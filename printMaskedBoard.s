        B main
row	DEFB "   1  2  3  4",0
space	DEFB "  ",0
gap	DEFB "\n",0
board	DEFW 	3, 1, 4, 7, 5, 1, 7, 6, 6, 0, 2, 5, 0, 4, 2, 3

		ALIGN

; printMaskedBoard -- print the board with only the squares in R1 and R2 visible
; Input: R0 <-- Address of board
;        R1 <-- Number of Cell to reveal
;        R2 <-- Number of Cell to reveal


    ; Insert your implementation of printMaskedBoard here.



PRINTR  	ADR R0,space
		SWI  3
		MOV R5,#1

test		CMP R6,R1
		BEQ Astrix
		CMP R6,R2
		BEQ Astrix
		B mask

mask            MOV R0,#'*'
		SWI 0
		B COMP 



Astrix		ADR R0, board 
		MUL R4,R6,R3	
		LDRB R0,[R0,R4]
		ADD R0,R0,#'A'
		SWI 0
COMP		ADR R0,space
		SWI 3
		ADD R6,R6,#1
		ADD R5,R5,#1
		CMP R5,#4
		BLE test
		MOV PC,R14



printMaskedBoard MOV R13,R14
		MOV R3,#4	    
		MOV R6,#0
		ADR R0,row
		SWI 3
		ADR R0,gap
		SWI 3
		MOV R0,#'A'
		SWI 0
		BL PRINTR
		ADR R0,gap
		SWI 3
		MOV R0,#'B'
		SWI 0
		BL PRINTR
		ADR R0,gap
		SWI 3
		MOV R0,#'C'
		SWI 0
		BL PRINTR
		ADR R0,gap
		SWI 3
		MOV R0,#'D'
		SWI 0
		BL PRINTR
		MOV PC,R13

main 	        ADRL R0, board 
        	MOV R1, #2
        	MOV R2, #15
        	BL printMaskedBoard
        	SWI 2

