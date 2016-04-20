/*******************************************************************************
* MyCAN                                                                        *
********************************************************************************
* Description:                                                                 *
* Functions to control the CAN1 of MyExpansionBoard_Pic32                      *
* based on the PIC32 CAN TX RX Code Example provided by Microchip
********************************************************************************
* Version : 1.00 - July 2011                                                   *
*******************************************************************************/

#define  MyCAN

#include "MyApp.h"

/* isCAN1MsgReceived is true if CAN1 channel 1 received
 * a message. This flag is updated in the CAN1 ISR. */
static volatile BOOL isCAN1MsgReceived = FALSE;

void MyCAN_Init(void)
{
    CAN_BIT_CONFIG canBitConfig;
    UINT baudPrescalar;

    /* Use the CAN Driver of the PIC32 Boad
     * Active the MCP1253 Regulated Charge Pump for 5V : SDN_5V = 1
     */

    mPORTBSetBits(SDN_5V);
    mPORTBSetPinsDigitalOut(SDN_5V);

    /* Step 1: Switch the CAN module
     * ON and switch it to Configuration
     * mode. Wait till the switch is
     * complete */

    CANEnableModule(CAN1, TRUE);

    CANSetOperatingMode(CAN1, CAN_CONFIGURATION);
    while (CANGetOperatingMode(CAN1) != CAN_CONFIGURATION);

    /* Step 2: Configure the CAN Module Clock. The
     * CAN_BIT_CONFIG data structure is used
     * for this purpose. The propagation segment,
     * phase segment 1 and phase segment 2
     * are configured to have 3TQ. The
     * CANSetSpeed function sets the baud.*/

    canBitConfig.phaseSeg2Tq = CAN_BIT_3TQ;
    canBitConfig.phaseSeg1Tq = CAN_BIT_3TQ;
    canBitConfig.propagationSegTq = CAN_BIT_3TQ;
    canBitConfig.phaseSeg2TimeSelect = TRUE;
    canBitConfig.sample3Time = TRUE;
    canBitConfig.syncJumpWidth = CAN_BIT_2TQ;

    CANSetSpeed(CAN1, &canBitConfig, SYS_FREQ, CAN_BUS_SPEED);

    /* Step 3: Assign the buffer area to the
     * CAN module.
     */

    CANAssignMemoryBuffer(CAN1, CAN1MemoryBuffer, sizeof(CAN1MemoryBuffer));

    /* Step 4: Configure channel 0 for TX and size of
     * 8 message buffers with RTR disabled and low medium
     * priority. Configure channel 1 for RX and size
     * of 8 message buffers and receive the full message.
     */

    CANConfigureChannelForTx(CAN1, CAN_CHANNEL0, 8, CAN_TX_RTR_DISABLED, CAN_LOW_MEDIUM_PRIORITY);
    CANConfigureChannelForRx(CAN1, CAN_CHANNEL1, 8, CAN_RX_FULL_RECEIVE);

    /* Step 5: Configure filters and mask. Configure
     * filter 0 to accept SID messages with ID 0x200 and 0x201 (mask = 0x7FE)
     * Configure filter mask 0 to compare all the ID
     * bits and to filter by the ID type specified in
     * the filter configuration. Messages accepted by
     * filter 0 should be stored in channel 1. */

    CANConfigureFilter(CAN1, CAN_FILTER0, 0x201, CAN_SID);
    CANConfigureFilterMask(CAN1, CAN_FILTER_MASK0, 0x7FE, CAN_SID, CAN_FILTER_MASK_IDE_TYPE);
    CANLinkFilterToChannel(CAN1, CAN_FILTER0, CAN_FILTER_MASK0, CAN_CHANNEL1);
    CANEnableFilter(CAN1, CAN_FILTER0, TRUE);

    /* Step 6: Enable interrupt and events. Enable the receive
     * channel not empty event (channel event) and the receive
     * channel event (module event).
     * The interrrupt peripheral library is used to enable
     * the CAN interrupt to the CPU. */

    CANEnableChannelEvent(CAN1, CAN_CHANNEL1, CAN_RX_CHANNEL_NOT_EMPTY, TRUE);
    CANEnableModuleEvent(CAN1, CAN_RX_EVENT, TRUE);

    /* These functions are from interrupt peripheral
     * library. */

    INTSetVectorPriority(INT_CAN_1_VECTOR, My_INT_CAN_1_PRIORITY);
    INTSetVectorSubPriority(INT_CAN_1_VECTOR, My_INT_CAN_1_SUB_PRIORITY);
    INTEnable(INT_CAN1, INT_ENABLED);

    /* Step 7: Switch the CAN mode
     * to normal mode. */

    CANSetOperatingMode(CAN1, CAN_NORMAL_OPERATION);
    while (CANGetOperatingMode(CAN1) != CAN_NORMAL_OPERATION);

}

/******************************************************************************/

