.include "./m329Pdef.inc"


	Start:
		
		ldi r16,0b01001000 ;este registro es para el D 
		ldi r15,0b00001000 ;este registro es para el B

		out DDRB,r15
		out PortB,r15

		out DDRD,r15
		out PortB,r15
		
