
.model large


.data

MSG DB ".....$"

LIST DW 5,4,-3,2,1,-900,3457,1515,-1515,20,1,-7,0,34
LIST_LEN DW 16
KEY DW 0
POS_KEY DW 0
TERM_CHAR DB 'x'

MSG_ARR_IN DB "Enter Input Array: $"
MSG_KEY_IN DB "Enter n: $"
MSG_FOUND DB " was found in the array$"
MSG_NTFND DB " was not found in the array$"
MSG_END DB "Thank you :)$"


.code



; BIN_SEARCH PROC
; search in a sorted array by the binary search method
; input: SI = array offset address
;       BX = number of elements
;       CX = key
; output: SI = offset of sorted array
;        AX = pos @where key has been found
; uses:
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/BinarySearch.asm


; INDEC PROC
; this procedure will read a number in decimal form
; stops @ receiving x
; input : none
; output : store binary number in AX , other READ char in DL
;           DL = 0 for space
; uses : MAIN
;INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/Dec16bitInput.asm






; OUTDEC PROC
; this procedure will display a decimal number
; input : AX
; output : none
; uses : MAIN
;INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/Dec16bitOutput.asm






; SELECT  PROC
;sorts a byte array by the selectsort method
;input: SI = array offset address
;       BX = number of elements
;output: SI = offset of sorted array
;uses:  SWAP
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/SelectionSort.asm






; SCAN_INT_DW_ARRAY PROC
; this procedure will input a list of decimal numbers
; input:    SI = array offset address where to store
;           CX = number of elements at most to scan
;           AL = stop instant @ receiving @char
; output :  CX = number of elements scanned
;           SI = array offset address where to store       
; uses : INDEC
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/ScanIntArray.asm





; PRINT_INT_DW_ARRAY PROC
; this procedure will display a list of decimal numbers
; input:    SI = array offset address
;           CX = number of elements
; output : none
; uses : OUTDEC
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/PrintIntArray.asm





; SELECT  PROC
;sorts a byte array by the selectsort method
;input: SI = array offset address
;       BX = number of elements
;output: SI = offset of sorted array
;uses:  SWAP
;INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/SelectionSort.asm












; newline
printNewline proc
    PUSH AX
    PUSH DX

    ; newline = AX , DL
    MOV AH,2
    MOV DL,0AH
    INT 21h   
    MOV DL,0DH
    INT 21h 

    POP DX
    POP AX
    RET
printNewline endp

printSpace proc
    PUSH AX
    PUSH DX

	;print a space
    MOV DL, ' '
    MOV AH,2
    INT 21h

    POP DX
    POP AX
    RET
printSpace endp

; LEA DX,string_var
printStringAddrIn_DX proc
    PUSH AX
    MOV AH,9
    INT 21h
    POP AX
    RET
printStringAddrIn_DX endp


returnDOS proc
    mov     ah,4Ch       ;DOS function: Exit program 
    mov     al,0         ;Return exit code value 
    int     21h          ;Call DOS. Terminate program 
    RET
returnDOS endp




main proc    
    
    ; initialize Data Segment = AX
    MOV AX,@DATA
    MOV DS,AX
    

    
    LEA DX,MSG_ARR_IN
    call printStringAddrIn_DX

    LEA SI,LIST
    MOV CX,LIST_LEN
    MOV AL,TERM_CHAR

    CALL SCAN_INT_DW_ARRAY
    MOV LIST_LEN,CX

    call printNewline    


    MOV BX,LIST_LEN
    CALL SELECT


    MOV CX,LIST_LEN
    CALL PRINT_INT_DW_ARRAY
    call printNewline


    @CONTINUE_SEARCH:
        call printNewline
        

        LEA DX,MSG_KEY_IN
        call printStringAddrIn_DX
        CALL INDEC
        
        CMP DL,TERM_CHAR
        JE @END_SEARCH
        
        CMP DL,0 ; DL>0 means ascii scanned
        JGE @CONTINUE_SEARCH

        MOV KEY,AX
        MOV AX,KEY
        CALL OUTDEC

        
        MOV BX,LIST_LEN
        MOV CX,KEY
        CALL BIN_SEARCH; returns found pos => AX
        MOV POS_KEY,AX

        CMP AX,0
        JGE @IFC ; found >= 0
        JMP @ELSC ; not found = -1

        @IFC: ; found
            ;MOV AX,AX ; pos in AX
            LEA DX,MSG_FOUND
            JMP @END_IF_ELS

        @ELSC: ; not found
            ;MOV AX,AX ; pos in AX
            LEA DX,MSG_NTFND
            JMP @END_IF_ELS

        @END_IF_ELS:
            call printStringAddrIn_DX
            call printNewline

    JMP @CONTINUE_SEARCH


    @END_SEARCH:
        LEA DX,MSG_END
        call printNewline
        call printStringAddrIn_DX
        call printNewline

    
    CALL returnDOS
       	
main endp    

end main
