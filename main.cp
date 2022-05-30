#line 1 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdio.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/string.h"





void * memchr(void *p, char n, unsigned int v);
int memcmp(void *s1, void *s2, int n);
void * memcpy(void * d1, void * s1, int n);
void * memmove(void * to, void * from, int n);
void * memset(void * p1, char character, int n);
char * strcat(char * to, char * from);
char * strchr(char * ptr, char chr);
int strcmp(char * s1, char * s2);
char * strcpy(char * to, char * from);
int strlen(char * s);
char * strncat(char * to, char * from, int size);
char * strncpy(char * to, char * from, int size);
int strspn(char * str1, char * str2);
char strcspn(char * s1, char * s2);
int strncmp(char * s1, char * s2, char len);
char * strpbrk(char * s1, char * s2);
char * strrchr(char *ptr, char chr);
char * strstr(char * s1, char * s2);
char * strtok(char * s1, char * s2);
#line 1 "c:/users/52551/documents/graduation-project/uart-tester/constants.h"
#line 16 "C:/Users/52551/Documents/Graduation-Project/UART-Tester/main.c"
char uart_rd = 0;
int ord(char c) { return (int)c; }

char inputBuffer[ 10  * 8 ];

int alarm_hours[ 10 ];
int alarm_minutes[ 10 ];
int dispenser_1_states[ 10 ];
int dispenser_2_states[ 10 ];
int dispenser_3_states[ 10 ];
int alarm_set_states[ 10 ];

void parse_alarm_string(char alarm_string[ 10  * 8 ]) {

 char * alarm_base = alarm_string;
 int index = 0;

 int alarm_hour = 0;
 int alarm_minute = 0;
 int dispenser_1_state = 0;
 int dispenser_2_state = 0;
 int dispenser_3_state = 0;
 int alarm_state = 0;

 int packet_number = 0;
 int offset;

 char textBuffer[80];

 for(index = 0; index <=  10 ; index++) {
 UART1_Write_Text("Alarm index");
 UART1_Write(index + 0x30);


 UART1_Write_Text("  - Convirtiendo hora");

 alarm_hour = (
 (atoi(alarm_string[index+0]) * 10) + atoi(alarm_string[index+1])
 );

 UART1_Write_Text("  - Convirtiendo minuto");


 alarm_minute = (
 (atoi(alarm_string[index + 2]) * 10) + atoi(alarm_string[index + 3])
 );



 UART1_Write_Text("  - Convirtiendo dispensador 1");

 dispenser_1_state = atoi(alarm_string[4]);

 UART1_Write_Text("  - Convirtiendo dispensador 2");

 dispenser_2_state = atoi(alarm_string[5]);


 UART1_Write_Text("  - Convirtiendo dispensador 3");

 dispenser_3_state = atoi(alarm_string[5]);


 UART1_Write_Text("  - Convirtiendo estado");

 alarm_state =  (atoi(alarm_string[6]) > 0?1:0) ;


 UART1_Write_Text("  - Asignando estados");

 alarm_hours[index] = alarm_hour;
 alarm_minutes[index] = alarm_minute;
 dispenser_1_states[index] = dispenser_1_state;
 dispenser_2_states[index] = dispenser_2_state;
 dispenser_3_states[index] = dispenser_3_state;
 alarm_set_states[index] = alarm_state;

  PORTB.RB0  =  (alarm_hour == 13 > 0?1:0) ;
 UART1_Write(65 + alarm_hour);
 UART1_Write(65);
  PORTB.RB1  = alarm_minute == 11?1:0;
  PORTB.RB2  = dispenser_1_state == 1?1:0;
  PORTB.RB3  = dispenser_2_state == 0?1:0;
  PORTB.RB4  = dispenser_3_state == 1?1:0;
  PORTB.RB5  = alarm_state == 1?1:0;
 break;
 }
}

void main() {
 TRISB = 0;

  PORTB.RB0  = 0;
  PORTB.RB1  = 0;
  PORTB.RB2  = 0;
  PORTB.RB3  = 0;
  PORTB.RB4  = 0;
  PORTB.RB5  = 0;
  PORTB.RB6  = 0;
 Delay_ms(500);
  PORTB.RB6  = 1;

 PORTC = 0x00;
 TRISC = 0x80;

 strcpy(inputBuffer, "");


 UART1_Init(9600);
 Delay_ms(100);

 UART1_Write_Text("Start");
 UART1_Write(10);
 UART1_Write(13);

 while (1) {
 if (UART1_Data_Ready() == 1) {


 UART1_Read_Text(inputBuffer, ";",  10  * 8  + 1);

 if (strlen(inputBuffer) > 0) {
 UART1_Write_Text(inputBuffer);

 UART1_Write_Text("-P-");
 UART1_Write_Text(inputBuffer);
 UART1_Write_Text("-P-");


 parse_alarm_string(inputBuffer);

 strcpy(inputBuffer, "");
 } else {

 UART1_Write_Text("Puta");

 }
 }


 delay_ms(250);
 }
}
