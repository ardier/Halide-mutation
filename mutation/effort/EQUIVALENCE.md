# Equivalent mutants on the generator route

Companion to `mutation/experiment2/EQUIVALENCE.md`, for the 41 generator-source
mutants that survived every added driver in `mutation/effort/`.

A mutant that no test can distinguish is **equivalent**, not "unkillable". Each
entry below states the argument. Where a sibling mutant at the same site *was*
killed, that is recorded too: it is the strongest corroboration available, since
it shows the site is reachable and observable and that the surviving variant is
the one the argument predicts should survive.

Every mutant listed here was measured twice — under the app's shipped driver and
under an added driver built to attack it — against the same mutant artifacts.
Neither killed it.

---

## lens_blur — 9

### 75:68 `operator/` -> `+`, `-`, `*` (3 mutants)

```
filtered_cost(x, y, z) = (cost_pyramid_pull[0](x, y, z, 0) /
                          cost_pyramid_pull[0](x, y, z, 1));
```

`filtered_cost` is used in exactly one place, line 82:

```
depth(x, y) = argmin(filtered_cost(x, y, r))[0];      // r over slices
```

Channel 1 of the pyramid carries `cost_confidence(x, y)`, which is declared with
**no z dimension** (line 48), and `downsample` only touches x and y, so channel 1
is constant in z at every pyramid level. Write it `B(x,y)`, and channel 0
`A(x,y,z)`. The four variants compute `A/B`, `A+B`, `A-B`, `A*B`.

`argmin` over z is invariant under adding or subtracting a z-constant, and under
multiplying or dividing by a positive z-constant. `B` is a blurred variance,
hence non-negative. So `depth` — the only consumer — is unchanged, and with it
everything downstream. Equivalent.

### 98:73 and 99:81 `operator+` -> `-` (2 mutants)

```
RDom r(-maximum_blur_radius, 2 * maximum_blur_radius + 1);
worst_case_bokeh_radius_y(x, y) = maximum(bokeh_radius(x, y + r));
worst_case_bokeh_radius(x, y)   = maximum(worst_case_bokeh_radius_y(x + r, y));
```

The reduction domain is symmetric about zero, and `r` appears nowhere else in the
expression. Substituting `r -> -r` is a bijection of the domain onto itself, so
`{f(y + r)}` and `{f(y - r)}` are the same multiset and their maxima are equal.
Equivalent. (The `*` and `/` variants at both sites were killed — they are not
sign flips of a symmetric index.)

### 138:39 `operator<` -> `<=`

```
Expr sample_is_in_front_of_this_pixel = depth(sample_x, sample_y) < depth(x, y);
...
sample_weight(x, y, z) = select((sample_is_within_bokeh_of_this_pixel ||
                                 sample_is_in_front_of_this_pixel) &&
                                    this_pixel_is_within_bokeh_of_sample,
                                1.0f, 0.0f);
```

The two predicates differ only where `depth(sample) == depth(x,y)`. But
`bokeh_radius` is a pure function of `depth` (line 86), so at such a pixel
`bokeh_radius_squared(sample_x, sample_y) == bokeh_radius_squared(x, y)`, which
makes `sample_is_within_bokeh_of_this_pixel` and
`this_pixel_is_within_bokeh_of_sample` the *same* predicate — call it `A`. The
select condition is then `(A || false) && A = A` in the original and
`(A || true) && A = A` in the mutant. Equal. Equivalent.

### 142:13 `Halide::select` -> `Internal::Call::if_then_else`

Both arms are the constants `1.0f` and `0.0f`: no loads, no faults, no
divergence, and no footprint for bounds inference to differ over. The two
constructs differ in whether the untaken arm is evaluated, which cannot change a
value here. Equivalent for any oracle that observes pipeline output. (Distinguish-
able in principle only by an oracle over allocation sizes or generated IR.)

### 292:50 and 293:55 `operator*` -> `/` (2 mutants)

```
upx(x, y, _) = 0.25f * f((x / 2) - 1 + 2 * (x % 2), y, _) + 0.75f * f(x / 2, y, _);
```

The mutation turns `2 * (x % 2)` into `2 / (x % 2)`. Halide's `%` on integers is
Euclidean, so `x % 2` is 0 or 1 for every `x`, including negative `x`:

* `x % 2 == 1`: `2 * 1 == 2 / 1 == 2`.
* `x % 2 == 0`: `2 * 0 == 0`, and `2 / 0 == 0` — Halide defines integer division
  by zero to produce zero rather than trapping.

Equal at both. Equivalent **on this target**, and the caveat is named: the
argument rests on Halide's defined behaviour for integer division by zero, not on
a mathematical identity.

