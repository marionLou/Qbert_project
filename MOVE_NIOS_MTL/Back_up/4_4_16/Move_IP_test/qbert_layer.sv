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
	input logic e_bad_jump,
	input logic [N_cube-1:0] position_qb,
	input logic [N_cube-1:0] e_next_qb,
	input logic [2:0] e_jump_qb,
	input logic [10:0] x_cnt, x_offset,  
	input logic [9:0] y_cnt, y_offset,
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,

//------OUTPUT-------------------//
	output logic [20:0] qbert_xy,
	output logic qbert_hitbox,
	output logic done_move,
	output logic le_qbert

	);
	
parameter N_cube;

logic [10:0] XC, x0; 
logic [9:0] YC, y0; 
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
typedef enum logic {IDLE, RUN} state_t;
state_t move_state;

typedef enum logic [1:0] {START, JUMP, PAUSE} jump_t;
jump_t qbert_state;


always_ff @(posedge clk) begin

	
/*
	e_jump_qb = 001 : DOWN_RIGHT
					 010 : DOWN_LEFT
					 011 : UP_RIGHT
					 100 : UP_LEFT
*/

	case(qbert_state)
		START : begin 
						{x0,y0} <= {x_offset, y_offset};
						{XC,YC} <= {x_offset, y_offset + YDIAG_DEMI};
						done_move_reg <= 1'b1;
						if (e_jump_qb != 0) qbert_state <= JUMP;
					end
		JUMP : begin 
						move_count <= move_count + 32'd1;
						case(move_state)
							IDLE : if( move_count[16] == 1'b1 ) begin
										if (e_jump_qb == 3'b001) begin
											if (YC > y0) 
												{XC,YC} <= {XC , YC - 10'd1}; 
											else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
												{XC,YC} <= {XC + 11'd1, YC};
											else begin
												done_move_reg <= 1'b1;
												if (!e_bad_jump) qbert_state <= PAUSE;
												else  qbert_state <= START;								
											end
											move_state <= RUN;
										end
										else if (e_jump_qb == 3'b010) begin
											if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
												{XC,YC} <= {XC , YC + 10'd1}; 
											else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
												{XC,YC} <= {XC + 11'd1, YC}; 
											else begin
												done_move_reg <= 1'b1;
												if (!e_bad_jump) qbert_state <= PAUSE;
												else qbert_state <= START;								
											end
											move_state <= RUN;
										end
										else if (e_jump_qb == 3'b011) begin
											if (XC > x0 - XDIAG_DEMI - XLENGTH) 
												{XC,YC} <= {XC - 11'd1, YC }; 
											else if (YC > y0) 
												{XC,YC} <= {XC , YC - 10'd1} ; 
											else begin
												done_move_reg <= 1'b1;
												if (!e_bad_jump) qbert_state <= PAUSE;
												else qbert_state <= START;								
											end
											move_state <= RUN;				
										end
										else if (e_jump_qb == 3'b100) begin
											if (XC > x0 - XDIAG_DEMI - XLENGTH) 
												{XC,YC} <= {XC - 11'd1, YC }; 
											else if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
												{XC,YC} <= {XC , YC + 10'd1} ; 
											else begin
												done_move_reg <= 1'b1;
												if (!e_bad_jump) qbert_state <= PAUSE;
												else qbert_state <= START;								
											end
											move_state <= RUN;
										end
									end 
							RUN : begin 
										done_move_reg <= 1'b0;
										if(move_count[16] == 1'b0) move_state <= IDLE; 
									end
						endcase
				end
		PAUSE : 	begin 
						{x0,y0} <= {XC, YC - YDIAG_DEMI};
						if(e_jump_qb !=0 && position_qb != e_next_qb)
							qbert_state <= JUMP;
					end	
	endcase
end	
//*************************************************************
/*	
	if(e_start_qb) begin
	 {x0,y0} <= {x_offset, y_offset};
	 {XC,YC} <= {x_offset, y_offset + YDIAG_DEMI};
	 done_move_reg <= 1'b1;
	end
	else if(e_jump_qb != 3'b00) done_move_reg <= 1'b0;
	if (done_move_reg == 0) begin
	move_count <= move_count + 32'd1;

		case(move_state)
			IDLE : if( move_count[16] == 1'b1 ) begin
						if (e_jump_qb == 3'b001) begin
							if (YC > y0) 
								{XC,YC} <= {XC , YC - 10'd1}; 
							else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
								{XC,YC} <= {XC + 11'd1, YC};
							else begin
								done_move_reg <= 1'b1;
								if (!e_bad_jump) begin
								{x0,y0} <= {XC, YC - YDIAG_DEMI};
								end
								else begin
								{x0,y0} <= {x_offset, y_offset};
								end								
							end
							move_state <= RUN;
							done_move_reg <= 1'b0;
						end
						else if (e_jump_qb == 3'b010) begin
							if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
								{XC,YC} <= {XC , YC + 10'd1}; 
							else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
								{XC,YC} <= {XC + 11'd1, YC}; 
							else begin
								if (!e_bad_jump) begin
								{x0,y0} <= {XC, YC - YDIAG_DEMI};
								done_move_reg <= 1'b1;
								end
								else begin
								{x0,y0} <= {x_offset, y_offset};
								done_move_reg <= 1'b1;
								end								
							end
							move_state <= RUN;
							done_move_reg <= 1'b0;
						end
						else if (e_jump_qb == 3'b011) begin
							if (XC > x0 - XDIAG_DEMI - XLENGTH) 
								{XC,YC} <= {XC - 11'd1, YC }; 
							else if (YC > y0) 
								{XC,YC} <= {XC , YC - 10'd1} ; 
							else begin
								if (!e_bad_jump) begin
								{x0,y0} <= {XC, YC - YDIAG_DEMI};
								done_move_reg <= 1'b1;
								end
								else begin
								{x0,y0} <= {x_offset, y_offset};
								done_move_reg <= 1'b1;
								end								
							end
							move_state <= RUN;
							done_move_reg <= 1'b0;				
						end
						else if (e_jump_qb == 3'b100) begin
							if (XC > x0 - XDIAG_DEMI - XLENGTH) 
								{XC,YC} <= {XC - 11'd1, YC }; 
							else if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
								{XC,YC} <= {XC , YC + 10'd1} ; 
							else begin
								if (!e_bad_jump) begin
								{x0,y0} <= {XC, YC - YDIAG_DEMI};
								done_move_reg <= 1'b1;
								end
								else begin
								{x0,y0} <= {x_offset, y_offset};
								done_move_reg <= 1'b1;
								end								
							end
							move_state <= RUN;
							done_move_reg <= 1'b0;
						end
					end 
			RUN : if(move_count[16] == 1'b0) move_state <= IDLE;
		endcase
	end
*/

//---------LeQbert------------------------//
	
always_ff @(posedge clk) begin	
	
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
			&& (x_cnt >= XC - XDIAG_DEMI/11'd2 && x_cnt <= XC + 11'd2*XDIAG_DEMI/11'd3)};


	
	is_qbert <= {pied_gauche, jambe_gauche, pied_droit, jambe_droite, tete, museau};
	

end

assign done_move = done_move_reg;	
assign le_qbert = (is_qbert != 6'b0);
assign qbert_xy = {XC,YC};

endmodule
