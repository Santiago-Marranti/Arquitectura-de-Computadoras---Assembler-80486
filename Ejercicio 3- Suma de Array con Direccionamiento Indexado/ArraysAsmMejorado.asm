%%writefile arrays_mejorado.asm
section .data
    array   dw 2, 4, 6, 8, 10
    count   dw 5
    sum     dw 0
    msg     db 'La suma es: ', 0
    len     equ $ - msg
    buffer  times 10 db 0
    newline db 10, 0

section .text
    global _start

_start:
    ; Calcular suma
    mov cx, [count]
    mov si, 0
    mov ax, 0

sum_loop:
    add ax, [array + si]
    add si, 2
    loop sum_loop

    mov [sum], ax

    ; Mostrar mensaje "La suma es: "
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, msg        ; mensaje
    mov edx, len        ; longitud
    int 0x80

    ; Convertir número a ASCII para mostrarlo
    mov ax, [sum]
    mov edi, buffer + 9  ; posición final del buffer
    mov byte [edi], 0    ; terminador nulo
    mov bx, 10           ; divisor

convert_loop:
    dec edi              ; mover hacia atrás en el buffer
    xor dx, dx           ; limpiar dx para división
    div bx               ; ax = ax/10, dx = resto
    add dl, '0'          ; convertir dígito a ASCII
    mov [edi], dl        ; almacenar dígito
    test ax, ax          ; verificar si ax es cero
    jnz convert_loop     ; si no es cero, continuar

    ; Calcular longitud del número
    mov ecx, edi         ; inicio del número
    mov edx, buffer + 10 ; fin del buffer
    sub edx, ecx         ; edx = longitud

    ; Mostrar el número
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    int 0x80

    ; Mostrar nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80