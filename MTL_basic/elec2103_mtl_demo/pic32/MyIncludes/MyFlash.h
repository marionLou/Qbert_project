/*******************************************************************************
* Header file for MyFlash                                                      *
*******************************************************************************/


#ifndef MyFLASH_H_
#define MyFLASH_H_

/*******************************************************************************
* Constants                                                                    *
*******************************************************************************/

// Flash Instructions
#define  FLASH_READ             0x03     // Read Memory
#define  FLASH_HS_READ          0x0B     // Read Memory at higher speed
#define  FLASH_4K_ERASE         0x20     // Erase 4 KByte of memory array
#define  FLASH_32K_ERASE        0x52     // Erase 32 KByte block of memory array
#define  FLASH_64K_ERASE        0xD8     // Erase 64 KByte block of memory array
#define  FLASH_CHIP_ERASE       0xC7     // Erase Full Memory Array
#define  FLASH_BYTE_PGRM        0x02     // To Program One Data Byte
#define  FLASH_AAI_WORD_PGRM    0xAD     // Auto Adddress Increment Programming
#define  FLASH_READ_STATUS      0x05     // Read Status Register
#define  FLASH_EN_WR_STATUS     0x50     // Enble Write Status Register
#define  FLASH_WRITE_STATUS     0x01     // Write Status Register
#define  FLASH_WRITE_ENABLE     0x06     // Write Enable
#define  FLASH_WRITE_DISABLE    0x04     // Write Disable
#define  FLASH_READ_ID          0x90     // Read ID
#define  FLASH_JEDEC_ID_READ    0x9F     // Read JEDEC ID

#define  FLASH_ENABLE_ACCESS    intStatus = INTDisableInterrupts(); \
                                mPORTEClearBits(CS_FLASH)

#define  FLASH_DISABLE_ACCESS   mPORTESetBits(CS_FLASH);            \
                                INTRestoreInterrupts(intStatus)

/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void            MyFlash_Init(void);
void            MyFlash_Test(void);
void            MyFlash_Erase(void);
void            MyFlash_Program_Byte(unsigned int theAddress, unsigned int theData);
unsigned int    MyFlash_Read_Byte(unsigned int theAddress);

/*******************************************************************************
* Global Variables for MyFlash Functions                                       *
*******************************************************************************/

#ifdef   MyFLASH

#endif


#endif /* MyFLASH_H_ */
