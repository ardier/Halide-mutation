#include "Halide.h"
#include <iostream>

using namespace Halide;

int main() {
  

   Buffer<float> vectorA(5), vectorB(5);
   for (int i = 0; i < 5; ++i) {
       vectorA(i) = i + 1.0f; // Example values for vector A
       vectorB(i) = 2.0f;    // Example values for vector B
   }

   Func dotProduct("DotProduct");
   RDom r(0, 5); // Define our reduction domain

   dotProduct() = 0.0f;
   dotProduct() += vectorA(r) * vectorB(r);

   // Added line of code to unroll the code
   dotProduct.update().unroll(r.x);

   // Print the loop nest that Halide plans to generate
   dotProduct.print_loop_nest();

   // Realize the dot product function
   Buffer<float> result = dotProduct.realize();

   // Access the scalar result from the buffer
   float dotProductResult = result(0);

   std::cout << "Dot product result: " << dotProductResult << std::endl;

   return 0;
}

