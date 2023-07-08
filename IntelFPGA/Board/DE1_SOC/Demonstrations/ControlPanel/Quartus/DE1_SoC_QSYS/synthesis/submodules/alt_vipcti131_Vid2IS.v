module alt_vipcti131_Vid2IS(
    rst,
    
    // video
    vid_clk,
    vid_data,
    vid_de,
    vid_datavalid,
    vid_locked,
    
    // optional video ports
    vid_f,
    vid_v_sync,
    vid_h_sync,
    vid_hd_sdn,
    vid_std,
    
    // IS
    is_clk,
    is_ready,
    is_valid,
    is_data,
    is_sop,
    is_eop,
    
    // Control
    av_address,
    av_read,
    av_readdata,
    av_write,
    av_writedata,
    
    // sync
    sof,
    sof_locked,
    refclk_div,
    
    // Interrupt
    status_update_int,
    
    // Error
    overflow) /* synthesis altera_attribute="disable_da_rule=\"R105,D101,D102\"" */;
    
// TODO: ancillary - remove the extra bit that goes into the fifo (anc) and instead
//                   make the first data beat the header type (0 or 14)

function integer alt_clogb2;
  input [31:0] value;
  integer i;
  begin
    alt_clogb2 = 32;
    for (i=31; i>0; i=i-1) begin
      if (2**i>=value)
        alt_clogb2 = i;
    end
  end
endfunction

parameter BPS = 10;
parameter NUMBER_OF_COLOUR_PLANES = 2;
parameter COLOUR_PLANES_ARE_IN_PARALLEL = 1;
parameter FIFO_DEPTH = 1920;
parameter USE_EMBEDDED_SYNCS = 1;
parameter ADD_DATA_ENABLE_SIGNAL = 0;
parameter CLOCKS_ARE_SAME = 0;
parameter USE_CONTROL = 1;
parameter INTERLACED = 1;
parameter H_ACTIVE_PIXELS_F0 = 1920;
parameter V_ACTIVE_LINES_F0 = 540;
parameter H_ACTIVE_PIXELS_F1 = 1920;
parameter V_ACTIVE_LINES_F1 = 540;
parameter SYNC_TO = 2;
parameter ACCEPT_COLOURS_IN_SEQ = 1;
parameter USE_STD = 1;
parameter STD_WIDTH = 3;
parameter GENERATE_SYNC = 1;
parameter GENERATE_ANC = 0;

localparam CONVERT_SEQ_TO_PAR = COLOUR_PLANES_ARE_IN_PARALLEL == 1 && ACCEPT_COLOURS_IN_SEQ != 0 && NUMBER_OF_COLOUR_PLANES > 1;
localparam DATA_WIDTH = (COLOUR_PLANES_ARE_IN_PARALLEL) ? BPS * NUMBER_OF_COLOUR_PLANES : BPS;
localparam NUMBER_OF_COLOUR_PLANES_IN_PARALLEL = (COLOUR_PLANES_ARE_IN_PARALLEL) ? NUMBER_OF_COLOUR_PLANES : 1;
localparam BASE = (BPS >= 10) ? 2 : 0;
localparam LOG2_NUMBER_OF_COLOUR_PLANES = alt_clogb2(NUMBER_OF_COLOUR_PLANES);
localparam COLOUR_PLANES_IN_SEQUENCE = (COLOUR_PLANES_ARE_IN_PARALLEL && !CONVERT_SEQ_TO_PAR) ? 1 : NUMBER_OF_COLOUR_PLANES;
localparam COLOUR_PLANES_IN_SEQUENCE_FIFO = (COLOUR_PLANES_ARE_IN_PARALLEL) ? 1 : NUMBER_OF_COLOUR_PLANES;
localparam FIFO_WIDTH = DATA_WIDTH + 1;
localparam FIFO_DEPTH_INT = (FIFO_DEPTH * COLOUR_PLANES_IN_SEQUENCE_FIFO) + 4;
localparam USED_WORDS_WIDTH = alt_clogb2(FIFO_DEPTH_INT);

input rst;

// video
input vid_clk;
input [DATA_WIDTH-1:0] vid_data;
input vid_de;
input vid_datavalid;
input vid_locked;

