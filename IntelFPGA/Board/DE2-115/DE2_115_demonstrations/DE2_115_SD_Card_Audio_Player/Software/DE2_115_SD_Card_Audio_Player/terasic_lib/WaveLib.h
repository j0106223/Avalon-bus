#ifndef _INC_WAVE_LIB_H
#define _INC_WAVE_LIB_H

#include "terasic_includes.h"

#ifdef __cplusplus
extern "C" {
#endif


bool WAVE_IsWaveFile(char *szWave, const int nSize);
int Wave_GetSampleRate(char *szWave, const int nSize);
int Wave_GetChannelNum(char *szWave, const int nSize);
int Wave_GetSampleBitNum(char *szWave, const int nSize);
int Wave_GetDataByteSize(char *szWave, const int nSize);
int Wave_GetWaveOffset(char *szWave, const int nSize);

#ifdef __cplusplus
}
#endif

#endif /* _INC_WAVE_LIB_H */
