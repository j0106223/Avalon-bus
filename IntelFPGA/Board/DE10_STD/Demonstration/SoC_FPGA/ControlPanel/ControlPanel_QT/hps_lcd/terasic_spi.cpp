#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include "terasic_spi.h"

#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "socal/alt_spim.h"
#include "socal/alt_rstmgr.h"


#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )

TERASIC_SPI::TERASIC_SPI(void):
	m_bIsConnected(false)
{
}

TERASIC_SPI::~TERASIC_SPI(void)
{
  //  Disconnect();
}



bool TERASIC_SPI::Connect(void){
	//bool bSuccess = false;
	
	Disconnect();
    m_fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) );
    if (m_fd == -1){
        printf("Error: failed to open memory map driver!\r\n");
        return false;
    }	
    m_virtual_base = (uint32_t) mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, m_fd, HW_REGS_BASE );

	usleep( 1000000 / 16 );
	
    //printf("[SPIM0]enable SPIM0 interface\r\n");
	// initialize the  peripheral to talk to the LCM
	alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_RSTMGR_PERMODRST_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_RSTMGR_PERMODRST_SPIM0_SET_MSK );
	
	//===================
	// step 1: disable SPI
	//         writing 0 to the SSI Enable register (SSIENR).
	//
	
    //printf("[SPIM0]SPIM0.spi_en = 0 # disable the SPI master\r\n");
	// [0] = 0, to disalbe SPI
	alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_SPIENR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_SPIENR_SPI_EN_SET_MSK );
	
	//===================
	// step 2: setup 
	//         Write Control Register 0 (CTRLLR0).
	//         Write the Baud Rate Select Register (BAUDR)
	//         Write the Transmit and Receive FIFO Threshold Level registers (TXFTLR and RXFTLR) to set FIFO buffer threshold levels.
	//         Write the IMR register to set up interrupt masks.
	//         Write the Slave Enable Register (SER) register here to enable the target slave for selection......
	

	// Transmit Only: Transfer Mode [9:8], TXONLY = 0x01
    //printf("[SPIM0]SPIM0_ctrlr0.tmod = 1  # TX only mode\r\n");
	alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_CTLR0_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_CTLR0_TMOD_SET_MSK );
	alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_CTLR0_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_CTLR0_TMOD_SET( ALT_SPIM_CTLR0_TMOD_E_TXONLY ) );
	
	
	// 200MHz / 64 = 3.125MHz: [15:0] = 64
    //printf("[SPIM0]SPIM0_baudr.sckdv = 64  # 200MHz / 64 = 3.125MHz\r\n");
	alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_BAUDR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_BAUDR_SCKDV_SET_MSK );
	alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_BAUDR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_BAUDR_SCKDV_SET( 64 ) );



	// ss_n0 = 1, [3:0]
    //printf("[SPIM0]SPIM0_ser.ser = 1  #ss_n0 = 1\r\n");
	alt_clrbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_SER_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_SER_SER_SET_MSK );
	alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_SER_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_SER_SER_SET( 1 ) );
	
	
	
	//===================
	// step 3: Enable the SPI master by writing 1 to the SSIENR register.
	// ALT_SPIM0_SPIENR_ADDR
    //printf("[SPIM0]spim0_spienr.spi_en = 1  # ensable the SPI master\r\n");
	alt_setbits_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_SPIENR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_SPIENR_SPI_EN_SET_MSK );
	
	// step 4: Write data for transmission to the target slave into the transmit FIFO buffer (write DR)
	//alt_setbits_word( ( virtual_base + ( ( uint32_t )( ALT_SPIM0_DR_ADDR ) & ( uint32_t )( ALT_SPIM1_SPIENR_ADDR ) ) ), data16 );
  m_bIsConnected = true;
  return true;

}

bool TERASIC_SPI::Disconnect(void){
	if (m_fd != -1){	
		close(m_fd);
		m_fd = -1;
	}
	m_bIsConnected = false;
	
	return true;		
}

bool TERASIC_SPI::Write8(uint8_t Data8){
	

	while( ALT_SPIM_SR_TFE_GET( alt_read_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_SR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ) ) ) != ALT_SPIM_SR_TFE_E_EMPTY );
	alt_write_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_DR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ), ALT_SPIM_DR_DR_SET( Data8 ) );
	while( ALT_SPIM_SR_TFE_GET( alt_read_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_SR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ) ) ) != ALT_SPIM_SR_TFE_E_EMPTY );
	while( ALT_SPIM_SR_BUSY_GET( alt_read_word( ( m_virtual_base + ( ( uint32_t )( ALT_SPIM0_SR_ADDR ) & ( uint32_t )( HW_REGS_MASK ) ) ) ) ) != ALT_SPIM_SR_BUSY_E_INACT );
	
	return true;
	
	
}

bool TERASIC_SPI::IsConnected(void){
		return m_bIsConnected;
}


