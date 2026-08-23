// Targeted test added for the mutation study (Experiment 2).
//
// NOT a replacement for the app's shipped process.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver.
//
// The gap this targets is in the *input*, not the assertions. process.cpp does:
//
//     Buffer<uint8_t, 3> left_im  = load_image(argv[1]);
//     Buffer<uint8_t, 3> right_im = load_image(argv[1]);      // <- same file
//
// It hands the same image to both eyes, so the stereo pair has zero disparity
// everywhere. lens_blur's whole front half is a stereo matcher: it builds a cost
// volume over displacements, measures the confidence of the match, and then runs
// a push/pull pyramid to inpaint depth into the low-confidence regions. With
// identical inputs that cost volume is degenerate -- the match is trivially
// perfect at zero displacement everywhere -- so the pyramid has nothing to
// inpaint and the boundary condition applied to each pyramid level
// (lens_blur_generator.cpp:63) never influences the result. That is why three
// BoundaryConditions mutants at that line survive even a golden-output oracle
// while the two on the input images (lines 29-30) die.
//
// This driver builds a genuine stereo pair instead: a textured scene with two
// distinct depths, and foreground blocks placed hard against the image borders
// so the pyramid's boundary handling is on the path to the output. It then
// writes the pipeline's raw float output for the golden-output oracle to
// compare -- raw, not PNG, so that 8-bit quantisation cannot hide a small
// difference -- plus a few self-checks that do not depend on a golden at all.

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
                right_im(x, y, c) = texture(x + 2 * d, y, c);
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
        printf("mutation_test: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test: OK\n");
    return 0;
}
