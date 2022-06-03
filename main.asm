
_writeBCDToLCD:

;main.c,39 :: 		void writeBCDToLCD(char ref) {
;main.c,40 :: 		Lcd_out(2, 1, "d                ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr1_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,41 :: 		Lcd_out(2, 1, "d ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr2_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,43 :: 		Lcd_chr_cp(((ref >> 4) & 0x0F) + 0x30);
	MOVF       FARG_writeBCDToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      15
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,45 :: 		Lcd_chr_cp((ref & 0x0F) + 0x30);
	MOVLW      15
	ANDWF      FARG_writeBCDToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,46 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_writeBCDToLCD0:
	DECFSZ     R13+0, 1
	GOTO       L_writeBCDToLCD0
	DECFSZ     R12+0, 1
	GOTO       L_writeBCDToLCD0
	DECFSZ     R11+0, 1
	GOTO       L_writeBCDToLCD0
	NOP
	NOP
;main.c,47 :: 		}
L_end_writeBCDToLCD:
	RETURN
; end of _writeBCDToLCD

_writeBytesToLCD:

;main.c,50 :: 		void writeBytesToLCD(char ref) {
;main.c,51 :: 		Lcd_out(2, 1, "b                ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr3_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,52 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,53 :: 		Lcd_out(2, 1, "b ");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr4_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,54 :: 		Lcd_chr_cp(((ref >> 7) & 0x01) + 0x30);
	MOVLW      7
	MOVWF      R0+0
	MOVF       FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVF       R0+0, 0
L__writeBytesToLCD34:
	BTFSC      STATUS+0, 2
	GOTO       L__writeBytesToLCD35
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__writeBytesToLCD34
L__writeBytesToLCD35:
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,55 :: 		Lcd_chr_cp(((ref >> 6) & 0x01) + 0x30);
	MOVLW      6
	MOVWF      R0+0
	MOVF       FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVF       R0+0, 0
L__writeBytesToLCD36:
	BTFSC      STATUS+0, 2
	GOTO       L__writeBytesToLCD37
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__writeBytesToLCD36
L__writeBytesToLCD37:
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,56 :: 		Lcd_chr_cp(((ref >> 5) & 0x01) + 0x30);
	MOVLW      5
	MOVWF      R0+0
	MOVF       FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVF       R0+0, 0
L__writeBytesToLCD38:
	BTFSC      STATUS+0, 2
	GOTO       L__writeBytesToLCD39
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__writeBytesToLCD38
L__writeBytesToLCD39:
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,57 :: 		Lcd_chr_cp(((ref >> 4) & 0x01) + 0x30);
	MOVF       FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,58 :: 		Lcd_chr_cp(((ref >> 3) & 0x01) + 0x30);
	MOVF       FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,59 :: 		Lcd_chr_cp(((ref >> 2) & 0x01) + 0x30);
	MOVF       FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,60 :: 		Lcd_chr_cp(((ref >> 1) & 0x01) + 0x30);
	MOVF       FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,61 :: 		Lcd_chr_cp(((ref >> 0) & 0x01) + 0x30);
	MOVLW      1
	ANDWF      FARG_writeBytesToLCD_ref+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,62 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_writeBytesToLCD1:
	DECFSZ     R13+0, 1
	GOTO       L_writeBytesToLCD1
	DECFSZ     R12+0, 1
	GOTO       L_writeBytesToLCD1
	DECFSZ     R11+0, 1
	GOTO       L_writeBytesToLCD1
	NOP
	NOP
;main.c,63 :: 		}
L_end_writeBytesToLCD:
	RETURN
; end of _writeBytesToLCD

_updateSentinel:

;main.c,67 :: 		void updateSentinel() {
;main.c,68 :: 		PORTB = ++sentinel;
	INCF       _sentinel+0, 1
	MOVF       _sentinel+0, 0
	MOVWF      PORTB+0
;main.c,69 :: 		}
L_end_updateSentinel:
	RETURN
; end of _updateSentinel

_init_led:

;main.c,71 :: 		void init_led() {
;main.c,73 :: 		for (i = 0; i < 2; i++)
	CLRF       R1+0
	CLRF       R1+1
L_init_led2:
	MOVLW      128
	XORWF      R1+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__init_led42
	MOVLW      2
	SUBWF      R1+0, 0
L__init_led42:
	BTFSC      STATUS+0, 0
	GOTO       L_init_led3
;main.c,75 :: 		STATUS = 1;
	BSF        PORTC+0, 2
;main.c,76 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_init_led5:
	DECFSZ     R13+0, 1
	GOTO       L_init_led5
	DECFSZ     R12+0, 1
	GOTO       L_init_led5
	DECFSZ     R11+0, 1
	GOTO       L_init_led5
	NOP
	NOP
;main.c,77 :: 		STATUS = 0;
	BCF        PORTC+0, 2
;main.c,78 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_init_led6:
	DECFSZ     R13+0, 1
	GOTO       L_init_led6
	DECFSZ     R12+0, 1
	GOTO       L_init_led6
	DECFSZ     R11+0, 1
	GOTO       L_init_led6
	NOP
	NOP
;main.c,73 :: 		for (i = 0; i < 2; i++)
	INCF       R1+0, 1
	BTFSC      STATUS+0, 2
	INCF       R1+1, 1
;main.c,79 :: 		}
	GOTO       L_init_led2
L_init_led3:
;main.c,80 :: 		}
L_end_init_led:
	RETURN
; end of _init_led

_initialize_alarms:

;main.c,84 :: 		void initialize_alarms() {
;main.c,87 :: 		for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
	CLRF       R1+0
L_initialize_alarms7:
	MOVLW      128
	XORLW      0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__initialize_alarms44
	MOVF       R1+0, 0
	SUBLW      30
L__initialize_alarms44:
	BTFSS      STATUS+0, 0
	GOTO       L_initialize_alarms8
;main.c,88 :: 		alarms[index] = 0;
	MOVF       R1+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	CLRF       INDF+0
;main.c,87 :: 		for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
	INCF       R1+0, 1
;main.c,89 :: 		}
	GOTO       L_initialize_alarms7
L_initialize_alarms8:
;main.c,90 :: 		}
L_end_initialize_alarms:
	RETURN
