#!/bin/bash
iverilog -g2012 i2s_core.v i2s_tb.sv -o i2s.vvp
vvp i2s.vvp
gtkwave i2s.vcd

