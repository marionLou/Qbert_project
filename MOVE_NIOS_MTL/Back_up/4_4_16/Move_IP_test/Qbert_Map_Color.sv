// DATE : 31-03-2016
// modificatio : adaptation pour l'AVALON
// 18:00 : test pour générer trois cubes et les mouvements du qbert

module Qbert_Map_Color(

// --- clk and reset -------------//

	input logic CLK_33,
	input logic reset,
	
// --- Qbert position ------------//

	input e_bad_jump, // NIOS
	input e_start_qb, // NIOS
	input e_pause_qb, // NIOS
	input logic [2:0] e_jump_qb, // NIOS
	input logic [20:0] e_XY0_qb, // NIOS
//	input logic [20:0] position_qb_XY1,
	input logic [N_cube-1:0] e_next_qb, // NIOS
	input logic e_done_move,
	
	output logic [N_cube-1:0] position_qb,
	output logic done_move,
	output logic KO_qb,

// --- Map parameters ------------//

	input logic [10:0] XLENGTH,
	input logic [20:0] XYDIAG_DEMI,
	input logic [20:0] RANK1_XY_OFFSET,
	input logic [N_cube-1:0] e_color_state,


// --- MTL parameters ------------//
	
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [7:0] red,
	output logic [7:0] green,
	output logic [7:0] blue
	);

	parameter N_cube = 3; 
	parameter N_rank = 2; 
	
	// Génération des offsets pour chaque rangée
	logic [20:0] RANK2_XY_OFFSET;
				
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
	logic [N_cube-1:0] hb_top;
	

	
// -- Qbert and co ---------------------------------------------//

	logic le_qbert;  
	logic [20:0] qbert_xy;
	// hitbox qbert
	logic hb_qb;
//	logic [2:0] position_qb;
	
	monster_position Qbert [N_cube-1:0](
					.CLK_33,
					.reset,
					.qbert_xy,
//					.xy('{R2_xy_point_n[1], R2_xy_point_n[0], RANK1_XY_OFFSET}),
					.xy('{R2_xy_point_n, RANK1_XY_OFFSET}),
					.XYDIAG_DEMI,
//					.box('{position_qb[2],position_qb[1],position_qb[0]}) 
					.box(position_qb) 
	);

// --- Rank 1 --------------------------------------------------//


always_ff @(posedge CLK_33) begin
	
	xy_offset [0][20:0] <= RANK1_XY_OFFSET;
	
	hb_top[0] <= {(x_cnt <= RANK1_XY_OFFSET[20:10] + XYDIAG_DEMI[20:10] && x_cnt >= RANK1_XY_OFFSET[20:10] - XYDIAG_DEMI[20:10]) 
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
		.hitbox_top('{hb_top[2], hb_top[1]})
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

//assign hitbox_top = hb_top;

qbert_layer #(N_cube) Beta (
// input
	.clk(CLK_33),
	.reset,
	.x_cnt,
	.y_cnt,
	.e_jump_qb,
	.e_bad_jump,
	.e_start_qb,
	.e_next_qb,
	.position_qb,
	.x_offset(e_XY0_qb[20:10]),
	.y_offset(e_XY0_qb[9:0]),
	.XLENGTH,
	.XDIAG_DEMI(XYDIAG_DEMI[20:10]),
	.YDIAG_DEMI(XYDIAG_DEMI[9:0]),
// output
	.qbert_hitbox(hb_qb),
	.done_move,
	.le_qbert,
	.qbert_xy
);


cube_generator #(N_cube) rank [1:0](
// input  
	.clk(CLK_33),
	.reset,
	.done_move(e_done_move),
	.x_cnt,
	.y_cnt,
	.XLENGTH,
	.XYDIAG_DEMI,
	.xy_offset(xy_offset),
	.position_qb,
	.e_next_qb,
	.hb_top,
	.e_color_state,
	.e_jump_qb,
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

//-----------------------------------------------

module monster_position (
	input logic CLK_33,
	input logic reset,
	input logic [20:0] qbert_xy,
	input logic [20:0] xy,
	input logic [20:0] XYDIAG_DEMI,
	output logic box 
	);
	reg x_min, y_min;
	reg x_max, y_max;
	
	always_ff @(posedge CLK_33) begin
	x_min <= { qbert_xy[20:10] >= xy[20:10] - (XYDIAG_DEMI[20:10] >> 2) };
	y_min <= { qbert_xy[9:0] >= (xy[9:0] + XYDIAG_DEMI[9:0]) - (XYDIAG_DEMI[9:0] >> 2) };
	
	x_max <= { qbert_xy[20:10] <= xy[20:10] + (XYDIAG_DEMI[20:10] >> 2) };
	y_max <= { qbert_xy[9:0] <= (xy[9:0] + XYDIAG_DEMI[9:0]) + (XYDIAG_DEMI[9:0] >> 2) };
	
	box <= { (x_min &&  x_max)  && (y_min &&  y_max) }; 
				
	end
	
endmodule
