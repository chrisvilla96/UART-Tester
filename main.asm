
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
	GOTO       L__initialize_alarms22
	MOVF       R1+0, 0
	SUBLW      30
L__initialize_alarms22:
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
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      update_alarm_alarm_index_L0+0
;main.c,49 :: 		if (0 <= alarm_index && alarm_index <= MAX_ALARMS) {
	MOVLW      0
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_update_alarm5
	MOVF       update_alarm_alarm_index_L0+0, 0
	SUBLW      10
	BTFSS      STATUS+0, 0
	GOTO       L_update_alarm5
L__update_alarm20:
;main.c,50 :: 		char offset = alarm_index * ALARM_PACKET_LENGTH;
	MOVF       update_alarm_alarm_index_L0+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      update_alarm_offset_L1+0
;main.c,53 :: 		alarms[offset + ALARM_FLAG_BYTE_OFFSET] = alarm_data[ALARM_FLAG_BYTE_OFFSET];
	MOVLW      0
	MOVWF      R0+1
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
;main.c,54 :: 		alarms[offset + ALARM_HOUR_BYTE_OFFSET] = Bcd2Dec(
	MOVF       update_alarm_offset_L1+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FLOC__update_alarm+0
;main.c,55 :: 		alarm_data[ALARM_HOUR_BYTE_OFFSET]
	INCF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
;main.c,56 :: 		);
	MOVF       FLOC__update_alarm+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,57 :: 		alarms[offset + ALARM_MINUTE_BYTE_OFFSET] = Bcd2Dec(
	MOVLW      2
	ADDWF      update_alarm_offset_L1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FLOC__update_alarm+0
;main.c,58 :: 		alarm_data[ALARM_MINUTE_BYTE_OFFSET]
	MOVLW      2
	ADDWF      FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
;main.c,59 :: 		);
	MOVF       FLOC__update_alarm+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,61 :: 		PORTB = 0xff;
	MOVLW      255
	MOVWF      PORTB+0
;main.c,62 :: 		delay_ms(75);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_update_alarm6:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm6
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm6
;main.c,64 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,65 :: 		delay_ms(75);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_update_alarm7:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm7
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm7
;main.c,67 :: 		PORTB = 0xff;
	MOVLW      255
	MOVWF      PORTB+0
;main.c,68 :: 		delay_ms(75);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_update_alarm8:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm8
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm8
;main.c,70 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,71 :: 		delay_ms(75);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_update_alarm9:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm9
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm9
;main.c,73 :: 		PORTB = 0xff;
	MOVLW      255
	MOVWF      PORTB+0
;main.c,74 :: 		delay_ms(75);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_update_alarm10:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm10
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm10
;main.c,76 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,77 :: 		delay_ms(75);
	MOVLW      195
	MOVWF      R12+0
	MOVLW      205
	MOVWF      R13+0
L_update_alarm11:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm11
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm11
;main.c,79 :: 		PORTB = alarm_data[ALARM_FLAG_BYTE_OFFSET];
	MOVF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;main.c,80 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_update_alarm12:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm12
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm12
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm12
	NOP
	NOP
;main.c,82 :: 		PORTB = alarm_data[ALARM_HOUR_BYTE_OFFSET];
	INCF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;main.c,83 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_update_alarm13:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm13
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm13
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm13
	NOP
	NOP
;main.c,85 :: 		PORTB = alarm_data[ALARM_MINUTE_BYTE_OFFSET];
	MOVLW      2
	ADDWF      FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTB+0
;main.c,86 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_update_alarm14:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm14
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm14
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm14
	NOP
	NOP
;main.c,87 :: 		}
L_update_alarm5:
;main.c,88 :: 		}
L_end_update_alarm:
	RETURN
; end of _update_alarm

_activate_dispensers:

;main.c,90 :: 		void activate_dispensers(char dispenser_flags) {
;main.c,91 :: 		PORTB = dispenser_flags;
	MOVF       FARG_activate_dispensers_dispenser_flags+0, 0
	MOVWF      PORTB+0
;main.c,92 :: 		}
L_end_activate_dispensers:
	RETURN
; end of _activate_dispensers

_check_alarms:

;main.c,94 :: 		void check_alarms() {
;main.c,158 :: 		}
L_end_check_alarms:
	RETURN
; end of _check_alarms

_main:

;main.c,160 :: 		void main() {
;main.c,163 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,164 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,167 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,168 :: 		UART1_Write_Text("Inicializado");
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,170 :: 		while (TRUE) {
L_main15:
;main.c,171 :: 		UART1_Write_Text("Main loop");
	MOVLW      ?lstr2_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,173 :: 		if (UART1_Data_Ready() == 1) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main17
;main.c,174 :: 		UART1_Read_Text(inputBuffer, ";", ALARM_PACKET_LENGTH + 1);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_UART1_Read_Text_Output+0
	MOVLW      ?lstr3_main+0
	MOVWF      FARG_UART1_Read_Text_Delimiter+0
	MOVLW      4
	MOVWF      FARG_UART1_Read_Text_Attempts+0
	CALL       _UART1_Read_Text+0
;main.c,175 :: 		}
L_main17:
;main.c,177 :: 		if (strlen(inputBuffer) == 3) {
	MOVLW      _inputBuffer+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main27
	MOVLW      3
	XORWF      R0+0, 0
L__main27:
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;main.c,178 :: 		update_alarm(inputBuffer);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_update_alarm_alarm_data+0
	CALL       _update_alarm+0
;main.c,179 :: 		}
L_main18:
;main.c,182 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main19:
	DECFSZ     R13+0, 1
	GOTO       L_main19
	DECFSZ     R12+0, 1
	GOTO       L_main19
	DECFSZ     R11+0, 1
	GOTO       L_main19
	NOP
	NOP
;main.c,183 :: 		}
	GOTO       L_main15
;main.c,184 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
