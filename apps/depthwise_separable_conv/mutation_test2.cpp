// Second targeted test for depthwise_separable_conv, added for the mutation
// study.
//
// mutation_test.cpp took this benchmark from a driver that checks nothing to an
// exact reference comparison. Three arithmetic mutants survived it, and all
// three survived for the same reason: they are equivalent *at the one tensor
// shape the test used*, not equivalent in general.
//
//   line 48:59  pad_width  = depthwise_filter.dim(2).extent() / 2   ->  ... - 2
//   line 49:60  pad_height = depthwise_filter.dim(3).extent() / 2   ->  ... - 2
//        With a 3x3 depthwise filter, 3 / 2 == 1 and 3 - 2 == 1. The mutation is
//        invisible at 3x3 (and at 4x4). At 5x5 it is 2 versus 3.
//
//   line 59:29  input_bounded(d / channel_multiplier, ...)          ->  d * ...
//        channel_multiplier is depthwise_filter.dim(0).extent(). The app, and
//        the first test, use a multiplier of 1, where d / 1 == d * 1 exactly.
//        At a multiplier of 2 the two disagree everywhere.
//
// So this test changes only the shape: a 5x5 depthwise filter and a channel
// multiplier of 2. The pipeline logic, the reference and the exactness argument
// are the same as in the first test -- small integer-valued floats, so every
// partial sum is exactly representable and Halide's accumulation order cannot
// matter.
//
// Note on shapes: the generator sums the depthwise filter over the multiplier
// axis while indexing depthwise_filter(rd, d, ...) with d running over the
// pointwise reduction extent, so at multiplier m the filter's second dimension
// must be CI * m for the indices to stay in bounds. That is what is built here.

#include <cstdint>
#include <cstdio>
#include <vector>

#include "HalideBuffer.h"

#include "depthwise_separable_conv.h"
#include "depthwise_separable_conv_auto_schedule.h"

using namespace Halide::Runtime;

static const int N = 1, CI = 32, CO = 16, CM = 2, W = 16, H = 16;
// The generator reads input channel `d / channel_multiplier`, and with a
// non-constant multiplier Halide cannot prove that quotient stays under CI, so
// its bounds inference conservatively demands a wider input than the pipeline
// actually reads (and the RoundUp tail on input_bounded's d tiling widens it
// further). Allocating extra channels satisfies that demand; they are never
// read, since every actual load is at d / CM < CI. At CM = 1 the quotient
// simplifies away and the first test needs no such slack.
static const int CI_ALLOC = 128;
static const int KW = 5, KH = 5;
static const int PAD_W = KW / 2, PAD_H = KH / 2;   // 2, as the generator computes
static const int DC = CI * CM;                     // depthwise / pointwise reduction extent

static int failures = 0;

static void fail(const char *what, int a, int b, double got, double want) {
    if (failures < 10) printf("FAIL %s [%d, %d]: got %g, expected %g\n", what, a, b, got, want);
    failures++;
}

static int small(uint32_t &s, int lo, int hi) {
    s = s * 1664525u + 1013904223u;
    return lo + (int)((s >> 16) % (uint32_t)(hi - lo + 1));
}

struct Inputs {
    Buffer<float, 4> input{CI_ALLOC, W, H, N};
    Buffer<float, 4> depthwise_filter{CM, DC, KW, KH};
    Buffer<float, 2> pointwise_filter{CO, DC};
    Buffer<float, 1> bias{CO};

    void fill(uint32_t seed) {
        uint32_t s = seed;
        for (int b = 0; b < N; b++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++)
                    for (int d = 0; d < CI_ALLOC; d++) input(d, x, y, b) = (float)small(s, 0, 15);
        for (int ky = 0; ky < KH; ky++)
            for (int kx = 0; kx < KW; kx++)
                for (int c = 0; c < DC; c++)
                    for (int m = 0; m < CM; m++) depthwise_filter(m, c, kx, ky) = (float)small(s, -2, 2);
        for (int c = 0; c < DC; c++)
            for (int o = 0; o < CO; o++) pointwise_filter(o, c) = (float)small(s, -2, 2);
        for (int o = 0; o < CO; o++) bias(o) = (float)small(s, -4, 4);
    }
};

static void reference(const Inputs &in, std::vector<float> &out) {
    std::vector<float> dw((size_t)DC * W * H * N, 0.f);
    for (int b = 0; b < N; b++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++)
                for (int d = 0; d < DC; d++) {
                    float acc = 0.f;
                    for (int ry = 0; ry < KH; ry++)
                        for (int rx = 0; rx < KW; rx++)
                            for (int rd = 0; rd < CM; rd++) {
                                int sx = x + rx - PAD_W, sy = y + ry - PAD_H;
                                float v = 0.f;
                                if (sx >= 0 && sx < W && sy >= 0 && sy < H) {
                                    v = in.input(d / CM, sx, sy, b);
                                }
                                acc += in.depthwise_filter(rd, d, rx, ry) * v;
                            }
                    dw[(((size_t)b * H + y) * W + x) * DC + d] = acc;
                }
    out.assign((size_t)CO * W * H * N, 0.f);
    for (int b = 0; b < N; b++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++)
                for (int d = 0; d < CO; d++) {
                    float acc = in.bias(d);
                    for (int rc = 0; rc < DC; rc++)
                        acc += in.pointwise_filter(d, rc) * dw[(((size_t)b * H + y) * W + x) * DC + rc];
                    out[(((size_t)b * H + y) * W + x) * CO + d] = acc > 0.f ? acc : 0.f;
                }
}

int main(int argc, char **argv) {
    Inputs in;
    in.fill(773311u);

    std::vector<float> want;
    reference(in, want);

    Buffer<float, 4> out(CO, W, H, N);
    out.fill(0.f);
    int err = depthwise_separable_conv(in.input, in.depthwise_filter,
                                       in.pointwise_filter, in.bias, out);
    if (err != 0) fail("pipeline returned an error", 0, 0, err, 0);

    long nonzero = 0;
    for (int b = 0; b < N; b++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++)
                for (int d = 0; d < CO; d++) {
                    float w = want[(((size_t)b * H + y) * W + x) * CO + d];
                    if (w != 0.f) nonzero++;
                    if (out(d, x, y, b) != w) fail("5x5 / multiplier-2 pipeline", x, y, out(d, x, y, b), w);
                }
    if (nonzero * 4 < (long)CO * W * H * N) {
        fail("reference is mostly zero; oracle would be vacuous", 0, 0,
             (double)nonzero, (double)CO * W * H * N / 4);
    }

    // The premise of the test, asserted rather than assumed: at this shape the
    // two mutated expressions genuinely disagree with the originals.
    if (KW / 2 == KW - 2) fail("filter width does not separate /2 from -2", KW, 0, KW / 2, KW - 2);
    if (CM == 1) fail("channel multiplier does not separate / from *", CM, 0, CM, 1);

    printf("shape: %dx%d depthwise filter, channel multiplier %d, pad %dx%d\n",
           KW, KH, CM, PAD_W, PAD_H);
    if (failures) {
        printf("mutation_test2: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test2: OK\n");
    return 0;
}
