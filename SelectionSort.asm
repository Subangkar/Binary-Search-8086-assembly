SELECT  PROC
;sorts a byte array by the selectsort method
;input: SI = array offset address
;       BX = number of elements
;output: SI = offset of sorted array
;uses:  SWAP
        PUSH    AX
        PUSH    BX
        PUSH    CX
        PUSH    DX
        PUSH    SI
        DEC     BX        ;N = N-1              
        JE      END_SORT  ;exit if 1-elt array
        MOV     DX,SI     ;save array offset
        ;for n-1 times do
        SORT_LOOP:      
                MOV     SI,DX     ;SI pts to array
                MOV     CX,BX     ;no. of comparisons to make
                MOV     DI,SI     ;DI pts to largest element
                MOV     AX,[DI]   ;AL has largest element
                ;locate biggest of remaining elts
                FIND_BIG:
                        INC     SI        ;SI pts to next element               
                        INC     SI        ;SI pts to next element               
                        CMP     [SI],AX   ;is new element > largest?                   
                        JNG     NEXT      ;no, go on
                        MOV     DI,SI     ;yes, move DI
                        MOV     AX,[DI]   ;AL has largest element
                NEXT:         
                LOOP    FIND_BIG  ;loop until done      
                ;swap biggest elt with last elt
        CALL    SWAP      ;Swap with last elt
        DEC     BX        ;N = N-1                      
        JNE     SORT_LOOP ;repeat if N <> 0             
        END_SORT:       
                POP     SI
                POP     DX
                POP     CX
                POP     BX
                POP     AX
                RET
SELECT  ENDP

SWAP    PROC
;swaps two array elements
;input: SI = one element
;       DI = other element
;output: exchanged elements
        PUSH    AX      ;save AX
        MOV     AX,[SI] ;get A[I]
        XCHG    AX,[DI] ;place in A[K]
        MOV     [SI],AX ;put A[K] in A[I]
        POP     AX      ;restore AX
        RET
SWAP    ENDP                              