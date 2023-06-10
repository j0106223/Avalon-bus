#include<stdio.h>

int imm_gen(int instr){
    int opcode = instr & 0x7F;
    if(opcode == 0x13){//I
        return instr >> 20;
    }
    if(opcode == 0x23){//S 
        return instr >> 25;
    } 
    if(opcode == 0x63){//B
        return ;
    } 
    if((opcode == 0x37) || (opcode == 0x17)){//U
        
        return ;
    } 
    if(opcode == 0x6F){//J
        return ;
    }
}

