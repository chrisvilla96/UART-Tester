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

char inputBuffer[ALARM_PACKET_LENGTH]; // 3 bytes
char alarms[MAX_ALARMS * ALARM_PACKET_LENGTH]; // 30 bytes


// Initialize every item on alarms array to 0
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

    alarms[offset + ALARM_FLAG_BYTE_OFFSET] = alarm_data[ALARM_FLAG_BYTE_OFFSET];
    alarms[offset + ALARM_HOUR_BYTE_OFFSET] = Bcd2Dec(
      alarm_data[ALARM_HOUR_BYTE_OFFSET]
    );
    alarms[offset + ALARM_MINUTE_BYTE_OFFSET] = Bcd2Dec(
      alarm_data[ALARM_MINUTE_BYTE_OFFSET]
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

  // segundos = Bcd2Dec(read_ds1307(0xD0, 0));
  // minutos = Bcd2Dec(read_ds1307(0xD0, 1));
  // hora = Bcd2Dec(read_ds1307(0xD0, 2));

  if (segundos == 0) {
    char alarm_index;
    for (alarm_index = 0; alarm_index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); alarm_index++) {

      // Gets the alarm minute and hour
      char current_alarm_hour = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
      char current_alarm_minute = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];

      // Checks if the hour and minute matches with the alarm data
      if (current_alarm_hour == hours && current_alarm_minute == minutes) {
        // Gets the current alarm flags data
        char current_alarm_flags = alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET];

        current_alarm_flags = (current_alarm_flags >> 1) & 0x07;

        activate_dispensers(current_alarm_flags);
      }

      alarm_index += 3;
    }
    /*
    for (alarm in alarms) {
      if (matches hour and minute)
      (FLAGS >> 1) & 0x07
      activate_dispensers(flags);
      delay_ms(1000);
  }
  */
  
  /// Keep going
  

            // Notificar el cambio en la alarma al pic secundario
            // TODO:
            // - Obtener tiempo actual
            /*
            for (index = 0; index <= MAX_ALARMS; index++) {
              if (GET_ALARM_DISPENSER_0_STATE(1))
            } */
            // - Hacer loop a través de las alarmas como en update_alarm
            // - Revisar si la alarma actual se activa en este minuto
            // - Si se activa, enviar señal a PIC secundario para activar dispensadores
  }
}

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

    check_alarms();
    delay_ms(250);

    // Alarma número 5, motores 2,1 prendidos 0 apagado, activa, 11:35
    fakeAlarm[0] = 0x5D; // 0101 1101
    fakeAlarm[1] = 0x11; 
    fakeAlarm[2] = 0x35;
    UART1_Write_Text("Enviando alarma");
    update_alarm(fakeAlarm);
  }
  // Shutdown
}