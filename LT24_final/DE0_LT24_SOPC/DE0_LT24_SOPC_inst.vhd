	component DE0_LT24_SOPC is
		port (
			alt_pll_areset_conduit_export               : in    std_logic                     := 'X';             -- export
			alt_pll_c1_clk                              : out   std_logic;                                        -- clk
			alt_pll_c3_clk                              : out   std_logic;                                        -- clk
			alt_pll_locked_conduit_export               : out   std_logic;                                        -- export
			alt_pll_phasedone_conduit_export            : out   std_logic;                                        -- export
			background_mem_s2_address                   : in    std_logic_vector(12 downto 0) := (others => 'X'); -- address
			background_mem_s2_chipselect                : in    std_logic                     := 'X';             -- chipselect
			background_mem_s2_clken                     : in    std_logic                     := 'X';             -- clken
			background_mem_s2_write                     : in    std_logic                     := 'X';             -- write
			background_mem_s2_readdata                  : out   std_logic_vector(15 downto 0);                    -- readdata
			background_mem_s2_writedata                 : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			background_mem_s2_byteenable                : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			clk_clk                                     : in    std_logic                     := 'X';             -- clk
			from_key_export                             : in    std_logic                     := 'X';             -- export
			gsensor_int_out_export                      : in    std_logic                     := 'X';             -- export
			gsensor_spi_out_SDIO                        : inout std_logic                     := 'X';             -- SDIO
			gsensor_spi_out_SCLK                        : out   std_logic;                                        -- SCLK
			gsensor_spi_out_CS_n                        : out   std_logic;                                        -- CS_n
			lt24_buffer_flag_external_connection_export : out   std_logic;                                        -- export
			lt24_conduit_cs                             : out   std_logic;                                        -- cs
			lt24_conduit_rs                             : out   std_logic;                                        -- rs
			lt24_conduit_rd                             : out   std_logic;                                        -- rd
			lt24_conduit_wr                             : out   std_logic;                                        -- wr
			lt24_conduit_data                           : out   std_logic_vector(15 downto 0);                    -- data
			lt24_lcd_rstn_export                        : out   std_logic;                                        -- export
			lt24_touch_busy_export                      : in    std_logic                     := 'X';             -- export
			lt24_touch_penirq_n_export                  : in    std_logic                     := 'X';             -- export
			lt24_touch_spi_MISO                         : in    std_logic                     := 'X';             -- MISO
			lt24_touch_spi_MOSI                         : out   std_logic;                                        -- MOSI
			lt24_touch_spi_SCLK                         : out   std_logic;                                        -- SCLK
			lt24_touch_spi_SS_n                         : out   std_logic;                                        -- SS_n
			lt_avalon_out_cs                            : in    std_logic                     := 'X';             -- cs
			lt_avalon_out_sdi                           : in    std_logic                     := 'X';             -- sdi
			lt_avalon_out_sdo                           : out   std_logic;                                        -- sdo
			lt_avalon_out_sclk                          : in    std_logic                     := 'X';             -- sclk
			lt_avalon_out_sint                          : out   std_logic;                                        -- sint
			pic_mem_s2_address                          : in    std_logic_vector(11 downto 0) := (others => 'X'); -- address
			pic_mem_s2_chipselect                       : in    std_logic                     := 'X';             -- chipselect
			pic_mem_s2_clken                            : in    std_logic                     := 'X';             -- clken
			pic_mem_s2_write                            : in    std_logic                     := 'X';             -- write
			pic_mem_s2_readdata                         : out   std_logic_vector(15 downto 0);                    -- readdata
			pic_mem_s2_writedata                        : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			pic_mem_s2_byteenable                       : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			reset_reset_n                               : in    std_logic                     := 'X';             -- reset_n
			sdram_wire_addr                             : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba                               : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n                            : out   std_logic;                                        -- cas_n
			sdram_wire_cke                              : out   std_logic;                                        -- cke
			sdram_wire_cs_n                             : out   std_logic;                                        -- cs_n
			sdram_wire_dq                               : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm                              : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n                            : out   std_logic;                                        -- ras_n
			sdram_wire_we_n                             : out   std_logic;                                        -- we_n
			to_led_export                               : out   std_logic_vector(7 downto 0);                     -- export
			irq_tocyclo_out_export                      : in    std_logic                     := 'X'              -- export
		);
	end component DE0_LT24_SOPC;

	u0 : component DE0_LT24_SOPC
		port map (
			alt_pll_areset_conduit_export               => CONNECTED_TO_alt_pll_areset_conduit_export,               --               alt_pll_areset_conduit.export
			alt_pll_c1_clk                              => CONNECTED_TO_alt_pll_c1_clk,                              --                           alt_pll_c1.clk
			alt_pll_c3_clk                              => CONNECTED_TO_alt_pll_c3_clk,                              --                           alt_pll_c3.clk
			alt_pll_locked_conduit_export               => CONNECTED_TO_alt_pll_locked_conduit_export,               --               alt_pll_locked_conduit.export
			alt_pll_phasedone_conduit_export            => CONNECTED_TO_alt_pll_phasedone_conduit_export,            --            alt_pll_phasedone_conduit.export
			background_mem_s2_address                   => CONNECTED_TO_background_mem_s2_address,                   --                    background_mem_s2.address
			background_mem_s2_chipselect                => CONNECTED_TO_background_mem_s2_chipselect,                --                                     .chipselect
			background_mem_s2_clken                     => CONNECTED_TO_background_mem_s2_clken,                     --                                     .clken
			background_mem_s2_write                     => CONNECTED_TO_background_mem_s2_write,                     --                                     .write
			background_mem_s2_readdata                  => CONNECTED_TO_background_mem_s2_readdata,                  --                                     .readdata
			background_mem_s2_writedata                 => CONNECTED_TO_background_mem_s2_writedata,                 --                                     .writedata
			background_mem_s2_byteenable                => CONNECTED_TO_background_mem_s2_byteenable,                --                                     .byteenable
			clk_clk                                     => CONNECTED_TO_clk_clk,                                     --                                  clk.clk
			from_key_export                             => CONNECTED_TO_from_key_export,                             --                             from_key.export
			gsensor_int_out_export                      => CONNECTED_TO_gsensor_int_out_export,                      --                      gsensor_int_out.export
			gsensor_spi_out_SDIO                        => CONNECTED_TO_gsensor_spi_out_SDIO,                        --                      gsensor_spi_out.SDIO
			gsensor_spi_out_SCLK                        => CONNECTED_TO_gsensor_spi_out_SCLK,                        --                                     .SCLK
			gsensor_spi_out_CS_n                        => CONNECTED_TO_gsensor_spi_out_CS_n,                        --                                     .CS_n
			lt24_buffer_flag_external_connection_export => CONNECTED_TO_lt24_buffer_flag_external_connection_export, -- lt24_buffer_flag_external_connection.export
			lt24_conduit_cs                             => CONNECTED_TO_lt24_conduit_cs,                             --                         lt24_conduit.cs
			lt24_conduit_rs                             => CONNECTED_TO_lt24_conduit_rs,                             --                                     .rs
			lt24_conduit_rd                             => CONNECTED_TO_lt24_conduit_rd,                             --                                     .rd
			lt24_conduit_wr                             => CONNECTED_TO_lt24_conduit_wr,                             --                                     .wr
			lt24_conduit_data                           => CONNECTED_TO_lt24_conduit_data,                           --                                     .data
			lt24_lcd_rstn_export                        => CONNECTED_TO_lt24_lcd_rstn_export,                        --                        lt24_lcd_rstn.export
			lt24_touch_busy_export                      => CONNECTED_TO_lt24_touch_busy_export,                      --                      lt24_touch_busy.export
			lt24_touch_penirq_n_export                  => CONNECTED_TO_lt24_touch_penirq_n_export,                  --                  lt24_touch_penirq_n.export
			lt24_touch_spi_MISO                         => CONNECTED_TO_lt24_touch_spi_MISO,                         --                       lt24_touch_spi.MISO
			lt24_touch_spi_MOSI                         => CONNECTED_TO_lt24_touch_spi_MOSI,                         --                                     .MOSI
			lt24_touch_spi_SCLK                         => CONNECTED_TO_lt24_touch_spi_SCLK,                         --                                     .SCLK
			lt24_touch_spi_SS_n                         => CONNECTED_TO_lt24_touch_spi_SS_n,                         --                                     .SS_n
			lt_avalon_out_cs                            => CONNECTED_TO_lt_avalon_out_cs,                            --                        lt_avalon_out.cs
			lt_avalon_out_sdi                           => CONNECTED_TO_lt_avalon_out_sdi,                           --                                     .sdi
			lt_avalon_out_sdo                           => CONNECTED_TO_lt_avalon_out_sdo,                           --                                     .sdo
			lt_avalon_out_sclk                          => CONNECTED_TO_lt_avalon_out_sclk,                          --                                     .sclk
			lt_avalon_out_sint                          => CONNECTED_TO_lt_avalon_out_sint,                          --                                     .sint
			pic_mem_s2_address                          => CONNECTED_TO_pic_mem_s2_address,                          --                           pic_mem_s2.address
			pic_mem_s2_chipselect                       => CONNECTED_TO_pic_mem_s2_chipselect,                       --                                     .chipselect
			pic_mem_s2_clken                            => CONNECTED_TO_pic_mem_s2_clken,                            --                                     .clken
			pic_mem_s2_write                            => CONNECTED_TO_pic_mem_s2_write,                            --                                     .write
			pic_mem_s2_readdata                         => CONNECTED_TO_pic_mem_s2_readdata,                         --                                     .readdata
			pic_mem_s2_writedata                        => CONNECTED_TO_pic_mem_s2_writedata,                        --                                     .writedata
			pic_mem_s2_byteenable                       => CONNECTED_TO_pic_mem_s2_byteenable,                       --                                     .byteenable
			reset_reset_n                               => CONNECTED_TO_reset_reset_n,                               --                                reset.reset_n
			sdram_wire_addr                             => CONNECTED_TO_sdram_wire_addr,                             --                           sdram_wire.addr
			sdram_wire_ba                               => CONNECTED_TO_sdram_wire_ba,                               --                                     .ba
			sdram_wire_cas_n                            => CONNECTED_TO_sdram_wire_cas_n,                            --                                     .cas_n
			sdram_wire_cke                              => CONNECTED_TO_sdram_wire_cke,                              --                                     .cke
			sdram_wire_cs_n                             => CONNECTED_TO_sdram_wire_cs_n,                             --                                     .cs_n
			sdram_wire_dq                               => CONNECTED_TO_sdram_wire_dq,                               --                                     .dq
			sdram_wire_dqm                              => CONNECTED_TO_sdram_wire_dqm,                              --                                     .dqm
			sdram_wire_ras_n                            => CONNECTED_TO_sdram_wire_ras_n,                            --                                     .ras_n
			sdram_wire_we_n                             => CONNECTED_TO_sdram_wire_we_n,                             --                                     .we_n
			to_led_export                               => CONNECTED_TO_to_led_export,                               --                               to_led.export
			irq_tocyclo_out_export                      => CONNECTED_TO_irq_tocyclo_out_export                       --                      irq_tocyclo_out.export
		);

