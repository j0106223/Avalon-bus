
#include "hwlib.h"
#include <stdio.h>

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */


/*!
 * This type definition enumerates the possible states the FPGA can be in at
 * any one time.
 */
typedef enum ALT_FPGA_STATE_e
{
    /*!
     * FPGA in Power Up Phase. This is the state of the FPGA just after
     * powering up.
     *
     * \internal
     * Register documentation calls it "PWR_OFF" which is really a misnomer as
     * the FPGA is powered as evident from alt_fpga_mon_status_get() and
     * looking at the ALT_FPGA_MON_FPGA_POWER_ON bit.
     * \endinternal
     */
    ALT_FPGA_STATE_POWER_UP = 0x0,

    /*!
     * FPGA in Reset Phase. In this phase, the FPGA resets, clears the FPGA
     * configuration RAM bits, tri-states all FPGA user I/O pins, pulls the
     * nSTATUS and CONF_DONE pins low, and determines the configuration mode
     * by reading the value of the MSEL pins.
     */
    ALT_FPGA_STATE_RESET = 0x1,

    /*!
     * FPGA in Configuration Phase. This state represents the phase when the
     * configuration bitstream is loaded into the FPGA fabric. The
     * configuration phase is complete after the FPGA has received all the
     * configuration data.
     */
    ALT_FPGA_STATE_CFG = 0x2,

    /*!
     * FPGA in Initialization Phase. In this state the FPGA prepares to enter
     * User Mode. In Configuration via PCI Express (CVP), this state indicates
     * I/O configuration has completed.
     */
    ALT_FPGA_STATE_INIT = 0x3,

    /*!
     * FPGA in User Mode. In this state, the FPGA performs the function loaded
     * during the configuration phase. The FPGA user I/O are functional as
     * determined at design time.
     */
    ALT_FPGA_STATE_USER_MODE = 0x4,

    /*!
     * FPGA state has not yet been determined. This only occurs briefly after
     * reset.
     */
    ALT_FPGA_STATE_UNKNOWN = 0x5,

    /*!
     * FPGA is powered off.
     *
     * \internal
     * This is a software only state which is determined by
     * alt_fpga_mon_status_get() and looking at the ALT_FPGA_MON_FPGA_POWER_ON
     * bit. The hardware register sourced for ALT_FPGA_STATE_t is only 3 bits
     * wide so this will never occur in hardware.
     * \endinternal
     */
    ALT_FPGA_STATE_POWER_OFF = 0xF

} ALT_FPGA_STATE_t;


/*!
 * This type definition enumerates the monitored status conditions for the FPGA
 * Control Block (CB).
 */
typedef enum ALT_FPGA_MON_STATUS_e
{
    /*!
     * 0 if the FPGA is in Reset Phase or if the FPGA detected an error during
     * the Configuration Phase.
     */
    ALT_FPGA_MON_nSTATUS = 0x0001,

    /*!
     * 0 during the FPGA Reset Phase and 1 when the FPGA Configuration Phase is
     * done.
     */
    ALT_FPGA_MON_CONF_DONE = 0x0002,

    /*!
     * 0 during the FPGA Configuration Phase and 1 when the FPGA Initialization
     * Phase is done.
     */
    ALT_FPGA_MON_INIT_DONE = 0x0004,

    /*!
     * CRC error indicator. A 1 indicates that the FPGA detected a CRC error
     * while in User Mode.
     */
    ALT_FPGA_MON_CRC_ERROR = 0x0008,

    /*!
     * Configuration via PCIe (CVP) Done indicator. A 1 indicates that CVP is
     * done.
     */
    ALT_FPGA_MON_CVP_CONF_DONE = 0x0010,

    /*!
     * Partial Reconfiguration ready indicator. A 1 indicates that the FPGA is
     * ready to receive partial reconfiguration or external scrubbing data.
     */
    ALT_FPGA_MON_PR_READY = 0x0020,

    /*!
     * Partial Reconfiguration error indicator. A 1 indicates that the FPGA
     * detected an error during partial reconfiguration or external scrubbing.
     */
    ALT_FPGA_MON_PR_ERROR = 0x0040,

    /*!
     * Partial Reconfiguration done indicator. A 1 indicates partial
     * reconfiguration or external scrubbing is done.
     */
    ALT_FPGA_MON_PR_DONE = 0x0080,

    /*!
     * Value of the nCONFIG pin. This can be pulled-down by the FPGA in this
     * device or logic external to this device connected to the nCONFIG pin.
     * See the description of the nCONFIG field in this register to understand
     * when the FPGA in this device pulls-down the nCONFIG pin. Logic external
     * to this device pulls-down the nCONFIG pin to put the FPGA into the Reset
     * Phase.
     */
    ALT_FPGA_MON_nCONFIG_PIN = 0x0100,

    /*!
     * Value of the nSTATUS pin. This can be pulled-down by the FPGA in this
     * device or logic external to this device connected to the nSTATUS pin.
     * See the description of the nSTATUS field in this register to understand
     * when the FPGA in this device pulls-down the nSTATUS pin. Logic external
     * to this device pulls-down the nSTATUS pin during Configuration Phase or
     * Initialization Phase if it detected an error.
     */
    ALT_FPGA_MON_nSTATUS_PIN = 0x0200,

    /*!
     * Value of the CONF_DONE pin. This can be pulled-down by the FPGA in this
     * device or logic external to this device connected to the CONF_DONE pin.
     * See the description of the CONF_DONE field in this register to
     * understand when the FPGA in this device pulls-down the CONF_DONE pin.
     * See FPGA documentation to determine how logic external to this device
     * drives CONF_DONE.
     */
    ALT_FPGA_MON_CONF_DONE_PIN = 0x0400,

    /*!
     * FPGA powered on indicator.
     */
    ALT_FPGA_MON_FPGA_POWER_ON = 0x0800,

} ALT_FPGA_MON_STATUS_t;


