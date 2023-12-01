; ModuleID = '/Users/smadadi/Projects/halide_install_original/distrib/tools/GenGen.cpp'
source_filename = "/Users/smadadi/Projects/halide_install_original/distrib/tools/GenGen.cpp"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

%"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit" = type { i8 }
%"class.std::__1::basic_ostream" = type { i32 (...)**, %"class.std::__1::basic_ios.base" }
%"class.std::__1::basic_ios.base" = type <{ %"class.std::__1::ios_base", %"class.std::__1::basic_ostream"*, i32 }>
%"class.std::__1::ios_base" = type { i32 (...)**, i32, i64, i64, i32, i32, i8*, i8*, void (i32, %"class.std::__1::ios_base"*, i32)**, i32*, i64, i64, i64*, i64, i64, i8**, i64, i64 }
%"class.std::__1::locale::id" = type <{ %"struct.std::__1::once_flag", i32, [4 x i8] }>
%"struct.std::__1::once_flag" = type { i64 }
%"class.std::__1::basic_string" = type { %"class.std::__1::__compressed_pair" }
%"class.std::__1::__compressed_pair" = type { %"struct.std::__1::__compressed_pair_elem" }
%"struct.std::__1::__compressed_pair_elem" = type { %"struct.std::__1::basic_string<char>::__rep" }
%"struct.std::__1::basic_string<char>::__rep" = type { %union.anon }
%union.anon = type { %"struct.std::__1::basic_string<char>::__long" }
%"struct.std::__1::basic_string<char>::__long" = type { i8*, i64, i64 }
%"struct.HalideIntrospectionCanary::A" = type { i32, %"class.HalideIntrospectionCanary::A::B" }
%"class.HalideIntrospectionCanary::A::B" = type { i32, float, %"struct.HalideIntrospectionCanary::A"* }
%"struct.std::__1::__default_init_tag" = type { i8 }
%"struct.std::__1::__compressed_pair_elem.0" = type { i8 }
%"class.std::__1::allocator" = type { i8 }
%"struct.std::__1::__non_trivial_if" = type { i8 }
%"struct.std::__1::basic_string<char>::__short" = type { [23 x i8], %struct.anon }
%struct.anon = type { i8 }
%"struct.std::__1::basic_string<char>::__raw" = type { [3 x i64] }
%"class.std::__1::basic_ostream<char>::sentry" = type { i8, %"class.std::__1::basic_ostream"* }
%"class.std::__1::ostreambuf_iterator" = type { %"class.std::__1::basic_streambuf"* }
%"class.std::__1::basic_streambuf" = type { i32 (...)**, %"class.std::__1::locale", i8*, i8*, i8*, i8*, i8*, i8* }
%"class.std::__1::locale" = type { %"class.std::__1::locale::__imp"* }
%"class.std::__1::locale::__imp" = type opaque
%"class.std::__1::basic_ios" = type <{ %"class.std::__1::ios_base", %"class.std::__1::basic_ostream"*, i32, [4 x i8] }>
%"struct.std::__1::iterator" = type { i8 }
%"class.std::__1::ctype" = type <{ %"class.std::__1::locale::facet", i32*, i8, [7 x i8] }>
%"class.std::__1::locale::facet" = type { %"class.std::__1::__shared_count" }
%"class.std::__1::__shared_count" = type { i32 (...)**, i64 }

@_ZN25HalideIntrospectionCanaryL11test_objectE = internal global %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit" zeroinitializer, align 1
@.str = private unnamed_addr constant [3 x i8] c"a1\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"a2\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"int\00", align 1
@.str.3 = private unnamed_addr constant [8 x i8] c".an_int\00", align 1
@.str.4 = private unnamed_addr constant [73 x i8] c"/Users/smadadi/Projects/halide_install_original/distrib/include/Halide.h\00", align 1
@.str.5 = private unnamed_addr constant [32 x i8] c"HalideIntrospectionCanary::A::B\00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c".a_b\00", align 1
@.str.7 = private unnamed_addr constant [32 x i8] c"HalideIntrospectionCanary::A \\*\00", align 1
@.str.8 = private unnamed_addr constant [12 x i8] c".a_b.parent\00", align 1
@.str.9 = private unnamed_addr constant [6 x i8] c"float\00", align 1
@.str.10 = private unnamed_addr constant [13 x i8] c".a_b.a_float\00", align 1
@.str.11 = private unnamed_addr constant [29 x i8] c"HalideIntrospectionCanary::A\00", align 1
@.str.12 = private unnamed_addr constant [2 x i8] c":\00", align 1
@_ZNSt3__14cerrE = external global %"class.std::__1::basic_ostream", align 8
@.str.13 = private unnamed_addr constant [42 x i8] c"You should not have called this function\0A\00", align 1
@_ZNSt3__15ctypeIcE2idE = external global %"class.std::__1::locale::id", align 8
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__sub_I_GenGen.cpp, i8* null }]

; Function Attrs: noinline ssp uwtable
define internal void @__cxx_global_var_init() #0 section "__TEXT,__StaticInit,regular,pure_instructions" {
  %1 = call noundef %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* @_ZN25HalideIntrospectionCanary12_GLOBAL__N_119TestCompilationUnitC1Ev(%"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* noundef nonnull align 1 dereferenceable(1) @_ZN25HalideIntrospectionCanaryL11test_objectE)
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal noundef %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* @_ZN25HalideIntrospectionCanary12_GLOBAL__N_119TestCompilationUnitC1Ev(%"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 align 2 {
  %2 = alloca %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"*, align 8
  store %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* %0, %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"** %2, align 8
  %3 = load %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"*, %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"** %2, align 8
  %4 = call noundef %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* @_ZN25HalideIntrospectionCanary12_GLOBAL__N_119TestCompilationUnitC2Ev(%"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* noundef nonnull align 1 dereferenceable(1) %3)
  ret %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* %3
}

; Function Attrs: mustprogress noinline norecurse optnone ssp uwtable
define noundef i32 @main(i32 noundef %0, i8** noundef %1) #2 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i8**, align 8
  store i32 0, i32* %3, align 4
  store i32 %0, i32* %4, align 4
  store i8** %1, i8*** %5, align 8
  %6 = load i32, i32* %4, align 4
  %7 = load i8**, i8*** %5, align 8
  %8 = call noundef i32 @_ZN6Halide8Internal20generate_filter_mainEiPPc(i32 noundef %6, i8** noundef %7)
  ret i32 %8
}

declare noundef i32 @_ZN6Halide8Internal20generate_filter_mainEiPPc(i32 noundef, i8** noundef) #3

; Function Attrs: noinline optnone ssp uwtable
define internal noundef %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* @_ZN25HalideIntrospectionCanary12_GLOBAL__N_119TestCompilationUnitC2Ev(%"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #1 align 2 {
  %2 = alloca %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"*, align 8
  store %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* %0, %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"** %2, align 8
  %3 = load %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"*, %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"** %2, align 8
  call void @_ZN6Halide8Internal13Introspection21test_compilation_unitEPFbPFbPKvRKNSt3__112basic_stringIcNS4_11char_traitsIcEENS4_9allocatorIcEEEEEESE_PFvvE(i1 (i1 (i8*, %"class.std::__1::basic_string"*)*)* noundef @_ZN25HalideIntrospectionCanaryL4testEPFbPKvRKNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEE, i1 (i8*, %"class.std::__1::basic_string"*)* noundef @_ZN25HalideIntrospectionCanaryL6test_aEPKvRKNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE, void ()* noundef @_ZN25HalideIntrospectionCanaryL13offset_markerEv)
  ret %"struct.HalideIntrospectionCanary::(anonymous namespace)::TestCompilationUnit"* %3
}

declare void @_ZN6Halide8Internal13Introspection21test_compilation_unitEPFbPFbPKvRKNSt3__112basic_stringIcNS4_11char_traitsIcEENS4_9allocatorIcEEEEEESE_PFvvE(i1 (i1 (i8*, %"class.std::__1::basic_string"*)*)* noundef, i1 (i8*, %"class.std::__1::basic_string"*)* noundef, void ()* noundef) #3

; Function Attrs: mustprogress noinline optnone ssp uwtable
define internal noundef zeroext i1 @_ZN25HalideIntrospectionCanaryL4testEPFbPKvRKNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEEE(i1 (i8*, %"class.std::__1::basic_string"*)* noundef %0) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca i1, align 1
  %3 = alloca i1 (i8*, %"class.std::__1::basic_string"*)*, align 8
  %4 = alloca %"struct.HalideIntrospectionCanary::A", align 8
  %5 = alloca %"struct.HalideIntrospectionCanary::A", align 8
  %6 = alloca %"class.std::__1::basic_string", align 8
  %7 = alloca i8*, align 8
  %8 = alloca i32, align 4
  %9 = alloca %"class.std::__1::basic_string", align 8
  %10 = alloca i1, align 1
  store i1 (i8*, %"class.std::__1::basic_string"*)* %0, i1 (i8*, %"class.std::__1::basic_string"*)** %3, align 8
  %11 = call noundef %"struct.HalideIntrospectionCanary::A"* @_ZN25HalideIntrospectionCanary1AC1Ev(%"struct.HalideIntrospectionCanary::A"* noundef nonnull align 8 dereferenceable(24) %4)
  %12 = call noundef %"struct.HalideIntrospectionCanary::A"* @_ZN25HalideIntrospectionCanary1AC1Ev(%"struct.HalideIntrospectionCanary::A"* noundef nonnull align 8 dereferenceable(24) %5)
  %13 = load i1 (i8*, %"class.std::__1::basic_string"*)*, i1 (i8*, %"class.std::__1::basic_string"*)** %3, align 8
  %14 = bitcast %"struct.HalideIntrospectionCanary::A"* %4 to i8*
  %15 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %6, i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i64 0, i64 0))
  store i1 false, i1* %10, align 1
  %16 = invoke noundef zeroext i1 %13(i8* noundef %14, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %6)
          to label %17 unwind label %33

17:                                               ; preds = %1
  br i1 %16, label %18, label %25

18:                                               ; preds = %17
  %19 = load i1 (i8*, %"class.std::__1::basic_string"*)*, i1 (i8*, %"class.std::__1::basic_string"*)** %3, align 8
  %20 = bitcast %"struct.HalideIntrospectionCanary::A"* %5 to i8*
  %21 = invoke noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %9, i8* noundef getelementptr inbounds ([3 x i8], [3 x i8]* @.str.1, i64 0, i64 0))
          to label %22 unwind label %33

22:                                               ; preds = %18
  store i1 true, i1* %10, align 1
  %23 = invoke noundef zeroext i1 %19(i8* noundef %20, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %9)
          to label %24 unwind label %37

24:                                               ; preds = %22
  br label %25

25:                                               ; preds = %24, %17
  %26 = phi i1 [ false, %17 ], [ %23, %24 ]
  store i1 %26, i1* %2, align 1
  %27 = load i1, i1* %10, align 1
  br i1 %27, label %28, label %30

28:                                               ; preds = %25
  %29 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %9) #10
  br label %30

30:                                               ; preds = %28, %25
  %31 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %6) #10
  %32 = load i1, i1* %2, align 1
  ret i1 %32

33:                                               ; preds = %18, %1
  %34 = landingpad { i8*, i32 }
          cleanup
  %35 = extractvalue { i8*, i32 } %34, 0
  store i8* %35, i8** %7, align 8
  %36 = extractvalue { i8*, i32 } %34, 1
  store i32 %36, i32* %8, align 4
  br label %45

37:                                               ; preds = %22
  %38 = landingpad { i8*, i32 }
          cleanup
  %39 = extractvalue { i8*, i32 } %38, 0
  store i8* %39, i8** %7, align 8
  %40 = extractvalue { i8*, i32 } %38, 1
  store i32 %40, i32* %8, align 4
  %41 = load i1, i1* %10, align 1
  br i1 %41, label %42, label %44

42:                                               ; preds = %37
  %43 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %9) #10
  br label %44

44:                                               ; preds = %42, %37
  br label %45

45:                                               ; preds = %44, %33
  %46 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %6) #10
  br label %47

47:                                               ; preds = %45
  %48 = load i8*, i8** %7, align 8
  %49 = load i32, i32* %8, align 4
  %50 = insertvalue { i8*, i32 } undef, i8* %48, 0
  %51 = insertvalue { i8*, i32 } %50, i32 %49, 1
  resume { i8*, i32 } %51
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define internal noundef zeroext i1 @_ZN25HalideIntrospectionCanaryL6test_aEPKvRKNSt3__112basic_stringIcNS2_11char_traitsIcEENS2_9allocatorIcEEEE(i8* noundef %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca i8*, align 8
  %4 = alloca %"class.std::__1::basic_string"*, align 8
  %5 = alloca %"struct.HalideIntrospectionCanary::A"*, align 8
  %6 = alloca i8, align 1
  %7 = alloca %"class.std::__1::basic_string", align 8
  %8 = alloca %"class.std::__1::basic_string", align 8
  %9 = alloca i8*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %"class.std::__1::basic_string", align 8
  %12 = alloca %"class.std::__1::basic_string", align 8
  %13 = alloca %"class.std::__1::basic_string", align 8
  %14 = alloca %"class.std::__1::basic_string", align 8
  %15 = alloca %"class.std::__1::basic_string", align 8
  %16 = alloca %"class.std::__1::basic_string", align 8
  %17 = alloca %"class.std::__1::basic_string", align 8
  %18 = alloca %"class.std::__1::basic_string", align 8
  %19 = alloca %"class.std::__1::basic_string", align 8
  %20 = alloca %"class.std::__1::basic_string", align 8
  %21 = alloca %"class.std::__1::basic_string", align 8
  %22 = alloca %"class.std::__1::basic_string", align 8
  store i8* %0, i8** %3, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %4, align 8
  %23 = load i8*, i8** %3, align 8
  %24 = bitcast i8* %23 to %"struct.HalideIntrospectionCanary::A"*
  store %"struct.HalideIntrospectionCanary::A"* %24, %"struct.HalideIntrospectionCanary::A"** %5, align 8
  store i8 1, i8* %6, align 1
  %25 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %5, align 8
  %26 = getelementptr inbounds %"struct.HalideIntrospectionCanary::A", %"struct.HalideIntrospectionCanary::A"* %25, i32 0, i32 0
  %27 = bitcast i32* %26 to i8*
  %28 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %7, i8* noundef getelementptr inbounds ([4 x i8], [4 x i8]* @.str.2, i64 0, i64 0))
  %29 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  invoke void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EERKS9_PKS6_(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %8, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %29, i8* noundef getelementptr inbounds ([8 x i8], [8 x i8]* @.str.3, i64 0, i64 0))
          to label %30 unwind label %129

