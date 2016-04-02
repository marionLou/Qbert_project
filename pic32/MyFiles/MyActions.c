#include "MyApp.h"

void GetActions(char *Msg){
    // The only instruction we have so far is "YourLevel:#"
	// If it is this one, we happly it,
	// else we just print the message we got on the terminal
    char theStr[128];
	char * token, noNumber;
	token = strtok (Msg,"_,.-:");
/*	if (strcmp(token, "YourLevel") == 0) {
		token = strtok(NULL, " ,.-:");
		if (strcmp(token, "1")==0){
			MyDif_Level="Easy";
			mPORTBSetPinsDigitalIn(USD_CD);
			MyMDDFS_loadOneshow(1);
		}
		else if (strcmp(token, "2")==0) {
			MyDif_Level="Medium";
			mPORTBSetPinsDigitalIn(USD_CD);
			MyMDDFS_loadOneshow(2);
		}
		else if (strcmp(token, "3")==0) {
			MyDif_Level="Hard";
			mPORTBSetPinsDigitalIn(USD_CD);
			MyMDDFS_loadOneshow(3);
		}
		else MyConsole_SendMsg("Fuck it");

			MyConsole_SendMsg("Your difficulty level has been adapted, except if I said fuck it before!\n>");
		}*/
    if(strcmp(token, "Color") == 0){
        token = strtok(NULL, "");
        int cat = strtol(token, &noNumber, 10);
        MyCyclone_Write(1,cat);
        sprintf(theStr, "Receive LT-TOUCH Msg '%d'\n>", cat);
    }
    else if(strcmp(token, "Dir") == 0){
        token = strtok(NULL, "");
        int cat = strtol(token, &noNumber, 10);
        if (noNumber == token) {
            fprintf(stderr, "No digits were found\n");
            MyConsole_SendMsg(stderr);
            exit(EXIT_FAILURE);
        }
        else{
            cat = 32+cat;
            MyCyclone_Write(1,cat);
            sprintf(theStr, "Receive LT-TOUCH Msg (+2^5) '%d'\n>", cat);
        }
    }
    else if (strcmp(token, "TestPika") == 0){
        MyConsole_SendMsg("These actions work!");
    }
	else {
        sprintf(theStr, "Receive MIWI Msg '%s'\n>", Msg);
        MyConsole_SendMsg(theStr);
	}    
}