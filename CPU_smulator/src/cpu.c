#include "../inc/cpu.h"

void cpu_init(struct cpu *cpu_inst){
    mem_init(&cpu_inst->rom, ROM_BASE, ROM_SIZE);//rom
    mem_init(&cpu_inst->ram, RAM_BASE, RAM_SIZE);//ram
    hex2mem("a.hex", &cpu_inst->rom, &cpu_inst->ram);
    pc_init(&cpu_inst->pc, START_ADDR);
    regfile_init(&cpu_inst->regfile);
}
void cpu_run(struct cpu *cpu_inst){
    int instr;
    while(1){
        //fetch
        instr = read_mem(&cpu_inst->rom, cpu_inst->pc.cnt);
        //decode
        instruction_decode(&cpu_inst->decoder, instr);
        control_decode(&cpu_inst->control, cpu_inst->decoder.opcode);
        if(cpu_inst->control.MemRead){
            read_mem(&cpu_inst->ram, ){
        }
        if(cpu_inst->control.MemWrite){
            write_mem(&cpu_inst->ram, ,){
        }
        if(cpu_inst->control.RegWrite){
            write_reg(cpu_inst-, int index, int data)
        }
        if(cpu_inst->control.ALUSrc){

        }
    }
}