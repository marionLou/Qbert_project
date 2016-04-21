/*******************************************************************************
* MyWIFI                                                                       *
********************************************************************************
* Description:                                                                 *
* Functions to control the Module Wifi - MRF24WB0MA                            *
********************************************************************************
* Version : 1.00 - July 2011                                                   *
*******************************************************************************/

#define  MyWIFI

/*
 * This macro uniquely defines this file as the main entry point.
 * There should only be one such definition in the entire project,
 * and this file must define the AppConfig variable as described below.
 */
#define THIS_IS_STACK_APPLICATION

// Address that ICMP client will ping.  If the DNS client module is not available in the stack, then this hostname is ignored and the local gateway IP address will be pinged instead.
#define HOST_TO_PING	"ww1.microchip.com"

// Include all headers for any enabled TCPIP Stack functions
#include "TCPIP Stack/TCPIP.h"

#include "MyApp.h"

// Used for Wi-Fi assertions
#define WF_MODULE_NUMBER   WF_MODULE_MAIN_DEMO

/******************************************************************************/

void MyWIFI_Init(void) {

    // Configure Pins for MRF24J40MB
    mPORTESetBits(RST_WIFI);
    mPORTESetPinsDigitalOut(RST_WIFI);

    mPORTBSetBits(WIFI_HIB);
    mPORTBSetPinsDigitalOut(WIFI_HIB);

    mPORTBClearBits(WIFI_WP);                // Has to be pulled low
    mPORTBSetPinsDigitalOut(WIFI_WP);
/*
    // Configure the INT4 controller for WIFI
    // Set RD11/INT4 as input
    mPORTDSetPinsDigitalIn(BIT_11);
    // Clear corresponding bits in INTCON for falling edge trigger
    INTCONCLR = _INTCON_INT4EP_MASK;
    // Set up interrupt prioirty and sub-priority
    INTSetVectorPriority(INT_EXTERNAL_4_VECTOR, My_INT_EXTERNAL_4_PRIORITY);
    INTSetVectorSubPriority(INT_EXTERNAL_4_VECTOR, My_INT_EXTERNAL_4_SUB_PRIORITY);
    // Clear the interrupt flags
    INTClearFlag(INT_INT4);
    // Enable INT4
    INTEnable(INT_INT4, INT_ENABLED);
 */
}

void MyWIFI_Start(void) {
        
    // Initialize stack-related hardware components
    TickInit();
    #if defined(STACK_USE_MPFS2)
        MPFSInit();
    #endif

    // Initialize Stack and application related NV variables into AppConfig.
    MyWIFI_InitAppConfig();

    // Initialize core stack layers (MAC, ARP, TCP, UDP) and
    // application modules (HTTP, SNMP, etc.)
    StackInit();

    // Connect to the my WIFI Network
    MyWIFI_Connect();
}

/******************************************************************************/

static ROM BYTE SerializedMACAddress[6] = {MY_DEFAULT_MAC_BYTE1, MY_DEFAULT_MAC_BYTE2, MY_DEFAULT_MAC_BYTE3, MY_DEFAULT_MAC_BYTE4, MY_DEFAULT_MAC_BYTE5, MY_DEFAULT_MAC_BYTE6};

