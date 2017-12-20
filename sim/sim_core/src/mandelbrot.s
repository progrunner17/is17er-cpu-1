# jump to entry point
	auipc	x31, 0 # [0]
	jalr	x0, x31, 107 # [1]
# dbl.40:	let rec dbl f = f +. f
	fadd	f1, f1, f1	# [2] f +. f
	jalr	x0, x1, 0	# [3] f +. f
# iloop.56:	let rec iloop i zr zi zr2 zi2 cr ci = if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci
	bne	x4, x0, 4	# [4] if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci
# beq:	print_int 1
	addi	x4, x0, 49	# [5] 1
	ob	x4 	# [6] print_int 1
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
	addi	x4, x0, 48	# [34] 0
	ob	x4 	# [35] print_int 0
	jalr x0, x1, 0	# [36] print_int 0
# xloop.46:	let rec xloop x y = if x >= 400 then () else let cr = dbl (float_of_int x) /. 400.0 -. 1.5 in let ci = dbl (float_of_int y) /. 400.0 -. 1.0 in let rec iloop i zr zi zr2 zi2 cr ci = if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci in iloop 1000 0.0 0.0 0.0 0.0 cr ci ; (* let i = ref 1000 in let zr = ref 0.0 in let zi = ref 0.0 in let zr2 = ref 0.0 in let zi2 = ref 0.0 in while (if !i = 0 then (print_int 1; false) else let tr = !zr2 -. !zi2 +. cr in let ti = dbl !zr *. !zi +. ci in zr := tr; zi := ti; zr2 := !zr *. !zr; zi2 := !zi *. !zi; if !zr2 +. !zi2 > 2.0 *. 2.0 then (print_int 0; false) else true) do i := !i - 1 done; *) xloop (x + 1) y
	addi	x6, x0, 400	# [37] 400
	bge	x4, x6, 51	# [38] if x >= 400 then () else let cr = dbl (float_of_int x) /. 400.0 -. 1.5 in let ci = dbl (float_of_int y) /. 400.0 -. 1.0 in let rec iloop i zr zi zr2 zi2 cr ci = if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci in iloop 1000 0.0 0.0 0.0 0.0 cr ci ; (* let i = ref 1000 in let zr = ref 0.0 in let zi = ref 0.0 in let zr2 = ref 0.0 in let zi2 = ref 0.0 in while (if !i = 0 then (print_int 1; false) else let tr = !zr2 -. !zi2 +. cr in let ti = dbl !zr *. !zi +. ci in zr := tr; zi := ti; zr2 := !zr *. !zr; zi2 := !zi *. !zi; if !zr2 +. !zi2 > 2.0 *. 2.0 then (print_int 0; false) else true) do i := !i - 1 done; *) xloop (x + 1) y
# blt:	let cr = dbl (float_of_int x) /. 400.0 -. 1.5 in let ci = dbl (float_of_int y) /. 400.0 -. 1.0 in let rec iloop i zr zi zr2 zi2 cr ci = if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci in iloop 1000 0.0 0.0 0.0 0.0 cr ci ; (* let i = ref 1000 in let zr = ref 0.0 in let zi = ref 0.0 in let zr2 = ref 0.0 in let zi2 = ref 0.0 in while (if !i = 0 then (print_int 1; false) else let tr = !zr2 -. !zi2 +. cr in let ti = dbl !zr *. !zi +. ci in zr := tr; zi := ti; zr2 := !zr *. !zr; zi2 := !zi *. !zi; if !zr2 +. !zi2 > 2.0 *. 2.0 then (print_int 0; false) else true) do i := !i - 1 done; *) xloop (x + 1) y
	itof	f1, x4	# [39] float_of_int x
	sw	x4, 0(x2)	# [40] dbl (float_of_int x)
	sw	x5, 1(x2)	# [41] dbl (float_of_int x)
	sw	x1, 2(x2)	# [42] dbl (float_of_int x)
	addi	x2, x2, 3	# [43] dbl (float_of_int x)
	jal	x1, -42	# [44] dbl (float_of_int x)
	addi	x2, x2, -3	# [45] dbl (float_of_int x)
	lw	x1, 2(x2)	# [46] dbl (float_of_int x)
	lui	x31, 242237	# [47] dbl (float_of_int x) /. 400.0
	addi	x31, x31, 1802	# [48] dbl (float_of_int x) /. 400.0
	xtof	f2, x31	# [49] dbl (float_of_int x) /. 400.0
	fmul	f1, f1, f2	# [50] dbl (float_of_int x) /. 400.0
	lui	x31, 261120	# [51] 1.5
	addi	x31, x31, 0	# [52] 1.5
	xtof	f2, x31	# [53] 1.5
	# let cr = dbl (float_of_int x) /. 400.0 -. 1.5
	fsub	f1, f1, f2	# [54] dbl (float_of_int x) /. 400.0 -. 1.5
	lw	x4, 1(x2)	# [55] float_of_int y
	itof	f2, x4	# [56] float_of_int y
	fsw	f1, 2(x2)	# [57] dbl (float_of_int y)
	fmv	f1, f2	# [58] dbl (float_of_int y)
	sw	x1, 3(x2)	# [59] dbl (float_of_int y)
	addi	x2, x2, 4	# [60] dbl (float_of_int y)
	jal	x1, -59	# [61] dbl (float_of_int y)
	addi	x2, x2, -4	# [62] dbl (float_of_int y)
	lw	x1, 3(x2)	# [63] dbl (float_of_int y)
	lui	x31, 242237	# [64] dbl (float_of_int y) /. 400.0
	addi	x31, x31, 1802	# [65] dbl (float_of_int y) /. 400.0
	xtof	f2, x31	# [66] dbl (float_of_int y) /. 400.0
	fmul	f1, f1, f2	# [67] dbl (float_of_int y) /. 400.0
	# let ci = dbl (float_of_int y) /. 400.0 -. 1.0
	fsub	f6, f1, f11	# [68] dbl (float_of_int y) /. 400.0 -. 1.0
	addi	x4, x0, 1000	# [69] 1000
	addi	x31, x0, 0	# [70] 0.0
	xtof	f1, x31	# [71] 0.0
	addi	x31, x0, 0	# [72] 0.0
	xtof	f2, x31	# [73] 0.0
	addi	x31, x0, 0	# [74] 0.0
	xtof	f3, x31	# [75] 0.0
	addi	x31, x0, 0	# [76] 0.0
	xtof	f4, x31	# [77] 0.0
	flw	f5, 2(x2)	# [78] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	sw	x1, 3(x2)	# [79] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	addi	x2, x2, 4	# [80] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	jal	x1, -77	# [81] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	addi	x2, x2, -4	# [82] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	lw	x1, 3(x2)	# [83] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	addi	x0, x4, 0	# [84] iloop 1000 0.0 0.0 0.0 0.0 cr ci
	lw	x4, 0(x2)	# [85] x + 1
	addi	x4, x4, 1	# [86] x + 1
	lw	x5, 1(x2)	# [87] xloop (x + 1) y
	jal	x0, -51	# [88] xloop (x + 1) y
# bge:	()
	jalr x0, x1, 0	# [89] ()
# yloop.42:	let rec yloop y = if y >= 400 then () else let rec xloop x y = if x >= 400 then () else let cr = dbl (float_of_int x) /. 400.0 -. 1.5 in let ci = dbl (float_of_int y) /. 400.0 -. 1.0 in let rec iloop i zr zi zr2 zi2 cr ci = if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci in iloop 1000 0.0 0.0 0.0 0.0 cr ci ; (* let i = ref 1000 in let zr = ref 0.0 in let zi = ref 0.0 in let zr2 = ref 0.0 in let zi2 = ref 0.0 in while (if !i = 0 then (print_int 1; false) else let tr = !zr2 -. !zi2 +. cr in let ti = dbl !zr *. !zi +. ci in zr := tr; zi := ti; zr2 := !zr *. !zr; zi2 := !zi *. !zi; if !zr2 +. !zi2 > 2.0 *. 2.0 then (print_int 0; false) else true) do i := !i - 1 done; *) xloop (x + 1) y in xloop 0 y; yloop (y + 1)
	addi	x5, x0, 400	# [90] 400
	bge	x4, x5, 15	# [91] if y >= 400 then () else let rec xloop x y = if x >= 400 then () else let cr = dbl (float_of_int x) /. 400.0 -. 1.5 in let ci = dbl (float_of_int y) /. 400.0 -. 1.0 in let rec iloop i zr zi zr2 zi2 cr ci = if i = 0 then print_int 1 else let tr = zr2 -. zi2 +. cr in let ti = dbl zr *. zi +. ci in let zr = tr in let zi = ti in let zr2 = zr *. zr in let zi2 = zi *. zi in if fless (2.0 *. 2.0) (zr2 +. zi2) then print_int 0 else iloop (i - 1) zr zi zr2 zi2 cr ci in iloop 1000 0.0 0.0 0.0 0.0 cr ci ; (* let i = ref 1000 in let zr = ref 0.0 in let zi = ref 0.0 in let zr2 = ref 0.0 in let zi2 = ref 0.0 in while (if !i = 0 then (print_int 1; false) else let tr = !zr2 -. !zi2 +. cr in let ti = dbl !zr *. !zi +. ci in zr := tr; zi := ti; zr2 := !zr *. !zr; zi2 := !zi *. !zi; if !zr2 +. !zi2 > 2.0 *. 2.0 then (print_int 0; false) else true) do i := !i - 1 done; *) xloop (x + 1) y in xloop 0 y; yloop (y + 1)
# blt:	xloop 0 y; yloop (y + 1)
	addi	x5, x0, 0	# [92] 0
	sw	x4, 0(x2)	# [93] xloop 0 y
	addi	x30, x5, 0	# [94] xloop 0 y
	addi	x5, x4, 0	# [95] xloop 0 y
	addi	x4, x30, 0	# [96] xloop 0 y
	sw	x1, 1(x2)	# [97] xloop 0 y
	addi	x2, x2, 2	# [98] xloop 0 y
	jal	x1, -62	# [99] xloop 0 y
	addi	x2, x2, -2	# [100] xloop 0 y
	lw	x1, 1(x2)	# [101] xloop 0 y
	addi	x0, x4, 0	# [102] xloop 0 y
	lw	x4, 0(x2)	# [103] y + 1
	addi	x4, x4, 1	# [104] y + 1
	jal	x0, -15	# [105] yloop (y + 1)
# bge:	()
	jalr x0, x1, 0	# [106] ()
# entry point
	addi	x2, x0, 0 # [107]
	lui	x3, 256 # [108]
	addi	x3, x3, -1 # [109]
# program begins
	addi	x4, x0, 0	# [110] 0
	sw	x1, 0(x2)	# [111] yloop 0
	addi	x2, x2, 1	# [112] yloop 0
	jal	x1, -23	# [113] yloop 0
	addi	x2, x2, -1	# [114] yloop 0
	lw	x1, 0(x2)	# [115] yloop 0
# program ends
	hlt	# [116]
