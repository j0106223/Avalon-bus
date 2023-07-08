#include "terasic_includes.h"
#include "video_control.h"
#include "i2c.h"

typedef struct{
    alt_u8 Address;
    alt_u8  Data;
}I2C_CONFIG;

I2C_CONFIG szTvConfig[] = {
#if 1

    {0x00, 0x00},
    {0xc3, 0x01},
    {0xc4, 0x80},
    {0x04, 0x57},
    {0x17, 0x41},
    {0x58, 0x01},
    {0x3d, 0xa2},
    {0x37, 0xa0},
    {0x3e, 0x6a},
    
    {0x3f, 0xa0},
    {0x0d, 0xc7},
    {0x55, 0x81},
    {0x37, 0xa0},
    {0x08, 0x80},
    {0x27, 0xd8},
    {0x2c, 0x8e},
    {0x2d, 0xf8},
    {0x2e, 0xce},
    {0x2f, 0xf4},
    {0x30, 0xb2},
    {0x0e, 0x00} 

/*
        {0x00, 0x00}, // // input control: Autodetect TV format, Coposite input
        {0xc3, 0x01}, // select AIN1
        {0xc4, 0x80}, // manual select
        {0x3a, 0x17}, // AIN2,3 power down
        {0x04, 0x44}, // ITU-R BT.656 compatible
        {0x0d, 0x1c},  // Set Free-run color
     
    {0x00, 0x00},
    {0xc3, 0x01},
    {0xc4, 0x80},
    {0x04, 0x57},
    {0x17, 0x41},
    {0x58, 0x01},
    {0x3d, 0xa2},
    {0x37, 0xa0},
    {0x3e, 0x6a},
    
    {0x3f, 0xa0},
    {0x0e, 0x80},
    {0x55, 0x81},
    {0x37, 0xa0},
    {0x08, 0x80},
    {0x0a, 0x18},
    {0x2c, 0x8e},
    {0x2d, 0xf8},
    {0x2e, 0xce},
    {0x2f, 0xf4},
    {0x30, 0xb2},
    {0x0e, 0x00} */
#else    
    {0x15, 0x00},
    {0x17, 0x41},
    {0x3A, 0x16},
    {0x50, 0x04},
    {0xC3, 0x05},
    {0xC4, 0x80},
    {0x0E, 0x80},
    {0x50, 0x20},
    {0x52, 0x18},
    {0x58, 0xED},
    {0x77, 0xC5},
    {0x7C, 0x93},
    {0x7D, 0x00},
    {0xD0, 0x48},
    {0xD5, 0xA0},
    {0xD7, 0xEA},
    {0xE4, 0x3E},
    {0xEA, 0x0F},
    {0xE9, 0x3E},
    {0x0E, 0x00}
#endif    
  
};    


bool VIDEO_Enable(bool bEnable){
    bool bPass = TRUE;
    int nNum, i;
    alt_u8 ID;
/*    
    alt_u16 szReg[] = {
        0x0000, // // input control: Autodetect TV format, Coposite input
        0xc301, // select AIN1
        0xc480, // manual select
        0x3a17, // AIN2,3 power down
        0x0444, // ITU-R BT.656 compatible
        0x0d1c  // Set Free-run color
    };
     */
    
    IOWR(ALT_VIP_CTI_0_BASE, 0, bEnable?0x01:0x00);
    if (!bEnable)
        return TRUE; 
     
    nNum = sizeof(szTvConfig)/sizeof(szTvConfig[0]);
    
  //  hardware reset
    IOWR(TD_RESET_N_BASE, 0, 0x01);
    usleep(100);
    IOWR(TD_RESET_N_BASE, 0, 0x00);
    usleep(100);
    IOWR(TD_RESET_N_BASE, 0, 0x01);
    usleep(100);
    

    if (I2C_Read(I2C_SCL_BASE, I2C_SDA_BASE, I2C_TV_ADDR, 0x11, &ID)){
    	printf("id(reg 0x11)=%02xh\r\n", ID);
    }else{
    	printf("Failed to read chip id\r\n");

    }

    for(i=0;i<nNum && bPass;i++){
        bPass = I2C_Write(I2C_SCL_BASE, I2C_SDA_BASE, I2C_TV_ADDR, szTvConfig[i].Address, szTvConfig[i].Data);
        usleep(10);
    }        
    return bPass;
}


// background is layer 0 ???



void MIX_LayerEnable(int nLayerIndex, bool bEnable){

	// stop
	IOWR(ALT_VIP_MIX_0_BASE, 0x00, 0x00);

	IOWR(ALT_VIP_MIX_0_BASE, nLayerIndex*3+1, bEnable?0x01:0x00);

	// start
	IOWR(ALT_VIP_MIX_0_BASE, 0x00, 0x01);
}

void MIX_LayerMove(int nLayerIndex, int x, int y){
	IOWR(ALT_VIP_MIX_0_BASE, nLayerIndex*3-1, x);
	IOWR(ALT_VIP_MIX_0_BASE, nLayerIndex*3+0, y);

}



void MIX_Init(void){

	// stop
	IOWR(ALT_VIP_MIX_0_BASE, 0x00, 0x00);

	// disable layer 1 (second layer)
//	MIX_LayerEnable(1, FALSE);
	//MIX_LayerMove(1, 0, 0);


	// start
	IOWR(ALT_VIP_MIX_0_BASE, 0x00, 0x01);

}


