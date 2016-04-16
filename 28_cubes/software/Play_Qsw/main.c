/*
 * play_qbert.c
 *
 *  Created on: 14 avr. 2016
 *      Author: Stephane
 */


#include <stdio.h>
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
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 88, sc_xy);

  int qbert_passage = 0;
  int qbert_jump = 0;
  int next_qbert = 1;
  int bad_j = 1;
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 36, qbert_jump);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 28, qbert_passage);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, next_qbert);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 60, bad_j);


  int pause = 1;
  int resume = 0;
  int restart = 0;
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, pause);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52, resume);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48, restart);

  int speed = 300000; // 1 : 100000
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 80, speed);
  int tilt_acc = 0;
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 104, tilt_acc);

  int spi_game_status;
  int spi_jump;
  int spi_acc;

  // instantiation �l�ments pour g�rer le coloriage
  int dir, etc;
  int next;
  int move[2];
  int result = 1;
  int elems, painted, pos;
  elems = 1; painted = 0;
  int count_q = 0;
  int state_qb;
  int pos_qb;
  int write = 1;


  while(1){
	  //printf("debut de boucle");
	  spi_game_status = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 4);
	  spi_jump = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 8);
	  spi_acc = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 12);
	  pos_qb = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 44);

	  if(spi_game_status > 64){
		  switch(spi_game_status){
		  case 65 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, write); break; //pause
		  case 66 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, !write); break; //pause
		  case 67 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52, write); break; //resume
		  case 68 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52, !write); break; //resume
		  case 69 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48, write); break; //restart
		  case 70 : IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48, !write); break; //restart
		  }
	  }
	  //printf("probleme de switch?");
	  // gestion du d�placement du qbert + coloriage des cases

	  if(spi_jump > 16 && pos_qb){
		  dir = spi_jump-16;
		  if (dir>0 && dir<5) {
		  		  move[0] = (dir > 2); // dir=3,4: UP
		  		  move[1] = ((dir % 2)==0); // dir=2,4: LEFT
		  		  //printf("move0: %d; move1: %d\n", move[0], move[1]);
		  		  result = mvmt(move, pos_qb);
		  		  //printf("next cube:%d\n", result);
		  		  //printf("//	Result of %dth test: %d\n", i, result);
		  		  painted = 1<<(result-1);
		  		  next_qbert = painted;
		  		  elems = elems | painted;
		  		  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, next_qbert); // next position qbert
		  		  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 28, elems); // case � colorier
		  		  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 36, dir);
		  }
	  }
	  //printf("avant l'accelerometre\n");
	  if(spi_acc==40) IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 60, write);
	  else if (spi_acc==41) IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 60, !write);
	  else if(spi_acc > 32) IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 100, spi_acc-32);
	  //printf("avant le if\n");
	  count_q = count_q+1;
	  if (count_q>100000) {
		  count_q = 0;
		  state_qb = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 72);
		  printf("Etat du qbert: %d\n", state_qb);
		  printf("game: %d;\t jump: %d;\t accelerometer: %d\n", spi_game_status, spi_jump, spi_acc);
		  //printf("jump: %d\n", spi_jump);
		  //printf("accelerometer: %d\n", spi_acc);
		  printf("Next cube: %d\n", next_qbert);
	  }
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
   int end;
   int k, k2;
   for(k=r_size; k>0; k--) if (n>=rows[k-1]) break;

   if (move[0]) end = n-(k-move[1]); //UP
   else end = n+(k+move[1]); //DOWN

   for(k2=r_size; k2>0; k2--) if (end>=rows[k2-1]) break;

   //printf("move actual: %d, %d	", n, end);
   if (abs(k-k2)==1) return end;
   else return init;
}