30:                                               ; preds = %2
  %31 = invoke noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11, i8* noundef getelementptr inbounds ([73 x i8], [73 x i8]* @.str.4, i64 0, i64 0))
          to label %32 unwind label %133

32:                                               ; preds = %30
  %33 = invoke noundef zeroext i1 @_ZN6Halide8InternalL19check_introspectionEPKvRKNSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEESB_SB_i(i8* noundef %27, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %7, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %8, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11, i32 noundef 25312)
          to label %34 unwind label %137

34:                                               ; preds = %32
  %35 = zext i1 %33 to i32
  %36 = load i8, i8* %6, align 1
  %37 = trunc i8 %36 to i1
  %38 = zext i1 %37 to i32
  %39 = and i32 %38, %35
  %40 = icmp ne i32 %39, 0
  %41 = zext i1 %40 to i8
  store i8 %41, i8* %6, align 1
  %42 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11) #10
  %43 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %8) #10
  %44 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %7) #10
  %45 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %5, align 8
  %46 = getelementptr inbounds %"struct.HalideIntrospectionCanary::A", %"struct.HalideIntrospectionCanary::A"* %45, i32 0, i32 1
  %47 = bitcast %"class.HalideIntrospectionCanary::A::B"* %46 to i8*
  %48 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12, i8* noundef getelementptr inbounds ([32 x i8], [32 x i8]* @.str.5, i64 0, i64 0))
  %49 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  invoke void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EERKS9_PKS6_(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %13, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %49, i8* noundef getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i64 0, i64 0))
          to label %50 unwind label %146

50:                                               ; preds = %34
  %51 = invoke noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %14, i8* noundef getelementptr inbounds ([73 x i8], [73 x i8]* @.str.4, i64 0, i64 0))
          to label %52 unwind label %150

52:                                               ; preds = %50
  %53 = invoke noundef zeroext i1 @_ZN6Halide8InternalL19check_introspectionEPKvRKNSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEESB_SB_i(i8* noundef %47, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %13, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %14, i32 noundef 25313)
          to label %54 unwind label %154

54:                                               ; preds = %52
  %55 = zext i1 %53 to i32
  %56 = load i8, i8* %6, align 1
  %57 = trunc i8 %56 to i1
  %58 = zext i1 %57 to i32
  %59 = and i32 %58, %55
  %60 = icmp ne i32 %59, 0
  %61 = zext i1 %60 to i8
  store i8 %61, i8* %6, align 1
  %62 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %14) #10
  %63 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %13) #10
  %64 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12) #10
  %65 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %5, align 8
  %66 = getelementptr inbounds %"struct.HalideIntrospectionCanary::A", %"struct.HalideIntrospectionCanary::A"* %65, i32 0, i32 1
  %67 = getelementptr inbounds %"class.HalideIntrospectionCanary::A::B", %"class.HalideIntrospectionCanary::A::B"* %66, i32 0, i32 2
  %68 = bitcast %"struct.HalideIntrospectionCanary::A"** %67 to i8*
  %69 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %15, i8* noundef getelementptr inbounds ([32 x i8], [32 x i8]* @.str.7, i64 0, i64 0))
  %70 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  invoke void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EERKS9_PKS6_(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %16, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %70, i8* noundef getelementptr inbounds ([12 x i8], [12 x i8]* @.str.8, i64 0, i64 0))
          to label %71 unwind label %163

71:                                               ; preds = %54
  %72 = invoke noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17, i8* noundef getelementptr inbounds ([73 x i8], [73 x i8]* @.str.4, i64 0, i64 0))
          to label %73 unwind label %167

73:                                               ; preds = %71
  %74 = invoke noundef zeroext i1 @_ZN6Halide8InternalL19check_introspectionEPKvRKNSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEESB_SB_i(i8* noundef %68, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %15, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %16, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17, i32 noundef 25314)
          to label %75 unwind label %171

75:                                               ; preds = %73
  %76 = zext i1 %74 to i32
  %77 = load i8, i8* %6, align 1
  %78 = trunc i8 %77 to i1
  %79 = zext i1 %78 to i32
  %80 = and i32 %79, %76
  %81 = icmp ne i32 %80, 0
  %82 = zext i1 %81 to i8
  store i8 %82, i8* %6, align 1
  %83 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  %84 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %16) #10
  %85 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %15) #10
  %86 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %5, align 8
  %87 = getelementptr inbounds %"struct.HalideIntrospectionCanary::A", %"struct.HalideIntrospectionCanary::A"* %86, i32 0, i32 1
  %88 = getelementptr inbounds %"class.HalideIntrospectionCanary::A::B", %"class.HalideIntrospectionCanary::A::B"* %87, i32 0, i32 1
  %89 = bitcast float* %88 to i8*
  %90 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %18, i8* noundef getelementptr inbounds ([6 x i8], [6 x i8]* @.str.9, i64 0, i64 0))
  %91 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  invoke void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EERKS9_PKS6_(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %19, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %91, i8* noundef getelementptr inbounds ([13 x i8], [13 x i8]* @.str.10, i64 0, i64 0))
          to label %92 unwind label %180

92:                                               ; preds = %75
  %93 = invoke noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %20, i8* noundef getelementptr inbounds ([73 x i8], [73 x i8]* @.str.4, i64 0, i64 0))
          to label %94 unwind label %184

94:                                               ; preds = %92
  %95 = invoke noundef zeroext i1 @_ZN6Halide8InternalL19check_introspectionEPKvRKNSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEESB_SB_i(i8* noundef %89, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %18, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %19, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %20, i32 noundef 25315)
          to label %96 unwind label %188

96:                                               ; preds = %94
  %97 = zext i1 %95 to i32
  %98 = load i8, i8* %6, align 1
  %99 = trunc i8 %98 to i1
  %100 = zext i1 %99 to i32
  %101 = and i32 %100, %97
  %102 = icmp ne i32 %101, 0
  %103 = zext i1 %102 to i8
  store i8 %103, i8* %6, align 1
  %104 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %20) #10
  %105 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %19) #10
  %106 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %18) #10
  %107 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %5, align 8
  %108 = getelementptr inbounds %"struct.HalideIntrospectionCanary::A", %"struct.HalideIntrospectionCanary::A"* %107, i32 0, i32 1
  %109 = getelementptr inbounds %"class.HalideIntrospectionCanary::A::B", %"class.HalideIntrospectionCanary::A::B"* %108, i32 0, i32 2
  %110 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %109, align 8
  %111 = bitcast %"struct.HalideIntrospectionCanary::A"* %110 to i8*
  %112 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %21, i8* noundef getelementptr inbounds ([29 x i8], [29 x i8]* @.str.11, i64 0, i64 0))
  %113 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %114 = invoke noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %22, i8* noundef getelementptr inbounds ([73 x i8], [73 x i8]* @.str.4, i64 0, i64 0))
          to label %115 unwind label %197

115:                                              ; preds = %96
  %116 = invoke noundef zeroext i1 @_ZN6Halide8InternalL19check_introspectionEPKvRKNSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEESB_SB_i(i8* noundef %111, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %21, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %113, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %22, i32 noundef 25316)
          to label %117 unwind label %201

117:                                              ; preds = %115
  %118 = zext i1 %116 to i32
  %119 = load i8, i8* %6, align 1
  %120 = trunc i8 %119 to i1
  %121 = zext i1 %120 to i32
  %122 = and i32 %121, %118
  %123 = icmp ne i32 %122, 0
  %124 = zext i1 %123 to i8
  store i8 %124, i8* %6, align 1
  %125 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %22) #10
  %126 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %21) #10
  %127 = load i8, i8* %6, align 1
  %128 = trunc i8 %127 to i1
  ret i1 %128

129:                                              ; preds = %2
  %130 = landingpad { i8*, i32 }
          cleanup
  %131 = extractvalue { i8*, i32 } %130, 0
  store i8* %131, i8** %9, align 8
  %132 = extractvalue { i8*, i32 } %130, 1
  store i32 %132, i32* %10, align 4
  br label %144

133:                                              ; preds = %30
  %134 = landingpad { i8*, i32 }
          cleanup
  %135 = extractvalue { i8*, i32 } %134, 0
  store i8* %135, i8** %9, align 8
  %136 = extractvalue { i8*, i32 } %134, 1
  store i32 %136, i32* %10, align 4
  br label %142

137:                                              ; preds = %32
  %138 = landingpad { i8*, i32 }
          cleanup
  %139 = extractvalue { i8*, i32 } %138, 0
  store i8* %139, i8** %9, align 8
  %140 = extractvalue { i8*, i32 } %138, 1
  store i32 %140, i32* %10, align 4
  %141 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11) #10
  br label %142

142:                                              ; preds = %137, %133
  %143 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %8) #10
  br label %144

144:                                              ; preds = %142, %129
  %145 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %7) #10
  br label %208

146:                                              ; preds = %34
  %147 = landingpad { i8*, i32 }
          cleanup
  %148 = extractvalue { i8*, i32 } %147, 0
  store i8* %148, i8** %9, align 8
  %149 = extractvalue { i8*, i32 } %147, 1
  store i32 %149, i32* %10, align 4
  br label %161

150:                                              ; preds = %50
  %151 = landingpad { i8*, i32 }
          cleanup
  %152 = extractvalue { i8*, i32 } %151, 0
  store i8* %152, i8** %9, align 8
  %153 = extractvalue { i8*, i32 } %151, 1
  store i32 %153, i32* %10, align 4
  br label %159

154:                                              ; preds = %52
  %155 = landingpad { i8*, i32 }
          cleanup
  %156 = extractvalue { i8*, i32 } %155, 0
  store i8* %156, i8** %9, align 8
  %157 = extractvalue { i8*, i32 } %155, 1
  store i32 %157, i32* %10, align 4
  %158 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %14) #10
  br label %159

159:                                              ; preds = %154, %150
  %160 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %13) #10
  br label %161

161:                                              ; preds = %159, %146
  %162 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12) #10
  br label %208

163:                                              ; preds = %54
  %164 = landingpad { i8*, i32 }
          cleanup
  %165 = extractvalue { i8*, i32 } %164, 0
  store i8* %165, i8** %9, align 8
  %166 = extractvalue { i8*, i32 } %164, 1
  store i32 %166, i32* %10, align 4
  br label %178

167:                                              ; preds = %71
  %168 = landingpad { i8*, i32 }
          cleanup
  %169 = extractvalue { i8*, i32 } %168, 0
  store i8* %169, i8** %9, align 8
  %170 = extractvalue { i8*, i32 } %168, 1
  store i32 %170, i32* %10, align 4
  br label %176

171:                                              ; preds = %73
  %172 = landingpad { i8*, i32 }
          cleanup
  %173 = extractvalue { i8*, i32 } %172, 0
  store i8* %173, i8** %9, align 8
  %174 = extractvalue { i8*, i32 } %172, 1
  store i32 %174, i32* %10, align 4
  %175 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  br label %176

176:                                              ; preds = %171, %167
  %177 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %16) #10
  br label %178

178:                                              ; preds = %176, %163
  %179 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %15) #10
  br label %208

180:                                              ; preds = %75
  %181 = landingpad { i8*, i32 }
          cleanup
  %182 = extractvalue { i8*, i32 } %181, 0
  store i8* %182, i8** %9, align 8
  %183 = extractvalue { i8*, i32 } %181, 1
  store i32 %183, i32* %10, align 4
  br label %195

184:                                              ; preds = %92
  %185 = landingpad { i8*, i32 }
          cleanup
  %186 = extractvalue { i8*, i32 } %185, 0
  store i8* %186, i8** %9, align 8
  %187 = extractvalue { i8*, i32 } %185, 1
  store i32 %187, i32* %10, align 4
  br label %193

188:                                              ; preds = %94
  %189 = landingpad { i8*, i32 }
          cleanup
  %190 = extractvalue { i8*, i32 } %189, 0
  store i8* %190, i8** %9, align 8
  %191 = extractvalue { i8*, i32 } %189, 1
  store i32 %191, i32* %10, align 4
  %192 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %20) #10
  br label %193

193:                                              ; preds = %188, %184
  %194 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %19) #10
  br label %195

195:                                              ; preds = %193, %180
  %196 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %18) #10
  br label %208

197:                                              ; preds = %96
  %198 = landingpad { i8*, i32 }
          cleanup
  %199 = extractvalue { i8*, i32 } %198, 0
  store i8* %199, i8** %9, align 8
  %200 = extractvalue { i8*, i32 } %198, 1
  store i32 %200, i32* %10, align 4
  br label %206

201:                                              ; preds = %115
  %202 = landingpad { i8*, i32 }
          cleanup
  %203 = extractvalue { i8*, i32 } %202, 0
  store i8* %203, i8** %9, align 8
  %204 = extractvalue { i8*, i32 } %202, 1
  store i32 %204, i32* %10, align 4
  %205 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %22) #10
  br label %206

206:                                              ; preds = %201, %197
  %207 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %21) #10
  br label %208

