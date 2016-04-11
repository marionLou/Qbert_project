// version 01/04/16

module cube_generator(
	input logic clk,
	input logic reset,
	input logic done_move,
	input logic [2:0] e_jump_qb,
	input logic [10:0] x_cnt, XLENGTH,
	input logic [9:0] y_cnt, 
	input logic [20:0] xy_offset,
	input logic [20:0] XYDIAG_DEMI,
	input logic [N_cube-1:0] hb_top,
	input logic [N_cube-1:0] e_color_state,
	input logic [N_cube-1:0] position_qb,
	input logic [N_cube-1:0] e_next_qb,
	
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
 
	reg [20:0] XY0;
	reg [20:0] XY1;
	reg [20:0] XY2;
	reg [20:0] XY3;
	reg [20:0] XY4;
	reg [20:0] XY5;
	reg [20:0] XY6;

	

	logic [10:0] X_line_12;
	logic [10:0] X_line_23;
	logic [10:0] X_line_45;
	logic [10:0] X_line_50;
	logic [10:0] X_line_06;
	logic [10:0] X_line_64;


	
	reg left_reg;
	reg right_reg;
	reg [3:0] top_reg;
	reg top_color_reg;
	reg [N_cube-1:0] color_state_reg;
	
	typedef enum logic {IDLE, UPDATE} state_t;
	state_t color_bit;
	
	
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
					
case(color_bit)
	IDLE : 	begin
					top_color_reg <= ((color_state_reg & hb_top ) != 1'b0);
					if (position_qb != e_next_qb) color_bit <= UPDATE;
				end	
	UPDATE : if (done_move) begin
					color_state_reg <= e_color_state;
					top_color_reg <= ((color_state_reg & hb_top ) != 1'b0);
					color_bit <= IDLE;
				end
				else top_color_reg <= ((color_state_reg & hb_top ) != 1'b0);
endcase
					
		
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
