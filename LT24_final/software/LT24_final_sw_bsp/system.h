/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'CPU' in SOPC Builder design 'DE0_LT24_SOPC'
 * SOPC Builder design path: ../../DE0_LT24_SOPC.sopcinfo
 *
 * Generated: Fri Apr 15 01:39:09 CEST 2016
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
 * ALT_PLL configuration
 *
 */

#define ALT_MODULE_CLASS_ALT_PLL altpll
#define ALT_PLL_BASE 0x40078e0
#define ALT_PLL_IRQ -1
#define ALT_PLL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ALT_PLL_NAME "/dev/ALT_PLL"
#define ALT_PLL_SPAN 16
#define ALT_PLL_TYPE "altpll"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_qsys"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x04006820
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "fast"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1b
#define ALT_CPU_DCACHE_LINE_SIZE 32
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 5
#define ALT_CPU_DCACHE_SIZE 2048
#define ALT_CPU_EXCEPTION_ADDR 0x02000020
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
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
#define ALT_CPU_INST_ADDR_WIDTH 0x1b
#define ALT_CPU_NAME "CPU"
#define ALT_CPU_NUM_OF_SHADOW_REG_SETS 0
#define ALT_CPU_RESET_ADDR 0x02000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x04006820
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "fast"
#define NIOS2_DATA_ADDR_WIDTH 0x1b
#define NIOS2_DCACHE_LINE_SIZE 32
#define NIOS2_DCACHE_LINE_SIZE_LOG2 5
#define NIOS2_DCACHE_SIZE 2048
#define NIOS2_EXCEPTION_ADDR 0x02000020
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
#define NIOS2_INST_ADDR_WIDTH 0x1b
#define NIOS2_NUM_OF_SHADOW_REG_SETS 0
#define NIOS2_RESET_ADDR 0x02000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SPI
#define __ALTERA_AVALON_TIMER
#define __ALTERA_NIOS2_QSYS
#define __ALTPLL
#define __LED_CONTROLLER
#define __LT24_CONTROLLER
#define __LT_AVALON
#define __TERASIC_SPI_3WIRE


/*
 * Gsensor_SPI configuration
 *
 */

#define ALT_MODULE_CLASS_Gsensor_SPI TERASIC_SPI_3WIRE
#define GSENSOR_SPI_BASE 0x4007800
#define GSENSOR_SPI_IRQ -1
#define GSENSOR_SPI_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GSENSOR_SPI_NAME "/dev/Gsensor_SPI"
#define GSENSOR_SPI_SPAN 64
#define GSENSOR_SPI_TYPE "TERASIC_SPI_3WIRE"


/*
 * Gsensor_int configuration
 *
 */

#define ALT_MODULE_CLASS_Gsensor_int altera_avalon_pio
#define GSENSOR_INT_BASE 0x4007880
#define GSENSOR_INT_BIT_CLEARING_EDGE_REGISTER 0
#define GSENSOR_INT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define GSENSOR_INT_CAPTURE 1
#define GSENSOR_INT_DATA_WIDTH 1
#define GSENSOR_INT_DO_TEST_BENCH_WIRING 0
#define GSENSOR_INT_DRIVEN_SIM_VALUE 0
#define GSENSOR_INT_EDGE_TYPE "RISING"
#define GSENSOR_INT_FREQ 50000000
#define GSENSOR_INT_HAS_IN 1
#define GSENSOR_INT_HAS_OUT 0
#define GSENSOR_INT_HAS_TRI 0
#define GSENSOR_INT_IRQ 5
#define GSENSOR_INT_IRQ_INTERRUPT_CONTROLLER_ID 0
#define GSENSOR_INT_IRQ_TYPE "LEVEL"
#define GSENSOR_INT_NAME "/dev/Gsensor_int"
#define GSENSOR_INT_RESET_VALUE 0
#define GSENSOR_INT_SPAN 16
#define GSENSOR_INT_TYPE "altera_avalon_pio"


