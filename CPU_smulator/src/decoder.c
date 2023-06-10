#include "../inc/decoder.h"
void instruction_decode(struct decoder *decoder_inst, int instruction){
                               //instr[6:0] 
    decoder_inst->opcode     = instruction & 127;
                               //instr[11:7]
    decoder_inst->rd         = (instruction >> 7) & 31;
                               //instr[14:12]
    decoder_inst->func3      = (instruction >> 12) & 7;
                               //instr[19:15]
    decoder_inst->rs1        = (instruction >> 15) & 31;
                               //instr[24:20]
    decoder_inst->rs2        = (instruction >> 20) & 31;
                               //instr[31:25]
    decoder_inst->func7      = (instruction >> 25) & 127;
}

