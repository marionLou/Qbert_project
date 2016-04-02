/******************************************************************************
 *
 *                Microchip Memory Disk Drive File System
 *
*****************************************************************************/


#ifndef _HARDWAREPROFILE_MDDFS_H_
#define _HARDWAREPROFILE_MDDFS_H_

// Define your clock speed here

    #define RUN_AT_80MHZ

    // Various clock values
   
    //#define GetSystemClock()            (80000000ul)
    //#define GetPeripheralClock()        (GetSystemClock()/2)
    //#define GetInstructionClock()       (GetSystemClock())

    // Clock values

    #define MILLISECONDS_PER_TICK       10                  // Definition for use with a tick timer
    #define TIMER_PRESCALER             TIMER_PRESCALER_8   // Definition for use with a tick timer
    #define TIMER_PERIOD                37500               // Definition for use with a tick timer
    

// Select your interface type
// This library currently only supports a single physical interface layer at a time


// Description: Macro used to enable the SD-SPI physical layer (SD-SPI.c and .h)
#define USE_SD_INTERFACE_WITH_SPI

// Description: Macro used to enable the CF-PMP physical layer (CF-PMP.c and .h)
//#define USE_CF_INTERFACE_WITH_PMP

// Description: Macro used to enable the CF-Manual physical layer (CF-Bit transaction.c and .h)                                                                
//#define USE_MANUAL_CF_INTERFACE

// Description: Macro used to enable the USB Host physical layer (USB host MSD library)
//#define USE_USB_INTERFACE


/*********************************************************************/
/******************* Pin and Register Definitions ********************/
/*********************************************************************/

/* SD Card definitions: Change these to fit your application when using
   an SD-card-based physical layer                                   */

#ifdef USE_SD_INTERFACE_WITH_SPI

//SPI Configuration
#define SPI_START_CFG_1     (PRI_PRESCAL_64_1 | SEC_PRESCAL_8_1 | MASTER_ENABLE_ON | SPI_CKE_ON | SPI_SMP_ON)
#define SPI_START_CFG_2     (SPI_ENABLE)

// Define the SPI frequency
#define SPI_FREQUENCY			(20000000)
    
// Description: SD-SPI Chip Select Output bit
#define SD_CS               LATBbits.LATB13
// Description: SD-SPI Chip Select TRIS bit
#define SD_CS_TRIS          TRISBbits.TRISB13
            
// Description: SD-SPI Card Detect Input bit
#define SD_CD               PORTBbits.RB15
// Description: SD-SPI Card Detect TRIS bit
#define SD_CD_TRIS          TRISBbits.TRISB15

// Description: SD-SPI Write Protect Check Input bit
//#define SD_WE               PORTFbits.RF1
// Description: SD-SPI Write Protect Check TRIS bit
//#define SD_WE_TRIS          TRISFbits.TRISF1
                   
// Description: The main SPI control register
#define SPICON1             SPI1ACON
// Description: The SPI status register
#define SPISTAT             SPI1ASTAT
// Description: The SPI Buffer
#define SPIBUF              SPI1ABUF
// Description: The receive buffer full bit in the SPI status register
#define SPISTAT_RBF         SPI1ASTATbits.SPIRBF
// Description: The bitwise define for the SPI control register (i.e. _____bits)
#define SPICON1bits         SPI1ACONbits
// Description: The bitwise define for the SPI status register (i.e. _____bits)
#define SPISTATbits         SPI1ASTATbits
// Description: The enable bit for the SPI module
#define SPIENABLE           SPI1ACONbits.ON
// Description: The definition for the SPI baud rate generator register (PIC32)
#define SPIBRG              SPI1ABRG

// Tris pins for SCK/SDI/SDO lines

// Description: The TRIS bit for the SCK pin
//#define SPICLOCK            TRISFbits.TRISF6
// Description: The TRIS bit for the SDI pin
//#define SPIIN               TRISFbits.TRISF7
// Description: The TRIS bit for the SDO pin
//#define SPIOUT              TRISFbits.TRISF8

//SPI library functions
//#define putcSPI             putcSPI1A
//#define getcSPI             getcSPI1A
//#define OpenSPI(config1, config2)   OpenSPI1A(config1, config2)
      
