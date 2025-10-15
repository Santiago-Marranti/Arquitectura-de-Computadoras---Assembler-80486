.MODEL SMALL             ; Definir modelo de memoria SMALL (código y datos separados)
.STACK 100h              ; Reservar 256 bytes para la pila
.DATA
    array   DW 2, 4, 6, 8, 10  ; Array de números de 16 bits
    count   DW 5               ; Cantidad de elementos en el array
    sum     DW 0               ; Variable para almacenar la suma
.CODE
START:
    MOV AX, @DATA        ; Cargar dirección del segmento de datos en AX
    MOV DS, AX           ; Inicializar DS con la dirección del segmento de datos

    MOV CX, [count]      ; Cargar el contador CX con la cantidad de elementos
    MOV SI, 0             ; Inicializar el índice SI en 0
    MOV AX, 0             ; Inicializar acumulador AX en 0 para la suma

SUM_LOOP:
    ADD AX, [array+SI]   ; Sumar el elemento del array apuntado por SI a AX
    ADD SI, 2             ; Incrementar SI en 2 (cada elemento es WORD = 2 bytes)
    LOOP SUM_LOOP         ; Decrementar CX y repetir el bucle mientras CX ≠ 0

    MOV [sum], AX         ; Guardar el resultado final de la suma en la variable sum

    MOV AH, 4Ch           ; Función de DOS para terminar programa
    INT 21h               ; Llamar a interrupción 21h
END START