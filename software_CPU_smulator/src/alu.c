struct alu{
    int alu_op;
    int a;//operand 1
    int b;//operand 2
    int result;
};
int alu_decode(struct alu alu_inst){

}
int alu_add(struct alu *alu_inst){
    return alu_inst->a + alu_inst->b;
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