#ifndef _OPCODE
#define _OPCODE

//opcode
#define OP_LUI 		   0b0110111
#define OP_AUIPC       0b0010111
#define OP_JAL		   0b1101111
#define OP_JALR		   0b1100111
#define OP_BRANCH	   0b1100011
#define OP_LOAD		   0b0000011
#define OP_STORE	   0b0100011
#define OP_ALUI		   0b0010011
#define OP_ALU		   0b0110011
// #define OP_MULDIV	   0b0110011
#define OP_LOAD_FP     0b0000111
#define OP_STORE_FP    0b0100111
#define OP_FP          0b1010011
#define OP_HLT		   0b0000001


//funct3_branch
#define B_EQ 		0b000
#define B_NE 		0b001
#define B_LT 		0b100
#define B_GE 		0b101
#define B_LTU 		0b110
#define B_GEU 		0b111


//funct3_load
#define LOAD_BYTE_S 0b000
#define LOAD_HALF_S	0b001
#define LOAD_WORD    0b010
#define LOAD_BYTE_Z	0b100
#define LOAD_HALF_Z	0b101


//funct3_store
#define STORE_BYTE  0b000
#define STORE_HALF	0b001
#define STORE_WORD	0b010

// funct3_alu
#define ALU_ADD 	0b000 // ALU_SUB
#define ALU_SLL 	0b001
#define ALU_SLT 	0b010
#define ALU_SLTU 	0b011
#define ALU_XOR 	0b100
#define ALU_SRX 	0b101 //ALU_SRA and ALU_SRL
#define ALU_OR 		0b110
#define ALU_AND 	0b111



// funct3 fcmp
#define F3_FEQ    0b010
#define F3_FLT    0b001
#define F3_FLE    0b000

// funct3 fsgnj
#define F3_FSGNJ 	0b000	//fmv
#define F3_FSGNJN	0b001   //fneg
#define F3_FSGNJX	0b010   //fabs



// funct5 for fp
#define F5_FADD   0b00000
#define F5_FSUB   0b00001
#define F5_FMUL   0b00010
#define F5_FDIV   0b00011
#define F5_FSQRT  0b01011
#define F5_FSGNJ  0b00100
#define F5_FTOI   0b11000 //and floor
#define F5_FTOX   0b11100
#define F5_FCMP   0b10100
#define F5_ITOF   0b11010
#define F5_XTOF   0b11110


#endif


