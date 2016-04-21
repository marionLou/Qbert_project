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
	input logic e_menu_qb,
	input logic e_win_qb,
	
	input logic [31:0] e_speed_qb,
	input logic [2:0] e_jump_qb, // NIOS
	input logic [20:0] e_XY0_qb, // NIOS
	input logic [27:0] e_next_qb, // NIOS
	
	output logic [27:0] position_qb,
	output logic done_move_qb,
	output logic [3:0] LIFE_qb,
	output logic [2:0] state_qb,
	output logic [2:0] game_qb,
	
	output logic [1:0] saucer_qb_state,
	
	output logic [6:0] coin,
	
// ---- Freeze definition --------//

	input logic e_freeze_acc, // NIOS
	input logic e_timer_freeze,
// --- Arcade gameover -----------//

	input logic e_piece,

// ---- Soucoupe definition ------//
	
	input logic [20:0] e_XY0_sc,
	input logic [1:0] e_tilt_acc,
	
	output logic [1:0] state_sc,
	output logic done_move_sc,
	output logic qb_on_sc,
	output logic [20:0] soucoupe_xy,
	
// --- SDRAM data --------------- //
	input	 	wire [31:0]	  iREAD_DATA,
	input		wire		  	  oREAD_SDRAM_EN,
	output	wire	[7:0]	  imgSD,
	
// --- Touch definition --------- //
	input 	wire	[9:0]		x_touch,
	input 	wire	[8:0]		y_touch,
	input 	wire				pulse_touch,
	
// --- Boule rouge definition ----//


//	output logic [27:0] position_br [3:0],
	
	
	
// --- Serpent definition --------//
//	output logic [27:0] position_sp,
	
// --- Cochon definition ---------//
//	output logic [27:0] position_cc [3:0],
	
// --- Fantome definition --------//
//	output logic [27:0] position_ft,
	
// --- Map parameters ------------//

//	input logic [10:0] XLENGTH,
//	input logic [20:0] XYDIAG_DEMI,
//	input logic [20:0] RANK1_XY_OFFSET,
	input logic [27:0] e_color_state,


// --- MTL parameters ------------//
	
	input logic [10:0] x_cnt, 
	input logic [9:0] y_cnt,
	output logic [23:0] Qbert_RGB
	);

	
	parameter N_cube = 3; 
	parameter N_rank = 2; 
	
	
	logic [10:0] XLENGTH = 11'd22;
	logic [20:0] XYDIAG_DEMI = {11'd15, 10'd22};
	logic [20:0] XYDIAG = {11'd30, 10'd44};
	logic [10:0] R1_X_OFFSET = 11'd250;
	logic [9:0] R1_Y_OFFSET = 10'd190;
	logic [20:0] R1_XY_OFFSET = {11'd250, 10'd190};
	
//	logic [20:0] XYRECT = XYDIAG_DEMI - {11'd3,10'd3};
	
	// Génération des offsets pour chaque rangée
	logic [20:0] RANK_XY_OFFSET [6:0];
				