void MyWIFI_InitAppConfig(void) {

    // Start out zeroing all AppConfig bytes to ensure all fields are
    // deterministic for checksum generation
    memset((void*) &AppConfig, 0x00, sizeof (AppConfig));

    AppConfig.Flags.bIsDHCPEnabled = TRUE;
    AppConfig.Flags.bInConfigMode = TRUE;
    memcpypgm2ram((void*) &AppConfig.MyMACAddr, (ROM void*) SerializedMACAddress, sizeof (AppConfig.MyMACAddr));

    AppConfig.MyIPAddr.Val = MY_DEFAULT_IP_ADDR_BYTE1 | MY_DEFAULT_IP_ADDR_BYTE2 << 8ul | MY_DEFAULT_IP_ADDR_BYTE3 << 16ul | MY_DEFAULT_IP_ADDR_BYTE4 << 24ul;
    AppConfig.DefaultIPAddr.Val = AppConfig.MyIPAddr.Val;
    AppConfig.MyMask.Val = MY_DEFAULT_MASK_BYTE1 | MY_DEFAULT_MASK_BYTE2 << 8ul | MY_DEFAULT_MASK_BYTE3 << 16ul | MY_DEFAULT_MASK_BYTE4 << 24ul;
    AppConfig.DefaultMask.Val = AppConfig.MyMask.Val;
    AppConfig.MyGateway.Val = MY_DEFAULT_GATE_BYTE1 | MY_DEFAULT_GATE_BYTE2 << 8ul | MY_DEFAULT_GATE_BYTE3 << 16ul | MY_DEFAULT_GATE_BYTE4 << 24ul;
    AppConfig.PrimaryDNSServer.Val = MY_DEFAULT_PRIMARY_DNS_BYTE1 | MY_DEFAULT_PRIMARY_DNS_BYTE2 << 8ul | MY_DEFAULT_PRIMARY_DNS_BYTE3 << 16ul | MY_DEFAULT_PRIMARY_DNS_BYTE4 << 24ul;
    AppConfig.SecondaryDNSServer.Val = MY_DEFAULT_SECONDARY_DNS_BYTE1 | MY_DEFAULT_SECONDARY_DNS_BYTE2 << 8ul | MY_DEFAULT_SECONDARY_DNS_BYTE3 << 16ul | MY_DEFAULT_SECONDARY_DNS_BYTE4 << 24ul;


    // SNMP Community String configuration
    #if defined(STACK_USE_SNMP_SERVER)
    {
        BYTE i;
        static ROM char * ROM cReadCommunities[] = SNMP_READ_COMMUNITIES;
        static ROM char * ROM cWriteCommunities[] = SNMP_WRITE_COMMUNITIES;
        ROM char * strCommunity;

        for (i = 0; i < SNMP_MAX_COMMUNITY_SUPPORT; i++) {
            // Get a pointer to the next community string
            strCommunity = cReadCommunities[i];
            if (i >= sizeof (cReadCommunities) / sizeof (cReadCommunities[0]))
                strCommunity = "";

            // Ensure we don't buffer overflow.  If your code gets stuck here,
            // it means your SNMP_COMMUNITY_MAX_LEN definition in TCPIPConfig.h
            // is either too small or one of your community string lengths
            // (SNMP_READ_COMMUNITIES) are too large.  Fix either.
            if (strlenpgm(strCommunity) >= sizeof (AppConfig.readCommunity[0]))
                while (1);

            // Copy string into AppConfig
            strcpypgm2ram((char*) AppConfig.readCommunity[i], strCommunity);

            // Get a pointer to the next community string
            strCommunity = cWriteCommunities[i];
            if (i >= sizeof (cWriteCommunities) / sizeof (cWriteCommunities[0]))
                strCommunity = "";

            // Ensure we don't buffer overflow.  If your code gets stuck here,
            // it means your SNMP_COMMUNITY_MAX_LEN definition in TCPIPConfig.h
            // is either too small or one of your community string lengths
            // (SNMP_WRITE_COMMUNITIES) are too large.  Fix either.
            if (strlenpgm(strCommunity) >= sizeof (AppConfig.writeCommunity[0]))
                while (1);

            // Copy string into AppConfig
            strcpypgm2ram((char*) AppConfig.writeCommunity[i], strCommunity);
        }
    }
    #endif

    // Load the default NetBIOS Host Name
    memcpypgm2ram(AppConfig.NetBIOSName, (ROM void*) MY_DEFAULT_HOST_NAME, 16);
    FormatNetBIOSName(AppConfig.NetBIOSName);

    // Load the default SSID Name
    WF_ASSERT(sizeof (MY_DEFAULT_SSID_NAME) <= sizeof (AppConfig.MySSID));
    memcpypgm2ram(AppConfig.MySSID, (ROM void*) MY_DEFAULT_SSID_NAME, sizeof (MY_DEFAULT_SSID_NAME));
    AppConfig.SsidLength = sizeof (MY_DEFAULT_SSID_NAME) - 1;

    AppConfig.SecurityMode = MY_DEFAULT_WIFI_SECURITY_MODE;
    AppConfig.WepKeyIndex = MY_DEFAULT_WEP_KEY_INDEX;

    #if (MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_OPEN)
        memset(AppConfig.SecurityKey, 0x00, sizeof (AppConfig.SecurityKey));
        AppConfig.SecurityKeyLength = 0;

    #elif MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WEP_40
        memcpypgm2ram(AppConfig.SecurityKey, (ROM void*) MY_DEFAULT_WEP_KEYS_40, sizeof (MY_DEFAULT_WEP_KEYS_40) - 1);
        AppConfig.SecurityKeyLength = sizeof (MY_DEFAULT_WEP_KEYS_40) - 1;

    #elif MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WEP_104
        memcpypgm2ram(AppConfig.SecurityKey, (ROM void*) MY_DEFAULT_WEP_KEYS_104, sizeof (MY_DEFAULT_WEP_KEYS_104) - 1);
        AppConfig.SecurityKeyLength = sizeof (MY_DEFAULT_WEP_KEYS_104) - 1;

    #elif (MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WPA_WITH_KEY)       || \
          (MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WPA2_WITH_KEY)      || \
	  (MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WPA_AUTO_WITH_KEY)
        memcpypgm2ram(AppConfig.SecurityKey, (ROM void*) MY_DEFAULT_PSK, sizeof (MY_DEFAULT_PSK) - 1);
        AppConfig.SecurityKeyLength = sizeof (MY_DEFAULT_PSK) - 1;

    #elif (MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WPA_WITH_PASS_PHRASE)     || \
	  (MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WPA2_WITH_PASS_PHRASE)    || \
	  (MY_DEFAULT_WIFI_SECURITY_MODE == WF_SECURITY_WPA_AUTO_WITH_PASS_PHRASE)
        memcpypgm2ram(AppConfig.SecurityKey, (ROM void*) MY_DEFAULT_PSK_PHRASE, sizeof (MY_DEFAULT_PSK_PHRASE) - 1);
        AppConfig.SecurityKeyLength = sizeof (MY_DEFAULT_PSK_PHRASE) - 1;

    #else
        #error "No security defined"
    #endif

    // Compute the checksum of the AppConfig defaults as loaded from ROM
    wOriginalAppConfigChecksum = CalcIPChecksum((BYTE*) & AppConfig, sizeof (AppConfig));
}

