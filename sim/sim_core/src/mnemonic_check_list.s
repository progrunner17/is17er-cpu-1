lui x1, 100
auipc x1, 100
jal  x1, 100
jalr x1, x2, 100
beq  x1, x2, -100
bne  x1, x2, -100
blt  x1, x2, -100
bge  x1, x2, -100
bltu x1, x2, -100
bgeu x1, x2, -100
lb  x1, 100(x2)
lh  x1, 100(x2)
lw  x1, 100(x2)
lbu x1, 100(x2)
lhu x1, 100(x2)
sb  x1, -100(x2)
sh  x1, -100(x2)
sw  x1, -100(x2)
addi   x1, x2, 100
slli   x1, x2, 100
slti   x1, x2, 100
sltiu  x1, x2, 100
xori  x1, x2, 100
srai  x1, x2, 100
srli  x1, x2, 100
ori  x1, x2, 100
andi  x1, x2, 100
sub   x1, x2, x3
add   x1, x2, x3
sll   x1, x2, x3
slt   x1, x2, x3
sltu  x1, x2, x3
xor  x1, x2, x3
sra  x1, x2, x3
srl  x1, x2, x3
or  x1, x2, x3
and  x1, x2, x3
flw f1, 100(x2)
fsw f1, 100(x2)
fadd f1, f2, f3
fsub f1, f2, f3
fmul f1, f2, f3
fdiv f1, f2, f3
fsqrt f1, f2
fmv f1, f2
fneg f1, f2
fabs f1, f2
ftoi x1, f2
ftox x1, f2
feq x1, f2, f3
flt x1, f2, f3
fle x1, f2, f3
itof f1, x2
xtof f1, x2
ob x1
ib x1
hlt