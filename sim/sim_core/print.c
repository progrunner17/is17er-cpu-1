#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "include.h"
#include "opcode.h"
#include "size.h"
// 3つの判定値からニーモニックを復元。逆アセンブリ用?
void print_mnemonic(int opcode,int funct3,int is_sra_sub){
	if(opcode == OP_LUI){
		printf("lui");
	}else if (opcode == OP_AUIPC) {
		printf("aupic");
	}else if (opcode == OP_JAL) {
		printf("jal");
	}else if (opcode == OP_JALR) {
		printf("jalr");
	}else if (opcode == OP_BRANCH){
		if(funct3 == B_EQ){
			printf("beq");
		}else if (funct3 == B_NE) {
			printf("bne");
		}else if (funct3 == B_LT) {
			printf("blt");
		}else if (funct3 == B_GE) {
			printf("bge");
		}else if (funct3 == B_LTU) {
			printf("bltu");
		}else if (funct3 == B_GEU) {
			printf("bgeu");
		}
	}else if (opcode == OP_LOAD) {
		if(funct3 == LOAD_BYTE_S){
			printf("lb");
		}else if(funct3 == LOAD_HALF_S){
			printf("lh");
		}else if(funct3 == LOAD_WORD){
			printf("lw");
		}else if(funct3 == LOAD_BYTE_Z){
			printf("lbu");
		}else if(funct3 == LOAD_HALF_Z){
			printf("lhu");
		}
	}else if (opcode == OP_STORE) {
		if(funct3 == STORE_BYTE){
			printf("sb");
		}else if(funct3 == STORE_HALF){
			printf("sh");
		}else if (funct3 == STORE_WORD) {
			printf("sw");
		}
	}else if (opcode == OP_ALUI) {
		if(funct3 == ALU_ADD){
			printf("addi");
		}else if (funct3 == ALU_SLL) {
			printf("slli");
		}else if (funct3 == ALU_SLT) {
			printf("slti");
		}else if (funct3 == ALU_SLTU) {
			printf("sltui");
		}else if (funct3 == ALU_XOR) {
			printf("xori");
		}else if (funct3 == ALU_SRX && is_sra_sub == 0) {
			printf("srli");
		}else if (funct3 == ALU_SRX && is_sra_sub == 1) {
			printf("srai");
		}else if (funct3 == ALU_OR) {
			printf("ori");
		}else if (funct3 == ALU_AND) {
			printf("andi");
		}
	}else if (opcode == OP_ALU) {
		if((funct3 == ALU_ADD) && (is_sra_sub == 0)){
			printf("add");
		}else if((funct3 == ALU_ADD) && (is_sra_sub == 1)){
			printf("sub");
		}else if (funct3 == ALU_SLL) {
			printf("sll");
		}else if (funct3 == ALU_SLT) {
			printf("slt");
		}else if (funct3 == ALU_SLTU) {
			printf("sltu");
		}else if (funct3 == ALU_XOR) {
			printf("xor");
		}else if (funct3 == ALU_SRX && is_sra_sub == 0) {
			printf("srl");
		}else if (funct3 == ALU_SRX && is_sra_sub == 1) {
			printf("sra");
		}else if (funct3 == ALU_OR) {
			printf("or");
		}else if (funct3 == ALU_AND) {
			printf("and");
		}
	}else{
		printf("err!!!!!!!!!!!!!!!!!!!!!!\n");
	}
}










// 命令をプリント
void print_instr(Instr instr){

	if(instr == NULL){
		fprintf(stderr,"invalid instr\n");
		return;
	}
	// printf("%s ",instr->mnenonic); //opcode,funct3,及びis_sra_subで置き換え
	print_mnemonic(instr->opcode,instr->funct3,instr->is_sra_sub);
	putchar(' ');

	if(instr->opcode == OP_LUI){
		printf("x%d, %d",instr->rd,instr->imm);
	}else if(instr->opcode == OP_AUIPC){
		printf("x%d, %d",instr->rd,instr->imm);
	}else if(instr->opcode == OP_JAL){
		printf("x%d, %d\t//label: %s",instr->rd,instr->imm,instr->label);
	}else if(instr->opcode == OP_JALR){
		printf("x%d, x%d, %d",instr->rd,instr->rs1,instr->imm);
	}else if(instr->opcode == OP_BRANCH){
		printf("x%d, x%d, %d",instr->rs1,instr->rs2,instr->imm);
	}else if(instr->opcode == OP_LOAD){
		printf("x%d, %d(x%d)",instr->rd,instr->imm,instr->rs1);
	}else if(instr->opcode == OP_STORE){
		printf("x%d, %d(x%d)",instr->rs2,instr->imm,instr->rs1);
	}else if(instr->opcode == OP_ALUI){
		printf("x%d, x%d, %d",instr->rd,instr->rs1,instr->imm);
	}else if(instr->opcode == OP_ALU){
		printf("x%d, x%d, x%d",instr->rd,instr->rs1,instr->rs2);
	}
	putchar('\n');
}


void print_reg(Reg reg,int opt){
	printf("レジスタ値一覧\n");
	if(opt && PRINT_REG_PC)
		printf("pc:\t%08x\n\n", reg->pc);
	if(opt & PRINT_REG_X_D){
		for(int i = 0; i<32 ;i++){
			printf("x%d:\t%12d\t",i,reg->x[i]);
			if(i%2) putchar('\n');
		}
		putchar('\n');
	}

	if(opt & PRINT_REG_X_X){
		for(int i = 0; i<32 ;i++){
			printf("x%d:\t%08d\t",i,reg->x[i]);
			if(i%2) putchar('\n');
		}
		putchar('\n');
	}
	if(opt & PRINT_REG_F){
		for(int i = 0; i<32 ;i++){
			printf("x%d:\t%f\t",i,reg->f[i]);
			if(i%2) putchar('\n');
		}
		putchar('\n');
	}

}


void print_memory(word *memory,int start,int n){

	int pc = 0;
	for(int i = start - BASE_ADDR; i< start + n ;i++){
		pc = i + BASE_ADDR;

		printf("0x%08x: %08x\t",pc,memory[i]);

		if((i+1)%8 == 0) putchar('\n');

	}

	putchar('\n');
};



void print_prgram(Program program){
int pc = BASE_ADDR;

	for(int i = 0;program[i] != NULL;i++){
		pc = i + BASE_ADDR;
		printf("pc:%08x\t", pc);
		print_instr(program[i]);
	}
}

void fprint_bin(FILE *fp,int d,int max,int min){
	int b = 0;
	for(int i = max ; i >= min; i--){
		b = ((1 << i) & d) != 0 ? 1 : 0;
		fputc('0' + b,fp);
	}
}



void print_help(void){
	FILE *fp =fopen("readme.txt","r");
	char line[128];
	fgets(line,128,fp);
	puts(line);
}