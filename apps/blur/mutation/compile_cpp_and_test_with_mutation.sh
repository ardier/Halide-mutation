#! /bin/bash

# This script compiles the C++ code and the test binary.

/usr/local/llvm/bin/clang++  -O3 -std=c++17 \
-I /Users/smadadi/Projects/halide_install_original/distrib/include/ \
-I /Users/smadadi/Projects/halide_install_original/distrib/tools/ \
-Wall -Werror -Wno-unused-function -Wcast-qual -Wignored-qualifiers \
-Wno-comment -Wsign-compare -Wno-unknown-warning-option -Wno-psabi \
-fvisibility=hidden -c ../bin/host/halide_blur.halide_generated.cpp  -o halide_blur.o -fexperimental-new-pass-manager -g -grecord-command-line -fpass-plugin=/Users/smadadi/Projects/PSrepos/ps4/mutation/mull/build.dir/tools/mull-ir-frontend/mull-ir-frontend-14

 /usr/local/llvm/bin/clang++ -O3 -std=c++17 -I /Users/smadadi/Projects/halide_install_original/distrib/include/ -I /Users/smadadi/Projects/halide_install_original/distrib/tools/  -Wall -Werror -Wno-unused-function -Wcast-qual -Wignored-qualifiers -Wno-comment -Wsign-compare -Wno-unknown-warning-option -Wno-psabi  -fvisibility=hidden  -Wall -O2 -I../bin/host ../test.cpp ../halide_blur.o -o ../bin/host/test -L/usr/local/llvm/lib -ldl -lpthread -lz
