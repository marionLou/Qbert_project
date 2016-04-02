/*********************************************************************
 *
 *	Hardware specific definitions for MyExpansionBoard_Pic32_v1
 *
 *********************************************************************/


#ifndef _HARDWARE_PROFILE_MIWI_H
    #define _HARDWARE_PROFILE_MIWI_H
    
    #include "GenericTypeDefs.h"
    #include "ConfigApp.h"
    
    #define CLOCK_FREQ		(80000000)
    #define RFIF                IFS0bits.INT3IF
    #define RFIE                IEC0bits.INT3IE

    #define PHY_CS              LATEbits.LATE2
    #define PHY_CS_TRIS         TRISEbits.TRISE2
    #define PHY_RESETn          LATEbits.LATE6
    #define PHY_RESETn_TRIS     TRISEbits.TRISE6
    #define PHY_WAKE            LATBbits.LATB5
    #define PHY_WAKE_TRIS       TRISBbits.TRISB5

    #define RF_INT_PIN          PORTDbits.RD10
    #define RF_INT_TRIS         TRISDbits.TRISD10

    #define TMRL TMR2

    #define  MIWI_ENABLE_ACCESS     unsigned int intStatus; \
                                    intStatus = INTDisableInterrupts();

    #define  MIWI_DISABLE_ACCESS    INTRestoreInterrupts(intStatus)
    
#endif
