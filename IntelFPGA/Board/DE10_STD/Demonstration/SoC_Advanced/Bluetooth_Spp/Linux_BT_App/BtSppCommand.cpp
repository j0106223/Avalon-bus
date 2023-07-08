/*
 * BtSppCommand.cpp
 *
 *  Created on: 2014/9/12
 *      Author: Richard
 */

#include "terasic_os.h"
#include "BtSppCommand.h"
#include <stdlib.h>


#define ACTION_START		0x30
#define ACTION_STOP			0x35

#define ACTION_FORDWARD		'8' //0x38
#define ACTION_BACKWARD		'2' //0x32
#define ACTION_TRUN_RIGHT	'6' //0x36
#define ACTION_TRUN_LEFT	'4' //0x34
#define ACTION_SPEED_UP		'+' //0x2b
#define ACTION_SPEED_DOWN	'-' //0x2d





typedef struct{
	char szCommand[10];
	int CommandId;
	bool bParameter;
}COMMAND_INFO;

COMMAND_INFO gCommandList[] = {
		{"ATLED0\n", CBtSppCommand::CMD_LED0, true},
		{"ATLED1\n", CBtSppCommand::CMD_LED1, false},
		{"ATLED2\n", CBtSppCommand::CMD_LED2, false},
		{"ATLED3\n", CBtSppCommand::CMD_LED3, false},
		{"ATON\n"  , CBtSppCommand::CMD_LED_ON, false},
		{"ATOFF\n", CBtSppCommand::CMD_LED_OFF, false},
};
CBtSppCommand::CBtSppCommand():
		CBtSpp()
	{
	// TODO Auto-generated constructor stub
//	strcpy(m_szUartName, pUartName);

}

CBtSppCommand::~CBtSppCommand() {
	// TODO Auto-generated destructor stub
}

/*
bool CBtSppCommand::Open(void){
	bool bSuccess;

	bSuccess = CUart::Open(m_szUartName);

	return bSuccess;

} */

int CBtSppCommand::CommandPolling(int *pParam){
	int Command = CMD_IDLE, ThisCommand;
	int ThisParam, nReadLen;
	char szData[32];

	if (CommandRead(szData, sizeof(szData), &nReadLen)){
		szData[nReadLen] = 0;
		printf("#[%.6f]:%s\r\n", (float)OS_GetTickCount()/(float)OS_TicksPerSecond(), szData);
		if (CommandParsing(szData, &ThisCommand, &ThisParam)){
			Command = ThisCommand;
			*pParam = ThisParam;

		}

	}	// if

	return Command;

}


bool CBtSppCommand::CommandParsing(char *pCommand, int *pCommandID, int *pParam){

	bool bFind = false;
	int nNum, i, j,x=0;
	bool find_equal = false;
	char Data[10]={0};
	nNum = sizeof(gCommandList)/sizeof(gCommandList[0]);


	for(i=0;i<nNum && !bFind;i++){
		if (strncmp(pCommand, gCommandList[i].szCommand, strlen(gCommandList[i].szCommand)) == 0){
			*pCommandID = gCommandList[i].CommandId;
			if (gCommandList[i].bParameter){
				//*pParam = 10; //??
				for(j=0;pCommand[j]!='\n';j++){
					if(find_equal==true){
						Data[x] = pCommand[j];
						x++;
					}
					else if(pCommand[j]=='=')
						find_equal=true;
				}
				*pParam=atoi(Data);
			}
			bFind = true;
		} // if

	} // for

	return bFind;

}

bool CBtSppCommand::CommandRead(char *pBuffer, int nBufferSize, int *prx_lenmand){
	int RxLen;
	char Data;
	bool bDone = false;
	int Len = 0;
	uint32_t timeout;

	if (!CBtSpp::NoneBlockingRead((char *)&Data, sizeof(Data), &RxLen) || RxLen == 0)
			return false;

	*(pBuffer + 0) = Data;

	// read until find '\r'
	timeout = OS_GetTickCount() + OS_TicksPerSecond()/100;
	Len = 1;
	while(!bDone){
		if (CBtSpp::NoneBlockingRead((char *)&Data, sizeof(Data), &RxLen) && RxLen == sizeof(Data)){
			*(pBuffer + Len) = Data;
			Len++;
			if (Data == '\n')
				bDone = true;
		}else if (Len >= nBufferSize){
			// buffer full
			bDone = true;
		}else if (OS_GetTickCount() > timeout){
			// timeout
			bDone = true;
		}else{
		}
		usleep(10);

	}
	*prx_lenmand = Len;


	return true;


}


