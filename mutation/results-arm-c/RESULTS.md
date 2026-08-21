# Halide-native vs. emitted-C++ mutation — full-corpus result

The comparison the thesis's Tables 5/6 frame: for the same benchmark logic, how
many mutants does a Halide-native operator set produce against Mull's stock C++
operators applied to the *equivalent C++ program* Halide itself emits, and how
many of each does the benchmark's own test suite kill.

- **Arm A** (Halide-native, 65 operators, IR + AST routes) — from the completed
  sweep on `Halide-mutation@wip-c`, `mutation/results-full-sweep/`. Not re-run.
- **Arm C** (emitted C++, stock `cxx_default`) — this directory, run to
  completion on swsec01.

Full tables: `COMPARISON.txt` (regenerate with
`python3 ../lowered-cpp/cxx_default_arm/compare_arms.py`). Per-mutant data:
`<app>-cxx_default.csv`. Per-app run metadata: `<app>-sweep.json`. The two
benchmarks with no arm-C data, and `camera_pipe`'s unblocking: `BLOCKED.md`.

## Update (2026-08-21): `camera_pipe` unblocked, 11 of 13 now comparable

`camera_pipe` was excluded below as one of two "Halide C backend emits invalid
C++" benchmarks. It no longer is: the specific bug (`.prefetch()` lowering to
a `void` result assigned to `uint16_t`) is fixed upstream in Halide v21, and
the same one-line transformation v21's C backend applies automatically was
reproduced mechanically on this arm's own (older) toolchain — add-only, no
existing expression touched, verified compile-clean before/after with a bare
`clang++ -fsyntax-only`. Full detail and the exact diff: `BLOCKED.md`.

Full sweep, same mechanism as the other 10: **1,163 mutants, 100% swept, O1
19.3% (224), O2 81.5% (948)** — `camera_pipe-cxx_default.csv` /
`camera_pipe-sweep.json`. The numbers in the rest of this document (coverage,
headline mutant count, headline kill rate, like-for-like arithmetic, cost
table) were written before this and describe the 10-benchmark corpus; they are
left as originally reported rather than silently edited. `COMPARISON.txt` is
regenerated and reflects all 11 comparable benchmarks — read it, not the
prose below, for current totals.

`bgu`, the other C-backend-invalid benchmark, has its compile error fixed the
same way but still produces no arm-C data, for an unrelated, separately
diagnosed reason (Mull's own instrumentation does not complete in practical
time on its emitted file). `BLOCKED.md` has the full writeup, including why
this is a different failure mode from `lens_blur`'s.

## Coverage (as of the original 10-benchmark run; see update above for `camera_pipe`)

10 of the 13 Table-4 benchmarks have arm-C data; 9 of those are complete sweeps
of every mutation point, `nl_means` is 1250 of 2128 in shuffled order. Before
this run the corpus stood at 2 complete, 6 truncated mid-sweep, 5 with nothing.

| | before (16-core / 31 GB, 10 min per benchmark) | now (128-core / 251 GB) |
|---|---|---|
| complete | 2 | 9 |
| partial | 6 (3–173 mutants each) | 1 (`nl_means`, 59%) |
| no data | 5 | 3 |
| mutants with a verdict | 1,231 | 8,746 |

## Headline: mutant count

**The emitted C++ yields 7.7 C++ mutants for every Halide-native mutation
point, and 21.1 for every Halide-native mutant that is actually effective**
(9,624 vs. 1,242 points; 9,624 vs. 457 effective) across the 10 comparable
benchmarks. Per benchmark the ratio spans 2.1x (`harris`) to 48.4x
(`nl_means`), and it tracks how much a generator's source expressions get
duplicated by lowering rather than how large the generator is.

Restricting arm C to the generator-specific region of the emitted file — past
the 3,446-line boilerplate prefix that is byte-identical across all 13
independently lowered files — removes only 12% of the mutants (8,486 of 9,624
in the swept subset) and barely moves the kill rate (18.3% vs. 20.4% O1,
45.9% vs. 42.4% O2). Boilerplate dilution is a real effect but a small one.
The multiplier is lowering itself: vectorisation, tiling and boundary clamping
turn one source expression into many emitted sites, most of which are not
individually output-determining.

## Headline: kill rate

Over the 10 comparable benchmarks:

| arm | denominator | n | O1 kill | O2 kill |
|---|---|---:|---:|---:|
| A, Halide-native | effective mutants | 457 | 9.6% | 71.3% |
| A, Halide-native | all evaluated (incl. equivalent) | 698 | 13.3% | 53.7% |
| C, emitted C++ | all mutants | 8,746 | 18.3% | 45.7% |

The two arms do not filter equivalent mutants the same way, which is why both
arm-A denominators are shown. Halide compiles in stages, so a mutated
generator's emitted `.stmt` can be diffed against the baseline's before any
test runs: 192 of arm A's points here are provably equivalent at `target=host`
and 49 more are killed by the Halide compiler itself. The emitted `.cpp`
already *is* the lowered pipeline, so arm C has no such stage and no way to
recognise an equivalent mutant short of running it. The free equivalence
pre-filter is a property of multi-stage DSL compilation, not of the operator
set.

