#include "../inc/regfile.h"
#include <stdio.h>

void write_regfile(struct regfile *regfile_inst, int reg_index, int data){
    if(reg_index > 32){
        printf("%d is over register amount",reg_index);
        return;
    }
    regfile_inst->x[reg_index] = data;
}  
int read_regfile(struct regfile *regfile_inst, int reg_index){
    return regfile_inst->x[reg_index];
}
void regfile_init(struct regfile *regfile_inst){
    
}
