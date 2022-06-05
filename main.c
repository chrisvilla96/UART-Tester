#include "constants.h" 
#include "macros.h"
#include "utils.h"
#include "timeModule.h"
#include "ds1307.h"
#include "alarms.h"

char alarms[MAX_ALARMS * ALARM_BYTE_LENGTH];
char fakeHour = 0x12;
char fakeMinute = 0x34;
char fakeSeconds = 0;


// PROCESSING FUNCTIONS
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

void activateDispenser(char flags) {
  writeTextToLCD("Activo putos!");
  delay_ms(500);
  writeBytesToLCD(flags);
  writeBytesToLCD((flags & 0x0F));
  delay_ms(500);
}

void checkAlarms() {
  char alarmIndex;
  char realTimeHours, realTimeMinutes, realTimeSeconds;

  // Gets curent time from DS1307
  realTimeSeconds = read_ds1307(0xD0, 0);
  realTimeMinutes = read_ds1307(0xD0, 1);
  realTimeHours = read_ds1307(0xD0, 2);

  // Sends Current Time to LCD
  sendsTimeDataToLCD(
    realTimeSeconds, 
    realTimeMinutes, 
    realTimeHours
  );

  // writeBCDToLCD(realTimeSeconds);

  if (realTimeSeconds != 0) return;

  for (alarmIndex = 0; alarmIndex < MAX_ALARMS; alarmIndex++) {
    char alarmOffset = alarmIndex * ALARM_BYTE_LENGTH;
    char flags = LS_NIBBLE(alarms[alarmOffset + ALARM_FLAG_BYTE]);
    char alarmActive = flags & ALARM_FLAG_ACTIVE;
    char alarmHours, alarmMinutes;
  
    if (!alarmActive) continue;

    alarmHours = alarms[alarmOffset + ALARM_HOUR_BYTE];
    alarmMinutes = alarms[alarmOffset + ALARM_MINUTE_BYTE];

    if (alarmHours == realTimeHours && alarmMinutes == realTimeMinutes)
    {
      activateDispenser((ALARM_FLAG_ALL_DISPENSERS & flags) >> 0x01);
    }
  }

  delay_ms(1000);
}

void UARTgetAlarm() {
  char inputBuffer[ALARM_PACKET_LENGTH];

  if (UART1_Data_Ready() == 1) {
    UART1_Read_Text(&inputBuffer, ";", ALARM_PACKET_LENGTH + 1);
    writeTextToLCD("Dato recibido");
  }

  if (strlen(inputBuffer) == 3) {
      char alarmDataIndex, alarmDataFlags, alarmDataHours, alarmDataMinutes;

      alarmDataIndex = GET_ALARM_INDEX(inputBuffer[ALARM_FLAG_BYTE]);
      alarmDataFlags = GET_ALARM_FLAGS(inputBuffer[ALARM_FLAG_BYTE]);

      alarmDataHours = inputBuffer[ALARM_HOUR_BYTE];
      alarmDataMinutes = inputBuffer[ALARM_MINUTE_BYTE];

      setAlarm(
        alarmDataIndex,
        alarmDataFlags,
        alarmDataHours,
        alarmDataMinutes
      );
  }
}

// INIT FUNCTIONS

void initializeLCDModule() {
  Lcd_init();
  Lcd_cmd(12);
  delay_ms(100);
  Lcd_Cmd(_LCD_CLEAR); // Clears Display
}

void initializeBluetoothModule() {
  UART1_Init(9600);
}

void initializaDS1307Module() {
  I2C1_Init(100000);
}

void initializeAlarms() {
  char index;
  char totalIterations = MAX_ALARMS * ALARM_BYTE_LENGTH;
  for (index = 0; index < totalIterations; index++)
  {
    alarms[index] = 0x00;
  }
}

void initialize() {
  char index;
  char totalIterations = MAX_ALARMS * ALARM_BYTE_LENGTH;
  initializeLCDModule();
  initializeAlarms();
  initializeBluetoothModule();
  initializaDS1307Module();
  setAlarm(
      1,
      ALARM_FLAG_DISPENSER_2 | ALARM_FLAG_DISPENSER_0 | ALARM_FLAG_ACTIVE,
      0x12,
      0x34);
}

void finalize() {}

void main() {
  // Perform initialization{
  initialize();

  // Sets DS1307 Module Time 11:49:50
  set_data_ds1307(50, 49, 11, 1, 1, 1, 18);

  // Sets fake alarm ID:1, Dispensers: [1,2,3], Hour: 11, Minute: 50 
  setAlarm(0x01, 0x0F, 0x11, 0x50);

  // Main application loop;
  while(TRUE) {
    UARTgetAlarm();
    checkAlarms();
    // Leer lista de alarmas activas
    // Enviar una por una al activador
    /*  
    fakeMinute++;
      
    if (fakeMinute > 59) {
      fakeMinute = 0;
    }
    */
  }
  // Cleanup
  finalize();
}