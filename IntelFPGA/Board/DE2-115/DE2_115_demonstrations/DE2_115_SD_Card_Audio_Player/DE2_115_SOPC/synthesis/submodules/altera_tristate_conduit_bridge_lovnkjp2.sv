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


// $Id: //acds/rel/10.1sp1/ip/merlin/altera_tristate_conduit_bridge/altera_tristate_conduit_bridge.sv.terp#2 $
// $Revision: #2 $
// $Date: 2010/11/17 $
// $Author: bgordon $

//Defined Terp Parameters
//DINFO : String of decoded Tristate Conduit Masters System Info


  
//data description
// master_list => 1 entry for each master containing
  // 3 entries, out_list, tri_list, in_list
// out_list => array with keys == roles, returns array containing 2 keys width and name
// in_list => array with keys == roles, returns array containing 2 keys width and name
// tri_list => array with keys == roles, returns array containing 3 keys out, in, outen
//    out => array containing 2 keys width and name
//    in => array containing 2 keys width and name
//    outen => string containing the name of the pin




					      
module altera_tristate_conduit_bridge_lovnkjp2 (
				       input wire clk
				      ,input wire reset
				      ,input wire tcs_request
				      ,output wire tcs_grant
				      //tristate pins
                                      ,input wire tcs_tri_state_bridge_flash_data_outen
				      ,input wire[8 - 1 : 0 ] tcs_tri_state_bridge_flash_data_out
				      ,output wire[8 - 1 : 0 ] tcs_tri_state_bridge_flash_data_in
                                      //**conduit instantiation**
				      ,inout wire[8 - 1 : 0 ] tri_state_bridge_flash_data
				      //**conduit instantiation**
				      //input pins
				      //output pins
				      ,input wire [23 - 1 : 0 ] tcs_address_to_the_cfi_flash_out
				      //**conduit instantiation**
				      ,inout wire [23 - 1 : 0 ] address_to_the_cfi_flash
				      //**conduit instantiation**
				      ,input wire [1 - 1 : 0 ] tcs_write_n_to_the_cfi_flash_out
				      //**conduit instantiation**
				      ,inout wire [1 - 1 : 0 ] write_n_to_the_cfi_flash
				      //**conduit instantiation**
				      ,input wire [1 - 1 : 0 ] tcs_select_n_to_the_cfi_flash_out
				      //**conduit instantiation**
				      ,inout wire [1 - 1 : 0 ] select_n_to_the_cfi_flash
				      //**conduit instantiation**
				      ,input wire [1 - 1 : 0 ] tcs_read_n_to_the_cfi_flash_out
				      //**conduit instantiation**
				      ,inout wire [1 - 1 : 0 ] read_n_to_the_cfi_flash
				      //**conduit instantiation**
   );


    reg 	tcs_request_reg;
    assign 	tcs_grant = tcs_request_reg;

    always@(posedge clk, posedge reset) begin
       if(reset) begin
	tcs_request_reg <= '0;
       end
       else begin
	 tcs_request_reg <= tcs_request;
       end
			     
    end
					     

//*****  Master tri_state_bridge_flash_pinSharer_0.tcm  *****
					     
//tristate pins
						
    reg                       tcs_tri_state_bridge_flash_data_outen_pre;    
    reg [8 - 1 : 0 ] tcs_tri_state_bridge_flash_data_out_pre; 
  
    always@(posedge clk, posedge reset) begin
       if(reset) begin
	 tcs_tri_state_bridge_flash_data_outen_pre <= 'h0;
       end else begin
	 tcs_tri_state_bridge_flash_data_outen_pre <= tcs_tri_state_bridge_flash_data_outen;
       end
     end

     always@(posedge clk) begin
	 tcs_tri_state_bridge_flash_data_out_pre   <= tcs_tri_state_bridge_flash_data_out[8 - 1 : 0];
     end						 
							 
    assign 	tri_state_bridge_flash_data[8 - 1 : 0 ] = tcs_tri_state_bridge_flash_data_outen_pre ? tcs_tri_state_bridge_flash_data_out_pre : 'z ;						    
    reg [8-1:0] 	tcs_tri_state_bridge_flash_data_in_pre;
								    
    always@(posedge clk) begin
	 tcs_tri_state_bridge_flash_data_in_pre <= tri_state_bridge_flash_data[8 - 1 : 0];
    end
								    
    assign      tcs_tri_state_bridge_flash_data_in[8 - 1 : 0] = tcs_tri_state_bridge_flash_data_in_pre[8 - 1 :0];

