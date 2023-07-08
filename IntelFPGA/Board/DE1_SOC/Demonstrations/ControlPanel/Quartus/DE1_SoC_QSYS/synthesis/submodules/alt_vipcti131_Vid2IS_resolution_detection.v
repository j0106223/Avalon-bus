module alt_vipcti131_Vid2IS_resolution_detection(
    input wire rst,
    input wire clk,
    
    input wire count_cycle,
    input wire ap,
    input wire hd_sdn,
    input wire start_new_line,
    input wire start_new_field,
    input wire end_of_vsync,
    input wire f,
    input wire vid_locked,
    
    output reg update,
    output reg interlaced,
    output reg [14:0] active_sample_count,
    output reg [13:0] active_line_count_f0,
    output reg [13:0] active_line_count_f1,
    output reg [14:0] total_sample_count,
    output reg [13:0] total_line_count_f0,
    output reg [13:0] total_line_count_f1,
    output reg [13:0] total_line_count,
    output reg stable,
    output reg resolution_valid,
    output reg resolution_change);
    
parameter NUMBER_OF_COLOUR_PLANES = 0;
parameter COLOUR_PLANES_ARE_IN_PARALLEL = 0;
parameter LOG2_NUMBER_OF_COLOUR_PLANES = 0;
parameter H_ACTIVE_PIXELS = 0;
parameter V_ACTIVE_LINES_F0 = 0;
parameter V_ACTIVE_LINES_F1 = 0;
parameter INTERLACED = 0;

wire count_sample;
wire ap_plus_1;
reg active_line;
wire end_of_active_line;

