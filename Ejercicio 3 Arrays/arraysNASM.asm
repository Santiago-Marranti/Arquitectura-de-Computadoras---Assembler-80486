section .data
    array   dw 2, 4, 6, 8, 10    ; Array de números de 16 bits
    count   dw 5                  ; Cantidad de elementos
    sum     dw 0                  ; Variable para la suma

section .text
    global _start

_start:
    mov cx, [count]      ; Cargar contador
    mov si, 0            ; Inicializar índice
    mov ax, 0            ; Inicializar acumulador

sum_loop:
    add ax, [array + si] ; Sumar elemento del array
    add si, 2            ; Incrementar índice (WORD = 2 bytes)
    loop sum_loop        ; Repetir mientras CX ≠ 0

    mov [sum], ax        ; Guardar resultado

    ; Salir del programa en Linux
    mov eax, 1           ; sys_exit
    mov ebx, 0           ; código de salida 0
    int 0x80             ; llamada al sistema