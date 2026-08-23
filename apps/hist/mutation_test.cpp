// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Why this file exists: hist has no added driver registered, so the sweep
// scored `test2_added` against the shipped driver's own out.png and the two
// test columns were two readings of one program.
//
// Two reference-free assertions, both on a GREYSCALE input (r == g == b):
//
//  1. Greyscale in, greyscale out. The generator converts to YCrCb, equalises
//     Y, and converts back. With r == g == b == v the chroma terms are
//         Cr = (r - Y)*0.713 + 128,  Cb = (b - Y)*0.564 + 128
//     and Y is v times (0.299 + 0.587 + 0.114), so Cr and Cb sit at 128 and
//     the inverse transform returns eq(x,y) on all three channels. A correct
//     build must therefore emit r == g == b. Checked with a slack of one
//     8-bit level, because that luma sum is 0.99999999 rather than 1 and the
//     result is rounded to uint8.
//
//  2. Equalisation is monotone. The equalised value is the CDF sampled at the
//     input's luma bin, and a CDF is non-decreasing, so a brighter input pixel
//     can never map to a darker output pixel. This is the defining property of
//     histogram equalisation and it does not depend on the image at all.
//     Checked across the 256 distinct intensities of a ramp, again with one
//     level of slack for the uint8 rounding.
//
// The input is a ramp plus structure rather than apps/images/rgb.png, and the
// full uint8 output is dumped rather than routed through PNG.

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "hist.h"
#include "hist_auto_schedule.h"

using namespace Halide::Runtime;

static const int W = 256, H = 128;
static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

int main(int argc, char **argv) {
    // A greyscale image whose columns sweep all 256 intensities, with the row
    // index perturbing the histogram so the CDF is not a straight line.
    Buffer<uint8_t, 3> input(W, H, 3);
    for (int y = 0; y < H; y++)
        for (int x = 0; x < W; x++) {
            int v = (x + (y / 16) * 3) % 256;
            for (int c = 0; c < 3; c++) input(x, y, c) = (uint8_t)v;
        }

    Buffer<uint8_t, 3> output(W, H, 3);
    output.fill(0);
    hist(input, output);

    // ---- 1. greyscale in, greyscale out --------------------------------
    {
        int worst = 0, wx = -1, wy = -1;
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) {
                int r = output(x, y, 0), g = output(x, y, 1), b = output(x, y, 2);
                int d = std::max(std::abs(r - g), std::max(std::abs(g - b), std::abs(r - b)));
                if (d > worst) { worst = d; wx = x; wy = y; }
            }
        if (worst > 1) {
            printf("worst channel spread at (%d,%d)\n", wx, wy);
            fail("a greyscale input did not produce a greyscale output", worst, 1);
        }
        printf("greyscale channel spread <= %d\n", worst);
    }

    // ---- 2. equalisation is monotone in input intensity ----------------
    {
        // Collect, for each input intensity, the output level it maps to.
        int seen[256]; for (int i = 0; i < 256; i++) seen[i] = -1;
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) {
                int v = input(x, y, 0);
                int o = output(x, y, 0);
                if (seen[v] < 0) seen[v] = o;
                else if (std::abs(seen[v] - o) > 1) {
                    fail("equal input intensities mapped to different outputs",
                         o, seen[v]);
                    goto done_mono;
                }
            }
        {
            int prev = -1, n = 0;
            for (int i = 0; i < 256; i++) {
                if (seen[i] < 0) continue;
                n++;
                if (prev >= 0 && seen[i] < prev - 1) {
                    printf("intensity %d mapped to %d after %d\n", i, seen[i], prev);
                    fail("histogram equalisation is not monotone", seen[i], prev);
                    break;
                }
                prev = seen[i];
            }
            if (n < 200) fail("the ramp did not cover the intensity range", n, 200);
            printf("monotone over %d distinct intensities\n", n);
        }
    }
done_mono:

    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) fail("could not open out.bin", 0, 1);
        else {
            std::vector<uint8_t> flat((size_t)W * H * 3);
            size_t i = 0;
            for (int c = 0; c < 3; c++)
                for (int y = 0; y < H; y++)
                    for (int x = 0; x < W; x++) flat[i++] = output(x, y, c);
            fwrite(flat.data(), 1, flat.size(), f);
            fclose(f);
        }
    }
    if (failures) { printf("mutation_test: %d failure(s)\n", failures); return 1; }
    printf("mutation_test: OK\n");
    return 0;
}
