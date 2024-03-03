#include "Halide.h"

using namespace Halide;

class DotProductGenerator : public Generator<DotProductGenerator> {
public:
    Input<Buffer<float>> vectorA{"vectorA", 1};
    Input<Buffer<float>> vectorB{"vectorB", 1};
    
    Output<Buffer<float>> result{"result", 1};

    void generate() {
        Var x; // Variable 'x' is declared but not used since we are dealing with scalar output
        
        Func dotProduct("DotProduct");
        RDom r(vectorA.dim(0).min(), vectorA.dim(0).extent());
        
        dotProduct() = sum(vectorA(r) * vectorB(r)); // Directly compute the dot product
        
        result(x) = dotProduct(); // Assign the computed dot product to the output buffer
        result.bound(x, 0, 1); // Constrain the output to a single value

    }
};

HALIDE_REGISTER_GENERATOR(DotProductGenerator, halide_dotProduct)