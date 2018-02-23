`ifndef DEF
`define DEF


`define WF_WIDTH 7

`define INST_BASE_ADDR	32'h0000_0000
`define OP_LUI 		5'b01101
`define OP_AUIPC 	5'b00101
`define OP_JAL		5'b11011
`define OP_JALR		5'b11001
`define OP_BRANCH	5'b11000
`define OP_LOAD		5'b00000
`define OP_STORE	5'b01000
`define OP_ALUI		5'b00100
`define OP_ALU		5'b01100
`define OP_MULDIV	5'b01100
`define OP_LOAD_FP	5'b00001
`define OP_STORE_FP	5'b01001
`define OP_FP 		5'b10100
`define OP_LOAD_IO  5'b00010
`define OP_STORE_IO 5'b01010

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

`define F5_FADD		5'b00000
`define F5_FSUB		5'b00001
`define F5_FMUL		5'b00010
`define F5_FDIV		5'b00011
`define F5_FSQRT	5'b01011
`define F5_FSGNJ 	5'b00100
`define F5_FTOI 	5'b11000 //and floor
`define F5_FTOX 	5'b11100
`define F5_FCMP 	5'b10100
`define F5_ITOF 	5'b11010
`define F5_XTOF 	5'b11110

`define F3_FEQ 		3'b010
`define F3_FLT 		3'b001
`define F3_FLE 		3'b000

`define F3_RNE   	3'b000
`define F3_RDN		3'b010


`define F3_FSGNJ 	3'b000
`define F3_FSGNJN	3'b001
`define F3_FSGNJX	3'b010




`define PC_BASE 32'h0000_0000

`endif