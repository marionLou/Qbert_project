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

module boule_rouge_layer(

//------INPUT--------------------//	
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,
	
	input logic e_enable_br, //  apparition de la boule rouge
	input logic [6:0] e_move_br, // déplacement de la boule rouge
	input logic [20:0] e_XY0_br,
	
	input logic e_start_qb, // état du jeux
	input logic e_resume_qb,
	input logic e_pause_qb,
	
	input logic e_bad_jump,
	input logic [31:0] e_speed_qb,
	input logic qbert_hitbox,
	
	input logic done_move_sc,
	// input logic [27:0] position_qb,
	// input logic [27:0] e_next_qb,
	// input logic [2:0] mvt_reg,
	// input logic [10:0] x_offset,  
	// input logic [9:0]  y_offset,
	// input logic [20:0] soucoupe_xy,
	// input logic [1:0] e_tilt_acc,
	// input logic qb_on_sc,

//------OUTPUT-------------------//
	output logic [20:0] boule_rouge_xy,
	output logic [3:0] KO_qb, 
	output logic [2:0] state_qb, 
	output logic [2:0] game_qb, 
	
	output logic boule_rouge_hitbox,
	output logic done_move,
	output logic la_boule_rouge

	);
	
parameter N_cube;

logic [10:0] x0; 
logic [9:0]  y0; 
logic [10:0] XC = 11'd100;
logic [9:0] YC = 10'd180;

reg done_move_reg;

//--------- zone qbert----------

logic is_boule_rouge;


logic [31:0] count = 32'b0;
logic [4:0] mvt_cnt = 5'b0; // compte le nbre de déplacement
logic mvt_reg;
logic [31:0] df_speed = 32'd100000; 
logic [31:0] speed;
logic [10:0] shade_x = 11'd0;
logic [10:0] start_x = 11'd0;



reg ko_anim, start_anim;
reg [1:0] end_anim; 
reg [1:0] saucer_anim;

typedef enum logic [2:0] {START, MOVE, END} brstate_t;
brstate_t br_state;

typedef enum logic [1:0] {RESUME, PAUSE, RESTART} state_t;
state_t game_state;


always_ff @(posedge clk) begin

speed <= (e_speed_qb != 1'b0) ? e_speed_qb : df_speed;	

if (mvt_cnt = 5'd1) mvt_reg <= e_move_br[0];
else (mvt_cnt = 5'd2) mvt_reg <= e_move_br[1];
else (mvt_cnt = 5'd3) mvt_reg <= e_move_br[2];
else (mvt_cnt = 5'd4) mvt_reg <= e_move_br[3];
else (mvt_cnt = 5'd5) mvt_reg <= e_move_br[4];
else (mvt_cnt = 5'd6) mvt_reg <= e_move_br[5];
else mvt_reg <= 1'b0;


case(game_state)
	RESUME :	begin 
					if(e_pause_qb)	game_state <= PAUSE;
					else begin
						if (e_enable_br & !done_move_sc) br_state <= START;
						else if (done_move_sc) br_state <= END;
						case(br_state)
								START : begin 
												{x0,y0} <= {e_XY0_br[20:10] - (XLENGTH) + start_x, e_XY0_br[9:0]};
												{XC,YC} <= {e_XY0_br[20:10] - (XLENGTH) + start_x, e_XY0_br[9:0] + YDIAG_DEMI};
												case(start_anim)
													1'b0 : if( count[16] == 1'b1 ) begin
																if (start_x < XLENGTH)
																	start_x <= start_x + 11'd1;
																else begin
																			count <= 32'b0;
																			mvt_cnt <= 4'd1;
																			done_move_reg <= 1'b1;
																			start_x <= 11'd0;
																			br_state <= MOVE;
																		end
																start_anim <= 1'b1;
															end
															else count <= count + 1'b1;
													1'b1 : if(count[16] == 1'b0) start_anim <= 1'b0;
												endcase 												
											end
								MOVE : begin 
												count <= count + 32'd1;
												case(move_anim)
														if( count == speed ) begin
																if (mvt_reg == 1'b0) begin
																	if (YC > y0) 
																		{XC,YC} <= {XC , YC - 10'd1}; 
																	else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
																		{XC,YC} <= {XC + 11'd1, YC};
																	else begin
																		done_move_reg <= 1'b1;
																		if (mvt_cnt == 5'd7) begin
																			mvt_cnt <= 1'b0;
																			br_state <= END;
																		end
																		else  mvt_cnt <= mvt_cnt + 1;								
																	end
																	count <= 1'b0;
																	move_anim <= ZERO;
																end
																else if (mvt_reg == 1'b1) begin
																	if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
																		{XC,YC} <= {XC , YC + 10'd1}; 
																	else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
																		{XC,YC} <= {XC + 11'd1, YC}; 
																	else begin
																		done_move_reg <= 1'b1;
																		if (mvt_cnt == 5'd7) begin
																			mvt_cnt <= 1'b0;
																			br_state <= END;
																		end
																		else mvt_cnt <= mvt_cnt + 1;
																	end
																	count <= 1'b0;
																	move_anim <= ZERO;
																end
															end
														else begin count <= count + 1'b1;
																	done_move_reg <= 1'b0;
														end
												endcase
										end
								END : 	begin
												case(end_anim)
													2'b00 : if( count[17] == 1'b1 ) begin
																if (shade_x < ( XDIAG_DEMI >> 1 )) /// MODIFICATION
																	shade_x <= shade_x + 11'd1;
																else begin
																		count <= 32'b0;
																		shade_x <= 11'd0;
																		end_anim <= 2'b10;
																	end
																end_anim <= 2'b1;
															 end
															 else count <= count + 1'b1;
													2'b01 : if(count[17] == 1'b0) end_anim <= 2'b0;
													2'b10 : if(e_enable_br) br_state <= START;
												endcase 
										end
						endcase
					end	
				end
	PAUSE : 	begin 
					if(e_resume_qb) game_state <= RESUME;
					else if (e_start_qb) game_state <= RESTART;
				end
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

if (mvt_reg == 3'd1 || mvt_reg == 3'd3) begin
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
