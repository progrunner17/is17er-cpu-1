#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <math.h>
#include "include.h"
#include "size.h"
#include "opcode.h"


//アセンブリのファイルを読みこみ命令(へのポインタ)の配列を返す関数
Program load_assembly(const char* filename,Data d){
	FILE *fp;
	char buff[BUF_SIZE];
	char mnenonic[64];
	Instr instr;
	Instr *program;
	int opcode;
	int pc = 0;
	LList label_list =  NULL;
	int src_break = 0;
	int seek;


	program = calloc(PROGRAM_SIZE,sizeof(Instr));

	if ((fp = fopen(filename, "r")) == NULL) {
		perror("file open error!!\n");
		return (Instr *)NULL ;
	}

	for (int line = 1; fgets(buff,BUF_SIZE,fp)!= NULL; line++){
		if(*buff == '\n')continue;
		printf("%s",buff);
		// 空白以外の文字が現れるまでシーク
		seek = strcspn(buff," \t") + 1;

		//空白文字しかいあるいはコメンドだったら次のループへ
		if(seek >=BUF_SIZE || *(buff + seek) == '\n' || *(buff + seek) == '#' )continue;

		//		ニーモニック
		sscanf(buff,"%s",mnenonic);

		if((opcode = create_opcode(mnenonic))){//オペコードを取得できたらtrue
		// 命令用の領域を確保
		instr = initialize_instr();
		// オペコードの次の(空白)文字までシーク
		seek += strcspn(buff + seek," \t");
		// printf("hello\n");

		if(opcode == OP_LUI || opcode == OP_AUIPC){								//opcode rd, imm
			sscanf(buff + seek," x%d, %d",&instr->rd,&instr->imm);
		}else if (opcode == OP_JAL) {											//opcode rd, label
			if(sscanf(buff + seek," x%d, 0x%x ",&instr->rd,&instr->imm) == 2){}			// 16進数読み取り
			else if(sscanf(buff + seek," x%d, %d ",&instr->rd,&instr->imm)  == 2){}		// 10進数読み取り
			else if(sscanf(buff + seek," x%d, %s ",&instr->rd,instr->label)  == 2){		// ラベル読み取り
				label_list = add_label(instr->label,pc,label_list);
			}

		}else if (opcode == OP_JALR) {											//opcode rd, rs1, label
			sscanf(buff + seek," x%d, x%d, %d",&instr->rd,&instr->rs1,&instr->imm);
		}else if (opcode == OP_BRANCH) {										//opcode rs1, rs2, imm (immはオフセット)
			// sscanf(buff + seek," x%d, x%d, %s",&instr->rs1,&instr->rs2,instr->label);
			sscanf(buff + seek," x%d, x%d, %d",&instr->rs1,&instr->rs2,&instr->imm);
			instr->funct3 = create_funct3(mnenonic);
		}else if (opcode == OP_LOAD) {											//opcode rd, imm(rs1) (immはディスプレースメント)
			sscanf(buff + seek," x%d, %d(x%d)",&instr->rd,&instr->imm,&instr->rs1);
			instr->funct3 = create_funct3(mnenonic);
		}else if (opcode == OP_STORE) {											//opcode rs2, imm(rs1) (immはディスプレースメント rs2がrs1より先にあるのはロードと合わせるためだと思う)
			sscanf(buff + seek," x%d, %d(x%d)",&instr->rs2,&instr->imm,&instr->rs1);
			instr->funct3 = create_funct3(mnenonic);
		}else if (opcode == OP_ALUI) {											//opcode rd, rs1, imm
			sscanf(buff + seek," x%d, x%d, %d",&(instr->rd),&(instr->rs1),&(instr->imm));
			instr->funct3 = create_funct3(mnenonic);
			instr->is_sra_sub = strcmp(mnenonic,"sra")  ? 1 : 0;
		}else if (opcode == OP_ALU) {											//opcode rd, rs1, rs2
			sscanf(buff + seek," x%d, x%d, x%d",&instr->rd,&instr->rs1,&instr->rs2);
			instr->funct3 = create_funct3(mnenonic);
			instr->is_sra_sub = (strcmp(mnenonic,"sub") == 0 || strcmp(mnenonic,"sra") == 0) ? 1 : 0;
		}

		instr->opcode = opcode;//オペコード格納
		instr->line = line;//行番号保存
		strcpy(instr->mnenonic,mnenonic);

		// printf("0x%08x\t",pc);
		// print_instr(instr);
		program[pc] = instr;
		pc++;
	}else {//オペコードが取得できなかったら

		if(strcmp(mnenonic,"*break*") == 0){
			src_break = 1;
			continue;
		}



	}
	}//for
	// print_labels(label_list);
	resolve_label(program,label_list);
	printf("命令数:\t%d\n",pc+1);
	fclose(fp);
	d->llist = label_list;
	return program;
}

