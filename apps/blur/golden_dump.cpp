// Artifact dump for blur -- test 2 (golden), added by the mutation harness.
//
// blur's shipped test.cpp is the one genuinely self-checking driver in this
// corpus: it compares the Halide pipeline against two reference C++
// implementations in the same file and abort()s on a mismatch. It stays
// exactly as it is and remains test 1.
//
// What it does not do is look at the image border: its comparison loop runs
// over [64, w-64) x [64, h-64), so a mutant that only changes boundary
// behaviour passes it. And blur saves no output file at all, so test 2
// (golden) had nothing of its own to compare and silently restated test 1.
//
// This driver adds the missing observable: run the pipeline once over the same
// deterministic input and write the WHOLE output buffer, border included, as
// raw little-endian uint16. Its own exit status is not the signal -- the bytes
// are. It is swapped in with dataclasses.replace(app, driver_source=...) and
// touches no shipped file.
//
// Written element by element in index order so the bytes never depend on the
// buffer's stride or allocation padding.

#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "halide_blur.h"

using namespace Halide::Runtime;

int main(int argc, char **argv) {
    const char *out_path = (argc > 1) ? argv[1] : "out.bin";

    // Same size and same rand() sequence as apps/blur/test.cpp, so the two
    // drivers see the same pipeline input.
    const int width = 2568, height = 1922;
    Buffer<uint16_t, 2> input(width, height);
    for (int y = 0; y < input.height(); y++) {
        for (int x = 0; x < input.width(); x++) {
            input(x, y) = rand() & 0xfff;
        }
    }

    Buffer<uint16_t, 2> out(input.width() - 8, input.height() - 2);
    int err = halide_blur(input, out);
    if (err != 0) {
        fprintf(stderr, "halide_blur returned %d\n", err);
        return 1;
    }
    out.copy_to_host();

    std::vector<uint16_t> flat;
    flat.reserve((size_t)out.width() * out.height());
    for (int y = 0; y < out.height(); y++) {
        for (int x = 0; x < out.width(); x++) {
            flat.push_back(out(x, y));
        }
    }

    FILE *f = fopen(out_path, "wb");
    if (!f) {
        fprintf(stderr, "cannot open %s\n", out_path);
        return 1;
    }
    size_t n = fwrite(flat.data(), sizeof(uint16_t), flat.size(), f);
    if (fclose(f) != 0 || n != flat.size()) {
        fprintf(stderr, "short write to %s\n", out_path);
        return 1;
    }
    printf("wrote %zu elements to %s\n", flat.size(), out_path);
    return 0;
}
