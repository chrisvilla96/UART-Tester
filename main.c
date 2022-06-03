#include <stdio.h>
#include "constants.h"
#include "ds1307.h"
#include "lcd_connection.h"

#define TO_BOOL(X) (X > 0?1:0)

// Alarm Packet example

// Alarm macros
#define GET_ALARM_INDEX(X) ((X >> 4) & 0x0F);
#define GET_ALARM_ACTIVE_STATE(X) (X & ALARM_ID_MASK);
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
#define LED_7 PORTB.RB7

#define STATUS PORTC.RC2  

char inputBuffer[ALARM_PACKET_LENGTH]; // 3 bytes
char alarms[MAX_ALARMS * ALARM_PACKET_LENGTH]; // 30 bytes
char sentinel = 0;

void writeBCDToLCD(char ref) {
      Lcd_out(2, 1, "d                ");
      Lcd_out(2, 1, "d ");

      Lcd_chr_cp(((ref >> 4) & 0x0F) + 0x30);
      // Lcd_chr_cp(((ref >> 0) & 0x0F) + 0x30);
      Lcd_chr_cp((ref & 0x0F) + 0x30);
      delay_ms(1000);
}


void writeBytesToLCD(char ref) {
      Lcd_out(2, 1, "b                ");
      Lcd_Cmd(_LCD_CLEAR);
      Lcd_out(2, 1, "b ");
      Lcd_chr_cp(((ref >> 7) & 0x01) + 0x30);
      Lcd_chr_cp(((ref >> 6) & 0x01) + 0x30);
      Lcd_chr_cp(((ref >> 5) & 0x01) + 0x30);
      Lcd_chr_cp(((ref >> 4) & 0x01) + 0x30);
      Lcd_chr_cp(((ref >> 3) & 0x01) + 0x30);
      Lcd_chr_cp(((ref >> 2) & 0x01) + 0x30);
      Lcd_chr_cp(((ref >> 1) & 0x01) + 0x30);
      Lcd_chr_cp(((ref >> 0) & 0x01) + 0x30);
      delay_ms(1000);
}


// 
void updateSentinel() {
  PORTB = ++sentinel;
}

void init_led() {
  int i;
  for (i = 0; i < 2; i++)
  {
    STATUS = 1;
    delay_ms(1000);
    STATUS = 0;
    delay_ms(1000);
  }
}


// Initialize every item on alarms array to 0
void initialize_alarms() {
  // Byte accounting base + 1
  char index; 
  for (index = 0; index <= (MAX_ALARMS * ALARM_PACKET_LENGTH); index++) {
    alarms[index] = 0;
  }
}


// Updates alarms array by receiving a packet lengths
void update_alarm(char alarm_data[ALARM_PACKET_LENGTH]) {
  // Byte accounting base + 3
  char alarm_index = GET_ALARM_INDEX(alarm_data[0]);

  if (0 <= alarm_index && alarm_index <= MAX_ALARMS) {
    char offset = alarm_index * ALARM_PACKET_LENGTH;

    alarms[offset + ALARM_FLAG_BYTE_OFFSET] = alarm_data[ALARM_FLAG_BYTE_OFFSET];
    alarms[offset + ALARM_HOUR_BYTE_OFFSET] = alarm_data[ALARM_HOUR_BYTE_OFFSET];
    alarms[offset + ALARM_MINUTE_BYTE_OFFSET] = alarm_data[ALARM_MINUTE_BYTE_OFFSET];
    /*
    
    Lcd_chr_cp(Bcd2Dec(alarms[offset + ALARM_FLAG_BYTE_OFFSET]) / 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarms[offset + ALARM_FLAG_BYTE_OFFSET]) % 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarms[offset + ALARM_HOUR_BYTE_OFFSET]) / 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarms[offset + ALARM_HOUR_BYTE_OFFSET]) % 10 + 0x30); 
    Lcd_chr_cp(Bcd2Dec(alarms[offset + ALARM_MINUTE_BYTE_OFFSET]) / 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarms[offset + ALARM_MINUTE_BYTE_OFFSET]) % 10 + 0x30);
    */

    Lcd_out(2, 1, "SA_");
    Lcd_chr_cp(Bcd2Dec(alarm_data[0]) / 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarm_data[0]) % 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarm_data[1]) / 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarm_data[1]) % 10 + 0x30); 
    Lcd_chr_cp(Bcd2Dec(alarm_data[2]) / 10 + 0x30);
    Lcd_chr_cp(Bcd2Dec(alarm_data[2]) % 10 + 0x30);
    Lcd_chr_cp('|');
    delay_ms(2000);
  }

  


  PORTB = 0x0F;
  delay_ms(500);
  PORTB = 0x00;
  delay_ms(500);
}

