#!/usr/bin/env python3
"""Job 1: classify every schedule-directive mutation point by write-position.

For each app with schedule-arm data, find its generator source, brace-match
every function/method definition, then for each unique (file,line) mutation
site determine the innermost enclosing function and bucket it:
  - formal-schedule-block: innermost enclosing function is named "schedule"
    (in-class or Class::schedule out-of-line)
  - inline-in-generate: innermost enclosing function is named "generate"
    (in-class or Class::generate out-of-line)
  - other: enclosing function is neither (e.g. a helper called from
    generate(), or top-level / not inside any detected function)
"""
import collections
import json
import sys

sys.path.insert(0, "/tmp/claude-1000/-home-ardi-project-dsl-mutants-halide/79c69961-ec65-41df-a717-1c36536a2c1f/scratchpad")
import classify_enclosing as ce

APPS_DIR = "/home/ardi/project/dsl_mutants/halide/Halide-mutation-wip-c/apps"

SRC = {
    "bgu": "bgu/bgu_generator.cpp",
    "bilateral_grid": "bilateral_grid/bilateral_grid_generator.cpp",
    "blur": "blur/halide_blur_generator.cpp",
    "c_backend": "c_backend/pipeline_generator.cpp",
    "camera_pipe": "camera_pipe/camera_pipe_generator.cpp",
    "conv_layer": "conv_layer/conv_layer_generator.cpp",
    "depthwise_separable_conv": "depthwise_separable_conv/depthwise_separable_conv_generator.cpp",
    "harris": "harris/harris_generator.cpp",
    "hist": "hist/hist_generator.cpp",
    "iir_blur": "iir_blur/iir_blur_generator.cpp",
    "max_filter": "max_filter/max_filter_generator.cpp",
    "nl_means": "nl_means/nl_means_generator.cpp",
    "unsharp": "unsharp/unsharp_generator.cpp",
}


def bucket(name):
    if name is None:
        return "other-toplevel"
    base = name.split("::")[-1]
    if base == "schedule":
        return "formal-schedule-block"
    if base == "generate":
        return "inline-in-generate"
    return "other:" + base


def main():
    census = json.load(open(sys.argv[1]))
    unresolved = set()
    if len(sys.argv) > 2:
        import csv
        for r in csv.DictReader(open(sys.argv[2])):
            unresolved.add((r["app"], r["mutator"], r["file"], r["line"], r["column"]))

    per_site_rows = []
    per_mutant_rows = []
    func_dirs = {}
    for app, rel in SRC.items():
        path = f"{APPS_DIR}/{rel}"
        text = open(path, encoding="utf-8", errors="replace").read()
        funcs, _ = ce.classify_functions(text)
        func_dirs[app] = funcs

    site_bucket_cache = {}
    for app, items in census.items():
        if app not in SRC:
            print("WARNING: no source mapping for", app, file=sys.stderr)
            continue
        funcs = func_dirs[app]
        sites = collections.defaultdict(list)
        for it in items:
            sites[(it["file"], it["line"])].append(it)
        for (fn, line), muts in sites.items():
            key = (app, fn, line)
            if key not in site_bucket_cache:
                stack = ce.enclosing_stack(funcs, line)
                innermost = stack[0][0] if stack else None
                b = bucket(innermost)
                site_bucket_cache[key] = (innermost, b)
            innermost, b = site_bucket_cache[key]
            n_unresolved = sum(
                1 for m in muts
                if (app, m["mutator"], fn, str(line), str(m["col"])) in unresolved
            )
            per_site_rows.append({
                "app": app, "file": fn, "line": line,
                "enclosing_function": innermost, "bucket": b,
                "n_mutants_at_site": len(muts),
                "n_unresolved_at_site": n_unresolved,
            })
            for m in muts:
                per_mutant_rows.append({
                    "app": app, "mutator": m["mutator"], "file": fn, "line": line,
                    "col": m["col"], "enclosing_function": innermost, "bucket": b,
                    "stage2": m["stage2"], "effective": m["effective"],
                    "unresolved": (app, m["mutator"], fn, str(line), str(m["col"])) in unresolved,
                })

    with open("/tmp/claude-1000/-home-ardi-project-dsl-mutants-halide/79c69961-ec65-41df-a717-1c36536a2c1f/scratchpad/schedule_site_classification.json", "w") as f:
        json.dump(per_site_rows, f, indent=1)
    with open("/tmp/claude-1000/-home-ardi-project-dsl-mutants-halide/79c69961-ec65-41df-a717-1c36536a2c1f/scratchpad/schedule_mutant_classification.json", "w") as f:
        json.dump(per_mutant_rows, f, indent=1)

    # Summary: per app, sites and mutants by bucket
    print("=== per-app site counts by bucket ===")
    by_app_bucket = collections.Counter()
    by_app_bucket_mutants = collections.Counter()
    by_app_bucket_unresolved = collections.Counter()
    for r in per_site_rows:
        by_app_bucket[(r["app"], r["bucket"])] += 1
        by_app_bucket_mutants[(r["app"], r["bucket"])] += r["n_mutants_at_site"]
        by_app_bucket_unresolved[(r["app"], r["bucket"])] += r["n_unresolved_at_site"]

    apps = sorted(SRC)
    all_buckets = sorted(set(b for (_, b) in by_app_bucket))
    hdr = f"{'app':<28}" + "".join(f"{b:>26}" for b in all_buckets)
    print(hdr)
    for app in apps:
        row = f"{app:<28}"
        for b in all_buckets:
            n_sites = by_app_bucket.get((app, b), 0)
            n_mut = by_app_bucket_mutants.get((app, b), 0)
            n_unres = by_app_bucket_unresolved.get((app, b), 0)
            row += f"{f'{n_sites}s/{n_mut}m/{n_unres}u':>26}"
        print(row)

    print("\n=== corpus totals ===")
    tot_sites = collections.Counter()
    tot_mut = collections.Counter()
    tot_unres = collections.Counter()
    for (app, b), n in by_app_bucket.items():
        tot_sites[b] += n
    for (app, b), n in by_app_bucket_mutants.items():
        tot_mut[b] += n
    for (app, b), n in by_app_bucket_unresolved.items():
        tot_unres[b] += n
    for b in all_buckets:
        print(f"{b:<26} sites={tot_sites[b]:>4}  mutants={tot_mut[b]:>4}  unresolved={tot_unres[b]:>4}")


if __name__ == "__main__":
    main()
