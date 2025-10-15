%%writefile factorial_input.asm
section .data
    msg1    db 'Ingrese un numero para factorial (0-8): ', 0
    len1    equ $ - msg1
    msg2    db 'Factorial: ', 0
    len2    equ $ - msg2
    error_msg db 'Error: Numero debe ser 0-8', 10, 0
    error_len equ $ - error_msg
    newline db 10, 0
    buffer  times 10 db 0

section .bss
    num     resw 1
    result  resd 1

section .text
    global _start

_start:
    ; Pedir número al usuario
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
    mov [num], ax

    ; Validar rango (0-8)
    cmp ax, 0
    jl error
    cmp ax, 8
    jg error

    ; Calcular factorial
    call calcular_factorial

    ; Mostrar resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov ax, [result]
    call print_number

    ; Nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Salir exitosamente
    jmp exit

error:
    ; Mostrar mensaje de error
    mov eax, 4
    mov ebx, 1
    mov ecx, error_msg
    mov edx, error_len
    int 0x80
    mov ebx, 1  ; Código de error

exit:
    ; Salir del programa
    mov eax, 1
    int 0x80

; =============================================
; Subrutina: Calcular Factorial
; Entrada: [num] = número a calcular
; Salida: [result] = factorial
; =============================================
calcular_factorial:
    pusha
    mov ax, 1              ; Inicializar acumulador
    mov cx, [num]          ; Cargar número
    
    cmp cx, 0              ; Verificar si es 0
    je .fact_done          ; Si es 0, factorial = 1
    
.fact_loop:
    mul cx                 ; AX = AX * CX
    dec cx                 ; Decrementar contador
    jnz .fact_loop         ; Repetir si no es cero
    
.fact_done:
    mov [result], ax       ; Guardar resultado
    popa
    ret

; =============================================
; Subrutina: Convertir ASCII a número
; Entrada: ESI = puntero a string
; Salida: AX = número convertido
; =============================================
atoi:
    xor eax, eax
    xor ebx, ebx
.atoi_loop:
    mov bl, [esi]
    cmp bl, 10             ; Verificar fin de línea
    je .atoi_done
    cmp bl, 0              ; Verificar fin de string
    je .atoi_done
    cmp bl, '0'            ; Validar que es dígito
    jl .atoi_done
    cmp bl, '9'
    jg .atoi_done
    sub bl, '0'            ; Convertir ASCII a número
    imul eax, 10           ; Multiplicar por 10
    add eax, ebx           ; Sumar nuevo dígito
    inc esi
    jmp .atoi_loop
.atoi_done:
    ret

; =============================================
; Subrutina: Imprimir número
; Entrada: AX = número a imprimir
; =============================================
print_number:
    pusha
    mov edi, buffer + 9    ; Posición final del buffer
    mov byte [edi], 0      ; Terminador nulo
    mov bx, 10             ; Base 10
    mov cx, 0              ; Contador de dígitos

.convert:
    dec edi                ; Mover hacia atrás en buffer
    xor dx, dx             ; Limpiar DX para división
    div bx                 ; AX = AX/10, DX = resto
    add dl, '0'            ; Convertir a ASCII
    mov [edi], dl          ; Almacenar dígito
    inc cx                 ; Incrementar contador
    test ax, ax            ; Verificar si AX es 0
    jnz .convert           ; Si no es 0, continuar

    ; Mostrar número
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, cx
    int 0x80
    
    popa
    ret

    # Compilar versión con input
print("Compilando factorial_input.asm...")
!nasm -f elf32 factorial_input.asm -o factorial_input.o
!ld -m elf_i386 factorial_input.o -o factorial_input

print("Ejecutando pruebas con diferentes entradas:\n")

# Probar con diferentes números válidos
print("=== PRUEBAS VÁLIDAS ===")
!echo "0" | ./factorial_input
!echo "1" | ./factorial_input  
!echo "5" | ./factorial_input
!echo "8" | ./factorial_input

print("\n=== PRUEBAS INVÁLIDAS ===")
# Probar con números fuera de rango
!echo "-1" | ./factorial_input
!echo "9" | ./factorial_input
!echo "20" | ./factorial_input

print("\n=== PRUEBA CON ENTRADA NO NUMÉRICA ===")
# Probar con entrada no numérica
!echo "abc" | ./factorial_input

# Verificar códigos de salida para diferentes casos
print("Verificando códigos de salida:")

# Caso exitoso
print("Código de salida para entrada 5:", end=" ")
!echo "5" | ./factorial_input; echo "Código: $?"

# Caso error
print("Código de salida para entrada 9:", end=" ")
!echo "9" | ./factorial_input; echo "Código: $?"

# Mostrar información del ejecutable
print("\nInformación del ejecutable:")
!file factorial_input
!size factorial_input