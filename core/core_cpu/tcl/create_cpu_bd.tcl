# $clk 及び $rstは外部定義


# create instr mem
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 instr_mem
set_property -dict [list CONFIG.Memory_Type {Single_Port_ROM} CONFIG.Enable_32bit_Address {false} CONFIG.Enable_A {Use_ENA_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.use_bram_block {Stand_Alone} CONFIG.Use_Byte_Write_Enable {false} CONFIG.Byte_Size {9} CONFIG.Use_RSTA_Pin {false} CONFIG.Port_A_Write_Rate {0}] [get_bd_cells instr_mem]
set_property CONFIG.Write_Depth_A [expr 2 ** $instr_addr_width] [get_bd_cells instr_mem]
connect_bd_net [get_bd_pins $clk] [get_bd_pins instr_mem/clka]
endgroup

# create data mem
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.0 axi_bram_ctrl
set_property -dict [list CONFIG.PROTOCOL {AXI4LITE} CONFIG.SINGLE_PORT_BRAM {1} CONFIG.ECC_TYPE {0}] [get_bd_cells axi_bram_ctrl]
create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 data_mem
connect_bd_intf_net [get_bd_intf_pins axi_bram_ctrl/BRAM_PORTA] [get_bd_intf_pins data_mem/BRAM_PORTA]
connect_bd_net [get_bd_pins axi_bram_ctrl/s_axi_aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins $rst] [get_bd_pins axi_bram_ctrl/s_axi_aresetn]
endgroup


# module cpu
startgroup
create_bd_cell -type module -reference cpu cpu
connect_bd_net [get_bd_pins $clk] [get_bd_pins cpu/clk]
connect_bd_net [get_bd_pins $rst] [get_bd_pins cpu/rst_n]
connect_bd_net [get_bd_pins cpu/instr_addr] [get_bd_pins instr_mem/addra]
connect_bd_net [get_bd_pins cpu/instr_code] [get_bd_pins instr_mem/douta]
connect_bd_net [get_bd_pins instr_mem/ena] [get_bd_pins cpu/instr_en]
connect_bd_intf_net [get_bd_intf_pins axi_bram_ctrl/S_AXI] [get_bd_intf_pins cpu/AXI]
set_property -dict [list CONFIG.INSTR_ADDR_WIDTH $instr_addr_width] [get_bd_cells cpu]
endgroup

# float
startgroup
create_bd_cell -type module -reference float float
connect_bd_net [get_bd_pins $clk] [get_bd_pins float/clk]
connect_bd_net [get_bd_pins float/rst_n] [get_bd_pins $rst]
endgroup

# create fadd fsub
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 fadd
set_property -dict [list CONFIG.Has_ARESETn {true}] [get_bd_cells fadd]
connect_bd_net [get_bd_pins fadd/aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins fadd/aresetn] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins float/fadd_a] [get_bd_intf_pins fadd/S_AXIS_A]
connect_bd_intf_net [get_bd_intf_pins float/fadd_b] [get_bd_intf_pins fadd/S_AXIS_B]
connect_bd_intf_net [get_bd_intf_pins float/fadd_operation] [get_bd_intf_pins fadd/S_AXIS_OPERATION]
connect_bd_intf_net [get_bd_intf_pins fadd/M_AXIS_RESULT] [get_bd_intf_pins float/fadd_r]
endgroup

# create fmul
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 fmul
set_property -dict [list CONFIG.Operation_Type {Multiply} CONFIG.Has_ARESETn {true} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {Full_Usage} CONFIG.C_Latency {9} CONFIG.C_Rate {1}] [get_bd_cells fmul]
connect_bd_net [get_bd_pins fmul/aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins fmul/aresetn] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins float/fmul_a] [get_bd_intf_pins fmul/S_AXIS_A]
connect_bd_intf_net [get_bd_intf_pins float/fmul_b] [get_bd_intf_pins fmul/S_AXIS_B]
connect_bd_intf_net [get_bd_intf_pins fmul/M_AXIS_RESULT] [get_bd_intf_pins float/fmul_r]
endgroup

# create fdiv
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 fdiv
set_property -dict [list CONFIG.Operation_Type {Divide} CONFIG.Has_ARESETn {true} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {29} CONFIG.C_Rate {1}] [get_bd_cells fdiv]
connect_bd_net [get_bd_pins fdiv/aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins fdiv/aresetn] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins float/fdiv_a] [get_bd_intf_pins fdiv/S_AXIS_A]
connect_bd_intf_net [get_bd_intf_pins float/fdiv_b] [get_bd_intf_pins fdiv/S_AXIS_B]
connect_bd_intf_net [get_bd_intf_pins fdiv/M_AXIS_RESULT] [get_bd_intf_pins float/fdiv_r]
endgroup

