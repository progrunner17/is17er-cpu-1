# jump to entry point
	auipc	x31, 0 # [0]
	jalr	x0, x31, 15 # [1]
# f.8:	let rec f x = (if x < 0 then if x < 1 then 10 else 20 else if x < 2 then 30 else 40) + 100
	bge	x4, x0, 7	# [2] if x < 0 then if x < 1 then 10 else 20 else if x < 2 then 30 else 40
# blt:	if x < 1 then 10 else 20
	addi	x5, x0, 1	# [3] 1
	bge	x4, x5, 3	# [4] if x < 1 then 10 else 20
# blt:	10
	addi	x4, x0, 10	# [5] 10
	jal	x0, 2	# [6] if x < 1 then 10 else 20
# bge:	20
	addi	x4, x0, 20	# [7] 20
# cont:	if x < 1 then 10 else 20
	jal	x0, 6	# [8] if x < 0 then if x < 1 then 10 else 20 else if x < 2 then 30 else 40
# bge:	if x < 2 then 30 else 40
	addi	x5, x0, 2	# [9] 2
	bge	x4, x5, 3	# [10] if x < 2 then 30 else 40
# blt:	30
	addi	x4, x0, 30	# [11] 30
	jal	x0, 2	# [12] if x < 2 then 30 else 40
# bge:	40
	addi	x4, x0, 40	# [13] 40
# cont:	if x < 2 then 30 else 40
# cont:	if x < 0 then if x < 1 then 10 else 20 else if x < 2 then 30 else 40
	addi	x4, x4, 100	# [14] (if x < 0 then if x < 1 then 10 else 20 else if x < 2 then 30 else 40) + 100
	jalr	x0, x1, 0	# [15] (if x < 0 then if x < 1 then 10 else 20 else if x < 2 then 30 else 40) + 100
# entry point
	addi x2, x0, 0 # [16]
	lui x3, 256 # [17]
	addi x3, x3, -1 # [18]
# program begins
	addi	x4, x0, 10	# [19] 10
	addi	x2, x2, 1	# [20] f 10
	jal	x1, -19	# [21] f 10
	addi	x2, x2, -1	# [22] f 10
	lw	x1, 0(x2)	# [23] f 10
	addi	x4, x4, 0	# [24] f 10
	sw	x4, -63(x0)	# [25] print_int (f 10)
# program ends
	hlt # [26]
