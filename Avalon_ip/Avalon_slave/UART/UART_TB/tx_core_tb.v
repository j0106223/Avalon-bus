`timescale 1ns/1ps
module tx_core_tb;
    reg tx_clk;
    reg reset_n;
    reg tx_valid;
    reg [7:0]tx_data;
    wire tx_ready;
    wire tx;
    wire done;

    initial begin
        $dumpfile("tx.vcd");
        $dumpvars(0, tx_core_tb);
    end

    integer seed;
    initial begin
        tx_clk      = 0;
        tx_valid    = 0;
        tx_data     = 0;
        reset_n     = 1;
        seed        = 20;
        #1 reset_n  = 0;
        #1 reset_n  = 1;
        repeat(10)begin
            if(tx_ready)begin//fix this bug
                tx_valid = 1'b1;
                tx_data  = $random(seed);
                $display("%0t:random = %x",$time, $random(seed)%256);
            end
            @(posedge tx_done) $display("test2");;
            $display("test");
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