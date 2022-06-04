#include "constants.h" 
#include "macros.h"
#include "utils.h"
#include "timeModule.h"
#include "alarms.h"

char alarms[MAX_ALARMS * ALARM_BYTE_LENGTH];

void initializeLCDModule() {
  Lcd_init();
  Lcd_cmd(12);
  delay_ms(100);
  Lcd_Cmd(_LCD_CLEAR); // Clears Display
}

void initializaDS1307Module() {
}

void dumpAlarms() {
  char index;
  for (index = 0; index < MAX_ALARMS; index++) {
    char offset = index * ALARM_BYTE_LENGTH;
    writeBytesToLCD(0b11111111);
    writeBytesToLCD(alarms[offset + ALARM_FLAG_BYTE]);
    writeBytesToLCD(alarms[offset + ALARM_HOUR_BYTE]);
    writeBytesToLCD(alarms[offset + ALARM_MINUTE_BYTE]);
  }
}


void setAlarm(char index, char flags, char bcd_hour, char bcd_minute) {
  if (0 <= index && index <= MAX_ALARMS) {
    char offset = index * ALARM_BYTE_LENGTH;
    alarms[offset + ALARM_FLAG_BYTE] = flags;
    alarms[offset + ALARM_HOUR_BYTE] = bcd_hour;
    alarms[offset + ALARM_MINUTE_BYTE] = bcd_minute;
  }
}

void initializeAlarms() {
  char index;
  char totalIterations = MAX_ALARMS * ALARM_BYTE_LENGTH;
  for (index = 0; index < totalIterations; index++) {
    alarms[index] = 0x00;
  }
}

void initialize() {
  char index;
  char totalIterations = MAX_ALARMS * ALARM_BYTE_LENGTH;
  initializeLCDModule();
  initializeAlarms();
  setAlarm(
    1,  
    ALARM_FLAG_DISPENSER_2 | ALARM_FLAG_DISPENSER_0 | ALARM_FLAG_ACTIVE, 
    0x12, 
    0x34
  );
  dumpAlarms();
}

void checkAlarms() {
}

void mainLoop() {
  char stuff = 0b01011101;
  char index = 0;

  checkAlarms();
}

void finalize() {}

void main() {
  // Perform initialization{
  initialize();

  // Main application loop;
  while(TRUE) {
    mainLoop();
  }

  // Cleanup
  finalize();
}