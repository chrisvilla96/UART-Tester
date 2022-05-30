
_write_ds1307:

;ds1307.c,3 :: 		unsigned char dato)
;ds1307.c,5 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;ds1307.c,6 :: 		I2C1_Wr(direccion_esclavo);
	MOVF       FARG_write_ds1307_direccion_esclavo+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,7 :: 		I2C1_Wr(direccion_memoria); // MEMORIA L
	MOVF       FARG_write_ds1307_direccion_memoria+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,8 :: 		I2C1_Wr(dato);              // DATO
	MOVF       FARG_write_ds1307_dato+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,9 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;ds1307.c,10 :: 		}
L_end_write_ds1307:
	RETURN
; end of _write_ds1307

_read_ds1307:

;ds1307.c,13 :: 		unsigned char direccion_memoria)
;ds1307.c,16 :: 		I2C1_Start();
	CALL       _I2C1_Start+0
;ds1307.c,17 :: 		I2C1_Wr(direccion_esclavo);
	MOVF       FARG_read_ds1307_direccion_esclavo+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,18 :: 		I2C1_Wr(direccion_memoria); // MEMORIA L
	MOVF       FARG_read_ds1307_direccion_memoria+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,19 :: 		I2C1_Repeated_Start();
	CALL       _I2C1_Repeated_Start+0
;ds1307.c,20 :: 		I2C1_Wr(direccion_esclavo + 1);
	INCF       FARG_read_ds1307_direccion_esclavo+0, 0
	MOVWF      FARG_I2C1_Wr_data_+0
	CALL       _I2C1_Wr+0
;ds1307.c,21 :: 		valor = I2C1_Rd(0);
	CLRF       FARG_I2C1_Rd_ack+0
	CALL       _I2C1_Rd+0
	MOVF       R0+0, 0
	MOVWF      read_ds1307_valor_L0+0
	CLRF       read_ds1307_valor_L0+1
;ds1307.c,22 :: 		I2C1_Stop();
	CALL       _I2C1_Stop+0
;ds1307.c,23 :: 		return valor;
	MOVF       read_ds1307_valor_L0+0, 0
	MOVWF      R0+0
	MOVF       read_ds1307_valor_L0+1, 0
	MOVWF      R0+1
;ds1307.c,24 :: 		}
L_end_read_ds1307:
	RETURN
; end of _read_ds1307

_set_data_ds1307:

;ds1307.c,27 :: 		int dia_semana, int dia, int mes, int ano)
;ds1307.c,30 :: 		segundos = Dec2Bcd(segundos);
	MOVF       FARG_set_data_ds1307_segundos+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_data_ds1307_segundos+0
	CLRF       FARG_set_data_ds1307_segundos+1
;ds1307.c,31 :: 		minutos = Dec2Bcd(minutos);
	MOVF       FARG_set_data_ds1307_minutos+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_data_ds1307_minutos+0
	CLRF       FARG_set_data_ds1307_minutos+1
;ds1307.c,32 :: 		hora = Dec2Bcd(hora);
	MOVF       FARG_set_data_ds1307_hora+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_data_ds1307_hora+0
	CLRF       FARG_set_data_ds1307_hora+1
;ds1307.c,33 :: 		dia_semana = Dec2Bcd(dia_semana);
	MOVF       FARG_set_data_ds1307_dia_semana+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_data_ds1307_dia_semana+0
	CLRF       FARG_set_data_ds1307_dia_semana+1
;ds1307.c,34 :: 		dia = Dec2Bcd(dia);
	MOVF       FARG_set_data_ds1307_dia+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_data_ds1307_dia+0
	CLRF       FARG_set_data_ds1307_dia+1
;ds1307.c,35 :: 		mes = Dec2Bcd(mes);
	MOVF       FARG_set_data_ds1307_mes+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_data_ds1307_mes+0
	CLRF       FARG_set_data_ds1307_mes+1
;ds1307.c,36 :: 		ano = Dec2Bcd(ano);
	MOVF       FARG_set_data_ds1307_ano+0, 0
	MOVWF      FARG_Dec2Bcd_decnum+0
	CALL       _Dec2Bcd+0
	MOVF       R0+0, 0
	MOVWF      FARG_set_data_ds1307_ano+0
	CLRF       FARG_set_data_ds1307_ano+1
;ds1307.c,38 :: 		for (i = 0; i <= 6; i++)
	CLRF       set_data_ds1307_i_L0+0
	CLRF       set_data_ds1307_i_L0+1
L_set_data_ds13070:
	MOVLW      128
	MOVWF      R0+0
	MOVLW      128
	XORWF      set_data_ds1307_i_L0+1, 0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130715
	MOVF       set_data_ds1307_i_L0+0, 0
	SUBLW      6
L__set_data_ds130715:
	BTFSS      STATUS+0, 0
	GOTO       L_set_data_ds13071
;ds1307.c,40 :: 		switch (i)
	GOTO       L_set_data_ds13073
