// Targeted test added for the mutation study (Experiment 2).
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver.
//
// Target: Halide_sub_to_mul at iir_blur_generator.cpp:25:12, the `1 - alpha` in
//
//     blur(x, ry, c) = (1 - alpha) * blur(x, ry - 1, c) + alpha * input(x, ry, c);
//
// mutated to `1 * alpha`, i.e. the feedback coefficient becomes alpha instead of
// 1 - alpha. The shipped driver calls iir_blur(input, 0.5f, output) -- and at
// alpha = 0.5, 1 - alpha IS alpha. The mutant is not equivalent; it is
// equivalent at the single coefficient value the test suite ever passes. Any
// other alpha separates them.
//
// The primary check here needs no reference at all and no tolerance. A
// first-order low-pass of this form has unity DC gain: the recurrence
// b <- (1 - a) * b + a * v has v as its fixed point, and the filter is seeded
// with b = v, so a constant input must come back out unchanged -- and exactly
// so in floating point when a is dyadic, since (1-a)*v and a*v are then exact
// and sum to v. Under the mutation the recurrence becomes b <- a*b + a*v, whose
// fixed point is a*v/(1-a) -- at alpha = 0.25 that is v/3, a 67% error.
//
// A full double-precision reference follows as a second check. That one does
// carry a tolerance, because the reference is computed in double and the
// pipeline in float; 1e-4 relative is ~three orders of magnitude above the
// float round-off this recurrence accumulates and ~three below the error any of
// these mutants produce, so it is loose enough not to be flaky and tight enough
// to still be an oracle.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <vector>

#include "HalideBuffer.h"

#include "iir_blur.h"
#include "iir_blur_auto_schedule.h"

using namespace Halide::Runtime;

static const int W = 96, H = 64, C = 3;
// Deliberately not 0.5: that is the one value at which the mutation vanishes.
// Dyadic, so the DC check below is exact in float.
static const float ALPHA = 0.25f;

static int failures = 0;

static void fail(const char *what, int x, int y, int c, double got, double want) {
    if (failures < 10) {
        printf("FAIL %s at (%d, %d, %d): got %.9g, expected %.9g\n", what, x, y, c, got, want);
    }
    failures++;
}

// One pass of the generator's blur_cols_transpose, in double:
//   blur(x, 0, c)  = in(x, 0, c)
//   blur(x, ry, c) = (1-a)*blur(x, ry-1, c) + a*in(x, ry, c)     ry = 1 .. h-1
//   blur(x, fr, c) = (1-a)*blur(x, fr+1, c) + a*blur(x, fr, c)   fr = h-2 .. 0
//   out(x, y, c)   = blur(y, x, c)                                (transpose)
static void pass(const std::vector<double> &in, int w, int h, int ch, double a,
                 std::vector<double> &out) {
    out.assign((size_t)h * w * ch, 0.0);   // transposed: dims become (h, w, ch)
    std::vector<double> b(h);
    for (int c = 0; c < ch; c++) {
        for (int x = 0; x < w; x++) {
            b[0] = in[((size_t)c * h + 0) * w + x];
            for (int y = 1; y < h; y++) {
                b[y] = (1.0 - a) * b[y - 1] + a * in[((size_t)c * h + y) * w + x];
            }
            for (int y = h - 2; y >= 0; y--) {
                b[y] = (1.0 - a) * b[y + 1] + a * b[y];
            }
            // transpose(xx, yy, c) = blur(yy, xx, c): column x becomes row x
            for (int y = 0; y < h; y++) {
                out[((size_t)c * w + x) * h + y] = b[y];
            }
        }
    }
}

int main(int argc, char **argv) {
    // ---- 1. unity DC gain, exact ----------------------------------------
    {
        const float CONST = 8.0f;
        Buffer<float, 3> in(W, H, C), out(W, H, C);
        in.fill(CONST);
        out.fill(0.f);
        int err = iir_blur(in, ALPHA, out);
        if (err != 0) fail("pipeline returned an error", 0, 0, 0, err, 0);
        for (int c = 0; c < C; c++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++)
                    if (out(x, y, c) != CONST) {
                        fail("unity DC gain (constant input must pass through)",
                             x, y, c, out(x, y, c), CONST);
                    }
        printf("DC check: constant %.1f in, alpha %.2f\n", CONST, ALPHA);
    }

    // ---- 2. full reference on a textured image --------------------------
    {
        Buffer<float, 3> in(W, H, C), out(W, H, C);
        std::vector<double> ref((size_t)C * H * W);
        uint32_t s = 4242u;
        for (int c = 0; c < C; c++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++) {
                    s = s * 1664525u + 1013904223u;
                    float v = (float)((s >> 16) % 256u) / 255.0f;
                    in(x, y, c) = v;
                    ref[((size_t)c * H + y) * W + x] = v;
                }
        out.fill(0.f);
        int err = iir_blur(in, ALPHA, out);
        if (err != 0) fail("pipeline returned an error", 0, 0, 0, err, 0);

        std::vector<double> t1, t2;
        pass(ref, W, H, C, (double)ALPHA, t1);   // (H, W, C)
        pass(t1, H, W, C, (double)ALPHA, t2);    // back to (W, H, C)

        double worst = 0.0;
        for (int c = 0; c < C; c++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++) {
                    double want = t2[((size_t)c * H + y) * W + x];
                    double got = out(x, y, c);
                    double d = std::fabs(got - want) / (std::fabs(want) + 1e-6);
                    if (d > worst) worst = d;
                    if (d > 1e-4) fail("IIR reference", x, y, c, got, want);
                }
        printf("reference check: worst relative deviation %.3g (limit 1e-4)\n", worst);

        // Non-degeneracy: the filter must actually smooth. If the pipeline were
        // an identity the reference check above would still pass only if the
        // reference were also an identity, but this pins it directly.
        double in_var = 0, out_var = 0, in_mean = 0, out_mean = 0;
        long n = 0;
        for (int c = 0; c < C; c++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++) { in_mean += in(x, y, c); out_mean += out(x, y, c); n++; }
        in_mean /= n; out_mean /= n;
        for (int c = 0; c < C; c++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++) {
                    double a = in(x, y, c) - in_mean, b = out(x, y, c) - out_mean;
                    in_var += a * a; out_var += b * b;
                }
        printf("variance: in %.6g -> out %.6g\n", in_var / n, out_var / n);
        if (!(out_var < in_var * 0.5)) {
            fail("filter does not smooth", 0, 0, 0, out_var / n, in_var / n * 0.5);
        }
    }

    if (failures) {
        printf("mutation_test: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test: OK\n");
    return 0;
}
