/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'cpu' in SOPC Builder design 'DE1_SoC_QSYS'
 * SOPC Builder design path: ../../DE1_SoC_QSYS.sopcinfo
 *
 * Generated: Wed Oct 16 19:40:23 CST 2013
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00001020
#define ALT_CPU_CPU_FREQ 130000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1a
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x00080020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 130000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 1
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 32
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_ICACHE_SIZE 4096
#define ALT_CPU_INITDA_SUPPORTED
#define ALT_CPU_INST_ADDR_WIDTH 0x14
#define ALT_CPU_NAME "cpu"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x00080000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00001020
#define NIOS2_CPU_FREQ 130000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1a
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x00080020
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 1
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 32
#define NIOS2_ICACHE_LINE_SIZE_LOG2 5
#define NIOS2_ICACHE_SIZE 4096
#define NIOS2_INITDA_SUPPORTED
#define NIOS2_INST_ADDR_WIDTH 0x14
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x00080000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SPI
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_AVALON_TIMER
#define __ALTERA_AVALON_UART
#define __ALTERA_NIOS2_QSYS
#define __ALT_VIP_CTI
#define __ALT_VIP_MIX
#define __AUDIO_IF


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone V"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart"
#define ALT_STDERR_BASE 0x60
#define ALT_STDERR_DEV jtag_uart
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart"
#define ALT_STDIN_BASE 0x60
#define ALT_STDIN_DEV jtag_uart
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart"
#define ALT_STDOUT_BASE 0x60
#define ALT_STDOUT_DEV jtag_uart
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "DE1_SoC_QSYS"


/*
 * alt_vip_cti_0 configuration
 *
 */

#define ALT_MODULE_CLASS_alt_vip_cti_0 alt_vip_cti
#define ALT_VIP_CTI_0_BASE 0x10080
#define ALT_VIP_CTI_0_IRQ -1
#define ALT_VIP_CTI_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ALT_VIP_CTI_0_NAME "/dev/alt_vip_cti_0"
#define ALT_VIP_CTI_0_SPAN 256
#define ALT_VIP_CTI_0_TYPE "alt_vip_cti"


/*
 * alt_vip_mix_0 configuration
 *
 */

#define ALT_MODULE_CLASS_alt_vip_mix_0 alt_vip_mix
#define ALT_VIP_MIX_0_BASE 0x10100
#define ALT_VIP_MIX_0_IRQ -1
#define ALT_VIP_MIX_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ALT_VIP_MIX_0_NAME "/dev/alt_vip_mix_0"
#define ALT_VIP_MIX_0_SPAN 1024
#define ALT_VIP_MIX_0_TYPE "alt_vip_mix"


/*
 * audio configuration
 *
 */

#define ALT_MODULE_CLASS_audio AUDIO_IF
#define AUDIO_BASE 0x40
#define AUDIO_IRQ -1
#define AUDIO_IRQ_INTERRUPT_CONTROLLER_ID -1
#define AUDIO_NAME "/dev/audio"
#define AUDIO_SPAN 128
#define AUDIO_TYPE "AUDIO_IF"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER
#define ALT_TIMESTAMP_CLK TIMER_STAMP


/*
 * i2c_scl configuration
 *
 */

#define ALT_MODULE_CLASS_i2c_scl altera_avalon_pio
#define I2C_SCL_BASE 0x3000050
#define I2C_SCL_BIT_CLEARING_EDGE_REGISTER 0
#define I2C_SCL_BIT_MODIFYING_OUTPUT_REGISTER 0
#define I2C_SCL_CAPTURE 0
#define I2C_SCL_DATA_WIDTH 1
#define I2C_SCL_DO_TEST_BENCH_WIRING 0
#define I2C_SCL_DRIVEN_SIM_VALUE 0
#define I2C_SCL_EDGE_TYPE "NONE"
#define I2C_SCL_FREQ 10000000
#define I2C_SCL_HAS_IN 0
#define I2C_SCL_HAS_OUT 1
#define I2C_SCL_HAS_TRI 0
#define I2C_SCL_IRQ -1
#define I2C_SCL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define I2C_SCL_IRQ_TYPE "NONE"
#define I2C_SCL_NAME "/dev/i2c_scl"
#define I2C_SCL_RESET_VALUE 0
#define I2C_SCL_SPAN 64
#define I2C_SCL_TYPE "altera_avalon_pio"


