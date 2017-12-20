#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include "include.h"
#define PROMPT ">> "

FILE *log_fp = NULL;
FILE *out_fp = NULL;
FILE *in_fp = NULL;
char *machine_filename = NULL;
char *source_filename = NULL;
char *input_filename = NULL;
char *output_filename = NULL;
char *log_filename = NULL;

/* 標準入力から最大size-1個の文字を改行またはEOFまで読み込み、sに設定する */
char* get_line(char *s, int size) {
  printf(PROMPT);
  while (fgets(s, size, stdin) == NULL) {
    if (errno == EINTR)
      continue;
    return NULL;
  }
  return s;
}


// コマンドライン引数からファイル名を受け取る
Files parse_commandline_arg(int argc, char **argv) {
  Files args;
  log_fp = stderr;
  out_fp = stdout;
  in_fp = stdin;


  args = (Files )malloc(sizeof(struct _files));
  bzero(args, sizeof(struct _files));
  int opt;
  opterr = 0;
  while ((opt = getopt(argc, argv, "m:s:i:o:l:a")) != -1) {
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
    fgets(buff, BUF_SIZE, stdin);
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
  return NULL;
}


// アセンブリからオペコード生成
//ニーモニックの文字 列を渡してオペコード(include.hで定義))を返す関数
int create_opcode(const char* mnemonic) {
  int opcode = 0;
  opcode =  (strcmp(mnemonic, "lui")  == 0) ? OP_LUI :
            (strcmp(mnemonic, "auipc") == 0) ? OP_AUIPC :
            (strcmp(mnemonic, "jal") == 0) ? OP_JAL :
            (strcmp(mnemonic, "jalr") == 0) ? OP_JALR :
            (strcmp(mnemonic, "beq") == 0) ||
            (strcmp(mnemonic, "bne") == 0) ||
            (strcmp(mnemonic, "blt") == 0) ||
            (strcmp(mnemonic, "bge") == 0) ||
            (strcmp(mnemonic, "bltu") == 0) ||
            (strcmp(mnemonic, "bgeu") == 0) ? OP_BRANCH :
            (strcmp(mnemonic, "lb") == 0) ||
            (strcmp(mnemonic, "lh") == 0) ||
            (strcmp(mnemonic, "lw") == 0) ||
            (strcmp(mnemonic, "lbu") == 0) ||
            (strcmp(mnemonic, "lhu") == 0) ? OP_LOAD :
            (strcmp(mnemonic, "sb") == 0) ||
            (strcmp(mnemonic, "sh") == 0) ||
            (strcmp(mnemonic, "sw") == 0) ? OP_STORE :
            (strcmp(mnemonic, "addi") == 0) ||
            (strcmp(mnemonic, "slti") == 0) ||
            (strcmp(mnemonic, "sltiu") == 0) ||
            (strcmp(mnemonic, "xori") == 0) ||
            (strcmp(mnemonic, "ori") == 0) ||
            (strcmp(mnemonic, "andi") == 0) ||
            (strcmp(mnemonic, "slli") == 0) ||
            (strcmp(mnemonic, "srli") == 0) ||
            (strcmp(mnemonic, "srai") == 0) ? OP_ALUI :
            (strcmp(mnemonic, "add") == 0) ||
            (strcmp(mnemonic, "sub") == 0) ||
            (strcmp(mnemonic, "sll") == 0) ||
            (strcmp(mnemonic, "slt") == 0) ||
            (strcmp(mnemonic, "sltu") == 0) ||
            (strcmp(mnemonic, "xor") == 0) ||
            (strcmp(mnemonic, "srl") == 0) ||
            (strcmp(mnemonic, "sra") == 0) ||
            (strcmp(mnemonic, "or") == 0) ||
            (strcmp(mnemonic, "and") == 0) ? OP_ALU :
            (strcmp(mnemonic, "fadd") == 0) ||
            (strcmp(mnemonic, "fsub") == 0) ||
            (strcmp(mnemonic, "fmul") == 0) ||
            (strcmp(mnemonic, "fdiv") == 0) ||
            (strcmp(mnemonic, "fsqrt") == 0) ||
            (strcmp(mnemonic, "feq") == 0)  ||
            (strcmp(mnemonic, "flt") == 0)  ||
            (strcmp(mnemonic, "fle") == 0)  ||
            (strcmp(mnemonic, "fmv") == 0)  ||  //fsgnj
            (strcmp(mnemonic, "fneg") == 0) ||  //fsgnjn
            (strcmp(mnemonic, "fabs") == 0) ||  //fsgnjx
            (strcmp(mnemonic, "ftoi") == 0) ||
            (strcmp(mnemonic, "itof") == 0) ||
            (strcmp(mnemonic, "ftox") == 0) ||
            (strcmp(mnemonic, "xtof") == 0) ? OP_FP :
            (strcmp(mnemonic, "fsw") == 0) ? OP_STORE_FP :
            (strcmp(mnemonic, "flw") == 0) ? OP_LOAD_FP :
            (strcmp(mnemonic, "ob") == 0) ? OP_STORE_IO :
            (strcmp(mnemonic, "ib") == 0) ? OP_LOAD_IO :
            (strcmp(mnemonic, "hlt") == 0) ? OP_HLT:
            -1;
  return opcode;
}

// オペコードとニーモニックを渡して,funct3を返す関数。
int create_funct3(const char * mnemonic) {
  int funct3 = 0;
  funct3 =  (strcmp(mnemonic, "jalr") == 0) ? 0b000 :
            (strcmp(mnemonic, "beq") == 0) ? B_EQ :
            (strcmp(mnemonic, "bne") == 0) ? B_NE :
            (strcmp(mnemonic, "blt") == 0) ? B_LT :
            (strcmp(mnemonic, "bge") == 0) ? B_GE :
            (strcmp(mnemonic, "bltu") == 0) ? B_LTU :
            (strcmp(mnemonic, "bgeu") == 0) ? B_GEU :
            (strcmp(mnemonic, "lb") == 0) ? LOAD_BYTE_S :
            (strcmp(mnemonic, "lh") == 0) ? LOAD_HALF_S :
            (strcmp(mnemonic, "lw") == 0) ? LOAD_WORD :
            (strcmp(mnemonic, "lbu") == 0) ? LOAD_BYTE_Z :
            (strcmp(mnemonic, "lhu") == 0) ? LOAD_HALF_Z :
            (strcmp(mnemonic, "sb") == 0) ? STORE_BYTE :
            (strcmp(mnemonic, "sh") == 0) ? STORE_HALF :
            (strcmp(mnemonic, "sw") == 0) ? STORE_WORD :
            (strcmp(mnemonic, "addi") == 0) ? ALU_ADD :
            (strcmp(mnemonic, "slti") == 0) ? ALU_SLT :
            (strcmp(mnemonic, "sltiu") == 0) ? ALU_SLTU :
            (strcmp(mnemonic, "xori") == 0) ? ALU_XOR :
            (strcmp(mnemonic, "ori") == 0) ? ALU_OR :
            (strcmp(mnemonic, "andi") == 0) ? ALU_AND :
            (strcmp(mnemonic, "slli") == 0) ? ALU_SLL :
            (strcmp(mnemonic, "srli") == 0) ? ALU_SRX :
            (strcmp(mnemonic, "srai") == 0) ? ALU_SRX :
            (strcmp(mnemonic, "add") == 0) ? ALU_ADD :
            (strcmp(mnemonic, "sub") == 0) ? ALU_ADD :
            (strcmp(mnemonic, "sll") == 0) ? ALU_SLL :
            (strcmp(mnemonic, "slt") == 0) ? ALU_SLT :
            (strcmp(mnemonic, "sltu") == 0) ? ALU_SLTU :
            (strcmp(mnemonic, "xor") == 0) ? ALU_XOR :
            (strcmp(mnemonic, "srl") == 0) ? ALU_SRX :
            (strcmp(mnemonic, "sra") == 0) ? ALU_SRX :
            (strcmp(mnemonic, "or") == 0) ? ALU_OR :
            (strcmp(mnemonic, "and") == 0) ? ALU_AND :
            // (strcmp(mnemonic,"fadd") == 0) ? F5_FADD:
            // (strcmp(mnemonic,"fsub") == 0) ? F5_FSUB:
            // (strcmp(mnemonic,"fmul") == 0) ? F5_FMUL:
            // (strcmp(mnemonic,"fdiv") == 0) ? F5_FDIV:
            // (strcmp(mnemonic,"fsqrt") == 0) ? F5_FSQRT:
            (strcmp(mnemonic, "feq") == 0)  ? F3_FEQ :
            (strcmp(mnemonic, "flt") == 0) ? F3_FLT :
            (strcmp(mnemonic, "fle") == 0) ? F3_FLE :
            (strcmp(mnemonic, "fmv") == 0) ? F3_FSGNJ :
            (strcmp(mnemonic, "fneg") == 0) ? F3_FSGNJN :
            (strcmp(mnemonic, "fabs") == 0) ? F3_FSGNJX :
            // (strcmp(mnemonic,"ftoi") == 0) ? F5_FTOI:
            // (strcmp(mnemonic,"itof") == 0) ? F5_ITOF:
            // (strcmp(mnemonic,"ftox") == 0) ? F5_FTOX:
            // (strcmp(mnemonic,"xtof") == 0) ? F5_XTOF:
            (strcmp(mnemonic, "fsw") == 0) ? STORE_WORD :
            (strcmp(mnemonic, "flw") == 0) ? LOAD_WORD :
            (strcmp(mnemonic, "ob") == 0) ? STORE_BYTE :
            (strcmp(mnemonic, "ib") == 0) ? LOAD_BYTE_Z :
            -1;
  return funct3;
}



int create_funct5(const char *mnemonic) {
  int funct5 = 0;

  funct5 = (strcmp(mnemonic, "add") == 0) ||
           (strcmp(mnemonic, "srl") == 0) ||
           (strcmp(mnemonic, "srli") == 0) ? 0 :
           (strcmp(mnemonic, "sub") == 0) ||
           (strcmp(mnemonic, "srai") == 0) ||
           (strcmp(mnemonic, "sra") == 0) ||
           (strcmp(mnemonic, "fadd") == 0) ? F5_FADD :
           (strcmp(mnemonic, "fsub") == 0) ? F5_FSUB :
           (strcmp(mnemonic, "fmul") == 0) ? F5_FMUL :
           (strcmp(mnemonic, "fdiv") == 0) ? F5_FDIV :
           (strcmp(mnemonic, "fsqrt") == 0) ? F5_FSQRT :
           (strcmp(mnemonic, "feq") == 0) ||
           (strcmp(mnemonic, "flt") == 0) ||
           (strcmp(mnemonic, "fle") == 0) ? F5_FCMP :
           (strcmp(mnemonic, "fmv") == 0) ||
           (strcmp(mnemonic, "fneg") == 0) ||
           (strcmp(mnemonic, "fabs") == 0) ? F5_FSGNJ :
           (strcmp(mnemonic, "ftoi") == 0) ? F5_FTOI :
           (strcmp(mnemonic, "itof") == 0) ? F5_ITOF :
           (strcmp(mnemonic, "ftox") == 0) ? F5_FTOX :
           (strcmp(mnemonic, "xtof") == 0) ? F5_XTOF :
           // (strcmp(mnemonic,"fsw") == 0) ? STORE_WORD:
           // (strcmp(mnemonic,"flw") == 0) ? LOAD_WORD:
           -1;
  return funct5;
}



int create_is_sra_sub(const char *mnemonic) {
  int is_sra_sub;
  is_sra_sub =  (strcmp(mnemonic, "sub") == 0) ||
                (strcmp(mnemonic, "sra") == 0) ||
                (strcmp(mnemonic, "srai") == 0) ? 1 : 0;
  return is_sra_sub;
}



Instr load_asm_line(char * buff) {
  Instr instr = NULL;
  char *mnemonic, *op1, *op2, *op3;
  char label[64] = "";
  int opcode = 0;
  char tmp[BUF_SIZE];
  int error = 0;

  strcpy(tmp, buff); //元のデータを壊さないように、ラベルもあるし...
  if ((mnemonic =  strtok(tmp, " \t\n")) == NULL ) return NULL; //空行ならNULL
  op1 = strtok(NULL, ",");
  op2 = strtok(NULL, ",");
  op3 = strtok(NULL, " \t\n");

  // printf("mnemonic:\t%s\n",mnemonic);
  // printf("op1:\t%s\n",op1);
  // printf("op2:\t%s\n",op2);
  // printf("op3:\t%s\n",op3);

  instr = initialize_instr();


  if ((opcode = create_opcode(mnemonic)) != -1 ) { //オペコードを取得できたらtrue
    // 命令用の領域を確保
    instr = initialize_instr();
    instr->funct3 = create_funct3(mnemonic);
    instr->funct5 = create_funct5(mnemonic);
    instr->opcode = opcode;
    instr->is_sra_sub = create_is_sra_sub(mnemonic);

    // read 1st operand
    switch (opcode) {
      case OP_LUI: case OP_AUIPC: case OP_JAL: case OP_JALR: case OP_LOAD: case OP_ALUI: case OP_ALU: case OP_LOAD_FP: case OP_FP: case OP_LOAD_IO:
        if ( !sscanf(op1, " x%d", &instr->rd) && !sscanf(op1, " f%d", &instr->rd) ) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 1st oprand:\t cannot read rd\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;
        }
        break;
      case OP_STORE: case OP_STORE_FP:case OP_STORE_IO:
        if ( !sscanf(op1, " x%d", &instr->rs2) && !sscanf(op1, " f%d", &instr->rs2) ) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 1st oprand:\t cannot read rs2\n");
           fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
         error = 1;
        }
        break;

      case OP_BRANCH:
        if ( !sscanf(op1, " x%d", &instr->rs1) ) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 1st oprand:\t cannot read rs1\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;

        }
        break;
      case OP_HLT:break;
      default:
        fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 1st oprand:\t invalid opcode\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
        error = 1;
    }

    // read 2nd operand
    switch (opcode) {
      case OP_LUI:
      case OP_AUIPC:
        if (!sscanf(op2, " 0x%x", &instr->imm) && !sscanf(op2, " %d", &instr->imm)) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 2nd oprand:\t cannot read imm\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;
        }
        break;
      case OP_JAL:
        if (!sscanf(op2, " 0x%x", &instr->imm) && !sscanf(op2, " %d", &instr->imm)) {
          if (sscanf(op2, " %s", label)) {
            instr->label = calloc(strlen(label) + 1, sizeof(char));
            strcpy(instr->label, label);
          } else {
            fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 2nd oprand:\t cannot read imm & label\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
            error = 1;
          }
        }
        break;
      case OP_JALR:
      case OP_ALUI:
      case OP_ALU:
      case OP_FP:
        if ( !sscanf(op2, " x%d", &instr->rs1) && !sscanf(op2, " f%d", &instr->rs1) ) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 2nd oprand:\t cannot read rs1\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;
        }
        break;
      case OP_BRANCH:
        if ( !sscanf(op2, " x%d", &instr->rs2) ) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 2nd oprand:\t cannot read rs2\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;
        }
        break;
      case OP_LOAD:
      case OP_STORE:
      case OP_LOAD_FP:
      case OP_STORE_FP:
        if ( sscanf(op2, " 0x%x(x%d)", &instr->imm, &instr->rs1) != 2 && sscanf(op2, " %d(x%d)", &instr->imm, &instr->rs1) != 2 ) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 2nd oprand:\t cannot read imm(base)\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;
        }
        break;
        fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 2nd oprand:\t invalid opcode\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);

      case OP_HLT:break;

    }


    // read 3rd operand
    switch (opcode) {
      // no 3rd operand
      case OP_LUI: case OP_AUIPC: case OP_JAL:  case OP_LOAD: case OP_STORE: case OP_LOAD_FP: case OP_STORE_FP: case OP_LOAD_IO:case OP_STORE_IO:
        break;
      // label
      case OP_BRANCH:
        if (!sscanf(op3, " 0x%x", &instr->imm) && !sscanf(op3, " %d", &instr->imm)) {
          if (sscanf(op3, " %s", label)) {
            instr->label = calloc(strlen(label) + 1, sizeof(char));
            strcpy(instr->label, label);
          } else {
            fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 3rd oprand:\t cannot read imm & label\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
            error = 1;

          }
        }
        break;
      case OP_ALUI: case OP_JALR:
        if (!sscanf(op3, " 0x%x", &instr->imm) && !sscanf(op3, " %d", &instr->imm)) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 3rd oprand:\t cannot read imm\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;
        }
        break;
      case OP_ALU:
        if (!sscanf(op3, " x%d", &instr->rs2 )) {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 3rd oprand:\t cannot read rs2\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;

        }

        break;

      case OP_FP:
        switch (instr->funct5) {
          case F5_FADD:
          case F5_FSUB:
          case F5_FMUL:
          case F5_FDIV:
          case F5_FCMP:
            if ( !sscanf(op3, " f%d", &instr->rs2) ) {
              fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 3rd oprand of OP_FP:\t invalid funct5\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
              error = 1;

            }
            break;
          // no 3rd operand
          case F5_FSQRT:case F5_FTOI: case F5_FTOX: case F5_ITOF: case F5_XTOF:instr->rs2 = 0b00000;break;
          // no 3rd operand but sama as rs1
          case F5_FSGNJ:
            // printf("buff = %s\n",buff);
            instr->rs2 = instr->rs1;
            break;

          default: {
              fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 3rd oprand of OP_FP:\t invalid funct5\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
              error = 1;
            }
        }
        break;
      case OP_HLT:break;
      default: {
          fprintf(log_fp, "[ERROR]@load_asm_line:\tparse 3rd oprand:\t invalid opcode\n");
          fprintf(log_fp, "                      \t                :\t buff = \"%s\"\n",buff);
          error = 1;
        }
    }

    if (error)fprintf(log_fp, "[ERROR]@load_asm_line:\t%s\n", buff);
  } else {
    // ラベルかもしれないのでエラー表示しない
    // fprintf(log_fp,"[ERROR]@load_asm_line:\tline may be label\n");
    error = 1;
  } // if opcode

  if (error) {
    // print_instr(instr);
    // printf("free!!!\n");
    free(instr);
    instr = NULL;
  }
  return instr;

}




