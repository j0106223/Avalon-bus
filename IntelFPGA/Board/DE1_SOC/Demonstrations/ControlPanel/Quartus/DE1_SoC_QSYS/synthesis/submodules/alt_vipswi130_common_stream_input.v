module alt_vipswi130_common_stream_input
    #(parameter
        DATA_WIDTH = 10)
    (
    input wire rst,
    input wire clk,
    
    // din
    output  wire                    din_ready,
    input   wire                    din_valid,
    input   wire [DATA_WIDTH-1:0]   din_data,
    input   wire                    din_sop,
    input   wire                    din_eop,
    
    // internal
    input   wire                    int_ready,
    output  reg                     int_valid,
    output  reg  [DATA_WIDTH-1:0]   int_data,
    output  reg                     int_sop,
    output  reg                     int_eop);

reg                     din_valid_reg;
reg [DATA_WIDTH-1:0]    din_data_reg;
reg                     din_sop_reg;
reg                     din_eop_reg;

reg                     din_valid_buf1_reg;
reg [DATA_WIDTH-1:0]    din_data_buf1_reg;
reg                     din_sop_buf1_reg;
reg                     din_eop_buf1_reg; 

reg                     din_valid_buf2_reg;
reg [DATA_WIDTH-1:0]    din_data_buf2_reg;
reg                     din_sop_buf2_reg;
reg                     din_eop_buf2_reg; 

reg                     int_ready_reg1;
reg                     int_ready_reg2;

// Buffer the input as we have a ready latency of 1 and are registering
// the ready output.
always @ (posedge clk or posedge rst) begin
    if(rst) begin
        din_valid_reg <= 1'b0;
        din_data_reg <= {DATA_WIDTH{1'b0}};
        din_sop_reg <= 1'b0;
        din_eop_reg <= 1'b0;
            
        din_valid_buf1_reg <= 1'b0;
        din_data_buf1_reg <= {DATA_WIDTH{1'b0}};
        din_sop_buf1_reg <= 1'b0;
        din_eop_buf1_reg <= 1'b0;
        
        din_valid_buf2_reg <= 1'b0;
        din_data_buf2_reg <= {DATA_WIDTH{1'b0}};
        din_sop_buf2_reg <= 1'b0;
        din_eop_buf2_reg <= 1'b0;
    end else begin
        if(int_ready_reg2) begin
            din_valid_reg <= din_valid;
            din_data_reg <= din_data;
            din_sop_reg <= din_sop;
            din_eop_reg <= din_eop;
                
            din_valid_buf1_reg <= din_valid_reg;
            din_data_buf1_reg <= din_data_reg;
            din_sop_buf1_reg <= din_sop_reg;
            din_eop_buf1_reg <= din_eop_reg;
                
            din_valid_buf2_reg <= din_valid_buf1_reg;
            din_data_buf2_reg <= din_data_buf1_reg;
            din_sop_buf2_reg <= din_sop_buf1_reg;
            din_eop_buf2_reg <= din_eop_buf1_reg;
        end
    end
end

always @ (posedge clk or posedge rst) begin
    if(rst) begin
        int_ready_reg1 <= 1'b0;
        int_ready_reg2 <= 1'b0;
    end else begin
        int_ready_reg1 <= int_ready;
        int_ready_reg2 <= int_ready_reg1;
    end
end

assign din_ready = int_ready_reg1;

// Select the correct buffer to feed through.
// reg2    reg1    reg    |    select    reg     buf1    buf2 
// 0       0       0      |    x         0       0       0
// 0       0       1      |    buf2      0       0       0
// 0       1       0      |    x         0       0       x
// 0       1       1      |    buf1      0       0       x
// 1       0       0      |    x         1       1       1
// 1       0       1      |    buf1      1       1       x
// 1       1       0      |    x         1       1       x
// 1       1       1      |    reg       1       x       x
always @ (int_ready_reg1 or int_ready_reg2 or 
          din_valid_reg or din_valid_buf1_reg or din_valid_buf2_reg or
          din_data_reg or din_data_buf1_reg or din_data_buf2_reg or
          din_sop_reg or din_sop_buf1_reg or din_sop_buf2_reg or
          din_eop_reg or din_eop_buf1_reg or din_eop_buf2_reg) begin
    case({int_ready_reg2, int_ready_reg1})
        2'b00: begin
                   int_valid <= din_valid_buf2_reg;
                   int_data <= din_data_buf2_reg;
                   int_sop <= din_sop_buf2_reg;
                   int_eop <= din_eop_buf2_reg;
               end
        2'b01: begin
                   int_valid <= din_valid_buf1_reg;
                   int_data <= din_data_buf1_reg;
                   int_sop <= din_sop_buf1_reg;
                   int_eop <= din_eop_buf1_reg;
               end
        2'b10: begin
                   int_valid <= din_valid_buf1_reg;
                   int_data <= din_data_buf1_reg;
                   int_sop <= din_sop_buf1_reg;
                   int_eop <= din_eop_buf1_reg;
               end
        2'b11: begin
                   int_valid <= din_valid_reg;
                   int_data <= din_data_reg;
                   int_sop <= din_sop_reg;
                   int_eop <= din_eop_reg;
               end
    endcase
end

endmodule
