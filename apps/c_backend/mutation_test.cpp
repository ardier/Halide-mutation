// Targeted correctness test added for the mutation study (Experiment 2).
//
// NOT a replacement for the app's shipped run.cpp -- that file is left exactly
// as upstream ships it. This is an additional driver, linked against the same
// generated pipeline, that exists to close a specific oracle gap.
//
// The gap: run.cpp's only check is a *differential* one -- it runs the same
// pipeline through the LLVM backend and through the C backend and compares the
// two. Both copies are emitted by the same generator invocation, so a mutation
// in the generator changes both sides identically and cancels out; and even
// when the two disagree run.cpp only prints, it still exits 0. The result is
// that c_backend has no oracle at all with respect to generator mutation.
//
// What this test does instead: recomputes the pipeline in plain C++, with the
// same integer types Halide uses, and asserts agreement -- over two input
// regimes, because the app's own full-range uint16 input drives most output
// pixels into the max(0, ...) floor, where the pipeline is insensitive to
// almost everything. It then probes the two clamp() calls directly, since those
// are the constructs the surviving mutants rewrite.

#include <cassert>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "pipeline_c.h"
#include "pipeline_native.h"

using namespace Halide::Runtime;

extern "C" int an_extern_func(int x, int y) {
    return x + y;
}

extern "C" int an_extern_stage(halide_buffer_t *in, halide_buffer_t *out) {
    if (in->is_bounds_query()) {
        in->dim[0].extent = 10;
        in->dim[1].extent = 10;
        in->dim[0].min = 0;
        in->dim[1].min = 0;
    } else {
        assert(out->host);
        int result = 0;
        int16_t *origin = (int16_t *)in->host;
        origin -= in->dim[0].min * in->dim[0].stride;
        origin -= in->dim[1].min * in->dim[1].stride;
        for (int y = 0; y < 10; y++) {
            for (int x = 0; x < 10; x++) {
                result += origin[x * in->dim[0].stride + y * in->dim[1].stride];
            }
        }
        int16_t *dst = (int16_t *)(out->host);
        dst[0] = result;
    }
    return 0;
}

static const int W = 1432, H = 324;
static const int OW = 423, OH = 633;
static const int FN = OH;  // f is needed over [0, FN) in both dims

static int failures = 0;

static void fail(const char *what, int x, int y, long long got, long long want) {
    if (failures < 10) {
        printf("FAIL %s at (%d, %d): got %lld, expected %lld\n",
               what, x, y, got, want);
    }
    failures++;
}

// Halide clamps with min(max(v, lo), hi); spelled out rather than using
// std::clamp so the *order* of the bounds is explicit -- that order is exactly
// what the surviving mutants swap.
static int hclamp(int v, int lo, int hi) {
    int t = v > lo ? v : lo;
    return t < hi ? t : hi;
}

static void fill(Buffer<uint16_t, 2> &in, uint32_t seed, int modulus) {
    uint32_t s = seed;
    for (int y = 0; y < in.height(); y++) {
        for (int x = 0; x < in.width(); x++) {
            s = s * 1664525u + 1013904223u;
            uint32_t v = s >> 16;
            in(x, y) = (uint16_t)(modulus ? v % (uint32_t)modulus : v);
        }
    }
}

// f(x, y) = (input(clamp(x + 2, 0, W - 1), clamp(y - 2, 0, H - 1)) * 17) / 13,
// in uint16 throughout, matching Halide's promotion of `uint16 Expr * int`.
static void reference(const Buffer<uint16_t, 2> &in, std::vector<uint16_t> &f,
                      std::vector<uint16_t> &out) {
    f.assign((size_t)FN * FN, 0);
    for (int y = 0; y < FN; y++) {
        for (int x = 0; x < FN; x++) {
            uint16_t v = in(hclamp(x + 2, 0, W - 1), hclamp(y - 2, 0, H - 1));
            f[(size_t)y * FN + x] = (uint16_t)((uint16_t)(v * 17) / 13);
        }
    }
    int hsum = 0;
    for (int y = 0; y < 10; y++) {
        for (int x = 0; x < 10; x++) {
            hsum += (int16_t)f[(size_t)y * FN + x];
        }
    }
    const int16_t h_value = (int16_t)hsum;

    out.assign((size_t)OW * OH, 0);
    for (int y = 0; y < OH; y++) {
        for (int x = 0; x < OW; x++) {
            uint16_t sum16 = (uint16_t)(f[(size_t)x * FN + y] +   // f(y, x)
                                        f[(size_t)y * FN + x]);   // f(x, y)
            int32_t acc = (int32_t)sum16 + (x + y) + (int32_t)h_value;
            if (acc < 0) acc = 0;
            out[(size_t)y * OW + x] = (uint16_t)acc;
        }
    }
}

