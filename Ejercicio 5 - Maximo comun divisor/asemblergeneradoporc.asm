# Generar código assembler desde C
!gcc -S -m32 mcd.c -o mcd_c.s

# Mostrar el código generado
!echo "=== ASSEMBLER GENERADO POR GCC ==="
!cat mcd_c.s


=== ASSEMBLER GENERADO POR GCC ===
	.file	"mcd.c"
	.text
	.globl	calcularMCD
	.type	calcularMCD, @function
calcularMCD:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	jmp	.L2
.L4:
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jle	.L3
	movl	12(%ebp), %eax
	subl	%eax, 8(%ebp)
	jmp	.L2
.L3:
	movl	8(%ebp), %eax
	subl	%eax, 12(%ebp)
.L2:
	movl	8(%ebp), %eax
	cmpl	12(%ebp), %eax
	jne	.L4
	movl	8(%ebp), %eax
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	calcularMCD, .-calcularMCD
	.globl	calcularMCM
	.type	calcularMCM, @function
calcularMCM:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	.cfi_offset 3, -12
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	movl	8(%ebp), %eax
	imull	12(%ebp), %eax
	movl	%eax, %ebx
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	calcularMCD
	addl	$8, %esp
	movl	%eax, %ecx
	movl	%ebx, %eax
	cltd
	idivl	%ecx
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	calcularMCM, .-calcularMCM
	.section	.rodata
.LC0:
	.string	"MCD de %d y %d es: %d\n"
.LC1:
	.string	"MCM de %d y %d es: %d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
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
	subl	$16, %esp
	call	__x86.get_pc_thunk.bx
	addl	$_GLOBAL_OFFSET_TABLE_, %ebx
	movl	$48, -24(%ebp)
	movl	$18, -20(%ebp)
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	call	calcularMCD
	addl	$8, %esp
	movl	%eax, -16(%ebp)
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	call	calcularMCM
	addl	$8, %esp
	movl	%eax, -12(%ebp)
	pushl	-16(%ebp)
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	pushl	-12(%ebp)
	pushl	-20(%ebp)
	pushl	-24(%ebp)
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	movl	$0, %eax
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
.LFE2:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB3:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE3:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB4:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE4:
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits