transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control/Sdram_WR_FIFO.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control/Sdram_RD_FIFO.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/MTL_PLL.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/RAM_PLL.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/db {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/db/mtl_pll_altpll.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/db {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/db/ram_pll_altpll.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control/sdram_control.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control/sdr_data_path.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control/control_interface.v}
vlog -vlog01compat -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/sdram_control/command.v}
vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/LT_SPI.sv}
vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/DE0_NANO.sv}
vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/mtl_controller.sv}
vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/LineCUBE.sv}
vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/lineoblique.sv}

vlog -sv -work work +incdir+C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL {C:/Users/Stephane/Documents/GitHub/M1_PELEC/Test_MTL/lineCUBE_testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  lineCUBE_testbench

add wave *
view structure
view signals
run 100 us
