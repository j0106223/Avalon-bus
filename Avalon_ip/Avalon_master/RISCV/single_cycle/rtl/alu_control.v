module ALU_control 
(
    input   [2:0]   instruction_funct3,
    input           instruction_funct7,//just only needs take instruction[30],funct7[6]
    input   [1:0]   ALUOp,
    output  [3:0]   ALU_Operation
);
    wire      funct7;
    wire [2:0]funct3;
    assign funct3 = instruction_funct3;
    assign funct7 = instruction_funct7;//for sub

    wire R_format   = ALUOp[1];
    wire beq        = ALUOp[0];

    reg [3:0]control;
    assign ALU_Operation = control;
    localparam ADD  = 4'b0000;//0
    localparam SUB  = 4'b0001;//1
    localparam AND  = 4'b0010;//2
    localparam OR   = 4'b0011;//3
    localparam XOR  = 4'b0100;//4
    localparam SLL  = 4'b0101;//5
    localparam SRL  = 4'b0110;//6
    localparam SRA  = 4'b0111;//7
    localparam SLT  = 4'b1000;//8
    localparam SLTU = 4'b1001;//9
    always @(*) begin
        //x means dont care
        casex({R_format, beq, funct7, funct3})//encoding 
            6'b00xxxx:control = ADD;//ADD Default value, no branch no arithmetic
            6'bx1xxxx:control = SUB;//SUB for branch
            6'b1x0000:control = ADD;//ADD
            6'b1x1000:control = SUB;//SUB
            6'b1x0111:control = AND;//AND
            6'b1x0110:control = OR; //OR
            6'b1x0001:control = SLL;//SLL shift left logical
            6'b1x0101:control = SRL;//SRL shift right logical
            6'b1x1101:control = SRA;//SRA shift right arithmetic
            6'b1x0010:control = SLT;//SLT set on less than
            6'b1x0011:control = SLTU;//SLTU set on less than unsigned
            6'b1x0100:control = XOR;//XOR
            default:control = ADD;
        endcase    
    end

endmodule