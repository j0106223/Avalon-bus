module avs_i2s (
    clk,
    reset_n,
    avs_s0_address,
    avs_s0_read,
    avs_s0_write,
    avs_s0_waitrequest,
    avs_s0_readdata,
    avs_s0_writedata,
    avs_s0_export_i2s_sck,
    avs_s0_export_i2s_sd,
    avs_s0_export_i2s_ws,
);
    parameter DW = 16;
    input clk;
    input reset_n;
    input        avs_s0_address;
    input        avs_s0_read;
    input        avs_s0_write;
    output       avs_s0_waitrequest;
    output [31:0]avs_s0_readdata;
    input  [31:0]avs_s0_writedata;
    output avs_s0_export_i2s_sck;
    output avs_s0_export_i2s_sd;
    output avs_s0_export_i2s_ws;
    wire i2s_sck,
    wire i2s_sd,
    wire i2s_ws

//==================register map begin======================
reg [DW-1:0]data;
reg [31:0]clk_div;
reg [31:0]control;
reg [31:0]status;
//==================register map end========================
    //write register
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            data    <= 0;
            control <= 0;
            status  <= 0;
            clk_div <= 0;
        end else begin
            if(avs_s0_write)begin
                case (avs_s0_address)
                    0: data    <= avs_s0_writedata;
                    0: control <= avs_s0_writedata;
                    0: status  <= avs_s0_writedata;
                    0: clk_div <= avs_s0_writedata;
                endcase
            end
        end
    end

    //read register
    reg [31:0]readdata;
    assign avs_s0_readdata = readdata;
    always @(*) begin
        readdata = 0;
        if(avs_s0_read)begin
            case (avs_s0_address)
                0: readdata = data;
                1: readdata = control;
                2: readdata = status;
                3: readdata = clk_div;
            endcase
        end
    end

    wire i2s_clk;

    
endmodule