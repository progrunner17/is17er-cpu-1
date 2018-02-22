#ifndef _READF2
#define _READF2
void program_exec(FILE *fp,Machine mac,int breakpoint_nm,int breakpoint_op,int begin_fprintf,int end_fprintf);//機械語のファイルを受け取って実行する。主に、ファイルを開く等の雑多なことやデバッグ向けの操作を実装している。
//デバッグのために必要な引数（breakpointなど）は設定しないとき、-1とする。

//各命令の実行は下記の関数に任せる。その他の関数はother_function.hに仕様が書いてある。
int instruction_exec(instruction instr,Machine mac);//上記の関数における各命令の実行。上記関数のwhile文の条件でOP_HLTを用いるのでintを返す。

#endif