; end of _initialize_alarms

_update_alarm:

;main.c,94 :: 		void update_alarm(char alarm[ALARM_PACKET_LENGTH])
;main.c,103 :: 		alarm_flags = alarm[0];
	MOVF       FARG_update_alarm_alarm+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      update_alarm_alarm_flags_L0+0
;main.c,104 :: 		alarm_hour = alarm[1];
	INCF       FARG_update_alarm_alarm+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      update_alarm_alarm_hour_L0+0
;main.c,105 :: 		alarm_minute = alarm[2];
	MOVLW      2
	ADDWF      FARG_update_alarm_alarm+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      update_alarm_alarm_minute_L0+0
;main.c,110 :: 		writeBCDToLCD(alarm_flags);
	MOVF       R0+0, 0
	MOVWF      FARG_writeBCDToLCD_ref+0
	CALL       _writeBCDToLCD+0
;main.c,111 :: 		writeBytesToLCD(alarm_flags);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,113 :: 		writeBCDToLCD(alarm_hour);
	MOVF       update_alarm_alarm_hour_L0+0, 0
	MOVWF      FARG_writeBCDToLCD_ref+0
	CALL       _writeBCDToLCD+0
;main.c,114 :: 		writeBytesToLCD(alarm_hour);
	MOVF       update_alarm_alarm_hour_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,115 :: 		writeBCDToLCD(alarm_minute);
	MOVF       update_alarm_alarm_minute_L0+0, 0
	MOVWF      FARG_writeBCDToLCD_ref+0
	CALL       _writeBCDToLCD+0
;main.c,116 :: 		writeBytesToLCD(alarm_minute);
	MOVF       update_alarm_alarm_minute_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,120 :: 		writeBCDToLCD(alarm_flags);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBCDToLCD_ref+0
	CALL       _writeBCDToLCD+0
;main.c,121 :: 		writeBytesToLCD(alarm_flags);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,123 :: 		writeBytesToLCD(alarm_flags >> 0);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,124 :: 		writeBytesToLCD(alarm_flags >> 1);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	CALL       _writeBytesToLCD+0
;main.c,125 :: 		writeBytesToLCD(alarm_flags >> 2);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	CALL       _writeBytesToLCD+0
;main.c,126 :: 		writeBytesToLCD(alarm_flags >> 3);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	CALL       _writeBytesToLCD+0
;main.c,127 :: 		writeBytesToLCD(alarm_flags >> 4);
	MOVF       update_alarm_alarm_flags_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	RRF        FARG_writeBytesToLCD_ref+0, 1
	BCF        FARG_writeBytesToLCD_ref+0, 7
	CALL       _writeBytesToLCD+0
