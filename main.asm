
_led_routine:

;main.c,10 :: 		void led_routine() {
;main.c,12 :: 		for (i=0; i<2; i++){
	CLRF       R1+0
	CLRF       R1+1
L_led_routine0:
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__led_routine15
	MOVLW      2
	SUBWF      R1+0, 0
L__led_routine15:
	BTFSC      STATUS+0, 0
	GOTO       L_led_routine1
;main.c,13 :: 		LED = 1;
	BSF        PORTB+0, 7
;main.c,14 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_led_routine3:
	DECFSZ     R13+0, 1
	GOTO       L_led_routine3
	DECFSZ     R12+0, 1
	GOTO       L_led_routine3
	DECFSZ     R11+0, 1
	GOTO       L_led_routine3
	NOP
	NOP
;main.c,15 :: 		LED = 0;
	BCF        PORTB+0, 7
;main.c,16 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_led_routine4:
	DECFSZ     R13+0, 1
	GOTO       L_led_routine4
	DECFSZ     R12+0, 1
	GOTO       L_led_routine4
	DECFSZ     R11+0, 1
	GOTO       L_led_routine4
	NOP
	NOP
;main.c,12 :: 		for (i=0; i<2; i++){
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;main.c,18 :: 		}
	GOTO       L_led_routine0
L_led_routine1:
;main.c,19 :: 		}
L_end_led_routine:
	RETURN
; end of _led_routine

_main:

;main.c,23 :: 		void main() {
;main.c,26 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,27 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,30 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,31 :: 		UART1_Write_Text("Inicializado");
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,32 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main5:
	DECFSZ     R13+0, 1
	GOTO       L_main5
	DECFSZ     R12+0, 1
	GOTO       L_main5
	DECFSZ     R11+0, 1
	GOTO       L_main5
	NOP
;main.c,34 :: 		led_routine();
	CALL       _led_routine+0
;main.c,36 :: 		while (1) {
L_main6:
;main.c,38 :: 		if (UART1_Data_Ready() == 1) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;main.c,39 :: 		dato = UART1_Read();
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _dato+0
;main.c,40 :: 		}
L_main8:
;main.c,42 :: 		switch (dato) {
	GOTO       L_main9
;main.c,43 :: 		case 'a':
L_main11:
;main.c,44 :: 		LED = 1;
	BSF        PORTB+0, 7
;main.c,45 :: 		break;
	GOTO       L_main10
;main.c,47 :: 		default:
L_main12:
;main.c,48 :: 		LED = 0;
	BCF        PORTB+0, 7
;main.c,49 :: 		break;
	GOTO       L_main10
;main.c,50 :: 		}
L_main9:
	MOVF       _dato+0, 0
	XORLW      97
	BTFSC      STATUS+0, 2
	GOTO       L_main11
	GOTO       L_main12
L_main10:
;main.c,52 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
;main.c,53 :: 		}
	GOTO       L_main6
;main.c,54 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
