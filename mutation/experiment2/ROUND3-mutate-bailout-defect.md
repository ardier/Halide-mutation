# Round 3: the canMutate()/mutate() asymmetry in HalideReplacement

`canMutate()` (`libirm-halide/lib/HalideReplacement.cpp`) only checks that the
callee's mangled name matches an operator mapping. `mutate()` additionally
requires the sibling to be resolvable and link-safe, and silently does
nothing on four distinct paths when it is not. Mull embeds and reports the
mutation point regardless (it goes into `.mull_mutants`, becomes selectable
by environment variable, and is counted as a mutant) -- so a mutation that
was never applied produces an emitted `.stmt` that is byte-identical to
baseline, which is exactly this pipeline's test for "equivalent". A
never-applied mutant and a genuinely equivalent one are different claims,
and until now they were indistinguishable from the outside.

## Instrumentation

`libirm-halide@wip-q` (`fcb2b84`, pushed) adds a per-outcome counter and an
optional per-call log line to `mutate()`, gated by `IRM_HALIDE_MUTATE_STATS`
/ `IRM_HALIDE_MUTATE_LOG`. No control-flow in `canMutate()` or `mutate()`
changes -- every added statement is a call to `record()` placed immediately
before an existing `return`. `mull-ps@wip-q` bumps the `vendor/libirm`
submodule pin to the same commit; no other file changes.

## Measurement: which mutation points are actually applied

Ran stage 1 (instrumentation-compile only -- this is where `mutate()` runs
for every mutation point, since Mull bakes every mutant clone into the one
generator binary at this step; the env-var dispatch used later only selects
among clones that already exist) for the three IR-route arms
(arithmetic / schedule / relational-bitwise-compound, i.e. every arm that
goes through `HalideReplacement`) on 5 benchmarks: `blur` (control, all 30
arithmetic mutants known effective/killed), `bilateral_grid` (predicted
heavy case for the templated-operand skip), `harris` and `camera_pipe`
(large arithmetic arms), `unsharp`.

| app | arm | mutate() calls | applied | skipped | skip% |
|---|---|---:|---:|---:|---:|
| blur | arithmetic | 30 | 30 | 0 | 0.0% |
| blur | schedule | 21 | 21 | 0 | 0.0% |
| bilateral_grid | arithmetic | 198 | 165 | 33 | 16.7% |
| bilateral_grid | schedule | 37 | 37 | 0 | 0.0% |
| bilateral_grid | generated | 1 | 1 | 0 | 0.0% |
| harris | arithmetic | 236 | 188 | 48 | 20.3% |
| harris | schedule | 50 | 50 | 0 | 0.0% |
| camera_pipe | arithmetic | 507 | 497 | 10 | 2.0% |
| camera_pipe | schedule | 64 | 64 | 0 | 0.0% |
| camera_pipe | generated | 22 | 22 | 0 | 0.0% |
| unsharp | arithmetic | 147 | 123 | 24 | 16.3% |
| unsharp | schedule | 27 | 27 | 0 | 0.0% |
| unsharp | generated | 2 | 2 | 0 | 0.0% |
| **arithmetic subtotal** | | **1118** | **1003** | **115** | **10.3%** |
| **all IR-route arms** | | **1342** | **1227** | **115** | **8.6%** |

Every one of the 115 observed skips is `skip_sibling_absent_local` (bail-out
path 2: sibling absent and the callee is a locally-emitted `linkonce_odr`
template instantiation, e.g. `x * s_sigma` instantiating
`operator*<Var, GeneratorParam<int>>`). Zero skips of the other three kinds
(`skip_no_callee`, `skip_type_mismatch`, `skip_sibling_bodyless`) fired
anywhere in this sample. The defect is entirely confined to the arithmetic
arm -- schedule-directive and relational/bitwise operators are never
templated over a `GeneratorParam` operand the way `+ - * /` are, so path 2
essentially never applies to them. `blur` shows exactly 0 skips, confirming
it as a clean control.

## Cross-reference against the corpus resolution table

`resolution_table.py` (`mutation/experiment2/`) classifies a mutant as
`equivalent` when `stage2 == OK` and the emitted `.stmt` is byte-identical to
baseline (`effective != "1"`). Joining the diagnostic log against it
(`join_diag.py`), restricted to these 5 benchmarks' IR-route arms:

| app | arm | equiv (total) | genuinely equivalent | never-applied |
|---|---|---:|---:|---:|
| bilateral_grid | arithmetic | 1 | 0 | **1** |
| bilateral_grid | generated | 1 | 1 | 0 |
| bilateral_grid | schedule | 14 | 14 | 0 |
| blur | schedule | 17 | 17 | 0 |
| camera_pipe | schedule | 3 | 3 | 0 |
| harris | schedule | 34 | 34 | 0 |
| unsharp | arithmetic | 12 | 0 | **12** |
| unsharp | schedule | 11 | 11 | 0 |
| **TOTAL** | | **93** | **80** | **13** |

Every one of these 93 points was resolved (0 "no diagnostic found" -- exact,
not estimated, for this sample). All 13 contaminated mutants are on the
arithmetic arm, and every arithmetic-arm mutant that reached the equivalent
bucket in this sample was contaminated (13/13, 100%) -- zero genuine
arithmetic equivalents were observed. The other 80 "equivalent" mutants (all
schedule + the one relational one) are real: zero skips were ever recorded on
those arms, and they match the mechanism-level arguments already on record in
`EQUIVALENCE.md` (pure-integer pipelines, directives that don't touch a
reduction variable, etc.).

