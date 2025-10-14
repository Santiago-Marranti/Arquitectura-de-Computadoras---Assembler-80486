%%writefile mcd_mcm_input.asm
section .data
    msg_a    db 'Ingrese primer numero: ', 0
    len_a    equ $ - msg_a
    msg_b    db 'Ingrese segundo numero: ', 0
    len_b    equ $ - msg_b
    msg_mcd  db 'MCD: ', 0
    len_mcd  equ $ - msg_mcd
    msg_mcm  db 'MCM: ', 0
    len_mcm  equ $ - msg_mcm
    newline  db 10, 0
    space    db ' ', 0
    buffer   times 10 db 0

section .bss
    a       resw 1
    b       resw 1
    gcd     resw 1
    lcm     resw 1
    temp    resw 1

section .text
    global _start

_start:
    ; Pedir números
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
    mov [temp], ax      ; Guardar para cálculo de MCM

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

    ; Calcular MCD
    mov ax, [a]
    mov bx, [b]
    call calcular_mcd
    mov [gcd], ax

    ; Calcular MCM usando fórmula: MCM(a,b) = (a*b) / MCD(a,b)
    mov ax, [a]
    mov bx, [b]
    mul bx              ; DX:AX = a * b
    mov bx, [gcd]
    div bx              ; AX = (a*b) / MCD
    mov [lcm], ax

    ; Mostrar resultados
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mcd
    mov edx, len_mcd
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

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_mcm
    mov edx, len_mcm
    int 0x80

    mov ax, [lcm]
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

    mov eax, 1
    mov ebx, 0
    int 0x80

; Función para calcular MCD
calcular_mcd:
gcd_loop:
    cmp ax, bx
    je gcd_done
    jg greater

    sub bx, ax
    jmp gcd_loop

greater:
    sub ax, bx
    jmp gcd_loop

gcd_done:
    ret

; Funciones atoi e itoa
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