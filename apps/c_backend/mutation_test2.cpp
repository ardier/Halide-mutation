// Second targeted test for c_backend, added for the mutation study.
//
// mutation_test.cpp (the first one) closed the missing-assertion gap and took
// this benchmark from 12.5% to 84.4%. Three arithmetic mutants survived it, all
// at the same spot -- pipeline_generator.cpp:17 column 64, the `- 1` in
//
//     clamp(x + 2, 0, input.dim(0).extent() - 1)
//
// mutated to `+ 1`, `/ 1` and `* 1`, i.e. an upper clamp bound of extent+1,
// extent and extent respectively instead of extent-1.
//
// They survived for a reason that has nothing to do with the assertions: the
// first test inherits run.cpp's 1432-wide input, while f is only ever evaluated
// over x in [0, 633). x + 2 therefore tops out at 634, never reaches 1431, and
// the upper clamp is dead code. An off-by-one in a bound that is never attained
// cannot be observed no matter how carefully the output is checked.
//
// This test changes one thing: the input is narrower than the region the
// pipeline reads, so the upper clamp is live. Under the mutants the pipeline
// then demands input columns beyond the buffer, and Halide's own input bounds
// assertion fires -- the pipeline returns a non-zero error code, which this
// test checks for (the first test did not).
//
// The pipeline logic is identical to mutation_test.cpp; only the input width
// and the error checking differ.

#include <cassert>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "pipeline_c.h"
#include "pipeline_native.h"

using namespace Halide::Runtime;

extern "C" int an_extern_func(int x, int y) {
    return x + y;
}

extern "C" int an_extern_stage(halide_buffer_t *in, halide_buffer_t *out) {
    if (in->is_bounds_query()) {
        in->dim[0].extent = 10;
        in->dim[1].extent = 10;
        in->dim[0].min = 0;
        in->dim[1].min = 0;
    } else {
        assert(out->host);
        int result = 0;
        int16_t *origin = (int16_t *)in->host;
        origin -= in->dim[0].min * in->dim[0].stride;
        origin -= in->dim[1].min * in->dim[1].stride;
        for (int y = 0; y < 10; y++) {
            for (int x = 0; x < 10; x++) {
                result += origin[x * in->dim[0].stride + y * in->dim[1].stride];
            }
        }
        int16_t *dst = (int16_t *)(out->host);
        dst[0] = result;
    }
    return 0;
}

// Narrow enough that clamp(x + 2, 0, W - 1) actually binds: f is evaluated over
// x in [0, OH), so x + 2 reaches OH + 1 = 634, well past W - 1 = 299.
static const int W = 300, H = 324;
static const int OW = 423, OH = 633;
static const int FN = OH;

static int failures = 0;

static void fail(const char *what, int x, int y, long long got, long long want) {
    if (failures < 10) {
        printf("FAIL %s at (%d, %d): got %lld, expected %lld\n", what, x, y, got, want);
    }
    failures++;
}

static int hclamp(int v, int lo, int hi) {
    int t = v > lo ? v : lo;
    return t < hi ? t : hi;
}

int main(int argc, char **argv) {
    Buffer<uint16_t, 2> in(W, H);
    uint32_t s = 987654321u;
    for (int y = 0; y < H; y++) {
        for (int x = 0; x < W; x++) {
            s = s * 1664525u + 1013904223u;
            // Small values, so nothing wraps and no output pixel lands on the
            // max(0, ...) floor -- same reasoning as the first test's second
            // regime, which is where the oracle is live at every pixel.
            in(x, y) = (uint16_t)((s >> 16) % 200u);
        }
    }

    // Make the columns the clamp folds onto distinctive, so a shifted upper
    // bound changes values rather than merely changing which equal value is
    // read. Columns W-3..W-1 get a signature the rest of the image never uses.
    for (int y = 0; y < H; y++) {
        for (int x = W - 3; x < W; x++) in(x, y) = (uint16_t)(150 + (x - (W - 3)) * 13 + (y % 3));
    }

    std::vector<uint16_t> f((size_t)FN * FN);
    for (int y = 0; y < FN; y++) {
        for (int x = 0; x < FN; x++) {
            uint16_t v = in(hclamp(x + 2, 0, W - 1), hclamp(y - 2, 0, H - 1));
            f[(size_t)y * FN + x] = (uint16_t)((uint16_t)(v * 17) / 13);
        }
    }
    int hsum = 0;
    for (int y = 0; y < 10; y++)
        for (int x = 0; x < 10; x++) hsum += (int16_t)f[(size_t)y * FN + x];
    const int16_t h_value = (int16_t)hsum;

    Buffer<uint16_t, 2> out_native(OW, OH), out_c(OW, OH);
    out_native.fill(0);
    out_c.fill(0);

    // Checked, unlike in the first test: under these mutants the pipeline does
    // not produce wrong numbers, it refuses to run at all, because Halide's own
    // input bounds assertion catches the over-wide read the mutated clamp asks
    // for. Ignoring the return code would let exactly that go unnoticed.
    int err_native = pipeline_native(in, out_native);
    if (err_native != 0) fail("pipeline_native returned an error", 0, 0, err_native, 0);
    int err_c = pipeline_c(in, out_c);
    if (err_c != 0) fail("pipeline_c returned an error", 0, 0, err_c, 0);

    if (!failures) {
        long clamped = 0;
        for (int y = 0; y < OH; y++) {
            for (int x = 0; x < OW; x++) {
                uint16_t sum16 = (uint16_t)(f[(size_t)x * FN + y] + f[(size_t)y * FN + x]);
                int32_t acc = (int32_t)sum16 + (x + y) + (int32_t)h_value;
                if (acc < 0) acc = 0;
                uint16_t want = (uint16_t)acc;
                if (out_native(x, y) != want) fail("pipeline_native", x, y, out_native(x, y), want);
                if (out_c(x, y) != want) fail("pipeline_c", x, y, out_c(x, y), want);
            }
        }
        // Sanity: the upper clamp really is live for this input, which is the
        // whole premise of the test. Every x >= W - 2 folds onto column W - 1.
        for (int x = W - 2; x < FN; x++) clamped++;
        if (clamped < 100) fail("upper x clamp is not exercised", 0, 0, clamped, 100);
        printf("upper x clamp binds for %ld of %d columns of f\n", clamped, FN);
    }

    if (failures) {
        printf("mutation_test2: %d failure(s)\n", failures);
        return 1;
    }
    printf("mutation_test2: OK\n");
    return 0;
}
