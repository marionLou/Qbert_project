/*******************************************************************************
* Header file for MyWIFI                                                       *
*******************************************************************************/


#ifndef MyWIFI_H_
#define MyWIFI_H_

/*******************************************************************************
* Constants                                                                    *
*******************************************************************************/


/*******************************************************************************
* Functions Prototypes and Structures                                          *
*******************************************************************************/

void    MyWIFI_Init(void);
void    MyWIFI_Start(void);
void    MyWIFI_InitAppConfig(void);
void    MyWIFI_Connect(void);
void    MyWIFI_Task(void);
void    MyWIFI_SMTP(void);
void    MyWIFI_Ping(void);

// Define a header structure for validating the AppConfig data structure in EEPROM/Flash
typedef struct
{
	unsigned short wConfigurationLength;	// Number of bytes saved in EEPROM/Flash (sizeof(APP_CONFIG))
	unsigned short wOriginalChecksum;		// Checksum of the original AppConfig defaults as loaded from ROM (to detect when to wipe the EEPROM/Flash record of AppConfig due to a stack change, such as when switching from Ethernet to Wi-Fi)
	unsigned short wCurrentChecksum;		// Checksum of the current EEPROM/Flash data.  This protects against using corrupt values if power failure occurs while writing them and helps detect coding errors in which some other task writes to the EEPROM in the AppConfig area.
} NVM_VALIDATION_STRUCT;

/*******************************************************************************
* Global Variables for MyWIFI Functions                                        *
*******************************************************************************/

#ifdef   MyWIFI

// Declare AppConfig structure and some other supporting stack variables
APP_CONFIG AppConfig;
static unsigned short wOriginalAppConfigChecksum;	// Checksum of the ROM defaults for AppConfig
BYTE AN0String[8];

#endif

#if defined(MyWIFI) || defined(MyHTTP)
    // Declare here because we need "TCPIP Stack/TCPIP.h"
    void    MyWIFI_SaveAppConfig(const APP_CONFIG *ptrAppConfig);
#endif

#endif /* MyWIFI_H_ */
