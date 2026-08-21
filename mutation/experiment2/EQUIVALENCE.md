# Equivalence proofs for surviving mutants

A mutant is *resolved* if it is killed, rejected by the compiler, or shown to be
equivalent. This file carries the third kind. Each entry gives a mechanism, not
a shrug: an argument for why no input can distinguish the mutant from the
original, plus whatever empirical confirmation exists.

Empirical confirmation alone is never treated as proof here — a mutant that
survives every test written so far is a mutant nobody has killed *yet*. The
argument is what makes it resolved; the measurement is what makes the argument
credible.

Where possible the measurement is a **same-site positive control**: a sibling
mutant at the identical source location, produced by a different operator, that
the same test *does* kill. That rules out the obvious alternative explanation —
that the test simply cannot see anything at that line. Three of the entries
below have one:

| site | equivalent, survives | sibling at the same site, killed |
|---|---|---|
| `max_filter` 38:57 | `add_to_div`, `add_to_mul` (`2t+1 -> 2t`) | `add_to_sub` (`2t+1 -> 2t-1`) |
| `max_filter` 54:43 | `add_to_sub` (`x+dx -> x-dx`) | `add_to_div`, `add_to_mul` |
| `max_filter` `Halide.h` 13312 | `lt_to_le` | `lt_to_ge` |

---

## 1-2. `max_filter` 38:57 — `Halide_add_to_div`, `Halide_add_to_mul`

```cpp
slice_for_radius(t) = cast<int>(floor(log(2 * t + 1) / logf(2)));
```

The `+ 1` becomes `/ 1` and `* 1` respectively, so both mutants compute
`floor(log2(2t))` where the original computes `floor(log2(2t + 1))`.

**Argument.** For integer `t >= 1`, `floor(log2(2t))` and `floor(log2(2t+1))`
differ only if a power of two lies in the half-open interval `(2t, 2t+1]`. The
only integer in that interval is `2t+1`, which is odd, and the only odd power of
two is `1`. So the two agree for every `t >= 1`, and can differ only at `t = 0`,
where the original gives `floor(log2(1)) = 0` and the mutants evaluate
`log(0) = -inf`.

`t = 0` is never read. `slice_for_radius` has exactly one consumer:

```cpp
Expr slice = clamp(slice_for_radius(t), 0, slices);
...
output_(x, y, c) = maximum(vert(x + dx, y, c, clamp(filter_height(dx), 0, radius + 1)));
```

so the argument actually evaluated is `t = clamp(filter_height(dx), 0, radius+1)`
for `dx` in `[-26, 26]`. `filter_height(dx)` counts the `dy` in `[0, 26]` with
`dx^2 + dy^2 < 26.25^2`, and is minimised at `|dx| = 26`, where
`676 + dy^2 < 689.0625` holds for `dy` in `{0,1,2,3}` — four of them. So the
argument lies in `[4, 27]` at every point of the reduction domain, and `t = 0`
is outside it.

Bounds inference cannot see this (`filter_height` is a `Func`, so `clamp(v,0,27)`
widens to `[0, 27]`), which is why `slice_for_radius` is *computed* at `t = 0`
under `compute_root()` — but the value stored there is never loaded. Evaluating
`log(0)` produces `-inf` under IEEE default rules without trapping, and Halide
does not enable floating-point traps, so computing it has no side effect either.

**Confirmation.** Byte-identical output in the original sweep, and again under
`apps/max_filter/mutation_test.cpp`, which compares an exact C++ reference at
every pixel of the 30-pixel border band on a second, adversarial input.

## 3. `max_filter` 54:43 — `Halide_add_to_sub`

```cpp
RDom dx(-radius, 2 * radius + 1);
output_(x, y, c) = maximum(vert(x + dx, y, c, clamp(filter_height(dx), 0, radius + 1)));
```

The mutant reads `vert(x - dx, ...)`.

**Argument.** The reduction domain `dx in [-R, R]` is symmetric about zero, so
`dx -> -dx` is a bijection of it onto itself. Re-indexing the mutant's reduction
by `dx' = -dx` turns its term set into

```
{ vert(x + dx', y, c, t(-dx')) : dx' in [-R, R] }
```

and `filter_height` depends on its argument only through `x * x`, so it is even:
`t(-dx') = t(dx')`. The mutant's terms are therefore exactly the original's
terms, reordered. `maximum` depends only on the set of terms, and `max` is exact
in floating point (it selects an operand rather than computing a new value), so
reordering cannot change the result by even one ulp.

