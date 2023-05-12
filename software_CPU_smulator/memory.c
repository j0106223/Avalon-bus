#include <stdlib.h>
struct memory{
    int *data;
    int base;
};
int mem_init(struct memory *mem_inst, int base_addr, int byte_size){
    mem_inst->base = base_addr;
    if(byte_size % 4 != 0){
        return 0;//not a good memory size
    }
                                 //byte_size >> 4 equ byte_size/4
    mem_inst->data = (int *)malloc(sizeof(int) * (byte_size >> 4));
    return 1;
}

int read_mem(struct memory *mem_inst, int addr){
    //out off memory address space
    mem_inst->data[addr] = 10;
}
void write_mem(){

}
mem_chip_select

int overlap_check(){
    
}