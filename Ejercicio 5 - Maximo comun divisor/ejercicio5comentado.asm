.MODEL SMALL             ; Definir modelo de memoria SMALL (código y datos separados)
.STACK 100h              ; Reservar 256 bytes para la pila
.DATA
    a       DW 48        ; Primer número
    b       DW 18        ; Segundo número
    gcd     DW ?         ; Variable para almacenar el MCD
.CODE
START:
    MOV AX, @DATA        ; Cargar dirección del segmento de datos en AX
    MOV DS, AX           ; Inicializar DS con la dirección del segmento de datos

    MOV AX, [a]          ; Cargar el primer número en AX
    MOV BX, [b]          ; Cargar el segundo número en BX

GCD_LOOP:
    CMP AX, BX           ; Comparar AX y BX
    JE FOUND_GCD         ; Si son iguales, se encontró el MCD
    JG GREATER           ; Si AX > BX, saltar a GREATER

    ; Si AX < BX
    SUB BX, AX           ; Restar AX de BX (BX = BX - AX)
    JMP GCD_LOOP         ; Volver al inicio del bucle

GREATER:
    SUB AX, BX           ; Restar BX de AX (AX = AX - BX)
    JMP GCD_LOOP         ; Volver al inicio del bucle

FOUND_GCD:
    MOV [gcd], AX        ; Guardar el MCD en la variable gcd

    MOV AH, 4Ch          ; Función de DOS para terminar programa
    INT 21h              ; Llamar a interrupción 21h
END START