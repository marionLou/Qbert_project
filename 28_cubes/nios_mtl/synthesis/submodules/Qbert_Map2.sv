// DATE : 23-03-2016
// modificatio : adaptation pour l'AVALON

module Qbert_Map2(

// --- clk and reset -------------//

	input logic CLK_33,
	input logic reset,
	
// --- Qbert position ------------//

	input logic [3:0] qbert_jump,
	input logic [10:0] QBERT_POSITION_X0,
	input logic [10:0] QBERT_POSITION_X1,
	input logic [9:0] QBERT_POSITION_Y0,
	input logic [9:0] QBERT_POSITION_Y1,

// --- Map parameters ------------//

	input logic [10:0] XLENGTH,
	input logic [10:0] XDIAG_DEMI,
	input logic [10:0] RANK1_X_OFFSET,
	input logic [9:0] YDIAG_DEMI,
	input logic [9:0] RANK1_Y_OFFSET,

// --- MTL parameters ------------//
	
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);
	

	logic [10:0] RANK2_X_OFFSET;
	logic [9:0] RANK2_Y_OFFSET;
	logic [10:0]RANK3_X_OFFSET;
	logic [9:0] RANK3_Y_OFFSET;

 always_ff @(posedge CLK_33) begin
 	RANK2_X_OFFSET <= RANK1_X_OFFSET - XLENGTH - XDIAG_DEMI - 11'd1;
	RANK2_Y_OFFSET <= RANK1_Y_OFFSET + YDIAG_DEMI;
	RANK3_X_OFFSET <= RANK1_X_OFFSET - XLENGTH - XLENGTH - XDIAG_DEMI - XDIAG_DEMI - 11'd1;
	RANK3_Y_OFFSET <= RANK1_Y_OFFSET + YDIAG_DEMI + YDIAG_DEMI;
 end

// --- Rank 1 --------------------------------------------------//	
	logic R1_left_face_n1, R1_left_face_n2, R1_left_face_n3;
	logic R1_right_face_n1, R1_right_face_n2, R1_right_face_n3;
	logic R1_top_face_n1, R1_top_face_n2, R1_top_face_n3;
