RM = rm -rf
FLAGS = -nojournal -nolog



create_impl:
	vivado -mode batch  $(FLAGS) -source ./tcl/create_project.tcl -tclargs impl

create_sim:
	vivado -mode batch  $(FLAGS) -source ./tcl/create_project.tcl -tclargs sim



open_impl:
	vivado -mode batch  $(FLAGS) -source ./tcl/open.tcl  -tclargs impl &

open_sim:
	vivado -mode batch  $(FLAGS) -source ./tcl/open.tcl  -tclargs sim &


run_impl:
	vivado -mode batch  $(FLAGS) -source ./tcl/run.tcl -tclargs impl  $(SRC) &

run_sim:
	vivado -mode batch  $(FLAGS) -source ./tcl/run.tcl -tclargs sim  $(SRC) &


.PHONY: clean

clean:
	$(RM) .Xil cpu_impl cpu_sim *.log *.jou *.str *.~ vivado*.zip
