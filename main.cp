#line 1 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 1 "c:/users/chris/documents/graduation-project/uart-tester/constants.h"
#line 30 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
char inputBuffer[ 3 ];
char alarms[ 10  *  3 ];



void initialize_alarms() {

 char index;
 for (index = 0; index <= ( 10  *  3 ); index++) {
 alarms[index] = 0;
 }

}


void update_alarm(char alarm_data[ 3 ]) {

 char alarm_index =  ((alarm_data[0] >> 4) & 0x0F); ;
#line 65 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
 UART1_Write_Text("Revisando indice");
 if (0 <= alarm_index && alarm_index <=  10 ) {
 char offset = alarm_index *  3 ;
 char index;
 UART1_Write_Text("Alarma encontrada");

 alarms[offset +  0 ] = alarm_data[ 0 ];
 alarms[offset +  1 ] = Bcd2Dec(
 alarm_data[ 1 ]
 );
 alarms[offset +  2 ] = Bcd2Dec(
 alarm_data[ 2 ]
 );



 PORTB = alarms[offset +  0 ];
 UART1_Write_Text("Flags");
 delay_ms(1500);

 PORTB = alarms[offset +  1 ];
 UART1_Write_Text("Hora");
 delay_ms(1500);

 PORTB = alarms[offset +  2 ];
 UART1_Write_Text("Minutos");
 delay_ms(1500);

 }
}

void check_alarms() {
 char hours;
 char minutes;
 char index;
#line 118 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
}

void main() {
 char fakeAlarm[3];

 TRISB = 0;
 PORTB = 0x00;


 UART1_Init(9600);
 UART1_Write_Text("Inicializado");

 while ( 1 ) {
 UART1_Write_Text("Main loop");
#line 143 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
 delay_ms(250);


 fakeAlarm[0] = 0x5D;
 fakeAlarm[1] = 0x11;
 fakeAlarm[2] = 0x35;
 UART1_Write_Text("Enviando alarma");
 update_alarm(fakeAlarm);
 }

}
