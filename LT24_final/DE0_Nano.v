
module DE0_Nano(

	//////////// CLOCK //////////
	CLOCK_50,

	//////////// LED //////////
	LED,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SDRAM //////////
	DRAM_ADDR,
	DRAM_BA,
	DRAM_CAS_N,
	DRAM_CKE,
	DRAM_CLK,
	DRAM_CS_N,
	DRAM_DQ,
	DRAM_DQM,
	DRAM_RAS_N,
	DRAM_WE_N,
	
	//////////// ECPS //////////
	EPCS_ASDO,
	EPCS_DATA0,
	EPCS_DCLK,
	EPCS_NCSO,

	//////////// Accelerometer and EEPROM //////////
	G_SENSOR_CS_N,
	G_SENSOR_INT,
	I2C_SCLK,
	I2C_SDAT,

	//////////// ADC //////////
	ADC_CS_N,
	ADC_SADDR,
	ADC_SCLK,
	ADC_SDAT,

	//////////// 2x13 GPIO Header //////////
	GPIO_2,
	GPIO_2_IN,

	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO_0,
	GPIO_0_IN,
	
	//////////////  LCD LT24 to GPIO1 ////////////////
	LT24_ADC_BUSY,
	LT24_ADC_CS_N,
	LT24_ADC_DCLK,
	LT24_ADC_DIN,
	LT24_ADC_DOUT,
	LT24_ADC_PENIRQ_N,
	LT24_D,
	LT24_WR_N,
	LT24_RD_N,
	LT24_CS_N,
	LT24_RESET_N,
	LT24_RS,
	LT24_LCD_ON
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;

//////////// LED //////////
output		     [7:0]		LED;

//////////// KEY //////////
input 		     [1:0]		KEY;

//////////// SW //////////
input 		     [3:0]		SW;

//////////// SDRAM //////////
output		    [12:0]		DRAM_ADDR;
output		     [1:0]		DRAM_BA;
output		          		DRAM_CAS_N;
output		          		DRAM_CKE;
output		          		DRAM_CLK;
output		          		DRAM_CS_N;
inout 		    [15:0]		DRAM_DQ;
output		     [1:0]		DRAM_DQM;
output		          		DRAM_RAS_N;
output		          		DRAM_WE_N;

//////////// EPCS //////////
output		          		EPCS_ASDO;
input 		          		EPCS_DATA0;
output		          		EPCS_DCLK;
output		          		EPCS_NCSO;

//////////// Accelerometer and EEPROM //////////
output		          		G_SENSOR_CS_N;
input 		          		G_SENSOR_INT;
output							I2C_SCLK;
inout 		          		I2C_SDAT;

//////////// ADC //////////
output		          		ADC_CS_N;
output		          		ADC_SADDR;
output		          		ADC_SCLK;
input 		          		ADC_SDAT;

//////////// 2x13 GPIO Header //////////
inout 		    [12:0]		GPIO_2;
input 		     [2:0]		GPIO_2_IN;

//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
output 		    [33:0]		GPIO_0;
input 		     [1:0]		GPIO_0_IN;

//////////// GPIO_1 to LT24 //////////
output		          		LT24_ADC_CS_N;
output		          		LT24_ADC_DCLK;
output		          		LT24_ADC_DIN;
input		          		   LT24_ADC_BUSY;
input		          		   LT24_ADC_DOUT;
input		          		   LT24_ADC_PENIRQ_N;
output		    [15:0]		LT24_D;
output		          		LT24_WR_N;
output		          		LT24_RD_N;
output		         		LT24_CS_N;
output		         		LT24_RESET_N;
output		         		LT24_RS;
output		         		LT24_LCD_ON;

wire		          			LT24_ADC_CS_N_bus;
wire		          			LT24_ADC_DCLK_bus;
wire		          			LT24_ADC_DIN_bus;
wire		          			LT24_ADC_BUSY_bus;
wire	          		   	LT24_ADC_DOUT_bus;
wire	          		   	LT24_ADC_PENIRQ_N_bus;
wire		    	[15:0]		LT24_D_bus;
wire		          			LT24_WR_N_bus;
wire		          			LT24_RD_N_bus;
wire		         			LT24_CS_N_bus;
wire		         			LT24_RESET_N_bus;
wire		         			LT24_RS_bus;
wire  	         			LT24_LCD_ON_bus;


wire [11:0] pic_mem_s2_address;
wire        pic_mem_s2_chipselect; 
wire        pic_mem_s2_clken;     
wire        pic_mem_s2_write;          
wire [15:0] pic_mem_s2_readdata;    
wire [15:0] pic_mem_s2_writedata;           
wire [1:0]  pic_mem_s2_byteenable;

wire [12:0] background_mem_s2_address;                   
wire        background_mem_s2_chipselect;               
wire        background_mem_s2_clken;                     
wire        background_mem_s2_write;                    
wire [15:0] background_mem_s2_readdata;                 
wire [15:0] background_mem_s2_writedata;                
wire [1:0]  background_mem_s2_byteenable; 

wire 			lt24_buffer_flag;           

//=======================================================
//  REG/WIRE declarations
//=======================================================

wire RST_N;

wire 	Avalon_CS;
wire 	Avalon_SDI;
wire 	Avalon_SDO;
wire 	Avalon_SCK;
wire 	Avalon_SINT;

//=======================================================
//  Structural coding
//=======================================================

assign Avalon_SCK = GPIO_2[2];
assign Avalon_CS  = GPIO_2[3];
assign Avalon_SDO = GPIO_2[0];
assign GPIO_2[1] = Avalon_CS ? 1'bz : Avalon_SDI;
assign GPIO_2[5] = Avalon_SINT;

assign RST_N       = KEY[1];
assign LT24_LCD_ON = 1'b1; //default on

DE0_LT24_SOPC DE0_LT24_SOPC_inst(
		.clk_clk(CLOCK_50),          							//        clk.clk
		.reset_reset_n(RST_N),    								//      reset.reset_n
		
		// SDRAM
		.sdram_wire_addr(DRAM_ADDR),  						// sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),    							//           .ba
		.sdram_wire_cas_n(DRAM_CAS_N), 						//           .cas_n
		.sdram_wire_cke(DRAM_CKE),  							//           .cke
		.sdram_wire_cs_n(DRAM_CS_N),  						//           .cs_n
		.sdram_wire_dq(DRAM_DQ),    							//           .dq
		.sdram_wire_dqm(DRAM_DQM),   							//           .dqm
		.sdram_wire_ras_n(DRAM_RAS_N),						//           .ras_n
		.sdram_wire_we_n(DRAM_WE_N),  						//           .we_n
		
		// KEY
		.from_key_export(KEY[0]),  							//   from_key.export
		
		// LEDS
		.to_led_export(LED),                 				//   to_led.export
		
		// LT24 - LCD
		.lt24_conduit_cs(LT24_CS_N_bus),      					//  lt24_conduit.cs
		.lt24_conduit_rs(LT24_RS_bus),     						//              .rs
		.lt24_conduit_rd(LT24_RD_N_bus),      					//              .rd
		.lt24_conduit_wr(LT24_WR_N_bus),      					//              .wr
		.lt24_conduit_data(LT24_D_bus),    	   				//              .data
		.lt24_lcd_rstn_export(LT24_RESET_N_bus),				//       lt24_lcd_rstn.export
		
		// LT24 - TOUCH
		.lt24_touch_spi_MISO(LT24_ADC_DOUT_bus),        		//      lt24_touch_spi.MISO
		.lt24_touch_spi_MOSI(LT24_ADC_DIN_bus),        			//                    .MOSI
		.lt24_touch_spi_SCLK(LT24_ADC_DCLK_bus),        		//                    .SCLK
		.lt24_touch_spi_SS_n(LT24_ADC_CS_N_bus),       			//                    .SS_n
		.lt24_touch_penirq_n_export(LT24_ADC_PENIRQ_N_bus),	// lt24_touch_penirq_n.export
		.lt24_touch_busy_export(LT24_ADC_BUSY_bus),         	//           lt24_touch_busy.export
		
		.lt_avalon_out_cs(Avalon_CS),			//lt_avalon_out.cs
		.lt_avalon_out_sdi(Avalon_SDO),		//             .sdi
		.lt_avalon_out_sdo(Avalon_SDI),		//             .sdo
		.lt_avalon_out_sclk(Avalon_SCK),		//             .sclk
		.lt_avalon_out_sint(Avalon_SINT),

		.irq_tocyclo_out_export(Avalon_CS),	//irq_tocyclo_out.export
		
		// PLL
		.alt_pll_c4_conduit_export(),        				//        alt_pll_c4_conduit.export
		.alt_pll_c3_conduit_export(),        				//        alt_pll_c3_conduit.export
		.alt_pll_areset_conduit_export(),    				//    alt_pll_areset_conduit.export
		.alt_pll_locked_conduit_export(),    				//    alt_pll_locked_conduit.export
		.alt_pll_phasedone_conduit_export(),  				// alt_pll_phasedone_conduit.export
		.alt_pll_c1_clk(DRAM_CLK),                      //                alt_pll_c1.clk  
		
		.pic_mem_s2_address(pic_mem_s2_address),			//                pic_mem_s2.address
		.pic_mem_s2_chipselect(pic_mem_s2_chipselect),	//                          .chipselect
		.pic_mem_s2_clken(pic_mem_s2_clken),				//                          .clken
		.pic_mem_s2_write(pic_mem_s2_write),				//                          .write
		.pic_mem_s2_readdata(pic_mem_s2_readdata),		//                          .readdata
		.pic_mem_s2_writedata(pic_mem_s2_writedata),		//                          .writedata
		.pic_mem_s2_byteenable(pic_mem_s2_byteenable),	//                          .byteenable
		
		.lt24_buffer_flag_external_connection_export(lt24_buffer_flag),
		
		.background_mem_s2_address(background_mem_s2_address),                   
		.background_mem_s2_chipselect(background_mem_s2_chipselect),                
		.background_mem_s2_clken(background_mem_s2_clken),                     
		.background_mem_s2_write(background_mem_s2_write),                     
		.background_mem_s2_readdata(background_mem_s2_readdata),                  
		.background_mem_s2_writedata(background_mem_s2_writedata),                 
		.background_mem_s2_byteenable(background_mem_s2_byteenable) ,
		
		.gsensor_spi_out_SDIO(I2C_SDAT),                        //                      gsensor_spi_out.SDIO
		.gsensor_spi_out_SCLK(I2C_SCLK),                        //                                     .SCLK
		.gsensor_spi_out_CS_n(G_SENSOR_CS_N),                   //                                     .CS_n
		.gsensor_int_out_export(G_SENSOR_INT)                   //                      gsensor_int_out.export
	);
	
	LT24_buffer lt24_buf(
		.clk(CLOCK_50),          							
		.rst_n(RST_N),
		.LT24_ADC_BUSY_bus(LT24_ADC_BUSY_bus),
		.LT24_ADC_CS_N_bus(LT24_ADC_CS_N_bus),
		.LT24_ADC_DCLK_bus(LT24_ADC_DCLK_bus),
		.LT24_ADC_DIN_bus(LT24_ADC_DIN_bus),
		.LT24_ADC_DOUT_bus(LT24_ADC_DOUT_bus),
		.LT24_ADC_PENIRQ_N_bus(LT24_ADC_PENIRQ_N_bus),
		.LT24_D_bus(LT24_D_bus),
		.LT24_WR_N_bus(LT24_WR_N_bus),
		.LT24_RD_N_bus(LT24_RD_N_bus),
		.LT24_CS_N_bus(LT24_CS_N_bus),
		.LT24_RESET_N_bus(LT24_RESET_N_bus),
		.LT24_RS_bus(LT24_RS_bus),
		
		.LT24_ADC_BUSY_screen(LT24_ADC_BUSY),
		.LT24_ADC_CS_N_screen(LT24_ADC_CS_N),
		.LT24_ADC_DCLK_screen(LT24_ADC_DCLK),
		.LT24_ADC_DIN_screen(LT24_ADC_DIN),
		.LT24_ADC_DOUT_screen(LT24_ADC_DOUT),
		.LT24_ADC_PENIRQ_N_screen(LT24_ADC_PENIRQ_N),
		.LT24_D_screen(LT24_D),
		.LT24_WR_N_screen(LT24_WR_N),
		.LT24_RD_N_screen(LT24_RD_N),
		.LT24_CS_N_screen(LT24_CS_N),
		.LT24_RESET_N_screen(LT24_RESET_N),
		.LT24_RS_screen(LT24_RS),
		
		.pic_mem_s2_address(pic_mem_s2_address),               //                pic_mem_s2.address
		.pic_mem_s2_chipselect(pic_mem_s2_chipselect),            //                          .chipselect
		.pic_mem_s2_clken(pic_mem_s2_clken),                 //                          .clken
		.pic_mem_s2_write(pic_mem_s2_write),                 //                          .write
		.pic_mem_s2_readdata(pic_mem_s2_readdata),              //                          .readdata
		.pic_mem_s2_writedata(pic_mem_s2_writedata),             //                          .writedata
		.pic_mem_s2_byteenable(pic_mem_s2_byteenable),            //                          .byteenable
		
		.lt24_buffer_flag(lt24_buffer_flag),
		
		.background_mem_s2_address(background_mem_s2_address),                   
		.background_mem_s2_chipselect(background_mem_s2_chipselect),                
		.background_mem_s2_clken(background_mem_s2_clken),                     
		.background_mem_s2_write(background_mem_s2_write),                     
		.background_mem_s2_readdata(background_mem_s2_readdata),                  
		.background_mem_s2_writedata(background_mem_s2_writedata),                 
		.background_mem_s2_byteenable(background_mem_s2_byteenable) 
	);
				 
endmodule
