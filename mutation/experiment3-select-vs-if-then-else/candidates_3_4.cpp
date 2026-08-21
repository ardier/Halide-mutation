// Candidate 3: NaN/Inf-producing branch -- does the untaken branch's NaN ever
// reach the output, or is it always cleanly discarded by select() choosing the
// other value?
// Candidate 4: integer division by zero in the untaken branch -- does Halide's
// (documented-safe) integer division avoid a crash either way?
#include "Halide.h"
#include <cstdio>
#include <cmath>

using namespace Halide;
using Halide::Internal::Call;

static Expr make_ite(Expr cond, Expr a, Expr b) {
    Expr sel = select(cond, a, b);
    return Call::make(sel.type(), Call::if_then_else,
                       {cond, cast(sel.type(), a), cast(sel.type(), b)},
                       Call::PureIntrinsic);
}

static int real_main() {
    Var x("x");

    printf("=== Candidate 3: NaN-producing untaken branch (sqrt of negative) ===\n");
    {
        // f(x) = select(x >= 0, float(x), sqrt(-1.0f))  -- for all x in [0,10), cond is always true,
        // so the sqrt(-1) branch is never the "chosen" value, but is it ever computed and does it leak?
        Expr cond = (x >= 0);
        Expr a = cast<float>(x);
        Expr b = sqrt(cast<float>(-1.0f));

        Func f_sel("f_sel3"), f_ite("f_ite3");
        f_sel(x) = select(cond, a, b);
        f_ite(x) = make_ite(cond, a, b);

        Buffer<float> out_sel = f_sel.realize({10});
        Buffer<float> out_ite = f_ite.realize({10});
        bool any_nan_sel = false, any_nan_ite = false;
        for (int i = 0; i < 10; i++) {
            if (std::isnan(out_sel(i))) any_nan_sel = true;
            if (std::isnan(out_ite(i))) any_nan_ite = true;
        }
        printf("select    : out = ");
        for (int i = 0; i < 10; i++) printf("%.1f ", out_sel(i));
        printf(" | any NaN: %s\n", any_nan_sel ? "YES" : "no");
        printf("if_then_else: out = ");
        for (int i = 0; i < 10; i++) printf("%.1f ", out_ite(i));
        printf(" | any NaN: %s\n", any_nan_ite ? "YES" : "no");
        printf("-> %s\n\n", (any_nan_sel == any_nan_ite) ? "SAME (no distinguishing value difference)"
                                                            : "DIFFERENT (distinguishing!)");
    }

    printf("=== Candidate 4: integer division by zero in untaken branch ===\n");
    {
        // f(x) = select(x != 0, 100 / x, 100 / 0)   -- for x in [1,10), the x!=0 branch is always
        // taken, but does eager select's unconditional evaluation of 100/0 crash or misbehave?
        Expr cond = (x != 0);
        Expr a = 100 / x;
        Expr b = Expr(100) / Expr(0);  // force Halide Expr division, not plain C++ int division (UB/SIGFPE at the C++ level)

        Func f_sel("f_sel4"), f_ite("f_ite4");
        f_sel(x) = select(cond, a, b);
        f_ite(x) = make_ite(cond, a, b);

        try {
            Buffer<int32_t> out_sel = f_sel.realize({10}); // x in [0,10); x=0 hits cond false -> uses b=100/0 there deliberately
            printf("select    : out = ");
            for (int i = 0; i < 10; i++) printf("%d ", out_sel(i));
            printf("\n");
        } catch (const Halide::Error &e) {
            printf("select    : THREW: %s\n", e.what());
        }
        try {
            Buffer<int32_t> out_ite = f_ite.realize({10});
            printf("if_then_else: out = ");
            for (int i = 0; i < 10; i++) printf("%d ", out_ite(i));
            printf("\n");
        } catch (const Halide::Error &e) {
            printf("if_then_else: THREW: %s\n", e.what());
        }
    }

    return 0;
}

int main() {
    try { return real_main(); }
    catch (const Halide::Error &e) { printf("HALIDE ERROR: %s\n", e.what()); return 1; }
}
