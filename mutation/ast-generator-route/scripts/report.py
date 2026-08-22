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
import re
import sys
from collections import Counter, defaultdict

KINDS = ["test1_demo", "test2_added", "test3_perf"]


def load(path):
    with open(path) as fh:
        return list(csv.DictReader(fh))


# A digest the harness could not actually read. Recorded rather than crashed
# on, which is what makes the correction below possible after the fact.
MISSING = ("<missing>", "<absent>", "")


def _repair_missing_artifact(out, r):
    """Un-score an output comparison that had no output to compare.

    The emitted-C++ harness (b1/run_harness.py) guards only the TIMEOUT case
    before scoring test2_golden. A golden run that ABORTS or exits nonzero
    also writes no artifact, and its digest then reads "<missing>", which
    compares unequal to the golden digest and is scored KILLED. That credits
    the added test with a kill on a mutant the demo test had already caught,
    and inflates exactly the number the added test exists to measure.

    Measured: 62 of resize's 251 test2 kills, and 6 of 30 blur generator
    mutants before the generator harness was fixed at source. The generator
    harness now refuses to score these; this repairs rows written by the
    emitted harness, which records artifact_digest and so still carries the
    evidence needed to correct them.

    A run that legitimately produced a different artifact is untouched -- it
    has a real digest.
    """
    if out.get("test2_added") != "KILLED":
        return 0
    dig = (r.get("artifact_digest") or "").strip()
    if dig in MISSING or dig.startswith("<"):
        out["test2_added"] = "NOT_RUN"
        out["_repaired"] = 1
        return 1
    return 0


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
    _repair_missing_artifact(out, r)
    return out


def summarise(rows, label, pts_total=None):
    rows = [normalise(r) for r in rows]
    n = len(rows)
    total = pts_total if pts_total is not None else n

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
    print(f"  points identified              {total}")
    if total != n:
        print(f"  NOT REACHED (still running)    {total - n}")
    print(f"  points evaluated               {n}")
    print(f"  tool/compiler rejected mutant  {gen_fail}")
    print(f"  mutants generated              {n - gen_fail}")
    if genlink_fail:
        print(f"    generator link failed        {genlink_fail}")
    if gen_no_pipe:
        print(f"    generator produced no pipeline {gen_no_pipe}")
    print(f"    equivalent (TCE)             {equiv}"
          + (f"   ({100.0*equiv/n:.1f}% of evaluated)" if n else ""))
    if link_fail:
        print(f"    driver link failed           {link_fail}")
    print(f"  mutants RUN                    {ran}")
    print(f"  mutants KILLED                 {killed}")
    print(f"  RESOLVED (killed or equiv)     {resolved}"
          + (f"   ({100.0*resolved/n:.1f}% of evaluated)" if n else ""))

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
    repaired = sum(int(r.get("_repaired") or 0) for r in rows)
    if repaired:
        print(f"    [corrected] {repaired} test2 'kills' were scored against a "
              f"MISSING artifact\n"
              f"                (golden run aborted / exited nonzero, wrote "
              f"nothing) and are\n"
              f"                re-recorded NOT_RUN: nothing to compare is not "
              f"a kill.")
    return dict(points=total, evaluated=n, generated=n - gen_fail, run=ran, killed=killed,
                equiv=equiv, resolved=resolved)


GEN1 = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen1/out"
GEN2 = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen2/out"

SUMMARY_FIELDS = [
    "route", "target_kind", "app", "driver_kind", "points_identified",
    "points_evaluated", "not_reached", "mutants_generated", "mutants_run", "mutants_killed", "equivalent_tce",
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


def app_stats(rows, route, tk, app, complete, pts_total=None):
    """One summary row. Every denominator counts only mutants on which that
    kind actually RAN; NOT_RUN never enters one."""
    n = len(rows)
    bad = sum(1 for r in rows if (r.get("stage_compile") or "")
              in ("GEN_FAIL", "COMPILE_FAIL", "HARNESS_ERROR"))
    total = pts_total if pts_total is not None else n
    row = {f: "" for f in SUMMARY_FIELDS}
    row.update(route=route, target_kind=tk, app=app,
               driver_kind=driver_kind(app), points_identified=total,
               points_evaluated=n, not_reached=max(0, total - n),
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


POINTS_RE = re.compile(r"\[\w+\]\s+(\d+) points identified")


def log_facts(csv_path):
    """(complete, points_identified) read from the run's own log.

    For a run still in flight the CSV holds only the rows written so far.
    Taking points_identified from the CSV would silently shrink the
    denominator to whatever happened to be finished, which is the exact way a
    partial result turns into an overstated rate. The log records the true
    identified count at emit time, before any mutant was evaluated, so it is
    the honest denominator; the difference between it and the rows written is
    reported as NOT REACHED rather than folded into anything.
    """
    log = os.path.join(os.path.dirname(os.path.dirname(csv_path)), "logs",
                       os.path.basename(csv_path).replace(".csv", ".log"))
    complete, pts = False, None
    try:
        for line in open(log):
            if line.startswith("wall "):
                complete = True
            m = POINTS_RE.search(line)
            if m and pts is None:
                pts = int(m.group(1))
    except OSError:
        pass
    return complete, pts


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
            done, pts = log_facts(f)
            label = app if done else f"{app}  [PARTIAL]"
            s = summarise(raw, label, pts)
            summary_rows.append(app_stats([normalise(r) for r in raw],
                                          "ast_mutator", tk, app, done, pts))
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
