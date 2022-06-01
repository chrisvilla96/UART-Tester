/*
  PROGRAMA PARA PROBAR COMUNICACIÓN UART CON BT

  Se recibe un caracter via BT.
  En caso de que sea 'a', se enciende el LED en RB7
*/

#define LED PORTB.RB7

char dato;

void main() {
  char fakeAlarm[3];
  // Initialization
  TRISB = 0;
  PORTB = 0x00;
  //initialize_alarms();

  UART1_Init(9600);
  UART1_Write_Text("Inicializado");
  delay_ms(100);

  while (1) {
    
    if (UART1_Data_Ready() == 1) {
      dato = UART1_Read();
    }

    switch (dato) {
    case 'a':
      LED = 1;
      break;
    
    default:
      LED = 0;
      break;
    }

    delay_ms(100);
  }
}