#@Copyright : Ammar Khalil
#Dependices $<
#Target $@
#Generic using " %. "
 
##Toolchain
CC=arm-none-eabi-
##Options i need in my command
CFLAGS=-mcpu=arm926ej-s
##includes files directory
INCS=-I .
##libraries
LIBS=
##wild card SRC All .c files in directory
SRC=$(wildcard *.c)
##Here you could replace all the .c files in the directory to .o file directly
OBJ=$(SRC:.c=.o)
##The assembly
As=$(wildcard *.s)
AsOBJ=$(As:.s=.o)
##the outputfile name
Project_name=Learn-in-depth

all: $(Project_name).bin
	@echo "<====Building is Done!====>"

startup.o : startup.s
	$(CC)as.exe $(CFLAGS) $< -o $@

%.o : %.c
	$(CC)gcc.exe -c -g $(CFLAGS) $(INCS)  $< -o $@

$(Project_name).elf: $(OBJ) $(AsOBJ)
	$(CC)ld.exe -T linkerscript.ld $(LIBS) $(OBJ) $(AsOBJ) -o $@

$(Project_name).bin: $(Project_name).elf
	$(CC)objcopy -O binary $< $@

clean_all:
	rm *.o *.elf *.bin

clean:
	rm *.elf *.bin
