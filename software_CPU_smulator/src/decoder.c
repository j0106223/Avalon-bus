#include "../inc/decoder.h"
void instruction_decode(struct decoder *decoder_inst, int instruction){
                               //instr[6:0] 
    decoder_inst->opcode     = instruction & 127;
                               //instr[19:15]
    decoder_inst->ra1        = instruction & (31 << 15);
                               //instr[24:20]
    decoder_inst->ra2        = instruction & (31 << 20);
                               //instr[11:7]
    decoder_inst->wa         = instruction & (31 << 7);
                               //instr[30:14~12]
    decoder_inst->alu_opcode = instruction & ((1 << 30) | (7 << 12));
}

