"""Summary tables over a pipeline run.

One resolution figure plus a per-kind breakdown. The kinds are:

  test 1  demo program      the shipped driver's own verdict (exit code, crash,
                            abort, timeout). Zero effort, ships with the app.
  test 2  additional tests  oracles we added, in two sub-tiers kept apart:
                              golden  = snapshot the baseline output, byte-diff
                              written = hand-authored assertion drivers
  test 3  performance       median wall time against a threshold from that
                            app's own baseline noise.

The two test-2 sub-tiers are never pooled: the difference between snapshotting
an output and writing an assertion driver is the test-writing effort the
breakdown exists to measure, and one number would hide it.

RESOLVED = killed by at least one kind, or proven equivalent. Equivalence is a
positive result, not a shortfall.
"""

from __future__ import annotations

import collections
from typing import List

from .pipeline import TEST_KINDS, MutantResult

# Short column labels, in report order.
KIND_LABEL = {
    "test1_demo": "t1demo",
    "test2_golden": "t2gold",
    "test2_written": "t2writ",
    "test3_perf": "t3perf",
}


def _pct(num: int, den: int) -> str:
    return "  n/a" if den == 0 else f"{100.0 * num / den:5.1f}%"


def _bucket(results: List[MutantResult], key):
    out = collections.defaultdict(list)
    for r in results:
        out[key(r)].append(r)
    return out


def _stats(rows: List[MutantResult]) -> dict:
    total = len(rows)
    gen_killed = sum(1 for r in rows if r.stage2 in ("GEN_ERROR", "GEN_TIMEOUT"))
    build_err = sum(1 for r in rows if r.stage3 == "BUILD_ERROR")
    harness = sum(1 for r in rows if r.stage2 == "HARNESS_ERROR")
    runnable = [r for r in rows if r.stage2 == "OK" and r.stage3 == "OK"]
    effective = [r for r in runnable if r.effective]
    equivalent = len(runnable) - len(effective)
    differs = sum(1 for r in rows if r.stmt_differs)
    killed_any = sum(1 for r in effective if r.killed)
    s = {
        "total": total,
        "gen_killed": gen_killed,
        "build_err": build_err,
        "harness": harness,
        "runnable": len(runnable),
        "effective": len(effective),
        "equivalent": equivalent,
        "stmt_differs": differs,
        "killed_any": killed_any,
        # Equivalent mutants are resolved without being killed, so the
        # denominator for resolution is effective + equivalent, not effective.
        "resolved": killed_any + equivalent,
        "resolvable": len(effective) + equivalent,
    }
    for k in TEST_KINDS:
        s[k] = sum(1 for r in effective if getattr(r, k) == "KILLED")
        # "killed by X" and "X alone sufficed" are different questions.
        s[k + "_only"] = sum(1 for r in effective if r.killed_by == [k])
    return s


_KIND_HDR = "".join(f"{KIND_LABEL[k]:>8}" for k in TEST_KINDS)
_KIND_ONLY_HDR = "".join(f"{KIND_LABEL[k] + '!':>8}" for k in TEST_KINDS)


def _kind_cells(s: dict) -> str:
    return "".join(f"{s[k]:>8}" for k in TEST_KINDS)


def _kind_only_cells(s: dict) -> str:
    return "".join(f"{s[k + '_only']:>8}" for k in TEST_KINDS)


