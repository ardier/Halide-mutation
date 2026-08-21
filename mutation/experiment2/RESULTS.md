# Experiment 2 analog: killing O2-surviving mutants with targeted tests

Every number below is a measured before/after pair on the same mutant with the
same toolchain. Nothing is projected.

## What this experiment is

The thesis's Experiment 2 picked benchmarks that still had unresolved
(surviving) mutants, wrote tests aimed at those mutants, and reported the change
in test completeness. This is that experiment run against this sprint's
65-operator set, and specifically against the mutants that survive the
*strongest* oracle in the pipeline (O2, the golden-output oracle) rather than
only the apps' own shipped tests.

Starting point: the full Arm A sweep
(`mutation/results-full-sweep/FINAL-REPORT.txt`) — 542 effective mutants, 371
killed by O2 (68.5%).

## The target population, and its complete disposition

Restricting to the three novel AST-route families, the O2 survivors are a
population of exactly **20**. All 20 are now accounted for:

| outcome | n | which |
|---|---:|---|
| **killed by a new test** | **8** | c_backend clamp ×2; depthwise_separable_conv clamp ×2 + select-swap ×1; lens_blur BoundaryConditions ×3 |
| **proven equivalent** | **2** | max_filter `repeat_edge→mirror_image`, `→mirror_interior` |
| **correctness-oracle-blind** | **10** | every `select→if_then_else` mutant |

Five new test drivers were written, one per benchmark. Every one is an
*additional* file; no app's shipped driver was modified.

| new test | benchmark | outcome |
|---|---|---|
| `apps/c_backend/mutation_test.cpp` | c_backend | 2 kills |
| `apps/depthwise_separable_conv/mutation_test.cpp` | depthwise_separable_conv | 3 kills |
| `apps/lens_blur/mutation_test.cpp` | lens_blur | 3 kills |
| `apps/max_filter/mutation_test.cpp` | max_filter | 0 kills — establishes equivalence, with a positive control |
| `apps/camera_pipe/mutation_test.cpp` | camera_pipe | 0 kills — establishes oracle-blindness |

## Corpus-level effect

| operator family | effective | O2-killed before | after |
|---|---:|---:|---:|
| BoundaryConditions | 27 | 22 (81.5%) | **25 (92.6%)** |
| select/clamp | 39 | 34 (87.2%) | **39 (100.0%)** |
| select→if_then_else | 10 | 0 (0.0%) | 0 (0.0%) |
| **whole corpus, all 65 operators** | **542** | **371 (68.5%)** | **379 (69.9%)** |

The two BoundaryConditions mutants that remain are the two proven equivalent, so
against the non-equivalent population that family is at **25/25 (100%)**.

## Per-benchmark test completeness

| benchmark | families measured | effective | before | after |
|---|---|---:|---:|---:|
| c_backend | all 6 | 32 | 4 (12.5%) | **27 (84.4%)** |
| depthwise_separable_conv | all 6 | 88 | 15 (17.0%) | **50 (56.8%)** |
| — same, excluding schedule + if_then_else | 4 | 53 | 15 (28.3%) | **50 (94.3%)** |
| lens_blur | 3 AST | 13 | 9 (69.2%) | **12 (92.3%)** |
| camera_pipe | 2 AST | 20 | 13 (65.0%) | 13 (65.0%) |
| max_filter | BC + if_then_else | 4 | 1 (25.0%) | 1 (25.0%) |

`c_backend`'s "before" column reproduces the full sweep's own c_backend row
exactly (32 effective, 4 killed), which is the harness's self-check.

`depthwise_separable_conv`'s does not, and the reason is worth stating: the
sweep recorded 37 effective mutants for it and killed 0, because its arithmetic
and relational arms (50 mutants) were never reached inside the wall-clock budget
and were correctly excluded as `NOT_RUN`. This run evaluates the complete
population, so its "before" figure is 15/88 rather than 0/37 — new data, not a
contradiction. The residual 38 after the new test are 34 schedule-directive
mutants plus 1 `if_then_else` plus 3 arithmetic; excluding the two families no
correctness oracle can reach gives the 28.3% → 94.3% line.

`camera_pipe` and `max_filter` show no change in the count, but the new tests do
strengthen three kills from "the output bytes differ" to "the test fails" (O2 →
O1): camera_pipe's `clamp_swap_bounds` at 246:22 and `select_swap_branches` at
332:16, and max_filter's `repeat_edge→repeat_image`.

