
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
	GOTO       L__initialize_alarms21
	MOVF       R1+0, 0
	SUBLW      30
L__initialize_alarms21:
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
L__update_alarm18:
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
;main.c,60 :: 		}
L_update_alarm5:
;main.c,61 :: 		}
L_end_update_alarm:
	RETURN
; end of _update_alarm

_activate_dispensers:

;main.c,63 :: 		void activate_dispensers(char dispenser_flags) {
;main.c,64 :: 		PORTB = dispenser_flags;
	MOVF       FARG_activate_dispensers_dispenser_flags+0, 0
	MOVWF      PORTB+0
;main.c,65 :: 		}
L_end_activate_dispensers:
	RETURN
; end of _activate_dispensers

_check_alarms:

;main.c,67 :: 		void check_alarms() {
;main.c,77 :: 		if (segundos == 0) {
	MOVF       check_alarms_segundos_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms6
;main.c,79 :: 		for (alarm_index = 0; alarm_index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); alarm_index++) {
	CLRF       check_alarms_alarm_index_L1+0
L_check_alarms7:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__check_alarms25
	MOVF       check_alarms_alarm_index_L1+0, 0
	SUBLW      30
L__check_alarms25:
	BTFSS      STATUS+0, 0
	GOTO       L_check_alarms8
;main.c,82 :: 		char current_alarm_hour = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
	MOVF       check_alarms_alarm_index_L1+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVLW      _alarms+0
	ADDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
;main.c,83 :: 		char current_alarm_minute = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      check_alarms_current_alarm_minute_L2+0
;main.c,86 :: 		if (current_alarm_hour == hours && current_alarm_minute == minutes) {
	MOVF       R1+0, 0
	XORWF      check_alarms_hours_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms12
	MOVF       check_alarms_current_alarm_minute_L2+0, 0
	XORWF      check_alarms_minutes_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms12
L__check_alarms19:
;main.c,88 :: 		char current_alarm_flags = alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET];
	MOVF       check_alarms_alarm_index_L1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
;main.c,90 :: 		current_alarm_flags = (current_alarm_flags >> 1) & 0x07;
	MOVF       R1+0, 0
	MOVWF      FARG_activate_dispensers_dispenser_flags+0
	RRF        FARG_activate_dispensers_dispenser_flags+0, 1
	BCF        FARG_activate_dispensers_dispenser_flags+0, 7
	MOVLW      7
	ANDWF      FARG_activate_dispensers_dispenser_flags+0, 1
;main.c,92 :: 		activate_dispensers(current_alarm_flags);
	CALL       _activate_dispensers+0
;main.c,93 :: 		}
L_check_alarms12:
;main.c,95 :: 		alarm_index += 3;
	MOVLW      3
	ADDWF      check_alarms_alarm_index_L1+0, 1
;main.c,79 :: 		for (alarm_index = 0; alarm_index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); alarm_index++) {
	INCF       check_alarms_alarm_index_L1+0, 1
;main.c,96 :: 		}
	GOTO       L_check_alarms7
L_check_alarms8:
;main.c,119 :: 		}
L_check_alarms6:
;main.c,120 :: 		}
L_end_check_alarms:
	RETURN
; end of _check_alarms

_main:

;main.c,122 :: 		void main() {
;main.c,125 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,126 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,129 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,130 :: 		UART1_Write_Text("Inicializado");
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,132 :: 		while (TRUE) {
L_main13:
;main.c,133 :: 		UART1_Write_Text("Main loop");
	MOVLW      ?lstr2_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,135 :: 		if (UART1_Data_Ready() == 1) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main15
;main.c,136 :: 		UART1_Read_Text(inputBuffer, ";", ALARM_PACKET_LENGTH + 1);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_UART1_Read_Text_Output+0
	MOVLW      ?lstr3_main+0
	MOVWF      FARG_UART1_Read_Text_Delimiter+0
	MOVLW      4
	MOVWF      FARG_UART1_Read_Text_Attempts+0
	CALL       _UART1_Read_Text+0
;main.c,137 :: 		}
L_main15:
;main.c,139 :: 		if (strlen(inputBuffer) == 3) {
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
	GOTO       L_main16
;main.c,140 :: 		update_alarm(inputBuffer);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_update_alarm_alarm_data+0
	CALL       _update_alarm+0
;main.c,141 :: 		}
L_main16:
;main.c,143 :: 		check_alarms();
	CALL       _check_alarms+0
;main.c,144 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main17:
	DECFSZ     R13+0, 1
	GOTO       L_main17
	DECFSZ     R12+0, 1
	GOTO       L_main17
	DECFSZ     R11+0, 1
	GOTO       L_main17
	NOP
	NOP
;main.c,147 :: 		fakeAlarm[0] = 0x5D; // 0101 1101
	MOVLW      93
	MOVWF      main_fakeAlarm_L0+0
;main.c,148 :: 		fakeAlarm[1] = 0x11;
	MOVLW      17
	MOVWF      main_fakeAlarm_L0+1
;main.c,149 :: 		fakeAlarm[2] = 0x35;
	MOVLW      53
	MOVWF      main_fakeAlarm_L0+2
;main.c,150 :: 		UART1_Write_Text("Enviando alarma");
	MOVLW      ?lstr4_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,151 :: 		update_alarm(fakeAlarm);
	MOVLW      main_fakeAlarm_L0+0
	MOVWF      FARG_update_alarm_alarm_data+0
	CALL       _update_alarm+0
;main.c,152 :: 		}
	GOTO       L_main13
;main.c,154 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