Read on the like-for-like denominator (effective mutants for A, all mutants
for C), a Halide-native mutant is **2.5x more likely to be killed by a
golden-output oracle** than an emitted-C++ one, from a population 21x smaller.

## Like-for-like: arithmetic only

The closest match to the thesis's own framing — arm A's 12 pairwise `+ - * /`
swaps on `Halide::Expr` against the 4 arithmetic swaps stock `cxx_default`
actually ships, on the same source expressions:

| | points | effective | O1 | O2 |
|---|---:|---:|---:|---:|
| A, Halide-native arithmetic | 838 | 290 | 14.1% | **97.2%** |
| C, emitted-C++ arithmetic | 5,074 | — | 12.3% | 49.9% |

6.1 emitted-C++ arithmetic mutants per Halide-native arithmetic point, 17.5 per
effective one. The gap in O2 is the sharpest single number in this table:
essentially every effective Halide-native arithmetic mutant changes the output,
while half of their emitted-C++ counterparts do not.

## Correction to the earlier arm-C O2 numbers

The earlier run reported O1 and O2 as identical on every single mutant of every
benchmark and flagged it as an unexplained anomaly. It was an instrumentation
defect, not a property of the subjects. Every `filter.cpp`/`process.cpp` in
this corpus runs the manual variant, then `<app>_auto_schedule(...)` into the
*same* output buffer, then saves that buffer; the earlier harness satisfied the
auto-scheduled symbol with a separately generated **unmutated** library, so the
mutation was overwritten before the image was written. Arm A gets both variants
from one mutated generator. Defining `<app>_auto_schedule` as a forwarding shim
onto the mutated pipeline restores that, without touching any shipped driver.
`harris` moves from 17.8%/17.8% to 17.8%/68.4%. Nine of the ten benchmarks were
affected; only `blur` (which has no auto-scheduled variant) was not.

## Reproduction check

`blur` was swept on a different machine, a different Halide build and a
different Mull build than the earlier complete run, and reproduced it to the
mutant: 347 mutation points, 123 killed (35.4%). Mutant counts also match the
earlier truncated runs wherever those got far enough to report a total
(`harris` 591, `unsharp` 828, `hist` 647, `iir_blur` 471, `max_filter` 605,
`conv_layer` 837, `bilateral_grid` 1348). Pre-filter candidate counts match too
(`blur` 2,310 -> 347; `harris` 4,031 -> 591).

## Cost

| benchmark | emitted lines | candidates | mutants | instrument (s) | sweep (s) |
|---|---:|---:|---:|---:|---:|
| blur | 4,261 | 2,310 | 347 | 19 | 7 |
| harris | 4,656 | 4,031 | 591 | 61 | 18 |
| max_filter | 4,673 | 3,836 | 605 | 83 | 2,185 |
| iir_blur | 4,800 | 3,184 | 471 | 27 | 96 |
| hist | 5,009 | 4,533 | 647 | 71 | 136 |
| unsharp | 5,104 | 5,675 | 828 | 174 | 67 |
| conv_layer | 5,557 | 4,804 | 837 | 79 | 2,341 |
| bilateral_grid | 5,973 | 9,858 | 1,348 | 332 | 1,759 |
| depthwise_separable_conv | 7,064 | 11,606 | 1,822 | 735 | 53 |
| nl_means | 7,554 | — | 2,128 | 2,689 | 4,074 (59% swept) |
| camera_pipe (unblocked) | 6,337 | 1,163 | 1,163 | 413 | 118 |
| lens_blur | 14,805 | — | — | >7,470, stopped | — |
| bgu (compile fixed, instrument not tractable) | 16,164 | — | — | >5,220, stopped (2 attempts) | — |

Instrumentation cost is superlinear in emitted-file size and is what stops
`lens_blur`: 2 h 04 min at 84 GB RSS with no output, on a machine with 8x the
RAM of the one that OOM-killed the same step. Sweep cost is dominated by how
long the benchmark's own driver runs, not by mutant count — `depthwise_separable_conv`
sweeps 1,822 mutants in 53 s while `max_filter` needs 36 minutes for 605.
`camera_pipe`, once unblocked, instruments in line with its size (bigger than
`nl_means`'s line count would suggest, but far denser in resolved candidates
per line than the RAM-heavy tail below it). `bgu` is a distinct, worse case
than `lens_blur` on the same axis: its emitted file is the largest in the
corpus (16,164 lines), and unlike `lens_blur` it does not fail on memory (RSS
plateaus safely near 73 GB) — it fails on wall-clock time in Mull's
single-threaded mutation-application phase. See `BLOCKED.md` for the full
two-attempt account (a stack-overflow crash on the first attempt, fixed by
raising the process stack limit; a ~87-minute run that still had not finished
on the second).
