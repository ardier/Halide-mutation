#!/usr/bin/env python3
"""The thesis's headline comparison: Halide-native mutants (arm A) against
semantically-equivalent emitted-C++ mutants (arm C) for the same benchmark.

Arm A rows come from the completed 65-operator sweep on `Halide-mutation@wip-c`
(`mutation/results-full-sweep/`), merged across its two passes exactly the way
that sweep's own `final_report.py` merges them: keyed by mutant identity, an
evaluated row beats a NOT_RUN row, and when both passes evaluated the same
mutant the later verdict wins. Its stage-1 census (`census.json`) fills in the
app x operator-family cells the sweep never emitted a row for at all, so the
mutation-point counts here reproduce that report's totals (1,983 points, 542
effective, 49 O1 kills, 371 O2 kills over the full 14-app sweep) rather than
undercounting by the 86 points that only exist in the census.

Arm C rows come from `mutation/results-arm-c/`, produced by `arm_c_swsec.py`.

The two arms count different things, and the table keeps them separate rather
than pretending otherwise:

  * "C mutants" is every mutation point stock cxx_default found in the emitted
    file, whether or not the sweep got to all of them; "C n" in the kill-rate
    table is how many actually got a verdict. They differ only where a row is
    marked partial. "points" is every mutation point the frontend reported. It is the number
    the thesis's own "C++/Halide Mutants Ratio" column compares, so the ratio
    is computed on it.
  * "eval" is how many of those points actually got a verdict. Arm C evaluates
    every point. Arm A's sweep ran under a wall-clock budget that left some
    arithmetic points unevaluated, so for arm A eval < points.
  * "eff" (effective) is arm A's stronger denominator: points that survive to
    a runnable binary *and* provably change the emitted `.stmt`. Arm C has no
    equivalent filter -- there is no second compilation stage to diff -- so
    arm C kill rates are reported over all evaluated mutants. Both rates are
    printed for arm A so the comparison can be read either way.

Usage: python3 compare_arms.py [--arm-a DIR] [--arm-c DIR] [--out FILE]
"""
import argparse
import csv
import json
import os
import sys
from collections import defaultdict

HERE = os.path.dirname(os.path.abspath(__file__))
DEFAULT_A = "/mnt/scratch1/ardi/dsl_mut/armc-work/armA"
DEFAULT_CENSUS = "/mnt/scratch1/ardi/dsl_mut/armc-work/armA/census.json"

# The six operator families of the 65-operator arm-A sweep, in that sweep's
# own order (see mutation/halidemut/apps.py ARMS).
ARM_ORDER = ["arithmetic", "schedule", "generated", "boundary_conditions",
             "select_clamp", "if_then_else"]
DEFAULT_C = os.path.abspath(os.path.join(HERE, "..", "..", "results-arm-c"))

# The 13 real Table-4 benchmarks. `compositing` does not exist in this
# checkout (unmerged upstream branch) and `c_backend` is the C-backend's own
# demo app, not a benchmark -- both are excluded from every corpus total.
CORPUS = ["bgu", "bilateral_grid", "blur", "camera_pipe", "conv_layer",
          "depthwise_separable_conv", "harris", "hist", "iir_blur", "lens_blur",
          "max_filter", "nl_means", "unsharp"]

# Benchmarks with no arm-C data, and the specific reason for each. See
# ../../results-arm-c/BLOCKED.md for the evidence behind these one-liners.
BLOCKED = {
    "camera_pipe": "blocked: Halide C backend emits invalid C++ (void -> uint16_t)",
    "bgu": "blocked: Halide C backend emits invalid C++ (float8 -> float)",
    "lens_blur": "skipped: instrumentation compile killed at 2h04m / 84GB, no output",
}
C_BACKEND_BROKEN = set(BLOCKED)

# Stock cxx_default's arithmetic swaps. Note the asymmetry, which is a real
# finding and not a configuration slip: Mull ships 4 arithmetic operators
# (+<->- and *<->/ in both directions), while arm A's arithmetic family has all
# 12 ordered pairs over + - * / on Halide::Expr. The like-for-like table below
# compares these two sets on the same source expressions.
ARITH_CXX = {"cxx_add_to_sub", "cxx_sub_to_add", "cxx_mul_to_div",
             "cxx_div_to_mul"}


