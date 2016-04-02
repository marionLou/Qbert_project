/*******************************************************************************
* Header file for MyUART                                                       *
*******************************************************************************/


#ifndef MyCAMERA_H_
#define MyCAMERA_H_


/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void MyCamera_Init(void);
int  MyCamera_Start(void);
int  MyCamera_Reset(void);
int  MyCamera_Picture(void);
void MyCamera_Debug(void);
void MyCamera_Tx(unsigned char *theChar);
int  MyCamera_Rx(unsigned char theAnwer);

/*******************************************************************************
* µCAM Commands                                                                *
*******************************************************************************/

#define MyCAMERA_TX_ACK         "\xAA\x0E\x0D\x00\x00\x00"
#define MyCAMERA_TX_SYNC        "\xAA\x0D\x00\x00\x00\x00"
#define MyCAMERA_TX_RESET       "\xAA\x08\x00\x00\x00\x00"
#define MyCAMERA_TX_INITIAL     "\xAA\x01\x00\x07\x07\x07"
#define MyCAMERA_TX_PACKAGE     "\xAA\x06\x08\x00\x01\x00"
#define MyCAMERA_TX_SNAPSHOT    "\xAA\x05\x00\x00\x00\x00"
#define MyCAMERA_TX_PICTURE     "\xAA\x04\x01\x00\x00\x00"

#define MyCAMERA_RX_ACK     1
#define MyCAMERA_RX_NAK     2
#define MyCAMERA_RX_SYNC    3
#define MyCAMERA_RX_DATA    4
#define MyCAMERA_RX_UNKNOWN 5


/*******************************************************************************
* Global Variables for MyCamera Functions                                      *
*******************************************************************************/
#define MyCAMERA_RX_BUFFER_SIZE    512
#define MyCAMERA_IMAGE_BUFFER_SIZE 65536

#ifdef   MyCAMERA

unsigned int   MyCamera_Rx_Index_Wr =0;
unsigned int   MyCamera_Rx_Index_Rd =0; 
unsigned char  MyCamera_Rx_Buffer[MyCAMERA_RX_BUFFER_SIZE];

#define  MyCAMERA_EXT
#define  MyCAMERA_INIT =0

#else
#define  MyCAMERA_EXT  extern
#define  MyCAMERA_INIT

#endif

MyCAMERA_EXT unsigned char MyCamera_Image_Buffer[MyCAMERA_IMAGE_BUFFER_SIZE];
MyCAMERA_EXT unsigned int  MyCamera_Image_Length MyCAMERA_INIT;

#endif /* MyCAMERA_H_ */