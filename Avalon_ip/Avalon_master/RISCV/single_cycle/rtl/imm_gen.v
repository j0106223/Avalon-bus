`default_nettype none
module ImmGen (
    instruction,
    Immediate
);

    input   [31:0] instruction;
    output  [31:0] Immediate;

    wire [6:0]  opcode;
    wire [31:0] i;
    assign opcode   = instruction[6:0]; //just rename
    assign i        = instruction;      //just rename
    
    //for load store and branch
    //12 bits immediate extend to 32bits
    reg [31:0]imm;
    assign Immediate = imm;
    always @(*) begin
        case(opcode)
            7'b0000011,//I Type load
            7'b1100111,//I Type jalr
            7'b0010011:imm = {{21{i[31]}}, i[30:20]};//I Type immediate arithmatic
            7'b0100011:imm = {{21{i[31]}}, i[30:25], i[11:7]};//S Type
            7'b1100011:imm = {{20{i[31]}}, i[7], i[30:25], i[11:8], 1'b0};//B or SB Type
            7'b0110111,//U or UJ Type LUI
            7'b0010111:imm = {i[31:12], 12'b000000000000};//U or UJ Type AUIPC
            7'b1101111:imm = {{12{i[31]}}, i[19:12], i[20], i[30:21], 1'b0};//J Type JAL
            default:imm = 32'h0000_0000;
        endcase 
    end

endmodule