/*******************************************************************************
* Header file for MySPI                                                        *
*******************************************************************************/

#ifndef MySPI_H_
#define MySPI_H_

/*******************************************************************************
* Functions Prototypes                                                         *
*******************************************************************************/

void            MySPI_Init(void);
void            MySPI_Close(void);
void            MySPI_PutC(unsigned int theData);
unsigned int    MySPI_GetC(void);
unsigned int    MySPI_PutGetC(unsigned int theData);

#endif /* MySPI_H_ */
