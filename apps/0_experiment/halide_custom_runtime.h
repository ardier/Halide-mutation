#pragma once

#include "Halide.h"

extern "C" {
    int halide_default_do_par_for(void *user_context, halide_task_t f, int min, int size, uint8_t *closure);
    extern halide_do_par_for_t custom_do_par_for;

    void *halide_default_malloc(void *user_context, size_t x);
    void halide_default_free(void *user_context, void *ptr);

    void *halide_malloc(void *user_context, size_t x);
    void halide_free(void *user_context, void *ptr);

    int halide_error_out_of_memory(void *user_context);
    // Add other error functions as needed

    void halide_error(void *user_context, const char *str);

    int halide_default_do_task(void *user_context, halide_task_t f, int idx, uint8_t *closure);
    extern halide_do_task_t custom_do_task;

    // Declare any other functions or variables here
}
