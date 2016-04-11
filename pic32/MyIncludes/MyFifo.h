/* 
 * File:   MyFifo.h
 * Author: Louis_M
 *
 * Created on 18 février 2016, 23:00
 */

#ifndef MYFIFO_H
#define	MYFIFO_H

typedef struct fifonode fifonode_t;
typedef struct fifo fifo_t;

fifo_t * fifo_new(void);
void fifo_add(fifo_t *f, char *data);
int fifo_remove(fifo_t *f);
int fifo_isEmpty(fifo_t *f);
int fifo_getSize(fifo_t *f);

int fifo_getID(fifo_t *f);
char * fifo_getString(fifo_t *f);

#endif	/* MYFIFO_H */

