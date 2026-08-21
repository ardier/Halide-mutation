# Experiment 2, round 2: resolving the arithmetic, relational and schedule survivors

Round 1 (`RESULTS.md`) took the three DSL-native operator families to 100%
resolution. This round targets what was left, under two relaxed constraints:
more than one test per app is allowed, and *equivalent* counts as resolved.

Accounting is over **evaluated** mutants — killed, killed by the Halide compiler,
or shown equivalent — rather than kill rate over effective ones, so a mutant that
provably cannot be killed stops being counted as a failure.

Reproduce the table below with `python3 resolution_table.py [-v]`. It merges the
sweep and every targeted-test run, and lists each argued-equivalent mutant
explicitly so the count can be audited against the prose rather than inferred.

## The finding this round turns on

Every arithmetic survivor that a new test killed survived for the same reason,
and it is not the reason round 1 found. Round 1's gaps were *missing assertions*
(and, for `lens_blur`, a degenerate input). These are different: the assertions
were already there and already exact. The mutants survived because the test
fixed a **parameter** at a value where the mutation is the identity.

| app | mutated expression | value used by the app | why it hides the mutation |
|---|---|---|---|
| `depthwise_separable_conv` 48, 49 | `filter.dim(k).extent() / 2` → `- 2` | 3x3 filter | `3 / 2 == 3 - 2 == 1` |
| `depthwise_separable_conv` 59 | `d / channel_multiplier` → `d * ...` | multiplier 1 | `d / 1 == d * 1` |
| `iir_blur` 25 | `1 - alpha` → `1 * alpha` | driver passes `alpha = 0.5` | `1 - 0.5 == 0.5` |
| `c_backend` 17 | `extent() - 1` → `+ 1`, `/ 1`, `* 1` | 1432-wide input | upper clamp bound never attained |
| `lens_blur` 34 | `2 * z + 1` → `2 * z / 1` | even synthetic disparities | the `+1` match term never carries the answer |

These are not equivalent mutants. They are mutants that are equivalent **at the
one point in the parameter space the test suite ever visits** — a coverage gap in
the *inputs*, invisible to any amount of assertion strengthening. Two of the five
are a fixed-point coincidence in integer division (`3/2 == 3-2`, `d/1 == d*1`),
one is a coefficient coincidence (`1 - a == a` exactly at `a = 1/2`), and two are
unattained-bound coincidences.

Each was fixed by adding a second test that moves the parameter, changing nothing
else: a 5x5 filter with multiplier 2, `alpha = 0.25`, a narrower input, odd
disparities.

## Resolution by family

| family | evaluated | killed | by compiler | equivalent | unresolved | resolved | was unresolved |
|---|---:|---:|---:|---:|---:|---:|---:|
| Arithmetic | 464 | 429 | 0 | 35 | **0** | 100.0% | 32 |
| Schedule directive | 345 | 13 | 50 | 172 | **110** | 68.1% | 115 |
| Relational & bitwise | 30 | 27 | 1 | 2 | **0** | 100.0% | 4 |
| BoundaryConditions | 27 | 25 | 0 | 2 | **0** | 100.0% | 0 |
| select / clamp | 41 | 39 | 0 | 2 | **0** | 100.0% | 0 |
| select -> if_then_else | 13 | 0 | 0 | 13 | **0** | 100.0% | 0 |
| **corpus** | 920 | 533 | 51 | 226 | **110** | 88.0% | 151 |

Five of the six families are now fully resolved. Schedule directives are the only
family with anything left, and the remaining 110 are discussed below.

Evaluated counts grew from 793 to 920 because these runs reached mutants the
original sweep had recorded as `NOT_RUN` and correctly excluded from its rates —
notably `depthwise_separable_conv`'s arithmetic and relational arms and part of
`lens_blur`'s arithmetic arm.

## New tests

| file | app | targets |
|---|---|---|
| `apps/c_backend/mutation_test2.cpp` | c_backend | 3 arithmetic at 17:64 |
| `apps/depthwise_separable_conv/mutation_test2.cpp` | depthwise_separable_conv | 3 arithmetic at 48:59, 49:60, 59:29 |
| `apps/depthwise_separable_conv/mutation_test3.cpp` | depthwise_separable_conv | schedule family (float-order sensitivity) |
| `apps/conv_layer/mutation_test.cpp` | conv_layer | 3 arithmetic at 25:54, `max_to_min` at 27:28 |
| `apps/iir_blur/mutation_test.cpp` | iir_blur | `sub_to_mul` at 25:12 |
| `apps/lens_blur/mutation_test2.cpp` | lens_blur | `add_to_div` at 34:60 |

