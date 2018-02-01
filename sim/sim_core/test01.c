/*

2進数読み込みのチェック


*/






#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "include.h"


	int main(int argc, char const * argv[]) {

		log_fp = stderr;
		srand((unsigned)time(NULL));
		uint32_t opcodes[15] = {
			OP_LUI 		  ,
			OP_AUIPC	  ,
			OP_JAL		  ,
			OP_JALR		  ,
			OP_BRANCH	  ,
			OP_LOAD		  ,
			OP_STORE	  ,
			OP_ALUI		  ,
			OP_ALU		  ,
			OP_LOAD_FP    ,
			OP_STORE_FP   ,
			OP_FP         ,
			OP_LOAD_IO	  ,
			OP_STORE_IO	  ,
			OP_HLT
		};

		Instr instr = NULL;
		instr = initialize_instr();
		int imm, funct3, funct5;

		int next = 0;
		for (int i = 0; i < 15;) {
			instr->opcode = opcodes[i];
			if (next == 3)imm = funct3 = funct5 = next = 0;

			switch (opcodes[i]) {
				case OP_LUI:
					next++; break;
				case OP_AUIPC:
					next++; break;
				case OP_JAL:
					next++; break;
				case OP_JALR:
					next++; break;
				case OP_BRANCH:
					funct3 = B_EQ;
					next++; break;
				case OP_LOAD:
					funct3 = LOAD_WORD;
					next++; break;
				case OP_STORE:
					funct3 = STORE_WORD;
					next++; break;
				case OP_ALUI:
					next++; break;
				case OP_ALU:
					next++; break;
				case OP_LOAD_FP:
					funct3 = LOAD_WORD;
					next++; break;
				case OP_STORE_FP:
					funct3 = STORE_WORD;
					next++; break;
				case OP_FP:
					next++; break;
				case OP_LOAD_IO:
					next++; break;
				case OP_STORE_IO:
					next++; break;
				case OP_HLT:
					next++; break;
				default: break;

			}


			instr->rs1    = (int)(rand() % 32);
			instr->rs2    = (int)(rand() % 32);
			instr->rd     = (int)(rand() % 32);
			instr->imm    = rand() >> 20;
			instr->funct3 = funct3;
			instr->funct5 = funct5;

			print_instr(instr);
			putchar('\n');
			instr->machine_code = create_machine_code(instr);
			Instr i2 = create_instr(instr->machine_code);
			print_instr(i2);
			printf("\n%d\n%d", instr->funct3, i2->funct3);

			putchar('\n');
			if (next == 3)i++;
		}
		free(instr);
		return 0;
	}