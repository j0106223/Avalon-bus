module alt_vipcti131_Vid2IS_av_st_output
    #(parameter
        FIFO_WIDTH = 20,
        DATA_WIDTH = 20,
        NUMBER_OF_COLOUR_PLANES_IN_PARALLEL = 2,
        BPS = 10)
    (
        input wire rst,
        
        input wire enable,
        input wire [FIFO_WIDTH-1:0] q,
        output wire rdreq,
        input wire empty,
        input wire is_interlaced,
        input wire [1:0] is_sync_to,
        input wire is_field_prediction,
        input wire [16:0] is_active_sample_count,
        input wire [16:0] is_active_line_count_f0,
        input wire [16:0] is_active_line_count_f1,
        
        // IS
        input wire is_clk,
        input wire is_ready,
        output wire is_valid,
        output reg [DATA_WIDTH-1:0] is_data,
        output reg is_sop,
        output reg is_eop,
        
        output wire is_output_enable);

localparam [3:0] IDLE            = 4'd0;
localparam [3:0] CONTROL_HEADER  = 4'd1;
localparam [3:0] WIDTH_3         = 4'd2;
localparam [3:0] WIDTH_2         = 4'd3;
localparam [3:0] WIDTH_1         = 4'd4;
localparam [3:0] WIDTH_0         = 4'd5;
localparam [3:0] HEIGHT_3        = 4'd6;
localparam [3:0] HEIGHT_2        = 4'd7;
localparam [3:0] HEIGHT_1        = 4'd8;
localparam [3:0] HEIGHT_0        = 4'd9;
localparam [3:0] INTERLACING     = 4'd10;
localparam [3:0] HEADER          = 4'd11;
localparam [3:0] OUTPUT_DATA     = 4'd12;
localparam [3:0] WAIT            = 4'd13;
localparam [3:0] OUTPUT_ANC      = 4'd14;
        
wire [DATA_WIDTH-1:0] is_data_fifo;
wire is_packet;
reg is_valid_int;
reg is_valid_no_ready;
reg is_ready_reg;
wire [3:0] state_next;
reg [3:0] state;
wire [DATA_WIDTH-1:0] control_header_data;
wire is_ready_int;
reg request_data;
wire is_packet_valid;
reg stall;
wire request_data_next;
reg rdreq_reg;

assign {is_data_fifo, is_packet} = q;

// The fifo read latency is one, so the valid is a registered version of the 
// read request.
assign request_data_next = state_next == HEADER || state_next == OUTPUT_DATA || state_next == OUTPUT_ANC;
assign rdreq = request_data & (~is_valid_int | ~is_valid_no_ready | (is_valid_int & is_ready_reg)) & ~empty;
assign is_output_enable = enable | ~empty;
assign is_ready_int = ~is_valid_no_ready | is_valid;
assign is_valid = is_valid_no_ready & is_ready_reg;
assign is_packet_valid = is_packet & is_valid_int;

