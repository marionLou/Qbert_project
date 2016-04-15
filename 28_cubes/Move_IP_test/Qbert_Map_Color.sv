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
	input logic e_resume_qb,
	input logic [31:0] e_speed_qb,
	input logic [2:0] e_jump_qb, // NIOS
	input logic [20:0] e_XY0_qb, // NIOS
	input logic [27:0] e_next_qb, // NIOS
	input logic e_done_move,
	
	output logic [27:0] position_qb,
	output logic done_move,
	output logic [3:0] KO_qb,
	output logic [2:0] state_qb,
	output logic [2:0] game_qb,
	output logic [31:0] test_count,
	
	output logic [1:0] saucer_qb_state,
	
// ---- Soucoupe definition ------//
	
	input logic [20:0] e_XY0_sc,
	input logic [1:0] e_tilt_acc,
	
	output logic [1:0] state_sc,
	output logic done_move_sc,
	output logic qb_on_sc,
	output logic [20:0] soucoupe_xy,

// --- Map parameters ------------//

	input logic [10:0] XLENGTH,
	input logic [20:0] XYDIAG_DEMI,
	input logic [20:0] RANK1_XY_OFFSET,
	input logic [27:0] e_color_state,


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
	logic [20:0] RANK_XY_OFFSET [6:0];
				
	logic [9:0] shift [6:0] = '{10'd6, 10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0};
//	logic [6:0] unplus = {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
//'{10'd6, 10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0}							
    rank_offset_generator ROG [6:0](
						.XLENGTH,
						.RANK1_XY_OFFSET,
						.XYDIAG_DEMI,
						.shift(shift),
						.rank_xy_offset( RANK_XY_OFFSET )
						);
	// couleur
//	logic [7:0] decolor;
	// curseur pour tracer les cubes
	logic [20:0] xy_offset [6:0];
	
	// output des cubes
	logic [6:0]	right_face, left_face,
				top_face, top_color;
	
	// hitbox top cube
	logic [27:0] hb_top;
	

	
// -- Qbert and co ---------------------------------------------//

	logic le_qbert;  
	logic [20:0] qbert_xy;
	// hitbox qbert
	logic hb_qb;
	logic mode_saucer;

	logic la_soucoupe;
	logic hb_sc;
//	logic [20:0] soucoupe_xy;


// --- Rank 1 --------------------------------------------------//


