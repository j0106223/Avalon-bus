module alt_vipcti130_Vid2IS_control
    #(parameter
        USE_CONTROL = 1,
        INTERLACED = 1,
        H_ACTIVE_PIXELS_F0 = 1920,
        V_ACTIVE_LINES_F0 = 540,
        V_ACTIVE_LINES_F1 = 540,
        USED_WORDS_WIDTH = 15,
        STD_WIDTH = 3)
    (
    input   wire rst,
    input   wire clk,
    
    // From FIFO
    input   wire [USED_WORDS_WIDTH-1:0] usedw,
    input   wire overflow_sticky,
    input   wire is_output_enable,  // from the outgoing state machine
    
    // From resolution detection
    input   wire update,
    input   wire resolution_change,
    input   wire interlaced,
    input   wire [14:0] active_sample_count,
    input   wire [13:0] active_line_count_f0,
    input   wire [13:0] active_line_count_f1,
    input   wire [14:0] total_sample_count,
    input   wire [13:0] total_line_count_f0,
    input   wire [13:0] total_line_count_f1,
    input   wire stable,
    input   wire resolution_valid,
    input   wire [STD_WIDTH-1:0] vid_std, // from the incoming video
    
    // Vid2IS control signals
    output  wire enable,
    output  wire clear_overflow_sticky,
    output  reg  is_interlaced,
    output  reg  [16:0] is_active_sample_count,
    output  reg  [16:0] is_active_line_count_f0,
    output  reg  [16:0] is_active_line_count_f1,
    output  reg  [13:0] sof_sample,
    output  reg  [12:0] sof_line,
    output  reg  [1:0] sof_subsample,
    output  reg  [13:0] refclk_divider_value,
    output  reg  genlock_enable,
    
    // Aavalon-MM slave port
    input   wire [3:0] av_address,
    input   wire av_read,
    output  wire [15:0] av_readdata,
    input   wire av_write,
    input   wire [15:0] av_writedata,
    
    output  wire status_update_int);
    
reg is_stable;
reg [16:0] is_total_sample_count;
reg [16:0] is_total_line_count_f0;
reg [16:0] is_total_line_count_f1;
wire [15:0] is_std;
wire is_update;
reg is_update_reg;
reg is_resolution_valid;