/*
 * i2c_sda configuration
 *
 */

#define ALT_MODULE_CLASS_i2c_sda altera_avalon_pio
#define I2C_SDA_BASE 0x3000040
#define I2C_SDA_BIT_CLEARING_EDGE_REGISTER 0
#define I2C_SDA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define I2C_SDA_CAPTURE 0
#define I2C_SDA_DATA_WIDTH 1
#define I2C_SDA_DO_TEST_BENCH_WIRING 0
#define I2C_SDA_DRIVEN_SIM_VALUE 0
#define I2C_SDA_EDGE_TYPE "NONE"
#define I2C_SDA_FREQ 10000000
#define I2C_SDA_HAS_IN 0
#define I2C_SDA_HAS_OUT 0
#define I2C_SDA_HAS_TRI 1
#define I2C_SDA_IRQ -1
#define I2C_SDA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define I2C_SDA_IRQ_TYPE "NONE"
#define I2C_SDA_NAME "/dev/i2c_sda"
#define I2C_SDA_RESET_VALUE 0
#define I2C_SDA_SPAN 64
#define I2C_SDA_TYPE "altera_avalon_pio"


/*
 * jtag_uart configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x60
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/jtag_uart"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 32
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * onchip_memory2 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_BASE 0x80000
#define ONCHIP_MEMORY2_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_DUAL_PORT 0
#define ONCHIP_MEMORY2_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_INIT_CONTENTS_FILE "DE1_SoC_QSYS_onchip_memory2"
#define ONCHIP_MEMORY2_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_IRQ -1
#define ONCHIP_MEMORY2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_NAME "/dev/onchip_memory2"
#define ONCHIP_MEMORY2_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_SIZE_VALUE 160000
#define ONCHIP_MEMORY2_SPAN 160000
#define ONCHIP_MEMORY2_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_WRITABLE 1


/*
 * spi_0 configuration
 *
 */

#define ALT_MODULE_CLASS_spi_0 altera_avalon_spi
#define SPI_0_BASE 0x1000000
#define SPI_0_CLOCKMULT 1
#define SPI_0_CLOCKPHASE 0
#define SPI_0_CLOCKPOLARITY 1
#define SPI_0_CLOCKUNITS "Hz"
#define SPI_0_DATABITS 16
#define SPI_0_DATAWIDTH 16
#define SPI_0_DELAYMULT "1.0E-9"
#define SPI_0_DELAYUNITS "ns"
#define SPI_0_EXTRADELAY 0
#define SPI_0_INSERT_SYNC 0
#define SPI_0_IRQ 7
#define SPI_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define SPI_0_ISMASTER 1
#define SPI_0_LSBFIRST 0
#define SPI_0_NAME "/dev/spi_0"
#define SPI_0_NUMSLAVES 1
#define SPI_0_PREFIX "spi_"
#define SPI_0_SPAN 128
#define SPI_0_SYNC_REG_DEPTH 2
#define SPI_0_TARGETCLOCK 20000000u
#define SPI_0_TARGETSSDELAY "0.0"
#define SPI_0_TYPE "altera_avalon_spi"


/*
 * sysid configuration
 *
 */

#define ALT_MODULE_CLASS_sysid altera_avalon_sysid_qsys
#define SYSID_BASE 0x3000060
#define SYSID_ID 0
#define SYSID_IRQ -1
#define SYSID_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_NAME "/dev/sysid"
#define SYSID_SPAN 8
#define SYSID_TIMESTAMP 1381894597
#define SYSID_TYPE "altera_avalon_sysid_qsys"


/*
 * td_reset_n configuration
 *
 */

#define ALT_MODULE_CLASS_td_reset_n altera_avalon_pio
#define TD_RESET_N_BASE 0x3000020
#define TD_RESET_N_BIT_CLEARING_EDGE_REGISTER 0
#define TD_RESET_N_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TD_RESET_N_CAPTURE 0
#define TD_RESET_N_DATA_WIDTH 1
#define TD_RESET_N_DO_TEST_BENCH_WIRING 0
#define TD_RESET_N_DRIVEN_SIM_VALUE 0
#define TD_RESET_N_EDGE_TYPE "NONE"
#define TD_RESET_N_FREQ 10000000
#define TD_RESET_N_HAS_IN 0
#define TD_RESET_N_HAS_OUT 1
#define TD_RESET_N_HAS_TRI 0
#define TD_RESET_N_IRQ -1
#define TD_RESET_N_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TD_RESET_N_IRQ_TYPE "NONE"
#define TD_RESET_N_NAME "/dev/td_reset_n"
#define TD_RESET_N_RESET_VALUE 0
#define TD_RESET_N_SPAN 64
#define TD_RESET_N_TYPE "altera_avalon_pio"


