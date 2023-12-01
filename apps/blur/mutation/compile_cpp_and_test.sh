#! /bin/bash

# This script compiles the C++ code and the test binary.

/usr/local/llvm/bin/clang++  -O3 -std=c++17 \
-I /Users/smadadi/Projects/halide_install_original/distrib/include/ \
-I /Users/smadadi/Projects/halide_install_original/distrib/tools/ \
-Wall -Werror -Wno-unused-function -Wcast-qual -Wignored-qualifiers \
-Wno-comment -Wsign-compare -Wno-unknown-warning-option -Wno-psabi \
-fvisibility=hidden -c halide_blur.halide_generated.cpp  -o ../bin/host/halide_mutated_blur.o

 /usr/local/llvm/bin/clang++ -O3 -std=c++17 -I /Users/smadadi/Projects/halide_install_original/distrib/include/ -I /Users/smadadi/Projects/halide_install_original/distrib/tools/  -Wall -Werror -Wno-unused-function -Wcast-qual -Wignored-qualifiers -Wno-comment -Wsign-compare -Wno-unknown-warning-option -Wno-psabi  -fvisibility=hidden  -Wall -O2 -I../bin/host ../test.cpp ../bin/host/halide_mutated_blur.o -o ../bin/host/test -L/usr/local/llvm/lib -ldl -lpthread -lz