// Will generate an error if the clock speed is too low to interface to the card
#if (GetSystemClock() < 100000)
    #error Clock speed must exceed 100 kHz
#endif    

#endif


#ifdef USE_CF_INTERFACE_WITH_PMP

    /* CompactFlash-PMP card definitions: change these to fit your application when
    using the PMP module to interface with CF cards                                */
    
    #ifdef __18CXX
        #error The PIC18 architecture does not currently support PMP interface to CF cards
    #elif defined __dsPIC30F__
    
        // Sample dsPIC30 defines
        
        // Description: The output latch for the CF Reset signal
        #define CF_PMP_RST		    _RD0
        // Description: The TRIS bit for the CF Reset signal
        #define CF_PMP_RESETDIR	    _TRISD0
        // Description: The input port for the CF Ready signal
        #define CF_PMP_RDY	 	    _RD12
        // Description: The TRIS bit for the CF Ready signal
        #define CF_PMP_READYDIR	    _TRISD12
        // Description: The input port for the CF card detect signal
        #define CF_PMP_CD1		    _RC4
        // Description: The TRIS bit for the CF card detect signal
        #define CF_PMP_CD1DIR	    _TRISC4
    
    #elif defined __dsPIC33F__
    
        // Sample dsPIC33 defines

        // Description: The output latch for the CF Reset signal
        #define CF_PMP_RST		    _RD0
        // Description: The TRIS bit for the CF Reset signal
        #define CF_PMP_RESETDIR	    _TRISD0
        // Description: The input port for the CF Ready signal
        #define CF_PMP_RDY	 	    _RD12
        // Description: The TRIS bit for the CF Ready signal
        #define CF_PMP_READYDIR	    _TRISD12
        // Description: The input port for the CF card detect signal
        #define CF_PMP_CD1		    _RC4
        // Description: The TRIS bit for the CF card detect signal
        #define CF_PMP_CD1DIR	    _TRISC4
    
    #elif defined __PIC24F__
    
        // Default case for PIC24F

        // Description: The output latch for the CF Reset signal
        #define CF_PMP_RST		    LATDbits.LATD0
        // Description: The TRIS bit for the CF Reset signal
        #define CF_PMP_RESETDIR	    TRISDbits.TRISD0
        // Description: The input port for the CF Ready signal
        #define CF_PMP_RDY	 	    PORTDbits.RD12
        // Description: The TRIS bit for the CF Ready signal
        #define CF_PMP_READYDIR	    TRISDbits.TRISD12
        // Description: The input port for the CF card detect signal
        #define CF_PMP_CD1		    PORTCbits.RC4
        // Description: The TRIS bit for the CF card detect signal
        #define CF_PMP_CD1DIR	    TRISCbits.TRISC4
    
    #endif
    
    // Description: Defines the PMP data bus direction register
    #define MDD_CFPMP_DATADIR       TRISE
#endif