// The control interface has one register bit 0 of which (when set to a 1) 
// enables the ImageStream output.
generate
    if(USE_CONTROL) begin
        reg enable_reg;
        wire [15:0] usedw_output;
        reg status_update_int_reg;
        reg stable_int_reg;
        reg is_stable_reg;
        wire clear_interrupts;
        reg [1:0] interrupt_enable;
        reg clear_overflow_sticky_reg;
        reg resolution_change_reg;
        
        if(USED_WORDS_WIDTH >= 16)
            assign usedw_output = usedw[15:0];
        else
            assign usedw_output = {{16-USED_WORDS_WIDTH{1'b0}}, usedw};
        
        assign enable = enable_reg;
        assign av_readdata = (av_address == 4'd1)  ? {{5{1'b0}}, is_resolution_valid,
                                                                 overflow_sticky,
                                                                 is_stable,
                                                                 is_interlaced,
                                                                 is_active_line_count_f1[0] & is_total_line_count_f1[0],
                                                                 1'b0,
                                                                 is_active_line_count_f0[0] & is_total_line_count_f0[0],
                                                                 is_active_sample_count[0] & is_total_sample_count[0],
                                                                 2'b0,
                                                                 is_output_enable} :
                             (av_address == 4'd2)  ? {13'd0, stable_int_reg, status_update_int_reg, 1'b0} :
                             (av_address == 4'd3)  ? usedw_output :
                             (av_address == 4'd4)  ? is_active_sample_count[16:1] :
                             (av_address == 4'd5)  ? is_active_line_count_f0[16:1] :
                             (av_address == 4'd6)  ? is_active_line_count_f1[16:1] :
                             (av_address == 4'd7)  ? is_total_sample_count[16:1] :
                             (av_address == 4'd8)  ? is_total_line_count_f0[16:1] :
                             (av_address == 4'd9)  ? is_total_line_count_f1[16:1] :
                             (av_address == 4'd10) ? is_std :
                             (av_address == 4'd11) ? {sof_sample, sof_subsample} :
                             (av_address == 4'd12) ? {3'd0, sof_line} :
                             (av_address == 4'd13) ? {2'd0, refclk_divider_value} :
                             {{12{1'b0}}, genlock_enable, interrupt_enable, enable_reg};
        assign status_update_int = status_update_int_reg | stable_int_reg;
        assign clear_interrupts = (av_write && av_address == 4'd2);
        assign clear_overflow_sticky = clear_overflow_sticky_reg;
        
        always @ (posedge rst or posedge clk) begin
            if(rst) begin
                genlock_enable <= 1'b0;
                interrupt_enable <= 2'b00;
                enable_reg <= 1'b0;
                status_update_int_reg <= 1'b0;
                stable_int_reg <= 1'b0;
                sof_sample <= 14'd0;
                sof_subsample <= 2'd0;
                sof_line <= 13'd0;
                refclk_divider_value <= 14'd0;
                
                is_stable_reg <= 1'b0;
                resolution_change_reg <= 1'b0;
                clear_overflow_sticky_reg <= 1'b0;
             end else begin
                {genlock_enable, interrupt_enable, enable_reg} <= (av_write && av_address == 4'd0) ? av_writedata[3:0] : {genlock_enable, interrupt_enable, enable_reg};
                status_update_int_reg <= ((resolution_change ^ resolution_change_reg) | status_update_int_reg) & ~(clear_interrupts & av_writedata[1]) & interrupt_enable[0];
                stable_int_reg <= ((is_stable ^ is_stable_reg) | stable_int_reg) & ~(clear_interrupts & av_writedata[2]) & interrupt_enable[1];
                if(av_write && av_address == 4'd11) begin
                    sof_sample <= av_writedata[15:2];
                    sof_subsample <= av_writedata[1:0];
                end
                sof_line <= (av_write && av_address == 4'd12) ? av_writedata[12:0] : sof_line;
                refclk_divider_value <= (av_write && av_address == 4'd13) ? av_writedata[13:0] : refclk_divider_value;
                
                is_stable_reg <= is_stable;
                resolution_change_reg <= resolution_change;
                clear_overflow_sticky_reg <= ((av_write && av_address == 4'd1 && av_writedata[9]) | clear_overflow_sticky_reg) & overflow_sticky;
             end
        end
    end else begin
        assign enable = 1'b1;
        assign status_update_int = 1'b0;
        assign clear_overflow_sticky = 1'b0;
        
        always @ (posedge clk) begin
            genlock_enable <= 1'b0;
            sof_sample <= 14'd0;
            sof_subsample <= 2'd0;
            sof_line <= 13'd0;
            refclk_divider_value <= 14'd0;
        end
        
    end
endgenerate

always @ (posedge rst or posedge clk) begin
    if(rst) begin
        is_stable <= 1'b0;
        is_interlaced <= INTERLACED;
        is_active_sample_count <= {H_ACTIVE_PIXELS_F0, 1'b1};
        is_active_line_count_f0 <= {V_ACTIVE_LINES_F0, 1'b1};
        is_active_line_count_f1 <= (INTERLACED) ? {V_ACTIVE_LINES_F1, 1'b1} : 17'd0;
        is_total_sample_count <= 17'd0;
        is_total_line_count_f0 <= 17'd0;
        is_total_line_count_f1 <= 17'd0;
        is_resolution_valid <= 1'b0;
        
        is_update_reg <= 1'b0; 
     end else begin
        is_stable <= (is_update) ? stable : is_stable;
        is_interlaced <= (is_update) ? interlaced : is_interlaced;
        is_active_sample_count <= (is_update) ? {1'd0, active_sample_count} : is_active_sample_count;
        is_active_line_count_f0 <= (is_update) ? {2'd0, active_line_count_f0} : is_active_line_count_f0;
        is_active_line_count_f1 <= (is_update) ? {2'd0, active_line_count_f1} : is_active_line_count_f1;
        is_total_sample_count <= (is_update) ? {1'd0, total_sample_count} : is_total_sample_count;
        is_total_line_count_f0 <= (is_update) ? {2'd0, total_line_count_f0} : is_total_line_count_f0;
        is_total_line_count_f1 <= (is_update) ? {2'd0, total_line_count_f1} : is_total_line_count_f1;
        is_resolution_valid <= (is_update) ? resolution_valid : is_resolution_valid;
        
        is_update_reg <= update;
     end
end
    
assign is_update = update ^ is_update_reg;

generate
	if(STD_WIDTH >= 16)
    	assign is_std = vid_std[15:0];
	else
    	assign is_std = {{16-STD_WIDTH{1'b0}}, vid_std};
endgenerate

endmodule