/*
 * JTAG_UART configuration
 *
 */

#define ALT_MODULE_CLASS_JTAG_UART altera_avalon_jtag_uart
#define JTAG_UART_BASE 0x40078f8
#define JTAG_UART_IRQ 0
#define JTAG_UART_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_NAME "/dev/JTAG_UART"
#define JTAG_UART_READ_DEPTH 64
#define JTAG_UART_READ_THRESHOLD 8
#define JTAG_UART_SPAN 8
#define JTAG_UART_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_WRITE_DEPTH 64
#define JTAG_UART_WRITE_THRESHOLD 8


/*
 * KEY configuration
 *
 */

#define ALT_MODULE_CLASS_KEY altera_avalon_pio
#define KEY_BASE 0x40078d0
#define KEY_BIT_CLEARING_EDGE_REGISTER 0
#define KEY_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEY_CAPTURE 0
#define KEY_DATA_WIDTH 1
#define KEY_DO_TEST_BENCH_WIRING 0
#define KEY_DRIVEN_SIM_VALUE 0
#define KEY_EDGE_TYPE "NONE"
#define KEY_FREQ 10000000
#define KEY_HAS_IN 1
#define KEY_HAS_OUT 0
#define KEY_HAS_TRI 0
#define KEY_IRQ -1
#define KEY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define KEY_IRQ_TYPE "NONE"
#define KEY_NAME "/dev/KEY"
#define KEY_RESET_VALUE 0
#define KEY_SPAN 16
#define KEY_TYPE "altera_avalon_pio"


/*
 * LED_CTRL configuration
 *
 */

#define ALT_MODULE_CLASS_LED_CTRL LED_Controller
#define LED_CTRL_BASE 0x4007000
#define LED_CTRL_IRQ -1
#define LED_CTRL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LED_CTRL_NAME "/dev/LED_CTRL"
#define LED_CTRL_SPAN 1024
#define LED_CTRL_TYPE "LED_Controller"


/*
 * LT24_CTRL configuration
 *
 */

#define ALT_MODULE_CLASS_LT24_CTRL LT24_Controller
#define LT24_CTRL_BASE 0x40078f0
#define LT24_CTRL_IRQ -1
#define LT24_CTRL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LT24_CTRL_NAME "/dev/LT24_CTRL"
#define LT24_CTRL_SPAN 8
#define LT24_CTRL_TYPE "LT24_Controller"


/*
 * LT24_LCD_RSTN configuration
 *
 */

#define ALT_MODULE_CLASS_LT24_LCD_RSTN altera_avalon_pio
#define LT24_LCD_RSTN_BASE 0x40078c0
#define LT24_LCD_RSTN_BIT_CLEARING_EDGE_REGISTER 0
#define LT24_LCD_RSTN_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LT24_LCD_RSTN_CAPTURE 0
#define LT24_LCD_RSTN_DATA_WIDTH 1
#define LT24_LCD_RSTN_DO_TEST_BENCH_WIRING 0
#define LT24_LCD_RSTN_DRIVEN_SIM_VALUE 0
#define LT24_LCD_RSTN_EDGE_TYPE "NONE"
#define LT24_LCD_RSTN_FREQ 50000000
#define LT24_LCD_RSTN_HAS_IN 0
#define LT24_LCD_RSTN_HAS_OUT 1
#define LT24_LCD_RSTN_HAS_TRI 0
#define LT24_LCD_RSTN_IRQ -1
#define LT24_LCD_RSTN_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LT24_LCD_RSTN_IRQ_TYPE "NONE"
#define LT24_LCD_RSTN_NAME "/dev/LT24_LCD_RSTN"
#define LT24_LCD_RSTN_RESET_VALUE 0
#define LT24_LCD_RSTN_SPAN 16
#define LT24_LCD_RSTN_TYPE "altera_avalon_pio"


