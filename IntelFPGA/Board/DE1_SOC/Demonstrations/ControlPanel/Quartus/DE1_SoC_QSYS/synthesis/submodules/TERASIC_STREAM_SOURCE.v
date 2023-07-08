// read latency = 1 in this design

module TERASIC_STREAM_SOURCE(
	// clock
	clk,
	reset_n,
	
	// mm slave
	s_cs,
	s_read,
	s_write,
	s_readdata,
	s_writedata,
	
	
	// streaming source
	src_ready,
	src_valid,
	src_data,
	src_sop,
	src_eop,
	
	user_mode
	
	
);

parameter VIDEO_W	= 800;
parameter VIDEO_H	= 600;


	// clock
input							clk;
input							reset_n;



	// mm slave
input							s_cs;
input							s_read;
input							s_write;
output	reg	[7:0]		s_readdata;
input		[7:0]				s_writedata;

	
	// streaming source
input							src_ready;
output	reg				src_valid;
output	reg [23:0]		src_data;
output	reg				src_sop;
output	reg				src_eop;

	// mode
input		[7:0]				user_mode;


`define	PAT_SCALE			7'd0
`define	PAT_RED				7'd1
`define	PAT_GREEN			7'd2
`define	PAT_BLUE				7'd3
`define	PAT_WHITE			7'd4
`define	PAT_BLACK			7'd5
`define	PAT_RED_SCALE		7'd6
`define	PAT_GREEN_SCALE	7'd7
`define	PAT_BLUE_SCALE		7'd8

//////////////////////////////////
// mm slave
// bit0: 1 start streaming, 0 stop streaming
// bit1~7: pattern mode

reg 		 stream_active;
reg [6:0] pat_id;

always @ (posedge clk or negedge reset_n)
begin	
	if (~reset_n)
	begin
		pat_id <= 0;
		stream_active <= 1'b1; // defautl active for testing
	end
	else if (s_cs & s_write)
		{pat_id, stream_active} <= s_writedata;
	else if (s_cs & s_read)
		s_readdata <= {pat_id, stream_active};
end

//////////////////////////////////
// generate x & y
reg [9:0] x;
reg [9:0] y;


wire next_xy;
assign next_xy = src_ready & is_send_video_data;

always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n)
	begin
		x <= 0;
		y <= 0;
	end
	else if (next_xy) 
	begin
		if (x+1 < VIDEO_W)
			x <= x + 1;
		else if (y+1 < VIDEO_H)
		begin
			y <= y + 1;
			x <= 0;
		end
		else
		begin
			x <= 0;
			y <= 0;
		end
	end
end

///////////////////////////////////
// pat id
wire [6:0] disp_pat;
assign disp_pat = user_mode[0]?user_mode[7:1]:pat_id;

///////////////////////////////////
// generate src_data, src_eop, src_valid according to x & y;
// 
reg is_send_video_data;

always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n)
		src_valid <= 1'b0;
	else
		src_valid <= src_ready;
end

wire is_last_pixel;
assign is_last_pixel = ( ((x+1)==VIDEO_W) && ((y+1) == VIDEO_H) )?1'b1:1'b0;

always @ (posedge clk or negedge reset_n)
begin
	if (~reset_n)
	begin
		is_send_video_data <= 1'b0; // need to send packet id first
		src_sop <= 1'b0;
		src_eop <= 1'b0;
		src_data <= 0;
	end
	else if (src_ready)
	begin
		if (~is_send_video_data)
		begin // send packet id
			is_send_video_data <= 1'b1;
			src_sop <= 1'b1;
			src_eop <= 1'b0;
			src_data <= 0; // 0: presents 'Video data packet'
		end
		else
		begin
			src_sop <= 1'b0;//(x==0 && y ==0)?1'b1:1'b0;
			src_eop <= is_last_pixel;
			if (is_last_pixel)
				is_send_video_data <= 1'b0; // no more send video data 

			
			if (disp_pat == `PAT_SCALE)
			begin
				if (y < VIDEO_H/4)
					src_data <= {8'h00, 8'h00, x[7:0]}; 
				else if (y < VIDEO_H/2)
					src_data <= {8'h00, x[7:0], 8'h00}; 
				else if (y < VIDEO_H*3/4)
					src_data <= {x[7:0], 8'h00, 8'h00}; 
				else
					src_data <= {x[7:0], x[7:0], x[7:0]}; 
			end
			else if (disp_pat == `PAT_RED)
				src_data <= {8'h00, 8'h00, 8'hff};
			else if (disp_pat == `PAT_GREEN)
				src_data <= {8'h00, 8'hff, 8'h00};
			else if (disp_pat == `PAT_BLUE)
				src_data <= {8'hff, 8'h00, 8'h00};
			else if (disp_pat == `PAT_WHITE)
				src_data <= {8'hff, 8'hff, 8'hff};
			else if (disp_pat == `PAT_BLACK)
				src_data <= {8'h00, 8'h00, 8'h00};
			else if (disp_pat == `PAT_RED_SCALE)
				src_data <= {8'h00, 8'h00, x[7:0]};
			else if (disp_pat == `PAT_GREEN_SCALE)
				src_data <= {8'h00, x[7:0], 8'h00};
			else if (disp_pat == `PAT_BLUE_SCALE)
				src_data <= {x[7:0], 8'h00, 8'h00};
		end
	end
		
end




endmodule
