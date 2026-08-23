#!/usr/bin/env python3
"""The two numbers the experiment exists to produce, side by side.

  survivors per point   -- how much of the mutant population needed new tests
  tests per resolution  -- what it cost to clear what did

Both routes here are the same corpus, the same tool and the same oracles; the
only difference is WHERE the mutation lands: in the Halide generator, or in the
C++ that generator emits.
"""
import csv, glob, os, sys

GEN = sys.argv[1] if len(sys.argv) > 1 else \
    "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen1/out"

g = dict(pts=0, run=0, kill=0, eq=0, stage=0)
for f in sorted(glob.glob(GEN + "/*-gen.csv")):
    if "smoke" in f:
        continue
    rows = list(csv.DictReader(open(f)))
    eq = sum(1 for r in rows if r["equivalent"])
    run = sum(1 for r in rows if r["test1_demo"] in ("KILLED", "SURVIVED")
              or r["test2_added"] in ("KILLED", "SURVIVED"))
    g["pts"] += len(rows); g["eq"] += eq; g["run"] += run
    g["kill"] += sum(1 for r in rows if r["killed_by"])
    g["stage"] += len(rows) - run - eq
g["made"] = g["pts"] - g["stage"]
surv = g["run"] - g["kill"]

em = [r for r in csv.DictReader(open(GEN + "/SUMMARY.csv"))
      if r["target_kind"] == "emitted_cpp"]
P = sum(int(r["points_identified"]) for r in em)
M = sum(int(r["mutants_generated"]) for r in em)
R = sum(int(r["mutants_run"]) for r in em)
K = sum(int(r["mutants_killed"]) for r in em)
E = sum(int(r["equivalent_tce"]) for r in em)

print(f"{'':22s}{'generator (16 apps)':>22s}{'emitted C++ (3 apps)':>22s}")
def row(label, a, b):
    print(f"{label:22s}{a:>22}{b:>22}")
row("points identified", g["pts"], P)
row("mutants generated", g["made"], M)
row("TCE-equivalent", f"{g['eq']} ({g['eq']/g['made']*100:.1f}%)",
    f"{E} ({E/M*100:.1f}%)")
row("run", g["run"], R)
row("killed by the sweep", f"{g['kill']} ({g['kill']/g['run']*100:.1f}%)",
    f"{K} ({K/R*100:.1f}%)")
row("SURVIVORS", f"{surv} ({surv/g['pts']*100:.1f}% of pts)",
    f"{R-K} ({(R-K)/P*100:.1f}% of pts)")
print()
print(f"survivors per point: {surv/g['pts']*100:.1f}% vs {(R-K)/P*100:.1f}% "
      f"-- {((R-K)/P)/(surv/g['pts']):.1f}x more of the emitted population "
      f"needs new tests written for it.")
print()
print("Generator route after this experiment (mutation/effort/RESOLUTION.txt):")
print(f"  killed            {g['kill']} by the sweep + 177 by added drivers = {g['kill']+177}")
print(f"  equivalent        {g['eq']} by TCE + 41 by argument = {g['eq']+41}")
print(f"  detected by abort 3   (real detections; a crash writes no artifact,")
print(f"                         so neither test-2 mechanism returns a verdict)")
print(f"  stage losses      {g['stage']}  (never became runnable mutants)")
print(f"  UNRESOLVED        {g['pts'] - (g['kill']+177) - (g['eq']+41) - 3 - g['stage']}")
print()
print("Cost of clearing the 221 survivors: 11 added driver files were run")
print("against them, 4 of which were written for this experiment. 6 of the 11")
print("killed anything at all; the other 5 met only equivalent mutants.")
print("  159  lens_blur/mutation_test.cpp            pre-existing")
print("    8  interpolate/mutation_test.cpp          NEW")
print("    4  depthwise_separable_conv/mutation_test2.cpp  pre-existing")
print("    3  bgu/mutation_test.cpp                  NEW")
print("    2  iir_blur/mutation_test.cpp             pre-existing")
print("    1  bilateral_grid/mutation_test.cpp       NEW")
print("  = 177 mutants resolved by 6 files, ~30 mutants per file that worked.")
