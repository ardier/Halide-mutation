# Experiment 3: does a `select`-vs-`if_then_else`-distinguishing program exist?

**Question.** The `select → if_then_else` mutation operator (eager → lazy conditional
evaluation) survives 0/10 times across every oracle tried on the 13-benchmark corpus
(`bgu bilateral_grid blur camera_pipe conv_layer depthwise_separable_conv harris hist
iir_blur lens_blur max_filter nl_means unsharp`). A prior pass concluded the family is
"structurally outside any correctness oracle." This experiment asks: is that actually
true, or did we just never construct a program shaped to expose the difference?

**Answer: a distinguishing program exists.** The eager/lazy distinction is observable
through Halide's own bounds-inference machinery — not through any crash, NaN, or
divide-by-zero. It just does not occur naturally in this corpus's 13 real
`select → if_then_else` call sites, for a precise, checkable reason (below). So the
correct characterization is **"blind on this corpus,"** not **"structurally
unkillable."**

## The minimal distinguishing case

```cpp
ImageParam in(Int(32), 1, "in");
Var x;
Expr cond = x < 10;
Expr sel = select(cond, in(x), in(x + 100000));   // ORIGINAL (eager)
Func f_select; f_select(x) = sel;

Expr ite = Halide::Internal::Call::make(
    sel.type(), Halide::Internal::Call::if_then_else,
    {cond, cast(sel.type(), in(x)), cast(sel.type(), in(x + 100000))},
    Halide::Internal::Call::PureIntrinsic);          // MUTANT (lazy)
Func f_ite; f_ite(x) = ite;
```

Realized/queried over the output domain `x` in `[0,10)` (i.e. `f.realize({10})` /
`f.infer_input_bounds({10})`):

| | `in`'s required extent (bounds query) | `realize({10})` with a 10-element input buffer |
|---|---|---|
| `select` (**original**, eager) | **[0, 100010)**, extent 100010 | **throws**: `Input buffer in_sel is accessed at 100009, which is beyond the max (9)` |
| `if_then_else` (**mutant**, lazy) | **[0, 10)**, extent 10 | **succeeds**, correct output |

Full run: `bounds_oob.cpp` / `bounds_oob.output.txt` in this directory.

**A legitimate mutation test, correct polarity.** A developer who reads the *original*
(eager `select`) program and understands Halide's semantics can correctly assert
`"this generator requires an input buffer covering indices [0,100010)"` — this passes on
the original by construction. Run unchanged against the mutant, the same assertion
**fails**: the mutant's own bounds query reports it needs only 10 elements. No crash is
required for the oracle itself (the assertion is on the *declared bounds*, which is
exactly the "required input extent via bounds query" avenue flagged as most promising);
a crash-based version of the same test also works and has the correct
passes-on-original/fails-on-mutant direction, because eager evaluation is the one that
needs more, not less.

## The mechanism (traced in Halide v21 source, `src/Bounds.cpp`)

`Bounds.cpp`'s `BoxesTouched` visitor computes what region of each input buffer a
pipeline stage requires (this is what feeds the `.required` formulas baked into
bounds-query code, confirmed by dumping `.stmt` — see below).

- **`Select` has no `BoxesTouched::visit` override at all** (grep confirms exactly one
  `visit(const Select *)` in the whole file, and it belongs to a different, value-range
  visitor, not the box/region one). So the box-required visitor falls through to the
  generic case: it just visits `true_value` and `false_value` unconditionally under
  the current loop-variable scope, with **no use of the condition to restrict anything**.
  This is, in fact, an accurate model of eager evaluation: select really does read both
  branches for every iteration, so requiring both branches' full index ranges is correct,
  not merely conservative.

- **`Call::if_then_else` gets special-cased** (`BoxesTouched::visit(const Call*)`,
  `src/Bounds.cpp` around line 2415): it is converted into a genuine `IfThenElse` *Stmt*
  (`then_case`/`else_case` wrapped via `Evaluate::make`), and dispatched to
  `BoxesTouched::visit(const IfThenElse*)` (~line 2837). That visitor calls
  `solve_expression` on the condition for each free loop variable in scope; when the
  condition is a simple, invertible inequality on that variable (`x < 10` is exactly the
  `LT` case it handles), it **narrows the variable's scope** for each branch
  (`trim_scope_push`/`trim_scope_pop`) before visiting that branch's body. If a branch's
  narrowed range is empty within the query domain, that branch contributes nothing to
  the required region at all.

Dumping `.stmt` for both forms makes the difference literal and compiled-in, not just a
runtime coincidence:

```
select:        make_struct(f_select.min.0, f_select.extent.0 + 100000, 1, 0)   // always the full eager union
if_then_else:  let in_ite.extent.0.required = min(10 - f_ite.min.0, f_ite.extent.0)  // condition-narrowed
```

So the distinguishing power requires **three conditions simultaneously**:
1. the two branches read an **external buffer/Func at different index expressions**
   (not the same coordinate, not constants);
2. the condition is a **simple inequality/equality directly on (or affine in) the
   enclosing pure loop variable**, solvable by `solve_expression` (an arbitrary
   *data-dependent* condition — comparing two computed values — is not solvable this way
   and gets no narrowing at all, see below);
3. the two branches' index expressions are **not already forced into the same safe
   range** by something like `clamp` (if they are, narrowing changes nothing because the
   "unnarrowed" access was already safe/identical).

## A caveat found and worth flagging honestly: the gap does not shrink to zero when both branches are in-domain, and looks unsound there

Expectation going in (matching the corpus's camera_pipe finding, where the query domain
spans both branches and results come back byte-identical): once both branches are
actually reachable within the query/output domain, `if_then_else`'s narrowing should
recover a required region close to `select`'s full union.

Empirically (`bounds_span_both.cpp`, domain widened to `x` in `[0,20)` so *both*
`x<10` and `x>=10` are reachable): `select` correctly reports `[0,100020)`. But
`if_then_else` **still reports only `[0,10)`** — the else-branch's real requirement
(`in(x+100000)` for `x` in `[10,20)`, i.e. `[100010,100020)`) does not show up in the
compiled `.required` formula at all. Trusting that declared bound and allocating exactly
a 10-element buffer, then really calling `realize({20})`, does **not** throw — it
silently returns garbage for the `x>=10` outputs (`bounds_soundness_check.cpp`/`.output.txt`):
out-of-bounds reads that happen not to segfault, not a caught error. This looks like a
real under-approximation in Halide's `if_then_else` bounds narrowing for the two-branches-
both-reachable case, not merely "more conservative than select" — we did not fully
root-cause which pass is responsible (candidate: the sequential per-case
`trim_scope_push`/`body.accept(this)`/`trim_scope_pop` walk in
`BoxesTouched::visit(const IfThenElse*)` may not be what ultimately produces the
`BoundsInference.cpp`-emitted `.required` formula; we did not trace that connection to
the end, and are flagging this rather than asserting a specific line). This does **not**
change the headline finding (the single-reachable-branch case above is unambiguous and
independently verified via both the bounds query and real execution), but it means the
practical distinguishing gap between the two forms is *not* a narrow, easily-avoided edge
case — it appears to persist even in the "both branches reachable" shape, just via a
different (and more concerning) mechanism than originally expected. Worth a footnote/
threats-to-validity mention rather than a load-bearing claim, since it wasn't
independently root-caused.

## Why this shape does not occur in the actual 13-site corpus

All 13 real `select → if_then_else` mutation targets across the 13-app corpus
(`camera_pipe` ×9, `bgu` ×1, `depthwise_separable_conv` ×1, `lens_blur` ×1,
`max_filter` ×1 — grep below) were inspected against the three conditions above:

| site | condition shape | branches read | why no bounds gap is possible |
|---|---|---|---|
| `camera_pipe:27,33` `select((x%2)==0,...)` / `((y%2)==0,...)` | parity (modulo), not an interval-invertible inequality | `a(x/2,y)` / `b(x/2,y)` — same footprint either way | `solve_expression` cannot invert a modulo condition into a range at all; separately, the simplifier folds this exact mutant's `if_then_else` back to `Select` when it can prove both branches always safe (matches the plan's independent finding for these two lines) |
| `camera_pipe:75,82,119,130,325` `select(ghd_r<gvd_r,...)` etc. | comparison between two **computed Funcs at the same (x,y)** — opaque/data-dependent | both branches are `Func(x,y)` at the *same* coordinates | `solve_expression(c, x)`/`(c, y)` fails (`fully_solved=false`) since the condition doesn't isolate `x` or `y` algebraically — no narrowing happens, both forms visit the identical unrestricted footprint. This is the exact mechanism behind the earlier "bounds query returns input `[10,246)×[6,178)` byte-identically" corpus finding |
| `camera_pipe:332` `select(x<=minRaw,0,select(x>maxRaw,255,val))` | solvable, but | **no external buffer/Func read at all** — pure scalar arithmetic building a lookup curve | nothing to narrow a *region* for; condition 1 fails |
| `bgu:255` `select(c==i,exprs[i],e)` | solvable (equality on a pure channel Var) | `exprs[i]`/`e` are scalar polynomial-fit expressions, no differently-indexed buffer reads | condition 1 fails |
| `depthwise_separable_conv:41` `select(in_bounds, input(d,clamped_x,clamped_y,b), 0.0f)` | solvable (`in_bounds` derived from `x,y`) — **structurally the closest match to the distinguishing case** | `clamped_x = clamp(x,0,W-1)`, `clamped_y = clamp(y,0,H-1)` | condition 3 fails: the read is pre-clamped into a fixed safe range *regardless of which branch is taken*, so narrowing recovers nothing new. This is exactly, and independently, the site the earlier Experiment-2 pass already reported equivalent ("even the inferred input region doesn't move") — this experiment supplies the mechanism for *why* |
| `lens_blur:142` `select((...\|\|...) && ..., 1.0f, 0.0f)` | data-dependent boolean combination of computed Funcs | both branches are **float literals**, no buffer read either way | condition 1 fails outright |
| `max_filter:50` `select(x*x+dy*dy<..., 1, 0)` (inside `sum(...)`) | solvable but irrelevant | both branches are integer literals | condition 1 fails outright |

