	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_internal_aligned_alloc  ## -- Begin function halide_internal_aligned_alloc
	.weak_definition	_halide_internal_aligned_alloc
	.p2align	4, 0x90
_halide_internal_aligned_alloc:         ## @halide_internal_aligned_alloc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	leaq	(%rsi,%rdi,2), %rdi
	decq	%rdi
	movq	%rbx, %r14
	negq	%r14
	andq	%r14, %rdi
	callq	_malloc
	testq	%rax, %rax
	je	LBB0_1
## %bb.2:                               ## %if.end
	movq	%rax, %rcx
	addq	%rbx, %rax
	addq	$7, %rax
	andq	%r14, %rax
	movq	%rcx, -8(%rax)
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB0_1:
	xorl	%eax, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_internal_aligned_free   ## -- Begin function halide_internal_aligned_free
	.weak_definition	_halide_internal_aligned_free
	.p2align	4, 0x90
_halide_internal_aligned_free:          ## @halide_internal_aligned_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	-8(%rdi), %rdi
	popq	%rbp
	jmp	_free                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_malloc          ## -- Begin function halide_default_malloc
	.weak_definition	_halide_default_malloc
	.p2align	4, 0x90
_halide_default_malloc:                 ## @halide_default_malloc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	leaq	127(%rsi), %rdi
	andq	$-64, %rdi
	callq	_malloc
	testq	%rax, %rax
	je	LBB2_1
## %bb.2:                               ## %if.end.i
	movq	%rax, %rcx
	addq	$71, %rax
	andq	$-64, %rax
	movq	%rcx, -8(%rax)
	popq	%rbp
	retq
LBB2_1:
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_free            ## -- Begin function halide_default_free
	.weak_definition	_halide_default_free
	.p2align	4, 0x90
_halide_default_free:                   ## @halide_default_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	-8(%rsi), %rdi
	popq	%rbp
	jmp	_free                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_set_custom_malloc       ## -- Begin function halide_set_custom_malloc
	.weak_definition	_halide_set_custom_malloc
	.p2align	4, 0x90
_halide_set_custom_malloc:              ## @halide_set_custom_malloc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal13custom_mallocE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_free         ## -- Begin function halide_set_custom_free
	.weak_definition	_halide_set_custom_free
	.p2align	4, 0x90
_halide_set_custom_free:                ## @halide_set_custom_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal11custom_freeE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_malloc                  ## -- Begin function halide_malloc
	.weak_definition	_halide_malloc
	.p2align	4, 0x90
_halide_malloc:                         ## @halide_malloc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal13custom_mallocE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_free                    ## -- Begin function halide_free
	.weak_definition	_halide_free
	.p2align	4, 0x90
_halide_free:                           ## @halide_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal11custom_freeE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_error           ## -- Begin function halide_default_error
	.weak_definition	_halide_default_error
	.p2align	4, 0x90
_halide_default_error:                  ## @halide_default_error
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$4136, %rsp                     ## imm = 0x1028
	movq	%rsi, %r14
	movq	%rdi, %rbx
	leaq	-56(%rbp), %r15
	leaq	-4152(%rbp), %rdx
	movl	$4096, %ecx                     ## imm = 0x1000
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	leaq	L_.str(%rip), %rsi
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	testq	%rax, %rax
	je	LBB8_4
## %bb.1:                               ## %land.lhs.true
	movq	%rax, %r14
	cmpb	$0, (%rax)
	je	LBB8_4
## %bb.2:                               ## %land.lhs.true4
	movq	%r14, %rdi
	callq	_strlen
	cmpb	$10, -1(%rax,%r14)
	je	LBB8_4
## %bb.3:                               ## %if.then
	leaq	L_.str.13.172(%rip), %rsi
	leaq	-56(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
LBB8_4:                                 ## %if.end
	leaq	-56(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_halide_print
	callq	_abort
	addq	$4136, %rsp                     ## imm = 0x1028
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy: ## @_ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdx, (%rdi)
	testq	%rdx, %rdx
	leaq	-1(%rdx,%rcx), %rax
	cmoveq	%rdx, %rax
	movq	%rax, 8(%rdi)
	movq	%rdx, 16(%rdi)
	movq	%rsi, 24(%rdi)
	cmpq	%rdx, %rax
	jbe	LBB9_2
## %bb.1:                               ## %if.then
	movb	$0, (%rax)
LBB9_2:                                 ## %if.end
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rdx
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rsi
	callq	_halide_string_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBase3strEv ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBase3strEv
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBase3strEv: ## @_ZN6Halide7Runtime8Internal11PrinterBase3strEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	24(%rdi), %rdi
	movq	(%rbx), %rdx
	movq	16(%rbx), %rsi
	subq	%rsi, %rdx
	incq	%rdx
	callq	_halide_msan_annotate_memory_is_initialized
	movq	16(%rbx), %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error                   ## -- Begin function halide_error
	.weak_definition	_halide_error
	.p2align	4, 0x90
_halide_error:                          ## @halide_error
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal13error_handlerE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_set_error_handler       ## -- Begin function halide_set_error_handler
	.weak_definition	_halide_set_error_handler
	.p2align	4, 0x90
_halide_set_error_handler:              ## @halide_set_error_handler
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal13error_handlerE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_print                   ## -- Begin function halide_print
	.weak_definition	_halide_print
	.p2align	4, 0x90
_halide_print:                          ## @halide_print
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal12custom_printE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_set_custom_print        ## -- Begin function halide_set_custom_print
	.weak_definition	_halide_set_custom_print
	.p2align	4, 0x90
_halide_set_custom_print:               ## @halide_set_custom_print
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal12custom_printE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_start_clock             ## -- Begin function halide_start_clock
	.weak_definition	_halide_start_clock
	.p2align	4, 0x90
_halide_start_clock:                    ## @halide_start_clock
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	__ZN6Halide7Runtime8Internal29halide_reference_clock_initedE@GOTPCREL(%rip), %rbx
	cmpb	$0, (%rbx)
	jne	LBB16_2
## %bb.1:                               ## %if.then
	movq	__ZN6Halide7Runtime8Internal20halide_timebase_infoE@GOTPCREL(%rip), %rdi
	callq	_mach_timebase_info
	callq	_mach_absolute_time
	movq	__ZN6Halide7Runtime8Internal22halide_reference_clockE@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	movb	$1, (%rbx)
LBB16_2:                                ## %if.end
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_current_time_ns         ## -- Begin function halide_current_time_ns
	.weak_definition	_halide_current_time_ns
	.p2align	4, 0x90
_halide_current_time_ns:                ## @halide_current_time_ns
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	callq	_mach_absolute_time
	movq	%rax, %rcx
	movq	__ZN6Halide7Runtime8Internal22halide_reference_clockE@GOTPCREL(%rip), %rax
	subq	(%rax), %rcx
	movq	__ZN6Halide7Runtime8Internal20halide_timebase_infoE@GOTPCREL(%rip), %rdx
	movl	(%rdx), %eax
	movl	4(%rdx), %esi
	imulq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$32, %rcx
	je	LBB17_1
## %bb.2:
	xorl	%edx, %edx
	divq	%rsi
	popq	%rbp
	retq
LBB17_1:
                                        ## kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%esi
                                        ## kill: def $eax killed $eax def $rax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_sleep_ms                ## -- Begin function halide_sleep_ms
	.weak_definition	_halide_sleep_ms
	.p2align	4, 0x90
_halide_sleep_ms:                       ## @halide_sleep_ms
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	imull	$1000, %esi, %edi               ## imm = 0x3E8
	popq	%rbp
	jmp	_usleep                         ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_print           ## -- Begin function halide_default_print
	.weak_definition	_halide_default_print
	.p2align	4, 0x90
_halide_default_print:                  ## @halide_default_print
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rsi, %rdi
	callq	_strlen
	movl	$1, %edi
	movq	%rbx, %rsi
	movq	%rax, %rdx
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmp	_write                          ## TAILCALL
                                        ## -- End function
	.globl	_halide_host_cpu_count          ## -- Begin function halide_host_cpu_count
	.weak_definition	_halide_host_cpu_count
	.p2align	4, 0x90
_halide_host_cpu_count:                 ## @halide_host_cpu_count
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$58, %edi
	popq	%rbp
	jmp	_sysconf                        ## TAILCALL
                                        ## -- End function
	.globl	_halide_thread_yield            ## -- Begin function halide_thread_yield
	.weak_definition	_halide_thread_yield
	.p2align	4, 0x90
_halide_thread_yield:                   ## @halide_thread_yield
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%edi, %edi
	popq	%rbp
	jmp	_swtch_pri                      ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_do_task         ## -- Begin function halide_default_do_task
	.weak_definition	_halide_default_do_task
	.p2align	4, 0x90
_halide_default_do_task:                ## @halide_default_do_task
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rsi, %rax
	movl	%edx, %esi
	movq	%rcx, %rdx
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_do_loop_task    ## -- Begin function halide_default_do_loop_task
	.weak_definition	_halide_default_do_loop_task
	.p2align	4, 0x90
_halide_default_do_loop_task:           ## @halide_default_do_loop_task
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rsi, %rax
	movl	%edx, %esi
	movl	%ecx, %edx
	movq	%r8, %rcx
	movq	%r9, %r8
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_do_par_for      ## -- Begin function halide_default_do_par_for
	.weak_definition	_halide_default_do_par_for
	.p2align	4, 0x90
_halide_default_do_par_for:             ## @halide_default_do_par_for
## %bb.0:                               ## %entry
	testl	%ecx, %ecx
	jle	LBB24_1
## %bb.2:                               ## %if.end
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$128, %rsp
	movq	$0, -144(%rbp)
	movl	%edx, -108(%rbp)
	movl	%ecx, -104(%rbp)
	movb	$0, -96(%rbp)
	movl	$0, -112(%rbp)
	movq	%r8, -136(%rbp)
	movl	$0, -100(%rbp)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, -128(%rbp)
	movq	%rsi, -88(%rbp)
	movq	%rdi, -40(%rbp)
	movq	$0, -32(%rbp)
	movl	$0, -24(%rbp)
	movb	$0, -20(%rbp)
	leaq	-144(%rbp), %rbx
	movq	%rbx, -72(%rbp)
	movl	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r14
	movq	%r14, %rdi
	callq	_halide_mutex_lock
	movl	$1, %edi
	movq	%rbx, %rsi
	xorl	%edx, %edx
	callq	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	movq	%r14, %rdi
	callq	_halide_mutex_unlock
	movl	-28(%rbp), %eax
	addq	$128, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB24_1:
	xorl	%eax, %eax
	retq
                                        ## -- End function
	.globl	_halide_mutex_lock              ## -- Begin function halide_mutex_lock
	.weak_definition	_halide_mutex_lock
	.p2align	4, 0x90
_halide_mutex_lock:                     ## @halide_mutex_lock
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movl	$1, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, (%rdi)
	jne	LBB25_1
LBB25_4:                                ## %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex4lockEv.exit
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB25_1:                                ## %if.then.i
	movq	%rdi, %rbx
	movq	(%rdi), %rax
	movl	$40, %r12d
	movq	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPCREL(%rip), %r15
	addq	$16, %r15
	leaq	-48(%rbp), %r14
	.p2align	4, 0x90
LBB25_2:                                ## %while.cond.outer.i.i
                                        ## =>This Inner Loop Header: Depth=1
	testb	$1, %al
	jne	LBB25_5
## %bb.3:                               ## %if.then.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	movq	%rax, %rcx
	orq	$1, %rcx
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB25_2
	jmp	LBB25_4
LBB25_5:                                ## %if.end4.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	testl	%r12d, %r12d
	jg	LBB25_6
## %bb.8:                               ## %if.end8.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	testb	$2, %al
	jne	LBB25_10
LBB25_9:                                ## %if.then10.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	movq	%rax, %rcx
	orq	$2, %rcx
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB25_2
	jmp	LBB25_10
LBB25_6:                                ## %_ZN6Halide7Runtime8Internal15Synchronization12spin_control11should_spinEv.exit.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	decl	%r12d
	je	LBB25_7
## %bb.12:                              ## %if.then6.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	callq	_halide_thread_yield
	movq	(%rbx), %rax
	jmp	LBB25_2
LBB25_7:                                ##   in Loop: Header=BB25_2 Depth=1
	xorl	%r12d, %r12d
	testb	$2, %al
	je	LBB25_9
LBB25_10:                               ## %if.end19.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	movq	%r15, -48(%rbp)
	movq	%rbx, -40(%rbp)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	cmpq	%rbx, %rax
	je	LBB25_4
## %bb.11:                              ## %if.end24.i.i
                                        ##   in Loop: Header=BB25_2 Depth=1
	movq	(%rbx), %rax
	movl	$40, %r12d
	jmp	LBB25_2
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_ ## -- Begin function _ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	.weak_definition	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_: ## @_ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rsi, %r14
	movl	%edi, %ebx
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r8
	cmpb	$0, 2121(%r8)
	movq	%rdx, -64(%rbp)                 ## 8-byte Spill
	je	LBB26_1
## %bb.9:                               ## %if.end4
	movl	%ebx, %r15d
	movl	%ebx, -48(%rbp)                 ## 4-byte Spill
	testl	%ebx, %ebx
	jle	LBB26_10
LBB26_20:                               ## %for.body.preheader
	movq	%r15, %rax
	shlq	$7, %rax
	movl	$-1, %r10d
	xorl	%ecx, %ecx
	movl	$1, %edi
	xorl	%r12d, %r12d
	xorl	%r9d, %r9d
	xorl	%ebx, %ebx
	xorl	%r13d, %r13d
	jmp	LBB26_21
	.p2align	4, 0x90
LBB26_22:                               ## %if.then23
                                        ##   in Loop: Header=BB26_21 Depth=1
	incl	%r10d
LBB26_24:                               ## %for.inc
                                        ##   in Loop: Header=BB26_21 Depth=1
	addl	%esi, %r12d
	subq	$-128, %rcx
	cmpq	%rcx, %rax
	je	LBB26_11
LBB26_21:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movl	44(%r14,%rcx), %esi
	testl	%esi, %esi
	movzbl	%r13b, %r13d
	cmovel	%edi, %r13d
	movzbl	%r9b, %r9d
	cmovnel	%edi, %r9d
	cmpl	$0, 32(%r14,%rcx)
	movzbl	%bl, %ebx
	cmovnel	%edi, %ebx
	cmpb	$0, 48(%r14,%rcx)
	jne	LBB26_22
## %bb.23:                              ## %if.else24
                                        ##   in Loop: Header=BB26_21 Depth=1
	addl	40(%r14,%rcx), %r10d
	jmp	LBB26_24
LBB26_11:                               ## %for.cond.cleanup.loopexit
	andb	$1, %bl
	andb	$1, %r9b
	andb	$1, %r13b
	testq	%rdx, %rdx
	movl	%r9d, -52(%rbp)                 ## 4-byte Spill
	je	LBB26_13
LBB26_25:                               ## %do.body61
	movl	112(%rdx), %eax
	imull	44(%rdx), %eax
	subl	96(%rdx), %eax
	cmpl	%eax, %r12d
	jle	LBB26_27
## %bb.26:                              ## %if.then66
	leaq	L_.str.3(%rip), %rsi
	xorl	%edi, %edi
	movl	%r10d, %r12d
	callq	_halide_print
	callq	_abort
	movl	%r12d, %r10d
	movl	-52(%rbp), %r9d                 ## 4-byte Reload
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r8
	movq	-64(%rbp), %rdx                 ## 8-byte Reload
LBB26_27:                               ## %do.end69
	movl	%ebx, %eax
	orb	%r9b, %al
	movl	-48(%rbp), %esi                 ## 4-byte Reload
	je	LBB26_29
## %bb.28:                              ## %if.then73
	incl	96(%rdx)
	jmp	LBB26_29
LBB26_1:                                ## %land.rhs.i.preheader
	leaq	12(%r8), %rax
	movl	$2128, %ecx                     ## imm = 0x850
	addq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rcx
	.p2align	4, 0x90
LBB26_2:                                ## %land.rhs.i
                                        ## =>This Inner Loop Header: Depth=1
	cmpb	$0, (%rax)
	jne	LBB26_4
## %bb.3:                               ## %while.body.i
                                        ##   in Loop: Header=BB26_2 Depth=1
	incq	%rax
	cmpq	%rcx, %rax
	jb	LBB26_2
LBB26_4:                                ## %do.body.i
	movl	$2128, %ecx                     ## imm = 0x850
	addq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rcx
	cmpq	%rcx, %rax
	je	LBB26_6
## %bb.5:                               ## %if.then.i
	leaq	L_.str.6(%rip), %rsi
	xorl	%edi, %edi
	callq	_halide_print
	callq	_abort
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r8
	movq	-64(%rbp), %rdx                 ## 8-byte Reload
LBB26_6:                                ## %_ZNK6Halide7Runtime8Internal12work_queue_t13assert_zeroedEv.exit
	movl	8(%r8), %eax
	testl	%eax, %eax
	jne	LBB26_8
## %bb.7:                               ## %if.then2
	callq	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r8
	movq	-64(%rbp), %rdx                 ## 8-byte Reload
LBB26_8:                                ## %if.end
	cmpl	$2, %eax
	movl	$1, %ecx
	cmovgel	%eax, %ecx
	cmpl	$256, %ecx                      ## imm = 0x100
	movl	$256, %eax                      ## imm = 0x100
	cmovll	%ecx, %eax
	movl	%eax, 8(%r8)
	movb	$1, 2121(%r8)
	movl	%ebx, %r15d
	movl	%ebx, -48(%rbp)                 ## 4-byte Spill
	testl	%ebx, %ebx
	jg	LBB26_20
LBB26_10:
	xorl	%r13d, %r13d
	movl	$-1, %r10d
	xorl	%ebx, %ebx
	xorl	%r9d, %r9d
	xorl	%r12d, %r12d
	testq	%rdx, %rdx
	movl	%r9d, -52(%rbp)                 ## 4-byte Spill
	jne	LBB26_25
LBB26_13:                               ## %if.then32
	movl	%r10d, -68(%rbp)                ## 4-byte Spill
	movl	%ebx, %eax
	orb	%r9b, %al
	setne	-41(%rbp)                       ## 1-byte Folded Spill
	movl	24(%r8), %ecx
	cmpl	$255, %ecx
	jg	LBB26_18
## %bb.14:                              ## %land.rhs.preheader
	movzbl	%al, %eax
	addl	%eax, %r12d
	jmp	LBB26_15
	.p2align	4, 0x90
LBB26_17:                               ## %while.body
                                        ##   in Loop: Header=BB26_15 Depth=1
	incl	28(%r8)
	movq	__ZN6Halide7Runtime8Internal13worker_threadEPv@GOTPCREL(%rip), %rdi
	xorl	%esi, %esi
	callq	_halide_spawn_thread
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r8
	movslq	24(%r8), %rdx
	leal	1(%rdx), %ecx
	movl	%ecx, 24(%r8)
	movq	%rax, 72(%r8,%rdx,8)
	cmpq	$255, %rdx
	jge	LBB26_18
LBB26_15:                               ## %land.rhs
                                        ## =>This Inner Loop Header: Depth=1
	movl	8(%r8), %eax
	decl	%eax
	cmpl	%eax, %ecx
	jl	LBB26_17
## %bb.16:                              ## %lor.rhs
                                        ##   in Loop: Header=BB26_15 Depth=1
	subl	2124(%r8), %ecx
	incl	%ecx
	cmpl	%r12d, %ecx
	jl	LBB26_17
LBB26_18:                               ## %do.end50
	cmpb	$0, -41(%rbp)                   ## 1-byte Folded Reload
	movl	-48(%rbp), %esi                 ## 4-byte Reload
	movl	-68(%rbp), %r10d                ## 4-byte Reload
	je	LBB26_29
## %bb.19:                              ## %if.then54
	incl	2124(%r8)
LBB26_29:                               ## %if.end77
	testl	%esi, %esi
	jle	LBB26_33
## %bb.30:                              ## %for.body83.preheader
	movq	16(%r8), %rax
	incq	%r15
	.p2align	4, 0x90
LBB26_31:                               ## %for.body83
                                        ## =>This Inner Loop Header: Depth=1
	leal	-2(%r15), %ecx
	shlq	$7, %rcx
	movq	%rax, 64(%r14,%rcx)
	leaq	(%r14,%rcx), %rax
	movq	%r14, 72(%r14,%rcx)
	movl	%esi, 80(%r14,%rcx)
	movl	$0, 96(%r14,%rcx)
	decq	%r15
	cmpq	$1, %r15
	ja	LBB26_31
## %bb.32:                              ## %for.cond80.for.cond.cleanup82_crit_edge
	movq	%r14, 16(%r8)
LBB26_33:                               ## %for.cond.cleanup82
	movl	24(%r8), %eax
	movl	64(%r8), %ecx
	cmpl	%ecx, %r10d
	cmovgl	%eax, %r10d
	cmpl	%eax, %ecx
	cmovll	%eax, %r10d
	cmpl	$0, 68(%r8)
	cmovnel	%eax, %r10d
	movl	%r10d, 32(%r8)
	leaq	40(%r8), %rdi
	callq	_halide_cond_broadcast
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rcx
	movl	32(%rcx), %eax
	cmpl	28(%rcx), %eax
	jle	LBB26_36
## %bb.34:                              ## %if.then107
	leaq	48(%rcx), %rdi
	callq	_halide_cond_broadcast
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rcx
	testb	%r13b, %r13b
	je	LBB26_36
## %bb.35:                              ## %if.then109
	leaq	56(%rcx), %rdi
	callq	_halide_cond_broadcast
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rcx
LBB26_36:                               ## %if.end111
	orb	-52(%rbp), %bl                  ## 1-byte Folded Reload
	je	LBB26_40
## %bb.37:                              ## %if.then115
	movq	-64(%rbp), %rax                 ## 8-byte Reload
	testq	%rax, %rax
	je	LBB26_39
## %bb.38:                              ## %if.then117
	decl	96(%rax)
	jmp	LBB26_40
LBB26_39:                               ## %if.else120
	decl	2124(%rcx)
LBB26_40:                               ## %if.end123
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ## -- Begin function _ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
LCPI27_0:
	.long	1                               ## 0x1
	.long	4294967295                      ## 0xffffffff
	.space	4
	.space	4
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	.weak_definition	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE: ## @_ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	movq	%rdi, %rbx
	xorl	%r14d, %r14d
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r13
	leaq	48(%r13), %rax
	movq	%rax, -88(%rbp)                 ## 8-byte Spill
	leaq	40(%r13), %rax
	movq	%rax, -80(%rbp)                 ## 8-byte Spill
	leaq	56(%r13), %rax
	movq	%rax, -64(%rbp)                 ## 8-byte Spill
	leaq	16(%r13), %rax
	movq	%rax, -104(%rbp)                ## 8-byte Spill
	jmp	LBB27_1
LBB27_90:                               ## %land.lhs.true307
                                        ##   in Loop: Header=BB27_1 Depth=1
	cmpb	$0, 124(%r12)
	movl	$0, %r14d
	je	LBB27_1
	.p2align	4, 0x90
LBB27_91:                               ## %if.then310
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_cond_broadcast
	xorl	%r14d, %r14d
LBB27_1:                                ## %while.cond
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB27_13 Depth 2
                                        ##     Child Loop BB27_11 Depth 2
                                        ##       Child Loop BB27_30 Depth 3
                                        ##     Child Loop BB27_51 Depth 2
                                        ##       Child Loop BB27_53 Depth 3
                                        ##         Child Loop BB27_54 Depth 4
                                        ##     Child Loop BB27_77 Depth 2
	testq	%rbx, %rbx
	je	LBB27_7
## %bb.2:                               ## %cond.true
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	112(%rbx), %eax
	movl	40(%rbx), %ecx
	orl	%eax, %ecx
	je	LBB27_92
## %bb.3:                               ## %if.then
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	16(%r13), %r12
	cmpl	$0, 116(%rbx)
	je	LBB27_16
## %bb.4:                               ## %if.then3
                                        ##   in Loop: Header=BB27_1 Depth=1
	testl	%eax, %eax
	jne	LBB27_9
## %bb.5:                               ## %while.cond6.preheader
                                        ##   in Loop: Header=BB27_1 Depth=1
	cmpq	%rbx, %r12
	je	LBB27_6
	.p2align	4, 0x90
LBB27_13:                               ## %while.body8
                                        ##   Parent Loop BB27_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	%r12, %rax
	movq	64(%r12), %r12
	cmpq	%rbx, %r12
	jne	LBB27_13
## %bb.14:                              ## %while.end.loopexit
                                        ##   in Loop: Header=BB27_1 Depth=1
	addq	$64, %rax
	jmp	LBB27_15
	.p2align	4, 0x90
LBB27_7:                                ## %cond.end
                                        ##   in Loop: Header=BB27_1 Depth=1
	cmpb	$0, 2120(%r13)
	jne	LBB27_92
## %bb.8:                               ## %while.body.thread
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	16(%r13), %r12
LBB27_9:                                ## %do.end
                                        ##   in Loop: Header=BB27_1 Depth=1
	testq	%r12, %r12
	je	LBB27_34
## %bb.10:                              ## %do.end27.preheader
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	-104(%rbp), %r15                ## 8-byte Reload
	jmp	LBB27_11
	.p2align	4, 0x90
LBB27_33:                               ## %cleanup
                                        ##   in Loop: Header=BB27_11 Depth=2
	movq	%r12, %r15
	movq	64(%r12), %rax
	addq	$64, %r15
	movq	%rax, %r12
	testq	%rax, %rax
	je	LBB27_34
LBB27_11:                               ## %do.end27
                                        ##   Parent Loop BB27_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB27_30 Depth 3
	movq	88(%r12), %rax
	testq	%rax, %rax
	je	LBB27_12
## %bb.19:                              ## %if.else32
                                        ##   in Loop: Header=BB27_11 Depth=2
	movl	44(%rax), %edx
	movl	112(%rax), %ecx
	testl	%ecx, %ecx
	je	LBB27_21
## %bb.20:                              ## %if.else38
                                        ##   in Loop: Header=BB27_11 Depth=2
	imull	%ecx, %edx
LBB27_21:                               ## %if.end45
                                        ##   in Loop: Header=BB27_11 Depth=2
	subl	96(%rax), %edx
	jmp	LBB27_22
	.p2align	4, 0x90
LBB27_12:                               ## %if.then31
                                        ##   in Loop: Header=BB27_11 Depth=2
	movl	24(%r13), %edx
	subl	2124(%r13), %edx
	incl	%edx
LBB27_22:                               ## %if.end45
                                        ##   in Loop: Header=BB27_11 Depth=2
	movl	44(%r12), %ecx
	movb	$1, %sil
	movb	$1, %dil
	testq	%rbx, %rbx
	je	LBB27_24
## %bb.23:                              ## %lor.lhs.false
                                        ##   in Loop: Header=BB27_11 Depth=2
	movq	72(%r12), %rdi
	cmpq	72(%rbx), %rdi
	sete	%r8b
	testl	%ecx, %ecx
	sete	%dil
	orb	%r8b, %dil
LBB27_24:                               ## %lor.end
                                        ##   in Loop: Header=BB27_11 Depth=2
	cmpb	$0, 48(%r12)
	je	LBB27_26
## %bb.25:                              ## %lor.rhs70
                                        ##   in Loop: Header=BB27_11 Depth=2
	cmpl	$0, 112(%r12)
	sete	%sil
LBB27_26:                               ## %lor.end73
                                        ##   in Loop: Header=BB27_11 Depth=2
	cmpl	%ecx, %edx
	jl	LBB27_33
## %bb.27:                              ## %lor.end73
                                        ##   in Loop: Header=BB27_11 Depth=2
	xorb	$1, %dil
	jne	LBB27_33
## %bb.28:                              ## %lor.end73
                                        ##   in Loop: Header=BB27_11 Depth=2
	testb	%sil, %sil
	je	LBB27_33
## %bb.29:                              ## %if.then86
                                        ##   in Loop: Header=BB27_11 Depth=2
	movl	120(%r12), %edx
	cmpl	32(%r12), %edx
	jge	LBB27_45
	.p2align	4, 0x90
LBB27_30:                               ## %for.body.i
                                        ##   Parent Loop BB27_1 Depth=1
                                        ##     Parent Loop BB27_11 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movq	24(%r12), %rax
	movslq	%edx, %rcx
	shlq	$4, %rcx
	movq	(%rax,%rcx), %rdi
	movl	8(%rax,%rcx), %esi
	callq	_halide_default_semaphore_try_acquire
	testb	%al, %al
	je	LBB27_33
## %bb.31:                              ## %for.inc.i
                                        ##   in Loop: Header=BB27_30 Depth=3
	movl	120(%r12), %edx
	incl	%edx
	movl	%edx, 120(%r12)
	cmpl	32(%r12), %edx
	jl	LBB27_30
## %bb.32:                              ## %if.else127.loopexit
                                        ##   in Loop: Header=BB27_1 Depth=1
	leaq	88(%r12), %rsi
	leaq	44(%r12), %rdx
	movq	88(%r12), %rax
	movl	44(%r12), %ecx
	movl	$0, 120(%r12)
	incl	112(%r12)
	testq	%rax, %rax
	je	LBB27_47
LBB27_48:                               ## %if.else143
                                        ##   in Loop: Header=BB27_1 Depth=1
	addl	%ecx, 96(%rax)
	cmpb	$0, 48(%r12)
	movq	%rdx, -56(%rbp)                 ## 8-byte Spill
	movq	%rsi, -48(%rbp)                 ## 8-byte Spill
	je	LBB27_69
LBB27_50:                               ## %if.then156
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	64(%r12), %rax
	movq	%rax, (%r15)
	movq	%r13, %rdi
	callq	_halide_mutex_unlock
	xorl	%r14d, %r14d
	movl	$1, %r15d
	.p2align	4, 0x90
LBB27_51:                               ## %while.cond161.preheader
                                        ##   Parent Loop BB27_1 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB27_53 Depth 3
                                        ##         Child Loop BB27_54 Depth 4
	movl	40(%r12), %ecx
	movl	%ecx, %eax
	subl	%r14d, %eax
	cmpl	%r15d, %eax
	jle	LBB27_60
## %bb.52:                              ## %land.rhs.preheader
                                        ##   in Loop: Header=BB27_51 Depth=2
	movl	32(%r12), %eax
	movl	120(%r12), %edx
	jmp	LBB27_53
	.p2align	4, 0x90
LBB27_57:                               ## %while.body167
                                        ##   in Loop: Header=BB27_53 Depth=3
	movl	$0, 120(%r12)
	incl	%r15d
	movl	%ecx, %esi
	subl	%r14d, %esi
	xorl	%edx, %edx
	cmpl	%r15d, %esi
	jle	LBB27_58
LBB27_53:                               ## %land.rhs
                                        ##   Parent Loop BB27_1 Depth=1
                                        ##     Parent Loop BB27_51 Depth=2
                                        ## =>    This Loop Header: Depth=3
                                        ##         Child Loop BB27_54 Depth 4
	cmpl	%eax, %edx
	jge	LBB27_57
	.p2align	4, 0x90
LBB27_54:                               ## %for.body.i441
                                        ##   Parent Loop BB27_1 Depth=1
                                        ##     Parent Loop BB27_51 Depth=2
                                        ##       Parent Loop BB27_53 Depth=3
                                        ## =>      This Inner Loop Header: Depth=4
	movq	24(%r12), %rax
	movslq	%edx, %rcx
	shlq	$4, %rcx
	movq	(%rax,%rcx), %rdi
	movl	8(%rax,%rcx), %esi
	callq	_halide_default_semaphore_try_acquire
	testb	%al, %al
	je	LBB27_60
## %bb.55:                              ## %for.inc.i444
                                        ##   in Loop: Header=BB27_54 Depth=4
	movl	32(%r12), %eax
	movl	120(%r12), %edx
	incl	%edx
	movl	%edx, 120(%r12)
	cmpl	%eax, %edx
	jl	LBB27_54
## %bb.56:                              ## %while.body167.loopexit
                                        ##   in Loop: Header=BB27_53 Depth=3
	movl	40(%r12), %ecx
	jmp	LBB27_57
	.p2align	4, 0x90
LBB27_60:                               ## %while.end169
                                        ##   in Loop: Header=BB27_51 Depth=2
	testl	%r15d, %r15d
	je	LBB27_61
LBB27_58:                               ## %if.end172
                                        ##   in Loop: Header=BB27_51 Depth=2
	movq	104(%r12), %rdi
	movl	36(%r12), %edx
	addl	%r14d, %edx
	movq	(%r12), %rsi
	movq	8(%r12), %r8
	movl	%r15d, %ecx
	movq	%r12, %r9
	callq	_halide_do_loop_task
	addl	%r15d, %r14d
	xorl	%r15d, %r15d
	testl	%eax, %eax
	je	LBB27_51
## %bb.59:                              ##   in Loop: Header=BB27_1 Depth=1
	movl	%eax, %r13d
	jmp	LBB27_62
	.p2align	4, 0x90
LBB27_34:                               ## %if.then103
                                        ##   in Loop: Header=BB27_1 Depth=1
	testq	%rbx, %rbx
	je	LBB27_38
## %bb.35:                              ## %if.then105
                                        ##   in Loop: Header=BB27_1 Depth=1
	leal	1(%r14), %r15d
	cmpl	$39, %r14d
	jg	LBB27_37
## %bb.36:                              ## %if.then107
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	%r13, %rdi
	callq	_halide_mutex_unlock
	callq	_halide_thread_yield
	movq	%r13, %rdi
	callq	_halide_mutex_lock
	movl	%r15d, %r14d
	jmp	LBB27_1
	.p2align	4, 0x90
LBB27_16:                               ## %if.else
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	88(%rbx), %rax
	testq	%rax, %rax
	je	LBB27_9
## %bb.17:                              ## %land.lhs.true
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	116(%rax), %eax
	testl	%eax, %eax
	je	LBB27_9
## %bb.18:                              ## %if.then15
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	%eax, 116(%rbx)
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_cond_broadcast
	jmp	LBB27_1
LBB27_61:                               ##   in Loop: Header=BB27_1 Depth=1
	xorl	%r13d, %r13d
	movb	$1, %r15b
LBB27_62:                               ## %while.end179
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	addl	%r14d, 36(%r12)
	movl	40(%r12), %eax
	subl	%r14d, %eax
	movl	%eax, 40(%r12)
	testb	%r15b, %r15b
	je	LBB27_63
## %bb.66:                              ## %if.else190
                                        ##   in Loop: Header=BB27_1 Depth=1
	testl	%eax, %eax
	jle	LBB27_67
## %bb.68:                              ## %if.then194
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rcx
	movq	16(%rcx), %rax
	movq	%rax, 64(%r12)
	movq	%r12, 16(%rcx)
LBB27_67:                               ##   in Loop: Header=BB27_1 Depth=1
	xorl	%eax, %eax
	movq	-56(%rbp), %r8                  ## 8-byte Reload
	movq	-48(%rbp), %r9                  ## 8-byte Reload
	movq	(%r9), %rcx
	movl	(%r8), %edx
	testq	%rcx, %rcx
	jne	LBB27_85
	jmp	LBB27_84
LBB27_63:                               ## %if.end230.thread461
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	$0, 40(%r12)
	movq	-56(%rbp), %r8                  ## 8-byte Reload
	movq	-48(%rbp), %r9                  ## 8-byte Reload
	jmp	LBB27_64
LBB27_38:                               ## %if.else112
                                        ##   in Loop: Header=BB27_1 Depth=1
	incl	64(%r13)
	movl	28(%r13), %eax
	cmpl	32(%r13), %eax
	jle	LBB27_40
## %bb.39:                              ## %if.then115
                                        ##   in Loop: Header=BB27_1 Depth=1
	decl	%eax
	movl	%eax, 28(%r13)
	movq	-88(%rbp), %rdi                 ## 8-byte Reload
	movq	%r13, %rsi
	callq	_halide_cond_wait
	incl	28(%r13)
	decl	64(%r13)
	jmp	LBB27_1
LBB27_37:                               ## %if.else108
                                        ##   in Loop: Header=BB27_1 Depth=1
	incl	68(%r13)
	movb	$1, 124(%rbx)
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	movq	%r13, %rsi
	callq	_halide_cond_wait
	movb	$0, 124(%rbx)
	decl	68(%r13)
	movl	%r15d, %r14d
	jmp	LBB27_1
LBB27_40:                               ## %if.else118
                                        ##   in Loop: Header=BB27_1 Depth=1
	leal	1(%r14), %r15d
	cmpl	$39, %r14d
	jg	LBB27_42
## %bb.41:                              ## %if.then121
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	%r13, %rdi
	callq	_halide_mutex_unlock
	callq	_halide_thread_yield
	movq	%r13, %rdi
	callq	_halide_mutex_lock
	jmp	LBB27_43
LBB27_6:                                ##   in Loop: Header=BB27_1 Depth=1
	leaq	16(%r13), %rax
LBB27_15:                               ## %while.end
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	64(%rbx), %rcx
	movq	%rcx, (%rax)
	movl	$0, 40(%rbx)
	jmp	LBB27_1
LBB27_42:                               ## %if.else122
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	-80(%rbp), %rdi                 ## 8-byte Reload
	movq	%r13, %rsi
	callq	_halide_cond_wait
LBB27_43:                               ## %if.end124
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	%r15d, %r14d
	decl	64(%r13)
	jmp	LBB27_1
LBB27_45:                               ## %if.else127.loopexit63
                                        ##   in Loop: Header=BB27_1 Depth=1
	leaq	88(%r12), %rsi
	leaq	44(%r12), %rdx
	movl	$0, 120(%r12)
	incl	112(%r12)
	testq	%rax, %rax
	jne	LBB27_48
LBB27_47:                               ## %if.then136
                                        ##   in Loop: Header=BB27_1 Depth=1
	addl	%ecx, 2124(%r13)
	cmpb	$0, 48(%r12)
	movq	%rdx, -56(%rbp)                 ## 8-byte Spill
	movq	%rsi, -48(%rbp)                 ## 8-byte Spill
	jne	LBB27_50
LBB27_69:                               ## %if.else198
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	(%r12), %rax
	movq	%rax, -96(%rbp)                 ## 8-byte Spill
	movq	8(%r12), %rax
	movq	%rax, -72(%rbp)                 ## 8-byte Spill
	movq	56(%r12), %r13
	movq	104(%r12), %r14
	vmovq	36(%r12), %xmm0                 ## xmm0 = mem[0],zero
	vmovdqa	%xmm0, -128(%rbp)               ## 16-byte Spill
	vpaddd	LCPI27_0(%rip), %xmm0, %xmm0
	vmovq	%xmm0, 36(%r12)
	vpextrd	$1, %xmm0, %eax
	testl	%eax, %eax
	jne	LBB27_71
## %bb.70:                              ## %if.then208
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	64(%r12), %rax
	movq	%rax, (%r15)
LBB27_71:                               ## %if.end210
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	vmovdqa	-128(%rbp), %xmm0               ## 16-byte Reload
	vmovd	%xmm0, %edx
	movq	%r14, %rdi
	testq	%r13, %r13
	je	LBB27_73
## %bb.72:                              ## %if.then212
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	%r13, %rsi
	movq	-72(%rbp), %rcx                 ## 8-byte Reload
	callq	_halide_do_task
	jmp	LBB27_74
LBB27_73:                               ## %if.else220
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	-96(%rbp), %rsi                 ## 8-byte Reload
	movl	$1, %ecx
	movq	-72(%rbp), %r8                  ## 8-byte Reload
	movq	%r12, %r9
	callq	_halide_do_loop_task
LBB27_74:                               ## %if.end230
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	%eax, %r13d
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	testl	%r13d, %r13d
	movq	-56(%rbp), %r8                  ## 8-byte Reload
	movq	-48(%rbp), %r9                  ## 8-byte Reload
	je	LBB27_75
LBB27_64:                               ## %if.then238
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	%r13d, 116(%r12)
	movl	80(%r12), %ecx
	testl	%ecx, %ecx
	jle	LBB27_65
## %bb.76:                              ## %do.end243.lr.ph
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	72(%r12), %rdx
	shlq	$7, %rcx
	xorl	%esi, %esi
	xorl	%eax, %eax
	jmp	LBB27_77
LBB27_80:                               ## %land.rhs254
                                        ##   in Loop: Header=BB27_77 Depth=2
	movzbl	124(%rdx,%rsi), %edi
LBB27_81:                               ## %land.end260
                                        ##   in Loop: Header=BB27_77 Depth=2
	andb	$1, %al
	orb	%dil, %al
LBB27_82:                               ## %for.inc
                                        ##   in Loop: Header=BB27_77 Depth=2
	subq	$-128, %rsi
	cmpq	%rsi, %rcx
	je	LBB27_83
LBB27_77:                               ## %do.end243
                                        ##   Parent Loop BB27_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpl	$0, 116(%rdx,%rsi)
	jne	LBB27_82
## %bb.78:                              ## %if.then247
                                        ##   in Loop: Header=BB27_77 Depth=2
	movl	%r13d, 116(%rdx,%rsi)
	cmpl	$0, 112(%r12)
	je	LBB27_80
## %bb.79:                              ##   in Loop: Header=BB27_77 Depth=2
	xorl	%edi, %edi
	jmp	LBB27_81
LBB27_65:                               ##   in Loop: Header=BB27_1 Depth=1
	xorl	%eax, %eax
	.p2align	4, 0x90
LBB27_83:                               ## %if.end271
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	(%r9), %rcx
	movl	(%r8), %edx
	testq	%rcx, %rcx
	je	LBB27_84
LBB27_85:                               ## %if.else281
                                        ##   in Loop: Header=BB27_1 Depth=1
	subl	%edx, 96(%rcx)
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r13
	jmp	LBB27_86
LBB27_75:                               ##   in Loop: Header=BB27_1 Depth=1
	xorl	%eax, %eax
	movq	(%r9), %rcx
	movl	(%r8), %edx
	testq	%rcx, %rcx
	jne	LBB27_85
LBB27_84:                               ## %if.then274
                                        ##   in Loop: Header=BB27_1 Depth=1
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r13
	subl	%edx, 2124(%r13)
LBB27_86:                               ## %if.end290
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	112(%r12), %ecx
	decl	%ecx
	movl	%ecx, 112(%r12)
	testb	$1, %al
	jne	LBB27_91
## %bb.87:                              ## %lor.lhs.false297
                                        ##   in Loop: Header=BB27_1 Depth=1
	movl	$0, %r14d
	testl	%ecx, %ecx
	jne	LBB27_1
## %bb.88:                              ## %land.lhs.true300
                                        ##   in Loop: Header=BB27_1 Depth=1
	cmpl	$0, 40(%r12)
	je	LBB27_90
## %bb.89:                              ## %lor.lhs.false304
                                        ##   in Loop: Header=BB27_1 Depth=1
	cmpl	$0, 116(%r12)
	movl	$0, %r14d
	jne	LBB27_90
	jmp	LBB27_1
LBB27_92:                               ## %while.end316
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_mutex_unlock            ## -- Begin function halide_mutex_unlock
	.weak_definition	_halide_mutex_unlock
	.p2align	4, 0x90
_halide_mutex_unlock:                   ## @halide_mutex_unlock
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, (%rdi)
	je	LBB28_3
## %bb.1:                               ## %if.then.i
	movq	%rdi, %rsi
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, (%rdi)
	je	LBB28_3
## %bb.2:                               ## %if.end.i.i
	movq	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rax, -16(%rbp)
	movq	%rsi, -8(%rbp)
	leaq	-16(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
LBB28_3:                                ## %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex6unlockEv.exit
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy: ## @_ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rsi, %r15
	movq	%rdi, -56(%rbp)                 ## 8-byte Spill
	movq	%rsi, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	movq	%rax, %rbx
	movq	8(%rax), %r12
	movq	%rax, %r13
	addq	$8, %r13
	xorl	%eax, %eax
	movq	%rax, -64(%rbp)                 ## 8-byte Spill
                                        ## implicit-def: $rax
                                        ## kill: killed $rax
	jmp	LBB29_2
	.p2align	4, 0x90
LBB29_1:                                ##   in Loop: Header=BB29_2 Depth=1
	leaq	144(%r12), %r13
	movq	%r12, -64(%rbp)                 ## 8-byte Spill
	movq	%rax, %r12
	cmpq	%r15, %r14
	je	LBB29_22
LBB29_2:                                ## %while.cond
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB29_6 Depth 2
                                        ##     Child Loop BB29_12 Depth 2
	testq	%r12, %r12
	je	LBB29_17
## %bb.3:                               ## %while.body
                                        ##   in Loop: Header=BB29_2 Depth=1
	movq	136(%r12), %r14
	movq	144(%r12), %rax
	cmpq	%r15, %r14
	jne	LBB29_1
## %bb.4:                               ## %if.then
                                        ##   in Loop: Header=BB29_2 Depth=1
	movq	%rax, (%r13)
	cmpq	%r12, 16(%rbx)
	je	LBB29_9
## %bb.5:                               ## %while.cond7.preheader
                                        ##   in Loop: Header=BB29_2 Depth=1
	testq	%rax, %rax
	je	LBB29_10
	.p2align	4, 0x90
LBB29_6:                                ## %while.body9
                                        ##   Parent Loop BB29_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	136(%rax), %rcx
	movq	144(%rax), %rax
	testq	%rax, %rax
	je	LBB29_8
## %bb.7:                               ## %while.body9
                                        ##   in Loop: Header=BB29_6 Depth=2
	cmpq	%r15, %rcx
	jne	LBB29_6
LBB29_8:                                ## %if.end.loopexit
                                        ##   in Loop: Header=BB29_2 Depth=1
	cmpq	%r15, %rcx
	sete	%al
	jmp	LBB29_11
LBB29_9:                                ## %if.then5
                                        ##   in Loop: Header=BB29_2 Depth=1
	movq	-64(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, 16(%rbx)
LBB29_10:                               ##   in Loop: Header=BB29_2 Depth=1
	xorl	%eax, %eax
LBB29_11:                               ## %if.end
                                        ##   in Loop: Header=BB29_2 Depth=1
	movq	-56(%rbp), %rdi                 ## 8-byte Reload
	movq	(%rdi), %rcx
	movzbl	%al, %edx
	movl	$1, %esi
	movq	%rdx, -48(%rbp)                 ## 8-byte Spill
                                        ## kill: def $edx killed $edx killed $rdx
	callq	*16(%rcx)
	movq	%rax, 152(%r12)
	movq	%r12, %rdi
	callq	_pthread_mutex_lock
	movq	(%rbx), %rax
	.p2align	4, 0x90
LBB29_12:                               ## %atomicrmw.start
                                        ##   Parent Loop BB29_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB29_12
## %bb.13:                              ## %atomicrmw.end
                                        ##   in Loop: Header=BB29_2 Depth=1
	cmpq	$4, %rax
	jb	LBB29_16
## %bb.14:                              ## %atomicrmw.end
                                        ##   in Loop: Header=BB29_2 Depth=1
	andl	$2, %eax
	jne	LBB29_16
## %bb.15:                              ## %if.then.i
                                        ##   in Loop: Header=BB29_2 Depth=1
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB29_16:                               ## %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit
                                        ##   in Loop: Header=BB29_2 Depth=1
	movb	$0, 128(%r12)
	leaq	64(%r12), %rdi
	callq	_pthread_cond_signal
	movq	%r12, %rdi
	callq	_pthread_mutex_unlock
	cmpq	%r15, %r14
	jne	LBB29_2
	jmp	LBB29_22
LBB29_17:                               ## %while.end22
	movq	-56(%rbp), %rdi                 ## 8-byte Reload
	movq	(%rdi), %rax
	xorl	%esi, %esi
	xorl	%edx, %edx
	callq	*16(%rax)
	movq	(%rbx), %rax
	.p2align	4, 0x90
LBB29_18:                               ## %atomicrmw.start2
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB29_18
## %bb.19:                              ## %atomicrmw.end1
	xorl	%ecx, %ecx
	movq	%rcx, -48(%rbp)                 ## 8-byte Spill
	cmpq	$4, %rax
	jb	LBB29_22
## %bb.20:                              ## %atomicrmw.end1
	andl	$2, %eax
	jne	LBB29_22
## %bb.21:                              ## %if.then.i60
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
	xorl	%eax, %eax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
LBB29_22:                               ## %cleanup27
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy: ## @_ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movabsq	$-7046029254386353131, %rax     ## imm = 0x9E3779B97F4A7C15
	imulq	%rdi, %rax
	shrq	$54, %rax
	leaq	(%rax,%rax,2), %rcx
	movq	__ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPCREL(%rip), %rdx
	leaq	(%rdx,%rcx,8), %rbx
	movl	$1, %esi
	xorl	%eax, %eax
	lock		cmpxchgq	%rsi, (%rdx,%rcx,8)
	je	LBB30_2
## %bb.1:                               ## %if.then.i
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB30_2:                                ## %_ZN6Halide7Runtime8Internal15Synchronization9word_lock4lockEv.exit
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv: ## @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	(%rdi), %r14
	.p2align	4, 0x90
LBB31_1:                                ## %while.cond
                                        ## =>This Inner Loop Header: Depth=1
	cmpq	$4, %r14
	jb	LBB31_18
## %bb.2:                               ## %while.cond
                                        ##   in Loop: Header=BB31_1 Depth=1
	movl	%r14d, %eax
	andl	$2, %eax
	jne	LBB31_18
## %bb.3:                               ## %if.end
                                        ##   in Loop: Header=BB31_1 Depth=1
	movq	%r14, %rcx
	orq	$2, %rcx
	movq	%r14, %rax
	lock		cmpxchgq	%rcx, (%rbx)
	movq	%rax, %r14
	jne	LBB31_1
	jmp	LBB31_4
	.p2align	4, 0x90
LBB31_11:                               ##   in Loop: Header=BB31_4 Depth=1
	movq	%rax, %r14
	##MEMBARRIER
	jmp	LBB31_4
	.p2align	4, 0x90
LBB31_5:                                ## %while.body17.preheader
                                        ##   in Loop: Header=BB31_4 Depth=1
	movq	-48(%rbp), %r15                 ## 8-byte Reload
	jmp	LBB31_6
	.p2align	4, 0x90
LBB31_8:                                ## %do.end
                                        ##   in Loop: Header=BB31_6 Depth=2
	movq	%r15, 144(%r13)
	movq	152(%r13), %r12
	movq	%r13, %r15
	testq	%r12, %r12
	jne	LBB31_9
LBB31_6:                                ## %while.body17
                                        ##   Parent Loop BB31_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	136(%r15), %r13
	testq	%r13, %r13
	jne	LBB31_8
## %bb.7:                               ## %if.then20
                                        ##   in Loop: Header=BB31_6 Depth=2
	xorl	%edi, %edi
	leaq	L_.str.5(%rip), %rsi
	callq	_halide_print
	callq	_abort
	jmp	LBB31_8
	.p2align	4, 0x90
LBB31_4:                                ## %while.cond11
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB31_6 Depth 2
                                        ##     Child Loop BB31_13 Depth 2
	movq	%r14, %rax
	andq	$-4, %rax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
	movq	152(%rax), %r12
	testq	%r12, %r12
	je	LBB31_5
LBB31_9:                                ## %while.end23
                                        ##   in Loop: Header=BB31_4 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	%r12, 152(%rax)
	testb	$1, %r14b
	jne	LBB31_10
## %bb.12:                              ## %if.end35
                                        ##   in Loop: Header=BB31_4 Depth=1
	movq	144(%r12), %rax
	testq	%rax, %rax
	jne	LBB31_16
	.p2align	4, 0x90
LBB31_13:                               ## %while.body41
                                        ##   Parent Loop BB31_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	%r14d, %ecx
	andl	$1, %ecx
	movq	%r14, %rax
	lock		cmpxchgq	%rcx, (%rbx)
	je	LBB31_17
## %bb.14:                              ## %if.end47
                                        ##   in Loop: Header=BB31_13 Depth=2
	movq	%rax, %r14
	cmpq	$4, %rax
	jb	LBB31_13
## %bb.15:                              ## %cleanup70
                                        ##   in Loop: Header=BB31_4 Depth=1
	##MEMBARRIER
	jmp	LBB31_4
	.p2align	4, 0x90
LBB31_10:                               ## %if.then27
                                        ##   in Loop: Header=BB31_4 Depth=1
	movq	%r14, %rcx
	andq	$-3, %rcx
	movq	%r14, %rax
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB31_11
LBB31_18:                               ## %cleanup75
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB31_16:                               ## %if.else62
	movq	-48(%rbp), %rcx                 ## 8-byte Reload
	movq	%rax, 152(%rcx)
	lock		andq	$-3, (%rbx)
LBB31_17:                               ## %if.end66
	movq	%r12, %rdi
	callq	_pthread_mutex_lock
	movb	$0, 128(%r12)
	leaq	64(%r12), %rdi
	callq	_pthread_cond_signal
	movq	%r12, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_pthread_mutex_unlock           ## TAILCALL
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LCPI32_0:
	.space	16
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv: ## @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$168, %rsp
	movq	%rdi, %rbx
	movq	(%rdi), %r12
	movl	$40, %r13d
	leaq	-136(%rbp), %r14
	leaq	-200(%rbp), %r15
	jmp	LBB32_1
LBB32_16:                               ## %_ZN6Halide7Runtime8Internal15Synchronization13thread_parker4parkEv.exit
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%r15, %rdi
	callq	_pthread_mutex_unlock
	movq	(%rbx), %r12
	movl	$40, %r13d
LBB32_17:                               ## %if.end22
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%r14, %rdi
	callq	_pthread_cond_destroy
	movq	%r15, %rdi
	callq	_pthread_mutex_destroy
	.p2align	4, 0x90
LBB32_1:                                ## %while.cond.outer
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB32_14 Depth 2
	testb	$1, %r12b
	jne	LBB32_4
## %bb.2:                               ## %if.then
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%r12, %rcx
	orq	$1, %rcx
	movq	%r12, %rax
	lock		cmpxchgq	%rcx, (%rbx)
	je	LBB32_18
## %bb.3:                               ## %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_acquire_relaxedEPyS4_S4_.exit
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%rax, %r12
	jmp	LBB32_1
LBB32_4:                                ## %if.end4
                                        ##   in Loop: Header=BB32_1 Depth=1
	cmpq	$4, %r12
	jb	LBB32_8
## %bb.5:                               ## %if.end4
                                        ##   in Loop: Header=BB32_1 Depth=1
	testl	%r13d, %r13d
	jle	LBB32_8
## %bb.6:                               ## %_ZN6Halide7Runtime8Internal15Synchronization12spin_control11should_spinEv.exit
                                        ##   in Loop: Header=BB32_1 Depth=1
	decl	%r13d
	je	LBB32_7
## %bb.19:                              ## %if.then7
                                        ##   in Loop: Header=BB32_1 Depth=1
	callq	_halide_thread_yield
	movq	(%rbx), %r12
	jmp	LBB32_1
LBB32_7:                                ##   in Loop: Header=BB32_1 Depth=1
	xorl	%r13d, %r13d
LBB32_8:                                ## %if.end9
                                        ##   in Loop: Header=BB32_1 Depth=1
	movb	$0, -72(%rbp)
	movq	%r15, %rdi
	xorl	%esi, %esi
	callq	_pthread_mutex_init
	movq	%r14, %rdi
	xorl	%esi, %esi
	callq	_pthread_cond_init
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, -64(%rbp)
	movq	$0, -48(%rbp)
	movb	$1, -72(%rbp)
	movq	%r12, %rax
	andq	$-4, %rax
	je	LBB32_9
## %bb.10:                              ## %if.else
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%rax, -64(%rbp)
	jmp	LBB32_11
LBB32_9:                                ## %if.then12
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%r15, -48(%rbp)
LBB32_11:                               ## %if.end13
                                        ##   in Loop: Header=BB32_1 Depth=1
	movl	%r12d, %ecx
	andl	$3, %ecx
	orq	%r15, %rcx
	movq	%r12, %rax
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB32_12
## %bb.13:                              ## %if.then19
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%r15, %rdi
	callq	_pthread_mutex_lock
	cmpb	$0, -72(%rbp)
	je	LBB32_16
	.p2align	4, 0x90
LBB32_14:                               ## %while.body.i
                                        ##   Parent Loop BB32_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	_pthread_cond_wait
	cmpb	$0, -72(%rbp)
	jne	LBB32_14
	jmp	LBB32_16
LBB32_12:                               ## %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_release_relaxedEPyS4_S4_.exit
                                        ##   in Loop: Header=BB32_1 Depth=1
	movq	%rax, %r12
	jmp	LBB32_17
LBB32_18:                               ## %cleanup23
	addq	$168, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE: ## @_ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	8(%rdi), %rax
	movq	(%rax), %rax
	cmpq	$3, %rax
	sete	%al
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv: ## @_ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib: ## @_ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edx, %eax
	addq	%rax, %rax
	movq	8(%rdi), %rcx
	movq	%rax, (%rcx)
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb: ## @_ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_cond_broadcast          ## -- Begin function halide_cond_broadcast
	.weak_definition	_halide_cond_broadcast
	.p2align	4, 0x90
_halide_cond_broadcast:                 ## @halide_cond_broadcast
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	(%rdi), %rdx
	testq	%rdx, %rdx
	je	LBB37_2
## %bb.1:                               ## %if.end.i
	movq	%rdi, %rsi
	movq	__ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rax, -24(%rbp)
	movq	%rdi, -16(%rbp)
	movq	%rdx, -8(%rbp)
	leaq	-24(%rbp), %rdi
	xorl	%ecx, %ecx
	callq	__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
LBB37_2:                                ## %_ZN6Halide7Runtime8Internal15Synchronization9fast_cond9broadcastEv.exit
	addq	$32, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_semaphore_try_acquire ## -- Begin function halide_default_semaphore_try_acquire
	.weak_definition	_halide_default_semaphore_try_acquire
	.p2align	4, 0x90
_halide_default_semaphore_try_acquire:  ## @halide_default_semaphore_try_acquire
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	testl	%esi, %esi
	je	LBB38_1
## %bb.2:                               ## %if.end
	movl	(%rdi), %eax
	mfence
	movl	(%rdi), %eax
	movl	%eax, %edx
	subl	%esi, %edx
	js	LBB38_3
	.p2align	4, 0x90
LBB38_4:                                ## %land.rhs
                                        ## =>This Inner Loop Header: Depth=1
	lock		cmpxchgl	%edx, (%rdi)
	sete	%cl
	je	LBB38_6
## %bb.5:                               ## %land.rhs
                                        ##   in Loop: Header=BB38_4 Depth=1
	movl	%eax, %edx
	subl	%esi, %edx
	jns	LBB38_4
LBB38_6:                                ## %return
	movl	%ecx, %eax
	popq	%rbp
	retq
LBB38_1:
	movb	$1, %cl
	movl	%ecx, %eax
	popq	%rbp
	retq
LBB38_3:
	xorl	%ecx, %ecx
	movl	%ecx, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_cond_wait               ## -- Begin function halide_cond_wait
	.weak_definition	_halide_cond_wait
	.p2align	4, 0x90
_halide_cond_wait:                      ## @halide_cond_wait
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	movq	__ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rax, -72(%rbp)
	movq	%rdi, -64(%rbp)
	movq	%rbx, -56(%rbp)
	leaq	-72(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	cmpq	%rbx, %rax
	jne	LBB39_1
## %bb.12:                              ## %if.else.i
	movq	(%rbx), %rax
	testb	$1, %al
	jne	LBB39_14
## %bb.13:                              ## %if.then2.i
	leaq	L_.str.5.6(%rip), %rsi
	xorl	%edi, %edi
	callq	_halide_print
	callq	_abort
	jmp	LBB39_14
LBB39_1:                                ## %if.then.i
	movl	$1, %ecx
	xorl	%eax, %eax
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB39_2
LBB39_14:                               ## %_ZN6Halide7Runtime8Internal15Synchronization9fast_cond4waitEPNS2_10fast_mutexE.exit
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB39_2:                                ## %if.then.i.i
	movq	(%rbx), %rax
	movl	$40, %r12d
	movq	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPCREL(%rip), %r15
	addq	$16, %r15
	leaq	-48(%rbp), %r14
	.p2align	4, 0x90
LBB39_3:                                ## %while.cond.outer.i.i.i
                                        ## =>This Inner Loop Header: Depth=1
	testb	$1, %al
	jne	LBB39_5
## %bb.4:                               ## %if.then.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	movq	%rax, %rcx
	orq	$1, %rcx
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB39_3
	jmp	LBB39_14
LBB39_5:                                ## %if.end4.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	testl	%r12d, %r12d
	jg	LBB39_6
## %bb.8:                               ## %if.end8.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	testb	$2, %al
	jne	LBB39_10
LBB39_9:                                ## %if.then10.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	movq	%rax, %rcx
	orq	$2, %rcx
	lock		cmpxchgq	%rcx, (%rbx)
	jne	LBB39_3
	jmp	LBB39_10
LBB39_6:                                ## %_ZN6Halide7Runtime8Internal15Synchronization12spin_control11should_spinEv.exit.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	decl	%r12d
	je	LBB39_7
## %bb.15:                              ## %if.then6.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	callq	_halide_thread_yield
	movq	(%rbx), %rax
	jmp	LBB39_3
LBB39_7:                                ##   in Loop: Header=BB39_3 Depth=1
	xorl	%r12d, %r12d
	testb	$2, %al
	je	LBB39_9
LBB39_10:                               ## %if.end19.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	movq	%r15, -48(%rbp)
	movq	%rbx, -40(%rbp)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	cmpq	%rbx, %rax
	je	LBB39_14
## %bb.11:                              ## %if.end24.i.i.i
                                        ##   in Loop: Header=BB39_3 Depth=1
	movq	(%rbx), %rax
	movl	$40, %r12d
	jmp	LBB39_3
                                        ## -- End function
	.globl	_halide_do_loop_task            ## -- Begin function halide_do_loop_task
	.weak_definition	_halide_do_loop_task
	.p2align	4, 0x90
_halide_do_loop_task:                   ## @halide_do_loop_task
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_do_task                 ## -- Begin function halide_do_task
	.weak_definition	_halide_do_task
	.p2align	4, 0x90
_halide_do_task:                        ## @halide_do_task
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy: ## @_ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$184, %rsp
	movq	%rsi, %r13
	movq	%rdi, %r14
	movb	$0, -88(%rbp)
	leaq	-216(%rbp), %r12
	movq	%r12, %rdi
	xorl	%esi, %esi
	callq	_pthread_mutex_init
	leaq	-152(%rbp), %rbx
	movq	%rbx, %rdi
	xorl	%esi, %esi
	callq	_pthread_cond_init
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, -80(%rbp)
	movq	$0, -64(%rbp)
	movq	%r13, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	movq	%rax, %r15
	movb	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	(%r14), %rax
	leaq	-56(%rbp), %rsi
	movq	%r14, %rdi
	callq	*(%rax)
	testb	%al, %al
	je	LBB42_1
## %bb.6:                               ## %if.end
	movq	$0, -72(%rbp)
	movq	%r13, -80(%rbp)
	movb	$1, -88(%rbp)
	movq	%r15, %rax
	addq	$8, %rax
	movl	$144, %ecx
	addq	16(%r15), %rcx
	cmpq	$0, 8(%r15)
	cmoveq	%rax, %rcx
	leaq	-64(%rbp), %r13
	movq	%r12, (%rcx)
	movq	%r12, 16(%r15)
	movq	(%r15), %rax
	.p2align	4, 0x90
LBB42_7:                                ## %atomicrmw.start2
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%r15)
	jne	LBB42_7
## %bb.8:                               ## %atomicrmw.end1
	cmpq	$4, %rax
	jb	LBB42_11
## %bb.9:                               ## %atomicrmw.end1
	andl	$2, %eax
	jne	LBB42_11
## %bb.10:                              ## %if.then.i25
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB42_11:                               ## %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit26
	movq	(%r14), %rax
	movq	%r14, %rdi
	callq	*8(%rax)
	leaq	-216(%rbp), %rdi
	callq	_pthread_mutex_lock
	cmpb	$0, -88(%rbp)
	je	LBB42_14
## %bb.12:                              ## %while.body.i.preheader
	leaq	-216(%rbp), %r14
	.p2align	4, 0x90
LBB42_13:                               ## %while.body.i
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	_pthread_cond_wait
	cmpb	$0, -88(%rbp)
	jne	LBB42_13
LBB42_14:                               ## %_ZN6Halide7Runtime8Internal15Synchronization13thread_parker4parkEv.exit
	leaq	-216(%rbp), %rdi
	callq	_pthread_mutex_unlock
	jmp	LBB42_15
LBB42_1:                                ## %if.then
	leaq	-48(%rbp), %r13
	movq	(%r15), %rax
	.p2align	4, 0x90
LBB42_2:                                ## %atomicrmw.start
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%r15)
	jne	LBB42_2
## %bb.3:                               ## %atomicrmw.end
	cmpq	$4, %rax
	jb	LBB42_15
## %bb.4:                               ## %atomicrmw.end
	andl	$2, %eax
	jne	LBB42_15
## %bb.5:                               ## %if.then.i
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB42_15:                               ## %cleanup
	movq	(%r13), %r14
	movq	%rbx, %rdi
	callq	_pthread_cond_destroy
	leaq	-216(%rbp), %rdi
	callq	_pthread_mutex_destroy
	movq	%r14, %rax
	addq	$184, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE: ## @_ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	8(%rdi), %rax
	movq	(%rax), %rdx
	movq	16(%rdi), %rcx
	testq	%rdx, %rdx
	je	LBB43_1
## %bb.2:                               ## %if.else
	movb	$1, %al
	cmpq	%rcx, %rdx
	je	LBB43_4
## %bb.3:                               ## %if.then5
	movq	%rcx, 8(%rsi)
	xorl	%eax, %eax
LBB43_4:                                ## %cleanup
                                        ## kill: def $al killed $al killed $eax
	popq	%rbp
	retq
LBB43_1:                                ## %if.then
	movq	%rcx, (%rax)
	movb	$1, %al
                                        ## kill: def $al killed $al killed $eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv: ## @_ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	16(%rdi), %rsi
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, (%rsi)
	je	LBB44_3
## %bb.1:                               ## %if.then.i
	xorl	%ecx, %ecx
	movl	$1, %eax
	lock		cmpxchgq	%rcx, (%rsi)
	je	LBB44_3
## %bb.2:                               ## %if.end.i.i
	movq	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPCREL(%rip), %rax
	addq	$16, %rax
	movq	%rax, -16(%rbp)
	movq	%rsi, -8(%rbp)
	leaq	-16(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
LBB44_3:                                ## %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex6unlockEv.exit
	addq	$16, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib: ## @_ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
## %bb.0:                               ## %entry
	testl	%edx, %edx
	jne	LBB45_2
## %bb.1:                               ## %if.then
	pushq	%rbp
	movq	%rsp, %rbp
	movq	8(%rdi), %rax
	movq	$0, (%rax)
	popq	%rbp
LBB45_2:                                ## %if.end
	xorl	%eax, %eax
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy: ## @_ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r12
	movq	%rsi, %r13
	movq	%rdi, %r14
	leaq	-56(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
	movb	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movq	(%r14), %rax
	leaq	-72(%rbp), %rsi
	movq	%r14, %rdi
	callq	*(%rax)
	testb	%al, %al
	je	LBB46_1
## %bb.2:                               ## %if.end
	movq	-56(%rbp), %rdx
	movq	8(%rdx), %rsi
	testq	%rsi, %rsi
	je	LBB46_3
## %bb.4:                               ## %while.body.preheader
	addq	$8, %rdx
	xorl	%r15d, %r15d
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	xorl	%edi, %edi
	jmp	LBB46_5
	.p2align	4, 0x90
LBB46_6:                                ##   in Loop: Header=BB46_5 Depth=1
	leaq	144(%r8), %rdx
	movq	%r8, %rdi
LBB46_15:                               ## %if.end22
                                        ##   in Loop: Header=BB46_5 Depth=1
	testq	%rsi, %rsi
	je	LBB46_16
LBB46_5:                                ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rsi, %r8
	movq	136(%rsi), %r9
	movq	144(%rsi), %rsi
	cmpq	%r13, %r9
	jne	LBB46_6
## %bb.7:                               ## %if.then4
                                        ##   in Loop: Header=BB46_5 Depth=1
	movq	%rsi, (%rdx)
	movq	-56(%rbp), %r9
	cmpq	%r8, 16(%r9)
	je	LBB46_8
## %bb.9:                               ## %if.end10
                                        ##   in Loop: Header=BB46_5 Depth=1
	cmpb	$0, -72(%rbp)
	jne	LBB46_10
	jmp	LBB46_12
LBB46_8:                                ## %if.then7
                                        ##   in Loop: Header=BB46_5 Depth=1
	movq	%rdi, 16(%r9)
	cmpb	$0, -72(%rbp)
	je	LBB46_12
LBB46_10:                               ## %if.end10
                                        ##   in Loop: Header=BB46_5 Depth=1
	testq	%r15, %r15
	jne	LBB46_12
## %bb.11:                              ##   in Loop: Header=BB46_5 Depth=1
	movq	%r8, %r15
	jmp	LBB46_15
	.p2align	4, 0x90
LBB46_12:                               ## %if.else
                                        ##   in Loop: Header=BB46_5 Depth=1
	movq	%r8, %r9
	testq	%rax, %rax
	je	LBB46_14
## %bb.13:                              ## %if.else15
                                        ##   in Loop: Header=BB46_5 Depth=1
	movq	%r8, 144(%rcx)
	movq	%rax, %r9
LBB46_14:                               ## %if.end17
                                        ##   in Loop: Header=BB46_5 Depth=1
	movq	%r12, 136(%r8)
	movq	%r9, %rax
	movq	%r8, %rcx
	jmp	LBB46_15
LBB46_1:                                ## %if.then
	leaq	-56(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	xorl	%eax, %eax
	jmp	LBB46_26
LBB46_16:                               ## %while.end
	testq	%rax, %rax
	je	LBB46_17
## %bb.18:                              ## %if.then24
	movq	$0, 144(%rcx)
	movq	-48(%rbp), %rdx
	cmpq	$0, 8(%rdx)
	je	LBB46_19
## %bb.20:                              ## %if.else31
	movl	$144, %esi
	addq	16(%rdx), %rsi
	jmp	LBB46_21
LBB46_3:
	xorl	%eax, %eax
	xorl	%r15d, %r15d
	jmp	LBB46_22
LBB46_17:
	xorl	%eax, %eax
	jmp	LBB46_22
LBB46_19:
	leaq	8(%rdx), %rsi
LBB46_21:                               ## %if.end35
	movq	%rax, (%rsi)
	movq	%rcx, 16(%rdx)
	movb	$1, %al
LBB46_22:                               ## %if.end38
	xorl	%edx, %edx
	testq	%r15, %r15
	setne	%dl
	movq	(%r14), %r8
	movzbl	%al, %ecx
	leaq	-72(%rbp), %rsi
	movq	%r14, %rdi
	callq	*24(%r8)
	testq	%r15, %r15
	je	LBB46_24
## %bb.23:                              ## %if.then44
	movq	%rbx, 152(%r15)
	movq	%r15, %rdi
	callq	_pthread_mutex_lock
	leaq	-56(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	movb	$0, 128(%r15)
	leaq	64(%r15), %rdi
	callq	_pthread_cond_signal
	movq	%r15, %rdi
	callq	_pthread_mutex_unlock
	jmp	LBB46_25
LBB46_24:                               ## %if.else48
	leaq	-56(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
LBB46_25:                               ## %if.end49
	testq	%r15, %r15
	setne	%al
	andb	-72(%rbp), %al
	movzbl	%al, %eax
LBB46_26:                               ## %cleanup
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy: ## @_ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %rbx
	movabsq	$-7046029254386353131, %rax     ## imm = 0x9E3779B97F4A7C15
	imulq	%rax, %rsi
	shrq	$54, %rsi
	imulq	%rax, %rdx
	shrq	$54, %rdx
	cmpq	%rdx, %rsi
	jne	LBB47_2
## %bb.1:                               ## %if.then
	leaq	(%rsi,%rsi,2), %rcx
	movq	__ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPCREL(%rip), %rdx
	leaq	(%rdx,%rcx,8), %r14
	movl	$1, %esi
	xorl	%eax, %eax
	lock		cmpxchgq	%rsi, (%rdx,%rcx,8)
	movq	%r14, %r15
	movq	%r14, %r12
	je	LBB47_11
LBB47_10:                               ## %cleanup.sink.split
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB47_11:                               ## %cleanup
	movq	%r15, (%rbx)
	movq	%r12, 8(%rbx)
	movq	%rbx, %rax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB47_2:                                ## %if.else
	jae	LBB47_7
## %bb.3:                               ## %if.then3
	leaq	(%rsi,%rsi,2), %rcx
	movq	__ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPCREL(%rip), %rsi
	leaq	(%rsi,%rcx,8), %r15
	leaq	(%rdx,%rdx,2), %rax
	leaq	(%rsi,%rax,8), %r14
	movl	$1, %r12d
	xorl	%eax, %eax
	lock		cmpxchgq	%r12, (%rsi,%rcx,8)
	je	LBB47_5
## %bb.4:                               ## %if.then.i32
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB47_5:                                ## %_ZN6Halide7Runtime8Internal15Synchronization9word_lock4lockEv.exit33
	xorl	%eax, %eax
	lock		cmpxchgq	%r12, (%r14)
	movq	%r14, %r12
	jne	LBB47_10
	jmp	LBB47_11
LBB47_7:                                ## %if.else9
	leaq	(%rdx,%rdx,2), %rcx
	movq	__ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPCREL(%rip), %rdx
	leaq	(%rdx,%rcx,8), %r12
	leaq	(%rsi,%rsi,2), %rax
	leaq	(%rdx,%rax,8), %r14
	movl	$1, %r15d
	xorl	%eax, %eax
	lock		cmpxchgq	%r15, (%rdx,%rcx,8)
	je	LBB47_9
## %bb.8:                               ## %if.then.i37
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB47_9:                                ## %_ZN6Halide7Runtime8Internal15Synchronization9word_lock4lockEv.exit38
	xorl	%eax, %eax
	lock		cmpxchgq	%r15, (%r14)
	movq	%r14, %r15
	jne	LBB47_10
	jmp	LBB47_11
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE: ## @_ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rcx
	cmpq	%rcx, %rdi
	je	LBB48_1
## %bb.3:                               ## %if.else
	jbe	LBB48_11
## %bb.4:                               ## %if.then5
	movq	(%rdi), %rax
	.p2align	4, 0x90
LBB48_5:                                ## %atomicrmw.start2
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%rdi)
	jne	LBB48_5
## %bb.6:                               ## %atomicrmw.end1
	cmpq	$4, %rax
	jb	LBB48_9
## %bb.7:                               ## %atomicrmw.end1
	andl	$2, %eax
	jne	LBB48_9
## %bb.8:                               ## %if.then.i29
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB48_9:                                ## %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit30
	movq	8(%rbx), %rdi
	movq	(%rdi), %rax
	.p2align	4, 0x90
LBB48_10:                               ## %atomicrmw.start8
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%rdi)
	jne	LBB48_10
	jmp	LBB48_18
LBB48_1:                                ## %if.then
	movq	(%rdi), %rax
	.p2align	4, 0x90
LBB48_2:                                ## %atomicrmw.start
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%rdi)
	jne	LBB48_2
	jmp	LBB48_18
LBB48_11:                               ## %if.else10
	movq	(%rcx), %rax
	.p2align	4, 0x90
LBB48_12:                               ## %atomicrmw.start14
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rdx
	andq	$-2, %rdx
	lock		cmpxchgq	%rdx, (%rcx)
	jne	LBB48_12
## %bb.13:                              ## %atomicrmw.end13
	cmpq	$4, %rax
	jb	LBB48_16
## %bb.14:                              ## %atomicrmw.end13
	andl	$2, %eax
	jne	LBB48_16
## %bb.15:                              ## %if.then.i41
	movq	%rcx, %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB48_16:                               ## %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit42
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	.p2align	4, 0x90
LBB48_17:                               ## %atomicrmw.start20
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rcx
	andq	$-2, %rcx
	lock		cmpxchgq	%rcx, (%rdi)
	jne	LBB48_17
LBB48_18:                               ## %atomicrmw.end19
	cmpq	$4, %rax
	jb	LBB48_20
## %bb.19:                              ## %atomicrmw.end19
	andl	$2, %eax
	jne	LBB48_20
## %bb.21:                              ## %if.end15.sink.split
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmp	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv ## TAILCALL
LBB48_20:                               ## %if.end15
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE: ## @_ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	8(%rdi), %rax
	movq	(%rax), %rcx
	movq	16(%rdi), %rdx
	cmpq	%rdx, %rcx
	jne	LBB49_6
## %bb.1:                               ## %if.end
	movq	$0, (%rax)
	movq	16(%rdi), %r8
	movq	(%r8), %rax
	movb	$1, %dil
	.p2align	4, 0x90
LBB49_2:                                ## %if.end
                                        ## =>This Inner Loop Header: Depth=1
	testb	$1, %al
	je	LBB49_5
## %bb.3:                               ## %if.end.i
                                        ##   in Loop: Header=BB49_2 Depth=1
	movq	%rax, %r9
	orq	$2, %r9
	lock		cmpxchgq	%r9, (%r8)
	jne	LBB49_2
## %bb.4:
	xorl	%edi, %edi
LBB49_5:                                ## %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex21make_parked_if_lockedEv.exit
	movb	%dil, (%rsi)
LBB49_6:                                ## %cleanup
	cmpq	%rdx, %rcx
	sete	%al
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib: ## @_ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb: ## @_ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	cmpb	$0, (%rsi)
	je	LBB51_3
## %bb.1:                               ## %entry
	testb	%cl, %cl
	je	LBB51_3
## %bb.2:                               ## %if.then
	movq	16(%rdi), %rax
	lock		orq	$2, (%rax)
LBB51_3:                                ## %if.end
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv ## -- Begin function _ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
	.weak_definition	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv: ## @_ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	leaq	L_.str.1.7(%rip), %rdi
	callq	_getenv
	testq	%rax, %rax
	jne	LBB52_2
## %bb.1:                               ## %if.end
	leaq	L_.str.2(%rip), %rdi
	callq	_getenv
	testq	%rax, %rax
	je	LBB52_3
LBB52_2:                                ## %cond.true
	movq	%rax, %rdi
	popq	%rbp
	jmp	_atoi                           ## TAILCALL
LBB52_3:                                ## %cond.false
	popq	%rbp
	jmp	_halide_host_cpu_count          ## TAILCALL
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal13worker_threadEPv ## -- Begin function _ZN6Halide7Runtime8Internal13worker_threadEPv
	.weak_definition	__ZN6Halide7Runtime8Internal13worker_threadEPv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal13worker_threadEPv: ## @_ZN6Halide7Runtime8Internal13worker_threadEPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r14
	movq	%r14, %rdi
	callq	_halide_mutex_lock
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	movq	%r14, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_mutex_unlock            ## TAILCALL
                                        ## -- End function
	.globl	_halide_spawn_thread            ## -- Begin function halide_spawn_thread
	.weak_definition	_halide_spawn_thread
	.p2align	4, 0x90
_halide_spawn_thread:                   ## @halide_spawn_thread
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movl	$24, %edi
	callq	_malloc
	movq	%rax, %r15
	movq	%r14, (%rax)
	movq	%rbx, 8(%rax)
	leaq	16(%rax), %rdi
	movq	$0, 16(%rax)
	movq	__ZN6Halide7Runtime8Internal19spawn_thread_helperEPv@GOTPCREL(%rip), %rdx
	xorl	%esi, %esi
	movq	%rax, %rcx
	callq	_pthread_create
	movq	%r15, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal19spawn_thread_helperEPv ## -- Begin function _ZN6Halide7Runtime8Internal19spawn_thread_helperEPv
	.weak_definition	__ZN6Halide7Runtime8Internal19spawn_thread_helperEPv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal19spawn_thread_helperEPv: ## @_ZN6Halide7Runtime8Internal19spawn_thread_helperEPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, %rax
	movq	8(%rdi), %rdi
	callq	*(%rax)
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_do_parallel_tasks ## -- Begin function halide_default_do_parallel_tasks
	.weak_definition	_halide_default_do_parallel_tasks
	.p2align	4, 0x90
_halide_default_do_parallel_tasks:      ## @halide_default_do_parallel_tasks
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rcx, %r15
	movl	%esi, %r14d
	movslq	%esi, %rax
	movq	%rax, %rcx
	shlq	$7, %rcx
	movq	%rsp, %rbx
	subq	%rcx, %rbx
	movq	%rbx, %rsp
	testl	%eax, %eax
	jle	LBB56_4
## %bb.1:                               ## %for.body.preheader
	leaq	124(%rbx), %rax
	xorl	%ecx, %ecx
	jmp	LBB56_2
	.p2align	4, 0x90
LBB56_6:                                ## %if.end
                                        ##   in Loop: Header=BB56_2 Depth=1
	vmovups	(%rdx), %ymm0
	vmovups	24(%rdx), %ymm1
	addq	$56, %rdx
	vmovups	%ymm1, -100(%rax)
	vmovups	%ymm0, -124(%rax)
	movq	$0, -68(%rax)
	movq	%rdi, -20(%rax)
	movq	$0, -12(%rax)
	movl	$0, -4(%rax)
	movb	$0, (%rax)
	movq	%r15, -36(%rax)
LBB56_7:                                ## %for.inc
                                        ##   in Loop: Header=BB56_2 Depth=1
	incq	%rcx
	movslq	%r14d, %rsi
	subq	$-128, %rax
	cmpq	%rsi, %rcx
	jge	LBB56_4
LBB56_2:                                ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	cmpl	$0, 40(%rdx)
	jg	LBB56_6
## %bb.3:                               ## %if.then
                                        ##   in Loop: Header=BB56_2 Depth=1
	decl	%r14d
	jmp	LBB56_7
LBB56_4:                                ## %for.cond.cleanup
	testl	%r14d, %r14d
	je	LBB56_5
## %bb.8:                               ## %if.end19
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	vzeroupper
	callq	_halide_mutex_lock
	movl	%r14d, %edi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	testl	%r14d, %r14d
	jle	LBB56_9
## %bb.12:                              ## %for.body25.preheader
	movl	%r14d, %r15d
	xorl	%r14d, %r14d
	.p2align	4, 0x90
LBB56_13:                               ## %for.body25
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	movl	116(%rbx), %eax
	testl	%eax, %eax
	cmovnel	%eax, %r14d
	subq	$-128, %rbx
	decq	%r15
	jne	LBB56_13
	jmp	LBB56_10
LBB56_5:
	xorl	%r14d, %r14d
	jmp	LBB56_11
LBB56_9:
	xorl	%r14d, %r14d
LBB56_10:                               ## %for.cond.cleanup24
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
LBB56_11:                               ## %cleanup
	movl	%r14d, %eax
	leaq	-24(%rbp), %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
                                        ## -- End function
	.globl	_halide_default_semaphore_init  ## -- Begin function halide_default_semaphore_init
	.weak_definition	_halide_default_semaphore_init
	.p2align	4, 0x90
_halide_default_semaphore_init:         ## @halide_default_semaphore_init
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%esi, %eax
	movl	%esi, (%rdi)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_semaphore_release ## -- Begin function halide_default_semaphore_release
	.weak_definition	_halide_default_semaphore_release
	.p2align	4, 0x90
_halide_default_semaphore_release:      ## @halide_default_semaphore_release
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movl	%esi, %ebx
	movl	%esi, %r14d
	lock		xaddl	%r14d, (%rdi)
	testl	%esi, %esi
	je	LBB58_3
## %bb.1:                               ## %entry
	testl	%r14d, %r14d
	jne	LBB58_3
## %bb.2:                               ## %if.then
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %r15
	movq	%r15, %rdi
	callq	_halide_mutex_lock
	leaq	40(%r15), %rdi
	callq	_halide_cond_broadcast
	leaq	56(%r15), %rdi
	callq	_halide_cond_broadcast
	movq	%r15, %rdi
	callq	_halide_mutex_unlock
LBB58_3:                                ## %if.end
	addl	%ebx, %r14d
	movl	%r14d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_thread_pool_cleanup     ## -- Begin function halide_thread_pool_cleanup
	.weak_definition	_halide_thread_pool_cleanup
	.p2align	4, 0x90
_halide_thread_pool_cleanup:            ## @halide_thread_pool_cleanup
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_halide_shutdown_thread_pool    ## TAILCALL
                                        ## -- End function
	.globl	_halide_shutdown_thread_pool    ## -- Begin function halide_shutdown_thread_pool
	.weak_definition	_halide_shutdown_thread_pool
	.p2align	4, 0x90
_halide_shutdown_thread_pool:           ## @halide_shutdown_thread_pool
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rbx
	cmpb	$0, 2121(%rbx)
	je	LBB60_5
## %bb.1:                               ## %if.then
	movq	%rbx, %rdi
	callq	_halide_mutex_lock
	movb	$1, 2120(%rbx)
	leaq	56(%rbx), %rdi
	callq	_halide_cond_broadcast
	leaq	40(%rbx), %rdi
	callq	_halide_cond_broadcast
	leaq	48(%rbx), %rdi
	callq	_halide_cond_broadcast
	movq	%rbx, %rdi
	callq	_halide_mutex_unlock
	cmpl	$0, 24(%rbx)
	jle	LBB60_4
## %bb.2:                               ## %for.body.preheader
	xorl	%r14d, %r14d
	.p2align	4, 0x90
LBB60_3:                                ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	72(%rbx,%r14,8), %rdi
	callq	_halide_join_thread
	incq	%r14
	movslq	24(%rbx), %rax
	cmpq	%rax, %r14
	jl	LBB60_3
LBB60_4:                                ## %for.cond.cleanup
	addq	$12, %rbx
	movl	$2116, %edx                     ## imm = 0x844
	movq	%rbx, %rdi
	xorl	%esi, %esi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_memset                         ## TAILCALL
LBB60_5:                                ## %if.end
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_join_thread             ## -- Begin function halide_join_thread
	.weak_definition	_halide_join_thread
	.p2align	4, 0x90
_halide_join_thread:                    ## @halide_join_thread
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	$0, -16(%rbp)
	movq	16(%rdi), %rdi
	leaq	-16(%rbp), %rsi
	callq	_pthread_join
	movq	%rbx, %rdi
	callq	_free
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_cond_signal             ## -- Begin function halide_cond_signal
	.weak_definition	_halide_cond_signal
	.p2align	4, 0x90
_halide_cond_signal:                    ## @halide_cond_signal
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	LBB62_2
## %bb.1:                               ## %if.end.i
	movq	%rdi, %rsi
	movq	__ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE@GOTPCREL(%rip), %rcx
	addq	$16, %rcx
	movq	%rcx, -24(%rbp)
	movq	%rdi, -16(%rbp)
	movq	%rax, -8(%rbp)
	leaq	-24(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
LBB62_2:                                ## %_ZN6Halide7Runtime8Internal15Synchronization9fast_cond6signalEv.exit
	addq	$32, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE: ## @_ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movb	$1, %al
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib ## -- Begin function _ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib: ## @_ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
## %bb.0:                               ## %entry
	testl	%edx, %edx
	jne	LBB64_2
## %bb.1:                               ## %if.then
	pushq	%rbp
	movq	%rsp, %rbp
	movq	8(%rdi), %rax
	movq	$0, (%rax)
	popq	%rbp
LBB64_2:                                ## %if.end
	xorl	%eax, %eax
	retq
                                        ## -- End function
	.globl	_halide_mutex_array_create      ## -- Begin function halide_mutex_array_create
	.weak_definition	_halide_mutex_array_create
	.p2align	4, 0x90
_halide_mutex_array_create:             ## @halide_mutex_array_create
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movl	%edi, %r15d
	xorl	%r14d, %r14d
	movl	$8, %esi
	xorl	%edi, %edi
	callq	_halide_malloc
	testq	%rax, %rax
	je	LBB65_4
## %bb.1:                               ## %if.end
	movq	%rax, %rbx
	movslq	%r15d, %r14
	shlq	$3, %r14
	xorl	%edi, %edi
	movq	%r14, %rsi
	callq	_halide_malloc
	movq	%rax, (%rbx)
	testq	%rax, %rax
	je	LBB65_2
## %bb.3:                               ## %if.end6
	movq	%rax, %rdi
	xorl	%esi, %esi
	movq	%r14, %rdx
	callq	_memset
	movq	%rbx, %r14
	jmp	LBB65_4
LBB65_2:                                ## %if.then5
	xorl	%r14d, %r14d
	xorl	%edi, %edi
	movq	%rbx, %rsi
	callq	_halide_free
LBB65_4:                                ## %cleanup
	movq	%r14, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_mutex_array_destroy     ## -- Begin function halide_mutex_array_destroy
	.weak_definition	_halide_mutex_array_destroy
	.p2align	4, 0x90
_halide_mutex_array_destroy:            ## @halide_mutex_array_destroy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	(%rsi), %rsi
	callq	_halide_free
	movq	%r14, %rdi
	movq	%rbx, %rsi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_free                    ## TAILCALL
                                        ## -- End function
	.globl	_halide_mutex_array_lock        ## -- Begin function halide_mutex_array_lock
	.weak_definition	_halide_mutex_array_lock
	.p2align	4, 0x90
_halide_mutex_array_lock:               ## @halide_mutex_array_lock
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movslq	%esi, %rax
	shlq	$3, %rax
	addq	(%rdi), %rax
	movq	%rax, %rdi
	callq	_halide_mutex_lock
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_mutex_array_unlock      ## -- Begin function halide_mutex_array_unlock
	.weak_definition	_halide_mutex_array_unlock
	.p2align	4, 0x90
_halide_mutex_array_unlock:             ## @halide_mutex_array_unlock
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movslq	%esi, %rax
	shlq	$3, %rax
	addq	(%rdi), %rax
	movq	%rax, %rdi
	callq	_halide_mutex_unlock
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_num_threads         ## -- Begin function halide_set_num_threads
	.weak_definition	_halide_set_num_threads
	.p2align	4, 0x90
_halide_set_num_threads:                ## @halide_set_num_threads
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movl	%edi, %ebx
	testl	%edi, %edi
	js	LBB69_1
## %bb.2:                               ## %if.end
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	testl	%ebx, %ebx
	jne	LBB69_4
## %bb.3:                               ## %if.then2
	callq	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
	movl	%eax, %ebx
	jmp	LBB69_4
LBB69_1:                                ## %if.end.thread
	leaq	L_.str.4(%rip), %rsi
	xorl	%edi, %edi
	callq	_halide_error
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
LBB69_4:                                ## %if.end3
	movq	__ZN6Halide7Runtime8Internal10work_queueE@GOTPCREL(%rip), %rdi
	movl	8(%rdi), %r14d
	cmpl	$2, %ebx
	movl	$1, %eax
	cmovgel	%ebx, %eax
	cmpl	$256, %eax                      ## imm = 0x100
	movl	$256, %ecx                      ## imm = 0x100
	cmovll	%eax, %ecx
	movl	%ecx, 8(%rdi)
	callq	_halide_mutex_unlock
	movl	%r14d, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_do_task      ## -- Begin function halide_set_custom_do_task
	.weak_definition	_halide_set_custom_do_task
	.p2align	4, 0x90
_halide_set_custom_do_task:             ## @halide_set_custom_do_task
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_do_loop_task ## -- Begin function halide_set_custom_do_loop_task
	.weak_definition	_halide_set_custom_do_loop_task
	.p2align	4, 0x90
_halide_set_custom_do_loop_task:        ## @halide_set_custom_do_loop_task
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_do_par_for   ## -- Begin function halide_set_custom_do_par_for
	.weak_definition	_halide_set_custom_do_par_for
	.p2align	4, 0x90
_halide_set_custom_do_par_for:          ## @halide_set_custom_do_par_for
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_parallel_runtime ## -- Begin function halide_set_custom_parallel_runtime
	.weak_definition	_halide_set_custom_parallel_runtime
	.p2align	4, 0x90
_halide_set_custom_parallel_runtime:    ## @halide_set_custom_parallel_runtime
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	16(%rbp), %rax
	movq	__ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPCREL(%rip), %r10
	movq	%rdi, (%r10)
	movq	__ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPCREL(%rip), %rdi
	movq	%rsi, (%rdi)
	movq	__ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPCREL(%rip), %rsi
	movq	%rdx, (%rsi)
	movq	__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE@GOTPCREL(%rip), %rdx
	movq	%rcx, (%rdx)
	movq	__ZN6Halide7Runtime8Internal21custom_semaphore_initE@GOTPCREL(%rip), %rcx
	movq	%r8, (%rcx)
	movq	__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE@GOTPCREL(%rip), %rcx
	movq	%r9, (%rcx)
	movq	__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_do_par_for              ## -- Begin function halide_do_par_for
	.weak_definition	_halide_do_par_for
	.p2align	4, 0x90
_halide_do_par_for:                     ## @halide_do_par_for
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_do_parallel_tasks       ## -- Begin function halide_do_parallel_tasks
	.weak_definition	_halide_do_parallel_tasks
	.p2align	4, 0x90
_halide_do_parallel_tasks:              ## @halide_do_parallel_tasks
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_semaphore_init          ## -- Begin function halide_semaphore_init
	.weak_definition	_halide_semaphore_init
	.p2align	4, 0x90
_halide_semaphore_init:                 ## @halide_semaphore_init
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal21custom_semaphore_initE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_semaphore_release       ## -- Begin function halide_semaphore_release
	.weak_definition	_halide_semaphore_release
	.p2align	4, 0x90
_halide_semaphore_release:              ## @halide_semaphore_release
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_semaphore_try_acquire   ## -- Begin function halide_semaphore_try_acquire
	.weak_definition	_halide_semaphore_try_acquire
	.p2align	4, 0x90
_halide_semaphore_try_acquire:          ## @halide_semaphore_try_acquire
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_get_symbol      ## -- Begin function halide_default_get_symbol
	.weak_definition	_halide_default_get_symbol
	.p2align	4, 0x90
_halide_default_get_symbol:             ## @halide_default_get_symbol
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	%rdi, %rsi
	movq	$-2, %rdi
	popq	%rbp
	jmp	_dlsym                          ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_load_library    ## -- Begin function halide_default_load_library
	.weak_definition	_halide_default_load_library
	.p2align	4, 0x90
_halide_default_load_library:           ## @halide_default_load_library
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$5, %esi
	popq	%rbp
	jmp	_dlopen                         ## TAILCALL
                                        ## -- End function
	.globl	_halide_default_get_library_symbol ## -- Begin function halide_default_get_library_symbol
	.weak_definition	_halide_default_get_library_symbol
	.p2align	4, 0x90
_halide_default_get_library_symbol:     ## @halide_default_get_library_symbol
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	testq	%rdi, %rdi
	movq	$-2, %rax
	cmoveq	%rax, %rdi
	popq	%rbp
	jmp	_dlsym                          ## TAILCALL
                                        ## -- End function
	.globl	_halide_set_custom_get_symbol   ## -- Begin function halide_set_custom_get_symbol
	.weak_definition	_halide_set_custom_get_symbol
	.p2align	4, 0x90
_halide_set_custom_get_symbol:          ## @halide_set_custom_get_symbol
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal17custom_get_symbolE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_load_library ## -- Begin function halide_set_custom_load_library
	.weak_definition	_halide_set_custom_load_library
	.p2align	4, 0x90
_halide_set_custom_load_library:        ## @halide_set_custom_load_library
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal19custom_load_libraryE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_get_library_symbol ## -- Begin function halide_set_custom_get_library_symbol
	.weak_definition	_halide_set_custom_get_library_symbol
	.p2align	4, 0x90
_halide_set_custom_get_library_symbol:  ## @halide_set_custom_get_library_symbol
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal25custom_get_library_symbolE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_get_symbol              ## -- Begin function halide_get_symbol
	.weak_definition	_halide_get_symbol
	.p2align	4, 0x90
_halide_get_symbol:                     ## @halide_get_symbol
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal17custom_get_symbolE@GOTPCREL(%rip), %rax
	popq	%rbp
	jmpq	*(%rax)                         ## TAILCALL
                                        ## -- End function
	.globl	_halide_load_library            ## -- Begin function halide_load_library
	.weak_definition	_halide_load_library
	.p2align	4, 0x90
_halide_load_library:                   ## @halide_load_library
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal19custom_load_libraryE@GOTPCREL(%rip), %rax
	popq	%rbp
	jmpq	*(%rax)                         ## TAILCALL
                                        ## -- End function
	.globl	_halide_get_library_symbol      ## -- Begin function halide_get_library_symbol
	.weak_definition	_halide_get_library_symbol
	.p2align	4, 0x90
_halide_get_library_symbol:             ## @halide_get_library_symbol
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal25custom_get_library_symbolE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_set_gpu_device          ## -- Begin function halide_set_gpu_device
	.weak_definition	_halide_set_gpu_device
	.p2align	4, 0x90
_halide_set_gpu_device:                 ## @halide_set_gpu_device
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPCREL(%rip), %rax
	movl	%edi, (%rax)
	movq	__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE@GOTPCREL(%rip), %rax
	movb	$1, (%rax)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_get_gpu_device          ## -- Begin function halide_get_gpu_device
	.weak_definition	_halide_get_gpu_device
	.p2align	4, 0x90
_halide_get_gpu_device:                 ## @halide_get_gpu_device
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	__ZN6Halide7Runtime8Internal22halide_gpu_device_lockE@GOTPCREL(%rip), %rbx
	.p2align	4, 0x90
LBB89_1:                                ## %while.cond.i
                                        ## =>This Inner Loop Header: Depth=1
	movb	$1, %al
	xchgb	%al, (%rbx)
	testb	%al, %al
	jne	LBB89_1
## %bb.2:                               ## %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit
	movq	__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE@GOTPCREL(%rip), %r14
	cmpb	$0, (%r14)
	je	LBB89_4
## %bb.3:                               ## %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit.if.end4_crit_edge
	movq	__ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPCREL(%rip), %rax
	movl	(%rax), %eax
	jmp	LBB89_8
LBB89_4:                                ## %if.then
	leaq	L_.str.10(%rip), %rdi
	callq	_getenv
	testq	%rax, %rax
	je	LBB89_5
## %bb.6:                               ## %if.then2
	movq	%rax, %rdi
	callq	_atoi
	jmp	LBB89_7
LBB89_5:
	movl	$-1, %eax
LBB89_7:                                ## %if.end
	movq	__ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPCREL(%rip), %rcx
	movl	%eax, (%rcx)
	movb	$1, (%r14)
LBB89_8:                                ## %if.end4
	movb	$0, (%rbx)
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_trace           ## -- Begin function halide_default_trace
	.weak_definition	_halide_default_trace
	.p2align	4, 0x90
_halide_default_trace:                  ## @halide_default_trace
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$120, %rsp
	movq	%rsi, %r12
	movq	%rdi, %r14
	movl	$1, %r15d
	movl	$1, %ebx
	lock		xaddl	%ebx, __ZZ20halide_default_traceE3ids(%rip)
	callq	_halide_get_trace_file
	movl	%eax, -72(%rbp)                 ## 4-byte Spill
	testl	%eax, %eax
	movq	%r12, -112(%rbp)                ## 8-byte Spill
	movl	%ebx, -68(%rbp)                 ## 4-byte Spill
	movq	%r14, -64(%rbp)                 ## 8-byte Spill
	jle	LBB90_37
## %bb.1:                               ## %if.then
	movzwl	34(%r12), %eax
	movzbl	33(%r12), %r14d
	addq	$7, %r14
	shrq	$3, %r14
	imulq	%rax, %r14
	movl	48(%r12), %r13d
	shll	$2, %r13d
	movq	(%r12), %rdi
	callq	_strlen
	movq	%rax, %rbx
	incl	%ebx
	movq	24(%r12), %rdi
	testq	%rdi, %rdi
	je	LBB90_3
## %bb.2:                               ## %cond.true
	callq	_strlen
	movq	%rax, %r15
	incl	%r15d
LBB90_3:                                ## %cond.end
	movq	%r13, -120(%rbp)                ## 8-byte Spill
	leal	(%r14,%r13), %eax
	addl	%ebx, %eax
	leal	(%r15,%rax), %r13d
	addl	$31, %r13d
	andl	$-4, %r13d
	movq	__ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPCREL(%rip), %rax
	movq	(%rax), %r12
	leaq	12(%r12), %rax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
	cmpl	$1048577, %r13d                 ## imm = 0x100001
	movq	%r15, -144(%rbp)                ## 8-byte Spill
	movq	%rbx, -136(%rbp)                ## 8-byte Spill
	movq	%r14, -128(%rbp)                ## 8-byte Spill
	jae	LBB90_4
## %bb.12:                              ## %while.body.i.i.us.i.preheader
	movl	$1073741823, %ebx               ## imm = 0x3FFFFFFF
	movl	$-2147483648, %r14d             ## imm = 0x80000000
	jmp	LBB90_13
LBB90_20:                               ## %do.end.critedge.i.us.i
                                        ##   in Loop: Header=BB90_13 Depth=1
	lock		andl	$2147483647, (%r12)     ## imm = 0x7FFFFFFF
	.p2align	4, 0x90
LBB90_13:                               ## %while.body.i.i.us.i
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB90_16 Depth 2
	movl	(%r12), %eax
	andl	%ebx, %eax
	leal	1(%rax), %ecx
                                        ## kill: def $eax killed $eax killed $rax
	lock		cmpxchgl	%ecx, (%r12)
	jne	LBB90_13
## %bb.14:                              ## %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock14acquire_sharedEv.exit.i.us.i
                                        ##   in Loop: Header=BB90_13 Depth=1
	movl	%r13d, %eax
	lock		xaddl	%eax, 4(%r12)
	leal	(%rax,%r13), %ecx
	cmpl	$1048577, %ecx                  ## imm = 0x100001
	jb	LBB90_22
## %bb.15:                              ## %while.body.us.i
                                        ##   in Loop: Header=BB90_13 Depth=1
	lock		addl	%r13d, 8(%r12)
	lock		decl	(%r12)
	.p2align	4, 0x90
LBB90_16:                               ## %while.body.i.i3.us.i
                                        ##   Parent Loop BB90_13 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	lock		orl	$1073741824, (%r12)     ## imm = 0x40000000
	movl	$1073741824, %eax               ## imm = 0x40000000
	lock		cmpxchgl	%r14d, (%r12)
	jne	LBB90_16
## %bb.17:                              ## %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock17acquire_exclusiveEv.exit.i.us.i
                                        ##   in Loop: Header=BB90_13 Depth=1
	movl	4(%r12), %r15d
	testl	%r15d, %r15d
	je	LBB90_20
## %bb.18:                              ## %if.then.i8.us.i
                                        ##   in Loop: Header=BB90_13 Depth=1
	subl	8(%r12), %r15d
	movl	%r15d, 4(%r12)
	movl	-72(%rbp), %edi                 ## 4-byte Reload
	movq	-48(%rbp), %rsi                 ## 8-byte Reload
	movq	%r15, %rdx
	callq	_write
	movq	$0, 4(%r12)
	lock		andl	$2147483647, (%r12)     ## imm = 0x7FFFFFFF
	cmpl	%eax, %r15d
	je	LBB90_13
## %bb.19:                              ## %if.then10.i.us.i
                                        ##   in Loop: Header=BB90_13 Depth=1
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	leaq	L_.str.32(%rip), %rsi
	callq	_halide_print
	callq	_abort
	jmp	LBB90_13
LBB90_37:                               ## %if.else
	leaq	-104(%rbp), %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EEC2EPv
	movzbl	33(%r12), %eax
	movl	$8, %ecx
	.p2align	4, 0x90
LBB90_38:                               ## %while.cond
                                        ## =>This Inner Loop Header: Depth=1
	movl	%ecx, %r15d
	leal	(%r15,%r15), %ecx
	cmpl	%eax, %r15d
	jl	LBB90_38
## %bb.39:                              ## %do.body
	cmpl	$65, %r15d
	jl	LBB90_41
## %bb.40:                              ## %if.then64
	leaq	L_.str.2.13(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_print
	callq	_abort
LBB90_41:                               ## %do.end
	movl	36(%r12), %ecx
	leaq	l_reltable.halide_default_trace(%rip), %rax
	movq	%rcx, -48(%rbp)                 ## 8-byte Spill
	movslq	(%rax,%rcx,4), %rsi
	addq	%rax, %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.31.191(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%r12), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.39.197(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movl	44(%r12), %esi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.38.196(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	cmpw	$2, 34(%r12)
	jb	LBB90_43
## %bb.42:                              ## %if.then81
	leaq	L_.str.17(%rip), %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
LBB90_43:                               ## %if.end83
	cmpl	$0, 48(%r12)
	jle	LBB90_50
## %bb.44:                              ## %if.end101.peel
	movq	16(%r12), %rax
	movl	(%rax), %esi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	cmpl	$2, 48(%r12)
	jl	LBB90_50
## %bb.45:                              ## %if.then87.preheader
	movl	$1, %ebx
	leaq	-104(%rbp), %r14
	leaq	L_.str.55(%rip), %r13
	jmp	LBB90_46
	.p2align	4, 0x90
LBB90_48:                               ## %if.else98.split
                                        ##   in Loop: Header=BB90_46 Depth=1
	movq	%r13, %rsi
LBB90_49:                               ## %if.end101
                                        ##   in Loop: Header=BB90_46 Depth=1
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	-112(%rbp), %r12                ## 8-byte Reload
	movq	16(%r12), %rax
	movl	(%rax,%rbx,4), %esi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	incq	%rbx
	movslq	48(%r12), %rax
	cmpq	%rax, %rbx
	jge	LBB90_50
LBB90_46:                               ## %if.then87
                                        ## =>This Inner Loop Header: Depth=1
	movzwl	34(%r12), %ecx
	cmpl	$2, %ecx
	jb	LBB90_48
## %bb.47:                              ## %land.lhs.true
                                        ##   in Loop: Header=BB90_46 Depth=1
	movl	%ebx, %eax
	xorl	%edx, %edx
	divl	%ecx
	leaq	L_.str.18(%rip), %rsi
	testl	%edx, %edx
	jne	LBB90_48
	jmp	LBB90_49
LBB90_50:                               ## %for.cond.cleanup
	cmpw	$2, 34(%r12)
	leaq	L_.str.20(%rip), %rax
	leaq	L_.str.8.122(%rip), %rsi
	cmovaeq	%rax, %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	cmpl	$2, -48(%rbp)                   ## 4-byte Folded Reload
	movl	-68(%rbp), %r13d                ## 4-byte Reload
	jge	LBB90_107
## %bb.51:                              ## %if.then116
	cmpw	$2, 34(%r12)
	leaq	L_.str.22(%rip), %rax
	leaq	L_.str.23(%rip), %rsi
	cmovaeq	%rax, %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	cmpw	$0, 34(%r12)
	je	LBB90_107
## %bb.52:                              ## %if.end137.peel
	leaq	8(%r12), %rax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
	movzbl	32(%r12), %eax
	cmpq	$3, %rax
	ja	LBB90_77
## %bb.53:                              ## %if.end137.peel
	leaq	LJTI90_0(%rip), %rcx
	movslq	(%rcx,%rax,4), %rax
	addq	%rcx, %rax
	jmpq	*%rax
LBB90_70:                               ## %if.then141.peel
	cmpl	$8, %r15d
	je	LBB90_75
## %bb.71:                              ## %if.then141.peel
	cmpl	$16, %r15d
	je	LBB90_74
## %bb.72:                              ## %if.then141.peel
	cmpl	$32, %r15d
	jne	LBB90_76
## %bb.73:                              ## %if.then159.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movl	(%rax), %esi
	jmp	LBB90_67
LBB90_4:
	movl	$1073741823, %r14d              ## imm = 0x3FFFFFFF
	movl	$-2147483648, %ebx              ## imm = 0x80000000
	jmp	LBB90_5
LBB90_21:                               ## %do.end.critedge.i.i
                                        ##   in Loop: Header=BB90_5 Depth=1
	lock		andl	$2147483647, (%r12)     ## imm = 0x7FFFFFFF
	.p2align	4, 0x90
LBB90_5:                                ## %while.body.i.i.i
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB90_8 Depth 2
	movl	(%r12), %eax
	andl	%r14d, %eax
	leal	1(%rax), %ecx
                                        ## kill: def $eax killed $eax killed $rax
	lock		cmpxchgl	%ecx, (%r12)
	jne	LBB90_5
## %bb.6:                               ## %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock14acquire_sharedEv.exit.i.i
                                        ##   in Loop: Header=BB90_5 Depth=1
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	leaq	L_.str.31(%rip), %rsi
	callq	_halide_print
	callq	_abort
	movl	%r13d, %eax
	lock		xaddl	%eax, 4(%r12)
	leal	(%rax,%r13), %ecx
	cmpl	$1048577, %ecx                  ## imm = 0x100001
	jb	LBB90_22
## %bb.7:                               ## %while.body.i
                                        ##   in Loop: Header=BB90_5 Depth=1
	lock		addl	%r13d, 8(%r12)
	lock		decl	(%r12)
	.p2align	4, 0x90
LBB90_8:                                ## %while.body.i.i3.i
                                        ##   Parent Loop BB90_5 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	lock		orl	$1073741824, (%r12)     ## imm = 0x40000000
	movl	$1073741824, %eax               ## imm = 0x40000000
	lock		cmpxchgl	%ebx, (%r12)
	jne	LBB90_8
## %bb.9:                               ## %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock17acquire_exclusiveEv.exit.i.i
                                        ##   in Loop: Header=BB90_5 Depth=1
	movl	4(%r12), %r15d
	testl	%r15d, %r15d
	je	LBB90_21
## %bb.10:                              ## %if.then.i8.i
                                        ##   in Loop: Header=BB90_5 Depth=1
	subl	8(%r12), %r15d
	movl	%r15d, 4(%r12)
	movl	-72(%rbp), %edi                 ## 4-byte Reload
	movq	-48(%rbp), %rsi                 ## 8-byte Reload
	movq	%r15, %rdx
	callq	_write
	movq	$0, 4(%r12)
	lock		andl	$2147483647, (%r12)     ## imm = 0x7FFFFFFF
	cmpl	%eax, %r15d
	je	LBB90_5
## %bb.11:                              ## %if.then10.i.i
                                        ##   in Loop: Header=BB90_5 Depth=1
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	leaq	L_.str.32(%rip), %rsi
	callq	_halide_print
	callq	_abort
	jmp	LBB90_5
LBB90_22:                               ## %_ZN6Halide7Runtime8Internal11TraceBuffer14acquire_packetEPvij.exit
	movl	%eax, %eax
	movq	-48(%rbp), %r15                 ## 8-byte Reload
	addq	%rax, %r15
	cmpl	$4097, %r13d                    ## imm = 0x1001
	jb	LBB90_24
## %bb.23:                              ## %if.then18
	leaq	-104(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EEC2EPv
	movq	%r14, %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEj
	leaq	L_.str.13.172(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EED2Ev
LBB90_24:                               ## %if.end
	movl	%r13d, (%r15)
	movl	-68(%rbp), %r13d                ## 4-byte Reload
	movl	%r13d, 4(%r15)
	movq	-112(%rbp), %rbx                ## 8-byte Reload
	movl	32(%rbx), %eax
	movl	%eax, 8(%r15)
	vmovups	36(%rbx), %xmm0
	vmovups	%xmm0, 12(%r15)
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	movq	-144(%rbp), %r14                ## 8-byte Reload
	je	LBB90_26
## %bb.25:                              ## %if.then29
	leaq	28(%r15), %rdi
	movl	-120(%rbp), %edx                ## 4-byte Reload
	callq	_memcpy
LBB90_26:                               ## %if.end34
	movq	8(%rbx), %rsi
	testq	%rsi, %rsi
	je	LBB90_28
## %bb.27:                              ## %if.then36
	movslq	24(%r15), %rax
	leaq	(%r15,%rax,4), %rdi
	addq	$28, %rdi
	movq	-128(%rbp), %rdx                ## 8-byte Reload
	callq	_memcpy
LBB90_28:                               ## %if.end41
	movslq	24(%r15), %rax
	leaq	(%r15,%rax,4), %rax
	addq	$28, %rax
	movzwl	10(%r15), %ecx
	movzbl	9(%r15), %edi
	addq	$7, %rdi
	shrq	$3, %rdi
	imulq	%rcx, %rdi
	addq	%rax, %rdi
	movq	(%rbx), %rsi
	movl	-136(%rbp), %edx                ## 4-byte Reload
	callq	_memcpy
	movslq	24(%r15), %rax
	leaq	(%r15,%rax,4), %rax
	addq	$28, %rax
	movzwl	10(%r15), %ecx
	movzbl	9(%r15), %edi
	addq	$7, %rdi
	shrq	$3, %rdi
	imulq	%rcx, %rdi
	addq	%rax, %rdi
	.p2align	4, 0x90
LBB90_29:                               ## %while.cond.i403
                                        ## =>This Inner Loop Header: Depth=1
	cmpb	$0, (%rdi)
	leaq	1(%rdi), %rdi
	jne	LBB90_29
## %bb.30:                              ## %_ZN21halide_trace_packet_t9trace_tagEv.exit
	movq	24(%rbx), %rax
	testq	%rax, %rax
	leaq	L_.str.1.12(%rip), %rsi
	cmovneq	%rax, %rsi
	movl	%r14d, %edx
	callq	_memcpy
	movq	__ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	mfence
	lock		decl	(%rax)
	cmpl	$9, 36(%rbx)
	jne	LBB90_113
## %bb.31:                              ## %if.then58
	movq	(%rcx), %r14
	movl	$-2147483648, %ecx              ## imm = 0x80000000
	.p2align	4, 0x90
LBB90_32:                               ## %while.body.i.i
                                        ## =>This Inner Loop Header: Depth=1
	lock		orl	$1073741824, (%r14)     ## imm = 0x40000000
	movl	$1073741824, %eax               ## imm = 0x40000000
	lock		cmpxchgl	%ecx, (%r14)
	jne	LBB90_32
## %bb.33:                              ## %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock17acquire_exclusiveEv.exit.i
	movl	4(%r14), %ebx
	testl	%ebx, %ebx
	je	LBB90_36
## %bb.34:                              ## %if.then.i
	subl	8(%r14), %ebx
	movl	%ebx, 4(%r14)
	leaq	12(%r14), %rsi
	movl	-72(%rbp), %edi                 ## 4-byte Reload
	movq	%rbx, %rdx
	callq	_write
	movq	$0, 4(%r14)
	lock		andl	$2147483647, (%r14)     ## imm = 0x7FFFFFFF
	cmpl	%eax, %ebx
	je	LBB90_113
## %bb.35:                              ## %if.then10.i
	leaq	L_.str.32(%rip), %rsi
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_print
	callq	_abort
	jmp	LBB90_113
LBB90_36:                               ## %do.end.critedge.i
	lock		andl	$2147483647, (%r14)     ## imm = 0x7FFFFFFF
	jmp	LBB90_113
LBB90_62:                               ## %if.then177.peel
	cmpl	$8, %r15d
	je	LBB90_68
## %bb.63:                              ## %if.then177.peel
	cmpl	$16, %r15d
	je	LBB90_66
## %bb.64:                              ## %if.then177.peel
	cmpl	$32, %r15d
	jne	LBB90_69
## %bb.65:                              ## %if.then195.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movl	(%rax), %esi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEj
	cmpw	$2, 34(%r12)
	jae	LBB90_78
	jmp	LBB90_107
LBB90_55:                               ## %do.body214.peel
	cmpl	$15, %r15d
	jg	LBB90_57
## %bb.56:                              ## %if.then216.peel
	leaq	L_.str.24(%rip), %rsi
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_print
	callq	_abort
LBB90_57:                               ## %do.end219.peel
	cmpl	$32, %r15d
	je	LBB90_60
## %bb.58:                              ## %do.end219.peel
	cmpl	$16, %r15d
	jne	LBB90_61
## %bb.59:                              ## %if.then228.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movzwl	(%rax), %eax
	movw	%ax, -56(%rbp)
	movzwl	-56(%rbp), %eax
	movw	%ax, (%rsp)
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsENS2_11Float16BitsE
	cmpw	$2, 34(%r12)
	jae	LBB90_78
	jmp	LBB90_107
LBB90_54:                               ## %if.then246.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movq	(%rax), %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKv
	cmpw	$2, 34(%r12)
	jae	LBB90_78
	jmp	LBB90_107
LBB90_60:                               ## %if.then221.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	vmovss	(%rax), %xmm0                   ## xmm0 = mem[0],zero,zero,zero
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	cmpw	$2, 34(%r12)
	jae	LBB90_78
	jmp	LBB90_107
LBB90_61:                               ## %if.else234.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	vmovsd	(%rax), %xmm0                   ## xmm0 = mem[0],zero
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEd
	cmpw	$2, 34(%r12)
	jae	LBB90_78
	jmp	LBB90_107
LBB90_75:                               ## %if.then143.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movsbl	(%rax), %esi
	jmp	LBB90_67
LBB90_74:                               ## %if.then151.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movswl	(%rax), %esi
	jmp	LBB90_67
LBB90_76:                               ## %if.else164.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movq	(%rax), %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	cmpw	$2, 34(%r12)
	jae	LBB90_78
	jmp	LBB90_107
LBB90_68:                               ## %if.then179.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movzbl	(%rax), %esi
	jmp	LBB90_67
LBB90_66:                               ## %if.then187.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movzwl	(%rax), %esi
LBB90_67:                               ## %for.inc255.peel
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
LBB90_77:                               ## %for.inc255.peel
	cmpw	$2, 34(%r12)
	jb	LBB90_107
LBB90_78:                               ## %if.end137.preheader
	movq	%r12, %rbx
	movl	$1, %r13d
	leaq	-104(%rbp), %r12
	leaq	LJTI90_1(%rip), %r14
	jmp	LBB90_79
	.p2align	4, 0x90
LBB90_103:                              ## %if.then246
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rsi
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKv
LBB90_104:                              ## %for.inc255
                                        ##   in Loop: Header=BB90_79 Depth=1
	incq	%r13
	movq	-112(%rbp), %rbx                ## 8-byte Reload
	movzwl	34(%rbx), %eax
	cmpq	%rax, %r13
	jae	LBB90_105
LBB90_79:                               ## %if.end137
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r12, %rdi
	leaq	L_.str.55(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movzbl	32(%rbx), %eax
	cmpq	$3, %rax
	ja	LBB90_104
## %bb.80:                              ## %if.end137
                                        ##   in Loop: Header=BB90_79 Depth=1
	movslq	(%r14,%rax,4), %rax
	addq	%r14, %rax
	jmpq	*%rax
LBB90_81:                               ## %if.then141
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$32, %r15d
	je	LBB90_87
## %bb.82:                              ## %if.then141
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$16, %r15d
	je	LBB90_86
## %bb.83:                              ## %if.then141
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$8, %r15d
	jne	LBB90_88
## %bb.84:                              ## %if.then143
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movsbl	(%rax,%r13), %esi
	jmp	LBB90_85
	.p2align	4, 0x90
LBB90_89:                               ## %if.then177
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$32, %r15d
	je	LBB90_94
## %bb.90:                              ## %if.then177
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$16, %r15d
	je	LBB90_93
## %bb.91:                              ## %if.then177
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$8, %r15d
	jne	LBB90_95
## %bb.92:                              ## %if.then179
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movzbl	(%rax,%r13), %esi
	jmp	LBB90_85
	.p2align	4, 0x90
LBB90_96:                               ## %do.body214
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$15, %r15d
	jg	LBB90_98
## %bb.97:                              ## %if.then216
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	leaq	L_.str.24(%rip), %rsi
	callq	_halide_print
	callq	_abort
LBB90_98:                               ## %do.end219
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$16, %r15d
	je	LBB90_101
## %bb.99:                              ## %do.end219
                                        ##   in Loop: Header=BB90_79 Depth=1
	cmpl	$32, %r15d
	jne	LBB90_102
## %bb.100:                             ## %if.then221
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	vmovss	(%rax,%r13,4), %xmm0            ## xmm0 = mem[0],zero,zero,zero
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	jmp	LBB90_104
LBB90_101:                              ## %if.then228
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movzwl	(%rax,%r13,2), %eax
	movw	%ax, -56(%rbp)
	movzwl	-56(%rbp), %eax
	movw	%ax, (%rsp)
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsENS2_11Float16BitsE
	jmp	LBB90_104
LBB90_102:                              ## %if.else234
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	vmovsd	(%rax,%r13,8), %xmm0            ## xmm0 = mem[0],zero
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEd
	jmp	LBB90_104
LBB90_87:                               ## %if.then159
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movl	(%rax,%r13,4), %esi
	jmp	LBB90_85
LBB90_86:                               ## %if.then151
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movswl	(%rax,%r13,2), %esi
	jmp	LBB90_85
LBB90_94:                               ## %if.then195
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movl	(%rax,%r13,4), %esi
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEj
	jmp	LBB90_104
LBB90_93:                               ## %if.then187
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movzwl	(%rax,%r13,2), %esi
	.p2align	4, 0x90
LBB90_85:                               ## %for.inc255
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	jmp	LBB90_104
LBB90_88:                               ## %if.else164
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rsi
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	jmp	LBB90_104
LBB90_95:                               ## %if.else200
                                        ##   in Loop: Header=BB90_79 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movq	(%rax,%r13,8), %rsi
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	jmp	LBB90_104
LBB90_105:                              ## %for.cond.cleanup132
	cmpw	$1, %ax
	movl	-68(%rbp), %r13d                ## 4-byte Reload
	movq	%rbx, %r12
	jbe	LBB90_107
## %bb.106:                             ## %if.then262
	leaq	L_.str.25(%rip), %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
LBB90_107:                              ## %if.end265
	movq	24(%r12), %rax
	testq	%rax, %rax
	je	LBB90_110
## %bb.108:                             ## %land.lhs.true268
	cmpb	$0, (%rax)
	je	LBB90_110
## %bb.109:                             ## %if.then271
	leaq	L_.str.26(%rip), %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	24(%r12), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.27(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
LBB90_110:                              ## %if.end276
	leaq	L_.str.13.172(%rip), %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	__ZN6Halide7Runtime8Internal22halide_trace_file_lockE@GOTPCREL(%rip), %rbx
	.p2align	4, 0x90
LBB90_111:                              ## %while.cond.i407
                                        ## =>This Inner Loop Header: Depth=1
	movb	$1, %al
	xchgb	%al, (%rbx)
	testb	%al, %al
	jne	LBB90_111
## %bb.112:                             ## %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	movq	%rax, %rsi
	callq	_halide_print
	movb	$0, (%rbx)
	movq	-88(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EED2Ev
LBB90_113:                              ## %if.end279
	movl	%r13d, %eax
	addq	$120, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB90_69:                               ## %if.else200.peel
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax), %rax
	movq	(%rax), %rsi
	leaq	-104(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	cmpw	$2, 34(%r12)
	jae	LBB90_78
	jmp	LBB90_107
	.p2align	2, 0x90
	.data_region jt32
.set L90_0_set_70, LBB90_70-LJTI90_0
.set L90_0_set_62, LBB90_62-LJTI90_0
.set L90_0_set_55, LBB90_55-LJTI90_0
.set L90_0_set_54, LBB90_54-LJTI90_0
LJTI90_0:
	.long	L90_0_set_70
	.long	L90_0_set_62
	.long	L90_0_set_55
	.long	L90_0_set_54
.set L90_1_set_81, LBB90_81-LJTI90_1
.set L90_1_set_89, LBB90_89-LJTI90_1
.set L90_1_set_96, LBB90_96-LJTI90_1
.set L90_1_set_103, LBB90_103-LJTI90_1
LJTI90_1:
	.long	L90_1_set_81
	.long	L90_1_set_89
	.long	L90_1_set_96
	.long	L90_1_set_103
	.end_data_region
                                        ## -- End function
	.globl	_halide_get_trace_file          ## -- Begin function halide_get_trace_file
	.weak_definition	_halide_get_trace_file
	.p2align	4, 0x90
_halide_get_trace_file:                 ## @halide_get_trace_file
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rdi, %rbx
	movq	__ZN6Halide7Runtime8Internal22halide_trace_file_lockE@GOTPCREL(%rip), %r15
	.p2align	4, 0x90
LBB91_1:                                ## %while.cond.i
                                        ## =>This Inner Loop Header: Depth=1
	movb	$1, %al
	xchgb	%al, (%r15)
	testb	%al, %al
	jne	LBB91_1
## %bb.2:                               ## %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit
	movq	__ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPCREL(%rip), %r12
	cmpl	$0, (%r12)
	js	LBB91_3
LBB91_9:                                ## %if.end11
	movl	(%r12), %eax
	movb	$0, (%r15)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB91_3:                                ## %if.then
	leaq	L_.str.28(%rip), %rdi
	callq	_getenv
	testq	%rax, %rax
	je	LBB91_8
## %bb.4:                               ## %if.then1
	leaq	L_.str.29(%rip), %rsi
	movq	%rax, %rdi
	callq	_fopen
	movq	%rax, %r14
	testq	%rax, %rax
	jne	LBB91_6
## %bb.5:                               ## %if.then4
	leaq	L_.str.30(%rip), %rsi
	movq	%rbx, %rdi
	callq	_halide_print
	callq	_abort
LBB91_6:                                ## %do.end
	movq	%r14, %rdi
	callq	_fileno
	movl	%eax, %edi
	callq	_halide_set_trace_file
	movq	__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE@GOTPCREL(%rip), %rax
	movq	%r14, (%rax)
	movq	__ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPCREL(%rip), %rbx
	cmpq	$0, (%rbx)
	jne	LBB91_9
## %bb.7:                               ## %if.then7
	movl	$1048588, %edi                  ## imm = 0x10000C
	callq	_malloc
	movq	%rax, (%rbx)
	movq	$0, 4(%rax)
	xorl	%ecx, %ecx
	xchgl	%ecx, (%rax)
	jmp	LBB91_9
LBB91_8:                                ## %if.else
	xorl	%edi, %edi
	callq	_halide_set_trace_file
	jmp	LBB91_9
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EEC2EPv
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EEC2EPv: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EEC2EPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movl	$1024, %edi                     ## imm = 0x400
	callq	_malloc
	movl	$1024, %ecx                     ## imm = 0x400
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%rax, %rdx
	callq	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	cmpq	$0, 16(%rbx)
	je	LBB92_2
## %bb.1:                               ## %if.end
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
LBB92_2:                                ## %if.then
	movq	%rbx, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmp	__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv ## TAILCALL
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEj ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEj
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEj
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEj: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEj
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rax
	movl	%esi, %edx
	movq	%rax, %rsi
	movl	$1, %ecx
	callq	_halide_uint64_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EED2Ev
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EED2Ev: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE0ELy1024EED2Ev
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	movq	24(%rdi), %r14
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	_halide_print
	movq	16(%rbx), %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_free                           ## TAILCALL
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EEC2EPv
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EEC2EPv: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EEC2EPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movl	$4096, %edi                     ## imm = 0x1000
	callq	_malloc
	movl	$4096, %ecx                     ## imm = 0x1000
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	callq	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	cmpq	$0, 16(%rbx)
	je	LBB95_2
## %bb.1:                               ## %if.end
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB95_2:                                ## %if.then
	movq	%rbx, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv ## TAILCALL
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEi ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEi
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEi: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEi
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rax
	movslq	%esi, %rdx
	movq	%rax, %rsi
	movl	$1, %ecx
	callq	_halide_int64_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKv ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEPKv
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEPKv: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEPKv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rdx
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rsi
	callq	_halide_pointer_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsENS2_11Float16BitsE ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsENS2_11Float16BitsE
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsENS2_11Float16BitsE
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsENS2_11Float16BitsE: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsENS2_11Float16BitsE
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movzwl	16(%rbp), %edi
	callq	_halide_float16_bits_to_double
	movq	(%rbx), %rdi
	movq	8(%rbx), %rsi
	movl	$1, %edx
	callq	_halide_double_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEf ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEf
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEf: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEf
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rsi
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	xorl	%edx, %edx
	callq	_halide_double_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEd ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEd
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEd
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEd: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEd
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rsi
	movl	$1, %edx
	callq	_halide_double_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEy ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEy
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEy: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rdx
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rsi
	movl	$1, %ecx
	callq	_halide_uint64_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsEx ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsEx
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsEx: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsEx
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rdx
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rsi
	movl	$1, %ecx
	callq	_halide_int64_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EED2Ev
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EED2Ev: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy4096EED2Ev
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_free                           ## TAILCALL
                                        ## -- End function
	.globl	__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv ## -- Begin function _ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv
	.weak_definition	__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv
	.p2align	4, 0x90
__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv: ## @_ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	24(%rdi), %rdi
	leaq	L_.str.33(%rip), %rsi
	popq	%rbp
	jmp	_halide_error                   ## TAILCALL
                                        ## -- End function
	.globl	_halide_set_trace_file          ## -- Begin function halide_set_trace_file
	.weak_definition	_halide_set_trace_file
	.p2align	4, 0x90
_halide_set_trace_file:                 ## @halide_set_trace_file
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPCREL(%rip), %rax
	movl	%edi, (%rax)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_trace_cleanup           ## -- Begin function halide_trace_cleanup
	.weak_definition	_halide_trace_cleanup
	.p2align	4, 0x90
_halide_trace_cleanup:                  ## @halide_trace_cleanup
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_halide_shutdown_trace          ## TAILCALL
                                        ## -- End function
	.globl	_halide_shutdown_trace          ## -- Begin function halide_shutdown_trace
	.weak_definition	_halide_shutdown_trace
	.p2align	4, 0x90
_halide_shutdown_trace:                 ## @halide_shutdown_trace
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE@GOTPCREL(%rip), %r14
	movq	(%r14), %rdi
	testq	%rdi, %rdi
	je	LBB107_4
## %bb.1:                               ## %if.then
	callq	_fclose
	movl	%eax, %ebx
	movq	__ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPCREL(%rip), %rax
	movl	$0, (%rax)
	movq	__ZN6Halide7Runtime8Internal29halide_trace_file_initializedE@GOTPCREL(%rip), %rax
	movb	$0, (%rax)
	movq	$0, (%r14)
	movq	__ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	testq	%rdi, %rdi
	je	LBB107_3
## %bb.2:                               ## %if.then2
	callq	_free
LBB107_3:                               ## %if.end
	movl	$-30, %eax
	testl	%ebx, %ebx
	je	LBB107_4
## %bb.5:                               ## %return
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB107_4:                               ## %if.end5
	xorl	%eax, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_trace        ## -- Begin function halide_set_custom_trace
	.weak_definition	_halide_set_custom_trace
	.p2align	4, 0x90
_halide_set_custom_trace:               ## @halide_set_custom_trace
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal19halide_custom_traceE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_trace                   ## -- Begin function halide_trace
	.weak_definition	_halide_trace
	.p2align	4, 0x90
_halide_trace:                          ## @halide_trace
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal19halide_custom_traceE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_trace_helper            ## -- Begin function halide_trace_helper
	.weak_definition	_halide_trace_helper
	.p2align	4, 0x90
_halide_trace_helper:                   ## @halide_trace_helper
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
	movl	%r9d, %r13d
	movq	%rcx, %r14
	movq	%rdx, %r12
	movq	%rdi, %rbx
	movslq	48(%rbp), %r15
	movl	40(%rbp), %eax
	movl	32(%rbp), %ecx
	movl	24(%rbp), %edx
	movl	16(%rbp), %r9d
	movq	56(%rbp), %rdi
	movq	%rsi, -96(%rbp)
	movq	%r12, -88(%rbp)
	movq	%r14, -80(%rbp)
	movq	%rdi, -72(%rbp)
	movb	%r8b, -64(%rbp)
	movb	%r13b, -63(%rbp)
	movw	%r9w, -62(%rbp)
	movl	%edx, -60(%rbp)
	movl	%ecx, -56(%rbp)
	movl	%eax, -52(%rbp)
	movl	%r15d, -48(%rbp)
	leaq	-96(%rbp), %rsi
	movl	$56, %edx
	movq	%rbx, %rdi
	callq	_halide_msan_annotate_memory_is_initialized
	leal	7(%r13), %eax
	addl	$14, %r13d
	testl	%eax, %eax
	cmovnsl	%eax, %r13d
	sarl	$3, %r13d
	imull	16(%rbp), %r13d
	movslq	%r13d, %rdx
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	_halide_msan_annotate_memory_is_initialized
	shlq	$2, %r15
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%r15, %rdx
	callq	_halide_msan_annotate_memory_is_initialized
	movq	%rbx, %rdi
	leaq	-96(%rbp), %rsi
	callq	_halide_trace
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_ ## -- Begin function _ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	.weak_definition	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal9ends_withEPKcS3_: ## @_ZN6Halide7Runtime8Internal9ends_withEPKcS3_
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%eax, %eax
	.p2align	4, 0x90
LBB111_1:                               ## %while.cond
                                        ## =>This Inner Loop Header: Depth=1
	cmpb	$0, (%rdi,%rax)
	leaq	1(%rax), %rax
	jne	LBB111_1
## %bb.2:                               ## %while.cond1.preheader
	movq	$-1, %rcx
	.p2align	4, 0x90
LBB111_3:                               ## %while.cond1
                                        ## =>This Inner Loop Header: Depth=1
	cmpb	$0, 1(%rsi,%rcx)
	leaq	1(%rcx), %rcx
	jne	LBB111_3
## %bb.4:                               ## %while.cond6.preheader
	xorl	%edx, %edx
	cmpq	$1, %rax
	je	LBB111_11
## %bb.5:                               ## %while.cond6.preheader
	movl	$0, %r8d
	testq	%rcx, %rcx
	je	LBB111_10
	.p2align	4, 0x90
LBB111_6:                               ## %while.body8
                                        ## =>This Inner Loop Header: Depth=1
	movzbl	-1(%rdi,%rax), %edx
	cmpb	(%rsi,%rcx), %dl
	jne	LBB111_12
## %bb.7:                               ## %if.end
                                        ##   in Loop: Header=BB111_6 Depth=1
	leaq	-1(%rcx), %rdx
	leaq	-1(%rax), %r8
	cmpq	$1, %rcx
	je	LBB111_9
## %bb.8:                               ## %if.end
                                        ##   in Loop: Header=BB111_6 Depth=1
	movq	%rdx, %rcx
	cmpq	$2, %rax
	movq	%r8, %rax
	jne	LBB111_6
LBB111_9:                               ## %while.end13.loopexit
	movzbl	-1(%rdi,%r8), %r8d
	movzbl	(%rsi,%rdx), %edx
LBB111_10:                              ## %while.end13
	cmpb	%dl, %r8b
	sete	%al
                                        ## kill: def $al killed $al killed $eax
	popq	%rbp
	retq
LBB111_11:
	xorl	%r8d, %r8d
	cmpb	%dl, %r8b
	sete	%al
                                        ## kill: def $al killed $al killed $eax
	popq	%rbp
	retq
LBB111_12:
	xorl	%eax, %eax
                                        ## kill: def $al killed $al killed $eax
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__const
	.p2align	5, 0x0                          ## -- Begin function halide_debug_to_file
LCPI112_0:
	.long	327962                          ## 0x5011a
	.long	1                               ## 0x1
	.long	194                             ## 0xc2
	.long	327963                          ## 0x5011b
	.long	1                               ## 0x1
	.long	202                             ## 0xca
	.long	196892                          ## 0x3011c
	.long	1                               ## 0x1
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
LCPI112_1:
	.long	0                               ## 0x0
	.long	1                               ## 0x1
	.long	1                               ## 0x1
	.long	1                               ## 0x1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_debug_to_file
	.weak_definition	_halide_debug_to_file
	.p2align	4, 0x90
_halide_debug_to_file:                  ## @halide_debug_to_file
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$4440, %rsp                     ## imm = 0x1158
	movq	%rcx, %r14
	movl	%edx, %r12d
	movq	%rsi, %rbx
	movq	%rdi, %r13
	cmpq	$0, 16(%rcx)
	jne	LBB112_3
## %bb.1:                               ## %entry
	cmpq	$0, (%r14)
	jne	LBB112_3
## %bb.2:                               ## %if.then
	leaq	L_.str.34(%rip), %rsi
	movq	%r13, %rdi
	callq	_halide_error
	movl	$-34, %r15d
	jmp	LBB112_87
LBB112_3:                               ## %if.end
	cmpl	$5, 36(%r14)
	jl	LBB112_5
## %bb.4:                               ## %if.then1
	leaq	L_.str.1.35(%rip), %rsi
	movq	%r13, %rdi
	callq	_halide_error
	movl	$-43, %r15d
	jmp	LBB112_87
LBB112_5:                               ## %if.end2
	movq	%r13, %rdi
	movq	%r14, %rsi
	callq	_halide_copy_to_host
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB112_87
## %bb.6:                               ## %cleanup.cont
	leaq	L_.str.2.36(%rip), %rsi
	movq	%rbx, %rdi
	callq	_fopen
	movq	%rax, -56(%rbp)                 ## 8-byte Spill
	testq	%rax, %rax
	je	LBB112_11
## %bb.7:                               ## %if.end9
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%ymm0, -192(%rbp)
	vmovups	%ymm0, -160(%rbp)
	movslq	36(%r14), %rax
	testq	%rax, %rax
	jle	LBB112_12
## %bb.8:                               ## %for.body.lr.ph
	movq	40(%r14), %rcx
	leal	-1(%rax), %esi
	cmpl	$3, %esi
	movl	$3, %edx
	cmovbl	%esi, %edx
	shlq	$4, %rdx
	addq	$16, %rdx
	movl	$1, %r15d
	leaq	-188(%rbp), %rsi
	xorl	%edi, %edi
	.p2align	4, 0x90
LBB112_9:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	vmovups	(%rcx,%rdi), %xmm0
	vmovups	%xmm0, -4(%rsi,%rdi)
	imull	-188(%rbp,%rdi), %r15d
	addq	$16, %rdi
	cmpq	%rdi, %rdx
	jne	LBB112_9
## %bb.10:                              ## %for.cond20.preheader
	cmpl	$3, %eax
	jle	LBB112_13
	jmp	LBB112_15
LBB112_11:
	movl	$-13, %r15d
	jmp	LBB112_87
LBB112_12:
	movl	$1, %r15d
LBB112_13:                              ## %for.body23.preheader
	leaq	1(%rax), %rcx
	shlq	$4, %rax
	leaq	-192(%rbp), %rdx
	addq	%rdx, %rax
	addq	$8, %rax
	movabsq	$4294967296, %rdx               ## imm = 0x100000000
	movq	%rcx, %rsi
	.p2align	4, 0x90
LBB112_14:                              ## %for.body23
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rdx, -8(%rax)
	movl	$0, (%rax)
	incq	%rsi
	addq	$16, %rax
	cmpl	$4, %ecx
	movq	%rsi, %rcx
	jne	LBB112_14
LBB112_15:                              ## %for.cond.cleanup22
	movzbl	33(%r14), %eax
	addq	$7, %rax
	shrq	$3, %rax
	movq	%rax, -72(%rbp)                 ## 8-byte Spill
	leaq	L_.str.3.37(%rip), %rsi
	movq	%rbx, %rdi
	vzeroupper
	callq	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	testb	%al, %al
	jne	LBB112_17
## %bb.16:                              ## %lor.lhs.false
	leaq	L_.str.4.38(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	testb	%al, %al
	je	LBB112_27
LBB112_17:                              ## %if.then38
	movl	-188(%rbp), %edx
	movl	-172(%rbp), %esi
	movl	-140(%rbp), %r8d
	cmpl	$2, %r8d
	setb	%al
	movl	-156(%rbp), %edi
	cmpl	$5, %edi
	setl	%cl
	testb	%cl, %al
	movl	$1, %ebx
	cmovel	%edi, %ebx
	movl	%r8d, -60(%rbp)                 ## 4-byte Spill
	movl	%r8d, %r13d
	movl	%edi, -64(%rbp)                 ## 4-byte Spill
	cmovnel	%edi, %r13d
	movabsq	$34362509641, %rax              ## imm = 0x8002A4949
	movq	%rax, -4480(%rbp)
	movl	$16777231, -4472(%rbp)          ## imm = 0x100000F
	movw	$4, -4468(%rbp)
	movl	$1, -4466(%rbp)
	movl	%edx, -48(%rbp)                 ## 4-byte Spill
	movl	%edx, -4462(%rbp)
	movabsq	$4295229697, %rax               ## imm = 0x100040101
	movq	%rax, -4458(%rbp)
	movl	%esi, -4450(%rbp)
	movq	-72(%rbp), %rdx                 ## 8-byte Reload
	leal	(,%rdx,8), %eax
	movabsq	$4295164162, %rcx               ## imm = 0x100030102
	movq	%rcx, -4446(%rbp)
	movw	%ax, -4438(%rbp)
	movabsq	$4295164163, %rax               ## imm = 0x100030103
	movq	%rax, -4434(%rbp)
	movw	$1, -4426(%rbp)
	xorl	%eax, %eax
	cmpl	$3, %r13d
	setge	%al
	incl	%eax
	movabsq	$4295164166, %rcx               ## imm = 0x100030106
	movq	%rcx, -4422(%rbp)
	movw	%ax, -4414(%rbp)
	movl	$262417, -4410(%rbp)            ## imm = 0x40111
	movl	%r13d, -4406(%rbp)
	movabsq	$845614636073170, %rax          ## imm = 0x30115000000D2
	movq	%rax, -4402(%rbp)
	movl	$1, -4394(%rbp)
	movw	%r13w, -4390(%rbp)
	movabsq	$4295229718, %rax               ## imm = 0x100040116
	movq	%rax, -4386(%rbp)
	imull	%edx, %r15d
	cmpl	$1, %r13d
	leal	210(,%r13,4), %eax
	cmovel	%r15d, %eax
	movl	%esi, -44(%rbp)                 ## 4-byte Spill
	movl	%esi, -4378(%rbp)
	movl	$262423, -4374(%rbp)            ## imm = 0x40117
	movl	%r13d, -4370(%rbp)
	movl	%eax, -4366(%rbp)
	vmovaps	LCPI112_0(%rip), %ymm0          ## ymm0 = [327962,1,194,327963,1,202,196892,1]
	vmovups	%ymm0, -4362(%rbp)
	movw	$2, -4330(%rbp)
	movabsq	$4295164200, %rax               ## imm = 0x100030128
	movq	%rax, -4326(%rbp)
	movw	$1, -4318(%rbp)
	movslq	%r12d, %rax
	movq	__ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE@GOTPCREL(%rip), %rcx
	movzwl	(%rcx,%rax,2), %eax
	movabsq	$4295164243, %rcx               ## imm = 0x100030153
	movq	%rcx, -4314(%rbp)
	movw	%ax, -4306(%rbp)
	movabsq	$4295262437, %rax               ## imm = 0x1000480E5
	movq	%rax, -4302(%rbp)
	movl	%ebx, -4294(%rbp)
	vmovaps	LCPI112_1(%rip), %xmm0          ## xmm0 = [0,1,1,1]
	vmovups	%xmm0, -4290(%rbp)
	movl	$1, -4274(%rbp)
	leaq	-4480(%rbp), %rdi
	movl	$210, %esi
	movl	$1, %edx
	movq	-56(%rbp), %r12                 ## 8-byte Reload
	movq	%r12, %rcx
	vzeroupper
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
## %bb.18:                              ## %if.end105
	cmpl	$2, %r13d
	jl	LBB112_25
## %bb.19:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit625.lr.ph
	leal	210(,%r13,8), %eax
	movl	%eax, -384(%rbp)
	movl	-48(%rbp), %r15d                ## 4-byte Reload
	imull	-72(%rbp), %r15d                ## 4-byte Folded Reload
	imull	-44(%rbp), %r15d                ## 4-byte Folded Reload
	imull	%ebx, %r15d
	leaq	-384(%rbp), %rbx
	movl	%r13d, %r12d
	.p2align	4, 0x90
LBB112_20:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit625
                                        ## =>This Inner Loop Header: Depth=1
	movl	$4, %esi
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	-56(%rbp), %rcx                 ## 8-byte Reload
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_57
## %bb.21:                              ## %if.end120
                                        ##   in Loop: Header=BB112_20 Depth=1
	addl	%r15d, -384(%rbp)
	decl	%r12d
	jne	LBB112_20
## %bb.22:                              ## %for.end133
	movl	%r15d, -240(%rbp)
	leaq	-240(%rbp), %rbx
	movq	-56(%rbp), %r12                 ## 8-byte Reload
LBB112_23:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit631
                                        ## =>This Inner Loop Header: Depth=1
	movl	$4, %esi
	movl	$1, %edx
	movq	%rbx, %rdi
	movq	%r12, %rcx
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
## %bb.24:                              ## %for.cond142
                                        ##   in Loop: Header=BB112_23 Depth=1
	decl	%r13d
	jne	LBB112_23
LBB112_25:                              ## %cleanup159
	xorl	%ecx, %ecx
	movl	-64(%rbp), %ebx                 ## 4-byte Reload
	movl	-60(%rbp), %r15d                ## 4-byte Reload
	jmp	LBB112_36
LBB112_27:                              ## %if.else169
	leaq	L_.str.5.39(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	testb	%al, %al
	je	LBB112_35
## %bb.28:                              ## %while.cond.preheader
	xorl	%ecx, %ecx
	movq	%rbx, %rdx
	.p2align	4, 0x90
LBB112_29:                              ## %while.cond
                                        ## =>This Inner Loop Header: Depth=1
	decq	%rcx
	cmpb	$0, (%rdx)
	leaq	1(%rdx), %rdx
	jne	LBB112_29
## %bb.30:                              ## %while.body176.preheader
	subq	%rcx, %rbx
	incq	%rcx
	xorl	%eax, %eax
	.p2align	4, 0x90
LBB112_31:                              ## %while.body176
                                        ## =>This Inner Loop Header: Depth=1
	incq	%rcx
	cmpb	$46, -2(%rdx,%rax)
	leaq	-1(%rax), %rax
	jne	LBB112_31
## %bb.32:                              ## %while.cond179.preheader
	leaq	-2(%rbx), %rsi
	leaq	-1(%rcx), %rdx
	xorl	%r15d, %r15d
LBB112_33:                              ## %while.cond179
                                        ## =>This Inner Loop Header: Depth=1
	cmpq	%r15, %rcx
	je	LBB112_58
## %bb.34:                              ## %land.rhs181
                                        ##   in Loop: Header=BB112_33 Depth=1
	leaq	(%rsi,%r15), %rdi
	decq	%r15
	cmpb	$47, (%rax,%rdi)
	jne	LBB112_33
	jmp	LBB112_59
LBB112_35:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit673
	movl	-188(%rbp), %eax
	movl	-172(%rbp), %ecx
	movl	%eax, -48(%rbp)                 ## 4-byte Spill
	movl	%eax, -4480(%rbp)
	movl	%ecx, -44(%rbp)                 ## 4-byte Spill
	movl	%ecx, -4476(%rbp)
	movl	-156(%rbp), %ebx
	movl	%ebx, -4472(%rbp)
	movl	-140(%rbp), %r15d
	movl	%r15d, -4468(%rbp)
	movl	%r12d, -4464(%rbp)
	leaq	-4480(%rbp), %rdi
	movl	$20, %esi
	movl	$1, %edx
	movq	-56(%rbp), %r12                 ## 8-byte Reload
	movq	%r12, %rcx
	callq	_fwrite
	xorl	%ecx, %ecx
	testq	%rax, %rax
	je	LBB112_26
LBB112_36:                              ## %if.end316
	movl	$4096, %eax                     ## imm = 0x1000
	xorl	%edx, %edx
	divl	-72(%rbp)                       ## 4-byte Folded Reload
	movl	%eax, -96(%rbp)                 ## 4-byte Spill
	testl	%r15d, %r15d
	jle	LBB112_54
## %bb.37:                              ## %for.body327.lr.ph
	testl	%ebx, %ebx
	jle	LBB112_54
## %bb.38:                              ## %for.body327.lr.ph
	cmpl	$0, -44(%rbp)                   ## 4-byte Folded Reload
	jle	LBB112_54
## %bb.39:                              ## %for.body327.lr.ph
	cmpl	$0, -48(%rbp)                   ## 4-byte Folded Reload
	jle	LBB112_54
## %bb.40:                              ## %for.body327.us.us.us.preheader
	movq	%rcx, -88(%rbp)                 ## 8-byte Spill
	movl	-144(%rbp), %eax
	movl	%eax, -80(%rbp)                 ## 4-byte Spill
	addl	%eax, %r15d
	movl	%r15d, -60(%rbp)                ## 4-byte Spill
	movl	-160(%rbp), %r12d
	addl	%r12d, %ebx
	movl	%ebx, -64(%rbp)                 ## 4-byte Spill
	movl	-192(%rbp), %eax
	movl	-176(%rbp), %ebx
	addl	%ebx, -44(%rbp)                 ## 4-byte Folded Spill
	movl	%eax, -108(%rbp)                ## 4-byte Spill
	addl	%eax, -48(%rbp)                 ## 4-byte Folded Spill
	movl	-96(%rbp), %eax                 ## 4-byte Reload
                                        ## kill: def $eax killed $eax def $rax
	imull	-72(%rbp), %eax                 ## 4-byte Folded Reload
	movq	%rax, -248(%rbp)                ## 8-byte Spill
	xorl	%r13d, %r13d
	movl	%r12d, -100(%rbp)               ## 4-byte Spill
	movl	%ebx, -104(%rbp)                ## 4-byte Spill
	jmp	LBB112_42
LBB112_41:                              ## %for.inc394.us.us.us.us.us.us
                                        ##   in Loop: Header=BB112_42 Depth=1
	incl	%ebx
	cmpl	-44(%rbp), %ebx                 ## 4-byte Folded Reload
	jge	LBB112_50
LBB112_42:                              ## %for.body349.us.us.us.us.us.us
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB112_44 Depth 2
                                        ##       Child Loop BB112_46 Depth 3
	movl	-108(%rbp), %r15d               ## 4-byte Reload
	movl	%r13d, %eax
	jmp	LBB112_44
	.p2align	4, 0x90
LBB112_43:                              ## %for.inc389.us.us.us.us.us.us
                                        ##   in Loop: Header=BB112_44 Depth=2
	incl	%r15d
	movl	%r13d, %eax
	cmpl	-48(%rbp), %r15d                ## 4-byte Folded Reload
	jge	LBB112_41
LBB112_44:                              ## %for.body360.us.us.us.us.us.us
                                        ##   Parent Loop BB112_42 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB112_46 Depth 3
	leal	1(%rax), %r13d
	movl	%r15d, -384(%rbp)
	movl	%ebx, -380(%rbp)
	movl	%r12d, -376(%rbp)
	movl	-80(%rbp), %ecx                 ## 4-byte Reload
	movl	%ecx, -372(%rbp)
	movl	36(%r14), %ecx
	testl	%ecx, %ecx
	jle	LBB112_47
## %bb.45:                              ## %for.body.lr.ph.i.us.us.us.us.us.us
                                        ##   in Loop: Header=BB112_44 Depth=2
	movq	40(%r14), %rsi
	shlq	$2, %rcx
	xorl	%edi, %edi
	xorl	%edx, %edx
	.p2align	4, 0x90
LBB112_46:                              ## %for.body.i.us.us.us.us.us.us
                                        ##   Parent Loop BB112_42 Depth=1
                                        ##     Parent Loop BB112_44 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movslq	8(%rsi,%rdi,4), %r8
	movslq	-384(%rbp,%rdi), %r9
	movslq	(%rsi,%rdi,4), %r10
	subq	%r10, %r9
	imulq	%r8, %r9
	addq	%r9, %rdx
	addq	$4, %rdi
	cmpq	%rdi, %rcx
	jne	LBB112_46
	jmp	LBB112_48
LBB112_47:                              ##   in Loop: Header=BB112_44 Depth=2
	xorl	%edx, %edx
LBB112_48:                              ## %_ZNK15halide_buffer_t10address_ofEPKi.exit.us.us.us.us.us.us
                                        ##   in Loop: Header=BB112_44 Depth=2
	movzbl	33(%r14), %esi
	addq	$7, %rsi
	shrq	$3, %rsi
	imulq	%rdx, %rsi
	addq	16(%r14), %rsi
	movq	-72(%rbp), %rdx                 ## 8-byte Reload
	imull	%edx, %eax
	cltq
	leaq	(%rax,%rbp), %rdi
	addq	$-4480, %rdi                    ## imm = 0xEE80
	callq	_memcpy
	cmpl	-96(%rbp), %r13d                ## 4-byte Folded Reload
	jne	LBB112_43
## %bb.49:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit689.us.us.us.us.us.us
                                        ##   in Loop: Header=BB112_44 Depth=2
	movl	$1, %edx
	leaq	-4480(%rbp), %rdi
	movq	-248(%rbp), %rsi                ## 8-byte Reload
	movq	-56(%rbp), %rcx                 ## 8-byte Reload
	callq	_fwrite
	xorl	%r13d, %r13d
	testq	%rax, %rax
	jne	LBB112_43
	jmp	LBB112_85
LBB112_50:                              ## %for.inc399.us.us.us.us.us
                                        ##   in Loop: Header=BB112_42 Depth=1
	incl	%r12d
	cmpl	-64(%rbp), %r12d                ## 4-byte Folded Reload
	movl	-104(%rbp), %ebx                ## 4-byte Reload
	jl	LBB112_42
## %bb.51:                              ## %for.inc404.us.us.us
                                        ##   in Loop: Header=BB112_42 Depth=1
	movl	-80(%rbp), %eax                 ## 4-byte Reload
	incl	%eax
	movl	%eax, -80(%rbp)                 ## 4-byte Spill
	cmpl	-60(%rbp), %eax                 ## 4-byte Folded Reload
	movl	-100(%rbp), %r12d               ## 4-byte Reload
	jl	LBB112_42
## %bb.52:                              ## %for.end408
	testl	%r13d, %r13d
	movq	-56(%rbp), %r12                 ## 8-byte Reload
	movq	-88(%rbp), %rcx                 ## 8-byte Reload
	jle	LBB112_54
## %bb.53:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit695
	imull	-72(%rbp), %r13d                ## 4-byte Folded Reload
	movslq	%r13d, %rsi
	leaq	-4480(%rbp), %rdi
	movl	$1, %edx
	movq	%r12, %rcx
	callq	_fwrite
	movq	-88(%rbp), %rcx                 ## 8-byte Reload
	testq	%rax, %rax
	je	LBB112_26
LBB112_54:                              ## %if.end417
	movq	$0, -384(%rbp)
	testl	%ecx, %ecx
	je	LBB112_56
## %bb.55:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit701
	movl	%ecx, %esi
	leaq	-384(%rbp), %rdi
	movl	$1, %edx
	movq	%r12, %rcx
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
LBB112_56:                              ## %if.end428
	xorl	%r15d, %r15d
	jmp	LBB112_86
LBB112_57:                              ## %cleanup155.thread
	movq	-56(%rbp), %r12                 ## 8-byte Reload
	movl	$-13, %r15d
	jmp	LBB112_86
LBB112_58:
	movq	%rdx, %r15
LBB112_59:                              ## %while.end188
	cmpq	$-1, %r15
	je	LBB112_65
## %bb.60:                              ## %while.body192.preheader
	movq	%r15, %rdx
	notq	%rdx
	addq	%r15, %rbx
	xorl	%ecx, %ecx
LBB112_61:                              ## %while.body192
                                        ## =>This Inner Loop Header: Depth=1
	leaq	(%rbx,%rcx), %rsi
	movzbl	(%rax,%rsi), %esi
	movb	%sil, -4480(%rbp,%rcx)
	incq	%rcx
	cmpq	%rcx, %rdx
	jne	LBB112_61
## %bb.62:                              ## %while.cond196.preheader
	leaq	-1(%rcx), %rax
	cmpq	$255, %rax
	jb	LBB112_66
	jmp	LBB112_67
LBB112_65:
	xorl	%ecx, %ecx
LBB112_66:                              ## %while.body199
                                        ## =>This Inner Loop Header: Depth=1
	movb	$0, -4480(%rbp,%rcx)
	incq	%rcx
	cmpq	$256, %rcx                      ## imm = 0x100
	jne	LBB112_66
LBB112_67:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit637
	vmovups	l___const.halide_debug_to_file.header+96(%rip), %ymm0
	vmovups	%ymm0, -288(%rbp)
	vmovups	l___const.halide_debug_to_file.header+64(%rip), %ymm0
	vmovups	%ymm0, -320(%rbp)
	vmovups	l___const.halide_debug_to_file.header+32(%rip), %ymm0
	vmovups	%ymm0, -352(%rbp)
	vmovups	l___const.halide_debug_to_file.header(%rip), %ymm0
	vmovups	%ymm0, -384(%rbp)
	movb	$0, -256(%rbp)
	leaq	-384(%rbp), %rdi
	movl	$1, %ebx
	movl	$128, %esi
	movl	$1, %edx
	movq	-56(%rbp), %rcx                 ## 8-byte Reload
	vzeroupper
	callq	_fwrite
	movl	36(%r14), %eax
	testl	%eax, %eax
	jle	LBB112_77
## %bb.68:                              ## %for.body.lr.ph.i.i
	movq	40(%r14), %rcx
	movq	%rax, %rdx
	shlq	$4, %rdx
	xorl	%esi, %esi
	xorl	%ebx, %ebx
	jmp	LBB112_70
LBB112_69:                              ## %if.end.i.i
                                        ##   in Loop: Header=BB112_70 Depth=1
	addq	$16, %rsi
	cmpq	%rsi, %rdx
	je	LBB112_72
LBB112_70:                              ## %for.body.i.i
                                        ## =>This Inner Loop Header: Depth=1
	movl	8(%rcx,%rsi), %edi
	testl	%edi, %edi
	jle	LBB112_69
## %bb.71:                              ## %if.then.i.i
                                        ##   in Loop: Header=BB112_70 Depth=1
	movslq	4(%rcx,%rsi), %r8
	decq	%r8
	imulq	%rdi, %r8
	addq	%r8, %rbx
	jmp	LBB112_69
LBB112_72:                              ## %for.body.i12.i.preheader
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	LBB112_74
LBB112_73:                              ## %if.end.i23.i
                                        ##   in Loop: Header=BB112_74 Depth=1
	addq	$16, %rsi
	cmpq	%rsi, %rdx
	je	LBB112_76
LBB112_74:                              ## %for.body.i12.i
                                        ## =>This Inner Loop Header: Depth=1
	movslq	8(%rcx,%rsi), %r8
	testq	%r8, %r8
	jns	LBB112_73
## %bb.75:                              ## %if.then.i19.i
                                        ##   in Loop: Header=BB112_74 Depth=1
	movslq	4(%rcx,%rsi), %r9
	decq	%r9
	imulq	%r8, %r9
	addq	%r9, %rdi
	jmp	LBB112_73
LBB112_76:                              ## %_ZNK15halide_buffer_t12begin_offsetEv.exit.loopexit.i
	subq	%rdi, %rbx
	incq	%rbx
LBB112_77:                              ## %_ZNK15halide_buffer_t13size_in_bytesEv.exit
	movzbl	33(%r14), %esi
	addq	$7, %rsi
	shrq	$3, %rsi
	imulq	%rbx, %rsi
	movl	%esi, %edx
	negl	%edx
	andl	$7, %edx
	leaq	(%rdx,%rsi), %rcx
	shrq	$32, %rcx
	jne	LBB112_84
## %bb.78:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit643
	movl	$6, %r13d
	subl	%r15d, %r13d
	andl	$-8, %r13d
	cmpl	$3, %eax
	movl	$2, %ecx
	cmovgel	%eax, %ecx
	movl	$14, -240(%rbp)
	leal	4(,%rcx,4), %ebx
	movl	%ecx, %eax
	shll	$2, %eax
	andl	$-8, %ebx
	leal	(%rbx,%r13), %ecx
	movq	%rsi, -96(%rbp)                 ## 8-byte Spill
	addl	%esi, %ecx
	movq	%rdx, -88(%rbp)                 ## 8-byte Spill
	addl	%edx, %ecx
	addl	$40, %ecx
	movl	%ecx, -236(%rbp)
	movabsq	$34359738374, %rcx              ## imm = 0x800000006
	movq	%rcx, -232(%rbp)
	movslq	%r12d, %rdx
	movq	__ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE@GOTPCREL(%rip), %rcx
	movq	%rdx, -80(%rbp)                 ## 8-byte Spill
	movzbl	(%rcx,%rdx), %ecx
	movl	%ecx, -224(%rbp)
	movabsq	$21474836481, %rcx              ## imm = 0x500000001
	movq	%rcx, -220(%rbp)
	movl	%eax, -212(%rbp)
	leaq	-240(%rbp), %rdi
	movl	$32, %esi
	movl	$1, %edx
	movq	-56(%rbp), %r12                 ## 8-byte Reload
	movq	%r12, %rcx
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
## %bb.79:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit649
	movl	-188(%rbp), %eax
	movl	-172(%rbp), %ecx
	movl	%eax, -48(%rbp)                 ## 4-byte Spill
	movl	%eax, -208(%rbp)
	movl	%ecx, -44(%rbp)                 ## 4-byte Spill
	movl	%ecx, -204(%rbp)
	movl	-156(%rbp), %eax
	movl	%eax, -64(%rbp)                 ## 4-byte Spill
	movl	%eax, -200(%rbp)
	movl	-140(%rbp), %eax
	movl	%eax, -60(%rbp)                 ## 4-byte Spill
	movl	%eax, -196(%rbp)
	movslq	%ebx, %rsi
	leaq	-208(%rbp), %rdi
	movl	$1, %edx
	movq	%r12, %rcx
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
## %bb.80:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit655
	notl	%r15d
	movl	$1, -124(%rbp)
	movl	%r15d, -120(%rbp)
	leaq	-124(%rbp), %rdi
	movl	$8, %esi
	movl	$1, %edx
	movq	%r12, %rcx
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
## %bb.81:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit661
	movl	%r13d, %esi
	leaq	-4480(%rbp), %rdi
	movl	$1, %edx
	movq	%r12, %rcx
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
## %bb.82:                              ## %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit667
	movq	__ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE@GOTPCREL(%rip), %rax
	movq	-80(%rbp), %rcx                 ## 8-byte Reload
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -116(%rbp)
	movq	-96(%rbp), %rax                 ## 8-byte Reload
	movl	%eax, -112(%rbp)
	leaq	-116(%rbp), %rdi
	movl	$8, %esi
	movl	$1, %edx
	movq	%r12, %rcx
	callq	_fwrite
	testq	%rax, %rax
	je	LBB112_26
## %bb.83:                              ## %cleanup283
	movl	-64(%rbp), %ebx                 ## 4-byte Reload
	movl	-60(%rbp), %r15d                ## 4-byte Reload
	movq	-88(%rbp), %rcx                 ## 8-byte Reload
	jmp	LBB112_36
LBB112_26:                              ## %cleanup159.thread
	movl	$-13, %r15d
	jmp	LBB112_86
LBB112_84:                              ## %cleanup283.thread
	leaq	L_.str.6.40(%rip), %rsi
	movq	%r13, %rdi
	callq	_halide_error
LBB112_85:                              ## %cleanup406
	movl	$-13, %r15d
	movq	-56(%rbp), %r12                 ## 8-byte Reload
LBB112_86:                              ## %cleanup438
	movq	%r12, %rdi
	callq	_fclose
LBB112_87:                              ## %return
	movl	%r15d, %eax
	addq	$4440, %rsp                     ## imm = 0x1158
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_cache_cleanup           ## -- Begin function halide_cache_cleanup
	.weak_definition	_halide_cache_cleanup
	.p2align	4, 0x90
_halide_cache_cleanup:                  ## @halide_cache_cleanup
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_halide_memoization_cache_cleanup ## TAILCALL
                                        ## -- End function
	.globl	_halide_memoization_cache_cleanup ## -- Begin function halide_memoization_cache_cleanup
	.weak_definition	_halide_memoization_cache_cleanup
	.p2align	4, 0x90
_halide_memoization_cache_cleanup:      ## @halide_memoization_cache_cleanup
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %r14
	movl	$2048, %r15d                    ## imm = 0x800
	addq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %r15
	jmp	LBB114_1
	.p2align	4, 0x90
LBB114_3:                               ## %while.end
                                        ##   in Loop: Header=BB114_1 Depth=1
	addq	$8, %r14
	cmpq	%r15, %r14
	je	LBB114_4
LBB114_1:                               ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB114_2 Depth 2
	movq	(%r14), %rbx
	movq	$0, (%r14)
	testq	%rbx, %rbx
	je	LBB114_3
	.p2align	4, 0x90
LBB114_2:                               ## %while.body
                                        ##   Parent Loop BB114_1 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%rbx), %r12
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	xorl	%edi, %edi
	movq	%rbx, %rsi
	callq	_halide_free
	movq	%r12, %rbx
	testq	%r12, %r12
	jne	LBB114_2
	jmp	LBB114_3
LBB114_4:                               ## %for.cond.cleanup
	movq	__ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPCREL(%rip), %rax
	movq	$0, (%rax)
	movq	__ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPCREL(%rip), %rax
	movq	$0, (%rax)
	movq	__ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPCREL(%rip), %rax
	movq	$0, (%rax)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv ## -- Begin function _ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	.weak_definition	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv: ## @_ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %rbx
	cmpl	$0, 56(%rdi)
	je	LBB115_3
## %bb.1:                               ## %for.body.lr.ph
	xorl	%r14d, %r14d
	xorl	%r15d, %r15d
	.p2align	4, 0x90
LBB115_2:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	72(%rbx), %rsi
	addq	%r14, %rsi
	xorl	%edi, %edi
	callq	_halide_device_free
	movq	72(%rbx), %rax
	movq	16(%rax,%r14), %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	xorl	%edi, %edi
	movq	%rax, %rsi
	callq	_halide_free
	incq	%r15
	movl	56(%rbx), %eax
	addq	$56, %r14
	cmpq	%rax, %r15
	jb	LBB115_2
LBB115_3:                               ## %for.cond.cleanup
	movq	24(%rbx), %rsi
	xorl	%edi, %edi
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_free                    ## TAILCALL
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh ## -- Begin function _ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	.weak_definition	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh: ## @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	leaq	-64(%rdi), %rax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx ## -- Begin function _ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
	.weak_definition	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx: ## @_ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
                                        ## kill: def $esi killed $esi def $rsi
	leal	-16(%rsi), %eax
	cmpl	$-17, %eax
	jae	LBB117_1
LBB117_7:                               ## %if.end17
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB117_1:                               ## %while.cond.preheader
	movq	%rcx, %r14
	movq	%rdx, %rbx
	movq	%rdi, %r15
	testl	%esi, %esi
	js	LBB117_9
## %bb.2:                               ## %land.rhs.preheader
	movl	%esi, %r12d
	.p2align	4, 0x90
LBB117_3:                               ## %land.rhs
                                        ## =>This Inner Loop Header: Depth=1
	movq	24(%r15,%r12,8), %rax
	cmpq	$1, %rax
	jne	LBB117_4
## %bb.8:                               ## %while.body
                                        ##   in Loop: Header=BB117_3 Depth=1
	leaq	-1(%r12), %rax
	testq	%r12, %r12
	movq	%rax, %r12
	jg	LBB117_3
LBB117_9:                               ## %if.then5
	addq	(%r15), %rbx
	addq	8(%r15), %r14
	movq	408(%r15), %rdx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_memcpy                         ## TAILCALL
LBB117_4:                               ## %land.rhs
	testq	%rax, %rax
	je	LBB117_7
## %bb.5:                               ## %for.body.lr.ph
	movl	%r12d, %eax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
	decq	%r12
	xorl	%r13d, %r13d
	.p2align	4, 0x90
LBB117_6:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r15, %rdi
	movl	%r12d, %esi
	movq	%rbx, %rdx
	movq	%r14, %rcx
	callq	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	addq	152(%r15,%rax,8), %rbx
	addq	280(%r15,%rax,8), %r14
	incq	%r13
	cmpq	24(%r15,%rax,8), %r13
	jb	LBB117_6
	jmp	LBB117_7
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv ## -- Begin function _ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
	.weak_definition	__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv: ## @_ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	(%rdi), %rax
	cmpq	8(%rdi), %rax
	jne	LBB118_2
## %bb.1:                               ## %if.end
	popq	%rbp
	retq
LBB118_2:                               ## %if.then
	movq	16(%rdi), %rdx
	movl	$15, %esi
	xorl	%ecx, %ecx
	popq	%rbp
	jmp	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx ## TAILCALL
                                        ## -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3, 0x0                          ## -- Begin function _ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
LCPI119_0:
	.quad	1                               ## 0x1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
	.weak_definition	__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b: ## @_ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$712, %rsp                      ## imm = 0x2C8
	movq	%rdi, %rbx
	testl	%edx, %edx
	je	LBB119_2
## %bb.1:                               ## %cond.true
	movq	16(%rsi), %rax
	movq	%rax, -712(%rbp)
	testb	%r8b, %r8b
	jne	LBB119_4
LBB119_5:                               ## %cond.false6
	movq	(%rcx), %rax
	jmp	LBB119_6
LBB119_2:                               ## %cond.false
	movq	(%rsi), %rax
	movq	%rax, -712(%rbp)
	testb	%r8b, %r8b
	je	LBB119_5
LBB119_4:                               ## %cond.true4
	movq	16(%rcx), %rax
LBB119_6:                               ## %cond.end8
	movq	%rax, -704(%rbp)
	movzbl	33(%rsi), %edx
	leaq	7(%rdx), %rdi
	shrq	$3, %rdi
	movq	%rdi, -304(%rbp)
	vbroadcastsd	LCPI119_0(%rip), %ymm0  ## ymm0 = [1,1,1,1]
	vmovups	%ymm0, -688(%rbp)
	vxorps	%xmm1, %xmm1, %xmm1
	vmovups	%ymm1, -560(%rbp)
	vmovups	%ymm1, -432(%rbp)
	vmovups	%ymm0, -656(%rbp)
	vmovups	%ymm1, -528(%rbp)
	vmovups	%ymm1, -400(%rbp)
	vmovups	%ymm0, -624(%rbp)
	vmovups	%ymm1, -496(%rbp)
	vmovups	%ymm1, -368(%rbp)
	vmovups	%ymm0, -592(%rbp)
	vmovups	%ymm1, -464(%rbp)
	vmovups	%ymm1, -336(%rbp)
	movl	36(%rsi), %eax
	testl	%eax, %eax
	jle	LBB119_7
## %bb.12:                              ## %for.body19.lr.ph
	movq	40(%rsi), %r9
	movq	40(%rcx), %r10
	movq	%rax, %r11
	shlq	$4, %r11
	xorl	%r14d, %r14d
	xorl	%r8d, %r8d
	.p2align	4, 0x90
LBB119_13:                              ## %for.body19
                                        ## =>This Inner Loop Header: Depth=1
	movslq	8(%r9,%r14), %r15
	movslq	(%r10,%r14), %r12
	movslq	(%r9,%r14), %r13
	subq	%r13, %r12
	imulq	%r15, %r12
	addq	%r12, %r8
	addq	$16, %r14
	cmpq	%r14, %r11
	jne	LBB119_13
## %bb.8:                               ## %for.cond.cleanup18
	imulq	%rdi, %r8
	movq	%r8, -696(%rbp)
	cmpl	36(%rcx), %eax
	je	LBB119_9
	jmp	LBB119_11
LBB119_7:
	xorl	%r8d, %r8d
	imulq	%rdi, %r8
	movq	%r8, -696(%rbp)
	cmpl	36(%rcx), %eax
	jne	LBB119_11
LBB119_9:                               ## %lor.lhs.false
	movzbl	33(%rcx), %r8d
	addl	$7, %r8d
	shrl	$3, %r8d
	cmpl	%r8d, %edi
	jne	LBB119_11
## %bb.10:                              ## %lor.lhs.false
	cmpl	$17, %eax
	jge	LBB119_11
## %bb.14:                              ## %if.end
	testb	%dl, %dl
	je	LBB119_11
## %bb.15:                              ## %for.cond54.preheader
	testl	%eax, %eax
	jle	LBB119_16
## %bb.37:                              ## %for.body58.lr.ph
	movq	40(%rcx), %rcx
	movq	40(%rsi), %rdx
	xorl	%esi, %esi
	jmp	LBB119_38
	.p2align	4, 0x90
LBB119_47:                              ## %for.cond.cleanup94
                                        ##   in Loop: Header=BB119_38 Depth=1
	movslq	4(%rcx,%r9), %r9
	movq	%r9, -688(%rbp,%r11,8)
	movq	%r8, -432(%rbp,%r11,8)
	movq	%r10, -560(%rbp,%r11,8)
	incq	%rsi
	cmpq	%rax, %rsi
	je	LBB119_17
LBB119_38:                              ## %for.body58
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB119_41 Depth 2
                                        ##     Child Loop BB119_46 Depth 2
	movq	%rsi, %r9
	shlq	$4, %r9
	movslq	8(%rcx,%r9), %r8
	imulq	%rdi, %r8
	movl	$0, %r11d
	testq	%rsi, %rsi
	je	LBB119_44
## %bb.39:                              ## %for.body81.lr.ph
                                        ##   in Loop: Header=BB119_38 Depth=1
	testq	%r8, %r8
	je	LBB119_48
## %bb.40:                              ## %for.body81.preheader
                                        ##   in Loop: Header=BB119_38 Depth=1
	xorl	%r11d, %r11d
	.p2align	4, 0x90
LBB119_41:                              ## %for.body81
                                        ##   Parent Loop BB119_38 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpq	-432(%rbp,%r11,8), %r8
	jb	LBB119_44
## %bb.42:                              ## %for.inc89
                                        ##   in Loop: Header=BB119_41 Depth=2
	incq	%r11
	cmpq	%r11, %rsi
	jne	LBB119_41
## %bb.43:                              ##   in Loop: Header=BB119_38 Depth=1
	movq	%rsi, %r11
	jmp	LBB119_44
	.p2align	4, 0x90
LBB119_48:                              ## %for.body81.us.preheader
                                        ##   in Loop: Header=BB119_38 Depth=1
	movl	%esi, %r11d
LBB119_44:                              ## %for.end91
                                        ##   in Loop: Header=BB119_38 Depth=1
	movslq	8(%rdx,%r9), %r10
	imulq	%rdi, %r10
	movl	%r11d, %r11d
	cmpq	%r11, %rsi
	jbe	LBB119_47
## %bb.45:                              ## %for.body95.preheader
                                        ##   in Loop: Header=BB119_38 Depth=1
	movslq	%r11d, %r14
	movq	%rsi, %r15
	.p2align	4, 0x90
LBB119_46:                              ## %for.body95
                                        ##   Parent Loop BB119_38 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	-696(%rbp,%r15,8), %r12
	movq	-568(%rbp,%r15,8), %r13
	movq	%r12, -688(%rbp,%r15,8)
	movq	-440(%rbp,%r15,8), %r12
	movq	%r12, -432(%rbp,%r15,8)
	movq	%r13, -560(%rbp,%r15,8)
	leaq	-1(%r15), %r12
	movq	%r12, %r15
	cmpq	%r14, %r12
	jg	LBB119_46
	jmp	LBB119_47
LBB119_11:                              ## %if.then
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%ymm0, 384(%rbx)
	vmovups	%ymm0, 352(%rbx)
	vmovups	%ymm0, 320(%rbx)
	vmovups	%ymm0, 288(%rbx)
	vmovups	%ymm0, 256(%rbx)
	vmovups	%ymm0, 224(%rbx)
	vmovups	%ymm0, 192(%rbx)
	vmovups	%ymm0, 160(%rbx)
	vmovups	%ymm0, 128(%rbx)
	vmovups	%ymm0, 96(%rbx)
	vmovups	%ymm0, 64(%rbx)
	vmovups	%ymm0, 32(%rbx)
	vmovups	%ymm0, (%rbx)
LBB119_36:                              ## %while.end
	movq	%rbx, %rax
	addq	$712, %rsp                      ## imm = 0x2C8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
LBB119_17:                              ## %while.cond.preheader
	movq	-304(%rbp), %rdi
	testq	%rdi, %rdi
	je	LBB119_35
## %bb.18:                              ## %while.cond.preheader.land.lhs.true138.lr.ph_crit_edge
	movq	-560(%rbp), %rdx
	movq	-432(%rbp), %r12
	movq	-680(%rbp), %rax
	movq	%rax, -744(%rbp)                ## 8-byte Spill
	movq	-672(%rbp), %rax
	movq	%rax, -720(%rbp)                ## 8-byte Spill
	movq	-552(%rbp), %rax
	movq	-424(%rbp), %r14
	movq	-544(%rbp), %rcx
	movq	%rcx, -728(%rbp)                ## 8-byte Spill
	movq	-416(%rbp), %r10
	movq	-664(%rbp), %rcx
	movq	%rcx, -288(%rbp)                ## 8-byte Spill
	movq	-536(%rbp), %rcx
	movq	%rcx, -296(%rbp)                ## 8-byte Spill
	movq	-408(%rbp), %rcx
	movq	%rcx, -280(%rbp)                ## 8-byte Spill
	movq	-656(%rbp), %rcx
	movq	%rcx, -264(%rbp)                ## 8-byte Spill
	movq	-528(%rbp), %rcx
	movq	%rcx, -72(%rbp)                 ## 8-byte Spill
	movq	-400(%rbp), %rcx
	movq	%rcx, -48(%rbp)                 ## 8-byte Spill
	movq	-648(%rbp), %rcx
	movq	%rcx, -80(%rbp)                 ## 8-byte Spill
	movq	-520(%rbp), %rcx
	movq	%rcx, -240(%rbp)                ## 8-byte Spill
	movq	-392(%rbp), %rcx
	movq	%rcx, -88(%rbp)                 ## 8-byte Spill
	movq	-640(%rbp), %rcx
	movq	%rcx, -96(%rbp)                 ## 8-byte Spill
	movq	-512(%rbp), %rcx
	movq	%rcx, -248(%rbp)                ## 8-byte Spill
	movq	-384(%rbp), %rcx
	movq	%rcx, -104(%rbp)                ## 8-byte Spill
	movq	-632(%rbp), %rcx
	movq	%rcx, -112(%rbp)                ## 8-byte Spill
	movq	-504(%rbp), %rcx
	movq	-376(%rbp), %rsi
	movq	%rsi, -120(%rbp)                ## 8-byte Spill
	movq	-624(%rbp), %rsi
	movq	%rsi, -128(%rbp)                ## 8-byte Spill
	movq	-496(%rbp), %r15
	movq	-368(%rbp), %rsi
	movq	%rsi, -136(%rbp)                ## 8-byte Spill
	movq	-616(%rbp), %rsi
	movq	%rsi, -144(%rbp)                ## 8-byte Spill
	movq	-488(%rbp), %r13
	movq	-360(%rbp), %rsi
	movq	%rsi, -152(%rbp)                ## 8-byte Spill
	movq	-608(%rbp), %rsi
	movq	%rsi, -160(%rbp)                ## 8-byte Spill
	movq	-480(%rbp), %r11
	movq	-352(%rbp), %rsi
	movq	%rsi, -168(%rbp)                ## 8-byte Spill
	movq	-600(%rbp), %rsi
	movq	%rsi, -176(%rbp)                ## 8-byte Spill
	movq	-472(%rbp), %r9
	movq	-344(%rbp), %rsi
	movq	%rsi, -184(%rbp)                ## 8-byte Spill
	movq	-592(%rbp), %rsi
	movq	%rsi, -192(%rbp)                ## 8-byte Spill
	movq	-464(%rbp), %rsi
	movq	%rsi, -56(%rbp)                 ## 8-byte Spill
	movq	-336(%rbp), %r8
	movq	%r8, -200(%rbp)                 ## 8-byte Spill
	movq	-584(%rbp), %r8
	movq	%r8, -208(%rbp)                 ## 8-byte Spill
	movq	-456(%rbp), %r8
	movq	%r8, -64(%rbp)                  ## 8-byte Spill
	movq	-328(%rbp), %r8
	movq	%r8, -216(%rbp)                 ## 8-byte Spill
	movq	-576(%rbp), %r8
	movq	%r8, -224(%rbp)                 ## 8-byte Spill
	movq	-448(%rbp), %r8
	movq	%r8, -256(%rbp)                 ## 8-byte Spill
	movq	%r9, %rsi
	movq	%r11, %r9
	movq	%r13, %r11
	movq	%r15, %r13
	movq	%rcx, %r15
	movq	-320(%rbp), %rcx
	movq	%rcx, -232(%rbp)                ## 8-byte Spill
	movq	-568(%rbp), %rcx
	movq	-440(%rbp), %r8
	movq	%r8, -272(%rbp)                 ## 8-byte Spill
	movq	-312(%rbp), %r8
	jmp	LBB119_19
LBB119_16:
	movl	$1, %ecx
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	movq	%rax, -272(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -232(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -256(%rbp)                ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -224(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -216(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -64(%rbp)                 ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -208(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -200(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -56(%rbp)                 ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -192(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -184(%rbp)                ## 8-byte Spill
	xorl	%esi, %esi
	movl	$1, %eax
	movq	%rax, -176(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -168(%rbp)                ## 8-byte Spill
	xorl	%r9d, %r9d
	movl	$1, %eax
	movq	%rax, -160(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -152(%rbp)                ## 8-byte Spill
	xorl	%r11d, %r11d
	movl	$1, %eax
	movq	%rax, -144(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -136(%rbp)                ## 8-byte Spill
	xorl	%r13d, %r13d
	movl	$1, %eax
	movq	%rax, -128(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -120(%rbp)                ## 8-byte Spill
	xorl	%r15d, %r15d
	movl	$1, %eax
	movq	%rax, -112(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -104(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -248(%rbp)                ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -96(%rbp)                 ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -88(%rbp)                 ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -240(%rbp)                ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -80(%rbp)                 ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -72(%rbp)                 ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -264(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -280(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -296(%rbp)                ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -288(%rbp)                ## 8-byte Spill
	xorl	%r10d, %r10d
	xorl	%eax, %eax
	movq	%rax, -728(%rbp)                ## 8-byte Spill
	movl	$1, %eax
	movq	%rax, -720(%rbp)                ## 8-byte Spill
	xorl	%r14d, %r14d
	xorl	%eax, %eax
	movl	$1, %edx
	movq	%rdx, -744(%rbp)                ## 8-byte Spill
	xorl	%r12d, %r12d
	xorl	%edx, %edx
LBB119_19:                              ## %land.lhs.true138.lr.ph
	cmpq	%rdx, %rdi
	jne	LBB119_35
## %bb.20:                              ## %land.lhs.true138.lr.ph
	cmpq	%r12, %rdi
	jne	LBB119_35
## %bb.21:                              ## %while.body.peel
	imulq	-688(%rbp), %r12
	movq	%r12, -304(%rbp)
	movq	-744(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -688(%rbp)
	movq	%rax, -560(%rbp)
	movq	%r14, -432(%rbp)
	movq	-720(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -680(%rbp)
	movq	-728(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -552(%rbp)
	movq	%r10, -424(%rbp)
	movq	-288(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -672(%rbp)
	movq	-296(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -544(%rbp)
	movq	%rcx, -736(%rbp)                ## 8-byte Spill
	movq	-280(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -416(%rbp)
	movq	-264(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -664(%rbp)
	movq	-72(%rbp), %rcx                 ## 8-byte Reload
	movq	%rcx, -536(%rbp)
	movq	-48(%rbp), %rcx                 ## 8-byte Reload
	movq	%rcx, -408(%rbp)
	movq	-80(%rbp), %rcx                 ## 8-byte Reload
	movq	%rcx, -656(%rbp)
	movq	-240(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -528(%rbp)
	movq	-88(%rbp), %rcx                 ## 8-byte Reload
	movq	%rcx, -400(%rbp)
	movq	-96(%rbp), %rcx                 ## 8-byte Reload
	movq	%rcx, -648(%rbp)
	movq	-248(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -520(%rbp)
	movq	-104(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -392(%rbp)
	movq	-112(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -640(%rbp)
	movq	%r15, -512(%rbp)
	movq	-120(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -384(%rbp)
	movq	-128(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -632(%rbp)
	movq	%r13, -504(%rbp)
	movq	-136(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -376(%rbp)
	movq	-144(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -624(%rbp)
	movq	%r11, -496(%rbp)
	movq	-152(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -368(%rbp)
	movq	-160(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -616(%rbp)
	movq	%r9, -488(%rbp)
	movq	-168(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -360(%rbp)
	movq	-176(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -608(%rbp)
	movq	%rsi, -480(%rbp)
	movq	-184(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -352(%rbp)
	movq	-192(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -600(%rbp)
	movq	-56(%rbp), %rcx                 ## 8-byte Reload
	movq	%rcx, -472(%rbp)
	movq	-200(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -344(%rbp)
	movq	-208(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -592(%rbp)
	movq	-64(%rbp), %rcx                 ## 8-byte Reload
	movq	%rcx, -464(%rbp)
	movq	-216(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -336(%rbp)
	movq	-224(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -584(%rbp)
	movq	-256(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -456(%rbp)
	movq	-232(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -328(%rbp)
	movq	-736(%rbp), %rcx                ## 8-byte Reload
	movq	%rcx, -576(%rbp)
	movq	-272(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -448(%rbp)
	movq	%r8, -320(%rbp)
	movq	$1, -568(%rbp)
	movq	$0, -440(%rbp)
	movq	$0, -312(%rbp)
	testq	%r12, %r12
	je	LBB119_35
## %bb.22:                              ## %land.lhs.true138.peel291
	cmpq	%rax, %r12
	jne	LBB119_35
## %bb.23:                              ## %land.lhs.true138.peel291
	cmpq	%r14, %r12
	jne	LBB119_35
## %bb.24:                              ## %while.body.peel295
	imulq	-744(%rbp), %r14                ## 8-byte Folded Reload
	movq	%r14, -304(%rbp)
	movq	-720(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -688(%rbp)
	movq	-728(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -560(%rbp)
	movq	%r10, -432(%rbp)
	movq	-288(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -680(%rbp)
	movq	-296(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -552(%rbp)
	movq	-280(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -424(%rbp)
	movq	-264(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -672(%rbp)
	movq	-72(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -544(%rbp)
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -416(%rbp)
	movq	-80(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -664(%rbp)
	movq	-240(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -536(%rbp)
	movq	-88(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -408(%rbp)
	movq	-96(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -656(%rbp)
	movq	-248(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -528(%rbp)
	movq	-104(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -400(%rbp)
	movq	-112(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -648(%rbp)
	movq	%r15, -520(%rbp)
	movq	-120(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -392(%rbp)
	movq	-128(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -640(%rbp)
	movq	%r13, -512(%rbp)
	movq	-136(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -384(%rbp)
	movq	-144(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -632(%rbp)
	movq	%r11, -504(%rbp)
	movq	-152(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -376(%rbp)
	movq	-160(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -624(%rbp)
	movq	%r9, -496(%rbp)
	movq	-168(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -368(%rbp)
	movq	-176(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -616(%rbp)
	movq	%rsi, -488(%rbp)
	movq	-184(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -360(%rbp)
	movq	-192(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -608(%rbp)
	movq	-56(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -480(%rbp)
	movq	-200(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -352(%rbp)
	movq	-208(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -600(%rbp)
	movq	-64(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -472(%rbp)
	movq	-216(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -344(%rbp)
	movq	-224(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -592(%rbp)
	movq	-256(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -464(%rbp)
	movq	-232(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -336(%rbp)
	movq	%rcx, -584(%rbp)
	movq	-272(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -456(%rbp)
	movq	%r8, -328(%rbp)
	movq	$1, -576(%rbp)
	vxorps	%xmm1, %xmm1, %xmm1
	vmovups	%xmm1, -448(%rbp)
	movq	$0, -320(%rbp)
	testq	%r14, %r14
	je	LBB119_35
## %bb.25:                              ## %land.lhs.true138.peel299
	cmpq	-728(%rbp), %r14                ## 8-byte Folded Reload
	jne	LBB119_35
## %bb.26:                              ## %land.lhs.true138.peel299
	cmpq	%r10, %r14
	jne	LBB119_35
## %bb.27:                              ## %while.body.peel303
	imulq	-720(%rbp), %r10                ## 8-byte Folded Reload
	movq	%r10, -304(%rbp)
	movq	-288(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -688(%rbp)
	movq	-296(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -560(%rbp)
	movq	-280(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -432(%rbp)
	movq	-264(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -680(%rbp)
	movq	-72(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -552(%rbp)
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -424(%rbp)
	movq	-80(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -672(%rbp)
	movq	-240(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -544(%rbp)
	movq	-88(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -416(%rbp)
	movq	-96(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -664(%rbp)
	movq	-248(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -536(%rbp)
	movq	-104(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -408(%rbp)
	movq	-112(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -656(%rbp)
	movq	%r15, -528(%rbp)
	movq	-120(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -400(%rbp)
	movq	-128(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -648(%rbp)
	movq	%r13, -520(%rbp)
	movq	-136(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -392(%rbp)
	movq	-144(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -640(%rbp)
	movq	%r11, -512(%rbp)
	movq	-152(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -384(%rbp)
	movq	-160(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -632(%rbp)
	movq	%r9, -504(%rbp)
	movq	-168(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -376(%rbp)
	movq	-176(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -624(%rbp)
	movq	%rsi, -496(%rbp)
	movq	-184(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -368(%rbp)
	movq	-192(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -616(%rbp)
	movq	-56(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -488(%rbp)
	movq	-200(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -360(%rbp)
	movq	-208(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -608(%rbp)
	movq	-64(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -480(%rbp)
	movq	-216(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -352(%rbp)
	movq	-224(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -600(%rbp)
	movq	-256(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -472(%rbp)
	movq	-232(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -344(%rbp)
	movq	%rcx, -592(%rbp)
	movq	-272(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -464(%rbp)
	movq	%r8, -336(%rbp)
	movq	$1, -584(%rbp)
	vmovups	%xmm1, -456(%rbp)
	movq	$0, -328(%rbp)
	movq	$1, -568(%rbp)
	movq	$0, -312(%rbp)
	testq	%r10, %r10
	je	LBB119_35
## %bb.28:                              ## %land.lhs.true138.peel307
	movq	%r10, %rax
	cmpq	-296(%rbp), %r10                ## 8-byte Folded Reload
	jne	LBB119_35
## %bb.29:                              ## %land.lhs.true138.peel307
	cmpq	-280(%rbp), %rax                ## 8-byte Folded Reload
	jne	LBB119_35
## %bb.30:                              ## %while.body.peel311
	movq	-280(%rbp), %rcx                ## 8-byte Reload
	imulq	-288(%rbp), %rcx                ## 8-byte Folded Reload
	movq	%rcx, -304(%rbp)
	movq	-264(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -688(%rbp)
	movq	-72(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -560(%rbp)
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -432(%rbp)
	movq	-80(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -680(%rbp)
	movq	-240(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -552(%rbp)
	movq	-88(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -424(%rbp)
	movq	-96(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -672(%rbp)
	movq	-248(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -544(%rbp)
	movq	-104(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -416(%rbp)
	movq	-112(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -664(%rbp)
	movq	%r15, -536(%rbp)
	movq	-120(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -408(%rbp)
	movq	-128(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -656(%rbp)
	movq	%r13, -528(%rbp)
	movq	-136(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -400(%rbp)
	movq	-144(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -648(%rbp)
	movq	%r11, -520(%rbp)
	movq	-152(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -392(%rbp)
	movq	-160(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -640(%rbp)
	movq	%r9, -512(%rbp)
	movq	-168(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -384(%rbp)
	movq	-176(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -632(%rbp)
	movq	%rsi, -504(%rbp)
	movq	-184(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -376(%rbp)
	movq	-192(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -624(%rbp)
	movq	-56(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -496(%rbp)
	movq	-200(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -368(%rbp)
	movq	-208(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -616(%rbp)
	movq	-64(%rbp), %rax                 ## 8-byte Reload
	movq	%rax, -488(%rbp)
	movq	-216(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -360(%rbp)
	movq	-224(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -608(%rbp)
	movq	-256(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -480(%rbp)
	movq	-232(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -352(%rbp)
	movq	-736(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -600(%rbp)
	movq	-272(%rbp), %rax                ## 8-byte Reload
	movq	%rax, -472(%rbp)
	movq	%r8, -344(%rbp)
	movq	$1, -592(%rbp)
	vmovups	%xmm1, -464(%rbp)
	movq	$0, -336(%rbp)
	movq	$1, -576(%rbp)
	movq	$0, -320(%rbp)
	movq	$0, -440(%rbp)
	movq	%rcx, %rdi
	testq	%rcx, %rcx
	movq	-736(%rbp), %rcx                ## 8-byte Reload
	je	LBB119_35
## %bb.31:
	vxorps	%xmm1, %xmm1, %xmm1
LBB119_32:                              ## %land.lhs.true138
                                        ## =>This Inner Loop Header: Depth=1
	movq	-72(%rbp), %rdx                 ## 8-byte Reload
	movq	-80(%rbp), %rax                 ## 8-byte Reload
	movq	%rcx, %r12
	movq	-88(%rbp), %rcx                 ## 8-byte Reload
	movq	-96(%rbp), %r14                 ## 8-byte Reload
	movq	%r14, -80(%rbp)                 ## 8-byte Spill
	movq	-104(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -88(%rbp)                 ## 8-byte Spill
	movq	-112(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -96(%rbp)                 ## 8-byte Spill
	movq	-120(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -104(%rbp)                ## 8-byte Spill
	movq	-128(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -112(%rbp)                ## 8-byte Spill
	movq	-136(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -120(%rbp)                ## 8-byte Spill
	movq	-144(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -128(%rbp)                ## 8-byte Spill
	movq	-152(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -136(%rbp)                ## 8-byte Spill
	movq	-160(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -144(%rbp)                ## 8-byte Spill
	movq	-168(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -152(%rbp)                ## 8-byte Spill
	movq	-176(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -160(%rbp)                ## 8-byte Spill
	movq	-184(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -168(%rbp)                ## 8-byte Spill
	movq	-192(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -176(%rbp)                ## 8-byte Spill
	movq	-200(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -184(%rbp)                ## 8-byte Spill
	movq	-208(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -192(%rbp)                ## 8-byte Spill
	movq	-216(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -200(%rbp)                ## 8-byte Spill
	movq	-224(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -208(%rbp)                ## 8-byte Spill
	movq	-232(%rbp), %r14                ## 8-byte Reload
	movq	%r14, -216(%rbp)                ## 8-byte Spill
	movq	%r12, -224(%rbp)                ## 8-byte Spill
	movq	%r8, -232(%rbp)                 ## 8-byte Spill
	cmpq	%rdx, %rdi
	movq	-240(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -72(%rbp)                 ## 8-byte Spill
	movq	-248(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -240(%rbp)                ## 8-byte Spill
	movq	%r15, -248(%rbp)                ## 8-byte Spill
	movq	%r13, %r15
	movq	%r11, %r13
	movq	%r9, %r11
	movq	%rsi, %r9
	movq	-56(%rbp), %rsi                 ## 8-byte Reload
	movq	-64(%rbp), %rdx                 ## 8-byte Reload
	movq	%rdx, -56(%rbp)                 ## 8-byte Spill
	movq	-256(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -64(%rbp)                 ## 8-byte Spill
	movq	-272(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -256(%rbp)                ## 8-byte Spill
	jne	LBB119_35
## %bb.33:                              ## %land.lhs.true138
                                        ##   in Loop: Header=BB119_32 Depth=1
	cmpq	-48(%rbp), %rdi                 ## 8-byte Folded Reload
	jne	LBB119_35
## %bb.34:                              ## %while.body
                                        ##   in Loop: Header=BB119_32 Depth=1
	movq	-48(%rbp), %r14                 ## 8-byte Reload
	imulq	-264(%rbp), %r14                ## 8-byte Folded Reload
	movq	%r14, -304(%rbp)
	movq	%rax, -688(%rbp)
	movq	-72(%rbp), %rdx                 ## 8-byte Reload
	movq	%rdx, -560(%rbp)
	movq	%rcx, -432(%rbp)
	movq	-80(%rbp), %rdx                 ## 8-byte Reload
	movq	%rdx, -680(%rbp)
	movq	-240(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -552(%rbp)
	movq	-88(%rbp), %rdx                 ## 8-byte Reload
	movq	%rdx, -424(%rbp)
	movq	-96(%rbp), %rdx                 ## 8-byte Reload
	movq	%rdx, -672(%rbp)
	movq	-248(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -544(%rbp)
	movq	-104(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -416(%rbp)
	movq	-112(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -664(%rbp)
	movq	%r15, -536(%rbp)
	movq	-120(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -408(%rbp)
	movq	-128(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -656(%rbp)
	movq	%r13, -528(%rbp)
	movq	-136(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -400(%rbp)
	movq	-144(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -648(%rbp)
	movq	%r11, -520(%rbp)
	movq	-152(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -392(%rbp)
	movq	-160(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -640(%rbp)
	movq	%r9, -512(%rbp)
	movq	-168(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -384(%rbp)
	movq	-176(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -632(%rbp)
	movq	%rsi, -504(%rbp)
	movq	-184(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -376(%rbp)
	movq	-192(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -624(%rbp)
	movq	-56(%rbp), %rdx                 ## 8-byte Reload
	movq	%rdx, -496(%rbp)
	movq	-200(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -368(%rbp)
	movq	-208(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -616(%rbp)
	movq	-64(%rbp), %rdx                 ## 8-byte Reload
	movq	%rdx, -488(%rbp)
	movq	-216(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -360(%rbp)
	movq	-224(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -608(%rbp)
	movq	-256(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -480(%rbp)
	movq	-232(%rbp), %rdx                ## 8-byte Reload
	movq	%rdx, -352(%rbp)
	vmovups	%ymm0, -600(%rbp)
	vmovups	%ymm1, -472(%rbp)
	vmovups	%ymm1, -344(%rbp)
	movq	$1, -568(%rbp)
	movq	$0, -440(%rbp)
	movq	$0, -312(%rbp)
	movl	$0, %r8d
	movl	$0, %edx
	movq	%rdx, -272(%rbp)                ## 8-byte Spill
	movq	%rax, -264(%rbp)                ## 8-byte Spill
	movq	%rcx, -48(%rbp)                 ## 8-byte Spill
	movl	$1, %ecx
	movq	%r14, %rdi
	testq	%r14, %r14
	jne	LBB119_32
LBB119_35:                              ## %while.end
	leaq	-712(%rbp), %rsi
	movl	$416, %edx                      ## imm = 0x1A0
	movq	%rbx, %rdi
	vzeroupper
	callq	_memcpy
	jmp	LBB119_36
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m ## -- Begin function _ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	.weak_definition	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m: ## @_ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	callq	_memcmp
	testl	%eax, %eax
	sete	%al
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t ## -- Begin function _ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	.weak_definition	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t: ## @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	36(%rdi), %ecx
	testl	%ecx, %ecx
	jle	LBB121_10
## %bb.1:                               ## %for.body.lr.ph
	movq	40(%rdi), %rdx
	movl	(%rdx), %eax
	cmpl	(%rsi), %eax
	jne	LBB121_12
## %bb.2:                               ## %land.lhs.true.i.i.preheader
	movl	4(%rdx), %eax
	cmpl	4(%rsi), %eax
	jne	LBB121_12
## %bb.3:                               ## %land.lhs.true5.i.i.preheader
	movl	8(%rdx), %eax
	cmpl	8(%rsi), %eax
	jne	LBB121_12
## %bb.4:                               ## %_ZNK18halide_dimension_tneERKS_.exit.preheader
	movl	$24, %r8d
	movl	$1, %edi
	xorl	%eax, %eax
	.p2align	4, 0x90
LBB121_5:                               ## %_ZNK18halide_dimension_tneERKS_.exit
                                        ## =>This Inner Loop Header: Depth=1
	movl	-12(%rdx,%r8), %r9d
	cmpl	-12(%rsi,%r8), %r9d
	jne	LBB121_11
## %bb.6:                               ## %for.cond
                                        ##   in Loop: Header=BB121_5 Depth=1
	cmpq	%rcx, %rdi
	setae	%al
	je	LBB121_11
## %bb.7:                               ## %for.body
                                        ##   in Loop: Header=BB121_5 Depth=1
	movl	-8(%rdx,%r8), %r9d
	cmpl	-8(%rsi,%r8), %r9d
	jne	LBB121_11
## %bb.8:                               ## %land.lhs.true.i.i
                                        ##   in Loop: Header=BB121_5 Depth=1
	movl	-4(%rdx,%r8), %r9d
	cmpl	-4(%rsi,%r8), %r9d
	jne	LBB121_11
## %bb.9:                               ## %land.lhs.true5.i.i
                                        ##   in Loop: Header=BB121_5 Depth=1
	movl	(%rdx,%r8), %r9d
	leaq	16(%r8), %r10
	incq	%rdi
	cmpl	(%rsi,%r8), %r9d
	movq	%r10, %r8
	je	LBB121_5
	jmp	LBB121_11
LBB121_12:
	xorl	%eax, %eax
	andb	$1, %al
                                        ## kill: def $al killed $al killed $eax
	popq	%rbp
	retq
LBB121_10:
	movb	$1, %al
LBB121_11:                              ## %cleanup
	andb	$1, %al
                                        ## kill: def $al killed $al killed $eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by ## -- Begin function _ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
	.weak_definition	__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by: ## @_ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movl	%r9d, %r12d
	movq	%r8, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, (%rdi)
	movq	$0, 16(%rdi)
	movq	%rdx, 32(%rdi)
	movl	%ecx, 48(%rdi)
	movl	$0, 52(%rdi)
	movl	%r9d, 56(%rdi)
	movslq	36(%r8), %rax
	movl	%eax, 60(%rdi)
	movl	%r9d, %ecx
	imulq	$56, %rcx, %r13
	incl	%r12d
	imulq	%rax, %r12
	shlq	$4, %r12
	addq	%r13, %r12
	leaq	(%rdx,%r12), %rsi
	xorl	%edi, %edi
	callq	_halide_malloc
	movq	%rax, 24(%rbx)
	testq	%rax, %rax
	je	LBB122_12
## %bb.1:                               ## %if.end
	movq	%rax, 72(%rbx)
	addq	%rax, %r13
	movq	%r13, 64(%rbx)
	addq	%rax, %r12
	movq	%r12, 40(%rbx)
	cmpq	$0, 32(%rbx)
	je	LBB122_4
## %bb.2:                               ## %for.body.preheader
	xorl	%ecx, %ecx
	.p2align	4, 0x90
LBB122_3:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movzbl	(%r15,%rcx), %edx
	movq	40(%rbx), %rsi
	movb	%dl, (%rsi,%rcx)
	incq	%rcx
	cmpq	32(%rbx), %rcx
	jb	LBB122_3
LBB122_4:                               ## %for.cond23.preheader
	cmpl	$0, 60(%rbx)
	jle	LBB122_7
## %bb.5:                               ## %for.body27.lr.ph
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	.p2align	4, 0x90
LBB122_6:                               ## %for.body27
                                        ## =>This Inner Loop Header: Depth=1
	movq	40(%r14), %rsi
	movq	64(%rbx), %rdi
	vmovups	(%rsi,%rcx), %xmm0
	vmovups	%xmm0, (%rdi,%rcx)
	incq	%rdx
	movslq	60(%rbx), %rsi
	addq	$16, %rcx
	cmpq	%rsi, %rdx
	jl	LBB122_6
LBB122_7:                               ## %for.cond36.preheader
	movq	32(%rbp), %rcx
	movzbl	24(%rbp), %edx
	cmpl	$0, 56(%rbx)
	je	LBB122_11
## %bb.8:                               ## %for.body40.preheader
	movq	16(%rbp), %rsi
	xorl	%edi, %edi
	jmp	LBB122_9
	.p2align	4, 0x90
LBB122_10:                              ## %for.cond36.loopexit
                                        ##   in Loop: Header=BB122_9 Depth=1
	movl	56(%rbx), %r8d
	cmpq	%r8, %rdi
	jae	LBB122_11
LBB122_9:                               ## %for.body40
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB122_14 Depth 2
	movq	%rdi, %r8
	movq	(%rsi,%rdi,8), %rdi
	movq	72(%rbx), %r10
	imulq	$56, %r8, %r9
	vmovups	(%rdi), %ymm0
	vmovups	24(%rdi), %ymm1
	vmovups	%ymm1, 24(%r10,%r9)
	vmovups	%ymm0, (%r10,%r9)
	leaq	1(%r8), %rdi
	movl	60(%rbx), %r10d
	movl	%edi, %r11d
	imull	%r10d, %r11d
	shlq	$4, %r11
	addq	64(%rbx), %r11
	movq	72(%rbx), %r14
	movq	%r11, 40(%r14,%r9)
	testl	%r10d, %r10d
	jle	LBB122_10
## %bb.13:                              ## %for.body59.preheader
                                        ##   in Loop: Header=BB122_9 Depth=1
	xorl	%r10d, %r10d
	xorl	%r11d, %r11d
	.p2align	4, 0x90
LBB122_14:                              ## %for.body59
                                        ##   Parent Loop BB122_9 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%rsi,%r8,8), %r14
	movq	40(%r14), %r14
	movq	72(%rbx), %r15
	movq	40(%r15,%r9), %r15
	vmovups	(%r14,%r10), %xmm0
	vmovups	%xmm0, (%r15,%r10)
	incq	%r11
	movslq	60(%rbx), %r14
	addq	$16, %r10
	cmpq	%r14, %r11
	jl	LBB122_14
	jmp	LBB122_10
LBB122_11:                              ## %for.cond.cleanup39
	movb	%dl, 88(%rbx)
	movq	%rcx, 80(%rbx)
LBB122_12:                              ## %cleanup
	testq	%rax, %rax
	setne	%al
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal8djb_hashEPKhm ## -- Begin function _ZN6Halide7Runtime8Internal8djb_hashEPKhm
	.weak_definition	__ZN6Halide7Runtime8Internal8djb_hashEPKhm
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal8djb_hashEPKhm: ## @_ZN6Halide7Runtime8Internal8djb_hashEPKhm
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$5381, %eax                     ## imm = 0x1505
	testq	%rsi, %rsi
	je	LBB123_3
## %bb.1:                               ## %for.body.preheader
	xorl	%ecx, %ecx
	.p2align	4, 0x90
LBB123_2:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movl	%eax, %edx
	shll	$5, %edx
	addl	%eax, %edx
	movzbl	(%rdi,%rcx), %eax
	addl	%edx, %eax
	incq	%rcx
	cmpq	%rcx, %rsi
	jne	LBB123_2
LBB123_3:                               ## %for.cond.cleanup
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11prune_cacheEv ## -- Begin function _ZN6Halide7Runtime8Internal11prune_cacheEv
	.weak_definition	__ZN6Halide7Runtime8Internal11prune_cacheEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11prune_cacheEv: ## @_ZN6Halide7Runtime8Internal11prune_cacheEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	__ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	__ZN6Halide7Runtime8Internal14max_cache_sizeE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	cmpq	%rcx, %rax
	jle	LBB124_24
## %bb.1:                               ## %entry
	movq	__ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPCREL(%rip), %rdx
	movq	(%rdx), %rbx
	testq	%rbx, %rbx
	je	LBB124_24
## %bb.2:                               ## %while.body.preheader
	movq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %rsi
	.p2align	4, 0x90
LBB124_3:                               ## %while.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB124_6 Depth 2
                                        ##     Child Loop BB124_18 Depth 2
                                        ##       Child Loop BB124_26 Depth 3
                                        ##       Child Loop BB124_30 Depth 3
	movq	8(%rbx), %r13
	cmpl	$0, 52(%rbx)
	jne	LBB124_22
## %bb.4:                               ## %if.then
                                        ##   in Loop: Header=BB124_3 Depth=1
	movzbl	48(%rbx), %ecx
	movq	(%rsi,%rcx,8), %rdx
	cmpq	%rbx, %rdx
	je	LBB124_5
	.p2align	4, 0x90
LBB124_6:                               ## %while.cond9
                                        ##   Parent Loop BB124_3 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	testq	%rdx, %rdx
	je	LBB124_35
## %bb.7:                               ## %land.rhs11
                                        ##   in Loop: Header=BB124_6 Depth=2
	movq	%rdx, %rcx
	movq	(%rdx), %rdx
	cmpq	%rbx, %rdx
	jne	LBB124_6
	jmp	LBB124_8
LBB124_5:                               ##   in Loop: Header=BB124_3 Depth=1
	leaq	(%rsi,%rcx,8), %rcx
LBB124_8:                               ## %if.end21
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	(%rbx), %rdx
	movq	%rdx, (%rcx)
	movq	__ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPCREL(%rip), %rcx
	cmpq	%rbx, (%rcx)
	je	LBB124_9
## %bb.10:                              ## %if.end24
                                        ##   in Loop: Header=BB124_3 Depth=1
	testq	%r13, %r13
	je	LBB124_12
LBB124_11:                              ## %if.then26
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	16(%rbx), %rcx
	movq	%rcx, 16(%r13)
LBB124_12:                              ## %if.end28
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	16(%rbx), %rcx
	movq	__ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPCREL(%rip), %rdx
	cmpq	%rbx, (%rdx)
	je	LBB124_13
## %bb.14:                              ## %if.end32
                                        ##   in Loop: Header=BB124_3 Depth=1
	testq	%rcx, %rcx
	je	LBB124_16
LBB124_15:                              ## %if.then35
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	%r13, 16(%rbx)
LBB124_16:                              ## %if.end37
                                        ##   in Loop: Header=BB124_3 Depth=1
	movl	56(%rbx), %ecx
	testq	%rcx, %rcx
	je	LBB124_21
## %bb.17:                              ## %for.body.lr.ph
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	72(%rbx), %rdx
	xorl	%esi, %esi
	jmp	LBB124_18
	.p2align	4, 0x90
LBB124_33:                              ## %_ZNK15halide_buffer_t12begin_offsetEv.exit.loopexit.i
                                        ##   in Loop: Header=BB124_18 Depth=2
	notq	%r10
	addq	%r10, %r11
LBB124_34:                              ## %_ZNK15halide_buffer_t13size_in_bytesEv.exit
                                        ##   in Loop: Header=BB124_18 Depth=2
	movzbl	33(%rdx,%rdi), %edi
	addq	$7, %rdi
	shrq	$3, %rdi
	imulq	%r11, %rdi
	addq	%rdi, %rax
	incq	%rsi
	cmpq	%rcx, %rsi
	je	LBB124_20
LBB124_18:                              ## %for.body
                                        ##   Parent Loop BB124_3 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB124_26 Depth 3
                                        ##       Child Loop BB124_30 Depth 3
	imulq	$56, %rsi, %rdi
	movl	36(%rdx,%rdi), %r8d
	testl	%r8d, %r8d
	jle	LBB124_19
## %bb.25:                              ## %for.body.lr.ph.i.i
                                        ##   in Loop: Header=BB124_18 Depth=2
	movq	40(%rdx,%rdi), %r9
	shlq	$4, %r8
	xorl	%r11d, %r11d
	xorl	%r10d, %r10d
	jmp	LBB124_26
	.p2align	4, 0x90
LBB124_28:                              ## %if.end.i.i
                                        ##   in Loop: Header=BB124_26 Depth=3
	addq	$16, %r11
	cmpq	%r11, %r8
	je	LBB124_29
LBB124_26:                              ## %for.body.i.i
                                        ##   Parent Loop BB124_3 Depth=1
                                        ##     Parent Loop BB124_18 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	8(%r9,%r11), %r15d
	testl	%r15d, %r15d
	jle	LBB124_28
## %bb.27:                              ## %if.then.i.i
                                        ##   in Loop: Header=BB124_26 Depth=3
	movslq	4(%r9,%r11), %r12
	decq	%r12
	imulq	%r15, %r12
	addq	%r12, %r10
	jmp	LBB124_28
	.p2align	4, 0x90
LBB124_29:                              ## %for.body.i12.i.preheader
                                        ##   in Loop: Header=BB124_18 Depth=2
	xorl	%r15d, %r15d
	xorl	%r11d, %r11d
	jmp	LBB124_30
	.p2align	4, 0x90
LBB124_32:                              ## %if.end.i23.i
                                        ##   in Loop: Header=BB124_30 Depth=3
	addq	$16, %r15
	cmpq	%r15, %r8
	je	LBB124_33
LBB124_30:                              ## %for.body.i12.i
                                        ##   Parent Loop BB124_3 Depth=1
                                        ##     Parent Loop BB124_18 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movslq	8(%r9,%r15), %r12
	testq	%r12, %r12
	jns	LBB124_32
## %bb.31:                              ## %if.then.i19.i
                                        ##   in Loop: Header=BB124_30 Depth=3
	movslq	4(%r9,%r15), %r14
	decq	%r14
	imulq	%r12, %r14
	addq	%r14, %r11
	jmp	LBB124_32
	.p2align	4, 0x90
LBB124_19:                              ##   in Loop: Header=BB124_18 Depth=2
	movq	$-1, %r11
	jmp	LBB124_34
	.p2align	4, 0x90
LBB124_20:                              ## %for.cond.for.cond.cleanup_crit_edge
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	__ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPCREL(%rip), %rcx
	movq	%rax, (%rcx)
LBB124_21:                              ## %for.cond.cleanup
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	xorl	%edi, %edi
	movq	%rbx, %rsi
	callq	_halide_free
	movq	__ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	movq	__ZN6Halide7Runtime8Internal14max_cache_sizeE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rcx
	movq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %rsi
LBB124_22:                              ## %if.end41
                                        ##   in Loop: Header=BB124_3 Depth=1
	cmpq	%rcx, %rax
	jle	LBB124_24
## %bb.23:                              ## %if.end41
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	%r13, %rbx
	testq	%r13, %r13
	jne	LBB124_3
	jmp	LBB124_24
LBB124_9:                               ## %if.then23
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	__ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPCREL(%rip), %rcx
	movq	%r13, (%rcx)
	testq	%r13, %r13
	jne	LBB124_11
	jmp	LBB124_12
LBB124_13:                              ## %if.then30
                                        ##   in Loop: Header=BB124_3 Depth=1
	movq	__ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPCREL(%rip), %rdx
	movq	%rcx, (%rdx)
	testq	%rcx, %rcx
	jne	LBB124_15
	jmp	LBB124_16
LBB124_24:                              ## %while.end42
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB124_35:                              ## %if.then18
	leaq	L_.str.2.42(%rip), %rsi
	xorl	%edi, %edi
	callq	_halide_print
	callq	_abort
	ud2
                                        ## -- End function
	.globl	_halide_memoization_cache_set_size ## -- Begin function halide_memoization_cache_set_size
	.weak_definition	_halide_memoization_cache_set_size
	.p2align	4, 0x90
_halide_memoization_cache_set_size:     ## @halide_memoization_cache_set_size
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	testq	%rdi, %rdi
	movl	$1048576, %r14d                 ## imm = 0x100000
	cmovneq	%rdi, %r14
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rbx
	movq	%rbx, %rdi
	callq	_halide_mutex_lock
	movq	__ZN6Halide7Runtime8Internal14max_cache_sizeE@GOTPCREL(%rip), %rax
	movq	%r14, (%rax)
	callq	__ZN6Halide7Runtime8Internal11prune_cacheEv
	movq	%rbx, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_mutex_unlock            ## TAILCALL
                                        ## -- End function
	.globl	_halide_memoization_cache_lookup ## -- Begin function halide_memoization_cache_lookup
	.weak_definition	_halide_memoization_cache_lookup
	.p2align	4, 0x90
_halide_memoization_cache_lookup:       ## @halide_memoization_cache_lookup
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
	movq	%r9, -64(%rbp)                  ## 8-byte Spill
	movl	%r8d, %r13d
	movq	%rcx, %r14
	movq	%rsi, %rax
	movq	%rdi, -56(%rbp)                 ## 8-byte Spill
	movslq	%edx, %rsi
	movq	%rax, -80(%rbp)                 ## 8-byte Spill
	movq	%rax, %rdi
	movq	%rsi, -48(%rbp)                 ## 8-byte Spill
	callq	__ZN6Halide7Runtime8Internal8djb_hashEPKhm
	movl	%eax, %r15d
	movzbl	%r15b, %ebx
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	movq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %rax
	movq	(%rax,%rbx,8), %r12
	testq	%r12, %r12
	je	LBB126_13
## %bb.1:                               ## %while.body.lr.ph
	testl	%r13d, %r13d
	jle	LBB126_31
## %bb.2:                               ## %while.body.us.preheader
	movslq	%r13d, %rbx
	jmp	LBB126_3
	.p2align	4, 0x90
LBB126_30:                              ## %if.end73
                                        ##   in Loop: Header=BB126_31 Depth=1
	movq	(%r12), %r12
	testq	%r12, %r12
	je	LBB126_13
LBB126_31:                              ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	cmpl	%r15d, 48(%r12)
	jne	LBB126_30
## %bb.32:                              ## %land.lhs.true
                                        ##   in Loop: Header=BB126_31 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	cmpq	%rax, 32(%r12)
	jne	LBB126_30
## %bb.33:                              ## %land.lhs.true7
                                        ##   in Loop: Header=BB126_31 Depth=1
	movq	40(%r12), %rdi
	movq	-80(%rbp), %rsi                 ## 8-byte Reload
	movq	-48(%rbp), %rdx                 ## 8-byte Reload
	callq	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	testb	%al, %al
	je	LBB126_30
## %bb.34:                              ## %land.lhs.true10
                                        ##   in Loop: Header=BB126_31 Depth=1
	movq	64(%r12), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	testb	%al, %al
	je	LBB126_30
## %bb.35:                              ## %land.lhs.true13
                                        ##   in Loop: Header=BB126_31 Depth=1
	cmpl	%r13d, 56(%r12)
	jne	LBB126_30
LBB126_36:                              ## %if.then23
	movq	__ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPCREL(%rip), %rbx
	cmpq	(%rbx), %r12
	movq	-64(%rbp), %r15                 ## 8-byte Reload
	je	LBB126_49
## %bb.37:                              ## %do.body
	cmpq	$0, 8(%r12)
	jne	LBB126_39
## %bb.38:                              ## %if.then27
	leaq	L_.str.3.43(%rip), %rsi
	movq	-56(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_print
	callq	_abort
LBB126_39:                              ## %do.end
	movq	16(%r12), %rax
	testq	%rax, %rax
	je	LBB126_41
## %bb.40:                              ## %if.then29
	movq	8(%r12), %rcx
	movq	%rcx, 8(%rax)
	movq	8(%r12), %rax
	jmp	LBB126_44
LBB126_11:                              ## %for.cond.cleanup.us
                                        ##   in Loop: Header=BB126_3 Depth=1
	testb	%al, %al
	movl	-68(%rbp), %r13d                ## 4-byte Reload
	movq	-88(%rbp), %r14                 ## 8-byte Reload
	jne	LBB126_36
	.p2align	4, 0x90
LBB126_12:                              ## %if.end73.us
                                        ##   in Loop: Header=BB126_3 Depth=1
	movq	(%r12), %r12
	testq	%r12, %r12
	je	LBB126_13
LBB126_3:                               ## %while.body.us
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB126_9 Depth 2
	cmpl	%r15d, 48(%r12)
	jne	LBB126_12
## %bb.4:                               ## %land.lhs.true.us
                                        ##   in Loop: Header=BB126_3 Depth=1
	movq	-48(%rbp), %rax                 ## 8-byte Reload
	cmpq	%rax, 32(%r12)
	jne	LBB126_12
## %bb.5:                               ## %land.lhs.true7.us
                                        ##   in Loop: Header=BB126_3 Depth=1
	movq	40(%r12), %rdi
	movq	-80(%rbp), %rsi                 ## 8-byte Reload
	movq	-48(%rbp), %rdx                 ## 8-byte Reload
	callq	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	testb	%al, %al
	je	LBB126_12
## %bb.6:                               ## %land.lhs.true10.us
                                        ##   in Loop: Header=BB126_3 Depth=1
	movq	64(%r12), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	testb	%al, %al
	je	LBB126_12
## %bb.7:                               ## %land.lhs.true13.us
                                        ##   in Loop: Header=BB126_3 Depth=1
	cmpl	%r13d, 56(%r12)
	jne	LBB126_12
## %bb.8:                               ## %for.cond.preheader.us
                                        ##   in Loop: Header=BB126_3 Depth=1
	movq	%r14, -88(%rbp)                 ## 8-byte Spill
	movl	%r13d, -68(%rbp)                ## 4-byte Spill
	movl	$1, %r13d
	movl	$5, %r14d
	.p2align	4, 0x90
LBB126_9:                               ## %for.body.us
                                        ##   Parent Loop BB126_3 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	-64(%rbp), %rax                 ## 8-byte Reload
	movq	-8(%rax,%r13,8), %rdi
	movq	72(%r12), %rax
	movq	(%rax,%r14,8), %rsi
	callq	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	testb	%al, %al
	je	LBB126_11
## %bb.10:                              ## %for.body.us
                                        ##   in Loop: Header=BB126_9 Depth=2
	leaq	1(%r13), %rcx
	addq	$7, %r14
	cmpq	%rbx, %r13
	movq	%rcx, %r13
	jl	LBB126_9
	jmp	LBB126_11
LBB126_13:                              ## %for.cond75.preheader
	movl	$1, %ebx
	testl	%r13d, %r13d
	jle	LBB126_55
## %bb.14:                              ## %for.body78.preheader
	movl	%r13d, %eax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
	movl	$1, %r12d
	movl	$4294967295, %r13d              ## imm = 0xFFFFFFFF
	xorl	%r14d, %r14d
	.p2align	4, 0x90
LBB126_15:                              ## %for.body78
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB126_17 Depth 2
                                        ##     Child Loop BB126_21 Depth 2
	movq	-64(%rbp), %rax                 ## 8-byte Reload
	movq	(%rax,%r14,8), %rbx
	movl	36(%rbx), %ecx
	movl	$1, %eax
	testl	%ecx, %ecx
	jle	LBB126_25
## %bb.16:                              ## %for.body.lr.ph.i.i
                                        ##   in Loop: Header=BB126_15 Depth=1
	movq	40(%rbx), %rdx
	shlq	$4, %rcx
	xorl	%esi, %esi
	xorl	%eax, %eax
	jmp	LBB126_17
	.p2align	4, 0x90
LBB126_19:                              ## %if.end.i.i
                                        ##   in Loop: Header=BB126_17 Depth=2
	addq	$16, %rsi
	cmpq	%rsi, %rcx
	je	LBB126_20
LBB126_17:                              ## %for.body.i.i
                                        ##   Parent Loop BB126_15 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	8(%rdx,%rsi), %edi
	testl	%edi, %edi
	jle	LBB126_19
## %bb.18:                              ## %if.then.i.i
                                        ##   in Loop: Header=BB126_17 Depth=2
	movslq	4(%rdx,%rsi), %r8
	decq	%r8
	imulq	%rdi, %r8
	addq	%r8, %rax
	jmp	LBB126_19
	.p2align	4, 0x90
LBB126_20:                              ## %for.body.i12.i.preheader
                                        ##   in Loop: Header=BB126_15 Depth=1
	xorl	%edi, %edi
	xorl	%esi, %esi
	jmp	LBB126_21
	.p2align	4, 0x90
LBB126_23:                              ## %if.end.i23.i
                                        ##   in Loop: Header=BB126_21 Depth=2
	addq	$16, %rdi
	cmpq	%rdi, %rcx
	je	LBB126_24
LBB126_21:                              ## %for.body.i12.i
                                        ##   Parent Loop BB126_15 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movslq	8(%rdx,%rdi), %r8
	testq	%r8, %r8
	jns	LBB126_23
## %bb.22:                              ## %if.then.i19.i
                                        ##   in Loop: Header=BB126_21 Depth=2
	movslq	4(%rdx,%rdi), %r9
	decq	%r9
	imulq	%r8, %r9
	addq	%r9, %rsi
	jmp	LBB126_23
	.p2align	4, 0x90
LBB126_24:                              ## %_ZNK15halide_buffer_t12begin_offsetEv.exit.loopexit.i
                                        ##   in Loop: Header=BB126_15 Depth=1
	subq	%rsi, %rax
	incq	%rax
LBB126_25:                              ## %_ZNK15halide_buffer_t13size_in_bytesEv.exit
                                        ##   in Loop: Header=BB126_15 Depth=1
	movzbl	33(%rbx), %esi
	addq	$7, %rsi
	shrq	$3, %rsi
	imulq	%rax, %rsi
	addq	$64, %rsi
	movq	-56(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_malloc
	movq	%rax, 16(%rbx)
	testq	%rax, %rax
	je	LBB126_26
## %bb.53:                              ## %for.inc114
                                        ##   in Loop: Header=BB126_15 Depth=1
	addq	$64, %rax
	movq	%rax, 16(%rbx)
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	movl	%r15d, 8(%rax)
	movq	$0, (%rax)
	incq	%r14
	incq	%r12
	incq	%r13
	cmpq	-48(%rbp), %r14                 ## 8-byte Folded Reload
	jne	LBB126_15
## %bb.54:
	movl	$1, %ebx
	jmp	LBB126_55
LBB126_26:                              ## %for.cond89.preheader
	movl	$-1, %ebx
	testq	%r14, %r14
	je	LBB126_55
## %bb.27:                              ## %for.body92.preheader
	movq	-64(%rbp), %r14                 ## 8-byte Reload
	movq	-56(%rbp), %r15                 ## 8-byte Reload
	.p2align	4, 0x90
LBB126_28:                              ## %for.body92
                                        ## =>This Inner Loop Header: Depth=1
	movl	%r13d, %ebx
	movq	(%r14,%rbx,8), %rax
	movq	16(%rax), %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	movq	%r15, %rdi
	movq	%rax, %rsi
	callq	_halide_free
	movq	(%r14,%rbx,8), %rax
	movq	$0, 16(%rax)
	decq	%r12
	decq	%r13
	cmpq	$1, %r12
	jg	LBB126_28
## %bb.29:
	movl	$-1, %ebx
LBB126_55:                              ## %cleanup119
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	vzeroupper
	callq	_halide_mutex_unlock
	movl	%ebx, %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB126_41:                              ## %do.body33
	movq	__ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPCREL(%rip), %r14
	cmpq	%r12, (%r14)
	je	LBB126_43
## %bb.42:                              ## %if.then35
	leaq	L_.str.4.44(%rip), %rsi
	movq	-56(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_print
	callq	_abort
LBB126_43:                              ## %do.end38
	movq	8(%r12), %rax
	movq	%rax, (%r14)
LBB126_44:                              ## %do.body41
	testq	%rax, %rax
	jne	LBB126_46
## %bb.45:                              ## %if.then44
	leaq	L_.str.5.45(%rip), %rsi
	movq	-56(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_print
	callq	_abort
	movq	8(%r12), %rax
LBB126_46:                              ## %do.end47
	movq	16(%r12), %rcx
	movq	%rcx, 16(%rax)
	movq	$0, 8(%r12)
	movq	(%rbx), %rax
	movq	%rax, 16(%r12)
	testq	%rax, %rax
	je	LBB126_48
## %bb.47:                              ## %if.then54
	movq	%r12, 8(%rax)
LBB126_48:                              ## %if.end56
	movq	%r12, (%rbx)
LBB126_49:                              ## %if.end57
	testl	%r13d, %r13d
	jle	LBB126_52
## %bb.50:                              ## %for.body62.lr.ph
	movl	%r13d, %ecx
	leaq	(,%rcx,8), %rax
	subq	%rcx, %rax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
LBB126_51:                              ## %for.body62
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r15), %rdx
	movq	72(%r12), %rsi
	vmovups	(%rsi,%rcx,8), %ymm0
	vmovups	24(%rsi,%rcx,8), %ymm1
	vmovups	%ymm1, 24(%rdx)
	vmovups	%ymm0, (%rdx)
	addq	$7, %rcx
	addq	$8, %r15
	cmpq	%rcx, %rax
	jne	LBB126_51
LBB126_52:                              ## %cleanup119.loopexit211
	addl	%r13d, 52(%r12)
	xorl	%ebx, %ebx
	jmp	LBB126_55
                                        ## -- End function
	.globl	_halide_memoization_cache_store ## -- Begin function halide_memoization_cache_store
	.weak_definition	_halide_memoization_cache_store
	.p2align	4, 0x90
_halide_memoization_cache_store:        ## @halide_memoization_cache_store
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$72, %rsp
	movq	%r9, %r12
	movl	%r8d, -44(%rbp)                 ## 4-byte Spill
	movq	%rcx, -64(%rbp)                 ## 8-byte Spill
	movl	%edx, %r14d
	movq	%rsi, -72(%rbp)                 ## 8-byte Spill
	movq	%rdi, -80(%rbp)                 ## 8-byte Spill
	movq	(%r9), %rax
	movq	16(%rax), %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	movl	8(%rax), %r15d
	movzbl	%r15b, %ebx
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	movq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %rax
	movq	%rbx, -104(%rbp)                ## 8-byte Spill
	movq	(%rax,%rbx,8), %r13
	movslq	%r14d, %rax
	movq	%rax, -56(%rbp)                 ## 8-byte Spill
	movq	%r15, %r14
	testq	%r13, %r13
	je	LBB127_13
## %bb.1:                               ## %while.body.lr.ph
	movl	-44(%rbp), %eax                 ## 4-byte Reload
	testl	%eax, %eax
	jle	LBB127_15
## %bb.2:                               ## %while.body.us.preheader
	cltq
	movq	%rax, -112(%rbp)                ## 8-byte Spill
	jmp	LBB127_3
	.p2align	4, 0x90
LBB127_20:                              ## %if.end59
                                        ##   in Loop: Header=BB127_15 Depth=1
	movq	(%r13), %r13
	testq	%r13, %r13
	je	LBB127_13
LBB127_15:                              ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	cmpl	%r14d, 48(%r13)
	jne	LBB127_20
## %bb.16:                              ## %land.lhs.true
                                        ##   in Loop: Header=BB127_15 Depth=1
	movq	-56(%rbp), %rax                 ## 8-byte Reload
	cmpq	%rax, 32(%r13)
	jne	LBB127_20
## %bb.17:                              ## %land.lhs.true12
                                        ##   in Loop: Header=BB127_15 Depth=1
	movq	40(%r13), %rdi
	movq	-72(%rbp), %rsi                 ## 8-byte Reload
	movq	-56(%rbp), %rdx                 ## 8-byte Reload
	callq	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	testb	%al, %al
	je	LBB127_20
## %bb.18:                              ## %land.lhs.true15
                                        ##   in Loop: Header=BB127_15 Depth=1
	movq	64(%r13), %rsi
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	callq	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	testb	%al, %al
	je	LBB127_20
## %bb.19:                              ## %land.lhs.true18
                                        ##   in Loop: Header=BB127_15 Depth=1
	movl	-44(%rbp), %eax                 ## 4-byte Reload
	cmpl	%eax, 56(%r13)
	jne	LBB127_20
	jmp	LBB127_52
LBB127_11:                              ## %for.cond.cleanup.us
                                        ##   in Loop: Header=BB127_3 Depth=1
	testb	%al, %al
	movq	-88(%rbp), %r12                 ## 8-byte Reload
	movq	-96(%rbp), %r14                 ## 8-byte Reload
	jne	LBB127_21
	.p2align	4, 0x90
LBB127_12:                              ## %if.end59.us
                                        ##   in Loop: Header=BB127_3 Depth=1
	movq	(%r13), %r13
	testq	%r13, %r13
	je	LBB127_13
LBB127_3:                               ## %while.body.us
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB127_9 Depth 2
	cmpl	%r14d, 48(%r13)
	jne	LBB127_12
## %bb.4:                               ## %land.lhs.true.us
                                        ##   in Loop: Header=BB127_3 Depth=1
	movq	-56(%rbp), %rax                 ## 8-byte Reload
	cmpq	%rax, 32(%r13)
	jne	LBB127_12
## %bb.5:                               ## %land.lhs.true12.us
                                        ##   in Loop: Header=BB127_3 Depth=1
	movq	40(%r13), %rdi
	movq	-72(%rbp), %rsi                 ## 8-byte Reload
	movq	-56(%rbp), %rdx                 ## 8-byte Reload
	callq	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	testb	%al, %al
	je	LBB127_12
## %bb.6:                               ## %land.lhs.true15.us
                                        ##   in Loop: Header=BB127_3 Depth=1
	movq	64(%r13), %rsi
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	callq	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	testb	%al, %al
	je	LBB127_12
## %bb.7:                               ## %land.lhs.true18.us
                                        ##   in Loop: Header=BB127_3 Depth=1
	movl	-44(%rbp), %eax                 ## 4-byte Reload
	cmpl	%eax, 56(%r13)
	jne	LBB127_12
## %bb.8:                               ## %for.cond.preheader.us
                                        ##   in Loop: Header=BB127_3 Depth=1
	movq	%r14, -96(%rbp)                 ## 8-byte Spill
	movq	%r12, -88(%rbp)                 ## 8-byte Spill
	movq	72(%r13), %rcx
	movb	$1, %r15b
	movl	$1, %ebx
	xorl	%r12d, %r12d
	.p2align	4, 0x90
LBB127_9:                               ## %for.body.us
                                        ##   Parent Loop BB127_3 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	-88(%rbp), %rax                 ## 8-byte Reload
	movq	-8(%rax,%rbx,8), %r14
	movq	40(%rcx,%r12), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	movq	72(%r13), %rcx
	movq	16(%rcx,%r12), %rdx
	cmpq	16(%r14), %rdx
	movzbl	%r15b, %r15d
	movl	$0, %edx
	cmovel	%edx, %r15d
	testb	%al, %al
	je	LBB127_11
## %bb.10:                              ## %for.body.us
                                        ##   in Loop: Header=BB127_9 Depth=2
	leaq	1(%rbx), %rdx
	addq	$56, %r12
	cmpq	-112(%rbp), %rbx                ## 8-byte Folded Reload
	movq	%rdx, %rbx
	jl	LBB127_9
	jmp	LBB127_11
LBB127_13:                              ## %for.cond61.preheader
	movl	-44(%rbp), %eax                 ## 4-byte Reload
	testl	%eax, %eax
	jle	LBB127_14
## %bb.25:                              ## %for.body64.preheader
	movl	%eax, %eax
	xorl	%ecx, %ecx
	xorl	%r13d, %r13d
	jmp	LBB127_26
	.p2align	4, 0x90
LBB127_36:                              ## %_ZNK15halide_buffer_t12begin_offsetEv.exit.loopexit.i
                                        ##   in Loop: Header=BB127_26 Depth=1
	subq	%r9, %rsi
	incq	%rsi
LBB127_37:                              ## %_ZNK15halide_buffer_t13size_in_bytesEv.exit
                                        ##   in Loop: Header=BB127_26 Depth=1
	movzbl	33(%rdx), %edx
	addq	$7, %rdx
	shrq	$3, %rdx
	imulq	%rsi, %rdx
	addq	%rdx, %r13
	incq	%rcx
	cmpq	%rax, %rcx
	je	LBB127_38
LBB127_26:                              ## %for.body64
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB127_29 Depth 2
                                        ##     Child Loop BB127_33 Depth 2
	movq	(%r12,%rcx,8), %rdx
	movl	36(%rdx), %edi
	testl	%edi, %edi
	jle	LBB127_27
## %bb.28:                              ## %for.body.lr.ph.i.i
                                        ##   in Loop: Header=BB127_26 Depth=1
	movq	40(%rdx), %r8
	shlq	$4, %rdi
	xorl	%r9d, %r9d
	xorl	%esi, %esi
	jmp	LBB127_29
	.p2align	4, 0x90
LBB127_31:                              ## %if.end.i.i
                                        ##   in Loop: Header=BB127_29 Depth=2
	addq	$16, %r9
	cmpq	%r9, %rdi
	je	LBB127_32
LBB127_29:                              ## %for.body.i.i
                                        ##   Parent Loop BB127_26 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	8(%r8,%r9), %r10d
	testl	%r10d, %r10d
	jle	LBB127_31
## %bb.30:                              ## %if.then.i.i
                                        ##   in Loop: Header=BB127_29 Depth=2
	movslq	4(%r8,%r9), %r11
	decq	%r11
	imulq	%r10, %r11
	addq	%r11, %rsi
	jmp	LBB127_31
	.p2align	4, 0x90
LBB127_32:                              ## %for.body.i12.i.preheader
                                        ##   in Loop: Header=BB127_26 Depth=1
	xorl	%r10d, %r10d
	xorl	%r9d, %r9d
	jmp	LBB127_33
	.p2align	4, 0x90
LBB127_35:                              ## %if.end.i23.i
                                        ##   in Loop: Header=BB127_33 Depth=2
	addq	$16, %r10
	cmpq	%r10, %rdi
	je	LBB127_36
LBB127_33:                              ## %for.body.i12.i
                                        ##   Parent Loop BB127_26 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movslq	8(%r8,%r10), %r11
	testq	%r11, %r11
	jns	LBB127_35
## %bb.34:                              ## %if.then.i19.i
                                        ##   in Loop: Header=BB127_33 Depth=2
	movslq	4(%r8,%r10), %rbx
	decq	%rbx
	imulq	%r11, %rbx
	addq	%rbx, %r9
	jmp	LBB127_35
	.p2align	4, 0x90
LBB127_27:                              ##   in Loop: Header=BB127_26 Depth=1
	movl	$1, %esi
	jmp	LBB127_37
LBB127_14:
	xorl	%r13d, %r13d
LBB127_38:                              ## %for.cond.cleanup63
	movq	%r14, %rbx
	movq	__ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPCREL(%rip), %r15
	addq	%r13, (%r15)
	callq	__ZN6Halide7Runtime8Internal11prune_cacheEv
	movl	$96, %esi
	xorl	%edi, %edi
	callq	_halide_malloc
	movq	%rax, %r14
	testq	%rax, %rax
	je	LBB127_40
## %bb.39:                              ## %if.then76
	movzbl	16(%rbp), %eax
	subq	$8, %rsp
	movzbl	%al, %eax
	movq	%r14, %rdi
	movq	-72(%rbp), %rsi                 ## 8-byte Reload
	movq	-56(%rbp), %rdx                 ## 8-byte Reload
	movl	%ebx, %ecx
	movq	-64(%rbp), %r8                  ## 8-byte Reload
	movl	-44(%rbp), %r9d                 ## 4-byte Reload
	pushq	24(%rbp)
	pushq	%rax
	pushq	%r12
	callq	__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
	addq	$32, %rsp
	testb	%al, %al
	je	LBB127_40
## %bb.45:                              ## %if.end101
	movq	-104(%rbp), %rdx                ## 8-byte Reload
	movq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %rsi
	movq	(%rsi,%rdx,8), %rax
	movq	%rax, (%r14)
	movq	__ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	movq	%rcx, 16(%r14)
	testq	%rcx, %rcx
	je	LBB127_47
## %bb.46:                              ## %if.then106
	movq	%r14, 8(%rcx)
LBB127_47:                              ## %if.end107
	movq	%r14, (%rax)
	movq	__ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPCREL(%rip), %rax
	cmpq	$0, (%rax)
	movl	-44(%rbp), %ecx                 ## 4-byte Reload
	jne	LBB127_49
## %bb.48:                              ## %if.then109
	movq	%r14, (%rax)
LBB127_49:                              ## %if.end110
	movq	%r14, (%rsi,%rdx,8)
	movl	%ecx, 52(%r14)
	testl	%ecx, %ecx
	jle	LBB127_52
## %bb.50:                              ## %for.body117.preheader
	movl	-44(%rbp), %ebx                 ## 4-byte Reload
	xorl	%r15d, %r15d
	.p2align	4, 0x90
LBB127_51:                              ## %for.body117
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r12,%r15,8), %rax
	movq	16(%rax), %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	movq	%r14, (%rax)
	incq	%r15
	cmpq	%r15, %rbx
	jne	LBB127_51
	jmp	LBB127_52
LBB127_40:                              ## %if.then83
	subq	%r13, (%r15)
	movl	-44(%rbp), %eax                 ## 4-byte Reload
	testl	%eax, %eax
	jle	LBB127_43
## %bb.41:                              ## %for.body88.preheader
	movl	%eax, %ebx
	xorl	%r15d, %r15d
	.p2align	4, 0x90
LBB127_42:                              ## %for.body88
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r12,%r15,8), %rax
	movq	16(%rax), %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	movq	$0, (%rax)
	incq	%r15
	cmpq	%r15, %rbx
	jne	LBB127_42
LBB127_43:                              ## %for.cond.cleanup87
	testq	%r14, %r14
	je	LBB127_52
## %bb.44:                              ## %if.then99
	movq	-80(%rbp), %rdi                 ## 8-byte Reload
	movq	%r14, %rsi
	callq	_halide_free
LBB127_52:                              ## %cleanup132
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	xorl	%eax, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB127_21:                              ## %do.body
	testb	$1, %r15b
	jne	LBB127_23
## %bb.22:                              ## %if.then42
	leaq	L_.str.9.46(%rip), %rsi
	movq	-80(%rbp), %rdi                 ## 8-byte Reload
	callq	_halide_print
	callq	_abort
LBB127_23:                              ## %for.body48.preheader
	movl	-44(%rbp), %ebx                 ## 4-byte Reload
	xorl	%r14d, %r14d
	.p2align	4, 0x90
LBB127_24:                              ## %for.body48
                                        ## =>This Inner Loop Header: Depth=1
	movq	(%r12,%r14,8), %rax
	movq	16(%rax), %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	movq	$0, (%rax)
	incq	%r14
	cmpq	%r14, %rbx
	jne	LBB127_24
	jmp	LBB127_52
                                        ## -- End function
	.globl	_halide_memoization_cache_release ## -- Begin function halide_memoization_cache_release
	.weak_definition	_halide_memoization_cache_release
	.p2align	4, 0x90
_halide_memoization_cache_release:      ## @halide_memoization_cache_release
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	movq	%rsi, %rdi
	callq	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	movq	(%rax), %r14
	testq	%r14, %r14
	je	LBB128_4
## %bb.1:                               ## %if.else
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	movl	52(%r14), %eax
	testl	%eax, %eax
	jne	LBB128_3
## %bb.2:                               ## %if.then4
	leaq	L_.str.12.47(%rip), %rsi
	movq	%rbx, %rdi
	callq	_halide_print
	callq	_abort
	movl	52(%r14), %eax
LBB128_3:                               ## %do.end
	decl	%eax
	movl	%eax, 52(%r14)
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_mutex_unlock            ## TAILCALL
LBB128_4:                               ## %if.then
	movq	%rbx, %rdi
	movq	%rax, %rsi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_free                    ## TAILCALL
                                        ## -- End function
	.globl	_halide_memoization_cache_evict ## -- Begin function halide_memoization_cache_evict
	.weak_definition	_halide_memoization_cache_evict
	.p2align	4, 0x90
_halide_memoization_cache_evict:        ## @halide_memoization_cache_evict
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rsi, %rbx
	movq	%rdi, -56(%rbp)                 ## 8-byte Spill
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	movq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %r14
	movl	$2048, %eax                     ## imm = 0x800
	addq	__ZN6Halide7Runtime8Internal13cache_entriesE@GOTPCREL(%rip), %rax
	movq	%rax, -48(%rbp)                 ## 8-byte Spill
	jmp	LBB129_2
	.p2align	4, 0x90
LBB129_1:                               ## %if.end25
                                        ##   in Loop: Header=BB129_2 Depth=1
	addq	$8, %r14
	cmpq	-48(%rbp), %r14                 ## 8-byte Folded Reload
	je	LBB129_15
LBB129_2:                               ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB129_6 Depth 2
	movq	(%r14), %r13
	testq	%r13, %r13
	je	LBB129_1
## %bb.3:                               ## %while.body.preheader
                                        ##   in Loop: Header=BB129_2 Depth=1
	movq	%r14, %r12
	jmp	LBB129_6
	.p2align	4, 0x90
LBB129_4:                               ##   in Loop: Header=BB129_6 Depth=2
	movq	%r15, %r12
	testq	%r13, %r13
	je	LBB129_1
LBB129_6:                               ## %while.body
                                        ##   Parent Loop BB129_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	%r13, %r15
	movq	(%r13), %r13
	cmpb	$0, 88(%r15)
	je	LBB129_4
## %bb.7:                               ## %land.lhs.true
                                        ##   in Loop: Header=BB129_6 Depth=2
	cmpq	%rbx, 80(%r15)
	jne	LBB129_4
## %bb.8:                               ## %if.then7
                                        ##   in Loop: Header=BB129_6 Depth=2
	movq	%r13, (%r12)
	movq	8(%r15), %rax
	movq	16(%r15), %rcx
	testq	%rax, %rax
	je	LBB129_12
## %bb.9:                               ## %if.then9
                                        ##   in Loop: Header=BB129_6 Depth=2
	movq	%rcx, 16(%rax)
	movq	16(%r15), %rcx
	testq	%rcx, %rcx
	jne	LBB129_13
LBB129_10:                              ## %if.end
                                        ##   in Loop: Header=BB129_6 Depth=2
	movq	__ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPCREL(%rip), %rcx
	jmp	LBB129_14
LBB129_12:                              ## %if.else
                                        ##   in Loop: Header=BB129_6 Depth=2
	movq	__ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPCREL(%rip), %rdx
	movq	%rcx, (%rdx)
	testq	%rcx, %rcx
	je	LBB129_10
LBB129_13:                              ##   in Loop: Header=BB129_6 Depth=2
	addq	$8, %rcx
LBB129_14:                              ## %if.end
                                        ##   in Loop: Header=BB129_6 Depth=2
	movq	%rax, (%rcx)
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	movq	-56(%rbp), %rdi                 ## 8-byte Reload
	movq	%r15, %rsi
	callq	_halide_free
	testq	%r13, %r13
	jne	LBB129_6
	jmp	LBB129_1
LBB129_15:                              ## %for.cond.cleanup
	movq	__ZN6Halide7Runtime8Internal16memoization_lockE@GOTPCREL(%rip), %rdi
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_mutex_unlock            ## TAILCALL
                                        ## -- End function
	.globl	_halide_string_to_string        ## -- Begin function halide_string_to_string
	.weak_definition	_halide_string_to_string
	.p2align	4, 0x90
_halide_string_to_string:               ## @halide_string_to_string
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	cmpq	%rsi, %rdi
	jae	LBB130_6
## %bb.1:                               ## %if.end
	movq	%rsi, %rax
	testq	%rdx, %rdx
	leaq	L_.str.50(%rip), %rcx
	cmovneq	%rdx, %rcx
	.p2align	4, 0x90
LBB130_2:                               ## %if.end5
                                        ## =>This Inner Loop Header: Depth=1
	movzbl	(%rcx), %edx
	movb	%dl, (%rdi)
	testb	%dl, %dl
	je	LBB130_6
## %bb.3:                               ## %if.end8
                                        ##   in Loop: Header=BB130_2 Depth=1
	incq	%rdi
	incq	%rcx
	cmpq	%rax, %rdi
	jne	LBB130_2
## %bb.4:                               ## %if.then4
	movb	$0, -1(%rdi)
	popq	%rbp
	retq
LBB130_6:
	movq	%rdi, %rax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_uint64_to_string        ## -- Begin function halide_uint64_to_string
	.weak_definition	_halide_uint64_to_string
	.p2align	4, 0x90
_halide_uint64_to_string:               ## @halide_uint64_to_string
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movb	$0, -1(%rbp)
	leaq	-2(%rbp), %rax
	testq	%rdx, %rdx
	jne	LBB131_2
## %bb.1:                               ## %entry
	testl	%ecx, %ecx
	jle	LBB131_5
LBB131_2:                               ## %for.body.preheader
	movl	$1, %r10d
	movabsq	$-3689348814741910323, %r9      ## imm = 0xCCCCCCCCCCCCCCCD
	.p2align	4, 0x90
LBB131_3:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rdx, %r8
	movl	%r10d, %r11d
	mulxq	%r9, %rdx, %rdx
	shrq	$3, %rdx
	imull	$246, %edx, %r10d
	addl	%r8d, %r10d
	addb	$48, %r10b
	movb	%r10b, (%rax)
	decq	%rax
	leal	1(%r11), %r10d
	cmpl	%ecx, %r11d
	jl	LBB131_3
## %bb.4:                               ## %for.body
                                        ##   in Loop: Header=BB131_3 Depth=1
	cmpq	$9, %r8
	ja	LBB131_3
LBB131_5:                               ## %for.cond.cleanup
	incq	%rax
	movq	%rax, %rdx
	callq	_halide_string_to_string
	addq	$32, %rsp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_int64_to_string         ## -- Begin function halide_int64_to_string
	.weak_definition	_halide_int64_to_string
	.p2align	4, 0x90
_halide_int64_to_string:                ## @halide_int64_to_string
## %bb.0:                               ## %entry
	cmpq	%rsi, %rdi
	jae	LBB132_3
## %bb.1:                               ## %entry
	testq	%rdx, %rdx
	jns	LBB132_3
## %bb.2:                               ## %if.then
	pushq	%rbp
	movq	%rsp, %rbp
	movb	$45, (%rdi)
	incq	%rdi
	negq	%rdx
	popq	%rbp
LBB132_3:                               ## %if.end
	jmp	_halide_uint64_to_string        ## TAILCALL
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ## -- Begin function halide_double_to_string
LCPI133_0:
	.quad	0x8000000000000000              ## double -0
	.quad	0x8000000000000000              ## double -0
LCPI133_6:
	.long	1127219200                      ## 0x43300000
	.long	1160773632                      ## 0x45300000
	.long	0                               ## 0x0
	.long	0                               ## 0x0
LCPI133_7:
	.quad	0x4330000000000000              ## double 4503599627370496
	.quad	0x4530000000000000              ## double 1.9342813113834067E+25
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3, 0x0
LCPI133_1:
	.quad	0x3ff0000000000000              ## double 1
LCPI133_2:
	.quad	0x4024000000000000              ## double 10
LCPI133_3:
	.quad	0x412e848000000000              ## double 1.0E+6
LCPI133_4:
	.quad	0x3fe0000000000000              ## double 0.5
LCPI133_5:
	.quad	0x43e0000000000000              ## double 9.2233720368547758E+18
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_double_to_string
	.weak_definition	_halide_double_to_string
	.p2align	4, 0x90
_halide_double_to_string:               ## @halide_double_to_string
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$536, %rsp                      ## imm = 0x218
	movl	%edx, %r12d
	movq	%rsi, %rbx
	movq	%rdi, %r14
	vmovsd	%xmm0, -48(%rbp)
	movq	$0, -56(%rbp)
	leaq	-56(%rbp), %rdi
	leaq	-48(%rbp), %rsi
	movl	$8, %edx
	callq	_memcpy
	movq	-56(%rbp), %rax
	movb	$52, %cl
	bzhiq	%rcx, %rax, %r15
	movq	%rax, %r13
	shrq	$52, %r13
	andl	$2047, %r13d                    ## imm = 0x7FF
	cmpl	$2047, %r13d                    ## imm = 0x7FF
	jne	LBB133_9
## %bb.1:                               ## %if.then
	testq	%r15, %r15
	je	LBB133_6
## %bb.2:                               ## %if.then4
	testq	%rax, %rax
	js	LBB133_3
## %bb.5:                               ## %if.else
	leaq	L_.str.2.58(%rip), %rdx
	jmp	LBB133_4
LBB133_9:                               ## %if.else15
	testl	%r13d, %r13d
	jne	LBB133_18
## %bb.10:                              ## %if.else15
	testq	%r15, %r15
	jne	LBB133_18
## %bb.11:                              ## %if.then18
	testl	%r12d, %r12d
	je	LBB133_15
## %bb.12:                              ## %if.then20
	testq	%rax, %rax
	js	LBB133_13
## %bb.14:                              ## %if.else24
	leaq	L_.str.6.62(%rip), %rdx
	jmp	LBB133_4
LBB133_18:                              ## %if.end32
	testq	%rax, %rax
	js	LBB133_19
## %bb.20:                              ## %if.end36
	testl	%r12d, %r12d
	je	LBB133_35
LBB133_21:                              ## %while.condthread-pre-split
	vmovsd	-48(%rbp), %xmm0                ## xmm0 = mem[0],zero
	xorl	%r12d, %r12d
	vmovsd	LCPI133_1(%rip), %xmm1          ## xmm1 = mem[0],zero
	vucomisd	%xmm0, %xmm1
	jbe	LBB133_25
## %bb.22:                              ## %while.body.preheader
	xorl	%r12d, %r12d
	vmovsd	LCPI133_2(%rip), %xmm2          ## xmm2 = mem[0],zero
	.p2align	4, 0x90
LBB133_23:                              ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	vmulsd	%xmm2, %xmm0, %xmm0
	decl	%r12d
	vucomisd	%xmm0, %xmm1
	ja	LBB133_23
## %bb.24:                              ## %while.cond.while.cond40thread-pre-split_crit_edge
	vmovsd	%xmm0, -48(%rbp)
LBB133_25:                              ## %while.cond40thread-pre-split
	vucomisd	LCPI133_2(%rip), %xmm0
	jb	LBB133_29
## %bb.26:                              ## %while.body42.preheader
	vmovsd	LCPI133_2(%rip), %xmm1          ## xmm1 = mem[0],zero
	.p2align	4, 0x90
LBB133_27:                              ## %while.body42
                                        ## =>This Inner Loop Header: Depth=1
	vdivsd	%xmm1, %xmm0, %xmm0
	incl	%r12d
	vucomisd	%xmm1, %xmm0
	jae	LBB133_27
## %bb.28:                              ## %while.cond40.while.end43_crit_edge
	vmovsd	%xmm0, -48(%rbp)
LBB133_29:                              ## %while.end43
	vmovsd	LCPI133_3(%rip), %xmm1          ## xmm1 = mem[0],zero
	vfmadd213sd	LCPI133_4(%rip), %xmm0, %xmm1 ## xmm1 = (xmm0 * xmm1) + mem
	vcvttsd2si	%xmm1, %rax
	movq	%rax, %rcx
	vsubsd	LCPI133_5(%rip), %xmm1, %xmm0
	sarq	$63, %rcx
	vcvttsd2si	%xmm0, %rdx
	andq	%rcx, %rdx
	orq	%rax, %rdx
	movabsq	$4835703278458516699, %rax      ## imm = 0x431BDE82D7B634DB
	mulxq	%rax, %rax, %rax
	shrq	$18, %rax
	imulq	$-1000000, %rax, %r15           ## imm = 0xFFF0BDC0
	addq	%rdx, %r15
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%rax, %rdx
	movl	$1, %ecx
	callq	_halide_int64_to_string
	leaq	L_.str.39.197(%rip), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	movl	$6, %ecx
	callq	_halide_int64_to_string
	testl	%r12d, %r12d
	js	LBB133_31
## %bb.30:                              ## %if.then53
	leaq	L_.str.11.67(%rip), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	jmp	LBB133_32
LBB133_6:                               ## %if.else9
	testq	%rax, %rax
	js	LBB133_7
## %bb.8:                               ## %if.else13
	leaq	L_.str.4.60(%rip), %rdx
	jmp	LBB133_4
LBB133_3:                               ## %if.then6
	leaq	L_.str.1.57(%rip), %rdx
	jmp	LBB133_4
LBB133_15:                              ## %if.else26
	testq	%rax, %rax
	js	LBB133_16
## %bb.17:                              ## %if.else30
	leaq	L_.str.8.64(%rip), %rdx
	jmp	LBB133_4
LBB133_19:                              ## %if.then34
	leaq	L_.str.9.65(%rip), %rdx
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	movq	%rax, %r14
	vmovsd	-48(%rbp), %xmm0                ## xmm0 = mem[0],zero
	vxorpd	LCPI133_0(%rip), %xmm0, %xmm0
	vmovlpd	%xmm0, -48(%rbp)
	testl	%r12d, %r12d
	jne	LBB133_21
LBB133_35:                              ## %if.else61
	testl	%r13d, %r13d
	je	LBB133_36
## %bb.37:                              ## %if.end65
	movq	%r14, -64(%rbp)                 ## 8-byte Spill
	movabsq	$4503599627370495, %rax         ## imm = 0xFFFFFFFFFFFFF
	incq	%rax
	orq	%rax, %r15
	movl	%r13d, %r14d
	subl	$1075, %r14d                    ## imm = 0x433
	jae	LBB133_40
## %bb.38:                              ## %if.end100.thread
	movb	$51, %dl
	subb	%r13b, %dl
	xorl	%eax, %eax
	cmpl	$1023, %r13d                    ## imm = 0x3FF
	shrxq	%rdx, %r15, %rcx
	shlxq	%rdx, %rcx, %rdx
	cmovbq	%rax, %rcx
	cmovbq	%rax, %rdx
	subq	%rdx, %r15
	vmovq	%r15, %xmm0
	vmovdqa	LCPI133_6(%rip), %xmm1          ## xmm1 = [1127219200,1160773632,0,0]
	vpunpckldq	%xmm1, %xmm0, %xmm0     ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	vmovapd	LCPI133_7(%rip), %xmm2          ## xmm2 = [4.503599627370496E+15,1.9342813113834067E+25]
	vsubpd	%xmm2, %xmm0, %xmm0
	vpermilpd	$1, %xmm0, %xmm3        ## xmm3 = xmm0[1,0]
	vaddsd	%xmm0, %xmm3, %xmm0
	shlq	$52, %r14
	movabsq	$4696837146684686336, %rdx      ## imm = 0x412E848000000000
	addq	%r14, %rdx
	vmovq	%rdx, %xmm3
	vfmadd213sd	LCPI133_4(%rip), %xmm0, %xmm3 ## xmm3 = (xmm0 * xmm3) + mem
	vcvttsd2si	%xmm3, %rdx
	movq	%rdx, %rsi
	sarq	$63, %rsi
	vsubsd	LCPI133_5(%rip), %xmm3, %xmm0
	vcvttsd2si	%xmm0, %r15
	andq	%rsi, %r15
	orq	%rdx, %r15
	vmovq	%r15, %xmm0
	vpunpckldq	%xmm1, %xmm0, %xmm0     ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	vsubpd	%xmm2, %xmm0, %xmm0
	vpermilpd	$1, %xmm0, %xmm1        ## xmm1 = xmm0[1,0]
	vaddsd	%xmm0, %xmm1, %xmm0
	vucomisd	%xmm0, %xmm3
	setnp	%dl
	sete	%sil
	andb	%dl, %sil
	movl	%r15d, %edx
	andb	%sil, %dl
	movzbl	%dl, %edx
	subq	%rdx, %r15
	xorl	%edx, %edx
	cmpq	$1000000, %r15                  ## imm = 0xF4240
	cmoveq	%rax, %r15
	sete	%dl
	addq	%rcx, %rdx
	leaq	-64(%rbp), %rsi
	leaq	-96(%rbp), %r12
	movq	%r12, %rdi
	movl	$1, %ecx
	callq	_halide_int64_to_string
	jmp	LBB133_39
LBB133_7:                               ## %if.then11
	leaq	L_.str.3.59(%rip), %rdx
	jmp	LBB133_4
LBB133_13:                              ## %if.then22
	leaq	L_.str.5.61(%rip), %rdx
	jmp	LBB133_4
LBB133_31:                              ## %if.else55
	leaq	L_.str.12.68(%rip), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	negl	%r12d
LBB133_32:                              ## %if.end58
	movl	%r12d, %edx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$2, %ecx
	jmp	LBB133_33
LBB133_16:                              ## %if.then28
	leaq	L_.str.7.63(%rip), %rdx
LBB133_4:                               ## %cleanup143
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	jmp	LBB133_34
LBB133_36:                              ## %if.then63
	vxorpd	%xmm0, %xmm0, %xmm0
	movq	%r14, %rdi
	movq	%rbx, %rsi
	xorl	%edx, %edx
	callq	_halide_double_to_string
	jmp	LBB133_34
LBB133_40:                              ## %if.end100
	leaq	-64(%rbp), %rsi
	leaq	-96(%rbp), %r12
	movq	%r12, %rdi
	movq	%r15, %rdx
	movl	$1, %ecx
	callq	_halide_int64_to_string
	xorl	%r15d, %r15d
	testl	%r14d, %r14d
	je	LBB133_39
## %bb.41:                              ## %for.cond107.preheader.preheader
	xorl	%ecx, %ecx
	jmp	LBB133_42
	.p2align	4, 0x90
LBB133_47:                              ## %if.end133
                                        ##   in Loop: Header=BB133_42 Depth=1
	movq	%rdx, %r12
LBB133_48:                              ## %if.end133
                                        ##   in Loop: Header=BB133_42 Depth=1
	incl	%ecx
	cmpl	%r14d, %ecx
	je	LBB133_39
LBB133_42:                              ## %for.cond107.preheader
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB133_44 Depth 2
	movq	%r12, %rdx
	movq	%rax, %r12
	cmpq	%rdx, %rax
	je	LBB133_48
## %bb.43:                              ## %for.body111.preheader
                                        ##   in Loop: Header=BB133_42 Depth=1
	xorl	%edi, %edi
	movq	%rax, %rsi
	.p2align	4, 0x90
LBB133_44:                              ## %for.body111
                                        ##   Parent Loop BB133_42 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movzbl	-1(%rsi), %r8d
	addb	$-48, %r8b
	movzbl	%r8b, %r8d
	addl	%r8d, %r8d
	orl	%edi, %r8d
	leal	-10(%r8), %r9d
	xorl	%edi, %edi
	cmpb	$10, %r8b
	setge	%dil
	movzbl	%r9b, %r9d
	cmovll	%r8d, %r9d
	addb	$48, %r9b
	movb	%r9b, -1(%rsi)
	leaq	-1(%rsi), %r9
	movq	%r9, %rsi
	cmpq	%rdx, %r9
	jne	LBB133_44
## %bb.45:                              ## %for.cond.cleanup110
                                        ##   in Loop: Header=BB133_42 Depth=1
	cmpb	$9, %r8b
	jle	LBB133_47
## %bb.46:                              ## %if.then131
                                        ##   in Loop: Header=BB133_42 Depth=1
	movb	$49, -1(%rdx)
	decq	%rdx
	jmp	LBB133_47
LBB133_39:                              ## %for.cond.cleanup
	movq	-64(%rbp), %rdi                 ## 8-byte Reload
	movq	%rbx, %rsi
	movq	%r12, %rdx
	callq	_halide_string_to_string
	leaq	L_.str.39.197(%rip), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	movl	$6, %ecx
LBB133_33:                              ## %cleanup143
	callq	_halide_int64_to_string
LBB133_34:                              ## %cleanup143
	addq	$536, %rsp                      ## imm = 0x218
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_pointer_to_string       ## -- Begin function halide_pointer_to_string
	.weak_definition	_halide_pointer_to_string
	.p2align	4, 0x90
_halide_pointer_to_string:              ## @halide_pointer_to_string
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%xmm0, -32(%rbp)
	movl	$0, -16(%rbp)
	movl	%edx, %eax
	andl	$15, %eax
	leaq	L_.str.13.71(%rip), %rcx
	movzbl	(%rax,%rcx), %r8d
	leaq	-15(%rbp), %rax
	movb	%r8b, -14(%rbp)
	cmpq	$16, %rdx
	jae	LBB134_2
## %bb.1:
	leaq	-14(%rbp), %rdx
	jmp	LBB134_22
LBB134_2:                               ## %for.inc
	movl	%edx, %r8d
	shrl	$4, %r8d
	andl	$15, %r8d
	movzbl	(%r8,%rcx), %r9d
	leaq	-16(%rbp), %r8
	movb	%r9b, -15(%rbp)
	cmpq	$256, %rdx                      ## imm = 0x100
	jb	LBB134_21
## %bb.3:                               ## %for.inc.1
	movl	%edx, %eax
	shrl	$8, %eax
	andl	$15, %eax
	movzbl	(%rax,%rcx), %r9d
	leaq	-17(%rbp), %rax
	movb	%r9b, -16(%rbp)
	cmpq	$4096, %rdx                     ## imm = 0x1000
	jb	LBB134_4
## %bb.5:                               ## %for.inc.2
	movl	%edx, %r8d
	shrl	$12, %r8d
	andl	$15, %r8d
	movzbl	(%r8,%rcx), %r9d
	leaq	-18(%rbp), %r8
	movb	%r9b, -17(%rbp)
	cmpq	$65536, %rdx                    ## imm = 0x10000
	jb	LBB134_21
## %bb.6:                               ## %for.inc.3
	movl	%edx, %eax
	shrl	$16, %eax
	andl	$15, %eax
	movzbl	(%rax,%rcx), %r9d
	leaq	-19(%rbp), %rax
	movb	%r9b, -18(%rbp)
	cmpq	$1048576, %rdx                  ## imm = 0x100000
	jb	LBB134_4
## %bb.8:                               ## %for.inc.4
	movl	%edx, %r8d
	shrl	$20, %r8d
	andl	$15, %r8d
	movzbl	(%r8,%rcx), %r9d
	leaq	-20(%rbp), %r8
	movb	%r9b, -19(%rbp)
	cmpq	$16777216, %rdx                 ## imm = 0x1000000
	jb	LBB134_21
## %bb.9:                               ## %for.inc.5
	movl	%edx, %eax
	shrl	$24, %eax
	andl	$15, %eax
	movzbl	(%rax,%rcx), %r9d
	leaq	-21(%rbp), %rax
	movb	%r9b, -20(%rbp)
	cmpq	$268435456, %rdx                ## imm = 0x10000000
	jb	LBB134_4
## %bb.11:                              ## %for.inc.6
	movl	%edx, %r8d
	shrl	$28, %r8d
	movzbl	(%r8,%rcx), %r9d
	leaq	-22(%rbp), %r8
	movb	%r9b, -21(%rbp)
	movq	%rdx, %r9
	shrq	$32, %r9
	je	LBB134_21
## %bb.12:                              ## %for.inc.7
	andl	$15, %r9d
	movzbl	(%r9,%rcx), %r9d
	leaq	-23(%rbp), %rax
	movb	%r9b, -22(%rbp)
	movq	%rdx, %r9
	shrq	$36, %r9
	je	LBB134_4
## %bb.14:                              ## %for.inc.8
	andl	$15, %r9d
	movzbl	(%r9,%rcx), %r9d
	leaq	-24(%rbp), %r8
	movb	%r9b, -23(%rbp)
	movq	%rdx, %r9
	shrq	$40, %r9
	je	LBB134_21
## %bb.15:                              ## %for.inc.9
	andl	$15, %r9d
	movzbl	(%r9,%rcx), %r9d
	leaq	-25(%rbp), %rax
	movb	%r9b, -24(%rbp)
	movq	%rdx, %r9
	shrq	$44, %r9
	je	LBB134_4
## %bb.17:                              ## %for.inc.10
	andl	$15, %r9d
	movzbl	(%r9,%rcx), %r9d
	leaq	-26(%rbp), %r8
	movb	%r9b, -25(%rbp)
	movq	%rdx, %r9
	shrq	$48, %r9
	je	LBB134_21
## %bb.18:                              ## %for.inc.11
	andl	$15, %r9d
	movzbl	(%r9,%rcx), %r9d
	leaq	-27(%rbp), %rax
	movb	%r9b, -26(%rbp)
	movq	%rdx, %r9
	shrq	$52, %r9
	je	LBB134_4
## %bb.20:                              ## %for.inc.12
	andl	$15, %r9d
	movzbl	(%r9,%rcx), %r9d
	leaq	-28(%rbp), %r8
	movb	%r9b, -27(%rbp)
	movq	%rdx, %r9
	shrq	$56, %r9
	jne	LBB134_23
LBB134_21:
	movq	%rax, %rdx
	movq	%r8, %rax
	jmp	LBB134_22
LBB134_23:                              ## %for.inc.13
	andl	$15, %r9d
	movzbl	(%r9,%rcx), %r9d
	leaq	-29(%rbp), %rax
	movb	%r9b, -28(%rbp)
	shrq	$60, %rdx
	jne	LBB134_25
LBB134_4:
	movq	%r8, %rdx
LBB134_22:                              ## %cleanup
	movb	$120, (%rax)
	movb	$48, -2(%rdx)
	addq	$-2, %rdx
	callq	_halide_string_to_string
	addq	$32, %rsp
	popq	%rbp
	retq
LBB134_25:                              ## %for.inc.14
	movzbl	(%rdx,%rcx), %ecx
	movq	%rax, %rdx
	leaq	-30(%rbp), %rax
	movb	%cl, -29(%rbp)
	jmp	LBB134_22
                                        ## -- End function
	.globl	_halide_type_to_string          ## -- Begin function halide_type_to_string
	.weak_definition	_halide_type_to_string
	.p2align	4, 0x90
_halide_type_to_string:                 ## @halide_type_to_string
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdx, %r14
	movq	%rsi, %rbx
	movsbq	(%rdx), %rax
	cmpq	$4, %rax
	ja	LBB135_1
## %bb.2:                               ## %switch.lookup
	leaq	l_reltable.halide_type_to_string(%rip), %rcx
	movslq	(%rcx,%rax,4), %rdx
	addq	%rcx, %rdx
	jmp	LBB135_3
LBB135_1:
	leaq	L_.str.19.72(%rip), %rdx
LBB135_3:                               ## %sw.epilog
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	movzbl	1(%r14), %edx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	_halide_uint64_to_string
	cmpw	$1, 2(%r14)
	jne	LBB135_5
## %bb.4:                               ## %if.end
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB135_5:                               ## %if.then
	leaq	L_.str.20.78(%rip), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	movzwl	2(%r14), %edx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$1, %ecx
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_uint64_to_string        ## TAILCALL
                                        ## -- End function
	.globl	_halide_buffer_to_string        ## -- Begin function halide_buffer_to_string
	.weak_definition	_halide_buffer_to_string
	.p2align	4, 0x90
_halide_buffer_to_string:               ## @halide_buffer_to_string
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	testq	%rdx, %rdx
	je	LBB136_1
## %bb.3:                               ## %if.end
	movq	%rdx, %r14
	movq	%rbx, %rsi
	callq	_halide_pointer_to_string
	leaq	L_.str.22.80(%rip), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_string_to_string
	movq	(%r14), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	_halide_uint64_to_string
	leaq	L_.str.55(%rip), %r15
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_halide_string_to_string
	movq	8(%r14), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_pointer_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_halide_string_to_string
	movq	16(%r14), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_pointer_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_halide_string_to_string
	movq	24(%r14), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	_halide_uint64_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_halide_string_to_string
	leaq	32(%r14), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	_halide_type_to_string
	cmpl	$0, 36(%r14)
	jle	LBB136_6
## %bb.4:                               ## %for.body.lr.ph
	xorl	%r15d, %r15d
	leaq	L_.str.55(%rip), %r12
	xorl	%r13d, %r13d
	.p2align	4, 0x90
LBB136_5:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rax, %rdi
	movq	%rbx, %rsi
	leaq	L_.str.24.83(%rip), %rdx
	callq	_halide_string_to_string
	movq	40(%r14), %rcx
	movslq	(%rcx,%r15), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	_halide_int64_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r12, %rdx
	callq	_halide_string_to_string
	movq	40(%r14), %rcx
	movslq	4(%rcx,%r15), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	_halide_int64_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movq	%r12, %rdx
	callq	_halide_string_to_string
	movq	40(%r14), %rcx
	movslq	8(%rcx,%r15), %rdx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	movl	$1, %ecx
	callq	_halide_int64_to_string
	movq	%rax, %rdi
	movq	%rbx, %rsi
	leaq	L_.str.25.84(%rip), %rdx
	callq	_halide_string_to_string
	incq	%r13
	movslq	36(%r14), %rcx
	addq	$16, %r15
	cmpq	%rcx, %r13
	jl	LBB136_5
LBB136_6:                               ## %for.cond.cleanup
	leaq	L_.str.8.122(%rip), %rdx
	movq	%rax, %rdi
	jmp	LBB136_2
LBB136_1:                               ## %if.then
	leaq	L_.str.21.79(%rip), %rdx
LBB136_2:                               ## %if.then
	movq	%rbx, %rsi
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_string_to_string        ## TAILCALL
                                        ## -- End function
	.globl	_halide_internal_malloc_alignment ## -- Begin function halide_internal_malloc_alignment
	.weak_definition	_halide_internal_malloc_alignment
	.p2align	4, 0x90
_halide_internal_malloc_alignment:      ## @halide_internal_malloc_alignment
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$64, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_fopen                   ## -- Begin function halide_fopen
	.weak_definition	_halide_fopen
	.p2align	4, 0x90
_halide_fopen:                          ## @halide_fopen
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_fopen                          ## TAILCALL
                                        ## -- End function
	.globl	_halide_reuse_device_allocations ## -- Begin function halide_reuse_device_allocations
	.weak_definition	_halide_reuse_device_allocations
	.p2align	4, 0x90
_halide_reuse_device_allocations:       ## @halide_reuse_device_allocations
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE@GOTPCREL(%rip), %rax
	movb	%sil, (%rax)
	xorl	%r14d, %r14d
	testl	%esi, %esi
	jne	LBB139_4
## %bb.1:                               ## %if.then
	movq	%rdi, %rbx
	movq	__ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	movq	__ZN6Halide7Runtime8Internal23device_allocation_poolsE@GOTPCREL(%rip), %rax
	movq	(%rax), %r15
	xorl	%r14d, %r14d
	testq	%r15, %r15
	je	LBB139_3
	.p2align	4, 0x90
LBB139_5:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%rbx, %rdi
	callq	*(%r15)
	testl	%eax, %eax
	cmovnel	%eax, %r14d
	movq	8(%r15), %r15
	testq	%r15, %r15
	jne	LBB139_5
LBB139_3:                               ## %for.cond.cleanup
	movq	__ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
LBB139_4:                               ## %if.end5
	movl	%r14d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_can_reuse_device_allocations ## -- Begin function halide_can_reuse_device_allocations
	.weak_definition	_halide_can_reuse_device_allocations
	.p2align	4, 0x90
_halide_can_reuse_device_allocations:   ## @halide_can_reuse_device_allocations
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE@GOTPCREL(%rip), %rax
	movzbl	(%rax), %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_register_device_allocation_pool ## -- Begin function halide_register_device_allocation_pool
	.weak_definition	_halide_register_device_allocation_pool
	.p2align	4, 0x90
_halide_register_device_allocation_pool: ## @halide_register_device_allocation_pool
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	movq	__ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPCREL(%rip), %r14
	movq	%r14, %rdi
	callq	_halide_mutex_lock
	movq	__ZN6Halide7Runtime8Internal23device_allocation_poolsE@GOTPCREL(%rip), %rax
	movq	(%rax), %rcx
	movq	%rcx, 8(%rbx)
	movq	%rbx, (%rax)
	movq	%r14, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_mutex_unlock            ## TAILCALL
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t ## -- Begin function _ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	.weak_definition	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t: ## @_ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	24(%rsi), %rax
	xorl	%ebx, %ebx
	testb	$2, %al
	je	LBB142_6
## %bb.1:                               ## %if.end
	movl	$-14, %ebx
	testb	$1, %al
	jne	LBB142_6
## %bb.2:                               ## %if.end9
	movq	%rsi, %r14
	movq	8(%rsi), %rax
	testq	%rax, %rax
	je	LBB142_3
## %bb.4:                               ## %if.end15
	movq	%rdi, %r15
	movq	120(%rax), %rax
	movq	%r14, %rsi
	callq	*48(%rax)
	testl	%eax, %eax
	jne	LBB142_6
## %bb.5:                               ## %if.end22
	andb	$-3, 24(%r14)
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	_halide_msan_annotate_buffer_is_initialized
	xorl	%ebx, %ebx
	jmp	LBB142_6
LBB142_3:
	movl	$-19, %ebx
LBB142_6:                               ## %return
	movl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_release          ## -- Begin function halide_device_release
	.weak_definition	_halide_device_release
	.p2align	4, 0x90
_halide_device_release:                 ## @halide_device_release
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	120(%rsi), %rax
	popq	%rbp
	jmpq	*40(%rax)                       ## TAILCALL
                                        ## -- End function
	.globl	_halide_copy_to_host            ## -- Begin function halide_copy_to_host
	.weak_definition	_halide_copy_to_host
	.p2align	4, 0x90
_halide_copy_to_host:                   ## @halide_copy_to_host
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	testq	%rbx, %rbx
	je	LBB144_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rax
	movq	8(%rbx), %rcx
	testq	%rax, %rax
	je	LBB144_5
## %bb.3:                               ## %if.end.i
	testq	%rcx, %rcx
	jne	LBB144_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB144_12
	jmp	LBB144_11
LBB144_1:                               ## %if.then.i
	leaq	L_.str.6.91(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB144_12
	jmp	LBB144_11
LBB144_5:                               ## %if.end16.i
	testq	%rcx, %rcx
	je	LBB144_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB144_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB144_12
	jmp	LBB144_11
LBB144_8:                               ## %if.end28.i
	movl	24(%rbx), %eax
	notl	%eax
	testb	$3, %al
	jne	LBB144_11
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB144_12
LBB144_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.split
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	movl	%eax, %r15d
LBB144_12:                              ## %cleanup
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	movl	%r15d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_copy_to_device_already_locked  ## -- Begin function copy_to_device_already_locked
	.weak_definition	_copy_to_device_already_locked
	.p2align	4, 0x90
_copy_to_device_already_locked:         ## @copy_to_device_already_locked
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB145_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rax
	movq	8(%rbx), %rcx
	testq	%rax, %rax
	je	LBB145_5
## %bb.3:                               ## %if.end.i
	testq	%rcx, %rcx
	jne	LBB145_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB145_22
	jmp	LBB145_11
LBB145_1:                               ## %if.then.i
	leaq	L_.str.7.92(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB145_22
	jmp	LBB145_11
LBB145_5:                               ## %if.end16.i
	testq	%rcx, %rcx
	je	LBB145_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB145_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB145_22
	jmp	LBB145_11
LBB145_8:                               ## %if.end28.i
	movl	24(%rbx), %eax
	notl	%eax
	testb	$3, %al
	jne	LBB145_11
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB145_22
LBB145_11:                              ## %if.end
	testq	%r15, %r15
	jne	LBB145_14
## %bb.12:                              ## %if.then1
	movq	8(%rbx), %r15
	testq	%r15, %r15
	je	LBB145_13
LBB145_14:                              ## %if.end9
	cmpq	$0, (%rbx)
	je	LBB145_17
## %bb.15:                              ## %land.lhs.true
	cmpq	%r15, 8(%rbx)
	je	LBB145_18
## %bb.16:                              ## %if.then13
	leaq	-64(%rbp), %rbx
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.9.93(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-42, %r12d
	jmp	LBB145_22
LBB145_17:                              ## %if.then19
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_halide_device_malloc
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB145_22
LBB145_18:                              ## %if.end28
	movq	24(%rbx), %rax
	xorl	%r12d, %r12d
	testb	$1, %al
	je	LBB145_22
## %bb.19:                              ## %if.then30
	movl	$-15, %r12d
	testb	$2, %al
	jne	LBB145_22
## %bb.20:                              ## %if.else
	movq	120(%r15), %rax
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*56(%rax)
	testl	%eax, %eax
	jne	LBB145_22
## %bb.21:                              ## %if.then47
	andb	$-2, 24(%rbx)
	xorl	%r12d, %r12d
	jmp	LBB145_22
LBB145_13:
	movl	$-19, %r12d
LBB145_22:                              ## %cleanup
	movl	%r12d, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movl	$1024, %edi                     ## imm = 0x400
	callq	_malloc
	movl	$1024, %ecx                     ## imm = 0x400
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	callq	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	cmpq	$0, 16(%rbx)
	je	LBB146_2
## %bb.1:                               ## %if.end
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB146_2:                               ## %if.then
	movq	%rbx, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv ## TAILCALL
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	movq	24(%rdi), %r14
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	_halide_error
	movq	16(%rbx), %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_free                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_device_malloc           ## -- Begin function halide_device_malloc
	.weak_definition	_halide_device_malloc
	.p2align	4, 0x90
_halide_device_malloc:                  ## @halide_device_malloc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB148_1
## %bb.2:                               ## %if.end.i
	movq	(%r15), %rcx
	movq	8(%r15), %rax
	testq	%rcx, %rcx
	je	LBB148_5
## %bb.3:                               ## %if.end.i
	testq	%rax, %rax
	jne	LBB148_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	testl	%eax, %eax
	jne	LBB148_16
	jmp	LBB148_11
LBB148_1:                               ## %if.then.i
	leaq	L_.str.17.94(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	testl	%eax, %eax
	jne	LBB148_16
	jmp	LBB148_11
LBB148_5:                               ## %if.end16.i
	testq	%rax, %rax
	je	LBB148_8
## %bb.6:                               ## %if.end16.i
	testq	%rcx, %rcx
	jne	LBB148_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	testl	%eax, %eax
	jne	LBB148_16
	jmp	LBB148_11
LBB148_8:                               ## %if.end28.i
	movl	24(%r15), %ecx
	notl	%ecx
	testb	$3, %cl
	jne	LBB148_12
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	testl	%eax, %eax
	jne	LBB148_16
LBB148_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	8(%r15), %rax
LBB148_12:                              ## %if.end
	testq	%rax, %rax
	je	LBB148_15
## %bb.13:                              ## %if.end
	cmpq	%rbx, %rax
	je	LBB148_15
## %bb.14:                              ## %if.then5
	leaq	L_.str.20.95(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error
	movl	$-42, %eax
	jmp	LBB148_16
LBB148_15:                              ## %_ZN12_GLOBAL__N_121call_device_interfaceIPFiPvP15halide_buffer_tEJRS1_RS3_EEEiPK25halide_device_interface_tT_DpOT0_.exit
	movq	120(%rbx), %rax
	movq	16(%rax), %r12
	callq	*(%rax)
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	*%r12
	movl	%eax, %r14d
	movq	120(%rbx), %rax
	callq	*8(%rax)
	xorl	%eax, %eax
	testl	%r14d, %r14d
	sete	%al
	shll	$4, %eax
	addl	$-16, %eax
LBB148_16:                              ## %cleanup13
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_copy_to_device          ## -- Begin function halide_copy_to_device
	.weak_definition	_halide_copy_to_device
	.p2align	4, 0x90
_halide_copy_to_device:                 ## @halide_copy_to_device
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %r15
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %r12
	movq	%r12, %rdi
	callq	_halide_mutex_lock
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	callq	_copy_to_device_already_locked
	movl	%eax, %ebx
	movq	%r12, %rdi
	callq	_halide_mutex_unlock
	movl	%ebx, %eax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_sync             ## -- Begin function halide_device_sync
	.weak_definition	_halide_device_sync
	.p2align	4, 0x90
_halide_device_sync:                    ## @halide_device_sync
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB150_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rcx
	movq	8(%rbx), %rax
	testq	%rcx, %rcx
	je	LBB150_5
## %bb.3:                               ## %if.end.i
	testq	%rax, %rax
	jne	LBB150_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	testl	%eax, %eax
	jne	LBB150_14
	jmp	LBB150_11
LBB150_1:                               ## %if.then.i
	leaq	L_.str.16.96(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	testl	%eax, %eax
	jne	LBB150_14
	jmp	LBB150_11
LBB150_5:                               ## %if.end16.i
	testq	%rax, %rax
	je	LBB150_8
## %bb.6:                               ## %if.end16.i
	testq	%rcx, %rcx
	jne	LBB150_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	testl	%eax, %eax
	je	LBB150_11
LBB150_14:                              ## %cleanup8
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB150_8:                               ## %if.end28.i
	movl	24(%rbx), %ecx
	notl	%ecx
	testb	$3, %cl
	jne	LBB150_12
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	testl	%eax, %eax
	jne	LBB150_14
LBB150_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	8(%rbx), %rax
LBB150_12:                              ## %if.end
	testq	%rax, %rax
	je	LBB150_15
## %bb.13:                              ## %if.end4
	movq	120(%rax), %rax
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*32(%rax)
	movl	%eax, %ecx
	testl	%eax, %eax
	movl	$-17, %eax
	cmovel	%ecx, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB150_15:                              ## %if.then2
	movq	%r14, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_error_no_device_interface ## TAILCALL
                                        ## -- End function
	.globl	_halide_device_sync_global      ## -- Begin function halide_device_sync_global
	.weak_definition	_halide_device_sync_global
	.p2align	4, 0x90
_halide_device_sync_global:             ## @halide_device_sync_global
## %bb.0:                               ## %entry
	testq	%rsi, %rsi
	je	LBB151_1
## %bb.2:                               ## %if.end
	pushq	%rbp
	movq	%rsp, %rbp
	movq	120(%rsi), %rax
	movq	32(%rax), %rax
	xorl	%esi, %esi
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
LBB151_1:                               ## %return
	movl	$-19, %eax
	retq
                                        ## -- End function
	.globl	_halide_device_free             ## -- Begin function halide_device_free
	.weak_definition	_halide_device_free
	.p2align	4, 0x90
_halide_device_free:                    ## @halide_device_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB152_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rax
	movq	8(%rbx), %r15
	testq	%rax, %rax
	je	LBB152_5
## %bb.3:                               ## %if.end.i
	testq	%r15, %r15
	jne	LBB152_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	testl	%eax, %eax
	jne	LBB152_15
	jmp	LBB152_11
LBB152_1:                               ## %if.then.i
	leaq	L_.str.21.99(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	testl	%eax, %eax
	jne	LBB152_15
	jmp	LBB152_11
LBB152_5:                               ## %if.end16.i
	testq	%r15, %r15
	je	LBB152_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB152_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	testl	%eax, %eax
	jne	LBB152_15
	jmp	LBB152_11
LBB152_8:                               ## %if.end28.i
	movl	24(%rbx), %eax
	notl	%eax
	testb	$3, %al
	jne	LBB152_12
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	testl	%eax, %eax
	jne	LBB152_15
LBB152_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	8(%rbx), %r15
LBB152_12:                              ## %if.end
	testq	%r15, %r15
	je	LBB152_14
## %bb.13:                              ## %_ZN12_GLOBAL__N_121call_device_interfaceIPFiPvP15halide_buffer_tEJRS1_RS3_EEEiPK25halide_device_interface_tT_DpOT0_.exit
	movq	120(%r15), %rax
	movq	24(%rax), %r12
	callq	*(%rax)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*%r12
	movl	%eax, %r14d
	movq	120(%r15), %rax
	callq	*8(%rax)
	movl	$-18, %eax
	testl	%r14d, %r14d
	jne	LBB152_15
LBB152_14:                              ## %if.end8
	andb	$-3, 24(%rbx)
	xorl	%eax, %eax
LBB152_15:                              ## %cleanup10
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_free_as_destructor ## -- Begin function halide_device_free_as_destructor
	.weak_definition	_halide_device_free_as_destructor
	.p2align	4, 0x90
_halide_device_free_as_destructor:      ## @halide_device_free_as_destructor
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_halide_device_free             ## TAILCALL
                                        ## -- End function
	.globl	_halide_device_and_host_malloc  ## -- Begin function halide_device_and_host_malloc
	.weak_definition	_halide_device_and_host_malloc
	.p2align	4, 0x90
_halide_device_and_host_malloc:         ## @halide_device_and_host_malloc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB154_1
## %bb.2:                               ## %if.end.i
	movq	(%r15), %rcx
	movq	8(%r15), %rax
	testq	%rcx, %rcx
	je	LBB154_5
## %bb.3:                               ## %if.end.i
	testq	%rax, %rax
	jne	LBB154_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	testl	%eax, %eax
	jne	LBB154_16
	jmp	LBB154_11
LBB154_1:                               ## %if.then.i
	leaq	L_.str.22.100(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	testl	%eax, %eax
	jne	LBB154_16
	jmp	LBB154_11
LBB154_5:                               ## %if.end16.i
	testq	%rax, %rax
	je	LBB154_8
## %bb.6:                               ## %if.end16.i
	testq	%rcx, %rcx
	jne	LBB154_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	testl	%eax, %eax
	jne	LBB154_16
	jmp	LBB154_11
LBB154_8:                               ## %if.end28.i
	movl	24(%r15), %ecx
	notl	%ecx
	testb	$3, %cl
	jne	LBB154_12
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	testl	%eax, %eax
	jne	LBB154_16
LBB154_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	8(%r15), %rax
LBB154_12:                              ## %if.end
	testq	%rax, %rax
	je	LBB154_15
## %bb.13:                              ## %if.end
	cmpq	%rbx, %rax
	je	LBB154_15
## %bb.14:                              ## %if.then5
	leaq	-64(%rbp), %rbx
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.24.101(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-42, %eax
	jmp	LBB154_16
LBB154_15:                              ## %_ZN12_GLOBAL__N_121call_device_interfaceIPFiPvP15halide_buffer_tEJRS1_RS3_EEEiPK25halide_device_interface_tT_DpOT0_.exit
	movq	120(%rbx), %rax
	movq	64(%rax), %r12
	callq	*(%rax)
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	*%r12
	movl	%eax, %r14d
	movq	120(%rbx), %rax
	callq	*8(%rax)
	xorl	%eax, %eax
	testl	%r14d, %r14d
	sete	%al
	shll	$4, %eax
	addl	$-16, %eax
LBB154_16:                              ## %cleanup17
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_and_host_free    ## -- Begin function halide_device_and_host_free
	.weak_definition	_halide_device_and_host_free
	.p2align	4, 0x90
_halide_device_and_host_free:           ## @halide_device_and_host_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB155_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rax
	movq	8(%rbx), %r15
	testq	%rax, %rax
	je	LBB155_5
## %bb.3:                               ## %if.end.i
	testq	%r15, %r15
	jne	LBB155_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	testl	%eax, %eax
	jne	LBB155_17
	jmp	LBB155_11
LBB155_1:                               ## %if.then.i
	leaq	L_.str.26.102(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	testl	%eax, %eax
	jne	LBB155_17
	jmp	LBB155_11
LBB155_5:                               ## %if.end16.i
	testq	%r15, %r15
	je	LBB155_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB155_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	testl	%eax, %eax
	jne	LBB155_17
	jmp	LBB155_11
LBB155_8:                               ## %if.end28.i
	movl	24(%rbx), %eax
	notl	%eax
	testb	$3, %al
	jne	LBB155_12
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	testl	%eax, %eax
	jne	LBB155_17
LBB155_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	8(%rbx), %r15
LBB155_12:                              ## %if.end
	testq	%r15, %r15
	je	LBB155_14
## %bb.13:                              ## %_ZN12_GLOBAL__N_121call_device_interfaceIPFiPvP15halide_buffer_tEJRS1_RS3_EEEiPK25halide_device_interface_tT_DpOT0_.exit
	movq	120(%r15), %rax
	movq	72(%rax), %r12
	callq	*(%rax)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*%r12
	movl	%eax, %r14d
	movq	120(%r15), %rax
	callq	*8(%rax)
	movl	$-18, %eax
	testl	%r14d, %r14d
	jne	LBB155_17
	jmp	LBB155_16
LBB155_14:                              ## %if.else
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	je	LBB155_16
## %bb.15:                              ## %if.then9
	movq	%r14, %rdi
	callq	_halide_free
	movq	$0, 16(%rbx)
LBB155_16:                              ## %if.end13
	andb	$-3, 24(%rbx)
	xorl	%eax, %eax
LBB155_17:                              ## %cleanup15
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_device_and_host_malloc ## -- Begin function halide_default_device_and_host_malloc
	.weak_definition	_halide_default_device_and_host_malloc
	.p2align	4, 0x90
_halide_default_device_and_host_malloc: ## @halide_default_device_and_host_malloc
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB156_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rax
	movq	8(%rbx), %rcx
	testq	%rax, %rax
	je	LBB156_5
## %bb.3:                               ## %if.end.i
	testq	%rcx, %rcx
	jne	LBB156_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB156_27
	jmp	LBB156_11
LBB156_1:                               ## %if.then.i
	leaq	L_.str.27.103(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB156_27
	jmp	LBB156_11
LBB156_5:                               ## %if.end16.i
	testq	%rcx, %rcx
	je	LBB156_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB156_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB156_27
	jmp	LBB156_11
LBB156_8:                               ## %if.end28.i
	movl	24(%rbx), %eax
	notl	%eax
	testb	$3, %al
	jne	LBB156_11
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	movl	%eax, %r12d
	testl	%eax, %eax
	jne	LBB156_27
LBB156_11:                              ## %if.end
	movl	36(%rbx), %ecx
	testl	%ecx, %ecx
	jle	LBB156_12
## %bb.13:                              ## %for.body.lr.ph.i.i
	movq	40(%rbx), %rdx
	shlq	$4, %rcx
	xorl	%esi, %esi
	xorl	%eax, %eax
	jmp	LBB156_14
	.p2align	4, 0x90
LBB156_16:                              ## %if.end.i.i
                                        ##   in Loop: Header=BB156_14 Depth=1
	addq	$16, %rsi
	cmpq	%rsi, %rcx
	je	LBB156_17
LBB156_14:                              ## %for.body.i.i
                                        ## =>This Inner Loop Header: Depth=1
	movl	8(%rdx,%rsi), %edi
	testl	%edi, %edi
	jle	LBB156_16
## %bb.15:                              ## %if.then.i.i
                                        ##   in Loop: Header=BB156_14 Depth=1
	movslq	4(%rdx,%rsi), %r8
	decq	%r8
	imulq	%rdi, %r8
	addq	%r8, %rax
	jmp	LBB156_16
LBB156_17:                              ## %for.body.i12.i.preheader
	xorl	%esi, %esi
	xorl	%edi, %edi
	jmp	LBB156_18
	.p2align	4, 0x90
LBB156_20:                              ## %if.end.i23.i
                                        ##   in Loop: Header=BB156_18 Depth=1
	addq	$16, %rsi
	cmpq	%rsi, %rcx
	je	LBB156_21
LBB156_18:                              ## %for.body.i12.i
                                        ## =>This Inner Loop Header: Depth=1
	movslq	8(%rdx,%rsi), %r8
	testq	%r8, %r8
	jns	LBB156_20
## %bb.19:                              ## %if.then.i19.i
                                        ##   in Loop: Header=BB156_18 Depth=1
	movslq	4(%rdx,%rsi), %r9
	decq	%r9
	imulq	%r8, %r9
	addq	%r9, %rdi
	jmp	LBB156_20
LBB156_21:                              ## %_ZNK15halide_buffer_t12begin_offsetEv.exit.loopexit.i
	subq	%rdi, %rax
	incq	%rax
	jmp	LBB156_22
LBB156_12:
	movl	$1, %eax
LBB156_22:                              ## %_ZNK15halide_buffer_t13size_in_bytesEv.exit
	movzbl	33(%rbx), %esi
	addq	$7, %rsi
	shrq	$3, %rsi
	imulq	%rax, %rsi
	movq	%r14, %rdi
	callq	_halide_malloc
	movq	%rax, 16(%rbx)
	testq	%rax, %rax
	je	LBB156_23
## %bb.24:                              ## %if.end5
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%r15, %rdx
	callq	_halide_device_malloc
	testl	%eax, %eax
	je	LBB156_25
## %bb.26:                              ## %if.then8
	movl	%eax, %r12d
	movq	16(%rbx), %rsi
	movq	%r14, %rdi
	callq	_halide_free
	movq	$0, 16(%rbx)
	jmp	LBB156_27
LBB156_23:
	movl	$-34, %r12d
	jmp	LBB156_27
LBB156_25:
	xorl	%r12d, %r12d
LBB156_27:                              ## %cleanup12
	movl	%r12d, %eax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_device_and_host_free ## -- Begin function halide_default_device_and_host_free
	.weak_definition	_halide_default_device_and_host_free
	.p2align	4, 0x90
_halide_default_device_and_host_free:   ## @halide_default_device_and_host_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB157_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rax
	movq	8(%rbx), %rcx
	testq	%rax, %rax
	je	LBB157_5
## %bb.3:                               ## %if.end.i
	testq	%rcx, %rcx
	jne	LBB157_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB157_14
	jmp	LBB157_11
LBB157_1:                               ## %if.then.i
	leaq	L_.str.28.104(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB157_14
	jmp	LBB157_11
LBB157_5:                               ## %if.end16.i
	testq	%rcx, %rcx
	je	LBB157_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB157_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB157_14
	jmp	LBB157_11
LBB157_8:                               ## %if.end28.i
	movl	24(%rbx), %eax
	notl	%eax
	testb	$3, %al
	jne	LBB157_11
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	movl	%eax, %r15d
	testl	%eax, %eax
	jne	LBB157_14
LBB157_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.split
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	_halide_device_free
	movl	%eax, %r15d
	movq	16(%rbx), %rsi
	testq	%rsi, %rsi
	je	LBB157_13
## %bb.12:                              ## %if.then3
	movq	%r14, %rdi
	callq	_halide_free
	movq	$0, 16(%rbx)
LBB157_13:                              ## %if.end6
	andb	$-4, 24(%rbx)
LBB157_14:                              ## %cleanup
	movl	%r15d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_wrap_native      ## -- Begin function halide_device_wrap_native
	.weak_definition	_halide_device_wrap_native
	.p2align	4, 0x90
_halide_device_wrap_native:             ## @halide_device_wrap_native
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %r14
	testq	%rsi, %rsi
	je	LBB158_1
## %bb.2:                               ## %if.end.i
	movq	(%r12), %rcx
	movq	8(%r12), %rax
	testq	%rcx, %rcx
	je	LBB158_5
## %bb.3:                               ## %if.end.i
	testq	%rax, %rax
	jne	LBB158_5
## %bb.4:                               ## %if.then8.i
	movq	%r14, %rdi
	callq	_halide_error_no_device_interface
	testl	%eax, %eax
	jne	LBB158_16
	jmp	LBB158_11
LBB158_1:                               ## %if.then.i
	leaq	L_.str.29.105(%rip), %rsi
	movq	%r14, %rdi
	callq	_halide_error_buffer_is_null
	testl	%eax, %eax
	jne	LBB158_16
	jmp	LBB158_11
LBB158_5:                               ## %if.end16.i
	testq	%rax, %rax
	je	LBB158_8
## %bb.6:                               ## %if.end16.i
	testq	%rcx, %rcx
	jne	LBB158_8
## %bb.7:                               ## %if.then20.i
	movq	%r14, %rdi
	callq	_halide_error_device_interface_no_device
	testl	%eax, %eax
	jne	LBB158_16
	jmp	LBB158_11
LBB158_8:                               ## %if.end28.i
	movl	24(%r12), %ecx
	notl	%ecx
	testb	$3, %cl
	jne	LBB158_12
## %bb.9:                               ## %if.then36.i
	movq	%r14, %rdi
	callq	_halide_error_host_and_device_dirty
	testl	%eax, %eax
	jne	LBB158_16
LBB158_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	8(%r12), %rax
LBB158_12:                              ## %if.end
	testq	%rax, %rax
	je	LBB158_15
## %bb.13:                              ## %if.end
	cmpq	%rbx, %rax
	je	LBB158_15
## %bb.14:                              ## %if.then3
	leaq	-72(%rbp), %rbx
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.30.106(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-42, %eax
	jmp	LBB158_16
LBB158_15:                              ## %_ZN12_GLOBAL__N_121call_device_interfaceIPFiPvP15halide_buffer_tyEJRS1_RS3_RyEEEiPK25halide_device_interface_tT_DpOT0_.exit
	movq	%rbx, 8(%r12)
	movq	120(%rbx), %rax
	movq	112(%rax), %r13
	callq	*(%rax)
	movq	%r14, %rdi
	movq	%r12, %rsi
	movq	%r15, %rdx
	callq	*%r13
	movl	%eax, %r14d
	movq	120(%rbx), %rax
	callq	*8(%rax)
	xorl	%eax, %eax
	testl	%r14d, %r14d
	sete	%al
	shll	$4, %eax
	addl	$-16, %eax
LBB158_16:                              ## %cleanup13
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_detach_native    ## -- Begin function halide_device_detach_native
	.weak_definition	_halide_device_detach_native
	.p2align	4, 0x90
_halide_device_detach_native:           ## @halide_device_detach_native
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rsi, %r14
	movq	%rdi, %rbx
	testq	%rsi, %rsi
	je	LBB159_1
## %bb.2:                               ## %if.end.i
	movq	(%r14), %rax
	movq	8(%r14), %r12
	testq	%rax, %rax
	je	LBB159_5
## %bb.3:                               ## %if.end.i
	testq	%r12, %r12
	jne	LBB159_5
## %bb.4:                               ## %if.then8.i
	movq	%rbx, %rdi
	callq	_halide_error_no_device_interface
	testl	%eax, %eax
	jne	LBB159_16
	jmp	LBB159_11
LBB159_1:                               ## %if.then.i
	leaq	L_.str.31.107(%rip), %rsi
	movq	%rbx, %rdi
	callq	_halide_error_buffer_is_null
	testl	%eax, %eax
	jne	LBB159_16
	jmp	LBB159_11
LBB159_5:                               ## %if.end16.i
	testq	%r12, %r12
	je	LBB159_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB159_8
## %bb.7:                               ## %if.then20.i
	movq	%rbx, %rdi
	callq	_halide_error_device_interface_no_device
	testl	%eax, %eax
	jne	LBB159_16
	jmp	LBB159_11
LBB159_8:                               ## %if.end28.i
	movl	24(%r14), %eax
	notl	%eax
	testb	$3, %al
	jne	LBB159_12
## %bb.9:                               ## %if.then36.i
	movq	%rbx, %rdi
	callq	_halide_error_host_and_device_dirty
	testl	%eax, %eax
	jne	LBB159_16
LBB159_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	8(%r14), %r12
LBB159_12:                              ## %if.end
	xorl	%eax, %eax
	testq	%r12, %r12
	je	LBB159_16
## %bb.13:                              ## %_ZN12_GLOBAL__N_121call_device_interfaceIPFiPvP15halide_buffer_tEJRS1_RS3_EEEiPK25halide_device_interface_tT_DpOT0_.exit
	movq	120(%r12), %rax
	movq	120(%rax), %r15
	callq	*(%rax)
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	*%r15
	movl	%eax, %r15d
	movq	120(%r12), %rax
	callq	*8(%rax)
	movl	$-33, %eax
	testl	%r15d, %r15d
	jne	LBB159_16
## %bb.14:                              ## %cleanup.cont
	cmpq	$0, (%r14)
	movl	$0, %eax
	je	LBB159_16
## %bb.15:                              ## %if.then9
	leaq	L_.str.32.108(%rip), %rsi
	movq	%rbx, %rdi
	callq	_halide_error
	movl	$-22, %eax
LBB159_16:                              ## %cleanup17
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_device_wrap_native ## -- Begin function halide_default_device_wrap_native
	.weak_definition	_halide_default_device_wrap_native
	.p2align	4, 0x90
_halide_default_device_wrap_native:     ## @halide_default_device_wrap_native
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movl	$-32, %eax
	cmpq	$0, (%rsi)
	je	LBB160_1
## %bb.2:                               ## %return
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB160_1:                               ## %if.end
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	8(%rsi), %rax
	movq	120(%rax), %rax
	callq	*(%rax)
	movq	%rbx, (%r14)
	xorl	%eax, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_device_detach_native ## -- Begin function halide_default_device_detach_native
	.weak_definition	_halide_default_device_detach_native
	.p2align	4, 0x90
_halide_default_device_detach_native:   ## @halide_default_device_detach_native
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %rbx
	testq	%rsi, %rsi
	je	LBB161_1
## %bb.2:                               ## %if.end.i
	movq	(%rbx), %rax
	movq	8(%rbx), %rcx
	testq	%rax, %rax
	je	LBB161_5
## %bb.3:                               ## %if.end.i
	testq	%rcx, %rcx
	jne	LBB161_5
## %bb.4:                               ## %if.then8.i
	callq	_halide_error_no_device_interface
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	LBB161_14
	jmp	LBB161_11
LBB161_1:                               ## %if.then.i
	leaq	L_.str.34.109(%rip), %rsi
	callq	_halide_error_buffer_is_null
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	LBB161_14
	jmp	LBB161_11
LBB161_5:                               ## %if.end16.i
	testq	%rcx, %rcx
	je	LBB161_8
## %bb.6:                               ## %if.end16.i
	testq	%rax, %rax
	jne	LBB161_8
## %bb.7:                               ## %if.then20.i
	callq	_halide_error_device_interface_no_device
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	LBB161_14
	jmp	LBB161_11
LBB161_8:                               ## %if.end28.i
	movl	24(%rbx), %ecx
	notl	%ecx
	testb	$3, %cl
	jne	LBB161_12
## %bb.9:                               ## %if.then36.i
	callq	_halide_error_host_and_device_dirty
	movl	%eax, %r14d
	testl	%eax, %eax
	jne	LBB161_14
LBB161_11:                              ## %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	movq	(%rbx), %rax
LBB161_12:                              ## %if.end
	xorl	%r14d, %r14d
	testq	%rax, %rax
	je	LBB161_14
## %bb.13:                              ## %if.end2
	movq	8(%rbx), %rax
	movq	120(%rax), %rax
	callq	*8(%rax)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, (%rbx)
LBB161_14:                              ## %cleanup
	movl	%r14d, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_and_host_free_as_destructor ## -- Begin function halide_device_and_host_free_as_destructor
	.weak_definition	_halide_device_and_host_free_as_destructor
	.p2align	4, 0x90
_halide_device_and_host_free_as_destructor: ## @halide_device_and_host_free_as_destructor
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_halide_device_and_host_free    ## TAILCALL
                                        ## -- End function
	.globl	_halide_device_host_nop_free    ## -- Begin function halide_device_host_nop_free
	.weak_definition	_halide_device_host_nop_free
	.p2align	4, 0x90
_halide_device_host_nop_free:           ## @halide_device_host_nop_free
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_buffer_copy     ## -- Begin function halide_default_buffer_copy
	.weak_definition	_halide_default_buffer_copy
	.p2align	4, 0x90
_halide_default_buffer_copy:            ## @halide_default_buffer_copy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$-39, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_buffer_copy_already_locked ## -- Begin function halide_buffer_copy_already_locked
	.weak_definition	_halide_buffer_copy_already_locked
	.p2align	4, 0x90
_halide_buffer_copy_already_locked:     ## @halide_buffer_copy_already_locked
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$440, %rsp                      ## imm = 0x1B8
	movq	%rdx, %r12
	testq	%rdx, %rdx
	je	LBB165_5
## %bb.1:                               ## %land.lhs.true
	movq	8(%rcx), %rax
	testq	%rax, %rax
	je	LBB165_4
## %bb.2:                               ## %land.lhs.true
	cmpq	%r12, %rax
	je	LBB165_4
## %bb.3:                               ## %if.then
	leaq	L_.str.40(%rip), %rsi
	callq	_halide_error
	movl	$-42, %r13d
	jmp	LBB165_46
LBB165_4:                               ## %land.lhs.true5
	cmpq	$0, (%rcx)
	je	LBB165_13
LBB165_5:                               ## %if.end13
	cmpq	$0, (%rsi)
	movq	16(%rsi), %rax
	je	LBB165_9
## %bb.6:                               ## %land.rhs
	testq	%rax, %rax
	je	LBB165_12
## %bb.7:                               ## %land.end.thread284
	movq	24(%rsi), %rax
	movl	%eax, %edx
	andb	$1, %dl
	testb	$2, %al
	jne	LBB165_11
LBB165_8:
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	jmp	LBB165_16
LBB165_9:                               ## %land.end
	testq	%rax, %rax
	je	LBB165_14
## %bb.10:                              ## %land.end.land.rhs26_crit_edge
	movq	24(%rsi), %rax
	movb	$1, %dl
	testb	$2, %al
	je	LBB165_8
LBB165_11:                              ## %lor.rhs28
	cmpq	$0, 8(%rsi)
	setne	%r9b
	xorl	%r8d, %r8d
	jmp	LBB165_16
LBB165_12:
	movb	$1, %r8b
	xorl	%edx, %edx
	jmp	LBB165_15
LBB165_13:                              ## %if.then7
	movq	%rdi, %r14
	movq	%rsi, %r15
	movq	%rcx, %rsi
	movq	%r12, %rdx
	movq	%rcx, %rbx
	callq	_halide_device_malloc
	movq	%r15, %rsi
	movq	%r14, %rdi
	movq	%rbx, %rcx
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	LBB165_46
	jmp	LBB165_5
LBB165_14:
	movb	$1, %dl
	movb	$1, %r8b
LBB165_15:                              ## %land.end32
	movb	$1, %r9b
LBB165_16:                              ## %land.end32
	testq	%r12, %r12
	setne	%r10b
	movq	16(%rcx), %r15
	movl	$-34, %r13d
	movq	%r12, %rax
	orq	%r15, %rax
	je	LBB165_46
## %bb.17:                              ## %if.end41
	testq	%r12, %r12
	sete	%al
	orb	%dl, %al
	jne	LBB165_19
## %bb.18:                              ## %if.end50
	movq	120(%r12), %rax
	movq	%rdi, %rbx
	movq	%rsi, %r14
	movl	%edx, -56(%rbp)                 ## 4-byte Spill
	movq	%r12, %rdx
	movq	%rcx, %r13
	movl	%r8d, -52(%rbp)                 ## 4-byte Spill
	movl	%r9d, -48(%rbp)                 ## 4-byte Spill
	movb	%r10b, -41(%rbp)                ## 1-byte Spill
	callq	*80(%rax)
	movzbl	-41(%rbp), %r10d                ## 1-byte Folded Reload
	movl	-48(%rbp), %r9d                 ## 4-byte Reload
	movl	-52(%rbp), %r8d                 ## 4-byte Reload
	movl	-56(%rbp), %edx                 ## 4-byte Reload
	movq	%r14, %rsi
	movq	%rbx, %rdi
	movq	%r13, %rcx
	movl	%eax, %r13d
	cmpl	$-42, %eax
	jne	LBB165_36
LBB165_19:                              ## %if.then52
	testq	%r15, %r15
	sete	%al
	movl	$-42, %r13d
	testb	%al, %r8b
	jne	LBB165_46
## %bb.20:                              ## %if.end59
	orb	%r10b, %r9b
	cmpb	$1, %r9b
	jne	LBB165_28
## %bb.21:                              ## %if.else
	orb	%dl, %r10b
	je	LBB165_30
## %bb.22:                              ## %if.else82
	testq	%r15, %r15
	sete	%al
	orb	%al, %dl
	je	LBB165_33
## %bb.23:                              ## %if.else99
	testq	%r12, %r12
	je	LBB165_44
## %bb.24:                              ## %if.then101
	movq	%rcx, %rbx
	movq	%rdi, %r14
	movq	%rsi, %r15
	callq	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	movq	%r14, %rdi
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	LBB165_44
## %bb.25:                              ## %if.end125.thread301
	movq	120(%r12), %rax
	movq	%r15, %rsi
	movq	%r12, %rdx
	movq	%rbx, %rcx
	callq	*80(%rax)
	movl	%eax, %r13d
	cmpq	%r15, %rbx
	je	LBB165_42
## %bb.26:                              ## %if.end125.thread301
	testl	%r13d, %r13d
	movq	%r14, %rdi
	jne	LBB165_43
## %bb.27:                              ## %if.then129.thread307
	movq	24(%rbx), %rax
	andq	$-4, %rax
	orq	$2, %rax
	movq	%rax, 24(%rbx)
	jmp	LBB165_45
LBB165_28:                              ## %if.end125.thread
	leaq	-472(%rbp), %r12
	movq	%rdi, %r14
	movq	%r12, %rdi
	movq	%rsi, %r15
	movl	$1, %edx
	movq	%rcx, %rbx
	movl	$1, %r8d
	callq	__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
	movq	%r12, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
	xorl	%r13d, %r13d
	cmpq	%r15, %rbx
	je	LBB165_46
## %bb.29:                              ## %if.else134.thread
	movq	24(%rbx), %rax
	andq	$-4, %rax
	orq	$1, %rax
	movq	%rax, 24(%rbx)
	jmp	LBB165_46
LBB165_30:                              ## %if.then67
	movq	8(%rsi), %rax
	movq	120(%rax), %rax
	movq	%rdi, %r14
	movq	%rsi, %r15
	xorl	%edx, %edx
	movq	%rcx, %rbx
	callq	*80(%rax)
	movq	%r15, %rsi
	movq	%r14, %rdi
	movq	%rbx, %rcx
	movl	%eax, %r13d
	cmpl	$-42, %eax
	jne	LBB165_36
## %bb.31:                              ## %if.then75
	movq	%r14, %rdi
	movq	%rsi, %r15
	callq	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	movq	%r14, %rdi
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	LBB165_44
## %bb.32:                              ## %if.then78
	movq	%r14, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	movq	%rbx, %rcx
	callq	_halide_buffer_copy_already_locked
	jmp	LBB165_35
LBB165_33:                              ## %if.then86
	movq	8(%rsi), %rax
	movq	120(%rax), %rax
	movq	%rdi, %r14
	movq	%rsi, %r15
	xorl	%edx, %edx
	movq	%rcx, %rbx
	callq	*80(%rax)
	movq	%r14, %rdi
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	LBB165_44
## %bb.34:                              ## %if.then96
	orb	$1, 24(%rbx)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	movq	%r12, %rdx
	callq	_copy_to_device_already_locked
LBB165_35:                              ## %if.end125
	movq	%r14, %rdi
	movq	%rbx, %rcx
	movl	%eax, %r13d
	movq	%r15, %rsi
LBB165_36:                              ## %if.end125
	cmpq	%rsi, %rcx
	je	LBB165_43
## %bb.37:                              ## %if.end125
	testl	%r13d, %r13d
	jne	LBB165_43
## %bb.38:                              ## %if.then129
	movq	24(%rcx), %rax
	andq	$-4, %rax
	testq	%r12, %r12
	je	LBB165_40
## %bb.39:                              ## %if.then131
	orq	$2, %rax
	jmp	LBB165_41
LBB165_40:                              ## %if.else134
	orq	$1, %rax
LBB165_41:                              ## %return
	movq	%rax, 24(%rcx)
	jmp	LBB165_45
LBB165_42:
	movq	%r14, %rdi
LBB165_43:                              ## %if.end138
	testl	%r13d, %r13d
	je	LBB165_45
LBB165_44:                              ## %if.then140
	leaq	L_.str.53(%rip), %rsi
	callq	_halide_error
	jmp	LBB165_46
LBB165_45:
	xorl	%r13d, %r13d
LBB165_46:                              ## %return
	movl	%r13d, %eax
	addq	$440, %rsp                      ## imm = 0x1B8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_buffer_copy             ## -- Begin function halide_buffer_copy
	.weak_definition	_halide_buffer_copy
	.p2align	4, 0x90
_halide_buffer_copy:                    ## @halide_buffer_copy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rcx, %rbx
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	movq	8(%r15), %r13
	testq	%r13, %r13
	je	LBB166_2
## %bb.1:                               ## %if.then.i
	movq	120(%r13), %rax
	callq	*(%rax)
LBB166_2:                               ## %_ZN12_GLOBAL__N_19UseModuleC2EPK25halide_device_interface_t.exit
	testq	%r14, %r14
	je	LBB166_3
## %bb.4:                               ## %if.then.i23
	movq	120(%r14), %rax
	callq	*(%rax)
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	movq	%rbx, %rcx
	callq	_halide_buffer_copy_already_locked
	movl	%eax, %ebx
	movq	120(%r14), %rax
	callq	*8(%rax)
	testq	%r13, %r13
	je	LBB166_7
LBB166_6:                               ## %if.then.i27
	movq	120(%r13), %rax
	callq	*8(%rax)
LBB166_7:                               ## %_ZN12_GLOBAL__N_19UseModuleD2Ev.exit28
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	movl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB166_3:                               ## %_ZN12_GLOBAL__N_19UseModuleC2EPK25halide_device_interface_t.exit20.thread
	movq	%r12, %rdi
	movq	%r15, %rsi
	xorl	%edx, %edx
	movq	%rbx, %rcx
	callq	_halide_buffer_copy_already_locked
	movl	%eax, %ebx
	testq	%r13, %r13
	jne	LBB166_6
	jmp	LBB166_7
                                        ## -- End function
	.globl	_halide_default_device_crop     ## -- Begin function halide_default_device_crop
	.weak_definition	_halide_default_device_crop
	.p2align	4, 0x90
_halide_default_device_crop:            ## @halide_default_device_crop
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, %rsi
	leaq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.58(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-40, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_device_slice    ## -- Begin function halide_default_device_slice
	.weak_definition	_halide_default_device_slice
	.p2align	4, 0x90
_halide_default_device_slice:           ## @halide_default_device_slice
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, %rsi
	leaq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.59(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-40, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_crop             ## -- Begin function halide_device_crop
	.weak_definition	_halide_device_crop
	.p2align	4, 0x90
_halide_device_crop:                    ## @halide_device_crop
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	cmpq	$0, (%r15)
	je	LBB169_1
## %bb.2:                               ## %if.end
	cmpq	$0, (%r14)
	je	LBB169_5
## %bb.3:                               ## %if.then3
	leaq	-56(%rbp), %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.60(%rip), %rsi
	jmp	LBB169_4
LBB169_1:
	xorl	%ebx, %ebx
	jmp	LBB169_8
LBB169_5:                               ## %if.end4
	movl	36(%r15), %eax
	cmpl	36(%r14), %eax
	jne	LBB169_6
## %bb.7:                               ## %if.end9
	movq	8(%r15), %rax
	movq	120(%rax), %rax
	callq	*(%rax)
	movq	8(%r15), %rax
	movq	120(%rax), %rax
	movq	%rbx, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	*88(%rax)
	movl	%eax, %ebx
	jmp	LBB169_8
LBB169_6:                               ## %if.then6
	leaq	-56(%rbp), %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.61(%rip), %rsi
LBB169_4:                               ## %cleanup
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-41, %ebx
LBB169_8:                               ## %cleanup
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	movl	%ebx, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_slice            ## -- Begin function halide_device_slice
	.weak_definition	_halide_device_slice
	.p2align	4, 0x90
_halide_device_slice:                   ## @halide_device_slice
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%r8, %r14
	movl	%ecx, %r15d
	movl	%edx, %r12d
	movq	%rsi, %r13
	movq	%rdi, %rbx
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	cmpq	$0, (%r13)
	je	LBB170_1
## %bb.2:                               ## %if.end
	cmpq	$0, (%r14)
	je	LBB170_5
## %bb.3:                               ## %if.then3
	leaq	-72(%rbp), %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.60(%rip), %rsi
	jmp	LBB170_4
LBB170_1:
	xorl	%ebx, %ebx
	jmp	LBB170_8
LBB170_5:                               ## %if.end4
	movl	36(%r14), %eax
	incl	%eax
	cmpl	%eax, 36(%r13)
	jne	LBB170_6
## %bb.7:                               ## %if.end9
	movq	8(%r13), %rax
	movq	120(%rax), %rax
	callq	*(%rax)
	movq	8(%r13), %rax
	movq	120(%rax), %rax
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movl	%r12d, %edx
	movl	%r15d, %ecx
	movq	%r14, %r8
	callq	*96(%rax)
	movl	%eax, %ebx
	jmp	LBB170_8
LBB170_6:                               ## %if.then6
	leaq	-72(%rbp), %r14
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.64(%rip), %rsi
LBB170_4:                               ## %cleanup
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-41, %ebx
LBB170_8:                               ## %cleanup
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	movl	%ebx, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_device_release_crop ## -- Begin function halide_default_device_release_crop
	.weak_definition	_halide_default_device_release_crop
	.p2align	4, 0x90
_halide_default_device_release_crop:    ## @halide_default_device_release_crop
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	cmpq	$0, (%rsi)
	je	LBB171_1
## %bb.2:                               ## %if.end
	movq	%rdi, %rax
	leaq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv
	leaq	L_.str.58(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev
	movl	$-40, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
LBB171_1:
	xorl	%eax, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_device_release_crop     ## -- Begin function halide_device_release_crop
	.weak_definition	_halide_device_release_crop
	.p2align	4, 0x90
_halide_device_release_crop:            ## @halide_device_release_crop
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	cmpq	$0, (%rsi)
	je	LBB172_2
## %bb.1:                               ## %if.then
	movq	%rsi, %rbx
	movq	%rdi, %r14
	movq	__ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPCREL(%rip), %r15
	movq	%r15, %rdi
	callq	_halide_mutex_lock
	movq	8(%rbx), %r12
	movq	120(%r12), %rax
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	*104(%rax)
	movl	%eax, %r14d
	movq	$0, (%rbx)
	movq	120(%r12), %rax
	callq	*8(%rax)
	movq	$0, 8(%rbx)
	movq	%r15, %rdi
	callq	_halide_mutex_unlock
	movl	%r14d, %eax
	jmp	LBB172_3
LBB172_2:                               ## %return
	xorl	%eax, %eax
LBB172_3:                               ## %return
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_float16_bits_to_float   ## -- Begin function halide_float16_bits_to_float
	.weak_definition	_halide_float16_bits_to_float
	.p2align	4, 0x90
_halide_float16_bits_to_float:          ## @halide_float16_bits_to_float
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	%edi, %ecx
	shrl	$10, %ecx
	andl	$31, %ecx
	movl	%edi, %eax
	andl	$1023, %eax                     ## imm = 0x3FF
	je	LBB173_3
## %bb.1:                               ## %entry
	testl	%ecx, %ecx
	jne	LBB173_3
## %bb.2:                               ## %if.then
	xorl	%ecx, %ecx
	lzcntl	%eax, %ecx
	movl	%ecx, %edx
	xorb	$31, %dl
	btrl	%edx, %eax
	movb	$23, %sil
	subb	%dl, %sil
	shlxl	%esi, %eax, %eax
	shll	$23, %ecx
	movl	$1124073472, %edx               ## imm = 0x43000000
	subl	%ecx, %edx
	jmp	LBB173_7
LBB173_3:                               ## %if.else
	shll	$13, %eax
	testl	%ecx, %ecx
	je	LBB173_4
## %bb.5:                               ## %if.else18
	movl	$2139095040, %edx               ## imm = 0x7F800000
	cmpl	$31, %ecx
	je	LBB173_7
## %bb.6:                               ## %if.else21
	shll	$23, %ecx
	addl	$939524096, %ecx                ## imm = 0x38000000
	movl	%ecx, %edx
	jmp	LBB173_7
LBB173_4:
	xorl	%edx, %edx
LBB173_7:                               ## %if.end23
	orl	%eax, %edx
	movswl	%di, %eax
	andl	$-2147483648, %eax              ## imm = 0x80000000
	orl	%edx, %eax
	vmovd	%eax, %xmm0
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_float16_bits_to_double  ## -- Begin function halide_float16_bits_to_double
	.weak_definition	_halide_float16_bits_to_double
	.p2align	4, 0x90
_halide_float16_bits_to_double:         ## @halide_float16_bits_to_double
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	callq	_halide_float16_bits_to_float
	vcvtss2sd	%xmm0, %xmm0, %xmm0
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_bounds_inference_call_failed ## -- Begin function halide_error_bounds_inference_call_failed
	.weak_definition	_halide_error_bounds_inference_call_failed
	.p2align	4, 0x90
_halide_error_bounds_inference_call_failed: ## @halide_error_bounds_inference_call_failed
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$40, %rsp
	movl	%edx, %ebx
	movq	%rsi, %r15
	movq	%rdi, %rsi
	leaq	-56(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.113(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.1.114(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%ebx, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	%ebx, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movl	$1024, %edi                     ## imm = 0x400
	callq	_malloc
	movl	$1024, %ecx                     ## imm = 0x400
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	callq	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	cmpq	$0, 16(%rbx)
	je	LBB176_2
## %bb.1:                               ## %if.end
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB176_2:                               ## %if.then
	movq	%rbx, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv ## TAILCALL
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	movq	24(%rdi), %r14
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	%r14, %rdi
	movq	%rax, %rsi
	callq	_halide_error
	movq	16(%rbx), %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_free                           ## TAILCALL
                                        ## -- End function
	.globl	_halide_error_extern_stage_failed ## -- Begin function halide_error_extern_stage_failed
	.weak_definition	_halide_error_extern_stage_failed
	.p2align	4, 0x90
_halide_error_extern_stage_failed:      ## @halide_error_extern_stage_failed
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$40, %rsp
	movl	%edx, %ebx
	movq	%rsi, %r15
	movq	%rdi, %rsi
	leaq	-56(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.2.116(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.1.114(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%ebx, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	%ebx, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_explicit_bounds_too_small ## -- Begin function halide_error_explicit_bounds_too_small
	.weak_definition	_halide_error_explicit_bounds_too_small
	.p2align	4, 0x90
_halide_error_explicit_bounds_too_small: ## @halide_error_explicit_bounds_too_small
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movl	%r9d, -44(%rbp)                 ## 4-byte Spill
	movl	%r8d, %r12d
	movl	%ecx, %r13d
	movq	%rdx, %rbx
	movq	%rsi, %r14
	movq	%rdi, %rsi
	leaq	-80(%rbp), %r15
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.3.117(%rip), %rsi
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.4.118(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.5.119(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.6.120(%rip), %rbx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r12d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.7.121(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	-44(%rbp), %esi                 ## 4-byte Reload
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	16(%rbp), %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.8.122(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-2, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_bad_type          ## -- Begin function halide_error_bad_type
	.weak_definition	_halide_error_bad_type
	.p2align	4, 0x90
_halide_error_bad_type:                 ## @halide_error_bad_type
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
	movq	%rsi, %r12
	movq	%rdi, %r13
	movl	%edx, -64(%rbp)
	movl	%ecx, -60(%rbp)
	movl	$0, -56(%rbp)
	movl	$0, -48(%rbp)
	leaq	-56(%rbp), %r14
	leaq	-60(%rbp), %rsi
	movl	$4, %edx
	movq	%r14, %rdi
	callq	_memcpy
	leaq	-48(%rbp), %rbx
	leaq	-64(%rbp), %rsi
	movl	$4, %edx
	movq	%rbx, %rdi
	callq	_memcpy
	leaq	-96(%rbp), %r15
	movq	%r15, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.9.123(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsERK13halide_type_t
	leaq	L_.str.10.124(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsERK13halide_type_t
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-3, %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBaselsERK13halide_type_t ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBaselsERK13halide_type_t
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBaselsERK13halide_type_t
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBaselsERK13halide_type_t: ## @_ZN6Halide7Runtime8Internal11PrinterBaselsERK13halide_type_t
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %rdx
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	movq	8(%rbx), %rsi
	callq	_halide_type_to_string
	movq	%rax, (%rbx)
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_bad_dimensions    ## -- Begin function halide_error_bad_dimensions
	.weak_definition	_halide_error_bad_dimensions
	.p2align	4, 0x90
_halide_error_bad_dimensions:           ## @halide_error_bad_dimensions
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movl	%ecx, %r15d
	movl	%edx, %r14d
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	movq	%rbx, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.11.125(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r15d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.12.126(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r14d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.13.127(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-43, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_access_out_of_bounds ## -- Begin function halide_error_access_out_of_bounds
	.weak_definition	_halide_error_access_out_of_bounds
	.p2align	4, 0x90
_halide_error_access_out_of_bounds:     ## @halide_error_access_out_of_bounds
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	cmpl	%r9d, %ecx
	jge	LBB183_2
## %bb.1:                               ## %if.then
	movl	%r9d, %r15d
	movl	%ecx, %r13d
	leaq	-72(%rbp), %r14
	movq	%r14, %rdi
	movl	%edx, %r12d
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.14.128(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.15.129(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r15d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.16.130(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r12d, %esi
	jmp	LBB183_4
LBB183_2:                               ## %if.else
	movl	%r8d, %r12d
	movl	16(%rbp), %r15d
	cmpl	%r15d, %r8d
	jle	LBB183_5
## %bb.3:                               ## %if.then8
	leaq	-72(%rbp), %r14
	movq	%r14, %rdi
	movl	%edx, %r13d
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.14.128(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r12d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.17.131(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r15d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.16.130(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r13d, %esi
LBB183_4:                               ## %if.end17
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
LBB183_5:                               ## %if.end17
	movl	$-4, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_buffer_allocation_too_large ## -- Begin function halide_error_buffer_allocation_too_large
	.weak_definition	_halide_error_buffer_allocation_too_large
	.p2align	4, 0x90
_halide_error_buffer_allocation_too_large: ## @halide_error_buffer_allocation_too_large
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.18.132(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	leaq	L_.str.20.134(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-5, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_buffer_extents_negative ## -- Begin function halide_error_buffer_extents_negative
	.weak_definition	_halide_error_buffer_extents_negative
	.p2align	4, 0x90
_halide_error_buffer_extents_negative:  ## @halide_error_buffer_extents_negative
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movl	%ecx, %r14d
	movl	%edx, %r15d
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.21.135(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.22.136(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r15d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.23.137(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r14d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.8.122(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-28, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_buffer_extents_too_large ## -- Begin function halide_error_buffer_extents_too_large
	.weak_definition	_halide_error_buffer_extents_too_large
	.p2align	4, 0x90
_halide_error_buffer_extents_too_large: ## @halide_error_buffer_extents_too_large
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.24.138(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	leaq	L_.str.20.134(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-6, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_constraints_make_required_region_smaller ## -- Begin function halide_error_constraints_make_required_region_smaller
	.weak_definition	_halide_error_constraints_make_required_region_smaller
	.p2align	4, 0x90
_halide_error_constraints_make_required_region_smaller: ## @halide_error_constraints_make_required_region_smaller
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movl	%r9d, %r13d
                                        ## kill: def $r8d killed $r8d def $r8
	movl	%ecx, %r15d
	movl	%edx, %ebx
	movq	%rsi, %r14
	movq	%rdi, %rsi
	movl	16(%rbp), %eax
	leal	-1(%r13,%rax), %eax
	movl	%eax, -44(%rbp)                 ## 4-byte Spill
	leal	-1(%r15,%r8), %eax
	movl	%eax, -48(%rbp)                 ## 4-byte Spill
	leaq	-80(%rbp), %r12
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.25.139(%rip), %rsi
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.26.140(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%ebx, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.27.141(%rip), %rbx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.28.142(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.6.120(%rip), %r13
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	-44(%rbp), %esi                 ## 4-byte Reload
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.29.143(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r15d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	-48(%rbp), %esi                 ## 4-byte Reload
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.39.197(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-7, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_constraint_violated ## -- Begin function halide_error_constraint_violated
	.weak_definition	_halide_error_constraint_violated
	.p2align	4, 0x90
_halide_error_constraint_violated:      ## @halide_error_constraint_violated
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movl	%r8d, %r14d
	movq	%rcx, %r15
	movl	%edx, %r12d
	movq	%rsi, %r13
	movq	%rdi, %rsi
	leaq	-72(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.31.145(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.32.146(%rip), %r13
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r12d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.33.147(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r14d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.8.122(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-8, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_param_too_small_i64 ## -- Begin function halide_error_param_too_small_i64
	.weak_definition	_halide_error_param_too_small_i64
	.p2align	4, 0x90
_halide_error_param_too_small_i64:      ## @halide_error_param_too_small_i64
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.34.148(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	leaq	L_.str.35(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-9, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_param_too_small_u64 ## -- Begin function halide_error_param_too_small_u64
	.weak_definition	_halide_error_param_too_small_u64
	.p2align	4, 0x90
_halide_error_param_too_small_u64:      ## @halide_error_param_too_small_u64
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.34.148(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	leaq	L_.str.35(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-9, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_param_too_small_f64 ## -- Begin function halide_error_param_too_small_f64
	.weak_definition	_halide_error_param_too_small_f64
	.p2align	4, 0x90
_halide_error_param_too_small_f64:      ## @halide_error_param_too_small_f64
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$48, %rsp
	vmovsd	%xmm1, -32(%rbp)                ## 8-byte Spill
	vmovsd	%xmm0, -24(%rbp)                ## 8-byte Spill
	movq	%rsi, %r14
	movq	%rdi, %rsi
	leaq	-64(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.34.148(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	vmovsd	-24(%rbp), %xmm0                ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEd
	leaq	L_.str.35(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	vmovsd	-32(%rbp), %xmm0                ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEd
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-9, %eax
	addq	$48, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_param_too_large_i64 ## -- Begin function halide_error_param_too_large_i64
	.weak_definition	_halide_error_param_too_large_i64
	.p2align	4, 0x90
_halide_error_param_too_large_i64:      ## @halide_error_param_too_large_i64
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.34.148(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	leaq	L_.str.36(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEx
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-10, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_param_too_large_u64 ## -- Begin function halide_error_param_too_large_u64
	.weak_definition	_halide_error_param_too_large_u64
	.p2align	4, 0x90
_halide_error_param_too_large_u64:      ## @halide_error_param_too_large_u64
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rcx, %rbx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.34.148(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	leaq	L_.str.36(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-10, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_param_too_large_f64 ## -- Begin function halide_error_param_too_large_f64
	.weak_definition	_halide_error_param_too_large_f64
	.p2align	4, 0x90
_halide_error_param_too_large_f64:      ## @halide_error_param_too_large_f64
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$48, %rsp
	vmovsd	%xmm1, -32(%rbp)                ## 8-byte Spill
	vmovsd	%xmm0, -24(%rbp)                ## 8-byte Spill
	movq	%rsi, %r14
	movq	%rdi, %rsi
	leaq	-64(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.34.148(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	vmovsd	-24(%rbp), %xmm0                ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEd
	leaq	L_.str.36(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	vmovsd	-32(%rbp), %xmm0                ## 8-byte Reload
                                        ## xmm0 = mem[0],zero
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEd
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-10, %eax
	addq	$48, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_out_of_memory     ## -- Begin function halide_error_out_of_memory
	.weak_definition	_halide_error_out_of_memory
	.p2align	4, 0x90
_halide_error_out_of_memory:            ## @halide_error_out_of_memory
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	leaq	L_.str.37(%rip), %rsi
	callq	_halide_error
	movl	$-11, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_buffer_argument_is_null ## -- Begin function halide_error_buffer_argument_is_null
	.weak_definition	_halide_error_buffer_argument_is_null
	.p2align	4, 0x90
_halide_error_buffer_argument_is_null:  ## @halide_error_buffer_argument_is_null
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	leaq	-48(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.38(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.39(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-12, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_debug_to_file_failed ## -- Begin function halide_error_debug_to_file_failed
	.weak_definition	_halide_error_debug_to_file_failed
	.p2align	4, 0x90
_halide_error_debug_to_file_failed:     ## @halide_error_debug_to_file_failed
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movl	%ecx, %ebx
	movq	%rdx, %r15
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-64(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.40.149(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.41(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.42(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%ebx, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-13, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_unaligned_host_ptr ## -- Begin function halide_error_unaligned_host_ptr
	.weak_definition	_halide_error_unaligned_host_ptr
	.p2align	4, 0x90
_halide_error_unaligned_host_ptr:       ## @halide_error_unaligned_host_ptr
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$40, %rsp
	movl	%edx, %r14d
	movq	%rsi, %r15
	movq	%rdi, %rsi
	leaq	-56(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.43(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.44(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r14d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.45(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-24, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_device_dirty_with_no_device_support ## -- Begin function halide_error_device_dirty_with_no_device_support
	.weak_definition	_halide_error_device_dirty_with_no_device_support
	.p2align	4, 0x90
_halide_error_device_dirty_with_no_device_support: ## @halide_error_device_dirty_with_no_device_support
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
	movq	%rsi, %r14
	movq	%rdi, %rsi
	leaq	-48(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.46(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.47(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.48(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-44, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_host_is_null      ## -- Begin function halide_error_host_is_null
	.weak_definition	_halide_error_host_is_null
	.p2align	4, 0x90
_halide_error_host_is_null:             ## @halide_error_host_is_null
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	leaq	-48(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.43(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.49(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-34, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_bad_fold          ## -- Begin function halide_error_bad_fold
	.weak_definition	_halide_error_bad_fold
	.p2align	4, 0x90
_halide_error_bad_fold:                 ## @halide_error_bad_fold
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rcx, %r14
	movq	%rdx, %r12
	movq	%rsi, %r15
	movq	%rdi, %rsi
	leaq	-64(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.50.150(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.51(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.52(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.39.197(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-25, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_bad_extern_fold   ## -- Begin function halide_error_bad_extern_fold
	.weak_definition	_halide_error_bad_extern_fold
	.p2align	4, 0x90
_halide_error_bad_extern_fold:          ## @halide_error_bad_extern_fold
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
	movl	%r9d, %r13d
                                        ## kill: def $r8d killed $r8d def $r8
	movl	%ecx, %r14d
	movl	%edx, %ebx
	movq	%rsi, %r12
	movq	%rdi, %rsi
	movl	16(%rbp), %ecx
	leal	(%rcx,%r13), %r15d
	leal	(%r8,%r14), %eax
	decl	%eax
	movl	%eax, -44(%rbp)                 ## 4-byte Spill
	cmpl	%r9d, %r14d
	jl	LBB202_2
## %bb.1:                               ## %entry
	addl	%r14d, %r8d
	cmpl	%r15d, %r8d
	jg	LBB202_2
## %bb.3:                               ## %if.else
	leaq	-88(%rbp), %r15
	movq	%r15, %rdi
	movq	%rcx, %r13
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.53.151(%rip), %rsi
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%ebx, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.51(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.54(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r14d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.55(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	-44(%rbp), %esi                 ## 4-byte Reload
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.56(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.59.153(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.60.154(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.39.197(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r15, %rdi
	jmp	LBB202_4
LBB202_2:                               ## %if.then
	leaq	-88(%rbp), %rdi
	movq	%r12, -56(%rbp)                 ## 8-byte Spill
	movq	%rdi, %r12
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.53.151(%rip), %rsi
	movq	%r12, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%ebx, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.51(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	-56(%rbp), %rsi                 ## 8-byte Reload
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.54(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r14d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.55(%rip), %rbx
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	-44(%rbp), %esi                 ## 4-byte Reload
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.56(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.57(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	decl	%r15d
	movq	%rax, %rdi
	movl	%r15d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.58.152(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r12, %rdi
LBB202_4:                               ## %if.end
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-35, %eax
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_fold_factor_too_small ## -- Begin function halide_error_fold_factor_too_small
	.weak_definition	_halide_error_fold_factor_too_small
	.p2align	4, 0x90
_halide_error_fold_factor_too_small:    ## @halide_error_fold_factor_too_small
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movl	%r9d, -44(%rbp)                 ## 4-byte Spill
	movq	%r8, %r15
	movl	%ecx, %ebx
	movq	%rdx, %r13
	movq	%rsi, %r12
	movq	%rdi, %rsi
	leaq	-80(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.61.155(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%ebx, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.62(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.51(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.63(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.32.146(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	-44(%rbp), %esi                 ## 4-byte Reload
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.64.156(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-26, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_requirement_failed ## -- Begin function halide_error_requirement_failed
	.weak_definition	_halide_error_requirement_failed
	.p2align	4, 0x90
_halide_error_requirement_failed:       ## @halide_error_requirement_failed
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdx, %rbx
	movq	%rsi, %r15
	movq	%rdi, %rsi
	leaq	-56(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.65(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.66(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-27, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_specialize_fail   ## -- Begin function halide_error_specialize_fail
	.weak_definition	_halide_error_specialize_fail
	.p2align	4, 0x90
_halide_error_specialize_fail:          ## @halide_error_specialize_fail
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	leaq	-48(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.67(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-31, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_no_device_interface ## -- Begin function halide_error_no_device_interface
	.weak_definition	_halide_error_no_device_interface
	.p2align	4, 0x90
_halide_error_no_device_interface:      ## @halide_error_no_device_interface
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, %rsi
	leaq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.68(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-19, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_device_interface_no_device ## -- Begin function halide_error_device_interface_no_device
	.weak_definition	_halide_error_device_interface_no_device
	.p2align	4, 0x90
_halide_error_device_interface_no_device: ## @halide_error_device_interface_no_device
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, %rsi
	leaq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.69(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-36, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_host_and_device_dirty ## -- Begin function halide_error_host_and_device_dirty
	.weak_definition	_halide_error_host_and_device_dirty
	.p2align	4, 0x90
_halide_error_host_and_device_dirty:    ## @halide_error_host_and_device_dirty
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, %rsi
	leaq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.70(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-37, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_buffer_is_null    ## -- Begin function halide_error_buffer_is_null
	.weak_definition	_halide_error_buffer_is_null
	.p2align	4, 0x90
_halide_error_buffer_is_null:           ## @halide_error_buffer_is_null
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	leaq	-48(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.71(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.72(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-38, %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_storage_bound_too_small ## -- Begin function halide_error_storage_bound_too_small
	.weak_definition	_halide_error_storage_bound_too_small
	.p2align	4, 0x90
_halide_error_storage_bound_too_small:  ## @halide_error_storage_bound_too_small
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movl	%r8d, %r14d
	movl	%ecx, %r13d
	movq	%rdx, %r12
	movq	%rsi, %r15
	movq	%rdi, %rsi
	leaq	-72(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.73(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.62(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.51(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.74(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r14d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.64.156(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-45, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_device_crop_failed ## -- Begin function halide_error_device_crop_failed
	.weak_definition	_halide_error_device_crop_failed
	.p2align	4, 0x90
_halide_error_device_crop_failed:       ## @halide_error_device_crop_failed
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, %rsi
	leaq	-40(%rbp), %rbx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.75(%rip), %rsi
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-41, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_error_split_factor_not_positive ## -- Begin function halide_error_split_factor_not_positive
	.weak_definition	_halide_error_split_factor_not_positive
	.p2align	4, 0x90
_halide_error_split_factor_not_positive: ## @halide_error_split_factor_not_positive
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	movq	%r9, -48(%rbp)                  ## 8-byte Spill
	movq	%r8, %r12
	movq	%rcx, %r13
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	leaq	-80(%rbp), %r14
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EEC2EPv.112
	leaq	L_.str.76(%rip), %rsi
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.77(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.78(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.79(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r12, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.19.133(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	-48(%rbp), %rbx                 ## 8-byte Reload
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.80(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	16(%rbp), %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.81(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.82(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.83(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%r14, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.115
	movl	$-46, %eax
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_profiler_shutdown       ## -- Begin function halide_profiler_shutdown
	.weak_definition	_halide_profiler_shutdown
	.p2align	4, 0x90
_halide_profiler_shutdown:              ## @halide_profiler_shutdown
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	callq	_halide_profiler_get_state
	movq	40(%rax), %rdi
	testq	%rdi, %rdi
	je	LBB213_1
## %bb.2:                               ## %if.end
	movq	%rax, %rbx
	movl	$-2, 16(%rax)
	callq	_halide_join_thread
	movq	$0, 40(%rbx)
	movl	$-1, 16(%rbx)
	xorl	%edi, %edi
	movq	%rbx, %rsi
	callq	_halide_profiler_report_unlocked
	movq	%rbx, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmp	_halide_profiler_reset_unlocked ## TAILCALL
LBB213_1:                               ## %cleanup
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_profiler_get_state      ## -- Begin function halide_profiler_get_state
	.weak_definition	_halide_profiler_get_state
	.p2align	4, 0x90
_halide_profiler_get_state:             ## @halide_profiler_get_state
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	leaq	__ZZ25halide_profiler_get_stateE1s(%rip), %rax
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__literal4,4byte_literals
	.p2align	2, 0x0                          ## -- Begin function halide_profiler_report_unlocked
LCPI215_0:
	.long	0x49742400                      ## float 1.0E+6
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0
LCPI215_1:
	.long	1127219200                      ## 0x43300000
	.long	1160773632                      ## 0x45300000
	.long	0                               ## 0x0
	.long	0                               ## 0x0
LCPI215_2:
	.quad	0x4330000000000000              ## double 4503599627370496
	.quad	0x4530000000000000              ## double 1.9342813113834067E+25
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3, 0x0
LCPI215_3:
	.quad	0x3ddb7cdfd9d7bdbb              ## double 1.0E-10
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_profiler_report_unlocked
	.weak_definition	_halide_profiler_report_unlocked
	.p2align	4, 0x90
_halide_profiler_report_unlocked:       ## @halide_profiler_report_unlocked
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$232, %rsp
	movq	%rsi, %rbx
	movq	%rdi, %rsi
	movq	%rdi, -72(%rbp)
	leaq	-272(%rbp), %r13
	movq	%r13, %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EEC2EPv
	leaq	L_.str.7.166(%rip), %rdi
	callq	_getenv
	testq	%rax, %rax
	je	LBB215_3
## %bb.1:                               ## %if.then
	movq	%rax, %r14
	leaq	L_.str.8.167(%rip), %rsi
	movq	%rax, %rdi
	callq	_strcmp
	testl	%eax, %eax
	je	LBB215_4
## %bb.2:                               ## %if.else
	leaq	L_.str.9.168(%rip), %rsi
	movq	%r14, %rdi
	callq	_strcmp
	xorl	%ecx, %ecx
	testl	%eax, %eax
	setne	%al
	movl	%eax, -56(%rbp)                 ## 4-byte Spill
	leaq	__ZZ31halide_profiler_report_unlockedEN3$_18__invokeEP26halide_profiler_func_statsS1_(%rip), %rax
	cmoveq	%rax, %rcx
	movq	%rcx, -120(%rbp)                ## 8-byte Spill
	jmp	LBB215_5
LBB215_3:
	movb	$1, %al
	movl	%eax, -56(%rbp)                 ## 4-byte Spill
	xorl	%eax, %eax
	movq	%rax, -120(%rbp)                ## 8-byte Spill
	jmp	LBB215_5
LBB215_4:
	leaq	__ZZ31halide_profiler_report_unlockedEN3$_08__invokeEP26halide_profiler_func_statsS1_(%rip), %rax
	movq	%rax, -120(%rbp)                ## 8-byte Spill
	movl	$0, -56(%rbp)                   ## 4-byte Folded Spill
LBB215_5:                               ## %if.end11
	movb	$0, -46(%rbp)
	leaq	L_.str.10.169(%rip), %rdi
	callq	_getenv
	testq	%rax, %rax
	je	LBB215_9
## %bb.6:                               ## %if.then14
	movq	%rax, %r15
	leaq	L_.str.11.170(%rip), %rsi
	movq	%rax, %rdi
	callq	_strstr
	testq	%rax, %rax
	jne	LBB215_8
## %bb.7:                               ## %lor.lhs.false
	leaq	L_.str.12.171(%rip), %rsi
	movq	%r15, %rdi
	callq	_strstr
	testq	%rax, %rax
	je	LBB215_9
LBB215_8:                               ## %if.then19
	movb	$1, -46(%rbp)
LBB215_9:                               ## %if.end21
	movq	24(%rbx), %rdi
	testq	%rdi, %rdi
	je	LBB215_81
## %bb.10:
	leaq	-52(%rbp), %r12
	jmp	LBB215_14
	.p2align	4, 0x90
LBB215_11:                              ## %if.end254
                                        ##   in Loop: Header=BB215_14 Depth=1
	leaq	-52(%rbp), %r12
LBB215_12:                              ## %if.end255
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	-80(%rbp), %rdi                 ## 8-byte Reload
	leaq	-272(%rbp), %r13
LBB215_13:                              ## %cleanup257
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	64(%rdi), %rdi
	testq	%rdi, %rdi
	je	LBB215_81
LBB215_14:                              ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB215_42 Depth 2
                                        ##     Child Loop BB215_27 Depth 2
                                        ##     Child Loop BB215_49 Depth 2
                                        ##     Child Loop BB215_54 Depth 2
                                        ##       Child Loop BB215_55 Depth 3
                                        ##     Child Loop BB215_65 Depth 2
                                        ##     Child Loop BB215_71 Depth 2
                                        ##     Child Loop BB215_79 Depth 2
                                        ##     Child Loop BB215_61 Depth 2
	cmpl	$0, 80(%rdi)
	je	LBB215_13
## %bb.15:                              ## %if.end25
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	(%rdi), %rax
	movq	%rdi, %r15
	testq	%rax, %rax
	js	LBB215_17
## %bb.16:                              ## %if.end25
                                        ##   in Loop: Header=BB215_14 Depth=1
	vcvtsi2ss	%rax, %xmm4, %xmm0
	jmp	LBB215_18
	.p2align	4, 0x90
LBB215_17:                              ##   in Loop: Header=BB215_14 Depth=1
	movq	%rax, %rcx
	shrq	%rcx
	andl	$1, %eax
	orq	%rcx, %rax
	vcvtsi2ss	%rax, %xmm4, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
LBB215_18:                              ## %if.end25
                                        ##   in Loop: Header=BB215_14 Depth=1
	vdivss	LCPI215_0(%rip), %xmm0, %xmm0
	vmovss	%xmm0, -44(%rbp)                ## 4-byte Spill
	movq	%r13, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase5clearEv
	movq	32(%r15), %r14
	movq	40(%r15), %rbx
	cmpq	%rbx, %r14
	sete	-45(%rbp)
	movq	48(%r15), %rsi
	movq	%r13, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	leaq	L_.str.13.172(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	leaq	L_.str.14.173(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	vmovss	-44(%rbp), %xmm0                ## 4-byte Reload
                                        ## xmm0 = mem[0],zero,zero,zero
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	movq	%rax, %rdi
	leaq	L_.str.15.174(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	leaq	L_.str.16.175(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movl	84(%r15), %esi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%rax, %rdi
	leaq	L_.str.17.176(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movl	80(%r15), %esi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%rax, %rdi
	leaq	L_.str.18.177(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	vcvtsi2ssl	80(%r15), %xmm4, %xmm0
	vmovss	-44(%rbp), %xmm1                ## 4-byte Reload
                                        ## xmm1 = mem[0],zero,zero,zero
	vdivss	%xmm0, %xmm1, %xmm0
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	movq	%rax, %rdi
	leaq	L_.str.19.178(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	cmpb	$0, -45(%rbp)
	jne	LBB215_20
## %bb.19:                              ## %if.then49
                                        ##   in Loop: Header=BB215_14 Depth=1
	vmovq	%r14, %xmm0
	vmovdqa	LCPI215_1(%rip), %xmm2          ## xmm2 = [1127219200,1160773632,0,0]
	vpunpckldq	%xmm2, %xmm0, %xmm0     ## xmm0 = xmm0[0],xmm2[0],xmm0[1],xmm2[1]
	vmovapd	LCPI215_2(%rip), %xmm3          ## xmm3 = [4.503599627370496E+15,1.9342813113834067E+25]
	vsubpd	%xmm3, %xmm0, %xmm0
	vpermilpd	$1, %xmm0, %xmm1        ## xmm1 = xmm0[1,0]
	vaddsd	%xmm0, %xmm1, %xmm0
	vmovq	%rbx, %xmm1
	vpunpckldq	%xmm2, %xmm1, %xmm1     ## xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
	vsubpd	%xmm3, %xmm1, %xmm1
	vpermilpd	$1, %xmm1, %xmm2        ## xmm2 = xmm1[1,0]
	vaddsd	%xmm1, %xmm2, %xmm1
	vaddsd	LCPI215_3(%rip), %xmm1, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, -44(%rbp)                ## 4-byte Spill
	movq	%r13, %rdi
	leaq	L_.str.20.179(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	vmovss	-44(%rbp), %xmm0                ## 4-byte Reload
                                        ## xmm0 = mem[0],zero,zero,zero
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	movq	%rax, %rdi
	leaq	L_.str.13.172(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
LBB215_20:                              ## %if.end53
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	%r13, %rdi
	leaq	L_.str.21.180(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movl	88(%r15), %esi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	movq	%rax, %rdi
	leaq	L_.str.22.181(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	16(%r15), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	movq	%rax, %rdi
	leaq	L_.str.23.182(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	-72(%rbp), %rbx
	movq	%r13, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	%rbx, %rdi
	movq	%rax, %rsi
	callq	_halide_print
	cmpq	$0, (%r15)
	movq	%r15, %rdi
	leaq	L_.str.24.183(%rip), %r15
	jne	LBB215_22
## %bb.21:                              ## %lor.end
                                        ##   in Loop: Header=BB215_14 Depth=1
	cmpq	$0, 24(%rdi)
	je	LBB215_39
LBB215_22:                              ## %if.then76
                                        ##   in Loop: Header=BB215_14 Depth=1
	movslq	72(%rdi), %rax
	movq	%rsp, %r14
	leaq	15(,%rax,8), %rcx
	andq	$-16, %rcx
	subq	%rcx, %r14
	movq	%r14, %rsp
	movl	$23, -52(%rbp)
	testq	%rax, %rax
	movq	%rdi, -80(%rbp)                 ## 8-byte Spill
	jle	LBB215_36
## %bb.23:                              ## %for.body84.lr.ph
                                        ##   in Loop: Header=BB215_14 Depth=1
	xorl	%r15d, %r15d
	xorl	%r12d, %r12d
	xorl	%r8d, %r8d
	xorl	%esi, %esi
	xorl	%eax, %eax
	movq	%rax, -96(%rbp)                 ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -104(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -88(%rbp)                 ## 8-byte Spill
	jmp	LBB215_27
	.p2align	4, 0x90
LBB215_24:                              ## %if.end94
                                        ##   in Loop: Header=BB215_27 Depth=2
	movq	56(%r13,%r15), %rdi
	leaq	L_.str.24.183(%rip), %rsi
	callq	_strstr
	testq	%rax, %rax
	je	LBB215_29
## %bb.25:                              ## %if.then98
                                        ##   in Loop: Header=BB215_27 Depth=2
	movl	-44(%rbp), %r8d                 ## 4-byte Reload
	incl	%r8d
	movq	-88(%rbp), %rax                 ## 8-byte Reload
	addq	(%r13,%r15), %rax
	movq	%rax, -88(%rbp)                 ## 8-byte Spill
	movl	%ebx, %esi
	movq	-80(%rbp), %rdi                 ## 8-byte Reload
LBB215_26:                              ## %if.end114
                                        ##   in Loop: Header=BB215_27 Depth=2
	incq	%r12
	movslq	72(%rdi), %rax
	addq	$72, %r15
	cmpq	%rax, %r12
	jge	LBB215_33
LBB215_27:                              ## %for.body84
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movl	%r8d, -44(%rbp)                 ## 4-byte Spill
	movl	%esi, %ebx
	movq	56(%rdi), %r13
	movq	56(%r13,%r15), %rdi
	callq	_strlen
	cmpl	%eax, -52(%rbp)
	jge	LBB215_24
## %bb.28:                              ## %if.then93
                                        ##   in Loop: Header=BB215_27 Depth=2
	movl	%eax, -52(%rbp)
	jmp	LBB215_24
	.p2align	4, 0x90
LBB215_29:                              ## %if.else102
                                        ##   in Loop: Header=BB215_27 Depth=2
	movq	56(%r13,%r15), %rdi
	leaq	L_.str.25.184(%rip), %rsi
	callq	_strstr
	testq	%rax, %rax
	je	LBB215_31
## %bb.30:                              ## %if.then106
                                        ##   in Loop: Header=BB215_27 Depth=2
	movl	%ebx, %esi
	incl	%esi
	movq	-104(%rbp), %rax                ## 8-byte Reload
	addq	(%r13,%r15), %rax
	movq	%rax, -104(%rbp)                ## 8-byte Spill
	jmp	LBB215_32
LBB215_31:                              ## %if.else110
                                        ##   in Loop: Header=BB215_27 Depth=2
	movq	-96(%rbp), %rax                 ## 8-byte Reload
	addq	(%r13,%r15), %rax
	movq	%rax, -96(%rbp)                 ## 8-byte Spill
	movl	%ebx, %esi
LBB215_32:                              ## %if.end114
                                        ##   in Loop: Header=BB215_27 Depth=2
	movq	-80(%rbp), %rdi                 ## 8-byte Reload
	movl	-44(%rbp), %r8d                 ## 4-byte Reload
	jmp	LBB215_26
	.p2align	4, 0x90
LBB215_33:                              ## %for.cond120.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	movl	%eax, %eax
	testl	%eax, %eax
	leaq	-52(%rbp), %r12
	jle	LBB215_37
## %bb.34:                              ## %land.lhs.true.peel
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	56(%rdi), %rcx
	cmpq	$0, (%rcx)
	je	LBB215_45
## %bb.35:                              ## %if.end133.peel
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	%rcx, (%r14)
	movl	$1, %ebx
	jmp	LBB215_46
	.p2align	4, 0x90
LBB215_36:                              ##   in Loop: Header=BB215_14 Depth=1
	xorl	%ebx, %ebx
	xorl	%eax, %eax
	movq	%rax, -88(%rbp)                 ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -104(%rbp)                ## 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -96(%rbp)                 ## 8-byte Spill
	xorl	%esi, %esi
	xorl	%r8d, %r8d
	jmp	LBB215_38
LBB215_37:                              ##   in Loop: Header=BB215_14 Depth=1
	xorl	%ebx, %ebx
	leaq	-272(%rbp), %r13
	leaq	L_.str.24.183(%rip), %r15
LBB215_38:                              ## %if.end176
                                        ##   in Loop: Header=BB215_14 Depth=1
	leaq	-136(%rbp), %rcx
	leaq	-72(%rbp), %rdx
	jmp	LBB215_58
LBB215_39:                              ## %for.cond66.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	movl	72(%rdi), %eax
	testl	%eax, %eax
	jle	LBB215_13
## %bb.40:                              ## %for.body69.lr.ph
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	56(%rdi), %rcx
	cmpq	$0, 32(%rcx)
	jne	LBB215_22
## %bb.41:                              ## %for.cond66.preheader1
                                        ##   in Loop: Header=BB215_14 Depth=1
	addq	$104, %rcx
	leaq	-1(%rax), %rdx
	xorl	%esi, %esi
	.p2align	4, 0x90
LBB215_42:                              ## %for.cond66
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	cmpq	%rsi, %rdx
	je	LBB215_13
## %bb.43:                              ## %for.body69
                                        ##   in Loop: Header=BB215_42 Depth=2
	incq	%rsi
	cmpq	$0, (%rcx)
	leaq	72(%rcx), %rcx
	je	LBB215_42
## %bb.44:                              ## %for.body69.if.end74_crit_edge
                                        ##   in Loop: Header=BB215_14 Depth=1
	cmpq	%rax, %rsi
	jae	LBB215_13
	jmp	LBB215_22
LBB215_45:                              ##   in Loop: Header=BB215_14 Depth=1
	xorl	%ebx, %ebx
LBB215_46:                              ## %cleanup135.peel
                                        ##   in Loop: Header=BB215_14 Depth=1
	leaq	-272(%rbp), %r13
	leaq	-72(%rbp), %rdx
	cmpl	$1, %eax
	leaq	L_.str.24.183(%rip), %r15
	je	LBB215_47
## %bb.48:                              ## %cleanup135.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	movl	%ebx, %ebx
	decq	%rax
	addq	$72, %rcx
	.p2align	4, 0x90
LBB215_49:                              ## %cleanup135
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	%rcx, (%r14,%rbx,8)
	incq	%rbx
	addq	$72, %rcx
	decq	%rax
	jne	LBB215_49
## %bb.50:                              ## %for.cond.cleanup123
                                        ##   in Loop: Header=BB215_14 Depth=1
	cmpl	$1, %ebx
	sete	%al
	orb	-56(%rbp), %al                  ## 1-byte Folded Reload
	cmpb	$1, %al
	jne	LBB215_52
LBB215_47:                              ##   in Loop: Header=BB215_14 Depth=1
	leaq	-136(%rbp), %rcx
	jmp	LBB215_58
LBB215_52:                              ## %for.cond149.preheader.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	movl	%r8d, -44(%rbp)                 ## 4-byte Spill
	movl	%esi, -60(%rbp)                 ## 4-byte Spill
	movq	%rbx, -112(%rbp)                ## 8-byte Spill
	movl	%ebx, %eax
	movq	%rax, -144(%rbp)                ## 8-byte Spill
	movl	$1, %eax
	xorl	%r15d, %r15d
	jmp	LBB215_54
	.p2align	4, 0x90
LBB215_53:                              ## %for.cond.cleanup157
                                        ##   in Loop: Header=BB215_54 Depth=2
	movq	-160(%rbp), %rax                ## 8-byte Reload
	incq	%rax
	movq	-152(%rbp), %r15                ## 8-byte Reload
	incq	%r15
	cmpq	-144(%rbp), %rax                ## 8-byte Folded Reload
	je	LBB215_57
LBB215_54:                              ## %for.cond149.preheader
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Loop Header: Depth=2
                                        ##       Child Loop BB215_55 Depth 3
	movq	%rax, -160(%rbp)                ## 8-byte Spill
	movq	%r15, -152(%rbp)                ## 8-byte Spill
	.p2align	4, 0x90
LBB215_55:                              ## %land.rhs
                                        ##   Parent Loop BB215_14 Depth=1
                                        ##     Parent Loop BB215_54 Depth=2
                                        ## =>    This Inner Loop Header: Depth=3
	movl	%r15d, %ebx
	movq	(%r14,%rbx,8), %r12
	movq	8(%r14,%r15,8), %r13
	movq	%r12, %rdi
	movq	%r13, %rsi
	callq	*-120(%rbp)                     ## 8-byte Folded Reload
	testq	%rax, %rax
	jle	LBB215_53
## %bb.56:                              ## %for.body158
                                        ##   in Loop: Header=BB215_55 Depth=3
	movq	%r13, (%r14,%rbx,8)
	movq	%r12, 8(%r14,%r15,8)
	leaq	-1(%r15), %rax
	incq	%r15
	cmpq	$1, %r15
	movq	%rax, %r15
	jg	LBB215_55
	jmp	LBB215_53
LBB215_57:                              ## %if.end176.loopexit
                                        ##   in Loop: Header=BB215_14 Depth=1
	leaq	-272(%rbp), %r13
	movq	-80(%rbp), %rdi                 ## 8-byte Reload
	leaq	L_.str.24.183(%rip), %r15
	leaq	-52(%rbp), %r12
	leaq	-136(%rbp), %rcx
	leaq	-72(%rbp), %rdx
	movl	-60(%rbp), %esi                 ## 4-byte Reload
	movl	-44(%rbp), %r8d                 ## 4-byte Reload
	movq	-112(%rbp), %rbx                ## 8-byte Reload
	.p2align	4, 0x90
LBB215_58:                              ## %if.end176
                                        ##   in Loop: Header=BB215_14 Depth=1
	movq	%r13, -136(%rbp)
	movq	%rdi, -128(%rbp)
	movq	%r13, -240(%rbp)
	movq	%r12, -232(%rbp)
	movq	%rcx, -224(%rbp)
	leaq	-45(%rbp), %rax
	movq	%rax, -216(%rbp)
	movq	%rdx, -208(%rbp)
	movl	%esi, %eax
	orl	%r8d, %eax
	jne	LBB215_62
## %bb.59:                              ## %for.cond182.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	testl	%ebx, %ebx
	leaq	-240(%rbp), %r13
	jle	LBB215_12
## %bb.60:                              ## %for.body185.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	movl	%ebx, %ebx
	xorl	%r15d, %r15d
	.p2align	4, 0x90
LBB215_61:                              ## %for.body185
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%r14,%r15,8), %rsi
	movq	%r13, %rdi
	xorl	%edx, %edx
	callq	__ZZ31halide_profiler_report_unlockedENK3$_3clEP26halide_profiler_func_statsPKc
	incq	%r15
	cmpq	%r15, %rbx
	jne	LBB215_61
	jmp	LBB215_12
	.p2align	4, 0x90
LBB215_62:                              ## %if.else193
                                        ##   in Loop: Header=BB215_14 Depth=1
	movl	%r8d, -44(%rbp)                 ## 4-byte Spill
	movl	%esi, -60(%rbp)                 ## 4-byte Spill
	movq	%r13, -200(%rbp)
	leaq	-46(%rbp), %rax
	movq	%rax, -192(%rbp)
	movq	%r12, -184(%rbp)
	movq	%rcx, -176(%rbp)
	movq	%rdx, -168(%rbp)
	leaq	-200(%rbp), %rdi
	leaq	L_.str.26.185(%rip), %rsi
	movq	-96(%rbp), %rdx                 ## 8-byte Reload
	callq	__ZZ31halide_profiler_report_unlockedENK3$_4clEPKcy
	movl	%ebx, %r12d
	movq	%rbx, -112(%rbp)                ## 8-byte Spill
	testl	%ebx, %ebx
	jle	LBB215_73
## %bb.63:                              ## %for.body198.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	xorl	%ebx, %ebx
	jmp	LBB215_65
	.p2align	4, 0x90
LBB215_64:                              ## %if.end210
                                        ##   in Loop: Header=BB215_65 Depth=2
	incq	%rbx
	cmpq	%rbx, %r12
	je	LBB215_68
LBB215_65:                              ## %for.body198
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%r14,%rbx,8), %r13
	movq	56(%r13), %rdi
	movq	%r15, %rsi
	callq	_strstr
	testq	%rax, %rax
	jne	LBB215_64
## %bb.66:                              ## %land.lhs.true205
                                        ##   in Loop: Header=BB215_65 Depth=2
	movq	56(%r13), %rdi
	leaq	L_.str.25.184(%rip), %rsi
	callq	_strstr
	testq	%rax, %rax
	jne	LBB215_64
## %bb.67:                              ## %if.then209
                                        ##   in Loop: Header=BB215_65 Depth=2
	leaq	-240(%rbp), %rdi
	movq	%r13, %rsi
	xorl	%edx, %edx
	callq	__ZZ31halide_profiler_report_unlockedENK3$_3clEP26halide_profiler_func_statsPKc
	jmp	LBB215_64
LBB215_68:                              ## %for.cond.cleanup197
                                        ##   in Loop: Header=BB215_14 Depth=1
	cmpl	$0, -44(%rbp)                   ## 4-byte Folded Reload
	je	LBB215_75
## %bb.69:                              ## %if.then216
                                        ##   in Loop: Header=BB215_14 Depth=1
	leaq	-200(%rbp), %rdi
	leaq	L_.str.27.186(%rip), %rsi
	movq	-88(%rbp), %rdx                 ## 8-byte Reload
	callq	__ZZ31halide_profiler_report_unlockedENK3$_4clEPKcy
	xorl	%r15d, %r15d
	jmp	LBB215_71
	.p2align	4, 0x90
LBB215_70:                              ## %if.end229
                                        ##   in Loop: Header=BB215_71 Depth=2
	incq	%r15
	cmpq	%r15, %r12
	je	LBB215_75
LBB215_71:                              ## %for.body221
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%r14,%r15,8), %rbx
	movq	56(%rbx), %rdi
	leaq	L_.str.24.183(%rip), %r13
	movq	%r13, %rsi
	callq	_strstr
	testq	%rax, %rax
	je	LBB215_70
## %bb.72:                              ## %if.then228
                                        ##   in Loop: Header=BB215_71 Depth=2
	leaq	-240(%rbp), %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	__ZZ31halide_profiler_report_unlockedENK3$_3clEP26halide_profiler_func_statsPKc
	jmp	LBB215_70
LBB215_73:                              ## %for.cond.cleanup197.thread
                                        ##   in Loop: Header=BB215_14 Depth=1
	cmpl	$0, -44(%rbp)                   ## 4-byte Folded Reload
	je	LBB215_75
## %bb.74:                              ## %if.then216.thread
                                        ##   in Loop: Header=BB215_14 Depth=1
	leaq	-200(%rbp), %rdi
	leaq	L_.str.27.186(%rip), %rsi
	movq	-88(%rbp), %rdx                 ## 8-byte Reload
	callq	__ZZ31halide_profiler_report_unlockedENK3$_4clEPKcy
LBB215_75:                              ## %if.end234
                                        ##   in Loop: Header=BB215_14 Depth=1
	cmpl	$0, -60(%rbp)                   ## 4-byte Folded Reload
	je	LBB215_11
## %bb.76:                              ## %if.then236
                                        ##   in Loop: Header=BB215_14 Depth=1
	leaq	-200(%rbp), %rdi
	leaq	L_.str.28.187(%rip), %rsi
	movq	-104(%rbp), %rdx                ## 8-byte Reload
	callq	__ZZ31halide_profiler_report_unlockedENK3$_4clEPKcy
	cmpl	$0, -112(%rbp)                  ## 4-byte Folded Reload
	jle	LBB215_11
## %bb.77:                              ## %for.body241.preheader
                                        ##   in Loop: Header=BB215_14 Depth=1
	xorl	%r15d, %r15d
	jmp	LBB215_79
	.p2align	4, 0x90
LBB215_78:                              ## %if.end249
                                        ##   in Loop: Header=BB215_79 Depth=2
	incq	%r15
	cmpq	%r15, %r12
	je	LBB215_11
LBB215_79:                              ## %for.body241
                                        ##   Parent Loop BB215_14 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	(%r14,%r15,8), %rbx
	movq	56(%rbx), %rdi
	leaq	L_.str.25.184(%rip), %r13
	movq	%r13, %rsi
	callq	_strstr
	testq	%rax, %rax
	je	LBB215_78
## %bb.80:                              ## %if.then248
                                        ##   in Loop: Header=BB215_79 Depth=2
	leaq	-240(%rbp), %rdi
	movq	%rbx, %rsi
	movq	%r13, %rdx
	callq	__ZZ31halide_profiler_report_unlockedENK3$_3clEP26halide_profiler_func_statsPKc
	jmp	LBB215_78
LBB215_81:                              ## %for.cond.cleanup
	movq	-256(%rbp), %rdi
	callq	__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EED2Ev
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_profiler_reset_unlocked ## -- Begin function halide_profiler_reset_unlocked
	.weak_definition	_halide_profiler_reset_unlocked
	.p2align	4, 0x90
_halide_profiler_reset_unlocked:        ## @halide_profiler_reset_unlocked
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	movq	24(%rdi), %r14
	testq	%r14, %r14
	je	LBB216_3
	.p2align	4, 0x90
LBB216_1:                               ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	64(%r14), %rax
	movq	%rax, 24(%rbx)
	movq	56(%r14), %rdi
	callq	_free
	movq	%r14, %rdi
	callq	_free
	movq	24(%rbx), %r14
	testq	%r14, %r14
	jne	LBB216_1
LBB216_3:                               ## %while.end
	movl	$0, 12(%rbx)
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EEC2EPv
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EEC2EPv: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EEC2EPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movl	$1024, %edi                     ## imm = 0x400
	callq	_malloc
	movl	$1024, %ecx                     ## imm = 0x400
	movq	%rbx, %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	callq	__ZN6Halide7Runtime8Internal11PrinterBaseC2EPvPcy
	cmpq	$0, 16(%rbx)
	je	LBB217_2
## %bb.1:                               ## %if.end
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
LBB217_2:                               ## %if.then
	movq	%rbx, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	__ZNK6Halide7Runtime8Internal11PrinterBase16allocation_errorEv ## TAILCALL
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZZ31halide_profiler_report_unlockedEN3$_18__invokeEP26halide_profiler_func_statsS1_
__ZZ31halide_profiler_report_unlockedEN3$_18__invokeEP26halide_profiler_func_statsS1_: ## @"_ZZ31halide_profiler_report_unlockedEN3$_18__invokeEP26halide_profiler_func_statsS1_"
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	56(%rdi), %rdi
	movq	56(%rsi), %rsi
	callq	_strcmp
	cltq
	popq	%rbp
	retq
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZZ31halide_profiler_report_unlockedEN3$_08__invokeEP26halide_profiler_func_statsS1_
__ZZ31halide_profiler_report_unlockedEN3$_08__invokeEP26halide_profiler_func_statsS1_: ## @"_ZZ31halide_profiler_report_unlockedEN3$_08__invokeEP26halide_profiler_func_statsS1_"
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	(%rsi), %rax
	subq	(%rdi), %rax
	popq	%rbp
	retq
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EED2Ev
__ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EED2Ev: ## @_ZN6Halide7Runtime8Internal12_GLOBAL__N_111HeapPrinterILNS1_11PrinterTypeE2ELy1024EED2Ev
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	jmp	_free                           ## TAILCALL
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBase5clearEv ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBase5clearEv
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBase5clearEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBase5clearEv: ## @_ZN6Halide7Runtime8Internal11PrinterBase5clearEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	16(%rdi), %rax
	movq	%rax, (%rdi)
	testq	%rax, %rax
	je	LBB221_2
## %bb.1:                               ## %if.then
	movb	$0, (%rax)
LBB221_2:                               ## %if.end
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ## -- Begin function _ZZ31halide_profiler_report_unlockedENK3$_3clEP26halide_profiler_func_statsPKc
LCPI222_0:
	.long	1127219200                      ## 0x43300000
	.long	1160773632                      ## 0x45300000
	.long	0                               ## 0x0
	.long	0                               ## 0x0
LCPI222_1:
	.quad	0x4330000000000000              ## double 4503599627370496
	.quad	0x4530000000000000              ## double 1.9342813113834067E+25
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3, 0x0
LCPI222_2:
	.quad	0x3ddb7cdfd9d7bdbb              ## double 1.0E-10
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
__ZZ31halide_profiler_report_unlockedENK3$_3clEP26halide_profiler_func_statsPKc: ## @"_ZZ31halide_profiler_report_unlockedENK3$_3clEP26halide_profiler_func_statsPKc"
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movq	%rdx, %r15
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase5clearEv
	movq	(%rbx), %rdi
	leaq	L_.str.29.199(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	56(%r14), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	testq	%r15, %r15
	je	LBB222_2
## %bb.1:                               ## %if.then
	movq	(%rbx), %r12
	movq	%r15, %rdi
	callq	_strlen
	movq	%r12, %rdi
	movl	%eax, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase5eraseEi
LBB222_2:                               ## %if.end
	movq	(%rbx), %rdi
	leaq	L_.str.30.200(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	8(%rbx), %rax
	movslq	(%rax), %r12
	addq	$7, %r12
	movq	%r12, -48(%rbp)
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jae	LBB222_5
## %bb.3:                               ## %while.body.preheader
	leaq	L_.str.31.191(%rip), %r15
	.p2align	4, 0x90
LBB222_4:                               ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jb	LBB222_4
LBB222_5:                               ## %while.end
	movq	16(%rbx), %rdi
	movq	(%r14), %rsi
	leaq	-48(%rbp), %rdx
	xorl	%ecx, %ecx
	callq	__ZZ31halide_profiler_report_unlockedENK3$_2clEyRmb
	movq	24(%rbx), %rax
	cmpb	$0, (%rax)
	jne	LBB222_9
## %bb.6:                               ## %if.then10
	vmovsd	40(%r14), %xmm0                 ## xmm0 = mem[0],zero
	vmovapd	LCPI222_0(%rip), %xmm1          ## xmm1 = [1127219200,1160773632,0,0]
	vunpcklps	%xmm1, %xmm0, %xmm0     ## xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
	vmovapd	LCPI222_1(%rip), %xmm2          ## xmm2 = [4.503599627370496E+15,1.9342813113834067E+25]
	vsubpd	%xmm2, %xmm0, %xmm0
	vpermilpd	$1, %xmm0, %xmm3        ## xmm3 = xmm0[1,0]
	vaddsd	%xmm0, %xmm3, %xmm0
	vmovsd	48(%r14), %xmm3                 ## xmm3 = mem[0],zero
	vunpcklps	%xmm1, %xmm3, %xmm1     ## xmm1 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
	vsubpd	%xmm2, %xmm1, %xmm1
	vpermilpd	$1, %xmm1, %xmm2        ## xmm2 = xmm1[1,0]
	vaddsd	%xmm1, %xmm2, %xmm1
	vaddsd	LCPI222_2(%rip), %xmm1, %xmm1
	vdivsd	%xmm1, %xmm0, %xmm0
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vmovss	%xmm0, -52(%rbp)                ## 4-byte Spill
	movq	(%rbx), %rdi
	leaq	L_.str.32.201(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	vmovss	-52(%rbp), %xmm0                ## 4-byte Reload
                                        ## xmm0 = mem[0],zero,zero,zero
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	movq	(%rbx), %rdi
	movl	$3, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase5eraseEi
	movq	-48(%rbp), %r12
	addq	$15, %r12
	movq	%r12, -48(%rbp)
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jae	LBB222_9
## %bb.7:                               ## %while.body21.preheader
	leaq	L_.str.31.191(%rip), %r15
	.p2align	4, 0x90
LBB222_8:                               ## %while.body21
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jb	LBB222_8
LBB222_9:                               ## %if.end24
	cmpq	$0, 16(%r14)
	je	LBB222_22
## %bb.10:                              ## %if.then26
	movq	-48(%rbp), %r12
	leaq	15(%r12), %r13
	movq	(%rbx), %rdi
	leaq	L_.str.33.202(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	16(%r14), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r13, %rax
	jae	LBB222_13
## %bb.11:                              ## %while.body34.preheader
	leaq	L_.str.31.191(%rip), %r15
	.p2align	4, 0x90
LBB222_12:                              ## %while.body34
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r13, %rax
	jb	LBB222_12
LBB222_13:                              ## %while.end36
	leaq	L_.str.34.203(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movl	64(%r14), %esi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	addq	$30, %r12
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jae	LBB222_16
## %bb.14:                              ## %while.body43.preheader
	leaq	L_.str.31.191(%rip), %r15
	.p2align	4, 0x90
LBB222_15:                              ## %while.body43
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jb	LBB222_15
LBB222_16:                              ## %while.end45
	movslq	64(%r14), %rcx
	testq	%rcx, %rcx
	je	LBB222_17
## %bb.18:                              ## %if.then48
	movq	24(%r14), %rax
	movq	%rax, %rdx
	orq	%rcx, %rdx
	shrq	$32, %rdx
	je	LBB222_19
## %bb.20:
	xorl	%edx, %edx
	divq	%rcx
	movq	%rax, %r15
	jmp	LBB222_21
LBB222_17:
	xorl	%r15d, %r15d
	jmp	LBB222_21
LBB222_19:
                                        ## kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%ecx
	movl	%eax, %r15d
LBB222_21:                              ## %if.end53
	leaq	L_.str.35.204(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movl	%r15d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
LBB222_22:                              ## %if.end56
	cmpq	$0, 32(%r14)
	je	LBB222_24
## %bb.23:                              ## %if.then58
	movq	(%rbx), %rdi
	leaq	L_.str.36.205(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	32(%r14), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEy
LBB222_24:                              ## %if.end62
	movq	(%rbx), %rdi
	leaq	L_.str.13.172(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rdi
	movq	32(%rbx), %rax
	movq	(%rax), %rbx
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	%rbx, %rdi
	movq	%rax, %rsi
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_print                   ## TAILCALL
                                        ## -- End function
	.p2align	4, 0x90                         ## -- Begin function _ZZ31halide_profiler_report_unlockedENK3$_4clEPKcy
__ZZ31halide_profiler_report_unlockedENK3$_4clEPKcy: ## @"_ZZ31halide_profiler_report_unlockedENK3$_4clEPKcy"
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	movq	(%rdi), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase5clearEv
	movq	(%rbx), %rdi
	leaq	L_.str.41.188(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	8(%rbx), %rax
	cmpb	$0, (%rax)
	je	LBB223_1
## %bb.2:                               ## %if.then
	movq	(%rbx), %rdi
	leaq	L_.str.42.189(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movl	$9, %r12d
	jmp	LBB223_3
LBB223_1:
	xorl	%r12d, %r12d
LBB223_3:                               ## %if.end
	movq	(%rbx), %rdi
	leaq	L_.str.43.190(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	%rax, %rdi
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	leaq	L_.str.31.191(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	16(%rbx), %rax
	movslq	(%rax), %rax
	addq	%rax, %r12
	addq	$7, %r12
	movq	%r12, -40(%rbp)
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jae	LBB223_6
## %bb.4:                               ## %while.body.preheader
	leaq	L_.str.44.192(%rip), %r15
	.p2align	4, 0x90
LBB223_5:                               ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	%r12, %rax
	jb	LBB223_5
LBB223_6:                               ## %while.end
	movq	24(%rbx), %rdi
	leaq	-40(%rbp), %rdx
	movq	%r14, %rsi
	movl	$1, %ecx
	callq	__ZZ31halide_profiler_report_unlockedENK3$_2clEyRmb
	movq	(%rbx), %rdi
	leaq	L_.str.45.193(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	8(%rbx), %rax
	cmpb	$0, (%rax)
	je	LBB223_8
## %bb.7:                               ## %if.then12
	movq	(%rbx), %rdi
	leaq	L_.str.46.194(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
LBB223_8:                               ## %if.end14
	movq	(%rbx), %rdi
	leaq	L_.str.13.172(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rdi
	movq	32(%rbx), %rax
	movq	(%rax), %rbx
	callq	__ZN6Halide7Runtime8Internal11PrinterBase3strEv
	movq	%rbx, %rdi
	movq	%rax, %rsi
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_print                   ## TAILCALL
                                        ## -- End function
	.section	__TEXT,__literal4,4byte_literals
	.p2align	2, 0x0                          ## -- Begin function _ZZ31halide_profiler_report_unlockedENK3$_2clEyRmb
LCPI224_0:
	.long	0x49742400                      ## float 1.0E+6
LCPI224_1:
	.long	0x461c4000                      ## float 1.0E+4
LCPI224_2:
	.long	0x447a0000                      ## float 1000
LCPI224_3:
	.long	0x42c80000                      ## float 100
LCPI224_4:
	.long	0x41200000                      ## float 10
	.section	__TEXT,__text,regular,pure_instructions
	.p2align	4, 0x90
__ZZ31halide_profiler_report_unlockedENK3$_2clEyRmb: ## @"_ZZ31halide_profiler_report_unlockedENK3$_2clEyRmb"
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movl	%ecx, %r15d
	movq	%rdx, %rbx
	movq	%rsi, %r12
	movq	%rdi, %r14
	testq	%rsi, %rsi
	js	LBB224_1
## %bb.2:                               ## %entry
	vcvtsi2ss	%r12, %xmm0, %xmm0
	jmp	LBB224_3
LBB224_1:
	movq	%r12, %rax
	shrq	%rax
	movl	%r12d, %ecx
	andl	$1, %ecx
	orq	%rax, %rcx
	vcvtsi2ss	%rcx, %xmm0, %xmm0
	vaddss	%xmm0, %xmm0, %xmm0
LBB224_3:                               ## %entry
	movq	8(%r14), %rax
	vcvtsi2ssl	80(%rax), %xmm1, %xmm1
	vmulss	LCPI224_0(%rip), %xmm1, %xmm1
	vdivss	%xmm1, %xmm0, %xmm0
	vmovss	LCPI224_1(%rip), %xmm1          ## xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	vmovss	%xmm0, -44(%rbp)                ## 4-byte Spill
	ja	LBB224_4
## %bb.5:                               ## %if.end
	vmovss	LCPI224_2(%rip), %xmm1          ## xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	LBB224_6
LBB224_7:                               ## %if.end6
	vmovss	LCPI224_3(%rip), %xmm1          ## xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	LBB224_8
LBB224_9:                               ## %if.end10
	vmovss	LCPI224_4(%rip), %xmm1          ## xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	LBB224_11
LBB224_10:                              ## %if.then12
	movq	(%r14), %rdi
	leaq	L_.str.31.191(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	vmovss	-44(%rbp), %xmm0                ## 4-byte Reload
                                        ## xmm0 = mem[0],zero,zero,zero
LBB224_11:                              ## %if.end14
	movq	(%r14), %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEf
	movq	(%r14), %rdi
	movl	$3, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBase5eraseEi
	movq	(%r14), %rdi
	leaq	L_.str.37.195(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%rbx), %rax
	addq	$12, %rax
	movq	%rax, (%rbx)
	movq	(%r14), %rdi
	movq	(%rdi), %rcx
	subq	16(%rdi), %rcx
	cmpq	%rax, %rcx
	jae	LBB224_14
## %bb.12:                              ## %while.body.preheader
	leaq	L_.str.31.191(%rip), %r13
	.p2align	4, 0x90
LBB224_13:                              ## %while.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r13, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%r14), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	(%rbx), %rax
	jb	LBB224_13
LBB224_14:                              ## %while.end
	movq	8(%r14), %rax
	movq	(%rax), %rcx
	testq	%rcx, %rcx
	je	LBB224_15
## %bb.16:                              ## %if.end27
	imulq	$1000, %r12, %rax               ## imm = 0x3E8
	movq	%rax, %rdx
	orq	%rcx, %rdx
	shrq	$32, %rdx
	je	LBB224_17
## %bb.18:
	xorl	%edx, %edx
	divq	%rcx
	movq	%rax, %r12
	leaq	L_.str.38.196(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	cmpl	$99, %r12d
	jle	LBB224_20
	jmp	LBB224_21
LBB224_4:                               ## %if.then
	movq	(%r14), %rdi
	leaq	L_.str.31.191(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	vmovss	-44(%rbp), %xmm0                ## 4-byte Reload
                                        ## xmm0 = mem[0],zero,zero,zero
	vmovss	LCPI224_2(%rip), %xmm1          ## xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	LBB224_7
LBB224_6:                               ## %if.then4
	movq	(%r14), %rdi
	leaq	L_.str.31.191(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	vmovss	-44(%rbp), %xmm0                ## 4-byte Reload
                                        ## xmm0 = mem[0],zero,zero,zero
	vmovss	LCPI224_3(%rip), %xmm1          ## xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	jbe	LBB224_9
LBB224_8:                               ## %if.then8
	movq	(%r14), %rdi
	leaq	L_.str.31.191(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	vmovss	-44(%rbp), %xmm0                ## 4-byte Reload
                                        ## xmm0 = mem[0],zero,zero,zero
	vmovss	LCPI224_4(%rip), %xmm1          ## xmm1 = mem[0],zero,zero,zero
	vucomiss	%xmm0, %xmm1
	ja	LBB224_10
	jmp	LBB224_11
LBB224_15:                              ## %if.end27.thread
	leaq	L_.str.38.196(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	xorl	%r12d, %r12d
	jmp	LBB224_20
LBB224_17:
                                        ## kill: def $eax killed $eax killed $rax
	xorl	%edx, %edx
	divl	%ecx
	movl	%eax, %r12d
	leaq	L_.str.38.196(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	cmpl	$99, %r12d
	jg	LBB224_21
LBB224_20:                              ## %if.then30
	movq	(%r14), %rdi
	leaq	L_.str.31.191(%rip), %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
LBB224_21:                              ## %if.end32
	movslq	%r12d, %r12
	imulq	$1717986919, %r12, %r13         ## imm = 0x66666667
	movq	%r13, %rax
	shrq	$63, %rax
	sarq	$34, %r13
	addl	%eax, %r13d
	movq	(%r14), %rdi
	movl	%r13d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.39.197(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	addl	%r13d, %r13d
	leal	(%r13,%r13,4), %ecx
	subl	%ecx, %r12d
	movq	%rax, %rdi
	movl	%r12d, %esi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEi
	leaq	L_.str.40.198(%rip), %rsi
	movq	%rax, %rdi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	testb	%r15b, %r15b
	jne	LBB224_25
## %bb.22:                              ## %if.then39
	movq	(%rbx), %rax
	addq	$10, %rax
	movq	%rax, (%rbx)
	movq	(%r14), %rdi
	movq	(%rdi), %rcx
	subq	16(%rdi), %rcx
	cmpq	%rax, %rcx
	jae	LBB224_25
## %bb.23:                              ## %while.body44.preheader
	leaq	L_.str.31.191(%rip), %r15
	.p2align	4, 0x90
LBB224_24:                              ## %while.body44
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r15, %rsi
	callq	__ZN6Halide7Runtime8Internal11PrinterBaselsEPKc
	movq	(%r14), %rdi
	movq	(%rdi), %rax
	subq	16(%rdi), %rax
	cmpq	(%rbx), %rax
	jb	LBB224_24
LBB224_25:                              ## %if.end47
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal11PrinterBase5eraseEi ## -- Begin function _ZN6Halide7Runtime8Internal11PrinterBase5eraseEi
	.weak_definition	__ZN6Halide7Runtime8Internal11PrinterBase5eraseEi
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal11PrinterBase5eraseEi: ## @_ZN6Halide7Runtime8Internal11PrinterBase5eraseEi
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	LBB225_2
## %bb.1:                               ## %if.then
	movslq	%esi, %rcx
	subq	%rcx, %rax
	movq	16(%rdi), %rcx
	cmpq	%rcx, %rax
	cmovbq	%rcx, %rax
	movq	%rax, (%rdi)
	movb	$0, (%rax)
LBB225_2:                               ## %if.end8
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy ## -- Begin function _ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
	.weak_definition	__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy: ## @_ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdx, %r15
	movl	%esi, %r14d
	movq	%rdi, %r13
	callq	_halide_profiler_get_state
	movq	%rax, %r12
	movq	24(%rax), %rbx
	jmp	LBB226_1
	.p2align	4, 0x90
LBB226_4:                               ## %for.inc
                                        ##   in Loop: Header=BB226_1 Depth=1
	movq	64(%rbx), %rbx
LBB226_1:                               ## %entry
                                        ## =>This Inner Loop Header: Depth=1
	testq	%rbx, %rbx
	je	LBB226_5
## %bb.2:                               ## %for.body
                                        ##   in Loop: Header=BB226_1 Depth=1
	cmpq	%r13, 48(%rbx)
	jne	LBB226_4
## %bb.3:                               ## %land.lhs.true
                                        ##   in Loop: Header=BB226_1 Depth=1
	cmpl	%r14d, 72(%rbx)
	jne	LBB226_4
	jmp	LBB226_13
LBB226_5:                               ## %for.end
	movl	$96, %edi
	callq	_malloc
	testq	%rax, %rax
	je	LBB226_12
## %bb.6:                               ## %if.end7
	movq	%rax, %rbx
	movq	24(%r12), %rax
	movq	%rax, 64(%rbx)
	movq	%r13, 48(%rbx)
	movl	12(%r12), %eax
	movl	%eax, 76(%rbx)
	movl	%r14d, 72(%rbx)
	movq	$0, 80(%rbx)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%ymm0, (%rbx)
	movl	$0, 88(%rbx)
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, 32(%rbx)
	movslq	%r14d, %rax
	shlq	$3, %rax
	leaq	(%rax,%rax,8), %rdi
	vzeroupper
	callq	_malloc
	movq	%rax, 56(%rbx)
	testq	%rax, %rax
	je	LBB226_11
## %bb.7:                               ## %for.cond17.preheader
	testl	%r14d, %r14d
	jle	LBB226_10
## %bb.8:                               ## %for.body20.preheader
	movl	%r14d, %ecx
	addq	$64, %rax
	xorl	%edx, %edx
	vxorps	%xmm0, %xmm0, %xmm0
	vxorps	%xmm1, %xmm1, %xmm1
	.p2align	4, 0x90
LBB226_9:                               ## %for.body20
                                        ## =>This Inner Loop Header: Depth=1
	movq	$0, -64(%rax)
	movq	(%r15,%rdx,8), %rsi
	movq	%rsi, -8(%rax)
	movl	$0, (%rax)
	vmovups	%ymm0, -56(%rax)
	vmovups	%xmm1, -24(%rax)
	incq	%rdx
	addq	$72, %rax
	cmpq	%rdx, %rcx
	jne	LBB226_9
LBB226_10:                              ## %for.cond.cleanup19
	addl	%r14d, 12(%r12)
	movq	%rbx, 24(%r12)
	jmp	LBB226_13
LBB226_11:                              ## %if.then15
	movq	%rbx, %rdi
	callq	_free
LBB226_12:                              ## %cleanup62
	xorl	%ebx, %ebx
LBB226_13:                              ## %cleanup62
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	vzeroupper
	retq
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ## -- Begin function _ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
LCPI227_0:
	.space	8
	.quad	1                               ## 0x1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
	.weak_definition	__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi: ## @_ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	24(%rdi), %r8
	testq	%r8, %r8
	je	LBB227_8
## %bb.1:                               ## %for.body.preheader
	xorl	%r10d, %r10d
	movq	%r8, %r9
	jmp	LBB227_3
	.p2align	4, 0x90
LBB227_2:                               ## %if.end23
                                        ##   in Loop: Header=BB227_3 Depth=1
	movq	64(%rax), %r9
	movq	%rax, %r10
	testq	%r9, %r9
	je	LBB227_8
LBB227_3:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	movq	%r9, %rax
	movslq	76(%r9), %r9
	cmpl	%esi, %r9d
	jg	LBB227_2
## %bb.4:                               ## %land.lhs.true
                                        ##   in Loop: Header=BB227_3 Depth=1
	movl	72(%rax), %r11d
	addl	%r9d, %r11d
	cmpl	%esi, %r11d
	jle	LBB227_2
## %bb.5:                               ## %if.then
	testq	%r10, %r10
	je	LBB227_7
## %bb.6:                               ## %if.then4
	movq	64(%rax), %r11
	movq	%r11, 64(%r10)
	movq	%r8, 64(%rax)
	movq	%rax, 24(%rdi)
LBB227_7:                               ## %if.end
	movslq	%esi, %rsi
	leaq	(%rsi,%rsi,8), %rsi
	shlq	$3, %rsi
	addq	56(%rax), %rsi
	negq	%r9
	leaq	(%r9,%r9,8), %rdi
	addq	%rdx, (%rsi,%rdi,8)
	movslq	%ecx, %rcx
	vmovdqa	LCPI227_0(%rip), %xmm0          ## xmm0 = <u,1>
	vpinsrq	$0, %rcx, %xmm0, %xmm0
	vpaddq	40(%rsi,%rdi,8), %xmm0, %xmm1
	vmovdqu	%xmm1, 40(%rsi,%rdi,8)
	addq	%rdx, (%rax)
	incl	84(%rax)
	vpaddq	32(%rax), %xmm0, %xmm0
	vmovdqu	%xmm0, 32(%rax)
LBB227_8:                               ## %cleanup
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_profiler_sample         ## -- Begin function halide_profiler_sample
	.weak_definition	_halide_profiler_sample
	.p2align	4, 0x90
_halide_profiler_sample:                ## @halide_profiler_sample
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movq	32(%rdi), %rax
	testq	%rax, %rax
	je	LBB228_2
## %bb.1:                               ## %if.then
	leaq	-32(%rbp), %rdi
	leaq	-28(%rbp), %rsi
	callq	*%rax
	jmp	LBB228_3
LBB228_2:                               ## %if.else
	movl	16(%rbx), %eax
	movl	%eax, -32(%rbp)
	movl	20(%rbx), %eax
	movl	%eax, -28(%rbp)
LBB228_3:                               ## %if.end
	xorl	%edi, %edi
	callq	_halide_current_time_ns
	movq	%rax, %r15
	movl	-32(%rbp), %esi
	movl	$-1, %eax
	cmpl	$-2, %esi
	je	LBB228_7
## %bb.4:                               ## %if.else4
	testl	%esi, %esi
	js	LBB228_6
## %bb.5:                               ## %if.then6
	movq	%r15, %rdx
	subq	(%r14), %rdx
	movl	-28(%rbp), %ecx
	movq	%rbx, %rdi
	callq	__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
LBB228_6:                               ## %if.end8
	movq	%r15, (%r14)
	movl	8(%rbx), %eax
LBB228_7:                               ## %cleanup
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	__ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv ## -- Begin function _ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv
	.weak_definition	__ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv: ## @_ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	callq	_halide_profiler_get_state
	movq	%rax, %rbx
	movq	%rax, %rdi
	callq	_halide_mutex_lock
	cmpl	$-2, 16(%rbx)
	jne	LBB229_1
LBB229_6:                               ## %while.end8
	movq	%rbx, %rdi
	callq	_halide_mutex_unlock
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB229_1:                               ## %while.body.preheader
	leaq	-32(%rbp), %r14
	jmp	LBB229_2
	.p2align	4, 0x90
LBB229_5:                               ## %while.end
                                        ##   in Loop: Header=BB229_2 Depth=1
	cmpl	$-2, 16(%rbx)
	je	LBB229_6
LBB229_2:                               ## %while.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB229_4 Depth 2
	xorl	%edi, %edi
	callq	_halide_current_time_ns
	movq	%rax, -32(%rbp)
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	_halide_profiler_sample
	testl	%eax, %eax
	js	LBB229_5
## %bb.3:                               ## %cleanup.preheader
                                        ##   in Loop: Header=BB229_2 Depth=1
	movl	%eax, %r15d
	.p2align	4, 0x90
LBB229_4:                               ## %cleanup
                                        ##   Parent Loop BB229_2 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	movq	%rbx, %rdi
	callq	_halide_mutex_unlock
	xorl	%edi, %edi
	movl	%r15d, %esi
	callq	_halide_sleep_ms
	movq	%rbx, %rdi
	callq	_halide_mutex_lock
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	_halide_profiler_sample
	movl	%eax, %r15d
	testl	%eax, %eax
	jns	LBB229_4
	jmp	LBB229_5
                                        ## -- End function
	.globl	_halide_profiler_get_pipeline_state ## -- Begin function halide_profiler_get_pipeline_state
	.weak_definition	_halide_profiler_get_pipeline_state
	.p2align	4, 0x90
_halide_profiler_get_pipeline_state:    ## @halide_profiler_get_pipeline_state
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
	movq	%rdi, %r15
	callq	_halide_profiler_get_state
	movq	%rax, %rbx
	movq	%rax, %rdi
	callq	_halide_mutex_lock
	movq	24(%rbx), %r14
	testq	%r14, %r14
	je	LBB230_4
	.p2align	4, 0x90
LBB230_2:                               ## %for.body
                                        ## =>This Inner Loop Header: Depth=1
	cmpq	%r15, 48(%r14)
	je	LBB230_5
## %bb.3:                               ## %for.inc
                                        ##   in Loop: Header=BB230_2 Depth=1
	movq	64(%r14), %r14
	testq	%r14, %r14
	jne	LBB230_2
LBB230_4:
	xorl	%r14d, %r14d
LBB230_5:                               ## %cleanup
	movq	%rbx, %rdi
	callq	_halide_mutex_unlock
	movq	%r14, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_profiler_pipeline_start ## -- Begin function halide_profiler_pipeline_start
	.weak_definition	_halide_profiler_pipeline_start
	.p2align	4, 0x90
_halide_profiler_pipeline_start:        ## @halide_profiler_pipeline_start
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rcx, %r15
	movl	%edx, %r12d
	movq	%rsi, %r13
	movq	%rdi, %r14
	callq	_halide_profiler_get_state
	movq	%rax, %rbx
	movq	%rax, %rdi
	callq	_halide_mutex_lock
	cmpq	$0, 40(%rbx)
	jne	LBB231_2
## %bb.1:                               ## %if.then
	movq	%r14, %rdi
	callq	_halide_start_clock
	movq	__ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv@GOTPCREL(%rip), %rdi
	xorl	%esi, %esi
	callq	_halide_spawn_thread
	movq	%rax, 40(%rbx)
LBB231_2:                               ## %if.end
	movq	%r13, %rdi
	movl	%r12d, %esi
	movq	%r15, %rdx
	callq	__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
	testq	%rax, %rax
	je	LBB231_3
## %bb.4:                               ## %if.end8
	incl	80(%rax)
	movl	76(%rax), %r14d
	jmp	LBB231_5
LBB231_3:                               ## %if.then6
	movq	%r14, %rdi
	callq	_halide_error_out_of_memory
	movl	%eax, %r14d
LBB231_5:                               ## %cleanup
	movq	%rbx, %rdi
	callq	_halide_mutex_unlock
	movl	%r14d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_profiler_stack_peak_update ## -- Begin function halide_profiler_stack_peak_update
	.weak_definition	_halide_profiler_stack_peak_update
	.p2align	4, 0x90
_halide_profiler_stack_peak_update:     ## @halide_profiler_stack_peak_update
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdx, %rbx
	movq	%rsi, %r14
	testq	%rsi, %rsi
	je	LBB232_1
## %bb.2:                               ## %do.end
	movl	72(%r14), %edx
	testl	%edx, %edx
	jg	LBB232_3
	jmp	LBB232_11
LBB232_1:                               ## %if.then
	leaq	L_.str.206(%rip), %rsi
	callq	_halide_print
	callq	_abort
	movl	72(%r14), %edx
	testl	%edx, %edx
	jle	LBB232_11
LBB232_3:                               ## %for.body.lr.ph
	xorl	%ecx, %ecx
	jmp	LBB232_4
	.p2align	4, 0x90
LBB232_9:                               ## %for.inc.loopexit
                                        ##   in Loop: Header=BB232_4 Depth=1
	movl	72(%r14), %edx
LBB232_10:                              ## %for.inc
                                        ##   in Loop: Header=BB232_4 Depth=1
	incq	%rcx
	movslq	%edx, %rax
	cmpq	%rax, %rcx
	jge	LBB232_11
LBB232_4:                               ## %for.body
                                        ## =>This Loop Header: Depth=1
                                        ##     Child Loop BB232_7 Depth 2
	movq	(%rbx,%rcx,8), %rsi
	testq	%rsi, %rsi
	je	LBB232_10
## %bb.5:                               ## %if.then3
                                        ##   in Loop: Header=BB232_4 Depth=1
	movq	56(%r14), %rdi
	leaq	(%rcx,%rcx,8), %r8
	movq	32(%rdi,%r8,8), %rax
	cmpq	%rsi, %rax
	jae	LBB232_10
## %bb.6:                               ## %while.body.i.preheader
                                        ##   in Loop: Header=BB232_4 Depth=1
	leaq	(%rdi,%r8,8), %rdx
	addq	$32, %rdx
	.p2align	4, 0x90
LBB232_7:                               ## %while.body.i
                                        ##   Parent Loop BB232_4 Depth=1
                                        ## =>  This Inner Loop Header: Depth=2
	lock		cmpxchgq	%rsi, (%rdx)
	je	LBB232_9
## %bb.8:                               ## %while.body.i
                                        ##   in Loop: Header=BB232_7 Depth=2
	cmpq	%rsi, %rax
	jb	LBB232_7
	jmp	LBB232_9
LBB232_11:                              ## %for.cond.cleanup
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_profiler_memory_allocate ## -- Begin function halide_profiler_memory_allocate
	.weak_definition	_halide_profiler_memory_allocate
	.p2align	4, 0x90
_halide_profiler_memory_allocate:       ## @halide_profiler_memory_allocate
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	testq	%rcx, %rcx
	je	LBB233_14
## %bb.1:                               ## %if.end
	movq	%rcx, %rbx
	movl	%edx, %r15d
	movq	%rsi, %r14
	movq	%rdi, %r12
	testq	%rsi, %rsi
	je	LBB233_2
## %bb.3:                               ## %do.body4
	testl	%r15d, %r15d
	js	LBB233_4
LBB233_5:                               ## %do.body10
	cmpl	%r15d, 72(%r14)
	jg	LBB233_7
LBB233_6:                               ## %if.then12
	leaq	L_.str.3.209(%rip), %rsi
	movq	%r12, %rdi
	callq	_halide_print
	callq	_abort
LBB233_7:                               ## %do.end15
	movq	56(%r14), %rcx
	lock		incl	88(%r14)
	lock		addq	%rbx, 24(%r14)
	movq	%rbx, %rdx
	lock		xaddq	%rdx, 8(%r14)
	movslq	%r15d, %rsi
	addq	%rbx, %rdx
	movq	16(%r14), %rax
	.p2align	4, 0x90
LBB233_8:                               ## %do.end15
                                        ## =>This Inner Loop Header: Depth=1
	cmpq	%rdx, %rax
	jae	LBB233_10
## %bb.9:                               ## %while.body.i
                                        ##   in Loop: Header=BB233_8 Depth=1
	lock		cmpxchgq	%rdx, 16(%r14)
	jne	LBB233_8
LBB233_10:                              ## %_ZN12_GLOBAL__N_125sync_compare_max_and_swapIyEEvPT_S1_.exit
	leaq	(%rsi,%rsi,8), %rsi
	lock		incl	64(%rcx,%rsi,8)
	lock		addq	%rbx, 24(%rcx,%rsi,8)
	movq	%rbx, %rdx
	lock		xaddq	%rdx, 8(%rcx,%rsi,8)
	addq	%rbx, %rdx
	movq	16(%rcx,%rsi,8), %rax
	cmpq	%rdx, %rax
	jae	LBB233_14
## %bb.11:                              ## %while.body.i46.preheader
	leaq	(%rcx,%rsi,8), %rcx
	addq	$16, %rcx
	.p2align	4, 0x90
LBB233_12:                              ## %while.body.i46
                                        ## =>This Inner Loop Header: Depth=1
	lock		cmpxchgq	%rdx, (%rcx)
	je	LBB233_14
## %bb.13:                              ## %while.body.i46
                                        ##   in Loop: Header=BB233_12 Depth=1
	cmpq	%rdx, %rax
	jb	LBB233_12
LBB233_14:                              ## %return
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB233_2:                               ## %if.then2
	leaq	L_.str.1.207(%rip), %rsi
	movq	%r12, %rdi
	callq	_halide_print
	callq	_abort
	testl	%r15d, %r15d
	jns	LBB233_5
LBB233_4:                               ## %if.then6
	leaq	L_.str.2.208(%rip), %rsi
	movq	%r12, %rdi
	callq	_halide_print
	callq	_abort
	cmpl	%r15d, 72(%r14)
	jle	LBB233_6
	jmp	LBB233_7
                                        ## -- End function
	.globl	_halide_profiler_memory_free    ## -- Begin function halide_profiler_memory_free
	.weak_definition	_halide_profiler_memory_free
	.p2align	4, 0x90
_halide_profiler_memory_free:           ## @halide_profiler_memory_free
## %bb.0:                               ## %entry
	testq	%rcx, %rcx
	je	LBB234_8
## %bb.1:                               ## %if.end
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%rcx, %rbx
	movl	%edx, %r15d
	movq	%rsi, %r14
	movq	%rdi, %r12
	testq	%rsi, %rsi
	je	LBB234_2
## %bb.3:                               ## %do.body4
	testl	%r15d, %r15d
	js	LBB234_4
LBB234_5:                               ## %do.body10
	cmpl	%r15d, 72(%r14)
	jg	LBB234_7
LBB234_6:                               ## %if.then12
	leaq	L_.str.6.212(%rip), %rsi
	movq	%r12, %rdi
	callq	_halide_print
	callq	_abort
LBB234_7:                               ## %do.end15
	movq	56(%r14), %rax
	movslq	%r15d, %rcx
	lock		subq	%rbx, 8(%r14)
	leaq	(%rcx,%rcx,8), %rcx
	lock		subq	%rbx, 8(%rax,%rcx,8)
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
LBB234_8:                               ## %return
	retq
LBB234_2:                               ## %if.then2
	leaq	L_.str.4.210(%rip), %rsi
	movq	%r12, %rdi
	callq	_halide_print
	callq	_abort
	testl	%r15d, %r15d
	jns	LBB234_5
LBB234_4:                               ## %if.then6
	leaq	L_.str.5.211(%rip), %rsi
	movq	%r12, %rdi
	callq	_halide_print
	callq	_abort
	cmpl	%r15d, 72(%r14)
	jle	LBB234_6
	jmp	LBB234_7
                                        ## -- End function
	.globl	_halide_profiler_report         ## -- Begin function halide_profiler_report
	.weak_definition	_halide_profiler_report
	.p2align	4, 0x90
_halide_profiler_report:                ## @halide_profiler_report
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	callq	_halide_profiler_get_state
	movq	%rax, %r14
	movq	%rax, %rdi
	callq	_halide_mutex_lock
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	_halide_profiler_report_unlocked
	movq	%r14, %rdi
	popq	%rbx
	popq	%r14
	popq	%rbp
	jmp	_halide_mutex_unlock            ## TAILCALL
                                        ## -- End function
	.globl	_halide_profiler_reset          ## -- Begin function halide_profiler_reset
	.weak_definition	_halide_profiler_reset
	.p2align	4, 0x90
_halide_profiler_reset:                 ## @halide_profiler_reset
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	pushq	%rax
	callq	_halide_profiler_get_state
	movq	%rax, %rbx
	movq	%rax, %rdi
	callq	_halide_mutex_lock
	movq	%rbx, %rdi
	callq	_halide_profiler_reset_unlocked
	movq	%rbx, %rdi
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	jmp	_halide_mutex_unlock            ## TAILCALL
                                        ## -- End function
	.globl	_halide_profiler_pipeline_end   ## -- Begin function halide_profiler_pipeline_end
	.weak_definition	_halide_profiler_pipeline_end
	.p2align	4, 0x90
_halide_profiler_pipeline_end:          ## @halide_profiler_pipeline_end
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$-1, 16(%rsi)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_msan_annotate_memory_is_initialized ## -- Begin function halide_msan_annotate_memory_is_initialized
	.weak_definition	_halide_msan_annotate_memory_is_initialized
	.p2align	4, 0x90
_halide_msan_annotate_memory_is_initialized: ## @halide_msan_annotate_memory_is_initialized
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_msan_check_memory_is_initialized ## -- Begin function halide_msan_check_memory_is_initialized
	.weak_definition	_halide_msan_check_memory_is_initialized
	.p2align	4, 0x90
_halide_msan_check_memory_is_initialized: ## @halide_msan_check_memory_is_initialized
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_msan_check_buffer_is_initialized ## -- Begin function halide_msan_check_buffer_is_initialized
	.weak_definition	_halide_msan_check_buffer_is_initialized
	.p2align	4, 0x90
_halide_msan_check_buffer_is_initialized: ## @halide_msan_check_buffer_is_initialized
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_msan_annotate_buffer_is_initialized ## -- Begin function halide_msan_annotate_buffer_is_initialized
	.weak_definition	_halide_msan_annotate_buffer_is_initialized
	.p2align	4, 0x90
_halide_msan_annotate_buffer_is_initialized: ## @halide_msan_annotate_buffer_is_initialized
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	xorl	%eax, %eax
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_msan_annotate_buffer_is_initialized_as_destructor ## -- Begin function halide_msan_annotate_buffer_is_initialized_as_destructor
	.weak_definition	_halide_msan_annotate_buffer_is_initialized_as_destructor
	.p2align	4, 0x90
_halide_msan_annotate_buffer_is_initialized_as_destructor: ## @halide_msan_annotate_buffer_is_initialized_as_destructor
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_default_can_use_target_features ## -- Begin function halide_default_can_use_target_features
	.weak_definition	_halide_default_can_use_target_features
	.p2align	4, 0x90
_halide_default_can_use_target_features: ## @halide_default_can_use_target_features
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	movq	%rsi, %rbx
	movl	%edi, %r14d
	movq	__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_lock
	movq	__ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE@GOTPCREL(%rip), %r12
	cmpb	$0, (%r12)
	je	LBB243_1
## %bb.2:                               ## %if.end
	movq	__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	cmpl	$2, %r14d
	jne	LBB243_3
LBB243_4:                               ## %if.end2
	movq	__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdx
	andq	(%rbx), %rdx
	jne	LBB243_5
	jmp	LBB243_6
LBB243_1:                               ## %if.then
	leaq	-64(%rbp), %r15
	movq	%r15, %rdi
	callq	__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
	movq	__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPCREL(%rip), %rdi
	movl	$32, %edx
	movq	%r15, %rsi
	callq	_memcpy
	movb	$1, (%r12)
	movq	__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPCREL(%rip), %rdi
	callq	_halide_mutex_unlock
	cmpl	$2, %r14d
	je	LBB243_4
LBB243_3:                               ## %if.then1
	leaq	L_.str.217(%rip), %rsi
	xorl	%edi, %edi
	callq	_halide_error
	movq	__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rdx
	andq	(%rbx), %rdx
	je	LBB243_6
LBB243_5:                               ## %if.then7
	movq	16(%rcx), %rsi
	xorl	%eax, %eax
	andnq	%rdx, %rsi, %rdx
	jne	LBB243_9
LBB243_6:                               ## %if.end14
	movq	8(%rcx), %rdx
	andq	8(%rbx), %rdx
	je	LBB243_8
## %bb.7:                               ## %if.then7.1
	movq	24(%rcx), %rcx
	xorl	%eax, %eax
	andnq	%rdx, %rcx, %rcx
	jne	LBB243_9
LBB243_8:                               ## %if.end14.1
	movl	$1, %eax
LBB243_9:                               ## %cleanup15
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_set_custom_can_use_target_features ## -- Begin function halide_set_custom_can_use_target_features
	.weak_definition	_halide_set_custom_can_use_target_features
	.p2align	4, 0x90
_halide_set_custom_can_use_target_features: ## @halide_set_custom_can_use_target_features
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE@GOTPCREL(%rip), %rcx
	movq	(%rcx), %rax
	movq	%rdi, (%rcx)
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_can_use_target_features ## -- Begin function halide_can_use_target_features
	.weak_definition	_halide_can_use_target_features
	.p2align	4, 0x90
_halide_can_use_target_features:        ## @halide_can_use_target_features
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	movq	__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE@GOTPCREL(%rip), %rax
	movq	(%rax), %rax
	popq	%rbp
	jmpq	*%rax                           ## TAILCALL
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ## -- Begin function _ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
LCPI246_0:
	.quad	12919261627120                  ## 0xbc0000002f0
	.quad	0                               ## 0x0
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
	.weak_definition	__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
	.p2align	4, 0x90
__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv: ## @_ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	pushq	%rbx
	vmovaps	LCPI246_0(%rip), %xmm0          ## xmm0 = [12919261627120,0]
	vmovups	%ymm0, (%rdi)
	movq	$0, -24(%rbp)
	## InlineAsm Start

	xchgq	%rsi, %rbx
	movl	-24(%rbp), %eax
	movl	-20(%rbp), %ecx
	cpuid
	movl	%eax, -24(%rbp)
	movl	%ebx, -20(%rbp)
	movl	%ecx, -16(%rbp)
	movl	%edx, -12(%rbp)
	xchgq	%rsi, %rbx

	## InlineAsm End
	movq	$1, -40(%rbp)
	## InlineAsm Start

	xchgq	%rsi, %rbx
	movl	-40(%rbp), %eax
	movl	-36(%rbp), %ecx
	cpuid
	movl	%eax, -40(%rbp)
	movl	%ebx, -36(%rbp)
	movl	%ecx, -32(%rbp)
	movl	%edx, -28(%rbp)
	xchgq	%rsi, %rbx

	## InlineAsm End
	movl	-40(%rbp), %edx
	movl	%edx, %ecx
	shrl	$8, %ecx
	andl	$15, %ecx
	movl	%edx, %eax
	shrl	$4, %eax
	andl	$15, %eax
	cmpl	$6, %ecx
	je	LBB246_3
## %bb.1:                               ## %entry
	cmpl	$15, %ecx
	jne	LBB246_4
## %bb.2:                               ## %if.then7
	movl	%edx, %ecx
	shrl	$20, %ecx
	movzbl	%cl, %ecx
	addl	$15, %ecx
LBB246_3:                               ## %if.end
	shrl	$12, %edx
	andl	$240, %edx
	orl	%edx, %eax
LBB246_4:                               ## %if.end15
	cmpl	$1752462657, -20(%rbp)          ## imm = 0x68747541
	jne	LBB246_10
## %bb.5:                               ## %if.end15
	cmpl	$1769238117, -12(%rbp)          ## imm = 0x69746E65
	jne	LBB246_10
## %bb.6:                               ## %if.end15
	cmpl	$1145913699, -16(%rbp)          ## imm = 0x444D4163
	jne	LBB246_10
## %bb.7:                               ## %if.then23
	cmpl	$25, %ecx
	jne	LBB246_10
## %bb.8:                               ## %if.then23
	cmpl	$97, %eax
	jne	LBB246_10
## %bb.9:                               ## %if.then27
	movabsq	$7971459302128, %rax            ## imm = 0x740000002F0
	movq	%rax, 16(%rdi)
LBB246_19:                              ## %cleanup
	movq	%rdi, %rax
	popq	%rbx
	popq	%rbp
	vzeroupper
	retq
LBB246_10:                              ## %if.end29
	movl	-32(%rbp), %eax
	movq	%rax, %rcx
	shrq	$15, %rcx
	andl	$16, %ecx
	movq	%rax, %rdx
	shrq	$23, %rdx
	andl	$32, %edx
	orq	%rcx, %rdx
	movq	%rax, %rcx
	shrq	$20, %rcx
	andl	$512, %ecx                      ## imm = 0x200
	orq	%rdx, %rcx
	movq	%rax, %r8
	shrq	$5, %r8
	andl	$128, %r8d
	orq	%rcx, %r8
	testl	$805834752, %eax                ## imm = 0x30081000
	je	LBB246_12
## %bb.11:
	movq	%r8, 16(%rdi)
LBB246_12:
	notl	%eax
	testl	$1879048192, %eax               ## imm = 0x70000000
	jne	LBB246_19
## %bb.13:                              ## %if.then65
	movq	$7, -72(%rbp)
	## InlineAsm Start

	xchgq	%rsi, %rbx
	movl	-72(%rbp), %eax
	movl	-68(%rbp), %ecx
	cpuid
	movl	%eax, -72(%rbp)
	movl	%ebx, -68(%rbp)
	movl	%ecx, -64(%rbp)
	movl	%edx, -60(%rbp)
	xchgq	%rsi, %rbx

	## InlineAsm End
	movl	-68(%rbp), %eax
	testb	$32, %al
	je	LBB246_15
## %bb.14:                              ## %if.then70
	orq	$64, %r8
	movq	%r8, 16(%rdi)
LBB246_15:                              ## %if.end71
	notl	%eax
	testl	$268500992, %eax                ## imm = 0x10010000
	jne	LBB246_19
## %bb.16:                              ## %if.then75
	xorl	%ecx, %ecx
	testl	$469827584, %eax                ## imm = 0x1C010000
	sete	%cl
	shlq	$39, %rcx
	orq	%r8, %rcx
	xorl	%edx, %edx
	testl	$-805109760, %eax               ## imm = 0xD0030000
	sete	%dl
	shlq	$40, %rdx
	orq	%rcx, %rdx
	movabsq	$274877906944, %r8              ## imm = 0x4000000000
	orq	%rdx, %r8
	movq	%r8, 16(%rdi)
	testl	$-803012608, %eax               ## imm = 0xD0230000
	jne	LBB246_19
## %bb.17:                              ## %if.then89
	movabsq	$2199023255552, %rax            ## imm = 0x20000000000
	orq	%r8, %rax
	movq	%rax, 16(%rdi)
	movabsq	$4294967303, %rax               ## imm = 0x100000007
	movq	%rax, -56(%rbp)
	## InlineAsm Start

	xchgq	%rsi, %rbx
	movl	-56(%rbp), %eax
	movl	-52(%rbp), %ecx
	cpuid
	movl	%eax, -56(%rbp)
	movl	%ebx, -52(%rbp)
	movl	%ecx, -48(%rbp)
	movl	%edx, -44(%rbp)
	xchgq	%rsi, %rbx

	## InlineAsm End
	movl	-56(%rbp), %eax
	notl	%eax
	testb	$48, %al
	jne	LBB246_19
## %bb.18:                              ## %if.then98
	movabsq	$10995116277760, %rax           ## imm = 0xA0000000000
	orq	%rax, %r8
	movq	%r8, 16(%rdi)
	movq	%rdi, %rax
	popq	%rbx
	popq	%rbp
	vzeroupper
	retq
                                        ## -- End function
	.globl	_halide_use_jit_module          ## -- Begin function halide_use_jit_module
	.weak_definition	_halide_use_jit_module
	.p2align	4, 0x90
_halide_use_jit_module:                 ## @halide_use_jit_module
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	retq
                                        ## -- End function
	.globl	_halide_release_jit_module      ## -- Begin function halide_release_jit_module
	.weak_definition	_halide_release_jit_module
	.p2align	4, 0x90
_halide_release_jit_module:             ## @halide_release_jit_module
## %bb.0:                               ## %entry
	pushq	%rbp
	movq	%rsp, %rbp
	popq	%rbp
	retq
                                        ## -- End function
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4, 0x0                          ## -- Begin function halide_dotProduct
LCPI249_0:
	.long	0                               ## 0x0
	.long	1                               ## 0x1
	.long	1                               ## 0x1
	.long	0                               ## 0x0
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_dotProduct
	.p2align	4, 0x90
_halide_dotProduct:                     ## @halide_dotProduct
## %bb.0:                               ## %entry
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$232, %rsp
	testq	%rsi, %rsi
	je	LBB249_27
## %bb.1:                               ## %"assert succeeded"
	testq	%rdi, %rdi
	je	LBB249_28
## %bb.2:                               ## %"assert succeeded2"
	movq	%rdx, %rbx
	testq	%rdx, %rdx
	je	LBB249_29
## %bb.3:                               ## %"assert succeeded4"
	movq	16(%rbx), %r11
	movq	24(%rbx), %rax
	movq	%rax, 216(%rsp)                 ## 8-byte Spill
	movl	32(%rbx), %r10d
	movl	36(%rbx), %eax
	movl	%eax, 20(%rsp)                  ## 4-byte Spill
	movq	40(%rbx), %rax
	movl	(%rax), %r13d
	movl	4(%rax), %r15d
	movl	8(%rax), %ecx
	movl	%ecx, 16(%rsp)                  ## 4-byte Spill
	movq	16(%rdi), %r14
	movq	40(%rdi), %rdx
	movl	(%rdx), %r8d
	movl	4(%rdx), %ecx
	movl	8(%rdx), %edx
	movl	%edx, 36(%rsp)                  ## 4-byte Spill
	movq	40(%rsi), %rdx
	movslq	(%rdx), %rbp
	movl	4(%rdx), %r9d
	movq	%r9, 48(%rsp)                   ## 8-byte Spill
	movl	8(%rdx), %r9d
	movq	24(%rdi), %rdx
	movq	%rdx, 224(%rsp)                 ## 8-byte Spill
	movl	32(%rdi), %edx
	movl	%edx, 12(%rsp)                  ## 4-byte Spill
	movl	36(%rdi), %edx
	movl	%edx, 32(%rsp)                  ## 4-byte Spill
	movq	16(%rsi), %r12
	movq	24(%rsi), %rdx
	movq	%rdx, 40(%rsp)                  ## 8-byte Spill
	movl	32(%rsi), %edx
	movl	%edx, 28(%rsp)                  ## 4-byte Spill
	movl	36(%rsi), %edx
	movl	%edx, 24(%rsp)                  ## 4-byte Spill
	movq	%r14, %rdx
	testq	%r11, %r11
	jne	LBB249_5
## %bb.4:                               ## %_halide_buffer_is_bounds_query.exit
	cmpq	$0, (%rbx)
	movq	%r14, %rdx
	je	LBB249_8
LBB249_5:                               ## %after_bb
	testq	%rdx, %rdx
	jne	LBB249_9
LBB249_6:                               ## %_halide_buffer_is_bounds_query.exit95
	cmpq	$0, (%rdi)
	jne	LBB249_9
## %bb.7:                               ## %then_bb6
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, (%rdi)
	movq	$0, 16(%rdi)
	movabsq	$4295041026, %rax               ## imm = 0x100012002
	movq	%rax, 32(%rdi)
	movq	40(%rdi), %rax
	movl	%r8d, (%rax)
	movl	%ecx, 4(%rax)
	movq	$1, 8(%rax)
	movq	$0, 24(%rdi)
	jmp	LBB249_9
LBB249_8:                               ## %then_bb
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, (%rbx)
	movq	$0, 16(%rbx)
	movabsq	$4295041026, %rdx               ## imm = 0x100012002
	movq	%rdx, 32(%rbx)
	vmovaps	LCPI249_0(%rip), %xmm0          ## xmm0 = [0,1,1,0]
	vmovups	%xmm0, (%rax)
	movq	$0, 24(%rbx)
	movq	16(%rdi), %rdx
	testq	%rdx, %rdx
	je	LBB249_6
LBB249_9:                               ## %after_bb5
	cmpq	$0, 16(%rsi)
	je	LBB249_11
LBB249_10:
	xorl	%eax, %eax
	cmpq	$0, 16(%rbx)
	je	LBB249_17
LBB249_13:
	xorl	%edx, %edx
	movl	12(%rsp), %ebx                  ## 4-byte Reload
	cmpq	$0, 16(%rdi)
	je	LBB249_18
LBB249_14:
	xorl	%esi, %esi
	movl	16(%rsp), %edi                  ## 4-byte Reload
	orb	%sil, %al
	orb	%dl, %al
	je	LBB249_19
	jmp	LBB249_24
LBB249_11:                              ## %_halide_buffer_is_bounds_query.exit103
	movq	(%rsi), %rax
	testq	%rax, %rax
	je	LBB249_15
## %bb.12:                              ## %land.rhs.i125
	testq	%rax, %rax
	sete	%al
	cmpq	$0, 16(%rbx)
	jne	LBB249_13
LBB249_17:                              ## %land.rhs.i130
	cmpq	$0, (%rbx)
	sete	%dl
	movl	12(%rsp), %ebx                  ## 4-byte Reload
	cmpq	$0, 16(%rdi)
	jne	LBB249_14
LBB249_18:                              ## %land.rhs.i135
	cmpq	$0, (%rdi)
	sete	%sil
	movl	16(%rsp), %edi                  ## 4-byte Reload
	orb	%sil, %al
	orb	%dl, %al
	jne	LBB249_24
LBB249_19:                              ## %then_bb12
	xorl	%eax, %eax
	movl	%r13d, 68(%rsp)                 ## 4-byte Spill
	movq	%r11, 56(%rsp)                  ## 8-byte Spill
	movl	%r10d, 72(%rsp)                 ## 4-byte Spill
	cmpl	$73730, %r10d                   ## imm = 0x12002
	setne	%al
	movq	%rax, 192(%rsp)                 ## 8-byte Spill
	xorl	%eax, %eax
	cmpl	$1, 20(%rsp)                    ## 4-byte Folded Reload
	setne	%al
	movq	%rax, 184(%rsp)                 ## 8-byte Spill
	xorl	%eax, %eax
	cmpl	$73730, %ebx                    ## imm = 0x12002
	setne	%al
	shlq	$2, %rax
	movq	%rax, 208(%rsp)                 ## 8-byte Spill
	xorl	%esi, %esi
	cmpl	$1, 32(%rsp)                    ## 4-byte Folded Reload
	setne	%sil
	shlq	$3, %rsi
	xorl	%eax, %eax
	cmpl	$73730, 28(%rsp)                ## 4-byte Folded Reload
                                        ## imm = 0x12002
	setne	%al
	shlq	$4, %rax
	movq	%rax, 200(%rsp)                 ## 8-byte Spill
	xorl	%ebx, %ebx
	cmpl	$1, 24(%rsp)                    ## 4-byte Folded Reload
	setne	%bl
	shlq	$5, %rbx
	movq	%r15, %r11
	movq	%r15, 104(%rsp)                 ## 8-byte Spill
	addl	%r13d, %r15d
	setle	%al
	testl	%r13d, %r13d
	setg	%dl
	sets	11(%rsp)                        ## 1-byte Folded Spill
	orb	%al, %dl
	movzbl	%dl, %eax
	shlq	$6, %rax
	movq	%rax, 160(%rsp)                 ## 8-byte Spill
	movq	%r11, %rax
	shrq	$24, %rax
	andl	$-128, %eax
	movq	%rax, 144(%rsp)                 ## 8-byte Spill
	movq	%rcx, %rax
	shrq	$23, %rax
	andl	$256, %eax                      ## imm = 0x100
	movq	%rax, 168(%rsp)                 ## 8-byte Spill
	cmpl	%ebp, %r8d
	setl	%al
	movq	%r8, 96(%rsp)                   ## 8-byte Spill
	leal	(%rcx,%r8), %edx
	movq	%rbp, 88(%rsp)                  ## 8-byte Spill
	movl	%edi, %r10d
	movl	%r9d, %edi
	movq	48(%rsp), %r8                   ## 8-byte Reload
	leal	(%r8,%rbp), %r9d
	movl	%edx, 84(%rsp)                  ## 4-byte Spill
	movl	%r9d, 76(%rsp)                  ## 4-byte Spill
	cmpl	%r9d, %edx
	setg	%dl
	orb	%al, %dl
	movzbl	%dl, %eax
	shlq	$9, %rax
	movq	%rax, 176(%rsp)                 ## 8-byte Spill
	movq	%r8, %rax
	shrq	$21, %rax
	andl	$1024, %eax                     ## imm = 0x400
	movq	%rax, 152(%rsp)                 ## 8-byte Spill
	movq	216(%rsp), %rbp                 ## 8-byte Reload
	xorl	%eax, %eax
	cmpl	$1, %r10d
	setne	%al
	shlq	$11, %rax
	movq	%rax, 120(%rsp)                 ## 8-byte Spill
	xorl	%eax, %eax
	cmpl	$1, 36(%rsp)                    ## 4-byte Folded Reload
	setne	%al
	shlq	$12, %rax
	movq	%rax, 128(%rsp)                 ## 8-byte Spill
	xorl	%eax, %eax
	movl	%edi, 80(%rsp)                  ## 4-byte Spill
	cmpl	$1, %edi
	setne	%al
	shlq	$13, %rax
	movq	%rax, 136(%rsp)                 ## 8-byte Spill
	movq	%r11, %r9
	shrq	$17, %r9
	andl	$16384, %r9d                    ## imm = 0x4000
	movq	%rcx, %r10
	shrq	$16, %r10
	andl	$32768, %r10d                   ## imm = 0x8000
	shrq	$15, %r8
	andl	$65536, %r8d                    ## imm = 0x10000
	movq	%r8, 112(%rsp)                  ## 8-byte Spill
	andl	$2, %ebp
	shlq	$16, %rbp
	movq	224(%rsp), %rdi                 ## 8-byte Reload
	andl	$2, %edi
	shlq	$17, %rdi
	movq	40(%rsp), %r8                   ## 8-byte Reload
	andl	$2, %r8d
	shlq	$18, %r8
	xorl	%eax, %eax
	testq	%r14, %r14
	sete	%al
	shlq	$21, %rax
	xorl	%edx, %edx
	testq	%r12, %r12
	sete	%dl
	shlq	$22, %rdx
	movl	%r15d, 40(%rsp)                 ## 4-byte Spill
	cmpl	$2, %r15d
	setge	%r15b
	orb	11(%rsp), %r15b                 ## 1-byte Folded Reload
	movzbl	%r15b, %r15d
	shlq	$23, %r15
	cmpq	$0, 56(%rsp)                    ## 8-byte Folded Reload
	movabsq	$-9223372036854775808, %r11     ## imm = 0x8000000000000000
	leaq	1048576(%r11), %r13
	cmovneq	%r11, %r13
	orq	%rbp, %r13
	movq	184(%rsp), %r11                 ## 8-byte Reload
	leaq	(,%r11,2), %r11
	addq	%r13, %r11
	addq	192(%rsp), %r11                 ## 8-byte Folded Reload
	addq	144(%rsp), %r11                 ## 8-byte Folded Reload
	addq	120(%rsp), %r11                 ## 8-byte Folded Reload
	orq	%r9, %r11
	orq	160(%rsp), %rax                 ## 8-byte Folded Reload
	orq	%r11, %rax
	orq	%rdi, %r15
	orq	%rax, %r15
	orq	208(%rsp), %rsi                 ## 8-byte Folded Reload
	orq	168(%rsp), %rsi                 ## 8-byte Folded Reload
	orq	128(%rsp), %rsi                 ## 8-byte Folded Reload
	orq	%r10, %rsi
	orq	%rdx, %rsi
	orq	%r8, %rsi
	orq	%r15, %rsi
	orq	200(%rsp), %rbx                 ## 8-byte Folded Reload
	orq	152(%rsp), %rbx                 ## 8-byte Folded Reload
	orq	136(%rsp), %rbx                 ## 8-byte Folded Reload
	orq	112(%rsp), %rbx                 ## 8-byte Folded Reload
	orq	176(%rsp), %rbx                 ## 8-byte Folded Reload
	orq	%rsi, %rbx
	xorl	%eax, %eax
	tzcntq	%rbx, %rax
	cmpl	$23, %eax
	jbe	LBB249_31
## %bb.20:                              ## %"2_produce_sum"
	testl	%ecx, %ecx
	jle	LBB249_33
## %bb.21:                              ## %"1_for_sum.s1.r6$x.rebased.preheader"
	movslq	96(%rsp), %rax                  ## 4-byte Folded Reload
	shlq	$2, %rax
	movq	88(%rsp), %rdx                  ## 8-byte Reload
	shlq	$2, %rdx
	subq	%rdx, %rax
	addq	%rax, %r12
	vxorps	%xmm0, %xmm0, %xmm0
	xorl	%eax, %eax
	movq	56(%rsp), %rdx                  ## 8-byte Reload
	.p2align	4, 0x90
LBB249_22:                              ## %"1_for_sum.s1.r6$x.rebased"
                                        ## =>This Inner Loop Header: Depth=1
	vmovss	(%r12,%rax,4), %xmm1            ## xmm1 = mem[0],zero,zero,zero
	vfmadd231ss	(%r14,%rax,4), %xmm1, %xmm0 ## xmm0 = (xmm1 * mem) + xmm0
	incq	%rax
	cmpq	%rax, %rcx
	jne	LBB249_22
LBB249_23:                              ## %"3_consume_sum"
	vmovss	%xmm0, (%rdx)
LBB249_24:                              ## %common.ret
	xorl	%eax, %eax
LBB249_25:                              ## %common.ret
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
LBB249_15:                              ## %then_bb9
	vxorps	%xmm0, %xmm0, %xmm0
	vmovups	%xmm0, (%rsi)
	movq	$0, 16(%rsi)
	movabsq	$4295041026, %rax               ## imm = 0x100012002
	movq	%rax, 32(%rsi)
	movq	40(%rsi), %rax
	movl	%r8d, (%rax)
	movl	%ecx, 4(%rax)
	movq	$1, 8(%rax)
	movq	$0, 24(%rsi)
	cmpq	$0, 16(%rsi)
	jne	LBB249_10
## %bb.26:                              ## %then_bb9.land.rhs.i125_crit_edge
	movq	(%rsi), %rax
	testq	%rax, %rax
	sete	%al
	cmpq	$0, 16(%rbx)
	jne	LBB249_13
	jmp	LBB249_17
LBB249_27:                              ## %"assert failed"
	leaq	l_str.220(%rip), %rsi
	jmp	LBB249_30
LBB249_28:                              ## %"assert failed1"
	leaq	l_str(%rip), %rsi
	jmp	LBB249_30
LBB249_29:                              ## %"assert failed3"
	leaq	l_str.221(%rip), %rsi
LBB249_30:                              ## %"assert failed"
	xorl	%edi, %edi
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_buffer_argument_is_null ## TAILCALL
LBB249_31:                              ## %then_bb12
	movl	76(%rsp), %ebp                  ## 4-byte Reload
	movl	84(%rsp), %ebx                  ## 4-byte Reload
	movl	40(%rsp), %edi                  ## 4-byte Reload
	movl	80(%rsp), %r11d                 ## 4-byte Reload
	movl	20(%rsp), %r10d                 ## 4-byte Reload
	movl	72(%rsp), %edx                  ## 4-byte Reload
	movq	104(%rsp), %r8                  ## 8-byte Reload
	movl	68(%rsp), %r9d                  ## 4-byte Reload
	leaq	LJTI249_0(%rip), %rsi
	movslq	(%rsi,%rax,4), %rax
	addq	%rsi, %rax
	jmpq	*%rax
LBB249_32:                              ## %assert_failed
	leaq	l_str.224(%rip), %rsi
	xorl	%edi, %edi
	jmp	LBB249_38
LBB249_33:
	vxorps	%xmm0, %xmm0, %xmm0
	movq	56(%rsp), %rdx                  ## 8-byte Reload
	jmp	LBB249_23
LBB249_34:                              ## %assert_failed14
	leaq	l_str.224(%rip), %rsi
	xorl	%edi, %edi
	movl	%r10d, %edx
	jmp	LBB249_40
LBB249_35:                              ## %assert_failed15
	leaq	l_str.225(%rip), %rsi
	xorl	%edi, %edi
	movl	12(%rsp), %edx                  ## 4-byte Reload
	jmp	LBB249_38
LBB249_36:                              ## %assert_failed16
	leaq	l_str.225(%rip), %rsi
	xorl	%edi, %edi
	movl	32(%rsp), %edx                  ## 4-byte Reload
	jmp	LBB249_40
LBB249_37:                              ## %assert_failed17
	leaq	l_str.226(%rip), %rsi
	xorl	%edi, %edi
	movl	28(%rsp), %edx                  ## 4-byte Reload
LBB249_38:                              ## %assert_failed
	movl	$73730, %ecx                    ## imm = 0x12002
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_bad_type          ## TAILCALL
LBB249_39:                              ## %assert_failed18
	leaq	l_str.226(%rip), %rsi
	xorl	%edi, %edi
	movl	24(%rsp), %edx                  ## 4-byte Reload
LBB249_40:                              ## %assert_failed14
	movl	$1, %ecx
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_bad_dimensions    ## TAILCALL
LBB249_41:                              ## %assert_failed19
	decl	%edi
	movl	%edi, (%rsp)
	leaq	l_str.224(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	_halide_error_access_out_of_bounds
	jmp	LBB249_25
LBB249_42:                              ## %assert_failed20
	leaq	l_str.224(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	movl	%r8d, %ecx
	jmp	LBB249_47
LBB249_43:                              ## %assert_failed21
	leaq	l_str.225(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	jmp	LBB249_46
LBB249_44:                              ## %assert_failed22
	movl	%ebx, %r8d
	decl	%r8d
	decl	%ebp
	movl	%ebp, (%rsp)
	leaq	l_str.226(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	movq	96(%rsp), %rcx                  ## 8-byte Reload
                                        ## kill: def $ecx killed $ecx killed $rcx
	movq	88(%rsp), %r9                   ## 8-byte Reload
                                        ## kill: def $r9d killed $r9d killed $r9
	callq	_halide_error_access_out_of_bounds
	jmp	LBB249_25
LBB249_45:                              ## %assert_failed23
	leaq	l_str.226(%rip), %rsi
	xorl	%edi, %edi
	xorl	%edx, %edx
	movq	48(%rsp), %rcx                  ## 8-byte Reload
LBB249_46:                              ## %assert_failed21
                                        ## kill: def $ecx killed $ecx killed $rcx
LBB249_47:                              ## %assert_failed21
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_buffer_extents_negative ## TAILCALL
LBB249_48:                              ## %assert_failed24
	leaq	l_str.227(%rip), %rsi
	leaq	l_str.228(%rip), %rcx
	xorl	%edi, %edi
	movl	16(%rsp), %edx                  ## 4-byte Reload
	jmp	LBB249_51
LBB249_49:                              ## %assert_failed25
	leaq	l_str.229(%rip), %rsi
	leaq	l_str.228(%rip), %rcx
	xorl	%edi, %edi
	movl	36(%rsp), %edx                  ## 4-byte Reload
	jmp	LBB249_51
LBB249_50:                              ## %assert_failed26
	leaq	l_str.230(%rip), %rsi
	leaq	l_str.228(%rip), %rcx
	xorl	%edi, %edi
	movl	%r11d, %edx
LBB249_51:                              ## %assert_failed26
	movl	$1, %r8d
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_constraint_violated ## TAILCALL
LBB249_52:                              ## %assert_failed27
	movslq	%r8d, %rdx
	leaq	l_str.221(%rip), %rsi
	jmp	LBB249_55
LBB249_53:                              ## %assert_failed28
	movslq	%ecx, %rdx
	leaq	l_str(%rip), %rsi
	jmp	LBB249_55
LBB249_54:                              ## %assert_failed29
	movslq	48(%rsp), %rdx                  ## 4-byte Folded Reload
	leaq	l_str.220(%rip), %rsi
LBB249_55:                              ## %assert_failed27
	movl	$2147483647, %ecx               ## imm = 0x7FFFFFFF
	xorl	%edi, %edi
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_buffer_allocation_too_large ## TAILCALL
LBB249_56:                              ## %assert_failed30
	leaq	l_str.224(%rip), %rsi
	jmp	LBB249_59
LBB249_57:                              ## %assert_failed31
	leaq	l_str.225(%rip), %rsi
	jmp	LBB249_59
LBB249_58:                              ## %assert_failed32
	leaq	l_str.226(%rip), %rsi
LBB249_59:                              ## %assert_failed30
	xorl	%edi, %edi
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_device_dirty_with_no_device_support ## TAILCALL
LBB249_60:                              ## %assert_failed33
	leaq	l_str.224(%rip), %rsi
	jmp	LBB249_63
LBB249_61:                              ## %assert_failed34
	leaq	l_str.225(%rip), %rsi
	jmp	LBB249_63
LBB249_62:                              ## %assert_failed35
	leaq	l_str.226(%rip), %rsi
LBB249_63:                              ## %assert_failed33
	xorl	%edi, %edi
	addq	$232, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	_halide_error_host_is_null      ## TAILCALL
LBB249_64:                              ## %assert_failed36
	decl	%edi
	movl	%edi, (%rsp)
	leaq	l_str.231(%rip), %rsi
	leaq	l_str.221(%rip), %rdx
	xorl	%edi, %edi
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	_halide_error_explicit_bounds_too_small
	jmp	LBB249_25
	.p2align	2, 0x90
	.data_region jt32
.set L249_0_set_32, LBB249_32-LJTI249_0
.set L249_0_set_34, LBB249_34-LJTI249_0
.set L249_0_set_35, LBB249_35-LJTI249_0
.set L249_0_set_36, LBB249_36-LJTI249_0
.set L249_0_set_37, LBB249_37-LJTI249_0
.set L249_0_set_39, LBB249_39-LJTI249_0
.set L249_0_set_41, LBB249_41-LJTI249_0
.set L249_0_set_42, LBB249_42-LJTI249_0
.set L249_0_set_43, LBB249_43-LJTI249_0
.set L249_0_set_44, LBB249_44-LJTI249_0
.set L249_0_set_45, LBB249_45-LJTI249_0
.set L249_0_set_48, LBB249_48-LJTI249_0
.set L249_0_set_49, LBB249_49-LJTI249_0
.set L249_0_set_50, LBB249_50-LJTI249_0
.set L249_0_set_52, LBB249_52-LJTI249_0
.set L249_0_set_53, LBB249_53-LJTI249_0
.set L249_0_set_54, LBB249_54-LJTI249_0
.set L249_0_set_56, LBB249_56-LJTI249_0
.set L249_0_set_57, LBB249_57-LJTI249_0
.set L249_0_set_58, LBB249_58-LJTI249_0
.set L249_0_set_60, LBB249_60-LJTI249_0
.set L249_0_set_61, LBB249_61-LJTI249_0
.set L249_0_set_62, LBB249_62-LJTI249_0
.set L249_0_set_64, LBB249_64-LJTI249_0
LJTI249_0:
	.long	L249_0_set_32
	.long	L249_0_set_34
	.long	L249_0_set_35
	.long	L249_0_set_36
	.long	L249_0_set_37
	.long	L249_0_set_39
	.long	L249_0_set_41
	.long	L249_0_set_42
	.long	L249_0_set_43
	.long	L249_0_set_44
	.long	L249_0_set_45
	.long	L249_0_set_48
	.long	L249_0_set_49
	.long	L249_0_set_50
	.long	L249_0_set_52
	.long	L249_0_set_53
	.long	L249_0_set_54
	.long	L249_0_set_56
	.long	L249_0_set_57
	.long	L249_0_set_58
	.long	L249_0_set_60
	.long	L249_0_set_61
	.long	L249_0_set_62
	.long	L249_0_set_64
	.end_data_region
                                        ## -- End function
	.globl	_halide_dotProduct_argv         ## -- Begin function halide_dotProduct_argv
	.p2align	4, 0x90
_halide_dotProduct_argv:                ## @halide_dotProduct_argv
## %bb.0:                               ## %entry
	movq	(%rdi), %rax
	movq	8(%rdi), %rsi
	movq	16(%rdi), %rdx
	movq	%rax, %rdi
	jmp	_halide_dotProduct              ## TAILCALL
                                        ## -- End function
	.globl	_halide_dotProduct_metadata     ## -- Begin function halide_dotProduct_metadata
	.p2align	4, 0x90
_halide_dotProduct_metadata:            ## @halide_dotProduct_metadata
## %bb.0:                               ## %entry
	leaq	l_halide_dotProduct_metadata_storage(%rip), %rax
	retq
                                        ## -- End function
	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal13custom_mallocE ## @_ZN6Halide7Runtime8Internal13custom_mallocE
	.weak_definition	__ZN6Halide7Runtime8Internal13custom_mallocE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal13custom_mallocE:
	.quad	_halide_default_malloc

	.globl	__ZN6Halide7Runtime8Internal11custom_freeE ## @_ZN6Halide7Runtime8Internal11custom_freeE
	.weak_definition	__ZN6Halide7Runtime8Internal11custom_freeE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal11custom_freeE:
	.quad	_halide_default_free

	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"Error: "

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal13error_handlerE ## @_ZN6Halide7Runtime8Internal13error_handlerE
	.weak_definition	__ZN6Halide7Runtime8Internal13error_handlerE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal13error_handlerE:
	.quad	_halide_default_error

	.globl	__ZN6Halide7Runtime8Internal12custom_printE ## @_ZN6Halide7Runtime8Internal12custom_printE
	.weak_definition	__ZN6Halide7Runtime8Internal12custom_printE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal12custom_printE:
	.quad	_halide_default_print

	.globl	__ZN6Halide7Runtime8Internal29halide_reference_clock_initedE ## @_ZN6Halide7Runtime8Internal29halide_reference_clock_initedE
	.weak_definition	__ZN6Halide7Runtime8Internal29halide_reference_clock_initedE
__ZN6Halide7Runtime8Internal29halide_reference_clock_initedE:
	.byte	0                               ## 0x0

	.globl	__ZN6Halide7Runtime8Internal22halide_reference_clockE ## @_ZN6Halide7Runtime8Internal22halide_reference_clockE
	.weak_definition	__ZN6Halide7Runtime8Internal22halide_reference_clockE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal22halide_reference_clockE:
	.quad	0                               ## 0x0

	.globl	__ZN6Halide7Runtime8Internal20halide_timebase_infoE ## @_ZN6Halide7Runtime8Internal20halide_timebase_infoE
	.weak_definition	__ZN6Halide7Runtime8Internal20halide_timebase_infoE
	.p2align	2, 0x0
__ZN6Halide7Runtime8Internal20halide_timebase_infoE:
	.space	8

	.section	__DATA,__mod_term_func,mod_term_funcs
	.p2align	3, 0x0
	.quad	_halide_thread_pool_cleanup
	.quad	_halide_trace_cleanup
	.quad	_halide_cache_cleanup
	.quad	_halide_profiler_shutdown
	.section	__TEXT,__cstring,cstring_literals
L_.str.5:                               ## @.str.5
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/synchronization_common.h:251 halide_abort_if_false() failed: next != nullptr\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal15Synchronization5tableE ## @_ZN6Halide7Runtime8Internal15Synchronization5tableE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization5tableE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal15Synchronization5tableE:
	.space	24576

	.section	__TEXT,__cstring,cstring_literals
L_.str.1.7:                             ## @.str.1.7
	.asciz	"HL_NUM_THREADS"

L_.str.2:                               ## @.str.2
	.asciz	"HL_NUMTHREADS"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal10work_queueE ## @_ZN6Halide7Runtime8Internal10work_queueE
	.weak_definition	__ZN6Halide7Runtime8Internal10work_queueE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal10work_queueE:
	.space	8
	.long	0                               ## 0x0
	.long	0                               ## 0x0
	.quad	0
	.long	0                               ## 0x0
	.long	0                               ## 0x0
	.long	0                               ## 0x0
	.space	4
	.space	8
	.space	8
	.space	8
	.long	0                               ## 0x0
	.long	0                               ## 0x0
	.space	2048
	.byte	0                               ## 0x0
	.byte	0                               ## 0x0
	.space	2
	.long	0                               ## 0x0

	.section	__TEXT,__cstring,cstring_literals
L_.str.3:                               ## @.str.3
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/thread_pool_common.h:527 halide_abort_if_false() failed: (min_threads <= ((task_parent->task.min_threads * task_parent->active_workers) - task_parent->threads_reserved)) && \"Logic error: thread over commit.\\n\"\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal14custom_do_taskE ## @_ZN6Halide7Runtime8Internal14custom_do_taskE
	.weak_definition	__ZN6Halide7Runtime8Internal14custom_do_taskE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal14custom_do_taskE:
	.quad	_halide_default_do_task

	.globl	__ZN6Halide7Runtime8Internal19custom_do_loop_taskE ## @_ZN6Halide7Runtime8Internal19custom_do_loop_taskE
	.weak_definition	__ZN6Halide7Runtime8Internal19custom_do_loop_taskE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal19custom_do_loop_taskE:
	.quad	_halide_default_do_loop_task

	.globl	__ZN6Halide7Runtime8Internal17custom_do_par_forE ## @_ZN6Halide7Runtime8Internal17custom_do_par_forE
	.weak_definition	__ZN6Halide7Runtime8Internal17custom_do_par_forE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal17custom_do_par_forE:
	.quad	_halide_default_do_par_for

	.globl	__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE ## @_ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE
	.weak_definition	__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE:
	.quad	_halide_default_do_parallel_tasks

	.globl	__ZN6Halide7Runtime8Internal21custom_semaphore_initE ## @_ZN6Halide7Runtime8Internal21custom_semaphore_initE
	.weak_definition	__ZN6Halide7Runtime8Internal21custom_semaphore_initE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal21custom_semaphore_initE:
	.quad	_halide_default_semaphore_init

	.globl	__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE ## @_ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE
	.weak_definition	__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE:
	.quad	_halide_default_semaphore_try_acquire

	.globl	__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE ## @_ZN6Halide7Runtime8Internal24custom_semaphore_releaseE
	.weak_definition	__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE:
	.quad	_halide_default_semaphore_release

	.section	__TEXT,__cstring,cstring_literals
L_.str.4:                               ## @.str.4
	.asciz	"halide_set_num_threads: must be >= 0."

	.section	__DATA,__const
	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE ## @_ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE
	.weak_definition	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE
	.p2align	3, 0x0
__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE ## @_ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE
	.weak_definition	__ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE
	.p2align	3, 0x0
__ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE ## @_ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE
	.weak_definition	__ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE
	.p2align	3, 0x0
__ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.section	__TEXT,__cstring,cstring_literals
L_.str.5.6:                             ## @.str.5.6
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/synchronization_common.h:859 halide_abort_if_false() failed: val & 0x1\n"

	.section	__DATA,__const
	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE ## @_ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE
	.weak_definition	__ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE
	.p2align	3, 0x0
__ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.section	__TEXT,__cstring,cstring_literals
L_.str.6:                               ## @.str.6
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/thread_pool_common.h:155 halide_abort_if_false() failed: bytes == limit && \"Logic error in thread pool work queue initialization.\\n\"\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal17custom_get_symbolE ## @_ZN6Halide7Runtime8Internal17custom_get_symbolE
	.weak_definition	__ZN6Halide7Runtime8Internal17custom_get_symbolE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal17custom_get_symbolE:
	.quad	_halide_default_get_symbol

	.globl	__ZN6Halide7Runtime8Internal19custom_load_libraryE ## @_ZN6Halide7Runtime8Internal19custom_load_libraryE
	.weak_definition	__ZN6Halide7Runtime8Internal19custom_load_libraryE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal19custom_load_libraryE:
	.quad	_halide_default_load_library

	.globl	__ZN6Halide7Runtime8Internal25custom_get_library_symbolE ## @_ZN6Halide7Runtime8Internal25custom_get_library_symbolE
	.weak_definition	__ZN6Halide7Runtime8Internal25custom_get_library_symbolE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal25custom_get_library_symbolE:
	.quad	_halide_default_get_library_symbol

	.globl	__ZN6Halide7Runtime8Internal17halide_gpu_deviceE ## @_ZN6Halide7Runtime8Internal17halide_gpu_deviceE
	.weak_definition	__ZN6Halide7Runtime8Internal17halide_gpu_deviceE
	.p2align	2, 0x0
__ZN6Halide7Runtime8Internal17halide_gpu_deviceE:
	.long	0                               ## 0x0

	.globl	__ZN6Halide7Runtime8Internal22halide_gpu_device_lockE ## @_ZN6Halide7Runtime8Internal22halide_gpu_device_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal22halide_gpu_device_lockE
__ZN6Halide7Runtime8Internal22halide_gpu_device_lockE:
	.byte	0                               ## 0x0

	.globl	__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE ## @_ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE
	.weak_definition	__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE
__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE:
	.byte	0                               ## 0x0

	.section	__TEXT,__cstring,cstring_literals
L_.str.10:                              ## @.str.10
	.asciz	"HL_GPU_DEVICE"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal19halide_trace_bufferE ## @_ZN6Halide7Runtime8Internal19halide_trace_bufferE
	.weak_definition	__ZN6Halide7Runtime8Internal19halide_trace_bufferE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal19halide_trace_bufferE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal17halide_trace_fileE ## @_ZN6Halide7Runtime8Internal17halide_trace_fileE
	.weak_definition	__ZN6Halide7Runtime8Internal17halide_trace_fileE
	.p2align	2, 0x0
__ZN6Halide7Runtime8Internal17halide_trace_fileE:
	.long	4294967295                      ## 0xffffffff

	.globl	__ZN6Halide7Runtime8Internal22halide_trace_file_lockE ## @_ZN6Halide7Runtime8Internal22halide_trace_file_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal22halide_trace_file_lockE
__ZN6Halide7Runtime8Internal22halide_trace_file_lockE:
	.byte	0                               ## 0x0

	.globl	__ZN6Halide7Runtime8Internal29halide_trace_file_initializedE ## @_ZN6Halide7Runtime8Internal29halide_trace_file_initializedE
	.weak_definition	__ZN6Halide7Runtime8Internal29halide_trace_file_initializedE
__ZN6Halide7Runtime8Internal29halide_trace_file_initializedE:
	.byte	0                               ## 0x0

	.globl	__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE ## @_ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE
	.weak_definition	__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE:
	.quad	0

	.p2align	2, 0x0                          ## @_ZZ20halide_default_traceE3ids
__ZZ20halide_default_traceE3ids:
	.long	1                               ## 0x1

	.section	__TEXT,__cstring,cstring_literals
L_.str.1.12:                            ## @.str.1.12
	.space	1

L_.str.2.13:                            ## @.str.2.13
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/tracing.cpp:238 halide_abort_if_false() failed: print_bits <= 64 && \"Tracing bad type\"\n"

L_.str.3.14:                            ## @.str.3.14
	.asciz	"Load"

L_.str.4.15:                            ## @.str.4.15
	.asciz	"Store"

L_.str.5.16:                            ## @.str.5.16
	.asciz	"Begin realization"

L_.str.6.17:                            ## @.str.6.17
	.asciz	"End realization"

L_.str.7:                               ## @.str.7
	.asciz	"Produce"

L_.str.8:                               ## @.str.8
	.asciz	"End produce"

L_.str.9:                               ## @.str.9
	.asciz	"Consume"

L_.str.10.18:                           ## @.str.10.18
	.asciz	"End consume"

L_.str.11.19:                           ## @.str.11.19
	.asciz	"Begin pipeline"

L_.str.12:                              ## @.str.12
	.asciz	"End pipeline"

L_.str.13:                              ## @.str.13
	.asciz	"Tag"

	.section	__TEXT,__const
	.p2align	2, 0x0                          ## @reltable.halide_default_trace
l_reltable.halide_default_trace:
	.long	L_.str.3.14-l_reltable.halide_default_trace
	.long	L_.str.4.15-l_reltable.halide_default_trace
	.long	L_.str.5.16-l_reltable.halide_default_trace
	.long	L_.str.6.17-l_reltable.halide_default_trace
	.long	L_.str.7-l_reltable.halide_default_trace
	.long	L_.str.8-l_reltable.halide_default_trace
	.long	L_.str.9-l_reltable.halide_default_trace
	.long	L_.str.10.18-l_reltable.halide_default_trace
	.long	L_.str.11.19-l_reltable.halide_default_trace
	.long	L_.str.12-l_reltable.halide_default_trace
	.long	L_.str.13-l_reltable.halide_default_trace

	.section	__TEXT,__cstring,cstring_literals
L_.str.17:                              ## @.str.17
	.asciz	"<"

L_.str.18:                              ## @.str.18
	.asciz	">, <"

L_.str.20:                              ## @.str.20
	.asciz	">)"

L_.str.22:                              ## @.str.22
	.asciz	" = <"

L_.str.23:                              ## @.str.23
	.asciz	" = "

L_.str.24:                              ## @.str.24
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/tracing.cpp:307 halide_abort_if_false() failed: print_bits >= 16 && \"Tracing a bad type\"\n"

L_.str.25:                              ## @.str.25
	.asciz	">"

L_.str.26:                              ## @.str.26
	.asciz	" tag = \""

L_.str.27:                              ## @.str.27
	.asciz	"\""

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal19halide_custom_traceE ## @_ZN6Halide7Runtime8Internal19halide_custom_traceE
	.weak_definition	__ZN6Halide7Runtime8Internal19halide_custom_traceE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal19halide_custom_traceE:
	.quad	_halide_default_trace

	.section	__TEXT,__cstring,cstring_literals
L_.str.28:                              ## @.str.28
	.asciz	"HL_TRACE_FILE"

L_.str.29:                              ## @.str.29
	.asciz	"ab"

L_.str.30:                              ## @.str.30
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/tracing.cpp:371 halide_abort_if_false() failed: file && \"Failed to open trace file\\n\"\n"

L_.str.31:                              ## @.str.31
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/tracing.cpp:103 halide_abort_if_false() failed: size <= buffer_size\n"

L_.str.32:                              ## @.str.32
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/tracing.cpp:131 halide_abort_if_false() failed: success && \"Could not write to trace file\"\n"

L_.str.33:                              ## @.str.33
	.asciz	"Printer buffer allocation failed.\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE ## @_ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE
	.weak_definition	__ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE
	.p2align	1, 0x0
__ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE:
	.short	3                               ## 0x3
	.short	3                               ## 0x3
	.short	1                               ## 0x1
	.short	2                               ## 0x2
	.short	1                               ## 0x1
	.short	2                               ## 0x2
	.short	1                               ## 0x1
	.short	2                               ## 0x2
	.short	1                               ## 0x1
	.short	2                               ## 0x2

	.globl	__ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE ## @_ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE
	.weak_definition	__ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE
__ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE:
	.ascii	"\007\006\t\b\013\n\r\f\017\016"

	.globl	__ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE ## @_ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE
	.weak_definition	__ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE
__ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE:
	.ascii	"\007\t\002\001\004\003\006\005\r\f"

	.section	__TEXT,__cstring,cstring_literals
L_.str.34:                              ## @.str.34
	.asciz	"Bounds query buffer passed to halide_debug_to_file"

L_.str.1.35:                            ## @.str.1.35
	.asciz	"Can't debug_to_file a Func with more than four dimensions\n"

L_.str.2.36:                            ## @.str.2.36
	.asciz	"wb"

L_.str.3.37:                            ## @.str.3.37
	.asciz	".tiff"

L_.str.4.38:                            ## @.str.4.38
	.asciz	".tif"

L_.str.5.39:                            ## @.str.5.39
	.asciz	".mat"

	.section	__TEXT,__const
l___const.halide_debug_to_file.header:  ## @__const.halide_debug_to_file.header
	.asciz	"MATLAB 5.0 MAT-file, produced by Halide                                                                                     \000\001IM"

	.section	__TEXT,__cstring,cstring_literals
L_.str.6.40:                            ## @.str.6.40
	.asciz	"Can't debug_to_file to a .mat file greater than 4GB\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal16memoization_lockE ## @_ZN6Halide7Runtime8Internal16memoization_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal16memoization_lockE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal16memoization_lockE:
	.space	8

	.globl	__ZN6Halide7Runtime8Internal13cache_entriesE ## @_ZN6Halide7Runtime8Internal13cache_entriesE
	.weak_definition	__ZN6Halide7Runtime8Internal13cache_entriesE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal13cache_entriesE:
	.space	2048

	.globl	__ZN6Halide7Runtime8Internal18most_recently_usedE ## @_ZN6Halide7Runtime8Internal18most_recently_usedE
	.weak_definition	__ZN6Halide7Runtime8Internal18most_recently_usedE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal18most_recently_usedE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal19least_recently_usedE ## @_ZN6Halide7Runtime8Internal19least_recently_usedE
	.weak_definition	__ZN6Halide7Runtime8Internal19least_recently_usedE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal19least_recently_usedE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal14max_cache_sizeE ## @_ZN6Halide7Runtime8Internal14max_cache_sizeE
	.weak_definition	__ZN6Halide7Runtime8Internal14max_cache_sizeE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal14max_cache_sizeE:
	.quad	1048576                         ## 0x100000

	.globl	__ZN6Halide7Runtime8Internal18current_cache_sizeE ## @_ZN6Halide7Runtime8Internal18current_cache_sizeE
	.weak_definition	__ZN6Halide7Runtime8Internal18current_cache_sizeE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal18current_cache_sizeE:
	.quad	0                               ## 0x0

	.section	__TEXT,__cstring,cstring_literals
L_.str.2.42:                            ## @.str.2.42
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/cache.cpp:284 halide_abort_if_false() failed: prev_hash_entry != nullptr\n"

L_.str.3.43:                            ## @.str.3.43
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/cache.cpp:373 halide_abort_if_false() failed: entry->more_recent != nullptr\n"

L_.str.4.44:                            ## @.str.4.44
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/cache.cpp:377 halide_abort_if_false() failed: least_recently_used == entry\n"

L_.str.5.45:                            ## @.str.5.45
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/cache.cpp:380 halide_abort_if_false() failed: entry->more_recent != nullptr\n"

L_.str.9.46:                            ## @.str.9.46
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/cache.cpp:472 halide_abort_if_false() failed: no_host_pointers_equal\n"

L_.str.12.47:                           ## @.str.12.47
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/cache.cpp:550 halide_abort_if_false() failed: entry->in_use_count > 0\n"

L_.str.50:                              ## @.str.50
	.asciz	"<nullptr>"

L_.str.1.57:                            ## @.str.1.57
	.asciz	"-nan"

L_.str.2.58:                            ## @.str.2.58
	.asciz	"nan"

L_.str.3.59:                            ## @.str.3.59
	.asciz	"-inf"

L_.str.4.60:                            ## @.str.4.60
	.asciz	"inf"

L_.str.5.61:                            ## @.str.5.61
	.asciz	"-0.000000e+00"

L_.str.6.62:                            ## @.str.6.62
	.asciz	"0.000000e+00"

L_.str.7.63:                            ## @.str.7.63
	.asciz	"-0.000000"

L_.str.8.64:                            ## @.str.8.64
	.asciz	"0.000000"

L_.str.9.65:                            ## @.str.9.65
	.asciz	"-"

L_.str.11.67:                           ## @.str.11.67
	.asciz	"e+"

L_.str.12.68:                           ## @.str.12.68
	.asciz	"e-"

L_.str.13.71:                           ## @.str.13.71
	.asciz	"0123456789abcdef"

L_.str.14.77:                           ## @.str.14.77
	.asciz	"int"

L_.str.15.76:                           ## @.str.15.76
	.asciz	"uint"

L_.str.16.75:                           ## @.str.16.75
	.asciz	"float"

L_.str.17.74:                           ## @.str.17.74
	.asciz	"handle"

L_.str.18.73:                           ## @.str.18.73
	.asciz	"bfloat"

L_.str.19.72:                           ## @.str.19.72
	.asciz	"bad_type_code"

L_.str.20.78:                           ## @.str.20.78
	.asciz	"x"

L_.str.21.79:                           ## @.str.21.79
	.asciz	"nullptr"

L_.str.22.80:                           ## @.str.22.80
	.asciz	" -> buffer("

L_.str.24.83:                           ## @.str.24.83
	.asciz	", {"

L_.str.25.84:                           ## @.str.25.84
	.asciz	"}"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE ## @_ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE
	.weak_definition	__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE
__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE:
	.byte	1                               ## 0x1

	.globl	__ZN6Halide7Runtime8Internal21allocation_pools_lockE ## @_ZN6Halide7Runtime8Internal21allocation_pools_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal21allocation_pools_lockE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal21allocation_pools_lockE:
	.space	8

	.globl	__ZN6Halide7Runtime8Internal23device_allocation_poolsE ## @_ZN6Halide7Runtime8Internal23device_allocation_poolsE
	.weak_definition	__ZN6Halide7Runtime8Internal23device_allocation_poolsE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal23device_allocation_poolsE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal17device_copy_mutexE ## @_ZN6Halide7Runtime8Internal17device_copy_mutexE
	.weak_definition	__ZN6Halide7Runtime8Internal17device_copy_mutexE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal17device_copy_mutexE:
	.space	8

	.section	__TEXT,__cstring,cstring_literals
L_.str.6.91:                            ## @.str.6.91
	.asciz	"halide_copy_to_host"

L_.str.7.92:                            ## @.str.7.92
	.asciz	"halide_copy_to_device"

L_.str.9.93:                            ## @.str.9.93
	.asciz	"halide_copy_to_device does not support switching interfaces"

L_.str.16.96:                           ## @.str.16.96
	.asciz	"halide_device_sync"

L_.str.17.94:                           ## @.str.17.94
	.asciz	"halide_device_malloc"

L_.str.20.95:                           ## @.str.20.95
	.asciz	"halide_device_malloc doesn't support switching interfaces\n"

L_.str.21.99:                           ## @.str.21.99
	.asciz	"halide_device_free"

L_.str.22.100:                          ## @.str.22.100
	.asciz	"halide_device_and_host_malloc"

L_.str.24.101:                          ## @.str.24.101
	.asciz	"halide_device_and_host_malloc doesn't support switching interfaces"

L_.str.26.102:                          ## @.str.26.102
	.asciz	"halide_device_and_host_free"

L_.str.27.103:                          ## @.str.27.103
	.asciz	"halide_default_device_and_host_malloc"

L_.str.28.104:                          ## @.str.28.104
	.asciz	"halide_default_device_and_host_free"

L_.str.29.105:                          ## @.str.29.105
	.asciz	"halide_device_wrap_native"

L_.str.30.106:                          ## @.str.30.106
	.asciz	"halide_device_wrap_native doesn't support switching interfaces"

L_.str.31.107:                          ## @.str.31.107
	.asciz	"halide_device_detach_native"

L_.str.32.108:                          ## @.str.32.108
	.asciz	"buf->device == 0 in halide_device_detach_native() after detach_native()\n"

L_.str.34.109:                          ## @.str.34.109
	.asciz	"halide_default_device_detach_native"

L_.str.40:                              ## @.str.40
	.asciz	"halide_buffer_copy does not support switching device interfaces"

L_.str.53:                              ## @.str.53
	.asciz	"Failure in halide_buffer_copy_already_locked"

L_.str.58:                              ## @.str.58
	.asciz	"device_interface does not support cropping"

L_.str.59:                              ## @.str.59
	.asciz	"device_interface does not support slicing"

L_.str.60:                              ## @.str.60
	.asciz	"destination buffer already has a device allocation"

L_.str.61:                              ## @.str.61
	.asciz	"src and dst must have identical dimensionality"

L_.str.64:                              ## @.str.64
	.asciz	"dst must have exactly one fewer dimension than src"

L_.str.113:                             ## @.str.113
	.asciz	"Bounds inference call to external stage "

L_.str.1.114:                           ## @.str.1.114
	.asciz	" returned non-zero value: "

L_.str.2.116:                           ## @.str.2.116
	.asciz	"Call to external stage "

L_.str.3.117:                           ## @.str.3.117
	.asciz	"Bounds given for "

L_.str.4.118:                           ## @.str.4.118
	.asciz	" in "

L_.str.5.119:                           ## @.str.5.119
	.asciz	" (from "

L_.str.6.120:                           ## @.str.6.120
	.asciz	" to "

L_.str.7.121:                           ## @.str.7.121
	.asciz	") do not cover required region (from "

L_.str.8.122:                           ## @.str.8.122
	.asciz	")"

L_.str.9.123:                           ## @.str.9.123
	.asciz	" has type "

L_.str.10.124:                          ## @.str.10.124
	.asciz	" but type of the buffer passed in is "

L_.str.11.125:                          ## @.str.11.125
	.asciz	" requires a buffer of exactly "

L_.str.12.126:                          ## @.str.12.126
	.asciz	" dimensions, but the buffer passed in has "

L_.str.13.127:                          ## @.str.13.127
	.asciz	" dimensions"

L_.str.14.128:                          ## @.str.14.128
	.asciz	" is accessed at "

L_.str.15.129:                          ## @.str.15.129
	.asciz	", which is before the min ("

L_.str.16.130:                          ## @.str.16.130
	.asciz	") in dimension "

L_.str.17.131:                          ## @.str.17.131
	.asciz	", which is beyond the max ("

L_.str.18.132:                          ## @.str.18.132
	.asciz	"Total allocation for buffer "

L_.str.19.133:                          ## @.str.19.133
	.asciz	" is "

L_.str.20.134:                          ## @.str.20.134
	.asciz	", which exceeds the maximum size of "

L_.str.21.135:                          ## @.str.21.135
	.asciz	"The extents for buffer "

L_.str.22.136:                          ## @.str.22.136
	.asciz	" dimension "

L_.str.23.137:                          ## @.str.23.137
	.asciz	" is negative ("

L_.str.24.138:                          ## @.str.24.138
	.asciz	"Product of extents for buffer "

L_.str.25.139:                          ## @.str.25.139
	.asciz	"Applying the constraints on "

L_.str.26.140:                          ## @.str.26.140
	.asciz	" to the required region made it smaller in dimension "

L_.str.27.141:                          ## @.str.27.141
	.asciz	". "

L_.str.28.142:                          ## @.str.28.142
	.asciz	"Required size: "

L_.str.29.143:                          ## @.str.29.143
	.asciz	"Constrained size: "

L_.str.31.145:                          ## @.str.31.145
	.asciz	"Constraint violated: "

L_.str.32.146:                          ## @.str.32.146
	.asciz	" ("

L_.str.33.147:                          ## @.str.33.147
	.asciz	") == "

L_.str.34.148:                          ## @.str.34.148
	.asciz	"Parameter "

L_.str.35:                              ## @.str.35
	.asciz	" but must be at least "

L_.str.36:                              ## @.str.36
	.asciz	" but must be at most "

L_.str.37:                              ## @.str.37
	.asciz	"Out of memory (halide_malloc returned nullptr)"

L_.str.38:                              ## @.str.38
	.asciz	"Buffer argument "

L_.str.39:                              ## @.str.39
	.asciz	" is nullptr"

L_.str.40.149:                          ## @.str.40.149
	.asciz	"Failed to dump function "

L_.str.41:                              ## @.str.41
	.asciz	" to file "

L_.str.42:                              ## @.str.42
	.asciz	" with error "

L_.str.43:                              ## @.str.43
	.asciz	"The host pointer of "

L_.str.44:                              ## @.str.44
	.asciz	" is not aligned to a "

L_.str.45:                              ## @.str.45
	.asciz	" bytes boundary."

L_.str.46:                              ## @.str.46
	.asciz	"The buffer "

L_.str.47:                              ## @.str.47
	.asciz	" is dirty on device, but this pipeline was compiled "

L_.str.48:                              ## @.str.48
	.asciz	"with no support for device to host copies."

L_.str.49:                              ## @.str.49
	.asciz	" is null, but the pipeline will access it on the host."

L_.str.50.150:                          ## @.str.50.150
	.asciz	"The folded storage dimension "

L_.str.51:                              ## @.str.51
	.asciz	" of "

L_.str.52:                              ## @.str.52
	.asciz	" was accessed out of order by loop "

L_.str.53.151:                          ## @.str.53.151
	.asciz	"Cannot fold dimension "

L_.str.54:                              ## @.str.54
	.asciz	" because an extern stage accesses ["

L_.str.55:                              ## @.str.55
	.asciz	", "

L_.str.56:                              ## @.str.56
	.asciz	"],"

L_.str.57:                              ## @.str.57
	.asciz	" which is outside the range currently valid: ["

L_.str.58.152:                          ## @.str.58.152
	.asciz	"]."

L_.str.59.153:                          ## @.str.59.153
	.asciz	" which wraps around the boundary of the fold, "

L_.str.60.154:                          ## @.str.60.154
	.asciz	"which occurs at multiples of "

L_.str.61.155:                          ## @.str.61.155
	.asciz	"The fold factor ("

L_.str.62:                              ## @.str.62
	.asciz	") of dimension "

L_.str.63:                              ## @.str.63
	.asciz	" is too small to store the required region accessed by loop "

L_.str.64.156:                          ## @.str.64.156
	.asciz	")."

L_.str.65:                              ## @.str.65
	.asciz	"Requirement Failed: ("

L_.str.66:                              ## @.str.66
	.asciz	") "

L_.str.67:                              ## @.str.67
	.asciz	"A schedule specialized with specialize_fail() was chosen: "

L_.str.68:                              ## @.str.68
	.asciz	"Buffer has a non-zero device but no device interface.\n"

L_.str.69:                              ## @.str.69
	.asciz	"Buffer has a non-null device_interface but device is 0.\n"

L_.str.70:                              ## @.str.70
	.asciz	"Buffer has both host and device dirty bits set.\n"

L_.str.71:                              ## @.str.71
	.asciz	"Buffer pointer passed to "

L_.str.72:                              ## @.str.72
	.asciz	" is null.\n"

L_.str.73:                              ## @.str.73
	.asciz	"The explicit allocation bound ("

L_.str.74:                              ## @.str.74
	.asciz	" is too small to store the required region ("

L_.str.75:                              ## @.str.75
	.asciz	"Buffer could not be cropped (runtime error or unimplemented device option).\n"

L_.str.76:                              ## @.str.76
	.asciz	"In schedule for func "

L_.str.77:                              ## @.str.77
	.asciz	", the factor used to split the variable "

L_.str.78:                              ## @.str.78
	.asciz	" into "

L_.str.79:                              ## @.str.79
	.asciz	" and "

L_.str.80:                              ## @.str.80
	.asciz	". This evaluated to "

L_.str.81:                              ## @.str.81
	.asciz	", which is not strictly positive. "

L_.str.82:                              ## @.str.82
	.asciz	"Consider using max("

L_.str.83:                              ## @.str.83
	.asciz	", 1) instead."

	.section	__DATA,__data
	.p2align	3, 0x0                          ## @_ZZ25halide_profiler_get_stateE1s
__ZZ25halide_profiler_get_stateE1s:
	.space	8
	.long	1                               ## 0x1
	.long	0                               ## 0x0
	.long	0                               ## 0x0
	.long	0                               ## 0x0
	.quad	0
	.quad	0
	.quad	0

	.section	__TEXT,__cstring,cstring_literals
L_.str.206:                             ## @.str.206
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/profiler_common.cpp:247 halide_abort_if_false() failed: p_stats != nullptr\n"

L_.str.1.207:                           ## @.str.1.207
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/profiler_common.cpp:276 halide_abort_if_false() failed: p_stats != nullptr\n"

L_.str.2.208:                           ## @.str.2.208
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/profiler_common.cpp:277 halide_abort_if_false() failed: func_id >= 0\n"

L_.str.3.209:                           ## @.str.3.209
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/profiler_common.cpp:278 halide_abort_if_false() failed: func_id < p_stats->num_funcs\n"

L_.str.4.210:                           ## @.str.4.210
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/profiler_common.cpp:314 halide_abort_if_false() failed: p_stats != nullptr\n"

L_.str.5.211:                           ## @.str.5.211
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/profiler_common.cpp:315 halide_abort_if_false() failed: func_id >= 0\n"

L_.str.6.212:                           ## @.str.6.212
	.asciz	"/Users/ardimadadi/Documents/Projects/Studies/Research/halide/Halide_latest/src/runtime/profiler_common.cpp:316 halide_abort_if_false() failed: func_id < p_stats->num_funcs\n"

L_.str.7.166:                           ## @.str.7.166
	.asciz	"HL_PROFILER_SORT"

L_.str.8.167:                           ## @.str.8.167
	.asciz	"time"

L_.str.9.168:                           ## @.str.9.168
	.asciz	"name"

L_.str.10.169:                          ## @.str.10.169
	.asciz	"TERM"

L_.str.11.170:                          ## @.str.11.170
	.asciz	"color"

L_.str.12.171:                          ## @.str.12.171
	.asciz	"xterm"

L_.str.13.172:                          ## @.str.13.172
	.asciz	"\n"

L_.str.14.173:                          ## @.str.14.173
	.asciz	" total time: "

L_.str.15.174:                          ## @.str.15.174
	.asciz	" ms"

L_.str.16.175:                          ## @.str.16.175
	.asciz	"  samples: "

L_.str.17.176:                          ## @.str.17.176
	.asciz	"  runs: "

L_.str.18.177:                          ## @.str.18.177
	.asciz	"  time/run: "

L_.str.19.178:                          ## @.str.19.178
	.asciz	" ms\n"

L_.str.20.179:                          ## @.str.20.179
	.asciz	" average threads used: "

L_.str.21.180:                          ## @.str.21.180
	.asciz	" heap allocations: "

L_.str.22.181:                          ## @.str.22.181
	.asciz	"  peak heap usage: "

L_.str.23.182:                          ## @.str.23.182
	.asciz	" bytes\n"

L_.str.24.183:                          ## @.str.24.183
	.asciz	" (copy to device)"

L_.str.25.184:                          ## @.str.25.184
	.asciz	" (copy to host)"

L_.str.26.185:                          ## @.str.26.185
	.asciz	"funcs"

L_.str.27.186:                          ## @.str.27.186
	.asciz	"buffer copies to device"

L_.str.28.187:                          ## @.str.28.187
	.asciz	"buffer copies to host"

L_.str.29.199:                          ## @.str.29.199
	.asciz	"    "

L_.str.30.200:                          ## @.str.30.200
	.asciz	": "

L_.str.31.191:                          ## @.str.31.191
	.asciz	" "

L_.str.32.201:                          ## @.str.32.201
	.asciz	"threads: "

L_.str.33.202:                          ## @.str.33.202
	.asciz	" peak: "

L_.str.34.203:                          ## @.str.34.203
	.asciz	" num: "

L_.str.35.204:                          ## @.str.35.204
	.asciz	" avg: "

L_.str.36.205:                          ## @.str.36.205
	.asciz	" stack: "

L_.str.37.195:                          ## @.str.37.195
	.asciz	"ms"

L_.str.38.196:                          ## @.str.38.196
	.asciz	"("

L_.str.39.197:                          ## @.str.39.197
	.asciz	"."

L_.str.40.198:                          ## @.str.40.198
	.asciz	"%)"

L_.str.41.188:                          ## @.str.41.188
	.asciz	"  "

L_.str.42.189:                          ## @.str.42.189
	.asciz	"\033[90m\033[3m"

L_.str.43.190:                          ## @.str.43.190
	.asciz	"["

L_.str.44.192:                          ## @.str.44.192
	.asciz	":"

L_.str.45.193:                          ## @.str.45.193
	.asciz	" ::::]"

L_.str.46.194:                          ## @.str.46.194
	.asciz	"\033[0m"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE ## @_ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE
	.weak_definition	__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE:
	.quad	_halide_default_can_use_target_features

	.globl	__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE ## @_ZN6Halide7Runtime8Internal27halide_cpu_features_storageE
	.weak_definition	__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE:
	.space	32

	.globl	__ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE ## @_ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE
	.weak_definition	__ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE
__ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE:
	.byte	0                               ## 0x0

	.globl	__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE ## @_ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE
	.p2align	3, 0x0
__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE:
	.space	8

	.section	__TEXT,__cstring,cstring_literals
L_.str.217:                             ## @.str.217
	.asciz	"Internal error: wrong structure size passed to halide_can_use_target_features()\n"

	.section	__TEXT,__const
	.p2align	3, 0x0                          ## @0
l___unnamed_1:
	.space	16

	.p2align	5, 0x0                          ## @str
l_str:
	.asciz	"vectorA"

	.p2align	3, 0x0                          ## @1
l___unnamed_2:
	.space	16

	.p2align	5, 0x0                          ## @str.220
l_str.220:
	.asciz	"vectorB"

	.p2align	3, 0x0                          ## @2
l___unnamed_3:
	.quad	0                               ## 0x0

	.p2align	3, 0x0                          ## @3
l___unnamed_4:
	.quad	1                               ## 0x1

	.section	__DATA,__const
	.p2align	3, 0x0                          ## @4
l___unnamed_5:
	.quad	l___unnamed_3
	.quad	l___unnamed_4

	.section	__TEXT,__const
	.p2align	5, 0x0                          ## @str.221
l_str.221:
	.asciz	"result"

	.section	__DATA,__const
	.p2align	4, 0x0                          ## @5
l___unnamed_6:
	.quad	l_str
	.long	1                               ## 0x1
	.long	1                               ## 0x1
	.byte	2                               ## 0x2
	.byte	32                              ## 0x20
	.short	1                               ## 0x1
	.space	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	l___unnamed_1
	.quad	l_str.220
	.long	1                               ## 0x1
	.long	1                               ## 0x1
	.byte	2                               ## 0x2
	.byte	32                              ## 0x20
	.short	1                               ## 0x1
	.space	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	l___unnamed_2
	.quad	l_str.221
	.long	2                               ## 0x2
	.long	1                               ## 0x1
	.byte	2                               ## 0x2
	.byte	32                              ## 0x20
	.short	1                               ## 0x1
	.space	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	l___unnamed_5

	.section	__TEXT,__const
	.p2align	5, 0x0                          ## @str.222
l_str.222:
	.asciz	"x86-64-osx-avx-avx2-f16c-fma-sse41"

	.p2align	5, 0x0                          ## @str.223
l_str.223:
	.asciz	"halide_dotProduct"

	.section	__DATA,__const
	.p2align	4, 0x0                          ## @halide_dotProduct_metadata_storage
l_halide_dotProduct_metadata_storage:
	.long	1                               ## 0x1
	.long	3                               ## 0x3
	.quad	l___unnamed_6
	.quad	l_str.222
	.quad	l_str.223

	.section	__TEXT,__const
	.p2align	5, 0x0                          ## @str.224
l_str.224:
	.asciz	"Output buffer result"

	.p2align	5, 0x0                          ## @str.225
l_str.225:
	.asciz	"Input buffer vectorA"

	.p2align	5, 0x0                          ## @str.226
l_str.226:
	.asciz	"Input buffer vectorB"

	.p2align	5, 0x0                          ## @str.227
l_str.227:
	.asciz	"result.stride.0"

	.p2align	5, 0x0                          ## @str.228
l_str.228:
	.asciz	"1"

	.p2align	5, 0x0                          ## @str.229
l_str.229:
	.asciz	"vectorA.stride.0"

	.p2align	5, 0x0                          ## @str.230
l_str.230:
	.asciz	"vectorB.stride.0"

	.p2align	5, 0x0                          ## @str.231
l_str.231:
	.asciz	"v0"

	.p2align	2, 0x0                          ## @reltable.halide_type_to_string
l_reltable.halide_type_to_string:
	.long	L_.str.14.77-l_reltable.halide_type_to_string
	.long	L_.str.15.76-l_reltable.halide_type_to_string
	.long	L_.str.16.75-l_reltable.halide_type_to_string
	.long	L_.str.17.74-l_reltable.halide_type_to_string
	.long	L_.str.18.73-l_reltable.halide_type_to_string

.subsections_via_symbols
