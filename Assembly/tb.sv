`timescale 1ns/1ps
module tb;
    reg [7:0] mem [0:1024];
    int fp;
    initial begin
        $readmemh("a.hex",mem);
        fp = $fopen("mem2.txt","w");
        for (int i = 0; i < 1024; i++) begin
            if(((i % 16) == 0) && (i != 0))begin
                $display("");
                $fwrite(fp, "\n");
            end
            $fwrite(fp,"%x ",mem[i]);
            $write("%x ",mem[i]);
        end
        $fclose(fp);
    end
endmodule