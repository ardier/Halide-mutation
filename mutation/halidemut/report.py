"""Summary tables over a pipeline run."""

from __future__ import annotations

import collections
from typing import List

from .pipeline import MutantResult


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
    return {
        "total": total,
        "gen_killed": gen_killed,
        "build_err": build_err,
        "harness": harness,
        "runnable": len(runnable),
        "effective": len(effective),
        "equivalent": equivalent,
        "stmt_differs": differs,
        "o1_killed": sum(1 for r in effective if r.o1 == "KILLED"),
        "o2_killed": sum(1 for r in effective if r.o2 == "KILLED"),
        "killed_any": sum(1 for r in effective if r.killed),
    }


def summarise(results: List[MutantResult]) -> str:
    if not results:
        return "no results\n"
    lines = []

    lines.append("=" * 100)
    lines.append("PER APP x ARM")
    lines.append("=" * 100)
    hdr = (f"{'app':<16}{'arm':<12}{'mut':>5}{'genKill':>8}{'bldErr':>7}"
           f"{'equiv':>7}{'eff':>5}{'O1kill':>8}{'O2kill':>8}{'any':>6}"
           f"{'O1%':>7}{'O2%':>7}")
    lines.append(hdr)
    lines.append("-" * 100)
    for (app, arm), rows in sorted(_bucket(results, lambda r: (r.app, r.arm)).items()):
        s = _stats(rows)
        lines.append(
            f"{app:<16}{arm:<12}{s['total']:>5}{s['gen_killed']:>8}{s['build_err']:>7}"
            f"{s['equivalent']:>7}{s['effective']:>5}{s['o1_killed']:>8}"
            f"{s['o2_killed']:>8}{s['killed_any']:>6}"
            f"{_pct(s['o1_killed'], s['effective']):>7}{_pct(s['o2_killed'], s['effective']):>7}")

    lines.append("")
    lines.append("=" * 100)
    lines.append("PER ARM (all apps)")
    lines.append("=" * 100)
    lines.append(hdr.replace("app", "   ", 1))
    lines.append("-" * 100)
    for arm, rows in sorted(_bucket(results, lambda r: r.arm).items()):
        s = _stats(rows)
        lines.append(
            f"{'':<16}{arm:<12}{s['total']:>5}{s['gen_killed']:>8}{s['build_err']:>7}"
            f"{s['equivalent']:>7}{s['effective']:>5}{s['o1_killed']:>8}"
            f"{s['o2_killed']:>8}{s['killed_any']:>6}"
            f"{_pct(s['o1_killed'], s['effective']):>7}{_pct(s['o2_killed'], s['effective']):>7}")

    lines.append("")
    lines.append("=" * 100)
    lines.append("PER OPERATOR")
    lines.append("=" * 100)
    lines.append(f"{'mutator':<34}{'arm':<12}{'mut':>5}{'genKill':>8}{'equiv':>7}"
                 f"{'eff':>5}{'O1kill':>8}{'O2kill':>8}{'O2%':>8}")
    lines.append("-" * 100)
    for (arm, mut), rows in sorted(
            _bucket(results, lambda r: (r.arm, r.mutant.mutator)).items()):
        s = _stats(rows)
        lines.append(
            f"{mut:<34}{arm:<12}{s['total']:>5}{s['gen_killed']:>8}{s['equivalent']:>7}"
            f"{s['effective']:>5}{s['o1_killed']:>8}{s['o2_killed']:>8}"
            f"{_pct(s['o2_killed'], s['effective']):>8}")

    # Anything that did not reach a verdict is worth seeing explicitly.
    odd = [r for r in results
           if r.stage2 not in ("OK",) or r.stage3 != "OK"]
    if odd:
        lines.append("")
        lines.append("=" * 100)
        lines.append("NON-STANDARD OUTCOMES")
        lines.append("=" * 100)
        for r in sorted(odd, key=lambda r: (r.app, r.arm, r.mutant.mutator)):
            lines.append(f"  {r.app:<16}{r.arm:<11}{r.mutant.mutator:<32}"
                         f"{r.mutant.location:<30}{r.stage2}/{r.stage3}  {r.note}")

    lines.append("")
    lines.append("genKill = rejected by the Halide compiler (a kill only staged "
                 "compilation produces)")
    lines.append("equiv   = emitted .stmt byte-identical to baseline, so "
                 "unkillable at this target")
    lines.append("eff     = effective mutants; O1%/O2% are over these")

    return "\n".join(lines) + "\n"
