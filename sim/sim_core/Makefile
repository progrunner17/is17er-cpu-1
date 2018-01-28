CC = gcc
CFLAGS = -Wall -std=gnu99 -g -O1
LDFLAGS = -lm
INCRUDE = include.h size.h opcode.h
SRCS = util.c parsing.c assemble.c print.c sld.c
OBJS = $(SRCS:.c=.o)
TARGET = simulator
TESTS = 01 02 03

# simulator
$(TARGET): $(OBJS) $(INCRUDE) main.o
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS) main.o $(LDFLAGS)

# assembler
assembler: $(OBJS) assembler.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

# test
define test_template
test$(1):test$1.o $(INCRUDE) $(OBJS)
	$(CC) $(CFLAGS) -o test$1 $(OBJS) test$1.o $(LDFLAGS)
endef
$(foreach prog,$(TESTS),$(eval $(call test_template,$(prog))))


clean:
	$(RM) $(TARGET)  assembler $(addprefix test,$(TESTS)) *.o *~
