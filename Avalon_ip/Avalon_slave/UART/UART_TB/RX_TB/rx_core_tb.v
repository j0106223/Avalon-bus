`timescale 1ns/1ps
module rx_core_tb;
    reg        clk;
    reg        reset_n;

    wire       rx_clk;
    wire [7:0] rx_data;

    wire      tx_clk;
    reg       tx_valid;
    reg [7:0] tx_data;
    wire      tx_ready;
    wire      tx;
    wire      tx_done;

    always #1 clk = ~clk;

    assign rx_clk = clk;
    assign tx_clk = clk;

`ifdef DUMP_WAVE
    initial begin
        $dumpfile("rx_core.vcd");
        $dumpvars(0, rx_core_tb);
    end
`endif
    
    integer seed;
    integer fp;
    initial begin
        fp = $fopen("date.txt","r");
        if($fscanf(fp,"%d", seed))begin
            $display("testbench get seed = %d", seed);
        end else begin
            $display("fail to get random seed!!");
        end
        $fclose(fp);
    end
    initial begin
        clk = 0;
        reset_n = 1;
        #1 reset_n = 0;
        #1 reset_n = 1;
        repeat(50)begin
            wait(tx_ready == 1'b1);
            tx_valid = 1'b1;
            tx_data  = $random(seed);
            $write("tx_data = %d\t", tx_data);
            @(posedge tx_done)begin
                tx_valid = 1'b0;
            end
            @(posedge rx_done)begin
                $display("rx_data = %d", rx_data);
                if(rx_data != tx_data)begin
                    $display("uart rx fail!!");
                end
            end
        end
        $display("uart rx pass!!");
        $finish;
    end

    rx_core dut(
        .rx_clk  (rx_clk),
        .reset_n (reset_n),
        .rx_data (rx_data),
        .rx_done (rx_done),
        .rx      (tx)
    );

    tx_core tx_driver(
        .tx_clk     (tx_clk),
        .reset_n    (reset_n),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx)
    );
endmodule