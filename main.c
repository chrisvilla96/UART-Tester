#include "constants.h" 
#include "macros.h"
#include "utils.h"
#include "timeModule.h"
#include "alarms.h"

char alarms[MAX_ALARMS * ALARM_BYTE_LENGTH];
char fakeHour = 0x12;
char fakeMinute = 0x34;
char fakeSeconds = 0;

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
}

void checkAlarms() {
  char alarmIndex;
  
  if (fakeSeconds != 0) return;

  for (alarmIndex = 0; alarmIndex < MAX_ALARMS; alarmIndex++) {
    char alarmOffset = alarmIndex * ALARM_BYTE_LENGTH;
    char flags = LS_NIBBLE(alarms[alarmOffset + ALARM_FLAG_BYTE]);
    char alarmActive = flags & ALARM_FLAG_ACTIVE;
    char alarmHours, alarmMinutes;
    writeTextToLCD("Indice ");
    writeBCDToLCD(alarmIndex);

    if (!alarmActive) continue;

    alarmHours = alarms[alarmOffset + ALARM_HOUR_BYTE];
    alarmMinutes = alarms[alarmOffset + ALARM_MINUTE_BYTE];

    if (alarmHours == fakeHour && alarmMinutes == fakeMinute) {
      writeTextToLCD("Alarma activa");
      writeBCDToLCD(alarmIndex);
      delay_ms(1000);
    }
  }

  delay_ms(1000);
  writeTextToLCD("");
}

void mainLoop() {
  checkAlarms();
  fakeMinute++;
  
  if (fakeMinute > 59) {
    fakeMinute = 0;
  }
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