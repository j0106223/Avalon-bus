module addr_compare (
    scl,
    sda,
    load,
    comp,
    a2,
    a1,
    a0,
    rw
);
    
    input scl;
    input sda;
    input load;
    input a2;
    input a1;
    input a0;
    output comp;
    output rw;
    reg [6:0]shift_reg;
    wire [6:0]devicd_id;
    assign devicd_id = {4'b1000, {a2, a1, a0}};
    assign comp = (shift_reg == devicd_id) & load;
    assign rw = shift_reg[0];
    always @(posedge scl) begin
        shift_reg <= {shift_reg[6:1],sda};
    end
endmodule