#include "pc.h"
#include "memory.h"
#include "regfile.h"
#include "cpu_config.h"
#include "alu.h"



struct cpu{
    struct alu alu;
    struct memory rom;//for instruction
    struct memory ram;//for data
    struct regfile regfile;
    struct pc pc;
        
};