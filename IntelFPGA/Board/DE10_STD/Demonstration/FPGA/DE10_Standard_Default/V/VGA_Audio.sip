set_global_assignment -entity "VGA_Audio" -library "lib_VGA_Audio" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "VGA_Audio" -library "lib_VGA_Audio" -name IP_TOOL_VERSION "16.1"
set_global_assignment -entity "VGA_Audio" -library "lib_VGA_Audio" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_VGA_Audio" -name SPD_FILE [file join $::quartus(sip_path) "VGA_Audio.spd"]

set_global_assignment -library "lib_VGA_Audio" -name MISC_FILE [file join $::quartus(sip_path) "VGA_Audio_sim/VGA_Audio.vo"]
