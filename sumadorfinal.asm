.include "./m328Pdef.inc"


	Start:

        clh; inicializa la bandera de half carry en 0
        ldi r16,0b00010000 ;este registro es el numero 1
		ldi r17,0b00010000 ;este registro es el numero 2 para sumarlos
        ldi r18,0b00010000 ;este registro es usado para comparar el signo y carry positivo
        ldi r19,0b00100000 ;este registro es usado para comparar carry de negativos
        ldi r20,0b11111111 ;este registro es para definir el puerto como salida
        ldi r21,0b00011111

        cp r16,r18 ;compara el 16 con el 18
        brge NegativoPrimero ;Branch if r16 mayor o igual al 18 (es negativo)
        brlt PositivoPrimero ;Branch if r16 menor al 18 (es positivo)
        

    NegativoPrimero:
        
        cp r17,r18
        brge MismoSignoNeg ;Branch if r17 mayor o igual al 18 (es negativo)
        brlt DiferenteSignoMayorPrimero ;Branch if r17 menor al 18 (es positivo)

    PositivoPrimero:

        cp r17,r18
        brlt MismoSignoPos ;Branch if r17 menor al 18 (es positivo)
        brge DiferenteSignoMenorPrimero ;Branch if r17 mayor o igual al 18 (es negativo)

    MismoSignoPos:

        add r16,r17 ;r16 = r16 + r17
        cp r16,r18
        brge FixSignoPos ;La suma modifico el bit 5, hay que arreglarlo
        brlt Return ;La suma no tuvo carry al 5to bit, ya termino

    MismoSignoNeg:

        add r16,r17 ;r16 = r16 + r17
        cp r16,r19
        brlt Return ;La suma no tuvo carry al 6to bit, ya termino
        brge FixSignoNeg ;La suma modifico el bit 6, hay que arreglarlo

    DiferenteSignoMayorPrimero:

        sub r16, r17
        jmp Return

    DiferenteSignoMenorPrimero:

        sub r17, r16
        out DDRB,r20 ;setea el puerto d como out
        out PortB,r16 ;saca el registro resultado
        

    FixSignoPos:

        cbr r16,5 ;pone el quinto bit como 0
        seh ;pone la bandera de half carry en 1
        sbr r16,6 ;pone el sextp bit como 1 simbolizando el half carry
        jmp Return

    FixSignoNeg:

        sbr r16,6 ;pone el sexto bit como 0
        cbr r16,5 ;pone el quinto bit como 1
        seh ;pone la bandera de half carry en 1
        sbr r16,5 ;pone el sexto bit como 1 simbolizando el half carry
        jmp Return

    Return: 

        out DDRB,r20 ;setea el puerto d como out
        out PortB,r16 ;saca el registro resultado

