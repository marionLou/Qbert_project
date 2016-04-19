

// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            		:| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Fan					:| 07/06/30  :| Initial Revision
//	  V2.0 :| Charlotte Frenkel      :| 14/08/03  :| Improvements and adaptation to a
//																	 slideshow application on the DE0-Nano
// V3.0 :| Fokou stephane & Marion Louis : 01/04/2016 :Adding Avalon interface
// --------------------------------------------------------------------

module mtl_controller_avalon(
	// Avalon side
	input  wire        Avalon_CLK_50,     //   clock_sink.clk
	input  wire        Avalon_reset,      //   reset_sink.reset
	input  wire [7:0]  Avalon_address,    // avalon_slave.address
	input  wire        Avalon_read,       //             .read
	output wire [31:0] Avalon_readdata,  //             .readdata
	input  wire        Avalon_write,      //             .write
	input  wire [31:0] Avalon_writedata, //             .writedata
	
	// SPI Side
	input	wire	[7:0] iSPI_game_status,
	input	wire	[7:0]	iSPI_jump,
	input	wire	[7:0]	iSPI_acc,
	// Host Side
	input wire		  iCLK, 				// Input LCD control clock
	input wire        iRST_n, 				// Input system reset
	input	wire		  iLoading,			// Input signal telling in which loading state is the system
	output	wire		  oNewFrame,			// Output signal being a pulse when a new frame of the LCD begins
	output	wire		  oEndFrame,			// Output signal being a pulse when a frame of the LCD ends
	// SDRAM Side
	input	 wire [31:0]	  iREAD_DATA, 		// Input data from SDRAM (contains R, G and B colors)
	output	wire		  oREAD_SDRAM_EN,	// Output read SDRAM data control signal
	// LCD Side
	output	wire		  oHD,					// Output LCD horizontal sync 
	output	wire		  oVD,					// Output LCD vertical sync 
	output wire [7:0]	  oLCD_R,				// Output LCD red color data 
	output wire [7:0]	  oLCD_G,           // Output LCD green color data  
	output wire [7:0]	  oLCD_B            // Output LCD blue color data  
);
						
//============================================================================
// PARAMETER declarations
//============================================================================

// All these parameters are given in the MTL datasheet, section 3.2,
// available in the project file folder
parameter H_LINE = 1056; 
parameter V_LINE = 525;
parameter Horizontal_Blank = 46;          //H_SYNC + H_Back_Porch
parameter Horizontal_Front_Porch = 210;
parameter Vertical_Blank = 23;      	   //V_SYNC + V_BACK_PORCH
parameter Vertical_Front_Porch = 22;


//=============================================================================
// REG/WIRE declarations
//=============================================================================

reg  [10:0] x_cnt;  
reg  [9:0]	y_cnt; 
wire [7:0]	read_red;
wire [7:0]	read_green;
wire [7:0]	read_blue; 
wire		display_area, display_area_prev;
wire		q_rom;
wire [18:0] address;
reg			mhd;
reg			mvd;
reg			loading_buf;
reg			no_data_yet;

// -- QBERT signals ----------------//

logic [7:0] QG_red;
logic [7:0] QG_green;
logic [7:0] QG_blue;

// ===========================================================================
// AVALON interface
// ===========================================================================

reg [31:0] reg_readdata;

logic enable;


// ---- Cube definition ------------//
parameter k = 28; // nombre de cubes
parameter i = 7; // nombre de rangées

logic [10:0] XLENGTH;
logic [20:0] XYDIAG_DEMI;
logic [20:0] RANK1_XY_OFFSET;
logic [27:0]  e_color_state;

// ---- Qbert definition -----------//

logic [20:0] e_XY0_qb;
logic [2:0]	 e_jump_qb;
logic [27:0] e_next_qb;
logic [27:0] position_qb;
logic [31:0] e_speed_qb;

logic e_start_qb;
logic e_pause_qb;
logic e_resume_qb;
logic e_menu_qb;
logic e_win_qb;
logic e_bad_jump;
logic done_move_qb; 
logic [3:0] LIFE_qb;
logic [2:0] state_qb;
logic [2:0] game_qb;
logic [1:0] saucer_qb_state;	

// ---- Soucoupe definition -----------//

logic [20:0] e_XY0_sc;
logic [1:0] state_sc;
logic done_move_sc;
logic qb_on_sc;
logic [1:0] e_tilt_acc;
logic [20:0] soucoupe_xy;

// ---Freeze Power definition --------//
	
logic e_freeze_acc; // NIOS
logic e_timer_freeze;

// --Gameover definition ------------//
logic [6:0] coin;
logic e_piece;

// -- ADDRESS-------------------//

