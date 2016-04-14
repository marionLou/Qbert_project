/*
 * test.c
 *
 *  Created on: 29 mars 2016
 *      Author: Stephane
 */
/*
 *
logic [7:0] iSPI;
logic enable;

logic [4:0] A_enable = 5'd0;
logic [4:0] A_iSPI = 5'd1;


// ---- Cube definition ------------//
parameter k = 3; // nombre de cubes
parameter i = 2; // nombre de rang�es

logic [10:0] XLENGTH;
logic [20:0] XYDIAG_DEMI;
logic [20:0] RANK1_XY_OFFSET;
logic [k-1:0]  nios_top_color;

logic [4:0] A_XLENGTH = 5'd2;
logic [4:0] A_XYDIAG_DEMI = 5'd3;
logic [4:0] A_RANK1_XY_OFFSET = 5'd4;
logic [4:0] A_nios_top_color = 5'd5;

// ---- Qbert definition -----------//

logic [20:0] QBERT_POSITION_XY0;
logic [20:0] QBERT_POSITION_XY1;
logic [2:0]	 qbert_jump;
logic nios_start_qbert;
logic bad_jump;
logic done_move;

logic [4:0] A_QBERT_POSITION_XY0 = 5'd6;
logic [4:0] A_QBERT_POSITION_XY1 = 5'd7;
logic [4:0] A_qbert_jump = 5'd8;
logic [4:0] A_nios_start_qbert = 5'd9;
logic [4:0] A_bad_jump = 5'd10;
logic [4:0] A_done_move = 4'd11;
 */

#include <stdio.h>
#include "io.h"
#include "system.h"

int main(void)
{

  int enable = 1;
  int XLENGTH = 55;
  int XDIAG_DEMI = 30;
  int YDIAG_DEMI = 55;
  int XYDIAG_DEMI = (XDIAG_DEMI << 10) | YDIAG_DEMI;
  int RANK1_X_OFFSET = 250;
  int RANK1_Y_OFFSET = 160;
  int RANK1_XY_OFFSET = (RANK1_X_OFFSET << 10) | RANK1_Y_OFFSET;
  int QBERT_POSITION_X0 = 250;
  int QBERT_POSITION_Y0 = 160;
  int QBERT_POSITION_XY0 = (QBERT_POSITION_X0 << 10) | QBERT_POSITION_Y0;
  int qbert_passage = 0x1;
  int qbert_jump = 2;
  int next_qbert = 0x3;
  int bad_j = 1;

  int done = 1;
  int pause = 0;
  int resume = 0;
  int restart = 1;
  int speed = 100000; // 1 : 100000
  int test_cnt;
  test_cnt = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 80);
  printf("start_speed: %d \n", test_cnt);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 76, speed);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, restart);
  //usleep(100000);
  //IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 40, !restart);

  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,0, enable);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,8, XLENGTH);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,12, XYDIAG_DEMI);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,16, RANK1_XY_OFFSET);

  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,24, QBERT_POSITION_XY0);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 28, qbert_jump);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,20, qbert_passage);

  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 32, next_qbert);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 44, resume);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 48, pause);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 52, bad_j);
  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 56, done);
/* int position;
  while(1){
 	  position = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 72);
 	  printf("game: %d \n", position);
  }*/
  /*
   * Code pour g�rer le coloriage des cases
   */
  int cmd;
  int dir, etc;
  int next;
  int move[2];
  int result;
  int elems, painted, pos;
  elems = 1; painted = 0;
  pos = 1;

/*
 // while(1){
	  dir = 0x2;
	  pos = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 36);
	  //cmd = IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,28);
	  //dir = cmd-32;
//	  if (dir>0 && dir<5) {
		  move[0] = (dir > 2); // dir=3,4: UP
		  move[1] = ((dir % 2)==0); // dir=2,4: LEFT
		  result = mvmt(move, pos);
		  //printf("//	Result of %dth test: %d\n", i, result);
		  painted = 1<<(result-1);
		  elems = elems | painted;
		  //printf("This turn: %d;	Elems so far: %d\n", painted, elems);
//		  painted = 0; pos = result;
		  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 32, painted); // next position qbert
		  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE, 28, dir);
		  IOWR_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,20, elems); // case � colorier
		//  while (!IORD_32DIRECT(NIOS_MTL_CONTROLLER_0_BASE,40)) usleep(10); // ADD address for done
//		}
 // }

*/

  printf("Move my Qbert!\n");


  return 0;
}

int r_size = 6;
int rows[6] = {1, 2, 4, 7, 11, 16};

int mvmt(int move[2], int init)
{

   int n = 1;
   while(init != (1 << (n-1))){
	   n++;
   }
   int end;
   int k, k2;
   for(k=r_size; k>0; k--) if (n>=rows[k-1]) break;

   if (move[0]) end = n-(k-move[1]); //UP
   else end = n+(k+move[1]); //DOWN

   for(k2=r_size; k2>0; k2--) if (end>=rows[k2-1]) break;

   printf("move actual: %d, %d	", n, end);
   if (abs(k-k2)==1) return end;
   else return init;
}
