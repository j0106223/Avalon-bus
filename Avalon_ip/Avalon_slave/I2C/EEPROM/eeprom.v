module eeprom (
    scl,
    addr,
    write,
    data_i,
	data_o
);
    input clk;
    input write;
    input  [7:0] addr;
	input  [7:0] data_i;
	output [7:0] data_o;
    reg [7:0] mem [0:255];
    always @(posedge scl) begin//may be negedge
        if(write)begin
            mem[addr] <= data_i;
        end
    end
    assign data_o = mem[addr];
endmodule
