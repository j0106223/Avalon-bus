/*
 * PIO_LED.cpp
 *
 *  Created on: 2014/9/24
 *      Author: User
 */


#include "terasic_os.h"
#include "PIO_LED.h"
#include "mmap.h"
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "hps_0.h"

CMMap* CPIO_LED::m_mmap=NULL;
#define REG_SET	    0

CPIO_LED::CPIO_LED()

{
	m_mmap = new CMMap(CMMap::MAP_H2F_LW_BRIDGE);
	m_mmap->Reg32_Write(LEDR_BASE,REG_SET,0x0);
};

CPIO_LED::~CPIO_LED() {
	// TODO Auto-generated destructor stub
		delete m_mmap;
}



void CPIO_LED::SetLED(uint32_t Value)
{
	m_mmap->Reg32_Write(LEDR_BASE,REG_SET,Value);
}





