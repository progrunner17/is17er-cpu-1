#ifndef _OFUNC
#define _OFUNC
int ctob(char c);//停止時（ナル文字のとき）-1、文字0,1を整数0,1にする。その他は2(1より大きいと0,1でないと判断させる)。主にfile_load(FILE *fp)で用いている。
BinaryCode file_load(FILE *fp);//fpを一命令ごとに配列の一要素にする。－命令を３２要素のint型配列で表す。
BinaryCode initialize_binary_code(void);//BinaryCode初期化
int bintonm(instruction instr,int i0,int i1);//instr[i0]~instr[i1]を整数に直す。
int immtonm(instruction instr,int opcode);//オペコードによってimmを返す。（immがないときは0を返す）
Machine initialize_machine(void);//Machine初期化
int nextpc(int pc);//pc+4?pc+1?
char *get_line(char *s,int size);//sim_core/parsing.cよりコピペ。標準入力から最大size-1個の文字を改行またはEOFまで読み込み、sに設定する。
void parse_commandline_arg(int argc, char **argv);//sim_core/parsing.cのほぼコピペ。コマンドライン引数からファイル名を受け取る。
void print_asm(int opcode,int funct3,int funct7,int imm,int rs1,int rs2,int rd,int shamt);
#endif
