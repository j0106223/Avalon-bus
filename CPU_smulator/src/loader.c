//this program is target to load elf contain to instruction memory and data memory
//initialize memory by .hex which is converted from elf
#include <stdio.h>
#include <stdlib.h>
#include "../inc/cpu.h"
void hex2mem(char *file_name, struct memory *rom,struct memory *ram){
    FILE *fp;
    int start_addr;
    int end_addr;
    fp = fopen(file_name,"r");
    write_mem(&rom, addr, data);
    fclose(fp);
}
int check_memory_region(int load_addr, struct memory *mem){
    if((addr < mem->base) || (addr > (mem->base + mem->size))){
        return 0;
    }
    return 1;
}