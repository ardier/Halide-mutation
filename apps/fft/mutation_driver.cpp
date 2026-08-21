// Minimal added driver for the mutation pipeline: exercises exactly one fft
// instantiation (16x16 real-to-complex forward transform) instead of the
// shipped fft_aot_test.cpp, which links all 4 direction/type combinations at
// once. The assertion logic below is the forward-r2c block of
// fft_aot_test.cpp, reused verbatim -- this is a real correctness oracle
// (known closed-form magnitude/phase per bin), not just a crash check.
// Not part of the app's shipped CMake target.
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <iostream>

#include "HalideBuffer.h"

#include "fft_forward_r2c.h"

namespace {
const float kPi = 3.14159265358979310000f;
const int32_t kSize = 16;
}  // namespace

using Halide::Runtime::Buffer;

Buffer<float, 3> real_buffer(int32_t y_size = kSize) {
    return Buffer<float, 3>::make_interleaved(kSize, y_size, 1);
}

Buffer<float, 3> complex_buffer(int32_t y_size = kSize) {
    return Buffer<float, 3>::make_interleaved(kSize, y_size, 2);
}

float &re(Buffer<float, 3> &b, int x, int y) { return b(x, y, 0); }
float &im(Buffer<float, 3> &b, int x, int y) { return b(x, y, 1); }

int main() {
    std::cout << std::fixed;

    float signal_1d[kSize];
    for (size_t i = 0; i < kSize; i++) {
        signal_1d[i] = 0;
        for (size_t k = 1; k < 5; k++) {
            signal_1d[i] += cos(2 * kPi * (k * (i / (float)kSize) + (k / 16.0f)));
        }
    }

    auto in = real_buffer();
    for (int j = 0; j < kSize; j++) {
        for (int i = 0; i < kSize; i++) {
            in(i, j, 0) = signal_1d[i] + signal_1d[j];
        }
    }

    auto out = complex_buffer(kSize / 2 + 1);

    int halide_result = fft_forward_r2c(in, out);
    if (halide_result != 0) {
        std::cerr << "fft_forward_r2c failed returning " << halide_result << "\n";
        return 1;
    }

    for (size_t i = 1; i < 5; i++) {
        float real = re(out, (int)i, 0);
        float imaginary = im(out, (int)i, 0);
        float magnitude = sqrt(real * real + imaginary * imaginary);
        if (fabs(magnitude - .5f) > .001) {
            std::cerr << "bad magnitude for horizontal bin " << i << ": " << magnitude << "\n";
            return 1;
        }
        float phase_angle = atan2(imaginary, real);
        if (fabs(phase_angle - (i / 16.0f) * 2 * kPi) > .001) {
            std::cerr << "bad phase for horizontal bin " << i << ": " << phase_angle << "\n";
            return 1;
        }
    }

    // Print the full complex output so O2 (stdout-diff) has real content to
    // compare, not just "Success!".
    for (int y = 0; y < kSize / 2 + 1; y++) {
        for (int x = 0; x < kSize; x++) {
            printf("%.4f %.4f  ", re(out, x, y), im(out, x, y));
        }
        printf("\n");
    }

    printf("Success!\n");
    return 0;
}
