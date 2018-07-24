PRINT_INT_DW_ARRAY PROC
; this procedure will display a list of decimal numbers
;input: SI = array offset address
;       CX = number of elements
; output : none
; uses : OUTDEC

    PUSH AX
    PUSH CX
    PUSH DX
    PUSH SI
    
    @PRINT_INT_DW_ARRAY_PRINT:
        MOV AX,[SI]
        CALL OUTDEC
        INC SI
        INC SI

        ;print a space
        MOV DL, ' '
        MOV AH,2
        INT 21h
    LOOP @PRINT_INT_DW_ARRAY_PRINT

    POP SI
    POP DX
    POP CX
    POP AX
    RET
PRINT_INT_DW_ARRAY ENDP







;INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/Dec16bitInput.asm


;OUTDEC PROC
; this procedure will display a decimal number
; input : AX
; output : none
; uses : MAIN
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/Dec16bitOutput.asm





