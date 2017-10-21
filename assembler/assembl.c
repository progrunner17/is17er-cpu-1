#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define HASHSIZE 10

typedef struct list List;
struct list {
    char key[100];
    int value;
    List *next;
};

List* list_empty(){
   List *l;
   l=malloc(sizeof(List));
   if(l!=NULL){
     l->next=NULL;
   }

   return l;
}

int list_isempty(List *l)
{
  int s=0;

  if (l->next==NULL)
    s=1;
  
  return s;
}

int get_index(char *key)
{
    return strlen(key)%HASHSIZE;
}

List *list_search(char *key, List *l)
{
  if(list_isempty(l))
    return NULL;
  
  else if(strcmp(key,l->key)==0)
    return l;
  
  else
    return list_search(key,l->next); 
}

List *member(List hash[HASHSIZE],char *key)
{
    int index=get_index(key);
    
    return list_search(key,&hash[index]);
}

List *list_insert(char *key,int val,List *l)
{
  if(list_isempty(l)){
    strcpy(l->key,key);
    l->value = val;
    l->next = list_empty();

    return l;
  }

  else if(strcmp(key,l->key)==0){
    l->value = val;

    return l;
  }

  else{
    l->next=list_insert(key,val,l->next);

    return l;
  }
}

List *insert(List hash[HASHSIZE],char *key,int val,int index)
{
    return list_insert(key,val,&hash[index]);
}

List *list_delete(char *key,List *l)
{
  if(list_isempty(l)){
    return l;
  }

  else if(strcmp(key,l->key)==0){
    return l->next;
  }

  else{
    l->next=list_delete(key,l->next);

    return l;
  }
}

List *delete(List hash[HASHSIZE],char *key,int index)
{
  return list_delete(key,&hash[index]);
}

void list_free(List* l){
  if(l!=NULL){
    list_free(l->next);
    free(l);
  }
}

void hash_free(List *hash[HASHSIZE])
{
    int s;

    for(s=0;s<HASHSIZE;s++){
        list_free(hash[s]);
    }
}

int binary(int dec){
    int bin = 0;
    int base = 1;
    while(abs(dec) > 0){
        bin = bin + (dec % 2) * base;
        dec = dec / 2;
        base = base * 10;
    }
    return bin;
}

int sign(int imm){
    if(imm < 0) return 1;
    else return 0;
}

//一周プログラムを読み込んでlabelをtableに格納
void labelcheck(FILE *fp, List table[HASHSIZE]){
    char line[30], label[30];
    int index, lnum = 1;

    while(fgets(line, 30, fp) != NULL){
        if(strstr(line, ":") != NULL){
            strcpy(label, strtok(strtok(line, ":"), " "));
            index=get_index(label);
            table[index] = *insert(table, label, lnum, index);
            lnum--;
        }
        lnum++;
    }
}

