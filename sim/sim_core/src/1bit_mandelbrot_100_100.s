# this  program is made for test for vivado simulator 

# jump to entry point
	auipc	x31, 0 # [0]
	jalr	x0, x31, 37 # [1]
# dbl.32:	let rec dbl f = f +. f
	fadd	f1, f1, f1	# [2] f +. f
	jalr	x0, x1, 0	# [3] f +. f
# iloop.36:	let rec iloop i zr zi zr2 zi2 cr ci = if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci
	bne	x4, x0, 4	# [4] if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci
# beq:	print_int 1
	addi	x4, x0, 1	# [5] 1
	ob	x4	# [6] print_int 1
	jalr x0, x1, 0	# [7] print_int 1
# bne:	let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci
	fsub	f3, f3, f4	# [8] zr2 -. zi2
	# let tr = zr2 -. zi2 +. cr
	fadd	f3, f3, f5	# [9] zr2 -. zi2 +. cr
	fsw	f5, 0(x2)	# [10] dbl zr
	sw	x4, 1(x2)	# [11] dbl zr
	fsw	f3, 2(x2)	# [12] dbl zr
	fsw	f6, 3(x2)	# [13] dbl zr
	fsw	f2, 4(x2)	# [14] dbl zr
	sw	x1, 5(x2)	# [15] dbl zr
	addi	x2, x2, 6	# [16] dbl zr
	jal	x1, -15	# [17] dbl zr
	addi	x2, x2, -6	# [18] dbl zr
	lw	x1, 5(x2)	# [19] dbl zr
	flw	f2, 4(x2)	# [20] dbl zr *. zi
	fmul	f1, f1, f2	# [21] dbl zr *. zi
	flw	f6, 3(x2)	# [22] dbl zr *. zi +. ci
	# let ti = dbl zr *. zi +. ci
	fadd	f2, f1, f6	# [23] dbl zr *. zi +. ci
	flw	f1, 2(x2)	# [24] zr *. zr
	# let zr2 = zr *. zr
	fmul	f3, f1, f1	# [25] zr *. zr
	# let zi2 = zi *. zi
	fmul	f4, f2, f2	# [26] zi *. zi
	fadd	f5, f3, f4	# [27] zr2 +. zi2
	flt	x4, f13, f5	# [28] fless (2.0 *. 2.0) (zr2 +. zi2)
	bne	x4, x0, 5	# [29] if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci
# beq:	iloop (i - 1) zr zi zr2 zi2 cr ci
	lw	x4, 1(x2)	# [30] i - 1
	addi	x4, x4, -1	# [31] i - 1
	flw	f5, 0(x2)	# [32] iloop (i - 1) zr zi zr2 zi2 cr ci
	jal	x0, -29	# [33] iloop (i - 1) zr zi zr2 zi2 cr ci
# bne:	print_int 0
	addi	x4, x0, 0	# [34] 0
	ob	x4	# [35] print_int 0
	jalr x0, x1, 0	# [36] print_int 0
# entry point
	addi	x2, x0, 0 # [37]
	lui	x3, 256 # [38]
	addi	x3, x3, -1 # [39]
# program begins
	lui	x31, 273536	# [40] float_of_int x
	addi	x31, x31, 0	# [41] float_of_int x
	xtof	f1, x31	# [42] float_of_int x
	sw	x1, 0(x2)	# [43] dbl (float_of_int x)
	addi	x2, x2, 1	# [44] dbl (float_of_int x)
	jal	x1, -43	# [45] dbl (float_of_int x)
	addi	x2, x2, -1	# [46] dbl (float_of_int x)
	lw	x1, 0(x2)	# [47] dbl (float_of_int x)
	lui	x31, 242237	# [48] dbl (float_of_int x) /. 400.0
	addi	x31, x31, 1802	# [49] dbl (float_of_int x) /. 400.0
	xtof	f2, x31	# [50] dbl (float_of_int x) /. 400.0
	fmul	f1, f1, f2	# [51] dbl (float_of_int x) /. 400.0
	lui	x31, 261120	# [52] 1.5
	addi	x31, x31, 0	# [53] 1.5
	xtof	f2, x31	# [54] 1.5
	# let cr = dbl (float_of_int x) /. 400.0 -. 1.5
	fsub	f1, f1, f2	# [55] dbl (float_of_int x) /. 400.0 -. 1.5
	lui	x31, 273536	# [56] float_of_int y
	addi	x31, x31, 0	# [57] float_of_int y
	xtof	f2, x31	# [58] float_of_int y
	fsw	f1, 0(x2)	# [59] dbl (float_of_int y)
	fmv	f1, f2	# [60] dbl (float_of_int y)
	sw	x1, 1(x2)	# [61] dbl (float_of_int y)
	addi	x2, x2, 2	# [62] dbl (float_of_int y)
	jal	x1, -61	# [63] dbl (float_of_int y)
	addi	x2, x2, -2	# [64] dbl (float_of_int y)
	lw	x1, 1(x2)	# [65] dbl (float_of_int y)
	lui	x31, 242237	# [66] dbl (float_of_int y) /. 400.0
	addi	x31, x31, 1802	# [67] dbl (float_of_int y) /. 400.0
	xtof	f2, x31	# [68] dbl (float_of_int y) /. 400.0
	fmul	f1, f1, f2	# [69] dbl (float_of_int y) /. 400.0
	# let ci = dbl (float_of_int y) /. 400.0 -. 1.0
	fsub	f6, f1, f11	# [70] dbl (float_of_int y) /. 400.0 -. 1.0
	addi	x4, x0, 1000	# [71] 1000
	addi	x31, x0, 0	# [72] 0.0
	xtof	f1, x31	# [73] 0.0
	addi	x31, x0, 0	# [74] 0.0
	xtof	f2, x31	# [75] 0.0
	addi	x31, x0, 0	# [76] 0.0
	xtof	f3, x31	# [77] 0.0
	addi	x31, x0, 0	# [78] 0.0
	xtof	f4, x31	# [79] 0.0
	flw	f5, 0(x2)	# [80] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	sw	x1, 1(x2)	# [81] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	addi	x2, x2, 2	# [82] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	jal	x1, -79	# [83] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	addi	x2, x2, -2	# [84] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	lw	x1, 1(x2)	# [85] iloop 1000 0.0 0.0 0.0 0.0 cr ci
# program ends
	hlt	# [86]
