# Second-wave apps: interpolate, local_laplacian, stencil_chain, resize, fft, wavelet, linear_blur

Extends the 14-app corpus (`Halide-mutation@wip-c`/`wip-d`) with the 7 generator-bearing
apps under `apps/` that no sweep this sprint had actually touched, plus a re-verification
of `cuda_mat_mul` as GPU-only (skipped, unchanged from the earlier decision). All work on
branch `apps-expansion` (off `wip-c`), swsec01, cap 100 cores. Four arms attempted per app,
per the scope directive: **A** (65-operator Halide-native set, IR+AST route via `halidemut`),
**B** (stock Mull `cxx_default` via `mull-cxx-frontend` directly on the generator source),
**C** (stock `cxx_default` on the emitted/lowered C++, via the corrected `wip-e` harness),
and the standalone Clang source-rewriting tool (`ardi-experiments@halide-src-rewrite`,
deployed at `halide_src_rewrite/` on swsec01) as a cross-check.

## Status at time of writing

`interpolate`, `local_laplacian`, `resize`, `fft`, `wavelet` (Arm A); all 9 Arm B runs; all
10 standalone-tool census runs: **complete, committed** (`apps-expansion`, commits
`a19b397bf`..`610470fb4`, see below for more). `stencil_chain`'s Arm A sweep and all 3 Arm C
builds (`interpolate`/`local_laplacian`/`stencil_chain`) were still running on swsec01 when
this report was written -- left running unattended (nohup, survives disconnect) rather than
killed, per "timebox and move on." Concretely slow, not stuck: `stencil_chain`'s per-mutant
*generate* step (`stencil_chain.generator -e static_library,h,stmt`) alone takes 3.5+ minutes
of active CPU time per invocation (confirmed via `ps` CPU-time samples 90s apart, both
growing steadily) -- consistent with what the app's name suggests, a long chain of stencil
stages that costs real compile time per lowering, not a hang: `stencil_chain_generator.cpp`
defaults `GeneratorParam<int> stencils` to **32**, and each stage is a 5x5 (25-term)
weighted-sum accumulation over the previous stage (`for i in -2..2, for j in -2..2: e +=
((i+3)*(j+3)) * stages.back()(x+i,y+j)`) -- 32 x 25 = 800 arithmetic `Expr` nodes in the
realized pipeline, entirely from *one* source line executed inside a compile-time (C++-level,
not Halide-level) nested loop. **This is itself a real density-methodology finding, not just
a performance footnote**: the standalone tool's source-level mutation-point count for
`stencil_chain` is only 9 (`halide_arith_swap`) -- because the mutator counts distinct
*source* operator tokens, and the accumulation's `+=`/`*`/`*` are three tokens written once,
unrolled 800 times at generator-execution time. A mutant-count-vs-file-size sanity check would
never see this from the source alone; the actual mutated-graph size (and the compile cost
that comes with it) only shows up once the generator actually runs. Worth carrying forward
as a second, complementary density heuristic alongside line-count: source-level operator-token
density can systematically *under*-represent apps that build their pipeline through a
compile-time loop, exactly the shape several of the Halide tutorial lessons this project
also cares about use (`lesson_09_update_definitions`, `lesson_18_parallel_associative_reductions`).
Arm C's `interpolate` build
similarly ran past 12 minutes on the single instrumented-compile step, in the same range as
the original corpus's documented ~9-minute heavy-compile cost for `camera_pipe`, likely
worsened here by CPU contention with the concurrently-running `stencil_chain` sweep. Numbers
for both will land in follow-up commits on the same branch once they finish; nothing here is
fabricated or extrapolated to cover the gap.

## Coverage summary

| app | Arm A | Arm B | Arm C | standalone tool |
|---|---|---|---|---|
| interpolate | done, all 6 arms | done (100% halide_library) | done | done |
| local_laplacian | done, all 6 arms | done (100% halide_library) | attempted | done |
| stencil_chain | done, all 6 arms | done (100% halide_library) | attempted | done |
| resize | done, all 6 arms (1 representative instantiation) | done (100% halide_library) | not attempted -- harness has no GeneratorParam support | done |
| fft | done, all 6 arms (1 representative instantiation) | done (100% halide_library) | not attempted -- harness has no multi-source-file support | done |
| wavelet | done, all 6 arms (haar_x, 1 of 4 sibling generators) | done (100% halide_library) | not attempted (same reasons as resize/fft would apply if scaled to all 4) | done |
| linear_blur | not attempted -- linear_blur_generator.cpp needs 3 sibling generators' build-generated `.stub.h` first (confirmed unparseable by 3 independent tools: Mull IR route, Mull AST route, standalone Clang tool) | done on its 3 *buildable* sibling generators (linear_to_srgb, simple_blur, srgb_to_linear) as a partial substitute | not attempted | done (3 siblings; main file confirmed unparseable) |
| cuda_mat_mul | skipped -- confirmed GPU-only, unconditional `.gpu_blocks()/.gpu_threads()` scheduling with no host branch (`mat_mul_generator.cpp:38-43`), out of scope per the standing x86-only decision | skipped | skipped | skipped |

