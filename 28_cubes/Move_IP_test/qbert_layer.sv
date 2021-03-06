/*
	couleur orange R = 216
						G = 95
						B = 2
						version : 01/04/16 21:16
	
*/
// position des cases se trouvant sur les bords droites et gauches
`define TOP 32'h00000001

`define R02 32'h00000002
`define R04 32'h00000008
`define R07 32'h00000040
`define R11 32'h00000400
`define R16 32'h00008000
`define R22 32'h00200000

`define L03 32'h00000004
`define L06 32'h00000020
`define L10 32'h00000200
`define L15 32'h00004000
`define L21 32'h00100000
`define L28 32'h08000000

/* Pour faire facilement la condition dans l'accéléromètre,
   je crois qu'on peut faire un OR entre position_qb et Rside,
   puis voir si c'est different de 0.
   Les underscores définnissent les séparations entre lignes
   (normalement verilog les ignore simplement)
   */
`define Rside 32'b0000_0000001_000001_00001_0001_001_01_1
`define Lside 32'b0000_1000000_100000_10000_1000_100_10_1

module qbert_layer(

//------INPUT--------------------//	
	input logic clk,
	input logic reset,
	input logic e_start_qb,
	input logic e_resume_qb,
	input logic e_pause_qb,
	input logic e_win_qb,
	input logic e_bad_jump,
	input logic [31:0] e_speed_qb,
	input logic [27:0] position_qb,
	input logic [27:0] e_next_qb,
	input logic [2:0] e_jump_qb,
	input logic [10:0] x_cnt, x_offset,  
	input logic [9:0] y_cnt, y_offset,
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,
	input logic [20:0] soucoupe_xy,
	input logic [1:0] e_tilt_acc,
	input logic qb_on_sc,
	input logic done_move_sc,

//------OUTPUT-------------------//
	output logic [20:0] qbert_xy,
	output logic [3:0] KO_qb, 
	output logic [2:0] state_qb, 
	output logic [2:0] game_qb, // variable pour tester dans 
													// quel état se trouve qbert
													// dans le nios
	output logic [31:0] test_count, // checker le nombre de clock qu'il 
												// faut pour accrémenter d'un bit
												// l'animation du démarrage
	output logic mode_saucer,
	output logic qbert_hitbox,
	output logic done_move,
	output logic [1:0] saucer_qb_state,
	output logic le_qbert

	);
	
parameter N_cube;
logic [10:0] x0; 
logic [9:0]  y0; 
logic [10:0] XC = 11'd100;
logic [9:0] YC = 10'd180;
//{XC,YC} = {11'd100,10'd180}
reg done_move_reg;

//--------- zone qbert----------
logic pied_gauche;
logic pied_droit;
logic jambe_gauche;
logic jambe_droite;
logic tete;
logic museau;
logic [5:0] is_qbert;


logic [31:0] move_count = 32'b0;
logic [31:0] ko_count = 32'b0;
logic [31:0] start_count = 32'b0;
logic [31:0] sc_count = 32'b0;
logic [31:0] df_speed = 32'd100000; 
logic [31:0] speed;
logic [10:0] shade_x = 11'd0;
logic [10:0] start_x = 11'd0;

typedef enum logic {PLUS, ZERO} anim_t;
anim_t move_anim;

reg ko_anim, start_anim;
reg [1:0] saucer_anim;

typedef enum logic [2:0] {START=3'd0, JUMP=3'd1, IDLE=3'd2, SAUCER=3'd3, KO=3'd4} qstate_t;
qstate_t qbert_state;

typedef enum logic [2:0] {INTRO, RESUME, PAUSE, RESTART, WIN} state_t;
state_t game_state;


always_ff @(posedge clk) begin

speed <= (e_speed_qb != 1'b0) ? e_speed_qb : df_speed; // use default if (e_speed_qb==0)	
/*
	e_jump_qb = 001 : DOWN_RIGHT
					 010 : DOWN_LEFT
					 011 : UP_RIGHT
					 100 : UP_LEFT
*/
case(game_state)
	INTRO :	begin
					
				end
	RESUME :	begin 
					if(e_pause_qb)	game_state <= PAUSE;
					else begin
						case(qbert_state)
							START : begin 
										start_count <= start_count + 1'b1;
										{x0,y0} <= {x_offset - (XLENGTH) + start_x, y_offset};
										{XC,YC} <= {x_offset - (XLENGTH) + start_x, y_offset + YDIAG_DEMI};
										case(start_anim)
											1'b0 :  if( start_count[16] == 1'b1 ) begin
														if (start_x < XLENGTH) start_x <= start_x + 11'd1;
														else begin
															start_count <= 32'b0;
															done_move_reg <= 1'b1;
															start_x <= 11'd0;
															qbert_state <= IDLE;
														end
														test_count <= start_count;
														start_anim <= 1'b1;
													end
											1'b1 : if(start_count[16] == 1'b0) start_anim <= 1'b0;
										endcase 												
									end
							JUMP :   begin 
											if( move_count == speed ) begin
												if (e_jump_qb == 3'b001) begin
													if (YC > y0)
														{XC,YC} <= {XC , YC - 10'd1}; 
													else if (XC < x0 + XDIAG_DEMI + XLENGTH)
														{XC,YC} <= {XC + 11'd1, YC};
													else begin
														done_move_reg <= 1'b1;
														if (e_win_qb) game_state <= WIN;
														else if (!e_bad_jump) qbert_state <= IDLE;
														else  qbert_state <= KO;								
													end
												end
												else if (e_jump_qb == 3'b010) begin
													if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
														{XC,YC} <= {XC , YC + 10'd1}; 
													else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
														{XC,YC} <= {XC + 11'd1, YC}; 
													else begin
														done_move_reg <= 1'b1;
														if (e_win_qb) game_state <= WIN;
														else if (!e_bad_jump) qbert_state <= IDLE;
														else qbert_state <= KO;								
													end
												end
												else if (e_jump_qb == 3'b011) begin
													if (XC > x0 - XDIAG_DEMI - XLENGTH) 
														{XC,YC} <= {XC - 11'd1, YC }; 
													else if (YC > y0) 
														{XC,YC} <= {XC , YC - 10'd1} ; 
													else begin
														done_move_reg <= 1'b1;
														if (e_win_qb) game_state <= WIN;
														else if (!e_bad_jump) qbert_state <= IDLE;
														else qbert_state <= KO;								
													end
												end
												else if (e_jump_qb == 3'b100) begin
													if (XC > x0 - XDIAG_DEMI - XLENGTH) 
														{XC,YC} <= {XC - 11'd1, YC }; 
													else if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
														{XC,YC} <= {XC , YC + 10'd1} ; 
													else begin
														done_move_reg <= 1'b1;
														if (e_win_qb) game_state <= WIN;
														else if (!e_bad_jump) qbert_state <= IDLE;
														else qbert_state <= KO;								
													end
												end
												move_count <= 1'b0;
											end else move_count <= move_count + 32'd1;	
										end
							IDLE :  begin 
										{x0,y0} <= {XC, YC - YDIAG_DEMI};
										if(e_jump_qb !=0 && position_qb != e_next_qb && e_tilt_acc == 2'b0) begin
											done_move_reg <= 1'b0;
											qbert_state <= JUMP;
										end
										else if(e_tilt_acc == 2'd1) begin
											mode_saucer <= 1'b1;
											// je pense qu'on peut ramener ca en une ligne comme ca
											// (Rside, est defini au dessus, et pareil pour Lside bien sur)
											if ((position_qb & `Rside) != 0) qbert_state <= SAUCER;
											/*if(position_qb == `TOP) qbert_state <= SAUCER;
											else if(position_qb == `R02) qbert_state <= SAUCER;
											else if(position_qb == `R04) qbert_state <= SAUCER;
											else if(position_qb == `R07) qbert_state <= SAUCER;
											else if(position_qb == `R11) qbert_state <= SAUCER;
											else if(position_qb == `R16) qbert_state <= SAUCER;
											else if(position_qb == `R22) qbert_state <= SAUCER;*/
										end
										else if(e_tilt_acc == 2'd2) begin
											mode_saucer <= 1'b1;
											if(position_qb == `TOP) qbert_state <= SAUCER;
											else if(position_qb == `L03) qbert_state <= SAUCER;
											else if(position_qb == `L06) qbert_state <= SAUCER;
											else if(position_qb == `L10) qbert_state <= SAUCER;
											else if(position_qb == `L15) qbert_state <= SAUCER;
											else if(position_qb == `L21) qbert_state <= SAUCER;
											else if(position_qb == `L28) qbert_state <= SAUCER;
										end
									end
							SAUCER:	begin
										sc_count <= sc_count + 32'd1;
										case(saucer_anim)
											2'b00 : if( sc_count == speed ) begin
														if (e_tilt_acc == 2'd1) begin
															if (YC > y0-YDIAG_DEMI) begin
																{XC,YC} <= {XC , YC - 10'd1};
																saucer_anim <= 2'b01;
															end
															else begin
																done_move_reg <= 1'b1;
																if (!qb_on_sc) qbert_state <= KO;
																else saucer_anim <= 2'b10; 																			
															end
														end
														else if (e_tilt_acc == 2'd2) begin
															if (YC < y0+YDIAG_DEMI+YDIAG_DEMI+YDIAG_DEMI) begin 
																{XC,YC} <= {XC , YC + 10'd1};
																saucer_anim <= 2'b01;
															end
															else begin
																done_move_reg <= 1'b1;
																if (!qb_on_sc) qbert_state <= KO;
																else saucer_anim <= 2'b10;
															end
															sc_count <= 1'b0;
														end
													end
											2'b01 : begin // put done_move_reg to 0 only once is enough 
														done_move_reg <= 1'b0;
														saucer_anim <= 2'b0; 
													end
											2'b10 : begin
														if(done_move_sc) begin 
															mode_saucer <= 1'b0;
															saucer_anim <= 2'b0;
															qbert_state <= START;
														end
														else {XC,YC} <= soucoupe_xy;
													end
										endcase
									end
							KO : 	begin
//										if(!e_bad_jump) qbert_state <= IDLE;
//										else qbert_state <= START;
										ko_count <= ko_count + 1'b1;
										case(ko_anim)
											1'b0 :  if( ko_count[17] == 1'b1 ) begin
														if (shade_x < ( XDIAG_DEMI/11'd2 + 11'd2*XDIAG_DEMI/11'd3))
															shade_x <= shade_x + 11'd1;
														else begin
															KO_qb <= KO_qb + 1'b1;
															ko_count <= 32'b0;
															shade_x <= 11'd0;
															// pq cette condition?
															// si on est ici, c'est qu'on fait le bad jump non?
															//if(!position_qb) qbert_state <= IDLE;
															qbert_state <= START;
														end
														ko_anim <= 1'b1;
													end
											1'b1 :  if(ko_count[17] == 1'b0) ko_anim <= 1'b0;
										endcase 
									end
						endcase
					end	
				end
	PAUSE : 	begin 
					if(e_resume_qb) game_state <= RESUME;
					else if (e_start_qb) game_state <= RESTART;
				end
	WIN: 		if (e_start_qb) game_state <= RESTART;
				// + set a variable to have the brightness of pause menu
	RESTART : begin
						qbert_state <= START;
						start_x <= 11'd0;
						shade_x <= 11'd0;
						KO_qb <= 1'b0;
						{XC,YC} <= 21'b0;
						mode_saucer <= 1'b0;
						saucer_anim <= 2'b0;
						game_state <= RESUME;
				 end
	endcase
	
	state_qb <= qbert_state;
	game_qb <= game_state;
end	


//---------LeQbert------------------------//
	
always_ff @(posedge clk) begin	

if (e_jump_qb == 3'd1 || e_jump_qb == 3'd3) begin
	pied_gauche <= { (y_cnt <= YC + YDIAG_DEMI/10'd6  && y_cnt >= YC - YDIAG_DEMI/10'd6)	
						&& (x_cnt >= XC + XDIAG_DEMI/11'd2 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
						
	pied_droit <= { (y_cnt <= YC - YDIAG_DEMI/10'd12  && y_cnt >= YC - 10'd5*YDIAG_DEMI/10'd12)
						&& (x_cnt >= XC + XDIAG_DEMI/11'd2 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
	
	jambe_droite <= {	(y_cnt <= YC - YDIAG_DEMI/10'd12 && y_cnt >= YC - YDIAG_DEMI/10'd6)
							&& (x_cnt >= XC + XDIAG_DEMI/11'd3 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
							
	jambe_gauche <= {	(y_cnt <= YC + YDIAG_DEMI/10'd6 && y_cnt >= YC + YDIAG_DEMI/10'd12)
							&& (x_cnt >= XC + XDIAG_DEMI/11'd3 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
	
	tete <= {(y_cnt >= YC - YDIAG_DEMI/10'd4 && y_cnt <= YC + YDIAG_DEMI/10'd4) 
			&& (x_cnt <= XC + XDIAG_DEMI/11'd3 && x_cnt >= XC - XDIAG_DEMI/11'd2)};
			
	museau <= {(y_cnt <= YC - YDIAG_DEMI/10'd4 && y_cnt >= YC - 11'd2*YDIAG_DEMI/10'd3) 
			&& (x_cnt <= XC + XDIAG_DEMI/11'd3 && x_cnt >= XC - XDIAG_DEMI/11'd4)};
			
	qbert_hitbox <= {( y_cnt <= YC + YDIAG_DEMI/10'd4 &&  y_cnt >= YC - 11'd2*YDIAG_DEMI/10'd3)
			&& (x_cnt >= XC - XDIAG_DEMI/11'd2 + shade_x && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3 )};
			
end
else begin 

	pied_gauche <= { (y_cnt >= YC + YDIAG_DEMI/10'd6  && y_cnt <= YC + YDIAG_DEMI/10'd2)	
						&& (x_cnt >= XC + XDIAG_DEMI/11'd2 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
						
	pied_droit <= { (y_cnt >= YC - YDIAG_DEMI/10'd6 && y_cnt < YC + YDIAG_DEMI/10'd6)
						&& (x_cnt >= XC + XDIAG_DEMI/11'd2 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
	
	jambe_droite <= {	(y_cnt >= YC - YDIAG_DEMI/10'd6 && y_cnt <= YC - YDIAG_DEMI/10'd12)
							&& (x_cnt >= XC + XDIAG_DEMI/11'd3 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
							
	jambe_gauche <= {	(y_cnt >= YC + YDIAG_DEMI/10'd12 && y_cnt <= YC + YDIAG_DEMI/10'd6)
							&& (x_cnt >= XC + XDIAG_DEMI/11'd3 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
	
	tete <= {(y_cnt >= YC - YDIAG_DEMI/10'd4 && y_cnt <= YC + YDIAG_DEMI/10'd4) 
			&& (x_cnt <= XC + XDIAG_DEMI/11'd3 && x_cnt >= XC - XDIAG_DEMI/11'd2)};
			
	museau <= {(y_cnt >= YC + YDIAG_DEMI/10'd4 && y_cnt <= YC + 11'd2*YDIAG_DEMI/10'd3) 
			&& (x_cnt <= XC + XDIAG_DEMI/11'd3 && x_cnt >= XC - XDIAG_DEMI/11'd4)};
			
	qbert_hitbox <= {( y_cnt >= YC - YDIAG_DEMI/10'd4 &&  y_cnt <= YC + 11'd2*YDIAG_DEMI/10'd3)
			&& (x_cnt >= XC - XDIAG_DEMI/11'd2 + shade_x && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};
			
end
	
	is_qbert <= {pied_gauche, jambe_gauche, pied_droit, jambe_droite, tete, museau};
	

end

assign saucer_qb_state = saucer_anim;
assign done_move = done_move_reg;	
assign le_qbert = (is_qbert != 6'b0);
assign qbert_xy = {XC,YC};

endmodule
