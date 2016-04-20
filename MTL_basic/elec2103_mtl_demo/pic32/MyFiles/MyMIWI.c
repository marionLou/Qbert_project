/*******************************************************************************
* MyMIWI                                                                       *
********************************************************************************
* Description:                                                                 *
* Functions to control the Module 802.15.4 - MRF24J40MB                        *
********************************************************************************
* Version : 1.00 - July 2011                                                   *
*******************************************************************************/

/* Modifications to the Microchip MIWI Library : MRF24J40.c
 *
 *  Line 1593 - Routine HighISR
 *      Commment : void __ISR(_EXTERNAL_1_VECTOR, ipl4) _INT1Interrupt(void)
 *      Add      : void __ISR(_EXTERNAL_3_VECTOR, ipl4) _INT3Interrupt(void)
 *
 *  Disable all interrupts during SPI access
 *      PHYSetLongRAMAddr, PHYSetShortRAMAddr, PHYGetShortRAMAddr, PHYGetLongRAMAddr
 */
#define  MyMIWI_NODE1       // #define EUI_0 0x01 in ConfigApp.h
//#define  MyMIWI_NODE2       // #define EUI_0 0x03 in ConfigApp.h

#if defined(MyMIWI_NODE1) && defined(MyMIWI_NODE2)
    #error "Only 1 node must be defined"
#endif
#if !defined(MyMIWI_NODE1) && !defined(MyMIWI_NODE2)
    #error "1 node must be defined"
#endif

#define  MyMIWI

#include "MyApp.h"

void MyMIWI_Init(void) {

    // Configure Pins for MRF24J40MB
    mPORTESetBits(RST_MIWI);
    mPORTESetPinsDigitalOut(RST_MIWI);

    mPORTBSetBits(MIWI_WAKE);
    mPORTBSetPinsDigitalOut(MIWI_WAKE);

    // Configure the INT3 controller for MIWI
    // Set RD10/INT3 as input
    mPORTDSetPinsDigitalIn(BIT_10);
    // Clear corresponding bits in INTCON for falling edge trigger
    INTCONCLR = _INTCON_INT3EP_MASK;
    // Set up interrupt prioirty and sub-priority
    INTSetVectorPriority(INT_EXTERNAL_3_VECTOR, My_INT_EXTERNAL_3_PRIORITY);
    INTSetVectorSubPriority(INT_EXTERNAL_3_VECTOR, My_INT_EXTERNAL_3_SUB_PRIORITY);
    // Clear the interrupt flags
    INTClearFlag(INT_INT3);
    // Enable INT3
    INTEnable(INT_INT3, INT_ENABLED);

    // WARNING : Change in file MRF24J40.c in Microchip Application Library
    // the line : void __ISR(_EXTERNAL_1_VECTOR, ipl4) _INT1Interrupt(void)
    // by       : void __ISR(_EXTERNAL_3_VECTOR, ipl4) _INT3Interrupt(void)
}

void MyMIWI_Start(void) {
    
    BYTE    i;
    char    theStr[64];

    /*******************************************************************/
    // Initialize Microchip proprietary protocol. Which protocol to use
    // depends on the configuration in ConfigApp.h
    /*******************************************************************/
    /*******************************************************************/
    // Function MiApp_ProtocolInit initialize the protocol stack. The
    // only input parameter indicates if previous network configuration
    // should be restored. In this simple example, we assume that the
    // network starts from scratch.
    /*******************************************************************/
    MiApp_ProtocolInit(FALSE);

    // Set default channel
    if( MiApp_SetChannel(myMIWI_Channel) == FALSE )
    {
        Printf("\r\nSelection of channel ");
        PrintDec(myMIWI_Channel);
        Printf(" is not supported in current condition.\r\n");
        return;
    }

    /*******************************************************************/
    // Function MiApp_ConnectionMode defines the connection mode. The
    // possible connection modes are:
    //  ENABLE_ALL_CONN:    Enable all kinds of connection
    //  ENABLE_PREV_CONN:   Only allow connection already exists in
    //                      connection table
    //  ENABL_ACTIVE_SCAN_RSP:  Allow response to Active scan
    //  DISABLE_ALL_CONN:   Disable all connections.
    /*******************************************************************/
    MiApp_ConnectionMode(ENABLE_ALL_CONN);

    /*******************************************************************/
    // Function MiApp_EstablishConnection try to establish a new
    // connection with peer device.
    // The first parameter is the index to the active scan result, which
    //      is acquired by discovery process (active scan). If the value
    //      of the index is 0xFF, try to establish a connection with any
    //      peer.
    // The second parameter is the mode to establish connection, either
    //      direct or indirect. Direct mode means connection within the
    //      radio range; Indirect mode means connection may or may not
    //      in the radio range.
    /*******************************************************************/

#if defined(MyMIWI_NODE1)
    i = MiApp_EstablishConnection(0xFF, CONN_MODE_DIRECT);
#else
    while( (i = MiApp_EstablishConnection(0xFF, CONN_MODE_DIRECT)) == 0xFF );
#endif

    if(i != 0xFF) {
        sprintf(theStr, "Connected Peer  on Channel %d\n>", myMIWI_Channel);
        MyConsole_SendMsg(theStr);
    }
    else {
        
    /*******************************************************************/
    // If no network can be found and join, we need to start a new 
    // network by calling function MiApp_StartConnection
    //
    // The first parameter is the mode of start connection. There are 
    // two valid connection modes:
    //   - START_CONN_DIRECT        start the connection on current 
    //                              channel
    //   - START_CONN_ENERGY_SCN    perform an energy scan first, 
    //                              before starting the connection on 
    //                              the channel with least noise
    //   - START_CONN_CS_SCN        perform a carrier sense scan 
    //                              first, before starting the 
    //                              connection on the channel with 
    //                              least carrier sense noise. Not
    //                              supported for current radios
    //
    // The second parameter is the scan duration, which has the same 
    //     definition in Energy Scan. 10 is roughly 1 second. 9 is a 
    //     half second and 11 is 2 seconds. Maximum scan duration is 
    //     14, or roughly 16 seconds.
    //
    // The third parameter is the channel map. Bit 0 of the 
    //     double word parameter represents channel 0. For the 2.4GHz 
    //     frequency band, all possible channels are channel 11 to 
    //     channel 26. As the result, the bit map is 0x07FFF800. Stack 
    //     will filter out all invalid channels, so the application 
    //     only needs to pay attention to the channels that are not 
    //     preferred.
    /*******************************************************************/
        MiApp_StartConnection(START_CONN_DIRECT, 10, 0);
        MyConsole_SendMsg("Start Connection\n>");
    }

    /*******************************************************************/
    // Function DumpConnection is used to print out the content of the
    //  Connection Entry on the hyperterminal. It may be useful in
    // the debugging phase.
    // The only parameter of this function is the index of the
    // Connection Entry. The value of 0xFF means to print out all
    //  valid Connection Entry; otherwise, the Connection Entry
    // of the input index will be printed out.
    /*******************************************************************/
    DumpConnection(0xFF);
}

