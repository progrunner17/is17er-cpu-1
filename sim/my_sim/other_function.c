#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <unistd.h>
#include <errno.h>
#include "include.h"

FILE *log_fp = NULL;
FILE *out_fp = NULL;
FILE *in_fp = NULL;
char *machine_filename = NULL;
char *source_filename = NULL;
char *input_filename = NULL;
char *output_filename = NULL;
char *log_filename = NULL;

//デバッグ用フラグ
int check_bin_code=1;//file_load内でbin_codeの各要素をプリントさせる。

int ctob(char c){
	switch(c){
		case '\0':return -1;
		case '0':return 0;
		case '1':return 1;
		default: return 2;
	}
}

BinaryCode initialize_binary_code(void){
	BinaryCode bin_code;
	bin_code=calloc(PROGRAM_SIZE,sizeof(instruction)*32);

	return bin_code;
};

BinaryCode file_load(FILE *fp){
//デバッグ用↓
	FILE *fp_hoge;
	if(check_bin_code){
		if((fp_hoge=fopen("hoge.txt","w"))==NULL){
			fprintf(stderr,"check_bin_codeファイルオープン失敗");
		}
	}
//デバッグ用↑

	BinaryCode bin_code;
	bin_code=initialize_binary_code();
	char *s;
	int i=0;
	int j=0;
	int count;
	int b;//読み取っているファイル内容の一文字（0or1orナル文字）
	
	s=calloc(PROGRAM_SIZE,sizeof(char));
	while(fscanf(fp,"%s",s) != EOF){
		count=0;
		b=ctob(s[count]);	//0,1のとき0,1、停止するとき（\0のとき）-1、その他の文字のとき2となるようにctoiが変換している
		while(b>-1){	//ナル文字でなければ
			if(b==0||b==1){	//b==2は無視することに注意
				bin_code[i][31-j]=b;
				if(j<31){
					j++;
				}else{
					j=0;
					i++;
				}
			}
			count++;
			b=ctob(s[count]);	//0,1のとき0,1、停止するとき（\0のとき）-1、その他の文字のとき2となるようにctoiが変換している

//デバッグ用↓
			if(check_bin_code){
				fprintf(fp_hoge,"bin_code[%d][%d]=%d\n",i,j,bin_code[i][j]);
//デバッグ用↑
			}
		}
	}
	return bin_code;
}

int bintonm(instruction instr,int i0,int i1){
	int i;
	int c=0;
	int sum=0;
	for(i=i0;i<=i1;i++){
		sum=sum+instr[i]*pow(2,c);
		c++;
	}
	return sum;
}

int immtonm(instruction instr,int opcode){
	int retval;
	switch(opcode){
		case OP_LUI:
			retval=bintonm(instr,12,31)*pow(2,12);
		break;
		case OP_AUIPC:
			retval=bintonm(instr,12,31)*pow(2,12);
		break;
		case OP_JAL:
			retval=bintonm(instr,31,31)*pow(2,20)
				+bintonm(instr,21,30)*pow(2,1)
				+bintonm(instr,20,20)*pow(2,11)
				+bintonm(instr,12,19)*pow(2,12);
		break;
		case OP_JALR:
			retval=bintonm(instr,20,31);
		break;
		case OP_BRANCH:
			retval=bintonm(instr,31,31)*pow(2,12)
				+bintonm(instr,25,30)*pow(2,5)
				+bintonm(instr,8,11)*pow(2,1)
				+bintonm(instr,7,7)*pow(2,11);
		break;
		case OP_LOAD:
			retval=bintonm(instr,20,31);
		break;
		case OP_STORE:
			retval=bintonm(instr,25,31)*pow(2,5)
				+bintonm(instr,7,11);
		break;
		case OP_ALUI:
			retval=bintonm(instr,20,31);		
		break;
		case OP_ALU:
			retval=0;
		break;
		case OP_LOAD_FP:
			retval=bintonm(instr,20,31);
		break;
		case OP_STORE_FP:
			retval=bintonm(instr,25,31)*pow(2,5)
				+bintonm(instr,7,11);
		break;
		case OP_FP:
			retval=0;
		break;
		case OP_LOAD_IO:
			retval=0;//自信ない
		break;
		case OP_STORE_IO:
			retval=0;//自信ない
		break;
		case OP_HLT:
			retval=0;
		break;
		default: 
			retval=0;
	}
	return retval;
}

