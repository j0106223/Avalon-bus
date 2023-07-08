#ifndef CY7C67200_CMD_DATA_H
#define CY7C67200_CMD_DATA_H

/* COPYRIGHT 2002, CYPRESS SEMICONDUCTOR CORP.           */

#define SIE0						0
#define SIE1						1
#define SIEBOTH						2

#define cSIE1						0
#define cSIE2						1

#define PORT0						0
#define PORT1						1
#define PORT2						2
#define PORT3						3

#define HOST_ROLE    	    		0
#define PERIPHERAL_ROLE     		1
#define HOST_INACTIVE_ROLE  		2
#define PERIPHERAL_INACTIVE_ROLE  	3


//For host use
#define SIE1_DATA_BUFFER_OFFSET 	0
#define SIE1_DATA_BUFFER_SIZE 		0x800
#define SIE2_DATA_BUFFER_OFFSET 	SIE1_DATA_BUFFER_OFFSET+SIE1_DATA_BUFFER_SIZE
#define SIE2_DATA_BUFFER_SIZE 		0x800

//for peripheral use
#define EP1_CTL_STRUCTURE_OFFSET	SIE2_DATA_BUFFER_OFFSET+SIE2_DATA_BUFFER_SIZE		
#define EP1_CTL_STRUCTURE_SIZE		8
#define EP1_DATA_BUFFER_OFFSET		EP1_CTL_STRUCTURE_OFFSET+EP1_CTL_STRUCTURE_SIZE		
#define EP1_DATA_BUFFER_SIZE		0x400

#define EP2_CTL_STRUCTURE_OFFSET	EP1_DATA_BUFFER_OFFSET+EP1_DATA_BUFFER_SIZE		   
#define EP2_CTL_STRUCTURE_SIZE		8
#define EP2_DATA_BUFFER_OFFSET		EP2_CTL_STRUCTURE_OFFSET+EP2_CTL_STRUCTURE_SIZE	  
#define EP2_DATA_BUFFER_SIZE		0x400

#define EP3_CTL_STRUCTURE_OFFSET	EP2_DATA_BUFFER_OFFSET+EP2_DATA_BUFFER_SIZE
#define EP3_CTL_STRUCTURE_SIZE		8
#define EP3_DATA_BUFFER_OFFSET		EP3_CTL_STRUCTURE_OFFSET+EP3_CTL_STRUCTURE_SIZE
#define EP3_DATA_BUFFER_SIZE		8    

/* Use in the 0xc080 and 0xc0a0 */
#define HOST_HCTL_ARM_BIT           1
#define HOST_HCTL_ISOCH_BIT         4
#define HOST_HCTL_AFTERSOF_BIT      5
#define HOST_HCTL_DT_BIT            6
#define HOST_HCTL_PREAMBLE_BIT      7

#define CY_TD_SIZE					12

#define bmPID_MASK                  0xF
#define MAX_RETRY_TIMES				3
#define EZHOST_EOT					0 //4200


#define cCONTROLTRANSFER			0
#define cISOTRANSFER				1
#define cBULKTRANSFER				2
#define cINTERRUPTTRANSFER			3

#define PID_SOF                 	0x5
#define PID_IN                  	0x9
#define PID_OUT                 	0x1
#define PID_SETUP               	0xD
#define PID_DATA0               	0x3
#define PID_DATA1               	0xB
#define PID_ACK                 	0x2
#define PID_NAK                 	0xA
#define PID_STALL               	0xE
#define PID_PRE                 	0xC

#define cEP0                 		0
#define cEP1                 		1
#define cEP2                 		2
#define cEP3                 		3
#define cEP4                 		4
#define cEP5                 		5
#define cEP6                 		6
#define cEP7                 		7


#define TDERROR_SUCCESS             0
#define TDERROR_STALLED             1
#define TDERROR_SHORTPACKET         2
#define TDERROR_RETRY           	3
#define TDERROR_NOTEXECUTED         4
#define TDERROR_COUNTERDEC			5

//port control and status command

//For the LCP COMMAND_WRITE_CTRL_REG
#define DIRECT_WRITE				0
#define DIRECT_AND					1
#define DIRECT_OR					2



#define SUSB_CLASS_MSG              1<<13    //to SIE1_MBOX
#define PORT0_SPEED_MSG				1<<15	 //to SIE1_MBOX
#define OTG_FAILURE_MSG				1<<14	 //to SIE2_MBOX
#define SUSB_OTG_MSG				1<<15	 //to SIE2_MBOX


#define OTG_FAILURE_NOT_SUPPORT	    0x0000
#define OTG_FAILURE_NOT_RESPOND	    0x0001


