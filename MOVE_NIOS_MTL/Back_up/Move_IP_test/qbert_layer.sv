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
	input logic nios_start_qbert,
	input logic bad_jump,
	input logic [2:0] qbert_jump,
	input logic [10:0] x_cnt, x_offset, x1,  
	input logic [9:0] y_cnt, y_offset, y1,
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,

//------OUTPUT-------------------//
	output logic [20:0] qbert_xy,
	output logic qbert_hitbox,
	output logic done_move,
	output logic le_qbert

	);


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



always_ff @(posedge clk) begin

	
/*
	qbert_jump = 001 : DOWN_RIGHT
					 010 : DOWN_LEFT
					 011 : UP_RIGHT
					 100 : UP_LEFT
*/
	if(nios_start_qbert) begin
	 {x0,y0} <= {x_offset, y_offset};
	 {XC,YC} <= {x_offset, y_offset + YDIAG_DEMI};
	 done_move_reg <= 1'b1;
	end
	else if(qbert_jump != 3'b00) begin
	move_count <= move_count + 32'd1;

		case(move_state)
			IDLE : if( move_count[16] == 1'b1 ) begin
						if (qbert_jump == 3'b001) begin
							if (YC > y0) 
								{XC,YC} <= {XC , YC - 10'd1}; 
							else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
								{XC,YC} <= {XC + 11'd1, YC};
							else begin
								if (!bad_jump) begin
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
						else if (qbert_jump == 3'b010) begin
							if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
								{XC,YC} <= {XC , YC + 10'd1}; 
							else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
								{XC,YC} <= {XC + 11'd1, YC}; 
							else begin
								if (!bad_jump) begin
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
						else if (qbert_jump == 3'b011) begin
							if (XC > x0 - XDIAG_DEMI - XLENGTH) 
								{XC,YC} <= {XC - 11'd1, YC }; 
							else if (YC > y0) 
								{XC,YC} <= {XC , YC - 10'd1} ; 
							else begin
								if (!bad_jump) begin
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
						else if (qbert_jump == 3'b100) begin
							if (XC > x0 - XDIAG_DEMI - XLENGTH) 
								{XC,YC} <= {XC - 11'd1, YC }; 
							else if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
								{XC,YC} <= {XC , YC + 10'd1} ; 
							else begin
								if (!bad_jump) begin
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
/*			default : begin 
						move_state <= IDLE;
						{XC,YC} <= {x0 , y0 + YDIAG_DEMI};
						end*/
		endcase
	end


//---------LeQbert------------------------//
	
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
