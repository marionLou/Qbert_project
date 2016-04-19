
// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions of V2.0:	MTL controller adapted to a slideshow application
//										on the DE0-Nano board.
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            		:| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Fan					:| 07/06/30  :| Initial Revision
//	  V2.0 :| Charlotte Frenkel      :| 14/08/03  :| Improvements and adaptation to a
//																	 slideshow application on the DE0-Nano
// --------------------------------------------------------------------

module mtl_controller(
	// Host Side
	iCLK, 				// Input LCD control clock
	iRST_n, 				// Input system reset
	iLoading,			// Input signal telling in which loading state is the system
	oNewFrame,			// Output signal being a pulse when a new frame of the LCD begins
	oEndFrame,			// Output signal being a pulse when a frame of the LCD ends
	// SDRAM Side
	iREAD_DATA, 		// Input data from SDRAM (contains R, G and B colors)
	oREAD_SDRAM_EN,	// Output read SDRAM data control signal
	// LCD Side
	oHD,					// Output LCD horizontal sync 
	oVD,					// Output LCD vertical sync 
	oLCD_R,				// Output LCD red color data 
	oLCD_G,           // Output LCD green color data  
	oLCD_B,            // Output LCD blue color data  
	Time,
//	bg_img,
	x_touch,
	y_touch,
	pulse_touch
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

//===========================================================================
// PORT declarations
//===========================================================================

input				iCLK;   
input				iRST_n;
input				iLoading;
output			oNewFrame;
output			oEndFrame;
input	 [31:0]	iREAD_DATA;
output			oREAD_SDRAM_EN;
output			oHD;
output			oVD;
output [7:0]	oLCD_R;		
output [7:0]	oLCD_G;
output [7:0]	oLCD_B;
output [7:0]	Time;
//output [4:0]	bg_img;
input [9:0]		x_touch;
input [8:0]		y_touch;
input 			pulse_touch;

//=============================================================================
// REG/WIRE declarations
//=============================================================================

reg  [10:0] x_cnt;  
reg  [9:0]	y_cnt; 
wire [7:0]	read_red;
wire [7:0]	read_green;
wire [7:0]	read_blue; 
wire			display_area, display_area_prev;
wire		   q_rom;
wire [18:0] address;
reg			mhd;
reg			mvd;
reg			loading_buf;
reg			no_data_yet;

//logic [11:0] mem_0_addr, mem_1_addr, mem_8_addr;
//logic [15:0] q_mem_0, q_mem_1, q_mem_8;
logic color_change = 1'b1;
logic [10:0] heart_mem_addr;
logic [15:0] q_heart_mem;
logic [19:0] count_timer [4:0] = '{20'hFFFFFF, 20'hFFFFFF, 20'hFFFFFF, 20'hFFFFF, 20'hFFFFF};
logic [7:0] T_red, T_green, T_blue;
logic p_impulse;

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
Loading_ROM	Loading_ROM_inst (
	.address (address),
	.clock (iCLK),
	.q (q_rom),
	.rden (iLoading)
);

Menu_game intro_inst(
	.clk(iCLK),
	.reset(!iRST_n),
	.JPulse(p_impulse),
	.x_cnt,
	.y_cnt,
	
	.menu_RGB({T_red, T_green, T_blue})
);
	
heart_mem heart_inst (
	.address (heart_mem_addr),
	.clock (iCLK),
	.q (q_heart_mem)
	);
	
assign p_impulse = (x_touch>250 & x_touch<530 & y_touch>110 & y_touch<310) ? pulse_touch : 1'b0;

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

//assign mem_1_addr = display_area_prev ? (((x_cnt - 551)%35)*55 + (y_cnt - 351)%55) : 11'b0;

//assign mem_8_addr = display_area_prev ? ((x_cnt - 601)%50 + ((y_cnt - 351)%100)*50) : 12'b0;

/*assign heart_mem_addr = display_area_prev ? (((x_cnt - 101)%47)*40 + ((y_cnt - 101)%40)) : 11'b0;

assign disp_0 = (x_cnt>11'd100 & x_cnt<11'd148 &
					  y_cnt>10'd300 & y_cnt<10'd341);
assign disp_1 = (x_cnt>11'd100 & x_cnt<11'd148 &
					  y_cnt>10'd250 & y_cnt<10'd291);
assign disp_2 = (x_cnt>11'd100 & x_cnt<11'd148 &
					  y_cnt>10'd200 & y_cnt<10'd241);
assign disp_3 = (x_cnt>11'd100 & x_cnt<11'd148 &
					  y_cnt>10'd151 & y_cnt<10'd191);
assign disp_4 = (x_cnt>11'd100 & x_cnt<11'd148 &
					  y_cnt>10'd100 & y_cnt<10'd141);
					  
assign touch_loc = (x_touch>11'd100 & x_touch<11'd348 &
						  y_touch>10'd100 & y_touch<10'd250);

assign ct_0 = count_timer[0]>0;
assign ct_1 = count_timer[1]>0;
assign ct_2 = count_timer[2]>0;
assign ct_3 = count_timer[3]>0;
assign ct_4 = count_timer[4]>0;
assign opaque = (q_heart_mem[15:11]*8 + q_heart_mem[10:5]*4 + q_heart_mem[4:0]*8)<475;

assign  bloc_1 = (x_cnt>11'd295 & x_cnt<11'd370 & y_cnt>10'd190 & y_cnt<10'd335);
assign  bloc_2 = (x_cnt>11'd415 & x_cnt<11'd490 & y_cnt>10'd190 & y_cnt<10'd335);
assign  bloc_3 = (x_cnt>11'd535 & x_cnt<11'd610 & y_cnt>10'd190 & y_cnt<10'd335);

assign display_bg = (x_cnt<11'd100 | x_cnt>11'd800 |
							y_cnt<10'd80 | y_cnt>10'd450 );*/

