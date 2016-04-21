/*******************************************************************************
* Header file for MyConsole                                                    *
*******************************************************************************/


#ifndef MyCONSOLE_H_
#define MyCONSOLE_H_


/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void MyConsole_Init(void);
void MyConsole_SendMsg(const char *theMsg);
BOOL MyConsole_GetCmd(void);
void MyConsole_Task(void);

// Functions needed for Wireless Protocols (MiWI)

#define	ROM const

#define ConsoleInit()               // The initialization is done elsewhere
#define ConsoleIsPutReady() 1       // Not useful
#define ConsoleIsGetReady() 1       // Not useful

void ConsolePut(BYTE c);
BYTE ConsoleGet(void);
void PrintChar(BYTE);
void PrintDec(BYTE);
void ConsolePutROMString(ROM char* str);

#define Printf(x) ConsolePutROMString((ROM char*)x)

/*******************************************************************************
* Global Variables for MyConsole Functions                                     *
*******************************************************************************/

#ifdef   MyCONSOLE

char theCmd[64], *ptrCmd;

#endif


#endif /* MyCONSOLE_H_ */