// Artifact dump for conv_layer -- test 2 (golden), added by the mutation
// harness.
//
// The shipped apps/conv_layer/process.cpp computes an output buffer, times it,
// prints "Success!" and throws the buffer away. With no artifact on disk, test
// 2 (golden) fell back to normalised stdout -- which carries no pipeline
// output -- so its column only restated test 1's exit status and was not an
// independent measurement.
//
// This driver builds the same inputs from the same deterministic rand()
// sequence, calls the pipeline once, and writes the whole output buffer as raw
// float32. No benchmark loop: the timing that makes the shipped driver's
// stdout non-deterministic is exactly what has to go. Its own exit status is
// not the signal -- the bytes are.
//
// Swapped in with dataclasses.replace(app, driver_source=...); no shipped file
// is touched. Only the manually scheduled variant is called, so the artifact
// reflects the mutation directly.
//
// Written element by element in index order so the bytes never depend on the
// buffer's stride or allocation padding.

#include <cstdio>
#include <cstdlib>
#include <vector>

#include "HalideBuffer.h"
#include "conv_layer.h"

using namespace Halide::Runtime;

int main(int argc, char **argv) {
    const char *out_path = (argc > 1) ? argv[1] : "out.bin";

    // Same shapes and same rand() order as apps/conv_layer/process.cpp.
    const int N = 5, CI = 128, CO = 128, W = 100, H = 80;

    Buffer<float, 4> input(CI, W + 2, H + 2, N);
    Buffer<float, 4> filter(CO, 3, 3, CI);
    Buffer<float, 1> bias(CO);

    for (int c = 0; c < input.dim(3).extent(); c++)
        for (int z = 0; z < input.channels(); z++)
            for (int y = 0; y < input.height(); y++)
                for (int x = 0; x < input.width(); x++)
                    input(x, y, z, c) = rand();

    for (int c = 0; c < filter.dim(3).extent(); c++)
        for (int z = 0; z < filter.channels(); z++)
            for (int y = 0; y < filter.height(); y++)
                for (int x = 0; x < filter.width(); x++)
                    filter(x, y, z, c) = rand();

    for (int x = 0; x < bias.width(); x++) bias(x) = rand();

    Buffer<float, 4> output(CO, W, H, N);
    output.fill(0.0f);

    int err = conv_layer(input, filter, bias, output);
    if (err != 0) {
        fprintf(stderr, "conv_layer returned %d\n", err);
        return 1;
    }
    output.copy_to_host();

    std::vector<float> flat;
    flat.reserve((size_t)CO * W * H * N);
    for (int c = 0; c < output.dim(3).extent(); c++)
        for (int z = 0; z < output.channels(); z++)
            for (int y = 0; y < output.height(); y++)
                for (int x = 0; x < output.width(); x++)
                    flat.push_back(output(x, y, z, c));

    FILE *f = fopen(out_path, "wb");
    if (!f) {
        fprintf(stderr, "cannot open %s\n", out_path);
        return 1;
    }
    size_t n = fwrite(flat.data(), sizeof(float), flat.size(), f);
    if (fclose(f) != 0 || n != flat.size()) {
        fprintf(stderr, "short write to %s\n", out_path);
        return 1;
    }
    printf("wrote %zu elements to %s\n", flat.size(), out_path);
    return 0;
}