208:                                              ; preds = %206, %195, %178, %161, %144
  %209 = load i8*, i8** %9, align 8
  %210 = load i32, i32* %10, align 4
  %211 = insertvalue { i8*, i32 } undef, i8* %209, 0
  %212 = insertvalue { i8*, i32 } %211, i32 %210, 1
  resume { i8*, i32 } %212
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define internal void @_ZN25HalideIntrospectionCanaryL13offset_markerEv() #4 {
  %1 = call noundef nonnull align 8 dereferenceable(8) %"class.std::__1::basic_ostream"* @_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc(%"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) @_ZNSt3__14cerrE, i8* noundef getelementptr inbounds ([42 x i8], [42 x i8]* @.str.13, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"struct.HalideIntrospectionCanary::A"* @_ZN25HalideIntrospectionCanary1AC1Ev(%"struct.HalideIntrospectionCanary::A"* noundef nonnull returned align 8 dereferenceable(24) %0) unnamed_addr #1 align 2 {
  %2 = alloca %"struct.HalideIntrospectionCanary::A"*, align 8
  store %"struct.HalideIntrospectionCanary::A"* %0, %"struct.HalideIntrospectionCanary::A"** %2, align 8
  %3 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %2, align 8
  %4 = call noundef %"struct.HalideIntrospectionCanary::A"* @_ZN25HalideIntrospectionCanary1AC2Ev(%"struct.HalideIntrospectionCanary::A"* noundef nonnull align 8 dereferenceable(24) %3)
  ret %"struct.HalideIntrospectionCanary::A"* %3
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, i8* noundef %1) unnamed_addr #1 align 2 {
  %3 = alloca %"class.std::__1::basic_string"*, align 8
  %4 = alloca i8*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %5, i8* noundef %6)
  ret %"class.std::__1::basic_string"* %5
}

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24)) unnamed_addr #5

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"struct.HalideIntrospectionCanary::A"* @_ZN25HalideIntrospectionCanary1AC2Ev(%"struct.HalideIntrospectionCanary::A"* noundef nonnull returned align 8 dereferenceable(24) %0) unnamed_addr #1 align 2 {
  %2 = alloca %"struct.HalideIntrospectionCanary::A"*, align 8
  store %"struct.HalideIntrospectionCanary::A"* %0, %"struct.HalideIntrospectionCanary::A"** %2, align 8
  %3 = load %"struct.HalideIntrospectionCanary::A"*, %"struct.HalideIntrospectionCanary::A"** %2, align 8
  %4 = getelementptr inbounds %"struct.HalideIntrospectionCanary::A", %"struct.HalideIntrospectionCanary::A"* %3, i32 0, i32 1
  %5 = call noundef %"class.HalideIntrospectionCanary::A::B"* @_ZN25HalideIntrospectionCanary1A1BC1Ev(%"class.HalideIntrospectionCanary::A::B"* noundef nonnull align 8 dereferenceable(16) %4)
  %6 = getelementptr inbounds %"struct.HalideIntrospectionCanary::A", %"struct.HalideIntrospectionCanary::A"* %3, i32 0, i32 1
  %7 = getelementptr inbounds %"class.HalideIntrospectionCanary::A::B", %"class.HalideIntrospectionCanary::A::B"* %6, i32 0, i32 2
  store %"struct.HalideIntrospectionCanary::A"* %3, %"struct.HalideIntrospectionCanary::A"** %7, align 8
  ret %"struct.HalideIntrospectionCanary::A"* %3
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"class.HalideIntrospectionCanary::A::B"* @_ZN25HalideIntrospectionCanary1A1BC1Ev(%"class.HalideIntrospectionCanary::A::B"* noundef nonnull returned align 8 dereferenceable(16) %0) unnamed_addr #1 align 2 {
  %2 = alloca %"class.HalideIntrospectionCanary::A::B"*, align 8
  store %"class.HalideIntrospectionCanary::A::B"* %0, %"class.HalideIntrospectionCanary::A::B"** %2, align 8
  %3 = load %"class.HalideIntrospectionCanary::A::B"*, %"class.HalideIntrospectionCanary::A::B"** %2, align 8
  %4 = call noundef %"class.HalideIntrospectionCanary::A::B"* @_ZN25HalideIntrospectionCanary1A1BC2Ev(%"class.HalideIntrospectionCanary::A::B"* noundef nonnull align 8 dereferenceable(16) %3)
  ret %"class.HalideIntrospectionCanary::A::B"* %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr noundef %"class.HalideIntrospectionCanary::A::B"* @_ZN25HalideIntrospectionCanary1A1BC2Ev(%"class.HalideIntrospectionCanary::A::B"* noundef nonnull returned align 8 dereferenceable(16) %0) unnamed_addr #6 align 2 {
  %2 = alloca %"class.HalideIntrospectionCanary::A::B"*, align 8
  store %"class.HalideIntrospectionCanary::A::B"* %0, %"class.HalideIntrospectionCanary::A::B"** %2, align 8
  %3 = load %"class.HalideIntrospectionCanary::A::B"*, %"class.HalideIntrospectionCanary::A::B"** %2, align 8
  %4 = getelementptr inbounds %"class.HalideIntrospectionCanary::A::B", %"class.HalideIntrospectionCanary::A::B"* %3, i32 0, i32 0
  store i32 17, i32* %4, align 8
  %5 = getelementptr inbounds %"class.HalideIntrospectionCanary::A::B", %"class.HalideIntrospectionCanary::A::B"* %3, i32 0, i32 0
  %6 = load i32, i32* %5, align 8
  %7 = sitofp i32 %6 to float
  %8 = fmul float %7, 2.000000e+00
  %9 = getelementptr inbounds %"class.HalideIntrospectionCanary::A::B", %"class.HalideIntrospectionCanary::A::B"* %3, i32 0, i32 1
  store float %8, float* %9, align 4
  ret %"class.HalideIntrospectionCanary::A::B"* %3
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2IDnEEPKc(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, i8* noundef %1) unnamed_addr #1 align 2 {
  %3 = alloca %"class.std::__1::basic_string"*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca %"struct.std::__1::__default_init_tag", align 1
  %6 = alloca %"struct.std::__1::__default_init_tag", align 1
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %3, align 8
  store i8* %1, i8** %4, align 8
  %7 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %3, align 8
  %8 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %7, i32 0, i32 0
  %9 = call noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1INS_18__default_init_tagESA_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %8, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %5, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %6)
  %10 = load i8*, i8** %4, align 8
  %11 = load i8*, i8** %4, align 8
  %12 = call noundef i64 @_ZNSt3__111char_traitsIcE6lengthEPKc(i8* noundef %11) #10
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEPKcm(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %7, i8* noundef %10, i64 noundef %12)
  call void @_ZNSt3__119__debug_db_insert_cINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEEEvPT_(%"class.std::__1::basic_string"* noundef %7)
  ret %"class.std::__1::basic_string"* %7
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1INS_18__default_init_tagESA_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull returned align 8 dereferenceable(24) %0, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %1, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #1 align 2 {
  %4 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %5 = alloca %"struct.std::__1::__default_init_tag"*, align 8
  %6 = alloca %"struct.std::__1::__default_init_tag"*, align 8
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %4, align 8
  store %"struct.std::__1::__default_init_tag"* %1, %"struct.std::__1::__default_init_tag"** %5, align 8
  store %"struct.std::__1::__default_init_tag"* %2, %"struct.std::__1::__default_init_tag"** %6, align 8
  %7 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %4, align 8
  %8 = load %"struct.std::__1::__default_init_tag"*, %"struct.std::__1::__default_init_tag"** %5, align 8
  %9 = load %"struct.std::__1::__default_init_tag"*, %"struct.std::__1::__default_init_tag"** %6, align 8
  %10 = call noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2INS_18__default_init_tagESA_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %7, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %8, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %9)
  ret %"class.std::__1::__compressed_pair"* %7
}

declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEPKcm(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24), i8* noundef, i64 noundef) #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr noundef i64 @_ZNSt3__111char_traitsIcE6lengthEPKc(i8* noundef %0) #7 align 2 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call i64 @strlen(i8* noundef %3) #10
  ret i64 %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden void @_ZNSt3__119__debug_db_insert_cINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEEEvPT_(%"class.std::__1::basic_string"* noundef %0) #7 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2INS_18__default_init_tagESA_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull returned align 8 dereferenceable(24) %0, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %1, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #1 align 2 {
  %4 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %5 = alloca %"struct.std::__1::__default_init_tag"*, align 8
  %6 = alloca %"struct.std::__1::__default_init_tag"*, align 8
  %7 = alloca %"struct.std::__1::__default_init_tag", align 1
  %8 = alloca %"struct.std::__1::__default_init_tag", align 1
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %4, align 8
  store %"struct.std::__1::__default_init_tag"* %1, %"struct.std::__1::__default_init_tag"** %5, align 8
  store %"struct.std::__1::__default_init_tag"* %2, %"struct.std::__1::__default_init_tag"** %6, align 8
  %9 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %4, align 8
  %10 = bitcast %"class.std::__1::__compressed_pair"* %9 to %"struct.std::__1::__compressed_pair_elem"*
  %11 = load %"struct.std::__1::__default_init_tag"*, %"struct.std::__1::__default_init_tag"** %5, align 8
  %12 = call noundef nonnull align 1 dereferenceable(1) %"struct.std::__1::__default_init_tag"* @_ZNSt3__17forwardINS_18__default_init_tagEEEOT_RNS_16remove_referenceIS2_E4typeE(%"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %11) #10
  %13 = call noundef %"struct.std::__1::__compressed_pair_elem"* @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2ENS_18__default_init_tagE(%"struct.std::__1::__compressed_pair_elem"* noundef nonnull align 8 dereferenceable(24) %10)
  %14 = bitcast %"class.std::__1::__compressed_pair"* %9 to %"struct.std::__1::__compressed_pair_elem.0"*
  %15 = load %"struct.std::__1::__default_init_tag"*, %"struct.std::__1::__default_init_tag"** %6, align 8
  %16 = call noundef nonnull align 1 dereferenceable(1) %"struct.std::__1::__default_init_tag"* @_ZNSt3__17forwardINS_18__default_init_tagEEEOT_RNS_16remove_referenceIS2_E4typeE(%"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %15) #10
  %17 = call noundef %"struct.std::__1::__compressed_pair_elem.0"* @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2ENS_18__default_init_tagE(%"struct.std::__1::__compressed_pair_elem.0"* noundef nonnull align 1 dereferenceable(1) %14)
  ret %"class.std::__1::__compressed_pair"* %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) %"struct.std::__1::__default_init_tag"* @_ZNSt3__17forwardINS_18__default_init_tagEEEOT_RNS_16remove_referenceIS2_E4typeE(%"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %0) #7 {
  %2 = alloca %"struct.std::__1::__default_init_tag"*, align 8
  store %"struct.std::__1::__default_init_tag"* %0, %"struct.std::__1::__default_init_tag"** %2, align 8
  %3 = load %"struct.std::__1::__default_init_tag"*, %"struct.std::__1::__default_init_tag"** %2, align 8
  ret %"struct.std::__1::__default_init_tag"* %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"struct.std::__1::__compressed_pair_elem"* @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2ENS_18__default_init_tagE(%"struct.std::__1::__compressed_pair_elem"* noundef nonnull returned align 8 dereferenceable(24) %0) unnamed_addr #6 align 2 {
  %2 = alloca %"struct.std::__1::__default_init_tag", align 1
  %3 = alloca %"struct.std::__1::__compressed_pair_elem"*, align 8
  store %"struct.std::__1::__compressed_pair_elem"* %0, %"struct.std::__1::__compressed_pair_elem"** %3, align 8
  %4 = load %"struct.std::__1::__compressed_pair_elem"*, %"struct.std::__1::__compressed_pair_elem"** %3, align 8
  %5 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", %"struct.std::__1::__compressed_pair_elem"* %4, i32 0, i32 0
  ret %"struct.std::__1::__compressed_pair_elem"* %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"struct.std::__1::__compressed_pair_elem.0"* @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2ENS_18__default_init_tagE(%"struct.std::__1::__compressed_pair_elem.0"* noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #6 align 2 {
  %2 = alloca %"struct.std::__1::__default_init_tag", align 1
  %3 = alloca %"struct.std::__1::__compressed_pair_elem.0"*, align 8
  store %"struct.std::__1::__compressed_pair_elem.0"* %0, %"struct.std::__1::__compressed_pair_elem.0"** %3, align 8
  %4 = load %"struct.std::__1::__compressed_pair_elem.0"*, %"struct.std::__1::__compressed_pair_elem.0"** %3, align 8
  %5 = bitcast %"struct.std::__1::__compressed_pair_elem.0"* %4 to %"class.std::__1::allocator"*
  %6 = call noundef %"class.std::__1::allocator"* @_ZNSt3__19allocatorIcEC2Ev(%"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %5) #10
  ret %"struct.std::__1::__compressed_pair_elem.0"* %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::allocator"* @_ZNSt3__19allocatorIcEC2Ev(%"class.std::__1::allocator"* noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #6 align 2 {
  %2 = alloca %"class.std::__1::allocator"*, align 8
  store %"class.std::__1::allocator"* %0, %"class.std::__1::allocator"** %2, align 8
  %3 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %2, align 8
  %4 = bitcast %"class.std::__1::allocator"* %3 to %"struct.std::__1::__non_trivial_if"*
  %5 = call noundef %"struct.std::__1::__non_trivial_if"* @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2Ev(%"struct.std::__1::__non_trivial_if"* noundef nonnull align 1 dereferenceable(1) %4) #10
  ret %"class.std::__1::allocator"* %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"struct.std::__1::__non_trivial_if"* @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2Ev(%"struct.std::__1::__non_trivial_if"* noundef nonnull returned align 1 dereferenceable(1) %0) unnamed_addr #6 align 2 {
  %2 = alloca %"struct.std::__1::__non_trivial_if"*, align 8
  store %"struct.std::__1::__non_trivial_if"* %0, %"struct.std::__1::__non_trivial_if"** %2, align 8
  %3 = load %"struct.std::__1::__non_trivial_if"*, %"struct.std::__1::__non_trivial_if"** %2, align 8
  ret %"struct.std::__1::__non_trivial_if"* %3
}

; Function Attrs: nounwind
declare i64 @strlen(i8* noundef) #5

; Function Attrs: mustprogress noinline optnone ssp uwtable
define internal noundef zeroext i1 @_ZN6Halide8InternalL19check_introspectionEPKvRKNSt3__112basic_stringIcNS3_11char_traitsIcEENS3_9allocatorIcEEEESB_SB_i(i8* noundef %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %2, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3, i32 noundef %4) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %6 = alloca i8*, align 8
  %7 = alloca %"class.std::__1::basic_string"*, align 8
  %8 = alloca %"class.std::__1::basic_string"*, align 8
  %9 = alloca %"class.std::__1::basic_string"*, align 8
  %10 = alloca i32, align 4
  %11 = alloca %"class.std::__1::basic_string", align 8
  %12 = alloca %"class.std::__1::basic_string", align 8
  %13 = alloca %"class.std::__1::basic_string", align 8
  %14 = alloca i8*, align 8
  %15 = alloca i32, align 4
  %16 = alloca %"class.std::__1::basic_string", align 8
  %17 = alloca %"class.std::__1::basic_string", align 8
  store i8* %0, i8** %6, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %7, align 8
  store %"class.std::__1::basic_string"* %2, %"class.std::__1::basic_string"** %8, align 8
  store %"class.std::__1::basic_string"* %3, %"class.std::__1::basic_string"** %9, align 8
  store i32 %4, i32* %10, align 4
  %18 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %9, align 8
  call void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EERKS9_PKS6_(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %12, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %18, i8* noundef getelementptr inbounds ([2 x i8], [2 x i8]* @.str.12, i64 0, i64 0))
  %19 = load i32, i32* %10, align 4
  invoke void @_ZNSt3__19to_stringEi(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %13, i32 noundef %19)
          to label %20 unwind label %37

20:                                               ; preds = %5
  invoke void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EEOS9_SA_(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %11, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %13)
          to label %21 unwind label %41

21:                                               ; preds = %20
  %22 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %13) #10
  %23 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12) #10
  invoke void @_ZN6Halide8Internal13Introspection19get_source_locationEv(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %16)
          to label %24 unwind label %48

24:                                               ; preds = %21
  %25 = load i8*, i8** %6, align 8
  %26 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %7, align 8
  invoke void @_ZN6Halide8Internal13Introspection17get_variable_nameEPKvRKNSt3__112basic_stringIcNS4_11char_traitsIcEENS4_9allocatorIcEEEE(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8 %17, i8* noundef %25, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %26)
          to label %27 unwind label %52

27:                                               ; preds = %24
  %28 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %8, align 8
  %29 = call noundef zeroext i1 @_ZNSt3__1eqINS_9allocatorIcEEEEbRKNS_12basic_stringIcNS_11char_traitsIcEET_EES9_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %28) #10
  br i1 %29, label %30, label %32

