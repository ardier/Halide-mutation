#include "HalideRuntimeWebGPU.h"
#include "device_interface.h"
#include "printer.h"
#include "scoped_spin_lock.h"

// TODO: Discover this with CMake, and upstream toggle for stdint.h.
#include "webgpu/webgpu.h"

namespace Halide {
namespace Runtime {
namespace Internal {
namespace WebGPU {

extern WEAK halide_device_interface_t webgpu_device_interface;

WEAK int create_webgpu_context(void *user_context);

// A WebGPU adapter/device defined in this module with weak linkage.
WGPUAdapter WEAK global_adapter = nullptr;
WGPUDevice WEAK global_device = nullptr;
// Lock to synchronize access to the global WebGPU context.
volatile ScopedSpinLock::AtomicFlag WEAK context_lock = 0;

// Size of the staging buffer used for host<->device copies.
#define WEBGPU_STAGING_BUFFER_SIZE (4 * 1024 * 1024)
// A staging buffer used for host<->device copies.
WGPUBuffer WEAK staging_buffer = nullptr;

}  // namespace WebGPU
}  // namespace Internal
}  // namespace Runtime
}  // namespace Halide

using namespace Halide::Runtime::Internal;
using namespace Halide::Runtime::Internal::WebGPU;

extern "C" {

// Defined by Emscripten, and used to yield execution to asynchronous Javascript
// work in combination with Emscripten's "Asyncify" mechanism.
void emscripten_sleep(unsigned int ms);

// The default implementation of halide_webgpu_acquire_context uses the global
// pointers above, and serializes access with a spin lock.
// Overriding implementations of acquire/release must implement the following
// behavior:
// - halide_webgpu_acquire_context should always store a valid adapter/device
//   in adapter_ret/device_ret, or return an error code.
// - A call to halide_webgpu_acquire_context is followed by a matching call to
//   halide_webgpu_release_context. halide_webgpu_acquire_context should block
//   while a previous call (if any) has not yet been released via
//   halide_webgpu_release_context.
WEAK int halide_webgpu_acquire_context(void *user_context,
                                       WGPUAdapter *adapter_ret,
                                       WGPUDevice *device_ret,
                                       bool create = true) {
    halide_abort_if_false(user_context, &context_lock != nullptr);
    while (__atomic_test_and_set(&context_lock, __ATOMIC_ACQUIRE)) {
    }

    if (create && (global_device == nullptr)) {
        int status = create_webgpu_context(user_context);
        if (status != halide_error_code_success) {
            __atomic_clear(&context_lock, __ATOMIC_RELEASE);
            return status;
        }
    }

    *adapter_ret = global_adapter;
    *device_ret = global_device;

    return halide_error_code_success;
}

WEAK int halide_webgpu_release_context(void *user_context) {
    __atomic_clear(&context_lock, __ATOMIC_RELEASE);
    return 0;
}

}  // extern "C" linkage

namespace Halide {
namespace Runtime {
namespace Internal {
namespace WebGPU {

// Helper object to acquire and release the WebGPU context.
class WgpuContext {
    void *user_context;

public:
    WGPUAdapter adapter = nullptr;
    WGPUDevice device = nullptr;
    int error_code = 0;

    ALWAYS_INLINE WgpuContext(void *user_context)
        : user_context(user_context) {
        error_code = halide_webgpu_acquire_context(
            user_context, &adapter, &device);
    }

    ALWAYS_INLINE ~WgpuContext() {
        halide_webgpu_release_context(user_context);
    }
};

// Helper class for handling asynchronous errors for a set of WebGPU API calls
// within a particular scope.
class ErrorScope {
public:
    ALWAYS_INLINE ErrorScope(void *user_context, WGPUDevice device)
        : user_context(user_context), device(device) {
        // Capture validation and OOM errors.
        wgpuDevicePushErrorScope(device, WGPUErrorFilter_Validation);
        wgpuDevicePushErrorScope(device, WGPUErrorFilter_OutOfMemory);
        callbacks_remaining = 2;
    }

    ALWAYS_INLINE ~ErrorScope() {
        if (callbacks_remaining > 0) {
            // Pop the error scopes to flush any pending errors.
            wait();
        }
    }

    // Wait for all error callbacks in this scope to fire.
    // Returns the error code (or success).
    int wait() {
        if (callbacks_remaining == 0) {
            error(user_context) << "no outstanding error scopes\n";
            return halide_error_code_internal_error;
        }

        error_code = halide_error_code_success;
        wgpuDevicePopErrorScope(device, error_callback, this);
        wgpuDevicePopErrorScope(device, error_callback, this);

        // Wait for the error callbacks to fire.
        while (__atomic_load_n(&callbacks_remaining, __ATOMIC_ACQUIRE) > 0) {
            emscripten_sleep(1);
        }

        return error_code;
    }

private:
    void *user_context;
    WGPUDevice device;

