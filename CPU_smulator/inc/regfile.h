#ifndef _REGFILE_HEADER_
#define _REGFILE_HEADER_
#include <stdio.h>
#include "cpu_config.h"
struct regfile{
    int x[REG_NUM];//need parameterize
};
#endif