/******************************************************************************/

void MyWIFI_SaveAppConfig(const APP_CONFIG *ptrAppConfig)
{
	NVM_VALIDATION_STRUCT NVMValidationStruct;

	// Ensure adequate space has been reserved in non-volatile storage to
	// store the entire AppConfig structure.  If you get stuck in this while(1)
	// trap, it means you have a design time misconfiguration in TCPIPConfig.h.
	// You must increase MPFS_RESERVE_BLOCK to allocate more space.
	#if defined(STACK_USE_MPFS2)
            if(sizeof(NVMValidationStruct) + sizeof(AppConfig) > MPFS_RESERVE_BLOCK) {
                MyConsole_SendMsg("Fatal Erro in SaveAppConfig\n");
		while(1);
            }
	#endif

	// Get proper values for the validation structure indicating that we can use
	// these EEPROM/Flash contents on future boot ups
	NVMValidationStruct.wOriginalChecksum = wOriginalAppConfigChecksum;
	NVMValidationStruct.wCurrentChecksum = CalcIPChecksum((BYTE*)ptrAppConfig, sizeof(APP_CONFIG));
	NVMValidationStruct.wConfigurationLength = sizeof(APP_CONFIG);

	// Write the validation struct and current AppConfig contents to Flash
	SPIFlashBeginWrite(0x0000);
	SPIFlashWriteArray((BYTE*)&NVMValidationStruct, sizeof(NVMValidationStruct));
	SPIFlashWriteArray((BYTE*)ptrAppConfig, sizeof(APP_CONFIG));
}

