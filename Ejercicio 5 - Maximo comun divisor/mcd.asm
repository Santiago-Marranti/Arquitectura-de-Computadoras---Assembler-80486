%%writefile mcd_input.asm
section .data
    msg_a    db 'Ingrese primer numero: ', 0
    len_a    equ $ - msg_a
    msg_b    db 'Ingrese segundo numero: ', 0
    len_b    equ $ - msg_b
    msg_result db 'El MCD es: ', 0
    len_result equ $ - msg_result
    newline  db 10, 0
    buffer   times 10 db 0

section .bss
    a       resw 1
    b       resw 1
    gcd     resw 1

section .text
    global _start

_start:
    ; Pedir primer número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_a
    mov edx, len_a
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov esi, buffer
    call atoi
    mov [a], ax

    ; Pedir segundo número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_b
    mov edx, len_b
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov esi, buffer
    call atoi
    mov [b], ax

    ; Calcular MCD usando algoritmo de Euclides
    mov ax, [a]
    mov bx, [b]

gcd_loop:
    cmp ax, bx
    je found_gcd
    jg greater

    ; Si AX < BX
    sub bx, ax
    jmp gcd_loop

greater:
    sub ax, bx
    jmp gcd_loop

found_gcd:
    mov [gcd], ax

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_result
    mov edx, len_result
    int 0x80

    mov ax, [gcd]
    mov edi, buffer
    call itoa

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

; Funciones auxiliares
atoi:
    xor eax, eax
    xor ebx, ebx
.atoi_loop:
    mov bl, [esi]
    cmp bl, 10
    je .atoi_done
    cmp bl, 0
    je .atoi_done
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    inc esi
    jmp .atoi_loop
.atoi_done:
    ret

itoa:
    add edi, 9
    mov byte [edi], 0
    mov bx, 10
.itoa_loop:
    dec edi
    xor dx, dx
    div bx
    add dl, '0'
    mov [edi], dl
    test ax, ax
    jnz .itoa_loop
    ret