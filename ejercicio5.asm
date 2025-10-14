.MODEL SMALL
.STACK 100h
.DATA
    a       DW 48
    b       DW 18
    gcd     DW ?
.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, [a]
    MOV BX, [b]

GCD_LOOP:
    CMP AX, BX
    JE FOUND_GCD
    JG GREATER

    ; Si AX < BX
    SUB BX, AX
    JMP GCD_LOOP

GREATER:
    SUB AX, BX
    JMP GCD_LOOP

FOUND_GCD:
    MOV [gcd], AX

    MOV AH, 4Ch
    INT 21h
END START