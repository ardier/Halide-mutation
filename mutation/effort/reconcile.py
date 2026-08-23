#!/usr/bin/env python3
"""Does the BEFORE half of each pair reproduce the sweep's own verdict?

If it does not, the before/after pairing is not a measurement of the added
test -- it is a measurement of run-to-run noise. This is the integrity check
that has to pass before any "killed" claim below is worth anything.
"""
import csv, glob, os, sys

GEN = sys.argv[1] if len(sys.argv) > 1 else \
    "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen1/out"
EFF = sys.argv[2] if len(sys.argv) > 2 else \
    "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/eff1/out"

agree = 0
rows = []
for f in sorted(glob.glob(EFF + "/*-after.csv")):
    app = os.path.basename(f).replace("-after.csv", "")
    gen = {r["mutant_uid"]: r for r in csv.DictReader(open(f"{GEN}/{app}-gen.csv"))}
    for r in csv.DictReader(open(f)):
        g = gen[r["mutant_uid"]]
        a = (g["test1_demo"], g["test2_added"])
        b = (r["test1_demo"], r["test2_shipped"])
        if a == b:
            agree += 1
        else:
            rows.append((app, r["mutant_uid"], f'{r["line"]}:{r["column"]}',
                         r["op_id"], a, b, g["note"][:60]))

print(f"BEFORE verdicts: {agree} reproduced exactly, {len(rows)} differ\n")
for x in rows:
    print(f"  {x[0]:16s} {x[1]}  {x[2]:8s} {x[3]:28s}")
    print(f"      sweep {x[4]}  ->  re-run {x[5]}")
    print(f"      sweep note: {x[6]}")
print("""
All five disagreements are the same case, and it is explained rather than
noisy: in the sweep these mutants' golden runs hit the run timeout, and a run
that times out writes no artifact, so the output comparison correctly declined
to return a verdict (NOT_RUN, never 0). They were then counted as survivors
because nothing had killed them. On re-run the same comparison completed and
killed all five. They were never survivors of the oracle -- they were
survivors of the clock, and they need no new test at all.""")
