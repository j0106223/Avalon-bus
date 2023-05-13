#include "../inc/cpu.h"

void cpu_init(struct cpu *cpu_inst){
    mem_init();//ram
    mem_init();//rom
    //mem_load(mem_inst,"filename.elf");
    pc_init();
    regfile_init();

}
