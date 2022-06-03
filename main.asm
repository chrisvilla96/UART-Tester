
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
L__writeBytesToLCD44:
	BTFSC      STATUS+0, 2
	GOTO       L__writeBytesToLCD45
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__writeBytesToLCD44
L__writeBytesToLCD45:
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
L__writeBytesToLCD46:
	BTFSC      STATUS+0, 2
	GOTO       L__writeBytesToLCD47
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__writeBytesToLCD46
L__writeBytesToLCD47:
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
L__writeBytesToLCD48:
	BTFSC      STATUS+0, 2
	GOTO       L__writeBytesToLCD49
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__writeBytesToLCD48
L__writeBytesToLCD49:
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
	GOTO       L__init_led52
	MOVLW      2
	SUBWF      R1+0, 0
L__init_led52:
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
	GOTO       L__initialize_alarms54
	MOVF       R1+0, 0
	SUBLW      30
L__initialize_alarms54:
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

;main.c,94 :: 		void update_alarm(char alarm_data[ALARM_PACKET_LENGTH]) {
;main.c,96 :: 		char alarm_index = GET_ALARM_INDEX(alarm_data[0]);
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
;main.c,98 :: 		if (0 <= alarm_index && alarm_index <= MAX_ALARMS) {
	MOVLW      0
	SUBWF      R1+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_update_alarm12
	MOVF       update_alarm_alarm_index_L0+0, 0
	SUBLW      10
	BTFSS      STATUS+0, 0
	GOTO       L_update_alarm12
L__update_alarm40:
;main.c,99 :: 		char offset = alarm_index * ALARM_PACKET_LENGTH;
	MOVF       update_alarm_alarm_index_L0+0, 0
	MOVWF      R0+0
	MOVLW      3
	MOVWF      R4+0
	CALL       _Mul_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      update_alarm_offset_L1+0
;main.c,101 :: 		alarms[offset + ALARM_FLAG_BYTE_OFFSET] = alarm_data[ALARM_FLAG_BYTE_OFFSET];
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
;main.c,102 :: 		alarms[offset + ALARM_HOUR_BYTE_OFFSET] = alarm_data[ALARM_HOUR_BYTE_OFFSET];
	MOVF       update_alarm_offset_L1+0, 0
	ADDLW      1
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      R1+0
	INCF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,103 :: 		alarms[offset + ALARM_MINUTE_BYTE_OFFSET] = alarm_data[ALARM_MINUTE_BYTE_OFFSET];
	MOVLW      2
	ADDWF      update_alarm_offset_L1+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	BTFSC      STATUS+0, 0
	INCF       R0+1, 1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      R1+0
	MOVLW      2
	ADDWF      FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FSR
	MOVF       R0+0, 0
	MOVWF      INDF+0
;main.c,114 :: 		Lcd_out(2, 1, "SA_");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr5_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,115 :: 		Lcd_chr_cp(Bcd2Dec(alarm_data[0]) / 10 + 0x30);
	MOVF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,116 :: 		Lcd_chr_cp(Bcd2Dec(alarm_data[0]) % 10 + 0x30);
	MOVF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
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
;main.c,117 :: 		Lcd_chr_cp(Bcd2Dec(alarm_data[1]) / 10 + 0x30);
	INCF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,118 :: 		Lcd_chr_cp(Bcd2Dec(alarm_data[1]) % 10 + 0x30);
	INCF       FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
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
;main.c,119 :: 		Lcd_chr_cp(Bcd2Dec(alarm_data[2]) / 10 + 0x30);
	MOVLW      2
	ADDWF      FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,120 :: 		Lcd_chr_cp(Bcd2Dec(alarm_data[2]) % 10 + 0x30);
	MOVLW      2
	ADDWF      FARG_update_alarm_alarm_data+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
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
;main.c,121 :: 		Lcd_chr_cp('|');
	MOVLW      124
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,122 :: 		delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_update_alarm13:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm13
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm13
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm13
	NOP
;main.c,123 :: 		}
L_update_alarm12:
;main.c,128 :: 		PORTB = 0x0F;
	MOVLW      15
	MOVWF      PORTB+0
;main.c,129 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
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
;main.c,130 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,131 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_update_alarm15:
	DECFSZ     R13+0, 1
	GOTO       L_update_alarm15
	DECFSZ     R12+0, 1
	GOTO       L_update_alarm15
	DECFSZ     R11+0, 1
	GOTO       L_update_alarm15
	NOP
	NOP
;main.c,132 :: 		}
L_end_update_alarm:
	RETURN
