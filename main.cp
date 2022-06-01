#line 1 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 1 "c:/users/52551/documents/graduation-project/uart-tester/constants.h"
#line 30 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
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

 if (0 <= alarm_index && alarm_index <=  10 ) {
 char offset = alarm_index *  3 ;
 char index;

 alarms[offset +  0 ] = alarm_data[ 0 ];
 alarms[offset +  1 ] = Bcd2Dec(
 alarm_data[ 1 ]
 );
 alarms[offset +  2 ] = Bcd2Dec(
 alarm_data[ 2 ]
 );

 PORTB = 0xff;
 delay_ms(75);

 PORTB = 0x00;
 delay_ms(75);

 PORTB = 0xff;
 delay_ms(75);

 PORTB = 0x00;
 delay_ms(75);

 PORTB = 0xff;
 delay_ms(75);

 PORTB = 0x00;
 delay_ms(75);

 PORTB = alarm_data[ 0 ];
 delay_ms(1500);

 PORTB = alarm_data[ 1 ];
 delay_ms(1500);

 PORTB = alarm_data[ 2 ];
 delay_ms(1500);
 }
}

void activate_dispensers(char dispenser_flags) {
 PORTB = dispenser_flags;
}

void check_alarms() {
#line 158 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
}

void main() {
 char fakeAlarm[3];

 TRISB = 0;
 PORTB = 0x00;


 UART1_Init(9600);
 UART1_Write_Text("Inicializado");

 while ( 1 ) {
 UART1_Write_Text("Main loop");

 if (UART1_Data_Ready() == 1) {
 UART1_Read_Text(inputBuffer, ";",  3  + 1);
 }

 if (strlen(inputBuffer) == 3) {
 update_alarm(inputBuffer);
 }


 delay_ms(250);
 }
}
