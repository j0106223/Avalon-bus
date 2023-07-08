/* referece

-----
https://www.kernel.org/doc/Documentation/i2c/dev-interface
ioctl(file, I2C_RDWR, struct i2c_rdwr_ioctl_data *msgset)
  Do combined read/write transaction without stop in between.
  Only valid if the adapter has I2C_FUNC_I2C.  The argument is
  a pointer to a


-----
http://bunniestudios.com/blog/images/infocast_i2c.c
get_i2c_register example	
	
*/



#include <errno.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <linux/i2c.h>
#include <linux/i2c-dev.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"




#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

#define HPS_I2C_CONTROL	( 0x00080000 )  // GPIO48, CONTROL1


#define USE_RESTART   // for Video-in chip, need to enable restart


////////////////////////////
// using i2c restart

#ifdef USE_RESTART


static int set_i2c_register(int file,
                            unsigned char addr,
                            unsigned char reg,
                            unsigned char value) {

    unsigned char outbuf[2];
    struct i2c_rdwr_ioctl_data packets;
    struct i2c_msg messages[1];

    messages[0].addr  = addr;
    messages[0].flags = 0;
    messages[0].len   = sizeof(outbuf);
    messages[0].buf   = outbuf;

    /* The first byte indicates which register we'll write */
    outbuf[0] = reg;

    /* 
     * The second byte indicates the value to write.  Note that for many
     * devices, we can write multiple, sequential registers at once by
     * simply making outbuf bigger.
     */
    outbuf[1] = value;

    /* Transfer the i2c packets to the kernel and verify it worked */
    packets.msgs  = messages;
    packets.nmsgs = 1;
    if(ioctl(file, I2C_RDWR, &packets) < 0) {
        perror("Unable to send data");
        return 1;
    }

    return 0;
}

static int get_i2c_register(int file,
                            unsigned char addr,
                            unsigned char reg,
                            unsigned char *val) {
    unsigned char inbuf, outbuf;
    struct i2c_rdwr_ioctl_data packets;
    struct i2c_msg messages[2];

    /*
     * In order to read a register, we first do a "dummy write" by writing
     * 0 bytes to the register we want to read from.  This is similar to
     * the packet in set_i2c_register, except it's 1 byte rather than 2.
     */
    outbuf = reg;
    messages[0].addr  = addr;
    messages[0].flags = 0;
    messages[0].len   = sizeof(outbuf);
    messages[0].buf   = &outbuf;

    /* The data will get returned in this structure */
    messages[1].addr  = addr;
    messages[1].flags = I2C_M_RD/* | I2C_M_NOSTART*/;
    messages[1].len   = sizeof(inbuf);
    messages[1].buf   = &inbuf;

    /* Send the request to the kernel and get the result back */
    packets.msgs      = messages;
    packets.nmsgs     = 2;
    if(ioctl(file, I2C_RDWR, &packets) < 0) {
        perror("Unable to send data");
        return 1;
    }
    *val = inbuf;

    return 0;
}

#else


bool I2C_REG_WRITE(int file, uint8_t address, uint8_t value){
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


bool I2C_REG_READ(int file, uint8_t address,uint8_t *value){
	
	bool bSuccess = false;
	uint8_t Value;
	int read_len;
	
	// write to define register
	if (write(file, &address, sizeof(address)) == sizeof(address)){

		// read back value
		read_len = read(file, &Value, sizeof(Value));
		if (read_len == sizeof(Value)){
			  *value = Value;
			  bSuccess = true;
		}else{
	  	  printf("read fail (read_len=%d)\r\n", read_len);
	  }
	}else{
	  printf("write fail\r\n");
  }
	
	
	return bSuccess;	
}

#endif




int main(int argc,char ** argv) {
	
	

   void *virtual_base;
   int fd;
   bool bSuccess = true;
   
   int file;
   const char *filename = "/dev/i2c-0";
	 int addr = 0b00100000; // video-in chip
   char reg = 0x11; // 
   
   uint8_t result;
   
   
   printf("I2C BUS Switch Test\r\n");
	 if (argc >= 2){
		 addr = atoi(argv[1]);
	 }   
	 if (argc >= 3){
		 reg = atoi(argv[2]);
	 }   
   	
   if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
	    printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}

	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );



	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}
	
	//I2C multplex control
	// set the direction of the I2C direction bits attached to U10 to output
	alt_setbits_word( ( virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DDR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_I2C_CONTROL );
	// open the i2c interface with HPS
	alt_setbits_word( ( virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_I2C_CONTROL );
//	alt_clrbits_word( ( virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_I2C_CONTROL );
//	usleep( 100*1000 );	
  printf( "HPS owns the I2C bus!!!\n" );
    
	///////////////////////////////////////////
	// adv7180 i2c verify
	
	// open i2c bus
	if ((file = open(filename, O_RDWR)) < 0) {
  	  /* ERROR HANDLING: you can check errno to see what went wrong */
	    printf("Failed to open the i2c bus of %s", filename);
	    bSuccess = false;
	}else{
		printf("Open '%s' successfully.\r\n", filename);
	}	
	
#ifdef USE_RESTART
	if (get_i2c_register(file, addr, reg, &result)){
		bSuccess = false;
	}else{
	  bSuccess = true;
  }
  
#else	
	if (ioctl(file, I2C_SLAVE, addr) < 0) {
  	  printf("[VIDEO] Failed to acquire bus access and/or talk to slave ADV7180.\n");
  	  bSuccess = false;
	}	
	
	if (bSuccess)
	    bSuccess = I2C_REG_READ(file,reg,&result); 
	    
#endif
	
    if (bSuccess)
      	printf("REG[%xh]=%02Xh (i2c addr:%xh)\r\n", reg, result, addr);
		else
				printf("Failed to read register %02xh (i2c addr:%xh)\r\n", reg, addr);      	  
      	

	if (file)
		close(file);

	// end of adv7180 i2c verify
	///////////////////////////////////////////

    
	// i2c bus restore
	alt_clrbits_word( ( virtual_base + ( ( uint32_t )( ALT_GPIO1_SWPORTA_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), HPS_I2C_CONTROL );
  printf( "HPS release the I2C bus!!!\n" );
  
  printf("I2C Switch Test:%s\r\n", bSuccess?"Success":"Fail");

		 
	if( munmap( virtual_base, HW_REGS_SPAN ) != 0 ) {
		printf( "ERROR: munmap() failed...\n" );
		close( fd );
		return( 1 );
	}

	close( fd );

	return( 0 );

}