always_ff @(posedge CLK_33) begin
	
	xy_offset [0][20:0] <= RANK1_XY_OFFSET;
	
	hb_top[0] <= {(x_cnt <= RANK1_XY_OFFSET[20:10] + XYDIAG_DEMI[20:10] && x_cnt >= RANK1_XY_OFFSET[20:10] - XYDIAG_DEMI[20:10]) 
				&& (y_cnt <= RANK1_XY_OFFSET[9:0] + 10'd2*XYDIAG_DEMI[9:0] && y_cnt >= RANK1_XY_OFFSET[9:0] )};
	
end

	monster_position MP_rank1(
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(RANK1_XY_OFFSET),
					.XYDIAG_DEMI, 
					.box(position_qb[0]) 
	);

 
// --- Rank 2 --------------------------------------------------//
	
	logic [20:0] R2_xy_point_n [1:0];
	
	rank_n_generator RNG_rank2 [1:0] (
		.rank_offset(RANK_XY_OFFSET[1][20:0]),
		.shift(shift[1:0]), 
//		.shift('{10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R2_xy_point_n)
	);

	hitbox_top_generator HTG_rank2 [1:0] (
		.*,
		.top_offset(R2_xy_point_n),
		.hitbox_top(hb_top[2:1])
	);
	
		monster_position MP_rank2 [1:0](
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(R2_xy_point_n),
					.XYDIAG_DEMI, 
					.box(position_qb[2:1]) 
	);
	
// --- Rank 3 --------------------------------------------------//
	
	logic [20:0] R3_xy_point_n [2:0];
	
	rank_n_generator RNG_rank3 [2:0] (
		.rank_offset(RANK_XY_OFFSET[2][20:0]),
		.shift(shift[2:0]),
//		.shift('{10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R3_xy_point_n)
	);

	hitbox_top_generator HTG_rank3 [2:0] (
		.*,
		.top_offset(R3_xy_point_n),
		.hitbox_top(hb_top[5:3])
	);
	
		monster_position MP_rank3 [2:0](
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(R3_xy_point_n),
					.XYDIAG_DEMI, 
					.box(position_qb[5:3]) 
	);
	
// --- Rank 4 --------------------------------------------------//
	
	logic [20:0] R4_xy_point_n [3:0];
	
	rank_n_generator RNG_rank4 [3:0] (
		.rank_offset(RANK_XY_OFFSET[3][20:0]),
		.shift(shift[3:0]),
//		.shift('{10'd3, 10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R4_xy_point_n)
	);

	hitbox_top_generator HTG_rank4 [3:0] (
		.*,
		.top_offset(R4_xy_point_n),
		.hitbox_top(hb_top[9:6])
	);
	
		monster_position MP_rank4 [3:0](
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(R4_xy_point_n),
					.XYDIAG_DEMI, 
					.box(position_qb[9:6]) 
	);
	
// --- Rank 5 --------------------------------------------------//
	
	logic [20:0] R5_xy_point_n [4:0];
	
	rank_n_generator RNG_rank5 [4:0] (
		.rank_offset(RANK_XY_OFFSET[4][20:0]),
		.shift(shift[4:0]), 
//		.shift('{10'd4, 10'd3, 10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R5_xy_point_n)
	);

	hitbox_top_generator HTG_rank5 [4:0] (
		.*,
		.top_offset(R5_xy_point_n),
		.hitbox_top(hb_top[14:10])
	);
	
		monster_position MP_rank5 [4:0](
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(R5_xy_point_n),
					.XYDIAG_DEMI, 
					.box(position_qb[14:10]) 
	);
	


// --- Rank 6 --------------------------------------------------//
	
	logic [20:0] R6_xy_point_n [5:0];
	
	rank_n_generator RNG_rank6 [5:0] (
		.rank_offset(RANK_XY_OFFSET[5][20:0]),
		.shift(shift[5:0]),
//		.shift('{10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R6_xy_point_n)
	);

	hitbox_top_generator HTG_rank6 [5:0] (
		.*,
		.top_offset(R6_xy_point_n),
		.hitbox_top(hb_top[20:15])
	);
	
		monster_position MP_rank6 [5:0](
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(R6_xy_point_n),
					.XYDIAG_DEMI, 
					.box(position_qb[20:15]) 
	);
	
// --- Rank 7 --------------------------------------------------//
	
	logic [20:0] R7_xy_point_n [6:0];
	
	rank_n_generator RNG_rank7 [6:0] (
		.rank_offset(RANK_XY_OFFSET[6][20:0]),
		.shift(shift),
//		.shift('{10'd6,10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0}), 
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R7_xy_point_n)
	);

	hitbox_top_generator HTG_rank7 [6:0] (
		.*,
		.top_offset(R7_xy_point_n),
		.hitbox_top(hb_top[27:21])
	);
	
		monster_position MP_rank7 [6:0](
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(R7_xy_point_n),
					.XYDIAG_DEMI, 
					.box(position_qb[27:21]) 
	);
	
always_ff @(posedge CLK_33) begin
	
	case ({x_cnt,y_cnt})
	//-- Rank1------------------------//
	// déjà fait tout au dessus
		
	//-- Rank2------------------------//
	R2_xy_point_n[0]-{11'd1,10'd1} : xy_offset[1] <= R2_xy_point_n[0];
	R2_xy_point_n[1]-{11'd1,10'd1} : xy_offset[1] <= R2_xy_point_n[1];
	
	//-- Rank3------------------------//
	R3_xy_point_n[0]-{11'd1,10'd1} : xy_offset[2] <= R3_xy_point_n[0];
	R3_xy_point_n[1]-{11'd1,10'd1} : xy_offset[2] <= R3_xy_point_n[1];
	R3_xy_point_n[2]-{11'd1,10'd1} : xy_offset[2] <= R3_xy_point_n[2];
	
	//-- Rank4------------------------//
	R4_xy_point_n[0]-{11'd1,10'd1} : xy_offset[3] <= R4_xy_point_n[0];
	R4_xy_point_n[1]-{11'd1,10'd1} : xy_offset[3] <= R4_xy_point_n[1];
	R4_xy_point_n[2]-{11'd1,10'd1} : xy_offset[3] <= R4_xy_point_n[2];
	R4_xy_point_n[3]-{11'd1,10'd1} : xy_offset[3] <= R4_xy_point_n[3];
	
	//-- Rank5------------------------//
	R5_xy_point_n[0]-{11'd1,10'd1} : xy_offset[4] <= R5_xy_point_n[0];
	R5_xy_point_n[1]-{11'd1,10'd1} : xy_offset[4] <= R5_xy_point_n[1];
	R5_xy_point_n[2]-{11'd1,10'd1} : xy_offset[4] <= R5_xy_point_n[2];
	R5_xy_point_n[3]-{11'd1,10'd1} : xy_offset[4] <= R5_xy_point_n[3];
	R5_xy_point_n[4]-{11'd1,10'd1} : xy_offset[4] <= R5_xy_point_n[4];
	
	//-- Rank6------------------------//
	R6_xy_point_n[0]-{11'd1,10'd1} : xy_offset[5] <= R6_xy_point_n[0];
	R6_xy_point_n[1]-{11'd1,10'd1} : xy_offset[5] <= R6_xy_point_n[1];
	R6_xy_point_n[2]-{11'd1,10'd1} : xy_offset[5] <= R6_xy_point_n[2];
	R6_xy_point_n[3]-{11'd1,10'd1} : xy_offset[5] <= R6_xy_point_n[3];
	R6_xy_point_n[4]-{11'd1,10'd1} : xy_offset[5] <= R6_xy_point_n[4];
	R6_xy_point_n[5]-{11'd1,10'd1} : xy_offset[5] <= R6_xy_point_n[5];
	
	//-- Rank7------------------------//
	R7_xy_point_n[0]-{11'd1,10'd1} : xy_offset[6] <= R7_xy_point_n[0];
	R7_xy_point_n[1]-{11'd1,10'd1} : xy_offset[6] <= R7_xy_point_n[1];
	R7_xy_point_n[2]-{11'd1,10'd1} : xy_offset[6] <= R7_xy_point_n[2];
	R7_xy_point_n[3]-{11'd1,10'd1} : xy_offset[6] <= R7_xy_point_n[3];
	R7_xy_point_n[4]-{11'd1,10'd1} : xy_offset[6] <= R7_xy_point_n[4];
	R7_xy_point_n[5]-{11'd1,10'd1} : xy_offset[6] <= R7_xy_point_n[5];
	R7_xy_point_n[6]-{11'd1,10'd1} : xy_offset[6] <= R7_xy_point_n[6];
	
	endcase


// Donne les couleurs
//		if(e_pause_qb) decolor <= 8'd50;
//		else decolor <= 8'd0;
if(e_pause_qb) begin 
		if(hb_qb & (position_qb != 0)) begin
				red <= 8'd255;
				green <= 8'd145;
				blue <= 8'd52;
		end
		else if (hb_sc & la_soucoupe) begin
				red <= 8'd255;
				green <= 8'd78;
				blue <= 8'd86;	
		end
		else if(hb_top !=0) begin
			red 	<= 8'd136;
			green <= 8'd219;
			blue 	<= 8'd202;
		end
/*		else if(left_face !=0) begin
			red 	<= 8'd136;
			green <= 8'd219;
			blue 	<= 8'd202;
		end
		else if(right_face != 0) begin
			red <= 8'd99;
			green <= 8'd120;
			blue <= 8'd120;
		end 
		else if( top_face != 0) begin
			if ( top_color != 0) begin
				red <= 8'd136; 
				green <= 8'd120;
				blue <= 8'd255;
			end
			else begin
				red <= 8'd255;
				green <= 8'd255;
				blue <= 8'd50;
			end
		end*/
		else begin
		red 	<= 8'd50;
		green <= 8'd50;
		blue 	<= 8'd50;
		end
end
else begin		
		if(hb_qb & (position_qb != 0)) begin
				red <= 8'd216;
				green <= 8'd95;
				blue <= 8'd2;
		end
		else if (hb_sc & la_soucoupe) begin
				red <= 8'd237;
				green <= 8'd28;
				blue <= 8'd36;	
		end	
/*		else if(left_face !=0) begin
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
			else begin 
				red <= 8'd222;
				green <= 8'd222;
				blue <= 8'd0;
			end
		end */
		else if(hb_top !=0) begin
			red 	<= 8'd136;
			green <= 8'd219;
			blue 	<= 8'd202;
		end
		else begin
		red 	<= 8'd0;
		green <= 8'd0;
		blue 	<= 8'd0;
		end
	end
end

//assign hitbox_top = hb_top;

qbert_layer #(28) Beta (
// input
	.clk(CLK_33),
	.reset,
	.x_cnt,
	.y_cnt,
	.e_jump_qb,
	.e_bad_jump,
	.e_start_qb,
	.e_resume_qb,
	.e_speed_qb,
	.e_pause_qb,
	.e_next_qb,
	.position_qb,
	.x_offset(e_XY0_qb[20:10]),
	.y_offset(e_XY0_qb[9:0]),
	.XLENGTH,
	.XDIAG_DEMI(XYDIAG_DEMI[20:10]),
	.YDIAG_DEMI(XYDIAG_DEMI[9:0]),
	
	.soucoupe_xy,
	.qb_on_sc,
	.done_move_sc,
	.e_tilt_acc,
// output
	.qbert_hitbox(hb_qb),
	.KO_qb,
	.state_qb, 
	.game_qb,
	.done_move,
	.saucer_qb_state,
	.mode_saucer,
	.le_qbert,
	.test_count,
	.qbert_xy
);

