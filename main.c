#include <stdio.h>
#include "constants.h"

#define TO_BOOL(X) (X > 0?1:0)

// Alarm macros
#define GET_ALARM_INDEX(X) ((X >> 3) & 0x0F);
#define GET_ALARM_ACTIVE_STATE(X) (X & 0x1);
#define GET_ALARM_DISPENSER_0_STATE(X) ((X >> 1) & 0x1);
#define GET_ALARM_DISPENSER_1_STATE(X) ((X >> 2) & 0x1);
#define GET_ALARM_DISPENSER_2_STATE(X) ((X >> 3) & 0x1);

// Helper macros
#define LESS_THAN_OR(X, Y, Z) (X < Y ? X : Z)

#define LED_0 PORTB.RB0
#define LED_1 PORTB.RB1
#define LED_2 PORTB.RB2
#define LED_3 PORTB.RB3
#define LED_4 PORTB.RB4
#define LED_5 PORTB.RB5
#define LED_6 PORTB.RB6

char inputBuffer[ALARM_PACKET_LENGTH]; // 3 bytes
char alarms[MAX_ALARMS * ALARM_PACKET_LENGTH]; // 30 bytes

void initialize_alarms() {
  // Byte accounting base + 1
  char index; 
  for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
    alarms[index] = 0;
  }
}

void update_alarm(char alarm_data[ALARM_PACKET_LENGTH]) {
  // Byte accounting base + 3
  char alarm_index = GET_ALARM_INDEX(alarm_data[0]);

  if (0 <= alarm_index && alarm_index <= MAX_ALARMS) {
    char offset = alarm_index * ALARM_PACKET_LENGTH;
    char index;
    for (index = 0; index < ALARM_PACKET_LENGTH; index++) {
      alarms[offset + index] = alarm_data[index];
    }
  }
}

void check_alarms() {
  // Notificar el cambio en la alarma al pic secundario
}

void main() {
  // Initialization
  TRISB = 0;
  //initialize_alarms();

  // Alarm read loop
  while (TRUE) {
    if (UART1_Data_Ready() == 1) {
      UART1_Read_Text(inputBuffer, ";", ALARM_PACKET_LENGTH + 1);
    }

    if (strlen(inputBuffer) == 3) {
      update_alarm(inputBuffer);
    }

    check_alarms();
    delay_ms(250);
    inputBuffer[0] = 1;
    alarms[0] = 1;
  }

  // Shutdown
}