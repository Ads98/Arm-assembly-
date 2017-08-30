        B main

seed 	DEFW 1234567
hi	DEFB " hi ",0
here	DEFB " here ",0
HERE2	DEFB " HERE2 ",0
	ALIGN
multi	DEFW 65539
row	DEFB "   1  2  3  4",0
space	DEFB "  ",0
gap	DEFB "\n",0


        ALIGN

	board	DEFW 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 

main    ADRL R0,gap
	SWI 3
	ADR R0, board
	MOV R5,#0
	MOV R6,#0
gen	BL randu
	BL make
	CMP R5,#8
	BNE gen
        BL printBoard
        SWI 2

; printBoard -- print the board 
; Input: R0 <-- Address of board
        ; Copy your implementation of printBoard here from the firsrt exercise

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



printBoard   	ADRL R0, board
		MOV R13,R14 
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
		ADRL R0,gap
		SWI 3
		MOV R0,#'D'
		SWI 0
		BL PRINTR
		BL RESET
        	MOV PC,R13
		

make		ADRL R0,board
		LDR R0,[R0,R4]
		CMP R0,#-1
 		BNE fin
		ADRL R0,board
		STR R5,[R0,R4]
		ADD R6,R6,#1
		CMP R6,#2
		BEQ newChar
		B fin

newChar		MOV R6,#0		
		ADD R5,R5,#1

fin		MOV PC,R14


RESET		ADRL R0,board
		MOV R6,#0
		MOV R5,#-1
initialise	ADRL R0,board	
		STR R5,[R0,R6 lsl #2]
		ADD R6,R6,#1
		CMP R6,#16
		BNE initialise
		MOV PC,R14
		

; randu -- Generates a random number
; Input: None
; Ouptut: R0 -> Random number

randu	LDR R0,seed	
	LDR R2,seed
	LDR R3,multi
	MUL R2,R2,R3
	MOV R1, #0x7FFFFFFF
	AND R0,R2,R1
	STR R0,seed
	MOV R0, R0 ASR #8;  
        AND R0, R0, #0xf ;
	MOV R4,#4
	MUL R4,R0,R4
	MOV PC,R14



        ; Copy your implementation of randu from the previous coursework here

