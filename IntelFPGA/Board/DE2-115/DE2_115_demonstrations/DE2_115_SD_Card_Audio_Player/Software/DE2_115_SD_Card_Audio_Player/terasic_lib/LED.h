#ifndef LED_H_
#define LED_H_

void LED_AllOn(void);
void LED_AllOff(void);
void LED_Display(alt_u32 Mask);
void LED_BlinkStart(alt_u32 TimeInterval); // unit in ms
void LED_BlinkStop(void);
void LED_LightCount(alt_u8 LightCount);

#endif /*LED_H_*/