---

## camera_pipe — 16 equivalent (of 18 still surviving; the other 2 are below)

### 75:21, 82:21, 119:21, 130:21, 325:14, 332:16, 332:39 — `select` -> `if_then_else` (7)

Every arm at these sites is a pure, already-in-bounds expression over Funcs the
surrounding definition demands anyway. Lazy versus eager evaluation of the
untaken arm cannot change the value produced. Equivalent for an output oracle.

### 325:23 `operator>` -> `>=`

```
Expr b = 2.0f - pow(2.0f, contrast / 100.0f);
Expr a = 2.0f - 2.0f * b;
Expr z = select(g > 0.5f,
                1.0f - (a * (1.0f - g) * (1.0f - g) + b * (1.0f - g)),
                a * g * g + b * g);
```

The two branches differ only at `g == 0.5f`, and the curve is built to be
continuous there: with `a = 2 - 2b`, the false branch gives
`a/4 + b/2 = (2 - 2b)/4 + b/2 = 1/2`, and the true branch gives `1 - 1/2 = 1/2`.
Equivalent. (Strictly: the two branches evaluate the same quantity `t` and return
`t` and `1 - t`, which coincide when `t` rounds to exactly `0.5f`; a last-ulp
disagreement is conceivable but was not observed, and `g == 0.5f` exactly is
itself a measure-zero event over the integer LUT domain.)

### 332:25 `<=` -> `<` and `<=` -> `==`; 332:48 `>` -> `>=` and `>` -> `==` (4)

```
Expr xf  = clamp(cast<float>(x - minRaw) * invRange, 0.0f, 1.0f);
Expr val = cast(result_type, clamp(z * 255.0f + 0.5f, 0.0f, 255.0f));
curve(x) = select(x <= minRaw, 0, select(x > maxRaw, 255, val));
```

with `invRange = 1.0f / (maxRaw - minRaw)`. The two guards are **redundant with
the clamp on `xf`** that already sits inside `val`:

* `x <= minRaw` (or `x < minRaw`, or `x == minRaw`): `xf` clamps to `0`, so
  `g = pow(0, 1/gamma) = 0`, `z = 0`, and `val = cast(clamp(0.5f, 0, 255)) = 0` —
  which is exactly what the guard returns.
* `x >= maxRaw` (or `>`, or `==`): `xf` clamps to `1`, so `g = 1`, `z = 1`, and
  `val = cast(clamp(255.5f, 0, 255)) = 255` — exactly what the guard returns.

So moving the guard boundary by one LUT entry, in either direction, selects
between two expressions that agree there. Equivalent.

### 515:39 `operator*` -> `/`; 525:43 `operator/` -> `+`, `-`, `*` (4)

```
Expr strip_size = 32;
strip_size = (strip_size / 2) * 2;              // line 515
...
    .split(yi, yo, yi, strip_size / 2)          // line 525
```

Both lines are **schedule** code, inside `CameraPipe::schedule()`. They set a
strip height and a split factor. Halide's central guarantee is that scheduling
directives do not change what a pipeline computes, only the order and granularity
in which it is computed; a legal schedule with a different split factor produces
identical output. These four are therefore equivalent by the language's own
contract — an equivalence class with no analogue on the emitted-C++ route, where
the same textual change would corrupt a loop bound.

### NOT equivalent: 515:34 `operator/` -> `*` and `-` (2)

The same schedule expression, but these two variants make the pipeline **fail at
runtime**: under the added driver both die on SIGABRT, which is Halide's default
error handler aborting on a schedule that is illegal for that input size. They are
detected, not equivalent. They are recorded as `test2_added = NOT_RUN` because a
crash writes no artifact and is not a clean assertion failure, so neither test-2
mechanism returns a verdict; the detection is real but is a test-1-shaped
observation.

---

## depthwise_separable_conv — 6 equivalent (of 7 still surviving)

### 41:13 `select` -> `if_then_else`

As above: `select(in_bounds, input(d, clamped_x, clamped_y, b), 0.0f)`. The load
is clamped into bounds before the select ever runs, so the untaken arm is safe
and the value is the same either way. Equivalent.

### 288:53, 289:64 (x2), 290:64 (x2) — `operator==` -> `>=` / `<=` (5)

```
output.specialize(channel_multiplier == 1 &&
                  intermediate_channels == (intermediate_channels / 32) * 32 &&
                  depthwise_filter.dim(2).extent() == 3 &&
                  depthwise_filter.dim(3).extent() == 3);
```

