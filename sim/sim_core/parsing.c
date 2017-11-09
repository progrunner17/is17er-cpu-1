#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include "include.h"
#include "size.h"
#include "include.h"
#define PROMPT ">> "




/* 標準入力から最大size-1個の文字を改行またはEOFまで読み込み、sに設定する */
char* get_line(char *s, int size) {
    printf(PROMPT);

    while(fgets(s, size, stdin) == NULL) {
        if(errno == EINTR)
            continue;
        return NULL;
    }
    return s;
}

// コマンドライン引数からファイル名を受け取る
files parse_commandline_arg(int argc, char **argv){
	files args;
	args = (files )malloc(sizeof(struct _files));
	bzero(args,sizeof(struct _files));
	int opt;
	opterr = 0;
    while ((opt = getopt(argc, argv, "m:s:i:o:l:a")) != -1) {
        //コマンドライン引数のオプションがなくなるまで繰り返す
        switch (opt) {
            case 'm':
            	args->machine_filename = malloc(strlen(optarg));
                strcpy(args->machine_filename,optarg);
                break;
           case 's':
           		args->source_filename = malloc(strlen(optarg));
                strcpy(args->source_filename,optarg);
                break;
           case 'l':
           		args->log_filename = malloc(strlen(optarg));
                strcpy(args->log_filename,optarg);
                break;

           case 'i':
           		args->input_filename = malloc(strlen(optarg));
                strcpy(args->input_filename,optarg);
                break;

           case 'o':
           		args->output_filename = malloc(strlen(optarg));
                strcpy(args->output_filename,optarg);
                break;


            default: /* '?' */
                //指定していないオプションが渡された場合
                // printf("Usage: %s [-f] [-g] [-h argment] arg1 ...\n", argv[0]);
                fprintf(stderr,"command line arguments error\n");
                break;
        }
    }


	printf("-- files ---------------------------------------------------------------\n");

	if(!args->source_filename){
		char buff[BUF_SIZE];
		printf("please input source file name\n>> ");
		fgets(buff,BUF_SIZE,stdin);
		args->source_filename = malloc(BUF_SIZE);
		sscanf(buff,"%s",args->source_filename);
	}

	printf("source_file:\t\t%s\n",args->source_filename);


	printf("machine_code_file\t");
	if(args->machine_filename)printf("%s\n",args->machine_filename);//NULLじゃなかったら
	else printf("unset\n");


	printf("log_file:\t\t");
	if(args->log_filename)printf("%s\n",args->log_filename);
	else printf("unset\n");


	printf("input_file:\t\t");
	if(args->input_filename)printf("%s\n",args->input_filename);
	else printf("unset\n");


	printf("output_file:\t\t");
	if(args->output_filename)printf("%s\n",args->output_filename);
	else printf("unset\n");

	printf("------------------------------------------------------------------------\n");

    return args;
}




