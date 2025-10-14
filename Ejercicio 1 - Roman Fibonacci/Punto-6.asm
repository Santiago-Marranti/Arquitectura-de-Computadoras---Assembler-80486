//Crear versión con input (punto 6)

%%writefile fibonacci_input.asm
section .data
    msg1    db 'Cuantos numeros Fibonacci? ', 0
    len1    equ $ - msg1
    msg2    db 'Secuencia Fibonacci: ', 0
    len2    equ $ - msg2
    space   db ' ', 0
    newline db 10, 0
    buffer  times 10 db 0

section .bss
    fib     resw 20     ; Array para Fibonacci (hasta 20 números)
    count   resd 1

section .text
    global _start

_start:
    ; Pedir cantidad de números
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
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
    mov [count], eax

    ; Validar que sea al menos 2
    cmp eax, 2
    jge calculate_fib

    ; Si es menor que 2, usar mínimo 2
    mov eax, 2
    mov [count], eax

calculate_fib:
    ; Inicializar primeros dos números
    mov word [fib], 0
    mov word [fib + 2], 1

    ; Calcular resto de la secuencia
    mov ecx, eax
    sub ecx, 2          ; Ya tenemos 2 números
    mov si, 4           ; Empezar desde posición 2

fib_loop:
    mov ax, [fib + si - 4]
    add ax, [fib + si - 2]
    mov [fib + si], ax
    add si, 2
    loop fib_loop

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov ecx, [count]
    mov si, 0

display_loop:
    mov ax, [fib + si]
    call print_number
    call print_space
    add si, 2
    loop display_loop

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

; Funciones (las mismas que antes)
print_number:
    pusha
    mov edi, buffer + 9
    mov byte [edi], 0
    mov bx, 10
    mov cx, 0

convert:
    dec edi
    xor dx, dx
    div bx
    add dl, '0'
    mov [edi], dl
    inc cx
    test ax, ax
    jnz convert

    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, cx
    int 0x80
    popa
    ret

print_space:
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80
    popa
    ret

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


    // Compilar y probar con input

    # Compilar versión con input
!nasm -f elf32 fibonacci_input.asm -o fibonacci_input.o
!ld -m elf_i386 fibonacci_input.o -o fibonacci_input

# Probar con diferentes entradas
!echo "8" | ./fibonacci_input
!echo "5" | ./fibonacci_input
!echo "12" | ./fibonacci_input