// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped process.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// This test is written to FAIL TO KILL, and to make that a measurement rather
// than an omission. Five generator mutants survive the shipped driver and its
// golden image, and all five sit on the upper bound of a clamp:
//
//   43:48  idx = clamp(cast<int>(idx), 0, (levels - 1) * 256);
//          `-` mutated to `+`, `*`, `/`   ->  bound becomes (levels+1)*256,
//                                             levels*256, levels*256
//
//   68:57  Expr li = clamp(cast<int>(level), 0, levels - 2);
//          `-` mutated to `+` and `*`     ->  bound becomes levels+2, 2*levels
//
// The claim is that all five are EQUIVALENT MUTANTS, and the argument is that
// in both cases the clamped quantity provably never reaches the original upper
// bound, so raising that bound cannot change anything:
//
//   At 43. idx is computed on the line above as
//              gray(x,y) * cast<float>(levels - 1) * 256.0f
//          and gray is the fixed luma combination
//              0.299f*r + 0.587f*g + 0.114f*b
//          of channels that are input/65535.0f, hence each in [0,1]. Those
//          three float literals sum to 0.99999999 -- strictly less than one --
//          so gray < 1 for every possible input, idx < (levels-1)*256, and
//          cast<int>(idx) <= (levels-1)*256 - 1. The upper clamp never binds
//          in the original either. Every mutant only raises a bound that was
//          already unreachable.
//
//   At 68. level is inGPyramid[j](x,y) * cast<float>(levels - 1), and
//          inGPyramid is the Gaussian pyramid of that same gray, built with a
//          normalised 1-3-3-1 kernel, so it stays inside gray's range and
//          level < levels - 1. cast<int>(level) <= levels - 2, which is
//          exactly the original bound, so again it never binds.
//          Corroborating evidence from the sweep itself: the third mutant at
//          this site, `-` to `/`, gives a bound of levels/2 -- 4 instead of 6
//          at levels = 8, i.e. LOWERED below the reachable range -- and it was
//          killed. Only the two that raise the bound survive. That split is
//          what the argument predicts.
//
// The argument turns on the reachable range of gray, so this driver drives
// gray to its extremes on purpose:
//
//   * pure white (all three channels 65535) and pure black (all zero), so
//     cast<int>(idx) and cast<int>(level) sit at the very top and bottom of
//     their ranges, which is the only place the two clamps could differ;
//   * a ramp that steps through every one of the 256 lookup-table entries per
//     intensity level, so every idx the remap LUT can be asked for is asked
//     for;
//   * enough spatial structure at several scales that all levels of both
//     pyramids carry real content rather than a constant.
//
// If any of the five were killable by input choice, this is the input that
// would do it. The expected -- and measured -- result is that none of them
// die, which is the positive half of the claim: a mutant that no input can
// distinguish is equivalent, and equivalence detection is the expensive half
// of mutation testing.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"

#include "local_laplacian.h"
#include "local_laplacian_auto_schedule.h"

using namespace Halide::Runtime;

// The generator's pyramid_levels GeneratorParam is 8, so the image must stay
// non-degenerate through 8 halvings: 256 = 2^8.
static const int W = 256, H = 256;
static const int LEVELS = 8;                 // the app's own argv[2]
static const float ALPHA = 1.0f / (LEVELS - 1);  // process.cpp passes alpha/(levels-1)
static const float BETA = 1.0f;

static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

int main(int argc, char **argv) {
    Buffer<uint16_t, 3> input(W, H, 3);

    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            uint16_t r, g, b;
            if (y < 16) {
                // Saturated white: gray at its maximum, idx and level at the
                // top of their ranges. This row is the whole point of the test.
                r = g = b = 65535;
            } else if (y < 32) {
                // Saturated black: the bottom of the range, where the LOWER
                // clamp bound (untouched by these mutants) is what binds.
                r = g = b = 0;
            } else if (y < 96) {
                // A full-range ramp: 256 distinct intensities across the row,
                // so every LUT entry the remap can be asked for is exercised.
                uint16_t v = (uint16_t)((x % 256) * 257);
                r = g = b = v;
            } else if (y < 160) {
                // Per-channel ramps, so gray takes values the grey ramp above
                // never produces and the luma weights actually matter.
                r = (uint16_t)((x % 256) * 257);
                g = (uint16_t)(((x * 3 + y) % 256) * 257);
                b = (uint16_t)(((x * 7 + y * 5) % 256) * 257);
            } else {
                // Multi-scale blocky structure so that every level of both
                // pyramids has real content rather than a constant.
                uint32_t h = (uint32_t)(x / 2) * 73856093u ^
                             (uint32_t)(y / 2) * 19349663u;
                uint32_t m = (uint32_t)(x / 16) * 2654435761u ^
                             (uint32_t)(y / 16) * 40503u;
                h ^= h >> 13; h *= 1274126177u; h ^= h >> 16;
                m ^= m >> 11; m *= 2246822519u; m ^= m >> 15;
                uint16_t fine = (uint16_t)((h & 0x3fff));
                uint16_t coarse = (uint16_t)((m & 0xffff) & 0xc000);
                uint16_t v = (uint16_t)(fine + coarse);
                r = v;
                g = (uint16_t)(v ^ 0x1234);
                b = (uint16_t)(v ^ 0x5a5a);
            }
            input(x, y, 0) = r;
            input(x, y, 1) = g;
            input(x, y, 2) = b;
        }
    }

    Buffer<uint16_t, 3> output(W, H, 3);
    output.fill(0);
    local_laplacian(input, LEVELS, ALPHA, BETA, output);

    // ---- reference-free checks -----------------------------------------
    unsigned lo = 0xffffu, hi = 0;
    for (int c = 0; c < 3; c++)
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) {
                unsigned v = output(x, y, c);
                lo = v < lo ? v : lo;
                hi = v > hi ? v : hi;
            }
    if (hi == lo) {
        fail("output is constant; the pipeline is not doing anything", hi - lo, 1);
    }
    // The saturated rows must still be saturated: local Laplacian enhancement
    // is monotone at the extremes, so a pure white row cannot come back dark
    // nor a pure black row bright. This is what fires if a clamp bound is
    // lowered rather than raised -- which is the mutant at this site that the
    // sweep already killed.
    {
        double white_min = 65535.0, black_max = 0.0;
        for (int c = 0; c < 3; c++)
            for (int x = 0; x < W; x++) {
                double w = output(x, 4, c), b = output(x, 20, c);
                white_min = w < white_min ? w : white_min;
                black_max = b > black_max ? b : black_max;
            }
        if (white_min < 60000.0) {
            fail("a saturated white row did not stay near white", white_min, 60000.0);
        }
        if (black_max > 5000.0) {
            fail("a saturated black row did not stay near black", black_max, 5000.0);
        }
        printf("white row min %g, black row max %g\n", white_min, black_max);
    }
    printf("output range [%u, %u]\n", lo, hi);

    // ---- artifact for the output-comparison oracle ----------------------
    // The output is uint16; the shipped driver writes it through a PNG, which
    // for 16-bit data is lossless, so this dump is not stricter than the
    // shipped oracle in precision -- only in what input it is taken over.
    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) {
            fail("could not open out.bin", 0, 1);
        } else {
            std::vector<uint16_t> flat((size_t)W * H * 3);
            size_t i = 0;
            for (int c = 0; c < 3; c++)
                for (int y = 0; y < H; y++)
                    for (int x = 0; x < W; x++) flat[i++] = output(x, y, c);
            fwrite(flat.data(), sizeof(uint16_t), flat.size(), f);
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
