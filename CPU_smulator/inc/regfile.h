#ifndef _REGFILE_HEADER_
#define _REGFILE_HEADER_
#include "cpu_config.h"
struct regfile{
    int x[REG_NUM];//need parameterize
};
char reg_name[][5] = {
    "zero",
    "ra",
    "sp",
    "gp",
    "tp",
    "t0", "t1", "t2",
    "s0/fp", "s1",
    "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
    "s2", "s2", "s4", "s5", "s6", "s7", "s8", "s9", "s10", "s11",
    "t3", "t4", "t5", "t6"
};
#endif