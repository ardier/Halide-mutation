// Targeted correctness test added for the mutation study (Experiment 2).
//
// NOT a replacement for the app's shipped process.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// The gap: process.cpp fills its buffers with rand(), benchmarks the pipeline
// twice, prints two timings and "Success!", and never looks at a single output
// value. It saves no output artifact either, so even a golden-output oracle
// degenerates to comparing that same timing-only stdout. Every mutant of this
// benchmark therefore survives by construction -- the full sweep scored 37
// effective mutants and killed 0.
//
// What this test does instead: recomputes the depthwise-separable convolution
// in plain C++ and requires *exact* agreement. Exactness is affordable here
// because the test feeds small integer-valued floats: every product and every
// partial sum stays an exactly representable integer, so the result does not
// depend on the order Halide chooses to accumulate in, and no tolerance has to
// be invented (a loose tolerance is how an oracle silently stops being one).
//
// It then probes the two clamp() calls and the padding select() directly, since
// those are the constructs the surviving select/clamp mutants rewrite.

#include <cstdint>
#include <cstdio>
#include <vector>

#include "HalideBuffer.h"

#include "depthwise_separable_conv.h"
#include "depthwise_separable_conv_auto_schedule.h"

using namespace Halide::Runtime;

// Channel counts are kept at the app's own values: the manual schedule tiles
// the output's channel dimension by a full vector's worth of lanes, so
// shrinking CO would ask the schedule to run outside the shape it was written
// for. Only the spatial extent and the batch are shrunk, which is what makes
// the C++ reference cheap.
static const int N = 1, CI = 32, CO = 16, CM = 1, W = 16, H = 16;
static const int KW = 3, KH = 3;
static const int PAD_W = KW / 2, PAD_H = KH / 2;

static int failures = 0;

static void fail(const char *what, int a, int b, double got, double want) {
    if (failures < 10) {
        printf("FAIL %s [%d, %d]: got %g, expected %g\n", what, a, b, got, want);
    }
    failures++;
}

// A tiny deterministic integer source. Values are small enough that every
// product and partial sum below stays exactly representable in float.
static int small(uint32_t &s, int lo, int hi) {
    s = s * 1664525u + 1013904223u;
    return lo + (int)((s >> 16) % (uint32_t)(hi - lo + 1));
}

struct Inputs {
    Buffer<float, 4> input{CI, W, H, N};
    Buffer<float, 4> depthwise_filter{CM, CI, KW, KH};
    Buffer<float, 2> pointwise_filter{CO, CI * CM};
    Buffer<float, 1> bias{CO};

    void fill(uint32_t seed) {
        uint32_t s = seed;
        for (int b = 0; b < N; b++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++)
                    for (int d = 0; d < CI; d++)
                        // Deliberately varies with x and with y: a mutant that
                        // collapses either spatial clamp to a constant can only
                        // be seen if the input actually differs across that
                        // dimension.
                        input(d, x, y, b) = (float)small(s, 0, 15);
        for (int ky = 0; ky < KH; ky++)
            for (int kx = 0; kx < KW; kx++)
                for (int c = 0; c < CI; c++)
                    for (int m = 0; m < CM; m++)
                        depthwise_filter(m, c, kx, ky) = (float)small(s, -2, 2);
        for (int c = 0; c < CI * CM; c++)
            for (int o = 0; o < CO; o++)
                pointwise_filter(o, c) = (float)small(s, -2, 2);
        for (int o = 0; o < CO; o++) bias(o) = (float)small(s, -4, 4);
    }
};

// The pipeline, transcribed from the generator:
//
//   in_bounds       = 0 <= x < W && 0 <= y < H
//   input_bounded   = select(in_bounds, input(d, clamp(x,0,W-1), clamp(y,0,H-1), b), 0)
//   depthwise       = sum_{rd,rx,ry} dwf(rd,d,rx,ry) * input_bounded(d/CM, x+rx-PAD_W, y+ry-PAD_H, b)
//   pointwise       = bias(d) + sum_rc pwf(d,rc) * depthwise(rc,x,y,b)
//   output          = max(pointwise, 0)
static void reference(const Inputs &in, std::vector<float> &out) {
    std::vector<float> dw((size_t)CI * CM * W * H * N, 0.f);
    for (int b = 0; b < N; b++) {
        for (int y = 0; y < H; y++) {
            for (int x = 0; x < W; x++) {
                for (int d = 0; d < CI * CM; d++) {
                    float acc = 0.f;
                    for (int ry = 0; ry < KH; ry++) {
                        for (int rx = 0; rx < KW; rx++) {
                            for (int rd = 0; rd < CM; rd++) {
                                int sx = x + rx - PAD_W, sy = y + ry - PAD_H;
                                float v = 0.f;
                                if (sx >= 0 && sx < W && sy >= 0 && sy < H) {
                                    v = in.input(d / CM, sx, sy, b);
                                }
                                acc += in.depthwise_filter(rd, d, rx, ry) * v;
                            }
                        }
                    }
                    dw[(((size_t)b * H + y) * W + x) * CI * CM + d] = acc;
                }
            }
        }
    }
    out.assign((size_t)CO * W * H * N, 0.f);
    for (int b = 0; b < N; b++) {
        for (int y = 0; y < H; y++) {
            for (int x = 0; x < W; x++) {
                for (int d = 0; d < CO; d++) {
                    float acc = in.bias(d);
                    for (int rc = 0; rc < CI * CM; rc++) {
                        acc += in.pointwise_filter(d, rc) *
                               dw[(((size_t)b * H + y) * W + x) * CI * CM + rc];
                    }
                    out[(((size_t)b * H + y) * W + x) * CO + d] = acc > 0.f ? acc : 0.f;
                }
            }
        }
    }
}

