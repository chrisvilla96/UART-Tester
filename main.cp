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
 }
}

void activate_dispensers(char dispenser_flags) {
 PORTB = dispenser_flags;
}

void check_alarms() {
 char hours;
 char minutes;
 char index;
 char segundos;





 if (segundos == 0) {
 char alarm_index;
 for (alarm_index = 0; alarm_index <= ( 10  *  3 ); alarm_index++) {


 char current_alarm_hour = alarms[alarm_index +  1 ];
 char current_alarm_minute = alarms[alarm_index +  1 ];


 if (current_alarm_hour == hours && current_alarm_minute == minutes) {

 char current_alarm_flags = alarms[alarm_index +  0 ];

 current_alarm_flags = (current_alarm_flags >> 1) & 0x07;

 activate_dispensers(current_alarm_flags);
 }

 alarm_index += 3;
 }
#line 119 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
 }
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

 check_alarms();
 delay_ms(250);


 fakeAlarm[0] = 0x5D;
 fakeAlarm[1] = 0x11;
 fakeAlarm[2] = 0x35;
 UART1_Write_Text("Enviando alarma");
 update_alarm(fakeAlarm);
 }

}
