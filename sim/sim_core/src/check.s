addi x1, x0, 3
ob x1
addi x2, x0, 5
ob x2
add  x3, x1, x2
ob x3
lui x1, 0x12
auipc x2, 3
jal x0,2
hlt
beq x1,x1,2
hlt
bne x0,x1,2
hlt
blt x0,x1,2
hlt
addi x1, x0 ,0x123
addi x2, x0, 0
sw x1, 3(x2)
addi x2, x2, 1
lw x3, 2(x2)
addi x4, x0, 0x123
beq x3, x4, 2
hlt
addi x1, x0, 0x100
slli x1, x1, 2
srli x1, x1, 3
addi x1,x0,0
addi x2,x0,0
addi x3,x0,0
addi x4,x0,0
fadd f1, f11, f11 # f1 = 2
fmul f2, f1, f1   # f2 = 4
fsub f3, f2, f11  # f3 = 3
fdiv f4, f3, f1   # f4 = 1.5
fsqrt f5 ,f3     #   f5 = 1.732
fneg  f6, f5
fabs  f7, f6
fmv  f8 ,f26
ftox x1 ,f8
xtof f9, x1
ftoi x2, f11
addi x2, x0, 5
itof f1, x2
feq x2, f5 ,f7
flt x2, f6, f0




