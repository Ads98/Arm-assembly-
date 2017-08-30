    B main
line1   DEFB "Please enter an integar of your choice ",0
line2	DEFB "Your number is ",0
gap     DEFB "\n",0
comma   DEFB ",",0
fault   DEFB "Error the input must be a digit between 0 and 9",0
prompt  DEFB "Enter a number",0
result  DEFB " You entered ",0 
        ALIGN
readInt	MOV R4,#10
	ADR R0,line1
	MOV R1, #0
	SWI 3

input   SWI 1
	CMP R0,#10
	BEQ End
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
	B input
	

times   MUL R2,R2,R4
	ADD R2,R2,R3
	B input

Error   ADR R0,gap
	SWI 3	
	ADR R0,fault
	SWI 3
	ADR R0,gap
	SWI 3
	B readInt

	
End 	MOV PC,R14	 

main
	ADR R0,prompt
 	BL readInt
 	MOV R1,R0
 	ADR R0,result
 	SWI 3
	ADR R0,gap
	SWI 3
	MOV R0,R2
	SWI 4 
	SWI 2
	
