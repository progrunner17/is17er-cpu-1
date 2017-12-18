#ifndef _TYPE
#define _TYPE
#include <stdio.h>  //for FILE *
#include <stdint.h> // for uint32_t

typedef union _word word;
typedef word *Mem;
typedef struct _instruction *Instr;
typedef struct _instruction **Program;
typedef struct _label *LList;
typedef struct _reg *Reg;

union _word {
  float f;
  unsigned int x;
  int d;
};

struct _instruction {
  int opcode;
  int funct3;
  int funct5;
  int is_sra_sub;
  int rd;
  int rs1;
  int rs2;
  int imm;
  uint32_t machine_code;
  char *label;
  int label_addr;
  int line;
  int src_break;
  int exec_count;
};

struct _label {
  char name[64];
  int addr;
  int line;
  LList next;
};

struct _reg {
  int x[32];
  float f[32];
  unsigned int pc;
};

typedef struct _files *Files;

// runtime
struct _files {
  // char *machine_filename;
  // FILE *machine_fp;

  // char *source_filename;
  // FILE *source_fp;

  // char *input_filename;
  // FILE *input_fp;

  // char *output_filename;
  // FILE *output_fp;

  // char *log_filename;
  // FILE *log_fp;

};

typedef struct _runtime *Runtime;
struct _runtime {
  LList llist;
  int   instr_count;//命令数
  int   op_count[64];//命令別カウント
  int   b_count;//ignore用ブレイク回数カウント<<0
  double time;
  Files files;
  Reg reg;
  Program program;
  int max_instr;
  Mem memory;
};


// 以下関数プロトタイプ宣言。

// parsing.c
Program load_asm_file(const char* filename,LList llist);
int   create_opcode(const char* mnemonic);
int   create_funct3(const char* mnemonic);
int   create_funct5(const char* mnemonic);
int   create_is_sra_sub(const char* mnemonic);
Files parse_commandline_arg(int argc, char **argv);
char* get_line(char *s, int size);

// print.c
void  print_labels(LList label_list);
void  print_mnemonic(Instr i);
void  print_instr(Instr instr);
void  print_prgram(Program program);
void  print_memory(word *memory, int base_addr, unsigned int n,int option);
void  print_reg(Reg reg, int opt);
void  print_binary(int d);
void  fprint_bin(FILE *fp, int d, int max, int min);
// util.c
// label
LList    initialize_label(void);
LList    initialize_llist(void);
LList    add_label(const char *name, int pc, int line, LList llist);
int      search_label(const char* label, LList llist);
// Instr  set_label(Instr instr,LList llist);
void     resolve_label(Program program, LList llist);
void  print_label_of_pc(int pc,LList llist);

// instr
Instr    initialize_instr(void);
void     exec_instr(Instr i, Mem memory, Reg reg);
int      exec_program(Program program, Reg reg, Mem mem);

// runtime
Mem      initialize_memory(int memsize, Mem p);
Reg      initialize_reg(Reg p);

// assemble.c
uint32_t  create_machine_code(Instr i);
void      generate_binary(Program program, char *filename);

// 以下 ユーティリティ関数。
int         get_b_form(int d);
void        write_word(uint32_t d, FILE* fp);
Runtime     initialize_runtime(Runtime d);

Instr load_asm_line(char * buff);
uint32_t create_machine_code(Instr i);
void print_machine_code(FILE *fp,uint32_t code,int option);
#endif