//	logic [9:0] shift [6:0] = '{10'd6, 10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0};
/*							
    rank_offset_generator ROG [6:0](
						.XLENGTH,
						.RANK1_XY_OFFSET,
						.XYDIAG_DEMI,
						.shift(shift),
						.rank_xy_offset( RANK_XY_OFFSET )
						);
*/						

	// curseur pour tracer les cubes
	logic [20:0] xy_offset [6:0];
	
	// output des cubes
	logic [6:0]	right_face, left_face,
				top_face, top_color;
	
	// hitbox top cube
	logic [27:0] hb_top;
	
	//---- Touch ----------//
	logic p_impulse;
	assign p_impulse = (x_touch>11'd250 && x_touch<11'd430 && y_touch>10'd110 && y_touch<10'd260) ? pulse_touch : 1'b0;
	
	logic p_imp_l1, p_imp_l2, p_imp_l3, p_imp_l4;
	assign p_imp_l1 = (x_cnt>11'd245 && x_cnt<11'd255 && y_cnt>10'd110 && y_cnt<10'd260);
	assign p_imp_l2 = (x_cnt>11'd250 && x_cnt<11'd430 && y_cnt>10'd105 && y_cnt<10'd115);
	assign p_imp_l3 = (x_cnt>11'd425 && x_cnt<11'd435 && y_cnt>10'd110 && y_cnt<10'd260);
	assign p_imp_l4 = (x_cnt>11'd250 && x_cnt<11'd430 && y_cnt>10'd255 && y_cnt<10'd265);
	
	logic touch_enter;
	assign touch_enter = (x_touch>11'd550 && x_touch<11'd650 && y_touch>10'd150 && y_touch<10'd350) ? pulse_touch : 1'b0;
	
	logic p_touch_l1, p_touch_l2, p_touch_l3, p_touch_l4;
	assign p_touch_l1 = (x_cnt>11'd545 && x_cnt<11'd555 && y_cnt>10'd150 && y_cnt<10'd350);
	assign p_touch_l2 = (x_cnt>11'd550 && x_cnt<11'd650 && y_cnt>10'd145 && y_cnt<10'd155);
	assign p_touch_l3 = (x_cnt>11'd645 && x_cnt<11'd655 && y_cnt>10'd150 && y_cnt<10'd350);
	assign p_touch_l4 = (x_cnt>11'd550 && x_cnt<11'd650 && y_cnt>10'd345 && y_cnt<10'd355);
	
// -- Menu -----------------------------------------------------//
	logic arcade, showArc;
	assign arcade = (x_touch>11'd100 && x_touch<11'd200 && y_touch>10'd100 && y_touch<10'd400)? pulse_touch : 1'b0;
	logic arc_1, arc_2, arc_3, arc_4;
	assign arc_1 = (x_cnt>11'd97 && x_cnt<11'd103 && y_cnt>10'd100 && y_cnt<10'd400);
	assign arc_2 = (x_cnt>11'd100 && x_cnt<11'd200 && y_cnt>10'd97 && y_cnt<10'd103);
	assign arc_3 = (x_cnt>11'd197 && x_cnt<11'd203 && y_cnt>10'd100 && y_cnt<10'd400);
	assign arc_4 = (x_cnt>11'd100 && x_cnt<11'd200 && y_cnt>10'd397 && y_cnt<10'd403);
	
	logic speed_run, showRun;
	assign speed_run = (x_touch>11'd400 && x_touch<11'd500 && y_touch>10'd100 && y_touch<10'd400)? pulse_touch : 1'b0;
	logic speed_run_1, speed_run_2, speed_run_3, speed_run_4;
	assign speed_run_1 = (x_cnt>11'd397 && x_cnt<11'd403 && y_cnt>10'd100 && y_cnt<10'd400);
	assign speed_run_2 = (x_cnt>11'd400 && x_cnt<11'd500 && y_cnt>10'd97 && y_cnt<10'd103);
	assign speed_run_3 = (x_cnt>11'd397 && x_cnt<11'd403 && y_cnt>10'd100 && y_cnt<10'd400);
	assign speed_run_4 = (x_cnt>11'd400 && x_cnt<11'd500 && y_cnt>10'd397 && y_cnt<10'd403);
	

	logic sub_arc, sub_arcT;
	assign sub_arc = (x_cnt>11'd250 && x_cnt<11'd350 && y_cnt>10'd100 && y_cnt<10'd400);
	assign sub_arcT = (x_touch>11'd250 && x_touch<11'd350 && y_touch>10'd100 && y_touch<10'd400) ? pulse_touch : 1'b0;
	logic sub_run, sub_runT;
	assign sub_run = (x_cnt>11'd550 && x_cnt<11'd650 && y_cnt>10'd100 && y_cnt<10'd400);
	assign sub_runT = (x_touch>11'd550 && x_touch<11'd650 && y_touch>10'd100 && y_cnt<10'd400) ? pulse_touch : 1'b0;	

	
// -- Qbert and co ---------------------------------------------//

	logic le_qbert;  
	logic [20:0] qbert_xy;
	// hitbox qbert
	logic hb_qb;
	logic mode_saucer;
	logic gameover_qb;

	logic la_soucoupe;
	logic hb_sc;
