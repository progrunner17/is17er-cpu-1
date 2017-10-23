#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "include.h"

//%bが欲しいけどないから%dで使えるように作った。
int get_b_form(int d){
	int b = 0;
	for(int i = 1; d!= 0;i *= 10){
		b += (d%2) * i;
		d /= 2;
	}
	return b;
};


void print_memory(word *memory,int start,int n){
	int pc;
	int base = start / 4;
	for(int i = base;i< base + n ;i++){
		pc = i * 4;
		printf("0x%08x: %08x\t",pc,memory[i]);
		if((i+1)%8 == 0) putchar('\n');
	}
	putchar('\n');
};

Instr initialize_instr(void){
	Instr i;
	i = malloc(sizeof(struct instruction));
	strcpy(i->mnenonic,"");
	i->opcode = 0b0000000;
	i->funct3 = 0b000;
	i->is_sra_sub = 0b0;
	i->rd = 0b000;
	i->rs1 = 0b000;
	i->rs2 = 0b000;
	i->imm = 0;
	i->byte_code = 0b00000000000000000000000000000000;
	strcpy(i->label,"");
	i->label_addr = 0;
	i->line = 0;
	i->break_en = 0;
	return i;
}

//ニーモニックの文字列を渡してオペコード(include.hで定義))を返す関数
int create_opcode(const char* mnenonic){
	int opcode = 0;
	opcode = 	(strcmp(mnenonic,"lui")  == 0) ? OP_LUI:
				(strcmp(mnenonic,"auipc") == 0) ? OP_AUIPC:
				(strcmp(mnenonic,"jal") == 0) ? OP_JAL:
				(strcmp(mnenonic,"jalr") == 0) ? OP_JALR:
				(strcmp(mnenonic,"beq") == 0)||
				(strcmp(mnenonic,"bne") == 0)||
				(strcmp(mnenonic,"blt") == 0)||
				(strcmp(mnenonic,"bge") == 0)||
				(strcmp(mnenonic,"bltu") == 0)||
				(strcmp(mnenonic,"bgeu") == 0) ? OP_BRANCH:
				((strcmp(mnenonic,"lb") == 0) ||
				(strcmp(mnenonic,"lh") == 0) ||
				(strcmp(mnenonic,"lw") == 0) ||
				(strcmp(mnenonic,"lbu") == 0) ||
				(strcmp(mnenonic,"lhu") == 0)) ? OP_LOAD:
				(strcmp(mnenonic,"sb") == 0) ||
				(strcmp(mnenonic,"sh") == 0) ||
				(strcmp(mnenonic,"sw") == 0) ? OP_STORE:
				((strcmp(mnenonic,"addi") == 0) ||
				(strcmp(mnenonic,"slti") == 0) ||
				(strcmp(mnenonic,"sltiu") == 0) ||
				(strcmp(mnenonic,"xori") == 0) ||
				(strcmp(mnenonic,"ori") == 0) ||
				(strcmp(mnenonic,"andi") == 0) ||
				(strcmp(mnenonic,"slli") == 0) ||
				(strcmp(mnenonic,"srli") == 0) ||
				(strcmp(mnenonic,"srai") == 0)) ? OP_ALUI:
				(strcmp(mnenonic,"add") == 0) ||
				(strcmp(mnenonic,"sub") == 0) ||
				(strcmp(mnenonic,"sll") == 0) ||
				(strcmp(mnenonic,"slt") == 0) ||
				(strcmp(mnenonic,"sltu") == 0) ||
				(strcmp(mnenonic,"xor") == 0) ||
				(strcmp(mnenonic,"srl") == 0) ||
				(strcmp(mnenonic,"sra") == 0) ||
				(strcmp(mnenonic,"or") == 0) ||
				(strcmp(mnenonic,"and") == 0) ? OP_ALU : 0;
		return opcode;
}

