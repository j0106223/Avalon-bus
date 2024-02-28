module ALU (
    input   [3:0]   ALU_Operation,
    input   [31:0]  Data1,
    input   [31:0]  Data2,
    output  [31:0]  ALU_result,
    output          ZERO
);
    reg     [31:0]  result;
    assign ZERO = ~|result;//Self bitwise
    assign ALU_result = result;
    localparam ADD  = 4'b0000;//0
    localparam SUB  = 4'b0001;//1
    localparam AND  = 4'b0010;//2
    localparam OR   = 4'b0011;//3
    localparam XOR  = 4'b0100;//4
    localparam SLL  = 4'b0101;//5 shift left logical
    localparam SRL  = 4'b0110;//6 shift right logical
    localparam SRA  = 4'b0111;//7 shift right arithmetic
    localparam SLT  = 4'b1000;//8 set on less than
    localparam SLTU = 4'b1001;//9 set on less than unsigned
    always @(*) begin//need ALU_Operation,Data1 and Data2
        case(ALU_Operation)
            ADD:result = Data1 + Data2;
            SUB:result = Data1 - Data2;
            AND:result = Data1 & Data2;
            OR :result = Data1 | Data2;
            XOR:result = Data1 ^ Data2;
            SLL:result = Data1 << Data2;
            SRL:result = Data1 >> Data2;
            SRA:result = $signed(Data1) >>> Data2;
            SLT:
                begin
                    if(Data1[31] ^ Data2[31])begin//same as !=
                        result = Data1[31];
                    end else begin
                        if(Data1 < Data2)begin
                            result = 1;
                        end else begin
                            result = 0;
                        end
                    end
                end
            SLTU:result = (Data1 < Data2) ? 1'b1 : 1'b0;
            default:result = Data1 + Data2;
        endcase
    end
endmodule