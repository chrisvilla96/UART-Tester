#include <stdio.h>
#include "constants.h"

#define TO_BOOL(X) (X > 0?1:0)

// Alarm Packet example

// Alarm macros
#define GET_ALARM_INDEX(X) ((X >> 4) & 0x0F);
#define GET_ALARM_ACTIVE_STATE(X) (X & 0x1);
#define GET_ALARM_DISPENSER_0_STATE(X) (X & ALARM_DISPENSER_0_MASK)
#define GET_ALARM_DISPENSER_1_STATE(X) (X & ALARM_DISPENSER_1_MASK)
#define GET_ALARM_DISPENSER_2_STATE(X) (X & ALARM_DISPENSER_2_MASK)
// TODO: Macros para extraer hora y minuto

#define GET_ALARM_HOUR(X)  (((X & 0xF0) >> ) + (X))
#define GET_ALARM_MINUTE(X) (((X & 0xF0) >>) + (X) + (X))

// Helper macros
#define LESS_THAN_OR(X, Y, Z) (X < Y ? X : Z)

#define LED_0 PORTB.RB0
#define LED_1 PORTB.RB1
#define LED_2 PORTB.RB2
#define LED_3 PORTB.RB3
#define LED_4 PORTB.RB4
#define LED_5 PORTB.RB5
#define LED_6 PORTB.RB6



void main() {
  char fakeAlarm[3];
  // Initialization
  TRISB = 0;
  PORTB = 0x00;
  //initialize_alarms();

  UART1_Init(9600);
  UART1_Write_Text("Inicializado");
  // Alarm read loop
  while (TRUE) {
    UART1_Write_Text("Main loop");
    
    if (UART1_Data_Ready() == 1) {
      UART1_Read_Text(inputBuffer, ";", ALARM_PACKET_LENGTH + 1);
    }

    if (strlen(inputBuffer) == 3) {
      update_alarm(inputBuffer);
    }

    // check_alarms();
    delay_ms(250);
  }
}