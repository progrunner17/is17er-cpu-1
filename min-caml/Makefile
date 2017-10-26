# Sumii's Makefile for Min-Caml (for GNU Make)
#
# ack.mlなどのテストプログラムをtest/に用意してmake do_testを実行すると、
# min-camlとocamlでコンパイル・実行した結果を自動で比較します。

RESULT = min-caml
LIBS = str
NCSUFFIX = .opt
CC = gcc
CFLAGS = -g -O2 -Wall
OCAMLLDFLAGS = -warn-error -31

$(RESULT): debug-code top

# ↓もし実装を改造したら、それに合わせて変える
SOURCES = float.c h.ml type.ml id.ml m.ml s.ml \
syntax.ml parser.mly lexer.mll typing.mli typing.ml kNormal.mli kNormal.ml \
alpha.mli alpha.ml beta.mli beta.ml assoc.mli assoc.ml \
inline.mli inline.ml constFold.mli constFold.ml elim.mli elim.ml cse.ml lamlift.ml \
closure.mli closure.ml asm.mli asm.ml virtual.mli virtual.ml \
simm.mli simm.ml regAlloc.mli regAlloc.ml emit.mli emit.ml \
main.mli main.ml

TRASH = test/*.s min-rt/*.s

include OCamlMakefile