/*
 * td_status configuration
 *
 */

#define ALT_MODULE_CLASS_td_status altera_avalon_pio
#define TD_STATUS_BASE 0x3000030
#define TD_STATUS_BIT_CLEARING_EDGE_REGISTER 0
#define TD_STATUS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TD_STATUS_CAPTURE 0
#define TD_STATUS_DATA_WIDTH 2
#define TD_STATUS_DO_TEST_BENCH_WIRING 0
#define TD_STATUS_DRIVEN_SIM_VALUE 0
#define TD_STATUS_EDGE_TYPE "NONE"
#define TD_STATUS_FREQ 10000000
#define TD_STATUS_HAS_IN 1
#define TD_STATUS_HAS_OUT 0
#define TD_STATUS_HAS_TRI 0
#define TD_STATUS_IRQ -1
#define TD_STATUS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TD_STATUS_IRQ_TYPE "NONE"
#define TD_STATUS_NAME "/dev/td_status"
#define TD_STATUS_RESET_VALUE 0
#define TD_STATUS_SPAN 64
#define TD_STATUS_TYPE "altera_avalon_pio"


/*
 * timer configuration
 *
 */

#define ALT_MODULE_CLASS_timer altera_avalon_timer
#define TIMER_ALWAYS_RUN 0
#define TIMER_BASE 0x3000000
#define TIMER_COUNTER_SIZE 32
#define TIMER_FIXED_PERIOD 0
#define TIMER_FREQ 10000000
#define TIMER_IRQ 1
#define TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_LOAD_VALUE 9999
#define TIMER_MULT 0.0010
#define TIMER_NAME "/dev/timer"
#define TIMER_PERIOD 1
#define TIMER_PERIOD_UNITS "ms"
#define TIMER_RESET_OUTPUT 0
#define TIMER_SNAPSHOT 1
#define TIMER_SPAN 128
#define TIMER_TICKS_PER_SEC 1000.0
#define TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_TYPE "altera_avalon_timer"


/*
 * timer_stamp configuration
 *
 */

#define ALT_MODULE_CLASS_timer_stamp altera_avalon_timer
#define TIMER_STAMP_ALWAYS_RUN 0
#define TIMER_STAMP_BASE 0x0
#define TIMER_STAMP_COUNTER_SIZE 32
#define TIMER_STAMP_FIXED_PERIOD 0
#define TIMER_STAMP_FREQ 130000000
#define TIMER_STAMP_IRQ 8
#define TIMER_STAMP_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_STAMP_LOAD_VALUE 129999
#define TIMER_STAMP_MULT 0.0010
#define TIMER_STAMP_NAME "/dev/timer_stamp"
#define TIMER_STAMP_PERIOD 1
#define TIMER_STAMP_PERIOD_UNITS "ms"
#define TIMER_STAMP_RESET_OUTPUT 0
#define TIMER_STAMP_SNAPSHOT 1
#define TIMER_STAMP_SPAN 128
#define TIMER_STAMP_TICKS_PER_SEC 1000.0
#define TIMER_STAMP_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_STAMP_TYPE "altera_avalon_timer"


/*
 * uart configuration
 *
 */

#define ALT_MODULE_CLASS_uart altera_avalon_uart
#define UART_BASE 0x20
#define UART_BAUD 2400
#define UART_DATA_BITS 8
#define UART_FIXED_BAUD 0
#define UART_FREQ 130000000
#define UART_IRQ 4
#define UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_NAME "/dev/uart"
#define UART_PARITY 'N'
#define UART_SIM_CHAR_STREAM ""
#define UART_SIM_TRUE_BAUD 0
#define UART_SPAN 128
#define UART_STOP_BITS 1
#define UART_SYNC_REG_DEPTH 2
#define UART_TYPE "altera_avalon_uart"
#define UART_USE_CTS_RTS 0
#define UART_USE_EOP_REGISTER 0

#endif /* __SYSTEM_H_ */
