`default_nettype none
`include "include.vh"

module decode (
	input wire clk,
	input wire rst_n,

	input wire [31:0] instr_code,

	output wire [6:0] opcode,
	output wire [2:0] op_ctrl,
	output wire op_switch,// to switch (0&1), ADD&SUB , SRLI&SRAI, SRL&SRA
	// output wire op_imm,


	output wire [4:0] rs1_addr,
	output wire [4:0] rs2_addr,
	output reg [4:0] w_addr,
	output reg we,

	output wire [31:0] imm,//is it better not expanding？
	output wire [4:0] shamt
);


assign opcode = instr_code[6:0];
assign op_ctrl = instr_code[14:12];
assign op_switch = (opcode == `OP_ALUI & instr_code[30]) | (opcode == `OP_ALU & instr_code[30] & (op_ctrl == 3'b000 |op_ctrl==3'b101 ));
// assign op_imm = (opcode == `OP_ALUI | opcode == `OP)
assign shamt = instr_code[24:20] ;
assign rs1_addr = instr_code[19:15] ;
assign rs2_addr = instr_code[24:20] ;

assign w_addr = instr_code[11:7] ;
assign imm = 	(opcode == `OP_LUI | opcode == `OP_AUIPC) ? {instr_code[31:12],12'b0}:
				(opcode == `OP_JAL) ? {{12{instr_code[31]}},instr_code[19:12],instr_code[20],instr_code[30:21],1'b0}:
				(opcode == `OP_JALR| opcode == `OP_LOAD|opcode == `OP_ALUI)? {{21{instr_code[31]}},instr_code[30:20]}:
				(opcode == `OP_STORE )?{{21{instr_code[31]}},instr_code[30:25],instr_code[11:7]}:
				32'b0;


always @(posedge clk)begin
	if(~rst_n) begin
		we <= 0;
	end else begin
		we <= opcode == `OP_LUI || opcode == `OP_ALU || opcode == `OP_ALUI || opcode == `OP_LOAD;
	end
end


endmodule


`default_nettype wire