#ifndef QUEUE_COMMAND_H_
#define QUEUE_COMMANDH_

#include "Queue.h"

class CQueueCommand : public CQueue {
protected:
	typedef struct{
		int Command;
		int Param;
	}COMMAND_INFO;


public:
	CQueueCommand(int QueueSize = 8);
	virtual ~CQueueCommand();
	bool Push(int Command, int Param);
	bool Pop(int *pCommand, int *pParam);
	void Clear(void);

};

#endif /* QUEUE_COMMANDH_ */
