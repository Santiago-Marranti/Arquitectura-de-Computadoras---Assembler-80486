# Generar código assembler desde C
!gcc -S -m32 primo.c -o primo_c.s

# Mostrar el código generado
!echo "=== ASSEMBLER GENERADO POR GCC ==="
!cat primo_c.s

=== ASSEMBLER GENERADO POR GCC ===
	.file	"primo.c"
	.text
	.globl	esPrimo
	.type	esPrimo, @function
esPrimo:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$16, %esp
	call	__x86.get_pc_thunk.ax
	addl	$_GLOBAL_OFFSET_TABLE_, %eax
	cmpl	$1, 8(%ebp)
	jg	.L2
	movl	$0, %eax
	jmp	.L3
.L2:
	cmpl	$2, 8(%ebp)
	jne	.L4
	movl	$1, %eax
	jmp	.L3
.L4:
	movl	8(%ebp), %eax
	andl	$1, %eax
	testl	%eax, %eax
	jne	.L5
	movl	$0, %eax
	jmp	.L3
.L5:
	movl	$3, -4(%ebp)
	jmp	.L6
.L8:
	movl	8(%ebp), %eax
	cltd
	idivl	-4(%ebp)
	movl	%edx, %eax
	testl	%eax, %eax
	jne	.L7
	movl	$0, %eax
	jmp	.L3
.L7:
	addl	$2, -4(%ebp)
.L6:
	movl	-4(%ebp), %eax
	imull	%eax, %eax
	cmpl	%eax, 8(%ebp)
	jge	.L8
	movl	$1, %eax
.L3:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	esPrimo, .-esPrimo
	.section	.rodata
.LC0:
	.string	"%d es primo\n"
.LC1:
	.string	"%d no es primo\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
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
	movl	$17, -12(%ebp)
	pushl	-12(%ebp)
	call	esPrimo
	addl	$4, %esp
	testb	%al, %al
	je	.L10
	subl	$8, %esp
	pushl	-12(%ebp)
	leal	.LC0@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
	jmp	.L11
.L10:
	subl	$8, %esp
	pushl	-12(%ebp)
	leal	.LC1@GOTOFF(%ebx), %eax
	pushl	%eax
	call	printf@PLT
	addl	$16, %esp
.L11:
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
.LFE1:
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
.LFB2:
	.cfi_startproc
	movl	(%esp), %eax
	ret
	.cfi_endproc
.LFE2:
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
.LFB3:
	.cfi_startproc
	movl	(%esp), %ebx
	ret
	.cfi_endproc
.LFE3:
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04.2) 11.4.0"
	.section	.note.GNU-stack,"",@progbits