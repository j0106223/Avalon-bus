#ifndef _DECODER_HEADER_
#define _DECODER_HEADER_
struct decoder{
    int opcode;
    int rd;
    int func3;
    int rs1;
    int rs2;
    int func7;
};
#endif