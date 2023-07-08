#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "hwlib.h"
#include "ADXL345.h"



bool ADXL345_REG_WRITE(int file, uint8_t address, uint8_t value){
	bool bSuccess = false;
	uint8_t szValue[2];
	
	// write to define register
	szValue[0] = address;
	szValue[1] = value;
	if (write(file, &szValue, sizeof(szValue)) == sizeof(szValue)){
			bSuccess = true;
	}		
	
	return bSuccess;		
}

bool ADXL345_REG_READ(int file, uint8_t address,uint8_t *value){
	bool bSuccess = false;
	uint8_t Value;
	
	// write to define register
	if (write(file, &address, sizeof(address)) == sizeof(address)){
	
		// read back value
		if (read(file, &Value, sizeof(Value)) == sizeof(Value)){
			*value = Value;
			bSuccess = true;
		}
	}		
	
	return bSuccess;	
}

bool ADXL345_REG_MULTI_READ(int file, uint8_t readaddr,uint8_t readdata[], uint8_t len){
	bool bSuccess = false;

	// write to define register
	if (write(file, &readaddr, sizeof(readaddr)) == sizeof(readaddr)){
		// read back value
		if (read(file, readdata, len) == len){
			bSuccess = true;
		}
	}			
	return bSuccess;
}





int main(int argc, char *argv[]){
	
	int file;
	const char *filename = "/dev/i2c-0";
	uint8_t id;
	bool bSuccess;
	const int mg_per_digi = 4;
	uint16_t szXYZ[3];
	int cnt=0, max_cnt=0;
	
	printf("===== gsensor test =====\r\n");
	
	if (argc == 2){
		max_cnt = atoi(argv[1]);
	}
	
	// open bus
	if ((file = open(filename, O_RDWR)) < 0) {
  	  /* ERROR HANDLING: you can check errno to see what went wrong */
	    perror("Failed to open the i2c bus of gsensor");
  	  exit(1);
	}	
	

	// init	 
	// gsensor i2c address: 101_0011
	int addr = 0b01010011; 
	if (ioctl(file, I2C_SLAVE, addr) < 0) {
  	  printf("Failed to acquire bus access and/or talk to slave.\n");
	    /* ERROR HANDLING; you can check errno to see what went wrong */
  	  exit(1);
	}	
	

    // configure accelerometer as +-2g and start measure
    bSuccess = ADXL345_Init(file);
    if (bSuccess){
        // dump chip id
        bSuccess = ADXL345_IdRead(file, &id);
        if (bSuccess)
            printf("id=%02Xh\r\n", id);
    }        
    
    
    while(bSuccess && (max_cnt == 0 || cnt < max_cnt)){
        if (ADXL345_IsDataReady(file)){
            bSuccess = ADXL345_XYZ_Read(file, szXYZ);
            if (bSuccess){
	              cnt++;
                printf("[%d]X=%d mg, Y=%d mg, Z=%d mg\r\n", cnt,(int16_t)szXYZ[0]*mg_per_digi, (int16_t)szXYZ[1]*mg_per_digi, (int16_t)szXYZ[2]*mg_per_digi);
                // show raw data, 
                //printf("X=%04x, Y=%04x, Z=%04x\r\n", (alt_u16)szXYZ[0], (alt_u16)szXYZ[1],(alt_u16)szXYZ[2]);
                usleep(1000*1000);
            }
        }
    }
    
    if (!bSuccess)
        printf("Failed to access accelerometer\r\n");
	
		if (file)
			close(file);
			
		printf("gsensor, bye!\r\n");			


	return 0;
	
}