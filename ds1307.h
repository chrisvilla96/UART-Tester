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
    int segundos, 
    int minutos, 
    int hora,
    int dia_semana, 
    int dia, 
    int mes, 
    int ano
);