// Activates Dispensers by reading packet flags
void activate_dispensers(char dispenser_flags) {
  PORTB = dispenser_flags;
  PORTB = 0x0F;
  delay_ms(500);
  PORTB = 0x00;
  delay_ms(500);
  delay_ms(1500);
}

void check_alarms() {
  char hours;
  char minutes;
  char seconds;
  char alarm_index;

  seconds = read_ds1307(0xD0, 0);  // reads seconds from DS1307 in BCD
  minutes = read_ds1307(0xD0, 1);  // reads minutes from DS1307 in BCD
  hours = read_ds1307(0xD0, 2);    // reads hours from DS1307 in BCD

  if (seconds == 0x00) {
    Lcd_out(2, 1, "Estamos en 0 segundos");

    for (alarm_index = 0; alarm_index <= MAX_ALARMS; alarm_index++) {
      char current_alarm_hour;
      char current_alarm_minute;
      char otro;

      Lcd_out(2, 1, "CA");
      Lcd_chr_cp(alarm_index + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 7) & 0x01) + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 6) & 0x01) + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 5) & 0x01) + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 4) & 0x01) + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 3) & 0x01) + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 2) & 0x01) + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 1) & 0x01) + 0x30);
      Lcd_chr_cp(((alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] >> 0) & 0x01) + 0x30);
      delay_ms(1000);

      if (!(alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET] & ALARM_FLAG_BYTE_OFFSET)) {
        continue;
      }

      Lcd_out(2, 1, "alrm actv");
      Lcd_chr_cp(alarm_index + 0x30);
      delay_ms(1000);

      // Gets the alarm minute and hour
      current_alarm_hour = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];
      current_alarm_minute = alarms[alarm_index + ALARM_HOUR_BYTE_OFFSET];

      Lcd_out(2, 1, "t:");
      Lcd_chr_cp(Bcd2Dec(current_alarm_hour) / 10 + 0x30);
      Lcd_chr_cp(Bcd2Dec(current_alarm_minute) % 10 + 0x30);
      Lcd_chr_cp(Bcd2Dec(current_alarm_minute) / 10 + 0x30);
      Lcd_chr_cp(Bcd2Dec(current_alarm_minute) % 10 + 0x30);
      Lcd_chr_cp(',');
      Lcd_chr_cp(Bcd2Dec(hours) / 10 + 0x30);
      Lcd_chr_cp(Bcd2Dec(hours) % 10 + 0x30);
      Lcd_chr_cp(Bcd2Dec(minutes) / 10 + 0x30);
      Lcd_chr_cp(Bcd2Dec(minutes) % 10 + 0x30);
      delay_ms(1000);

      // Checks if the hour and minute matches with the alarm data
      if (current_alarm_hour == hours && current_alarm_minute == minutes) {
        // Gets the current alarm flags data
        char current_alarm_flags = alarms[alarm_index + ALARM_FLAG_BYTE_OFFSET];
        // Gets enabled motor flags
        current_alarm_flags = (current_alarm_flags >> 1) & 0x07;

        // Activates the dispenser with motor flagss
        activate_dispensers(current_alarm_flags);
      }
    }
  }
}

void check_ds1307() {
  char seconds;

  while (TRUE) {
    PORTB = 0x00;
    seconds = RTC_Read_Clock_Seconds();
    PORTB = seconds; // 0011 0101
    delay_ms(1000);
  }
  
  

  
  // ds1307_minutes = read_ds1307(0xD0, 1); // reads seconds from DS1307
  // ds1307_hours = read_ds1307(0xD0, 2);   // reads seconds from DS1307

  

  // PORTB = 0x00;
  // delay_ms(1000);

  // PORTB = ds1307_hours;
  // delay_ms(500);

  // check_alarms();
  // ds1307_seconds = read_ds1307(0xD0, 0);
  // PORTB = ds1307_seconds; // 0011 1001
  // delay_ms(2000);

  // PORTB = 0x00;
  // delay_ms(1000);
}

