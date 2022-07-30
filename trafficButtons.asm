QTI Sensor

title  "trafficButtons"
;
; A program that uses a QTI sensor to sense whether or not Santa's sleigh is approaching. 
; Lights flash if QTI senses something
;
;  Hardware Notes:
;  PIC16F684 running at 4 MHz
;	Inputs:
;		RA5 - QTI sensor
;
;	Outputs:
;		RC0, RC1, RC2, RC3, RC4 connected to LED's through 1K resistors	
;
; Kevin Tu
; 12/10/2019
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
;  Mainline of "TrafficLightsVTwo"

org    0
    movlw   7				;turn off Comparators
    movwf   CMCON0

    bsf     STATUS, RP0			;going into Bank 1
    clrf    ANSEL ^ 0x080		;making all PORTS are Digital

    clrf    TRISC ^ 0x080		;teach all of PORTC to be outputs
    
    movlw   b'00011000'			;leaving RA3 and RA4 as inputs, teaching everything else in PORTA to be outputs
    movwf   TRISA ^ 0x080		;moving binary value into TRISA to correspond with RA values
    
    bcf	    STATUS, RP0			;going back into Bank 0
    
loop:
    nop
    btfss PORTA, 4
	call button
    btfsc PORTA, 4
	call noButton
    goto loop
    
    
;--------------------------------------------------------------------------
PAGE
;Subroutines
   
noButton:
    clrf PORTC
    return
	
button:
    Dlay 1000000		    ;delay 1 second
	movlw b'00000001'	    ;turning on first LED
	movwf PORTC
    Dlay 2000000		    ;delay 2 seconds
	movlw b'00000011'	    ;turning on second LED
	movwf PORTC
    Dlay 2000000		    ;delay 2 seconds
	movlw b'00000111'	    ;turning on third LED
	movwf PORTC
    Dlay 2000000		    ;delay 2 seconds
	movlw b'00001111'	    ;turning on fourth LED
	movwf PORTC
    Dlay 2000000		    ;delay 2 seconds
	movlw b'00011111'	    ;turning on fifth LED
	movwf PORTC		
    Dlay 1000000		    ;delay 1 second
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 1000000		    ;turn off (essentially flashing on and off with intervals of 1 second)
	clrf PORTC
	nop
    Dlay 1000000
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 1000000
	clrf PORTC
	nop
    Dlay 1000000
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 1000000
	clrf PORTC
	nop	
    Dlay 1000000
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 1000000
	clrf PORTC
	nop	
    Dlay 1000000
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 1000000
	clrf PORTC
	nop	
    Dlay 100000			;flashing on and off with intervals of 0.1 seconds
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 100000
	clrf PORTC
	nop
    Dlay 100000
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 100000
	clrf PORTC
	nop
    Dlay 100000
	movlw b'00011111'
	movwf PORTC
	nop
     Dlay 100000
	clrf PORTC
	nop   
    Dlay 100000
	movlw b'00011111'
	movwf PORTC
	nop
     Dlay 100000
	clrf PORTC
	nop 
    Dlay 100000
	movlw b'00011111'
	movwf PORTC
	nop
    Dlay 100000
	clrf PORTC
	nop
	return    
end

