# cxx_default on emitted C++ (arm C, revived for blur + harris)

Applies Mull's stock `cxx_default` C++ mutator group (increment, arithmetic,
comparison, boundary, calls -- **not** `halide_mutator`/
`halide_boundary_conditions`/`halide_special_calls`; the exclusion is explicit
and intentional, see `mull-ps/lib/Mutators/MutatorsFactory.cpp:242-256`) to
the emitted `.halide_generated.cpp` files in `mutation/lowered-cpp/{blur,
harris}/`, links each mutant against the app's own real test/demo driver, and
runs it. This is the thesis's original Table 5/6 "emitted-C++ control" arm,
scoped to the two benchmarks that already have completed Halide-native runs
this sprint. Results: `mutation/results/{blur,harris}-cxx_default.csv` and
`mutation/results/summary-cxx_default.txt`.

## Stage 1 -- compile with cxx_default via the IR frontend

Same `-fpass-plugin=` pattern as `mull-ps/docs/linux-build.md` Stage 1, just
pointed at the emitted `.cpp` instead of a generator TU, and
`mutators: [cxx_default]` instead of `[halide_mutator]`. The emitted file
needs no special include path (no `Halide.h`, just stdlib headers), so the
compile is simpler than a generator TU:

```sh
cat > mull.yml <<'EOF'
mutators:
  - cxx_default
timeout: 99999999
quiet: false
includePaths:
  - .*
EOF

MULL_CONFIG=$PWD/mull.yml /usr/lib/llvm-14/bin/clang++ \
  -std=c++17 -O1 -g -grecord-command-line \
  -fpass-plugin=<mull-ps>/output/mull-ir-frontend-14 \
  -c $PWD/mutation/lowered-cpp/blur/halide_blur.halide_generated.cpp -o blur_cxx.o
```

List mutants -- the id prefix is `cxx_*` (not `Halide_*`), everything else
about the env-var key format is identical to the Halide-native route:

```sh
strings blur_cxx.o | grep -E '^cxx_[a-z_]+:/[^:]+:[0-9]+:[0-9]+$' | sort -u
```

Result: **347** mutants for blur (from 2,310 raw candidates before Mull's own
junk/file-path/debug-info filters), **591** for harris (from 4,031 raw). No
Halide-specific junk-detector exemption is needed here (unlike the generator
TU route) -- every mutation point lands inside the single `.cpp` file being
compiled, not inside a templated header, so the file-path filter passes them
through directly.

## Bucketing by region (whole-file vs. generator-specific-only view)

```sh
python3 bucket_mutants.py blur   blur_cxx_mutants.txt   > blur_regions.csv
python3 bucket_mutants.py harris harris_cxx_mutants.txt > harris_regions.csv
```

Reuses the boilerplate/generator-specific boundary from `../survey.py` (see
that script's docstring and `../README.md` for the methodology -- no `#line`
provenance exists in Halide's C-backend output, so the boundary comes from the
longest common byte-identical prefix across independently-lowered generators).
`bucket_mutants.py` is self-contained per app (doesn't need a second file to
diff against): it finds the same boundary via the last `}  // namespace` that
closes before the first `HALIDE_FUNCTION_ATTRS` marker, which lands on the
same line (3446, 1-based) in all 5 already-lowered apps.

## Stage 3 -- link and sweep

No Stage 2 (DSL re-compilation) in this arm -- the emitted `.cpp` already *is*
the lowered pipeline, there's no generator to re-run per mutant. Straight to
build + run, exactly like `linux-build.md`'s own Stage 3, except the object
being linked is the mutated *emitted* C++ instead of a native `.a`:

```sh
# runtime.a: Halide's C runtime, target=host, generator-agnostic -- the
# emitted .cpp only `extern "C"`-declares halide_error_*/halide_malloc/etc.,
# it doesn't define them.
<any>.generator -r runtime -o native/ target=host

# blur: test.cpp expects a function named exactly halide_blur(...), which is
# what -f halide_blur already produced when the file was lowered.
clang++ -std=c++17 -O2 -Wall -I mutation/lowered-cpp/blur -I build/include -I tools \
  apps/blur/test.cpp blur_cxx.o native/runtime.a -o blur_test_instrumented -lpthread -ldl

# harris: filter.cpp additionally links a second (native, unmutated)
# harris_auto_schedule.a purely so it links -- it isn't part of this arm and
# isn't exercised by either test kind.
<harris>.generator -g harris -f harris_auto_schedule -o native/ target=host-no_runtime
clang++ -std=c++17 -O2 -Wall -I/usr/include/libpng16 \
  -I mutation/lowered-cpp/harris -I native -I build/include -I tools \
  apps/harris/filter.cpp harris_cxx.o native/harris_auto_schedule.a native/runtime.a \
  -o harris_filter_instrumented -lpng16 -ljpeg -lpthread -ldl
```

One instrumented binary per app, all mutants behind env-var dispatch --
`sweep_blur.sh` / `sweep_harris.sh` re-run the same binary once per mutant id
(`env "<key>=1" ./binary`), no rebuild between mutants:

```sh
BIN=./blur_test_instrumented MUTLIST=blur_cxx_mutants.txt OUT=blur-cxx_default.csv \
  ./sweep_blur.sh

BIN=./harris_filter_instrumented MUTLIST=harris_cxx_mutants.txt \
  IMG_IN=apps/images/rgba.png BASELINE=harris_baseline.png OUT=harris-cxx_default.csv \
  ./sweep_harris.sh
```

## Test kinds

- **blur** -- test 1 (demo program) only. `apps/blur/test.cpp` has its own internal
  `abort()`-on-mismatch assertion (comparing against two independent
  reference C++ implementations in the same file); no separate golden-image
  artifact exists for this app (matches `mutation/halidemut/apps.py`'s
  `output_artifact=None` for blur).
- **harris** -- test 1 (exit code) and test 2 (golden: byte-compare of
  `out.png` against a snapshot from one unmutated run). `apps/harris/filter.cpp` has no
  internal assertion, same weak-test shape the Halide-native schedule arm
  already documented for this app.

## Results summary

See `mutation/results/summary-cxx_default.txt` for the full writeup and the
comparison against the existing Halide-native numbers (30/30 arithmetic kill
for blur, the schedule-directive run for harris). Reproduce the printed
tables with `python3 arm_c_summary.py` from this directory (reads the
committed CSVs directly, no rebuild needed).

**Headline number**: blur gives the cleanest like-for-like read (same
conceptual arithmetic-swap mutation, same underlying box-filter algorithm) --
**100% kill at the Halide-DSL level vs. ~32-35% kill at the emitted-C++
level**, even restricted to the matching 4 operator kinds and to the
generator-specific code region. Restricting to the generator-specific region
barely moves the number (35.4% -> 35.6%), so line-count boilerplate dilution
(the concern `../README.md` raised) is a small part of the story -- the
bigger effect is that Halide's lowering (vectorization, tiling,
boundary-clamp branches) turns each single source-level arithmetic expression
into many duplicated emitted-code instances, most of which are not
individually output-determining for a given test run. See the summary file
for the full argument and its implication for weighting/deduping future
arm-C mutant counts by lowering-induced site multiplicity.
