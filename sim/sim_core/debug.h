#ifndef _DEBUG
#define _DEBUG

typedef enum {
PC_is,
Line_is,
XRD_is,
FRD_is,
OP_is
} cond;


typedef struct _cond_clj *Cond;
struct _cond_clj{
cond c;
int pc;
char s[128];
};


#endif