; end of _update_alarm

_activate_dispensers:

;main.c,135 :: 		void activate_dispensers(char dispenser_flags) {
;main.c,136 :: 		PORTB = dispenser_flags;
	MOVF       FARG_activate_dispensers_dispenser_flags+0, 0
	MOVWF      PORTB+0
;main.c,137 :: 		PORTB = 0x0F;
	MOVLW      15
	MOVWF      PORTB+0
;main.c,138 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_activate_dispensers16:
	DECFSZ     R13+0, 1
	GOTO       L_activate_dispensers16
	DECFSZ     R12+0, 1
	GOTO       L_activate_dispensers16
	DECFSZ     R11+0, 1
	GOTO       L_activate_dispensers16
	NOP
	NOP
;main.c,139 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,140 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_activate_dispensers17:
	DECFSZ     R13+0, 1
	GOTO       L_activate_dispensers17
	DECFSZ     R12+0, 1
	GOTO       L_activate_dispensers17
	DECFSZ     R11+0, 1
	GOTO       L_activate_dispensers17
	NOP
	NOP
;main.c,141 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_activate_dispensers18:
	DECFSZ     R13+0, 1
	GOTO       L_activate_dispensers18
	DECFSZ     R12+0, 1
	GOTO       L_activate_dispensers18
	DECFSZ     R11+0, 1
	GOTO       L_activate_dispensers18
	NOP
	NOP
;main.c,142 :: 		}
L_end_activate_dispensers:
	RETURN
; end of _activate_dispensers

_check_alarms:

;main.c,144 :: 		void check_alarms() {
;main.c,150 :: 		seconds = read_ds1307(0xD0, 0);  // reads seconds from DS1307 in BCD
	MOVLW      208
	MOVWF      FARG_read_ds1307_direccion_esclavo+0
	CLRF       FARG_read_ds1307_direccion_memoria+0
	CALL       _read_ds1307+0
	MOVF       R0+0, 0
	MOVWF      check_alarms_seconds_L0+0
;main.c,151 :: 		minutes = read_ds1307(0xD0, 1);  // reads minutes from DS1307 in BCD
	MOVLW      208
	MOVWF      FARG_read_ds1307_direccion_esclavo+0
	MOVLW      1
	MOVWF      FARG_read_ds1307_direccion_memoria+0
	CALL       _read_ds1307+0
	MOVF       R0+0, 0
	MOVWF      check_alarms_minutes_L0+0
;main.c,152 :: 		hours = read_ds1307(0xD0, 2);    // reads hours from DS1307 in BCD
	MOVLW      208
	MOVWF      FARG_read_ds1307_direccion_esclavo+0
	MOVLW      2
	MOVWF      FARG_read_ds1307_direccion_memoria+0
	CALL       _read_ds1307+0
	MOVF       R0+0, 0
	MOVWF      check_alarms_hours_L0+0
;main.c,154 :: 		if (seconds == 0x00) {
	MOVF       check_alarms_seconds_L0+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms19
;main.c,155 :: 		Lcd_out(2, 1, "Estamos en 0 segundos");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr6_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,157 :: 		for (alarm_index = 0; alarm_index <= MAX_ALARMS; alarm_index++) {
	CLRF       check_alarms_alarm_index_L0+0
L_check_alarms20:
	MOVF       check_alarms_alarm_index_L0+0, 0
	SUBLW      10
	BTFSS      STATUS+0, 0
	GOTO       L_check_alarms21
;main.c,162 :: 		Lcd_out(2, 1, "CA");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr7_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,163 :: 		Lcd_chr_cp(alarm_index + 0x30);
	MOVLW      48
	ADDWF      check_alarms_alarm_index_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,164 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 7) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVLW      7
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVF       R0+0, 0
L__check_alarms58:
	BTFSC      STATUS+0, 2
	GOTO       L__check_alarms59
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__check_alarms58
L__check_alarms59:
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,165 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 6) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVLW      6
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVF       R0+0, 0
L__check_alarms60:
	BTFSC      STATUS+0, 2
	GOTO       L__check_alarms61
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__check_alarms60
L__check_alarms61:
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,166 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 5) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVLW      5
	MOVWF      R0+0
	MOVF       R1+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVF       R0+0, 0
