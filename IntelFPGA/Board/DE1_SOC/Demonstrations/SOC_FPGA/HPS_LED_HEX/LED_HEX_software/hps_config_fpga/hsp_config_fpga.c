// this  file  just test to config the fpga  
#include <stdio.h>
#include <sys/mman.h>
#include "alt_fpga_manager_terasic.h"
#include <stdbool.h>
#include <fcntl.h>
#include "socal/socal.h"
#include "socal/hps.h"
#include "socal/alt_fpgamgr.h"
#include <stdbool.h>
#define dprintf(...)
// #define dprintf(fmt, ...) printf(fmt, ##__VA_ARGS__)


// This is the timeout used when waiting for a state change in the FPGA monitor.
#define _ALT_FPGA_TMO_STATE     2048

// This is the timeout used when waiting for the DCLK countdown to complete.
// The time to wait a constant + DCLK * multiplier.
#define _ALT_FPGA_TMO_DCLK_CONST 2048
#define _ALT_FPGA_TMO_DCLK_MUL   2

#define _ALT_FPGA_TMO_CONFIG     8192

// This define is used to control whether to use the Configuration with DCLK steps
#ifndef _ALT_FPGA_USE_DCLK
#define _ALT_FPGA_USE_DCLK 0
#endif


/////

// This is used in the FGPA reconfiguration streaming interface. Because FPGA
// images are commonly stored on disk, the chunk size is that of the disk size.
// We cannot choose too large a chunk size because the stack size is fairly
// small.
#define DISK_SECTOR_SIZE    512
#define ISTREAM_CHUNK_SIZE  DISK_SECTOR_SIZE
#define HW_REGS_BASE ( ALT_STM_OFST )
#define HW_REGS_SPAN ( 0x04000000 )
#define HW_REGS_MASK ( HW_REGS_SPAN - 1 )


static volatile unsigned long *fpga_mng_stat=NULL;
static volatile unsigned long *fpga_mng_crtl=NULL;
static volatile unsigned long *fpga_mng_dclkcnt=NULL;
static volatile unsigned long *fpga_mng_dclkstat=NULL;
static volatile unsigned long *fpga_mng_gpo=NULL;
static volatile unsigned long *fpga_mng_gpi=NULL;
static volatile unsigned long *fpga_mng_data=NULL;
static volatile unsigned long *fpga_mng_non_gpio_porta_eoi=NULL;
static volatile unsigned long *fpga_mng_non_gpio_ext_porta=NULL;

// Internal struct and callback function which uses the streaming API to handle
// a single large buffer.
//

ALT_STATUS_CODE alt_fpga_control_enable(void);
ALT_STATUS_CODE alt_fpga_control_disable(void);
bool alt_fpga_control_is_enabled(void);
ALT_FPGA_STATE_t alt_fpga_state_get(void);
uint32_t alt_fpga_mon_status_get(void);
ALT_STATUS_CODE alt_fgpa_reset_assert(void);
ALT_STATUS_CODE alt_fgpa_reset_deassert(void);
ALT_FPGA_CFG_MODE_t alt_fpga_cfg_mode_get(void);
ALT_STATUS_CODE alt_fpga_cfg_mode_set(ALT_FPGA_CFG_MODE_t cfg_mode);
ALT_STATUS_CODE alt_fpga_configure(const void* cfg_buf, size_t cfg_buf_len);
ALT_STATUS_CODE alt_fpga_istream_configure(alt_fpga_istream_t cfg_stream,void * user_data);
uint32_t alt_fpga_gpi_read(uint32_t mask);
ALT_STATUS_CODE alt_fpga_gpo_write(uint32_t mask, uint32_t value);
				   
typedef struct ISTREAM_DATA_s
{
    uintptr_t buffer;
    size_t    length;
} ISTREAM_DATA_t;

static int32_t istream_callback(void * buf, size_t buf_len, void * context)
{
    ISTREAM_DATA_t * data = (ISTREAM_DATA_t *) context;

    // Find the minimum for buf_len and data->length
    int32_t copy_size = buf_len < data->length ? buf_len : data->length;

    // If the copy_size is positive, there is still data to be copied into the
    // istream buffer provided. Do that copy and take care of some book
    // keeping.
    if (copy_size)
    {
        memcpy(buf, (const void *) data->buffer, copy_size);
        data->buffer += copy_size;
        data->length -= copy_size;
    }

    return copy_size;
}

