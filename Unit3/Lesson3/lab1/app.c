#include "uart.h"

unsigned char buff[100]="learn-in-depth:Ammar";
unsigned char const buff2[100]="learn-in-depth:Ammar";

void main(void) 
{
    uart_send_string(buff);
}  