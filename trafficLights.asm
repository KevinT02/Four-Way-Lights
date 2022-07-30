Traffic Lights

title  "trafficLights"
;
; A program that uses subroutines and loops to simulate a traffic light intersection system on a roundabout
;
; Hardware Notes:
; PIC16F684 running at 4 MHz
;   Inputs:
;		
;   Outputs:
;	RC0, RC1, RC2	- outputs, 3x2 LED's (3 pairs of red, yellow, green)
;			- turn first to indicate bridge moving
;			- called 'north' to refer to the stoplights on the north end of the roundabout
;	RC3, RC4, RC5	- outputs, 3x3 LED's (3 sets of 3 red, yellow, green)
;			- turn second to stop cars on roundabout
;			- called 'south' to refer to the stoplights on the south, east, and west ends of the roundabout
;
; Kevin Tu
; 12/7/2019
;--------------------------------------------------------------------------
; Setup
    LIST R=DEC				
    INCLUDE "p16f684.inc" 
    INCLUDE "asmDelay.inc"

 __CONFIG _FCMEN_OFF & _IESO_OFF & _BOD_OFF & _CPD_OFF & _CP_OFF & _MCLRE_OFF & _PWRTE_ON & _WDT_OFF & _INTOSCIO

;  Variables
    CBLOCK 0x020 

    ENDC 
;--------------------------------------------------------------------------
PAGE
;  Mainline of "trafficLights"

org    0
    movlw   7				;turn off Comparators
    movwf   CMCON0

    bsf     STATUS, RP0			;going into Bank 1
    clrf    ANSEL ^ 0x080		;all PORTS are Digital

    clrf    TRISC ^ 0X080		;teach all of PORT C to be outputs
    
    bcf	    STATUS, RP0			;going back into Bank 0
    
loop:
    nop
    call seqOne
    call seqTwo
    call seqThree
    call seqFour
    call seqFive
    goto loop
    
;--------------------------------------------------------------------------
PAGE
;Subroutines
 
seqOne:
    movlw b'00010001'		;north red and south yellow are on
    movwf PORTC			;applying that to RA bits
    Dlay 3000000		;delay of 3 seconds
    nop
    return
    
seqTwo:
    movlw b'00100001'		;north red and south red are on
    movwf PORTC			
    Dlay 10000000		;delay of 10 seconds
    nop
    return 
	
seqThree:
    movlw b'00001001'		;north red and south green are on
    movwf PORTC
    Dlay 3000000		;delay of 3 second
    nop
    return

seqFour:
    movlw b'00001100'		;north green and south green are on
    movwf PORTC
    Dlay 15000000		;delay of 15 seconds
    nop
    return

seqFive:
    movlw b'00001010'		;north yellow and south green are on
    movwf PORTC
    Dlay 3000000		;delay of 3 seconds
    nop
    return  

end
