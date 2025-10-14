%%writefile primos_rango_input.asm
section .data
    msg_start db 'Ingrese inicio del rango: ', 0
    len_start equ $ - msg_start
    msg_end   db 'Ingrese fin del rango: ', 0
    len_end   equ $ - msg_end
    msg_result db 'Numeros primos en el rango: ', 10, 0
    len_result equ $ - msg_result
    space   db ' ', 0
    newline db 10, 0
    buffer  times 10 db 0

section .bss
    start   resw 1
    end     resw 1

section .text
    global _start

_start:
    ; Pedir inicio del rango
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_start
    mov edx, len_start
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov esi, buffer
    call atoi
    mov [start], ax

    ; Pedir fin del rango
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_end
    mov edx, len_end
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov esi, buffer
    call atoi
    mov [end], ax

    ; Mostrar título
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_result
    mov edx, len_result
    int 0x80

    ; Generar y mostrar primos en el rango
    mov cx, [start]      ; Número actual

range_loop:
    cmp cx, [end]
    jg done

    ; Verificar si CX es primo
    call is_prime
    cmp al, 1
    jne next_number

    ; Mostrar número primo
    mov ax, cx
    mov edi, buffer
    call itoa
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

next_number:
    inc cx
    jmp range_loop

done:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80

; Función para verificar si un número es primo
; Entrada: CX = número a verificar
; Salida: AL = 1 si es primo, 0 si no
is_prime:
    cmp cx, 2
    jl .not_prime
    je .is_prime

    mov bx, 2            ; Divisor inicial

.check_loop:
    mov ax, cx
    xor dx, dx
    div bx
    cmp dx, 0
    je .not_prime        ; Divisible → no primo

    inc bx
    mov ax, cx
    shr ax, 1            ; ax = cx / 2
    cmp bx, ax
    jle .check_loop      ; Continuar hasta bx <= cx/2

.is_prime:
    mov al, 1
    ret

.not_prime:
    mov al, 0
    ret

; Funciones atoi e itoa (igual que antes)
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