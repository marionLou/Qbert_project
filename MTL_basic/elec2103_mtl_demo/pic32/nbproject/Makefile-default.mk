#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=Microchip/Common/TimeDelay.c "Microchip/MDD File System/FSIO.c" "Microchip/MDD File System/SD-SPI.c" "Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.c" "Microchip/TCPIP Stack/WIFI/WFConnectionManager.c" "Microchip/TCPIP Stack/WIFI/WFConnectionProfile.c" "Microchip/TCPIP Stack/WIFI/WFDataTxRx.c" "Microchip/TCPIP Stack/WIFI/WFDriverCom.c" "Microchip/TCPIP Stack/WIFI/WFDriverRaw.c" "Microchip/TCPIP Stack/WIFI/WFEventHandler.c" "Microchip/TCPIP Stack/WIFI/WFInit.c" "Microchip/TCPIP Stack/WIFI/WFMac.c" "Microchip/TCPIP Stack/WIFI/WFMgmtMsg.c" "Microchip/TCPIP Stack/WIFI/WFParamMsg.c" "Microchip/TCPIP Stack/WIFI/WFPowerSave.c" "Microchip/TCPIP Stack/WIFI/WFScan.c" "Microchip/TCPIP Stack/WIFI/WFTxPower.c" "Microchip/TCPIP Stack/WIFI/WF_Eint.c" "Microchip/TCPIP Stack/WIFI/WF_Spi.c" "Microchip/TCPIP Stack/WiFi/WF_pbkdf2.c" "Microchip/TCPIP Stack/ARP.c" "Microchip/TCPIP Stack/Announce.c" "Microchip/TCPIP Stack/AutoIP.c" "Microchip/TCPIP Stack/BerkeleyAPI.c" "Microchip/TCPIP Stack/DHCP.c" "Microchip/TCPIP Stack/DHCPs.c" "Microchip/TCPIP Stack/DNS.c" "Microchip/TCPIP Stack/DNSs.c" "Microchip/TCPIP Stack/DynDNS.c" "Microchip/TCPIP Stack/FTP.c" "Microchip/TCPIP Stack/FileSystem.c" "Microchip/TCPIP Stack/HTTP2.c" "Microchip/TCPIP Stack/Hashes.c" "Microchip/TCPIP Stack/Helpers.c" "Microchip/TCPIP Stack/ICMP.c" "Microchip/TCPIP Stack/IP.c" "Microchip/TCPIP Stack/MPFS2.c" "Microchip/TCPIP Stack/NBNS.c" "Microchip/TCPIP Stack/RSA.c" "Microchip/TCPIP Stack/Random.c" "Microchip/TCPIP Stack/Reboot.c" "Microchip/TCPIP Stack/SMTP.c" "Microchip/TCPIP Stack/SNMP.c" "Microchip/TCPIP Stack/SNMPv3.c" "Microchip/TCPIP Stack/SNTP.c" "Microchip/TCPIP Stack/SPIFlash.c" "Microchip/TCPIP Stack/SSL.c" "Microchip/TCPIP Stack/StackTsk.c" "Microchip/TCPIP Stack/TCP.c" "Microchip/TCPIP Stack/TCPPerformanceTest.c" "Microchip/TCPIP Stack/TFTPc.c" "Microchip/TCPIP Stack/Telnet.c" "Microchip/TCPIP Stack/Tick.c" "Microchip/TCPIP Stack/UDP.c" Microchip/Transceivers/MRF24J40/MRF24J40.c Microchip/Transceivers/crc.c Microchip/Transceivers/security.c Microchip/WirelessProtocols/P2P/P2P.c Microchip/WirelessProtocols/SymbolTime.c MyFiles/MyCAN.c MyFiles/MyConsole.c MyFiles/MyCyclone.c MyFiles/MyFlash.c MyFiles/MyHTTP.c MyFiles/MyIO.c MyFiles/MyLED.c MyFiles/MyMDDFS.c MyFiles/MyMIWI.c MyFiles/MyMiniProjet.c MyFiles/MyRTCC.c MyFiles/MySPI.c MyFiles/MyTemperature.c MyFiles/MyWIFI.c MyFiles/MyCamera.c MyFiles/MyApp.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/Microchip/Common/TimeDelay.o "${OBJECTDIR}/Microchip/MDD File System/FSIO.o" "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o" "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o" "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o" "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o" "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o" "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o" "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o" "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o" "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o" "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o" "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o" "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o" "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o" "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o" "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o" "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o" "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o" "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o" "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o" "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o" "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o" "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o" "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o" "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o" "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o" "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o" "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o" ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o ${OBJECTDIR}/Microchip/Transceivers/crc.o ${OBJECTDIR}/Microchip/Transceivers/security.o ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o ${OBJECTDIR}/MyFiles/MyCAN.o ${OBJECTDIR}/MyFiles/MyConsole.o ${OBJECTDIR}/MyFiles/MyCyclone.o ${OBJECTDIR}/MyFiles/MyFlash.o ${OBJECTDIR}/MyFiles/MyHTTP.o ${OBJECTDIR}/MyFiles/MyIO.o ${OBJECTDIR}/MyFiles/MyLED.o ${OBJECTDIR}/MyFiles/MyMDDFS.o ${OBJECTDIR}/MyFiles/MyMIWI.o ${OBJECTDIR}/MyFiles/MyMiniProjet.o ${OBJECTDIR}/MyFiles/MyRTCC.o ${OBJECTDIR}/MyFiles/MySPI.o ${OBJECTDIR}/MyFiles/MyTemperature.o ${OBJECTDIR}/MyFiles/MyWIFI.o ${OBJECTDIR}/MyFiles/MyCamera.o ${OBJECTDIR}/MyFiles/MyApp.o
POSSIBLE_DEPFILES=${OBJECTDIR}/Microchip/Common/TimeDelay.o.d "${OBJECTDIR}/Microchip/MDD File System/FSIO.o.d" "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o.d" "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o.d" ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o.d ${OBJECTDIR}/Microchip/Transceivers/crc.o.d ${OBJECTDIR}/Microchip/Transceivers/security.o.d ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o.d ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o.d ${OBJECTDIR}/MyFiles/MyCAN.o.d ${OBJECTDIR}/MyFiles/MyConsole.o.d ${OBJECTDIR}/MyFiles/MyCyclone.o.d ${OBJECTDIR}/MyFiles/MyFlash.o.d ${OBJECTDIR}/MyFiles/MyHTTP.o.d ${OBJECTDIR}/MyFiles/MyIO.o.d ${OBJECTDIR}/MyFiles/MyLED.o.d ${OBJECTDIR}/MyFiles/MyMDDFS.o.d ${OBJECTDIR}/MyFiles/MyMIWI.o.d ${OBJECTDIR}/MyFiles/MyMiniProjet.o.d ${OBJECTDIR}/MyFiles/MyRTCC.o.d ${OBJECTDIR}/MyFiles/MySPI.o.d ${OBJECTDIR}/MyFiles/MyTemperature.o.d ${OBJECTDIR}/MyFiles/MyWIFI.o.d ${OBJECTDIR}/MyFiles/MyCamera.o.d ${OBJECTDIR}/MyFiles/MyApp.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/Microchip/Common/TimeDelay.o ${OBJECTDIR}/Microchip/MDD\ File\ System/FSIO.o ${OBJECTDIR}/Microchip/MDD\ File\ System/SD-SPI.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionAlgorithm.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionManager.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionProfile.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDataTxRx.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverCom.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverRaw.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFEventHandler.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFInit.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMac.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMgmtMsg.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFParamMsg.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFPowerSave.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFScan.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFTxPower.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Eint.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Spi.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/WiFi/WF_pbkdf2.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/ARP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/Announce.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/AutoIP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/BerkeleyAPI.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCPs.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/DNS.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/DNSs.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/DynDNS.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/FTP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/FileSystem.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/HTTP2.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/Hashes.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/Helpers.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/ICMP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/IP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/MPFS2.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/NBNS.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/RSA.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/Random.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/Reboot.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/SMTP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMPv3.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNTP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/SPIFlash.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/SSL.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/StackTsk.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/TCP.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/TCPPerformanceTest.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/TFTPc.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/Telnet.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/Tick.o ${OBJECTDIR}/Microchip/TCPIP\ Stack/UDP.o ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o ${OBJECTDIR}/Microchip/Transceivers/crc.o ${OBJECTDIR}/Microchip/Transceivers/security.o ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o ${OBJECTDIR}/MyFiles/MyCAN.o ${OBJECTDIR}/MyFiles/MyConsole.o ${OBJECTDIR}/MyFiles/MyCyclone.o ${OBJECTDIR}/MyFiles/MyFlash.o ${OBJECTDIR}/MyFiles/MyHTTP.o ${OBJECTDIR}/MyFiles/MyIO.o ${OBJECTDIR}/MyFiles/MyLED.o ${OBJECTDIR}/MyFiles/MyMDDFS.o ${OBJECTDIR}/MyFiles/MyMIWI.o ${OBJECTDIR}/MyFiles/MyMiniProjet.o ${OBJECTDIR}/MyFiles/MyRTCC.o ${OBJECTDIR}/MyFiles/MySPI.o ${OBJECTDIR}/MyFiles/MyTemperature.o ${OBJECTDIR}/MyFiles/MyWIFI.o ${OBJECTDIR}/MyFiles/MyCamera.o ${OBJECTDIR}/MyFiles/MyApp.o

