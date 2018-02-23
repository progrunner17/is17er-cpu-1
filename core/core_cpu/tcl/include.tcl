set project_dir 		[file normalize  "[file dirname [info script]]/../" ]
set rtl_dir 			$project_dir/rtl
set constraints_dir 	$project_dir/constraints
set tcl_dir 			$project_dir/tcl
set coe_dir 			$project_dir/coe
set instr_addr_width	14
# set data_addr_width		18
set impl_project_name 	cpu_impl
set sim_project_name 	cpu_sim
set coe_src 			min-rt_inline_80.coe
set baudrate 			115200
set is_sim 				0
set is_impl 			0