/******************************************************************************/

void MyWIFI_Connect(void) {
    UINT8 ConnectionProfileID;
    UINT8 channelList[] = MY_DEFAULT_CHANNEL_LIST;

    /* create a Connection Profile */
    WF_CPCreate(&ConnectionProfileID);

    WF_CPSetSsid(ConnectionProfileID,
            AppConfig.MySSID,
            AppConfig.SsidLength);
    WF_CPSetNetworkType(ConnectionProfileID, MY_DEFAULT_NETWORK_TYPE);
    WF_CASetScanType(MY_DEFAULT_SCAN_TYPE);  
    WF_CASetChannelList(channelList, sizeof (channelList));

    // The Retry Count parameter tells the WiFi Connection manager how many attempts to make when trying
    // to connect to an existing network.  In the Infrastructure case, the default is to retry forever so that
    // if the AP is turned off or out of range, the radio will continue to attempt a connection until the
    // AP is eventually back on or in range.  In the Adhoc case, the default is to retry 3 times since the 
    // purpose of attempting to establish a network in the Adhoc case is only to verify that one does not
    // initially exist.  If the retry count was set to WF_RETRY_FOREVER in the AdHoc mode, an AdHoc network
    // would never be established.  The constants MY_DEFAULT_LIST_RETRY_COUNT_ADHOC and 
    // MY_DEFAULT_LIST_RETRY_COUNT_INFRASTRUCTURE have been created specifically for the June 2011 MAL release.

    #if (MY_DEFAULT_NETWORK_TYPE == WF_ADHOC)
        WF_CASetListRetryCount(MY_DEFAULT_LIST_RETRY_COUNT_ADHOC);
    #else
        WF_CASetListRetryCount(MY_DEFAULT_LIST_RETRY_COUNT_INFRASTRUCTURE);
    #endif

    WF_CASetEventNotificationAction(MY_DEFAULT_EVENT_NOTIFICATION_LIST);
    WF_CASetBeaconTimeout(40);

    WF_CPSetSecurity(ConnectionProfileID,
            AppConfig.SecurityMode,
            AppConfig.WepKeyIndex, /* only used if WEP enabled */
            AppConfig.SecurityKey,
            AppConfig.SecurityKeyLength);
                     
    MyConsole_SendMsg("Start WiFi Connect\n");
    WF_CMConnect(ConnectionProfileID);
}

/******************************************************************************/

void MyWIFI_Task() {
    static DWORD dwLastIP = 0;
    char theStr[64];

    // This task performs normal stack task including checking
    // for incoming packet, type of packet and calling
    // appropriate stack entity to process it.
    StackTask();

    // This tasks invokes each of the core stack application tasks
    StackApplications();

    // Process application specific tasks

    #if defined(STACK_USE_SMTP_CLIENT)
        MyWIFI_SMTP();
    #endif

    #if defined(STACK_USE_ICMP_CLIENT)
        MyWIFI_Ping();
    #endif

    #if defined(STACK_USE_SNTP_CLIENT)
    #endif

    // If the local IP address has changed (ex: due to DHCP lease change)
    // write the new IP address to the Console and Announce service
    if(dwLastIP != AppConfig.MyIPAddr.Val) {
        dwLastIP = AppConfig.MyIPAddr.Val;
        sprintf(theStr, "New IP Address : %u.%u.%u.%u\n", AppConfig.MyIPAddr.v[0], AppConfig.MyIPAddr.v[1], AppConfig.MyIPAddr.v[2], AppConfig.MyIPAddr.v[3]);
        MyConsole_SendMsg(theStr);
        #if defined(STACK_USE_ANNOUNCE)
            AnnounceIP();
        #endif
    }
}

/******************************************************************************/

static enum {
    MAIL_HOME = 0,
    MAIL_BEGIN,
    MAIL_SMTP_FINISHING,
    MAIL_DONE
} MailState = MAIL_HOME;

