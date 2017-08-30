        B main

row	DEFB "   1  2  3  4",0
space	DEFB "  ",0
gap	DEFB "\n",0
fault   DEFB "Error the input must be a digit between 0 and 9",0	
single	DEFB " ",0
varible	DEFB "variable = ",0
entered	DEFB "you entered ",0
multi	DEFW 65539
con	DEFB "well done you found a match",0
any	DEFB "press any key to continue",0
prompt	DEFB " Please enter the baord position in the form C1 or A4 from A-H ,0-15 ",0
prompt1	DEFB " please enter a letter A-D",0
prompt2 DEFB "pleaseenter a number 1-15"
seed    DEFW    0x1234567


        ALIGN
	board	DEFW 	-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1 
main    MOV R13,#0x100000     ; Setup stack (see Lecture 21)

; Your main game loop should go here
	MOV R10,#0	
	MOV R7,#16
	MOV R8,#16
	BL  generateBoard
loop	MOV R9,#0
	MOV R7,#16
	MOV R8,#16
	BL cls
	BL printMaskedBoard
	BL boardSquareInput
	BL cls
	BL printMaskedBoard
	BL boardSquareInput
	BL cls
	BL printMaskedBoard
	BL delete
	ADRL R0,gap
	SWI 3
	ADRL R0,any
	SWI 3
	SWI 1
	CMP R10,#8
	BNE loop
	ADRL R0,gap
	SWI 3
	BL printMaskedBoard
	SWI 2

; cls -- Clears the Screen
; Input : None
; Ouptut: None

cls	MOV R1,#0	
cls2	ADRL R0,gap
	SWI 3
	ADD R1,R1,#1
	CMP R1,#100
	BNE cls2
        MOV PC,R14

; boardSquareInput -- read the square to reveael from the Keyboard
; Input:  R0 <- address of prompt for user
; Output: R0 <- Array index of entered square

boardSquareInput
	;MOV R13,R14
	STMFD R13!,{R14} 
select	ADRL R0,gap
	SWI 3
	ADRL R0,prompt
	SWI 3
	SWI 1
	MOV R1,R0
	CMP R0,#65
	BLT boardSquareInput
	CMP R0,# 68
	BGT boardSquareInput
	SWI 0
	SUB R0,R0,#'A'
	MOV R3,#4
	MUL R1,R0,R3
number	BL decimalInput
	ADRL R0,varible
	SWI 3
	MOV R0,R5
	SWI 4
	CMP R5,#0
	BLE select
	CMP R5,#4
	BGT select
	
find	ADD R0,R5,R1
	SUB R0,R0,#1
	ADD R9,R9,#1
	CMP R9,#1
	BEQ square1
	CMP R9,#1
	BGT square2

square1 MOV R7,R0
	LDMFD R13!,{pc} 

square2	MOV R8,R0
	LDMFD R13!,{pc}  




readInt	MOV R4,#10
	MOV R2, #0

input   SWI 1
	CMP R0,#10
	BEQ End
	CMP R0,#57
	BGT Error
	CMP R0,#48
	BLT Error
	ADD R2,R2,#1
	SUB R0,R0,#'0'
	SWI 4	
	MOV R3,R0
	CMP R2,#1
	BNE times
	MOV R5,R0
	B input
	

times   MUL R5,R5,R4
	ADD R5,R5,R3
	B input

Error   ADRL R0,gap
	SWI 3	
	ADRL R0,fault
	SWI 3
	ADRL R0,gap
	SWI 3
	B readInt

	
End	CMP R2,#1
	BNE terminate	
	MOV R5,R3 	
terminate
	LDMFD R13!,{pc} 	 

decimalInput
	;MOV R12,R14
	STMFD R13!,{R14} 
 	BL readInt
	LDMFD R13!, {pc} 


 generateBoard
; Input R0 -- array to generate board in

;generateBoard
;       Save R14 register here

; Insert your generate board code here...
 
	STMFD   R13!,{R14}   
	ADRL R0,gap
	SWI 3
	ADRL R0, board
	MOV R5,#0
	MOV R6,#0
