#line 1 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/ds1307.c"
void write_ds1307(unsigned char direccion_esclavo,
 unsigned char direccion_memoria,
 unsigned char dato)
{
 I2C1_Start();
 I2C1_Wr(direccion_esclavo);
 I2C1_Wr(direccion_memoria);
 I2C1_Wr(dato);
 I2C1_Stop();
}

int read_ds1307(unsigned char direccion_esclavo,
 unsigned char direccion_memoria)
{
 int valor;
 I2C1_Start();
 I2C1_Wr(direccion_esclavo);
 I2C1_Wr(direccion_memoria);
 I2C1_Repeated_Start();
 I2C1_Wr(direccion_esclavo + 1);
 valor = I2C1_Rd(0);
 I2C1_Stop();
 return valor;
}

void set_data_ds1307(int segundos, int minutos, int hora,
 int dia_semana, int dia, int mes, int ano)
{
 int i;
 segundos = Dec2Bcd(segundos);
 minutos = Dec2Bcd(minutos);
 hora = Dec2Bcd(hora);
 dia_semana = Dec2Bcd(dia_semana);
 dia = Dec2Bcd(dia);
 mes = Dec2Bcd(mes);
 ano = Dec2Bcd(ano);

 for (i = 0; i <= 6; i++)
 {
 switch (i)
 {
 case 0:
 write_ds1307(0xD0, i, segundos);
 break;
 case 1:
 write_ds1307(0xD0, i, minutos);
 break;
 case 2:
 write_ds1307(0xD0, i, hora);
 break;
 case 3:
 write_ds1307(0xD0, i, dia_semana);
 break;
 case 4:
 write_ds1307(0xD0, i, dia);
 break;
 case 5:
 write_ds1307(0xD0, i, mes);
 break;
 case 6:
 write_ds1307(0xD0, i, ano);
 break;
 }
 }
}
