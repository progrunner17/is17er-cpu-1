CC = gcc
CFLAGS = -Wall -std=gnu99 -g3 -O1
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
TARGET = simulator
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ -lm
clean:
	$(RM) $(TARGET) $(OBJS) *~
