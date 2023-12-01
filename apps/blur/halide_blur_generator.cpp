#include "Halide.h"
#include <iostream>
#include <string>

// int teessst(int z, int y);
// void tesssst2();

// int main() {

//     int s = 4343;
//     std::cout << s << "\n";
//     std::cout << "Hello World!\n";
//     int j = teessst(4 + 3, 8);
//     int k = teessst(999, 9999);
//     teessst(93463499, 9999);
//     teessst(93463499, 9999);
//     std::cout << "j+k: " << j + k << "\n";
//     tesssst2();
//     return 0;
// }

// int teessst(int z, int y) {
//     return z - y;
// }

// void tesssst2() {
//     int j = teessst(4 + 3, 8);
//     int k = teessst(999, 9999);
//     teessst(93463499, 9999);
//     teessst(93463499, 9999);
//     std::cout << "j+k: " << j + k << "\n";
// }

namespace {

enum class BlurGPUSchedule {
    Inline,          // Fully inlining schedule.
    Cache,           // Schedule caching intermedia result of blur_x.
    Slide,           // Schedule enabling sliding window opt within each
                     // work-item or cuda thread.
    SlideVectorize,  // The same as above plus vectorization per work-item.
};

std::map<std::string, BlurGPUSchedule> blurGPUScheduleEnumMap() {
    return {
        {"inline", BlurGPUSchedule::Inline},
        {"cache", BlurGPUSchedule::Cache},
        {"slide", BlurGPUSchedule::Slide},
        {"slide_vector", BlurGPUSchedule::SlideVectorize},
    };
};

class HalideBlur : public Halide::Generator<HalideBlur> {
public:
    GeneratorParam<BlurGPUSchedule> schedule{
        "schedule",
        BlurGPUSchedule::SlideVectorize,
        blurGPUScheduleEnumMap()};
    GeneratorParam<int> tile_x{"tile_x", 32};  // X tile.
    GeneratorParam<int> tile_y{"tile_y", 8};   // Y tile.

    Input<Buffer<uint16_t, 2>> input{"input"};
    Output<Buffer<uint16_t, 2>> blur_y{"blur_y"};

    void generate() {
        // tesssst2();
        // int j = teessst(4 + 3, 8);
        // int k = teessst(999, 9999);
        // teessst(93463499, 9999);
        // teessst(93463499, 9999);
        // std::cout << "j+k: " << j + k << "\n";
        //        Func blur_x("blur_x");
        Var x("x"), y("y");  //, xi("xi"), yi("yi");

        Expr e_0 = x + 1;
        Expr e_1 = y * 3;
        Expr e_2 = input(x, e_1) * input(e_0, y);
        // The algorithm
        blur_y(x, y) = input(x, y) + input(e_0, y);  // + input(x + 2, y)) / 3;
                                                     //        blur_y(x, y) = (blur_x(x, y) + blur_x(x, y + 1) + blur_x(x, y + 2)) / 3;
    }
};

}  // namespace

HALIDE_REGISTER_GENERATOR(HalideBlur, halide_blur)