def load_arm_a(d):
    merged = {}
    dupes = 0
    for name in sorted(os.listdir(d)):
        if not name.endswith(".csv"):
            continue
        with open(os.path.join(d, name), newline="") as fh:
            for r in csv.DictReader(fh):
                key = (r["app"], r["arm"], r["mutator"], r["file"],
                       r["line"], r["column"])
                prev = merged.get(key)
                if prev is None:
                    merged[key] = r
                elif prev["stage2"] == "NOT_RUN" and r["stage2"] != "NOT_RUN":
                    merged[key] = r
                elif prev["stage2"] != "NOT_RUN" and r["stage2"] != "NOT_RUN":
                    dupes += 1
                    merged[key] = r
    if dupes:
        print(f"note: {dupes} arm-A mutants were evaluated in both passes; "
              f"later verdict kept", file=sys.stderr)
    return list(merged.values())


def arm_a_stats(rows):
    evaluated = [r for r in rows if r["stage2"] != "NOT_RUN"]
    runnable = [r for r in rows if r["stage2"] == "OK" and r["stage3"] == "OK"]
    eff = [r for r in runnable if r["stmt_differs"] == "1"]
    gen_kill = [r for r in rows if r["stage2"] in ("GEN_ERROR", "GEN_TIMEOUT")]
    return dict(
        points=len(rows), evaluated=len(evaluated), not_run=len(rows) - len(evaluated),
        gen_kill=len(gen_kill), equiv=len(runnable) - len(eff), eff=len(eff),
        o1=sum(1 for r in eff if r["o1"] == "KILLED") + len(gen_kill),
        o2=sum(1 for r in eff if r["o2"] == "KILLED") + len(gen_kill),
        o1_eff=sum(1 for r in eff if r["o1"] == "KILLED"),
        o2_eff=sum(1 for r in eff if r["o2"] == "KILLED"),
    )


def arm_a_app_stats(app, by_arm, census):
    """Per-app arm-A stats, reconciled against the stage-1 census.

    An app x family cell with no CSV rows at all is not necessarily empty: the
    sweep may simply have run out of wall-clock budget before reaching it. The
    census recorded how many points that cell really has, and those points are
    counted as unevaluated rather than as nonexistent."""
    total = defaultdict(int)
    for arm in ARM_ORDER:
        rows = by_arm.get((app, arm), [])
        s = arm_a_stats(rows)
        if not rows:
            n = census.get(app, {}).get(arm, {}).get("n", 0)
            if n > 0:
                s["points"] = n
                s["not_run"] = n
        for k, v in s.items():
            total[k] += v
    return total


def load_arm_c_meta(d):
    """Per-app sweep metadata, so a partially swept benchmark reports its true
    mutation-point total (for the count ratio) alongside how many of those
    points actually got a verdict (for the kill rate)."""
    meta = {}
    for name in sorted(os.listdir(d)):
        if name.endswith("-sweep.json"):
            m = json.load(open(os.path.join(d, name)))
            meta[m["app"]] = m
    return meta


def load_arm_c(d):
    by_app = defaultdict(list)
    for name in sorted(os.listdir(d)):
        if name.endswith("-cxx_default.csv"):
            with open(os.path.join(d, name), newline="") as fh:
                for r in csv.DictReader(fh):
                    by_app[r["app"]].append(r)
    return by_app


def arm_c_stats(rows, region=None):
    sel = rows if region is None else [r for r in rows if r["region"] == region]
    return dict(points=len(sel),
                o1=sum(int(r["o1_killed"]) for r in sel),
                o2=sum(int(r["o2_killed"]) for r in sel))


def pct(k, n):
    return f"{100.0 * k / n:5.1f}%" if n else "    - "


