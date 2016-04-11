/*
	couleur orange R = 216
						G = 95
						B = 2
						version : 01/04/16 21:16
	
*/
module qbert_layer(

//------INPUT--------------------//	
	input logic clk,
	input logic reset,
	input logic e_start_qb,
	input logic e_resume_qb,
	input logic e_pause_qb,
	input logic e_bad_jump,
	input logic [31:0] e_speed_qb,
	input logic [N_cube-1:0] position_qb,
	input logic [N_cube-1:0] e_next_qb,
	input logic [2:0] e_jump_qb,
	input logic [10:0] x_cnt, x_offset,  
	input logic [9:0] y_cnt, y_offset,
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,

//------OUTPUT-------------------//
	output logic [20:0] qbert_xy,
	output logic [3:0] KO_qb, 
	output logic [2:0] state_qb, game_qb,
	output logic [31:0] test_count,
	output logic qbert_hitbox,
	output logic done_move,
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
logic [31:0] df_speed = 32'd50; // 2^16
logic [31:0] speed;
logic [10:0] shade_x = 11'd0;
logic [10:0] start_x = 11'd0;

typedef enum logic {PLUS, ZERO} anim_t;
anim_t move_anim;

reg ko_anim, start_anim;

typedef enum logic [1:0] {START = 2'b00, JUMP = 2'b01, IDLE = 2'b10, KO = 2'b11} qstate_t;
qstate_t qbert_state;

typedef enum logic [1:0] {RESUME = 2'b00, PAUSE = 2'b01 , RESTART = 2'b10} state_t;
state_t game_state;


always_ff @(posedge clk) begin

speed <= (e_speed_qb != 1'b0) ? e_speed_qb : df_speed;	
/*
	e_jump_qb = 001 : DOWN_RIGHT
					 010 : DOWN_LEFT
					 011 : UP_RIGHT
					 100 : UP_LEFT
*/
case(game_state)
	RESUME :	begin 
					if(e_pause_qb)	game_state <= PAUSE;
					else begin
						case(qbert_state)
								START : begin 
												start_count <= start_count + 1'b1;
												{x0,y0} <= {x_offset - (XLENGTH) + start_x, y_offset};
												{XC,YC} <= {x_offset - (XLENGTH) + start_x, y_offset + YDIAG_DEMI};
												case(start_anim)
													1'b0 : if( start_count[16] == 1'b1 ) begin
																if (start_x < XLENGTH)
																	start_x <= start_x + 11'd1;
																else begin
																			test_count <= start_count;
																			start_count <= 32'b0;
																			done_move_reg <= 1'b1;
																			start_x <= 11'd0;
																			qbert_state <= IDLE;
																		end
																start_anim <= 1'b1;
															 end
													1'b1 : if(start_count[16] == 1'b0) start_anim <= 1'b0;
												endcase 												
											end
								JUMP : begin 
												move_count <= move_count + 32'd1;
												case(move_anim)
													PLUS : if( move_count == speed ) begin
																if (e_jump_qb == 3'b001) begin
																	if (YC > y0) 
																		{XC,YC} <= {XC , YC - 10'd1}; 
																	else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
																		{XC,YC} <= {XC + 11'd1, YC};
																	else begin
																		done_move_reg <= 1'b1;
																		if (!e_bad_jump) qbert_state <= IDLE;
																		else  qbert_state <= KO;								
																	end
																	move_count <= 1'b0;
																	move_anim <= ZERO;
																end
																else if (e_jump_qb == 3'b010) begin
																	if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
																		{XC,YC} <= {XC , YC + 10'd1}; 
																	else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
																		{XC,YC} <= {XC + 11'd1, YC}; 
																	else begin
																		done_move_reg <= 1'b1;
																		if (!e_bad_jump) qbert_state <= IDLE;
																		else qbert_state <= KO;								
																	end
																	move_count <= 1'b0;
																	move_anim <= ZERO;
																end
																else if (e_jump_qb == 3'b011) begin
																	if (XC > x0 - XDIAG_DEMI - XLENGTH) 
																		{XC,YC} <= {XC - 11'd1, YC }; 
																	else if (YC > y0) 
																		{XC,YC} <= {XC , YC - 10'd1} ; 
																	else begin
																		done_move_reg <= 1'b1;
																		if (!e_bad_jump) qbert_state <= IDLE;
																		else qbert_state <= KO;								
																	end
																	move_count <= 1'b0;
																	move_anim <= ZERO;				
																end
																else if (e_jump_qb == 3'b100) begin
																	if (XC > x0 - XDIAG_DEMI - XLENGTH) 
																		{XC,YC} <= {XC - 11'd1, YC }; 
																	else if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
																		{XC,YC} <= {XC , YC + 10'd1} ; 
																	else begin
																		done_move_reg <= 1'b1;
																		if (!e_bad_jump) qbert_state <= IDLE;
																		else qbert_state <= KO;								
																	end
																	move_count <= 1'b0;
																	move_anim <= ZERO;
																end
															end 
													ZERO : begin 
																done_move_reg <= 1'b0;
																move_anim <= PLUS; 
															//	if(move_count[16] == 1'b0) move_anim <= PLUS; 
															end
												endcase
										end
								IDLE : begin 
												{x0,y0} <= {XC, YC - YDIAG_DEMI};
												if(e_jump_qb !=0 && position_qb != e_next_qb) begin
													done_move_reg <= 1'b0;
													qbert_state <= JUMP;
												end
											end
								KO : 	begin
//												if(!e_bad_jump)
//													qbert_state <= IDLE;
//												else
//													qbert_state <= START;
												ko_count <= ko_count + 1'b1;
												case(ko_anim)
													1'b0 : if( ko_count[17] == 1'b1 ) begin
																if (shade_x < ( XDIAG_DEMI/11'd2 + 11'd2*XDIAG_DEMI/11'd3))
																	shade_x <= shade_x + 11'd1;
																else begin
																			KO_qb <= KO_qb + 1'b1;
																			ko_count <= 32'b0;
																			shade_x <= 11'd0;
																			if(!e_bad_jump)
																				qbert_state <= IDLE;
																			else
																				qbert_state <= START;
																		end
																ko_anim <= 1'b1;
															 end
													1'b1 : if(ko_count[17] == 1'b0) ko_anim <= 1'b0;
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

assign done_move = done_move_reg;	
assign le_qbert = (is_qbert != 6'b0);
assign qbert_xy = {XC,YC};

endmodule
