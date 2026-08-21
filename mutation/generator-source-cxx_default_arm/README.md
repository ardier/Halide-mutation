# Arm B: stock `cxx_default` on generator *source* (not emitted/lowered C++)

Fills the gap identified 2026-08-21: the experiment design has three arms --
**A** (65-operator Halide-native set, IR+AST route), **B** (stock Mull
`cxx_default` mutators via `mull-cxx-frontend` directly on the generator's own
`.cpp`, which mixes real `Halide::Expr`-building code with plain host-language
C++ in the same file), **C** (stock `cxx_default` on the emitted/lowered C++,
see `../lowered-cpp/cxx_default_arm/`). Only Arm C had been scaled up before
this; Arm B had exactly one data point (`cxx_add_to_sub` alone on blur: 76
points, 100% in `Halide.h`). This directory extends Arm B to the full
`cxx_default` group across `blur`, `harris`, `camera_pipe` -- the last chosen
specifically because its generator has substantial plain-C++ helper-function
logic (`avg`/`blur121`/`interleave_x`/`interleave_y` as free functions, five
`CameraPipe::*` methods defined out-of-line, plus scalar schedule locals like
`int tile_x = 28;`), unlike blur/harris which are almost entirely
`generate()`-body DSL-expression building.

## Results

| Benchmark    | Total points | Halide-library | Halide-DSL | Plain-C++ |
|--------------|-------------:|----------------:|-----------:|----------:|
| blur         |           77 |     77 (100.0%) |   0 (0.0%) |  0 (0.0%) |
| harris       |           76 |     76 (100.0%) |   0 (0.0%) |  0 (0.0%) |
| camera_pipe  |           96 |     96 (100.0%) |   0 (0.0%) |  0 (0.0%) |
| **Total**    |      **249** | **249 (100.0%)**| **0 (0%)** | **0 (0%)**|

**All three benchmarks come back 100% Halide-library / 0% Halide-DSL / 0%
Plain-C++**, including camera_pipe, despite camera_pipe genuinely containing
the plain-C++ helper-function/schedule-parameter logic this arm was testing
for. See "Why the generator body is invisible to plain `cxx_default`" below
for the confirmed (not assumed) mechanism, and the diagnostics subsection for
evidence that the plain-C++ points are real and findable once that mechanism
is worked around, plus a distinct crash bug the workaround surfaced.

## Classification methodology (from the plan, not re-derived here)

For every mutation point found in a file that `#include`s `Halide.h`:

1. **Halide-library** -- the point's source location resolves inside a Halide
   header/library path (e.g. `build/include/Halide.h`), not the generator's
   own `.cpp`.
2. **Halide-DSL** -- in the generator's own file, and the mutated AST node's
   static type is a Halide DSL type (`Expr`, `Func`, `FuncRef`, `Var`, ...).
3. **Plain-C++** -- in the generator's own file, but the mutated node's type
   is an ordinary C++ type (`int`, `bool`, ...) -- loop counters,
   `GeneratorParam`/target-feature-driven conditionals, helper-function
   internals.

## How the points were found

