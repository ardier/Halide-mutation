// Follow-up to bounds_span_both.cpp's surprising result: with output domain
// x in [0,20) (spanning BOTH branches of `x<10`), if_then_else's *declared*
// required input extent was only 10 -- apparently omitting the else-branch's
// read of in_ite[x+100000] for x in [10,20) entirely. This checks what
// actually happens at runtime if you trust that declared bound: allocate
// EXACTLY a 10-element buffer (matching Halide's own infer_input_bounds
// answer) and really realize({20}). Does Halide's own runtime bounds
// assertion catch the mismatch (safe), or does it read out of bounds
// silently (a genuine soundness bug, independent of the mutation-testing
// question)?
#include "Halide.h"
#include <cstdio>

using namespace Halide;
using Halide::Internal::Call;

static int real_main() {
    const int OFFSET = 100000;
    const int OUT_EXTENT = 20;
    Var x("x");

    ImageParam in_ite(Int(32), 1, "in_ite");
    Expr cond = (x < 10);
    Expr a2 = in_ite(x), b2 = in_ite(x + OFFSET);
    Expr sel_expr2 = select(cond, a2, b2);
    Expr ite_expr = Call::make(sel_expr2.type(), Call::if_then_else,
                                {cond, cast(sel_expr2.type(), a2), cast(sel_expr2.type(), b2)},
                                Call::PureIntrinsic);
    Func f_ite("f_ite");
    f_ite(x) = ite_expr;

    // Step 1: ask Halide what it thinks it needs.
    f_ite.infer_input_bounds({OUT_EXTENT});
    Buffer<int32_t> declared = in_ite.get();
    int decl_min = declared.dim(0).min(), decl_ext = declared.dim(0).extent();
    printf("Halide's own infer_input_bounds says: in_ite needs [%d,%d) extent=%d\n",
           decl_min, decl_min + decl_ext, decl_ext);

    // Step 2: allocate EXACTLY that, fill with a sentinel, and really realize.
    Buffer<int32_t> buf(decl_ext);
    buf.set_min(decl_min);
    for (int i = 0; i < decl_ext; i++) buf(decl_min + i) = 111111 + i;
    in_ite.set(buf);

    printf("Realizing f_ite over x in [0,%d) with EXACTLY that buffer...\n", OUT_EXTENT);
    try {
        Buffer<int32_t> out = f_ite.realize({OUT_EXTENT});
        printf("realize() SUCCEEDED (no crash, no assertion). out = ");
        for (int i = 0; i < OUT_EXTENT; i++) printf("%d ", out(i));
        printf("\n");
        printf("-> for x>=10 (else branch), output should be in_ite(x+100000), which is\n");
        printf("   OUTSIDE the declared/allocated buffer. If those values look like plausible\n");
        printf("   garbage/reused-memory rather than a clean crash, that's a soundness gap.\n");
    } catch (const Halide::Error &e) {
        printf("realize() THREW (Halide's runtime caught it despite the bad declared bound): %s\n", e.what());
    }
    return 0;
}

int main() {
    try { return real_main(); }
    catch (const Halide::Error &e) { printf("HALIDE ERROR: %s\n", e.what()); return 1; }
}
