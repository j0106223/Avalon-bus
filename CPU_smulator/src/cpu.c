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
    int rd1;
    int rd2;
    int ram_rdata;
    int imm;
    while(1){
        //fetch
        instr = read_mem(&cpu_inst->rom, cpu_inst->pc.cnt);
        //decode
        imm = imm_gen(instr);
        instruction_decode(&cpu_inst->decoder, instr);
        control_decode(&cpu_inst->control, cpu_inst->decoder.opcode);
        rd1 = read_reg(&cpu_inst->regfile, cpu_inst->decoder.ra1);
        rd2 = read_reg(&cpu_inst->regfile, cpu_inst->decoder.ra2);
        cpu_inst->alu.a = rd1;
        if(cpu_inst->control.ALUSrc){
            cpu_inst->alu.b = imm;
        } else {
            cpu_inst->alu.b = rd2;
        }
        
        if(cpu_inst->control.MemRead){
            ram_rdata = read_mem(&cpu_inst->ram, cpu_inst->alu.result);
        }
        if(cpu_inst->control.MemWrite){
            write_mem(&cpu_inst->ram, cpu_inst->alu.result, rd2);
        }
        if(cpu_inst->control.RegWrite){
            if(cpu_inst->control.MemtoReg){
                write_reg(&cpu_inst->regfile, cpu_inst->decoder.wa, ram_rdata);
            }else {
                write_reg(&cpu_inst->regfile, cpu_inst->decoder.wa, cpu_inst->alu.result);
            }
        }
        //update pc
        if(cpu_inst->control.Branch & cpu_inst->alu.zero){
            pc_offset(&cpu_inst->pc, imm);
        } else {
            pc_inc_4byte(&cpu_inst->pc);
        }
    }
}