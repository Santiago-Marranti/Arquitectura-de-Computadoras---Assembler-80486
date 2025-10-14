.MODEL SMALL             ; Definir el modelo de memoria SMALL (segmentos de código y datos separados)
.STACK 100h              ; Reservar 256 bytes para la pila
.DATA
    num     DW 17        ; Número a verificar si es primo
    isPrime DB 1         ; Bandera que indica si es primo (1 = primo, 0 = no primo)
.CODE
START:
    MOV AX, @DATA        ; Cargar dirección del segmento de datos en AX
    MOV DS, AX           ; Inicializar DS con la dirección del segmento de datos

    MOV AX, [num]        ; Cargar el número a verificar en AX
    CMP AX, 2            ; Comparar si AX es menor que 2
    JL NOT_PRIME         ; Si AX < 2, saltar a NOT_PRIME (no es primo)

    MOV CX, 2            ; Inicializar contador CX desde 2

CHECK_LOOP:
    MOV DX, 0            ; Limpiar DX antes de la división (DX:AX / CX)
    DIV CX               ; Dividir AX entre CX, residuo en DX
    CMP DX, 0            ; Comparar residuo con 0
    JE NOT_PRIME         ; Si residuo = 0, AX es divisible por CX → no es primo

    INC CX               ; Incrementar CX (siguiente divisor)
    MOV AX, [num]        ; Restaurar AX con el número original
    CMP CX, AX           ; Comparar CX con AX
    JL CHECK_LOOP        ; Si CX < AX, continuar el ciclo

    JMP END_CHECK        ; Si CX >= AX, terminar verificación (es primo)

NOT_PRIME:
    MOV [isPrime], 0     ; Marcar bandera como 0 → no primo

END_CHECK:
    MOV AH, 4Ch          ; Función de DOS para terminar programa
    INT 21h 