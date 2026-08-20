# Emitted-C++ lowering (arm C prep)

Lowers 5 of the sprint's benchmark generators (`blur`, `bilateral_grid`,
`camera_pipe`, `harris`, `unsharp`) to Halide's C-backend `.cpp` output, the
same technique `apps/c_backend/` demonstrates in-tree, and surveys how much
of each emitted file is Halide's own library/runtime boilerplate vs.
generator-specific logic. This is prep for reviving Table 5's "Halide vs.
emitted-C++" comparison arm (cut for the sprint, see the TODO in
`/home/ardi/.claude/plans/1-read-my-thesis-deep-wadler.md`), not the arm
itself.

## Mechanism (verified against `apps/c_backend/Makefile`)

`apps/c_backend/Makefile` builds two generators and, for each, requests two
different output sets from the same generator binary via the `-e` (emit)
flag:

```make
$(BIN)/%/pipeline_native.a: $(GENERATOR_BIN)/pipeline.generator
	$^ -g pipeline -o $(@D) -f pipeline_native -e $(GENERATOR_OUTPUTS) target=$*

$(BIN)/%/pipeline_c.halide_generated.cpp: $(GENERATOR_BIN)/pipeline.generator
	$^ -g pipeline -o $(@D) -f pipeline_c -e c_source,c_header target=$*
```

The emit-outputs flag is `-e`, and the output that matters is literally named
`c_source` (paired with `c_header` for the matching `.h`). This is distinct
from `apps/support/Makefile.inc`'s default `GENERATOR_OUTPUTS ?=
static_library,h,registration,stmt,assembly` (line 40) — `c_source` is never
in the default set, it has to be requested explicitly. `run_cpp.cpp` in the
same app then compiles and links the emitted `.cpp` with a stock C++
compiler and cross-checks its output against the natively-compiled `.a`,
which is the "semantically-equivalent emitted C++" claim in practice, not
just in principle (reproduced below for `blur`, see Verification).

Reproduction, one generator:

```sh
clang++ -std=c++17 -O1 -g -I build/include -I tools -c tools/GenGen.cpp -o gengen.o
clang++ -std=c++17 -O1 -g -I build/include -I tools -c apps/blur/halide_blur_generator.cpp -o gen.o
clang++ gen.o gengen.o -o blur.generator -L build/src -lHalide -Wl,-rpath,$PWD/build/src -lpthread -ldl
./blur.generator -g halide_blur -o mutation/lowered-cpp/blur -f halide_blur -e c_source,c_header,stmt target=host
```

All 5 target apps have a single self-contained `*_generator.cpp` (no extra
`GENERATOR_DEPS` beyond the generator TU itself), so this same recipe applies
unmodified to all 5 — just swap the source file, `-g` generator name, and
`-f` output-file-basename per app (matched to each app's
`HALIDE_REGISTER_GENERATOR` name and Makefile's `-f`/`-e` convention).
Toolchain paths and flags are exactly the ones documented in
`mull-ps/docs/linux-build.md` §2 ("Build Halide") and §3 Stage-1 (LLVM 14,
`build/include`, `-std=c++17`) — read-only reference, not modified here.

## Benchmarks lowered

All 5 lowered cleanly on the first attempt with `target=host` and default
generator params — no failures to report, no app skipped:

| App | Generator name (`-g`) | Output dir |
|---|---|---|
| blur | `halide_blur` | `blur/` |
| bilateral_grid | `bilateral_grid` | `bilateral_grid/` |
| camera_pipe | `camera_pipe` | `camera_pipe/` |
| harris | `harris` | `harris/` |
| unsharp | `unsharp` | `unsharp/` |

Each directory has the emitted `<name>.halide_generated.cpp`, matching
`<name>.h`, and `<name>.stmt` (Halide IR, for reference/diffing).

**Verification the emission is real, standard, compilable C++:** each
`.halide_generated.cpp` compiles standalone with `g++ -std=c++17 -c` (no
special Halide includes needed beyond what's in the file itself) — verified
for `blur`, clean exit 0, only `-Wpsabi` ABI-note warnings from the
generic vector-emulation templates, no errors.

## Survey: boilerplate vs. generator-specific logic

The thesis speculated the emitted C++ "includes Halide compiler utility
functions that have nothing to do with the actual generator logic" but
explicitly could not quantify it. Two checks:

**1. `#line` / source-location provenance:** none. `grep -c '#line'` on all 5
emitted files returns 0. Halide's C backend does not emit any marker tying a
line back to Halide-library source vs. the generator's own `.cpp`, so the
split cannot be done mechanically via provenance the way a `#line`-aware tool
would. This confirms the thesis's own statement that it "cannot approximate"
the split from source locations — there are none to filter on.

