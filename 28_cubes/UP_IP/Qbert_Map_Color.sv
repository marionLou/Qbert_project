// DATE : 31-03-2016
// modificatio : adaptation pour l'AVALON

module Qbert_Map_Color(

// --- clk and reset -------------//

	input logic CLK_33,
	input logic reset,
	
// --- Qbert position ------------//

	input bad_jump,
	input nios_start_qbert,
	input logic [2:0] qbert_jump, 
	input logic [20:0] QBERT_POSITION_XY0,
	input logic [20:0] QBERT_POSITION_XY1,
	output logic done_move,

// --- Map parameters ------------//

	input logic [10:0] XLENGTH,
	input logic [20:0] XYDIAG_DEMI,
	input logic [20:0] RANK1_XY_OFFSET,
	input logic [N_cube:0] nios_top_color,
//	output logic [5:0] hitbox_top,

// --- MTL parameters ------------//
	
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);

	parameter N_cube = 27; // 27 + 1 
	parameter N_rank = 6; // 6 + 1
	
	// Génération des offsets pour chaque rangée
	logic [20:0] RANK2_XY_OFFSET, RANK3_XY_OFFSET,
				RANK4_XY_OFFSET, RANK5_XY_OFFSET,
				RANK6_XY_OFFSET, RANK7_XY_OFFSET;
				
	logic [9:0] shift [1:7] = '{10'd0, 10'd1, 10'd2,
								10'd3, 10'd4, 10'd5,
								10'd6};
								
								
    rank_offset_generator ROG [2:7](
						.XLENGTH,
						.RANK1_XY_OFFSET,
						.XYDIAG_DEMI,
						.shift(shift[2:7]),
						.rank_xy_offset('{RANK2_XY_OFFSET,
										RANK3_XY_OFFSET,
										RANK4_XY_OFFSET,
										RANK5_XY_OFFSET,
										RANK6_XY_OFFSET,
										RANK7_XY_OFFSET })
						);
	
	// curseur pour tracer les cubes
	logic [20:0] xy_offset [1:7];
	
	// hitbox top cube
	logic [N_cube:0] top_face_cnt;
	
	// hitbox qbert
	logic qbert_hitbox;


// --- Rank 1 --------------------------------------------------//

	logic R1_left_face;
	logic R1_right_face;
	logic R1_top_face;
	logic R1_top_color;

always_ff @(posedge CLK_33) begin
	
	xy_offset [1][20:0] <= RANK1_XY_OFFSET;
	
	top_face_cnt[0] <= {(x_cnt <= RANK1_XY_OFFSET[20:10] + XYDIAG_DEMI[20:10] && x_cnt >= RANK1_XY_OFFSET[20:10] - XYDIAG_DEMI[20:10]) 
				&& (y_cnt <= RANK1_XY_OFFSET[9:0] + 10'd2*XYDIAG_DEMI[9:0] && y_cnt >= RANK1_XY_OFFSET[9:0] )};
end
 
// --- Rank 2 --------------------------------------------------//
	
	logic R2_left_face;
	logic R2_right_face;
	logic R2_top_face;
	logic R2_top_color;
	
	logic [20:0] R2_xy_point_n [1:2];
	
	rank_n_generator RNG_rank2 [1:2] (
		.rank_offset(RANK2_XY_OFFSET),
		.shift(shift[1:2]),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R2_xy_point_n)
	);

	hitbox_top_generator HTG_rank2 [1:2] (
		.top_offset(R2_xy_point_n),
		.hitbox_top('{top_face_cnt[1], top_face_cnt[2]}),
		.*
	);
	
// --- Rank 3 --------------------------------------------------//	
	
	logic R3_left_face;
	logic R3_right_face;
	logic R3_top_face;
	logic R3_top_color;
	
	logic [20:0] R3_xy_point_n [1:3];
	
	rank_n_generator RNG_rank3 [1:3] (
		.rank_offset(RANK3_XY_OFFSET),
		.shift(shift[1:3]),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R3_xy_point_n)
	);

	hitbox_top_generator HTG_rank3 [1:3] (
		.top_offset(R3_xy_point_n),
		.hitbox_top('{top_face_cnt[3], top_face_cnt[4], top_face_cnt[5]}),
		.*
	);
// --- Rank 4 --------------------------------------------------//	
	
	logic R4_left_face;
	logic R4_right_face;
	logic R4_top_face;
	logic R4_top_color;
	
	logic [20:0] R4_xy_point_n [1:4];
	
	rank_n_generator RNG_rank4 [1:4] (
		.rank_offset(RANK4_XY_OFFSET),
		.shift(shift[1:4]),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R4_xy_point_n)
	);

	hitbox_top_generator HTG_rank4 [1:4] (
		.top_offset(R4_xy_point_n),
		.hitbox_top('{top_face_cnt[6], top_face_cnt[7], 
					top_face_cnt[8], top_face_cnt[9]}),
		.*
	);
	
