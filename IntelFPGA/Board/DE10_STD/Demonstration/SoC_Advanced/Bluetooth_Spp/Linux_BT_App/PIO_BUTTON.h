/*
 * PIO_LED.h
 *
 *  Created on: 2014/9/24
 *      Author: User
 */

#ifndef PIO_BUTTON_H_
#define PIO_BUTTON_H_

#include "terasic_os.h"
#include "mmap.h"
class CPIO_BUTTON{

public:
	static CMMap *m_mmap;
	CPIO_BUTTON();
	virtual ~CPIO_BUTTON();


	uint32_t GetBUTTON(void);

};



#endif /* PIO_LED_H_ */
