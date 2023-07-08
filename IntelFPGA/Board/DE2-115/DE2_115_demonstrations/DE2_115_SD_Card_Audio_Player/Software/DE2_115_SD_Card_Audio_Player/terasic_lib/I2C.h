#ifndef I2C_H_
#define I2C_H_

#define HMB_E2_I2C_ID   0xA0      // HMB EEPROM, 16 bytes
#define I2C_AUDIO_ADDR  0x34      // HMB AUDIO I2C
#define I2C_VIDEO_ADDR  0x40      // HMB VIDEO I2C


bool I2C_Write(alt_u32 clk_base, alt_u32 data_base, alt_8 DeviceAddr, alt_u8 ControlAddr, alt_u8 ControlData);
bool I2C_Read(alt_u32 clk_base, alt_u32 data_base, alt_8 DeviceAddr, alt_u8 ControlAddr, alt_u8 *pControlData);
bool I2C_MultipleRead(alt_u32 clk_base, alt_u32 data_base, alt_8 DeviceAddr, alt_u8 szData[], alt_u16 len);

#endif /*I2C_H_*/
