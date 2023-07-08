/*
 * PIO_LED.h
 *
 *  Created on: 2014/9/24
 *      Author: User
 */

#ifndef PIO_LED_H_
#define PIO_LED_H_

#include "terasic_os.h"
#include "mmap.h"
class CPIO_LED{

public:
	static CMMap *m_mmap;
	CPIO_LED();
	virtual ~CPIO_LED();


	void SetLED(uint32_t Value);

};



#endif /* PIO_LED_H_ */
