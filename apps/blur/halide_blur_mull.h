#include "Halide.h"
#include <iostream>
#include <string>

Halide::Expr stupid_hack(Halide::Func x, Halide::Func y, Halide::Var a, Halide::Var b) {
    Halide::Expr e0 = a * 3;
    Halide::Expr e1 = x(a, b) * y(a, b);
    Halide::Expr e2 = a - 3;
    Halide::Expr e3 = x(a, b) - y(a, b);
    Halide::Expr e4 = a / 3;
    Halide::Expr e5 = x(a, b) / y(a, b);
    return e0 - e1;
}

Halide::Buffer<uint16_t, 2> blur_halide(Halide::Buffer<uint16_t, 2> input) {
    Halide::Var x("x"), y("y");
    Halide::Func blur_x("blur_x"), blur_y("blur_y");

    blur_x(x, y) = (input(x, y) - input(x + 1, y) + input(x + 2, y)) / 3;
    blur_y(x, y) = (blur_x(x, y) + blur_x(x, y + 1) + blur_x(x, y + 2)) / 3;

    Halide::Buffer<uint16_t, 2> out = blur_y.realize({input.width() - 8, input.height() - 2});
    return out;
}