static void run_and_check(const char *label, Inputs &in, Buffer<float, 4> &out,
                          bool also_auto) {
    std::vector<float> want;
    reference(in, want);

    out.fill(0.f);
    depthwise_separable_conv(in.input, in.depthwise_filter, in.pointwise_filter,
                             in.bias, out);
    long nonzero = 0;
    for (int b = 0; b < N; b++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++)
                for (int d = 0; d < CO; d++) {
                    float w = want[(((size_t)b * H + y) * W + x) * CO + d];
                    if (w != 0.f) nonzero++;
                    if (out(d, x, y, b) != w) {
                        fail(label, x, y, out(d, x, y, b), w);
                    }
                }
    // A ReLU output that is all zeros would make the comparison vacuous.
    if (nonzero * 4 < (long)CO * W * H * N) {
        fail("reference is mostly zero; oracle would be vacuous", 0, 0,
             (double)nonzero, (double)CO * W * H * N / 4);
    }

    if (also_auto) {
        Buffer<float, 4> out2(CO, W, H, N);
        out2.fill(0.f);
        depthwise_separable_conv_auto_schedule(in.input, in.depthwise_filter,
                                               in.pointwise_filter, in.bias, out2);
        for (int b = 0; b < N; b++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++)
                    for (int d = 0; d < CO; d++) {
                        float w = want[(((size_t)b * H + y) * W + x) * CO + d];
                        if (out2(d, x, y, b) != w) {
                            fail("auto_schedule variant", x, y,
                                 out2(d, x, y, b), w);
                        }
                    }
    }
}

int main(int argc, char **argv) {
    Inputs in;
    in.fill(20260821u);
    Buffer<float, 4> out(CO, W, H, N);
    run_and_check("full pipeline", in, out, true);

    // ---- direct probes of the padding select() and the two clamps --------
    //
    // input_bounded is the generator's hand-rolled boundary condition:
    //   select(in_bounds, input(d, clamp(x,0,W-1), clamp(y,0,H-1), b), 0.0f)
    // Three separate things have to hold, and each is exactly what one of the
    // surviving mutants breaks.

    // (1) Interior pixels must depend on the input pixel underneath them.
    //     Collapsing either clamp to a constant (a swapped bound makes
    //     min(max(v, hi), lo) == lo) severs that.
    for (int probe = 0; probe < 2; probe++) {
        const int px = probe ? 11 : 4, py = probe ? 3 : 9;
        Inputs in2;
        in2.fill(20260821u);
        for (int d = 0; d < CI; d++) {
            in2.input(d, px, py, 0) = 15.f - in.input(d, px, py, 0);
        }
        Buffer<float, 4> out2(CO, W, H, N);
        out2.fill(0.f);
        depthwise_separable_conv(in2.input, in2.depthwise_filter,
                                 in2.pointwise_filter, in2.bias, out2);
        bool moved = false;
        for (int y = py - 1; y <= py + 1 && !moved; y++)
            for (int x = px - 1; x <= px + 1 && !moved; x++)
                for (int d = 0; d < CO && !moved; d++)
                    if (out2(d, x, y, 0) != out(d, x, y, 0)) moved = true;
        if (!moved) {
            fail("clamp: output does not depend on its own input pixel",
                 px, py, 0, 1);
        }
    }

    // (2) The padding really is zero outside the image, not a clamped edge
    //     value and not the inverse of the guard. Compare against a manually
    //     zero-padded run: widen the input by one pixel on every side, fill the
    //     halo with zeros, and ask the pipeline for the same interior. If
    //     select's branches are swapped the interior goes to zero and the halo
    //     supplies the data, so the two runs cannot agree.
    {
        Buffer<float, 4> wide(CI, W + 2, H + 2, N);
        wide.fill(0.f);
        for (int b = 0; b < N; b++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++)
                    for (int d = 0; d < CI; d++)
                        wide(d, x + 1, y + 1, b) = in.input(d, x, y, b);
        Buffer<float, 4> out_wide(CO, W + 2, H + 2, N);
        out_wide.fill(0.f);
        depthwise_separable_conv(wide, in.depthwise_filter, in.pointwise_filter,
                                 in.bias, out_wide);
        // Interior of the widened run must reproduce the whole of the original
        // run: both see the same 3x3 neighbourhood, zeros included.
        for (int b = 0; b < N; b++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++)
                    for (int d = 0; d < CO; d++)
                        if (out_wide(d, x + 1, y + 1, b) != out(d, x, y, b)) {
                            fail("zero padding is not zero padding", x, y,
                                 out_wide(d, x + 1, y + 1, b), out(d, x, y, b));
                        }
    }

    if (failures) {
        printf("mutation_test: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test: OK\n");
    return 0;
}
