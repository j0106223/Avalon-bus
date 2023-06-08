module avs_ps2 (
    clk,
    reset_n,
    avs_s0_address,
    avs_s0_read,
    avs_s0_write,
    avs_s0_waitrequest,
    avs_s0_readdata,
    avs_s0_writedata
);
    input         clk;
    input         reset_n;
    input         avs_s0_address;
    input         avs_s0_read;
    input         avs_s0_write;
    output        avs_s0_waitrequest;
    output [31:0] avs_s0_readdata;
    input  [31:0] avs_s0_writedata;
    output        avs_s0_irq;
    output        avs_s0_export_ps2_clk;
    output        avs_s0_export_ps2_data;

//these three register follow intel i8042 convention

    //Data Register (I/O Port 0x60)
    //Command Register (I/O Port 0x64)
    //Status Register (I/O Port 0x64)
    reg [7:0]data;
    reg [7:0]control;// or you can call it commnad
    reg [7:0]status;

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            data    <= 0;
            control <= 0;
            status  <= 0;
        end else begin
            if(avs_s0_write)begin
                case(avs_s0_address)
                    0:data    <= avs_s0_writedata[7:0];
                    1:control <= avs_s0_writedata[7:0];
                endcase
            end
        end
    end

    reg [7:0]readdata;
    assign avs_s0_readdata = {24'b0, readdata};
    always @(*) begin
        readdata = 0;
        if(avs_s0_read)begin
            case (avs_s0_address)
                0:readdata = data;
                1:readdata = status; 
            endcase
        end
    end
endmodule