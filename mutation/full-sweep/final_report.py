"""Build the final per-benchmark x operator-family table.

Raw mutation-point counts come from the result CSVs, which carry one row per
mutant including the ones a wall-clock budget left unevaluated. The stage-1
census fills in only the cells the sweep skipped because the census had already
recorded them as zero, and the cells a benchmark ran out of budget before
reaching at all.
"""
import csv
import json
import sys
from pathlib import Path

ROOT = Path("/home/ardi/project/dsl_mutants/halide")
WORK = ROOT / "sweep-work"
HAL = ROOT / "Halide-mutation-wip-c"
RESULTS = HAL / "mutation" / "results-full-sweep"
sys.path.insert(0, str(HAL / "mutation"))
from halidemut.apps import APPS, ARMS, ARM_FAMILY, ARM_ROUTE  # noqa: E402

CENSUS = json.loads((WORK / "census" / "census.json").read_text())
ARM_ORDER = ["arithmetic", "schedule", "generated",
             "boundary_conditions", "select_clamp", "if_then_else"]


def load_rows():
    rows = []
    for p in sorted(RESULTS.glob("*.csv")):
        with p.open(newline="") as fh:
            rows += list(csv.DictReader(fh))
    return rows


def stats(rows):
    runnable = [r for r in rows if r["stage2"] == "OK" and r["stage3"] == "OK"]
    eff = [r for r in runnable if r["stmt_differs"] == "1"]
    return {
        "raw": len(rows),
        "gen_kill": sum(1 for r in rows
                        if r["stage2"] in ("GEN_ERROR", "GEN_TIMEOUT")),
        "bld": sum(1 for r in rows if r["stage3"] == "BUILD_ERROR"),
        "harness": sum(1 for r in rows if r["stage2"] == "HARNESS_ERROR"),
        "not_run": sum(1 for r in rows if r["stage2"] == "NOT_RUN"),
        "equiv": len(runnable) - len(eff),
        "eff": len(eff),
        "o1": sum(1 for r in eff if r["o1"] == "KILLED"),
        "o2": sum(1 for r in eff if r["o2"] == "KILLED"),
        "any": sum(1 for r in eff if r["o1"] == "KILLED" or r["o2"] == "KILLED"),
    }


def cell_stats(app, arm, by):
    """Stats for one app x family cell, reconciled against the census.

    Three cases produce an empty CSV cell and they are not the same thing:
      - the census recorded zero mutation points, so the sweep skipped it
      - the census recorded some, but the benchmark ran out of budget before
        reaching this family: those mutants are real but unevaluated
      - never censused and never run
    """
    rows = by.get((app, arm), [])
    s = stats(rows)
    if rows:
        return s
    n = CENSUS.get(app, {}).get(arm, {}).get("n", 0)
    if n > 0:
        s["raw"] = n
        s["not_run"] = n
    return s


def agg(cells):
    out = {k: 0 for k in ("raw", "gen_kill", "bld", "harness", "not_run",
                          "equiv", "eff", "o1", "o2", "any")}
    for c in cells:
        for k in out:
            out[k] += c[k]
    return out


def pct(n, d):
    return "    -" if d == 0 else f"{100.0*n/d:5.1f}%"


HDR = (f"{'raw':>5}{'notRun':>7}{'genKill':>8}{'bldErr':>7}{'equiv':>7}"
       f"{'eff':>5}{'O1k':>5}{'O2k':>5}{'O1%':>8}{'O2%':>8}")


def fmt(s):
    return (f"{s['raw']:>5}{s['not_run']:>7}{s['gen_kill']:>8}{s['bld']:>7}"
            f"{s['equiv']:>7}{s['eff']:>5}{s['o1']:>5}{s['o2']:>5}"
            f"{pct(s['o1'], s['eff']):>8}{pct(s['o2'], s['eff']):>8}")