/*
 * LT24_TOUCH_BUSY configuration
 *
 */

#define ALT_MODULE_CLASS_LT24_TOUCH_BUSY altera_avalon_pio
#define LT24_TOUCH_BUSY_BASE 0x40078a0
#define LT24_TOUCH_BUSY_BIT_CLEARING_EDGE_REGISTER 0
#define LT24_TOUCH_BUSY_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LT24_TOUCH_BUSY_CAPTURE 0
#define LT24_TOUCH_BUSY_DATA_WIDTH 1
#define LT24_TOUCH_BUSY_DO_TEST_BENCH_WIRING 0
#define LT24_TOUCH_BUSY_DRIVEN_SIM_VALUE 0
#define LT24_TOUCH_BUSY_EDGE_TYPE "NONE"
#define LT24_TOUCH_BUSY_FREQ 50000000
#define LT24_TOUCH_BUSY_HAS_IN 1
#define LT24_TOUCH_BUSY_HAS_OUT 0
#define LT24_TOUCH_BUSY_HAS_TRI 0
#define LT24_TOUCH_BUSY_IRQ -1
#define LT24_TOUCH_BUSY_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LT24_TOUCH_BUSY_IRQ_TYPE "NONE"
#define LT24_TOUCH_BUSY_NAME "/dev/LT24_TOUCH_BUSY"
#define LT24_TOUCH_BUSY_RESET_VALUE 0
#define LT24_TOUCH_BUSY_SPAN 16
#define LT24_TOUCH_BUSY_TYPE "altera_avalon_pio"


/*
 * LT24_TOUCH_PENIRQ_N configuration
 *
 */

#define ALT_MODULE_CLASS_LT24_TOUCH_PENIRQ_N altera_avalon_pio
#define LT24_TOUCH_PENIRQ_N_BASE 0x40078b0
#define LT24_TOUCH_PENIRQ_N_BIT_CLEARING_EDGE_REGISTER 0
#define LT24_TOUCH_PENIRQ_N_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LT24_TOUCH_PENIRQ_N_CAPTURE 1
#define LT24_TOUCH_PENIRQ_N_DATA_WIDTH 1
#define LT24_TOUCH_PENIRQ_N_DO_TEST_BENCH_WIRING 0
#define LT24_TOUCH_PENIRQ_N_DRIVEN_SIM_VALUE 0
#define LT24_TOUCH_PENIRQ_N_EDGE_TYPE "FALLING"
#define LT24_TOUCH_PENIRQ_N_FREQ 50000000
#define LT24_TOUCH_PENIRQ_N_HAS_IN 1
#define LT24_TOUCH_PENIRQ_N_HAS_OUT 0
#define LT24_TOUCH_PENIRQ_N_HAS_TRI 0
#define LT24_TOUCH_PENIRQ_N_IRQ 3
#define LT24_TOUCH_PENIRQ_N_IRQ_INTERRUPT_CONTROLLER_ID 0
#define LT24_TOUCH_PENIRQ_N_IRQ_TYPE "EDGE"
#define LT24_TOUCH_PENIRQ_N_NAME "/dev/LT24_TOUCH_PENIRQ_N"
#define LT24_TOUCH_PENIRQ_N_RESET_VALUE 0
#define LT24_TOUCH_PENIRQ_N_SPAN 16
#define LT24_TOUCH_PENIRQ_N_TYPE "altera_avalon_pio"


/*
 * LT24_TOUCH_SPI configuration
 *
 */