#ifdef USE_MANUAL_CF_INTERFACE
    // Use these definitions with CF-Bit transaction.c and .h
    // This will manually perform parallel port transactions

    #ifdef __18CXX
    
        // Address lines

        // Description: The CF address bus output latch register (for PIC18)
        #define ADDBL                   LATA
        // Description: The CF address bus TRIS register (for PIC18)
        #define ADDDIR                  TRISA
    	
        // Data bus

        // Description: The Manual CF data bus port register
        #define MDD_CFBT_DATABIN        PORTD
        // Description: The Manual CF data bus output latch register
        #define MDD_CFBT_DATABOUT       LATD
        // Description: The Manual CF data bus TRIS register
        #define MDD_CFBT_DATADIR        TRISD

        // control bus lines

        // Description: The CF card chip select output latch bit
        #define CF_CE                   LATEbits.LATE1
        // Description: The CF card chip select TRIS bit
        #define CF_CEDIR                TRISEbits.TRISE1
        // Description: The CF card output enable strobe latch bit
        #define CF_OE                   LATAbits.LATA5
        // Description: The CF card output enable strobe TRIS bit
        #define CF_OEDIR                TRISAbits.TRISA5
        // Description: The CF card write enable strobe latch bit
        #define CF_WE                   LATAbits.LATA4
        // Description: The CF card write enable strobe TRIS bit
        #define CF_WEDIR                TRISAbits.TRISA4
        // Description: The CF card reset signal latch bit
        #define CF_BT_RST               LATEbits.LATE0
        // Description: The CF card reset signal TRIS bit
        #define CF_BT_RESETDIR          TRISEbits.TRISE0
        // Description: The CF card ready signal port bit
        #define CF_BT_RDY               PORTEbits.RE2
        // Description: The CF card ready signal TRIS bit
        #define CF_BT_READYDIR          TRISEbits.TRISE2
        // Description: The CF card detect signal port bit
        #define CF_BT_CD1               PORTCbits.RC2
        // Description: The CF card detect signal TRIS bit
        #define CF_BT_CD1DIR            TRISCbits.TRISC2
    
    #elif defined __dsPIC30F__
    
        // Address lines

         // Description: The CF address bus bit 0 output latch definition (for PIC24/30/33/32)
        #define ADDR0                   _LATB15
        // Description: The CF address bus bit 1 output latch definition (for PIC24/30/33/32)
        #define	ADDR1                   _LATB14
        // Description: The CF address bus bit 2 output latch definition (for PIC24/30/33/32)
        #define ADDR2                   _LATG9
        // Description: The CF address bus bit 3 output latch definition (for PIC24/30/33/32)
        #define ADDR3                   _LATG8
        // Description: The CF address bus bit 0 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS0                _TRISB15
        // Description: The CF address bus bit 1 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS1                _TRISB14
        // Description: The CF address bus bit 2 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS2                _TRISG9
        // Description: The CF address bus bit 3 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS3                _TRISG8
    	
        // Data bus

        // Description: The Manual CF data bus port register
        #define MDD_CFBT_DATABIN        PORTE
        // Description: The Manual CF data bus output latch register
        #define MDD_CFBT_DATABOUT       PORTE
        // Description: The Manual CF data bus TRIS register
        #define MDD_CFBT_DATADIR        TRISE
    	
        // control bus lines

        // Description: The CF card chip select output latch bit
        #define CF_CE                   _RD11
        // Description: The CF card chip select TRIS bit
        #define CF_CEDIR                _TRISD11
        // Description: The CF card output enable strobe latch bit
        #define CF_OE                   _RD5
        // Description: The CF card output enable strobe TRIS bit
        #define CF_OEDIR                _TRISD5	
        // Description: The CF card write enable strobe latch bit
        #define CF_WE                   _RD4
        // Description: The CF card write enable strobe TRIS bit
        #define CF_WEDIR                _TRISD4
        // Description: The CF card reset signal latch bit
        #define CF_BT_RST               _RD0
        // Description: The CF card reset signal TRIS bit
        #define CF_BT_RESETDIR          _TRISD0
        // Description: The CF card ready signal port bit
        #define CF_BT_RDY               _RD12
        // Description: The CF card ready signal TRIS bit
        #define CF_BT_READYDIR          _TRISD12
        // Description: The CF card detect signal port bit
        #define CF_BT_CD1               _RC4
        // Description: The CF card detect signal TRIS bit
        #define CF_BT_CD1DIR            _TRISC4

    #elif defined __dsPIC33F__

        // Address lines

        // Description: The CF address bus bit 0 output latch definition (for PIC24/30/33/32)
        #define ADDR0                   _LATB15
        // Description: The CF address bus bit 1 output latch definition (for PIC24/30/33/32)
        #define	ADDR1                   _LATB14
        // Description: The CF address bus bit 2 output latch definition (for PIC24/30/33/32)
        #define ADDR2                   _LATG9
        // Description: The CF address bus bit 3 output latch definition (for PIC24/30/33/32)
        #define ADDR3                   _LATG8
        // Description: The CF address bus bit 0 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS0                _TRISB15
        // Description: The CF address bus bit 1 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS1                _TRISB14
        // Description: The CF address bus bit 2 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS2                _TRISG9
        // Description: The CF address bus bit 3 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS3                _TRISG8
    	
        // Data bus

        // Description: The Manual CF data bus port register
        #define MDD_CFBT_DATABIN        PORTE
        // Description: The Manual CF data bus output latch register
        #define MDD_CFBT_DATABOUT       PORTE
        // Description: The Manual CF data bus TRIS register
        #define MDD_CFBT_DATADIR        TRISE
    	
        // control bus lines

        // Description: The CF card chip select output latch bit
        #define CF_CE                   _RD11
        // Description: The CF card chip select TRIS bit
        #define CF_CEDIR                _TRISD11
        // Description: The CF card output enable strobe latch bit
        #define CF_OE                   _RD5
        // Description: The CF card output enable strobe TRIS bit
        #define CF_OEDIR                _TRISD5	
        // Description: The CF card write enable strobe latch bit
        #define CF_WE                   _RD4
        // Description: The CF card write enable strobe TRIS bit
        #define CF_WEDIR                _TRISD4
        // Description: The CF card reset signal latch bit
        #define CF_BT_RST               _RD0
        // Description: The CF card reset signal TRIS bit
        #define CF_BT_RESETDIR          _TRISD0
        // Description: The CF card ready signal port bit
        #define CF_BT_RDY               _RD12
        // Description: The CF card ready signal TRIS bit
        #define CF_BT_READYDIR          _TRISD12
        // Description: The CF card detect signal port bit
        #define CF_BT_CD1               _RC4
        // Description: The CF card detect signal TRIS bit
        #define CF_BT_CD1DIR            _TRISC4
    
    #elif defined __PIC24F__
    
        // Address lines

        // Description: The CF address bus bit 0 output latch definition (for PIC24/30/33/32)
        #define ADDR0                   LATBbits.LATB15
        // Description: The CF address bus bit 1 output latch definition (for PIC24/30/33/32)
        #define	ADDR1                   LATBbits.LATB14
        // Description: The CF address bus bit 2 output latch definition (for PIC24/30/33/32)
        #define ADDR2                   LATGbits.LATG9
        // Description: The CF address bus bit 3 output latch definition (for PIC24/30/33/32)
        #define ADDR3                   LATGbits.LATG8
        // Description: The CF address bus bit 0 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS0                TRISBbits.TRISB15
        // Description: The CF address bus bit 1 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS1                TRISBbits.TRISB14
        // Description: The CF address bus bit 2 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS2                TRISGbits.TRISG9
        // Description: The CF address bus bit 3 TRIS definition (for PIC24/30/33/32)
        #define ADRTRIS3                TRISGbits.TRISG8
    	
        // Data bus

        // Description: The Manual CF data bus port register
        #define MDD_CFBT_DATABIN        PORTE
        // Description: The Manual CF data bus output latch register
        #define MDD_CFBT_DATABOUT       PORTE
        // Description: The Manual CF data bus TRIS register
        #define MDD_CFBT_DATADIR        TRISE
    	
        // control bus lines

        // Description: The CF card chip select output latch bit
        #define CF_CE                   PORTDbits.RD11
        // Description: The CF card chip select TRIS bit
        #define CF_CEDIR                TRISDbits.TRISD11
        // Description: The CF card output enable strobe latch bit
        #define CF_OE                   PORTDbits.RD5
        // Description: The CF card output enable strobe TRIS bit
        #define CF_OEDIR                TRISDbits.TRISD5	
        // Description: The CF card write enable strobe latch bit
        #define CF_WE                   PORTDbits.RD4
        // Description: The CF card write enable strobe TRIS bit
        #define CF_WEDIR                TRISDbits.TRISD4
        // Description: The CF card reset signal latch bit
        #define CF_BT_RST               PORTDbits.RD0
        // Description: The CF card reset signal TRIS bit
        #define CF_BT_RESETDIR          TRISDbits.TRISD0
        // Description: The CF card ready signal port bit
        #define CF_BT_RDY               PORTDbits.RD12
        // Description: The CF card ready signal TRIS bit
        #define CF_BT_READYDIR          TRISDbits.TRISD12
        // Description: The CF card detect signal port bit
        #define CF_BT_CD1               PORTCbits.RC4
        // Description: The CF card detect signal TRIS bit
        #define CF_BT_CD1DIR            TRISCbits.TRISC4
    #endif
#endif

#endif