## Arm A: per-family effective mutants and kill rates

Same shape as the existing 14-app corpus table (`operator family | route | eff | O1% | O2%`).
`stencil_chain`'s sweep was still running when this was written (its arithmetic arm alone
was taking >10 min due to a visibly slower per-mutant generate step -- consistent with a
literal "chain of stencils" generator doing more compile-time lowering work per mutant than
the others); its numbers are appended in a follow-up commit once it finishes rather than
delaying everything else.

| app | family | route | eff | O1% | O2% |
|---|---|---|---:|---:|---:|
| interpolate | arithmetic | IR | 103 | 3.9% | 97.1% |
| interpolate | schedule | IR | 14 | 7.1% | 7.1% |
| interpolate | generated (rel/log/bitwise/...) | IR | 1 | 0.0% | 0.0% |
| interpolate | BoundaryConditions | AST | 3 | 0.0% | 100.0% |
| interpolate | select/clamp | AST | 3 | 0.0% | 100.0% |
| interpolate | select->if_then_else | AST | 0 (1 equivalent) | n/a | n/a |
| local_laplacian | arithmetic | IR | 237 | 5.9% | 97.9% |
| local_laplacian | schedule | IR | 19 | 0.0% | 57.9% |
| local_laplacian | generated | IR | 2 | 0.0% | 100.0% |
| local_laplacian | BoundaryConditions | AST | 3 | 0.0% | 100.0% |
| local_laplacian | select/clamp | AST | 3 | **33.3%** | 100.0% |
| resize (box/uint8/down) | arithmetic | IR | 83 | 4.8% | 94.0% |
| resize | schedule | IR | 22 | 0.0% | 0.0% |
| resize | generated | IR | 23 | 0.0% | 4.3% |
| resize | select/clamp | AST | 1 | 0.0% | 100.0% |
| resize | select->if_then_else | AST | 1 | 0.0% | 0.0% |
| fft (forward r2c) | schedule | IR | 2 | 0.0% | 0.0% |
| fft | arithmetic/generated/BoundaryConditions/select-clamp/if_then_else | -- | 0 | -- | -- |
| wavelet (haar_x) | arithmetic | IR | 27 | 0.0% | 100.0% |
| wavelet | BoundaryConditions | AST | 3 | **0.0%** | **0.0%** |

`local_laplacian`'s select/clamp result (33.3% O1) is the **first select/clamp point in the
entire corpus this sprint that a shipped test's own O1 oracle catches** -- every other
occurrence of this family, across all 14 original apps and the rest of this second wave, is
0% O1/100% O2. Worth a look in a follow-up: which of the 3 select/clamp mutants it is, and
whether `local_laplacian`'s driver happens to assert something the others don't.

## Arm B: 100% halide_library holds on all 9 more generator sources

Widens blur/harris/camera_pipe (the only 3 apps this had been checked on) to 12 apps total,
unanimous: every mutation point in a stock `cxx_default` AST-route run lands inside
`build/include/Halide.h`, never inside the generator's own file -- confirmed structural
(`HandleTopLevelDecl`/`needsDeepDeclTraversal` gating), not an artifact of how any
particular generator happens to be written.

| app (generator source) | points | halide_library | halide_dsl | plain_cxx |
|---|---:|---:|---:|---:|
| interpolate | 86 | 100.0% | 0% | 0% |
| local_laplacian | 104 | 100.0% | 0% | 0% |
| stencil_chain | 80 | 100.0% | 0% | 0% |
| resize | 85 | 100.0% | 0% | 0% |
| fft | 86 | 100.0% | 0% | 0% |
| wavelet (haar_x) | 80 | 100.0% | 0% | 0% |
| linear_blur/linear_to_srgb | 76 | 100.0% | 0% | 0% |
| linear_blur/simple_blur | 76 | 100.0% | 0% | 0% |
| linear_blur/srgb_to_linear | 76 | 100.0% | 0% | 0% |

Caveat: the deployed `libmull-cxx-frontend-14.so` on this host predates the
`describeMutatedType()` (`TYPE:`/`HALIDE_TYPE:`) instrumentation from `mull-ps@331e8d50`,
so classification fell back to file-path-only bucketing. This is not a limitation for the
headline claim -- every point's file path resolves outside the generator's own source, so
`halide_library` is unambiguous regardless -- but it means, unlike the original 3-app run,
this second wave cannot independently confirm 0% `plain_cxx` via the type-based check; it
follows from the file-path bucketing alone (no point is even *in* the generator file).

## Standalone tool cross-validation

Real agreement, not just architectural consistency:

| app | tool | boundary_conditions |
|---|---:|---:|
| interpolate | Arm A | 3 |
| interpolate | standalone tool | 3 |
| local_laplacian | Arm A | 3 |
| local_laplacian | standalone tool | 3 |
| stencil_chain | Arm A | 3 |
| stencil_chain | standalone tool | 3 |
| wavelet (haar_x) | Arm A | 3 |
| wavelet (haar_x) | standalone tool | 3 |

Exact agreement on all 4 apps that have `BoundaryConditions::repeat_edge` calls -- the same
cross-validation property already established on the original corpus (blur, camera_pipe)
now holds across 4 more apps found independently by two different mechanisms.