//
// Helper function which sets the DCLKCNT, waits for DCLKSTAT to report the
// count completed, and clear the complete status.
// Returns:
//  - ALT_E_SUCCESS if the FPGA DCLKSTAT reports that the DCLK count is done.
//  - ALT_E_TMO     if the number of polling cycles exceeds the timeout value.
//
static ALT_STATUS_CODE dclk_set_and_wait_clear(uint32_t count, uint32_t timeout)
{
    ALT_STATUS_CODE status = ALT_E_TMO;

    // Clear any existing DONE status. This can happen if a previous call to
    // this function returned timeout. The counter would complete later on but
    // never be cleared.
    if (alt_read_word(fpga_mng_dclkstat))
    {
        alt_write_word(fpga_mng_dclkstat, ALT_FPGAMGR_DCLKSTAT_DCNTDONE_E_DONE);
    }

    // Issue the DCLK count.
    alt_write_word(fpga_mng_dclkcnt, count);

    // Poll DCLKSTAT to see if it completed in the timeout period specified.
    do
    {
        dprintf(".");

        uint32_t done = alt_read_word(fpga_mng_dclkstat);

        if (done == ALT_FPGAMGR_DCLKSTAT_DCNTDONE_E_DONE)
        {
            // Now that it is done, clear the DONE status.
            alt_write_word(fpga_mng_dclkstat, ALT_FPGAMGR_DCLKSTAT_DCNTDONE_E_DONE);

            status = ALT_E_SUCCESS;
            break;
        }
    }
    while (timeout--);
    dprintf("\n");
    return status;
}

//
// Helper function which waits for the FPGA to enter the specified state.
// Returns:
//  - ALT_E_SUCCESS if successful
//  - ALT_E_TMO     if the number of polling cycles exceeds the timeout value.
//
static ALT_STATUS_CODE wait_for_fpga_state(ALT_FPGA_STATE_t state, uint32_t timeout)
{
    ALT_STATUS_CODE status = ALT_E_TMO;

    // Poll on the state to see if it matches the requested state within the
    // timeout period specified.
    do
    {
        dprintf(".");
        ALT_FPGA_STATE_t current = alt_fpga_state_get();
        if (current == state)
        {
            status = ALT_E_SUCCESS;
            break;
        }
    }
    while (timeout--);

    dprintf("\n");

    return status;
}

//
// Waits for the FPGA CB monitor to report the FPGA configuration status by
// polling that both CONF_DONE and nSTATUS or neither flags are set.
//
// Returns:
//  - ALT_E_SUCCESS  if CB monitor reports configuration successful.
//  - ALT_E_FPGA_CFG if CB monitor reports configuration failure.
//  - ALT_E_FPGA_CRC if CB monitor reports a CRC error.
//  - ALT_E_TMO      if CONF_DONE and nSTATUS fails to "settle" in the number
//                   of polling cycles specified by the timeout value.
//
static ALT_STATUS_CODE wait_for_config_done(uint32_t timeout)
{
    ALT_STATUS_CODE retval = ALT_E_TMO;

    // Poll on the CONF_DONE and nSTATUS both being set within the timeout
    // period specified.
    do
    {
        dprintf(".");

        uint32_t status = alt_fpga_mon_status_get();

        // Detect CRC problems with the FGPA configuration
        if (status & ALT_FPGA_MON_CRC_ERROR)
        {
            retval = ALT_E_FPGA_CRC;
            break;
        }

        bool conf_done = (status & ALT_FPGA_MON_CONF_DONE) != 0;
        bool nstatus   = (status & ALT_FPGA_MON_nSTATUS)   != 0;

        if (conf_done == nstatus)
        {
            if (conf_done)
            {
                retval = ALT_E_SUCCESS;
            }
            else
            {
                retval = ALT_E_FPGA_CFG;
            }
            break;
        }
    }
    while (timeout--);
    dprintf("\n");
    return retval;
}

/////

ALT_STATUS_CODE alt_fpga_control_enable(void)
{
    // Simply set CTRL.EN to allow HPS to control the FPGA control block.
    alt_setbits_word(fpga_mng_crtl, ALT_FPGAMGR_CTL_EN_SET_MSK);
    return ALT_E_SUCCESS;
}