The one way this argument could fail is NaN, where `max` stops being
order-insensitive. The input is a `float` image; the app's own driver produces it
via `load_and_convert_image` from a PNG, and the test's synthetic input is
finite by construction, so no NaN reaches the reduction.

**Confirmation.** Byte-identical output in the sweep and under the exact
reference test.

## 4. `max_filter` `Halide.h` 13312:25 — `Halide_lt_to_le`

The mutated `<` is inside Halide's own header, in

```cpp
inline Expr operator<(Expr a, float b) { return std::move(a) < Expr(b); }
```

This is a *library* mutation point, not a generator one — the only one in the
unresolved set.

**Argument.** `operator<(Expr, float)` is instantiated exactly once from this
generator. Grepping the generator for comparisons of an `Expr` against a float
literal gives a single site (line 50; the `<` on lines 31 and 45 are `<<`
shifts):

```cpp
filter_height(x) = sum(select(x * x + dy * dy < (radius + 0.25f) * (radius + 0.25f), 1, 0));
```

The left side is `Int(32)`-valued (`x` is a `Var`, `dy` an `RVar`); the right
side is the constant `26.25f * 26.25f = 689.0625f`. `<` and `<=` differ only
where the operands are equal, and no integer equals `689.0625`. The two
predicates are therefore pointwise identical on every value this site can ever
see.

This also explains the contrast with `Halide_lt_to_ge` at the same location,
which the sweep killed: `>=` is a different predicate, not a boundary tweak.

**Confirmation.** Byte-identical output in the sweep and under the exact
reference test.

## 5. `bilateral_grid` 29:32 — `Halide_add_assign_to_sub_assign`

```cpp
histogram(x, y, z, c) = 0.0f;
histogram(x, y, zi, c) += mux(c, {val, 1.0f});     // mutated to -=
```

**Argument.** The pipeline's output is a *ratio* of two quantities that are both
linear in the histogram, so negating the histogram cancels.

Concretely, let `H` be the original histogram and `H'` the mutant's. The pure
definition is `0.0f` in both, and each update subtracts exactly what the original
adds. IEEE-754 negation is exact and addition is sign-symmetric —
`(-x) + (-y) = -(x + y)` holds exactly, with no rounding difference — so by
induction over the accumulation `H' = -H` exactly, whatever order Halide
accumulates in.

`blurz`, `blurx` and `blury` are fixed-coefficient weighted sums (1, 4, 6, 4, 1)
of histogram values, so each is exactly negated by the same argument.
`interpolated` is a nest of `lerp`, which is homogeneous of degree one in its two
endpoints and sign-symmetric in exact arithmetic *and* in floating point:
`(-a) + ((-b) - (-a)) * t` evaluates to the exact negation of `a + (b - a) * t`
term by term. So `interpolated' = -interpolated` exactly, in both channels.

The final line is

```cpp
bilateral_grid(x, y) = interpolated(x, y, 0) / interpolated(x, y, 1);
```

and `(-N) / (-D) == N / D` exactly in IEEE-754 for every pair of finite operands,
including the signed-zero and infinity cases: the sign of a quotient depends only
on the XOR of the operand signs, which negating both leaves unchanged, and the
magnitude is computed identically.

**Confirmation.** The sweep's O2 oracle compared the full output PNG byte-wise
and found it identical — an independent check on a real photograph, not a
synthetic input.

## 6-7. `blur` (4) and `c_backend` (2) — schedule directives on an integer pipeline

| app | site | mutants |
|---|---|---|
| blur | 106:18 `.vectorize(x, 16)`, 110:18 `.vectorize(x, 16)` | `vectorize_to_unroll` x2, `vectorize_to_parallel` |
| blur | 108:18 `.store_at(blur_y, y)` | `store_at_to_compute_at` |
| c_backend | 21:26 `f.compute_root().vectorize(x, 8)` | `vectorize_to_parallel`, `vectorize_to_unroll` |

**Argument.** Halide's scheduling language is value-preserving by construction:
a schedule chooses the loop order, tiling, storage granularity and
parallelisation for a fixed algorithm, and the compiler rejects schedules that
would change the result (that rejection is visible in this very sweep as the 50
schedule mutants killed at generation time, and as the two `harris`
`store_at_to_compute_at` mutants that abort at run time).

