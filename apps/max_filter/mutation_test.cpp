// Targeted test added for the mutation study (Experiment 2).
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver.
//
// Target: the two BoundaryConditions mutants at max_filter_generator.cpp:17:22
// that survive even the golden-output oracle
// (repeat_edge -> mirror_image, repeat_edge -> mirror_interior), while the third
// at the same site (repeat_edge -> repeat_image) dies.
//
// This test exists to settle *why* that split happens, and it is written so the
// answer cannot be "the test was too weak":
//
//   * it recomputes the max filter in C++ and compares exactly -- max over
//     floats is order-independent, so no tolerance is needed;
//   * it checks every pixel of the 30-pixel frame around the image, which is
//     the entire region any boundary condition can reach at radius 26, plus a
//     sample of the interior;
//   * the input is built so the border is where the interesting values are:
//     the global maxima sit in the outermost columns and rows, and the image is
//     deliberately asymmetric left-to-right and top-to-bottom, so replicating,
//     reflecting and wrapping the edge each pull in different pixels.
//
// The expected result is that this kills repeat_image and still does not kill
// mirror_image or mirror_interior, because those two are *equivalent mutants*
// here. A max over a window that is symmetric about its centre and shrinks with
// distance cannot tell edge-clamping from reflection: both map an out-of-domain
// sample to a coordinate that is no further from the centre in either axis, so
// it still lies inside the window and inside the image, and every in-window
// in-image coordinate is already sampled directly. The two therefore range over
// the same set of values, and max of a set does not care how the set was
// reached. Wrap-around is the exception -- it pulls in pixels from the opposite
// edge, genuinely outside the window -- which is exactly the one that dies.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"

#include "max_filter.h"
#include "max_filter_auto_schedule.h"

using namespace Halide::Runtime;

// Width must be at least 256: the manual schedule splits the output's x by 256
// with the default tail strategy, which needs an extent of at least the split
// factor.
static const int W = 256, H = 256, C = 3;
static const int RADIUS = 26;
static const int BORDER = RADIUS + 4;  // everything a boundary condition can touch

static int failures = 0;

static void fail(const char *what, int x, int y, int c, double got, double want) {
    if (failures < 10) {
        printf("FAIL %s at (%d, %d, %d): got %.9g, expected %.9g\n",
               what, x, y, c, got, want);
    }
    failures++;
}

// filter_height(dx) = #{ dy in [0, RADIUS] : dx^2 + dy^2 < (RADIUS + 0.25)^2 },
// transcribed from the generator, float comparison included.
static int filter_height(int dx) {
    int n = 0;
    const float lim = (RADIUS + 0.25f) * (RADIUS + 0.25f);
    for (int dy = 0; dy <= RADIUS; dy++) {
        if ((float)(dx * dx + dy * dy) < lim) n++;
    }
    return n;
}

static inline int clamp_i(int v, int lo, int hi) {
    return v < lo ? lo : (v > hi ? hi : v);
}

int main(int argc, char **argv) {
    Buffer<float, 3> input(W, H, C);

    // Deliberately asymmetric, with the extremes pushed against the edges so a
    // boundary condition that reaches for the wrong pixel is visible.
    for (int c = 0; c < C; c++) {
        for (int y = 0; y < H; y++) {
            for (int x = 0; x < W; x++) {
                uint32_t h = (uint32_t)x * 73856093u ^ (uint32_t)y * 19349663u ^
                             (uint32_t)c * 83492791u;
                h ^= h >> 13;
                h *= 1274126177u;
                h ^= h >> 16;
                float v = (float)(h % 1000) / 4000.0f;  // [0, 0.25)
                // A bright ramp along the left and top edges only. Under
                // repeat_edge and under reflection these values stay near the
                // edge they came from; under wrap-around they appear against
                // the opposite edge, hundreds of pixels away.
                if (x < 3) v += 0.70f + 0.02f * (float)(y % 5);
                if (y < 3) v += 0.55f + 0.02f * (float)(x % 7);
                // A dark, low-variance band down the right and bottom edges, so
                // the two halves of the image are not interchangeable.
                if (x >= W - 3 || y >= H - 3) v *= 0.05f;
                input(x, y, c) = v;
            }
        }
    }

    Buffer<float, 3> output(W, H, C);
    output.fill(0.f);
    max_filter(input, output);

    // ---- reference -------------------------------------------------------
    // out(x, y, c) = max over dx in [-R, R], dy in [-t(dx), t(dx)] of
    //                input(clamp(x + dx), clamp(y + dy), c)
    // with t(dx) = clamp(filter_height(dx), 0, R + 1).
    std::vector<int> t(2 * RADIUS + 1);
    for (int dx = -RADIUS; dx <= RADIUS; dx++) {
        t[dx + RADIUS] = clamp_i(filter_height(dx), 0, RADIUS + 1);
    }

    long checked = 0, border_checked = 0;
    for (int c = 0; c < C; c++) {
        for (int y = 0; y < H; y++) {
            bool y_border = (y < BORDER || y >= H - BORDER);
            for (int x = 0; x < W; x++) {
                bool border = y_border || x < BORDER || x >= W - BORDER;
                // Every pixel a boundary condition can influence, plus a
                // regular sample of the interior as a control.
                if (!border && ((x % 7) || (y % 7))) continue;

                float want = -1e30f;
                for (int dx = -RADIUS; dx <= RADIUS; dx++) {
                    int tt = t[dx + RADIUS];
                    int u = clamp_i(x + dx, 0, W - 1);
                    for (int dy = -tt; dy <= tt; dy++) {
                        int v = clamp_i(y + dy, 0, H - 1);
                        float s = input(u, v, c);
                        if (s > want) want = s;
                    }
                }
                if (output(x, y, c) != want) {
                    fail(border ? "border pixel" : "interior pixel", x, y, c,
                         output(x, y, c), want);
                }
                checked++;
                if (border) border_checked++;
            }
        }
    }
    printf("checked %ld pixels (%ld in the %d-pixel border band)\n",
           checked, border_checked, BORDER);
    // The border band is (W*H - (W-2B)*(H-2B)) * C pixels; assert we really did
    // walk all of it, so a future resize cannot quietly hollow the test out.
    const long expect_border =
        ((long)W * H - (long)(W - 2 * BORDER) * (H - 2 * BORDER)) * C;
    if (border_checked != expect_border) {
        fail("border band not fully covered", 0, 0, 0, (double)border_checked,
             (double)expect_border);
    }

    if (failures) {
        printf("mutation_test: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test: OK\n");
    return 0;
}
