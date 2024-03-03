#ifndef HALIDE_STUB_halide_dotProduct
#define HALIDE_STUB_halide_dotProduct

/* MACHINE-GENERATED - DO NOT EDIT */

#include <cassert>
#include <iterator>
#include <map>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "Halide.h"

namespace halide_register_generator {
namespace halide_dotProduct_ns {
extern std::unique_ptr<Halide::Internal::AbstractGenerator> factory(const Halide::GeneratorContext& context);
}  // namespace halide_register_generator
}  // namespace halide_dotProduct


class halide_dotProduct final : public Halide::NamesInterface {
public:
 struct Inputs final {
  Halide::Internal::StubInputBuffer<float> vectorA;
  Halide::Internal::StubInputBuffer<float> vectorB;

  Inputs() {}

  Inputs(
   const Halide::Internal::StubInputBuffer<float>& vectorA
   , const Halide::Internal::StubInputBuffer<float>& vectorB
  ) : 
   vectorA(vectorA)
   , vectorB(vectorB)
  {
  }
 };

 struct GeneratorParams final {
  GeneratorParams() {}

 };

 struct Outputs final {
  // Outputs
  Halide::Internal::StubOutputBuffer<float> result;

  // The Target used
  Target target;

  // operator Func() and operator()() overloads omitted because the sole Output is not Func.

  // get_pipeline() and realize() overloads omitted because some Outputs are not Func.
 };

 HALIDE_NO_USER_CODE_INLINE static Outputs generate(
  const GeneratorContext& context,
  const Inputs& inputs,
  const GeneratorParams& generator_params = GeneratorParams()
 )
 {
  std::shared_ptr<Halide::Internal::AbstractGenerator> generator = halide_register_generator::halide_dotProduct_ns::factory(context);
  generator->bind_input("vectorA", Halide::Internal::StubInputBuffer<>::to_parameter_vector(inputs.vectorA));
  generator->bind_input("vectorB", Halide::Internal::StubInputBuffer<>::to_parameter_vector(inputs.vectorB));
  generator->build_pipeline();
  return {
   Halide::Internal::StubOutputBuffer<float>::to_output_buffers(generator->output_func("result"), generator).at(0),
   generator->context().target()
  };
 }

 // overload to allow GeneratorBase-pointer
 inline static Outputs generate(
  const Halide::Internal::GeneratorBase* generator,
  const Inputs& inputs,
  const GeneratorParams& generator_params = GeneratorParams()
 )
 {
  return generate(generator->context(), inputs, generator_params);
 }

 // overload to allow Target instead of GeneratorContext.
 inline static Outputs generate(
  const Target& target,
  const Inputs& inputs,
  const GeneratorParams& generator_params = GeneratorParams()
 )
 {
  return generate(Halide::GeneratorContext(target), inputs, generator_params);
 }

 halide_dotProduct() = delete;
};


#endif  // HALIDE_STUB_halide_dotProduct