    // The error code reported by the callback functions.
    volatile int error_code;

    // Used to track outstanding error callbacks.
    volatile int callbacks_remaining = 0;

    // The error callback function.
    // Logs any errors, and decrements the remaining callback count.
    static void error_callback(WGPUErrorType type,
                               char const *message,
                               void *userdata) {
        ErrorScope *context = (ErrorScope *)userdata;
        switch (type) {
        case WGPUErrorType_NoError:
            // Do not overwrite the error_code to avoid masking earlier errors.
            break;
        case WGPUErrorType_Validation:
            error(context->user_context) << "WGPU: validation error: "
                                         << message << "\n";
            context->error_code = halide_error_code_generic_error;
            break;
        case WGPUErrorType_OutOfMemory:
            error(context->user_context) << "WGPU: out-of-memory error: "
                                         << message << "\n";
            context->error_code = halide_error_code_out_of_memory;
            break;
        default:
            error(context->user_context) << "WGPU: unknown error (" << type
                                         << "): " << message << "\n";
            context->error_code = halide_error_code_generic_error;
        }

        __atomic_sub_fetch(&context->callbacks_remaining, 1, __ATOMIC_RELEASE);
    }
};

namespace {

halide_error_code_t init_error_code = halide_error_code_success;

void request_device_callback(WGPURequestDeviceStatus status,
                             WGPUDevice device,
                             char const *message,
                             void *user_context) {
    if (status != WGPURequestDeviceStatus_Success) {
        debug(user_context) << "wgpuAdapterRequestDevice failed ("
                            << status << "): " << message << "\n";
        init_error_code = halide_error_code_generic_error;
        return;
    }
    global_device = device;
}

void request_adapter_callback(WGPURequestAdapterStatus status,
                              WGPUAdapter adapter,
                              char const *message,
                              void *user_context) {
    if (status != WGPURequestAdapterStatus_Success) {
        debug(user_context) << "wgpuInstanceRequestAdapter failed: ("
                            << status << "): " << message << "\n";
        init_error_code = halide_error_code_generic_error;
        return;
    }
    global_adapter = adapter;

    wgpuAdapterRequestDevice(adapter, nullptr, request_device_callback,
                             user_context);
}

}  // namespace

WEAK int create_webgpu_context(void *user_context) {
    WGPUInstance instance{};
    wgpuInstanceRequestAdapter(
        instance, nullptr, request_adapter_callback, user_context);

    // Wait for device initialization to complete.
    while (!global_device && init_error_code == halide_error_code_success) {
        emscripten_sleep(10);
    }

    return init_error_code;
}

}  // namespace WebGPU
}  // namespace Internal
}  // namespace Runtime
}  // namespace Halide

using namespace Halide::Runtime::Internal::WebGPU;

