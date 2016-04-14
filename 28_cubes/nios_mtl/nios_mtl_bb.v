
module nios_mtl (
	button_external_connection_export,
	clk_clk,
	leds_external_connection_export,
	nios_mtl_controller_0_mtl_controller_spi,
	nios_mtl_controller_0_mtl_controller_clk,
	nios_mtl_controller_0_mtl_controller_reset_n,
	nios_mtl_controller_0_mtl_controller_loading,
	nios_mtl_controller_0_mtl_controller_newframe,
	nios_mtl_controller_0_mtl_controller_endframe,
	nios_mtl_controller_0_mtl_controller_read_data,
	nios_mtl_controller_0_mtl_controller_read_sdram_en,
	nios_mtl_controller_0_mtl_controller_hd,
	nios_mtl_controller_0_mtl_controller_vd,
	nios_mtl_controller_0_mtl_controller_lcd_r,
	nios_mtl_controller_0_mtl_controller_lcd_g,
	nios_mtl_controller_0_mtl_controller_lcd_b,
	reset_reset_n,
	switch_external_connection_export);	

	input		button_external_connection_export;
	input		clk_clk;
	output	[7:0]	leds_external_connection_export;
	input	[7:0]	nios_mtl_controller_0_mtl_controller_spi;
	input		nios_mtl_controller_0_mtl_controller_clk;
	input		nios_mtl_controller_0_mtl_controller_reset_n;
	input		nios_mtl_controller_0_mtl_controller_loading;
	output		nios_mtl_controller_0_mtl_controller_newframe;
	output		nios_mtl_controller_0_mtl_controller_endframe;
	input	[31:0]	nios_mtl_controller_0_mtl_controller_read_data;
	output		nios_mtl_controller_0_mtl_controller_read_sdram_en;
	output		nios_mtl_controller_0_mtl_controller_hd;
	output		nios_mtl_controller_0_mtl_controller_vd;
	output	[7:0]	nios_mtl_controller_0_mtl_controller_lcd_r;
	output	[7:0]	nios_mtl_controller_0_mtl_controller_lcd_g;
	output	[7:0]	nios_mtl_controller_0_mtl_controller_lcd_b;
	input		reset_reset_n;
	input	[3:0]	switch_external_connection_export;
endmodule
