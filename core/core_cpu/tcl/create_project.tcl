
source ./tcl/include.tcl


# シミュレーション用or実機用にプロジェクト名、クロック等の設定

if {[string compare [lindex $argv 0] "impl" ]  == 0} {
	set project_name $impl_project_name
	set clk clk_wiz/clk_out1
	set rst clk_wiz/locked
	set is_impl 1
} elseif {[string compare [lindex $argv 0] "sim"] == 0} {
	set project_name $sim_project_name
	set clk sim_clk/clk
	set rst sim_clk/sync_rst
	set is_sim 1
} else {
	puts argv_does_not_exists
	exit
}




# プロジェクトの作成
create_project $project_name $project_dir/$project_name -part xcku040-ffva1156-2-e
set_property board_part xilinx.com:kcu105:part0:1.1 [current_project]

# ソースの追加
add_files -norecurse -scan_for_includes $rtl_dir

if { $is_sim } {
	add_files -norecurse -scan_for_includes $rtl_dir/sim
} elseif {$is_impl} {
	add_files -fileset constrs_1 -norecurse  $constraints_dir
	add_files -norecurse -scan_for_includes $rtl_dir/impl
}


# ブロックデザイン作成
create_bd_design "design_1"



# クロックの生成

if {$is_sim} {

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:sim_clk_gen:1.0 sim_clk
set_property -dict [list CONFIG.INITIAL_RESET_CLOCK_CYCLES {10}] [get_bd_cells sim_clk]
endgroup

} elseif {$is_impl} {

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.3 clk_wiz
apply_board_connection -board_interface "default_sysclk_300" -ip_intf "clk_wiz/CLK_IN1_D" -diagram "design_1"
apply_bd_automation -rule xilinx.com:bd_rule:board -config {Board_Interface "reset ( FPGA Reset ) " }  [get_bd_pins clk_wiz/reset]
endgroup

}



source $tcl_dir/create_cpu_bd.tcl




# 開始パルスの生成
if {$is_sim} {

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xconstant
set_property -dict [list CONFIG.CONST_VAL {0}] [get_bd_cells xconstant]
create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 shift_reg_1
set_property -dict [list CONFIG.Width {1} CONFIG.Depth {1} CONFIG.DefaultData {0} CONFIG.AsyncInitVal {1} CONFIG.SyncInitVal {0}] [get_bd_cells shift_reg_1]
create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 shift_reg_2
set_property -dict [list CONFIG.Width {1} CONFIG.Depth {20} CONFIG.DefaultData {0} CONFIG.AsyncInitVal {0} CONFIG.SyncInitVal {0}] [get_bd_cells shift_reg_2]
connect_bd_net [get_bd_pins shift_reg_2/D] [get_bd_pins shift_reg_1/Q]
connect_bd_net [get_bd_pins shift_reg_1/D] [get_bd_pins xconstant/dout]
connect_bd_net [get_bd_pins shift_reg_1/CLK] [get_bd_pins $clk]
connect_bd_net [get_bd_pins shift_reg_2/CLK] [get_bd_pins $clk]
group_bd_cells start_pulse [get_bd_cells shift_reg_1] [get_bd_cells shift_reg_2] [get_bd_cells xconstant]
connect_bd_net [get_bd_pins start_pulse/shift_reg_2/Q] [get_bd_pins cpu/start]
endgroup


} elseif {$is_impl} {

startgroup
create_bd_port -dir I start
create_bd_cell -type module -reference chattering chattering
connect_bd_net [get_bd_pins chattering/dout] [get_bd_pins cpu/start]
connect_bd_net [get_bd_pins chattering/clk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins $rst] [get_bd_pins chattering/rst_n]
connect_bd_net [get_bd_ports start] [get_bd_pins chattering/din]
endgroup

}



# create uart
if {$is_sim} {

startgroup
create_bd_cell -type module -reference uart_stream_cap  u_cap
connect_bd_intf_net [get_bd_intf_pins u_cap/STREAM_READ] [get_bd_intf_pins cpu/UART_INPUT]
connect_bd_intf_net [get_bd_intf_pins u_cap/STREAM_WRITE] [get_bd_intf_pins cpu/UART_OUTPUT]
connect_bd_net [get_bd_pins u_cap/clk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins u_cap/rst_n] [get_bd_pins $rst]
endgroup


} elseif {$is_impl} {

startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 uart
apply_board_connection -board_interface "rs232_uart" -ip_intf "uart/UART" -diagram "design_1"
connect_bd_net [get_bd_pins uart/s_axi_aclk] [get_bd_pins clk_wiz/clk_out1]
connect_bd_net [get_bd_pins uart/s_axi_aresetn] [get_bd_pins clk_wiz/locked]
create_bd_cell -type module -reference uart_controller uart_controller
connect_bd_net [get_bd_pins clk_wiz/clk_out1] [get_bd_pins uart_controller/clk]
connect_bd_net [get_bd_pins clk_wiz/locked] [get_bd_pins uart_controller/rst_n]
connect_bd_intf_net [get_bd_intf_pins uart_controller/AXI] [get_bd_intf_pins uart/S_AXI]
connect_bd_intf_net [get_bd_intf_pins uart_controller/UART_WRITE] [get_bd_intf_pins cpu/UART_OUTPUT]
connect_bd_intf_net [get_bd_intf_pins uart_controller/UART_READ] [get_bd_intf_pins cpu/UART_INPUT]
endgroup

}

regenerate_bd_layout
assign_bd_address
set_property range 1M [get_bd_addr_segs {cpu/AXI/SEG_axi_bram_ctrl_Mem0}]
set_property offset 0x00000000 [get_bd_addr_segs {cpu/AXI/SEG_axi_bram_ctrl_Mem0}]
regenerate_bd_layout
validate_bd_design
save_bd_design


# ラッパーの作成
make_wrapper -files [get_files $project_dir/$project_name/$project_name.srcs/sources_1/bd/design_1/design_1.bd] -top
add_files -norecurse $project_dir/$project_name/$project_name.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
set_property top design_1_wrapper [current_fileset]



if {$is_sim} {
set_property top design_1_wrapper [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]


} 
save_bd_design
close_project

# update_module_reference design_1_cpu_0
# update_module_reference design_1_float_0
