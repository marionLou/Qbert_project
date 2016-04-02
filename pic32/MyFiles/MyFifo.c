
/*
 * Copyright 2002 Sun Microsystems, Inc.  All rights reserved.
 * Use is subject to license terms.
 */

/*
 * Routines for manipulating a FIFO queue
 */

#include "MyApp.h"

// Definition of the "node" type
typedef struct fifonode {
	int fn_id;
    char *fn_data;
	struct fifonode *fn_next;
};

// Definition of a FIFO
typedef struct fifo {
	fifonode_t *f_head;
	fifonode_t *f_tail;
    int fSize;
};

// Create a new FIFO
fifo_t * fifo_new(void)
{
	fifo_t *f;

	f = calloc(1,sizeof (fifo_t));
    f->fSize = 0;

	return (f);
}

/* Add an item to the end of the fifo */
void fifo_add(fifo_t *f, char *data)
{
	fifonode_t *fn = malloc(sizeof (fifonode_t));
    
    	char * split;
    	int id = strtol(data, &split, 10);
    	fn->fn_id = id;
        fn->fn_data = data;
        fn->fn_next = NULL;
        f->fSize = f->fSize+1;

	// If the FIFO is empty, the new item becomes
	// the head and the tail at the same time
	if (f->f_tail == NULL)	f->f_head = f->f_tail = fn;
	else
	{
		f->f_tail->fn_next = fn;
		f->f_tail = fn;
	}
}


/* Remove an item from the front (head) of the fifo */
int fifo_remove(fifo_t *f)
{
	fifonode_t *fn;
	char *data;

	if ((fn = f->f_head) == NULL)
	{
        free(fn);
		return 0;
	}

	data = fn->fn_data;
    f->fSize = f->fSize-1;
	// If the fifo has only one element,
	// it becomes empty after the removal
	if ((f->f_head = fn->fn_next) == NULL)	f->f_tail = NULL;

	free(fn);
	return 1;
}

// Returns 1 if the fifo is empty, else it returns 0
int fifo_isEmpty(fifo_t *f)
{
	if (f->f_head == NULL) return 1;
	else return 0;
}

int fifo_getSize(fifo_t *f)
{
	return f->fSize;
}

// Returns the id of the first element, else 0
int fifo_getID(fifo_t *f)
{
	if (f->f_head == NULL) return 0;
	else
	{
	        int id = f->f_head->fn_id;
	        return id;
	}
}

// Returns the message of the first element, else 0
char * fifo_getString(fifo_t *f)
{
    	fifonode_t *fn;

	if ((fn = f->f_head) == NULL)
	{
        	return NULL;
	}
	else
	{
	        char *data;
	        data = fn->fn_data;
        	return data;
	}
    
}
