module ps2(           
           iRST_n,   //FSM reset signal;
           iCLK_50,  //clock source;
           PS2_CLK,  //ps2_clock signal inout;
           PS2_DAT,  //ps2_data  signal inout;
           keycode_o,
		   revcnt
           ); 
           //interface;
//=======================================================
//  PORT declarations
//=======================================================

input iRST_n;
input iCLK_50;

inout PS2_CLK;
inout PS2_DAT;


//instruction define, users can charge the instruction byte here for other purpose according to ps/2 mouse datasheet.
//the MSB is of parity check bit, that's when there are odd number of 1's with data bits, it's value is '0',otherwise it's '1' instead.

parameter enable_byte =9'b011110100;


//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [1:0] cur_state,nex_state;
reg ce,de;
reg [3:0] byte_cnt,delay;
reg [5:0] ct;
reg [7:0] x_latch,y_latch,cnt;
reg [8:0] clk_div;
reg [9:0] dout_reg;
reg [32:0] shift_reg;
reg       leflatch,riglatch,midlatch;
reg       ps2_clk_in,ps2_clk_syn1,ps2_dat_in,ps2_dat_syn1;
wire      clk,ps2_dat_syn0,ps2_clk_syn0,ps2_dat_out,ps2_clk_out;

          
//=======================================================
//  Structural coding
//=======================================================          
//clk division, derive a 97.65625KHz clock from the 50MHz source;

always@(posedge iCLK_50)
	begin
		clk_div <= clk_div+1;
	end
	
assign clk = clk_div[8];
//tristate output control for PS2_DAT and PS2_CLK;


assign ps2_clk_syn0 = PS2_CLK;
assign ps2_dat_syn0 = PS2_DAT;

//multi-clock region simple synchronization
always@(posedge clk)
	begin
		ps2_clk_syn1 <= ps2_clk_syn0;
		ps2_clk_in   <= ps2_clk_syn1;
		ps2_dat_syn1 <= ps2_dat_syn0;
		ps2_dat_in   <= ps2_dat_syn1;
	end

//idle counter
//always@(posedge clk)
//begin
//  if ({ps2_clk_in,ps2_dat_in} == 2'b11)
//	begin
//		cnt <= cnt+1;
//    end
//  else begin
//		cnt <= 8'd0;
//       end
//end



//pull ps2_clk low for 100us before transmit starts;
//always@(posedge clk)
//begin
//  if (cur_state == pullclk)
//     delay <= delay+1;
//  else
//     delay <= 4'b0000;
//end
////transmit data to ps2 device;eg. 0xF4
//always@(negedge ps2_clk_in)
//begin
//  if (cur_state == trans)
//     dout_reg <= {1'b0,dout_reg[9:1]};
//  else
//     dout_reg <= {enable_byte,1'b0};
//end
////transmit byte length counter
//always@(negedge ps2_clk_in)
//begin
//  if (cur_state == trans)
//     byte_cnt <= byte_cnt+1;
//  else
//     byte_cnt <= 4'b0000;
//end
////receive data from ps2 device;
//always@(negedge ps2_clk_in)
//begin
//  if (cur_state == listen)
//     shift_reg <= {ps2_dat_in,shift_reg[32:1]};
//end
////FSM movement
//always@(posedge clk,negedge iRST_n)
//begin
//  if (!iRST_n)
//     cur_state <= listen;
//  else
//     cur_state <= nex_state;
//end

//////KeyBoard serial data in /////
output	reg [7:0]	keycode_o;
output	reg	[7:0]	revcnt;
	
always @( posedge ps2_clk_in or negedge iRST_n)
	begin
		if (!iRST_n)
			revcnt=0;
		else if (revcnt >=10) 
			revcnt=0;
		else
			revcnt=revcnt+1;
	end
	
always @(posedge ps2_clk_in) 
begin
	case (revcnt[3:0])
		1:keycode_o[0]=ps2_dat_in;
		2:keycode_o[1]=ps2_dat_in;
		3:keycode_o[2]=ps2_dat_in;
		4:keycode_o[3]=ps2_dat_in;
		5:keycode_o[4]=ps2_dat_in;
		6:keycode_o[5]=ps2_dat_in;
		7:keycode_o[6]=ps2_dat_in;
		8:keycode_o[7]=ps2_dat_in;
	endcase
end

endmodule


     

