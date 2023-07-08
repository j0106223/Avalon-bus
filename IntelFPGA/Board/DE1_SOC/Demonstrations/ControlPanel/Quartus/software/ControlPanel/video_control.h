#ifndef VIDEO_CONTROL_H_
#define VIDEO_CONTROL_H_

bool VIDEO_Enable(bool bEnable);

void MIX_Init(void);
void MIX_LayerEnable(int nLayerIndex, bool bEnable);

#endif /*VIDEO_CONTROL_H_*/
