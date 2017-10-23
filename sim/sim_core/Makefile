CC = gcc
CFLAGS = -Wall -std=gnu99 -g -O1
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)

TARGET = simulator


$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	$(RM) $(TARGET) $(OBJS) *~
