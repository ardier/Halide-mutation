# Arm C at full corpus scale — stock `cxx_default` on Halide's emitted C++

This directory's original scripts (`lower_only.py`, `mutate_only.py`,
`bucket_mutants.py`, `sweep_blur.sh`, `sweep_harris.sh`) ran on a 16-core/31GB
laptop under a 10-minute-per-benchmark budget. That budget completed 2 of 13
benchmarks, truncated 6 mid-sweep, and lost 3 more to compile timeout or the
OOM killer. `arm_c_swsec.py` + `run_all.sh` are the same mechanism re-run to
completion on a 128-core/251GB host, and `compare_arms.py` joins the result to
the completed Halide-native sweep to produce the count-and-kill-rate comparison
the thesis's Tables 5/6 frame.

## Mechanism (unchanged)

1. **Lower.** Run each app's generator with `-e c_source,c_header,stmt` to get
   `<func>.halide_generated.cpp` — the whole pipeline as standalone C++, which
   is what the thesis means by "the equivalent C++ program."
2. **Instrument.** Compile that `.cpp` through `mull-ir-frontend-14` with
   `mutators: [cxx_default]` — Mull's *stock* C++ operator group, with none of
   this fork's Halide-specific mutators enabled. One object file carries every
   mutant behind env-var dispatch.
3. **Link.** Link it into the app's own shipped driver (`test.cpp` /
   `filter.cpp` / `process.cpp`, unmodified) plus Halide's C runtime.
4. **Sweep.** Run the binary once per mutant id, recording exit code (O1) and,
   where the driver writes an output image, a byte-comparison against an
   unmutated baseline (O2).

There is no stage-2 in this arm: the emitted `.cpp` already *is* the lowered
pipeline, so there is no generator to re-run per mutant, and correspondingly no
`.stmt` to diff. Every mutation point is evaluated, and kill rates are reported
over all of them.

## What the bigger host changed

**No timebox.** `ARMC_BUDGET` (default 2700s) covers compile+link+baseline+sweep
per app, ~4.5x the old budget. Nothing needed it: the slowest app compiled in
under 25 minutes and the slowest sweep finished in under 5.

**Parallel sweep.** Mutant runs are independent processes over one shared
binary, so they go through a worker pool rather than a `for` loop.

**`HL_NUM_THREADS` pinned to 2, not 1.** The pool would oversubscribe the
machine if each mutant run also spawned 128 Halide worker threads, but pinning
to *one* thread is wrong, not merely conservative: the emitted
`halide_do_par_for` collapses to a single task and mutations in the
task-splitting arithmetic stop being observable. Measured on blur, whose driver
aborts on a wrong result — five mutants that are killed at every thread count
from 2 through 32 survive at 1, and a sixth segfaults *only* at 1. From 2
upward every verdict is identical, so 2 is the cheapest faithful setting.

**`<app>_auto_schedule` is a shim onto the mutated pipeline.** This one is a
correctness fix, not a scaling change. Every `filter.cpp`/`process.cpp` in this
corpus does:

```c++
benchmark([&]() { app(input, output); });                 // manual schedule
benchmark([&]() { app_auto_schedule(input, output); });   // auto schedule
convert_and_save_image(output, argv[2]);                  // <- second result
```

Both calls write the *same* buffer and the image saved is the second one. The
earlier run satisfied `app_auto_schedule` with a separately generated, native,
**unmutated** library — so every trace of the mutation was overwritten before
the image was written, and O2 could only ever restate O1. That is exactly the
"O1 and O2 identical on every single mutant" anomaly the earlier harris run
flagged, and it applied to nine of the eleven runnable benchmarks, not just
harris. In arm A both variants come from one mutated generator, so both see the
mutation. Defining `app_auto_schedule` as a forwarding shim onto the mutated
`app` restores that property here without editing any shipped driver.

## Benchmarks that arm C structurally cannot run

`camera_pipe` and `bgu` do not compile as plain C++ at all. Re-verified here
with a bare `clang++ -std=c++17 -fsyntax-only` on the emitted file — no Mull,
no plugin, no mutation. `camera_pipe`'s `.prefetch()` lowers to a `void`
`__builtin_prefetch` result assigned to a `uint16_t`; `bgu`'s
`fast_inverse_f32` returns a `float8` assigned to a scalar `float`. This is a
property of Halide's C backend, and it means 2 of 13 benchmarks are outside
this arm's reach for reasons that have nothing to do with mutation testing.

## Region split (whole file vs. generator-specific)

Halide's C backend emits no `#line` markers, so provenance is recovered
structurally: the last top-level `}  // namespace` before the first
`HALIDE_FUNCTION_ATTRS` marker closes the SIMD-emulation preamble, and it lands
on line 3446 in all 13 emitted files. Everything up to there is boilerplate
(includes, embedded runtime declarations, `CppVector`/`NativeVector`
templates); from there to the `_argv` wrapper is generator-specific; the rest is
argv/metadata wrapper. `bucket_mutants.py` implements the split and every result
CSV carries a `region` column, so each benchmark can be read whole-file or
generator-specific-only.

## Toolchain (swsec01, no root)

Same old stack as the rest of this arm's work — LLVM 14, Halide 16, Mull built
from this fork — with three host-specific fixes:

- Ubuntu ships `/usr/lib/llvm-14/lib/cmake/clang` but not the `libclang*.a`
  files it references, so upstream `ClangTargets.cmake` hard-errors. Halide
  only needs the `clang` *executable* target (to compile runtime bitcode), so a
  four-line stub `ClangConfig.cmake` is enough for it. Mull genuinely links
  `clangTooling`, so for Mull the real static libraries were unpacked from
  `libclang-14-dev` into a merged user prefix.
- The newest `g++` here is 11, which reads `HalideReplacement({{a, b}})` as
  ambiguous between the `ReplacementMapping` constructor and the implicit
  copy/move ones. Fixed upstream in `libirm-halide` by naming the type in the
  braced initializer; no behaviour change.
- Halide's `build/` lives in tmpfs (`/dev/shm`) and does not survive a reboot.

## Usage

```sh
./run_all.sh                       # lower -> instrument -> sweep -> verify
python3 compare_arms.py --out ../../results-arm-c/COMPARISON.txt
```
