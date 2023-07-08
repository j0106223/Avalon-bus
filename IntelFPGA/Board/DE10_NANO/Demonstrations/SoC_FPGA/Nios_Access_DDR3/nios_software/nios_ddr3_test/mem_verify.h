/*
 * memry_verify.h
 *
 *  Created on: Dec 31, 2014
 *      Author: matthew
 */

#ifndef MEM_VERIFY_H_
#define MEM_VERIFY_H_

#include "terasic_includes.h"

bool TMEM_Verify(alt_u32 BaseAddr, alt_u32 ByteLen, alt_u32 InitValue, bool bShowMessage);


#endif /* MEMRY_VERIFY_H_ */