//Common memory for pass data between ez-host and external CPU
#define CLASS_COMMAND_ADDR						0x1E0
#define MBOXINT_BELONG_TO_HOST_FLG_ADDR			0x1E2	  //1 --host, 0 -- peripheral
#define PORT0_RESET_DONE_ADDR					0x1E4	  
#define SIEMBX_MSG_PASS_ADDR					0x1E6	  //pass the sie mbox msg to peripheral
#define PORT0_SPEED								0x1E8
#define OTG_INPUT_ADDR							0x1EA
#define OTG_FAILURE_ADDR						0x1EC	  //pass the faiure ID

#define SIE1_CONFIGURATION_ADDR		0x401


#define B_HNP_ENABLE				3
#define A_HNP_SUPPORT				4
#define A_ALT_HNP_SUPPORT			5

#define USB_OTG_SRP_SUPPORT 		0x01
#define USB_OTG_HNP_SUPPORT 		0x02


#define SIE1MSG                 0x0010              
#define SIE2MSG                 0x0020


/************************************************************ */
/* LCP COMMUNICATION EQUATES - Common for HPI, HSS and SPI    */
/************************************************************ */
/* THESE DEFINITIONS DEFINE THE LYBERTY CONTROL PROTOCOL (LCP) */
/* SBN: Jan/28/03 Update Host/Slave SIEx Message codde handle */
/* SBN: Jan/26/03 Remove CRB code */


/* ====== Default DTL Ports and CMDS ====== */
#define PORT_CMD_PROC                                        0x0000

/* --- CMDS --- */
#define CP_GET_PORT_LIST                                     0x0000
#define CP_SINGLE_PORT_MODE                                  0x0001 /*-- One port at a time access */
#define CP_MULTI_PORT_MODE                                   0x0002 /*-- Multiple Ports Active at a time */

#define PORT_HUSB                                            0x0001 /* SIE1/SIE2 and USB_A-USB_D controlled via CMDs */

#define PORT_SUSB                                            0x0002 /* SIE1/SIE2 and USB_A-USB_D controlled via CMDs */

#define PORT_SPI                                             0x0003

#define PORT_HSS                                             0x0004

#define PORT_IDE                                             0x0005

#define PORT_HPI                                             0x0006 /* HPI Master Mode DMA and MailBox control */

#define PORT_DRAM                                            0x0007


/* ====== HOST TO LYBERTY PORT COMMAND EQUATES ====== */

/* -- CMDs common to all ports -- */
#define COMM_RESET                                           0xFA50
#define COMM_JUMP2CODE                                       0xCE00 /* CE = CMD Equate */
#define COMM_EXEC_INT                                        0xCE01
#define COMM_READ_CTRL_REG                                   0xCE02
#define COMM_WRITE_CTRL_REG                                  0xCE03
#define COMM_CALL_CODE                                       0xCE04
#define COMM_READ_XMEM                                       0xCE05 /* Can access IRAM too but uses a small buffer */
#define COMM_WRITE_XMEM                                      0xCE06 /*   compared to READ_MEM and WRITE_MEM */
#define COMM_CONFIG                                          0xCE07 /* Uses COMM_BAUD_RATE to change HSS BaudRate etc */

/* -- CMDs for HSS and SPI  -- */
#define COMM_READ_MEM                                        0xCE08 /* Addr and Len sent as part of CMD  packet  */
#define COMM_WRITE_MEM                                       0xCE09 /* Addr and Len sent as part of CMD packet  */

/* ====== LYBERTY TO HOST RESPONSE AND COMMAND EQUATES ====== */
/* ----- Response Equates should Use 0xCxxx, 0xDxxx, 0xExxx, 0xFxxx --- */
/* General Responses */
#define COMM_ACK                                             0x0FED /* I ate it just fine. */
#define COMM_NAK                                             0xDEAD /* Sorry I'm not feeling well. */

/* Message for SIE1 and SIE2 in register 0x144 and 0x148 */
#define SUSB_EP0_MSG                                         0x0001
#define SUSB_EP1_MSG                                         0x0002
#define SUSB_EP2_MSG                                         0x0004
#define SUSB_EP3_MSG                                         0x0008
#define SUSB_EP4_MSG                                         0x0010
#define SUSB_EP5_MSG                                         0x0020
#define SUSB_EP6_MSG                                         0x0040
#define SUSB_EP7_MSG                                         0x0080
#define SUSB_RST_MSG                                         0x0100
#define SUSB_SOF_MSG                                         0x0200
#define SUSB_CFG_MSG                                         0x0400 /* send these flags to external processor */
#define SUSB_SUS_MSG                                         0x0800
#define SUSB_VBUS_MSG                                        0x8000
#define SUSB_ID_MSG                                          0x4000

/* ----- Commands To Host (HPI Only) ----- (use -0x00xx - 0x0Fxx) where top byte is Port Num) */
/* NDX new bit map for Host in both register 0x144 and 0x148 */
#define HUSB_TDListDone                                      0x1000 /*TDListDone message */

