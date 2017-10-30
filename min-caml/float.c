#include <stdio.h>
#include <stdint.h>
#include <caml/mlvalues.h>
#include <caml/alloc.h>

typedef union {
  int32_t i;
  float f;
} i_f;

value int32_of_float(value v) {
  i_f d;
  d.f = (float)Double_val(v);
  return copy_int32(d.i);
}
