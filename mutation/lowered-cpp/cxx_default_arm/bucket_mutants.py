#!/usr/bin/env python3
"""Classify a raw cxx_default mutant-id list (one `mutator:file:line:col` key
per line, as extracted from `strings *.o | grep ...` after Stage 1) into
boilerplate / generator_specific / wrapper_metadata regions.

Self-contained per app (no second file needed for a common-prefix diff, unlike
survey.py): the boilerplate/generator-specific boundary is the line where the
last top-level `}  // namespace` closes before the first `HALIDE_FUNCTION_ATTRS`
marker -- that namespace (CppVector/NativeVector SIMD-emulation templates)
closes at the exact same line (3446, 1-based) in every one of blur, harris,
unsharp, bilateral_grid and camera_pipe, so it's a reliable single-file marker.
It undercounts survey.py's cross-file common-prefix boundary by ~20 lines in
practice (survey.py found 3466 for the blur+harris pair), but empirically zero
mutants fall in that 20-line gap for blur or harris, so the two definitions
bucket identically for this data.

The generator-specific zone ends at the first HALIDE_FUNCTION_ATTRS marker for
the `_argv` wrapper (the second HALIDE_FUNCTION_ATTRS marker overall).

Usage: python3 bucket_mutants.py <app_dir> <mutant_list.txt>
Prints one CSV row per mutant to stdout: mutator,file,line,column,region
"""
import sys
import os

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), ".."))
from survey import find_generated_cpp  # noqa: E402


def region_bounds(app_dir):
    """Returns (boiler_end, genspec_end), both 1-based inclusive line numbers."""
    path = find_generated_cpp(app_dir)
    with open(path) as f:
        lines = f.readlines()
    attrs_idx = [i for i, l in enumerate(lines) if l.rstrip("\n") == "HALIDE_FUNCTION_ATTRS"]
    if len(attrs_idx) < 3:
        raise SystemExit(f"{path}: expected >=3 HALIDE_FUNCTION_ATTRS markers, found {len(attrs_idx)}")
    main_attrs, argv_attrs, _ = attrs_idx[0], attrs_idx[1], attrs_idx[2]

    namespace_closes = [i for i in range(main_attrs) if lines[i].rstrip("\n") == "}  // namespace"]
    if not namespace_closes:
        raise SystemExit(f"{path}: found no '}}  // namespace' before the main-function marker")
    boiler_end = namespace_closes[-1] + 1  # 0-based index -> 1-based line number

    genspec_end = argv_attrs  # 0-based index of the argv HALIDE_FUNCTION_ATTRS marker == 1-based
                              # line number of the line just before it (exclusive end, inclusive-1)
    return boiler_end, genspec_end


def classify(line_no, boiler_end, genspec_end):
    # line_no is 1-based (as emitted by Mull's env-var keys)
    if line_no <= boiler_end:
        return "boilerplate"
    elif line_no <= genspec_end:
        return "generator_specific"
    else:
        return "wrapper_metadata"


def main(argv):
    if len(argv) != 3:
        raise SystemExit(__doc__)
    app_dir, mutant_list = argv[1], argv[2]
    boiler_end, genspec_end = region_bounds(app_dir)
    print("mutator,file,line,column,region")
    with open(mutant_list) as f:
        for raw in f:
            key = raw.strip()
            if not key:
                continue
            parts = key.split(":")
            mutator, file_, line, col = parts[0], ":".join(parts[1:-2]), parts[-2], parts[-1]
            region = classify(int(line), boiler_end, genspec_end)
            print(f"{mutator},{os.path.basename(file_)},{line},{col},{region}")


if __name__ == "__main__":
    main(sys.argv)
