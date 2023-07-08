#include "terasic_os.h"
#include <pthread.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include "BtSppCommand.h"
#include "mmap.h"
#include "QueueCommand.h"
#include "PIO_LED.h"
#include "PIO_BUTTON.h"
#include <time.h>


typedef enum{
	CMD_LED0,
	CMD_LED1,
	CMD_LED2,
	CMD_LED3,
	CMD_LED_ON,
	CMD_LED_OFF,
	CMD_IDLE,
}COMMAND_ID;


static void *bluetooth_spp_thread(void *ptr)
{

	CBtSppCommand BtSppCommand;
	CQueueCommand *pQueueCommand;
	int Command, Param;
	pQueueCommand = (CQueueCommand *)ptr;
	printf("[BT]Start Service\r\n");
	BtSppCommand.RegisterService();
	while(1){
		printf("[BT]Lisen...\r\n");
		BtSppCommand.RfcommOpen();
		printf("[BT]Connected...\r\n");
		while(1){
			Command = BtSppCommand.CommandPolling(&Param);
			if (Command != CMD_IDLE){
				// push command to command queue
				if (Command == CMD_LED_OFF)
				   pQueueCommand->Clear();
				// push command to command queue
				if (!pQueueCommand->IsFull()){
				   pQueueCommand->Push(Command, Param);
				    }
			}
		}
		printf("[BT]Disconneected...\r\n");
		BtSppCommand.RfcommClose();
	}

//	pthread_exit(0); /* exit */
	return 0;
}

int main(int argc, char *argv[]){

    CQueueCommand QueueCommand;
    int Command, Param;
    bool bSleep = false;
    CPIO_LED LED_PIO;
    CPIO_BUTTON BUTTON_PIO;
    pthread_t id0;
    int ret0;

	printf("Create Bluetooth Thread\r\n");
	ret0=pthread_create(&id0,NULL,bluetooth_spp_thread, (void *)&QueueCommand);
	if(ret0!=0){
		printf("Creat pthread-0 error!\n");
		//exit(1);
	}
	printf("Listen Command...\r\n");
	LED_PIO.SetLED(0x0);
	while(1)
	{
		if(!QueueCommand.IsEmpty() && QueueCommand.Pop(&Command, &Param) ){
			switch(Command){
			case CMD_LED0:printf("CMD_LED1\n");
								LED_PIO.SetLED(0x1);
							  break;
			case CMD_LED1:printf("CMD_LED2\n");
								LED_PIO.SetLED(0x2);
							  break;

			case CMD_LED2:printf("CMD_LED3\n");
								LED_PIO.SetLED(0x4);
							  break;

			case CMD_LED3:printf("CMD_LED4\n");
								LED_PIO.SetLED(0x8);
							   break;

			case CMD_LED_ON:printf("CMD_ON\n");
								LED_PIO.SetLED(0xFF);
							   break;

			case CMD_LED_OFF:printf("CMD_OFF\n");
								LED_PIO.SetLED(0x0);
							   break;

			default:printf("Nothing\n");break;
			} 
		}

	}



	return 0;
}
