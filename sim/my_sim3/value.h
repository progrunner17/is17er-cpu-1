#include <stdio.h>

#ifndef _VALUE
#define _VALUE

#define MEMORY_SIZE  (1024 * 1024 * 4)	
#define PROGRAM_SIZE (1024 * 1024)
#define BUF_SIZE 256
extern FILE *log_fp;
extern FILE *out_fp;
extern FILE *in_fp;
extern char *machine_filename;
extern char *source_filename;
extern char *input_filename;
extern char *output_filename;
extern char *log_filename;
#endif
