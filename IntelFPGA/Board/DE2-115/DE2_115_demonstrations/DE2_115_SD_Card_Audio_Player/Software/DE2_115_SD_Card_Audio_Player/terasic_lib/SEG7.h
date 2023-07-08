#ifndef SEG7_H_
#define SEG7_H_


void SEG7_Clear(void);
void SEG7_Full(void);
void SEG7_Hex(alt_u32 Data, alt_u8 point_mask);
void SEG7_Decimal(alt_u32 Data, alt_u8 point_mask); 
void SEG7_Number(void);

#endif /*SEG7_H_*/
