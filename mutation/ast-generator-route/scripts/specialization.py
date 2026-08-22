#!/usr/bin/env python3
"""Bucket emitted-C++ mutation points by the function they land in.

Halide's C backend emits SEVERAL specialisations of the same parallel-for
body -- different vector widths, alignments and edge cases -- and a given
driver input executes only one of them. A mutation in an unexecuted
specialisation is real arithmetic, compiles to genuinely different object
code (so it is NOT TCE-equivalent), runs, and produces byte-identical output.
It survives for a reason that has nothing to do with the test being weak: the
code was never executed.

Measured on resize_box_uint8_down: four specialisations at lines 3627, 4508,
6379 and 8711. Every one of the 775 kills falls at line <= 4497, inside the
first. The 2,509 survivors at line >= 5000 are in specialisations the single
test input never reaches.

This matters for any kill rate quoted on the emitted-C++ route. Counting
unexecuted specialisations in the denominator makes the route look far weaker
than it is, and makes a cross-route comparison against the generator route --
where there is exactly one copy of the algorithm to mutate -- misleading. The
honest denominator is points in EXECUTED code; the rest should be reported as
their own category, the same way TCE equivalence is.
"""
import csv, re, sys, os
from collections import defaultdict

FUNC_RE = re.compile(r"^(?:static\s+)?(?:int|void|float|bool)\s+([A-Za-z_]\w*)\s*\(")

def functions(path):
    out = []
    with open(path, errors="replace") as fh:
        for i, line in enumerate(fh, 1):
            m = FUNC_RE.match(line)
            if m:
                out.append((i, m.group(1)))
    return out

def enclosing(funcs, line):
    name = "<file scope>"
    for start, n in funcs:
        if start <= line:
            name = n
        else:
            break
    return name

def main(csv_path, cpp_path):
    funcs = functions(cpp_path)
    rows = list(csv.DictReader(open(csv_path)))
    agg = defaultdict(lambda: dict(points=0, run=0, killed=0, equiv=0))
    for r in rows:
        try:
            ln = int(r["line"])
        except (ValueError, KeyError):
            continue
        a = agg[enclosing(funcs, ln)]
        a["points"] += 1
        t1 = (r.get("test1_demo") or "").strip()
        if t1 in ("KILLED", "SURVIVED"):
            a["run"] += 1
        if (r.get("killed") or "") == "1" or t1 == "KILLED":
            a["killed"] += 1
        if (r.get("resolution") or "") == "equivalent_tce" or \
           (r.get("equivalent") or ""):
            a["equiv"] += 1
    print("%-52s %7s %6s %7s %6s" % ("function", "points", "run", "killed", "equiv"))
    for name, a in sorted(agg.items(), key=lambda kv: -kv[1]["points"]):
        print("%-52s %7d %6d %7d %6d" % (name[:52], a["points"], a["run"],
                                         a["killed"], a["equiv"]))
    ex = {n: a for n, a in agg.items() if a["killed"]}
    dead = {n: a for n, a in agg.items() if a["run"] and not a["killed"]}
    print()
    print("functions with at least one kill (executed): %d, %d points"
          % (len(ex), sum(a["points"] for a in ex.values())))
    print("functions run but with ZERO kills (likely unexecuted specialisations): %d, %d points"
          % (len(dead), sum(a["points"] for a in dead.values())))

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