// Compare the pipeline against the reference for one input. Returns the number
// of output pixels that are not sitting on the max(0, ...) floor, which is how
// much of the output actually carries information for this input.
static long check_case(const char *label, uint32_t seed, int modulus) {
    Buffer<uint16_t, 2> in(W, H);
    fill(in, seed, modulus);

    std::vector<uint16_t> f, want;
    reference(in, f, want);

    Buffer<uint16_t, 2> out_native(OW, OH), out_c(OW, OH);
    pipeline_native(in, out_native);
    pipeline_c(in, out_c);

    long live = 0;
    for (int y = 0; y < OH; y++) {
        for (int x = 0; x < OW; x++) {
            uint16_t w = want[(size_t)y * OW + x];
            if (w != 0) live++;
            if (out_native(x, y) != w) fail("pipeline_native", x, y, out_native(x, y), w);
            if (out_c(x, y) != w) fail("pipeline_c", x, y, out_c(x, y), w);
        }
    }
    printf("%s: %ld/%d output pixels above the max(0,..) floor\n",
           label, live, OW * OH);
    return live;
}

int main(int argc, char **argv) {
    // Regime 1: the app's own full-range uint16 input. Exercises the uint16
    // wraparound in `* 17` and in `f(y,x) + f(x,y)`.
    check_case("full-range", 12345u, 0);

    // Regime 2: small values, so nothing wraps and no output pixel lands on the
    // max(0, ...) floor. This is the regime with a live oracle at every pixel.
    long live = check_case("small-range", 6789u, 200);
    if (live < OW * (long)OH) {
        fail("small-range regime should saturate nothing", 0, 0, live,
             OW * (long)OH);
    }

    // ---- direct probes of the two clamp() calls -------------------------
    // f(x, y) reads input(clamp(x + 2, 0, W - 1), clamp(y - 2, 0, H - 1)).
    // Neither clamp is the identity over the range f is evaluated on, so the
    // output must genuinely depend on the input pixel each clamp selects.
    // Swapping a clamp's bounds collapses it to a constant
    // (min(max(v, hi), lo) == lo whenever lo < hi), severing that dependence --
    // a property no amount of comparing two equally-mutated backends can see.
    Buffer<uint16_t, 2> in(W, H);
    fill(in, 6789u, 200);
    Buffer<uint16_t, 2> base(OW, OH);
    pipeline_native(in, base);

    {
        // Perturb exactly the input pixel that f(px, py) is supposed to read.
        // Chosen interior, and outside the 10x10 box the extern stage sums, so
        // the effect has to arrive through the clamps and not through h().
        const int px = 300, py = 102;
        Buffer<uint16_t, 2> in2(W, H);
        in2.copy_from(in);
        in2(px + 2, py - 2) = (uint16_t)((in(px + 2, py - 2) + 97) % 200);
        Buffer<uint16_t, 2> out2(OW, OH);
        pipeline_native(in2, out2);
        if (out2(px, py) == base(px, py)) {
            fail("clamp dependence: output ignores its own input pixel",
                 px, py, out2(px, py), base(px, py));
        }
    }
    {
        // Rows y = 0 and y = 1 both clamp to input row 0, so perturbing row 0
        // has to move both -- this pins the *lower* bound of the y clamp, which
        // is the argument a bounds swap moves to the far side.
        Buffer<uint16_t, 2> in3(W, H);
        in3.copy_from(in);
        for (int x = 0; x < W; x++) in3(x, 0) = (uint16_t)((in(x, 0) + 97) % 200);
        Buffer<uint16_t, 2> out3(OW, OH);
        pipeline_native(in3, out3);
        int moved0 = 0, moved1 = 0;
        for (int x = 100; x < 160; x++) {
            if (out3(x, 0) != base(x, 0)) moved0++;
            if (out3(x, 1) != base(x, 1)) moved1++;
        }
        if (moved0 < 55 || moved1 < 55) {
            fail("y clamp lower bound: rows 0 and 1 do not track input row 0",
                 0, 0, moved0 * 1000 + moved1, 60 * 1000 + 60);
        }
    }

    if (failures) {
        printf("mutation_test: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test: OK\n");
    return 0;
}
