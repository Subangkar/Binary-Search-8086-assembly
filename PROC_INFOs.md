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
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/Dec16bitInput.asm






; OUTDEC PROC
; this procedure will display a decimal number
; input : AX
; output : none
; uses : MAIN
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/Dec16bitOutput.asm






; PRINT_INT_DW_ARRAY PROC
; this procedure will display a list of decimal numbers
; input:    SI = array offset address
;           CX = number of elements
; output : none
; uses : OUTDEC
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/PrintIntArray.asm





; SCAN_INT_DW_ARRAY PROC
; this procedure will input a list of decimal numbers
; input:    SI = array offset address where to store
;           CX = number of elements at most to scan
;           AL = stop instant @ receiving @char
; output :  CX = number of elements scanned
;           SI = array offset address where to store       
; uses : INDEC
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/ScanIntArray.asm





; SELECT  PROC
;sorts a byte array by the selectsort method
;input: SI = array offset address
;       BX = number of elements
;output: SI = offset of sorted array
;uses:  SWAP
INCLUDE C:/users/subangkar/Desktop/MIC/Assembly/Offline-03/SelectionSort.asm

