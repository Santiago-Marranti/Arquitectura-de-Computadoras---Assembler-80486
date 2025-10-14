.MODEL SMALL
.STACK 100h
.DATA
    fib     DW 10 DUP(?)  ; Array para 10 números Fibonacci
    msg     DB 'Fibonacci: $'
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    ; Inicializar primeros dos números
    MOV WORD PTR [fib], 0
    MOV WORD PTR [fib+2], 1

    ; Calcular secuencia
    MOV CX, 8
    MOV SI, 4
FIB_LOOP:
    MOV AX, [fib+SI-4]    ; Direccionamiento indexado
    ADD AX, [fib+SI-2]
    MOV [fib+SI], AX
    ADD SI, 2
    LOOP FIB_LOOP

    ; Mostrar resultados
    MOV AH, 09h
    LEA DX, msg
    INT 21h

    MOV CX, 10
    MOV SI, 0
DISPLAY:
    ; Conversión a ASCII y display
    MOV AX, [fib+SI]
    CALL PRINT_NUMBER
    ADD SI, 2
    LOOP DISPLAY

    MOV AH, 4Ch
    INT 21h

PRINT_NUMBER PROC
    ; Implementar conversión número a ASCII
    RET
PRINT_NUMBER ENDP

END START


// comentado el siguiente 


.MODEL SMALL            ; Modelo de memoria pequeño
.STACK 100h             ; Reserva 256 bytes para la pila

.DATA
    fib DW 10 DUP(?)    ; Array para guardar 10 números Fibonacci
    msg DB 'Fibonacci: $' ; Mensaje que se mostrará antes de la secuencia

.CODE
START:
    MOV AX, @DATA       ; Carga la dirección base del segmento de datos en AX
    MOV DS, AX          ; Inicializa el segmento de datos DS

    MOV WORD PTR [fib], 0   ; fib[0] = 0 (primer número)
    MOV WORD PTR [fib+2], 1 ; fib[1] = 1 (segundo número)

    MOV CX, 8           ; CX = 8, se calcularán los 8 números restantes
    MOV SI, 4           ; SI apunta a fib[2] (cada número ocupa 2 bytes)

FIB_LOOP:
    MOV AX, [fib+SI-4]  ; AX = fib[n-2]
    ADD AX, [fib+SI-2]  ; AX = fib[n-2] + fib[n-1]
    MOV [fib+SI], AX    ; Guarda el resultado en fib[n]
    ADD SI, 2           ; Avanza al siguiente elemento del array
    LOOP FIB_LOOP       ; Decrementa CX y repite mientras CX ≠ 0

    MOV AH, 09h         ; Función DOS para mostrar cadena terminada en '$'
    LEA DX, msg         ; Carga la dirección del mensaje en DX
    INT 21h             ; Interrupción de DOS para imprimir

    MOV CX, 10          ; CX = 10, cantidad de números a mostrar
    MOV SI, 0           ; Reinicia el índice SI al comienzo del array

DISPLAY:
    MOV AX, [fib+SI]    ; Carga el número actual en AX
    CALL PRINT_NUMBER   ; Llama al procedimiento que imprime el número
    ADD SI, 2           ; Avanza al siguiente número
    LOOP DISPLAY        ; Decrementa CX y repite mientras CX ≠ 0

    MOV AH, 4Ch         ; Función DOS para terminar el programa
    INT 21h             ; Llama a DOS para finalizar

PRINT_NUMBER PROC
    RET                 ; Retorna al programa principal (sin implementación)
PRINT_NUMBER ENDP

END START               ; Fin del programa, punto de inicio START