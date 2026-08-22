#!/usr/bin/env python3
"""Reconcile the GENERATION-STAGE verdict against the object-code truth.

The generator-route points already carried verdicts before this work started:
EFFECTIVE / EQUIVALENT / GEN_FAIL, produced by diffing the emitted .stmt text.
No driver was ever linked and no test ever ran, so those verdicts were never
checked against anything. This checks them.

The two signals are recorded per mutant and can disagree in both directions:

  stmt_differs = 1   the emitted .stmt text changed -- the generation-stage
                     sweep called this EFFECTIVE
  tce_lib == base    the emitted static library is bit-identical machine code
                     -- no test can distinguish it from baseline, ever

A mutant with stmt_differs=1 AND tce_lib==base is a mutant the old sweep
counted as EFFECTIVE and that is in fact PROVABLY EQUIVALENT. Every such
mutant is one the old numbers would have put in the denominator of a kill
rate it could never appear in the numerator of.

.stmt is a pretty-printed intermediate. Two different printings can lower to
the same instructions -- Halide's `select` and `Internal::Call::if_then_else`
being the clearest case, since absent side effects they are the same
operation and the simplifier normalises them. So .stmt differing is evidence
the mutation reached the IR, not evidence it changed the program.
"""

import csv
import glob
import os
from collections import Counter, defaultdict

GEN1 = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen1/out"
FIELDS = ["app", "op_id", "file", "line", "column", "target",
          "stmt_differs", "tce_lib", "generation_stage_verdict",
          "object_code_verdict", "disagrees"]


def main():
    out_rows = []
    per_op = defaultdict(lambda: Counter())
    for f in sorted(glob.glob(os.path.join(GEN1, "*-gen.csv"))):
        app = os.path.basename(f).rsplit("-", 1)[0]
        for r in csv.DictReader(open(f)):
            # Only mutants that actually produced a pipeline have both signals.
            if (r.get("stage_generate") or "") != "OK":
                continue
            sd = (r.get("stmt_differs") or "").strip()
            if sd == "":
                continue
            equiv = (r.get("equivalent") or "").strip() == "tce_lib"
            gen_verdict = "EFFECTIVE" if sd == "1" else "EQUIVALENT"
            obj_verdict = "EQUIVALENT" if equiv else "EFFECTIVE"
            dis = int(gen_verdict != obj_verdict)
            per_op[r["op_id"]][(gen_verdict, obj_verdict)] += 1
            if dis:
                out_rows.append({
                    "app": app, "op_id": r["op_id"], "file": r["file"],
                    "line": r["line"], "column": r["column"],
                    "target": r["target"], "stmt_differs": sd,
                    "tce_lib": r["tce_lib"],
                    "generation_stage_verdict": gen_verdict,
                    "object_code_verdict": obj_verdict, "disagrees": 1})

    out = os.path.join(GEN1, "VERDICT_RECONCILIATION.csv")
    with open(out, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=FIELDS, lineterminator="\n")
        w.writeheader()
        for r in out_rows:
            w.writerow(r)

    tot = Counter()
    for op, c in per_op.items():
        for k, v in c.items():
            tot[k] += v
    n = sum(tot.values())
    print(f"generator mutants with both signals: {n}")
    print(f"  .stmt differs AND object differs   {tot[('EFFECTIVE','EFFECTIVE')]}"
          "   (agree: really effective)")
    print(f"  .stmt same   AND object same       {tot[('EQUIVALENT','EQUIVALENT')]}"
          "   (agree: really equivalent)")
    print(f"  .stmt differs BUT object identical {tot[('EFFECTIVE','EQUIVALENT')]}"
          "   <-- generation stage called these EFFECTIVE; they are PROVABLY EQUIVALENT")
    print(f"  .stmt same   BUT object differs    {tot[('EQUIVALENT','EFFECTIVE')]}"
          "   <-- generation stage called these EQUIVALENT; they are not")
    if n:
        d = tot[('EFFECTIVE', 'EQUIVALENT')] + tot[('EQUIVALENT', 'EFFECTIVE')]
        print(f"  disagreement rate {100.0*d/n:.1f}%")
    print()
    print("by operator (only rows where they disagree):")
    for op in sorted(per_op):
        c = per_op[op]
        d = c[('EFFECTIVE', 'EQUIVALENT')] + c[('EQUIVALENT', 'EFFECTIVE')]
        if d:
            print(f"  {op:32s} {d} of {sum(c.values())}")


if __name__ == "__main__":
    main()