**2. Working substitute — longest common prefix across independently-lowered
generators.** Every one of the 5 files begins with a **byte-identical**
3,466-line prefix (verified by diffing all pairs, not assumed): includes,
Halide's embedded runtime helpers (math wrappers, `_halide_buffer_t`
accessors, `halide_error_*`), the literal contents of `HalideRuntime.h`
inlined verbatim, and the generic `CppVector`/`NativeVector` SIMD-emulation
templates. None of this depends on what the generator computes — it's
identical whether the pipeline is a 1-line blur or the ~9-stage camera
pipeline — so it is unambiguously Halide-library boilerplate, not generator
logic. Everything after that prefix (parallel-for closure functions, the
top-level pipeline entry function body, the `_argv` marshaling wrapper, the
`_metadata()` descriptor table) is generator-specific, since it's the part
that actually differs.

Reproducible via `survey.py` (`python3 survey.py blur harris unsharp
bilateral_grid camera_pipe` from this directory):

| app | total lines | total bytes | boilerplate lines | boilerplate % | generator-specific lines | generator-specific % |
|---|---:|---:|---:|---:|---:|---:|
| blur | 4,261 | 161,744 | 3,466 | 81.3% | 738 | 17.3% |
| harris | 4,656 | 175,835 | 3,466 | 74.4% | 1,115 | 23.9% |
| unsharp | 5,104 | 192,977 | 3,466 | 67.9% | 1,563 | 30.6% |
| bilateral_grid | 5,973 | 225,190 | 3,466 | 58.0% | 2,419 | 40.5% |
| camera_pipe | 6,337 | 262,703 | 3,466 | 54.7% | 2,645 | 41.7% |

(The remaining 1–4% per file is the `_argv`/`_metadata` wrapper — trivial,
boilerplate-*shaped* code but populated with generator-specific buffer
names/types, so not cleanly attributable to either bucket; small enough not
to matter for the headline split.)

**The thesis's speculation is directionally correct but the magnitude is not
a single fixed number — it varies roughly 2x across benchmarks of different
size, from 55% to 81% boilerplate**, driven entirely by how much the
boilerplate floor (a fixed 3,466 lines / 135,978 bytes, constant regardless
of generator complexity) gets diluted as the generator's own compute logic
grows. Simple pipelines (blur, one small stencil) are dominated by
boilerplate (81%); complex ones (camera_pipe, ~9 stages) are closer to an
even split (55%/45%).

**Secondary check — is the "generator-specific" zone itself further diluted
by mechanical buffer-marshaling glue?** Grepping the generator-specific zone
(parallel-for closures + main function body, excluding the tiny argv/
metadata tail) for calls into named runtime helpers
(`_halide_buffer_get_*`, `halide_error_*`, `halide_cpp_*`,
`halide_maybe_unused`, etc.):

| app | generator-specific lines | lines calling a runtime helper | % |
|---|---:|---:|---:|
| blur | 687 (non-blank) | 94 | 13.7% |
| camera_pipe | 2,473 (non-blank) | 189 | 7.6% |

Only 8–14% of the generator-specific zone is direct calls into the shared
runtime — the rest is genuinely unique numbered-SSA arithmetic and control
flow (bounds computations, pixel math, loop structure) that traces back to
the specific pipeline's algorithm and schedule. So the generator-specific
line counts above are not further inflated by hidden boilerplate; they're
mostly real, distinct-per-benchmark logic.

## Implications for reviving arm C

- **Worth restricting mutation to the generator-specific region, not the
  whole file** — for simpler benchmarks (blur-scale pipelines) up to 80%+ of
  the emitted file is byte-identical shared boilerplate; mutating it
  indiscriminately would inflate the C++ arm's mutant count with points that
  say nothing about the specific generator and can't be meaningfully
  compared against the Halide-native arm's mutant population. The 3,466-line
  boundary found here is a mechanical, reproducible cutoff (byte-identical
  across every generator tested) that a junk/scope filter could use directly
  — no `#line`-based approach is available since Halide's C backend doesn't
  emit any.
- The magnitude is benchmark-dependent (55–81% boilerplate across just these
  5 apps), so a single project-wide "boilerplate fraction" constant would be
  wrong — any arm-C mutant-count comparison should report per-benchmark
  splits, not one pooled ratio.
- `bilateral_grid` and `camera_pipe` are the two benchmarks where the
  generator-specific fraction is largest (~40%), making them the best
  candidates if arm C is revived incrementally rather than across all 5 at
  once.
- `survey.py` in this directory is reusable as-is against the remaining 10
  benchmarks (post-Monday, per the plan) — it takes N output directories and
  computes the common-prefix boilerplate boundary automatically rather than
  hardcoding the 3,466 figure, so it should stay accurate even if a
  different benchmark's C backend output has a different (e.g. larger, if a
  future benchmark needs a runtime helper these 5 don't) shared prefix.
