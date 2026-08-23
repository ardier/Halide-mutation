// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Why this file exists. The generator sweep scored `test2_added` for this app
// against the shipped driver's own out.png, because harris has no added driver
// registered and so `golden_variant()` returned the app unchanged. The two
// test columns were therefore two readings of the same program, and the
// question the study asks -- what does a test WE wrote contribute over the
// shipped driver -- was unmeasured for this app rather than answered.
//
// This is a different program from filter.cpp in the three ways that matter:
// a synthetic input instead of apps/images/rgb.png, a raw float dump instead
// of an 8-bit PNG, and a reference-free assertion the shipped driver does not
// make.
//
// The assertion. Harris is a corner detector built on the two Sobel-like
// derivatives Ix and Iy, whose coefficients are +-1/12 and +-2/12 arranged in
// exactly cancelling pairs. On a CONSTANT image every tap sees the same value,
// so each pair cancels exactly in IEEE arithmetic -- x + (-x) is exactly zero,
// whatever x is -- and Ix and Iy are identically zero, hence Ixx, Iyy and Ixy
// are zero and the response det - 0.04*trace^2 is zero. So a flat field must
// produce an exactly flat zero response. That needs no golden and no tolerance
// worth arguing about, and it fails the moment a mutation unbalances the
// derivative stencil.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "harris.h"
#include "harris_auto_schedule.h"

using namespace Halide::Runtime;

static const int W = 128, H = 128;
static const int OW = W - 6, OH = H - 6;  // the shipped driver's output shape
// harris applies NO boundary condition, so the output must be offset by 3 in
// both dimensions or the 3x3-of-3x3 stencil reads before the input's min.
// filter.cpp does the same with output.set_min(3, 3).
static const int X0 = 3, Y0 = 3;
static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

static float texture(int x, int y, int c) {
    uint32_t h = (uint32_t)(x / 5) * 73856093u ^ (uint32_t)(y / 5) * 19349663u ^
                 (uint32_t)c * 83492791u;
    h ^= h >> 13; h *= 1274126177u; h ^= h >> 16;
    return (float)((h >> 8) & 255) / 255.0f;
}

int main(int argc, char **argv) {
    // ---- 1. the flat-field identity ------------------------------------
    {
        Buffer<float, 3> flat(W, H, 3);
        flat.fill(0.375f);
        Buffer<float, 2> out(OW, OH);
        out.set_min(X0, Y0);
        out.fill(1.0f);  // so a pipeline that writes nothing is caught
        harris(flat, out);
        double worst = 0.0;
        for (int y = Y0; y < Y0 + OH; y++)
            for (int x = X0; x < X0 + OW; x++) {
                double v = std::fabs((double)out(x, y));
                if (v > worst) worst = v;
            }
        if (!(worst <= 1e-9)) {
            fail("Harris response on a constant image is not zero", worst, 0.0);
        }
        printf("flat-field max |response| = %.9g\n", worst);
    }

    // ---- 2. structured input, dumped at full precision -----------------
    Buffer<float, 3> input(W, H, 3);
    for (int c = 0; c < 3; c++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) input(x, y, c) = texture(x, y, c);

    Buffer<float, 2> output(OW, OH);
    output.set_min(X0, Y0);
    output.fill(0.f);
    harris(input, output);

    double lo = 1e30, hi = -1e30;
    for (int y = Y0; y < Y0 + OH; y++)
        for (int x = X0; x < X0 + OW; x++) {
            float v = output(x, y);
            if (!std::isfinite(v)) { fail("non-finite response", v, 0); goto done; }
            lo = v < lo ? v : lo; hi = v > hi ? v : hi;
        }
done:
    if (hi - lo < 1e-12) fail("response is constant on a textured image", hi - lo, 1e-12);
    printf("response range [%g, %g]\n", lo, hi);

    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) fail("could not open out.bin", 0, 1);
        else {
            std::vector<float> flat((size_t)OW * OH);
            size_t i = 0;
            for (int y = Y0; y < Y0 + OH; y++)
                for (int x = X0; x < X0 + OW; x++) flat[i++] = output(x, y);
            fwrite(flat.data(), sizeof(float), flat.size(), f);
            fclose(f);
        }
    }
    if (failures) { printf("mutation_test: %d failure(s)\n", failures); return 1; }
    printf("mutation_test: OK\n");
    return 0;
}
