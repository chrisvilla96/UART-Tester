#include "constants.h" 
#include "macros.h"
#include "utils.h"
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

void setAlarms() {}

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
}

void mainLoop() {
  char stuff = 0b01011101;
  char index = 0;

  writeBytesToLCD(stuff);
  writeBytesToLCD(MS_NIBBLE(stuff));
  writeBytesToLCD(LS_NIBBLE(stuff));
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