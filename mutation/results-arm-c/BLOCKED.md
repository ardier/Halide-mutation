# Benchmarks the emitted-C++ arm could not measure, and why

Of the 13 Table-4 benchmarks, 11 now have arm-C data. `camera_pipe`, previously
blocked, is unblocked (2026-08-21) and fully swept below. `bgu` and `lens_blur`
still produce no arm-C data, each for a specific, reproducible reason that has
nothing to do with mutation testing.

## `camera_pipe` — UNBLOCKED (2026-08-21)

The C-backend bug is real on the toolchain this arm uses (Halide `release/16.x`
+ LLVM 14) but **already fixed upstream in Halide v21**: emitting the same
generator with the Halide v21 / LLVM 20 stack (`upgrade-latest/halide-latest`)
produces C++ that compiles with **0 errors**, no workaround needed. Diffing the
two backends' output at the failure site shows exactly what changed:

```
# old backend (release/16.x) -- does not compile
uint16_t _91 = __builtin_prefetch(((uint16_t *)_input + _90), /*rw*/0, /*locality*/0);

# v21 backend -- compiles
uint16_t _91 = (__builtin_prefetch(((uint16_t *)_input + _90), /*rw*/0, /*locality*/0), 0);
```

`.prefetch()` lowers to a `void`-returning `__builtin_prefetch`, and the old
backend assigns that void result directly to a `uint16_t` temporary (which
exists only so the next line can pass it to `halide_maybe_unused` and suppress
an unused-variable warning — it is otherwise dead). v21 wraps the call in a
comma expression that discards the void result and yields `0` instead.

Since this arm intentionally stays on the old toolchain (matching the other 10
benchmarks' methodology exactly, so results pool), the fix applied here
reproduces v21's own transformation verbatim on the old backend's output,
rather than moving the whole benchmark to a different Halide/LLVM version.
Implemented as `_fix_camera_pipe_prefetch()` in `arm_c_swsec.py`, applied
automatically at the end of `lower()` — regenerating this benchmark's emitted
C++ from scratch reproduces the fix, nothing was hand-patched into a file that
isn't tracked. The prefetch still executes for its side effect (a pure cache
hint, no effect on correctness either way); the fix changes no expression's
value, so it cannot change the pipeline's output. Verified with a bare
`clang++ -std=c++17 -O1 -fsyntax-only` (no Mull) before (1 error) and after (0
errors).

Full arm-C sweep, same mechanism and methodology as the other 10 benchmarks
(stock `cxx_default`, `<app>_auto_schedule` shim, `HL_NUM_THREADS=2`):
**1,163 mutants, 100% swept, O1 19.3% (224), O2 81.5% (948)** — see
`camera_pipe-cxx_default.csv` / `camera_pipe-sweep.json`, and `COMPARISON.txt`
for how it folds into the corpus tables (11 comparable benchmarks now, not 10).

## `bgu` — compile error fixed; instrumentation still not tractable

**The C-backend compile error itself is fixed**, same approach as
`camera_pipe`: mechanical, add-only patch to the emitted C++, applied
automatically by `_fix_bgu_fast_inverse()` in `arm_c_swsec.py` at `lower()`
time. Verified with a bare `clang++ -fsyntax-only`: 32 errors (uncapped; the
default error-limit cuts this off at 19-20, which is what the original report
and thesis both saw) before the fix, 0 after — on both the old stack (LLVM 14)
and Halide v21 (the bug is **not** upstream-fixed there; v21 emits the
identical wrong single forward-declaration).

