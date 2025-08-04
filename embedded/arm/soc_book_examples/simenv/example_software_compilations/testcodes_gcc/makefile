# ----------------------------------------------
# Example code for
#
# System-on-Chip Design with Arm(R) Cortex(R)-M 
# Processors
#
# Reference Book
#	   by Joseph Yiu, 2019 (first edition)
# 
# ISBN: 978-1-911531-19-7
# Arm Education Media
# https://www.armedumedia.com
#
# Disclaimer
# This example design is created for educational
# purpose only and are not validated to the same 
# quality level as Arm IP products. 
# Arm Education Media and author do not make any 
# warranties of these designs.
# ----------------------------------------------
# Purpose: Makefile for gcc (Arm GNU Embedded toolchain)
# ----------------------------------------------


INC_DIR1 = ../cmsis_include
INC_DIR2 = .
USER_DEF =
CC_OPTS  = -mthumb -mcpu=cortex-m3 -O3 -g -I $(INC_DIR1) -I $(INC_DIR2) 
LINKER_SCRIPT_PATH = .
LINKER_SCRIPT = mem.ld
LINK_OPTS = -T $(LINKER_SCRIPT)

all: hello.hex hello.lst

hello.elf: hello.c system_cm3_mcu.c uart_util.c retarget_gcc.c startup_cm3_mcu.S
	arm-none-eabi-gcc $(CC_OPTS) hello.c system_cm3_mcu.c \
		uart_util.c retarget_gcc.c startup_cm3_mcu.S \
		-L $(LINKER_SCRIPT_PATH) $(LINK_OPTS) -o $@

hello.hex : hello.elf
	arm-none-eabi-objcopy -S hello.elf -O verilog  $@

hello.lst : hello.elf
	arm-none-eabi-objdump -S hello.elf > $@

clean:
	rm *.elf
	rm *.lst
	rm *.hex
	