def summarise(results: List[MutantResult]) -> str:
    if not results:
        return "no results\n"
    lines = []
    width = 124

    lines.append("=" * width)
    lines.append("PER APP x ARM")
    lines.append("=" * width)
    hdr = (f"{'app':<16}{'arm':<12}{'mut':>5}{'genKill':>8}{'bldErr':>7}"
           f"{'equiv':>7}{'eff':>5}" + _KIND_HDR + f"{'any':>6}{'resolvd':>9}")
    lines.append(hdr)
    lines.append("-" * width)
    for (app, arm), rows in sorted(_bucket(results, lambda r: (r.app, r.arm)).items()):
        s = _stats(rows)
        lines.append(
            f"{app:<16}{arm:<12}{s['total']:>5}{s['gen_killed']:>8}"
            f"{s['build_err']:>7}{s['equivalent']:>7}{s['effective']:>5}"
            + _kind_cells(s) + f"{s['killed_any']:>6}"
            + f"{_pct(s['resolved'], s['resolvable']):>9}")

    lines.append("")
    lines.append("=" * width)
    lines.append("PER ARM (all apps)")
    lines.append("=" * width)
    lines.append(hdr.replace("app", "   ", 1))
    lines.append("-" * width)
    for arm, rows in sorted(_bucket(results, lambda r: r.arm).items()):
        s = _stats(rows)
        lines.append(
            f"{'':<16}{arm:<12}{s['total']:>5}{s['gen_killed']:>8}"
            f"{s['build_err']:>7}{s['equivalent']:>7}{s['effective']:>5}"
            + _kind_cells(s) + f"{s['killed_any']:>6}"
            + f"{_pct(s['resolved'], s['resolvable']):>9}")

    lines.append("")
    lines.append("=" * width)
    lines.append("SOLE SUFFICIENT KIND (mutants this kind and no other killed)")
    lines.append("=" * width)
    lines.append(f"{'':<16}{'arm':<12}{'eff':>5}" + _KIND_ONLY_HDR
                 + f"{'any':>6}")
    lines.append("-" * width)
    for arm, rows in sorted(_bucket(results, lambda r: r.arm).items()):
        s = _stats(rows)
        lines.append(f"{'':<16}{arm:<12}{s['effective']:>5}"
                     + _kind_only_cells(s) + f"{s['killed_any']:>6}")

    lines.append("")
    lines.append("=" * width)
    lines.append("PER OPERATOR")
    lines.append("=" * width)
    lines.append(f"{'mutator':<34}{'arm':<12}{'mut':>5}{'genKill':>8}"
                 f"{'equiv':>7}{'eff':>5}" + _KIND_HDR + f"{'any':>6}")
    lines.append("-" * width)
    for (arm, mut), rows in sorted(
            _bucket(results, lambda r: (r.arm, r.mutant.mutator)).items()):
        s = _stats(rows)
        lines.append(
            f"{mut:<34}{arm:<12}{s['total']:>5}{s['gen_killed']:>8}"
            f"{s['equivalent']:>7}{s['effective']:>5}"
            + _kind_cells(s) + f"{s['killed_any']:>6}")

    # Anything that did not reach a verdict is worth seeing explicitly.
    odd = [r for r in results
           if r.stage2 not in ("OK",) or r.stage3 != "OK"]
    if odd:
        lines.append("")
        lines.append("=" * width)
        lines.append("NON-STANDARD OUTCOMES")
        lines.append("=" * width)
        for r in sorted(odd, key=lambda r: (r.app, r.arm, r.mutant.mutator)):
            lines.append(f"  {r.app:<16}{r.arm:<11}{r.mutant.mutator:<32}"
                         f"{r.mutant.location:<30}{r.stage2}/{r.stage3}  {r.note}")

    lines.append("")
    lines.append("genKill = rejected by the Halide compiler (a kill only staged "
                 "compilation produces)")
    lines.append("equiv   = emitted .stmt byte-identical to baseline, so "
                 "unkillable at this target -- proven equivalent, RESOLVED")
    lines.append("eff     = effective mutants; the per-kind counts are over "
                 "these")
    lines.append("t1demo  = test 1, the shipped driver's own verdict")
    lines.append("t2gold  = test 2 (golden), baseline output snapshot byte-diff")
    lines.append("t2writ  = test 2 (written), hand-authored assertion driver")
    lines.append("t3perf  = test 3, median wall time vs the app's baseline noise")
    lines.append("any     = union of the kinds; a mutant may be killed by "
                 "several")
    lines.append("kind!   = that kind alone sufficed; no other kind killed it")
    lines.append("resolvd = (killed by any kind + proven equivalent) / "
                 "(eff + equiv)")

    return "\n".join(lines) + "\n"
