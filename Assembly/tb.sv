`timescale 1ns/1ps
module tb;
    reg [7:0] mem [0:1024];
    initial begin
        $readmemh("a.hex",mem);
        for (int i = 0; i < 1024; i++) begin
            if(((i % 16) == 0) && (i != 0))begin
                $display("");
            end
            $write("%x ",mem[i]);
        end
    end
endmodule