# Source Files
SOURCEFILES=Microchip/Common/TimeDelay.c Microchip/MDD File System/FSIO.c Microchip/MDD File System/SD-SPI.c Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.c Microchip/TCPIP Stack/WIFI/WFConnectionManager.c Microchip/TCPIP Stack/WIFI/WFConnectionProfile.c Microchip/TCPIP Stack/WIFI/WFDataTxRx.c Microchip/TCPIP Stack/WIFI/WFDriverCom.c Microchip/TCPIP Stack/WIFI/WFDriverRaw.c Microchip/TCPIP Stack/WIFI/WFEventHandler.c Microchip/TCPIP Stack/WIFI/WFInit.c Microchip/TCPIP Stack/WIFI/WFMac.c Microchip/TCPIP Stack/WIFI/WFMgmtMsg.c Microchip/TCPIP Stack/WIFI/WFParamMsg.c Microchip/TCPIP Stack/WIFI/WFPowerSave.c Microchip/TCPIP Stack/WIFI/WFScan.c Microchip/TCPIP Stack/WIFI/WFTxPower.c Microchip/TCPIP Stack/WIFI/WF_Eint.c Microchip/TCPIP Stack/WIFI/WF_Spi.c Microchip/TCPIP Stack/WiFi/WF_pbkdf2.c Microchip/TCPIP Stack/ARP.c Microchip/TCPIP Stack/Announce.c Microchip/TCPIP Stack/AutoIP.c Microchip/TCPIP Stack/BerkeleyAPI.c Microchip/TCPIP Stack/DHCP.c Microchip/TCPIP Stack/DHCPs.c Microchip/TCPIP Stack/DNS.c Microchip/TCPIP Stack/DNSs.c Microchip/TCPIP Stack/DynDNS.c Microchip/TCPIP Stack/FTP.c Microchip/TCPIP Stack/FileSystem.c Microchip/TCPIP Stack/HTTP2.c Microchip/TCPIP Stack/Hashes.c Microchip/TCPIP Stack/Helpers.c Microchip/TCPIP Stack/ICMP.c Microchip/TCPIP Stack/IP.c Microchip/TCPIP Stack/MPFS2.c Microchip/TCPIP Stack/NBNS.c Microchip/TCPIP Stack/RSA.c Microchip/TCPIP Stack/Random.c Microchip/TCPIP Stack/Reboot.c Microchip/TCPIP Stack/SMTP.c Microchip/TCPIP Stack/SNMP.c Microchip/TCPIP Stack/SNMPv3.c Microchip/TCPIP Stack/SNTP.c Microchip/TCPIP Stack/SPIFlash.c Microchip/TCPIP Stack/SSL.c Microchip/TCPIP Stack/StackTsk.c Microchip/TCPIP Stack/TCP.c Microchip/TCPIP Stack/TCPPerformanceTest.c Microchip/TCPIP Stack/TFTPc.c Microchip/TCPIP Stack/Telnet.c Microchip/TCPIP Stack/Tick.c Microchip/TCPIP Stack/UDP.c Microchip/Transceivers/MRF24J40/MRF24J40.c Microchip/Transceivers/crc.c Microchip/Transceivers/security.c Microchip/WirelessProtocols/P2P/P2P.c Microchip/WirelessProtocols/SymbolTime.c MyFiles/MyCAN.c MyFiles/MyConsole.c MyFiles/MyCyclone.c MyFiles/MyFlash.c MyFiles/MyHTTP.c MyFiles/MyIO.c MyFiles/MyLED.c MyFiles/MyMDDFS.c MyFiles/MyMIWI.c MyFiles/MyMiniProjet.c MyFiles/MyRTCC.c MyFiles/MySPI.c MyFiles/MyTemperature.c MyFiles/MyWIFI.c MyFiles/MyCamera.c MyFiles/MyApp.c


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
	${MAKE} ${MAKE_OPTIONS} -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MX795F512H
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/Microchip/Common/TimeDelay.o: Microchip/Common/TimeDelay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Common 
	@${RM} ${OBJECTDIR}/Microchip/Common/TimeDelay.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Common/TimeDelay.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Common/TimeDelay.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Common/TimeDelay.o.d" -o ${OBJECTDIR}/Microchip/Common/TimeDelay.o Microchip/Common/TimeDelay.c   
	
