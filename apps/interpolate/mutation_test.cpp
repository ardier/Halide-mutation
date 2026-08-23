// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped filter.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Eight generator mutants survive the shipped driver AND a byte comparison of
// the PNG it saves. All eight survive for reasons that live in the *input*, not
// in the assertions, and they split into three groups:
//
//   34:44  `select(c < 3, clamped(x,y,c) * clamped(x,y,3), clamped(x,y,3))`
//          with `<` mutated to `<=`. At c == 3 the mutant computes alpha*alpha
//          where the original computes alpha. The app's input is
//          apps/images/rgba.png, whose alpha channel takes only the values 0
//          and 255 -- and 0*0 == 0, 1*1 == 1. The mutant is equivalent at every
//          alpha the shipped test ever supplies. Any *fractional* alpha
//          separates them.
//
//   63:57  `upsampledx[l](x, y / 2, c)`      with `/` mutated to `+` and `-`
//   64:63  `upsampledx[l](x, (y + 1) / 2, c)` likewise
//          These corrupt the vertical half of the pyramid's upsample. They are
//          only observable where the upsample contributes, and it is gated:
//
//              Expr alpha = 1.0f - downsampled[l](x, y, 3);
//              interpolated[l](x,y,c) = downsampled[l](x,y,c)
//                                       + alpha * upsampled[l](x,y,c);
//
//          Wherever the image is opaque, alpha is 0 and the whole upsampled
//          term is multiplied away. This app is a hole-filler; with a mostly
//          opaque input there are no holes to fill and its entire reconstruction
//          path is dead weight.
//
//   44:40  `Expr w = input.width() / (1 << (l - 1));` with `/` mutated to
//          `+`, `-` and `*`. `w` is the upper bound of the extra clamp applied
//          at pyramid level 4 to stop the downsampling footprint running off
//          the image. Every mutant makes `w` far larger than the level-3 image,
//          so the clamp stops binding and level 4 upward reads edge-extended
//          content instead of the clamped content. That only shows up if there
//          is real, varying detail hard against the image border at the level-3
//          scale.
//
// So this driver changes the input, in exactly those three ways, and leaves the
// oracle alone:
//
//   * alpha is fractional, and takes many distinct values in (0, 1);
//   * a large part of the frame is fully transparent, in bands and blocks big
//     enough to still be holes several pyramid levels up, so the upsample path
//     carries the answer rather than being multiplied by zero;
//   * the colour field has strong structure right up against all four borders,
//     at a scale coarse enough to survive to level 3-4.
//
// The output is dumped as raw floats rather than routed through PNG, because
//8-bit quantisation is the other reason a real difference can hide -- the
// pipeline's output is float and the shipped driver throws most of it away.
//
// Two of the checks below need no reference at all, so they still hold on a
// different machine or compiler:
//
//   * every output value is finite, and the output is not constant;
//   * where the input is FULLY opaque the pipeline must return that pixel's
//     colour unchanged, exactly. That is an algebraic identity, not a
//     tolerance: at alpha == 1, interpolated[0] = colour*1 + 0*upsampled and
//     the normalising alpha channel is 1 + 0*upsampled, so normalize returns
//     the colour bit-for-bit whatever the pyramid did.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"

#include "interpolate.h"
#include "interpolate_auto_schedule.h"

using namespace Halide::Runtime;

// A power of two so that all ten pyramid levels stay non-degenerate, and large
// enough that level 4 -- where the extra clamp at generator line 46 lives --
// still has real content in it.
static const int W = 512, H = 512;

static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

// A deterministic blocky colour field. Blocky rather than per-pixel noise so
// that the structure survives being downsampled three or four times, which is
// what the level-4 clamp mutants need in order to be visible at all.
static float colour(int x, int y, int c) {
    uint32_t h = (uint32_t)(x / 8) * 73856093u ^ (uint32_t)(y / 8) * 19349663u ^
                 (uint32_t)c * 83492791u;
    h ^= h >> 13;
    h *= 1274126177u;
    h ^= h >> 16;
    // Quantised to 1/64ths: exactly representable in float, so the opaque-pixel
    // identity below can be checked for exact equality without a tolerance.
    return (float)((h >> 8) & 63) / 64.0f;
}

