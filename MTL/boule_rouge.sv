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
	input logic [5:0] e_move_br, // déplacement de la boule rouge 
	input logic [20:0] e_XY0_br,
	
	input logic e_start_qb, // état du jeux
	input logic e_resume_qb,
	input logic e_pause_qb,
	
	input logic e_bad_jump,
	input logic [31:0] e_speed_qb,
	input logic qbert_hitbox,
	input logic KO_qb,
	
	input logic done_move_sc,

//------OUTPUT-------------------//

	output logic [20:0] boule_rouge_xy,  
	output logic boule_rouge_hitbox,
	output logic br_state,
	output logic boule_rouge_end,
	output logic [4:0] br_mvt_cnt,
	output logic done_move_br,
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




typedef enum logic [2:0] {INIT, START, IDLE, MOVE, END} brstate_t;
brstate_t boule_rouge_state;

typedef enum logic [1:0] {RESUME, PAUSE, RESTART} state_t;
state_t game_state;


always_ff @(posedge clk) begin

speed <= (e_speed_qb != 1'b0) ? e_speed_qb : df_speed;	


case(game_state)
	RESUME :	begin 
					if(e_pause_qb)	game_state <= PAUSE;
					else begin
						if (done_move_sc) boule_rouge_state <= END;
						else if (freeze_power) boule_rouge_state <= IDLE;
						else if (KO_qb) boule_rouge_state <= END;
						case(boule_rouge_state)
								INIT : 	begin 
											if(e_enable_br) begin
												{x0,y0} <= {e_XY0_br[20:10] - (XLENGTH) + start_x, e_XY0_br[9:0]};
												{XC,YC} <= {e_XY0_br[20:10] - (XLENGTH) + start_x, e_XY0_br[9:0] + YDIAG_DEMI};
												boule_rouge_state <= START;
											end 
										end
								START : begin
											{XC,x0} <= {XC,x0} + {start_x,start_x};
											if( count[16] == 1'b1 ) begin
												count <= 1'b0;
												if (start_x < XLENGTH)
													start_x <= start_x + 11'd1;
												else begin
													mvt_cnt <= 4'd1;
													mvt_reg <= e_move_br[0];
													done_move_reg <= 1'b1;
													start_x <= 11'd0;
													boule_rouge_state <= IDLE;
												end				
											end
											else count <= count + 1'b1;
										end
								IDLE : 	begin
											if(!freeze_power) begin
												done_move_reg <= 1'b0;
												if(count[19]==1'b1) begin 
													count <= 1'b0;
													boule_rouge_state <= MOVE;
													if (mvt_cnt = 5'd2) mvt_reg <= e_move_br[1];
													else (mvt_cnt = 5'd3) mvt_reg <= e_move_br[2];
													else (mvt_cnt = 5'd4) mvt_reg <= e_move_br[3];
													else (mvt_cnt = 5'd5) mvt_reg <= e_move_br[4];
													else (mvt_cnt = 5'd6) mvt_reg <= e_move_br[5];
												end
												else count <= count + 1'b1;
											end
										end
								MOVE : begin 
											if( count == speed ) begin
												count <= 1'b0;
													if (mvt_reg == 1'b0) begin
														if (YC > y0) 
															{XC,YC} <= {XC , YC - 10'd1}; 
														else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC + 11'd1, YC};
														else begin
															done_move_reg <= 1'b1;
															if (mvt_cnt == 5'6) begin
																mvt_cnt <= 1'b0;
																boule_rouge_state <= END;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																boule_rouge_state <= IDLE;
															end																
														end
													end
													else if (mvt_reg == 1'b1) begin
														if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
															{XC,YC} <= {XC , YC + 10'd1}; 
														else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC + 11'd1, YC}; 
														else begin
															done_move_reg <= 1'b1;
															if (mvt_cnt == 5'6) begin
																mvt_cnt <= 1'b0;
																boule_rouge_state <= END;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																boule_rouge_state <= IDLE;
															end
														end
													end
											end
											else count <= count + 1'b1;
										end
								END : 	begin
											if( count[17] == 1'b1 ) begin
												count <= 1'b0;
												if (shade_x < (YDIAG_DEMI>>1)) /// MODIFICATION
													shade_x <= shade_x + 11'd1;
												else begin
													count <= 32'b0;
													shade_x <= 11'd0;
													boule_rouge_end <= 1'b1;
													boule_rouge_state <= INIT;
												end
											end
											else count <= count + 1'b1;
										end
						endcase
					end	
				end
	PAUSE : 	begin 
					if(e_resume_qb) game_state <= RESUME;
					else if (e_start_qb) game_state <= RESTART;
				end
	RESTART : begin
						boule_rouge_state <= INIT;
						start_x <= 11'd0;
						shade_x <= 11'd0;
						{XC,YC} <= 21'b0;
						game_state <= RESUME;
				 end
	endcase
end	


//---------LaBouleRouge------------------------//
	
always_ff @(posedge clk) begin	
	
	is_boule_rouge <= (x_cnt - XC)*(x_cnt - XC)+(y_cnt - XC)*(y_cnt - XC) <= (YDIAG_DEMI*YDIAG_DEMI >> 2);
	
	boule_rouge_hitbox <= {(x_cnt <= e_XY0_br[20:10] + (YDIAG_DEMI>>2) && x_cnt >= e_XY0_br[20:10] - (YDIAG_DEMI>>2) + shade_x)
							&& (y_cnt <= (e_XY0_br[20:10]+YDIAG_DEMI) + (YDIAG_DEMI>>2) && y_cnt >= (e_XY0_br[20:10]+YDIAG_DEMI) - (YDIAG_DEMI>>2))};

end

assign br_mvt_cnt = mvt_cnt;
assign br_state = boule_rouge_state;
assign boule_rouge_end = br_end;
assign done_move_br = done_move_reg;	
assign la_boule_rouge = is_boule_rouge;
assign boule_rouge_xy = {XC,YC};

endmodule