/*!
 * This type definition enumerates the available modes for configuring the
 * FPGA.
 */
typedef enum ALT_FPGA_CFG_MODE_e
{
    /*!
     * 16-bit Passive Parallel with Fast Power on Reset Delay; No AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x1.
     */
    ALT_FPGA_CFG_MODE_PP16_FAST_NOAES_NODC = 0x0,

    /*!
     * 16-bit Passive Parallel with Fast Power on Reset Delay; With AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x4.
     */
    ALT_FPGA_CFG_MODE_PP16_FAST_AES_NODC = 0x1,

    /*!
     * 16-bit Passive Parallel with Fast Power on Reset Delay; AES Optional;
     * With Data Compression. CDRATIO must be programmed to x8.
     */
    ALT_FPGA_CFG_MODE_PP16_FAST_AESOPT_DC = 0x2,

    /*!
     * 16-bit Passive Parallel with Slow Power on Reset Delay; No AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x1.
     */
    ALT_FPGA_CFG_MODE_PP16_SLOW_NOAES_NODC = 0x4,

    /*!
     * 16-bit Passive Parallel with Slow Power on Reset Delay; With AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x4.
     */
    ALT_FPGA_CFG_MODE_PP16_SLOW_AES_NODC = 0x5,

    /*!
     * 16-bit Passive Parallel with Slow Power on Reset Delay; AES Optional;
     * With Data Compression. CDRATIO must be programmed to x8.
     */
    ALT_FPGA_CFG_MODE_PP16_SLOW_AESOPT_DC = 0x6,

    /*!
     * 32-bit Passive Parallel with Fast Power on Reset Delay; No AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x1.
     */
    ALT_FPGA_CFG_MODE_PP32_FAST_NOAES_NODC = 0x8,

    /*!
     * 32-bit Passive Parallel with Fast Power on Reset Delay; With AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x4.
     */
    ALT_FPGA_CFG_MODE_PP32_FAST_AES_NODC = 0x9,

    /*!
     * 32-bit Passive Parallel with Fast Power on Reset Delay; AES Optional;
     * With Data Compression. CDRATIO must be programmed to x8.
     */
    ALT_FPGA_CFG_MODE_PP32_FAST_AESOPT_DC = 0xa,

    /*!
     * 32-bit Passive Parallel with Slow Power on Reset Delay; No AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x1.
         */
    ALT_FPGA_CFG_MODE_PP32_SLOW_NOAES_NODC = 0xc,

    /*!
     * 32-bit Passive Parallel with Slow Power on Reset Delay; With AES
     * Encryption; No Data Compression. CDRATIO must be programmed to x4.
     */
    ALT_FPGA_CFG_MODE_PP32_SLOW_AES_NODC = 0xd,

    /*!
     * 32-bit Passive Parallel with Slow Power on Reset Delay; AES Optional;
     * With Data Compression. CDRATIO must be programmed to x8.
     */
    ALT_FPGA_CFG_MODE_PP32_SLOW_AESOPT_DC = 0xe,

    /*!
     * Unknown FPGA Configuration Mode.
     */
    ALT_FPGA_CFG_MODE_UNKNOWN = 0x20,

} ALT_FPGA_CFG_MODE_t;