//	logic [3:0] R1_top_face_n1, R1_top_face_n2, R1_top_face_n3;
	logic R1_qbert_top_face_n1, R1_qbert_top_face_n2, R1_qbert_top_face_n3;
	
	logic [10:0] R1_x_offset_n1, R1_x_offset_n2, R1_x_offset_n3;
	logic [9:0] R1_y_offset_n1, R1_y_offset_n2, R1_y_offset_n3;

	
	always_ff @(posedge CLK_33) begin
	
	{R1_x_offset_n1, R1_y_offset_n1} <= {RANK1_X_OFFSET, RANK1_Y_OFFSET};
	{R1_x_offset_n2, R1_y_offset_n2} <= {RANK1_X_OFFSET, RANK1_Y_OFFSET + YDIAG_DEMI + YDIAG_DEMI + 10'd1};
	{R1_x_offset_n3, R1_y_offset_n3} <= {RANK1_X_OFFSET, RANK1_Y_OFFSET + YDIAG_DEMI + YDIAG_DEMI + YDIAG_DEMI + YDIAG_DEMI + 10'd1};
	
	end
	
	logic [2:0] R1_left_face;
	logic [2:0] R1_right_face;
//	logic [11:0] R1_top_face;
	
// --- Rank 2 --------------------------------------------------//

	logic R2_left_face_n1, R2_left_face_n2;
	logic R2_right_face_n1, R2_right_face_n2;
//	logic [3:0] R2_top_face_n1, R2_top_face_n2;
	logic R2_top_face_n1, R2_top_face_n2;
	logic R2_qbert_top_face_n1, R2_qbert_top_face_n2;
	
	logic [10:0] R2_x_offset_n1, R2_x_offset_n2;
	logic [9:0] R2_y_offset_n1, R2_y_offset_n2;

always_ff @(posedge CLK_33) begin
	 
			 {R2_x_offset_n1, R2_y_offset_n1} <= {RANK2_X_OFFSET, RANK2_Y_OFFSET};
			 {R2_x_offset_n2, R2_y_offset_n2} <= {RANK2_X_OFFSET, RANK2_Y_OFFSET + 10'd2*(YDIAG_DEMI)+10'd1};
end
	
	logic [1:0] R2_left_face;
	logic [1:0] R2_right_face;
//	logic [7:0] R2_top_face;
	
// --- Rank 3 --------------------------------------------------//

	logic R3_left_face_n1;
	logic R3_right_face_n1;
	logic R3_top_face_n1;
//	logic [3:0] R3_top_face_n1;
	logic R3_qbert_top_face_n1;
	
	logic [10:0] R3_x_offset_n1;
	logic [9:0] R3_y_offset_n1;

	always_ff @(posedge CLK_33) begin
	
	{R3_x_offset_n1, R3_y_offset_n1} <= {RANK3_X_OFFSET, RANK3_Y_OFFSET};
	
	end
	
	logic  R3_left_face;
	logic  R3_right_face;
//	logic [3:0] R3_top_face;
	
// -- Qbert and co ---------------------------------------------//

	logic [5:0] le_qbert;
	logic [10:0] qbert_x;
	logic [9:0] qbert_y;

// -- Plot 6 cubes----------------------------------------------//
 	
	// always_ff  @(posedge clk) begin
	
	// R1_left_face <= {R1_left_face_n1, R1_left_face_n2, R1_left_face_n3};
	// R1_right_face <= {R1_right_face_n1, R1_right_face_n2, R1_right_face_n3};
	// R1_top_face <= {R1_top_face_n1, R1_top_face_n2, R1_top_face_n3};
	
	// R2_left_face <= {R2_left_face_n1, R2_left_face_n2};
	// R2_right_face <= {R2_right_face_n1, R2_right_face_n2};
	// R2_top_face <= {R2_top_face_n1, R2_top_face_n2};
	
	// R3_left_face <= R3_left_face_n1;
	// R3_right_face <= R3_right_face_n1;
	// R3_top_face <= R3_top_face_n1;
	
	// end
	
	logic [5:0] qbert_route;
	logic is_left_face;
	logic is_right_face;
//	logic is_top_face;
	logic [5:0] is_top_face;
	
	always_ff @(posedge CLK_33) begin

	
	R1_left_face <= {R1_left_face_n1, R1_left_face_n2, R1_left_face_n3};
	R1_right_face <= {R1_right_face_n1, R1_right_face_n2, R1_right_face_n3};
//	R1_top_face <= {R1_top_face_n1, R1_top_face_n2, R1_top_face_n3};

	
	R2_left_face <= {R2_left_face_n1, R2_left_face_n2};
	R2_right_face <= {R2_right_face_n1, R2_right_face_n2};
//	R2_top_face <= {R2_top_face_n1, R2_top_face_n2};
	
	R3_left_face <= R3_left_face_n1;
	R3_right_face <= R3_right_face_n1;
//	R3_top_face <= R3_top_face_n1;
	
	qbert_route <= {R1_qbert_top_face_n1, R1_qbert_top_face_n2, R1_qbert_top_face_n3,
					R2_qbert_top_face_n1, R2_qbert_top_face_n2,
					R3_qbert_top_face_n1};
					
	is_top_face <= {R1_top_face_n1 , R1_top_face_n2 , R1_top_face_n3,
						R2_top_face_n1 , R2_top_face_n2,
						R3_top_face_n1};
	

	is_left_face <= (R1_left_face != 0) || (R2_left_face != 0) || (R3_left_face != 0);
	is_right_face <= (R1_right_face != 0) || (R2_right_face != 0) || (R3_right_face != 0);
//	is_top_face <= (R1_top_face != 0) || (R2_top_face != 0) || (R3_top_face != 0);
	
		if (le_qbert !=0) begin
			red <= 8'd216;
			green <= 8'd95;
			blue <= 8'd2;
		end
		else if(is_left_face !=0) begin
			red 	<= 8'd86;
			green <= 8'd169;
			blue 	<= 8'd152;
		end
		else if(is_right_face != 0) begin
			red <= 8'd49;
			green <= 8'd70;
			blue <= 8'd70;
		end
		else if(is_top_face != 0) begin
			if (qbert_route == is_top_face) begin
				red <= 8'd86;
				green <= 8'd70;
				blue <= 8'd239;
				end
			else 
				begin
				red <= 8'd222;
				green <= 8'd222;
				blue <= 8'd0;
				end
		end
		else begin
		red 	<= 8'd0;
		green <= 8'd0;
		blue 	<= 8'd0;
		end
	end
	
qbert_orange_bas_gauche Beta(
.clk(CLK_33),
.reset(reset),
.x_cnt(x_cnt),
.y_cnt(y_cnt),
.x0(QBERT_POSITION_X0),
.y0(QBERT_POSITION_Y0),
.x1(QBERT_POSITION_X1),
.y1(QBERT_POSITION_Y1),
.*
);

cube_generator  rank1_n1(  
	.clk(CLK_33),
	.x_offset(R1_x_offset_n1),
	.y_offset(R1_y_offset_n1),
	.left_face(R1_left_face_n1),
	.right_face(R1_right_face_n1),
	.top_face(R1_top_face_n1),
	.qbert_top_face(R1_qbert_top_face_n1),
	.*
	);
	

cube_generator  rank1_n2(
	.clk(CLK_33),
	.x_offset(R1_x_offset_n2),
	.y_offset(R1_y_offset_n2),
	.left_face(R1_left_face_n2),
	.right_face(R1_right_face_n2),
	.top_face(R1_top_face_n2),
	.qbert_top_face(R1_qbert_top_face_n2),
	.*
	);


cube_generator  rank1_n3( 
	.clk(CLK_33),
	.x_offset(R1_x_offset_n3),
	.y_offset(R1_y_offset_n3),
	.left_face(R1_left_face_n3),
	.right_face(R1_right_face_n3),
	.top_face(R1_top_face_n3),
	.qbert_top_face(R1_qbert_top_face_n3),
	.*
	);
	
	
cube_generator  rank2_n1( 
	.clk(CLK_33),
	.x_offset(R2_x_offset_n1),
	.y_offset(R2_y_offset_n1),
	.left_face(R2_left_face_n1),
	.right_face(R2_right_face_n1),
	.top_face(R2_top_face_n1),
	.qbert_top_face(R2_qbert_top_face_n1),
	.*
	);


cube_generator  rank2_n2( 
	.clk(CLK_33),
	.x_offset(R2_x_offset_n2),
	.y_offset(R2_y_offset_n2),
	.left_face(R2_left_face_n2),
	.right_face(R2_right_face_n2),
	.top_face(R2_top_face_n2),
	.qbert_top_face(R2_qbert_top_face_n2),
	.*
	);
	 
cube_generator  rank3_n1(  
	.clk(CLK_33),
	.x_offset(R3_x_offset_n1),
	.y_offset(R3_y_offset_n1),
	.left_face(R3_left_face_n1),
	.right_face(R3_right_face_n1),
	.top_face(R3_top_face_n1),
	.qbert_top_face(R3_qbert_top_face_n1),
	.*
	);

	
endmodule

