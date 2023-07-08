#include "terasic_os.h"
#include <time.h>


uint32_t OS_GetTickCount()
{

    struct timespec ts;

    clock_gettime(CLOCK_MONOTONIC, &ts);

    return (ts.tv_sec * 1000 + ts.tv_nsec / 1000000);
}

uint32_t OS_TicksPerSecond(){
	return 1000;
}
