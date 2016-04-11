/*******************************************************************************
* Header file for MyTEMPERATURE                                                *
*******************************************************************************/

#ifndef MyTEMPERATURE_H_
#define MyTEMPERATURE_H_

/*******************************************************************************
* Constants                                                                    *
*******************************************************************************/

// TC72 Registers
#define  TC72_CONTROL       0x00
#define  TC72_LSB_TEMP      0x01
#define  TC72_MSB_TEMP      0x02
#define  TC72_ID            0x03

/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void MyTemperature_Init(void);
int  MyTemperature_Read(void);
void MyTemperature_Debug(void);

#endif /* MyTEMPERATURE_H_ */
