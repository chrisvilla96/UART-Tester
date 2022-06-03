#line 1 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 1 "c:/users/chris/documents/graduation-project/uart-tester/constants.h"
#line 1 "c:/users/chris/documents/graduation-project/uart-tester/ds1307.h"





void write_ds1307(

 unsigned char direccion_esclavo,
 unsigned char direccion_memoria,
 unsigned char dato
);

int read_ds1307(
 unsigned char direccion_esclavo,
 unsigned char direccion_memoria
);

void set_data_ds1307(
 int second,
 int minute,
 int hour,
 int day,
 int week_day,
 int month,
 int year
);

char RTC_Read_Clock_Seconds();
#line 1 "c:/users/chris/documents/graduation-project/uart-tester/lcd_connection.h"

sbit LCD_RS at RD0_bit;
sbit LCD_EN at RD1_bit;
sbit LCD_D4 at RD4_bit;
sbit LCD_D5 at RD5_bit;
sbit LCD_D6 at RD6_bit;
sbit LCD_D7 at RD7_bit;

sbit LCD_RS_Direction at TRISD0_bit;
sbit LCD_EN_Direction at TRISD1_bit;
sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
#line 35 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
char inputBuffer[ 3 ];
char alarms[ 10  *  3 ];
char sentinel = 0;

void writeBCDToLCD(char ref) {
 Lcd_out(2, 1, "d                ");
 Lcd_out(2, 1, "d ");

 Lcd_chr_cp(((ref >> 4) & 0x0F) + 0x30);

 Lcd_chr_cp((ref & 0x0F) + 0x30);
 delay_ms(1000);
}


void writeBytesToLCD(char ref) {
 Lcd_out(2, 1, "b                ");
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_out(2, 1, "b ");
 Lcd_chr_cp(((ref >> 7) & 0x01) + 0x30);
 Lcd_chr_cp(((ref >> 6) & 0x01) + 0x30);
 Lcd_chr_cp(((ref >> 5) & 0x01) + 0x30);
 Lcd_chr_cp(((ref >> 4) & 0x01) + 0x30);
 Lcd_chr_cp(((ref >> 3) & 0x01) + 0x30);
 Lcd_chr_cp(((ref >> 2) & 0x01) + 0x30);
 Lcd_chr_cp(((ref >> 1) & 0x01) + 0x30);
 Lcd_chr_cp(((ref >> 0) & 0x01) + 0x30);
 delay_ms(1000);
}



void updateSentinel() {
 PORTB = ++sentinel;
}

void init_led() {
 int i;
 for (i = 0; i < 2; i++)
 {
  PORTC.RC2  = 1;
 delay_ms(1000);
  PORTC.RC2  = 0;
 delay_ms(1000);
 }
}



void initialize_alarms() {

 char index;
 for (index = 0; index <= ( 10  *  3 ); index++) {
 alarms[index] = 0;
 }
}



void update_alarm(char alarm_data[ 3 ]) {

 char alarm_index =  ((alarm_data[0] >> 4) & 0x0F); ;

 if (0 <= alarm_index && alarm_index <=  10 ) {
 char offset = alarm_index *  3 ;

 alarms[offset +  0 ] = alarm_data[ 0 ];
 alarms[offset +  1 ] = alarm_data[ 1 ];
 alarms[offset +  2 ] = alarm_data[ 2 ];
#line 114 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
 Lcd_out(2, 1, "SA_");
 Lcd_chr_cp(Bcd2Dec(alarm_data[0]) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(alarm_data[0]) % 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(alarm_data[1]) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(alarm_data[1]) % 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(alarm_data[2]) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(alarm_data[2]) % 10 + 0x30);
 Lcd_chr_cp('|');
 delay_ms(2000);
 }




 PORTB = 0x0F;
 delay_ms(500);
 PORTB = 0x00;
 delay_ms(500);
}


void activate_dispensers(char dispenser_flags) {
 PORTB = dispenser_flags;
 PORTB = 0x0F;
 delay_ms(500);
 PORTB = 0x00;
 delay_ms(500);
 delay_ms(1500);
}

