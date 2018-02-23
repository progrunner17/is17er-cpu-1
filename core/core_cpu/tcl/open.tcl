source ./tcl/include.tcl

if {[string compare [lindex $argv 0] "sim" ]  == 0} {
	puts sim
	set project_name $sim_project_name
} elseif {[string compare [lindex $argv 0] "impl" ]  == 0} {
	puts impl
	set project_name $impl_project_name
}

open_project $project_dir/$project_name/$project_name.xpr 
start_gui
