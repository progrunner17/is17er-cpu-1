jal x0, _entry
fib:
sw  x1, 0(x2)    # store link register
sw  x4, -1(x2)	# store n
addi x5, x0, 1  # x5 = 1
bge x5, x4, _bge # b 1 >= n
addi x4, x4, -1   # n = n - 1
addi x2, x2, 4
jal x1, fib
addi x2, x2, -4
sw x4, -2(x2)
lw x4, -1(x2)
addi x4, x4, -2 # n = n - 2
addi x2, x2, 4
jal x1, fib
addi x2, x2, -4
lw x5, -2(x2)  # x5 = fib (n - 1)
add x4, x4, x5
lw x1, 0(x2)
jalr x0, x1, 0
_entry:
addi x4, x0 ,10
addi x2, x0 ,4
jal x1, fib
addi x2, x2, -4 # return
# sw x4, -63(x0)
ob x4
hlt
_bge:
jalr x0, x1, 0
