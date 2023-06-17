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
    input          clk;
    input          reset_n;
    input    [2:0] avs_s0_address;
    input          avs_s0_read;
    input          avs_s0_write;
    output         avs_s0_waitrequest;
    output  [31:0] avs_s0_readdata;
    input   [31:0] avs_s0_writedata;

    reg  [7:0] rx_data; //reg[0]
    reg  [7:0] tx_data; //reg[1]
    reg  [7:0] control; //reg[2]
    reg  [7:0] status;  //reg[3]
    reg [31:0] clk_div; //reg[4]
    wire tx_data_we = avs_s0_write & (avs_s0_address == 3'd1);
    wire control_we = avs_s0_write & (avs_s0_address == 3'd2);
    wire clk_div_we = avs_s0_write & (avs_s0_address == 3'd4);
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            tx_data <= 0;
            control <= 0;
            clk_div <= 0;
        end else begin
            if(avs_s0_write)begin
                case (avs_s0_address)
                    1: tx_data <= avs_s0_writedata;
                    2: control <= avs_s0_writedata;
                    4: clk_div <= avs_s0_writedata;
                endcase
            end
        end
    end
//============update register================
    always @(posedge clk or negedge reset_n) begin
        if(!reset_n)begin
            status<=0;
        end else begin
            if(uart_core_rx_done)begin
                rx_data <= uart_core_rx_data;
            end
        end
    end
    
    /*always @(*) begin
        if(avs_s0_read)begin
            case (avs_s0_address)
                0: readdata = {24'b0, rx_data};
                1: readdata = {24'b0, tx_data};
                2: readdata = {24'b0, control};
                3: readdata = {24'b0, status};
                4: readdata = clk_div;
                default: readdate = 0;
            endcase
        end else begin
            readdate = 0;
        end
    end
*/

    wire uart_core_clk;
    wire uart_core_rx_clk;
    wire uart_core_tx_clk;
    assign uart_core_rx_clk = uart_core_clk;
    assign uart_core_tx_clk = uart_core_clk;
    clk_gen uart_clk_gen(
        .clk_i   (clk),
        .reset_n (reset_n),
        .clk_div (clk_div),
        .clk_o   (uart_core_clk)
    );
    uart_core inst(
        .reset_n    (reset_n),
        .rx_clk     (uart_core_rx_clk),
        .rx_data    (uart_core_rx_data),
        .rx_done    (uart_core_rx_done),
        .rx         (uart_core_rx),
        .tx_clk     (uart_core_tx_clk),
        .tx_valid   (uart_core_tx_valid),
        .tx_data    (uart_core_tx_data),
        .tx_ready   (uart_core_tx_ready),
        .tx_done    (uart_core_tx_done),
        .tx         (uart_core_tx)
    );
endmodule