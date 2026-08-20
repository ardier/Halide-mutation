"""Re-summarise one or more result CSVs.

    python3 -m halidemut.summarize results-main.csv results-camera.csv

Useful for merging runs that were executed separately -- a memory-heavy app is
often run on its own rather than blocking the batch.
"""

from __future__ import annotations

import csv
import sys
from pathlib import Path
from typing import List

from .pipeline import Mutant, MutantResult
from .report import summarise


def load(paths: List[Path]) -> List[MutantResult]:
    results = []
    for p in paths:
        with Path(p).open(newline="") as fh:
            for row in csv.DictReader(fh):
                m = Mutant(
                    key="", mutator=row["mutator"], path=row["file"],
                    line=int(row["line"]), column=int(row["column"]),
                )
                r = MutantResult(row["app"], row["arm"], m)
                r.stage2 = row["stage2"]
                r.stage3 = row["stage3"]
                r.stmt_differs = (row["stmt_differs"] == "1") if row["stmt_differs"] else None
                r.o1 = row["o1"]
                r.o2 = row["o2"]
                r.exit_code = int(row["exit_code"]) if row["exit_code"] else None
                r.wall_seconds = float(row["wall_seconds"] or 0.0)
                r.note = row.get("note", "")
                results.append(r)
    return results


def main(argv=None) -> int:
    argv = argv if argv is not None else sys.argv[1:]
    if not argv:
        print(__doc__.strip(), file=sys.stderr)
        return 2
    print(summarise(load([Path(a) for a in argv])))
    return 0


if __name__ == "__main__":
    sys.exit(main())
