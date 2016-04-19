/*******************************************************************************
* MyCyclone                                                                    *
********************************************************************************
* Description:                                                                 *
* Functions to control the Cyclone IV                                          *
********************************************************************************
* Version : 1.00 - June 2011                                                   *
*******************************************************************************/

#define  MyCYCLONE

#include "MyApp.h"

void MyCyclone_Init(void)
{
    // Configure Reset Pin = GPIO_2[10] = RD7
    mPORTDClearBits(RST_FPGA);
    mPORTDSetPinsDigitalOut(RST_FPGA);

    // Do a Reset
    mPORTDSetBits(RST_FPGA);
    mPORTDClearBits(RST_FPGA);

    // Do Interrupts Initialization
    // Set RD8/INT1 and RD9/INT2 as inputs
    mPORTDSetPinsDigitalIn(BIT_8 | BIT_9);
    // Clear corresponding bits in INTCON for falling edge trigger
    INTCONCLR = _INTCON_INT1EP_MASK | _INTCON_INT2EP_MASK;
    // Set up interrupt prioirty and sub-priority
    INTSetVectorPriority(INT_EXTERNAL_1_VECTOR, My_INT_EXTERNAL_1_PRIORITY);
    INTSetVectorSubPriority(INT_EXTERNAL_1_VECTOR, My_INT_EXTERNAL_1_SUB_PRIORITY);
    INTSetVectorPriority(INT_EXTERNAL_2_VECTOR, My_INT_EXTERNAL_2_PRIORITY);
    INTSetVectorSubPriority(INT_EXTERNAL_2_VECTOR, My_INT_EXTERNAL_2_SUB_PRIORITY);
    // Clear the interrupt flags
    INTClearFlag(INT_INT1);
    INTClearFlag(INT_INT2);
    // Enable INT1 & INT2
    INTEnable(INT_INT1, INT_ENABLED);
    INTEnable(INT_INT2, INT_ENABLED);
    // Enable KEY0 and KEY1 interrupts and IOs of the MyExpansionBoard_IO_v2
    MyCyclone_Write(CYCLONE_CONFIG,CYCLONE_ENABLE_INT_KEY0 | CYCLONE_ENABLE_INT_KEY1 | CYCLONE_ENABLE_IO_AB | CYCLONE_ENABLE_IO_CD);
}

/*******************************************************************************
*	Interrupt handler functions for INT1 and INT2
*******************************************************************************/

void __ISR(_EXTERNAL_1_VECTOR, My_INT_EXTERNAL_1_IPL) _External1InterruptHandler(void)
{
    // Clear the interrupt flags
    INTClearFlag(INT_INT1);
    MyConsole_SendMsg("Interrupt received from INT1 - KEY0 \n>");
}

void __ISR(_EXTERNAL_2_VECTOR, My_INT_EXTERNAL_2_IPL) _External2InterruptHandler(void)
{
    // Clear the interrupt flags
    INTClearFlag(INT_INT2);
    int rd_data; char data_txt[32];
    rd_data = MyCyclone_Read(1);
    sprintf(data_txt, "%d", rd_data);
    MyMIWI_InsertMsg(data_txt);
    MyConsole_SendMsg(data_txt); MyConsole_SendMsg("\n");
    
}

/******************************************************************************/

void MyCyclone_Write(unsigned int theAddress, unsigned int theData)
{
    unsigned int intStatus;

    intStatus = INTDisableInterrupts();
    mPORTEClearBits(CS_FPGA);
    MySPI_PutC(theAddress | 0x80); // Bit 7 = R/W = 1
    MySPI_PutC(theData);
    mPORTESetBits(CS_FPGA);
    INTRestoreInterrupts(intStatus);
}

/******************************************************************************/

unsigned int MyCyclone_Read(unsigned int theAddress)
{
    unsigned int theData;
    unsigned int intStatus;

    intStatus = INTDisableInterrupts();
    mPORTEClearBits(CS_FPGA);
    MySPI_PutC(theAddress & 0x7F);   // Bit 7 = R/W = 0
    theData = MySPI_GetC();
    mPORTESetBits(CS_FPGA);
    INTRestoreInterrupts(intStatus);
    return(theData);
}

/******************************************************************************/

