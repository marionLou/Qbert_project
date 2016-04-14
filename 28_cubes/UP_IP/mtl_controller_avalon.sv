

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
	input	wire	[7:0] iSPI,
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

logic [7:0] QBERT_GAME_red;
logic [7:0] QBERT_GAME_green;
logic [7:0] QBERT_GAME_blue;

// ===========================================================================
// AVALON interface
// ===========================================================================

reg [31:0] reg_readdata;

logic enable;

logic [4:0] A_enable = 5'd0;
logic [4:0] A_iSPI = 5'd1;


// ---- Cube definition ------------//
parameter k = 27; // nombre de cubes = k + 1 = 28
parameter i = 6; // nombre de rangées = k + 1 = 28

logic [10:0] XLENGTH;
logic [20:0] XYDIAG_DEMI;
logic [20:0] RANK1_XY_OFFSET;
logic [k:0]  nios_top_color;

logic [4:0] A_XLENGTH = 5'd2;
logic [4:0] A_XYDIAG_DEMI = 5'd3;
logic [4:0] A_RANK1_XY_OFFSET = 5'd4;
logic [4:0] A_nios_top_color = 5'd5;

// ---- Qbert definition -----------//

logic [20:0] QBERT_POSITION_XY0;
logic [20:0] QBERT_POSITION_XY1;
logic [2:0]	 qbert_jump;
logic nios_start_qbert;
logic bad_jump;
logic done_move; 	

logic [4:0] A_QBERT_POSITION_XY0 = 5'd6;
logic [4:0] A_QBERT_POSITION_XY1 = 5'd7;
logic [4:0] A_qbert_jump = 5'd8;
logic [4:0] A_nios_start_qbert = 5'd9;
logic [4:0] A_bad_jump = 5'd10;
logic [4:0] A_done_move = 4'd11;


// ---- READ & WRITE -----------//

always @ (posedge Avalon_CLK_50)
begin
	if (Avalon_reset) begin
		enable <= 1'd0;
		
		XLENGTH <= 11'd0;
		XYDIAG_DEMI <= 21'd0;
		RANK1_XY_OFFSET <= 21'd0;
		
		QBERT_POSITION_XY0 <= 21'd0;
		QBERT_POSITION_XY1 <= 21'd0;
		nios_top_color <= 6'd0;
		nios_start_qbert <= 1'd0;
		qbert_jump <= 3'd0;
		bad_jump <= 1'd0;
	end
	else begin 
		if (Avalon_write) begin 
			case(Avalon_address)
				A_enable : enable <= Avalon_writedata[0];
				
				A_XLENGTH : XLENGTH <= Avalon_writedata[10:0];
				A_XYDIAG_DEMI : XYDIAG_DEMI <= Avalon_writedata[20:0];
				A_RANK1_XY_OFFSET : RANK1_XY_OFFSET <= Avalon_writedata[20:0];
				A_nios_top_color : nios_top_color <= Avalon_writedata[k:0];
				
				A_QBERT_POSITION_XY0 : QBERT_POSITION_XY0 <= Avalon_writedata[20:0];
				A_QBERT_POSITION_XY1 : QBERT_POSITION_XY1 <= Avalon_writedata[20:0];
				A_qbert_jump : qbert_jump <= Avalon_writedata[2:0];
				A_nios_start_qbert : nios_start_qbert <= Avalon_writedata[0];
				A_bad_jump : bad_jump <= Avalon_writedata[0];
				
				default;
			endcase
		end

	 	if (Avalon_read) begin 
			case(Avalon_address)
				A_enable : reg_readdata <= {31'b0,enable};
				A_iSPI : reg_readdata <= {24'b0, iSPI};
				
				A_XLENGTH : reg_readdata <= {21'b0,XLENGTH};  
				A_XYDIAG_DEMI : reg_readdata <= {11'b0,XYDIAG_DEMI};
				A_RANK1_XY_OFFSET : reg_readdata <= {11'b0,RANK1_XY_OFFSET};
				
				
				A_QBERT_POSITION_XY0 : reg_readdata <= {11'b0,QBERT_POSITION_XY0};
				A_QBERT_POSITION_XY1 : reg_readdata <= {11'b0,QBERT_POSITION_XY1};
				A_nios_top_color : reg_readdata <= {26'b0,nios_top_color};
				A_qbert_jump : reg_readdata <= {29'b0,qbert_jump};
				A_done_move : reg_readdata <= {31'b0,done_move};

				default;
			endcase
		end				 
	end
end

assign Avalon_readdata = reg_readdata;


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
						read_red 	<= QBERT_GAME_red;
						read_green 	<= QBERT_GAME_green;
						read_blue 	<= QBERT_GAME_blue;
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

//=============================================================================
// QBERT GAME
//=============================================================================

Qbert_Map_Color #(.N_cube(k), .N_rank(i)) Beta(
	.CLK_33(iCLK),
	.reset(!iRST_n),

	
// --- Qbert position ------------//

	.bad_jump,
	.nios_start_qbert,
	.qbert_jump, 
	.QBERT_POSITION_XY0,
	.QBERT_POSITION_XY1,
	.done_move,

// --- Map parameters ------------//

	.XLENGTH,
	.XYDIAG_DEMI,
	.RANK1_XY_OFFSET,
	.nios_top_color,
	
// --- MTL parameters ------------//
	
	.x_cnt, 
	.y_cnt,
	.red(QBERT_GAME_red),
	.green(QBERT_GAME_green),
	.blue(QBERT_GAME_blue)
);


	
						
endmodule




