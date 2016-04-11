/*******************************************************************************
* MyCamera                                                                     *
********************************************************************************
* Description:                                                                 *
* Functions to control the µCAM (Serial JPEG Camera module through the UART3B  *
********************************************************************************
* Version : 1.00 - June 2012                                                   *
*******************************************************************************/


#define  MyCAMERA

#include "MyApp.h"

void MyCamera_Init(void)
{
    mPORTBSetPinsDigitalOut(BIT_14);    // U3BTX - RB14
    mPORTBSetPinsDigitalIn(BIT_8);      // U3BRX - RB8

    int theBaudRate;

    UARTConfigure(UART3B, UART_ENABLE_PINS_TX_RX_ONLY);
    UARTSetFifoMode(UART3B, UART_INTERRUPT_ON_TX_NOT_FULL | UART_INTERRUPT_ON_RX_NOT_EMPTY);
    UARTSetLineControl(UART3B, UART_DATA_SIZE_8_BITS | UART_PARITY_NONE | UART_STOP_BITS_1);
    theBaudRate = UARTSetDataRate(UART3B, GetPeripheralClock(), 56000);
    UARTEnable(UART3B, UART_ENABLE_FLAGS(UART_PERIPHERAL | UART_RX | UART_TX));
    
    // Configure UART3B RX Interrupt
    INTEnable(INT_SOURCE_UART_RX(UART3B), INT_ENABLED);
    INTSetVectorPriority(INT_VECTOR_UART(UART3B), My_INT_UART_PRIORITY);
    INTSetVectorSubPriority(INT_VECTOR_UART(UART3B), My_INT_UART_SUB_PRIORITY);
}

int MyCamera_Start(void)
{
    unsigned int i=0;

    MyCamera_Rx_Index_Wr = 0;
    MyCamera_Rx_Index_Rd = 0;

    for (i=0; i<100; i++) {
        MyCamera_Tx(MyCAMERA_TX_SYNC);
        MyDelayMs(10);
        MyConsole_SendMsg("*");
        if (MyCamera_Rx_Index_Wr > 0) {
            if (!MyCamera_Rx(MyCAMERA_RX_ACK))  return (FALSE);
            if (!MyCamera_Rx(MyCAMERA_RX_SYNC)) return (FALSE);
            MyCamera_Tx(MyCAMERA_TX_ACK);
            return(TRUE);
        };
    }
    return(FALSE);
}

int MyCamera_Reset(void)
{
    MyCamera_Tx(MyCAMERA_TX_RESET);
    MyConsole_SendMsg("Send Reset \n");
    if (!MyCamera_Rx(MyCAMERA_RX_SYNC)) return (FALSE);
    return(TRUE);
}

int MyCamera_Picture(void)
{
    unsigned int theLength, theID=0, theCounter, i, j;
    unsigned char theAck[6];
    unsigned char theStr[64];

    MyCamera_Rx_Index_Wr = 0;
    MyCamera_Rx_Index_Rd = 0;

    // Set Picture Type and Resolution
    MyCamera_Tx(MyCAMERA_TX_INITIAL);
    if (!MyCamera_Rx(MyCAMERA_RX_ACK)) return (FALSE);
    // Set Package Size
    MyCamera_Tx(MyCAMERA_TX_PACKAGE);
    if (!MyCamera_Rx(MyCAMERA_RX_ACK)) return (FALSE);
    // Get a Single Frame
    MyCamera_Tx(MyCAMERA_TX_SNAPSHOT);
    if (!MyCamera_Rx(MyCAMERA_RX_ACK)) return (FALSE);

    MyCamera_Rx_Index_Wr = 0;
    MyCamera_Rx_Index_Rd = 0;

    // Get the Picture
    MyCamera_Tx(MyCAMERA_TX_PICTURE);
    if (!MyCamera_Rx(MyCAMERA_RX_ACK)) return (FALSE);
    if (!MyCamera_Rx(MyCAMERA_RX_DATA)) return (FALSE);

    theLength = (int) MyCamera_Rx_Buffer[11];
    theLength = (theLength << 8) | ((int) MyCamera_Rx_Buffer[10]);
    theLength = (theLength << 8) | ((int) MyCamera_Rx_Buffer[9]);

    sprintf(theStr, "Image Length : %d\n ", theLength);
    MyConsole_SendMsg(theStr);

    MyCamera_Image_Length = 0;

    while(1) {

        MyCamera_Rx_Index_Wr = 0;
        MyCamera_Rx_Index_Rd = 0;
        theCounter = 0;

        theAck[0]=0xAA; theAck[1]=0x0E; theAck[2]=0x00; theAck[3]=0x00;
        theAck[4]=(unsigned char) (theID);
        theAck[5]=(unsigned char) (theID >> 8);
        MyCamera_Tx(theAck);

        theID++;
        if (MyCamera_Image_Length >= theLength) break;

        while(1) {
            if (MyCamera_Rx_Index_Wr >= 5) {
                if (MyCamera_Rx_Index_Wr >= (MyCamera_Rx_Buffer[2] + 6)) {
                    for (i=0; i<MyCamera_Rx_Buffer[2]; i++)
                        MyCamera_Image_Buffer[MyCamera_Image_Length++] = MyCamera_Rx_Buffer[i+4];
                    //MyConsole_SendMsg("µCAM sends Packet\n ");
                    break;
                }
            }
            if (theCounter++ > 500000) {
                MyConsole_SendMsg("µCAM not responding\n ");
                return(FALSE);
            }
        }
    }
    
    MyConsole_SendMsg("Image loaded\n ");
/*
    j=1;
    for (i=0; i<64; i++) {
        sprintf(theStr, "%x ", MyCamera_Image_Buffer[i]);
        MyConsole_SendMsg(theStr);
        if (j==64) { j=1; MyConsole_SendMsg("\n");} else j++;
    }
    MyConsole_SendMsg("\n");
*/
    return(TRUE);
}