// --- Rank 5 --------------------------------------------------//	
	
	logic R5_left_face;
	logic R5_right_face;
	logic R5_top_face;
	logic R5_top_color;
	
	logic [20:0] R5_xy_point_n [1:5];
	
	rank_n_generator RNG_rank5 [1:5] (
		.rank_offset(RANK5_XY_OFFSET),
		.shift(shift[1:5]),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R5_xy_point_n)
	);

	hitbox_top_generator HTG_rank5 [1:5] (
		.top_offset(R5_xy_point_n),
		.hitbox_top('{top_face_cnt[10], top_face_cnt[11],
					top_face_cnt[12], top_face_cnt[13],
					top_face_cnt[14]}),
		.*
	);

// --- Rank 6 --------------------------------------------------//	
	
	logic R6_left_face;
	logic R6_right_face;
	logic R6_top_face;
	logic R6_top_color;
	
	logic [20:0] R6_xy_point_n [1:6];
	
	rank_n_generator RNG_rank6 [1:6] (
		.rank_offset(RANK6_XY_OFFSET),
		.shift(shift[1:6]),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R6_xy_point_n)
	);

	hitbox_top_generator HTG_rank6 [1:6] (
		.top_offset(R6_xy_point_n),
		.hitbox_top('{top_face_cnt[15], top_face_cnt[16],
					top_face_cnt[17], top_face_cnt[18],
					top_face_cnt[19], top_face_cnt[20]}),
		.*
	);

// --- Rank 7 --------------------------------------------------//	
	
	logic R7_left_face;
	logic R7_right_face;
	logic R7_top_face;
	logic R7_top_color;
	
	logic [20:0] R7_xy_point_n [1:7];
	
	rank_n_generator RNG_rank7 [1:7] (
		.rank_offset(RANK7_XY_OFFSET),
		.shift(shift[1:7]),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R7_xy_point_n)
	);

	hitbox_top_generator HTG_rank7 [1:7] (
		.top_offset(R7_xy_point_n),
		.hitbox_top('{top_face_cnt[21], top_face_cnt[22],
					top_face_cnt[23], top_face_cnt[24],
					top_face_cnt[25], top_face_cnt[26], 
					top_face_cnt[27]}),
		.*
	);	

	
// -- Qbert and co ---------------------------------------------//

	logic le_qbert;  
	logic [20:0] qbert_xy;
	

// -- Plot 6 cubes----------------------------------------------//
	
	logic [6:0] is_left_face;
	logic [6:0] is_right_face;
	logic [6:0] is_top_face;
	logic [5:0] is_top_color;
	
always_ff @(posedge CLK_33) begin
	
	case ({x_cnt,y_cnt})
	//-- Rank1------------------------//
	// déjà fait tout au dessus
	
	
	//-- Rank2------------------------//
	R2_xy_point_n[1] : xy_offset[2] <= R2_xy_point_n[1];
	R2_xy_point_n[2] : xy_offset[2] <= R2_xy_point_n[2];
	
	//-- Rank3------------------------//
	R3_xy_point_n[1] : xy_offset[3] <= R3_xy_point_n[1];
	R3_xy_point_n[2] : xy_offset[3] <= R3_xy_point_n[2];
	R3_xy_point_n[3] : xy_offset[3] <= R3_xy_point_n[3];

	//-- Rank4------------------------//
	R4_xy_point_n[1] : xy_offset[4] <= R4_xy_point_n[1];
	R4_xy_point_n[2] : xy_offset[4] <= R4_xy_point_n[2];
	R4_xy_point_n[3] : xy_offset[4] <= R4_xy_point_n[3];
	R4_xy_point_n[4] : xy_offset[4] <= R4_xy_point_n[4];
	
	//-- Rank5------------------------//
	R5_xy_point_n[1] : xy_offset[5] <= R5_xy_point_n[1];
	R5_xy_point_n[2] : xy_offset[5] <= R5_xy_point_n[2];
	R5_xy_point_n[3] : xy_offset[5] <= R5_xy_point_n[3];
	R5_xy_point_n[4] : xy_offset[5] <= R5_xy_point_n[4];
	R5_xy_point_n[5] : xy_offset[5] <= R5_xy_point_n[5];
	
	//-- Rank6------------------------//
	R6_xy_point_n[1] : xy_offset[6] <= R6_xy_point_n[1];
	R6_xy_point_n[2] : xy_offset[6] <= R6_xy_point_n[2];
	R6_xy_point_n[3] : xy_offset[6] <= R6_xy_point_n[3];
	R6_xy_point_n[4] : xy_offset[6] <= R6_xy_point_n[4];
	R6_xy_point_n[5] : xy_offset[6] <= R6_xy_point_n[5];
	R6_xy_point_n[6] : xy_offset[6] <= R6_xy_point_n[6];
	
	//-- Rank7------------------------//
	R7_xy_point_n[1] : xy_offset[7] <= R7_xy_point_n[1];
	R7_xy_point_n[2] : xy_offset[7] <= R7_xy_point_n[2];
	R7_xy_point_n[3] : xy_offset[7] <= R7_xy_point_n[3];
	R7_xy_point_n[4] : xy_offset[7] <= R7_xy_point_n[4];
	R7_xy_point_n[5] : xy_offset[7] <= R7_xy_point_n[5];
	R7_xy_point_n[6] : xy_offset[7] <= R7_xy_point_n[6];
	R7_xy_point_n[7] : xy_offset[7] <= R7_xy_point_n[7];
	endcase


	is_left_face <= {R1_left_face, 
					R2_left_face, 
					R3_left_face,
					R4_left_face,
					R5_left_face,
					R6_left_face,
					R7_left_face
					};
					
	is_right_face <= {R1_right_face, 
					R2_right_face, 
					R3_right_face,
					R4_right_face,
					R5_right_face,
					R6_right_face,
					R7_right_face
					};	

	is_top_face <= {R1_top_face, 
					R2_top_face, 
					R3_top_face,
					R4_top_face,
					R5_top_face,
					R6_top_face,
					R7_top_face
					};
					
	is_top_color <= {R1_top_color, 
					R2_top_color, 
					R3_top_color,
					R4_top_color,
					R5_top_color,
					R6_top_color,
					R7_top_color
					};						

