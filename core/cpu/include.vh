`ifndef DEF

`define DEF 		1'b1
`define OP_LUI 		7'b0110111
`define OP_AUIPC 	7'b0010111
`define OP_JAL		7'b1101111
`define OP_JALR		7'b1100111
`define OP_BRANCH	7'b1100011
`define OP_LOAD		7'b0000011
`define OP_STORE	7'b0100011
`define OP_ALUI		7'b0010011
`define OP_ALU		7'b0110011
`define OP_MULDIV	7'b0110011

`define B_EQ 		3'b000
`define B_NE 		3'b001
`define B_LT 		3'b100
`define B_GE 		3'b101
`define B_LTU 		3'b110
`define B_GEU 		3'b111

`define ALU_ADD 	3'b000 // ALU_SUB
`define ALU_SLL 	3'b001
`define ALU_SLT 	3'b010
`define ALU_SLTU 	3'b011
`define ALU_XOR 	3'b100
`define ALU_SRX 	3'b101 //ALU_SRA and ALU_SRL
`define ALU_OR 		3'b110
`define ALU_AND 	3'b111

`define STORE_BYTE  3'b000
`define STORE_HALF	3'b001
`define STORE_WORD	3'b010

`define LOAD_BYTE_S 3'b000
`define LOAD_HALF_S	3'b001
`define LOAD_WORD	3'b010
`define LOAD_BYTE_Z	3'b100
`define LOAD_HALF_Z	3'b101


`define STATE_IDLE  3'd0
`define STATE_FD  	3'd1
`define STATE_DE  	3'd2
`define STATE_EW  	3'd3
`define STATE_WF  	3'd4
`define STATE_STOP  3'd5

`define PC_BASE 32'b0

`endif