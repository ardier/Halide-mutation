// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Target: bilateral_grid_generator.cpp:56:21, the `/` in
//
//     Expr xi = x / s_sigma;
//
// mutated to `+`, i.e. the slice step looks up grid cell `x + s_sigma` instead
// of grid cell `x / s_sigma`. The sibling mutants at the same site (`-` and
// `*`) both died on the shipped test; this one did not, and the reason it did
// not is not that it is equivalent -- it plainly is not -- but that the sweep
// never got a verdict out of it. Its recorded row is
//
//     test1_demo SURVIVED   test2 NOT_RUN   note: "golden run timed out"
//
// Replacing x/8 with x+8 makes the slice read grid coordinates far outside the
// populated grid, which drags the whole pipeline's bounds inference out with
// it. On the app's 1536x2560 input the run went over the sweep's timeout, and
// a run that times out writes no artifact, so the output comparison had nothing
// to compare and correctly declined to return a verdict. The mutant was then
// counted among the survivors because nothing had killed it -- which is true,
// but is a statement about the harness's clock, not about the mutant.
//
// So this driver changes one thing: it uses a small image. 256x256 instead of
// 1536x2560 is 60x less work, which is enough for even the blown-up bounds to
// finish well inside the timeout and actually write an artifact. Nothing about
// the oracle is loosened.
//
// The image itself is built so that a shifted grid lookup cannot come out the
// same by luck:
//
//   * a large flat plateau, much wider than one grid cell (s_sigma = 8) plus
//     the 5-tap blur's reach (+-2 cells = +-16 pixels), so that a correct
//     bilateral filter must return the plateau's own value in its interior --
//     a reference-free identity, since a bilateral filter is a normalised
//     weighted average and reproduces locally constant signal exactly;
//   * strong, high-contrast structure everywhere else, so the cell the mutant
//     reads instead holds a visibly different distribution.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"

#include "bilateral_grid.h"
#include "bilateral_grid_auto_schedule.h"

using namespace Halide::Runtime;

static const int W = 256, H = 256;
static const float R_SIGMA = 0.1f;  // the app's own value

// The plateau: well inside the image and much larger than the filter support.
static const int PX0 = 64, PX1 = 192, PY0 = 64, PY1 = 192;
static const float PLATEAU = 0.30f;

// How far inside the plateau the identity is checked. s_sigma is 8 and the
// grid is blurred with a 5-tap filter in x and y, so a pixel more than
// 8*2 + 8 = 24 pixels inside sees only plateau.
static const int MARGIN = 40;

static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

static float texture(int x, int y) {
    uint32_t h = (uint32_t)(x / 4) * 73856093u ^ (uint32_t)(y / 4) * 19349663u;
    h ^= h >> 13;
    h *= 1274126177u;
    h ^= h >> 16;
    // Deliberately far from the plateau value, and spread across the whole
    // intensity range so the grid's z axis is populated too.
    return (float)((h >> 8) & 255) / 255.0f;
}

int main(int argc, char **argv) {
    Buffer<float, 2> input(W, H);
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            bool in_plateau = (x >= PX0 && x < PX1 && y >= PY0 && y < PY1);
            input(x, y) = in_plateau ? PLATEAU : texture(x, y);
        }
    }

    Buffer<float, 2> output(W, H);
    output.fill(0.f);
    bilateral_grid(input, R_SIGMA, output);

    // ---- reference-free checks -----------------------------------------
    double lo = 1e30, hi = -1e30;
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            float v = output(x, y);
            if (!std::isfinite(v)) {
                fail("output contains a non-finite value", v, 0);
                goto done;
            }
            lo = v < lo ? v : lo;
            hi = v > hi ? v : hi;
        }
    }
done:
    if (hi - lo < 1e-4) {
        fail("output is constant; the pipeline is not doing anything", hi - lo, 1e-4);
    }

    // A bilateral filter is a weighted average with non-negative weights,
    // normalised by their sum, so it cannot leave the input's range.
    if (lo < -1e-3 || hi > 1.0f + 1e-3) {
        fail("output left the range of the input", lo < -1e-3 ? lo : hi,
             lo < -1e-3 ? 0.0 : 1.0);
    }

    // The plateau identity. Every sample the filter can reach from here has
    // the same value, so the normalised average of them is that value.
    {
        double worst = 0.0;
        int wx = -1, wy = -1;
        for (int y = PY0 + MARGIN; y < PY1 - MARGIN; y++) {
            for (int x = PX0 + MARGIN; x < PX1 - MARGIN; x++) {
                double d = std::fabs((double)output(x, y) - PLATEAU);
                if (d > worst) { worst = d; wx = x; wy = y; }
            }
        }
        if (worst > 1e-3) {
            printf("worst plateau deviation at (%d,%d)\n", wx, wy);
            fail("interior of a flat plateau was not reproduced", worst, 0.0);
        }
        printf("plateau max deviation %.9g\n", worst);
    }
    printf("range [%g, %g]\n", lo, hi);

    // ---- artifact for the output-comparison oracle ----------------------
    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) {
            fail("could not open out.bin", 0, 1);
        } else {
            std::vector<float> flat((size_t)W * H);
            size_t i = 0;
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++) flat[i++] = output(x, y);
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