// Donne les couleurs
	
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
			if (is_top_color != 0) begin
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

//assign hitbox_top = top_face_cnt;

qbert_layer Beta(
// input
	.clk(CLK_33),
	.reset,
	.x_cnt,
	.y_cnt,
	.qbert_jump,
	.bad_jump,
	.nios_start_qbert,
	.x_offset(QBERT_POSITION_XY0[20:10]),
	.x1(QBERT_POSITION_XY1[20:10]),
	.y_offset(QBERT_POSITION_XY0[9:0]),
	.y1(QBERT_POSITION_XY1[9:0]),
	.XLENGTH,
	.XDIAG_DEMI(XYDIAG_DEMI[20:10]),
	.YDIAG_DEMI(XYDIAG_DEMI[9:0]),
// output
	.qbert_hitbox,
	.done_move,
	.le_qbert,
	.qbert_xy
);

/* 
7 rangées de cubes 
[20:10] xy_offset [6:0], je génère 7 offsets pour les 7 cubes
[] left_face [6:0]
[] right_face [6:0]
[] top_face [6:0] 
Il faut juste un cube pour générer une rangée
*/
cube_generator #(N_cube) rank [1: N_rank + 1](
// input  
	.clk(CLK_33),
	.reset,
	.done_move,
	.x_cnt,
	.y_cnt,
	.XLENGTH,
	.XYDIAG_DEMI,
	.xy_offset(xy_offset),
	.top_face_cnt,
	.nios_top_color,
// output
	.left_face(left_face),
	.right_face(right_face),
	.top_face(top_face),
	.top_color(top_color)
	);


endmodule

//-----------------------------------------------
module rank_offset_generator (
	input logic [10:0] XLENGTH,
	input logic [20:0] RANK1_XY_OFFSET,
	input logic [20:0] XYDIAG_DEMI,
	input logic [9:0] shift,
	output logic [20:0] rank_xy_offset
	);
assign rank_xy_offset = {RANK1_XY_OFFSET[20:10] + shift*(XYDIAG_DEMI[20:10]+XLENGTH+ 11'd1),
						RANK1_XY_OFFSET[9:0] - shift*(XYDIAG_DEMI[9:0]+10'd1)};	
endmodule

//-----------------------------------------------
module rank_n_generator (
	input logic [20:0] rank_offset,
	input logic [9:0] shift,
	input logic [9:0] ydiag,
	output logic [20:0] point_n
	);
assign point_n = {rank_offset[20:10], rank_offset[9:0] + shift*(ydiag + 10'd1)};
endmodule

//-----------------------------------------------
module hitbox_top_generator (
	input logic CLK_33,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	input logic [20:0] top_offset,
	input logic [20:0] XYDIAG_DEMI,
	output logic hitbox_top
);

always_ff @(posedge CLK_33) begin
	hitbox_top <= {(x_cnt <= top_offset[20:10] + XYDIAG_DEMI[20:10] && x_cnt >= top_offset[20:10] - XYDIAG_DEMI[20:10]) 
				&& (y_cnt <= top_offset[9:0] + 10'd2*XYDIAG_DEMI[9:0] && y_cnt >= top_offset[9:0] )};
end
	
endmodule