${OBJECTDIR}/Microchip/MDD\ File\ System/FSIO.o: Microchip/MDD\ File\ System/FSIO.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/MDD\ File\ System 
	@${RM} ${OBJECTDIR}/Microchip/MDD\ File\ System/FSIO.o.d 
	@${RM} "${OBJECTDIR}/Microchip/MDD File System/FSIO.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/MDD File System/FSIO.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/MDD File System/FSIO.o.d" -o "${OBJECTDIR}/Microchip/MDD File System/FSIO.o" "Microchip/MDD File System/FSIO.c"   
	
${OBJECTDIR}/Microchip/MDD\ File\ System/SD-SPI.o: Microchip/MDD\ File\ System/SD-SPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/MDD\ File\ System 
	@${RM} ${OBJECTDIR}/Microchip/MDD\ File\ System/SD-SPI.o.d 
	@${RM} "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o.d" -o "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o" "Microchip/MDD File System/SD-SPI.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionAlgorithm.o: Microchip/TCPIP\ Stack/WIFI/WFConnectionAlgorithm.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionAlgorithm.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o" "Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionManager.o: Microchip/TCPIP\ Stack/WIFI/WFConnectionManager.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionManager.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o" "Microchip/TCPIP Stack/WIFI/WFConnectionManager.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionProfile.o: Microchip/TCPIP\ Stack/WIFI/WFConnectionProfile.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionProfile.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o" "Microchip/TCPIP Stack/WIFI/WFConnectionProfile.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDataTxRx.o: Microchip/TCPIP\ Stack/WIFI/WFDataTxRx.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDataTxRx.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o" "Microchip/TCPIP Stack/WIFI/WFDataTxRx.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverCom.o: Microchip/TCPIP\ Stack/WIFI/WFDriverCom.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverCom.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o" "Microchip/TCPIP Stack/WIFI/WFDriverCom.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverRaw.o: Microchip/TCPIP\ Stack/WIFI/WFDriverRaw.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverRaw.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o" "Microchip/TCPIP Stack/WIFI/WFDriverRaw.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFEventHandler.o: Microchip/TCPIP\ Stack/WIFI/WFEventHandler.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFEventHandler.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o" "Microchip/TCPIP Stack/WIFI/WFEventHandler.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFInit.o: Microchip/TCPIP\ Stack/WIFI/WFInit.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFInit.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o" "Microchip/TCPIP Stack/WIFI/WFInit.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMac.o: Microchip/TCPIP\ Stack/WIFI/WFMac.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMac.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o" "Microchip/TCPIP Stack/WIFI/WFMac.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMgmtMsg.o: Microchip/TCPIP\ Stack/WIFI/WFMgmtMsg.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMgmtMsg.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o" "Microchip/TCPIP Stack/WIFI/WFMgmtMsg.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFParamMsg.o: Microchip/TCPIP\ Stack/WIFI/WFParamMsg.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFParamMsg.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o" "Microchip/TCPIP Stack/WIFI/WFParamMsg.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFPowerSave.o: Microchip/TCPIP\ Stack/WIFI/WFPowerSave.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFPowerSave.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o" "Microchip/TCPIP Stack/WIFI/WFPowerSave.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFScan.o: Microchip/TCPIP\ Stack/WIFI/WFScan.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFScan.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o" "Microchip/TCPIP Stack/WIFI/WFScan.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFTxPower.o: Microchip/TCPIP\ Stack/WIFI/WFTxPower.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFTxPower.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o" "Microchip/TCPIP Stack/WIFI/WFTxPower.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Eint.o: Microchip/TCPIP\ Stack/WIFI/WF_Eint.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Eint.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o" "Microchip/TCPIP Stack/WIFI/WF_Eint.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Spi.o: Microchip/TCPIP\ Stack/WIFI/WF_Spi.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Spi.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o" "Microchip/TCPIP Stack/WIFI/WF_Spi.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WiFi/WF_pbkdf2.o: Microchip/TCPIP\ Stack/WiFi/WF_pbkdf2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WiFi 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WiFi/WF_pbkdf2.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o" "Microchip/TCPIP Stack/WiFi/WF_pbkdf2.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/ARP.o: Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/ARP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o" "Microchip/TCPIP Stack/ARP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Announce.o: Microchip/TCPIP\ Stack/Announce.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Announce.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o" "Microchip/TCPIP Stack/Announce.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/AutoIP.o: Microchip/TCPIP\ Stack/AutoIP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/AutoIP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o" "Microchip/TCPIP Stack/AutoIP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/BerkeleyAPI.o: Microchip/TCPIP\ Stack/BerkeleyAPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/BerkeleyAPI.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o" "Microchip/TCPIP Stack/BerkeleyAPI.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCP.o: Microchip/TCPIP\ Stack/DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o" "Microchip/TCPIP Stack/DHCP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCPs.o: Microchip/TCPIP\ Stack/DHCPs.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCPs.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o" "Microchip/TCPIP Stack/DHCPs.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DNS.o: Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DNS.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o" "Microchip/TCPIP Stack/DNS.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DNSs.o: Microchip/TCPIP\ Stack/DNSs.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DNSs.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o" "Microchip/TCPIP Stack/DNSs.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DynDNS.o: Microchip/TCPIP\ Stack/DynDNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DynDNS.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o" "Microchip/TCPIP Stack/DynDNS.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/FTP.o: Microchip/TCPIP\ Stack/FTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/FTP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o" "Microchip/TCPIP Stack/FTP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/FileSystem.o: Microchip/TCPIP\ Stack/FileSystem.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/FileSystem.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o" "Microchip/TCPIP Stack/FileSystem.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/HTTP2.o: Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/HTTP2.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o" "Microchip/TCPIP Stack/HTTP2.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Hashes.o: Microchip/TCPIP\ Stack/Hashes.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Hashes.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o" "Microchip/TCPIP Stack/Hashes.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Helpers.o: Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Helpers.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o" "Microchip/TCPIP Stack/Helpers.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/ICMP.o: Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/ICMP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o" "Microchip/TCPIP Stack/ICMP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/IP.o: Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/IP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o" "Microchip/TCPIP Stack/IP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/MPFS2.o: Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/MPFS2.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o" "Microchip/TCPIP Stack/MPFS2.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/NBNS.o: Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/NBNS.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o" "Microchip/TCPIP Stack/NBNS.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/RSA.o: Microchip/TCPIP\ Stack/RSA.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/RSA.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o" "Microchip/TCPIP Stack/RSA.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Random.o: Microchip/TCPIP\ Stack/Random.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Random.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o" "Microchip/TCPIP Stack/Random.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Reboot.o: Microchip/TCPIP\ Stack/Reboot.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Reboot.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o" "Microchip/TCPIP Stack/Reboot.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SMTP.o: Microchip/TCPIP\ Stack/SMTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SMTP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o" "Microchip/TCPIP Stack/SMTP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMP.o: Microchip/TCPIP\ Stack/SNMP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o" "Microchip/TCPIP Stack/SNMP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMPv3.o: Microchip/TCPIP\ Stack/SNMPv3.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMPv3.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o" "Microchip/TCPIP Stack/SNMPv3.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SNTP.o: Microchip/TCPIP\ Stack/SNTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNTP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o" "Microchip/TCPIP Stack/SNTP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SPIFlash.o: Microchip/TCPIP\ Stack/SPIFlash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SPIFlash.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o" "Microchip/TCPIP Stack/SPIFlash.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SSL.o: Microchip/TCPIP\ Stack/SSL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SSL.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o" "Microchip/TCPIP Stack/SSL.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/StackTsk.o: Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/StackTsk.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o" "Microchip/TCPIP Stack/StackTsk.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/TCP.o: Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/TCP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o" "Microchip/TCPIP Stack/TCP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/TCPPerformanceTest.o: Microchip/TCPIP\ Stack/TCPPerformanceTest.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/TCPPerformanceTest.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o" "Microchip/TCPIP Stack/TCPPerformanceTest.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/TFTPc.o: Microchip/TCPIP\ Stack/TFTPc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/TFTPc.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o" "Microchip/TCPIP Stack/TFTPc.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Telnet.o: Microchip/TCPIP\ Stack/Telnet.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Telnet.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o" "Microchip/TCPIP Stack/Telnet.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Tick.o: Microchip/TCPIP\ Stack/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Tick.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o" "Microchip/TCPIP Stack/Tick.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/UDP.o: Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/UDP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o" "Microchip/TCPIP Stack/UDP.c"   
	