**None of the 13 real sites combine all three conditions.** The one site that comes
structurally closest (`depthwise_separable_conv:41`, a hand-written boundary condition —
exactly the shape you'd expect to trip this) is specifically immune because Halide
developers wrote it with clamped indices, which happens to also make it immune to this
bounds-narrowing effect. Everything else fails condition 1 or 2 outright: the corpus's
selects are almost all either data-dependent per-pixel picks between two Funcs read at
matching coordinates (no possible index-region difference regardless of eager/lazy), or
scalar-only expressions with no buffer read to narrow at all.

**Conclusion for the corpus.** The 0% kill rate is a genuine **corpus property**, not a
tooling gap and not evidence the mutation is inherently unobservable: `select → if_then_else`
*is* killable by a real, principled oracle (bounds-query assertions on required input
extent), but exploiting that requires a `select` whose condition is directly solvable on
the loop variable *and* whose branches are unclamped, differently-indexed reads — a shape
this corpus's Halide-idiomatic code doesn't happen to contain. **Recommended framing for
the paper: "blind on this corpus," with the corrected, empirically-grounded reason why —
not "structurally outside any correctness oracle."**

## Other candidates tried (per the task's priority order), and why they don't help

- **NaN/Inf-producing untaken branch** (`candidates_3_4.cpp`, Candidate 3):
  `select(x>=0, float(x), sqrt(-1.0f))` — no difference between forms, no NaN reaches
  the output either way. `select`/`if_then_else` both simply *return* the chosen
  branch's value; IEEE-754 NaN computation in the untaken branch doesn't trap and isn't
  combined with anything downstream, so eager vs. lazy is unobservable here regardless
  of corpus. Confirmed empirically, not just asserted.
- **Integer division by zero** (`candidates_3_4.cpp`, Candidate 4):
  `select(x!=0, 100/x, 100/0)` — identical output for both forms (`100/0` evaluates to
  `0` under Halide's total/safe integer division either way). Matches — and reconfirms —
  the prior agent's finding; not pursued further given the timebox.

## Files in this directory

- `bounds_oob.cpp` / `.output.txt` — the primary distinguishing case (single-branch-reachable domain): bounds query, `.stmt` dump, execution test, explicit pass/fail verdict.
- `bounds_span_both.cpp` / `.output.txt` — the both-branches-reachable domain variant; shows the gap does not close.
- `bounds_soundness_check.cpp` / `.output.txt` — follow-up probing whether trusting the (apparently too-small) declared bound from the both-branches case is actually safe at runtime (it is not: silent out-of-bounds read, no crash, no error).
- `candidates_3_4.cpp` / `.output.txt` — NaN/Inf and integer-div-by-zero candidates, both non-distinguishing.

All four programs are standalone (no Generator class, no Mull, no corpus dependency) —
plain Halide C++ using `Halide::Internal::Call::make(..., Call::if_then_else, ...,
Call::PureIntrinsic)` to hand-construct the mutant, following the working template
already validated in `mull-ps@wip-p` and `halide_src_rewrite`'s
`halide_select_to_if_then_else` operator (type must come from the *original select
expression's* `.type()`, per the `match_types` subtlety already documented in the plan).
Built/run on swsec01 against the already-built Halide v21/LLVM 20 stack at
`/dev/shm/ardi_dslmut/halide-build` (`libHalide.so`, `include/Halide.h`).