soucoup_layer Flying_Saucer(
// input
	.clk(CLK_33),
	.reset,
	.x_cnt,
	.y_cnt,
	.XLENGTH,
	.XDIAG_DEMI(XYDIAG_DEMI[20:10]),
	.YDIAG_DEMI(XYDIAG_DEMI[9:0]),
	
	.e_pause_qb,
	.e_start_qb,
	.e_resume_qb,
	.e_speed_qb,
	.e_XY0_qb,
	.e_XY0_sc,
	.qbert_xy,
	.mode_saucer,
	.qbert_hitbox(hb_qb),
	
// output
	
	.soucoupe_xy,
	.qb_on_sc,
	.done_move_sc,
	.soucoupe_hitbox(hb_sc),
	.state_sc, // etat de la soucoupe
	.la_soucoupe
	);

cube_generator #(28) rank [6:0](
// input  
	.clk(CLK_33),
	.reset,
//	.done_move(e_done_move),
	.done_move,
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
assign rank_xy_offset = {RANK1_XY_OFFSET[20:10] + shift*(XYDIAG_DEMI[20:10]+XLENGTH),
						RANK1_XY_OFFSET[9:0] - shift*(XYDIAG_DEMI[9:0])};	
endmodule

//-----------------------------------------------
module rank_n_generator (
	input logic [20:0] rank_offset,
	input logic [9:0] shift,
	input logic [9:0] ydiag,
	output logic [20:0] point_n
	);
assign point_n = {rank_offset[20:10], rank_offset[9:0] + shift*(ydiag)};
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
	x_min <= { qbert_xy[20:10] >= xy[20:10] - (XYDIAG_DEMI[20:10]/11'd2) };
	y_min <= { qbert_xy[9:0] >= (xy[9:0] + XYDIAG_DEMI[9:0]) - (XYDIAG_DEMI[9:0]/10'd2) };
	
	x_max <= { qbert_xy[20:10] <= xy[20:10] + (XYDIAG_DEMI[20:10]/11'd2) };
	y_max <= { qbert_xy[9:0] <= (xy[9:0] + XYDIAG_DEMI[9:0]) + (XYDIAG_DEMI[9:0]/10'd2) };
	
	box <= { (x_min &&  x_max)  && (y_min &&  y_max) }; 
				
	end
	
endmodule
