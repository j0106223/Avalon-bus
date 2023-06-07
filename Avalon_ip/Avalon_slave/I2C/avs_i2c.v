module avs_i2c (
    clk,
    reset_n,
    avs_s0_address,
    avs_s0_read,
    avs_s0_write,
    avs_s0_waitrequest,
    avs_s0_readdata,
    avs_s0_writedata
);
    input clk;
    input reset_n;
    input         avs_s0_address;
    input         avs_s0_read;
    input         avs_s0_write;
    output        avs_s0_waitrequest;
    output [31:0] avs_s0_readdata;
    input  [31:0] avs_s0_writedata;
    output        avs_s0_export_scl;
    output        avs_s0_export_sda;

//==================register map begin======================
    reg [31:0] rdata;
    reg [31:0] wdata;
    reg [31:0] control;
    reg [31:0] status;
    reg [31:0] clk_div;
//==================register map end========================
    //write register
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            rdata   <= 0;
            wdata   <= 0;
            control <= 0;
            status  <= 0;
            clk_div <= 0;
        end else begin
            if(avs_s0_write)begin
                case (avs_s0_address)
                    0:rdata   <= avs_s0_writedata;
                    0:wdata   <= avs_s0_writedata;
                    0:control <= avs_s0_writedata;
                    0:status  <= avs_s0_writedata;
                    0:clk_div <= avs_s0_writedata;
                endcase
            end
        end
    end
    reg [31:0]readdata;
    assign avs_s0_readdata = readdata;
    always @(*) begin
        readdata = 0;
        if(avs_s0_read)begin
            case (avs_s0_address)
                0: readdata = rdata;
                1: readdata = wdata;
                2: readdata = control;
                3: readdata = status;
                4: readdata = clk_div; 
            endcase
        end
    end
endmodule