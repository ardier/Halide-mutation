// Candidate 1+2: select vs if_then_else, condition = solvable inequality directly
// on the pure loop Var, branches read genuinely disjoint index ranges of an
// external input buffer (one branch deliberately far out of range of the other).
//
// Tests, for BOTH the eager `select` form (the mutation OPERATOR'S ORIGINAL) and
// the hand-built lazy `if_then_else` form (the MUTANT):
//   1. required input bounds via Halide's own bounds-query machinery
//      (Func::infer_input_bounds) -- this is the "does bounds inference narrow
//      the region Halide demands of the input" oracle from the task.
//   2. the emitted .stmt for each.
//   3. whether an actual realize() succeeds or throws, when given a buffer sized
//      to exactly the SMALL (lazy-only) requirement.
//
// Construction of the if_then_else form follows the working template recorded in
// the thesis-plan (`mull-ps@wip-p`, and halide_src_rewrite's
// halide_select_to_if_then_else operator template):
//   Halide::Internal::Call::make(
//       (SELECT_EXPR).type(), Halide::Internal::Call::if_then_else,
//       {cond, cast(t, a), cast(t, b)}, Halide::Internal::Call::PureIntrinsic)
// using the ORIGINAL select expression's own .type() (match_types is not
// derivable from either branch alone).

#include "Halide.h"
#include <cstdio>
#include <stdexcept>

using namespace Halide;
using Halide::Internal::Call;

static void dump_stmt(Func f, const std::vector<Argument> &args, const std::string &path) {
    f.compile_to_lowered_stmt(path, args, Text);
}

static int real_main();

int main() {
    try {
        return real_main();
    } catch (const Halide::Error &e) {
        printf("UNCAUGHT HALIDE ERROR: %s\n", e.what());
        return 1;
    } catch (const std::exception &e) {
        printf("UNCAUGHT EXCEPTION: %s\n", e.what());
        return 1;
    }
}

