#!/usr/bin/env python3
"""Same as classify.py but tolerates a log with no TYPE:/HALIDE_TYPE: fields
(this deployed libmull-cxx-frontend-14.so predates that instrumentation).
Points outside the generator's own file are unambiguously halide_library
regardless; only points *inside* the generator file need the type fields to
tell halide_dsl from plain_cxx, and none occurred in this second-wave run.
"""
import re, sys, csv

LINE_RE = re.compile(
    r"^Recording mutation point: (?P<mutator>[A-Za-z_]+):(?P<file>.+):(?P<line>\d+):(?P<col>\d+) "
    r"\(end: (?P<endline>\d+):(?P<endcol>\d+)\)(?: TYPE:(?P<type>.*) HALIDE_TYPE:(?P<halide>[01]))?$"
)

def main(argv):
    log_path, generator_path, out_csv = argv[1], argv[2], argv[3]
    rows = []
    with open(log_path) as f:
        for line in f:
            m = LINE_RE.match(line.rstrip("\n"))
            if m:
                rows.append(m.groupdict())

    out = []
    for r in rows:
        if r["file"] != generator_path:
            bucket = "halide_library"
        elif r.get("halide") == "1":
            bucket = "halide_dsl"
        elif r.get("halide") == "0":
            bucket = "plain_cxx"
        else:
            bucket = "in_generator_file_UNTYPED"
        r2 = dict(r); r2["bucket"] = bucket
        out.append(r2)

    with open(out_csv, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["mutator","file","line","col","endline","endcol","type","halide","bucket"])
        w.writeheader()
        for r in out:
            w.writerow(r)

    total = len(out)
    lib = sum(1 for r in out if r["bucket"] == "halide_library")
    dsl = sum(1 for r in out if r["bucket"] == "halide_dsl")
    cxx = sum(1 for r in out if r["bucket"] == "plain_cxx")
    untyped_in_gen = sum(1 for r in out if r["bucket"] == "in_generator_file_UNTYPED")
    print(f"total={total}")
    if total:
        print(f"  halide_library : {lib:4} ({100*lib/total:.1f}%)")
        print(f"  halide_dsl     : {dsl:4} ({100*dsl/total:.1f}%)")
        print(f"  plain_cxx      : {cxx:4} ({100*cxx/total:.1f}%)")
        print(f"  in-generator, untyped (needs describeMutatedType() build) : {untyped_in_gen:4}")

if __name__ == "__main__":
    main(sys.argv)
