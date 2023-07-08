#ifndef BT_SPP_COMMAND_H_
#define BT_SPP_COMMAND_H_

#include "BtSpp.h"

class CBtSppCommand: public CBtSpp {
public:
	typedef enum{
	CMD_LED0,
	CMD_LED1,
	CMD_LED2,
	CMD_LED3,
	CMD_LED_ON,
	CMD_LED_OFF,
	CMD_IDLE
	}COMMAND_ID;

protected:
	bool CommandParsing(char *pCommand, int *pCommandID, int *pParam);
	bool CommandRead(char *pBuffer, int nBufferSize, int *prx_lenmand);
	

public:
	CBtSppCommand();
	virtual ~CBtSppCommand();
	
	int CommandPolling(int *pParam);


};

#endif /* BT_SPP_COMMAND_H_ */
