// NEC protocol.
module IR_TRANSMITTER_Terasic(

input 	       iCLK_50,          //iCLK = 50MHz
input           iRST_n,

 //Send data will add their inverted data,LSB first(NEC protocol). you can impelement your own format if needed
input  [7:0]    iADDRESS, // 8bits Address 
input  [7:0]    iCOMMAND, // 8bits Command
input           iSEND,

output reg      oIR_TX_BUSY,
output          oIRDA		
					);
					
//protocol control.  

//NEC protocol.
parameter LEADER_HIGH_DUR   =  450000;	 //     450000 *0.02us = 9ms
parameter LEADER_LOW_DUR    =  225000;	 //     225000 *0.02us = 4.5ms
parameter DATA_HIGH_DUR     =  112500;	 //     112500 *0.02us = 2.25ms
parameter DATA_LOW_DUR      =  56250;	 //     56250 *0.02us  = 1.125ms
parameter PULSE_DUR         =  28125;	 //     28125 *0.02us  = 562.25us
// user define
parameter TIME_WAIT         =  1125000;	 //     22.5ms // add this wait time for make sure .this sending period doesn't disturb the next 

//localparam
localparam TX_IDLE          = 0;
localparam TX_LEDAER_HIGH   = 1;
localparam TX_LEDAER_LOW    = 2;
localparam TX_DATA          = 3;
localparam TX_0             = 4;
localparam TX_1             = 5;
localparam TX_STOP          = 6;
localparam TX_WAIT          = 7; 

					
					
					
// you can impelement a fifo to queue the sending datas.
reg          oIRDA_out;		

reg [7:0]    tx_status;
reg [31:0]   send_data;		
reg [5:0]    send_count;
reg [31:0]   time_count;

//////////////////////////////
// generate a 38KHz 1/3 duty cycle  carrier wave
reg [9:0]    clk_38K_count;
reg          clk_38K;
// duty cycle 1/3
always @ (posedge iCLK_50 or negedge iRST_n)
 begin
    if(!iRST_n) begin
          clk_38K <= 1'b0;
	       clk_38K_count <= 'b0;
			 
	 end 
	 else begin
	    
		 if(clk_38K) begin   
	 
	        if(clk_38K_count == 438) begin
		       clk_38K       <= 1'b0;
	          clk_38K_count <= 'b0;
		     end else begin
		  	    clk_38K_count <= clk_38K_count + 1'b1;
		    end
		 end else begin
		 
	        if(clk_38K_count == 878) begin
		       clk_38K       <= 1'b1;
	          clk_38K_count <= 'b0;
		     end else begin
		  	    clk_38K_count <= clk_38K_count + 1'b1;
		    end
		 
		 end
	 
	end
end

assign oIRDA = oIRDA_out & clk_38K;

//  tx state machine
always @ (posedge iCLK_50 or negedge iRST_n)
 begin 
    if(!iRST_n) begin
	      time_count  <= 'b0;
	      tx_status   <= TX_IDLE;
			send_data   <= 32'b0;
			send_count  <= 6'b0;
			oIR_TX_BUSY <= 1'b0;
			oIRDA_out <= 1'b0;
	 end else begin
	 
	    case(tx_status) 
		 
		   TX_IDLE:   
			    if(iSEND) begin
				    tx_status   <= TX_LEDAER_HIGH;
					 oIR_TX_BUSY <= 1'b1;
					
					// User can change the data format if they needed.
					// e.g.  tearsic IR remote :  vendor(16bits) + KEY(8bits)+ inverted KEY (8bits)
					 send_data <= {{iADDRESS[0],iADDRESS[1],iADDRESS[2],iADDRESS[3],iADDRESS[4],iADDRESS[5],iADDRESS[6],iADDRESS[7]}, //  Address  LSB first
                             ~{iADDRESS[0],iADDRESS[1],iADDRESS[2],iADDRESS[3],iADDRESS[4],iADDRESS[5],iADDRESS[6],iADDRESS[7]}, //inverted 
						  	         {iCOMMAND[0],iCOMMAND[1],iCOMMAND[2],iCOMMAND[3],iCOMMAND[4],iCOMMAND[5],iCOMMAND[6],iCOMMAND[7]}, //  Command  LSB first
						     	     ~{iCOMMAND[0],iCOMMAND[1],iCOMMAND[2],iCOMMAND[3],iCOMMAND[4],iCOMMAND[5],iCOMMAND[6],iCOMMAND[7]} // inverted 
				                };
									 
					 oIRDA_out      <= 1'b1; // leader 9ms high start.
                time_count <= 'b0;
				end else begin
					oIRDA_out <= 1'b0;
					oIR_TX_BUSY <= 1'b0;
               send_data   <= 'b0;
					time_count  <= 'b0;
				end
			
			TX_LEDAER_HIGH: // send leader code    9ms high + 4.5ms low
			     if(time_count == LEADER_HIGH_DUR) begin
				        time_count  <= 'b0;
						  tx_status   <= TX_LEDAER_LOW;
						  oIRDA_out       <= 1'b0; //
				  end else begin
				      time_count <= time_count + 1'b1;
              end
			TX_LEDAER_LOW: // send leader code    4.5ms low
			     if(time_count == LEADER_LOW_DUR) begin
				        time_count  <= 'b0;
						  tx_status   <= TX_DATA;
				  end else begin
				      time_count <= time_count + 1'b1;
              end
				  
			TX_DATA:  // ADDRESS + /ADDRESS + DATA + /DATA  ,LSB first.  
			
			     if(send_count[5]) begin  // all datas sent.
				  
				     send_count <= 6'b0;
				     tx_status   <=  TX_STOP;
					  oIRDA_out       <= 1'b1; 
				  end else begin
				  
				  	  send_count <= send_count + 1'b1;
					  
					  if(send_data[31]) tx_status  <=  TX_1;
					  else              tx_status  <=  TX_0;

                 send_data <= {send_data[30:0],1'b0};
					  
					  oIRDA_out       <= 1'b1; //
				  end
		
			
			TX_0: // send data 0

				  if(time_count == DATA_LOW_DUR) begin
				  		time_count  <= 'b0;
						tx_status   <= TX_DATA;
				  end
				  else if(time_count == PULSE_DUR) begin
					  oIRDA_out       <= 1'b0; 
				     time_count <= time_count + 1'b1;
				  end else begin
				      time_count <= time_count + 1'b1;
              end
			
			TX_1: // send data 1
				  if(time_count == DATA_HIGH_DUR) begin
				  		time_count  <= 'b0;
						tx_status   <= TX_DATA;
				  end
				  else if(time_count == PULSE_DUR) begin
					  oIRDA_out       <= 1'b0; 
				     time_count <= time_count + 1'b1;
				  end else begin
				      time_count <= time_count + 1'b1;
              end
			TX_STOP:
             if(time_count == PULSE_DUR) begin
					   oIRDA_out  <= 1'b0; 
					  	tx_status  <= TX_WAIT;
						time_count <= 'b0;
				  end else begin
				      time_count <= time_count + 1'b1;
             end
			TX_WAIT:
             if(time_count == TIME_WAIT) begin
    				  	tx_status  <= TX_IDLE;
						time_count <= 'b0;
				  end else begin
				      time_count <= time_count + 1'b1;
             end
			default: tx_status   <= TX_IDLE;

	   endcase
	end
 end
					

endmodule