extern "C" {

WEAK int halide_webgpu_device_malloc(void *user_context, halide_buffer_t *buf) {
    debug(user_context)
        << "WGPU: halide_webgpu_device_malloc (user_context: " << user_context
        << ", buf: " << buf << ")\n";

    WgpuContext context(user_context);
    if (context.error_code) {
        return context.error_code;
    }

    ErrorScope error_scope(user_context, context.device);

    WGPUBufferDescriptor desc = {
        .nextInChain = nullptr,
        .label = nullptr,
        .usage = WGPUBufferUsage_Storage |
                 WGPUBufferUsage_CopyDst |
                 WGPUBufferUsage_CopySrc,
        .size = buf->size_in_bytes(),
        .mappedAtCreation = false,
    };
    WGPUBuffer device_buffer = wgpuDeviceCreateBuffer(context.device, &desc);

    int error_code = error_scope.wait();
    if (error_code != halide_error_code_success) {
        return error_code;
    }

    if (staging_buffer == nullptr) {
        ErrorScope error_scope(user_context, context.device);

        // Create a staging buffer for transfers if we haven't already.
        WGPUBufferDescriptor desc = {
            .nextInChain = nullptr,
            .label = nullptr,
            .usage = WGPUBufferUsage_CopyDst | WGPUBufferUsage_MapRead,
            .size = WEBGPU_STAGING_BUFFER_SIZE,
            .mappedAtCreation = false,
        };
        staging_buffer = wgpuDeviceCreateBuffer(global_device, &desc);

        int error_code = error_scope.wait();
        if (error_code != halide_error_code_success) {
            staging_buffer = nullptr;
            return error_code;
        }
    }

    buf->device = (uint64_t)device_buffer;
    buf->device_interface = &webgpu_device_interface;
    buf->device_interface->impl->use_module();

    debug(user_context)
        << "      Allocated device buffer " << (void *)buf->device << "\n";

    return halide_error_code_success;
}

WEAK int halide_webgpu_device_free(void *user_context, halide_buffer_t *buf) {
    if (buf->device == 0) {
        return 0;
    }

    WGPUBuffer buffer = (WGPUBuffer)buf->device;

    debug(user_context)
        << "WGPU: halide_webgpu_device_free (user_context: " << user_context
        << ", buf: " << buf << ") WGPUBuffer: " << buffer << "\n";

    wgpuBufferRelease(buffer);
    buf->device = 0;
    buf->device_interface->impl->release_module();
    buf->device_interface = nullptr;

    return halide_error_code_success;
}

WEAK int halide_webgpu_device_sync(void *user_context, halide_buffer_t *) {
    WgpuContext context(user_context);
    if (context.error_code) {
        return context.error_code;
    }

    ErrorScope error_scope(user_context, context.device);

    // Wait for all work on the queue to finish.
    struct WorkDoneResult {
        volatile bool complete = false;
        volatile WGPUQueueWorkDoneStatus status;
    };
    WorkDoneResult result;
    wgpuQueueOnSubmittedWorkDone(
        wgpuDeviceGetQueue(context.device), 0,
        [](WGPUQueueWorkDoneStatus status, void *userdata) {
            WorkDoneResult *result = (WorkDoneResult *)userdata;
            result->status = status;
            __atomic_store_n(&result->complete, true, __ATOMIC_RELEASE);
        },
        &result);

    int error_code = error_scope.wait();
    if (error_code != halide_error_code_success) {
        return error_code;
    }

    while (!__atomic_load_n(&result.complete, __ATOMIC_ACQUIRE)) {
        emscripten_sleep(1);
    }

    return result.status == WGPUQueueWorkDoneStatus_Success ?
               halide_error_code_success :
               halide_error_code_device_sync_failed;
}

WEAK int halide_webgpu_device_release(void *user_context) {
    debug(user_context)
        << "WGPU: halide_webgpu_device_release (user_context: " << user_context
        << ")\n";

    WgpuContext context(user_context);
    if (context.error_code) {
        return context.error_code;
    }

    if (staging_buffer) {
        wgpuBufferRelease(staging_buffer);
    }
    wgpuDeviceRelease(context.device);
    wgpuAdapterRelease(context.adapter);

    return 1;
}

WEAK int halide_webgpu_copy_to_host(void *user_context, halide_buffer_t *buf) {
    debug(user_context)
        << "WGPU: halide_webgpu_copy_to_host (user_context: " << user_context
        << ", buf: " << buf << ")\n";

    // TODO: Handle multi-dimensional strided copies.

    WgpuContext context(user_context);
    if (context.error_code) {
        return context.error_code;
    }

    ErrorScope error_scope(user_context, context.device);

    WGPUBuffer buffer = (WGPUBuffer)buf->device;

    // Copy chunks via the staging buffer.
    for (size_t offset = 0; offset < buf->size_in_bytes();
         offset += WEBGPU_STAGING_BUFFER_SIZE) {

        size_t num_bytes = WEBGPU_STAGING_BUFFER_SIZE;
        if (offset + num_bytes > buf->size_in_bytes()) {
            num_bytes = buf->size_in_bytes() - offset;
        }

        // Copy this chunk to the staging buffer.
        WGPUCommandEncoder encoder =
            wgpuDeviceCreateCommandEncoder(context.device, nullptr);
        wgpuCommandEncoderCopyBufferToBuffer(encoder, buffer, offset,
                                             staging_buffer, 0, num_bytes);
        WGPUCommandBuffer command_buffer =
            wgpuCommandEncoderFinish(encoder, nullptr);
        wgpuQueueSubmit(wgpuDeviceGetQueue(context.device), 1, &command_buffer);

        struct BufferMapResult {
            volatile bool map_complete = false;
            volatile WGPUBufferMapAsyncStatus map_status;
        };
        BufferMapResult result;

        // Map the staging buffer for reading.
        wgpuBufferMapAsync(
            staging_buffer, WGPUMapMode_Read, 0, num_bytes,
            [](WGPUBufferMapAsyncStatus status, void *userdata) {
                BufferMapResult *result = (BufferMapResult *)userdata;
                result->map_status = status;
                __atomic_store_n(&result->map_complete, true, __ATOMIC_RELEASE);
            },
            &result);
        while (!__atomic_load_n(&result.map_complete, __ATOMIC_ACQUIRE)) {
            emscripten_sleep(1);
        }
        if (result.map_status != WGPUBufferMapAsyncStatus_Success) {
            debug(user_context) << "wgpuBufferMapAsync failed: "
                                << result.map_status << "\n";
            return halide_error_code_copy_to_host_failed;
        }

        // Copy the data from the mapped staging buffer to the host allocation.
        const void *src = wgpuBufferGetConstMappedRange(staging_buffer, 0,
                                                        num_bytes);
        memcpy(buf->host + offset, src, num_bytes);
        wgpuBufferUnmap(staging_buffer);
    }

    return error_scope.wait();
}

WEAK int halide_webgpu_copy_to_device(void *user_context, halide_buffer_t *buf) {
    debug(user_context)
        << "WGPU: halide_webgpu_copy_to_device (user_context: " << user_context
        << ", buf: " << buf << ")\n";

    // TODO: Handle multi-dimensional strided copies.

    WgpuContext context(user_context);
    if (context.error_code) {
        return context.error_code;
    }

    ErrorScope error_scope(user_context, context.device);

    WGPUBuffer buffer = (WGPUBuffer)buf->device;
    wgpuQueueWriteBuffer(wgpuDeviceGetQueue(context.device),
                         buffer, 0, buf->host, buf->size_in_bytes());

    return error_scope.wait();
}

WEAK int halide_webgpu_device_and_host_malloc(void *user_context, struct halide_buffer_t *buf) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_device_and_host_free(void *user_context, struct halide_buffer_t *buf) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_buffer_copy(void *user_context, struct halide_buffer_t *src,
                                   const struct halide_device_interface_t *dst_device_interface,
                                   struct halide_buffer_t *dst) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_device_crop(void *user_context,
                                   const struct halide_buffer_t *src,
                                   struct halide_buffer_t *dst) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_device_slice(void *user_context,
                                    const struct halide_buffer_t *src,
                                    int slice_dim,
                                    int slice_pos,
                                    struct halide_buffer_t *dst) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_device_release_crop(void *user_context,
                                           struct halide_buffer_t *buf) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_wrap_native(void *user_context, struct halide_buffer_t *buf, uint64_t mem) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_detach_native(void *user_context, halide_buffer_t *buf) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK int halide_webgpu_initialize_kernels(void *user_context, void **state_ptr, const char *src, int size) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK void halide_webgpu_finalize_kernels(void *user_context, void *state_ptr) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
}