// Assigns the right color data.
always_ff @(posedge iCLK) begin
	// If the screen is reset, put at zero the color signals.
	if (!iRST_n) begin
		read_red 	<= 8'b0;
		read_green 	<= 8'b0;
		read_blue 	<= 8'b0;
	// If we are in the active display area...
	end else if (display_area) begin
		/*if ((disp_0 | disp_1 | disp_2 | disp_3 | disp_4) & opaque) begin
			if (disp_4 & ct_4) begin
				count_timer[4] <= count_timer[4] - 20'b1;
				//if (pulse_touch) count_timer[4] <= 20'b0;
				read_red 	<= q_heart_mem[15:11]*8;
				read_green 	<= q_heart_mem[10:5]*4;
				read_blue 	<= q_heart_mem[4:0]*8;
				Time = 8'd50;
				//bg_img = 5'd1;
			end else if (disp_3 & ct_3) begin
				if (!ct_4) count_timer[3] <= count_timer[3] - 20'b1;
				//if (pulse_touch) count_timer[3] <= 20'b0;
				read_red 	<= q_heart_mem[15:11]*8;
				read_green 	<= q_heart_mem[10:5]*4;
				read_blue 	<= q_heart_mem[4:0]*8;
				Time = 8'd40;
				//bg_img = 5'd2;
			end else if (disp_2 & ct_2) begin
				if (!ct_4 & !ct_3) count_timer[2] <= count_timer[2] - 20'b1;
				//if (pulse_touch) count_timer[2] <= 20'b0;
				read_red 	<= q_heart_mem[15:11]*8;
				read_green 	<= q_heart_mem[10:5]*4;
				read_blue 	<= q_heart_mem[4:0]*8;
				Time = 8'd30;
				//bg_img = 5'd3;
			end else if (disp_1 & ct_1) begin
				if (!ct_4 & !ct_3 & !ct_2) count_timer[1] <= count_timer[1] - 20'b1;
				//if (pulse_touch & touch_loc) count_timer[1] <= 20'b0;
				read_red 	<= q_heart_mem[15:11]*8;
				read_green 	<= q_heart_mem[10:5]*4;
				read_blue 	<= q_heart_mem[4:0]*8;
				Time = 8'd20;
				//bg_img = 5'd4;
			end else if (disp_0 & ct_0) begin
				if (!ct_4 & !ct_3 & !ct_2 & !ct_1) count_timer[0] <= count_timer[0] - 20'b1;
				//if (pulse_touch & touch_loc) count_timer[0] <= 20'b0;
				read_red 	<= q_heart_mem[15:11]*8;
				read_green 	<= q_heart_mem[10:5]*4;
				read_blue 	<= q_heart_mem[4:0]*8;
				Time = 8'd10;
				//bg_img = 5'd5;
			end else begin
				read_red 	<= 8'd0;
				read_green 	<= 8'd255;
				read_blue 	<= 8'd0;
			end
		end
		else if (display_bg | bloc_1 | bloc_2 | bloc_3) begin
			//if (oREAD_SDRAM_EN) begin
				read_red 	<= iREAD_DATA[23:16];
				read_green 	<= iREAD_DATA[15:8];
				read_blue 	<= iREAD_DATA[7:0];
			end
			else begin
				read_red 	<= 8'd255;
				read_green 	<= 8'd255;
				read_blue 	<= 8'd0;
			end
		end*/	
		// ...and if no data has been sent yet by the PIC32,
		// then display a white screen.
		if (no_data_yet) begin
			read_red 	<= T_red;
			read_green 	<= T_green;
			read_blue 	<= T_blue;
		end
		// ...and if the slideshow is currently loading,
		// then display the loading screen.
		// The current pixel is black (resp. white)
		// if a 1 (resp. 0) is written in the ROM.
		/*nd else if (loading_buf) begin
			if(q_rom) begin
				read_red 	<= 8'd0;
				read_green 	<= 8'd0;
				read_blue 	<= 8'd255;
			end else begin
				read_red 	<= 8'd255;
				read_green 	<= 8'd0;
				read_blue 	<= 8'd0;
			end
		// ...and if the slideshow has been loaded,
		// then display the values read from the SDRAM.
		end*/
		/*else begin
			read_red 	<= iREAD_DATA[23:16];
			read_green 	<= iREAD_DATA[15:8];
			read_blue 	<= iREAD_DATA[7:0];
		end*/
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