#define ALT_MODULE_CLASS_LT24_TOUCH_SPI altera_avalon_spi
#define LT24_TOUCH_SPI_BASE 0x4007840
#define LT24_TOUCH_SPI_CLOCKMULT 1
#define LT24_TOUCH_SPI_CLOCKPHASE 0
#define LT24_TOUCH_SPI_CLOCKPOLARITY 0
#define LT24_TOUCH_SPI_CLOCKUNITS "Hz"
#define LT24_TOUCH_SPI_DATABITS 8
#define LT24_TOUCH_SPI_DATAWIDTH 16
#define LT24_TOUCH_SPI_DELAYMULT "1.0E-9"
#define LT24_TOUCH_SPI_DELAYUNITS "ns"
#define LT24_TOUCH_SPI_EXTRADELAY 0
#define LT24_TOUCH_SPI_INSERT_SYNC 0
#define LT24_TOUCH_SPI_IRQ 1
#define LT24_TOUCH_SPI_IRQ_INTERRUPT_CONTROLLER_ID 0
#define LT24_TOUCH_SPI_ISMASTER 1
#define LT24_TOUCH_SPI_LSBFIRST 0
#define LT24_TOUCH_SPI_NAME "/dev/LT24_TOUCH_SPI"
#define LT24_TOUCH_SPI_NUMSLAVES 1
#define LT24_TOUCH_SPI_PREFIX "spi_"
#define LT24_TOUCH_SPI_SPAN 32
#define LT24_TOUCH_SPI_SYNC_REG_DEPTH 2
#define LT24_TOUCH_SPI_TARGETCLOCK 32000u
#define LT24_TOUCH_SPI_TARGETSSDELAY "0.0"
#define LT24_TOUCH_SPI_TYPE "altera_avalon_spi"


/*
 * LT24_buffer_flag configuration
 *
 */

#define ALT_MODULE_CLASS_LT24_buffer_flag altera_avalon_pio
#define LT24_BUFFER_FLAG_BASE 0x4007890
#define LT24_BUFFER_FLAG_BIT_CLEARING_EDGE_REGISTER 0
#define LT24_BUFFER_FLAG_BIT_MODIFYING_OUTPUT_REGISTER 0
#define LT24_BUFFER_FLAG_CAPTURE 0
#define LT24_BUFFER_FLAG_DATA_WIDTH 1
#define LT24_BUFFER_FLAG_DO_TEST_BENCH_WIRING 0
#define LT24_BUFFER_FLAG_DRIVEN_SIM_VALUE 0
#define LT24_BUFFER_FLAG_EDGE_TYPE "NONE"
#define LT24_BUFFER_FLAG_FREQ 50000000
#define LT24_BUFFER_FLAG_HAS_IN 0
#define LT24_BUFFER_FLAG_HAS_OUT 1
#define LT24_BUFFER_FLAG_HAS_TRI 0
#define LT24_BUFFER_FLAG_IRQ -1
#define LT24_BUFFER_FLAG_IRQ_INTERRUPT_CONTROLLER_ID -1
#define LT24_BUFFER_FLAG_IRQ_TYPE "NONE"
#define LT24_BUFFER_FLAG_NAME "/dev/LT24_buffer_flag"
#define LT24_BUFFER_FLAG_RESET_VALUE 0
#define LT24_BUFFER_FLAG_SPAN 16
#define LT24_BUFFER_FLAG_TYPE "altera_avalon_pio"


/*
 * LT_Avalon configuration
 *
 */

#define ALT_MODULE_CLASS_LT_Avalon LT_Avalon
#define LT_AVALON_BASE 0x4007400
#define LT_AVALON_IRQ 4
#define LT_AVALON_IRQ_INTERRUPT_CONTROLLER_ID 0
#define LT_AVALON_NAME "/dev/LT_Avalon"
#define LT_AVALON_SPAN 1024
#define LT_AVALON_TYPE "LT_Avalon"


/*
 * SDRAM configuration
 *
 */

#define ALT_MODULE_CLASS_SDRAM altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x2000000
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/SDRAM"
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_REFRESH_PERIOD 15.625
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x18
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 9
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 33554432
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/JTAG_UART"
#define ALT_STDERR_BASE 0x40078f8
#define ALT_STDERR_DEV JTAG_UART
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/JTAG_UART"
#define ALT_STDIN_BASE 0x40078f8
#define ALT_STDIN_DEV JTAG_UART
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/JTAG_UART"
#define ALT_STDOUT_BASE 0x40078f8
#define ALT_STDOUT_DEV JTAG_UART
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "DE0_LT24_SOPC"


