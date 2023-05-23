#include "../inc/alu.h"

int alu_decode(struct alu *alu_inst, int alu_opcode){
    switch (alu_opcode){
        case 0:alu_inst->result = alu_add(alu_inst->a, alu_inst->b);
            break;
        case 1:alu_inst->result = alu_sub(alu_inst->a, alu_inst->b);
            break;
        case 2:alu_inst->result = alu_sll(alu_inst->a, alu_inst->b);
            break;
        case 3:alu_inst->result = alu_slt(alu_inst->a, alu_inst->b);
            break;
        case 4:alu_inst->result = alu_sltu(alu_inst->a, alu_inst->b);
            break;
        case 5:alu_inst->result = alu_xor(alu_inst->a, alu_inst->b);
            break;
        case 6:alu_inst->result = alu_srl(alu_inst->a, alu_inst->b);
            break;
        case 7:alu_inst->result = alu_sra(alu_inst->a, alu_inst->b);
            break;
        case 8:alu_inst->result = alu_or(alu_inst->a, alu_inst->b);
            break;
        case 9:alu_inst->result = alu_and(alu_inst->a, alu_inst->b);
            break;
        default:alu_inst->result = 0;
            break;
    }
}
int alu_add(int a, int b){
    return a + b;
}
int alu_sub(int a, int b){
    return a - b;
}
int alu_sll(int a, int b){
    return a << b;
}
int alu_slt(int a, int b){
    return a < b;
}
int alu_sltu(int a, int b){

}
int alu_xor(int a, int b){
    return a ^ b;
}
int alu_srl(int a, int b){
    return a >> b;
}
int alu_sra(int a, int b){

}
int alu_or(int a, int b){
    return a | b;
}
int alu_and(int a, int b){
    return a & b;
}