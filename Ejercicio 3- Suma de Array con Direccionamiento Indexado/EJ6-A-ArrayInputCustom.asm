section .data
    msg_count db 'Cuantos numeros en el array? ', 0
    len_count equ $ - msg_count
    msg_num   db 'Ingrese numero: ', 0
    len_num   equ $ - msg_num
    msg_sum   db 'La suma del array es: ', 0
    len_sum   equ $ - msg_sum
    newline   db 10, 0
    buffer    times 10 db 0

section .bss
    array   resw 20     ; Array para hasta 20 números
    count   resw 1
    sum     resw 1

section .text
    global _start

_start:
    ; Pedir cantidad de números
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_count
    mov edx, len_count
    int 0x80

    ; Leer cantidad
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    mov esi, buffer
    call atoi
    mov [count], ax

    ; Leer los números del array
    mov cx, [count]
    mov si, 0
    mov di, 0          ; índice para array

read_loop:
    push cx
    push si

    ; Mostrar mensaje para número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_num
    mov edx, len_num
    int 0x80

    ; Leer número
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 10
    int 0x80

    ; Convertir y guardar en array
    mov esi, buffer
    call atoi
    mov [array + di], ax
    add di, 2

    pop si
    pop cx
    loop read_loop

    ; Calcular suma (igual que tu código original)
    mov cx, [count]
    mov si, 0
    mov ax, 0

sum_loop:
    add ax, [array + si]
    add si, 2
    loop sum_loop

    mov [sum], ax

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_sum
    mov edx, len_sum
    int 0x80

    mov ax, [sum]
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