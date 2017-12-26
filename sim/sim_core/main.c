#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include "include.h"

#define _BYTE1(x) (  x        & 0xFF )
#define _BYTE2(x) ( (x >>  8) & 0xFF )
#define _BYTE3(x) ( (x >> 16) & 0xFF )
#define _BYTE4(x) ( (x >> 24) & 0xFF )
#define BYTE_SWAP_16(x) ((uint16_t)( _BYTE1(x)<<8 | _BYTE2(x) ))
#define BYTE_SWAP_32(x) ((uint32_t)( _BYTE1(x)<<24 | _BYTE2(x)<<16 | _BYTE3(x)<<8 | _BYTE4(x) ))
extern uint8_t sld_bytes[];
extern unsigned sld_n_bytes;

int main(int argc, char **argv)
{

	parse_commandline_arg(argc,argv);
	// runtime = initialize_runtime(NULL);
	Mem memory = initialize_memory(MEMORY_SIZE,NULL);
	Reg reg = initialize_reg(NULL);
    LList llist = initialize_llist();
	Program program = load_asm_file(source_filename,llist);
	// print_labels(llist);
	char buff[BUF_SIZE];
	char prev_buff[BUF_SIZE];
	char filename[BUF_SIZE];
	char *tmp;
	char command[BUF_SIZE];
 	Instr instr;
	int count = 0;
	int n = 1;
	int data = 0;
	char c = 0;

// initial header print
	while(get_line(buff,BUF_SIZE)){
		tmp = buff +  strspn(buff," \t\n");
		if(strlen(tmp) == 0){
			strcpy(tmp,prev_buff);
		}else{
			strcpy(prev_buff,tmp);
		}

		sscanf(tmp,"%s",command);
		tmp += strlen(command);

		if(strcmp("run",command) == 0 || strcmp("r",command) == 0){
			GETTIME_FROM(ts,t);
			count = exec_program(program,reg,memory);
			GETTIME_TO(ts,t);
			printf("execution:\t%lfsec\n",t);
			printf("%d\n",count);
			printf("動的命令数:%3.2f億\n",(float)count/100000000.0);
			printf("毎秒%3.2f億命令実行\n",count/t/100000000);
			fflush(out_fp);
			fclose(out_fp);
		}else if(strcmp("next",command) == 0 || strcmp("n",command) == 0){
			// ステップ数を指定 指定がなければ1をセット
			n = 1;
			if(!sscanf(tmp," %d",&n)) n = 1;

			for(int i = 0 ; i < n; i++){
				if((instr = program[reg->pc]) == NULL || program[reg->pc]->opcode == OP_HLT || program[reg->pc]->opcode == OP_LOAD_IO|| program[reg->pc]->opcode == OP_STORE_IO ){
					fprintf(stderr,"end of program\n");
					break;
				}
				print_label_of_pc(reg->pc, llist);
				printf("addr:%6d  ",reg->pc);
				printf("line:%4d\t",instr->line);
				print_instr(instr);
				exec_instr(instr,memory,reg);
				if(instr->src_break){
					printf("ソースコードで指定されたbreak\n");
					break;
				}
			}
		}else if(strcmp("countinue",command) == 0 || strcmp("c",command) == 0){

			// continue_program(program,reg,memory);

		}else if(strcmp("set",command) == 0 || strcmp("s",command) == 0){

			if(sscanf(tmp," x%d",&n) ){
				if(n > 0 && n < 32){
					if((tmp  = strchr(tmp,'=')) != NULL){
						tmp++;
						if(sscanf(tmp," 0x%x",&data) || sscanf(tmp," %d",&data) )reg->x[n] = data;
						else fprintf(stderr,"data error");
					}else {
						fprintf(stderr,"format error\n");
					}
				}else fprintf(stderr,"x%d cannot be over written or not exists\n",n);
			}else if(sscanf(tmp," f%d",&n)){
				if(n > 0 && n <11){
					if((tmp  = strchr(tmp,'=')) != NULL){
						tmp++;
					if(!sscanf(tmp," %f",&reg->f[n]))fprintf(stderr,"data error");
					}else{
						fprintf(stderr,"format error\n");
					}
				}else fprintf(stderr,"f%d cannot be over written\n",n);
			}else if (strcmp(tmp,"output") == 0){
				if((tmp  = strchr(tmp,'=')) != NULL){
						tmp++;
						sscanf(tmp," %s",filename);
					}else{
						fprintf(stderr,"format error\n");
					}
				if((out_fp = fopen(filename,"a"))){
					printf("出力ファイルを%sに更新しました\n",filename);
				}else {
					printf("ファイル%sを開けませんでした\n",filename);
					printf("出力ファイルを再設定してください\n");
				}
			}

		}else if(strcmp("info",command) == 0 || strcmp("i",command) == 0){
			sscanf(tmp,"%s",command);
			if(strcmp(command,"x") == 0){
				print_reg(reg, PRINT_REG_X_D);
			}else if(strcmp(command,"x/x") == 0){
				print_reg(reg,PRINT_REG_X_X);
			}else if(strcmp(command,"x/b") == 0){
				print_reg(reg,PRINT_REG_X_B);
			}else if(strcmp(command,"f") == 0){
				print_reg(reg,PRINT_REG_F);
			}else if(strcmp(command,"f/x") == 0){
				print_reg(reg,PRINT_REG_F_X);
			}else if(strcmp(command,"f/b") == 0){
				print_reg(reg,PRINT_REG_F_B);
			}else if(strcmp(command,"r") == 0){
				print_reg(reg,PRINT_REG_F | PRINT_REG_X_X | PRINT_REG_PC);
			}else if(strcmp(command,"p") == 0 || strcmp(command,"program") == 0){
				tmp +=  strlen(command) + 1;
				// printf("%s",tmp);
				n = PROGRAM_SIZE;
				sscanf(tmp,"%d",&n);
				print_program(program,0,n);
			}else if(strcmp(command,"l") == 0 || strcmp(command,"label") == 0){
				print_labels(llist);
			}else if(strcmp(command,"n") == 0 || strcmp(command,"next") == 0){
				tmp += strlen(command);
				if(!sscanf(tmp,"%d",&n)) n = 0;
				print_instr(program[reg->pc + n]);
			}else if(strcmp(command,"l") == 0 || strcmp(command,"label") == 0){
				print_labels(llist);
			}else if(strcmp(command,"sld") == 0){
				printf("sld_n_bytes:%d\n",sld_n_bytes);
				tmp += strlen(command) + 1;
				// printf("%s",tmp);
				n = sld_n_bytes / 4;
				sscanf(tmp,"%d",&n);
				uint32_t *p;
				p = (uint32_t *)sld_bytes;
				word w;
				for(int i = 0; i<n; i++){
					w.x = BYTE_SWAP_32(p[i]);
					printf("%5d:%d,%f\n",i,w.x,w.f);
				}
			}

		}else if(strcmp("break",command) == 0 || strcmp("b",command) == 0){

		}else if(strcmp("delete",command) == 0 || strcmp("d",command) == 0){

		}else if(strcmp("display",command) == 0){

		}else if(strcmp("print",command) == 0 || strcmp("p",command) == 0){
			sscanf(tmp,"%s",command);
			if(sscanf(tmp," x%d",&n) ){
				printf(" x%d:\t0x%d\n",n,reg->x[n]);
			}else if(sscanf(tmp," f%d",&n)){
				printf(" f%d:\t%f\n",n,reg->f[n]);
			}else if(strcmp(command,"pc") == 0){
				printf(" pc:\t%08x\n",reg->pc);
			}else if(strcmp(command,"pcd") == 0){
				printf(" pc:\t%08d\n",reg->pc);
			}
		}else if(strcmp("reset",command) == 0 || strcmp("r",command) == 0){
			sscanf(tmp,"%s",command);
			if(strcmp(command,"reg") == 0 ){
				reg = initialize_reg(reg);
			}else if(strcmp(command,"memory") == 0){
				memory = initialize_memory(MEMORY_SIZE,memory);
			}
		}else if(strcmp("load",command) == 0 || strcmp("l",command) == 0){

			tmp += strlen(command);
			char filename[128];
			if(!sscanf(tmp," %s %s",command,filename)){
				fprintf(stderr,"error the usage of load command\n");
				continue;
			}

			if(strcmp(command,"source") == 0 ||strcmp(command,"src") == 0 ||strcmp(command,"s") == 0 ){

			}

		}else if(strcmp("help",command) == 0 || strcmp("h",command) == 0){
				system("less ./readme.txt");

		}else if(strcmp("quit",command) == 0 || strcmp("q",command) == 0){
			exit(EXIT_SUCCESS);

		}else if(strncmp(command,"x/",2) == 0 ){//メモリ表示
			tmp-=strlen(command);
			if(sscanf(tmp,"x/%d%c 0x%x",&n,&c,&data) == 3) print_memory(memory,data,n,c);
			else if(!sscanf(tmp,"x/%d%c %d",&n,&c,&data)) fprintf(stderr,"error 1");
			else print_memory(memory,data,n,c);
		}else{
			fprintf(stderr,"command error\n");
		}
	}
	return 0;
}
