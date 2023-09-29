`timescale 1ns/1ps
module start_tb;
    
    initial begin
        $dumpfile("start.vcd");
        $dumpvars(0, start_tb);
    end
    integer seed = 1214;
    reg scl;
    reg sda;
    initial begin
        fork
            begin//sda
                sda = 1;
                #2;
                sda = 0;
                #1.5;
                repeat(7)begin
                   sda = {$random(seed)};
                   $display("sda = %d",sda);
                   #2;  
                end
            end
            begin//scl
                scl = 1;
                #2;
                repeat(20)begin
                    #1 scl = ~scl;
                end
            end
        join
        $finish;
    end
    start_stop_logic DUT(
        .scl            (scl),
        .sda            (sda),
        .start_detected (start_detected),
        .stop_detected  (stop_detected)
    );
endmodule