;main.c,161 :: 		}
L_end_update_alarm:
	RETURN
; end of _update_alarm

_activate_dispensers:

;main.c,164 :: 		void activate_dispensers(char dispenser_flags) {
;main.c,165 :: 		PORTB = dispenser_flags;
	MOVF       FARG_activate_dispensers_dispenser_flags+0, 0
	MOVWF      PORTB+0
;main.c,166 :: 		PORTB = 0x0F;
	MOVLW      15
	MOVWF      PORTB+0
;main.c,167 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_activate_dispensers10:
	DECFSZ     R13+0, 1
	GOTO       L_activate_dispensers10
	DECFSZ     R12+0, 1
	GOTO       L_activate_dispensers10
	DECFSZ     R11+0, 1
	GOTO       L_activate_dispensers10
	NOP
	NOP
;main.c,168 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,169 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_activate_dispensers11:
	DECFSZ     R13+0, 1
	GOTO       L_activate_dispensers11
	DECFSZ     R12+0, 1
	GOTO       L_activate_dispensers11
	DECFSZ     R11+0, 1
	GOTO       L_activate_dispensers11
	NOP
	NOP
;main.c,170 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_activate_dispensers12:
	DECFSZ     R13+0, 1
	GOTO       L_activate_dispensers12
	DECFSZ     R12+0, 1
	GOTO       L_activate_dispensers12
	DECFSZ     R11+0, 1
	GOTO       L_activate_dispensers12
	NOP
	NOP
;main.c,171 :: 		}
L_end_activate_dispensers:
	RETURN
; end of _activate_dispensers

_check_alarms:

;main.c,173 :: 		void check_alarms() {
;main.c,179 :: 		seconds = read_ds1307(0xD0, 0);  // reads seconds from DS1307 in BCD
	MOVLW      208
	MOVWF      FARG_read_ds1307_direccion_esclavo+0
	CLRF       FARG_read_ds1307_direccion_memoria+0
	CALL       _read_ds1307+0
	MOVF       R0+0, 0
	MOVWF      check_alarms_seconds_L0+0
;main.c,180 :: 		minutes = read_ds1307(0xD0, 1);  // reads minutes from DS1307 in BCD
	MOVLW      208
	MOVWF      FARG_read_ds1307_direccion_esclavo+0
	MOVLW      1
	MOVWF      FARG_read_ds1307_direccion_memoria+0
	CALL       _read_ds1307+0
	MOVF       R0+0, 0
	MOVWF      check_alarms_minutes_L0+0
;main.c,181 :: 		hours = read_ds1307(0xD0, 2);    // reads hours from DS1307 in BCD
	MOVLW      208
	MOVWF      FARG_read_ds1307_direccion_esclavo+0
	MOVLW      2
	MOVWF      FARG_read_ds1307_direccion_memoria+0
	CALL       _read_ds1307+0
	MOVF       R0+0, 0
	MOVWF      check_alarms_hours_L0+0
;main.c,183 :: 		if (seconds == 0x00) {
	MOVF       check_alarms_seconds_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms13
;main.c,185 :: 		for (alarm_index = 0; alarm_index <= MAX_ALARMS; alarm_index++) {
	CLRF       check_alarms_alarm_index_L0+0
L_check_alarms14:
	MOVF       check_alarms_alarm_index_L0+0, 0
	SUBLW      10
	BTFSS      STATUS+0, 0
	GOTO       L_check_alarms15
;main.c,191 :: 		char current_alarm_flags = alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET];
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      check_alarms_current_alarm_flags_L2+0
;main.c,193 :: 		writeBytesToLCD(current_alarm_flags);
	MOVF       R0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,194 :: 		writeBCDToLCD(current_alarm_flags);
	MOVF       check_alarms_current_alarm_flags_L2+0, 0
	MOVWF      FARG_writeBCDToLCD_ref+0
	CALL       _writeBCDToLCD+0
;main.c,196 :: 		if (!(alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] & ALARM_FLAG_BYTE_OFFSET)) {
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVLW      0
	ANDWF      INDF+0, 0
	MOVWF      R0+0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms17
;main.c,197 :: 		continue;
	GOTO       L_check_alarms16
;main.c,198 :: 		}
L_check_alarms17:
;main.c,201 :: 		current_alarm_hour = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
	MOVF       check_alarms_alarm_index_L0+0, 0
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
;main.c,202 :: 		current_alarm_minute = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      check_alarms_current_alarm_minute_L2+0
;main.c,205 :: 		if (current_alarm_hour == hours && current_alarm_minute == minutes) {
	MOVF       R1+0, 0
	XORWF      check_alarms_hours_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms20
	MOVF       check_alarms_current_alarm_minute_L2+0, 0
	XORWF      check_alarms_minutes_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms20
L__check_alarms31:
;main.c,209 :: 		current_alarm_flags = (current_alarm_flags >> 1) & 0x07;
	MOVF       check_alarms_current_alarm_flags_L2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      7
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	MOVWF      check_alarms_current_alarm_flags_L2+0
;main.c,212 :: 		activate_dispensers(current_alarm_flags);
	MOVF       R0+0, 0
	MOVWF      FARG_activate_dispensers_dispenser_flags+0
	CALL       _activate_dispensers+0
;main.c,213 :: 		}
L_check_alarms20:
;main.c,214 :: 		}
L_check_alarms16:
;main.c,185 :: 		for (alarm_index = 0; alarm_index <= MAX_ALARMS; alarm_index++) {
	INCF       check_alarms_alarm_index_L0+0, 1
;main.c,214 :: 		}
	GOTO       L_check_alarms14
