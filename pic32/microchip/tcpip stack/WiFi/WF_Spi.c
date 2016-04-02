/*******************************************************************************
 *
 * MRF24WB0M Driver SPI interface routines
 * Module for Microchip TCP/IP Stack
 *
 *
 * Written for MyExpansionBoard_Pic32
 *
 ******************************************************************************/

#include "TCPIP Stack/WFMac.h"

/* used for assertions */
#if defined(WF_DEBUG)
    #define WF_MODULE_NUMBER   WF_MODULE_WF_SPI
#endif

static inline __attribute__((__always_inline__)) void WaitForDataByte( void )
{
    while ((WF_SPISTATbits.SPITBF == 1) || (WF_SPISTATbits.SPIRBF == 0));
}


/*****************************************************************************
  Function:
	void WF_SpiInit(void)

  Summary:
	Initializes the SPI interface to the MRF24WB0M device.

  Description:
	Configures the SPI interface for communications with the MRF24WB0M.

  Precondition:
	None

  Parameters:
	None

  Returns:
  	None
  	
  Remarks:
	This function is called by WFHardwareInit.
*****************************************************************************/
void WF_SpiInit(void)
{
    /* We do nothing ! */

    /* Should be : */
    /* enable the SPI clocks            */
    /* set as master                    */
    /* clock idles high                 */
    /* ms bit first                     */
    /* 8 bit tranfer length             */
    /* data changes on falling edge     */
    /* data is sampled on rising edge   */
    /* set the clock divider            */

    /*
    PIC32 SPI clock speed:
    ---------------------
    Fsck =        Fpb
           ------------------
           2 * (SPIxBRG + 1)

    Note that the maximum possible baud rate is
    Fpb/2 (SPIXBRG = 0) and the minimum possible baud
    rate is Fpb /1024.
    */

    //WF_SPI_BRG = (GetPeripheralClock()-1ul)/2ul/WF_MAX_SPI_FREQ;
    //WF_SPICON1 = 0x00000260;    // sample at end, data change idle to active, clock idle high, master
    //WF_SPICON1bits.ON = 1;

}


/******************************************************************************/

int WF_IntStatus;
int WF_SPICON_save;
int WF_SPIBRG_save;

void WF_SpiEnableChipSelect(void)
{     
    /* Disable all Interrupts */
    WF_IntStatus = INTDisableInterrupts();

    /* Save SPI configuration and set WF configuration */
    WF_SPICON_save = WF_SPICON1;
    WF_SPIBRG_save = WF_SPI_BRG;
    WF_SPICON1bits.ON = 0;
    WF_SPI_BRG = (GetPeripheralClock()-1ul)/2ul/WF_MAX_SPI_FREQ;
    WF_SPICON1 = 0x00000260;    // sample at end, data change idle to active, clock idle high, master
    WF_SPICON1bits.ON = 1;

    /* set Slave Select low (enable SPI chip select on MRF24WB0M) */
    WF_CS_IO = 0;
}    


void WF_SpiDisableChipSelect(void)
{   
    /* set Slave Select high ((disable SPI chip select on MRF24WB0M)   */
    WF_CS_IO = 1;

    /* Restore SPI Configuration */
    WF_SPICON1bits.ON = 0;
    WF_SPI_BRG = WF_SPIBRG_save;
    WF_SPICON1 = WF_SPICON_save;
    WF_SPICON1bits.ON = 1;

    /* Restore the Interrupts */
    INTRestoreInterrupts(WF_IntStatus);
}    

/*****************************************************************************
  Function:
	void WFSpiTxRx(void)

  Summary:
	Transmits and receives SPI bytes

  Description:
	Transmits and receives N bytes of SPI data.

  Precondition:
	None

  Parameters:
	p_txBuf - pointer to SPI tx data
	txLen   - number of bytes to Tx
	p_rxBuf - pointer to where SPI rx data will be stored
	rxLen   - number of SPI rx bytes caller wants copied to p_rxBuf

  Returns:
  	None
  	
  Remarks:
	Will clock out the larger of txLen or rxLen, and pad if necessary.
*****************************************************************************/
void MyWFSpiTxRx_NotUsed(UINT8   *p_txBuf,
               UINT16  txLen, 
               UINT8   *p_rxBuf,
               UINT16  rxLen)
{
    UINT16 byteCount;
    UINT16 i;
    UINT8  rxData;


#if defined(WF_DEBUG) && defined(WF_USE_POWER_SAVE_FUNCTIONS)
    /* Cannot communicate with MRF24WB0M when it is in hibernate mode */
    {
        static UINT8 state;  /* avoid local vars in functions called from interrupt */
        WF_GetPowerSaveState(&state);
        WF_ASSERT(state != WF_PS_HIBERNATE);
    }    
#endif 
    
    /* total number of byte to clock is whichever is larger, txLen or rxLen */
    byteCount = (txLen >= rxLen)?txLen:rxLen;
    
    for (i = 0; i < byteCount; ++i)
    {
        /* if still have bytes to transmit from tx buffer */
        if (txLen > 0)
        {
            rxData = (UINT8) MySPI_PutGetC(*p_txBuf++);
            --txLen;
        }
        /* else done writing bytes out from tx buffer */
        else
        {
            rxData = (UINT8) MySPI_PutGetC(0xff);  /* clock out a "don't care" byte */
        }  
        
        /* if still have bytes to read into rx buffer */
        if (rxLen > 0)
        {
            *p_rxBuf++ = rxData;
            --rxLen;
        }
    }    
}                      

void WFSpiTxRx(UINT8   *p_txBuf,
               UINT16  txLen,
               UINT8   *p_rxBuf,
               UINT16  rxLen)
{
    #if defined(__18CXX)
        static UINT16 byteCount;  /* avoid local variables in functions called from interrupt routine */
        static UINT16 i;
        static UINT8  rxTrash;
    #else
        UINT16 byteCount;
        UINT16 i;
        UINT8  rxTrash;
    #endif

#if defined(WF_DEBUG) && defined(WF_USE_POWER_SAVE_FUNCTIONS)
    /* Cannot communicate with MRF24WB0M when it is in hibernate mode */
    {
        static UINT8 state;  /* avoid local vars in functions called from interrupt */
        WF_GetPowerSaveState(&state);
        WF_ASSERT(state != WF_PS_HIBERNATE);
    }
#endif

    /* total number of byte to clock is whichever is larger, txLen or rxLen */
    byteCount = (txLen >= rxLen)?txLen:rxLen;

    for (i = 0; i < byteCount; ++i)
    {
        /* if still have bytes to transmit from tx buffer */
        if (txLen > 0)
        {
            WF_SSPBUF = *p_txBuf++;
            --txLen;
        }
        /* else done writing bytes out from tx buffer */
        else
        {
            WF_SSPBUF = 0xff;  /* clock out a "don't care" byte */
        }

        /* wait until tx/rx byte to completely clock out */
        WaitForDataByte();

        /* if still have bytes to read into rx buffer */
        if (rxLen > 0)
        {
            //*p_rxBuf++ = WF_SSPBUF;  !!!!
            *p_rxBuf++ = WF_SSPBUF;
            --rxLen;
        }
        /* else done reading bytes into rx buffer */
        else
        {
            rxTrash = WF_SSPBUF;  /* read and throw away byte */
        }
    }  /* end for loop */
}