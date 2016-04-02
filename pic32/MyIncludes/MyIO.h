/*******************************************************************************
* Header file for MyIO                                                         *
*******************************************************************************/


#ifndef MyIO_H_
#define MyIO_H_

/*******************************************************************************
* Constants                                                                    *
*******************************************************************************/

// 11 Registers associated with the MCP23S09
#define  IODIR     0x00     // IO Direction Register : 1=input
#define  IPOL      0x01     // Input Polarity : 1=inverted
#define  GPINTEN   0x02     // Interrupt-on-Change : 1=enable interrupt
#define  DEFVAL    0x03     // Default Value for Interrupt-on-Change
#define  INTCON    0x04     // Interrupt Control : 1=pin is compared with DEFVAL 0=pin is compared with previous value
#define  IOCON     0x05     // Configuration register (see manual)
#define  GPPU      0x06     // GPIO Pull-up : 1=Pull-up enabled
#define  INTF      0x07     // Interrupt Flag : 1=pin cause interrupt
#define  INTCAP    0x08     // Interrupt captured value for port
#define  GPIO      0x09     // Reflect the value on the port
#define  OLAT      0x0A     // Reflect the value on the output latch

/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void    MyIO_Init(void);
void    MyIO_Write(UINT theAddress, UINT theData);
UINT    MyIO_Read(UINT theAddress);
void    MyIO_Debug(UINT theAddress);
void    MyIO_SetBit(UINT theBit);
void    MyIO_ClearBit(UINT theBit);
void    MyIO_WriteBit(UINT theBit, UINT theValue);
UINT    MyIO_ReadBit(UINT theBit);
void    MyIO_ToggleBit(UINT theBit);
void    MyIO_ConfigBit_Out(UINT theBit, BOOL PullUpEnable);
void    MyIO_ConfigBit_In(UINT theBit);

/*******************************************************************************
* Global Variables for MyIO Functions                                          *
*******************************************************************************/

#ifdef   MyIO


#endif


#endif /* MyIO_H_ */
