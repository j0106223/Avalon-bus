// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/main/ip/merlin/altera_tristate_conduit_pin_sharer/altera_tristate_conduit_pin_sharer.sv.terp#4 $
// $Revision: #4 $
// $Date: 2010/01/18 $
// $Author: aferrucc $

//Defined Terp Parameters
//
// NUM_INTERFACES
// MASTER_SLAVE_MAPPING
// RETURNED_LISTS
// OUT_INT_LIST


    
  


module altera_tristate_conduit_pin_sharer_core_d367wjsk (
		     //clock and reset connections
                      input wire clk
		     ,input wire reset
		     
		     //Arbitrator Connections
		       
		     //Arbitrator Grant Interface
		     ,output reg ack
		     ,input wire[1-1:0] next_grant

		     //Arbitrator Request Interfaces

		     ,output wire arb_tcs0_request
		     //TCS Interface Connections
                     ,input wire [1-1:0] i_av_tri_s1_cfi_flash_0_tcm_data_outen
                     ,output wire [8-1:0] i_av_tri_s1_cfi_flash_0_tcm_data_in
                     ,input wire [23-1:0] i_av_tri_s1_cfi_flash_0_tcm_address_out
                     ,input wire [1-1:0] i_av_tri_s1_cfi_flash_0_tcm_read_n_out
                     ,input wire [1-1:0] i_av_tri_s1_cfi_flash_0_tcm_write_n_out
                     ,input wire [8-1:0] i_av_tri_s1_cfi_flash_0_tcm_data_out
                     ,input wire [1-1:0] i_av_tri_s1_cfi_flash_0_tcm_chipselect_n_out

		     ,input wire tcs0_request
		     ,output wire tcs0_grant
		     //TCM Interface Connections
		     ,output wire request
		     ,input wire grant
		     ,input wire[8 -1:0] tri_state_bridge_flash_data_in
		     ,output wire[1 -1:0] select_n_to_the_cfi_flash_out
		     ,output wire[1 -1:0] write_n_to_the_cfi_flash_out
		     ,output wire[8 -1:0] tri_state_bridge_flash_data_out
		     ,output wire[1 -1:0] tri_state_bridge_flash_data_outen
		     ,output wire[1 -1:0] read_n_to_the_cfi_flash_out
		     ,output wire[23 -1:0] address_to_the_cfi_flash_out

  );
function [1-1:0] getIndex;
      
    input [1-1:0] select;
   
    getIndex = 'h0;
    
    for(int i=0; i < 1; i = i + 1) begin
      if( select[i] == 1'b1 )
        getIndex = i;
    end
								
endfunction // getIndex
   
   reg[1-1:0] 	selected_grant;
   
    assign 	i_av_tri_s1_cfi_flash_0_tcm_data_in[8-1:0] = tri_state_bridge_flash_data_in[8-1:0];
						
    assign 	select_n_to_the_cfi_flash_out[1-1:0] = i_av_tri_s1_cfi_flash_0_tcm_chipselect_n_out[1-1:0];
						 
    assign 	write_n_to_the_cfi_flash_out[1-1:0] = i_av_tri_s1_cfi_flash_0_tcm_write_n_out[1-1:0];
						 
    assign 	tri_state_bridge_flash_data_out[8-1:0] = i_av_tri_s1_cfi_flash_0_tcm_data_out[8-1:0];
						 
    assign 	tri_state_bridge_flash_data_outen[1-1:0] = i_av_tri_s1_cfi_flash_0_tcm_data_outen[1-1:0];
					     
    assign 	read_n_to_the_cfi_flash_out[1-1:0] = i_av_tri_s1_cfi_flash_0_tcm_read_n_out[1-1:0];
						 
    assign 	address_to_the_cfi_flash_out[23-1:0] = i_av_tri_s1_cfi_flash_0_tcm_address_out[23-1:0];
						 
								   
    //Request Assignments
    
							   
    wire [1-1:0] concated_incoming_requests;
   
    assign 		       concated_incoming_requests = {
							       tcs0_request
							      };

    assign 		       arb_tcs0_request = tcs0_request;

    assign                     request = | concated_incoming_requests;

   
   //Grant Assignments
   
    assign 		       tcs0_grant = selected_grant[0];
   

							  
// Perform Grant Selection						  
   always@(posedge clk, posedge reset) begin
     if(reset) begin
	selected_grant<=0;
	ack <= 0;
     end 
     else begin
       if(grant && (concated_incoming_requests[getIndex(selected_grant)] == 0 || selected_grant == 0 )) begin
	  if(~request)
	    selected_grant <= '0;
	  else
	    selected_grant <= next_grant;
	  
          ack<=1;
       end
       else begin
         ack<=0;
         selected_grant <= selected_grant;
       end
     end
   end // always@ (posedge clk, posedge reset)
   
endmodule
   
   // declare multiplexor here...
   // inputs are in the foreach pin_master_info
   // select line is the global select line
   // connected inputs are defined to be 0



