
_initialize_alarms:

;main.c,27 :: 		void initialize_alarms() {
;main.c,30 :: 		for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
	CLRF       R1+0
L_initialize_alarms0:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initialize_alarms15
	MOVF       R1+0, 0
	SUBLW      30
L__initialize_alarms15:
	BTFSS      STATUS+0, 0
	GOTO       L_initialize_alarms1
;main.c,31 :: 		alarms[index] = 0;
	MOVF       R1+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	CLRF       INDF+0
;main.c,30 :: 		for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
	INCF       R1+0, 1
;main.c,32 :: 		}
	GOTO       L_initialize_alarms0
L_initialize_alarms1:
;main.c,33 :: 		}
L_end_initialize_alarms:
	RETURN
; end of _initialize_alarms

_update_alarm:

;main.c,35 :: 		void update_alarm(char alarm_data[ALARM_PACKET_LENGTH]) {
;main.c,37 :: 		char alarm_index = GET_ALARM_INDEX(alarm_data[0]);
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
	MOVLW      15
	ANDWF      R0+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      R5+0
;main.c,38 :: 		alarm_index = LESS_THAN_OR(alarm_index, 10, -1);
	MOVLW      10
	SUBWF      R1+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_update_alarm3
	MOVF       R5+0, 0
	MOVWF      R3+0
	GOTO       L_update_alarm4
L_update_alarm3:
	MOVLW      255
	MOVWF      R3+0
L_update_alarm4:
	MOVF       R3+0, 0
	MOVWF      R5+0
;main.c,40 :: 		if (alarm_index > 0) {
	MOVF       R3+0, 0
	SUBLW      0
	BTFSC      STATUS+0, 0
	GOTO       L_update_alarm5
;main.c,41 :: 		char offset = 0; //alarmIndex * FULL_PACKET_LENGTH;
;main.c,44 :: 		for (index = 0; index < ALARM_PACKET_LENGTH; index++) {
	CLRF       R4+0
L_update_alarm6:
	MOVLW      3
	SUBWF      R4+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_update_alarm7
;main.c,46 :: 		alarms[pepe + index] = alarm_data[index];
	MOVF       R4+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      R1+0
	MOVF       R4+0, 0
	ADDWF      FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,44 :: 		for (index = 0; index < ALARM_PACKET_LENGTH; index++) {
	INCF       R4+0, 1
;main.c,47 :: 		}
	GOTO       L_update_alarm6
L_update_alarm7:
;main.c,48 :: 		}
L_update_alarm5:
;main.c,50 :: 		}
L_end_update_alarm:
	RETURN
; end of _update_alarm

_main:

;main.c,52 :: 		void main() {
;main.c,54 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,58 :: 		while (TRUE) {
L_main9:
;main.c,59 :: 		if (UART1_Data_Ready() == 1) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;main.c,60 :: 		UART1_Read_Text(inputBuffer, ";", ALARM_PACKET_LENGTH + 1);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_UART1_Read_Text_Output+0
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_UART1_Read_Text_Delimiter+0
	MOVLW      4
	MOVWF      FARG_UART1_Read_Text_Attempts+0
	CALL       _UART1_Read_Text+0
;main.c,61 :: 		}
L_main11:
;main.c,63 :: 		if (strlen(inputBuffer) == 3) {
	MOVLW      _inputBuffer+0
	MOVWF      FARG_strlen_s+0
	CALL       _strlen+0
	MOVLW      0
	XORWF      R0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main18
	MOVLW      3
	XORWF      R0+0, 0
L__main18:
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;main.c,64 :: 		update_alarm(inputBuffer);
	MOVLW      _inputBuffer+0
	MOVWF      FARG_update_alarm_alarm_data+0
	CALL       _update_alarm+0
;main.c,65 :: 		}
L_main12:
;main.c,67 :: 		delay_ms(250);
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main13:
	DECFSZ     R13+0, 1
	GOTO       L_main13
	DECFSZ     R12+0, 1
	GOTO       L_main13
	DECFSZ     R11+0, 1
	GOTO       L_main13
	NOP
	NOP
;main.c,68 :: 		inputBuffer[0] = 1;
	MOVLW      1
	MOVWF      _inputBuffer+0
;main.c,69 :: 		alarms[0] = 1;
	MOVLW      1
	MOVWF      _alarms+0
;main.c,70 :: 		}
	GOTO       L_main9
;main.c,73 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