// optional video ports
input vid_f;
input vid_v_sync;
input vid_h_sync;
input vid_hd_sdn;
input [STD_WIDTH-1:0] vid_std;

// IS
input is_clk;
input is_ready;
output is_valid;
output [DATA_WIDTH-1:0] is_data;
output is_sop;
output is_eop;

// Control
input [3:0] av_address;
input av_read;
output [15:0] av_readdata;
input av_write;
input [15:0] av_writedata;

// Sync
output sof;
output sof_locked;
output refclk_div;

// Interrupt
output status_update_int;

// Error
output overflow;

reg [DATA_WIDTH-1:0] vid_data_input;
reg vid_datavalid_input;
reg vid_f_input;
reg vid_v_sync_input;
reg vid_h_sync_input;
reg vid_hd_sdn_input;

wire [DATA_WIDTH-1:0] is_data;
wire is_valid;
wire is_sop;
wire is_eop;

wire rdreq;
wire wrreq;
wire wrreq_pre_swap;
wire [DATA_WIDTH-1:0] data;
wire full;
wire enable;
wire [USED_WORDS_WIDTH-1:0] usedw;

wire overflow_nxt;
reg overflow_reg;
reg overflow_sticky;
wire overflow_sticky_sync1;

reg enable_synced;

wire rst_vid_clk;
wire ap;
wire f;
wire start_of_vsync;
reg [1:0] sync_count;
reg locked;
wire h_sync, v_sync;
reg h_sync_reg, v_sync_reg;
wire packet;
wire start_of_hsync;
wire lost_vid_locked;
wire overflowed;
wire early_eop;
wire eop;
wire [14:0] active_sample_count;
wire [13:0] active_line_count_f0;
wire [13:0] active_line_count_f1;
wire [14:0] total_sample_count;
wire [13:0] total_line_count_f0;
wire [13:0] total_line_count_f1;
wire [13:0] total_line_count;
wire is_interlaced;
wire [16:0] is_active_sample_count;
wire [16:0] is_active_line_count_f0;
wire [16:0] is_active_line_count_f1;
wire [13:0] sof_sample;
wire [1:0] sof_subsample;
wire [12:0] sof_line;
wire [13:0] refclk_divider_value;
wire genlock_enable;
wire update_sync1;
wire resolution_change;
wire resolution_change_sync1;
wire update;
wire [STD_WIDTH-1:0] vid_std_sync1;
reg ap_reg;
wire end_of_vsync;
wire interlaced;
wire start_of_ap;
wire [1:0] sync_count_next;
wire locked_next;
wire stable;
wire resolution_valid;
wire wrreq_pre_enable;
reg vid_locked_reg;
wire clear_overflow_sticky;
wire is_output_enable;
wire frame_synch;
wire field_prediction_nxt;
reg field_prediction;
wire vid_clk_int;
wire last_sample;
reg f_reg;

generate begin : clocks_are_same_generate
     if(CLOCKS_ARE_SAME) begin
         assign rst_vid_clk = rst;
         assign vid_clk_int = is_clk;
     end else begin
         reg rst_vid_clk_reg;
         reg rst_vid_clk_reg2;
         
         always @ (posedge rst or posedge vid_clk_int) begin
             if(rst) begin
                rst_vid_clk_reg <= 1'b1;
                rst_vid_clk_reg2 <= 1'b1;
             end else begin
                rst_vid_clk_reg <= 1'b0;
                rst_vid_clk_reg2 <= rst_vid_clk_reg;
             end
         end
         assign rst_vid_clk = rst_vid_clk_reg2;
         assign vid_clk_int = vid_clk;
     end
end endgenerate

