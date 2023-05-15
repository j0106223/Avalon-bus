#include "../inc/cpu.h"

void cpu_init(struct cpu *cpu_inst){
    mem_init(&cpu_inst->rom);//rom
    mem_init(&cpu_inst->ram);//ram
    //mem_load(mem_inst,"filename.elf");
    pc_init();
    regfile_init();
}
void cpu_run(struct cpu *cpu_inst){
    int instr;
    while(1){
        //fetch
        instr = read_mem(cpu_inst->rom, cpu_inst->pc.cnt);
        //decode
        instruction_decode(cpu_inst->decoder, instr);
        cpu_inst->decoder.alu_opcode;
        cpu_inst->decoder.opcode;
        cpu_inst->decoder.ra1;
        cpu_inst->decoder.ra2;
        cpu_inst->decoder.wa;
        //alu
        //memory
        //write back
        //
    }

}
void 