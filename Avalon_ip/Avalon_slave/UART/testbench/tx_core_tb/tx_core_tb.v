`timescale 1ns/1ps
module tx_core_tb;
    reg       tx_clk;
    reg       reset_n;
    reg       tx_valid;
    reg [7:0] tx_data;
    wire      tx_ready;
    wire      tx;
    wire      tx_done;

    initial begin
        $dumpfile("tx_core.vcd");
        $dumpvars(0, tx_core_tb);
    end

    integer seed;
    integer fp;
    initial begin
        fp = $fopen("date.txt","r");
        if($fscanf(fp,"%d", seed))begin
            $display("seed = %d", seed);
        end else begin
            $display("fail to get random seed!!");
        end
        $fclose(fp);
    end
    initial begin
        tx_clk      = 0;
        tx_valid    = 0;
        tx_data     = 0;
        reset_n     = 1;
        #1 reset_n  = 0;
        #1 reset_n  = 1;
        repeat(100)begin
            wait(tx_ready == 1'b1);
            tx_valid = 1'b1;
            tx_data  = $random(seed);
            $display("%8t:tx_data = %d",$time, tx_data);
            @(posedge tx_done);
        end
        $finish;
    end
    always #1 tx_clk = ~tx_clk;
    
    tx_core dut(
        .tx_clk     (tx_clk),
        .reset_n    (reset_n),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx)
    );

    
endmodule