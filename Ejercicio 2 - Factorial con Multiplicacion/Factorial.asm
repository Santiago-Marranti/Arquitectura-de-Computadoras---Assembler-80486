.MODEL SMALL
.STACK 100h
.DATA
    num     DW 5
    result  DD ?
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, 1
    MOV CX, [num]       ; Direccionamiento directo
    CMP CX, 0
    JE FACT_DONE

FACT_LOOP:
    MUL CX             ; AX = AX * CX
    LOOP FACT_LOOP

FACT_DONE:
    MOV [result], AX   ; Almacenar resultado

    MOV AH, 4Ch
    INT 21h
END START