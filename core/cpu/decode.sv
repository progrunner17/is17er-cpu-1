`default_nettype none

`include "include.vh"

module decode (
	input wire clk,
	input wire rst_n,

	input wire [31:0] instr_code,

	output reg [6:0] opcode,
	output reg [2:0] op_ctrl,
	output reg op_switch,// to switch (0&1), ADD&SUB , SRLI&SRAI, SRL&SRA

	output wire [4:0] rs1_addr,
	output wire [4:0] rs2_addr,
	output reg [31:0] imm,//is it better not expanding？
	output reg [4:0] waddr,
	output reg we

);


assign rs1_addr = instr_code[19:15] ;
assign rs2_addr = instr_code[24:20] ;
// assign imm = 	(opcode == `OP_LUI | opcode == `OP_AUIPC) ? {instr_code[31:12],12'b0}:
// 				(opcode == `OP_JAL) ? {{12{instr_code[31]}},instr_code[19:12],instr_code[20],instr_code[30:21],1'b0}:
// 				(opcode == `OP_JALR| opcode == `OP_LOAD|opcode == `OP_ALUI)? {{21{instr_code[31]}},instr_code[30:20]}:
// 				(opcode == `OP_BRANCH)?{{20{instr_code[31]}},instr_code[7],instr_code[30:25],instr_code[11:8],1'b0}:
// 				(opcode == `OP_STORE )?{{21{instr_code[31]}},instr_code[30:25],instr_code[11:7]}:
// 				32'b0;

always @(posedge clk)begin 
	if(~rst_n)begin
		opcode <= 0;
		waddr <= 0;
		op_ctrl <= 0;
		op_switch <= 0;
		imm <= 0;
		we <= 0;
	end else begin
		opcode <= instr_code[6:0];
		waddr <= instr_code[11:7] ;
		op_ctrl <= instr_code[14:12];
		op_switch <= (opcode == `OP_ALUI && opcode == `OP_ALUI) || instr_code[30];
		case (instr_code[6:0]) //instr_code[6:0] == opcode
			`OP_LUI:			imm <= {instr_code[31:12],12'b0};
			`OP_AUIPC:		imm <= {instr_code[31:12],12'b0};
			`OP_JAL:			imm <= {{12{instr_code[31]}},instr_code[19:12],instr_code[20],instr_code[30:21],1'b0};
			`OP_JALR:		imm <= {{21{instr_code[31]}},instr_code[30:20]};
			`OP_BRANCH:		imm <= {{20{instr_code[31]}},instr_code[7],instr_code[30:25],instr_code[11:8],1'b0};
			`OP_LOAD:		imm <= {{21{instr_code[31]}},instr_code[30:20]};
			`OP_STORE:		imm <= {{21{instr_code[31]}},instr_code[30:25],instr_code[11:7]};
			`OP_ALUI:		imm <= {{21{instr_code[31]}},instr_code[30:20]};		
			default : 		imm <= 32'h0;
		endcase
		we <= (instr_code[6:0] == `OP_LUI)||(instr_code[6:0] == `OP_JAL)||(instr_code[6:0] == `OP_JALR)||(instr_code[6:0] == `OP_ALUI)||(instr_code[6:0] == `OP_ALU);
	end
end


endmodule


`default_nettype wire