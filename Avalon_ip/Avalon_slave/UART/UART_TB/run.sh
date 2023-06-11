#!/bin/bash
iverilog tx_core_tb.v ../tx_core.v
vvp ./a.out

