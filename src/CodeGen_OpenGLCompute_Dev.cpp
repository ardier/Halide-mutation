#include "CodeGen_OpenGLCompute_Dev.h"
#include "CodeGen_GPU_Dev.h"
#include "CodeGen_OpenGL_Dev.h"
#include "Debug.h"
#include "Deinterleave.h"
#include "IRMatch.h"
#include "IRMutator.h"
#include "IROperator.h"
#include "Simplify.h"
#include "VaryingAttributes.h"
#include <iomanip>
#include <limits>
#include <map>

namespace Halide {
namespace Internal {

using std::ostringstream;
using std::string;
using std::vector;

namespace {

class CodeGen_OpenGLCompute_Dev : public CodeGen_GPU_Dev {
public:
    CodeGen_OpenGLCompute_Dev(Target target);

    // CodeGen_GPU_Dev interface
    void add_kernel(Stmt stmt,
                    const std::string &name,
                    const std::vector<DeviceArgument> &args) override;

    void init_module() override;

    std::vector<char> compile_to_src() override;

    std::string get_current_kernel_name() override;

    void dump() override;

    std::string print_gpu_name(const std::string &name) override;

    std::string api_unique_name() override {
        return "openglcompute";
    }
    bool kernel_run_takes_types() const override {
        return true;
    }

protected:
    class CodeGen_OpenGLCompute_C : public CodeGen_GLSLBase {
    public:
        CodeGen_OpenGLCompute_C(std::ostream &s, Target t);
        void add_kernel(const Stmt &stmt,
                        const std::string &name,
                        const std::vector<DeviceArgument> &args);

    protected:
        std::string print_type(Type type, AppendSpaceIfNeeded space_option = DoNotAppendSpace) override;

        using CodeGen_GLSLBase::visit;
        void visit(const For *) override;
        void visit(const Ramp *op) override;
        void visit(const Broadcast *op) override;
        void visit(const Load *op) override;
        void visit(const Store *op) override;
        void visit(const Call *op) override;
        void visit(const Allocate *op) override;
        void visit(const Free *op) override;
        void visit(const Select *op) override;
        void visit(const Evaluate *op) override;
        void visit(const IntImm *op) override;

    public:
        int workgroup_size[3];
    };

