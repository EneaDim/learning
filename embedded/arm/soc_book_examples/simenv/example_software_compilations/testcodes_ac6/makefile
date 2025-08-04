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
# Purpose: Makefile for Arm Compiler 6
# ----------------------------------------------

INC_DIR1 = ../cmsis_include
INC_DIR2 = .
USER_DEF =
ARM_CC_OPTS  = --target=arm-arm-none-eabi -mcpu=cortex-m3 -c -O3 -g -I $(INC_DIR1) -I $(INC_DIR2) 
ARM_ASM_OPTS = --cpu Cortex-M3 -g
ARM_LINK_OPTS = "--keep=startup_cm3_mcu.o(RESET)" "--first=startup_cm3_mcu.o(RESET)" \
		--force_scanlib --rw_base 0x20000000 --ro_base 0x00000000 --map

all: hello.hex hello.lst
hello.o: hello.c
	armclang $(ARM_CC_OPTS) $< -o  $@

system_cm3_mcu.o: system_cm3_mcu.c
	armclang $(ARM_CC_OPTS) $< -o  $@

uart_util.o: uart_util.c
	armclang $(ARM_CC_OPTS) $< -o  $@

retarget_io.o: retarget_io.c RTE_Components.h
	armclang $(ARM_CC_OPTS) $< -o  $@

startup_cm3_mcu.o: startup_cm3_mcu.s
	armasm $(ARM_ASM_OPTS) $< -o  $@

hello.elf: hello.o system_cm3_mcu.o uart_util.o retarget_io.o startup_cm3_mcu.o
	armlink hello.o system_cm3_mcu.o uart_util.o retarget_io.o startup_cm3_mcu.o $(ARM_LINK_OPTS) -o $@

hello.hex : hello.elf
	fromelf --vhx --8x1 $< --output $@


hello.lst : hello.elf
	fromelf -c -d -e -s $< --output $@

clean:
	rm *.o
	rm *.elf
	rm *.lst
	rm *.hex
