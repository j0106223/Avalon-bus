
/** include files **/

#include "./../terasic_includes.h"
#include "usb_hal.h"


/** local definitions **/
#ifdef DEBUG_CY7C67200_HAL
    #define DEBUG_OUT(format, arg...) {printf("[UHAL]"); printf(format, ## arg);}
    #define DEBUG_ERR(format, arg...) {printf("[UHAL_ERR]");printf(format, ## arg);}
#else
    #define DEBUG_OUT(format, arg...) 
    #define DEBUG_ERR(format, arg...)
#endif   

#define HPI_DATA    0
#define HPI_MAILBOX 1
#define HPI_ADDR    2
#define HPI_STATUS  3

/** default settings **/

/** external functions **/

/** external data **/


/** internal functions **/
static int writeable_region(unsigned short chip_addr, int byte_length);

static void hpi_write_words(unsigned short chip_addr,
                         unsigned short *data,
                         int num_words
                        );
static void hpi_read_words(unsigned short chip_addr,
                        unsigned short *data,
                        int num_words
                        );

/** public data **/

/** private data **/

/** public functions **/


int hpi_init(void)
{

    return SUCCESS;
}


/*
 *  FUNCTION: hpi_read_memory
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *    data            - Data to receive pointer
 *    byte_length     - Length of data to read
 *
 *  DESCRIPTION:
 *    This function reads data from the specified address and length on the ASIC.
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
int hpi_read_memory(unsigned short chip_addr,
                    char * data,
                    int byte_length
                    )
{
    int num_words = 0;
    unsigned short short_int;

    /* Check for unaligned address */
    if ((chip_addr & 0x1) == 0x1) {

        /* Read Word */
        short_int = hpi_read_word(chip_addr - 1);

        /* Save upper byte */
        *data++ = (char) ((unsigned short) short_int >> 0x8);

        /* Update address */
        chip_addr = chip_addr + 1;

        /* Update length */
        byte_length--;
    }

    /* Determine number of words to read */
    num_words = byte_length >> 1;

    /* Check for words to read */
    if (num_words > 0) {

        hpi_read_words(chip_addr, (unsigned short *) data, num_words);

        byte_length -= (2 * num_words);

        chip_addr += (2 * num_words);
    }

    /* Check for a remaining byte to read*/
    if (byte_length > 0) {

        /* Read Word */
        short_int = hpi_read_word(chip_addr);

        /* Save lower byte */
        *(data + 2*num_words) = (char) ((unsigned short) short_int >> 0x0);

        /* Update length */
        byte_length--;
    }

    /* Consistancy check */
    if (byte_length != 0) {
        DEBUG_ERR("hpi_read_memory: Internal error\r\n");
    }

    return(SUCCESS);
}

/*
 *  FUNCTION: hpi_write_memory
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *    data            - Data to write pointer
 *    byte_length     - Length of data to write
 *
 *  DESCRIPTION:
 *    This function writes data to the specfied address and length on the ASIC.
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
int hpi_write_memory(unsigned short chip_addr, 
                     char * data,
                     int byte_length
                    )
{
    int response = ERROR;
    int num_words = 0;
    unsigned short short_int;
    unsigned short tmp_short_int;

      DEBUG_OUT("hpi_write_memory.- chip_addr = 0x%x, byte_length = 0x%x\r\n", chip_addr, byte_length);


    /* Check if the memory region is writable or not */

    if (writeable_region(chip_addr, byte_length) == SUCCESS) {

        /* Check for unaligned address */
        if ((chip_addr & 0x1) == 0x1) {

            /* Read Word */
            short_int = hpi_read_word(chip_addr - 1);

            /* Modify upper byte */
            tmp_short_int = (unsigned short) (0x00FF & *data++);
            short_int = ((0x00FF & short_int) | (tmp_short_int << 8));

            /* Write Word */
            hpi_write_word((chip_addr - 1), short_int);

            /* Update address */
            chip_addr = chip_addr + 1;

            /* Update length */
            byte_length--;
        }

        /* Determine number of words to write */
        num_words = (int) byte_length/2;

        /* Check for words to write */
        if (num_words > 0) {
            hpi_write_words(chip_addr, (unsigned short *) data, num_words);

            byte_length -= (2 * num_words);

            chip_addr += (2 * num_words);

            data += (2 * num_words);
        }

        /* Check for a remaining byte to read*/
        if (byte_length > 0) {

            /* Read Word */
            short_int = hpi_read_word(chip_addr); 

            /* Modify lower byte */
            tmp_short_int = (unsigned short) (0x00FF & *data++);
            short_int = ((0xFF00 & short_int) | tmp_short_int);

            /* Write Word */
            hpi_write_word(chip_addr, short_int);

            /* Update length */
            byte_length--;
        }

        /* Consistancy check */
        if (byte_length != 0) {
            DEBUG_ERR("hpi_write_memory: Internal error\r\n");
        }

        response = SUCCESS;
    }
    else
        DEBUG_ERR("hpi_write_memory: this memory region is not writable\r\n");

    return(response);
}


/*
 *  FUNCTION: hpi_read_reg
 *
 *  PARAMETERS:
 *    reg_addr        - Offset Register Address of the ASIC
 *    reg_value       - Register Value pointer
 *
 *  DESCRIPTION:
 *    This function reads data from the specified register address
 *    on the ASIC.
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
int hpi_read_reg(unsigned short reg_addr,
                 unsigned short *reg_value
                )
{

    /* Hardware Specific Code to Write to Lyberty via HPI Port */
    *reg_value = hpi_read_word(reg_addr);

    return (SUCCESS);
}