always @ (posedge rst or posedge is_clk) begin
    if(rst) begin
        state <= IDLE;
        is_valid_int <= 1'b0;
        is_data <= {DATA_WIDTH{1'b0}};
        is_sop <= 1'b0;
        is_eop <= 1'b0;
        is_valid_no_ready <= 1'b0;
        is_ready_reg <= 1'b0;
        stall <= 1'b0;
        request_data <= 1'b0;
        rdreq_reg <= 1'b0;
    end else begin
        if(is_ready_int) begin
            state <= state_next;
        end
        is_valid_int <= (state_next != IDLE && !(request_data_next && !rdreq)) || (is_valid_int && is_valid_no_ready && !is_ready_reg);
        if(is_ready_int) begin
            is_data <= (state == HEADER || state == OUTPUT_DATA || state == OUTPUT_ANC) ? is_data_fifo : control_header_data;
            is_sop <= state == CONTROL_HEADER | state == HEADER;
            is_eop <= state == (CONTROL_HEADER + (9/NUMBER_OF_COLOUR_PLANES_IN_PARALLEL) + (9%NUMBER_OF_COLOUR_PLANES_IN_PARALLEL == 0 ? 0 : 1)) ||
                               ((state == HEADER || state == OUTPUT_DATA || state == OUTPUT_ANC) && is_packet_valid);
        end
        is_valid_no_ready <= is_valid_int || (is_valid_no_ready && !is_ready_reg);
        is_ready_reg <= is_ready;
        request_data <= request_data_next;
        rdreq_reg <= rdreq;
    end
end

wire [16:0] cp_active_sample_count, cp_line_count;
reg [DATA_WIDTH-1:0] control_header_data_packed [8:0];
wire [3:0] control_header_state [8:0];

assign cp_active_sample_count = is_active_sample_count;
assign cp_line_count = (is_field_prediction) ? is_active_line_count_f1 : is_active_line_count_f0;

generate
    begin : generate_control_header
        genvar i;
        genvar symbol;
        for(symbol = 0; symbol < 9; symbol = symbol + NUMBER_OF_COLOUR_PLANES_IN_PARALLEL) begin : control_header_packing
            if(symbol + NUMBER_OF_COLOUR_PLANES_IN_PARALLEL >= 9)
                assign control_header_state[symbol/NUMBER_OF_COLOUR_PLANES_IN_PARALLEL] = HEADER;
            else
                assign control_header_state[symbol/NUMBER_OF_COLOUR_PLANES_IN_PARALLEL] = WIDTH_2 + symbol/NUMBER_OF_COLOUR_PLANES_IN_PARALLEL;
            
            for(i = 0; i < NUMBER_OF_COLOUR_PLANES_IN_PARALLEL; i = i + 1) begin  : pack_control_header
                always @ (posedge rst or posedge is_clk) begin
                    if(rst) begin
                        control_header_data_packed[symbol/NUMBER_OF_COLOUR_PLANES_IN_PARALLEL][BPS*i+(BPS-1):BPS*i] <= {BPS{1'b0}};
                    end else begin
                        if(state_next == CONTROL_HEADER) begin
                            control_header_data_packed[symbol/NUMBER_OF_COLOUR_PLANES_IN_PARALLEL][BPS*i+(BPS-1):BPS*i] <=
                                (symbol + i == 0) ? {{BPS-4{1'b0}}, cp_active_sample_count[16:13]} :
                                (symbol + i == 1) ? {{BPS-4{1'b0}}, cp_active_sample_count[12:9]} :
                                (symbol + i == 2) ? {{BPS-4{1'b0}}, cp_active_sample_count[8:5]} :
                                (symbol + i == 3) ? {{BPS-4{1'b0}}, cp_active_sample_count[4:1]} :
                                (symbol + i == 4) ? {{BPS-4{1'b0}}, cp_line_count[16:13]} :
                                (symbol + i == 5) ? {{BPS-4{1'b0}}, cp_line_count[12:9]} :
                                (symbol + i == 6) ? {{BPS-4{1'b0}}, cp_line_count[8:5]} :
                                (symbol + i == 7) ? {{BPS-4{1'b0}}, cp_line_count[4:1]} :
                                (symbol + i == 8) ? {{BPS-4{1'b0}}, is_interlaced, is_field_prediction, is_sync_to} :
                                    4'b0000;
                        end
                    end
                end
            end
        end
        
        // Supplementary block to assign a dummy value to the non-used signals.
        for(symbol = 1 + 9 / NUMBER_OF_COLOUR_PLANES_IN_PARALLEL; symbol < 9; symbol = symbol + 1) begin : supplementary_block
            assign control_header_state[symbol] = 4'b0;
            always @ (posedge is_clk) begin
               control_header_data_packed[symbol] <= {DATA_WIDTH{1'b0}};
            end
        end
        
    end
endgenerate

// Header packet insertion
wire insert_control_header;

assign insert_control_header = (is_field_prediction) ? is_active_line_count_f1[0] & is_active_sample_count[0] :
                                                       is_active_line_count_f0[0] & is_active_sample_count[0];

assign control_header_data = (state == WIDTH_3) ? control_header_data_packed[0] :
                             (state == WIDTH_2) ? control_header_data_packed[1] :
                             (state == WIDTH_1) ? control_header_data_packed[2] :
                             (state == WIDTH_0) ? control_header_data_packed[3] :
                             (state == HEIGHT_3) ? control_header_data_packed[4] :
                             (state == HEIGHT_2) ? control_header_data_packed[5] :
                             (state == HEIGHT_1) ? control_header_data_packed[6] :
                             (state == HEIGHT_0) ? control_header_data_packed[7] :
                             (state == INTERLACING) ? control_header_data_packed[8] : 4'd15;

assign state_next = (state == IDLE) ? (~empty) ? (insert_control_header) ? CONTROL_HEADER : HEADER :
                                                 IDLE :
                    (state == CONTROL_HEADER) ? WIDTH_3 :
                    (state == WIDTH_3) ? control_header_state[0] :
                    (state == WIDTH_2) ? control_header_state[1] :
                    (state == WIDTH_1) ? control_header_state[2] :
                    (state == WIDTH_0) ? control_header_state[3] :
                    (state == HEIGHT_3) ? control_header_state[4] :
                    (state == HEIGHT_2) ? control_header_state[5] :
                    (state == HEIGHT_1) ? control_header_state[6] :
                    (state == HEIGHT_0) ? control_header_state[7] :
                    (state == INTERLACING) ? control_header_state[8] :
                    (state == HEADER) ? (rdreq_reg) ? (is_packet_valid) ? (is_output_enable) ? HEADER : IDLE : 
                                                                          (is_data_fifo == 0) ? OUTPUT_DATA : OUTPUT_ANC : HEADER :
	                (state == OUTPUT_ANC) ? (is_packet_valid) ? (is_output_enable) ? HEADER : IDLE :
                                                                OUTPUT_ANC :
                    (state == OUTPUT_DATA) ? (is_packet_valid) ? (is_output_enable) ? (insert_control_header) ? CONTROL_HEADER : HEADER : IDLE :
                                                                 OUTPUT_DATA : IDLE;

endmodule
