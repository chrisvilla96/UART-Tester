#line 1 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 1 "c:/users/52551/documents/graduation-project/uart-tester/constants.h"
#line 24 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
char inputBuffer[ 3 ];
char alarms[ 10  *  3 ];

void initialize_alarms() {

 char index;
 for (index = 0; index <= ( 10  *  3 ); index++) {
 alarms[index] = 0;
 }
}

void update_alarm(char alarm_data[ 3 ]) {

 char alarm_index =  ((alarm_data[0] >> 3) & 0x0F); ;

 if (0 <= alarm_index && alarm_index <=  10 ) {
 char offset = alarmIndex * FULL_PACKET_LENGTH;
 char index;
 for (index = 0; index <  3 ; index++) {
 offset = 0;
 alarms[offset + index] = alarm_data[index];
 }
 }

}

void main() {

 TRISB = 0;



 while ( 1 ) {
 if (UART1_Data_Ready() == 1) {
 UART1_Read_Text(inputBuffer, ";",  3  + 1);
 }

 if (strlen(inputBuffer) == 3) {
 update_alarm(inputBuffer);
 }

 delay_ms(250);
 inputBuffer[0] = 1;
 alarms[0] = 1;
 }


}
