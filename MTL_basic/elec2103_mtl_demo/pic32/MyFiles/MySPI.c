/*******************************************************************************
* MyLED                                                                        *
********************************************************************************
* Description:                                                                 *
* Functions to control the SPI of MyExpansionBoard_Pic32                       *
********************************************************************************
* Version : 1.00 - June 2011                                                   *
*******************************************************************************/

#define  MySPI

#include "MyApp.h"

void MySPI_Init(void)
{
    volatile int Debug;

    // SpiChnOpen onfigures SPI Pins
    // SPI_OPEN_MSTEN : Master Mode
    // SPI_OPEN_CKE : Clock Edge Select bit - 1 = Serial output data changes on
    //  transition from active clock state to Idle clock state
    //  (cfr page 18 of PIC32 Family Ref. Manual Sect 23 SPI)
    // SPI_OPEN_SMP : SPI Data Input Sample Phase bit
    //  0 = Input data sampled at middle of data output time

    // Set SPI Clock to 1MHz

    SpiChnOpen(SPI_CHANNEL1A, SPI_OPEN_MSTEN | SPI_OPEN_CKE_REV | SPI_OPEN_MODE8, GetPeripheralClock()/(80ul));

    /*
    PIC32 SPI clock speed:
    ---------------------
    Fsck =        Fpb
           ------------------
           2 * (SPIxBRG + 1)

    Note that the maximum possible baud rate is
    Fpb/2 (SPIXBRG = 0) and the minimum possible baud
    rate is Fpb /1024.

    WF_MAX_SPI_FREQ         = (10000000ul)  (10MHz)
    SPIFLASH_MAX_SPI_FREQ   = (16000000ul)  (16MHz)

    The SPI clock for Wifi Module is set locally

    The SPI Clock speed is limited to 5MHz due to Cyclone limitations
    */
    SPI1ABRG = (GetPeripheralClock()-1ul)/2ul/(5000000ul);
}

void MySPI_Close(void)
{
    SpiChnClose(SPI_CHANNEL1A);
}

void MySPI_PutC(unsigned int theData)
{
    int theDummyData;

    SpiChnPutC(SPI_CHANNEL1A, theData);
    theDummyData = SpiChnGetC(SPI_CHANNEL1A);
}

unsigned int MySPI_GetC(void)
{
    int theData;

    SpiChnPutC(SPI_CHANNEL1A, 0x00);
    theData = SpiChnGetC(SPI_CHANNEL1A);
    return(theData);
}

unsigned int MySPI_PutGetC(unsigned int theDataIn)
{
    int theDataOut;

    SpiChnPutC(SPI_CHANNEL1A, theDataIn);
    theDataOut = SpiChnGetC(SPI_CHANNEL1A);
    return(theDataOut);
}
