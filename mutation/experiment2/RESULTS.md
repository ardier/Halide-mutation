# Experiment 2 analog: killing O2-surviving mutants with targeted tests

Status: **partial, and stopped deliberately** (machine migration to a larger
host). Everything recorded below is measured, verified before/after, and
reproducible with the commands in this file. Nothing here is projected.

## What this experiment is

The thesis's Experiment 2 picked a handful of benchmarks that still had
unresolved (surviving) mutants, wrote tests aimed at those mutants, and reported
the resulting change in test completeness. This is the same experiment run
against this sprint's much larger operator set, and specifically against the
mutants that survive the *strongest* oracle currently in the pipeline (O2, the
golden-output oracle) rather than only the apps' own shipped tests.

Starting point: the full 65-operator Arm A sweep
(`mutation/results-full-sweep/FINAL-REPORT.txt`) — 542 effective mutants,
371 killed by O2 (68.5%).

## Target selection

Restricting to the three novel AST-route families, the O2 survivors are a
population of exactly **20**:

| family | effective | O2-killed | O2 survivors | where |
|---|---:|---:|---:|---|
| BoundaryConditions | 27 | 22 | **5** | lens_blur 63:36 (x3), max_filter 17:22 (x2) |
| select/clamp | 39 | 34 | **5** | c_backend 17:26, 17:70; depthwise_separable_conv 38:26, 39:26, 41:13 |
| select->if_then_else | 10 | 0 | **10** | camera_pipe (x7), depthwise_separable_conv, lens_blur, max_filter |

Covered so far: **the entire select/clamp survivor population (5/5)** plus one
of the ten `select->if_then_else` survivors.

## Result 1 — select/clamp survivors: 5 of 5 killed

Two new test drivers were written, one per benchmark. Both are *additional*
files; neither app's shipped driver was modified.

| new test | app | targets | before | after |
|---|---|---|---|---|
| `apps/c_backend/mutation_test.cpp` | c_backend | `Halide_clamp_swap_bounds` 17:26, 17:70 | SURVIVED, SURVIVED | **KILLED, KILLED** |
| `apps/depthwise_separable_conv/mutation_test.cpp` | depthwise_separable_conv | `Halide_clamp_swap_bounds` 38:26, 39:26; `Halide_select_swap_branches` 41:13 | SURVIVED x3 | **KILLED x3** |

Both are killed under **O1** (the test exits non-zero), which is a strictly
stronger result than an O2 byte difference: the test *fails*, it does not merely
produce different output.

Corpus-wide effect on this family: select/clamp goes from **34/39 (87.2%)** to
**39/39 (100.0%)** O2-killed. Corpus-wide across all 65 operators:
**371/542 (68.5%) -> 376/542 (69.4%)**.

### Why they survived, and what the tests do about it

Both benchmarks are ones where O2 is not independent of O1 (neither driver saves
an output artifact, so the "golden output" degenerates to the driver's own
normalised stdout — this is the caveat already recorded in the sweep's
FINAL-REPORT).

* **c_backend** ships the corpus's only differential oracle: it runs the
  pipeline through the LLVM backend and through the C backend and compares the
  two. Both copies come out of the *same* mutated generator invocation, so a
  generator mutation moves both sides identically and cancels; and even on a
  mismatch `run.cpp` only prints, still exiting 0. Net effect: no oracle at all
  with respect to generator mutation.

  The new test recomputes the pipeline in plain C++ with Halide's own integer
  promotion rules and requires exact agreement. It runs two input regimes,
  because a measurement made while writing it turned out to matter: under the
  app's own full-range `uint16` input, only **6,550 of 267,759 output pixels
  (2.4%)** are above the pipeline's `max(0, ...)` floor — the other 97.6% are
  insensitive to almost any mutation. A second small-valued regime puts every
  pixel above the floor. It then probes the two `clamp()` calls directly: a
  swapped bound collapses `min(max(v, hi), lo)` to the constant `lo`, severing
  the output's dependence on the input pixel it is supposed to read.

* **depthwise_separable_conv** ships a pure benchmark driver: `rand()`-filled
  buffers, two timing runs, `printf("Success!")`, and no inspection of a single
  output value. The full sweep scored 37 effective mutants on it and killed
  **zero**.

  The new test recomputes the depthwise-separable convolution in C++ and demands
  *exact* float equality. Exactness is affordable because the test feeds small
  integer-valued floats, so every product and partial sum stays an exactly
  representable integer and the result is independent of the order Halide
  accumulates in — no tolerance has to be invented. It keeps the app's channel
  counts (the manual schedule tiles the output channel dimension by a full
  vector width) and shrinks only the spatial extent and batch, which is what
  makes the reference cheap: the whole test runs in 3 ms. It then probes the
  hand-rolled boundary condition three ways — interior pixels must depend on the
  input pixel beneath them (kills both clamp swaps), and the padding must be
  genuine zero padding, checked against a manually zero-padded widened run
  (kills the select branch swap).

## Result 2 — whole-benchmark test completeness, c_backend

The same test was run against **every** effective mutant of c_backend, all six
operator families, before and after:

| operator family | effective | O2-killed before | after |
|---|---:|---:|---:|
| arithmetic | 27 | 4 (14.8%) | 24 (88.9%) |
| schedule directive | 2 | 0 (0.0%) | 0 (0.0%) |
| relational/logical/bitwise | 1 | 0 (0.0%) | 1 (100%) |
| select/clamp | 2 | 0 (0.0%) | 2 (100%) |
| **all** | **32** | **4 (12.5%)** | **27 (84.4%)** |