int main(int argc, char *argv[])
{
    FILE *in, *out;
    char buf[20];
    char rd[5], rs[5], rs1[5], rs2[5], imm[10], label[30];
    List *hash[HASHSIZE];
    int line, linep, s, lnum = 1;

    if (argc <= 2){
        puts("too few arguments");
        return 1;
    }
    in = fopen(argv[1], "r");
    if(in == NULL){
        perror("fopen");
        return 1;
    }
    out = fopen(argv[2], "w");
    if(out == NULL){
        perror("fopen");
        return 1;
    }

    for(s=0;s<HASHSIZE;s++){
        hash[s]=list_empty();
    }

    labelcheck(in, *hash);

    in = fopen(argv[1], "r");
    if(in == NULL){
        perror("fopen");
        return 1;
    }

    while(fscanf(in, "%s", buf) != EOF){
        if (strcmp(buf, "lui") == 0){
            fscanf(in, "%s", rd);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%019d%05d0110111\n", sign(atoi(imm)), binary(atoi(imm)), binary(atoi(rd+1)));
        }
        if (strcmp(buf, "auipc") == 0){
            fscanf(in, "%s", rd);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%019d%05d0010111\n", sign(atoi(imm)), binary(atoi(imm)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "jal") == 0){
            fscanf(in, "%s", rd);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%010d%d%08d%05d1101111\n", sign(atoi(imm)), binary(atoi(imm)%1024), binary((atoi(imm)%2048)/1024), binary(atoi(imm)/2048), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "jalr") == 0){
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%011d%05d000%05d1100111\n", sign(atoi(imm)), binary(atoi(imm)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "beq") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fscanf(in, "%s", label);
            line = 2 * (member(*hash, label) -> value - lnum);
            linep = line * (1 - 2 * sign(line));
            fprintf(out, "%d%06d%05d%05d000%04d%d1100011\n", sign(line), binary((linep%512)/16), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(linep%16), binary(linep/512));
        }
        else if (strcmp(buf, "bne") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fscanf(in, "%s", label);
            line = 2 * (member(*hash, label) -> value - lnum);
            linep = line * (1 - 2 * sign(line));
            fprintf(out, "%d%06d%05d%05d001%04d%d1100011\n", sign(line), binary((linep%512)/16), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(linep%16), binary(linep/512));
        }
        else if (strcmp(buf, "blt") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fscanf(in, "%s", label);
            line = 2 * (member(*hash, label) -> value - lnum);
            linep = line * (1 - 2 * sign(line));
            fprintf(out, "%d%06d%05d%05d100%04d%d1100011\n", sign(line), binary((linep%512)/16), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(linep%16), binary(linep/512));
        }
        else if (strcmp(buf, "bge") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fscanf(in, "%s", label);
            line = 2 * (member(*hash, label) -> value - lnum);
            linep = line * (1 - 2 * sign(line));
            fprintf(out, "%d%06d%05d%05d101%04d%d1100011\n", sign(line), binary((linep%512)/16), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(linep%16), binary(linep/512));
        }
        else if (strcmp(buf, "bltu") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fscanf(in, "%s", label);
            line = 2 * (member(*hash, label) -> value - lnum);
            linep = line * (1 - 2 * sign(line));
            fprintf(out, "%d%06d%05d%05d110%04d%d1100011\n", sign(line), binary((linep%512)/16), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(linep%16), binary(linep/512));
        }
        else if (strcmp(buf, "bgeu") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fscanf(in, "%s", label);
            line = 2 * (member(*hash, label) -> value - lnum);
            linep = line * (1 - 2 * sign(line));
            fprintf(out, "%d%06d%05d%05d111%04d%d1100011\n", sign(line), binary((linep%512)/16), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(linep%16), binary(linep/512));
        }


        else if (strcmp(buf, "lb") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s(%s)", imm, rs1);
            fprintf(out, "%d%011d%05d000%05d0000011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "lh") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s(%s)", imm, rs1);
            fprintf(out, "%d%011d%05d001%05d0000011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "lw") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s(%s)", imm, rs1);
            fprintf(out, "%d%011d%05d010%05d0000011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "lbu") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s(%s)", imm, rs1);
            fprintf(out, "%d%011d%05d100%05d0000011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "lhu") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s(%s)", imm, rs1);
            fprintf(out, "%d%011d%05d0101%05d0000011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }

        else if (strcmp(buf, "sb") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s(%s)", imm, rs2);
            fprintf(out, "%d%06d%05d%05d000%05d0100011\n", sign(atoi(imm)), binary((atoi(imm)%2048)/32), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(imm)%32));
        }
        else if (strcmp(buf, "sh") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s(%s)", imm, rs2);
            fprintf(out, "%d%06d%05d%05d001%05d0100011\n", sign(atoi(imm)), binary((atoi(imm)%2048)/32), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(imm)%32));
        }
        else if (strcmp(buf, "sw") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s(%s)", imm, rs2);
            fprintf(out, "%d%06d%05d%05d010%05d0100011\n", sign(atoi(imm)), binary((atoi(imm)%2048)/32), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(imm)%32));
        }
        

        
        else if (strcmp(buf, "addi") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%011d%05d000%05d0010011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "slti") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%011d%05d010%05d0010011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "sltiu") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%011d%05d011%05d0010011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "xori") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%011d%05d100%05d0010011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "ori") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%011d%05d110%05d0010011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "andi") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "%d%011d%05d111%05d0010011\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "slli") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "0000000%056d%05d000%05d0010011\n", binary(atoi(imm)%32), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "srli") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "0000000%05d%05d000%05d0010011\n", binary(atoi(imm)%32), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "srai") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", imm);
            fprintf(out, "0100000%05d%05d000%05d0010011\n", binary(atoi(imm)%32), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        

        else if (strcmp(buf, "add") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d000%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "sub") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0100000%05d%05d000%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "sll") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d001%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "slt") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d010%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "sltu") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d011%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "xor") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d100%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "srl") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d101%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "sra") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0100000%05d%05d101%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "or") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d110%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "and") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d111%05d0110011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "flw") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s(%s)", imm, rs);
            fprintf(out, "%d%011d%05d010%05d0000111\n", sign(atoi(imm)), binary(atoi(imm)%2048), binary(atoi(rs+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "fsw") == 0) {
            fscanf(in, "%s", rs1);
            fscanf(in, "%s(%s)", imm, rs2);
            fprintf(out, "%d%06d%05d%05d010%05d0100111\n", sign(atoi(imm)), binary((atoi(imm)%2048)/32), binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(imm)%32));
        }


        else if (strcmp(buf, "fadd") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000000%05d%05d000%05d1010011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "fsub") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0000100%05d%05d000%05d1010011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "fmul") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0001000%05d%05d000%05d1010011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "fdiv") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "0001100%05d%05d000%05d1010011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "fsqrt") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "010110000000%05d000%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rd+1)));
        }


        //else if (strcmp(buf, "fmv.s") == 0) {
        //    fscanf(in, "%s", rd);
        //    fscanf(in, "%s", rs);
        //    fprintf(out, "0010000%05d%05d000%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        //}


        else if (strcmp(buf, "fabs") == 0) { //FSGNJX.S
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "0010001%05d%05d010%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rs+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "fneg") == 0) { //FSGNJN.S
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "0010001%05d%05d001%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rs+1)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "feq") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "1010001%05d%05d010%05d1010011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "flt") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "1010001%05d%05d001%05d1010011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "fle") == 0) {
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs1);
            fscanf(in, "%s", rs2);
            fprintf(out, "1010001%05d%05d000%05d1010011\n", binary(atoi(rs2+1)), binary(atoi(rs1+1)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "itof") == 0) { //FCVT.S.W, RM = 000
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "110100000000%05d000%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "floor") == 0) { //FCVT.S.W, RM = 010
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "110100000000%05d010%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "ftoi") == 0) { //FCVT.W.S, RM = 000
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "110000000000%05d000%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rd+1)));
        }


        else if (strcmp(buf, "mvftoi") == 0) { //FMV.X.W
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "111000000000%05d000%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rd+1)));
        }
        else if (strcmp(buf, "mvitof") == 0) { //FMV.W.X
            fscanf(in, "%s", rd);
            fscanf(in, "%s", rs);
            fprintf(out, "111100000000%05d000%05d1010011\n", binary(atoi(rs+1)), binary(atoi(rd+1)));
        }

        else{
            lnum--;
        }
        lnum++;
        // コメントの対応？
        // 渡される即値をみてはじくようにしたい?
    }

    hash_free(hash);
    fclose(in);
    fclose(out);

    return 0;
}