gen	BL randu
	BL make
	CMP R5,#8
	BNE gen
	LDMFD   R13!,{R14}
        MOV     PC,R14

        ;B displayBoard

; printBoard -- print the board 
; Input: R0 <-- Address of board
        ; Copy your implementation of printBoard here from the firsrt exercise

DisplayR  	ADRL R0,space
		SWI  3
		MOV R1,#1
		

star		ADRL R0, board	
		MUL R4,R2,R3
		LDRB R0,[R0,R4]
		ADD R0,R0,#'A'
		SWI 0
		ADD R2,R2,#1
		ADRL R0,space
		SWI 3
		ADD R1,R1,#1
		CMP R1,#4
		BLE star
		MOV PC,R14



displayBoard   	ADRL R0, board 
	        MOV R3,#4	    
		MOV R2,#0
		ADR R0,row
		SWI 3
		ADRL R0,gap
		SWI 3
		MOV R0,#'A'
		SWI 0
		BL DisplayR
		ADRL R0,gap
		SWI 3
		MOV R0,#'B'
		SWI 0
		BL DisplayR
		ADRL R0,gap
		SWI 3
		MOV R0,#'C'
		SWI 0
		BL DisplayR
		ADRL R0,gap
		SWI 3
		MOV R0,#'D'
		SWI 0
		BL DisplayR
        	LDMFD   R13!,{R14}
        	MOV     PC,R14

		

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

fin		MOV PC,R14;    

	;Restore R14 register here
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

; printMaskedBoard -- print the board with only the squares in R1 and R2 visible
; Input: R0 <-- Address of board
;        R1 <-- Number of Cell to reveal
;        R2 <-- Number of Cell to reveal


PRINTR          ADRL R0,space
		SWI  3
		MOV R5,#1

test		ADRL R0,board
		LDR R0,[R0,R6 lsl #2]
		CMP R0,#-1
		BEQ blank		
		CMP R6,R7
		BEQ Astrix
		CMP R6,R8
		BEQ Astrix
		B mask

mask            MOV R0,#'*'
		SWI 0
		B COMP 

blank		ADRL R0,single
		SWI 3		
		B COMP



Astrix		ADRL R0, board 
		MUL R4,R6,R3	
		LDRB R0,[R0,R4]
		ADD R0,R0,#'A'
		SWI 0
COMP		ADRL R0,space
		SWI 3
		ADD R6,R6,#1
		ADD R5,R5,#1
		CMP R5,#4
		BLE test
		MOV PC,R14



printmain	;MOV R12,R14
		STMFD R13!, {R14}        
		MOV R3,#4	    
		MOV R6,#0
		ADRL R0,row
		SWI 3
		ADRL R0,gap
		SWI 3
		MOV R0,#'A'
		SWI 0
		BL PRINTR
		ADRL R0,gap
		SWI 3
		MOV R0,#'B'
		SWI 0
		BL PRINTR
		ADRL R0,gap
		SWI 3
		MOV R0,#'C'
		SWI 0
		BL PRINTR
		ADRL R0,gap
		SWI 3
		MOV R0,#'D'
		SWI 0
		BL PRINTR
		LDMFD R13!, {pc} 

printMaskedBoard 
		;MOV R13,R14
		STMFD R13!, {R14} 
		;MOV R0,R7
		;SWI 4
		;MOV R0,R8
		;SWI 4
        	BL printmain

        ; Insert your modfiied implementation of printMaskedBoard here.


        LDMFD R13!, {pc} 


delete	ADRL R0,board
	MOV R3,#4
	MUL R1,R7,R3
	MUL R2,R8,R3
	LDR R1,[R0,R1]
	ADD R1,R1,#'A'
	LDR R2,[R0,R2]
	ADD R2,R2,#'A'
	CMP R1,R2
	BEQ remove
	MOV PC,R14

remove  ADRL R0,con
	SWI 3
	MOV R5,#-1
	ADRL R0,board	
	STR R5,[R0,R7 lsl #2]
	ADRL R0,board
	STR R5,[R0,R8 lsl #2]
	ADD R10,R10,#1
	MOV PC,R14
	
