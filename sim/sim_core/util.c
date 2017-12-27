#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include "include.h"

typedef union {
  int i;
  float f;
  uint32_t u;
  uint8_t b[4];
} fi_union;
int input_index = 0;


extern fi_union sld_words[];
extern uint8_t sld_bytes[];
extern unsigned sld_n_bytes;

int show_all = 1;
int error  = 0;

Runtime runtime = NULL;
struct timespec ts;
double t = 0;
// ラベル関係
// ラベルリストにラベルを追加
LList add_label(const char *name, int pc, int line, LList llist) {
	if (llist == NULL) {
		fprintf(log_fp, "[ERROR]@add_label:\t llist is NULL\n");
		return NULL;
	} else if (llist->next == NULL) {
		fprintf(log_fp,"[LOG]@add_label:\tlabel %s is added to list \n",name);
		fflush(log_fp);
		LList label;
		label = initialize_label();
		label->addr = pc;
		label->line = line;
		strcpy(label->name, name);
		llist->next = label;
		return llist;
	} else {
		return add_label(name, pc, line, llist->next);
	}
}

LList initialize_llist(void) {
	fprintf(log_fp,"[LOG]@initialize_label: called\n");
	LList llist ;
	llist = initialize_label();
	llist->addr = 0;
	llist->line = 0;
	strcpy(llist->name, "top of file");
	return llist;
}

LList initialize_label(void) {
	return calloc(1, sizeof(struct _label));
}

//ラベルの文字列を渡して、アドレスを返す関数
int search_label(const char* name, LList llist) {
	if (llist == NULL) {
		fprintf(log_fp, "[ERROR]@search_label:\t cannot finde label %s\n", name);
		return -1;
	} else if (strcmp(llist->name, name) != 0 ) {
		return search_label(name, llist->next);
	} else { //match
		return llist->addr;
	}
}

// ラベルの解決。
void resolve_label(Instr *program, LList llist) {
	int opcode;
	int label_addr = 0;
	for (int pc = 0; program[pc] != NULL; pc++) {
		opcode = program[pc]->opcode;
		if ((opcode == OP_JAL || opcode == OP_JALR || opcode == OP_BRANCH ) && program[pc]->label) {//ラベルがNULLでないとき
			label_addr = search_label(program[pc]->label, llist);
			program[pc]->imm = label_addr - pc;
			fprintf(log_fp,"[LOG]@resolve_label:label %s corresponds to addr%d\n",program[pc]->label,label_addr);
			fprintf(log_fp,"                   :pc = %d\n then imm = %d\n",pc, program[pc]->imm);
		}
	}
}


void  print_label_of_pc(int pc,LList llist){
	if(llist == NULL) return;
	if(llist->addr == pc)printf("%s\n", llist->name);
	else print_label_of_pc(pc,llist->next);
}

// 命令関係
Instr initialize_instr(void) {
	Instr i;
	i = malloc(sizeof(struct _instruction));
	i->opcode = 0b0000000;
	i->funct3 = 0b000;
	i->funct5 = 0b00000;
	i->is_sra_sub = 0b0;
	i->rd = 0b000;
	i->rs1 = 0b000;
	i->rs2 = 0b000;
	i->imm = 0;
	i->machine_code = 0b00000000000000000000000000000000;
	i->label = NULL;
	i->label_addr = 0;
	i->line = 0;
	i->src_break = 0;
	i->exec_count = 0;
	return i;
}


