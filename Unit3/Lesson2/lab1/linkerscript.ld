/*learn-in-depth
//unit3-lesson2-lab1
//Eng.AmmarKhalil
/*****************************************************/

ENTRY(reset)
MEMORY
{
    Mem (rwx) : ORIGIN = 0x00000000, LENGTH = 64M
}

SECTIONS
{
    . = 0x10000 ;
    .startup . : 
    {
        startup.o(.text)
    }>Mem
    .text :
    {
        *(.text) *(.rodata)
    }>Mem
    .data :
    {
        *(.data)
    }>Mem
    .bss :
    {
        *(.bss) *(.COMMON)
    }>Mem 
    . = . + 0x1000 ; 
    Stack_Top = . ;
}
