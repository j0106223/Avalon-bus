#ifndef TERASIC_OS_H_
#define TERASIC_OS_H_

#include <unistd.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

uint32_t OS_GetTickCount(); // mini second (1/1000 second)
uint32_t OS_TicksPerSecond();


#endif //TERASIC_OS_H_
