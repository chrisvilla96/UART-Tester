#line 1 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
#line 10 "C:/Users/Chris/Documents/Graduation-Project/UART-Tester/main.c"
void led_routine() {
 int i;
 for (i=0; i<2; i++){
  PORTB.RB7  = 1;
 delay_ms(1000);
  PORTB.RB7  = 0;
 delay_ms(1000);

 }
}

char dato;

void main() {
 char fakeAlarm[3];

 TRISB = 0;
 PORTB = 0x00;


 UART1_Init(9600);
 UART1_Write_Text("Inicializado");
 delay_ms(100);

 led_routine();

 while (1) {

 if (UART1_Data_Ready() == 1) {
 dato = UART1_Read();
 }

 switch (dato) {
 case 'a':
  PORTB.RB7  = 1;
 break;

 default:
  PORTB.RB7  = 0;
 break;
 }

 delay_ms(100);
 }
}
