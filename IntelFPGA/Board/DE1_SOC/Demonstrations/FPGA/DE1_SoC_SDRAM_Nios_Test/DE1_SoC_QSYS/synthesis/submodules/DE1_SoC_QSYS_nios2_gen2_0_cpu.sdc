# Legal Notice: (C)2016 Altera Corporation. All rights reserved.  Your
# use of Altera Corporation's design tools, logic functions and other
# software and tools, and its AMPP partner logic functions, and any
# output files any of the foregoing (including device programming or
# simulation files), and any associated documentation or information are
# expressly subject to the terms and conditions of the Altera Program
# License Subscription Agreement or other applicable license agreement,
# including, without limitation, that your use is for the sole purpose
# of programming logic devices manufactured by Altera and sold by Altera
# or its authorized distributors.  Please refer to the applicable
# agreement for further details.

#**************************************************************
# Timequest JTAG clock definition
#   Uncommenting the following lines will define the JTAG
#   clock in TimeQuest Timing Analyzer
#**************************************************************

#create_clock -period 10MHz {altera_reserved_tck}
#set_clock_groups -asynchronous -group {altera_reserved_tck}

#**************************************************************
# Set TCL Path Variables 
#**************************************************************

set 	DE1_SoC_QSYS_nios2_gen2_0_cpu 	DE1_SoC_QSYS_nios2_gen2_0_cpu:*
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_oci 	DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_oci:the_DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_oci
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_break 	DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_oci_break:the_DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_oci_break
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_ocimem 	DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_ocimem:the_DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_ocimem
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_debug 	DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_oci_debug:the_DE1_SoC_QSYS_nios2_gen2_0_cpu_nios2_oci_debug
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_wrapper 	DE1_SoC_QSYS_nios2_gen2_0_cpu_debug_slave_wrapper:the_DE1_SoC_QSYS_nios2_gen2_0_cpu_debug_slave_wrapper
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_tck 	DE1_SoC_QSYS_nios2_gen2_0_cpu_debug_slave_tck:the_DE1_SoC_QSYS_nios2_gen2_0_cpu_debug_slave_tck
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sysclk 	DE1_SoC_QSYS_nios2_gen2_0_cpu_debug_slave_sysclk:the_DE1_SoC_QSYS_nios2_gen2_0_cpu_debug_slave_sysclk
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_path 	 [format "%s|%s" $DE1_SoC_QSYS_nios2_gen2_0_cpu $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci]
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_break_path 	 [format "%s|%s" $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_path $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_break]
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_ocimem_path 	 [format "%s|%s" $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_path $DE1_SoC_QSYS_nios2_gen2_0_cpu_ocimem]
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_debug_path 	 [format "%s|%s" $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_path $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_debug]
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_tck_path 	 [format "%s|%s|%s" $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_path $DE1_SoC_QSYS_nios2_gen2_0_cpu_wrapper $DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_tck]
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sysclk_path 	 [format "%s|%s|%s" $DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_path $DE1_SoC_QSYS_nios2_gen2_0_cpu_wrapper $DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sysclk]
set 	DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sr 	 [format "%s|*sr" $DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_tck_path]

#**************************************************************
# Set False Paths
#**************************************************************

set_false_path -from [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_break_path|break_readreg*] -to [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_debug_path|*resetlatch]     -to [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sr[33]]
set_false_path -from [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_debug_path|monitor_ready]  -to [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sr[0]]
set_false_path -from [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_debug_path|monitor_error]  -to [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sr[34]]
set_false_path -from [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_ocimem_path|*MonDReg*] -to [get_keepers *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sr*]
set_false_path -from *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sr*    -to *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sysclk_path|*jdo*
set_false_path -from sld_hub:*|irf_reg* -to *$DE1_SoC_QSYS_nios2_gen2_0_cpu_jtag_sysclk_path|ir*
set_false_path -from sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1] -to *$DE1_SoC_QSYS_nios2_gen2_0_cpu_oci_debug_path|monitor_go
