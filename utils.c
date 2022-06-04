#include "macros.h"
#include "utils.h"

void writeBCDToLCDTimed(char ref, const int millis)
{
    char msn = MS_NIBBLE(ref);
    char lsn = LS_NIBBLE(ref);

    Lcd_out(2, 1, "d                ");
    Lcd_out(2, 1, "d ");
    
    Lcd_chr_cp(msn + 0x30);
    Lcd_chr_cp(lsn + 0x30);

    delay_ms(1000);
}

void writeBCDToLCD(char ref)
{
  writeBCDToLCDTimed(ref, 1000);
}

void writeBytesToLCDTimed(char ref, const int millis)
{
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

void writeBytesToLCD(char ref)
{
  writeBytesToLCDTimed(ref, 1000);
}