// オペコードとニーモニックを渡して,funct3を返す関数。
int create_funct3(const char * mnenonic){
	int funct3 = 0;
	funct3 =	(strcmp(mnenonic,"beq") == 0)? B_EQ :
				(strcmp(mnenonic,"bne") == 0)? B_NE :
				(strcmp(mnenonic,"blt") == 0)? B_LT:
				(strcmp(mnenonic,"bge") == 0)? B_GE:
				(strcmp(mnenonic,"bltu") == 0)? B_LTU:
				(strcmp(mnenonic,"bgeu") == 0)? B_GEU:
				(strcmp(mnenonic,"lb") == 0) ? LOAD_BYTE_S:
				(strcmp(mnenonic,"lh") == 0) ? LOAD_HALF_S:
				(strcmp(mnenonic,"lw") == 0) ? LOAD_WORD:
				(strcmp(mnenonic,"lbu") == 0) ? LOAD_BYTE_Z:
				(strcmp(mnenonic,"lhu") == 0) ? LOAD_HALF_Z:
				(strcmp(mnenonic,"sb") == 0) ? STORE_BYTE:
				(strcmp(mnenonic,"sh") == 0) ? STORE_HALF:
				(strcmp(mnenonic,"sw") == 0) ? STORE_WORD:
				(strcmp(mnenonic,"addi") == 0) ? ALU_ADD:
				(strcmp(mnenonic,"slti") == 0) ? ALU_SLT:
				(strcmp(mnenonic,"sltiu") == 0) ? ALU_SLTU:
				(strcmp(mnenonic,"xori") == 0) ? ALU_XOR:
				(strcmp(mnenonic,"ori") == 0) ? ALU_OR:
				(strcmp(mnenonic,"andi") == 0) ? ALU_AND:
				(strcmp(mnenonic,"slli") == 0) ? ALU_SLL:
				(strcmp(mnenonic,"srli") == 0) ? ALU_SRX:
				(strcmp(mnenonic,"srai") == 0) ? ALU_SRX:
				(strcmp(mnenonic,"add") == 0) ? ALU_ADD:
				(strcmp(mnenonic,"sub") == 0) ? ALU_ADD:
				(strcmp(mnenonic,"sll") == 0) ? ALU_SLL:
				(strcmp(mnenonic,"slt") == 0) ? ALU_SLT:
				(strcmp(mnenonic,"sltu") == 0) ? ALU_SLTU:
				(strcmp(mnenonic,"xor") == 0) ? ALU_XOR:
				(strcmp(mnenonic,"srl") == 0) ? ALU_SRX:
				(strcmp(mnenonic,"sra") == 0) ? ALU_SRX:
				(strcmp(mnenonic,"or") == 0) ? ALU_OR:
				(strcmp(mnenonic,"and") == 0) ? ALU_AND : 0;
	return funct3;

}

int create_is_sra_sub(const char *mnenonic){
	int is_sra_sub;
	is_sra_sub = 	(strcmp(mnenonic,"sub") == 0)||
					(strcmp(mnenonic,"sra") == 0)||
					(strcmp(mnenonic,"srai") == 0) ? 1:0;
	return is_sra_sub;
}



//ラベルの文字列を渡して、アドレスを返す関数
int search_label(const char* name,LList label_list){
	if(label_list == NULL){
		fprintf(stderr,"ラベル:%sが存在しません",name);
		return -1;
	}else if(strcmp(label_list->name,name) !=0 ){
		return search_label(name,label_list->next);
	}else{//match
		return label_list->addr;
	}
}

// ラベルリストにラベルを追加
LList add_label(const char *name,int pc,LList label_list){
		LList label;
		label = calloc(1,sizeof(struct label));
		label->addr = pc;
		strcpy(label->name,name);
		label->next = label_list;
		return label;
}

void print_labels(LList label_list){
	if(label_list!= NULL){
		if(label_list->next != NULL) print_labels(label_list->next);
		printf("label:%s\taddr:%d\n",label_list->name,label_list->addr);
	}else{
		printf("ラベル一覧");
	}
}

