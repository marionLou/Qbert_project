/*******************************************************************************
* Header file for MyCAN                                                        *
*******************************************************************************/


#ifndef MyCAN_H_
#define MyCAN_H_

/*******************************************************************************
* Constants                                                                    *
*******************************************************************************/

#define CAN_BUS_SPEED 250000

/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void    MyCAN_Init(void);
BOOL    MyCAN_RxMsg(unsigned *theSID, char *theData);
void    MyCAN_TxMsg(unsigned theSID,  char *theData);
void    MyCAN_Task(void);

/*******************************************************************************
* Global Variables for MyConsole Functions                                     *
*******************************************************************************/

#ifdef   MyCAN
#define  MyCAN_EXT
#else
#define  MyCAN_EXT  extern
#endif

/* Each CAN modulec uses 2 Channels (Channel 0
 * and Channel 1). Each channel is configured
 * to be 8 messages deep. Channel 0 is configured
 * for Transmit and Channel 1 is configured for
 *
 * The size of of the memory buffer is :
 * 2 (Channels) * 8 (Messages Buffers)
 * 16 (bytes/per message buffer) bytes. */

BYTE CAN1MemoryBuffer[2 * 8 * CAN_TX_RX_MESSAGE_SIZE_BYTES];


#endif /* MyCAN_H_ */