## Why each family survived, and what the tests did about it

### select/clamp — 5 of 5 killed, both under O1

Both benchmarks are ones where O2 is not independent of O1 (neither driver saves
an output artifact, so the golden output degenerates to the driver's own
normalised stdout — the caveat already recorded in the sweep's FINAL-REPORT).
Both new tests are self-checking, so they are killed by exit status; the
degeneracy does not weaken the "after" figure.

* **c_backend** ships the corpus's only differential oracle: it runs the
  pipeline through the LLVM backend and through the C backend and compares. Both
  copies come out of the *same* mutated generator invocation, so a generator
  mutation moves both sides identically and cancels; and on a mismatch `run.cpp`
  only prints, still exiting 0. Net effect: no oracle at all with respect to
  generator mutation.

  The new test recomputes the pipeline in plain C++ with Halide's own integer
  promotion rules and requires exact agreement, over two input regimes. The
  second regime exists because of a measurement made while writing it: under the
  app's own full-range `uint16` input only **6,550 of 267,759 output pixels
  (2.4%)** rise above the pipeline's `max(0, ...)` floor; the rest are
  insensitive to almost any mutation. It then probes both `clamp()` calls
  directly — a swapped bound collapses `min(max(v, hi), lo)` to the constant
  `lo`, severing the output's dependence on the pixel it should read.

* **depthwise_separable_conv** ships a pure benchmark driver: `rand()`-filled
  buffers, two timing runs, `printf("Success!")`, no inspection of any output
  value.

  The new test recomputes the convolution in C++ and demands *exact* float
  equality. Exactness is affordable because it feeds small integer-valued
  floats, so every product and partial sum stays exactly representable and the
  result is independent of Halide's accumulation order — no tolerance has to be
  invented, which is how oracles quietly stop being oracles. It keeps the app's
  channel counts (the manual schedule tiles the output channel dimension by a
  full vector width) and shrinks only the spatial extent and batch: the whole
  test runs in 3 ms. Three probes follow — interior pixels must depend on the
  input pixel beneath them (kills both clamp swaps), and the padding must be
  genuine zero padding, checked against a manually zero-padded widened run
  (kills the select branch swap).

### BoundaryConditions — 3 killed, 2 proven equivalent

* **lens_blur.** The gap was in the *input*, not the assertions. `process.cpp`
  does `load_image(argv[1])` twice — into both `left_im` and `right_im`. The
  stereo pair has zero disparity, so the cost volume that lens_blur's front half
  builds is degenerate, the push/pull pyramid that inpaints depth has nothing to
  inpaint, and the boundary condition applied to each pyramid level (generator
  line 63) never reaches the output. That is exactly why the three mutants at
  line 63 survive while the two on the input images (lines 29–30) die.

  The new driver synthesises a real stereo pair — two depths, foreground blocks
  placed hard against the left, right and top borders so the depth discontinuity
  reaches the boundary of every pyramid level — and dumps raw floats rather than
  PNG, so 8-bit quantisation cannot hide a small difference. **6/9 → 9/9.**
  Output verified deterministic over 5 runs and at `HL_NUM_THREADS` 1 and 16, so
  the golden-output kills are not scheduling noise.

* **max_filter.** These two are genuine equivalent mutants, and the test
  demonstrates it rather than asserting it. A max over a window that is
  symmetric about its centre and shrinks with distance cannot distinguish
  edge-clamping from reflection: both map an out-of-domain sample to a
  coordinate no further from the centre in either axis, so it still lies inside
  the window and inside the image, and every in-window in-image coordinate is
  already sampled directly. The two range over the same *set* of values, and a
  maximum does not care how the set was reached. Wrap-around is the exception —
  it pulls in pixels from the opposite edge, genuinely outside the window.

  The new test recomputes the radius-26 max filter exactly and checks every
  pixel of the 30-pixel frame — the entire region any boundary condition can
  reach — on an input whose extremes sit in the outermost rows and columns and
  which is asymmetric in both axes. The positive control is the point: that same
  test strengthens `repeat_edge→repeat_image` from an output diff to an
  assertion failure, and still cannot touch the two mirror mutants. The
  reference matched the pipeline on all 83,712 checked pixels first try,
  including the top-border case where the vertical log-max's reduction domain
  runs out, so the transcription is exact rather than approximately right.

  This also predicts the family's behaviour elsewhere: BoundaryConditions
  mutants are equivalent for order-statistic (max/min) filters over symmetric
  windows and not for linear filters — which is why the same operator dies on
  `unsharp`, `nl_means`, `bgu` and `bilateral_grid`.

### select→if_then_else — 0 of 10, and that is the result

`select(c, a, b)` evaluates both arms; `if_then_else(c, a, b)` evaluates only
the taken one. All ten mutants are *effective* (their emitted `.stmt` provably
differs from baseline) and all ten survive.

`apps/camera_pipe/mutation_test.cpp` was written to give that difference every
chance, since camera_pipe holds 7 of the 10:

1. **Branch coverage and ties** — a synthetic Bayer frame with pure horizontal
   edges, pure vertical edges, diagonals, flat fields (where the demosaic's
   `ghd < gvd` comparison is an exact tie, the input class where eager and lazy
   evaluation are most likely to diverge) and noise salted with the tone curve's
   exact guard values, so every mutated condition is driven true, false and
   borderline.
2. **Full-precision comparison** — raw `uint8` output dumped for the oracle
   rather than routed through PNG, every pixel compared.
3. **A bounds query** — the mechanism with a real chance of showing something.
   Halide's `boxes_touched` handles `Call::if_then_else` by building an actual
   `IfThenElse` statement (`src/Bounds.cpp:2255`) instead of the plain interval
   union it uses for `Select` (`src/Bounds.cpp:1279`), so if laziness narrowed
   the region the pipeline demands of its input, a bounds query is where it
   would appear. The inferred region is folded into the same artifact the oracle
   hashes, putting it on equal footing with a pixel change.

All three hold, and all seven mutants still survive — the query returns
`input [10, 246) × [6, 178)` byte-identically for baseline and mutants, which
settles empirically that Halide's `IfThenElse` handling merges both branches
when the condition is data-dependent. The same outcome holds at the other three
sites (`depthwise_separable_conv` 41:13 against the exact reference test,
`lens_blur` 142:13, `max_filter` 50:32).

So this family's survival is not a weak-test-suite finding: it is a
**correctness-oracle-blind** finding, structurally the same shape as the
schedule-directive family (2.3% O1 / 10.2% O2 in the sweep, and 0/34 here on
depthwise_separable_conv under both drivers). Both change *how* the pipeline
computes, not *what*. The place to catch them is an O3 performance oracle —
which is where the sprint's earlier camera_pipe observation already pointed, the
strongest of these mutants turning a 32-wide vectorised `select` into a 32-wide
`if_then_else`.

## Where O1 and O2 are not independent

Flagged wherever it applies, since it bounds what these numbers mean:

* `c_backend` and `depthwise_separable_conv` save no output artifact, so O2
  falls back to normalised stdout and restates O1. Both new tests are
  self-checking, so their "after" figures are honest O1 results; the "before"
  figures are correspondingly conservative.
* `max_filter`'s new test likewise reports through exit status only.
* `lens_blur` and `camera_pipe` have genuinely independent O2 on both variants
  (the shipped drivers save PNGs; the new drivers save raw dumps).

## Reproducing

```sh
cd mutation/experiment2

python3 run_targets.py --app c_backend \
    --arms boundary_conditions,if_then_else,select_clamp,generated,schedule,arithmetic \
    --csv results/c_backend-full.csv
python3 run_targets.py --app depthwise_separable_conv \
    --arms boundary_conditions,if_then_else,select_clamp,generated,schedule,arithmetic \
    --csv results/dwsc-full.csv
python3 run_targets.py --app lens_blur --arms boundary_conditions,if_then_else,select_clamp \
    --test-args '[]' --test-output-artifact out.bin --csv results/lens_blur.csv
python3 run_targets.py --app camera_pipe --arms if_then_else,select_clamp \
    --test-args '[]' --test-output-artifact out.bin --csv results/camera_pipe.csv
python3 run_targets.py --app max_filter --arms boundary_conditions,if_then_else \
    --test-args '[]' --test-output-artifact '' --csv results/max_filter.csv
```

`run_targets.py` reuses `halidemut`'s own stage1/stage2/stage3 pipeline, so the
mutant identity mechanism (Mull's env-var runtime dispatch), the
equivalent-at-target handling and the two oracles are exactly the ones the full
sweep used. The only thing it adds is running each mutant twice — once against
the app's shipped driver, once against the new test.

All paths are flags with defaults (`--halide-root`, `--halide-build`,
`--mull-output`, `--llvm-prefix`, `--workdir`), so this moves to another host
unchanged.
