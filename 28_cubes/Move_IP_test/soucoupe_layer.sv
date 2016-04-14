module soucoup_layer(
//------INPUT--------------------//
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,
	
	input logic e_pause_qb,
	input logic e_start_qb,
	input logic e_resume_qb,
	input logic [31:0] e_speed_qb,
	input logic [20:0] e_XY0_qb,
	input logic [20:0] e_XY0_sc,
	
	input logic [20:0] qbert_xy,
	input logic qbert_hitbox,
	input logic mode_saucer,
//------OUTPUT-------------------//
	output logic [20:0] soucoupe_xy,
	output logic qb_on_sc,
	output logic done_move_sc,
	output logic soucoupe_hitbox,
	output logic [1:0] state_sc, // etat de la soucoupe
	output logic la_soucoupe
	);

// -- GAME STATE && SOUCOUPE STATE ------- //

logic is_qb_on_sc;
logic done_move_reg = 1'b0;


logic [10:0] XC, x_end;
logic [9:0] YC, y_end;
assign x_end = e_XY0_qb[20:10] - (XLENGTH + XDIAG_DEMI);
assign y_end = e_XY0_qb[9:0] + YDIAG_DEMI;

logic signed [11:0] dy;
assign dy = (e_XY0_sc[9:0] - (e_XY0_qb[9:0] + YDIAG_DEMI));
//logic left_side = (dy >= 0); 	// 1 : si la soucoupe se trouve à gauche de la pyramide
									// 0 : si la soucoupe se trouve à droite de la pyramide


//assign x_step = e_XY0_qb[20:10];
//assign y_step = e_XY0_qb[9:0] + YDIAG_DEMI; 

logic [31:0] df_speed = 32'd100000;
logic [31:0] speed;
 
logic [31:0] count = 32'b0;

logic [10:0] shade_x = 11'd0;
logic enable = 1'b1;
	
typedef enum logic {PLUS, ZERO} anim_t;
anim_t move_anim;

reg end_anim;

typedef enum logic [1:0] {BEGIN, MOVE, END} soucoupe_t;
soucoupe_t souc_state;
	
