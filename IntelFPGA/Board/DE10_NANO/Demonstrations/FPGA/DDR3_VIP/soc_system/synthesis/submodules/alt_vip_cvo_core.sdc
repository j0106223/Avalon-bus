# (C) 2001-2016 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


proc alt_vip_get_timequest_name {hier_name} {
	set sta_name ""
	for {set inst_start [string first ":" $hier_name]} {$inst_start != -1} {set inst_start [string first ":" $hier_name $inst_start]} {
		incr inst_start
		set inst_end [string first "|" $hier_name $inst_start]
		if {$inst_end == -1} {
			append sta_name [string range $hier_name $inst_start end]
		} else {
			append sta_name [string range $hier_name $inst_start $inst_end]
		}
	}
	return $sta_name
}

proc alt_vip_get_core_instance_list {corename} {
	set full_instance_list [alt_vip_get_core_full_instance_list $corename]
	set instance_list [list]

	foreach inst $full_instance_list {
		set sta_name [alt_vip_get_timequest_name $inst]
		if {[lsearch $instance_list $sta_name] == -1} {
			lappend instance_list $sta_name
		}
	}
	return $instance_list
}

proc alt_vip_get_core_full_instance_list {corename} {
	set instance_list [list]

	# Look for a keeper (register) name
	# Try mem_clk[0] to determine core instances
	set search_list [list "*"]
	set found 0
	for {set i 0} {$found == 0 && $i != [llength $search_list]} {incr i} {
		set pattern [lindex $search_list $i]
		set instance_collection [get_keepers -nowarn "*|${corename}:*|$pattern"]
		if {[get_collection_size $instance_collection] == 0} {
			set instance_collection [get_keepers "${corename}:*|$pattern"]
		}
		if {[get_collection_size $instance_collection] > 0} {
			set found 1
		}
	}
	# regexp to extract the full hierarchy path of an instance name
	set inst_regexp {(^.*}
	append inst_regexp ${corename}
	append inst_regexp {:[A-Za-z0-9\.\\_\[\]\-\$()]+)\|}
	foreach_in_collection inst $instance_collection {
		set name [get_node_info -name $inst]
		if {[regexp -- $inst_regexp $name -> hier_name] == 1} {
			if {[lsearch $instance_list $hier_name] == -1} {
				lappend instance_list $hier_name
			}
		}
	}
	return $instance_list
}

set corename "alt_vip_cvo_core"
set instance_list [alt_vip_get_core_instance_list $corename]

