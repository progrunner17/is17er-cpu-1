CC = gcc
CFLAGS = -Wall -std=gnu99 -g -O1
INCLUDE = include.h opcode.h type.h value.h sld.h exec_function.h other_function.h
SRCS = exec_function.c other_function.c sld.c
OBJS = $(SRCS:.c=.o)

simulator: $(OBJS) $(INCLUDE) main.o
	$(CC) $(CFLAGS) -o $@ $(OBJS) main.o -lm

clean: 
	$(RM) simulator *.o *.ppm *~