/* Sharing bits */
#define HUSB_SOF                                             0x2000 /*SOF message */
#define HUSB_ARMV                                            0x0001 /*Device Remove message */
#define HUSB_AINS_FS                                         0x0002 /*Full Speed Device Insert message */
#define HUSB_AINS_LS                                         0x0004 /*Low Speed Device Insert message */
#define HUSB_AWakeUp                                         0x0008 /*WakeUp message */
#define HUSB_BRMV                                            0x0010 /*Device Remove message */
#define HUSB_BINS_FS                                         0x0020 /*Full Speed Device Insert message */
#define HUSB_BINS_LS                                         0x0040 /*Low Speed Device Insert message */
#define HUSB_BWakeUp                                         0x0080 /*WakeUp message */


/************************************************************ */
/* Lyberty Data Pointers for Common Data Area */
/************************************************************ */
/* SBN: Jan/27/03 update for new LCP code */

#define _start_of_comm                                       0x019A
#define lcp_table                                            0x019A /* COMM_TRANSPORT */
#define snd_msg                                              0x019C /* common send msg routine */
#define lcp_sema                                             0x019E /* lcp_semaphore */
#define lcp_chain                                            0x01A0 /* chain for lcp idle loop */
#define lcp_rsp                                              0x01A2 /* CommConfig: location 0x1a4-0x1ae are free */


/* -----Memory adress for send the TD list pointer and Semaphore in USB HOST */
/* -----OWNER: NDX.  */
#define HUSB_SIE1_pCurrentTDPtr                              0x01B0 /* Address to SIE1 current TD pointer */
#define HUSB_SIE2_pCurrentTDPtr                              0x01B2 /* Address to SIE2 current TD pointer */
#define HUSB_pEOT                                            0x01B4 /* Address to End Of Transfer  */
#define HUSB_SIE1_pTDListDone_Sem                            0x01B6 /* Address to SIE1 TD List Done semaphore */
#define HUSB_SIE2_pTDListDone_Sem                            0x01B8 /* Address to SIE2 TD List Done semaphore */


/* ===== CMD DATA AREA - UNION for ALL COMMANDS ============   */
/* --- 8 byte HSS/SPI FIFO Data goes in here --- */
#define COMM_PORT_CMD                                        0x01BA
#define COMM_PORT_DATA                                       0x01BC /* Generic Ptr to CMD data in HSS FIFO */

/* -- DATA UNION FOR SIMPLE PORT CMDS -- */
#define COMM_MEM_ADDR                                        0x01BC /* -- For COMM_RD/WR_MEM */
#define COMM_MEM_LEN                                         0x01BE /* -- For COMM_RD/WR_MEM */
#define COMM_LAST_DATA                                       0x01C0 /* -- UNUSED but HSS FiFo can handle this last data */

#define COMM_CTRL_REG_ADDR                                   0x01BC /* -- For COMM_RD/WR_CTRL_REG */
#define COMM_CTRL_REG_DATA                                   0x01BE /* -- For COMM_RD/WR_CTRL_REG */
#define COMM_CTRL_REG_LOGIC                                  0x01C0 /* -- User to AND/OR Reg */
#define REG_WRITE_FLG                                        0x0000
#define REG_AND_FLG                                          0x0001
#define REG_OR_FLG                                           0x0002

#define COMM_BAUD_RATE                                       0x01BC /* -- For COMM_SET_BAUD in scalar units for the given I/F */
#define COMM_TIMEOUT                                         0x01BE /* -- For using Timerout on Sending Response to host. */
#define COMM_CODE_ADDR                                       0x01BC /* -- For COMM_CALL_CODE and COMM_JUMP2CODE */

/* !!! NOTE: For HSS/SPI all of the above are sent in FIFO */
/*           For HPI done with HW Access. */
/* --- Register Buffers for EXEC_INT Commands */
#define COMM_INT_NUM                                         0x01C2 /* -- For COMM_EXEC_INT */
#define COMM_R0                                              0x01C4 /* This data struct must be written via MEM_WRITE commands for HSS and SPI */
#define COMM_R1                                              0x01C6
#define COMM_R2                                              0x01C8
#define COMM_R3                                              0x01CA
#define COMM_R4                                              0x01CC
#define COMM_R5                                              0x01CE
#define COMM_R6                                              0x01D0
#define COMM_R7                                              0x01D2
#define COMM_R8                                              0x01D4
#define COMM_R9                                              0x01D6
#define COMM_R10                                             0x01D8
#define COMM_R11                                             0x01DA
#define COMM_R12                                             0x01DC
#define COMM_R13                                             0x01DE

/*============================================================= */
/* BIOS free memory area: 0x1E0 - 0x1FE */


#endif //#define CY7C67200_CMD_DATA_H
