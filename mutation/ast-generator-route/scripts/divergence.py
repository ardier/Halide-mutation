#!/usr/bin/env python3
"""Record mutants that made the Halide COMPILER ITSELF fail to produce a
pipeline, as their own stage outcome.

This is a kill category the emitted-C++ route cannot produce by construction.
By the time you are mutating emitted C++ there is no compiler stage left to
break: the pipeline has already been generated, and the mutation can only
affect the scalar code that clang then compiles. Mutating the GENERATOR puts
the mutation upstream of Halide's own lowering, bounds inference and
scheduling, so a mutant can make the compiler diverge rather than make the
program wrong.

First observed on stencil_chain: 4 of 12 generator mutants ran past the 900 s
generate timeout, and all four are the same two rewrites -- operator+ ->
operator* and operator+ -> operator/ -- at the same stencil accumulation
(line 27, columns 64 and 71). Turning the accumulation of a stencil chain
into a product or a quotient changes what bounds inference has to solve, and
the compiler stops terminating in reasonable time.

These are NOT scored as test kills. The mutant never became a runnable
pipeline, so no test ever ran on it; folding it into a timeout column would
conflate "the program hung" with "the compiler hung", which are different
findings. It is recorded here as a distinct stage outcome so it cannot be
lost in the summary.
"""

import csv
import glob
import os

GEN1 = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/gen1/out"
FIELDS = ["app", "op_id", "file", "line", "column", "target",
          "stage_compile", "stage_genlink", "stage_generate", "note"]


def main():
    rows = []
    for f in sorted(glob.glob(os.path.join(GEN1, "*-gen.csv"))):
        app = os.path.basename(f).rsplit("-", 1)[0]
        for r in csv.DictReader(open(f)):
            sg = (r.get("stage_generate") or "").strip()
            gl = (r.get("stage_genlink") or "").strip()
            # Only the stages where the mutated generator itself was the thing
            # that failed. A mutant the compiler REJECTED at parse time is a
            # different and much less interesting outcome, and is excluded.
            if sg and sg != "OK":
                rows.append({k: r.get(k, "") for k in FIELDS} | {"app": app})
            elif gl and gl != "OK":
                rows.append({k: r.get(k, "") for k in FIELDS} | {"app": app})

    out = os.path.join(GEN1, "COMPILER_DIVERGENCE.csv")
    with open(out, "w", newline="") as fh:
        w = csv.DictWriter(fh, fieldnames=FIELDS, lineterminator="\n")
        w.writeheader()
        for r in rows:
            w.writerow(r)

    by_app = {}
    by_kind = {}
    for r in rows:
        by_app.setdefault(r["app"], []).append(r)
        k = r["stage_generate"] if r["stage_generate"] not in ("", "OK") \
            else r["stage_genlink"]
        by_kind[k] = by_kind.get(k, 0) + 1
    print(f"generator-stage failures: {len(rows)}")
    for k, v in sorted(by_kind.items()):
        print(f"  {k:16s} {v}")
    for a, rs in sorted(by_app.items()):
        tgt = sorted({r["target"] for r in rs})
        loc = sorted({f'{r["line"]}:{r["column"]}' for r in rs})
        print(f"  {a}: {len(rs)}  at {','.join(loc)}  -> {'; '.join(tgt)}")
    return len(rows)


if __name__ == "__main__":
    main()