/*
 *  FUNCTION: hpi_write_reg
 *
 *  PARAMETERS:
 *    reg_addr        - Offset Register Address of the ASIC
 *    reg_value       - Register Value
 *
 *  DESCRIPTION:
 *    This function writes data to the specified register address
 *    on the ASIC.
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
int hpi_write_reg(unsigned short reg_addr,
                  unsigned short reg_value)
{

    hpi_write_word(reg_addr, reg_value);

    return (SUCCESS);
}

/*
 *  FUNCTION: hpi_read_status
 *
 *  PARAMETERS:
 *
 *  DESCRIPTION:
 *    This function reads from the hpi status register
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
unsigned short hpi_read_status(void)
{
    unsigned short value;
    
    value = IORD(HPI_NIOSII_BASE_ADDR,HPI_STATUS);

    DEBUG_OUT("read_status: value = 0x%04x\r\n", value);

    return value;
}


/*
 *  FUNCTION: hpi_write_mbx
 *
 *  PARAMETERS:
 *    value           - Length
 *  DESCRIPTION:
 *    This function writes to the hpi mailbox
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
void hpi_write_mbx(unsigned short value)
{
    DEBUG_OUT("write_mbx: 0x%04x\r\n", value);

    IOWR(HPI_NIOSII_BASE_ADDR,HPI_MAILBOX,value);
}


/*
 *  FUNCTION: hpi_read_mbx
 *
 *  PARAMETERS:
 *
 *  DESCRIPTION:
 *    This function reads from hpi mailbox
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
unsigned short hpi_read_mbx(void)
{
    unsigned short value;
 
    value =  IORD(HPI_NIOSII_BASE_ADDR,HPI_MAILBOX);

    DEBUG_OUT("read_mbx: 0x%04x\r\n", value);

    return value;
}


/*
 *  FUNCTION: hpi_write_word
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *    value           - Value to write
 *
 *  DESCRIPTION:
 *    This function writes to hpi
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
void hpi_write_word(unsigned short chip_addr,
                        unsigned short value
                        )
{
    DEBUG_OUT("write_word: addr=0x%04x, value=0x%04x\r\n", chip_addr, value);
    IOWR(HPI_NIOSII_BASE_ADDR,HPI_ADDR, chip_addr);
    IOWR(HPI_NIOSII_BASE_ADDR, HPI_DATA, value);
}





/*
 *  FUNCTION: hpi_read_word
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *
 *  DESCRIPTION:
 *    This function reads from hpi
 *
 *  RETURNS: 
 *    Value of the chip_addr
 */
unsigned short hpi_read_word(unsigned short chip_addr)
{
    unsigned short value;
    IOWR( HPI_NIOSII_BASE_ADDR,HPI_ADDR, chip_addr);
    value = IORD( HPI_NIOSII_BASE_ADDR,HPI_DATA) ;
    DEBUG_OUT("read_word: addr=0x%04x, value=0x%04x\r\n", chip_addr, value);
    return value;
}



/*
 *  FUNCTION: hpi_write_words
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *    data            - data pointer
 *    num_words       - Length
 *
 *  DESCRIPTION:
 *    This function writes words to hpi
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
void hpi_write_words(unsigned short chip_addr,
                         unsigned short *data,
                         int num_words
                        )
{
    int i;

    IOWR( HPI_NIOSII_BASE_ADDR,HPI_ADDR, chip_addr);

    DEBUG_OUT("write_words addr:0x%04x, num_words:%d", chip_addr, num_words);

    for (i=0; i<num_words; i++) 
    {
        DEBUG_OUT(" 0x%04x", *data);
        IOWR (HPI_NIOSII_BASE_ADDR, HPI_DATA    ,*data++);
    }
}

/*
 *  FUNCTION: hpi_read_words
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *    data            - data pointer
 *    num_words       - Length
 *
 *  DESCRIPTION:
 *    This function reads words from hpi
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
void hpi_read_words(unsigned short chip_addr,
                        unsigned short *data,
                        int num_words
                        )
{
    int i;

    IOWR( HPI_NIOSII_BASE_ADDR,HPI_ADDR, chip_addr);

    DEBUG_OUT("read_words addr:0x%04x, num_words:%d", chip_addr, num_words);

    for (i=0; i<num_words; i++) 
    {
        *data++ = IORD (HPI_NIOSII_BASE_ADDR,HPI_DATA  );
        DEBUG_OUT("    0x%04x", *(data-1));
    }
}

/** private functions **/


/*
 *  FUNCTION: get_ushort
 *
 *  PARAMETERS:
 *    data            - Data
 *    start_address   - Start address in data to convert
 *
 *  DESCRIPTION:
 *    This function builds an unsigned short from the data
 *    provided.
 *
 *  RETURNS: 
 *    An unsigned short.
 */

unsigned short get_ushort(char * data, int start_address)
{
    unsigned short value = 0;

    value = (((unsigned short)(*(unsigned char*)(data + start_address + 1)) << 8) |
              (unsigned short)(*(unsigned char*)(data + start_address)));

    return value;
}

/*
 *  FUNCTION: writeable_region
 *
 *  PARAMETERS:
 *    chip_addr       - Offset Address of the ASIC
 *    byte_length     - Length
 *
 *  DESCRIPTION:
 *    This function determines if the address and length falls within
 *    a valid "writeable" region.
 *
 *  RETURNS: 
 *    SUCCESS         - Success
 *    ERROR           - Failure
 */
int writeable_region(unsigned short chip_addr,
                         int byte_length)
{
    int response = ERROR;

    /* Check that address is in a valid writable range */
    if (((int)chip_addr + byte_length) <= 0xFFFF)
        response = SUCCESS;

    return response;
}