// Coverage. Returns alpha in [0, 1].
//
//   * a wide fully-transparent cross through the middle, and transparent
//     blocks against three of the four borders: holes that are still holes
//     four or five pyramid levels up, which is the only way the vertical
//     upsample mutants at 63:57 and 64:63 reach the output;
//   * elsewhere a *fractional* coverage that varies across the frame, which is
//     what separates alpha from alpha*alpha at 34:44;
//   * a band of exactly-opaque pixels, which the reference-free identity check
//     below uses.
static float alpha_at(int x, int y) {
    // Fully transparent: the holes to be filled.
    if (x >= 200 && x < 312) return 0.0f;              // vertical band
    if (y >= 200 && y < 312) return 0.0f;              // horizontal band
    if (x < 56 && y >= 96 && y < 208) return 0.0f;     // against the left edge
    if (x >= W - 56 && y >= 320) return 0.0f;          // against the right edge
    if (y < 48 && x >= 128 && x < 256) return 0.0f;    // against the top edge

    // Fully opaque: the region the exactness identity is checked on.
    if (x >= 384 && x < 448 && y >= 32 && y < 96) return 1.0f;

    // Fractional, and deliberately many distinct values. alpha*alpha differs
    // from alpha at every one of them.
    int q = ((x / 4) * 7 + (y / 4) * 13) % 47;
    return 0.125f + (float)q / 64.0f;  // 0.125 .. ~0.86, none of them 0 or 1
}

int main(int argc, char **argv) {
    Buffer<float, 3> input(W, H, 4);
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            float a = alpha_at(x, y);
            for (int c = 0; c < 3; c++) input(x, y, c) = colour(x, y, c);
            input(x, y, 3) = a;
        }
    }

    Buffer<float, 3> output(W, H, 3);
    output.fill(0.f);
    interpolate(input, output);

    // ---- reference-free checks -----------------------------------------
    double lo = 1e30, hi = -1e30;
    long n = 0;
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
                n++;
            }
        }
    }
done_scan:
    if (n && hi - lo < 1e-4) {
        fail("output is constant; the pipeline is not doing anything", hi - lo, 1e-4);
    }

    // Fully opaque pixels must come back exactly. At alpha == 1 the generator
    // computes colour*1 + (1-1)*upsampled over 1 + (1-1)*upsampled, so the
    // whole pyramid cancels and the answer is the input colour bit-for-bit.
    // This holds for every mutant that only touches the pyramid -- it is here
    // to catch a mutant that breaks the compositing algebra itself, and to
    // prove the test is actually reading the pipeline's output.
    {
        int checked = 0;
        for (int y = 32; y < 96; y++) {
            for (int x = 384; x < 448; x++) {
                for (int c = 0; c < 3; c++) {
                    float want = colour(x, y, c), got = output(x, y, c);
                    if (got != want) {
                        fail("opaque pixel was not returned unchanged", got, want);
                        goto done_opaque;
                    }
                    checked++;
                }
            }
        }
    done_opaque:
        if (checked == 0) fail("no opaque pixels were checked", 0, 1);
    }

    // Every weight in this reconstruction is non-negative and the result is
    // normalised by the accumulated coverage, so the output is a convex
    // combination of input colours and cannot leave their range.
    if (n && (lo < -1e-4 || hi > 1.0f + 1e-4)) {
        fail("output left the convex hull of the input colours",
             lo < -1e-4 ? lo : hi, lo < -1e-4 ? 0.0 : 1.0);
    }
    printf("range [%g, %g] over %ld values\n", lo, hi, n);

    // ---- artifact for the output-comparison oracle ----------------------
    // Raw floats. The shipped driver saves an 8-bit PNG, and 8-bit
    // quantisation is precisely what lets a real difference in a float
    // pipeline go unnoticed.
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
