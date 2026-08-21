// Same construction as bounds_oob.cpp, but with the OUTPUT/QUERY DOMAIN widened
// so that BOTH branches of the condition (x<10) are actually reachable within
// the query (x in [0,20) instead of [0,10)). This tests whether the
// select-vs-if_then_else bounds gap survives once both branches are genuinely
// exercised in-domain -- the shape that matches the corpus's data-dependent
// select sites (e.g. camera_pipe), where the query/image domain spans the
// entire condition's variability.
#include "Halide.h"
#include <cstdio>

using namespace Halide;
using Halide::Internal::Call;

static int real_main() {
    const int OFFSET = 100000;
    const int OUT_EXTENT = 20;  // spans x<10 AND x>=10
    Var x("x");

    ImageParam in_sel(Int(32), 1, "in_sel");
    Expr cond = (x < 10);
    Expr sel_expr = select(cond, in_sel(x), in_sel(x + OFFSET));
    Func f_select("f_select");
    f_select(x) = sel_expr;

    ImageParam in_ite(Int(32), 1, "in_ite");
    Expr a2 = in_ite(x), b2 = in_ite(x + OFFSET);
    Expr sel_expr2 = select(cond, a2, b2);
    Expr ite_expr = Call::make(sel_expr2.type(), Call::if_then_else,
                                {cond, cast(sel_expr2.type(), a2), cast(sel_expr2.type(), b2)},
                                Call::PureIntrinsic);
    Func f_ite("f_ite");
    f_ite(x) = ite_expr;

    f_select.compile_to_lowered_stmt("/tmp/f_select_span.stmt", {in_sel}, Text);
    f_ite.compile_to_lowered_stmt("/tmp/f_ite_span.stmt", {in_ite}, Text);

    f_select.infer_input_bounds({OUT_EXTENT});
    Buffer<int32_t> bs = in_sel.get();
    printf("domain x in [0,%d): select required range = [%d,%d) extent=%d\n",
           OUT_EXTENT, bs.dim(0).min(), bs.dim(0).min() + bs.dim(0).extent(), bs.dim(0).extent());

    f_ite.infer_input_bounds({OUT_EXTENT});
    Buffer<int32_t> bi = in_ite.get();
    printf("domain x in [0,%d): if_then_else required range = [%d,%d) extent=%d\n",
           OUT_EXTENT, bi.dim(0).min(), bi.dim(0).min() + bi.dim(0).extent(), bi.dim(0).extent());

    printf(bs.dim(0).extent() == bi.dim(0).extent() ? "SAME extent -> gap disappears once both branches are in-domain\n"
                                                     : "DIFFERENT extent -> gap survives even with both branches in-domain\n");
    return 0;
}

int main() {
    try { return real_main(); }
    catch (const Halide::Error &e) { printf("HALIDE ERROR: %s\n", e.what()); return 1; }
}
