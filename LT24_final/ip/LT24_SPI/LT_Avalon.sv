// LT24_PIC32.v

// This file was auto-generated as a prototype implementation of a module
// created in component editor.  It ties off all outputs to ground and
// ignores all inputs.  It needs to be edited to make it do something
// useful.
// 
// This file will not be automatically regenerated.  You should check it in
// to your version control system if you want to keep it.

`timescale 1 ps / 1 ps
module LT_Avalon (
		input  wire [31:0] write_data, //     avalon_slave.writedata
		output wire [31:0] read_data,  //                 .readdata
		input  wire        write,      //                 .chipselect
		input  wire        read,       //                 .read
		input  wire [7:0]  address,    //                 .address
		input  wire        SPI_CS,     //         LT24_SPI.cs
		input  wire        SPI_SDI,    //                 .sdi
		output wire        SPI_SDO,    //                 .sdo
		input  wire        SPI_SCLK,   //                 .sclk
		input  wire        clk,        //              clk.clk
		input  wire        reset,      //            reset.reset
		output wire        SPI_INT,    // interrupt_sender.irq
		output wire        IRQ_PTC     // interrupt_sender.irq
	);

	// TODO: Auto-generated HDL template
	
	//=======================================================
//  REG/WIRE declarations
//=======================================================

parameter Data_0  = 8'd0;
parameter Data_1  = 8'd1;
parameter Data_2  = 8'd2;
parameter Data_3  = 8'd3;


logic [7:0] Data_ToPic;
logic [7:0] Data_ToCyclo;

logic irqCS = 1'b0;
logic preCS = 1'b1;
logic [7:0] delay_CS;
		
always @ (posedge clk)
begin
	if (reset) begin
		Data_ToPic <= 8'b0;
//		Data_Out <= 8'b0;
	end
	else begin 
		if (write) begin 
			case(address)
				Data_0: Data_ToPic <= write_data[7:0];
				default;
			endcase
		end

	 	if (read) begin 
			case(address)
				Data_0: read_data <= Data_ToPic; //(Data_In != 0)?Data_In:8'd237
				Data_1: read_data <= Data_ToCyclo;
				Data_2: read_data <= irqCS;
				Data_3: read_data <= delay_CS;
				default;
			endcase
		end				 
	end
end

// Interrupt from Pic to Cyclo
always @(posedge clk)
begin
	if(!preCS & SPI_CS) begin
		irqCS <= 1'b1;
		preCS <= SPI_CS;
		delay_CS <= 8'b0;
	end
	else if(irqCS & delay_CS < 8'b00111111) begin
		delay_CS <= delay_CS + 8'b1;
		preCS <= SPI_CS;
	end
	else  begin
		preCS <= SPI_CS;
		irqCS <= 1'b0;
		delay_CS <= 8'b1;
	end	
end


MySPI surf (
		.theClock (clk), 
		.theReset (reset), 
		.MySPI_clk (SPI_SCLK), 
		.MySPI_cs (SPI_CS), 
		.MySPI_sdi (SPI_SDI), 
		.MySPI_sdo (SPI_SDO),  
		.Data_ToPic (Data_ToPic), 
		.Data_ToCyclo (Data_ToCyclo)
		);
		
assign SPI_INT = write;
assign IRQ_PTC = irqCS;

endmodule
