# Benchmarks the emitted-C++ arm could not measure, and why

Three of the 13 Table-4 benchmarks produce no arm-C data. None of the three
failed for the same reason, and none of the three is a shortfall of the run
that produced the other ten — each is a specific, reproducible property of a
tool in the chain.

## `camera_pipe` and `bgu` — Halide's C backend emits invalid C++

Re-verified on swsec01 with a bare `clang++ -std=c++17 -O1 -fsyntax-only` on
the emitted file. No Mull, no plugin, no mutation, no linking:

| benchmark | errors | first error |
|---|---:|---|
| `camera_pipe` | 1 | `camera_pipe.halide_generated.cpp:3800:26: cannot initialize a variable of type 'uint16_t' with an rvalue of type 'void'` |
| `bgu` | 19 | `bgu.halide_generated.cpp:11349:13: cannot initialize a variable of type 'float' with an rvalue of type 'float8'` |

Same causes reported from the earlier local run, on a completely independent
toolchain: `camera_pipe`'s `.prefetch()` schedule directive lowers to a `void`
`__builtin_prefetch` result being assigned to a `uint16_t`, and `bgu`'s
`fast_inverse_f32` returns a vector `float8` assigned to a scalar `float`.
Fixing either means patching Halide's C backend or rewriting the generator, so
2 of 13 benchmarks are outside this arm's reach for reasons that have nothing
to do with mutation testing. That is itself the reportable result: "lower the
DSL to equivalent C++ and mutate that" is not a technique you can point at an
arbitrary Halide pipeline.

## `lens_blur` — the single-instrumented-binary approach does not scale to it

Skipped by explicit decision, not left running. The instrumentation compile

```
clang++ -std=c++17 -O1 -g -grecord-command-line \
        -fpass-plugin=mull-ir-frontend-14 -c lens_blur.halide_generated.cpp
```

was killed at **2 h 04 min** of continuous ~100% CPU at **84 GB RSS**, with no
output produced. It is not hung — it burns real CPU the whole time — it is
simply superlinear in the size of the emitted file, and `lens_blur`'s is the
second largest in the corpus (14,805 lines / 608 KB, 75.5% generator-specific).
For scale, the same step takes 19 s on `blur`, 61 s on `harris`, 332 s on
`bilateral_grid`, 735 s on `depthwise_separable_conv`, and 2,689 s on
`nl_means` — `lens_blur` had already passed three times the next-worst case
when it was stopped.

The interesting part is that the bigger machine did not rescue it. On the
16-core/31 GB laptop this benchmark was killed by the OOM killer; on a
128-core/251 GB server with the memory ceiling removed entirely it still failed,
on time rather than on memory. The cost is structural to Mull's mechanism —
one object file has to hold every mutant of a 608 KB translation unit behind
runtime dispatch, and each candidate is re-parsed by the junk detector — not to
the hardware. The contrast worth recording is that the standalone
source-rewriting mutator (`ardi-experiments@halide-src-rewrite`), which emits N
separately-compiled mutated sources instead of one instrumented binary, handles
this same benchmark in 81 seconds.
