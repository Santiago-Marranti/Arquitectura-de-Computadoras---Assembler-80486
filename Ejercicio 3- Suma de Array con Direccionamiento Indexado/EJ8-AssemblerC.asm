
;	# Generar código assembler desde C
;	!gcc -S -m32 array_suma.c -o array_suma_c.s

;	# Mostrar el código generado
;	!echo "=== ASSEMBLER GENERADO POR GCC ==="
;	!cat array_suma_c.s


;=== ASSEMBLER GENERADO POR GCC ===
	.file	"array_suma.c"
	.text
	.section	.rodata
.LC0:
	.string	"La suma del array es: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	leal	4(%esp), %ecx
	.cfi_def_cfa 1, 0
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	.cfi_escape 0x10,0x5,0x2,0x75,0
	pushl	%ebx
	pushl	%ecx
	.cfi_escape 0xf,0x3,0x75,0x78,0x6
	.cfi_escape 0x10,0x3,0x2,0x75,0x7c
	subl	$48, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	%gs:20, %edx
	movl	%edx, -12(%ebp)
	xorl	%edx, %edx
	movl	$2, -32(%ebp)
	movl	$4, -28(%ebp)
	movl	$6, -24(%ebp)
	movl	$8, -20(%ebp)
	movl	$10, -16(%ebp)
	movl	$5, -36(%ebp)
	movl	$0, -44(%ebp)
	movl	$0, -40(%ebp)
	jmp	.L2
.L3:
	movl	-40(%ebp), %edx
	movl	-32(%ebp,%edx,4), %edx
	addl	%edx, -44(%ebp)
	addl	$1, -40(%ebp)
.L2:
	movl	-40(%ebp), %edx
	cmpl	-36(%ebp), %edx
	jl	.L3
	subl	$8, %esp
	pushl	-44(%ebp)
	leal	.LC0@GOTOFF(%eax), %edx
	pushl	%edx
	movl	%eax, %ebx
	call	printf@PLT
	addl	$16, %esp
	movl	$0, %eax
	movl	-12(%ebp), %edx
	subl	%gs:20, %edx
	je	.L5
	call	__stack_chk_fail_local
.L5:
	leal	-8(%ebp), %esp
	popl	%ecx
	.cfi_restore 1
	.cfi_def_cfa 1, 0
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	leal	-4(%ecx), %esp
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB1:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE1:
	.hidden	__stack_chk_fail_local
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits