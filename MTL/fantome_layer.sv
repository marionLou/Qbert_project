/*
	couleur orange R = 216
						G = 95
						B = 2
						version : 01/04/16 21:16
	
*/
// position des cases se trouvant sur les bords droites et gauches
`define TOP 32'h00000001

`define R02 32'h00000002
`define R04 32'h00000008
`define R07 32'h00000040
`define R11 32'h00000400
`define R16 32'h00008000
`define R22 32'h00200000

`define L03 32'h00000004
`define L06 32'h00000020
`define L10 32'h00000200
`define L15 32'h00004000
`define L21 32'h00100000
`define L28 32'h08000000

`define C00 28'b0000000000000000000000000001
`define C01 28'b0000000000000000000000000010
`define C02 28'b0000000000000000000000000100
`define C03 28'b0000000000000000000000001000
`define C04 28'b0000000000000000000000010000
`define C05 28'b0000000000000000000000100000
`define C06 28'b0000000000000000000001000000
`define C07 28'b0000000000000000000010000000
`define C08 28'b0000000000000000000100000000
`define C09 28'b0000000000000000001000000000
`define C10 28'b0000000000000000010000000000
`define C11 28'b0000000000000000100000000000
`define C12 28'b0000000000000001000000000000
`define C13 28'b0000000000000010000000000000
`define C14 28'b0000000000000100000000000000
`define C15 28'b0000000000001000000000000000
`define C16 28'b0000000000010000000000000000
`define C17 28'b0000000000100000000000000000
`define C18 28'b0000000001000000000000000000
`define C19 28'b0000000010000000000000000000
`define C20 28'b0000000100000000000000000000
`define C21 28'b0000001000000000000000000000
`define C22 28'b0000010000000000000000000000
`define C23 28'b0000100000000000000000000000
`define C24 28'b0001000000000000000000000000
`define C25 28'b0010000000000000000000000000
`define C26 28'b0100000000000000000000000000
`define C27 28'b1000000000000000000000000000

`define J_DR 3'd1
`define J_DL 3'd2
`define J_UR 3'd3
`define J_UL 3'd4

module fantome_layer(

//------INPUT--------------------//	
	input logic clk,
	input logic reset,
	input logic [10:0] x_cnt,
	input logic [9:0] y_cnt,
	
	input logic [10:0] XDIAG_DEMI, XLENGTH,
	input logic [9:0] YDIAG_DEMI,
	
	input logic e_enable_ft, //  apparition de la boule mauve
	input logic [20:0] e_XY0_ft,
	
	input logic [31:0] e_speed_qb,
	input logic [27:0] position_qb,
	input logic [20:0] qbert_xy,
	
	input logic freeze_power,
	input logic qb_on_sc,
	
	input logic [20:0][27:0] r_xy_offset, 

//------OUTPUT-------------------//

	output logic [20:0] fantome_xy,  
	output logic fantome_hitbox,
	output logic [2:0] ft_state,
	output logic ft_end,
	output logic [10:0] sp_points,
	output logic [4:0] ft_mvt_cnt,
	output logic done_move_ft,
	output logic le_fantome

	);
	

logic [10:0] x0; 
logic [9:0]  y0; 
logic [10:0] XC;
logic [9:0] YC;

reg done_move_reg;

//--------- zone qbert----------


logic fantome_end;


logic [31:0] count = 32'b0;
logic [4:0] mvt_cnt = 5'b0; // compte le nbre de déplacement
logic [2:0] mvt_reg;
logic [31:0] df_speed = 32'd100000; 
logic [31:0] speed;
logic [10:0] shade_x_0;
logic [10:0] shade_x_1;
logic two_round;



typedef enum logic [2:0] {INIT, IDLE, TELEPORTATION , END} spstate_t;
spstate_t fantome_state;


always_ff @(posedge clk) begin

speed <= (e_speed_qb != 1'b0) ? e_speed_qb : df_speed;	


						case(fantome_state)
								INIT : 	begin 
											if(e_enable_ft) begin
												//{x0,y0} <= {e_XY0_ft[20:10] - (XLENGTH) + start_x, e_XY0_ft[9:0]};
												{XC,YC} <= {e_XY0_ft[20:10] - (XLENGTH) + start_x, e_XY0_ft[9:0] + YDIAG_DEMI};
												shade_x_0 <= 1'b0;
												shade_x_1 <= 1'b0;
												mvt_cnt <= 1'b0;
												fantome_end <= 1'b0;
												fantome_state <= IDLE;
												two_round <= 1'b0;
											end 
										end
								IDLE : 	begin
											if(!freeze_power) begin
												done_move_reg <= 1'b0;
												if(mvt_cnt == 2'd3 & !two_round) begin
													mvt_cnt <= 2'd0;
													two_round <= 1'b1;
												end	
												else if (mvt_cnt == 2'd3 & two_round)
													fantome_state <= END;
												else begin
													if( count[17] == 1'b1 ) begin
														count <= 1'b0;
														if (shade_x_0 < (XDIAG_DEMI+XLENGTH)) /// MODIFICATION
															shade_x_0 <= shade_x_0 + 11'd1;
														else begin
															count <= 32'b0;
															shade_x_1 <= 11'd0;
															fantome_state <= TELEPORTATION;
															case(mvt_cnt)
															`J_DR : 	{XC,YC} 	<= {x0 + XDIAG_DEMI + XLENGTH,y0};
															`J_DL : 	{XC,YC} 	<= {x0 + XDIAG_DEMI + XLENGTH,y0 + YDIAG_DEMI + YDIAG_DEMI};
															`J_UR : 	{XC,YC} 	<= {x0 - XDIAG_DEMI - XLENGTH,y0};
															`J_UL	:	{XC,YC}	<= {x0 - XDIAG_DEMI - XLENGTH,y0 + YDIAG_DEMI + YDIAG_DEMI};
															endcase
														end
													end
													else count <= count + 1'b1;	
												end
											end	
										end
								TELEPORTATION : 	begin
															if( count[17] == 1'b1 ) begin
																count <= 1'b0;
																if (shade_x_1 < (XDIAG_DEMI+XLENGTH)) /// MODIFICATION
																	shade_x_1 <= shade_x_1 + 11'd1;
																	else begin 
																		count <= 32'b0;
																		shade_x_0 <= 11'd0;
																		//shade_x_0 <= 11'd0;
																		mvt_cnt <= mvt_cnt + 1'b1; 
																		fantome_state <= IDLE;
																	end
															end
															else count <= count + 1'b1;
														end
								END : 	begin
											if( count[17] == 1'b1 ) begin
												count <= 1'b0;
												if (shade_x_0 < (XDIAG_DEMI+XLENGTH)) /// MODIFICATION
													shade_x_0 <= shade_x_0 + 11'd1;
												else begin
													count <= 32'b0;
													shade_x_0 <= 11'd0;
													fantome_end <= 1'b1;
													fantome_state <= INIT;
												end
											end
											else count <= count + 1'b1;
										end
						endcase

end	


//---------LeFantome------------------------//

logic tete,tronc;
logic [1:0] is_fantome;


always_ff @(posedge clk) begin
	

tete <= {(x_cnt <= XC - (XDIAG_DEMI>>1) && x_cnt >= XC - (XDIAG_DEMI))
			&&(y_cnt >= YC - (XDIAG_DEMI>>1) && y_cnt <= YC + (XDIAG_DEMI>>1) )};
			
tronc <= {(x_cnt >= XC - (XDIAG_DEMI>>1) && x_cnt <= XC + XDIAG_DEMI)
			&& (y_cnt >= YC - (YDIAG_DEMI>>1) && x_cnt <= YC + (YDIAG_DEMI>>1))};
			
is_fantome <= {tete,tronc};
fantome_hitbox <= {(x_cnt <= XC + XDIAG_DEMI && x_cnt >= XC - XDIAG_DEMI + shade_x_0 -shade_x_1)
							&& (y_cnt <= YC + XDIAG_DEMI && y_cnt >= YC - XDIAG_DEMI)};

end

assign ft_mvt_cnt = mvt_cnt;
assign ft_state = fantome_state;
assign ft_end = fantome_end;
assign done_move_ft = done_move_reg;	
assign le_fantome = (is_fantome !=2'b0);
assign fantome_xy = {XC,YC};

getposition Beta(
	.clk,
	.reset,
	.position_qb,
	.r_xy_offset,
	.x0,
	.y0
);

endmodule

module getposition(
	input logic clk,
	input logic reset,
	input logic [27:0] position_qb,
	input logic [20:0][27:0] r_xy_offset,
	output logic [10:0]  x0,
	output logic [9:0] y0
);

always_ff@(posedge clk)begin
	case(position_qb)
	`C00 :	{x0,y0} <= r_xy_offset[0];
	`C01 :	{x0,y0} <= r_xy_offset[1];
	`C02 :	{x0,y0} <= r_xy_offset[2];
	`C03 :	{x0,y0} <= r_xy_offset[3];
	`C04 :	{x0,y0} <= r_xy_offset[4];
	`C05 :	{x0,y0} <= r_xy_offset[5];
	`C06 :	{x0,y0} <= r_xy_offset[6];
	`C07 :	{x0,y0} <= r_xy_offset[7];
	`C08 :	{x0,y0} <= r_xy_offset[8];
	`C09 :	{x0,y0} <= r_xy_offset[9];
	`C10 :	{x0,y0} <= r_xy_offset[10];
	`C11 :	{x0,y0} <= r_xy_offset[11];
	`C12 :	{x0,y0} <= r_xy_offset[12];
	`C13 :	{x0,y0} <= r_xy_offset[13];
	`C14 :	{x0,y0} <= r_xy_offset[14];
	`C15 :	{x0,y0} <= r_xy_offset[15];
	`C16 :	{x0,y0} <= r_xy_offset[16];
	`C17 :	{x0,y0} <= r_xy_offset[17];
	`C18 :	{x0,y0} <= r_xy_offset[18];
	`C19 :	{x0,y0} <= r_xy_offset[19];
	`C20 :	{x0,y0} <= r_xy_offset[20];
	`C21 :	{x0,y0} <= r_xy_offset[21];
	`C22 :	{x0,y0} <= r_xy_offset[22];
	`C23 :	{x0,y0} <= r_xy_offset[23];
	`C24 :	{x0,y0} <= r_xy_offset[24];
	`C25 :	{x0,y0} <= r_xy_offset[25];
	`C26 :	{x0,y0} <= r_xy_offset[26];
	`C27 :	{x0,y0} <= r_xy_offset[27];
	endcase
end
endmodule
