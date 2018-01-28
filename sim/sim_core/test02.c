#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "include.h"


int instr_eq(Instr i1, Instr i2) {
	int error = 0;

	if (i1->opcode != i2->opcode) {
		error = 1;
	} else {
		switch (i1->opcode) {
			case OP_LUI:
			case OP_AUIPC:
			case OP_JAL:						//opcode rd, label
				error = i1->rd != i2->rd ||
				        i1->imm != i2->imm;
				break;
			case OP_JALR:						//opcode rd, rs1, label
				error = i1->rd != i2->rd ||
				        i1->imm != i2->imm ||
				        i1->rs1 != i2->rs1 ||
				        i1->funct3 != 0 ||
				        i2->funct3 != 0;
				break;
			case OP_BRANCH:						//opcode rs1, rs2, imm (immはオフセット)
				error = i1->rd != i2->rd ||
				        i1->imm != i2->imm ||
				        i1->rs1 != i2->rs1 ||
				        i1->rs2 != i2->rs2 ||
				        i1->funct3 != i2->funct3;
				break;
			case OP_LOAD:
			case OP_LOAD_FP:
				error = i1->rd != i2->rd ||
				        i1->imm != i2->imm ||
				        i1->rs1 != i2->rs1 ||
				        i1->funct3 != i2->funct3;
				break;
			case OP_STORE:
			case  OP_STORE_FP:
				error = i1->imm != i2->imm ||
				        i1->rs1 != i2->rs1 ||
				        i1->rs2 != i2->rs2 ||
				        i1->funct3 != i2->funct3;
				break;
			case OP_ALUI :
				error = i1->rd != i2->rd ||
				        i1->imm != i2->imm ||
				        i1->rs1 != i2->rs1 ||
				        i1->funct3 != i2->funct3 ||
				        i1->is_sra_sub != i2->is_sra_sub;

				break;
			case OP_ALU:						//opcode rd, rs1, rs2
				error = i1->rd != i2->rd ||
				        i1->rs1 != i2->rs1 ||
				        i1->rs2 != i2->rs2 ||
				        i1->funct3 != i2->funct3 ||
				        i1->is_sra_sub != i2->is_sra_sub;
				break;
			case OP_FP:
				error = i1->funct5 != i2->funct5;

				switch (i1->funct5) {
					case  F5_FADD:
					case  F5_FSUB:
					case  F5_FMUL:
					case  F5_FDIV:
						error = i1->rd != i2->rd ||
						        i1->rs1 != i2->rs1 ||
						        i1->rs2 != i2->rs2;
						break;
					case  F5_FSQRT:
						error = i1->rd != i2->rd ||
						        i1->rs1 != i2->rs1 ;						break;
					case  F5_FCMP:
						error = i1->rd != i2->rd ||
						        i1->rs1 != i2->rs1 ||
						        i1->rs2 != i2->rs2 ||
						        i1->funct3 != i2->funct3;
						break;
					case F5_FSGNJ:
						error = i1->rd != i2->rd ||
						        i1->rs1 != i2->rs1 ||
						        i1->rs2 != i2->rs2 ||
						        i1->funct3 != i2->funct3;
						break;
					case  F5_FTOI: {
							error = i1->rd != i2->rd ||
							        i1->rs1 != i2->rs1 ||
							        i1->funct3 != i2->funct3;
						} break;
					case  F5_FTOX:
					case  F5_ITOF:
					case  F5_XTOF:
						error = i1->rd != i2->rd ||
						        i1->rs1 != i2->rs1 ||
						        i1->funct3 != i2->funct3;
						break;
					default:
						fprintf(stderr, "invalid operation of F_OP\n");
						error = 1;
						break;
				}

				break;
			case OP_STORE_IO : 
					error = i1->rs1 != i2->rs1;
					break;
			case OP_LOAD_IO :
					error = i1->rd != i2->rd;
					break;
			}
		}
		if(error){

			printf("i1:");print_instr(i1);putchar('\n');
			printf("i2:");print_instr(i2);putchar('\n');
			printf("i1_rs1:         %d\n",i1->rs1);
			printf("i2_rs1:         %d\n",i2->rs1);
			printf("i1_rs2:         %d\n",i1->rs2);
			printf("i2_rs2:         %d\n",i2->rs2);
			printf("i1_rd:          %d\n",i1->rd);
			printf("i2_rd:          %d\n",i2->rd);
			printf("i1_imm:         %d\n",i1->imm);
			printf("i2_imm:         %d\n",i2->imm);
			printf("i1_funct3:      %d\n",i1->funct3);
			printf("i2_funct3:      %d\n",i2->funct3);
			printf("i1_fucnt5:      %d\n",i1->funct5);
			printf("i2_fucnt5:      %d\n",i2->funct5);
			printf("i1_is_sra_sub:  %d\n",i1->is_sra_sub);
			printf("i2_is_sra_sub:  %d\n",i2->is_sra_sub);
		}
		return error;
	}
int main(int argc, char const *argv[])
{

	log_fp = stderr;
	LList llist = initialize_llist();
	uint32_t  code = 0;
	Program program = NULL;
	program =  load_asm_file("../../min-caml/raytracer/min-rt.s",llist);
	program =  load_asm_file("./src/min-rt.s",llist);
	for(int i = 0;program[i] != NULL;i++){
		code = create_machine_code(program[i]);
		if(instr_eq(program[i],create_instr(code))) {
			printf("pc:%d\n",i);
			return 0;
		}
	}
	return 0;
}