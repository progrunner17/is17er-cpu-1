#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "include.h"


uint32_t insert_code(Instr i, int option) {
	uint32_t code = 0;

	if (option & CODE_OP) {
		code |= i->opcode;
	}

	if (CODE_RS1 & option) {
		if(i->rs1 != -1)code |= (i->rs1 & 0b11111) << 15;
		if (i->rs1 > 31)fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of rs1:%d\n", i->rs1);
	}

	if (CODE_RS2 & option) {
		if(i->rs2 != -1)code |= (i->rs2 & 0b11111) << 20;
		if (i->rs2 > 31)fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of rs2:%d\n", i->rs1);
	}
	if (CODE_RD & option) {
		if(i->rd != -1)code |= (i->rd & 0b11111) << 7;
		if (i->rd > 31)fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of rd:%d\n", i->rd);
	}

	if (CODE_F3 & option) {
		if(i->funct3 != -1)code |= (i->funct3 & 0b111) << 12 ;
		if (i->funct3 > 7)fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of funct3:%d\n", i->funct3);
	}

	if (CODE_F5 & option) {
		if(i->funct5 != -1)code |= ((i->funct5 &  0b11111) << 27 );
		if(i->is_sra_sub)code |= 1<<30;
		if (i->funct5 >= (1 << 5))fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of funct5:%d\n", i->funct5);

	}
	if (CODE_IMM_U & option) {
		code |= i->imm << 12;
		if (i->imm >= 1 << 20)fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of imm:%d\n", i->imm);
	}
	if (CODE_IMM_J & option) {
		code |= i->imm << 12;
		if (i->imm >= 1 << 20)fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of imm:%d\n", i->imm);
	}
	if (CODE_IMM_I & option) {
		code |= i->imm << 20;
		if (i->imm >= 1 << 20)fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid value of imm:%d\n", i->imm);

	}
	if (CODE_IMM_B & option) {
		code |= (i->imm & 0b11111) << 7;
		code |= (( unsigned int )i->imm >> 5 ) << 25;

	}

	if (CODE_IMM_S & option) {
		code |= (i->imm & 0b11111) << 7;
		code |= (( unsigned int )i->imm >> 5 ) << 25;

	}

	return code;

}

uint32_t create_machine_code(Instr i) {

	uint32_t code = 0;

	switch (i->opcode) {
		case OP_LUI:
		case OP_AUIPC:
			code = insert_code(i , CODE_OP | CODE_RD | CODE_IMM_U);
			break;
		case OP_JAL:
			code = insert_code(i, CODE_OP | CODE_RD | CODE_IMM_J);
			break;
		case OP_JALR:
			code = insert_code(i, CODE_OP | CODE_RD | CODE_RS1 | CODE_IMM_I | CODE_F3);
			break;
		case OP_BRANCH:
			code = insert_code(i, CODE_OP | CODE_RS1 | CODE_RS2 | CODE_IMM_B | CODE_F3);
			break;
		case OP_STORE:
		case OP_STORE_FP:
		case OP_STORE_IO:
			code = insert_code(i, CODE_OP | CODE_RS2 | CODE_RS1 | CODE_IMM_S | CODE_F3);
			break;
		case OP_LOAD:
		case OP_LOAD_FP:
		case OP_LOAD_IO:
			code = insert_code(i, CODE_OP | CODE_RD | CODE_RS1 | CODE_F3 | CODE_IMM_I);
			break;
		case OP_ALU:
			switch (i->funct3) {
				case ALU_ADD:
				case ALU_SRX:
					code = insert_code(i, CODE_OP | CODE_RD | CODE_RS1 | CODE_RS2 | CODE_F3 | CODE_F5);
					break;
				default:
					code = insert_code(i, CODE_OP | CODE_RD | CODE_RS1 | CODE_RS2 | CODE_F3);
			}
			break;
		case OP_ALUI:
			switch (i->funct3) {
				case ALU_SRX:
					code = insert_code(i, CODE_OP | CODE_RD | CODE_RS1 | CODE_IMM_I | CODE_F3 | CODE_F5);
					break;
				default:
					code = insert_code(i, CODE_OP | CODE_RD | CODE_RS1 | CODE_IMM_I | CODE_F3);
			}		break;
		case OP_FP:
			code = insert_code(i, CODE_OP | CODE_RD | CODE_RS1 | CODE_RS2 | CODE_F3 | CODE_F5);
			break;
		case OP_HLT:
			code = 0;break;
		case OP_ABORT:
			code = 1;break;

		default: fprintf(stderr, "[ERROR]@create_machine_code:\tinvalid opcode\n");
	}

	return code;
}


/*
 +----
 |  3                   2                 1                   0|
 |1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1|
 |

*/
uint32_t parce_binary(void){
char c = 0;

uint32_t n = 0;
while((c = getchar()) != EOF ){
	if(c == ',' )break;
	else if(c == '0' || c == '1') n =  n<<1;
	if(c == '1') n |= 0b1;

}






return n;

}


