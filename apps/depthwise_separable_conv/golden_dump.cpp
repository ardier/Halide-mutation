// Artifact dump for depthwise_separable_conv -- test 2 (golden), added by the
// mutation harness.
//
// The shipped apps/depthwise_separable_conv/process.cpp computes an output
// buffer, times it, prints "Success!" and throws the buffer away. With no
// artifact on disk, test 2 (golden) fell back to normalised stdout -- which
// carries no pipeline output -- so its column only restated test 1's exit
// status and was not an independent measurement.
//
// This driver builds the same inputs from the same deterministic rand()
// sequence, calls the pipeline once, and writes the whole output buffer as raw
// float32. No benchmark loop. Its own exit status is not the signal -- the
// bytes are.
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
#include "depthwise_separable_conv.h"

using namespace Halide::Runtime;

int main(int argc, char **argv) {
    const char *out_path = (argc > 1) ? argv[1] : "out.bin";

    // Second layer of MobileNet v2 -- same shapes and same rand() order as
    // apps/depthwise_separable_conv/process.cpp.
    const int N = 4, CI = 32, CO = 16, CM = 1, W = 112, H = 112;

    Buffer<float, 4> input(CI, W, H, N);
    Buffer<float, 4> depthwise_filter(CM, CI, 3, 3);
    Buffer<float, 2> pointwise_filter(CO, CI * CM);
    Buffer<float, 1> bias(CO);

    for (int c = 0; c < input.dim(3).extent(); c++)
        for (int z = 0; z < input.channels(); z++)
            for (int y = 0; y < input.height(); y++)
                for (int x = 0; x < input.width(); x++)
                    input(x, y, z, c) = rand();

    for (int c = 0; c < depthwise_filter.dim(3).extent(); c++)
        for (int z = 0; z < depthwise_filter.channels(); z++)
            for (int y = 0; y < depthwise_filter.height(); y++)
                for (int x = 0; x < depthwise_filter.width(); x++)
                    depthwise_filter(x, y, z, c) = rand();

    for (int y = 0; y < pointwise_filter.height(); y++)
        for (int x = 0; x < pointwise_filter.width(); x++)
            pointwise_filter(x, y) = rand();

    for (int x = 0; x < bias.width(); x++) bias(x) = rand();

    Buffer<float, 4> output(CO, W, H, N);
    output.fill(0.0f);

    int err = depthwise_separable_conv(input, depthwise_filter,
                                       pointwise_filter, bias, output);
    if (err != 0) {
        fprintf(stderr, "depthwise_separable_conv returned %d\n", err);
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
