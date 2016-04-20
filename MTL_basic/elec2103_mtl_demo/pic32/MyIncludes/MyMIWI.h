/*******************************************************************************
* Header file for MyMIWI                                                       *
*******************************************************************************/


#ifndef MyMIWI_H_
#define MyMIWI_H_

/*******************************************************************************
* Constants                                                                    *
*******************************************************************************/

#define myMIWI_Channel              25
#define myMIWI_EnableBroadcast      1
#define myMIWI_DisableBroadcast     0

/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void    MyMIWI_Init(void);
void    MyMIWI_Start(void);
BOOL    MyMIWI_RxMsg(char *theMsg);
void    MyMIWI_TxMsg(BOOL enableBroadcast, char *theMsg);
void    MyMIWI_Task(void);

/*******************************************************************************
* MiApp Interfaces Functions                                                   *
*******************************************************************************/

BOOL    MiApp_ProtocolInit(BOOL bNetworkFreezer);
BOOL    MiApp_SetChannel(BYTE Channel);
void    MiApp_ConnectionMode(BYTE Mode);
BYTE    MiApp_EstablishConnection(BYTE ActiveScanIndex, BYTE Mode);
BOOL    MiApp_MessageAvailable(void);
void    MiApp_DiscardMessage(void);
BOOL    MiApp_BroadcastPacket(BOOL SecEn );
BOOL    MiApp_UnicastConnection(BYTE ConnectionIndex, BOOL SecEn);
BOOL    MiApp_UnicastAddress(BYTE *DestinationAddress, BOOL PermanentAddr, BOOL SecEn);

#define MiApp_FlushTx()     {TxData = PAYLOAD_START;}
#define MiApp_WriteData(a)  TxBuffer[TxData++] = a

#define ENABLE_ALL_CONN         0x00
#define ENABLE_PREV_CONN        0x01
#define ENABLE_ACTIVE_SCAN_RSP  0x02
#define DISABLE_ALL_CONN        0x03

#define CONN_MODE_DIRECT        0x00
#define CONN_MODE_INDIRECT      0x01

#define START_CONN_DIRECT       0x00
#define START_CONN_ENERGY_SCN   0x01
#define START_CONN_CS_SCN       0x02

#define PAYLOAD_START           0

#define MY_ADDRESS_LENGTH       4       // Has to be equal to the value defined in ConfigApp.h

typedef struct
    {
        union
        {
            BYTE Val;
            struct
            {
                BYTE	broadcast:  2;      // 1: broadcast message
                BYTE	ackReq:     1;      // 1: sender request acknowledgement in MAC.
                BYTE	secEn:      1;      // 1: application payload has been secured
                BYTE	repeat:     1;      // 1: message received through a repeater
                BYTE	command:    1;      // 1: message is a command frame
                BYTE    srcPrsnt:   1;      // 1: source address present in the packet
                BYTE    altSrcAddr: 1;      // 1: source address is alternative network address
            } bits;
        }  flags;

        WORD_VAL    SourcePANID;            // PAN Identifier of the sender
        BYTE        *SourceAddress;         // pointer to the source address
        BYTE        *Payload;               // pointer to the application payload
        BYTE        PayloadSize;            // application payload length
        BYTE        PacketRSSI;             // RSSI value of the receive message
        BYTE        PacketLQI;              // LQI value of the received message

} RECEIVED_MESSAGE;

extern RECEIVED_MESSAGE rxMessage;
extern BYTE             TxBuffer[];
extern BYTE             TxData;

/*******************************************************************************
* Global Variables for MyMIWI Functions                                        *
*******************************************************************************/

#ifdef   MyMIWI

/*******************************************************************/
// AdditionalNodeID variable array defines the additional
// information to identify a device on a P2P connection. This array
// will be transmitted with the P2P_CONNECTION_REQUEST command to
// initiate the connection between the two devices. Along with the
// long address of this device, this variable array will be stored
// in the P2P Connection Entry structure of the partner device. The
// size of this array is ADDITIONAL_CONNECTION_PAYLOAD, defined in
// P2PDefs.h.
// In this demo, this variable array is set to be empty.
/******************************************************************/
#define ADDITIONAL_NODE_ID_SIZE   1     // WARNING : Also defined in ConfigApp.h

#if ADDITIONAL_NODE_ID_SIZE > 0
    BYTE AdditionalNodeID[ADDITIONAL_NODE_ID_SIZE] = { 0x00 };
#endif

#endif

#endif /* MyMIWI_H_ */
