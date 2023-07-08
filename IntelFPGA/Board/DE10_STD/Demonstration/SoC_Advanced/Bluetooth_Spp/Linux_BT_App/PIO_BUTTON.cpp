/*
 * PIO_LED.cpp
 *
 *  Created on: 2014/9/24
 *      Author: User
 */


#include "terasic_os.h"
#include "PIO_BUTTON.h"
#include "mmap.h"
#include "hwlib.h"
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_gpio.h"
#include "hps_0.h"

CMMap* CPIO_BUTTON::m_mmap=NULL;
#define REG_ADDR	    0

CPIO_BUTTON::CPIO_BUTTON()

{
	m_mmap = new CMMap(CMMap::MAP_H2F_LW_BRIDGE);
};

CPIO_BUTTON::~CPIO_BUTTON() {
	// TODO Auto-generated destructor stub
		delete m_mmap;
}



uint32_t CPIO_BUTTON::GetBUTTON()
{
	return (m_mmap->Reg32_Read(KEY_BASE,REG_ADDR) & 0x3);
}