// control registers and Avalon-MM slave interface
alt_vipcti131_Vid2IS_control control(
    .rst(rst),
    .clk(is_clk),

    // From FIFO
    .usedw(usedw),
    .overflow_sticky(overflow_sticky_sync1),
    .is_output_enable(is_output_enable), // from the outgoing state machine
    
    // From resolution detection
    .update(update_sync1),
    .resolution_change(resolution_change_sync1),
    .interlaced(interlaced),
    .active_sample_count(active_sample_count),
    .active_line_count_f0(active_line_count_f0),
    .active_line_count_f1(active_line_count_f1),
    .total_sample_count(total_sample_count),
    .total_line_count_f0(total_line_count_f0),
    .total_line_count_f1(total_line_count_f1),
    .stable(stable),
    .resolution_valid(resolution_valid),
    .vid_std(vid_std_sync1), // from the incoming video
    
    // Vid2IS control signals
    .enable(enable),
    .clear_overflow_sticky(clear_overflow_sticky),
    .is_interlaced(is_interlaced),
    .is_active_sample_count(is_active_sample_count),
    .is_active_line_count_f0(is_active_line_count_f0),
    .is_active_line_count_f1(is_active_line_count_f1),
    .sof_sample(sof_sample),
    .sof_line(sof_line),
    .sof_subsample(sof_subsample),
    .refclk_divider_value(refclk_divider_value),
    .genlock_enable(genlock_enable),
    
    // Aavalon-MM slave port
    .av_address(av_address),
    .av_read(av_read),
    .av_readdata(av_readdata),
    .av_write(av_write),
    .av_writedata(av_writedata),
    
    .status_update_int(status_update_int));
    
defparam control.USE_CONTROL = USE_CONTROL,
         control.INTERLACED = INTERLACED,
         control.H_ACTIVE_PIXELS_F0 = H_ACTIVE_PIXELS_F0,
         control.V_ACTIVE_LINES_F0 = V_ACTIVE_LINES_F0,
         control.V_ACTIVE_LINES_F1 = V_ACTIVE_LINES_F1,
         control.USED_WORDS_WIDTH = USED_WORDS_WIDTH,
         control.STD_WIDTH = STD_WIDTH;
         
// synchronize the status signals to the system clock domain
generate begin : use_std_generate
    if(USE_STD) begin
        alt_vipcti131_common_sync #(CLOCKS_ARE_SAME, STD_WIDTH) vid_std_sync(
            .rst(rst),
            .sync_clock(is_clk),
            .data_in(vid_std),
            .data_out(vid_std_sync1));
    end else begin
        assign vid_std_sync1 = {STD_WIDTH{1'b0}};
    end
end endgenerate

alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) overflow_sticky_sync(
    .rst(rst),
    .sync_clock(is_clk),
    .data_in(overflow_sticky),
    .data_out(overflow_sticky_sync1));

alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) update_sync(
    .rst(rst),
    .sync_clock(is_clk),
    .data_in(update),
    .data_out(update_sync1));

alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) resolution_change_sync(
    .rst(rst),
    .sync_clock(is_clk),
    .data_in(resolution_change),
    .data_out(resolution_change_sync1));

// synchronize all the control signals to the video clock domain
wire enable_sync1;
wire clear_overflow_sticky_sync1;
wire genlock_enable_sync1;
wire [13:0] refclk_divider_value_sync1;
wire [13:0] sof_sample_sync1;
wire [12:0] sof_line_sync1;
wire [1:0] sof_subsample_sync1;

alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) enable_sync(
    .rst(rst_vid_clk),
    .sync_clock(vid_clk_int),
    .data_in(enable),
    .data_out(enable_sync1));
    
alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) clear_overflow_sticky_sync(
    .rst(rst_vid_clk),
    .sync_clock(vid_clk_int),
    .data_in(clear_overflow_sticky),
    .data_out(clear_overflow_sticky_sync1));

alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) genlock_enable_sync(
    .rst(rst_vid_clk),
    .sync_clock(vid_clk_int),
    .data_in(genlock_enable),
    .data_out(genlock_enable_sync1));
    
alt_vipcti131_common_sync #(CLOCKS_ARE_SAME, 14) refclk_divider_value_sync(
    .rst(rst_vid_clk),
    .sync_clock(vid_clk_int),
    .data_in(refclk_divider_value),
    .data_out(refclk_divider_value_sync1));
  
alt_vipcti131_common_sync #(CLOCKS_ARE_SAME, 14) sof_sample_sync(
    .rst(rst_vid_clk),
    .sync_clock(vid_clk_int),
    .data_in(sof_sample),
    .data_out(sof_sample_sync1));
    