void MyWIFI_SMTP(void) {

    static DWORD WaitTime;

    switch (MailState) {
        case MAIL_HOME:
            if (MyMail_Flag) {
                // Start sending an email
                MyMail_Flag = FALSE;
                MailState++;
            }
            break;

        case MAIL_BEGIN:
            if (SMTPBeginUsage()) {
                // Note that these strings must stay allocated in
                // memory until SMTPIsBusy() returns FALSE.  To
                // guarantee that the C compiler does not reuse this
                // memory, you must allocate the strings as static.

                static BYTE RAMStringTo[] = "jean-didier.legat@uclouvain.be";
                //static BYTE RAMStringCC[] = "foo@picsaregood.com, \"Jane Smith\" <jane.smith@picsaregood.com>";
                //static BYTE RAMStringBCC[] = "";
                static BYTE RAMStringBody[] = "Message generated by stack \r\n\r\nButtons: 3210";

                SMTPClient.Server.szROM = (ROM BYTE*)"relay.skynet.be";	// SMTP server address
                SMTPClient.ROMPointers.Server = 1;
                SMTPClient.ServerPort = (WORD) 25;
                //SMTPClient.UseSSL = TRUE;

                //SMTPClient.Username.szROM = (ROM BYTE*)"mchpboard";
                //SMTPClient.ROMPointers.Username = 1;
                //SMTPClient.Password.szROM = (ROM BYTE*)"secretpassword";
                //SMTPClient.ROMPointers.Password = 1;

                SMTPClient.To.szRAM = RAMStringTo;
                SMTPClient.From.szROM = (ROM BYTE*)"\"Home\" <jean-didier.legat@skynet.be>";
                SMTPClient.ROMPointers.From = 1;
                SMTPClient.Subject.szROM = (ROM BYTE*) "Hello world!  SMTP Test.";
                SMTPClient.ROMPointers.Subject = 1;
                SMTPClient.Body.szRAM = RAMStringBody;
                SMTPSendMail();
                MailState++;
            }
            break;

        case MAIL_SMTP_FINISHING:
            if (!SMTPIsBusy()) {
                // Finished sending mail
                MailState++;
                WaitTime = TickGet();
                if (SMTPEndUsage() == SMTP_SUCCESS)
                    MyConsole_SendMsg("Mail sent successfully\n");
                else MyConsole_SendMsg("Mail sent not successfully\n");
            }
            break;

        case MAIL_DONE:
            // Wait for at least 1 second to pass before allowing another
            // email to be sent.  This is merely to prevent
            // accidental flooding of email boxes while
            // developing code.  Your application may wish to
            // remove this.
            if (TickGet() - WaitTime > TICK_SECOND)
                MailState = MAIL_HOME;
            break;
    }

}

/******************************************************************************/

static enum {
    SM_HOME = 0,
    SM_GET_ICMP_RESPONSE
} PingState = SM_HOME;
    
void MyWIFI_Ping(void) {

    static DWORD Timer;
    LONG ret;
    char theStr[64];

    switch (PingState) {
        case SM_HOME:
            // Send a ping request out if the global variable is set by MyConsole
            if (MyPing_Flag) {
                // Don't ping flood: wait at least 1 second between ping requests
                if (TickGet() - Timer > 1ul * TICK_SECOND) {
                    // Obtain ownership of the ICMP module
                    if (!ICMPBeginUsage())
                        break;

                    // Update anti-ping flood timer
                    Timer = TickGet();

                    // Send ICMP echo request
                    #if defined(STACK_USE_DNS)
                        ICMPSendPingToHostROM((ROM BYTE*) HOST_TO_PING);
                    #else
                        ICMPSendPing(AppConfig.MyGateway.Val);
                    #endif
                    PingState = SM_GET_ICMP_RESPONSE;
                    MyPing_Flag = FALSE;
                }
            }
            break;

        case SM_GET_ICMP_RESPONSE:
            // Get the status of the ICMP module
            ret = ICMPGetReply();
            if (ret == -2) {
                // Do nothing: still waiting for echo
                break;
            } else if (ret == -1) {
                // Request timed out
                MyConsole_SendMsg("Ping timed out\n");
                PingState = SM_HOME;
            } else if (ret == -3) {
                // DNS address not resolvable
                MyConsole_SendMsg("Can't resolve IP\n");
                PingState = SM_HOME;
            } else {
                // Echo received.  Time elapsed is stored in ret (Tick units).
                sprintf(theStr, "Reply: %d ms\n", TickConvertToMilliseconds((DWORD) ret));
                MyConsole_SendMsg(theStr);
                PingState = SM_HOME;
            }

            // Finished with the ICMP module, release it so other apps can begin using it
            ICMPEndUsage();
            break;
    }
}

