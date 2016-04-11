 /*********************************************************************
 *
 *	Hardware specific definitions for MyExpansionBoard_Pic32_v1
 *
 *********************************************************************/

#ifndef HARDWARE_PROFILE_WIFI_H
#define HARDWARE_PROFILE_WIFI_H

#include "Compiler.h"

// Clock frequency values
// These directly influence timed events using the Tick module.  They also are used for UART and SPI baud rate generation.
#define GetSystemClock()		(80000000ul)			// Hz
#define GetInstructionClock()	(GetSystemClock()/1)	// Normally GetSystemClock()/4 for PIC18, GetSystemClock()/2 for PIC24/dsPIC, and GetSystemClock()/1 for PIC32.  Might need changing if using Doze modes.
#define GetPeripheralClock()	(GetSystemClock()/1)	// Normally GetSystemClock()/4 for PIC18, GetSystemClock()/2 for PIC24/dsPIC, and GetSystemClock()/1 for PIC32.  Divisor may be different if using a PIC32 since it's configurable.

//----------------------------
// MRF24WB0M WiFi I/O pins
//----------------------------

#define WF_CS_TRIS		(TRISEbits.TRISE3)      // RE3
#define WF_CS_IO		(LATEbits.LATE3)
//#define WF_SDI_TRIS		(TRISFbits.TRISF7)
//#define WF_SCK_TRIS		(TRISFbits.TRISF6)
//#define WF_SDO_TRIS		(TRISFbits.TRISF8)
#define WF_RESET_TRIS		(TRISEbits.TRISE7)      // RE7
#define WF_RESET_IO		(LATEbits.LATE7)
#define WF_INT_TRIS		(TRISDbits.TRISD11)	// INT4 = RD11
#define WF_INT_IO		(PORTDbits.RD11)
#define WF_HIBERNATE_TRIS	(TRISBbits.TRISB3)      // RB3
#define WF_HIBERNATE_IO		(PORTBbits.RB3)

#define WF_INT_EDGE		(INTCONbits.INT4EP)
#define WF_INT_IE		(IEC0bits.INT4IE)
#define WF_INT_IF		(IFS0bits.INT4IF)
#define WF_INT_IE_CLEAR		IEC0CLR
#define WF_INT_IF_CLEAR		IFS0CLR
#define WF_INT_IE_SET		IEC0SET
#define WF_INT_IF_SET		IFS0SET
#define WF_INT_BIT		0x00080000              // INT4 = IRQ19 (cfr PIC32MX5_6_7_Datasheet p110


#define WF_INT_IPCSET		IPC4SET
#define WF_INT_IPCCLR		IPC4CLR
#define WF_INT_IPC_MASK		0xFF000000
#define WF_INT_IPC_VALUE	0x0C000000

#define WF_SSPBUF		(SPI1ABUF)
#define WF_SPISTAT		(SPI1ASTAT)
#define WF_SPISTATbits		(SPI1ASTATbits)
#define WF_SPICON1		(SPI1ACON)
#define WF_SPICON1bits		(SPI1ACONbits)
//#define WF_SPI_IE_CLEAR		IEC0CLR
//#define WF_SPI_IF_CLEAR		IFS0CLR
//#define WF_SPI_INT_BITS		0x03800000
#define WF_SPI_BRG		(SPI1ABRG)
#define WF_MAX_SPI_FREQ		(10000000ul)	// Hz

//----------------------------
// SST25VF032B - Flash
//----------------------------

#define SPIFLASH_CS_TRIS	(TRISEbits.TRISE0)      // RE0
#define SPIFLASH_CS_IO		(LATEbits.LATE0)
#//define SPIFLASH_SCK_TRIS	(TRISGbits.TRISG6)
#//define SPIFLASH_SDI_TRIS	(TRISGbits.TRISG7)
#//define SPIFLASH_SDI_IO	(PORTGbits.RG7)
#//define SPIFLASH_SDO_TRIS	TRISGbits.TRISG8)
#define SPIFLASH_SPI_IF		(IFS1bits.SPI1ARXIF)
#define SPIFLASH_SSPBUF		(SPI1ABUF)
#define SPIFLASH_SPICON1	(SPI1ACON)
#define SPIFLASH_SPICON1bits	(SPI1ACONbits)
#define SPIFLASH_SPISTATbits	(SPI1ASTATbits)
#define SPIFLASH_SPIBRG		(SPI1ABRG)

#endif // #ifndef HARDWARE_PROFILE_H
