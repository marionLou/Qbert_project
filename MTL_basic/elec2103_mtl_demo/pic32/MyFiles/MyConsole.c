/*******************************************************************************
* MyConsole                                                                    *
********************************************************************************
* Description:                                                                 *
* Functions to send and receive data from the Console                          *
********************************************************************************
* Version : 1.00 - June 2011                                                   *
*******************************************************************************/

/*  
*   The Console uses UART2A
*       U2ARTS = RG6
*       U2ARX = RG7
*       U2ATX = RG8
*       U2ACTS = RG9
*
*   Install Driver for FDTI chip : http://www.ftdichip.com/Drivers/VCP.htm
*
*   Terminal Emulation on MAC/Linux/PC
*       on MAC : QuickTerm - http://www.macupdate.com/app/mac/19751/quickterm
*       on MAC/Linux : Use 'screen' as a serial terminal emulator : http://hints.macworld.com/article.php?story=20061109133825654
*       on PC : HyperTerminal
*/


#define  MyCONSOLE

#include "MyApp.h"

void MyConsole_Init(void)
{
    UARTConfigure(UART2A, UART_ENABLE_PINS_TX_RX_ONLY);
    UARTSetFifoMode(UART2A, UART_INTERRUPT_ON_TX_NOT_FULL | UART_INTERRUPT_ON_RX_NOT_EMPTY);
    UARTSetLineControl(UART2A, UART_DATA_SIZE_8_BITS | UART_PARITY_NONE | UART_STOP_BITS_1);
    UARTSetDataRate(UART2A, GetPeripheralClock(), 9600);
    UARTEnable(UART2A, UART_ENABLE_FLAGS(UART_PERIPHERAL | UART_RX | UART_TX));

    ptrCmd = theCmd;
}

void MyConsole_SendMsg(const char *theMsg)
{
    while(*theMsg != '\0')
    {
        while(!UARTTransmitterIsReady(UART2A));
        UARTSendDataByte(UART2A, *theMsg);
        theMsg++;
    }
    while(!UARTTransmissionHasCompleted(UART2A));
}

BOOL MyConsole_GetCmd(void)
{
    if (!UARTReceivedDataIsAvailable(UART2A))
        return FALSE;
    *ptrCmd = UARTGetDataByte(UART2A);
    
    // Do echo
    while(!UARTTransmitterIsReady(UART2A));
    UARTSendDataByte(UART2A, *ptrCmd);
    
    switch (*ptrCmd) {
        case '\r':
            *ptrCmd = '\0';
            ptrCmd = theCmd;
            return TRUE;
        case '\n':
            break;
        default:  
//            if ((theCmd+sizeCmd-1) > ptrCmd)
                ptrCmd++;
            break;
    }
    return FALSE;
}

void MyConsole_Task(void)
{
    unsigned char theStr[64];

    if (!MyConsole_GetCmd()) return;

    if (strcmp(theCmd, "MyTest") == 0) {

        MyConsole_SendMsg("MyTest ok\n>");

    } else if (strcmp(theCmd, "MyCAN") == 0) {

        MyCAN_TxMsg(0x200, "0123456");
        MyConsole_SendMsg("Send CAN Msg 0x200 '0123456'\n>");

    } else if (strcmp(theCmd, "MyMIWI-B") == 0) {

        MyMIWI_TxMsg(myMIWI_EnableBroadcast, "0123456");
        MyConsole_SendMsg("Send MIWI Broadcast Msg '0123456'\n>");

    } else if (strcmp(theCmd, "MyMIWI-U") == 0) {

        MyMIWI_TxMsg(myMIWI_DisableBroadcast, "0123456");
        MyConsole_SendMsg("Send MIWI Unicast Msg '0123456'\n>");

    } else if (strcmp(theCmd, "MyPing") == 0) {

        MyPing_Flag = TRUE;

    } else if (strcmp(theCmd, "MyMail") == 0) {

        MyMail_Flag = TRUE;

    } else if (strcmp(theCmd, "MyRTCC") == 0) {

        MyRTCC_SetTime();
        MyRTCC_GetTime();

    } else if (strcmp(theCmd, "MyTime") == 0) {

        MyRTCC_GetTime();

    } else if (strcmp(theCmd, "MyFlash") == 0) {

        MyFlash_Erase();
        MyFlash_Test();

    } else if (strcmp(theCmd, "MyTemp") == 0) {

        int  theTemperature;

        theTemperature = MyTemperature_Read();
        if (theTemperature >= 0x80)
            theTemperature |= 0xffffff00;   // Sign Extend
        sprintf(theStr, "Temperature : %d°\n", theTemperature);
        MyConsole_SendMsg(theStr);

    } else if (strcmp(theCmd, "MyMDDFS") == 0) {

        mPORTBSetPinsDigitalIn(USD_CD);
        MyMDDFS_Test();

    } else if (strcmp(theCmd, "MySlideshow") == 0) {

        mPORTBSetPinsDigitalIn(USD_CD);
        MyConsole_SendMsg("A slideshow will be loaded and displayed on the MTL screen.\n\n\t");
        //The function for loading the slideshow from the SD card is located in MyMDDFS.c.
        MyMDDFS_loadSlideshow(theCmd);

    } else if (strcmp(theCmd, "MyCam_Sync")     == 0) { MyCamera_Start();
    } else if (strcmp(theCmd, "MyCam_Reset")    == 0) { MyCamera_Reset();
    } else if (strcmp(theCmd, "MyCam")          == 0) { MyCamera_Picture();
    } else if (strcmp(theCmd, "MyCam_Debug")    == 0) { MyCamera_Debug();
    } else {
        MyConsole_SendMsg("Unknown Command\n>");
    }
}

/*******************************************************************************
 * Functions needed for Wireless Protocols (MiWI)
 * ****************************************************************************/

ROM unsigned char CharacterArray[]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

void ConsolePutROMString(ROM char* str)
{
    BYTE c;
    while( (c = *str++) )
        ConsolePut(c);
}

void ConsolePut(BYTE c)
{
    while(!UARTTransmitterIsReady(UART2A));
    UARTSendDataByte(UART2A, c);
}

BYTE ConsoleGet(void)
{
    char Temp;
    while(!UARTReceivedDataIsAvailable(UART2A));
    Temp = UARTGetDataByte(UART2A);
    return Temp;
}

void PrintChar(BYTE toPrint)
{
    BYTE PRINT_VAR;
    PRINT_VAR = toPrint;
    toPrint = (toPrint>>4)&0x0F;
    ConsolePut(CharacterArray[toPrint]);
    toPrint = (PRINT_VAR)&0x0F;
    ConsolePut(CharacterArray[toPrint]);
    return;
}

void PrintDec(BYTE toPrint)
{
    ConsolePut(CharacterArray[toPrint/10]);
    ConsolePut(CharacterArray[toPrint%10]);
}