void check_alarms() {
 char hours;
 char minutes;
 char seconds;
 char alarm_index;

 seconds = read_ds1307(0xD0, 0);
 minutes = read_ds1307(0xD0, 1);
 hours = read_ds1307(0xD0, 2);

 if (seconds == 0x00) {
 Lcd_out(2, 1, "Estamos en 0 segundos");

 for (alarm_index = 0; alarm_index <=  10 ; alarm_index++) {
 char current_alarm_hour;
 char current_alarm_minute;
 char otro;

 Lcd_out(2, 1, "CA");
 Lcd_chr_cp(alarm_index + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 7) & 0x01) + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 6) & 0x01) + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 5) & 0x01) + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 4) & 0x01) + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 3) & 0x01) + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 2) & 0x01) + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 1) & 0x01) + 0x30);
 Lcd_chr_cp(((alarms[alarm_index +  0 ] >> 0) & 0x01) + 0x30);
 delay_ms(1000);

 if (!(alarms[alarm_index +  0 ] &  0 )) {
 continue;
 }

 Lcd_out(2, 1, "alrm actv");
 Lcd_chr_cp(alarm_index + 0x30);
 delay_ms(1000);


 current_alarm_hour = alarms[alarm_index +  1 ];
 current_alarm_minute = alarms[alarm_index +  1 ];

 Lcd_out(2, 1, "t:");
 Lcd_chr_cp(Bcd2Dec(current_alarm_hour) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(current_alarm_minute) % 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(current_alarm_minute) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(current_alarm_minute) % 10 + 0x30);
 Lcd_chr_cp(',');
 Lcd_chr_cp(Bcd2Dec(hours) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(hours) % 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(minutes) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(minutes) % 10 + 0x30);
 delay_ms(1000);


 if (current_alarm_hour == hours && current_alarm_minute == minutes) {

 char current_alarm_flags = alarms[alarm_index +  0 ];

 current_alarm_flags = (current_alarm_flags >> 1) & 0x07;


 activate_dispensers(current_alarm_flags);
 }
 }
 }
}

void check_ds1307() {
 char seconds;

 while ( 1 ) {
 PORTB = 0x00;
 seconds = RTC_Read_Clock_Seconds();
 PORTB = seconds;
 delay_ms(1000);
 }
#line 243 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
}


void sends_data_to_lcd(char second, char minute, char hour) {
#line 258 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
 Lcd_out(1, 1, "HORA: ");
 Lcd_chr_cp(Bcd2Dec(hour)/10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(hour)%10 + 0x30);
 Lcd_chr_cp(':');
 Lcd_chr_cp(Bcd2Dec(minute) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(minute) % 10 + 0x30);
 Lcd_chr_cp(':');
 Lcd_chr_cp(Bcd2Dec(second) / 10 + 0x30);
 Lcd_chr_cp(Bcd2Dec(second) % 10 + 0x30);
}


char ds1307_seconds;
char ds1307_minutes;
char ds1307_hours;




void main() {
 char fakeAlarm[3];
 char loopIndex = 0;

 TRISB = 0;
 PORTB = 0x00;


 TRISC.RC2 = 0;
 PORTC.RC2 = 0;
 initialize_alarms();


 UART1_Init(9600);

 UART1_Write_Text("Inicializado\n");

 delay_ms(100);


 Lcd_init();
 Lcd_cmd(12);
 delay_ms(100);
 Lcd_Cmd(_LCD_CLEAR);


 I2C1_Init(100000);
 delay_ms(100);



 UART1_Write_Text("ANTES DE SET DATA\n");




 set_data_ds1307(45, 34, 11, 1, 1, 1, 18);


 UART1_Write_Text("Despues DE SET DATA\n");





 fakeAlarm[0] = 0x5D;
 fakeAlarm[1] = 0x11;
 fakeAlarm[2] = 0x35;


 delay_ms(1500);
 UART1_Write_Text("Enviando alarma");
 update_alarm(fakeAlarm);


 writeBytesToLCD(fakeAlarm[0]);
 writeBCDToLCD(fakeAlarm[0]);



 while ( 1 )
 {
#line 361 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
 check_alarms();
 delay_ms(500);
 }

}
