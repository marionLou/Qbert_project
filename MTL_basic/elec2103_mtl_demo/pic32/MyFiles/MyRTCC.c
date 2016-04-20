/*******************************************************************************
* MyRTCC                                                                       *
********************************************************************************
* Description:                                                                 *
* Functions to control tje RTCC peripheral (Real-Time Clock and Calendar)      *
********************************************************************************
* Version : 1.00 - July 2011                                                   *
*******************************************************************************/

#define  MyRTCC

#include "MyApp.h"
#include <time.h>

void MyRTCC_Init(void)
{
    // Init the RTCC
    // Wait for the SOSC to be actually running and RTCC to have its clock source
    RtccInit();
    RtccGetClkStat();
    while(RtccGetClkStat()!= RTCC_CLK_ON);   // Could wait here at most 32ms

    // time is MSb: hour, min, sec, rsvd. date is MSb: year, mon, mday, wday.
    // please note that the rsvd field has to be 0 in the time field!
    RtccOpen(0x09000000, 0x11070102, 0);

    // Enable the Alarm with Indefinite Repeat (Chime)
    RtccChimeEnable();
    // Do an alarm every half second
    RtccSetAlarmRpt(RTCC_RPT_HALF_SEC);
    // Enable the alarm
    RtccAlarmEnable();

    // Configure the INT controller for RTCC
    INTSetVectorPriority(INT_RTCC_VECTOR, My_INT_RTCC_PRIORITY);
    INTSetVectorSubPriority(INT_RTCC_VECTOR, My_INT_RTCC_SUB_PRIORITY);
    INTEnable(INT_RTCC, INT_ENABLED);
}

/******************************************************************************/

void MyRTCC_SetTime(void) {

    DWORD       MyUTC;
    struct tm   *ptm;
    rtccTime    MyTime;
    rtccDate    MyDate;

    MyUTC = SNTPGetUTCSeconds();
    ptm = gmtime(&MyUTC);

    MyTime.l = (unsigned char) 0;
    MyTime.sec = (unsigned char)  (((ptm->tm_sec) / 10) << 4) + ((ptm->tm_sec) % 10);
    MyTime.min = (unsigned char)  (((ptm->tm_min) / 10) << 4) + ((ptm->tm_min) % 10);
    MyTime.hour = (unsigned char) (((ptm->tm_hour+2) / 10) << 4) + ((ptm->tm_hour+2) % 10);

    MyDate.wday = (unsigned char) RtccWeekDay(ptm->tm_year - 100, ptm->tm_mon + 1, ptm->tm_mday);
    MyDate.mday = (unsigned char) (((ptm->tm_mday) / 10) << 4) + ((ptm->tm_mday) % 10);
    MyDate.mon = (unsigned char)  (((ptm->tm_mon+1) / 10) << 4) + ((ptm->tm_mon+1) % 10);
    MyDate.year = (unsigned char) (((ptm->tm_year-100) / 10) << 4) + ((ptm->tm_year-100) % 10);

    RtccSetTimeDate(MyTime.l, MyDate.l);
}

/******************************************************************************/

void MyRTCC_GetTime(void) {
    rtccTime    MyTime;
    rtccDate    MyDate;
    char        theStr[64];

    RtccGetTimeDate(&MyTime, &MyDate);

    sprintf(theStr, "%d/%d/%d %d:%d:%d\n",
        ((MyDate.mday >> 4) * 10) + (MyDate.mday % 16),
        ((MyDate.mon  >> 4) * 10) + (MyDate.mon  % 16),
        ((MyDate.year >> 4) * 10) + (MyDate.year % 16),
        ((MyTime.hour >> 4) * 10) + (MyTime.hour % 16),
        ((MyTime.min  >> 4) * 10) + (MyTime.min  % 16),
        ((MyTime.sec  >> 4) * 10) + (MyTime.sec  % 16));
    MyConsole_SendMsg(theStr);
}

/******************************************************************************/

void MyRTCC_Task(void) {
    int theLed, theStatus;

    if (MyRTCC_Flag) {

        MyLED1_Toggle();
        MyLED2_Toggle();

        theLed = (MyCyclone_Read(CYCLONE_LED70) + 1) & 0xf;
        theStatus = MyCyclone_Read(CYCLONE_STATUS) & 0xf0;
        MyCyclone_Write(CYCLONE_LED70,theLed | theStatus);

        MyCyclone_LED = theLed | theStatus;
        MyCyclone_Switch = (theStatus >> 4) & 0xf;

        MyRTCC_Flag = FALSE;
    }
}

/******************************************************************************/

void __ISR(_RTCC_VECTOR, My_INT_RTCC_IPL) _RtccInterruptHandler(void)
{
    // Clear the RTCC int flag
    INTClearFlag(INT_RTCC);

    MyRTCC_Flag = TRUE;
    MyLED0_Toggle();

}

/******************************************************************************/