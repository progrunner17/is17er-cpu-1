puts [pwd]
source "./tcl/include.tcl"

puts [string compare [lindex $argv 0] "sim" ]

if { [string compare [lindex $argv 0] "sim" ]  == 0} {
	set project_name $sim_project_name 
	set is_sim 1

} elseif {[string compare [lindex $argv 0] "impl" ]  == 0} {
	
	set project_name $impl_project_name
	set is_impl 1
} else {
	puts no_option_exits
	exit
}
puts  [file exists "$project_dir/$project_name/$project_name.xpr"] 
if { [file exists "$project_dir/$project_name/$project_name.xpr"] != 1} {

puts does_not_exists
 source $tcl_dir/create_project.tcl


} else {
	puts exists
}


if {[string length [lindex $argv 1]] >0} {
	set coe_src [lindex $argv 1]
}


open_project $project_dir/$project_name/$project_name.xpr 

open_bd_design $project_dir/$project_name/$project_name.srcs/sources_1/bd/design_1/design_1.bd
set_property -dict [list CONFIG.Load_Init_File {true} CONFIG.Coe_File $coe_dir/$coe_src CONFIG.Fill_Remaining_Memory_Locations {true}] [get_bd_cells instr_mem]
save_bd_design


if {$is_sim} {
start_gui
generate_target Simulation [get_files /home/tansei/Dropbox/cpu_exp/core_cpu/cpu_sim/cpu_sim.srcs/sources_1/bd/design_1/design_1.bd]
export_ip_user_files -of_objects [get_files /home/tansei/Dropbox/cpu_exp/core_cpu/cpu_sim/cpu_sim.srcs/sources_1/bd/design_1/design_1.bd] -no_script -force -quiet
launch_simulation
set curr_wave [current_wave_config]
if { [string length $curr_wave] == 0 } {
	create_wave_config "simulation_wave_config"; 
}

set_property needs_save false [current_wave_config]

add_wave {{/design_1_wrapper/design_1_i/cpu/inst/clk}} {{/design_1_wrapper/design_1_i/cpu/inst/rst_n}} {{/design_1_wrapper/design_1_i/cpu/inst/start}} 
add_wave {{/design_1_wrapper/design_1_i/cpu/inst/instr_addr}} 
add_wave {{/design_1_wrapper/design_1_i/cpu/inst/F_val}} {{/design_1_wrapper/design_1_i/cpu/inst/D_val}} {{/design_1_wrapper/design_1_i/cpu/inst/E_val}} {{/design_1_wrapper/design_1_i/cpu/inst/W_val}} 
add_wave {{/design_1_wrapper/design_1_i/cpu/inst/i_decode/rs1_addr}}  {{/design_1_wrapper/design_1_i/cpu/inst/i_decode/rs2_addr}} {{/design_1_wrapper/design_1_i/cpu/inst/i_decode/rd_addr}}  {{/design_1_wrapper/design_1_i/cpu/inst/E_rs1}}  {{/design_1_wrapper/design_1_i/cpu/inst/E_rs2}}  
add_wave {{/design_1_wrapper/design_1_i/cpu/inst/i_decode/imm}} 
add_wave {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[7]}} {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[6]}} {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[5]}} {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[4]}} {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[3]}} {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[2]}} {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[1]}} {{/design_1_wrapper/design_1_i/cpu/inst/i_register/x[0]}} 
add_wave {{/design_1_wrapper/design_1_i/cpu/inst/AXI_AWADDR}} {{/design_1_wrapper/design_1_i/cpu/inst/AXI_WDATA}} {{/design_1_wrapper/design_1_i/cpu/inst/AXI_ARADDR}} {{/design_1_wrapper/design_1_i/cpu/inst/AXI_RDATA}} 
restart
run 20us


} elseif {$is_impl} {

launch_runs synth_1 -jobs 4
wait_on_run synth_1
launch_runs impl_1 -jobs 4
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
close_project
puts "Complete generatet bitstream"

}