Two of these deserve a note.

`conv_layer/mutation_test.cpp` is the benchmark's first output check of any kind
— its shipped `process.cpp` fills buffers with `rand()`, benchmarks twice, prints
two timings and `Success!`. The reference is exact (small integer-valued floats,
so accumulation order cannot matter) and is evaluated at a fixed sample of output
points plus every corner, because a full reference over all 5.12M outputs would
be ~5.9 GFLOP of scalar C++ per run for no extra discriminating power.

`iir_blur/mutation_test.cpp` leads with a check that needs no reference and no
tolerance: a first-order low-pass of this form has unity DC gain, so a constant
input must come back out unchanged — and *exactly* so in floating point when
alpha is dyadic. Under the mutation the recurrence's fixed point becomes
`a*v/(1-a)`, which at `alpha = 0.25` is `v/3`. A full double-precision reference
follows as a second check, with a stated `1e-4` relative tolerance and an
explicit argument for why that is loose enough not to be flaky and tight enough
to still be an oracle.

## Verified kills

Each row is a before/after pair on the same mutant, same toolchain: the app's
shipped driver, then the new test.

| app | mutant | site | before | after |
|---|---|---|---|---|
| c_backend | `sub_to_add` | 17:64 | SURVIVED | **KILLED (O1)** |
| c_backend | `sub_to_div` | 17:64 | SURVIVED | **KILLED (O1)** |
| c_backend | `sub_to_mul` | 17:64 | SURVIVED | **KILLED (O1)** |
| depthwise_separable_conv | `div_to_sub` | 48:59 | SURVIVED | **KILLED (O1)** |
| depthwise_separable_conv | `div_to_sub` | 49:60 | SURVIVED | **KILLED (O1)** |
| depthwise_separable_conv | `div_to_mul` | 59:29 | SURVIVED | **KILLED (O1)** |
| iir_blur | `sub_to_mul` | 25:12 | SURVIVED | **KILLED (O1)** |
| lens_blur | `add_to_div` | 34:60 | SURVIVED | **KILLED (O2)** |
| conv_layer | `mul_to_add` | 25:54 | SURVIVED | **KILLED (O1)** |
| conv_layer | `mul_to_sub` | 25:54 | SURVIVED | **KILLED (O1)** |
| conv_layer | `mul_to_div` | 25:54 | SURVIVED | **KILLED (O1)** |
| conv_layer | `max_to_min` (relational) | 27:28 | SURVIVED | **KILLED (O1)** |

`c_backend`'s whole arithmetic arm goes to **27/27** with the second test.

`lens_blur`'s arithmetic arm was cut short deliberately, not by a budget: it
holds 234 mutation points, only one of which was a target, and each costs a full
generator run of the corpus's most memory-hungry benchmark. It was stopped at
275 of 468 evaluations once the target's before/after pair was in hand, to free
the machine for `conv_layer`, which held four of the six remaining targets.
Everything it did evaluate is real and recorded; the rest is marked unevaluated
rather than counted, the same convention the original sweep used for its
timeboxed cells.

The `lens_blur` kill is an O2 (golden-output) kill rather than an assertion
failure, because that test's oracle is a raw float dump of a synthetic stereo
scene rather than a reference computation — lens_blur has no cheap reference. The
others all *fail*, which is the stronger form.


## Equivalence

`EQUIVALENCE.md` carries eight arguments covering thirteen mutants. Each gives a
mechanism, and three of them are backed by a **same-site positive control** — a
sibling mutant at the identical source location, produced by a different
operator, that the same test does kill. That is what rules out the alternative
explanation that the test simply cannot see anything at that line:

| site | equivalent, survives | sibling at the same site, killed |
|---|---|---|
| `max_filter` 38:57 | `add_to_div`, `add_to_mul` (`2t+1` → `2t`) | `add_to_sub` (`2t+1` → `2t-1`) |
| `max_filter` 54:43 | `add_to_sub` (`x+dx` → `x-dx`) | `add_to_div`, `add_to_mul` |
| `max_filter` `Halide.h` 13312 | `lt_to_le` | `lt_to_ge` |

## Data integrity: two CSVs lost rows mid-run, and how that was caught

While round-2 runs were still writing, `git add`/`git commit` were run over
`mutation/experiment2/results/`. Two result files stopped being appended to
partway through, while their processes carried on and logged every remaining
verdict normally. Nothing errored; the runs reported success.

