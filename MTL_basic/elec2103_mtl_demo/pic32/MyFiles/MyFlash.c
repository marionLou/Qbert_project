/*******************************************************************************
* MyFlash                                                                      *
********************************************************************************
* Description:                                                                 *
* Functions to control the 32-Mbit SPI Serial Flash - SST25VF032B              *
********************************************************************************
* Version : 1.10 - Sept 2012                                                   *
*******************************************************************************/

#define  MyFLASH

#include "MyApp.h"

void MyFlash_Init(void)
{
    unsigned int    intStatus;
    unsigned int    theStatus;
    char            theStr[64];

    // Configure Flash Pins (Port B) and set to 1 (default value)
    mPORTBSetBits(FLASH_WP | FLASH_HOLD);
    mPORTBSetPinsDigitalOut(FLASH_WP | FLASH_HOLD);

    // Set the Block Protection bits (BP3-0) to 0 (Disable all protections)
    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_EN_WR_STATUS);
    FLASH_DISABLE_ACCESS;
    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_WRITE_STATUS);
        MySPI_PutC(0x00);
    FLASH_DISABLE_ACCESS;
/*
    // Read the Status Register
    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_READ_STATUS);
        theStatus = MySPI_GetC();
    FLASH_DISABLE_ACCESS;

    sprintf(theStr, "Flash Status 0: 0x%x\n>", theStatus);
    MyConsole_SendMsg(theStr);
*/
}

/******************************************************************************/

void MyFlash_Erase(void)
{
    unsigned int    intStatus;
    unsigned int    theStatus, n=0, x, i;
    char            theStr[256];

    // Enable Write Operation
    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_WRITE_ENABLE);
    FLASH_DISABLE_ACCESS;

    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_CHIP_ERASE);
    FLASH_DISABLE_ACCESS;

    // Poll the Busy in the Status Register to check the completion of the erase sequence
    while(1) {
        FLASH_ENABLE_ACCESS;
            MySPI_PutC(FLASH_READ_STATUS);
            theStatus = MySPI_GetC();
        FLASH_DISABLE_ACCESS;
        if ((theStatus & 0x01) == 0) break;
     }

    // Enable further Write Operation
    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_WRITE_ENABLE);
    FLASH_DISABLE_ACCESS;

    // Check the Memory
    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_READ);
        MySPI_PutC(0x00);
        MySPI_PutC(0x00);
        MySPI_PutC(0x00);
        for (i=0; i < 0x10000; i++) {
            x = MySPI_GetC();
            if (x != 0xFF) n++;
        }
    FLASH_DISABLE_ACCESS;

    sprintf(theStr, "Flash Erase : %d Error(s)\n>", n);
    MyConsole_SendMsg(theStr);
}

/******************************************************************************/

void MyFlash_Program_Byte(unsigned int theAddress, unsigned int theData)
{
    unsigned int    intStatus;
    unsigned int    theStatus;

    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_WRITE_ENABLE);
    FLASH_DISABLE_ACCESS;

    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_BYTE_PGRM);
        MySPI_PutC(theAddress >> 16);
        MySPI_PutC(theAddress >> 8);
        MySPI_PutC(theAddress);
        MySPI_PutC(theData);
    FLASH_DISABLE_ACCESS;

   // Poll the Busy in the Status Register to check the completion of the write sequence
    while(1) {
        FLASH_ENABLE_ACCESS;
            MySPI_PutC(FLASH_READ_STATUS);
            theStatus = MySPI_GetC();
        FLASH_DISABLE_ACCESS;
        if ((theStatus & 0x01) == 0) break;
     }
}

/******************************************************************************/

unsigned int MyFlash_Read_Byte(unsigned int theAddress)
{
    unsigned int    intStatus;
    unsigned int    theData;

    FLASH_ENABLE_ACCESS;
        MySPI_PutC(FLASH_READ);
        MySPI_PutC(theAddress >> 16);
        MySPI_PutC(theAddress >> 8);
        MySPI_PutC(theAddress);
        theData = MySPI_GetC();
    FLASH_DISABLE_ACCESS;
    return (theData);
}

/******************************************************************************/

void MyFlash_Test(void)
{
    unsigned int    intStatus;
    unsigned int    theData, i, n=0;
    char            theStr[64];

    for (i=0; i<8; i++) {
        MyFlash_Program_Byte(i,i);
    }
    for (i=0; i<8; i++) {
        theData = (MyFlash_Read_Byte(i) & 0xff);
        if (theData != i) {
            n++;
         }
         //sprintf(theStr, "Flash Data : 0x%x - 0x%x\n>", i, theData);
         //MyConsole_SendMsg(theStr);
    }
    sprintf(theStr, "Flash Test : %d Error(s)\n>", n);
    MyConsole_SendMsg(theStr);
}

/******************************************************************************/