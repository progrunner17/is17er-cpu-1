`default_nettype none

`include "./include.vh"
module alu
(op1,op2,funct3,is_sub_sra,alu_result);
	input wire [31:0]op1;
	input wire [31:0]op2;
	input wire [2:0] funct3;
	input wire is_sub_sra;
	output wire [31:0]alu_result;




wire slt,sltu;
assign slt = $signed(op1) < $signed(op2);
assign sltu = $unsigned(op1) < $unsigned(op2);

wire [31:0] sll,sra,srl;
assign sra = $signed(op1) >>> $unsigned(op2[4:0]) ;
assign srl = op1 >> $unsigned(op2[4:0]);
assign sll = op1 << $unsigned(op2[4:0]);



assign alu_result = (funct3 == `ALU_ADD) ? (is_sub_sra ? op1 - op2: op1 + op2) :
					(funct3 == `ALU_SLL) ?  sll:
					(funct3 == `ALU_SLT) ?  {31'b0,slt}:
					(funct3 == `ALU_SLTU) ? {31'b0,sltu}:
					(funct3 == `ALU_XOR) ?  op1 ^ op2:
                	(funct3 == `ALU_SRX ) ? (is_sub_sra ?  sra : srl):
					(funct3 == `ALU_OR) ?  op1 | op2:
					(funct3 == `ALU_AND) ? op1 & op2 : 32'hXXXX_XXXX ;
endmodule

`default_nettype wire