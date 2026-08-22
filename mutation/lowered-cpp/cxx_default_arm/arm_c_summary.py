#!/usr/bin/env python3
"""Print whole-file vs. generator-specific-only kill-rate summaries from the
committed cxx_default sweep CSVs (mutation/results/{blur,harris}-cxx_default.csv).
Each row already carries a `region` column (boilerplate / generator_specific /
wrapper_metadata) computed by bucket_mutants.py against survey.py's boundaries.

Usage: python3 arm_c_summary.py
Run from anywhere; paths are relative to the repo's mutation/results/ dir.
"""
import csv
import os

HERE = os.path.dirname(os.path.abspath(__file__))
RESULTS = os.path.join(HERE, "..", "..", "results")

ARITH_FAMILY = {"cxx_add_to_sub", "cxx_sub_to_add", "cxx_mul_to_div", "cxx_div_to_mul"}


def load(name):
    with open(os.path.join(RESULTS, name)) as f:
        return list(csv.DictReader(f))


def summarize_blur(rows, filt=None):
    if filt:
        rows = [r for r in rows if filt(r)]
    n = len(rows)
    k = sum(1 for r in rows if r["killed"] == "1")
    return n, k, (100 * k / n if n else float("nan"))


def summarize_harris(rows, filt=None):
    if filt:
        rows = [r for r in rows if filt(r)]
    n = len(rows)
    t1 = sum(1 for r in rows if r["test1_demo_killed"] == "1")
    t2g = sum(1 for r in rows if r["test2_golden_killed"] == "1")
    return n, t1, t2g, (100 * t1 / n if n else float("nan")), (100 * t2g / n if n else float("nan"))


def main():
    blur = load("blur-cxx_default.csv")
    harris = load("harris-cxx_default.csv")

    print("BLUR (cxx_default on emitted C++):")
    n, k, pct = summarize_blur(blur)
    print(f"  whole-file:                            n={n:4} killed={k:4} ({pct:.1f}%)")
    n, k, pct = summarize_blur(blur, lambda r: r["region"] == "generator_specific")
    print(f"  generator-specific only:               n={n:4} killed={k:4} ({pct:.1f}%)")
    n, k, pct = summarize_blur(blur, lambda r: r["mutator"] in ARITH_FAMILY)
    print(f"  arithmetic-family only (whole-file):   n={n:4} killed={k:4} ({pct:.1f}%)")

    print()
    print("HARRIS (cxx_default on emitted C++):")
    n, t1, t2g, p1, p2 = summarize_harris(harris)
    print(f"  whole-file:                            n={n:4} test1={t1:4}({p1:.1f}%) test2gold={t2g:4}({p2:.1f}%)")
    n, t1, t2g, p1, p2 = summarize_harris(harris, lambda r: r["region"] == "generator_specific")
    print(f"  generator-specific only:               n={n:4} test1={t1:4}({p1:.1f}%) test2gold={t2g:4}({p2:.1f}%)")
    n, t1, t2g, p1, p2 = summarize_harris(harris, lambda r: r["mutator"] in ARITH_FAMILY)
    print(f"  arithmetic-family only (whole-file):   n={n:4} test1={t1:4}({p1:.1f}%) test2gold={t2g:4}({p2:.1f}%)")


if __name__ == "__main__":
    main()