//input pins
										     

//output pins
					  
reg [23-1:0] tcs_address_to_the_cfi_flash_out_pre /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
reg                  tcs_address_to_the_cfi_flash_out_pre_outen /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_ENABLE_REGISTER=ON"  */;
						  
    always@(posedge clk, posedge reset) begin
       if(reset) begin
	 tcs_address_to_the_cfi_flash_out_pre_outen <= 'h0;
       end else begin
	 tcs_address_to_the_cfi_flash_out_pre_outen <= 'h1;
       end
    end

    always@(posedge clk) begin
       tcs_address_to_the_cfi_flash_out_pre <= tcs_address_to_the_cfi_flash_out[23 - 1 : 0];
    end
						  
    assign 	address_to_the_cfi_flash [23 - 1 : 0 ] = tcs_address_to_the_cfi_flash_out_pre_outen ? tcs_address_to_the_cfi_flash_out_pre[23 - 1 : 0 ] : 'z; 
reg [1-1:0] tcs_write_n_to_the_cfi_flash_out_pre /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
reg                  tcs_write_n_to_the_cfi_flash_out_pre_outen /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_ENABLE_REGISTER=ON"  */;
						  
    always@(posedge clk, posedge reset) begin
       if(reset) begin
	 tcs_write_n_to_the_cfi_flash_out_pre_outen <= 'h0;
       end else begin
	 tcs_write_n_to_the_cfi_flash_out_pre_outen <= 'h1;
       end
    end

    always@(posedge clk) begin
       tcs_write_n_to_the_cfi_flash_out_pre <= tcs_write_n_to_the_cfi_flash_out[1 - 1 : 0];
    end
						  
    assign 	write_n_to_the_cfi_flash [1 - 1 : 0 ] = tcs_write_n_to_the_cfi_flash_out_pre_outen ? tcs_write_n_to_the_cfi_flash_out_pre[1 - 1 : 0 ] : 'z; 
reg [1-1:0] tcs_select_n_to_the_cfi_flash_out_pre /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
reg                  tcs_select_n_to_the_cfi_flash_out_pre_outen /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_ENABLE_REGISTER=ON"  */;
						  
    always@(posedge clk, posedge reset) begin
       if(reset) begin
	 tcs_select_n_to_the_cfi_flash_out_pre_outen <= 'h0;
       end else begin
	 tcs_select_n_to_the_cfi_flash_out_pre_outen <= 'h1;
       end
    end

    always@(posedge clk) begin
       tcs_select_n_to_the_cfi_flash_out_pre <= tcs_select_n_to_the_cfi_flash_out[1 - 1 : 0];
    end
						  
    assign 	select_n_to_the_cfi_flash [1 - 1 : 0 ] = tcs_select_n_to_the_cfi_flash_out_pre_outen ? tcs_select_n_to_the_cfi_flash_out_pre[1 - 1 : 0 ] : 'z; 
reg [1-1:0] tcs_read_n_to_the_cfi_flash_out_pre /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_REGISTER=ON"  */;
reg                  tcs_read_n_to_the_cfi_flash_out_pre_outen /* synthesis ALTERA_ATTRIBUTE = "FAST_OUTPUT_ENABLE_REGISTER=ON"  */;
						  
    always@(posedge clk, posedge reset) begin
       if(reset) begin
	 tcs_read_n_to_the_cfi_flash_out_pre_outen <= 'h0;
       end else begin
	 tcs_read_n_to_the_cfi_flash_out_pre_outen <= 'h1;
       end
    end

    always@(posedge clk) begin
       tcs_read_n_to_the_cfi_flash_out_pre <= tcs_read_n_to_the_cfi_flash_out[1 - 1 : 0];
    end
						  
    assign 	read_n_to_the_cfi_flash [1 - 1 : 0 ] = tcs_read_n_to_the_cfi_flash_out_pre_outen ? tcs_read_n_to_the_cfi_flash_out_pre[1 - 1 : 0 ] : 'z; 
endmodule


