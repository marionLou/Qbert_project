/*
	couleur orange R = 216
						G = 95
						B = 2
*/
module qbert_orange_bas_gauche(

//------INPUT--------------------//	
	input logic clk,
	input logic reset,
	input logic [3:0] qbert_jump,
	input logic [10:0] x_cnt, x0, x1,  
	input logic [9:0] y_cnt, y0, y1,
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,

//------OUTPUT-------------------//
	output logic [10:0] qbert_x,  
	output logic [9:0] qbert_y,
	output logic [5:0] le_qbert

	);


logic [10:0] XC; // x-top face center
logic [9:0] YC; // y-top face center

logic pied_gauche;
logic pied_droit;
logic jambe_gauche;
logic jambe_droite;
logic tete;
//logic oeil_gauche;
//logic oeil_droit;
//logic bouche;
logic museau;
logic [5:0] is_qbert_orange;


logic [31:0] move_count = 32'b0;
typedef enum logic {IDLE, RUN} state_t;
state_t move_state;



always_ff @(posedge clk) begin

	
//---- move Qbert in four directions--//
//if(qbert_jump != 4'b0000) begin
// move_count <= move_count + 32'd1;
//
//	case(move_state)
//		IDLE : if( move_count[16] == 1'b1 ) begin 
//					if (YC <= y1 + YDIAG_DEMI) begin
//						{XC,YC} <= {XC , YC + 10'd1}; 
//					end
//					else if (XC < x1) {XC,YC} <= {XC + 11'd1, YC} ; 
//					else {XC,YC} <= {x0 , y0 + YDIAG_DEMI};
//					
//					move_state <= RUN; 
//				end 
//		RUN : if(move_count[16] == 1'b0) move_state <= IDLE;
//		default : begin 
//					move_state <= IDLE;
//					{XC,YC} <= {x0 , y0 + YDIAG_DEMI};
//					end
//	endcase
//end
//else {XC,YC} <= {x0 , y0 + YDIAG_DEMI};
/*
	qbert_jump = 0001 : DOWN_RIGHT
					 0010 : DOWN_LEFT
					 0100 : UP_RIGHT
					 1000 : UP_LEFT
*/
if(qbert_jump != 4'b0000) begin
 move_count <= move_count + 32'd1;

	case(move_state)
		IDLE : if( move_count[15] == 1'b1 ) begin
					if (qbert_jump == 4'b0001) begin
						if (YC > y0) 
							{XC,YC} <= {XC , YC - 10'd1}; 
						else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
							{XC,YC} <= {XC + 11'd1, YC}; 
						move_state <= RUN;
					end
					else if (qbert_jump == 4'b0010) begin
						if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
							{XC,YC} <= {XC , YC + 10'd1}; 
						else if (XC < x0 + XDIAG_DEMI + XLENGTH) 
							{XC,YC} <= {XC + 11'd1, YC} ; 
						move_state <= RUN;
					end
					else if (qbert_jump == 4'b0100) begin
						if (XC > x0 - XDIAG_DEMI - XLENGTH) 
							{XC,YC} <= {XC - 11'd1, YC }; 
						else if (YC > y0) 
							{XC,YC} <= {XC , YC - 10'd1} ; 
						move_state <= RUN;				
					end
					else if (qbert_jump == 4'b1000) begin
						if (XC > x0 - XDIAG_DEMI - XLENGTH) 
							{XC,YC} <= {XC - 11'd1, YC }; 
						else if (YC < y0 + YDIAG_DEMI + YDIAG_DEMI) 
							{XC,YC} <= {XC , YC + 10'd1} ; 
						move_state <= RUN;
					end
				end 
		RUN : if(move_count[15] == 1'b0) move_state <= IDLE;
		default : begin 
					move_state <= IDLE;
					{XC,YC} <= {x0 , y0 + YDIAG_DEMI};
					end
	endcase
end
else {XC,YC} <= {x0 , y0 + YDIAG_DEMI};

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


	
	is_qbert_orange <= {pied_gauche, jambe_gauche, pied_droit, jambe_droite, tete, museau};
	

end
	
assign le_qbert = is_qbert_orange;
assign {qbert_x,qbert_y} = {XC,YC};

endmodule