# create fsqrt
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 fsqrt
set_property -dict [list CONFIG.Operation_Type {Square_root} CONFIG.Has_ARESETn {true} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {29} CONFIG.C_Rate {1}] [get_bd_cells fsqrt]
connect_bd_net [get_bd_pins fsqrt/aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins fsqrt/aresetn] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins float/fsqrt] [get_bd_intf_pins fsqrt/S_AXIS_A]
connect_bd_intf_net [get_bd_intf_pins fsqrt/M_AXIS_RESULT] [get_bd_intf_pins float/fsqrt_r]
endgroup

# create fcmp
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 fcmp
set_property -dict [list CONFIG.Operation_Type {Compare} CONFIG.Has_ARESETn {true} CONFIG.Result_Precision_Type {Custom} CONFIG.C_Result_Exponent_Width {1} CONFIG.C_Result_Fraction_Width {0} CONFIG.C_Mult_Usage {No_Usage} CONFIG.Maximum_Latency {false} CONFIG.C_Latency {2} CONFIG.C_Rate {1}] [get_bd_cells fcmp]
connect_bd_net [get_bd_pins fcmp/aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins fcmp/aresetn] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins float/fcmp_a] [get_bd_intf_pins fcmp/S_AXIS_A]
connect_bd_intf_net [get_bd_intf_pins float/fcmp_b] [get_bd_intf_pins fcmp/S_AXIS_B]
connect_bd_intf_net [get_bd_intf_pins float/fcmp_operation] [get_bd_intf_pins fcmp/S_AXIS_OPERATION]
connect_bd_intf_net [get_bd_intf_pins fcmp/M_AXIS_RESULT] [get_bd_intf_pins float/fcmp_r]
endgroup

# create ftoi
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 ftoi
set_property -dict [list CONFIG.Operation_Type {Float_to_fixed} CONFIG.Has_ARESETn {true} CONFIG.Result_Precision_Type {Int32} CONFIG.C_Result_Exponent_Width {32} CONFIG.C_Result_Fraction_Width {0} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {7} CONFIG.C_Rate {1}] [get_bd_cells ftoi]
connect_bd_net [get_bd_pins ftoi/aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins ftoi/aresetn] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins float/ftoi] [get_bd_intf_pins ftoi/S_AXIS_A]
connect_bd_intf_net [get_bd_intf_pins ftoi/M_AXIS_RESULT] [get_bd_intf_pins float/ftoi_r]
endgroup

# crate itof
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 itof
set_property -dict [list CONFIG.Operation_Type {Fixed_to_float} CONFIG.Has_ARESETn {true} CONFIG.Result_Precision_Type {Single} CONFIG.C_Result_Exponent_Width {8} CONFIG.C_Result_Fraction_Width {24} CONFIG.C_Accum_Msb {32} CONFIG.C_Accum_Lsb {-31} CONFIG.C_Accum_Input_Msb {32} CONFIG.C_Mult_Usage {No_Usage} CONFIG.C_Latency {7} CONFIG.C_Rate {1}] [get_bd_cells itof]
connect_bd_net [get_bd_pins itof/aclk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins itof/aresetn] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins float/itof] [get_bd_intf_pins itof/S_AXIS_A]
connect_bd_intf_net [get_bd_intf_pins itof/M_AXIS_RESULT] [get_bd_intf_pins float/itof_r]
endgroup

# create floor
startgroup
create_bd_cell -type module -reference axi_stream_floor floor
connect_bd_net [get_bd_pins floor/clk] [get_bd_pins $clk]
connect_bd_net [get_bd_pins floor/rst_n] [get_bd_pins $rst]
connect_bd_intf_net [get_bd_intf_pins floor/floor] [get_bd_intf_pins float/floor]
connect_bd_intf_net [get_bd_intf_pins float/floor_r] [get_bd_intf_pins floor/floor_r]
endgroup

# float connect
startgroup
connect_bd_net [get_bd_pins float/ef_en] [get_bd_pins cpu/ef_en]
connect_bd_net [get_bd_pins cpu/f_rs1] [get_bd_pins float/f_rs1]
connect_bd_net [get_bd_pins float/f_frs1] [get_bd_pins cpu/f_frs1]
connect_bd_net [get_bd_pins float/f_frs2] [get_bd_pins cpu/f_frs2]
connect_bd_net [get_bd_pins float/f_funct3] [get_bd_pins cpu/f_funct3]
connect_bd_net [get_bd_pins cpu/f_funct5] [get_bd_pins float/f_funct5]
connect_bd_net [get_bd_pins cpu/fp_valid] [get_bd_pins float/fp_valid]
connect_bd_net [get_bd_pins float/fpdata] [get_bd_pins cpu/fp_data]
endgroup



group_bd_cells floating_unit [get_bd_cells float] [get_bd_cells fsqrt] [get_bd_cells fmul] [get_bd_cells ftoi] [get_bd_cells floor] [get_bd_cells fdiv] [get_bd_cells fcmp] [get_bd_cells itof] [get_bd_cells fadd]
