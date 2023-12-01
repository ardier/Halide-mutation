#ifndef HALIDE_STUB_halide_blur
#define HALIDE_STUB_halide_blur

/* MACHINE-GENERATED - DO NOT EDIT */

#include <cassert>
#include <map>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "Halide.h"

namespace halide_register_generator {
namespace halide_blur_ns {
extern std::unique_ptr<Halide::Internal::GeneratorBase> factory(const Halide::GeneratorContext& context);
}  // namespace halide_register_generator
}  // namespace halide_blur


enum class Enum_schedule {
  cache,
  inline,
  slide,
  slide_vector,
};

inline HALIDE_NO_USER_CODE_INLINE const std::map<Enum_schedule, std::string>& Enum_schedule_map() {
  static const std::map<Enum_schedule, std::string> m = {
    { Enum_schedule::cache, "cache"},
    { Enum_schedule::inline, "inline"},
    { Enum_schedule::slide, "slide"},
    { Enum_schedule::slide_vector, "slide_vector"},
  };
  return m;
};

class halide_blur final : public Halide::NamesInterface {
public:
 struct Inputs final {
  Halide::Internal::StubInputBuffer<uint16_t> input;

  Inputs() {}

  Inputs(
   const Halide::Internal::StubInputBuffer<uint16_t>& input
  ) : 
   input(input)
  {
  }
 };

 struct GeneratorParams final {
  Enum_schedule schedule{ Enum_schedule::slide_vector };
  int32_t tile_x{ 32 };
  int32_t tile_y{ 8 };

  GeneratorParams() {}

  GeneratorParams(
   Enum_schedule schedule
   , int32_t tile_x
   , int32_t tile_y
  ) : 
   schedule(schedule)
   , tile_x(tile_x)
   , tile_y(tile_y)
  {
  }

  inline HALIDE_NO_USER_CODE_INLINE Halide::Internal::GeneratorParamsMap to_generator_params_map() const {
   return {
    {"schedule", Enum_schedule_map().at(schedule)}
    , {"tile_x", std::to_string(tile_x)}
    , {"tile_y", std::to_string(tile_y)}
   };
  }
 };

 struct Outputs final {
  // Outputs
  Halide::Internal::StubOutputBuffer<uint16_t> blur_y;

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
  using Stub = Halide::Internal::GeneratorStub;
  Stub stub(
   context,
   halide_register_generator::halide_blur_ns::factory,
   generator_params.to_generator_params_map(),
   {
    Stub::to_stub_input_vector(inputs.input),
   }
  );
  return {
   stub.get_output_buffers<Halide::Internal::StubOutputBuffer<uint16_t>>("blur_y").at(0),
   stub.generator->context().get_target()
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

 halide_blur() = delete;
};


#endif  // HALIDE_STUB_halide_blur
