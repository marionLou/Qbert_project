/*************************************************************************
* MyLED                                                                  *
**************************************************************************
* Description:                                                           *
* Functions to control the 2 LED of MyExpansionBoard_Pic32               *
**************************************************************************
* Version : 1.00 - June 2011                                             *
**************************************************************************/

#define  MyLED

#include "MyApp.h"

void MyLED_Init(void)
{
    // RB10 pin has other functions : TMS and VREFOUT
    // To disable JTAG : JTAGEN=0 (bit 3 of DDPCON)
    // To disable output of VREF : CVROE = 0 (bit 6 of CVRCON)
    DDPCON = 0; // Full reset of DEBUG DATA PORT CONTROL REGISTER
    CVRCON = 0; // Full disable of the comparator voltage reference

    // Turn off leds before configuring the IO pin as output
    mPORTBClearBits(BIT_9 | BIT_10 | BIT_11);

    // Set RB9 and RB10 as outputs
    mPORTBSetPinsDigitalOut(BIT_9 | BIT_10 | BIT_11);

}

void MyLED2_Toggle(void)
{
    mPORTBToggleBits(BIT_9);

}

void MyLED1_Toggle(void)
{
    mPORTBToggleBits(BIT_10);
}

void MyLED0_Toggle(void)
{
    mPORTBToggleBits(BIT_11);
}
