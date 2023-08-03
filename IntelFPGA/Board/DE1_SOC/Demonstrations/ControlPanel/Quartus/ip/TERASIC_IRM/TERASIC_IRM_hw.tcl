# TCL File Generated by Component Editor 12.1
# Fri Nov 30 13:39:04 CST 2012
# DO NOT MODIFY


# 
# TERASIC_IRM "TERASIC_IRM" v1.0
# null 2012.11.30.13:39:04
# 
# 

# 
# request TCL package from ACDS 12.1
# 
package require -exact qsys 12.1


# 
# module TERASIC_IRM
# 
set_module_property NAME TERASIC_IRM
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "Terasic Qsys Component/"
set_module_property DISPLAY_NAME TERASIC_IRM
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset quartus_synth QUARTUS_SYNTH "" "Quartus Synthesis"
set_fileset_property quartus_synth TOP_LEVEL TERASIC_IRM
set_fileset_property quartus_synth ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file TERASIC_IRM.v VERILOG PATH TERASIC_IRM.v
add_fileset_file irda_receive_terasic.v VERILOG PATH irda_receive_terasic.v

add_fileset sim_verilog SIM_VERILOG "" "Verilog Simulation"
set_fileset_property sim_verilog ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file TERASIC_IRM.v VERILOG PATH TERASIC_IRM.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point avalon_slave
# 
add_interface avalon_slave avalon end
set_interface_property avalon_slave addressAlignment NATIVE
set_interface_property avalon_slave addressUnits WORDS
set_interface_property avalon_slave associatedClock clock_sink
set_interface_property avalon_slave associatedReset clock_sink_reset
set_interface_property avalon_slave bitsPerSymbol 8
set_interface_property avalon_slave burstOnBurstBoundariesOnly false
set_interface_property avalon_slave burstcountUnits WORDS
set_interface_property avalon_slave explicitAddressSpan 0
set_interface_property avalon_slave holdTime 0
set_interface_property avalon_slave linewrapBursts false
set_interface_property avalon_slave maximumPendingReadTransactions 0
set_interface_property avalon_slave readLatency 0
set_interface_property avalon_slave readWaitStates 2
set_interface_property avalon_slave readWaitTime 2
set_interface_property avalon_slave setupTime 0
set_interface_property avalon_slave timingUnits Cycles
set_interface_property avalon_slave writeWaitTime 0
set_interface_property avalon_slave ENABLED true

add_interface_port avalon_slave s_read read Input 1
add_interface_port avalon_slave s_cs_n chipselect_n Input 1
add_interface_port avalon_slave s_readdata readdata Output 32
add_interface_port avalon_slave s_write write Input 1
add_interface_port avalon_slave s_writedata writedata Input 32
set_interface_assignment avalon_slave embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true

add_interface_port clock_sink clk clk Input 1


# 
# connection point clock_sink_reset
# 
add_interface clock_sink_reset reset end
set_interface_property clock_sink_reset associatedClock clock_sink
set_interface_property clock_sink_reset synchronousEdges DEASSERT
set_interface_property clock_sink_reset ENABLED true

add_interface_port clock_sink_reset reset_n reset_n Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock ""
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true

add_interface_port conduit_end ir export Input 1


# 
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint avalon_slave
set_interface_property interrupt_sender associatedClock clock_sink
set_interface_property interrupt_sender associatedReset clock_sink_reset
set_interface_property interrupt_sender ENABLED true

add_interface_port interrupt_sender irq irq Output 1
