#include <stdio.h>
#include <string.h>
#include "constants.h"

#define TO_BOOL(X) (X > 0?1:0)

#define LED_0 PORTB.RB0
#define LED_1 PORTB.RB1
#define LED_2 PORTB.RB2
#define LED_3 PORTB.RB3
#define LED_4 PORTB.RB4
#define LED_5 PORTB.RB5
#define LED_6 PORTB.RB6


char uart_rd = 0;
int ord(char c) { return (int)c; }

char inputBuffer[FULL_PACKET_LENGTH];

int alarm_hours[MAX_ALARMS];
int alarm_minutes[MAX_ALARMS];
int dispenser_1_states[MAX_ALARMS];
int dispenser_2_states[MAX_ALARMS];
int dispenser_3_states[MAX_ALARMS];
int alarm_set_states[MAX_ALARMS];

void parse_alarm_string(char alarm_string[FULL_PACKET_LENGTH]) {
  // DO IT
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

  for(index = 0; index <= MAX_ALARMS; index++) {
    UART1_Write_Text("Alarm index");
    UART1_Write(index + 0x30);

    #ifdef __DEBUG__
    UART1_Write_Text("  - Convirtiendo hora");
    #endif
    alarm_hour = (
      (atoi(alarm_string[index+0]) * 10) + atoi(alarm_string[index+1])
    );
    #ifdef __DEBUG__
    UART1_Write_Text("  - Convirtiendo minuto");
    #endif
    //UART1_Write(alarm_hour + 0x30);
    alarm_minute = (
      (atoi(alarm_string[index + 2]) * 10) + atoi(alarm_string[index + 3])
    );
    //UART1_Write(alarm_minute + 0x30);

    #ifdef __DEBUG__
    UART1_Write_Text("  - Convirtiendo dispensador 1");
    #endif
    dispenser_1_state = atoi(alarm_string[4]);
    #ifdef __DEBUG__
    UART1_Write_Text("  - Convirtiendo dispensador 2");
    #endif
    dispenser_2_state = atoi(alarm_string[5]);

    #ifdef __DEBUG__
    UART1_Write_Text("  - Convirtiendo dispensador 3");
    #endif
    dispenser_3_state = atoi(alarm_string[5]);

    #ifdef __DEBUG__
    UART1_Write_Text("  - Convirtiendo estado");
    #endif
    alarm_state = TO_BOOL(atoi(alarm_string[6]));

    #ifdef __DEBUG__
    UART1_Write_Text("  - Asignando estados");
    #endif
    alarm_hours[index] = alarm_hour;
    alarm_minutes[index] = alarm_minute;
    dispenser_1_states[index] = dispenser_1_state;
    dispenser_2_states[index] = dispenser_2_state;
    dispenser_3_states[index] = dispenser_3_state;
    alarm_set_states[index] = alarm_state;

    LED_0 = TO_BOOL(alarm_hour == 13);
    UART1_Write(65 + alarm_hour);
    UART1_Write(65);
    LED_1 = alarm_minute == 11?1:0;
    LED_2 = dispenser_1_state == 1?1:0;
    LED_3 = dispenser_2_state == 0?1:0;
    LED_4 = dispenser_3_state == 1?1:0;
    LED_5 = alarm_state == 1?1:0;
    break;
  }
}

void main() {
  TRISB = 0;

  LED_0 = 0;
  LED_1 = 0;
  LED_2 = 0;
  LED_3 = 0;
  LED_4 = 0;
  LED_5 = 0;
  LED_6 = 0;
  Delay_ms(500);  
  LED_6 = 1;

  PORTC = 0x00;
  TRISC = 0x80;  // PORTC.Bit7 is Input for UART.

  strcpy(inputBuffer, "");

  // Initialize hardware UART1 and establish communication at 9600 bps
  UART1_Init(9600);
  Delay_ms(100);                  // Wait for UART module to stabilize

  UART1_Write_Text("Start");
  UART1_Write(10);
  UART1_Write(13);

  while (1) {                     // Endless loop
    if (UART1_Data_Ready() == 1) {     // If data is received,
      // uart_rd = UART1_Read_Text(output, ",", 10);     // read the received data,
      
      UART1_Read_Text(inputBuffer, ";", FULL_PACKET_LENGTH + 1);

      if (strlen(inputBuffer) > 0) {
        UART1_Write_Text(inputBuffer);
        #ifdef __DEBUG__
        UART1_Write_Text("-P-");
        UART1_Write_Text(inputBuffer);
        UART1_Write_Text("-P-");
        #endif

        parse_alarm_string(inputBuffer);

        strcpy(inputBuffer, "");
      } else {
        #ifdef __DEBUG__
        UART1_Write_Text("Puta");
        #endif
      }
    }
    
    //UART1_Write_Text("aa_");
    delay_ms(250);
  }
}