${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o: Microchip/Transceivers/MRF24J40/MRF24J40.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Transceivers/MRF24J40 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o.d" -o ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o Microchip/Transceivers/MRF24J40/MRF24J40.c   
	
${OBJECTDIR}/Microchip/Transceivers/crc.o: Microchip/Transceivers/crc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Transceivers 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/crc.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/crc.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Transceivers/crc.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Transceivers/crc.o.d" -o ${OBJECTDIR}/Microchip/Transceivers/crc.o Microchip/Transceivers/crc.c   
	
${OBJECTDIR}/Microchip/Transceivers/security.o: Microchip/Transceivers/security.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Transceivers 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/security.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/security.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Transceivers/security.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Transceivers/security.o.d" -o ${OBJECTDIR}/Microchip/Transceivers/security.o Microchip/Transceivers/security.c   
	
${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o: Microchip/WirelessProtocols/P2P/P2P.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/WirelessProtocols/P2P 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o.d 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o.d" -o ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o Microchip/WirelessProtocols/P2P/P2P.c   
	
${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o: Microchip/WirelessProtocols/SymbolTime.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/WirelessProtocols 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o.d 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o.d" -o ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o Microchip/WirelessProtocols/SymbolTime.c   
	
${OBJECTDIR}/MyFiles/MyCAN.o: MyFiles/MyCAN.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyCAN.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyCAN.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyCAN.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyCAN.o.d" -o ${OBJECTDIR}/MyFiles/MyCAN.o MyFiles/MyCAN.c   
	
${OBJECTDIR}/MyFiles/MyConsole.o: MyFiles/MyConsole.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyConsole.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyConsole.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyConsole.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyConsole.o.d" -o ${OBJECTDIR}/MyFiles/MyConsole.o MyFiles/MyConsole.c   
	
${OBJECTDIR}/MyFiles/MyCyclone.o: MyFiles/MyCyclone.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyCyclone.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyCyclone.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyCyclone.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyCyclone.o.d" -o ${OBJECTDIR}/MyFiles/MyCyclone.o MyFiles/MyCyclone.c   
	
${OBJECTDIR}/MyFiles/MyFlash.o: MyFiles/MyFlash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyFlash.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyFlash.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyFlash.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyFlash.o.d" -o ${OBJECTDIR}/MyFiles/MyFlash.o MyFiles/MyFlash.c   
	
${OBJECTDIR}/MyFiles/MyHTTP.o: MyFiles/MyHTTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyHTTP.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyHTTP.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyHTTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyHTTP.o.d" -o ${OBJECTDIR}/MyFiles/MyHTTP.o MyFiles/MyHTTP.c   
	
${OBJECTDIR}/MyFiles/MyIO.o: MyFiles/MyIO.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyIO.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyIO.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyIO.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyIO.o.d" -o ${OBJECTDIR}/MyFiles/MyIO.o MyFiles/MyIO.c   
	
${OBJECTDIR}/MyFiles/MyLED.o: MyFiles/MyLED.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyLED.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyLED.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyLED.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyLED.o.d" -o ${OBJECTDIR}/MyFiles/MyLED.o MyFiles/MyLED.c   
	
${OBJECTDIR}/MyFiles/MyMDDFS.o: MyFiles/MyMDDFS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyMDDFS.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyMDDFS.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyMDDFS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyMDDFS.o.d" -o ${OBJECTDIR}/MyFiles/MyMDDFS.o MyFiles/MyMDDFS.c   
	
${OBJECTDIR}/MyFiles/MyMIWI.o: MyFiles/MyMIWI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyMIWI.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyMIWI.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyMIWI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyMIWI.o.d" -o ${OBJECTDIR}/MyFiles/MyMIWI.o MyFiles/MyMIWI.c   
	
${OBJECTDIR}/MyFiles/MyMiniProjet.o: MyFiles/MyMiniProjet.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyMiniProjet.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyMiniProjet.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyMiniProjet.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyMiniProjet.o.d" -o ${OBJECTDIR}/MyFiles/MyMiniProjet.o MyFiles/MyMiniProjet.c   
	
${OBJECTDIR}/MyFiles/MyRTCC.o: MyFiles/MyRTCC.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyRTCC.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyRTCC.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyRTCC.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyRTCC.o.d" -o ${OBJECTDIR}/MyFiles/MyRTCC.o MyFiles/MyRTCC.c   
	
${OBJECTDIR}/MyFiles/MySPI.o: MyFiles/MySPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MySPI.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MySPI.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MySPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MySPI.o.d" -o ${OBJECTDIR}/MyFiles/MySPI.o MyFiles/MySPI.c   
	
${OBJECTDIR}/MyFiles/MyTemperature.o: MyFiles/MyTemperature.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyTemperature.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyTemperature.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyTemperature.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyTemperature.o.d" -o ${OBJECTDIR}/MyFiles/MyTemperature.o MyFiles/MyTemperature.c   
	
${OBJECTDIR}/MyFiles/MyWIFI.o: MyFiles/MyWIFI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyWIFI.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyWIFI.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyWIFI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyWIFI.o.d" -o ${OBJECTDIR}/MyFiles/MyWIFI.o MyFiles/MyWIFI.c   
	
${OBJECTDIR}/MyFiles/MyCamera.o: MyFiles/MyCamera.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyCamera.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyCamera.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyCamera.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyCamera.o.d" -o ${OBJECTDIR}/MyFiles/MyCamera.o MyFiles/MyCamera.c   
	
${OBJECTDIR}/MyFiles/MyApp.o: MyFiles/MyApp.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyApp.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyApp.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyApp.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG -D__MPLAB_DEBUGGER_PK3=1 -fframe-base-loclist  -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyApp.o.d" -o ${OBJECTDIR}/MyFiles/MyApp.o MyFiles/MyApp.c   
	
else
${OBJECTDIR}/Microchip/Common/TimeDelay.o: Microchip/Common/TimeDelay.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Common 
	@${RM} ${OBJECTDIR}/Microchip/Common/TimeDelay.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Common/TimeDelay.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Common/TimeDelay.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Common/TimeDelay.o.d" -o ${OBJECTDIR}/Microchip/Common/TimeDelay.o Microchip/Common/TimeDelay.c   
	
${OBJECTDIR}/Microchip/MDD\ File\ System/FSIO.o: Microchip/MDD\ File\ System/FSIO.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/MDD\ File\ System 
	@${RM} ${OBJECTDIR}/Microchip/MDD\ File\ System/FSIO.o.d 
	@${RM} "${OBJECTDIR}/Microchip/MDD File System/FSIO.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/MDD File System/FSIO.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/MDD File System/FSIO.o.d" -o "${OBJECTDIR}/Microchip/MDD File System/FSIO.o" "Microchip/MDD File System/FSIO.c"   
	
${OBJECTDIR}/Microchip/MDD\ File\ System/SD-SPI.o: Microchip/MDD\ File\ System/SD-SPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/MDD\ File\ System 
	@${RM} ${OBJECTDIR}/Microchip/MDD\ File\ System/SD-SPI.o.d 
	@${RM} "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o.d" -o "${OBJECTDIR}/Microchip/MDD File System/SD-SPI.o" "Microchip/MDD File System/SD-SPI.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionAlgorithm.o: Microchip/TCPIP\ Stack/WIFI/WFConnectionAlgorithm.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionAlgorithm.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.o" "Microchip/TCPIP Stack/WIFI/WFConnectionAlgorithm.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionManager.o: Microchip/TCPIP\ Stack/WIFI/WFConnectionManager.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionManager.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionManager.o" "Microchip/TCPIP Stack/WIFI/WFConnectionManager.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionProfile.o: Microchip/TCPIP\ Stack/WIFI/WFConnectionProfile.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFConnectionProfile.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFConnectionProfile.o" "Microchip/TCPIP Stack/WIFI/WFConnectionProfile.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDataTxRx.o: Microchip/TCPIP\ Stack/WIFI/WFDataTxRx.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDataTxRx.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDataTxRx.o" "Microchip/TCPIP Stack/WIFI/WFDataTxRx.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverCom.o: Microchip/TCPIP\ Stack/WIFI/WFDriverCom.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverCom.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverCom.o" "Microchip/TCPIP Stack/WIFI/WFDriverCom.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverRaw.o: Microchip/TCPIP\ Stack/WIFI/WFDriverRaw.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFDriverRaw.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFDriverRaw.o" "Microchip/TCPIP Stack/WIFI/WFDriverRaw.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFEventHandler.o: Microchip/TCPIP\ Stack/WIFI/WFEventHandler.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFEventHandler.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFEventHandler.o" "Microchip/TCPIP Stack/WIFI/WFEventHandler.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFInit.o: Microchip/TCPIP\ Stack/WIFI/WFInit.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFInit.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFInit.o" "Microchip/TCPIP Stack/WIFI/WFInit.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMac.o: Microchip/TCPIP\ Stack/WIFI/WFMac.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMac.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMac.o" "Microchip/TCPIP Stack/WIFI/WFMac.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMgmtMsg.o: Microchip/TCPIP\ Stack/WIFI/WFMgmtMsg.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFMgmtMsg.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFMgmtMsg.o" "Microchip/TCPIP Stack/WIFI/WFMgmtMsg.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFParamMsg.o: Microchip/TCPIP\ Stack/WIFI/WFParamMsg.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFParamMsg.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFParamMsg.o" "Microchip/TCPIP Stack/WIFI/WFParamMsg.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFPowerSave.o: Microchip/TCPIP\ Stack/WIFI/WFPowerSave.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFPowerSave.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFPowerSave.o" "Microchip/TCPIP Stack/WIFI/WFPowerSave.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFScan.o: Microchip/TCPIP\ Stack/WIFI/WFScan.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFScan.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFScan.o" "Microchip/TCPIP Stack/WIFI/WFScan.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFTxPower.o: Microchip/TCPIP\ Stack/WIFI/WFTxPower.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WFTxPower.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WFTxPower.o" "Microchip/TCPIP Stack/WIFI/WFTxPower.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Eint.o: Microchip/TCPIP\ Stack/WIFI/WF_Eint.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Eint.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Eint.o" "Microchip/TCPIP Stack/WIFI/WF_Eint.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Spi.o: Microchip/TCPIP\ Stack/WIFI/WF_Spi.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WIFI/WF_Spi.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WIFI/WF_Spi.o" "Microchip/TCPIP Stack/WIFI/WF_Spi.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/WiFi/WF_pbkdf2.o: Microchip/TCPIP\ Stack/WiFi/WF_pbkdf2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WiFi 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/WiFi/WF_pbkdf2.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/WiFi/WF_pbkdf2.o" "Microchip/TCPIP Stack/WiFi/WF_pbkdf2.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/ARP.o: Microchip/TCPIP\ Stack/ARP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/ARP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/ARP.o" "Microchip/TCPIP Stack/ARP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Announce.o: Microchip/TCPIP\ Stack/Announce.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Announce.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Announce.o" "Microchip/TCPIP Stack/Announce.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/AutoIP.o: Microchip/TCPIP\ Stack/AutoIP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/AutoIP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/AutoIP.o" "Microchip/TCPIP Stack/AutoIP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/BerkeleyAPI.o: Microchip/TCPIP\ Stack/BerkeleyAPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/BerkeleyAPI.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/BerkeleyAPI.o" "Microchip/TCPIP Stack/BerkeleyAPI.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCP.o: Microchip/TCPIP\ Stack/DHCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DHCP.o" "Microchip/TCPIP Stack/DHCP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCPs.o: Microchip/TCPIP\ Stack/DHCPs.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DHCPs.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DHCPs.o" "Microchip/TCPIP Stack/DHCPs.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DNS.o: Microchip/TCPIP\ Stack/DNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DNS.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DNS.o" "Microchip/TCPIP Stack/DNS.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DNSs.o: Microchip/TCPIP\ Stack/DNSs.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DNSs.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DNSs.o" "Microchip/TCPIP Stack/DNSs.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/DynDNS.o: Microchip/TCPIP\ Stack/DynDNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/DynDNS.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/DynDNS.o" "Microchip/TCPIP Stack/DynDNS.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/FTP.o: Microchip/TCPIP\ Stack/FTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/FTP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/FTP.o" "Microchip/TCPIP Stack/FTP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/FileSystem.o: Microchip/TCPIP\ Stack/FileSystem.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/FileSystem.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/FileSystem.o" "Microchip/TCPIP Stack/FileSystem.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/HTTP2.o: Microchip/TCPIP\ Stack/HTTP2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/HTTP2.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/HTTP2.o" "Microchip/TCPIP Stack/HTTP2.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Hashes.o: Microchip/TCPIP\ Stack/Hashes.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Hashes.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Hashes.o" "Microchip/TCPIP Stack/Hashes.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Helpers.o: Microchip/TCPIP\ Stack/Helpers.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Helpers.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Helpers.o" "Microchip/TCPIP Stack/Helpers.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/ICMP.o: Microchip/TCPIP\ Stack/ICMP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/ICMP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/ICMP.o" "Microchip/TCPIP Stack/ICMP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/IP.o: Microchip/TCPIP\ Stack/IP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/IP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/IP.o" "Microchip/TCPIP Stack/IP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/MPFS2.o: Microchip/TCPIP\ Stack/MPFS2.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/MPFS2.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/MPFS2.o" "Microchip/TCPIP Stack/MPFS2.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/NBNS.o: Microchip/TCPIP\ Stack/NBNS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/NBNS.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/NBNS.o" "Microchip/TCPIP Stack/NBNS.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/RSA.o: Microchip/TCPIP\ Stack/RSA.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/RSA.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/RSA.o" "Microchip/TCPIP Stack/RSA.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Random.o: Microchip/TCPIP\ Stack/Random.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Random.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Random.o" "Microchip/TCPIP Stack/Random.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Reboot.o: Microchip/TCPIP\ Stack/Reboot.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Reboot.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Reboot.o" "Microchip/TCPIP Stack/Reboot.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SMTP.o: Microchip/TCPIP\ Stack/SMTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SMTP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SMTP.o" "Microchip/TCPIP Stack/SMTP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMP.o: Microchip/TCPIP\ Stack/SNMP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SNMP.o" "Microchip/TCPIP Stack/SNMP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMPv3.o: Microchip/TCPIP\ Stack/SNMPv3.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNMPv3.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SNMPv3.o" "Microchip/TCPIP Stack/SNMPv3.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SNTP.o: Microchip/TCPIP\ Stack/SNTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SNTP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SNTP.o" "Microchip/TCPIP Stack/SNTP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SPIFlash.o: Microchip/TCPIP\ Stack/SPIFlash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SPIFlash.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SPIFlash.o" "Microchip/TCPIP Stack/SPIFlash.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/SSL.o: Microchip/TCPIP\ Stack/SSL.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/SSL.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/SSL.o" "Microchip/TCPIP Stack/SSL.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/StackTsk.o: Microchip/TCPIP\ Stack/StackTsk.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/StackTsk.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/StackTsk.o" "Microchip/TCPIP Stack/StackTsk.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/TCP.o: Microchip/TCPIP\ Stack/TCP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/TCP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/TCP.o" "Microchip/TCPIP Stack/TCP.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/TCPPerformanceTest.o: Microchip/TCPIP\ Stack/TCPPerformanceTest.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/TCPPerformanceTest.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/TCPPerformanceTest.o" "Microchip/TCPIP Stack/TCPPerformanceTest.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/TFTPc.o: Microchip/TCPIP\ Stack/TFTPc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/TFTPc.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/TFTPc.o" "Microchip/TCPIP Stack/TFTPc.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Telnet.o: Microchip/TCPIP\ Stack/Telnet.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Telnet.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Telnet.o" "Microchip/TCPIP Stack/Telnet.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/Tick.o: Microchip/TCPIP\ Stack/Tick.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/Tick.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/Tick.o" "Microchip/TCPIP Stack/Tick.c"   
	
${OBJECTDIR}/Microchip/TCPIP\ Stack/UDP.o: Microchip/TCPIP\ Stack/UDP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/TCPIP\ Stack 
	@${RM} ${OBJECTDIR}/Microchip/TCPIP\ Stack/UDP.o.d 
	@${RM} "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o" 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o.d" -o "${OBJECTDIR}/Microchip/TCPIP Stack/UDP.o" "Microchip/TCPIP Stack/UDP.c"   
	
${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o: Microchip/Transceivers/MRF24J40/MRF24J40.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Transceivers/MRF24J40 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o.d" -o ${OBJECTDIR}/Microchip/Transceivers/MRF24J40/MRF24J40.o Microchip/Transceivers/MRF24J40/MRF24J40.c   
	
${OBJECTDIR}/Microchip/Transceivers/crc.o: Microchip/Transceivers/crc.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Transceivers 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/crc.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/crc.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Transceivers/crc.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Transceivers/crc.o.d" -o ${OBJECTDIR}/Microchip/Transceivers/crc.o Microchip/Transceivers/crc.c   
	
${OBJECTDIR}/Microchip/Transceivers/security.o: Microchip/Transceivers/security.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/Transceivers 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/security.o.d 
	@${RM} ${OBJECTDIR}/Microchip/Transceivers/security.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/Transceivers/security.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/Transceivers/security.o.d" -o ${OBJECTDIR}/Microchip/Transceivers/security.o Microchip/Transceivers/security.c   
	
${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o: Microchip/WirelessProtocols/P2P/P2P.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/WirelessProtocols/P2P 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o.d 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o.d" -o ${OBJECTDIR}/Microchip/WirelessProtocols/P2P/P2P.o Microchip/WirelessProtocols/P2P/P2P.c   
	
${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o: Microchip/WirelessProtocols/SymbolTime.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/Microchip/WirelessProtocols 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o.d 
	@${RM} ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o 
	@${FIXDEPS} "${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o.d" -o ${OBJECTDIR}/Microchip/WirelessProtocols/SymbolTime.o Microchip/WirelessProtocols/SymbolTime.c   
	
${OBJECTDIR}/MyFiles/MyCAN.o: MyFiles/MyCAN.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyCAN.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyCAN.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyCAN.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyCAN.o.d" -o ${OBJECTDIR}/MyFiles/MyCAN.o MyFiles/MyCAN.c   
	
${OBJECTDIR}/MyFiles/MyConsole.o: MyFiles/MyConsole.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyConsole.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyConsole.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyConsole.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyConsole.o.d" -o ${OBJECTDIR}/MyFiles/MyConsole.o MyFiles/MyConsole.c   
	
${OBJECTDIR}/MyFiles/MyCyclone.o: MyFiles/MyCyclone.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyCyclone.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyCyclone.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyCyclone.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyCyclone.o.d" -o ${OBJECTDIR}/MyFiles/MyCyclone.o MyFiles/MyCyclone.c   
	
${OBJECTDIR}/MyFiles/MyFlash.o: MyFiles/MyFlash.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyFlash.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyFlash.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyFlash.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyFlash.o.d" -o ${OBJECTDIR}/MyFiles/MyFlash.o MyFiles/MyFlash.c   
	
${OBJECTDIR}/MyFiles/MyHTTP.o: MyFiles/MyHTTP.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyHTTP.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyHTTP.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyHTTP.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyHTTP.o.d" -o ${OBJECTDIR}/MyFiles/MyHTTP.o MyFiles/MyHTTP.c   
	
${OBJECTDIR}/MyFiles/MyIO.o: MyFiles/MyIO.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyIO.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyIO.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyIO.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyIO.o.d" -o ${OBJECTDIR}/MyFiles/MyIO.o MyFiles/MyIO.c   
	
${OBJECTDIR}/MyFiles/MyLED.o: MyFiles/MyLED.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyLED.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyLED.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyLED.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyLED.o.d" -o ${OBJECTDIR}/MyFiles/MyLED.o MyFiles/MyLED.c   
	
${OBJECTDIR}/MyFiles/MyMDDFS.o: MyFiles/MyMDDFS.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyMDDFS.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyMDDFS.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyMDDFS.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyMDDFS.o.d" -o ${OBJECTDIR}/MyFiles/MyMDDFS.o MyFiles/MyMDDFS.c   
	
${OBJECTDIR}/MyFiles/MyMIWI.o: MyFiles/MyMIWI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyMIWI.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyMIWI.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyMIWI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyMIWI.o.d" -o ${OBJECTDIR}/MyFiles/MyMIWI.o MyFiles/MyMIWI.c   
	
${OBJECTDIR}/MyFiles/MyMiniProjet.o: MyFiles/MyMiniProjet.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyMiniProjet.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyMiniProjet.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyMiniProjet.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyMiniProjet.o.d" -o ${OBJECTDIR}/MyFiles/MyMiniProjet.o MyFiles/MyMiniProjet.c   
	
${OBJECTDIR}/MyFiles/MyRTCC.o: MyFiles/MyRTCC.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyRTCC.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyRTCC.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyRTCC.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyRTCC.o.d" -o ${OBJECTDIR}/MyFiles/MyRTCC.o MyFiles/MyRTCC.c   
	
${OBJECTDIR}/MyFiles/MySPI.o: MyFiles/MySPI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MySPI.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MySPI.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MySPI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MySPI.o.d" -o ${OBJECTDIR}/MyFiles/MySPI.o MyFiles/MySPI.c   
	
${OBJECTDIR}/MyFiles/MyTemperature.o: MyFiles/MyTemperature.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyTemperature.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyTemperature.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyTemperature.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyTemperature.o.d" -o ${OBJECTDIR}/MyFiles/MyTemperature.o MyFiles/MyTemperature.c   
	
${OBJECTDIR}/MyFiles/MyWIFI.o: MyFiles/MyWIFI.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyWIFI.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyWIFI.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyWIFI.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyWIFI.o.d" -o ${OBJECTDIR}/MyFiles/MyWIFI.o MyFiles/MyWIFI.c   
	
${OBJECTDIR}/MyFiles/MyCamera.o: MyFiles/MyCamera.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyCamera.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyCamera.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyCamera.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyCamera.o.d" -o ${OBJECTDIR}/MyFiles/MyCamera.o MyFiles/MyCamera.c   
	
${OBJECTDIR}/MyFiles/MyApp.o: MyFiles/MyApp.c  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} ${OBJECTDIR}/MyFiles 
	@${RM} ${OBJECTDIR}/MyFiles/MyApp.o.d 
	@${RM} ${OBJECTDIR}/MyFiles/MyApp.o 
	@${FIXDEPS} "${OBJECTDIR}/MyFiles/MyApp.o.d" $(SILENT) -rsi ${MP_CC_DIR}../  -c ${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION) -I"MyIncludes" -I"MyConfig" -I"MyConfig/MyConfig_MIWI" -I"MyConfig/MyConfig_WIFI" -I"MyConfig/MyConfig_MDDFS" -I"Microchip/Include" -I"MyWeb" -MMD -MF "${OBJECTDIR}/MyFiles/MyApp.o.d" -o ${OBJECTDIR}/MyFiles/MyApp.o MyFiles/MyApp.c   
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mdebugger -D__MPLAB_DEBUGGER_PK3=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_PK3=1,--defsym=_min_heap_size=55000
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=55000
	${MP_CC_DIR}\\xc32-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/pic32.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
