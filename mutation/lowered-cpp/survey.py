#!/usr/bin/env python3
"""Survey how much of a Halide C-backend-emitted .cpp file is Halide's own
runtime/library boilerplate vs. genuine generator-specific logic.

Background: Halide's C backend (`-e c_source`) emits no `#line` directives
and no other source-location provenance markers, so the split can't be done
by mechanically attributing lines to an original file:line the way a
compiler diagnostic would. Instead this script uses an empirical, mechanical
method that turns out to work cleanly for this codebase: every emitted file
begins with a byte-identical prefix (includes, embedded HalideRuntime.h,
CppVector/NativeVector generic vector-emulation templates, halide_buffer_t
accessor helpers, the halide_filter_metadata_t struct definition) that does
not depend at all on what the generator computes. That prefix is discovered
by diffing multiple emitted files against each other and taking the longest
common prefix; anything after it is generator-specific, further split into:
  - parallel-for closure functions (one per parallelized stage)
  - the top-level pipeline entry function body
  - the _argv marshaling wrapper
  - the _metadata() descriptor table

Usage: python3 survey.py <app1_dir> <app2_dir> ...
Each <appN_dir> must contain exactly one *.halide_generated.cpp file.
"""
import sys
import glob
import os


def find_generated_cpp(app_dir):
    matches = glob.glob(os.path.join(app_dir, "*.halide_generated.cpp"))
    if len(matches) != 1:
        raise SystemExit(f"expected exactly one *.halide_generated.cpp in {app_dir}, found {matches}")
    return matches[0]


def common_prefix_len(all_lines):
    """Length (in lines) of the longest common prefix shared by every file."""
    shortest = min(len(l) for l in all_lines)
    for i in range(shortest):
        first = all_lines[0][i]
        if any(lines[i] != first for lines in all_lines[1:]):
            return i
    return shortest


def analyze(path, boiler_len):
    with open(path) as f:
        lines = f.readlines()
    n = len(lines)
    total_bytes = sum(len(l.encode("utf-8")) for l in lines)

    attrs_idx = [i for i, l in enumerate(lines) if l.rstrip("\n") == "HALIDE_FUNCTION_ATTRS"]
    if len(attrs_idx) < 3:
        raise SystemExit(f"{path}: expected >=3 HALIDE_FUNCTION_ATTRS markers (main fn, argv, metadata), found {len(attrs_idx)}")
    main_attrs, argv_attrs, meta_attrs = attrs_idx[0], attrs_idx[1], attrs_idx[2]

    parfor_block = lines[boiler_len:main_attrs]
    main_block = lines[main_attrs:argv_attrs]
    argv_block = lines[argv_attrs:meta_attrs]
    meta_block = lines[meta_attrs:n]

    def stat(block):
        return len(block), sum(len(l.encode("utf-8")) for l in block)

    boiler_bytes = sum(len(l.encode("utf-8")) for l in lines[:boiler_len])
    pf_l, pf_b = stat(parfor_block)
    m_l, m_b = stat(main_block)
    a_l, a_b = stat(argv_block)
    md_l, md_b = stat(meta_block)

    gen_l, gen_b = pf_l + m_l, pf_b + m_b
    wrap_l, wrap_b = a_l + md_l, a_b + md_b

    return {
        "path": path,
        "total_lines": n,
        "total_bytes": total_bytes,
        "boiler_lines": boiler_len,
        "boiler_bytes": boiler_bytes,
        "parfor_lines": pf_l,
        "main_lines": m_l,
        "argv_lines": a_l,
        "meta_lines": md_l,
        "gen_lines": gen_l,
        "gen_bytes": gen_b,
        "wrap_lines": wrap_l,
        "wrap_bytes": wrap_b,
    }


def main(argv):
    if len(argv) < 2:
        raise SystemExit(__doc__)
    app_dirs = argv[1:]
    paths = [find_generated_cpp(d) for d in app_dirs]
    all_lines = []
    for p in paths:
        with open(p) as f:
            all_lines.append(f.readlines())
    boiler_len = common_prefix_len(all_lines)

    print(f"Common byte-identical boilerplate prefix across all {len(paths)} files: {boiler_len} lines\n")
    header = f"{'app':16} {'total_L':>8} {'total_B':>9} {'boiler_L':>9} {'boiler_%':>9} {'genspec_L':>10} {'genspec_%':>10} {'wrap_L':>7}"
    print(header)
    print("-" * len(header))
    for d, p in zip(app_dirs, paths):
        app = os.path.basename(os.path.normpath(d))
        r = analyze(p, boiler_len)
        boiler_pct = 100 * r["boiler_lines"] / r["total_lines"]
        gen_pct = 100 * r["gen_lines"] / r["total_lines"]
        print(f"{app:16} {r['total_lines']:8} {r['total_bytes']:9} {r['boiler_lines']:9} {boiler_pct:8.1f}% "
              f"{r['gen_lines']:10} {gen_pct:9.1f}% {r['wrap_lines']:7}")


if __name__ == "__main__":
    main(sys.argv)