void MyCamera_Tx(unsigned char *theBuffer)
{
    int theSize = 6;
    
    while(theSize) {
        while(!UARTTransmitterIsReady(UART3B));
        UARTSendDataByte(UART3B, *theBuffer);
        theBuffer++; theSize--;
    }
    while(!UARTTransmissionHasCompleted(UART3B));
}

int MyCamera_Rx(unsigned char theMessage)
{
    unsigned char theAnswer;
    unsigned char theStr[64];
    unsigned int  theCounter = 0;

    while(1) {

        if ((MyCamera_Rx_Index_Wr - MyCamera_Rx_Index_Rd) >= 6)
        {
            if      ((MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd] == 0xAA)  && (MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd+1] == 0x0E)) theAnswer = MyCAMERA_RX_ACK;
            else if ((MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd] == 0xAA)  && (MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd+1] == 0x0F)) theAnswer = MyCAMERA_RX_NAK;
            else if ((MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd] == 0xAA)  && (MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd+1] == 0x0D)) theAnswer = MyCAMERA_RX_SYNC;
            else if ((MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd] == 0xAA)  && (MyCamera_Rx_Buffer[MyCamera_Rx_Index_Rd+1] == 0x0A)) theAnswer = MyCAMERA_RX_DATA;
            else theAnswer = MyCAMERA_RX_UNKNOWN;

            MyCamera_Rx_Index_Rd += 6;
            if (MyCamera_Rx_Index_Rd >= MyCAMERA_RX_BUFFER_SIZE) MyCamera_Rx_Index_Rd -= MyCAMERA_RX_BUFFER_SIZE;

            switch (theAnswer) {
                case MyCAMERA_RX_ACK     : MyConsole_SendMsg("µCAM sends ACK\n "); break;
                case MyCAMERA_RX_NAK     : MyConsole_SendMsg("µCAM sends NAK\n "); break;
                case MyCAMERA_RX_SYNC    : MyConsole_SendMsg("µCAM sends SYNC\n "); break;
                case MyCAMERA_RX_DATA    : MyConsole_SendMsg("µCAM sends DATA\n "); break;
                case MyCAMERA_RX_UNKNOWN : MyConsole_SendMsg("µCAM sends UNKNOWN\n "); break;
            }

            if (theMessage == theAnswer) return(TRUE); else return(FALSE);
        }

        if (theCounter++ > 500000) break;
    }
    
    MyConsole_SendMsg("µCAM not responding\n ");
    return(FALSE);
}

void MyCamera_Debug(void)
{
    unsigned char theStr[64];
    unsigned int  i;

    sprintf(theStr, "Index_Rd = %d - Index_Wr = %d\n", MyCamera_Rx_Index_Rd, MyCamera_Rx_Index_Wr);
    MyConsole_SendMsg(theStr);
    for (i=0; i<MyCamera_Rx_Index_Wr; i++) {
        sprintf(theStr, "%x ", MyCamera_Rx_Buffer[i]);
        MyConsole_SendMsg(theStr);
    }
    MyConsole_SendMsg("\n");

    unsigned char lineStatus;
    lineStatus = UARTGetLineStatus(UART3B);
    if ( (UART_OVERRUN_ERROR) & lineStatus )
        MyConsole_SendMsg("UART_OVERRUN_ERROR\n ");
}

void __ISR(_UART_3B_VECTOR, My_INT_UART_IPL) _IntUart3BHandler(void)
{
    unsigned char theStr[64];

    // Is this an RX interrupt?
    if (INTGetFlag(INT_SOURCE_UART_RX(UART3B)))
    {
        // Read the byte
        MyCamera_Rx_Buffer[MyCamera_Rx_Index_Wr] = UARTGetDataByte(UART3B);
        
        MyCamera_Rx_Index_Wr++;
        if (MyCamera_Rx_Index_Wr >= MyCAMERA_RX_BUFFER_SIZE) MyCamera_Rx_Index_Wr=0;
        
        // Clear the RX interrupt Flag
        INTClearFlag(INT_SOURCE_UART_RX(UART3B));
    }
    
    // We don't care about TX interrupt
    if ( INTGetFlag(INT_SOURCE_UART_TX(UART3B)) )
    {
        INTClearFlag(INT_SOURCE_UART_TX(UART3B));
    }
}