Machine initialize_machine(void){
	Machine mac;
	int i;
	mac=malloc(sizeof(struct machine));
	mac->pc=0;
	mac->fcsr=0;
	for(i=0;i<32;i++)
		mac->x[i]=0;
	for(i=0;i<=10;i++)
		mac->f[i]=0;
//以下、sim_core/util.c l.538~558コピペ
	mac->f[11] = 1.0;
	mac->f[12] = 2.0;
	mac->f[13] = 4.0;
	mac->f[14] = 10.0;
	mac->f[15] = 15.0;
	mac->f[16] = 20.0;
	mac->f[17] = 128.0;
	mac->f[18] = 200.0;
	mac->f[19] = 255.0;
	mac->f[20] = 850.0;
	mac->f[21] = 0.100;
	mac->f[22] = 0.200;
	mac->f[23] = 0.001;
	mac->f[24] = 0.005;
	mac->f[25] = 0.150;
	mac->f[26] = 0.250;
	mac->f[27] = 0.500;
	mac->f[28] = M_PI;
	mac->f[29] = 30.0 / M_PI;
	mac->f[30] = 0;
	mac->f[31] = 0;
	mac->mem=calloc(MEMORY_SIZE,sizeof(int));
	mac->fmem=calloc(MEMORY_SIZE,sizeof(float));
	mac->stack_max=0;
	mac->heap_max=0;

	return mac;
}


int nextpc(int pc){
 return	pc+1;
}

char* get_line(char *s, int size) {
  printf(">> ");
  while (fgets(s, size, stdin) == NULL) {
    if (errno == EINTR)
      continue;
    return NULL;
  }
  return s;
}

void parse_commandline_arg(int argc, char **argv) {
  log_fp = stderr;
  out_fp = stdout;
  in_fp = stdin;

  int opt;
  opterr = 0;
  while ((opt = getopt(argc, argv, "m:s:i:o:l")) != -1) {
    //コマンドライン引数のオプションがなくなるまで繰り返す
    switch (opt) {
      case 'm':
        machine_filename = (char *) malloc(strlen(optarg) + 1);
        strcpy(machine_filename, optarg);
        break;

      case 's':
        source_filename = (char *) malloc(strlen(optarg) + 1);
        strcpy(source_filename, optarg);
        break;

      case 'l':
        log_filename = (char *) malloc(strlen(optarg) + 1);
        strcpy(log_filename, optarg);
        log_fp = fopen(optarg,"a");
        break;

      case 'i':
        input_filename = (char *) malloc(strlen(optarg) + 1);
        strcpy(input_filename, optarg);
        load_sld_file(input_filename,1); 
        break;

      case 'o':
        output_filename = (char *) malloc(strlen(optarg) + 1);
        strcpy(output_filename, optarg);
        break;

      default: /* '?' */
        //指定していないオプションが渡された場合
        // printf("Usage: %s [-f] [-g] [-h argment] arg1 ...\n", argv[0]);
        fprintf(log_fp, "[ERROR]@parse_commandline_arg:\tinvalid option\n"); break;
    }
  }


  fprintf(log_fp, "-- files ---------------------------------------------------------------\n");
  fflush(stdout);

  if (!source_filename) {
    char buff[BUF_SIZE];
    printf("please input source file name\n>> ");
    if(fgets(buff, BUF_SIZE, stdin) == NULL){
        printf("fgets error\n");
    }
    source_filename =(char *)  malloc(BUF_SIZE);
    sscanf(buff, "%s", source_filename);
  }

  fprintf(log_fp, "source_file:\t\t%s\n", source_filename);
  fflush(stdout);

  fprintf(log_fp, "machine_code_file\t");
  if (machine_filename)printf("%s\n", machine_filename); //NULLじゃなかったら
  else {
    if (machine_filename) machine_filename = (char *) realloc(machine_filename , strlen("machine.cpu") + 1);
    else machine_filename =  (char *)malloc(strlen("machine.cpu") + 1);
    fprintf(log_fp, "machine.cpu(default)\n");
  }


  fprintf(log_fp, "log_file:\t\t");
  if (log_filename) {
    fprintf(log_fp, "%s\n", log_filename);
  } else {
    fprintf(log_fp, "stderr\n");
  }


  fprintf(log_fp, "input_file:\t\t");
  if (input_filename){
    fprintf(log_fp, "%s\n", input_filename);
    in_fp = fopen(input_filename, "r");
  }
  else{
    fprintf(log_fp, "unset\n");
    in_fp = stdin;
  }


  fprintf(log_fp, "output_file:\t\t");
  if (output_filename) {
    fprintf(log_fp, "%s\n", output_filename);
  } else {
    if (output_filename) output_filename = (char *)realloc(output_filename , strlen("sim.out") + 1);
    else output_filename =  (char *)malloc(strlen("sim.out") + 1);
    strcpy(output_filename, "sim.out");
    fprintf(log_fp, "sim.out(default)\n");
  }
  out_fp =  fopen(output_filename, "w");

  fprintf(log_fp, "------------------------------------------------------------------------\n");
}
