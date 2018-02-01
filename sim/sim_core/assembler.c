#include <stdio.h>
#include "./include.h"


int main(int argc, char const *argv[])
{
	FILE *fp = NULL;
	log_fp = stderr;
	out_fp = stdout;
	LList llist = initialize_llist();
	Program program = load_asm_file(argv[1],llist);
	print_program(program,-1,-1);

	if((fp = fopen(argv[2],"w")) == NULL){
		fprintf(log_fp,"[ERROR]@assembler:\terror of opening output file:%s\n",argv[2]);
		return 0;
	}else{
		fprintf(log_fp,"[LOG]@assembler:\topen asm file:%s\n",argv[2]);
	}

	fprintf(fp,"memory_initialization_radix=2;\n");
	fprintf(fp,"memory_initialization_vector=\n");
	uint32_t code = 0;
	for(int i = 0; program[i] != NULL;i++){

		if(i != 0)fprintf(fp,",\n");
		code = create_machine_code(program[i]);
		printf("opcode:\t");
		for(int i = 6; i > 1 ; i--){
			if( code & 1<<i)putchar('1');else putchar('0');
		}
		putchar('\n');

		printf("code[%d]:%08x\n",i,code);
			for(int j = 31;j >= 0; j--){
				if(code & 1<<j)fputc('1',fp);
				else fputc('0',fp);
			}
		if(program[i+1] != NULL)print_instr(program[i+1]);
		putchar('\n');

	}
	fprintf(fp,";\n");
	fclose(fp);
	return 0;
}