#ifndef _INCLUDE
#define _INCLUDE

// 時間計測用
#define GETTIME_FROM(ts,t) 	{clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9;}
#define GETTIME_TO(ts,t) {clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9 - t;}
/*
struct timespac ts;
double t;
GETTIME_FROM(ts,t)
処理本体
GETTIME_TO(ts,t)
でtに処理時間が格納される.
*/


#define MEMORY_SIZE 1024			// == word size == byte size / 4
#define PROGRAM_SIZE 1024
#define BASE_ADDR 0



typedef unsigned int word;
typedef unsigned short halfword;
typedef char byte;

typedef struct instruction *Instr;
typedef struct instruction **Program;
typedef unsigned int *Mem; //word *
typedef struct label *LList;
typedef struct reg *Reg;

// typedef struct exec *Exec;

// struct exec{
// 	Program program;
// 	LList llist;
// 	Mem memory;
// 	Reg reg;
// };


struct instruction {
  char mnenonic[8]; //opcode as string
  int opcode;
  int funct3;
  int is_sra_sub;
  int rd;
  int rs1;
  int rs2;
  int imm;
  word byte_code;
  char label[64];
  int label_addr;
  int line;
  int break_en;
};

struct label{
	char name[64];
	int addr;
	LList next;
};

struct reg{
	int x[32];
	float f[32];
	unsigned int pc;
};


// 以下RISC-Vの定数
//opcode
#define OP_LUI 		0b0110111
#define OP_AUIPC 	0b0010111
#define OP_JAL		0b1101111
#define OP_JALR		0b1100111
#define OP_BRANCH	0b1100011
#define OP_LOAD		0b0000011
#define OP_STORE	0b0100011
#define OP_ALUI		0b0010011
#define OP_ALU		0b0110011
#define OP_MULDIV	0b0110011

//funct3_branch
#define B_EQ 		0b000
#define B_NE 		0b001
#define B_LT 		0b100
#define B_GE 		0b101
#define B_LTU 		0b110
#define B_GEU 		0b111


//funct3_load
#define LOAD_BYTE_S 0b000
#define LOAD_HALF_S	0b001
#define LOAD_WORD	0b010
#define LOAD_BYTE_Z	0b100
#define LOAD_HALF_Z	0b101


//funct3_store
#define STORE_BYTE  0b000
#define STORE_HALF	0b001
#define STORE_WORD	0b010

// funct3_alu
#define ALU_ADD 	0b000 // ALU_SUB
#define ALU_SLL 	0b001
#define ALU_SLT 	0b010
#define ALU_SLTU 	0b011
#define ALU_XOR 	0b100
#define ALU_SRX 	0b101 //ALU_SRA and ALU_SRL
#define ALU_OR 		0b110
#define ALU_AND 	0b111



// 以下関数プロトタイプ宣言。
Program load_assembly(const char* filename,int base_addr);
//Program load_binary(const char* filename,int base_addr);

int 	create_opcode(const char* mnenonic);
int 	create_funct3(const char* mnenonic);
int 	create_is_sra_sub(const char* mnenonic);


int 	search_label(const char* label,LList label_list);
Instr 	set_label(Instr instr,LList label_list);
LList 	add_label(const char *name,int pc,LList label_list);
void 	resolve_label(Program program,LList label_list,int base_addr);
void 	print_labels(LList label_list);

Instr 	initialize_instr(void);
void 	print_instr(Instr instr);
void 	print_mnemonic(int opcode,int funct3,int is_sra_sub);
void 	exec_instr(Instr i,Mem memory,Reg reg,int option);


int 	exec_program(Program program,Reg reg,Mem mem,int base_addr,int option);
void 	print_prgram(Program program);

Mem 	initialize_memory(int memsize);
void 	print_memory(word *memory,int start, int n);

Reg 	initialize_reg(int base_addr);
void 	print_reg(Reg reg);

// set break()


// 以下 ユーティリティ関数。
int get_b_form(int d);


#endif