**c_backend's test completeness rises from 12.5% to 84.4%** from adding one
test file. The "before" column reproduces the full sweep's own c_backend numbers
exactly (32 effective, 12.5%), which is the harness's self-check.

The two schedule-directive mutants remain alive, consistent with the sweep's
corpus-wide finding that correctness oracles are structurally near-blind to that
family; they are an O3 (performance oracle) target, not a test-writing target.

## Result 3 — an honest negative: `select -> if_then_else` is not killed

`Halide_select_to_if_then_else` at
`depthwise_separable_conv_generator.cpp:41:13` is an *effective* mutant (the
emitted `.stmt` provably differs from baseline) and it **survives the new exact
reference test as well**, exactly as it survived the shipped driver.

That is the expected outcome and it is worth reporting as a result rather than a
gap. `select(c, a, b)` evaluates both branches; `if_then_else(c, a, b)`
evaluates only the taken one. In this corpus neither branch of any mutated site
has an observable effect when it is not taken — Halide's integer division is
already safe (checked earlier in the sprint with a dedicated test case), and
Halide's own bounds machinery deliberately reconstructs an equivalent `Select`
when reasoning about `Call::if_then_else` (`src/Bounds.cpp:1279`), so even the
inferred input region does not move. The mutation changes the generated code,
not the values it computes.

So this family's survival is not a weak-test-suite finding: it is a
**correctness-oracle-blind** finding, structurally the same shape as the
schedule-directive family (2.3% O1 / 10.2% O2 in the sweep). Both change *how*
the pipeline computes, not *what*. The place to catch them is an O3 performance
oracle — which is precisely where the sprint's camera_pipe observation points
(the strongest of these mutants turns a 32-wide vectorised `select` into a
32-wide `if_then_else`, putting per-lane laziness and SIMD in direct tension).

## Not yet done (queued for the larger host)

* **BoundaryConditions survivors (5).** `max_filter` 17:22 x2 and `lens_blur`
  63:36 x3. For `max_filter` there is a proof sketch that
  `repeat_edge`/`mirror_image`/`mirror_interior` are genuinely *equivalent* for
  this pipeline (below); `lens_blur` is untested and is one of the RAM-heavy
  benchmarks, so it is a natural first job on the bigger machine.
* **`select -> if_then_else` on camera_pipe (7 of the 10).** camera_pipe is
  memory-heavy locally.
* **depthwise_separable_conv whole-benchmark before/after.** Started and stopped
  mid-run; `results/dwsc-full.csv` holds the durable partial (select/clamp and
  if_then_else complete, `generated` arm's before-variant only). This is the
  benchmark the sweep scored at 0/37, so completing it is the largest single
  completeness delta available.

### max_filter BoundaryConditions: why a better test cannot kill these

`max_filter` computes, at each output pixel, the maximum over a disc-shaped
window centred on that pixel (`filter_height(dx)` gives the window's vertical
half-extent, monotonically decreasing in `|dx|`). For a window that is symmetric
about its centre and shrinks with distance:

* `repeat_edge` maps an out-of-domain sample `p` to `clamp(p)`, and
  `|clamp(p) - centre| <= |p - centre|` in each dimension.
* `mirror_image`/`mirror_interior` map `p` to its reflection, and the reflection
  is likewise no further from the centre than `p` is, in each dimension.

So under all three, every sampled coordinate lands inside `window ∩ domain`, and
every point of `window ∩ domain` is sampled (it maps to itself). The three
boundary conditions therefore see the **same set of values**, and a maximum over
a set is insensitive to how that set was reached. `repeat_image` is the
exception — wrap-around pulls in pixels from the opposite edge, genuinely
outside the window — and it is indeed the one the sweep's O2 oracle already
killed (`repeat_edge_to_repeat_image` KILLED, `..._to_mirror_image` and
`..._to_mirror_interior` SURVIVED).

This predicts the split cleanly and generalises: BoundaryConditions mutants are
equivalent for order-statistic (max/min) filters over symmetric windows, and not
for linear filters — which is why the same operator dies on `unsharp`,
`nl_means`, `bgu` and `bilateral_grid`. Worth writing up as a
characterisation of when this operator family yields equivalent mutants, rather
than counting the two `max_filter` survivors as an oracle gap.

## Reproducing

```sh
cd mutation/experiment2

# just the targeted survivors
python3 run_targets.py --app c_backend --arms select_clamp \
    --csv results/c_backend.csv
python3 run_targets.py --app depthwise_separable_conv \
    --arms select_clamp,if_then_else --csv results/dwsc-ast.csv

# whole-benchmark before/after
python3 run_targets.py --app c_backend \
    --arms boundary_conditions,if_then_else,select_clamp,generated,schedule,arithmetic \
    --csv results/c_backend-full.csv
```

`run_targets.py` reuses `halidemut`'s own stage1/stage2/stage3 pipeline, so the
mutant identity mechanism (Mull's env-var runtime dispatch), the
equivalent-at-target handling and the two oracles are exactly the ones the full
sweep used. The only thing it adds is running each mutant twice — once against
the app's shipped driver, once against the new test — so every "killed" claim is
a before/after pair measured on the same mutant with the same toolchain.

All paths are flags with defaults (`--halide-root`, `--halide-build`,
`--mull-output`, `--llvm-prefix`, `--workdir`), so the script moves to another
host unchanged.
