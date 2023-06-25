`timescale 1ns/1ps
module avs_uare_tb;
    parameter AW = 5;
    parameter DW = 32;
    reg clk;
    reg reset_n;
    initial begin
        $dumpfile("avs_uare_tb.vcd");
        $dumpvars(0, avs_uare_tb);    
    end
    initial begin
        clk = 0;
        forever begin
           #1 clk = ~clk; 
        end
    end
    initial begin
           reset_n = 1'b1;
        #1 reset_n = 1'b0;
        #1 reset_n = 1'b1;
        //pattern
        repeat(100)begin
            //transmit testing
            //receive testing
        end
    end


    
    //dut inst
    reg address;
    reg read;
    reg write;
    reg writedata;
    reg rx;

    reg  [7:0] rx_data; //reg[0]
    reg  [7:0] tx_data; //reg[1]
    reg  [7:0] control; //reg[2]
    reg  [7:0] status;  //reg[3]
    reg [31:0] clk_div; //reg[4]
    avs_uart dut(
        .clk                (clk        ),
        .reset_n            (reset_n    ),
        .avs_s0_address     (address    ),
        .avs_s0_read        (read       ),
        .avs_s0_write       (write      ),
        .avs_s0_waitrequest (waitrequest),
        .avs_s0_readdata    (readdata   ),
        .avs_s0_writedata   (writedata  ),
        .avs_s0_irq         (irq        ),
        .avs_s0_export_rx   (rx         ),
        .avs_s0_export_tx   (tx         )
    );
    task avm_read(
        input [AW-1:0]addr
    );
        begin
            @(posedge clk);
            address = addr;
            @(posedge clk);
            read = 1'b1;
            wait(!waitrequest);
            @(posedge clk);
            read = 1'b0;
        end
    endtask

    task avm_write(
        input [AW-1:0]addr,
        input [DW-1:0]value
    );
        begin
            @(posedge clk);
            address = addr;
            writedata = value;
            @(posedge clk);
            write = 1;
            wait(!waitrequest);
            @(posedge clk);
            write = 0;
        end
    endtask

    task set_tx_data(
        input [DW-1:0]data
    );
        begin
            avm_write(1, data);
        end
    endtask

    task set_control(
        input [DW-1:0]data
    );
        begin
            avm_write(2, data);
        end
    endtask

    task set_status(
        input [DW-1:0]data
    );
        begin
            avm_write(3, data);
        end
    endtask

    task set_clk_div(
        input [DW-1:0]data
    );
        begin
            avm_write(4, data);
        end
    endtask

    task get_rx_data;
        begin
            avm_read(0);
            rx_data = readdata;
        end
    endtask

    task get_status;
        begin
            avm_read(3);
            status = readdata;
        end
    endtask
endmodule