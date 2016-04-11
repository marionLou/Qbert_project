// version 01/04/16

module cube_generator(
	input logic clk,
	input logic reset,
	input logic done_move,
	input logic [10:0] x_cnt, XLENGTH,
	input logic [9:0] y_cnt, 
	input logic [20:0] xy_offset,
	input logic [20:0] XYDIAG_DEMI,
	input logic [N_cube:0] top_face_cnt,
	input logic [N_cube:0] nios_top_color,
	
	output logic top_color,
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



	parameter N_cube;
 
	logic [20:0] XY0;
	logic [20:0] XY1;
	logic [20:0] XY2;
	logic [20:0] XY3;
	logic [20:0] XY4;
	logic [20:0] XY5;
	logic [20:0] XY6;

	

	logic [10:0] X_line_12;
	logic [10:0] X_line_23;
	logic [10:0] X_line_45;
	logic [10:0] X_line_50;
	logic [10:0] X_line_06;
	logic [10:0] X_line_64;


	
	logic left_reg;
	logic right_reg;
	logic [3:0] top_reg;
	logic top_color_reg;
	
	
	
	
always_ff @(posedge clk)
begin
	
	XY0 <= {xy_offset[20:10] , 
			xy_offset[9:0]};
			
	XY1 <= {xy_offset[20:10] + XLENGTH ,
			xy_offset[9:0]};
			
	XY2 <= {xy_offset[20:10] + XLENGTH + XYDIAG_DEMI[20:10] , 
			xy_offset[9:0] + XYDIAG_DEMI[9:0]};
			
	XY3 <= {xy_offset[20:10] + XLENGTH , 
			xy_offset[9:0] + 10'd2*XYDIAG_DEMI[9:0]};
			
	XY4 <= {xy_offset[20:10] , 
			xy_offset[9:0] +10'd2*XYDIAG_DEMI[9:0]};
			
	XY5 <= { xy_offset[20:10] - XYDIAG_DEMI[20:10] ,
			xy_offset[9:0] + XYDIAG_DEMI[9:0]};
			
	XY6 <= { xy_offset[20:10] + XYDIAG_DEMI[20:10] , 
			xy_offset[9:0] + XYDIAG_DEMI[9:0]};
	
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
					

if ( ((nios_top_color & top_face_cnt ) != 6'b0) && done_move)
 top_color_reg <= 1'b1; 
else top_color_reg <= 1'b0;
					
		
end


assign top_face = top_reg[3]|top_reg[2]|top_reg[1]|top_reg[0];
assign left_face = left_reg;
assign right_face = right_reg;
assign top_color = top_color_reg;


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