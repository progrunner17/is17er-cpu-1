#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include "include.h"
#include "size.h"

// freeが適当だからしっかり
// ブレイクポイントの一覧も表示したい。
// 今はオプション指定方法が適当だからちゃんとしたい。cf exex_instr
// Program型が今はInstrの配列になっているけど、LList,Mem,Regもまとめた構造体にしたい。
// コードが大きくなって可読性が下がったからもう少しファイルを分割すると良さそう。
// せっかくだからアセンブラも統合したい
// デバッグ用にstruct instruction全て表示する関数もあったら良さそう。
// バイナリを読み込んでProgram型を返すload_binaryもあったら良さそう。
// つまり逆アセンブルできるように
// immediateが有効な範囲かどうか判定する関数があったら良さそう。
// その際にオペコードから即値のタイプを判断する関数と、可読性向上のために可読性向上タイプを表す定数をヘッダに追加
// コマンドライン引数を判定するようにしたい。
// floatとintを同じbit列が出るようなunsigned intに変換できる関数があったら良さそう。
// exec_instrがロード命令とストア命令がwordサイズにしか対応していないから、そのほかの対応も。
// ロードの際に、現状ラベルで読み込むところを即値でも読み込めるようにしたら良さそう。%sをしないでfgetcを使うとか??
// 命令実行の際などにopcode,funct3等が有効かどうか判断する関数があったら良さそうint funct3_is_valid(int opcode,int funct3)みたいな
//  -src の後の引数をファイルとして読むとか
// vcdファイルを出力できればレジスタの遷移を追えて良いかも？？
// もっと簡単な対話型の環境があったら良さそう。
	// シェルを作った時のparse.cを流用できそう
	// ステップ実行とか
	// メモリやレジスタの初期化
	// メモリやレジスタの操作
	// 直接命令を書いて実行するとか。
	// ブレークポイント設定。ラベルや行番号。



extern FILE *log_fp;
extern FILE *out_fp;
extern FILE *in_fp;

Runtime runtime = NULL;

int main(int argc, char **argv)
{
	Program program = NULL;
	Mem memory = NULL;
	struct timespec ts;
	double t = 0;
	Reg reg = NULL;
	Files files = NULL;
	char buff[BUF_SIZE];
	char* tmp;
	char command[BUF_SIZE];
 	Instr instr;
 	// int display_opt = 0;

	runtime = initialize_runtime(NULL);

	files = parse_commandline_arg(argc,argv);
	// printf("load program \n\n");
 	program = load_asm_file(files->source_filename);
	memory = initialize_memory(MEMORY_SIZE,NULL);
	reg = initialize_reg(NULL);

	runtime->files = files;
	runtime->reg = reg;
	runtime->program = program;
	runtime->memory = memory;
	// print_prgram(program);
// initial header print
	while(get_line(buff,BUF_SIZE)){
		tmp = buff +  strspn(buff," \t\n");
		if(strlen(tmp) == 0)continue;

		sscanf(tmp,"%s",command);
		if(strcmp("run",command) == 0 || strcmp("r",command) == 0){
			// memory = initialize_memory(MEMORY_SIZE,memory);
			// reg = initialize_reg(reg);
			reg->pc = 0;
			GETTIME_FROM(ts,t);
			exec_program(program,reg,memory);
			GETTIME_TO(ts,t);
			printf("execution:\t%lfsec\n",t);
		}else if(strcmp("next",command) == 0 || strcmp("n",command) == 0){
			int n = 1;
			tmp += strlen(command);
			if(!sscanf(tmp," %d",&n)) n = 1;
			for(int i = 0 ; i < n; i++){



			if((instr = program[reg->pc]) == NULL){
				fprintf(stderr,"end of program\n");
				break;
			}
				printf("0x%08x\t",reg->pc);
				print_instr(instr);
				exec_instr(instr,memory,reg);
			}

		}else if(strcmp("countinue",command) == 0 || strcmp("c",command) == 0){

			// continue_program(program,reg,memory);

		}else if(strcmp("set",command) == 0 || strcmp("s",command) == 0){

			tmp += strlen(command);
			int n;
			int data;
			if(sscanf(tmp," x%d",&n) ){
				if(n > 0 && n < 32){
					if((tmp  = strchr(tmp,'=')) != NULL){
						tmp++;
						if(sscanf(tmp," 0x%x",&data) || sscanf(tmp," %d",&data) )reg->x[n] = data;
						else fprintf(stderr,"data error");
					}else {
						fprintf(stderr,"format error\n");
					}

				}else fprintf(stderr,"x%d cannot be over written\n",n);
			}else if(sscanf(tmp," f%d",&n)){
				if(n > 0 && n <11){

					if((tmp  = strchr(tmp,'=')) != NULL){
						tmp++;
					if(!sscanf(tmp," %f",&reg->f[n]))fprintf(stderr,"data error");
					}else {
						fprintf(stderr,"format error\n");
					}
				}else fprintf(stderr,"f%d cannot be over written\n",n);
			}

		}else if(strcmp("info",command) == 0 || strcmp("i",command) == 0){
			tmp += strlen(command);
			sscanf(tmp,"%s",command);
			if(strcmp(command,"x") == 0){
				print_reg(reg,PRINT_REG_X_X);
			}else if(strcmp(command,"f") == 0){
				print_reg(reg,PRINT_REG_F);
			}else if(strcmp(command,"r") == 0){
				print_reg(reg,PRINT_REG_F | PRINT_REG_X_X | PRINT_REG_PC);
			}else if(strcmp(command,"p") == 0 || strcmp(command,"program") == 0){
				print_prgram(program);
			}else if(strcmp(command,"l") == 0 || strcmp(command,"label") == 0){
				print_labels(runtime->llist);
			}else if(strcmp(command,"n") == 0 || strcmp(command,"next") == 0){
				tmp += strlen(command);
				int n = 0;
				if(!sscanf(tmp,"%d",&n)) n = 1;
				for(int i = 0;i < n;i++){
				print_instr(program[reg->pc + i]);
				}
			}else if(strcmp(command,"l") == 0 || strcmp(command,"label") == 0){
				print_labels(runtime->llist);
			}

		}else if(strcmp("break",command) == 0 || strcmp("b",command) == 0){

		}else if(strcmp("delete",command) == 0 || strcmp("d",command) == 0){

		}else if(strcmp("display",command) == 0){
			// pc
			// x, xn
			// f, fn
			// mem

		}else if(strcmp("print",command) == 0 || strcmp("p",command) == 0){

			tmp += strlen(command);
			sscanf(tmp,"%s",command);
			int n;
			if(sscanf(tmp," x%d",&n) ){

				printf(" x%d:\t0x%08x\n",n,reg->x[n]);

			}else if(sscanf(tmp," f%d",&n)){
				printf(" f%d:\t%f\n",n,reg->f[n]);
			}else if(strcmp(command,"pc") == 0){
				printf(" pc:\t%08x\n",reg->pc);
			}

		}else if(strcmp("reset",command) == 0 || strcmp("r",command) == 0){

			tmp += strlen(command);
			sscanf(tmp,"%s",command);

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
			int size = 0;
			char c;
			if(sscanf(tmp,"x/%d %c",&size,&c) != 2) fprintf(stderr,"error 1");
		}else{
			fprintf(stderr,"command error\n");

		}
	}
	return 0;
}
