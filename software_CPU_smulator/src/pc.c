#include "../inc/pc.h"
void pc_init(struct pc *pc_inst, int start_addr){
    pc_inst->cnt = start_addr;
}

int get_pc(struct pc *pc_inst){
    return pc_inst->cnt;
}

void set_pc(struct pc *pc_inst, int next_pc){
    pc_inst->cnt = next_pc;
}
void pc_inc_4byte(struct pc *pc_inst){
    set_pc(pc_inst, get_pc(pc_inst) + 4);
}

void pc_offset(struct pc *pc_inst, int offset){
    set_pc(pc_inst, get_pc(pc_inst) + offset);
}