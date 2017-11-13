# jump to entry point
	auipc	x31, 0 # [0]
	jalr	x0, x31, 24 # [1]
# fib.10:	let rec fib n = if n <= 1 then n else fib (n - 1) + fib (n - 2)
	addi	x5, x0, 1	# [2] 1
	bge	x5, x4, 21	# [3] if n <= 1 then n else fib (n - 1) + fib (n - 2)
# blt:	fib (n - 1) + fib (n - 2)
	addi	x5, x4, -1	# [4] n - 1
	sw	x4, 0(x2)	# [5] fib (n - 1)
	addi	x4, x5, 0	# [6] fib (n - 1)
	addi	x2, x2, 2	# [7] fib (n - 1)
	jal	x1, -6	# [8] fib (n - 1)
	addi	x2, x2, -2	# [9] fib (n - 1)
	lw	x1, 1(x2)	# [10] fib (n - 1)
	addi	x4, x4, 0	# [11] fib (n - 1)
	lw	x5, 0(x2)	# [12] n - 2
	addi	x5, x5, -2	# [13] n - 2
	sw	x4, 1(x2)	# [14] fib (n - 2)
	addi	x4, x5, 0	# [15] fib (n - 2)
	addi	x2, x2, 3	# [16] fib (n - 2)
	jal	x1, -15	# [17] fib (n - 2)
	addi	x2, x2, -3	# [18] fib (n - 2)
	lw	x1, 2(x2)	# [19] fib (n - 2)
	addi	x4, x4, 0	# [20] fib (n - 2)
	lw	x5, 1(x2)	# [21] fib (n - 1) + fib (n - 2)
	add	x4, x5, x4	# [22] fib (n - 1) + fib (n - 2)
	jalr	x0, x1, 0	# [23] fib (n - 1) + fib (n - 2)
# bge:	n
	jalr	x0, x1, 0	# [24] n
# entry point
	addi x2, x0, 0 # [25]
	lui x3, 256 # [26]
	addi x3, x3, -1 # [27]
# program begins
	addi	x4, x0, 30	# [28] 30
	addi	x2, x2, 1	# [29] fib 30
	jal	x1, -28	# [30] fib 30
	addi	x2, x2, -1	# [31] fib 30
	lw	x1, 0(x2)	# [32] fib 30
	addi	x4, x4, 0	# [33] fib 30
	sw	x4, -63(x0)	# [34] print_int (fib 30)
# program ends
	hlt # [35]
