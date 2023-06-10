#include "../inc/regfile.h"
#include <stdio.h>

int read_reg(struct regfile *regfile_inst, int index){
    if(index >= 32){
        printf("register file access fail...\n");
        printf("wrong register index");
        exit(1);
    }
    return regfile_inst->x[index];
}
void write_reg(struct regfile *regfile_inst, int index, int data){
    if(index >= 32){
        printf("register file access fail...\n");
        printf("wrong register index");
        exit(1);
    }
    regfile_inst->x[index] = data;
}
void regfile_init(struct regfile *regfile_inst){
    int i;
    for(i = 0; i < 32; i++){
        regfile_inst->x[i] = 0;
    }
}