That guarantee has exactly one practical leak: floating-point. Reassociating or
re-vectorising a float computation can change rounding even when the
mathematical value is unchanged, which is how ten schedule mutants elsewhere in
this corpus were killed by byte-comparing a saved image.

Both of these pipelines are integer end to end, so the leak does not apply:

* `blur` is `uint16` throughout —
  `blur_x(x, y) = (input(x, y) + input(x + 1, y) + input(x + 2, y)) / 3`, and
  `blur_y` likewise over `blur_x`, with `Input<Buffer<uint16_t, 2>>` and
  `Output<Buffer<uint16_t, 2>>`.
* `c_backend` is `uint16` throughout —
  `f(x, y) = (input(clamp(...), clamp(...)) * 17) / 13` and an integer
  `output`, with the extern stage summing `int16` values.

Two's-complement addition and multiplication are exactly associative and
commutative, and neither vectorisation, unrolling, parallelisation nor a change
of storage granularity alters the *expression* evaluated per output element --
only the loop structure around it. There is therefore no mechanism by which any
of these six mutants can change an output value.

`store_at_to_compute_at` deserves its own sentence: moving a Func's storage
level inward disables sliding-window reuse, so the mutant recomputes values the
original would have kept. It computes the same values, more often.

**Confirmation.** Byte-identical output in the sweep. Note that for these two
apps O2 is not independent of O1 (neither driver saves an artifact), so the
sweep's confirmation here is weaker than elsewhere; the argument, not the
measurement, is what resolves these six.

**Scope.** This argument covers *integer* pipelines only. It deliberately does
not extend to the other 109 unresolved schedule mutants, which sit in float
pipelines. `iir_blur` is the counterexample that forces that caution: at the
same site (`blur.update(1).vectorize(x)`, line 56, and `update(2)`, line 59),
`vectorize -> parallel` changes the output enough for O2 to kill it while
`vectorize -> unroll` does not. The reduction there runs over `ry` and neither
directive touches `ry`, so no Halide-level reassociation occurs -- the
difference has to come from instruction selection (FMA contraction, vector
width) below Halide. A structural "the directive is on a pure loop dimension"
test is therefore necessary but *not* sufficient for float pipelines, and no
equivalence is claimed for them here.

## 8. `max_filter` 29:41 — `Halide_add_to_mul`

```cpp
RDom r(-radius, input_.height() + radius, 1, slices - 1);
```

becomes `input_.height() * radius`, enlarging the reduction domain's first
extent from `H + 26` to `26H`, so `r.x` runs over `[-26, 26H - 26)` instead of
`[-26, H)`.

**Argument.** The enlarged domain updates `vert_log` at rows `[H, 26H - 26)`
that the original leaves at its pure definition, `vert_log(x, y, c, 0) =
input(x, y, c)`. Those rows are exactly where the extra work lands, and they are
also exactly where it cannot matter.

`input` here is `repeat_edge(input_, ...)`, so `input(x, y, c) = input(x, H-1, c)`
for every `y >= H - 1`: the tail is constant in `y`. `vert_log(x, y, c, k)` is a
maximum over the row range `[y, y + 2^k - 1]`, and a maximum over a set of equal
values is that value, so for `y >= H - 1` the updated entry equals
`input(x, H-1, c)` -- which is precisely the pure-definition value the original
leaves there. Updating those rows therefore writes back what was already there.

The rows the consumer actually reads are `[y - t, y + t]` for `y` in `[0, H)` and
`t` in `[4, 27]`, i.e. at most `[-27, H + 26]`; every read above `H - 1` falls in
the constant tail. Rows below `H` are updated identically by both versions --
same `r.x` minimum, same recurrence over `r.y`.

So the mutant does 26x the work and produces the same image. It is a
performance mutant wearing an arithmetic mutant's clothes, and only an O3-style
oracle could see it.

**Confirmation.** Survives `apps/max_filter/mutation_test.cpp`, the exact C++
reference over the entire 30-pixel border band -- the region where a difference
in the boundary tail would have to appear. The same test kills
`Halide_add_to_sub` and `Halide_add_to_div` at the neighbouring sites, so it is
not a case of the test being blind.

---

## Not claimed here

The ten `select -> if_then_else` mutants and the two `max_filter`
BoundaryConditions mutants were argued in `RESULTS.md` and are not repeated.

Nothing in the schedule-directive family is claimed as equivalent in this file.
The 166 already classified equivalent-at-target by the pipeline were established
by a different and stronger route — byte-identical emitted `.stmt` — which needs
no argument at all.