alt_vipcti131_common_sync #(CLOCKS_ARE_SAME, 13) sof_line_sync(
    .rst(rst_vid_clk),
    .sync_clock(vid_clk_int),
    .data_in(sof_line),
    .data_out(sof_line_sync1));
 
alt_vipcti131_common_sync #(CLOCKS_ARE_SAME, 2) sof_subsample_sync(
    .rst(rst_vid_clk),
    .sync_clock(vid_clk_int),
    .data_in(sof_subsample),
    .data_out(sof_subsample_sync1));
    
// Register the video input signals
always @ (posedge rst_vid_clk or posedge vid_clk_int) begin
    if (rst_vid_clk) begin
        vid_data_input <= {DATA_WIDTH{1'b0}};
        vid_datavalid_input <= 1'b0;
        vid_f_input <= 1'b0;
        vid_v_sync_input <= 1'b0;
        vid_h_sync_input <= 1'b0;
        vid_hd_sdn_input <= 1'b0;
    end else begin
        vid_data_input <= vid_data;
        if (~USE_EMBEDDED_SYNCS && ADD_DATA_ENABLE_SIGNAL)
            vid_datavalid_input <= vid_de;
        else
            vid_datavalid_input <= vid_datavalid;
        vid_f_input <= vid_f;
        vid_v_sync_input <= vid_v_sync;
        vid_h_sync_input <= vid_h_sync;
        if(CONVERT_SEQ_TO_PAR)
            vid_hd_sdn_input <= vid_hd_sdn;
        else
            vid_hd_sdn_input <= COLOUR_PLANES_ARE_IN_PARALLEL;
    end
end

// extract any embedded syncs
wire vid_enable_int;
wire vid_f_int;
wire vid_h_sync_int;
wire vid_v_sync_int;
wire vid_datavalid_int;
wire vid_anc_valid_int;
wire [DATA_WIDTH-1:0] vid_data_int;

generate begin : use_embedded_syncs_generate
    if(USE_EMBEDDED_SYNCS) begin
        assign vid_enable_int = vid_datavalid_input;  // TODO: vid_enable should be a top level signal that is used
                                                      // in both embedded and separate sync modes
        
        alt_vipcti131_Vid2IS_embedded_sync_extractor#(
                .DATA_WIDTH(DATA_WIDTH),
                .BPS(BPS),
                .BASE(BASE),
                .GENERATE_ANC(GENERATE_ANC))
            sync_extractor(
                .rst(rst_vid_clk),
                .clk(vid_clk_int),
    
                // video
                .vid_locked(vid_locked),
                .vid_enable(vid_enable_int),
                .vid_hd_sdn(vid_hd_sdn_input),
                .vid_data_in(vid_data_input),
    
                // optional video ports
                .vid_f(vid_f_int),
                .vid_h_sync(vid_h_sync_int),
                .vid_v_sync(vid_v_sync_int),
                .vid_datavalid(vid_datavalid_int),
                .vid_anc_valid(vid_anc_valid_int),
                .vid_data_out(vid_data_int));
    end else begin
        assign vid_enable_int = (ADD_DATA_ENABLE_SIGNAL==1) ? vid_datavalid : 1'b1;
    
        alt_vipcti131_Vid2IS_sync_polarity_convertor hsync_convertor(
            .rst(rst_vid_clk),
            .clk(vid_clk_int),
            
            .sync_in(vid_h_sync_input),
            .datavalid(vid_datavalid_input),
            .sync_out(vid_h_sync_int));
            
        alt_vipcti131_Vid2IS_sync_polarity_convertor vsync_convertor(
            .rst(rst_vid_clk),
            .clk(vid_clk_int),
            
            .sync_in(vid_v_sync_input),
            .datavalid(vid_datavalid_input),
            .sync_out(vid_v_sync_int));
            
        assign vid_f_int = vid_f_input;
        assign vid_datavalid_int = vid_datavalid_input;
        assign vid_anc_valid_int = 1'b0;
        assign vid_data_int = vid_data_input;
    end
end endgenerate

// this section drives the write side of the fifo.
wire valid_nxt;
reg valid_reg;
reg [DATA_WIDTH-1:0] data_reg;
reg vid_f_reg;
reg vid_h_sync_reg;
reg vid_v_sync_reg;
reg vid_datavalid_reg;
reg vid_anc_valid_reg;
reg convert;

assign valid_nxt = vid_enable_int & (vid_datavalid_int | vid_anc_valid_int); 

always @ (posedge rst_vid_clk or posedge vid_clk_int) begin
    if(rst_vid_clk) begin
        valid_reg <= 1'b0;
        convert <= 1'b0;
        data_reg <= {DATA_WIDTH{1'b0}};
        vid_f_reg <= 1'b0;
        vid_h_sync_reg <= 1'b0;
        vid_v_sync_reg <= 1'b0;
        vid_datavalid_reg <= 1'b0;
        vid_anc_valid_reg <= 1'b0;
    end else begin
        if(overflow_nxt) begin // if an overflow occurs when there is still data to write
                               // we must write the eop when the fifo frees some space
            valid_reg <= valid_reg;
            convert <= convert;
        end else begin
            valid_reg <= (valid_nxt | valid_reg) & ~eop;
            convert <= ((vid_enable_int & vid_datavalid_int) | convert) & ~eop;   // tells the write buffer whether to convert from sd to hd
        end
        data_reg <= (valid_nxt) ? vid_data_int : data_reg;
        
        if(vid_enable_int) begin
            vid_f_reg <= vid_f_int;
            vid_h_sync_reg <= vid_h_sync_int;
            vid_v_sync_reg <= vid_v_sync_int;
            vid_datavalid_reg <= vid_datavalid_int;
            vid_anc_valid_reg <= vid_anc_valid_int;
        end
    end
end

assign wrreq_pre_enable = valid_nxt | eop; // end of packet flushes the last pixel
assign data = (valid_nxt & ~valid_reg) ? (vid_datavalid_int) ? 0 : 13 : // first data word is the type 0 - image, 13 - ancilliary
                                         data_reg;
assign f = vid_f_reg;
assign h_sync = vid_h_sync_reg;
assign v_sync = vid_v_sync_reg;
assign ap = vid_datavalid_reg;
assign last_sample = valid_reg & (start_of_vsync | end_of_vsync);

always @ (posedge rst_vid_clk or posedge vid_clk_int) begin
    if(rst_vid_clk) begin
        sync_count <= 2'b01;
        locked <= 1'b0;
	    enable_synced <= 1'b0;
        
        overflow_reg <= 1'b0;
        overflow_sticky <= 1'b0;
        vid_locked_reg <= 1'b0;
        
        h_sync_reg <= 1'b0;
        v_sync_reg <= 1'b0;
        ap_reg <= 1'b0;
        
        f_reg <= 1'b0;
        field_prediction <= 1'b0;
    end else begin
        if(~vid_locked | lost_vid_locked | overflowed) begin
            sync_count <= 2'b01;
            locked <= 1'b0;
            enable_synced <= 1'b0;
        end else begin
            sync_count <= sync_count_next;
            locked <= locked_next;
            enable_synced <= (frame_synch) ? enable_sync1 & locked_next : enable_synced;
        end
        
        h_sync_reg <= h_sync;
        v_sync_reg <= v_sync;
        ap_reg <= ap;
        
        overflow_reg <= overflow_nxt;
        overflow_sticky <= (overflow_nxt | overflow_sticky) & ~clear_overflow_sticky_sync1;
        vid_locked_reg <= vid_locked;
        
        f_reg <= f;
        field_prediction <= field_prediction_nxt;
    end
end

assign field_prediction_nxt = (~interlaced | end_of_vsync) ? f_reg : (start_of_vsync) ? ~f_reg : field_prediction;
    
assign overflow = overflow_sticky; // the sticky overflow output is set when the video interface attempts to 
                                   // write data when the fifo is full.
assign overflow_nxt = (wrreq | overflow_reg) & full;
assign lost_vid_locked = (~vid_locked & vid_locked_reg);
assign overflowed = (~full & overflow_reg);

assign wrreq = wrreq_pre_enable & enable_synced;
assign wrreq_pre_swap = wrreq & ~full;
assign start_of_ap = ap & ~ap_reg;
assign end_of_vsync = ~v_sync & v_sync_reg;
assign start_of_vsync = v_sync & ~v_sync_reg;
assign start_of_hsync = h_sync & ~h_sync_reg;
assign early_eop = valid_reg & (lost_vid_locked | overflowed);
assign eop =  last_sample | early_eop;
assign packet = last_sample | early_eop;
assign sync_count_next = (start_of_hsync) ? sync_count - 2'b01 : sync_count;
assign locked_next = ~|sync_count_next | locked;

generate begin : sync_to_generate
    if(SYNC_TO == 0) begin
        assign frame_synch = end_of_vsync & ~f;
    end else if(SYNC_TO == 1) begin
        assign frame_synch = end_of_vsync & f;
    end else begin
        assign frame_synch = end_of_vsync;
    end
end endgenerate

// this module counts the samples and lines of the frame
alt_vipcti131_Vid2IS_resolution_detection resolution_detection(
    .rst(rst_vid_clk),
    .clk(vid_clk_int),
    
    // Video signals
    .count_cycle(vid_enable_int),
    .ap(ap),
    .hd_sdn(vid_hd_sdn_input),
    .start_new_line(start_of_hsync),
    .start_new_field(start_of_vsync),
    .end_of_vsync(end_of_vsync),
    .f(f),
    .vid_locked(vid_locked),
    
    // Calculated resolution
    .update(update),
    .interlaced(interlaced),
    .active_sample_count(active_sample_count),
    .active_line_count_f0(active_line_count_f0),
    .active_line_count_f1(active_line_count_f1),
    .total_sample_count(total_sample_count),
    .total_line_count_f0(total_line_count_f0),
    .total_line_count_f1(total_line_count_f1),
    .total_line_count(total_line_count),
    .stable(stable),
    .resolution_valid(resolution_valid),
    .resolution_change(resolution_change));
    
defparam resolution_detection.NUMBER_OF_COLOUR_PLANES = NUMBER_OF_COLOUR_PLANES,
         resolution_detection.COLOUR_PLANES_ARE_IN_PARALLEL = COLOUR_PLANES_ARE_IN_PARALLEL,
         resolution_detection.LOG2_NUMBER_OF_COLOUR_PLANES = LOG2_NUMBER_OF_COLOUR_PLANES,
         resolution_detection.H_ACTIVE_PIXELS = H_ACTIVE_PIXELS_F0,
         resolution_detection.V_ACTIVE_LINES_F0 = V_ACTIVE_LINES_F0,
         resolution_detection.V_ACTIVE_LINES_F1 = V_ACTIVE_LINES_F1,
         resolution_detection.INTERLACED = INTERLACED;

// this module generates a start of frame signal synched to the incoming video
generate begin : sync_generation_generate
    if(GENERATE_SYNC > 0) begin
        alt_vipcti131_common_sync_generation sync_generation(
            .rst(rst_vid_clk),
            .clk(vid_clk_int),
            
            .clear_enable(1'b0),
            .enable_count(vid_enable_int),
            .hd_sdn(vid_hd_sdn_input),
            .start_of_vsync(start_of_vsync),
            .field_prediction(field_prediction_nxt),
            .interlaced(interlaced),
            .total_sample_count(total_sample_count[14:1]),
            .total_sample_count_valid(total_sample_count[0]),
            .total_line_count(total_line_count[13:1]),
            .total_line_count_valid(total_line_count[0]),
            .stable(stable),
            
            .divider_value(refclk_divider_value_sync1),
            .sof_sample(sof_sample_sync1),
            .sof_line(sof_line_sync1),
            .sof_subsample(sof_subsample_sync1),
            
            .output_enable(genlock_enable_sync1),
            .sof(sof),
            .sof_locked(sof_locked),
            .div(refclk_div));

            defparam sync_generation.NUMBER_OF_COLOUR_PLANES = NUMBER_OF_COLOUR_PLANES,
                     sync_generation.COLOUR_PLANES_ARE_IN_PARALLEL = COLOUR_PLANES_ARE_IN_PARALLEL,
                     sync_generation.LOG2_NUMBER_OF_COLOUR_PLANES = LOG2_NUMBER_OF_COLOUR_PLANES,
                     sync_generation.TOTALS_MINUS_ONE = 0;
    end else begin
        assign sof = 1'b0;
        assign sof_locked = 1'b0;
    end
end endgenerate

// conversion of sequential colour planes into parallel colours places, clock crossing using a dc fifo and
// output to Avalon-ST Video
generate begin : avalon_st_output
    if(GENERATE_SYNC < 2) begin
        wire wrreq_post_swap;
        wire [DATA_WIDTH-1:0] data_post_swap;
        wire packet_post_swap;
        
        // if we are in sequential to parallel conversion mode then insert a write buffer to do the conversion
        if(CONVERT_SEQ_TO_PAR) begin
            alt_vipcti131_Vid2IS_write_buffer #(
                    .DATA_WIDTH(DATA_WIDTH),
                    .NUMBER_OF_COLOUR_PLANES(NUMBER_OF_COLOUR_PLANES),
                    .BPS(BPS))
                write_buffer(
                    .rst(rst_vid_clk),
                    .clk(vid_clk_int),
                    
                    .convert(convert),
                    .hd_sdn(vid_hd_sdn_input),
                    .early_eop(early_eop),
                    
                    .wrreq_in(wrreq_pre_swap),
                    .data_in(data),
                    .packet_in(packet),
                    
                    .wrreq_out(wrreq_post_swap),
                    .data_out(data_post_swap),
                    .packet_out(packet_post_swap));
        end else begin
            assign data_post_swap = data;
            assign wrreq_post_swap = wrreq_pre_swap;
            assign packet_post_swap = packet;
        end
        
        wire [FIFO_WIDTH-1:0] q;
        wire empty;
        
        alt_vipcti131_common_fifo #(
                .DATA_WIDTH(FIFO_WIDTH),
                .CLOCKS_ARE_SAME(CLOCKS_ARE_SAME),
                .FIFO_DEPTH(FIFO_DEPTH_INT))
            input_fifo(
                .wrclk(vid_clk_int),
                .rdreq(rdreq),
                .aclr(rst_vid_clk),
                .rdclk(is_clk),
                .wrreq(wrreq_post_swap),
                .data({data_post_swap, packet_post_swap}),
                .rdusedw(usedw),
                .rdempty(empty),
                .wrfull(full),
                .q(q));
         
        wire enable_resync1;
        wire is_field_prediction;
        
        alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) field_prediction_sync(
            .rst(rst),
            .sync_clock(is_clk),
            .data_in(field_prediction),
            .data_out(is_field_prediction));

        alt_vipcti131_common_sync #(CLOCKS_ARE_SAME) enable_resync_sync(
            .rst(rst),
            .sync_clock(is_clk),
            .data_in(enable_synced),
            .data_out(enable_resync1));
         
        // TODO - control packet insertion should be done before the input_fifo
        // that would remove the need for this output module (it would turn into
        // a read from the input_fifo)
        alt_vipcti131_Vid2IS_av_st_output #(
                .FIFO_WIDTH(FIFO_WIDTH),
                .DATA_WIDTH(DATA_WIDTH),
                .NUMBER_OF_COLOUR_PLANES_IN_PARALLEL(NUMBER_OF_COLOUR_PLANES_IN_PARALLEL),
                .BPS(BPS))
            av_st_output(
                .rst(rst),
                
                .enable(enable_resync1),
                .q(q),
                .rdreq(rdreq),
                .empty(empty),
                .is_interlaced(is_interlaced),
                .is_sync_to(2'b10),
                .is_field_prediction(is_field_prediction),
                .is_active_sample_count(is_active_sample_count),
                .is_active_line_count_f0(is_active_line_count_f0),
                .is_active_line_count_f1(is_active_line_count_f1),
                
                .is_clk(is_clk),
                .is_ready(is_ready),
                .is_valid(is_valid),
                .is_data(is_data),
                .is_sop(is_sop),
                .is_eop(is_eop),
                
                .is_output_enable(is_output_enable));
    end else begin
        assign is_valid = 1'b0;
        assign is_sop = 1'b0;
        assign is_eop = 1'b0;
        assign is_data = {DATA_WIDTH{1'b0}};
    end
end endgenerate

endmodule
