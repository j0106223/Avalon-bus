#include <stdio.h>
#include <stdlib.h>
#include "../inc/memory.h"

int mem_init(struct memory *mem_inst, int base_addr, int size){
    mem_inst->base = base_addr;
    if(size % 4 != 0){
        return 0;//not a good memory size
    }
                                 //byte_size >> 4 equ byte_size/4
    mem_inst->data = (int *)malloc(sizeof(int) * (size >> 4));
    return 1;
}

int read_mem(struct memory *mem_inst, int addr){
    if((addr < mem_inst->base) || (mem_inst->base + mem_inst->size < addr)){
        printf("memory read fail!!\n");
        printf("addr:%0X is out off memory region %0X~%0X\n", addr, mem_inst->base, mem_inst->base+mem_inst->size);
        exit(1);
    }
    return mem_inst->data[addr];
}
void write_mem(struct memory *mem_inst, int addr, int data){
    if((addr < mem_inst->base) || (mem_inst->base + mem_inst->size < addr)){
        printf("memory write fail!!\n");
        printf("addr:%0X is out off memory region %0X~%0X\n", addr, mem_inst->base, mem_inst->base+mem_inst->size);
        exit(1);
    }
    mem_inst->data[addr] = data;
}