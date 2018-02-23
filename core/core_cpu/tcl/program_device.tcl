source ./tcl/include.tcl


open_hw
connect_hw_server
open_hw_target
set_property PROGRAM.FILE $project_dir/$impl_project_name/$impl_project_name.runs/impl_1/design_1_wrapper.bit [lindex [get_hw_devices xcku040_0] 0]
current_hw_device [lindex [get_hw_devices xcku040_0] 0]
refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcku040_0] 0]
set_property PROBES.FILE {} [lindex [get_hw_devices xcku040_0] 0]
set_property PROGRAM.FILE $project_dir/$impl_project_name/$impl_project_name.runs/impl_1/design_1_wrapper.bit [lindex [get_hw_devices xcku040_0] 0]
program_hw_devices [lindex [get_hw_devices xcku040_0] 0]
refresh_hw_device [lindex [get_hw_devices xcku040_0] 0]
disconnect_hw_server localhost:3121
close_hw