typedef enum logic [5:0] 
{	A_enable,  // 0
	A_iSPI_game_status, // 4 
	A_iSPI_jump, // 8
	A_iSPI_acc, // 12 
	A_XLENGTH, // 16
	A_XYDIAG_DEMI, // 20
	A_RANK1_XY_OFFSET, // 24
	A_e_color_state, // 28
	A_e_XY0_qb, // 32
	A_e_jump_qb, // 36
	A_e_next_qb, // 40
	A_position_qb, // 44
	A_e_start_qb, // 48 
	A_e_resume_qb, // 52
	A_e_pause_qb, // 56
	A_e_menu_qb, // 60
	A_e_bad_jump, // 64
	A_LIFE_qb, // 68
	A_done_move_qb, // 72 
	A_state_qb,	// 76 
	A_game_qb, // 80  
	A_e_speed_qb, // 84 
	A_e_XY0_sc, // 88
	A_state_sc, // 92 
	A_done_move_sc, // 96 
	A_qb_on_sc, // 100 
	A_e_tilt_acc, // 104 
	A_saucer_qb_state, // 108 
	A_soucoupe_xy, // 112 
	A_e_freeze_acc, // 116
	A_e_timer_freeze, // 118
	A_e_win_qb, //  122
	A_coin // 124
	} 
A_register;

A_register nios_address;


// ---- READ & WRITE -----------//

always @ (posedge Avalon_CLK_50)
begin
	//A_register <= Avalon_address;
	if (Avalon_reset) begin
		enable <= 1'd0;
		
		XLENGTH <= 11'd0;
		XYDIAG_DEMI <= 21'd0;
		RANK1_XY_OFFSET <= 21'd0;
		e_color_state <= 6'd0;
		
		e_XY0_qb <= 21'd0;
		e_start_qb <= 1'd0;
		e_pause_qb <= 1'd0;
		e_jump_qb <= 3'd0;
		e_bad_jump <= 1'd0;
		e_next_qb <= 1'd0;
		e_resume_qb <= 1'b0;
		
		e_XY0_sc <= 21'd0;
		e_tilt_acc <= 1'b0;
		
		e_freeze_acc <= 1'b0;
		e_timer_freeze <= 32'd0;
	end
	else begin 
		if (Avalon_write) begin 
			case(Avalon_address)
				A_enable : enable <= Avalon_writedata[0];
				
				A_XLENGTH : XLENGTH <= Avalon_writedata[10:0];
				A_XYDIAG_DEMI : XYDIAG_DEMI <= Avalon_writedata[20:0];
				A_RANK1_XY_OFFSET : RANK1_XY_OFFSET <= Avalon_writedata[20:0];
				A_e_color_state : e_color_state <= Avalon_writedata[27:0];
				
				A_e_XY0_qb : e_XY0_qb <= Avalon_writedata[20:0];
				A_e_jump_qb : e_jump_qb <= Avalon_writedata[2:0];
				A_e_next_qb : e_next_qb <= Avalon_writedata[27:0];
				A_e_start_qb : e_start_qb <= Avalon_writedata[0];
				A_e_resume_qb : e_resume_qb <= Avalon_writedata[0];
				A_e_pause_qb : e_pause_qb <= Avalon_writedata[0];
				A_e_menu_qb : e_menu_qb <= Avalon_writedata[0];
				A_e_bad_jump : e_bad_jump <= Avalon_writedata[0];
				A_e_speed_qb : e_speed_qb <= Avalon_writedata;
				
				A_e_XY0_sc : e_XY0_sc <= Avalon_writedata[20:0];
				A_e_tilt_acc : e_tilt_acc <= Avalon_writedata[1:0];
				
				A_e_freeze_acc : e_freeze_acc <= Avalon_writedata[0];
				A_e_timer_freeze : e_timer_freeze <= Avalon_writedata;
				default;
			endcase
		end

	 	if (Avalon_read) begin 
			case(Avalon_address)
				A_enable : reg_readdata <= enable;
				A_iSPI_game_status : reg_readdata <= iSPI_game_status;
				A_iSPI_jump : reg_readdata <= iSPI_jump;
				A_iSPI_acc : reg_readdata <= iSPI_acc;
				
				A_position_qb : reg_readdata <= position_qb;
				A_LIFE_qb : reg_readdata <= LIFE_qb;
				A_done_move_qb : reg_readdata <= done_move_qb;
				A_state_qb : reg_readdata <= state_qb;
				A_game_qb : reg_readdata <= game_qb;
				A_saucer_qb_state : reg_readdata <= saucer_qb_state;
				
			
				A_state_sc : reg_readdata <= state_sc;
				A_done_move_sc : reg_readdata <= done_move_sc;
				A_qb_on_sc : reg_readdata <= qb_on_sc;
				A_soucoupe_xy : reg_readdata <= soucoupe_xy;
				
				A_XLENGTH : reg_readdata <= XLENGTH;
				A_XYDIAG_DEMI : reg_readdata <= XYDIAG_DEMI;
				A_RANK1_XY_OFFSET : reg_readdata <= RANK1_XY_OFFSET;
				A_e_color_state : reg_readdata <= e_color_state;
				
				A_e_XY0_qb : reg_readdata <= e_XY0_qb;
				A_e_jump_qb : reg_readdata <= e_jump_qb;
				A_e_next_qb : reg_readdata <= e_next_qb;
				A_e_start_qb : reg_readdata <= e_start_qb;
				A_e_resume_qb : reg_readdata <= e_resume_qb;
				A_e_pause_qb : reg_readdata <= e_pause_qb;
				A_e_menu_qb : reg_readdata <= e_menu_qb;
				A_e_bad_jump : reg_readdata <= e_bad_jump;
				A_e_speed_qb : reg_readdata <= e_speed_qb;
				
				A_e_XY0_sc : reg_readdata <= e_XY0_sc;
				A_e_tilt_acc : reg_readdata <= e_tilt_acc;
				
				A_e_freeze_acc : reg_readdata <= e_freeze_acc;
				A_e_timer_freeze : reg_readdata <= e_timer_freeze;
				default;
			endcase
		end				 
	end
end

assign Avalon_readdata = reg_readdata;

//=============================================================================
// QBERT GAME
//=============================================================================

Qbert_Map_Color #(.N_cube(k), .N_rank(i)) Beta(
	.CLK_33(iCLK),
	.reset(!iRST_n),

	
// --- Qbert position ------------//

	.e_bad_jump,
	.e_start_qb,
	.e_resume_qb,
	.e_pause_qb,
	.e_jump_qb,
	.e_speed_qb,	
	.e_XY0_qb,
	.position_qb,
	.e_next_qb,
	.done_move_qb,
	.LIFE_qb,
	.state_qb, 
	.game_qb,
	.saucer_qb_state,
	
// ---- Soucoupe definition -----------//

	.e_XY0_sc,
	.state_sc,
	.done_move_sc,
	.qb_on_sc,
	.e_tilt_acc,
	.soucoupe_xy,
	
// ---- Freeze definition --------//

	.e_freeze_acc, // NIOS
	.e_timer_freeze,
	
// --- Arcade definition -------//
	.coin,
	.e_piece,
// --- Map parameters ------------//

	.XLENGTH,
	.XYDIAG_DEMI,
	.RANK1_XY_OFFSET,
	.e_color_state,
	
// --- MTL parameters ------------//
	
	.x_cnt, 
	.y_cnt,
	.Qbert_RGB({QG_red,QG_blue,QG_green})
);


//=============================================================================
// Structural coding
//=============================================================================


//--- Assigning the right color data as a function -------------------------
//--- of the current pixel position ----------------------------------------

// This loading ROM contains B/W data to display the loading screen.
// The data is available in the rom.mif file in the project folder.
// Note that it is just a gadget for the demonstration, it is not efficient!
// Indeed, it must contain 1bit x 800 x 480 = 384000 bits of data,
// which is more than 60% of the total memory bits of the FPGA.
// Don't hesitate to suppress it.

/*
Loading_ROM	Loading_ROM_inst (
	.address (address),
	.clock (iCLK),
	.q (q_rom),
	.rden (iLoading)
);
*/

// This signal controls read requests to the SDRAM.
// When asserted, new data becomes available in iREAD_DATA
// at each clock cycle.
assign	oREAD_SDRAM_EN = (~loading_buf && display_area_prev);
						
// This signal indicates the LCD active display area shifted back from
// 1 pixel in the x direction. This accounts for the 1-cycle delay
// in the sequential logic.
assign	display_area = ((x_cnt>(Horizontal_Blank-2)&&
						(x_cnt<(H_LINE-Horizontal_Front_Porch-1))&&
						(y_cnt>(Vertical_Blank-1))&& 
						(y_cnt<(V_LINE-Vertical_Front_Porch))));

// This signal indicates the same LCD active display area, now shifted
// back from 2 pixels in the x direction, again for sequential delays.
assign	display_area_prev =	((x_cnt>(Horizontal_Blank-3)&&
						(x_cnt<(H_LINE-Horizontal_Front_Porch-2))&&
						(y_cnt>(Vertical_Blank-1))&& 
						(y_cnt<(V_LINE-Vertical_Front_Porch))));	
						
// This signal updates the ROM address to read from based on the current pixel position.
assign address = display_area_prev ? ((x_cnt-(Horizontal_Blank-2)) + (y_cnt-Vertical_Blank)*800) : 19'b0;


