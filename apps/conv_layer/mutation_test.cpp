// Targeted test added for the mutation study (Experiment 2).
//
// NOT a replacement for the app's shipped process.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver.
//
// The gap: process.cpp fills its buffers with rand(), benchmarks the pipeline
// twice, prints two timings and "Success!", and never inspects an output value.
// It saves no artifact either, so the golden-output oracle degenerates to that
// same timing-only stdout. Four mutants survive it that plainly change what the
// pipeline computes:
//
//   line 25:54  filter(...) * input(...)  ->  + , - , /   (the convolution's
//               multiply-accumulate stops being a multiply-accumulate)
//   line 27:28  relu = max(0, conv)       ->  min(0, conv)  (the ReLU is
//               inverted; every output becomes non-positive)
//
// This test recomputes the layer in C++ and requires exact equality. Exactness
// is affordable because the inputs are small integer-valued floats: every
// product and every partial sum stays an exactly representable integer, so the
// result does not depend on the order Halide accumulates in and no tolerance
// has to be invented.
//
// The reference is evaluated at a sampled set of output points rather than all
// 5.12M of them. Each point costs CI*3*3 = 1152 multiply-accumulates, so a full
// reference would be ~5.9 GFLOP of scalar C++ per run; a few thousand points
// spread over all four axes is the same oracle for these mutants at a fraction
// of the cost. The sample is fixed, not random-per-run, so a failure reproduces.

#include <cstdint>
#include <cstdio>
#include <vector>

#include "HalideBuffer.h"

#include "conv_layer.h"
#include "conv_layer_auto_schedule.h"

using namespace Halide::Runtime;

// Fixed by the generator: it hard-codes these extents when it schedules.
static const int N = 5, CI = 128, CO = 128, W = 100, H = 80;

static int failures = 0;

static void fail(const char *what, int c, int x, int y, int n, double got, double want) {
    if (failures < 10) {
        printf("FAIL %s at (c=%d, x=%d, y=%d, n=%d): got %.9g, expected %.9g\n",
               what, c, x, y, n, got, want);
    }
    failures++;
}

static int small(uint32_t &s, int lo, int hi) {
    s = s * 1664525u + 1013904223u;
    return lo + (int)((s >> 16) % (uint32_t)(hi - lo + 1));
}

int main(int argc, char **argv) {
    Buffer<float, 4> input(CI, W + 2, H + 2, N);
    Buffer<float, 4> filter(CO, 3, 3, CI);
    Buffer<float, 1> bias(CO);

    uint32_t s = 20260821u;
    for (int n = 0; n < N; n++)
        for (int y = 0; y < H + 2; y++)
            for (int x = 0; x < W + 2; x++)
                for (int c = 0; c < CI; c++) input(c, x, y, n) = (float)small(s, 0, 7);
    for (int ci = 0; ci < CI; ci++)
        for (int ky = 0; ky < 3; ky++)
            for (int kx = 0; kx < 3; kx++)
                for (int co = 0; co < CO; co++) filter(co, kx, ky, ci) = (float)small(s, -2, 2);
    for (int co = 0; co < CO; co++) bias(co) = (float)small(s, -8, 8);

    Buffer<float, 4> output(CO, W, H, N);
    output.fill(0.f);
    int err = conv_layer(input, filter, bias, output);
    if (err != 0) fail("pipeline returned an error", 0, 0, 0, 0, err, 0);

    // conv(c, x, y, n) = bias(c) + sum_{rx<CI, ry<3, rz<3}
    //                        filter(c, ry, rz, rx) * input(rx, x + ry, y + rz, n)
    // relu(c, x, y, n) = max(0, conv(c, x, y, n))
    long checked = 0, positive = 0;
    for (int n = 0; n < N; n++) {
        for (int y = 3; y < H; y += 11) {
            for (int x = 2; x < W; x += 13) {
                for (int c = 0; c < CO; c += 7) {
                    float acc = bias(c);
                    for (int rx = 0; rx < CI; rx++)
                        for (int rz = 0; rz < 3; rz++)
                            for (int ry = 0; ry < 3; ry++)
                                acc += filter(c, ry, rz, rx) * input(rx, x + ry, y + rz, n);
                    float want = acc > 0.f ? acc : 0.f;
                    if (want > 0.f) positive++;
                    if (output(c, x, y, n) != want) {
                        fail("conv + relu", c, x, y, n, output(c, x, y, n), want);
                    }
                    checked++;
                }
            }
        }
    }
    // Also pin the corners, where an off-by-one in the 3x3 window would show
    // first, and which a strided sample can miss.
    for (int n = 0; n < N; n += 4) {
        const int xs[4] = {0, 1, W - 2, W - 1};
        const int ys[4] = {0, 1, H - 2, H - 1};
        for (int i = 0; i < 4; i++)
            for (int j = 0; j < 4; j++)
                for (int c = 0; c < CO; c += 31) {
                    int x = xs[i], y = ys[j];
                    float acc = bias(c);
                    for (int rx = 0; rx < CI; rx++)
                        for (int rz = 0; rz < 3; rz++)
                            for (int ry = 0; ry < 3; ry++)
                                acc += filter(c, ry, rz, rx) * input(rx, x + ry, y + rz, n);
                    float want = acc > 0.f ? acc : 0.f;
                    if (want > 0.f) positive++;
                    if (output(c, x, y, n) != want) {
                        fail("conv + relu (corner)", c, x, y, n, output(c, x, y, n), want);
                    }
                    checked++;
                }
    }

    // A ReLU output that is all zeros would make the comparison vacuous, and
    // would in particular hide max -> min.
    if (positive * 4 < checked) {
        fail("too few positive outputs; oracle would be vacuous", 0, 0, 0, 0,
             (double)positive, (double)checked / 4);
    }
    printf("checked %ld output points, %ld above the ReLU floor\n", checked, positive);

    if (failures) {
        printf("mutation_test: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test: OK\n");
    return 0;
}
