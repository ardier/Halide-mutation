// Minimal added driver for the mutation pipeline: exercises exactly one
// resize instantiation (box, uint8, downsample) instead of the shipped
// resize.cpp, which links all 24 GeneratorParam combinations at once.
// Not part of the app's shipped CMake target.
#include <cstdio>

#include "HalideBuffer.h"
#include "halide_image_io.h"

#include "resize_box_uint8_down.h"

int main(int argc, char **argv) {
    if (argc != 3) {
        printf("Usage: %s in out\n", argv[0]);
        return 1;
    }

    Halide::Runtime::Buffer<uint8_t> in = Halide::Tools::load_and_convert_image(argv[1]);

    float scale_factor = 0.5f;
    int out_width = (int)(in.width() * scale_factor);
    int out_height = (int)(in.height() * scale_factor);
    Halide::Runtime::Buffer<uint8_t> out(out_width, out_height, in.channels());

    int result = resize_box_uint8_down(in, scale_factor, out);
    if (result != 0) {
        fprintf(stderr, "resize_box_uint8_down failed: %d\n", result);
        return 1;
    }

    Halide::Tools::convert_and_save_image(out, argv[2]);
    printf("Success!\n");
    return 0;
}
