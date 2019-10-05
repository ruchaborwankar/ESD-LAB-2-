ORG 0000H	;START OF PROGRAM	
LJMP MAIN 	;MAIN PROGRAM

ORG 000BH	;TIMER INTERRUPT ADDRESS
LJMP ISR	;JUMP TO ISR

MAIN: MOV TMOD,#01H	;INITIALIZE MODE 1
MOV TH0,#0F5H	;SET TIMER TO 0
MOV TL0,#02FH	;SET TIMER TO 0
SETB TR0		;START THE TIMER
MOV R0,#08H
MOV IE,#82H		;SET INTERRUPT FLAG
HERE:SJMP HERE

ISR:
DJNZ R0,X	;decrement And jump if it is not zero	
CPL P1.0	;complement led
MOV R0,#08H;reset the resistor to 7 for 500ms
MOV TH0,#0F5H
MOV TL0,#02FH
X:SETB P1.2	;set port p1.2
CLR TF0	;clear the overflow flag
CLR P1.2
RETI		;return from isr to main
END
