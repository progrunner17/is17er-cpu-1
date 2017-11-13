CC = gcc
CFLAGS = -Wall -std=gnu99 -g -O1
SRCS = util.c parsing.c assemble.c print.c
OBJS = $(SRCS:.c=.o)
TARGET = simulator


simulator: $(OBJS) simulator.o
	$(CC) $(CFLAGS) -o $@ $^ -lm


test: $(OBJS) test.o
	$(CC) $(CFLAGS) -o $@ $^ -lm


clean:
	$(RM) $(TARGET) $(OBJS) *~