/******************************************************************************/

void MyWIFI_Debug(void) {
    char theStr[128];

    sprintf(theStr, "WF_INT_IO=%x WF_INT_IF=%x WF_INT_IE=%x WF_HIB_IO=%x CS=%x \n", WF_INT_IO, WF_INT_IF, WF_INT_IE, WF_HIBERNATE_IO,
            PORTReadBits(IOPORT_E, CS_FPGA | CS_WIFI | CS_MIWI | CS_IO | CS_FLASH));
    MyConsole_SendMsg(theStr);
}

/******************************************************************************/

#if defined(WF_DEBUG)
    #define WF_MODULE_NUMBER    WF_MODULE_WF_CONFIG
#endif

static ROM char *connectionFailureStrings[] = {
        "NULL",                                  /* 0 - not used */
        "NULL",                                  /* 1 - not used */
        "WF_JOIN_FAILURE",                       /* 2            */
        "WF_AUTHENTICATION_FAILURE",             /* 3            */
        "WF_ASSOCIATION_FAILURE",                /* 4            */
        "WF_WEP_HANDSHAKE_FAILURE",              /* 5            */
        "WF_PSK_CALCULATION_FAILURE",            /* 6            */
        "WF_PSK_HANDSHAKE_FAILURE",              /* 7            */
        "WF_ADHOC_JOIN_FAILURE",                 /* 8            */
        "WF_SECURITY_MISMATCH_FAILURE",          /* 9            */
        "WF_NO_SUITABLE_AP_FOUND_FAILURE",       /* 10           */
        "WF_RETRY_FOREVER_NOT_SUPPORTED_FAILURE",/* 11           */
    };

static ROM char *connectionLostStrings[] = {
        "Association Failure",      /* 0 */
        "WF_BEACON_TIMEOUT",        /* 1 */
        "WF_DEAUTH_RECEIVED",       /* 2 */
        "WF_DISASSOCIATE_RECEIVED", /* 3 */
    };

/*******************************************************************************
 * FUNCTION: WF_ProcessEvent
 *
 * RETURNS:  None
 *
 * PARAMS:   event      -- event that occurred
 *           eventInfo  -- additional information about the event.  Not all events
 *                         have associated info, in which case this value will be
 *                         set to WF_NO_ADDITIONAL_INFO (0xff)
 *           eventInfo  -- Additional information about the event.  This is not applicable
 *                         to all events.
 *
 *  NOTES:   The Host application must NOT directly call this function.  This
 *           function is called by the WiFi Driver code when an event occurs
 *           that may need processing by the Host CPU.
 *
 *           No other WiFi Driver function should be called from this function, with the
 *           exception of WF_ASSERT.  It is recommended that if the application wishes to be
 *           notified of an event that it simply set a flag and let application code in the
 *           main loop handle the event.
 *
 *           WFSetFuncState must be called when entering and leaving this function.
 *           When WF_ASSERT is enabled this allows a runtime check if any illegal WF functions
 *           are called from within this function.
 *
 *           For events that the application is not interested in simply leave the
 *           case statement empty.
 *
 *           Customize this function as needed for your application.
 ******************************************************************************/

