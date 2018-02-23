`default_nettype none

`include "./include.vh"


module decode #(
	parameter INSTR_ADDR_WIDTH = 14
)
(clk,rst_n,d_en,instr_code,D_pc,E_pc,E_opcode,E_funct5,E_funct3,
E_imm,rs1_addr,rs2_addr,E_rd_addr,E_write_flags);



	input  wire                  clk          ;
	input  wire                  rst_n        ;
	input  wire                  d_en         ;
	input  wire [          31:0] instr_code   ;
	input  wire [INSTR_ADDR_WIDTH-1:0] D_pc         ;
	output reg  [INSTR_ADDR_WIDTH-1:0] E_pc           = 0;
	output reg  [           4:0] E_opcode       = 0;
	output reg  [           4:0] E_funct5       = 0;
	output reg  [           2:0] E_funct3       = 0;
	output reg  [          31:0] E_imm          = 0;
	output wire [           4:0] rs1_addr     ;
	output wire [           4:0] rs2_addr     ;
	output reg  [           4:0] E_rd_addr      = 0;
	output reg  [ `WF_WIDTH-1:0] E_write_flags  = 0;



//imm
	wire [31:0] imm;
	make_imm inst_make_imm(.instr_code(instr_code),.imm(imm));

//operation
	wire [4:0] opcode;
	assign opcode = instr_code[6:2];

	wire [2:0] funct3;
	assign funct3 = instr_code[14:12];

	wire [4:0] funct5;
	assign funct5 = instr_code[31:27];

	wire is_sub_sra;
	assign is_sub_sra = instr_code[30] ; 
	assign rs1_addr = instr_code[19:15];
	assign rs2_addr = instr_code[24:20];
	wire [4:0] rd_addr;
	assign rd_addr = instr_code[11:7];

	wire [`WF_WIDTH-1:0] write_flags;
	make_write_flags inst_make_write_flags(.opcode(opcode),.funct5(funct5),.funct3(funct3),.write_flags(write_flags));

	always @(posedge clk) begin
		if(~rst_n) begin
			E_pc          <=  'h0;
			E_opcode      <=  5'b0;
			E_funct3      <=  3'b0;
			E_funct5      <=  5'b0;
			E_imm         <= 32'b0;
			E_rd_addr     <=  5'b0;
			E_write_flags <=  6'b0;
		end else if (d_en)begin
			E_pc          <= D_pc;
			E_opcode      <= opcode;
			E_funct3      <= funct3;
			E_funct5      <= funct5;
			E_imm         <= imm;
			E_rd_addr     <= rd_addr;
			E_write_flags <= write_flags;
		end
	end
endmodule

module make_imm (
	input  wire [31:0] instr_code,
	output wire [31:0] imm
);

	wire [4:0] opcode;
	assign opcode = instr_code[6:2];
	assign imm    = (opcode == `OP_LUI || opcode == `OP_AUIPC) ? {instr_code[31:12],12'h000}: //U 20bit unsigned
		(opcode == `OP_JAL) ? {{13{instr_code[31]}},instr_code[30:12]} : //J alpha // 20bit signed
		(opcode == `OP_JALR || opcode == `OP_LOAD || opcode == `OP_ALUI || opcode ==`OP_LOAD_FP) ? {{21{instr_code[31]}},instr_code[30:20]}://I 12bit signed
		(opcode == `OP_BRANCH || opcode == `OP_STORE || opcode == `OP_STORE_FP) ? {{21{instr_code[31]}},instr_code[30:25],instr_code[11:7]}://B,S 12bit signed
		32'h0000_0000;
endmodule




module make_write_flags (
	input  wire [          4:0] opcode     ,
	input  wire [          4:0] funct5     ,
	input  wire [          2:0] funct3     ,
	output wire [`WF_WIDTH-1:0] write_flags
);

	wire xwe;
	assign xwe = (opcode == `OP_LUI || opcode == `OP_AUIPC ||opcode == `OP_JAL || opcode == `OP_JALR || opcode == `OP_ALUI || opcode == `OP_ALU || opcode == `OP_LOAD || opcode == `OP_LOAD_IO ||(opcode == `OP_FP && (funct5 == `F5_FTOX || funct5 == `F5_FTOI || funct5 == `F5_FCMP)));
	wire fwe;

	assign fwe = (opcode == `OP_LOAD_FP || (opcode ==`OP_FP  && (funct5 == `F5_FADD || funct5 == `F5_FSUB || funct5 == `F5_FMUL || funct5 == `F5_FDIV || funct5 == `F5_FSQRT || funct5 == `F5_FSGNJ || funct5 ==`F5_XTOF || funct5 == `F5_ITOF)));

	wire fip_flag;
	assign fip_flag = (opcode == `OP_FP && (funct5 == `F5_FADD || funct5 == `F5_FSUB ||funct5 == `F5_FMUL ||funct5 == `F5_FDIV || funct5 == `F5_FSQRT || funct5 == `F5_FCMP || funct5 == `F5_FTOI   ||  funct5 == `F5_ITOF ));

	wire rd_flag;
	assign rd_flag = (opcode == `OP_LUI || opcode == `OP_AUIPC || opcode == `OP_JAL || opcode == `OP_JALR || opcode == `OP_ALUI || opcode == `OP_ALU || (opcode == `OP_FP && (funct5 ==`F5_FSGNJ || funct5 == `F5_FTOX || funct5 == `F5_XTOF )));

	wire axi_flag;
	assign axi_flag = (opcode == `OP_LOAD || opcode == `OP_LOAD_FP);

	wire input_flag;
	assign input_flag = opcode == `OP_LOAD_IO;
// input flag
	assign write_flags[6] = input_flag;
//xwe  integer register write enable
	assign write_flags[5] = xwe;
//fwe  floating register write enable
	assign write_flags[4] = fwe;
//wait wait until valid signal in write back stage
	assign write_flags[3] = (axi_flag || opcode == `OP_STORE || opcode == `OP_STORE_FP|| opcode == `OP_STORE_IO || fip_flag || input_flag );
//rd   write data is to be rd, which is from execute module
	assign write_flags[2] = rd_flag;
//fip  write data is to be fpdata, which is from float module
	assign write_flags[1] = fip_flag;
//axi  write data is to be axi_rdata, which is from memory
	assign write_flags[0] = axi_flag;

endmodule

`default_nettype wire

