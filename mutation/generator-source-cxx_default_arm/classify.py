#!/usr/bin/env python3
"""Classify Arm B (mull-cxx-frontend cxx_default on generator source) mutation
points into Halide-library / Halide-DSL / Plain-C++ per the plan's
methodology. Reads the plugin's stdout log (one "Recording mutation point:"
line per point, with the TYPE:/HALIDE_TYPE: fields added by the
describeMutatedType() instrumentation in ASTMutationsSearchVisitor.cpp).
"""
import re
import sys
import csv

LINE_RE = re.compile(
    r"^Recording mutation point: (?P<mutator>[A-Za-z_]+):(?P<file>.+):(?P<line>\d+):(?P<col>\d+) "
    r"\(end: (?P<endline>\d+):(?P<endcol>\d+)\) TYPE:(?P<type>.*) HALIDE_TYPE:(?P<halide>[01])$"
)


def classify(rows, generator_path):
    out = []
    for r in rows:
        if r["file"] != generator_path:
            bucket = "halide_library"
        elif r["halide"] == "1":
            bucket = "halide_dsl"
        else:
            bucket = "plain_cxx"
        r2 = dict(r)
        r2["bucket"] = bucket
        out.append(r2)
    return out


def main(argv):
    if len(argv) != 4:
        raise SystemExit("usage: classify.py <log> <generator_source_path> <out_csv>")
    log_path, generator_path, out_csv = argv[1], argv[2], argv[3]
    rows = []
    with open(log_path) as f:
        for line in f:
            line = line.rstrip("\n")
            m = LINE_RE.match(line)
            if not m:
                continue
            rows.append(m.groupdict())

    classified = classify(rows, generator_path)

    with open(out_csv, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["mutator", "file", "line", "col", "endline", "endcol",
                                          "type", "halide", "bucket"])
        w.writeheader()
        for r in classified:
            w.writerow(r)

    total = len(classified)
    lib = sum(1 for r in classified if r["bucket"] == "halide_library")
    dsl = sum(1 for r in classified if r["bucket"] == "halide_dsl")
    cxx = sum(1 for r in classified if r["bucket"] == "plain_cxx")
    print(f"total={total}")
    print(f"  halide_library : {lib:4} ({100*lib/total:.1f}%)" if total else "  halide_library : 0")
    print(f"  halide_dsl     : {dsl:4} ({100*dsl/total:.1f}%)" if total else "  halide_dsl     : 0")
    print(f"  plain_cxx      : {cxx:4} ({100*cxx/total:.1f}%)" if total else "  plain_cxx      : 0")

    if cxx > 0:
        print("\n  plain_cxx sample points:")
        for r in classified:
            if r["bucket"] == "plain_cxx":
                print(f"    {r['mutator']}:{r['file']}:{r['line']}:{r['col']} TYPE={r['type']}")


if __name__ == "__main__":
    main(sys.argv)
