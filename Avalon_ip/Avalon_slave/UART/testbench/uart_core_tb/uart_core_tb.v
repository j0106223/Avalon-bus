module uart_core_tb;

    reg        clk;
    reg        reset_n;

    wire       rx_clk;
    wire [7:0] rx_data;

    wire      tx_clk;
    reg       tx_valid;
    reg [7:0] tx_data;
    wire      tx_ready;
    wire      tx_done;
    wire      tx2rx;
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

    integer i;
    initial begin
        clk = 0;
        reset_n = 1;
        #1 reset_n = 0;
        #1 reset_n = 1;
        $display("\n=========random test============\n");
        repeat(500)begin
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
        $display("\n=========increase test============\n");
        for(i = 0; i < 256;i = i + 1)begin
            wait(tx_ready == 1'b1);
            tx_valid = 1'b1;
            tx_data  = i;
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
        $display("\n=========decrease test============\n");
        for(i = 255; i >=0 ;i = i -1)begin
            wait(tx_ready == 1'b1);
            tx_valid = 1'b1;
            tx_data  = i;
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
        $display("=============uart core pass!!=============");
        $finish;
    end

    uart_core dut(
        .reset_n    (reset_n),
        .rx_clk     (rx_clk),
        .rx_data    (rx_data),
        .rx_done    (rx_done),
        .rx         (tx2rx),
        .tx_clk     (tx_clk),
        .tx_valid   (tx_valid),
        .tx_data    (tx_data),
        .tx_ready   (tx_ready),
        .tx_done    (tx_done),
        .tx         (tx2rx)
    );

endmodule