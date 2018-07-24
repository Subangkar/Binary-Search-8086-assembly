BIN_SEARCH PROC
;search in a sorted array by the binary search method
;input: SI = array offset address
;       BX = number of elements
;       CX = key
;output: SI = offset of sorted array
;        AX = pos @where key has been found
;uses:
    ;PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    
    
    MOV DX,BX   ; DX = rIndex
    DEC DX 
    MOV BX,0    ; BX = lIndex


    @START_BIN_SEARCH: ; BX=l,AX=m,DX=r
        CMP BX,DX ; exit when lIndex > rIndex
        JG @NOT_FOUND_BIN_SEARCH
        MOV AX,BX
        ADD AX,DX ; AX=BX+DX
        SHR AX,1 ; AX = midIndex ; m=(l+r)/2
        
        ;MOV SI,AX
        ;ADD SI,SI
        MOV DI,SI
        ADD DI,AX
        ADD DI,AX
        CMP CX,[DI]
        JE @FOUND_BIN_SEARCH            
        JG @BIG_PIVOT_BIN_SEARCH
        JMP @SMALL_PIVOT_BIN_SEARCH

        @BIG_PIVOT_BIN_SEARCH:
            INC AX 
            MOV BX,AX ; l=m+1
            JMP @START_BIN_SEARCH

        @SMALL_PIVOT_BIN_SEARCH:
            DEC AX
            MOV DX,AX ; r=m-1
            JMP @START_BIN_SEARCH


    @NOT_FOUND_BIN_SEARCH:
        MOV AX,-1
        JMP @END_BIN_SEARCH

    @FOUND_BIN_SEARCH: ; index already in AX
        ;ADD AL,01
        JMP @END_BIN_SEARCH


    @END_BIN_SEARCH:
        POP DI
        POP SI
        POP DX
        POP CX
        POP BX
        ;POP AX
    RET
BIN_SEARCH ENDP

