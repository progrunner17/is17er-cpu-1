#ifndef OPTION_
#define OPTION_
// exec instr & and exec program
#define EXEC_OPT_PRINT_PC    1<<0
#define EXEC_OPT_PRINT_REG    1<<1
#define EXEC_OPT_PRINT_MEM    1<<2
#define EXEC_OPT_PRINT_INSTR  1<<3
#define EXEC_OPT_BREAK_EN     1<<4
#define EXEC_OPT_DISPLAY      1<<5

#define PRINT_REG_PC  1<<0
#define PRINT_REG_PC_X  1<<0
#define PRINT_REG_PC_D  1<<7
#define PRINT_REG_X_D   1<<1
#define PRINT_REG_X_X   1<<2
#define PRINT_REG_X_B   1<<3
#define PRINT_REG_F     1<<4
#define PRINT_REG_F_X   1<<5
#define PRINT_REG_F_B   1<<6


#define PRINT_CODE_TXT 1<<1
#define PRINT_CODE_BIN 1<<2


#define CODE_OP  		1<<1
#define CODE_RS1 		1<<2
#define CODE_RS2 		1<<3
#define CODE_RD  		1<<4
#define CODE_F3  		1<<5
#define CODE_F5  		1<<6
#define CODE_IMM_U 		1<<7
#define CODE_IMM_J 		1<<8
#define CODE_IMM_I		1<<9
#define CODE_IMM_B		1<<10
#define CODE_IMM_S		1<<11


#define OPT_BIG_ENDIAN  1<<0
#define OPT_


#endif
