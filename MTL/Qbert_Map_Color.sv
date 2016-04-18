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
	input logic e_freeze_power, // NIOS
	
	output logic [27:0] position_qb,
	output logic done_move_qb,
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
// --- Boule rouge definition ----//

	output logic [27:0] position_br [3:0],
	
	
	
// --- Serpent definition --------//
	output logic [27:0] position_sp,
	
// --- Cochon definition ---------//
	output logic [27:0] position_cc [3:0],
	
// --- Fantome definition --------//
	output logic [27:0] position_ft,
	
// --- Map parameters ------------//

	input logic [10:0] XLENGTH,
	input logic [20:0] XYDIAG_DEMI,
	input logic [20:0] RANK1_XY_OFFSET,
	input logic [27:0] e_color_state,


// --- MTL parameters ------------//
	
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [7:0] R,
	output logic [7:0] G,
	output logic [7:0] B
	);

	parameter N_cube = 3; 
	parameter N_rank = 2; 
	
	logic [20:0] XYRECT = XYDIAG_DEMI - {11'd3,10'd3};
	
	// Génération des offsets pour chaque rangée
	logic [20:0] RANK2_XY_OFFSET;
	logic [20:0] RANK_XY_OFFSET [6:0];
				
	logic [9:0] shift [6:0] = '{10'd6, 10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0};
							
    rank_offset_generator ROG [6:0](
						.XLENGTH,
						.RANK1_XY_OFFSET,
						.XYDIAG_DEMI,
						.shift(shift),
						.rank_xy_offset( RANK_XY_OFFSET )
						);
						
	
	// output des cubes
	logic [27:0] top_color;
	
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



	hitbox_top_generator HTG_rank1 (
		.*,
		.XYDIAG_DEMI(XYRECT), 
		.top_offset(RANK1_XY_OFFSET),
		.e_color_bit(e_color_state[0]),
		.top_color(top_color[0]),
		.hitbox_top(hb_top[0])
	);
	
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
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R2_xy_point_n)
	);

	hitbox_top_generator HTG_rank2 [1:0] (
		.*,
		.XYDIAG_DEMI(XYRECT),
		.top_offset(R2_xy_point_n),
		.e_color_bit(e_color_state[2:1]),
		.top_color(top_color[2:1]),
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
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R3_xy_point_n)
	);

	hitbox_top_generator HTG_rank3 [2:0] (
		.*,
		.XYDIAG_DEMI(XYRECT),
		.top_offset(R3_xy_point_n),
		.e_color_bit(e_color_state[5:3]),
		.top_color(top_color[5:3]),
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
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R4_xy_point_n)
	);

	hitbox_top_generator HTG_rank4 [3:0] (
		.*,
		.XYDIAG_DEMI(XYRECT),
		.top_offset(R4_xy_point_n),
		.e_color_bit(e_color_state[9:6]),
		.top_color(top_color[9:6]),
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
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R5_xy_point_n)
	);

	hitbox_top_generator HTG_rank5 [4:0] (
		.*,
		.XYDIAG_DEMI(XYRECT),
		.top_offset(R5_xy_point_n),
		.e_color_bit(e_color_state[14:10]),
		.top_color(top_color[14:10]),
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
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R6_xy_point_n)
	);

	hitbox_top_generator HTG_rank6 [5:0] (
		.*,
		.XYDIAG_DEMI(XYRECT),
		.top_offset(R6_xy_point_n),
		.e_color_bit(e_color_state[20:15]),
		.top_color(top_color[20:15]),
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
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R7_xy_point_n)
	);

	hitbox_top_generator HTG_rank7 [6:0] (
		.*,
		.XYDIAG_DEMI(XYRECT),
		.top_offset(R7_xy_point_n),
		.e_color_bit(e_color_state[27:21]),
		.top_color(top_color[27:21]),
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



parameter logic [23:0] top_0_RGB = {8'd222,8'd222,8'd0};
parameter logic [23:0] top_1_RGB = {8'd86,8'd70,8'd239};
parameter logic [23:0] soucoupe_RGB = {8'd237,8'd28,8'd36};
parameter logic [23:0] qbert_RGB = {8'd216,8'd95,8'd2};
parameter logic [23:0] boule_rouge_RGB = {8'd220,8'd0,8'd0};
parameter logic [23:0] serpent_RGB = {8'd228,8'd0,8'd186};
parameter logic [23:0] background_0_RGB = {8'd0,8'd0,8'd0};

parameter logic [23:0] p_top_0_RGB = {8'd255,8'd255,8'd50};
parameter logic [23:0] p_top_1_RGB = {8'd136,8'd120,8'd255};
parameter logic [23:0] p_soucoupe_RGB = {8'd255,8'd78,8'd86};
parameter logic [23:0] p_qbert_RGB = {8'd255,8'd145,8'd52};
parameter logic [23:0] p_boule_rouge_RGB = {8'd255,8'd50,8'd50};
parameter logic [23:0] p_serpent_RGB = {8'd255,8'd50,8'd236};
parameter logic [23:0] p_background_0_RGB = {8'd50,8'd50,8'd50};

logic game_state_fsm;
logic pause_color;
logic pause_state;
logic resume,pause,restart;
logic menu_screen;
logic gameover_screen;
logic win_qb;

logic [23:0] gameover_RGB;
logic [23:0] menu_RGB;
 	
always_ff @(posedge CLK_33) begin

	
	case (pause_state)
	1'b0 : 	if(e_pause_qb) begin 
				pause_color <= 1'b1;
				pause_state <= 1'b1;
			end
	1'b1 : 	if(e_resume_qb|e_start_qb) begin
				pause_color <= 1'b0;
				pause_state <= 1'b0;
			end
	endcase
	
	if(menu_screen) {R,G,B} <= menu_RGB;
	else if (gameover_screen) 
		{R,G,B} <= gameover_RGB;	
	else if (pause_color) begin 
		if(hb_qb & le_qbert) 
			{R,G,B} <= p_qbert_RGB;
		else if (hb_sc & la_soucoupe) 
			{R,G,B} <= p_soucoupe_RGB;
		else if(hb_top !=0) begin				
			if ( top_color != 0) 
				{R,G,B} <= p_top_1_RGB;
			else 
				{R,G,B} <= p_top_0_RGB;
		end 
		else {R,G,B} <= p_background_0_RGB;		
	end
	else begin
		if(hb_qb & le_qbert) 
			{R,G,B} <= qbert_RGB;
		else if (hb_sc & la_soucoupe) 
			{R,G,B} <= soucoupe_RGB;
		else if(hb_top !=0) begin				
			if ( top_color != 0) 
				{R,G,B} <= top_1_RGB;
			else {R,G,B} <= top_0_RGB;
		end 
		else {R,G,B} <= background_0_RGB;		
	end

end


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
	
Menu_game intro(
	.clk,
	.reset,
	.x_cnt,
	.y_cnt,	
	.menu_RGB
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
	input logic e_color_bit,
	input logic [27:0] position_qb,
	input logic [27:0] e_next_qb,
	
	output logic top_color,
	output logic hitbox_top
);

typedef enum logic {IDLE, UPDATE} state_t;
	state_t color_bit;
	
reg top_color_reg;	
reg color_state_reg;

always_ff @(posedge CLK_33) begin
	hitbox_top <= {(x_cnt <= top_offset[20:10] + XYDIAG_DEMI[20:10] && x_cnt >= top_offset[20:10] - XYDIAG_DEMI[20:10]) 
				&& (y_cnt <= top_offset[9:0] + 10'd2*XYDIAG_DEMI[9:0] && y_cnt >= top_offset[9:0] )};
				
	case(color_bit)
	IDLE : 	begin
					top_color_reg <= color_state_reg;
					if (position_qb != e_next_qb) color_bit <= UPDATE;
				end	
	UPDATE : if (done_move) begin
					color_state_reg <= e_color_bit;
					top_color_reg <= color_state_reg & hb_top;
					color_bit <= IDLE;
				end
				else top_color_reg <= color_state_reg;
end

assign top_color = top_color_reg; 
	
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
