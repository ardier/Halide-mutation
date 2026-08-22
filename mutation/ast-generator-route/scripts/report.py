#!/usr/bin/env python3
"""Report over both routes, normalised into the CURRENT column vocabulary.

The two harnesses were written at different times and do not agree on column
names. The generator-route harness already emits the current vocabulary
(test1_demo / test2_added / test2_method / test3_perf). The emitted-C++
harness still emits the older split columns (test2_golden / test2_written).
They are folded here rather than in the CSVs, so the raw per-mutant rows stay
exactly as each run produced them:

    test2_golden   -> test2_added, test2_method = output_compare
    test2_written  -> test2_added, test2_method = assertion

`resolved` is COMPUTED here and never stored: a mutant is resolved if any test
kind killed it, or if it was proven equivalent.

Two numbers are reported per test kind, and they answer different questions:

    killed        this kind killed the mutant (other kinds may also have)
    killed ALONE  this kind killed it and NO other kind did -- i.e. dropping
                  this kind would lose the mutant entirely

A kind's denominator is the number of mutants on which that kind actually RAN.
NOT_RUN never enters a denominator: an output comparison that had no artifact
to compare did not "fail to kill", it did not run.
"""

import csv
import glob
import os
import sys
from collections import Counter, defaultdict

KINDS = ["test1_demo", "test2_added", "test3_perf"]


def load(path):
    with open(path) as fh:
        return list(csv.DictReader(fh))


def normalise(r):
    """One row -> the current vocabulary, whichever harness wrote it."""
    out = dict(r)
    if "test2_added" not in r:
        g = (r.get("test2_golden") or "NOT_RUN").strip()
        w = (r.get("test2_written") or "NOT_RUN").strip()
        # Where both exist, a kill by either is a kill by "the test we added";
        # the method records which one fired.
        if g != "NOT_RUN" and w != "NOT_RUN":
            out["test2_added"] = "KILLED" if "KILLED" in (g, w) else "SURVIVED"
            out["test2_method"] = ("output_compare" if g == "KILLED"
                                   else "assertion" if w == "KILLED"
                                   else "output_compare;assertion")
        elif g != "NOT_RUN":
            out["test2_added"], out["test2_method"] = g, "output_compare"
        elif w != "NOT_RUN":
            out["test2_added"], out["test2_method"] = w, "assertion"
        else:
            out["test2_added"], out["test2_method"] = "NOT_RUN", ""
    # equivalence: generator route stores `equivalent`, emitted route stores
    # `resolution == equivalent_tce`
    if not out.get("equivalent"):
        out["equivalent"] = ("tce" if r.get("resolution") == "equivalent_tce"
                             else "")
    for k in KINDS:
        out[k] = (out.get(k) or "").strip() or "NOT_RUN"
    return out


def summarise(rows, label):
    rows = [normalise(r) for r in rows]
    n = len(rows)

    def stage(r, key):
        return (r.get(key) or "").strip()

    gen_fail = sum(1 for r in rows if stage(r, "stage_compile")
                   in ("GEN_FAIL", "COMPILE_FAIL", "HARNESS_ERROR"))
    genlink_fail = sum(1 for r in rows
                       if stage(r, "stage_genlink") == "GENLINK_FAIL")
    gen_no_pipe = sum(1 for r in rows
                      if stage(r, "stage_generate").startswith("GEN_"))
    link_fail = sum(1 for r in rows if stage(r, "stage_link") == "LINK_FAIL")
    equiv = sum(1 for r in rows if r["equivalent"])
    ran = sum(1 for r in rows if any(r[k] in ("KILLED", "SURVIVED")
                                     for k in KINDS))
    killed_rows = [r for r in rows
                   if any(r[k] == "KILLED" for k in KINDS)]
    killed = len(killed_rows)
    resolved = sum(1 for r in rows
                   if r["equivalent"] or any(r[k] == "KILLED" for k in KINDS))

    print(f"\n=== {label} ===")
    print(f"  points identified              {n}")
    print(f"  tool/compiler rejected mutant  {gen_fail}")
    print(f"  mutants generated              {n - gen_fail}")
    if genlink_fail:
        print(f"    generator link failed        {genlink_fail}")
    if gen_no_pipe:
        print(f"    generator produced no pipeline {gen_no_pipe}")
    print(f"    equivalent (TCE)             {equiv}"
          + (f"   ({100.0*equiv/n:.1f}% of points)" if n else ""))
    if link_fail:
        print(f"    driver link failed           {link_fail}")
    print(f"  mutants RUN                    {ran}")
    print(f"  mutants KILLED                 {killed}")
    print(f"  RESOLVED (killed or equiv)     {resolved}"
          + (f"   ({100.0*resolved/n:.1f}%)" if n else ""))

    print("  per test kind:")
    for k in KINDS:
        kran = sum(1 for r in rows if r[k] in ("KILLED", "SURVIVED"))
        kk = sum(1 for r in rows if r[k] == "KILLED")
        alone = sum(1 for r in rows if r[k] == "KILLED"
                    and not any(r[o] == "KILLED" for o in KINDS if o != k))
        if kran == 0 and kk == 0:
            print(f"    {k:12s} NOT RUN on any mutant")
            continue
        print(f"    {k:12s} ran {kran:6d}  killed {kk:6d} "
              f"({100.0*kk/kran if kran else 0:5.1f}% of run)  "
              f"killed ALONE {alone:6d}")
    methods = Counter(r.get("test2_method", "") for r in rows
                      if r["test2_added"] in ("KILLED", "SURVIVED"))
    if methods:
        print(f"    test2_method                 "
              f"{dict(m for m in methods.items() if m[0])}")
    return dict(points=n, generated=n - gen_fail, run=ran, killed=killed,
                equiv=equiv, resolved=resolved)


