
_initialize_alarms:

;main.c,35 :: 		void initialize_alarms() {
;main.c,38 :: 		for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
	CLRF       R1+0
L_initialize_alarms0:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initialize_alarms14
	MOVF       R1+0, 0
	SUBLW      30
L__initialize_alarms14:
	BTFSS      STATUS+0, 0
	GOTO       L_initialize_alarms1
;main.c,39 :: 		alarms[index] = 0;
	MOVF       R1+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	CLRF       INDF+0
;main.c,38 :: 		for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
	INCF       R1+0, 1
;main.c,40 :: 		}
	GOTO       L_initialize_alarms0
L_initialize_alarms1:
;main.c,42 :: 		}
L_end_initialize_alarms:
	RETURN
; end of _initialize_alarms

_update_alarm:

;main.c,45 :: 		void update_alarm(char alarm_data[ALARM_PACKET_LENGTH]) {
;main.c,47 :: 		char alarm_index = GET_ALARM_INDEX(alarm_data[0]);
	MOVF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      update_alarm_alarm_index_L0+0
	RRF        update_alarm_alarm_index_L0+0, 1
	BCF        update_alarm_alarm_index_L0+0, 7
	RRF        update_alarm_alarm_index_L0+0, 1
	BCF        update_alarm_alarm_index_L0+0, 7
	RRF        update_alarm_alarm_index_L0+0, 1
	BCF        update_alarm_alarm_index_L0+0, 7
	RRF        update_alarm_alarm_index_L0+0, 1
	BCF        update_alarm_alarm_index_L0+0, 7
	MOVLW      15
	ANDWF      update_alarm_alarm_index_L0+0, 1
;main.c,65 :: 		UART1_Write_Text("Revisando indice");
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,66 :: 		if (0 <= alarm_index && alarm_index <= MAX_ALARMS) {
	MOVLW      0
	SUBWF      update_alarm_alarm_index_L0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_update_alarm5
	MOVF       update_alarm_alarm_index_L0+0, 0
	SUBLW      10
	BTFSS      STATUS+0, 0
	GOTO       L_update_alarm5
L__update_alarm12:
;main.c,67 :: 		char offset = alarm_index * ALARM_PACKET_LENGTH;
	MOVF       update_alarm_alarm_index_L0+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      update_alarm_offset_L1+0
;main.c,69 :: 		UART1_Write_Text("Alarma encontrada");
	MOVLW      ?lstr2_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,71 :: 		alarms[offset + ALARM_FLAG_BYTE_OFFSET] = alarm_data[ALARM_FLAG_BYTE_OFFSET];
	MOVF       update_alarm_offset_L1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      R1+0
	MOVF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,72 :: 		alarms[offset + ALARM_HOUR_BYTE_OFFSET] = Bcd2Dec(
	MOVF       update_alarm_offset_L1+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FLOC__update_alarm+0
;main.c,73 :: 		alarm_data[ALARM_HOUR_BYTE_OFFSET]
	INCF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
;main.c,74 :: 		);
	MOVF       FLOC__update_alarm+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,75 :: 		alarms[offset + ALARM_MINUTE_BYTE_OFFSET] = Bcd2Dec(
	MOVLW      2
	ADDWF      update_alarm_offset_L1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FLOC__update_alarm+0
;main.c,76 :: 		alarm_data[ALARM_MINUTE_BYTE_OFFSET]
	MOVLW      2
	ADDWF      FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
;main.c,77 :: 		);
	MOVF       FLOC__update_alarm+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,81 :: 		PORTB = alarms[offset + ALARM_FLAG_BYTE_OFFSET];
	MOVF       update_alarm_offset_L1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;main.c,82 :: 		UART1_Write_Text("Flags");
	MOVLW      ?lstr3_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,83 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_update_alarm6:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm6
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm6
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm6
	NOP
	NOP
;main.c,85 :: 		PORTB = alarms[offset + ALARM_HOUR_BYTE_OFFSET];
	MOVF       update_alarm_offset_L1+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;main.c,86 :: 		UART1_Write_Text("Hora");
	MOVLW      ?lstr4_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,87 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_update_alarm7:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm7
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm7
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm7
	NOP
	NOP
;main.c,89 :: 		PORTB = alarms[offset + ALARM_MINUTE_BYTE_OFFSET];
	MOVLW      2
	ADDWF      update_alarm_offset_L1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;main.c,90 :: 		UART1_Write_Text("Minutos");
	MOVLW      ?lstr5_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,91 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_update_alarm8:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm8
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm8
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm8
	NOP
	NOP
;main.c,93 :: 		}
L_update_alarm5:
;main.c,94 :: 		}
L_end_update_alarm:
	RETURN
; end of _update_alarm

_check_alarms:

;main.c,96 :: 		void check_alarms() {
;main.c,118 :: 		}
L_end_check_alarms:
	RETURN
; end of _check_alarms

_main:

;main.c,120 :: 		void main() {
;main.c,123 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,124 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,127 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,128 :: 		UART1_Write_Text("Inicializado");
	MOVLW      ?lstr6_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,130 :: 		while (TRUE) {
L_main9:
;main.c,131 :: 		UART1_Write_Text("Main loop");
	MOVLW      ?lstr7_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,143 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
	NOP
;main.c,146 :: 		fakeAlarm[0] = 0x5D; // 0101 1101
	MOVLW      93
	MOVWF      main_fakeAlarm_L0+0
;main.c,147 :: 		fakeAlarm[1] = 0x11;
	MOVLW      17
	MOVWF      main_fakeAlarm_L0+1
;main.c,148 :: 		fakeAlarm[2] = 0x35;
	MOVLW      53
	MOVWF      main_fakeAlarm_L0+2
;main.c,149 :: 		UART1_Write_Text("Enviando alarma");
	MOVLW      ?lstr8_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,150 :: 		update_alarm(fakeAlarm);
	MOVLW      main_fakeAlarm_L0+0
	MOVWF      FARG_update_alarm_alarm_data+0
	CALL       _update_alarm+0
;main.c,151 :: 		}
	GOTO       L_main9
;main.c,153 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