typedef enum logic [1:0] {RESUME = 2'b00, PAUSE = 2'b01 , RESTART = 2'b10} state_t;
state_t game_state;

always_ff @(posedge clk) begin

speed <= (e_speed_qb != 1'b0) ? e_speed_qb : df_speed;

case(game_state)
	RESUME :	begin 
					if(e_pause_qb)	game_state <= PAUSE;
					else begin
						case(souc_state)
								BEGIN : begin
												enable <= 1'b1;
												{XC,YC} <= {e_XY0_sc[20:10], e_XY0_sc[9:0] + YDIAG_DEMI};
												if(mode_saucer && is_qb_on_sc) begin // 2'b11 == SAUCER
													done_move_reg <= 1'b0;
													souc_state <= MOVE;
												end
											end
								END : begin 
												if (enable) begin 
													count <= count + 1'b1;
													case(end_anim)
														1'b0 : if( count[17] == 1'b1 ) begin
																	if (shade_x < d_hb_x)
																		shade_x <= shade_x + 11'd1;
																	else begin
																				count <= 32'b0;
																				shade_x <= 11'd0;
																				enable <= 1'b0;
																			end
																	end_anim <= 1'b1;
																 end
														1'b1 : if(count[17] == 1'b0) end_anim <= 1'b0;
													endcase
												end
											end
								MOVE : begin 
												count <= count + 32'd1;
												case(move_anim)
													PLUS : if( count == speed ) begin
																if (dy >= 0) begin
																	if (XC > x_end) 
																		{XC,YC} <= {XC - 10'd1, YC}; 
																	else if (YC > y_end) 
																		{XC,YC} <= {XC, YC - 10'd1};
																	else begin
																		done_move_reg <= 1'b1;
																		souc_state <= END;								
																	end
																	count <= 1'b0;
																	move_anim <= ZERO;
																end
																else begin
																	if (XC > x_end) 
																		{XC,YC} <= {XC - 10'd1, YC}; 
																	else if (YC < y_end) 
																		{XC,YC} <= {XC, YC + 10'd1};
																	else begin
																		done_move_reg <= 1'b1;
																		souc_state <= END;								
																	end
																	count <= 1'b0;
																	move_anim <= ZERO;
																end
															end 
													ZERO : begin 
																done_move_reg <= 1'b0;
																move_anim <= PLUS;  
															end
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
						souc_state <= BEGIN;
						shade_x <= 11'd0;
						{XC,YC} <= 21'b0;
						done_move_reg <= 1'b0;
						game_state <= RESUME;
				 end
	endcase
end

// --- AFFICHAGE de la soucoupe ---------- //
logic [10:0] hb_x1,hb_x2,hb_x3;
logic [9:0] hb_y1,hb_y2,hb_y3;
logic [11:0] d_hb_x;
reg hb_n1,hb_n2,hb_n3;


assign hb_x1 = (XDIAG_DEMI)/11'd4;
assign hb_x2 = (XDIAG_DEMI)/11'd2;
assign hb_x3 = (XDIAG_DEMI+XDIAG_DEMI+XDIAG_DEMI)/11'd4;
assign d_hb_x = (XDIAG_DEMI+XDIAG_DEMI+XDIAG_DEMI)/11'd2;

assign hb_y1 = (YDIAG_DEMI)/10'd4;
assign hb_y2 = (YDIAG_DEMI)/10'd2;
assign hb_y3 = (YDIAG_DEMI+YDIAG_DEMI+YDIAG_DEMI)/10'd4;

always_ff@(posedge clk) begin
	/*
		hb_x1 <= (XDIAG_DEMI)/11'd4;
	hb_x2 <= (XDIAG_DEMI)/11'd2;
	hb_x3 <= (XDIAG_DEMI+XDIAG_DEMI+XDIAG_DEMI)/11'd4;
	
	hb_y1 <= (YDIAG_DEMI)/10'd4;
	hb_y2 <= (YDIAG_DEMI)/10'd2;
	hb_y3 <= (YDIAG_DEMI+XDIAG_DEMI+XDIAG_DEMI)/10'd4; */
	if(!enable) begin 
		{hb_n1,hb_n2,hb_n3,soucoupe_hitbox} <= 4'b0;	
	end
	else begin
	hb_n1 <= {(x_cnt <= XC + hb_x1 && x_cnt >= XC - hb_x1)
				&&(y_cnt <= YC + hb_y3 && y_cnt >= YC - hb_y3)};
				
	hb_n2 <= {(x_cnt <= XC + hb_x2 && x_cnt >= XC - hb_x2)
				&&(y_cnt <= YC + hb_y2 && y_cnt >= YC - hb_y2)};
				
	hb_n3 <= {(x_cnt <= XC + hb_x3 && x_cnt >= XC - hb_x3)
				&&(y_cnt <= YC + hb_y1 && y_cnt >= YC - hb_y1)};
	
	soucoupe_hitbox <= {(x_cnt <= XC + hb_x3 - shade_x && x_cnt >= XC - hb_x3)
							&&(y_cnt <= YC + hb_y3 && y_cnt >= YC - hb_y3)};
	end
	
	soucoupe_xy <= {XC,YC};
	
end

assign qb_on_sc = is_qb_on_sc;
assign done_move_sc = done_move_reg;
assign state_sc = souc_state;
assign la_soucoupe = ({hb_n1,hb_n2,hb_n3}!=3'b0);	

soucoupe_qbert beta(
	clk,
	YDIAG_DEMI,
	e_XY0_sc,
	qbert_xy,
	is_qb_on_sc
	);

endmodule

module soucoupe_qbert(

	input logic clk, 
	input logic [9:0] YDIAG_DEMI,
	input logic [20:0] e_XY0_sc,
	input logic [20:0] qbert_xy,
	
	output logic is_qb_on_sc
);

always_ff @(posedge clk) begin
	is_qb_on_sc <= {(qbert_xy[20:10] <= e_XY0_sc[20:10] + 11'd15 
						&& qbert_xy[20:10] >= e_XY0_sc[20:10] - 11'd15)
						&&(qbert_xy[9:0] <= (e_XY0_sc[9:0]+YDIAG_DEMI) + 10'd15 
						&& qbert_xy[9:0] >= (e_XY0_sc[9:0]+YDIAG_DEMI) - 10'd15)};
end
endmodule 