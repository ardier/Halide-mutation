// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Target: the three mutants at bgu_generator.cpp:412:78, the `+` in
//
//     Expr input_luma = A(3,0) + 2*A(3,1) + A(3,2) + epsilon * (N + 1);
//
// mutated to `N - 1`, `N * 1` and `N / 1`. `input_luma` is the denominator of
//
//     Expr gain = output_luma / input_luma;
//
// which the regulariser then pushes the fitted affine model towards:
//
//     b(0,0) += weighted_lambda * gain;   // and (1,1), (2,2)
//
// Why they survive the shipped test. epsilon is 1e-6, and A(3,0..2) are sums of
// guide luma over a grid cell -- of order 1e5 for a natural image once the
// 5-tap blurs in z, x and y have multiplied the counts up. Perturbing the sum
// by one epsilon is a relative change of about 1e-11: far below float32's 1e-7
// resolution, and then the result is quantised to an 8-bit PNG on top of that.
// The mutation is real but arithmetically invisible at the scale the app's own
// input puts on that expression.
//
// The fix is not a stricter oracle, it is an input that puts the epsilon term
// where it can be seen. This driver hands BGU a guide pair that is identically
// zero -- splat_loc = 0 and values = 0 -- so that A(3,0..2) and b(3,0..2) are
// exactly zero and BOTH lumas collapse to their epsilon terms alone:
//
//     output_luma = epsilon * (N + 1)
//     input_luma  = epsilon * (N + 1)      ->  gain == 1, exactly, in every cell
//
// With the data terms gone, A is diagonal -- lambda*(N+1) on the first three
// entries -- and b is lambda*(N+1)*gain on the same diagonal, so the solve
// returns gain*I with a zero offset, and the model applied to the high-res
// input is the identity (algebraically; see TOL below for what float does to
// it):
//
//     BGU(guide = 0, target = 0, image) == image
//
// That is a reference-free identity, and it is exactly what the mutants break:
// each of them leaves output_luma at epsilon*(N+1) while the denominator
// becomes epsilon*N or epsilon*(N-1), so gain becomes (N+1)/N or (N+1)/(N-1)
// and the output is the input scaled by a whisker more than one. N is the
// blurred constraint count, so a small s_sigma keeps N small and the whisker
// large: at s_sigma = 2 it is a relative 1e-4, four orders of magnitude above
// float32 round-off, where at the app's s_sigma = 16 it would be 1e-6.
//
// r_sigma is 1 here, i.e. a single intensity bin. That is deliberate: with a
// zero guide every constraint lands in bin 0, so any finer intensity binning
// would leave the higher bins with no constraints at all, and a mutant that
// divides by N would then be dividing by zero. One bin keeps every sampled bin
// populated, so the mutants are separated by arithmetic rather than by a
// division by zero.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"

#include "bgu.h"
#include "bgu_auto_schedule.h"

using namespace Halide::Runtime;

static const int W = 256, H = 256;      // high-res
static const int LW = W / 8, LH = H / 8;  // low-res guide pair
static const int S_SIGMA = 2;
static const float R_SIGMA = 1.0f;

// The identity above is algebraic, but the solve runs in float and measurably
// so: on the unmutated pipeline the worst deviation is 7.6e-5, not zero. That
// is the same order as the shift the mutants produce, so this tolerance is NOT
// the oracle that separates them -- it is a sanity bound, set two orders above
// the observed baseline error, that catches a mutant which breaks the
// compositing algebra outright. The oracle that does the separating is the
// bitwise comparison of the raw float dump below, which is exact and needs no
// tolerance at all. Inventing a tight tolerance here instead would have been
// the wrong move: it would sit inside the pipeline's own round-off and go
// flaky.
static const float TOL = 1e-2f;

static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

// Deterministic content for the high-res image, kept inside [0.05, 0.80] so
// that the final clamp(.., 0.0f, 1.0f) in the generator never fires -- neither
// for the baseline nor for a mutant that scales the result slightly above one.
static float pixel(int x, int y, int c) {
    uint32_t h = (uint32_t)(x / 3) * 73856093u ^ (uint32_t)(y / 3) * 19349663u ^
                 (uint32_t)c * 83492791u;
    h ^= h >> 13;
    h *= 1274126177u;
    h ^= h >> 16;
    return 0.05f + (float)((h >> 9) & 255) * (0.75f / 255.0f);
}

int main(int argc, char **argv) {
    // The guide pair is identically zero: that is the whole point of the test.
    Buffer<float, 3> splat_loc(LW, LH, 3), values(LW, LH, 3);
    splat_loc.fill(0.0f);
    values.fill(0.0f);

    Buffer<float, 3> slice_loc(W, H, 3);
    for (int c = 0; c < 3; c++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) slice_loc(x, y, c) = pixel(x, y, c);

    Buffer<float, 3> output(W, H, 3);
    output.fill(0.0f);

    bgu(R_SIGMA, S_SIGMA, splat_loc, values, slice_loc, output);

    // ---- the reference-free identity ------------------------------------
    // A zero guide and a zero target leave the regulariser as the only term in
    // the fit, and it fits gain == 1, so BGU must return its input untouched.
    double worst = 0.0;
    int worst_x = -1, worst_y = -1, worst_c = -1;
    for (int c = 0; c < 3; c++) {
        for (int y = 0; y < H; y++) {
            for (int x = 0; x < W; x++) {
                float got = output(x, y, c);
                if (!std::isfinite(got)) {
                    fail("output contains a non-finite value", got, 0);
                    goto done;
                }
                double d = std::fabs((double)got - (double)slice_loc(x, y, c));
                if (d > worst) {
                    worst = d; worst_x = x; worst_y = y; worst_c = c;
                }
            }
        }
    }
done:
    if (worst > TOL) {
        printf("worst deviation at (%d,%d,%d)\n", worst_x, worst_y, worst_c);
        fail("BGU with a zero guide pair is not the identity", worst, 0.0);
    }
    printf("max |out - in| = %.9g over %d values\n", worst, W * H * 3);

    // ---- artifact for the output-comparison oracle ----------------------
    // Raw floats: the shipped driver writes an 8-bit PNG, and the differences
    // this test exists to expose are ~1e-4 relative, which PNG cannot carry.
    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) {
            fail("could not open out.bin", 0, 1);
        } else {
            std::vector<float> flat((size_t)W * H * 3);
            size_t i = 0;
            for (int c = 0; c < 3; c++)
                for (int y = 0; y < H; y++)
                    for (int x = 0; x < W; x++) flat[i++] = output(x, y, c);
            fwrite(flat.data(), sizeof(float), flat.size(), f);
            fclose(f);
        }
    }

    if (failures) {
        printf("mutation_test: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test: OK\n");
    return 0;
}