// Send time data to LCD Display
void sends_data_to_lcd(char second, char minute, char hour) {
  /*
  Lcd_out(1, 1, "HORA: ");
  Lcd_chr_cp((hour / 10) + 48);
  Lcd_chr_cp((hour % 10) + 48);
  Lcd_chr_cp(':');
  Lcd_chr_cp((minute / 10) + 48);
  Lcd_chr_cp((minute % 10) + 48);
  Lcd_chr_cp(':');
  Lcd_chr_cp((second / 10) + 48);
  Lcd_chr_cp((second % 10) + 48);
  */
  Lcd_out(1, 1, "HORA: ");
  Lcd_chr_cp(Bcd2Dec(hour)/10 + 0x30);
  Lcd_chr_cp(Bcd2Dec(hour)%10 + 0x30);
  Lcd_chr_cp(':');
  Lcd_chr_cp(Bcd2Dec(minute) / 10 + 0x30);
  Lcd_chr_cp(Bcd2Dec(minute) % 10 + 0x30);
  Lcd_chr_cp(':');
  Lcd_chr_cp(Bcd2Dec(second) / 10 + 0x30);
  Lcd_chr_cp(Bcd2Dec(second) % 10 + 0x30);
}

// reads hours and minutes from DS1307
char ds1307_seconds;
char ds1307_minutes;
char ds1307_hours;




void main() {
  char fakeAlarm[3];
  char loopIndex = 0;
  // Initialization
  TRISB = 0;
  PORTB = 0x00;

  // Status LED Initializations
  TRISC.RC2 = 0;
  PORTC.RC2 = 0;
  initialize_alarms();
  // updateSentinel(); // 1

  UART1_Init(9600);
  // updateSentinel(); // 2
  UART1_Write_Text("Inicializado\n");
  // updateSentinel(); // 3
  delay_ms(100);

  // LCD Inicialización
  Lcd_init();
  Lcd_cmd(12);
  delay_ms(100);
  Lcd_Cmd(_LCD_CLEAR); // Clears Display

  // DS1307 Initialize
  I2C1_Init(100000);
  delay_ms(100);
  // updateSentinel(); // 4

  // segundo, minuto, hora, día_semana, día, mes, año
  UART1_Write_Text("ANTES DE SET DATA\n");
  // updateSentinel(); // 5
  // set_data_ds1307(segundos, minutos, hora, dia, mes, ano);
  // updateSentinel(); // 6
  // Set DS1307 11:34:45
  set_data_ds1307(45, 34, 11, 1, 1, 1, 18);
  // updateSentinel(); // 7

  UART1_Write_Text("Despues DE SET DATA\n");

  // init_led();
  // updateSentinel(); // 8

  // Alarma número 5, motores 2,1 prendidos 0 apagado, activa, 11:35
  fakeAlarm[0] = 0x5D; // 0101 1101
  fakeAlarm[1] = 0x11; 
  fakeAlarm[2] = 0x35;

  // sends_data_to_lcd(fakeAlarm[0], fakeAlarm[1], fakeAlarm[2]);
  delay_ms(1500);
  UART1_Write_Text("Enviando alarma");
  update_alarm(fakeAlarm);
  // updateSentinel();

  writeBytesToLCD(fakeAlarm[0]);
  writeBCDToLCD(fakeAlarm[0]);
  // writeBCDToLCD(0x23);
  
  // Alarm read loop
  while (TRUE)
  {
    // updateSentinel();

    // check_ds1307();
    /*
    UART1_Write_Text("Main loop");
    
    if (UART1_Data_Ready() == 1) {
      UART1_Read_Text(inputBuffer, ";", ALARM_PACKET_LENGTH + 1);
    }

    if (strlen(inputBuffer) == 3) {
      update_alarm(inputBuffer);
    }
    */
    //update_alarm(fakeAlarm);

    //ds1307_seconds = read_ds1307(0xD0, 0);  // reads seconds from DS1307
    //ds1307_minutes = read_ds1307(0xD0, 1);  // reads minutess from DS1307
    //ds1307_hours = read_ds1307(0xD0, 2);  // reads minutess from DS1307

    // sends_data_to_lcd(ds1307_seconds, ds1307_minutes, ds1307_hours);
    // init_led();
    check_alarms();
    delay_ms(500);
  }
  // Shutdown
}