    std::ostringstream src_stream;
    std::string cur_kernel_name;
    CodeGen_OpenGLCompute_C glc;
};

CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_Dev(Target target)
    : glc(src_stream, target) {
}

CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::CodeGen_OpenGLCompute_C(std::ostream &s, Target t)
    : CodeGen_GLSLBase(s, t) {
    builtin["trunc_f32"] = "trunc";
}

string CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::print_type(Type type, AppendSpaceIfNeeded space) {
    Type mapped_type = map_type(type);
    if (mapped_type.is_uint() && !mapped_type.is_bool()) {
        string s = mapped_type.is_scalar() ? "uint" : "uvec" + std::to_string(mapped_type.lanes());
        if (space == AppendSpace) {
            s += " ";
        }
        return s;
    } else {
        return CodeGen_GLSLBase::print_type(type, space);
    }
}

namespace {
string simt_intrinsic(const string &name) {
    if (ends_with(name, ".__thread_id_x")) {
        return "gl_LocalInvocationID.x";
    } else if (ends_with(name, ".__thread_id_y")) {
        return "gl_LocalInvocationID.y";
    } else if (ends_with(name, ".__thread_id_z")) {
        return "gl_LocalInvocationID.z";
    } else if (ends_with(name, ".__thread_id_w")) {
        internal_error << "4-dimension loops with " << name << " are not supported\n";
    } else if (ends_with(name, ".__block_id_x")) {
        return "gl_WorkGroupID.x";
    } else if (ends_with(name, ".__block_id_y")) {
        return "gl_WorkGroupID.y";
    } else if (ends_with(name, ".__block_id_z")) {
        return "gl_WorkGroupID.z";
    } else if (ends_with(name, ".__block_id_w")) {
        internal_error << "4-dimension loops with " << name << " are not supported\n";
    }
    internal_error << "simt_intrinsic called on bad variable name: " << name << "\n";
    return "";
}

int thread_loop_workgroup_index(const string &name) {
    string ids[] = {".__thread_id_x",
                    ".__thread_id_y",
                    ".__thread_id_z",
                    ".__thread_id_w"};
    for (size_t i = 0; i < sizeof(ids) / sizeof(string); i++) {
        if (ends_with(name, ids[i])) {
            return i;
        }
    }
    return -1;
}
}  // namespace

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Call *op) {
    if (op->is_intrinsic(Call::gpu_thread_barrier)) {
        internal_assert(op->args.size() == 1) << "gpu_thread_barrier() intrinsic must specify memory fence type.\n";

        const auto *fence_type_ptr = as_const_int(op->args[0]);
        internal_assert(fence_type_ptr) << "gpu_thread_barrier() parameter is not a constant integer.\n";
        auto fence_type = *fence_type_ptr;

        stream << get_indent() << "barrier();\n";

        // barrier() is an execution barrier; for memory behavior, we'll use the
        // least-common-denominator groupMemoryBarrier(), because other fence types
        // require extensions or GL 4.3 as a minumum.
        if (fence_type & CodeGen_GPU_Dev::MemoryFenceType::Device ||
            fence_type & CodeGen_GPU_Dev::MemoryFenceType::Shared) {
            stream << "groupMemoryBarrier();\n";
        }
        print_assignment(op->type, "0");
    } else {
        CodeGen_GLSLBase::visit(op);
    }
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const For *loop) {
    user_assert(loop->for_type != ForType::GPULane)
        << "The OpenGLCompute backend does not support the gpu_lanes() scheduling directive.";

    if (is_gpu_var(loop->name)) {
        internal_assert((loop->for_type == ForType::GPUBlock) ||
                        (loop->for_type == ForType::GPUThread))
            << "kernel loop must be either gpu block or gpu thread\n";
        internal_assert(is_const_zero(loop->min));

        debug(4) << "loop extent is " << loop->extent << "\n";
        //
        //  Need to extract workgroup size.
        //
        int index = thread_loop_workgroup_index(loop->name);
        if (index >= 0) {
            const IntImm *int_limit = loop->extent.as<IntImm>();
            user_assert(int_limit != nullptr) << "For OpenGLCompute workgroup size must be a constant integer.\n";
            int new_workgroup_size = int_limit->value;
            user_assert(workgroup_size[index] == 0 ||
                        workgroup_size[index] == new_workgroup_size)
                << "OpenGLCompute requires all gpu kernels have same workgroup size, "
                << "but two different ones were encountered " << workgroup_size[index]
                << " and " << new_workgroup_size
                << " in dimension " << index << ".\n";
            workgroup_size[index] = new_workgroup_size;
            debug(4) << "Workgroup size for index " << index << " is " << workgroup_size[index] << "\n";
        }

        stream << get_indent() << print_type(Int(32)) << " " << print_name(loop->name)
               << " = int(" << simt_intrinsic(loop->name) << ");\n";

        loop->body.accept(this);

    } else {
        user_assert(loop->for_type != ForType::Parallel)
            << "Cannot use parallel loops inside OpenGLCompute kernel\n";
        CodeGen_C::visit(loop);
    }
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Ramp *op) {
    ostringstream rhs;
    rhs << print_type(op->type) << "(";

    if (op->lanes > 4) {
        internal_error << "GLSL: ramp lanes " << op->lanes << " is not supported\n";
    }

    rhs << print_expr(op->base);

    for (int i = 1; i < op->lanes; ++i) {
        rhs << ", " << print_expr(Add::make(op->base, Mul::make(i, op->stride)));
    }

    rhs << ")";
    print_assignment(op->base.type(), rhs.str());
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Broadcast *op) {
    string id_value = print_expr(op->value);
    ostringstream oss;
    oss << print_type(op->type.with_lanes(op->lanes)) << "(" << id_value << ")";
    print_assignment(op->type.with_lanes(op->lanes), oss.str());
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Load *op) {
    user_assert(is_const_one(op->predicate)) << "GLSL: predicated load is not supported.\n";
    // TODO: support vectors
    // https://github.com/halide/Halide/issues/4975
    internal_assert(op->type.is_scalar());
    string id_index = print_expr(op->index);

    ostringstream oss;
    oss << print_name(op->name);
    if (!allocations.contains(op->name)) {
        oss << ".data";
    }
    oss << "[" << id_index << "]";
    print_assignment(op->type, oss.str());
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Store *op) {
    user_assert(is_const_one(op->predicate)) << "GLSL: predicated store is not supported.\n";
    // TODO: support vectors
    // https://github.com/halide/Halide/issues/4975
    internal_assert(op->value.type().is_scalar());
    string id_index = print_expr(op->index);

    string id_value = print_expr(op->value);

    stream << get_indent() << print_name(op->name);
    if (!allocations.contains(op->name)) {
        stream << ".data";
    }
    stream << "[" << id_index << "] = " << print_type(op->value.type()) << "(" << id_value << ");\n";

    // Need a cache clear on stores to avoid reusing stale loaded
    // values from before the store.
    cache.clear();
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Select *op) {
    ostringstream rhs;
    string true_val = print_expr(op->true_value);
    string false_val = print_expr(op->false_value);
    string cond = print_expr(op->condition);
    rhs << print_type(op->type)
        << "(" << cond
        << " ? " << true_val
        << " : " << false_val
        << ")";
    print_assignment(op->type, rhs.str());
}

void CodeGen_OpenGLCompute_Dev::add_kernel(Stmt s,
                                           const string &name,
                                           const vector<DeviceArgument> &args) {
    debug(2) << "CodeGen_OpenGLCompute_Dev::compile " << name << "\n";

    // TODO: do we have to uniquify these names, or can we trust that they are safe?
    cur_kernel_name = name;
    glc.add_kernel(s, name, args);
}

namespace {
class FindSharedAllocations : public IRVisitor {
    using IRVisitor::visit;

