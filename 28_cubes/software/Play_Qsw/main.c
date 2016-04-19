/*
 * play_qbert.c
 *
 *  Created on: 14 avr. 2016
 *      Author: Stephane
 */


#include <stdio.h>
#include <stdlib.h>
#include "io.h"
#include "system.h"

int main(void)
{

  int enable = 1;
  int XLENGTH = 22;
  int XDIAG_DEMI = 15;
  int YDIAG_DEMI = 22;
  int XYDIAG_DEMI = (XDIAG_DEMI << 10) | YDIAG_DEMI;
  int RANK1_X_OFFSET = 250;
  int RANK1_Y_OFFSET = 190;
  int RANK1_XY_OFFSET = (RANK1_X_OFFSET << 10) | RANK1_Y_OFFSET;
  int QBERT_POSITION_X0 = 250;
  int QBERT_POSITION_Y0 = 190;
  int QBERT_POSITION_XY0 = (QBERT_POSITION_X0 << 10) | QBERT_POSITION_Y0;
  int sc_x = RANK1_X_OFFSET + 3*(XLENGTH+XDIAG_DEMI);
  int sc_y = RANK1_Y_OFFSET - 5*YDIAG_DEMI;
  int sc_xy = (sc_x << 10) | sc_y;

  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,0, enable);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,16, XLENGTH);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,20, XYDIAG_DEMI);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,24, RANK1_XY_OFFSET);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,32, QBERT_POSITION_XY0);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 92, sc_xy);

  int qbert_passage = 0;
  int qbert_jump = 0;
  int next_qbert = 1;
  int bad_j = 0;
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 36, qbert_jump);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 28, qbert_passage);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, next_qbert);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 64, bad_j);


  int pause = 1;
  int resume = 0;
  int restart = 0;
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, pause);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52, resume);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48, restart);

  int speed = 300000; // 1 : 100000
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 84, speed);
  int tilt_acc = 0;
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 108, tilt_acc);

  int game_level = 2;

  int spi_game_status, spi_jump, spi_acc;
  int up_game_status = 0;
  int up_jump = 0;
  int up_acc = 0;
  int old_game_status = 0;
  int old_jump = 0;
  int old_acc = 0;

  // instantiation �l�ments pour g�rer le coloriage
  int dir, etc;
  int next;
  int move[2];
  int result = 1;
  int elems, painted;
  elems = 1; painted = 0;
  int count_q = 0;
  int state_qb, pos_qb, state_game;
  int write = 1;
  int rd_pause, rd_start, rd_resume, rd_tilt;

  /*int q;
  int red[2+game_level][4];
  int old_move[2+game_level];
  int curr_move[2+game_level];
  for (q=1; q<2+game_level; q++){
	  red[q][0] = rand()%1; red[q][1] = rand()%1;
	  red[q][2] = rand()%1; red[q][3] = rand()%1;
  }*/
  
  // write the first move on the redball
  /* In while:
	 curr_move is assign to the actual done_move_reg and
	 old_move is assigned to the previous value of done_move_reg.
	 Once curr_move is equal to 1 and old_move to 0, this means
	 a jump has been executed and we can write the next move.
  */


  while(1){
	
	
	
	pos_qb = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 44);
	spi_game_status = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 4);
	spi_jump = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 8);
	spi_acc = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 12);
	up_game_status = (spi_game_status > 64);
	up_jump = (spi_jump > 16);
	up_acc = (spi_acc > 32);

	if(up_game_status != old_game_status){
		old_game_status = !old_game_status;
		if (up_game_status) spi_game_status = spi_game_status - 64;
		switch(spi_game_status){
		case 1 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52, !write); 	   // !resume
				 IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48, !write); 	   // !restart
				 IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, write);  break; // pause
		case 2 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, !write); 	   // !pause
				 IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52, write);  break; // resume
		case 3 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, !write); 	   // !pause
				 IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 36, 0);
				 IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 64, 0);
				 IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48, write);  break; // restart
		}
	}
	//printf("probleme de switch?");
	// gestion du d�placement du qbert + coloriage des cases

	if((up_jump != old_jump) && pos_qb){
		old_jump = !old_jump;
		if (up_jump) dir = spi_jump - 16;
		else dir = spi_jump;
		if (dir>0 && dir<5) {
			move[0] = (dir > 2); // dir=3,4: UP
		  	move[1] = ((dir % 2)==0); // dir=2,4: LEFT
		  	//printf("move0: %d; move1: %d\n", move[0], move[1]);
		  	result = mvmt(move, pos_qb);
		  	//printf("next cube:%d\n", result);
		  	//printf("//	Result of %dth test: %d\n", i, result);
		  	IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 36, dir);
			if (result==0){
				int QS, oldQS; // Qbert state
				QS = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 76); // qbert state
				while (QS != 0){
					if (QS!=oldQS && QS==4){
						IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 36, 0); // no jump
					}
					QS = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 76);
				}
				IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, 1);
			}
			else {
				painted = 1<<(result-1);
				next_qbert = painted;
				elems = elems | painted;
				IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, next_qbert); // next position qbert
				IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 28, elems); // case � colorier
				usleep(10);
				IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 44, next_qbert); // next position qbert
			}
		}
	}
	  
	if(up_acc != old_acc){
		old_acc = !old_acc;
		if (up_acc) spi_acc = spi_acc - 32;
		//if(spi_acc==4) IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 64, write);
		//else if (spi_acc==5) IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 64, !write);
		//else
			IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 108, spi_acc);
	}
	//printf("avant le if\n");
	count_q = count_q+1;
	if (count_q>2000) {
		rd_resume = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52); 	   // resume
		rd_start = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48); 	   // restart
		rd_pause = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56);	   // pause
		count_q = 0;
		state_qb = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 76);
		state_game = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 80);
		rd_tilt = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 108);	   // tilt
		//if (state_qb) {
			//IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 64, !bad_j);
			//IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, 1);
		//}
		printf("Etat du qbert: %d;\t etat du jeu: %d\n", state_qb, state_game);
		printf("game_status: %d;\t jump: %d;\t accelerometer: %d\n", spi_game_status, spi_jump, spi_acc);
		printf("resume: %d;\t restart: %d;\t pause: %d\n", rd_resume, rd_start, rd_pause);
		printf("Tilt value: %d\n", rd_tilt);
		printf("Actual cube: %d; next cube: %d\n", pos_qb, next_qbert);

	}
	usleep(100);
  }




  printf("Move my Qbert!\n");


  return 0;
}

int r_size = 7;
int rows[7] = {1, 2, 4, 7, 11, 16, 22};

int mvmt(int move[2], int init)
{

   int n = 1;
   while(init != (1 << (n-1))){
	   n++;
	   //printf("Value of init (%d) and n (%d)\n", init, n);
   }
   printf("value of init: %d\n", n);
   int end;
   int k, k2;
   for(k=r_size; k>0; k--) if (n>=rows[k-1]) break;

   if (move[0]) end = n-(k-move[1]); //UP
   else end = n+(k+move[1]); //DOWN
   printf("value of end: %d\n", end);

   for(k2=r_size; k2>0; k2--) if (end>=rows[k2-1]) break;
   printf("value of lines: %d; %d\n", k, k2);
   //printf("move actual: %d, %d	", n, end);
   if (abs(k-k2)==1) return end;
   else {
	   IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 44, 0);
	   return 0;
   }
}

