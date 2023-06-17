#!/bin/bash
gcc gen_seed.c -o gen_seed.out
./gen_seed.out
#iverilog -D DUMP_WAVE uart_core_tb.v ../../uart_core.v ../../rx_core.v ../../tx_core.v -o uart_core.vvp
iverilog uart_core_tb.v ../../rx_core.v ../../uart_core.v ../../tx_core.v -o uart_core.vvp 
vvp ./uart_core.vvp 
#gtkwave ./uart_core.vcd

