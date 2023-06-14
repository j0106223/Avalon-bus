module avs_uart (
    clk,
    reset_n,
    avs_s0_address,
    avs_s0_read,
    avs_s0_write,
    avs_s0_waitrequest,
    avs_s0_readdata,
    avs_s0_writedata
);
    reg [7:0]rx_data;
    reg [7:0]tx_data;
    reg [7:0]control;
    reg [7:0]status;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            rx_data <= 0;
            tx_data <= 0;
            control <= 0;
            status  <= 0;
        end else begin
            if(avs_s0_write)begin
                case (avs_s0_address)
                    0: rx_data <= avs_s0_writedata;
                    1: tx_data <= avs_s0_writedata;
                    2: control <= avs_s0_writedata;
                    3: status  <= avs_s0_writedata; 
                endcase
            end
        end
    end
    reg [7:0]readdate;
    assign avs_s0_readdata = {24'b0, readdate};
    always @(*) begin
        readdate = 0;
        if(avs_s0_read)begin
            case (avs_s0_address)
                0: readdate = rx_data;
                1: readdate = tx_data;
                2: readdate = control;
                3: readdate = status;
                default: readdate = 0;
            endcase
        end else begin
            readdate = 0;
        end
    end
endmodule