// ラベルの解決。
void resolve_label(Instr *program,LList label_list,int base_addr){
	int pc,opcode;
	for(int i = 0; program[i] != NULL;i++){
		opcode = program[i]->opcode;
		if(opcode == OP_JAL || opcode == OP_JALR || opcode == OP_BRANCH){
			pc = base_addr + i * 4;
			program[i]->label_addr =search_label(program[i]->label, label_list);
			program[i]->imm = program[i]->label_addr - pc;
		}
	}
}

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

	// printf("%s ",instr->mnenonic); //opcode,funct3,及びis_sra_subで置き換え
	print_mnemonic(instr->opcode,instr->funct3,instr->is_sra_sub);
	putchar(' ');

	if(instr->opcode == OP_LUI){
		printf("x%d, %d",instr->rd,instr->imm);
	}else if(instr->opcode == OP_AUIPC){
		printf("x%d, %d",instr->rd,instr->imm);
	}else if(instr->opcode == OP_JAL){
		printf("x%d, %s",instr->rd,instr->label);
	}else if(instr->opcode == OP_JALR){
		printf("x%d, x%d, %s",instr->rd,instr->rs1,instr->label);
	}else if(instr->opcode == OP_BRANCH){
		printf("x%d, x%d, %s, %d",instr->rs1,instr->rs2,instr->label,instr->imm);
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

//アセンブリのファイルを読みこみ命令(へのポインタ)の配列を返す関数
Instr *load_assembly(const char* filename,int base_addr){
	FILE *fp;
	char mnenonic[64];
	Instr instr;
	Instr *program;
	int opcode;
	int pc = base_addr;
	LList label_list =  NULL;
	int break_en = 0;

	program = calloc(PROGRAM_SIZE,sizeof(Instr));

	if ((fp = fopen(filename, "r")) == NULL) {
		perror("file open error!!\n");
		return (Instr *)NULL ;
	}

	for (int line = 0; fscanf(fp,"%s",mnenonic) != EOF; line++){
		if(strcmp(mnenonic,"*break*") == 0){
			break_en = 1;
			continue;
		}

		instr = initialize_instr();
		opcode = create_opcode(mnenonic);
		if(opcode == OP_LUI){								//opcode rd, imm
			fscanf(fp," x%d, %d",&instr->rd,&instr->imm);
		}else if (opcode == OP_AUIPC) {						//opcode rd, imm
			fscanf(fp," x%d, %d",&instr->rd,&instr->imm);
		}else if (opcode == OP_JAL) {						//opcode rd, label
			fscanf(fp," x%d, %s",&instr->rd,instr->label);
		}else if (opcode == OP_JALR) {						//opcode rd, rs1, label
			fscanf(fp," x%d, x%d, %s",&instr->rd,&instr->rs1,instr->label);
		}else if (opcode == OP_BRANCH) {						//opcode rs1, rs2, imm (immはオフセット)
			fscanf(fp," x%d, x%d, %s",&instr->rs1,&instr->rs2,instr->label);
			instr->funct3 = create_funct3(mnenonic);
		}else if (opcode == OP_LOAD) {						//opcode rd, imm(rs1) (immはディスプレースメント)
			fscanf(fp," x%d, %d(x%d)",&instr->rd,&instr->imm,&instr->rs1);
			instr->funct3 = create_funct3(mnenonic);
		}else if (opcode == OP_STORE) {						//opcode rs2, imm(rs1) (immはディスプレースメント rs2がrs1より先にあるのはロードと合わせるためだと思う)
			fscanf(fp," x%d, %d(x%d)",&instr->rs2,&instr->imm,&instr->rs1);
			instr->funct3 = create_funct3(mnenonic);
		}else if (opcode == OP_ALUI) {						//opcode rd, rs1, imm
			fscanf(fp," x%d, x%d, %d",&(instr->rd),&(instr->rs1),&(instr->imm));
			instr->funct3 = create_funct3(mnenonic);
			instr->is_sra_sub = strcmp(mnenonic,"sra")  ? 1 : 0; //TODO
		}else if (opcode == OP_ALU) {						//opcode rd, rs1, rs2
			fscanf(fp," x%d, x%d, x%d",&instr->rd,&instr->rs1,&instr->rs2);
			instr->funct3 = create_funct3(mnenonic);
			instr->is_sra_sub = (strcmp(mnenonic,"sub") == 0 || strcmp(mnenonic,"sra") == 0) ? 1 : 0; //TODO
		}else if (opcode == 0){ //ラベル

			if(mnenonic[0] != '#' ){
				label_list =  add_label(mnenonic,pc,label_list);
				printf("label: %s \taddr:%d\n",mnenonic,pc);
			}else{
				while(fgetc(fp) != '\n'); //行末まで破棄
			}

			free(instr);
			continue;
		}
		if(break_en) instr->break_en = 1;
		instr->opcode = opcode;//オペコード格納
		instr->line = line;//行番号保存
		strcpy(instr->mnenonic,mnenonic);
		program[(pc-base_addr)/4] = instr;

		printf("addr:%8x   //%d命令目\n",pc,(pc-base_addr)/4);
		print_instr(instr);
		pc += 4;
	}

	print_labels(label_list);
	resolve_label(program,label_list,base_addr);
	printf("命令数:\t%d\n",(pc-base_addr)/4);
	return program;
}



Mem initialize_memory(int memsize){
	return calloc(MEMORY_SIZE,sizeof(word));
}

Reg initialize_reg(int base_addr){
	Reg  reg;
	reg = calloc(1,sizeof(struct reg));
	reg->pc = base_addr;
	return reg;
}

// floatをbit列として取得する用
union w {
	float f;
	unsigned int u;
};

void print_reg(Reg reg){
	printf("レジスタ値一覧\n");
	// union w ww;
		printf("pc:\t%08x\n",reg->pc);
	for(int i = 0; i<32 ;i++){
		printf("x%d:\t%08x\t",i,reg->x[i]);
		if(i%2) putchar('\n');
		// ww.f = reg->f[i];
		// printf("f%d:\t%8x\t%f\n",i,ww.u,ww.f);
	}
}

// 命令を実行する。
void exec_instr(Instr i,Mem memory,Reg reg,int option){
		if(option & (1<<2))printf("pc: %08x\n",reg->pc);
		if(option & (1<<1)){
			printf("実行命令: ");
			print_instr(i);
		}

		if(i->opcode == OP_LUI){								//opcode rd, imm
			reg->x[i->rd] = i->imm << 12;
		}else if (i->opcode == OP_AUIPC) {						//opcode rd, imm
			reg->x[i->rd] = reg->pc + (i->imm << 12);
		}else if (i->opcode == OP_JAL) {						//opcode rd, label
			reg->x[i->rd] = reg->pc + 4;						//rd is usually 1 or 5 risc-v p14
			reg->pc = reg->pc + i->imm ;
					if(option & 1) print_reg(reg);
			return;
		}else if (i->opcode == OP_JALR) {						//opcode rd, rs1, label
			reg->x[i->rd] = reg->pc + 4;
			reg->pc = reg->x[i->rs1] + i->imm ;
					if(option & 1) print_reg(reg);
			return;
		}else if (i->opcode == OP_BRANCH) {						//opcode rs1, rs2, imm (immはオフセット)
			reg->pc  = 	(i->funct3 == B_EQ && (int) reg->x[i->rs1] == (int) reg->x[i->rs2]) ||
					(i->funct3 == B_NE && (int) reg->x[i->rs1] != (int) reg->x[i->rs2]) ||
					(i->funct3 == B_LT && (int) reg->x[i->rs1] <  (int) reg->x[i->rs2]) ||
					(i->funct3 == B_GE && (int) reg->x[i->rs1] >= (int) reg->x[i->rs2]) ||
					(i->funct3 == B_LTU && (unsigned int) reg->x[i->rs1] < (unsigned int) reg->x[i->rs2]) ||
					(i->funct3 == B_GEU && (unsigned int) reg->x[i->rs1] >= (unsigned int) reg->x[i->rs2])
					? reg->pc + i->imm : reg->pc + 4;
					if(option & 1) print_reg(reg);
			return;
		}else if (i->opcode == OP_LOAD) {						//opcode rd, imm(rs1) (immはディスプレースメント)
			if(i->funct3 == LOAD_WORD){
				reg->x[i->rd] = memory[i->rs1+i->imm];
			}else{
				printf("ロード命令はlwしかサポートしていません");
			}
		}else if (i->opcode == OP_STORE) {						//opcode rs2, imm(rs1) (immはディスプレースメント rs2がrs1より先にあるのはロードと合わせるためだと思う)
			if(i->funct3 ==STORE_WORD){
				memory[i->rs1 + i->imm] = reg->x[i->rs2];
			}else{
				printf("ストア命令はswしかサポートしていません。");
			}
		}else if ((i->opcode == OP_ALUI) && (i->rd != 0)) {						//opcode rd, rs1, imm
				reg->x[i->rd] = 	(i->funct3 == ALU_ADD) ? reg->x[i->rs1] + i->imm:
									(i->funct3 == ALU_SLL) ? reg->x[i->rs1] << i->imm:
									(i->funct3 == ALU_SLT) ? ((int)reg->x[i->rs1] < i->imm ? 1:0):
									(i->funct3 == ALU_SLTU) ? ((unsigned int)reg->x[i->rs1] < (unsigned int)i->imm ? 1:0 ) :
									(i->funct3 == ALU_XOR) ? reg->x[i->rs1] ^ i->imm:
									(i->funct3 == ALU_SRX) ? ( i->is_sra_sub ? reg->x[i->rs1] >> i->imm : reg->x[i->rs1] >> i->imm):
									(i->funct3 == ALU_OR) ? reg->x[i->rs1] | i->imm:
									(i->funct3 == ALU_AND) ? reg->x[i->rs1] & i->imm: 0;
		}else if ((i->opcode == OP_ALU )&& (i->rd != 0)) {						//opcode rd, rs1, rs2
				reg->x[i->rd] = 	(i->funct3 == ALU_ADD) ?
									(i->is_sra_sub ? reg->x[i->rs1] - reg->x[i->rs2] : reg->x[i->rs1] + reg->x[i->rs2] ):
									(i->funct3 == ALU_SLL) ? reg->x[i->rs1] << reg->x[i->rs2]:
									(i->funct3 == ALU_SLT) ? ((int)reg->x[i->rs1] < reg->x[i->rs2] ? 1:0):
									(i->funct3 == ALU_SLTU) ? ((unsigned int)reg->x[i->rs1] < (unsigned int)reg->x[i->rs2] ? 1:0 ) :
									(i->funct3 == ALU_XOR) ? reg->x[i->rs1] ^ reg->x[i->rs2]:
									(i->funct3 == ALU_SRX) ? ( i->is_sra_sub ? reg->x[i->rs1] >> reg->x[i->rs2] : reg->x[i->rs1] >> reg->x[i->rs2]):
									(i->funct3 == ALU_OR) ? reg->x[i->rs1] | reg->x[i->rs2]:
									(i->funct3 == ALU_AND) ? reg->x[i->rs1] & reg->x[i->rs2]: 0;
		}else {
			// fprintf(stderr,"オペコードが不正です。\nopcode:%7d",get_b_form(i->opcode));
			// return ;
		}
		reg->pc += 4;
		if(option & 1) print_reg(reg);
		return;
}
void print_prgram(Program program){
	for(int i = 0;program[i] != NULL;i++){
		print_instr(program[i]);
	}
}

int  exec_program(Program program,Reg reg,Mem mem,int base_addr,int option){
	Instr i;
		// printf("実行開始\n");
	int count = 0;
	while(( i = program[(reg->pc - base_addr)/4]) != NULL){
		// if(option == ) print_instr(i);
		exec_instr(i,mem,reg,option);
		// if(option == )print_reg(reg);
		if(i->break_en){
			printf("break!\n");
			return count;
		}
		count++;
	}
	return count;
		// printf("実行終了");
	// printf("count:%d\n",count);
}
