#include "../inc/alu.h"

int alu_decode(struct alu *alu_inst, int alu_opcode){
    switch (alu_opcode){
    case 0:alu_inst->result = alu_add(alu_inst->a,alu_inst->b); break;
    case 1:
        break;
    case 2:
        break;
    case 3:
        break;
    case 4:
        break;
    case 5:
        break;
    case 6:
        break;
    case 7:
        break;
    default:
        break;
    }
}
int alu_add(int a, int b){
    return a + b;
}
int alu_sub(struct alu *alu_inst){
    return alu_inst->a - alu_inst->b;
}
int alu_sll(struct alu *alu_inst){

}
int alu_slt(struct alu *alu_inst){

}
int alu_sltu(struct alu *alu_inst){

}
int alu_xor(struct alu *alu_inst){
    return alu_inst->a ^ alu_inst->b;
}
int alu_srl(struct alu *alu_inst){

}
int alu_sra(struct alu *alu_inst){

}
int alu_or(struct alu *alu_inst){
    return alu_inst->a | alu_inst->b;
}
int alu_and(struct alu *alu_inst){
    return alu_inst->a & alu_inst->b;
}