30:                                               ; preds = %27
  %31 = call noundef zeroext i1 @_ZNSt3__1eqINS_9allocatorIcEEEEbRKNS_12basic_stringIcNS_11char_traitsIcEET_EES9_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %16, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11) #10
  br label %32

32:                                               ; preds = %30, %27
  %33 = phi i1 [ false, %27 ], [ %31, %30 ]
  %34 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  %35 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %16) #10
  %36 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11) #10
  ret i1 %33

37:                                               ; preds = %5
  %38 = landingpad { i8*, i32 }
          cleanup
  %39 = extractvalue { i8*, i32 } %38, 0
  store i8* %39, i8** %14, align 8
  %40 = extractvalue { i8*, i32 } %38, 1
  store i32 %40, i32* %15, align 4
  br label %46

41:                                               ; preds = %20
  %42 = landingpad { i8*, i32 }
          cleanup
  %43 = extractvalue { i8*, i32 } %42, 0
  store i8* %43, i8** %14, align 8
  %44 = extractvalue { i8*, i32 } %42, 1
  store i32 %44, i32* %15, align 4
  %45 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %13) #10
  br label %46

46:                                               ; preds = %41, %37
  %47 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12) #10
  br label %59

48:                                               ; preds = %21
  %49 = landingpad { i8*, i32 }
          cleanup
  %50 = extractvalue { i8*, i32 } %49, 0
  store i8* %50, i8** %14, align 8
  %51 = extractvalue { i8*, i32 } %49, 1
  store i32 %51, i32* %15, align 4
  br label %57

52:                                               ; preds = %24
  %53 = landingpad { i8*, i32 }
          cleanup
  %54 = extractvalue { i8*, i32 } %53, 0
  store i8* %54, i8** %14, align 8
  %55 = extractvalue { i8*, i32 } %53, 1
  store i32 %55, i32* %15, align 4
  %56 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %16) #10
  br label %57

57:                                               ; preds = %52, %48
  %58 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11) #10
  br label %59

59:                                               ; preds = %57, %46
  %60 = load i8*, i8** %14, align 8
  %61 = load i32, i32* %15, align 4
  %62 = insertvalue { i8*, i32 } undef, i8* %60, 0
  %63 = insertvalue { i8*, i32 } %62, i32 %61, 1
  resume { i8*, i32 } %63
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EERKS9_PKS6_(%"class.std::__1::basic_string"* noalias sret(%"class.std::__1::basic_string") align 8 %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1, i8* noundef %2) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca i8*, align 8
  %5 = alloca %"class.std::__1::basic_string"*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i1, align 1
  %8 = alloca %"class.std::__1::allocator", align 1
  %9 = alloca %"class.std::__1::allocator", align 1
  %10 = alloca i64, align 8
  %11 = alloca i64, align 8
  %12 = alloca i8*, align 8
  %13 = alloca i32, align 4
  %14 = bitcast %"class.std::__1::basic_string"* %0 to i8*
  store i8* %14, i8** %4, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %5, align 8
  store i8* %2, i8** %6, align 8
  store i1 false, i1* %7, align 1
  %15 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %5, align 8
  call void @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13get_allocatorEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %15) #10
  %16 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS4_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %8) #10
  %17 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %5, align 8
  %18 = call noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  store i64 %18, i64* %10, align 8
  %19 = load i8*, i8** %6, align 8
  %20 = call noundef i64 @_ZNSt3__111char_traitsIcE6lengthEPKc(i8* noundef %19) #10
  store i64 %20, i64* %11, align 8
  %21 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %5, align 8
  %22 = call noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %21) #10
  %23 = load i64, i64* %10, align 8
  %24 = load i64, i64* %10, align 8
  %25 = load i64, i64* %11, align 8
  %26 = add i64 %24, %25
  invoke void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEPKcmm(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0, i8* noundef %22, i64 noundef %23, i64 noundef %26)
          to label %27 unwind label %33

27:                                               ; preds = %3
  %28 = load i8*, i8** %6, align 8
  %29 = load i64, i64* %11, align 8
  %30 = invoke noundef nonnull align 8 dereferenceable(24) %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0, i8* noundef %28, i64 noundef %29)
          to label %31 unwind label %33

31:                                               ; preds = %27
  store i1 true, i1* %7, align 1
  %32 = load i1, i1* %7, align 1
  br i1 %32, label %40, label %38

33:                                               ; preds = %27, %3
  %34 = landingpad { i8*, i32 }
          cleanup
  %35 = extractvalue { i8*, i32 } %34, 0
  store i8* %35, i8** %12, align 8
  %36 = extractvalue { i8*, i32 } %34, 1
  store i32 %36, i32* %13, align 4
  %37 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #10
  br label %41

38:                                               ; preds = %31
  %39 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #10
  br label %40

40:                                               ; preds = %38, %31
  ret void

41:                                               ; preds = %33
  %42 = load i8*, i8** %12, align 8
  %43 = load i32, i32* %13, align 4
  %44 = insertvalue { i8*, i32 } undef, i8* %42, 0
  %45 = insertvalue { i8*, i32 } %44, i32 %43, 1
  resume { i8*, i32 } %45
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden void @_ZNSt3__1plIcNS_11char_traitsIcEENS_9allocatorIcEEEENS_12basic_stringIT_T0_T1_EEOS9_SA_(%"class.std::__1::basic_string"* noalias sret(%"class.std::__1::basic_string") align 8 %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %2) #4 {
  %4 = alloca i8*, align 8
  %5 = alloca %"class.std::__1::basic_string"*, align 8
  %6 = alloca %"class.std::__1::basic_string"*, align 8
  %7 = bitcast %"class.std::__1::basic_string"* %0 to i8*
  store i8* %7, i8** %4, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %5, align 8
  store %"class.std::__1::basic_string"* %2, %"class.std::__1::basic_string"** %6, align 8
  %8 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %5, align 8
  %9 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %6, align 8
  %10 = call noundef nonnull align 8 dereferenceable(24) %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendERKS5_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %8, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %9)
  %11 = call noundef nonnull align 8 dereferenceable(24) %"class.std::__1::basic_string"* @_ZNSt3__14moveIRNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEEEONS_16remove_referenceIT_E4typeEOS9_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %10) #10
  %12 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1EOS5_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %11) #10
  ret void
}

declare void @_ZNSt3__19to_stringEi(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8, i32 noundef) #3

declare void @_ZN6Halide8Internal13Introspection19get_source_locationEv(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8) #3

declare void @_ZN6Halide8Internal13Introspection17get_variable_nameEPKvRKNSt3__112basic_stringIcNS4_11char_traitsIcEENS4_9allocatorIcEEEE(%"class.std::__1::basic_string"* sret(%"class.std::__1::basic_string") align 8, i8* noundef, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24)) #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef zeroext i1 @_ZNSt3__1eqINS_9allocatorIcEEEEbRKNS_12basic_stringIcNS_11char_traitsIcEET_EES9_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1) #7 {
  %3 = alloca i1, align 1
  %4 = alloca %"class.std::__1::basic_string"*, align 8
  %5 = alloca %"class.std::__1::basic_string"*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %4, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %5, align 8
  %9 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %10 = call noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %9) #10
  store i64 %10, i64* %6, align 8
  %11 = load i64, i64* %6, align 8
  %12 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %5, align 8
  %13 = call noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12) #10
  %14 = icmp ne i64 %11, %13
  br i1 %14, label %15, label %16

15:                                               ; preds = %2
  store i1 false, i1* %3, align 1
  br label %51

16:                                               ; preds = %2
  %17 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %18 = call noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  store i8* %18, i8** %7, align 8
  %19 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %5, align 8
  %20 = call noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %19) #10
  store i8* %20, i8** %8, align 8
  %21 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %22 = call noundef zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %21) #10
  br i1 %22, label %23, label %29

23:                                               ; preds = %16
  %24 = load i8*, i8** %7, align 8
  %25 = load i8*, i8** %8, align 8
  %26 = load i64, i64* %6, align 8
  %27 = call noundef i32 @_ZNSt3__111char_traitsIcE7compareEPKcS3_m(i8* noundef %24, i8* noundef %25, i64 noundef %26) #10
  %28 = icmp eq i32 %27, 0
  store i1 %28, i1* %3, align 1
  br label %51

29:                                               ; preds = %16
  br label %30

30:                                               ; preds = %43, %29
  %31 = load i64, i64* %6, align 8
  %32 = icmp ne i64 %31, 0
  br i1 %32, label %33, label %50

33:                                               ; preds = %30
  %34 = load i8*, i8** %7, align 8
  %35 = load i8, i8* %34, align 1
  %36 = sext i8 %35 to i32
  %37 = load i8*, i8** %8, align 8
  %38 = load i8, i8* %37, align 1
  %39 = sext i8 %38 to i32
  %40 = icmp ne i32 %36, %39
  br i1 %40, label %41, label %42

41:                                               ; preds = %33
  store i1 false, i1* %3, align 1
  br label %51

42:                                               ; preds = %33
  br label %43

43:                                               ; preds = %42
  %44 = load i64, i64* %6, align 8
  %45 = add i64 %44, -1
  store i64 %45, i64* %6, align 8
  %46 = load i8*, i8** %7, align 8
  %47 = getelementptr inbounds i8, i8* %46, i32 1
  store i8* %47, i8** %7, align 8
  %48 = load i8*, i8** %8, align 8
  %49 = getelementptr inbounds i8, i8* %48, i32 1
  store i8* %49, i8** %8, align 8
  br label %30, !llvm.loop !9

50:                                               ; preds = %30
  store i1 true, i1* %3, align 1
  br label %51

51:                                               ; preds = %50, %41, %23, %15
  %52 = load i1, i1* %3, align 1
  ret i1 %52
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) %"class.std::__1::basic_string"* @_ZNSt3__14moveIRNS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEEEONS_16remove_referenceIT_E4typeEOS9_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  ret %"class.std::__1::basic_string"* %3
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendERKS5_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1) #4 align 2 {
  %3 = alloca %"class.std::__1::basic_string"*, align 8
  %4 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %3, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %4, align 8
  %5 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %3, align 8
  %6 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %7 = call noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %6) #10
  %8 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %9 = call noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %8) #10
  %10 = call noundef nonnull align 8 dereferenceable(24) %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %5, i8* noundef %7, i64 noundef %9)
  ret %"class.std::__1::basic_string"* %10
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1EOS5_(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1) unnamed_addr #6 align 2 {
  %3 = alloca %"class.std::__1::basic_string"*, align 8
  %4 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %3, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %4, align 8
  %5 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %3, align 8
  %6 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %7 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2EOS5_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %5, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %6) #10
  ret %"class.std::__1::basic_string"* %5
}

declare noundef nonnull align 8 dereferenceable(24) %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6appendEPKcm(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24), i8* noundef, i64 noundef) #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = call noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  %5 = call noundef i8* @_ZNSt3__112__to_addressIKcEEPT_S3_(i8* noundef %4) #10
  ret i8* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = call noundef zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__get_long_sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br label %9

7:                                                ; preds = %1
  %8 = call noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__get_short_sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi i64 [ %6, %5 ], [ %8, %7 ]
  ret i64 %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__112__to_addressIKcEEPT_S3_(i8* noundef %0) #7 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  ret i8* %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = call noundef zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br label %9

