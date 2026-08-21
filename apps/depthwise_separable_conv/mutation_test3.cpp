// Third targeted test for depthwise_separable_conv, added for the mutation
// study. This one targets the schedule-directive family, not arithmetic.
//
// Why a third test. mutation_test.cpp and mutation_test2.cpp both feed small
// integer-valued floats, deliberately, so that every partial sum is exactly
// representable and Halide's choice of accumulation order cannot affect the
// result. That is the right design for checking *what* the pipeline computes --
// but it makes those tests structurally blind to the one way a schedule
// directive can change a result at all: reassociating a floating-point
// reduction.
//
// It matters here because this benchmark saves no output artifact, so the
// golden-output oracle degenerates to the driver's stdout and has never
// compared a single output value for any of its 33 surviving schedule mutants.
// Ten schedule mutants elsewhere in the corpus were killed by exactly this --
// byte-comparison of a saved image after a vectorize/unroll/parallel swap -- so
// this is applying the corpus's existing oracle uniformly, not inventing a
// stricter one for this app.
//
// The design is the mirror image of the first two tests: inputs spanning a wide
// exponent range, so the pointwise reduction's partial sums genuinely depend on
// the order they are accumulated in, and a raw bit-level dump of the output for
// the oracle to compare. The test also verifies its own premise -- that summing
// these terms in two different orders really does give different floats -- so a
// silent loss of sensitivity shows up as a failure rather than as a pass.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <vector>

#include "HalideBuffer.h"

#include "depthwise_separable_conv.h"
#include "depthwise_separable_conv_auto_schedule.h"

using namespace Halide::Runtime;

static const int N = 1, CI = 32, CO = 16, CM = 1, W = 16, H = 16;
static const int KW = 3, KH = 3;

static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %g, expected %g\n", what, got, want);
    failures++;
}

// Wide-exponent values: a few very large terms among many small ones is the
// classic configuration in which floating-point addition is not associative.
static float spread(uint32_t &s, int idx) {
    s = s * 1664525u + 1013904223u;
    float mant = 1.0f + (float)((s >> 16) % 1000u) / 1000.0f;
    // Exponents cycle over a ~14-decade range.
    static const int exps[7] = {7, -3, 5, -6, 2, -1, 6};
    int e = exps[idx % 7];
    return mant * std::pow(10.0f, (float)e) * (((s >> 8) & 1u) ? 1.0f : -1.0f);
}

int main(int argc, char **argv) {
    Buffer<float, 4> input(CI, W, H, N);
    Buffer<float, 4> depthwise_filter(CM, CI, KW, KH);
    Buffer<float, 2> pointwise_filter(CO, CI * CM);
    Buffer<float, 1> bias(CO);

    uint32_t s = 31337u;
    int k = 0;
    for (int b = 0; b < N; b++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++)
                for (int d = 0; d < CI; d++) input(d, x, y, b) = spread(s, k++);
    for (int ky = 0; ky < KH; ky++)
        for (int kx = 0; kx < KW; kx++)
            for (int c = 0; c < CI; c++)
                for (int m = 0; m < CM; m++) depthwise_filter(m, c, kx, ky) = spread(s, k++);
    for (int c = 0; c < CI * CM; c++)
        for (int o = 0; o < CO; o++) pointwise_filter(o, c) = spread(s, k++);
    for (int o = 0; o < CO; o++) bias(o) = spread(s, k++);

    // ---- premise check --------------------------------------------------
    // The test claims to be sensitive to accumulation order. Demonstrate it on
    // the same numbers the pipeline will see, rather than assuming it: sum one
    // pointwise reduction forwards and backwards and require the two floats to
    // differ. If they ever stop differing, this test has quietly become blind
    // and that is a failure, not a pass.
    {
        float fwd = bias(0), rev = 0.0f;
        for (int rc = 0; rc < CI * CM; rc++) fwd += pointwise_filter(0, rc);
        for (int rc = CI * CM - 1; rc >= 0; rc--) rev += pointwise_filter(0, rc);
        rev += bias(0);
        if (fwd == rev) {
            fail("inputs are not order-sensitive; this test cannot see a "
                 "reassociated reduction", fwd, rev);
        } else {
            printf("order sensitivity: forward %.9g vs reverse %.9g\n", fwd, rev);
        }
    }

    Buffer<float, 4> out(CO, W, H, N);
    out.fill(0.f);
    int err = depthwise_separable_conv(input, depthwise_filter, pointwise_filter, bias, out);
    if (err != 0) fail("pipeline returned an error", err, 0);

    long finite = 0, total = 0, nonzero = 0;
    for (int b = 0; b < N; b++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++)
                for (int d = 0; d < CO; d++) {
                    float v = out(d, x, y, b);
                    total++;
                    if (std::isfinite(v)) finite++;
                    if (v != 0.f) nonzero++;
                }
    // Overflow to inf would make every mutant's output identically inf and the
    // comparison vacuous; the exponent range above is chosen to stay clear of
    // that, and this pins it.
    if (finite != total) fail("output contains non-finite values", (double)finite, (double)total);
    if (nonzero * 4 < total) fail("output is mostly zero after the ReLU", (double)nonzero, (double)total / 4);
    printf("%ld/%ld outputs finite, %ld above the ReLU floor\n", finite, total, nonzero);

    // ---- artifact for the golden-output oracle --------------------------
    // Raw IEEE bits: any reassociation of the reduction shows up here even when
    // it is only a one-ulp difference.
    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) {
            fail("could not open out.bin", 0, 1);
        } else {
            std::vector<float> flat((size_t)CO * W * H * N);
            size_t i = 0;
            for (int b = 0; b < N; b++)
                for (int y = 0; y < H; y++)
                    for (int x = 0; x < W; x++)
                        for (int d = 0; d < CO; d++) flat[i++] = out(d, x, y, b);
            fwrite(flat.data(), sizeof(float), flat.size(), f);
            fclose(f);
        }
    }

    if (failures) {
        printf("mutation_test3: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test3: OK\n");
    return 0;
}
