CC = gcc
CFLAGS = -Wall -std=gnu99 -g -O1
INCRUDE = include.h size.h opcode.h
SRCS = util.c parsing.c assemble.c print.c sld.c
OBJS = $(SRCS:.c=.o)
TARGET = simulator


$(TARGET): $(OBJS) $(INCRUDE) main.o
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) main.o -lm


test: $(OBJS) test.o
	$(CC) $(CFLAGS) -o $@ $^ -lm

assembler: $(OBJS) assembler.o
	$(CC) $(CFLAGS) -o $@ $^ -lm


clean:
	$(RM) $(TARGET) $(OBJS) main.o test.o assembler.o test assembler  *~