7:                                                ; preds = %1
  %8 = call noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi i8* [ %6, %5 ], [ %8, %7 ]
  ret i8* %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to %"struct.std::__1::basic_string<char>::__short"*
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", %"struct.std::__1::basic_string<char>::__short"* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.anon, %struct.anon* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 1
  %11 = zext i8 %10 to i64
  %12 = and i64 %11, 128
  %13 = icmp ne i64 %12, 0
  ret i1 %13
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to %"struct.std::__1::basic_string<char>::__long"*
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", %"struct.std::__1::basic_string<char>::__long"* %7, i32 0, i32 0
  %9 = load i8*, i8** %8, align 8
  ret i8* %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to %"struct.std::__1::basic_string<char>::__short"*
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", %"struct.std::__1::basic_string<char>::__short"* %7, i32 0, i32 0
  %9 = getelementptr inbounds [23 x i8], [23 x i8]* %8, i64 0, i64 0
  %10 = call noundef i8* @_ZNSt3__114pointer_traitsIPKcE10pointer_toERS1_(i8* noundef nonnull align 1 dereferenceable(1) %9) #10
  ret i8* %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::__compressed_pair"*, align 8
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %2, align 8
  %3 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %2, align 8
  %4 = bitcast %"class.std::__1::__compressed_pair"* %3 to %"struct.std::__1::__compressed_pair_elem"*
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getEv(%"struct.std::__1::__compressed_pair_elem"* noundef nonnull align 8 dereferenceable(24) %4) #10
  ret %"struct.std::__1::basic_string<char>::__rep"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getEv(%"struct.std::__1::__compressed_pair_elem"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"struct.std::__1::__compressed_pair_elem"*, align 8
  store %"struct.std::__1::__compressed_pair_elem"* %0, %"struct.std::__1::__compressed_pair_elem"** %2, align 8
  %3 = load %"struct.std::__1::__compressed_pair_elem"*, %"struct.std::__1::__compressed_pair_elem"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", %"struct.std::__1::__compressed_pair_elem"* %3, i32 0, i32 0
  ret %"struct.std::__1::basic_string<char>::__rep"* %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__114pointer_traitsIPKcE10pointer_toERS1_(i8* noundef nonnull align 1 dereferenceable(1) %0) #7 align 2 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call noundef i8* @_ZNSt3__19addressofIKcEEPT_RS2_(i8* noundef nonnull align 1 dereferenceable(1) %3) #10
  ret i8* %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__19addressofIKcEEPT_RS2_(i8* noundef nonnull align 1 dereferenceable(1) %0) #7 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  ret i8* %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE15__get_long_sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to %"struct.std::__1::basic_string<char>::__long"*
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", %"struct.std::__1::basic_string<char>::__long"* %7, i32 0, i32 1
  %9 = load i64, i64* %8, align 8
  ret i64 %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i64 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE16__get_short_sizeEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to %"struct.std::__1::basic_string<char>::__short"*
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", %"struct.std::__1::basic_string<char>::__short"* %7, i32 0, i32 1
  %9 = getelementptr inbounds %struct.anon, %struct.anon* %8, i32 0, i32 0
  %10 = load i8, i8* %9, align 1
  %11 = zext i8 %10 to i64
  ret i64 %11
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2EOS5_(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, %"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %1) unnamed_addr #6 align 2 {
  %3 = alloca %"class.std::__1::basic_string"*, align 8
  %4 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %3, align 8
  store %"class.std::__1::basic_string"* %1, %"class.std::__1::basic_string"** %4, align 8
  %5 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %5, i32 0, i32 0
  %7 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %8 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %7, i32 0, i32 0
  %9 = call noundef nonnull align 8 dereferenceable(24) %"class.std::__1::__compressed_pair"* @_ZNSt3__14moveIRNS_17__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES6_EEEEONS_16remove_referenceIT_E4typeEOSC_(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %8) #10
  %10 = bitcast %"class.std::__1::__compressed_pair"* %6 to i8*
  %11 = bitcast %"class.std::__1::__compressed_pair"* %9 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %10, i8* align 8 %11, i64 24, i1 false)
  %12 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__zeroEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %12) #10
  call void @_ZNSt3__119__debug_db_insert_cINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEEEvPT_(%"class.std::__1::basic_string"* noundef %5)
  ret %"class.std::__1::basic_string"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) %"class.std::__1::__compressed_pair"* @_ZNSt3__14moveIRNS_17__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES6_EEEEONS_16remove_referenceIT_E4typeEOSC_(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %0) #7 {
  %2 = alloca %"class.std::__1::__compressed_pair"*, align 8
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %2, align 8
  %3 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %2, align 8
  ret %"class.std::__1::__compressed_pair"* %3
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #8

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__zeroEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  %3 = alloca [3 x i64]*, align 8
  %4 = alloca i32, align 4
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %5 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %6 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %5, i32 0, i32 0
  %7 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %6) #10
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %7, i32 0, i32 0
  %9 = bitcast %union.anon* %8 to %"struct.std::__1::basic_string<char>::__raw"*
  %10 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__raw", %"struct.std::__1::basic_string<char>::__raw"* %9, i32 0, i32 0
  store [3 x i64]* %10, [3 x i64]** %3, align 8
  store i32 0, i32* %4, align 4
  br label %11

11:                                               ; preds = %19, %1
  %12 = load i32, i32* %4, align 4
  %13 = icmp ult i32 %12, 3
  br i1 %13, label %14, label %22

14:                                               ; preds = %11
  %15 = load [3 x i64]*, [3 x i64]** %3, align 8
  %16 = load i32, i32* %4, align 4
  %17 = zext i32 %16 to i64
  %18 = getelementptr inbounds [3 x i64], [3 x i64]* %15, i64 0, i64 %17
  store i64 0, i64* %18, align 8
  br label %19

19:                                               ; preds = %14
  %20 = load i32, i32* %4, align 4
  %21 = add i32 %20, 1
  store i32 %21, i32* %4, align 4
  br label %11, !llvm.loop !11

22:                                               ; preds = %11
  ret void
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::__compressed_pair"*, align 8
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %2, align 8
  %3 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %2, align 8
  %4 = bitcast %"class.std::__1::__compressed_pair"* %3 to %"struct.std::__1::__compressed_pair_elem"*
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getEv(%"struct.std::__1::__compressed_pair_elem"* noundef nonnull align 8 dereferenceable(24) %4) #10
  ret %"struct.std::__1::basic_string<char>::__rep"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getEv(%"struct.std::__1::__compressed_pair_elem"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"struct.std::__1::__compressed_pair_elem"*, align 8
  store %"struct.std::__1::__compressed_pair_elem"* %0, %"struct.std::__1::__compressed_pair_elem"** %2, align 8
  %3 = load %"struct.std::__1::__compressed_pair_elem"*, %"struct.std::__1::__compressed_pair_elem"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::__1::__compressed_pair_elem", %"struct.std::__1::__compressed_pair_elem"* %3, i32 0, i32 0
  ret %"struct.std::__1::basic_string<char>::__rep"* %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr noundef i32 @_ZNSt3__111char_traitsIcE7compareEPKcS3_m(i8* noundef %0, i8* noundef %1, i64 noundef %2) #7 align 2 {
  %4 = alloca i32, align 4
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i64 %2, i64* %7, align 8
  %8 = load i64, i64* %7, align 8
  %9 = icmp eq i64 %8, 0
  br i1 %9, label %10, label %11

10:                                               ; preds = %3
  store i32 0, i32* %4, align 4
  br label %16

11:                                               ; preds = %3
  %12 = load i8*, i8** %5, align 8
  %13 = load i8*, i8** %6, align 8
  %14 = load i64, i64* %7, align 8
  %15 = call i32 @memcmp(i8* noundef %12, i8* noundef %13, i64 noundef %14) #10
  store i32 %15, i32* %4, align 4
  br label %16

16:                                               ; preds = %11, %10
  %17 = load i32, i32* %4, align 4
  ret i32 %17
}

; Function Attrs: nounwind
declare i32 @memcmp(i8* noundef, i8* noundef, i64 noundef) #5

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden void @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13get_allocatorEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = call noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7__allocEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1ERKS4_(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %1) unnamed_addr #6 align 2 {
  %3 = alloca %"class.std::__1::basic_string"*, align 8
  %4 = alloca %"class.std::__1::allocator"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %3, align 8
  store %"class.std::__1::allocator"* %1, %"class.std::__1::allocator"** %4, align 8
  %5 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %3, align 8
  %6 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %4, align 8
  %7 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS4_(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %5, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %6) #10
  ret %"class.std::__1::basic_string"* %5
}

declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEPKcmm(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24), i8* noundef, i64 noundef, i64 noundef) #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE7__allocEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E6secondEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  ret %"class.std::__1::allocator"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E6secondEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::__compressed_pair"*, align 8
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %2, align 8
  %3 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %2, align 8
  %4 = bitcast %"class.std::__1::__compressed_pair"* %3 to %"struct.std::__1::__compressed_pair_elem.0"*
  %5 = call noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNKSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EE5__getEv(%"struct.std::__1::__compressed_pair_elem.0"* noundef nonnull align 1 dereferenceable(1) %4) #10
  ret %"class.std::__1::allocator"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNKSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EE5__getEv(%"struct.std::__1::__compressed_pair_elem.0"* noundef nonnull align 1 dereferenceable(1) %0) #7 align 2 {
  %2 = alloca %"struct.std::__1::__compressed_pair_elem.0"*, align 8
  store %"struct.std::__1::__compressed_pair_elem.0"* %0, %"struct.std::__1::__compressed_pair_elem.0"** %2, align 8
  %3 = load %"struct.std::__1::__compressed_pair_elem.0"*, %"struct.std::__1::__compressed_pair_elem.0"** %2, align 8
  %4 = bitcast %"struct.std::__1::__compressed_pair_elem.0"* %3 to %"class.std::__1::allocator"*
  ret %"class.std::__1::allocator"* %4
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2ERKS4_(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %1) unnamed_addr #6 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::__1::basic_string"*, align 8
  %4 = alloca %"class.std::__1::allocator"*, align 8
  %5 = alloca %"struct.std::__1::__default_init_tag", align 1
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %3, align 8
  store %"class.std::__1::allocator"* %1, %"class.std::__1::allocator"** %4, align 8
  %6 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %3, align 8
  %7 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %6, i32 0, i32 0
  %8 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %4, align 8
  %9 = invoke noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1INS_18__default_init_tagERKS5_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %7, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %5, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %8)
          to label %10 unwind label %11

10:                                               ; preds = %2
  call void @_ZNSt3__119__debug_db_insert_cINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEEEvPT_(%"class.std::__1::basic_string"* noundef %6)
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__zeroEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %6) #10
  ret %"class.std::__1::basic_string"* %6

