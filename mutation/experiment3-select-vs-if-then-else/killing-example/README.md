# A killing example for `select -> if_then_else`

This directory is a **self-contained, runnable existence proof** that the
`select -> if_then_else` mutation operator (eager -> lazy conditional
evaluation) is killable in principle by a correctness-adjacent oracle — even
though it survives 0/10 times on the actual 14/13-benchmark corpus (see
`../RESULTS.md` for why the corpus itself doesn't happen to exercise this
shape).

## What makes it observable

Not a crash, not a NaN, not a divide-by-zero — **Halide's own bounds-inference
machinery**. `select(cond, a, b)` unconditionally requires whatever `a` and
`b` require, for every output pixel, regardless of `cond` — that's an
accurate model of eager evaluation (it *actually does* compute both
branches). `Halide::Internal::Call::if_then_else` gets lowered into a genuine
conditional statement, and when its condition is a simple inequality directly
on the loop variable (like `x < 10`), Halide's bounds-inference pass
(`solve_expression` in `src/Bounds.cpp`) can prove the untaken branch's
region is unreachable and drops it from the declared input requirement. The
two forms therefore compile to **different closed-form formulas for "how
much input does this pipeline need"** — provable by inspection of the
lowered `.stmt`, and observable via `Pipeline::infer_input_bounds()` without
running anything that could fail.

## The generator

`oob_select_generator.cpp` is one minimal `Halide::Generator<T>` (the same
base class every corpus generator mutated by this operator uses), ~10 lines
in `generate()`:

```cpp
Input<Buffer<int32_t, 1>> in{"in"};
Output<Buffer<int32_t, 1>> out{"out"};

void generate() {
    Var x("x");
    Expr cond = x < 10;
    Expr a = in(x);
    Expr b = in(x + 100000);
    out(x) = select(cond, a, b);   // <- the ORIGINAL. The mutant replaces
                                    //    just this line (see the #ifdef block
                                    //    in the file) with the hand-built
                                    //    if_then_else, exactly the transform
                                    //    the real operator applies.
}
```

The mutant form (guarded by `#ifdef MUTANT_IF_THEN_ELSE` in the same file, so
the only difference between the two builds is that one block) is built using
the exact template already validated for the real operator (`mull-ps@wip-p`,
`halide_src_rewrite`'s `halide_select_to_if_then_else`):

```cpp
Expr sel = select(cond, a, b);  // only to obtain .type() -- match_types is
                                  // not derivable from either branch alone
out(x) = Halide::Internal::Call::make(
    sel.type(), Halide::Internal::Call::if_then_else,
    {cond, Halide::cast(sel.type(), a), Halide::cast(sel.type(), b)},
    Halide::Internal::Call::PureIntrinsic);
```

## Build both forms and run the killing test

```bash
HB=/path/to/halide/build ./build_and_test.sh
```

(`HB` defaults to the swsec01 path this was developed/verified against:
`/dev/shm/ardi_dslmut/halide-build`, a Halide v21.0.0 / LLVM 20 build. Needs
`Halide.h` and `libHalide.so` under `$HB/include` and `$HB/src`
respectively — any Halide v21-ish build with those two present works.)

The script compiles `oob_select_generator.cpp` twice from the *same file*
(once plain -> `./original`, once with `-DMUTANT_IF_THEN_ELSE` -> `./mutant`),
runs the identical embedded test against each, and reports a verdict.

## The test, and why the polarity is correct

The test is written by reading only the **original** (eager `select`)
program and reasoning about what it must require:

> "`select` evaluates both branches for every output pixel, so realizing
> `out` over `x` in `[0,10)` requires input covering `[0,10)` (the direct
> branch) **and** `[100000,100010)` (the offset branch) — i.e. required
> extent >= 100010."

That assertion is baked into the shared `main()` once, compiled unchanged
into both binaries, and run against both:

```
=== ORIGINAL (select) ===
required input extent (bounds query) = [0, 100010), extent=100010
test 'required extent covers both branches (>= 100010)': PASS

=== MUTANT (if_then_else) ===
required input extent (bounds query) = [0, 10), extent=10
test 'required extent covers both branches (>= 100010)': FAIL

VERDICT: mutant KILLED (test passes on original, fails on mutant).
```

This is the conventional mutation-testing direction (passes on original,
fails on mutant), achieved honestly: the assertion follows directly from
eager semantics, and it fails on the mutant precisely *because* the mutant is
lazy and Halide's compiler can prove the untaken branch needn't be read. No
inversion, no cherry-picking a direction that happens to work only because
the original crashes (the operator's original/mutant asymmetry the parent
investigation flagged as a trap to avoid — this test doesn't fall into it:
the original is the one whose declared requirement is *larger*, so asserting
on that requirement and testing it against the mutant is exactly the direction
that stays valid).

A crash-based version of the same idea also works, in the same direction
(`../RESULTS.md`'s `bounds_oob.cpp`, "execution test" section): given a
buffer sized to the *mutant's* declared requirement (10 elements), the
original throws `Input buffer ... is accessed at 100009, which is beyond the
max (9)` while the mutant realizes cleanly and correctly — but that direction
requires the original to be run in a context expecting a crash, which is a
less natural "test," so the bounds-query assertion above is the one worth
keeping as the canonical example.

## Does this shape occur in the real 14/13-benchmark corpus?

No — see `../RESULTS.md` for the full per-site breakdown of all 13 real
`select -> if_then_else` call sites. None combine (a) a condition solvable
via loop-variable interval reasoning, (b) branches that read a buffer/Func at
genuinely different index expressions, and (c) those indices not already
forced into a common safe range by `clamp`. That's a corpus property, not a
limitation of the operator or the oracle: this example is the existence proof
that the operator *is* killable in principle.
