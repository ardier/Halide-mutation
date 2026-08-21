#!/usr/bin/env python3
"""Resolution accounting over every evaluated mutant.

Counts resolution -- killed by a test, killed by the Halide compiler, or shown
equivalent -- rather than kill rate, so that an equivalent mutant counts as
settled instead of dragging a percentage down.

Sources, in increasing precedence:
  1. mutation/results-full-sweep/*.csv     the 65-operator sweep (pass2 wins)
  2. mutation/experiment2/results/*.csv    every targeted-test run, 'after' rows

A mutant is keyed by (app, arm, mutator, file, line, column). A later 'after'
row overrides an earlier verdict for the same key, and any KILLED verdict
anywhere is sticky: a mutant killed by one test does not become unresolved
because a different test failed to kill it.

EQUIVALENT_BY_ARGUMENT lists mutants resolved by the arguments in
EQUIVALENCE.md and RESULTS.md. They are listed explicitly, one line each, so
that the count can be audited against the prose rather than inferred.
"""
import csv
import glob
import os
import sys
import collections

HERE = os.path.dirname(os.path.abspath(__file__))
MUT = os.path.dirname(HERE)

FAMILY = {
    "arithmetic": "Arithmetic",
    "schedule": "Schedule directive",
    "generated": "Relational & bitwise",
    "boundary_conditions": "BoundaryConditions",
    "select_clamp": "select / clamp",
    "if_then_else": "select -> if_then_else",
}
ORDER = ["Arithmetic", "Schedule directive", "Relational & bitwise",
         "BoundaryConditions", "select / clamp", "select -> if_then_else"]

# (app, mutator, line, column) -> where the argument lives
EQUIVALENT_BY_ARGUMENT = {
    # RESULTS.md, round 1
    ("max_filter", "Halide_repeat_edge_to_mirror_image", "17", "22"): "RESULTS.md",
    ("max_filter", "Halide_repeat_edge_to_mirror_interior", "17", "22"): "RESULTS.md",
    # EQUIVALENCE.md, round 2
    ("max_filter", "Halide_add_to_div", "38", "57"): "EQUIVALENCE.md 1-2",
    ("max_filter", "Halide_add_to_mul", "38", "57"): "EQUIVALENCE.md 1-2",
    ("max_filter", "Halide_add_to_sub", "54", "43"): "EQUIVALENCE.md 3",
    ("max_filter", "Halide_lt_to_le", "13312", "25"): "EQUIVALENCE.md 4",
    ("bilateral_grid", "Halide_add_assign_to_sub_assign", "29", "32"): "EQUIVALENCE.md 5",
    ("blur", "Halide_vectorize_to_unroll", "106", "18"): "EQUIVALENCE.md 6-7",
    ("blur", "Halide_store_at_to_compute_at", "108", "18"): "EQUIVALENCE.md 6-7",
    ("blur", "Halide_vectorize_to_parallel", "110", "18"): "EQUIVALENCE.md 6-7",
    ("blur", "Halide_vectorize_to_unroll", "110", "18"): "EQUIVALENCE.md 6-7",
    ("c_backend", "Halide_vectorize_to_parallel", "21", "26"): "EQUIVALENCE.md 6-7",
    ("c_backend", "Halide_vectorize_to_unroll", "21", "26"): "EQUIVALENCE.md 6-7",
    ("max_filter", "Halide_add_to_mul", "29", "41"): "EQUIVALENCE.md 8",
}
# select -> if_then_else: every effective mutant of this operator is argued
# output-equivalent in RESULTS.md, so it is matched by operator rather than
# listed site by site.
EQUIVALENT_OPERATORS = {"Halide_select_to_if_then_else"}


def load():
    rows = {}
    killed = set()

    def absorb(path, only_after):
        for r in csv.DictReader(open(path)):
            if only_after and r.get("variant") not in (None, "after"):
                continue
            k = (r["app"], r["arm"], r["mutator"], r["file"], r["line"], r["column"])
            if r.get("o1") == "KILLED" or r.get("o2") == "KILLED":
                killed.add(k)
            prev = rows.get(k)
            if prev is None or not only_after:
                rows[k] = r
            else:
                rows[k] = r
        return

    for f in sorted(glob.glob(os.path.join(MUT, "results-full-sweep", "*.csv"))):
        if "pass2" in f:
            continue
        absorb(f, False)
    for f in sorted(glob.glob(os.path.join(MUT, "results-full-sweep", "*pass2*.csv"))):
        absorb(f, False)
    for f in sorted(glob.glob(os.path.join(HERE, "results", "*.csv"))):
        absorb(f, True)
    return rows, killed


def classify(k, r, killed):
    app, arm, mutator, fn, line, col = k
    if r["stage2"] not in ("OK",):
        if r["stage2"] in ("GEN_ERROR", "GEN_TIMEOUT"):
            return "compiler"
        return "notrun"          # NOT_RUN / HARNESS_ERROR: never evaluated
    if k in killed:
        return "killed"
    if r["effective"] != "1":
        return "equivalent"      # emitted .stmt byte-identical to baseline
    if mutator in EQUIVALENT_OPERATORS:
        return "equivalent"
    if (app, mutator, line, col) in EQUIVALENT_BY_ARGUMENT:
        return "equivalent"
    return "unresolved"


def main():
    rows, killed = load()
    tally = collections.defaultdict(collections.Counter)
    unresolved = collections.defaultdict(list)
    for k, r in rows.items():
        fam = FAMILY.get(k[1], k[1])
        c = classify(k, r, killed)
        if c == "notrun":
            continue
        tally[fam][c] += 1
        tally[fam]["evaluated"] += 1
        if c == "unresolved":
            unresolved[fam].append(k)

    hdr = ("%-24s %9s %8s %13s %11s %12s %9s" %
           ("family", "evaluated", "killed", "by compiler", "equivalent",
            "unresolved", "resolved"))
    print(hdr); print("-" * len(hdr))
    tot = collections.Counter()
    for fam in ORDER:
        t = tally.get(fam)
        if not t:
            continue
        for kk in ("evaluated", "killed", "compiler", "equivalent", "unresolved"):
            tot[kk] += t[kk]
        res = t["evaluated"] - t["unresolved"]
        print("%-24s %9d %8d %13d %11d %12d %8.1f%%" %
              (fam, t["evaluated"], t["killed"], t["compiler"], t["equivalent"],
               t["unresolved"], 100.0 * res / t["evaluated"] if t["evaluated"] else 0))
    print("-" * len(hdr))
    res = tot["evaluated"] - tot["unresolved"]
    print("%-24s %9d %8d %13d %11d %12d %8.1f%%" %
          ("corpus", tot["evaluated"], tot["killed"], tot["compiler"],
           tot["equivalent"], tot["unresolved"],
           100.0 * res / tot["evaluated"] if tot["evaluated"] else 0))

    if "-v" in sys.argv:
        print("\nremaining unresolved, by family:")
        for fam in ORDER:
            if not unresolved.get(fam):
                continue
            print("\n  %s (%d)" % (fam, len(unresolved[fam])))
            by_app = collections.Counter(k[0] for k in unresolved[fam])
            for a, n in by_app.most_common():
                print("     %-28s %d" % (a, n))


if __name__ == "__main__":
    main()
