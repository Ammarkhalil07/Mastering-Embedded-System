#include "uart.h"

#define UART0DR *((volatile unsigned int *const) ((unsigned int*)0x101f100))

void uart_send_string(unsigned char *txbuff)
{
    while(*txbuff != '\0')
    {
        UART0DR = (unsigned int)(*txbuff) ;
        txbuff++;
    }
}