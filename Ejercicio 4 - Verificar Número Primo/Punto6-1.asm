%%writefile primo_input.asm
section .data
    msg_input db 'Ingrese un numero para verificar si es primo: ', 0
    len_input equ $ - msg_input
    msg_prime db ' es primo', 10, 0
    len_prime equ $ - msg_prime
    msg_notprime db ' no es primo', 10, 0
    len_notprime equ $ - msg_notprime
    buffer times 10 db 0

section .bss
    num     resw 1
    isPrime resb 1

section .text
    global _start

_start:
    ; Pedir número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_input
    mov edx, len_input
    int 0x80

    ; Leer input
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    ; Convertir a número
    mov esi, buffer
    call atoi
    mov [num], ax

    ; Verificar si es primo
    mov byte [isPrime], 1  ; Asumir que es primo inicialmente

    mov ax, [num]
    cmp ax, 2
    jl not_prime          ; Si < 2, no es primo

    mov cx, 2             ; Inicializar divisor

check_loop:
    mov dx, 0             ; Limpiar DX para división
    div cx                ; DX:AX / CX
    cmp dx, 0             ; Verificar residuo
    je not_prime          ; Si residuo = 0, no es primo

    inc cx                ; Siguiente divisor
    mov ax, [num]         ; Restaurar número original
    cmp cx, ax            ; ¿Llegamos al número?
    jl check_loop         ; Continuar si CX < número
    jmp end_check         ; Terminar verificación

not_prime:
    mov byte [isPrime], 0 ; Marcar como no primo

end_check:
    ; Mostrar el número
    mov ax, [num]
    mov edi, buffer
    call itoa
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 10
    int 0x80

    ; Mostrar si es primo o no
    cmp byte [isPrime], 1
    jne show_not_prime

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_prime
    mov edx, len_prime
    int 0x80
    jmp exit

show_not_prime:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_notprime
    mov edx, len_notprime
    int 0x80

exit:
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