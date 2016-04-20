/*******************************************************************************
* MyIO                                                                         *
********************************************************************************
* Description:                                                                 *
* Functions to control the IO MCP23S09                                         *
* Configuration for the MyApp_Sensor                                           *
********************************************************************************
* Version : 1.01 - Aug 2012                                                    *
*******************************************************************************/

#define  MyIO

#include "MyApp.h"

void MyIO_Init(void)
{
    // Configure Reset Pin (PortE)
    mPORTESetBits(RST_IO);
    mPORTESetPinsDigitalOut(RST_IO);

    // Do a Reset
    mPORTEClearBits(RST_IO);
    mPORTESetBits(RST_IO);

    // Default Configuration
    
    MyIO_Write(IODIR, 0xFF);    // GP7-0 as input
    MyIO_Write(IPOL, 0x00);     // No inversion for inputs
    MyIO_Write(GPINTEN, 0x00);  // Disable interrupt
    MyIO_Write(DEFVAL, 0x00);   // Not used
    MyIO_Write(INTCON, 0x00);   // Comparison with previous value
    MyIO_Write(GPPU,0x00);      // No pull-up
    MyIO_Write(OLAT,0x00);      // Initial value for GP7-0 = 0

    // Configuration Register
    // Bit 5 = SEQOP = 1 = Sequential operation disabled
    // Bit 2 = ODR = 0 = Active driver output for INT pin
    // Bit 1 = INTPOL = 0 = Active low INT pin
    // Bit 0 = INTCC = 0 = Reading GPIO register clears the interrupt
    MyIO_Write(IOCON,0x20);

    // Configure the INT0 controller for IO
    // Set RD0/INT0 as inputs
    mPORTDSetPinsDigitalIn(BIT_0);
    // Clear corresponding bits in INTCON for falling edge trigger
    INTCONCLR = _INTCON_INT0EP_MASK;
    // Set up interrupt prioirty and sub-priority
    INTSetVectorPriority(INT_EXTERNAL_0_VECTOR, My_INT_EXTERNAL_0_PRIORITY);
    INTSetVectorSubPriority(INT_EXTERNAL_0_VECTOR, My_INT_EXTERNAL_0_SUB_PRIORITY);
    // Clear the interrupt flags
    INTClearFlag(INT_INT0);
    // Enable INT0
    INTEnable(INT_INT0, INT_ENABLED);
}

/******************************************************************************/

void __ISR(_EXTERNAL_0_VECTOR, My_INT_EXTERNAL_0_IPL) _External0InterruptHandler(void)
{
    UINT theGPIO;

    // Clear the interrupt flag
    INTClearFlag(INT_INT0);
    // Set GP6 as GP3
    theGPIO = MyIO_Read(GPIO);
    theGPIO = ~(theGPIO << 3);
    MyIO_Write(OLAT, theGPIO);

    MyConsole_SendMsg("Interrupt received from INT0 - IO \n>");
}

/******************************************************************************/

void MyIO_Write(UINT theAddress, UINT theData)
{
    unsigned int intStatus;

    intStatus = INTDisableInterrupts();
    mPORTEClearBits(CS_IO);
    MySPI_PutC(0x40);           // 0100000 R/W=0
    MySPI_PutC(theAddress);
    MySPI_PutC(theData);
    mPORTESetBits(CS_IO);
    INTRestoreInterrupts(intStatus);
}

/******************************************************************************/

UINT MyIO_Read(UINT theAddress)
{
    unsigned int theData;
    unsigned int intStatus;

    intStatus = INTDisableInterrupts();
    mPORTEClearBits(CS_IO);
    MySPI_PutC(0x41);           // 0100000 R/W=1
    MySPI_PutC(theAddress);
    theData = MySPI_GetC();
    mPORTESetBits(CS_IO);
    INTRestoreInterrupts(intStatus);
    return(theData);
}

/******************************************************************************/

void MyIO_Debug(UINT theAddress)
{
    char theStr[256];

    sprintf(theStr, "MyIO_Reg %d  : 0x%x\n>", theAddress, MyIO_Read(theAddress));
    MyConsole_SendMsg(theStr);
}

/******************************************************************************/

void MyIO_SetBit(UINT theBit)
{
    MyIO_Write(OLAT , MyIO_Read(OLAT) | theBit);
}

void MyIO_ClearBit(UINT theBit)
{
    MyIO_Write(OLAT , MyIO_Read(OLAT) & ~theBit);
}

void MyIO_WriteBit(UINT theBit, UINT theValue)
{
    if (theValue == 0)
         MyIO_ClearBit(theBit);
    else MyIO_SetBit(theBit);
}

UINT MyIO_ReadBit(UINT theBit)
{
    if ((MyIO_Read(GPIO) & theBit) == 0) return (0);
    else return (1);
}

void MyIO_ToggleBit(unsigned int theBit)
{
    if ((MyIO_Read(OLAT) & theBit) == 0)
         MyIO_SetBit(theBit);
    else MyIO_ClearBit(theBit);
}

void MyIO_ConfigBit_Out(UINT theBit, BOOL PullUpEnable)
{
    MyIO_Write(IODIR , MyIO_Read(IODIR) & ~theBit); // Clear bit for Output
    if (PullUpEnable)
         MyIO_Write(GPPU , MyIO_Read(GPPU) | theBit);   // Set bit for Pull-Up Enable
    else MyIO_Write(GPPU , MyIO_Read(GPPU) & ~theBit);  // Clear bit for Pull-Up Disable
}

void MyIO_ConfigBit_In(UINT theBit)
{
    MyIO_Write(IODIR , MyIO_Read(IODIR) | theBit); // Set bit for Input
}

/******************************************************************************/