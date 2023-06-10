#include "../inc/alu.h"
int alu_zero(int a, int b){
    return a == b;
}
int alu(int alu_opcode, int a, int b){
    switch (alu_opcode){
        case 0:
            return alu_add(a, b);
            break;
        case 1:
            return alu_sub(a, b);
            break;
        case 2:
            return alu_sll(a, b);
            break;
        case 3:
            return alu_slt(a, b);
            break;
        case 4:
            return alu_sltu(a, b);
            break;
        case 5:
            return alu_xor(a, b);
            break;
        case 6:
            return alu_srl(a, b);
            break;
        case 7:
            return alu_sra(a, b);
            break;
        case 8:
            return alu_or(a, b);
            break;
        case 9:
            return alu_and(a, b);
            break;
        default:
            return 0;
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