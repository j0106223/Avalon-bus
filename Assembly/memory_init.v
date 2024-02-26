module memory_init(
    input  [10:0] address,
    output [31:0] data
);
    reg [7:0] mem [0:1024];

    initial begin
        $readmemh("a.hex",mem);
    end

    assign data = mem[address];
endmodule