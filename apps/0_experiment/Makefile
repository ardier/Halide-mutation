include ../support/Makefile.inc

.PHONY: build clean test
build: $(BIN)/$(HL_TARGET)/test

# In order to ensure our static library works, we arbitrarily link against
# the static library for this app.
$(GENERATOR_BIN)/halide_dotProduct.generator: halide_dotProduct_generator.cpp $(GENERATOR_DEPS_STATIC)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $(filter %.cpp,$^) -o $@ $(LIBHALIDE_LDFLAGS_STATIC)

$(BIN)/%/halide_dotProduct.a: $(GENERATOR_BIN)/halide_dotProduct.generator
	@mkdir -p $(@D)
	$^ -g halide_dotProduct -e $(GENERATOR_OUTPUTS),object,cpp_stub,c_header,c_source -o $(@D) target=$*

# g++ on OS X might actually be system clang without openmp
CXX_VERSION=$(shell $(CXX) --version)
ifeq (,$(findstring clang,$(CXX_VERSION)))
OPENMP_FLAGS=-fopenmp
else
OPENMP_FLAGS=
endif

# check if "halide_dotProduct.halide_generated.cpp" exists in the target directory and if yes compile it into halide_dotProduct.o
$(BIN)/%/halide_dotProduct.o: $(BIN)/%/halide_dotProduct.a
	@mkdir -p $(@D)
	$(CXX-$*) $(CXXFLAGS-$*) -Wall -O2 -c $(@D)/halide_dotProduct.halide_generated.cpp -o $@ $(OPENMP_FLAGS)


# -O2 is faster than -O3 for this app (O3 unrolls too much)
$(BIN)/%/test: $(BIN)/%/halide_dotProduct.o test.cpp
	@mkdir -p $(@D)
	$(CXX-$*) $(CXXFLAGS-$*) $(OPENMP_FLAGS) -Wall -O2 -I$(BIN)/$* test.cpp $(BIN)/$*/halide_dotProduct.o -o $@ $(LDFLAGS-$*)

clean:
	rm -rf $(BIN)

test: $(BIN)/$(HL_TARGET)/test
	$<