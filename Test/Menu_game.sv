// Code validé

module Menu_game(

	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,	
	
	output logic [23:0] menu_RGB
);

logic [10:0] XLENGTH = 11'd100;
logic [20:0] XYDIAG_DEMI = {11'd80,10'd100};
logic [20:0] xy_offset = {11'd350,10'd110};
logic [20:0] XYC = {11'd350,10'd210};

parameter logic [23:0] qbert_RGB = {8'd216,8'd95,8'd2};
parameter logic [23:0] serpent_RGB = {8'd228,8'd0,8'd186};			
parameter logic [23:0] num0_RGB = {8'd222,8'd222,8'd0};
parameter logic [23:0] num1_RGB = {8'd86,8'd70,8'd239};
parameter logic [23:0] num2_RGB = {8'd0,8'd255,8'd64};
parameter logic [23:0] num3_RGB = {8'd132,8'd35,8'd156};
parameter logic [23:0] num4_RGB = {8'd170,8'd13,8'd40};
parameter logic [23:0] left_face_RGB = {8'd86,8'd169,8'd152};
parameter logic [23:0] right_face_RGB = {8'd49,8'd70,8'd70};
parameter logic [23:0] background_0_RGB = {8'd146,8'd165,8'd216}; 


always_ff @(posedge clk) begin
	if(le_qbert) 
//		menu_RGB <= qbert_RGB;
		menu_RGB <= serpent_RGB;
	else if (right_face)
		menu_RGB <= right_face_RGB;
	else if (left_face)
		menu_RGB <= left_face_RGB;
	else if(top_face) begin
		if (color_numero == 3'd0)
			menu_RGB <= num0_RGB;
		else if (color_numero == 3'd1)
			menu_RGB <= num1_RGB;
		else if (color_numero == 3'd2)
			menu_RGB <= num2_RGB;
		else if (color_numero == 3'd3)
			menu_RGB <= num3_RGB;
		else if (color_numero == 3'd4)
			menu_RGB <= num4_RGB;
	end
	else
		menu_RGB <= background_0_RGB;
end

logic [2:0] color_numero;
logic top_face;
logic left_face;
logic right_face; 

cube_menu Intro (
	.clk,
	.reset,
	.XLENGTH,
	.XYDIAG_DEMI,
	.x_cnt,.y_cnt,
	.xy_offset,
	.jump,
	.done_move,
	
	.color_numero,
	.left_face,
	.right_face,
	.top_face
); 

logic jump;
logic done_move;
logic le_qbert;

qbert_menu qbert_M(	
	.clk,
	.reset,
	.x_cnt,
	.y_cnt, 
	.xy_offset(XYC),
	.XLENGTH,
	.XDIAG_DEMI(XYDIAG_DEMI[20:10]),
	.YDIAG_DEMI(XYDIAG_DEMI[9:0]),
	
	.jump,
	.done_move,
	.le_qbert
);

endmodule

//-------------------------------------------
module cube_menu(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt, XLENGTH,
	input logic [9:0] y_cnt, 
	input logic [20:0] xy_offset,
	input logic [20:0] XYDIAG_DEMI,
	input logic jump,
	input logic done_move,
	
	output logic [2:0] color_numero,
	output logic left_face,
	output logic right_face,
	output logic top_face
	);
	/*
 A beautiful cube with 
the position of each point 
				y	<------O
		 5				    |
	  %%%%%				 |
	4%%%°%%%0			 v
	 -%%%%%-			   
	|-- 6 --|			 X
	|---|---|
	1\--|--3
	  \-2-/
	
	*/  
	
	// lenght for the cube's left face



 
	logic [20:0] XY0;
	logic [20:0] XY1;
	logic [20:0] XY2;
	logic [20:0] XY3;
	logic [20:0] XY4;
	logic [20:0] XY5;
	logic [20:0] XY6;

assign XY0 = {xy_offset[20:10] , 
			xy_offset[9:0]};
assign XY1 = {xy_offset[20:10] + XLENGTH ,
			xy_offset[9:0]};
assign XY2 = {xy_offset[20:10] + XLENGTH + XYDIAG_DEMI[20:10] , 
			xy_offset[9:0] + XYDIAG_DEMI[9:0]};
assign XY3 = {xy_offset[20:10] + XLENGTH , 
			xy_offset[9:0] + 10'd2*XYDIAG_DEMI[9:0]};
assign XY4 = {xy_offset[20:10] , 
			xy_offset[9:0] +10'd2*XYDIAG_DEMI[9:0]};
assign XY5 = { xy_offset[20:10] - XYDIAG_DEMI[20:10] ,
			xy_offset[9:0] + XYDIAG_DEMI[9:0]};
assign XY6 = { xy_offset[20:10] + XYDIAG_DEMI[20:10] , 
			xy_offset[9:0] + XYDIAG_DEMI[9:0]};

	logic [10:0] X_line_12;
	logic [10:0] X_line_23;
	logic [10:0] X_line_45;
	logic [10:0] X_line_50;
	logic [10:0] X_line_06;
	logic [10:0] X_line_64;


	
	reg left_reg;
	reg right_reg;
	reg [3:0] top_reg;
	logic [2:0] color_reg = 1'b0;
	
	typedef enum logic {IDLE, UPDATE} state_t;
	state_t color_bit;
	
	
always_ff @(posedge clk)
begin
		
  left_reg <= {(x_cnt >= X_line_64 && x_cnt <= X_line_23) 
					&&(y_cnt >= XY6[9:0] && y_cnt <= XY4[9:0])};
	
  right_reg <= {(x_cnt >= X_line_06 && x_cnt <= X_line_12) 
					&&(y_cnt >= XY0[9:0] && y_cnt < XY6[9:0])}; 
									
  top_reg[0] <= {(x_cnt >= XY0[20:10] && x_cnt <= X_line_06)  
					&& (y_cnt >= XY0[9:0] && y_cnt <= XY6[9:0])};
		
  top_reg[1] <= {(x_cnt >= X_line_50 && x_cnt <= XY0[20:10])  
					&& (y_cnt >= XY0[9:0] && y_cnt <= XY6[9:0])};
					
  top_reg[2] <= {(x_cnt >= XY0[20:10] && x_cnt <= X_line_64)  
					&&(y_cnt >= XY6[9:0] && y_cnt <= XY4[9:0])};
	
  top_reg[3] <= {(x_cnt >= X_line_45 && x_cnt <= XY0[20:10])  
					&&(y_cnt >= XY6[9:0] && y_cnt <= XY4[9:0])};
					
case(color_bit)
	IDLE : 	if(jump) color_bit <= UPDATE;	
	
	UPDATE: if (done_move) begin
				color_bit <= IDLE;
				if(color_numero == 3'd4)
					color_reg <= 1'b0;
				else color_reg <= color_reg + 1'b1;
			end
endcase
					
		
end


assign top_face = top_reg[3]|top_reg[2]|top_reg[1]|top_reg[0];
assign left_face = left_reg;
assign right_face = right_reg;
assign color_numero = color_reg;

Draw_Line line12(
	.x0(XY1[20:10]), .x1(XY2[20:10]),
	.y0(XY1[9:0]), .y1(XY2[9:0]),
	.x_line(X_line_12),
	.y_line(),	
	.*
);

Draw_Line line23(
	.x0(XY2[20:10]), .x1(XY3[20:10]),
	.y0(XY2[9:0]), .y1(XY3[9:0]),
	.x_line(X_line_23),
	.y_line(),	
	.*
);


Draw_Line line45(
	.x0(XY5[20:10]), .x1(XY4[20:10]),
	.y0(XY5[9:0]), .y1(XY4[9:0]),
	.x_line(X_line_45),
	.y_line(),	
	.*
);

Draw_Line line50(
	.x0(XY0[20:10]), .x1(XY5[20:10]),
	.y0(XY0[9:0]), .y1(XY5[9:0]),
	.x_line(X_line_50), 
	.y_line(),
	.*
);

Draw_Line line06(
	.x0(XY0[20:10]), .x1(XY6[20:10]),
	.y0(XY0[9:0]), .y1(XY6[9:0]),
	.x_line(X_line_06),
	.y_line(),	
	.*
);

Draw_Line line64(
	.x0(XY6[20:10]), .x1(XY4[20:10]),
	.y0(XY6[9:0]), .y1(XY4[9:0]),
	.x_line(X_line_64),
	.y_line(),	
	.*
);

endmodule
//----------------------------------------
module qbert_menu (	
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt, 
	input logic [20:0] xy_offset,
	input logic [10:0] XLENGTH,
	input logic [10:0] XDIAG_DEMI,
	input logic [9:0] YDIAG_DEMI,
	
	output logic jump,
	output logic done_move,
	output logic le_qbert
);

// -----JUMP automatique ---------------------------//
typedef enum logic [1:0] {INIT, IDLE, JUMP} qstate_t;
qstate_t qbert_state;

logic [31:0] count = 32'b0;
logic jump_reg;
logic done_move_reg;
logic [10:0] XC;
logic [9:0] YC;
logic [20:0] xy0;
logic [1:0] up_jump;

always_ff @(posedge clk) begin
	case(qbert_state)
		INIT:	begin 
					{XC,YC} <= xy_offset;
					qbert_state <= IDLE;
					done_move_reg <= 1'b1;
					jump_reg <= 1'b0;
					up_jump <= 1'b1;
					xy0 <= xy_offset - {XLENGTH+XDIAG_DEMI,10'd0};
				end
		IDLE:	begin
					if(count == 32'd8000000) begin
						count <= 1'b0;
						done_move_reg <= 1'b0;
						jump_reg <= 1'b1;
						qbert_state <= JUMP;
					end
					else count <= count + 1'b1;
				end
		JUMP : 	begin
					if (((up_jump == 2'd2)? count[16] : count[17])== 1'b1) begin
						count <= 1'b0;
						if (up_jump == 2'd1) begin
							if(XC > xy0[20:10])
								{XC,YC} <= {XC - 11'd1,YC};
							else up_jump <= 2'd2;
						end
						else if(up_jump == 2'd2) begin
							if(XC < xy_offset[20:10])
								{XC,YC} <= {XC + 11'd1,YC};
							else begin
								jump_reg <= 1'b0;
								done_move_reg <= 1'b1;
								up_jump <= 2'd1;
								qbert_state <= IDLE;
							end
						end
					end
					else count <= count + 1'b1;
				end
	endcase
end
//---------Affichage du Qbert------------------------//

logic pied_gauche;
logic pied_droit;
logic jambe_gauche;
logic jambe_droite;
logic tete;
logic museau;
logic [5:0] is_qbert;

//--------
logic tete2;
logic tronc;
logic queue_1;
logic queue_2;
logic [3:0] is_serpent;

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
/*			
	tete2 <= {(x_cnt <= XC - 11'd3*(XLENGTH>>2) && x_cnt >= XC - XLENGTH )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>1) )};
			
	tronc <= {(x_cnt >= XC - 11'd3*(XLENGTH>>2) && x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) )
				&&(y_cnt >= YC - (YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
	queue_1 <= {(x_cnt <= XC + 11'd3*(XDIAG_DEMI>>2) && x_cnt >= XC + (XDIAG_DEMI>>1) )
				&&(y_cnt >= YC - 11'd3*(YDIAG_DEMI>>2) && y_cnt <= YC + (YDIAG_DEMI>>2) )};
			
	queue_2 <= {(x_cnt <= XC + (XDIAG_DEMI>>1) && x_cnt >= XC)
				&&(y_cnt <= YC - 11'd3*(YDIAG_DEMI>>2) && y_cnt >= YC - (YDIAG_DEMI>>1) )};
*/			
	is_qbert <= {pied_gauche, jambe_gauche, pied_droit, jambe_droite, tete, museau};
//	is_serpent <= {tete2, tronc, queue_1, queue_2};
end

assign jump = jump_reg;
assign done_move = done_move_reg;
assign le_qbert = (is_qbert != 6'b0);
//assign le_qbert = (is_serpent != 4'b0);
endmodule