/*!
 * Type definition for the callback function prototype used by the FPGA Manager
 * to read configuration bitstream data from a user defined input source
 * stream.
 *
 * The purpose of this callback function declaration is to provide a prototype
 * for a user defined method of sequentially reading FPGA configuration
 * bitstream data from an arbitrary input source. Example input sources include
 * a file resident on a file system, a network stream socket, or a fixed
 * address block in flash memory. The only requirement on the input source is
 * that it is capable of supplying consecutive blocks of data of the requested
 * size from the FPGA configuration bitstream as demanded by the FPGA Manager.
 *
 * During FPGA configuration, the FPGA Manager periodically calls the user
 * defined callback function to fetch the next \e buf_len consecutive
 * configuration data bytes from the user defined input stream. The callback
 * function fills the FPGA Manager supplied buffer \e buf with up to the next
 * \e buf_len bytes of configuration bitsteam data as read from the input
 * source stream. The callback function returns the number of configuration
 * bytes read into \e buf or 0 upon reaching the end of the configuration
 * bitstream data.
 *
 * If an error occurs on the configuration bitstream input source, then the
 * callback function should return an error code value less than 0.
 *
 * \param       buf
 *              A pointer to a buffer to fill with FPGA configuration bitstream
 *              data bytes.
 *
 * \param       buf_len
 *              The length of the input buffer \e buf in bytes. The number of
 *              FPGA configuration bitstream data bytes copied into \e buf
 *              should not exceed \e buf_len.
 *
 * \param       user_data
 *              A 32-bit data word for passing user defined data. The content
 *              of this parameter is user defined. The FPGA Manager merely
 *              forwards the \e user_data value when it invokes the callback.
 * 
 * \retval      >0      The number of bytes returned in buf.
 * \retval      =0      The end of the input stream has been reached.
 * \retval      <0      An error occurred on the input stream.
 */
typedef int32_t (*alt_fpga_istream_t)(void* buf, size_t buf_len, void* user_data);


/*!
 * This type definition enumerates the signal mask selections for the General
 * Purpose Input (GPI) signals driven from the FPGA to the SoC.
 */
