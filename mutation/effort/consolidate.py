#!/usr/bin/env python3
"""Consolidate the before/after runs into one resolution table.

One row per app. Every number here comes from a CSV written by
effort_harness.py, in which each mutant was run twice -- shipped driver and
added driver -- against the same mutant artifacts.
"""
import csv, glob, os, sys, collections

P = "/mnt/scratch1/ardi/dsl_mut/.priv-79c69961/eff1"
OUT = P + "/out"

# app -> ordered list of (added driver, csv tag). Later runs only see the
# mutants the earlier ones failed to kill, so a kill is attributed to the
# first driver that achieved it.
RUNS = {
    "lens_blur":                [("apps/lens_blur/mutation_test.cpp", "after"),
                                 ("apps/lens_blur/mutation_test2.cpp", "after2")],
    "camera_pipe":              [("apps/camera_pipe/mutation_test.cpp", "after")],
    "depthwise_separable_conv": [("apps/depthwise_separable_conv/mutation_test.cpp", "after"),
                                 ("apps/depthwise_separable_conv/mutation_test2.cpp", "after2")],
    "max_filter":               [("apps/max_filter/mutation_test.cpp", "after")],
    "iir_blur":                 [("apps/iir_blur/mutation_test.cpp", "after")],
    "interpolate":              [("apps/interpolate/mutation_test.cpp", "after")],
    "bgu":                      [("apps/bgu/mutation_test.cpp", "after")],
    "bilateral_grid":           [("apps/bilateral_grid/mutation_test.cpp", "after")],
    "local_laplacian":          [("apps/local_laplacian/mutation_test.cpp", "after")],
}

# Added drivers written for THIS experiment, as opposed to restored from
# earlier commits. The distinction matters: the headline effort number is
# tests written per mutant resolved, and a test someone already wrote is
# effort already spent, not effort saved.
NEW_HERE = {
    "apps/interpolate/mutation_test.cpp",
    "apps/bgu/mutation_test.cpp",
    "apps/bilateral_grid/mutation_test.cpp",
    "apps/local_laplacian/mutation_test.cpp",
}

rows = []
per_driver = collections.Counter()
tot = collections.Counter()
detail = {}

for app, runs in sorted(RUNS.items()):
    killed_by_driver = {}
    shipped_kill = set()
    crash = {}
    seen = set()
    remaining = None
    for drv, tag in runs:
        path = f"{OUT}/{app}-{tag}.csv"
        if not os.path.exists(path):
            continue
        rs = list(csv.DictReader(open(path)))
        # Sorted by SOURCE POSITION, never completion order.
        rs.sort(key=lambda r: (int(r["line"]), int(r["column"]), r["op_id"]))
        for r in rs:
            uid = r["mutant_uid"]
            seen.add(uid)
            if r["test2_shipped"] == "KILLED":
                shipped_kill.add(uid)
            if r["test2_added"] == "KILLED" and uid not in killed_by_driver:
                killed_by_driver[uid] = (drv, r["test2_method"])
            if str(r["after_exit"]).startswith("-"):
                crash[uid] = r["after_exit"]
        remaining = [r for r in rs if r["mutant_uid"] not in killed_by_driver]

    for uid, (drv, _m) in killed_by_driver.items():
        per_driver[drv] += 1

    n = len(seen)
    k = len(killed_by_driver)
    rows.append(dict(
        app=app, survivors=n, killed=k, remaining=n - k,
        also_killed_by_shipped=len(shipped_kill),
        crash_detected=len([u for u in crash if u not in killed_by_driver]),
        drivers=" + ".join(d.split("/")[-1] for d, _ in runs),
        new_here=sum(1 for d, _ in runs if d in NEW_HERE),
    ))
    detail[app] = remaining
    tot["survivors"] += n
    tot["killed"] += k
    tot["remaining"] += n - k
    tot["shipped"] += len(shipped_kill)
    tot["crash"] += len([u for u in crash if u not in killed_by_driver])

w = csv.DictWriter(sys.stdout, fieldnames=list(rows[0]), lineterminator="\n")
w.writeheader()
for r in sorted(rows, key=lambda r: -r["survivors"]):
    w.writerow(r)
print()
print(f"TOTAL survivors targeted   {tot['survivors']}")
print(f"      killed by added test {tot['killed']}")
print(f"      still surviving      {tot['remaining']}")
print(f"        of which detected by a runtime abort (not a comparison kill) {tot['crash']}")
print(f"      also killed by the SHIPPED driver's own oracle on re-run       {tot['shipped']}")
print()
print("kills attributed to each added driver (first driver that killed it):")
for d, c in per_driver.most_common():
    tagname = "NEW" if d in NEW_HERE else "pre-existing"
    print(f"  {c:4d}  {d}   [{tagname}]")
files_used = sorted({d for runs in RUNS.values() for d, _ in runs})
print(f"\ntest files used: {len(files_used)}  "
      f"({len([f for f in files_used if f in NEW_HERE])} written here, "
      f"{len([f for f in files_used if f not in NEW_HERE])} pre-existing)")
print(f"test files that killed at least one mutant: {len(per_driver)}")

print("\n=== still surviving, by app and source position ===")
for app in sorted(detail):
    rs = detail[app] or []
    if not rs:
        continue
    print(f"\n{app} ({len(rs)}):")
    for r in rs:
        note = ""
        if str(r["after_exit"]).startswith("-"):
            note = f"   [added test died on signal {str(r['after_exit'])[1:]}]"
        print(f"  {r['mutant_uid']}  {r['op_id']:30s} {r['line']:>4}:{r['column']:<4} "
              f"{r['target']}{note}")
