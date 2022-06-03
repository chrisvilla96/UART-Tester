
_write_ds1307:

;ds1307.c,7 :: 		)
;ds1307.c,9 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;ds1307.c,10 :: 		I2C1_Wr(direccion_esclavo);
	MOVF       FARG_write_ds1307_direccion_esclavo+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,11 :: 		I2C1_Wr(direccion_memoria); // MEMORIA L
	MOVF       FARG_write_ds1307_direccion_memoria+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,12 :: 		I2C1_Wr(dato);              // DATO
	MOVF       FARG_write_ds1307_dato+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,13 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;ds1307.c,14 :: 		}
L_end_write_ds1307:
	RETURN
; end of _write_ds1307

_read_ds1307:

;ds1307.c,19 :: 		)
;ds1307.c,22 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;ds1307.c,23 :: 		I2C1_Wr(direccion_esclavo);
	MOVF       FARG_read_ds1307_direccion_esclavo+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,24 :: 		I2C1_Wr(direccion_memoria); // MEMORIA L
	MOVF       FARG_read_ds1307_direccion_memoria+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,25 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;ds1307.c,26 :: 		I2C1_Wr(direccion_esclavo + 1);
	INCF       FARG_read_ds1307_direccion_esclavo+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,27 :: 		valor = I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      read_ds1307_valor_L0+0
	CLRF       read_ds1307_valor_L0+1
;ds1307.c,28 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;ds1307.c,29 :: 		return valor;
	MOVF       read_ds1307_valor_L0+0, 0
	MOVWF      R0+0
	MOVF       read_ds1307_valor_L0+1, 0
	MOVWF      R0+1
;ds1307.c,30 :: 		}
L_end_read_ds1307:
	RETURN
; end of _read_ds1307

_set_data_ds1307:

;ds1307.c,40 :: 		)
;ds1307.c,42 :: 		write_ds1307(0xD0, 0, Dec2Bcd(second));
	MOVF       FARG_set_data_ds1307_second+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	CLRF       FARG_write_ds1307_direccion_memoria+0
	CALL       _write_ds1307+0
;ds1307.c,43 :: 		write_ds1307(0xD0, 1, Dec2Bcd(minute));
	MOVF       FARG_set_data_ds1307_minute+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVLW      1
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	CALL       _write_ds1307+0
;ds1307.c,44 :: 		write_ds1307(0xD0, 2, Dec2Bcd(hour));
	MOVF       FARG_set_data_ds1307_hour+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVLW      2
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	CALL       _write_ds1307+0
;ds1307.c,45 :: 		write_ds1307(0xD0, 3, Dec2Bcd(day));
	MOVF       FARG_set_data_ds1307_day+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVLW      3
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	CALL       _write_ds1307+0
;ds1307.c,46 :: 		write_ds1307(0xD0, 4, Dec2Bcd(week_day));
	MOVF       FARG_set_data_ds1307_week_day+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVLW      4
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	CALL       _write_ds1307+0
;ds1307.c,47 :: 		write_ds1307(0xD0, 5, Dec2Bcd(year));
	MOVF       FARG_set_data_ds1307_year+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVLW      5
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	CALL       _write_ds1307+0
;ds1307.c,87 :: 		}
L_end_set_data_ds1307:
	RETURN
; end of _set_data_ds1307

_RTC_Read_Clock_Tine_Element:

;ds1307.c,89 :: 		char RTC_Read_Clock_Tine_Element(char element)
;ds1307.c,91 :: 		I2C_Start();
	CALL       _I2C_Start+0
;ds1307.c,92 :: 		I2C_Write(DEVICE_ID_WRITE);
	MOVLW      208
	MOVWF      FARG_I2C_Write_data_+0
	CALL       _I2C_Write+0
;ds1307.c,93 :: 		I2C_Write(element); /* address from where time needs to be read*/
	MOVF       FARG_RTC_Read_Clock_Tine_Element_element+0, 0
	MOVWF      FARG_I2C_Write_data_+0
	CALL       _I2C_Write+0
;ds1307.c,94 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;ds1307.c,95 :: 		I2C_Write(DEVICE_ID_READ);
	MOVLW      209
	MOVWF      FARG_I2C_Write_data_+0
	CALL       _I2C_Write+0
;ds1307.c,96 :: 		return I2C_Read(1); /* hours > read data and send nack for indicating stop reading*/
	MOVLW      1
	MOVWF      FARG_I2C_Read_ack+0
	CALL       _I2C_Read+0
;ds1307.c,97 :: 		}
L_end_RTC_Read_Clock_Tine_Element:
	RETURN
; end of _RTC_Read_Clock_Tine_Element

_RTC_Read_Clock_Seconds:

;ds1307.c,99 :: 		char RTC_Read_Clock_Seconds()
;ds1307.c,101 :: 		return RTC_Read_Clock_Tine_Element(TIME_ELEMENT_SECOND);
	CLRF       FARG_RTC_Read_Clock_Tine_Element_element+0
	CALL       _RTC_Read_Clock_Tine_Element+0
;ds1307.c,102 :: 		}
L_end_RTC_Read_Clock_Seconds:
	RETURN
; end of _RTC_Read_Clock_Seconds
