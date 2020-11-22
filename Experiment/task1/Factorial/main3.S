	.file	"main.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d"
	.text
	.p2align 4
	.globl	fac
	.type	fac, @function
fac:
.LFB1:
	.cfi_startproc
	endbr64
	movl	$2, i(%rip)
	cmpl	$1, %edi
	jle	.L4
	leal	1(%rdi), %ecx
	movl	$2, %eax
	movl	$1, %esi
	.p2align 4,,10
	.p2align 3
.L3:
	movl	%eax, %edx
	imull	%eax, %esi
	addl	$1, %eax
	cmpl	%edi, %edx
	jne	.L3
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	movl	%ecx, i(%rip)
	jmp	printf@PLT
	.p2align 4,,10
	.p2align 3
.L4:
	movl	$1, %esi
	leaq	.LC0(%rip), %rdi
	xorl	%eax, %eax
	jmp	printf@PLT
	.cfi_endproc
.LFE1:
	.size	fac, .-fac
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	leaq	.LC0(%rip), %rdi
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rsi
	call	__isoc99_scanf@PLT
	movl	4(%rsp), %edi
	call	fac
	movq	8(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L10
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L10:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.comm	i,4,4
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
