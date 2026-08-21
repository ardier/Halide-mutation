// Second targeted test for lens_blur, added for the mutation study.
//
// mutation_test.cpp supplied a real stereo pair (the shipped process.cpp loads
// the same file into both eyes) and that killed the three cost-pyramid
// BoundaryConditions mutants. One arithmetic mutant survived it:
//
//   line 34:60   Halide_add_to_div on the `+ 1` in
//                absd(left(x, y, c), right(x + 2 * z + 1, y, c))
//                mutated to  right(x + 2 * z / 1, y, c) == right(x + 2 * z, y, c)
//
// The generator scores each candidate depth z by the better of two matches, at
// displacement 2z and at 2z+1 -- that pair is how one slice index covers both an
// even and an odd pixel disparity. The mutation collapses the pair, leaving only
// even disparities representable.
//
// The first test could not see this because every disparity it synthesised was
// even (right = texture shifted by 2*d), so the 2z term already gave the exact
// match and the 2z+1 term never carried the answer. This test changes exactly
// one thing: the scene is built at ODD disparities (2*d + 1), which only the
// mutated-away term can match exactly.
//
// Everything else -- the two-depth scene, the foreground blocks against the
// borders, the raw float dump instead of PNG -- is unchanged from the first test.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"

#include "lens_blur.h"
#include "lens_blur_auto_schedule.h"

using namespace Halide::Runtime;

// Kept a multiple of 128 in x and y so that all eight pyramid levels
// (w /= 2 seven times) stay non-degenerate, as they are for the app's own
// 192x320 rgb_small.png.
static const int W = 192, H = 192;
static const int SLICES = 32, FOCUS_DEPTH = 13, APERTURE_SAMPLES = 32;
static const float BLUR_RADIUS_SCALE = 0.5f;

// Disparities, in pixels. The generator matches left(x) against right(x + 2z)
// and right(x + 2z + 1), so a surface at slice z is a shift of 2z.
static const int Z_BG = 3, Z_FG = 18;

static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %g, expected %g\n", what, got, want);
    failures++;
}

// A blocky deterministic texture over a domain wider than the image, so that
// shifting by a disparity still lands on real content rather than off the edge.
// Blocky rather than per-pixel noise: 3x3 cells give the matcher an
// unambiguous, well-conditioned signal instead of a field of equally good
// false matches.
static uint8_t texture(int u, int y, int c) {
    uint32_t h = (uint32_t)(u / 3) * 73856093u ^ (uint32_t)(y / 3) * 19349663u ^
                 (uint32_t)c * 83492791u;
    h ^= h >> 13;
    h *= 1274126177u;
    h ^= h >> 16;
    return (uint8_t)(h & 0xff);
}

// Two depths: a background plane, and foreground blocks. Three of the four
// blocks are placed against an image border (left edge, right edge, top edge)
// precisely so the depth discontinuity -- the thing the push/pull pyramid has
// to inpaint across -- reaches the boundary of every pyramid level.
static int depth_at(int x, int y) {
    if (x < 46 && y > 40 && y < 120) return Z_FG;          // against the left edge
    if (x > W - 40 && y > 96) return Z_FG;                 // against the right edge
    if (y < 34 && x > 60 && x < 150) return Z_FG;          // against the top edge
    if (x > 78 && x < 122 && y > 132 && y < 172) return Z_FG;  // interior control
    return Z_BG;
}

int main(int argc, char **argv) {
    Buffer<uint8_t, 3> left_im(W, H, 3), right_im(W, H, 3);
    for (int c = 0; c < 3; c++) {
        for (int y = 0; y < H; y++) {
            for (int x = 0; x < W; x++) {
                int d = depth_at(x, y);
                left_im(x, y, c) = texture(x, y, c);
                // Odd disparity: only the `2 * z + 1` term matches this exactly.
                right_im(x, y, c) = texture(x + 2 * d + 1, y, c);
            }
        }
    }

    Buffer<float, 3> output(W, H, 3);
    output.fill(0.f);
    lens_blur(left_im, right_im, SLICES, FOCUS_DEPTH, BLUR_RADIUS_SCALE,
              APERTURE_SAMPLES, output);

    // ---- golden-free self-checks ---------------------------------------
    // These hold for any correct build and need no recorded reference, so they
    // survive a change of machine or compiler.
    double lo = 1e30, hi = -1e30, sum = 0.0;
    long n = 0, border_n = 0;
    double border_lo = 1e30, border_hi = -1e30;
    for (int c = 0; c < 3; c++) {
        for (int y = 0; y < H; y++) {
            for (int x = 0; x < W; x++) {
                float v = output(x, y, c);
                if (!std::isfinite(v)) {
                    fail("output contains a non-finite value", v, 0);
                    goto done_scan;
                }
                lo = v < lo ? v : lo;
                hi = v > hi ? v : hi;
                sum += v;
                n++;
                if (x < 8 || x >= W - 8 || y < 8 || y >= H - 8) {
                    border_n++;
                    border_lo = v < border_lo ? v : border_lo;
                    border_hi = v > border_hi ? v : border_hi;
                }
            }
        }
    }
done_scan:
    if (n && hi - lo < 1e-3) {
        fail("output is constant; the pipeline is not doing anything", hi - lo, 1e-3);
    }
    // The 8-pixel frame must carry real, varying content too. A boundary
    // condition that collapses the border to a single value, or that leaves it
    // untouched at the fill value, shows up here without any golden.
    if (border_n && border_hi - border_lo < 1e-3) {
        fail("output border is constant", border_hi - border_lo, 1e-3);
    }
    printf("range [%g, %g] mean %g; border range [%g, %g]\n",
           lo, hi, n ? sum / n : 0.0, border_lo, border_hi);

    // ---- artifact for the golden-output oracle --------------------------
    // Raw floats: PNG would quantise to 8 bits and could hide a difference that
    // is real but small, which is exactly the failure mode this test exists to
    // avoid.
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
        printf("mutation_test2: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test2: OK\n");
    return 0;
}