foreach inst $instance_list {
    
    set_multicycle_path -setup -start -through [get_nets "${inst}|mode_banks|u_calculate_mode_dynamic|*"] 2
    set_multicycle_path -hold -start -through [get_nets "${inst}|mode_banks|u_calculate_mode_dynamic|*"] 1

    set_max_delay -from [get_keepers "${inst}|mode_banks|interlaced_field_reg[*]"]     -to [get_keepers "${inst}|mode_banks|vid_interlaced_field[*]"]  100
    set_max_delay -from [get_keepers "${inst}|mode_banks|interlaced_reg"]              -to [get_keepers "${inst}|mode_banks|vid_interlaced"]           100
    set_max_delay -from [get_keepers "${inst}|mode_banks|h_total_minus_one_reg[*]"]    -to [get_keepers "${inst}|mode_banks|vid_h_total_minus_one[*]"] 100
    set_max_delay -from [get_keepers "${inst}|mode_banks|v_total_minus_one_reg[*]"]    -to [get_keepers "${inst}|mode_banks|vid_v_total_minus_one[*]"] 100
    set_max_delay -from [get_keepers "${inst}|mode_banks|h_blank_reg[*]"]              -to [get_keepers "${inst}|mode_banks|vid_h_blank[*]"]           100
    set_max_delay -from [get_keepers "${inst}|mode_banks|h_sync_start_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_h_sync_start[*]"]      100
    set_max_delay -from [get_keepers "${inst}|mode_banks|h_sync_end_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_h_sync_end[*]"]        100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f2_v_start_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_f2_v_start[*]"]        100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f1_v_start_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_f1_v_start[*]"]        100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f1_v_end_reg[*]"]             -to [get_keepers "${inst}|mode_banks|vid_f1_v_end[*]"]          100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f2_v_sync_start_reg[*]"]      -to [get_keepers "${inst}|mode_banks|vid_f2_v_sync_start[*]"]   100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f2_v_sync_end_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f2_v_sync_end[*]"]     100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f1_v_sync_start_reg[*]"]      -to [get_keepers "${inst}|mode_banks|vid_f1_v_sync_start[*]"]   100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f1_v_sync_end_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f1_v_sync_end[*]"]     100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f_rising_edge_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f_rising_edge[*]"]     100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f_falling_edge_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f_falling_edge[*]"]    100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f1_v_end_nxt_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_f1_v_end_nxt[*]"]      100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f2_anc_v_start_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f2_anc_v_start[*]"]    100
    set_max_delay -from [get_keepers "${inst}|mode_banks|f1_anc_v_start_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f1_anc_v_start[*]"]    100
    set_max_delay -from [get_keepers "${inst}|mode_banks|h_sync_polarity_reg"]         -to [get_keepers "${inst}|mode_banks|vid_h_sync_polarity"]      100
    set_max_delay -from [get_keepers "${inst}|mode_banks|v_sync_polarity_reg"]         -to [get_keepers "${inst}|mode_banks|vid_v_sync_polarity"]      100

    set_min_delay -from [get_keepers "${inst}|mode_banks|interlaced_field_reg[*]"]     -to [get_keepers "${inst}|mode_banks|vid_interlaced_field[*]"]  -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|interlaced_reg"]              -to [get_keepers "${inst}|mode_banks|vid_interlaced"]           -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|h_total_minus_one_reg[*]"]    -to [get_keepers "${inst}|mode_banks|vid_h_total_minus_one[*]"] -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|v_total_minus_one_reg[*]"]    -to [get_keepers "${inst}|mode_banks|vid_v_total_minus_one[*]"] -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|h_blank_reg[*]"]              -to [get_keepers "${inst}|mode_banks|vid_h_blank[*]"]           -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|h_sync_start_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_h_sync_start[*]"]      -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|h_sync_end_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_h_sync_end[*]"]        -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f2_v_start_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_f2_v_start[*]"]        -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f1_v_start_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_f1_v_start[*]"]        -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f1_v_end_reg[*]"]             -to [get_keepers "${inst}|mode_banks|vid_f1_v_end[*]"]          -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f2_v_sync_start_reg[*]"]      -to [get_keepers "${inst}|mode_banks|vid_f2_v_sync_start[*]"]   -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f2_v_sync_end_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f2_v_sync_end[*]"]     -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f1_v_sync_start_reg[*]"]      -to [get_keepers "${inst}|mode_banks|vid_f1_v_sync_start[*]"]   -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f1_v_sync_end_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f1_v_sync_end[*]"]     -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f_rising_edge_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f_rising_edge[*]"]     -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f_falling_edge_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f_falling_edge[*]"]    -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f1_v_end_nxt_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_f1_v_end_nxt[*]"]      -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f2_anc_v_start_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f2_anc_v_start[*]"]    -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|f1_anc_v_start_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f1_anc_v_start[*]"]    -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|h_sync_polarity_reg"]         -to [get_keepers "${inst}|mode_banks|vid_h_sync_polarity"]      -100
    set_min_delay -from [get_keepers "${inst}|mode_banks|v_sync_polarity_reg"]         -to [get_keepers "${inst}|mode_banks|vid_v_sync_polarity"]      -100

    set_net_delay -from [get_keepers "${inst}|mode_banks|interlaced_field_reg[*]"]     -to [get_keepers "${inst}|mode_banks|vid_interlaced_field[*]"]  -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|interlaced_reg"]              -to [get_keepers "${inst}|mode_banks|vid_interlaced"]           -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|h_total_minus_one_reg[*]"]    -to [get_keepers "${inst}|mode_banks|vid_h_total_minus_one[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|v_total_minus_one_reg[*]"]    -to [get_keepers "${inst}|mode_banks|vid_v_total_minus_one[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|h_blank_reg[*]"]              -to [get_keepers "${inst}|mode_banks|vid_h_blank[*]"]           -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|h_sync_start_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_h_sync_start[*]"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|h_sync_end_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_h_sync_end[*]"]        -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f2_v_start_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_f2_v_start[*]"]        -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f1_v_start_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_f1_v_start[*]"]        -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f1_v_end_reg[*]"]             -to [get_keepers "${inst}|mode_banks|vid_f1_v_end[*]"]          -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f2_v_sync_start_reg[*]"]      -to [get_keepers "${inst}|mode_banks|vid_f2_v_sync_start[*]"]   -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f2_v_sync_end_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f2_v_sync_end[*]"]     -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f1_v_sync_start_reg[*]"]      -to [get_keepers "${inst}|mode_banks|vid_f1_v_sync_start[*]"]   -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f1_v_sync_end_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f1_v_sync_end[*]"]     -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f_rising_edge_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_f_rising_edge[*]"]     -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f_falling_edge_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f_falling_edge[*]"]    -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f1_v_end_nxt_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_f1_v_end_nxt[*]"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f2_anc_v_start_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f2_anc_v_start[*]"]    -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|f1_anc_v_start_reg[*]"]       -to [get_keepers "${inst}|mode_banks|vid_f1_anc_v_start[*]"]    -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|h_sync_polarity_reg"]         -to [get_keepers "${inst}|mode_banks|vid_h_sync_polarity"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    set_net_delay -from [get_keepers "${inst}|mode_banks|v_sync_polarity_reg"]         -to [get_keepers "${inst}|mode_banks|vid_v_sync_polarity"]      -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8

        #set_max_delay -from [get_keepers "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] 100
        #set_min_delay -from [get_keepers "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}|dffpipe*"] -100
        #set_net_delay -from [get_pins -compatibility_mode "${fifo_name}rdptr_g[*]*"] -to [get_keepers "${fifo_name}ws_dgrp|dffpipe*"] -max 2
        #set_net_delay -from $from_node_list -to $to_node_list -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
        
    # The following may not exist to be applied to
    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_standard[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|standard_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_standard[*]"]                   100
        set_min_delay -from [get_keepers "${inst}|mode_banks|standard_reg[*]"]          -to [get_keepers "${inst}|mode_banks|vid_standard[*]"]                 -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|standard_reg[*]"]          -to [get_keepers "${inst}|mode_banks|vid_standard[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_serial_output[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|serial_output_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_serial_output[*]"]          100
        set_min_delay -from [get_keepers "${inst}|mode_banks|serial_output_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_serial_output[*]"]        -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|serial_output_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_serial_output[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_ap_line[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|ap_line_reg[*]"]              -to [get_keepers "${inst}|mode_banks|vid_ap_line[*]"]                100
        set_min_delay -from [get_keepers "${inst}|mode_banks|ap_line_reg[*]"]               -to [get_keepers "${inst}|mode_banks|vid_ap_line[*]"]              -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|ap_line_reg[*]"]               -to [get_keepers "${inst}|mode_banks|vid_ap_line[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_ap_line_end[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|ap_line_end_reg[*]"]          -to [get_keepers "${inst}|mode_banks|vid_ap_line_end[*]"]            100
        set_min_delay -from [get_keepers "${inst}|mode_banks|ap_line_end_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_ap_line_end[*]"]          -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|ap_line_end_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_ap_line_end[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_sav[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|sav_reg[*]"]                  -to [get_keepers "${inst}|mode_banks|vid_sav[*]"]                    100
        set_min_delay -from [get_keepers "${inst}|mode_banks|sav_reg[*]"]                   -to [get_keepers "${inst}|mode_banks|vid_sav[*]"]                  -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|sav_reg[*]"]                   -to [get_keepers "${inst}|mode_banks|vid_sav[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_sof_sample[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|sof_sample_reg[*]"]           -to [get_keepers "${inst}|mode_banks|vid_sof_sample[*]"]             100
        set_min_delay -from [get_keepers "${inst}|mode_banks|sof_sample_reg[*]"]            -to [get_keepers "${inst}|mode_banks|vid_sof_sample[*]"]           -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|sof_sample_reg[*]"]            -to [get_keepers "${inst}|mode_banks|vid_sof_sample[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_sof_line[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|sof_line_reg[*]"]             -to [get_keepers "${inst}|mode_banks|vid_sof_line[*]"]               100
        set_min_delay -from [get_keepers "${inst}|mode_banks|sof_line_reg[*]"]              -to [get_keepers "${inst}|mode_banks|vid_sof_line[*]"]             -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|sof_line_reg[*]"]              -to [get_keepers "${inst}|mode_banks|vid_sof_line[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_sof_subsample[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|sof_subsample_reg[*]"]        -to [get_keepers "${inst}|mode_banks|vid_sof_subsample[*]"]          100
        set_min_delay -from [get_keepers "${inst}|mode_banks|sof_subsample_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_sof_subsample[*]"]        -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|sof_subsample_reg[*]"]         -to [get_keepers "${inst}|mode_banks|vid_sof_subsample[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }

    if {[get_collection_size [get_keepers "${inst}|mode_banks|vid_vcoclk_divider_value[*]" -nowarn]] != 0} {
        set_max_delay -from [get_keepers "${inst}|mode_banks|vcoclk_divider_value_reg[*]"] -to [get_keepers "${inst}|mode_banks|vid_vcoclk_divider_value[*]"]   100
        set_min_delay -from [get_keepers "${inst}|mode_banks|vcoclk_divider_value_reg[*]"]  -to [get_keepers "${inst}|mode_banks|vid_vcoclk_divider_value[*]"] -100
        set_net_delay -from [get_keepers "${inst}|mode_banks|vcoclk_divider_value_reg[*]"]  -to [get_keepers "${inst}|mode_banks|vid_vcoclk_divider_value[*]"] -max -get_value_from_clock_period dst_clock_period -value_multiplier 0.8
    }
    
    
}

############################################################################
# alt_vip_common_sync has embedded SDC commands so no longer constrained in this file
############################################################################

set instance_collection [get_keepers -nowarn "*|${corename}:*|rst_vid_clk_reg*"]
    foreach_in_collection inst $instance_collection {
        set name [get_node_info -name $inst]
                puts $name
                set clear_pin [get_pins ${name}|clrn]
                puts "Setting false path through [get_pin_info -name $clear_pin]"
                set_false_path -through $clear_pin
        }