Most of the arithmetic arm's skipped points do **not** currently reach the
equivalent bucket at all -- they sit in `notRun` (stage 2/3 never reached
under the sweep's wall-clock budget, already ~60% of the raw arithmetic
population corpus-wide per the earlier full-sweep report). So today's
contamination of the *reported* equivalent count is smaller than "every skip
becomes a false equivalent" would suggest, but it is total (100%) within
whichever slice of the arithmetic arm *does* get evaluated, and it will grow
as budget/coverage increases unless fixed.

Corpus-wide (`resolution_table.py`, all 14 apps, all families): 224
equivalent of 850 evaluated. Of the 33 corpus-wide arithmetic-arm
equivalents, 13 (39%) are covered by this exact measurement and all 13 are
confirmed contaminated; the remaining 20 (in `bgu`, `c_backend`, `conv_layer`,
`depthwise_separable_conv`, `hist`, `iir_blur`, `lens_blur`, `max_filter`,
`nl_means`) were not measured in this pass. Given the 100% contamination rate
observed on every arithmetic-equivalent mutant sampled, and that the
triggering pattern (`GeneratorParam`-templated arithmetic) is a standard
Halide idiom used throughout the corpus, extrapolating the same rate to the
unmeasured remainder is the honest expectation, not a worst case -- but it is
an extrapolation from 13 exactly-measured points, not a corpus-wide
measurement, and should be reported as such.

## Fix validated: mirror the three link-safety checks into canMutate()

Architecture (from `mull-ps/lib/Driver.cpp` and
`MutantPreparationTasks.cpp`): `MutationsFinder::getMutationPoints` runs
`canMutate()` over every original function, over the whole module, and
completes entirely *before* any cloning, deletion, trampoline insertion, or
`mutate()` call happens. `CloneMutatedFunctionsTask` then clones one copy of
each *function under test* per mutation point it hosts, and
`DeleteOriginalFunctionsTask` drops the true original's body
(`dropAllReferences()`) once it has been cloned. Crucially, this only ever
touches the enclosing function containing an approved mutation point -- never
an arbitrary callee referenced from within it. The callee and its sibling
(the two functions `HalideReplacement::mutate()`'s checks are about) are
therefore backed by the same `llvm::Function*` objects, in the same module,
at both `canMutate()`-time and `mutate()`-time, for every case in this
corpus. Mirroring mutate()'s three checks into canMutate() (read-only --
never calling `getOrInsertFunction`, so canMutate() stays non-mutating) is
sound on this basis.

Validated empirically, not just argued (`libirm-halide@wip-q-canmutate-fix`,
`83e8028`, pushed -- kept off `wip-q` so the diagnostic-only measurement
above stays auditable on its own):

| app | old: mutate() calls | old: skipped | predicted new count | actual new count | new: applied | new: skipped |
|---|---:|---:|---:|---:|---:|---:|
| bilateral_grid | 198 | 33 | 165 | **165** | 165 | 0 |
| harris | 236 | 48 | 188 | **189** | 189 | 0 |
| camera_pipe | 507 | 10 | 497 | **497** | 497 | 0 |
| unsharp | 147 | 24 | 123 | **123** | 123 | 0 |

3 of 4 match the hand-computed prediction exactly; in all 4, every point the
fixed `canMutate()` now reports is successfully applied (0 skips remain).
harris is off by +1: one `(mutator, file, line, column)` key
(`Halide_mul_to_div` at a `Halide.h` line) appears in the fixed build's
applied set but is absent -- not skipped, simply never present -- from the
unfixed build's log entirely. Re-running the *unfixed* binary a second time
reproduces exactly 236 (confirmed deterministic), so this is not general
compiler run-to-run noise. Given `findMapping`/`directCallee` are unmodified,
byte-identical code in both binaries, the two builds must be seeing a
slightly different *set* of candidate instructions at that one site --
plausible given the location is inside `Halide.h` and multiple template
instantiations can share one debug source line, and cloning is per
mutation-point-host-function, so a change one level away in what gets
cloned/dropped could shift what's visible at that address. This is a real,
narrow, unresolved discrepancy (1 point / 236, 0.4%) worth checking before
treating the fix as exactly loss-free in all cases; it does not change the
core result (the fix eliminates the skip category, never removes an
otherwise-applicable point) but should not be swept under the rug either.

## Recommendation

Ship the `canMutate()` mirror. It is a small, well-understood change, backed
by both a from-the-source-code soundness argument and an empirical
before/after check across 4 benchmarks that shows it doing exactly what's
predicted in 3/4 cases and something 0.4%-off in the 4th (in the safe
direction observed -- one *extra* correctly-resolved point, not a lost one,
though the mechanism isn't fully root-caused). It removes the entire
`skip_sibling_absent_local` category at the source: an inapplicable point is
never recorded as a mutation point, never gets a `.mull_mutants` identifier,
and is never at risk of being scored `equivalent` for having done nothing.
The risk direction the task asked about -- canMutate() wrongly claiming a
point cannot be mutated when it actually could, silently losing a real
mutant -- was not observed anywhere in this measurement: every point that
disappeared under the fix was independently confirmed, via the diagnostic
log on the *unfixed* binary, to have been a skip already.

Recommend *not* silently re-running the full corpus and republishing new
headline numbers as part of this change. The 850-evaluated / 224-equivalent
figures (and the 793/212 figures the investigation started from, likely a
slightly earlier snapshot of the same fast-moving resolution accounting)
should be reported alongside this finding with the contamination called out
explicitly, and a corrected re-run done as a distinct, auditable step once
the fix lands -- exactly per the "don't silently change the reported
numbers" constraint.
