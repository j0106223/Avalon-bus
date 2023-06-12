#!/bin/bash
gcc gen_seed.c -o gen_seed.out
./gen_seed.out
iverilog tx_core_tb.v ../tx_core.v -o tx_core.vvp
vvp ./tx_core.vvp
gtkwave ./tx_core.vcd

