module instruction_memory(
    address,
    data
);
    parameter AW = 32;
    parameter DW = 32;
    input  [AW-1:0] address
    output [DW-1:0] data;

    reg [7:0] mem [0:1024];

    initial begin
        $readmemh("a.hex",mem);
    end

    assign data = mem[address];
endmodule