;ds1307.c,42 :: 		case 0:
L_set_data_ds13075:
;ds1307.c,43 :: 		write_ds1307(0xD0, i, segundos);
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVF       set_data_ds1307_i_L0+0, 0
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	MOVF       FARG_set_data_ds1307_segundos+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	CALL       _write_ds1307+0
;ds1307.c,44 :: 		break;
	GOTO       L_set_data_ds13074
;ds1307.c,45 :: 		case 1:
L_set_data_ds13076:
;ds1307.c,46 :: 		write_ds1307(0xD0, i, minutos);
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVF       set_data_ds1307_i_L0+0, 0
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	MOVF       FARG_set_data_ds1307_minutos+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	CALL       _write_ds1307+0
;ds1307.c,47 :: 		break;
	GOTO       L_set_data_ds13074
;ds1307.c,48 :: 		case 2:
L_set_data_ds13077:
;ds1307.c,49 :: 		write_ds1307(0xD0, i, hora);
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVF       set_data_ds1307_i_L0+0, 0
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	MOVF       FARG_set_data_ds1307_hora+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	CALL       _write_ds1307+0
;ds1307.c,50 :: 		break;
	GOTO       L_set_data_ds13074
;ds1307.c,51 :: 		case 3:
L_set_data_ds13078:
;ds1307.c,52 :: 		write_ds1307(0xD0, i, dia_semana);
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVF       set_data_ds1307_i_L0+0, 0
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	MOVF       FARG_set_data_ds1307_dia_semana+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	CALL       _write_ds1307+0
;ds1307.c,53 :: 		break;
	GOTO       L_set_data_ds13074
;ds1307.c,54 :: 		case 4:
L_set_data_ds13079:
;ds1307.c,55 :: 		write_ds1307(0xD0, i, dia);
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVF       set_data_ds1307_i_L0+0, 0
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	MOVF       FARG_set_data_ds1307_dia+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	CALL       _write_ds1307+0
;ds1307.c,56 :: 		break;
	GOTO       L_set_data_ds13074
;ds1307.c,57 :: 		case 5:
L_set_data_ds130710:
;ds1307.c,58 :: 		write_ds1307(0xD0, i, mes);
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVF       set_data_ds1307_i_L0+0, 0
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	MOVF       FARG_set_data_ds1307_mes+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	CALL       _write_ds1307+0
;ds1307.c,59 :: 		break;
	GOTO       L_set_data_ds13074
;ds1307.c,60 :: 		case 6:
L_set_data_ds130711:
;ds1307.c,61 :: 		write_ds1307(0xD0, i, ano);
	MOVLW      208
	MOVWF      FARG_write_ds1307_direccion_esclavo+0
	MOVF       set_data_ds1307_i_L0+0, 0
	MOVWF      FARG_write_ds1307_direccion_memoria+0
	MOVF       FARG_set_data_ds1307_ano+0, 0
	MOVWF      FARG_write_ds1307_dato+0
	CALL       _write_ds1307+0
;ds1307.c,62 :: 		break;
	GOTO       L_set_data_ds13074
;ds1307.c,63 :: 		}
L_set_data_ds13073:
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130716
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+0, 0
L__set_data_ds130716:
	BTFSC      STATUS+0, 2
	GOTO       L_set_data_ds13075
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130717
	MOVLW      1
	XORWF      set_data_ds1307_i_L0+0, 0
L__set_data_ds130717:
	BTFSC      STATUS+0, 2
	GOTO       L_set_data_ds13076
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130718
	MOVLW      2
	XORWF      set_data_ds1307_i_L0+0, 0
L__set_data_ds130718:
	BTFSC      STATUS+0, 2
	GOTO       L_set_data_ds13077
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130719
	MOVLW      3
	XORWF      set_data_ds1307_i_L0+0, 0
L__set_data_ds130719:
	BTFSC      STATUS+0, 2
	GOTO       L_set_data_ds13078
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130720
	MOVLW      4
	XORWF      set_data_ds1307_i_L0+0, 0
L__set_data_ds130720:
	BTFSC      STATUS+0, 2
	GOTO       L_set_data_ds13079
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130721
	MOVLW      5
	XORWF      set_data_ds1307_i_L0+0, 0
L__set_data_ds130721:
	BTFSC      STATUS+0, 2
	GOTO       L_set_data_ds130710
	MOVLW      0
	XORWF      set_data_ds1307_i_L0+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__set_data_ds130722
	MOVLW      6
	XORWF      set_data_ds1307_i_L0+0, 0
L__set_data_ds130722:
	BTFSC      STATUS+0, 2
	GOTO       L_set_data_ds130711
L_set_data_ds13074:
;ds1307.c,38 :: 		for (i = 0; i <= 6; i++)
	INCF       set_data_ds1307_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       set_data_ds1307_i_L0+1, 1
;ds1307.c,64 :: 		}
	GOTO       L_set_data_ds13070
L_set_data_ds13071:
;ds1307.c,65 :: 		}
L_end_set_data_ds1307:
	RETURN
; end of _set_data_ds1307