typedef enum ALT_FPGA_GPI_e
{
    /*! Signal driven from the FPGA fabric on f2s_gp[0] */
    ALT_FPGA_GPI_0  = (int32_t)(1UL <<  0),

    /*! Signal driven from the FPGA fabric on f2s_gp[1] */
    ALT_FPGA_GPI_1  = (int32_t)(1UL <<  1),

    /*! Signal driven from the FPGA fabric on f2s_gp[2] */
    ALT_FPGA_GPI_2  = (int32_t)(1UL <<  2),

    /*! Signal driven from the FPGA fabric on f2s_gp[3] */
    ALT_FPGA_GPI_3  = (int32_t)(1UL <<  3),

    /*! Signal driven from the FPGA fabric on f2s_gp[4] */
    ALT_FPGA_GPI_4  = (int32_t)(1UL <<  4),

    /*! Signal driven from the FPGA fabric on f2s_gp[5] */
    ALT_FPGA_GPI_5  = (int32_t)(1UL <<  5),

    /*! Signal driven from the FPGA fabric on f2s_gp[6] */
    ALT_FPGA_GPI_6  = (int32_t)(1UL <<  6),

    /*! Signal driven from the FPGA fabric on f2s_gp[7] */
    ALT_FPGA_GPI_7  = (int32_t)(1UL <<  7),

    /*! Signal driven from the FPGA fabric on f2s_gp[8] */
    ALT_FPGA_GPI_8  = (int32_t)(1UL <<  8),

    /*! Signal driven from the FPGA fabric on f2s_gp[9] */
    ALT_FPGA_GPI_9  = (int32_t)(1UL <<  9),

    /*! Signal driven from the FPGA fabric on f2s_gp[10] */
    ALT_FPGA_GPI_10 = (int32_t)(1UL << 10),

    /*! Signal driven from the FPGA fabric on f2s_gp[11] */
    ALT_FPGA_GPI_11 = (int32_t)(1UL << 11),

    /*! Signal driven from the FPGA fabric on f2s_gp[12] */
    ALT_FPGA_GPI_12 = (int32_t)(1UL << 12),

    /*! Signal driven from the FPGA fabric on f2s_gp[13] */
    ALT_FPGA_GPI_13 = (int32_t)(1UL << 13),

    /*! Signal driven from the FPGA fabric on f2s_gp[14] */
    ALT_FPGA_GPI_14 = (int32_t)(1UL << 14),

    /*! Signal driven from the FPGA fabric on f2s_gp[15] */
    ALT_FPGA_GPI_15 = (int32_t)(1UL << 15),

    /*! Signal driven from the FPGA fabric on f2s_gp[16] */
    ALT_FPGA_GPI_16 = (int32_t)(1UL << 16),

    /*! Signal driven from the FPGA fabric on f2s_gp[17] */
    ALT_FPGA_GPI_17 = (int32_t)(1UL << 17),

    /*! Signal driven from the FPGA fabric on f2s_gp[18] */
    ALT_FPGA_GPI_18 = (int32_t)(1UL << 18),

    /*! Signal driven from the FPGA fabric on f2s_gp[19] */
    ALT_FPGA_GPI_19 = (int32_t)(1UL << 19),

    /*! Signal driven from the FPGA fabric on f2s_gp[20] */
    ALT_FPGA_GPI_20 = (int32_t)(1UL << 20),

    /*! Signal driven from the FPGA fabric on f2s_gp[21] */
    ALT_FPGA_GPI_21 = (int32_t)(1UL << 21),

    /*! Signal driven from the FPGA fabric on f2s_gp[22] */
    ALT_FPGA_GPI_22 = (int32_t)(1UL << 22),

    /*! Signal driven from the FPGA fabric on f2s_gp[23] */
    ALT_FPGA_GPI_23 = (int32_t)(1UL << 23),

    /*! Signal driven from the FPGA fabric on f2s_gp[24] */
    ALT_FPGA_GPI_24 = (int32_t)(1UL << 24),

    /*! Signal driven from the FPGA fabric on f2s_gp[25] */
    ALT_FPGA_GPI_25 = (int32_t)(1UL << 25),

    /*! Signal driven from the FPGA fabric on f2s_gp[26] */
    ALT_FPGA_GPI_26 = (int32_t)(1UL << 26),

    /*! Signal driven from the FPGA fabric on f2s_gp[27] */
    ALT_FPGA_GPI_27 = (int32_t)(1UL << 27),

    /*! Signal driven from the FPGA fabric on f2s_gp[28] */
    ALT_FPGA_GPI_28 = (int32_t)(1UL << 28),

    /*! Signal driven from the FPGA fabric on f2s_gp[29] */
    ALT_FPGA_GPI_29 = (int32_t)(1UL << 29),

    /*! Signal driven from the FPGA fabric on f2s_gp[30] */
    ALT_FPGA_GPI_30 = (int32_t)(1UL << 30),

    /*! Signal driven from the FPGA fabric on f2s_gp[31] */
    ALT_FPGA_GPI_31 = (int32_t)(1UL << 31)

} ALT_FPGA_GPI_t;


/*!
 * This type definition enumerates the signal mask selections for the General
 * Purpose Output (GPO) signals driven from the SoC to the FPGA.
 */
