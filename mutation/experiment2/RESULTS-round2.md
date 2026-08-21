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

<!-- TABLE -->

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

What is being measured instead: `depthwise_separable_conv` holds the largest
single block (34) and saves no output artifact, so its schedule mutants have
never had an output compared at all.
`apps/depthwise_separable_conv/mutation_test3.cpp` gives them one — wide-exponent
inputs so the pointwise reduction's partial sums genuinely depend on accumulation
order, and a raw bit-level dump for the oracle. The test verifies its own premise
(summing the same terms forwards and backwards must give different floats) so
that a silent loss of sensitivity fails rather than passes.
