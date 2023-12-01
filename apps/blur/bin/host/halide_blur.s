	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_default_malloc          ; -- Begin function halide_default_malloc
	.weak_definition	_halide_default_malloc
	.p2align	2
_halide_default_malloc:                 ; @halide_default_malloc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	add	x0, x1, #32
	bl	_malloc
	cbz	x0, LBB0_2
; %bb.1:                                ; %if.end
	mov	x8, x0
	add	x9, x0, #39
	and	x0, x9, #0xffffffffffffffe0
	stur	x8, [x0, #-8]
LBB0_2:                                 ; %cleanup
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_default_free            ; -- Begin function halide_default_free
	.weak_definition	_halide_default_free
	.p2align	2
_halide_default_free:                   ; @halide_default_free
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldur	x0, [x1, #-8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_free
                                        ; -- End function
	.globl	_halide_set_custom_malloc       ; -- Begin function halide_set_custom_malloc
	.weak_definition	_halide_set_custom_malloc
	.p2align	2
_halide_set_custom_malloc:              ; @halide_set_custom_malloc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh0:
	adrp	x9, __ZN6Halide7Runtime8Internal13custom_mallocE@GOTPAGE
Lloh1:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal13custom_mallocE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh0, Lloh1
                                        ; -- End function
	.globl	_halide_set_custom_free         ; -- Begin function halide_set_custom_free
	.weak_definition	_halide_set_custom_free
	.p2align	2
_halide_set_custom_free:                ; @halide_set_custom_free
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh2:
	adrp	x9, __ZN6Halide7Runtime8Internal11custom_freeE@GOTPAGE
Lloh3:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal11custom_freeE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh2, Lloh3
                                        ; -- End function
	.globl	_halide_malloc                  ; -- Begin function halide_malloc
	.weak_definition	_halide_malloc
	.p2align	2
_halide_malloc:                         ; @halide_malloc
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh4:
	adrp	x8, __ZN6Halide7Runtime8Internal13custom_mallocE@GOTPAGE
Lloh5:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal13custom_mallocE@GOTPAGEOFF]
Lloh6:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh4, Lloh5, Lloh6
                                        ; -- End function
	.globl	_halide_free                    ; -- Begin function halide_free
	.weak_definition	_halide_free
	.p2align	2
_halide_free:                           ; @halide_free
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh7:
	adrp	x8, __ZN6Halide7Runtime8Internal11custom_freeE@GOTPAGE
Lloh8:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal11custom_freeE@GOTPAGEOFF]
Lloh9:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh7, Lloh8, Lloh9
                                        ; -- End function
	.globl	_halide_default_error           ; -- Begin function halide_default_error
	.weak_definition	_halide_default_error
	.p2align	2
_halide_default_error:                  ; @halide_default_error
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	sub	sp, sp, #1, lsl #12             ; =4096
	mov	x20, x1
	mov	x19, x0
	mov	x21, sp
	add	x1, x21, #4094
Lloh10:
	adrp	x2, l_.str@PAGE
Lloh11:
	add	x2, x2, l_.str@PAGEOFF
	mov	x0, sp
	bl	_halide_string_to_string
	add	x1, x0, #4094
	mov	x2, x20
	bl	_halide_string_to_string
	ldurb	w8, [x0, #-1]
	cmp	w8, #10
	b.eq	LBB6_2
; %bb.1:                                ; %if.then
	mov	w8, #10
	strh	w8, [x0], #1
LBB6_2:                                 ; %if.end
	sub	x8, x0, x21
	add	x2, x8, #1
	mov	x1, sp
	mov	x0, x19
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, sp
	mov	x0, x19
	bl	_halide_print
	bl	_abort
	add	sp, sp, #1, lsl #12             ; =4096
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh10, Lloh11
                                        ; -- End function
	.globl	_halide_error                   ; -- Begin function halide_error
	.weak_definition	_halide_error
	.p2align	2
_halide_error:                          ; @halide_error
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh12:
	adrp	x8, __ZN6Halide7Runtime8Internal13error_handlerE@GOTPAGE
Lloh13:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal13error_handlerE@GOTPAGEOFF]
Lloh14:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh12, Lloh13, Lloh14
                                        ; -- End function
	.globl	_halide_set_error_handler       ; -- Begin function halide_set_error_handler
	.weak_definition	_halide_set_error_handler
	.p2align	2
_halide_set_error_handler:              ; @halide_set_error_handler
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh15:
	adrp	x9, __ZN6Halide7Runtime8Internal13error_handlerE@GOTPAGE
Lloh16:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal13error_handlerE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh15, Lloh16
                                        ; -- End function
	.globl	_halide_print                   ; -- Begin function halide_print
	.weak_definition	_halide_print
	.p2align	2
_halide_print:                          ; @halide_print
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh17:
	adrp	x8, __ZN6Halide7Runtime8Internal12custom_printE@GOTPAGE
Lloh18:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal12custom_printE@GOTPAGEOFF]
Lloh19:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh17, Lloh18, Lloh19
                                        ; -- End function
	.globl	_halide_set_custom_print        ; -- Begin function halide_set_custom_print
	.weak_definition	_halide_set_custom_print
	.p2align	2
_halide_set_custom_print:               ; @halide_set_custom_print
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh20:
	adrp	x9, __ZN6Halide7Runtime8Internal12custom_printE@GOTPAGE
Lloh21:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal12custom_printE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh20, Lloh21
                                        ; -- End function
	.globl	_halide_start_clock             ; -- Begin function halide_start_clock
	.weak_definition	_halide_start_clock
	.p2align	2
_halide_start_clock:                    ; @halide_start_clock
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
Lloh22:
	adrp	x19, __ZN6Halide7Runtime8Internal29halide_reference_clock_initedE@GOTPAGE
Lloh23:
	ldr	x19, [x19, __ZN6Halide7Runtime8Internal29halide_reference_clock_initedE@GOTPAGEOFF]
	ldrb	w8, [x19]
	cbz	w8, LBB11_2
; %bb.1:                                ; %if.end
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB11_2:                                ; %if.then
Lloh24:
	adrp	x0, __ZN6Halide7Runtime8Internal20halide_timebase_infoE@GOTPAGE
Lloh25:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal20halide_timebase_infoE@GOTPAGEOFF]
	bl	_mach_timebase_info
	bl	_mach_absolute_time
Lloh26:
	adrp	x8, __ZN6Halide7Runtime8Internal22halide_reference_clockE@GOTPAGE
Lloh27:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal22halide_reference_clockE@GOTPAGEOFF]
Lloh28:
	str	x0, [x8]
	mov	w8, #1
	strb	w8, [x19]
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh22, Lloh23
	.loh AdrpLdrGotStr	Lloh26, Lloh27, Lloh28
	.loh AdrpLdrGot	Lloh24, Lloh25
                                        ; -- End function
	.globl	_halide_current_time_ns         ; -- Begin function halide_current_time_ns
	.weak_definition	_halide_current_time_ns
	.p2align	2
_halide_current_time_ns:                ; @halide_current_time_ns
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	bl	_mach_absolute_time
Lloh29:
	adrp	x8, __ZN6Halide7Runtime8Internal22halide_reference_clockE@GOTPAGE
Lloh30:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal22halide_reference_clockE@GOTPAGEOFF]
Lloh31:
	ldr	x8, [x8]
Lloh32:
	adrp	x9, __ZN6Halide7Runtime8Internal20halide_timebase_infoE@GOTPAGE
Lloh33:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal20halide_timebase_infoE@GOTPAGEOFF]
	sub	x8, x0, x8
	ldp	w10, w9, [x9]
	mul	x8, x8, x10
	udiv	x0, x8, x9
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh32, Lloh33
	.loh AdrpLdrGotLdr	Lloh29, Lloh30, Lloh31
                                        ; -- End function
	.globl	_halide_sleep_ms                ; -- Begin function halide_sleep_ms
	.weak_definition	_halide_sleep_ms
	.p2align	2
_halide_sleep_ms:                       ; @halide_sleep_ms
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w8, #1000
	mul	w0, w1, w8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_usleep
                                        ; -- End function
	.globl	_halide_default_print           ; -- Begin function halide_default_print
	.weak_definition	_halide_default_print
	.p2align	2
_halide_default_print:                  ; @halide_default_print
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	mov	x0, x1
	bl	_strlen
	mov	x2, x0
	mov	w0, #1
	mov	x1, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_write
                                        ; -- End function
	.globl	_halide_host_cpu_count          ; -- Begin function halide_host_cpu_count
	.weak_definition	_halide_host_cpu_count
	.p2align	2
_halide_host_cpu_count:                 ; @halide_host_cpu_count
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #58
	bl	_sysconf
                                        ; kill: def $w0 killed $w0 killed $x0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_thread_yield            ; -- Begin function halide_thread_yield
	.weak_definition	_halide_thread_yield
	.p2align	2
_halide_thread_yield:                   ; @halide_thread_yield
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_swtch_pri
                                        ; -- End function
	.globl	_halide_default_do_task         ; -- Begin function halide_default_do_task
	.weak_definition	_halide_default_do_task
	.p2align	2
_halide_default_do_task:                ; @halide_default_do_task
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	x4, x1
	mov	x1, x2
	mov	x2, x3
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x4
                                        ; -- End function
	.globl	_halide_default_do_loop_task    ; -- Begin function halide_default_do_loop_task
	.weak_definition	_halide_default_do_loop_task
	.p2align	2
_halide_default_do_loop_task:           ; @halide_default_do_loop_task
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	x6, x1
	mov	x1, x2
	mov	x2, x3
	mov	x3, x4
	mov	x4, x5
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x6
                                        ; -- End function
	.globl	_halide_default_do_par_for      ; -- Begin function halide_default_do_par_for
	.weak_definition	_halide_default_do_par_for
	.p2align	2
_halide_default_do_par_for:             ; @halide_default_do_par_for
; %bb.0:                                ; %entry
	cmp	w3, #1
	b.lt	LBB19_2
; %bb.1:                                ; %if.end
	sub	sp, sp, #160
	stp	x20, x19, [sp, #128]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #144]            ; 16-byte Folded Spill
	add	x29, sp, #144
	strb	wzr, [sp, #48]
	stp	wzr, w2, [sp, #32]
	stp	xzr, x4, [sp]
	stp	w3, wzr, [sp, #40]
	stp	xzr, xzr, [sp, #16]
	stp	x0, xzr, [sp, #104]
	str	wzr, [sp, #120]
	strb	wzr, [sp, #124]
	mov	x8, sp
	str	x1, [sp, #56]
	str	x8, [sp, #72]
	str	wzr, [sp, #80]
	str	xzr, [sp, #88]
Lloh34:
	adrp	x19, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh35:
	ldr	x19, [x19, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	mov	x0, x19
	bl	_halide_mutex_lock
	mov	x1, sp
	mov	w0, #1
	mov	x2, #0
	bl	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	mov	x0, sp
	bl	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	mov	x0, x19
	bl	_halide_mutex_unlock
	ldr	w0, [sp, #116]
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	add	sp, sp, #160
	ret
LBB19_2:
	mov	w0, #0
	ret
	.loh AdrpLdrGot	Lloh34, Lloh35
                                        ; -- End function
	.globl	_halide_mutex_lock              ; -- Begin function halide_mutex_lock
	.weak_definition	_halide_mutex_lock
	.p2align	2
_halide_mutex_lock:                     ; @halide_mutex_lock
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x8, #0
	mov	w9, #1
	casa	x8, x9, [x0]
	cmp	x8, #0
	b.ne	LBB20_2
LBB20_1:                                ; %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex4lockEv.exit
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB20_2:                                ; %if.then.i
	mov	x19, x0
	ldr	x9, [x0]
	mov	w8, #40
Lloh36:
	adrp	x10, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGE
Lloh37:
	ldr	x10, [x10, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGEOFF]
	add	x20, x10, #16
LBB20_3:                                ; %while.cond.outer.i.i
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB20_5 Depth 2
	tbnz	w9, #0, LBB20_8
; %bb.4:                                ; %if.then.i.i.preheader
                                        ;   in Loop: Header=BB20_3 Depth=1
	mov	x10, x9
LBB20_5:                                ; %if.then.i.i
                                        ;   Parent Loop BB20_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	orr	x11, x9, #0x1
	casa	x10, x11, [x19]
	cmp	x10, x9
	b.eq	LBB20_1
; %bb.6:                                ; %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_acquire_relaxedEPyS4_S4_.exit.i.i
                                        ;   in Loop: Header=BB20_5 Depth=2
	mov	x9, x10
	tbz	w10, #0, LBB20_5
; %bb.7:                                ; %if.end4.i.i.loopexit
                                        ;   in Loop: Header=BB20_3 Depth=1
	mov	x9, x10
LBB20_8:                                ; %if.end4.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	subs	w21, w8, #1
	b.ge	LBB20_12
; %bb.9:                                ; %if.end8.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	tbnz	w9, #1, LBB20_15
LBB20_10:                               ; %if.then10.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	orr	x11, x9, #0x2
	mov	x10, x9
	cas	x10, x11, [x19]
	cmp	x10, x9
	b.eq	LBB20_15
; %bb.11:                               ; %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_relaxed_relaxedEPyS4_S4_.exit.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	mov	x9, x10
	b	LBB20_3
LBB20_12:                               ; %_ZN6Halide7Runtime8Internal15Synchronization12spin_control11should_spinEv.exit.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	b.eq	LBB20_14
; %bb.13:                               ; %if.then6.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	bl	_halide_thread_yield
	ldr	x9, [x19]
	mov	x8, x21
	b	LBB20_3
LBB20_14:                               ;   in Loop: Header=BB20_3 Depth=1
	mov	w8, #0
	tbz	w9, #1, LBB20_10
LBB20_15:                               ; %if.end19.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	stp	x20, x19, [sp]
	mov	x0, sp
	mov	x1, x19
	bl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	cmp	x0, x19
	b.eq	LBB20_1
; %bb.16:                               ; %if.end24.i.i
                                        ;   in Loop: Header=BB20_3 Depth=1
	ldr	x9, [x19]
	mov	w8, #40
	b	LBB20_3
	.loh AdrpLdrGot	Lloh36, Lloh37
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_ ; -- Begin function _ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	.weak_definition	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	.p2align	2
__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_: ; @_ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
; %bb.0:                                ; %entry
	sub	sp, sp, #112
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	mov	x19, x2
	mov	x20, x1
	mov	x21, x0
Lloh38:
	adrp	x23, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh39:
	ldr	x23, [x23, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	ldrb	w8, [x23, #2121]
	cbz	w8, LBB21_11
; %bb.1:                                ; %if.end4
	cmp	w21, #1
	b.lt	LBB21_19
LBB21_2:                                ; %for.body.preheader
	mov	w8, #0
	mov	w10, #0
	mov	w11, #0
	mov	w9, #0
	add	x12, x20, #48
	mov	w24, #-1
	mov	w13, w21
	b	LBB21_4
LBB21_3:                                ; %if.then23
                                        ;   in Loop: Header=BB21_4 Depth=1
	add	w24, w24, #1
	add	w8, w14, w8
	add	x12, x12, #128
	subs	x13, x13, #1
	b.eq	LBB21_6
LBB21_4:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldur	w14, [x12, #-4]
	cmp	w14, #0
	csinc	w9, w9, wzr, ne
	csinc	w10, w10, wzr, eq
	ldur	w15, [x12, #-16]
	cmp	w15, #0
	csinc	w11, w11, wzr, eq
	ldrb	w15, [x12]
	cbnz	w15, LBB21_3
; %bb.5:                                ; %if.else24
                                        ;   in Loop: Header=BB21_4 Depth=1
	ldur	w15, [x12, #-8]
	add	w24, w15, w24
	add	w8, w14, w8
	add	x12, x12, #128
	subs	x13, x13, #1
	b.ne	LBB21_4
LBB21_6:                                ; %for.cond.cleanup.loopexit
	and	w25, w11, #0x1
	and	w26, w10, #0x1
	and	w22, w9, #0x1
	cbz	x19, LBB21_20
LBB21_7:                                ; %do.body61
	ldr	w9, [x19, #44]
	ldr	w10, [x19, #112]
	ldr	w11, [x19, #96]
	neg	w11, w11
	madd	w9, w10, w9, w11
	cmp	w8, w9
	b.le	LBB21_9
; %bb.8:                                ; %if.then66
Lloh40:
	adrp	x1, l_.str.3@PAGE
Lloh41:
	add	x1, x1, l_.str.3@PAGEOFF
	mov	x0, #0
	bl	_halide_print
	bl	_abort
LBB21_9:                                ; %do.end69
	orr	w8, w25, w26
	cbz	w8, LBB21_27
; %bb.10:                               ; %if.then73
	ldr	w8, [x19, #96]
	add	w8, w8, #1
	str	w8, [x19, #96]
	b	LBB21_27
LBB21_11:                               ; %land.rhs.i.preheader
	add	x8, x23, #12
LBB21_12:                               ; %land.rhs.i
                                        ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x8]
	cbnz	w9, LBB21_14
; %bb.13:                               ; %while.body.i
                                        ;   in Loop: Header=BB21_12 Depth=1
	add	x8, x8, #1
	add	x9, x23, #2128
	cmp	x8, x9
	b.lo	LBB21_12
LBB21_14:                               ; %do.body.i
	add	x9, x23, #2128
	cmp	x8, x9
	b.eq	LBB21_16
; %bb.15:                               ; %if.then.i
Lloh42:
	adrp	x1, l_.str.6@PAGE
Lloh43:
	add	x1, x1, l_.str.6@PAGEOFF
	mov	x0, #0
	bl	_halide_print
	bl	_abort
LBB21_16:                               ; %_ZNK6Halide7Runtime8Internal12work_queue_t13assert_zeroedEv.exit
	ldr	w0, [x23, #8]
	cbnz	w0, LBB21_18
; %bb.17:                               ; %if.then2
	bl	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
LBB21_18:                               ; %if.end
	cmp	w0, #1
	csinc	w8, w0, wzr, gt
	cmp	w8, #256
	mov	w9, #256
	csel	w8, w8, w9, lo
	str	w8, [x23, #8]
	mov	w8, #1
	strb	w8, [x23, #2121]
	cmp	w21, #1
	b.ge	LBB21_2
LBB21_19:
	mov	w22, #0
	mov	w25, #0
	mov	w26, #0
	mov	w8, #0
	mov	w24, #-1
	cbnz	x19, LBB21_7
LBB21_20:                               ; %if.then32
	str	w22, [sp, #12]                  ; 4-byte Folded Spill
	orr	w10, w25, w26
	cmp	w10, #0
	cset	w28, eq
	ldr	w9, [x23, #24]
	cmp	w9, #255
	b.gt	LBB21_25
; %bb.21:                               ; %land.rhs.preheader
	add	w27, w8, w10
Lloh44:
	adrp	x22, __ZN6Halide7Runtime8Internal13worker_threadEPv@GOTPAGE
Lloh45:
	ldr	x22, [x22, __ZN6Halide7Runtime8Internal13worker_threadEPv@GOTPAGEOFF]
	b	LBB21_23
LBB21_22:                               ; %while.body
                                        ;   in Loop: Header=BB21_23 Depth=1
	ldr	w8, [x23, #28]
	add	w8, w8, #1
	str	w8, [x23, #28]
	mov	x0, x22
	mov	x1, #0
	bl	_halide_spawn_thread
	ldrsw	x8, [x23, #24]
	add	w9, w8, #1
	str	w9, [x23, #24]
	add	x10, x23, x8, lsl #3
	str	x0, [x10, #72]
	cmp	w8, #255
	b.ge	LBB21_25
LBB21_23:                               ; %land.rhs
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [x23, #8]
	sub	w8, w8, #1
	cmp	w9, w8
	b.lt	LBB21_22
; %bb.24:                               ; %lor.rhs
                                        ;   in Loop: Header=BB21_23 Depth=1
	ldr	w8, [x23, #2124]
	sub	w8, w9, w8
	add	w8, w8, #1
	cmp	w8, w27
	b.lt	LBB21_22
LBB21_25:                               ; %do.end50
	ldr	w22, [sp, #12]                  ; 4-byte Folded Reload
	tbnz	w28, #0, LBB21_27
; %bb.26:                               ; %if.then54
	ldr	w8, [x23, #2124]
	add	w8, w8, #1
	str	w8, [x23, #2124]
LBB21_27:                               ; %if.end77
	cmp	w21, #1
	b.lt	LBB21_38
; %bb.28:                               ; %for.body83.preheader
	ldr	x8, [x23, #16]
	mov	w9, w21
	subs	w10, w21, #1
	b.eq	LBB21_34
; %bb.29:                               ; %vector.scevcheck
	sub	x11, x9, #1
	cmp	w10, w11
	b.lo	LBB21_34
; %bb.30:                               ; %vector.scevcheck
	lsr	x10, x11, #32
	cbnz	x10, LBB21_34
; %bb.31:                               ; %vector.ph
	and	x11, x9, #0xfffffffe
	and	x10, x9, #0x1
	mov	w12, #-2
	add	x12, x9, x12
	mov	x13, x11
LBB21_32:                               ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
	add	w14, w12, #1
	add	x14, x20, x14, lsl #7
	stp	x8, x20, [x14, #64]
	and	x8, x12, #0xffffffff
	add	x8, x20, x8, lsl #7
	stp	x14, x20, [x8, #64]
	str	w21, [x14, #80]
	str	w21, [x8, #80]
	str	wzr, [x14, #96]
	str	wzr, [x8, #96]
	sub	x12, x12, #2
	sub	x13, x13, #2
	cbnz	x13, LBB21_32
; %bb.33:                               ; %middle.block
	cmp	x11, x9
	b.ne	LBB21_35
	b	LBB21_37
LBB21_34:
	mov	x10, x9
LBB21_35:                               ; %for.body83.preheader1
	add	x9, x10, #1
LBB21_36:                               ; %for.body83
                                        ; =>This Inner Loop Header: Depth=1
	sub	w10, w9, #2
	add	x10, x20, x10, lsl #7
	stp	x8, x20, [x10, #64]
	str	w21, [x10, #80]
	str	wzr, [x10, #96]
	sub	x9, x9, #1
	mov	x8, x10
	cmp	x9, #1
	b.hi	LBB21_36
LBB21_37:                               ; %for.cond80.for.cond.cleanup82_crit_edge
	str	x20, [x23, #16]
LBB21_38:                               ; %for.cond.cleanup82
	ldp	w9, w8, [x23, #64]
	ldr	w10, [x23, #24]
	cmp	w24, w9
	ccmp	w9, w10, #8, le
	ccmp	w8, #0, #0, ge
	csel	w8, w10, w24, ne
	str	w8, [x23, #32]
	add	x0, x23, #40
	bl	_halide_cond_broadcast
	ldp	w9, w8, [x23, #28]
	cmp	w8, w9
	b.le	LBB21_41
; %bb.39:                               ; %if.then107
	add	x0, x23, #48
	bl	_halide_cond_broadcast
	cbz	w22, LBB21_41
; %bb.40:                               ; %if.then109
	add	x0, x23, #56
	bl	_halide_cond_broadcast
LBB21_41:                               ; %if.end111
	orr	w8, w25, w26
	cbz	w8, LBB21_45
; %bb.42:                               ; %if.then115
	cbz	x19, LBB21_44
; %bb.43:                               ; %if.then117
	ldr	w8, [x19, #96]
	sub	w8, w8, #1
	str	w8, [x19, #96]
	b	LBB21_45
LBB21_44:                               ; %if.else120
	ldr	w8, [x23, #2124]
	sub	w8, w8, #1
	str	w8, [x23, #2124]
LBB21_45:                               ; %if.end123
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.loh AdrpLdrGot	Lloh38, Lloh39
	.loh AdrpAdd	Lloh40, Lloh41
	.loh AdrpAdd	Lloh42, Lloh43
	.loh AdrpLdrGot	Lloh44, Lloh45
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE ; -- Begin function _ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	.weak_definition	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	.p2align	2
__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE: ; @_ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
; %bb.0:                                ; %entry
	sub	sp, sp, #112
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	mov	x19, x0
	mov	w22, #0
Lloh46:
	adrp	x20, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh47:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	b	LBB22_3
LBB22_1:                                ; %land.lhs.true307
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	w22, #0
	ldrb	w8, [x21, #124]
	cbz	w8, LBB22_3
LBB22_2:                                ; %if.then310
                                        ;   in Loop: Header=BB22_3 Depth=1
	add	x0, x20, #56
	bl	_halide_cond_broadcast
	mov	w22, #0
LBB22_3:                                ; %while.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB22_8 Depth 2
                                        ;     Child Loop BB22_15 Depth 2
                                        ;       Child Loop BB22_26 Depth 3
                                        ;     Child Loop BB22_32 Depth 2
                                        ;       Child Loop BB22_35 Depth 3
                                        ;         Child Loop BB22_36 Depth 4
                                        ;     Child Loop BB22_73 Depth 2
	cbz	x19, LBB22_10
; %bb.4:                                ; %cond.true
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w9, [x19, #40]
	ldr	w8, [x19, #112]
	orr	w9, w9, w8
	cbz	w9, LBB22_86
; %bb.5:                                ; %if.then
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x21, [x20, #16]
	ldr	w9, [x19, #116]
	cbz	w9, LBB22_45
; %bb.6:                                ; %if.then3
                                        ;   in Loop: Header=BB22_3 Depth=1
	cbnz	w8, LBB22_12
; %bb.7:                                ; %while.cond6.preheader
                                        ;   in Loop: Header=BB22_3 Depth=1
	cmp	x21, x19
	b.eq	LBB22_58
LBB22_8:                                ; %while.body8
                                        ;   Parent Loop BB22_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x8, x21
	ldr	x21, [x21, #64]
	cmp	x21, x19
	b.ne	LBB22_8
; %bb.9:                                ; %while.end.loopexit
                                        ;   in Loop: Header=BB22_3 Depth=1
	add	x8, x8, #64
	b	LBB22_59
LBB22_10:                               ; %cond.end
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldrb	w8, [x20, #2120]
	cbnz	w8, LBB22_86
; %bb.11:                               ; %while.body.thread
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x21, [x20, #16]
LBB22_12:                               ; %do.end
                                        ;   in Loop: Header=BB22_3 Depth=1
	cbz	x21, LBB22_42
; %bb.13:                               ; %do.end27.preheader
                                        ;   in Loop: Header=BB22_3 Depth=1
	add	x24, x20, #16
	b	LBB22_15
LBB22_14:                               ; %cleanup
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	x8, [x21, #64]!
	mov	x24, x21
	mov	x21, x8
	cbz	x8, LBB22_42
LBB22_15:                               ; %do.end27
                                        ;   Parent Loop BB22_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB22_26 Depth 3
	ldr	x8, [x21, #88]
	cbz	x8, LBB22_20
; %bb.16:                               ; %if.else32
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	w10, [x8, #112]
	ldr	w9, [x8, #44]
	cbz	w10, LBB22_28
; %bb.17:                               ; %if.else38
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	w11, [x8, #96]
	neg	w11, w11
	madd	w10, w9, w10, w11
	ldr	w9, [x21, #44]
	cbz	x19, LBB22_21
LBB22_18:                               ; %lor.lhs.false
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	x11, [x21, #72]
	ldr	x12, [x19, #72]
	cmp	x11, x12
	cset	w11, eq
	cmp	w9, #0
	cset	w12, eq
	orr	w11, w11, w12
	ldrb	w12, [x21, #48]
	cbz	w12, LBB22_22
LBB22_19:                               ; %lor.rhs70
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	w12, [x21, #112]
	cmp	w12, #0
	cset	w12, eq
	cmp	w10, w9
	b.ge	LBB22_23
	b	LBB22_14
LBB22_20:                               ; %if.then31
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	w9, [x20, #24]
	ldr	w10, [x20, #2124]
	sub	w9, w9, w10
	add	w10, w9, #1
	ldr	w9, [x21, #44]
	cbnz	x19, LBB22_18
LBB22_21:                               ;   in Loop: Header=BB22_15 Depth=2
	mov	w11, #1
	ldrb	w12, [x21, #48]
	cbnz	w12, LBB22_19
LBB22_22:                               ;   in Loop: Header=BB22_15 Depth=2
	mov	w12, #1
	cmp	w10, w9
	b.lt	LBB22_14
LBB22_23:                               ; %lor.end73
                                        ;   in Loop: Header=BB22_15 Depth=2
	eor	w10, w11, #0x1
	tbnz	w10, #0, LBB22_14
; %bb.24:                               ; %lor.end73
                                        ;   in Loop: Header=BB22_15 Depth=2
	cbz	w12, LBB22_14
; %bb.25:                               ; %if.then86
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	w10, [x21, #120]
	ldr	w11, [x21, #32]
	cmp	w10, w11
	b.ge	LBB22_63
LBB22_26:                               ; %for.body.i
                                        ;   Parent Loop BB22_3 Depth=1
                                        ;     Parent Loop BB22_15 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	x8, [x21, #24]
	add	x8, x8, w10, sxtw #4
	ldr	x0, [x8]
	ldr	w1, [x8, #8]
	bl	_halide_default_semaphore_try_acquire
	cbz	w0, LBB22_14
; %bb.27:                               ; %for.inc.i
                                        ;   in Loop: Header=BB22_26 Depth=3
	ldr	w8, [x21, #120]
	add	w10, w8, #1
	str	w10, [x21, #120]
	ldr	w8, [x21, #32]
	cmp	w10, w8
	b.lt	LBB22_26
	b	LBB22_29
LBB22_28:                               ; %if.then35
                                        ;   in Loop: Header=BB22_15 Depth=2
	ldr	w10, [x8, #96]
	sub	w10, w9, w10
	ldr	w9, [x21, #44]
	cbnz	x19, LBB22_18
	b	LBB22_21
LBB22_29:                               ; %if.else127.loopexit
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	x28, x21
	ldr	x8, [x28, #88]!
	mov	x27, x28
	ldr	w9, [x27, #-44]!
	str	wzr, [x21, #120]
	ldr	w10, [x21, #112]
	add	w10, w10, #1
	str	w10, [x21, #112]
	cbz	x8, LBB22_64
LBB22_30:                               ; %if.else143
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w10, [x8, #96]
	add	w9, w10, w9
	str	w9, [x8, #96]
	ldrb	w8, [x21, #48]
	cbz	w8, LBB22_65
LBB22_31:                               ; %if.then156
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x8, [x21, #64]
	str	x8, [x24]
	mov	x0, x20
	bl	_halide_mutex_unlock
	mov	w24, #0
	mov	w23, #1
LBB22_32:                               ; %while.cond161.preheader
                                        ;   Parent Loop BB22_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB22_35 Depth 3
                                        ;         Child Loop BB22_36 Depth 4
	ldr	w9, [x21, #40]
	sub	w8, w9, w24
	cmp	w8, w23
	b.le	LBB22_39
; %bb.33:                               ; %land.rhs.preheader
                                        ;   in Loop: Header=BB22_32 Depth=2
	ldr	w8, [x21, #120]
	ldr	w10, [x21, #32]
	b	LBB22_35
LBB22_34:                               ; %while.body167
                                        ;   in Loop: Header=BB22_35 Depth=3
	mov	w8, #0
	str	wzr, [x21, #120]
	add	w23, w23, #1
	sub	w11, w9, w24
	cmp	w11, w23
	b.le	LBB22_40
LBB22_35:                               ; %land.rhs
                                        ;   Parent Loop BB22_3 Depth=1
                                        ;     Parent Loop BB22_32 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB22_36 Depth 4
	cmp	w8, w10
	b.ge	LBB22_34
LBB22_36:                               ; %for.body.i480
                                        ;   Parent Loop BB22_3 Depth=1
                                        ;     Parent Loop BB22_32 Depth=2
                                        ;       Parent Loop BB22_35 Depth=3
                                        ; =>      This Inner Loop Header: Depth=4
	ldr	x9, [x21, #24]
	add	x8, x9, w8, sxtw #4
	ldr	x0, [x8]
	ldr	w1, [x8, #8]
	bl	_halide_default_semaphore_try_acquire
	cbz	w0, LBB22_39
; %bb.37:                               ; %for.inc.i483
                                        ;   in Loop: Header=BB22_36 Depth=4
	ldr	w8, [x21, #120]
	add	w8, w8, #1
	str	w8, [x21, #120]
	ldr	w10, [x21, #32]
	cmp	w8, w10
	b.lt	LBB22_36
; %bb.38:                               ; %while.body167.loopexit
                                        ;   in Loop: Header=BB22_35 Depth=3
	ldr	w9, [x21, #40]
	b	LBB22_34
LBB22_39:                               ; %while.end169
                                        ;   in Loop: Header=BB22_32 Depth=2
	cbz	w23, LBB22_48
LBB22_40:                               ; %if.end172
                                        ;   in Loop: Header=BB22_32 Depth=2
	ldr	x0, [x21, #104]
	ldr	w8, [x21, #36]
	add	w2, w8, w24
	ldp	x1, x4, [x21]
	mov	x3, x23
	mov	x5, x21
	bl	_halide_do_loop_task
	add	w24, w23, w24
	mov	w23, #0
	cbz	w0, LBB22_32
; %bb.41:                               ;   in Loop: Header=BB22_3 Depth=1
	mov	x22, x0
	mov	w23, #0
	b	LBB22_49
LBB22_42:                               ; %if.then103
                                        ;   in Loop: Header=BB22_3 Depth=1
	cbz	x19, LBB22_53
; %bb.43:                               ; %if.then105
                                        ;   in Loop: Header=BB22_3 Depth=1
	add	w21, w22, #1
	cmp	w22, #39
	b.gt	LBB22_55
; %bb.44:                               ; %if.then107
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	x0, x20
	bl	_halide_mutex_unlock
	bl	_halide_thread_yield
	mov	x0, x20
	bl	_halide_mutex_lock
	mov	x22, x21
	b	LBB22_3
LBB22_45:                               ; %if.else
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x8, [x19, #88]
	cbz	x8, LBB22_12
; %bb.46:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w8, [x8, #116]
	cbz	w8, LBB22_12
; %bb.47:                               ; %if.then15
                                        ;   in Loop: Header=BB22_3 Depth=1
	str	w8, [x19, #116]
	add	x0, x20, #56
	bl	_halide_cond_broadcast
	b	LBB22_3
LBB22_48:                               ;   in Loop: Header=BB22_3 Depth=1
	mov	w22, #0
	mov	w23, #1
LBB22_49:                               ; %while.end179
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	x0, x20
	bl	_halide_mutex_lock
	ldp	w8, w9, [x21, #36]
	add	w10, w8, w24
	sub	w8, w9, w24
	stp	w10, w8, [x21, #36]
	tbz	w23, #0, LBB22_52
; %bb.50:                               ; %if.else190
                                        ;   in Loop: Header=BB22_3 Depth=1
	cmp	w8, #1
	b.lt	LBB22_81
; %bb.51:                               ; %if.then194
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	w8, #0
	ldr	x9, [x20, #16]
	str	x9, [x21, #64]
	str	x21, [x20, #16]
	ldr	x10, [x28]
	ldr	w9, [x27]
	cbnz	x10, LBB22_78
	b	LBB22_82
LBB22_52:                               ; %if.end230.thread502
                                        ;   in Loop: Header=BB22_3 Depth=1
	str	wzr, [x21, #40]
	b	LBB22_68
LBB22_53:                               ; %if.else112
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w8, [x20, #64]
	add	w8, w8, #1
	str	w8, [x20, #64]
	ldp	w8, w9, [x20, #28]
	cmp	w8, w9
	b.le	LBB22_56
; %bb.54:                               ; %if.then115
                                        ;   in Loop: Header=BB22_3 Depth=1
	sub	w8, w8, #1
	str	w8, [x20, #28]
	add	x0, x20, #48
	mov	x1, x20
	bl	_halide_cond_wait
	ldr	w8, [x20, #28]
	add	w8, w8, #1
	str	w8, [x20, #28]
	b	LBB22_62
LBB22_55:                               ; %if.else108
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w8, [x20, #68]
	add	w8, w8, #1
	str	w8, [x20, #68]
	mov	w8, #1
	strb	w8, [x19, #124]
	add	x0, x20, #56
	mov	x1, x20
	bl	_halide_cond_wait
	strb	wzr, [x19, #124]
	ldr	w8, [x20, #68]
	sub	w8, w8, #1
	str	w8, [x20, #68]
	mov	x22, x21
	b	LBB22_3
LBB22_56:                               ; %if.else118
                                        ;   in Loop: Header=BB22_3 Depth=1
	add	w21, w22, #1
	cmp	w22, #39
	b.gt	LBB22_60
; %bb.57:                               ; %if.then121
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	x0, x20
	bl	_halide_mutex_unlock
	bl	_halide_thread_yield
	mov	x0, x20
	bl	_halide_mutex_lock
	b	LBB22_61
LBB22_58:                               ;   in Loop: Header=BB22_3 Depth=1
	add	x8, x20, #16
LBB22_59:                               ; %while.end
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x9, [x19, #64]
	str	x9, [x8]
	str	wzr, [x19, #40]
	b	LBB22_3
LBB22_60:                               ; %if.else122
                                        ;   in Loop: Header=BB22_3 Depth=1
	add	x0, x20, #40
	mov	x1, x20
	bl	_halide_cond_wait
LBB22_61:                               ; %if.end124
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	x22, x21
LBB22_62:                               ; %if.end124
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w8, [x20, #64]
	sub	w8, w8, #1
	str	w8, [x20, #64]
	b	LBB22_3
LBB22_63:                               ; %if.else127.loopexit63
                                        ;   in Loop: Header=BB22_3 Depth=1
	add	x28, x21, #88
	add	x27, x21, #44
	str	wzr, [x21, #120]
	ldr	w10, [x21, #112]
	add	w10, w10, #1
	str	w10, [x21, #112]
	cbnz	x8, LBB22_30
LBB22_64:                               ; %if.then136
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w8, [x20, #2124]
	add	w8, w8, w9
	str	w8, [x20, #2124]
	ldrb	w8, [x21, #48]
	cbnz	w8, LBB22_31
LBB22_65:                               ; %if.else198
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldp	x8, x22, [x21]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	ldr	x26, [x21, #56]
	ldr	x25, [x21, #104]
	ldp	w23, w8, [x21, #36]
	add	w9, w23, #1
	subs	w8, w8, #1
	stp	w9, w8, [x21, #36]
	b.eq	LBB22_79
; %bb.66:                               ; %if.end210
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	x0, x20
	bl	_halide_mutex_unlock
	mov	x0, x25
	cbz	x26, LBB22_80
LBB22_67:                               ; %if.then212
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	x1, x26
	mov	x2, x23
	mov	x3, x22
	bl	_halide_do_task
	mov	x22, x0
	mov	x0, x20
	bl	_halide_mutex_lock
	cbz	w22, LBB22_81
LBB22_68:                               ; %if.then238
                                        ;   in Loop: Header=BB22_3 Depth=1
	str	w22, [x21, #116]
	ldr	w9, [x21, #80]
	cmp	w9, #1
	b.lt	LBB22_76
; %bb.69:                               ; %do.end243.lr.ph
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	w8, #0
	ldr	x10, [x21, #72]
	add	x10, x10, #116
	b	LBB22_73
LBB22_70:                               ; %land.rhs254
                                        ;   in Loop: Header=BB22_73 Depth=2
	ldrb	w11, [x10, #8]
LBB22_71:                               ; %land.end260
                                        ;   in Loop: Header=BB22_73 Depth=2
	and	w8, w8, #0x1
	orr	w8, w11, w8
LBB22_72:                               ; %for.inc
                                        ;   in Loop: Header=BB22_73 Depth=2
	add	x10, x10, #128
	subs	x9, x9, #1
	b.eq	LBB22_77
LBB22_73:                               ; %do.end243
                                        ;   Parent Loop BB22_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w11, [x10]
	cbnz	w11, LBB22_72
; %bb.74:                               ; %if.then247
                                        ;   in Loop: Header=BB22_73 Depth=2
	str	w22, [x10]
	ldr	w11, [x21, #112]
	cbz	w11, LBB22_70
; %bb.75:                               ;   in Loop: Header=BB22_73 Depth=2
	mov	w11, #0
	b	LBB22_71
LBB22_76:                               ;   in Loop: Header=BB22_3 Depth=1
	mov	w8, #0
LBB22_77:                               ; %if.end271
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x10, [x28]
	ldr	w9, [x27]
	cbz	x10, LBB22_82
LBB22_78:                               ; %if.else281
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w11, [x10, #96]
	sub	w9, w11, w9
	str	w9, [x10, #96]
	ldr	w9, [x21, #112]
	sub	w9, w9, #1
	str	w9, [x21, #112]
	tbnz	w8, #0, LBB22_2
	b	LBB22_83
LBB22_79:                               ; %if.then208
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x8, [x21, #64]
	str	x8, [x24]
	mov	x0, x20
	bl	_halide_mutex_unlock
	mov	x0, x25
	cbnz	x26, LBB22_67
LBB22_80:                               ; %if.else220
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	x1, [sp, #8]                    ; 8-byte Folded Reload
	mov	x2, x23
	mov	w3, #1
	mov	x4, x22
	mov	x5, x21
	bl	_halide_do_loop_task
	mov	x22, x0
	mov	x0, x20
	bl	_halide_mutex_lock
	cbnz	w22, LBB22_68
LBB22_81:                               ;   in Loop: Header=BB22_3 Depth=1
	mov	w8, #0
	ldr	x10, [x28]
	ldr	w9, [x27]
	cbnz	x10, LBB22_78
LBB22_82:                               ; %if.then274
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w10, [x20, #2124]
	sub	w9, w10, w9
	str	w9, [x20, #2124]
	ldr	w9, [x21, #112]
	sub	w9, w9, #1
	str	w9, [x21, #112]
	tbnz	w8, #0, LBB22_2
LBB22_83:                               ; %lor.lhs.false297
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	w22, #0
	cbnz	w9, LBB22_3
; %bb.84:                               ; %land.lhs.true300
                                        ;   in Loop: Header=BB22_3 Depth=1
	ldr	w8, [x21, #40]
	cbz	w8, LBB22_1
; %bb.85:                               ; %lor.lhs.false304
                                        ;   in Loop: Header=BB22_3 Depth=1
	mov	w22, #0
	ldr	w8, [x21, #116]
	cbnz	w8, LBB22_1
	b	LBB22_3
LBB22_86:                               ; %while.end316
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.loh AdrpLdrGot	Lloh46, Lloh47
                                        ; -- End function
	.globl	_halide_mutex_unlock            ; -- Begin function halide_mutex_unlock
	.weak_definition	_halide_mutex_unlock
	.p2align	2
_halide_mutex_unlock:                   ; @halide_mutex_unlock
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	w8, #1
	casl	x8, xzr, [x0]
	cmp	x8, #1
	b.eq	LBB23_3
; %bb.1:                                ; %if.then.i
	mov	x1, x0
	mov	w8, #1
	casl	x8, xzr, [x0]
	cmp	x8, #1
	b.eq	LBB23_3
; %bb.2:                                ; %if.end.i.i
Lloh48:
	adrp	x8, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGE
Lloh49:
	ldr	x8, [x8, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGEOFF]
	add	x8, x8, #16
	stp	x8, x1, [sp]
	mov	x0, sp
	bl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
LBB23_3:                                ; %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex6unlockEv.exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpLdrGot	Lloh48, Lloh49
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy: ; @_ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	x21, x1
	mov	x20, x0
	mov	x0, x1
	bl	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	mov	x19, x0
	mov	x24, #0
	mov	x25, x0
	ldr	x22, [x25, #8]!
	mov	w26, #1
                                        ; implicit-def: $x0
	b	LBB24_2
LBB24_1:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit
                                        ;   in Loop: Header=BB24_2 Depth=1
	strb	wzr, [x22, #128]
	add	x0, x22, #64
	bl	_pthread_cond_signal
	mov	x0, x22
	bl	_pthread_mutex_unlock
	mov	w0, w23
	cmp	x27, x21
	b.eq	LBB24_16
LBB24_2:                                ; %while.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB24_6 Depth 2
	cbz	x22, LBB24_13
; %bb.3:                                ; %while.body
                                        ;   in Loop: Header=BB24_2 Depth=1
	ldr	x27, [x22, #136]
	mov	x9, x22
	ldr	x8, [x9, #144]!
	cmp	x27, x21
	b.ne	LBB24_8
; %bb.4:                                ; %if.then
                                        ;   in Loop: Header=BB24_2 Depth=1
	str	x8, [x25]
	ldr	x9, [x19, #16]
	cmp	x9, x22
	b.eq	LBB24_9
; %bb.5:                                ; %while.cond7.preheader
                                        ;   in Loop: Header=BB24_2 Depth=1
	cbz	x8, LBB24_10
LBB24_6:                                ; %while.body9
                                        ;   Parent Loop BB24_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x9, [x8, #136]
	ldr	x8, [x8, #144]
	cmp	x8, #0
	ccmp	x9, x21, #4, ne
	b.ne	LBB24_6
; %bb.7:                                ; %if.end.loopexit
                                        ;   in Loop: Header=BB24_2 Depth=1
	cmp	x9, x21
	cset	w23, eq
	b	LBB24_11
LBB24_8:                                ;   in Loop: Header=BB24_2 Depth=1
	mov	x25, x9
	mov	x24, x22
	mov	x22, x8
	cmp	x27, x21
	b.ne	LBB24_2
	b	LBB24_16
LBB24_9:                                ; %if.then5
                                        ;   in Loop: Header=BB24_2 Depth=1
	mov	w23, #0
	str	x24, [x19, #16]
	b	LBB24_11
LBB24_10:                               ;   in Loop: Header=BB24_2 Depth=1
	mov	w23, #0
LBB24_11:                               ; %if.end
                                        ;   in Loop: Header=BB24_2 Depth=1
	ldr	x8, [x20]
	ldr	x8, [x8, #16]
	mov	x0, x20
	mov	w1, #1
	mov	x2, x23
	blr	x8
	str	x0, [x22, #152]
	mov	x0, x22
	bl	_pthread_mutex_lock
	ldclrl	x26, x8, [x19]
	and	x9, x8, #0x2
	cmp	x8, #4
	ccmp	x9, #0, #0, hs
	b.ne	LBB24_1
; %bb.12:                               ; %if.then.i
                                        ;   in Loop: Header=BB24_2 Depth=1
	mov	x0, x19
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
	b	LBB24_1
LBB24_13:                               ; %while.end22
	ldr	x8, [x20]
	ldr	x8, [x8, #16]
	mov	x0, x20
	mov	w1, #0
	mov	w2, #0
	blr	x8
	mov	w8, #1
	ldclrl	x8, x8, [x19]
	and	x9, x8, #0x2
	cmp	x8, #4
	ccmp	x9, #0, #0, hs
	b.ne	LBB24_15
; %bb.14:                               ; %if.then.i68
	mov	x0, x19
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB24_15:                               ; %cleanup27
	mov	x0, #0
LBB24_16:                               ; %cleanup27
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy: ; @_ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x8, #0
	mov	x9, #31765
	movk	x9, #32586, lsl #16
	movk	x9, #31161, lsl #32
	movk	x9, #40503, lsl #48
	mul	x9, x0, x9
	lsr	x9, x9, #54
	mov	w10, #24
Lloh50:
	adrp	x11, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGE
Lloh51:
	ldr	x11, [x11, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGEOFF]
	madd	x19, x9, x10, x11
	mov	w9, #1
	casa	x8, x9, [x19]
	cmp	x8, #0
	b.eq	LBB25_2
; %bb.1:                                ; %if.then.i
	mov	x0, x19
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB25_2:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock4lockEv.exit
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh50, Lloh51
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv: ; @_ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x19, x0
	ldr	x8, [x0]
LBB26_1:                                ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	cmp	x8, #4
	b.lo	LBB26_16
; %bb.2:                                ; %while.cond
                                        ;   in Loop: Header=BB26_1 Depth=1
	tbnz	w8, #1, LBB26_16
; %bb.3:                                ; %if.end
                                        ;   in Loop: Header=BB26_1 Depth=1
	orr	x9, x8, #0x2
	mov	x22, x8
	casa	x22, x9, [x19]
	cmp	x22, x8
	mov	x8, x22
	b.ne	LBB26_1
; %bb.4:                                ; %while.cond11.preheader
Lloh52:
	adrp	x20, l_.str.5@PAGE
Lloh53:
	add	x20, x20, l_.str.5@PAGEOFF
	and	x23, x22, #0xfffffffffffffffc
	ldr	x21, [x23, #152]
	cbz	x21, LBB26_12
LBB26_5:                                ; %while.end23
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB26_8 Depth 2
	str	x21, [x23, #152]
	tbnz	w22, #0, LBB26_10
; %bb.6:                                ; %if.end35
                                        ;   in Loop: Header=BB26_5 Depth=1
	ldr	x8, [x21, #144]
	cbnz	x8, LBB26_17
; %bb.7:                                ; %while.body41.preheader
                                        ;   in Loop: Header=BB26_5 Depth=1
	mov	x8, x22
LBB26_8:                                ; %while.body41
                                        ;   Parent Loop BB26_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	and	x9, x22, #0x1
	casal	x8, x9, [x19]
	cmp	x8, x22
	b.eq	LBB26_18
; %bb.9:                                ; %if.end47
                                        ;   in Loop: Header=BB26_8 Depth=2
	mov	x22, x8
	cmp	x8, #4
	b.lo	LBB26_8
	b	LBB26_11
LBB26_10:                               ; %if.then27
                                        ;   in Loop: Header=BB26_5 Depth=1
	and	x9, x22, #0xfffffffffffffffd
	mov	x8, x22
	casal	x8, x9, [x19]
	cmp	x8, x22
	b.eq	LBB26_16
LBB26_11:                               ; %cleanup70
                                        ;   in Loop: Header=BB26_5 Depth=1
	dmb	ishld
	mov	x22, x8
	and	x23, x22, #0xfffffffffffffffc
	ldr	x21, [x23, #152]
	cbnz	x21, LBB26_5
LBB26_12:                               ; %while.body17.preheader
	mov	x24, x23
	b	LBB26_14
LBB26_13:                               ; %do.end
                                        ;   in Loop: Header=BB26_14 Depth=1
	str	x24, [x25, #144]
	ldr	x21, [x25, #152]
	mov	x24, x25
	cbnz	x21, LBB26_5
LBB26_14:                               ; %while.body17
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x25, [x24, #136]
	cbnz	x25, LBB26_13
; %bb.15:                               ; %if.then20
                                        ;   in Loop: Header=BB26_14 Depth=1
	mov	x0, #0
	mov	x1, x20
	bl	_halide_print
	bl	_abort
	b	LBB26_13
LBB26_16:                               ; %cleanup75
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
LBB26_17:                               ; %if.else62
	str	x8, [x23, #152]
	mov	w8, #2
	ldclrl	x8, x8, [x19]
LBB26_18:                               ; %if.end66
	mov	x0, x21
	bl	_pthread_mutex_lock
	strb	wzr, [x21, #128]
	add	x0, x21, #64
	bl	_pthread_cond_signal
	mov	x0, x21
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_pthread_mutex_unlock
	.loh AdrpAdd	Lloh52, Lloh53
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv: ; @_ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
; %bb.0:                                ; %entry
	sub	sp, sp, #240
	stp	x26, x25, [sp, #160]            ; 16-byte Folded Spill
	stp	x24, x23, [sp, #176]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #192]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #208]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #224]            ; 16-byte Folded Spill
	add	x29, sp, #224
	mov	x19, x0
	ldr	x24, [x0]
	mov	x21, sp
	add	x20, x21, #64
	mov	w23, #40
	mov	w22, #1
	tbnz	w24, #0, LBB27_6
	b	LBB27_2
LBB27_1:                                ; %_ZN6Halide7Runtime8Internal15Synchronization13thread_parker4parkEv.exit
                                        ;   in Loop: Header=BB27_6 Depth=1
	mov	x0, sp
	bl	_pthread_mutex_unlock
	ldr	x24, [x19]
	mov	w23, #40
	mov	x0, x20
	bl	_pthread_cond_destroy
	mov	x0, sp
	bl	_pthread_mutex_destroy
	tbnz	w24, #0, LBB27_6
LBB27_2:                                ; %if.then.preheader
	mov	x8, x24
LBB27_3:                                ; %if.then
                                        ; =>This Inner Loop Header: Depth=1
	orr	x9, x24, #0x1
	casa	x8, x9, [x19]
	cmp	x8, x24
	b.eq	LBB27_17
; %bb.4:                                ; %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_acquire_relaxedEPyS4_S4_.exit
                                        ;   in Loop: Header=BB27_3 Depth=1
	mov	x24, x8
	tbz	w8, #0, LBB27_3
; %bb.5:                                ; %if.end4.loopexit
	mov	x24, x8
LBB27_6:                                ; %if.end4
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB27_14 Depth 2
	cmp	x24, #4
	b.lo	LBB27_11
; %bb.7:                                ; %if.end4
                                        ;   in Loop: Header=BB27_6 Depth=1
	subs	w25, w23, #1
	b.lt	LBB27_11
; %bb.8:                                ; %_ZN6Halide7Runtime8Internal15Synchronization12spin_control11should_spinEv.exit
                                        ;   in Loop: Header=BB27_6 Depth=1
	b.eq	LBB27_10
; %bb.9:                                ; %if.then7
                                        ;   in Loop: Header=BB27_6 Depth=1
	bl	_halide_thread_yield
	ldr	x24, [x19]
	mov	x23, x25
	tbz	w24, #0, LBB27_2
	b	LBB27_6
LBB27_10:                               ;   in Loop: Header=BB27_6 Depth=1
	mov	w23, #0
LBB27_11:                               ; %if.end9
                                        ;   in Loop: Header=BB27_6 Depth=1
	strb	wzr, [sp, #128]
	mov	x0, sp
	mov	x1, #0
	bl	_pthread_mutex_init
	mov	x0, x20
	mov	x1, #0
	bl	_pthread_cond_init
	stp	xzr, xzr, [sp, #136]
	str	xzr, [sp, #152]
	strb	w22, [sp, #128]
	ands	x8, x24, #0xfffffffffffffffc
	b.eq	LBB27_15
; %bb.12:                               ; %if.else
                                        ;   in Loop: Header=BB27_6 Depth=1
	str	x8, [sp, #136]
	mov	x9, sp
	bfxil	x9, x24, #0, #2
	mov	x8, x24
	casl	x8, x9, [x19]
	cmp	x8, x24
	b.ne	LBB27_16
LBB27_13:                               ; %if.then19
                                        ;   in Loop: Header=BB27_6 Depth=1
	mov	x0, sp
	bl	_pthread_mutex_lock
	ldrb	w8, [sp, #128]
	cbz	w8, LBB27_1
LBB27_14:                               ; %while.body.i
                                        ;   Parent Loop BB27_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x1, sp
	mov	x0, x20
	bl	_pthread_cond_wait
	ldrb	w8, [sp, #128]
	cbnz	w8, LBB27_14
	b	LBB27_1
LBB27_15:                               ; %if.then12
                                        ;   in Loop: Header=BB27_6 Depth=1
	str	x21, [sp, #152]
	mov	x9, sp
	bfxil	x9, x24, #0, #2
	mov	x8, x24
	casl	x8, x9, [x19]
	cmp	x8, x24
	b.eq	LBB27_13
LBB27_16:                               ; %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_release_relaxedEPyS4_S4_.exit
                                        ;   in Loop: Header=BB27_6 Depth=1
	mov	x24, x8
	mov	x0, x20
	bl	_pthread_cond_destroy
	mov	x0, sp
	bl	_pthread_mutex_destroy
	tbz	w24, #0, LBB27_2
	b	LBB27_6
LBB27_17:                               ; %cleanup23
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #208]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #192]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #176]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #160]            ; 16-byte Folded Reload
	add	sp, sp, #240
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE: ; @_ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x8, [x0, #8]
	ldr	x8, [x8]
	cmp	x8, #3
	cset	w0, eq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv: ; @_ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib: ; @_ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	cmp	w2, #0
	mov	w8, #2
	csel	x8, x8, xzr, ne
	ldr	x9, [x0, #8]
	stlr	x8, [x9]
	mov	x0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb: ; @_ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_cond_broadcast          ; -- Begin function halide_cond_broadcast
	.weak_definition	_halide_cond_broadcast
	.p2align	2
_halide_cond_broadcast:                 ; @halide_cond_broadcast
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	ldr	x2, [x0]
	cbz	x2, LBB32_2
; %bb.1:                                ; %if.end.i
	mov	x1, x0
Lloh54:
	adrp	x8, __ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE@GOTPAGE
Lloh55:
	ldr	x8, [x8, __ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE@GOTPAGEOFF]
	add	x8, x8, #16
	stp	x8, x0, [sp, #8]
	str	x2, [sp, #24]
	add	x0, sp, #8
	mov	x3, #0
	bl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
LBB32_2:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9fast_cond9broadcastEv.exit
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.loh AdrpLdrGot	Lloh54, Lloh55
                                        ; -- End function
	.globl	_halide_default_semaphore_try_acquire ; -- Begin function halide_default_semaphore_try_acquire
	.weak_definition	_halide_default_semaphore_try_acquire
	.p2align	2
_halide_default_semaphore_try_acquire:  ; @halide_default_semaphore_try_acquire
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	cbz	w1, LBB33_6
; %bb.1:                                ; %if.end
	ldar	w11, [x0]
	subs	w10, w11, w1
	b.mi	LBB33_7
; %bb.2:                                ; %land.rhs.preheader
	mov	x9, x11
LBB33_3:                                ; %land.rhs
                                        ; =>This Inner Loop Header: Depth=1
	casal	w9, w10, [x0]
	cmp	w9, w11
	cset	w8, eq
	b.eq	LBB33_5
; %bb.4:                                ; %land.rhs
                                        ;   in Loop: Header=BB33_3 Depth=1
	sub	w10, w9, w1
	mov	x11, x9
	tbz	w10, #31, LBB33_3
LBB33_5:                                ; %return
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB33_6:
	mov	w8, #1
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB33_7:
	mov	w8, #0
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_cond_wait               ; -- Begin function halide_cond_wait
	.weak_definition	_halide_cond_wait
	.p2align	2
_halide_cond_wait:                      ; @halide_cond_wait
; %bb.0:                                ; %entry
	sub	sp, sp, #96
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	x19, x1
	mov	x1, x0
Lloh56:
	adrp	x8, __ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE@GOTPAGE
Lloh57:
	ldr	x8, [x8, __ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE@GOTPAGEOFF]
	add	x8, x8, #16
	stp	x8, x0, [sp, #8]
	str	x19, [sp, #24]
	add	x0, sp, #8
	bl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	cmp	x0, x19
	b.ne	LBB34_3
; %bb.1:                                ; %if.else.i
	ldr	x8, [x19]
	tbnz	w8, #0, LBB34_4
; %bb.2:                                ; %if.then2.i
Lloh58:
	adrp	x1, l_.str.5.6@PAGE
Lloh59:
	add	x1, x1, l_.str.5.6@PAGEOFF
	mov	x0, #0
	bl	_halide_print
	bl	_abort
	b	LBB34_4
LBB34_3:                                ; %if.then.i
	mov	x8, #0
	mov	w9, #1
	casa	x8, x9, [x19]
	cmp	x8, #0
	b.ne	LBB34_5
LBB34_4:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9fast_cond4waitEPNS2_10fast_mutexE.exit
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
LBB34_5:                                ; %if.then.i.i
	ldr	x9, [x19]
	mov	w8, #40
Lloh60:
	adrp	x10, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGE
Lloh61:
	ldr	x10, [x10, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGEOFF]
	add	x20, x10, #16
LBB34_6:                                ; %while.cond.outer.i.i.i
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB34_8 Depth 2
	tbnz	w9, #0, LBB34_11
; %bb.7:                                ; %if.then.i.i.i.preheader
                                        ;   in Loop: Header=BB34_6 Depth=1
	mov	x10, x9
LBB34_8:                                ; %if.then.i.i.i
                                        ;   Parent Loop BB34_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	orr	x11, x9, #0x1
	casa	x10, x11, [x19]
	cmp	x10, x9
	b.eq	LBB34_4
; %bb.9:                                ; %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_acquire_relaxedEPyS4_S4_.exit.i.i.i
                                        ;   in Loop: Header=BB34_8 Depth=2
	mov	x9, x10
	tbz	w10, #0, LBB34_8
; %bb.10:                               ; %if.end4.i.i.i.loopexit
                                        ;   in Loop: Header=BB34_6 Depth=1
	mov	x9, x10
LBB34_11:                               ; %if.end4.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	subs	w21, w8, #1
	b.ge	LBB34_15
; %bb.12:                               ; %if.end8.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	tbnz	w9, #1, LBB34_18
LBB34_13:                               ; %if.then10.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	orr	x11, x9, #0x2
	mov	x10, x9
	cas	x10, x11, [x19]
	cmp	x10, x9
	b.eq	LBB34_18
; %bb.14:                               ; %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_relaxed_relaxedEPyS4_S4_.exit.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	mov	x9, x10
	b	LBB34_6
LBB34_15:                               ; %_ZN6Halide7Runtime8Internal15Synchronization12spin_control11should_spinEv.exit.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	b.eq	LBB34_17
; %bb.16:                               ; %if.then6.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	bl	_halide_thread_yield
	ldr	x9, [x19]
	mov	x8, x21
	b	LBB34_6
LBB34_17:                               ;   in Loop: Header=BB34_6 Depth=1
	mov	w8, #0
	tbz	w9, #1, LBB34_13
LBB34_18:                               ; %if.end19.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	stp	x20, x19, [sp, #32]
	add	x0, sp, #32
	mov	x1, x19
	bl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	cmp	x0, x19
	b.eq	LBB34_4
; %bb.19:                               ; %if.end24.i.i.i
                                        ;   in Loop: Header=BB34_6 Depth=1
	ldr	x9, [x19]
	mov	w8, #40
	b	LBB34_6
	.loh AdrpLdrGot	Lloh56, Lloh57
	.loh AdrpAdd	Lloh58, Lloh59
	.loh AdrpLdrGot	Lloh60, Lloh61
                                        ; -- End function
	.globl	_halide_do_loop_task            ; -- Begin function halide_do_loop_task
	.weak_definition	_halide_do_loop_task
	.p2align	2
_halide_do_loop_task:                   ; @halide_do_loop_task
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh62:
	adrp	x8, __ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPAGE
Lloh63:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPAGEOFF]
Lloh64:
	ldr	x6, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x6
	.loh AdrpLdrGotLdr	Lloh62, Lloh63, Lloh64
                                        ; -- End function
	.globl	_halide_do_task                 ; -- Begin function halide_do_task
	.weak_definition	_halide_do_task
	.p2align	2
_halide_do_task:                        ; @halide_do_task
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh65:
	adrp	x8, __ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPAGE
Lloh66:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPAGEOFF]
Lloh67:
	ldr	x4, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x4
	.loh AdrpLdrGotLdr	Lloh65, Lloh66, Lloh67
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy: ; @_ZN6Halide7Runtime8Internal15Synchronization15parking_control4parkEy
; %bb.0:                                ; %entry
	sub	sp, sp, #240
	stp	x24, x23, [sp, #176]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #192]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #208]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #224]            ; 16-byte Folded Spill
	add	x29, sp, #224
	mov	x22, x1
	mov	x20, x0
	strb	wzr, [sp, #144]
	add	x23, sp, #16
	add	x0, sp, #16
	mov	x1, #0
	bl	_pthread_mutex_init
	add	x19, x23, #64
	mov	x0, x19
	mov	x1, #0
	bl	_pthread_cond_init
	stp	xzr, xzr, [sp, #152]
	str	xzr, [sp, #168]
	mov	x0, x22
	bl	__ZN6Halide7Runtime8Internal15Synchronization11lock_bucketEy
	mov	x21, x0
	strb	wzr, [sp]
	mov	x24, sp
	str	xzr, [sp, #8]
	ldr	x8, [x20]
	ldr	x8, [x8]
	mov	x1, sp
	mov	x0, x20
	blr	x8
	tbz	w0, #0, LBB37_7
; %bb.1:                                ; %if.end
	stp	x22, xzr, [sp, #152]
	mov	w8, #1
	strb	w8, [sp, #144]
	mov	x9, x21
	ldr	x10, [x9, #8]!
	ldr	x11, [x21, #16]
	add	x11, x11, #144
	cmp	x10, #0
	csel	x9, x9, x11, eq
	str	x23, [x9]
	str	x23, [x21, #16]
	ldclrl	x8, x8, [x21]
	cmp	x8, #4
	b.lo	LBB37_4
; %bb.2:                                ; %if.end
	tbnz	w8, #1, LBB37_4
; %bb.3:                                ; %if.then.i27
	mov	x0, x21
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB37_4:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit28
	add	x22, x23, #152
	ldr	x8, [x20]
	ldr	x8, [x8, #8]
	mov	x0, x20
	blr	x8
	add	x0, sp, #16
	bl	_pthread_mutex_lock
	ldrb	w8, [sp, #144]
	cbz	w8, LBB37_6
LBB37_5:                                ; %while.body.i
                                        ; =>This Inner Loop Header: Depth=1
	add	x1, sp, #16
	mov	x0, x19
	bl	_pthread_cond_wait
	ldrb	w8, [sp, #144]
	cbnz	w8, LBB37_5
LBB37_6:                                ; %_ZN6Halide7Runtime8Internal15Synchronization13thread_parker4parkEv.exit
	add	x0, sp, #16
	bl	_pthread_mutex_unlock
	b	LBB37_9
LBB37_7:                                ; %if.then
	add	x22, x24, #8
	mov	w8, #1
	ldclrl	x8, x8, [x21]
	and	x9, x8, #0x2
	cmp	x8, #4
	ccmp	x9, #0, #0, hs
	b.ne	LBB37_9
; %bb.8:                                ; %if.then.i
	mov	x0, x21
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB37_9:                                ; %cleanup
	ldr	x20, [x22]
	mov	x0, x19
	bl	_pthread_cond_destroy
	add	x0, sp, #16
	bl	_pthread_mutex_destroy
	mov	x0, x20
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #208]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #192]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #176]            ; 16-byte Folded Reload
	add	sp, sp, #240
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE: ; @_ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x9, x8, [x0, #8]
	ldr	x10, [x9]
	cbz	x10, LBB38_3
; %bb.1:                                ; %if.else
	cmp	x10, x8
	b.ne	LBB38_4
; %bb.2:
	mov	w0, #1
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB38_3:                                ; %if.then
	str	x8, [x9]
	mov	w0, #1
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB38_4:                                ; %if.then5
	mov	w0, #0
	str	x8, [x1, #8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv: ; @_ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
; %bb.0:                                ; %entry
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	ldr	x1, [x0, #16]
	mov	w8, #1
	casl	x8, xzr, [x1]
	cmp	x8, #1
	b.eq	LBB39_3
; %bb.1:                                ; %if.then.i
	mov	w8, #1
	casl	x8, xzr, [x1]
	cmp	x8, #1
	b.eq	LBB39_3
; %bb.2:                                ; %if.end.i.i
Lloh68:
	adrp	x8, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGE
Lloh69:
	ldr	x8, [x8, __ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE@GOTPAGEOFF]
	add	x8, x8, #16
	stp	x8, x1, [sp]
	mov	x0, sp
	bl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
LBB39_3:                                ; %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex6unlockEv.exit
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpLdrGot	Lloh68, Lloh69
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib: ; @_ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
; %bb.0:                                ; %entry
	tbnz	w2, #0, LBB40_2
; %bb.1:                                ; %if.then
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x8, [x0, #8]
	str	xzr, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
LBB40_2:                                ; %if.end
	mov	x0, #0
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy: ; @_ZN6Halide7Runtime8Internal15Synchronization15parking_control14unpark_requeueEyyy
; %bb.0:                                ; %entry
	sub	sp, sp, #96
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	x19, x3
	mov	x22, x2
	mov	x23, x1
	mov	x20, x0
	add	x8, sp, #16
	mov	x0, x1
	mov	x1, x2
	bl	__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
	strb	wzr, [sp]
	str	xzr, [sp, #8]
	ldr	x8, [x20]
	ldr	x8, [x8]
	mov	x1, sp
	mov	x0, x20
	blr	x8
	tbz	w0, #0, LBB41_13
; %bb.1:                                ; %if.end
	ldr	x10, [sp, #16]
	ldr	x11, [x10, #8]!
	cbz	x11, LBB41_18
; %bb.2:                                ; %while.body.preheader
	mov	x21, #0
	mov	x9, #0
	mov	x8, #0
	mov	x12, #0
	b	LBB41_5
LBB41_3:                                ;   in Loop: Header=BB41_5 Depth=1
	mov	x10, x14
	mov	x12, x13
LBB41_4:                                ; %if.end22
                                        ;   in Loop: Header=BB41_5 Depth=1
	cbz	x11, LBB41_14
LBB41_5:                                ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	mov	x13, x11
	ldr	x15, [x11, #136]
	mov	x14, x11
	ldr	x11, [x14, #144]!
	cmp	x15, x23
	b.ne	LBB41_3
; %bb.6:                                ; %if.then4
                                        ;   in Loop: Header=BB41_5 Depth=1
	str	x11, [x10]
	ldr	x14, [sp, #16]
	ldr	x15, [x14, #16]
	cmp	x15, x13
	b.eq	LBB41_11
; %bb.7:                                ; %if.end10
                                        ;   in Loop: Header=BB41_5 Depth=1
	ldrb	w14, [sp]
	cmp	w14, #0
	ccmp	x21, #0, #0, ne
	b.eq	LBB41_12
LBB41_8:                                ; %if.else
                                        ;   in Loop: Header=BB41_5 Depth=1
	mov	x0, x13
	cbz	x8, LBB41_10
; %bb.9:                                ; %if.else15
                                        ;   in Loop: Header=BB41_5 Depth=1
	str	x13, [x9, #144]
	mov	x0, x8
LBB41_10:                               ; %if.end17
                                        ;   in Loop: Header=BB41_5 Depth=1
	str	x22, [x13, #136]
	mov	x8, x0
	mov	x9, x13
	b	LBB41_4
LBB41_11:                               ; %if.then7
                                        ;   in Loop: Header=BB41_5 Depth=1
	str	x12, [x14, #16]
	ldrb	w14, [sp]
	cmp	w14, #0
	ccmp	x21, #0, #0, ne
	b.ne	LBB41_8
LBB41_12:                               ;   in Loop: Header=BB41_5 Depth=1
	mov	x21, x13
	b	LBB41_4
LBB41_13:                               ; %if.then
	add	x0, sp, #16
	bl	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	mov	w0, #0
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
LBB41_14:                               ; %while.end
	cbz	x8, LBB41_19
; %bb.15:                               ; %if.then24
	str	xzr, [x9, #144]
	ldr	x10, [sp, #24]
	mov	x11, x10
	ldr	x12, [x11, #8]!
	cbz	x12, LBB41_17
; %bb.16:                               ; %if.else31
	ldr	x11, [x10, #16]
	add	x11, x11, #144
LBB41_17:                               ; %if.end35
	str	x8, [x11]
	str	x9, [x10, #16]
	mov	w3, #1
	b	LBB41_20
LBB41_18:
	mov	w3, #0
	mov	x21, #0
	b	LBB41_20
LBB41_19:
	mov	w3, #0
LBB41_20:                               ; %if.end38
	cmp	x21, #0
	cset	w2, ne
	ldr	x8, [x20]
	ldr	x8, [x8, #24]
	mov	x1, sp
	mov	x0, x20
	blr	x8
	cbz	x21, LBB41_22
; %bb.21:                               ; %if.then44
	str	x19, [x21, #152]
	mov	x0, x21
	bl	_pthread_mutex_lock
	add	x0, sp, #16
	bl	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	strb	wzr, [x21, #128]
	add	x0, x21, #64
	bl	_pthread_cond_signal
	mov	x0, x21
	bl	_pthread_mutex_unlock
	b	LBB41_23
LBB41_22:                               ; %if.else48
	add	x0, sp, #16
	bl	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
LBB41_23:                               ; %if.end49
	cmp	x21, #0
	cset	w8, ne
	ldrb	w9, [sp]
	and	w0, w8, w9
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy: ; @_ZN6Halide7Runtime8Internal15Synchronization16lock_bucket_pairEyy
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x19, x8
	mov	x8, #31765
	movk	x8, #32586, lsl #16
	movk	x8, #31161, lsl #32
	movk	x8, #40503, lsl #48
	mul	x9, x0, x8
	lsr	x22, x9, #54
	mul	x8, x1, x8
	lsr	x23, x8, #54
	cmp	x22, x23
	b.ne	LBB42_2
; %bb.1:                                ; %if.then
	mov	x8, #0
Lloh70:
	adrp	x9, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGE
Lloh71:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGEOFF]
	mov	w10, #24
	madd	x20, x22, x10, x9
	mov	w9, #1
	casa	x8, x9, [x20]
	mov	x21, x20
	cmp	x8, #0
	b.ne	LBB42_9
	b	LBB42_10
LBB42_2:                                ; %if.else
	mov	x8, #0
Lloh72:
	adrp	x9, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGE
Lloh73:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGEOFF]
	mov	w10, #24
	b.hs	LBB42_6
; %bb.3:                                ; %if.then3
	madd	x20, x22, x10, x9
	madd	x21, x23, x10, x9
	mov	w9, #1
	casa	x8, x9, [x20]
	cmp	x8, #0
	b.eq	LBB42_5
; %bb.4:                                ; %if.then.i40
	mov	x0, x20
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB42_5:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock4lockEv.exit41
	mov	x8, #0
	mov	w9, #1
	casa	x8, x9, [x21]
	mov	x22, x23
	cmp	x8, #0
	b.ne	LBB42_9
	b	LBB42_10
LBB42_6:                                ; %if.else9
	madd	x21, x23, x10, x9
	madd	x20, x22, x10, x9
	mov	w9, #1
	casa	x8, x9, [x21]
	cmp	x8, #0
	b.eq	LBB42_8
; %bb.7:                                ; %if.then.i48
	mov	x0, x21
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB42_8:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock4lockEv.exit49
	mov	x8, #0
	mov	w9, #1
	casa	x8, x9, [x20]
	cmp	x8, #0
	b.eq	LBB42_10
LBB42_9:                                ; %cleanup.sink.split
	mov	w8, #24
Lloh74:
	adrp	x9, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGE
Lloh75:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal15Synchronization5tableE@GOTPAGEOFF]
	madd	x0, x22, x8, x9
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock9lock_fullEv
LBB42_10:                               ; %cleanup
	stp	x20, x21, [x19]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh70, Lloh71
	.loh AdrpLdrGot	Lloh72, Lloh73
	.loh AdrpLdrGot	Lloh74, Lloh75
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE: ; @_ZN6Halide7Runtime8Internal15Synchronization18unlock_bucket_pairERNS2_11bucket_pairE
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	ldr	x0, [x0]
	ldr	x8, [x19, #8]
	cmp	x0, x8
	b.eq	LBB43_5
; %bb.1:                                ; %if.else
	b.ls	LBB43_7
; %bb.2:                                ; %if.then5
	mov	w8, #1
	ldclrl	x8, x8, [x0]
	and	x9, x8, #0x2
	cmp	x8, #4
	ccmp	x9, #0, #0, hs
	b.ne	LBB43_4
; %bb.3:                                ; %if.then.i30
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB43_4:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit31
	ldr	x0, [x19, #8]
LBB43_5:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit45
	mov	w8, #1
	ldclrl	x8, x8, [x0]
	and	x9, x8, #0x2
	cmp	x8, #4
	ccmp	x9, #0, #0, hs
	b.eq	LBB43_10
LBB43_6:                                ; %if.end15
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB43_7:                                ; %if.else10
	mov	w9, #1
	ldclrl	x9, x9, [x8]
	and	x10, x9, #0x2
	cmp	x9, #4
	ccmp	x10, #0, #0, hs
	b.ne	LBB43_9
; %bb.8:                                ; %if.then.i44
	mov	x0, x8
	bl	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
LBB43_9:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9word_lock6unlockEv.exit45
	ldr	x0, [x19]
	mov	w8, #1
	ldclrl	x8, x8, [x0]
	and	x9, x8, #0x2
	cmp	x8, #4
	ccmp	x9, #0, #0, hs
	b.ne	LBB43_6
LBB43_10:                               ; %if.end15.sink.split
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	__ZN6Halide7Runtime8Internal15Synchronization9word_lock11unlock_fullEv
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE: ; @_ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x10, x9, [x0, #8]
	ldr	x8, [x10]
	cmp	x8, x9
	b.ne	LBB44_8
; %bb.1:                                ; %if.end
	str	xzr, [x10]
	ldr	x10, [x0, #16]
	ldr	x12, [x10]
	tbz	w12, #0, LBB44_5
; %bb.2:                                ; %if.end.i.preheader
	mov	x11, x12
LBB44_3:                                ; %if.end.i
                                        ; =>This Inner Loop Header: Depth=1
	orr	x13, x12, #0x2
	cas	x11, x13, [x10]
	cmp	x11, x12
	b.eq	LBB44_6
; %bb.4:                                ; %_ZN6Halide7Runtime8Internal15Synchronization12_GLOBAL__N_131atomic_cas_weak_relaxed_relaxedEPyS4_S4_.exit.i
                                        ;   in Loop: Header=BB44_3 Depth=1
	mov	x12, x11
	tbnz	w11, #0, LBB44_3
LBB44_5:
	mov	w10, #1
	b	LBB44_7
LBB44_6:
	mov	w10, #0
LBB44_7:                                ; %_ZN6Halide7Runtime8Internal15Synchronization10fast_mutex21make_parked_if_lockedEv.exit
	strb	w10, [x1]
LBB44_8:                                ; %cleanup
	cmp	x8, x9
	cset	w0, eq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib: ; @_ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	x0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb: ; @_ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldrb	w8, [x1]
	cmp	w8, #0
	ccmp	w3, #0, #4, ne
	b.eq	LBB46_2
; %bb.1:                                ; %if.then
	ldr	x8, [x0, #16]
	mov	w9, #2
	ldset	x9, x8, [x8]
LBB46_2:                                ; %if.end
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv ; -- Begin function _ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
	.weak_definition	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
	.p2align	2
__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv: ; @_ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh76:
	adrp	x0, l_.str.1@PAGE
Lloh77:
	add	x0, x0, l_.str.1@PAGEOFF
	bl	_getenv
	cbnz	x0, LBB47_2
; %bb.1:                                ; %if.end
Lloh78:
	adrp	x0, l_.str.2@PAGE
Lloh79:
	add	x0, x0, l_.str.2@PAGEOFF
	bl	_getenv
	cbz	x0, LBB47_3
LBB47_2:                                ; %cond.true
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_atoi
LBB47_3:                                ; %cond.false
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_halide_host_cpu_count
	.loh AdrpAdd	Lloh76, Lloh77
	.loh AdrpAdd	Lloh78, Lloh79
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal13worker_threadEPv ; -- Begin function _ZN6Halide7Runtime8Internal13worker_threadEPv
	.weak_definition	__ZN6Halide7Runtime8Internal13worker_threadEPv
	.p2align	2
__ZN6Halide7Runtime8Internal13worker_threadEPv: ; @_ZN6Halide7Runtime8Internal13worker_threadEPv
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
Lloh80:
	adrp	x20, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh81:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	mov	x0, x20
	bl	_halide_mutex_lock
	mov	x0, x19
	bl	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	mov	x0, x20
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_mutex_unlock
	.loh AdrpLdrGot	Lloh80, Lloh81
                                        ; -- End function
	.globl	_halide_spawn_thread            ; -- Begin function halide_spawn_thread
	.weak_definition	_halide_spawn_thread
	.p2align	2
_halide_spawn_thread:                   ; @halide_spawn_thread
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x1
	mov	x20, x0
	mov	w0, #24
	bl	_malloc
	mov	x21, x0
	stp	x20, x19, [x0]
	str	xzr, [x0, #16]!
Lloh82:
	adrp	x2, __ZN6Halide7Runtime8Internal19spawn_thread_helperEPv@GOTPAGE
Lloh83:
	ldr	x2, [x2, __ZN6Halide7Runtime8Internal19spawn_thread_helperEPv@GOTPAGEOFF]
	mov	x1, #0
	mov	x3, x21
	bl	_pthread_create
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh82, Lloh83
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal19spawn_thread_helperEPv ; -- Begin function _ZN6Halide7Runtime8Internal19spawn_thread_helperEPv
	.weak_definition	__ZN6Halide7Runtime8Internal19spawn_thread_helperEPv
	.p2align	2
__ZN6Halide7Runtime8Internal19spawn_thread_helperEPv: ; @_ZN6Halide7Runtime8Internal19spawn_thread_helperEPv
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x8, x0, [x0]
	blr	x8
	mov	x0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_default_do_parallel_tasks ; -- Begin function halide_default_do_parallel_tasks
	.weak_definition	_halide_default_do_parallel_tasks
	.p2align	2
_halide_default_do_parallel_tasks:      ; @halide_default_do_parallel_tasks
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x3
	mov	x20, x1
	sxtw	x8, w20
	mov	x9, sp
	sub	x19, x9, x8, lsl #7
	mov	sp, x19
	cmp	w1, #1
	b.lt	LBB51_5
; %bb.1:                                ; %for.body.preheader
	mov	x8, #0
	add	x9, x19, #124
	b	LBB51_3
LBB51_2:                                ; %if.end
                                        ;   in Loop: Header=BB51_3 Depth=1
	ldp	q0, q1, [x2]
	ldr	q2, [x2, #32]
	ldr	x10, [x2, #48]
	add	x2, x2, #56
	stur	x10, [x9, #-76]
	stur	q2, [x9, #-92]
	stur	q1, [x9, #-108]
	stur	q0, [x9, #-124]
	stur	xzr, [x9, #-68]
	stur	x0, [x9, #-20]
	stur	xzr, [x9, #-12]
	stur	wzr, [x9, #-4]
	strb	wzr, [x9]
	stur	x21, [x9, #-36]
	add	x8, x8, #1
	add	x9, x9, #128
	cmp	x8, w20, sxtw
	b.ge	LBB51_5
LBB51_3:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w10, [x2, #40]
	cmp	w10, #0
	b.gt	LBB51_2
; %bb.4:                                ; %if.then
                                        ;   in Loop: Header=BB51_3 Depth=1
	sub	w20, w20, #1
	add	x8, x8, #1
	add	x9, x9, #128
	cmp	x8, w20, sxtw
	b.lt	LBB51_3
LBB51_5:                                ; %for.cond.cleanup
	cbz	w20, LBB51_9
; %bb.6:                                ; %if.end19
Lloh84:
	adrp	x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh85:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	bl	_halide_mutex_lock
	mov	x0, x20
	mov	x1, x19
	mov	x2, x21
	bl	__ZN6Halide7Runtime8Internal27enqueue_work_already_lockedEiPNS1_4workES3_
	cmp	w20, #1
	b.lt	LBB51_10
; %bb.7:                                ; %for.body25.preheader
	mov	w21, #0
	mov	w20, w20
LBB51_8:                                ; %for.body25
                                        ; =>This Inner Loop Header: Depth=1
	mov	x0, x19
	bl	__ZN6Halide7Runtime8Internal28worker_thread_already_lockedEPNS1_4workE
	ldr	w8, [x19, #116]
	cmp	w8, #0
	csel	w21, w21, w8, eq
	add	x19, x19, #128
	subs	x20, x20, #1
	b.ne	LBB51_8
	b	LBB51_11
LBB51_9:
	mov	w21, #0
	mov	x0, x21
	sub	sp, x29, #32
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB51_10:
	mov	w21, #0
LBB51_11:                               ; %for.cond.cleanup24
Lloh86:
	adrp	x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh87:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	x0, x21
	sub	sp, x29, #32
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh84, Lloh85
	.loh AdrpLdrGot	Lloh86, Lloh87
                                        ; -- End function
	.globl	_halide_default_semaphore_init  ; -- Begin function halide_default_semaphore_init
	.weak_definition	_halide_default_semaphore_init
	.p2align	2
_halide_default_semaphore_init:         ; @halide_default_semaphore_init
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	stlr	w1, [x0]
	mov	x0, x1
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_default_semaphore_release ; -- Begin function halide_default_semaphore_release
	.weak_definition	_halide_default_semaphore_release
	.p2align	2
_halide_default_semaphore_release:      ; @halide_default_semaphore_release
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x1
	ldaddal	w1, w21, [x0]
	cbz	w1, LBB53_3
; %bb.1:                                ; %entry
	cbnz	w21, LBB53_3
; %bb.2:                                ; %if.then
Lloh88:
	adrp	x20, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh89:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	mov	x0, x20
	bl	_halide_mutex_lock
	add	x0, x20, #40
	bl	_halide_cond_broadcast
	add	x0, x20, #56
	bl	_halide_cond_broadcast
	mov	x0, x20
	bl	_halide_mutex_unlock
LBB53_3:                                ; %if.end
	add	w0, w21, w19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh88, Lloh89
                                        ; -- End function
	.globl	_halide_thread_pool_cleanup     ; -- Begin function halide_thread_pool_cleanup
	.weak_definition	_halide_thread_pool_cleanup
	.p2align	2
_halide_thread_pool_cleanup:            ; @halide_thread_pool_cleanup
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_halide_shutdown_thread_pool
                                        ; -- End function
	.globl	_halide_shutdown_thread_pool    ; -- Begin function halide_shutdown_thread_pool
	.weak_definition	_halide_shutdown_thread_pool
	.p2align	2
_halide_shutdown_thread_pool:           ; @halide_shutdown_thread_pool
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
Lloh90:
	adrp	x19, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh91:
	ldr	x19, [x19, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	ldrb	w8, [x19, #2121]
	cbz	w8, LBB55_5
; %bb.1:                                ; %if.then
	mov	x0, x19
	bl	_halide_mutex_lock
	mov	w8, #1
	strb	w8, [x19, #2120]
	add	x0, x19, #56
	bl	_halide_cond_broadcast
	add	x0, x19, #40
	bl	_halide_cond_broadcast
	add	x0, x19, #48
	bl	_halide_cond_broadcast
	mov	x0, x19
	bl	_halide_mutex_unlock
	ldr	w8, [x19, #24]
	cmp	w8, #1
	b.lt	LBB55_4
; %bb.2:                                ; %for.body.preheader
	mov	x20, #0
LBB55_3:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	add	x8, x19, x20, lsl #3
	ldr	x0, [x8, #72]
	bl	_halide_join_thread
	add	x20, x20, #1
	ldrsw	x8, [x19, #24]
	cmp	x20, x8
	b.lt	LBB55_3
LBB55_4:                                ; %for.cond.cleanup
	add	x0, x19, #12
	mov	w1, #0
	mov	w2, #2116
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_memset
LBB55_5:                                ; %if.end
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh90, Lloh91
                                        ; -- End function
	.globl	_halide_join_thread             ; -- Begin function halide_join_thread
	.weak_definition	_halide_join_thread
	.p2align	2
_halide_join_thread:                    ; @halide_join_thread
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x0
	str	xzr, [sp, #8]
	ldr	x0, [x0, #16]
	add	x1, sp, #8
	bl	_pthread_join
	mov	x0, x19
	bl	_free
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
                                        ; -- End function
	.globl	_halide_cond_signal             ; -- Begin function halide_cond_signal
	.weak_definition	_halide_cond_signal
	.p2align	2
_halide_cond_signal:                    ; @halide_cond_signal
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	ldr	x8, [x0]
	cbz	x8, LBB57_2
; %bb.1:                                ; %if.end.i
	mov	x1, x0
Lloh92:
	adrp	x9, __ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE@GOTPAGE
Lloh93:
	ldr	x9, [x9, __ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE@GOTPAGEOFF]
	add	x9, x9, #16
	stp	x9, x0, [sp, #8]
	str	x8, [sp, #24]
	add	x0, sp, #8
	bl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control10unpark_oneEy
LBB57_2:                                ; %_ZN6Halide7Runtime8Internal15Synchronization9fast_cond6signalEv.exit
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.loh AdrpLdrGot	Lloh92, Lloh93
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE: ; @_ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #1
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib ; -- Begin function _ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
	.weak_def_can_be_hidden	__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
	.p2align	2
__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib: ; @_ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
; %bb.0:                                ; %entry
	tbnz	w2, #0, LBB59_2
; %bb.1:                                ; %if.then
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x8, [x0, #8]
	str	xzr, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
LBB59_2:                                ; %if.end
	mov	x0, #0
	ret
                                        ; -- End function
	.globl	_halide_mutex_array_create      ; -- Begin function halide_mutex_array_create
	.weak_definition	_halide_mutex_array_create
	.p2align	2
_halide_mutex_array_create:             ; @halide_mutex_array_create
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x20, x0
	mov	x0, #0
	mov	w1, #8
	bl	_halide_malloc
	mov	x19, x0
	cbz	x0, LBB60_3
; %bb.1:                                ; %if.end
	sbfiz	x20, x20, #3, #32
	mov	x0, #0
	mov	x1, x20
	bl	_halide_malloc
	str	x0, [x19]
	cbz	x0, LBB60_4
; %bb.2:                                ; %if.end6
	mov	w1, #0
	mov	x2, x20
	bl	_memset
LBB60_3:                                ; %cleanup
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB60_4:                                ; %if.then5
	mov	x1, x19
	bl	_halide_free
	mov	x19, #0
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_mutex_array_destroy     ; -- Begin function halide_mutex_array_destroy
	.weak_definition	_halide_mutex_array_destroy
	.p2align	2
_halide_mutex_array_destroy:            ; @halide_mutex_array_destroy
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	mov	x20, x0
	ldr	x1, [x1]
	bl	_halide_free
	mov	x0, x20
	mov	x1, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_free
                                        ; -- End function
	.globl	_halide_mutex_array_lock        ; -- Begin function halide_mutex_array_lock
	.weak_definition	_halide_mutex_array_lock
	.p2align	2
_halide_mutex_array_lock:               ; @halide_mutex_array_lock
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x8, [x0]
	add	x0, x8, w1, sxtw #3
	bl	_halide_mutex_lock
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_mutex_array_unlock      ; -- Begin function halide_mutex_array_unlock
	.weak_definition	_halide_mutex_array_unlock
	.p2align	2
_halide_mutex_array_unlock:             ; @halide_mutex_array_unlock
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x8, [x0]
	add	x0, x8, w1, sxtw #3
	bl	_halide_mutex_unlock
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_set_num_threads         ; -- Begin function halide_set_num_threads
	.weak_definition	_halide_set_num_threads
	.p2align	2
_halide_set_num_threads:                ; @halide_set_num_threads
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x20, x0
Lloh94:
	adrp	x19, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh95:
	ldr	x19, [x19, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	tbnz	w0, #31, LBB64_3
; %bb.1:                                ; %if.end
Lloh96:
	adrp	x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh97:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	bl	_halide_mutex_lock
	cbnz	w20, LBB64_4
; %bb.2:                                ; %if.then2
	bl	__ZN6Halide7Runtime8Internal27default_desired_num_threadsEv
	mov	x20, x0
	b	LBB64_4
LBB64_3:                                ; %if.end.thread
Lloh98:
	adrp	x1, l_.str.4@PAGE
Lloh99:
	add	x1, x1, l_.str.4@PAGEOFF
	mov	x0, #0
	bl	_halide_error
Lloh100:
	adrp	x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGE
Lloh101:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal10work_queueE@GOTPAGEOFF]
	bl	_halide_mutex_lock
LBB64_4:                                ; %if.end3
	ldr	w21, [x19, #8]
	cmp	w20, #1
	csinc	w8, w20, wzr, gt
	cmp	w8, #256
	mov	w9, #256
	csel	w8, w8, w9, lo
	str	w8, [x19, #8]
	mov	x0, x19
	bl	_halide_mutex_unlock
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh94, Lloh95
	.loh AdrpLdrGot	Lloh96, Lloh97
	.loh AdrpLdrGot	Lloh100, Lloh101
	.loh AdrpAdd	Lloh98, Lloh99
                                        ; -- End function
	.globl	_halide_set_custom_do_task      ; -- Begin function halide_set_custom_do_task
	.weak_definition	_halide_set_custom_do_task
	.p2align	2
_halide_set_custom_do_task:             ; @halide_set_custom_do_task
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh102:
	adrp	x9, __ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPAGE
Lloh103:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh102, Lloh103
                                        ; -- End function
	.globl	_halide_set_custom_do_loop_task ; -- Begin function halide_set_custom_do_loop_task
	.weak_definition	_halide_set_custom_do_loop_task
	.p2align	2
_halide_set_custom_do_loop_task:        ; @halide_set_custom_do_loop_task
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh104:
	adrp	x9, __ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPAGE
Lloh105:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh104, Lloh105
                                        ; -- End function
	.globl	_halide_set_custom_do_par_for   ; -- Begin function halide_set_custom_do_par_for
	.weak_definition	_halide_set_custom_do_par_for
	.p2align	2
_halide_set_custom_do_par_for:          ; @halide_set_custom_do_par_for
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh106:
	adrp	x9, __ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPAGE
Lloh107:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh106, Lloh107
                                        ; -- End function
	.globl	_halide_set_custom_parallel_runtime ; -- Begin function halide_set_custom_parallel_runtime
	.weak_definition	_halide_set_custom_parallel_runtime
	.p2align	2
_halide_set_custom_parallel_runtime:    ; @halide_set_custom_parallel_runtime
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh108:
	adrp	x8, __ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPAGE
Lloh109:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPAGEOFF]
Lloh110:
	str	x0, [x8]
Lloh111:
	adrp	x8, __ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPAGE
Lloh112:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal14custom_do_taskE@GOTPAGEOFF]
Lloh113:
	str	x1, [x8]
Lloh114:
	adrp	x8, __ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPAGE
Lloh115:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19custom_do_loop_taskE@GOTPAGEOFF]
Lloh116:
	str	x2, [x8]
Lloh117:
	adrp	x8, __ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE@GOTPAGE
Lloh118:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE@GOTPAGEOFF]
Lloh119:
	str	x3, [x8]
Lloh120:
	adrp	x8, __ZN6Halide7Runtime8Internal21custom_semaphore_initE@GOTPAGE
Lloh121:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal21custom_semaphore_initE@GOTPAGEOFF]
Lloh122:
	str	x4, [x8]
Lloh123:
	adrp	x8, __ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE@GOTPAGE
Lloh124:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE@GOTPAGEOFF]
Lloh125:
	str	x5, [x8]
Lloh126:
	adrp	x8, __ZN6Halide7Runtime8Internal24custom_semaphore_releaseE@GOTPAGE
Lloh127:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal24custom_semaphore_releaseE@GOTPAGEOFF]
Lloh128:
	str	x6, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGotStr	Lloh126, Lloh127, Lloh128
	.loh AdrpLdrGotStr	Lloh123, Lloh124, Lloh125
	.loh AdrpLdrGotStr	Lloh120, Lloh121, Lloh122
	.loh AdrpLdrGotStr	Lloh117, Lloh118, Lloh119
	.loh AdrpLdrGotStr	Lloh114, Lloh115, Lloh116
	.loh AdrpLdrGotStr	Lloh111, Lloh112, Lloh113
	.loh AdrpLdrGotStr	Lloh108, Lloh109, Lloh110
                                        ; -- End function
	.globl	_halide_do_par_for              ; -- Begin function halide_do_par_for
	.weak_definition	_halide_do_par_for
	.p2align	2
_halide_do_par_for:                     ; @halide_do_par_for
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh129:
	adrp	x8, __ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPAGE
Lloh130:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17custom_do_par_forE@GOTPAGEOFF]
Lloh131:
	ldr	x5, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x5
	.loh AdrpLdrGotLdr	Lloh129, Lloh130, Lloh131
                                        ; -- End function
	.globl	_halide_do_parallel_tasks       ; -- Begin function halide_do_parallel_tasks
	.weak_definition	_halide_do_parallel_tasks
	.p2align	2
_halide_do_parallel_tasks:              ; @halide_do_parallel_tasks
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh132:
	adrp	x8, __ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE@GOTPAGE
Lloh133:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE@GOTPAGEOFF]
Lloh134:
	ldr	x4, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x4
	.loh AdrpLdrGotLdr	Lloh132, Lloh133, Lloh134
                                        ; -- End function
	.globl	_halide_semaphore_init          ; -- Begin function halide_semaphore_init
	.weak_definition	_halide_semaphore_init
	.p2align	2
_halide_semaphore_init:                 ; @halide_semaphore_init
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh135:
	adrp	x8, __ZN6Halide7Runtime8Internal21custom_semaphore_initE@GOTPAGE
Lloh136:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal21custom_semaphore_initE@GOTPAGEOFF]
Lloh137:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh135, Lloh136, Lloh137
                                        ; -- End function
	.globl	_halide_semaphore_release       ; -- Begin function halide_semaphore_release
	.weak_definition	_halide_semaphore_release
	.p2align	2
_halide_semaphore_release:              ; @halide_semaphore_release
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh138:
	adrp	x8, __ZN6Halide7Runtime8Internal24custom_semaphore_releaseE@GOTPAGE
Lloh139:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal24custom_semaphore_releaseE@GOTPAGEOFF]
Lloh140:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh138, Lloh139, Lloh140
                                        ; -- End function
	.globl	_halide_semaphore_try_acquire   ; -- Begin function halide_semaphore_try_acquire
	.weak_definition	_halide_semaphore_try_acquire
	.p2align	2
_halide_semaphore_try_acquire:          ; @halide_semaphore_try_acquire
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh141:
	adrp	x8, __ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE@GOTPAGE
Lloh142:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE@GOTPAGEOFF]
Lloh143:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh141, Lloh142, Lloh143
                                        ; -- End function
	.globl	_halide_default_get_symbol      ; -- Begin function halide_default_get_symbol
	.weak_definition	_halide_default_get_symbol
	.p2align	2
_halide_default_get_symbol:             ; @halide_default_get_symbol
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	x1, x0
	mov	x0, #-2
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_dlsym
                                        ; -- End function
	.globl	_halide_default_load_library    ; -- Begin function halide_default_load_library
	.weak_definition	_halide_default_load_library
	.p2align	2
_halide_default_load_library:           ; @halide_default_load_library
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w1, #5
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_dlopen
                                        ; -- End function
	.globl	_halide_default_get_library_symbol ; -- Begin function halide_default_get_library_symbol
	.weak_definition	_halide_default_get_library_symbol
	.p2align	2
_halide_default_get_library_symbol:     ; @halide_default_get_library_symbol
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	cmp	x0, #0
	mov	x8, #-2
	csel	x0, x8, x0, eq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_dlsym
                                        ; -- End function
	.globl	_halide_set_custom_get_symbol   ; -- Begin function halide_set_custom_get_symbol
	.weak_definition	_halide_set_custom_get_symbol
	.p2align	2
_halide_set_custom_get_symbol:          ; @halide_set_custom_get_symbol
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh144:
	adrp	x9, __ZN6Halide7Runtime8Internal17custom_get_symbolE@GOTPAGE
Lloh145:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal17custom_get_symbolE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh144, Lloh145
                                        ; -- End function
	.globl	_halide_set_custom_load_library ; -- Begin function halide_set_custom_load_library
	.weak_definition	_halide_set_custom_load_library
	.p2align	2
_halide_set_custom_load_library:        ; @halide_set_custom_load_library
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh146:
	adrp	x9, __ZN6Halide7Runtime8Internal19custom_load_libraryE@GOTPAGE
Lloh147:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal19custom_load_libraryE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh146, Lloh147
                                        ; -- End function
	.globl	_halide_set_custom_get_library_symbol ; -- Begin function halide_set_custom_get_library_symbol
	.weak_definition	_halide_set_custom_get_library_symbol
	.p2align	2
_halide_set_custom_get_library_symbol:  ; @halide_set_custom_get_library_symbol
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh148:
	adrp	x9, __ZN6Halide7Runtime8Internal25custom_get_library_symbolE@GOTPAGE
Lloh149:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal25custom_get_library_symbolE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh148, Lloh149
                                        ; -- End function
	.globl	_halide_get_symbol              ; -- Begin function halide_get_symbol
	.weak_definition	_halide_get_symbol
	.p2align	2
_halide_get_symbol:                     ; @halide_get_symbol
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh150:
	adrp	x8, __ZN6Halide7Runtime8Internal17custom_get_symbolE@GOTPAGE
Lloh151:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17custom_get_symbolE@GOTPAGEOFF]
Lloh152:
	ldr	x1, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x1
	.loh AdrpLdrGotLdr	Lloh150, Lloh151, Lloh152
                                        ; -- End function
	.globl	_halide_load_library            ; -- Begin function halide_load_library
	.weak_definition	_halide_load_library
	.p2align	2
_halide_load_library:                   ; @halide_load_library
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh153:
	adrp	x8, __ZN6Halide7Runtime8Internal19custom_load_libraryE@GOTPAGE
Lloh154:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19custom_load_libraryE@GOTPAGEOFF]
Lloh155:
	ldr	x1, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x1
	.loh AdrpLdrGotLdr	Lloh153, Lloh154, Lloh155
                                        ; -- End function
	.globl	_halide_get_library_symbol      ; -- Begin function halide_get_library_symbol
	.weak_definition	_halide_get_library_symbol
	.p2align	2
_halide_get_library_symbol:             ; @halide_get_library_symbol
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh156:
	adrp	x8, __ZN6Halide7Runtime8Internal25custom_get_library_symbolE@GOTPAGE
Lloh157:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal25custom_get_library_symbolE@GOTPAGEOFF]
Lloh158:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh156, Lloh157, Lloh158
                                        ; -- End function
	.globl	_halide_set_gpu_device          ; -- Begin function halide_set_gpu_device
	.weak_definition	_halide_set_gpu_device
	.p2align	2
_halide_set_gpu_device:                 ; @halide_set_gpu_device
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh159:
	adrp	x8, __ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPAGE
Lloh160:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPAGEOFF]
Lloh161:
	str	w0, [x8]
Lloh162:
	adrp	x8, __ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE@GOTPAGE
Lloh163:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE@GOTPAGEOFF]
	mov	w9, #1
Lloh164:
	strb	w9, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGotStr	Lloh162, Lloh163, Lloh164
	.loh AdrpLdrGotStr	Lloh159, Lloh160, Lloh161
                                        ; -- End function
	.globl	_halide_get_gpu_device          ; -- Begin function halide_get_gpu_device
	.weak_definition	_halide_get_gpu_device
	.p2align	2
_halide_get_gpu_device:                 ; @halide_get_gpu_device
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
Lloh165:
	adrp	x19, __ZN6Halide7Runtime8Internal22halide_gpu_device_lockE@GOTPAGE
Lloh166:
	ldr	x19, [x19, __ZN6Halide7Runtime8Internal22halide_gpu_device_lockE@GOTPAGEOFF]
	mov	w8, #1
LBB84_1:                                ; %while.cond.i
                                        ; =>This Inner Loop Header: Depth=1
	swpab	w8, w9, [x19]
	cbnz	w9, LBB84_1
; %bb.2:                                ; %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit
Lloh167:
	adrp	x20, __ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE@GOTPAGE
Lloh168:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE@GOTPAGEOFF]
	ldrb	w8, [x20]
	cbz	w8, LBB84_4
; %bb.3:                                ; %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit.if.end4_crit_edge
Lloh169:
	adrp	x8, __ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPAGE
Lloh170:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPAGEOFF]
Lloh171:
	ldr	w0, [x8]
	stlrb	wzr, [x19]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB84_4:                                ; %if.then
Lloh172:
	adrp	x0, l_.str.8@PAGE
Lloh173:
	add	x0, x0, l_.str.8@PAGEOFF
	bl	_getenv
	cbz	x0, LBB84_6
; %bb.5:                                ; %if.then2
	bl	_atoi
	b	LBB84_7
LBB84_6:
	mov	w0, #-1
LBB84_7:                                ; %if.end
Lloh174:
	adrp	x8, __ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPAGE
Lloh175:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17halide_gpu_deviceE@GOTPAGEOFF]
Lloh176:
	str	w0, [x8]
	mov	w8, #1
	strb	w8, [x20]
	stlrb	wzr, [x19]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh165, Lloh166
	.loh AdrpLdrGot	Lloh167, Lloh168
	.loh AdrpLdrGotLdr	Lloh169, Lloh170, Lloh171
	.loh AdrpAdd	Lloh172, Lloh173
	.loh AdrpLdrGotStr	Lloh174, Lloh175, Lloh176
                                        ; -- End function
	.globl	_halide_default_trace           ; -- Begin function halide_default_trace
	.weak_definition	_halide_default_trace
	.p2align	2
_halide_default_trace:                  ; @halide_default_trace
; %bb.0:                                ; %entry
	sub	sp, sp, #144
	stp	x28, x27, [sp, #48]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #64]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #80]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #96]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #112]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #128]            ; 16-byte Folded Spill
	add	x29, sp, #128
	mov	x21, x1
Lloh177:
	adrp	x8, __ZZ20halide_default_traceE3ids@PAGE
Lloh178:
	add	x8, x8, __ZZ20halide_default_traceE3ids@PAGEOFF
	mov	w9, #1
	ldaddal	w9, w27, [x8]
	str	x0, [sp, #40]                   ; 8-byte Folded Spill
	bl	_halide_get_trace_file
	cmp	w0, #1
	b.lt	LBB85_3
; %bb.1:                                ; %if.then
	mov	x22, x0
	ldrh	w8, [x21, #34]
	ldrb	w9, [x21, #33]
	add	x9, x9, #7
	lsr	x9, x9, #3
	mul	x20, x9, x8
	ldr	w8, [x21, #48]
	lsl	w23, w8, #2
	ldr	x0, [x21]
	bl	_strlen
	add	w19, w0, #1
	ldr	x0, [x21, #24]
	str	w27, [sp, #28]                  ; 4-byte Folded Spill
	cbz	x0, LBB85_5
; %bb.2:                                ; %cond.true
	bl	_strlen
	add	w9, w0, #1
	b	LBB85_6
LBB85_3:                                ; %if.else
	mov	w0, #4096
	bl	_malloc
	mov	x22, x0
	cbz	x0, LBB85_28
; %bb.4:                                ; %if.then6.i439
	add	x23, x22, #4095
	strb	wzr, [x22, #4095]
	b	LBB85_29
LBB85_5:
	mov	w9, #1
LBB85_6:                                ; %cond.end
	add	w8, w23, w20
	add	w8, w8, w19
	add	w8, w8, w9
	add	w8, w8, #31
	and	w26, w8, #0xfffffffc
Lloh179:
	adrp	x8, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGE
Lloh180:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGEOFF]
Lloh181:
	ldr	x25, [x8]
	add	x27, x25, #12
	cmp	w26, #256, lsl #12              ; =1048576
	str	w9, [sp, #24]                   ; 4-byte Folded Spill
	str	x19, [sp, #32]                  ; 8-byte Folded Spill
	stp	x23, x20, [sp, #8]              ; 16-byte Folded Spill
	b.hi	LBB85_16
; %bb.7:                                ; %while.body.i.i.us.i.preheader
	mov	w20, #-1
	mov	w23, #1073741824
	mov	w24, #-2147483648
Lloh182:
	adrp	x19, l_.str.32@PAGE
Lloh183:
	add	x19, x19, l_.str.32@PAGEOFF
	b	LBB85_9
LBB85_8:                                ; %do.end.critedge.i.us.i
                                        ;   in Loop: Header=BB85_9 Depth=1
	ldclral	w24, w8, [x25]
LBB85_9:                                ; %while.body.i.i.us.i
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB85_12 Depth 2
	ldr	w8, [x25]
	and	w8, w8, #0x3fffffff
	add	w9, w8, #1
	mov	x10, x8
	casal	w10, w9, [x25]
	cmp	w10, w8
	b.ne	LBB85_9
; %bb.10:                               ; %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock14acquire_sharedEv.exit.i.us.i
                                        ;   in Loop: Header=BB85_9 Depth=1
	add	x8, x25, #4
	ldaddal	w26, w8, [x8]
	add	w9, w8, w26
	cmp	w9, #256, lsl #12               ; =1048576
	b.ls	LBB85_25
; %bb.11:                               ; %while.body.us.i
                                        ;   in Loop: Header=BB85_9 Depth=1
	add	x8, x25, #8
	ldaddal	w26, w8, [x8]
	ldaddal	w20, w8, [x25]
LBB85_12:                               ; %while.body.i.i5.us.i
                                        ;   Parent Loop BB85_9 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldsetal	w23, w8, [x25]
	mov	w8, #1073741824
	casal	w8, w24, [x25]
	cmp	w8, w23
	b.ne	LBB85_12
; %bb.13:                               ; %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock17acquire_exclusiveEv.exit.i.us.i
                                        ;   in Loop: Header=BB85_9 Depth=1
	ldr	w8, [x25, #4]
	cbz	w8, LBB85_8
; %bb.14:                               ; %if.then.i9.us.i
                                        ;   in Loop: Header=BB85_9 Depth=1
	ldr	w9, [x25, #8]
	sub	w28, w8, w9
	str	w28, [x25, #4]
	mov	x0, x22
	mov	x1, x27
	mov	x2, x28
	bl	_write
	stp	wzr, wzr, [x25, #4]
	ldclral	w24, w8, [x25]
	cmp	w28, w0
	b.eq	LBB85_9
; %bb.15:                               ; %if.then10.i.us.i
                                        ;   in Loop: Header=BB85_9 Depth=1
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	mov	x1, x19
	bl	_halide_print
	bl	_abort
	b	LBB85_9
LBB85_16:
Lloh184:
	adrp	x28, l_.str.31@PAGE
Lloh185:
	add	x28, x28, l_.str.31@PAGEOFF
	mov	w23, #-1
	mov	w20, #1073741824
	mov	w19, #-2147483648
	b	LBB85_18
LBB85_17:                               ; %do.end.critedge.i.i
                                        ;   in Loop: Header=BB85_18 Depth=1
	ldclral	w19, w8, [x25]
LBB85_18:                               ; %while.body.i.i.i
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB85_21 Depth 2
	ldr	w8, [x25]
	and	w8, w8, #0x3fffffff
	add	w9, w8, #1
	mov	x10, x8
	casal	w10, w9, [x25]
	cmp	w10, w8
	b.ne	LBB85_18
; %bb.19:                               ; %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock14acquire_sharedEv.exit.i.i
                                        ;   in Loop: Header=BB85_18 Depth=1
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	mov	x1, x28
	bl	_halide_print
	bl	_abort
	add	x8, x25, #4
	ldaddal	w26, w8, [x8]
	add	w9, w8, w26
	cmp	w9, #256, lsl #12               ; =1048576
	b.ls	LBB85_25
; %bb.20:                               ; %while.body.i
                                        ;   in Loop: Header=BB85_18 Depth=1
	add	x8, x25, #8
	ldaddal	w26, w8, [x8]
	ldaddal	w23, w8, [x25]
LBB85_21:                               ; %while.body.i.i5.i
                                        ;   Parent Loop BB85_18 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldsetal	w20, w8, [x25]
	mov	w8, #1073741824
	casal	w8, w19, [x25]
	cmp	w8, w20
	b.ne	LBB85_21
; %bb.22:                               ; %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock17acquire_exclusiveEv.exit.i.i
                                        ;   in Loop: Header=BB85_18 Depth=1
	ldr	w8, [x25, #4]
	cbz	w8, LBB85_17
; %bb.23:                               ; %if.then.i9.i
                                        ;   in Loop: Header=BB85_18 Depth=1
	ldr	w9, [x25, #8]
	sub	w24, w8, w9
	str	w24, [x25, #4]
	mov	x0, x22
	mov	x1, x27
	mov	x2, x24
	bl	_write
	stp	wzr, wzr, [x25, #4]
	ldclral	w19, w8, [x25]
	cmp	w24, w0
	b.eq	LBB85_18
; %bb.24:                               ; %if.then10.i.i
                                        ;   in Loop: Header=BB85_18 Depth=1
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
Lloh186:
	adrp	x1, l_.str.32@PAGE
Lloh187:
	add	x1, x1, l_.str.32@PAGEOFF
	bl	_halide_print
	bl	_abort
	b	LBB85_18
LBB85_25:
	ldp	w23, w27, [sp, #24]             ; 8-byte Folded Reload
Lloh188:
	adrp	x20, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGE
Lloh189:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGEOFF]
	add	x8, x25, w8, uxtw
	add	x25, x8, #12
	cmp	w26, #1, lsl #12                ; =4096
	b.ls	LBB85_53
; %bb.26:                               ; %if.then17
	mov	w0, #1024
	bl	_malloc
	mov	x19, x0
	cbz	x0, LBB85_51
; %bb.27:                               ; %if.else.i
	add	x24, x19, #1023
	strb	wzr, [x19, #1023]
	mov	x0, x19
	mov	x1, x24
	mov	x2, x26
	mov	w3, #1
	bl	_halide_uint64_to_string
Lloh190:
	adrp	x2, l_.str.7.164@PAGE
Lloh191:
	add	x2, x2, l_.str.7.164@PAGEOFF
	mov	x1, x24
	bl	_halide_string_to_string
	sub	x8, x0, x19
	add	x2, x8, #1
	mov	x0, #0
	mov	x1, x19
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x0, #0
	mov	x1, x19
	bl	_halide_print
	b	LBB85_52
LBB85_28:
	mov	x23, #0
LBB85_29:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy4096EEC2EPvPc.exit
	ldrb	w8, [x21, #33]
	mov	w9, #8
LBB85_30:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov	x19, x9
	lsl	w9, w9, #1
	cmp	w19, w8
	b.lt	LBB85_30
; %bb.31:                               ; %do.body
	cmp	w19, #65
	b.lt	LBB85_33
; %bb.32:                               ; %if.then63
Lloh192:
	adrp	x1, l_.str.2.11@PAGE
Lloh193:
	add	x1, x1, l_.str.2.11@PAGEOFF
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	bl	_halide_print
	bl	_abort
LBB85_33:                               ; %do.end
	ldr	w25, [x21, #36]
Lloh194:
	adrp	x8, l___const.halide_default_trace.event_types@PAGE
Lloh195:
	add	x8, x8, l___const.halide_default_trace.event_types@PAGEOFF
	ldr	x2, [x8, x25, lsl #3]
	mov	x0, x22
	mov	x1, x23
	bl	_halide_string_to_string
Lloh196:
	adrp	x2, l_.str.20.177@PAGE
Lloh197:
	add	x2, x2, l_.str.20.177@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	ldr	x2, [x21]
	mov	x1, x23
	bl	_halide_string_to_string
Lloh198:
	adrp	x2, l_.str.30.141@PAGE
Lloh199:
	add	x2, x2, l_.str.30.141@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	ldrsw	x2, [x21, #44]
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh200:
	adrp	x2, l_.str.22.179@PAGE
Lloh201:
	add	x2, x2, l_.str.22.179@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	ldrh	w8, [x21, #34]
	cmp	w8, #2
	b.lo	LBB85_35
; %bb.34:                               ; %if.then80
Lloh202:
	adrp	x2, l_.str.17@PAGE
Lloh203:
	add	x2, x2, l_.str.17@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
LBB85_35:                               ; %if.end82
	ldr	w8, [x21, #48]
	cmp	w8, #1
	b.lt	LBB85_43
; %bb.36:                               ; %if.end100.peel
	ldr	x8, [x21, #16]
	ldrsw	x2, [x8]
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	ldr	w8, [x21, #48]
	cmp	w8, #2
	b.lt	LBB85_43
; %bb.37:                               ; %if.then86.preheader
	mov	w20, #1
Lloh204:
	adrp	x24, l_.str.18@PAGE
Lloh205:
	add	x24, x24, l_.str.18@PAGEOFF
Lloh206:
	adrp	x26, l_.str.55@PAGE
Lloh207:
	add	x26, x26, l_.str.55@PAGEOFF
	b	LBB85_40
LBB85_38:                               ; %if.else97.split
                                        ;   in Loop: Header=BB85_40 Depth=1
	mov	x2, x26
LBB85_39:                               ; %if.end100
                                        ;   in Loop: Header=BB85_40 Depth=1
	mov	x1, x23
	bl	_halide_string_to_string
	ldr	x8, [x21, #16]
	ldrsw	x2, [x8, x20, lsl #2]
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	add	x20, x20, #1
	ldrsw	x8, [x21, #48]
	cmp	x20, x8
	b.ge	LBB85_43
LBB85_40:                               ; %if.then86
                                        ; =>This Inner Loop Header: Depth=1
	ldrh	w8, [x21, #34]
	cmp	w8, #2
	b.lo	LBB85_38
; %bb.41:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB85_40 Depth=1
	udiv	w9, w20, w8
	msub	w8, w9, w8, w20
	cbnz	w8, LBB85_38
; %bb.42:                               ;   in Loop: Header=BB85_40 Depth=1
	mov	x2, x24
	b	LBB85_39
LBB85_43:                               ; %for.cond.cleanup
	ldrh	w8, [x21, #34]
Lloh208:
	adrp	x9, l_.str.8.119@PAGE
Lloh209:
	add	x9, x9, l_.str.8.119@PAGEOFF
Lloh210:
	adrp	x10, l_.str.20@PAGE
Lloh211:
	add	x10, x10, l_.str.20@PAGEOFF
	cmp	w8, #1
	csel	x2, x10, x9, hi
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x24, x0
	cmp	w25, #1
	b.gt	LBB85_122
; %bb.44:                               ; %if.then115
	ldrh	w8, [x21, #34]
Lloh212:
	adrp	x9, l_.str.23@PAGE
Lloh213:
	add	x9, x9, l_.str.23@PAGEOFF
Lloh214:
	adrp	x10, l_.str.22@PAGE
Lloh215:
	add	x10, x10, l_.str.22@PAGEOFF
	cmp	w8, #1
	csel	x2, x10, x9, hi
	mov	x0, x24
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x24, x0
	ldrh	w8, [x21, #34]
	cbz	w8, LBB85_122
; %bb.45:                               ; %if.end136.peel
	mov	x20, x27
	add	x27, x21, #8
	ldrb	w8, [x21, #32]
	cmp	w8, #3
	b.hi	LBB85_88
; %bb.46:                               ; %if.end136.peel
Lloh216:
	adrp	x9, LJTI85_0@PAGE
Lloh217:
	add	x9, x9, LJTI85_0@PAGEOFF
	adr	x10, LBB85_47
	ldrb	w11, [x9, x8]
	add	x10, x10, x11, lsl #2
	br	x10
LBB85_47:                               ; %if.then140.peel
	cmp	w19, #8
	b.eq	LBB85_79
; %bb.48:                               ; %if.then140.peel
	cmp	w19, #16
	b.eq	LBB85_80
; %bb.49:                               ; %if.then140.peel
	cmp	w19, #32
	b.ne	LBB85_81
; %bb.50:                               ; %if.then158.peel
	ldr	x8, [x27]
	ldrsw	x2, [x8]
	b	LBB85_84
LBB85_51:                               ; %if.then.i427
	mov	x1, #0
	mov	x2, x26
	mov	w3, #1
	bl	_halide_uint64_to_string
Lloh218:
	adrp	x2, l_.str.7.164@PAGE
Lloh219:
	add	x2, x2, l_.str.7.164@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
Lloh220:
	adrp	x1, l_.str.29.163@PAGE
Lloh221:
	add	x1, x1, l_.str.29.163@PAGEOFF
	mov	x0, #0
	bl	_halide_error
LBB85_52:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE0ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_free
LBB85_53:                               ; %if.end
	stp	w26, w27, [x25]
	ldr	w8, [x21, #32]
	str	w8, [x25, #8]
	ldur	q0, [x21, #36]
	stur	q0, [x25, #12]
	ldr	x1, [x21, #16]
	cbz	x1, LBB85_55
; %bb.54:                               ; %if.then28
	add	x0, x25, #28
	ldr	x2, [sp, #8]                    ; 8-byte Folded Reload
	bl	_memcpy
LBB85_55:                               ; %if.end33
	ldr	x1, [x21, #8]
	cbz	x1, LBB85_57
; %bb.56:                               ; %if.then35
	ldrsw	x8, [x25, #24]
	add	x8, x25, x8, lsl #2
	add	x0, x8, #28
	ldr	x2, [sp, #16]                   ; 8-byte Folded Reload
	bl	_memcpy
LBB85_57:                               ; %if.end40
	add	x19, x25, #28
	ldrsw	x8, [x25, #24]
	add	x8, x19, x8, lsl #2
	ldrh	w9, [x25, #10]
	ldrb	w10, [x25, #9]
	add	x10, x10, #7
	lsr	x10, x10, #3
	madd	x0, x10, x9, x8
	ldr	x1, [x21]
	ldr	x2, [sp, #32]                   ; 8-byte Folded Reload
	bl	_memcpy
	ldrsw	x8, [x25, #24]
	add	x8, x19, x8, lsl #2
	ldrh	w9, [x25, #10]
	ldrb	w10, [x25, #9]
	add	x10, x10, #7
	lsr	x10, x10, #3
	madd	x0, x10, x9, x8
LBB85_58:                               ; %while.cond.i409
                                        ; =>This Inner Loop Header: Depth=1
	ldrb	w8, [x0], #1
	cbnz	w8, LBB85_58
; %bb.59:                               ; %_ZN21halide_trace_packet_t9trace_tagEv.exit
	ldr	x8, [x21, #24]
Lloh222:
	adrp	x9, l_.str.1.10@PAGE
Lloh223:
	add	x9, x9, l_.str.1.10@PAGEOFF
	cmp	x8, #0
	csel	x1, x9, x8, eq
	mov	w2, w23
	bl	_memcpy
	ldr	x8, [x20]
	dmb	ish
	mov	w9, #-1
	ldaddal	w9, w8, [x8]
	ldr	w8, [x21, #36]
	cmp	w8, #9
	b.ne	LBB85_131
; %bb.60:                               ; %if.then57
	ldr	x20, [x20]
	mov	w8, #1073741824
	mov	w9, #-2147483648
LBB85_61:                               ; %while.body.i.i
                                        ; =>This Inner Loop Header: Depth=1
	ldsetal	w8, w10, [x20]
	mov	w10, #1073741824
	casal	w10, w9, [x20]
	cmp	w10, w8
	b.ne	LBB85_61
; %bb.62:                               ; %_ZN6Halide7Runtime8Internal23SharedExclusiveSpinLock17acquire_exclusiveEv.exit.i
	ldr	w8, [x20, #4]
	cbz	w8, LBB85_65
; %bb.63:                               ; %if.then.i
	ldr	w9, [x20, #8]
	sub	w19, w8, w9
	str	w19, [x20, #4]
	add	x1, x20, #12
	mov	x0, x22
	mov	x2, x19
	bl	_write
	stp	wzr, wzr, [x20, #4]
	mov	w8, #-2147483648
	ldclral	w8, w8, [x20]
	cmp	w19, w0
	b.eq	LBB85_131
; %bb.64:                               ; %if.then10.i
Lloh224:
	adrp	x1, l_.str.32@PAGE
Lloh225:
	add	x1, x1, l_.str.32@PAGEOFF
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	bl	_halide_print
	bl	_abort
	b	LBB85_131
LBB85_65:                               ; %do.end.critedge.i
	mov	w8, #-2147483648
	ldclral	w8, w8, [x20]
	b	LBB85_131
LBB85_66:                               ; %if.then176.peel
	cmp	w19, #8
	b.eq	LBB85_82
; %bb.67:                               ; %if.then176.peel
	cmp	w19, #16
	b.eq	LBB85_83
; %bb.68:                               ; %if.then176.peel
	cmp	w19, #32
	b.ne	LBB85_85
; %bb.69:                               ; %if.then194.peel
	ldr	x8, [x27]
	ldr	w2, [x8]
	b	LBB85_86
LBB85_70:                               ; %do.body213.peel
	cmp	w19, #15
	b.gt	LBB85_72
; %bb.71:                               ; %if.then215.peel
Lloh226:
	adrp	x1, l_.str.24@PAGE
Lloh227:
	add	x1, x1, l_.str.24@PAGEOFF
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	bl	_halide_print
	bl	_abort
LBB85_72:                               ; %do.end218.peel
	cmp	w19, #32
	b.eq	LBB85_76
; %bb.73:                               ; %do.end218.peel
	cmp	w19, #16
	b.ne	LBB85_77
; %bb.74:                               ; %if.then227.peel
	ldr	x8, [x27]
	ldrh	w0, [x8]
	bl	_halide_float16_bits_to_double
	b	LBB85_78
LBB85_75:                               ; %if.then244.peel
	ldr	x8, [x27]
	ldr	x2, [x8]
	mov	x0, x24
	mov	x1, x23
	bl	_halide_pointer_to_string
	b	LBB85_87
LBB85_76:                               ; %if.then220.peel
	ldr	x8, [x27]
	ldr	s0, [x8]
	fcvt	d0, s0
	mov	x0, x24
	mov	x1, x23
	mov	w2, #0
	bl	_halide_double_to_string
	b	LBB85_87
LBB85_77:                               ; %if.else232.peel
	ldr	x8, [x27]
	ldr	d0, [x8]
LBB85_78:                               ; %for.inc253.peel
	mov	x0, x24
	mov	x1, x23
	mov	w2, #1
	bl	_halide_double_to_string
	b	LBB85_87
LBB85_79:                               ; %if.then142.peel
	ldr	x8, [x27]
	ldrsb	x2, [x8]
	b	LBB85_84
LBB85_80:                               ; %if.then150.peel
	ldr	x8, [x27]
	ldrsh	x2, [x8]
	b	LBB85_84
LBB85_81:                               ; %if.else163.peel
	ldr	x8, [x27]
	ldr	x2, [x8]
	b	LBB85_84
LBB85_82:                               ; %if.then178.peel
	ldr	x8, [x27]
	ldrb	w2, [x8]
	b	LBB85_84
LBB85_83:                               ; %if.then186.peel
	ldr	x8, [x27]
	ldrh	w2, [x8]
LBB85_84:                               ; %for.inc253.peel
	mov	x0, x24
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	b	LBB85_87
LBB85_85:                               ; %if.else199.peel
	ldr	x8, [x27]
	ldr	x2, [x8]
LBB85_86:                               ; %for.inc253.peel
	mov	x0, x24
	mov	x1, x23
	mov	w3, #1
	bl	_halide_uint64_to_string
LBB85_87:                               ; %for.inc253.peel
	mov	x24, x0
LBB85_88:                               ; %for.inc253.peel
	ldrh	w8, [x21, #34]
	cmp	w8, #2
	b.lo	LBB85_119
; %bb.89:                               ; %if.end136.preheader
	mov	w28, #1
Lloh228:
	adrp	x25, l_.str.55@PAGE
Lloh229:
	add	x25, x25, l_.str.55@PAGEOFF
Lloh230:
	adrp	x26, LJTI85_1@PAGE
Lloh231:
	add	x26, x26, LJTI85_1@PAGEOFF
	b	LBB85_94
LBB85_90:                               ; %if.then186
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldrh	w2, [x8, x28, lsl #1]
LBB85_91:                               ; %for.inc253
                                        ;   in Loop: Header=BB85_94 Depth=1
	mov	x0, x24
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
LBB85_92:                               ; %for.inc253
                                        ;   in Loop: Header=BB85_94 Depth=1
	mov	x24, x0
LBB85_93:                               ; %for.inc253
                                        ;   in Loop: Header=BB85_94 Depth=1
	add	x28, x28, #1
	ldrh	w8, [x21, #34]
	cmp	x28, x8
	b.hs	LBB85_120
LBB85_94:                               ; %if.end136
                                        ; =>This Inner Loop Header: Depth=1
	mov	x0, x24
	mov	x1, x23
	mov	x2, x25
	bl	_halide_string_to_string
	mov	x24, x0
	ldrb	w8, [x21, #32]
	cmp	w8, #3
	b.hi	LBB85_93
; %bb.95:                               ; %if.end136
                                        ;   in Loop: Header=BB85_94 Depth=1
	adr	x9, LBB85_96
	ldrb	w10, [x26, x8]
	add	x9, x9, x10, lsl #2
	br	x9
LBB85_96:                               ; %if.then140
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #32
	b.eq	LBB85_113
; %bb.97:                               ; %if.then140
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #16
	b.eq	LBB85_114
; %bb.98:                               ; %if.then140
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #8
	b.ne	LBB85_116
; %bb.99:                               ; %if.then142
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldrsb	x2, [x8, x28]
	b	LBB85_91
LBB85_100:                              ; %if.then176
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #32
	b.eq	LBB85_115
; %bb.101:                              ; %if.then176
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #16
	b.eq	LBB85_90
; %bb.102:                              ; %if.then176
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #8
	b.ne	LBB85_117
; %bb.103:                              ; %if.then178
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldrb	w2, [x8, x28]
	b	LBB85_91
LBB85_104:                              ; %do.body213
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #15
	b.gt	LBB85_106
; %bb.105:                              ; %if.then215
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
Lloh232:
	adrp	x1, l_.str.24@PAGE
Lloh233:
	add	x1, x1, l_.str.24@PAGEOFF
	bl	_halide_print
	bl	_abort
LBB85_106:                              ; %do.end218
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #16
	b.eq	LBB85_110
; %bb.107:                              ; %do.end218
                                        ;   in Loop: Header=BB85_94 Depth=1
	cmp	w19, #32
	b.ne	LBB85_111
; %bb.108:                              ; %if.then220
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldr	s0, [x8, x28, lsl #2]
	fcvt	d0, s0
	mov	x0, x24
	mov	x1, x23
	mov	w2, #0
	bl	_halide_double_to_string
	b	LBB85_92
LBB85_109:                              ; %if.then244
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldr	x2, [x8, x28, lsl #3]
	mov	x0, x24
	mov	x1, x23
	bl	_halide_pointer_to_string
	b	LBB85_92
LBB85_110:                              ; %if.then227
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldrh	w0, [x8, x28, lsl #1]
	bl	_halide_float16_bits_to_double
	b	LBB85_112
LBB85_111:                              ; %if.else232
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldr	d0, [x8, x28, lsl #3]
LBB85_112:                              ; %for.inc253
                                        ;   in Loop: Header=BB85_94 Depth=1
	mov	x0, x24
	mov	x1, x23
	mov	w2, #1
	bl	_halide_double_to_string
	b	LBB85_92
LBB85_113:                              ; %if.then158
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldrsw	x2, [x8, x28, lsl #2]
	b	LBB85_91
LBB85_114:                              ; %if.then150
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldrsh	x2, [x8, x28, lsl #1]
	b	LBB85_91
LBB85_115:                              ; %if.then194
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldr	w2, [x8, x28, lsl #2]
	b	LBB85_118
LBB85_116:                              ; %if.else163
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldr	x2, [x8, x28, lsl #3]
	b	LBB85_91
LBB85_117:                              ; %if.else199
                                        ;   in Loop: Header=BB85_94 Depth=1
	ldr	x8, [x27]
	ldr	x2, [x8, x28, lsl #3]
LBB85_118:                              ; %for.inc253
                                        ;   in Loop: Header=BB85_94 Depth=1
	mov	x0, x24
	mov	x1, x23
	mov	w3, #1
	bl	_halide_uint64_to_string
	b	LBB85_92
LBB85_119:
	mov	x27, x20
	b	LBB85_122
LBB85_120:                              ; %for.cond.cleanup131
	cmp	w8, #1
	mov	x27, x20
	b.ls	LBB85_122
; %bb.121:                              ; %if.then260
Lloh234:
	adrp	x2, l_.str.25@PAGE
Lloh235:
	add	x2, x2, l_.str.25@PAGEOFF
	mov	x0, x24
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x24, x0
LBB85_122:                              ; %if.end263
	ldr	x8, [x21, #24]
	cbz	x8, LBB85_125
; %bb.123:                              ; %land.lhs.true266
	ldrb	w8, [x8]
	cbz	w8, LBB85_125
; %bb.124:                              ; %if.then269
Lloh236:
	adrp	x2, l_.str.26@PAGE
Lloh237:
	add	x2, x2, l_.str.26@PAGEOFF
	mov	x0, x24
	mov	x1, x23
	bl	_halide_string_to_string
	ldr	x2, [x21, #24]
	mov	x1, x23
	bl	_halide_string_to_string
Lloh238:
	adrp	x2, l_.str.27@PAGE
Lloh239:
	add	x2, x2, l_.str.27@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x24, x0
LBB85_125:                              ; %if.end274
Lloh240:
	adrp	x2, l_.str.7.164@PAGE
Lloh241:
	add	x2, x2, l_.str.7.164@PAGEOFF
	mov	x0, x24
	mov	x1, x23
	bl	_halide_string_to_string
Lloh242:
	adrp	x20, __ZN6Halide7Runtime8Internal22halide_trace_file_lockE@GOTPAGE
Lloh243:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal22halide_trace_file_lockE@GOTPAGEOFF]
	mov	w8, #1
LBB85_126:                              ; %while.cond.i414
                                        ; =>This Inner Loop Header: Depth=1
	swpab	w8, w9, [x20]
	cbnz	w9, LBB85_126
; %bb.127:                              ; %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit
	cbz	x22, LBB85_129
; %bb.128:                              ; %if.else.i564
	sub	x8, x0, x22
	add	x19, x8, #1
	ldr	x21, [sp, #40]                  ; 8-byte Folded Reload
	mov	x0, x21
	mov	x1, x22
	mov	x2, x19
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x0, x21
	mov	x1, x22
	bl	_halide_print
	stlrb	wzr, [x20]
	mov	x0, x21
	mov	x1, x22
	mov	x2, x19
	bl	_halide_msan_annotate_memory_is_initialized
	b	LBB85_130
LBB85_129:                              ; %if.then.i558
Lloh244:
	adrp	x19, l_.str.29.163@PAGE
Lloh245:
	add	x19, x19, l_.str.29.163@PAGEOFF
	ldr	x21, [sp, #40]                  ; 8-byte Folded Reload
	mov	x0, x21
	mov	x1, x19
	bl	_halide_print
	stlrb	wzr, [x20]
	mov	x0, x21
	mov	x1, x19
	bl	_halide_error
LBB85_130:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy4096EED2Ev.exit
	mov	x0, x22
	bl	_free
LBB85_131:                              ; %if.end277
	mov	x0, x27
	ldp	x29, x30, [sp, #128]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #112]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #96]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #80]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #64]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #144
	ret
	.loh AdrpAdd	Lloh177, Lloh178
	.loh AdrpLdrGotLdr	Lloh179, Lloh180, Lloh181
	.loh AdrpAdd	Lloh182, Lloh183
	.loh AdrpAdd	Lloh184, Lloh185
	.loh AdrpAdd	Lloh186, Lloh187
	.loh AdrpLdrGot	Lloh188, Lloh189
	.loh AdrpAdd	Lloh190, Lloh191
	.loh AdrpAdd	Lloh192, Lloh193
	.loh AdrpAdd	Lloh200, Lloh201
	.loh AdrpAdd	Lloh198, Lloh199
	.loh AdrpAdd	Lloh196, Lloh197
	.loh AdrpAdd	Lloh194, Lloh195
	.loh AdrpAdd	Lloh202, Lloh203
	.loh AdrpAdd	Lloh206, Lloh207
	.loh AdrpAdd	Lloh204, Lloh205
	.loh AdrpAdd	Lloh210, Lloh211
	.loh AdrpAdd	Lloh208, Lloh209
	.loh AdrpAdd	Lloh214, Lloh215
	.loh AdrpAdd	Lloh212, Lloh213
	.loh AdrpAdd	Lloh216, Lloh217
	.loh AdrpAdd	Lloh220, Lloh221
	.loh AdrpAdd	Lloh218, Lloh219
	.loh AdrpAdd	Lloh222, Lloh223
	.loh AdrpAdd	Lloh224, Lloh225
	.loh AdrpAdd	Lloh226, Lloh227
	.loh AdrpAdd	Lloh230, Lloh231
	.loh AdrpAdd	Lloh228, Lloh229
	.loh AdrpAdd	Lloh232, Lloh233
	.loh AdrpAdd	Lloh234, Lloh235
	.loh AdrpAdd	Lloh238, Lloh239
	.loh AdrpAdd	Lloh236, Lloh237
	.loh AdrpLdrGot	Lloh242, Lloh243
	.loh AdrpAdd	Lloh240, Lloh241
	.loh AdrpAdd	Lloh244, Lloh245
	.section	__TEXT,__const
LJTI85_0:
	.byte	(LBB85_47-LBB85_47)>>2
	.byte	(LBB85_66-LBB85_47)>>2
	.byte	(LBB85_70-LBB85_47)>>2
	.byte	(LBB85_75-LBB85_47)>>2
LJTI85_1:
	.byte	(LBB85_96-LBB85_96)>>2
	.byte	(LBB85_100-LBB85_96)>>2
	.byte	(LBB85_104-LBB85_96)>>2
	.byte	(LBB85_109-LBB85_96)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_get_trace_file          ; -- Begin function halide_get_trace_file
	.weak_definition	_halide_get_trace_file
	.p2align	2
_halide_get_trace_file:                 ; @halide_get_trace_file
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x0
Lloh246:
	adrp	x21, __ZN6Halide7Runtime8Internal22halide_trace_file_lockE@GOTPAGE
Lloh247:
	ldr	x21, [x21, __ZN6Halide7Runtime8Internal22halide_trace_file_lockE@GOTPAGEOFF]
	mov	w8, #1
LBB86_1:                                ; %while.cond.i
                                        ; =>This Inner Loop Header: Depth=1
	swpab	w8, w9, [x21]
	cbnz	w9, LBB86_1
; %bb.2:                                ; %_ZN6Halide7Runtime8Internal14ScopedSpinLockC2EPVc.exit
Lloh248:
	adrp	x22, __ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPAGE
Lloh249:
	ldr	x22, [x22, __ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPAGEOFF]
	ldr	w8, [x22]
	tbnz	w8, #31, LBB86_4
LBB86_3:                                ; %if.end11
	ldr	w0, [x22]
	stlrb	wzr, [x21]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB86_4:                                ; %if.then
Lloh250:
	adrp	x0, l_.str.28@PAGE
Lloh251:
	add	x0, x0, l_.str.28@PAGEOFF
	bl	_getenv
	cbz	x0, LBB86_9
; %bb.5:                                ; %if.then1
Lloh252:
	adrp	x1, l_.str.29@PAGE
Lloh253:
	add	x1, x1, l_.str.29@PAGEOFF
	bl	_fopen
	mov	x20, x0
	cbnz	x0, LBB86_7
; %bb.6:                                ; %if.then4
Lloh254:
	adrp	x1, l_.str.30@PAGE
Lloh255:
	add	x1, x1, l_.str.30@PAGEOFF
	mov	x0, x19
	bl	_halide_print
	bl	_abort
LBB86_7:                                ; %do.end
	mov	x0, x20
	bl	_fileno
	bl	_halide_set_trace_file
Lloh256:
	adrp	x8, __ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE@GOTPAGE
Lloh257:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE@GOTPAGEOFF]
Lloh258:
	str	x20, [x8]
Lloh259:
	adrp	x19, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGE
Lloh260:
	ldr	x19, [x19, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGEOFF]
	ldr	x8, [x19]
	cbnz	x8, LBB86_3
; %bb.8:                                ; %if.then7
	mov	w0, #12
	movk	w0, #16, lsl #16
	bl	_malloc
	str	x0, [x19]
	stp	wzr, wzr, [x0, #4]
	str	wzr, [x0]
	ldr	w0, [x22]
	stlrb	wzr, [x21]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB86_9:                                ; %if.else
	bl	_halide_set_trace_file
	ldr	w0, [x22]
	stlrb	wzr, [x21]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh246, Lloh247
	.loh AdrpLdrGot	Lloh248, Lloh249
	.loh AdrpAdd	Lloh250, Lloh251
	.loh AdrpAdd	Lloh252, Lloh253
	.loh AdrpAdd	Lloh254, Lloh255
	.loh AdrpLdrGot	Lloh259, Lloh260
	.loh AdrpLdrGotStr	Lloh256, Lloh257, Lloh258
                                        ; -- End function
	.globl	_halide_set_trace_file          ; -- Begin function halide_set_trace_file
	.weak_definition	_halide_set_trace_file
	.p2align	2
_halide_set_trace_file:                 ; @halide_set_trace_file
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh261:
	adrp	x8, __ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPAGE
Lloh262:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPAGEOFF]
Lloh263:
	str	w0, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGotStr	Lloh261, Lloh262, Lloh263
                                        ; -- End function
	.globl	_halide_trace_cleanup           ; -- Begin function halide_trace_cleanup
	.weak_definition	_halide_trace_cleanup
	.p2align	2
_halide_trace_cleanup:                  ; @halide_trace_cleanup
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_halide_shutdown_trace
                                        ; -- End function
	.globl	_halide_shutdown_trace          ; -- Begin function halide_shutdown_trace
	.weak_definition	_halide_shutdown_trace
	.p2align	2
_halide_shutdown_trace:                 ; @halide_shutdown_trace
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
Lloh264:
	adrp	x20, __ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE@GOTPAGE
Lloh265:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE@GOTPAGEOFF]
	ldr	x0, [x20]
	cbz	x0, LBB89_4
; %bb.1:                                ; %if.then
	bl	_fclose
	mov	x19, x0
Lloh266:
	adrp	x8, __ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPAGE
Lloh267:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal17halide_trace_fileE@GOTPAGEOFF]
Lloh268:
	adrp	x9, __ZN6Halide7Runtime8Internal29halide_trace_file_initializedE@GOTPAGE
Lloh269:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal29halide_trace_file_initializedE@GOTPAGEOFF]
Lloh270:
	str	wzr, [x8]
Lloh271:
	strb	wzr, [x9]
	str	xzr, [x20]
Lloh272:
	adrp	x8, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGE
Lloh273:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19halide_trace_bufferE@GOTPAGEOFF]
Lloh274:
	ldr	x0, [x8]
	cbz	x0, LBB89_3
; %bb.2:                                ; %if.then2
	bl	_free
LBB89_3:                                ; %return
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB89_4:
	mov	w19, #0
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh264, Lloh265
	.loh AdrpLdrGotLdr	Lloh272, Lloh273, Lloh274
	.loh AdrpLdrGotStr	Lloh268, Lloh269, Lloh271
	.loh AdrpLdrGotStr	Lloh266, Lloh267, Lloh270
                                        ; -- End function
	.globl	_halide_set_custom_trace        ; -- Begin function halide_set_custom_trace
	.weak_definition	_halide_set_custom_trace
	.p2align	2
_halide_set_custom_trace:               ; @halide_set_custom_trace
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh275:
	adrp	x9, __ZN6Halide7Runtime8Internal19halide_custom_traceE@GOTPAGE
Lloh276:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal19halide_custom_traceE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh275, Lloh276
                                        ; -- End function
	.globl	_halide_trace                   ; -- Begin function halide_trace
	.weak_definition	_halide_trace
	.p2align	2
_halide_trace:                          ; @halide_trace
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh277:
	adrp	x8, __ZN6Halide7Runtime8Internal19halide_custom_traceE@GOTPAGE
Lloh278:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19halide_custom_traceE@GOTPAGEOFF]
Lloh279:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh277, Lloh278, Lloh279
                                        ; -- End function
	.globl	_halide_trace_helper            ; -- Begin function halide_trace_helper
	.weak_definition	_halide_trace_helper
	.p2align	2
_halide_trace_helper:                   ; @halide_trace_helper
; %bb.0:                                ; %entry
	sub	sp, sp, #128
	stp	x24, x23, [sp, #64]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	mov	x19, x6
	mov	x20, x5
	mov	x21, x3
	mov	x22, x2
	mov	x23, x0
	ldp	w8, w24, [x29, #20]
                                        ; kill: def $w24 killed $w24 def $x24
	sxtw	x24, w24
	ldr	w9, [x29, #16]
	ldr	x10, [x29, #32]
	stp	x1, x2, [sp, #8]
	stp	x3, x10, [sp, #24]
	strb	w4, [sp, #40]
	strb	w5, [sp, #41]
	strh	w6, [sp, #42]
	stp	w7, w9, [sp, #44]
	stp	w8, w24, [sp, #52]
	add	x1, sp, #8
	mov	w2, #56
	bl	_halide_msan_annotate_memory_is_initialized
	add	w8, w20, #7
	add	w9, w20, #14
	cmp	w8, #0
	csel	w8, w9, w8, lt
	asr	w8, w8, #3
	mul	w8, w8, w19
	sxtw	x2, w8
	mov	x0, x23
	mov	x1, x22
	bl	_halide_msan_annotate_memory_is_initialized
	lsl	x2, x24, #2
	mov	x0, x23
	mov	x1, x21
	bl	_halide_msan_annotate_memory_is_initialized
	add	x1, sp, #8
	mov	x0, x23
	bl	_halide_trace
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_ ; -- Begin function _ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	.weak_definition	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	.p2align	2
__ZN6Halide7Runtime8Internal9ends_withEPKcS3_: ; @_ZN6Halide7Runtime8Internal9ends_withEPKcS3_
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w10, #1
	mov	x8, x0
LBB93_1:                                ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov	x13, x8
	mov	x9, x10
	ldrb	w11, [x8], #1
	sub	x10, x10, #1
	cbnz	w11, LBB93_1
; %bb.2:                                ; %while.cond1.preheader
	mov	w12, #1
	mov	x10, x1
LBB93_3:                                ; %while.cond1
                                        ; =>This Inner Loop Header: Depth=1
	mov	x15, x10
	mov	x11, x12
	ldrb	w14, [x10], #1
	sub	x12, x12, #1
	cbnz	w14, LBB93_3
; %bb.4:                                ; %while.cond6.preheader
	mov	w12, #0
	mov	w14, #0
	cmp	x13, x0
	b.eq	LBB93_11
; %bb.5:                                ; %while.cond6.preheader
	cmp	x15, x1
	b.eq	LBB93_11
; %bb.6:                                ; %if.end.preheader
	mov	x13, #-2
LBB93_7:                                ; %if.end
                                        ; =>This Inner Loop Header: Depth=1
	ldrb	w14, [x8, x13]
	ldrb	w12, [x10, x13]
	cbz	x9, LBB93_11
; %bb.8:                                ; %if.end
                                        ;   in Loop: Header=BB93_7 Depth=1
	cbz	x11, LBB93_11
; %bb.9:                                ; %if.end.while.body8_crit_edge
                                        ;   in Loop: Header=BB93_7 Depth=1
	sub	x13, x13, #1
	add	x9, x9, #1
	add	x11, x11, #1
	cmp	w14, w12
	b.eq	LBB93_7
; %bb.10:
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB93_11:                               ; %while.end13
	cmp	w14, w12
	cset	w0, eq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ; -- Begin function halide_debug_to_file
lCPI94_0:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
lCPI94_1:
	.long	6                               ; 0x6
	.long	8                               ; 0x8
lCPI94_2:
	.long	1                               ; 0x1
	.long	5                               ; 0x5
lCPI94_3:
	.long	1                               ; 0x1
	.long	194                             ; 0xc2
lCPI94_4:
	.long	1                               ; 0x1
	.long	202                             ; 0xca
	.section	__TEXT,__literal16,16byte_literals
	.p2align	4
lCPI94_5:
	.long	0                               ; 0x0
	.long	1                               ; 0x1
	.long	1                               ; 0x1
	.long	1                               ; 0x1
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_debug_to_file
	.weak_definition	_halide_debug_to_file
	.p2align	2
_halide_debug_to_file:                  ; @halide_debug_to_file
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	sub	sp, sp, #1, lsl #12             ; =4096
	sub	sp, sp, #320
	mov	x23, x0
	ldr	x8, [x3, #16]
	ldr	x9, [x3]
	cmp	x8, #0
	ccmp	x9, #0, #0, eq
	b.eq	LBB94_3
; %bb.1:                                ; %if.end
	mov	x20, x3
	ldr	w8, [x3, #36]
	cmp	w8, #5
	b.lt	LBB94_6
; %bb.2:                                ; %if.then1
Lloh280:
	adrp	x1, l_.str.1.35@PAGE
Lloh281:
	add	x1, x1, l_.str.1.35@PAGEOFF
	b	LBB94_4
LBB94_3:                                ; %if.then
Lloh282:
	adrp	x1, l_.str.34@PAGE
Lloh283:
	add	x1, x1, l_.str.34@PAGEOFF
LBB94_4:                                ; %return
	mov	x0, x23
	bl	_halide_error
	mov	w21, #-1
LBB94_5:                                ; %return
	mov	x0, x21
	add	sp, sp, #1, lsl #12             ; =4096
	add	sp, sp, #320
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB94_6:                                ; %if.end2
	mov	x22, x2
	mov	x24, x1
	mov	x0, x23
	mov	x1, x20
	bl	_halide_copy_to_host
	mov	x21, x0
	cbnz	w0, LBB94_5
; %bb.7:                                ; %if.end6
Lloh284:
	adrp	x1, l_.str.2.36@PAGE
Lloh285:
	add	x1, x1, l_.str.2.36@PAGEOFF
	mov	x0, x24
	bl	_fopen
	cbz	x0, LBB94_14
; %bb.8:                                ; %if.end9
	mov	x19, x0
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [x29, #-160]
	stp	q0, q0, [x29, #-128]
	ldrsw	x8, [x20, #36]
	cmp	w8, #1
	b.lt	LBB94_15
; %bb.9:                                ; %for.body.lr.ph
	ldr	x9, [x20, #40]
	sub	w10, w8, #1
	cmp	w10, #3
	mov	w11, #3
	csel	w10, w10, w11, lo
	ldr	q0, [x9]
	stur	q0, [x29, #-160]
	ldur	w25, [x29, #-156]
	cbz	w10, LBB94_13
; %bb.10:                               ; %for.body.1
	add	w10, w10, #1
	ldr	q0, [x9, #16]
	stur	q0, [x29, #-144]
	ldur	w11, [x29, #-140]
	mul	x25, x25, x11
	cmp	w10, #2
	b.eq	LBB94_13
; %bb.11:                               ; %for.body.2
	ldr	q0, [x9, #32]
	stur	q0, [x29, #-128]
	ldur	w11, [x29, #-124]
	mul	x25, x25, x11
	cmp	w10, #3
	b.eq	LBB94_13
; %bb.12:                               ; %for.body.3
	ldr	q0, [x9, #48]
	stur	q0, [x29, #-112]
	ldur	w9, [x29, #-108]
	mul	x25, x25, x9
LBB94_13:                               ; %for.cond19.preheader
	cmp	w8, #3
	b.le	LBB94_16
	b	LBB94_22
LBB94_14:
	mov	w21, #-2
	b	LBB94_5
LBB94_15:
	mov	w25, #1
LBB94_16:                               ; %for.body22.preheader
	adrp	x9, lCPI94_0@PAGE
	cmp	w8, #3
	b.eq	LBB94_20
; %bb.17:                               ; %vector.ph
	mov	w10, #3
	sub	w10, w10, w8
	add	x10, x10, #1
	and	x11, x10, #0x1fffffffe
	add	x12, x11, x8
	sub	x13, x29, #160
	add	x8, x13, x8, lsl #4
	add	x8, x8, #16
	ldr	d0, [x9, lCPI94_0@PAGEOFF]
	mov	x13, x11
LBB94_18:                               ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
	stur	d0, [x8, #-16]
	str	d0, [x8]
	stur	wzr, [x8, #-8]
	str	wzr, [x8, #8]
	add	x8, x8, #32
	subs	x13, x13, #2
	b.ne	LBB94_18
; %bb.19:                               ; %middle.block
	mov	x8, x12
	cmp	x10, x11
	b.eq	LBB94_22
LBB94_20:                               ; %for.body22.preheader4
	sub	w10, w8, #4
	sub	x11, x29, #160
	add	x8, x11, x8, lsl #4
	orr	x8, x8, #0x8
	ldr	d0, [x9, lCPI94_0@PAGEOFF]
LBB94_21:                               ; %for.body22
                                        ; =>This Inner Loop Header: Depth=1
	stur	d0, [x8, #-8]
	str	wzr, [x8], #16
	adds	w10, w10, #1
	b.lo	LBB94_21
LBB94_22:                               ; %for.cond.cleanup21
	ldrb	w8, [x20, #33]
	add	x26, x8, #7
	lsr	x21, x26, #3
Lloh286:
	adrp	x1, l_.str.3.37@PAGE
Lloh287:
	add	x1, x1, l_.str.3.37@PAGEOFF
	mov	x0, x24
	bl	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	tbnz	w0, #0, LBB94_24
; %bb.23:                               ; %lor.lhs.false
Lloh288:
	adrp	x1, l_.str.4.38@PAGE
Lloh289:
	add	x1, x1, l_.str.4.38@PAGEOFF
	mov	x0, x24
	bl	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	cbz	w0, LBB94_33
LBB94_24:                               ; %if.then36
	add	x8, sp, #32
	ldur	w10, [x29, #-156]
	ldur	w11, [x29, #-140]
	ldur	w9, [x29, #-108]
	ldur	w12, [x29, #-124]
	cmp	w9, #2
	cset	w13, lo
	cmp	w12, #5
	cset	w14, lt
	tst	w13, w14
	csinc	w24, w12, wzr, eq
	csel	w23, w12, w9, ne
	mov	x9, #18761
	movk	x9, #42, lsl #16
	movk	x9, #8, lsl #32
	str	x9, [sp, #32]
	mov	w9, #15
	movk	w9, #256, lsl #16
	str	w9, [sp, #40]
	mov	w9, #4
	strh	w9, [sp, #44]
	mov	w9, #1
	stur	w9, [sp, #46]
	stur	w10, [sp, #50]
	mov	x10, #257
	movk	x10, #4, lsl #16
	movk	x10, #1, lsl #32
	stur	x10, [sp, #54]
	stur	w11, [sp, #62]
	and	w10, w26, #0x1f8
	mov	x12, #258
	movk	x12, #3, lsl #16
	movk	x12, #1, lsl #32
	stur	x12, [sp, #66]
	strh	w10, [sp, #74]
	mov	x10, #259
	movk	x10, #3, lsl #16
	movk	x10, #1, lsl #32
	stur	x10, [sp, #78]
	strh	w9, [sp, #86]
	cmp	w23, #2
	cinc	w10, w9, gt
	mov	x12, #262
	movk	x12, #3, lsl #16
	movk	x12, #1, lsl #32
	stur	x12, [sp, #90]
	strh	w10, [sp, #98]
	mov	w10, #273
	movk	w10, #4, lsl #16
	stur	w10, [sp, #102]
	stur	w23, [sp, #106]
	mov	x10, #210
	movk	x10, #277, lsl #32
	movk	x10, #3, lsl #48
	stur	x10, [sp, #110]
	stur	w9, [sp, #118]
	strh	w23, [sp, #122]
	mov	x10, #278
	movk	x10, #4, lsl #16
	movk	x10, #1, lsl #32
	stur	x10, [sp, #126]
	stur	w11, [sp, #134]
	mul	w10, w21, w25
	lsl	w11, w23, #2
	add	w11, w11, #210
	cmp	w23, #1
	csel	w10, w10, w11, eq
	mov	w11, #279
	movk	w11, #4, lsl #16
	stur	w11, [sp, #138]
	stur	w23, [sp, #142]
	stur	w10, [sp, #146]
	mov	w10, #282
	movk	w10, #5, lsl #16
	stur	w10, [sp, #150]
Lloh290:
	adrp	x10, lCPI94_3@PAGE
Lloh291:
	ldr	d0, [x10, lCPI94_3@PAGEOFF]
	stur	d0, [sp, #154]
	mov	w10, #283
	movk	w10, #5, lsl #16
	stur	w10, [x8, #130]
Lloh292:
	adrp	x10, lCPI94_4@PAGE
Lloh293:
	ldr	d0, [x10, lCPI94_4@PAGEOFF]
	stur	d0, [x8, #134]
	mov	x10, #284
	movk	x10, #3, lsl #16
	movk	x10, #1, lsl #32
	stur	x10, [x8, #142]
	mov	w10, #2
	strh	w10, [sp, #182]
	mov	x10, #296
	movk	x10, #3, lsl #16
	movk	x10, #1, lsl #32
	stur	x10, [x8, #154]
	strh	w9, [sp, #194]
Lloh294:
	adrp	x10, __ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE@GOTPAGE
Lloh295:
	ldr	x10, [x10, __ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE@GOTPAGEOFF]
	ldrh	w10, [x10, w22, sxtw #1]
	mov	x11, #339
	movk	x11, #3, lsl #16
	movk	x11, #1, lsl #32
	stur	x11, [x8, #166]
	strh	w10, [sp, #206]
	mov	x10, #32997
	movk	x10, #4, lsl #16
	movk	x10, #1, lsl #32
	stur	x10, [x8, #178]
	stur	w24, [x8, #186]
Lloh296:
	adrp	x10, lCPI94_5@PAGE
Lloh297:
	ldr	q0, [x10, lCPI94_5@PAGEOFF]
	stur	q0, [x8, #190]
	stur	w9, [x8, #206]
	add	x0, sp, #32
	mov	w1, #210
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_32
; %bb.25:                               ; %if.end103
	cmp	w23, #2
	b.lt	LBB94_41
; %bb.26:                               ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit672.lr.ph
	lsl	w8, w23, #3
	add	w8, w8, #210
	str	w8, [sp, #4192]
	mul	w22, w24, w21
	mov	x24, x23
LBB94_27:                               ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit672
                                        ; =>This Inner Loop Header: Depth=1
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #96
	mov	w1, #4
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_78
; %bb.28:                               ; %if.end118
                                        ;   in Loop: Header=BB94_27 Depth=1
	ldur	w8, [x29, #-156]
	ldur	w9, [x29, #-140]
	mul	w8, w22, w8
	mul	w8, w8, w9
	ldr	w9, [sp, #4192]
	add	w9, w8, w9
	str	w9, [sp, #4192]
	subs	w24, w24, #1
	b.ne	LBB94_27
; %bb.29:                               ; %for.end129
	str	w8, [sp, #4160]
LBB94_30:                               ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit679
                                        ; =>This Inner Loop Header: Depth=1
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #64
	mov	w1, #4
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_91
; %bb.31:                               ; %for.cond138
                                        ;   in Loop: Header=BB94_30 Depth=1
	subs	w23, w23, #1
	b.ne	LBB94_30
	b	LBB94_41
LBB94_32:
	mov	w21, #-3
	b	LBB94_145
LBB94_33:                               ; %if.else164
Lloh298:
	adrp	x1, l_.str.5.39@PAGE
Lloh299:
	add	x1, x1, l_.str.5.39@PAGEOFF
	mov	x0, x24
	bl	__ZN6Halide7Runtime8Internal9ends_withEPKcS3_
	cbz	w0, LBB94_40
; %bb.34:                               ; %while.cond.preheader
	mov	x8, #0
	add	x26, sp, #1, lsl #12            ; =4096
	add	x26, x26, #64
LBB94_35:                               ; %while.cond
                                        ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x24, x8]
	add	x8, x8, #1
	cbnz	w9, LBB94_35
LBB94_36:                               ; %while.body171
                                        ; =>This Inner Loop Header: Depth=1
	add	x9, x24, x8
	ldurb	w9, [x9, #-2]
	sub	x8, x8, #1
	cmp	w9, #46
	b.ne	LBB94_36
; %bb.37:                               ; %while.cond174.preheader
	mov	x25, #0
	neg	x9, x8
	mov	w10, #1
	sub	x10, x10, x8
LBB94_38:                               ; %while.cond174
                                        ; =>This Inner Loop Header: Depth=1
	cbz	x10, LBB94_79
; %bb.39:                               ; %land.rhs176
                                        ;   in Loop: Header=BB94_38 Depth=1
	add	x11, x24, x25
	add	x11, x11, x8
	ldurb	w11, [x11, #-2]
	sub	x25, x25, #1
	add	x10, x10, #1
	cmp	w11, #47
	b.ne	LBB94_38
	b	LBB94_80
LBB94_40:                               ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit728
	ldur	w8, [x29, #-156]
	ldur	w9, [x29, #-140]
	stp	w8, w9, [sp, #32]
	ldur	w8, [x29, #-124]
	ldur	w9, [x29, #-108]
	stp	w8, w9, [sp, #40]
	str	w22, [sp, #48]
	add	x0, sp, #32
	mov	w1, #20
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_92
LBB94_41:                               ; %cleanup154.thread
	mov	w28, #0
LBB94_42:                               ; %if.end311
	ldur	w11, [x29, #-108]
	cmp	w11, #1
	b.lt	LBB94_74
; %bb.43:                               ; %for.body322.lr.ph
	mov	x22, x19
	mov	w8, #0
	mov	w9, #4096
	udiv	w23, w9, w21
	ldur	w12, [x29, #-112]
	mul	w9, w23, w21
	str	x9, [sp, #24]                   ; 8-byte Folded Spill
	add	x9, sp, #1, lsl #12             ; =4096
	add	x9, x9, #96
	add	x9, x9, #16
	stp	x28, x9, [sp, #8]               ; 16-byte Folded Spill
	ldp	w10, w9, [x29, #-128]
	add	x28, sp, #32
	mov	x27, x10
	mov	x24, x12
LBB94_44:                               ; %for.body322
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB94_49 Depth 2
                                        ;       Child Loop BB94_53 Depth 3
                                        ;         Child Loop BB94_57 Depth 4
                                        ;           Child Loop BB94_64 Depth 5
                                        ;           Child Loop BB94_67 Depth 5
	cmp	w9, #1
	b.lt	LBB94_71
; %bb.45:                               ; %for.body333.preheader
                                        ;   in Loop: Header=BB94_44 Depth=1
	ldp	w11, w12, [x29, #-144]
	mov	x25, x11
	b	LBB94_49
LBB94_46:                               ; %for.inc394.loopexit.loopexit
                                        ;   in Loop: Header=BB94_49 Depth=2
	ldp	w10, w9, [x29, #-128]
LBB94_47:                               ; %for.inc394
                                        ;   in Loop: Header=BB94_49 Depth=2
	mov	x25, x11
LBB94_48:                               ; %for.inc394
                                        ;   in Loop: Header=BB94_49 Depth=2
	add	w27, w27, #1
	add	w13, w9, w10
	cmp	w27, w13
	b.ge	LBB94_70
LBB94_49:                               ; %for.body333
                                        ;   Parent Loop BB94_44 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB94_53 Depth 3
                                        ;         Child Loop BB94_57 Depth 4
                                        ;           Child Loop BB94_64 Depth 5
                                        ;           Child Loop BB94_67 Depth 5
	cmp	w12, #1
	b.lt	LBB94_48
; %bb.50:                               ; %for.body344.preheader
                                        ;   in Loop: Header=BB94_49 Depth=2
	ldur	w13, [x29, #-156]
	cmp	w13, #1
	b.ge	LBB94_53
	b	LBB94_47
LBB94_51:                               ; %for.inc389.loopexit
                                        ;   in Loop: Header=BB94_53 Depth=3
	ldp	w11, w12, [x29, #-144]
LBB94_52:                               ; %for.inc389
                                        ;   in Loop: Header=BB94_53 Depth=3
	add	w25, w25, #1
	add	w9, w11, w12
	cmp	w25, w9
	b.ge	LBB94_46
LBB94_53:                               ; %for.body344
                                        ;   Parent Loop BB94_44 Depth=1
                                        ;     Parent Loop BB94_49 Depth=2
                                        ; =>    This Loop Header: Depth=3
                                        ;         Child Loop BB94_57 Depth 4
                                        ;           Child Loop BB94_64 Depth 5
                                        ;           Child Loop BB94_67 Depth 5
	cmp	w13, #1
	b.lt	LBB94_52
; %bb.54:                               ; %for.body355.preheader
                                        ;   in Loop: Header=BB94_53 Depth=3
	ldur	w26, [x29, #-160]
	b	LBB94_57
LBB94_55:                               ;   in Loop: Header=BB94_57 Depth=4
	mov	w8, #0
LBB94_56:                               ; %for.inc384
                                        ;   in Loop: Header=BB94_57 Depth=4
	add	w26, w26, #1
	ldp	w9, w13, [x29, #-160]
	add	w9, w9, w13
	cmp	w26, w9
	b.ge	LBB94_51
LBB94_57:                               ; %for.body355
                                        ;   Parent Loop BB94_44 Depth=1
                                        ;     Parent Loop BB94_49 Depth=2
                                        ;       Parent Loop BB94_53 Depth=3
                                        ; =>      This Loop Header: Depth=4
                                        ;           Child Loop BB94_64 Depth 5
                                        ;           Child Loop BB94_67 Depth 5
	str	w26, [sp, #4192]
	str	w25, [sp, #4196]
	str	w27, [sp, #4200]
	str	w24, [sp, #4204]
	ldr	w9, [x20, #36]
	cmp	w9, #1
	b.lt	LBB94_62
; %bb.58:                               ; %for.body.lr.ph.i
                                        ;   in Loop: Header=BB94_57 Depth=4
	ldr	x10, [x20, #40]
	ldrsw	x11, [x10, #8]
	ldrsw	x12, [x10]
	sxtw	x13, w26
	sub	x12, x13, x12
	mul	x11, x12, x11
	cmp	w9, #1
	b.eq	LBB94_68
; %bb.59:                               ; %for.body.i.for.body.i_crit_edge.preheader
                                        ;   in Loop: Header=BB94_57 Depth=4
	ldrsw	x12, [x10, #24]
	ldrsw	x13, [x10, #16]
	sxtw	x14, w25
	sub	x13, x14, x13
	madd	x11, x13, x12, x11
	cmp	w9, #2
	b.eq	LBB94_68
; %bb.60:                               ; %for.body.i.for.body.i_crit_edge.for.body.i.for.body.i_crit_edge_crit_edge.lr.ph
                                        ;   in Loop: Header=BB94_57 Depth=4
	sub	x12, x9, #2
	cmp	x12, #5
	b.hs	LBB94_63
; %bb.61:                               ;   in Loop: Header=BB94_57 Depth=4
	mov	w12, #2
	b	LBB94_66
LBB94_62:                               ;   in Loop: Header=BB94_57 Depth=4
	mov	x11, #0
	b	LBB94_68
LBB94_63:                               ; %vector.ph138
                                        ;   in Loop: Header=BB94_57 Depth=4
	and	x13, x12, #0x3
	tst	x12, #0x3
	mov	w14, #4
	csel	x13, x14, x13, eq
	sub	x13, x12, x13
	add	x12, x13, #2
	movi.2d	v0, #0000000000000000
	movi.2d	v1, #0000000000000000
	mov.d	v1[0], x11
	add	x11, x10, #64
	ldr	x14, [sp, #16]                  ; 8-byte Folded Reload
LBB94_64:                               ; %vector.body136
                                        ;   Parent Loop BB94_44 Depth=1
                                        ;     Parent Loop BB94_49 Depth=2
                                        ;       Parent Loop BB94_53 Depth=3
                                        ;         Parent Loop BB94_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	sub	x15, x11, #32
	ld4.2s	{ v2, v3, v4, v5 }, [x15]
	ld4.2s	{ v16, v17, v18, v19 }, [x11]
	ldp	d6, d7, [x14, #-8]
	sub.2s	v6, v6, v2
	sub.2s	v7, v7, v16
	smlal.2d	v1, v6, v4
	smlal.2d	v0, v7, v18
	add	x11, x11, #64
	add	x14, x14, #16
	subs	x13, x13, #4
	b.ne	LBB94_64
; %bb.65:                               ; %middle.block134
                                        ;   in Loop: Header=BB94_57 Depth=4
	add.2d	v0, v0, v1
	addp.2d	d0, v0
	fmov	x11, d0
LBB94_66:                               ; %for.body.i.for.body.i_crit_edge.for.body.i.for.body.i_crit_edge_crit_edge.preheader
                                        ;   in Loop: Header=BB94_57 Depth=4
	sub	x9, x9, x12
	add	x10, x10, x12, lsl #4
	add	x10, x10, #8
	add	x13, sp, #1, lsl #12            ; =4096
	add	x13, x13, #96
	add	x12, x13, x12, lsl #2
LBB94_67:                               ; %for.body.i.for.body.i_crit_edge.for.body.i.for.body.i_crit_edge_crit_edge
                                        ;   Parent Loop BB94_44 Depth=1
                                        ;     Parent Loop BB94_49 Depth=2
                                        ;       Parent Loop BB94_53 Depth=3
                                        ;         Parent Loop BB94_57 Depth=4
                                        ; =>        This Inner Loop Header: Depth=5
	ldrsw	x13, [x12], #4
	ldrsw	x14, [x10]
	ldursw	x15, [x10, #-8]
	sub	x13, x13, x15
	madd	x11, x13, x14, x11
	add	x10, x10, #16
	subs	x9, x9, #1
	b.ne	LBB94_67
LBB94_68:                               ; %_ZNK15halide_buffer_t10address_ofEPKi.exit
                                        ;   in Loop: Header=BB94_57 Depth=4
	add	w19, w8, #1
	ldr	x9, [x20, #16]
	ldrb	w10, [x20, #33]
	add	x10, x10, #7
	lsr	x10, x10, #3
	madd	x1, x10, x11, x9
	mul	w8, w8, w21
	add	x0, x28, w8, sxtw
	mov	x2, x21
	bl	_memcpy
	mov	x8, x19
	cmp	w19, w23
	b.ne	LBB94_56
; %bb.69:                               ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit746
                                        ;   in Loop: Header=BB94_57 Depth=4
	add	x0, sp, #32
	ldr	x1, [sp, #24]                   ; 8-byte Folded Reload
	mov	w2, #1
	mov	x3, x22
	bl	_fwrite
	cbnz	x0, LBB94_55
	b	LBB94_77
LBB94_70:                               ; %for.inc399.loopexit
                                        ;   in Loop: Header=BB94_44 Depth=1
	ldp	w12, w11, [x29, #-112]
	mov	x27, x10
LBB94_71:                               ; %for.inc399
                                        ;   in Loop: Header=BB94_44 Depth=1
	add	w24, w24, #1
	add	w13, w11, w12
	cmp	w24, w13
	b.lt	LBB94_44
; %bb.72:                               ; %for.end403
	cmp	w8, #1
	mov	x19, x22
	ldr	x28, [sp, #8]                   ; 8-byte Folded Reload
	b.lt	LBB94_74
; %bb.73:                               ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit753
	mul	w8, w8, w21
	sxtw	x1, w8
	add	x0, sp, #32
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_146
LBB94_74:                               ; %if.end412
	str	xzr, [sp, #4192]
	cbz	w28, LBB94_76
; %bb.75:                               ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit760
	mov	w1, w28
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #96
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_95
LBB94_76:                               ; %if.end423
	mov	w21, #0
	b	LBB94_145
LBB94_77:                               ; %cleanup425.loopexit
	mov	w21, #-13
	mov	x19, x22
	b	LBB94_145
LBB94_78:
	mov	w21, #-4
	b	LBB94_145
LBB94_79:
	mov	x25, x9
LBB94_80:                               ; %while.end183
	add	x10, sp, #32
	add	x9, sp, #32
	cmn	x25, #1
	b.eq	LBB94_89
; %bb.81:                               ; %while.body187.preheader
	mov	x11, x25
	cmn	x25, #32
	b.hs	LBB94_87
; %bb.82:                               ; %vector.memcheck
	mvn	x12, x25
	add	x11, x24, x25
	add	x14, x11, x8
	add	x11, x24, x8
	sub	x11, x11, #1
	cmp	x9, x11
	b.hs	LBB94_84
; %bb.83:                               ; %vector.memcheck
	add	x13, x9, x12
	mov	x11, x25
	cmp	x14, x13
	b.lo	LBB94_87
LBB94_84:                               ; %vector.ph58
	and	x13, x12, #0xffffffffffffffe0
	add	x15, sp, #32
	add	x9, x15, x13
	add	x11, x25, x13
	add	x14, x14, #16
	add	x15, x15, #16
	mov	x16, x13
LBB94_85:                               ; %vector.body56
                                        ; =>This Inner Loop Header: Depth=1
	ldp	q0, q1, [x14, #-16]
	stp	q0, q1, [x15, #-16]
	add	x14, x14, #32
	add	x15, x15, #32
	subs	x16, x16, #32
	b.ne	LBB94_85
; %bb.86:                               ; %middle.block54
	cmp	x13, x12
	b.eq	LBB94_88
LBB94_87:                               ; %while.body187
                                        ; =>This Inner Loop Header: Depth=1
	add	x12, x24, x11
	add	x11, x11, #1
	ldrb	w12, [x12, x8]
	strb	w12, [x9], #1
	cmn	x11, #1
	b.ne	LBB94_87
LBB94_88:                               ; %while.cond191.preheader
	add	x8, sp, #32
	add	x8, x8, #256
	cmp	x9, x8
	b.hs	LBB94_105
LBB94_89:                               ; %iter.check
	add	x8, x10, #256
	sub	x10, x8, x9
	cmp	x10, #7
	b.hi	LBB94_93
; %bb.90:
	mov	x11, x9
	b	LBB94_104
LBB94_91:                               ; %select.unfold
	mov	w21, #-5
	b	LBB94_145
LBB94_92:
	mov	w21, #-12
	b	LBB94_145
LBB94_93:                               ; %vector.main.loop.iter.check
	cmp	x10, #32
	b.hs	LBB94_96
; %bb.94:
	mov	x12, #0
	b	LBB94_100
LBB94_95:
	mov	w21, #-16
	b	LBB94_145
LBB94_96:                               ; %vector.ph77
	and	x12, x10, #0xffffffffffffffe0
	add	x11, x9, #16
	movi.2d	v0, #0000000000000000
	mov	x13, x12
LBB94_97:                               ; %vector.body73
                                        ; =>This Inner Loop Header: Depth=1
	stp	q0, q0, [x11, #-16]
	add	x11, x11, #32
	subs	x13, x13, #32
	b.ne	LBB94_97
; %bb.98:                               ; %middle.block71
	cmp	x10, x12
	b.eq	LBB94_105
; %bb.99:                               ; %vec.epilog.iter.check
	tst	x10, #0x18
	b.eq	LBB94_103
LBB94_100:                              ; %vec.epilog.ph
	and	x13, x10, #0xfffffffffffffff8
	add	x11, x9, x13
	sub	x14, x12, x13
	add	x9, x9, x12
	movi.2d	v0, #0000000000000000
LBB94_101:                              ; %vec.epilog.vector.body
                                        ; =>This Inner Loop Header: Depth=1
	str	d0, [x9], #8
	adds	x14, x14, #8
	b.ne	LBB94_101
; %bb.102:                              ; %vec.epilog.middle.block
	cmp	x10, x13
	b.ne	LBB94_104
	b	LBB94_105
LBB94_103:
	add	x11, x9, x12
LBB94_104:                              ; %while.body194
                                        ; =>This Inner Loop Header: Depth=1
	strb	wzr, [x11], #1
	cmp	x11, x8
	b.ne	LBB94_104
LBB94_105:                              ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit686
	strb	wzr, [x26, #160]
Lloh300:
	adrp	x8, l___const.halide_debug_to_file.header@PAGE
Lloh301:
	add	x8, x8, l___const.halide_debug_to_file.header@PAGEOFF
	ldp	q0, q1, [x8, #64]
	str	q0, [sp, #4256]
	str	q1, [sp, #4272]
	ldp	q0, q1, [x8, #96]
	str	q0, [sp, #4288]
	str	q1, [sp, #4304]
	ldp	q0, q1, [x8]
	str	q0, [sp, #4192]
	str	q1, [sp, #4208]
	ldp	q0, q1, [x8, #32]
	str	q0, [sp, #4224]
	str	q1, [sp, #4240]
	mov	w24, #1
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #96
	mov	w1, #128
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	ldr	w8, [x20, #36]
	cmp	w8, #1
	b.lt	LBB94_129
; %bb.106:                              ; %for.body.lr.ph.i.i
	ldr	x9, [x20, #40]
	cmp	w8, #1
	b.ne	LBB94_108
; %bb.107:
	mov	x11, #0
	mov	x10, #0
	b	LBB94_117
LBB94_108:                              ; %vector.ph98
	mov	x10, #0
	mov	x12, #0
	and	x11, x8, #0xfffffffe
	add	x13, x9, #24
	mov	x14, x11
	b	LBB94_110
LBB94_109:                              ; %pred.load.continue108
                                        ;   in Loop: Header=BB94_110 Depth=1
	sub	w17, w17, #1
	sub	w0, w0, #1
	sxtw	x17, w17
	sxtw	x0, w0
	mul	x17, x17, x15
	mul	x0, x0, x16
	cmp	w15, #0
	csel	x15, x17, xzr, gt
	add	x10, x10, x15
	cmp	w16, #0
	csel	x15, x0, xzr, gt
	add	x12, x12, x15
	add	x13, x13, #32
	subs	x14, x14, #2
	b.eq	LBB94_114
LBB94_110:                              ; %vector.body96
                                        ; =>This Inner Loop Header: Depth=1
	ldur	w15, [x13, #-16]
                                        ; implicit-def: $w17
	cmp	w15, #1
	b.lt	LBB94_112
; %bb.111:                              ; %pred.load.if
                                        ;   in Loop: Header=BB94_110 Depth=1
	ldur	w17, [x13, #-20]
LBB94_112:                              ; %pred.load.continue
                                        ;   in Loop: Header=BB94_110 Depth=1
	ldr	w16, [x13]
                                        ; implicit-def: $w0
	cmp	w16, #1
	b.lt	LBB94_109
; %bb.113:                              ; %pred.load.if107
                                        ;   in Loop: Header=BB94_110 Depth=1
	ldur	w0, [x13, #-4]
	b	LBB94_109
LBB94_114:                              ; %middle.block94
	add	x10, x12, x10
	cmp	x11, x8
	b.ne	LBB94_117
LBB94_115:                              ; %for.body.i12.i.preheader
	cmp	w8, #2
	b.hs	LBB94_121
; %bb.116:
	mov	x11, #0
	mov	x12, #0
	b	LBB94_137
LBB94_117:                              ; %for.body.i.i.preheader
	sub	x12, x8, x11
	add	x11, x9, x11, lsl #4
	add	x11, x11, #8
	b	LBB94_119
LBB94_118:                              ; %if.end.i.i
                                        ;   in Loop: Header=BB94_119 Depth=1
	add	x11, x11, #16
	subs	x12, x12, #1
	b.eq	LBB94_115
LBB94_119:                              ; %for.body.i.i
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w13, [x11]
	cmp	w13, #1
	b.lt	LBB94_118
; %bb.120:                              ; %if.then.i.i
                                        ;   in Loop: Header=BB94_119 Depth=1
	ldursw	x14, [x11, #-4]
	sub	x14, x14, #1
	madd	x10, x14, x13, x10
	b	LBB94_118
LBB94_121:                              ; %vector.ph115
	mov	x12, #0
	mov	x13, #0
	and	x11, x8, #0xfffffffe
	add	x14, x9, #24
	mov	x15, x11
	b	LBB94_123
LBB94_122:                              ; %pred.load.continue128
                                        ;   in Loop: Header=BB94_123 Depth=1
	sub	w0, w0, #1
	sub	w1, w1, #1
	sxtw	x0, w0
	sxtw	x1, w1
	mul	x0, x0, x16
	mul	x1, x1, x17
	cmp	w16, #0
	csel	x16, x0, xzr, lt
	add	x12, x12, x16
	cmp	w17, #0
	csel	x16, x1, xzr, lt
	add	x13, x13, x16
	add	x14, x14, #32
	subs	x15, x15, #2
	b.eq	LBB94_127
LBB94_123:                              ; %vector.body113
                                        ; =>This Inner Loop Header: Depth=1
	ldursw	x16, [x14, #-16]
                                        ; implicit-def: $w0
	tbz	w16, #31, LBB94_125
; %bb.124:                              ; %pred.load.if125
                                        ;   in Loop: Header=BB94_123 Depth=1
	ldur	w0, [x14, #-20]
LBB94_125:                              ; %pred.load.continue126
                                        ;   in Loop: Header=BB94_123 Depth=1
	ldrsw	x17, [x14]
                                        ; implicit-def: $w1
	tbz	w17, #31, LBB94_122
; %bb.126:                              ; %pred.load.if127
                                        ;   in Loop: Header=BB94_123 Depth=1
	ldur	w1, [x14, #-4]
	b	LBB94_122
LBB94_127:                              ; %middle.block111
	add	x12, x13, x12
	cmp	x11, x8
	b.ne	LBB94_137
LBB94_128:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit.loopexit
	sub	x9, x10, x12
	add	x24, x9, #1
LBB94_129:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit
	ldrb	w9, [x20, #33]
	add	x9, x9, #7
	lsr	x9, x9, #3
	mul	x24, x9, x24
	neg	w9, w24
	and	w28, w9, #0x7
	add	x9, x24, x28
	lsr	x9, x9, #32
	cbnz	x9, LBB94_136
; %bb.130:                              ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit693
	mov	w9, #6
	sub	w9, w9, w25
	and	w23, w9, #0xfffffff8
	cmp	w8, #2
	mov	w9, #2
	csel	w8, w8, w9, gt
	mov	w9, #14
	lsl	w8, w8, #2
	add	w10, w8, #4
	and	w27, w10, #0xfffffff8
	add	w10, w23, w27
	add	w10, w10, w24
	add	w10, w10, w28
	add	w10, w10, #40
	str	w9, [sp, #4160]
	str	w10, [sp, #4164]
Lloh302:
	adrp	x9, lCPI94_1@PAGE
Lloh303:
	ldr	d0, [x9, lCPI94_1@PAGEOFF]
	str	d0, [sp, #4168]
Lloh304:
	adrp	x9, lCPI94_2@PAGE
Lloh305:
	ldr	d0, [x9, lCPI94_2@PAGEOFF]
Lloh306:
	adrp	x9, __ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE@GOTPAGE
Lloh307:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE@GOTPAGEOFF]
	sxtw	x22, w22
	ldrb	w9, [x9, x22]
	stur	d0, [x26, #20]
	str	w9, [sp, #4176]
	str	w8, [sp, #4188]
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #64
	mov	w1, #32
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_141
; %bb.131:                              ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit700
	ldur	w8, [x29, #-156]
	ldur	w9, [x29, #-140]
	str	w8, [sp, #4144]
	str	w9, [sp, #4148]
	ldur	w8, [x29, #-124]
	ldur	w9, [x29, #-108]
	str	w8, [sp, #4152]
	str	w9, [sp, #4156]
	sxtw	x1, w27
	mov	w26, #1
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #48
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_142
; %bb.132:                              ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit707
	mvn	w8, w25
	str	w26, [sp, #4136]
	str	w8, [sp, #4140]
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #40
	mov	w1, #8
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_143
; %bb.133:                              ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit714
	add	x0, sp, #32
	mov	x1, x23
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbz	x0, LBB94_144
; %bb.134:                              ; %_ZN6Halide7Runtime8Internal10ScopedFile5writeEPKvm.exit721
Lloh308:
	adrp	x8, __ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE@GOTPAGE
Lloh309:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE@GOTPAGEOFF]
	ldrb	w8, [x8, x22]
	str	w8, [sp, #4128]
	str	w24, [sp, #4132]
	add	x0, sp, #1, lsl #12             ; =4096
	add	x0, x0, #32
	mov	w1, #8
	mov	w2, #1
	mov	x3, x19
	bl	_fwrite
	cbnz	x0, LBB94_42
; %bb.135:
	mov	w21, #-11
	b	LBB94_145
LBB94_136:                              ; %cleanup278.thread
Lloh310:
	adrp	x1, l_.str.6.40@PAGE
Lloh311:
	add	x1, x1, l_.str.6.40@PAGEOFF
	mov	x0, x23
	bl	_halide_error
	mov	w21, #-6
	b	LBB94_145
LBB94_137:                              ; %for.body.i12.i.preheader2
	sub	x13, x8, x11
	add	x9, x9, x11, lsl #4
	add	x9, x9, #8
	b	LBB94_139
LBB94_138:                              ; %if.end.i22.i
                                        ;   in Loop: Header=BB94_139 Depth=1
	add	x9, x9, #16
	subs	x13, x13, #1
	b.eq	LBB94_128
LBB94_139:                              ; %for.body.i12.i
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x11, [x9]
	tbz	w11, #31, LBB94_138
; %bb.140:                              ; %if.then.i18.i
                                        ;   in Loop: Header=BB94_139 Depth=1
	ldursw	x14, [x9, #-4]
	sub	x14, x14, #1
	madd	x12, x14, x11, x12
	b	LBB94_138
LBB94_141:                              ; %cleanup278.thread789
	mov	w21, #-7
	b	LBB94_145
LBB94_142:                              ; %cleanup278.thread793
	mov	w21, #-8
	b	LBB94_145
LBB94_143:
	mov	w21, #-9
	b	LBB94_145
LBB94_144:
	mov	w21, #-10
LBB94_145:                              ; %cleanup433
	mov	x0, x19
	bl	_fclose
	b	LBB94_5
LBB94_146:
	mov	w21, #-14
	b	LBB94_145
	.loh AdrpAdd	Lloh280, Lloh281
	.loh AdrpAdd	Lloh282, Lloh283
	.loh AdrpAdd	Lloh284, Lloh285
	.loh AdrpAdd	Lloh286, Lloh287
	.loh AdrpAdd	Lloh288, Lloh289
	.loh AdrpLdr	Lloh296, Lloh297
	.loh AdrpLdrGot	Lloh294, Lloh295
	.loh AdrpLdr	Lloh292, Lloh293
	.loh AdrpLdr	Lloh290, Lloh291
	.loh AdrpAdd	Lloh298, Lloh299
	.loh AdrpAdd	Lloh300, Lloh301
	.loh AdrpLdrGot	Lloh306, Lloh307
	.loh AdrpAdrp	Lloh304, Lloh306
	.loh AdrpLdr	Lloh304, Lloh305
	.loh AdrpAdrp	Lloh302, Lloh304
	.loh AdrpLdr	Lloh302, Lloh303
	.loh AdrpLdrGot	Lloh308, Lloh309
	.loh AdrpAdd	Lloh310, Lloh311
                                        ; -- End function
	.globl	_halide_cache_cleanup           ; -- Begin function halide_cache_cleanup
	.weak_definition	_halide_cache_cleanup
	.p2align	2
_halide_cache_cleanup:                  ; @halide_cache_cleanup
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_halide_memoization_cache_cleanup
                                        ; -- End function
	.globl	_halide_memoization_cache_cleanup ; -- Begin function halide_memoization_cache_cleanup
	.weak_definition	_halide_memoization_cache_cleanup
	.p2align	2
_halide_memoization_cache_cleanup:      ; @halide_memoization_cache_cleanup
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
Lloh312:
	adrp	x20, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGE
Lloh313:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGEOFF]
	mov	x21, x20
	b	LBB96_2
LBB96_1:                                ; %while.end
                                        ;   in Loop: Header=BB96_2 Depth=1
	add	x21, x21, #8
	add	x8, x20, #2048
	cmp	x21, x8
	b.eq	LBB96_4
LBB96_2:                                ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB96_3 Depth 2
	ldr	x19, [x21]
	str	xzr, [x21]
	cbz	x19, LBB96_1
LBB96_3:                                ; %while.body
                                        ;   Parent Loop BB96_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x22, [x19]
	mov	x0, x19
	bl	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	mov	x0, #0
	mov	x1, x19
	bl	_halide_free
	mov	x19, x22
	cbnz	x22, LBB96_3
	b	LBB96_1
LBB96_4:                                ; %for.cond.cleanup
Lloh314:
	adrp	x8, __ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPAGE
Lloh315:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPAGEOFF]
Lloh316:
	str	xzr, [x8]
Lloh317:
	adrp	x8, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGE
Lloh318:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGEOFF]
Lloh319:
	str	xzr, [x8]
Lloh320:
	adrp	x8, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGE
Lloh321:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGEOFF]
Lloh322:
	str	xzr, [x8]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh312, Lloh313
	.loh AdrpLdrGotStr	Lloh320, Lloh321, Lloh322
	.loh AdrpLdrGotStr	Lloh317, Lloh318, Lloh319
	.loh AdrpLdrGotStr	Lloh314, Lloh315, Lloh316
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv ; -- Begin function _ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	.weak_definition	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	.p2align	2
__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv: ; @_ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x0
	ldr	w8, [x0, #56]
	cbz	w8, LBB97_3
; %bb.1:                                ; %for.body.lr.ph
	mov	x20, #0
	mov	w21, #16
LBB97_2:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x19, #72]
	add	x8, x8, x21
	sub	x1, x8, #16
	mov	x0, #0
	bl	_halide_device_free
	ldr	x8, [x19, #72]
	ldr	x0, [x8, x21]
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	mov	x1, x0
	mov	x0, #0
	bl	_halide_free
	add	x20, x20, #1
	ldr	w8, [x19, #56]
	add	x21, x21, #56
	cmp	x20, x8
	b.lo	LBB97_2
LBB97_3:                                ; %for.cond.cleanup
	ldr	x1, [x19, #24]
	mov	x0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_halide_free
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh ; -- Begin function _ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	.weak_definition	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	.p2align	2
__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh: ; @_ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	sub	x0, x0, #32
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx ; -- Begin function _ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
	.weak_definition	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
	.p2align	2
__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx: ; @_ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x19, x3
	mov	x20, x2
                                        ; kill: def $w1 killed $w1 def $x1
	mov	x21, x0
	tbnz	w1, #31, LBB99_3
LBB99_1:                                ; %land.rhs
                                        ; =>This Inner Loop Header: Depth=1
	add	x8, x21, w1, uxtw #3
	ldr	x8, [x8, #24]
	cmp	x8, #1
	b.ne	LBB99_4
; %bb.2:                                ; %while.body
                                        ;   in Loop: Header=BB99_1 Depth=1
	sub	w8, w1, #1
	cmp	w1, #0
	mov	x1, x8
	b.gt	LBB99_1
	b	LBB99_8
LBB99_3:                                ; %while.end
	cmn	w1, #1
	b.eq	LBB99_8
LBB99_4:                                ; %for.cond.preheader
	add	x23, x21, w1, sxtw #3
	ldr	x8, [x23, #24]!
	cbz	x8, LBB99_7
; %bb.5:                                ; %for.body.lr.ph
	mov	x24, #0
	sxtw	x8, w1
	sub	w22, w8, #1
	add	x8, x21, x8, lsl #3
	add	x25, x8, #152
	add	x26, x8, #280
LBB99_6:                                ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	mov	x0, x21
	mov	x1, x22
	mov	x2, x20
	mov	x3, x19
	bl	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
	ldr	x8, [x25]
	add	x20, x8, x20
	ldr	x8, [x26]
	add	x19, x8, x19
	add	x24, x24, #1
	ldr	x8, [x23]
	cmp	x24, x8
	b.lo	LBB99_6
LBB99_7:                                ; %if.end
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
LBB99_8:                                ; %if.then
	ldp	x8, x9, [x21]
	add	x1, x8, x20
	add	x0, x9, x19
	ldr	x2, [x21, #408]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_memcpy
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv ; -- Begin function _ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
	.weak_definition	__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
	.p2align	2
__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv: ; @_ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x8, x9, [x0]
	cmp	x8, x9
	b.ne	LBB100_2
; %bb.1:                                ; %if.end
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB100_2:                               ; %if.then
	ldr	x2, [x0, #16]
	mov	w1, #15
	mov	x3, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	__ZN6Halide7Runtime8Internal18copy_memory_helperERKNS1_11device_copyEixx
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b ; -- Begin function _ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
	.weak_definition	__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
	.p2align	2
__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b: ; @_ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	sub	sp, sp, #576
	add	x9, sp, #152
	cbz	w1, LBB101_3
; %bb.1:                                ; %cond.true
	ldr	x11, [x0, #16]
	add	x10, x9, #264
	str	x11, [sp, #152]
	cbnz	w3, LBB101_4
LBB101_2:                               ; %cond.false6
	ldr	x11, [x2]
	b	LBB101_5
LBB101_3:                               ; %cond.false
	ldr	x11, [x0]
	add	x10, x9, #264
	str	x11, [sp, #152]
	cbz	w3, LBB101_2
LBB101_4:                               ; %cond.true4
	ldr	x11, [x2, #16]
LBB101_5:                               ; %cond.end8
	str	x11, [sp, #160]
	ldrb	w13, [x0, #33]
	add	x11, x13, #7
	lsr	x11, x11, #3
	str	x11, [sp, #560]
	mov	w12, #1
	dup.2d	v0, x12
	stp	q0, q0, [sp, #176]
	movi.2d	v1, #0000000000000000
	stur	q1, [x9, #152]
	stur	q1, [x9, #168]
	stp	q0, q0, [sp, #208]
	stur	q1, [x9, #184]
	stp	q1, q1, [x10, #32]
	stur	q1, [x9, #200]
	stur	q0, [sp, #240]
	stur	q1, [x9, #216]
	stp	q1, q1, [x10, #64]
	add	x12, sp, #1
	stur	q0, [x12, #255]
	stur	q1, [x9, #232]
	add	x12, sp, #17
	stur	q0, [x12, #255]
	stur	q1, [x9, #248]
	stp	q1, q1, [x10, #96]
	stur	q0, [x9, #136]
	stp	q1, q1, [x10]
	str	q1, [x10, #128]
	ldr	w12, [x0, #36]
	cmp	w12, #1
	b.lt	LBB101_8
; %bb.6:                                ; %for.body19.lr.ph
	ldr	x15, [x0, #40]
	ldr	x14, [x2, #40]
	cmp	w12, #4
	b.hi	LBB101_9
; %bb.7:
	mov	x16, #0
	mov	x17, #0
	b	LBB101_12
LBB101_8:
	mov	x17, #0
	b	LBB101_14
LBB101_9:                               ; %vector.ph
	and	x16, x12, #0x3
	tst	x12, #0x3
	mov	w17, #4
	csel	x16, x17, x16, eq
	sub	x16, x12, x16
	add	x17, x14, #32
	add	x1, x15, #32
	movi.2d	v0, #0000000000000000
	mov	x3, x16
	movi.2d	v1, #0000000000000000
LBB101_10:                              ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
	sub	x4, x1, #32
	ld4.2s	{ v2, v3, v4, v5 }, [x4]
	ld4.2s	{ v16, v17, v18, v19 }, [x1]
	sub	x4, x17, #32
	ld4.2s	{ v20, v21, v22, v23 }, [x4]
	ld4.2s	{ v24, v25, v26, v27 }, [x17]
	sub.2s	v6, v20, v2
	sub.2s	v7, v24, v16
	smlal.2d	v0, v6, v4
	smlal.2d	v1, v7, v18
	add	x17, x17, #64
	add	x1, x1, #64
	subs	x3, x3, #4
	b.ne	LBB101_10
; %bb.11:                               ; %middle.block
	add.2d	v0, v1, v0
	addp.2d	d0, v0
	fmov	x17, d0
LBB101_12:                              ; %for.body19.preheader
	sub	x1, x12, x16
	lsl	x16, x16, #4
	add	x15, x15, x16
	add	x15, x15, #8
	add	x14, x14, x16
LBB101_13:                              ; %for.body19
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x16, [x14], #16
	ldrsw	x3, [x15]
	ldursw	x4, [x15, #-8]
	sub	x16, x16, x4
	madd	x17, x16, x3, x17
	add	x15, x15, #16
	subs	x1, x1, #1
	b.ne	LBB101_13
LBB101_14:                              ; %for.cond.cleanup18
	mul	x14, x17, x11
	str	x14, [sp, #168]
	ldr	w14, [x2, #36]
	cmp	w12, w14
	b.ne	LBB101_31
; %bb.15:                               ; %lor.lhs.false
	ldrb	w14, [x2, #33]
	add	w14, w14, #7
	cmp	w11, w14, lsr #3
	ccmp	w12, #17, #0, eq
	b.ge	LBB101_31
; %bb.16:                               ; %if.end
	cbz	w13, LBB101_31
; %bb.17:                               ; %for.cond54.preheader
	cmp	w12, #1
	b.lt	LBB101_37
; %bb.18:                               ; %for.body58.lr.ph
	mov	x13, #0
	ldr	x14, [x2, #40]
	ldr	x15, [x0, #40]
	add	x16, sp, #152
	add	x17, x16, #280
	add	x0, x16, #144
	b	LBB101_20
LBB101_19:                              ; %for.cond.cleanup94
                                        ;   in Loop: Header=BB101_20 Depth=1
	mul	x3, x3, x11
	add	x4, x14, x13, lsl #4
	ldrsw	x4, [x4, #4]
	add	x2, x16, x2, lsl #3
	str	x4, [x2, #24]
	str	x1, [x2, #280]
	str	x3, [x2, #152]
	add	x13, x13, #1
	add	x0, x0, #8
	cmp	x13, x12
	b.eq	LBB101_33
LBB101_20:                              ; %for.body58
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB101_23 Depth 2
                                        ;     Child Loop BB101_29 Depth 2
	lsl	x2, x13, #4
	add	x1, x14, x2
	ldrsw	x1, [x1, #8]
	mul	x1, x1, x11
	cbz	x13, LBB101_26
; %bb.21:                               ; %for.body81.lr.ph
                                        ;   in Loop: Header=BB101_20 Depth=1
	cbz	x1, LBB101_30
; %bb.22:                               ; %for.body81.preheader
                                        ;   in Loop: Header=BB101_20 Depth=1
	mov	x4, #0
LBB101_23:                              ; %for.body81
                                        ;   Parent Loop BB101_20 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x3, [x17, x4, lsl #3]
	cmp	x1, x3
	b.lo	LBB101_27
; %bb.24:                               ; %for.inc89
                                        ;   in Loop: Header=BB101_23 Depth=2
	add	x4, x4, #1
	cmp	x13, x4
	b.ne	LBB101_23
; %bb.25:                               ;   in Loop: Header=BB101_20 Depth=1
	mov	x4, x13
	add	x2, x15, x2
	ldrsw	x3, [x2, #8]
	mov	w2, w4
	cmp	x13, x2
	b.ls	LBB101_19
	b	LBB101_28
LBB101_26:                              ;   in Loop: Header=BB101_20 Depth=1
	mov	w4, #0
LBB101_27:                              ; %for.end91
                                        ;   in Loop: Header=BB101_20 Depth=1
	add	x2, x15, x2
	ldrsw	x3, [x2, #8]
	mov	w2, w4
	cmp	x13, x2
	b.ls	LBB101_19
LBB101_28:                              ; %for.body95.preheader
                                        ;   in Loop: Header=BB101_20 Depth=1
	sxtw	x4, w2
	mov	x5, x0
	mov	x6, x13
LBB101_29:                              ; %for.body95
                                        ;   Parent Loop BB101_20 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	sub	x6, x6, #1
	ldur	x7, [x5, #-128]
	stur	x7, [x5, #-120]
	ldr	x7, [x5, #128]
	str	x7, [x5, #136]
	ldr	x7, [x5]
	str	x7, [x5, #8]
	sub	x5, x5, #8
	cmp	x6, x4
	b.gt	LBB101_29
	b	LBB101_19
LBB101_30:                              ; %for.body81.us.preheader
                                        ;   in Loop: Header=BB101_20 Depth=1
	mov	x4, x13
	add	x2, x15, x2
	ldrsw	x3, [x2, #8]
	mov	w2, w4
	cmp	x13, x2
	b.ls	LBB101_19
	b	LBB101_28
LBB101_31:                              ; %if.then
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [x8, #384]
	stp	q0, q0, [x8, #352]
	stp	q0, q0, [x8, #320]
	stp	q0, q0, [x8, #288]
	stp	q0, q0, [x8, #256]
	stp	q0, q0, [x8, #224]
	stp	q0, q0, [x8, #192]
	stp	q0, q0, [x8, #160]
	stp	q0, q0, [x8, #128]
	stp	q0, q0, [x8, #96]
	stp	q0, q0, [x8, #64]
	stp	q0, q0, [x8, #32]
	stp	q0, q0, [x8]
LBB101_32:                              ; %while.end
	add	sp, sp, #576
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB101_33:                              ; %while.cond.preheader
	ldr	x7, [sp, #560]
	ldr	x11, [sp, #304]
	cmp	x7, x11
	b.ne	LBB101_37
; %bb.34:                               ; %land.rhs.lr.ph
	ldr	x11, [sp, #176]
	str	x11, [sp, #16]                  ; 8-byte Folded Spill
	ldp	x11, x16, [sp, #184]
	str	x11, [sp, #144]                 ; 8-byte Folded Spill
	ldp	x14, x11, [sp, #312]
	str	x11, [sp, #136]                 ; 8-byte Folded Spill
	ldr	x11, [sp, #440]
	str	x11, [sp, #128]                 ; 8-byte Folded Spill
	ldr	x11, [sp, #448]
	str	x11, [sp, #120]                 ; 8-byte Folded Spill
	ldp	x11, x17, [sp, #200]
	str	x11, [sp, #104]                 ; 8-byte Folded Spill
	ldr	x11, [sp, #328]
	str	x11, [sp, #112]                 ; 8-byte Folded Spill
	ldp	x11, x0, [sp, #336]
	str	x11, [sp, #96]                  ; 8-byte Folded Spill
	ldp	x11, x12, [sp, #456]
	str	x11, [sp, #88]                  ; 8-byte Folded Spill
	ldr	x11, [sp, #216]
	str	x11, [sp, #80]                  ; 8-byte Folded Spill
	ldp	x15, x4, [sp, #352]
	ldr	x11, [sp, #472]
	str	x11, [sp, #72]                  ; 8-byte Folded Spill
	ldr	x11, [sp, #480]
	str	x11, [sp, #64]                  ; 8-byte Folded Spill
	ldr	x11, [sp, #224]
	str	x11, [sp, #56]                  ; 8-byte Folded Spill
	ldr	x11, [sp, #232]
	str	x11, [sp, #48]                  ; 8-byte Folded Spill
	ldp	x1, x5, [sp, #368]
	ldr	x11, [sp, #488]
	str	x11, [sp, #40]                  ; 8-byte Folded Spill
	ldp	x11, x3, [sp, #496]
	str	x11, [sp, #32]                  ; 8-byte Folded Spill
	ldp	x11, x6, [sp, #240]
	str	x11, [sp, #24]                  ; 8-byte Folded Spill
	ldur	q1, [x9, #136]
	ldp	x19, x23, [sp, #384]
	ldr	q2, [x10]
	ldr	q3, [x10, #128]
	mov	w9, #1
	dup.2d	v0, x9
	ldr	x20, [sp, #512]
	ldp	x22, x24, [sp, #256]
	ldp	x25, x9, [sp, #400]
	ldr	x21, [sp, #520]
	ldr	x26, [sp, #528]
	ldp	x28, x30, [sp, #272]
	ldr	x11, [sp, #432]
	ldr	x27, [sp, #536]
LBB101_35:                              ; %land.rhs
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x10, [sp, #144]                 ; 8-byte Folded Reload
	str	x16, [sp, #144]                 ; 8-byte Folded Spill
	ldp	x16, x13, [sp, #120]            ; 16-byte Folded Reload
	str	x16, [sp, #128]                 ; 8-byte Folded Spill
	mov	x2, x4
	mov	x4, x1
	mov	x1, x0
	mov	x0, x12
	ldr	x12, [sp, #104]                 ; 8-byte Folded Reload
	ldr	x16, [sp, #88]                  ; 8-byte Folded Reload
	str	x16, [sp, #120]                 ; 8-byte Folded Spill
	mov	x16, x12
	str	x17, [sp, #104]                 ; 8-byte Folded Spill
	str	x0, [sp, #88]                   ; 8-byte Folded Spill
	ldp	x12, x17, [sp, #72]             ; 16-byte Folded Reload
	ldr	x0, [sp, #56]                   ; 8-byte Folded Reload
	str	x0, [sp, #80]                   ; 8-byte Folded Spill
	ldr	x0, [sp, #64]                   ; 8-byte Folded Reload
	str	x0, [sp, #72]                   ; 8-byte Folded Spill
	ldr	x0, [sp, #48]                   ; 8-byte Folded Reload
	str	x0, [sp, #56]                   ; 8-byte Folded Spill
	ldr	x0, [sp, #40]                   ; 8-byte Folded Reload
	str	x0, [sp, #64]                   ; 8-byte Folded Spill
	ldr	x0, [sp, #24]                   ; 8-byte Folded Reload
	str	x0, [sp, #48]                   ; 8-byte Folded Spill
	ldr	x0, [sp, #32]                   ; 8-byte Folded Reload
	stp	x3, x0, [sp, #32]               ; 16-byte Folded Spill
	str	x6, [sp, #24]                   ; 8-byte Folded Spill
	mov	x3, x20
	mov	x20, x21
	mov	x21, x26
	mov	x26, x27
	cmp	x7, x11
	mov	x7, x14
	ldr	x14, [sp, #136]                 ; 8-byte Folded Reload
	ldr	x27, [sp, #112]                 ; 8-byte Folded Reload
	str	x27, [sp, #136]                 ; 8-byte Folded Spill
	ldr	x27, [sp, #96]                  ; 8-byte Folded Reload
	str	x27, [sp, #112]                 ; 8-byte Folded Spill
	str	x1, [sp, #96]                   ; 8-byte Folded Spill
	b.ne	LBB101_37
; %bb.36:                               ; %while.body
                                        ;   in Loop: Header=BB101_35 Depth=1
	mov	x6, x22
	mov	x22, x24
	mov	x24, x28
	mov	x28, x30
	mov	x0, x15
	mov	x15, x2
	mov	x1, x5
	mov	x5, x19
	mov	x19, x23
	mov	x23, x25
	mov	x25, x9
	ldr	x9, [sp, #144]                  ; 8-byte Folded Reload
	stp	x10, x9, [sp, #176]
	str	x14, [sp, #8]                   ; 8-byte Folded Spill
	ldr	x9, [sp, #16]                   ; 8-byte Folded Reload
	mul	x14, x11, x9
	ldr	x9, [sp, #136]                  ; 8-byte Folded Reload
	str	x9, [sp, #320]
	ldr	x9, [sp, #120]                  ; 8-byte Folded Reload
	str	x9, [sp, #448]
	ldr	x9, [sp, #104]                  ; 8-byte Folded Reload
	str	x9, [sp, #200]
	ldr	x9, [sp, #96]                   ; 8-byte Folded Reload
	str	x9, [sp, #336]
	str	x12, [sp, #464]
	ldr	x9, [sp, #80]                   ; 8-byte Folded Reload
	str	x9, [sp, #216]
	str	x2, [sp, #352]
	ldr	x9, [sp, #64]                   ; 8-byte Folded Reload
	str	x9, [sp, #480]
	ldr	x9, [sp, #48]                   ; 8-byte Folded Reload
	str	x9, [sp, #232]
	str	x1, [sp, #368]
	ldr	x9, [sp, #32]                   ; 8-byte Folded Reload
	str	x9, [sp, #496]
	str	x6, [sp, #248]
	str	x19, [sp, #384]
	str	x20, [sp, #512]
	stp	x24, x30, [sp, #264]
	str	x25, [sp, #400]
	str	x26, [sp, #528]
	add	x9, sp, #25
	stur	q1, [x9, #255]
	add	x9, sp, #153
	stur	q2, [x9, #255]
	add	x9, sp, #281
	stur	q3, [x9, #255]
	mov	w9, #1
	str	x9, [sp, #296]
	movi.2d	v4, #0000000000000000
	mov.d	v4[0], v3[1]
	stp	xzr, x13, [sp, #424]
	fmov	x27, d3
	movi.2d	v5, #0000000000000000
	mov.d	v5[0], v2[1]
	str	x14, [sp, #560]
	str	xzr, [sp, #552]
	fmov	x9, d2
	mov.16b	v6, v0
	mov.d	v6[0], v1[1]
	fmov	x30, d1
	str	x10, [sp, #16]                  ; 8-byte Folded Spill
	mov	x11, x13
	mov.16b	v3, v4
	mov.16b	v2, v5
	mov.16b	v1, v6
	cmp	x14, x7
	ldr	x14, [sp, #8]                   ; 8-byte Folded Reload
	stp	x7, x14, [sp, #304]
	ldr	x10, [sp, #128]                 ; 8-byte Folded Reload
	str	x10, [sp, #440]
	str	x16, [sp, #192]
	ldr	x10, [sp, #112]                 ; 8-byte Folded Reload
	str	x10, [sp, #328]
	ldr	x10, [sp, #88]                  ; 8-byte Folded Reload
	str	x10, [sp, #456]
	str	x17, [sp, #208]
	str	x0, [sp, #344]
	ldr	x10, [sp, #72]                  ; 8-byte Folded Reload
	str	x10, [sp, #472]
	ldr	x10, [sp, #56]                  ; 8-byte Folded Reload
	str	x10, [sp, #224]
	str	x4, [sp, #360]
	ldr	x10, [sp, #40]                  ; 8-byte Folded Reload
	str	x10, [sp, #488]
	ldr	x10, [sp, #24]                  ; 8-byte Folded Reload
	str	x10, [sp, #240]
	str	x5, [sp, #376]
	str	x3, [sp, #504]
	str	x22, [sp, #256]
	str	x23, [sp, #392]
	str	x21, [sp, #520]
	b.eq	LBB101_35
LBB101_37:                              ; %while.end
	add	x1, sp, #152
	mov	x0, x8
	mov	w2, #416
	bl	_memcpy
	b	LBB101_32
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m ; -- Begin function _ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	.weak_definition	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	.p2align	2
__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m: ; @_ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	bl	_memcmp
	cmp	w0, #0
	cset	w0, eq
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t ; -- Begin function _ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	.weak_definition	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	.p2align	2
__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t: ; @_ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	w8, [x0, #36]
	cmp	w8, #1
	b.lt	LBB103_7
; %bb.1:                                ; %for.body.lr.ph
	ldr	x10, [x0, #40]
	add	x9, x1, #8
	add	x10, x10, #8
LBB103_2:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldur	w11, [x10, #-8]
	ldur	w12, [x9, #-8]
	cmp	w11, w12
	b.ne	LBB103_8
; %bb.3:                                ; %land.lhs.true.i.i
                                        ;   in Loop: Header=BB103_2 Depth=1
	ldur	w11, [x10, #-4]
	ldur	w12, [x9, #-4]
	cmp	w11, w12
	b.ne	LBB103_8
; %bb.4:                                ; %land.lhs.true5.i.i
                                        ;   in Loop: Header=BB103_2 Depth=1
	ldr	w11, [x10]
	ldr	w12, [x9]
	cmp	w11, w12
	b.ne	LBB103_8
; %bb.5:                                ; %_ZNK18halide_dimension_tneERKS_.exit
                                        ;   in Loop: Header=BB103_2 Depth=1
	ldr	w11, [x10, #4]
	ldr	w12, [x9, #4]
	cmp	w11, w12
	b.ne	LBB103_8
; %bb.6:                                ; %for.cond
                                        ;   in Loop: Header=BB103_2 Depth=1
	add	x9, x9, #16
	add	x10, x10, #16
	subs	x8, x8, #1
	b.ne	LBB103_2
LBB103_7:
	mov	w0, #1
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB103_8:
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by ; -- Begin function _ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
	.weak_definition	__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
	.p2align	2
__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by: ; @_ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x19, x7
	mov	x20, x6
	mov	x24, x5
	mov	x22, x4
	mov	x23, x1
	mov	x21, x0
	stp	xzr, xzr, [x0]
	str	xzr, [x0, #16]
	str	x2, [x0, #32]
	stp	w3, wzr, [x0, #48]
	ldrsw	x8, [x4, #36]
	stp	w5, w8, [x0, #56]
	mov	w25, #56
	add	w9, w5, #1
	mul	x8, x9, x8
	lsl	x8, x8, #4
	umaddl	x26, w5, w25, x8
	add	x1, x26, x2
	mov	x0, #0
	bl	_halide_malloc
	str	x0, [x21, #24]
	cbz	x0, LBB104_16
; %bb.1:                                ; %if.end
	umull	x8, w24, w25
	add	x8, x0, x8
	stp	x8, x0, [x21, #64]
	add	x8, x0, x26
	str	x8, [x21, #40]
	ldr	x9, [x21, #32]
	cbz	x9, LBB104_5
; %bb.2:                                ; %for.body.preheader
	ldrb	w9, [x23]
	strb	w9, [x8]
	ldr	x8, [x21, #32]
	cmp	x8, #2
	b.lo	LBB104_5
; %bb.3:                                ; %for.body.for.body_crit_edge.preheader
	mov	w8, #1
LBB104_4:                               ; %for.body.for.body_crit_edge
                                        ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x23, x8]
	ldr	x10, [x21, #40]
	strb	w9, [x10, x8]
	add	x8, x8, #1
	ldr	x9, [x21, #32]
	cmp	x8, x9
	b.lo	LBB104_4
LBB104_5:                               ; %for.cond23.preheader
	ldr	w8, [x21, #60]
	cmp	w8, #1
	b.lt	LBB104_8
; %bb.6:                                ; %for.body27.lr.ph
	mov	x8, #0
	mov	x9, #0
LBB104_7:                               ; %for.body27
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x10, [x22, #40]
	ldr	x11, [x21, #64]
	ldr	q0, [x10, x8]
	str	q0, [x11, x8]
	add	x9, x9, #1
	ldrsw	x10, [x21, #60]
	add	x8, x8, #16
	cmp	x9, x10
	b.lt	LBB104_7
LBB104_8:                               ; %for.cond36.preheader
	ldr	x8, [x29, #16]
	ldr	w9, [x21, #56]
	cbz	w9, LBB104_15
; %bb.9:                                ; %for.body40.preheader
	mov	x10, #0
	mov	w9, #56
	b	LBB104_11
LBB104_10:                              ; %for.cond36.loopexit
                                        ;   in Loop: Header=BB104_11 Depth=1
	ldr	w12, [x21, #56]
	mov	x10, x11
	cmp	x11, x12
	b.hs	LBB104_15
LBB104_11:                              ; %for.body40
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB104_14 Depth 2
	ldr	x11, [x20, x10, lsl #3]
	ldr	x12, [x21, #72]
	mul	x13, x10, x9
	add	x12, x12, x13
	ldp	q0, q1, [x11]
	ldr	q2, [x11, #32]
	ldr	x11, [x11, #48]
	str	x11, [x12, #48]
	stp	q1, q2, [x12, #16]
	str	q0, [x12]
	add	x11, x10, #1
	ldr	w14, [x21, #60]
	mul	w12, w14, w11
	ldp	x15, x16, [x21, #64]
	add	x12, x15, w12, uxtw #4
	add	x13, x16, x13
	str	x12, [x13, #40]
	cmp	w14, #1
	b.lt	LBB104_10
; %bb.12:                               ; %for.body59.preheader
                                        ;   in Loop: Header=BB104_11 Depth=1
	ldr	x13, [x20, x10, lsl #3]
	ldr	x13, [x13, #40]
	ldr	q0, [x13]
	str	q0, [x12]
	ldr	w12, [x21, #60]
	cmp	w12, #2
	b.lt	LBB104_10
; %bb.13:                               ; %for.body59.for.body59_crit_edge.preheader
                                        ;   in Loop: Header=BB104_11 Depth=1
	mov	w12, #16
	mov	w13, #1
LBB104_14:                              ; %for.body59.for.body59_crit_edge
                                        ;   Parent Loop BB104_11 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x14, [x21, #72]
	madd	x14, x10, x9, x14
	ldr	x14, [x14, #40]
	ldr	x15, [x20, x10, lsl #3]
	ldr	x15, [x15, #40]
	ldr	q0, [x15, x12]
	str	q0, [x14, x12]
	add	x13, x13, #1
	ldrsw	x14, [x21, #60]
	add	x12, x12, #16
	cmp	x13, x14
	b.lt	LBB104_14
	b	LBB104_10
LBB104_15:                              ; %for.cond.cleanup39
	strb	w19, [x21, #88]
	str	x8, [x21, #80]
LBB104_16:                              ; %cleanup
	cmp	x0, #0
	cset	w0, ne
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal8djb_hashEPKhm ; -- Begin function _ZN6Halide7Runtime8Internal8djb_hashEPKhm
	.weak_definition	__ZN6Halide7Runtime8Internal8djb_hashEPKhm
	.p2align	2
__ZN6Halide7Runtime8Internal8djb_hashEPKhm: ; @_ZN6Halide7Runtime8Internal8djb_hashEPKhm
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w8, #5381
	cbz	x1, LBB105_2
LBB105_1:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	add	w8, w8, w8, lsl #5
	ldrb	w9, [x0], #1
	add	w8, w8, w9
	subs	x1, x1, #1
	b.ne	LBB105_1
LBB105_2:                               ; %for.cond.cleanup
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal11prune_cacheEv ; -- Begin function _ZN6Halide7Runtime8Internal11prune_cacheEv
	.weak_definition	__ZN6Halide7Runtime8Internal11prune_cacheEv
	.p2align	2
__ZN6Halide7Runtime8Internal11prune_cacheEv: ; @_ZN6Halide7Runtime8Internal11prune_cacheEv
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
Lloh323:
	adrp	x21, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGE
Lloh324:
	ldr	x21, [x21, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGEOFF]
	ldr	x20, [x21]
Lloh325:
	adrp	x22, __ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPAGE
Lloh326:
	ldr	x22, [x22, __ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPAGEOFF]
	ldr	x8, [x22]
Lloh327:
	adrp	x23, __ZN6Halide7Runtime8Internal14max_cache_sizeE@GOTPAGE
Lloh328:
	ldr	x23, [x23, __ZN6Halide7Runtime8Internal14max_cache_sizeE@GOTPAGEOFF]
	ldr	x9, [x23]
	cmp	x8, x9
	ccmp	x20, #0, #4, gt
	b.ne	LBB106_2
LBB106_1:                               ; %while.end42
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
LBB106_2:                               ; %while.body.preheader
Lloh329:
	adrp	x24, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGE
Lloh330:
	ldr	x24, [x24, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGEOFF]
Lloh331:
	adrp	x25, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGE
Lloh332:
	ldr	x25, [x25, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGEOFF]
	mov	w26, #56
Lloh333:
	adrp	x19, l_.str.2.42@PAGE
Lloh334:
	add	x19, x19, l_.str.2.42@PAGEOFF
LBB106_3:                               ; %while.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB106_5 Depth 2
                                        ;     Child Loop BB106_20 Depth 2
                                        ;       Child Loop BB106_26 Depth 3
                                        ;       Child Loop BB106_35 Depth 3
                                        ;       Child Loop BB106_39 Depth 3
                                        ;       Child Loop BB106_46 Depth 3
	ldr	x27, [x20, #8]
	ldr	w10, [x20, #52]
	cbnz	w10, LBB106_50
; %bb.4:                                ; %if.then
                                        ;   in Loop: Header=BB106_3 Depth=1
	ldrb	w9, [x20, #48]
	ldr	x8, [x24, x9, lsl #3]
	cmp	x8, x20
	b.eq	LBB106_7
LBB106_5:                               ; %while.cond9
                                        ;   Parent Loop BB106_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x28, x8
	cbz	x8, LBB106_8
; %bb.6:                                ; %land.rhs11
                                        ;   in Loop: Header=BB106_5 Depth=2
	ldr	x8, [x28]
	cmp	x8, x20
	b.ne	LBB106_5
	b	LBB106_9
LBB106_7:                               ; %if.then6
                                        ;   in Loop: Header=BB106_3 Depth=1
	ldr	x8, [x20]
	str	x8, [x24, x9, lsl #3]
	ldr	x8, [x21]
	cmp	x8, x20
	b.ne	LBB106_11
	b	LBB106_10
LBB106_8:                               ; %if.then18
                                        ;   in Loop: Header=BB106_3 Depth=1
	mov	x0, #0
	mov	x1, x19
	bl	_halide_print
	bl	_abort
LBB106_9:                               ; %do.end
                                        ;   in Loop: Header=BB106_3 Depth=1
	ldr	x8, [x20]
	str	x8, [x28]
	ldr	x8, [x21]
	cmp	x8, x20
	b.ne	LBB106_11
LBB106_10:                              ; %if.then23
                                        ;   in Loop: Header=BB106_3 Depth=1
	str	x27, [x21]
LBB106_11:                              ; %if.end24
                                        ;   in Loop: Header=BB106_3 Depth=1
	cbz	x27, LBB106_13
; %bb.12:                               ; %if.then26
                                        ;   in Loop: Header=BB106_3 Depth=1
	ldr	x8, [x20, #16]
	str	x8, [x27, #16]
LBB106_13:                              ; %if.end28
                                        ;   in Loop: Header=BB106_3 Depth=1
	ldr	x9, [x25]
	ldr	x8, [x20, #16]
	cmp	x9, x20
	b.eq	LBB106_52
; %bb.14:                               ; %if.end32
                                        ;   in Loop: Header=BB106_3 Depth=1
	cbz	x8, LBB106_16
LBB106_15:                              ; %if.then35
                                        ;   in Loop: Header=BB106_3 Depth=1
	str	x27, [x20, #16]
LBB106_16:                              ; %if.end37
                                        ;   in Loop: Header=BB106_3 Depth=1
	ldr	w8, [x20, #56]
	cbz	w8, LBB106_49
; %bb.17:                               ; %for.body.lr.ph
                                        ;   in Loop: Header=BB106_3 Depth=1
	mov	x10, #0
	ldr	x9, [x22]
	ldr	x11, [x20, #72]
	b	LBB106_20
LBB106_18:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit.loopexit
                                        ;   in Loop: Header=BB106_20 Depth=2
	mvn	x12, x14
	add	x12, x16, x12
LBB106_19:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit
                                        ;   in Loop: Header=BB106_20 Depth=2
	madd	x13, x10, x26, x11
	ldrb	w13, [x13, #33]
	add	x13, x13, #7
	lsr	x13, x13, #3
	madd	x9, x13, x12, x9
	add	x10, x10, #1
	cmp	x10, x8
	b.eq	LBB106_48
LBB106_20:                              ; %for.body
                                        ;   Parent Loop BB106_3 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB106_26 Depth 3
                                        ;       Child Loop BB106_35 Depth 3
                                        ;       Child Loop BB106_39 Depth 3
                                        ;       Child Loop BB106_46 Depth 3
	madd	x12, x10, x26, x11
	ldr	w12, [x12, #36]
	cmp	w12, #1
	b.lt	LBB106_23
; %bb.21:                               ; %for.body.lr.ph.i.i
                                        ;   in Loop: Header=BB106_20 Depth=2
	madd	x13, x10, x26, x11
	ldr	x13, [x13, #40]
	cmp	w12, #1
	b.ne	LBB106_24
; %bb.22:                               ;   in Loop: Header=BB106_20 Depth=2
	mov	x15, #0
	mov	x14, #0
	b	LBB106_33
LBB106_23:                              ;   in Loop: Header=BB106_20 Depth=2
	mov	x12, #-1
	b	LBB106_19
LBB106_24:                              ; %vector.ph29
                                        ;   in Loop: Header=BB106_20 Depth=2
	mov	x14, #0
	mov	x16, #0
	and	x15, x12, #0xfffffffe
	add	x17, x13, #24
	mov	x0, x15
	b	LBB106_26
LBB106_25:                              ; %pred.load.continue42
                                        ;   in Loop: Header=BB106_26 Depth=3
	sub	w3, w3, #1
	sub	w4, w4, #1
	sxtw	x3, w3
	sxtw	x4, w4
	mul	x3, x3, x1
	mul	x4, x4, x2
	cmp	w1, #0
	csel	x1, x3, xzr, gt
	add	x14, x14, x1
	cmp	w2, #0
	csel	x1, x4, xzr, gt
	add	x16, x16, x1
	add	x17, x17, #32
	subs	x0, x0, #2
	b.eq	LBB106_30
LBB106_26:                              ; %vector.body27
                                        ;   Parent Loop BB106_3 Depth=1
                                        ;     Parent Loop BB106_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldur	w1, [x17, #-16]
                                        ; implicit-def: $w3
	cmp	w1, #1
	b.lt	LBB106_28
; %bb.27:                               ; %pred.load.if39
                                        ;   in Loop: Header=BB106_26 Depth=3
	ldur	w3, [x17, #-20]
LBB106_28:                              ; %pred.load.continue40
                                        ;   in Loop: Header=BB106_26 Depth=3
	ldr	w2, [x17]
                                        ; implicit-def: $w4
	cmp	w2, #1
	b.lt	LBB106_25
; %bb.29:                               ; %pred.load.if41
                                        ;   in Loop: Header=BB106_26 Depth=3
	ldur	w4, [x17, #-4]
	b	LBB106_25
LBB106_30:                              ; %middle.block25
                                        ;   in Loop: Header=BB106_20 Depth=2
	add	x14, x16, x14
	cmp	x15, x12
	b.ne	LBB106_33
LBB106_31:                              ; %for.body.i12.i.preheader
                                        ;   in Loop: Header=BB106_20 Depth=2
	cmp	w12, #2
	b.hs	LBB106_37
; %bb.32:                               ;   in Loop: Header=BB106_20 Depth=2
	mov	x15, #0
	mov	x16, #0
	b	LBB106_44
LBB106_33:                              ; %for.body.i.i.preheader
                                        ;   in Loop: Header=BB106_20 Depth=2
	sub	x16, x12, x15
	add	x15, x13, x15, lsl #4
	add	x15, x15, #8
	b	LBB106_35
LBB106_34:                              ; %if.end.i.i
                                        ;   in Loop: Header=BB106_35 Depth=3
	add	x15, x15, #16
	subs	x16, x16, #1
	b.eq	LBB106_31
LBB106_35:                              ; %for.body.i.i
                                        ;   Parent Loop BB106_3 Depth=1
                                        ;     Parent Loop BB106_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldr	w17, [x15]
	cmp	w17, #1
	b.lt	LBB106_34
; %bb.36:                               ; %if.then.i.i
                                        ;   in Loop: Header=BB106_35 Depth=3
	ldursw	x0, [x15, #-4]
	sub	x0, x0, #1
	madd	x14, x0, x17, x14
	b	LBB106_34
LBB106_37:                              ; %vector.ph
                                        ;   in Loop: Header=BB106_20 Depth=2
	mov	x16, #0
	mov	x17, #0
	and	x15, x12, #0xfffffffe
	add	x0, x13, #24
	mov	x1, x15
	b	LBB106_39
LBB106_38:                              ; %pred.load.continue23
                                        ;   in Loop: Header=BB106_39 Depth=3
	sub	w4, w4, #1
	sub	w5, w5, #1
	sxtw	x4, w4
	sxtw	x5, w5
	mul	x4, x4, x2
	mul	x5, x5, x3
	cmp	w2, #0
	csel	x2, x4, xzr, lt
	add	x16, x16, x2
	cmp	w3, #0
	csel	x2, x5, xzr, lt
	add	x17, x17, x2
	add	x0, x0, #32
	subs	x1, x1, #2
	b.eq	LBB106_43
LBB106_39:                              ; %vector.body
                                        ;   Parent Loop BB106_3 Depth=1
                                        ;     Parent Loop BB106_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldursw	x2, [x0, #-16]
                                        ; implicit-def: $w4
	tbnz	w2, #31, LBB106_41
; %bb.40:                               ; %pred.load.continue
                                        ;   in Loop: Header=BB106_39 Depth=3
	ldrsw	x3, [x0]
                                        ; implicit-def: $w5
	tbz	w3, #31, LBB106_38
	b	LBB106_42
LBB106_41:                              ; %pred.load.if
                                        ;   in Loop: Header=BB106_39 Depth=3
	ldur	w4, [x0, #-20]
	ldrsw	x3, [x0]
                                        ; implicit-def: $w5
	tbz	w3, #31, LBB106_38
LBB106_42:                              ; %pred.load.if22
                                        ;   in Loop: Header=BB106_39 Depth=3
	ldur	w5, [x0, #-4]
	b	LBB106_38
LBB106_43:                              ; %middle.block
                                        ;   in Loop: Header=BB106_20 Depth=2
	add	x16, x17, x16
	cmp	x15, x12
	b.eq	LBB106_18
LBB106_44:                              ; %for.body.i12.i.preheader1
                                        ;   in Loop: Header=BB106_20 Depth=2
	sub	x12, x12, x15
	add	x13, x13, x15, lsl #4
	add	x13, x13, #8
	b	LBB106_46
LBB106_45:                              ; %if.end.i22.i
                                        ;   in Loop: Header=BB106_46 Depth=3
	add	x13, x13, #16
	subs	x12, x12, #1
	b.eq	LBB106_18
LBB106_46:                              ; %for.body.i12.i
                                        ;   Parent Loop BB106_3 Depth=1
                                        ;     Parent Loop BB106_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	ldrsw	x15, [x13]
	tbz	w15, #31, LBB106_45
; %bb.47:                               ; %if.then.i18.i
                                        ;   in Loop: Header=BB106_46 Depth=3
	ldursw	x17, [x13, #-4]
	sub	x17, x17, #1
	madd	x16, x17, x15, x16
	b	LBB106_45
LBB106_48:                              ; %for.cond.for.cond.cleanup_crit_edge
                                        ;   in Loop: Header=BB106_3 Depth=1
	str	x9, [x22]
LBB106_49:                              ; %for.cond.cleanup
                                        ;   in Loop: Header=BB106_3 Depth=1
	mov	x0, x20
	bl	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	mov	x0, #0
	mov	x1, x20
	bl	_halide_free
	ldr	x8, [x22]
	ldr	x9, [x23]
LBB106_50:                              ; %if.end41
                                        ;   in Loop: Header=BB106_3 Depth=1
	cmp	x8, x9
	b.le	LBB106_1
; %bb.51:                               ; %if.end41
                                        ;   in Loop: Header=BB106_3 Depth=1
	mov	x20, x27
	cbnz	x27, LBB106_3
	b	LBB106_1
LBB106_52:                              ; %if.then30
                                        ;   in Loop: Header=BB106_3 Depth=1
	str	x8, [x25]
	cbnz	x8, LBB106_15
	b	LBB106_16
	.loh AdrpLdrGot	Lloh327, Lloh328
	.loh AdrpLdrGot	Lloh325, Lloh326
	.loh AdrpLdrGot	Lloh323, Lloh324
	.loh AdrpAdd	Lloh333, Lloh334
	.loh AdrpLdrGot	Lloh331, Lloh332
	.loh AdrpLdrGot	Lloh329, Lloh330
                                        ; -- End function
	.globl	_halide_memoization_cache_set_size ; -- Begin function halide_memoization_cache_set_size
	.weak_definition	_halide_memoization_cache_set_size
	.p2align	2
_halide_memoization_cache_set_size:     ; @halide_memoization_cache_set_size
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	cmp	x0, #0
	mov	w8, #1048576
	csel	x20, x8, x0, eq
Lloh335:
	adrp	x19, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh336:
	ldr	x19, [x19, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	mov	x0, x19
	bl	_halide_mutex_lock
Lloh337:
	adrp	x8, __ZN6Halide7Runtime8Internal14max_cache_sizeE@GOTPAGE
Lloh338:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal14max_cache_sizeE@GOTPAGEOFF]
Lloh339:
	str	x20, [x8]
	bl	__ZN6Halide7Runtime8Internal11prune_cacheEv
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_mutex_unlock
	.loh AdrpLdrGotStr	Lloh337, Lloh338, Lloh339
	.loh AdrpLdrGot	Lloh335, Lloh336
                                        ; -- End function
	.globl	_halide_memoization_cache_lookup ; -- Begin function halide_memoization_cache_lookup
	.weak_definition	_halide_memoization_cache_lookup
	.p2align	2
_halide_memoization_cache_lookup:       ; @halide_memoization_cache_lookup
; %bb.0:                                ; %entry
	sub	sp, sp, #112
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	mov	x19, x5
	mov	x28, x4
	mov	x23, x3
                                        ; kill: def $w2 killed $w2 def $x2
	mov	x24, x1
	mov	x20, x0
	sxtw	x25, w2
	mov	x0, x1
	mov	x1, x25
	bl	__ZN6Halide7Runtime8Internal8djb_hashEPKhm
	mov	x21, x0
	and	w22, w0, #0xff
Lloh340:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh341:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	bl	_halide_mutex_lock
Lloh342:
	adrp	x8, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGE
Lloh343:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGEOFF]
	ldr	x26, [x8, w22, uxtw #3]
	cbz	x26, LBB108_23
; %bb.1:                                ; %while.body.lr.ph
	cmp	w28, #0
	b.le	LBB108_13
; %bb.2:                                ; %while.body.us.preheader
	sxtw	x27, w28
	b	LBB108_4
LBB108_3:                               ; %if.end73.us
                                        ;   in Loop: Header=BB108_4 Depth=1
	ldr	x26, [x26]
	cbz	x26, LBB108_23
LBB108_4:                               ; %while.body.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB108_10 Depth 2
	ldr	w8, [x26, #48]
	cmp	w8, w21
	b.ne	LBB108_3
; %bb.5:                                ; %land.lhs.true.us
                                        ;   in Loop: Header=BB108_4 Depth=1
	ldr	x8, [x26, #32]
	cmp	x8, x25
	b.ne	LBB108_3
; %bb.6:                                ; %land.lhs.true7.us
                                        ;   in Loop: Header=BB108_4 Depth=1
	ldr	x0, [x26, #40]
	mov	x1, x24
	mov	x2, x25
	bl	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	cbz	w0, LBB108_3
; %bb.7:                                ; %land.lhs.true10.us
                                        ;   in Loop: Header=BB108_4 Depth=1
	ldr	x1, [x26, #64]
	mov	x0, x23
	bl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	cbz	w0, LBB108_3
; %bb.8:                                ; %land.lhs.true13.us
                                        ;   in Loop: Header=BB108_4 Depth=1
	ldr	w8, [x26, #56]
	cmp	w8, w28
	b.ne	LBB108_3
; %bb.9:                                ; %for.cond.preheader.us
                                        ;   in Loop: Header=BB108_4 Depth=1
	str	x28, [sp, #8]                   ; 8-byte Folded Spill
	mov	x28, #0
	mov	w22, #40
LBB108_10:                              ; %for.body.us
                                        ;   Parent Loop BB108_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x0, [x19, x28, lsl #3]
	ldr	x8, [x26, #72]
	ldr	x1, [x8, x22]
	bl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	add	x28, x28, #1
	add	x22, x22, #56
	cmp	w0, #0
	ccmp	x28, x27, #0, ne
	b.lt	LBB108_10
; %bb.11:                               ; %for.cond.cleanup.us
                                        ;   in Loop: Header=BB108_4 Depth=1
	ldr	x28, [sp, #8]                   ; 8-byte Folded Reload
	tbz	w0, #0, LBB108_3
	b	LBB108_18
LBB108_12:                              ; %if.end73
                                        ;   in Loop: Header=BB108_13 Depth=1
	ldr	x26, [x26]
	cbz	x26, LBB108_23
LBB108_13:                              ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [x26, #48]
	cmp	w8, w21
	b.ne	LBB108_12
; %bb.14:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB108_13 Depth=1
	ldr	x8, [x26, #32]
	cmp	x8, x25
	b.ne	LBB108_12
; %bb.15:                               ; %land.lhs.true7
                                        ;   in Loop: Header=BB108_13 Depth=1
	ldr	x0, [x26, #40]
	mov	x1, x24
	mov	x2, x25
	bl	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	cbz	w0, LBB108_12
; %bb.16:                               ; %land.lhs.true10
                                        ;   in Loop: Header=BB108_13 Depth=1
	ldr	x1, [x26, #64]
	mov	x0, x23
	bl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	cbz	w0, LBB108_12
; %bb.17:                               ; %land.lhs.true13
                                        ;   in Loop: Header=BB108_13 Depth=1
	ldr	w8, [x26, #56]
	cmp	w8, w28
	b.ne	LBB108_12
LBB108_18:                              ; %if.then23
Lloh344:
	adrp	x21, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGE
Lloh345:
	ldr	x21, [x21, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGEOFF]
	ldr	x8, [x21]
	cmp	x26, x8
	b.eq	LBB108_69
; %bb.19:                               ; %do.body
	ldr	x8, [x26, #8]
	cbnz	x8, LBB108_21
; %bb.20:                               ; %if.then27
Lloh346:
	adrp	x1, l_.str.3.43@PAGE
Lloh347:
	add	x1, x1, l_.str.3.43@PAGEOFF
	mov	x0, x20
	bl	_halide_print
	bl	_abort
LBB108_21:                              ; %do.end
	ldr	x8, [x26, #16]
	cbz	x8, LBB108_61
; %bb.22:                               ; %if.then29
	ldr	x9, [x26, #8]
	str	x9, [x8, #8]
	ldr	x8, [x26, #8]
	b	LBB108_64
LBB108_23:                              ; %for.cond75.preheader
	cmp	w28, #1
	b.lt	LBB108_56
; %bb.24:                               ; %for.body78.preheader
	mov	x23, #0
	mov	w22, w28
	orr	x24, xzr, #0x20
LBB108_25:                              ; %for.body78
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB108_31 Depth 2
                                        ;     Child Loop BB108_40 Depth 2
                                        ;     Child Loop BB108_45 Depth 2
                                        ;     Child Loop BB108_54 Depth 2
	ldr	x25, [x19, x23, lsl #3]
	ldr	w8, [x25, #36]
	cmp	w8, #1
	b.lt	LBB108_28
; %bb.26:                               ; %for.body.lr.ph.i.i
                                        ;   in Loop: Header=BB108_25 Depth=1
	ldr	x9, [x25, #40]
	cmp	w8, #1
	b.ne	LBB108_29
; %bb.27:                               ;   in Loop: Header=BB108_25 Depth=1
	mov	x11, #0
	mov	x10, #0
	b	LBB108_38
LBB108_28:                              ;   in Loop: Header=BB108_25 Depth=1
	mov	w8, #1
	b	LBB108_50
LBB108_29:                              ; %vector.ph39
                                        ;   in Loop: Header=BB108_25 Depth=1
	mov	x10, #0
	mov	x12, #0
	and	x11, x8, #0xfffffffe
	add	x13, x9, #24
	mov	x14, x11
	b	LBB108_31
LBB108_30:                              ; %pred.load.continue52
                                        ;   in Loop: Header=BB108_31 Depth=2
	sub	w17, w17, #1
	sub	w0, w0, #1
	sxtw	x17, w17
	sxtw	x0, w0
	mul	x17, x17, x15
	mul	x0, x0, x16
	cmp	w15, #0
	csel	x15, x17, xzr, gt
	add	x10, x10, x15
	cmp	w16, #0
	csel	x15, x0, xzr, gt
	add	x12, x12, x15
	add	x13, x13, #32
	subs	x14, x14, #2
	b.eq	LBB108_35
LBB108_31:                              ; %vector.body37
                                        ;   Parent Loop BB108_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldur	w15, [x13, #-16]
                                        ; implicit-def: $w17
	cmp	w15, #1
	b.lt	LBB108_33
; %bb.32:                               ; %pred.load.if49
                                        ;   in Loop: Header=BB108_31 Depth=2
	ldur	w17, [x13, #-20]
LBB108_33:                              ; %pred.load.continue50
                                        ;   in Loop: Header=BB108_31 Depth=2
	ldr	w16, [x13]
                                        ; implicit-def: $w0
	cmp	w16, #1
	b.lt	LBB108_30
; %bb.34:                               ; %pred.load.if51
                                        ;   in Loop: Header=BB108_31 Depth=2
	ldur	w0, [x13, #-4]
	b	LBB108_30
LBB108_35:                              ; %middle.block35
                                        ;   in Loop: Header=BB108_25 Depth=1
	add	x10, x12, x10
	cmp	x11, x8
	b.ne	LBB108_38
LBB108_36:                              ; %for.body.i12.i.preheader
                                        ;   in Loop: Header=BB108_25 Depth=1
	cmp	w8, #2
	b.hs	LBB108_42
; %bb.37:                               ;   in Loop: Header=BB108_25 Depth=1
	mov	x11, #0
	mov	x12, #0
	b	LBB108_52
LBB108_38:                              ; %for.body.i.i.preheader
                                        ;   in Loop: Header=BB108_25 Depth=1
	sub	x12, x8, x11
	add	x11, x9, x11, lsl #4
	add	x11, x11, #8
	b	LBB108_40
LBB108_39:                              ; %if.end.i.i
                                        ;   in Loop: Header=BB108_40 Depth=2
	add	x11, x11, #16
	subs	x12, x12, #1
	b.eq	LBB108_36
LBB108_40:                              ; %for.body.i.i
                                        ;   Parent Loop BB108_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w13, [x11]
	cmp	w13, #1
	b.lt	LBB108_39
; %bb.41:                               ; %if.then.i.i
                                        ;   in Loop: Header=BB108_40 Depth=2
	ldursw	x14, [x11, #-4]
	sub	x14, x14, #1
	madd	x10, x14, x13, x10
	b	LBB108_39
LBB108_42:                              ; %vector.ph
                                        ;   in Loop: Header=BB108_25 Depth=1
	mov	x12, #0
	mov	x13, #0
	and	x11, x8, #0xfffffffe
	add	x14, x9, #24
	mov	x15, x11
	b	LBB108_45
LBB108_43:                              ; %pred.load.if
                                        ;   in Loop: Header=BB108_45 Depth=2
	ldur	w0, [x14, #-20]
	ldrsw	x17, [x14]
                                        ; implicit-def: $w1
	tbnz	w17, #31, LBB108_47
LBB108_44:                              ; %pred.load.continue33
                                        ;   in Loop: Header=BB108_45 Depth=2
	sub	w0, w0, #1
	sub	w1, w1, #1
	sxtw	x0, w0
	sxtw	x1, w1
	mul	x0, x0, x16
	mul	x1, x1, x17
	cmp	w16, #0
	csel	x16, x0, xzr, lt
	add	x12, x12, x16
	cmp	w17, #0
	csel	x16, x1, xzr, lt
	add	x13, x13, x16
	add	x14, x14, #32
	subs	x15, x15, #2
	b.eq	LBB108_48
LBB108_45:                              ; %vector.body
                                        ;   Parent Loop BB108_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldursw	x16, [x14, #-16]
                                        ; implicit-def: $w0
	tbnz	w16, #31, LBB108_43
; %bb.46:                               ; %pred.load.continue
                                        ;   in Loop: Header=BB108_45 Depth=2
	ldrsw	x17, [x14]
                                        ; implicit-def: $w1
	tbz	w17, #31, LBB108_44
LBB108_47:                              ; %pred.load.if32
                                        ;   in Loop: Header=BB108_45 Depth=2
	ldur	w1, [x14, #-4]
	b	LBB108_44
LBB108_48:                              ; %middle.block
                                        ;   in Loop: Header=BB108_25 Depth=1
	add	x12, x13, x12
	cmp	x11, x8
	b.ne	LBB108_52
LBB108_49:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit.loopexit
                                        ;   in Loop: Header=BB108_25 Depth=1
	sub	x8, x10, x12
	add	x8, x8, #1
LBB108_50:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit
                                        ;   in Loop: Header=BB108_25 Depth=1
	ldrb	w9, [x25, #33]
	add	x9, x9, #7
	lsr	x9, x9, #3
	madd	x1, x9, x8, x24
	mov	x0, x20
	bl	_halide_malloc
	str	x0, [x25, #16]
	cbz	x0, LBB108_57
; %bb.51:                               ; %for.inc114
                                        ;   in Loop: Header=BB108_25 Depth=1
	add	x0, x0, #32
	str	x0, [x25, #16]
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	str	w21, [x0, #8]
	str	xzr, [x0]
	add	x23, x23, #1
	cmp	x23, x22
	b.ne	LBB108_25
	b	LBB108_56
LBB108_52:                              ; %for.body.i12.i.preheader1
                                        ;   in Loop: Header=BB108_25 Depth=1
	sub	x8, x8, x11
	add	x9, x9, x11, lsl #4
	add	x9, x9, #8
	b	LBB108_54
LBB108_53:                              ; %if.end.i22.i
                                        ;   in Loop: Header=BB108_54 Depth=2
	add	x9, x9, #16
	subs	x8, x8, #1
	b.eq	LBB108_49
LBB108_54:                              ; %for.body.i12.i
                                        ;   Parent Loop BB108_25 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrsw	x11, [x9]
	tbz	w11, #31, LBB108_53
; %bb.55:                               ; %if.then.i18.i
                                        ;   in Loop: Header=BB108_54 Depth=2
	ldursw	x13, [x9, #-4]
	sub	x13, x13, #1
	madd	x12, x13, x11, x12
	b	LBB108_53
LBB108_56:
	mov	w19, #1
	b	LBB108_60
LBB108_57:                              ; %for.cond89.preheader
	cbz	x23, LBB108_59
LBB108_58:                              ; %for.body92
                                        ; =>This Inner Loop Header: Depth=1
	sub	w8, w23, #1
	lsl	x21, x8, #3
	ldr	x8, [x19, x21]
	ldr	x0, [x8, #16]
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	mov	x1, x0
	mov	x0, x20
	bl	_halide_free
	ldr	x8, [x19, x21]
	str	xzr, [x8, #16]
	subs	x23, x23, #1
	b.gt	LBB108_58
LBB108_59:
	mov	w19, #-1
LBB108_60:                              ; %cleanup119
Lloh348:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh349:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB108_61:                              ; %do.body33
Lloh350:
	adrp	x22, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGE
Lloh351:
	ldr	x22, [x22, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGEOFF]
	ldr	x8, [x22]
	cmp	x8, x26
	b.eq	LBB108_63
; %bb.62:                               ; %if.then35
Lloh352:
	adrp	x1, l_.str.4.44@PAGE
Lloh353:
	add	x1, x1, l_.str.4.44@PAGEOFF
	mov	x0, x20
	bl	_halide_print
	bl	_abort
LBB108_63:                              ; %do.end38
	ldr	x8, [x26, #8]
	str	x8, [x22]
LBB108_64:                              ; %do.body41
	cbnz	x8, LBB108_66
; %bb.65:                               ; %if.then44
Lloh354:
	adrp	x1, l_.str.5.45@PAGE
Lloh355:
	add	x1, x1, l_.str.5.45@PAGEOFF
	mov	x0, x20
	bl	_halide_print
	bl	_abort
	ldr	x8, [x26, #8]
LBB108_66:                              ; %do.end47
	ldr	x9, [x26, #16]
	str	x9, [x8, #16]
	ldr	x8, [x21]
	stp	xzr, x8, [x26, #8]
	cbz	x8, LBB108_68
; %bb.67:                               ; %if.then54
	str	x26, [x8, #8]
LBB108_68:                              ; %if.end56
	str	x26, [x21]
LBB108_69:                              ; %if.end57
	cmp	w28, #1
	b.lt	LBB108_72
; %bb.70:                               ; %for.body62.lr.ph
	mov	x8, #0
	mov	w9, #56
	umull	x9, w28, w9
LBB108_71:                              ; %for.body62
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x10, [x19], #8
	ldr	x11, [x26, #72]
	add	x11, x11, x8
	ldp	q0, q1, [x11]
	ldr	q2, [x11, #32]
	ldr	x11, [x11, #48]
	str	x11, [x10, #48]
	stp	q1, q2, [x10, #16]
	str	q0, [x10]
	add	x8, x8, #56
	cmp	x9, x8
	b.ne	LBB108_71
LBB108_72:                              ; %cleanup119.loopexit223
	mov	w19, #0
	ldr	w8, [x26, #52]
	add	w8, w8, w28
	str	w8, [x26, #52]
	b	LBB108_60
	.loh AdrpLdrGot	Lloh342, Lloh343
	.loh AdrpLdrGot	Lloh340, Lloh341
	.loh AdrpLdrGot	Lloh344, Lloh345
	.loh AdrpAdd	Lloh346, Lloh347
	.loh AdrpLdrGot	Lloh348, Lloh349
	.loh AdrpLdrGot	Lloh350, Lloh351
	.loh AdrpAdd	Lloh352, Lloh353
	.loh AdrpAdd	Lloh354, Lloh355
                                        ; -- End function
	.globl	_halide_memoization_cache_store ; -- Begin function halide_memoization_cache_store
	.weak_definition	_halide_memoization_cache_store
	.p2align	2
_halide_memoization_cache_store:        ; @halide_memoization_cache_store
; %bb.0:                                ; %entry
	sub	sp, sp, #160
	stp	x28, x27, [sp, #64]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #80]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #112]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #128]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #144]            ; 16-byte Folded Spill
	add	x29, sp, #144
	str	x7, [sp, #32]                   ; 8-byte Folded Spill
	str	w6, [sp, #44]                   ; 4-byte Folded Spill
	mov	x19, x5
	mov	x20, x4
	mov	x21, x3
	stp	x2, x1, [sp, #48]               ; 16-byte Folded Spill
	mov	x23, x0
	ldr	x8, [x5]
	ldr	x0, [x8, #16]
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	ldr	w27, [x0, #8]
	and	x25, x27, #0xff
Lloh356:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh357:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	bl	_halide_mutex_lock
Lloh358:
	adrp	x8, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGE
Lloh359:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGEOFF]
	ldr	x24, [x8, x25, lsl #3]
	cbz	x24, LBB109_22
; %bb.1:                                ; %while.body.lr.ph
	ldr	x8, [sp, #48]                   ; 8-byte Folded Reload
	sxtw	x28, w8
	cmp	w20, #0
	b.le	LBB109_17
; %bb.2:                                ; %while.body.us.preheader
	sxtw	x26, w20
	b	LBB109_4
LBB109_3:                               ; %if.end59.us
                                        ;   in Loop: Header=BB109_4 Depth=1
	ldr	x24, [x24]
	cbz	x24, LBB109_22
LBB109_4:                               ; %while.body.us
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB109_10 Depth 2
	ldr	w8, [x24, #48]
	cmp	w8, w27
	b.ne	LBB109_3
; %bb.5:                                ; %land.lhs.true.us
                                        ;   in Loop: Header=BB109_4 Depth=1
	ldr	x8, [x24, #32]
	cmp	x8, x28
	b.ne	LBB109_3
; %bb.6:                                ; %land.lhs.true12.us
                                        ;   in Loop: Header=BB109_4 Depth=1
	ldr	x0, [x24, #40]
	ldr	x1, [sp, #56]                   ; 8-byte Folded Reload
	mov	x2, x28
	bl	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	cbz	w0, LBB109_3
; %bb.7:                                ; %land.lhs.true15.us
                                        ;   in Loop: Header=BB109_4 Depth=1
	ldr	x1, [x24, #64]
	mov	x0, x21
	bl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	cbz	w0, LBB109_3
; %bb.8:                                ; %land.lhs.true18.us
                                        ;   in Loop: Header=BB109_4 Depth=1
	ldr	w8, [x24, #56]
	cmp	w8, w20
	b.ne	LBB109_3
; %bb.9:                                ; %for.cond.preheader.us
                                        ;   in Loop: Header=BB109_4 Depth=1
	stp	x21, x25, [sp, #8]              ; 16-byte Folded Spill
	str	x23, [sp, #24]                  ; 8-byte Folded Spill
	mov	x23, #0
	mov	x25, #0
	ldr	x8, [x24, #72]
	mov	w22, #1
LBB109_10:                              ; %for.body.us
                                        ;   Parent Loop BB109_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x21, [x19, x25, lsl #3]
	add	x8, x8, x23
	ldr	x1, [x8, #40]
	mov	x0, x21
	bl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	ldr	x8, [x24, #72]
	add	x9, x8, x23
	ldr	x9, [x9, #16]
	ldr	x10, [x21, #16]
	cmp	x9, x10
	csel	w22, wzr, w22, eq
	add	x25, x25, #1
	add	x23, x23, #56
	cmp	w0, #0
	ccmp	x25, x26, #0, ne
	b.lt	LBB109_10
; %bb.11:                               ; %for.cond.cleanup.us
                                        ;   in Loop: Header=BB109_4 Depth=1
	ldp	x25, x23, [sp, #16]             ; 16-byte Folded Reload
	ldr	x21, [sp, #8]                   ; 8-byte Folded Reload
	tbz	w0, #0, LBB109_3
; %bb.12:                               ; %do.body
	tbnz	w22, #0, LBB109_14
; %bb.13:                               ; %if.then42
Lloh360:
	adrp	x1, l_.str.9.46@PAGE
Lloh361:
	add	x1, x1, l_.str.9.46@PAGEOFF
	mov	x0, x23
	bl	_halide_print
	bl	_abort
LBB109_14:                              ; %for.body48.preheader
	mov	w20, w20
LBB109_15:                              ; %for.body48
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x19], #8
	ldr	x0, [x8, #16]
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	str	xzr, [x0]
	subs	x20, x20, #1
	b.ne	LBB109_15
	b	LBB109_69
LBB109_16:                              ; %if.end59
                                        ;   in Loop: Header=BB109_17 Depth=1
	ldr	x24, [x24]
	cbz	x24, LBB109_22
LBB109_17:                              ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w8, [x24, #48]
	cmp	w8, w27
	b.ne	LBB109_16
; %bb.18:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB109_17 Depth=1
	ldr	x8, [x24, #32]
	cmp	x8, x28
	b.ne	LBB109_16
; %bb.19:                               ; %land.lhs.true12
                                        ;   in Loop: Header=BB109_17 Depth=1
	ldr	x0, [x24, #40]
	ldr	x1, [sp, #56]                   ; 8-byte Folded Reload
	mov	x2, x28
	bl	__ZN6Halide7Runtime8Internal10keys_equalEPKhS3_m
	cbz	w0, LBB109_16
; %bb.20:                               ; %land.lhs.true15
                                        ;   in Loop: Header=BB109_17 Depth=1
	ldr	x1, [x24, #64]
	mov	x0, x21
	bl	__ZN6Halide7Runtime8Internal16buffer_has_shapeEPK15halide_buffer_tPK18halide_dimension_t
	cbz	w0, LBB109_16
; %bb.21:                               ; %land.lhs.true18
                                        ;   in Loop: Header=BB109_17 Depth=1
	ldr	w8, [x24, #56]
	cmp	w8, w20
	b.ne	LBB109_16
	b	LBB109_69
LBB109_22:                              ; %for.cond61.preheader
	mov	x24, x21
	cmp	w20, #1
	b.lt	LBB109_54
; %bb.23:                               ; %for.body64.preheader
	mov	x8, #0
	mov	x21, #0
	mov	w9, w20
	b	LBB109_26
LBB109_24:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit.loopexit
                                        ;   in Loop: Header=BB109_26 Depth=1
	sub	x11, x13, x15
	add	x11, x11, #1
LBB109_25:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit
                                        ;   in Loop: Header=BB109_26 Depth=1
	ldrb	w10, [x10, #33]
	add	x10, x10, #7
	lsr	x10, x10, #3
	madd	x21, x10, x11, x21
	add	x8, x8, #1
	cmp	x8, x9
	b.eq	LBB109_55
LBB109_26:                              ; %for.body64
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB109_32 Depth 2
                                        ;     Child Loop BB109_41 Depth 2
                                        ;     Child Loop BB109_45 Depth 2
                                        ;     Child Loop BB109_52 Depth 2
	ldr	x10, [x19, x8, lsl #3]
	ldr	w11, [x10, #36]
	cmp	w11, #1
	b.lt	LBB109_29
; %bb.27:                               ; %for.body.lr.ph.i.i
                                        ;   in Loop: Header=BB109_26 Depth=1
	ldr	x12, [x10, #40]
	cmp	w11, #1
	b.ne	LBB109_30
; %bb.28:                               ;   in Loop: Header=BB109_26 Depth=1
	mov	x14, #0
	mov	x13, #0
	b	LBB109_39
LBB109_29:                              ;   in Loop: Header=BB109_26 Depth=1
	mov	w11, #1
	b	LBB109_25
LBB109_30:                              ; %vector.ph24
                                        ;   in Loop: Header=BB109_26 Depth=1
	mov	x13, #0
	mov	x15, #0
	and	x14, x11, #0xfffffffe
	add	x16, x12, #24
	mov	x17, x14
	b	LBB109_32
LBB109_31:                              ; %pred.load.continue37
                                        ;   in Loop: Header=BB109_32 Depth=2
	sub	w2, w2, #1
	sub	w3, w3, #1
	sxtw	x2, w2
	sxtw	x3, w3
	mul	x2, x2, x0
	mul	x3, x3, x1
	cmp	w0, #0
	csel	x0, x2, xzr, gt
	add	x13, x13, x0
	cmp	w1, #0
	csel	x0, x3, xzr, gt
	add	x15, x15, x0
	add	x16, x16, #32
	subs	x17, x17, #2
	b.eq	LBB109_36
LBB109_32:                              ; %vector.body22
                                        ;   Parent Loop BB109_26 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldur	w0, [x16, #-16]
                                        ; implicit-def: $w2
	cmp	w0, #1
	b.lt	LBB109_34
; %bb.33:                               ; %pred.load.if34
                                        ;   in Loop: Header=BB109_32 Depth=2
	ldur	w2, [x16, #-20]
LBB109_34:                              ; %pred.load.continue35
                                        ;   in Loop: Header=BB109_32 Depth=2
	ldr	w1, [x16]
                                        ; implicit-def: $w3
	cmp	w1, #1
	b.lt	LBB109_31
; %bb.35:                               ; %pred.load.if36
                                        ;   in Loop: Header=BB109_32 Depth=2
	ldur	w3, [x16, #-4]
	b	LBB109_31
LBB109_36:                              ; %middle.block20
                                        ;   in Loop: Header=BB109_26 Depth=1
	add	x13, x15, x13
	cmp	x14, x11
	b.ne	LBB109_39
LBB109_37:                              ; %for.body.i12.i.preheader
                                        ;   in Loop: Header=BB109_26 Depth=1
	cmp	w11, #2
	b.hs	LBB109_43
; %bb.38:                               ;   in Loop: Header=BB109_26 Depth=1
	mov	x14, #0
	mov	x15, #0
	b	LBB109_50
LBB109_39:                              ; %for.body.i.i.preheader
                                        ;   in Loop: Header=BB109_26 Depth=1
	sub	x15, x11, x14
	add	x14, x12, x14, lsl #4
	add	x14, x14, #8
	b	LBB109_41
LBB109_40:                              ; %if.end.i.i
                                        ;   in Loop: Header=BB109_41 Depth=2
	add	x14, x14, #16
	subs	x15, x15, #1
	b.eq	LBB109_37
LBB109_41:                              ; %for.body.i.i
                                        ;   Parent Loop BB109_26 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w16, [x14]
	cmp	w16, #1
	b.lt	LBB109_40
; %bb.42:                               ; %if.then.i.i
                                        ;   in Loop: Header=BB109_41 Depth=2
	ldursw	x17, [x14, #-4]
	sub	x17, x17, #1
	madd	x13, x17, x16, x13
	b	LBB109_40
LBB109_43:                              ; %vector.ph
                                        ;   in Loop: Header=BB109_26 Depth=1
	mov	x15, #0
	mov	x16, #0
	and	x14, x11, #0xfffffffe
	add	x17, x12, #24
	mov	x0, x14
	b	LBB109_45
LBB109_44:                              ; %pred.load.continue18
                                        ;   in Loop: Header=BB109_45 Depth=2
	sub	w3, w3, #1
	sub	w4, w4, #1
	sxtw	x3, w3
	sxtw	x4, w4
	mul	x3, x3, x1
	mul	x4, x4, x2
	cmp	w1, #0
	csel	x1, x3, xzr, lt
	add	x15, x15, x1
	cmp	w2, #0
	csel	x1, x4, xzr, lt
	add	x16, x16, x1
	add	x17, x17, #32
	subs	x0, x0, #2
	b.eq	LBB109_49
LBB109_45:                              ; %vector.body
                                        ;   Parent Loop BB109_26 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldursw	x1, [x17, #-16]
                                        ; implicit-def: $w3
	tbnz	w1, #31, LBB109_47
; %bb.46:                               ; %pred.load.continue
                                        ;   in Loop: Header=BB109_45 Depth=2
	ldrsw	x2, [x17]
                                        ; implicit-def: $w4
	tbz	w2, #31, LBB109_44
	b	LBB109_48
LBB109_47:                              ; %pred.load.if
                                        ;   in Loop: Header=BB109_45 Depth=2
	ldur	w3, [x17, #-20]
	ldrsw	x2, [x17]
                                        ; implicit-def: $w4
	tbz	w2, #31, LBB109_44
LBB109_48:                              ; %pred.load.if17
                                        ;   in Loop: Header=BB109_45 Depth=2
	ldur	w4, [x17, #-4]
	b	LBB109_44
LBB109_49:                              ; %middle.block
                                        ;   in Loop: Header=BB109_26 Depth=1
	add	x15, x16, x15
	cmp	x14, x11
	b.eq	LBB109_24
LBB109_50:                              ; %for.body.i12.i.preheader1
                                        ;   in Loop: Header=BB109_26 Depth=1
	sub	x11, x11, x14
	add	x12, x12, x14, lsl #4
	add	x12, x12, #8
	b	LBB109_52
LBB109_51:                              ; %if.end.i22.i
                                        ;   in Loop: Header=BB109_52 Depth=2
	add	x12, x12, #16
	subs	x11, x11, #1
	b.eq	LBB109_24
LBB109_52:                              ; %for.body.i12.i
                                        ;   Parent Loop BB109_26 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrsw	x14, [x12]
	tbz	w14, #31, LBB109_51
; %bb.53:                               ; %if.then.i18.i
                                        ;   in Loop: Header=BB109_52 Depth=2
	ldursw	x16, [x12, #-4]
	sub	x16, x16, #1
	madd	x15, x16, x14, x15
	b	LBB109_51
LBB109_54:
	mov	x21, #0
LBB109_55:                              ; %for.cond.cleanup63
Lloh362:
	adrp	x22, __ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPAGE
Lloh363:
	ldr	x22, [x22, __ZN6Halide7Runtime8Internal18current_cache_sizeE@GOTPAGEOFF]
	ldr	x8, [x22]
	add	x8, x8, x21
	str	x8, [x22]
	bl	__ZN6Halide7Runtime8Internal11prune_cacheEv
	mov	x0, #0
	mov	w1, #96
	bl	_halide_malloc
	mov	x28, x0
	cbz	x0, LBB109_64
; %bb.56:                               ; %if.then76
	ldp	x8, x1, [sp, #48]               ; 16-byte Folded Reload
                                        ; kill: def $w8 killed $w8 killed $x8 def $x8
	sxtw	x2, w8
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	str	x8, [sp]
	mov	x0, x28
	mov	x3, x27
	mov	x4, x24
	mov	x5, x20
	mov	x6, x19
	ldr	w7, [sp, #44]                   ; 4-byte Folded Reload
	bl	__ZN6Halide7Runtime8Internal10CacheEntry4initEPKhmjPK15halide_buffer_tiPPS5_by
	tbz	w0, #0, LBB109_64
; %bb.57:                               ; %if.end101
Lloh364:
	adrp	x10, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGE
Lloh365:
	ldr	x10, [x10, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGEOFF]
	ldr	x8, [x10, x25, lsl #3]
	str	x8, [x28]
Lloh366:
	adrp	x8, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGE
Lloh367:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGEOFF]
	ldr	x9, [x8]
	str	x9, [x28, #16]
	cbz	x9, LBB109_59
; %bb.58:                               ; %if.then106
	str	x28, [x9, #8]
LBB109_59:                              ; %if.end107
	str	x28, [x8]
Lloh368:
	adrp	x8, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGE
Lloh369:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGEOFF]
	ldr	x9, [x8]
	cbnz	x9, LBB109_61
; %bb.60:                               ; %if.then109
	str	x28, [x8]
LBB109_61:                              ; %if.end110
	str	x28, [x10, x25, lsl #3]
	str	w20, [x28, #52]
	cmp	w20, #1
	b.lt	LBB109_69
; %bb.62:                               ; %for.body117.preheader
	mov	w20, w20
LBB109_63:                              ; %for.body117
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x19], #8
	ldr	x0, [x8, #16]
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	str	x28, [x0]
	subs	x20, x20, #1
	b.ne	LBB109_63
	b	LBB109_69
LBB109_64:                              ; %if.then83
	ldr	x8, [x22]
	sub	x8, x8, x21
	str	x8, [x22]
	cmp	w20, #1
	b.lt	LBB109_67
; %bb.65:                               ; %for.body88.preheader
	mov	w20, w20
LBB109_66:                              ; %for.body88
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x19], #8
	ldr	x0, [x8, #16]
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	str	xzr, [x0]
	subs	x20, x20, #1
	b.ne	LBB109_66
LBB109_67:                              ; %for.cond.cleanup87
	cbz	x28, LBB109_69
; %bb.68:                               ; %if.then99
	mov	x0, x23
	mov	x1, x28
	bl	_halide_free
LBB109_69:                              ; %cleanup132
Lloh370:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh371:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	w0, #0
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	ret
	.loh AdrpLdrGot	Lloh358, Lloh359
	.loh AdrpLdrGot	Lloh356, Lloh357
	.loh AdrpAdd	Lloh360, Lloh361
	.loh AdrpLdrGot	Lloh362, Lloh363
	.loh AdrpLdrGot	Lloh366, Lloh367
	.loh AdrpLdrGot	Lloh364, Lloh365
	.loh AdrpLdrGot	Lloh368, Lloh369
	.loh AdrpLdrGot	Lloh370, Lloh371
                                        ; -- End function
	.globl	_halide_memoization_cache_release ; -- Begin function halide_memoization_cache_release
	.weak_definition	_halide_memoization_cache_release
	.p2align	2
_halide_memoization_cache_release:      ; @halide_memoization_cache_release
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	mov	x0, x1
	bl	__ZN6Halide7Runtime8Internal21get_pointer_to_headerEPh
	ldr	x20, [x0]
	cbz	x20, LBB110_4
; %bb.1:                                ; %if.else
Lloh372:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh373:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	bl	_halide_mutex_lock
	ldr	w8, [x20, #52]
	cbnz	w8, LBB110_3
; %bb.2:                                ; %if.then4
Lloh374:
	adrp	x1, l_.str.12.47@PAGE
Lloh375:
	add	x1, x1, l_.str.12.47@PAGEOFF
	mov	x0, x19
	bl	_halide_print
	bl	_abort
	ldr	w8, [x20, #52]
LBB110_3:                               ; %do.end
	sub	w8, w8, #1
	str	w8, [x20, #52]
Lloh376:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh377:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_mutex_unlock
LBB110_4:                               ; %if.then
	mov	x1, x0
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_free
	.loh AdrpLdrGot	Lloh372, Lloh373
	.loh AdrpAdd	Lloh374, Lloh375
	.loh AdrpLdrGot	Lloh376, Lloh377
                                        ; -- End function
	.globl	_halide_memoization_cache_evict ; -- Begin function halide_memoization_cache_evict
	.weak_definition	_halide_memoization_cache_evict
	.p2align	2
_halide_memoization_cache_evict:        ; @halide_memoization_cache_evict
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	x19, x1
	mov	x20, x0
Lloh378:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh379:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	bl	_halide_mutex_lock
Lloh380:
	adrp	x22, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGE
Lloh381:
	ldr	x22, [x22, __ZN6Halide7Runtime8Internal13cache_entriesE@GOTPAGEOFF]
Lloh382:
	adrp	x23, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGE
Lloh383:
	ldr	x23, [x23, __ZN6Halide7Runtime8Internal18most_recently_usedE@GOTPAGEOFF]
Lloh384:
	adrp	x24, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGE
Lloh385:
	ldr	x24, [x24, __ZN6Halide7Runtime8Internal19least_recently_usedE@GOTPAGEOFF]
	mov	x25, x22
	b	LBB111_2
LBB111_1:                               ; %if.end25
                                        ;   in Loop: Header=BB111_2 Depth=1
	add	x25, x25, #8
	add	x8, x22, #2048
	cmp	x25, x8
	b.eq	LBB111_11
LBB111_2:                               ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB111_7 Depth 2
	ldr	x26, [x25]
	cbz	x26, LBB111_1
; %bb.3:                                ; %while.body.preheader
                                        ;   in Loop: Header=BB111_2 Depth=1
	mov	x27, x25
	b	LBB111_7
LBB111_4:                               ; %if.else
                                        ;   in Loop: Header=BB111_7 Depth=2
	str	x9, [x23]
LBB111_5:                               ; %if.end
                                        ;   in Loop: Header=BB111_7 Depth=2
	add	x10, x9, #8
	cmp	x9, #0
	csel	x9, x24, x10, eq
	str	x8, [x9]
	mov	x0, x21
	bl	__ZN6Halide7Runtime8Internal10CacheEntry7destroyEv
	mov	x0, x20
	mov	x1, x21
	bl	_halide_free
	mov	x21, x27
LBB111_6:                               ; %if.end24
                                        ;   in Loop: Header=BB111_7 Depth=2
	mov	x27, x21
	cbz	x26, LBB111_1
LBB111_7:                               ; %while.body
                                        ;   Parent Loop BB111_2 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x21, x26
	ldr	x26, [x26]
	ldrb	w8, [x21, #88]
	cbz	w8, LBB111_6
; %bb.8:                                ; %land.lhs.true
                                        ;   in Loop: Header=BB111_7 Depth=2
	ldr	x8, [x21, #80]
	cmp	x8, x19
	b.ne	LBB111_6
; %bb.9:                                ; %if.then7
                                        ;   in Loop: Header=BB111_7 Depth=2
	str	x26, [x27]
	ldp	x8, x9, [x21, #8]
	cbz	x8, LBB111_4
; %bb.10:                               ; %if.then9
                                        ;   in Loop: Header=BB111_7 Depth=2
	str	x9, [x8, #16]
	ldr	x9, [x21, #16]
	b	LBB111_5
LBB111_11:                              ; %for.cond.cleanup
Lloh386:
	adrp	x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGE
Lloh387:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal16memoization_lockE@GOTPAGEOFF]
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	b	_halide_mutex_unlock
	.loh AdrpLdrGot	Lloh384, Lloh385
	.loh AdrpLdrGot	Lloh382, Lloh383
	.loh AdrpLdrGot	Lloh380, Lloh381
	.loh AdrpLdrGot	Lloh378, Lloh379
	.loh AdrpLdrGot	Lloh386, Lloh387
                                        ; -- End function
	.globl	_halide_string_to_string        ; -- Begin function halide_string_to_string
	.weak_definition	_halide_string_to_string
	.p2align	2
_halide_string_to_string:               ; @halide_string_to_string
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	cmp	x0, x1
	b.hs	LBB112_5
; %bb.1:                                ; %if.end
Lloh388:
	adrp	x8, l_.str.50@PAGE
Lloh389:
	add	x8, x8, l_.str.50@PAGEOFF
	cmp	x2, #0
	csel	x8, x8, x2, eq
LBB112_2:                               ; %if.end5
                                        ; =>This Inner Loop Header: Depth=1
	ldrb	w9, [x8]
	strb	w9, [x0]
	cbz	w9, LBB112_5
; %bb.3:                                ; %if.end8
                                        ;   in Loop: Header=BB112_2 Depth=1
	add	x0, x0, #1
	add	x8, x8, #1
	cmp	x0, x1
	b.ne	LBB112_2
; %bb.4:                                ; %if.then4
	sturb	wzr, [x0, #-1]
	mov	x0, x1
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB112_5:
	mov	x1, x0
	mov	x0, x1
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh388, Lloh389
                                        ; -- End function
	.globl	_halide_uint64_to_string        ; -- Begin function halide_uint64_to_string
	.weak_definition	_halide_uint64_to_string
	.p2align	2
_halide_uint64_to_string:               ; @halide_uint64_to_string
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	strb	wzr, [sp, #31]
	mov	x8, sp
	add	x8, x8, #30
	cbnz	x2, LBB113_2
; %bb.1:                                ; %entry
	cmp	w3, #1
	b.lt	LBB113_5
LBB113_2:                               ; %for.body.preheader
	mov	w11, #1
	mov	x9, #-3689348814741910324
	movk	x9, #52429
	mov	w10, #-10
LBB113_3:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	mov	x12, x2
	mov	x13, x11
	umulh	x11, x2, x9
	lsr	x2, x11, #3
	madd	w11, w2, w10, w12
	add	w11, w11, #48
	strb	w11, [x8], #-1
	add	w11, w13, #1
	cmp	w13, w3
	b.lt	LBB113_3
; %bb.4:                                ; %for.body
                                        ;   in Loop: Header=BB113_3 Depth=1
	cmp	x12, #9
	b.hi	LBB113_3
LBB113_5:                               ; %for.cond.cleanup
	add	x2, x8, #1
	bl	_halide_string_to_string
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
                                        ; -- End function
	.globl	_halide_int64_to_string         ; -- Begin function halide_int64_to_string
	.weak_definition	_halide_int64_to_string
	.p2align	2
_halide_int64_to_string:                ; @halide_int64_to_string
; %bb.0:                                ; %entry
	cmp	x0, x1
	b.hs	LBB114_3
; %bb.1:                                ; %entry
	tbz	x2, #63, LBB114_3
; %bb.2:                                ; %if.then
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w8, #45
	strb	w8, [x0], #1
	neg	x2, x2
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
LBB114_3:                               ; %if.end
	b	_halide_uint64_to_string
                                        ; -- End function
	.globl	_halide_double_to_string        ; -- Begin function halide_double_to_string
	.weak_definition	_halide_double_to_string
	.p2align	2
_halide_double_to_string:               ; @halide_double_to_string
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	sub	sp, sp, #528
	mov	x21, x2
	mov	x19, x1
	mov	x20, x0
	stur	d0, [x29, #-56]
	stur	xzr, [x29, #-64]
	sub	x0, x29, #64
	sub	x1, x29, #56
	mov	w2, #8
	bl	_memcpy
	ldur	x8, [x29, #-64]
	and	x22, x8, #0xfffffffffffff
	ubfx	x23, x8, #52, #11
	cmp	w23, #2047
	b.ne	LBB115_4
; %bb.1:                                ; %if.then
	cbz	x22, LBB115_19
; %bb.2:                                ; %if.then4
	tbnz	x8, #63, LBB115_21
; %bb.3:                                ; %if.else
Lloh390:
	adrp	x2, l_.str.2.58@PAGE
Lloh391:
	add	x2, x2, l_.str.2.58@PAGEOFF
	b	LBB115_34
LBB115_4:                               ; %if.else15
	cmp	w23, #0
	ccmp	x22, #0, #0, eq
	b.eq	LBB115_16
; %bb.5:                                ; %if.end32
	tbnz	x8, #63, LBB115_22
; %bb.6:                                ; %if.end36
	cbz	w21, LBB115_23
LBB115_7:                               ; %while.condthread-pre-split
	ldur	d0, [x29, #-56]
	fmov	d1, #1.00000000
	mov	w22, #0
	fcmp	d0, d1
	b.pl	LBB115_11
; %bb.8:                                ; %while.body.preheader
	fmov	d2, #10.00000000
LBB115_9:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	fmul	d0, d0, d2
	sub	w22, w22, #1
	fcmp	d0, d1
	b.mi	LBB115_9
; %bb.10:                               ; %while.cond.while.cond40thread-pre-split_crit_edge
	stur	d0, [x29, #-56]
LBB115_11:                              ; %while.cond40thread-pre-split
	fmov	d1, #10.00000000
	fcmp	d0, d1
	b.lt	LBB115_14
LBB115_12:                              ; %while.body42
                                        ; =>This Inner Loop Header: Depth=1
	fdiv	d0, d0, d1
	add	w22, w22, #1
	fcmp	d0, d1
	b.ge	LBB115_12
; %bb.13:                               ; %while.cond40.while.end43_crit_edge
	stur	d0, [x29, #-56]
LBB115_14:                              ; %while.end43
	mov	x8, #145685290680320
	movk	x8, #16686, lsl #48
	fmov	d1, x8
	fmov	d2, #0.50000000
	fmadd	d0, d0, d1, d2
	fcvtzu	x8, d0
	mov	x9, #13531
	movk	x9, #55222, lsl #16
	movk	x9, #56962, lsl #32
	movk	x9, #17179, lsl #48
	umulh	x9, x8, x9
	lsr	x2, x9, #18
	mov	x9, #-16960
	movk	x9, #65520, lsl #16
	madd	x21, x2, x9, x8
	mov	x0, x20
	mov	x1, x19
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh392:
	adrp	x2, l_.str.30.141@PAGE
Lloh393:
	add	x2, x2, l_.str.30.141@PAGEOFF
	mov	x1, x19
	bl	_halide_string_to_string
	mov	x1, x19
	mov	x2, x21
	mov	w3, #6
	bl	_halide_int64_to_string
	tbnz	w22, #31, LBB115_29
; %bb.15:                               ; %if.then53
Lloh394:
	adrp	x2, l_.str.11.67@PAGE
Lloh395:
	add	x2, x2, l_.str.11.67@PAGEOFF
	mov	x1, x19
	bl	_halide_string_to_string
	b	LBB115_30
LBB115_16:                              ; %if.then18
	cbz	w21, LBB115_26
; %bb.17:                               ; %if.then20
	tbnz	x8, #63, LBB115_31
; %bb.18:                               ; %if.else24
Lloh396:
	adrp	x2, l_.str.6.62@PAGE
Lloh397:
	add	x2, x2, l_.str.6.62@PAGEOFF
	b	LBB115_34
LBB115_19:                              ; %if.else9
	tbnz	x8, #63, LBB115_28
; %bb.20:                               ; %if.else13
Lloh398:
	adrp	x2, l_.str.4.60@PAGE
Lloh399:
	add	x2, x2, l_.str.4.60@PAGEOFF
	b	LBB115_34
LBB115_21:                              ; %if.then6
Lloh400:
	adrp	x2, l_.str.1.57@PAGE
Lloh401:
	add	x2, x2, l_.str.1.57@PAGEOFF
	b	LBB115_34
LBB115_22:                              ; %if.then34
Lloh402:
	adrp	x2, l_.str.9.65@PAGE
Lloh403:
	add	x2, x2, l_.str.9.65@PAGEOFF
	mov	x0, x20
	mov	x1, x19
	bl	_halide_string_to_string
	mov	x20, x0
	ldur	d0, [x29, #-56]
	fneg	d0, d0
	stur	d0, [x29, #-56]
	cbnz	w21, LBB115_7
LBB115_23:                              ; %if.else61
	cbz	w23, LBB115_32
; %bb.24:                               ; %if.end65
	orr	x2, x22, #0x10000000000000
	sub	w22, w23, #1075
	cmp	w23, #1074
	b.hi	LBB115_35
; %bb.25:                               ; %if.end102.thread
	mov	w8, #1075
	sub	w8, w8, w23
	lsr	x9, x2, x8
	lsl	x8, x9, x8
	cmp	w23, #1023
	csel	x9, xzr, x9, lo
	csel	x8, xzr, x8, lo
	sub	x8, x2, x8
	ucvtf	d0, x8
	mov	x8, #145685290680320
	movk	x8, #16686, lsl #48
	add	x8, x8, x22, lsl #52
	fmov	d1, x8
	fmov	d2, #0.50000000
	fmadd	d0, d0, d1, d2
	fcvtzu	x8, d0
	fcvtzu	d1, d0
	ucvtf	d1, d1
	fcmp	d0, d1
	cset	w10, eq
	and	w10, w10, w8
	sub	x8, x8, x10
	mov	w10, #16960
	movk	w10, #15, lsl #16
	cmp	x8, x10
	cinc	x2, x9, eq
	csel	x22, xzr, x8, eq
	mov	x8, sp
	add	x1, x8, #512
	add	x21, x8, #480
	mov	x0, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	b	LBB115_45
LBB115_26:                              ; %if.else26
	tbnz	x8, #63, LBB115_33
; %bb.27:                               ; %if.else30
Lloh404:
	adrp	x2, l_.str.8.64@PAGE
Lloh405:
	add	x2, x2, l_.str.8.64@PAGEOFF
	b	LBB115_34
LBB115_28:                              ; %if.then11
Lloh406:
	adrp	x2, l_.str.3.59@PAGE
Lloh407:
	add	x2, x2, l_.str.3.59@PAGEOFF
	b	LBB115_34
LBB115_29:                              ; %if.else55
Lloh408:
	adrp	x2, l_.str.12.68@PAGE
Lloh409:
	add	x2, x2, l_.str.12.68@PAGEOFF
	mov	x1, x19
	bl	_halide_string_to_string
	neg	w22, w22
LBB115_30:                              ; %if.end58
	mov	w2, w22
	mov	x1, x19
	mov	w3, #2
	b	LBB115_46
LBB115_31:                              ; %if.then22
Lloh410:
	adrp	x2, l_.str.5.61@PAGE
Lloh411:
	add	x2, x2, l_.str.5.61@PAGEOFF
	b	LBB115_34
LBB115_32:                              ; %if.then63
	movi	d0, #0000000000000000
	mov	x0, x20
	mov	x1, x19
	mov	w2, #0
	bl	_halide_double_to_string
	add	sp, sp, #528
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB115_33:                              ; %if.then28
Lloh412:
	adrp	x2, l_.str.7.63@PAGE
Lloh413:
	add	x2, x2, l_.str.7.63@PAGEOFF
LBB115_34:                              ; %cleanup145
	mov	x0, x20
	mov	x1, x19
	bl	_halide_string_to_string
	add	sp, sp, #528
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB115_35:                              ; %if.end102
	mov	x8, sp
	add	x1, x8, #512
	add	x21, x8, #480
	mov	x0, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	w22, LBB115_44
; %bb.36:                               ; %for.cond109.preheader.preheader
	mov	w8, #0
	mov	w9, #49
	b	LBB115_39
LBB115_37:                              ; %if.end135
                                        ;   in Loop: Header=BB115_39 Depth=1
	mov	x21, x10
LBB115_38:                              ; %if.end135
                                        ;   in Loop: Header=BB115_39 Depth=1
	add	w8, w8, #1
	cmp	w8, w22
	b.eq	LBB115_44
LBB115_39:                              ; %for.cond109.preheader
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB115_41 Depth 2
	mov	x10, x21
	mov	x21, x0
	cmp	x0, x10
	b.eq	LBB115_38
; %bb.40:                               ; %for.body113.preheader
                                        ;   in Loop: Header=BB115_39 Depth=1
	mov	w12, #0
	mov	x11, x0
LBB115_41:                              ; %for.body113
                                        ;   Parent Loop BB115_39 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldrb	w13, [x11, #-1]!
	sub	w13, w13, #48
	sxtb	w13, w13
	orr	w14, w12, w13, lsl #1
	sxtb	w13, w14
	sub	w15, w14, #10
	cmp	w13, #9
	cset	w12, gt
	csel	w14, w15, w14, gt
	add	w14, w14, #48
	strb	w14, [x11]
	cmp	x11, x10
	b.ne	LBB115_41
; %bb.42:                               ; %for.cond.cleanup112
                                        ;   in Loop: Header=BB115_39 Depth=1
	cmp	w13, #9
	b.le	LBB115_37
; %bb.43:                               ; %if.then133
                                        ;   in Loop: Header=BB115_39 Depth=1
	strb	w9, [x10, #-1]!
	b	LBB115_37
LBB115_44:
	mov	x22, #0
LBB115_45:                              ; %for.cond.cleanup
	mov	x0, x20
	mov	x1, x19
	mov	x2, x21
	bl	_halide_string_to_string
Lloh414:
	adrp	x2, l_.str.30.141@PAGE
Lloh415:
	add	x2, x2, l_.str.30.141@PAGEOFF
	mov	x1, x19
	bl	_halide_string_to_string
	mov	x1, x19
	mov	x2, x22
	mov	w3, #6
LBB115_46:                              ; %cleanup145
	bl	_halide_int64_to_string
	add	sp, sp, #528
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh390, Lloh391
	.loh AdrpAdd	Lloh392, Lloh393
	.loh AdrpAdd	Lloh394, Lloh395
	.loh AdrpAdd	Lloh396, Lloh397
	.loh AdrpAdd	Lloh398, Lloh399
	.loh AdrpAdd	Lloh400, Lloh401
	.loh AdrpAdd	Lloh402, Lloh403
	.loh AdrpAdd	Lloh404, Lloh405
	.loh AdrpAdd	Lloh406, Lloh407
	.loh AdrpAdd	Lloh408, Lloh409
	.loh AdrpAdd	Lloh410, Lloh411
	.loh AdrpAdd	Lloh412, Lloh413
	.loh AdrpAdd	Lloh414, Lloh415
                                        ; -- End function
	.globl	_halide_pointer_to_string       ; -- Begin function halide_pointer_to_string
	.weak_definition	_halide_pointer_to_string
	.p2align	2
_halide_pointer_to_string:              ; @halide_pointer_to_string
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	str	wzr, [sp, #24]
	stp	xzr, xzr, [sp, #8]
	add	x10, sp, #8
Lloh416:
	adrp	x9, l_.str.13.71@PAGE
Lloh417:
	add	x9, x9, l_.str.13.71@PAGEOFF
	and	x8, x2, #0xf
	ldrb	w11, [x9, x8]
	add	x8, x10, #17
	strb	w11, [sp, #26]
	cmp	x2, #16
	b.hs	LBB116_2
; %bb.1:
	add	x2, x10, #18
	b	LBB116_18
LBB116_2:                               ; %for.inc
	ubfx	x11, x2, #4, #4
	ldrb	w11, [x9, x11]
	add	x10, x10, #16
	strb	w11, [sp, #25]
	cmp	x2, #256
	b.lo	LBB116_15
; %bb.3:                                ; %for.inc.1
	ubfx	x8, x2, #8, #4
	ldrb	w12, [x9, x8]
	add	x11, sp, #8
	add	x8, x11, #15
	strb	w12, [sp, #24]
	cmp	x2, #1, lsl #12                 ; =4096
	b.lo	LBB116_17
; %bb.4:                                ; %for.inc.2
	ubfx	x10, x2, #12, #4
	ldrb	w12, [x9, x10]
	add	x10, x11, #14
	strb	w12, [sp, #23]
	cmp	x2, #16, lsl #12                ; =65536
	b.lo	LBB116_15
; %bb.5:                                ; %for.inc.3
	ubfx	x8, x2, #16, #4
	ldrb	w12, [x9, x8]
	add	x11, sp, #8
	add	x8, x11, #13
	strb	w12, [sp, #22]
	cmp	x2, #256, lsl #12               ; =1048576
	b.lo	LBB116_17
; %bb.6:                                ; %for.inc.4
	ubfx	x10, x2, #20, #4
	ldrb	w12, [x9, x10]
	add	x10, x11, #12
	strb	w12, [sp, #21]
	lsr	x11, x2, #24
	cbz	x11, LBB116_15
; %bb.7:                                ; %for.inc.5
	ubfx	x8, x2, #24, #4
	ldrb	w12, [x9, x8]
	add	x11, sp, #8
	add	x8, x11, #11
	strb	w12, [sp, #20]
	lsr	x12, x2, #28
	cbz	x12, LBB116_17
; %bb.8:                                ; %for.inc.6
	ubfx	x10, x2, #28, #4
	ldrb	w12, [x9, x10]
	add	x10, x11, #10
	strb	w12, [sp, #19]
	lsr	x11, x2, #32
	cbz	x11, LBB116_15
; %bb.9:                                ; %for.inc.7
	ubfx	x8, x2, #32, #4
	ldrb	w12, [x9, x8]
	add	x11, sp, #8
	add	x8, x11, #9
	strb	w12, [sp, #18]
	lsr	x12, x2, #36
	cbz	x12, LBB116_17
; %bb.10:                               ; %for.inc.8
	ubfx	x10, x2, #36, #4
	ldrb	w12, [x9, x10]
	add	x10, x11, #8
	strb	w12, [sp, #17]
	lsr	x11, x2, #40
	cbz	x11, LBB116_15
; %bb.11:                               ; %for.inc.9
	ubfx	x8, x2, #40, #4
	ldrb	w12, [x9, x8]
	add	x11, sp, #8
	orr	x8, x11, #0x7
	strb	w12, [sp, #16]
	lsr	x12, x2, #44
	cbz	x12, LBB116_17
; %bb.12:                               ; %for.inc.10
	ubfx	x10, x2, #44, #4
	ldrb	w12, [x9, x10]
	orr	x10, x11, #0x6
	strb	w12, [sp, #15]
	lsr	x11, x2, #48
	cbz	x11, LBB116_15
; %bb.13:                               ; %for.inc.11
	ubfx	x8, x2, #48, #4
	ldrb	w12, [x9, x8]
	mov	w8, #5
	add	x11, sp, #8
	orr	x8, x11, x8
	strb	w12, [sp, #14]
	lsr	x12, x2, #52
	cbz	x12, LBB116_17
; %bb.14:                               ; %for.inc.12
	ubfx	x10, x2, #52, #4
	ldrb	w12, [x9, x10]
	orr	x10, x11, #0x4
	strb	w12, [sp, #13]
	lsr	x11, x2, #56
	cbnz	x11, LBB116_16
LBB116_15:
	mov	x2, x8
	mov	x8, x10
	b	LBB116_18
LBB116_16:                              ; %for.inc.13
	ubfx	x8, x2, #56, #4
	ldrb	w12, [x9, x8]
	add	x11, sp, #8
	orr	x8, x11, #0x3
	strb	w12, [sp, #12]
	lsr	x12, x2, #60
	cbnz	x12, LBB116_19
LBB116_17:
	mov	x2, x10
LBB116_18:                              ; %cleanup
	mov	w9, #120
	strb	w9, [x8]
	mov	w8, #48
	strb	w8, [x2, #-2]!
	bl	_halide_string_to_string
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
LBB116_19:                              ; %for.inc.14
	ldrb	w9, [x9, x12]
	mov	x2, x8
	orr	x8, x11, #0x2
	strb	w9, [sp, #11]
	b	LBB116_18
	.loh AdrpAdd	Lloh416, Lloh417
                                        ; -- End function
	.globl	_halide_type_to_string          ; -- Begin function halide_type_to_string
	.weak_definition	_halide_type_to_string
	.p2align	2
_halide_type_to_string:                 ; @halide_type_to_string
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x20, x2
	mov	x19, x1
	ldrsb	x8, [x2]
	cmp	x8, #3
	b.hi	LBB117_2
; %bb.1:                                ; %switch.lookup
Lloh418:
	adrp	x9, l_switch.table.halide_type_to_string@PAGE
Lloh419:
	add	x9, x9, l_switch.table.halide_type_to_string@PAGEOFF
	ldr	x2, [x9, x8, lsl #3]
	b	LBB117_3
LBB117_2:
Lloh420:
	adrp	x2, l_.str.18.72@PAGE
Lloh421:
	add	x2, x2, l_.str.18.72@PAGEOFF
LBB117_3:                               ; %sw.epilog
	mov	x1, x19
	bl	_halide_string_to_string
	ldrb	w2, [x20, #1]
	mov	x1, x19
	mov	w3, #1
	bl	_halide_uint64_to_string
	ldrh	w8, [x20, #2]
	cmp	w8, #1
	b.ne	LBB117_5
; %bb.4:                                ; %if.end
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB117_5:                               ; %if.then
Lloh422:
	adrp	x2, l_.str.19.77@PAGE
Lloh423:
	add	x2, x2, l_.str.19.77@PAGEOFF
	mov	x1, x19
	bl	_halide_string_to_string
	ldrh	w2, [x20, #2]
	mov	x1, x19
	mov	w3, #1
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_uint64_to_string
	.loh AdrpAdd	Lloh418, Lloh419
	.loh AdrpAdd	Lloh420, Lloh421
	.loh AdrpAdd	Lloh422, Lloh423
                                        ; -- End function
	.globl	_halide_buffer_to_string        ; -- Begin function halide_buffer_to_string
	.weak_definition	_halide_buffer_to_string
	.p2align	2
_halide_buffer_to_string:               ; @halide_buffer_to_string
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x19, x1
	cbz	x2, LBB118_5
; %bb.1:                                ; %if.end
	mov	x20, x2
Lloh424:
	adrp	x2, l_.str.21.79@PAGE
Lloh425:
	add	x2, x2, l_.str.21.79@PAGEOFF
	mov	x1, x19
	bl	_halide_string_to_string
	ldr	x2, [x20]
	mov	x1, x19
	mov	w3, #1
	bl	_halide_uint64_to_string
Lloh426:
	adrp	x21, l_.str.55@PAGE
Lloh427:
	add	x21, x21, l_.str.55@PAGEOFF
	mov	x1, x19
	mov	x2, x21
	bl	_halide_string_to_string
	ldr	x2, [x20, #8]
	mov	x1, x19
	bl	_halide_pointer_to_string
	mov	x1, x19
	mov	x2, x21
	bl	_halide_string_to_string
	ldr	x2, [x20, #16]
	mov	x1, x19
	bl	_halide_pointer_to_string
	mov	x1, x19
	mov	x2, x21
	bl	_halide_string_to_string
	ldr	x2, [x20, #24]
	mov	x1, x19
	mov	w3, #1
	bl	_halide_uint64_to_string
	mov	x1, x19
	mov	x2, x21
	bl	_halide_string_to_string
	add	x2, x20, #32
	mov	x1, x19
	bl	_halide_type_to_string
	ldr	w8, [x20, #36]
	cmp	w8, #1
	b.lt	LBB118_4
; %bb.2:                                ; %for.body.lr.ph
	mov	x24, #0
	mov	x25, #0
Lloh428:
	adrp	x21, l_.str.23.82@PAGE
Lloh429:
	add	x21, x21, l_.str.23.82@PAGEOFF
Lloh430:
	adrp	x22, l_.str.55@PAGE
Lloh431:
	add	x22, x22, l_.str.55@PAGEOFF
Lloh432:
	adrp	x23, l_.str.24.83@PAGE
Lloh433:
	add	x23, x23, l_.str.24.83@PAGEOFF
LBB118_3:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	mov	x1, x19
	mov	x2, x21
	bl	_halide_string_to_string
	ldr	x8, [x20, #40]
	ldrsw	x2, [x8, x24]
	mov	x1, x19
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x19
	mov	x2, x22
	bl	_halide_string_to_string
	ldr	x8, [x20, #40]
	add	x8, x8, x24
	ldrsw	x2, [x8, #4]
	mov	x1, x19
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x19
	mov	x2, x22
	bl	_halide_string_to_string
	ldr	x8, [x20, #40]
	add	x8, x8, x24
	ldrsw	x2, [x8, #8]
	mov	x1, x19
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x19
	mov	x2, x23
	bl	_halide_string_to_string
	add	x25, x25, #1
	ldrsw	x8, [x20, #36]
	add	x24, x24, #16
	cmp	x25, x8
	b.lt	LBB118_3
LBB118_4:                               ; %for.cond.cleanup
Lloh434:
	adrp	x2, l_.str.8.119@PAGE
Lloh435:
	add	x2, x2, l_.str.8.119@PAGEOFF
	b	LBB118_6
LBB118_5:                               ; %if.then
Lloh436:
	adrp	x2, l_.str.20.78@PAGE
Lloh437:
	add	x2, x2, l_.str.20.78@PAGEOFF
LBB118_6:                               ; %if.then
	mov	x1, x19
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	b	_halide_string_to_string
	.loh AdrpAdd	Lloh426, Lloh427
	.loh AdrpAdd	Lloh424, Lloh425
	.loh AdrpAdd	Lloh432, Lloh433
	.loh AdrpAdd	Lloh430, Lloh431
	.loh AdrpAdd	Lloh428, Lloh429
	.loh AdrpAdd	Lloh434, Lloh435
	.loh AdrpAdd	Lloh436, Lloh437
                                        ; -- End function
	.globl	_halide_malloc_alignment        ; -- Begin function halide_malloc_alignment
	.weak_definition	_halide_malloc_alignment
	.p2align	2
_halide_malloc_alignment:               ; @halide_malloc_alignment
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #32
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_reuse_device_allocations ; -- Begin function halide_reuse_device_allocations
	.weak_definition	_halide_reuse_device_allocations
	.p2align	2
_halide_reuse_device_allocations:       ; @halide_reuse_device_allocations
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
Lloh438:
	adrp	x8, __ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE@GOTPAGE
Lloh439:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE@GOTPAGEOFF]
Lloh440:
	strb	w1, [x8]
	tbz	w1, #0, LBB120_2
; %bb.1:
	mov	w20, #0
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB120_2:                               ; %if.then
	mov	x19, x0
Lloh441:
	adrp	x0, __ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPAGE
Lloh442:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPAGEOFF]
	bl	_halide_mutex_lock
Lloh443:
	adrp	x8, __ZN6Halide7Runtime8Internal23device_allocation_poolsE@GOTPAGE
Lloh444:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal23device_allocation_poolsE@GOTPAGEOFF]
Lloh445:
	ldr	x21, [x8]
	cbz	x21, LBB120_5
; %bb.3:                                ; %for.body.preheader
	mov	w20, #0
LBB120_4:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x21]
	mov	x0, x19
	blr	x8
	cmp	w0, #0
	csel	w20, w20, w0, eq
	ldr	x21, [x21, #8]
	cbnz	x21, LBB120_4
	b	LBB120_6
LBB120_5:
	mov	w20, #0
LBB120_6:                               ; %for.cond.cleanup
Lloh446:
	adrp	x0, __ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPAGE
Lloh447:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGotStr	Lloh438, Lloh439, Lloh440
	.loh AdrpLdrGotLdr	Lloh443, Lloh444, Lloh445
	.loh AdrpLdrGot	Lloh441, Lloh442
	.loh AdrpLdrGot	Lloh446, Lloh447
                                        ; -- End function
	.globl	_halide_can_reuse_device_allocations ; -- Begin function halide_can_reuse_device_allocations
	.weak_definition	_halide_can_reuse_device_allocations
	.p2align	2
_halide_can_reuse_device_allocations:   ; @halide_can_reuse_device_allocations
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh448:
	adrp	x8, __ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE@GOTPAGE
Lloh449:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE@GOTPAGEOFF]
	ldrb	w0, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh448, Lloh449
                                        ; -- End function
	.globl	_halide_register_device_allocation_pool ; -- Begin function halide_register_device_allocation_pool
	.weak_definition	_halide_register_device_allocation_pool
	.p2align	2
_halide_register_device_allocation_pool: ; @halide_register_device_allocation_pool
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
Lloh450:
	adrp	x20, __ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPAGE
Lloh451:
	ldr	x20, [x20, __ZN6Halide7Runtime8Internal21allocation_pools_lockE@GOTPAGEOFF]
	mov	x0, x20
	bl	_halide_mutex_lock
Lloh452:
	adrp	x8, __ZN6Halide7Runtime8Internal23device_allocation_poolsE@GOTPAGE
Lloh453:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal23device_allocation_poolsE@GOTPAGEOFF]
	ldr	x9, [x8]
	str	x9, [x19, #8]
	str	x19, [x8]
	mov	x0, x20
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_mutex_unlock
	.loh AdrpLdrGot	Lloh452, Lloh453
	.loh AdrpLdrGot	Lloh450, Lloh451
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t ; -- Begin function _ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	.weak_definition	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	.p2align	2
__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t: ; @_ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	ldr	x8, [x1, #24]
	tbnz	w8, #1, LBB123_2
; %bb.1:                                ; %return
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB123_2:                               ; %if.end
	tbnz	w8, #0, LBB123_5
; %bb.3:                                ; %if.end9
	mov	x19, x1
	ldr	x8, [x1, #8]
	cbz	x8, LBB123_6
; %bb.4:                                ; %if.end15
	mov	x20, x0
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #48]
	mov	x1, x19
	blr	x8
	cbz	w0, LBB123_7
LBB123_5:
	mov	w0, #-14
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB123_6:
	mov	w0, #-19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB123_7:                               ; %if.end23
	ldr	x8, [x19, #24]
	and	x8, x8, #0xfffffffffffffffd
	str	x8, [x19, #24]
	mov	x0, x20
	mov	x1, x19
	bl	_halide_msan_annotate_buffer_is_initialized
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_device_release          ; -- Begin function halide_device_release
	.weak_definition	_halide_device_release
	.p2align	2
_halide_device_release:                 ; @halide_device_release
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x8, [x1, #120]
	ldr	x1, [x8, #40]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x1
                                        ; -- End function
	.globl	_halide_copy_to_host            ; -- Begin function halide_copy_to_host
	.weak_definition	_halide_copy_to_host
	.p2align	2
_halide_copy_to_host:                   ; @halide_copy_to_host
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x1
	mov	x20, x0
Lloh454:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh455:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_lock
	cbz	x19, LBB125_5
; %bb.1:                                ; %if.end.i
	ldp	x8, x9, [x19]
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB125_6
; %bb.2:                                ; %if.end10.i
	cbz	x9, LBB125_7
; %bb.3:                                ; %if.end10.i
	cbnz	x8, LBB125_7
; %bb.4:                                ; %if.then14.i
	mov	x0, x20
	bl	_halide_error_device_interface_no_device
	mov	x21, x0
	cbnz	w0, LBB125_10
	b	LBB125_9
LBB125_5:                               ; %if.then.i
Lloh456:
	adrp	x1, l_.str.6.88@PAGE
Lloh457:
	add	x1, x1, l_.str.6.88@PAGEOFF
	mov	x0, x20
	bl	_halide_error_buffer_is_null
	mov	x21, x0
	cbnz	w0, LBB125_10
	b	LBB125_9
LBB125_6:                               ; %if.then8.i
	mov	x0, x20
	bl	_halide_error_no_device_interface
	mov	x21, x0
	cbnz	w0, LBB125_10
	b	LBB125_9
LBB125_7:                               ; %if.end16.i
	ldr	w8, [x19, #24]
	mvn	w8, w8
	tst	x8, #0x3
	b.ne	LBB125_9
; %bb.8:                                ; %if.then24.i
	mov	x0, x20
	bl	_halide_error_host_and_device_dirty
	mov	x21, x0
	cbnz	w0, LBB125_10
LBB125_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.split
	mov	x0, x20
	mov	x1, x19
	bl	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	mov	x21, x0
LBB125_10:                              ; %cleanup
Lloh458:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh459:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh454, Lloh455
	.loh AdrpAdd	Lloh456, Lloh457
	.loh AdrpLdrGot	Lloh458, Lloh459
                                        ; -- End function
	.globl	_copy_to_device_already_locked  ; -- Begin function copy_to_device_already_locked
	.weak_definition	_copy_to_device_already_locked
	.p2align	2
_copy_to_device_already_locked:         ; @copy_to_device_already_locked
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x2
	mov	x19, x1
	mov	x20, x0
	cbz	x1, LBB126_5
; %bb.1:                                ; %if.end.i
	ldp	x9, x8, [x19]
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB126_6
; %bb.2:                                ; %if.end10.i
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB126_7
; %bb.3:                                ; %if.end16.i
	ldr	w8, [x19, #24]
	mvn	w8, w8
	tst	x8, #0x3
	b.ne	LBB126_8
; %bb.4:                                ; %if.then24.i
	mov	x0, x20
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB126_14
	b	LBB126_8
LBB126_5:                               ; %if.then.i
Lloh460:
	adrp	x1, l_.str.7.89@PAGE
Lloh461:
	add	x1, x1, l_.str.7.89@PAGEOFF
	mov	x0, x20
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB126_14
	b	LBB126_8
LBB126_6:                               ; %if.then8.i
	mov	x0, x20
	bl	_halide_error_no_device_interface
	cbnz	w0, LBB126_14
	b	LBB126_8
LBB126_7:                               ; %if.then14.i
	mov	x0, x20
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB126_14
LBB126_8:                               ; %if.end
	cbnz	x21, LBB126_10
; %bb.9:                                ; %if.then2
	ldr	x21, [x19, #8]
	cbz	x21, LBB126_20
LBB126_10:                              ; %if.end11
	ldr	x8, [x19]
	cbz	x8, LBB126_13
; %bb.11:                               ; %land.lhs.true
	ldr	x8, [x19, #8]
	cmp	x8, x21
	b.eq	LBB126_15
; %bb.12:                               ; %if.then14
Lloh462:
	adrp	x1, l_.str.9.90@PAGE
Lloh463:
	add	x1, x1, l_.str.9.90@PAGEOFF
	mov	x0, x20
	bl	_halide_error
	mov	w0, #-42
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB126_13:                              ; %if.then18
	mov	x0, x20
	mov	x1, x19
	mov	x2, x21
	bl	_halide_device_malloc
	cbz	w0, LBB126_15
LBB126_14:                              ; %cleanup
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB126_15:                              ; %if.end27
	ldr	x8, [x19, #24]
	tbnz	w8, #0, LBB126_17
; %bb.16:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB126_17:                              ; %if.then29
	tbnz	w8, #1, LBB126_19
; %bb.18:                               ; %if.else
	ldr	x8, [x21, #120]
	ldr	x8, [x8, #56]
	mov	x0, x20
	mov	x1, x19
	blr	x8
	cbz	w0, LBB126_21
LBB126_19:
	mov	w0, #-15
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB126_20:                              ; %if.then7
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	b	_halide_error_no_device_interface
LBB126_21:                              ; %if.then46
	ldr	x8, [x19, #24]
	and	x8, x8, #0xfffffffffffffffe
	str	x8, [x19, #24]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh460, Lloh461
	.loh AdrpAdd	Lloh462, Lloh463
                                        ; -- End function
	.globl	_halide_device_malloc           ; -- Begin function halide_device_malloc
	.weak_definition	_halide_device_malloc
	.p2align	2
_halide_device_malloc:                  ; @halide_device_malloc
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x2
	mov	x21, x1
	mov	x20, x0
	cbz	x1, LBB127_5
; %bb.1:                                ; %if.end.i
	ldp	x9, x8, [x21]
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB127_6
; %bb.2:                                ; %if.end10.i
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB127_8
; %bb.3:                                ; %if.end16.i
	ldr	w9, [x21, #24]
	mvn	w9, w9
	tst	x9, #0x3
	b.ne	LBB127_10
; %bb.4:                                ; %if.then24.i
	mov	x0, x20
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB127_7
	b	LBB127_9
LBB127_5:                               ; %if.then.i
Lloh464:
	adrp	x1, l_.str.17.91@PAGE
Lloh465:
	add	x1, x1, l_.str.17.91@PAGEOFF
	mov	x0, x20
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB127_7
	b	LBB127_9
LBB127_6:                               ; %if.then8.i
	mov	x0, x20
	bl	_halide_error_no_device_interface
	cbz	w0, LBB127_9
LBB127_7:                               ; %cleanup12
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB127_8:                               ; %if.then14.i
	mov	x0, x20
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB127_7
LBB127_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x8, [x21, #8]
LBB127_10:                              ; %if.end
	cbz	x8, LBB127_13
; %bb.11:                               ; %if.end
	cmp	x8, x19
	b.eq	LBB127_13
; %bb.12:                               ; %if.then6
Lloh466:
	adrp	x1, l_.str.20.92@PAGE
Lloh467:
	add	x1, x1, l_.str.20.92@PAGEOFF
	mov	x0, x20
	bl	_halide_error
	mov	w0, #-42
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB127_13:                              ; %if.end7
	ldr	x8, [x19, #120]
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x19, #120]
	ldr	x8, [x8, #16]
	mov	x0, x20
	mov	x1, x21
	blr	x8
	mov	x20, x0
	ldr	x8, [x19, #120]
	ldr	x8, [x8, #8]
	blr	x8
	cmp	w20, #0
	mov	w8, #-16
	csel	w0, wzr, w8, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh464, Lloh465
	.loh AdrpAdd	Lloh466, Lloh467
                                        ; -- End function
	.globl	_halide_copy_to_device          ; -- Begin function halide_copy_to_device
	.weak_definition	_halide_copy_to_device
	.p2align	2
_halide_copy_to_device:                 ; @halide_copy_to_device
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x2
	mov	x20, x1
	mov	x21, x0
Lloh468:
	adrp	x22, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh469:
	ldr	x22, [x22, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	mov	x0, x22
	bl	_halide_mutex_lock
	mov	x0, x21
	mov	x1, x20
	mov	x2, x19
	bl	_copy_to_device_already_locked
	mov	x19, x0
	mov	x0, x22
	bl	_halide_mutex_unlock
	mov	x0, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh468, Lloh469
                                        ; -- End function
	.globl	_halide_device_sync             ; -- Begin function halide_device_sync
	.weak_definition	_halide_device_sync
	.p2align	2
_halide_device_sync:                    ; @halide_device_sync
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	mov	x20, x0
	cbz	x1, LBB129_5
; %bb.1:                                ; %if.end.i
	ldp	x9, x8, [x19]
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB129_6
; %bb.2:                                ; %if.end10.i
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB129_8
; %bb.3:                                ; %if.end16.i
	ldr	w9, [x19, #24]
	mvn	w9, w9
	tst	x9, #0x3
	b.ne	LBB129_10
; %bb.4:                                ; %if.then24.i
	mov	x0, x20
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB129_7
	b	LBB129_9
LBB129_5:                               ; %if.then.i
Lloh470:
	adrp	x1, l_.str.16.93@PAGE
Lloh471:
	add	x1, x1, l_.str.16.93@PAGEOFF
	mov	x0, x20
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB129_7
	b	LBB129_9
LBB129_6:                               ; %if.then8.i
	mov	x0, x20
	bl	_halide_error_no_device_interface
	cbz	w0, LBB129_9
LBB129_7:                               ; %cleanup8
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB129_8:                               ; %if.then14.i
	mov	x0, x20
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB129_7
LBB129_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x8, [x19, #8]
LBB129_10:                              ; %if.end
	cbz	x8, LBB129_12
; %bb.11:                               ; %if.end5
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #32]
	mov	x0, x20
	mov	x1, x19
	blr	x8
	cmp	w0, #0
	mov	w8, #-17
	csel	w0, wzr, w8, eq
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB129_12:                              ; %if.then3
	mov	x0, x20
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_error_no_device_interface
	.loh AdrpAdd	Lloh470, Lloh471
                                        ; -- End function
	.globl	_halide_device_free             ; -- Begin function halide_device_free
	.weak_definition	_halide_device_free
	.p2align	2
_halide_device_free:                    ; @halide_device_free
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x20, x1
	mov	x19, x0
	cbz	x1, LBB130_5
; %bb.1:                                ; %if.end.i
	ldp	x8, x22, [x20]
	cmp	x8, #0
	ccmp	x22, #0, #0, ne
	b.eq	LBB130_6
; %bb.2:                                ; %if.end10.i
	cmp	x22, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB130_8
; %bb.3:                                ; %if.end16.i
	ldr	w8, [x20, #24]
	mvn	w8, w8
	tst	x8, #0x3
	b.ne	LBB130_10
; %bb.4:                                ; %if.then24.i
	mov	x0, x19
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB130_7
	b	LBB130_9
LBB130_5:                               ; %if.then.i
Lloh472:
	adrp	x1, l_.str.21.96@PAGE
Lloh473:
	add	x1, x1, l_.str.21.96@PAGEOFF
	mov	x0, x19
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB130_7
	b	LBB130_9
LBB130_6:                               ; %if.then8.i
	mov	x0, x19
	bl	_halide_error_no_device_interface
	cbz	w0, LBB130_9
LBB130_7:                               ; %cleanup12
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB130_8:                               ; %if.then14.i
	mov	x0, x19
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB130_7
LBB130_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x22, [x20, #8]
LBB130_10:                              ; %if.end
	cbz	x22, LBB130_14
; %bb.11:                               ; %if.then3
	ldr	x8, [x22, #120]
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #24]
	mov	x0, x19
	mov	x1, x20
	blr	x8
	mov	x21, x0
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #8]
	blr	x8
	ldr	x8, [x20]
	cbz	x8, LBB130_13
; %bb.12:                               ; %if.then8
Lloh474:
	adrp	x1, l_.str.22.97@PAGE
Lloh475:
	add	x1, x1, l_.str.22.97@PAGEOFF
	mov	x0, x19
	bl	_halide_print
	bl	_abort
LBB130_13:                              ; %do.end
	cmp	w21, #0
	mov	w8, #-18
	csel	w0, wzr, w8, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB130_14:                              ; %if.end11
	mov	w0, #0
	ldr	x8, [x20, #24]
	and	x8, x8, #0xfffffffffffffffd
	str	x8, [x20, #24]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh472, Lloh473
	.loh AdrpAdd	Lloh474, Lloh475
                                        ; -- End function
	.globl	_halide_device_free_as_destructor ; -- Begin function halide_device_free_as_destructor
	.weak_definition	_halide_device_free_as_destructor
	.p2align	2
_halide_device_free_as_destructor:      ; @halide_device_free_as_destructor
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_halide_device_free
                                        ; -- End function
	.globl	_halide_device_and_host_malloc  ; -- Begin function halide_device_and_host_malloc
	.weak_definition	_halide_device_and_host_malloc
	.p2align	2
_halide_device_and_host_malloc:         ; @halide_device_and_host_malloc
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
	cbz	x1, LBB132_5
; %bb.1:                                ; %if.end.i
	ldp	x9, x8, [x21]
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB132_6
; %bb.2:                                ; %if.end10.i
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB132_8
; %bb.3:                                ; %if.end16.i
	ldr	w9, [x21, #24]
	mvn	w9, w9
	tst	x9, #0x3
	b.ne	LBB132_10
; %bb.4:                                ; %if.then24.i
	mov	x0, x19
	bl	_halide_error_host_and_device_dirty
	mov	x22, x0
	cbnz	w0, LBB132_7
	b	LBB132_9
LBB132_5:                               ; %if.then.i
Lloh476:
	adrp	x1, l_.str.23.98@PAGE
Lloh477:
	add	x1, x1, l_.str.23.98@PAGEOFF
	mov	x0, x19
	bl	_halide_error_buffer_is_null
	mov	x22, x0
	cbnz	w0, LBB132_7
	b	LBB132_9
LBB132_6:                               ; %if.then8.i
	mov	x0, x19
	bl	_halide_error_no_device_interface
	mov	x22, x0
	cbz	w0, LBB132_9
LBB132_7:                               ; %cleanup14
	mov	x0, x22
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB132_8:                               ; %if.then14.i
	mov	x0, x19
	bl	_halide_error_device_interface_no_device
	mov	x22, x0
	cbnz	w0, LBB132_7
LBB132_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x8, [x21, #8]
LBB132_10:                              ; %if.end
	cbz	x8, LBB132_13
; %bb.11:                               ; %if.end
	cmp	x8, x20
	b.eq	LBB132_13
; %bb.12:
	mov	w22, #-42
Lloh478:
	adrp	x1, l_.str.25.99@PAGE
Lloh479:
	add	x1, x1, l_.str.25.99@PAGEOFF
	b	LBB132_15
LBB132_13:                              ; %if.end7
	ldr	x8, [x20, #120]
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x20, #120]
	ldr	x8, [x8, #64]
	mov	x0, x19
	mov	x1, x21
	blr	x8
	mov	x21, x0
	ldr	x8, [x20, #120]
	ldr	x8, [x8, #8]
	blr	x8
	cbz	w21, LBB132_16
; %bb.14:
	mov	w22, #-16
Lloh480:
	adrp	x1, l_.str.26.100@PAGE
Lloh481:
	add	x1, x1, l_.str.26.100@PAGEOFF
LBB132_15:                              ; %cleanup14.sink.split
	mov	x0, x19
	bl	_halide_error
	mov	x0, x22
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB132_16:
	mov	w22, #0
	mov	x0, x22
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh476, Lloh477
	.loh AdrpAdd	Lloh478, Lloh479
	.loh AdrpAdd	Lloh480, Lloh481
                                        ; -- End function
	.globl	_halide_device_and_host_free    ; -- Begin function halide_device_and_host_free
	.weak_definition	_halide_device_and_host_free
	.p2align	2
_halide_device_and_host_free:           ; @halide_device_and_host_free
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x1
	mov	x20, x0
	cbz	x1, LBB133_5
; %bb.1:                                ; %if.end.i
	ldp	x8, x22, [x19]
	cmp	x8, #0
	ccmp	x22, #0, #0, ne
	b.eq	LBB133_6
; %bb.2:                                ; %if.end10.i
	cmp	x22, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB133_8
; %bb.3:                                ; %if.end16.i
	ldr	w8, [x19, #24]
	mvn	w8, w8
	tst	x8, #0x3
	b.ne	LBB133_10
; %bb.4:                                ; %if.then24.i
	mov	x0, x20
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB133_7
	b	LBB133_9
LBB133_5:                               ; %if.then.i
Lloh482:
	adrp	x1, l_.str.27.101@PAGE
Lloh483:
	add	x1, x1, l_.str.27.101@PAGEOFF
	mov	x0, x20
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB133_7
	b	LBB133_9
LBB133_6:                               ; %if.then8.i
	mov	x0, x20
	bl	_halide_error_no_device_interface
	cbz	w0, LBB133_9
LBB133_7:                               ; %cleanup18
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB133_8:                               ; %if.then14.i
	mov	x0, x20
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB133_7
LBB133_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x22, [x19, #8]
LBB133_10:                              ; %if.end
	cbz	x22, LBB133_14
; %bb.11:                               ; %if.then3
	ldr	x8, [x22, #120]
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #72]
	mov	x0, x20
	mov	x1, x19
	blr	x8
	mov	x21, x0
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #8]
	blr	x8
	ldr	x8, [x19]
	cbz	x8, LBB133_13
; %bb.12:                               ; %if.then8
Lloh484:
	adrp	x1, l_.str.28.102@PAGE
Lloh485:
	add	x1, x1, l_.str.28.102@PAGEOFF
	mov	x0, x20
	bl	_halide_print
	bl	_abort
LBB133_13:                              ; %do.end
	cmp	w21, #0
	mov	w8, #-18
	csel	w0, wzr, w8, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB133_14:                              ; %if.else11
	ldr	x1, [x19, #16]
	cbz	x1, LBB133_16
; %bb.15:                               ; %if.then13
	mov	x0, x20
	bl	_halide_free
	str	xzr, [x19, #16]
LBB133_16:                              ; %if.end17
	mov	w0, #0
	ldr	x8, [x19, #24]
	and	x8, x8, #0xfffffffffffffffd
	str	x8, [x19, #24]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh482, Lloh483
	.loh AdrpAdd	Lloh484, Lloh485
                                        ; -- End function
	.globl	_halide_default_device_and_host_malloc ; -- Begin function halide_default_device_and_host_malloc
	.weak_definition	_halide_default_device_and_host_malloc
	.p2align	2
_halide_default_device_and_host_malloc: ; @halide_default_device_and_host_malloc
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x2
	mov	x19, x1
	mov	x20, x0
	cbz	x1, LBB134_5
; %bb.1:                                ; %if.end.i
	ldp	x9, x8, [x19]
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB134_6
; %bb.2:                                ; %if.end10.i
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB134_8
; %bb.3:                                ; %if.end16.i
	ldr	w8, [x19, #24]
	mvn	w8, w8
	tst	x8, #0x3
	b.ne	LBB134_9
; %bb.4:                                ; %if.then24.i
	mov	x0, x20
	bl	_halide_error_host_and_device_dirty
	mov	x22, x0
	cbnz	w0, LBB134_7
	b	LBB134_9
LBB134_5:                               ; %if.then.i
Lloh486:
	adrp	x1, l_.str.29.103@PAGE
Lloh487:
	add	x1, x1, l_.str.29.103@PAGEOFF
	mov	x0, x20
	bl	_halide_error_buffer_is_null
	mov	x22, x0
	cbnz	w0, LBB134_7
	b	LBB134_9
LBB134_6:                               ; %if.then8.i
	mov	x0, x20
	bl	_halide_error_no_device_interface
	mov	x22, x0
	cbz	w0, LBB134_9
LBB134_7:                               ; %cleanup13
	mov	x0, x22
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB134_8:                               ; %if.then14.i
	mov	x0, x20
	bl	_halide_error_device_interface_no_device
	mov	x22, x0
	cbnz	w0, LBB134_7
LBB134_9:                               ; %if.end
	ldr	w8, [x19, #36]
	cmp	w8, #1
	b.lt	LBB134_12
; %bb.10:                               ; %for.body.lr.ph.i.i
	ldr	x9, [x19, #40]
	cmp	w8, #1
	b.ne	LBB134_13
; %bb.11:
	mov	x11, #0
	mov	x10, #0
	b	LBB134_22
LBB134_12:
	mov	w8, #1
	b	LBB134_34
LBB134_13:                              ; %vector.ph
	mov	x10, #0
	mov	x12, #0
	and	x11, x8, #0xfffffffe
	add	x13, x9, #24
	mov	x14, x11
	b	LBB134_15
LBB134_14:                              ; %pred.load.continue6
                                        ;   in Loop: Header=BB134_15 Depth=1
	sub	w17, w17, #1
	sub	w0, w0, #1
	sxtw	x17, w17
	sxtw	x0, w0
	mul	x17, x17, x15
	mul	x0, x0, x16
	cmp	w15, #0
	csel	x15, x17, xzr, gt
	add	x10, x10, x15
	cmp	w16, #0
	csel	x15, x0, xzr, gt
	add	x12, x12, x15
	add	x13, x13, #32
	subs	x14, x14, #2
	b.eq	LBB134_19
LBB134_15:                              ; %vector.body
                                        ; =>This Inner Loop Header: Depth=1
	ldur	w15, [x13, #-16]
                                        ; implicit-def: $w17
	cmp	w15, #1
	b.lt	LBB134_17
; %bb.16:                               ; %pred.load.if
                                        ;   in Loop: Header=BB134_15 Depth=1
	ldur	w17, [x13, #-20]
LBB134_17:                              ; %pred.load.continue
                                        ;   in Loop: Header=BB134_15 Depth=1
	ldr	w16, [x13]
                                        ; implicit-def: $w0
	cmp	w16, #1
	b.lt	LBB134_14
; %bb.18:                               ; %pred.load.if5
                                        ;   in Loop: Header=BB134_15 Depth=1
	ldur	w0, [x13, #-4]
	b	LBB134_14
LBB134_19:                              ; %middle.block
	add	x10, x12, x10
	cmp	x11, x8
	b.ne	LBB134_22
LBB134_20:                              ; %for.body.i12.i.preheader
	cmp	w8, #2
	b.hs	LBB134_26
; %bb.21:
	mov	x11, #0
	mov	x12, #0
	b	LBB134_37
LBB134_22:                              ; %for.body.i.i.preheader
	sub	x12, x8, x11
	add	x11, x9, x11, lsl #4
	add	x11, x11, #8
	b	LBB134_24
LBB134_23:                              ; %if.end.i.i
                                        ;   in Loop: Header=BB134_24 Depth=1
	add	x11, x11, #16
	subs	x12, x12, #1
	b.eq	LBB134_20
LBB134_24:                              ; %for.body.i.i
                                        ; =>This Inner Loop Header: Depth=1
	ldr	w13, [x11]
	cmp	w13, #1
	b.lt	LBB134_23
; %bb.25:                               ; %if.then.i.i
                                        ;   in Loop: Header=BB134_24 Depth=1
	ldursw	x14, [x11, #-4]
	sub	x14, x14, #1
	madd	x10, x14, x13, x10
	b	LBB134_23
LBB134_26:                              ; %vector.ph12
	mov	x12, #0
	mov	x13, #0
	and	x11, x8, #0xfffffffe
	add	x14, x9, #24
	mov	x15, x11
	b	LBB134_28
LBB134_27:                              ; %pred.load.continue25
                                        ;   in Loop: Header=BB134_28 Depth=1
	sub	w0, w0, #1
	sub	w1, w1, #1
	sxtw	x0, w0
	sxtw	x1, w1
	mul	x0, x0, x16
	mul	x1, x1, x17
	cmp	w16, #0
	csel	x16, x0, xzr, lt
	add	x12, x12, x16
	cmp	w17, #0
	csel	x16, x1, xzr, lt
	add	x13, x13, x16
	add	x14, x14, #32
	subs	x15, x15, #2
	b.eq	LBB134_32
LBB134_28:                              ; %vector.body10
                                        ; =>This Inner Loop Header: Depth=1
	ldursw	x16, [x14, #-16]
                                        ; implicit-def: $w0
	tbnz	w16, #31, LBB134_30
; %bb.29:                               ; %pred.load.continue23
                                        ;   in Loop: Header=BB134_28 Depth=1
	ldrsw	x17, [x14]
                                        ; implicit-def: $w1
	tbz	w17, #31, LBB134_27
	b	LBB134_31
LBB134_30:                              ; %pred.load.if22
                                        ;   in Loop: Header=BB134_28 Depth=1
	ldur	w0, [x14, #-20]
	ldrsw	x17, [x14]
                                        ; implicit-def: $w1
	tbz	w17, #31, LBB134_27
LBB134_31:                              ; %pred.load.if24
                                        ;   in Loop: Header=BB134_28 Depth=1
	ldur	w1, [x14, #-4]
	b	LBB134_27
LBB134_32:                              ; %middle.block8
	add	x12, x13, x12
	cmp	x11, x8
	b.ne	LBB134_37
LBB134_33:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit.loopexit
	sub	x8, x10, x12
	add	x8, x8, #1
LBB134_34:                              ; %_ZNK15halide_buffer_t13size_in_bytesEv.exit
	ldrb	w9, [x19, #33]
	add	x9, x9, #7
	lsr	x9, x9, #3
	mul	x1, x9, x8
	mov	x0, x20
	bl	_halide_malloc
	str	x0, [x19, #16]
	cbz	x0, LBB134_41
; %bb.35:                               ; %if.end6
	mov	x0, x20
	mov	x1, x19
	mov	x2, x21
	bl	_halide_device_malloc
	mov	x22, x0
	cbz	w0, LBB134_7
; %bb.36:                               ; %if.then9
	ldr	x1, [x19, #16]
	mov	x0, x20
	bl	_halide_free
	str	xzr, [x19, #16]
	mov	x0, x22
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB134_37:                              ; %for.body.i12.i.preheader1
	sub	x8, x8, x11
	add	x9, x9, x11, lsl #4
	add	x9, x9, #8
	b	LBB134_39
LBB134_38:                              ; %if.end.i22.i
                                        ;   in Loop: Header=BB134_39 Depth=1
	add	x9, x9, #16
	subs	x8, x8, #1
	b.eq	LBB134_33
LBB134_39:                              ; %for.body.i12.i
                                        ; =>This Inner Loop Header: Depth=1
	ldrsw	x11, [x9]
	tbz	w11, #31, LBB134_38
; %bb.40:                               ; %if.then.i18.i
                                        ;   in Loop: Header=BB134_39 Depth=1
	ldursw	x13, [x9, #-4]
	sub	x13, x13, #1
	madd	x12, x13, x11, x12
	b	LBB134_38
LBB134_41:
	mov	w22, #-1
	mov	x0, x22
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh486, Lloh487
                                        ; -- End function
	.globl	_halide_default_device_and_host_free ; -- Begin function halide_default_device_and_host_free
	.weak_definition	_halide_default_device_and_host_free
	.p2align	2
_halide_default_device_and_host_free:   ; @halide_default_device_and_host_free
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x1
	mov	x20, x0
	cbz	x1, LBB135_5
; %bb.1:                                ; %if.end.i
	ldp	x9, x8, [x19]
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB135_6
; %bb.2:                                ; %if.end10.i
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB135_8
; %bb.3:                                ; %if.end16.i
	ldr	w8, [x19, #24]
	mvn	w8, w8
	tst	x8, #0x3
	b.ne	LBB135_9
; %bb.4:                                ; %if.then24.i
	mov	x0, x20
	bl	_halide_error_host_and_device_dirty
	mov	x21, x0
	cbnz	w0, LBB135_7
	b	LBB135_9
LBB135_5:                               ; %if.then.i
Lloh488:
	adrp	x1, l_.str.30.104@PAGE
Lloh489:
	add	x1, x1, l_.str.30.104@PAGEOFF
	mov	x0, x20
	bl	_halide_error_buffer_is_null
	mov	x21, x0
	cbnz	w0, LBB135_7
	b	LBB135_9
LBB135_6:                               ; %if.then8.i
	mov	x0, x20
	bl	_halide_error_no_device_interface
	mov	x21, x0
	cbz	w0, LBB135_9
LBB135_7:                               ; %cleanup
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB135_8:                               ; %if.then14.i
	mov	x0, x20
	bl	_halide_error_device_interface_no_device
	mov	x21, x0
	cbnz	w0, LBB135_7
LBB135_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.split
	mov	x0, x20
	mov	x1, x19
	bl	_halide_device_free
	mov	x21, x0
	ldr	x1, [x19, #16]
	cbz	x1, LBB135_11
; %bb.10:                               ; %if.then2
	mov	x0, x20
	bl	_halide_free
	str	xzr, [x19, #16]
LBB135_11:                              ; %if.end5
	ldr	x8, [x19, #24]
	and	x8, x8, #0xfffffffffffffffc
	str	x8, [x19, #24]
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh488, Lloh489
                                        ; -- End function
	.globl	_halide_device_wrap_native      ; -- Begin function halide_device_wrap_native
	.weak_definition	_halide_device_wrap_native
	.p2align	2
_halide_device_wrap_native:             ; @halide_device_wrap_native
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x19, x3
	mov	x20, x2
	mov	x22, x1
	mov	x21, x0
	cbz	x1, LBB136_5
; %bb.1:                                ; %if.end.i
	ldp	x9, x8, [x22]
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB136_6
; %bb.2:                                ; %if.end10.i
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB136_8
; %bb.3:                                ; %if.end16.i
	ldr	w9, [x22, #24]
	mvn	w9, w9
	tst	x9, #0x3
	b.ne	LBB136_10
; %bb.4:                                ; %if.then24.i
	mov	x0, x21
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB136_7
	b	LBB136_9
LBB136_5:                               ; %if.then.i
Lloh490:
	adrp	x1, l_.str.31.105@PAGE
Lloh491:
	add	x1, x1, l_.str.31.105@PAGEOFF
	mov	x0, x21
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB136_7
	b	LBB136_9
LBB136_6:                               ; %if.then8.i
	mov	x0, x21
	bl	_halide_error_no_device_interface
	cbz	w0, LBB136_9
LBB136_7:                               ; %cleanup12
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB136_8:                               ; %if.then14.i
	mov	x0, x21
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB136_7
LBB136_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x8, [x22, #8]
LBB136_10:                              ; %if.end
	cbz	x8, LBB136_13
; %bb.11:                               ; %if.end
	cmp	x8, x19
	b.eq	LBB136_13
; %bb.12:                               ; %if.then4
Lloh492:
	adrp	x1, l_.str.32.106@PAGE
Lloh493:
	add	x1, x1, l_.str.32.106@PAGEOFF
	mov	x0, x21
	bl	_halide_error
	mov	w0, #-42
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB136_13:                              ; %if.end5
	ldr	x8, [x19, #120]
	ldr	x8, [x8]
	blr	x8
	str	x19, [x22, #8]
	ldr	x8, [x19, #120]
	ldr	x8, [x8, #112]
	mov	x0, x21
	mov	x1, x22
	mov	x2, x20
	blr	x8
	mov	x20, x0
	ldr	x8, [x19, #120]
	ldr	x8, [x8, #8]
	blr	x8
	cmp	w20, #0
	mov	w8, #-16
	csel	w0, wzr, w8, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh490, Lloh491
	.loh AdrpAdd	Lloh492, Lloh493
                                        ; -- End function
	.globl	_halide_device_detach_native    ; -- Begin function halide_device_detach_native
	.weak_definition	_halide_device_detach_native
	.p2align	2
_halide_device_detach_native:           ; @halide_device_detach_native
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x20, x1
	mov	x19, x0
	cbz	x1, LBB137_5
; %bb.1:                                ; %if.end.i
	ldp	x8, x22, [x20]
	cmp	x8, #0
	ccmp	x22, #0, #0, ne
	b.eq	LBB137_6
; %bb.2:                                ; %if.end10.i
	cmp	x22, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB137_8
; %bb.3:                                ; %if.end16.i
	ldr	w8, [x20, #24]
	mvn	w8, w8
	tst	x8, #0x3
	b.ne	LBB137_10
; %bb.4:                                ; %if.then24.i
	mov	x0, x19
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB137_7
	b	LBB137_9
LBB137_5:                               ; %if.then.i
Lloh494:
	adrp	x1, l_.str.33.107@PAGE
Lloh495:
	add	x1, x1, l_.str.33.107@PAGEOFF
	mov	x0, x19
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB137_7
	b	LBB137_9
LBB137_6:                               ; %if.then8.i
	mov	x0, x19
	bl	_halide_error_no_device_interface
	cbz	w0, LBB137_9
LBB137_7:                               ; %cleanup
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB137_8:                               ; %if.then14.i
	mov	x0, x19
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB137_7
LBB137_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x22, [x20, #8]
LBB137_10:                              ; %if.end
	cbz	x22, LBB137_14
; %bb.11:                               ; %if.then3
	ldr	x8, [x22, #120]
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #120]
	mov	x0, x19
	mov	x1, x20
	blr	x8
	mov	x21, x0
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #8]
	blr	x8
	ldr	x8, [x20]
	cbz	x8, LBB137_13
; %bb.12:                               ; %if.then8
Lloh496:
	adrp	x1, l_.str.34.108@PAGE
Lloh497:
	add	x1, x1, l_.str.34.108@PAGEOFF
	mov	x0, x19
	bl	_halide_print
	bl	_abort
LBB137_13:                              ; %do.end
	cmp	w21, #0
	mov	w8, #-33
	csel	w0, wzr, w8, eq
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB137_14:
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh494, Lloh495
	.loh AdrpAdd	Lloh496, Lloh497
                                        ; -- End function
	.globl	_halide_default_device_wrap_native ; -- Begin function halide_default_device_wrap_native
	.weak_definition	_halide_default_device_wrap_native
	.p2align	2
_halide_default_device_wrap_native:     ; @halide_default_device_wrap_native
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	ldr	x8, [x1]
	cbz	x8, LBB138_2
; %bb.1:
	mov	w0, #-32
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB138_2:                               ; %if.end
	mov	x19, x2
	mov	x20, x1
	ldr	x8, [x1, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8]
	blr	x8
	mov	w0, #0
	str	x19, [x20]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_default_device_detach_native ; -- Begin function halide_default_device_detach_native
	.weak_definition	_halide_default_device_detach_native
	.p2align	2
_halide_default_device_detach_native:   ; @halide_default_device_detach_native
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x1
	cbz	x1, LBB139_5
; %bb.1:                                ; %if.end.i
	ldp	x8, x9, [x19]
	cmp	x8, #0
	ccmp	x9, #0, #0, ne
	b.eq	LBB139_6
; %bb.2:                                ; %if.end10.i
	cmp	x9, #0
	ccmp	x8, #0, #0, ne
	b.eq	LBB139_8
; %bb.3:                                ; %if.end16.i
	ldr	w9, [x19, #24]
	mvn	w9, w9
	tst	x9, #0x3
	b.ne	LBB139_10
; %bb.4:                                ; %if.then24.i
	bl	_halide_error_host_and_device_dirty
	cbnz	w0, LBB139_7
	b	LBB139_9
LBB139_5:                               ; %if.then.i
Lloh498:
	adrp	x1, l_.str.35@PAGE
Lloh499:
	add	x1, x1, l_.str.35@PAGEOFF
	bl	_halide_error_buffer_is_null
	cbnz	w0, LBB139_7
	b	LBB139_9
LBB139_6:                               ; %if.then8.i
	bl	_halide_error_no_device_interface
	cbz	w0, LBB139_9
LBB139_7:                               ; %cleanup
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB139_8:                               ; %if.then14.i
	bl	_halide_error_device_interface_no_device
	cbnz	w0, LBB139_7
LBB139_9:                               ; %_ZN12_GLOBAL__N_126debug_log_and_validate_bufEPvPK15halide_buffer_tPKc.exit.if.end_crit_edge
	ldr	x8, [x19]
LBB139_10:                              ; %if.end
	cbz	x8, LBB139_12
; %bb.11:                               ; %if.end3
	ldr	x8, [x19, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #8]
	blr	x8
	mov	w0, #0
	stp	xzr, xzr, [x19]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
LBB139_12:
	mov	w0, #0
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh498, Lloh499
                                        ; -- End function
	.globl	_halide_device_and_host_free_as_destructor ; -- Begin function halide_device_and_host_free_as_destructor
	.weak_definition	_halide_device_and_host_free_as_destructor
	.p2align	2
_halide_device_and_host_free_as_destructor: ; @halide_device_and_host_free_as_destructor
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	_halide_device_and_host_free
                                        ; -- End function
	.globl	_halide_device_host_nop_free    ; -- Begin function halide_device_host_nop_free
	.weak_definition	_halide_device_host_nop_free
	.p2align	2
_halide_device_host_nop_free:           ; @halide_device_host_nop_free
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_default_buffer_copy     ; -- Begin function halide_default_buffer_copy
	.weak_definition	_halide_default_buffer_copy
	.p2align	2
_halide_default_buffer_copy:            ; @halide_default_buffer_copy
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #-39
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_buffer_copy_already_locked ; -- Begin function halide_buffer_copy_already_locked
	.weak_definition	_halide_buffer_copy_already_locked
	.p2align	2
_halide_buffer_copy_already_locked:     ; @halide_buffer_copy_already_locked
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	sub	sp, sp, #416
	mov	x19, x3
	mov	x20, x2
	mov	x21, x1
	mov	x22, x0
	cbz	x2, LBB143_3
; %bb.1:                                ; %land.lhs.true
	ldr	x8, [x19, #8]
	cmp	x8, #0
	ccmp	x8, x20, #4, ne
	b.ne	LBB143_7
; %bb.2:                                ; %land.lhs.true5
	ldr	x8, [x19]
	cbz	x8, LBB143_12
LBB143_3:                               ; %if.end13
	ldr	x9, [x21]
	ldr	x8, [x21, #16]
	cbz	x9, LBB143_8
; %bb.4:                                ; %land.rhs
	cbz	x8, LBB143_11
; %bb.5:                                ; %land.end.thread268
	ldr	x8, [x21, #24]
	and	w23, w8, #0x1
	mov	w24, #0
	tbnz	w8, #1, LBB143_10
LBB143_6:
	mov	w25, #0
	cmp	x20, #0
	cset	w27, ne
	ldr	x26, [x19, #16]
	cbz	x20, LBB143_14
	b	LBB143_16
LBB143_7:                               ; %if.then
Lloh500:
	adrp	x1, l_.str.41@PAGE
Lloh501:
	add	x1, x1, l_.str.41@PAGEOFF
	mov	x0, x22
	bl	_halide_error
	mov	w0, #-42
	b	LBB143_39
LBB143_8:                               ; %land.end
	cbz	x8, LBB143_13
; %bb.9:                                ; %land.end.land.rhs26_crit_edge
	ldr	x8, [x21, #24]
	mov	w23, #1
	mov	w24, #0
	tbz	w8, #1, LBB143_6
LBB143_10:                              ; %lor.rhs28
	ldr	x8, [x21, #8]
	cmp	x8, #0
	cset	w25, ne
	cmp	x20, #0
	cset	w27, ne
	ldr	x26, [x19, #16]
	cbz	x20, LBB143_14
	b	LBB143_16
LBB143_11:
	mov	w23, #0
	mov	w24, #1
	mov	w25, #1
	cmp	x20, #0
	cset	w27, ne
	ldr	x26, [x19, #16]
	cbz	x20, LBB143_14
	b	LBB143_16
LBB143_12:                              ; %if.then7
	mov	x0, x22
	mov	x1, x19
	mov	x2, x20
	bl	_halide_device_malloc
	cbnz	w0, LBB143_39
	b	LBB143_3
LBB143_13:
	mov	w24, #1
	mov	w23, #1
	mov	w25, #1
	cmp	x20, #0
	cset	w27, ne
	ldr	x26, [x19, #16]
	cbnz	x20, LBB143_16
LBB143_14:                              ; %land.end32
	cbnz	x26, LBB143_16
; %bb.15:
	mov	w0, #-34
	b	LBB143_39
LBB143_16:                              ; %if.end41
	cmp	x20, #0
	cset	w8, eq
	orr	w8, w8, w23
	tbnz	w8, #0, LBB143_18
; %bb.17:                               ; %if.end49
	ldr	x8, [x20, #120]
	ldr	x8, [x8, #80]
	mov	x0, x22
	mov	x1, x21
	mov	x2, x20
	mov	x3, x19
	blr	x8
	cmn	w0, #42
	b.ne	LBB143_32
LBB143_18:                              ; %if.then51
	cmp	x26, #0
	cset	w8, eq
	and	w8, w24, w8
	tbz	w8, #0, LBB143_20
LBB143_19:
	mov	w0, #-42
	b	LBB143_39
LBB143_20:                              ; %if.end58
	orr	w8, w27, w25
	tbz	w8, #0, LBB143_26
; %bb.21:                               ; %if.else
	orr	w8, w23, w27
	tbz	w8, #0, LBB143_27
; %bb.22:                               ; %if.else81
	cmp	x26, #0
	cset	w8, eq
	orr	w8, w23, w8
	tbz	w8, #0, LBB143_30
; %bb.23:                               ; %if.else98
	cbz	x20, LBB143_19
; %bb.24:                               ; %if.then100
	mov	x0, x22
	mov	x1, x21
	bl	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	cbnz	w0, LBB143_39
; %bb.25:                               ; %if.then105
	ldr	x8, [x20, #120]
	ldr	x8, [x8, #80]
	mov	x0, x22
	mov	x1, x21
	mov	x2, x20
	mov	x3, x19
	blr	x8
	b	LBB143_32
LBB143_26:                              ; %if.end117.thread262
	mov	x8, sp
	mov	x0, x21
	mov	w1, #1
	mov	x2, x19
	mov	w3, #1
	bl	__ZN6Halide7Runtime8Internal16make_buffer_copyEPK15halide_buffer_tbS4_b
	mov	x0, sp
	mov	x1, x22
	bl	__ZN6Halide7Runtime8Internal11copy_memoryERKNS1_11device_copyEPv
	b	LBB143_33
LBB143_27:                              ; %if.then66
	ldr	x8, [x21, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #80]
	mov	x0, x22
	mov	x1, x21
	mov	x2, #0
	mov	x3, x19
	blr	x8
	cmn	w0, #42
	b.ne	LBB143_32
; %bb.28:                               ; %if.then74
	mov	x0, x22
	mov	x1, x21
	bl	__ZN6Halide7Runtime8Internal27copy_to_host_already_lockedEPvP15halide_buffer_t
	cbnz	w0, LBB143_39
; %bb.29:                               ; %if.then77
	mov	x0, x22
	mov	x1, x21
	mov	x2, #0
	mov	x3, x19
	bl	_halide_buffer_copy_already_locked
	b	LBB143_32
LBB143_30:                              ; %if.then85
	ldr	x8, [x21, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #80]
	mov	x0, x22
	mov	x1, x21
	mov	x2, #0
	mov	x3, x19
	blr	x8
	cbnz	w0, LBB143_39
; %bb.31:                               ; %if.then95
	ldr	x8, [x19, #24]
	orr	x8, x8, #0x1
	str	x8, [x19, #24]
	mov	x0, x22
	mov	x1, x19
	mov	x2, x20
	bl	_copy_to_device_already_locked
LBB143_32:                              ; %if.end117
	cbnz	w0, LBB143_39
LBB143_33:                              ; %land.lhs.true126
	cmp	x19, x21
	b.eq	LBB143_36
; %bb.34:                               ; %if.then128
	ldr	x8, [x19, #24]
	and	x8, x8, #0xfffffffffffffffc
	mov	w0, #0
	cbz	x20, LBB143_37
; %bb.35:                               ; %if.then130
	orr	x8, x8, #0x2
	b	LBB143_38
LBB143_36:
	mov	w0, #0
	b	LBB143_39
LBB143_37:                              ; %if.else133
	orr	x8, x8, #0x1
LBB143_38:                              ; %cleanup143
	str	x8, [x19, #24]
LBB143_39:                              ; %cleanup143
	add	sp, sp, #416
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh500, Lloh501
                                        ; -- End function
	.globl	_halide_buffer_copy             ; -- Begin function halide_buffer_copy
	.weak_definition	_halide_buffer_copy
	.p2align	2
_halide_buffer_copy:                    ; @halide_buffer_copy
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x3
	mov	x20, x2
	mov	x19, x1
	mov	x22, x0
Lloh502:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh503:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_lock
	cbz	x20, LBB144_2
; %bb.1:                                ; %if.then
	ldr	x8, [x20, #120]
	ldr	x8, [x8]
	blr	x8
LBB144_2:                               ; %if.end
	ldr	x8, [x19, #8]
	cbz	x8, LBB144_4
; %bb.3:                                ; %if.then12
	ldr	x8, [x8, #120]
	ldr	x8, [x8]
	blr	x8
LBB144_4:                               ; %if.end16
	mov	x0, x22
	mov	x1, x19
	mov	x2, x20
	mov	x3, x21
	bl	_halide_buffer_copy_already_locked
	mov	x21, x0
	cbz	x20, LBB144_6
; %bb.5:                                ; %if.then18
	ldr	x8, [x20, #120]
	ldr	x8, [x8, #8]
	blr	x8
LBB144_6:                               ; %if.end20
	ldr	x8, [x19, #8]
	cbz	x8, LBB144_8
; %bb.7:                                ; %if.then23
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #8]
	blr	x8
LBB144_8:                               ; %if.end27
Lloh504:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh505:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	x0, x21
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh502, Lloh503
	.loh AdrpLdrGot	Lloh504, Lloh505
                                        ; -- End function
	.globl	_halide_default_device_crop     ; -- Begin function halide_default_device_crop
	.weak_definition	_halide_default_device_crop
	.p2align	2
_halide_default_device_crop:            ; @halide_default_device_crop
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh506:
	adrp	x1, l_.str.58@PAGE
Lloh507:
	add	x1, x1, l_.str.58@PAGEOFF
	bl	_halide_error
	mov	w0, #-40
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh506, Lloh507
                                        ; -- End function
	.globl	_halide_default_device_slice    ; -- Begin function halide_default_device_slice
	.weak_definition	_halide_default_device_slice
	.p2align	2
_halide_default_device_slice:           ; @halide_default_device_slice
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh508:
	adrp	x1, l_.str.59@PAGE
Lloh509:
	add	x1, x1, l_.str.59@PAGEOFF
	bl	_halide_error
	mov	w0, #-40
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh508, Lloh509
                                        ; -- End function
	.globl	_halide_device_crop             ; -- Begin function halide_device_crop
	.weak_definition	_halide_device_crop
	.p2align	2
_halide_device_crop:                    ; @halide_device_crop
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x20, x2
	mov	x21, x1
	mov	x19, x0
Lloh510:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh511:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_lock
	ldr	x8, [x21]
	cbz	x8, LBB147_3
; %bb.1:                                ; %if.end
	ldr	x8, [x20]
	cbz	x8, LBB147_4
; %bb.2:                                ; %if.then3
Lloh512:
	adrp	x1, l_.str.60@PAGE
Lloh513:
	add	x1, x1, l_.str.60@PAGEOFF
	b	LBB147_7
LBB147_3:
	mov	w19, #0
	b	LBB147_8
LBB147_4:                               ; %if.end4
	ldr	w8, [x21, #36]
	ldr	w9, [x20, #36]
	cmp	w8, w9
	b.ne	LBB147_6
; %bb.5:                                ; %if.end7
	ldr	x8, [x21, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x21, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #88]
	mov	x0, x19
	mov	x1, x21
	mov	x2, x20
	blr	x8
	mov	x19, x0
	b	LBB147_8
LBB147_6:                               ; %if.then6
Lloh514:
	adrp	x1, l_.str.61@PAGE
Lloh515:
	add	x1, x1, l_.str.61@PAGEOFF
LBB147_7:                               ; %cleanup
	mov	x0, x19
	bl	_halide_error
	mov	w19, #-41
LBB147_8:                               ; %cleanup
Lloh516:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh517:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	x0, x19
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh510, Lloh511
	.loh AdrpAdd	Lloh512, Lloh513
	.loh AdrpAdd	Lloh514, Lloh515
	.loh AdrpLdrGot	Lloh516, Lloh517
                                        ; -- End function
	.globl	_halide_device_slice            ; -- Begin function halide_device_slice
	.weak_definition	_halide_device_slice
	.p2align	2
_halide_device_slice:                   ; @halide_device_slice
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x19, x4
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov	x20, x0
Lloh518:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh519:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_lock
	ldr	x8, [x23]
	cbz	x8, LBB148_3
; %bb.1:                                ; %if.end
	ldr	x8, [x19]
	cbz	x8, LBB148_4
; %bb.2:                                ; %if.then3
Lloh520:
	adrp	x1, l_.str.60@PAGE
Lloh521:
	add	x1, x1, l_.str.60@PAGEOFF
	b	LBB148_7
LBB148_3:
	mov	w19, #0
	b	LBB148_8
LBB148_4:                               ; %if.end4
	ldr	w8, [x23, #36]
	ldr	w9, [x19, #36]
	add	w9, w9, #1
	cmp	w8, w9
	b.ne	LBB148_6
; %bb.5:                                ; %if.end7
	ldr	x8, [x23, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8]
	blr	x8
	ldr	x8, [x23, #8]
	ldr	x8, [x8, #120]
	ldr	x8, [x8, #96]
	mov	x0, x20
	mov	x1, x23
	mov	x2, x22
	mov	x3, x21
	mov	x4, x19
	blr	x8
	mov	x19, x0
	b	LBB148_8
LBB148_6:                               ; %if.then6
Lloh522:
	adrp	x1, l_.str.64@PAGE
Lloh523:
	add	x1, x1, l_.str.64@PAGEOFF
LBB148_7:                               ; %cleanup
	mov	x0, x20
	bl	_halide_error
	mov	w19, #-41
LBB148_8:                               ; %cleanup
Lloh524:
	adrp	x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh525:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh518, Lloh519
	.loh AdrpAdd	Lloh520, Lloh521
	.loh AdrpAdd	Lloh522, Lloh523
	.loh AdrpLdrGot	Lloh524, Lloh525
                                        ; -- End function
	.globl	_halide_default_device_release_crop ; -- Begin function halide_default_device_release_crop
	.weak_definition	_halide_default_device_release_crop
	.p2align	2
_halide_default_device_release_crop:    ; @halide_default_device_release_crop
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldr	x8, [x1]
	cbz	x8, LBB149_2
; %bb.1:                                ; %if.end
Lloh526:
	adrp	x1, l_.str.58@PAGE
Lloh527:
	add	x1, x1, l_.str.58@PAGEOFF
	bl	_halide_error
	mov	w0, #-40
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB149_2:
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh526, Lloh527
                                        ; -- End function
	.globl	_halide_device_release_crop     ; -- Begin function halide_device_release_crop
	.weak_definition	_halide_device_release_crop
	.p2align	2
_halide_device_release_crop:            ; @halide_device_release_crop
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	ldr	x8, [x1]
	cbz	x8, LBB150_2
; %bb.1:                                ; %if.then
	mov	x19, x1
	mov	x20, x0
Lloh528:
	adrp	x21, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGE
Lloh529:
	ldr	x21, [x21, __ZN6Halide7Runtime8Internal17device_copy_mutexE@GOTPAGEOFF]
	mov	x0, x21
	bl	_halide_mutex_lock
	ldr	x22, [x19, #8]
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #104]
	mov	x0, x20
	mov	x1, x19
	blr	x8
	mov	x20, x0
	str	xzr, [x19]
	ldr	x8, [x22, #120]
	ldr	x8, [x8, #8]
	blr	x8
	str	xzr, [x19, #8]
	mov	x0, x21
	bl	_halide_mutex_unlock
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB150_2:                               ; %return
	mov	w0, #0
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh528, Lloh529
                                        ; -- End function
	.globl	_halide_float16_bits_to_float   ; -- Begin function halide_float16_bits_to_float
	.weak_definition	_halide_float16_bits_to_float
	.p2align	2
_halide_float16_bits_to_float:          ; @halide_float16_bits_to_float
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ubfx	w9, w0, #10, #5
	ands	w8, w0, #0x3ff
	b.eq	LBB151_3
; %bb.1:                                ; %entry
	cbnz	w9, LBB151_3
; %bb.2:                                ; %if.then
	clz	w10, w8
	eor	w9, w10, #0x1f
	mov	w11, #1
	lsl	w11, w11, w9
	bic	w8, w8, w11
	mov	w11, #23
	sub	w9, w11, w9
	lsl	w9, w8, w9
	mov	w8, #1124073472
	sub	w8, w8, w10, lsl #23
	lsr	w10, w0, #15
	bfi	w8, w10, #31, #1
	orr	w8, w8, w9
	fmov	s0, w8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB151_3:                               ; %if.else
	lsl	w8, w8, #13
	mov	w10, #2139095040
	cmp	w9, #31
	mov	w11, #939524096
	add	w11, w11, w9, lsl #23
	csel	w10, w10, w11, eq
	cmp	w9, #0
	csel	w9, wzr, w10, eq
	lsr	w10, w0, #15
	bfi	w8, w10, #31, #1
	orr	w8, w8, w9
	fmov	s0, w8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_float16_bits_to_double  ; -- Begin function halide_float16_bits_to_double
	.weak_definition	_halide_float16_bits_to_double
	.p2align	2
_halide_float16_bits_to_double:         ; @halide_float16_bits_to_double
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	bl	_halide_float16_bits_to_float
	fcvt	d0, s0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_error_bounds_inference_call_failed ; -- Begin function halide_error_bounds_inference_call_failed
	.weak_definition	_halide_error_bounds_inference_call_failed
	.p2align	2
_halide_error_bounds_inference_call_failed: ; @halide_error_bounds_inference_call_failed
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x19, x2
	mov	x22, x1
	mov	x20, x0
	mov	w0, #1024
	bl	_malloc
	mov	x21, x0
	cbz	x0, LBB153_2
; %bb.1:                                ; %if.then6.i
	add	x23, x21, #1023
	strb	wzr, [x21, #1023]
Lloh530:
	adrp	x2, l_.str.111@PAGE
Lloh531:
	add	x2, x2, l_.str.111@PAGEOFF
	mov	x0, x21
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB153_3
LBB153_2:                               ; %entry.split
Lloh532:
	adrp	x2, l_.str.111@PAGE
Lloh533:
	add	x2, x2, l_.str.111@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB153_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh534:
	adrp	x2, l_.str.1.112@PAGE
Lloh535:
	add	x2, x2, l_.str.1.112@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w19
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	x21, LBB153_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x21
	add	x2, x8, #1
	mov	x0, x20
	mov	x1, x21
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x21
	b	LBB153_6
LBB153_5:
Lloh536:
	adrp	x1, l_.str.29.163@PAGE
Lloh537:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB153_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x20
	bl	_halide_error
	mov	x0, x21
	bl	_free
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh530, Lloh531
	.loh AdrpAdd	Lloh532, Lloh533
	.loh AdrpAdd	Lloh534, Lloh535
	.loh AdrpAdd	Lloh536, Lloh537
                                        ; -- End function
	.globl	_halide_error_extern_stage_failed ; -- Begin function halide_error_extern_stage_failed
	.weak_definition	_halide_error_extern_stage_failed
	.p2align	2
_halide_error_extern_stage_failed:      ; @halide_error_extern_stage_failed
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x19, x2
	mov	x22, x1
	mov	x20, x0
	mov	w0, #1024
	bl	_malloc
	mov	x21, x0
	cbz	x0, LBB154_2
; %bb.1:                                ; %if.then6.i
	add	x23, x21, #1023
	strb	wzr, [x21, #1023]
Lloh538:
	adrp	x2, l_.str.2.113@PAGE
Lloh539:
	add	x2, x2, l_.str.2.113@PAGEOFF
	mov	x0, x21
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB154_3
LBB154_2:                               ; %entry.split
Lloh540:
	adrp	x2, l_.str.2.113@PAGE
Lloh541:
	add	x2, x2, l_.str.2.113@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB154_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh542:
	adrp	x2, l_.str.1.112@PAGE
Lloh543:
	add	x2, x2, l_.str.1.112@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w19
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	x21, LBB154_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x21
	add	x2, x8, #1
	mov	x0, x20
	mov	x1, x21
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x21
	b	LBB154_6
LBB154_5:
Lloh544:
	adrp	x1, l_.str.29.163@PAGE
Lloh545:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB154_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x20
	bl	_halide_error
	mov	x0, x21
	bl	_free
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh538, Lloh539
	.loh AdrpAdd	Lloh540, Lloh541
	.loh AdrpAdd	Lloh542, Lloh543
	.loh AdrpAdd	Lloh544, Lloh545
                                        ; -- End function
	.globl	_halide_error_explicit_bounds_too_small ; -- Begin function halide_error_explicit_bounds_too_small
	.weak_definition	_halide_error_explicit_bounds_too_small
	.p2align	2
_halide_error_explicit_bounds_too_small: ; @halide_error_explicit_bounds_too_small
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	x21, x6
	mov	x22, x5
	mov	x24, x4
	mov	x25, x3
	mov	x27, x2
	mov	x26, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB155_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh546:
	adrp	x2, l_.str.3.114@PAGE
Lloh547:
	add	x2, x2, l_.str.3.114@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB155_3
LBB155_2:                               ; %entry.split
Lloh548:
	adrp	x2, l_.str.3.114@PAGE
Lloh549:
	add	x2, x2, l_.str.3.114@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB155_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x27
	bl	_halide_string_to_string
Lloh550:
	adrp	x2, l_.str.4.115@PAGE
Lloh551:
	add	x2, x2, l_.str.4.115@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x26
	bl	_halide_string_to_string
Lloh552:
	adrp	x2, l_.str.5.116@PAGE
Lloh553:
	add	x2, x2, l_.str.5.116@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w25
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh554:
	adrp	x25, l_.str.6.117@PAGE
Lloh555:
	add	x25, x25, l_.str.6.117@PAGEOFF
	mov	x1, x23
	mov	x2, x25
	bl	_halide_string_to_string
	sxtw	x2, w24
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh556:
	adrp	x2, l_.str.7.118@PAGE
Lloh557:
	add	x2, x2, l_.str.7.118@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w22
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x23
	mov	x2, x25
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh558:
	adrp	x2, l_.str.8.119@PAGE
Lloh559:
	add	x2, x2, l_.str.8.119@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	cbz	x20, LBB155_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB155_6
LBB155_5:
Lloh560:
	adrp	x1, l_.str.29.163@PAGE
Lloh561:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB155_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-2
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh546, Lloh547
	.loh AdrpAdd	Lloh548, Lloh549
	.loh AdrpAdd	Lloh558, Lloh559
	.loh AdrpAdd	Lloh556, Lloh557
	.loh AdrpAdd	Lloh554, Lloh555
	.loh AdrpAdd	Lloh552, Lloh553
	.loh AdrpAdd	Lloh550, Lloh551
	.loh AdrpAdd	Lloh560, Lloh561
                                        ; -- End function
	.globl	_halide_error_bad_type          ; -- Begin function halide_error_bad_type
	.weak_definition	_halide_error_bad_type
	.p2align	2
_halide_error_bad_type:                 ; @halide_error_bad_type
; %bb.0:                                ; %entry
	sub	sp, sp, #80
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x21, x1
	mov	x19, x0
	stp	w3, w2, [sp, #24]
	str	wzr, [sp, #16]
	str	wzr, [sp, #8]
	add	x0, sp, #16
	add	x1, sp, #24
	mov	w2, #4
	bl	_memcpy
	add	x0, sp, #8
	add	x1, sp, #28
	mov	w2, #4
	bl	_memcpy
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB156_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
	mov	x0, x20
	mov	x1, x22
	mov	x2, x21
	bl	_halide_string_to_string
	b	LBB156_3
LBB156_2:                               ; %entry.split
	mov	x1, #0
	mov	x2, x21
	bl	_halide_string_to_string
	mov	x22, #0
LBB156_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
Lloh562:
	adrp	x2, l_.str.9.120@PAGE
Lloh563:
	add	x2, x2, l_.str.9.120@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	add	x2, sp, #16
	mov	x1, x22
	bl	_halide_type_to_string
Lloh564:
	adrp	x2, l_.str.10.121@PAGE
Lloh565:
	add	x2, x2, l_.str.10.121@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	add	x2, sp, #8
	mov	x1, x22
	bl	_halide_type_to_string
	cbz	x20, LBB156_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB156_6
LBB156_5:
Lloh566:
	adrp	x1, l_.str.29.163@PAGE
Lloh567:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB156_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-3
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.loh AdrpAdd	Lloh564, Lloh565
	.loh AdrpAdd	Lloh562, Lloh563
	.loh AdrpAdd	Lloh566, Lloh567
                                        ; -- End function
	.globl	_halide_error_bad_dimensions    ; -- Begin function halide_error_bad_dimensions
	.weak_definition	_halide_error_bad_dimensions
	.p2align	2
_halide_error_bad_dimensions:           ; @halide_error_bad_dimensions
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x23, x3
	mov	x21, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB157_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
	mov	x0, x20
	mov	x1, x22
	mov	x2, x24
	bl	_halide_string_to_string
	b	LBB157_3
LBB157_2:                               ; %entry.split
	mov	x1, #0
	mov	x2, x24
	bl	_halide_string_to_string
	mov	x22, #0
LBB157_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
Lloh568:
	adrp	x2, l_.str.11.122@PAGE
Lloh569:
	add	x2, x2, l_.str.11.122@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w23
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh570:
	adrp	x2, l_.str.12.123@PAGE
Lloh571:
	add	x2, x2, l_.str.12.123@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh572:
	adrp	x2, l_.str.13.124@PAGE
Lloh573:
	add	x2, x2, l_.str.13.124@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	cbz	x20, LBB157_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB157_6
LBB157_5:
Lloh574:
	adrp	x1, l_.str.29.163@PAGE
Lloh575:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB157_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-43
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh572, Lloh573
	.loh AdrpAdd	Lloh570, Lloh571
	.loh AdrpAdd	Lloh568, Lloh569
	.loh AdrpAdd	Lloh574, Lloh575
                                        ; -- End function
	.globl	_halide_error_access_out_of_bounds ; -- Begin function halide_error_access_out_of_bounds
	.weak_definition	_halide_error_access_out_of_bounds
	.p2align	2
_halide_error_access_out_of_bounds:     ; @halide_error_access_out_of_bounds
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x21, x2
	mov	x26, x1
	mov	x19, x0
	cmp	w3, w5
	b.ge	LBB158_3
; %bb.1:                                ; %if.then
	mov	x23, x5
	mov	x25, x3
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB158_6
; %bb.2:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
	mov	x0, x20
	mov	x1, x22
	mov	x2, x26
	bl	_halide_string_to_string
	b	LBB158_7
LBB158_3:                               ; %if.else
	mov	x22, x6
	mov	x24, x4
	cmp	w4, w6
	b.le	LBB158_13
; %bb.4:                                ; %if.then8
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB158_9
; %bb.5:                                ; %if.then6.i59
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
	mov	x0, x20
	mov	x1, x23
	mov	x2, x26
	bl	_halide_string_to_string
	b	LBB158_10
LBB158_6:                               ; %if.then.split
	mov	x1, #0
	mov	x2, x26
	bl	_halide_string_to_string
	mov	x22, #0
LBB158_7:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
Lloh576:
	adrp	x2, l_.str.14.125@PAGE
Lloh577:
	add	x2, x2, l_.str.14.125@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w25
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh578:
	adrp	x2, l_.str.15.126@PAGE
Lloh579:
	add	x2, x2, l_.str.15.126@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w23
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh580:
	adrp	x2, l_.str.16.127@PAGE
Lloh581:
	add	x2, x2, l_.str.16.127@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	x20, LBB158_11
LBB158_8:                               ; %if.end17.sink.split.sink.split
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x21, x20
	b	LBB158_12
LBB158_9:                               ; %if.then8.split
	mov	x1, #0
	mov	x2, x26
	bl	_halide_string_to_string
	mov	x23, #0
LBB158_10:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit62
Lloh582:
	adrp	x2, l_.str.14.125@PAGE
Lloh583:
	add	x2, x2, l_.str.14.125@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w24
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh584:
	adrp	x2, l_.str.17.128@PAGE
Lloh585:
	add	x2, x2, l_.str.17.128@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w22
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh586:
	adrp	x2, l_.str.16.127@PAGE
Lloh587:
	add	x2, x2, l_.str.16.127@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
                                        ; kill: def $w21 killed $w21 killed $x21 def $x21
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	cbnz	x20, LBB158_8
LBB158_11:
	mov	x21, #0
Lloh588:
	adrp	x20, l_.str.29.163@PAGE
Lloh589:
	add	x20, x20, l_.str.29.163@PAGEOFF
LBB158_12:                              ; %if.end17.sink.split
	mov	x0, x19
	mov	x1, x20
	bl	_halide_error
	mov	x0, x21
	bl	_free
LBB158_13:                              ; %if.end17
	mov	w0, #-4
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh580, Lloh581
	.loh AdrpAdd	Lloh578, Lloh579
	.loh AdrpAdd	Lloh576, Lloh577
	.loh AdrpAdd	Lloh586, Lloh587
	.loh AdrpAdd	Lloh584, Lloh585
	.loh AdrpAdd	Lloh582, Lloh583
	.loh AdrpAdd	Lloh588, Lloh589
                                        ; -- End function
	.globl	_halide_error_buffer_allocation_too_large ; -- Begin function halide_error_buffer_allocation_too_large
	.weak_definition	_halide_error_buffer_allocation_too_large
	.p2align	2
_halide_error_buffer_allocation_too_large: ; @halide_error_buffer_allocation_too_large
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB159_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh590:
	adrp	x2, l_.str.18.129@PAGE
Lloh591:
	add	x2, x2, l_.str.18.129@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB159_3
LBB159_2:                               ; %entry.split
Lloh592:
	adrp	x2, l_.str.18.129@PAGE
Lloh593:
	add	x2, x2, l_.str.18.129@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB159_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh594:
	adrp	x2, l_.str.19.130@PAGE
Lloh595:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	mov	w3, #1
	bl	_halide_uint64_to_string
Lloh596:
	adrp	x2, l_.str.20.131@PAGE
Lloh597:
	add	x2, x2, l_.str.20.131@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	mov	w3, #1
	bl	_halide_uint64_to_string
	cbz	x20, LBB159_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB159_6
LBB159_5:
Lloh598:
	adrp	x1, l_.str.29.163@PAGE
Lloh599:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB159_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-5
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh590, Lloh591
	.loh AdrpAdd	Lloh592, Lloh593
	.loh AdrpAdd	Lloh596, Lloh597
	.loh AdrpAdd	Lloh594, Lloh595
	.loh AdrpAdd	Lloh598, Lloh599
                                        ; -- End function
	.globl	_halide_error_buffer_extents_negative ; -- Begin function halide_error_buffer_extents_negative
	.weak_definition	_halide_error_buffer_extents_negative
	.p2align	2
_halide_error_buffer_extents_negative:  ; @halide_error_buffer_extents_negative
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x23, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB160_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
Lloh600:
	adrp	x2, l_.str.21.132@PAGE
Lloh601:
	add	x2, x2, l_.str.21.132@PAGEOFF
	mov	x0, x20
	mov	x1, x22
	bl	_halide_string_to_string
	b	LBB160_3
LBB160_2:                               ; %entry.split
Lloh602:
	adrp	x2, l_.str.21.132@PAGE
Lloh603:
	add	x2, x2, l_.str.21.132@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x22, #0
LBB160_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x22
	mov	x2, x24
	bl	_halide_string_to_string
Lloh604:
	adrp	x2, l_.str.22.133@PAGE
Lloh605:
	add	x2, x2, l_.str.22.133@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w23
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh606:
	adrp	x2, l_.str.23.134@PAGE
Lloh607:
	add	x2, x2, l_.str.23.134@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh608:
	adrp	x2, l_.str.8.119@PAGE
Lloh609:
	add	x2, x2, l_.str.8.119@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	cbz	x20, LBB160_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB160_6
LBB160_5:
Lloh610:
	adrp	x1, l_.str.29.163@PAGE
Lloh611:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB160_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-28
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh600, Lloh601
	.loh AdrpAdd	Lloh602, Lloh603
	.loh AdrpAdd	Lloh608, Lloh609
	.loh AdrpAdd	Lloh606, Lloh607
	.loh AdrpAdd	Lloh604, Lloh605
	.loh AdrpAdd	Lloh610, Lloh611
                                        ; -- End function
	.globl	_halide_error_buffer_extents_too_large ; -- Begin function halide_error_buffer_extents_too_large
	.weak_definition	_halide_error_buffer_extents_too_large
	.p2align	2
_halide_error_buffer_extents_too_large: ; @halide_error_buffer_extents_too_large
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB161_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh612:
	adrp	x2, l_.str.24.135@PAGE
Lloh613:
	add	x2, x2, l_.str.24.135@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB161_3
LBB161_2:                               ; %entry.split
Lloh614:
	adrp	x2, l_.str.24.135@PAGE
Lloh615:
	add	x2, x2, l_.str.24.135@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB161_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh616:
	adrp	x2, l_.str.19.130@PAGE
Lloh617:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh618:
	adrp	x2, l_.str.20.131@PAGE
Lloh619:
	add	x2, x2, l_.str.20.131@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	x20, LBB161_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB161_6
LBB161_5:
Lloh620:
	adrp	x1, l_.str.29.163@PAGE
Lloh621:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB161_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-6
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh612, Lloh613
	.loh AdrpAdd	Lloh614, Lloh615
	.loh AdrpAdd	Lloh618, Lloh619
	.loh AdrpAdd	Lloh616, Lloh617
	.loh AdrpAdd	Lloh620, Lloh621
                                        ; -- End function
	.globl	_halide_error_constraints_make_required_region_smaller ; -- Begin function halide_error_constraints_make_required_region_smaller
	.weak_definition	_halide_error_constraints_make_required_region_smaller
	.p2align	2
_halide_error_constraints_make_required_region_smaller: ; @halide_error_constraints_make_required_region_smaller
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	x23, x5
	mov	x21, x3
	mov	x24, x2
	mov	x25, x1
	mov	x19, x0
	add	w8, w5, w6
	sub	w27, w8, #1
	add	w8, w3, w4
	sub	w26, w8, #1
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB162_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
Lloh622:
	adrp	x2, l_.str.25.136@PAGE
Lloh623:
	add	x2, x2, l_.str.25.136@PAGEOFF
	mov	x0, x20
	mov	x1, x22
	bl	_halide_string_to_string
	b	LBB162_3
LBB162_2:                               ; %entry.split
Lloh624:
	adrp	x2, l_.str.25.136@PAGE
Lloh625:
	add	x2, x2, l_.str.25.136@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x22, #0
LBB162_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x22
	mov	x2, x25
	bl	_halide_string_to_string
Lloh626:
	adrp	x2, l_.str.26.137@PAGE
Lloh627:
	add	x2, x2, l_.str.26.137@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w24
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh628:
	adrp	x24, l_.str.27.138@PAGE
Lloh629:
	add	x24, x24, l_.str.27.138@PAGEOFF
	mov	x1, x22
	mov	x2, x24
	bl	_halide_string_to_string
Lloh630:
	adrp	x2, l_.str.28.139@PAGE
Lloh631:
	add	x2, x2, l_.str.28.139@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w23
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh632:
	adrp	x23, l_.str.6.117@PAGE
Lloh633:
	add	x23, x23, l_.str.6.117@PAGEOFF
	mov	x1, x22
	mov	x2, x23
	bl	_halide_string_to_string
	sxtw	x2, w27
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x22
	mov	x2, x24
	bl	_halide_string_to_string
Lloh634:
	adrp	x2, l_.str.29.140@PAGE
Lloh635:
	add	x2, x2, l_.str.29.140@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x22
	mov	x2, x23
	bl	_halide_string_to_string
	sxtw	x2, w26
	mov	x1, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh636:
	adrp	x2, l_.str.30.141@PAGE
Lloh637:
	add	x2, x2, l_.str.30.141@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	cbz	x20, LBB162_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB162_6
LBB162_5:
Lloh638:
	adrp	x1, l_.str.29.163@PAGE
Lloh639:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB162_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-7
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh622, Lloh623
	.loh AdrpAdd	Lloh624, Lloh625
	.loh AdrpAdd	Lloh636, Lloh637
	.loh AdrpAdd	Lloh634, Lloh635
	.loh AdrpAdd	Lloh632, Lloh633
	.loh AdrpAdd	Lloh630, Lloh631
	.loh AdrpAdd	Lloh628, Lloh629
	.loh AdrpAdd	Lloh626, Lloh627
	.loh AdrpAdd	Lloh638, Lloh639
                                        ; -- End function
	.globl	_halide_error_constraint_violated ; -- Begin function halide_error_constraint_violated
	.weak_definition	_halide_error_constraint_violated
	.p2align	2
_halide_error_constraint_violated:      ; @halide_error_constraint_violated
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x21, x4
	mov	x22, x3
	mov	x24, x2
	mov	x25, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB163_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh640:
	adrp	x2, l_.str.31.142@PAGE
Lloh641:
	add	x2, x2, l_.str.31.142@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB163_3
LBB163_2:                               ; %entry.split
Lloh642:
	adrp	x2, l_.str.31.142@PAGE
Lloh643:
	add	x2, x2, l_.str.31.142@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB163_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x25
	bl	_halide_string_to_string
Lloh644:
	adrp	x25, l_.str.32.143@PAGE
Lloh645:
	add	x25, x25, l_.str.32.143@PAGEOFF
	mov	x1, x23
	mov	x2, x25
	bl	_halide_string_to_string
	sxtw	x2, w24
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh646:
	adrp	x2, l_.str.33.144@PAGE
Lloh647:
	add	x2, x2, l_.str.33.144@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x25
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh648:
	adrp	x2, l_.str.8.119@PAGE
Lloh649:
	add	x2, x2, l_.str.8.119@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	cbz	x20, LBB163_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB163_6
LBB163_5:
Lloh650:
	adrp	x1, l_.str.29.163@PAGE
Lloh651:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB163_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-8
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh640, Lloh641
	.loh AdrpAdd	Lloh642, Lloh643
	.loh AdrpAdd	Lloh648, Lloh649
	.loh AdrpAdd	Lloh646, Lloh647
	.loh AdrpAdd	Lloh644, Lloh645
	.loh AdrpAdd	Lloh650, Lloh651
                                        ; -- End function
	.globl	_halide_error_param_too_small_i64 ; -- Begin function halide_error_param_too_small_i64
	.weak_definition	_halide_error_param_too_small_i64
	.p2align	2
_halide_error_param_too_small_i64:      ; @halide_error_param_too_small_i64
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB164_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh652:
	adrp	x2, l_.str.34.145@PAGE
Lloh653:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB164_3
LBB164_2:                               ; %entry.split
Lloh654:
	adrp	x2, l_.str.34.145@PAGE
Lloh655:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB164_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh656:
	adrp	x2, l_.str.19.130@PAGE
Lloh657:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh658:
	adrp	x2, l_.str.35.146@PAGE
Lloh659:
	add	x2, x2, l_.str.35.146@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	x20, LBB164_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB164_6
LBB164_5:
Lloh660:
	adrp	x1, l_.str.29.163@PAGE
Lloh661:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB164_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-9
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh652, Lloh653
	.loh AdrpAdd	Lloh654, Lloh655
	.loh AdrpAdd	Lloh658, Lloh659
	.loh AdrpAdd	Lloh656, Lloh657
	.loh AdrpAdd	Lloh660, Lloh661
                                        ; -- End function
	.globl	_halide_error_param_too_small_u64 ; -- Begin function halide_error_param_too_small_u64
	.weak_definition	_halide_error_param_too_small_u64
	.p2align	2
_halide_error_param_too_small_u64:      ; @halide_error_param_too_small_u64
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB165_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh662:
	adrp	x2, l_.str.34.145@PAGE
Lloh663:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB165_3
LBB165_2:                               ; %entry.split
Lloh664:
	adrp	x2, l_.str.34.145@PAGE
Lloh665:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB165_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh666:
	adrp	x2, l_.str.19.130@PAGE
Lloh667:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	mov	w3, #1
	bl	_halide_uint64_to_string
Lloh668:
	adrp	x2, l_.str.35.146@PAGE
Lloh669:
	add	x2, x2, l_.str.35.146@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	mov	w3, #1
	bl	_halide_uint64_to_string
	cbz	x20, LBB165_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB165_6
LBB165_5:
Lloh670:
	adrp	x1, l_.str.29.163@PAGE
Lloh671:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB165_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-9
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh662, Lloh663
	.loh AdrpAdd	Lloh664, Lloh665
	.loh AdrpAdd	Lloh668, Lloh669
	.loh AdrpAdd	Lloh666, Lloh667
	.loh AdrpAdd	Lloh670, Lloh671
                                        ; -- End function
	.globl	_halide_error_param_too_small_f64 ; -- Begin function halide_error_param_too_small_f64
	.weak_definition	_halide_error_param_too_small_f64
	.p2align	2
_halide_error_param_too_small_f64:      ; @halide_error_param_too_small_f64
; %bb.0:                                ; %entry
	stp	d9, d8, [sp, #-64]!             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	fmov	d8, d1
	fmov	d9, d0
	mov	x22, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB166_2
; %bb.1:                                ; %if.then6.i
	add	x21, x20, #1023
	strb	wzr, [x20, #1023]
Lloh672:
	adrp	x2, l_.str.34.145@PAGE
Lloh673:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x0, x20
	mov	x1, x21
	bl	_halide_string_to_string
	b	LBB166_3
LBB166_2:                               ; %entry.split
Lloh674:
	adrp	x2, l_.str.34.145@PAGE
Lloh675:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x21, #0
LBB166_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x21
	mov	x2, x22
	bl	_halide_string_to_string
Lloh676:
	adrp	x2, l_.str.19.130@PAGE
Lloh677:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x21
	bl	_halide_string_to_string
	mov	x1, x21
	fmov	d0, d9
	mov	w2, #1
	bl	_halide_double_to_string
Lloh678:
	adrp	x2, l_.str.35.146@PAGE
Lloh679:
	add	x2, x2, l_.str.35.146@PAGEOFF
	mov	x1, x21
	bl	_halide_string_to_string
	mov	x1, x21
	fmov	d0, d8
	mov	w2, #1
	bl	_halide_double_to_string
	cbz	x20, LBB166_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB166_6
LBB166_5:
Lloh680:
	adrp	x1, l_.str.29.163@PAGE
Lloh681:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB166_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-9
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp], #64               ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh672, Lloh673
	.loh AdrpAdd	Lloh674, Lloh675
	.loh AdrpAdd	Lloh678, Lloh679
	.loh AdrpAdd	Lloh676, Lloh677
	.loh AdrpAdd	Lloh680, Lloh681
                                        ; -- End function
	.globl	_halide_error_param_too_large_i64 ; -- Begin function halide_error_param_too_large_i64
	.weak_definition	_halide_error_param_too_large_i64
	.p2align	2
_halide_error_param_too_large_i64:      ; @halide_error_param_too_large_i64
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB167_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh682:
	adrp	x2, l_.str.34.145@PAGE
Lloh683:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB167_3
LBB167_2:                               ; %entry.split
Lloh684:
	adrp	x2, l_.str.34.145@PAGE
Lloh685:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB167_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh686:
	adrp	x2, l_.str.19.130@PAGE
Lloh687:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh688:
	adrp	x2, l_.str.36@PAGE
Lloh689:
	add	x2, x2, l_.str.36@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	x20, LBB167_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB167_6
LBB167_5:
Lloh690:
	adrp	x1, l_.str.29.163@PAGE
Lloh691:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB167_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-10
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh682, Lloh683
	.loh AdrpAdd	Lloh684, Lloh685
	.loh AdrpAdd	Lloh688, Lloh689
	.loh AdrpAdd	Lloh686, Lloh687
	.loh AdrpAdd	Lloh690, Lloh691
                                        ; -- End function
	.globl	_halide_error_param_too_large_u64 ; -- Begin function halide_error_param_too_large_u64
	.weak_definition	_halide_error_param_too_large_u64
	.p2align	2
_halide_error_param_too_large_u64:      ; @halide_error_param_too_large_u64
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB168_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh692:
	adrp	x2, l_.str.34.145@PAGE
Lloh693:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB168_3
LBB168_2:                               ; %entry.split
Lloh694:
	adrp	x2, l_.str.34.145@PAGE
Lloh695:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB168_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh696:
	adrp	x2, l_.str.19.130@PAGE
Lloh697:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	mov	w3, #1
	bl	_halide_uint64_to_string
Lloh698:
	adrp	x2, l_.str.36@PAGE
Lloh699:
	add	x2, x2, l_.str.36@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	mov	w3, #1
	bl	_halide_uint64_to_string
	cbz	x20, LBB168_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB168_6
LBB168_5:
Lloh700:
	adrp	x1, l_.str.29.163@PAGE
Lloh701:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB168_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-10
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh692, Lloh693
	.loh AdrpAdd	Lloh694, Lloh695
	.loh AdrpAdd	Lloh698, Lloh699
	.loh AdrpAdd	Lloh696, Lloh697
	.loh AdrpAdd	Lloh700, Lloh701
                                        ; -- End function
	.globl	_halide_error_param_too_large_f64 ; -- Begin function halide_error_param_too_large_f64
	.weak_definition	_halide_error_param_too_large_f64
	.p2align	2
_halide_error_param_too_large_f64:      ; @halide_error_param_too_large_f64
; %bb.0:                                ; %entry
	stp	d9, d8, [sp, #-64]!             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	fmov	d8, d1
	fmov	d9, d0
	mov	x22, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB169_2
; %bb.1:                                ; %if.then6.i
	add	x21, x20, #1023
	strb	wzr, [x20, #1023]
Lloh702:
	adrp	x2, l_.str.34.145@PAGE
Lloh703:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x0, x20
	mov	x1, x21
	bl	_halide_string_to_string
	b	LBB169_3
LBB169_2:                               ; %entry.split
Lloh704:
	adrp	x2, l_.str.34.145@PAGE
Lloh705:
	add	x2, x2, l_.str.34.145@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x21, #0
LBB169_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x21
	mov	x2, x22
	bl	_halide_string_to_string
Lloh706:
	adrp	x2, l_.str.19.130@PAGE
Lloh707:
	add	x2, x2, l_.str.19.130@PAGEOFF
	mov	x1, x21
	bl	_halide_string_to_string
	mov	x1, x21
	fmov	d0, d9
	mov	w2, #1
	bl	_halide_double_to_string
Lloh708:
	adrp	x2, l_.str.36@PAGE
Lloh709:
	add	x2, x2, l_.str.36@PAGEOFF
	mov	x1, x21
	bl	_halide_string_to_string
	mov	x1, x21
	fmov	d0, d8
	mov	w2, #1
	bl	_halide_double_to_string
	cbz	x20, LBB169_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB169_6
LBB169_5:
Lloh710:
	adrp	x1, l_.str.29.163@PAGE
Lloh711:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB169_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-10
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp], #64               ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh702, Lloh703
	.loh AdrpAdd	Lloh704, Lloh705
	.loh AdrpAdd	Lloh708, Lloh709
	.loh AdrpAdd	Lloh706, Lloh707
	.loh AdrpAdd	Lloh710, Lloh711
                                        ; -- End function
	.globl	_halide_error_out_of_memory     ; -- Begin function halide_error_out_of_memory
	.weak_definition	_halide_error_out_of_memory
	.p2align	2
_halide_error_out_of_memory:            ; @halide_error_out_of_memory
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh712:
	adrp	x1, l_.str.37@PAGE
Lloh713:
	add	x1, x1, l_.str.37@PAGEOFF
	bl	_halide_error
	mov	w0, #-11
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh712, Lloh713
                                        ; -- End function
	.globl	_halide_error_buffer_argument_is_null ; -- Begin function halide_error_buffer_argument_is_null
	.weak_definition	_halide_error_buffer_argument_is_null
	.p2align	2
_halide_error_buffer_argument_is_null:  ; @halide_error_buffer_argument_is_null
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB171_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
Lloh714:
	adrp	x2, l_.str.38@PAGE
Lloh715:
	add	x2, x2, l_.str.38@PAGEOFF
	mov	x0, x20
	mov	x1, x22
	bl	_halide_string_to_string
	b	LBB171_3
LBB171_2:                               ; %entry.split
Lloh716:
	adrp	x2, l_.str.38@PAGE
Lloh717:
	add	x2, x2, l_.str.38@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x22, #0
LBB171_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x22
	mov	x2, x21
	bl	_halide_string_to_string
Lloh718:
	adrp	x2, l_.str.39@PAGE
Lloh719:
	add	x2, x2, l_.str.39@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	cbz	x20, LBB171_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB171_6
LBB171_5:
Lloh720:
	adrp	x1, l_.str.29.163@PAGE
Lloh721:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB171_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-12
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh714, Lloh715
	.loh AdrpAdd	Lloh716, Lloh717
	.loh AdrpAdd	Lloh718, Lloh719
	.loh AdrpAdd	Lloh720, Lloh721
                                        ; -- End function
	.globl	_halide_error_debug_to_file_failed ; -- Begin function halide_error_debug_to_file_failed
	.weak_definition	_halide_error_debug_to_file_failed
	.p2align	2
_halide_error_debug_to_file_failed:     ; @halide_error_debug_to_file_failed
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB172_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh722:
	adrp	x2, l_.str.40@PAGE
Lloh723:
	add	x2, x2, l_.str.40@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB172_3
LBB172_2:                               ; %entry.split
Lloh724:
	adrp	x2, l_.str.40@PAGE
Lloh725:
	add	x2, x2, l_.str.40@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB172_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh726:
	adrp	x2, l_.str.41.147@PAGE
Lloh727:
	add	x2, x2, l_.str.41.147@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh728:
	adrp	x2, l_.str.42@PAGE
Lloh729:
	add	x2, x2, l_.str.42@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
	cbz	x20, LBB172_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB172_6
LBB172_5:
Lloh730:
	adrp	x1, l_.str.29.163@PAGE
Lloh731:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB172_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-13
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh722, Lloh723
	.loh AdrpAdd	Lloh724, Lloh725
	.loh AdrpAdd	Lloh728, Lloh729
	.loh AdrpAdd	Lloh726, Lloh727
	.loh AdrpAdd	Lloh730, Lloh731
                                        ; -- End function
	.globl	_halide_error_unaligned_host_ptr ; -- Begin function halide_error_unaligned_host_ptr
	.weak_definition	_halide_error_unaligned_host_ptr
	.p2align	2
_halide_error_unaligned_host_ptr:       ; @halide_error_unaligned_host_ptr
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x2
	mov	x22, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB173_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh732:
	adrp	x2, l_.str.43@PAGE
Lloh733:
	add	x2, x2, l_.str.43@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB173_3
LBB173_2:                               ; %entry.split
Lloh734:
	adrp	x2, l_.str.43@PAGE
Lloh735:
	add	x2, x2, l_.str.43@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB173_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh736:
	adrp	x2, l_.str.44@PAGE
Lloh737:
	add	x2, x2, l_.str.44@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh738:
	adrp	x2, l_.str.45@PAGE
Lloh739:
	add	x2, x2, l_.str.45@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	cbz	x20, LBB173_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB173_6
LBB173_5:
Lloh740:
	adrp	x1, l_.str.29.163@PAGE
Lloh741:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB173_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-24
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh732, Lloh733
	.loh AdrpAdd	Lloh734, Lloh735
	.loh AdrpAdd	Lloh738, Lloh739
	.loh AdrpAdd	Lloh736, Lloh737
	.loh AdrpAdd	Lloh740, Lloh741
                                        ; -- End function
	.globl	_halide_error_device_dirty_with_no_device_support ; -- Begin function halide_error_device_dirty_with_no_device_support
	.weak_definition	_halide_error_device_dirty_with_no_device_support
	.p2align	2
_halide_error_device_dirty_with_no_device_support: ; @halide_error_device_dirty_with_no_device_support
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB174_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
Lloh742:
	adrp	x2, l_.str.46@PAGE
Lloh743:
	add	x2, x2, l_.str.46@PAGEOFF
	mov	x0, x20
	mov	x1, x22
	bl	_halide_string_to_string
	b	LBB174_3
LBB174_2:                               ; %entry.split
Lloh744:
	adrp	x2, l_.str.46@PAGE
Lloh745:
	add	x2, x2, l_.str.46@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x22, #0
LBB174_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x22
	mov	x2, x21
	bl	_halide_string_to_string
Lloh746:
	adrp	x2, l_.str.47@PAGE
Lloh747:
	add	x2, x2, l_.str.47@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
Lloh748:
	adrp	x2, l_.str.48@PAGE
Lloh749:
	add	x2, x2, l_.str.48@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	cbz	x20, LBB174_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB174_6
LBB174_5:
Lloh750:
	adrp	x1, l_.str.29.163@PAGE
Lloh751:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB174_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-44
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh742, Lloh743
	.loh AdrpAdd	Lloh744, Lloh745
	.loh AdrpAdd	Lloh748, Lloh749
	.loh AdrpAdd	Lloh746, Lloh747
	.loh AdrpAdd	Lloh750, Lloh751
                                        ; -- End function
	.globl	_halide_error_host_is_null      ; -- Begin function halide_error_host_is_null
	.weak_definition	_halide_error_host_is_null
	.p2align	2
_halide_error_host_is_null:             ; @halide_error_host_is_null
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB175_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
Lloh752:
	adrp	x2, l_.str.43@PAGE
Lloh753:
	add	x2, x2, l_.str.43@PAGEOFF
	mov	x0, x20
	mov	x1, x22
	bl	_halide_string_to_string
	b	LBB175_3
LBB175_2:                               ; %entry.split
Lloh754:
	adrp	x2, l_.str.43@PAGE
Lloh755:
	add	x2, x2, l_.str.43@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x22, #0
LBB175_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x22
	mov	x2, x21
	bl	_halide_string_to_string
Lloh756:
	adrp	x2, l_.str.49@PAGE
Lloh757:
	add	x2, x2, l_.str.49@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	cbz	x20, LBB175_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB175_6
LBB175_5:
Lloh758:
	adrp	x1, l_.str.29.163@PAGE
Lloh759:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB175_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-34
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh752, Lloh753
	.loh AdrpAdd	Lloh754, Lloh755
	.loh AdrpAdd	Lloh756, Lloh757
	.loh AdrpAdd	Lloh758, Lloh759
                                        ; -- End function
	.globl	_halide_error_bad_fold          ; -- Begin function halide_error_bad_fold
	.weak_definition	_halide_error_bad_fold
	.p2align	2
_halide_error_bad_fold:                 ; @halide_error_bad_fold
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x24, x2
	mov	x22, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB176_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh760:
	adrp	x2, l_.str.50.148@PAGE
Lloh761:
	add	x2, x2, l_.str.50.148@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB176_3
LBB176_2:                               ; %entry.split
Lloh762:
	adrp	x2, l_.str.50.148@PAGE
Lloh763:
	add	x2, x2, l_.str.50.148@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB176_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh764:
	adrp	x2, l_.str.51@PAGE
Lloh765:
	add	x2, x2, l_.str.51@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh766:
	adrp	x2, l_.str.52@PAGE
Lloh767:
	add	x2, x2, l_.str.52@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	bl	_halide_string_to_string
Lloh768:
	adrp	x2, l_.str.30.141@PAGE
Lloh769:
	add	x2, x2, l_.str.30.141@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	cbz	x20, LBB176_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB176_6
LBB176_5:
Lloh770:
	adrp	x1, l_.str.29.163@PAGE
Lloh771:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB176_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-25
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh760, Lloh761
	.loh AdrpAdd	Lloh762, Lloh763
	.loh AdrpAdd	Lloh768, Lloh769
	.loh AdrpAdd	Lloh766, Lloh767
	.loh AdrpAdd	Lloh764, Lloh765
	.loh AdrpAdd	Lloh770, Lloh771
                                        ; -- End function
	.globl	_halide_error_bad_extern_fold   ; -- Begin function halide_error_bad_extern_fold
	.weak_definition	_halide_error_bad_extern_fold
	.p2align	2
_halide_error_bad_extern_fold:          ; @halide_error_bad_extern_fold
; %bb.0:                                ; %entry
	stp	x28, x27, [sp, #-96]!           ; 16-byte Folded Spill
	stp	x26, x25, [sp, #16]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	mov	x21, x6
	mov	x23, x5
	mov	x26, x4
	mov	x22, x3
	mov	x27, x2
	mov	x24, x1
	mov	x19, x0
	cmp	w3, w5
	b.lt	LBB177_2
; %bb.1:                                ; %lor.lhs.false
	add	w25, w26, w22
	add	w8, w21, w23
	cmp	w25, w8
	b.le	LBB177_7
LBB177_2:                               ; %if.then
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB177_4
; %bb.3:                                ; %if.then6.i
	add	x25, x20, #1023
	strb	wzr, [x20, #1023]
Lloh772:
	adrp	x2, l_.str.53@PAGE
Lloh773:
	add	x2, x2, l_.str.53@PAGEOFF
	mov	x0, x20
	mov	x1, x25
	bl	_halide_string_to_string
	b	LBB177_5
LBB177_4:                               ; %if.then.split
Lloh774:
	adrp	x2, l_.str.53@PAGE
Lloh775:
	add	x2, x2, l_.str.53@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x25, #0
LBB177_5:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	sxtw	x2, w27
	mov	x1, x25
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh776:
	adrp	x2, l_.str.51@PAGE
Lloh777:
	add	x2, x2, l_.str.51@PAGEOFF
	mov	x1, x25
	bl	_halide_string_to_string
	mov	x1, x25
	mov	x2, x24
	bl	_halide_string_to_string
Lloh778:
	adrp	x2, l_.str.54@PAGE
Lloh779:
	add	x2, x2, l_.str.54@PAGEOFF
	mov	x1, x25
	bl	_halide_string_to_string
	sxtw	x2, w22
	mov	x1, x25
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh780:
	adrp	x24, l_.str.55@PAGE
Lloh781:
	add	x24, x24, l_.str.55@PAGEOFF
	mov	x1, x25
	mov	x2, x24
	bl	_halide_string_to_string
	add	w8, w26, w22
	sub	w8, w8, #1
	sxtw	x2, w8
	mov	x1, x25
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh782:
	adrp	x2, l_.str.56@PAGE
Lloh783:
	add	x2, x2, l_.str.56@PAGEOFF
	mov	x1, x25
	bl	_halide_string_to_string
Lloh784:
	adrp	x2, l_.str.57@PAGE
Lloh785:
	add	x2, x2, l_.str.57@PAGEOFF
	mov	x1, x25
	bl	_halide_string_to_string
	sxtw	x2, w23
	mov	x1, x25
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x25
	mov	x2, x24
	bl	_halide_string_to_string
	add	w8, w21, w23
	sub	w8, w8, #1
	sxtw	x2, w8
	mov	x1, x25
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh786:
	adrp	x2, l_.str.58.149@PAGE
Lloh787:
	add	x2, x2, l_.str.58.149@PAGEOFF
	mov	x1, x25
	bl	_halide_string_to_string
	cbz	x20, LBB177_11
LBB177_6:                               ; %if.end.sink.split
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x21, x20
	b	LBB177_12
LBB177_7:                               ; %if.else
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB177_9
; %bb.8:                                ; %if.then6.i107
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh788:
	adrp	x2, l_.str.53@PAGE
Lloh789:
	add	x2, x2, l_.str.53@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB177_10
LBB177_9:                               ; %if.else.split
Lloh790:
	adrp	x2, l_.str.53@PAGE
Lloh791:
	add	x2, x2, l_.str.53@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB177_10:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit110
                                        ; kill: def $w27 killed $w27 killed $x27 def $x27
	sxtw	x2, w27
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh792:
	adrp	x2, l_.str.51@PAGE
Lloh793:
	add	x2, x2, l_.str.51@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh794:
	adrp	x2, l_.str.54@PAGE
Lloh795:
	add	x2, x2, l_.str.54@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
                                        ; kill: def $w22 killed $w22 killed $x22 def $x22
	sxtw	x2, w22
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh796:
	adrp	x2, l_.str.55@PAGE
Lloh797:
	add	x2, x2, l_.str.55@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sub	w8, w25, #1
	sxtw	x2, w8
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh798:
	adrp	x2, l_.str.56@PAGE
Lloh799:
	add	x2, x2, l_.str.56@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
Lloh800:
	adrp	x2, l_.str.59.150@PAGE
Lloh801:
	add	x2, x2, l_.str.59.150@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
Lloh802:
	adrp	x2, l_.str.60.151@PAGE
Lloh803:
	add	x2, x2, l_.str.60.151@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh804:
	adrp	x2, l_.str.30.141@PAGE
Lloh805:
	add	x2, x2, l_.str.30.141@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	cbnz	x20, LBB177_6
LBB177_11:
	mov	x21, #0
Lloh806:
	adrp	x20, l_.str.29.163@PAGE
Lloh807:
	add	x20, x20, l_.str.29.163@PAGEOFF
LBB177_12:                              ; %if.end
	mov	x0, x19
	mov	x1, x20
	bl	_halide_error
	mov	x0, x21
	bl	_free
	mov	w0, #-35
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #96             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh772, Lloh773
	.loh AdrpAdd	Lloh774, Lloh775
	.loh AdrpAdd	Lloh786, Lloh787
	.loh AdrpAdd	Lloh784, Lloh785
	.loh AdrpAdd	Lloh782, Lloh783
	.loh AdrpAdd	Lloh780, Lloh781
	.loh AdrpAdd	Lloh778, Lloh779
	.loh AdrpAdd	Lloh776, Lloh777
	.loh AdrpAdd	Lloh788, Lloh789
	.loh AdrpAdd	Lloh790, Lloh791
	.loh AdrpAdd	Lloh804, Lloh805
	.loh AdrpAdd	Lloh802, Lloh803
	.loh AdrpAdd	Lloh800, Lloh801
	.loh AdrpAdd	Lloh798, Lloh799
	.loh AdrpAdd	Lloh796, Lloh797
	.loh AdrpAdd	Lloh794, Lloh795
	.loh AdrpAdd	Lloh792, Lloh793
	.loh AdrpAdd	Lloh806, Lloh807
                                        ; -- End function
	.globl	_halide_error_fold_factor_too_small ; -- Begin function halide_error_fold_factor_too_small
	.weak_definition	_halide_error_fold_factor_too_small
	.p2align	2
_halide_error_fold_factor_too_small:    ; @halide_error_fold_factor_too_small
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x21, x5
	mov	x22, x4
	mov	x26, x3
	mov	x25, x2
	mov	x24, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB178_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh808:
	adrp	x2, l_.str.61.152@PAGE
Lloh809:
	add	x2, x2, l_.str.61.152@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB178_3
LBB178_2:                               ; %entry.split
Lloh810:
	adrp	x2, l_.str.61.152@PAGE
Lloh811:
	add	x2, x2, l_.str.61.152@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB178_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	sxtw	x2, w26
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh812:
	adrp	x2, l_.str.62@PAGE
Lloh813:
	add	x2, x2, l_.str.62@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x25
	bl	_halide_string_to_string
Lloh814:
	adrp	x2, l_.str.51@PAGE
Lloh815:
	add	x2, x2, l_.str.51@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh816:
	adrp	x2, l_.str.63@PAGE
Lloh817:
	add	x2, x2, l_.str.63@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh818:
	adrp	x2, l_.str.32.143@PAGE
Lloh819:
	add	x2, x2, l_.str.32.143@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh820:
	adrp	x2, l_.str.64.153@PAGE
Lloh821:
	add	x2, x2, l_.str.64.153@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	cbz	x20, LBB178_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB178_6
LBB178_5:
Lloh822:
	adrp	x1, l_.str.29.163@PAGE
Lloh823:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB178_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-26
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh808, Lloh809
	.loh AdrpAdd	Lloh810, Lloh811
	.loh AdrpAdd	Lloh820, Lloh821
	.loh AdrpAdd	Lloh818, Lloh819
	.loh AdrpAdd	Lloh816, Lloh817
	.loh AdrpAdd	Lloh814, Lloh815
	.loh AdrpAdd	Lloh812, Lloh813
	.loh AdrpAdd	Lloh822, Lloh823
                                        ; -- End function
	.globl	_halide_error_requirement_failed ; -- Begin function halide_error_requirement_failed
	.weak_definition	_halide_error_requirement_failed
	.p2align	2
_halide_error_requirement_failed:       ; @halide_error_requirement_failed
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x2
	mov	x22, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB179_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh824:
	adrp	x2, l_.str.65@PAGE
Lloh825:
	add	x2, x2, l_.str.65@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB179_3
LBB179_2:                               ; %entry.split
Lloh826:
	adrp	x2, l_.str.65@PAGE
Lloh827:
	add	x2, x2, l_.str.65@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB179_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh828:
	adrp	x2, l_.str.66@PAGE
Lloh829:
	add	x2, x2, l_.str.66@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x21
	bl	_halide_string_to_string
	cbz	x20, LBB179_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB179_6
LBB179_5:
Lloh830:
	adrp	x1, l_.str.29.163@PAGE
Lloh831:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB179_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-27
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh824, Lloh825
	.loh AdrpAdd	Lloh826, Lloh827
	.loh AdrpAdd	Lloh828, Lloh829
	.loh AdrpAdd	Lloh830, Lloh831
                                        ; -- End function
	.globl	_halide_error_specialize_fail   ; -- Begin function halide_error_specialize_fail
	.weak_definition	_halide_error_specialize_fail
	.p2align	2
_halide_error_specialize_fail:          ; @halide_error_specialize_fail
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB180_2
; %bb.1:                                ; %if.else.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
Lloh832:
	adrp	x2, l_.str.67@PAGE
Lloh833:
	add	x2, x2, l_.str.67@PAGEOFF
	mov	x0, x20
	mov	x1, x22
	bl	_halide_string_to_string
	mov	x1, x22
	mov	x2, x21
	bl	_halide_string_to_string
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB180_3
LBB180_2:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit.thread
Lloh834:
	adrp	x2, l_.str.67@PAGE
Lloh835:
	add	x2, x2, l_.str.67@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x1, #0
	mov	x2, x21
	bl	_halide_string_to_string
Lloh836:
	adrp	x1, l_.str.29.163@PAGE
Lloh837:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB180_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-31
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh832, Lloh833
	.loh AdrpAdd	Lloh836, Lloh837
	.loh AdrpAdd	Lloh834, Lloh835
                                        ; -- End function
	.globl	_halide_error_no_device_interface ; -- Begin function halide_error_no_device_interface
	.weak_definition	_halide_error_no_device_interface
	.p2align	2
_halide_error_no_device_interface:      ; @halide_error_no_device_interface
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB181_2
; %bb.1:                                ; %if.else.i
	add	x1, x20, #1023
	strb	wzr, [x20, #1023]
Lloh838:
	adrp	x2, l_.str.68@PAGE
Lloh839:
	add	x2, x2, l_.str.68@PAGEOFF
	mov	x0, x20
	bl	_halide_string_to_string
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB181_3
LBB181_2:                               ; %if.then.i
Lloh840:
	adrp	x2, l_.str.68@PAGE
Lloh841:
	add	x2, x2, l_.str.68@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
Lloh842:
	adrp	x1, l_.str.29.163@PAGE
Lloh843:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB181_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh838, Lloh839
	.loh AdrpAdd	Lloh842, Lloh843
	.loh AdrpAdd	Lloh840, Lloh841
                                        ; -- End function
	.globl	_halide_error_device_interface_no_device ; -- Begin function halide_error_device_interface_no_device
	.weak_definition	_halide_error_device_interface_no_device
	.p2align	2
_halide_error_device_interface_no_device: ; @halide_error_device_interface_no_device
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB182_2
; %bb.1:                                ; %if.else.i
	add	x1, x20, #1023
	strb	wzr, [x20, #1023]
Lloh844:
	adrp	x2, l_.str.69@PAGE
Lloh845:
	add	x2, x2, l_.str.69@PAGEOFF
	mov	x0, x20
	bl	_halide_string_to_string
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB182_3
LBB182_2:                               ; %if.then.i
Lloh846:
	adrp	x2, l_.str.69@PAGE
Lloh847:
	add	x2, x2, l_.str.69@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
Lloh848:
	adrp	x1, l_.str.29.163@PAGE
Lloh849:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB182_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-36
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh844, Lloh845
	.loh AdrpAdd	Lloh848, Lloh849
	.loh AdrpAdd	Lloh846, Lloh847
                                        ; -- End function
	.globl	_halide_error_host_and_device_dirty ; -- Begin function halide_error_host_and_device_dirty
	.weak_definition	_halide_error_host_and_device_dirty
	.p2align	2
_halide_error_host_and_device_dirty:    ; @halide_error_host_and_device_dirty
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB183_2
; %bb.1:                                ; %if.else.i
	add	x1, x20, #1023
	strb	wzr, [x20, #1023]
Lloh850:
	adrp	x2, l_.str.70@PAGE
Lloh851:
	add	x2, x2, l_.str.70@PAGEOFF
	mov	x0, x20
	bl	_halide_string_to_string
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB183_3
LBB183_2:                               ; %if.then.i
Lloh852:
	adrp	x2, l_.str.70@PAGE
Lloh853:
	add	x2, x2, l_.str.70@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
Lloh854:
	adrp	x1, l_.str.29.163@PAGE
Lloh855:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB183_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-37
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh850, Lloh851
	.loh AdrpAdd	Lloh854, Lloh855
	.loh AdrpAdd	Lloh852, Lloh853
                                        ; -- End function
	.globl	_halide_error_buffer_is_null    ; -- Begin function halide_error_buffer_is_null
	.weak_definition	_halide_error_buffer_is_null
	.p2align	2
_halide_error_buffer_is_null:           ; @halide_error_buffer_is_null
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB184_2
; %bb.1:                                ; %if.then6.i
	add	x22, x20, #1023
	strb	wzr, [x20, #1023]
Lloh856:
	adrp	x2, l_.str.71@PAGE
Lloh857:
	add	x2, x2, l_.str.71@PAGEOFF
	mov	x0, x20
	mov	x1, x22
	bl	_halide_string_to_string
	b	LBB184_3
LBB184_2:                               ; %entry.split
Lloh858:
	adrp	x2, l_.str.71@PAGE
Lloh859:
	add	x2, x2, l_.str.71@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x22, #0
LBB184_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	mov	x1, x22
	mov	x2, x21
	bl	_halide_string_to_string
Lloh860:
	adrp	x2, l_.str.72@PAGE
Lloh861:
	add	x2, x2, l_.str.72@PAGEOFF
	mov	x1, x22
	bl	_halide_string_to_string
	cbz	x20, LBB184_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB184_6
LBB184_5:
Lloh862:
	adrp	x1, l_.str.29.163@PAGE
Lloh863:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB184_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-38
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh856, Lloh857
	.loh AdrpAdd	Lloh858, Lloh859
	.loh AdrpAdd	Lloh860, Lloh861
	.loh AdrpAdd	Lloh862, Lloh863
                                        ; -- End function
	.globl	_halide_error_storage_bound_too_small ; -- Begin function halide_error_storage_bound_too_small
	.weak_definition	_halide_error_storage_bound_too_small
	.p2align	2
_halide_error_storage_bound_too_small:  ; @halide_error_storage_bound_too_small
; %bb.0:                                ; %entry
	stp	x26, x25, [sp, #-80]!           ; 16-byte Folded Spill
	stp	x24, x23, [sp, #16]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x21, x4
	mov	x25, x3
	mov	x24, x2
	mov	x22, x1
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB185_2
; %bb.1:                                ; %if.then6.i
	add	x23, x20, #1023
	strb	wzr, [x20, #1023]
Lloh864:
	adrp	x2, l_.str.73@PAGE
Lloh865:
	add	x2, x2, l_.str.73@PAGEOFF
	mov	x0, x20
	mov	x1, x23
	bl	_halide_string_to_string
	b	LBB185_3
LBB185_2:                               ; %entry.split
Lloh866:
	adrp	x2, l_.str.73@PAGE
Lloh867:
	add	x2, x2, l_.str.73@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
	mov	x23, #0
LBB185_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EEC2EPvPc.exit
	sxtw	x2, w25
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh868:
	adrp	x2, l_.str.62@PAGE
Lloh869:
	add	x2, x2, l_.str.62@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x24
	bl	_halide_string_to_string
Lloh870:
	adrp	x2, l_.str.51@PAGE
Lloh871:
	add	x2, x2, l_.str.51@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	mov	x1, x23
	mov	x2, x22
	bl	_halide_string_to_string
Lloh872:
	adrp	x2, l_.str.74@PAGE
Lloh873:
	add	x2, x2, l_.str.74@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	sxtw	x2, w21
	mov	x1, x23
	mov	w3, #1
	bl	_halide_int64_to_string
Lloh874:
	adrp	x2, l_.str.64.153@PAGE
Lloh875:
	add	x2, x2, l_.str.64.153@PAGEOFF
	mov	x1, x23
	bl	_halide_string_to_string
	cbz	x20, LBB185_5
; %bb.4:                                ; %if.else.i
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB185_6
LBB185_5:
Lloh876:
	adrp	x1, l_.str.29.163@PAGE
Lloh877:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB185_6:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-45
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #16]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp], #80             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh864, Lloh865
	.loh AdrpAdd	Lloh866, Lloh867
	.loh AdrpAdd	Lloh874, Lloh875
	.loh AdrpAdd	Lloh872, Lloh873
	.loh AdrpAdd	Lloh870, Lloh871
	.loh AdrpAdd	Lloh868, Lloh869
	.loh AdrpAdd	Lloh876, Lloh877
                                        ; -- End function
	.globl	_halide_error_device_crop_failed ; -- Begin function halide_error_device_crop_failed
	.weak_definition	_halide_error_device_crop_failed
	.p2align	2
_halide_error_device_crop_failed:       ; @halide_error_device_crop_failed
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	mov	w0, #1024
	bl	_malloc
	mov	x20, x0
	cbz	x0, LBB186_2
; %bb.1:                                ; %if.else.i
	add	x1, x20, #1023
	strb	wzr, [x20, #1023]
Lloh878:
	adrp	x2, l_.str.75@PAGE
Lloh879:
	add	x2, x2, l_.str.75@PAGEOFF
	mov	x0, x20
	bl	_halide_string_to_string
	sub	x8, x0, x20
	add	x2, x8, #1
	mov	x0, x19
	mov	x1, x20
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x20
	b	LBB186_3
LBB186_2:                               ; %if.then.i
Lloh880:
	adrp	x2, l_.str.75@PAGE
Lloh881:
	add	x2, x2, l_.str.75@PAGEOFF
	mov	x1, #0
	bl	_halide_string_to_string
Lloh882:
	adrp	x1, l_.str.29.163@PAGE
Lloh883:
	add	x1, x1, l_.str.29.163@PAGEOFF
LBB186_3:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE1ELy1024EED2Ev.exit
	mov	x0, x19
	bl	_halide_error
	mov	x0, x20
	bl	_free
	mov	w0, #-41
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh878, Lloh879
	.loh AdrpAdd	Lloh882, Lloh883
	.loh AdrpAdd	Lloh880, Lloh881
                                        ; -- End function
	.globl	_halide_profiler_shutdown       ; -- Begin function halide_profiler_shutdown
	.weak_definition	_halide_profiler_shutdown
	.p2align	2
_halide_profiler_shutdown:              ; @halide_profiler_shutdown
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	bl	_halide_profiler_get_state
	mov	x19, x0
	ldr	x0, [x0, #40]
	cbz	x0, LBB187_2
; %bb.1:                                ; %if.end
	mov	w8, #-2
	str	w8, [x19, #16]
	bl	_halide_join_thread
	str	xzr, [x19, #40]
	mov	w8, #-1
	str	w8, [x19, #16]
	mov	x0, #0
	mov	x1, x19
	bl	_halide_profiler_report_unlocked
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_profiler_reset_unlocked
LBB187_2:                               ; %cleanup
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_profiler_get_state      ; -- Begin function halide_profiler_get_state
	.weak_definition	_halide_profiler_get_state
	.p2align	2
_halide_profiler_get_state:             ; @halide_profiler_get_state
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh884:
	adrp	x0, __ZZ25halide_profiler_get_stateE1s@PAGE
Lloh885:
	add	x0, x0, __ZZ25halide_profiler_get_stateE1s@PAGEOFF
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh884, Lloh885
                                        ; -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ; -- Begin function halide_profiler_report_unlocked
lCPI189_0:
	.quad	0x3ddb7cdfd9d7bdbb              ; double 1.0E-10
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_profiler_report_unlocked
	.weak_definition	_halide_profiler_report_unlocked
	.p2align	2
_halide_profiler_report_unlocked:       ; @halide_profiler_report_unlocked
; %bb.0:                                ; %entry
	sub	sp, sp, #128
	stp	d9, d8, [sp, #16]               ; 16-byte Folded Spill
	stp	x28, x27, [sp, #32]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #48]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #64]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #80]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #96]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	mov	x22, x1
	mov	x20, x0
	mov	w0, #1024
	bl	_malloc
	mov	x19, x0
	cbz	x0, LBB189_2
; %bb.1:                                ; %if.then6.i
	add	x21, x19, #1023
	strb	wzr, [x19, #1023]
	ldr	x27, [x22, #24]
	mov	x26, x19
	cbnz	x27, LBB189_3
	b	LBB189_60
LBB189_2:
	mov	x21, #0
	ldr	x27, [x22, #24]
	mov	x26, x19
	cbz	x27, LBB189_60
LBB189_3:                               ; %for.body.lr.ph
	mov	w8, #1
	sub	x8, x8, x19
	str	x8, [sp]                        ; 8-byte Folded Spill
	mov	w25, #72
Lloh886:
	adrp	x28, l_.str.20.177@PAGE
Lloh887:
	add	x28, x28, l_.str.20.177@PAGEOFF
Lloh888:
	adrp	x8, lCPI189_0@PAGE
Lloh889:
	ldr	d8, [x8, lCPI189_0@PAGEOFF]
	mov	x26, x19
	b	LBB189_5
LBB189_4:                               ; %cleanup181
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldr	x27, [x27, #64]
	cbz	x27, LBB189_60
LBB189_5:                               ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB189_58 Depth 2
                                        ;     Child Loop BB189_20 Depth 2
                                        ;       Child Loop BB189_26 Depth 3
                                        ;       Child Loop BB189_31 Depth 3
                                        ;       Child Loop BB189_36 Depth 3
                                        ;       Child Loop BB189_42 Depth 3
                                        ;       Child Loop BB189_45 Depth 3
                                        ;       Child Loop BB189_47 Depth 3
	ldr	w8, [x27, #80]
	cbz	w8, LBB189_4
; %bb.6:                                ; %if.end
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldr	x24, [x27]
	cbz	x19, LBB189_8
; %bb.7:                                ; %if.then.i273
                                        ;   in Loop: Header=BB189_5 Depth=1
	strb	wzr, [x19]
	ldp	x22, x23, [x27, #32]
	cmp	x22, x23
	cset	w26, eq
	ldr	x2, [x27, #48]
	mov	x0, x19
	b	LBB189_9
LBB189_8:                               ; %if.end.split
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldp	x22, x23, [x27, #32]
	cmp	x22, x23
	cset	w26, eq
	ldr	x2, [x27, #48]
	mov	x0, #0
LBB189_9:                               ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy1024EE5clearEv.exit
                                        ;   in Loop: Header=BB189_5 Depth=1
	mov	x1, x21
	bl	_halide_string_to_string
	ucvtf	s0, x24
	mov	w8, #9216
	movk	w8, #18804, lsl #16
	fmov	s1, w8
	fdiv	s9, s0, s1
	mov	x1, x21
Lloh890:
	adrp	x24, l_.str.7.164@PAGE
Lloh891:
	add	x24, x24, l_.str.7.164@PAGEOFF
	mov	x2, x24
	bl	_halide_string_to_string
	mov	x1, x21
Lloh892:
	adrp	x2, l_.str.8.165@PAGE
Lloh893:
	add	x2, x2, l_.str.8.165@PAGEOFF
	bl	_halide_string_to_string
	fcvt	d0, s9
	mov	x1, x21
	mov	w2, #0
	bl	_halide_double_to_string
	mov	x1, x21
Lloh894:
	adrp	x2, l_.str.9.166@PAGE
Lloh895:
	add	x2, x2, l_.str.9.166@PAGEOFF
	bl	_halide_string_to_string
	mov	x1, x21
Lloh896:
	adrp	x2, l_.str.10.167@PAGE
Lloh897:
	add	x2, x2, l_.str.10.167@PAGEOFF
	bl	_halide_string_to_string
	ldrsw	x2, [x27, #84]
	mov	x1, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x21
Lloh898:
	adrp	x2, l_.str.11.168@PAGE
Lloh899:
	add	x2, x2, l_.str.11.168@PAGEOFF
	bl	_halide_string_to_string
	ldrsw	x2, [x27, #80]
	mov	x1, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x21
Lloh900:
	adrp	x2, l_.str.12.169@PAGE
Lloh901:
	add	x2, x2, l_.str.12.169@PAGEOFF
	bl	_halide_string_to_string
	ldr	s0, [x27, #80]
	scvtf	s0, s0
	fdiv	s0, s9, s0
	fcvt	d0, s0
	mov	x1, x21
	mov	w2, #0
	bl	_halide_double_to_string
	mov	x1, x21
Lloh902:
	adrp	x2, l_.str.13.170@PAGE
Lloh903:
	add	x2, x2, l_.str.13.170@PAGEOFF
	bl	_halide_string_to_string
	str	w26, [sp, #12]                  ; 4-byte Folded Spill
	tbnz	w26, #0, LBB189_11
; %bb.10:                               ; %if.then24
                                        ;   in Loop: Header=BB189_5 Depth=1
	ucvtf	d0, x22
	ucvtf	d1, x23
	fadd	d1, d1, d8
	fdiv	d0, d0, d1
	fcvt	s9, d0
	mov	x1, x21
Lloh904:
	adrp	x2, l_.str.14.171@PAGE
Lloh905:
	add	x2, x2, l_.str.14.171@PAGEOFF
	bl	_halide_string_to_string
	fcvt	d0, s9
	mov	x1, x21
	mov	w2, #0
	bl	_halide_double_to_string
	mov	x1, x21
	mov	x2, x24
	bl	_halide_string_to_string
LBB189_11:                              ; %if.end28
                                        ;   in Loop: Header=BB189_5 Depth=1
	mov	x1, x21
Lloh906:
	adrp	x2, l_.str.15.172@PAGE
Lloh907:
	add	x2, x2, l_.str.15.172@PAGEOFF
	bl	_halide_string_to_string
	ldrsw	x2, [x27, #88]
	mov	x1, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x21
Lloh908:
	adrp	x2, l_.str.16.173@PAGE
Lloh909:
	add	x2, x2, l_.str.16.173@PAGEOFF
	bl	_halide_string_to_string
	ldr	x2, [x27, #16]
	mov	x1, x21
	mov	w3, #1
	bl	_halide_uint64_to_string
	mov	x1, x21
Lloh910:
	adrp	x2, l_.str.17.174@PAGE
Lloh911:
	add	x2, x2, l_.str.17.174@PAGEOFF
	bl	_halide_string_to_string
	mov	x26, x0
	cbz	x19, LBB189_13
; %bb.12:                               ; %if.then.i347
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldr	x8, [sp]                        ; 8-byte Folded Reload
	add	x2, x8, x26
	mov	x0, x20
	mov	x1, x19
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x19
	mov	x0, x20
	bl	_halide_print
	ldr	x8, [x27]
	cbnz	x8, LBB189_15
	b	LBB189_14
LBB189_13:                              ;   in Loop: Header=BB189_5 Depth=1
Lloh912:
	adrp	x1, l_.str.29.163@PAGE
Lloh913:
	add	x1, x1, l_.str.29.163@PAGEOFF
	mov	x0, x20
	bl	_halide_print
	ldr	x8, [x27]
	cbnz	x8, LBB189_15
LBB189_14:                              ; %lor.end
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldr	x8, [x27, #24]
	cbz	x8, LBB189_56
LBB189_15:                              ; %for.cond53.preheader
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldr	w8, [x27, #72]
	cmp	w8, #1
	b.lt	LBB189_4
; %bb.16:                               ; %for.body57.lr.ph
                                        ;   in Loop: Header=BB189_5 Depth=1
	mov	x22, #0
	b	LBB189_20
LBB189_17:                              ; %if.then.i473
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldr	x8, [sp]                        ; 8-byte Folded Reload
	add	x2, x8, x26
	mov	x0, x20
	mov	x1, x19
	bl	_halide_msan_annotate_memory_is_initialized
	mov	x1, x19
LBB189_18:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy1024EE3strEv.exit475
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x0, x20
	bl	_halide_print
LBB189_19:                              ; %cleanup172
                                        ;   in Loop: Header=BB189_20 Depth=2
	add	x22, x22, #1
	ldrsw	x8, [x27, #72]
	cmp	x22, x8
	b.ge	LBB189_4
LBB189_20:                              ; %for.body57
                                        ;   Parent Loop BB189_5 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB189_26 Depth 3
                                        ;       Child Loop BB189_31 Depth 3
                                        ;       Child Loop BB189_36 Depth 3
                                        ;       Child Loop BB189_42 Depth 3
                                        ;       Child Loop BB189_45 Depth 3
                                        ;       Child Loop BB189_47 Depth 3
	cbz	x19, LBB189_22
; %bb.21:                               ; %if.then.i351
                                        ;   in Loop: Header=BB189_20 Depth=2
	strb	wzr, [x19]
LBB189_22:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy1024EE5clearEv.exit353
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldr	x23, [x27, #56]
	madd	x24, x22, x25, x23
	cbnz	x22, LBB189_24
; %bb.23:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldr	x8, [x24]
	mov	x26, x19
	cbz	x8, LBB189_19
LBB189_24:                              ; %if.end66
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x0, x19
	mov	x1, x21
Lloh914:
	adrp	x2, l_.str.18.175@PAGE
Lloh915:
	add	x2, x2, l_.str.18.175@PAGEOFF
	bl	_halide_string_to_string
	madd	x8, x22, x25, x23
	ldr	x2, [x8, #56]
	mov	x1, x21
	bl	_halide_string_to_string
	mov	x1, x21
Lloh916:
	adrp	x2, l_.str.19.176@PAGE
Lloh917:
	add	x2, x2, l_.str.19.176@PAGEOFF
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, #24
	b.hi	LBB189_27
; %bb.25:                               ; %while.body.preheader
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldr	w26, [sp, #12]                  ; 4-byte Folded Reload
LBB189_26:                              ; %while.body
                                        ;   Parent Loop BB189_5 Depth=1
                                        ;     Parent Loop BB189_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x1, x21
	mov	x2, x28
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, #25
	b.lo	LBB189_26
	b	LBB189_28
LBB189_27:                              ;   in Loop: Header=BB189_20 Depth=2
	ldr	w26, [sp, #12]                  ; 4-byte Folded Reload
LBB189_28:                              ; %while.end
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldr	x8, [x24]
	ucvtf	s0, x8
	ldr	s1, [x27, #80]
	scvtf	s1, s1
	mov	w8, #9216
	movk	w8, #18804, lsl #16
	fmov	s2, w8
	fmul	s1, s1, s2
	fdiv	s0, s0, s1
	fcvt	d0, s0
	mov	x1, x21
	mov	w2, #0
	bl	_halide_double_to_string
	cbz	x0, LBB189_30
; %bb.29:                               ; %if.then.i374
                                        ;   in Loop: Header=BB189_20 Depth=2
	sub	x8, x0, #3
	cmp	x8, x19
	csel	x0, x19, x8, lo
	strb	wzr, [x0]
LBB189_30:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy1024EE5eraseEi.exit
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x1, x21
Lloh918:
	adrp	x2, l_.str.21.178@PAGE
Lloh919:
	add	x2, x2, l_.str.21.178@PAGEOFF
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, #34
	b.hi	LBB189_32
LBB189_31:                              ; %while.body86
                                        ;   Parent Loop BB189_5 Depth=1
                                        ;     Parent Loop BB189_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x1, x21
	mov	x2, x28
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, #35
	b.lo	LBB189_31
LBB189_32:                              ; %while.end88
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldr	x8, [x27]
	cbz	x8, LBB189_34
; %bb.33:                               ; %if.then91
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldr	x9, [x24]
	mov	w10, #100
	mul	x9, x9, x10
	udiv	x24, x9, x8
	b	LBB189_35
LBB189_34:                              ;   in Loop: Header=BB189_20 Depth=2
	mov	x24, #0
LBB189_35:                              ; %if.end97
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x1, x21
Lloh920:
	adrp	x2, l_.str.22.179@PAGE
Lloh921:
	add	x2, x2, l_.str.22.179@PAGEOFF
	bl	_halide_string_to_string
	sxtw	x2, w24
	mov	x1, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	mov	x1, x21
Lloh922:
	adrp	x2, l_.str.23.180@PAGE
Lloh923:
	add	x2, x2, l_.str.23.180@PAGEOFF
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, #42
	b.hi	LBB189_37
LBB189_36:                              ; %while.body105
                                        ;   Parent Loop BB189_5 Depth=1
                                        ;     Parent Loop BB189_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x1, x21
	mov	x2, x28
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, #43
	b.lo	LBB189_36
LBB189_37:                              ; %while.end107
                                        ;   in Loop: Header=BB189_20 Depth=2
	tbz	w26, #0, LBB189_39
; %bb.38:                               ;   in Loop: Header=BB189_20 Depth=2
	mov	w24, #58
	madd	x26, x22, x25, x23
	ldr	x8, [x26, #16]!
	cbnz	x8, LBB189_44
	b	LBB189_52
LBB189_39:                              ; %if.then109
                                        ;   in Loop: Header=BB189_20 Depth=2
	madd	x8, x22, x25, x23
	ldp	d0, d1, [x8, #40]
	ucvtf	d0, d0
	ucvtf	d1, d1
	fadd	d1, d1, d8
	fdiv	d0, d0, d1
	fcvt	s9, d0
	mov	x1, x21
Lloh924:
	adrp	x2, l_.str.24.181@PAGE
Lloh925:
	add	x2, x2, l_.str.24.181@PAGEOFF
	bl	_halide_string_to_string
	fcvt	d0, s9
	mov	x1, x21
	mov	w2, #0
	bl	_halide_double_to_string
	cbz	x0, LBB189_41
; %bb.40:                               ; %if.then.i413
                                        ;   in Loop: Header=BB189_20 Depth=2
	sub	x8, x0, #3
	cmp	x8, x19
	csel	x0, x19, x8, lo
	strb	wzr, [x0]
LBB189_41:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy1024EE5eraseEi.exit414
                                        ;   in Loop: Header=BB189_20 Depth=2
	sub	x8, x0, x19
	cmp	x8, #57
	b.hi	LBB189_43
LBB189_42:                              ; %while.body124
                                        ;   Parent Loop BB189_5 Depth=1
                                        ;     Parent Loop BB189_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x1, x21
	mov	x2, x28
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, #58
	b.lo	LBB189_42
LBB189_43:                              ;   in Loop: Header=BB189_20 Depth=2
	mov	w24, #73
	madd	x26, x22, x25, x23
	ldr	x8, [x26, #16]!
	cbz	x8, LBB189_52
LBB189_44:                              ; %if.then130
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x1, x21
Lloh926:
	adrp	x2, l_.str.25.182@PAGE
Lloh927:
	add	x2, x2, l_.str.25.182@PAGEOFF
	bl	_halide_string_to_string
	ldr	x2, [x26]
	mov	x1, x21
	mov	w3, #1
	bl	_halide_uint64_to_string
	sub	x8, x0, x19
	mov	x1, x21
	cmp	x8, x24
	b.hs	LBB189_46
LBB189_45:                              ; %while.body138
                                        ;   Parent Loop BB189_5 Depth=1
                                        ;     Parent Loop BB189_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x2, x28
	bl	_halide_string_to_string
	sub	x8, x0, x19
	mov	x1, x21
	cmp	x8, x24
	b.lo	LBB189_45
LBB189_46:                              ; %while.end140
                                        ;   in Loop: Header=BB189_20 Depth=2
Lloh928:
	adrp	x2, l_.str.26.183@PAGE
Lloh929:
	add	x2, x2, l_.str.26.183@PAGEOFF
	bl	_halide_string_to_string
	madd	x26, x22, x25, x23
	ldrsw	x2, [x26, #64]!
	mov	x1, x21
	mov	w3, #1
	bl	_halide_int64_to_string
	add	x24, x24, #15
	sub	x8, x0, x19
	cmp	x8, x24
	b.hs	LBB189_48
LBB189_47:                              ; %while.body148
                                        ;   Parent Loop BB189_5 Depth=1
                                        ;     Parent Loop BB189_20 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	x1, x21
	mov	x2, x28
	bl	_halide_string_to_string
	sub	x8, x0, x19
	cmp	x8, x24
	b.lo	LBB189_47
LBB189_48:                              ; %while.end150
                                        ;   in Loop: Header=BB189_20 Depth=2
	ldrsw	x8, [x26]
	cbz	w8, LBB189_50
; %bb.49:                               ; %if.then153
                                        ;   in Loop: Header=BB189_20 Depth=2
	madd	x9, x22, x25, x23
	ldr	x9, [x9, #24]
	udiv	x24, x9, x8
	b	LBB189_51
LBB189_50:                              ;   in Loop: Header=BB189_20 Depth=2
	mov	x24, #0
LBB189_51:                              ; %if.end159
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x1, x21
Lloh930:
	adrp	x2, l_.str.27.184@PAGE
Lloh931:
	add	x2, x2, l_.str.27.184@PAGEOFF
	bl	_halide_string_to_string
	sxtw	x2, w24
	mov	x1, x21
	mov	w3, #1
	bl	_halide_int64_to_string
LBB189_52:                              ; %if.end162
                                        ;   in Loop: Header=BB189_20 Depth=2
Lloh932:
	adrp	x24, l_.str.7.164@PAGE
Lloh933:
	add	x24, x24, l_.str.7.164@PAGEOFF
	madd	x23, x22, x25, x23
	ldr	x8, [x23, #32]!
	cbz	x8, LBB189_54
; %bb.53:                               ; %if.then165
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x1, x21
Lloh934:
	adrp	x2, l_.str.28.185@PAGE
Lloh935:
	add	x2, x2, l_.str.28.185@PAGEOFF
	bl	_halide_string_to_string
	ldr	x2, [x23]
	mov	x1, x21
	mov	w3, #1
	bl	_halide_uint64_to_string
LBB189_54:                              ; %if.end169
                                        ;   in Loop: Header=BB189_20 Depth=2
	mov	x1, x21
	mov	x2, x24
	bl	_halide_string_to_string
	mov	x26, x0
	cbnz	x19, LBB189_17
; %bb.55:                               ;   in Loop: Header=BB189_20 Depth=2
Lloh936:
	adrp	x1, l_.str.29.163@PAGE
Lloh937:
	add	x1, x1, l_.str.29.163@PAGEOFF
	b	LBB189_18
LBB189_56:                              ; %for.cond41.preheader
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldr	w8, [x27, #72]
	cmp	w8, #1
	b.lt	LBB189_4
; %bb.57:                               ; %for.body44.lr.ph
                                        ;   in Loop: Header=BB189_5 Depth=1
	ldr	x9, [x27, #56]
	add	x9, x9, #32
LBB189_58:                              ; %for.body44
                                        ;   Parent Loop BB189_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x10, [x9]
	cbnz	x10, LBB189_15
; %bb.59:                               ; %for.cond41
                                        ;   in Loop: Header=BB189_58 Depth=2
	add	x9, x9, #72
	subs	x8, x8, #1
	b.ne	LBB189_58
	b	LBB189_4
LBB189_60:                              ; %for.cond.cleanup
	cbz	x19, LBB189_62
; %bb.61:                               ; %if.else.i
	sub	x8, x26, x19
	add	x2, x8, #1
	mov	x0, x20
	mov	x1, x19
	bl	_halide_msan_annotate_memory_is_initialized
	b	LBB189_63
LBB189_62:                              ; %if.then.i
Lloh938:
	adrp	x1, l_.str.29.163@PAGE
Lloh939:
	add	x1, x1, l_.str.29.163@PAGEOFF
	mov	x0, x20
	bl	_halide_error
LBB189_63:                              ; %_ZN6Halide7Runtime8Internal12_GLOBAL__N_17PrinterILNS1_11PrinterTypeE2ELy1024EED2Ev.exit
	mov	x0, x19
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #96]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #80]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #64]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #48]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	ldp	d9, d8, [sp, #16]               ; 16-byte Folded Reload
	add	sp, sp, #128
	b	_free
	.loh AdrpLdr	Lloh888, Lloh889
	.loh AdrpAdd	Lloh886, Lloh887
	.loh AdrpAdd	Lloh902, Lloh903
	.loh AdrpAdd	Lloh900, Lloh901
	.loh AdrpAdd	Lloh898, Lloh899
	.loh AdrpAdd	Lloh896, Lloh897
	.loh AdrpAdd	Lloh894, Lloh895
	.loh AdrpAdd	Lloh892, Lloh893
	.loh AdrpAdd	Lloh890, Lloh891
	.loh AdrpAdd	Lloh904, Lloh905
	.loh AdrpAdd	Lloh910, Lloh911
	.loh AdrpAdd	Lloh908, Lloh909
	.loh AdrpAdd	Lloh906, Lloh907
	.loh AdrpAdd	Lloh912, Lloh913
	.loh AdrpAdd	Lloh916, Lloh917
	.loh AdrpAdd	Lloh914, Lloh915
	.loh AdrpAdd	Lloh918, Lloh919
	.loh AdrpAdd	Lloh922, Lloh923
	.loh AdrpAdd	Lloh920, Lloh921
	.loh AdrpAdd	Lloh924, Lloh925
	.loh AdrpAdd	Lloh926, Lloh927
	.loh AdrpAdd	Lloh928, Lloh929
	.loh AdrpAdd	Lloh930, Lloh931
	.loh AdrpAdd	Lloh932, Lloh933
	.loh AdrpAdd	Lloh934, Lloh935
	.loh AdrpAdd	Lloh936, Lloh937
	.loh AdrpAdd	Lloh938, Lloh939
                                        ; -- End function
	.globl	_halide_profiler_reset_unlocked ; -- Begin function halide_profiler_reset_unlocked
	.weak_definition	_halide_profiler_reset_unlocked
	.p2align	2
_halide_profiler_reset_unlocked:        ; @halide_profiler_reset_unlocked
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	ldr	x20, [x0, #24]
	cbz	x20, LBB190_2
LBB190_1:                               ; %while.body
                                        ; =>This Inner Loop Header: Depth=1
	ldp	x0, x8, [x20, #56]
	str	x8, [x19, #24]
	bl	_free
	mov	x0, x20
	bl	_free
	ldr	x20, [x19, #24]
	cbnz	x20, LBB190_1
LBB190_2:                               ; %while.end
	str	wzr, [x19, #12]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy ; -- Begin function _ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
	.weak_definition	__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
	.p2align	2
__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy: ; @_ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x2
	mov	x20, x1
	mov	x23, x0
	bl	_halide_profiler_get_state
	mov	x22, x0
	ldr	x19, [x0, #24]
	cbnz	x19, LBB191_9
LBB191_1:                               ; %for.end
	mov	w0, #96
	bl	_malloc
	mov	x19, x0
	cbz	x0, LBB191_7
; %bb.2:                                ; %if.end7
	ldr	x8, [x22, #24]
	str	x8, [x19, #64]
	str	x23, [x19, #48]
	ldr	w8, [x22, #12]
	stp	w20, w8, [x19, #72]
	str	xzr, [x19]
	str	xzr, [x19, #80]
	movi.2d	v0, #0000000000000000
	stur	q0, [x19, #8]
	mov	w8, #72
	str	xzr, [x19, #24]
	str	wzr, [x19, #88]
	smull	x0, w20, w8
	str	q0, [x19, #32]
	bl	_malloc
	str	x0, [x19, #56]
	cbz	x0, LBB191_11
; %bb.3:                                ; %for.cond17.preheader
	cmp	w20, #1
	b.lt	LBB191_6
; %bb.4:                                ; %for.body20.lr.ph
	mov	w8, w20
	add	x9, x0, #32
	movi.2d	v0, #0000000000000000
LBB191_5:                               ; %for.body20
                                        ; =>This Inner Loop Header: Depth=1
	stur	xzr, [x9, #-32]
	ldr	x10, [x21], #8
	stur	q0, [x9, #-24]
	stur	xzr, [x9, #-8]
	str	wzr, [x9, #32]
	str	q0, [x9]
	stp	xzr, x10, [x9, #16]
	add	x9, x9, #72
	subs	x8, x8, #1
	b.ne	LBB191_5
LBB191_6:                               ; %for.cond.cleanup19
	ldr	w8, [x22, #12]
	add	w8, w8, w20
	str	w8, [x22, #12]
	str	x19, [x22, #24]
LBB191_7:                               ; %cleanup62
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
LBB191_8:                               ; %for.inc
                                        ;   in Loop: Header=BB191_9 Depth=1
	ldr	x19, [x19, #64]
	cbz	x19, LBB191_1
LBB191_9:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x19, #48]
	cmp	x8, x23
	b.ne	LBB191_8
; %bb.10:                               ; %land.lhs.true
                                        ;   in Loop: Header=BB191_9 Depth=1
	ldr	w8, [x19, #72]
	cmp	w8, w20
	b.ne	LBB191_8
	b	LBB191_7
LBB191_11:                              ; %if.then15
	mov	x0, x19
	bl	_free
	mov	x19, #0
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi ; -- Begin function _ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
	.weak_definition	__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
	.p2align	2
__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi: ; @_ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
                                        ; kill: def $w3 killed $w3 def $x3
	ldr	x9, [x0, #24]
	cbz	x9, LBB192_8
; %bb.1:                                ; %for.body.preheader
	mov	x10, #0
	mov	x11, x9
	b	LBB192_3
LBB192_2:                               ; %if.end23
                                        ;   in Loop: Header=BB192_3 Depth=1
	ldr	x11, [x8, #64]
	mov	x10, x8
	cbz	x11, LBB192_8
LBB192_3:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	mov	x8, x11
	ldrsw	x11, [x11, #76]
	cmp	w11, w1
	b.gt	LBB192_2
; %bb.4:                                ; %land.lhs.true
                                        ;   in Loop: Header=BB192_3 Depth=1
	ldr	w12, [x8, #72]
	add	w12, w12, w11
	cmp	w12, w1
	b.le	LBB192_2
; %bb.5:                                ; %if.then
	cbz	x10, LBB192_7
; %bb.6:                                ; %if.then4
	ldr	x12, [x8, #64]
	str	x12, [x10, #64]
	str	x9, [x8, #64]
	str	x8, [x0, #24]
LBB192_7:                               ; %if.end
	ldr	x9, [x8, #56]
	mov	w10, #72
	smaddl	x9, w1, w10, x9
	mneg	x10, x11, x10
	add	x9, x9, x10
	ldr	x10, [x9]
	add	x10, x10, x2
	str	x10, [x9]
	sxtw	x10, w3
	mov	w11, #1
	dup.2d	v0, x11
	mov.d	v0[0], x10
	ldur	q1, [x9, #40]
	add.2d	v1, v1, v0
	stur	q1, [x9, #40]
	ldr	x9, [x8]
	add	x9, x9, x2
	str	x9, [x8]
	ldr	w9, [x8, #84]
	add	w9, w9, #1
	str	w9, [x8, #84]
	ldr	q1, [x8, #32]
	add.2d	v0, v1, v0
	str	q0, [x8, #32]
LBB192_8:                               ; %cleanup
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_profiler_sample         ; -- Begin function halide_profiler_sample
	.weak_definition	_halide_profiler_sample
	.p2align	2
_halide_profiler_sample:                ; @halide_profiler_sample
; %bb.0:                                ; %entry
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x20, x1
	mov	x19, x0
	ldr	x8, [x0, #32]
	cbz	x8, LBB193_3
; %bb.1:                                ; %if.then
	add	x0, sp, #12
	add	x1, sp, #8
	blr	x8
	mov	x0, #0
	bl	_halide_current_time_ns
	ldr	w1, [sp, #12]
	cmn	w1, #2
	b.ne	LBB193_4
LBB193_2:
	mov	w0, #-1
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB193_3:                               ; %if.else
	ldp	w8, w9, [x19, #16]
	stp	w9, w8, [sp, #8]
	mov	x0, #0
	bl	_halide_current_time_ns
	ldr	w1, [sp, #12]
	cmn	w1, #2
	b.eq	LBB193_2
LBB193_4:                               ; %if.else4
	mov	x21, x0
	tbnz	w1, #31, LBB193_6
; %bb.5:                                ; %if.then6
	ldr	x8, [x20]
	sub	x2, x21, x8
	ldr	w3, [sp, #8]
	mov	x0, x19
	bl	__ZN6Halide7Runtime8Internal9bill_funcEP21halide_profiler_stateiyi
LBB193_6:                               ; %if.end8
	str	x21, [x20]
	ldr	w0, [x19, #8]
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv ; -- Begin function _ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv
	.weak_definition	__ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv
	.p2align	2
__ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv: ; @_ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv
; %bb.0:                                ; %entry
	sub	sp, sp, #48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	bl	_halide_profiler_get_state
	mov	x19, x0
	bl	_halide_mutex_lock
LBB194_1:                               ; %entry
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB194_4 Depth 2
	ldr	w8, [x19, #16]
	cmn	w8, #2
	b.eq	LBB194_5
; %bb.2:                                ; %while.body
                                        ;   in Loop: Header=BB194_1 Depth=1
	mov	x0, #0
	bl	_halide_current_time_ns
	str	x0, [sp, #8]
	add	x1, sp, #8
	mov	x0, x19
	bl	_halide_profiler_sample
	tbnz	w0, #31, LBB194_1
; %bb.3:                                ; %cleanup.preheader
                                        ;   in Loop: Header=BB194_1 Depth=1
	mov	x20, x0
LBB194_4:                               ; %cleanup
                                        ;   Parent Loop BB194_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	x0, x19
	bl	_halide_mutex_unlock
	mov	x0, #0
	mov	x1, x20
	bl	_halide_sleep_ms
	mov	x0, x19
	bl	_halide_mutex_lock
	add	x1, sp, #8
	mov	x0, x19
	bl	_halide_profiler_sample
	mov	x20, x0
	tbz	w0, #31, LBB194_4
	b	LBB194_1
LBB194_5:                               ; %while.end8
	mov	x0, x19
	bl	_halide_mutex_unlock
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
                                        ; -- End function
	.globl	_halide_profiler_get_pipeline_state ; -- Begin function halide_profiler_get_pipeline_state
	.weak_definition	_halide_profiler_get_pipeline_state
	.p2align	2
_halide_profiler_get_pipeline_state:    ; @halide_profiler_get_pipeline_state
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x21, x0
	bl	_halide_profiler_get_state
	mov	x19, x0
	bl	_halide_mutex_lock
	ldr	x20, [x19, #24]
	cbz	x20, LBB195_3
LBB195_1:                               ; %for.body
                                        ; =>This Inner Loop Header: Depth=1
	ldr	x8, [x20, #48]
	cmp	x8, x21
	b.eq	LBB195_3
; %bb.2:                                ; %for.inc
                                        ;   in Loop: Header=BB195_1 Depth=1
	ldr	x20, [x20, #64]
	cbnz	x20, LBB195_1
LBB195_3:                               ; %cleanup
	mov	x0, x19
	bl	_halide_mutex_unlock
	mov	x0, x20
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_profiler_pipeline_start ; -- Begin function halide_profiler_pipeline_start
	.weak_definition	_halide_profiler_pipeline_start
	.p2align	2
_halide_profiler_pipeline_start:        ; @halide_profiler_pipeline_start
; %bb.0:                                ; %entry
	stp	x24, x23, [sp, #-64]!           ; 16-byte Folded Spill
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	mov	x21, x3
	mov	x22, x2
	mov	x23, x1
	mov	x20, x0
	bl	_halide_profiler_get_state
	mov	x19, x0
	bl	_halide_mutex_lock
	ldr	x8, [x19, #40]
	cbz	x8, LBB196_3
; %bb.1:                                ; %if.end
	mov	x0, x23
	mov	x1, x22
	mov	x2, x21
	bl	__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
	cbz	x0, LBB196_4
LBB196_2:                               ; %if.end8
	ldp	w20, w8, [x0, #76]
	add	w8, w8, #1
	str	w8, [x0, #80]
	b	LBB196_5
LBB196_3:                               ; %if.then
	mov	x0, x20
	bl	_halide_start_clock
Lloh940:
	adrp	x0, __ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv@GOTPAGE
Lloh941:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal24sampling_profiler_threadEPv@GOTPAGEOFF]
	mov	x1, #0
	bl	_halide_spawn_thread
	str	x0, [x19, #40]
	mov	x0, x23
	mov	x1, x22
	mov	x2, x21
	bl	__ZN6Halide7Runtime8Internal23find_or_create_pipelineEPKciPKy
	cbnz	x0, LBB196_2
LBB196_4:                               ; %if.then6
	mov	x0, x20
	bl	_halide_error_out_of_memory
	mov	x20, x0
LBB196_5:                               ; %cleanup
	mov	x0, x19
	bl	_halide_mutex_unlock
	mov	x0, x20
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp], #64             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh940, Lloh941
                                        ; -- End function
	.globl	_halide_profiler_stack_peak_update ; -- Begin function halide_profiler_stack_peak_update
	.weak_definition	_halide_profiler_stack_peak_update
	.p2align	2
_halide_profiler_stack_peak_update:     ; @halide_profiler_stack_peak_update
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x2
	mov	x20, x1
	cbz	x1, LBB197_2
; %bb.1:                                ; %do.end
	ldr	w10, [x20, #72]
	cmp	w10, #1
	b.ge	LBB197_3
	b	LBB197_10
LBB197_2:                               ; %if.then
Lloh942:
	adrp	x1, l_.str.186@PAGE
Lloh943:
	add	x1, x1, l_.str.186@PAGEOFF
	bl	_halide_print
	bl	_abort
	ldr	w10, [x20, #72]
	cmp	w10, #1
	b.lt	LBB197_10
LBB197_3:                               ; %for.body.lr.ph
	mov	x8, #0
	mov	w9, #72
	b	LBB197_6
LBB197_4:                               ; %for.inc.loopexit
                                        ;   in Loop: Header=BB197_6 Depth=1
	ldr	w10, [x20, #72]
LBB197_5:                               ; %for.inc
                                        ;   in Loop: Header=BB197_6 Depth=1
	add	x8, x8, #1
	cmp	x8, w10, sxtw
	b.ge	LBB197_10
LBB197_6:                               ; %for.body
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB197_8 Depth 2
	ldr	x11, [x19, x8, lsl #3]
	cbz	x11, LBB197_5
; %bb.7:                                ; %if.then3
                                        ;   in Loop: Header=BB197_6 Depth=1
	ldr	x10, [x20, #56]
	madd	x10, x8, x9, x10
	ldr	x12, [x10, #32]!
LBB197_8:                               ; %while.cond.i
                                        ;   Parent Loop BB197_6 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	cmp	x12, x11
	b.hs	LBB197_4
; %bb.9:                                ; %while.body.i
                                        ;   in Loop: Header=BB197_8 Depth=2
	mov	x13, x12
	casal	x13, x11, [x10]
	cmp	x12, x13
	mov	x12, x13
	b.ne	LBB197_8
	b	LBB197_4
LBB197_10:                              ; %for.cond.cleanup
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	ret
	.loh AdrpAdd	Lloh942, Lloh943
                                        ; -- End function
	.globl	_halide_profiler_memory_allocate ; -- Begin function halide_profiler_memory_allocate
	.weak_definition	_halide_profiler_memory_allocate
	.p2align	2
_halide_profiler_memory_allocate:       ; @halide_profiler_memory_allocate
; %bb.0:                                ; %entry
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	cbz	x3, LBB198_11
; %bb.1:                                ; %if.end
	mov	x19, x3
	mov	x21, x2
	mov	x20, x1
	mov	x22, x0
	cbz	x1, LBB198_12
; %bb.2:                                ; %do.body4
	tbnz	w21, #31, LBB198_13
LBB198_3:                               ; %do.body10
	ldr	w8, [x20, #72]
	cmp	w8, w21
	b.gt	LBB198_5
LBB198_4:                               ; %if.then12
Lloh944:
	adrp	x1, l_.str.3.189@PAGE
Lloh945:
	add	x1, x1, l_.str.3.189@PAGEOFF
	mov	x0, x22
	bl	_halide_print
	bl	_abort
LBB198_5:                               ; %do.end15
	ldr	x8, [x20, #56]
	sxtw	x9, w21
	add	x10, x20, #88
	mov	w11, #1
	ldaddal	w11, w10, [x10]
	add	x10, x20, #24
	ldaddal	x19, x10, [x10]
	add	x10, x20, #8
	ldaddal	x19, x10, [x10]
	add	x10, x10, x19
	ldr	x11, [x20, #16]
LBB198_6:                               ; %while.cond.i
                                        ; =>This Inner Loop Header: Depth=1
	cmp	x11, x10
	b.hs	LBB198_8
; %bb.7:                                ; %while.body.i
                                        ;   in Loop: Header=BB198_6 Depth=1
	add	x12, x20, #16
	mov	x13, x11
	casal	x13, x10, [x12]
	cmp	x11, x13
	mov	x11, x13
	b.ne	LBB198_6
LBB198_8:                               ; %_ZN12_GLOBAL__N_125sync_compare_max_and_swapIyEEvPT_S1_.exit
	mov	w10, #72
	madd	x8, x9, x10, x8
	add	x9, x8, #64
	mov	w10, #1
	ldaddal	w10, w9, [x9]
	add	x9, x8, #24
	ldaddal	x19, x9, [x9]
	add	x9, x8, #8
	ldaddal	x19, x9, [x9]
	add	x9, x9, x19
	ldr	x10, [x8, #16]!
LBB198_9:                               ; %while.cond.i43
                                        ; =>This Inner Loop Header: Depth=1
	cmp	x10, x9
	b.hs	LBB198_11
; %bb.10:                               ; %while.body.i45
                                        ;   in Loop: Header=BB198_9 Depth=1
	mov	x11, x10
	casal	x11, x9, [x8]
	cmp	x10, x11
	mov	x10, x11
	b.ne	LBB198_9
LBB198_11:                              ; %return
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
	ret
LBB198_12:                              ; %if.then2
Lloh946:
	adrp	x1, l_.str.1.187@PAGE
Lloh947:
	add	x1, x1, l_.str.1.187@PAGEOFF
	mov	x0, x22
	bl	_halide_print
	bl	_abort
	tbz	w21, #31, LBB198_3
LBB198_13:                              ; %if.then6
Lloh948:
	adrp	x1, l_.str.2.188@PAGE
Lloh949:
	add	x1, x1, l_.str.2.188@PAGEOFF
	mov	x0, x22
	bl	_halide_print
	bl	_abort
	ldr	w8, [x20, #72]
	cmp	w8, w21
	b.le	LBB198_4
	b	LBB198_5
	.loh AdrpAdd	Lloh944, Lloh945
	.loh AdrpAdd	Lloh946, Lloh947
	.loh AdrpAdd	Lloh948, Lloh949
                                        ; -- End function
	.globl	_halide_profiler_memory_free    ; -- Begin function halide_profiler_memory_free
	.weak_definition	_halide_profiler_memory_free
	.p2align	2
_halide_profiler_memory_free:           ; @halide_profiler_memory_free
; %bb.0:                                ; %entry
	cbz	x3, LBB199_6
; %bb.1:                                ; %if.end
	stp	x22, x21, [sp, #-48]!           ; 16-byte Folded Spill
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	mov	x20, x3
	mov	x19, x2
	mov	x21, x1
	mov	x22, x0
	cbz	x1, LBB199_7
; %bb.2:                                ; %do.body4
	tbnz	w19, #31, LBB199_8
LBB199_3:                               ; %do.body10
	ldr	w8, [x21, #72]
	cmp	w8, w19
	b.gt	LBB199_5
LBB199_4:                               ; %if.then12
Lloh950:
	adrp	x1, l_.str.6.192@PAGE
Lloh951:
	add	x1, x1, l_.str.6.192@PAGEOFF
	mov	x0, x22
	bl	_halide_print
	bl	_abort
LBB199_5:                               ; %do.end15
	ldr	x8, [x21, #56]
	add	x9, x21, #8
	neg	x10, x20
	ldaddal	x10, x9, [x9]
	mov	w9, #72
	smaddl	x8, w19, w9, x8
	add	x8, x8, #8
	ldaddal	x10, x8, [x8]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp], #48             ; 16-byte Folded Reload
LBB199_6:                               ; %return
	ret
LBB199_7:                               ; %if.then2
Lloh952:
	adrp	x1, l_.str.4.190@PAGE
Lloh953:
	add	x1, x1, l_.str.4.190@PAGEOFF
	mov	x0, x22
	bl	_halide_print
	bl	_abort
	tbz	w19, #31, LBB199_3
LBB199_8:                               ; %if.then6
Lloh954:
	adrp	x1, l_.str.5.191@PAGE
Lloh955:
	add	x1, x1, l_.str.5.191@PAGEOFF
	mov	x0, x22
	bl	_halide_print
	bl	_abort
	ldr	w8, [x21, #72]
	cmp	w8, w19
	b.le	LBB199_4
	b	LBB199_5
	.loh AdrpAdd	Lloh950, Lloh951
	.loh AdrpAdd	Lloh952, Lloh953
	.loh AdrpAdd	Lloh954, Lloh955
                                        ; -- End function
	.globl	_halide_profiler_report         ; -- Begin function halide_profiler_report
	.weak_definition	_halide_profiler_report
	.p2align	2
_halide_profiler_report:                ; @halide_profiler_report
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	mov	x19, x0
	bl	_halide_profiler_get_state
	mov	x20, x0
	bl	_halide_mutex_lock
	mov	x0, x19
	mov	x1, x20
	bl	_halide_profiler_report_unlocked
	mov	x0, x20
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_mutex_unlock
                                        ; -- End function
	.globl	_halide_profiler_reset          ; -- Begin function halide_profiler_reset
	.weak_definition	_halide_profiler_reset
	.p2align	2
_halide_profiler_reset:                 ; @halide_profiler_reset
; %bb.0:                                ; %entry
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	bl	_halide_profiler_get_state
	mov	x19, x0
	bl	_halide_mutex_lock
	mov	x0, x19
	bl	_halide_profiler_reset_unlocked
	mov	x0, x19
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	_halide_mutex_unlock
                                        ; -- End function
	.globl	_halide_profiler_pipeline_end   ; -- Begin function halide_profiler_pipeline_end
	.weak_definition	_halide_profiler_pipeline_end
	.p2align	2
_halide_profiler_pipeline_end:          ; @halide_profiler_pipeline_end
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w8, #-1
	str	w8, [x1, #16]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_msan_annotate_memory_is_initialized ; -- Begin function halide_msan_annotate_memory_is_initialized
	.weak_definition	_halide_msan_annotate_memory_is_initialized
	.p2align	2
_halide_msan_annotate_memory_is_initialized: ; @halide_msan_annotate_memory_is_initialized
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_msan_check_memory_is_initialized ; -- Begin function halide_msan_check_memory_is_initialized
	.weak_definition	_halide_msan_check_memory_is_initialized
	.p2align	2
_halide_msan_check_memory_is_initialized: ; @halide_msan_check_memory_is_initialized
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_msan_check_buffer_is_initialized ; -- Begin function halide_msan_check_buffer_is_initialized
	.weak_definition	_halide_msan_check_buffer_is_initialized
	.p2align	2
_halide_msan_check_buffer_is_initialized: ; @halide_msan_check_buffer_is_initialized
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_msan_annotate_buffer_is_initialized ; -- Begin function halide_msan_annotate_buffer_is_initialized
	.weak_definition	_halide_msan_annotate_buffer_is_initialized
	.p2align	2
_halide_msan_annotate_buffer_is_initialized: ; @halide_msan_annotate_buffer_is_initialized
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	mov	w0, #0
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_msan_annotate_buffer_is_initialized_as_destructor ; -- Begin function halide_msan_annotate_buffer_is_initialized_as_destructor
	.weak_definition	_halide_msan_annotate_buffer_is_initialized_as_destructor
	.p2align	2
_halide_msan_annotate_buffer_is_initialized_as_destructor: ; @halide_msan_annotate_buffer_is_initialized_as_destructor
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_default_can_use_target_features ; -- Begin function halide_default_can_use_target_features
	.weak_definition	_halide_default_can_use_target_features
	.p2align	2
_halide_default_can_use_target_features: ; @halide_default_can_use_target_features
; %bb.0:                                ; %entry
	sub	sp, sp, #80
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #48]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	mov	x19, x1
	mov	x20, x0
Lloh956:
	adrp	x0, __ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPAGE
Lloh957:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPAGEOFF]
	bl	_halide_mutex_lock
Lloh958:
	adrp	x21, __ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE@GOTPAGE
Lloh959:
	ldr	x21, [x21, __ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE@GOTPAGEOFF]
	ldrb	w8, [x21]
	cbz	w8, LBB208_3
; %bb.1:                                ; %if.end
Lloh960:
	adrp	x0, __ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPAGE
Lloh961:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	cmp	w20, #2
	b.ne	LBB208_4
LBB208_2:                               ; %if.end2
	ldr	x9, [x19]
Lloh962:
	adrp	x8, __ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPAGE
Lloh963:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPAGEOFF]
	ldr	x10, [x8]
	ands	x9, x10, x9
	b.ne	LBB208_5
	b	LBB208_6
LBB208_3:                               ; %if.then
	mov	x8, sp
	bl	__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
Lloh964:
	adrp	x0, __ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPAGE
Lloh965:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPAGEOFF]
	mov	x1, sp
	mov	w2, #32
	bl	_memcpy
	mov	w8, #1
	strb	w8, [x21]
Lloh966:
	adrp	x0, __ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPAGE
Lloh967:
	ldr	x0, [x0, __ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE@GOTPAGEOFF]
	bl	_halide_mutex_unlock
	cmp	w20, #2
	b.eq	LBB208_2
LBB208_4:                               ; %if.then1
Lloh968:
	adrp	x1, l_.str.197@PAGE
Lloh969:
	add	x1, x1, l_.str.197@PAGEOFF
	mov	x0, #0
	bl	_halide_error
	ldr	x9, [x19]
Lloh970:
	adrp	x8, __ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPAGE
Lloh971:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal27halide_cpu_features_storageE@GOTPAGEOFF]
	ldr	x10, [x8]
	ands	x9, x10, x9
	b.eq	LBB208_6
LBB208_5:                               ; %if.then7
	ldr	x10, [x8, #16]
	bics	xzr, x9, x10
	b.ne	LBB208_9
LBB208_6:                               ; %for.inc.critedge
	ldr	x9, [x19, #8]
	ldr	x10, [x8, #8]
	ands	x9, x10, x9
	b.eq	LBB208_8
; %bb.7:                                ; %if.then7.1
	ldr	x8, [x8, #24]
	bics	xzr, x9, x8
	b.ne	LBB208_9
LBB208_8:                               ; %for.inc.critedge.1
	mov	w0, #1
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
LBB208_9:
	mov	w0, #0
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #48]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.loh AdrpLdrGot	Lloh958, Lloh959
	.loh AdrpLdrGot	Lloh956, Lloh957
	.loh AdrpLdrGot	Lloh960, Lloh961
	.loh AdrpLdrGot	Lloh962, Lloh963
	.loh AdrpLdrGot	Lloh966, Lloh967
	.loh AdrpLdrGot	Lloh964, Lloh965
	.loh AdrpLdrGot	Lloh970, Lloh971
	.loh AdrpAdd	Lloh968, Lloh969
                                        ; -- End function
	.globl	_halide_set_custom_can_use_target_features ; -- Begin function halide_set_custom_can_use_target_features
	.weak_definition	_halide_set_custom_can_use_target_features
	.p2align	2
_halide_set_custom_can_use_target_features: ; @halide_set_custom_can_use_target_features
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh972:
	adrp	x9, __ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE@GOTPAGE
Lloh973:
	ldr	x9, [x9, __ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE@GOTPAGEOFF]
	ldr	x8, [x9]
	str	x0, [x9]
	mov	x0, x8
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh972, Lloh973
                                        ; -- End function
	.globl	_halide_can_use_target_features ; -- Begin function halide_can_use_target_features
	.weak_definition	_halide_can_use_target_features
	.p2align	2
_halide_can_use_target_features:        ; @halide_can_use_target_features
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
Lloh974:
	adrp	x8, __ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE@GOTPAGE
Lloh975:
	ldr	x8, [x8, __ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE@GOTPAGEOFF]
Lloh976:
	ldr	x2, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	br	x2
	.loh AdrpLdrGotLdr	Lloh974, Lloh975, Lloh976
                                        ; -- End function
	.globl	__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv ; -- Begin function _ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
	.weak_definition	__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
	.p2align	2
__ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv: ; @_ZN6Halide7Runtime8Internal23halide_get_cpu_featuresEv
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	movi.2d	v0, #0000000000000000
	stp	q0, q0, [x8]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_use_jit_module          ; -- Begin function halide_use_jit_module
	.weak_definition	_halide_use_jit_module
	.p2align	2
_halide_use_jit_module:                 ; @halide_use_jit_module
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.globl	_halide_release_jit_module      ; -- Begin function halide_release_jit_module
	.weak_definition	_halide_release_jit_module
	.p2align	2
_halide_release_jit_module:             ; @halide_release_jit_module
; %bb.0:                                ; %entry
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
                                        ; -- End function
	.section	__TEXT,__literal8,8byte_literals
	.p2align	3                               ; -- Begin function halide_blur
lCPI214_0:
	.long	1                               ; 0x1
	.long	0                               ; 0x0
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_blur
	.p2align	2
_halide_blur:                           ; @halide_blur
; %bb.0:                                ; %entry
	sub	sp, sp, #160
	stp	x28, x27, [sp, #64]             ; 16-byte Folded Spill
	stp	x26, x25, [sp, #80]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #112]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #128]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #144]            ; 16-byte Folded Spill
	cbz	x0, LBB214_29
; %bb.1:                                ; %"assert succeeded"
	cbz	x1, LBB214_30
; %bb.2:                                ; %"assert succeeded2"
	ldp	x19, x23, [x1, #16]
	ldp	w10, w2, [x1, #32]
	ldr	x4, [x1, #40]
	ldp	w9, w3, [x4]
	ldr	w12, [x4, #8]
	ldp	w11, w8, [x4, #16]
	ldrsw	x20, [x4, #24]
	ldp	x21, x24, [x0, #16]
	ldp	w15, w13, [x0, #32]
	ldr	x6, [x0, #40]
	ldp	w5, w16, [x6]
	ldr	w17, [x6, #8]
	ldp	w14, w7, [x6, #16]
	ldrsw	x22, [x6, #24]
	cbz	x19, LBB214_4
; %bb.3:
	mov	x6, x21
	cbnz	x6, LBB214_9
	b	LBB214_6
LBB214_4:                               ; %_halide_buffer_is_bounds_query.exit
	ldr	x25, [x1]
	mov	x6, x21
	cbz	x25, LBB214_8
; %bb.5:                                ; %after_bb
	cbnz	x6, LBB214_9
LBB214_6:                               ; %_halide_buffer_is_bounds_query.exit79
	ldr	x4, [x0]
	cbnz	x4, LBB214_9
; %bb.7:                                ; %then_bb4
	ldr	x4, [x0, #40]
	add	w6, w3, #1
	stp	w9, w6, [sp, #32]
Lloh977:
	adrp	x25, lCPI214_0@PAGE
Lloh978:
	ldr	d0, [x25, lCPI214_0@PAGEOFF]
	str	d0, [sp, #40]
	stp	w11, w8, [sp, #48]
	stp	w6, wzr, [sp, #56]
	stp	xzr, xzr, [x0, #8]
	str	xzr, [x0]
	mov	x6, #4097
	movk	x6, #1, lsl #16
	movk	x6, #2, lsl #32
	str	x6, [x0, #32]
	ldp	q0, q1, [sp, #32]
	str	q0, [x4]
	ldr	x4, [x0, #40]
	str	q1, [x4, #16]
	str	xzr, [x0, #24]
	b	LBB214_9
LBB214_8:                               ; %then_bb
	stp	w9, w3, [sp]
Lloh979:
	adrp	x6, lCPI214_0@PAGE
Lloh980:
	ldr	d0, [x6, lCPI214_0@PAGEOFF]
	str	d0, [sp, #8]
	stp	w11, w8, [sp, #16]
	stp	w3, wzr, [sp, #24]
	stp	xzr, xzr, [x1, #8]
	str	xzr, [x1]
	mov	x6, #4097
	movk	x6, #1, lsl #16
	movk	x6, #2, lsl #32
	str	x6, [x1, #32]
	ldp	q0, q1, [sp]
	str	q0, [x4]
	ldr	x4, [x1, #40]
	str	q1, [x4, #16]
	str	xzr, [x1, #24]
	ldr	x6, [x0, #16]
	cbz	x6, LBB214_6
LBB214_9:                               ; %after_bb3
	ldr	x4, [x1, #16]
	cbz	x4, LBB214_12
; %bb.10:
	mov	w1, #0
	ldr	x4, [x0, #16]
	cbz	x4, LBB214_13
LBB214_11:
	mov	w0, #0
	orr	w0, w1, w0
	tbz	w0, #0, LBB214_15
	b	LBB214_14
LBB214_12:                              ; %land.rhs.i86
	ldr	x1, [x1]
	cmp	x1, #0
	cset	w1, eq
	ldr	x4, [x0, #16]
	cbnz	x4, LBB214_11
LBB214_13:                              ; %land.rhs.i92
	ldr	x0, [x0]
	cmp	x0, #0
	cset	w0, eq
	orr	w0, w1, w0
	tbz	w0, #0, LBB214_15
LBB214_14:                              ; %common.ret
	mov	w0, #0
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	ret
LBB214_15:                              ; %then_bb7
	sxtw	x6, w16
	sxtw	x0, w7
	mov	w1, #4097
	movk	w1, #1, lsl #16
	mov	w4, #1
	fmov	d0, x4
	shl.2d	v0, v0, #63
	cmp	w10, w1
	cset	w4, ne
	fmov	d1, x4
	shl.2d	v1, v1, #0
	orr.16b	v1, v1, v0
	cmp	w2, #2
	cset	w4, ne
	fmov	d2, x4
	shl.2d	v2, v2, #1
	orr.16b	v1, v1, v2
	cmp	w15, w1
	cset	w1, ne
	fmov	d2, x1
	shl.2d	v2, v2, #2
	orr.16b	v1, v1, v2
	cmp	w13, #2
	cset	w1, ne
	fmov	d2, x1
	shl.2d	v2, v2, #3
	orr.16b	v1, v1, v2
	lsr	x1, x3, #31
	fmov	d2, x1
	shl.2d	v3, v2, #4
	orr.16b	v1, v1, v3
	lsr	x1, x8, #31
	fmov	d3, x1
	shl.2d	v3, v3, #5
	orr.16b	v1, v1, v3
	cmp	w9, w5
	cset	w1, lt
	add	w4, w3, w9
	add	w25, w6, w5
	cmp	w4, w25
	cset	w26, ge
	orr	w1, w1, w26
	fmov	d3, x1
	shl.2d	v3, v3, #6
	orr.16b	v3, v1, v3
	lsr	x1, x16, #31
	fmov	d1, x1
	shl.2d	v4, v1, #7
	orr.16b	v3, v3, v4
	subs	w1, w11, w14
	cset	w28, lt
	add	w26, w8, w11
	add	w27, w0, w14
	cmp	w26, w27
	cset	w30, gt
	orr	w28, w28, w30
	fmov	d4, x28
	shl.2d	v4, v4, #8
	orr.16b	v3, v3, v4
	lsr	x28, x7, #31
	fmov	d4, x28
	shl.2d	v4, v4, #9
	orr.16b	v3, v3, v4
	cmp	w12, #1
	cset	w28, ne
	fmov	d4, x28
	shl.2d	v4, v4, #10
	orr.16b	v3, v3, v4
	cmp	w17, #1
	cset	w28, ne
	fmov	d4, x28
	shl.2d	v4, v4, #11
	orr.16b	v3, v3, v4
	fmov	x28, d3
	rbit	x28, x28
	clz	x28, x28
	cmp	w28, #11
	b.ls	LBB214_32
; %bb.16:                               ; %no_errors_bb
	mov	x10, x3
	sxtw	x2, w10
	mov	x10, x8
	sxtw	x12, w10
	cmp	x19, #0
	cset	w14, eq
	mul	x10, x12, x2
	mul	x11, x0, x6
	shl.2d	v2, v2, #0
	orr.16b	v0, v2, v0
	mul	x12, x20, x12
	cmp	x12, #0
	cneg	x12, x12, mi
	lsr	x13, x12, #31
	cmp	x13, #0
	cset	w13, ne
	fmov	d2, x13
	shl.2d	v2, v2, #1
	orr.16b	v0, v0, v2
	mov	w15, #2147483647
	cmp	x10, x15
	cset	w13, gt
	fmov	d2, x13
	shl.2d	v2, v2, #2
	orr.16b	v0, v0, v2
	shl.2d	v1, v1, #3
	orr.16b	v0, v0, v1
	mul	x13, x22, x0
	cmp	x13, #0
	cneg	x13, x13, mi
	lsr	x16, x13, #31
	cmp	x16, #0
	cset	w16, ne
	fmov	d1, x16
	shl.2d	v1, v1, #4
	orr.16b	v0, v0, v1
	cmp	x11, x15
	cset	w15, gt
	fmov	d1, x15
	shl.2d	v1, v1, #5
	orr.16b	v0, v0, v1
	ubfx	x15, x23, #1, #1
	fmov	d1, x15
	shl.2d	v1, v1, #6
	orr.16b	v0, v0, v1
	ubfx	x15, x24, #1, #1
	fmov	d1, x15
	shl.2d	v1, v1, #7
	orr.16b	v0, v0, v1
	fmov	d1, x14
	shl.2d	v1, v1, #8
	orr.16b	v0, v0, v1
	cmp	x21, #0
	cset	w14, eq
	fmov	d1, x14
	shl.2d	v1, v1, #9
	orr.16b	v0, v0, v1
	fmov	x14, d0
	rbit	x14, x14
	clz	x14, x14
	cmp	w14, #9
	b.ls	LBB214_34
; %bb.17:                               ; %"produce blur_y"
	cmp	w8, #1
	b.lt	LBB214_14
; %bb.18:                               ; %"for blur_y.s0.y.rebased.preheader"
	cmp	w3, #1
	b.lt	LBB214_14
; %bb.19:                               ; %"for blur_y.s0.y.rebased.us.preheader"
	mov	w17, #0
	mov	x10, #0
	sub	x11, x3, #1
	madd	w9, w22, w1, w9
	sub	w9, w9, w5
	and	x12, x3, #0xfffffff0
	add	x13, x19, #16
	lsr	x14, x11, #32
	mov	x15, x9
	b	LBB214_21
LBB214_20:                              ; %"end for blur_y.s0.x.rebased.loopexit.us"
                                        ;   in Loop: Header=BB214_21 Depth=1
	add	x10, x10, #1
	add	w17, w16, w20
	add	w15, w15, w22
	cmp	x10, x8
	b.eq	LBB214_14
LBB214_21:                              ; %"for blur_y.s0.y.rebased.us"
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB214_27 Depth 2
                                        ;     Child Loop BB214_25 Depth 2
	sxtw	x16, w17
	cmp	w3, #16
	b.lo	LBB214_23
; %bb.22:                               ; %vector.scevcheck
                                        ;   in Loop: Header=BB214_21 Depth=1
	madd	w0, w22, w10, w9
	add	w1, w0, w11
	cmp	w1, w0
	ccmp	x14, #0, #0, ge
	b.eq	LBB214_26
LBB214_23:                              ;   in Loop: Header=BB214_21 Depth=1
	mov	x1, #0
LBB214_24:                              ; %"for blur_y.s0.x.rebased.us.preheader"
                                        ;   in Loop: Header=BB214_21 Depth=1
	sub	x17, x3, x1
	add	x0, x1, x16
	add	x0, x19, x0, lsl #1
	add	w1, w15, w1
LBB214_25:                              ; %"for blur_y.s0.x.rebased.us"
                                        ;   Parent Loop BB214_21 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	x2, x21, w1, sxtw #1
	ldrh	w4, [x2]
	ldrh	w2, [x2, #2]
	add	w2, w2, w4
	strh	w2, [x0], #2
	add	w1, w1, #1
	subs	x17, x17, #1
	b.ne	LBB214_25
	b	LBB214_20
LBB214_26:                              ; %vector.body.preheader
                                        ;   in Loop: Header=BB214_21 Depth=1
	add	x17, x13, w17, sxtw #1
	mov	x0, x15
	mov	x1, x12
LBB214_27:                              ; %vector.body
                                        ;   Parent Loop BB214_21 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	x2, x21, w0, sxtw #1
	ldp	q0, q1, [x2]
	ldur	q2, [x2, #2]
	ldur	q3, [x2, #18]
	add.8h	v0, v2, v0
	add.8h	v1, v3, v1
	stp	q0, q1, [x17, #-16]
	add	x17, x17, #32
	add	w0, w0, #16
	subs	x1, x1, #16
	b.ne	LBB214_27
; %bb.28:                               ; %middle.block
                                        ;   in Loop: Header=BB214_21 Depth=1
	mov	x1, x12
	cmp	x12, x3
	b.eq	LBB214_20
	b	LBB214_24
LBB214_29:                              ; %"assert failed"
Lloh981:
	adrp	x1, l_str@PAGE
Lloh982:
	add	x1, x1, l_str@PAGEOFF
	b	LBB214_31
LBB214_30:                              ; %"assert failed1"
Lloh983:
	adrp	x1, l_str.200@PAGE
Lloh984:
	add	x1, x1, l_str.200@PAGEOFF
	mov	x0, #0
LBB214_31:                              ; %"assert failed"
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_buffer_argument_is_null
LBB214_32:                              ; %then_bb7
Lloh985:
	adrp	x0, LJTI214_0@PAGE
Lloh986:
	add	x0, x0, LJTI214_0@PAGEOFF
	adr	x1, LBB214_33
	ldrb	w6, [x0, x28]
	add	x1, x1, x6, lsl #2
	br	x1
LBB214_33:                              ; %assert_failed
Lloh987:
	adrp	x1, l_str.203@PAGE
Lloh988:
	add	x1, x1, l_str.203@PAGEOFF
	mov	x0, #0
	mov	x2, x10
	b	LBB214_51
LBB214_34:                              ; %no_errors_bb
Lloh989:
	adrp	x8, LJTI214_1@PAGE
Lloh990:
	add	x8, x8, LJTI214_1@PAGEOFF
	adr	x9, LBB214_35
	ldrb	w15, [x8, x14]
	add	x9, x9, x15, lsl #2
	br	x9
LBB214_35:                              ; %assert_failed21
Lloh991:
	adrp	x1, l_str.200@PAGE
Lloh992:
	add	x1, x1, l_str.200@PAGEOFF
	mov	x0, #0
	b	LBB214_40
LBB214_36:                              ; %assert_failed22
Lloh993:
	adrp	x1, l_str.200@PAGE
Lloh994:
	add	x1, x1, l_str.200@PAGEOFF
	mov	x0, #0
	mov	x2, x12
	b	LBB214_40
LBB214_37:                              ; %assert_failed23
Lloh995:
	adrp	x1, l_str.200@PAGE
Lloh996:
	add	x1, x1, l_str.200@PAGEOFF
	mov	x0, #0
	mov	x2, x10
	b	LBB214_42
LBB214_38:                              ; %assert_failed24
Lloh997:
	adrp	x1, l_str@PAGE
Lloh998:
	add	x1, x1, l_str@PAGEOFF
	mov	x0, #0
	mov	x2, x6
	b	LBB214_40
LBB214_39:                              ; %assert_failed25
Lloh999:
	adrp	x1, l_str@PAGE
Lloh1000:
	add	x1, x1, l_str@PAGEOFF
	mov	x0, #0
	mov	x2, x13
LBB214_40:                              ; %assert_failed21
	mov	w3, #2147483647
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_buffer_allocation_too_large
LBB214_41:                              ; %assert_failed26
Lloh1001:
	adrp	x1, l_str@PAGE
Lloh1002:
	add	x1, x1, l_str@PAGEOFF
	mov	x0, #0
	mov	x2, x11
LBB214_42:                              ; %assert_failed23
	mov	w3, #2147483647
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_buffer_extents_too_large
LBB214_43:                              ; %assert_failed27
Lloh1003:
	adrp	x1, l_str.203@PAGE
Lloh1004:
	add	x1, x1, l_str.203@PAGEOFF
	b	LBB214_45
LBB214_44:                              ; %assert_failed28
Lloh1005:
	adrp	x1, l_str.204@PAGE
Lloh1006:
	add	x1, x1, l_str.204@PAGEOFF
LBB214_45:                              ; %assert_failed27
	mov	x0, #0
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_device_dirty_with_no_device_support
LBB214_46:                              ; %assert_failed29
Lloh1007:
	adrp	x1, l_str.203@PAGE
Lloh1008:
	add	x1, x1, l_str.203@PAGEOFF
	b	LBB214_48
LBB214_47:                              ; %assert_failed30
Lloh1009:
	adrp	x1, l_str.204@PAGE
Lloh1010:
	add	x1, x1, l_str.204@PAGEOFF
LBB214_48:                              ; %assert_failed29
	mov	x0, #0
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_host_is_null
LBB214_49:                              ; %assert_failed9
Lloh1011:
	adrp	x1, l_str.203@PAGE
Lloh1012:
	add	x1, x1, l_str.203@PAGEOFF
	mov	x0, #0
	b	LBB214_53
LBB214_50:                              ; %assert_failed10
Lloh1013:
	adrp	x1, l_str.204@PAGE
Lloh1014:
	add	x1, x1, l_str.204@PAGEOFF
	mov	x0, #0
	mov	x2, x15
LBB214_51:                              ; %assert_failed
	mov	w3, #4097
	movk	w3, #1, lsl #16
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_bad_type
LBB214_52:                              ; %assert_failed11
Lloh1015:
	adrp	x1, l_str.204@PAGE
Lloh1016:
	add	x1, x1, l_str.204@PAGEOFF
	mov	x0, #0
	mov	x2, x13
LBB214_53:                              ; %assert_failed9
	mov	w3, #2
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_bad_dimensions
LBB214_54:                              ; %assert_failed12
Lloh1017:
	adrp	x1, l_str.203@PAGE
Lloh1018:
	add	x1, x1, l_str.203@PAGEOFF
	mov	x0, #0
	mov	w2, #0
                                        ; kill: def $w3 killed $w3 killed $x3
	b	LBB214_61
LBB214_55:                              ; %assert_failed13
Lloh1019:
	adrp	x1, l_str.203@PAGE
Lloh1020:
	add	x1, x1, l_str.203@PAGEOFF
	mov	x0, #0
	mov	w2, #1
	mov	x3, x8
	b	LBB214_61
LBB214_56:                              ; %assert_failed14
	sub	w6, w25, #1
Lloh1021:
	adrp	x1, l_str.204@PAGE
Lloh1022:
	add	x1, x1, l_str.204@PAGEOFF
	mov	x0, #0
	mov	w2, #0
	mov	x3, x9
	b	LBB214_59
LBB214_57:                              ; %assert_failed15
Lloh1023:
	adrp	x1, l_str.204@PAGE
Lloh1024:
	add	x1, x1, l_str.204@PAGEOFF
	mov	x0, #0
	mov	w2, #0
	mov	x3, x16
	b	LBB214_61
LBB214_58:                              ; %assert_failed16
	sub	w4, w26, #1
	sub	w6, w27, #1
Lloh1025:
	adrp	x1, l_str.204@PAGE
Lloh1026:
	add	x1, x1, l_str.204@PAGEOFF
	mov	x0, #0
	mov	w2, #1
	mov	x3, x11
	mov	x5, x14
LBB214_59:                              ; %assert_failed14
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_access_out_of_bounds
LBB214_60:                              ; %assert_failed17
Lloh1027:
	adrp	x1, l_str.204@PAGE
Lloh1028:
	add	x1, x1, l_str.204@PAGEOFF
	mov	x0, #0
	mov	w2, #1
	mov	x3, x7
LBB214_61:                              ; %assert_failed12
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_buffer_extents_negative
LBB214_62:                              ; %assert_failed18
Lloh1029:
	adrp	x1, l_str.205@PAGE
Lloh1030:
	add	x1, x1, l_str.205@PAGEOFF
Lloh1031:
	adrp	x3, l_str.206@PAGE
Lloh1032:
	add	x3, x3, l_str.206@PAGEOFF
	mov	x0, #0
	mov	x2, x12
	b	LBB214_64
LBB214_63:                              ; %assert_failed19
Lloh1033:
	adrp	x1, l_str.207@PAGE
Lloh1034:
	add	x1, x1, l_str.207@PAGEOFF
Lloh1035:
	adrp	x3, l_str.206@PAGE
Lloh1036:
	add	x3, x3, l_str.206@PAGEOFF
	mov	x0, #0
	mov	x2, x17
LBB214_64:                              ; %assert_failed18
	mov	w4, #1
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #80]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #160
	b	_halide_error_constraint_violated
	.loh AdrpLdr	Lloh977, Lloh978
	.loh AdrpLdr	Lloh979, Lloh980
	.loh AdrpAdd	Lloh981, Lloh982
	.loh AdrpAdd	Lloh983, Lloh984
	.loh AdrpAdd	Lloh985, Lloh986
	.loh AdrpAdd	Lloh987, Lloh988
	.loh AdrpAdd	Lloh989, Lloh990
	.loh AdrpAdd	Lloh991, Lloh992
	.loh AdrpAdd	Lloh993, Lloh994
	.loh AdrpAdd	Lloh995, Lloh996
	.loh AdrpAdd	Lloh997, Lloh998
	.loh AdrpAdd	Lloh999, Lloh1000
	.loh AdrpAdd	Lloh1001, Lloh1002
	.loh AdrpAdd	Lloh1003, Lloh1004
	.loh AdrpAdd	Lloh1005, Lloh1006
	.loh AdrpAdd	Lloh1007, Lloh1008
	.loh AdrpAdd	Lloh1009, Lloh1010
	.loh AdrpAdd	Lloh1011, Lloh1012
	.loh AdrpAdd	Lloh1013, Lloh1014
	.loh AdrpAdd	Lloh1015, Lloh1016
	.loh AdrpAdd	Lloh1017, Lloh1018
	.loh AdrpAdd	Lloh1019, Lloh1020
	.loh AdrpAdd	Lloh1021, Lloh1022
	.loh AdrpAdd	Lloh1023, Lloh1024
	.loh AdrpAdd	Lloh1025, Lloh1026
	.loh AdrpAdd	Lloh1027, Lloh1028
	.loh AdrpAdd	Lloh1031, Lloh1032
	.loh AdrpAdd	Lloh1029, Lloh1030
	.loh AdrpAdd	Lloh1035, Lloh1036
	.loh AdrpAdd	Lloh1033, Lloh1034
	.section	__TEXT,__const
LJTI214_0:
	.byte	(LBB214_33-LBB214_33)>>2
	.byte	(LBB214_49-LBB214_33)>>2
	.byte	(LBB214_50-LBB214_33)>>2
	.byte	(LBB214_52-LBB214_33)>>2
	.byte	(LBB214_54-LBB214_33)>>2
	.byte	(LBB214_55-LBB214_33)>>2
	.byte	(LBB214_56-LBB214_33)>>2
	.byte	(LBB214_57-LBB214_33)>>2
	.byte	(LBB214_58-LBB214_33)>>2
	.byte	(LBB214_60-LBB214_33)>>2
	.byte	(LBB214_62-LBB214_33)>>2
	.byte	(LBB214_63-LBB214_33)>>2
LJTI214_1:
	.byte	(LBB214_35-LBB214_35)>>2
	.byte	(LBB214_36-LBB214_35)>>2
	.byte	(LBB214_37-LBB214_35)>>2
	.byte	(LBB214_38-LBB214_35)>>2
	.byte	(LBB214_39-LBB214_35)>>2
	.byte	(LBB214_41-LBB214_35)>>2
	.byte	(LBB214_43-LBB214_35)>>2
	.byte	(LBB214_44-LBB214_35)>>2
	.byte	(LBB214_46-LBB214_35)>>2
	.byte	(LBB214_47-LBB214_35)>>2
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_halide_blur_argv               ; -- Begin function halide_blur_argv
	.p2align	2
_halide_blur_argv:                      ; @halide_blur_argv
; %bb.0:                                ; %entry
	ldp	x8, x1, [x0]
	mov	x0, x8
	b	_halide_blur
                                        ; -- End function
	.globl	_halide_blur_metadata           ; -- Begin function halide_blur_metadata
	.p2align	2
_halide_blur_metadata:                  ; @halide_blur_metadata
; %bb.0:                                ; %entry
Lloh1037:
	adrp	x0, l_halide_blur_metadata_storage@PAGE
Lloh1038:
	add	x0, x0, l_halide_blur_metadata_storage@PAGEOFF
	ret
	.loh AdrpAdd	Lloh1037, Lloh1038
                                        ; -- End function
	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal13custom_mallocE ; @_ZN6Halide7Runtime8Internal13custom_mallocE
	.weak_definition	__ZN6Halide7Runtime8Internal13custom_mallocE
	.p2align	3
__ZN6Halide7Runtime8Internal13custom_mallocE:
	.quad	_halide_default_malloc

	.globl	__ZN6Halide7Runtime8Internal11custom_freeE ; @_ZN6Halide7Runtime8Internal11custom_freeE
	.weak_definition	__ZN6Halide7Runtime8Internal11custom_freeE
	.p2align	3
__ZN6Halide7Runtime8Internal11custom_freeE:
	.quad	_halide_default_free

	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Error: "

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal13error_handlerE ; @_ZN6Halide7Runtime8Internal13error_handlerE
	.weak_definition	__ZN6Halide7Runtime8Internal13error_handlerE
	.p2align	3
__ZN6Halide7Runtime8Internal13error_handlerE:
	.quad	_halide_default_error

	.globl	__ZN6Halide7Runtime8Internal12custom_printE ; @_ZN6Halide7Runtime8Internal12custom_printE
	.weak_definition	__ZN6Halide7Runtime8Internal12custom_printE
	.p2align	3
__ZN6Halide7Runtime8Internal12custom_printE:
	.quad	_halide_default_print

	.globl	__ZN6Halide7Runtime8Internal29halide_reference_clock_initedE ; @_ZN6Halide7Runtime8Internal29halide_reference_clock_initedE
	.weak_definition	__ZN6Halide7Runtime8Internal29halide_reference_clock_initedE
__ZN6Halide7Runtime8Internal29halide_reference_clock_initedE:
	.byte	0                               ; 0x0

	.globl	__ZN6Halide7Runtime8Internal22halide_reference_clockE ; @_ZN6Halide7Runtime8Internal22halide_reference_clockE
	.weak_definition	__ZN6Halide7Runtime8Internal22halide_reference_clockE
	.p2align	3
__ZN6Halide7Runtime8Internal22halide_reference_clockE:
	.quad	0                               ; 0x0

	.globl	__ZN6Halide7Runtime8Internal20halide_timebase_infoE ; @_ZN6Halide7Runtime8Internal20halide_timebase_infoE
	.weak_definition	__ZN6Halide7Runtime8Internal20halide_timebase_infoE
	.p2align	2
__ZN6Halide7Runtime8Internal20halide_timebase_infoE:
	.space	8

	.section	__DATA,__mod_term_func,mod_term_funcs
	.p2align	3
	.quad	_halide_thread_pool_cleanup
	.quad	_halide_trace_cleanup
	.quad	_halide_cache_cleanup
	.quad	_halide_profiler_shutdown
	.section	__TEXT,__cstring,cstring_literals
l_.str.5:                               ; @.str.5
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/synchronization_common.h:386 halide_abort_if_false() failed: next != nullptr\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal15Synchronization5tableE ; @_ZN6Halide7Runtime8Internal15Synchronization5tableE
	.weak_definition	__ZN6Halide7Runtime8Internal15Synchronization5tableE
	.p2align	3
__ZN6Halide7Runtime8Internal15Synchronization5tableE:
	.space	24576

	.section	__TEXT,__cstring,cstring_literals
l_.str.1:                               ; @.str.1
	.asciz	"HL_NUM_THREADS"

l_.str.2:                               ; @.str.2
	.asciz	"HL_NUMTHREADS"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal10work_queueE ; @_ZN6Halide7Runtime8Internal10work_queueE
	.weak_definition	__ZN6Halide7Runtime8Internal10work_queueE
	.p2align	3
__ZN6Halide7Runtime8Internal10work_queueE:
	.space	8
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	0
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.space	4
	.space	8
	.space	8
	.space	8
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.space	2048
	.byte	0                               ; 0x0
	.byte	0                               ; 0x0
	.space	2
	.long	0                               ; 0x0

	.section	__TEXT,__cstring,cstring_literals
l_.str.3:                               ; @.str.3
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/thread_pool_common.h:527 halide_abort_if_false() failed: (min_threads <= ((task_parent->task.min_threads * task_parent->active_workers) - task_parent->threads_reserved)) && \"Logic error: thread over commit.\\n\"\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal14custom_do_taskE ; @_ZN6Halide7Runtime8Internal14custom_do_taskE
	.weak_definition	__ZN6Halide7Runtime8Internal14custom_do_taskE
	.p2align	3
__ZN6Halide7Runtime8Internal14custom_do_taskE:
	.quad	_halide_default_do_task

	.globl	__ZN6Halide7Runtime8Internal19custom_do_loop_taskE ; @_ZN6Halide7Runtime8Internal19custom_do_loop_taskE
	.weak_definition	__ZN6Halide7Runtime8Internal19custom_do_loop_taskE
	.p2align	3
__ZN6Halide7Runtime8Internal19custom_do_loop_taskE:
	.quad	_halide_default_do_loop_task

	.globl	__ZN6Halide7Runtime8Internal17custom_do_par_forE ; @_ZN6Halide7Runtime8Internal17custom_do_par_forE
	.weak_definition	__ZN6Halide7Runtime8Internal17custom_do_par_forE
	.p2align	3
__ZN6Halide7Runtime8Internal17custom_do_par_forE:
	.quad	_halide_default_do_par_for

	.globl	__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE ; @_ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE
	.weak_definition	__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE
	.p2align	3
__ZN6Halide7Runtime8Internal24custom_do_parallel_tasksE:
	.quad	_halide_default_do_parallel_tasks

	.globl	__ZN6Halide7Runtime8Internal21custom_semaphore_initE ; @_ZN6Halide7Runtime8Internal21custom_semaphore_initE
	.weak_definition	__ZN6Halide7Runtime8Internal21custom_semaphore_initE
	.p2align	3
__ZN6Halide7Runtime8Internal21custom_semaphore_initE:
	.quad	_halide_default_semaphore_init

	.globl	__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE ; @_ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE
	.weak_definition	__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE
	.p2align	3
__ZN6Halide7Runtime8Internal28custom_semaphore_try_acquireE:
	.quad	_halide_default_semaphore_try_acquire

	.globl	__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE ; @_ZN6Halide7Runtime8Internal24custom_semaphore_releaseE
	.weak_definition	__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE
	.p2align	3
__ZN6Halide7Runtime8Internal24custom_semaphore_releaseE:
	.quad	_halide_default_semaphore_release

	.section	__TEXT,__cstring,cstring_literals
l_.str.4:                               ; @.str.4
	.asciz	"halide_set_num_threads: must be >= 0."

	.section	__DATA,__const
	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE ; @_ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE
	.weak_def_can_be_hidden	__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE
	.p2align	3
__ZTVN6Halide7Runtime8Internal15Synchronization21mutex_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization21mutex_parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE ; @_ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE
	.weak_def_can_be_hidden	__ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE
	.p2align	3
__ZTVN6Halide7Runtime8Internal15Synchronization25broadcast_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization25broadcast_parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE ; @_ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE
	.weak_def_can_be_hidden	__ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE
	.p2align	3
__ZTVN6Halide7Runtime8Internal15Synchronization22signal_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization22signal_parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.section	__TEXT,__cstring,cstring_literals
l_.str.5.6:                             ; @.str.5.6
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/synchronization_common.h:994 halide_abort_if_false() failed: val & 0x1\n"

	.section	__DATA,__const
	.globl	__ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE ; @_ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE
	.weak_def_can_be_hidden	__ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE
	.p2align	3
__ZTVN6Halide7Runtime8Internal15Synchronization20wait_parking_controlE:
	.quad	0
	.quad	0
	.quad	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control8validateERNS2_15validate_actionE
	.quad	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control12before_sleepEv
	.quad	__ZN6Halide7Runtime8Internal15Synchronization20wait_parking_control6unparkEib
	.quad	__ZN6Halide7Runtime8Internal15Synchronization15parking_control16requeue_callbackERKNS2_15validate_actionEbb

	.section	__TEXT,__cstring,cstring_literals
l_.str.6:                               ; @.str.6
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/thread_pool_common.h:155 halide_abort_if_false() failed: bytes == limit && \"Logic error in thread pool work queue initialization.\\n\"\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal17custom_get_symbolE ; @_ZN6Halide7Runtime8Internal17custom_get_symbolE
	.weak_definition	__ZN6Halide7Runtime8Internal17custom_get_symbolE
	.p2align	3
__ZN6Halide7Runtime8Internal17custom_get_symbolE:
	.quad	_halide_default_get_symbol

	.globl	__ZN6Halide7Runtime8Internal19custom_load_libraryE ; @_ZN6Halide7Runtime8Internal19custom_load_libraryE
	.weak_definition	__ZN6Halide7Runtime8Internal19custom_load_libraryE
	.p2align	3
__ZN6Halide7Runtime8Internal19custom_load_libraryE:
	.quad	_halide_default_load_library

	.globl	__ZN6Halide7Runtime8Internal25custom_get_library_symbolE ; @_ZN6Halide7Runtime8Internal25custom_get_library_symbolE
	.weak_definition	__ZN6Halide7Runtime8Internal25custom_get_library_symbolE
	.p2align	3
__ZN6Halide7Runtime8Internal25custom_get_library_symbolE:
	.quad	_halide_default_get_library_symbol

	.globl	__ZN6Halide7Runtime8Internal17halide_gpu_deviceE ; @_ZN6Halide7Runtime8Internal17halide_gpu_deviceE
	.weak_definition	__ZN6Halide7Runtime8Internal17halide_gpu_deviceE
	.p2align	2
__ZN6Halide7Runtime8Internal17halide_gpu_deviceE:
	.long	0                               ; 0x0

	.globl	__ZN6Halide7Runtime8Internal22halide_gpu_device_lockE ; @_ZN6Halide7Runtime8Internal22halide_gpu_device_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal22halide_gpu_device_lockE
__ZN6Halide7Runtime8Internal22halide_gpu_device_lockE:
	.byte	0                               ; 0x0

	.globl	__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE ; @_ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE
	.weak_definition	__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE
__ZN6Halide7Runtime8Internal29halide_gpu_device_initializedE:
	.byte	0                               ; 0x0

	.section	__TEXT,__cstring,cstring_literals
l_.str.8:                               ; @.str.8
	.asciz	"HL_GPU_DEVICE"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal19halide_trace_bufferE ; @_ZN6Halide7Runtime8Internal19halide_trace_bufferE
	.weak_definition	__ZN6Halide7Runtime8Internal19halide_trace_bufferE
	.p2align	3
__ZN6Halide7Runtime8Internal19halide_trace_bufferE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal17halide_trace_fileE ; @_ZN6Halide7Runtime8Internal17halide_trace_fileE
	.weak_definition	__ZN6Halide7Runtime8Internal17halide_trace_fileE
	.p2align	2
__ZN6Halide7Runtime8Internal17halide_trace_fileE:
	.long	4294967295                      ; 0xffffffff

	.globl	__ZN6Halide7Runtime8Internal22halide_trace_file_lockE ; @_ZN6Halide7Runtime8Internal22halide_trace_file_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal22halide_trace_file_lockE
__ZN6Halide7Runtime8Internal22halide_trace_file_lockE:
	.byte	0                               ; 0x0

	.globl	__ZN6Halide7Runtime8Internal29halide_trace_file_initializedE ; @_ZN6Halide7Runtime8Internal29halide_trace_file_initializedE
	.weak_definition	__ZN6Halide7Runtime8Internal29halide_trace_file_initializedE
__ZN6Halide7Runtime8Internal29halide_trace_file_initializedE:
	.byte	0                               ; 0x0

	.globl	__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE ; @_ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE
	.weak_definition	__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE
	.p2align	3
__ZN6Halide7Runtime8Internal35halide_trace_file_internally_openedE:
	.quad	0

	.p2align	2                               ; @_ZZ20halide_default_traceE3ids
__ZZ20halide_default_traceE3ids:
	.long	1                               ; 0x1

	.section	__TEXT,__cstring,cstring_literals
l_.str.1.10:                            ; @.str.1.10
	.space	1

l_.str.2.11:                            ; @.str.2.11
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/tracing.cpp:218 halide_abort_if_false() failed: print_bits <= 64 && \"Tracing bad type\"\n"

l_.str.3.12:                            ; @.str.3.12
	.asciz	"Load"

l_.str.4.13:                            ; @.str.4.13
	.asciz	"Store"

l_.str.5.14:                            ; @.str.5.14
	.asciz	"Begin realization"

l_.str.6.15:                            ; @.str.6.15
	.asciz	"End realization"

l_.str.7:                               ; @.str.7
	.asciz	"Produce"

l_.str.8.16:                            ; @.str.8.16
	.asciz	"End produce"

l_.str.9.17:                            ; @.str.9.17
	.asciz	"Consume"

l_.str.10:                              ; @.str.10
	.asciz	"End consume"

l_.str.11:                              ; @.str.11
	.asciz	"Begin pipeline"

l_.str.12:                              ; @.str.12
	.asciz	"End pipeline"

l_.str.13:                              ; @.str.13
	.asciz	"Tag"

	.section	__DATA,__const
	.p2align	3                               ; @__const.halide_default_trace.event_types
l___const.halide_default_trace.event_types:
	.quad	l_.str.3.12
	.quad	l_.str.4.13
	.quad	l_.str.5.14
	.quad	l_.str.6.15
	.quad	l_.str.7
	.quad	l_.str.8.16
	.quad	l_.str.9.17
	.quad	l_.str.10
	.quad	l_.str.11
	.quad	l_.str.12
	.quad	l_.str.13

	.section	__TEXT,__cstring,cstring_literals
l_.str.17:                              ; @.str.17
	.asciz	"<"

l_.str.18:                              ; @.str.18
	.asciz	">, <"

l_.str.20:                              ; @.str.20
	.asciz	">)"

l_.str.22:                              ; @.str.22
	.asciz	" = <"

l_.str.23:                              ; @.str.23
	.asciz	" = "

l_.str.24:                              ; @.str.24
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/tracing.cpp:287 halide_abort_if_false() failed: print_bits >= 16 && \"Tracing a bad type\"\n"

l_.str.25:                              ; @.str.25
	.asciz	">"

l_.str.26:                              ; @.str.26
	.asciz	" tag = \""

l_.str.27:                              ; @.str.27
	.asciz	"\""

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal19halide_custom_traceE ; @_ZN6Halide7Runtime8Internal19halide_custom_traceE
	.weak_definition	__ZN6Halide7Runtime8Internal19halide_custom_traceE
	.p2align	3
__ZN6Halide7Runtime8Internal19halide_custom_traceE:
	.quad	_halide_default_trace

	.section	__TEXT,__cstring,cstring_literals
l_.str.28:                              ; @.str.28
	.asciz	"HL_TRACE_FILE"

l_.str.29:                              ; @.str.29
	.asciz	"ab"

l_.str.30:                              ; @.str.30
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/tracing.cpp:351 halide_abort_if_false() failed: file && \"Failed to open trace file\\n\"\n"

l_.str.31:                              ; @.str.31
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/tracing.cpp:87 halide_abort_if_false() failed: size <= buffer_size\n"

l_.str.32:                              ; @.str.32
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/tracing.cpp:115 halide_abort_if_false() failed: success && \"Could not write to trace file\"\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE ; @_ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE
	.weak_definition	__ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE
	.p2align	1
__ZN6Halide7Runtime8Internal30pixel_type_to_tiff_sample_typeE:
	.short	3                               ; 0x3
	.short	3                               ; 0x3
	.short	1                               ; 0x1
	.short	2                               ; 0x2
	.short	1                               ; 0x1
	.short	2                               ; 0x2
	.short	1                               ; 0x1
	.short	2                               ; 0x2
	.short	1                               ; 0x1
	.short	2                               ; 0x2

	.globl	__ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE ; @_ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE
	.weak_definition	__ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE
__ZN6Halide7Runtime8Internal31pixel_type_to_matlab_class_codeE:
	.ascii	"\007\006\t\b\013\n\r\f\017\016"

	.globl	__ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE ; @_ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE
	.weak_definition	__ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE
__ZN6Halide7Runtime8Internal30pixel_type_to_matlab_type_codeE:
	.ascii	"\007\t\002\001\004\003\006\005\r\f"

	.section	__TEXT,__cstring,cstring_literals
l_.str.34:                              ; @.str.34
	.asciz	"Bounds query buffer passed to halide_debug_to_file"

l_.str.1.35:                            ; @.str.1.35
	.asciz	"Can't debug_to_file a Func with more than four dimensions\n"

l_.str.2.36:                            ; @.str.2.36
	.asciz	"wb"

l_.str.3.37:                            ; @.str.3.37
	.asciz	".tiff"

l_.str.4.38:                            ; @.str.4.38
	.asciz	".tif"

l_.str.5.39:                            ; @.str.5.39
	.asciz	".mat"

	.section	__TEXT,__const
l___const.halide_debug_to_file.header:  ; @__const.halide_debug_to_file.header
	.asciz	"MATLAB 5.0 MAT-file, produced by Halide                                                                                     \000\001IM"

	.section	__TEXT,__cstring,cstring_literals
l_.str.6.40:                            ; @.str.6.40
	.asciz	"Can't debug_to_file to a .mat file greater than 4GB\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal16memoization_lockE ; @_ZN6Halide7Runtime8Internal16memoization_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal16memoization_lockE
	.p2align	3
__ZN6Halide7Runtime8Internal16memoization_lockE:
	.space	8

	.globl	__ZN6Halide7Runtime8Internal13cache_entriesE ; @_ZN6Halide7Runtime8Internal13cache_entriesE
	.weak_definition	__ZN6Halide7Runtime8Internal13cache_entriesE
	.p2align	3
__ZN6Halide7Runtime8Internal13cache_entriesE:
	.space	2048

	.globl	__ZN6Halide7Runtime8Internal18most_recently_usedE ; @_ZN6Halide7Runtime8Internal18most_recently_usedE
	.weak_definition	__ZN6Halide7Runtime8Internal18most_recently_usedE
	.p2align	3
__ZN6Halide7Runtime8Internal18most_recently_usedE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal19least_recently_usedE ; @_ZN6Halide7Runtime8Internal19least_recently_usedE
	.weak_definition	__ZN6Halide7Runtime8Internal19least_recently_usedE
	.p2align	3
__ZN6Halide7Runtime8Internal19least_recently_usedE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal14max_cache_sizeE ; @_ZN6Halide7Runtime8Internal14max_cache_sizeE
	.weak_definition	__ZN6Halide7Runtime8Internal14max_cache_sizeE
	.p2align	3
__ZN6Halide7Runtime8Internal14max_cache_sizeE:
	.quad	1048576                         ; 0x100000

	.globl	__ZN6Halide7Runtime8Internal18current_cache_sizeE ; @_ZN6Halide7Runtime8Internal18current_cache_sizeE
	.weak_definition	__ZN6Halide7Runtime8Internal18current_cache_sizeE
	.p2align	3
__ZN6Halide7Runtime8Internal18current_cache_sizeE:
	.quad	0                               ; 0x0

	.section	__TEXT,__cstring,cstring_literals
l_.str.2.42:                            ; @.str.2.42
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/cache.cpp:284 halide_abort_if_false() failed: prev_hash_entry != nullptr\n"

l_.str.3.43:                            ; @.str.3.43
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/cache.cpp:373 halide_abort_if_false() failed: entry->more_recent != nullptr\n"

l_.str.4.44:                            ; @.str.4.44
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/cache.cpp:377 halide_abort_if_false() failed: least_recently_used == entry\n"

l_.str.5.45:                            ; @.str.5.45
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/cache.cpp:380 halide_abort_if_false() failed: entry->more_recent != nullptr\n"

l_.str.9.46:                            ; @.str.9.46
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/cache.cpp:472 halide_abort_if_false() failed: no_host_pointers_equal\n"

l_.str.12.47:                           ; @.str.12.47
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/cache.cpp:550 halide_abort_if_false() failed: entry->in_use_count > 0\n"

l_.str.50:                              ; @.str.50
	.asciz	"<nullptr>"

l_.str.1.57:                            ; @.str.1.57
	.asciz	"-nan"

l_.str.2.58:                            ; @.str.2.58
	.asciz	"nan"

l_.str.3.59:                            ; @.str.3.59
	.asciz	"-inf"

l_.str.4.60:                            ; @.str.4.60
	.asciz	"inf"

l_.str.5.61:                            ; @.str.5.61
	.asciz	"-0.000000e+00"

l_.str.6.62:                            ; @.str.6.62
	.asciz	"0.000000e+00"

l_.str.7.63:                            ; @.str.7.63
	.asciz	"-0.000000"

l_.str.8.64:                            ; @.str.8.64
	.asciz	"0.000000"

l_.str.9.65:                            ; @.str.9.65
	.asciz	"-"

l_.str.11.67:                           ; @.str.11.67
	.asciz	"e+"

l_.str.12.68:                           ; @.str.12.68
	.asciz	"e-"

l_.str.13.71:                           ; @.str.13.71
	.asciz	"0123456789abcdef"

l_.str.14.76:                           ; @.str.14.76
	.asciz	"int"

l_.str.15.75:                           ; @.str.15.75
	.asciz	"uint"

l_.str.16.74:                           ; @.str.16.74
	.asciz	"float"

l_.str.17.73:                           ; @.str.17.73
	.asciz	"handle"

l_.str.18.72:                           ; @.str.18.72
	.asciz	"bad_type_code"

l_.str.19.77:                           ; @.str.19.77
	.asciz	"x"

l_.str.20.78:                           ; @.str.20.78
	.asciz	"nullptr"

l_.str.21.79:                           ; @.str.21.79
	.asciz	"buffer("

l_.str.23.82:                           ; @.str.23.82
	.asciz	", {"

l_.str.24.83:                           ; @.str.24.83
	.asciz	"}"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE ; @_ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE
	.weak_definition	__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE
__ZN6Halide7Runtime8Internal36halide_reuse_device_allocations_flagE:
	.byte	1                               ; 0x1

	.globl	__ZN6Halide7Runtime8Internal21allocation_pools_lockE ; @_ZN6Halide7Runtime8Internal21allocation_pools_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal21allocation_pools_lockE
	.p2align	3
__ZN6Halide7Runtime8Internal21allocation_pools_lockE:
	.space	8

	.globl	__ZN6Halide7Runtime8Internal23device_allocation_poolsE ; @_ZN6Halide7Runtime8Internal23device_allocation_poolsE
	.weak_definition	__ZN6Halide7Runtime8Internal23device_allocation_poolsE
	.p2align	3
__ZN6Halide7Runtime8Internal23device_allocation_poolsE:
	.quad	0

	.globl	__ZN6Halide7Runtime8Internal17device_copy_mutexE ; @_ZN6Halide7Runtime8Internal17device_copy_mutexE
	.weak_definition	__ZN6Halide7Runtime8Internal17device_copy_mutexE
	.p2align	3
__ZN6Halide7Runtime8Internal17device_copy_mutexE:
	.space	8

	.section	__TEXT,__cstring,cstring_literals
l_.str.6.88:                            ; @.str.6.88
	.asciz	"halide_copy_to_host"

l_.str.7.89:                            ; @.str.7.89
	.asciz	"halide_copy_to_device"

l_.str.9.90:                            ; @.str.9.90
	.asciz	"halide_copy_to_device does not support switching interfaces\n"

l_.str.16.93:                           ; @.str.16.93
	.asciz	"halide_device_sync"

l_.str.17.91:                           ; @.str.17.91
	.asciz	"halide_device_malloc"

l_.str.20.92:                           ; @.str.20.92
	.asciz	"halide_device_malloc doesn't support switching interfaces\n"

l_.str.21.96:                           ; @.str.21.96
	.asciz	"halide_device_free"

l_.str.22.97:                           ; @.str.22.97
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/device_interface.cpp:252 halide_abort_if_false() failed: buf->device == 0\n"

l_.str.23.98:                           ; @.str.23.98
	.asciz	"halide_device_and_host_malloc"

l_.str.25.99:                           ; @.str.25.99
	.asciz	"halide_device_and_host_malloc doesn't support switching interfaces\n"

l_.str.26.100:                          ; @.str.26.100
	.asciz	"allocating host and device memory failed\n"

l_.str.27.101:                          ; @.str.27.101
	.asciz	"halide_device_and_host_free"

l_.str.28.102:                          ; @.str.28.102
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/device_interface.cpp:317 halide_abort_if_false() failed: buf->device == 0\n"

l_.str.29.103:                          ; @.str.29.103
	.asciz	"halide_default_device_and_host_malloc"

l_.str.30.104:                          ; @.str.30.104
	.asciz	"halide_default_device_and_host_free"

l_.str.31.105:                          ; @.str.31.105
	.asciz	"halide_device_wrap_native"

l_.str.32.106:                          ; @.str.32.106
	.asciz	"halide_device_wrap_native doesn't support switching interfaces\n"

l_.str.33.107:                          ; @.str.33.107
	.asciz	"halide_device_detach_native"

l_.str.34.108:                          ; @.str.34.108
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/device_interface.cpp:403 halide_abort_if_false() failed: buf->device == 0\n"

l_.str.35:                              ; @.str.35
	.asciz	"halide_default_device_detach_native"

l_.str.41:                              ; @.str.41
	.asciz	"halide_buffer_copy does not support switching device interfaces"

l_.str.58:                              ; @.str.58
	.asciz	"device_interface does not support cropping\n"

l_.str.59:                              ; @.str.59
	.asciz	"device_interface does not support slicing\n"

l_.str.60:                              ; @.str.60
	.asciz	"destination buffer already has a device allocation\n"

l_.str.61:                              ; @.str.61
	.asciz	"src and dst must have identical dimensionality\n"

l_.str.64:                              ; @.str.64
	.asciz	"dst must have exactly one fewer dimension than src\n"

l_.str.111:                             ; @.str.111
	.asciz	"Bounds inference call to external stage "

l_.str.1.112:                           ; @.str.1.112
	.asciz	" returned non-zero value: "

l_.str.2.113:                           ; @.str.2.113
	.asciz	"Call to external stage "

l_.str.3.114:                           ; @.str.3.114
	.asciz	"Bounds given for "

l_.str.4.115:                           ; @.str.4.115
	.asciz	" in "

l_.str.5.116:                           ; @.str.5.116
	.asciz	" (from "

l_.str.6.117:                           ; @.str.6.117
	.asciz	" to "

l_.str.7.118:                           ; @.str.7.118
	.asciz	") do not cover required region (from "

l_.str.8.119:                           ; @.str.8.119
	.asciz	")"

l_.str.9.120:                           ; @.str.9.120
	.asciz	" has type "

l_.str.10.121:                          ; @.str.10.121
	.asciz	" but type of the buffer passed in is "

l_.str.11.122:                          ; @.str.11.122
	.asciz	" requires a buffer of exactly "

l_.str.12.123:                          ; @.str.12.123
	.asciz	" dimensions, but the buffer passed in has "

l_.str.13.124:                          ; @.str.13.124
	.asciz	" dimensions"

l_.str.14.125:                          ; @.str.14.125
	.asciz	" is accessed at "

l_.str.15.126:                          ; @.str.15.126
	.asciz	", which is before the min ("

l_.str.16.127:                          ; @.str.16.127
	.asciz	") in dimension "

l_.str.17.128:                          ; @.str.17.128
	.asciz	", which is beyond the max ("

l_.str.18.129:                          ; @.str.18.129
	.asciz	"Total allocation for buffer "

l_.str.19.130:                          ; @.str.19.130
	.asciz	" is "

l_.str.20.131:                          ; @.str.20.131
	.asciz	", which exceeds the maximum size of "

l_.str.21.132:                          ; @.str.21.132
	.asciz	"The extents for buffer "

l_.str.22.133:                          ; @.str.22.133
	.asciz	" dimension "

l_.str.23.134:                          ; @.str.23.134
	.asciz	" is negative ("

l_.str.24.135:                          ; @.str.24.135
	.asciz	"Product of extents for buffer "

l_.str.25.136:                          ; @.str.25.136
	.asciz	"Applying the constraints on "

l_.str.26.137:                          ; @.str.26.137
	.asciz	" to the required region made it smaller in dimension "

l_.str.27.138:                          ; @.str.27.138
	.asciz	". "

l_.str.28.139:                          ; @.str.28.139
	.asciz	"Required size: "

l_.str.29.140:                          ; @.str.29.140
	.asciz	"Constrained size: "

l_.str.30.141:                          ; @.str.30.141
	.asciz	"."

l_.str.31.142:                          ; @.str.31.142
	.asciz	"Constraint violated: "

l_.str.32.143:                          ; @.str.32.143
	.asciz	" ("

l_.str.33.144:                          ; @.str.33.144
	.asciz	") == "

l_.str.34.145:                          ; @.str.34.145
	.asciz	"Parameter "

l_.str.35.146:                          ; @.str.35.146
	.asciz	" but must be at least "

l_.str.36:                              ; @.str.36
	.asciz	" but must be at most "

l_.str.37:                              ; @.str.37
	.asciz	"Out of memory (halide_malloc returned nullptr)"

l_.str.38:                              ; @.str.38
	.asciz	"Buffer argument "

l_.str.39:                              ; @.str.39
	.asciz	" is nullptr"

l_.str.40:                              ; @.str.40
	.asciz	"Failed to dump function "

l_.str.41.147:                          ; @.str.41.147
	.asciz	" to file "

l_.str.42:                              ; @.str.42
	.asciz	" with error "

l_.str.43:                              ; @.str.43
	.asciz	"The host pointer of "

l_.str.44:                              ; @.str.44
	.asciz	" is not aligned to a "

l_.str.45:                              ; @.str.45
	.asciz	" bytes boundary."

l_.str.46:                              ; @.str.46
	.asciz	"The buffer "

l_.str.47:                              ; @.str.47
	.asciz	" is dirty on device, but this pipeline was compiled "

l_.str.48:                              ; @.str.48
	.asciz	"with no support for device to host copies."

l_.str.49:                              ; @.str.49
	.asciz	" is null, but the pipeline will access it on the host."

l_.str.50.148:                          ; @.str.50.148
	.asciz	"The folded storage dimension "

l_.str.51:                              ; @.str.51
	.asciz	" of "

l_.str.52:                              ; @.str.52
	.asciz	" was accessed out of order by loop "

l_.str.53:                              ; @.str.53
	.asciz	"Cannot fold dimension "

l_.str.54:                              ; @.str.54
	.asciz	" because an extern stage accesses ["

l_.str.55:                              ; @.str.55
	.asciz	", "

l_.str.56:                              ; @.str.56
	.asciz	"],"

l_.str.57:                              ; @.str.57
	.asciz	" which is outside the range currently valid: ["

l_.str.58.149:                          ; @.str.58.149
	.asciz	"]."

l_.str.59.150:                          ; @.str.59.150
	.asciz	" which wraps around the boundary of the fold, "

l_.str.60.151:                          ; @.str.60.151
	.asciz	"which occurs at multiples of "

l_.str.61.152:                          ; @.str.61.152
	.asciz	"The fold factor ("

l_.str.62:                              ; @.str.62
	.asciz	") of dimension "

l_.str.63:                              ; @.str.63
	.asciz	" is too small to store the required region accessed by loop "

l_.str.64.153:                          ; @.str.64.153
	.asciz	")."

l_.str.65:                              ; @.str.65
	.asciz	"Requirement Failed: ("

l_.str.66:                              ; @.str.66
	.asciz	") "

l_.str.67:                              ; @.str.67
	.asciz	"A schedule specialized with specialize_fail() was chosen: "

l_.str.68:                              ; @.str.68
	.asciz	"Buffer has a non-zero device but no device interface.\n"

l_.str.69:                              ; @.str.69
	.asciz	"Buffer has a non-null device_interface but device is 0.\n"

l_.str.70:                              ; @.str.70
	.asciz	"Buffer has both host and device dirty bits set.\n"

l_.str.71:                              ; @.str.71
	.asciz	"Buffer pointer passed to "

l_.str.72:                              ; @.str.72
	.asciz	" is null.\n"

l_.str.73:                              ; @.str.73
	.asciz	"The explicit allocation bound ("

l_.str.74:                              ; @.str.74
	.asciz	" is too small to store the required region ("

l_.str.75:                              ; @.str.75
	.asciz	"Buffer could not be cropped (runtime error or unimplemented device option).\n"

	.section	__DATA,__data
	.p2align	3                               ; @_ZZ25halide_profiler_get_stateE1s
__ZZ25halide_profiler_get_stateE1s:
	.space	8
	.long	1                               ; 0x1
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.long	0                               ; 0x0
	.quad	0
	.quad	0
	.quad	0

	.section	__TEXT,__cstring,cstring_literals
l_.str.186:                             ; @.str.186
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/profiler_common.cpp:246 halide_abort_if_false() failed: p_stats != nullptr\n"

l_.str.1.187:                           ; @.str.1.187
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/profiler_common.cpp:273 halide_abort_if_false() failed: p_stats != nullptr\n"

l_.str.2.188:                           ; @.str.2.188
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/profiler_common.cpp:274 halide_abort_if_false() failed: func_id >= 0\n"

l_.str.3.189:                           ; @.str.3.189
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/profiler_common.cpp:275 halide_abort_if_false() failed: func_id < p_stats->num_funcs\n"

l_.str.4.190:                           ; @.str.4.190
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/profiler_common.cpp:309 halide_abort_if_false() failed: p_stats != nullptr\n"

l_.str.5.191:                           ; @.str.5.191
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/profiler_common.cpp:310 halide_abort_if_false() failed: func_id >= 0\n"

l_.str.6.192:                           ; @.str.6.192
	.asciz	"/Users/smadadi/Projects/halide_16_for_llvm14/src/runtime/profiler_common.cpp:311 halide_abort_if_false() failed: func_id < p_stats->num_funcs\n"

l_.str.7.164:                           ; @.str.7.164
	.asciz	"\n"

l_.str.8.165:                           ; @.str.8.165
	.asciz	" total time: "

l_.str.9.166:                           ; @.str.9.166
	.asciz	" ms"

l_.str.10.167:                          ; @.str.10.167
	.asciz	"  samples: "

l_.str.11.168:                          ; @.str.11.168
	.asciz	"  runs: "

l_.str.12.169:                          ; @.str.12.169
	.asciz	"  time/run: "

l_.str.13.170:                          ; @.str.13.170
	.asciz	" ms\n"

l_.str.14.171:                          ; @.str.14.171
	.asciz	" average threads used: "

l_.str.15.172:                          ; @.str.15.172
	.asciz	" heap allocations: "

l_.str.16.173:                          ; @.str.16.173
	.asciz	"  peak heap usage: "

l_.str.17.174:                          ; @.str.17.174
	.asciz	" bytes\n"

l_.str.18.175:                          ; @.str.18.175
	.asciz	"  "

l_.str.19.176:                          ; @.str.19.176
	.asciz	": "

l_.str.20.177:                          ; @.str.20.177
	.asciz	" "

l_.str.21.178:                          ; @.str.21.178
	.asciz	"ms"

l_.str.22.179:                          ; @.str.22.179
	.asciz	"("

l_.str.23.180:                          ; @.str.23.180
	.asciz	"%)"

l_.str.24.181:                          ; @.str.24.181
	.asciz	"threads: "

l_.str.25.182:                          ; @.str.25.182
	.asciz	" peak: "

l_.str.26.183:                          ; @.str.26.183
	.asciz	" num: "

l_.str.27.184:                          ; @.str.27.184
	.asciz	" avg: "

l_.str.28.185:                          ; @.str.28.185
	.asciz	" stack: "

l_.str.29.163:                          ; @.str.29.163
	.asciz	"Printer buffer allocation failed.\n"

	.section	__DATA,__data
	.globl	__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE ; @_ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE
	.weak_definition	__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE
	.p2align	3
__ZN6Halide7Runtime8Internal30custom_can_use_target_featuresE:
	.quad	_halide_default_can_use_target_features

	.globl	__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE ; @_ZN6Halide7Runtime8Internal27halide_cpu_features_storageE
	.weak_definition	__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE
	.p2align	3
__ZN6Halide7Runtime8Internal27halide_cpu_features_storageE:
	.space	32

	.globl	__ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE ; @_ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE
	.weak_definition	__ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE
__ZN6Halide7Runtime8Internal31halide_cpu_features_initializedE:
	.byte	0                               ; 0x0

	.globl	__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE ; @_ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE
	.weak_definition	__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE
	.p2align	3
__ZN6Halide7Runtime8Internal36halide_cpu_features_initialized_lockE:
	.space	8

	.section	__TEXT,__cstring,cstring_literals
l_.str.197:                             ; @.str.197
	.asciz	"Internal error: wrong structure size passed to halide_can_use_target_features()\n"

	.section	__TEXT,__const
	.p2align	4                               ; @0
l___unnamed_1:
	.space	32

	.p2align	5                               ; @str
l_str:
	.asciz	"input"

	.p2align	4                               ; @1
l___unnamed_2:
	.space	32

	.p2align	5                               ; @str.200
l_str.200:
	.asciz	"blur_y"

	.section	__DATA,__const
	.p2align	4                               ; @2
l___unnamed_3:
	.quad	l_str
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.byte	1                               ; 0x1
	.byte	16                              ; 0x10
	.short	1                               ; 0x1
	.space	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	l___unnamed_1
	.quad	l_str.200
	.long	2                               ; 0x2
	.long	2                               ; 0x2
	.byte	1                               ; 0x1
	.byte	16                              ; 0x10
	.short	1                               ; 0x1
	.space	4
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	l___unnamed_2

	.section	__TEXT,__const
	.p2align	5                               ; @str.201
l_str.201:
	.asciz	"arm-64-osx"

	.p2align	5                               ; @str.202
l_str.202:
	.asciz	"halide_blur"

	.section	__DATA,__const
	.p2align	4                               ; @halide_blur_metadata_storage
l_halide_blur_metadata_storage:
	.long	1                               ; 0x1
	.long	2                               ; 0x2
	.quad	l___unnamed_3
	.quad	l_str.201
	.quad	l_str.202

	.section	__TEXT,__const
	.p2align	5                               ; @str.203
l_str.203:
	.asciz	"Output buffer blur_y"

	.p2align	5                               ; @str.204
l_str.204:
	.asciz	"Input buffer input"

	.p2align	5                               ; @str.205
l_str.205:
	.asciz	"blur_y.stride.0"

	.p2align	5                               ; @str.206
l_str.206:
	.asciz	"1"

	.p2align	5                               ; @str.207
l_str.207:
	.asciz	"input.stride.0"

	.section	__DATA,__const
	.p2align	3                               ; @switch.table.halide_type_to_string
l_switch.table.halide_type_to_string:
	.quad	l_.str.14.76
	.quad	l_.str.15.75
	.quad	l_.str.16.74
	.quad	l_.str.17.73

.subsections_via_symbols
