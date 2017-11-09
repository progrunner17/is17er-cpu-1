#ifndef _INCLUDE
#define _INCLUDE
#include <stdio.h>

// 時間計測用
#define GETTIME_FROM(ts,t) 	{clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9;}
#define GETTIME_TO(ts,t) {clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9 - t;}
/*
//以下のように二つの変数を宣言
struct timespac ts;
double t;
GETTIME_FROM(ts,t)
処理本体
GETTIME_TO(ts,t)
でtに処理時間が格納される.
*/

typedef unsigned int word;
typedef unsigned short halfword;
typedef char byte;
typedef unsigned int *Mem; //word *



typedef struct _instruction *Instr;
typedef struct _instruction **Program;

typedef struct _label *LList;
typedef struct _reg *Reg;






struct _instruction {
  char mnenonic[8]; //opcode as string
  int opcode;
  int funct3;
  int funct5;
  int is_sra_sub;
//address of register
  int rd;
  int rs1;
  int rs2;
  int imm;
  word machine_code;
  char label[64];
  int label_addr;
  int line;
  int src_break;
};



struct _label{
	char name[64];
	int addr;
	LList next;
};



struct _reg{
	int x[32];
	float f[32];
	unsigned int pc;
};


struct _files{
  char *machine_filename;
  FILE *machine_fp;

  char *source_filename;
  FILE *source_fp;

  char *input_filename;
  FILE *input_fp;

  char *output_filename;
  FILE *output_fp;

  char *log_filename;
  FILE *log_fp;

};



typedef struct _files *files;
typedef enum{
  LUI,
  AUIPC,
  JAL,
  JALR,
  BEQ,
  BNE,
  BLT,
  BGE,
  BLTU,
  BGEU,
  SB,
  SH,
  SW,
  LB,
  LH,
  LW,
  LBU,
  LHU,
  ADDI,
  SLLI,
  SLTI,
  SLTUI,
  XORI,
  SRAI,
  SRLI,
  ORI,
  ANDI,
  ADD,
  SUB,
  SLL,
  SLTU,
  XOR,
  SRA,
  SRL,
  OR,
  AND,
  FADD,
  FSUB,
  FMUL,
  FDIV,
  FSQRT,
  FEQ,
  FLT,
  FLE,
  FSGNJ,
  FSGNJN,
  FSGNJX,
  FTOI,
  ITOF,
  FTOX,
  XTOF,
  FINISH
}OP;

typedef enum{
  D,
  X,
  B,
  F
  // ,I
}format;

enum type{
  LINE,
  LABEL,
  ADDR,
  MNEMO,
  REG_X,
  REG_F,
  PC,//PCそのもの
};


typedef struct cond* Cond;
struct _cond{
  enum  type b_type;
  int enable;
  int n;
  char *str;
  OP op;
};

typedef enum{
  RUN,
  NEXT,
  CONTINUE,
  SET,
  INFO,
  BREAK,
  DELETE,
  // DISPLAY,
  PRINT,
  // DISABLE,
  // ENABLE,
  // IGNORE,
  MEMORY,
  ERROR,
  QUIT

}COMMAND;


typedef struct _data *Data;
struct _data{
  LList llist;
  Cond   w_list[32];//watch
  Cond   b_list[32];
  Cond   d_list[32];
  int   instr_count;//命令数
  int   op_count[64];//命令別カウント
  int   b_count;//ignore用ブレイク回数カウント
  double time;
};


// // exec instr & and exec program
// #define EXEC_OPT_PRINT_PC    1<<0
// #define EXEC_OPT_PRINT_REG    1<<1
// #define EXEC_OPT_PRINT_MEM    1<<2
// #define EXEC_OPT_PRINT_INSTR  1<<3
// #define EXEC_OPT_BREAK_EN     1<<4


#define PRINT_REG_PC 1
#define PRINT_REG_X_D  1<<1
#define PRINT_REG_X_X  1<<2
#define PRINT_REG_F  1<<3






// 以下関数プロトタイプ宣言。
Program load_assembly(const char* filename,Data d);


//アセンブリからオペコードを作る。
int 	create_opcode(const char* mnenonic);
int 	create_funct3(const char* mnenonic);
int 	create_is_sra_sub(const char* mnenonic);


// ラベル
LList initialize_label(void);
LList   add_label(const char *name,int pc,LList label_list);
int 	search_label(const char* label,LList label_list);
void  print_labels(LList label_list);
// Instr 	set_label(Instr instr,LList label_list);
void 	resolve_label(Program program,LList label_list);

// 命令関係
Instr 	initialize_instr(void);
void 	print_instr(Instr instr);
void 	print_mnemonic(int opcode,int funct3,int is_sra_sub);
void 	exec_instr(Instr i,Mem memory,Reg reg,Data d);

// プログラム全体を管理。
int 	exec_program(Program program,Reg reg,Mem mem,Data d);
void 	print_prgram(Program program);

// プログラムの実行関係
Mem 	initialize_memory(int memsize,Mem p);
void 	print_memory(word *memory,int start, int n);
Reg 	initialize_reg(Reg p);
void 	print_reg(Reg reg,int opt);

word create_machine_code(Instr i);

void generate_binary(Program program,char *filename);
// 以下 ユーティリティ関数。
int get_b_form(int d);
void print_binary(int d);
void write_word(word d,FILE* fp);

files parse_commandline_arg(int argc, char **argv);
char* get_line(char *s, int size);


void fprint_bin(FILE *fp,int d,int max,int min);

Data initialize_data(Data d);

void print_help(void);
#endif