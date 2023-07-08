#ifndef USB_DEVICE_H_
#define USB_DEVICE_H_

#include "./../terasic_includes.h"


typedef struct _device_status{
        unsigned short hpi_status; // flag for hpi interrupt status register
        bool    bEP1InTransfer;     // FALSE : no transaction 
        bool    bEP2InTransfer;
        bool    bEP1_Transfer_Judge;// for timeout judge
        alt_u32 EP1_Transfer_Timeout;
}DEVICE_STATUS;


typedef struct
{
        alt_u16 wNextLink;
        alt_u16 wAddress;
        alt_u16 wLength;
        alt_u16 wCallBack;
}TRANSFER_FRAME;


#define EP1_TRANSFER_STRUCT_ADDRESS 0x1000
#define EP2_TRANSFER_STRUCT_ADDRESS 0x2000

#define EP1_SEND_BUF_ADDRESS 0x1100
#define EP2_RECEIVE_BUF_ADDRESS 0x2100

#define EP1_DATA_DEFAULT_LEN 8
#define EP2_DATA_DEFAULT_LEN 64

void dc_init_struct(void);

void dc_clear_bug(void);

int dc_download(char * download_data,int max_try);

int dc_download_code(unsigned short chip_addr,
                      int byte_length,
                      char * data
                      );

//int lcp_command(DEVICE_INFO * pdc);
int hpi_command( unsigned short cmd);

int usb_send_data(
                  unsigned short endpoint,
                  unsigned short send_buffer_location,
                  unsigned char * data,  // 
                  int byte_length
                  );
                  
int usb_enable_receive_data(
                  unsigned short endpoint,
                  unsigned short receive_buffer_location,
                  int byte_length
                  );



#endif /*USB_DEVICE_H_*/