Root cause, more precise than the earlier "float8 -> float" one-liner: `bgu`'s
Cholesky solve calls Halide's `fast_inverse` intrinsic both at its native
vector width (`float8`, from the schedule's `vectorize(x, 8)`) and, after the
C backend's own per-lane scalarization of that vectorized stage, at scalar
width — but the backend forward-declares each extern callee exactly once,
keyed only by function name (`src/CodeGen_C.cpp`,
`ExternCallPrototypes::visit(Call*)`), not by `(name, signature)`. Only the
`float8` overload ever gets declared, so the 32 scalarized call sites resolve
against it via an implicit `float`->`float8` splat and return the wrong type.
The scalar entry point already exists and is already linked into every arm-C
binary: Halide's own runtime (`src/runtime/x86.ll`) defines a `weak_odr float
@fast_inverse_f32(float)`, computed via the same SSE `rcp.ss` approximate-
reciprocal instruction the vector form uses per lane. The fix adds only the
missing C++ prototype for that pre-existing symbol (`extern "C"` linkage can't
carry two overloads of the same name, so it uses ordinary C++ linkage plus an
`asm("fast_inverse_f32")` label to bind to the identical external symbol) — no
new code, no behaviour change.

**What is still blocked, and why it's a different problem from the compile
error:** getting the now-valid C++ through Mull's actual instrumentation
mechanism. Two distinct failures, both on the corrected file:

1. With the default 8 MB stack, Mull's own IR-mutation LLVM pass
   (`mull::mutateBitcode`, inside `mull-ir-frontend-14`) **segfaults**
   partway through, deep in a recursive traversal
   (`clang: error: ... exit code 139`, stack dump ending in
   `mull::mutateBitcode(llvm::Module&)`). Raising the process stack limit
   (`ulimit -s unlimited`) avoids this crash.
2. With that crash avoided, the compile runs a very long single-threaded
   phase — RSS plateaus safely around **73 GB** (confirmed CPU-active the
   whole time via `ps`/`/proc/<pid>/stat`, not hung or swapping to death) —
   and did not complete within **~87 minutes** before being stopped. This is
   not a memory failure like `lens_blur`'s (below): the machine had well over
   100 GB free the entire time. It is a wall-clock cost wall in Mull's
   single-threaded mutation-application pipeline on a translation unit this
   large and this arithmetic-dense (the Cholesky solve is a 4x4 matrix
   inversion unrolled into ~28+ update definitions, each further duplicated by
   vectorization) — the same structural limitation already documented for
   `lens_blur`, and independently reproduced this same session by a separate
   sweep's `interpolate`/`local_laplacian`/`stencil_chain` attempts (each
   timed out at 1200 s under the same mechanism).

So `bgu` moves from "the emitted C++ is invalid" to "the emitted C++ is valid,
but the tool that would mutate it does not finish in practical time" — a
narrower, more specific gap than before, and one that (like `lens_blur`)
points at Mull's single-instrumented-binary architecture rather than at
Halide's C backend. No arm-C data for `bgu`; `arm_c_swsec.py` keeps it out of
`SWEEPABLE` accordingly (`backend_broken` renamed in spirit but the app is
still excluded from the sweep list — see the `BLOCKED` entry in
`compare_arms.py`).

## `lens_blur` — the single-instrumented-binary approach does not scale to it

Skipped by explicit decision, not left running. The instrumentation compile

```
clang++ -std=c++17 -O1 -g -grecord-command-line \
        -fpass-plugin=mull-ir-frontend-14 -c lens_blur.halide_generated.cpp
```

was killed at **2 h 04 min** of continuous ~100% CPU at **84 GB RSS**, with no
output produced. It is not hung — it burns real CPU the whole time — it is
simply superlinear in the size of the emitted file, and `lens_blur`'s is the
second largest in the corpus (14,805 lines / 608 KB, 75.5% generator-specific).
For scale, the same step takes 19 s on `blur`, 61 s on `harris`, 332 s on
`bilateral_grid`, 735 s on `depthwise_separable_conv`, and 2,689 s on
`nl_means` — `lens_blur` had already passed three times the next-worst case
when it was stopped. `bgu` (above) is the same failure mode by a different
route: its compile error is fixed, but its emitted file (16,164 lines) is
larger still, and it hits the same wall.

The interesting part is that the bigger machine did not rescue either one. On
the 16-core/31 GB laptop `lens_blur` was killed by the OOM killer; on a
128-core/251 GB server with the memory ceiling effectively removed, both it and
`bgu` still failed — `lens_blur` on memory, `bgu` on time. The cost is
structural to Mull's mechanism — one object file has to hold every mutant of a
large translation unit behind runtime dispatch, and each candidate is
re-parsed by the junk detector — not to the hardware. The contrast worth
recording is that the standalone source-rewriting mutator
(`ardi-experiments@halide-src-rewrite`), which emits N separately-compiled
mutated sources instead of one instrumented binary, handles `lens_blur` in 81
seconds; the same architectural fix would be the natural next step for `bgu`
too, if it is ever revisited.
