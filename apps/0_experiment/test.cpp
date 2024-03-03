#include "halide_dotProduct.h" // Include the header for the generated Halide code
#include <HalideBuffer.h>
#include <iostream>

using namespace Halide::Runtime;

int main() {
    // Define the size of the input vectors
    const int size = 5;

    // Initialize input vectors as Halide buffers
    Buffer<float> vectorA(size), vectorB(size);

    // Fill the input vectors with values
    for (int i = 0; i < size; ++i) {
        vectorA(i) = i + 1.0f; // e.g., vectorA = [1.0, 2.0, 3.0, 4.0, 5.0]
        vectorB(i) = 2.0f;    // e.g., vectorB = [2.0, 2.0, 2.0, 2.0, 2.0]
    }

    // Prepare a buffer for the result (scalar output treated as a 1D buffer with a single element)
    Buffer<float> resultBuffer(1);

    // Call the Halide-generated function
    int error = halide_dotProduct(vectorA, vectorB, resultBuffer);
    if (error) {
        std::cerr << "Error: Halide function returned non-zero error code " << error << std::endl;
        return -1;
    }

    // Access and print the result
    std::cout << "Dot product result: " << resultBuffer(0) << std::endl;

    return 0;
}