// アセンブリからオペコード生成
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




// ラベル関係
	// ラベルリストにラベルを追加
	LList add_label(const char *name,int pc,LList label_list){
			LList label;
			label = calloc(1,sizeof(struct _label));
			label->addr = pc;
			strcpy(label->name,name);
			label->next = label_list;
			return label;
	}

	LList initialize_label(void){
		return calloc(1,sizeof(struct _label));
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
	void print_labels(LList label_list){
		if(label_list!= NULL){
			if(label_list->next != NULL) print_labels(label_list->next);
			printf("label:%s\taddr:%d\n",label_list->name,label_list->addr);
		}else{
			printf("ラベル一覧");
		}
	}
	// ラベルの解決。
	void resolve_label(Instr *program,LList label_list){
		int opcode;
		for(int pc = 0; program[pc] != NULL;pc++){
			opcode = program[pc]->opcode;
			if(opcode == OP_JAL || opcode == OP_JALR || opcode == OP_BRANCH){
				program[pc]->label_addr =search_label(program[pc]->label, label_list);
				program[pc]->imm = program[pc]->label_addr - pc;
			}
		}
	}

// 命令関係
	Instr initialize_instr(void){
		Instr i;

		i = malloc(sizeof(struct _instruction));

		strcpy(i->mnenonic,"");
		i->opcode = 0b0000000;
		i->funct3 = 0b000;
		i->funct5 = 0b00000;
		i->is_sra_sub = 0b0;
		i->rd = 0b000;
		i->rs1 = 0b000;
		i->rs2 = 0b000;
		i->imm = 0;
		i->machine_code = 0b00000000000000000000000000000000;
		strcpy(i->label,"");
		i->label_addr = 0;
		i->line = 0;
		i->src_break = 0;
		return i;
	}


	// 命令を実行する。
	void exec_instr(Instr i,Mem memory,Reg reg,Data d){

			if(i->opcode == OP_LUI){								//opcode rd, imm

				reg->x[i->rd] = i->imm << 12;
				reg->pc++;

			}else if (i->opcode == OP_AUIPC) {						//opcode rd, imm
				reg->x[i->rd] = reg->pc + i->imm;
				reg->pc++;

			}else if (i->opcode == OP_JAL) {						//opcode rd, label

				reg->x[i->rd] = reg->pc + 1;						//rd is usually 1 or 5 risc-v p14
				reg->pc = reg->pc + i->imm  + 1;

				return;
			}else if (i->opcode == OP_JALR) {						//opcode rd, rs1, label

				reg->x[i->rd] = reg->pc + 1;
				reg->pc = reg->x[i->rs1] + i->imm ;

			}else if (i->opcode == OP_BRANCH) {						//opcode rs1, rs2, imm (immはオフセット)

				reg->pc  = 	(i->funct3 == B_EQ && (int) reg->x[i->rs1] == (int) reg->x[i->rs2]) ||
						(i->funct3 == B_NE && (int) reg->x[i->rs1] != (int) reg->x[i->rs2]) ||
						(i->funct3 == B_LT && (int) reg->x[i->rs1] <  (int) reg->x[i->rs2]) ||
						(i->funct3 == B_GE && (int) reg->x[i->rs1] >= (int) reg->x[i->rs2]) ||
						(i->funct3 == B_LTU && (unsigned int) reg->x[i->rs1] < (unsigned int) reg->x[i->rs2]) ||
						(i->funct3 == B_GEU && (unsigned int) reg->x[i->rs1] >= (unsigned int) reg->x[i->rs2])
						? reg->pc + i->imm + 1: reg->pc + 1;

			}else if (i->opcode == OP_LOAD) {						//opcode rd, imm(rs1) (immはディスプレースメント)

				if(i->funct3 == LOAD_WORD){
					reg->x[i->rd] = memory[i->rs1+i->imm];
				}else{
					fprintf(stderr,"ロード命令はlwしかサポートしていません");
				}

				reg->pc++;

			}else if (i->opcode == OP_STORE) {						//opcode rs2, imm(rs1) (immはディスプレースメント rs2がrs1より先にあるのはロードと合わせるためだと思う)

				int addr = i->rs1 + i->imm;
				printf("%08x\n",addr );
				if(i->funct3 ==STORE_WORD){

					if((unsigned int )addr < MEMORY_SIZE){
							memory[i->rs1 + i->imm] = reg->x[i->rs2];
					}else if(addr<<2 == 0xFFFFF000){//output

					// FILE *fp;

					// if ((fp = fopen("out.txt", "ab")) == NULL) {
					// perror("file open error!!\n");
					// }

					// 	fwrite(&(reg->x[i->rs2]),4,1,fp);

					// 		fclose(fp);
					// }

					}else{
						fprintf(stderr,"ストア命令はswしかサポートしていません。");
					}
				}
				reg->pc++;

			}else if ( i->opcode == OP_ALUI && i->rd != 0) {						//opcode rd, rs1, imm

					reg->x[i->rd] = 	(i->funct3 == ALU_ADD) ? reg->x[i->rs1] + i->imm:
										(i->funct3 == ALU_SLL) ? reg->x[i->rs1] << i->imm:
										(i->funct3 == ALU_SLT) ? ((int)reg->x[i->rs1] < i->imm ? 1:0):
										(i->funct3 == ALU_SLTU) ? ((unsigned int)reg->x[i->rs1] < (unsigned int)i->imm ? 1:0 ) :
										(i->funct3 == ALU_XOR) ? reg->x[i->rs1] ^ i->imm:
										(i->funct3 == ALU_SRX) ? ( i->is_sra_sub ? reg->x[i->rs1] >> i->imm : reg->x[i->rs1] >> i->imm):
										(i->funct3 == ALU_OR) ? reg->x[i->rs1] | i->imm:
										(i->funct3 == ALU_AND) ? reg->x[i->rs1] & i->imm: 0;
					(reg->pc)++;
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
					reg->pc++;

			} else if(i->opcode == OP_FP){

				if(i->funct5 == F5_FADD){
					reg->f[i->rd] = reg->f[i->rs1] + reg->f[i->rs2];
				}else if(i->funct5 == F5_FSUB){
					reg->f[i->rd] = reg->f[i->rs1] - reg->f[i->rs2];
				}else if(i->funct5 == F5_FMUL){
					reg->f[i->rd] = reg->f[i->rs1] * reg->f[i->rs2];
				}else if(i->funct5 == F5_FDIV){
					reg->f[i->rd] = reg->f[i->rs1] / reg->f[i->rs2];
				}else if(i->funct5 == F5_FSQRT){
					float ff = 0;

					ff = fabsf(reg->f[i->rs1]);
					ff = sqrtf((float)ff);

				}else if(i->funct5 == F5_FCMP){
					reg->x[i->rd] = (i->funct3 == F3_FEQ) ? (reg->f[i->rs1] == reg->f[i->rs2] ? 1 : 0) :
									(i->funct3 == F3_FLT) ? (reg->f[i->rs1] <  reg->f[i->rs2] ? 1 : 0) :
									(i->funct3 == F3_FLE) ? (reg->f[i->rs1] <= reg->f[i->rs2] ? 1 : 0):
									0;
				}else if(i->funct5 == F5_FTOI){
					// if();


				}else if(i->funct5 == F5_FTOX){
					reg->x[i->rd] = reg->f[i->rs1];
				}else if(i->funct5 == F5_ITOF){
					reg->f[i->rd] = (float)reg->x[i->rd];
				}else if(i->funct5 == F5_XTOF){
					reg->f[i->rd] = reg->x[i->rd];
				}else{
					fprintf(stderr,"invalid operation of F_OP\n");
					return;
				}
				reg->pc++;
			} else if(i->opcode == OP_STORE_FP){


			} else if(i->opcode == OP_LOAD_FP){

					reg->f[i->rd] = memory[i->rs1+i->imm];
			}else {
				fprintf(stderr,"invalid opcode:\t0b");
				fprint_bin(stderr,i->opcode,6,0);
				fputc('\n',stderr);
			}

}





int  exec_program(Program program,Reg reg,Mem mem,Data d){
	Instr instr;
	int instr_count = 0;
	while((instr=program[reg->pc]) != NULL){
		exec_instr(instr,mem,reg,d);
	}
	return instr_count;
}


word create_machine_code(Instr i){
	word code = 0;
	// code |= 0b11;//下位2ビットは 11
	int opcode = i-> opcode;
	code |= opcode;
	//rd
	if(opcode == OP_LUI || opcode == OP_AUIPC || opcode == OP_JAL || opcode == OP_JALR || opcode == OP_LOAD || opcode == OP_ALUI || opcode == OP_ALU){
		code |= (i->rd & 0b11111) << 7;
		if(i->rd > 31)fprintf(stderr,"invalid value of rd:%d\n",i->rd);
	}
	//funct3
	if(opcode == OP_BRANCH || opcode == OP_LOAD || opcode == OP_STORE || opcode == OP_ALU || opcode == OP_ALUI){
		code |= (i->funct3 & 0b111) <<12 ;
		if(i->funct3 > 7)fprintf(stderr,"invalid value of funct3:%d\n",i->funct3);
	}
	//rs1
	if (opcode ==OP_JALR || opcode == OP_BRANCH || opcode == OP_LOAD || opcode == OP_STORE || opcode == OP_ALU || opcode == OP_ALUI){
		code |= (i->rs1 & 0b11111) << 15;
		if(i->rs1 > 31)fprintf(stderr,"invalid value of rs1:%d\n",i->rs1);
	}
	//rs2
	if (opcode == OP_BRANCH || opcode == OP_STORE || opcode == OP_ALU){
		code |= (i->rs2 & 0b11111) << 20;
		if(i->rs2 > 31)fprintf(stderr,"invalid value of rs2:%2x",i->rs2);
	}
	//imm U
	if(opcode == OP_LUI || opcode == OP_AUIPC){
		code |= i->imm<<12;
	}else if(opcode == OP_JAL){
	 // if(i->imm < 0)code |= 1<<31;
		code |= i->imm << 12;

	}else if(opcode == OP_JALR || opcode == OP_LOAD || opcode == OP_ALUI){
		code |= i->imm << 20;
	}else if (opcode == OP_BRANCH || opcode == OP_STORE)
	{
		code |= (i->imm & 0b11111)<<7;
		code |= (( unsigned int )i->imm / 1<<5 )<<25;
	}
	return code;
}


void generate_binary(Program program,char *filename){

	unsigned int machine_code;
	FILE* fp;

	if ((fp = fopen(filename, "wb")) == NULL) {
		perror("file open error!!\n");
	}

	for (int i = 0; program[i] != NULL;i++)
	{
		machine_code = create_machine_code(program[i]);
		program[i]->machine_code = machine_code;
		write_word(machine_code,fp);

	}

	fclose(fp);

}

void write_word(word d,FILE *fp){
	for(int i = 7; i >= 0;i--){
		putc(d/(1<<(i*8)),fp);
		d %= 1<<i*8;
	}
}
//%bが欲しいけどないから%dで使えるように作った。
int get_b_form(int d){
	int b = 0;
	for(int i = 1; d!= 0;i *= 10){
		b += (d%2) * i;
		d /= 2;
	}
	return b;
}

Mem initialize_memory(int memsize,Mem p){
	if(p != NULL){
		bzero(p,MEMORY_SIZE);
		return p;
	}else{
		return calloc(MEMORY_SIZE,sizeof(word));
	}
}

Reg initialize_reg(Reg reg){
	if(reg == NULL){
	reg = malloc(sizeof(struct _reg));
	reg->pc = 0;
	}

	for(int i = 0;i<32;i++)
		reg->x[i] = reg->f[i] = 0;
	return reg;
}
// floatをbit列として取得する用
union w {
	float f;
	unsigned int u;
};

Data initialize_data(Data d){
	if(d == NULL)
		d = malloc(sizeof(struct _data));
	d->instr_count = 0;
	bzero( d->b_list,32 * sizeof(Cond));
	bzero( d->w_list ,32 * sizeof(Cond));
	bzero( d->d_list ,32 * sizeof(Cond));
	d->b_count = 0;
	d->time = 0;
	bzero( d->op_count ,64 * sizeof(int));
	d->llist = NULL;
	return d;
}