It was caught by a cross-check rather than by noticing anything wrong: the
`after` pass of two runs reported fewer *effective* mutants than the `before`
pass, which is impossible — effectiveness is decided by comparing the emitted
`.stmt` against the baseline and does not depend on which driver is linked.

| file | rows the log recorded | rows the CSV kept |
|---|---:|---:|
| `iir_blur-arith.csv` (after) | 39 | 15 |
| `dwsc-schedule-t3.csv` (after) | 34 | 22 |
| `c_backend-arith-t2.csv` | 27 / 27 | 27 / 27 |
| `dwsc-arith-t2.csv` | 33 / 33 | 33 / 33 |
| `max_filter-arith.csv` | 54 / 54 | 54 / 54 (+3 equivalent) |

The three intact files are the ones whose runs had already finished before any
git command touched the directory. No reported conclusion depended on the two
damaged files: the logs are append-only and complete, and both results were read
back from them and then confirmed by a clean re-run.

The tell was a set of identical nanosecond mtimes across unrelated CSVs —
`max_filter-arith.csv` and `dwsc-schedule-t3.csv` both at `12:36:59.975930516`,
and two round-1 files both at `12:07:43.928476962`, the moment of a
`git reset --hard`. Independent writers do not collide on a nanosecond; a single
git operation stamping several paths does. These files carry CRLF line endings
(Python's `csv` module writes `\r\n`) under `text: auto`, which is exactly the
configuration where git rewrites a working-tree file rather than leaving it
alone.

Two changes came out of it:

* `.gitattributes` marking `*.csv -text` in both results directories, so git
  never rewrites a result file in the working tree (`git check-attr` now reports
  `text: unset`);
* results are committed only when no run is writing to them.

Worth recording beyond this study: a long sweep that streams to a file inside a
git working tree is quietly fragile, and the failure is silent in both
directions — the process reports success and the file looks well-formed. The
`before`/`after` design is what made it detectable at all, because it produces
two independent counts of the same quantity.

## Schedule directives

Lowest priority, and mostly still open. Two things were established.

**Six are resolved by argument.** `blur` (4) and `c_backend` (2) are integer
pipelines end to end. Halide's scheduling language is value-preserving by
construction and the compiler rejects schedules that would not be — visible in
this sweep as the 50 schedule mutants killed at generation time. The one
practical leak in that guarantee is floating-point rounding, and it does not
apply to a `uint16` pipeline. See `EQUIVALENCE.md` 6-7.

**A structural argument alone is not enough for the float pipelines.** Every one
of the 115 unresolved schedule mutants applies its directive to a *pure* loop
dimension, never to a reduction variable, so no Halide-level reassociation
occurs. That looked like a general equivalence argument until `iir_blur`
falsified it: at the same site (`blur.update(1).vectorize(x)`, line 56, and
`update(2)`, line 59) `vectorize -> parallel` changes the output enough for the
golden-output oracle to kill it, while `vectorize -> unroll` does not. The
reduction there runs over `ry` and neither directive touches `ry`. The difference
therefore comes from instruction selection below Halide — FMA contraction, vector
width — not from anything visible in the schedule. No equivalence is claimed for
the remaining float-pipeline schedule mutants on structural grounds.

The integer argument was checked against every other app holding unresolved
schedule mutants, and extends to none of them. `hist` is the near miss worth
recording: its input and output are both `uint8`, so it looks like an integer
pipeline from the signature, but its interior is not — `Y`, `Cr` and `Cb` are
float Funcs (`0.299f * input(...)` and friends), and the float `Y` feeds
`cast<int>(clamp(Y, 0, 255))` to pick a histogram bin. A rounding difference in
`Y` can therefore move a sample into a different bin and change the integer
histogram downstream. Element type at the interface is not a proxy for element
type in the reduction; `harris`, `unsharp`, `nl_means`, `bilateral_grid`,
`max_filter`, `iir_blur` and `conv_layer` are float outright.

What is being measured instead: `depthwise_separable_conv` holds the largest
single block (34) and saves no output artifact, so its schedule mutants have
never had an output compared at all.
`apps/depthwise_separable_conv/mutation_test3.cpp` gives them one — wide-exponent
inputs so the pointwise reduction's partial sums genuinely depend on accumulation
order, and a raw bit-level dump for the oracle. The test verifies its own premise
(summing the same terms forwards and backwards must give different floats) so
that a silent loss of sensitivity fails rather than passes.
