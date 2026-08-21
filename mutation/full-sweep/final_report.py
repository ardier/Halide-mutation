"""Build the final per-benchmark x operator-family table.

Merges the stage-1 census (which records the arms that produced *zero* mutation
points, and so never reach the result CSVs) with the per-app result CSVs.
"""
import csv
import json
import sys
from pathlib import Path

ROOT = Path("/home/ardi/project/dsl_mutants/halide")
WORK = ROOT / "sweep-work"
sys.path.insert(0, str(ROOT / "Halide-mutation-wip-c" / "mutation"))
from halidemut.apps import APPS, ARMS, ARM_FAMILY, ARM_ROUTE  # noqa: E402

CENSUS = json.loads((WORK / "census" / "census.json").read_text())
ARM_ORDER = ["arithmetic", "schedule", "generated",
             "boundary_conditions", "select_clamp", "if_then_else"]


def load_rows():
    rows = []
    for p in sorted((WORK / "results").glob("*.csv")):
        with p.open(newline="") as fh:
            rows += list(csv.DictReader(fh))
    return rows


def stats(rows):
    gen_kill = sum(1 for r in rows if r["stage2"] in ("GEN_ERROR", "GEN_TIMEOUT"))
    bld = sum(1 for r in rows if r["stage3"] == "BUILD_ERROR")
    harn = sum(1 for r in rows if r["stage2"] == "HARNESS_ERROR")
    runnable = [r for r in rows if r["stage2"] == "OK" and r["stage3"] == "OK"]
    eff = [r for r in runnable if r["stmt_differs"] == "1"]
    return {
        "gen_kill": gen_kill, "bld": bld, "harness": harn,
        "equiv": len(runnable) - len(eff), "eff": len(eff),
        "o1": sum(1 for r in eff if r["o1"] == "KILLED"),
        "o2": sum(1 for r in eff if r["o2"] == "KILLED"),
        "any": sum(1 for r in eff if r["o1"] == "KILLED" or r["o2"] == "KILLED"),
    }


def pct(n, d):
    return "    -" if d == 0 else f"{100.0*n/d:5.1f}%"