/*
 * TIMER configuration
 *
 */

#define ALT_MODULE_CLASS_TIMER altera_avalon_timer
#define TIMER_ALWAYS_RUN 0
#define TIMER_BASE 0x4007860
#define TIMER_COUNTER_SIZE 32
#define TIMER_FIXED_PERIOD 0
#define TIMER_FREQ 10000000
#define TIMER_IRQ 2
#define TIMER_IRQ_INTERRUPT_CONTROLLER_ID 0
#define TIMER_LOAD_VALUE 19999
#define TIMER_MULT 0.001
#define TIMER_NAME "/dev/TIMER"
#define TIMER_PERIOD 2
#define TIMER_PERIOD_UNITS "ms"
#define TIMER_RESET_OUTPUT 0
#define TIMER_SNAPSHOT 1
#define TIMER_SPAN 32
#define TIMER_TICKS_PER_SEC 500
#define TIMER_TIMEOUT_PULSE_OUTPUT 0
#define TIMER_TYPE "altera_avalon_timer"


/*
 * background_mem configuration
 *
 */

#define ALT_MODULE_CLASS_background_mem altera_avalon_onchip_memory2
#define BACKGROUND_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define BACKGROUND_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define BACKGROUND_MEM_BASE 0x4000000
#define BACKGROUND_MEM_CONTENTS_INFO ""
#define BACKGROUND_MEM_DUAL_PORT 1
#define BACKGROUND_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define BACKGROUND_MEM_INIT_CONTENTS_FILE "myBackground"
#define BACKGROUND_MEM_INIT_MEM_CONTENT 1
#define BACKGROUND_MEM_INSTANCE_ID "NONE"
#define BACKGROUND_MEM_IRQ -1
#define BACKGROUND_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BACKGROUND_MEM_NAME "/dev/background_mem"
#define BACKGROUND_MEM_NON_DEFAULT_INIT_FILE_ENABLED 1
#define BACKGROUND_MEM_RAM_BLOCK_TYPE "AUTO"
#define BACKGROUND_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define BACKGROUND_MEM_SINGLE_CLOCK_OP 0
#define BACKGROUND_MEM_SIZE_MULTIPLE 1
#define BACKGROUND_MEM_SIZE_VALUE 9600
#define BACKGROUND_MEM_SPAN 9600
#define BACKGROUND_MEM_TYPE "altera_avalon_onchip_memory2"
#define BACKGROUND_MEM_WRITABLE 1


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK TIMER
#define ALT_TIMESTAMP_CLK none


/*
 * pic_mem configuration
 *
 */

#define ALT_MODULE_CLASS_pic_mem altera_avalon_onchip_memory2
#define PIC_MEM_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define PIC_MEM_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define PIC_MEM_BASE 0x4004000
#define PIC_MEM_CONTENTS_INFO ""
#define PIC_MEM_DUAL_PORT 1
#define PIC_MEM_GUI_RAM_BLOCK_TYPE "AUTO"
#define PIC_MEM_INIT_CONTENTS_FILE "myCharac"
#define PIC_MEM_INIT_MEM_CONTENT 1
#define PIC_MEM_INSTANCE_ID "NONE"
#define PIC_MEM_IRQ -1
#define PIC_MEM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PIC_MEM_NAME "/dev/pic_mem"
#define PIC_MEM_NON_DEFAULT_INIT_FILE_ENABLED 1
#define PIC_MEM_RAM_BLOCK_TYPE "AUTO"
#define PIC_MEM_READ_DURING_WRITE_MODE "DONT_CARE"
#define PIC_MEM_SINGLE_CLOCK_OP 0
#define PIC_MEM_SIZE_MULTIPLE 1
#define PIC_MEM_SIZE_VALUE 8192
#define PIC_MEM_SPAN 8192
#define PIC_MEM_TYPE "altera_avalon_onchip_memory2"
#define PIC_MEM_WRITABLE 1