ALT_STATUS_CODE alt_fpga_control_disable(void)
{
    // Simply clear CTRL.EN to allow HPS to control the FPGA control block.
    alt_clrbits_word(fpga_mng_crtl, ALT_FPGAMGR_CTL_EN_SET_MSK);

    return ALT_E_SUCCESS;
}

bool alt_fpga_control_is_enabled(void)
{
    // Check if CTRL.EN is set or not.
    if ((alt_read_word(fpga_mng_crtl) & ALT_FPGAMGR_CTL_EN_SET_MSK) != 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}
uint32_t alt_fpga_mon_status_get(void)
{
    return alt_read_word(fpga_mng_non_gpio_ext_porta) & ((1 << 12) - 1);
}

ALT_FPGA_STATE_t alt_fpga_state_get(void)
{
    // Detect FPGA power status.
    // NOTE: Do not use alt_fpga_state_get() to look for ALT_FPGA_STATE_PWR_OFF.
    //   This is a bit of a misnomer in that the ALT_FPGA_STATE_PWR_OFF really means
    //   FPGA is powered off or idle (which happens just out of being reset by the
    //   reset manager).
    if ((alt_fpga_mon_status_get() & ALT_FPGA_MON_FPGA_POWER_ON) == 0)
    {
        return ALT_FPGA_STATE_POWER_OFF;
    }
    // The fpgamgrreg::stat::mode bits maps to the FPGA state enum.
    return (ALT_FPGA_STATE_t) ALT_FPGAMGR_STAT_MOD_GET(alt_read_word(fpga_mng_stat));
}


ALT_STATUS_CODE alt_fgpa_reset_assert(void)
{
    // Verify that HPS has control of the FPGA control block.
    if (alt_fpga_control_is_enabled() != true)
    {
        return ALT_E_FPGA_NO_SOC_CTRL;
    }

    // Detect FPGA power status.
    if (alt_fpga_state_get() == ALT_FPGA_STATE_POWER_OFF)
    {
        return ALT_E_FPGA_PWR_OFF;
    }

    // Set the nCONFIGPULL to put the FPGA into reset.
    alt_setbits_word(fpga_mng_crtl, ALT_FPGAMGR_CTL_NCFGPULL_SET_MSK);

    return ALT_E_SUCCESS;
}

ALT_STATUS_CODE alt_fgpa_reset_deassert(void)
{
    // Verify that HPS has control of the FPGA control block.
    if (alt_fpga_control_is_enabled() != true)
    {
        return ALT_E_FPGA_NO_SOC_CTRL;
    }

    // Detect FPGA power status.
    if (alt_fpga_state_get() == ALT_FPGA_STATE_POWER_OFF)
    {
        return ALT_E_FPGA_PWR_OFF;
    }
    // Clear the nCONFIGPULL to release the FPGA from reset.
    alt_clrbits_word(fpga_mng_crtl, ALT_FPGAMGR_CTL_NCFGPULL_SET_MSK);
    return ALT_E_SUCCESS;
}

ALT_FPGA_CFG_MODE_t alt_fpga_cfg_mode_get(void)
{
    uint32_t msel = ALT_FPGAMGR_STAT_MSEL_GET(alt_read_word(fpga_mng_stat));
    switch (msel)
    {
    case ALT_FPGAMGR_STAT_MSEL_E_PP16_FAST_NOAES_NODC: // SoCAL: 0x0
    case ALT_FPGAMGR_STAT_MSEL_E_PP16_FAST_AES_NODC:   // SoCAL: 0x1
    case ALT_FPGAMGR_STAT_MSEL_E_PP16_FAST_AESOPT_DC:  // SoCAL: 0x2
    case ALT_FPGAMGR_STAT_MSEL_E_PP16_SLOW_NOAES_NODC: // SoCAL: 0x4
    case ALT_FPGAMGR_STAT_MSEL_E_PP16_SLOW_AES_NODC:   // SoCAL: 0x5
    case ALT_FPGAMGR_STAT_MSEL_E_PP16_SLOW_AESOPT_DC:  // SoCAL: 0x6
    case ALT_FPGAMGR_STAT_MSEL_E_PP32_FAST_NOAES_NODC: // SoCAL: 0x8
    case ALT_FPGAMGR_STAT_MSEL_E_PP32_FAST_AES_NODC:   // SoCAL: 0x9
    case ALT_FPGAMGR_STAT_MSEL_E_PP32_FAST_AESOPT_DC:  // SoCAL: 0xa
    case ALT_FPGAMGR_STAT_MSEL_E_PP32_SLOW_NOAES_NODC: // SoCAL: 0xc
    case ALT_FPGAMGR_STAT_MSEL_E_PP32_SLOW_AES_NODC:   // SoCAL: 0xd
    case ALT_FPGAMGR_STAT_MSEL_E_PP32_SLOW_AESOPT_DC:  // SoCAL: 0xe
        // The definitions for the various msel's match up with the hardware
        // definitions, so just cast it to the enum type.
        return (ALT_FPGA_CFG_MODE_t) msel;
    default:
        return ALT_FPGA_CFG_MODE_UNKNOWN;
    }
}

ALT_STATUS_CODE alt_fpga_cfg_mode_set(ALT_FPGA_CFG_MODE_t cfg_mode)
{
    // This function will always return ERROR. See header for reasons.
    return ALT_E_ERROR;
}

ALT_STATUS_CODE alt_fpga_configure(const void* cfg_buf, 
                                   size_t cfg_buf_len)
{
    // Use the istream_callback to convert a full buffer configure into an
    // istream configure.
    ISTREAM_DATA_t data;
    data.buffer = (uintptr_t) cfg_buf;
    data.length = cfg_buf_len;
    return alt_fpga_istream_configure(istream_callback, &data);
}

//
// This function handles writing data to the FPGA data register and ensuring
// the image was programmed correctly.
//
static ALT_STATUS_CODE alt_fpga_istream_configure_idata(alt_fpga_istream_t cfg_stream,
                                                        void * user_data)
{
    ALT_STATUS_CODE status;

    // Step 9:
    //  - Write configuration image to AXI DATA register in 4 byte chunks.

    dprintf("FPGA: === Step 9 ===\n");

    char buffer[ISTREAM_CHUNK_SIZE];
    int32_t cb_status = 0; // Callback status

    do
    {
        cb_status = cfg_stream(buffer, sizeof(buffer), user_data);

        if (cb_status > 0)
        {
            uint32_t cfg_buf_len = cb_status;
            size_t i = 0;

            // Write out as many complete 32-bit chunks.
            uint32_t * buffer_32 = (uint32_t *) buffer;
            while (cfg_buf_len >= sizeof(uint32_t))
            {
                alt_write_word(fpga_mng_data, buffer_32[i++]);
                cfg_buf_len -= sizeof(uint32_t);
            }

            // Write out remaining non 32-bit chunks.
            switch (cfg_buf_len)
            {
            case 3:
                alt_write_word(fpga_mng_data, buffer_32[i++] & 0x00ffffff);
                break;
            case 2:
                alt_write_word(fpga_mng_data, buffer_32[i++] & 0x0000ffff);
                break;
            case 1:
                alt_write_word(fpga_mng_data, buffer_32[i++] & 0x000000ff);
                break;
            default:
                // This will never happen.
                break;
            }
        }

    } while (cb_status > 0);

    if (cb_status < 0)
    {
        // A problem occurred when streaming data from the source.
        dprintf("FPGA: Error in step 9: Problem streaming from FPGA image source.\n");
        return ALT_E_FPGA_CFG_STM;
    }

    // Step 10:
    //  - Observe CONF_DONE and nSTATUS (active low)
    //  - if CONF_DONE = 1 and nSTATUS = 1, configuration was successful
    //  - if CONF_DONE = 0 and nSTATUS = 0, configuration failed

    dprintf("FPGA: === Step 10 ===\n");

    status = wait_for_config_done(_ALT_FPGA_TMO_CONFIG);

    if (status == ALT_E_TMO)
    {
        dprintf("FPGA: Error in step 10: Timeout waiting for CONF_DONE + nSTATUS.\n");
        return ALT_E_FPGA_CFG;
    }
    if (status == ALT_E_FPGA_CRC)
    {
        dprintf("FPGA: Error in step 10: CRC error detected.\n");
        return ALT_E_FPGA_CRC;
    }
    if (status != ALT_E_SUCCESS)
    {
        dprintf("FPGA: Error in step 10: Configuration error CONF_DONE, nSTATUS = 0.\n");
        return ALT_E_FPGA_CFG;
    }
    return ALT_E_SUCCESS;
}

ALT_STATUS_CODE alt_fpga_istream_configure(alt_fpga_istream_t cfg_stream,
                                           void * user_data)
{
    // Verify preconditions.
    // This is a minor difference from the configure instructions given by the NPP.

    // Verify that HPS has control of the FPGA control block.
    if (alt_fpga_control_is_enabled() != true)
    {
        return ALT_E_FPGA_NO_SOC_CTRL;
    }

    // Detect FPGA power status.
    if (alt_fpga_state_get() == ALT_FPGA_STATE_POWER_OFF)
    {
        return ALT_E_FPGA_PWR_OFF;
    }

    /////

    ALT_STATUS_CODE status = ALT_E_SUCCESS;

    dprintf("FPGA: Configure() !!!\n");

    // The FPGA CTRL register cache
    uint32_t ctrl_reg;

    ctrl_reg = alt_read_word(fpga_mng_crtl);

    // Step 1:
    //  - Set CTRL.CFGWDTH, CTRL.CDRATIO to match cfg mode
    //  - Set CTRL.NCE to 0

    dprintf("FPGA: === Step 1 ===\n");

    int cfgwidth = 0;
    int cdratio  = 0;

    switch (alt_fpga_cfg_mode_get())
    {
    case ALT_FPGA_CFG_MODE_PP16_FAST_NOAES_NODC:
        cfgwidth = 16;
        cdratio  = 1;
        break;
    case ALT_FPGA_CFG_MODE_PP16_FAST_AES_NODC:
        cfgwidth = 16;
        cdratio  = 4;
        break;
    case ALT_FPGA_CFG_MODE_PP16_FAST_AESOPT_DC:
        cfgwidth = 16;
        cdratio  = 8;
        break;
    case ALT_FPGA_CFG_MODE_PP16_SLOW_NOAES_NODC:
        cfgwidth = 16;
        cdratio  = 1;
        break;
    case ALT_FPGA_CFG_MODE_PP16_SLOW_AES_NODC:
        cfgwidth = 16;
        cdratio  = 4;
        break;
    case ALT_FPGA_CFG_MODE_PP16_SLOW_AESOPT_DC:
        cfgwidth = 16;
        cdratio  = 8;
        break;
    case ALT_FPGA_CFG_MODE_PP32_FAST_NOAES_NODC:
        cfgwidth = 32;
        cdratio  = 1;
        break;
    case ALT_FPGA_CFG_MODE_PP32_FAST_AES_NODC:
        cfgwidth = 32;
        cdratio  = 4;
        break;
    case ALT_FPGA_CFG_MODE_PP32_FAST_AESOPT_DC:
        cfgwidth = 32;
        cdratio  = 8;
        break;
    case ALT_FPGA_CFG_MODE_PP32_SLOW_NOAES_NODC:
        cfgwidth = 32;
        cdratio  = 1;
        break;
    case ALT_FPGA_CFG_MODE_PP32_SLOW_AES_NODC:
        cfgwidth = 32;
        cdratio  = 4;
        break;
    case ALT_FPGA_CFG_MODE_PP32_SLOW_AESOPT_DC:
        cfgwidth = 32;
        cdratio  = 8;
        break;
    default:
        return ALT_E_ERROR;
    }

    dprintf("FPGA: CDRATIO  = %x\n", cdratio);
    dprintf("FPGA: CFGWIDTH = %s\n", cfgwidth == 16 ? "16" : "32");

    // Adjust CTRL for the CDRATIO
    ctrl_reg &= ALT_FPGAMGR_CTL_CDRATIO_CLR_MSK;
    switch (cdratio)
    {
    case 1:
        ctrl_reg |= ALT_FPGAMGR_CTL_CDRATIO_SET(ALT_FPGAMGR_CTL_CDRATIO_E_X1);
        break;
    case 2: // Unused; included for completeness.
        ctrl_reg |= ALT_FPGAMGR_CTL_CDRATIO_SET(ALT_FPGAMGR_CTL_CDRATIO_E_X2);
        break;
    case 4:
        ctrl_reg |= ALT_FPGAMGR_CTL_CDRATIO_SET(ALT_FPGAMGR_CTL_CDRATIO_E_X4);
        break;
    case 8:
        ctrl_reg |= ALT_FPGAMGR_CTL_CDRATIO_SET(ALT_FPGAMGR_CTL_CDRATIO_E_X8);
        break;
    default:
        return ALT_E_ERROR;
    }

    // Adjust CTRL for CFGWIDTH
    switch (cfgwidth)
    {
    case 16:
        ctrl_reg &= ALT_FPGAMGR_CTL_CFGWDTH_CLR_MSK;
        break;
    case 32:
        ctrl_reg |= ALT_FPGAMGR_CTL_CFGWDTH_SET_MSK;
        break;
    default:
        return ALT_E_ERROR;
    }

    // Set NCE to 0.
    ctrl_reg &= ALT_FPGAMGR_CTL_NCE_CLR_MSK;

    alt_write_word(fpga_mng_crtl, ctrl_reg);

    // Step 2:
    //  - Set CTRL.EN to 1

    dprintf("FPGA: === Step 2 (skipped due to precondition) ===\n");

    // Step 3:
    //  - Set CTRL.NCONFIGPULL to 1 to put FPGA in reset

    dprintf("FPGA: === Step 3 ===\n");

    ctrl_reg |= ALT_FPGAMGR_CTL_NCFGPULL_SET_MSK;
    alt_write_word(fpga_mng_crtl, ctrl_reg);

    // Step 4:
    //  - Wait for STATUS.MODE to report FPGA is in reset phase

    dprintf("FPGA: === Step 4 ===\n");

    status = wait_for_fpga_state(ALT_FPGA_STATE_RESET, _ALT_FPGA_TMO_STATE);
    // Handle any error conditions after reset has been unasserted.

    // Step 5:
    //  - Set CONTROL.NCONFIGPULL to 0 to release FPGA from reset

    dprintf("FPGA: === Step 5 ===\n");

    ctrl_reg &= ALT_FPGAMGR_CTL_NCFGPULL_CLR_MSK;
    alt_write_word(fpga_mng_crtl, ctrl_reg);

    if (status != ALT_E_SUCCESS)
    {
        // This is a failure from Step 4.
        dprintf("FPGA: Error in step 4: Wait for RESET timeout.\n");
        return ALT_E_FPGA_CFG;
    }

    // Step 6:
    //  - Wait for STATUS.MODE to report FPGA is in configuration phase

    dprintf("FPGA: === Step 6 ===\n");

    status = wait_for_fpga_state(ALT_FPGA_STATE_CFG, _ALT_FPGA_TMO_STATE);

    if (status != ALT_E_SUCCESS)
    {
        dprintf("FPGA: Error in step 6: Wait for CFG timeout.\n");
        return ALT_E_FPGA_CFG;
    }

    // Step 7:
    //  - Clear nSTATUS interrupt in CB Monitor

    dprintf("FPGA: === Step 7 ===\n");

    alt_write_word(fpga_mng_non_gpio_porta_eoi,
                   ALT_MON_GPIO_PORTA_EOI_NS_SET(ALT_MON_GPIO_PORTA_EOI_NS_E_CLR));

    // Step 8:
    //  - Set CTRL.AXICFGEN to 1 to enable config data on AXI slave bus

    dprintf("FPGA: === Step 8 ===\n");

    ctrl_reg |= ALT_FPGAMGR_CTL_AXICFGEN_SET_MSK;
    alt_write_word(fpga_mng_crtl, ctrl_reg);

    /////

    //
    // Helper function to handle steps 9 - 10.
    //

    ALT_STATUS_CODE data_status;
    data_status = alt_fpga_istream_configure_idata(cfg_stream, user_data);

    /////

    // Step 11:
    //  - Set CTRL.AXICFGEN to 0 to disable config data on AXI slave bus

    dprintf("FPGA: === Step 11 ===\n");

    ctrl_reg &= ALT_FPGAMGR_CTL_AXICFGEN_CLR_MSK;
    alt_write_word(fpga_mng_crtl, ctrl_reg);

    // Step 12:
    //  - Write 4 to DCLKCNT
    //  - Wait for STATUS.DCNTDONE = 1
    //  - Clear W1C bit in STATUS.DCNTDONE

    dprintf("FPGA: === Step 12 ===\n");

    status = dclk_set_and_wait_clear(4, _ALT_FPGA_TMO_DCLK_CONST + 4 * _ALT_FPGA_TMO_DCLK_MUL);
    if (status != ALT_E_SUCCESS)
    {
        dprintf("FPGA: Error in step 12: Wait for dclk(4) timeout.\n");

        // The error here is probably a result of an error in the FPGA data.
        if (data_status != ALT_E_SUCCESS)
        {
            return data_status;
        }
        else
        {
            return ALT_E_FPGA_CFG;
        }
    }

#if _ALT_FPGA_USE_DCLK

    // Extra steps for Configuration with DCLK for Initialization Phase (4.2.1.2)

    // Step 14 (using 4.2.1.2 steps), 15 (using 4.2.1.2 steps)
    //  - Write 0x5000 to DCLKCNT
    //  - Poll until STATUS.DCNTDONE = 1, write 1 to clear

    dprintf("FPGA: === Step 14 (4.2.1.2) ===\n");
    dprintf("FPGA: === Step 15 (4.2.1.2) ===\n");
    
    status = dclk_set_and_wait_clear(0x5000, _ALT_FPGA_TMO_DCLK_CONST + 0x5000 * _ALT_FPGA_TMO_DCLK_MUL);
    if (status == ALT_E_TMO)
    {
        dprintf("FPGA: Error in step 15 (4.2.1.2): Wait for dclk(0x5000) timeout.\n");

        // The error here is probably a result of an error in the FPGA data.
        if (data_status != ALT_E_SUCCESS)
        {
            return data_status;
        }
        else
        {
            return ALT_E_FPGA_CFG;
        }
    }

#endif

    // Step 13:
    //  - Wait for STATUS.MODE to report USER MODE

    dprintf("FPGA: === Step 13 ===\n");

    status = wait_for_fpga_state(ALT_FPGA_STATE_USER_MODE, _ALT_FPGA_TMO_STATE);
    if (status == ALT_E_TMO)
    {
        dprintf("FPGA: Error in step 13: Wait for state = USER_MODE timeout.\n");

        // The error here is probably a result of an error in the FPGA data.
        if (data_status != ALT_E_SUCCESS)
        {
            return data_status;
        }
        else
        {
            return ALT_E_FPGA_CFG;
        }
    }

    // Step 14:
    //  - Set CTRL.EN to 0
    dprintf("FPGA: === Step 14 (skipped due to precondition) ===\n");
    // Return data_status. status is used for the setup of the FPGA parameters
    // and should be successful. Any errors in programming the FPGA is
    // returned in data_status.
    return data_status;
}

uint32_t alt_fpga_gpi_read(uint32_t mask)
{
    if (mask == 0)
    {
        return 0;
    }

    return alt_read_word(fpga_mng_gpi) & mask;
}

ALT_STATUS_CODE alt_fpga_gpo_write(uint32_t mask, uint32_t value)
{
    if (mask == 0)
    {
        return ALT_E_SUCCESS;
    }
    alt_write_word(fpga_mng_gpo, (alt_read_word(fpga_mng_gpo) & ~mask) | (value & mask));
    return ALT_E_SUCCESS;
}

ALT_STATUS_CODE test_config_full(char *filename)
{
    FILE * fp=NULL;
    char *   fpga_image=NULL;
    char *   fpga_image_temp=NULL;
    uint32_t fpga_image_size,i ;
    // Verify the MSELs are appropriate for the type of image we're using
    ALT_FPGA_CFG_MODE_t mode = alt_fpga_cfg_mode_get();
    switch (mode)
    {
    case ALT_FPGA_CFG_MODE_PP32_FAST_AESOPT_DC:
    case ALT_FPGA_CFG_MODE_PP32_SLOW_AESOPT_DC:
    case ALT_FPGA_CFG_MODE_PP16_FAST_AESOPT_DC:
    case ALT_FPGA_CFG_MODE_PP16_SLOW_AESOPT_DC:
        printf("INFO: MSEL configured correctly for FPGA image.\n");
        break;
    default:
        printf("ERROR: Incompatible MSEL mode set. Cannot continue with FPGA programming.\n");
        return ALT_E_ERROR;
    }  
    // This is the symbol name for the SOF file contents linked in.
     //open the file  read  file name---soc_system_dc.rbf
    if((fp = fopen(filename,"rb"))==NULL)
    {
	printf("soc_system_dc.rbf open %s failed\n");
	return false;
    }
    printf("%s file file open success \n",filename);
    //get file size  fpga_image_size
    fseek(fp,0,SEEK_END);
    fpga_image_size=ftell(fp);
    fseek(fp,0,SEEK_SET);  
    //malloc memory  and  get the file content
    fpga_image=(char *)malloc(fpga_image_size);
    fpga_image_temp=fpga_image;
    for(i=0;i<fpga_image_size;i++)
    {
	*fpga_image_temp=fgetc(fp);
	fpga_image_temp++;
    }		
    // Trace the FPGA image information.
    printf("INFO: FPGA Image binary at %p.\n", fpga_image);
    printf("INFO: FPGA Image size is %u bytes.\n", (unsigned int)fpga_image_size);

    // Try the full configuration a few times.
    const uint32_t full_config_retry = 5;
    for (i = 0; i < full_config_retry; ++i)
    {
        ALT_STATUS_CODE status;
        status = alt_fpga_configure(fpga_image, fpga_image_size);
        if (status == ALT_E_SUCCESS)
        {
            printf("INFO: alt_fpga_configure() successful on the %u of %u retry(s).\n",
                   (unsigned int)(i + 1),
                   (unsigned int)full_config_retry);
	    free(fpga_image);//add to free memory
            return ALT_E_SUCCESS;
        }
    }
    printf("ERROR: FPGA failed to program after %u attempt(s).\n", (unsigned int)full_config_retry);
    return ALT_E_ERROR;
}

int main(int argc, char** argv)
{  
	int fd;
	void *virtual_base;
	ALT_STATUS_CODE status = ALT_E_SUCCESS;
        // map the address space for the LED registers into user space so we can interact with them.
	// we'll actually map in the entire CSR span of the HPS since we want to access various registers within that span
	if(argc!=2)
	{
		printf("please Specify the config source file name \r\n");
		return 3;
	}
	if(access(argv[1],R_OK)!=0)
	{
		printf("can't access config source file %s \r\n",argv[1]);
		printf("please check the file \r\n");
		return 2;
	}	
	if( ( fd = open( "/dev/mem", ( O_RDWR | O_SYNC ) ) ) == -1 ) {
		printf( "ERROR: could not open \"/dev/mem\"...\n" );
		return( 1 );
	}
	virtual_base = mmap( NULL, HW_REGS_SPAN, ( PROT_READ | PROT_WRITE ), MAP_SHARED, fd, HW_REGS_BASE );
	if( virtual_base == MAP_FAILED ) {
		printf( "ERROR: mmap() failed...\n" );
		close( fd );
		return( 1 );
	}
	fpga_mng_stat= virtual_base + ( ( uint32_t )( ALT_FPGAMGR_STAT_ADDR) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_crtl= virtual_base + ( ( uint32_t )( ALT_FPGAMGR_CTL_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_dclkstat= virtual_base + ( ( uint32_t )( ALT_FPGAMGR_DCLKSTAT_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_dclkcnt = virtual_base + ( ( uint32_t )( ALT_FPGAMGR_DCLKCNT_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_gpo= virtual_base + ( ( uint32_t )( ALT_FPGAMGR_GPO_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_gpi= virtual_base + ( ( uint32_t )( ALT_FPGAMGR_GPI_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_data= virtual_base + ( ( uint32_t )( ALT_FPGAMGRDATA_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_non_gpio_porta_eoi= virtual_base + ( ( uint32_t )( ALT_FPGAMGR_MON_GPIO_PORTA_EOI_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );
	fpga_mng_non_gpio_ext_porta= virtual_base + ( ( uint32_t )( ALT_FPGAMGR_MON_GPIO_EXT_PORTA_ADDR ) & ( uint32_t )( HW_REGS_MASK ) );	
	printf("INFO: alt_fpga_control_enable().\n");
	status = alt_fpga_control_enable();
	printf("INFO: alt_fpga_control_enable OK.\n");
	if (status == ALT_E_SUCCESS)
	{
	    printf("alt_fpga_control_enable OK  next config the fpga\n");
            status = test_config_full(argv[1]);
	}
	printf("INFO: alt_fpga_control_disable().\n");
	alt_fpga_control_disable();
	return 0;
}