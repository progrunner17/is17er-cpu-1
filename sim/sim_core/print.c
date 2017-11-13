#include <stdio.h>
#include <stdarg.h>
#include "include.h"
#include "opcode.h"
#include "size.h"


extern FILE *log_fp;
extern Runtime runtime;

// // print.c
// void  print_labels(LList label_list);
// void  print_instr(Instr instr);
// void  print_mnemonic(Instr i);
// void  print_prgram(Program program);
// void  print_memory(word *memory,int start, int n);
// void  print_reg(Reg reg,int opt);
// void print_binary(int d);
// void fprint_bin(FILE *fp,int d,int max,int min);
// void print_error(char *format, ...);
// void print_log(char *format, ...);

void print_mnemonic(Instr i) {
	if(i == NULL){
		fprintf(log_fp,"[ERROR]@print_mnemonic:\tNULL pointer\n");
		return;
	}
	switch (i->opcode) {
	case OP_LUI: printf("lui"); break;
	case OP_AUIPC: printf("auipc"); break;
	case OP_JAL: printf("jal"); break;
	case OP_JALR: printf("jalr"); break;
	case OP_BRANCH:
		switch (i->funct3) {
		case B_EQ: printf("beq"); break;
		case B_NE: printf("bne"); break;
		case B_LT: printf("blt"); break;
		case B_GE: printf("bge"); break;
		case B_LTU: printf("bltu"); break;
		case B_GEU: printf("bgeu"); break;
		default:fprintf(log_fp,"[ERROR]@print_mnemonic:\tcase OP_BRANCH:\tinvalid funct3\n");
		}
		break;
	case OP_LOAD:
		switch (i->funct3) {
		case LOAD_BYTE_S: printf("lb"); break;
		case LOAD_HALF_S: printf("lh"); break;
		case LOAD_WORD  : printf("lw"); break;
		case LOAD_BYTE_Z: printf("lbu"); break;
		case LOAD_HALF_Z: printf("lhu"); break;
		}
		break;
	case OP_STORE:
		switch (i->funct3) {
		case STORE_BYTE: printf("sb"); break;
		case STORE_HALF: printf("sh"); break;
		case STORE_WORD: printf("sw"); break;
		}
		break;
	case OP_ALUI:
		switch (i->funct3) {
		case ALU_ADD: printf("addi"); break;
		case ALU_SLL: printf("slli"); break;
		case ALU_SLT: printf("slti"); break;
		case ALU_SLTU: printf("sltui"); break;
		case ALU_XOR: printf("xori"); break;
		case ALU_SRX:
			if (i->is_sra_sub)printf("srai");
			else printf("srli");
			break;
		case ALU_OR: printf("ori"); break;
		case ALU_AND: printf("andi"); break;
		}
		break;
	case OP_ALU:
		switch (i->funct3) {
		case ALU_ADD:
			if (i->is_sra_sub)printf("sub");
			else printf("add");
			break;
		case ALU_SLL: printf("sll"); break;
		case ALU_SLT: printf("slt"); break;
		case ALU_SLTU: printf("sltu"); break;
		case ALU_XOR: printf("xor"); break;
		case ALU_SRX:
			if (i->is_sra_sub)printf("sra");
			else printf("srl");
			break;
		case ALU_OR: printf("or"); break;
		case ALU_AND: printf("and"); break;
			break;
		}
		break;

	case OP_LOAD_FP:
		if (i->funct3 == LOAD_WORD)printf("flw");
		else fprintf(log_fp,"[ERROR]@print_mnemonic:\tcase OP_LOAD_FP:\tonly word is permitted\n");
		break;

	case OP_STORE_FP:
		if (i->funct3 == STORE_WORD)printf("fsw");
		else fprintf(log_fp,"[ERROR]@print_mnemonic:\tcase OP_STORE_FP:\tonly word is permitted\n");
		break;

	case OP_FP:
		switch (i->funct5) {
		case F5_FADD: printf("fadd"); break;
		case F5_FSUB: printf("fsub"); break;
		case F5_FMUL: printf("fmul"); break;
		case F5_FDIV: printf("fdiv"); break;
		case F5_FSQRT: printf("fsqrt"); break;
		case F5_FSGNJ:
			switch (i->funct3) {
			case F3_FSGNJ : printf("fmv"); break;
			case F3_FSGNJN : printf("fneg"); break;
			case F3_FSGNJX : printf("fabs"); break;
			}
			break;
		case F5_FTOI: printf("ftoi"); break;
		case F5_FTOX: printf("ftox"); break;
		case F5_FCMP:
			switch (i->funct3) {
			case F3_FEQ: printf("feq"); break;
			case F3_FLT: printf("flt"); break;
			case F3_FLE: printf("fle"); break;
			}
			break;
		case F5_ITOF: printf("itof"); break;
		case F5_XTOF: printf("xtof"); break;
		}
		break;
	default:
		fprintf(log_fp,"[ERROR]@print_mnemonic:\tinvalid opcode\n");
	}
}

