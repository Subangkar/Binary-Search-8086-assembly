
.stack 100h


.data



.code






multiply_BX_withInto_AX proc

    PUSH BX ; to not to lose multiplier
    PUSH DX


    ; a*b = 2^x.a + y.a where (2^x+y)=b
    MOV DX,0; product in DX

    ; if b is odd then a+=a now multiply a by (b-1)(even times)
    LOOP_multiply_BX_withInto_AX:
        TEST BX,1
        JZ END_IF_multiply_AX_with_BX
        ADD DX,AX 
    END_IF_multiply_AX_with_BX: ; computes 2^x.a
        SHL AX,1; a*=2; hence need to multiply b/2 more times
        SHR BX,1
    JNZ LOOP_multiply_BX_withInto_AX ; cont until b=0

    MOV AX,DX;output in DX

    POP DX
    POP BX
    RET
multiply_BX_withInto_AX endp


; LEA DX,string_var
printStringAddrIn_DX proc
    PUSH AX
    MOV AH,9
    INT 21h
    POP AX
    RET
printStringAddrIn_DX endp


; take input of multiple digit decimal number<255 output in DH	
scan8bitIntIn_DH proc
    PUSH AX
    PUSH DX

    ; take input of multiple digit decimal number<255 affects AX,DX output in DH	
    MOV AL,'0'
    MOV DH,0  ; DH holds all digit number	
    SCAN_DIGITS:

    MOV DL,AL ; DL holds last digit char
    SUB DL,'0'; DL holds last digit value

    MOV AL,DH
    MOV AH,10
    MUL AH
    MOV DH,AL
    ADD DH,DL
    
    MOV AH,1
    INT 21h

    CMP AL,0DH
    JNE SCAN_DIGITS

    POP AX ; DX.old in AX
    MOV DL,AL; DL = DL.old
    POP AX ; AX = old AX
    RET
scan8bitIntIn_DH endp

scan16bitIntIn_AX proc
    PUSH DX
    PUSH BX

    MOV DX,0
    MOV BX,10

    MOV AX,DX
    call multiply_BX_withInto_AX; n *= 10

    MOV DX,AX
    call scanSingleDigitIntIn_AL

    ; if 0<=x<=9 


    MOV AH,0
    ADD DX,AX
    

    MOV AX,DX
    POP BX
    POP DX
    RET
scan16bitIntIn_AX endp


scanSingleDigitIntIn_AL proc
    call scanByteIn_AL
    SUB AL,'0'
    RET
scanSingleDigitIntIn_AL endp


; take input in AL affects AX
scanByteIn_AL proc
	; take input in AL affects AX
    MOV AH,1
    INT 21h
    RET
scanByteIn_AL endp


; prints the Byte in DL
printByteIn_DL proc
    PUSH AX

    MOV AH,2
    INT 21h

    POP AX    
    RET
printByteIn_DL endp


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
printSpace endp



returnDOS proc
    mov     ah,4Ch       ;DOS function: Exit program 
    mov     al,0         ;Return exit code value 
    int     21h          ;Call DOS. Terminate program 
    RET
returnDOS endp












main proc

    MOV AX,15
    MOV BX,10
    MOV DX,15

    ;call multiply_BX_withInto_AX


    call scanSingleDigitIntIn_AL

    ;call scanByteIn_AL
    ;call printNewline
    ;call printSpace
    ;MOV DL,AL
    ;call printByteIn_DL
    ;call returnDOS

main endp



end main