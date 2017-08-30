    B main
line1   DEFB "Please enter an integar of your choice ",0
line2	DEFB "Your number is ",0
line3	DEFB "Random number generator",0
line4	DEFB "Random number = ",0
gap     DEFB "\n",0
comma   DEFB ",",0
next   DEFB "The next random number is ",0 
seed 	DEFW 120
multi	DEFW 65539

        ALIGN

main    LDR R2,seed 
	ADR R0,gap
	SWI 3
	LDR R0,seed
	ADR R0,gap
	SWI 3
	ADR R0,line2
	SWI 3
	MOV R0,R2
	SWI 4
	ADR R0,gap
	SWI 3
	ADR R0,line3
	SWI 3
	ADR R0,gap
	SWI 3
	ADR R0,line4
	SWI 3
	LDR R3,multi
	MUL R2,R2,R3
	MOV R1, #0x7FFFFFFF
	AND R0,R2,R1
	STR R0,seed
 	SWI 4
	B main 
	 
	
	 
	
