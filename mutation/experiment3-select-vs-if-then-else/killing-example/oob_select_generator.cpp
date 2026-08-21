// Minimal Halide Generator exhibiting the select-vs-if_then_else distinguishing
// shape: a select() whose condition is a solvable inequality directly on the pure
// loop Var, with branches reading genuinely disjoint index ranges of the input.
//
// Compile WITHOUT -DMUTANT_IF_THEN_ELSE to get the ORIGINAL (eager `select`).
// Compile WITH    -DMUTANT_IF_THEN_ELSE to get the MUTANT (lazy `if_then_else`),
// built via the exact template already validated for the real
// `select -> if_then_else` mutation operator (mull-ps@wip-p /
// halide_src_rewrite's halide_select_to_if_then_else): the type must come from
// the ORIGINAL select expression's own .type() (Halide::match_types is not
// derivable from either branch alone).
//
// The only difference between the two build modes is the single generate()
// body below -- see README.md for the exact diff and the killing test.

#include "Halide.h"
#include <cstdio>

namespace {

class OobSelectDemo : public Halide::Generator<OobSelectDemo> {
public:
    Input<Buffer<int32_t, 1>> in{"in"};
    Output<Buffer<int32_t, 1>> out{"out"};

    void generate() {
        using namespace Halide;
        Var x("x");
        Expr cond = x < 10;
        Expr a = in(x);
        Expr b = in(x + 100000);

#ifdef MUTANT_IF_THEN_ELSE
        Expr sel = select(cond, a, b);  // only to obtain .type(), per the operator's documented subtlety
        out(x) = Halide::Internal::Call::make(
            sel.type(), Halide::Internal::Call::if_then_else,
            {cond, Halide::cast(sel.type(), a), Halide::cast(sel.type(), b)},
            Halide::Internal::Call::PureIntrinsic);
#else
        out(x) = select(cond, a, b);
#endif
    }
};

}  // namespace

// --- Killing test driver (identical for both build modes) ---
//
// A test author who reads the ORIGINAL (eager select) program can correctly
// derive: "select evaluates both branches for every output pixel, so this
// generator requires input covering [0,10) (the direct-index branch) AND
// [100000,100010) (the offset branch) -- i.e. required extent >= 100010."
// That assertion is written once, independent of which form is actually being
// compiled, and run unchanged against both.
int main() {
    using namespace Halide;

    Target target = get_jit_target_from_environment();
    GeneratorContext ctx(target);
    auto gen = OobSelectDemo::create(ctx);
    // Generator<T> re-declares build_pipeline()/input_parameter() as protected;
    // they are public on the AbstractGenerator interface it implements, so call
    // through that interface.
    Halide::Internal::AbstractGenerator &agen = *gen;
    Pipeline p = agen.build_pipeline();

    const int OUT_EXTENT = 10;
    const int OFFSET = 100000;

    p.infer_input_bounds({OUT_EXTENT});
    std::vector<Parameter> in_params = agen.input_parameter("in");
    Buffer<> raw = in_params[0].buffer();
    int lo = raw.dim(0).min();
    int ext = raw.dim(0).extent();

    printf("required input extent (bounds query) = [%d, %d), extent=%d\n", lo, lo + ext, ext);

    bool test_passes = (lo <= 0) && (ext >= OFFSET + OUT_EXTENT);

#ifdef MUTANT_IF_THEN_ELSE
    printf("build = MUTANT (if_then_else)\n");
#else
    printf("build = ORIGINAL (select)\n");
#endif
    printf("test 'required extent covers both branches (>= %d)': %s\n",
           OFFSET + OUT_EXTENT, test_passes ? "PASS" : "FAIL");

    // Exit code doubles as the test verdict: 0 = PASS, 1 = FAIL.
    return test_passes ? 0 : 1;
}