L_check_alarms15:
;main.c,215 :: 		}
L_check_alarms13:
;main.c,216 :: 		}
L_end_check_alarms:
	RETURN
; end of _check_alarms

_check_ds1307:

;main.c,218 :: 		void check_ds1307() {
;main.c,221 :: 		while (TRUE) {
L_check_ds130721:
;main.c,222 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,223 :: 		seconds = RTC_Read_Clock_Seconds();
	CALL       _RTC_Read_Clock_Seconds+0
;main.c,224 :: 		PORTB = seconds; // 0011 0101
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;main.c,225 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_check_ds130723:
	DECFSZ     R13+0, 1
	GOTO       L_check_ds130723
	DECFSZ     R12+0, 1
	GOTO       L_check_ds130723
	DECFSZ     R11+0, 1
	GOTO       L_check_ds130723
	NOP
	NOP
;main.c,226 :: 		}
	GOTO       L_check_ds130721
;main.c,249 :: 		}
L_end_check_ds1307:
	RETURN
; end of _check_ds1307

_sends_data_to_lcd:

;main.c,252 :: 		void sends_data_to_lcd(char second, char minute, char hour) {
;main.c,264 :: 		Lcd_out(1, 1, "HORA: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,265 :: 		Lcd_chr_cp(Bcd2Dec(hour)/10 + 0x30);
	MOVF       FARG_sends_data_to_lcd_hour+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,266 :: 		Lcd_chr_cp(Bcd2Dec(hour)%10 + 0x30);
	MOVF       FARG_sends_data_to_lcd_hour+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,267 :: 		Lcd_chr_cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,268 :: 		Lcd_chr_cp(Bcd2Dec(minute) / 10 + 0x30);
	MOVF       FARG_sends_data_to_lcd_minute+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,269 :: 		Lcd_chr_cp(Bcd2Dec(minute) % 10 + 0x30);
	MOVF       FARG_sends_data_to_lcd_minute+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,270 :: 		Lcd_chr_cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,271 :: 		Lcd_chr_cp(Bcd2Dec(second) / 10 + 0x30);
	MOVF       FARG_sends_data_to_lcd_second+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,272 :: 		Lcd_chr_cp(Bcd2Dec(second) % 10 + 0x30);
	MOVF       FARG_sends_data_to_lcd_second+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,273 :: 		}
L_end_sends_data_to_lcd:
	RETURN
; end of _sends_data_to_lcd

_main:

;main.c,283 :: 		void main() {
;main.c,285 :: 		char loopIndex = 0;
;main.c,287 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,288 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,291 :: 		TRISC.RC2 = 0;
	BCF        TRISC+0, 2
;main.c,292 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;main.c,293 :: 		initialize_alarms();
	CALL       _initialize_alarms+0
;main.c,296 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,298 :: 		UART1_Write_Text("Inicializado\n");
	MOVLW      ?lstr6_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,300 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main24:
	DECFSZ     R13+0, 1
	GOTO       L_main24
	DECFSZ     R12+0, 1
	GOTO       L_main24
	DECFSZ     R11+0, 1
	GOTO       L_main24
	NOP
;main.c,303 :: 		Lcd_init();
	CALL       _Lcd_Init+0
;main.c,304 :: 		Lcd_cmd(12);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,305 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main25:
	DECFSZ     R13+0, 1
	GOTO       L_main25
	DECFSZ     R12+0, 1
	GOTO       L_main25
	DECFSZ     R11+0, 1
	GOTO       L_main25
	NOP
;main.c,306 :: 		Lcd_Cmd(_LCD_CLEAR); // Clears Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,309 :: 		I2C1_Init(100000);
	MOVLW      20
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;main.c,310 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main26:
	DECFSZ     R13+0, 1
	GOTO       L_main26
	DECFSZ     R12+0, 1
	GOTO       L_main26
	DECFSZ     R11+0, 1
	GOTO       L_main26
	NOP
;main.c,314 :: 		UART1_Write_Text("ANTES DE SET DATA\n");
	MOVLW      ?lstr7_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,319 :: 		set_data_ds1307(45, 34, 11, 1, 1, 1, 18);
	MOVLW      45
	MOVWF      FARG_set_data_ds1307_second+0
	MOVLW      0
	MOVWF      FARG_set_data_ds1307_second+1
	MOVLW      34
	MOVWF      FARG_set_data_ds1307_minute+0
	MOVLW      0
	MOVWF      FARG_set_data_ds1307_minute+1
	MOVLW      11
	MOVWF      FARG_set_data_ds1307_hour+0
	MOVLW      0
	MOVWF      FARG_set_data_ds1307_hour+1
	MOVLW      1
	MOVWF      FARG_set_data_ds1307_day+0
	MOVLW      0
	MOVWF      FARG_set_data_ds1307_day+1
	MOVLW      1
	MOVWF      FARG_set_data_ds1307_week_day+0
	MOVLW      0
	MOVWF      FARG_set_data_ds1307_week_day+1
	MOVLW      1
	MOVWF      FARG_set_data_ds1307_month+0
	MOVLW      0
	MOVWF      FARG_set_data_ds1307_month+1
	MOVLW      18
	MOVWF      FARG_set_data_ds1307_year+0
	MOVLW      0
	MOVWF      FARG_set_data_ds1307_year+1
	CALL       _set_data_ds1307+0
;main.c,322 :: 		UART1_Write_Text("Despues DE SET DATA\n");
	MOVLW      ?lstr8_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,328 :: 		fakeAlarm[0] = 0x5D; // 0101 1101
	MOVLW      93
	MOVWF      main_fakeAlarm_L0+0
;main.c,329 :: 		fakeAlarm[1] = 0x11;
	MOVLW      17
	MOVWF      main_fakeAlarm_L0+1
;main.c,330 :: 		fakeAlarm[2] = 0x35;
	MOVLW      53
	MOVWF      main_fakeAlarm_L0+2
;main.c,332 :: 		writeBCDToLCD(fakeAlarm[0]);
	MOVF       main_fakeAlarm_L0+0, 0
	MOVWF      FARG_writeBCDToLCD_ref+0
	CALL       _writeBCDToLCD+0
;main.c,333 :: 		writeBytesToLCD(fakeAlarm[0]);
	MOVF       main_fakeAlarm_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,336 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main27:
	DECFSZ     R13+0, 1
	GOTO       L_main27
	DECFSZ     R12+0, 1
	GOTO       L_main27
	DECFSZ     R11+0, 1
	GOTO       L_main27
	NOP
	NOP
;main.c,337 :: 		UART1_Write_Text("Enviando alarma");
	MOVLW      ?lstr9_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,339 :: 		update_alarm(fakeAlarm);
	MOVLW      main_fakeAlarm_L0+0
	MOVWF      FARG_update_alarm_alarm+0
	CALL       _update_alarm+0
;main.c,347 :: 		while (TRUE)
L_main28:
;main.c,371 :: 		check_alarms();
	CALL       _check_alarms+0
;main.c,372 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main30:
	DECFSZ     R13+0, 1
	GOTO       L_main30
	DECFSZ     R12+0, 1
	GOTO       L_main30
	DECFSZ     R11+0, 1
	GOTO       L_main30
	NOP
	NOP
;main.c,373 :: 		}
	GOTO       L_main28
;main.c,375 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
