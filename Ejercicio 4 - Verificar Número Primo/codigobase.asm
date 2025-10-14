.MODEL SMALL
.STACK 100h
.DATA
    num     DW 17
    isPrime DB 1       ; 1 = primo, 0 = no primo
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, [num]
    CMP AX, 2
    JL NOT_PRIME

    MOV CX, 2          ; Contador desde 2
CHECK_LOOP:
    MOV DX, 0
    DIV CX             ; DX:AX / CX
    CMP DX, 0          ; ¿Divisible?
    JE NOT_PRIME

    INC CX
    MOV AX, [num]      ; Restaurar AX
    CMP CX, AX
    JL CHECK_LOOP

    JMP END_CHECK

NOT_PRIME:
    MOV [isPrime], 0

END_CHECK:
    MOV AH, 4Ch
    INT 21h
END START