def ratio(c, a):
    """C++ mutants per Halide mutant -- the thesis's "C++/Halide Mutants
    Ratio". Blank rather than 0.0x when arm C produced nothing for a
    benchmark, since that means "not measurable here", not "zero"."""
    return f"{c / a:6.1f}x" if a and c else "      -"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--arm-a", default=DEFAULT_A)
    ap.add_argument("--census", default=DEFAULT_CENSUS)
    ap.add_argument("--arm-c", default=DEFAULT_C)
    ap.add_argument("--out", default=None)
    args = ap.parse_args()

    census = json.load(open(args.census)) if os.path.exists(args.census) else {}
    if not census:
        print(f"warning: no census at {args.census}; arm-A point counts will "
              f"omit families the sweep never reached", file=sys.stderr)
    by_arm = defaultdict(list)
    apps_seen = set()
    for r in load_arm_a(args.arm_a):
        by_arm[(r["app"], r["arm"])].append(r)
        apps_seen.add(r["app"])
    a_stats = {app: arm_a_app_stats(app, by_arm, census)
               for app in apps_seen | set(census)}
    c_rows = load_arm_c(args.arm_c)
    c_meta = load_arm_c_meta(args.arm_c)

    out = []
    def p(s=""):
        out.append(s)
        print(s)

    W = 122
    p("=" * W)
    p("HALIDE-NATIVE (arm A, 65 operators) vs. EMITTED-C++ (arm C, stock cxx_default) -- mutant counts")
    p("=" * W)
    p(f"{'benchmark':<26}{'A pts':>7}{'A eval':>7}{'A eff':>7}"
      f"{'C mutants':>11}{'C gen-spec':>11}{'C/A pts':>9}{'C/A eff':>9}  status")
    p("-" * W)
    tot = defaultdict(int)
    for app in CORPUS:
        a = a_stats.get(app, defaultdict(int))
        cr = c_rows.get(app, [])
        c = arm_c_stats(cr)
        cg = arm_c_stats(cr, "generator_specific")
        m = c_meta.get(app, {})
        c_total = m.get("mutants", c["points"])
        if app in BLOCKED:
            status = BLOCKED[app]
        elif not cr:
            status = "arm C missing"
        else:
            status = ("" if m.get("status", "COMPLETE") == "COMPLETE"
                      else f"partial: {c['points']} of {c_total} swept "
                           f"(shuffled order, so an unbiased sample)")
            tot["n"] += 1
            tot["A_pts"] += a["points"]; tot["A_eval"] += a["evaluated"]
            tot["A_eff"] += a["eff"]; tot["A_o1"] += a["o1_eff"]; tot["A_o2"] += a["o2_eff"]
            tot["C_tot"] += c_total
            tot["C_pts"] += c["points"]; tot["C_o1"] += c["o1"]; tot["C_o2"] += c["o2"]
            tot["Cg_pts"] += cg["points"]; tot["Cg_o1"] += cg["o1"]; tot["Cg_o2"] += cg["o2"]
        p(f"{app:<26}{a['points']:>7}{a['evaluated']:>7}{a['eff']:>7}"
          f"{c_total:>11}{cg['points']:>11}"
          f"{ratio(c_total, a['points']):>9}{ratio(c_total, a['eff']):>9}  {status}")
    CORPUS_LABEL = f"CORPUS ({tot['n']} comparable)"
    p("-" * W)
    p(f"{CORPUS_LABEL:<26}{tot['A_pts']:>7}{tot['A_eval']:>7}{tot['A_eff']:>7}"
      f"{tot['C_tot']:>11}{tot['Cg_pts']:>11}"
      f"{ratio(tot['C_tot'], tot['A_pts']):>9}{ratio(tot['C_tot'], tot['A_eff']):>9}")
    p()

    p("=" * W)
    p("KILL RATES -- arm A over effective mutants, arm C over all evaluated mutants")
    p("=" * W)
    p(f"{'benchmark':<26}{'A eff':>7}{'A O1':>7}{'A O2':>7}"
      f"{'C n':>8}{'C O1':>7}{'C O2':>7}   {'A O1%':>7}{'A O2%':>7}{'C O1%':>7}{'C O2%':>7}")
    p("-" * W)
    for app in CORPUS:
        if app in C_BACKEND_BROKEN or not c_rows.get(app):
            continue
        a = a_stats.get(app, defaultdict(int))
        c = arm_c_stats(c_rows[app])
        p(f"{app:<26}{a['eff']:>7}{a['o1_eff']:>7}{a['o2_eff']:>7}"
          f"{c['points']:>8}{c['o1']:>7}{c['o2']:>7}   "
          f"{pct(a['o1_eff'], a['eff']):>7}{pct(a['o2_eff'], a['eff']):>7}"
          f"{pct(c['o1'], c['points']):>7}{pct(c['o2'], c['points']):>7}")
    p("-" * W)
    p(f"{CORPUS_LABEL:<26}{tot['A_eff']:>7}{tot['A_o1']:>7}{tot['A_o2']:>7}"
      f"{tot['C_pts']:>8}{tot['C_o1']:>7}{tot['C_o2']:>7}   "
      f"{pct(tot['A_o1'], tot['A_eff']):>7}{pct(tot['A_o2'], tot['A_eff']):>7}"
      f"{pct(tot['C_o1'], tot['C_pts']):>7}{pct(tot['C_o2'], tot['C_pts']):>7}")
    p()

    p("=" * W)
    p("DENOMINATOR SENSITIVITY -- the two arms do not filter equivalent mutants the same way")
    p("=" * W)
    p("Arm A can tell an equivalent mutant from a real one for free: Halide")
    p("compiles in stages, so the mutated generator's emitted .stmt can be")
    p("diffed against the baseline's before any test runs. 200 of its 1,983")
    p("points corpus-wide are provably equivalent at target=host and 51 are")
    p("killed by the Halide compiler itself. Arm C has no such stage -- the")
    p("emitted .cpp already is the lowered pipeline -- so nothing distinguishes")
    p("an equivalent emitted-C++ mutant from a live one short of running it.")
    p("That asymmetry is itself a property of multi-stage DSL compilation, but")
    p("it means arm A's rate is over a cleaner denominator, so both are shown.")
    p()
    ev = defaultdict(int)
    for app in CORPUS:
        if app in C_BACKEND_BROKEN or not c_rows.get(app):
            continue
        a = a_stats.get(app, defaultdict(int))
        for k in ("evaluated", "eff", "o1", "o2", "o1_eff", "o2_eff",
                  "equiv", "gen_kill"):
            ev[k] += a[k]
    p(f"{'arm A, over effective mutants':<44}"
      f"{tot['A_eff']:>7}{tot['A_o1']:>8}{tot['A_o2']:>8}"
      f"{pct(tot['A_o1'], tot['A_eff']):>9}{pct(tot['A_o2'], tot['A_eff']):>9}")
    p(f"{'arm A, over all evaluated (incl. equivalent)':<44}"
      f"{ev['evaluated']:>7}{ev['o1']:>8}{ev['o2']:>8}"
      f"{pct(ev['o1'], ev['evaluated']):>9}{pct(ev['o2'], ev['evaluated']):>9}")
    p(f"{'arm C, over all mutants (no equiv filter)':<44}"
      f"{tot['C_pts']:>7}{tot['C_o1']:>8}{tot['C_o2']:>8}"
      f"{pct(tot['C_o1'], tot['C_pts']):>9}{pct(tot['C_o2'], tot['C_pts']):>9}")
    p(f"{'  (arm A equivalent-at-host / compiler-killed)':<44}"
      f"{ev['equiv']:>7}{ev['gen_kill']:>8}")
    p()

    p("=" * W)
    p("LIKE-FOR-LIKE: ARITHMETIC OPERATORS ONLY")
    p("(the closest match to the thesis's own framing -- arm A's 12 pairwise")
    p(" +-*/ swaps on Halide::Expr against the 4 arithmetic swaps stock")
    p(" cxx_default actually ships. Same source expressions, same algorithm,")
    p(" one mutated before Halide lowers it and one after.)")
    p("=" * W)
    p(f"{'benchmark':<26}{'A pts':>7}{'A eff':>7}{'A O1%':>8}{'A O2%':>8}"
      f"{'C n':>7}{'C gspec':>9}{'C O1%':>8}{'C O2%':>8}{'C/A pts':>9}{'C/A eff':>9}")
    p("-" * W)
    at = defaultdict(int)
    for app in CORPUS:
        if app in C_BACKEND_BROKEN or not c_rows.get(app):
            continue
        arows = by_arm.get((app, "arithmetic"), [])
        a = arm_a_stats(arows)
        if not arows:
            n = census.get(app, {}).get("arithmetic", {}).get("n", 0)
            a["points"] = n
        ca = [r for r in c_rows[app] if r["mutator"] in ARITH_CXX]
        cag = [r for r in ca if r["region"] == "generator_specific"]
        c = arm_c_stats(ca)
        cg = arm_c_stats(cag)
        at["A_pts"] += a["points"]; at["A_eff"] += a["eff"]
        at["A_o1"] += a["o1_eff"]; at["A_o2"] += a["o2_eff"]
        at["C_n"] += c["points"]; at["C_o1"] += c["o1"]; at["C_o2"] += c["o2"]
        at["Cg_n"] += cg["points"]; at["Cg_o1"] += cg["o1"]; at["Cg_o2"] += cg["o2"]
        p(f"{app:<26}{a['points']:>7}{a['eff']:>7}"
          f"{pct(a['o1_eff'], a['eff']):>8}{pct(a['o2_eff'], a['eff']):>8}"
          f"{c['points']:>7}{cg['points']:>9}"
          f"{pct(c['o1'], c['points']):>8}{pct(c['o2'], c['points']):>8}"
          f"{ratio(c['points'], a['points']):>9}{ratio(c['points'], a['eff']):>9}")
    p("-" * W)
    p(f"{CORPUS_LABEL:<26}{at['A_pts']:>7}{at['A_eff']:>7}"
      f"{pct(at['A_o1'], at['A_eff']):>8}{pct(at['A_o2'], at['A_eff']):>8}"
      f"{at['C_n']:>7}{at['Cg_n']:>9}"
      f"{pct(at['C_o1'], at['C_n']):>8}{pct(at['C_o2'], at['C_n']):>8}"
      f"{ratio(at['C_n'], at['A_pts']):>9}{ratio(at['C_n'], at['A_eff']):>9}")
    p(f"{'  ... generator-specific':<26}{'':>7}{'':>7}{'':>8}{'':>8}"
      f"{at['Cg_n']:>7}{'':>9}"
      f"{pct(at['Cg_o1'], at['Cg_n']):>8}{pct(at['Cg_o2'], at['Cg_n']):>8}"
      f"{ratio(at['Cg_n'], at['A_pts']):>9}{ratio(at['Cg_n'], at['A_eff']):>9}")
    p()

    p("=" * W)
    p("ARM C BY EMITTED-FILE REGION -- whole file vs. generator-specific only")
    p("(the boilerplate prefix is byte-identical across independently lowered")
    p(" generators; see ../survey.py and bucket_mutants.py for the split)")
    p("=" * W)
    p(f"{'benchmark':<26}{'boiler n':>10}{'O1%':>8}{'O2%':>8}"
      f"{'gen-spec n':>12}{'O1%':>8}{'O2%':>8}{'wrapper n':>11}{'O1%':>8}{'O2%':>8}")
    p("-" * W)
    agg = {r: defaultdict(int) for r in ("boilerplate", "generator_specific",
                                         "wrapper_metadata")}
    for app in CORPUS:
        rows = c_rows.get(app)
        if not rows or app in C_BACKEND_BROKEN:
            continue
        cells = []
        for reg in ("boilerplate", "generator_specific", "wrapper_metadata"):
            s = arm_c_stats(rows, reg)
            agg[reg]["n"] += s["points"]; agg[reg]["o1"] += s["o1"]; agg[reg]["o2"] += s["o2"]
            cells.append(s)
        p(f"{app:<26}"
          f"{cells[0]['points']:>10}{pct(cells[0]['o1'], cells[0]['points']):>8}{pct(cells[0]['o2'], cells[0]['points']):>8}"
          f"{cells[1]['points']:>12}{pct(cells[1]['o1'], cells[1]['points']):>8}{pct(cells[1]['o2'], cells[1]['points']):>8}"
          f"{cells[2]['points']:>11}{pct(cells[2]['o1'], cells[2]['points']):>8}{pct(cells[2]['o2'], cells[2]['points']):>8}")
    p("-" * W)
    p(f"{CORPUS_LABEL:<26}"
      f"{agg['boilerplate']['n']:>10}{pct(agg['boilerplate']['o1'], agg['boilerplate']['n']):>8}"
      f"{pct(agg['boilerplate']['o2'], agg['boilerplate']['n']):>8}"
      f"{agg['generator_specific']['n']:>12}{pct(agg['generator_specific']['o1'], agg['generator_specific']['n']):>8}"
      f"{pct(agg['generator_specific']['o2'], agg['generator_specific']['n']):>8}"
      f"{agg['wrapper_metadata']['n']:>11}{pct(agg['wrapper_metadata']['o1'], agg['wrapper_metadata']['n']):>8}"
      f"{pct(agg['wrapper_metadata']['o2'], agg['wrapper_metadata']['n']):>8}")
    p()

    p("=" * W)
    p("ARM C BY MUTATOR (whole corpus)")
    p("=" * W)
    by_mut = defaultdict(lambda: defaultdict(int))
    for app, rows in c_rows.items():
        for r in rows:
            m = by_mut[r["mutator"]]
            m["n"] += 1; m["o1"] += int(r["o1_killed"]); m["o2"] += int(r["o2_killed"])
    p(f"{'mutator':<34}{'n':>8}{'O1':>7}{'O2':>7}{'O1%':>8}{'O2%':>8}")
    p("-" * W)
    for name in sorted(by_mut, key=lambda k: -by_mut[k]["n"]):
        m = by_mut[name]
        p(f"{name:<34}{m['n']:>8}{m['o1']:>7}{m['o2']:>7}"
          f"{pct(m['o1'], m['n']):>8}{pct(m['o2'], m['n']):>8}")

    if args.out:
        with open(args.out, "w") as f:
            f.write("\n".join(out) + "\n")
        print(f"\nwritten to {args.out}", file=sys.stderr)


if __name__ == "__main__":
    main()