//	logic [20:0] soucoupe_xy;


// --- Rank 1 --------------------------------------------------//



always_ff @(posedge CLK_33) begin
	
	xy_offset [0][20:0] <= R1_XY_OFFSET;
	
	hb_top[0] <= {(x_cnt <= R1_XY_OFFSET[20:10] + XYDIAG_DEMI[20:10] && x_cnt >= R1_XY_OFFSET[20:10] - XYDIAG_DEMI[20:10]) 
				&& (y_cnt <= R1_XY_OFFSET[9:0] + XYDIAG[9:0] && y_cnt >= R1_XY_OFFSET[9:0] )};
	
end

	monster_position MP_rank1(
					.CLK_33,
					.reset,
					.qbert_xy,
					.xy(R1_XY_OFFSET),
					.XYDIAG_DEMI, 
					.box(position_qb[0]) 
	);

 
// --- Rank 2 --------------------------------------------------//
	
	logic [20:0] R2_xy_point_n [1:0] = '{{11'd287, 10'd212},{11'd287, 10'd168}};
/*	
	rank_n_generator RNG_rank2 [1:0] (
		.rank_offset(RANK_XY_OFFSET[1][20:0]),
		.shift(shift[1:0]), 
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R2_xy_point_n)
	);
*/
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
	
	logic [20:0] R3_xy_point_n [2:0] =  '{{11'd324, 10'd234}, {11'd324, 10'd190}, {11'd324, 10'd146}};
	
/*	rank_n_generator RNG_rank3 [2:0] (
		.rank_offset(RANK_XY_OFFSET[2][20:0]),
		.shift(shift[2:0]),
//		.shift('{10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R3_xy_point_n)
	);*/

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
	
	logic [20:0] R4_xy_point_n [3:0] =  '{{11'd361, 10'd256}, {11'd361, 10'd212},
													  {11'd361, 10'd168}, {11'd361, 10'd124}};
	
/*	rank_n_generator RNG_rank4 [3:0] (
		.rank_offset(RANK_XY_OFFSET[3][20:0]),
		.shift(shift[3:0]),
//		.shift('{10'd3, 10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R4_xy_point_n)
	);*/

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
	
	logic [20:0] R5_xy_point_n [4:0] = '{{11'd398, 10'd278}, {11'd398, 10'd234}, {11'd398, 10'd190},
													 {11'd398, 10'd146}, {11'd398, 10'd102}};
	
/*	rank_n_generator RNG_rank5 [4:0] (
		.rank_offset(RANK_XY_OFFSET[4][20:0]),
		.shift(shift[4:0]), 
//		.shift('{10'd4, 10'd3, 10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R5_xy_point_n)
	);*/

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
	
	logic [20:0] R6_xy_point_n [5:0] = '{{11'd435, 10'd300}, {11'd435, 10'd256}, {11'd435, 10'd212},
													 {11'd435, 10'd168}, {11'd435, 10'd124}, {11'd435, 10'd80}};
	
	/*rank_n_generator RNG_rank6 [5:0] (
		.rank_offset(RANK_XY_OFFSET[5][20:0]),
		.shift(shift[5:0]),
//		.shift('{10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0}),
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R6_xy_point_n)
	);*/

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
	
	logic [20:0] R7_xy_point_n [6:0] = '{{11'd472, 10'd322}, {11'd472, 10'd278}, {11'd472, 10'd234},
													 {11'd472, 10'd190}, {11'd472, 10'd146},
													 {11'd472, 10'd102}, {11'd472, 10'd58}};
	
/*	rank_n_generator RNG_rank7 [6:0] (
		.rank_offset(RANK_XY_OFFSET[6][20:0]),
		.shift(shift),
//		.shift('{10'd6,10'd5, 10'd4, 10'd3, 10'd2, 10'd1, 10'd0}), 
		.ydiag(10'd2*XYDIAG_DEMI[9:0]),
		.point_n(R7_xy_point_n)
	);*/

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

//------ Gestion des offsets pour les cubes------//
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
end




 	


