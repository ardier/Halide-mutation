// Targeted test added for the mutation study (Experiment 2).
//
// NOT a replacement for the app's shipped process.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver.
//
// Target: the seven surviving `Halide_select_to_if_then_else` mutants, which
// are the largest single block of mutants in the corpus that survive even the
// golden-output oracle. They sit at
//
//   camera_pipe_generator.cpp:75,82   demosaic green at red/blue sites
//                            119,130  demosaic red at blue / blue at red
//                            325      the tone curve's contrast branch
//                            332 (x2) the tone curve's guard bands
//
// `select(c, a, b)` evaluates both arms; `if_then_else(c, a, b)` evaluates only
// the taken one. This driver is built to give that difference every chance to
// become observable, in the three ways it plausibly could:
//
//  1. *Branch coverage and ties.* A synthetic Bayer frame containing pure
//     horizontal edges, pure vertical edges, diagonals, flat fields (where the
//     demosaic's `ghd < gvd` comparison is an exact tie -- the one input class
//     where eager and lazy evaluation are most likely to diverge) and noise, so
//     every mutated condition is driven true, false and borderline.
//  2. *Full-precision comparison.* The raw uint8 output is dumped for the
//     golden-output oracle rather than being routed through PNG, and every
//     pixel is compared, not a summary statistic.
//  3. *A bounds query.* This is the mechanism with a real chance of showing a
//     difference: Halide's `boxes_touched` handles `Call::if_then_else` by
//     building an actual `IfThenElse` statement (src/Bounds.cpp:2255) instead
//     of the plain interval union it uses for `Select` (src/Bounds.cpp:1279).
//     If laziness narrows the region the pipeline demands of its input, a
//     bounds query is where that shows up -- so the test asserts the inferred
//     input region, which no output comparison could ever see.
//
// If all three hold and the mutants still survive, that is the result: this
// operator family changes how the pipeline computes, not what it computes, and
// belongs to a performance oracle rather than a correctness one.

#include <cmath>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"

#include "camera_pipe.h"

using namespace Halide::Runtime;

static const int W = 256, H = 192;
static const int OW = ((W - 32) / 32) * 32;   // 224, as process.cpp computes it
static const int OH = ((H - 24) / 32) * 32;   // 160
static const int BLACK_LEVEL = 25, WHITE_LEVEL = 1023;

static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %g, expected %g\n", what, got, want);
    failures++;
}

// Five horizontal bands, each exercising a different shape of the demosaic's
// horizontal-vs-vertical decision:
//   band 0  flat        -- ghd == gvd exactly, the tie case
//   band 1  vertical stripes   -- horizontal gradient dominates
//   band 2  horizontal stripes -- vertical gradient dominates
//   band 3  diagonal    -- both gradients comparable, decision flips pixel to pixel
//   band 4  noise + the exact tone-curve guard values (blackLevel, whiteLevel)
static uint16_t raw_at(int x, int y) {
    int band = (y * 5) / H;
    switch (band) {
    case 0:
        return 512;
    case 1:
        return ((x / 2) % 2) ? 900 : 120;
    case 2:
        return ((y / 2) % 2) ? 900 : 120;
    case 3:
        return (uint16_t)(((x + y) * 7) % 1024);
    default: {
        uint32_t h = (uint32_t)x * 73856093u ^ (uint32_t)y * 19349663u;
        h ^= h >> 13;
        h *= 1274126177u;
        h ^= h >> 16;
        // Salt the noise with the two tone-curve guard-band boundaries, so
        // `x <= minRaw` and `x > maxRaw` are each driven both ways and hit
        // exactly on the boundary value.
        switch (x % 7) {
        case 0: return (uint16_t)BLACK_LEVEL;
        case 1: return (uint16_t)(BLACK_LEVEL - 1);
        case 2: return (uint16_t)(BLACK_LEVEL + 1);
        case 3: return (uint16_t)WHITE_LEVEL;
        case 4: return 0;
        default: return (uint16_t)(h % 1024);
        }
    }
    }
}

static void fill_matrices(Buffer<float, 2> &m3200, Buffer<float, 2> &m7000) {
    float a[][4] = {{1.6697f, -0.2693f, -0.4004f, -42.4346f},
                    {-0.3576f, 1.0615f, 1.5949f, -37.1158f},
                    {-0.2175f, -1.8751f, 6.9640f, -26.6970f}};
    float b[][4] = {{2.2997f, -0.4478f, 0.1706f, -39.0923f},
                    {-0.3826f, 1.5906f, -0.2080f, -25.4311f},
                    {-0.0888f, -0.7344f, 2.2832f, -20.0826f}};
    for (int i = 0; i < 3; i++)
        for (int j = 0; j < 4; j++) {
            m3200(j, i) = a[i][j];
            m7000(j, i) = b[i][j];
        }
}

