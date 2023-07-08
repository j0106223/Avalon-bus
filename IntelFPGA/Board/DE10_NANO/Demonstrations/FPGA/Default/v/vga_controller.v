module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data
							 );
input iRST_n;
input iVGA_CLK;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
parameter VIDEO_W	= 640;
parameter VIDEO_H	= 480;

reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst/*synthesis keep*/;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS)
									);
////
////Addresss generator
reg [18:0] ADDR/*synthesis noprune*/;
reg [9:0] H_CONT/*synthesis noprune*/;
reg [8:0]V_CONT/*synthesis noprune*/;
reg cBLANK_n_delay;
wire BLANK_n_valid/*synthesis keep*/;

always@(posedge iVGA_CLK)
cBLANK_n_delay=cBLANK_n;

assign BLANK_n_valid=(cBLANK_n_delay==1 & cBLANK_n==0)?1'b1:1'b0;

always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     H_CONT<=10'd0;
  else if (cHS==1'b0)
     H_CONT<=10'd0;
  else if (cBLANK_n==1'b1)
     H_CONT<=H_CONT+1;
end

always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     V_CONT<=9'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     V_CONT<=9'd0;
  else if (BLANK_n_valid==1 && V_CONT<VIDEO_H)
     V_CONT<=V_CONT+1;
end
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
//////Color table output
img_index	img_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////

always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     begin
     ADDR<=19'd0;
	   bgr_data <= 0;  
	  end
  else if (H_CONT>=40 && H_CONT<=VIDEO_W-41 && V_CONT>=30 && V_CONT<=VIDEO_H-31)//560*420
     begin  
	    bgr_data <=bgr_data_raw;
       ADDR<=ADDR+1;
	  end
  else if (V_CONT==VIDEO_H-30)
     ADDR<=19'd0;
  else bgr_data <= 0;  
end

assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0];
///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	
















