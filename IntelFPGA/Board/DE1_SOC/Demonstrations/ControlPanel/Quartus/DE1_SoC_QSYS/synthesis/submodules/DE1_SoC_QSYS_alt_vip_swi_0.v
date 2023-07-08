
module DE1_SoC_QSYS_alt_vip_swi_0(
    input wire clock,
    input wire reset,
    
    // din
    output wire din_0_ready,
    input wire din_0_valid,
    input wire [24-1:0] din_0_data,
    input wire din_0_startofpacket,
    input wire din_0_endofpacket,
    output wire din_1_ready,
    input wire din_1_valid,
    input wire [24-1:0] din_1_data,
    input wire din_1_startofpacket,
    input wire din_1_endofpacket,

        // dout
    input wire dout_0_ready,
    output wire dout_0_valid,
    output wire [24-1:0] dout_0_data,
    output wire dout_0_startofpacket,
    output wire dout_0_endofpacket,

   // control
   input wire [5-1:0] control_address,
   input wire control_read,
   output wire [32-1:0] control_readdata,
   input wire control_write,
   input wire [32-1:0] control_writedata);

wire enable;
wire [1:0] select;
wire [0:0] synced;

// control
alt_vipswi130_switch_control #(
        .AV_ADDRESS_WIDTH(5),
        .AV_DATA_WIDTH(32),
        .NO_INPUTS(2),
        .NO_OUTPUTS(1),
        .NO_SYNCS(1)
    )
    control(
        .rst(reset),
        .clk(clock),
        
        // control
        .av_address(control_address),
        .av_read(control_read),
        .av_readdata(control_readdata),
        .av_write(control_write),
        .av_writedata(control_writedata),
        
        // internal
        .enable(enable),
        .select(select),
        .synced(synced));

// inputs
reg [0:0] input_int_ready0;
wire input_int_valid0;
wire [24-1:0] input_int_data0;
wire input_int_sop0;
wire input_int_eop0;

alt_vipswi130_common_stream_input #(
        .DATA_WIDTH(24)
    )
    input0(
        .rst(reset),
        .clk(clock),
        
        // din
        .din_ready(din_0_ready),
        .din_valid(din_0_valid),
        .din_data(din_0_data),
        .din_sop(din_0_startofpacket),
        .din_eop(din_0_endofpacket),
        
        // internal
        .int_ready(|input_int_ready0),
        .int_valid(input_int_valid0),
        .int_data(input_int_data0),
        .int_sop(input_int_sop0),
        .int_eop(input_int_eop0));


reg [0:0] input_int_ready1;
wire input_int_valid1;
wire [24-1:0] input_int_data1;
wire input_int_sop1;
wire input_int_eop1;

alt_vipswi130_common_stream_input #(
        .DATA_WIDTH(24)
    )
    input1(
        .rst(reset),
        .clk(clock),
        
        // din
        .din_ready(din_1_ready),
        .din_valid(din_1_valid),
        .din_data(din_1_data),
        .din_sop(din_1_startofpacket),
        .din_eop(din_1_endofpacket),
        
        // internal
        .int_ready(|input_int_ready1),
        .int_valid(input_int_valid1),
        .int_data(input_int_data1),
        .int_sop(input_int_sop1),
        .int_eop(input_int_eop1));


// muxes
wire output_int_ready0;
reg output_int_valid0;
reg [24-1:0] output_int_data0;
reg output_int_sop0;
reg output_int_eop0;
reg alpha_output_int_valid0;
reg [8-1:0] alpha_output_int_data0;
reg alpha_output_int_sop0;
reg alpha_output_int_eop0;
wire alpha_output_int_ready0;

always @ (select[1:0]
          or input_int_valid0 or input_int_data0
          or input_int_sop0 or input_int_eop0
          or input_int_valid1 or input_int_data1
          or input_int_sop1 or input_int_eop1
          or output_int_ready0
          ) begin
    case(select[1:0])
        2'd1: begin
                 output_int_valid0 = input_int_valid0;
                 output_int_data0 = input_int_data0;
                 output_int_sop0 = input_int_sop0;
                 output_int_eop0 = input_int_eop0;
                 input_int_ready0[0] = output_int_ready0;
                 input_int_ready1[0] = 1'b0;
                 end

        2'd2: begin
                 output_int_valid0 = input_int_valid1;
                 output_int_data0 = input_int_data1;
                 output_int_sop0 = input_int_sop1;
                 output_int_eop0 = input_int_eop1;
                 input_int_ready0[0] = 1'b0;
                 input_int_ready1[0] = output_int_ready0;
                 end

        default: begin
                 output_int_valid0 = 1'b0;
                 output_int_data0 = {24{1'b0}};
                 output_int_sop0 = 1'b0;
                 output_int_eop0 = 1'b0;
                 input_int_ready0[0] = 1'b0;
                 input_int_ready1[0] = 1'b0;
                 end
    endcase
end

// outputs
alt_vipswi130_common_stream_output #(
        .DATA_WIDTH(24)
    )
    output0(
        .rst(reset),
        .clk(clock),
        
        // dout
        .dout_ready(dout_0_ready),
        .dout_valid(dout_0_valid),
        .dout_data(dout_0_data),
        .dout_sop(dout_0_startofpacket),
        .dout_eop(dout_0_endofpacket),
        
        // internal
        .int_ready(output_int_ready0),
        .int_valid(output_int_valid0),
        .int_data(output_int_data0),
        .int_sop(output_int_sop0),
        .int_eop(output_int_eop0),
        
        // control signals
        .enable(enable),
        .synced(synced[0]));


endmodule
