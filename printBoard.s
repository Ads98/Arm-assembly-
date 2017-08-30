        B main
row	DEFB "   1  2  3  4",0
space	DEFB "  ",0
gap	DEFB "\n",0
board	DEFW 	3, 1, 4, 7, 5, 1, 7, 6, 6, 0, 2, 5, 0, 4, 2, 3

        	ALIGN

; printBoard -- print the board 
; Input: R0 <-- Address of board
    ; Insert your implementation here
PRINTR  	ADR R0,space
		SWI  3
		MOV R1,#1
Astrix		ADR R0, board
		MUL R4,R2,R3	
		LDRB R0,[R0,R4]
		ADD R0,R0,#'A'
		SWI 0
		ADD R2,R2,#1
		ADR R0,space
		SWI 3
		ADD R1,R1,#1
		CMP R1,#4
		BLE Astrix
		MOV PC,R14
printBoard	MOV R13,R14	
		MOV R3,#4	    
		MOV R2,#0
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
main    	ADR R0, board 
        	BL printBoard
        	SWI 2
