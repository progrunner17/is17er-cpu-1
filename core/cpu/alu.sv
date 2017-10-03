`default_nettype none

`include "include.vh"
module alu (
	input wire [31:0]op1,
	input wire [31:0]op2,
	input wire [2:0] op_ctrl,
	input wire op_switch,
	output wire [31:0]alu_result
);
wire slt,sltu;
wire is_sub;
assign slt = $signed(op1) < $signed(op2);
assign sltu = op1 < op2;

assign alu_result = (op_ctrl == `ALU_ADD) ? (op_switch ? op1 + op2: op1 - op2) :
				(op_ctrl == `ALU_SLL) ?  op1 << op2:
				(op_ctrl == `ALU_SLT) ?  {31'b0,slt}:
				(op_ctrl == `ALU_SLTU) ? {31'b0,sltu}:
				(op_ctrl == `ALU_XOR) ?  op1 ^ op2:
				(op_ctrl == `ALU_SRX) ?  (op_switch ? op1 >> op2 : $signed(op1) >>> op2 ):
				(op_ctrl == `ALU_OR) ?  op1 || op2:
				(op_ctrl == `ALU_AND) ? op1 && op2 : 32'b0 ;
endmodule

`default_nettype wire