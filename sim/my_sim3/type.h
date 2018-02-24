#ifndef _TYPE
#define _TYPE
typedef int instruction[32];
typedef instruction *BinaryCode;

union mem{
int x;
float f;
};

struct machine {
int pc;
int fcsr;
int x[32];//汎用レジスタ
float f[32];//浮動小数点数レジスタ
union mem *mem;
int stack_max;
int heap_max;
};

typedef struct machine *Machine;
#endif
