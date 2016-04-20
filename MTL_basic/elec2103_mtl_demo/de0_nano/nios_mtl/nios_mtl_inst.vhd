	component nios_mtl is
		port (
			button_external_connection_export                  : in  std_logic                     := 'X';             -- export
			clk_clk                                            : in  std_logic                     := 'X';             -- clk
			leds_external_connection_export                    : out std_logic_vector(7 downto 0);                     -- export
			nios_mtl_controller_0_mtl_controller_clk           : in  std_logic                     := 'X';             -- clk
			nios_mtl_controller_0_mtl_controller_reset_n       : in  std_logic                     := 'X';             -- reset_n
			nios_mtl_controller_0_mtl_controller_loading       : in  std_logic                     := 'X';             -- loading
			nios_mtl_controller_0_mtl_controller_newframe      : out std_logic;                                        -- newframe
			nios_mtl_controller_0_mtl_controller_endframe      : out std_logic;                                        -- endframe
			nios_mtl_controller_0_mtl_controller_read_data     : in  std_logic_vector(31 downto 0) := (others => 'X'); -- read_data
			nios_mtl_controller_0_mtl_controller_read_sdram_en : out std_logic;                                        -- read_sdram_en
			nios_mtl_controller_0_mtl_controller_hd            : out std_logic;                                        -- hd
			nios_mtl_controller_0_mtl_controller_vd            : out std_logic;                                        -- vd
			nios_mtl_controller_0_mtl_controller_lcd_r         : out std_logic_vector(7 downto 0);                     -- lcd_r
			nios_mtl_controller_0_mtl_controller_lcd_g         : out std_logic_vector(7 downto 0);                     -- lcd_g
			nios_mtl_controller_0_mtl_controller_lcd_b         : out std_logic_vector(7 downto 0);                     -- lcd_b
			nios_mtl_controller_0_mtl_controller_game_status   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- game_status
			nios_mtl_controller_0_mtl_controller_jump          : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- jump
			nios_mtl_controller_0_mtl_controller_acc           : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- acc
			nios_mtl_controller_0_mtl_controller_button        : in  std_logic                     := 'X';             -- button
			nios_mtl_controller_0_mtl_controller_ptouch        : in  std_logic                     := 'X';             -- ptouch
			nios_mtl_controller_0_mtl_controller_ytouch        : in  std_logic_vector(8 downto 0)  := (others => 'X'); -- ytouch
			nios_mtl_controller_0_mtl_controller_xtouch        : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- xtouch
			reset_reset_n                                      : in  std_logic                     := 'X';             -- reset_n
			switch_external_connection_export                  : in  std_logic_vector(3 downto 0)  := (others => 'X')  -- export
		);
	end component nios_mtl;

	u0 : component nios_mtl
		port map (
			button_external_connection_export                  => CONNECTED_TO_button_external_connection_export,                  --           button_external_connection.export
			clk_clk                                            => CONNECTED_TO_clk_clk,                                            --                                  clk.clk
			leds_external_connection_export                    => CONNECTED_TO_leds_external_connection_export,                    --             leds_external_connection.export
			nios_mtl_controller_0_mtl_controller_clk           => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_clk,           -- nios_mtl_controller_0_mtl_controller.clk
			nios_mtl_controller_0_mtl_controller_reset_n       => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_reset_n,       --                                     .reset_n
			nios_mtl_controller_0_mtl_controller_loading       => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_loading,       --                                     .loading
			nios_mtl_controller_0_mtl_controller_newframe      => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_newframe,      --                                     .newframe
			nios_mtl_controller_0_mtl_controller_endframe      => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_endframe,      --                                     .endframe
			nios_mtl_controller_0_mtl_controller_read_data     => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_read_data,     --                                     .read_data
			nios_mtl_controller_0_mtl_controller_read_sdram_en => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_read_sdram_en, --                                     .read_sdram_en
			nios_mtl_controller_0_mtl_controller_hd            => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_hd,            --                                     .hd
			nios_mtl_controller_0_mtl_controller_vd            => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_vd,            --                                     .vd
			nios_mtl_controller_0_mtl_controller_lcd_r         => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_lcd_r,         --                                     .lcd_r
			nios_mtl_controller_0_mtl_controller_lcd_g         => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_lcd_g,         --                                     .lcd_g
			nios_mtl_controller_0_mtl_controller_lcd_b         => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_lcd_b,         --                                     .lcd_b
			nios_mtl_controller_0_mtl_controller_game_status   => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_game_status,   --                                     .game_status
			nios_mtl_controller_0_mtl_controller_jump          => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_jump,          --                                     .jump
			nios_mtl_controller_0_mtl_controller_acc           => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_acc,           --                                     .acc
			nios_mtl_controller_0_mtl_controller_button        => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_button,        --                                     .button
			nios_mtl_controller_0_mtl_controller_ptouch        => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_ptouch,        --                                     .ptouch
			nios_mtl_controller_0_mtl_controller_ytouch        => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_ytouch,        --                                     .ytouch
			nios_mtl_controller_0_mtl_controller_xtouch        => CONNECTED_TO_nios_mtl_controller_0_mtl_controller_xtouch,        --                                     .xtouch
			reset_reset_n                                      => CONNECTED_TO_reset_reset_n,                                      --                                reset.reset_n
			switch_external_connection_export                  => CONNECTED_TO_switch_external_connection_export                   --           switch_external_connection.export
		);

