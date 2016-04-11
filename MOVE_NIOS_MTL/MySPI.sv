
//=======================================================

module MySPI (
	input  logic		 theClock, theReset,
	input  logic       MySPI_clk, MySPI_cs, MySPI_sdi,
	output logic  		 MySPI_sdo,
	output logic [7:0] Config,
	input  logic [7:0] Status,
	output logic [7:0] Led70,
	output logic [7:0] Red,
	output logic [7:0] Green,
	output logic [7:0] Blue,
	output logic [7:0] ImgNum,
	output logic		 Trigger
);

//--- Registers Address ---------------------------------

parameter A_Config     			= 7'h00;
parameter A_Status     			= 7'h01;
parameter A_Led70      			= 7'h02;
parameter A_Red					= 7'h03;
parameter A_Green					= 7'h04;
parameter A_Blue					= 7'h05;
parameter A_ImgNum				= 7'h06;

//--- FSM States ----------------------------------------

typedef enum logic [3:0] {
	S_Wait, 
	S_Addr, S_Addr_00, S_Addr_01, S_Addr_11,
	S_Data, S_Data_00, S_Data_01, S_Data_11,
	S_End} statetype;

//--- Declarations --------------------------------------

statetype	SPI_state, SPI_nextstate;
logic			SPI_CLK0, SPI_CLK;
logic			SPI_CS0, SPI_CS;
logic [2:0] SPI_counter;
logic			SPI_counter_reset, SPI_counter_inc;	 
logic [7:0] SPI_address, SPI_data;
logic			SPI_address_shift;
logic			SPI_data_shift, SPI_data_load, SPI_data_update;

//--- SPI Output ----------------------------------------

assign MySPI_sdo = SPI_data[7];

//--- SPI Double Synchronization ------------------------

always @ (posedge theClock)
begin
	SPI_CLK0 <= MySPI_clk;	SPI_CLK  <= SPI_CLK0;
	SPI_CS0  <= MySPI_cs;	SPI_CS   <= SPI_CS0;
end


//--- SPI FSM -------------------------------------------

always_ff @ (posedge theClock)
	SPI_state <= SPI_nextstate;
	
always_comb
begin
	SPI_nextstate = SPI_state;
	case (SPI_state)
		S_Wait	 : if (SPI_CS) SPI_nextstate = S_Wait;
							else SPI_nextstate = S_Addr;
		S_Addr	 : SPI_nextstate = S_Addr_00;
		S_Addr_00 : if (SPI_CLK) SPI_nextstate = S_Addr_01;
		S_Addr_01 : SPI_nextstate = S_Addr_11;
		S_Addr_11 : if (SPI_CLK) SPI_nextstate = S_Addr_11;
							else if (SPI_counter == 3'b000) SPI_nextstate = S_Data;
								else SPI_nextstate = S_Addr_00;
		S_Data	 : SPI_nextstate = S_Data_00;
		S_Data_00 : if (SPI_CLK) SPI_nextstate = S_Data_01;
		S_Data_01 : SPI_nextstate = S_Data_11;
		S_Data_11 : if (SPI_CLK) SPI_nextstate = S_Data_11;
							else if (SPI_counter == 3'b000) SPI_nextstate = S_End;
								else SPI_nextstate = S_Data_00;
		S_End     : SPI_nextstate = S_Wait;
	endcase
	if (SPI_CS) SPI_nextstate = S_Wait;
end

assign SPI_counter_reset = ((SPI_state == S_Addr)    | (SPI_state == S_Data));
assign SPI_counter_inc   = ((SPI_state == S_Addr_01) | (SPI_state == S_Data_01));
assign SPI_address_shift = (SPI_state == S_Addr_01);
assign SPI_data_shift	 = (SPI_state == S_Data_01);
assign SPI_data_load		 = (SPI_state == S_Data);
assign SPI_data_update   = ((SPI_state == S_End) & SPI_address[7]);

//--- On the positive edge of the clock -----------------

always_ff @ (posedge theClock)
begin
	
	if (SPI_counter_reset) SPI_counter <= 3'b000;
		else if (SPI_counter_inc) SPI_counter <= SPI_counter + 3'b1;
		
	if (SPI_address_shift) SPI_address <= { SPI_address[6:0], MySPI_sdi };
	
	if (SPI_data_shift) SPI_data <= { SPI_data[6:0], MySPI_sdi };
		else if (SPI_data_load)
			case (SPI_address[6:0])
				A_Config    		: SPI_data <= Config;
				A_Status    		: SPI_data <= Status;
				A_Led70     		: SPI_data <= Led70;
			endcase
		
	if (theReset) begin
		Config <= 8'h00;
		Led70 <= 8'h00;
		Red  <= 8'h00;
		Green <= 8'h00;
		Blue <= 8'h00;
		ImgNum <= 8'h00;
	end else if ((SPI_data_update) & (SPI_address[6:0] == A_Blue)) begin
		Blue <= SPI_data;
		Trigger <= 1'b1;
	end else begin
		Trigger <= 1'b0;
		if ((SPI_data_update) & (SPI_address[6:0] == A_Config)) Config <= SPI_data; 
		else if ((SPI_data_update) & (SPI_address[6:0] == A_Led70))  Led70 <= SPI_data; 
		else if ((SPI_data_update) & (SPI_address[6:0] == A_Red)) Red <= SPI_data;
		else if ((SPI_data_update) & (SPI_address[6:0] == A_Green)) Green <= SPI_data;
		else if ((SPI_data_update) & (SPI_address[6:0] == A_ImgNum)) ImgNum <= SPI_data;
	end
	
end

endmodule

//=======================================================