def main():
    rows = load_rows()
    by = {}
    for r in rows:
        by.setdefault((r["app"], r["arm"]), []).append(r)

    apps = sorted(CENSUS)
    out = []
    out.append("=" * 118)
    out.append("PER BENCHMARK x OPERATOR FAMILY   (65 Halide-native operators, target=host)")
    out.append("=" * 118)
    out.append(f"{'benchmark':<26}{'operator family':<32}{'raw':>5}{'genKill':>8}"
               f"{'bldErr':>7}{'equiv':>7}{'eff':>5}{'O1k':>5}{'O2k':>5}"
               f"{'O1%':>8}{'O2%':>8}")
    out.append("-" * 118)
    for app in apps:
        first = True
        for arm in ARM_ORDER:
            raw = CENSUS[app].get(arm, {}).get("n", 0)
            cell = by.get((app, arm), [])
            if raw <= 0 and not cell:
                s = dict(gen_kill=0, bld=0, harness=0, equiv=0, eff=0,
                         o1=0, o2=0, any=0)
                raw = max(raw, 0)
            else:
                s = stats(cell)
            name = app if first else ""
            first = False
            out.append(
                f"{name:<26}{ARM_FAMILY[arm]:<32}{raw:>5}{s['gen_kill']:>8}"
                f"{s['bld']:>7}{s['equiv']:>7}{s['eff']:>5}{s['o1']:>5}"
                f"{s['o2']:>5}{pct(s['o1'], s['eff']):>8}{pct(s['o2'], s['eff']):>8}")
        tot_raw = sum(CENSUS[app].get(a, {}).get("n", 0) for a in ARM_ORDER)
        ts = stats([r for k, v in by.items() if k[0] == app for r in v])
        out.append(f"{'':<26}{'ALL FAMILIES':<32}{tot_raw:>5}{ts['gen_kill']:>8}"
                   f"{ts['bld']:>7}{ts['equiv']:>7}{ts['eff']:>5}{ts['o1']:>5}"
                   f"{ts['o2']:>5}{pct(ts['o1'], ts['eff']):>8}"
                   f"{pct(ts['o2'], ts['eff']):>8}")
        out.append("")

    out.append("=" * 118)
    out.append("PER OPERATOR FAMILY (whole corpus)")
    out.append("=" * 118)
    out.append(f"{'operator family':<32}{'route':<6}{'ops':>5}{'raw':>6}{'genKill':>8}"
               f"{'bldErr':>7}{'equiv':>7}{'eff':>5}{'O1k':>5}{'O2k':>5}"
               f"{'O1%':>8}{'O2%':>8}")
    out.append("-" * 118)
    for arm in ARM_ORDER:
        raw = sum(CENSUS[a].get(arm, {}).get("n", 0) for a in apps)
        cell = [r for k, v in by.items() if k[1] == arm for r in v]
        s = stats(cell)
        out.append(f"{ARM_FAMILY[arm]:<32}{ARM_ROUTE[arm]:<6}{len(ARMS[arm]):>5}{raw:>6}"
                   f"{s['gen_kill']:>8}{s['bld']:>7}{s['equiv']:>7}{s['eff']:>5}"
                   f"{s['o1']:>5}{s['o2']:>5}{pct(s['o1'], s['eff']):>8}"
                   f"{pct(s['o2'], s['eff']):>8}")
    raw_all = sum(CENSUS[a].get(x, {}).get("n", 0) for a in apps for x in ARM_ORDER)
    sa = stats(rows)
    out.append("-" * 118)
    out.append(f"{'TOTAL':<32}{'':<6}{sum(len(ARMS[a]) for a in ARM_ORDER):>5}{raw_all:>6}"
               f"{sa['gen_kill']:>8}{sa['bld']:>7}{sa['equiv']:>7}{sa['eff']:>5}"
               f"{sa['o1']:>5}{sa['o2']:>5}{pct(sa['o1'], sa['eff']):>8}"
               f"{pct(sa['o2'], sa['eff']):>8}")

    out.append("")
    out.append("=" * 118)
    out.append("PER OPERATOR (only operators with >=1 mutation point in the corpus)")
    out.append("=" * 118)
    out.append(f"{'operator':<38}{'family':<32}{'raw':>5}{'genKill':>8}{'equiv':>7}"
               f"{'eff':>5}{'O1k':>5}{'O2k':>5}{'O2%':>8}")
    out.append("-" * 118)
    per_op_raw = {}
    for app in apps:
        for arm in ARM_ORDER:
            for op, n in CENSUS[app].get(arm, {}).get("per_op", {}).items():
                per_op_raw[(arm, op)] = per_op_raw.get((arm, op), 0) + n
    by_op = {}
    for r in rows:
        by_op.setdefault((r["arm"], r["mutator"]), []).append(r)
    for (arm, op) in sorted(per_op_raw):
        s = stats(by_op.get((arm, op), []))
        out.append(f"{op:<38}{ARM_FAMILY[arm]:<32}{per_op_raw[(arm, op)]:>5}"
                   f"{s['gen_kill']:>8}{s['equiv']:>7}{s['eff']:>5}{s['o1']:>5}"
                   f"{s['o2']:>5}{pct(s['o2'], s['eff']):>8}")

    inert = []
    for arm in ARM_ORDER:
        for op in ARMS[arm]:
            if (arm, op) not in per_op_raw:
                inert.append((arm, op))
    out.append("")
    out.append(f"Operators with zero mutation points anywhere in the corpus: {len(inert)}")
    for arm, op in inert:
        out.append(f"    {op:<40}({ARM_FAMILY[arm]})")

    out.append("")
    out.append("raw     = mutation points the frontend recorded")
    out.append("genKill = the Halide compiler itself rejected the mutant (a kill "
               "category only staged compilation produces)")
    out.append("equiv   = emitted .stmt byte-identical to baseline: unreachable at "
               "target=host, unkillable by any oracle")
    out.append("eff     = effective (reachable, code-changing) mutants; O1%/O2% are "
               "over these, never over raw")

    text = "\n".join(out) + "\n"
    print(text)
    (WORK / "final-report.txt").write_text(text)


if __name__ == "__main__":
    main()
