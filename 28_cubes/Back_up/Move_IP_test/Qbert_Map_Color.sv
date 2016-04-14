// DATE : 31-03-2016
// modificatio : adaptation pour l'AVALON
// 18:00 : test pour générer trois cubes et les mouvements du qbert

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
	input logic [N_cube - 1:0] nios_top_color,


// --- MTL parameters ------------//
	
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);

	parameter N_cube = 6; 
	parameter N_rank = 3; 
	
	// Génération des offsets pour chaque rangée
	logic [20:0] RANK2_XY_OFFSET, RANK3_XY_OFFSET,
				RANK4_XY_OFFSET, RANK5_XY_OFFSET,
				RANK6_XY_OFFSET, RANK7_XY_OFFSET;
				
	logic [9:0] shift [2:0] = '{10'd2, 10'd1, 10'd0};
								

								
    rank_offset_generator ROG (
						.XLENGTH,
						.RANK1_XY_OFFSET,
						.XYDIAG_DEMI,
						.shift(shift[1]),
						.rank_xy_offset( RANK2_XY_OFFSET )
						);
	
	// curseur pour tracer les cubes
	logic [20:0] xy_offset [1:0];
	
	// output des cubes
	logic [1:0]	right_face, left_face,
				top_face, top_color;
	
	// hitbox top cube
	logic [N_cube-1:0] top_face_cnt;
	

	
// -- Qbert and co ---------------------------------------------//

	logic le_qbert;  
	logic [20:0] qbert_xy;
	// hitbox qbert
	logic qbert_hitbox;

// --- Rank 1 --------------------------------------------------//


always_ff @(posedge CLK_33) begin
	
	xy_offset [0][20:0] <= RANK1_XY_OFFSET;
	
	top_face_cnt[0] <= {(x_cnt <= RANK1_XY_OFFSET[20:10] + XYDIAG_DEMI[20:10] && x_cnt >= RANK1_XY_OFFSET[20:10] - XYDIAG_DEMI[20:10]) 
				&& (y_cnt <= RANK1_XY_OFFSET[9:0] + 10'd2*XYDIAG_DEMI[9:0] && y_cnt >= RANK1_XY_OFFSET[9:0] )};
end

 
// --- Rank 2 --------------------------------------------------//
	
	logic [20:0] R2_xy_point_n [1:0];
	
	rank_n_generator RNG_rank2 [1:0] (
		.rank_offset(RANK2_XY_OFFSET),
		.shift(shift[1:0]),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R2_xy_point_n)
	);

	hitbox_top_generator HTG_rank2 [1:0] (
		.*,
		.top_offset(R2_xy_point_n),
		.hitbox_top('{top_face_cnt[2], top_face_cnt[1]})
	);
	
	
always_ff @(posedge CLK_33) begin
	
	case ({x_cnt,y_cnt})
	//-- Rank1------------------------//
	// déjà fait tout au dessus
		
	//-- Rank2------------------------//
	R2_xy_point_n[0]-{11'd1,10'd1} : xy_offset[1] <= R2_xy_point_n[0];
	R2_xy_point_n[1]-{11'd1,10'd1} : xy_offset[1] <= R2_xy_point_n[1];
	
	endcase

// Donne les couleurs
	
		if (le_qbert) begin
			red <= 8'd216;
			green <= 8'd95;
			blue <= 8'd2;
		end
		else if(left_face !=0) begin
			red 	<= 8'd86;
			green <= 8'd169;
			blue 	<= 8'd152;
		end
		else if(right_face != 0) begin
			red <= 8'd49;
			green <= 8'd70;
			blue <= 8'd70;
		end
		else if( top_face != 0) begin
			if ( top_color != 0) begin
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


cube_generator #(N_cube) rank [1:0](
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
	.qbert_jump,
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