GEN1 = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen1/out"
GEN2 = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen2/out"

SUMMARY_FIELDS = [
    "route", "target_kind", "app", "driver_kind", "points_identified",
    "mutants_generated", "mutants_run", "mutants_killed", "equivalent_tce",
    "resolved",
    "test1_demo_ran", "test1_demo_killed", "test1_demo_killed_alone",
    "test2_added_ran", "test2_added_killed", "test2_added_killed_alone",
    "test2_method", "test3_perf_ran", "test3_perf_killed", "complete",
]


def driver_kind(app):
    """Is the driver behind test1_demo the app's OWN shipped driver?

    test1_demo is defined as "the shipped driver's own verdict", and for 17 of
    the 20 registered apps that is exactly what it is (test.cpp, filter.cpp,
    process.cpp, run.cpp). Three apps -- resize, fft, wavelet -- register an
    ADDED apps/<app>/mutation_driver.cpp as their primary driver instead, and
    those added drivers carry real assertions (fft's has three `return 1`
    paths against a closed-form magnitude/phase oracle). For those three the
    test1_demo column is not measuring a shipped demo at all; it is measuring
    a written assertion test, and its kill rate is not comparable with the
    other apps'. Flagging it is the difference between a matrix cell that can
    be read across a row and one that quietly cannot.
    """
    try:
        sys.path.insert(0, "/mnt/scratch1/ardi/dsl_mut/"
                           "Halide-mutation-wip-c/mutation")
        from halidemut.apps import APPS
        src = os.path.basename(APPS[app].driver_source)
        return "added_assertion" if src.startswith("mutation_") else "shipped"
    except Exception:
        return ""


def app_stats(rows, route, tk, app, complete):
    """One summary row. Every denominator counts only mutants on which that
    kind actually RAN; NOT_RUN never enters one."""
    n = len(rows)
    bad = sum(1 for r in rows if (r.get("stage_compile") or "")
              in ("GEN_FAIL", "COMPILE_FAIL", "HARNESS_ERROR"))
    row = {f: "" for f in SUMMARY_FIELDS}
    row.update(route=route, target_kind=tk, app=app,
               driver_kind=driver_kind(app), points_identified=n,
               mutants_generated=n - bad, complete=int(complete))
    row["equivalent_tce"] = sum(1 for r in rows if r["equivalent"])
    row["mutants_run"] = sum(1 for r in rows if any(
        r[k] in ("KILLED", "SURVIVED") for k in KINDS))
    row["mutants_killed"] = sum(1 for r in rows if any(
        r[k] == "KILLED" for k in KINDS))
    row["resolved"] = sum(1 for r in rows if r["equivalent"] or any(
        r[k] == "KILLED" for k in KINDS))
    for k in KINDS:
        row[f"{k}_ran"] = sum(1 for r in rows
                              if r[k] in ("KILLED", "SURVIVED"))
        row[f"{k}_killed"] = sum(1 for r in rows if r[k] == "KILLED")
        if k != "test3_perf":
            row[f"{k}_killed_alone"] = sum(
                1 for r in rows if r[k] == "KILLED"
                and not any(r[o] == "KILLED" for o in KINDS if o != k))
    ms = sorted({r.get("test2_method", "") for r in rows
                 if r["test2_added"] in ("KILLED", "SURVIVED")
                 and r.get("test2_method")})
    row["test2_method"] = ";".join(ms)
    return row


def is_complete(csv_path):
    log = os.path.join(os.path.dirname(os.path.dirname(csv_path)), "logs",
                       os.path.basename(csv_path).replace(".csv", ".log"))
    try:
        return any(l.startswith("wall ") for l in open(log))
    except OSError:
        return False


def main():
    specs = [
        (GEN1, "*-gen.csv", "TARGET 1  AST mutator x GENERATOR source",
         "generator"),
        (GEN2, "*-emitted.csv",
         "TARGET 2  AST mutator x emitted C++ (new apps)", "emitted_cpp"),
    ]
    summary_rows = []
    for d, pat, title, tk in specs:
        files = sorted(glob.glob(os.path.join(d, pat)))
        if not files:
            continue
        print("\n" + "#" * 72)
        print("#", title)
        print("#" * 72)
        sub = defaultdict(int)
        for f in files:
            app = os.path.basename(f).rsplit("-", 1)[0]
            raw = load(f)
            if not raw:
                print(f"\n=== {app} === (no rows yet)")
                continue
            done = is_complete(f)
            s = summarise(raw, app + ("" if done else "  [PARTIAL]"))
            summary_rows.append(app_stats([normalise(r) for r in raw],
                                          "ast_mutator", tk, app, done))
            for k, v in s.items():
                sub[k] += v
        print(f"\n  --- {title} TOTAL ---")
        for k in ("points", "generated", "run", "killed", "equiv", "resolved"):
            print(f"    {k:10s} {sub[k]}")

    out = os.path.join(GEN1, "SUMMARY.csv")
    with open(out, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=SUMMARY_FIELDS, lineterminator="\n")
        w.writeheader()
        for r in summary_rows:
            w.writerow(r)
    print(f"\nwrote {out}")


if __name__ == "__main__":
    main()
