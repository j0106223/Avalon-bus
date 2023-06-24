module avs_uare_tb;
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

    end


    
    //dut inst
    task avm_read;
        begin
        end
    endtask
    task avm_write;
        begin
        end
    endtask
    task set_tx_data;
        begin
        end
    endtask
    task set_control;
        begin
        end
    endtask
    task set_clk_div;
        begin
        end
    endtask
    task get_rx_data;
        begin
        end
    endtask
    task get_status;
        begin
        end
    endtask
endmodule