def main():
    rows = load_rows()
    by = {}
    for r in rows:
        by.setdefault((r["app"], r["arm"]), []).append(r)

    apps = sorted(APPS)
    out = []
    out.append("=" * 120)
    out.append("PER BENCHMARK x OPERATOR FAMILY   "
               "(65 Halide-native operators, target=host)")
    out.append("=" * 120)
    out.append(f"{'benchmark':<26}{'operator family':<32}" + HDR)
    out.append("-" * 120)
    for app in apps:
        cells = []
        first = True
        for arm in ARM_ORDER:
            s = cell_stats(app, arm, by)
            cells.append(s)
            out.append(f"{(app if first else ''):<26}"
                       f"{ARM_FAMILY[arm]:<32}" + fmt(s))
            first = False
        out.append(f"{'':<26}{'ALL FAMILIES':<32}" + fmt(agg(cells)))
        out.append("")

    out.append("=" * 120)
    out.append("PER OPERATOR FAMILY (whole corpus)")
    out.append("=" * 120)
    out.append(f"{'operator family':<26}{'route':<6}{'ops':>5}{'apps':>6}" + HDR)
    out.append("-" * 120)
    fam_cells = {}
    for arm in ARM_ORDER:
        cells = [cell_stats(a, arm, by) for a in apps]
        fam_cells[arm] = cells
        live = sum(1 for c in cells if c["raw"] > 0)
        out.append(f"{ARM_FAMILY[arm]:<26}{ARM_ROUTE[arm]:<6}"
                   f"{len(ARMS[arm]):>5}{live:>6}" + fmt(agg(cells)))
    out.append("-" * 120)
    out.append(f"{'TOTAL':<26}{'':<6}"
               f"{sum(len(ARMS[a]) for a in ARM_ORDER):>5}{'':>6}"
               + fmt(agg([c for cs in fam_cells.values() for c in cs])))

    out.append("")
    out.append("=" * 120)
    out.append("PER OPERATOR (operators with >=1 mutation point in the corpus)")
    out.append("=" * 120)
    out.append(f"{'operator':<38}{'family':<28}{'raw':>5}{'notRun':>7}"
               f"{'genKill':>8}{'equiv':>7}{'eff':>5}{'O1k':>5}{'O2k':>5}"
               f"{'O2%':>8}")
    out.append("-" * 120)
    by_op = {}
    for r in rows:
        by_op.setdefault((r["arm"], r["mutator"]), []).append(r)
    for (arm, op) in sorted(by_op):
        s = stats(by_op[(arm, op)])
        out.append(f"{op:<38}{ARM_FAMILY[arm]:<28}{s['raw']:>5}"
                   f"{s['not_run']:>7}{s['gen_kill']:>8}{s['equiv']:>7}"
                   f"{s['eff']:>5}{s['o1']:>5}{s['o2']:>5}"
                   f"{pct(s['o2'], s['eff']):>8}")

    seen = {op for _, op in by_op}
    inert = [(arm, op) for arm in ARM_ORDER for op in ARMS[arm]
             if op not in seen]
    out.append("")
    out.append(f"Operators with no mutation point anywhere in the swept "
               f"corpus: {len(inert)} of 65")
    for arm, op in inert:
        out.append(f"    {op:<42}({ARM_FAMILY[arm]})")

    out.append("")
    out.append("raw     = mutation points recorded for this cell")
    out.append("notRun  = real mutation points the benchmark's wall-clock "
               "budget never reached. Excluded from every rate.")
    out.append("genKill = the Halide compiler itself rejected the mutant -- a "
               "kill category only staged compilation produces")
    out.append("equiv   = emitted .stmt byte-identical to baseline: unreachable "
               "at target=host, unkillable by any oracle")
    out.append("eff     = effective (reachable, code-changing) mutants. O1% and "
               "O2% are over eff, never over raw.")

    text = "\n".join(out) + "\n"
    print(text)
    (RESULTS / "FINAL-REPORT.txt").write_text(text)


if __name__ == "__main__":
    main()
