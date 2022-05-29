#include <stdio.h>
#include <string.h>
#include "constants.h"


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

  for(index = 0; index <= MAX_ALARMS; index++) {
    UART1_Write_Text("Alarm index");

    alarm_hour = 0;
    alarm_minute = 0;
    dispenser_1_state = 0;
    dispenser_2_state = 0;
    dispenser_3_state = 0;
    alarm_state = 0;

    alarm_hours[index] = alarm_hour;
    alarm_minutes[index] = alarm_minute;
    dispenser_1_states[index] = dispenser_1_state;
    dispenser_2_states[index] = dispenser_2_state;
    dispenser_3_states[index] = dispenser_3_state;
    alarm_set_states[index] = alarm_state;
  }
}

void main() {
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
        parse_alarm_string(inputBuffer);
        strcpy(inputBuffer, "");
      } else {
        UART1_Write_Text("Puta");
      }
    }
    
    //UART1_Write_Text("aa_");
    delay_ms(250);
  }
}