addi x1, x0, 1
addi x2, x0, 0
addi x6, x0, 20000000

fib:
addi x3, x1, 0
add x1, x1, x2
addi x2, x3, 0
addi x6, x6, -1
blt x0, x6, fib: