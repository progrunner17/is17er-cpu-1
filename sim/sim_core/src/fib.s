	# .globl _min_caml_start
# fib.10:	# let rec fib n = if n <= 1 then n else fib (n - 1) + fib (n - 2)
	addi	x5, x0, 1	# 1
	bge	x5, x4, 21	# if n <= 1 then n else fib (n - 1) + fib (n - 2)
# blt:	fib (n - 1) + fib (n - 2)
	addi	x5, x4, -1	# n - 1
	sw	x4, 0(x2)	# fib (n - 1)
	addi	x4, x5, 0	# fib (n - 1)
	addi	x2, x2, 2	# fib (n - 1)
	jal	x0, -7	# fib (n - 1)
	addi	x2, x2, -2	# fib (n - 1)
	lw	x1, 1(x2)	# fib (n - 1)
	addi	x4, x4, 0	# fib (n - 1)
	lw	x5, 0(x2)	# n - 2
	addi	x5, x5, -2	# n - 2
	sw	x4, 1(x2)	# fib (n - 2)
	addi	x4, x5, 0	# fib (n - 2)
	addi	x2, x2, 3	# fib (n - 2)
	jal	x0, -16	# fib (n - 2)
	addi	x2, x2, -3	# fib (n - 2)
	lw	x1, 2(x2)	# fib (n - 2)
	addi	x4, x4, 0	# fib (n - 2)
	lw	x5, 1(x2)	# fib (n - 1) + fib (n - 2)
	add	x4, x5, x4	# fib (n - 1) + fib (n - 2)
	jalr	x0, x1, 0	# fib (n - 1) + fib (n - 2)
# bge:	n
	jalr	x0, x1, 0	# n
_min_caml_start:	# entry point
	addi x2, x0, 0
	lui x3, 256
	addi x3, x3, 1048575
# program starts
	addi	x4, x0, 30	# 30
	addi	x2, x2, 1	# fib 30
	jal	x0, -29	# fib 30
	addi	x2, x2, -1	# fib 30
	lw	x1, 0(x2)	# fib 30
	addi	x4, x4, 0	# fib 30
	sw	x4, -1024(x0)	# print_int (fib 30)
# program ends
	jal x4, 0x10
	jal x4, 10
	jal x4, _min_caml_start:


# addi x1, x0, 1
# addi x2, x0, 0
# addi x6, x0, 20


# fib:
# addi x3, x1, 0
# add x1, x1, x2
# addi x2, x3, 0
# addi x6, x6, -1
# blt x0, x6, fib:
# sw	x0, -1024(x0)
# sw	x1, -1024(x0)
# sw	x2, -1024(x0)
# sw	x3, -1024(x0)
