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

module serpent_layer(

//------INPUT--------------------//	
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,
	
	input logic e_enable_sp, //  apparition de la boule rouge
	input logic [4:0] e_move_sp, // déplacement de la boule rouge 
	input logic [20:0] e_XY0_sp,
	
	input logic e_start_qb, // état du jeux
	input logic e_resume_qb,
	input logic e_pause_qb,
	
	input logic e_bad_jump,
	input logic [31:0] e_speed_qb,
	input logic qbert_hitbox,
	input logic [20:0] qbert_xy,
	input logic KO_qb,
	
	input logic done_move_sc,
	
	input logic freeze_power,

//------OUTPUT-------------------//

	output logic [20:0] serpent_xy,  
	output logic serpent_hitbox,
	output logic sp_state,
	output logic sp_end,
	output logic [10:0] sp_points,
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

logic [3:0] is_serpent;
logic shape_boule;


logic [31:0] count = 32'b0;
logic [4:0] mvt_cnt = 5'b0; // compte le nbre de déplacement
logic mvt_reg;
logic [31:0] df_speed = 32'd100000; 
logic [31:0] speed;
logic [10:0] shade_x = 11'd0;
logic [10:0] start_x = 11'd0;




typedef enum logic [2:0] {INIT, START, IDLE, MOVE_1, MOVE_2, CHANGE, END} brstate_t;
spstate_t serpent_state;

typedef enum logic [1:0] {RESUME, PAUSE, RESTART} state_t;
state_t game_state;


always_ff @(posedge clk) begin

speed <= (e_speed_qb != 1'b0) ? e_speed_qb : df_speed;	


case(game_state)
	RESUME :	begin 
					if(e_pause_qb)	game_state <= PAUSE;
					else begin
						if (done_move_sc) boule_rouge_state <= END;
						else if (freeze_power) serpent_state <= IDLE;
						else if (KO_qb) serpent_state <= END;
						case(serpent_state)
								INIT : 	begin 
											if(e_enable_sp) begin
												{x0,y0} <= {e_XY0_sp[20:10] - (XLENGTH) + start_x, e_XY0_sp[9:0]};
												{XC,YC} <= {e_XY0_sp[20:10] - (XLENGTH) + start_x, e_XY0_sp[9:0] + YDIAG_DEMI};
												change_x <= 1'b0;
												start_x <= 1'b0;
												shade_x <= 1'b0;
												shape_boule <= 1'b1;
												shape_serpent <= 1'b0;
												serpent_state <= START;
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
													mvt_reg_1 <= e_move_sp[0];
													done_move_reg <= 1'b1;
													start_x <= 11'd0;
													serpent_state <= IDLE;
												end				
											end
											else count <= count + 1'b1;
										end
								IDLE : 	begin
											{x0,y0} <= {XC,YC-YDIAG_DEMI};
											if(!freeze_power) begin
												done_move_reg <= 1'b0;
												if(count[19]==1'b1) begin 
													count <= 1'b0;
													if(shape_boule) begin 
													
														serpent_state <= MOVE_1;
														if (mvt_cnt = 5'd2) mvt_reg_1 <= e_move_sp[1];
														else (mvt_cnt = 5'd3) mvt_reg_1 <= e_move_sp[2];
														else (mvt_cnt = 5'd4) mvt_reg_1 <= e_move_sp[3];
														else (mvt_cnt = 5'd5) mvt_reg_1 <= e_move_sp[4];
													else begin
														serpent_state <= MOVE_2;
														
														if (XC > qbert_xy[20:10] && YC > qbert_xy[9:0]) begin
															
															mvt_reg_2 <= 3'd1;
														end
														else if (XC > qbert_xy[20:10] && YC < qbert_xy[9:0]) begin
															
															mvt_reg_2 <= 3'd2;
														end
														else if (XC < qbert_xy[20:10] && YC > qbert_xy[9:0]) begin 
															
															mvt_reg_2 <= 3'd3;
														end
														else if (XC < qbert_xy[20:10] && YC < qbert_xy[9:0]) begin 
															
															mvt_reg_2 <= 3'd4;
														end
														else if ((XC < qbert_xy[20:10] | XC > qbert_xy[20:10]) && 
																(YC < qbert_xy[9:0] - 10'd10 & YC > qbert_xy[9:0] + 10'd10)) begin
																
																if (chance_cnt[0]) mvt_reg_2 <= 3'd4;
																else mvt_reg_2 <= 3'd3;
														end
														else if (XC < qbert_xy[20:10] - 11'd10 & XC > qbert_xy[20:10] + 10'd10)
																(YC < qbert_xy[9:0] | YC > qbert_xy[9:0])) begin
																
																if (chance_cnt[0]) mvt_reg_2 <= 3'd2;
																else mvt_reg_2 <= 3'd1;
														end
													end
													
												end
												else count <= count + 1'b1;
											end
										end
								MOVE_1 : begin 
											if( count == speed ) begin
												count <= 1'b0;
													if (mvt_reg_1 == 1'b0) begin
														if (YC > y0) 
															{XC,YC} <= {XC , YC - 10'd1}; 
														else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC + 11'd1, YC};
														else begin
															done_move_reg <= 1'b1;
															if (mvt_cnt == 5'd5) begin
																mvt_cnt <= 1'b0;
																shape_serpent <= 1'b1;
																serpent_state <= CHANGE;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																serpent_state <= IDLE;
															end																
														end
													end
													else if (mvt_reg_1 == 1'b1) begin
														if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
															{XC,YC} <= {XC , YC + 10'd1}; 
														else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC + 11'd1, YC}; 
														else begin
															done_move_reg <= 1'b1;
															if (mvt_cnt == 5'd5) begin
																mvt_cnt <= 1'b0;
																shape_serpent <= 1'b1;
																serpent_state <= CHANGE;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																serpent_state <= IDLE;
															end
														end
													end
											end
											else count <= count + 1'b1;
										end
								MOVE_2 : 	begin
												if( count == speed ) begin
												count <= 1'b0;
													if (mvt_reg_2 == 3'd1) begin
														if (YC > y0) 
															{XC,YC} <= {XC , YC - 10'd1}; 
														else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC + 11'd1, YC};
														else begin
															done_move_reg <= 1'b1;
															if (position_sp == 1'd0) begin
																mvt_cnt <= 1'b0;
																sp_end <= 1'b1;
																serpent_state <= END;
																if(qb_on_sc) sp_points <= 10'd500;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																serpent_state <= IDLE;
															end																
														end
													end
													else if (mvt_reg_2 == 3'd2) begin
														if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
															{XC,YC} <= {XC , YC + 10'd1}; 
														else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC + 11'd1, YC}; 
														else begin
															done_move_reg <= 1'b1;
															if (position_sp == 1'd0) begin
																mvt_cnt <= 1'b0;
																sp_end <= 1'b1;
																serpent_state <= END;
																if(qb_on_sc) sp_points <= 10'd500;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																serpent_state <= IDLE;
															end
														end
													end
													else if (mvt_reg_2 == 3'd3) begin
														if (YC > y0 + YDIAG_DEMI + YDIAG_DEMI) 
															{XC,YC} <= {XC , YC - 10'd1}; 
														else if (XC > x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC - 11'd1, YC}; 
														else begin
															done_move_reg <= 1'b1;
															if (position_sp == 1'd0) begin
																mvt_cnt <= 1'b0;
																sp_end <= 1'b1;
																serpent_state <= END;
																if(qb_on_sc) sp_points <= 10'd500;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																serpent_state <= IDLE;
															end
														end
													end
													else if (mvt_reg_2 == 3'd4) begin
														if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
															{XC,YC} <= {XC , YC + 10'd1}; 
														else if (XC > x0 + XDIAG_DEMI + XLENGTH) 
															{XC,YC} <= {XC - 11'd1, YC}; 
														else begin
															done_move_reg <= 1'b1;
															if (position_sp == 1'd0) begin
																mvt_cnt <= 1'b0;
																sp_end <= 1'b1;
																serpent_state <= END;
																if(qb_on_sc) sp_points <= 10'd500;
															end
															else begin 
																mvt_cnt <= mvt_cnt + 1;
																serpent_state <= IDLE;
															end
														end
													end
												end
												else count <= count + 1'b1;
											end
								CHANGE :	begin
												if(count[18] == 1'b1) begin
													count <= 1'b0;
													if(change_x < (XDIAG_DEMI+XLENGTH))
														change_x <= change_x + 11'd1;
													else begin
														count <= 1'b0;
														shape_boule <= 1'b0; // on passe à la forme serpent
														serpent_state <= IDLE;
													//	change_x <= 1'b0; Il ne faut pas mettre à 0
													// à la fin de la transformation
													end 
												end
												else count <= count + 1'b1;
											end
								END : 	begin
											if( count[17] == 1'b1 ) begin
												count <= 1'b0;
												if (shade_x < (XDIAG_DEMI+XLENGTH)) /// MODIFICATION
													shade_x <= shade_x + 11'd1;
												else begin
													count <= 32'b0;
													shade_x <= 11'd0;
													serpent_end <= 1'b1;
													serpent_state <= INIT;
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

logic tete, tronc, queue_1, queue_2;
logic boule_mauve;
logic change_hitbox;
logic [10:0] change_x;
logic shape_boule;
logic shape_serpent;
// logic hitbox_boule;
// logic hitbox_shape1, hitbox_shape2;

always_ff @(posedge clk) begin
	
	
if (shape_boule) 	
	boule_mauve <= {(x_cnt - XC)*(x_cnt - XC)+(y_cnt - XC)*(y_cnt - XC) <= (YDIAG_DEMI*YDIAG_DEMI )>> 2};
else boule_mauve <= 1'b0;

if(!shape_serpent) 
		{tete,tronc,queue_1,queue_2} <= 4'b0;
else begin
if(serpent_state == MOVE_2) begin 
		if(mvt_reg_2 == 3'd2 || mvt_reg_2 == 3'd4) begin 
		tete <= {(x_cnt <= XC - 11'd3*(XDIAG_DEMI>>2) && x_cnt >= XC - XDIAG_DEMI )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>1) )};
			
		tronc <= {(x_cnt >= XC - 11'd3*(XDIAG_DEMI>>2) && x_cnt <= XC + (XDIAG_DEMI>>1) )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
		queue_1 <= {(x_cnt <= XC + (XDIAG_DEMI>>1) && x_cnt >= XC + (XDIAG_DEMI>>2) )
				&&(y_cnt >= YC - 11'd3*(YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
		queue_2 <= {(x_cnt <= XC + (XDIAG_DEMI>>2) && x_cnt >= XC)
				&&(y_cnt <= YC - 11'd3*(YDIAG_DEMI>>2) && y_cnt >= YC - YDIAG_DEMI )};
	end
	else begin 
	
		tete <= {(x_cnt <= XC - 11'd3*(XDIAG_DEMI>>2) && x_cnt >= XC - XDIAG_DEMI )
				&&(y_cnt <= YC + (YDIAG_DEMI>>2) && y_cnt >= YC - (YDIAG_DEMI>>1) )};
			
		tronc <= {(x_cnt >= XC - 11'd3*(XDIAG_DEMI>>2) && x_cnt <= XC + (XDIAG_DEMI>>1) )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
		queue_1 <= {(x_cnt <= XC + (XDIAG_DEMI>>1) && x_cnt >= XC + (XDIAG_DEMI>>2) )
				&&(y_cnt <= YC + 11'd3*(YDIAG_DEMI>>2) && y_cnt >= YC - (YDIAG_DEMI>>2) )};
			
		queue_2 <= {(x_cnt <= XC + (XDIAG_DEMI>>2) && x_cnt >= XC)
				&&(y_cnt >= YC + 11'd3*(YDIAG_DEMI>>2) && y_cnt <= YC + YDIAG_DEMI )};
	end
	end
else begin 
	if(mvt_reg_2 == 3'd1 || mvt_reg_2 == 3'd3) begin 
		tete <= {(x_cnt <= XC - 11'd3*(XLENGTH>>2) && x_cnt >= XC - XLENGTH )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>1) )};
			
		tronc <= {(x_cnt >= XC - 11'd3*(XLENGTH>>2) && x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
		queue_1 <= {(x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) && x_cnt >= XC + (XDIAG_DEMI>>1) )
				&&(y_cnt >= YC - 11'd3*(YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
		queue_2 <= {(x_cnt <= XC + (XDIAG_DEMI>>1) && x_cnt >= XC)
				&&(y_cnt <= YC - 11'd3*(YDIAG_DEMI>>2) && y_cnt >= YC - (YDIAG_DEMI>>1) )};
				
		// hitbox_shape1 <= {(x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) && x_cnt >= XC - XLENGTH )
						// &&(y_cnt >= YC - (YDIAG_DEMI>>1) && y_cnt <= YC + (YDIAG_DEMI>>1)};
	end
	else begin 
	
		tete <= {(x_cnt <= XC - 11'd3*(XLENGTH>>2) && x_cnt >= XC - XLENGTH )
				&&(y_cnt <= YC + (YDIAG_DEMI>>2) && y_cnt >= YC - (YDIAG_DEMI>>1) )};
			
		tronc <= {(x_cnt >= XC - 11'd3*(XLENGTH>>2) && x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
		queue_1 <= {(x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) && x_cnt >= XC + (XDIAG_DEMI>>1) )
				&&(y_cnt <= YC + 11'd3*(YDIAG_DEMI>>2) && y_cnt >= YC - (YDIAG_DEMI>>2) )};
			
		queue_2 <= {(x_cnt <= XC + (XDIAG_DEMI>>1) && x_cnt >= XC)
				&&(y_cnt <= YC + 11'd3*(YDIAG_DEMI>>2) && y_cnt >= YC + (YDIAG_DEMI>>1) )};
				
		// hitbox_shape1 <= {(x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) && x_cnt >= XC - XLENGTH )
						// &&(y_cnt >= YC - (YDIAG_DEMI>>1) && y_cnt <= YC + (YDIAG_DEMI>>1)};
	end
end
end
	
	change_hitbox <= {(x_cnt <= XC + XDIAG_DEMI && x_cnt >= XC - XLENGTH + change_x)
					&&(y_cnt <= YC + XDIAG_DEMI && y_cnt >= YC + XDIAG_DEMI )};
					
	serpent_hitbox <= {(x_cnt <= XC + XDIAG_DEMI && x_cnt >= XC - XLENGTH + shade_x)
					&&(y_cnt <= YC + XDIAG_DEMI && y_cnt >= YC + XDIAG_DEMI )};
					
	is_serpent <= (change_hitbox)? boule : {tete,tronc,queue_1,queue_2}; 

end

assign sp_mvt_cnt = mvt_cnt;
assign sp_state = boule_rouge_state;
assign sp_end = serpent_end;
assign done_move_sp = done_move_reg;	
assign le_serpent = is_serpent;
assign serpent_xy = {XC,YC};

endmodule
