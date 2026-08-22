#!/usr/bin/env python3
"""Per-app status block for an incremental commit message.

States each app as COMPLETE or PARTIAL with "N of M evaluated", so a commit
made at 3am is self-describing: whoever reads the log can tell at a glance
which CSVs are finished and which are a snapshot of a run still in flight,
without having to go and look at /mnt/scratch1 to find out.

M is read from the run log, where the identified count was recorded at emit
time before any mutant was evaluated. Taking it from the CSV would report the
rows that happen to exist as though they were the whole population.
"""

import csv
import glob
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import report as R  # noqa: E402


def main():
    lines, tot = [], dict(ident=0, ev=0, killed=0, equiv=0, run=0)
    any_partial = False
    for d, pat, tk in ((R.GEN1, "*-gen.csv", "generator"),
                       (R.GEN2, "*-emitted.csv", "emitted C++")):
        for f in sorted(glob.glob(os.path.join(d, pat))):
            app = os.path.basename(f).rsplit("-", 1)[0]
            rows = [R.normalise(r) for r in R.load(f)]
            if not rows:
                continue
            done, pts = R.log_facts(f)
            n = len(rows)
            pts = pts if pts is not None else n
            killed = sum(1 for r in rows
                         if any(r[k] == "KILLED" for k in R.KINDS))
            equiv = sum(1 for r in rows if r["equivalent"])
            ran = sum(1 for r in rows if any(
                r[k] in ("KILLED", "SURVIVED") for k in R.KINDS))
            state = "COMPLETE" if done else "PARTIAL "
            if not done:
                any_partial = True
            lines.append(
                f"  {app:24s} {tk:11s} {state}  {n} of {pts} evaluated, "
                f"{ran} run, {killed} killed, {equiv} equivalent")
            tot["ident"] += pts
            tot["ev"] += n
            tot["killed"] += killed
            tot["equiv"] += equiv
            tot["run"] += ran

    out = []
    out.append("Per app (M = points identified at emit time, from the run log,")
    out.append("not from the rows written, so a PARTIAL is reported as partial")
    out.append("rather than as a smaller complete run):")
    out.append("")
    out.extend(lines)
    out.append("")
    out.append(f"  TOTAL  {tot['ev']} of {tot['ident']} points evaluated, "
               f"{tot['run']} run, {tot['killed']} killed, "
               f"{tot['equiv']} proven equivalent")
    if any_partial:
        out.append("")
        out.append("Rows are streamed one per mutant and flushed, so every")
        out.append("PARTIAL file above is valid as far as it goes.")
    print("\n".join(out))


if __name__ == "__main__":
    main()
