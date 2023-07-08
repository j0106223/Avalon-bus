#ifndef USB_HAL_H_
#define USB_HAL_H_

int hpi_init(void);

int hpi_read_memory(unsigned short chip_addr, 
                     char * data,
                     int byte_length
                    );
int hpi_write_memory(unsigned short chip_addr, 
                     char * data,
                     int byte_length
                    );

int hpi_read_reg(unsigned short reg_addr,unsigned short *reg_value);
int hpi_write_reg(unsigned short reg_addr,unsigned short reg_value);

unsigned short hpi_read_status(void);

void hpi_write_mbx(unsigned short value);
unsigned short hpi_read_mbx(void);

void hpi_write_word(unsigned short chip_addr,unsigned short value );
unsigned short hpi_read_word(unsigned short chip_addr);
                       
unsigned short get_ushort(char * data, int start_address);

#endif /*USB_HAL_H_*/