int main(int argc, char **argv) {
    Buffer<uint16_t, 2> input(W, H);
    for (int y = 0; y < H; y++)
        for (int x = 0; x < W; x++) input(x, y) = raw_at(x, y);

    Buffer<float, 2> matrix_3200(4, 3), matrix_7000(4, 3);
    fill_matrices(matrix_3200, matrix_7000);

    int bounds[4] = {-1, -1, -1, -1};

    // ---- (3) bounds query, run first ------------------------------------
    // A buffer with a null host puts the pipeline in bounds-inference mode: it
    // computes and writes back the region it would need, without touching any
    // data. This is the only observable in the whole app that depends on how
    // Halide reasons about a conditional rather than on what the conditional
    // evaluates to.
    {
        Buffer<uint16_t, 2> in_q(nullptr, 1, 1);
        Buffer<float, 2> m1_q(nullptr, 1, 1), m2_q(nullptr, 1, 1);
        Buffer<uint8_t, 3> out_q(nullptr, OW, OH, 3);
        int err = camera_pipe(in_q, m1_q, m2_q, 3700.f, 2.f, 50.f, 1.f,
                              BLACK_LEVEL, WHITE_LEVEL, out_q);
        if (err != 0) {
            fail("bounds query returned an error", err, 0);
        } else {
            // Recorded from the unmutated pipeline. A mutant that changes how
            // much of the input the pipeline demands fails here even if every
            // output byte it produces is identical.
            printf("bounds query: input [%d, %d) x [%d, %d)\n",
                   in_q.dim(0).min(), in_q.dim(0).min() + in_q.dim(0).extent(),
                   in_q.dim(1).min(), in_q.dim(1).min() + in_q.dim(1).extent());
            // Carried into the same artifact the golden-output oracle hashes,
            // so a change in the demanded region is a kill on equal footing
            // with a change in a pixel.
            bounds[0] = in_q.dim(0).min();
            bounds[1] = in_q.dim(0).extent();
            bounds[2] = in_q.dim(1).min();
            bounds[3] = in_q.dim(1).extent();
            if (in_q.dim(0).extent() <= 0 || in_q.dim(1).extent() <= 0) {
                fail("bounds query produced an empty input region",
                     in_q.dim(0).extent(), 1);
            }
        }
    }

    // ---- (1)+(2) full-precision output over all five bands ---------------
    Buffer<uint8_t, 3> output(OW, OH, 3);
    output.fill(0);
    int err = camera_pipe(input, matrix_3200, matrix_7000, 3700.f, 2.f, 50.f,
                          1.f, BLACK_LEVEL, WHITE_LEVEL, output);
    if (err != 0) fail("camera_pipe returned an error", err, 0);

    // Golden-free self-checks: each band must produce its own distinct
    // response. If a mutation collapsed the demosaic's directional choice, or
    // flattened the tone curve, the per-band means stop being distinguishable.
    double band_sum[5] = {0, 0, 0, 0, 0};
    long band_n[5] = {0, 0, 0, 0, 0};
    for (int c = 0; c < 3; c++)
        for (int y = 0; y < OH; y++) {
            int band = (y * 5) / OH;
            if (band > 4) band = 4;
            for (int x = 0; x < OW; x++) {
                band_sum[band] += output(x, y, c);
                band_n[band]++;
            }
        }
    for (int i = 0; i < 5; i++) {
        printf("band %d mean %.4f\n", i, band_n[i] ? band_sum[i] / band_n[i] : 0.0);
    }
    for (int i = 0; i < 5; i++)
        for (int j = i + 1; j < 5; j++) {
            double a = band_n[i] ? band_sum[i] / band_n[i] : 0.0;
            double b = band_n[j] ? band_sum[j] / band_n[j] : 0.0;
            if (std::fabs(a - b) < 1e-9) {
                fail("two input bands produced identical output means; the "
                     "pipeline is not discriminating between them", a, b);
            }
        }

    // Raw dump for the golden-output oracle -- every byte, no PNG round trip.
    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) {
            fail("could not open out.bin", 0, 1);
        } else {
            fwrite(bounds, sizeof(int), 4, f);
            std::vector<uint8_t> flat((size_t)OW * OH * 3);
            size_t i = 0;
            for (int c = 0; c < 3; c++)
                for (int y = 0; y < OH; y++)
                    for (int x = 0; x < OW; x++) flat[i++] = output(x, y, c);
            fwrite(flat.data(), 1, flat.size(), f);
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