// 命令を実行する。
void exec_instr(Instr i, Mem memory, Reg reg) {
	unsigned  int jump_addr = 0;
	int jump_en = 0;

	if (i == NULL) {
		fprintf(log_fp, "[ERROR]@exec_instr:\tinstr is NULL\n");fflush(log_fp);
						error = 1;
		return;
	}
	if (reg == NULL) {
		fprintf(log_fp, "[ERROR]@exec_instr:\treg is NULL\n");fflush(log_fp);
						error = 1;
		return;
	}

	switch (i->opcode) {
		case OP_LUI:
			if(show_all)fprintf(log_fp,"\trd:x%d = %d\n",i->rd,reg->x[i->rd]);
			if ( 0 < i->rd && i->rd < 32) reg->x[i->rd] = i->imm << 12;
			if(show_all)fprintf(log_fp,"\tx%d <= %d\n",i->rd,reg->x[i->rd]);
			break;
		case OP_AUIPC:
			if(show_all)fprintf(log_fp,"\trd:x%d = %d\n",i->rd,reg->x[i->rd]);
			if ( 0 < i->rd && i->rd < 32)reg->x[i->rd] = reg->pc + (i->imm<<12);
			if(show_all)fprintf(log_fp,"\tx%d <= %d\n",i->rd,reg->x[i->rd]);
			break;
		case OP_JAL:						//opcode rd, label
				if ( 0 < i->rd && i->rd < 32){
						reg->x[i->rd] = reg->pc + 1;
						if(show_all)fprintf(log_fp,"\tx%d <= %d\n",i->rd,reg->x[i->rd]);
						if(show_all)fprintf(log_fp,"\trs1: x%d = %d\n",i->rs1,reg->x[i->rs1]);
						if(show_all)fprintf(log_fp,"\timm:     = %d\n",i->imm);
				}						//rd is usually 1 or 5 risc-v p14
				// reg->pc = reg->pc + i->imm ;
				jump_addr = reg->pc + i->imm ;
				jump_en = 1;
			break;
		case OP_JALR:						//opcode rd, rs1, label
			if ( 0 < i->rd && i->rd < 32){
				reg->x[i->rd] = reg->pc  + 1;
				if(show_all)fprintf(log_fp,"\t     x%d <= %d\n",i->rd,reg->x[i->rd]);
			}
			// reg->pc = reg->x[i->rs1] + i->imm ;
				jump_addr = reg->x[i->rs1] + i->imm ;
				jump_en = 1;
			break;
		case OP_BRANCH:						//opcode rs1, rs2, imm (immはオフセット)
			if(show_all)fprintf(log_fp,"\trs1: x%d = %d,\n\trs2: x%d = %d\n",i->rs1, reg->x[i->rs1],i->rs2, reg->x[i->rs2]);
			switch(i->funct3){
					case B_EQ:
						jump_en = reg->x[i->rs1] ==  reg->x[i->rs2];
						break;
					case B_NE:
						jump_en = reg->x[i->rs1] !=  reg->x[i->rs2];
						break;
					case B_LT:
						jump_en = reg->x[i->rs1] <   reg->x[i->rs2];
						break;
					case B_GE:
						jump_en = reg->x[i->rs1] >=  reg->x[i->rs2];
						break;
					case B_LTU:
						jump_en = (unsigned int) reg->x[i->rs1] < (unsigned int) reg->x[i->rs2]  ;
						break;
					case B_GEU:
						jump_en = (unsigned int) reg->x[i->rs1] >= (unsigned int) reg->x[i->rs2]  ;
						break;
					default:
						jump_en = 0;
						error = 1;
						fprintf(log_fp,"[ERROR]@exec_instr:@pc = %8d OP_STORE\n", reg->pc);
						fprintf(log_fp,"[ERROR]@exec_instr:branch mode error\n");
			}
			if(show_all){
				if(jump_en)fprintf(log_fp, "\tcondition: TRUE\n");
				else fprintf(log_fp, "\tcondition: FALSE\n");
			}
			jump_addr = reg->pc + i->imm;
			break;
		case OP_LOAD: {						//opcode rd, imm(rs1) (immはディスプレースメント)
				int addr = reg->x[i->rs1] + i->imm;
				if (i->funct3 == LOAD_WORD && 0 < i->rd && i->rd < 32  ) {
					if ( addr < MEMORY_SIZE ){
						if(show_all)fprintf(log_fp,"\trd:  x%d =  %d\n",i->rd,reg->x[i->rd]);
						reg->x[i->rd] = memory[addr].d;
						if(show_all)fprintf(log_fp,"\tmem_addr:%d (0x%06x)\n",addr,addr);
						if(show_all)fprintf(log_fp,"\t     x%d <= %d\n",i->rd,reg->x[i->rd]);
					}else {
						error = 1;
						fprintf(log_fp, "[ERROR]@exec_instr:@pc:%d (0x%08x) OP_LOAD\n",reg->pc,reg->pc);
						fprintf(log_fp, "[ERROR]@exec_instr:\tmemory size error\n");
						fprintf(log_fp, "[ERROR]@exec_instr:\taccess addr is \t0x%08x\n", addr );
						fprintf(log_fp, "[ERROR]@exec_instr:\tbut valid addr is 0 ~ 0x%08x\n", MEMORY_SIZE - 1);
					}
				} else {
					fprintf(log_fp, "ロード命令はlwしかサポートしていません");
				}
			}
			break;
		case OP_STORE: {					//opcode rs2, imm(rs1) (immはディスプレースメント rs2がrs1より先にあるのはロードと合わせるためだと思う)
				int addr = reg->x[i->rs1] + i->imm;
				if (i->funct3 == STORE_WORD) {
					if ((unsigned int )addr < MEMORY_SIZE) {
						memory[addr].x = reg->x[i->rs2];
						if(show_all)fprintf(log_fp,"\tmem_addr:%d (0x%06x)\n",addr,addr);
						if(show_all)fprintf(log_fp,"\tx%d:%d is stored\n",i->rs2,reg->x[i->rs2]);

					} else {
						error = 1;
						fprintf(log_fp, "[ERROR]@exec_instr:@pc = %8d (0x%08x) OP_STORE\n",reg->pc,reg->pc);
						fprintf(log_fp, "[ERROR]@exec_instr:\tmemory size error\n");
						fprintf(log_fp, "                   \taccess addr is  0x%08x\n", addr );
						fprintf(log_fp, "                   \tbut valid addr is 0 ~ 0x%08x\n", MEMORY_SIZE - 1);
					}
				}
			}
			break;
		case OP_ALUI :						//opcode rd, rs1, imm
			if(show_all)fprintf(log_fp,"\trs1: x%d = %d\n\timm = %d\n",i->rs1, reg->x[i->rs1],i->imm);
			if(show_all)fprintf(log_fp,"\trd:  x%d = %d\n",i->rd,reg->x[i->rd]);
			if ( 0 < i->rd && i->rd < 32  ) {
				switch (i->funct3) {
					case ALU_ADD : 	reg->x[i->rd] =  reg->x[i->rs1] + i->imm ; break;
					case ALU_SLL : 	reg->x[i->rd] =  reg->x[i->rs1] << i->imm; break;
					case ALU_SLT : 	reg->x[i->rd] =  ((int)reg->x[i->rs1] < i->imm ? 1 : 0) ; break;
					case ALU_SLTU : reg->x[i->rd] =  ((unsigned int)reg->x[i->rs1] < (unsigned int)i->imm ? 1 : 0 ) ; break;
					case ALU_XOR : 	reg->x[i->rd] =  reg->x[i->rs1] ^ i->imm ; break;
					case ALU_SRX : 	reg->x[i->rd] =  ( i->is_sra_sub ? reg->x[i->rs1] >> i->imm : (unsigned int)reg->x[i->rs1] >> (unsigned int)i->imm) ; break;
					case ALU_OR : 	reg->x[i->rd] =  reg->x[i->rs1] | i->imm ; break;
					case ALU_AND : 	reg->x[i->rd] =  reg->x[i->rs1] & i->imm ; break;
					default: fprintf(stderr, "error in exec alui\n");
				}
			}
			if(show_all)fprintf(log_fp,"\tx%d <= %d\n",i->rd,reg->x[i->rd]);
			break;
		case OP_ALU:						//opcode rd, rs1, rs2
			if(show_all)fprintf(log_fp,"\trd:x%d = %d\n",i->rd,reg->x[i->rd]);
			if(show_all)fprintf(log_fp,"\trs1:x%d = %d\n\trs2:x%d = %d\n",i->rs1, reg->x[i->rs1],i->rs2, reg->x[i->rs2]);
			if ( 0 < i->rd && i->rd < 32) {
				switch (i->funct3) {
					case  ALU_ADD :
						if (i->is_sra_sub) 	reg->x[i->rd] =  reg->x[i->rs1]  - reg->x[i->rs2];
						else 				reg->x[i->rd] =  reg->x[i->rs1]  + reg->x[i->rs2]; break;
					case  ALU_SLL : 	reg->x[i->rd] =  reg->x[i->rs1] << reg->x[i->rs2] ; break;
					case  ALU_SLT : 	reg->x[i->rd] =  ((int)reg->x[i->rs1] < reg->x[i->rs2] ? 1 : 0) ; break;
					case  ALU_SLTU : 	reg->x[i->rd] =  ((unsigned int)reg->x[i->rs1] < (unsigned int)reg->x[i->rs2] ? 1 : 0 ) ; break;
					case  ALU_XOR : 	reg->x[i->rd] =  reg->x[i->rs1] ^ reg->x[i->rs2] ; break;
					case  ALU_SRX : 	reg->x[i->rd] =  ( i->is_sra_sub ? reg->x[i->rs1] >> reg->x[i->rs2] : (unsigned int )reg->x[i->rs1] >> (unsigned int )reg->x[i->rs2]) ; break;
					case  ALU_OR : 		reg->x[i->rd] =  reg->x[i->rs1] | reg->x[i->rs2] ; break;
					case  ALU_AND : 	reg->x[i->rd] =  reg->x[i->rs1] & reg->x[i->rs2] ; break;
				}
			}
			if(show_all)fprintf(log_fp,"\tx%d <= %d\n",i->rd,reg->x[i->rd]);
			break;
		case OP_FP:
			switch (i->funct5) {
				case  F5_FADD:
					if(show_all)fprintf(log_fp,"\trd: f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					if(show_all)fprintf(log_fp,"\trs2:f%d = %f \n",i->rs2,reg->f[i->rs2]);
					reg->f[i->rd] = reg->f[i->rs1] + reg->f[i->rs2];
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);
					break;
				case  F5_FSUB:
					if(show_all)fprintf(log_fp,"\trd: f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					if(show_all)fprintf(log_fp,"\trs2:f%d = %f \n",i->rs2,reg->f[i->rs2]);
					reg->f[i->rd] = reg->f[i->rs1] - reg->f[i->rs2];
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);
					break;
				case  F5_FMUL:
					if(show_all)fprintf(log_fp,"\trd: f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					if(show_all)fprintf(log_fp,"\trs2:f%d = %f \n",i->rs2,reg->f[i->rs2]);
					reg->f[i->rd] = reg->f[i->rs1] * reg->f[i->rs2];
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);
					break;
				case  F5_FDIV:
					if(show_all)fprintf(log_fp,"\trd: f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					if(show_all)fprintf(log_fp,"\trs2:f%d = %f \n",i->rs2,reg->f[i->rs2]);
					reg->f[i->rd] = reg->f[i->rs1] / reg->f[i->rs2];
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);
					break;
				case  F5_FSQRT:
					if(show_all)fprintf(log_fp,"\trd:f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					reg->f[i->rd] = sqrtf(fabsf(reg->f[i->rs1]));
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);
					break;
				case  F5_FCMP:
					if(show_all)fprintf(log_fp,"\trd:x%d = %d \n",i->rd,reg->x[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					if(show_all)fprintf(log_fp,"\trs2:f%d = %f \n",i->rs2,reg->f[i->rs2]);
					reg->x[i->rd] = (i->funct3 == F3_FEQ && reg->f[i->rs1] == reg->f[i->rs2] ) ||
					                (i->funct3 == F3_FLT && reg->f[i->rs1] <  reg->f[i->rs2] ) ||
					                (i->funct3 == F3_FLE && reg->f[i->rs1] <= reg->f[i->rs2] ); 
					if(show_all)fprintf(log_fp,"\tx%d  <= %d\n",i->rd, reg->x[i->rd]);
					break;
				case F5_FSGNJ:
					if(show_all)fprintf(log_fp,"\trd:f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					switch(i->funct3){
						case F3_FSGNJ: reg->f[i->rd] = reg->f[i->rs1];break;
						case F3_FSGNJN: reg->f[i->rd] = - (reg->f[i->rs1]);break;
						case F3_FSGNJX: reg->f[i->rd] = fabs(reg->f[i->rs1]);break;
					}
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);
					break;
				case  F5_FTOI:{
					if(show_all)fprintf(log_fp,"\trd:x%d = %d \n",i->rd,reg->x[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					switch(i->funct3){
						case F3_RNE:reg->x[i->rd] = (int) roundf(reg->f[i->rs1]);break;
						case F3_RDN:reg->x[i->rd] = (int) reg->f[i->rs1]; break;
					}
					if(show_all)fprintf(log_fp,"\tx%d  <= %d\n",i->rd, reg->x[i->rd]);
				}break;
				case  F5_FTOX:
					if(show_all)fprintf(log_fp,"\trd:x%d = %d \n",i->rd,reg->x[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:f%d = %f \n",i->rs1,reg->f[i->rs1]);
					((float *)reg->x)[i->rd] = reg->f[i->rs1];
					if(show_all)fprintf(log_fp,"\tx%d  <= %d\n",i->rd, reg->x[i->rd]);
				break;
				case  F5_ITOF:
					if(show_all)fprintf(log_fp,"\trd:f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:x%d = %d \n",i->rs1,reg->x[i->rs1]);
					reg->f[i->rd] = (float)reg->x[i->rs1];
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);
					break;
				case  F5_XTOF:
					if(show_all)fprintf(log_fp,"\trd:f%d = %f \n",i->rd,reg->f[i->rd]);
					if(show_all)fprintf(log_fp,"\trs1:x%d = %d \n",i->rs1,reg->x[i->rs1]);
					((int *) reg->f)[i->rd] = reg->x[i->rs1];break;
					if(show_all)fprintf(log_fp,"\tf%d  <= %f\n",i->rd, reg->f[i->rd]);

				default:
					fprintf(stderr, "invalid operation of F_OP\n");
					error = 1;
					return;
			}

			break;
		case  OP_STORE_FP: {
				int addr  = reg->x[i->rs1] + i->imm;
					if ((unsigned int )addr < MEMORY_SIZE) {
						memory[addr].f = reg->f[i->rs2];
						// printf("store x%d(%d) to mem[%d]\n",i->rs2,reg->x[i->rs2],reg->x[i->rs1] + i->imm);
						// printf("stored data == %d\n",memory[i->rs1 + i->imm].x);
						if(show_all)fprintf(log_fp,"\tmem_addr:%d (0x%06x)\n",addr,addr);
						if(show_all)fprintf(log_fp,"\tf%d:%f is stored\n",i->rs2,reg->f[i->rs2]);
					} else {
						fprintf(log_fp, "[ERROR]@exec_instr:@pc = %8d (0x%08x) OP_STORE_FP\n",reg->pc,reg->pc);
						fprintf(log_fp, "[ERROR]@exec_instr:\tmemory size error\n");
						fprintf(log_fp, "                   \taccess addr is  0x%08x\n", addr );
						fprintf(log_fp, "                   \tbut valid addr is 0 ~ 0x%08x\n", MEMORY_SIZE - 1);
					}

			}
			break;
		case OP_LOAD_FP : {
				if(show_all)fprintf(log_fp,"\trs1: x%d = %d\n\timm = %d\n",i->rs1, reg->x[i->rs1],i->imm);
				int addr  = reg->x[i->rs1] + i->imm;
					if ( addr < MEMORY_SIZE ){
							if(show_all)fprintf(log_fp,"\trd:  f%d =  %f\n",i->rd,reg->f[i->rd]);
							reg->f[i->rd] = memory[addr].f;
							if(show_all)fprintf(log_fp,"\tmem_addr:%d (0x%06x)\n",addr,addr);
							if(show_all)fprintf(log_fp,"\t     f%d <= %f\n",i->rd,reg->f[i->rd]);
					}else {
						error = 1;
						// fprintf(log_fp,"\trs1: x%d = %d\n\timm = %d\n",i->rs1, reg->x[i->rs1],i->imm);
						// fprintf(log_fp,"\trs1: x%d = %08x\n\timm = %08x\n",i->rs1, reg->x[i->rs1],i->imm);
						fprintf(log_fp, "[ERROR]@exec_instr:@pc = %8d (0x%08x) OP_LOAD_FP\n",reg->pc,reg->pc);
						fprintf(log_fp, "[ERROR]@exec_instr:\tmemory size error\n");
						fprintf(log_fp, "[ERROR]@exec_instr:\taccess addr is        0x%08x\n", addr );
						fprintf(log_fp, "[ERROR]@exec_instr:\tbut valid addr is 0 ~ 0x%08x\n", MEMORY_SIZE - 1);
					}
			}
			break;
		case OP_STORE_IO :{
				if(i->funct3 == STORE_BYTE){
					if(!out_fp){
						fprintf(log_fp,"[LOG]@exec_instr:\toutput file is not declared\n");
						printf("please input output file name\n>> ");
						char filename[BUF_SIZE];
						scanf("%s",filename);
						out_fp = fopen(filename,"w");
					}
					if(show_all)fprintf(log_fp,"\trs2:x%d = %d(0x%08x) \n",i->rs2,reg->x[i->rs2],reg->x[i->rs2]);
					fwrite(&(reg->x[i->rs2]),1,1,out_fp);
					// printf("%d\n",reg->x[i->rs2]);
				}else{
					error = 1;
					fprintf(log_fp,"[ERROR]@exec_instr\t:funct3 of ob should be STORE_BYTE\n");
				}

			}
			break;
		case OP_LOAD_IO :{
			if(input_index <sld_n_bytes){
						if(show_all)fprintf(log_fp,"\trd:x%d = %d(0x%08x) \n",i->rd,reg->x[i->rd],reg->x[i->rd]);
							word w;
							w.x = sld_words[input_index/4].i;
							uint32_t data =  (uint32_t)sld_bytes[input_index++];
							fprintf(log_fp,"\tinput[%d]: %02x\t", input_index-1,data);
							printf("(%12d or %10.5f)\n",w.x,w.f);
							reg->x[i->rd] = data;
							if(show_all)fprintf(log_fp,"\tx%d  <= %d(0x%08x)\n",i->rd, reg->x[i->rd], reg->x[i->rd]);
			}else{
					fprintf(log_fp,"[ERROR]@exec_instr\t:lack of input data\n");
						error = 1;
			}
			}
			break;
		default: {
						error = 1;
				fprintf(stderr, "invalid opcode:\t0b");
				fprint_bin(stderr, i->opcode, 6, 0);
				fputc('\n', stderr);
			}
	}
	if(jump_en){
		reg->pc =jump_addr;
		if(show_all)fprintf(log_fp,"\tjump to %d\n",jump_addr);
	}else{
		reg->pc++;
	}
	// print_reg(reg,PRINT_REG_PC);
	// printf("imm:%d,x[%d]:%d\n",i->imm,i->rd,reg->x[i->rd]);
	i->exec_count++;
if(show_all){
	fprintf(log_fp,"\tinstr count:%d \n",i->exec_count++);
}
}





int  exec_program(Program program, Reg reg, Mem mem) {
	Instr instr;
	int instr_count = 0;
	while ((instr = program[reg->pc]) != NULL && instr->opcode != OP_HLT) {
		exec_instr(instr, mem, reg);
		if(error){
		print_instr(instr);
		putchar('\n');
					break;
		}
		instr_count++;
	}
	return instr_count;
}



void generate_binary(Program program, char *filename) {

	uint32_t machine_code;
	FILE* fp;

	if ((fp = fopen(filename, "wb")) == NULL) {
		perror("file open error!!\n");
	}

	for (int i = 0; program[i] != NULL; i++) {
		machine_code = create_machine_code(program[i]);
		program[i]->machine_code = machine_code;
		write_word(machine_code, fp);

	}

	fclose(fp);

}

void write_word(uint32_t d, FILE *fp) {
	for (int i = 7; i >= 0; i--) {
		putc(d / (1 << (i * 8)), fp);
		d %= 1 << i * 8;
	}
}
//%bが欲しいけどないから%dで使えるように作った。
int get_b_form(int d) {
	int b = 0;
	for (int i = 1; d != 0; i *= 10) {
		b += (d % 2) * i;
		d /= 2;
	}
	return b;
}

Mem initialize_memory(int memsize, Mem p) {
	if (p != NULL) {
		bzero(p, MEMORY_SIZE);
		return p;
	} else {
		return calloc(MEMORY_SIZE, sizeof(word));
	}
}

Reg initialize_reg(Reg reg) {
	if (reg == NULL) {
		reg = malloc(sizeof(struct _reg));
		reg->pc = 0;
	}

	for (int i = 0; i < 32; i++)
		reg->x[i] = 0;

	for (int i = 0; i <= 10; i++)
		reg->f[i] = 0;
	reg->f[11] = 1.0;
	reg->f[12] = 2.0;
	reg->f[13] = 4.0;
	reg->f[14] = 10.0;
	reg->f[15] = 15.0;
	reg->f[16] = 20.0;
	reg->f[17] = 128.0;
	reg->f[18] = 200.0;
	reg->f[19] = 255.0;
	reg->f[20] = 850.0;
	reg->f[21] = 0.100;
	reg->f[22] = 0.200;
	reg->f[23] = 0.001;
	reg->f[24] = 0.005;
	reg->f[25] = 0.150;
	reg->f[26] = 0.250;
	reg->f[27] = 0.500;
	reg->f[28] = M_PI;
	reg->f[29] = 30.0 / M_PI;
	reg->f[30] = 0;
	reg->f[31] = 0;
	return reg;
}

Runtime initialize_runtime(Runtime d) {
	if (d == NULL)
		d = malloc(sizeof(struct _runtime));
	d->instr_count = 0;
	// bzero( d->b_list, 32 * sizeof(Cond));
	// bzero( d->w_list , 32 * sizeof(Cond));
	// bzero( d->d_list , 32 * sizeof(Cond));
	d->b_count = 0;
	d->time = 0;
	bzero( d->op_count , 64 * sizeof(int));
	d->llist = NULL;
	d->files = NULL;
	d->reg = NULL;
	d->program = NULL;
	d->memory = NULL;
	d->max_instr = 0;
	return d;
}


