#include<stdio.h>

struct imm_gen{
    int  imm;
    int  format;
};

int imm_gen(struct imm_gen * imm_gen_inst, int instr){
    int opcode = instr & 0x7F;
    if(opcode == 0x13){//I
        imm_gen_inst->format = 0;
        imm_gen_inst->imm = instr >> 20;
        return imm_gen_inst->imm;
    }
    if(opcode == 0x23){//S
        imm_gen_inst->format = 1;
        imm_gen_inst->imm = instr >> 25;
        return imm_gen_inst->imm;
    } 
    if(opcode == 0x63){//B
        imm_gen_inst->format = 2;
        return ;
    } 
    if((opcode == 0x37) || (opcode == 0x17)){//U
        imm_gen_inst->format = 3;
        return ;
    } 
    if(opcode == 0x6F){//J
        imm_gen_inst->format = 4;
        return ;
    }
}

