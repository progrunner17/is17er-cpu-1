lui x1,100
lui x1,0x100
auipc x1,100
auipc x1,0x100
jal x1,100
jal x1,label
jalr x1,x2,100
lb x1 , 100(x2)
lh x1 , 100(x2)
lw x1 , 100(x2)
lw x1 , 0x100(x2)
sb x1, 100(x2)
sh x1, 100(x2)
sw x1, 100(x2)
sw x1, 0x100(x2)
addi x1, x2 , 0x10
addi x1, x2 , 10
slli x1, x2 , 10
slti x1, x2 , 10
xori x1, x2 , 10
srai x1, x2 , 10
srli x1, x2 , 10
andi x1, x2 , 10
ori x1, x2 , 10
flw x1 , 100(x2)
fsw x1 , 100(x2)
label:


fadd f1, f2, f3
fsub f1, f2, f3
fmul f1, f2, f3
fdiv f1, f2, f3
fsqrt f1, f2
fmv f1, f2
fneg f1, f2
fabs f1, f2
ftoi f1, f2, f3
ftox f1, f2, f3
feq f1, f2, f3
flt f1, f2, f3
fle f1, f2, f3
itof f1, f2, f3
xtof f1, f2, f3