11:                                               ; preds = %2
  %12 = landingpad { i8*, i32 }
          catch i8* null
  %13 = extractvalue { i8*, i32 } %12, 0
  call void @__clang_call_terminate(i8* %13) #11
  unreachable
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1INS_18__default_init_tagERKS5_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull returned align 8 dereferenceable(24) %0, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %1, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #1 align 2 {
  %4 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %5 = alloca %"struct.std::__1::__default_init_tag"*, align 8
  %6 = alloca %"class.std::__1::allocator"*, align 8
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %4, align 8
  store %"struct.std::__1::__default_init_tag"* %1, %"struct.std::__1::__default_init_tag"** %5, align 8
  store %"class.std::__1::allocator"* %2, %"class.std::__1::allocator"** %6, align 8
  %7 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %4, align 8
  %8 = load %"struct.std::__1::__default_init_tag"*, %"struct.std::__1::__default_init_tag"** %5, align 8
  %9 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %6, align 8
  %10 = call noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2INS_18__default_init_tagERKS5_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %7, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %8, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %9)
  ret %"class.std::__1::__compressed_pair"* %7
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8* %0) #9 {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #10
  call void @_ZSt9terminatev() #11
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2INS_18__default_init_tagERKS5_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull returned align 8 dereferenceable(24) %0, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %1, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %2) unnamed_addr #1 align 2 {
  %4 = alloca %"class.std::__1::__compressed_pair"*, align 8
  %5 = alloca %"struct.std::__1::__default_init_tag"*, align 8
  %6 = alloca %"class.std::__1::allocator"*, align 8
  %7 = alloca %"struct.std::__1::__default_init_tag", align 1
  store %"class.std::__1::__compressed_pair"* %0, %"class.std::__1::__compressed_pair"** %4, align 8
  store %"struct.std::__1::__default_init_tag"* %1, %"struct.std::__1::__default_init_tag"** %5, align 8
  store %"class.std::__1::allocator"* %2, %"class.std::__1::allocator"** %6, align 8
  %8 = load %"class.std::__1::__compressed_pair"*, %"class.std::__1::__compressed_pair"** %4, align 8
  %9 = bitcast %"class.std::__1::__compressed_pair"* %8 to %"struct.std::__1::__compressed_pair_elem"*
  %10 = load %"struct.std::__1::__default_init_tag"*, %"struct.std::__1::__default_init_tag"** %5, align 8
  %11 = call noundef nonnull align 1 dereferenceable(1) %"struct.std::__1::__default_init_tag"* @_ZNSt3__17forwardINS_18__default_init_tagEEEOT_RNS_16remove_referenceIS2_E4typeE(%"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %10) #10
  %12 = call noundef %"struct.std::__1::__compressed_pair_elem"* @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2ENS_18__default_init_tagE(%"struct.std::__1::__compressed_pair_elem"* noundef nonnull align 8 dereferenceable(24) %9)
  %13 = bitcast %"class.std::__1::__compressed_pair"* %8 to %"struct.std::__1::__compressed_pair_elem.0"*
  %14 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %6, align 8
  %15 = call noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNSt3__17forwardIRKNS_9allocatorIcEEEEOT_RNS_16remove_referenceIS5_E4typeE(%"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %14) #10
  %16 = call noundef %"struct.std::__1::__compressed_pair_elem.0"* @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2IRKS2_vEEOT_(%"struct.std::__1::__compressed_pair_elem.0"* noundef nonnull align 1 dereferenceable(1) %13, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %15)
  ret %"class.std::__1::__compressed_pair"* %8
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNSt3__17forwardIRKNS_9allocatorIcEEEEOT_RNS_16remove_referenceIS5_E4typeE(%"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %0) #7 {
  %2 = alloca %"class.std::__1::allocator"*, align 8
  store %"class.std::__1::allocator"* %0, %"class.std::__1::allocator"** %2, align 8
  %3 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %2, align 8
  ret %"class.std::__1::allocator"* %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr noundef %"struct.std::__1::__compressed_pair_elem.0"* @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2IRKS2_vEEOT_(%"struct.std::__1::__compressed_pair_elem.0"* noundef nonnull returned align 1 dereferenceable(1) %0, %"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %1) unnamed_addr #6 align 2 {
  %3 = alloca %"struct.std::__1::__compressed_pair_elem.0"*, align 8
  %4 = alloca %"class.std::__1::allocator"*, align 8
  store %"struct.std::__1::__compressed_pair_elem.0"* %0, %"struct.std::__1::__compressed_pair_elem.0"** %3, align 8
  store %"class.std::__1::allocator"* %1, %"class.std::__1::allocator"** %4, align 8
  %5 = load %"struct.std::__1::__compressed_pair_elem.0"*, %"struct.std::__1::__compressed_pair_elem.0"** %3, align 8
  %6 = bitcast %"struct.std::__1::__compressed_pair_elem.0"* %5 to %"class.std::__1::allocator"*
  %7 = load %"class.std::__1::allocator"*, %"class.std::__1::allocator"** %4, align 8
  %8 = call noundef nonnull align 1 dereferenceable(1) %"class.std::__1::allocator"* @_ZNSt3__17forwardIRKNS_9allocatorIcEEEEOT_RNS_16remove_referenceIS5_E4typeE(%"class.std::__1::allocator"* noundef nonnull align 1 dereferenceable(1) %7) #10
  ret %"struct.std::__1::__compressed_pair_elem.0"* %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr noundef nonnull align 8 dereferenceable(8) %"class.std::__1::basic_ostream"* @_ZNSt3__1lsINS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc(%"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %0, i8* noundef %1) #4 {
  %3 = alloca %"class.std::__1::basic_ostream"*, align 8
  %4 = alloca i8*, align 8
  store %"class.std::__1::basic_ostream"* %0, %"class.std::__1::basic_ostream"** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = load i8*, i8** %4, align 8
  %8 = call noundef i64 @_ZNSt3__111char_traitsIcE6lengthEPKc(i8* noundef %7) #10
  %9 = call noundef nonnull align 8 dereferenceable(8) %"class.std::__1::basic_ostream"* @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(%"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %5, i8* noundef %6, i64 noundef %8)
  ret %"class.std::__1::basic_ostream"* %9
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr noundef nonnull align 8 dereferenceable(8) %"class.std::__1::basic_ostream"* @_ZNSt3__124__put_character_sequenceIcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m(%"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %0, i8* noundef %1, i64 noundef %2) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %4 = alloca %"class.std::__1::basic_ostream"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca %"class.std::__1::basic_ostream<char>::sentry", align 8
  %8 = alloca i8*, align 8
  %9 = alloca i32, align 4
  %10 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %11 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  store %"class.std::__1::basic_ostream"* %0, %"class.std::__1::basic_ostream"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i64 %2, i64* %6, align 8
  %12 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %13 = invoke noundef %"class.std::__1::basic_ostream<char>::sentry"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(%"class.std::__1::basic_ostream<char>::sentry"* noundef nonnull align 8 dereferenceable(16) %7, %"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %12)
          to label %14 unwind label %84

14:                                               ; preds = %3
  %15 = invoke noundef zeroext i1 @_ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbEv(%"class.std::__1::basic_ostream<char>::sentry"* noundef nonnull align 8 dereferenceable(16) %7)
          to label %16 unwind label %88

16:                                               ; preds = %14
  br i1 %15, label %17, label %109

17:                                               ; preds = %16
  %18 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %19 = call noundef %"class.std::__1::ostreambuf_iterator"* @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1ERNS_13basic_ostreamIcS2_EE(%"class.std::__1::ostreambuf_iterator"* noundef nonnull align 8 dereferenceable(8) %11, %"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %18) #10
  %20 = load i8*, i8** %5, align 8
  %21 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %22 = bitcast %"class.std::__1::basic_ostream"* %21 to i8**
  %23 = load i8*, i8** %22, align 8
  %24 = getelementptr i8, i8* %23, i64 -24
  %25 = bitcast i8* %24 to i64*
  %26 = load i64, i64* %25, align 8
  %27 = bitcast %"class.std::__1::basic_ostream"* %21 to i8*
  %28 = getelementptr inbounds i8, i8* %27, i64 %26
  %29 = bitcast i8* %28 to %"class.std::__1::ios_base"*
  %30 = invoke noundef i32 @_ZNKSt3__18ios_base5flagsEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %29)
          to label %31 unwind label %88

31:                                               ; preds = %17
  %32 = and i32 %30, 176
  %33 = icmp eq i32 %32, 32
  br i1 %33, label %34, label %38

34:                                               ; preds = %31
  %35 = load i8*, i8** %5, align 8
  %36 = load i64, i64* %6, align 8
  %37 = getelementptr inbounds i8, i8* %35, i64 %36
  br label %40

38:                                               ; preds = %31
  %39 = load i8*, i8** %5, align 8
  br label %40

40:                                               ; preds = %38, %34
  %41 = phi i8* [ %37, %34 ], [ %39, %38 ]
  %42 = load i8*, i8** %5, align 8
  %43 = load i64, i64* %6, align 8
  %44 = getelementptr inbounds i8, i8* %42, i64 %43
  %45 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %46 = bitcast %"class.std::__1::basic_ostream"* %45 to i8**
  %47 = load i8*, i8** %46, align 8
  %48 = getelementptr i8, i8* %47, i64 -24
  %49 = bitcast i8* %48 to i64*
  %50 = load i64, i64* %49, align 8
  %51 = bitcast %"class.std::__1::basic_ostream"* %45 to i8*
  %52 = getelementptr inbounds i8, i8* %51, i64 %50
  %53 = bitcast i8* %52 to %"class.std::__1::ios_base"*
  %54 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %55 = bitcast %"class.std::__1::basic_ostream"* %54 to i8**
  %56 = load i8*, i8** %55, align 8
  %57 = getelementptr i8, i8* %56, i64 -24
  %58 = bitcast i8* %57 to i64*
  %59 = load i64, i64* %58, align 8
  %60 = bitcast %"class.std::__1::basic_ostream"* %54 to i8*
  %61 = getelementptr inbounds i8, i8* %60, i64 %59
  %62 = bitcast i8* %61 to %"class.std::__1::basic_ios"*
  %63 = invoke noundef signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %62)
          to label %64 unwind label %88

64:                                               ; preds = %40
  %65 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %11, i32 0, i32 0
  %66 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %65, align 8
  %67 = ptrtoint %"class.std::__1::basic_streambuf"* %66 to i64
  %68 = invoke i64 @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(i64 %67, i8* noundef %20, i8* noundef %41, i8* noundef %44, %"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %53, i8 noundef signext %63)
          to label %69 unwind label %88

69:                                               ; preds = %64
  %70 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %10, i32 0, i32 0
  %71 = inttoptr i64 %68 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %71, %"class.std::__1::basic_streambuf"** %70, align 8
  %72 = call noundef zeroext i1 @_ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedEv(%"class.std::__1::ostreambuf_iterator"* noundef nonnull align 8 dereferenceable(8) %10) #10
  br i1 %72, label %73, label %108

73:                                               ; preds = %69
  %74 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %75 = bitcast %"class.std::__1::basic_ostream"* %74 to i8**
  %76 = load i8*, i8** %75, align 8
  %77 = getelementptr i8, i8* %76, i64 -24
  %78 = bitcast i8* %77 to i64*
  %79 = load i64, i64* %78, align 8
  %80 = bitcast %"class.std::__1::basic_ostream"* %74 to i8*
  %81 = getelementptr inbounds i8, i8* %80, i64 %79
  %82 = bitcast i8* %81 to %"class.std::__1::basic_ios"*
  invoke void @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %82, i32 noundef 5)
          to label %83 unwind label %88

83:                                               ; preds = %73
  br label %108

84:                                               ; preds = %3
  %85 = landingpad { i8*, i32 }
          catch i8* null
  %86 = extractvalue { i8*, i32 } %85, 0
  store i8* %86, i8** %8, align 8
  %87 = extractvalue { i8*, i32 } %85, 1
  store i32 %87, i32* %9, align 4
  br label %93

88:                                               ; preds = %73, %64, %40, %17, %14
  %89 = landingpad { i8*, i32 }
          catch i8* null
  %90 = extractvalue { i8*, i32 } %89, 0
  store i8* %90, i8** %8, align 8
  %91 = extractvalue { i8*, i32 } %89, 1
  store i32 %91, i32* %9, align 4
  %92 = call noundef %"class.std::__1::basic_ostream<char>::sentry"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char>::sentry"* noundef nonnull align 8 dereferenceable(16) %7) #10
  br label %93

93:                                               ; preds = %88, %84
  %94 = load i8*, i8** %8, align 8
  %95 = call i8* @__cxa_begin_catch(i8* %94) #10
  %96 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %97 = bitcast %"class.std::__1::basic_ostream"* %96 to i8**
  %98 = load i8*, i8** %97, align 8
  %99 = getelementptr i8, i8* %98, i64 -24
  %100 = bitcast i8* %99 to i64*
  %101 = load i64, i64* %100, align 8
  %102 = bitcast %"class.std::__1::basic_ostream"* %96 to i8*
  %103 = getelementptr inbounds i8, i8* %102, i64 %101
  %104 = bitcast i8* %103 to %"class.std::__1::ios_base"*
  invoke void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %104)
          to label %105 unwind label %111

105:                                              ; preds = %93
  call void @__cxa_end_catch()
  br label %106

106:                                              ; preds = %105, %109
  %107 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  ret %"class.std::__1::basic_ostream"* %107

108:                                              ; preds = %83, %69
  br label %109

109:                                              ; preds = %108, %16
  %110 = call noundef %"class.std::__1::basic_ostream<char>::sentry"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char>::sentry"* noundef nonnull align 8 dereferenceable(16) %7) #10
  br label %106

111:                                              ; preds = %93
  %112 = landingpad { i8*, i32 }
          cleanup
  %113 = extractvalue { i8*, i32 } %112, 0
  store i8* %113, i8** %8, align 8
  %114 = extractvalue { i8*, i32 } %112, 1
  store i32 %114, i32* %9, align 4
  invoke void @__cxa_end_catch()
          to label %115 unwind label %121

115:                                              ; preds = %111
  br label %116

116:                                              ; preds = %115
  %117 = load i8*, i8** %8, align 8
  %118 = load i32, i32* %9, align 4
  %119 = insertvalue { i8*, i32 } undef, i8* %117, 0
  %120 = insertvalue { i8*, i32 } %119, i32 %118, 1
  resume { i8*, i32 } %120

121:                                              ; preds = %111
  %122 = landingpad { i8*, i32 }
          catch i8* null
  %123 = extractvalue { i8*, i32 } %122, 0
  call void @__clang_call_terminate(i8* %123) #11
  unreachable
}

declare noundef %"class.std::__1::basic_ostream<char>::sentry"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_(%"class.std::__1::basic_ostream<char>::sentry"* noundef nonnull returned align 8 dereferenceable(16), %"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8)) unnamed_addr #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef zeroext i1 @_ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbEv(%"class.std::__1::basic_ostream<char>::sentry"* noundef nonnull align 8 dereferenceable(16) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_ostream<char>::sentry"*, align 8
  store %"class.std::__1::basic_ostream<char>::sentry"* %0, %"class.std::__1::basic_ostream<char>::sentry"** %2, align 8
  %3 = load %"class.std::__1::basic_ostream<char>::sentry"*, %"class.std::__1::basic_ostream<char>::sentry"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_ostream<char>::sentry", %"class.std::__1::basic_ostream<char>::sentry"* %3, i32 0, i32 0
  %5 = load i8, i8* %4, align 8
  %6 = trunc i8 %5 to i1
  ret i1 %6
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden i64 @_ZNSt3__116__pad_and_outputIcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_(i64 %0, i8* noundef %1, i8* noundef %2, i8* noundef %3, %"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %4, i8 noundef signext %5) #4 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %7 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %8 = alloca %"class.std::__1::ostreambuf_iterator", align 8
  %9 = alloca i8*, align 8
  %10 = alloca i8*, align 8
  %11 = alloca i8*, align 8
  %12 = alloca %"class.std::__1::ios_base"*, align 8
  %13 = alloca i8, align 1
  %14 = alloca i64, align 8
  %15 = alloca i64, align 8
  %16 = alloca i64, align 8
  %17 = alloca %"class.std::__1::basic_string", align 8
  %18 = alloca i8*, align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  %22 = inttoptr i64 %0 to %"class.std::__1::basic_streambuf"*
  store %"class.std::__1::basic_streambuf"* %22, %"class.std::__1::basic_streambuf"** %21, align 8
  store i8* %1, i8** %9, align 8
  store i8* %2, i8** %10, align 8
  store i8* %3, i8** %11, align 8
  store %"class.std::__1::ios_base"* %4, %"class.std::__1::ios_base"** %12, align 8
  store i8 %5, i8* %13, align 1
  %23 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  %24 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %23, align 8
  %25 = icmp eq %"class.std::__1::basic_streambuf"* %24, null
  br i1 %25, label %26, label %29

26:                                               ; preds = %6
  %27 = bitcast %"class.std::__1::ostreambuf_iterator"* %7 to i8*
  %28 = bitcast %"class.std::__1::ostreambuf_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %27, i8* align 8 %28, i64 8, i1 false)
  br label %121

29:                                               ; preds = %6
  %30 = load i8*, i8** %11, align 8
  %31 = load i8*, i8** %9, align 8
  %32 = ptrtoint i8* %30 to i64
  %33 = ptrtoint i8* %31 to i64
  %34 = sub i64 %32, %33
  store i64 %34, i64* %14, align 8
  %35 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %12, align 8
  %36 = call noundef i64 @_ZNKSt3__18ios_base5widthEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %35)
  store i64 %36, i64* %15, align 8
  %37 = load i64, i64* %15, align 8
  %38 = load i64, i64* %14, align 8
  %39 = icmp sgt i64 %37, %38
  br i1 %39, label %40, label %44

40:                                               ; preds = %29
  %41 = load i64, i64* %14, align 8
  %42 = load i64, i64* %15, align 8
  %43 = sub nsw i64 %42, %41
  store i64 %43, i64* %15, align 8
  br label %45

44:                                               ; preds = %29
  store i64 0, i64* %15, align 8
  br label %45

45:                                               ; preds = %44, %40
  %46 = load i8*, i8** %10, align 8
  %47 = load i8*, i8** %9, align 8
  %48 = ptrtoint i8* %46 to i64
  %49 = ptrtoint i8* %47 to i64
  %50 = sub i64 %48, %49
  store i64 %50, i64* %16, align 8
  %51 = load i64, i64* %16, align 8
  %52 = icmp sgt i64 %51, 0
  br i1 %52, label %53, label %66

53:                                               ; preds = %45
  %54 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  %55 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %54, align 8
  %56 = load i8*, i8** %9, align 8
  %57 = load i64, i64* %16, align 8
  %58 = call noundef i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl(%"class.std::__1::basic_streambuf"* noundef nonnull align 8 dereferenceable(64) %55, i8* noundef %56, i64 noundef %57)
  %59 = load i64, i64* %16, align 8
  %60 = icmp ne i64 %58, %59
  br i1 %60, label %61, label %65

61:                                               ; preds = %53
  %62 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %62, align 8
  %63 = bitcast %"class.std::__1::ostreambuf_iterator"* %7 to i8*
  %64 = bitcast %"class.std::__1::ostreambuf_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %63, i8* align 8 %64, i64 8, i1 false)
  br label %121

65:                                               ; preds = %53
  br label %66

66:                                               ; preds = %65, %45
  %67 = load i64, i64* %15, align 8
  %68 = icmp sgt i64 %67, 0
  br i1 %68, label %69, label %95

69:                                               ; preds = %66
  %70 = load i64, i64* %15, align 8
  %71 = load i8, i8* %13, align 1
  %72 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1Emc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17, i64 noundef %70, i8 noundef signext %71)
  %73 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  %74 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %73, align 8
  %75 = call noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  %76 = load i64, i64* %15, align 8
  %77 = invoke noundef i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl(%"class.std::__1::basic_streambuf"* noundef nonnull align 8 dereferenceable(64) %74, i8* noundef %75, i64 noundef %76)
          to label %78 unwind label %85

78:                                               ; preds = %69
  %79 = load i64, i64* %15, align 8
  %80 = icmp ne i64 %77, %79
  br i1 %80, label %81, label %90

81:                                               ; preds = %78
  %82 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %82, align 8
  %83 = bitcast %"class.std::__1::ostreambuf_iterator"* %7 to i8*
  %84 = bitcast %"class.std::__1::ostreambuf_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %83, i8* align 8 %84, i64 8, i1 false)
  store i32 1, i32* %20, align 4
  br label %91

85:                                               ; preds = %69
  %86 = landingpad { i8*, i32 }
          cleanup
  %87 = extractvalue { i8*, i32 } %86, 0
  store i8* %87, i8** %18, align 8
  %88 = extractvalue { i8*, i32 } %86, 1
  store i32 %88, i32* %19, align 4
  %89 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  br label %125

90:                                               ; preds = %78
  store i32 0, i32* %20, align 4
  br label %91

91:                                               ; preds = %90, %81
  %92 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %17) #10
  %93 = load i32, i32* %20, align 4
  switch i32 %93, label %130 [
    i32 0, label %94
    i32 1, label %121
  ]

94:                                               ; preds = %91
  br label %95

95:                                               ; preds = %94, %66
  %96 = load i8*, i8** %11, align 8
  %97 = load i8*, i8** %10, align 8
  %98 = ptrtoint i8* %96 to i64
  %99 = ptrtoint i8* %97 to i64
  %100 = sub i64 %98, %99
  store i64 %100, i64* %16, align 8
  %101 = load i64, i64* %16, align 8
  %102 = icmp sgt i64 %101, 0
  br i1 %102, label %103, label %116

103:                                              ; preds = %95
  %104 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  %105 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %104, align 8
  %106 = load i8*, i8** %10, align 8
  %107 = load i64, i64* %16, align 8
  %108 = call noundef i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl(%"class.std::__1::basic_streambuf"* noundef nonnull align 8 dereferenceable(64) %105, i8* noundef %106, i64 noundef %107)
  %109 = load i64, i64* %16, align 8
  %110 = icmp ne i64 %108, %109
  br i1 %110, label %111, label %115

111:                                              ; preds = %103
  %112 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %8, i32 0, i32 0
  store %"class.std::__1::basic_streambuf"* null, %"class.std::__1::basic_streambuf"** %112, align 8
  %113 = bitcast %"class.std::__1::ostreambuf_iterator"* %7 to i8*
  %114 = bitcast %"class.std::__1::ostreambuf_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %113, i8* align 8 %114, i64 8, i1 false)
  br label %121

115:                                              ; preds = %103
  br label %116

116:                                              ; preds = %115, %95
  %117 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %12, align 8
  %118 = call noundef i64 @_ZNSt3__18ios_base5widthEl(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %117, i64 noundef 0)
  %119 = bitcast %"class.std::__1::ostreambuf_iterator"* %7 to i8*
  %120 = bitcast %"class.std::__1::ostreambuf_iterator"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %119, i8* align 8 %120, i64 8, i1 false)
  br label %121

121:                                              ; preds = %116, %111, %91, %61, %26
  %122 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %7, i32 0, i32 0
  %123 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %122, align 8
  %124 = ptrtoint %"class.std::__1::basic_streambuf"* %123 to i64
  ret i64 %124

125:                                              ; preds = %85
  %126 = load i8*, i8** %18, align 8
  %127 = load i32, i32* %19, align 4
  %128 = insertvalue { i8*, i32 } undef, i8* %126, 0
  %129 = insertvalue { i8*, i32 } %128, i32 %127, 1
  resume { i8*, i32 } %129

130:                                              ; preds = %91
  unreachable
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::ostreambuf_iterator"* @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1ERNS_13basic_ostreamIcS2_EE(%"class.std::__1::ostreambuf_iterator"* noundef nonnull returned align 8 dereferenceable(8) %0, %"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #6 align 2 {
  %3 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  %4 = alloca %"class.std::__1::basic_ostream"*, align 8
  store %"class.std::__1::ostreambuf_iterator"* %0, %"class.std::__1::ostreambuf_iterator"** %3, align 8
  store %"class.std::__1::basic_ostream"* %1, %"class.std::__1::basic_ostream"** %4, align 8
  %5 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %3, align 8
  %6 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %7 = call noundef %"class.std::__1::ostreambuf_iterator"* @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2ERNS_13basic_ostreamIcS2_EE(%"class.std::__1::ostreambuf_iterator"* noundef nonnull align 8 dereferenceable(8) %5, %"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %6) #10
  ret %"class.std::__1::ostreambuf_iterator"* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i32 @_ZNKSt3__18ios_base5flagsEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::ios_base"*, align 8
  store %"class.std::__1::ios_base"* %0, %"class.std::__1::ios_base"** %2, align 8
  %3 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %3, i32 0, i32 1
  %5 = load i32, i32* %4, align 8
  ret i32 %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden noundef signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillEv(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %0) #4 align 2 {
  %2 = alloca %"class.std::__1::basic_ios"*, align 8
  store %"class.std::__1::basic_ios"* %0, %"class.std::__1::basic_ios"** %2, align 8
  %3 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %2, align 8
  %4 = call noundef i32 @_ZNSt3__111char_traitsIcE3eofEv() #10
  %5 = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %3, i32 0, i32 2
  %6 = load i32, i32* %5, align 8
  %7 = call noundef zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 noundef %4, i32 noundef %6) #10
  br i1 %7, label %8, label %12

8:                                                ; preds = %1
  %9 = call noundef signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %3, i8 noundef signext 32)
  %10 = sext i8 %9 to i32
  %11 = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %3, i32 0, i32 2
  store i32 %10, i32* %11, align 8
  br label %12

12:                                               ; preds = %8, %1
  %13 = getelementptr inbounds %"class.std::__1::basic_ios", %"class.std::__1::basic_ios"* %3, i32 0, i32 2
  %14 = load i32, i32* %13, align 8
  %15 = trunc i32 %14 to i8
  ret i8 %15
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef zeroext i1 @_ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedEv(%"class.std::__1::ostreambuf_iterator"* noundef nonnull align 8 dereferenceable(8) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  store %"class.std::__1::ostreambuf_iterator"* %0, %"class.std::__1::ostreambuf_iterator"** %2, align 8
  %3 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %3, i32 0, i32 0
  %5 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %4, align 8
  %6 = icmp eq %"class.std::__1::basic_streambuf"* %5, null
  ret i1 %6
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden void @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateEj(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %0, i32 noundef %1) #4 align 2 {
  %3 = alloca %"class.std::__1::basic_ios"*, align 8
  %4 = alloca i32, align 4
  store %"class.std::__1::basic_ios"* %0, %"class.std::__1::basic_ios"** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %3, align 8
  %6 = bitcast %"class.std::__1::basic_ios"* %5 to %"class.std::__1::ios_base"*
  %7 = load i32, i32* %4, align 4
  call void @_ZNSt3__18ios_base8setstateEj(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %6, i32 noundef %7)
  ret void
}

; Function Attrs: nounwind
declare noundef %"class.std::__1::basic_ostream<char>::sentry"* @_ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev(%"class.std::__1::basic_ostream<char>::sentry"* noundef nonnull returned align 8 dereferenceable(16)) unnamed_addr #5

declare void @_ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136)) #3

