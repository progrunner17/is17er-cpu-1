#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <errno.h>
#include "include.h"
#include "other_function.h"
#include "exec_function2.h"

struct timespec ts;
double t;
#define GETTIME_FROM(ts,t)  {clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9;}
#define GETTIME_TO(ts,t) {clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9 - t;}


int main(int argc,char **argv){
	parse_commandline_arg(argc,argv);
	char buff[BUF_SIZE];
	char prev_buff[BUF_SIZE];
	char *tmp;
	char command[BUF_SIZE];
	FILE *fp;
	int n,n0,n1;
	Machine mac;
	mac=initialize_machine();

	while((get_line(buff,BUF_SIZE))!=NULL){
//↓sim_core/main.cよりコピペ。コマンド読む。
		tmp = buff +  strspn(buff," \t\n");
		if(strlen(tmp) == 0){
			strcpy(tmp,prev_buff);
		}else{
			strcpy(prev_buff,tmp);
		}

		sscanf(tmp,"%s",command);
		tmp += strlen(command);
//↑sim_core/main.cよりコピペ
		fp=fopen(source_filename,"r");
		if(strcmp("run",command)==0||strcmp("r",command)==0){
			GETTIME_FROM(ts,t);
			program_exec(fp,mac,-1,-1,-1,-1);
			GETTIME_TO(ts,t);
			printf("execution:\t%lfsec\n",t);
			printf("スタック使用量:%7dword(%08xword)\n",mac->stack_max-(1<<17),mac->stack_max-(1<<17));
			printf("ヒープ使用量:%7dword(%08xword)\n",mac->heap_max,mac->heap_max);
			fflush(out_fp);
			fclose(out_fp);	
		}else if(strcmp("log",command)==0||strcmp("l",command)==0){
			sscanf(tmp,"%s",command);
			if(sscanf(tmp," %d %d",&n0,&n1) ){
				program_exec(fp,mac,-1,-1,n0,n1);
			}
		}else if(strcmp("continue",command)==0||strcmp("c",command)==0){
			mac=initialize_machine();
			fp=fopen(source_filename,"r");			
			sscanf(tmp,"%s",command);
			if(sscanf(tmp," %d",&n0) ){
				program_exec(fp,mac,n0,-1,-1,-1);
			}
		}else if(strcmp("next",command)==0||strcmp("n",command)==0){
			sscanf(tmp,"%s",command);
			if(sscanf(tmp," %d",&n0) ){
				program_exec(fp,mac,n0,-1,-1,-1);
			}
		}else if(strcmp("opcode_next",command)==0||strcmp("o",command)==0){
			sscanf(tmp,"%s",command);
			if(sscanf(tmp," %d",&n0) ){
				program_exec(fp,mac,-1,n0,-1,-1);
			}
		}else if(strcmp("help",command)==0||strcmp("h",command)==0){
			if(system("less ./readme.txt") == -1){
		        	printf("system error\n");
			}
		}else if(strcmp("print",command)==0||strcmp("p",command)==0){
			sscanf(tmp,"%s",command);
			if(sscanf(tmp," x%d",&n) ){
				printf(" x%d:\t%d\n",n,mac->x[n]);
			}else if(sscanf(tmp," f%d",&n)){
				printf(" f%d:\t%f\n",n,mac->f[n]);
			}else if(sscanf(tmp," fm%d",&n)==0){
				printf(" memory%d:\t%f\n",n,mac->fmem[n]);
			}else if(sscanf(tmp," m%d",&n)==0){
				printf(" memory%d:\t%d\n",n,mac->mem[n]);
			}else if(strcmp(command,"pcx") == 0||strcmp(command,"pc") == 0){
				printf(" pc:\t0x%08x\n",mac->pc);
			}else if(strcmp(command,"pcd") == 0){
				printf(" pc:\t%08d\n",mac->pc);
			}else if(strcmp(tmp," all")==0){
				for(n=0;n<32;n++)
					printf(" x%d:\t%d\n",n,mac->x[n]);
				for(n=0;n<32;n++)
					printf(" f%d:\t%f\n",n,mac->f[n]);
				printf(" pc(16進数):\t0x%08x\n",mac->pc);
				printf(" pc(10進数):\t%08d\n",mac->pc);
			}
		}else if(strcmp("initialize",command)==0||strcmp("i",command)==0){
			mac=initialize_machine();
		}else if(strcmp("quit",command)==0||strcmp("q",command)==0){
			exit(EXIT_SUCCESS);
		}else{
			fprintf(stderr,"command error");
		}
	}
	return 0;
}
