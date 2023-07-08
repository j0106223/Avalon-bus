
#include "QueueCommand.h"


CQueueCommand::CQueueCommand(int QueueSize):
	CQueue(QueueSize)
	{
	// TODO Auto-generated constructor stub

}

CQueueCommand::~CQueueCommand() {
	// TODO Auto-generated destructor stub

}



bool CQueueCommand::Push(int Command, int Param){
    COMMAND_INFO *pCommandInfo;

    if (IsFull())
        return false;
    
    pCommandInfo = new COMMAND_INFO;
    pCommandInfo->Command = Command;
    pCommandInfo->Param = Param;

    return CQueue::Push((void *)pCommandInfo);

}

bool CQueueCommand::Pop(int *pCommand, int *pParam){
    COMMAND_INFO *pCommandInfo;

    if (IsEmpty())
        return false;

    pCommandInfo = (COMMAND_INFO *)CQueue::Pop();
    *pCommand = pCommandInfo->Command;
    *pParam = pCommandInfo->Param;
    return true;
}

void CQueueCommand::Clear(void){
	COMMAND_INFO *pCommandInfo;

	while(!IsEmpty()){
		pCommandInfo = (COMMAND_INFO *)CQueue::Pop();
		delete pCommandInfo;
	}
	CQueue::Clear();
}

