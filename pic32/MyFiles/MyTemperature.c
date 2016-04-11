/*************************************************************************
* MyTemperature                                                          *
**************************************************************************
* Description:                                                           *
* Functions to control the TC72 Digital Temperature Sensor with SPI      *
**************************************************************************
* Version : 1.00 - Sept 2011                                             *
**************************************************************************/

#define  MyTEMPERATURE

#include "MyApp.h"

/******************************************************************************/

int TC72_IntStatus;
int TC72_SPICON_save;
int TC72_SPIBRG_save;

void TC72_ConfigureSPI(void)
{
    /* Disable all Interrupts */
    TC72_IntStatus = INTDisableInterrupts();

    /* Save SPI configuration and set WF configuration */
    TC72_SPICON_save = SPI1ACON;
    TC72_SPIBRG_save = SPI1ABRG;
    SPI1ACONbits.ON = 0;
    SPI1ABRG = (GetPeripheralClock()-1ul)/2ul/(5000000ul);
    SPI1ACON = 0x00000020;    // SMP=0; CKE=0; CKP=0, master
    SPI1ACONbits.ON = 1;
}


void TC72_RestoreSPI(void)
{
    /* Restore SPI Configuration */
    SPI1ACONbits.ON = 0;
    SPI1ABRG = TC72_SPIBRG_save;
    SPI1ACON = TC72_SPICON_save;
    SPI1ACONbits.ON = 1;

    /* Restore the Interrupts */
    INTRestoreInterrupts(TC72_IntStatus);
}

/******************************************************************************/

void MyTemperature_Init(void)
{
    unsigned int    theControl;
    char            theStr[64];

    TC72_ConfigureSPI();

    mPORTBSetBits(CS_TEMP);
    MySPI_PutC(0x80 | TC72_CONTROL); // A7=1 for Write Operation
    MySPI_PutC(0x00);
    mPORTBClearBits(CS_TEMP);

    TC72_RestoreSPI();

}

int MyTemperature_Read(void)
{
    int             theTemperature = 0;
    char            theStr[64];

    TC72_ConfigureSPI();

    mPORTBSetBits(CS_TEMP);
    MySPI_PutC(TC72_MSB_TEMP);
    theTemperature = MySPI_GetC();
    mPORTBClearBits(CS_TEMP);

    TC72_RestoreSPI();
    return(theTemperature);

}

void MyTemperature_Debug(void)
{
    char            theStr[64];

    TC72_ConfigureSPI();

    mPORTBSetBits(CS_TEMP);
    MySPI_PutC(TC72_CONTROL);
    sprintf(theStr, "Temp Control : 0x%x\n>", MySPI_GetC());
    MyConsole_SendMsg(theStr);
    mPORTBClearBits(CS_TEMP);
    MyDelayMs(10);

    mPORTBSetBits(CS_TEMP);
    MySPI_PutC(TC72_ID);
    sprintf(theStr, "ID  : 0x%x\n>", MySPI_GetC());
    MyConsole_SendMsg(theStr);
    mPORTBClearBits(CS_TEMP);
    MyDelayMs(10);

    mPORTBSetBits(CS_TEMP);
    MySPI_PutC(TC72_MSB_TEMP);
    sprintf(theStr, "MSB  : 0x%x\n>", MySPI_GetC());
    MyConsole_SendMsg(theStr);
    mPORTBClearBits(CS_TEMP);
    MyDelayMs(10);


    mPORTBSetBits(CS_TEMP);
    MySPI_PutC(TC72_LSB_TEMP);
    sprintf(theStr, "LSB  : 0x%x\n>", MySPI_GetC());
    MyConsole_SendMsg(theStr);
    mPORTBClearBits(CS_TEMP);

    TC72_RestoreSPI();

}

