#include "../inc/debug.h"
#include "../inc/cpu.h"
#include <stdio.h>
void show32bit(unsigned int data){
    int i;
    for(i = 0; i < 32; i++){  
        if(data & (1 << i)){
            printf("1");
        }else {
            printf("0");
        }   
    }
}
void showNbit(unsigned int data,int n){
    int i;
    for(i = 0; i < n; i++){
        if(data & (1 << i)){
            printf("1");
        }else {
            printf("0");
        }      
    }
}
void showRegs(struct regfile *regfile_inst){
    int i;
    printf("=================Register File Content=================");
    for(i = 0; i < REG_NUM; i++){
        printf("x%d/%s = %X%d \t", i, reg_name[i], regfile_inst->x[i]);
    }
    printf("=================Register File Content=================");
}