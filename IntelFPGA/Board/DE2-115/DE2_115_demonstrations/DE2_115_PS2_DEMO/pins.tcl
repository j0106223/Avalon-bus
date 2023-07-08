#============================================================
# Build by Terasic System Builder V1.0.0
#============================================================

set_global_assignment -name FAMILY "Cyclone IV E"
set_global_assignment -name DEVICE EP4CE115F29C8L
set_global_assignment -name TOP_LEVEL_ENTITY DE2_115_PS2_DEMO
set_global_assignment -name ORIGINAL_QUARTUS_VERSION 9.1
set_global_assignment -name LAST_QUARTUS_VERSION "9.1 SP1"
set_global_assignment -name PROJECT_CREATION_TIME_DATE "14:02:28 JANUARY 27,2010"
set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
set_global_assignment -name DEVICE_FILTER_PIN_COUNT 780
set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 8L
#set_global_assignment -name SDC_FILE de2_115_golden_sopc.SDC


#============================================================
# CLOCK
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OSC_50[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OSC_50[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OSC_50[2]


#============================================================
# Sma
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SMA_CLKIN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SMA_CLKOUT

#============================================================
# LED
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[9]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[10]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[11]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[12]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[13]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[14]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[15]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[16]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[17]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDG[8]

#============================================================
# KEY
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to KEY[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to KEY[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to KEY[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to KEY[3]

#============================================================
# SW
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[7]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[8]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[9]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[10]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[11]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[12]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[13]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[14]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[15]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[16]
set_instance_assignment -name IO_STANDARD "2.5 V" -to SW[17]

#============================================================
# SEG7
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX0_D[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX0_D[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX0_D[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX0_D[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX0_D[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX0_D[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX0_D[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX1_D[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX1_D[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX1_D[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX1_D[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX1_D[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX1_D[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX1_D[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX2_D[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX2_D[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX2_D[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX2_D[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX2_D[4]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX2_D[5]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX2_D[6]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX3_D[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HEX3_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX3_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX4_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX5_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX6_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX6_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX6_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX6_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX6_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX6_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX6_D[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX7_D[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX7_D[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX7_D[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX7_D[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX7_D[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX7_D[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to HEX7_D[6]

#============================================================
# LCD
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_DATA[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_BLON
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_RW
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_EN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_RS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LCD_ON

#============================================================
# RS232
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to UART_TXD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to UART_RXD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to UART_CTS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to UART_RTS

#============================================================
# PS2
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_KBCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_KBDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_MSCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to PS2_MSDAT

#============================================================
# SDCARD
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_CMD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_WP_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SD_DAT[3]

#============================================================
# VGA
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_HS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_VS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_SYNC_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_BLANK_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_R[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_G[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to VGA_B[7]

#============================================================
# Audio
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_ADCLRCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_ADCDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_DACLRCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_DACDAT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_XCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to AUD_BCLK

#============================================================
# I2C for EEPROM
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EEP_I2C_SCL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EEP_I2C_SDA

#============================================================
# I2C for Audioand Tv-Decode 1 and 2
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to I2C_SCL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to I2C_SDA

#============================================================
# Ethernet 0
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_TX_DATA[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_DATA[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_TX_DATA[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_DATA[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_DATA[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_TX_DATA[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_DATA[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_GTX_CLK
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_TX_EN
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_TX_ER
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RESET_n
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_DV
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_ER
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_CRS
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_COL
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_RX_CLK
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_TX_CLK
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_MDC
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_MDIO

#============================================================
# Ethernet 1
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_TX_DATA[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_DATA[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_TX_DATA[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_DATA[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_TX_DATA[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_DATA[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_TX_DATA[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_DATA[3]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_GTX_CLK
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_TX_EN
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_TX_ER
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_INT_n
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RESET_n
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_DV
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_ER
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_CRS
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_COL
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_RX_CLK
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_TX_CLK
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_MDC
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET1_MDIO


#============================================================
# TV Decoder
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_HS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_VS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_CLK27
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_RESET_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to TD_DATA[7]

#============================================================
# USB 
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DATA[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_A[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_A[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_CS_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_WE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_OE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_INT[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_INT[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_RESET_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DREQ[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DREQ[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DACK_n[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_DACK_n[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_FSPEED
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to OTG_LSPEED

#============================================================
# IR Receiver
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IRDA_RXD

#============================================================
# SDRAM
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_BA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQM[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQM[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQM[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQM[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_RAS_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CAS_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CKE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_WE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_CS_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_DQ[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to DRAM_ADDR[12]

#============================================================
# SRAM
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_ADDR[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_DQ[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_UB_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_LB_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_CE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_OE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SRAM_WE_n

#============================================================
# Flash
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_ADDR[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_DQ[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_CE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_OE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_RESET_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_RY
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_WE_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_WP_n

#============================================================
# GPIO, GPIO connect to GPIO Default
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[6]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[7]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[8]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[9]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[10]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[11]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[12]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[13]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[14]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[15]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[16]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[17]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[18]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[19]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[20]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[21]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[22]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[23]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[24]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[25]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[26]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[27]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[28]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[29]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[30]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[31]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[32]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[33]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[34]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to GPIO_DATA[35]

#============================================================
# HSMC, HSMC connect to HSMC Default
#============================================================
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_CLKOUT0
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[0]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[1]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to HSMC_D[3]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKOUT_p1
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKOUT_n1
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[12]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[12]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[12]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[12]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[13]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[13]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[13]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[13]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[14]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[14]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[14]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[14]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[15]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[15]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[15]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[15]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[16]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[16]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[16]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[16]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKOUT_p2
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKOUT_n2

#============================================================
# HSMC, HSMC connect to HSMC Default
#============================================================
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EXT_IO[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EXT_IO[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EXT_IO[2]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EXT_IO[3]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EXT_IO[4]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EXT_IO[5]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to EXT_IO[6]

#============================================================
# End of pin assignments by Terasic System Builder
#============================================================




set_location_assignment PIN_A17 -to NET0_GTX_CLK
set_location_assignment PIN_A21 -to NET0_INT_n
set_location_assignment PIN_C20 -to NET0_MDC
set_location_assignment PIN_B21 -to NET0_MDIO
set_location_assignment PIN_C19 -to NET0_RESET_n
set_location_assignment PIN_A15 -to NET0_RX_CLK
set_location_assignment PIN_E15 -to NET0_RX_COL
set_location_assignment PIN_D15 -to NET0_RX_CRS
set_location_assignment PIN_C16 -to NET0_RX_DATA[0]
set_location_assignment PIN_D16 -to NET0_RX_DATA[1]
set_location_assignment PIN_D17 -to NET0_RX_DATA[2]
set_location_assignment PIN_C15 -to NET0_RX_DATA[3]
set_location_assignment PIN_C17 -to NET0_RX_DV
set_location_assignment PIN_D18 -to NET0_RX_ER
set_location_assignment PIN_B17 -to NET0_TX_CLK
set_location_assignment PIN_C18 -to NET0_TX_DATA[0]
set_location_assignment PIN_D19 -to NET0_TX_DATA[1]
set_location_assignment PIN_A19 -to NET0_TX_DATA[2]
set_location_assignment PIN_B19 -to NET0_TX_DATA[3]
set_location_assignment PIN_A18 -to NET0_TX_EN
set_location_assignment PIN_B18 -to NET0_TX_ER
set_location_assignment PIN_C23 -to NET1_GTX_CLK
set_location_assignment PIN_D24 -to NET1_INT_n
set_location_assignment PIN_D23 -to NET1_MDC
set_location_assignment PIN_D25 -to NET1_MDIO
set_location_assignment PIN_D22 -to NET1_RESET_n
set_location_assignment PIN_B15 -to NET1_RX_CLK
set_location_assignment PIN_B22 -to NET1_RX_COL
set_location_assignment PIN_D20 -to NET1_RX_CRS
set_location_assignment PIN_B23 -to NET1_RX_DATA[0]
set_location_assignment PIN_C21 -to NET1_RX_DATA[1]
set_location_assignment PIN_A23 -to NET1_RX_DATA[2]
set_location_assignment PIN_D21 -to NET1_RX_DATA[3]
set_location_assignment PIN_A22 -to NET1_RX_DV
set_location_assignment PIN_C24 -to NET1_RX_ER
set_location_assignment PIN_C22 -to NET1_TX_CLK
set_location_assignment PIN_C25 -to NET1_TX_DATA[0]
set_location_assignment PIN_A26 -to NET1_TX_DATA[1]
set_location_assignment PIN_B26 -to NET1_TX_DATA[2]
set_location_assignment PIN_C26 -to NET1_TX_DATA[3]
set_location_assignment PIN_B25 -to NET1_TX_EN
set_location_assignment PIN_A25 -to NET1_TX_ER
set_location_assignment PIN_Y2 -to OSC_50[0]
set_location_assignment PIN_AG14 -to OSC_50[1]
set_location_assignment PIN_AG15 -to OSC_50[2]
set_location_assignment PIN_AH14 -to SMA_CLKIN
set_location_assignment PIN_AH15 -to HSMC_CLKIN0
set_location_assignment PIN_E21 -to LEDG[0]
set_location_assignment PIN_E22 -to LEDG[1]
set_location_assignment PIN_E25 -to LEDG[2]
set_location_assignment PIN_E24 -to LEDG[3]
set_location_assignment PIN_H21 -to LEDG[4]
set_location_assignment PIN_G20 -to LEDG[5]
set_location_assignment PIN_G22 -to LEDG[6]
set_location_assignment PIN_G21 -to LEDG[7]
set_location_assignment PIN_F17 -to LEDG[8]
set_location_assignment PIN_G19 -to LEDR[0]
set_location_assignment PIN_E19 -to LEDR[2]
set_location_assignment PIN_F19 -to LEDR[1]
set_location_assignment PIN_F21 -to LEDR[3]
set_location_assignment PIN_F18 -to LEDR[4]
set_location_assignment PIN_E18 -to LEDR[5]
set_location_assignment PIN_J19 -to LEDR[6]
set_location_assignment PIN_H19 -to LEDR[7]
set_location_assignment PIN_J17 -to LEDR[8]
set_location_assignment PIN_G17 -to LEDR[9]
set_location_assignment PIN_J15 -to LEDR[10]
set_location_assignment PIN_H16 -to LEDR[11]
set_location_assignment PIN_J16 -to LEDR[12]
set_location_assignment PIN_H17 -to LEDR[13]
set_location_assignment PIN_F15 -to LEDR[14]
set_location_assignment PIN_G15 -to LEDR[15]
set_location_assignment PIN_G16 -to LEDR[16]
set_location_assignment PIN_H15 -to LEDR[17]
set_location_assignment PIN_J27 -to HSMC_CLKIN_p1
set_location_assignment PIN_J28 -to HSMC_CLKIN_n1
set_location_assignment PIN_Y27 -to HSMC_CLKIN_p2
set_location_assignment PIN_Y28 -to HSMC_CLKIN_n2
set_location_assignment PIN_D27 -to HSMC_TX_D_p[0]
set_location_assignment PIN_D28 -to HSMC_TX_D_n[0]
set_location_assignment PIN_F24 -to HSMC_RX_D_p[0]
set_location_assignment PIN_F25 -to HSMC_RX_D_n[0]
set_location_assignment PIN_E27 -to HSMC_TX_D_p[1]
set_location_assignment PIN_C27 -to HSMC_RX_D_n[1]
set_location_assignment PIN_E28 -to HSMC_TX_D_n[1]
set_location_assignment PIN_D26 -to HSMC_RX_D_p[1]
set_location_assignment PIN_F27 -to HSMC_TX_D_p[2]
set_location_assignment PIN_F28 -to HSMC_TX_D_n[2]
set_location_assignment PIN_F26 -to HSMC_RX_D_p[2]
set_location_assignment PIN_E26 -to HSMC_RX_D_n[2]
set_location_assignment PIN_G27 -to HSMC_TX_D_p[3]
set_location_assignment PIN_G28 -to HSMC_TX_D_n[3]
set_location_assignment PIN_G25 -to HSMC_RX_D_p[3]
set_location_assignment PIN_G26 -to HSMC_RX_D_n[3]
set_location_assignment PIN_K27 -to HSMC_TX_D_p[4]
set_location_assignment PIN_K28 -to HSMC_TX_D_n[4]
set_location_assignment PIN_H25 -to HSMC_RX_D_p[4]
set_location_assignment PIN_H26 -to HSMC_RX_D_n[4]
set_location_assignment PIN_M27 -to HSMC_TX_D_p[5]
set_location_assignment PIN_M28 -to HSMC_TX_D_n[5]
set_location_assignment PIN_K25 -to HSMC_RX_D_p[5]
set_location_assignment PIN_K26 -to HSMC_RX_D_n[5]
set_location_assignment PIN_K21 -to HSMC_TX_D_p[6]
set_location_assignment PIN_K22 -to HSMC_TX_D_n[6]
set_location_assignment PIN_L23 -to HSMC_RX_D_p[6]
set_location_assignment PIN_L24 -to HSMC_RX_D_n[6]
set_location_assignment PIN_H23 -to HSMC_TX_D_p[7]
set_location_assignment PIN_H24 -to HSMC_TX_D_n[7]
set_location_assignment PIN_M25 -to HSMC_RX_D_p[7]
set_location_assignment PIN_M26 -to HSMC_RX_D_n[7]
set_location_assignment PIN_J23 -to HSMC_TX_D_p[8]
set_location_assignment PIN_J24 -to HSMC_TX_D_n[8]
set_location_assignment PIN_R25 -to HSMC_RX_D_p[8]
set_location_assignment PIN_R26 -to HSMC_RX_D_n[8]
set_location_assignment PIN_P27 -to HSMC_TX_D_p[9]
#set_location_assignment PIN_P28 -to HSMC_TX_D_n[9]
set_location_assignment PIN_T25 -to HSMC_RX_D_p[9]
set_location_assignment PIN_T26 -to HSMC_RX_D_n[9]
set_location_assignment PIN_J25 -to HSMC_TX_D_p[10]
set_location_assignment PIN_J26 -to HSMC_TX_D_n[10]
set_location_assignment PIN_U25 -to HSMC_RX_D_p[10]
set_location_assignment PIN_U26 -to HSMC_RX_D_n[10]
set_location_assignment PIN_L27 -to HSMC_TX_D_p[11]
set_location_assignment PIN_L28 -to HSMC_TX_D_n[11]
set_location_assignment PIN_L21 -to HSMC_RX_D_p[11]
set_location_assignment PIN_L22 -to HSMC_RX_D_n[11]
set_location_assignment PIN_V25 -to HSMC_TX_D_p[12]
set_location_assignment PIN_V26 -to HSMC_TX_D_n[12]
set_location_assignment PIN_N25 -to HSMC_RX_D_p[12]
set_location_assignment PIN_N26 -to HSMC_RX_D_n[12]
set_location_assignment PIN_R27 -to HSMC_TX_D_p[13]
set_location_assignment PIN_R28 -to HSMC_TX_D_n[13]
set_location_assignment PIN_P25 -to HSMC_RX_D_p[13]
set_location_assignment PIN_P26 -to HSMC_RX_D_n[13]
set_location_assignment PIN_U27 -to HSMC_TX_D_p[14]
set_location_assignment PIN_U28 -to HSMC_TX_D_n[14]
set_location_assignment PIN_P21 -to HSMC_RX_D_p[14]
set_location_assignment PIN_R21 -to HSMC_RX_D_n[14]
set_location_assignment PIN_V27 -to HSMC_TX_D_p[15]
set_location_assignment PIN_V28 -to HSMC_TX_D_n[15]
set_location_assignment PIN_R22 -to HSMC_RX_D_p[15]
set_location_assignment PIN_R23 -to HSMC_RX_D_n[15]
set_location_assignment PIN_U22 -to HSMC_TX_D_p[16]
set_location_assignment PIN_V22 -to HSMC_TX_D_n[16]
set_location_assignment PIN_T21 -to HSMC_RX_D_p[16]
set_location_assignment PIN_T22 -to HSMC_RX_D_n[16]
set_location_assignment PIN_V23 -to HSMC_CLKOUT_p2
set_location_assignment PIN_V24 -to HSMC_CLKOUT_n2
set_location_assignment PIN_G23 -to HSMC_CLKOUT_p1
set_location_assignment PIN_G24 -to HSMC_CLKOUT_n1
set_location_assignment PIN_AD28 -to HSMC_CLKOUT0
set_location_assignment PIN_AE26 -to HSMC_D[0]
set_location_assignment PIN_AE28 -to HSMC_D[1]
set_location_assignment PIN_AE27 -to HSMC_D[2]
set_location_assignment PIN_G18 -to HEX0_D[0]
set_location_assignment PIN_F22 -to HEX0_D[1]
set_location_assignment PIN_M23 -to KEY[0]
set_location_assignment PIN_M21 -to KEY[1]
set_location_assignment PIN_N21 -to KEY[2]
set_location_assignment PIN_R24 -to KEY[3]
set_location_assignment PIN_AC28 -to SW[1]
set_location_assignment PIN_AC27 -to SW[2]
set_location_assignment PIN_AD27 -to SW[3]
set_location_assignment PIN_AB27 -to SW[4]
set_location_assignment PIN_AC26 -to SW[5]
set_location_assignment PIN_AD26 -to SW[6]
set_location_assignment PIN_E17 -to HEX0_D[2]
set_location_assignment PIN_L26 -to HEX0_D[3]
set_location_assignment PIN_L25 -to HEX0_D[4]
set_location_assignment PIN_J22 -to HEX0_D[5]
set_location_assignment PIN_H22 -to HEX0_D[6]
set_location_assignment PIN_M24 -to HEX1_D[0]
set_location_assignment PIN_AB26 -to SW[7]
set_location_assignment PIN_AC25 -to SW[8]
set_location_assignment PIN_AB25 -to SW[9]
set_location_assignment PIN_AC24 -to SW[10]
set_location_assignment PIN_AB24 -to SW[11]
set_location_assignment PIN_AB23 -to SW[12]
set_location_assignment PIN_AA24 -to SW[13]
set_location_assignment PIN_AA23 -to SW[14]
set_location_assignment PIN_AA22 -to SW[15]
set_location_assignment PIN_Y24 -to SW[16]
set_location_assignment PIN_Y23 -to SW[17]
set_location_assignment PIN_Y22 -to HEX1_D[1]
set_location_assignment PIN_W21 -to HEX1_D[2]
set_location_assignment PIN_W22 -to HEX1_D[3]
set_location_assignment PIN_W25 -to HEX1_D[4]
set_location_assignment PIN_U23 -to HEX1_D[5]
set_location_assignment PIN_U24 -to HEX1_D[6]
set_location_assignment PIN_AA25 -to HEX2_D[0]
set_location_assignment PIN_AA26 -to HEX2_D[1]
set_location_assignment PIN_Y25 -to HEX2_D[2]
set_location_assignment PIN_W26 -to HEX2_D[3]
set_location_assignment PIN_Y26 -to HEX2_D[4]
set_location_assignment PIN_AB22 -to GPIO_DATA[0]
set_location_assignment PIN_AC15 -to GPIO_DATA[1]
set_location_assignment PIN_AB21 -to GPIO_DATA[2]
set_location_assignment PIN_Y17 -to GPIO_DATA[3]
set_location_assignment PIN_AC21 -to GPIO_DATA[4]
set_location_assignment PIN_Y16 -to GPIO_DATA[5]
set_location_assignment PIN_AD21 -to GPIO_DATA[6]
set_location_assignment PIN_AE16 -to GPIO_DATA[7]
set_location_assignment PIN_AC19 -to GPIO_DATA[10]
set_location_assignment PIN_AF16 -to GPIO_DATA[11]
set_location_assignment PIN_AD19 -to GPIO_DATA[12]
set_location_assignment PIN_AF15 -to GPIO_DATA[13]
set_location_assignment PIN_AF24 -to GPIO_DATA[14]
set_location_assignment PIN_AE21 -to GPIO_DATA[15]
set_location_assignment PIN_AF25 -to GPIO_DATA[16]
set_location_assignment PIN_AC22 -to GPIO_DATA[17]
set_location_assignment PIN_AE22 -to GPIO_DATA[18]
set_location_assignment PIN_AF21 -to GPIO_DATA[19]
set_location_assignment PIN_AF22 -to GPIO_DATA[20]
set_location_assignment PIN_AD22 -to GPIO_DATA[21]
set_location_assignment PIN_AG25 -to GPIO_DATA[22]
set_location_assignment PIN_AD25 -to GPIO_DATA[23]
set_location_assignment PIN_AH25 -to GPIO_DATA[24]
set_location_assignment PIN_AE25 -to GPIO_DATA[25]
set_location_assignment PIN_AG22 -to GPIO_DATA[26]
set_location_assignment PIN_AE24 -to GPIO_DATA[27]
set_location_assignment PIN_AH22 -to GPIO_DATA[28]
set_location_assignment PIN_AF26 -to GPIO_DATA[29]
set_location_assignment PIN_AE20 -to GPIO_DATA[30]
set_location_assignment PIN_AG23 -to GPIO_DATA[31]
set_location_assignment PIN_AF20 -to GPIO_DATA[32]
set_location_assignment PIN_AH26 -to GPIO_DATA[33]
set_location_assignment PIN_AE23 -to SMA_CLKOUT
set_location_assignment PIN_W27 -to HEX2_D[5]
set_location_assignment PIN_W28 -to HEX2_D[6]
set_location_assignment PIN_V21 -to HEX3_D[0]
set_location_assignment PIN_U21 -to HEX3_D[1]
set_location_assignment PIN_AB20 -to HEX3_D[2]
set_location_assignment PIN_AA21 -to HEX3_D[3]
set_location_assignment PIN_AD24 -to HEX3_D[4]
set_location_assignment PIN_AF23 -to HEX3_D[5]
set_location_assignment PIN_Y19 -to HEX3_D[6]
set_location_assignment PIN_AB19 -to HEX4_D[0]
set_location_assignment PIN_AA19 -to HEX4_D[1]
set_location_assignment PIN_AG21 -to HEX4_D[2]
set_location_assignment PIN_AH21 -to HEX4_D[3]
set_location_assignment PIN_AE19 -to HEX4_D[4]
set_location_assignment PIN_AF19 -to HEX4_D[5]
set_location_assignment PIN_AE18 -to HEX4_D[6]
set_location_assignment PIN_AD18 -to HEX5_D[0]
set_location_assignment PIN_AC18 -to HEX5_D[1]
set_location_assignment PIN_AB18 -to HEX5_D[2]
set_location_assignment PIN_AH19 -to HEX5_D[3]
set_location_assignment PIN_AG19 -to HEX5_D[4]
set_location_assignment PIN_AF18 -to HEX5_D[5]
set_location_assignment PIN_AH18 -to HEX5_D[6]
set_location_assignment PIN_AA17 -to HEX6_D[0]
set_location_assignment PIN_AB16 -to HEX6_D[1]
set_location_assignment PIN_AA16 -to HEX6_D[2]
set_location_assignment PIN_AB17 -to HEX6_D[3]
set_location_assignment PIN_AB15 -to HEX6_D[4]
set_location_assignment PIN_AA15 -to HEX6_D[5]
set_location_assignment PIN_AC17 -to HEX6_D[6]
set_location_assignment PIN_AD17 -to HEX7_D[0]
set_location_assignment PIN_AE17 -to HEX7_D[1]
set_location_assignment PIN_AE5 -to DRAM_CLK
set_location_assignment PIN_AG17 -to HEX7_D[2]
set_location_assignment PIN_AH17 -to HEX7_D[3]
set_location_assignment PIN_AF17 -to HEX7_D[4]
set_location_assignment PIN_AG18 -to HEX7_D[5]
set_location_assignment PIN_AA14 -to HEX7_D[6]
set_location_assignment PIN_AE14 -to SD_DAT[0]
set_location_assignment PIN_AF13 -to SD_DAT[1]
set_location_assignment PIN_AB14 -to SD_DAT[2]
set_location_assignment PIN_AC14 -to SD_DAT[3]
set_location_assignment PIN_AE13 -to SD_CLK
set_location_assignment PIN_AD14 -to SD_CMD
set_location_assignment PIN_AF14 -to SD_WP_n
set_location_assignment PIN_AF12 -to FLASH_DQ[7]
set_location_assignment PIN_AH11 -to FLASH_DQ[6]
set_location_assignment PIN_AG11 -to FLASH_DQ[5]
set_location_assignment PIN_AF11 -to FLASH_DQ[4]
set_location_assignment PIN_AH10 -to FLASH_DQ[3]
set_location_assignment PIN_AG10 -to FLASH_DQ[2]
set_location_assignment PIN_AF10 -to FLASH_DQ[1]
set_location_assignment PIN_AH8 -to FLASH_DQ[0]
set_location_assignment PIN_AG12 -to FLASH_ADDR[0]
set_location_assignment PIN_AD11 -to FLASH_ADDR[22]
set_location_assignment PIN_AD10 -to FLASH_ADDR[21]
set_location_assignment PIN_AE10 -to FLASH_ADDR[20]
set_location_assignment PIN_AD12 -to FLASH_ADDR[19]
set_location_assignment PIN_AC12 -to FLASH_ADDR[18]
set_location_assignment PIN_AH12 -to FLASH_ADDR[17]
set_location_assignment PIN_AA8 -to FLASH_ADDR[16]
set_location_assignment PIN_Y10 -to FLASH_ADDR[15]
set_location_assignment PIN_AC8 -to FLASH_ADDR[14]
set_location_assignment PIN_AD8 -to FLASH_ADDR[13]
set_location_assignment PIN_AA10 -to FLASH_ADDR[12]
set_location_assignment PIN_AF9 -to FLASH_ADDR[11]
set_location_assignment PIN_AE9 -to FLASH_ADDR[10]
set_location_assignment PIN_AB10 -to FLASH_ADDR[9]
set_location_assignment PIN_AB12 -to FLASH_ADDR[8]
set_location_assignment PIN_AB13 -to FLASH_ADDR[7]
set_location_assignment PIN_AA12 -to FLASH_ADDR[6]
set_location_assignment PIN_AA13 -to FLASH_ADDR[5]
set_location_assignment PIN_Y12 -to FLASH_ADDR[4]
set_location_assignment PIN_Y14 -to FLASH_ADDR[3]
set_location_assignment PIN_Y13 -to FLASH_ADDR[2]
set_location_assignment PIN_AH7 -to FLASH_ADDR[1]
set_location_assignment PIN_AG7 -to FLASH_CE_n
set_location_assignment PIN_AG8 -to FLASH_OE_n
set_location_assignment PIN_AC10 -to FLASH_WE_n
set_location_assignment PIN_AE11 -to FLASH_RESET_n
set_location_assignment PIN_AE12 -to FLASH_WP_n
set_location_assignment PIN_Y1 -to FLASH_RY
set_location_assignment PIN_AG3 -to SRAM_DQ[15]
set_location_assignment PIN_AF3 -to SRAM_DQ[14]
set_location_assignment PIN_AE4 -to SRAM_DQ[13]
set_location_assignment PIN_AE3 -to SRAM_DQ[12]
set_location_assignment PIN_AE1 -to SRAM_DQ[11]
set_location_assignment PIN_AE2 -to SRAM_DQ[10]
set_location_assignment PIN_AD2 -to SRAM_DQ[9]
set_location_assignment PIN_AD1 -to SRAM_DQ[8]
set_location_assignment PIN_AF7 -to SRAM_DQ[7]
set_location_assignment PIN_AH6 -to SRAM_DQ[6]
set_location_assignment PIN_AG6 -to SRAM_DQ[5]
set_location_assignment PIN_AF6 -to SRAM_DQ[4]
set_location_assignment PIN_AH4 -to SRAM_DQ[3]
set_location_assignment PIN_AG4 -to SRAM_DQ[2]
set_location_assignment PIN_AF4 -to SRAM_DQ[1]
set_location_assignment PIN_AH3 -to SRAM_DQ[0]
set_location_assignment PIN_AC4 -to SRAM_UB_n
set_location_assignment PIN_AD4 -to SRAM_LB_n
set_location_assignment PIN_AF8 -to SRAM_CE_n
set_location_assignment PIN_AD5 -to SRAM_OE_n
set_location_assignment PIN_AE8 -to SRAM_WE_n
set_location_assignment PIN_AE6 -to SRAM_ADDR[5]
set_location_assignment PIN_AB5 -to SRAM_ADDR[6]
set_location_assignment PIN_AC5 -to SRAM_ADDR[7]
set_location_assignment PIN_AF5 -to SRAM_ADDR[8]
set_location_assignment PIN_T7 -to SRAM_ADDR[9]
set_location_assignment PIN_AF2 -to SRAM_ADDR[10]
set_location_assignment PIN_AD3 -to SRAM_ADDR[11]
set_location_assignment PIN_AB4 -to SRAM_ADDR[12]
set_location_assignment PIN_AC3 -to SRAM_ADDR[13]
set_location_assignment PIN_AA4 -to SRAM_ADDR[14]
set_location_assignment PIN_AB7 -to SRAM_ADDR[0]
set_location_assignment PIN_AD7 -to SRAM_ADDR[1]
set_location_assignment PIN_AE7 -to SRAM_ADDR[2]
set_location_assignment PIN_AC7 -to SRAM_ADDR[3]
set_location_assignment PIN_AB6 -to SRAM_ADDR[4]
set_location_assignment PIN_T8 -to SRAM_ADDR[19]
set_location_assignment PIN_AB8 -to SRAM_ADDR[18]
set_location_assignment PIN_AB9 -to SRAM_ADDR[17]
set_location_assignment PIN_AC11 -to SRAM_ADDR[16]
set_location_assignment PIN_AB11 -to SRAM_ADDR[15]
set_location_assignment PIN_U1 -to DRAM_DQ[31]
set_location_assignment PIN_U4 -to DRAM_DQ[30]
set_location_assignment PIN_T3 -to DRAM_DQ[29]
set_location_assignment PIN_R3 -to DRAM_DQ[28]
set_location_assignment PIN_R2 -to DRAM_DQ[27]
set_location_assignment PIN_R1 -to DRAM_DQ[26]
set_location_assignment PIN_R7 -to DRAM_DQ[25]
set_location_assignment PIN_U5 -to DRAM_DQ[24]
set_location_assignment PIN_M8 -to DRAM_DQ[16]
set_location_assignment PIN_L8 -to DRAM_DQ[17]
set_location_assignment PIN_P2 -to DRAM_DQ[18]
set_location_assignment PIN_N3 -to DRAM_DQ[19]
set_location_assignment PIN_N4 -to DRAM_DQ[20]
set_location_assignment PIN_M4 -to DRAM_DQ[21]
set_location_assignment PIN_M7 -to DRAM_DQ[22]
set_location_assignment PIN_L7 -to DRAM_DQ[23]
set_location_assignment PIN_Y3 -to DRAM_DQ[8]
set_location_assignment PIN_Y4 -to DRAM_DQ[9]
set_location_assignment PIN_AB1 -to DRAM_DQ[10]
set_location_assignment PIN_AA3 -to DRAM_DQ[11]
set_location_assignment PIN_AB2 -to DRAM_DQ[12]
set_location_assignment PIN_AC1 -to DRAM_DQ[13]
set_location_assignment PIN_AB3 -to DRAM_DQ[14]
set_location_assignment PIN_AC2 -to DRAM_DQ[15]
set_location_assignment PIN_W3 -to DRAM_DQ[0]
set_location_assignment PIN_W2 -to DRAM_DQ[1]
set_location_assignment PIN_V4 -to DRAM_DQ[2]
set_location_assignment PIN_W1 -to DRAM_DQ[3]
set_location_assignment PIN_V3 -to DRAM_DQ[4]
set_location_assignment PIN_V2 -to DRAM_DQ[5]
set_location_assignment PIN_V1 -to DRAM_DQ[6]
set_location_assignment PIN_U3 -to DRAM_DQ[7]
set_location_assignment PIN_W4 -to DRAM_DQM[1]
set_location_assignment PIN_K8 -to DRAM_DQM[2]
set_location_assignment PIN_U2 -to DRAM_DQM[0]
set_location_assignment PIN_N8 -to DRAM_DQM[3]
set_location_assignment PIN_U6 -to DRAM_RAS_n
set_location_assignment PIN_V7 -to DRAM_CAS_n
set_location_assignment PIN_AA6 -to DRAM_CKE
set_location_assignment PIN_V6 -to DRAM_WE_n
set_location_assignment PIN_T4 -to DRAM_CS_n
set_location_assignment PIN_U7 -to DRAM_BA[0]
set_location_assignment PIN_R4 -to DRAM_BA[1]
set_location_assignment PIN_Y7 -to DRAM_ADDR[12]
set_location_assignment PIN_AA5 -to DRAM_ADDR[11]
set_location_assignment PIN_R5 -to DRAM_ADDR[10]
set_location_assignment PIN_Y6 -to DRAM_ADDR[9]
set_location_assignment PIN_Y5 -to DRAM_ADDR[8]
set_location_assignment PIN_AA7 -to DRAM_ADDR[7]
set_location_assignment PIN_W7 -to DRAM_ADDR[6]
set_location_assignment PIN_W8 -to DRAM_ADDR[5]
set_location_assignment PIN_V5 -to DRAM_ADDR[4]
set_location_assignment PIN_R6 -to DRAM_ADDR[0]
set_location_assignment PIN_V8 -to DRAM_ADDR[1]
set_location_assignment PIN_U8 -to DRAM_ADDR[2]
set_location_assignment PIN_P1 -to DRAM_ADDR[3]
set_location_assignment PIN_Y15 -to IRDA_RXD
set_location_assignment PIN_L6 -to LCD_BLON
set_location_assignment PIN_M5 -to LCD_DATA[7]
set_location_assignment PIN_M3 -to LCD_DATA[6]
set_location_assignment PIN_K2 -to LCD_DATA[5]
set_location_assignment PIN_K1 -to LCD_DATA[4]
set_location_assignment PIN_K7 -to LCD_DATA[3]
set_location_assignment PIN_L2 -to LCD_DATA[2]
set_location_assignment PIN_L1 -to LCD_DATA[1]
set_location_assignment PIN_L3 -to LCD_DATA[0]
set_location_assignment PIN_L4 -to LCD_EN
set_location_assignment PIN_M1 -to LCD_RW
set_location_assignment PIN_M2 -to LCD_RS
set_location_assignment PIN_L5 -to LCD_ON
set_location_assignment PIN_F7 -to TD_DATA[7]
set_location_assignment PIN_E7 -to TD_DATA[6]
set_location_assignment PIN_D6 -to TD_DATA[5]
set_location_assignment PIN_D7 -to TD_DATA[4]
set_location_assignment PIN_C7 -to TD_DATA[3]
set_location_assignment PIN_D8 -to TD_DATA[2]
set_location_assignment PIN_A7 -to TD_DATA[1]
set_location_assignment PIN_E8 -to TD_DATA[0]
set_location_assignment PIN_D1 -to AUD_DACDAT
set_location_assignment PIN_E3 -to AUD_DACLRCK
set_location_assignment PIN_D2 -to AUD_ADCDAT
set_location_assignment PIN_C2 -to AUD_ADCLRCK
set_location_assignment PIN_E1 -to AUD_XCK
set_location_assignment PIN_F2 -to AUD_BCLK
set_location_assignment PIN_G6 -to PS2_KBCLK
set_location_assignment PIN_H5 -to PS2_KBDAT
set_location_assignment PIN_G5 -to PS2_MSCLK
set_location_assignment PIN_F5 -to PS2_MSDAT
set_location_assignment PIN_J13 -to UART_RTS
set_location_assignment PIN_D14 -to EEP_I2C_SCL
set_location_assignment PIN_E14 -to EEP_I2C_SDA
set_location_assignment PIN_B14 -to TD_CLK27
set_location_assignment PIN_D12 -to VGA_B[7]
set_location_assignment PIN_D11 -to VGA_B[6]
set_location_assignment PIN_C12 -to VGA_B[5]
set_location_assignment PIN_A11 -to VGA_B[4]
set_location_assignment PIN_B11 -to VGA_B[3]
set_location_assignment PIN_C11 -to VGA_B[2]
set_location_assignment PIN_B10 -to VGA_B[0]
set_location_assignment PIN_C9 -to VGA_G[7]
set_location_assignment PIN_F10 -to VGA_G[6]
set_location_assignment PIN_B8 -to VGA_G[5]
set_location_assignment PIN_C8 -to VGA_G[4]
set_location_assignment PIN_F8 -to VGA_G[2]
set_location_assignment PIN_G11 -to VGA_G[1]
set_location_assignment PIN_G8 -to VGA_G[0]
set_location_assignment PIN_H10 -to VGA_R[7]
set_location_assignment PIN_H8 -to VGA_R[6]
set_location_assignment PIN_J12 -to VGA_R[5]
set_location_assignment PIN_G10 -to VGA_R[4]
set_location_assignment PIN_F12 -to VGA_R[3]
set_location_assignment PIN_D10 -to VGA_R[2]
set_location_assignment PIN_E11 -to VGA_R[1]
set_location_assignment PIN_E12 -to VGA_R[0]
set_location_assignment PIN_A12 -to VGA_CLK
set_location_assignment PIN_F11 -to VGA_BLANK_n
set_location_assignment PIN_C10 -to VGA_SYNC_n
set_location_assignment PIN_G13 -to VGA_HS
set_location_assignment PIN_C13 -to VGA_VS
set_location_assignment PIN_G7 -to TD_RESET_n
set_location_assignment PIN_E4 -to TD_VS
set_location_assignment PIN_E5 -to TD_HS
set_location_assignment PIN_B7 -to I2C_SCL
set_location_assignment PIN_A8 -to I2C_SDA
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_TX_DATA[2]
set_instance_assignment -name IO_STANDARD "2.5 V" -to NET0_INT_n
set_instance_assignment -name IO_STANDARD "2.5 V" -to LEDR[2]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[8]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[9]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[10]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[11]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[8]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[9]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[10]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[11]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[8]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[9]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[10]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[11]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[7]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[8]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[9]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[10]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[11]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKIN_p2
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKIN_n2
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[0]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[1]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[2]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[3]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[4]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[5]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[6]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_p[7]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[0]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[1]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[2]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[3]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[4]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[5]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[6]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_TX_D_n[7]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[0]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[1]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[2]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[3]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[4]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[5]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[6]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_p[7]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[0]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[1]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[2]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[3]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[4]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[5]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_RX_D_n[6]
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKIN_p1
set_instance_assignment -name IO_STANDARD LVDS -to HSMC_CLKIN_n1
set_instance_assignment -name IO_STANDARD "3.0-V LVTTL" -to HSMC_CLKIN0

set_location_assignment PIN_AF27 -to HSMC_D[3]
set_location_assignment PIN_AB28 -to SW[0]
set_location_assignment PIN_AD15 -to GPIO_DATA[8]
set_location_assignment PIN_AE15 -to GPIO_DATA[9]
set_location_assignment PIN_AH23 -to GPIO_DATA[34]
set_location_assignment PIN_AG26 -to GPIO_DATA[35]

set_location_assignment PIN_J10 -to EXT_IO[0]
set_location_assignment PIN_J14 -to EXT_IO[1]
set_location_assignment PIN_H13 -to EXT_IO[2]
set_location_assignment PIN_H14 -to EXT_IO[3]
set_location_assignment PIN_E10 -to EXT_IO[5]
set_location_assignment PIN_D9 -to EXT_IO[6]
set_location_assignment PIN_D4 -to OTG_DACK_n[1]
set_location_assignment PIN_C4 -to OTG_DACK_n[0]
set_location_assignment PIN_A3 -to OTG_CS_n
set_location_assignment PIN_B3 -to OTG_OE_n
set_location_assignment PIN_B4 -to OTG_DREQ[1]
set_location_assignment PIN_A4 -to OTG_WE_n
set_location_assignment PIN_B6 -to OTG_LSPEED
set_location_assignment PIN_H7 -to OTG_A[0]
set_location_assignment PIN_C6 -to OTG_FSPEED
set_location_assignment PIN_D5 -to OTG_INT[1]
set_location_assignment PIN_C5 -to OTG_RESET_n
set_location_assignment PIN_A6 -to OTG_INT[0]
set_location_assignment PIN_J1 -to OTG_DREQ[0]
set_location_assignment PIN_C3 -to OTG_A[1]
set_location_assignment PIN_J6 -to OTG_DATA[0]
set_location_assignment PIN_K4 -to OTG_DATA[1]
set_location_assignment PIN_J5 -to OTG_DATA[2]
set_location_assignment PIN_K3 -to OTG_DATA[3]
set_location_assignment PIN_J4 -to OTG_DATA[4]
set_location_assignment PIN_J3 -to OTG_DATA[5]
set_location_assignment PIN_J7 -to OTG_DATA[6]
set_location_assignment PIN_H6 -to OTG_DATA[7]
set_location_assignment PIN_H3 -to OTG_DATA[8]
set_location_assignment PIN_H4 -to OTG_DATA[9]
set_location_assignment PIN_G1 -to OTG_DATA[10]
set_location_assignment PIN_G2 -to OTG_DATA[11]
set_location_assignment PIN_G3 -to OTG_DATA[12]
set_location_assignment PIN_F1 -to OTG_DATA[13]
set_location_assignment PIN_F3 -to OTG_DATA[14]
set_location_assignment PIN_G4 -to OTG_DATA[15]
set_location_assignment PIN_C14 -to NET0_LINK100
set_location_assignment PIN_D13 -to NET1_LINK100
set_location_assignment PIN_A14 -to NETCLK_25
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to NET0_LINK100
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to NET1_LINK100
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to NETCLK_25
set_instance_assignment -name IO_MAXIMUM_TOGGLE_RATE "0 MHz" -to HEX0_D
set_instance_assignment -name IO_MAXIMUM_TOGGLE_RATE "0 MHz" -to HEX1_D
set_instance_assignment -name IO_MAXIMUM_TOGGLE_RATE "0 MHz" -to HEX2_D
set_instance_assignment -name IO_MAXIMUM_TOGGLE_RATE "0 MHz" -to HEX3_D
set_instance_assignment -name IO_MAXIMUM_TOGGLE_RATE "0 MHz" -to KEY
set_instance_assignment -name IO_MAXIMUM_TOGGLE_RATE "0 MHz" -to SW
set_location_assignment PIN_F14 -to EXT_IO[4]
set_location_assignment PIN_G14 -to UART_CTS
set_location_assignment PIN_G12 -to UART_RXD
set_location_assignment PIN_G9 -to UART_TXD
set_location_assignment PIN_A10 -to VGA_B[1]
set_location_assignment PIN_H12 -to VGA_G[3]