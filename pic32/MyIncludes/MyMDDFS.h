/*******************************************************************************
* Header file for MyFDDFS                                                      *
*******************************************************************************/

#include "MDD File System/FSIO.h"

#ifndef MyFDDFS_H_
#define MyFDDFS_H_

/*******************************************************************************
* Constants                                                                    *
*******************************************************************************/



/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void MyMDDFS_SaveSPI(void);
void MyMDDFS_RestoreSPI(void);
void MyMDDFS_Init(void);
void MyMDDFS_loadSlideshow(char* theCmd);
void MyMDDFS_loadStartShow(void);
int  MyMDDFS_ReadImg (char* name);
long MyMDDFS_getImageInfo(FSFILE* inputFile, long offset, int numberOfChars);
void MyMDDFS_Test(void);


#endif /* MyFDDFS_H_ */