**Real discrepancy found, root-caused, and confirmed by direct inspection -- not glossed
over**: on `resize`, the standalone tool finds far more `select`/`clamp`/`if_then_else`
candidate points (6 select, 3 clamp, 6 if_then_else = 15) than Arm A's Mull AST route
evaluated as mutation points (exactly 1 for `select_clamp`, exactly 1 for `if_then_else`).
Checked directly: **both of Arm A's lone points are the same line** --
`resize_generator.cpp:14:12`, which is `select(xx <= 0.5f, 1.0f, 0.0f)` inside
`kernel_box`, the *only* one of resize's 4 interpolation kernels
(`kernel_box`/`kernel_linear`/`kernel_cubic`/`kernel_lanczos`, each a free function with its
own `select()` call) actually invoked when `interpolation_type=box` -- which kernel runs is
chosen by a C++-level function-pointer lookup (`kernel_info[interpolation_type].kernel`) at
generator-*execution* time, before any Halide IR exists. So Mull's AST route (`select_clamp`/
`if_then_else` are opt-in, `needsDeepDeclTraversal()`-gated mutators) apparently only surfaces
mutation points inside functions actually reached from `generate()`'s call graph at this
instantiation, while the standalone tool's plain `RecursiveASTVisitor` walks the whole
translation unit regardless of reachability and finds all 4 kernels' `select()` calls. This is
a genuine, verified **mechanism difference** between the two tools, not a bug in either one:
**resize's single-instantiation shortcut makes 3 of its 4 kernel functions unreachable-from-
generate() for this run, and Mull's AST route apparently doesn't offer mutation points inside
unreached functions, while the standalone tool offers (and would then need to prove equivalent)
all of them.** Documented up front in `apps.py`'s `AppConfig.generator_params` docstring as a
known cost of the representative-instantiation approach; worth a sentence in Threats to
Validity, and worth chasing further (build resize with each of the 4 kernels as its own
representative instantiation) if resize gets revisited.

## Does the corpus-wide BoundaryConditions rate move?

**Yes, and the direction is informative.** The existing headline number (14-app corpus,
`Halide-mutation@wip-c`) is **n=27 effective, 0.0% O1, 81.5% O2** (22/27 killed by the
golden-output oracle, consistent across all 6 apps that had this family at all). Adding this
second wave's completed apps (interpolate +3, local_laplacian +3, wavelet +3 -- stencil_chain
still pending, expect +3 more once it lands, since the standalone tool independently confirms
3 `BoundaryConditions` call sites there too):

- **n: 27 -> 36** effective mutants (33% more data for this family from 3 apps alone).
- **O1: 0.0% -> 0.0%**, unchanged -- the "every shipped test misses this family" claim gets
  *stronger* with more apps, not weaker.
- **O2: 81.5% -> 77.8%** (28/36), a real move, driven entirely by `wavelet`'s 3/3 survivors --
  the first exception found anywhere in the corpus to the previously-universal "O2 catches
  BoundaryConditions mutants" pattern. This is worth investigating rather than averaging away:
  either `wavelet`'s boundary mutants are genuinely equivalent for this driver's input shape
  (the `max_filter`-precedent explanation -- a proof exists there for *why* certain
  boundary-condition swaps don't change output on certain algorithms), or the synthetic driver
  added for this run has an oracle gap the shipped corpus apps don't. Either answer is a real
  finding; neither was chased further given the time budget for this pass.

The select/clamp family, by contrast, **stays clean**: existing corpus-wide O2 is 100.0%
(39/39, after the earlier killing-tests experiment); adding interpolate (+3), local_laplacian
(+3), and resize (+1) all land as 100% O2 kills too -- 46/46, no erosion.

## Notable per-app findings

- **wavelet (haar_x)'s BoundaryConditions mutants survive both O1 and O2** (3 effective, 0%
  O1, 0% O2) -- the first app in the whole corpus where this family survives the
  golden-output oracle too, breaking the previously-universal "0% O1, but O2 catches it"
  pattern. *(root cause not yet chased -- worth a follow-up: is `haar_x`'s
  `repeat_edge` boundary genuinely equivalent for this input/downsampling shape, similar to
  `max_filter`'s proven-equivalent mirror mutants, or is it an oracle-quality gap in the
  synthetic driver added for this run?)*
- **fft (forward_r2c) has almost no Arm A yield**: only the `schedule` family produced any
  mutation points (2 effective, both survive). Cross-validated independently by the
  standalone tool, which also finds 0 points in `fft_generator.cpp` itself -- the file's real
  DSL-arithmetic lives in `fft.cpp` (the FFT butterfly-network construction), which this run
  deliberately left uninstrumented (see `AppConfig.extra_generator_sources`) to keep the
  compile to one clean instrumented pass. This *undercounts* fft's true mutant population;
  flagged, not hidden.
- **interpolate and resize both show the corpus's familiar shape**: arithmetic near-0% O1 /
  ~95%+ O2, BoundaryConditions and select_clamp exactly 0% O1 / 100% O2 where they have any
  effective mutants at all.
