// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped process.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Why this file exists: nl_means has no added driver registered, so the sweep
// scored `test2_added` against the shipped driver's own out.png and the two
// test columns were two readings of one program.
//
// The assertion. Non-local means is a NORMALISED weighted average: the
// generator carries an alpha channel of ones through the same weighted sum as
// the colour channels and divides by it at the end. Whatever the weights are,
// on a CONSTANT image every sample in the search area has the same value v, so
// the result is v * sum(w) / sum(w) = v. A flat field must come back unchanged.
// That holds for any patch size, search area and sigma, needs no golden, and
// breaks as soon as a mutation unbalances the numerator against the
// denominator -- which is exactly what a mutation to the weight expression, to
// the alpha mux, or to the final divide would do.
//
// A second reference-free check follows from the same fact: with non-negative
// weights the output is a convex combination of input pixels, so it cannot
// leave the input's range.
//
// The image is small (64x64) on purpose. This pipeline costs
// search_area^2 * patch_size^2 per pixel, and this driver is run once per
// mutant across the whole population.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "nl_means.h"
#include "nl_means_auto_schedule.h"

using namespace Halide::Runtime;

static const int W = 64, H = 64;
static const int PATCH = 7, SEARCH = 7;   // the app's own argv values
static const float SIGMA = 0.12f;
static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

static float texture(int x, int y, int c) {
    uint32_t h = (uint32_t)(x / 3) * 73856093u ^ (uint32_t)(y / 3) * 19349663u ^
                 (uint32_t)c * 83492791u;
    h ^= h >> 13; h *= 1274126177u; h ^= h >> 16;
    return 0.05f + (float)((h >> 8) & 255) * (0.90f / 255.0f);
}

int main(int argc, char **argv) {
    // ---- 1. the flat-field identity ------------------------------------
    {
        const float V = 0.4375f;  // exactly representable
        Buffer<float, 3> flat(W, H, 3);
        flat.fill(V);
        Buffer<float, 3> out(W, H, 3);
        out.fill(-1.0f);
        nl_means(flat, PATCH, SEARCH, SIGMA, out);
        double worst = 0.0;
        for (int c = 0; c < 3; c++)
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++) {
                    double d = std::fabs((double)out(x, y, c) - V);
                    if (d > worst) worst = d;
                }
        // A normalised weighted average of identical values is that value; the
        // tolerance covers only the float division, not the identity.
        if (worst > 1e-5) {
            fail("a constant image was not denoised to itself", worst, 0.0);
        }
        printf("flat-field max deviation %.9g\n", worst);
    }

    // ---- 2. structured input, dumped at full precision -----------------
    Buffer<float, 3> input(W, H, 3);
    double in_lo = 1e30, in_hi = -1e30;
    for (int c = 0; c < 3; c++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) {
                float v = texture(x, y, c);
                input(x, y, c) = v;
                in_lo = v < in_lo ? v : in_lo; in_hi = v > in_hi ? v : in_hi;
            }

    Buffer<float, 3> output(W, H, 3);
    output.fill(0.f);
    nl_means(input, PATCH, SEARCH, SIGMA, output);

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
    // Non-negative weights, normalised: the result is a convex combination.
    if (lo < in_lo - 1e-4 || hi > in_hi + 1e-4) {
        fail("output left the range of the input", lo < in_lo - 1e-4 ? lo : hi,
             lo < in_lo - 1e-4 ? in_lo : in_hi);
    }
    printf("range [%g, %g] (input [%g, %g])\n", lo, hi, in_lo, in_hi);

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
