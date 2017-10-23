#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <errno.h>
#include "include.h"

#define PROMPT ">>"
#define BUF_SIZE

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


int main(int argc, char const *argv[])
{
	Program program;
	Mem memory;//配列
	struct timespec ts;
	double t = 0;
	Reg reg;
	int base_addr = BASE_ADDR;
	int count,cmd,cmd1,cmd2;
	int option = 0;

	memory = initialize_memory(MEMORY_SIZE);
	reg = initialize_reg(base_addr);
	program = load_assembly(argv[1],0);

	print_prgram(program);
	Instr inst;

	while(1){
		printf("以下の数字を入力してください\n");
		printf("全実行:\t\t\t0\n");
		printf("ステップ実行:\t\t1\n");
		printf("メモリ表示:\t\t2\n");
		printf("レジスタ表示:\t\t3\n");
		printf("処理時間表示:\t\t4\n");
		printf("命令数を指定して実行:\t5\n");
		printf("オプション指定:\t\t6\n");
		printf("1億命令あたりの実行時間測定:7\n");
		if(scanf("%d",&cmd)  == EOF) break;
		if(cmd == 0){
			GETTIME_FROM(ts,t);
			count = exec_program(program,reg,memory,base_addr,option);
			GETTIME_TO(ts,t);
		}else if(cmd == 1){
			inst = program[(reg->pc - base_addr)/4];
			if(inst != NULL) {
				exec_instr(inst,memory,reg,option);
				count++;
			}
		}else if (cmd == 2) {
			printf("アドレス(16進) サイズ\n");
			scanf("%x %d",&cmd1,&cmd2);
			print_memory(memory,cmd1,cmd2);
		}else if(cmd == 3){
			print_reg(reg);
		}else if (cmd == 4) {
			printf("処理時間:%lf\n",t);
		}else if(cmd == 5){
			printf("命令数\n");
			scanf("%d",&cmd1);
			for(int i = 0; i<cmd1;i++){
				inst = program[(reg->pc - base_addr)/4];
				if(inst != NULL) {
					exec_instr(inst,memory,reg,option);
					count++;
				}else{
					printf("end of program\n");
					break;
				}
			}
		}else if(cmd == 6){
			printf("オプション指定\n");
			printf("レジスタ表示:1\n命令表示:2\npc表示:4\nのxor\n");
			scanf("%d",&cmd1);
			option = cmd1;
		}else if(cmd == 7){
			inst = initialize_instr();
			inst->opcode = OP_ALUI;
			inst->funct3 = ALU_ADD;
			inst->rs1 = 1;
			inst->rs2 = 1;
			inst->rd = 1;
			inst->imm = 1;
			GETTIME_FROM(ts,t);
			for(int i = 0;i < 100000000;i++){
				exec_instr(inst,memory,reg,option);
			}
			GETTIME_TO(ts,t);
			printf("1億命令あたり%lfsec\n",t);
		}else{
			return 0;
		}

	}
			free(inst);

	return 0;
}