alt_vipcti131_common_sample_counter sample_counter(
    .rst(rst),
    .clk(clk),
    .sclr(1'b0),
    .hd_sdn(hd_sdn),
    .count_cycle(count_cycle),
    .count_sample(count_sample));
    
defparam sample_counter.NUMBER_OF_COLOUR_PLANES = NUMBER_OF_COLOUR_PLANES,
         sample_counter.COLOUR_PLANES_ARE_IN_PARALLEL = COLOUR_PLANES_ARE_IN_PARALLEL,
         sample_counter.LOG2_NUMBER_OF_COLOUR_PLANES = LOG2_NUMBER_OF_COLOUR_PLANES;

assign ap_plus_1 = count_sample & ap;
assign end_of_active_line = start_new_line & active_line;

reg [1:0] current_field;
reg [1:0] prev_field;
reg start_new_field_sticky;
reg reset_line_count;
wire reset_line_count_nxt;
wire stable_next;
reg stable_reg;
reg first_start_of_line;
reg first_start_new_field;
wire [2:0] lines_next;
reg [2:0] lines;
reg [13:0] next_active_sample_count;    // 16384
reg [12:0] next_active_line_count;      // 8192
reg [13:0] next_total_sample_count;
reg [12:0] next_total_line_count;
wire [14:0] active_sample_count_nxt;
wire [13:0] active_line_count_f0_nxt;
wire [13:0] active_line_count_f1_nxt;
wire [14:0] total_sample_count_nxt;
wire [13:0] total_line_count_f0_nxt;
wire [13:0] total_line_count_f1_nxt;
wire reset_sample;
wire reset_f0;
wire reset_f1;
wire reset_total_sample;
wire reset_total_f0;
wire reset_total_f1;
wire update_active_line_f1;
wire update_active_sample;
wire update_active_line_f0;
wire update_total_sample;
wire update_total_line_f0;
wire update_total_line_f1;
wire field_update;
wire stable_update;
wire resolution_valid_update;
wire field_0;
wire field_1;
wire update_sample;
reg interlaced_valid;
wire resolution_valid_nxt;
reg resolution_valid_reg;
reg second_active_line;

// These signals count the samples and lines of the frame
always @ (posedge rst or posedge clk) begin
    if(rst) begin
        current_field <= {INTERLACED, 1'b0};
        prev_field <= 2'b00;
        interlaced <= 1'b0;
        interlaced_valid <= 1'b0;
        start_new_field_sticky <= 1'b0;
        reset_line_count <= 1'b0;
        
        lines <= 3'b000;
        stable <= 1'b0;
        stable_reg <= 1'b0;
        
        active_line <= 1'b0;
        next_active_sample_count <= 14'd0;
        next_active_line_count <= 13'd0;
        next_total_sample_count <= 14'd0;
        next_total_line_count <= 13'd0;
        active_sample_count <= {H_ACTIVE_PIXELS, 1'b1};
        active_line_count_f0 <= {V_ACTIVE_LINES_F0, 1'b1};
        active_line_count_f1 <= (INTERLACED) ? {V_ACTIVE_LINES_F1, 1'b1} : 17'd0;
        total_sample_count <= 15'd0;
        total_line_count_f0 <= 14'd0;
        total_line_count_f1 <= 14'd0;
        total_line_count <= 14'd0;
        
        update <= 1'b0;
        first_start_new_field <= 1'b0;
        first_start_of_line <= 1'b0;
        second_active_line <= 1'b0;
        
        resolution_valid <= 1'b0;
        resolution_valid_reg <= 1'b0;
        resolution_change <= 1'b0;
    end else begin
        // the incoming video is interlaced if the current field or the previous
        // field is 1
        current_field <= (~vid_locked) ? {current_field[1], 1'b0} : (end_of_vsync) ? {f, 1'b1} : current_field;
        prev_field <= (~vid_locked) ? {prev_field[1], 1'b0} : (end_of_vsync) ? current_field : prev_field;
        interlaced <= current_field[1] | prev_field[1];
        interlaced_valid <= current_field[0] & prev_field[0];
        start_new_field_sticky <= (start_new_field | start_new_field_sticky) & ~start_new_line;
        reset_line_count <= reset_line_count_nxt;
        
        // if two out of the last 3 lines were consistent then we are stable
        lines <= lines_next;
        stable <= stable_next;
        stable_reg <= stable;
        
        active_line <= (ap | active_line) & ~start_new_line;
        next_active_sample_count <= (end_of_active_line) ? 14'd0 : (ap_plus_1) ? next_active_sample_count + 14'd1 : next_active_sample_count;
        next_active_line_count <= (reset_line_count) ? 13'd0 : (end_of_active_line) ? next_active_line_count + 13'd1 : next_active_line_count;
        next_total_sample_count <= (start_new_line) ? {13'd0, count_sample} : (count_sample) ? next_total_sample_count + 14'd1 : next_total_sample_count;
        next_total_line_count <= (reset_line_count) ? 13'd0 : (start_new_line) ? next_total_line_count + 13'd1 : next_total_line_count;
        
        // if the f1 field is valid and we notice it change then we must reset the f0 field also and vice versa.
        active_sample_count <= active_sample_count_nxt;
        active_line_count_f0 <= active_line_count_f0_nxt;
        active_line_count_f1 <= active_line_count_f1_nxt;
        total_sample_count <= total_sample_count_nxt;
        total_line_count_f0 <= total_line_count_f0_nxt;
        total_line_count_f1 <= total_line_count_f1_nxt;
        total_line_count[13:1] <= (~interlaced) ? total_line_count_f0_nxt[13:1] : total_line_count_f0_nxt[13:1] + total_line_count_f1_nxt[13:1];
        total_line_count[0] <= total_line_count_f0_nxt[0] & (~interlaced | total_line_count_f1_nxt[0]);
        
        update <= update ^ (field_update | stable_update | resolution_valid_update);
        first_start_of_line <= (start_new_line | first_start_of_line) & vid_locked;
        first_start_new_field <= (reset_line_count | first_start_new_field) & vid_locked;
        second_active_line <= (end_of_active_line | (second_active_line & ~start_new_line)) & vid_locked;  // we don't count the first active line for total sample
                                                                                                           // count because the hsync timing can change during vblank
        
        resolution_valid <= resolution_valid_nxt;
        resolution_valid_reg <= resolution_valid;
        resolution_change <= resolution_change ^ ((resolution_valid & resolution_valid_nxt & field_update) | (resolution_valid & ~resolution_valid_reg));
    end
end

assign reset_line_count_nxt = start_new_line & (start_new_field | start_new_field_sticky);

assign lines_next = (~vid_locked) ? 3'b000 : (start_new_line) ? {lines[1:0], ~update_sample} : lines;
assign stable_next = vid_locked & first_start_of_line & ((lines_next[0] & lines_next[1]) | (lines_next[0] & lines_next[2]) | (lines_next[1] & lines_next[2]));

assign resolution_valid_nxt = active_sample_count_nxt[0] & total_sample_count_nxt[0] &
                              active_line_count_f0_nxt[0] & total_line_count_f0_nxt[0] &
                              ((active_line_count_f1_nxt[0] & total_line_count_f1_nxt[0]) | ~interlaced) &
                              interlaced_valid;

assign active_sample_count_nxt = (update_active_sample) ? {next_active_sample_count, 1'b1} : active_sample_count;
assign active_line_count_f0_nxt = (reset_f0) ? {active_line_count_f0[13:1], 1'b0} : (update_active_line_f0) ? {next_active_line_count, 1'b1} : active_line_count_f0;
assign active_line_count_f1_nxt = (reset_f1) ? {active_line_count_f1[13:1], 1'b0} : (update_active_line_f1) ? {next_active_line_count, 1'b1} : active_line_count_f1;
assign total_sample_count_nxt = (update_total_sample) ? {next_total_sample_count, 1'b1} : total_sample_count;
assign total_line_count_f0_nxt = (reset_total_f0) ? {total_line_count_f0[13:1], 1'b0} : (update_total_line_f0) ? {next_total_line_count, 1'b1} : total_line_count_f0;
assign total_line_count_f1_nxt = (reset_total_f1) ? {total_line_count_f1[13:1], 1'b0} : (update_total_line_f1) ? {next_total_line_count, 1'b1} : total_line_count_f1;

assign field_update = (update_active_sample | update_active_line_f0 | update_active_line_f1 |
                       update_total_sample | update_total_line_f0 | update_total_line_f1);
assign stable_update = stable_next ^ stable;
assign resolution_valid_update = resolution_valid_nxt ^ resolution_valid;

// if we detect a change in the line count we must reset the other field
assign reset_sample = (update_active_sample & active_sample_count[0]);
assign reset_f0 = reset_sample | (update_active_line_f1 & active_line_count_f1[0]);
assign reset_f1 = reset_sample | (update_active_line_f0 & active_line_count_f0[0]);

assign reset_total_sample = (update_total_sample & total_sample_count[0]);
assign reset_total_f0 = reset_total_sample | (update_total_line_f1 & total_line_count_f1[0]);
assign reset_total_f1 = reset_total_sample | (update_total_line_f0 & total_line_count_f0[0]);

assign field_0 = reset_line_count & ~f;
assign field_1 = reset_line_count & f;

assign update_active_sample = (end_of_active_line) && (next_active_sample_count != active_sample_count[14:1] || !active_sample_count[0]) && first_start_of_line;
assign update_active_line_f0 = field_0 && (next_active_line_count != active_line_count_f0[13:1] || !active_line_count_f0[0]) && first_start_new_field;
assign update_active_line_f1 = field_1 && (next_active_line_count != active_line_count_f1[13:1] || !active_line_count_f1[0]) && first_start_new_field;

assign update_total_sample = (end_of_active_line && second_active_line) && (next_total_sample_count != total_sample_count[14:1] || !total_sample_count[0]) && first_start_of_line;
assign update_total_line_f0 = field_0 && (next_total_line_count != total_line_count_f0[13:1] || !total_line_count_f0[0]) && first_start_new_field;
assign update_total_line_f1 = field_1 && (next_total_line_count != total_line_count_f1[13:1] || !total_line_count_f1[0]) && first_start_new_field;

assign update_sample = update_active_sample & update_total_sample;

endmodule