BOOL MyCAN_RxMsg(unsigned *theSID, char *theData)
{
    /* This function will check if a CAN
     * message is available in CAN1 channel 1 */

    CANRxMessageBuffer * theMsg;
    unsigned i;

    if (isCAN1MsgReceived == FALSE) {
        /* CAN1 did not receive any message so
         * exit the function. Note that the
         * isCAN1MsgReceived flag is updated
         * by the CAN1 ISR. */

        return(FALSE);
    }

    /* Message was received. Reset message received flag to catch
     * the next message and read the message. Note that
     * you could also check the CANGetRxMessage function
     * return value for null to check if a message has
     * been received. */

    isCAN1MsgReceived = FALSE;

    theMsg = CANGetRxMessage(CAN1, CAN_CHANNEL1);

    *theSID = theMsg->msgSID.SID;
    for (i=0; i<8; i++)
        *theData++ = theMsg->data[i];

    /* Call the CANUpdateChannel() function to let
     * CAN 1 module know that the message processing
     * is done. Enable the receive channale not empty event
     * so that the CAN module generates an interrupt when
     * the event occurs the next time.*/

    CANUpdateChannel(CAN1, CAN_CHANNEL1);
    CANEnableChannelEvent(CAN1, CAN_CHANNEL1, CAN_RX_CHANNEL_NOT_EMPTY, TRUE);

    return(TRUE);
}
/******************************************************************************/

void MyCAN_TxMsg(unsigned theSID, char *theData)
{
    unsigned i;

    /* This function will send a message to
     * CAN2 with SID 202. The data payload
     * size is 1 byte. The value of the LED5Status
     * will be toggled and then sent as
     * the payload. CAN1 Channel 0 is used
     * to send the message */

    CANTxMessageBuffer * message;

    /* Get a pointer to the next buffer in the channel
     * check if the returned value is null. */

    message = CANGetTxMessageBuffer(CAN1, CAN_CHANNEL0);

    if (message != NULL) {

        /* Form a Standard ID CAN message.
         * Start by clearing the buffer.
         * Send message to CAN2.
         * IDE = 0 means Standard ID message.
         * Send 7 bytes of data.
         * This is the payload.	*/


        message->messageWord[0] = 0;
        message->messageWord[1] = 0;
        message->messageWord[2] = 0;
        message->messageWord[3] = 0;

        message->msgSID.SID = theSID;
        message->msgEID.IDE = 0;
        message->msgEID.DLC = 8; // Data Length Control, valid values are 0-8

        for (i=0; i<8; i++)
            message->data[i] = *theData++;

        /* This function lets the CAN module
         * know that the message processing is done
         * and message is ready to be processed. */

        CANUpdateChannel(CAN1, CAN_CHANNEL0);

        /* Direct the CAN module to flush the
         * TX channel. This will send any pending
         * message in the TX channel. */

        CANFlushTxChannel(CAN1, CAN_CHANNEL0);
    }
}

/******************************************************************************/

void MyCAN_Task(void) {

    unsigned theSID;
    char theData[64], theStr[64];
    
    if (MyCAN_RxMsg(&theSID, theData)) {
        sprintf(theStr, "Receive CAN Msg 0x%x '%s'\n>", theSID, theData);
        MyConsole_SendMsg(theStr);
        if (theSID == 0x200)
            MyCAN_TxMsg(0x201, theData);
    }
}

/******************************************************************************/

void __ISR(_CAN_1_VECTOR, My_INT_CAN_1_IPL) _CAN1InterruptHandler(void)
{
    /* This is the CAN1 Interrupt Handler.
     * Note that there are many source events in the
     * CAN1 module for this interrupt. These
     * events are enabled by the  CANEnableModuleEvent()
     * function. In this example, only the RX_EVENT
     * is enabled. */


    /* Check if the source of the interrupt is
     * RX_EVENT. This is redundant since only this
     * event is enabled in this example but
     * this shows one scheme for handling events. */

    if ((CANGetModuleEvent(CAN1) & CAN_RX_EVENT) != 0) {

        /* Within this, you can check which channel caused the
         * event by using the CANGetModuleEvent() function
         * which returns a code representing the highest priority
         * pending event. */

        if (CANGetPendingEventCode(CAN1) == CAN_CHANNEL1_EVENT) {
            /* This means that channel 1 caused the event.
             * The CAN_RX_CHANNEL_NOT_EMPTY event is persistent. You
             * could either read the channel in the ISR
             * to clear the event condition or as done
             * here, disable the event source, and set
             * an application flag to indicate that a message
             * has been received. The event can be
             * enabled by the application when it has processed
             * one message.
             *
             * Note that leaving the event enabled would
             * cause the CPU to keep executing the ISR since
             * the CAN_RX_CHANNEL_NOT_EMPTY event is persistent (unless
             * the not empty condition is cleared.)
             * */

            CANEnableChannelEvent(CAN1, CAN_CHANNEL1, CAN_RX_CHANNEL_NOT_EMPTY, FALSE);
            isCAN1MsgReceived = TRUE;
            MyConsole_SendMsg("Interrupt received from CAN1 - Msg received \n>");
        }
    }

    /* The CAN1 Interrupt flag is  cleared at the end of the
     * interrupt routine. This is because the event source
     * that could have caused this interrupt  to occur
     * (CAN_RX_CHANNEL_NOT_EMPTY) is disabled. Attempting to
     * clear the CAN1 interrupt flag when the the CAN_RX_CHANNEL_NOT_EMPTY
     * interrupt is enabled will not have any effect because the
     * base event is still present. */

    INTClearFlag(INT_CAN1);

}

/******************************************************************************/

