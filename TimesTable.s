    B start
line1   DEFB "Please enter an integar of your choice ",0
line2	DEFB "Your number is ",0
gap     DEFB "\n",0
comma   DEFB ",",0
fault   DEFB "Error the input must be a digit between 0 and 9",0
line3	DEFB "Here is the times table",0
x	DEFB "x",0
is	DEFB " is ",0

        ALIGN
start	MOV R4,#10
	ADR R0,line1
	MOV R1, #0
	SWI 3

main    SWI 1
	CMP R0,#10
	BEQ show
	CMP R0,#57
	BGT Error
	CMP R0,#48
	BLT Error
	ADD R1,R1,#1
	SUB R0,R0,#'0'
	SWI 4	
	MOV R3,R0
	CMP R1,#1
	BNE times
	MOV R2,R0
	B main
	

times   MUL R2,R2,R4
	ADD R2,R2,R3
	B main

Error   ADR R0,gap
	SWI 3	
	ADR R0,fault
	SWI 3
	ADR R0,gap
	SWI 3
	B start

show	ADR R0,gap
	SWI 3
	ADR R0,line2
	SWI 3
	MOV R0,R2
	SWI 4
	ADR R0,gap
	SWI 3
	ADR R0,line3
	SWI 3
	MOV R1,#1
table   ADR R0,gap
	SWI 3	
	MOV R0,R1
	SWI 4
	ADR R0,x
	SWI 3
	MOV R0,R2
	SWI 4
	ADR R0, is
	SWI 3
	MUL R0,R1,R2
	SWI 4
	ADD R1,R1,#1
	CMP R1,R2
	BLE table	 
	SWI 2
	