declare void @__cxa_end_catch()

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i64 @_ZNKSt3__18ios_base5widthEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::ios_base"*, align 8
  store %"class.std::__1::ios_base"* %0, %"class.std::__1::ios_base"** %2, align 8
  %3 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %3, i32 0, i32 3
  %5 = load i64, i64* %4, align 8
  ret i64 %5
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden noundef i64 @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnEPKcl(%"class.std::__1::basic_streambuf"* noundef nonnull align 8 dereferenceable(64) %0, i8* noundef %1, i64 noundef %2) #4 align 2 {
  %4 = alloca %"class.std::__1::basic_streambuf"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  store %"class.std::__1::basic_streambuf"* %0, %"class.std::__1::basic_streambuf"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.std::__1::basic_streambuf"*, %"class.std::__1::basic_streambuf"** %4, align 8
  %8 = load i8*, i8** %5, align 8
  %9 = load i64, i64* %6, align 8
  %10 = bitcast %"class.std::__1::basic_streambuf"* %7 to i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)***
  %11 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)**, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*** %10, align 8
  %12 = getelementptr inbounds i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %11, i64 12
  %13 = load i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)*, i64 (%"class.std::__1::basic_streambuf"*, i8*, i64)** %12, align 8
  %14 = call noundef i64 %13(%"class.std::__1::basic_streambuf"* noundef nonnull align 8 dereferenceable(64) %7, i8* noundef %8, i64 noundef %9)
  ret i64 %14
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1Emc(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, i64 noundef %1, i8 noundef signext %2) unnamed_addr #1 align 2 {
  %4 = alloca %"class.std::__1::basic_string"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8, align 1
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %8 = load i64, i64* %5, align 8
  %9 = load i8, i8* %6, align 1
  %10 = call noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2Emc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %7, i64 noundef %8, i8 noundef signext %9)
  ret %"class.std::__1::basic_string"* %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = call noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  %5 = call noundef i8* @_ZNSt3__112__to_addressIcEEPT_S2_(i8* noundef %4) #10
  ret i8* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i64 @_ZNSt3__18ios_base5widthEl(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %0, i64 noundef %1) #7 align 2 {
  %3 = alloca %"class.std::__1::ios_base"*, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  store %"class.std::__1::ios_base"* %0, %"class.std::__1::ios_base"** %3, align 8
  store i64 %1, i64* %4, align 8
  %6 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %3, align 8
  %7 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %6, i32 0, i32 3
  %8 = load i64, i64* %7, align 8
  store i64 %8, i64* %5, align 8
  %9 = load i64, i64* %4, align 8
  %10 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %6, i32 0, i32 3
  store i64 %9, i64* %10, align 8
  %11 = load i64, i64* %5, align 8
  ret i64 %11
}

; Function Attrs: noinline optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::basic_string"* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2Emc(%"class.std::__1::basic_string"* noundef nonnull returned align 8 dereferenceable(24) %0, i64 noundef %1, i8 noundef signext %2) unnamed_addr #1 align 2 {
  %4 = alloca %"class.std::__1::basic_string"*, align 8
  %5 = alloca i64, align 8
  %6 = alloca i8, align 1
  %7 = alloca %"struct.std::__1::__default_init_tag", align 1
  %8 = alloca %"struct.std::__1::__default_init_tag", align 1
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %4, align 8
  store i64 %1, i64* %5, align 8
  store i8 %2, i8* %6, align 1
  %9 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %4, align 8
  %10 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %9, i32 0, i32 0
  %11 = call noundef %"class.std::__1::__compressed_pair"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1INS_18__default_init_tagESA_EEOT_OT0_(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %10, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %7, %"struct.std::__1::__default_init_tag"* noundef nonnull align 1 dereferenceable(1) %8)
  %12 = load i64, i64* %5, align 8
  %13 = load i8, i8* %6, align 1
  call void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %9, i64 noundef %12, i8 noundef signext %13)
  call void @_ZNSt3__119__debug_db_insert_cINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEEEEvPT_(%"class.std::__1::basic_string"* noundef %9)
  ret %"class.std::__1::basic_string"* %9
}

declare void @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24), i64 noundef, i8 noundef signext) #3

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__112__to_addressIcEEPT_S2_(i8* noundef %0) #7 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  ret i8* %3
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = call noundef zeroext i1 @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br i1 %4, label %5, label %7

5:                                                ; preds = %1
  %6 = call noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br label %9