// 命令をプリント
void print_instr(Instr instr) {
	if (instr == NULL) {
		fprintf(log_fp,"[ERROR]@print_instr: NULL pointer\n");
		return;
	}
	// printf("%s ",instr->mnemonic); //opcode,funct3,及びis_sra_subで置き換え
	print_mnemonic(instr);
	putchar(' ');
	switch (instr->opcode) {
	case OP_LUI:
	case OP_AUIPC: printf("x%d, %d", instr->rd, instr->imm); break;
	case OP_JAL: printf("x%d, %d\t//label: %s", instr->rd, instr->imm, instr->label); break;
	case OP_JALR: printf("x%d, x%d, %d", instr->rd, instr->rs1, instr->imm); break;
	case OP_BRANCH: printf("x%d, x%d, %d //label: %s", instr->rs1, instr->rs2, instr->imm, instr->label); break;
	case OP_LOAD: printf("x%d, %d(x%d)", instr->rd, instr->imm, instr->rs1); break;
	case OP_STORE: printf("x%d, %d(x%d)", instr->rs2, instr->imm, instr->rs1); break;
	case OP_ALUI: printf("x%d, x%d, %d", instr->rd, instr->rs1, instr->imm); break;
	case OP_ALU: printf("x%d, x%d, x%d", instr->rd, instr->rs1, instr->rs2); break;
	case OP_STORE_FP: printf("f%d, %d(x%d)", instr->rs2, instr->imm, instr->rs1); break;
	case OP_LOAD_FP: printf("f%d, %d(x%d)", instr->rd, instr->imm, instr->rs1); break;
	case OP_FP:
			switch (instr->funct5) {
			case F5_FADD:
			case F5_FSUB:
			case F5_FMUL:
			case F5_FDIV: printf("f%d, f%d, f%d", instr->rd, instr->rs1, instr->rs2); break;
			case F5_FSQRT:
			case F5_FSGNJ: printf("f%d, f%d", instr->rd, instr->rs1); break;
			case F5_FTOI:
			case F5_FTOX: printf("x%d, f%d", instr->rd, instr->rs1); break;
			case F5_FCMP: printf("x%d, f%d, f%d", instr->rd, instr->rs1, instr->rs2); break;
			case F5_ITOF:
			case F5_XTOF: printf("f%d, x%d", instr->rd, instr->rs1); break;
			}
			break;
	default: fprintf(log_fp,"[ERROR]@print_instr: opcode error\n");
	}
	putchar('\n');
}


void print_reg(Reg reg, int opt) {
	printf("register:\n");
	if (opt && PRINT_REG_PC)
		printf("pc:\t%08x\n\n", reg->pc);


	if (opt & PRINT_REG_X_D) {
		for (int i = 0; i < 32 ; i++) {
			printf("x%d:\t%12d\t", i, reg->x[i]);
			if (i % 2) putchar('\n');
		}
		putchar('\n');
	}

	if (opt & PRINT_REG_X_X) {
		for (int i = 0; i < 32 ; i++) {
			printf("x%d:\t%08x\t", i, reg->x[i]);
			if (i % 2) putchar('\n');
		}
		putchar('\n');
	}
	if (opt & PRINT_REG_F) {
		for (int i = 0; i < 32 ; i++) {
			printf("x%d:\t%f\t", i, reg->f[i]);
			if (i % 2) putchar('\n');
		}
		putchar('\n');
	}

}

void print_memory(word *memory, int base, unsigned int n) {
	int pc = 0;
	for (int i = base; i < base + n ; i++) {
		pc = i + BASE_ADDR;
		printf("0x%08x: %08x\t", pc, memory[i].x);
		if ((i + 1) % 8 == 0) putchar('\n');
	}
	putchar('\n');
};


void print_prgram(Program program) {
	int pc = BASE_ADDR;
	for (int i = 0; program[i] != NULL; i++) {
		pc = i + BASE_ADDR;
		printf("0x%08x:\t", pc);
		print_instr(program[i]);
	}
}

void print_labels(LList llist) {
	if (llist != NULL) {
		printf("0x%08x:  %s\t//line %d\n",  llist->addr,llist->name,llist->line);
		if (llist->next != NULL) print_labels(llist->next);

	}
}


void fprint_bin(FILE *fp, int d, int max, int min) {
	int b = 0;
	printf("0b");
	for (int i = max ; i >= min; i--) {
		b = ((1 << i) & d) != 0 ? 1 : 0;
		fputc('0' + b, fp);
	}
}

void print_help(void) {
	FILE *fp = fopen("readme.txt", "r");
	char line[128];
	fgets(line, 128, fp);
	puts(line);
}


