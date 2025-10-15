section .data
    msg_count db 'Cuantos numeros? ', 0
    len_count equ $ - msg_count
    msg_num   db 'Ingrese numero: ', 0
    len_num   equ $ - msg_num
    msg_avg   db 'El promedio es: ', 0
    len_avg   equ $ - msg_avg
    newline   db 10, 0
    buffer    times 10 db 0

section .bss
    array   resw 20
    count   resw 1
    sum     resw 1
    promedio resw 1

section .text
    global _start

_start:
    ; Pedir cantidad
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_count
    mov edx, len_count
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov esi, buffer
    call atoi
    mov [count], ax

    ; Leer números
    mov cx, [count]
    mov di, 0
    mov ax, 0          ; empezar suma desde ahora

read_loop:
    push cx
    push ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_num
    mov edx, len_num
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov esi, buffer
    call atoi
    mov [array + di], ax
    add di, 2

    pop ax
    add ax, [array + di - 2]  ; sumar inmediatamente
    pop cx
    loop read_loop

    mov [sum], ax

    ; Calcular promedio
    mov dx, 0
    mov bx, [count]
    div bx
    mov [promedio], ax

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_avg
    mov edx, len_avg
    int 0x80

    mov ax, [promedio]
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

; Mismas funciones atoi e itoa
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