7:                                                ; preds = %1
  %8 = call noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %3) #10
  br label %9

9:                                                ; preds = %7, %5
  %10 = phi i8* [ %6, %5 ], [ %8, %7 ]
  ret i8* %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to %"struct.std::__1::basic_string<char>::__long"*
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__long", %"struct.std::__1::basic_string<char>::__long"* %7, i32 0, i32 0
  %9 = load i8*, i8** %8, align 8
  ret i8* %9
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerEv(%"class.std::__1::basic_string"* noundef nonnull align 8 dereferenceable(24) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::basic_string"*, align 8
  store %"class.std::__1::basic_string"* %0, %"class.std::__1::basic_string"** %2, align 8
  %3 = load %"class.std::__1::basic_string"*, %"class.std::__1::basic_string"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::basic_string", %"class.std::__1::basic_string"* %3, i32 0, i32 0
  %5 = call noundef nonnull align 8 dereferenceable(24) %"struct.std::__1::basic_string<char>::__rep"* @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstEv(%"class.std::__1::__compressed_pair"* noundef nonnull align 8 dereferenceable(24) %4) #10
  %6 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__rep", %"struct.std::__1::basic_string<char>::__rep"* %5, i32 0, i32 0
  %7 = bitcast %union.anon* %6 to %"struct.std::__1::basic_string<char>::__short"*
  %8 = getelementptr inbounds %"struct.std::__1::basic_string<char>::__short", %"struct.std::__1::basic_string<char>::__short"* %7, i32 0, i32 0
  %9 = getelementptr inbounds [23 x i8], [23 x i8]* %8, i64 0, i64 0
  %10 = call noundef i8* @_ZNSt3__114pointer_traitsIPcE10pointer_toERc(i8* noundef nonnull align 1 dereferenceable(1) %9) #10
  ret i8* %10
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__114pointer_traitsIPcE10pointer_toERc(i8* noundef nonnull align 1 dereferenceable(1) %0) #7 align 2 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  %4 = call noundef i8* @_ZNSt3__19addressofIcEEPT_RS1_(i8* noundef nonnull align 1 dereferenceable(1) %3) #10
  ret i8* %4
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNSt3__19addressofIcEEPT_RS1_(i8* noundef nonnull align 1 dereferenceable(1) %0) #7 {
  %2 = alloca i8*, align 8
  store i8* %0, i8** %2, align 8
  %3 = load i8*, i8** %2, align 8
  ret i8* %3
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::ostreambuf_iterator"* @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2ERNS_13basic_ostreamIcS2_EE(%"class.std::__1::ostreambuf_iterator"* noundef nonnull returned align 8 dereferenceable(8) %0, %"class.std::__1::basic_ostream"* noundef nonnull align 8 dereferenceable(8) %1) unnamed_addr #6 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::__1::ostreambuf_iterator"*, align 8
  %4 = alloca %"class.std::__1::basic_ostream"*, align 8
  store %"class.std::__1::ostreambuf_iterator"* %0, %"class.std::__1::ostreambuf_iterator"** %3, align 8
  store %"class.std::__1::basic_ostream"* %1, %"class.std::__1::basic_ostream"** %4, align 8
  %5 = load %"class.std::__1::ostreambuf_iterator"*, %"class.std::__1::ostreambuf_iterator"** %3, align 8
  %6 = bitcast %"class.std::__1::ostreambuf_iterator"* %5 to %"struct.std::__1::iterator"*
  %7 = getelementptr inbounds %"class.std::__1::ostreambuf_iterator", %"class.std::__1::ostreambuf_iterator"* %5, i32 0, i32 0
  %8 = load %"class.std::__1::basic_ostream"*, %"class.std::__1::basic_ostream"** %4, align 8
  %9 = bitcast %"class.std::__1::basic_ostream"* %8 to i8**
  %10 = load i8*, i8** %9, align 8
  %11 = getelementptr i8, i8* %10, i64 -24
  %12 = bitcast i8* %11 to i64*
  %13 = load i64, i64* %12, align 8
  %14 = bitcast %"class.std::__1::basic_ostream"* %8 to i8*
  %15 = getelementptr inbounds i8, i8* %14, i64 %13
  %16 = bitcast i8* %15 to %"class.std::__1::basic_ios"*
  %17 = invoke noundef %"class.std::__1::basic_streambuf"* @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufEv(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %16)
          to label %18 unwind label %19

18:                                               ; preds = %2
  store %"class.std::__1::basic_streambuf"* %17, %"class.std::__1::basic_streambuf"** %7, align 8
  ret %"class.std::__1::ostreambuf_iterator"* %5

19:                                               ; preds = %2
  %20 = landingpad { i8*, i32 }
          catch i8* null
  %21 = extractvalue { i8*, i32 } %20, 0
  call void @__clang_call_terminate(i8* %21) #11
  unreachable
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden noundef %"class.std::__1::basic_streambuf"* @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufEv(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %0) #4 align 2 {
  %2 = alloca %"class.std::__1::basic_ios"*, align 8
  store %"class.std::__1::basic_ios"* %0, %"class.std::__1::basic_ios"** %2, align 8
  %3 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %2, align 8
  %4 = bitcast %"class.std::__1::basic_ios"* %3 to %"class.std::__1::ios_base"*
  %5 = call noundef i8* @_ZNKSt3__18ios_base5rdbufEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %4)
  %6 = bitcast i8* %5 to %"class.std::__1::basic_streambuf"*
  ret %"class.std::__1::basic_streambuf"* %6
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr hidden noundef i8* @_ZNKSt3__18ios_base5rdbufEv(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %0) #7 align 2 {
  %2 = alloca %"class.std::__1::ios_base"*, align 8
  store %"class.std::__1::ios_base"* %0, %"class.std::__1::ios_base"** %2, align 8
  %3 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %3, i32 0, i32 6
  %5 = load i8*, i8** %4, align 8
  ret i8* %5
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr noundef zeroext i1 @_ZNSt3__111char_traitsIcE11eq_int_typeEii(i32 noundef %0, i32 noundef %1) #7 align 2 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %4, align 4
  %7 = icmp eq i32 %5, %6
  ret i1 %7
}

; Function Attrs: mustprogress noinline nounwind optnone ssp uwtable
define linkonce_odr noundef i32 @_ZNSt3__111char_traitsIcE3eofEv() #7 align 2 {
  ret i32 -1
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden noundef signext i8 @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenEc(%"class.std::__1::basic_ios"* noundef nonnull align 8 dereferenceable(148) %0, i8 noundef signext %1) #4 align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.std::__1::basic_ios"*, align 8
  %4 = alloca i8, align 1
  %5 = alloca %"class.std::__1::locale", align 8
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  store %"class.std::__1::basic_ios"* %0, %"class.std::__1::basic_ios"** %3, align 8
  store i8 %1, i8* %4, align 1
  %8 = load %"class.std::__1::basic_ios"*, %"class.std::__1::basic_ios"** %3, align 8
  %9 = bitcast %"class.std::__1::basic_ios"* %8 to %"class.std::__1::ios_base"*
  call void @_ZNKSt3__18ios_base6getlocEv(%"class.std::__1::locale"* sret(%"class.std::__1::locale") align 8 %5, %"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %9)
  %10 = invoke noundef nonnull align 8 dereferenceable(25) %"class.std::__1::ctype"* @_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE(%"class.std::__1::locale"* noundef nonnull align 8 dereferenceable(8) %5)
          to label %11 unwind label %16

11:                                               ; preds = %2
  %12 = load i8, i8* %4, align 1
  %13 = invoke noundef signext i8 @_ZNKSt3__15ctypeIcE5widenEc(%"class.std::__1::ctype"* noundef nonnull align 8 dereferenceable(25) %10, i8 noundef signext %12)
          to label %14 unwind label %16

14:                                               ; preds = %11
  %15 = call noundef %"class.std::__1::locale"* @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* noundef nonnull align 8 dereferenceable(8) %5) #10
  ret i8 %13

16:                                               ; preds = %11, %2
  %17 = landingpad { i8*, i32 }
          cleanup
  %18 = extractvalue { i8*, i32 } %17, 0
  store i8* %18, i8** %6, align 8
  %19 = extractvalue { i8*, i32 } %17, 1
  store i32 %19, i32* %7, align 4
  %20 = call noundef %"class.std::__1::locale"* @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* noundef nonnull align 8 dereferenceable(8) %5) #10
  br label %21

21:                                               ; preds = %16
  %22 = load i8*, i8** %6, align 8
  %23 = load i32, i32* %7, align 4
  %24 = insertvalue { i8*, i32 } undef, i8* %22, 0
  %25 = insertvalue { i8*, i32 } %24, i32 %23, 1
  resume { i8*, i32 } %25
}

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden noundef nonnull align 8 dereferenceable(25) %"class.std::__1::ctype"* @_ZNSt3__19use_facetINS_5ctypeIcEEEERKT_RKNS_6localeE(%"class.std::__1::locale"* noundef nonnull align 8 dereferenceable(8) %0) #4 {
  %2 = alloca %"class.std::__1::locale"*, align 8
  store %"class.std::__1::locale"* %0, %"class.std::__1::locale"** %2, align 8
  %3 = load %"class.std::__1::locale"*, %"class.std::__1::locale"** %2, align 8
  %4 = call noundef %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"* noundef nonnull align 8 dereferenceable(8) %3, %"class.std::__1::locale::id"* noundef nonnull align 8 dereferenceable(12) @_ZNSt3__15ctypeIcE2idE)
  %5 = bitcast %"class.std::__1::locale::facet"* %4 to %"class.std::__1::ctype"*
  ret %"class.std::__1::ctype"* %5
}

declare void @_ZNKSt3__18ios_base6getlocEv(%"class.std::__1::locale"* sret(%"class.std::__1::locale") align 8, %"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136)) #3

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden noundef signext i8 @_ZNKSt3__15ctypeIcE5widenEc(%"class.std::__1::ctype"* noundef nonnull align 8 dereferenceable(25) %0, i8 noundef signext %1) #4 align 2 {
  %3 = alloca %"class.std::__1::ctype"*, align 8
  %4 = alloca i8, align 1
  store %"class.std::__1::ctype"* %0, %"class.std::__1::ctype"** %3, align 8
  store i8 %1, i8* %4, align 1
  %5 = load %"class.std::__1::ctype"*, %"class.std::__1::ctype"** %3, align 8
  %6 = load i8, i8* %4, align 1
  %7 = bitcast %"class.std::__1::ctype"* %5 to i8 (%"class.std::__1::ctype"*, i8)***
  %8 = load i8 (%"class.std::__1::ctype"*, i8)**, i8 (%"class.std::__1::ctype"*, i8)*** %7, align 8
  %9 = getelementptr inbounds i8 (%"class.std::__1::ctype"*, i8)*, i8 (%"class.std::__1::ctype"*, i8)** %8, i64 7
  %10 = load i8 (%"class.std::__1::ctype"*, i8)*, i8 (%"class.std::__1::ctype"*, i8)** %9, align 8
  %11 = call noundef signext i8 %10(%"class.std::__1::ctype"* noundef nonnull align 8 dereferenceable(25) %5, i8 noundef signext %6)
  ret i8 %11
}

; Function Attrs: nounwind
declare noundef %"class.std::__1::locale"* @_ZNSt3__16localeD1Ev(%"class.std::__1::locale"* noundef nonnull returned align 8 dereferenceable(8)) unnamed_addr #5

declare noundef %"class.std::__1::locale::facet"* @_ZNKSt3__16locale9use_facetERNS0_2idE(%"class.std::__1::locale"* noundef nonnull align 8 dereferenceable(8), %"class.std::__1::locale::id"* noundef nonnull align 8 dereferenceable(12)) #3

; Function Attrs: mustprogress noinline optnone ssp uwtable
define linkonce_odr hidden void @_ZNSt3__18ios_base8setstateEj(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %0, i32 noundef %1) #4 align 2 {
  %3 = alloca %"class.std::__1::ios_base"*, align 8
  %4 = alloca i32, align 4
  store %"class.std::__1::ios_base"* %0, %"class.std::__1::ios_base"** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %"class.std::__1::ios_base"*, %"class.std::__1::ios_base"** %3, align 8
  %6 = getelementptr inbounds %"class.std::__1::ios_base", %"class.std::__1::ios_base"* %5, i32 0, i32 4
  %7 = load i32, i32* %6, align 8
  %8 = load i32, i32* %4, align 4
  %9 = or i32 %7, %8
  call void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136) %5, i32 noundef %9)
  ret void
}

declare void @_ZNSt3__18ios_base5clearEj(%"class.std::__1::ios_base"* noundef nonnull align 8 dereferenceable(136), i32 noundef) #3

; Function Attrs: noinline ssp uwtable
define internal void @_GLOBAL__sub_I_GenGen.cpp() #0 section "__TEXT,__StaticInit,regular,pure_instructions" {
  call void @__cxx_global_var_init()
  ret void
}

attributes #0 = { noinline ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #1 = { noinline optnone ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #2 = { mustprogress noinline norecurse optnone ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #3 = { "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #4 = { mustprogress noinline optnone ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #5 = { nounwind "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #6 = { noinline nounwind optnone ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #7 = { mustprogress noinline nounwind optnone ssp uwtable "frame-pointer"="non-leaf" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+crypto,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.5a,+zcm,+zcz" }
attributes #8 = { argmemonly nofree nounwind willreturn }
attributes #9 = { noinline noreturn nounwind }
attributes #10 = { nounwind }
attributes #11 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 1, !"branch-target-enforcement", i32 0}
!2 = !{i32 1, !"sign-return-address", i32 0}
!3 = !{i32 1, !"sign-return-address-all", i32 0}
!4 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!5 = !{i32 7, !"PIC Level", i32 2}
!6 = !{i32 7, !"uwtable", i32 1}
!7 = !{i32 7, !"frame-pointer", i32 1}
!8 = !{!"Homebrew clang version 14.0.6"}
!9 = distinct !{!9, !10}
!10 = !{!"llvm.loop.mustprogress"}
!11 = distinct !{!11, !10}
