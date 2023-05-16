#ifndef _CONTROL_HEADER_
#define _CONTROL_HEADER_
struct control
{
    int ALUSrc;
    int MemtoReg;
    int RegWrite;
    int MemRead;
    int MemWrite;
    int Branch;
    int ALUOp1;//for alu
    int ALUOp0;//for branch
};
#endif


