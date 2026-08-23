// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Why this file exists: unsharp has no added driver registered, so the sweep
// scored `test2_added` against the shipped driver's own out.png and the two
// test columns were two readings of one program. This one is different in the
// ways that matter -- synthetic input, raw float dump, and an assertion the
// shipped driver does not make.
//
// The assertion. The generator computes a single, CHANNEL-INDEPENDENT ratio
//
//     gray(x,y)   = 0.299 r + 0.587 g + 0.114 b        (one value per pixel)
//     sharpen     = 2 * gray - blur_x
//     ratio(x,y)  = sharpen / gray                     (one value per pixel)
//     output(x,y,c) = ratio(x,y) * input(x,y,c)
//
// so at any pixel the three output channels are the SAME scalar times the three
// input channels. That gives a cross-channel identity that needs no reference
// image at all:
//
//     output(x,y,0) * input(x,y,1)  ==  output(x,y,1) * input(x,y,0)
//
// and likewise for the (0,2) pair. It holds for every input and every correct
// build, and it fails as soon as a mutation makes any part of the ratio depend
// on c, or makes the final multiply pick up the wrong channel. It is checked
// with a relative tolerance because the two sides are different float products
// of the same reals, not because the identity is approximate.
//
// A constant-image identity is deliberately NOT used here: the generator's
// Gaussian kernel is evaluated at four taps and never normalised, so
// blur(const) is const * K with K only approximately 1, and asserting anything
// about its exact value would be asserting a property of the app's own
// arithmetic rather than of the pipeline.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "unsharp.h"
#include "unsharp_auto_schedule.h"

using namespace Halide::Runtime;

static const int W = 128, H = 128;
static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

static float texture(int x, int y, int c) {
    uint32_t h = (uint32_t)(x / 4) * 73856093u ^ (uint32_t)(y / 4) * 19349663u ^
                 (uint32_t)c * 83492791u;
    h ^= h >> 13; h *= 1274126177u; h ^= h >> 16;
    // Kept well away from zero: `ratio` divides by gray, and a gray of zero
    // would make the identity below 0 == 0 and test nothing.
    return 0.20f + (float)((h >> 8) & 255) * (0.70f / 255.0f);
}

int main(int argc, char **argv) {
    Buffer<float, 3> input(W, H, 3);
    for (int c = 0; c < 3; c++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) input(x, y, c) = texture(x, y, c);

    Buffer<float, 3> output(W, H, 3);
    output.fill(0.f);
    unsharp(input, output);

    // ---- the cross-channel identity -------------------------------------
    double worst = 0.0;
    int wx = -1, wy = -1, wc = -1;
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            for (int c = 1; c < 3; c++) {
                double a = (double)output(x, y, 0) * (double)input(x, y, c);
                double b = (double)output(x, y, c) * (double)input(x, y, 0);
                double scale = std::fabs(a) + std::fabs(b) + 1e-12;
                double rel = std::fabs(a - b) / scale;
                if (rel > worst) { worst = rel; wx = x; wy = y; wc = c; }
            }
        }
    }
    if (worst > 1e-5) {
        printf("worst cross-channel deviation at (%d,%d) channel %d\n", wx, wy, wc);
        fail("output channels are not a common scalar times the input channels",
             worst, 0.0);
    }
    printf("cross-channel max relative deviation %.9g\n", worst);

    double lo = 1e30, hi = -1e30;
    for (int c = 0; c < 3; c++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) {
                float v = output(x, y, c);
                if (!std::isfinite(v)) { fail("non-finite output", v, 0); goto done; }
                lo = v < lo ? v : lo; hi = v > hi ? v : hi;
            }
done:
    if (hi - lo < 1e-6) fail("output is constant", hi - lo, 1e-6);
    printf("range [%g, %g]\n", lo, hi);

    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) fail("could not open out.bin", 0, 1);
        else {
            std::vector<float> flat((size_t)W * H * 3);
            size_t i = 0;
            for (int c = 0; c < 3; c++)
                for (int y = 0; y < H; y++)
                    for (int x = 0; x < W; x++) flat[i++] = output(x, y, c);
            fwrite(flat.data(), sizeof(float), flat.size(), f);
            fclose(f);
        }
    }
    if (failures) { printf("mutation_test: %d failure(s)\n", failures); return 1; }
    printf("mutation_test: OK\n");
    return 0;
}