One `-fsyntax-only` compile per generator TU through `mull-cxx-frontend`
(`mull-ps/tools/mull-cxx-frontend`, see `../../mull-ps/docs/linux-build.md`
section 4 for the base recipe), `mull.yml` in this directory selecting
`mutators: [cxx_default]` (the full stock group -- arithmetic, relational,
bitwise, compound-assignment, increment/decrement, negation, void-call
removal, scalar-call replacement, const-assign/init -- **not**
`halide_mutator`/`halide_boundary_conditions`/`halide_special_calls`, per
`mull-ps/lib/Mutators/MutatorsFactory.cpp`). `-fsyntax-only` is enough: the
plugin runs as a `PluginASTAction` during Sema, independent of whether codegen
happens after, so no object file or link step is needed just to enumerate and
classify mutation points (this is lighter than a full `-c` compile, kept
deliberately minimal per the "don't compete with the two heavy sweeps running
concurrently" resource constraint).

```sh
MULL_CONFIG=$PWD/mull.yml /usr/lib/llvm-14/bin/clang++ \
  -std=c++17 -fsyntax-only -g -grecord-command-line \
  -fplugin=<mull-ps>/output/libmull-cxx-frontend-14.so \
  -I <Halide-mutation>/build/include -I <Halide-mutation>/tools \
  -c apps/<app>/<generator>.cpp \
  > <app>_points.txt 2> <app>_points.err   # stdout/stderr MUST go to separate
                                            # files -- llvm::outs()/errs() are
                                            # unsynchronized buffered streams;
                                            # merging them with 2>&1 into one
                                            # file interleaves mid-line and
                                            # corrupts the parse (seen once,
                                            # re-run cleanly with separate fds)
```

The `"Recording mutation point: ..."` line this frontend already prints (see
`linux-build.md`) was extended with two fields
(`mull-ps@331e8d50`, `tools/mull-cxx-frontend/src/ASTMutationsSearchVisitor.cpp`,
`describeMutatedType()`) for exactly this classification: `TYPE:<type-string>`
and `HALIDE_TYPE:<0|1>`, the latter computed structurally (canonical type's
`CXXRecordDecl`'s enclosing namespace, reusing the existing
`isInsideHalideNamespace` helper already used by the Halide-native AST
mutators above it in the same file) rather than by string-matching, so it's
robust to typedefs and printing-policy namespace elision. Bucket 1 vs (2|3)
was already derivable from the pre-existing `sourceFilePath` field; this
instrumentation is what makes bucket 2 vs 3 possible without hand-inspecting
every point.

`classify.py <log> <generator_source_path> <out_csv>` parses the log and
prints the per-app summary table plus a CSV with a `bucket` column.

## Why the generator body is invisible to plain `cxx_default` (verified, not guessed)

**Headline finding: all three benchmarks come back 100% Halide-library / 0%
Halide-DSL / 0% Plain-C++.** Every one of blur's 77, harris's 76, and
camera_pipe's 96 mutation points lands inside `build/include/Halide.h`; none
land in any generator's own `.cpp`, camera_pipe included. This holds even
though camera_pipe's generator has exactly the plain-C++ helper-function
logic the task asked it to test for -- `int lutResample = 1;` /
`lutResample = 8;` inside `CameraPipe::apply_curve`, `int tile_x = 28;` /
`int vec = ...; vec = 64;` / `const int y_offset = 220;` inside
`CameraPipe::generate()`, an `if (lutResample == 1)` branch -- none of it
is ever reached by `mull-cxx-frontend` under a stock `cxx_default`
configuration. This is the real finding the plan's gap-fill anticipated as a
live possibility, confirmed empirically below rather than assumed.

**First (disproven) hypothesis, kept here because the disproof matters:**
initially assumed the split would be inline-vs-out-of-line method definitions
(inline methods parsed as part of their enclosing `CXXRecordDecl`, never
delivered to `HandleTopLevelDecl` as standalone `Decl::Function`s, vs.
free functions and out-of-line member definitions delivered individually
regardless of namespace nesting). **A minimal reproduction
(`diagnostics/minitest.cpp`) disproves this**: a free function
(`helper_free_function`), an inline method (`Foo::generate`), and an
out-of-line method (`Foo::generate2`) are **all three equally invisible**
to plain `cxx_default` when nested inside `namespace { ... }` --
`diagnostics/minitest_cxx_default_only.out` records exactly one mutation
point, in `top_level_free`, the one function truly outside any namespace.
`HandleTopLevelDecl` delivers an anonymous namespace's entire contents as
one `Decl::Namespace`-kind `DeclGroupRef`, not as individually-visited member
declarations -- so the mutating visitor never even inspects the *kind* of
declaration (free/inline/out-of-line) that's nested inside it; the whole
namespace is opaque unless something deliberately recurses into it. Since
every one of blur/harris/camera_pipe's generators wraps its entire body
(helper functions and the `Generator` subclass alike) in one top-level
anonymous `namespace { ... }`, this affects all three uniformly, which is
exactly what the data shows.

**The actual mechanism**: `cxx_default`'s members are **all**
`enabledByDefault = true` in `MutationMap`'s table, and
`needsDeepDeclTraversal()` -- the gate on `MullClangPlugin.cpp`'s
`mutateNestedFunctions`, this sprint's earlier fix for namespace/class-body
traversal -- only returns true when an *opt-in* (`enabledByDefault = false`)
mutator is active, i.e. only for `halide_boundary_conditions`/
`halide_special_calls`. **A pure `cxx_default` configuration can never
satisfy this condition, structurally, regardless of the target file's
content** -- not a benchmark-specific gap, an architectural one. This is a
real, reportable limitation of the current `mull-cxx-frontend`
configuration model, not a failure to find plain-C++ mutants that happen not
to exist: they do exist (see below), the frontend just never looks at the
file region they're in when configured this way.

### Diagnostic: forcing the traversal open confirms the plain-C++ points exist and are findable, but hits an unrelated pre-existing crash

To check whether the fix, if it *did* engage, would actually find the
plain-C++ points identified by inspection (`lutResample`, `tile_x`, `vec`,
`y_offset`, ...), `MutationMap::addMutation("cxx_default")` turns out **not**
to recognize `"cxx_default"` as a group name at all -- it's a name the AST
frontend's own `MUTATION_GROUPS` table doesn't define (only
`halide_boundary_conditions`/`halide_special_calls`/`halide_ast` are); a
config naming it silently no-ops, and the reason the main results above are
still correct is an accidental equivalence: an empty `usedMutatorSet` falls
back to every `enabledByDefault` mutator via
`setDefaultMutationsIfNotSpecified()`, which happens to equal the full
`cxx_default` set. That fallback only triggers on a genuinely empty set,
though, so it silently breaks the moment an opt-in group is added alongside
it in the same config (confirmed: `mutators: [cxx_default,
halide_boundary_conditions]` on camera_pipe finds deep traversal now
engaged -- 434 unique functions visited vs. 50 before -- but **zero**
mutation points anywhere, because only the 12 `halide_boundary_conditions`
identifiers actually made it into `usedMutatorSet`).

Working around this by listing all 42 `cxx_*` identifiers explicitly instead
of the group name (`diagnostics/mull_deep_explicit.yml`) alongside
`halide_boundary_conditions` (just to force `needsDeepDeclTraversal()` true)
confirms the traversal, once open, does find plain-C++ points in all three
shapes: on `minitest.cpp`
(`diagnostics/minitest_cxx_default_plus_deep_traversal.out`) it now finds
all 4 `int` initializations -- the free function's, the inline method's, the
out-of-line method's, and the true-top-level one's. On camera_pipe itself,
the same config **crashes the compiler (SIGSEGV, exit 139)** before reaching
any of the generator's own helper functions -- it was still deep-traversing
into Halide.h's own internal namespaces (last visited: `Halide.h:29020`)
when it died. The crash (full trace in
`diagnostics/camera_pipe_deep_traversal_crash_signature.txt`) is in
`ASTMutationsSearchVisitor::VisitVarDecl` calling
`D->getInit()->getExprLoc()` without checking `D->getInit()` for null --
crashes on any in-scope `int`/`float`/`double` `VarDecl` that is a
declaration without an initializer (e.g. `extern int x;`), which
`needsDeepDeclTraversal()` never used to expose at this scale (previously
only reachable through the narrow, call-site-scoped
`BoundaryConditions`/`select`/`clamp` visitors, not a blanket recursive walk
of every namespace and class Clang parses, including all of Halide.h's own
internals). **This is a distinct, previously-latent bug from the
`HandleTopLevelDecl` traversal fix itself** -- the fix's own logic is sound
(confirmed by the minitest success), but nothing scopes `mutateNestedFunctions`
to the user's own file, so once it's triggered by any opt-in mutator it also
walks the entirety of every included header, and Halide.h is large enough to
contain at least one uninitialized-declaration `VarDecl` that this null-deref
hits. Not fixed as part of this task (out of scope: this arm's job was
classification, not repairing the AST frontend further) -- flagged
separately.

**Bottom line for camera_pipe as the "contrast" benchmark**: the contrast
the task was testing for is real and confirmed to exist in the source
(camera_pipe unambiguously has plain-C++ helper-function/schedule-parameter
logic that blur/harris don't), and a forced/patched traversal does find that
exact shape of point on a small reproduction -- but under the literal,
as-specified "full `cxx_default` group" configuration this task asked for,
**zero** of it is reachable, for the structural `needsDeepDeclTraversal()`
reason above, not because the plain-C++ code isn't there.