L__check_alarms62:
	BTFSC      STATUS+0, 2
	GOTO       L__check_alarms63
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	ADDLW      255
	GOTO       L__check_alarms62
L__check_alarms63:
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,167 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 4) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
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
;main.c,168 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 3) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
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
;main.c,169 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 2) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
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
;main.c,170 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 1) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	RRF        FARG_Lcd_Chr_CP_out_char+0, 1
	BCF        FARG_Lcd_Chr_CP_out_char+0, 7
	MOVLW      1
	ANDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,171 :: 		Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 0) & 0x01) + 0x30);
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVLW      1
	ANDWF      INDF+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	MOVLW      48
	ADDWF      FARG_Lcd_Chr_CP_out_char+0, 1
	CALL       _Lcd_Chr_CP+0
;main.c,172 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_check_alarms23:
	DECFSZ     R13+0, 1
	GOTO       L_check_alarms23
	DECFSZ     R12+0, 1
	GOTO       L_check_alarms23
	DECFSZ     R11+0, 1
	GOTO       L_check_alarms23
	NOP
	NOP
;main.c,174 :: 		if (!(alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] & ALARM_FLAG_BYTE_OFFSET)) {
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
	GOTO       L_check_alarms24
;main.c,175 :: 		continue;
	GOTO       L_check_alarms22
;main.c,176 :: 		}
L_check_alarms24:
;main.c,178 :: 		Lcd_out(2, 1, "alrm actv");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr8_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,179 :: 		Lcd_chr_cp(alarm_index + 0x30);
	MOVLW      48
	ADDWF      check_alarms_alarm_index_L0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,180 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_check_alarms25:
	DECFSZ     R13+0, 1
	GOTO       L_check_alarms25
	DECFSZ     R12+0, 1
	GOTO       L_check_alarms25
	DECFSZ     R11+0, 1
	GOTO       L_check_alarms25
	NOP
	NOP
;main.c,183 :: 		current_alarm_hour = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
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
	MOVWF      check_alarms_current_alarm_hour_L2+0
;main.c,184 :: 		current_alarm_minute = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
	MOVF       R0+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      check_alarms_current_alarm_minute_L2+0
;main.c,186 :: 		Lcd_out(2, 1, "t:");
	MOVLW      2
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr9_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,187 :: 		Lcd_chr_cp(Bcd2Dec(current_alarm_hour) / 10 + 0x30);
	MOVF       check_alarms_current_alarm_hour_L2+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,188 :: 		Lcd_chr_cp(Bcd2Dec(current_alarm_minute) % 10 + 0x30);
	MOVF       check_alarms_current_alarm_minute_L2+0, 0
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
;main.c,189 :: 		Lcd_chr_cp(Bcd2Dec(current_alarm_minute) / 10 + 0x30);
	MOVF       check_alarms_current_alarm_minute_L2+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,190 :: 		Lcd_chr_cp(Bcd2Dec(current_alarm_minute) % 10 + 0x30);
	MOVF       check_alarms_current_alarm_minute_L2+0, 0
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
;main.c,191 :: 		Lcd_chr_cp(',');
	MOVLW      44
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,192 :: 		Lcd_chr_cp(Bcd2Dec(hours) / 10 + 0x30);
	MOVF       check_alarms_hours_L0+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,193 :: 		Lcd_chr_cp(Bcd2Dec(hours) % 10 + 0x30);
	MOVF       check_alarms_hours_L0+0, 0
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
;main.c,194 :: 		Lcd_chr_cp(Bcd2Dec(minutes) / 10 + 0x30);
	MOVF       check_alarms_minutes_L0+0, 0
	MOVWF      FARG_Bcd2Dec_bcdnum+0
	CALL       _Bcd2Dec+0
	MOVLW      10
	MOVWF      R4+0
	CALL       _Div_8X8_U+0
	MOVLW      48
	ADDWF      R0+0, 0
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,195 :: 		Lcd_chr_cp(Bcd2Dec(minutes) % 10 + 0x30);
	MOVF       check_alarms_minutes_L0+0, 0
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
;main.c,196 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_check_alarms26:
	DECFSZ     R13+0, 1
	GOTO       L_check_alarms26
	DECFSZ     R12+0, 1
	GOTO       L_check_alarms26
	DECFSZ     R11+0, 1
	GOTO       L_check_alarms26
	NOP
	NOP