/*
 * ucosii configuration
 *
 */

#define OS_ARG_CHK_EN 1
#define OS_CPU_HOOKS_EN 1
#define OS_DEBUG_EN 1
#define OS_EVENT_NAME_SIZE 32
#define OS_FLAGS_NBITS 16
#define OS_FLAG_ACCEPT_EN 1
#define OS_FLAG_DEL_EN 1
#define OS_FLAG_EN 1
#define OS_FLAG_NAME_SIZE 32
#define OS_FLAG_QUERY_EN 1
#define OS_FLAG_WAIT_CLR_EN 1
#define OS_LOWEST_PRIO 20
#define OS_MAX_EVENTS 60
#define OS_MAX_FLAGS 20
#define OS_MAX_MEM_PART 60
#define OS_MAX_QS 20
#define OS_MAX_TASKS 10
#define OS_MBOX_ACCEPT_EN 1
#define OS_MBOX_DEL_EN 1
#define OS_MBOX_EN 1
#define OS_MBOX_POST_EN 1
#define OS_MBOX_POST_OPT_EN 1
#define OS_MBOX_QUERY_EN 1
#define OS_MEM_EN 1
#define OS_MEM_NAME_SIZE 32
#define OS_MEM_QUERY_EN 1
#define OS_MUTEX_ACCEPT_EN 1
#define OS_MUTEX_DEL_EN 1
#define OS_MUTEX_EN 1
#define OS_MUTEX_QUERY_EN 1
#define OS_Q_ACCEPT_EN 1
#define OS_Q_DEL_EN 1
#define OS_Q_EN 1
#define OS_Q_FLUSH_EN 1
#define OS_Q_POST_EN 1
#define OS_Q_POST_FRONT_EN 1
#define OS_Q_POST_OPT_EN 1
#define OS_Q_QUERY_EN 1
#define OS_SCHED_LOCK_EN 1
#define OS_SEM_ACCEPT_EN 1
#define OS_SEM_DEL_EN 1
#define OS_SEM_EN 1
#define OS_SEM_QUERY_EN 1
#define OS_SEM_SET_EN 1
#define OS_TASK_CHANGE_PRIO_EN 1
#define OS_TASK_CREATE_EN 1
#define OS_TASK_CREATE_EXT_EN 1
#define OS_TASK_DEL_EN 1
#define OS_TASK_IDLE_STK_SIZE 512
#define OS_TASK_NAME_SIZE 32
#define OS_TASK_PROFILE_EN 1
#define OS_TASK_QUERY_EN 1
#define OS_TASK_STAT_EN 1
#define OS_TASK_STAT_STK_CHK_EN 1
#define OS_TASK_STAT_STK_SIZE 512
#define OS_TASK_SUSPEND_EN 1
#define OS_TASK_SW_HOOK_EN 1
#define OS_TASK_TMR_PRIO 0
#define OS_TASK_TMR_STK_SIZE 512
#define OS_THREAD_SAFE_NEWLIB 1
#define OS_TICKS_PER_SEC TIMER_TICKS_PER_SEC
#define OS_TICK_STEP_EN 1
#define OS_TIME_DLY_HMSM_EN 1
#define OS_TIME_DLY_RESUME_EN 1
#define OS_TIME_GET_SET_EN 1
#define OS_TIME_TICK_HOOK_EN 1
#define OS_TMR_CFG_MAX 16
#define OS_TMR_CFG_NAME_SIZE 16
#define OS_TMR_CFG_TICKS_PER_SEC 10
#define OS_TMR_CFG_WHEEL_SIZE 2
#define OS_TMR_EN 0

#endif /* __SYSTEM_H_ */
