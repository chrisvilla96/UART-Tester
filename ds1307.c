#include "ds1307.h"

void write_ds1307(
    unsigned char direccion_esclavo,
    unsigned char direccion_memoria,
    unsigned char dato
)
{
    I2C1_Start();
    I2C1_Wr(direccion_esclavo);
    I2C1_Wr(direccion_memoria); // MEMORIA L
    I2C1_Wr(dato);              // DATO
    I2C1_Stop();
}

int read_ds1307(
    unsigned char direccion_esclavo,
    unsigned char direccion_memoria
)
{
    int valor;
    I2C1_Start();
    I2C1_Wr(direccion_esclavo);
    I2C1_Wr(direccion_memoria); // MEMORIA L
    I2C1_Repeated_Start();
    I2C1_Wr(direccion_esclavo + 1);
    valor = I2C1_Rd(0);
    I2C1_Stop();
    return valor;
}

void set_data_ds1307(
    int second, 
    int minute, 
    int hour,
    int day,
    int week_day, 
    int month, 
    int year
)
{
    write_ds1307(0xD0, 0, Dec2Bcd(second));
    write_ds1307(0xD0, 1, Dec2Bcd(minute));
    write_ds1307(0xD0, 2, Dec2Bcd(hour));
    write_ds1307(0xD0, 3, Dec2Bcd(day));
    write_ds1307(0xD0, 4, Dec2Bcd(week_day));
    write_ds1307(0xD0, 5, Dec2Bcd(year));

}

char RTC_Read_Clock_Tine_Element(char element)
{   
    I2C_Start();
    I2C_Write(DEVICE_ID_WRITE);
    I2C_Write(element); /* address from where time needs to be read*/
    I2C1_Repeated_Start();
    I2C_Write(DEVICE_ID_READ);
    return I2C_Read(1); /* hours > read data and send nack for indicating stop reading*/
}

char RTC_Read_Clock_Seconds()
{
    return RTC_Read_Clock_Tine_Element(TIME_ELEMENT_SECOND);
}