//アセンブリのファイルを読みこみ命令(へのポインタ)の配列を返す関数
Program load_asm_file(const char* filename,LList llist) {
  FILE *fp;
  Instr instr;
  Program program;
  char buff[BUF_SIZE];
  int pc = 0;
  int src_break = 0;
  char *p;


  program = calloc(PROGRAM_SIZE, sizeof(Instr));
  llist = initialize_llist();

  if ((fp = fopen(filename, "r")) == NULL) {
    fprintf(log_fp, "[ERROR]@load_asm_file:\tcannot open file %s\n", filename);
    return NULL ;
  }

  for (int line = 1; fgets(buff, BUF_SIZE, fp) ; line++) {


    if ((p = strchr(buff, '#'))){
      // printf("strlen:%d\n",strlen(buff));
      if(strlen(buff) == BUF_SIZE-1){
            // printf("orver!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
            int c = 0;
            while(1){
                c = fgetc(fp);
                if(c == '\n' || c== EOF ){
                   ungetc(c,fp);
                   break;
                }
            }
        }
      *p = '\0';
    }   //remove comment
    p = buff + strspn(buff, " \t\n");
    if ( p != NULL && strlen(p) == 0 )continue;               //empty line
    if(strncmp("(*break*)", buff,9) == 0 ){
      src_break = 1;
      continue;
    }
    if ((instr = load_asm_line(p))) {
      instr->src_break = src_break;
      instr->line = line;//行番号保存
      program[pc] = instr;
      pc++;
      src_break = 0;
    } else { //オペコードが取得できなかったら
      char label[128];
      char * p2 = NULL;
      p2 = strtok(p," \t:");
      sscanf(p, "%s", label);
      add_label(label, pc, line, llist);

      // fprintf(log_fp, "[ERROR]@load_asm_file:\tinvalid assembly %s\n", p);
    }
    // print_instr(instr);
  } //for
  printf("label list\n");
  print_labels(llist);

  resolve_label(program, llist);
  printf("命令数:\t%d\n", pc);
  fclose(fp);
  // print_prgram(program);
  fflush(stdout);
  // runtime->llist = llist;
  // runtime->max_instr = pc;
  // printf("max_instr = %d\n",runtime->max_instr);
  return program;
}