// Assigns the right color data.
always_ff @(posedge iCLK) begin
	// If the screen is reset, put at zero the color signals.
	if (!iRST_n) begin
		read_red 	<= 8'b0;
		read_green 	<= 8'b0;
		read_blue 	<= 8'b0;
	// If we are in the active display area...
	end else if (display_area) begin
		// ...and if no data has been sent yet by the PIC32,
		// then display a white screen.
		
//000000000000000000000000000000000000000000000000000000000//				
//*****BEGIN********** QBERT COLOR GAME *********BEGIN*****// 
//000000000000000000000000000000000000000000000000000000000//	
		if (no_data_yet) begin
					if (enable) begin
						read_red 	<= QG_red;
						read_green 	<= QG_green;
						read_blue 	<= QG_blue;
					end 
					else begin
						read_red 	<= 8'd199;
						read_green 	<= 8'd65;
						read_blue 	<= 8'd175;
					end
		end				
//000000000000000000000000000000000000000000000000000000000//						
//*****END************* QBERT COLOR GAME ********END*******//
//000000000000000000000000000000000000000000000000000000000//
	
		// ...and if the slideshow is currently loading,
		// then display the loading screen.
		// The current pixel is black (resp. white)
		// if a 1 (resp. 0) is written in the ROM.
		else if (loading_buf) begin
			if(q_rom) begin
				read_red 	<= 8'b0;
				read_green 	<= 8'b0;
				read_blue 	<= 8'b0;
			end else begin
				read_red 	<= 8'd255;
				read_green 	<= 8'd255;
				read_blue 	<= 8'd255;
			end
		// ...and if the slideshow has been loaded,
		// then display the values read from the SDRAM.
		end else begin
			read_red 	<= iREAD_DATA[23:16];
			read_green 	<= iREAD_DATA[15:8];
			read_blue 	<= iREAD_DATA[7:0];
		end
	// If we aren't in the active display area, put at zero
	// the color signals.
	end else begin
		read_red 	<= 8'b0;
		read_green 	<= 8'b0;
		read_blue 	<= 8'b0;
	end
end


//--- Keeping track of x and y positions of the current pixel ------------------
//--- and generating the horiz. and vert. sync. signals ------------------------

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
	begin
		x_cnt <= 11'd0;	
		mhd  <= 1'd0;  
	end	
	else if (x_cnt == (H_LINE-1))
	begin
		x_cnt <= 11'd0;
		mhd  <= 1'd0;
	end	   
	else
	begin
		x_cnt <= x_cnt + 11'd1;
		mhd  <= 1'd1;
	end	
end

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
		y_cnt <= 10'd0;
	else if (x_cnt == (H_LINE-1))
	begin
		if (y_cnt == (V_LINE-1))
			y_cnt <= 10'd0;
		else
			y_cnt <= y_cnt + 10'd1;	
	end
end

always@(posedge iCLK  or negedge iRST_n) begin
	if (!iRST_n)
		mvd  <= 1'b1;
	else if (y_cnt == 10'd0)
		mvd  <= 1'b0;
	else
		mvd  <= 1'b1;
end	

assign oNewFrame = ((x_cnt == 11'd0)   && (y_cnt == 10'd0)  );	
assign oEndFrame = ((x_cnt == 11'd846) && (y_cnt == 10'd503));	
	
	
//--- Retrieving the current loading state based on the iLoading signal --------
	
// - When iLoading is initially at 0, the PIC32 has not sent anything yet, the 
//   no_data_yet and loading_buf signals are at 1 and a white screen is displayed.
// - When iLoading rises to 1, the slideshow is currently loading and no_data_yet
//   falls at zero: the loading screen is displayed.
// - When iLoading falls back to 0, the loading_buf signal falls at zero at the
//   beginning of the next frame. The SDRAM data is then displayed.
always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n) begin
		no_data_yet <= 1'b1;
		loading_buf <= 1'b1;
	end else if (!iLoading && oNewFrame && !no_data_yet) 
		loading_buf <= 1'b0;
	else if (iLoading)
		no_data_yet <= 1'b0;
end	
	

//--- Assigning synchronously the color and sync. signals ------------------

always@(posedge iCLK or negedge iRST_n) begin
	if (!iRST_n)
		begin
			oHD	<= 1'd0;
			oVD	<= 1'd0;
			oLCD_R <= 8'd0;
			oLCD_G <= 8'd0;
			oLCD_B <= 8'd0;
		end
	else
		begin
			oHD	<= mhd;
			oVD	<= mvd;
			oLCD_R <= read_red;
			oLCD_G <= read_green;
			oLCD_B <= read_blue;
		end		
end




	
						
endmodule




