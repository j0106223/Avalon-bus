`default_nettype none
module control (
    instruction_opcode,
    Branch,
    MemRead,
    MemtoReg,
    ALUOp,
    MemWrite,
    ALUSrc,
    RegWrite
);

    input [6:0] instruction_opcode;
    output      Branch;
    output      MemRead;
    output      MemtoReg;
    output[1:0] ALUOp;
    output      MemWrite;
    output      ALUSrc;
    output      RegWrite;

    wire [6:0]i     = instruction_opcode;//just rename
    wire R_format   = ~i[6] &  i[5] &  i[4] & ~i[3] & ~i[2] & i[1] & i[0];//0110011
    wire lw         = ~i[6] & ~i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0];//0000011
    wire sw         = ~i[6] &  i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0];//0100011
    wire beq        =  i[6] &  i[5] & ~i[4] & ~i[3] & ~i[2] & i[1] & i[0];//1100011
    wire lui        = ~i[6] &  i[5] &  i[4] & ~i[3] &  i[2] & i[1] & i[0];//0110111
    wire auipc      = ~i[6] & ~i[5] &  i[4] & ~i[3] &  i[2] & i[1] & i[0];//0010111
    wire jal        =  i[6] &  i[5] & ~i[4] &  i[3] &  i[2] & i[1] & i[0];//1101111
    wire jalr       =  i[6] &  i[5] & ~i[4] & ~i[3] &  i[2] & i[1] & i[0];//1100111
    
    
    assign  Branch   = beq;
    assign  MemRead  = lw;
    assign  MemtoReg = lw;
    assign  ALUOp[1] = R_format;
    assign  ALUOp[0] = beq;
    assign  MemWrite = sw;
    assign  ALUSrc   = lw | sw;
    assign  RegWrite = R_format | lw;
endmodule