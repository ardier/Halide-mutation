#include <cmath>
#include <cstdint>
#include <cstdio>
#ifdef __SSE2__
#include <emmintrin.h>
#elif __ARM_NEON
#include <arm_neon.h>
#endif

#include "Halide.h"

// using namespace Halide::Runtime;

Halide::Buffer<uint16_t, 2> blur(Halide::Buffer<uint16_t, 2> in) {
    Halide::Buffer<uint16_t, 2> tmp(in.width() - 8, in.height());
    Halide::Buffer<uint16_t, 2> out(in.width() - 8, in.height() - 2);

    for (int y = 0; y < tmp.height(); y++)
        for (int x = 0; x < tmp.width(); x++)
            tmp(x, y) = (in(x, y) + in(x + 1, y) + in(x + 2, y)) / 3;

    for (int y = 0; y < out.height(); y++)
        for (int x = 0; x < out.width(); x++)
            out(x, y) = (tmp(x, y) + tmp(x, y + 1) + tmp(x, y + 2)) / 3;

    return out;
}

#include "halide_blur_mull.h"

int main(int argc, char **argv) {

    const int width = 648;
    const int height = 482;

    Halide::Buffer<uint16_t, 2> input(width, height);

    for (int y = 0; y < input.height(); y++) {
        for (int x = 0; x < input.width(); x++) {
            input(x, y) = 0;  // rand() & 0xfff;
        }
    }

    Halide::Buffer<uint16_t, 2> blurry = blur(input);

    Halide::Buffer<uint16_t, 2> halide = blur_halide(input);

    for (int y = 64; y < input.height() - 64; y++) {
        for (int x = 64; x < input.width() - 64; x++) {
            if (blurry(x, y) != halide(x, y)) {
                printf("difference at (%d,%d): %d %d\n", x, y, blurry(x, y), halide(x, y));
                abort();
            }
        }
    }

    printf("Success!\n");
    return 0;
}
