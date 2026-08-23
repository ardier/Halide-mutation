// Targeted test added for the mutation study.
//
// NOT a replacement for the app's shipped process.cpp -- that file is left
// exactly as upstream ships it. This is an additional driver linked against the
// same generated pipeline.
//
// Why this file exists: stencil_chain has no added driver registered, so the
// sweep scored `test2_added` against the shipped driver's own out.png and the
// two test columns were two readings of one program.
//
// The assertion. The pipeline is 32 chained 5x5 stencils over a repeat_edge
// boundary condition. On a CONSTANT image, repeat_edge makes every tap of
// every stage see the same value, so every stage is spatially constant and so
// is the output -- whatever the weights are, whatever the accumulator type is,
// and however the integer arithmetic wraps. That last part is why the check is
// "spatially constant" rather than a specific value: the weights sum to 225 and
// the accumulation is integral, so predicting the exact value would mean
// asserting the app's own overflow behaviour rather than a property of the
// pipeline. Spatial constancy is the part that is unarguable, and it fails as
// soon as a mutation makes a stencil tap depend on position in a way the
// original does not -- a mutated coordinate offset, a broken boundary
// condition, or an unbalanced accumulation.
//
// A second run on structured input provides the artifact, dumped as raw
// uint16 rather than through a PNG.

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "stencil_chain.h"
#include "stencil_chain_auto_schedule.h"

using namespace Halide::Runtime;

// The CPU schedule hardcodes its tile size from the app's own image rather
// than from the buffer it is given:
//
//     const int w = 1536 + expansion, h = 2560 + expansion;
//     out.compute_root().tile(x, y, xo, yo, xi, yi, w / 4, h / 4)
//
// so the output must be at least 384 x 640 or the tail strategy shifts the
// tile inwards past the buffer's min and the pipeline aborts with
// "Output buffer output is accessed at -192". This is the smallest size that
// schedule accepts; a smaller image is not a smaller test here, it is a
// different bug.
static const int W = 384, H = 640;
static int failures = 0;

static void fail(const char *what, double got, double want) {
    if (failures < 10) printf("FAIL %s: got %.9g, expected %.9g\n", what, got, want);
    failures++;
}

int main(int argc, char **argv) {
    // ---- 1. a constant image must stay spatially constant --------------
    {
        Buffer<uint16_t, 2> flat(W, H);
        flat.fill((uint16_t)1234);
        Buffer<uint16_t, 2> out(W, H);
        out.fill(0);
        stencil_chain(flat, out);
        uint16_t first = out(0, 0);
        for (int y = 0; y < H; y++)
            for (int x = 0; x < W; x++) {
                if (out(x, y) != first) {
                    printf("differs at (%d,%d)\n", x, y);
                    fail("a constant image did not stay constant through the chain",
                         out(x, y), first);
                    goto done_flat;
                }
            }
    done_flat:
        printf("flat-field constant value %u\n", (unsigned)first);
    }

    // ---- 2. structured input, dumped ------------------------------------
    Buffer<uint16_t, 2> input(W, H);
    for (int y = 0; y < H; y++)
        for (int x = 0; x < W; x++) {
            uint32_t h = (uint32_t)(x / 3) * 73856093u ^ (uint32_t)(y / 3) * 19349663u;
            h ^= h >> 13; h *= 1274126177u; h ^= h >> 16;
            input(x, y) = (uint16_t)(h & 0x0fff);
        }

    Buffer<uint16_t, 2> output(W, H);
    output.fill(0);
    stencil_chain(input, output);

    unsigned lo = 0xffffu, hi = 0;
    for (int y = 0; y < H; y++)
        for (int x = 0; x < W; x++) {
            unsigned v = output(x, y);
            lo = v < lo ? v : lo; hi = v > hi ? v : hi;
        }
    if (hi == lo) fail("output is constant on a textured image", hi - lo, 1);
    printf("range [%u, %u]\n", lo, hi);

    {
        FILE *f = fopen("out.bin", "wb");
        if (!f) fail("could not open out.bin", 0, 1);
        else {
            std::vector<uint16_t> flat((size_t)W * H);
            size_t i = 0;
            for (int y = 0; y < H; y++)
                for (int x = 0; x < W; x++) flat[i++] = output(x, y);
            fwrite(flat.data(), sizeof(uint16_t), flat.size(), f);
            fclose(f);
        }
    }
    if (failures) { printf("mutation_test: %d failure(s)\n", failures); return 1; }
    printf("mutation_test: OK\n");
    return 0;
}
