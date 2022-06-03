#define DEVICE_ID_WRITE 0xD0
#define DEVICE_ID_READ 0xD1

#define TIME_ELEMENT_SECOND 0

void write_ds1307(
    
    unsigned char direccion_esclavo, 
    unsigned char direccion_memoria, 
    unsigned char dato
);

int read_ds1307(
    unsigned char direccion_esclavo, 
    unsigned char direccion_memoria
);

void set_data_ds1307(
    int second,
    int minute,
    int hour,
    int day,
    int week_day,
    int month,
    int year
);

char RTC_Read_Clock_Seconds();