Instr create_instr(uint32_t code) {

	Instr instr = initialize_instr();
	uint32_t opcode  = 0;
	opcode = (code & 0b1111111);
	instr->opcode = opcode;
	if(opcode == OP_HLT || opcode == OP_ABORT)return instr;
// opcode check
	switch (opcode) {
		case OP_LUI:
		case OP_AUIPC:
		case OP_JAL:
		case OP_JALR:
		case OP_BRANCH:
		case OP_LOAD:
		case OP_STORE:
		case OP_ALUI:
		case OP_ALU:
		case OP_LOAD_FP :
		case OP_STORE_FP:
		case OP_FP      :
		case OP_LOAD_IO:
		case OP_STORE_IO:
		case OP_HLT:
		case OP_ABORT:
			break;
		default: fprintf(stderr, "[ERROR]@create_instr:\tinvalid opcode\n");
			break;
	}

	// fuct5
	switch (opcode) {
		case OP_FP:
			instr->funct5 = code>>27;break;
		default: break;
	}

	// funct3
	switch (opcode) {
		// case OP_LUI:
		// case OP_AUIPC:
		// case OP_JAL:
		case OP_JALR:
		case OP_BRANCH:
		case OP_LOAD:
		case OP_STORE:
		case OP_ALUI:
		case OP_ALU:
		case OP_LOAD_FP :
		case OP_STORE_FP:
		case OP_FP      :
		case OP_LOAD_IO:
		case OP_STORE_IO:
		case OP_HLT:
			instr->funct3  = (code >> 12) & 0b111;break;
		default: break;
	}

	// is_sub_rsa
	switch (opcode) {
		case OP_ALUI:
			if( instr->funct3 == ALU_SRX) instr->is_sra_sub =  (code & (1<<30)) != 0;
		break;
		case OP_ALU:
			if(instr->funct3 == ALU_ADD || instr->funct3 == ALU_SRX)instr->is_sra_sub =  (code & (1<<30)) != 0;
		default: break;
	}


	// rd
	switch (opcode) {
		case OP_LUI:
		case OP_AUIPC:
		case OP_JAL:
		case OP_JALR:
		// case OP_BRANCH:
		case OP_LOAD:
		// case OP_STORE:
		case OP_ALUI:
		case OP_ALU:
		case OP_LOAD_FP :
		// case OP_STORE_FP:
		case OP_FP      :
		case OP_LOAD_IO:
		// case OP_STORE_IO:
		case OP_HLT:
			instr->rd  = (code >> 7) & 0b11111;break;
		default: break;
	}


	// rs1
	switch (opcode) {
		// case OP_LUI:
		// case OP_AUIPC:
		// case OP_JAL:
		case OP_JALR:
		case OP_BRANCH:
		case OP_LOAD:
		case OP_STORE:
		case OP_ALUI:
		case OP_ALU:
		case OP_LOAD_FP :
		case OP_STORE_FP:
		case OP_FP:
		case OP_LOAD_IO:
		case OP_STORE_IO:
		case OP_HLT:
			instr->rs1  = (code >> 15) & 0b11111;
		default: break;
	}

	// rs2
	switch (opcode) {
		case OP_LUI:
		case OP_AUIPC:
		case OP_JAL:
		case OP_JALR:
		case OP_BRANCH:
		// case OP_LOAD:
		case OP_STORE:
		// case OP_ALUI:
		case OP_ALU:
		// case OP_LOAD_FP :
		case OP_STORE_FP:
		case OP_FP      :
		// case OP_LOAD_IO:
		case OP_STORE_IO:
		case OP_HLT:
			instr->rs2  = (code >> 20) & 0b11111;
		default: break;
	}
	// imm
	switch (opcode) {
		case OP_LUI:
		case OP_AUIPC:
		case OP_JAL:
			instr->imm  = ((int)code)>>12;break;
		case OP_JALR:
		case OP_LOAD:
		case OP_ALUI:
			if(instr->is_sra_sub){
						instr->imm  = (((int)code)>>20) & 0b11111;break;
				}
		case OP_LOAD_FP :
			instr->imm  = ((int)code)>>20;break;

		case OP_BRANCH:
		case OP_STORE:
		case OP_STORE_FP:
		    instr->imm = ((((int)code)>>7)&0b11111) |((((int)code)>>25)<<5);break;
		// case OP_ALU:
		// case OP_FP      :
		// case OP_LOAD_IO:
		// case OP_STORE_IO:
		// case OP_HLT:
		default: break;
	}
	return instr;
}



void print_machine_code(FILE *fp, uint32_t code, int option) {
	if (option & PRINT_CODE_TXT_HEX) {
		fprintf(fp, "%8x\n", code);
	}
	if (option & PRINT_CODE_BIN) {
		fwrite(&code, 4, 1, fp);
	}
}

