.include "./m328Pdef.inc"


    Start:

        clh; inicializa la bandera de half carry en 0
        clc ;inicializa la bandera de carry en 0    
        ldi r16,0b00011111 ;este registro es el byte 0 numero 1
        ldi r17,0b00000000 ;este registro es el byte 1 numero 1 
        ldi r18,0b00010000 ;este registro es el byte 2 numero 1
        ldi r19,0b00100000 ;este registro es el byte 3 numero 1
        ldi r20,0b11111111 ;este registro es el byte 0 numero 2
        ldi r21,0b00011111 ;este registro es el byte 1 numero 2
        ldi r22,0b00001111 ;este registro es el byte 2 numero 2
        ldi r23,0b00100000 ;este registro es el byte 3 numero 2
        ldi r24,0b10000000 ;este registro temp guarda los signos de ambos numeros
                           ; bit 0 ->num1  bit 1 -> num2

        sbrc r24,0 ;se salta la siguiente linea si bit 0 del registro de signo es cero(el primer numero es positivo)
        rjmp Num1_Positivo
        rjmp Num1_Negativo

    Num1_Negativo:
      
        sbrc r24,1 ;se salta la siguiente linea si bit 1 del registro de signo es cero(el segundo numero es positivo)
        rjmp Num1Neg_Num2Pos
        rjmp Num1Num2_Negativos

    Num1_Positivo:

        sbrc r24,1 ;se salta la siguiente linea si bit 1 del registro de signo es cero(el segundo numero es positivo)
        rjmp Num1Num2_Positivos
        rjmp Num1Pos_Num2Neg

    Num1Num2_Positivos:

        add r16, r20 ;r16 = r16 +r20, suma los primeros 8 bits
        adc r17, r21 ;r17 = r17 + r21 + carry, suma del bit 8 al 16, modifica bandera carry si hay acarreo
        adc r18, r22 ;r18 = r18 + r22 + carry, suma del bit 16 al 24, modifica bandera carry si hay acarreo
        adc r19, r23 ;r18 = r19 + r23 + carry, suma del bit 24 al 32, modifica bandera carry si hay acarreo

    Num1Pos_Num2Neg:

        cpr r19,r23 ;compara si el numero positivo es mayor al negativo
        brge UnoMenosDosPos
        brlt DosMenosUnoNeg
    
 

    Num1Neg_Num2Pos:        

        cpr r23,r19 ;compara si el numero positivo es mayor al negativo     
        brge DosMenosUnoPos
        brlt UnoMenosDosNeg       

    UnoMenosDosPos: 

        sub r16,r20
        sbc r17,r21
        sbc r18,r22
        sbc r19,r23
        ;falta poner el signo del resultado positivo

    UnoMenosDosNeg:

        sub r16,r20
        sbc r17,r21
        sbc r18,r22
        sbc r19,r23
        ;falta poner el signo del resultado negativo

    DosMenosUnoNeg:

        sub r20,r16
        sbc r21,r17
        sbc r22,r18
        sbc r23,r19
        ;falta poner el signo del resultado negativo

    DosMenosUnoPos

        sub r20,r16
        sbc r21,r17
        sbc r22,r18
        sbc r23,r19
        ;falta poner el signo del resultado positivo

    Num1Num2_Negativos:
        
        add r16, r20 ;r16 = r16 +r20, suma los primeros 8 bits
        adc r17, r21 ;r17 = r17 + r21 + carry, suma del bit 8 al 16, modifica bandera carry si hay acarreo
        adc r18, r22 ;r18 = r18 + r22 + carry, suma del bit 16 al 24, modifica bandera carry si hay acarreo
        adc r19, r23 ;r18 = r19 + r23 + carry, suma del bit 24 al 32, modifica bandera carry si hay acarreo