;main.c,199 :: 		if (current_alarm_hour == hours && current_alarm_minute == minutes) {
	MOVF       check_alarms_current_alarm_hour_L2+0, 0
	XORWF      check_alarms_hours_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms29
	MOVF       check_alarms_current_alarm_minute_L2+0, 0
	XORWF      check_alarms_minutes_L0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L_check_alarms29
L__check_alarms41:
;main.c,201 :: 		char current_alarm_flags = alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET];
	MOVF       check_alarms_alarm_index_L0+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	MOVF       R0+0, 0
	ADDLW      _alarms+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      R1+0
;main.c,203 :: 		current_alarm_flags = (current_alarm_flags >> 1) & 0x07;
	MOVF       R1+0, 0
	MOVWF      FARG_activate_dispensers_dispenser_flags+0
	RRF        FARG_activate_dispensers_dispenser_flags+0, 1
	BCF        FARG_activate_dispensers_dispenser_flags+0, 7
	MOVLW      7
	ANDWF      FARG_activate_dispensers_dispenser_flags+0, 1
;main.c,206 :: 		activate_dispensers(current_alarm_flags);
	CALL       _activate_dispensers+0
;main.c,207 :: 		}
L_check_alarms29:
;main.c,208 :: 		}
L_check_alarms22:
;main.c,157 :: 		for (alarm_index = 0; alarm_index <= MAX_ALARMS; alarm_index++) {
	INCF       check_alarms_alarm_index_L0+0, 1
;main.c,208 :: 		}
	GOTO       L_check_alarms20
L_check_alarms21:
;main.c,209 :: 		}
L_check_alarms19:
;main.c,210 :: 		}
L_end_check_alarms:
	RETURN
; end of _check_alarms

_check_ds1307:

;main.c,212 :: 		void check_ds1307() {
;main.c,215 :: 		while (TRUE) {
L_check_ds130730:
;main.c,216 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,217 :: 		seconds = RTC_Read_Clock_Seconds();
	CALL       _RTC_Read_Clock_Seconds+0
;main.c,218 :: 		PORTB = seconds; // 0011 0101
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;main.c,219 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_check_ds130732:
	DECFSZ     R13+0, 1
	GOTO       L_check_ds130732
	DECFSZ     R12+0, 1
	GOTO       L_check_ds130732
	DECFSZ     R11+0, 1
	GOTO       L_check_ds130732
	NOP
	NOP
;main.c,220 :: 		}
	GOTO       L_check_ds130730
;main.c,243 :: 		}
L_end_check_ds1307:
	RETURN
; end of _check_ds1307

_sends_data_to_lcd:

;main.c,246 :: 		void sends_data_to_lcd(char second, char minute, char hour) {
;main.c,258 :: 		Lcd_out(1, 1, "HORA: ");
	MOVLW      1
	MOVWF      FARG_Lcd_Out_row+0
	MOVLW      1
	MOVWF      FARG_Lcd_Out_column+0
	MOVLW      ?lstr10_main+0
	MOVWF      FARG_Lcd_Out_text+0
	CALL       _Lcd_Out+0
;main.c,259 :: 		Lcd_chr_cp(Bcd2Dec(hour)/10 + 0x30);
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
;main.c,260 :: 		Lcd_chr_cp(Bcd2Dec(hour)%10 + 0x30);
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
;main.c,261 :: 		Lcd_chr_cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,262 :: 		Lcd_chr_cp(Bcd2Dec(minute) / 10 + 0x30);
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
;main.c,263 :: 		Lcd_chr_cp(Bcd2Dec(minute) % 10 + 0x30);
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
;main.c,264 :: 		Lcd_chr_cp(':');
	MOVLW      58
	MOVWF      FARG_Lcd_Chr_CP_out_char+0
	CALL       _Lcd_Chr_CP+0
;main.c,265 :: 		Lcd_chr_cp(Bcd2Dec(second) / 10 + 0x30);
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
;main.c,266 :: 		Lcd_chr_cp(Bcd2Dec(second) % 10 + 0x30);
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
;main.c,267 :: 		}
L_end_sends_data_to_lcd:
	RETURN
; end of _sends_data_to_lcd

_main:

;main.c,277 :: 		void main() {
;main.c,279 :: 		char loopIndex = 0;
;main.c,281 :: 		TRISB = 0;
	CLRF       TRISB+0
;main.c,282 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;main.c,285 :: 		TRISC.RC2 = 0;
	BCF        TRISC+0, 2
;main.c,286 :: 		PORTC.RC2 = 0;
	BCF        PORTC+0, 2
;main.c,287 :: 		initialize_alarms();
	CALL       _initialize_alarms+0
;main.c,290 :: 		UART1_Init(9600);
	MOVLW      51
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;main.c,292 :: 		UART1_Write_Text("Inicializado\n");
	MOVLW      ?lstr11_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,294 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main33:
	DECFSZ     R13+0, 1
	GOTO       L_main33
	DECFSZ     R12+0, 1
	GOTO       L_main33
	DECFSZ     R11+0, 1
	GOTO       L_main33
	NOP
;main.c,297 :: 		Lcd_init();
	CALL       _Lcd_Init+0
;main.c,298 :: 		Lcd_cmd(12);
	MOVLW      12
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,299 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main34:
	DECFSZ     R13+0, 1
	GOTO       L_main34
	DECFSZ     R12+0, 1
	GOTO       L_main34
	DECFSZ     R11+0, 1
	GOTO       L_main34
	NOP
;main.c,300 :: 		Lcd_Cmd(_LCD_CLEAR); // Clears Display
	MOVLW      1
	MOVWF      FARG_Lcd_Cmd_out_char+0
	CALL       _Lcd_Cmd+0
;main.c,303 :: 		I2C1_Init(100000);
	MOVLW      20
	MOVWF      SSPADD+0
	CALL       _I2C1_Init+0
;main.c,304 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main35:
	DECFSZ     R13+0, 1
	GOTO       L_main35
	DECFSZ     R12+0, 1
	GOTO       L_main35
	DECFSZ     R11+0, 1
	GOTO       L_main35
	NOP
;main.c,308 :: 		UART1_Write_Text("ANTES DE SET DATA\n");
	MOVLW      ?lstr12_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,313 :: 		set_data_ds1307(45, 34, 11, 1, 1, 1, 18);
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
;main.c,316 :: 		UART1_Write_Text("Despues DE SET DATA\n");
	MOVLW      ?lstr13_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,322 :: 		fakeAlarm[0] = 0x5D; // 0101 1101
	MOVLW      93
	MOVWF      main_fakeAlarm_L0+0
;main.c,323 :: 		fakeAlarm[1] = 0x11;
	MOVLW      17
	MOVWF      main_fakeAlarm_L0+1
;main.c,324 :: 		fakeAlarm[2] = 0x35;
	MOVLW      53
	MOVWF      main_fakeAlarm_L0+2
;main.c,327 :: 		delay_ms(1500);
	MOVLW      16
	MOVWF      R11+0
	MOVLW      57
	MOVWF      R12+0
	MOVLW      13
	MOVWF      R13+0
L_main36:
	DECFSZ     R13+0, 1
	GOTO       L_main36
	DECFSZ     R12+0, 1
	GOTO       L_main36
	DECFSZ     R11+0, 1
	GOTO       L_main36
	NOP
	NOP
;main.c,328 :: 		UART1_Write_Text("Enviando alarma");
	MOVLW      ?lstr14_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;main.c,329 :: 		update_alarm(fakeAlarm);
	MOVLW      main_fakeAlarm_L0+0
	MOVWF      FARG_update_alarm_alarm_data+0
	CALL       _update_alarm+0
;main.c,332 :: 		writeBytesToLCD(fakeAlarm[0]);
	MOVF       main_fakeAlarm_L0+0, 0
	MOVWF      FARG_writeBytesToLCD_ref+0
	CALL       _writeBytesToLCD+0
;main.c,333 :: 		writeBCDToLCD(fakeAlarm[0]);
	MOVF       main_fakeAlarm_L0+0, 0
	MOVWF      FARG_writeBCDToLCD_ref+0
	CALL       _writeBCDToLCD+0
;main.c,337 :: 		while (TRUE)
L_main37:
;main.c,361 :: 		check_alarms();
	CALL       _check_alarms+0
;main.c,362 :: 		delay_ms(500);
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L_main39:
	DECFSZ     R13+0, 1
	GOTO       L_main39
	DECFSZ     R12+0, 1
	GOTO       L_main39
	DECFSZ     R11+0, 1
	GOTO       L_main39
	NOP
	NOP
;main.c,363 :: 		}
	GOTO       L_main37
;main.c,365 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
