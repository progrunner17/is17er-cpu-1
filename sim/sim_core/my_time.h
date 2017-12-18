

#ifndef _MY_TIME
#define _MY_TIME
#include <time.h>

// 時間計測用
#define GETTIME_FROM(ts,t)  {clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9;}
#define GETTIME_TO(ts,t) {clock_gettime(CLOCK_REALTIME, &ts); t = (double) ts.tv_sec + (double) ts.tv_nsec * 1e-9 - t;}
/*
//以下のように二つの変数を宣言
struct timespac ts;
double t;
GETTIME_FROM(ts,t)
処理本体
GETTIME_TO(ts,t)
でtに処理時間が格納される.
*/

extern struct timespec ts;
extern double t;
#endif

