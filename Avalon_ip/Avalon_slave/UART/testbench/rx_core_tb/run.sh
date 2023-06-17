#!/bin/bash
gcc gen_seed.c -o gen_seed.out
./gen_seed.out
#iverilog -D DUMP_WAVE rx_core_tb.v ../../rx_core.v ../../tx_core.v -o rx_core.vvp
iverilog rx_core_tb.v ../../rx_core.v ../../tx_core.v -o rx_core.vvp 
vvp ./rx_core.vvp 
#gtkwave ./rx_core.vcd

