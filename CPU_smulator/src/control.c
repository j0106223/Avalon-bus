#include "../inc/control.h"

void control_decode(struct control *control_inst, int opcode){
    //R-format
    if(opcode == 51){//7'b0110011
        control_inst->ALUSrc   = 0;
        control_inst->MemtoReg = 0;
        control_inst->RegWrite = 1;
        control_inst->MemRead  = 0;
        control_inst->MemWrite = 0;
        control_inst->Branch   = 0;
        control_inst->ALUOp1   = 1;
        control_inst->ALUOp0   = 0;
    }
    //lw
    if(opcode == 3){//7'b0000011
        control_inst->ALUSrc   = 1;
        control_inst->MemtoReg = 1;
        control_inst->RegWrite = 1;
        control_inst->MemRead  = 1;
        control_inst->MemWrite = 0;
        control_inst->Branch   = 0;
        control_inst->ALUOp1   = 0;
        control_inst->ALUOp0   = 0;
    }
    //sw
    if(opcode == 35){//7'b0100011
        control_inst->ALUSrc   = 1;
        //control_inst->MemtoReg = x;dont care
        control_inst->RegWrite = 0;
        control_inst->MemRead  = 0;
        control_inst->MemWrite = 1;
        control_inst->Branch   = 0;
        control_inst->ALUOp1   = 0;
        control_inst->ALUOp0   = 0;            
    }
    //beq
    if(opcode == 99){//7'b1100011
        control_inst->ALUSrc   = 0;
        //control_inst->MemtoReg = x;dont care
        control_inst->RegWrite = 0;
        control_inst->MemRead  = 0;
        control_inst->MemWrite = 0;
        control_inst->Branch   = 1;
        control_inst->ALUOp1   = 0;
        control_inst->ALUOp0   = 1;
    }
}