    void visit(const Allocate *op) override {
        op->body.accept(this);
        if (op->memory_type == MemoryType::GPUShared) {
            allocs.push_back(op);
        }
    }

public:
    vector<const Allocate *> allocs;
};
}  // namespace

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::add_kernel(const Stmt &s,
                                                                    const string &name,
                                                                    const vector<DeviceArgument> &args) {

    debug(2) << "Adding OpenGLCompute kernel " << name << "\n";
    cache.clear();

    if (target.os == Target::Android) {
        stream << "#version 310 es\n"
               << "#extension GL_ANDROID_extension_pack_es31a : require\n";
    } else if (target.has_feature(Target::EGL)) {
        stream << "#version 310 es\n";
    } else {
        stream << "#version 430\n";
    }
    stream << "float float_from_bits(int x) { return intBitsToFloat(int(x)); }\n";
    stream << "#define halide_unused(x) (void)(x)\n";

    for (size_t i = 0; i < args.size(); i++) {
        if (args[i].is_buffer) {
            //
            // layout(binding = 10) buffer buffer10 {
            //     vec3 data[];
            // } inBuffer;
            //
            stream << "layout(binding=" << i << ")"
                   << " buffer buffer" << i << " { "
                   << print_type(args[i].type) << " data[]; } "
                   << print_name(args[i].name) << ";\n";
        } else {
            stream << "layout(location = " << i << ") uniform " << print_type(args[i].type)
                   << " " << print_name(args[i].name) << ";\n";
        }
    }

    // Find all the shared allocations and declare them at global scope.
    FindSharedAllocations fsa;
    s.accept(&fsa);
    for (const Allocate *op : fsa.allocs) {
        internal_assert(op->extents.size() == 1 && is_const(op->extents[0]));
        stream << "shared "
               << print_type(op->type) << " "
               << print_name(op->name) << "["
               << op->extents[0] << "];\n";
    }

    // We'll figure out the workgroup size while traversing the stmt
    workgroup_size[0] = 0;
    workgroup_size[1] = 0;
    workgroup_size[2] = 0;

    stream << "void main()\n{\n";
    indent += 2;
    print(s);
    indent -= 2;
    stream << "}\n";

    // Declare the workgroup size.
    indent += 2;
    stream << "layout(local_size_x = " << workgroup_size[0];
    if (workgroup_size[1] > 1) {
        stream << ", local_size_y = " << workgroup_size[1];
    }
    if (workgroup_size[2] > 1) {
        stream << ", local_size_z = " << workgroup_size[2];
    }
    stream << ") in;\n// end of kernel " << name << "\n";
    indent -= 2;
}

void CodeGen_OpenGLCompute_Dev::init_module() {
    src_stream.str("");
    src_stream.clear();
    cur_kernel_name = "";
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Allocate *op) {
    debug(2) << "OpenGLCompute: Allocate " << op->name << " of type " << op->type << " on device\n";

    stream << get_indent();
    Allocation alloc;
    alloc.type = op->type;
    allocations.push(op->name, alloc);

    internal_assert(!op->extents.empty());
    Expr extent = 1;
    for (const Expr &e : op->extents) {
        extent *= e;
    }
    extent = simplify(extent);
    internal_assert(is_const(extent));

    if (op->memory_type != MemoryType::GPUShared) {
        stream << "{\n";
        indent += 2;
        stream << get_indent();
        // Shared allocations were already declared at global scope.
        stream << print_type(op->type) << " "
               << print_name(op->name) << "["
               << op->extents[0] << "];\n";
    }
    op->body.accept(this);

    if (op->memory_type != MemoryType::GPUShared) {
        indent -= 2;
        stream << get_indent() << "}\n";
    }
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Free *op) {
    debug(2) << "OpenGLCompute: Free on device for " << op->name << "\n";

    allocations.pop(op->name);
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const Evaluate *op) {
    if (is_const(op->value)) {
        return;
    }
    print_expr(op->value);
}

void CodeGen_OpenGLCompute_Dev::CodeGen_OpenGLCompute_C::visit(const IntImm *op) {
    if (op->type == Int(32)) {
        // GL seems to interpret some large int immediates as uints.
        id = "int(" + std::to_string(op->value) + ")";
    } else {
        id = print_type(op->type) + "(" + std::to_string(op->value) + ")";
    }
}

vector<char> CodeGen_OpenGLCompute_Dev::compile_to_src() {
    string str = src_stream.str();
    debug(1) << "GLSL Compute source:\n"
             << str << "\n";
    vector<char> buffer(str.begin(), str.end());
    buffer.push_back(0);
    return buffer;
}

string CodeGen_OpenGLCompute_Dev::get_current_kernel_name() {
    return cur_kernel_name;
}

void CodeGen_OpenGLCompute_Dev::dump() {
    std::cerr << src_stream.str() << "\n";
}

std::string CodeGen_OpenGLCompute_Dev::print_gpu_name(const std::string &name) {
    return name;
}

}  // namespace

CodeGen_GPU_Dev *new_CodeGen_OpenGLCompute_Dev(const Target &target) {
    return new CodeGen_OpenGLCompute_Dev(target);
}

}  // namespace Internal
}  // namespace Halide