void WF_ProcessEvent(UINT8 event, UINT16 eventInfo, UINT8 *extraInfo) {
    char theStr[128];

    /* this function tells the WF driver that we are in this function */
    WFSetFuncState(WF_PROCESS_EVENT_FUNC, WF_ENTERING_FUNCTION);

    switch (event) {
        case WF_EVENT_CONNECTION_SUCCESSFUL:
            MyConsole_SendMsg("WF_Event: Connection Successful\n");
            break;

        case WF_EVENT_CONNECTION_FAILED:
            sprintf(theStr, "WF_Event: Connection Failed -- eventInfo = %d %s\n", eventInfo, connectionFailureStrings[eventInfo]);
            MyConsole_SendMsg(theStr);
            break;

        case WF_EVENT_CONNECTION_TEMPORARILY_LOST:
            sprintf(theStr, "WF_Event: Connection Temporarily Lost -- eventInfo = %d %s\n", eventInfo, connectionLostStrings[eventInfo]);
            MyConsole_SendMsg(theStr);
            break;

        case WF_EVENT_CONNECTION_PERMANENTLY_LOST:
            sprintf(theStr, "WF_Event: Connection Permanently Lost -- eventInfo = %d %s\n", eventInfo, connectionLostStrings[eventInfo]);
            MyConsole_SendMsg(theStr);
            break;

        case WF_EVENT_CONNECTION_REESTABLISHED:
            MyConsole_SendMsg("WF_Event: Connection Reestablished\r\n");
            break;

        case WF_EVENT_SCAN_RESULTS_READY:
            sprintf(theStr, "WF_Event: Scan Results Ready -- %d results\n", eventInfo);
            MyConsole_SendMsg(theStr);
            break;

        case WF_EVENT_RX_PACKET_RECEIVED:
            sprintf(theStr, "Event: Rx Packet Received - length = %d\n", eventInfo);
            MyConsole_SendMsg(theStr);
            break;

        default:
            WF_ASSERT(FALSE); /* unknown event */
            break;
    }

    /* Informs the WF driver that we are leaving this function */
    WFSetFuncState(WF_PROCESS_EVENT_FUNC, WF_LEAVING_FUNCTION);
}

/*******************************************************************************
 *                                   WF_AssertionFailed()
 *
 * Description : Called by a WiFi library function when an assert occurs.
 *
 * Argument(s) : moduleNumber - module number (located in WFApi.h)
 *
 *               lineNumber   - line number within module where assert occurred.
 *
 * Return(s)   : None
 *
 * Caller(s)   : WF Driver
 *
 * Notes:      : (1) If the WF_ASSERT macro is enabled (via the WF_DEBUG define in WF_Config.h) this is the
 *                   function that gets called when WF_ASSERT() fails.
 *
 *               (2) Customize this function as desired to handle assertion errors
 *
 ******************************************************************************/

void WF_AssertionFailed(UINT8 moduleNumber, UINT16 lineNumber) {
    char buf[128];
    UINT16 moduleNameIdx;
    static ROM char *moduleName[] = {
        "MainDemo.c",
        "WF_Config.c",
        "WF_Eint.c",
        "WF_Spi.c",
        "WFMac.c",
        "WFParamMsg.c",
        "WFConnectionProfile.c",
        "WFConnectionAlgorithm.c",
        "WFConnectionManager.c",
        "WFDriverCom.c",
        "WFInit.c",
        "WFDriverRaw.c",
        "WFMgmtMsg.c",
        "WFMgmtMsgTest.c",
        "WFTxPower.c",
        "WFPowerSave.c",
        "WFEventHandler.c",
        "WFScan.c",
        "WFDataTxRx",
        "IperfApp.c",
        "WFHostBridge.c",
        "WF_iperfClient.c",
        "WF_iperfServer.c",
        "WF_iperfCommon.c"
    };

    if (moduleNumber < 100)
        moduleNameIdx = moduleNumber;
    else
        moduleNameIdx = moduleNumber - 81; /* to make index 19 */

    sprintf(buf, "WF ASSERTION at %s Line Number = %d\n", moduleName[moduleNameIdx],lineNumber);
    MyConsole_SendMsg(buf);

    MyWIFI_Debug();

    while (1);
}

/******************************************************************************/