logic [23:0] in_game_RGB;
logic [23:0] menu_RGB;
logic [1:0] RGB_state;


always_ff @(posedge CLK_33) begin	
	case (RGB_state)
	3'd0: begin
				if (p_imp_l1 || p_imp_l2 || p_imp_l3 || p_imp_l4) Qbert_RGB <= {8'd255,8'd0,8'd0};
				else if (p_touch_l1 || p_touch_l2 || p_touch_l3 || p_touch_l4) Qbert_RGB <= {8'd0,8'd0,8'd255};
				else Qbert_RGB <= menu_RGB;
				if (touch_enter) RGB_state <= 3'd1;
				if(e_start_qb|e_pause_qb) RGB_state <= 3'd2;
			end
	3'd1: begin	// ecran intro
				if (arcade) begin
					showArc <= 1'b1; showRun <= 1'b0;
				end
				else if (speed_run) begin
					showArc <= 1'b0; showRun <= 1'b1;
				end
					
				if (oREAD_SDRAM_EN) begin
					if (sub_arc) if (showArc) Qbert_RGB <= iREAD_DATA[23:0];
									 else Qbert_RGB <= 24'd0;
					else if (sub_run) if (showRun) Qbert_RGB <= iREAD_DATA[23:0];
											else Qbert_RGB <= 24'd0;
					else Qbert_RGB <= iREAD_DATA[23:0];
				end else Qbert_RGB <= {8'd255,8'd255,8'd0};
				if (sub_arcT) RGB_state <= 3'd2;
				else if (sub_runT) imgSD=!imgSD;
				if(gameover_qb) RGB_state <= 3'd3;
			end		
	3'd2: begin	
				Qbert_RGB <= in_game_RGB;
				if(e_menu_qb) RGB_state <= 3'd0;
				else if(gameover_qb) RGB_state <= 3'd3; 
			end
	3'd3:	begin
				Qbert_RGB <= {8'd0,8'd50,8'd100};
				if(e_menu_qb) RGB_state <= 3'd0;
				else if(e_start_qb) RGB_state <= 3'd2; 
			end
	endcase	
end

logic KO_serpent;
logic KO_fantome;
logic [3:0] KO_boule_rouge;
logic [3:0] KO_cochon;
logic freeze_power;
logic mode_arcade = 1'b0;
qbert_layer #(28) Beta (
// input
	.clk(CLK_33),
	.reset,
	.x_cnt,
	.y_cnt,
	.x_offset(e_XY0_qb[20:10]),
	.y_offset(e_XY0_qb[9:0]),
	.XLENGTH,
	.XDIAG_DEMI(XYDIAG_DEMI[20:10]),
	.YDIAG_DEMI(XYDIAG_DEMI[9:0]),
	
	.e_start_qb,
	.e_resume_qb,
	.e_pause_qb,
	.e_menu_qb,
	
	.e_jump_qb,
	.e_speed_qb,
//	.e_bad_jump,	
	.e_next_qb,
	
	.position_qb,
	.e_win_qb,
	.mode_arcade,
	
	.e_freeze_acc,
	.e_timer_freeze,
	
	.soucoupe_xy,
	.qb_on_sc,
	.done_move_sc,
	.e_tilt_acc,
	
	.e_piece,
	
	.KO_serpent,
	.KO_boule_rouge,
	.KO_cochon,
	.KO_fantome,
// output

	.qbert_hitbox(hb_qb),
	.LIFE_qb,
	
	.state_qb, 
	.game_qb,
	
	.freeze_power,
	
	.done_move_qb,
	.saucer_qb_state, // test pour determiner le state
	.mode_saucer, // indique aux autres modules que qbert
					// 
	.le_qbert,
	.qbert_xy
);
cube_generator #(28) rank [6:0](
// input  
	.clk(CLK_33),
	.reset,
	.done_move(done_move_qb),
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
/*
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
*/	
Menu_game intro(
	.clk(CLK_33),
	.reset,
	.x_cnt,
	.y_cnt,
	.JPulse(p_impulse),
	.menu_RGB
);

in_game_RGB testcool(
	.clk(CLK_33),
	.reset,
	.x_cnt,
	.y_cnt,
	
	.e_pause_qb,
	.e_start_qb,
	.e_resume_qb, 
	.le_qbert,
	.hb_qb,
	.top_face,
	.left_face,
	.right_face,
	.top_color,
	
	.in_game_RGB
);

endmodule

//-----------------------------------------------
module in_game_RGB(
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	
	input logic e_pause_qb,
	input logic e_start_qb,
	input logic e_resume_qb, 
	input logic le_qbert,
	input logic hb_qb,
	input logic [6:0] top_face,
	input logic [6:0] top_color,
	input logic [6:0] left_face,
	input logic [6:0] right_face,
//	input logic la_boule_rouge,
//	input logic [27:0] hb_top,
	
	output logic [23:0] in_game_RGB
); 

parameter logic [23:0] top_face_0_RGB = {8'd222,8'd222,8'd0};
parameter logic [23:0] left_face_0_RGB = {8'd86,8'd169,8'd152};
parameter logic [23:0] right_face_0_RGB = {8'd49,8'd70,8'd70};
parameter logic [23:0] top_color_0_RGB = {8'd86,8'd70,8'd239};
parameter logic [23:0] soucoupe_RGB = {8'd237,8'd28,8'd36};
parameter logic [23:0] qbert_RGB = {8'd216,8'd95,8'd2};
parameter logic [23:0] boule_rouge_RGB = {8'd220,8'd0,8'd0};
parameter logic [23:0] serpent_RGB = {8'd228,8'd0,8'd186};
parameter logic [23:0] background_0_RGB = {8'd0,8'd0,8'd0};

parameter logic [23:0] p_top_face_0_RGB = {8'd222,8'd222,8'd0};
parameter logic [23:0] p_left_face_0_RGB = {8'd136,8'd219,8'd202};
parameter logic [23:0] p_right_face_0_RGB = {8'd99,8'd120,8'd120};
parameter logic [23:0] p_top_color_0_RGB = {8'd86,8'd70,8'd239};
parameter logic [23:0] p_soucoupe_RGB = {8'd255,8'd78,8'd86};
parameter logic [23:0] p_qbert_RGB = {8'd255,8'd145,8'd52};
parameter logic [23:0] p_boule_rouge_RGB = {8'd255,8'd50,8'd50};
parameter logic [23:0] p_serpent_RGB = {8'd255,8'd50,8'd236};
parameter logic [23:0] p_background_0_RGB = {8'd50,8'd50,8'd50};

logic pause_play;
always_ff @(posedge clk) begin

case(pause_play) 

1'b0:	if(e_resume_qb|e_start_qb) pause_play <= 1'b1; 
		else begin 
			if(hb_qb & le_qbert) 
				in_game_RGB <= p_qbert_RGB;
//			else if(la_boule_rouge != 0)
//				in_game_RGB <= p_boule_rouge_RGB;
			else if(left_face !=0)
				in_game_RGB <= p_left_face_0_RGB;
			else if(right_face !=0)
				in_game_RGB <= p_right_face_0_RGB;
			else if( top_face !=0) begin				
				if (top_color) 
					in_game_RGB <= p_top_color_0_RGB;
				else in_game_RGB <= p_top_face_0_RGB;
			end 
			else 
				in_game_RGB <= p_background_0_RGB;
		end
		
1'b1:	if(e_pause_qb) pause_play <= 1'b0;
		else begin 
			if(hb_qb & le_qbert) 
				in_game_RGB <= qbert_RGB;
//			else if(la_boule_rouge != 0)
//				in_game_RGB <= boule_rouge_RGB;
			else if(left_face !=0)
				in_game_RGB <= p_left_face_0_RGB;
			else if(right_face !=0)
				in_game_RGB <= p_right_face_0_RGB;
			else if( top_face !=0) begin				
				if (top_color) 
					in_game_RGB <= p_top_color_0_RGB;
				else in_game_RGB <= p_top_face_0_RGB;
			end 
			else 
				in_game_RGB <= background_0_RGB;
		end
	endcase
end
	
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