static int real_main() {
    const int OFFSET = 100000;   // far out-of-range offset for the "else" branch
    const int OUT_EXTENT = 10;   // output/query domain: x in [0, 10)
    Var x("x");

    // ---------- SELECT form (the mutation operator's ORIGINAL) ----------
    ImageParam in_sel(Int(32), 1, "in_sel");
    Expr cond = (x < 10);
    Expr a = in_sel(x);
    Expr b = in_sel(x + OFFSET);
    Expr sel_expr = select(cond, a, b);
    Func f_select("f_select");
    f_select(x) = sel_expr;

    // ---------- hand-built IF_THEN_ELSE form (the MUTANT) ----------
    ImageParam in_ite(Int(32), 1, "in_ite");
    Expr cond2 = (x < 10);
    Expr a2 = in_ite(x);
    Expr b2 = in_ite(x + OFFSET);
    Expr sel_expr2 = select(cond2, a2, b2);  // built only to obtain .type() per the plan's noted subtlety
    Expr ite_expr = Call::make(sel_expr2.type(), Call::if_then_else,
                                {cond2, cast(sel_expr2.type(), a2), cast(sel_expr2.type(), b2)},
                                Call::PureIntrinsic);
    Func f_ite("f_ite");
    f_ite(x) = ite_expr;

    printf("=== .stmt dump ===\n");
    dump_stmt(f_select, {in_sel}, "/tmp/f_select.stmt");
    dump_stmt(f_ite, {in_ite}, "/tmp/f_ite.stmt");
    printf("wrote /tmp/f_select.stmt and /tmp/f_ite.stmt\n\n");

    // ---------- bounds query: what does each form DEMAND of the input? ----------
    printf("=== bounds query, output domain x in [0,%d) ===\n", OUT_EXTENT);
    {
        f_select.infer_input_bounds({OUT_EXTENT});
        Buffer<int32_t> buf = in_sel.get();
        printf("select    : in_sel required range = [%d, %d)  (extent %d)\n",
               buf.dim(0).min(), buf.dim(0).min() + buf.dim(0).extent(), buf.dim(0).extent());
    }
    {
        f_ite.infer_input_bounds({OUT_EXTENT});
        Buffer<int32_t> buf = in_ite.get();
        printf("if_then_else: in_ite required range = [%d, %d)  (extent %d)\n",
               buf.dim(0).min(), buf.dim(0).min() + buf.dim(0).extent(), buf.dim(0).extent());
    }

    // ---------- the actual test: assert on ORIGINAL's (select's) declared bounds,
    //            then run the identical assertion against the MUTANT ----------
    printf("\n=== oracle: assert required extent covers the union of BOTH branches ===\n");
    // A test author, having examined the ORIGINAL (eager select) program, would
    // reasonably expect/assert that Halide requires input covering both the
    // low range [0,10) AND the offset range [100000,100010), since eager
    // evaluation touches both regions unconditionally for every output pixel.
    bool select_pass, ite_pass;
    {
        f_select.infer_input_bounds({OUT_EXTENT});
        Buffer<int32_t> buf = in_sel.get();
        int lo = buf.dim(0).min();
        int ext = buf.dim(0).extent();
        // expected: covers [0,10) and [100000,100010) => min<=0, max>=100009 => extent >= 100010
        select_pass = (lo <= 0) && (ext >= OFFSET + OUT_EXTENT);
        printf("test on ORIGINAL (select)      : required extent=%d -> %s\n",
               ext, select_pass ? "PASS (matches eager expectation)" : "FAIL");
    }
    {
        f_ite.infer_input_bounds({OUT_EXTENT});
        Buffer<int32_t> buf = in_ite.get();
        int lo = buf.dim(0).min();
        int ext = buf.dim(0).extent();
        ite_pass = (lo <= 0) && (ext >= OFFSET + OUT_EXTENT);
        printf("same test on MUTANT (if_then_else): required extent=%d -> %s\n",
               ext, ite_pass ? "PASS" : "FAIL (mutant needs far less input)");
    }

    printf("\n=== VERDICT ===\n");
    if (select_pass && !ite_pass) {
        printf("DISTINGUISHING: test passes on original, fails on mutant.\n");
    } else {
        printf("NOT distinguishing under this oracle (select_pass=%d ite_pass=%d)\n",
               select_pass, ite_pass);
    }

    // ---------- execution test: realize with a buffer sized to the SMALL
    //            (lazy-only) requirement; see which form tolerates it ----------
    printf("\n=== execution test: realize with buffer sized to the LAZY-only extent [0,%d) ===\n", OUT_EXTENT);
    {
        Buffer<int32_t> small(OUT_EXTENT);
        small.set_min(0);
        for (int i = 0; i < OUT_EXTENT; i++) small(i) = 1000 + i;
        in_ite.set(small);
        try {
            Buffer<int32_t> out = f_ite.realize({OUT_EXTENT});
            printf("if_then_else (mutant)  realize() with small buffer: SUCCEEDED, out(0..%d)=",
                   OUT_EXTENT - 1);
            for (int i = 0; i < OUT_EXTENT; i++) printf("%d ", out(i));
            printf("\n");
        } catch (const Halide::Error &e) {
            printf("if_then_else (mutant)  realize() with small buffer: THREW: %s\n", e.what());
        }
    }
    {
        Buffer<int32_t> small(OUT_EXTENT);
        small.set_min(0);
        for (int i = 0; i < OUT_EXTENT; i++) small(i) = 1000 + i;
        in_sel.set(small);
        try {
            Buffer<int32_t> out = f_select.realize({OUT_EXTENT});
            printf("select (original)      realize() with small buffer: SUCCEEDED, out(0..%d)=",
                   OUT_EXTENT - 1);
            for (int i = 0; i < OUT_EXTENT; i++) printf("%d ", out(i));
            printf("\n");
        } catch (const Halide::Error &e) {
            printf("select (original)      realize() with small buffer: THREW: %s\n", e.what());
        }
    }

    return 0;
}