typedef enum ALT_FPGA_GPO_e
{
    /*! Signal driven from the FPGA fabric on s2f_gp[0] */
    ALT_FPGA_GPO_0  = (int32_t)(1UL <<  0),

    /*! Signal driven from the FPGA fabric on s2f_gp[1] */
    ALT_FPGA_GPO_1  = (int32_t)(1UL <<  1),

    /*! Signal driven from the FPGA fabric on s2f_gp[2] */
    ALT_FPGA_GPO_2  = (int32_t)(1UL <<  2),

    /*! Signal driven from the FPGA fabric on s2f_gp[3] */
    ALT_FPGA_GPO_3  = (int32_t)(1UL <<  3),

    /*! Signal driven from the FPGA fabric on s2f_gp[4] */
    ALT_FPGA_GPO_4  = (int32_t)(1UL <<  4),

    /*! Signal driven from the FPGA fabric on s2f_gp[5] */
    ALT_FPGA_GPO_5  = (int32_t)(1UL <<  5),

    /*! Signal driven from the FPGA fabric on s2f_gp[6] */
    ALT_FPGA_GPO_6  = (int32_t)(1UL <<  6),

    /*! Signal driven from the FPGA fabric on s2f_gp[7] */
    ALT_FPGA_GPO_7  = (int32_t)(1UL <<  7),

    /*! Signal driven from the FPGA fabric on s2f_gp[8] */
    ALT_FPGA_GPO_8  = (int32_t)(1UL <<  8),

    /*! Signal driven from the FPGA fabric on s2f_gp[9] */
    ALT_FPGA_GPO_9  = (int32_t)(1UL <<  9),

    /*! Signal driven from the FPGA fabric on s2f_gp[10] */
    ALT_FPGA_GPO_10 = (int32_t)(1UL << 10),

    /*! Signal driven from the FPGA fabric on s2f_gp[11] */
    ALT_FPGA_GPO_11 = (int32_t)(1UL << 11),

    /*! Signal driven from the FPGA fabric on s2f_gp[12] */
    ALT_FPGA_GPO_12 = (int32_t)(1UL << 12),

    /*! Signal driven from the FPGA fabric on s2f_gp[13] */
    ALT_FPGA_GPO_13 = (int32_t)(1UL << 13),

    /*! Signal driven from the FPGA fabric on s2f_gp[14] */
    ALT_FPGA_GPO_14 = (int32_t)(1UL << 14),

    /*! Signal driven from the FPGA fabric on s2f_gp[15] */
    ALT_FPGA_GPO_15 = (int32_t)(1UL << 15),

    /*! Signal driven from the FPGA fabric on s2f_gp[16] */
    ALT_FPGA_GPO_16 = (int32_t)(1UL << 16),

    /*! Signal driven from the FPGA fabric on s2f_gp[17] */
    ALT_FPGA_GPO_17 = (int32_t)(1UL << 17),

    /*! Signal driven from the FPGA fabric on s2f_gp[18] */
    ALT_FPGA_GPO_18 = (int32_t)(1UL << 18),

    /*! Signal driven from the FPGA fabric on s2f_gp[19] */
    ALT_FPGA_GPO_19 = (int32_t)(1UL << 19),

    /*! Signal driven from the FPGA fabric on s2f_gp[20] */
    ALT_FPGA_GPO_20 = (int32_t)(1UL << 20),

    /*! Signal driven from the FPGA fabric on s2f_gp[21] */
    ALT_FPGA_GPO_21 = (int32_t)(1UL << 21),

    /*! Signal driven from the FPGA fabric on s2f_gp[22] */
    ALT_FPGA_GPO_22 = (int32_t)(1UL << 22),

    /*! Signal driven from the FPGA fabric on s2f_gp[23] */
    ALT_FPGA_GPO_23 = (int32_t)(1UL << 23),

    /*! Signal driven from the FPGA fabric on s2f_gp[24] */
    ALT_FPGA_GPO_24 = (int32_t)(1UL << 24),

    /*! Signal driven from the FPGA fabric on s2f_gp[25] */
    ALT_FPGA_GPO_25 = (int32_t)(1UL << 25),

    /*! Signal driven from the FPGA fabric on s2f_gp[26] */
    ALT_FPGA_GPO_26 = (int32_t)(1UL << 26),

    /*! Signal driven from the FPGA fabric on s2f_gp[27] */
    ALT_FPGA_GPO_27 = (int32_t)(1UL << 27),

    /*! Signal driven from the FPGA fabric on s2f_gp[28] */
    ALT_FPGA_GPO_28 = (int32_t)(1UL << 28),

    /*! Signal driven from the FPGA fabric on s2f_gp[29] */
    ALT_FPGA_GPO_29 = (int32_t)(1UL << 29),

    /*! Signal driven from the FPGA fabric on s2f_gp[30] */
    ALT_FPGA_GPO_30 = (int32_t)(1UL << 30),

    /*! Signal driven from the FPGA fabric on s2f_gp[31] */
    ALT_FPGA_GPO_31 = (int32_t)(1UL << 31)

} ALT_FPGA_GPO_t;



/*!
 * @}
 */

/*!
 * @}
 */

#ifdef __cplusplus
}
#endif  /* __cplusplus */


