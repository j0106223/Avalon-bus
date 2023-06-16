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
    reg [31:0]clk_div;
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            tx_data <= 0;
            control <= 0;
            status  <= 0;
            clk_div <= 0;
        end else begin
            if(avs_s0_write)begin
                case (avs_s0_address)
                    1: tx_data <= avs_s0_writedata;
                    2: control <= avs_s0_writedata;
                    3: status  <= avs_s0_writedata;
                    4: clk_div <= avs_s0_writedata;
                endcase
            end
        end
    end

    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            status<=0;
        end else begin
            if()begin
            end else begin
            end
        end
    end
    reg [7:0]readdate;
    assign avs_s0_readdata = {24'b0, readdate};
    always @(*) begin
        readdate = 0;
        if(avs_s0_read)begin
            case (avs_s0_address)
                0: avs_s0_readdata = {24'b0, rx_data};
                1: avs_s0_readdata = {24'b0, tx_data};
                2: avs_s0_readdata = {24'b0, control};
                3: avs_s0_readdata = {24'b0, status};
                4: avs_s0_readdata = clk_div;
                default: readdate = 0;
            endcase
        end else begin
            readdate = 0;
        end
    end


    wire uart_clk;
    wire rx_clk;
    wire tx_clk;
    assign rx_clk = uart_clk;
    assign tx_clk = uart_clk;
    clk_gen uart_clk_gen(
        .clk_i   (clk),
        .reset_n (reset_n),
        .clk_div (clk_div),
        .clk_o   (uart_clk)
    );

    uart_core uart_core_inst(
        .reset_n    (reset_n),
        .rx_clk     (rx_clk),
        .rx_data    (rx_data),
        .rx_done    (rx_done),
        .rx         (rx),
        .tx_clk     (tx_clk),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx)
    );
endmodule