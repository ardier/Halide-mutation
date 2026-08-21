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

## Why `-fsyntax-only` and no HandleTopLevelDecl deep-traversal opt-in

`cxx_default`'s members are **all** `enabledByDefault = true` in
`MutationMap`'s table, and `needsDeepDeclTraversal()` only returns true when
an *opt-in* (`enabledByDefault = false`) mutator is active -- i.e. only for
the `halide_boundary_conditions`/`halide_special_calls` AST-route Halide
operators, never for plain `cxx_default`. This means `HandleTopLevelDecl`'s
earlier namespace/class-body traversal fix (`mull-ps`, 2026-08-21,
`MullClangPlugin::HandleTopLevelDecl`) is **not exercised by this arm at
all** -- a stock `cxx_default` run only ever sees genuinely top-level
declarations as Clang's parser delivers them one at a time, before any of
this sprint's deep-traversal code runs.

Concretely, whether a generator's helper code is visible to `cxx_default`
depends entirely on *how it's written*, not on any Mull-side fix:

- A method defined **inline inside a class body** (blur's and harris's
  `generate()`, `Demosaic::generate()` in camera_pipe) is parsed as part of
  the enclosing `CXXRecordDecl` and only reaches `HandleTopLevelDecl` as one
  `Decl::CXXRecord` -- individual inline methods are never separately
  delivered, so `cxx_default` cannot see inside them, deep-traversal fix or
  not.
- A **free function at namespace scope**, or a **member function defined
  out-of-line** (`Func CameraPipe::hot_pixel_suppression(...)`, `void
  CameraPipe::generate()` declared in-class but defined after), is delivered
  individually to `HandleTopLevelDecl` as `Decl::Function` by Clang's parser
  regardless of which namespace it lexically sits in -- reachable by plain
  `cxx_default` today, no fix needed.

camera_pipe happens to mix both styles (`Demosaic::generate()` inline and
therefore invisible to this arm; `CameraPipe::generate()` and its five helper
methods out-of-line and therefore visible), which is exactly what makes it
the right contrast benchmark -- see the results below and `SUMMARY.md`.
