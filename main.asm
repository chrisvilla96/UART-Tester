
_ord:

;main.c,7 :: 		int ord(char c) { return (int)c; }
	MOVF       FARG_ord_c+0, 0
	MOVWF      R0+0
	CLRF       R0+1
L_end_ord:
	RETURN
; end of _ord

_parse_alarm_string:

;main.c,18 :: 		void parse_alarm_string(char alarm_string[FULL_PACKET_LENGTH]) {
;main.c,21 :: 		int index = 0;
	CLRF       parse_alarm_string_index_L0+0
	CLRF       parse_alarm_string_index_L0+1
	CLRF       parse_alarm_string_alarm_minute_L0+0
	CLRF       parse_alarm_string_alarm_minute_L0+1
	CLRF       parse_alarm_string_dispenser_1_state_L0+0
	CLRF       parse_alarm_string_dispenser_1_state_L0+1
	CLRF       parse_alarm_string_dispenser_2_state_L0+0
	CLRF       parse_alarm_string_dispenser_2_state_L0+1
	CLRF       parse_alarm_string_dispenser_3_state_L0+0
	CLRF       parse_alarm_string_dispenser_3_state_L0+1
	CLRF       parse_alarm_string_alarm_state_L0+0
	CLRF       parse_alarm_string_alarm_state_L0+1
;main.c,29 :: 		for(index = 0; index <= MAX_ALARMS; index++) {
	CLRF       parse_alarm_string_index_L0+0
	CLRF       parse_alarm_string_index_L0+1
L_parse_alarm_string0:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      parse_alarm_string_index_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__parse_alarm_string12
	MOVF       parse_alarm_string_index_L0+0, 0
	SUBLW      10
L__parse_alarm_string12:
	BTFSS      STATUS+0, 0
	GOTO       L_parse_alarm_string1
;main.c,30 :: 		UART1_Write_Text("Alarm index");
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,33 :: 		alarm_minute = 0;
	CLRF       parse_alarm_string_alarm_minute_L0+0
	CLRF       parse_alarm_string_alarm_minute_L0+1
;main.c,34 :: 		dispenser_1_state = 0;
	CLRF       parse_alarm_string_dispenser_1_state_L0+0
	CLRF       parse_alarm_string_dispenser_1_state_L0+1
;main.c,35 :: 		dispenser_2_state = 0;
	CLRF       parse_alarm_string_dispenser_2_state_L0+0
	CLRF       parse_alarm_string_dispenser_2_state_L0+1
;main.c,36 :: 		dispenser_3_state = 0;
	CLRF       parse_alarm_string_dispenser_3_state_L0+0
	CLRF       parse_alarm_string_dispenser_3_state_L0+1
;main.c,37 :: 		alarm_state = 0;
	CLRF       parse_alarm_string_alarm_state_L0+0
	CLRF       parse_alarm_string_alarm_state_L0+1
;main.c,39 :: 		alarm_hours[index] = alarm_hour;
	MOVF       parse_alarm_string_index_L0+0, 0
	MOVWF      R0+0
	MOVF       parse_alarm_string_index_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _alarm_hours+0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;main.c,40 :: 		alarm_minutes[index] = alarm_minute;
	MOVF       parse_alarm_string_index_L0+0, 0
	MOVWF      R0+0
	MOVF       parse_alarm_string_index_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _alarm_minutes+0
	MOVWF      FSR
	MOVF       parse_alarm_string_alarm_minute_L0+0, 0
	MOVWF      INDF+0
	MOVF       parse_alarm_string_alarm_minute_L0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;main.c,41 :: 		dispenser_1_states[index] = dispenser_1_state;
	MOVF       parse_alarm_string_index_L0+0, 0
	MOVWF      R0+0
	MOVF       parse_alarm_string_index_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _dispenser_1_states+0
	MOVWF      FSR
	MOVF       parse_alarm_string_dispenser_1_state_L0+0, 0
	MOVWF      INDF+0
	MOVF       parse_alarm_string_dispenser_1_state_L0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;main.c,42 :: 		dispenser_2_states[index] = dispenser_2_state;
	MOVF       parse_alarm_string_index_L0+0, 0
	MOVWF      R0+0
	MOVF       parse_alarm_string_index_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _dispenser_2_states+0
	MOVWF      FSR
	MOVF       parse_alarm_string_dispenser_2_state_L0+0, 0
	MOVWF      INDF+0
	MOVF       parse_alarm_string_dispenser_2_state_L0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;main.c,43 :: 		dispenser_3_states[index] = dispenser_3_state;
	MOVF       parse_alarm_string_index_L0+0, 0
	MOVWF      R0+0
	MOVF       parse_alarm_string_index_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _dispenser_3_states+0
	MOVWF      FSR
	MOVF       parse_alarm_string_dispenser_3_state_L0+0, 0
	MOVWF      INDF+0
	MOVF       parse_alarm_string_dispenser_3_state_L0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;main.c,44 :: 		alarm_set_states[index] = alarm_state;
	MOVF       parse_alarm_string_index_L0+0, 0
	MOVWF      R0+0
	MOVF       parse_alarm_string_index_L0+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _alarm_set_states+0
	MOVWF      FSR
	MOVF       parse_alarm_string_alarm_state_L0+0, 0
	MOVWF      INDF+0
	MOVF       parse_alarm_string_alarm_state_L0+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
;main.c,29 :: 		for(index = 0; index <= MAX_ALARMS; index++) {
	INCF       parse_alarm_string_index_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       parse_alarm_string_index_L0+1, 1
;main.c,45 :: 		}
	GOTO       L_parse_alarm_string0
L_parse_alarm_string1:
;main.c,46 :: 		}
L_end_parse_alarm_string:
	RETURN
; end of _parse_alarm_string

_main:

;main.c,48 :: 		void main() {
;main.c,49 :: 		PORTC = 0x00;
	CLRF       PORTC+0
;main.c,50 :: 		TRISC = 0x80;  // PORTC.Bit7 is Input for UART.
	MOVLW      128
	MOVWF      TRISC+0
;main.c,52 :: 		strcpy(inputBuffer, "");
	MOVLW      _inputBuffer+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr2_main+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;main.c,55 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,56 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;main.c,58 :: 		UART1_Write_Text("Start");
	MOVLW      ?lstr3_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,59 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;main.c,60 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;main.c,62 :: 		while (1) {                     // Endless loop
L_main4:
;main.c,63 :: 		if (UART1_Data_Ready() == 1) {     // If data is received,
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;main.c,66 :: 		UART1_Read_Text(inputBuffer, ";", FULL_PACKET_LENGTH + 1);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_UART1_Read_Text_Output+0
	MOVLW      ?lstr4_main+0
	MOVWF      FARG_UART1_Read_Text_Delimiter+0
	MOVLW      81
	MOVWF      FARG_UART1_Read_Text_Attempts+0
	CALL       _UART1_Read_Text+0
;main.c,68 :: 		if (strlen(inputBuffer) > 0) {
	MOVLW      _inputBuffer+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main14
	MOVF       R0+0, 0
	SUBLW      0
L__main14:
	BTFSC      STATUS+0, 0
	GOTO       L_main7
;main.c,69 :: 		UART1_Write_Text(inputBuffer);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,70 :: 		parse_alarm_string(inputBuffer);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_parse_alarm_string_alarm_string+0
	CALL       _parse_alarm_string+0
;main.c,71 :: 		strcpy(inputBuffer, "");
	MOVLW      _inputBuffer+0
	MOVWF      FARG_strcpy_to+0
	MOVLW      ?lstr5_main+0
	MOVWF      FARG_strcpy_from+0
	CALL       _strcpy+0
;main.c,72 :: 		} else {
	GOTO       L_main8
L_main7:
;main.c,73 :: 		UART1_Write_Text("Puta");
	MOVLW      ?lstr6_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,74 :: 		}
L_main8:
;main.c,75 :: 		}
L_main6:
;main.c,78 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main9:
	DECFSZ     R13+0, 1
	GOTO       L_main9
	DECFSZ     R12+0, 1
	GOTO       L_main9
	DECFSZ     R11+0, 1
	GOTO       L_main9
	NOP
	NOP
;main.c,79 :: 		}
	GOTO       L_main4
;main.c,80 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
