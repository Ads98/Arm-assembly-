    B main
line1   DEFB "Please enter an integar of your choice ",0
line2	DEFB "Your number is ",0
line3	DEFB "Random number generator",0
line4	DEFB "Random number = ",0
enter   DEFB " Please enter a number between 0 and 255 ",0
guess   DEFB " please guess the value ",0
lower   DEFB "  this is lower than the number ",0
higher  DEFB " this is greater than the number",0
correct DEFB " Well done you gussed correctly ",0
gap     DEFB "\n",0
comma   DEFB ",",0
minus   DEFB "Error the number must be postive between the range 0-255 ",0
number	DEFB "You entered ",0
wrong   DEFB "Error the number entered must be between 0 and 255",0
fault   DEFB "Error the input must be a digit between 0 and 9",0
randS   DEFB "The next random number is ",0 
seed 	DEFW 1050
multi	DEFW 65539

        ALIGN

randu   LDR R0,seed
gen	LDR R3,multi
	MUL R0,R0,R3
	MOV R1, #0x7FFFFFFF
	AND R0,R0,R1
	STR R0,seed
	MOV R0, R0 ASR #8 ; shift R0 right by 8 bits 
        AND R0, R0, #0xff ; take the modulo by 256
	MOV R5,R0 
	MOV PC,R14



begin	MOV R4,#10
	ADRL R0,enter
	MOV R1, #0
	SWI 3

build   SWI 1
	CMP R0,#10
	BEQ End
	CMP R0,#45
	BEQ negtive
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
	B build
	

times   MUL R2,R2,R4
	ADD R2,R2,R3
	B build

Error   ADRL R0,gap
	SWI 3	
	ADRL R0,fault
	SWI 3
	ADRL R0,gap
	SWI 3
	B begin

End	ADRL R0,gap
	SWI 3
	ADRL R0,number
	SWI 3
	MOV R0,R2



 	
compare	MOV R1,R0

start   CMP R1,#255
	BGT invalid
	CMP R1,R5
	BGT Greater
	CMP R1,R5
	BLT smaller
	CMP R1,R5
	BEQ equal
	


invalid	MOV R0,R2
	SWI 4
	ADRL R0,gap
	SWI 3
	ADRL R0,wrong
	SWI 3
	ADRL R0,gap
	SWI 3
	B begin

Greater MOV R0,R2
	SWI 4
	ADRL R0,higher
	SWI 3
	B begin

smaller	MOV R0,R2
	SWI 4
	ADRL R0,lower
	SWI 3
	B begin

negtive MOV R0,R2
	SWI 4
	ADRL R0,gap
	SWI 3
	ADRL R0,minus
	SWI 3
	ADRL R0,gap
	SWI 3
	B begin

equal   ADRL R0,correct
	SWI 3
	MOV PC,R14



main	BL randu
	BL begin
	SWI 2




	