WEAK int halide_webgpu_run(void *user_context,
                           void *state_ptr,
                           const char *entry_name,
                           int blocksX, int blocksY, int blocksZ,
                           int threadsX, int threadsY, int threadsZ,
                           int shared_mem_bytes,
                           size_t arg_sizes[],
                           void *args[],
                           int8_t arg_is_buffer[]) {
    // TODO: Implement this.
    halide_debug_assert(user_context, false && "unimplemented");
    return 1;
}

WEAK const struct halide_device_interface_t *halide_webgpu_device_interface() {
    return &webgpu_device_interface;
}

namespace {
WEAK __attribute__((destructor)) void halide_webgpu_cleanup() {
    halide_webgpu_device_release(nullptr);
}
}  // namespace

}  // extern "C" linkage

namespace Halide {
namespace Runtime {
namespace Internal {
namespace WebGPU {

WEAK halide_device_interface_impl_t webgpu_device_interface_impl = {
    halide_use_jit_module,
    halide_release_jit_module,
    halide_webgpu_device_malloc,
    halide_webgpu_device_free,
    halide_webgpu_device_sync,
    halide_webgpu_device_release,
    halide_webgpu_copy_to_host,
    halide_webgpu_copy_to_device,
    halide_webgpu_device_and_host_malloc,
    halide_webgpu_device_and_host_free,
    halide_webgpu_buffer_copy,
    halide_webgpu_device_crop,
    halide_webgpu_device_slice,
    halide_webgpu_device_release_crop,
    halide_webgpu_wrap_native,
    halide_webgpu_detach_native,
};

WEAK halide_device_interface_t webgpu_device_interface = {
    halide_device_malloc,
    halide_device_free,
    halide_device_sync,
    halide_device_release,
    halide_copy_to_host,
    halide_copy_to_device,
    halide_device_and_host_malloc,
    halide_device_and_host_free,
    halide_buffer_copy,
    halide_device_crop,
    halide_device_slice,
    halide_device_release_crop,
    halide_device_wrap_native,
    halide_device_detach_native,
    nullptr,
    &webgpu_device_interface_impl};

}  // namespace WebGPU
}  // namespace Internal
}  // namespace Runtime
}  // namespace Halide
