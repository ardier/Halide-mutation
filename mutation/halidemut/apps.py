"""Per-benchmark configuration for the mutation pipeline.

Each entry describes how to build one Halide app's generator, what to generate
from it, and how to drive the resulting pipeline so a mutant's effect is
observable.

A note on the ``_auto_schedule`` variants. Most apps' drivers link two copies of
the pipeline -- the manually scheduled one and a Mullapudi2016-autoscheduled one
-- benchmark both, and then save the output of the *autoscheduled* run. That is
unusable as a mutation oracle: every generator guards its manual schedule with
``if (!using_autoscheduler())``, so a schedule-directive mutant changes only the
manual variant while the saved image comes from the auto variant, and every such
mutant would be scored as surviving no matter what it did.

So the second variant is generated from the same source *without* passing
``autoscheduler=``. It is then simply the manual schedule under a second symbol
name, the app's own driver links and runs unmodified, and the artifact it saves
reflects the mutation. This also removes the autoscheduler from the inner loop,
which matters: it dominates generation time.
"""

from dataclasses import dataclass, field
from typing import List, Optional


@dataclass(frozen=True)
class AppConfig:
    name: str
    generator_source: str
    """Path to the generator TU, relative to the Halide source root."""

    generator_name: str
    """Argument to the generator binary's -g flag."""

    driver_source: str
    """The app's own test/demo driver, relative to the Halide source root."""

    function_name: str
    """Argument to -f; also the emitted header/function name."""

    driver_args: List[str] = field(default_factory=list)
    """Driver argv. ``{input}`` and ``{output}`` are substituted at run time."""

    needs_auto_variant: bool = True
    """Whether the driver links a second ``<function_name>_auto_schedule`` copy."""

    needs_runtime: bool = True
    """Whether a separate runtime.a must be generated and linked."""

    input_image: Optional[str] = None
    """Input file relative to the Halide source root."""

    output_artifact: Optional[str] = None
    """Filename the driver writes; compared byte-wise by the O2 oracle. When
    None the O2 oracle falls back to the driver's normalised stdout."""

    extra_driver_outputs: List[str] = field(default_factory=list)
    """Additional files the driver writes that are not the oracle artifact."""

    needs_image_io: bool = True
    """Link libpng/libjpeg for halide_image_io.h."""

    run_timeout: int = 300
    generate_timeout: int = 600

    memory_heavy: bool = False
    """Run this app's mutants serially rather than in the shared pool."""


APPS = {
    # Self-checking: generates random input and compares the Halide pipeline
    # against two reference C++ implementations. The only app of the five whose
    # shipped test is a real correctness oracle rather than a demo -- though it
    # skips a 64-pixel border.
    "blur": AppConfig(
        name="blur",
        generator_source="apps/blur/halide_blur_generator.cpp",
        generator_name="halide_blur",
        function_name="halide_blur",
        driver_source="apps/blur/test.cpp",
        driver_args=[],
        needs_auto_variant=False,
        needs_runtime=False,
        input_image=None,
        output_artifact=None,
        needs_image_io=False,
    ),
    "bilateral_grid": AppConfig(
        name="bilateral_grid",
        generator_source="apps/bilateral_grid/bilateral_grid_generator.cpp",
        generator_name="bilateral_grid",
        function_name="bilateral_grid",
        driver_source="apps/bilateral_grid/filter.cpp",
        driver_args=["{input}", "{output}", "0.1", "10"],
        input_image="apps/images/gray.png",
        output_artifact="out.png",
    ),
    "harris": AppConfig(
        name="harris",
        generator_source="apps/harris/harris_generator.cpp",
        generator_name="harris",
        function_name="harris",
        driver_source="apps/harris/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgba.png",
        output_artifact="out.png",
    ),
    "unsharp": AppConfig(
        name="unsharp",
        generator_source="apps/unsharp/unsharp_generator.cpp",
        generator_name="unsharp",
        function_name="unsharp",
        driver_source="apps/unsharp/filter.cpp",
        driver_args=["{input}", "{output}"],
        input_image="apps/images/rgba.png",
        output_artifact="out.png",
    ),
    # Historically the most fragile of the five: the largest generator, and the
    # heaviest at both generate and run time.
    "camera_pipe": AppConfig(
        name="camera_pipe",
        generator_source="apps/camera_pipe/camera_pipe_generator.cpp",
        generator_name="camera_pipe",
        function_name="camera_pipe",
        driver_source="apps/camera_pipe/process.cpp",
        driver_args=["{input}", "3700", "2.0", "50", "1.0", "1", "{output}", "{outdir}/h_auto.png"],
        input_image="apps/images/bayer_raw.png",
        output_artifact="out.png",
        extra_driver_outputs=["h_auto.png"],
        run_timeout=600,
        generate_timeout=1200,
        memory_heavy=True,
    ),
}


# The two experiment arms.
ARMS = {
    # The legacy 12 arithmetic operators: pairwise + - * / on Halide::Expr.
    # Every one has a direct C++ sibling.
    "arithmetic": [
        "Halide_add_to_mul", "Halide_add_to_sub", "Halide_add_to_div",
        "Halide_sub_to_mul", "Halide_sub_to_add", "Halide_sub_to_div",
        "Halide_mul_to_add", "Halide_mul_to_sub", "Halide_mul_to_div",
        "Halide_div_to_mul", "Halide_div_to_sub", "Halide_div_to_add",
    ],
    # The new schedule-directive family. No C++ or GPL sibling exists: these
    # mutate how the pipeline is scheduled, not what it computes.
    "schedule": [
        "Halide_vectorize_to_unroll", "Halide_vectorize_to_parallel",
        "Halide_unroll_to_vectorize", "Halide_unroll_to_parallel",
        "Halide_parallel_to_vectorize", "Halide_parallel_to_unroll",
        "Halide_compute_at_to_store_at", "Halide_store_at_to_compute_at",
    ],
}
