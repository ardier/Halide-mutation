#!/usr/bin/env python3
"""Cross-reference HalideReplacement's mutate()-bailout diagnostics (from
run_stage1_diag.py's captured stderr logs) against the corpus resolution
table's per-mutant classification (resolution_table.py / results-full-sweep
CSVs), for the target benchmarks.

For every mutant resolution_table.py currently classifies as "equivalent",
this determines whether that classification is because mutate() actually ran
and produced no observable change (a real equivalent mutant) or because
mutate() bailed out on one of its four guard paths before ever touching the
IR (the defect under investigation: Mull embedded and reported a mutation
point it never applied).
"""
import collections
import glob
import os
import re
import sys

HERE = "/mnt/scratch1/ardi/dsl_mut/HM-arith/mutation/experiment2"
DIAG = os.path.join(HERE, "diag")
sys.path.insert(0, HERE)
import resolution_table as rt  # noqa: E402

TARGETS = {"blur", "bilateral_grid", "harris", "camera_pipe", "unsharp"}
IR_ARMS = {"arithmetic", "schedule", "generated"}

# irm:: RTTI class name -> mull-ps mutator ID, for the 12 legacy arithmetic
# classes and the 2 compute_at/store_at ones, whose class names don't already
# match the lowercase-underscore CSV convention. Everything else (schedule
# directive swaps, and every X-macro-generated relational/bitwise/compound
# operator) already matches after stripping the "irm::" prefix.
IRREGULAR = {
    "Halide_AddToMul": "Halide_add_to_mul",
    "Halide_AddToSub": "Halide_add_to_sub",
    "Halide_AddToDiv": "Halide_add_to_div",
    "Halide_SubToMul": "Halide_sub_to_mul",
    "Halide_SubToAdd": "Halide_sub_to_add",
    "Halide_SubToDiv": "Halide_sub_to_div",
    "Halide_MulToAdd": "Halide_mul_to_add",
    "Halide_MulToSub": "Halide_mul_to_sub",
    "Halide_MulToDiv": "Halide_mul_to_div",
    "Halide_DivToMul": "Halide_div_to_mul",
    "Halide_DivToAdd": "Halide_div_to_add",
    "Halide_DivToSub": "Halide_div_to_sub",
}

LOG_RE = re.compile(
    r"^\[HalideReplacement\] (\S+) at (.+):(\d+):(\d+): (\S+)$")


def normalize_label(raw):
    cls = raw.split("::")[-1]
    return IRREGULAR.get(cls, cls)


def load_diag():
    """(app, arm) -> {(mutator, basename, line, col): outcome}"""
    out = {}
    for path in glob.glob(os.path.join(DIAG, "*.stderr.log")):
        base = os.path.basename(path)[: -len(".stderr.log")]
        app, arm = base.split("__", 1)
        points = {}
        with open(path) as fh:
            for line in fh:
                m = LOG_RE.match(line.rstrip("\n"))
                if not m:
                    continue
                raw_label, file_, ln, col, outcome = m.groups()
                mutator = normalize_label(raw_label)
                key = (mutator, os.path.basename(file_), ln, col)
                # A given (mutator, file, line, col) can recur across
                # multiple mutant clones only if Mull ever created more than
                # one point at the identical address for the identical
                # mutator, which does not happen; still, keep the first.
                points.setdefault(key, outcome)
        out[(app, arm)] = points
    return out


def main():
    diag = load_diag()
    rows, killed = rt.load()

    # counts[app][arm][outcome] where outcome in
    # {matched_applied, matched_skip:<reason>, no_diag}
    detail = collections.defaultdict(list)
    agg = collections.Counter()
    agg_by_reason = collections.Counter()

    for k, r in rows.items():
        app, arm, mutator, file_, line, col = k
        if app not in TARGETS or arm not in IR_ARMS:
            continue
        cls = rt.classify(k, r, killed)
        if cls != "equivalent":
            continue
        pts = diag.get((app, arm), {})
        dkey = (mutator, os.path.basename(file_), line, col)
        outcome = pts.get(dkey)
        if outcome is None:
            agg["no_diag_found"] += 1
            tag = "no_diag_found"
        elif outcome == "applied":
            agg["genuinely_equivalent"] += 1
            tag = "genuinely_equivalent"
        else:
            agg["never_applied"] += 1
            agg_by_reason[outcome] += 1
            tag = f"never_applied:{outcome}"
        detail[(app, arm)].append((mutator, file_, line, col, tag))

    print("=" * 100)
    print("Equivalent-classified IR-route mutants: genuinely equivalent vs never-applied")
    print("=" * 100)
    hdr = f"{'app':<18}{'arm':<12}{'equiv(total)':>13}{'genuine_equiv':>15}{'never_applied':>15}{'no_diag':>9}"
    print(hdr)
    print("-" * len(hdr))
    for app in sorted(TARGETS):
        for arm in sorted(IR_ARMS):
            rows_here = detail.get((app, arm), [])
            if not rows_here:
                continue
            total = len(rows_here)
            genuine = sum(1 for t in rows_here if t[4] == "genuinely_equivalent")
            never = sum(1 for t in rows_here if t[4].startswith("never_applied"))
            nodiag = sum(1 for t in rows_here if t[4] == "no_diag_found")
            print(f"{app:<18}{arm:<12}{total:>13}{genuine:>15}{never:>15}{nodiag:>9}")
    print("-" * len(hdr))
    total = sum(len(v) for v in detail.values())
    genuine = agg["genuinely_equivalent"]
    never = agg["never_applied"]
    nodiag = agg["no_diag_found"]
    print(f"{'TOTAL':<18}{'':<12}{total:>13}{genuine:>15}{never:>15}{nodiag:>9}")

    print()
    print("never-applied, by bail-out reason:")
    for reason, n in agg_by_reason.most_common():
        print(f"    {reason:<32}{n}")

    print()
    print("Detail (app, arm, mutator, file, line, col, disposition):")
    for (app, arm), items in sorted(detail.items()):
        for mutator, file_, line, col, tag in items:
            print(f"  {app:<16}{arm:<11}{mutator:<38}{os.path.basename(file_)}:{line}:{col:<5} {tag}")


if __name__ == "__main__":
    main()