/******************************************************************************/

BOOL MyMIWI_RxMsg(char *theMsg) {

    int i;

    /*******************************************************************/
    // Function MiApp_MessageAvailable returns a boolean to indicate if
    //  a packet has been received by the transceiver. If a packet has
    //  been received, all information will be stored in the rxFrame,
    //  structure of RECEIVED_MESSAGE.
    /*******************************************************************/
    if( !MiApp_MessageAvailable() )
        return FALSE;

    /*******************************************************************/
    // If a packet has been received, following code prints out some of
    // the information available in rxMessage.
    /*******************************************************************/
    if( rxMessage.flags.bits.secEn )
        ConsolePutROMString((ROM char *)"Secured ");

    if( rxMessage.flags.bits.broadcast )
        ConsolePutROMString((ROM char *)"Broadcast Packet with RSSI ");
    else
        ConsolePutROMString((ROM char *)"Unicast Packet with RSSI ");

    PrintChar(rxMessage.PacketRSSI);

    if( rxMessage.flags.bits.srcPrsnt ) {
        ConsolePutROMString((ROM char *)" from ");
         if( rxMessage.flags.bits.altSrcAddr ) {
            PrintChar(rxMessage.SourceAddress[1]);
            PrintChar(rxMessage.SourceAddress[0]);
         } else {
            for(i = 0; i < MY_ADDRESS_LENGTH; i++)
                PrintChar(rxMessage.SourceAddress[MY_ADDRESS_LENGTH-1-i]);
         }
    }

    ConsolePutROMString((ROM char *)" : ");
    for(i = 0; i < rxMessage.PayloadSize; i++) {
        ConsolePut(rxMessage.Payload[i]);
        *theMsg++ = rxMessage.Payload[i];
    }
    ConsolePutROMString((ROM char *)"\n");
    *theMsg = '\0';

    /*******************************************************************/
    // Function MiApp_DiscardMessage is used to release the current
    //  received packet.
    // After calling this function, the stack can start to process the
    //  next received frame
    /*******************************************************************/
    MiApp_DiscardMessage();

    return TRUE;
}

/******************************************************************************/

void MyMIWI_TxMsg(BOOL enableBroadcast, char *theMsg)
{
    /*******************************************************************/
    // First call MiApp_FlushTx to reset the Transmit buffer. Then fill
    // the buffer one byte by one byte by calling function
    // MiApp_WriteData
    /*******************************************************************/
    MiApp_FlushTx();
    while (*theMsg != '\0')
        MiApp_WriteData(*theMsg++);

    if (enableBroadcast) {

        /*******************************************************************/
        // Function MiApp_BroadcastPacket is used to broadcast a message
        //    The only parameter is the boolean to indicate if we need to
        //       secure the frame
        /*******************************************************************/
        MiApp_BroadcastPacket(FALSE);

    } else {

        /*******************************************************************/
        // Function MiApp_UnicastConnection is one of the functions to
        //  unicast a message.
        //    The first parameter is the index of Connection Entry for
        //       the peer device. In this demo, since there are only two
        //       devices involved, the peer device must be stored in the
        //       first Connection Entry
        //    The second parameter is the boolean to indicate if we need to
        //       secure the frame. If encryption is applied, the security
        //       key are defined in ConfigApp.h
        //
        // Another way to unicast a message is by calling function
        //  MiApp_UnicastAddress. Instead of supplying the index of the
        //  Connection Entry of the peer device, this function requires the
        //  input parameter of destination address.
        /*******************************************************************/
        if( MiApp_UnicastConnection(0, FALSE) == FALSE )
            Printf("\r\nUnicast Failed\r\n");
    }
}

/******************************************************************************/

// Implementation of MSPI.c

void SPIPut(BYTE v) { MySPI_PutC((unsigned int) v); }
BYTE SPIGet(void)   { return ((BYTE) MySPI_GetC()); }

/******************************************************************************/

void MyMIWI_Task(void) {

    char theData[64], theStr[128];

    if (MyMIWI_RxMsg(theData)) {
        sprintf(theStr, "Receive MIWI Msg '%s'\n>", theData);
        MyConsole_SendMsg(theStr);
        if (strcmp(theData, "Ack MIWI") != 0)
            MyMIWI_TxMsg(myMIWI_EnableBroadcast, "Ack MIWI");
    }
}

/******************************************************************************/