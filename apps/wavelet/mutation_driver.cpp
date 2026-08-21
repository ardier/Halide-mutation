// Minimal added driver for the mutation pipeline: exercises exactly one of
// wavelet's 4 generator classes (haar_x -- the one with a BoundaryConditions
// call) instead of the shipped wavelet.cpp, which links all 4 at once.
// Not part of the app's shipped CMake target.
#include <cstdio>

#include "HalideBuffer.h"
#include "halide_image_io.h"

#include "haar_x.h"

int main(int argc, char **argv) {
    if (argc != 3) {
        printf("Usage: %s in out\n", argv[0]);
        return 1;
    }

    Halide::Runtime::Buffer<float> loaded = Halide::Tools::load_and_convert_image(argv[1]);
    Halide::Runtime::Buffer<float, 2> in =
        loaded.dimensions() == 2 ? Halide::Runtime::Buffer<float, 2>(loaded)
                                  : Halide::Runtime::Buffer<float, 2>(loaded.sliced(2, 0));

    Halide::Runtime::Buffer<float, 3> out(in.width() / 2, in.height(), 2);

    int result = haar_x(in, out);
    if (result != 0) {
        fprintf(stderr, "haar_x failed: %d\n", result);
        return 1;
    }

    // Rearrange the 2-channel transform coefficients into one clamped image
    // so O2 has a real output artifact to byte-compare, mirroring wavelet.cpp
    // save_transformed's own convention.
    Halide::Runtime::Buffer<float, 2> rearranged(out.width() * 2, out.height());
    for (int y = 0; y < out.height(); y++) {
        for (int x = 0; x < out.width(); x++) {
            float lo = out(x, y, 0), hi = out(x, y, 1);
            rearranged(x, y) = lo < 0.0f ? 0.0f : (lo > 1.0f ? 1.0f : lo);
            float hiv = hi * 4.f + 0.5f;
            rearranged(x + out.width(), y) = hiv < 0.0f ? 0.0f : (hiv > 1.0f ? 1.0f : hiv);
        }
    }

    Halide::Tools::convert_and_save_image(rearranged, argv[2]);
    printf("Success!\n");
    return 0;
}
