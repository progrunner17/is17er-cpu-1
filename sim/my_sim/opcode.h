//五反田くんのコードのコピペ(F7だけ書き換えor追加)

#ifndef _OPCODE
#define _OPCODE

//opcode
#define OP_LUI 		   0b0110111//55
#define OP_AUIPC	   0b0010111//23
#define OP_JAL		   0b1101111//111
#define OP_JALR		   0b1100111//103
#define OP_BRANCH	   0b1100011//99
#define OP_LOAD		   0b0000011//3
#define OP_STORE	   0b0100011//35
#define OP_ALUI		   0b0010011//19
#define OP_ALU		   0b0110011//51
#define OP_LOAD_FP     0b0000111//7
#define OP_STORE_FP    0b0100111//39
#define OP_FP          0b1010011//83
#define OP_LOAD_IO	   0b0001011//11
#define OP_STORE_IO	   0b0101011//43
#define OP_HLT		   0b0000000//0



//funct3_branch
#define B_EQ 		0b000//0
#define B_NE 		0b001//1
#define B_LT 		0b100//4
#define B_GE 		0b101//5
#define B_LTU 		0b110//6
#define B_GEU 		0b111//7


//funct3_load
#define LOAD_BYTE_S 0b000//0
#define LOAD_HALF_S	0b001//1
#define LOAD_WORD    0b010//2
#define LOAD_BYTE_Z	0b100//4
#define LOAD_HALF_Z	0b101//5


//funct3_store
#define STORE_BYTE      0b000//0
#define STORE_HALF	0b001//1
#define STORE_WORD	0b010//2

// funct3_alu(aluiも同じ)
#define ALU_ADD 	0b000//0 // ALU_SUB
#define ALU_SLL 	0b001//1
#define ALU_SLT 	0b010//2
#define ALU_SLTU 	0b011//3
#define ALU_XOR 	0b100//4
#define ALU_SRX 	0b101//5  //ALU_SRA and ALU_SRL
#define ALU_OR 		0b110//6
#define ALU_AND 	0b111//7



// funct3 fcmp
#define F3_FEQ    0b010//2
#define F3_FLT    0b001//1
#define F3_FLE    0b000//0

// funct3 fsgnj
#define F3_FSGNJ 	0b000//0	//fmv
#define F3_FSGNJN	0b001//1   //fneg
#define F3_FSGNJX	0b010//2   //fabs

//  funct3 frm

#define F3_RNE 0b000//0   //ftoi
#define F3_RTZ 0b001//1
#define F3_RDN 0b010//2  //floor
#define F3_RUP 0b011//3



// funct7 for fp
#define F7_FADD   0b0000000//0
#define F7_FSUB   0b0000100//4
#define F7_FMUL   0b0001000//8
#define F7_FDIV   0b0001100//12
#define F7_FSQRT  0b0101100//44
#define F7_FSGNJ  0b0010000//16
#define F7_FTOI   0b1100000//96 //and floor
#define F7_FTOX   0b1110000//112
#define F7_FCMP   0b1010000//80
#define F7_ITOF   0b1101000//104
#define F7_XTOF   0b1111000//120

//funct7
#define F7_ADD  0b0000000//0
#define F7_SUB  0b0100000//32
#define F7_SRL  0b0000000//0
#define F7_SRA  0b0100000//32

#endif


