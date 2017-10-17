#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Prog {
  char nmc[50];
  char adr[50];
  int opc;
  int rd;
  int rs1;
  int rs2;
  int imm;
  int shamt;
  int succ;
  int pred;
  int funct3;
  int funct7;
  int zimm;
  int csr;
  char label[50];
};

int search_label(char *str,int *label,struct Prog* prog){
  int i=0;

  while(strcmp(str,prog[label[i]].label) != 0){
    i++; 
  }
  return i;
}
int search_label_i(int i,int *label){
  int j=0;

  while(i != label[j]){
    j++; 
  }
  return j;
}

void exec(struct Prog *prog,int *mem,int *reg,int *label,int pc_max){

  int pc = 0;
  int adr;
  int i;    

  unsigned short u1;
  unsigned short u2;
  int i1;
  int i2;
  int x, y, z;
  while(pc<pc_max){
    if(prog[pc].label != NULL){
      printf("%s\n",prog[pc].label);
	}
    printf("[%d] %s\n", pc,prog[pc].nmc);

    if(strcmp(prog[pc].nmc,"lui")==0){
      reg[prog[pc].rd]=mem[search_label(prog[pc].adr,label,prog)];
      pc=pc+4;
    }
    else if(strcmp(prog[pc].nmc,"auipc")==0){
      reg[prog[pc].rd]=mem[pc+prog[pc].imm];
      pc=pc+4;
    }
    else if(strcmp(prog[pc].nmc,"jal")==0){
      reg[prog[pc].rd] = pc+4;
      pc=search_label(prog[pc].adr,label,prog);
    }else if(strcmp(prog[pc].nmc,"jalr")==0){
      reg[prog[pc].rd] = pc+4;
      pc = reg[prog[pc].rs1];
    }else if(strcmp(prog[pc].nmc,"beq")==0){
      if(reg[prog[pc].rs1]==reg[prog[pc].rs2])
	pc=search_label(prog[pc].adr,label,prog);
    }else if(strcmp(prog[pc].nmc,"bne")==0){
      if(reg[prog[pc].rs1]!=reg[prog[pc].rs2])
	pc=search_label(prog[pc].adr,label,prog);
    }else if(strcmp(prog[pc].nmc,"blt")==0){
      if(reg[prog[pc].rs1]<reg[prog[pc].rs2])
	pc=search_label(prog[pc].adr,label,prog);
    }else if(strcmp(prog[pc].nmc,"bge")==0){
      if(reg[prog[pc].rs1]>=reg[prog[pc].rs2])
	pc=search_label(prog[pc].adr,label,prog);
    }else if(strcmp(prog[pc].nmc,"bltu")==0){
      u1=reg[prog[pc].rs1];
      u2=reg[prog[pc].rs2];
      if(u1<u2)
	pc=search_label(prog[pc].adr,label,prog);
    }else if(strcmp(prog[pc].nmc,"bgeu")==0){
      u1=reg[prog[pc].rs1];
      u2=reg[prog[pc].rs2];
      if(u1>=u2)
	pc=search_label(prog[pc].adr,label,prog);
    }else if(strcmp(prog[pc].nmc,"lb")==0){
      reg[prog[pc].rd]=mem[reg[prog[pc].rs1]+prog[pc].imm];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"lh")==0){
      reg[prog[pc].rd]=mem[reg[prog[pc].rs1]+prog[pc].imm];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"lw")==0){
      reg[prog[pc].rd]=mem[reg[prog[pc].rs1]+prog[pc].imm];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"lbu")==0){
      reg[prog[pc].rd]=mem[reg[prog[pc].rs1]+prog[pc].imm];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"lhu")==0){
      reg[prog[pc].rd]=mem[reg[prog[pc].rs1]+prog[pc].imm];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"sb")==0){
      mem[reg[prog[pc].rs1]+prog[pc].imm]=reg[prog[pc].rs2];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"sh")==0){
      mem[reg[prog[pc].rs1]+prog[pc].imm]=reg[prog[pc].rs2];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"sw")==0){
      mem[reg[prog[pc].rs1]+prog[pc].imm]=reg[prog[pc].rs2];
      pc=pc+4;
    }else if(strcmp(prog[pc].nmc,"addi")==0){
      prog[pc].rd=prog[pc].rs1+prog[pc].imm;
      pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"slti")==0){
      i1=reg[prog[pc].rs1];
      i2=prog[pc].imm;
      reg[prog[pc].rd]=(i1<i2);
　　　pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"sltiu")==0){
      u1=reg[prog[pc].rs1];
      u2=prog[pc].imm;
      reg[prog[pc].rd]=(u1<u2);
　　　pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"xori")==0){
      x = reg[prog[pc].rs1];
      y = prog[pc].imm;
      reg[prog[pc].rd] = (x && (!y)) || ((!x) && y);
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"ori")==0){
      x = reg[prog[pc].rs1];
      y = prog[pc].imm;
      reg[prog[pc].rd] = x || y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"andi")==0){
      x = reg[prog[pc].rs1];
      y = prog[pc].imm;
      reg[prog[pc].rd] = x && y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"slli")==0){
      x = reg[prog[pc].rs1];
      y = prog[pc].imm;
      reg[prog[pc].rd] = x && y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"srli")==0){
      u1 = reg[prog[pc].rs1];
      u2 = prog[pc].imm;
      reg[prog[pc].rd] = u1 >> u2;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"srai")==0){
      i1 = reg[prog[pc].rs1];
      i2 = prog[pc].imm;
      reg[prog[pc].rd] = i1 >> i2;
    }else if(strcmp(prog[pc].nmc,"add")==0){
      x = reg[prog[pc].rs1];
      y = reg[prog[pc].rs2];
      reg[prog[pc].rd] = x+y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"sub")==0){
      x = reg[prog[pc].rs1];
      y = reg[prog[pc].rs2];
      reg[prog[pc].rd] = x - y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"sll")==0){
      x = reg[prog[pc].rs1];
      y = reg[prog[pc].rs2];
      reg[prog[pc].rd] = x << y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"slt")==0){
      i1 = reg[prog[pc].rs1];
      i2 = reg[prog[pc].rs2];
      reg[prog[pc].rd] = i1 < i2;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"sltu")==0){
      u1 = reg[prog[pc].rs1];
      u2 = reg[prog[pc].rs2];
      reg[prog[pc].rd] = u1 < u2;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"xor")==0){
      x = reg[prog[pc].rs1];
      y = reg[prog[pc].rs2];
      reg[prog[pc].rd] = (x && (!y)) || ((!x) && y);
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"srl")==0){
      u1 = reg[prog[pc].rs1];
      u2 = reg[prog[pc].rs2];
      reg[prog[pc].rd] = u1 >> u2;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"sra")==0){
      i1 = reg[prog[pc].rs1];
      i2 = reg[prog[pc].rs2];
      reg[prog[pc].rd] = i1 >> i2;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"or")==0){
      x = reg[prog[pc].rs1];
      y = reg[prog[pc].rs2];
      reg[prog[pc].rd] = x || y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"and")==0){
      x = reg[prog[pc].rs1];
      y = reg[prog[pc].rs2];
      reg[prog[pc].rd] = x && y;
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"fence")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"fence.i")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"ecall")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"ebreak")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"csrrw")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"csrrs")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"csrrc")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"csrrwi")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"csrrsi")==0){
	     pc = pc+4;
    }else if(strcmp(prog[pc].nmc,"csrrci")==0){
     pc = pc+4;
    }

    for(i=0;i<32;i++)
    printf("x%d : %d,",i,reg[i]);
    printf("\n");

    if(prog[pc].rd==0||prog[pc].rs1==0||prog[pc].rs2==0){
      printf("error:x0\n");
      break;
    }


  }
}
int main(int argc, char** argv){
  FILE *input;
  FILE *output;
  int label_i=0;
  char opc[20];
  int label[100];
	 
  int pc=0;
  int lr=0;
  struct Prog *prog;
  prog = malloc(sizeof(struct Prog));
  int *mem;
  mem=malloc(sizeof(int));
  char rd;
  char rs1;
  char rs2;
  int n1;
  int n2;
  int n3;
  char comma;
  char comma1;
  char comma2;
  char comma3;
  char rbra;
  char lbra;
  int imm;
  int shamt;
  char *lab;
  lab=malloc(sizeof(char));
  int not_nmc_flag = 0;  

  int i=0;
  int reg [32];
  reg[0]=0;

  int ff;
  printf("シミュレーションの読み込みデバッグff(ff=0:no,ff>0:yes)\nff=");
  scanf("%d",&ff);
  puts("");

  int lab_i = 0;  
  input = fopen("assembly.s","r");
  output = fopen("result.s","w");

  if (input == NULL) {
    printf("ファイルオープンエラー\n");
    return -1;
  }
  while((fscanf(input,"%s",opc)) != EOF){

    if(ff>0)printf("pc=%d,%s\n",pc,opc);

    strcpy(prog[pc].nmc, opc);
    //ISA↓
    if(strcmp(opc,"lui")==0){
      scanf("%c%d%c , %s",&rd,&n1,&comma,lab);
      prog[pc].rd = n1;
      strcpy(prog[pc].adr, lab);
    }else if(strcmp(opc,"auipc")==0){
      scanf("%c%d%c , %d",&rd,&n1,&comma1,&imm);
      prog[pc].rd = n1;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"jal")==0){
      scanf("%c%d%c , %s",&rd,&n1,&comma1,lab);
      prog[pc].rd = n1;
      strcpy(prog[pc].adr, lab);
    }else if(strcmp(opc,"jalr")==0){
      scanf("%c%d%c , %c%d%c , %s",&rd,&n1,&comma1,&rs1,&n2,&comma2,lab);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      strcpy(prog[pc].adr, lab);
    }else if(strcmp(opc,"beq")==0){
      scanf("%c%d%c , %c%d%c , %s",&rs1,&n2,&comma2,&rs2,&n3,&comma3,lab);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      strcpy(prog[pc].adr, lab);
    }else if(strcmp(opc,"bne")==0){
      scanf("%c%d%c , %c%d%c , %s",&rs1,&n2,&comma2,&rs2,&n3,&comma3,lab);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      strcpy(prog[pc].adr, lab);

    }else if(strcmp(opc,"blt")==0){
      scanf("%c%d%c , %c%d%c , %s",&rs1,&n2,&comma2,&rs2,&n3,&comma3,lab);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      strcpy(prog[pc].adr, lab);

    }else if(strcmp(opc,"bge")==0){
      scanf("%c%d%c , %c%d%c , %s",&rs1,&n2,&comma2,&rs2,&n3,&comma3,lab);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      strcpy(prog[pc].adr, lab);

    }else if(strcmp(opc,"bltu")==0){
      scanf("%c%d%c , %c%d%c , %s",&rs1,&n2,&comma2,&rs2,&n3,&comma3,lab);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      strcpy(prog[pc].adr, lab);

    }else if(strcmp(opc,"bgeu")==0){
      scanf("%c%d%c , %c%d%c , %s",&rs1,&n2,&comma2,&rs2,&n3,&comma3,lab);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      strcpy(prog[pc].adr, lab);
    }else if(strcmp(opc,"lb")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rd,&n1,&comma1,&imm,&lbra,&rs1,&n2,&rbra);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc] .imm = imm;
    }else if(strcmp(opc,"lh")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rd,&n1,&comma1,&imm,&lbra,&rs1,&n2,&rbra);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"lw")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rd,&n1,&comma1,&imm,&lbra,&rs1,&n2,&rbra);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"lbu")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rd,&n1,&comma1,&imm,&lbra,&rs1,&n2,&rbra);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"lhu")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rd,&n1,&comma1,&imm,&lbra,&rs1,&n2,&rbra);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"sb")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rs1,&n2,&comma2,&imm,&lbra,&rs2,&n3,&rbra);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"sh")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rs1,&n2,&comma2,&imm,&lbra,&rs2,&n3,&rbra);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"sw")==0){
      scanf("%c%d%c , %d%c%c%d%c",&rs1,&n2,&comma2,&imm,&lbra,&rs2,&n3,&rbra);
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      prog[pc].imm = imm;

    }else if(strcmp(opc,"addi")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"slti")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"sltiu")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"xori")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"ori")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"andi")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].imm = imm;
    }else if(strcmp(opc,"slli")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&shamt);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].shamt = shamt;
    }else if(strcmp(opc,"srli")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&shamt);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].shamt = shamt;
    }else if(strcmp(opc,"srai")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&shamt);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].shamt = shamt;
    }else if(strcmp(opc,"add")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"sub")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"sll")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"slt")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"sltu")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"xor")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"srl")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"sra")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"or")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"and")==0){
      scanf("%c%d%c , %c%d%c , %c%d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&rs2,&n3);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
    }else if(strcmp(opc,"csrrw")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].rs2 = n3;
      prog[pc].csr = imm;

    }else if(strcmp(opc,"fence")==0){
      scanf("%c%d%c , %d%c , %d",&rd,&n1,&comma1,&n2,&comma2,&n3);
      prog[pc].rd = n1;
      prog[pc].succ = n2;
      prog[pc].pred = n3;
    }else if(strcmp(opc,"fence.i")==0){

    }else if(strcmp(opc,"ecall")==0){

    }else if(strcmp(opc,"ebreak")==0){

    }else if(strcmp(opc,"csrrw")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].csr = imm;

    }else if(strcmp(opc,"csrrs")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].csr = imm;

    }else if(strcmp(opc,"csrrc")==0){
      scanf("%c%d%c , %c%d%c , %d",&rd,&n1,&comma1,&rs1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].rs1 = n2;
      prog[pc].csr = imm;

    }else if(strcmp(opc,"csrrwi")==0){
      scanf("%c%d%c , %d%c, %d",&rd,&n1,&comma1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].zimm = n2;
      prog[pc].csr = imm;
    }else if(strcmp(opc,"csrrsi")==0){
      scanf("%c%d%c , %d%c, %d",&rd,&n1,&comma1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].zimm = n2;
      prog[pc].csr = imm;
    }else if(strcmp(opc,"csrrci")==0){
      scanf("%c%d%c , %d%c, %d",&rd,&n1,&comma1,&n2,&comma2,&imm);
      prog[pc].rd = n1;
      prog[pc].zimm = n2;
      prog[pc].csr = imm;
    }else{
      strcpy(prog[pc].label,opc); 
      label[lab_i] = pc;
      lab_i++;
      pc=pc-4;
    }
    //ISA↑
    pc = pc+4;
  }

  exec(prog,mem,reg,label,pc);

  fclose(input);
  fclose(output);

  return 0;
}