`specialize` is a scheduling directive: it emits an extra code path guarded by a
predicate, and Halide guarantees both paths compute the same result. Widening the
predicate changes which shapes take the specialised path — that is, changes
performance — but not what any of them compute. Equivalent by the same contract as
the camera_pipe schedule mutants.

### NOT equivalent: 59:29 `operator/` -> `*`

`input_bounded(d / channel_multiplier, ...)` -> `d * channel_multiplier`. Under
`mutation_test2.cpp`, which uses a channel multiplier of 2, this aborts (SIGABRT)
rather than merely differing. Detected, not equivalent; recorded as NOT_RUN for
the same reason as camera_pipe 515:34.

---

## local_laplacian — 5

Both sites raise the **upper bound of a clamp above a value the clamped quantity
provably never reaches**, so the clamp does not bind in the original either.

### 43:48 `operator-` -> `+`, `*`, `/` (3)

```
Expr idx = gray(x, y) * cast<float>(levels - 1) * 256.0f;
idx = clamp(cast<int>(idx), 0, (levels - 1) * 256);
```

`gray = 0.299f*r + 0.587f*g + 0.114f*b` over channels that are `input / 65535.0f`,
each in `[0, 1]`. Those three float literals sum to `0.99999999`, strictly less
than one, so `gray < 1` for **every** input, hence `idx < (levels-1)*256` and
`cast<int>(idx) <= (levels-1)*256 - 1`. The mutants replace the bound with
`(levels+1)*256`, `levels*256`, `levels*256` — all larger. A bound that never
bound, raised. Equivalent.

### 68:57 `operator-` -> `+`, `*` (2)

```
Expr level = inGPyramid[j](x, y) * cast<float>(levels - 1);
Expr li = clamp(cast<int>(level), 0, levels - 2);
```

`inGPyramid` is the Gaussian pyramid of the same `gray`, built with a normalised
1-3-3-1 kernel, so it stays within `gray`'s range and `level < levels - 1`, giving
`cast<int>(level) <= levels - 2` — exactly the original bound. The mutants raise it
to `levels + 2` and `2 * levels`. Equivalent.

**Corroboration.** The third variant at 68:57, `-` -> `/`, gives `levels / 2` — at
`levels = 8` that is 4, *below* the reachable range of 6 — and the sweep killed it.
Only the two that raise the bound survive, which is exactly what the argument
predicts. `apps/local_laplacian/mutation_test.cpp` was written to attack these
five with saturated white and black rows and a full-range ramp, driving `gray` to
both extremes; all five survived it.

---

## max_filter — 5

### 17:22 `repeat_edge` -> `mirror_image` and `mirror_interior` (2)

Prior work's argument, restated and re-measured: a max over a window that is
symmetric about its centre and shrinks with distance from it cannot tell
edge-clamping from reflection. Both map an out-of-domain sample to a coordinate no
further from the window centre in either axis, so the reflected sample still lies
inside the window and inside the image, and every in-window in-image coordinate is
already sampled directly. The two therefore range over the same set of values and
the max agrees. The sibling `repeat_edge -> repeat_image` at this site *was*
killed — wrapping maps a sample to the far edge, outside the window — which is the
corroboration.

### 38:57 `operator+` -> `*` and `/` (2)

```
slice_for_radius(t) = cast<int>(floor(log(2 * t + 1) / logf(2)));
Expr slice = clamp(slice_for_radius(t), 0, slices);      // the only use
```

Both mutants turn `2 * t + 1` into `2 * t`. For integer `t >= 1`, `2t + 1` is odd
and greater than one, so no power of two lies in `(2t, 2t + 1]` and
`floor(log2(2t)) == floor(log2(2t + 1))`. The only remaining case is `t == 0`,
which is unreachable here: `t` is `clamp(filter_height(dx), 0, radius + 1)`, and at
`radius = 26` the smallest value `filter_height` takes over `dx in [-26, 26]` is 4.
Equivalent.

### 54:43 `operator+` -> `-`

```
RDom dx(-radius, 2 * radius + 1);
output_(x, y, c) = maximum(vert(x + dx, y, c, clamp(filter_height(dx), 0, radius + 1)));
```

The reduction domain is symmetric about zero, and the only other use of `dx` is
`filter_height(dx)`, which is defined as `sum(select(x*x + dy*dy < ..., 1, 0))` —
a function of `dx*dx`, hence even. Under `dx -> -dx` the multiset of terms
`{(x + dx, filter_height(dx))}` maps exactly onto `{(x - dx, filter_height(dx))}`,
so the maxima are equal. Equivalent. The `*` and `/` variants at the same site
were killed, as the argument predicts — neither is a sign flip.
