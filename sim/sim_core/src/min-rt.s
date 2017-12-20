# jump to entry point
	auipc	x31, 2 # [0]
	jalr	x0, x31, -596 # [1]
# sgn.2907:	let rec sgn x = if fiszero x then 0.0 else if fispos x then 1.0 else -1.0
	feq	x4, f1, f0	# [2] fiszero x
	bne	x4, x0, 11	# [3] if fiszero x then 0.0 else if fispos x then 1.0 else -1.0
# beq:	if fispos x then 1.0 else -1.0
	flt	x4, f0, f1	# [4] fispos x
	bne	x4, x0, 5	# [5] if fispos x then 1.0 else -1.0
# beq:	-1.0
	lui	x31, -264192	# [6] -1.0
	addi	x31, x31, 0	# [7] -1.0
	xtof	f1, x31	# [8] -1.0
	jalr	x0, x1, 0	# [9] -1.0
# bne:	1.0
	lui	x31, 260096	# [10] 1.0
	addi	x31, x31, 0	# [11] 1.0
	xtof	f1, x31	# [12] 1.0
	jalr	x0, x1, 0	# [13] 1.0
# bne:	0.0
	addi	x31, x0, 0	# [14] 0.0
	xtof	f1, x31	# [15] 0.0
	jalr	x0, x1, 0	# [16] 0.0
# fneg_cond.2909:	let rec fneg_cond cond x = if cond then x else fneg x
	bne	x4, x0, 3	# [17] if cond then x else fneg x
# beq:	fneg x
	fneg	f1, f1	# [18] fneg x
	jalr	x0, x1, 0	# [19] fneg x
# bne:	x
	jalr	x0, x1, 0	# [20] x
# add_mod5.2912:	let rec add_mod5 x y = let sum = x + y in if sum >= 5 then sum - 5 else sum
	# let sum = x + y
	add	x4, x4, x5	# [21] x + y
	addi	x5, x0, 5	# [22] 5
	bge	x4, x5, 2	# [23] if sum >= 5 then sum - 5 else sum
# blt:	sum
	jalr	x0, x1, 0	# [24] sum
# bge:	sum - 5
	addi	x4, x4, -5	# [25] sum - 5
	jalr	x0, x1, 0	# [26] sum - 5
# vecset.2915:	let rec vecset v x y z = v.(0) <- x; v.(1) <- y; v.(2) <- z
	fsw	f1, 0(x4)	# [27] v.(0) <- x
	fsw	f2, 1(x4)	# [28] v.(1) <- y
	fsw	f3, 2(x4)	# [29] v.(2) <- z
	jalr x0, x1, 0	# [30] v.(2) <- z
# vecfill.2920:	let rec vecfill v elem = v.(0) <- elem; v.(1) <- elem; v.(2) <- elem
	fsw	f1, 0(x4)	# [31] v.(0) <- elem
	fsw	f1, 1(x4)	# [32] v.(1) <- elem
	fsw	f1, 2(x4)	# [33] v.(2) <- elem
	jalr x0, x1, 0	# [34] v.(2) <- elem
# vecbzero.2923:	let rec vecbzero v = vecfill v 0.0
	addi	x31, x0, 0	# [35] 0.0
	xtof	f1, x31	# [36] 0.0
	jal	x0, -6	# [37] vecfill v 0.0
# veccpy.2925:	let rec veccpy dest src = dest.(0) <- src.(0); dest.(1) <- src.(1); dest.(2) <- src.(2)
	flw	f1, 0(x5)	# [38] src.(0)
	fsw	f1, 0(x4)	# [39] dest.(0) <- src.(0)
	flw	f1, 1(x5)	# [40] src.(1)
	fsw	f1, 1(x4)	# [41] dest.(1) <- src.(1)
	flw	f1, 2(x5)	# [42] src.(2)
	fsw	f1, 2(x4)	# [43] dest.(2) <- src.(2)
	jalr x0, x1, 0	# [44] dest.(2) <- src.(2)
# vecunit_sgn.2933:	let rec vecunit_sgn v inv = let l = sqrt (fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2)) in let il = if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l in v.(0) <- v.(0) *. il; v.(1) <- v.(1) *. il; v.(2) <- v.(2) *. il
	flw	f1, 0(x4)	# [45] v.(0)
	fmul	f1, f1, f1	# [46] fsqr v.(0)
	flw	f2, 1(x4)	# [47] v.(1)
	fmul	f2, f2, f2	# [48] fsqr v.(1)
	fadd	f1, f1, f2	# [49] fsqr v.(0) +. fsqr v.(1)
	flw	f2, 2(x4)	# [50] v.(2)
	fmul	f2, f2, f2	# [51] fsqr v.(2)
	fadd	f1, f1, f2	# [52] fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2)
	# let l = sqrt (fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2))
	fsqrt	f1, f1	# [53] sqrt (fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2))
	feq	x6, f1, f0	# [54] fiszero l
	# let il = if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
	bne	x6, x0, 9	# [55] if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
# beq:	if inv then -1.0 /. l else 1.0 /. l
	bne	x5, x0, 3	# [56] if inv then -1.0 /. l else 1.0 /. l
# beq:	1.0 /. l
	fdiv	f1, f11, f1	# [57] 1.0 /. l
	jal	x0, 5	# [58] if inv then -1.0 /. l else 1.0 /. l
# bne:	-1.0 /. l
	lui	x31, -264192	# [59] -1.0
	addi	x31, x31, 0	# [60] -1.0
	xtof	f2, x31	# [61] -1.0
	fdiv	f1, f2, f1	# [62] -1.0 /. l
# cont:	if inv then -1.0 /. l else 1.0 /. l
	jal	x0, 4	# [63] if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
# bne:	1.0
	lui	x31, 260096	# [64] 1.0
	addi	x31, x31, 0	# [65] 1.0
	xtof	f1, x31	# [66] 1.0
# cont:	if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
	flw	f2, 0(x4)	# [67] v.(0)
	fmul	f2, f2, f1	# [68] v.(0) *. il
	fsw	f2, 0(x4)	# [69] v.(0) <- v.(0) *. il
	flw	f2, 1(x4)	# [70] v.(1)
	fmul	f2, f2, f1	# [71] v.(1) *. il
	fsw	f2, 1(x4)	# [72] v.(1) <- v.(1) *. il
	flw	f2, 2(x4)	# [73] v.(2)
	fmul	f1, f2, f1	# [74] v.(2) *. il
	fsw	f1, 2(x4)	# [75] v.(2) <- v.(2) *. il
	jalr x0, x1, 0	# [76] v.(2) <- v.(2) *. il
# veciprod.2936:	let rec veciprod v w = v.(0) *. w.(0) +. v.(1) *. w.(1) +. v.(2) *. w.(2)
	flw	f1, 0(x4)	# [77] v.(0)
	flw	f2, 0(x5)	# [78] w.(0)
	fmul	f1, f1, f2	# [79] v.(0) *. w.(0)
	flw	f2, 1(x4)	# [80] v.(1)
	flw	f3, 1(x5)	# [81] w.(1)
	fmul	f2, f2, f3	# [82] v.(1) *. w.(1)
	fadd	f1, f1, f2	# [83] v.(0) *. w.(0) +. v.(1) *. w.(1)
	flw	f2, 2(x4)	# [84] v.(2)
	flw	f3, 2(x5)	# [85] w.(2)
	fmul	f2, f2, f3	# [86] v.(2) *. w.(2)
	fadd	f1, f1, f2	# [87] v.(0) *. w.(0) +. v.(1) *. w.(1) +. v.(2) *. w.(2)
	jalr	x0, x1, 0	# [88] v.(0) *. w.(0) +. v.(1) *. w.(1) +. v.(2) *. w.(2)
# veciprod2.2939:	let rec veciprod2 v w0 w1 w2 = v.(0) *. w0 +. v.(1) *. w1 +. v.(2) *. w2
	flw	f4, 0(x4)	# [89] v.(0)
	fmul	f1, f4, f1	# [90] v.(0) *. w0
	flw	f4, 1(x4)	# [91] v.(1)
	fmul	f2, f4, f2	# [92] v.(1) *. w1
	fadd	f1, f1, f2	# [93] v.(0) *. w0 +. v.(1) *. w1
	flw	f2, 2(x4)	# [94] v.(2)
	fmul	f2, f2, f3	# [95] v.(2) *. w2
	fadd	f1, f1, f2	# [96] v.(0) *. w0 +. v.(1) *. w1 +. v.(2) *. w2
	jalr	x0, x1, 0	# [97] v.(0) *. w0 +. v.(1) *. w1 +. v.(2) *. w2
# vecaccum.2944:	let rec vecaccum dest scale v = dest.(0) <- dest.(0) +. scale *. v.(0); dest.(1) <- dest.(1) +. scale *. v.(1); dest.(2) <- dest.(2) +. scale *. v.(2)
	flw	f2, 0(x4)	# [98] dest.(0)
	flw	f3, 0(x5)	# [99] v.(0)
	fmul	f3, f1, f3	# [100] scale *. v.(0)
	fadd	f2, f2, f3	# [101] dest.(0) +. scale *. v.(0)
	fsw	f2, 0(x4)	# [102] dest.(0) <- dest.(0) +. scale *. v.(0)
	flw	f2, 1(x4)	# [103] dest.(1)
	flw	f3, 1(x5)	# [104] v.(1)
	fmul	f3, f1, f3	# [105] scale *. v.(1)
	fadd	f2, f2, f3	# [106] dest.(1) +. scale *. v.(1)
	fsw	f2, 1(x4)	# [107] dest.(1) <- dest.(1) +. scale *. v.(1)
	flw	f2, 2(x4)	# [108] dest.(2)
	flw	f3, 2(x5)	# [109] v.(2)
	fmul	f1, f1, f3	# [110] scale *. v.(2)
	fadd	f1, f2, f1	# [111] dest.(2) +. scale *. v.(2)
	fsw	f1, 2(x4)	# [112] dest.(2) <- dest.(2) +. scale *. v.(2)
	jalr x0, x1, 0	# [113] dest.(2) <- dest.(2) +. scale *. v.(2)
# vecadd.2948:	let rec vecadd dest v = dest.(0) <- dest.(0) +. v.(0); dest.(1) <- dest.(1) +. v.(1); dest.(2) <- dest.(2) +. v.(2)
	flw	f1, 0(x4)	# [114] dest.(0)
	flw	f2, 0(x5)	# [115] v.(0)
	fadd	f1, f1, f2	# [116] dest.(0) +. v.(0)
	fsw	f1, 0(x4)	# [117] dest.(0) <- dest.(0) +. v.(0)
	flw	f1, 1(x4)	# [118] dest.(1)
	flw	f2, 1(x5)	# [119] v.(1)
	fadd	f1, f1, f2	# [120] dest.(1) +. v.(1)
	fsw	f1, 1(x4)	# [121] dest.(1) <- dest.(1) +. v.(1)
	flw	f1, 2(x4)	# [122] dest.(2)
	flw	f2, 2(x5)	# [123] v.(2)
	fadd	f1, f1, f2	# [124] dest.(2) +. v.(2)
	fsw	f1, 2(x4)	# [125] dest.(2) <- dest.(2) +. v.(2)
	jalr x0, x1, 0	# [126] dest.(2) <- dest.(2) +. v.(2)
# vecscale.2954:	let rec vecscale dest scale = dest.(0) <- dest.(0) *. scale; dest.(1) <- dest.(1) *. scale; dest.(2) <- dest.(2) *. scale
	flw	f2, 0(x4)	# [127] dest.(0)
	fmul	f2, f2, f1	# [128] dest.(0) *. scale
	fsw	f2, 0(x4)	# [129] dest.(0) <- dest.(0) *. scale
	flw	f2, 1(x4)	# [130] dest.(1)
	fmul	f2, f2, f1	# [131] dest.(1) *. scale
	fsw	f2, 1(x4)	# [132] dest.(1) <- dest.(1) *. scale
	flw	f2, 2(x4)	# [133] dest.(2)
	fmul	f1, f2, f1	# [134] dest.(2) *. scale
	fsw	f1, 2(x4)	# [135] dest.(2) <- dest.(2) *. scale
	jalr x0, x1, 0	# [136] dest.(2) <- dest.(2) *. scale
# vecaccumv.2957:	let rec vecaccumv dest v w = dest.(0) <- dest.(0) +. v.(0) *. w.(0); dest.(1) <- dest.(1) +. v.(1) *. w.(1); dest.(2) <- dest.(2) +. v.(2) *. w.(2)
	flw	f1, 0(x4)	# [137] dest.(0)
	flw	f2, 0(x5)	# [138] v.(0)
	flw	f3, 0(x6)	# [139] w.(0)
	fmul	f2, f2, f3	# [140] v.(0) *. w.(0)
	fadd	f1, f1, f2	# [141] dest.(0) +. v.(0) *. w.(0)
	fsw	f1, 0(x4)	# [142] dest.(0) <- dest.(0) +. v.(0) *. w.(0)
	flw	f1, 1(x4)	# [143] dest.(1)
	flw	f2, 1(x5)	# [144] v.(1)
	flw	f3, 1(x6)	# [145] w.(1)
	fmul	f2, f2, f3	# [146] v.(1) *. w.(1)
	fadd	f1, f1, f2	# [147] dest.(1) +. v.(1) *. w.(1)
	fsw	f1, 1(x4)	# [148] dest.(1) <- dest.(1) +. v.(1) *. w.(1)
	flw	f1, 2(x4)	# [149] dest.(2)
	flw	f2, 2(x5)	# [150] v.(2)
	flw	f3, 2(x6)	# [151] w.(2)
	fmul	f2, f2, f3	# [152] v.(2) *. w.(2)
	fadd	f1, f1, f2	# [153] dest.(2) +. v.(2) *. w.(2)
	fsw	f1, 2(x4)	# [154] dest.(2) <- dest.(2) +. v.(2) *. w.(2)
	jalr x0, x1, 0	# [155] dest.(2) <- dest.(2) +. v.(2) *. w.(2)
# o_texturetype.2961:	let rec o_texturetype m = let (m_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_tex
	# let (m_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 0(x4)	# [156] let (m_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# [157] m_tex
# o_form.2963:	let rec o_form m = let (xm_tex, m_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_shape
	# let (xm_tex, m_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 1(x4)	# [158] let (xm_tex, m_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# [159] m_shape
# o_reflectiontype.2965:	let rec o_reflectiontype m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_surface
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 2(x4)	# [160] let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# [161] m_surface
# o_isinvert.2967:	let rec o_isinvert m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, m_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_invert
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, m_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 6(x4)	# [162] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, m_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# [163] m_invert
# o_isrot.2969:	let rec o_isrot m = let (xm_tex, xm_shape, xm_surface, m_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_isrot
	# let (xm_tex, xm_shape, xm_surface, m_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 3(x4)	# [164] let (xm_tex, xm_shape, xm_surface, m_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# [165] m_isrot
# o_param_a.2971:	let rec o_param_a m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# [166] let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# [167] m_abc.(0)
	jalr	x0, x1, 0	# [168] m_abc.(0)
# o_param_b.2973:	let rec o_param_b m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# [169] let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# [170] m_abc.(1)
	jalr	x0, x1, 0	# [171] m_abc.(1)
# o_param_c.2975:	let rec o_param_c m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc.(2)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# [172] let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# [173] m_abc.(2)
	jalr	x0, x1, 0	# [174] m_abc.(2)
# o_param_abc.2977:	let rec o_param_abc m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# [175] let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# [176] m_abc
# o_param_x.2979:	let rec o_param_x m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_xyz.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 5(x4)	# [177] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# [178] m_xyz.(0)
	jalr	x0, x1, 0	# [179] m_xyz.(0)
# o_param_y.2981:	let rec o_param_y m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_xyz.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 5(x4)	# [180] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# [181] m_xyz.(1)
	jalr	x0, x1, 0	# [182] m_xyz.(1)
# o_param_z.2983:	let rec o_param_z m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_xyz.(2)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 5(x4)	# [183] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# [184] m_xyz.(2)
	jalr	x0, x1, 0	# [185] m_xyz.(2)
# o_diffuse.2985:	let rec o_diffuse m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_surfparams.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 7(x4)	# [186] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# [187] m_surfparams.(0)
	jalr	x0, x1, 0	# [188] m_surfparams.(0)
# o_hilight.2987:	let rec o_hilight m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_surfparams.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 7(x4)	# [189] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# [190] m_surfparams.(1)
	jalr	x0, x1, 0	# [191] m_surfparams.(1)
# o_color_red.2989:	let rec o_color_red m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m in m_color.(0)
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	lw	x4, 8(x4)	# [192] let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# [193] m_color.(0)
	jalr	x0, x1, 0	# [194] m_color.(0)
# o_color_green.2991:	let rec o_color_green m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m in m_color.(1)
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	lw	x4, 8(x4)	# [195] let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# [196] m_color.(1)
	jalr	x0, x1, 0	# [197] m_color.(1)
# o_color_blue.2993:	let rec o_color_blue m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m in m_color.(2)
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	lw	x4, 8(x4)	# [198] let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# [199] m_color.(2)
	jalr	x0, x1, 0	# [200] m_color.(2)
# o_param_r1.2995:	let rec o_param_r1 m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m in m_rot123.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	lw	x4, 9(x4)	# [201] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# [202] m_rot123.(0)
	jalr	x0, x1, 0	# [203] m_rot123.(0)
# o_param_r2.2997:	let rec o_param_r2 m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m in m_rot123.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	lw	x4, 9(x4)	# [204] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# [205] m_rot123.(1)
	jalr	x0, x1, 0	# [206] m_rot123.(1)
# o_param_r3.2999:	let rec o_param_r3 m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m in m_rot123.(2)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	lw	x4, 9(x4)	# [207] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# [208] m_rot123.(2)
	jalr	x0, x1, 0	# [209] m_rot123.(2)
# o_param_ctbl.3001:	let rec o_param_ctbl m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, m_ctbl) = m in m_ctbl
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, m_ctbl) = m
	lw	x4, 10(x4)	# [210] let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, m_ctbl) = m
	jalr	x0, x1, 0	# [211] m_ctbl
# p_rgb.3003:	let rec p_rgb pixel = let (m_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_rgb
	# let (m_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 0(x4)	# [212] let (m_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# [213] m_rgb
# p_intersection_points.3005:	let rec p_intersection_points pixel = let (xm_rgb, m_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_isect_ps
	# let (xm_rgb, m_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 1(x4)	# [214] let (xm_rgb, m_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# [215] m_isect_ps
# p_surface_ids.3007:	let rec p_surface_ids pixel = let (xm_rgb, xm_isect_ps, m_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_sids
	# let (xm_rgb, xm_isect_ps, m_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 2(x4)	# [216] let (xm_rgb, xm_isect_ps, m_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# [217] m_sids
# p_calc_diffuse.3009:	let rec p_calc_diffuse pixel = let (xm_rgb, xm_isect_ps, xm_sids, m_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_cdif
	# let (xm_rgb, xm_isect_ps, xm_sids, m_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 3(x4)	# [218] let (xm_rgb, xm_isect_ps, xm_sids, m_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# [219] m_cdif
# p_energy.3011:	let rec p_energy pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, m_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_engy
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, m_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 4(x4)	# [220] let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, m_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# [221] m_engy
# p_received_ray_20percent.3013:	let rec p_received_ray_20percent pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, m_r20p, xm_gid, xm_nvectors ) = pixel in m_r20p
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, m_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 5(x4)	# [222] let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, m_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# [223] m_r20p
# p_group_id.3015:	let rec p_group_id pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel in m_gid.(0)
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	lw	x4, 6(x4)	# [224] let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	lw	x4, 0(x4)	# [225] m_gid.(0)
	jalr	x0, x1, 0	# [226] m_gid.(0)
# p_set_group_id.3017:	let rec p_set_group_id pixel id = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel in m_gid.(0) <- id
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	lw	x4, 6(x4)	# [227] let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	sw	x5, 0(x4)	# [228] m_gid.(0) <- id
	jalr x0, x1, 0	# [229] m_gid.(0) <- id
# p_nvectors.3020:	let rec p_nvectors pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, m_nvectors ) = pixel in m_nvectors
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, m_nvectors ) = pixel
	lw	x4, 7(x4)	# [230] let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, m_nvectors ) = pixel
	jalr	x0, x1, 0	# [231] m_nvectors
# d_vec.3022:	let rec d_vec d = let (m_vec, xm_const) = d in m_vec
	# let (m_vec, xm_const) = d
	lw	x4, 0(x4)	# [232] let (m_vec, xm_const) = d
	jalr	x0, x1, 0	# [233] m_vec
# d_const.3024:	let rec d_const d = let (dm_vec, m_const) = d in m_const
	# let (dm_vec, m_const) = d
	lw	x4, 1(x4)	# [234] let (dm_vec, m_const) = d
	jalr	x0, x1, 0	# [235] m_const
# r_surface_id.3026:	let rec r_surface_id r = let (m_sid, xm_dvec, xm_br) = r in m_sid
	# let (m_sid, xm_dvec, xm_br) = r
	lw	x4, 0(x4)	# [236] let (m_sid, xm_dvec, xm_br) = r
	jalr	x0, x1, 0	# [237] m_sid
# r_dvec.3028:	let rec r_dvec r = let (xm_sid, m_dvec, xm_br) = r in m_dvec
	# let (xm_sid, m_dvec, xm_br) = r
	lw	x4, 1(x4)	# [238] let (xm_sid, m_dvec, xm_br) = r
	jalr	x0, x1, 0	# [239] m_dvec
# r_bright.3030:	let rec r_bright r = let (xm_sid, xm_dvec, m_br) = r in m_br
	# let (xm_sid, xm_dvec, m_br) = r
	flw	f1, 2(x4)	# [240] let (xm_sid, xm_dvec, m_br) = r
	jalr	x0, x1, 0	# [241] m_br
# rad.3032:	let rec rad x = x *. 0.017453293
	lui	x31, 248047	# [242] 0.017453293
	addi	x31, x31, -1483	# [243] 0.017453293
	xtof	f2, x31	# [244] 0.017453293
	fmul	f1, f1, f2	# [245] x *. 0.017453293
	jalr	x0, x1, 0	# [246] x *. 0.017453293
# read_screen_settings.3034:	let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lui	x4, 256	# [247] screen
	addi	x4, x4, 63	# [248] screen
	ib	x30	# [249] read_float ()
	slli	x30, x30, 8	# [250] read_float ()
	ib	x31	# [251] read_float ()
	or	x30, x30, x31	# [252] read_float ()
	slli	x30, x30, 8	# [253] read_float ()
	ib	x31	# [254] read_float ()
	or	x30, x30, x31	# [255] read_float ()
	slli	x30, x30, 8	# [256] read_float ()
	ib	x31	# [257] read_float ()
	or	x30, x30, x31	# [258] read_float ()
	xtof	f1, x30	# [259] read_float ()
	fsw	f1, 0(x4)	# [260] screen.(0) <- read_float ()
	lui	x4, 256	# [261] screen
	addi	x4, x4, 63	# [262] screen
	ib	x30	# [263] read_float ()
	slli	x30, x30, 8	# [264] read_float ()
	ib	x31	# [265] read_float ()
	or	x30, x30, x31	# [266] read_float ()
	slli	x30, x30, 8	# [267] read_float ()
	ib	x31	# [268] read_float ()
	or	x30, x30, x31	# [269] read_float ()
	slli	x30, x30, 8	# [270] read_float ()
	ib	x31	# [271] read_float ()
	or	x30, x30, x31	# [272] read_float ()
	xtof	f1, x30	# [273] read_float ()
	fsw	f1, 1(x4)	# [274] screen.(1) <- read_float ()
	lui	x4, 256	# [275] screen
	addi	x4, x4, 63	# [276] screen
	ib	x30	# [277] read_float ()
	slli	x30, x30, 8	# [278] read_float ()
	ib	x31	# [279] read_float ()
	or	x30, x30, x31	# [280] read_float ()
	slli	x30, x30, 8	# [281] read_float ()
	ib	x31	# [282] read_float ()
	or	x30, x30, x31	# [283] read_float ()
	slli	x30, x30, 8	# [284] read_float ()
	ib	x31	# [285] read_float ()
	or	x30, x30, x31	# [286] read_float ()
	xtof	f1, x30	# [287] read_float ()
	fsw	f1, 2(x4)	# [288] screen.(2) <- read_float ()
	ib	x30	# [289] read_float ()
	slli	x30, x30, 8	# [290] read_float ()
	ib	x31	# [291] read_float ()
	or	x30, x30, x31	# [292] read_float ()
	slli	x30, x30, 8	# [293] read_float ()
	ib	x31	# [294] read_float ()
	or	x30, x30, x31	# [295] read_float ()
	slli	x30, x30, 8	# [296] read_float ()
	ib	x31	# [297] read_float ()
	or	x30, x30, x31	# [298] read_float ()
	xtof	f1, x30	# [299] read_float ()
	# let v1 = rad (read_float ())
	sw	x1, 0(x2)	# [300] rad (read_float ())
	addi	x2, x2, 1	# [301] rad (read_float ())
	jal	x1, -60	# [302] rad (read_float ())
	addi	x2, x2, -1	# [303] rad (read_float ())
	lw	x1, 0(x2)	# [304] rad (read_float ())
	fmul	f2, f1, f1	# [305]
	fmul	f3, f2, f27	# [306]
	fmul	f4, f3, f2	# [307]
	lui	x31, 252586	# [308]
	addi	x31, x31, -1365	# [309]
	xtof	f5, x31	# [310]
	fmul	f4, f4, f5	# [311]
	fmul	f5, f4, f2	# [312]
	lui	x31, 249992	# [313]
	addi	x31, x31, -1911	# [314]
	xtof	f6, x31	# [315]
	fmul	f5, f5, f6	# [316]
	fmul	f6, f5, f2	# [317]
	lui	x31, 248100	# [318]
	addi	x31, x31, -1755	# [319]
	xtof	f7, x31	# [320]
	fmul	f6, f6, f7	# [321]
	fmul	f2, f6, f2	# [322]
	lui	x31, 246624	# [323]
	addi	x31, x31, -1183	# [324]
	xtof	f7, x31	# [325]
	fmul	f2, f2, f7	# [326]
	fsub	f3, f11, f3	# [327]
	fadd	f3, f3, f4	# [328]
	fsub	f3, f3, f5	# [329]
	fadd	f3, f3, f6	# [330]
	# let cos_v1 = cos v1
	fsub	f2, f3, f2	# [331]
	lui	x31, 256559	# [332]
	addi	x31, x31, -1661	# [333]
	xtof	f3, x31	# [334]
	fmul	f3, f1, f3	# [335]
	ftoi	x4, f3	# [336]
	andi	x5, x4, 1	# [337]
	itof	f3, x5	# [338]
	fmul	f3, f3, f12	# [339]
	fsub	f3, f11, f3	# [340]
	itof	f4, x4	# [341]
	fmul	f4, f4, f28	# [342]
	fsub	f1, f1, f4	# [343]
	lui	x31, 261264	# [344]
	addi	x31, x31, -37	# [345]
	xtof	f4, x31	# [346]
	fsub	f1, f1, f4	# [347]
	fmul	f1, f1, f1	# [348]
	fmul	f4, f1, f27	# [349]
	fmul	f5, f4, f1	# [350]
	lui	x31, 252586	# [351]
	addi	x31, x31, -1365	# [352]
	xtof	f6, x31	# [353]
	fmul	f5, f5, f6	# [354]
	fmul	f6, f5, f1	# [355]
	lui	x31, 249992	# [356]
	addi	x31, x31, -1911	# [357]
	xtof	f7, x31	# [358]
	fmul	f6, f6, f7	# [359]
	fmul	f7, f6, f1	# [360]
	lui	x31, 248100	# [361]
	addi	x31, x31, -1755	# [362]
	xtof	f8, x31	# [363]
	fmul	f7, f7, f8	# [364]
	fmul	f1, f7, f1	# [365]
	lui	x31, 246624	# [366]
	addi	x31, x31, -1183	# [367]
	xtof	f8, x31	# [368]
	fmul	f1, f1, f8	# [369]
	fsub	f4, f11, f4	# [370]
	fadd	f4, f4, f5	# [371]
	fsub	f4, f4, f6	# [372]
	fadd	f4, f4, f7	# [373]
	fsub	f1, f4, f1	# [374]
	# let sin_v1 = sin v1
	fmul	f1, f3, f1	# [375]
	ib	x30	# [376] read_float ()
	slli	x30, x30, 8	# [377] read_float ()
	ib	x31	# [378] read_float ()
	or	x30, x30, x31	# [379] read_float ()
	slli	x30, x30, 8	# [380] read_float ()
	ib	x31	# [381] read_float ()
	or	x30, x30, x31	# [382] read_float ()
	slli	x30, x30, 8	# [383] read_float ()
	ib	x31	# [384] read_float ()
	or	x30, x30, x31	# [385] read_float ()
	xtof	f3, x30	# [386] read_float ()
	fsw	f1, 0(x2)	# [387] rad (read_float ())
	fsw	f2, 1(x2)	# [388] rad (read_float ())
	# let v2 = rad (read_float ())
	fmv	f1, f3	# [389] rad (read_float ())
	sw	x1, 2(x2)	# [390] rad (read_float ())
	addi	x2, x2, 3	# [391] rad (read_float ())
	jal	x1, -150	# [392] rad (read_float ())
	addi	x2, x2, -3	# [393] rad (read_float ())
	lw	x1, 2(x2)	# [394] rad (read_float ())
	fmul	f2, f1, f1	# [395]
	fmul	f3, f2, f27	# [396]
	fmul	f4, f3, f2	# [397]
	lui	x31, 252586	# [398]
	addi	x31, x31, -1365	# [399]
	xtof	f5, x31	# [400]
	fmul	f4, f4, f5	# [401]
	fmul	f5, f4, f2	# [402]
	lui	x31, 249992	# [403]
	addi	x31, x31, -1911	# [404]
	xtof	f6, x31	# [405]
	fmul	f5, f5, f6	# [406]
	fmul	f6, f5, f2	# [407]
	lui	x31, 248100	# [408]
	addi	x31, x31, -1755	# [409]
	xtof	f7, x31	# [410]
	fmul	f6, f6, f7	# [411]
	fmul	f2, f6, f2	# [412]
	lui	x31, 246624	# [413]
	addi	x31, x31, -1183	# [414]
	xtof	f7, x31	# [415]
	fmul	f2, f2, f7	# [416]
	fsub	f3, f11, f3	# [417]
	fadd	f3, f3, f4	# [418]
	fsub	f3, f3, f5	# [419]
	fadd	f3, f3, f6	# [420]
	# let cos_v2 = cos v2
	fsub	f2, f3, f2	# [421]
	lui	x31, 256559	# [422]
	addi	x31, x31, -1661	# [423]
	xtof	f3, x31	# [424]
	fmul	f3, f1, f3	# [425]
	ftoi	x4, f3	# [426]
	andi	x5, x4, 1	# [427]
	itof	f3, x5	# [428]
	fmul	f3, f3, f12	# [429]
	fsub	f3, f11, f3	# [430]
	itof	f4, x4	# [431]
	fmul	f4, f4, f28	# [432]
	fsub	f1, f1, f4	# [433]
	lui	x31, 261264	# [434]
	addi	x31, x31, -37	# [435]
	xtof	f4, x31	# [436]
	fsub	f1, f1, f4	# [437]
	fmul	f1, f1, f1	# [438]
	fmul	f4, f1, f27	# [439]
	fmul	f5, f4, f1	# [440]
	lui	x31, 252586	# [441]
	addi	x31, x31, -1365	# [442]
	xtof	f6, x31	# [443]
	fmul	f5, f5, f6	# [444]
	fmul	f6, f5, f1	# [445]
	lui	x31, 249992	# [446]
	addi	x31, x31, -1911	# [447]
	xtof	f7, x31	# [448]
	fmul	f6, f6, f7	# [449]
	fmul	f7, f6, f1	# [450]
	lui	x31, 248100	# [451]
	addi	x31, x31, -1755	# [452]
	xtof	f8, x31	# [453]
	fmul	f7, f7, f8	# [454]
	fmul	f1, f7, f1	# [455]
	lui	x31, 246624	# [456]
	addi	x31, x31, -1183	# [457]
	xtof	f8, x31	# [458]
	fmul	f1, f1, f8	# [459]
	fsub	f4, f11, f4	# [460]
	fadd	f4, f4, f5	# [461]
	fsub	f4, f4, f6	# [462]
	fadd	f4, f4, f7	# [463]
	fsub	f1, f4, f1	# [464]
	# let sin_v2 = sin v2
	fmul	f1, f3, f1	# [465]
	lui	x4, 256	# [466] screenz_dir
	addi	x4, x4, 160	# [467] screenz_dir
	flw	f3, 1(x2)	# [468] cos_v1 *. sin_v2
	fmul	f4, f3, f1	# [469] cos_v1 *. sin_v2
	fmul	f4, f4, f18	# [470] cos_v1 *. sin_v2 *. 200.0
	fsw	f4, 0(x4)	# [471] screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0
	lui	x4, 256	# [472] screenz_dir
	addi	x4, x4, 160	# [473] screenz_dir
	lui	x31, -248704	# [474] -200.0
	addi	x31, x31, 0	# [475] -200.0
	xtof	f4, x31	# [476] -200.0
	flw	f5, 0(x2)	# [477] sin_v1 *. -200.0
	fmul	f4, f5, f4	# [478] sin_v1 *. -200.0
	fsw	f4, 1(x4)	# [479] screenz_dir.(1) <- sin_v1 *. -200.0
	lui	x4, 256	# [480] screenz_dir
	addi	x4, x4, 160	# [481] screenz_dir
	fmul	f4, f3, f2	# [482] cos_v1 *. cos_v2
	fmul	f4, f4, f18	# [483] cos_v1 *. cos_v2 *. 200.0
	fsw	f4, 2(x4)	# [484] screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0
	lui	x4, 256	# [485] screenx_dir
	addi	x4, x4, 154	# [486] screenx_dir
	fsw	f2, 0(x4)	# [487] screenx_dir.(0) <- cos_v2
	lui	x4, 256	# [488] screenx_dir
	addi	x4, x4, 154	# [489] screenx_dir
	addi	x31, x0, 0	# [490] 0.0
	xtof	f4, x31	# [491] 0.0
	fsw	f4, 1(x4)	# [492] screenx_dir.(1) <- 0.0
	lui	x4, 256	# [493] screenx_dir
	addi	x4, x4, 154	# [494] screenx_dir
	fneg	f4, f1	# [495] fneg sin_v2
	fsw	f4, 2(x4)	# [496] screenx_dir.(2) <- fneg sin_v2
	lui	x4, 256	# [497] screeny_dir
	addi	x4, x4, 157	# [498] screeny_dir
	fneg	f4, f5	# [499] fneg sin_v1
	fmul	f1, f4, f1	# [500] fneg sin_v1 *. sin_v2
	fsw	f1, 0(x4)	# [501] screeny_dir.(0) <- fneg sin_v1 *. sin_v2
	lui	x4, 256	# [502] screeny_dir
	addi	x4, x4, 157	# [503] screeny_dir
	fneg	f1, f3	# [504] fneg cos_v1
	fsw	f1, 1(x4)	# [505] screeny_dir.(1) <- fneg cos_v1
	lui	x4, 256	# [506] screeny_dir
	addi	x4, x4, 157	# [507] screeny_dir
	fneg	f1, f5	# [508] fneg sin_v1
	fmul	f1, f1, f2	# [509] fneg sin_v1 *. cos_v2
	fsw	f1, 2(x4)	# [510] screeny_dir.(2) <- fneg sin_v1 *. cos_v2
	lui	x4, 256	# [511] viewpoint
	addi	x4, x4, 66	# [512] viewpoint
	lui	x5, 256	# [513] screen
	addi	x5, x5, 63	# [514] screen
	flw	f1, 0(x5)	# [515] screen.(0)
	lui	x5, 256	# [516] screenz_dir
	addi	x5, x5, 160	# [517] screenz_dir
	flw	f2, 0(x5)	# [518] screenz_dir.(0)
	fsub	f1, f1, f2	# [519] screen.(0) -. screenz_dir.(0)
	fsw	f1, 0(x4)	# [520] viewpoint.(0) <- screen.(0) -. screenz_dir.(0)
	lui	x4, 256	# [521] viewpoint
	addi	x4, x4, 66	# [522] viewpoint
	lui	x5, 256	# [523] screen
	addi	x5, x5, 63	# [524] screen
	flw	f1, 1(x5)	# [525] screen.(1)
	lui	x5, 256	# [526] screenz_dir
	addi	x5, x5, 160	# [527] screenz_dir
	flw	f2, 1(x5)	# [528] screenz_dir.(1)
	fsub	f1, f1, f2	# [529] screen.(1) -. screenz_dir.(1)
	fsw	f1, 1(x4)	# [530] viewpoint.(1) <- screen.(1) -. screenz_dir.(1)
	lui	x4, 256	# [531] viewpoint
	addi	x4, x4, 66	# [532] viewpoint
	lui	x5, 256	# [533] screen
	addi	x5, x5, 63	# [534] screen
	flw	f1, 2(x5)	# [535] screen.(2)
	lui	x5, 256	# [536] screenz_dir
	addi	x5, x5, 160	# [537] screenz_dir
	flw	f2, 2(x5)	# [538] screenz_dir.(2)
	fsub	f1, f1, f2	# [539] screen.(2) -. screenz_dir.(2)
	fsw	f1, 2(x4)	# [540] viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	jalr x0, x1, 0	# [541] viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
# read_light.3036:	let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	# let nl = read_int ()
	ib	x4	# [542] read_int ()
	slli	x4, x4, 8	# [543] read_int ()
	ib	x31	# [544] read_int ()
	or	x4, x4, x31	# [545] read_int ()
	slli	x4, x4, 8	# [546] read_int ()
	ib	x31	# [547] read_int ()
	or	x4, x4, x31	# [548] read_int ()
	slli	x4, x4, 8	# [549] read_int ()
	ib	x31	# [550] read_int ()
	or	x4, x4, x31	# [551] read_int ()
	ib	x30	# [552] read_float ()
	slli	x30, x30, 8	# [553] read_float ()
	ib	x31	# [554] read_float ()
	or	x30, x30, x31	# [555] read_float ()
	slli	x30, x30, 8	# [556] read_float ()
	ib	x31	# [557] read_float ()
	or	x30, x30, x31	# [558] read_float ()
	slli	x30, x30, 8	# [559] read_float ()
	ib	x31	# [560] read_float ()
	or	x30, x30, x31	# [561] read_float ()
	xtof	f1, x30	# [562] read_float ()
	# let l1 = rad (read_float ())
	sw	x1, 0(x2)	# [563] rad (read_float ())
	addi	x2, x2, 1	# [564] rad (read_float ())
	jal	x1, -323	# [565] rad (read_float ())
	addi	x2, x2, -1	# [566] rad (read_float ())
	lw	x1, 0(x2)	# [567] rad (read_float ())
	lui	x31, 256559	# [568]
	addi	x31, x31, -1661	# [569]
	xtof	f2, x31	# [570]
	fmul	f2, f1, f2	# [571]
	ftoi	x4, f2	# [572]
	andi	x5, x4, 1	# [573]
	itof	f2, x5	# [574]
	fmul	f2, f2, f12	# [575]
	fsub	f2, f11, f2	# [576]
	itof	f3, x4	# [577]
	fmul	f3, f3, f28	# [578]
	fsub	f3, f1, f3	# [579]
	lui	x31, 261264	# [580]
	addi	x31, x31, -37	# [581]
	xtof	f4, x31	# [582]
	fsub	f3, f3, f4	# [583]
	fmul	f3, f3, f3	# [584]
	fmul	f4, f3, f27	# [585]
	fmul	f5, f4, f3	# [586]
	lui	x31, 252586	# [587]
	addi	x31, x31, -1365	# [588]
	xtof	f6, x31	# [589]
	fmul	f5, f5, f6	# [590]
	fmul	f6, f5, f3	# [591]
	lui	x31, 249992	# [592]
	addi	x31, x31, -1911	# [593]
	xtof	f7, x31	# [594]
	fmul	f6, f6, f7	# [595]
	fmul	f7, f6, f3	# [596]
	lui	x31, 248100	# [597]
	addi	x31, x31, -1755	# [598]
	xtof	f8, x31	# [599]
	fmul	f7, f7, f8	# [600]
	fmul	f3, f7, f3	# [601]
	lui	x31, 246624	# [602]
	addi	x31, x31, -1183	# [603]
	xtof	f8, x31	# [604]
	fmul	f3, f3, f8	# [605]
	fsub	f4, f11, f4	# [606]
	fadd	f4, f4, f5	# [607]
	fsub	f4, f4, f6	# [608]
	fadd	f4, f4, f7	# [609]
	fsub	f3, f4, f3	# [610]
	# let sl1 = sin l1
	fmul	f2, f2, f3	# [611]
	lui	x4, 256	# [612] light
	addi	x4, x4, 69	# [613] light
	fneg	f2, f2	# [614] fneg sl1
	fsw	f2, 1(x4)	# [615] light.(1) <- fneg sl1
	ib	x30	# [616] read_float ()
	slli	x30, x30, 8	# [617] read_float ()
	ib	x31	# [618] read_float ()
	or	x30, x30, x31	# [619] read_float ()
	slli	x30, x30, 8	# [620] read_float ()
	ib	x31	# [621] read_float ()
	or	x30, x30, x31	# [622] read_float ()
	slli	x30, x30, 8	# [623] read_float ()
	ib	x31	# [624] read_float ()
	or	x30, x30, x31	# [625] read_float ()
	xtof	f2, x30	# [626] read_float ()
	fsw	f1, 0(x2)	# [627] rad (read_float ())
	# let l2 = rad (read_float ())
	fmv	f1, f2	# [628] rad (read_float ())
	sw	x1, 1(x2)	# [629] rad (read_float ())
	addi	x2, x2, 2	# [630] rad (read_float ())
	jal	x1, -389	# [631] rad (read_float ())
	addi	x2, x2, -2	# [632] rad (read_float ())
	lw	x1, 1(x2)	# [633] rad (read_float ())
	flw	f2, 0(x2)	# [634]
	fmul	f2, f2, f2	# [635]
	fmul	f3, f2, f27	# [636]
	fmul	f4, f3, f2	# [637]
	lui	x31, 252586	# [638]
	addi	x31, x31, -1365	# [639]
	xtof	f5, x31	# [640]
	fmul	f4, f4, f5	# [641]
	fmul	f5, f4, f2	# [642]
	lui	x31, 249992	# [643]
	addi	x31, x31, -1911	# [644]
	xtof	f6, x31	# [645]
	fmul	f5, f5, f6	# [646]
	fmul	f6, f5, f2	# [647]
	lui	x31, 248100	# [648]
	addi	x31, x31, -1755	# [649]
	xtof	f7, x31	# [650]
	fmul	f6, f6, f7	# [651]
	fmul	f2, f6, f2	# [652]
	lui	x31, 246624	# [653]
	addi	x31, x31, -1183	# [654]
	xtof	f7, x31	# [655]
	fmul	f2, f2, f7	# [656]
	fsub	f3, f11, f3	# [657]
	fadd	f3, f3, f4	# [658]
	fsub	f3, f3, f5	# [659]
	fadd	f3, f3, f6	# [660]
	# let cl1 = cos l1
	fsub	f2, f3, f2	# [661]
	lui	x31, 256559	# [662]
	addi	x31, x31, -1661	# [663]
	xtof	f3, x31	# [664]
	fmul	f3, f1, f3	# [665]
	ftoi	x4, f3	# [666]
	andi	x5, x4, 1	# [667]
	itof	f3, x5	# [668]
	fmul	f3, f3, f12	# [669]
	fsub	f3, f11, f3	# [670]
	itof	f4, x4	# [671]
	fmul	f4, f4, f28	# [672]
	fsub	f4, f1, f4	# [673]
	lui	x31, 261264	# [674]
	addi	x31, x31, -37	# [675]
	xtof	f5, x31	# [676]
	fsub	f4, f4, f5	# [677]
	fmul	f4, f4, f4	# [678]
	fmul	f5, f4, f27	# [679]
	fmul	f6, f5, f4	# [680]
	lui	x31, 252586	# [681]
	addi	x31, x31, -1365	# [682]
	xtof	f7, x31	# [683]
	fmul	f6, f6, f7	# [684]
	fmul	f7, f6, f4	# [685]
	lui	x31, 249992	# [686]
	addi	x31, x31, -1911	# [687]
	xtof	f8, x31	# [688]
	fmul	f7, f7, f8	# [689]
	fmul	f8, f7, f4	# [690]
	lui	x31, 248100	# [691]
	addi	x31, x31, -1755	# [692]
	xtof	f9, x31	# [693]
	fmul	f8, f8, f9	# [694]
	fmul	f4, f8, f4	# [695]
	lui	x31, 246624	# [696]
	addi	x31, x31, -1183	# [697]
	xtof	f9, x31	# [698]
	fmul	f4, f4, f9	# [699]
	fsub	f5, f11, f5	# [700]
	fadd	f5, f5, f6	# [701]
	fsub	f5, f5, f7	# [702]
	fadd	f5, f5, f8	# [703]
	fsub	f4, f5, f4	# [704]
	# let sl2 = sin l2
	fmul	f3, f3, f4	# [705]
	lui	x4, 256	# [706] light
	addi	x4, x4, 69	# [707] light
	fmul	f3, f2, f3	# [708] cl1 *. sl2
	fsw	f3, 0(x4)	# [709] light.(0) <- cl1 *. sl2
	fmul	f1, f1, f1	# [710]
	fmul	f3, f1, f27	# [711]
	fmul	f4, f3, f1	# [712]
	lui	x31, 252586	# [713]
	addi	x31, x31, -1365	# [714]
	xtof	f5, x31	# [715]
	fmul	f4, f4, f5	# [716]
	fmul	f5, f4, f1	# [717]
	lui	x31, 249992	# [718]
	addi	x31, x31, -1911	# [719]
	xtof	f6, x31	# [720]
	fmul	f5, f5, f6	# [721]
	fmul	f6, f5, f1	# [722]
	lui	x31, 248100	# [723]
	addi	x31, x31, -1755	# [724]
	xtof	f7, x31	# [725]
	fmul	f6, f6, f7	# [726]
	fmul	f1, f6, f1	# [727]
	lui	x31, 246624	# [728]
	addi	x31, x31, -1183	# [729]
	xtof	f7, x31	# [730]
	fmul	f1, f1, f7	# [731]
	fsub	f3, f11, f3	# [732]
	fadd	f3, f3, f4	# [733]
	fsub	f3, f3, f5	# [734]
	fadd	f3, f3, f6	# [735]
	# let cl2 = cos l2
	fsub	f1, f3, f1	# [736]
	lui	x4, 256	# [737] light
	addi	x4, x4, 69	# [738] light
	fmul	f1, f2, f1	# [739] cl1 *. cl2
	fsw	f1, 2(x4)	# [740] light.(2) <- cl1 *. cl2
	lui	x4, 256	# [741] beam
	addi	x4, x4, 70	# [742] beam
	ib	x30	# [743] read_float ()
	slli	x30, x30, 8	# [744] read_float ()
	ib	x31	# [745] read_float ()
	or	x30, x30, x31	# [746] read_float ()
	slli	x30, x30, 8	# [747] read_float ()
	ib	x31	# [748] read_float ()
	or	x30, x30, x31	# [749] read_float ()
	slli	x30, x30, 8	# [750] read_float ()
	ib	x31	# [751] read_float ()
	or	x30, x30, x31	# [752] read_float ()
	xtof	f1, x30	# [753] read_float ()
	fsw	f1, 0(x4)	# [754] beam.(0) <- read_float ()
	jalr x0, x1, 0	# [755] beam.(0) <- read_float ()
# rotate_quadratic_matrix.3038:	let rec rotate_quadratic_matrix abc rot = let cos_x = cos rot.(0) in let sin_x = sin rot.(0) in let cos_y = cos rot.(1) in let sin_y = sin rot.(1) in let cos_z = cos rot.(2) in let sin_z = sin rot.(2) in let m00 = cos_y *. cos_z in let m01 = sin_x *. sin_y *. cos_z -. cos_x *. sin_z in let m02 = cos_x *. sin_y *. cos_z +. sin_x *. sin_z in let m10 = cos_y *. sin_z in let m11 = sin_x *. sin_y *. sin_z +. cos_x *. cos_z in let m12 = cos_x *. sin_y *. sin_z -. sin_x *. cos_z in let m20 = fneg sin_y in let m21 = sin_x *. cos_y in let m22 = cos_x *. cos_y in let ao = abc.(0) in let bo = abc.(1) in let co = abc.(2) in abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	flw	f1, 0(x5)	# [756] rot.(0)
	fmul	f1, f1, f1	# [757]
	fmul	f2, f1, f27	# [758]
	fmul	f3, f2, f1	# [759]
	lui	x31, 252586	# [760]
	addi	x31, x31, -1365	# [761]
	xtof	f4, x31	# [762]
	fmul	f3, f3, f4	# [763]
	fmul	f4, f3, f1	# [764]
	lui	x31, 249992	# [765]
	addi	x31, x31, -1911	# [766]
	xtof	f5, x31	# [767]
	fmul	f4, f4, f5	# [768]
	fmul	f5, f4, f1	# [769]
	lui	x31, 248100	# [770]
	addi	x31, x31, -1755	# [771]
	xtof	f6, x31	# [772]
	fmul	f5, f5, f6	# [773]
	fmul	f1, f5, f1	# [774]
	lui	x31, 246624	# [775]
	addi	x31, x31, -1183	# [776]
	xtof	f6, x31	# [777]
	fmul	f1, f1, f6	# [778]
	fsub	f2, f11, f2	# [779]
	fadd	f2, f2, f3	# [780]
	fsub	f2, f2, f4	# [781]
	fadd	f2, f2, f5	# [782]
	# let cos_x = cos rot.(0)
	fsub	f1, f2, f1	# [783]
	flw	f2, 0(x5)	# [784] rot.(0)
	lui	x31, 256559	# [785]
	addi	x31, x31, -1661	# [786]
	xtof	f3, x31	# [787]
	fmul	f3, f2, f3	# [788]
	ftoi	x6, f3	# [789]
	andi	x7, x6, 1	# [790]
	itof	f3, x7	# [791]
	fmul	f3, f3, f12	# [792]
	fsub	f3, f11, f3	# [793]
	itof	f4, x6	# [794]
	fmul	f4, f4, f28	# [795]
	fsub	f2, f2, f4	# [796]
	lui	x31, 261264	# [797]
	addi	x31, x31, -37	# [798]
	xtof	f4, x31	# [799]
	fsub	f2, f2, f4	# [800]
	fmul	f2, f2, f2	# [801]
	fmul	f4, f2, f27	# [802]
	fmul	f5, f4, f2	# [803]
	lui	x31, 252586	# [804]
	addi	x31, x31, -1365	# [805]
	xtof	f6, x31	# [806]
	fmul	f5, f5, f6	# [807]
	fmul	f6, f5, f2	# [808]
	lui	x31, 249992	# [809]
	addi	x31, x31, -1911	# [810]
	xtof	f7, x31	# [811]
	fmul	f6, f6, f7	# [812]
	fmul	f7, f6, f2	# [813]
	lui	x31, 248100	# [814]
	addi	x31, x31, -1755	# [815]
	xtof	f8, x31	# [816]
	fmul	f7, f7, f8	# [817]
	fmul	f2, f7, f2	# [818]
	lui	x31, 246624	# [819]
	addi	x31, x31, -1183	# [820]
	xtof	f8, x31	# [821]
	fmul	f2, f2, f8	# [822]
	fsub	f4, f11, f4	# [823]
	fadd	f4, f4, f5	# [824]
	fsub	f4, f4, f6	# [825]
	fadd	f4, f4, f7	# [826]
	fsub	f2, f4, f2	# [827]
	# let sin_x = sin rot.(0)
	fmul	f2, f3, f2	# [828]
	flw	f3, 1(x5)	# [829] rot.(1)
	fmul	f3, f3, f3	# [830]
	fmul	f4, f3, f27	# [831]
	fmul	f5, f4, f3	# [832]
	lui	x31, 252586	# [833]
	addi	x31, x31, -1365	# [834]
	xtof	f6, x31	# [835]
	fmul	f5, f5, f6	# [836]
	fmul	f6, f5, f3	# [837]
	lui	x31, 249992	# [838]
	addi	x31, x31, -1911	# [839]
	xtof	f7, x31	# [840]
	fmul	f6, f6, f7	# [841]
	fmul	f7, f6, f3	# [842]
	lui	x31, 248100	# [843]
	addi	x31, x31, -1755	# [844]
	xtof	f8, x31	# [845]
	fmul	f7, f7, f8	# [846]
	fmul	f3, f7, f3	# [847]
	lui	x31, 246624	# [848]
	addi	x31, x31, -1183	# [849]
	xtof	f8, x31	# [850]
	fmul	f3, f3, f8	# [851]
	fsub	f4, f11, f4	# [852]
	fadd	f4, f4, f5	# [853]
	fsub	f4, f4, f6	# [854]
	fadd	f4, f4, f7	# [855]
	# let cos_y = cos rot.(1)
	fsub	f3, f4, f3	# [856]
	flw	f4, 1(x5)	# [857] rot.(1)
	lui	x31, 256559	# [858]
	addi	x31, x31, -1661	# [859]
	xtof	f5, x31	# [860]
	fmul	f5, f4, f5	# [861]
	ftoi	x6, f5	# [862]
	andi	x7, x6, 1	# [863]
	itof	f5, x7	# [864]
	fmul	f5, f5, f12	# [865]
	fsub	f5, f11, f5	# [866]
	itof	f6, x6	# [867]
	fmul	f6, f6, f28	# [868]
	fsub	f4, f4, f6	# [869]
	lui	x31, 261264	# [870]
	addi	x31, x31, -37	# [871]
	xtof	f6, x31	# [872]
	fsub	f4, f4, f6	# [873]
	fmul	f4, f4, f4	# [874]
	fmul	f6, f4, f27	# [875]
	fmul	f7, f6, f4	# [876]
	lui	x31, 252586	# [877]
	addi	x31, x31, -1365	# [878]
	xtof	f8, x31	# [879]
	fmul	f7, f7, f8	# [880]
	fmul	f8, f7, f4	# [881]
	lui	x31, 249992	# [882]
	addi	x31, x31, -1911	# [883]
	xtof	f9, x31	# [884]
	fmul	f8, f8, f9	# [885]
	fmul	f9, f8, f4	# [886]
	lui	x31, 248100	# [887]
	addi	x31, x31, -1755	# [888]
	xtof	f10, x31	# [889]
	fmul	f9, f9, f10	# [890]
	fmul	f4, f9, f4	# [891]
	lui	x31, 246624	# [892]
	addi	x31, x31, -1183	# [893]
	xtof	f10, x31	# [894]
	fmul	f4, f4, f10	# [895]
	fsub	f6, f11, f6	# [896]
	fadd	f6, f6, f7	# [897]
	fsub	f6, f6, f8	# [898]
	fadd	f6, f6, f9	# [899]
	fsub	f4, f6, f4	# [900]
	# let sin_y = sin rot.(1)
	fmul	f4, f5, f4	# [901]
	flw	f5, 2(x5)	# [902] rot.(2)
	fmul	f5, f5, f5	# [903]
	fmul	f6, f5, f27	# [904]
	fmul	f7, f6, f5	# [905]
	lui	x31, 252586	# [906]
	addi	x31, x31, -1365	# [907]
	xtof	f8, x31	# [908]
	fmul	f7, f7, f8	# [909]
	fmul	f8, f7, f5	# [910]
	lui	x31, 249992	# [911]
	addi	x31, x31, -1911	# [912]
	xtof	f9, x31	# [913]
	fmul	f8, f8, f9	# [914]
	fmul	f9, f8, f5	# [915]
	lui	x31, 248100	# [916]
	addi	x31, x31, -1755	# [917]
	xtof	f10, x31	# [918]
	fmul	f9, f9, f10	# [919]
	fmul	f5, f9, f5	# [920]
	lui	x31, 246624	# [921]
	addi	x31, x31, -1183	# [922]
	xtof	f10, x31	# [923]
	fmul	f5, f5, f10	# [924]
	fsub	f6, f11, f6	# [925]
	fadd	f6, f6, f7	# [926]
	fsub	f6, f6, f8	# [927]
	fadd	f6, f6, f9	# [928]
	# let cos_z = cos rot.(2)
	fsub	f5, f6, f5	# [929]
	flw	f6, 2(x5)	# [930] rot.(2)
	lui	x31, 256559	# [931]
	addi	x31, x31, -1661	# [932]
	xtof	f7, x31	# [933]
	fmul	f7, f6, f7	# [934]
	ftoi	x6, f7	# [935]
	andi	x7, x6, 1	# [936]
	itof	f7, x7	# [937]
	fmul	f7, f7, f12	# [938]
	fsub	f7, f11, f7	# [939]
	itof	f8, x6	# [940]
	fmul	f8, f8, f28	# [941]
	fsub	f6, f6, f8	# [942]
	lui	x31, 261264	# [943]
	addi	x31, x31, -37	# [944]
	xtof	f8, x31	# [945]
	fsub	f6, f6, f8	# [946]
	fmul	f6, f6, f6	# [947]
	fmul	f8, f6, f27	# [948]
	fmul	f9, f8, f6	# [949]
	lui	x31, 252586	# [950]
	addi	x31, x31, -1365	# [951]
	xtof	f10, x31	# [952]
	fmul	f9, f9, f10	# [953]
	fmul	f10, f9, f6	# [954]
	lui	x31, 249992	# [955]
	addi	x31, x31, -1911	# [956]
	xtof	f30, x31	# [957]
	fmul	f10, f10, f30	# [958]
	fmul	f30, f10, f6	# [959]
	fsw	f1, 0(x2)	# [960] let sin_z = sin rot.(2) in let m00 = cos_y *. cos_z in let m01 = sin_x *. sin_y *. cos_z -. cos_x *. sin_z in let m02 = cos_x *. sin_y *. cos_z +. sin_x *. sin_z in let m10 = cos_y *. sin_z in let m11 = sin_x *. sin_y *. sin_z +. cos_x *. cos_z in let m12 = cos_x *. sin_y *. sin_z -. sin_x *. cos_z in let m20 = fneg sin_y in let m21 = sin_x *. cos_y in let m22 = cos_x *. cos_y in let ao = abc.(0) in let bo = abc.(1) in let co = abc.(2) in abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	lui	x31, 248100	# [961]
	addi	x31, x31, -1755	# [962]
	xtof	f1, x31	# [963]
	fmul	f1, f30, f1	# [964]
	fmul	f6, f1, f6	# [965]
	lui	x31, 246624	# [966]
	addi	x31, x31, -1183	# [967]
	xtof	f30, x31	# [968]
	fmul	f6, f6, f30	# [969]
	fsub	f8, f11, f8	# [970]
	fadd	f8, f8, f9	# [971]
	fsub	f8, f8, f10	# [972]
	fadd	f1, f8, f1	# [973]
	fsub	f1, f1, f6	# [974]
	# let sin_z = sin rot.(2)
	fmul	f1, f7, f1	# [975]
	# let m00 = cos_y *. cos_z
	fmul	f6, f3, f5	# [976] cos_y *. cos_z
	fmul	f7, f2, f4	# [977] sin_x *. sin_y
	fmul	f7, f7, f5	# [978] sin_x *. sin_y *. cos_z
	flw	f8, 0(x2)	# [979] cos_x *. sin_z
	fmul	f9, f8, f1	# [980] cos_x *. sin_z
	# let m01 = sin_x *. sin_y *. cos_z -. cos_x *. sin_z
	fsub	f7, f7, f9	# [981] sin_x *. sin_y *. cos_z -. cos_x *. sin_z
	fmul	f9, f8, f4	# [982] cos_x *. sin_y
	fmul	f9, f9, f5	# [983] cos_x *. sin_y *. cos_z
	fmul	f10, f2, f1	# [984] sin_x *. sin_z
	# let m02 = cos_x *. sin_y *. cos_z +. sin_x *. sin_z
	fadd	f9, f9, f10	# [985] cos_x *. sin_y *. cos_z +. sin_x *. sin_z
	# let m10 = cos_y *. sin_z
	fmul	f10, f3, f1	# [986] cos_y *. sin_z
	fmul	f30, f2, f4	# [987] sin_x *. sin_y
	fmul	f30, f30, f1	# [988] sin_x *. sin_y *. sin_z
	fsw	f9, 1(x2)	# [989] let m11 = sin_x *. sin_y *. sin_z +. cos_x *. cos_z in let m12 = cos_x *. sin_y *. sin_z -. sin_x *. cos_z in let m20 = fneg sin_y in let m21 = sin_x *. cos_y in let m22 = cos_x *. cos_y in let ao = abc.(0) in let bo = abc.(1) in let co = abc.(2) in abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f9, f8, f5	# [990] cos_x *. cos_z
	# let m11 = sin_x *. sin_y *. sin_z +. cos_x *. cos_z
	fadd	f9, f30, f9	# [991] sin_x *. sin_y *. sin_z +. cos_x *. cos_z
	fmul	f30, f8, f4	# [992] cos_x *. sin_y
	fmul	f1, f30, f1	# [993] cos_x *. sin_y *. sin_z
	fmul	f5, f2, f5	# [994] sin_x *. cos_z
	# let m12 = cos_x *. sin_y *. sin_z -. sin_x *. cos_z
	fsub	f1, f1, f5	# [995] cos_x *. sin_y *. sin_z -. sin_x *. cos_z
	# let m20 = fneg sin_y
	fneg	f4, f4	# [996] fneg sin_y
	# let m21 = sin_x *. cos_y
	fmul	f2, f2, f3	# [997] sin_x *. cos_y
	# let m22 = cos_x *. cos_y
	fmul	f3, f8, f3	# [998] cos_x *. cos_y
	# let ao = abc.(0)
	flw	f5, 0(x4)	# [999] abc.(0)
	# let bo = abc.(1)
	flw	f8, 1(x4)	# [1000] abc.(1)
	# let co = abc.(2)
	flw	f30, 2(x4)	# [1001] abc.(2)
	fsw	f6, 2(x2)	# [1002] abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f6, f6, f6	# [1003] fsqr m00
	fmul	f6, f5, f6	# [1004] ao *. fsqr m00
	fsw	f10, 3(x2)	# [1005] abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f10, f10, f10	# [1006] fsqr m10
	fmul	f10, f8, f10	# [1007] bo *. fsqr m10
	fadd	f6, f6, f10	# [1008] ao *. fsqr m00 +. bo *. fsqr m10
	fmul	f10, f4, f4	# [1009] fsqr m20
	fmul	f10, f30, f10	# [1010] co *. fsqr m20
	fadd	f6, f6, f10	# [1011] ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20
	fsw	f6, 0(x4)	# [1012] abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20
	fmul	f6, f7, f7	# [1013] fsqr m01
	fmul	f6, f5, f6	# [1014] ao *. fsqr m01
	fmul	f10, f9, f9	# [1015] fsqr m11
	fmul	f10, f8, f10	# [1016] bo *. fsqr m11
	fadd	f6, f6, f10	# [1017] ao *. fsqr m01 +. bo *. fsqr m11
	fmul	f10, f2, f2	# [1018] fsqr m21
	fmul	f10, f30, f10	# [1019] co *. fsqr m21
	fadd	f6, f6, f10	# [1020] ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21
	fsw	f6, 1(x4)	# [1021] abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21
	flw	f6, 1(x2)	# [1022] fsqr m02
	fmul	f10, f6, f6	# [1023] fsqr m02
	fmul	f10, f5, f10	# [1024] ao *. fsqr m02
	fsw	f4, 4(x2)	# [1025] abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f4, f1, f1	# [1026] fsqr m12
	fmul	f4, f8, f4	# [1027] bo *. fsqr m12
	fadd	f4, f10, f4	# [1028] ao *. fsqr m02 +. bo *. fsqr m12
	fmul	f10, f3, f3	# [1029] fsqr m22
	fmul	f10, f30, f10	# [1030] co *. fsqr m22
	fadd	f4, f4, f10	# [1031] ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22
	fsw	f4, 2(x4)	# [1032] abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22
	fmul	f4, f5, f7	# [1033] ao *. m01
	fmul	f4, f4, f6	# [1034] ao *. m01 *. m02
	fmul	f10, f8, f9	# [1035] bo *. m11
	fmul	f10, f10, f1	# [1036] bo *. m11 *. m12
	fadd	f4, f4, f10	# [1037] ao *. m01 *. m02 +. bo *. m11 *. m12
	fmul	f10, f30, f2	# [1038] co *. m21
	fmul	f10, f10, f3	# [1039] co *. m21 *. m22
	fadd	f4, f4, f10	# [1040] ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22
	fmul	f4, f12, f4	# [1041] 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22)
	fsw	f4, 0(x5)	# [1042] rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22)
	flw	f4, 2(x2)	# [1043] ao *. m00
	fmul	f10, f5, f4	# [1044] ao *. m00
	fmul	f6, f10, f6	# [1045] ao *. m00 *. m02
	fsw	f2, 5(x2)	# [1046] rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	flw	f10, 3(x2)	# [1047] bo *. m10
	fmul	f2, f8, f10	# [1048] bo *. m10
	fmul	f1, f2, f1	# [1049] bo *. m10 *. m12
	fadd	f1, f6, f1	# [1050] ao *. m00 *. m02 +. bo *. m10 *. m12
	flw	f2, 4(x2)	# [1051] co *. m20
	fmul	f6, f30, f2	# [1052] co *. m20
	fmul	f3, f6, f3	# [1053] co *. m20 *. m22
	fadd	f1, f1, f3	# [1054] ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22
	fmul	f1, f12, f1	# [1055] 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22)
	fsw	f1, 1(x5)	# [1056] rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22)
	fmul	f1, f5, f4	# [1057] ao *. m00
	fmul	f1, f1, f7	# [1058] ao *. m00 *. m01
	fmul	f3, f8, f10	# [1059] bo *. m10
	fmul	f3, f3, f9	# [1060] bo *. m10 *. m11
	fadd	f1, f1, f3	# [1061] ao *. m00 *. m01 +. bo *. m10 *. m11
	fmul	f2, f30, f2	# [1062] co *. m20
	flw	f3, 5(x2)	# [1063] co *. m20 *. m21
	fmul	f2, f2, f3	# [1064] co *. m20 *. m21
	fadd	f1, f1, f2	# [1065] ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21
	fmul	f1, f12, f1	# [1066] 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fsw	f1, 2(x5)	# [1067] rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	jalr x0, x1, 0	# [1068] rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
# read_nth_object.3041:	let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	# let texture = read_int ()
	ib	x5	# [1069] read_int ()
	slli	x5, x5, 8	# [1070] read_int ()
	ib	x31	# [1071] read_int ()
	or	x5, x5, x31	# [1072] read_int ()
	slli	x5, x5, 8	# [1073] read_int ()
	ib	x31	# [1074] read_int ()
	or	x5, x5, x31	# [1075] read_int ()
	slli	x5, x5, 8	# [1076] read_int ()
	ib	x31	# [1077] read_int ()
	or	x5, x5, x31	# [1078] read_int ()
	addi	x6, x0, -1	# [1079] -1
	bne	x5, x6, 3	# [1080] if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
# beq:	false
	addi	x4, x0, 0	# [1081] false
	jalr	x0, x1, 0	# [1082] false
# bne:	let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true
	# let form = read_int ()
	ib	x6	# [1083] read_int ()
	slli	x6, x6, 8	# [1084] read_int ()
	ib	x31	# [1085] read_int ()
	or	x6, x6, x31	# [1086] read_int ()
	slli	x6, x6, 8	# [1087] read_int ()
	ib	x31	# [1088] read_int ()
	or	x6, x6, x31	# [1089] read_int ()
	slli	x6, x6, 8	# [1090] read_int ()
	ib	x31	# [1091] read_int ()
	or	x6, x6, x31	# [1092] read_int ()
	# let refltype = read_int ()
	ib	x7	# [1093] read_int ()
	slli	x7, x7, 8	# [1094] read_int ()
	ib	x31	# [1095] read_int ()
	or	x7, x7, x31	# [1096] read_int ()
	slli	x7, x7, 8	# [1097] read_int ()
	ib	x31	# [1098] read_int ()
	or	x7, x7, x31	# [1099] read_int ()
	slli	x7, x7, 8	# [1100] read_int ()
	ib	x31	# [1101] read_int ()
	or	x7, x7, x31	# [1102] read_int ()
	# let isrot_p = read_int ()
	ib	x8	# [1103] read_int ()
	slli	x8, x8, 8	# [1104] read_int ()
	ib	x31	# [1105] read_int ()
	or	x8, x8, x31	# [1106] read_int ()
	slli	x8, x8, 8	# [1107] read_int ()
	ib	x31	# [1108] read_int ()
	or	x8, x8, x31	# [1109] read_int ()
	slli	x8, x8, 8	# [1110] read_int ()
	ib	x31	# [1111] read_int ()
	or	x8, x8, x31	# [1112] read_int ()
	addi	x9, x0, 3	# [1113] 3
	addi	x31, x0, 0	# [1114] 0.0
	xtof	f1, x31	# [1115] 0.0
	# let abc = create_array 3 0.0
	add	x31, x3, x9	# [1116] create_array 3 0.0
	beq	x31, x3, 4	# [1117] create_array 3 0.0
	fsw	f1, 0(x3)	# [1118] create_array 3 0.0
	addi	x3, x3, 1	# [1119] create_array 3 0.0
	jal	x0, -3	# [1120] create_array 3 0.0
	ib	x30	# [1121] read_float ()
	slli	x30, x30, 8	# [1122] read_float ()
	ib	x31	# [1123] read_float ()
	or	x30, x30, x31	# [1124] read_float ()
	slli	x30, x30, 8	# [1125] read_float ()
	ib	x31	# [1126] read_float ()
	or	x30, x30, x31	# [1127] read_float ()
	slli	x30, x30, 8	# [1128] read_float ()
	ib	x31	# [1129] read_float ()
	or	x30, x30, x31	# [1130] read_float ()
	xtof	f1, x30	# [1131] read_float ()
	fsw	f1, 0(x9)	# [1132] abc.(0) <- read_float ()
	ib	x30	# [1133] read_float ()
	slli	x30, x30, 8	# [1134] read_float ()
	ib	x31	# [1135] read_float ()
	or	x30, x30, x31	# [1136] read_float ()
	slli	x30, x30, 8	# [1137] read_float ()
	ib	x31	# [1138] read_float ()
	or	x30, x30, x31	# [1139] read_float ()
	slli	x30, x30, 8	# [1140] read_float ()
	ib	x31	# [1141] read_float ()
	or	x30, x30, x31	# [1142] read_float ()
	xtof	f1, x30	# [1143] read_float ()
	fsw	f1, 1(x9)	# [1144] abc.(1) <- read_float ()
	ib	x30	# [1145] read_float ()
	slli	x30, x30, 8	# [1146] read_float ()
	ib	x31	# [1147] read_float ()
	or	x30, x30, x31	# [1148] read_float ()
	slli	x30, x30, 8	# [1149] read_float ()
	ib	x31	# [1150] read_float ()
	or	x30, x30, x31	# [1151] read_float ()
	slli	x30, x30, 8	# [1152] read_float ()
	ib	x31	# [1153] read_float ()
	or	x30, x30, x31	# [1154] read_float ()
	xtof	f1, x30	# [1155] read_float ()
	fsw	f1, 2(x9)	# [1156] abc.(2) <- read_float ()
	addi	x10, x0, 3	# [1157] 3
	addi	x31, x0, 0	# [1158] 0.0
	xtof	f1, x31	# [1159] 0.0
	# let xyz = create_array 3 0.0
	add	x31, x3, x10	# [1160] create_array 3 0.0
	beq	x31, x3, 4	# [1161] create_array 3 0.0
	fsw	f1, 0(x3)	# [1162] create_array 3 0.0
	addi	x3, x3, 1	# [1163] create_array 3 0.0
	jal	x0, -3	# [1164] create_array 3 0.0
	ib	x30	# [1165] read_float ()
	slli	x30, x30, 8	# [1166] read_float ()
	ib	x31	# [1167] read_float ()
	or	x30, x30, x31	# [1168] read_float ()
	slli	x30, x30, 8	# [1169] read_float ()
	ib	x31	# [1170] read_float ()
	or	x30, x30, x31	# [1171] read_float ()
	slli	x30, x30, 8	# [1172] read_float ()
	ib	x31	# [1173] read_float ()
	or	x30, x30, x31	# [1174] read_float ()
	xtof	f1, x30	# [1175] read_float ()
	fsw	f1, 0(x10)	# [1176] xyz.(0) <- read_float ()
	ib	x30	# [1177] read_float ()
	slli	x30, x30, 8	# [1178] read_float ()
	ib	x31	# [1179] read_float ()
	or	x30, x30, x31	# [1180] read_float ()
	slli	x30, x30, 8	# [1181] read_float ()
	ib	x31	# [1182] read_float ()
	or	x30, x30, x31	# [1183] read_float ()
	slli	x30, x30, 8	# [1184] read_float ()
	ib	x31	# [1185] read_float ()
	or	x30, x30, x31	# [1186] read_float ()
	xtof	f1, x30	# [1187] read_float ()
	fsw	f1, 1(x10)	# [1188] xyz.(1) <- read_float ()
	ib	x30	# [1189] read_float ()
	slli	x30, x30, 8	# [1190] read_float ()
	ib	x31	# [1191] read_float ()
	or	x30, x30, x31	# [1192] read_float ()
	slli	x30, x30, 8	# [1193] read_float ()
	ib	x31	# [1194] read_float ()
	or	x30, x30, x31	# [1195] read_float ()
	slli	x30, x30, 8	# [1196] read_float ()
	ib	x31	# [1197] read_float ()
	or	x30, x30, x31	# [1198] read_float ()
	xtof	f1, x30	# [1199] read_float ()
	fsw	f1, 2(x10)	# [1200] xyz.(2) <- read_float ()
	ib	x30	# [1201] read_float ()
	slli	x30, x30, 8	# [1202] read_float ()
	ib	x31	# [1203] read_float ()
	or	x30, x30, x31	# [1204] read_float ()
	slli	x30, x30, 8	# [1205] read_float ()
	ib	x31	# [1206] read_float ()
	or	x30, x30, x31	# [1207] read_float ()
	slli	x30, x30, 8	# [1208] read_float ()
	ib	x31	# [1209] read_float ()
	or	x30, x30, x31	# [1210] read_float ()
	xtof	f1, x30	# [1211] read_float ()
	# let m_invert = fisneg (read_float ())
	flt	x11, f1, f0	# [1212] fisneg (read_float ())
	addi	x12, x0, 2	# [1213] 2
	addi	x31, x0, 0	# [1214] 0.0
	xtof	f1, x31	# [1215] 0.0
	# let reflparam = create_array 2 0.0
	add	x31, x3, x12	# [1216] create_array 2 0.0
	beq	x31, x3, 4	# [1217] create_array 2 0.0
	fsw	f1, 0(x3)	# [1218] create_array 2 0.0
	addi	x3, x3, 1	# [1219] create_array 2 0.0
	jal	x0, -3	# [1220] create_array 2 0.0
	ib	x30	# [1221] read_float ()
	slli	x30, x30, 8	# [1222] read_float ()
	ib	x31	# [1223] read_float ()
	or	x30, x30, x31	# [1224] read_float ()
	slli	x30, x30, 8	# [1225] read_float ()
	ib	x31	# [1226] read_float ()
	or	x30, x30, x31	# [1227] read_float ()
	slli	x30, x30, 8	# [1228] read_float ()
	ib	x31	# [1229] read_float ()
	or	x30, x30, x31	# [1230] read_float ()
	xtof	f1, x30	# [1231] read_float ()
	fsw	f1, 0(x12)	# [1232] reflparam.(0) <- read_float ()
	ib	x30	# [1233] read_float ()
	slli	x30, x30, 8	# [1234] read_float ()
	ib	x31	# [1235] read_float ()
	or	x30, x30, x31	# [1236] read_float ()
	slli	x30, x30, 8	# [1237] read_float ()
	ib	x31	# [1238] read_float ()
	or	x30, x30, x31	# [1239] read_float ()
	slli	x30, x30, 8	# [1240] read_float ()
	ib	x31	# [1241] read_float ()
	or	x30, x30, x31	# [1242] read_float ()
	xtof	f1, x30	# [1243] read_float ()
	fsw	f1, 1(x12)	# [1244] reflparam.(1) <- read_float ()
	addi	x13, x0, 3	# [1245] 3
	addi	x31, x0, 0	# [1246] 0.0
	xtof	f1, x31	# [1247] 0.0
	# let color = create_array 3 0.0
	add	x31, x3, x13	# [1248] create_array 3 0.0
	beq	x31, x3, 4	# [1249] create_array 3 0.0
	fsw	f1, 0(x3)	# [1250] create_array 3 0.0
	addi	x3, x3, 1	# [1251] create_array 3 0.0
	jal	x0, -3	# [1252] create_array 3 0.0
	ib	x30	# [1253] read_float ()
	slli	x30, x30, 8	# [1254] read_float ()
	ib	x31	# [1255] read_float ()
	or	x30, x30, x31	# [1256] read_float ()
	slli	x30, x30, 8	# [1257] read_float ()
	ib	x31	# [1258] read_float ()
	or	x30, x30, x31	# [1259] read_float ()
	slli	x30, x30, 8	# [1260] read_float ()
	ib	x31	# [1261] read_float ()
	or	x30, x30, x31	# [1262] read_float ()
	xtof	f1, x30	# [1263] read_float ()
	fsw	f1, 0(x13)	# [1264] color.(0) <- read_float ()
	ib	x30	# [1265] read_float ()
	slli	x30, x30, 8	# [1266] read_float ()
	ib	x31	# [1267] read_float ()
	or	x30, x30, x31	# [1268] read_float ()
	slli	x30, x30, 8	# [1269] read_float ()
	ib	x31	# [1270] read_float ()
	or	x30, x30, x31	# [1271] read_float ()
	slli	x30, x30, 8	# [1272] read_float ()
	ib	x31	# [1273] read_float ()
	or	x30, x30, x31	# [1274] read_float ()
	xtof	f1, x30	# [1275] read_float ()
	fsw	f1, 1(x13)	# [1276] color.(1) <- read_float ()
	ib	x30	# [1277] read_float ()
	slli	x30, x30, 8	# [1278] read_float ()
	ib	x31	# [1279] read_float ()
	or	x30, x30, x31	# [1280] read_float ()
	slli	x30, x30, 8	# [1281] read_float ()
	ib	x31	# [1282] read_float ()
	or	x30, x30, x31	# [1283] read_float ()
	slli	x30, x30, 8	# [1284] read_float ()
	ib	x31	# [1285] read_float ()
	or	x30, x30, x31	# [1286] read_float ()
	xtof	f1, x30	# [1287] read_float ()
	fsw	f1, 2(x13)	# [1288] color.(2) <- read_float ()
	addi	x14, x0, 3	# [1289] 3
	addi	x31, x0, 0	# [1290] 0.0
	xtof	f1, x31	# [1291] 0.0
	# let rotation = create_array 3 0.0
	add	x31, x3, x14	# [1292] create_array 3 0.0
	beq	x31, x3, 4	# [1293] create_array 3 0.0
	fsw	f1, 0(x3)	# [1294] create_array 3 0.0
	addi	x3, x3, 1	# [1295] create_array 3 0.0
	jal	x0, -3	# [1296] create_array 3 0.0
	sw	x4, 0(x2)	# [1297] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x5, 1(x2)	# [1298] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x7, 2(x2)	# [1299] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x8, 3(x2)	# [1300] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x9, 4(x2)	# [1301] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x10, 5(x2)	# [1302] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x12, 6(x2)	# [1303] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x13, 7(x2)	# [1304] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x14, 8(x2)	# [1305] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x11, 9(x2)	# [1306] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	sw	x6, 10(x2)	# [1307] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	bne	x8, x0, 2	# [1308] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
# beq:	()
	jal	x0, 55	# [1309] if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
# bne:	rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ())
	ib	x30	# [1310] read_float ()
	slli	x30, x30, 8	# [1311] read_float ()
	ib	x31	# [1312] read_float ()
	or	x30, x30, x31	# [1313] read_float ()
	slli	x30, x30, 8	# [1314] read_float ()
	ib	x31	# [1315] read_float ()
	or	x30, x30, x31	# [1316] read_float ()
	slli	x30, x30, 8	# [1317] read_float ()
	ib	x31	# [1318] read_float ()
	or	x30, x30, x31	# [1319] read_float ()
	xtof	f1, x30	# [1320] read_float ()
	sw	x1, 11(x2)	# [1321] rad (read_float ())
	addi	x2, x2, 12	# [1322] rad (read_float ())
	jal	x1, -1081	# [1323] rad (read_float ())
	addi	x2, x2, -12	# [1324] rad (read_float ())
	lw	x1, 11(x2)	# [1325] rad (read_float ())
	lw	x4, 8(x2)	# [1326] rotation.(0) <- rad (read_float ())
	fsw	f1, 0(x4)	# [1327] rotation.(0) <- rad (read_float ())
	ib	x30	# [1328] read_float ()
	slli	x30, x30, 8	# [1329] read_float ()
	ib	x31	# [1330] read_float ()
	or	x30, x30, x31	# [1331] read_float ()
	slli	x30, x30, 8	# [1332] read_float ()
	ib	x31	# [1333] read_float ()
	or	x30, x30, x31	# [1334] read_float ()
	slli	x30, x30, 8	# [1335] read_float ()
	ib	x31	# [1336] read_float ()
	or	x30, x30, x31	# [1337] read_float ()
	xtof	f1, x30	# [1338] read_float ()
	sw	x1, 11(x2)	# [1339] rad (read_float ())
	addi	x2, x2, 12	# [1340] rad (read_float ())
	jal	x1, -1099	# [1341] rad (read_float ())
	addi	x2, x2, -12	# [1342] rad (read_float ())
	lw	x1, 11(x2)	# [1343] rad (read_float ())
	lw	x4, 8(x2)	# [1344] rotation.(1) <- rad (read_float ())
	fsw	f1, 1(x4)	# [1345] rotation.(1) <- rad (read_float ())
	ib	x30	# [1346] read_float ()
	slli	x30, x30, 8	# [1347] read_float ()
	ib	x31	# [1348] read_float ()
	or	x30, x30, x31	# [1349] read_float ()
	slli	x30, x30, 8	# [1350] read_float ()
	ib	x31	# [1351] read_float ()
	or	x30, x30, x31	# [1352] read_float ()
	slli	x30, x30, 8	# [1353] read_float ()
	ib	x31	# [1354] read_float ()
	or	x30, x30, x31	# [1355] read_float ()
	xtof	f1, x30	# [1356] read_float ()
	sw	x1, 11(x2)	# [1357] rad (read_float ())
	addi	x2, x2, 12	# [1358] rad (read_float ())
	jal	x1, -1117	# [1359] rad (read_float ())
	addi	x2, x2, -12	# [1360] rad (read_float ())
	lw	x1, 11(x2)	# [1361] rad (read_float ())
	lw	x5, 8(x2)	# [1362] rotation.(2) <- rad (read_float ())
	fsw	f1, 2(x5)	# [1363] rotation.(2) <- rad (read_float ())
# cont:	if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	addi	x4, x0, 2	# [1364] 2
	lw	x5, 10(x2)	# [1365] if form = 2 then true else m_invert
	# let m_invert2 = if form = 2 then true else m_invert
	bne	x5, x4, 3	# [1366] if form = 2 then true else m_invert
# beq:	true
	addi	x4, x0, 1	# [1367] true
	jal	x0, 2	# [1368] if form = 2 then true else m_invert
# bne:	m_invert
	lw	x4, 9(x2)	# [1369] m_invert
# cont:	if form = 2 then true else m_invert
	addi	x6, x0, 4	# [1370] 4
	addi	x31, x0, 0	# [1371] 0.0
	xtof	f1, x31	# [1372] 0.0
	# let ctbl = create_array 4 0.0
	add	x31, x3, x6	# [1373] create_array 4 0.0
	beq	x31, x3, 4	# [1374] create_array 4 0.0
	fsw	f1, 0(x3)	# [1375] create_array 4 0.0
	addi	x3, x3, 1	# [1376] create_array 4 0.0
	jal	x0, -3	# [1377] create_array 4 0.0
	addi	x31, x3, 0	# [1378] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	addi	x3, x3, 11	# [1379] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x6, 10(x31)	# [1380] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x6, 8(x2)	# [1381] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x6, 9(x31)	# [1382] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x7, 7(x2)	# [1383] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x7, 8(x31)	# [1384] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x7, 6(x2)	# [1385] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x7, 7(x31)	# [1386] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 6(x31)	# [1387] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x4, 5(x2)	# [1388] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 5(x31)	# [1389] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x4, 4(x2)	# [1390] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 4(x31)	# [1391] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x7, 3(x2)	# [1392] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x7, 3(x31)	# [1393] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x8, 2(x2)	# [1394] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x8, 2(x31)	# [1395] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x5, 1(x31)	# [1396] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x8, 1(x2)	# [1397] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x8, 0(x31)	# [1398] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	# let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl )
	addi	x8, x31, 0	# [1399] texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lui	x9, 256	# [1400] objects
	addi	x9, x9, 60	# [1401] objects
	lw	x10, 0(x2)	# [1402] objects.(n) <- obj
	add	x31, x9, x10	# [1403] objects.(n) <- obj
	sw	x8, 0(x31)	# [1404] objects.(n) <- obj
	addi	x8, x0, 3	# [1405] 3
	bne	x5, x8, 53	# [1406] if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else ()
# beq:	let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c
	# let a = abc.(0)
	flw	f1, 0(x4)	# [1407] abc.(0)
	feq	x5, f1, f0	# [1408] fiszero a
	bne	x5, x0, 11	# [1409] if fiszero a then 0.0 else sgn a /. fsqr a
# beq:	sgn a /. fsqr a
	fsw	f1, 11(x2)	# [1410] sgn a
	sw	x1, 12(x2)	# [1411] sgn a
	addi	x2, x2, 13	# [1412] sgn a
	jal	x1, -1411	# [1413] sgn a
	addi	x2, x2, -13	# [1414] sgn a
	lw	x1, 12(x2)	# [1415] sgn a
	flw	f2, 11(x2)	# [1416] fsqr a
	fmul	f2, f2, f2	# [1417] fsqr a
	fdiv	f1, f1, f2	# [1418] sgn a /. fsqr a
	jal	x0, 3	# [1419] if fiszero a then 0.0 else sgn a /. fsqr a
# bne:	0.0
	addi	x31, x0, 0	# [1420] 0.0
	xtof	f1, x31	# [1421] 0.0
# cont:	if fiszero a then 0.0 else sgn a /. fsqr a
	lw	x4, 4(x2)	# [1422] abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a
	fsw	f1, 0(x4)	# [1423] abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a
	# let b = abc.(1)
	flw	f1, 1(x4)	# [1424] abc.(1)
	feq	x5, f1, f0	# [1425] fiszero b
	bne	x5, x0, 11	# [1426] if fiszero b then 0.0 else sgn b /. fsqr b
# beq:	sgn b /. fsqr b
	fsw	f1, 12(x2)	# [1427] sgn b
	sw	x1, 13(x2)	# [1428] sgn b
	addi	x2, x2, 14	# [1429] sgn b
	jal	x1, -1428	# [1430] sgn b
	addi	x2, x2, -14	# [1431] sgn b
	lw	x1, 13(x2)	# [1432] sgn b
	flw	f2, 12(x2)	# [1433] fsqr b
	fmul	f2, f2, f2	# [1434] fsqr b
	fdiv	f1, f1, f2	# [1435] sgn b /. fsqr b
	jal	x0, 3	# [1436] if fiszero b then 0.0 else sgn b /. fsqr b
# bne:	0.0
	addi	x31, x0, 0	# [1437] 0.0
	xtof	f1, x31	# [1438] 0.0
# cont:	if fiszero b then 0.0 else sgn b /. fsqr b
	lw	x4, 4(x2)	# [1439] abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b
	fsw	f1, 1(x4)	# [1440] abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b
	# let c = abc.(2)
	flw	f1, 2(x4)	# [1441] abc.(2)
	feq	x5, f1, f0	# [1442] fiszero c
	bne	x5, x0, 11	# [1443] if fiszero c then 0.0 else sgn c /. fsqr c
# beq:	sgn c /. fsqr c
	fsw	f1, 13(x2)	# [1444] sgn c
	sw	x1, 14(x2)	# [1445] sgn c
	addi	x2, x2, 15	# [1446] sgn c
	jal	x1, -1445	# [1447] sgn c
	addi	x2, x2, -15	# [1448] sgn c
	lw	x1, 14(x2)	# [1449] sgn c
	flw	f2, 13(x2)	# [1450] fsqr c
	fmul	f2, f2, f2	# [1451] fsqr c
	fdiv	f1, f1, f2	# [1452] sgn c /. fsqr c
	jal	x0, 3	# [1453] if fiszero c then 0.0 else sgn c /. fsqr c
# bne:	0.0
	addi	x31, x0, 0	# [1454] 0.0
	xtof	f1, x31	# [1455] 0.0
# cont:	if fiszero c then 0.0 else sgn c /. fsqr c
	lw	x4, 4(x2)	# [1456] abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c
	fsw	f1, 2(x4)	# [1457] abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c
	jal	x0, 12	# [1458] if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else ()
# bne:	if form = 2 then vecunit_sgn abc (not m_invert) else ()
	addi	x8, x0, 2	# [1459] 2
	bne	x5, x8, 10	# [1460] if form = 2 then vecunit_sgn abc (not m_invert) else ()
# beq:	vecunit_sgn abc (not m_invert)
	lw	x5, 9(x2)	# [1461] not m_invert
	xori	x5, x5, -1	# [1462] not m_invert
	sw	x1, 14(x2)	# [1463] vecunit_sgn abc (not m_invert)
	addi	x2, x2, 15	# [1464] vecunit_sgn abc (not m_invert)
	jal	x1, -1420	# [1465] vecunit_sgn abc (not m_invert)
	addi	x2, x2, -15	# [1466] vecunit_sgn abc (not m_invert)
	lw	x1, 14(x2)	# [1467] vecunit_sgn abc (not m_invert)
	addi	x0, x4, 0	# [1468] vecunit_sgn abc (not m_invert)
	jal	x0, 1	# [1469] if form = 2 then vecunit_sgn abc (not m_invert) else ()
# bne:	()
# cont:	if form = 2 then vecunit_sgn abc (not m_invert) else ()
# cont:	if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else ()
	lw	x4, 3(x2)	# [1470] if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
	bne	x4, x0, 2	# [1471] if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
# beq:	()
	jal	x0, 9	# [1472] if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
# bne:	rotate_quadratic_matrix abc rotation
	lw	x4, 4(x2)	# [1473] rotate_quadratic_matrix abc rotation
	lw	x5, 8(x2)	# [1474] rotate_quadratic_matrix abc rotation
	sw	x1, 14(x2)	# [1475] rotate_quadratic_matrix abc rotation
	addi	x2, x2, 15	# [1476] rotate_quadratic_matrix abc rotation
	jal	x1, -721	# [1477] rotate_quadratic_matrix abc rotation
	addi	x2, x2, -15	# [1478] rotate_quadratic_matrix abc rotation
	lw	x1, 14(x2)	# [1479] rotate_quadratic_matrix abc rotation
	addi	x0, x4, 0	# [1480] rotate_quadratic_matrix abc rotation
# cont:	if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
	addi	x4, x0, 1	# [1481] true
	jalr	x0, x1, 0	# [1482] true
# read_object.3043:	let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	addi	x5, x0, 60	# [1483] 60
	bge	x4, x5, 16	# [1484] if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
# blt:	if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n
	sw	x4, 0(x2)	# [1485] read_nth_object n
	sw	x1, 1(x2)	# [1486] read_nth_object n
	addi	x2, x2, 2	# [1487] read_nth_object n
	jal	x1, -419	# [1488] read_nth_object n
	addi	x2, x2, -2	# [1489] read_nth_object n
	lw	x1, 1(x2)	# [1490] read_nth_object n
	bne	x4, x0, 6	# [1491] if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n
# beq:	n_objects.(0) <- n
	lui	x4, 256	# [1492] n_objects
	addi	x4, x4, 0	# [1493] n_objects
	lw	x5, 0(x2)	# [1494] n_objects.(0) <- n
	sw	x5, 0(x4)	# [1495] n_objects.(0) <- n
	jalr x0, x1, 0	# [1496] n_objects.(0) <- n
# bne:	read_object (n + 1)
	lw	x4, 0(x2)	# [1497] n + 1
	addi	x4, x4, 1	# [1498] n + 1
	jal	x0, -16	# [1499] read_object (n + 1)
# bge:	()
	jalr x0, x1, 0	# [1500] ()
# read_all_object.3045:	let rec read_all_object _ = read_object 0
	addi	x4, x0, 0	# [1501] 0
	jal	x0, -19	# [1502] read_object 0
# read_net_item.3047:	let rec read_net_item length = let item = read_int () in if item = -1 then create_array (length + 1) (-1) else let v = read_net_item (length + 1) in (v.(length) <- item; v)
	# let item = read_int ()
	ib	x5	# [1503] read_int ()
	slli	x5, x5, 8	# [1504] read_int ()
	ib	x31	# [1505] read_int ()
	or	x5, x5, x31	# [1506] read_int ()
	slli	x5, x5, 8	# [1507] read_int ()
	ib	x31	# [1508] read_int ()
	or	x5, x5, x31	# [1509] read_int ()
	slli	x5, x5, 8	# [1510] read_int ()
	ib	x31	# [1511] read_int ()
	or	x5, x5, x31	# [1512] read_int ()
	addi	x6, x0, -1	# [1513] -1
	bne	x5, x6, 9	# [1514] if item = -1 then create_array (length + 1) (-1) else let v = read_net_item (length + 1) in (v.(length) <- item; v)
# beq:	create_array (length + 1) (-1)
	addi	x4, x4, 1	# [1515] length + 1
	addi	x5, x0, -1	# [1516] -1
	add	x31, x3, x4	# [1517] create_array (length + 1) (-1)
	beq	x31, x3, 4	# [1518] create_array (length + 1) (-1)
	sw	x5, 0(x3)	# [1519] create_array (length + 1) (-1)
	addi	x3, x3, 1	# [1520] create_array (length + 1) (-1)
	jal	x0, -3	# [1521] create_array (length + 1) (-1)
	jalr	x0, x1, 0	# [1522] create_array (length + 1) (-1)
# bne:	let v = read_net_item (length + 1) in (v.(length) <- item; v)
	addi	x6, x4, 1	# [1523] length + 1
	sw	x4, 0(x2)	# [1524] read_net_item (length + 1)
	sw	x5, 1(x2)	# [1525] read_net_item (length + 1)
	# let v = read_net_item (length + 1)
	addi	x4, x6, 0	# [1526] read_net_item (length + 1)
	sw	x1, 2(x2)	# [1527] read_net_item (length + 1)
	addi	x2, x2, 3	# [1528] read_net_item (length + 1)
	jal	x1, -26	# [1529] read_net_item (length + 1)
	addi	x2, x2, -3	# [1530] read_net_item (length + 1)
	lw	x1, 2(x2)	# [1531] read_net_item (length + 1)
	lw	x5, 0(x2)	# [1532] v.(length) <- item
	lw	x6, 1(x2)	# [1533] v.(length) <- item
	add	x31, x4, x5	# [1534] v.(length) <- item
	sw	x6, 0(x31)	# [1535] v.(length) <- item
	jalr	x0, x1, 0	# [1536] v
# read_or_network.3049:	let rec read_or_network length = let net = read_net_item 0 in if net.(0) = -1 then create_array (length + 1) net else let v = read_or_network (length + 1) in (v.(length) <- net; v)
	addi	x5, x0, 0	# [1537] 0
	sw	x4, 0(x2)	# [1538] read_net_item 0
	# let net = read_net_item 0
	addi	x4, x5, 0	# [1539] read_net_item 0
	sw	x1, 1(x2)	# [1540] read_net_item 0
	addi	x2, x2, 2	# [1541] read_net_item 0
	jal	x1, -39	# [1542] read_net_item 0
	addi	x2, x2, -2	# [1543] read_net_item 0
	lw	x1, 1(x2)	# [1544] read_net_item 0
	lw	x5, 0(x4)	# [1545] net.(0)
	addi	x6, x0, -1	# [1546] -1
	bne	x5, x6, 9	# [1547] if net.(0) = -1 then create_array (length + 1) net else let v = read_or_network (length + 1) in (v.(length) <- net; v)
# beq:	create_array (length + 1) net
	lw	x5, 0(x2)	# [1548] length + 1
	addi	x5, x5, 1	# [1549] length + 1
	add	x31, x3, x5	# [1550] create_array (length + 1) net
	beq	x31, x3, 4	# [1551] create_array (length + 1) net
	sw	x4, 0(x3)	# [1552] create_array (length + 1) net
	addi	x3, x3, 1	# [1553] create_array (length + 1) net
	jal	x0, -3	# [1554] create_array (length + 1) net
	jalr	x0, x1, 0	# [1555] create_array (length + 1) net
# bne:	let v = read_or_network (length + 1) in (v.(length) <- net; v)
	lw	x5, 0(x2)	# [1556] length + 1
	addi	x6, x5, 1	# [1557] length + 1
	sw	x4, 1(x2)	# [1558] read_or_network (length + 1)
	# let v = read_or_network (length + 1)
	addi	x4, x6, 0	# [1559] read_or_network (length + 1)
	sw	x1, 2(x2)	# [1560] read_or_network (length + 1)
	addi	x2, x2, 3	# [1561] read_or_network (length + 1)
	jal	x1, -25	# [1562] read_or_network (length + 1)
	addi	x2, x2, -3	# [1563] read_or_network (length + 1)
	lw	x1, 2(x2)	# [1564] read_or_network (length + 1)
	lw	x5, 0(x2)	# [1565] v.(length) <- net
	lw	x6, 1(x2)	# [1566] v.(length) <- net
	add	x31, x4, x5	# [1567] v.(length) <- net
	sw	x6, 0(x31)	# [1568] v.(length) <- net
	jalr	x0, x1, 0	# [1569] v
# read_and_network.3051:	let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	addi	x5, x0, 0	# [1570] 0
	sw	x4, 0(x2)	# [1571] read_net_item 0
	# let net = read_net_item 0
	addi	x4, x5, 0	# [1572] read_net_item 0
	sw	x1, 1(x2)	# [1573] read_net_item 0
	addi	x2, x2, 2	# [1574] read_net_item 0
	jal	x1, -72	# [1575] read_net_item 0
	addi	x2, x2, -2	# [1576] read_net_item 0
	lw	x1, 1(x2)	# [1577] read_net_item 0
	lw	x5, 0(x4)	# [1578] net.(0)
	addi	x6, x0, -1	# [1579] -1
	bne	x5, x6, 2	# [1580] if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
# beq:	()
	jalr x0, x1, 0	# [1581] ()
# bne:	and_net.(n) <- net; read_and_network (n + 1)
	lui	x5, 256	# [1582] and_net
	addi	x5, x5, 120	# [1583] and_net
	lw	x6, 0(x2)	# [1584] and_net.(n) <- net
	add	x31, x5, x6	# [1585] and_net.(n) <- net
	sw	x4, 0(x31)	# [1586] and_net.(n) <- net
	addi	x4, x6, 1	# [1587] n + 1
	jal	x0, -18	# [1588] read_and_network (n + 1)
# read_parameter.3053:	let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x1, 0(x2)	# [1589] read_screen_settings()
	addi	x2, x2, 1	# [1590] read_screen_settings()
	jal	x1, -1344	# [1591] read_screen_settings()
	addi	x2, x2, -1	# [1592] read_screen_settings()
	lw	x1, 0(x2)	# [1593] read_screen_settings()
	addi	x0, x4, 0	# [1594] read_screen_settings()
	sw	x1, 0(x2)	# [1595] read_light()
	addi	x2, x2, 1	# [1596] read_light()
	jal	x1, -1055	# [1597] read_light()
	addi	x2, x2, -1	# [1598] read_light()
	lw	x1, 0(x2)	# [1599] read_light()
	addi	x0, x4, 0	# [1600] read_light()
	sw	x1, 0(x2)	# [1601] read_all_object ()
	addi	x2, x2, 1	# [1602] read_all_object ()
	jal	x1, -102	# [1603] read_all_object ()
	addi	x2, x2, -1	# [1604] read_all_object ()
	lw	x1, 0(x2)	# [1605] read_all_object ()
	addi	x0, x4, 0	# [1606] read_all_object ()
	addi	x4, x0, 0	# [1607] 0
	sw	x1, 0(x2)	# [1608] read_and_network 0
	addi	x2, x2, 1	# [1609] read_and_network 0
	jal	x1, -40	# [1610] read_and_network 0
	addi	x2, x2, -1	# [1611] read_and_network 0
	lw	x1, 0(x2)	# [1612] read_and_network 0
	addi	x0, x4, 0	# [1613] read_and_network 0
	lui	x4, 256	# [1614] or_net
	addi	x4, x4, 121	# [1615] or_net
	addi	x5, x0, 0	# [1616] 0
	sw	x4, 0(x2)	# [1617] read_or_network 0
	addi	x4, x5, 0	# [1618] read_or_network 0
	sw	x1, 1(x2)	# [1619] read_or_network 0
	addi	x2, x2, 2	# [1620] read_or_network 0
	jal	x1, -84	# [1621] read_or_network 0
	addi	x2, x2, -2	# [1622] read_or_network 0
	lw	x1, 1(x2)	# [1623] read_or_network 0
	lw	x5, 0(x2)	# [1624] or_net.(0) <- read_or_network 0
	sw	x4, 0(x5)	# [1625] or_net.(0) <- read_or_network 0
	jalr x0, x1, 0	# [1626] or_net.(0) <- read_or_network 0
# solver_rect_surface.3055:	let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	add	x31, x5, x6	# [1627] dirvec.(i0)
	flw	f4, 0(x31)	# [1628] dirvec.(i0)
	feq	x9, f4, f0	# [1629] fiszero dirvec.(i0)
	bne	x9, x0, 75	# [1630] if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
# beq:	let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	fsw	f3, 0(x2)	# [1631] o_param_abc m
	sw	x8, 1(x2)	# [1632] o_param_abc m
	fsw	f2, 2(x2)	# [1633] o_param_abc m
	sw	x7, 3(x2)	# [1634] o_param_abc m
	fsw	f1, 4(x2)	# [1635] o_param_abc m
	sw	x6, 5(x2)	# [1636] o_param_abc m
	sw	x5, 6(x2)	# [1637] o_param_abc m
	sw	x4, 7(x2)	# [1638] o_param_abc m
	# let abc = o_param_abc m
	sw	x1, 8(x2)	# [1639] o_param_abc m
	addi	x2, x2, 9	# [1640] o_param_abc m
	jal	x1, -1466	# [1641] o_param_abc m
	addi	x2, x2, -9	# [1642] o_param_abc m
	lw	x1, 8(x2)	# [1643] o_param_abc m
	lw	x5, 7(x2)	# [1644] o_isinvert m
	sw	x4, 8(x2)	# [1645] o_isinvert m
	addi	x4, x5, 0	# [1646] o_isinvert m
	sw	x1, 9(x2)	# [1647] o_isinvert m
	addi	x2, x2, 10	# [1648] o_isinvert m
	jal	x1, -1487	# [1649] o_isinvert m
	addi	x2, x2, -10	# [1650] o_isinvert m
	lw	x1, 9(x2)	# [1651] o_isinvert m
	lw	x5, 5(x2)	# [1652] dirvec.(i0)
	lw	x6, 6(x2)	# [1653] dirvec.(i0)
	add	x31, x6, x5	# [1654] dirvec.(i0)
	flw	f1, 0(x31)	# [1655] dirvec.(i0)
	flt	x7, f1, f0	# [1656] fisneg dirvec.(i0)
	xor	x4, x4, x7	# [1657] xor (o_isinvert m) (fisneg dirvec.(i0))
	lw	x7, 8(x2)	# [1658] abc.(i0)
	add	x31, x7, x5	# [1659] abc.(i0)
	flw	f1, 0(x31)	# [1660] abc.(i0)
	# let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	sw	x1, 9(x2)	# [1661] fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	addi	x2, x2, 10	# [1662] fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	jal	x1, -1646	# [1663] fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	addi	x2, x2, -10	# [1664] fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	lw	x1, 9(x2)	# [1665] fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	flw	f2, 4(x2)	# [1666] d -. b0
	fsub	f1, f1, f2	# [1667] d -. b0
	lw	x4, 5(x2)	# [1668] dirvec.(i0)
	lw	x5, 6(x2)	# [1669] dirvec.(i0)
	add	x31, x5, x4	# [1670] dirvec.(i0)
	flw	f2, 0(x31)	# [1671] dirvec.(i0)
	# let d2 = (d -. b0) /. dirvec.(i0)
	fdiv	f1, f1, f2	# [1672] (d -. b0) /. dirvec.(i0)
	lw	x4, 3(x2)	# [1673] dirvec.(i1)
	add	x31, x5, x4	# [1674] dirvec.(i1)
	flw	f2, 0(x31)	# [1675] dirvec.(i1)
	fmul	f2, f1, f2	# [1676] d2 *. dirvec.(i1)
	flw	f3, 2(x2)	# [1677] d2 *. dirvec.(i1) +. b1
	fadd	f2, f2, f3	# [1678] d2 *. dirvec.(i1) +. b1
	fabs	f2, f2	# [1679] fabs (d2 *. dirvec.(i1) +. b1)
	lw	x6, 8(x2)	# [1680] abc.(i1)
	add	x31, x6, x4	# [1681] abc.(i1)
	flw	f3, 0(x31)	# [1682] abc.(i1)
	flt	x4, f2, f3	# [1683] fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1)
	bne	x4, x0, 3	# [1684] if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
# beq:	false
	addi	x4, x0, 0	# [1685] false
	jalr	x0, x1, 0	# [1686] false
# bne:	if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false
	lw	x4, 1(x2)	# [1687] dirvec.(i2)
	add	x31, x5, x4	# [1688] dirvec.(i2)
	flw	f2, 0(x31)	# [1689] dirvec.(i2)
	fmul	f2, f1, f2	# [1690] d2 *. dirvec.(i2)
	flw	f3, 0(x2)	# [1691] d2 *. dirvec.(i2) +. b2
	fadd	f2, f2, f3	# [1692] d2 *. dirvec.(i2) +. b2
	fabs	f2, f2	# [1693] fabs (d2 *. dirvec.(i2) +. b2)
	add	x31, x6, x4	# [1694] abc.(i2)
	flw	f3, 0(x31)	# [1695] abc.(i2)
	flt	x4, f2, f3	# [1696] fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2)
	bne	x4, x0, 3	# [1697] if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false
# beq:	false
	addi	x4, x0, 0	# [1698] false
	jalr	x0, x1, 0	# [1699] false
# bne:	solver_dist.(0) <- d2; true
	lui	x4, 256	# [1700] solver_dist
	addi	x4, x4, 122	# [1701] solver_dist
	fsw	f1, 0(x4)	# [1702] solver_dist.(0) <- d2
	addi	x4, x0, 1	# [1703] true
	jalr	x0, x1, 0	# [1704] true
# bne:	false
	addi	x4, x0, 0	# [1705] false
	jalr	x0, x1, 0	# [1706] false
# solver_rect.3064:	let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x6, x0, 0	# [1707] 0
	addi	x7, x0, 1	# [1708] 1
	addi	x8, x0, 2	# [1709] 2
	fsw	f1, 0(x2)	# [1710] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	fsw	f3, 1(x2)	# [1711] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	fsw	f2, 2(x2)	# [1712] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	sw	x5, 3(x2)	# [1713] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	sw	x4, 4(x2)	# [1714] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	sw	x1, 5(x2)	# [1715] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	addi	x2, x2, 6	# [1716] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	jal	x1, -90	# [1717] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	addi	x2, x2, -6	# [1718] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	lw	x1, 5(x2)	# [1719] solver_rect_surface m dirvec b0 b1 b2 0 1 2
	bne	x4, x0, 35	# [1720] if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
# beq:	if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x6, x0, 1	# [1721] 1
	addi	x7, x0, 2	# [1722] 2
	addi	x8, x0, 0	# [1723] 0
	flw	f1, 2(x2)	# [1724] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	flw	f2, 1(x2)	# [1725] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	flw	f3, 0(x2)	# [1726] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x4, 4(x2)	# [1727] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x5, 3(x2)	# [1728] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	sw	x1, 5(x2)	# [1729] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	addi	x2, x2, 6	# [1730] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	jal	x1, -104	# [1731] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	addi	x2, x2, -6	# [1732] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x1, 5(x2)	# [1733] solver_rect_surface m dirvec b1 b2 b0 1 2 0
	bne	x4, x0, 19	# [1734] if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
# beq:	if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x6, x0, 2	# [1735] 2
	addi	x7, x0, 0	# [1736] 0
	addi	x8, x0, 1	# [1737] 1
	flw	f1, 1(x2)	# [1738] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	flw	f2, 0(x2)	# [1739] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	flw	f3, 2(x2)	# [1740] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x4, 4(x2)	# [1741] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x5, 3(x2)	# [1742] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	sw	x1, 5(x2)	# [1743] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	addi	x2, x2, 6	# [1744] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	jal	x1, -118	# [1745] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	addi	x2, x2, -6	# [1746] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x1, 5(x2)	# [1747] solver_rect_surface m dirvec b2 b0 b1 2 0 1
	bne	x4, x0, 3	# [1748] if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
# beq:	0
	addi	x4, x0, 0	# [1749] 0
	jalr	x0, x1, 0	# [1750] 0
# bne:	3
	addi	x4, x0, 3	# [1751] 3
	jalr	x0, x1, 0	# [1752] 3
# bne:	2
	addi	x4, x0, 2	# [1753] 2
	jalr	x0, x1, 0	# [1754] 2
# bne:	1
	addi	x4, x0, 1	# [1755] 1
	jalr	x0, x1, 0	# [1756] 1
# solver_surface.3070:	let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	fsw	f3, 0(x2)	# [1757] o_param_abc m
	fsw	f2, 1(x2)	# [1758] o_param_abc m
	fsw	f1, 2(x2)	# [1759] o_param_abc m
	sw	x5, 3(x2)	# [1760] o_param_abc m
	# let abc = o_param_abc m
	sw	x1, 4(x2)	# [1761] o_param_abc m
	addi	x2, x2, 5	# [1762] o_param_abc m
	jal	x1, -1588	# [1763] o_param_abc m
	addi	x2, x2, -5	# [1764] o_param_abc m
	lw	x1, 4(x2)	# [1765] o_param_abc m
	addi	x5, x4, 0	# [1766] o_param_abc m
	lw	x4, 3(x2)	# [1767] veciprod dirvec abc
	sw	x5, 4(x2)	# [1768] veciprod dirvec abc
	# let d = veciprod dirvec abc
	sw	x1, 5(x2)	# [1769] veciprod dirvec abc
	addi	x2, x2, 6	# [1770] veciprod dirvec abc
	jal	x1, -1694	# [1771] veciprod dirvec abc
	addi	x2, x2, -6	# [1772] veciprod dirvec abc
	lw	x1, 5(x2)	# [1773] veciprod dirvec abc
	flt	x4, f0, f1	# [1774] fispos d
	bne	x4, x0, 3	# [1775] if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
# beq:	0
	addi	x4, x0, 0	# [1776] 0
	jalr	x0, x1, 0	# [1777] 0
# bne:	solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1
	lui	x4, 256	# [1778] solver_dist
	addi	x4, x4, 122	# [1779] solver_dist
	flw	f2, 2(x2)	# [1780] veciprod2 abc b0 b1 b2
	flw	f3, 1(x2)	# [1781] veciprod2 abc b0 b1 b2
	flw	f4, 0(x2)	# [1782] veciprod2 abc b0 b1 b2
	lw	x5, 4(x2)	# [1783] veciprod2 abc b0 b1 b2
	sw	x4, 5(x2)	# [1784] veciprod2 abc b0 b1 b2
	fsw	f1, 6(x2)	# [1785] veciprod2 abc b0 b1 b2
	addi	x4, x5, 0	# [1786] veciprod2 abc b0 b1 b2
	fmv	f1, f2	# [1787] veciprod2 abc b0 b1 b2
	fmv	f2, f3	# [1788] veciprod2 abc b0 b1 b2
	fmv	f3, f4	# [1789] veciprod2 abc b0 b1 b2
	sw	x1, 7(x2)	# [1790] veciprod2 abc b0 b1 b2
	addi	x2, x2, 8	# [1791] veciprod2 abc b0 b1 b2
	jal	x1, -1703	# [1792] veciprod2 abc b0 b1 b2
	addi	x2, x2, -8	# [1793] veciprod2 abc b0 b1 b2
	lw	x1, 7(x2)	# [1794] veciprod2 abc b0 b1 b2
	fneg	f1, f1	# [1795] fneg (veciprod2 abc b0 b1 b2)
	flw	f2, 6(x2)	# [1796] fneg (veciprod2 abc b0 b1 b2) /. d
	fdiv	f1, f1, f2	# [1797] fneg (veciprod2 abc b0 b1 b2) /. d
	lw	x4, 5(x2)	# [1798] solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d
	fsw	f1, 0(x4)	# [1799] solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d
	addi	x4, x0, 1	# [1800] 1
	jalr	x0, x1, 0	# [1801] 1
# quadratic.3076:	let rec quadratic m v0 v1 v2 = let diag_part = fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m in if o_isrot m = 0 then diag_part else diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	fmul	f4, f1, f1	# [1802] fsqr v0
	fsw	f1, 0(x2)	# [1803] o_param_a m
	fsw	f3, 1(x2)	# [1804] o_param_a m
	sw	x4, 2(x2)	# [1805] o_param_a m
	fsw	f2, 3(x2)	# [1806] o_param_a m
	fsw	f4, 4(x2)	# [1807] o_param_a m
	sw	x1, 5(x2)	# [1808] o_param_a m
	addi	x2, x2, 6	# [1809] o_param_a m
	jal	x1, -1644	# [1810] o_param_a m
	addi	x2, x2, -6	# [1811] o_param_a m
	lw	x1, 5(x2)	# [1812] o_param_a m
	flw	f2, 4(x2)	# [1813] fsqr v0 *. o_param_a m
	fmul	f1, f2, f1	# [1814] fsqr v0 *. o_param_a m
	flw	f2, 3(x2)	# [1815] fsqr v1
	fmul	f3, f2, f2	# [1816] fsqr v1
	lw	x4, 2(x2)	# [1817] o_param_b m
	fsw	f1, 5(x2)	# [1818] o_param_b m
	fsw	f3, 6(x2)	# [1819] o_param_b m
	sw	x1, 7(x2)	# [1820] o_param_b m
	addi	x2, x2, 8	# [1821] o_param_b m
	jal	x1, -1653	# [1822] o_param_b m
	addi	x2, x2, -8	# [1823] o_param_b m
	lw	x1, 7(x2)	# [1824] o_param_b m
	flw	f2, 6(x2)	# [1825] fsqr v1 *. o_param_b m
	fmul	f1, f2, f1	# [1826] fsqr v1 *. o_param_b m
	flw	f2, 5(x2)	# [1827] fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m
	fadd	f1, f2, f1	# [1828] fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m
	flw	f2, 1(x2)	# [1829] fsqr v2
	fmul	f3, f2, f2	# [1830] fsqr v2
	lw	x4, 2(x2)	# [1831] o_param_c m
	fsw	f1, 7(x2)	# [1832] o_param_c m
	fsw	f3, 8(x2)	# [1833] o_param_c m
	sw	x1, 9(x2)	# [1834] o_param_c m
	addi	x2, x2, 10	# [1835] o_param_c m
	jal	x1, -1664	# [1836] o_param_c m
	addi	x2, x2, -10	# [1837] o_param_c m
	lw	x1, 9(x2)	# [1838] o_param_c m
	flw	f2, 8(x2)	# [1839] fsqr v2 *. o_param_c m
	fmul	f1, f2, f1	# [1840] fsqr v2 *. o_param_c m
	flw	f2, 7(x2)	# [1841] fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m
	# let diag_part = fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m
	fadd	f1, f2, f1	# [1842] fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m
	lw	x4, 2(x2)	# [1843] o_isrot m
	fsw	f1, 9(x2)	# [1844] o_isrot m
	sw	x1, 10(x2)	# [1845] o_isrot m
	addi	x2, x2, 11	# [1846] o_isrot m
	jal	x1, -1683	# [1847] o_isrot m
	addi	x2, x2, -11	# [1848] o_isrot m
	lw	x1, 10(x2)	# [1849] o_isrot m
	bne	x4, x0, 3	# [1850] if o_isrot m = 0 then diag_part else diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
# beq:	diag_part
	flw	f1, 9(x2)	# [1851] diag_part
	jalr	x0, x1, 0	# [1852] diag_part
# bne:	diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	flw	f1, 1(x2)	# [1853] v1 *. v2
	flw	f2, 3(x2)	# [1854] v1 *. v2
	fmul	f3, f2, f1	# [1855] v1 *. v2
	lw	x4, 2(x2)	# [1856] o_param_r1 m
	fsw	f3, 10(x2)	# [1857] o_param_r1 m
	sw	x1, 11(x2)	# [1858] o_param_r1 m
	addi	x2, x2, 12	# [1859] o_param_r1 m
	jal	x1, -1659	# [1860] o_param_r1 m
	addi	x2, x2, -12	# [1861] o_param_r1 m
	lw	x1, 11(x2)	# [1862] o_param_r1 m
	flw	f2, 10(x2)	# [1863] v1 *. v2 *. o_param_r1 m
	fmul	f1, f2, f1	# [1864] v1 *. v2 *. o_param_r1 m
	flw	f2, 9(x2)	# [1865] diag_part +. v1 *. v2 *. o_param_r1 m
	fadd	f1, f2, f1	# [1866] diag_part +. v1 *. v2 *. o_param_r1 m
	flw	f2, 0(x2)	# [1867] v2 *. v0
	flw	f3, 1(x2)	# [1868] v2 *. v0
	fmul	f3, f3, f2	# [1869] v2 *. v0
	lw	x4, 2(x2)	# [1870] o_param_r2 m
	fsw	f1, 11(x2)	# [1871] o_param_r2 m
	fsw	f3, 12(x2)	# [1872] o_param_r2 m
	sw	x1, 13(x2)	# [1873] o_param_r2 m
	addi	x2, x2, 14	# [1874] o_param_r2 m
	jal	x1, -1671	# [1875] o_param_r2 m
	addi	x2, x2, -14	# [1876] o_param_r2 m
	lw	x1, 13(x2)	# [1877] o_param_r2 m
	flw	f2, 12(x2)	# [1878] v2 *. v0 *. o_param_r2 m
	fmul	f1, f2, f1	# [1879] v2 *. v0 *. o_param_r2 m
	flw	f2, 11(x2)	# [1880] diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m
	fadd	f1, f2, f1	# [1881] diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m
	flw	f2, 3(x2)	# [1882] v0 *. v1
	flw	f3, 0(x2)	# [1883] v0 *. v1
	fmul	f2, f3, f2	# [1884] v0 *. v1
	lw	x4, 2(x2)	# [1885] o_param_r3 m
	fsw	f1, 13(x2)	# [1886] o_param_r3 m
	fsw	f2, 14(x2)	# [1887] o_param_r3 m
	sw	x1, 15(x2)	# [1888] o_param_r3 m
	addi	x2, x2, 16	# [1889] o_param_r3 m
	jal	x1, -1683	# [1890] o_param_r3 m
	addi	x2, x2, -16	# [1891] o_param_r3 m
	lw	x1, 15(x2)	# [1892] o_param_r3 m
	flw	f2, 14(x2)	# [1893] v0 *. v1 *. o_param_r3 m
	fmul	f1, f2, f1	# [1894] v0 *. v1 *. o_param_r3 m
	flw	f2, 13(x2)	# [1895] diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	fadd	f1, f2, f1	# [1896] diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	jalr	x0, x1, 0	# [1897] diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
# bilinear.3081:	let rec bilinear m v0 v1 v2 w0 w1 w2 = let diag_part = v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m in if o_isrot m = 0 then diag_part else diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	fmul	f7, f1, f4	# [1898] v0 *. w0
	fsw	f4, 0(x2)	# [1899] o_param_a m
	fsw	f1, 1(x2)	# [1900] o_param_a m
	fsw	f6, 2(x2)	# [1901] o_param_a m
	fsw	f3, 3(x2)	# [1902] o_param_a m
	sw	x4, 4(x2)	# [1903] o_param_a m
	fsw	f5, 5(x2)	# [1904] o_param_a m
	fsw	f2, 6(x2)	# [1905] o_param_a m
	fsw	f7, 7(x2)	# [1906] o_param_a m
	sw	x1, 8(x2)	# [1907] o_param_a m
	addi	x2, x2, 9	# [1908] o_param_a m
	jal	x1, -1743	# [1909] o_param_a m
	addi	x2, x2, -9	# [1910] o_param_a m
	lw	x1, 8(x2)	# [1911] o_param_a m
	flw	f2, 7(x2)	# [1912] v0 *. w0 *. o_param_a m
	fmul	f1, f2, f1	# [1913] v0 *. w0 *. o_param_a m
	flw	f2, 5(x2)	# [1914] v1 *. w1
	flw	f3, 6(x2)	# [1915] v1 *. w1
	fmul	f4, f3, f2	# [1916] v1 *. w1
	lw	x4, 4(x2)	# [1917] o_param_b m
	fsw	f1, 8(x2)	# [1918] o_param_b m
	fsw	f4, 9(x2)	# [1919] o_param_b m
	sw	x1, 10(x2)	# [1920] o_param_b m
	addi	x2, x2, 11	# [1921] o_param_b m
	jal	x1, -1753	# [1922] o_param_b m
	addi	x2, x2, -11	# [1923] o_param_b m
	lw	x1, 10(x2)	# [1924] o_param_b m
	flw	f2, 9(x2)	# [1925] v1 *. w1 *. o_param_b m
	fmul	f1, f2, f1	# [1926] v1 *. w1 *. o_param_b m
	flw	f2, 8(x2)	# [1927] v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m
	fadd	f1, f2, f1	# [1928] v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m
	flw	f2, 2(x2)	# [1929] v2 *. w2
	flw	f3, 3(x2)	# [1930] v2 *. w2
	fmul	f4, f3, f2	# [1931] v2 *. w2
	lw	x4, 4(x2)	# [1932] o_param_c m
	fsw	f1, 10(x2)	# [1933] o_param_c m
	fsw	f4, 11(x2)	# [1934] o_param_c m
	sw	x1, 12(x2)	# [1935] o_param_c m
	addi	x2, x2, 13	# [1936] o_param_c m
	jal	x1, -1765	# [1937] o_param_c m
	addi	x2, x2, -13	# [1938] o_param_c m
	lw	x1, 12(x2)	# [1939] o_param_c m
	flw	f2, 11(x2)	# [1940] v2 *. w2 *. o_param_c m
	fmul	f1, f2, f1	# [1941] v2 *. w2 *. o_param_c m
	flw	f2, 10(x2)	# [1942] v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m
	# let diag_part = v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m
	fadd	f1, f2, f1	# [1943] v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m
	lw	x4, 4(x2)	# [1944] o_isrot m
	fsw	f1, 12(x2)	# [1945] o_isrot m
	sw	x1, 13(x2)	# [1946] o_isrot m
	addi	x2, x2, 14	# [1947] o_isrot m
	jal	x1, -1784	# [1948] o_isrot m
	addi	x2, x2, -14	# [1949] o_isrot m
	lw	x1, 13(x2)	# [1950] o_isrot m
	bne	x4, x0, 3	# [1951] if o_isrot m = 0 then diag_part else diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
# beq:	diag_part
	flw	f1, 12(x2)	# [1952] diag_part
	jalr	x0, x1, 0	# [1953] diag_part
# bne:	diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	flw	f1, 5(x2)	# [1954] v2 *. w1
	flw	f2, 3(x2)	# [1955] v2 *. w1
	fmul	f3, f2, f1	# [1956] v2 *. w1
	flw	f4, 2(x2)	# [1957] v1 *. w2
	flw	f5, 6(x2)	# [1958] v1 *. w2
	fmul	f6, f5, f4	# [1959] v1 *. w2
	fadd	f3, f3, f6	# [1960] v2 *. w1 +. v1 *. w2
	lw	x4, 4(x2)	# [1961] o_param_r1 m
	fsw	f3, 13(x2)	# [1962] o_param_r1 m
	sw	x1, 14(x2)	# [1963] o_param_r1 m
	addi	x2, x2, 15	# [1964] o_param_r1 m
	jal	x1, -1764	# [1965] o_param_r1 m
	addi	x2, x2, -15	# [1966] o_param_r1 m
	lw	x1, 14(x2)	# [1967] o_param_r1 m
	flw	f2, 13(x2)	# [1968] (v2 *. w1 +. v1 *. w2) *. o_param_r1 m
	fmul	f1, f2, f1	# [1969] (v2 *. w1 +. v1 *. w2) *. o_param_r1 m
	flw	f2, 2(x2)	# [1970] v0 *. w2
	flw	f3, 1(x2)	# [1971] v0 *. w2
	fmul	f2, f3, f2	# [1972] v0 *. w2
	flw	f4, 0(x2)	# [1973] v2 *. w0
	flw	f5, 3(x2)	# [1974] v2 *. w0
	fmul	f5, f5, f4	# [1975] v2 *. w0
	fadd	f2, f2, f5	# [1976] v0 *. w2 +. v2 *. w0
	lw	x4, 4(x2)	# [1977] o_param_r2 m
	fsw	f1, 14(x2)	# [1978] o_param_r2 m
	fsw	f2, 15(x2)	# [1979] o_param_r2 m
	sw	x1, 16(x2)	# [1980] o_param_r2 m
	addi	x2, x2, 17	# [1981] o_param_r2 m
	jal	x1, -1778	# [1982] o_param_r2 m
	addi	x2, x2, -17	# [1983] o_param_r2 m
	lw	x1, 16(x2)	# [1984] o_param_r2 m
	flw	f2, 15(x2)	# [1985] (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	fmul	f1, f2, f1	# [1986] (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	flw	f2, 14(x2)	# [1987] (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	fadd	f1, f2, f1	# [1988] (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	flw	f2, 5(x2)	# [1989] v0 *. w1
	flw	f3, 1(x2)	# [1990] v0 *. w1
	fmul	f2, f3, f2	# [1991] v0 *. w1
	flw	f3, 0(x2)	# [1992] v1 *. w0
	flw	f4, 6(x2)	# [1993] v1 *. w0
	fmul	f3, f4, f3	# [1994] v1 *. w0
	fadd	f2, f2, f3	# [1995] v0 *. w1 +. v1 *. w0
	lw	x4, 4(x2)	# [1996] o_param_r3 m
	fsw	f1, 16(x2)	# [1997] o_param_r3 m
	fsw	f2, 17(x2)	# [1998] o_param_r3 m
	sw	x1, 18(x2)	# [1999] o_param_r3 m
	addi	x2, x2, 19	# [2000] o_param_r3 m
	jal	x1, -1794	# [2001] o_param_r3 m
	addi	x2, x2, -19	# [2002] o_param_r3 m
	lw	x1, 18(x2)	# [2003] o_param_r3 m
	flw	f2, 17(x2)	# [2004] (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	fmul	f1, f2, f1	# [2005] (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	flw	f2, 16(x2)	# [2006] (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	fadd	f1, f2, f1	# [2007] (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	fmul	f1, f1, f27	# [2008] fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	flw	f2, 12(x2)	# [2009] diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	fadd	f1, f2, f1	# [2010] diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	jalr	x0, x1, 0	# [2011] diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
# solver_second.3089:	let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	flw	f4, 0(x5)	# [2012] dirvec.(0)
	flw	f5, 1(x5)	# [2013] dirvec.(1)
	flw	f6, 2(x5)	# [2014] dirvec.(2)
	fsw	f3, 0(x2)	# [2015] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fsw	f2, 1(x2)	# [2016] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fsw	f1, 2(x2)	# [2017] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	sw	x4, 3(x2)	# [2018] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	sw	x5, 4(x2)	# [2019] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	# let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fmv	f3, f6	# [2020] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fmv	f2, f5	# [2021] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fmv	f1, f4	# [2022] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	sw	x1, 5(x2)	# [2023] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	addi	x2, x2, 6	# [2024] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	jal	x1, -223	# [2025] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	addi	x2, x2, -6	# [2026] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	lw	x1, 5(x2)	# [2027] quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	feq	x4, f1, f0	# [2028] fiszero aa
	bne	x4, x0, 78	# [2029] if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
# beq:	let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0
	lw	x4, 4(x2)	# [2030] dirvec.(0)
	flw	f2, 0(x4)	# [2031] dirvec.(0)
	flw	f3, 1(x4)	# [2032] dirvec.(1)
	flw	f4, 2(x4)	# [2033] dirvec.(2)
	flw	f5, 2(x2)	# [2034] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	flw	f6, 1(x2)	# [2035] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	flw	f7, 0(x2)	# [2036] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	lw	x4, 3(x2)	# [2037] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fsw	f1, 5(x2)	# [2038] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	# let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f1, f2	# [2039] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f2, f3	# [2040] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f3, f4	# [2041] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f4, f5	# [2042] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f5, f6	# [2043] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f6, f7	# [2044] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	sw	x1, 6(x2)	# [2045] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	addi	x2, x2, 7	# [2046] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	jal	x1, -149	# [2047] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	addi	x2, x2, -7	# [2048] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	lw	x1, 6(x2)	# [2049] bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	flw	f2, 2(x2)	# [2050] quadratic m b0 b1 b2
	flw	f3, 1(x2)	# [2051] quadratic m b0 b1 b2
	flw	f4, 0(x2)	# [2052] quadratic m b0 b1 b2
	lw	x4, 3(x2)	# [2053] quadratic m b0 b1 b2
	fsw	f1, 6(x2)	# [2054] quadratic m b0 b1 b2
	# let cc0 = quadratic m b0 b1 b2
	fmv	f1, f2	# [2055] quadratic m b0 b1 b2
	fmv	f2, f3	# [2056] quadratic m b0 b1 b2
	fmv	f3, f4	# [2057] quadratic m b0 b1 b2
	sw	x1, 7(x2)	# [2058] quadratic m b0 b1 b2
	addi	x2, x2, 8	# [2059] quadratic m b0 b1 b2
	jal	x1, -258	# [2060] quadratic m b0 b1 b2
	addi	x2, x2, -8	# [2061] quadratic m b0 b1 b2
	lw	x1, 7(x2)	# [2062] quadratic m b0 b1 b2
	lw	x4, 3(x2)	# [2063] o_form m
	fsw	f1, 7(x2)	# [2064] o_form m
	sw	x1, 8(x2)	# [2065] o_form m
	addi	x2, x2, 9	# [2066] o_form m
	jal	x1, -1909	# [2067] o_form m
	addi	x2, x2, -9	# [2068] o_form m
	lw	x1, 8(x2)	# [2069] o_form m
	addi	x5, x0, 3	# [2070] 3
	# let cc = if o_form m = 3 then cc0 -. 1.0 else cc0
	bne	x4, x5, 4	# [2071] if o_form m = 3 then cc0 -. 1.0 else cc0
# beq:	cc0 -. 1.0
	flw	f1, 7(x2)	# [2072] cc0 -. 1.0
	fsub	f1, f1, f11	# [2073] cc0 -. 1.0
	jal	x0, 2	# [2074] if o_form m = 3 then cc0 -. 1.0 else cc0
# bne:	cc0
	flw	f1, 7(x2)	# [2075] cc0
# cont:	if o_form m = 3 then cc0 -. 1.0 else cc0
	flw	f2, 6(x2)	# [2076] fsqr bb
	fmul	f3, f2, f2	# [2077] fsqr bb
	flw	f4, 5(x2)	# [2078] aa *. cc
	fmul	f1, f4, f1	# [2079] aa *. cc
	# let d = fsqr bb -. aa *. cc
	fsub	f1, f3, f1	# [2080] fsqr bb -. aa *. cc
	flt	x4, f0, f1	# [2081] fispos d
	bne	x4, x0, 3	# [2082] if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0
# beq:	0
	addi	x4, x0, 0	# [2083] 0
	jalr	x0, x1, 0	# [2084] 0
# bne:	let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1)
	# let sd = sqrt d
	fsqrt	f1, f1	# [2085] sqrt d
	lw	x4, 3(x2)	# [2086] o_isinvert m
	fsw	f1, 8(x2)	# [2087] o_isinvert m
	sw	x1, 9(x2)	# [2088] o_isinvert m
	addi	x2, x2, 10	# [2089] o_isinvert m
	jal	x1, -1928	# [2090] o_isinvert m
	addi	x2, x2, -10	# [2091] o_isinvert m
	lw	x1, 9(x2)	# [2092] o_isinvert m
	# let t1 = if o_isinvert m then sd else fneg sd
	bne	x4, x0, 4	# [2093] if o_isinvert m then sd else fneg sd
# beq:	fneg sd
	flw	f1, 8(x2)	# [2094] fneg sd
	fneg	f1, f1	# [2095] fneg sd
	jal	x0, 2	# [2096] if o_isinvert m then sd else fneg sd
# bne:	sd
	flw	f1, 8(x2)	# [2097] sd
# cont:	if o_isinvert m then sd else fneg sd
	lui	x4, 256	# [2098] solver_dist
	addi	x4, x4, 122	# [2099] solver_dist
	flw	f2, 6(x2)	# [2100] t1 -. bb
	fsub	f1, f1, f2	# [2101] t1 -. bb
	flw	f2, 5(x2)	# [2102] (t1 -. bb) /. aa
	fdiv	f1, f1, f2	# [2103] (t1 -. bb) /. aa
	fsw	f1, 0(x4)	# [2104] solver_dist.(0) <- (t1 -. bb) /. aa
	addi	x4, x0, 1	# [2105] 1
	jalr	x0, x1, 0	# [2106] 1
# bne:	0
	addi	x4, x0, 0	# [2107] 0
	jalr	x0, x1, 0	# [2108] 0
# solver.3095:	let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	lui	x7, 256	# [2109] objects
	addi	x7, x7, 60	# [2110] objects
	# let m = objects.(index)
	add	x31, x7, x4	# [2111] objects.(index)
	lw	x4, 0(x31)	# [2112] objects.(index)
	flw	f1, 0(x6)	# [2113] org.(0)
	sw	x5, 0(x2)	# [2114] o_param_x m
	sw	x4, 1(x2)	# [2115] o_param_x m
	sw	x6, 2(x2)	# [2116] o_param_x m
	fsw	f1, 3(x2)	# [2117] o_param_x m
	sw	x1, 4(x2)	# [2118] o_param_x m
	addi	x2, x2, 5	# [2119] o_param_x m
	jal	x1, -1943	# [2120] o_param_x m
	addi	x2, x2, -5	# [2121] o_param_x m
	lw	x1, 4(x2)	# [2122] o_param_x m
	flw	f2, 3(x2)	# [2123] org.(0) -. o_param_x m
	# let b0 = org.(0) -. o_param_x m
	fsub	f1, f2, f1	# [2124] org.(0) -. o_param_x m
	lw	x4, 2(x2)	# [2125] org.(1)
	flw	f2, 1(x4)	# [2126] org.(1)
	lw	x5, 1(x2)	# [2127] o_param_y m
	fsw	f1, 4(x2)	# [2128] o_param_y m
	fsw	f2, 5(x2)	# [2129] o_param_y m
	addi	x4, x5, 0	# [2130] o_param_y m
	sw	x1, 6(x2)	# [2131] o_param_y m
	addi	x2, x2, 7	# [2132] o_param_y m
	jal	x1, -1953	# [2133] o_param_y m
	addi	x2, x2, -7	# [2134] o_param_y m
	lw	x1, 6(x2)	# [2135] o_param_y m
	flw	f2, 5(x2)	# [2136] org.(1) -. o_param_y m
	# let b1 = org.(1) -. o_param_y m
	fsub	f1, f2, f1	# [2137] org.(1) -. o_param_y m
	lw	x4, 2(x2)	# [2138] org.(2)
	flw	f2, 2(x4)	# [2139] org.(2)
	lw	x4, 1(x2)	# [2140] o_param_z m
	fsw	f1, 6(x2)	# [2141] o_param_z m
	fsw	f2, 7(x2)	# [2142] o_param_z m
	sw	x1, 8(x2)	# [2143] o_param_z m
	addi	x2, x2, 9	# [2144] o_param_z m
	jal	x1, -1962	# [2145] o_param_z m
	addi	x2, x2, -9	# [2146] o_param_z m
	lw	x1, 8(x2)	# [2147] o_param_z m
	flw	f2, 7(x2)	# [2148] org.(2) -. o_param_z m
	# let b2 = org.(2) -. o_param_z m
	fsub	f1, f2, f1	# [2149] org.(2) -. o_param_z m
	lw	x4, 1(x2)	# [2150] o_form m
	fsw	f1, 8(x2)	# [2151] o_form m
	# let m_shape = o_form m
	sw	x1, 9(x2)	# [2152] o_form m
	addi	x2, x2, 10	# [2153] o_form m
	jal	x1, -1996	# [2154] o_form m
	addi	x2, x2, -10	# [2155] o_form m
	lw	x1, 9(x2)	# [2156] o_form m
	addi	x5, x0, 1	# [2157] 1
	bne	x4, x5, 7	# [2158] if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
# beq:	solver_rect m dirvec b0 b1 b2
	flw	f1, 4(x2)	# [2159] solver_rect m dirvec b0 b1 b2
	flw	f2, 6(x2)	# [2160] solver_rect m dirvec b0 b1 b2
	flw	f3, 8(x2)	# [2161] solver_rect m dirvec b0 b1 b2
	lw	x4, 1(x2)	# [2162] solver_rect m dirvec b0 b1 b2
	lw	x5, 0(x2)	# [2163] solver_rect m dirvec b0 b1 b2
	jal	x0, -457	# [2164] solver_rect m dirvec b0 b1 b2
# bne:	if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	addi	x5, x0, 2	# [2165] 2
	bne	x4, x5, 7	# [2166] if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
# beq:	solver_surface m dirvec b0 b1 b2
	flw	f1, 4(x2)	# [2167] solver_surface m dirvec b0 b1 b2
	flw	f2, 6(x2)	# [2168] solver_surface m dirvec b0 b1 b2
	flw	f3, 8(x2)	# [2169] solver_surface m dirvec b0 b1 b2
	lw	x4, 1(x2)	# [2170] solver_surface m dirvec b0 b1 b2
	lw	x5, 0(x2)	# [2171] solver_surface m dirvec b0 b1 b2
	jal	x0, -415	# [2172] solver_surface m dirvec b0 b1 b2
# bne:	solver_second m dirvec b0 b1 b2
	flw	f1, 4(x2)	# [2173] solver_second m dirvec b0 b1 b2
	flw	f2, 6(x2)	# [2174] solver_second m dirvec b0 b1 b2
	flw	f3, 8(x2)	# [2175] solver_second m dirvec b0 b1 b2
	lw	x4, 1(x2)	# [2176] solver_second m dirvec b0 b1 b2
	lw	x5, 0(x2)	# [2177] solver_second m dirvec b0 b1 b2
	jal	x0, -166	# [2178] solver_second m dirvec b0 b1 b2
# solver_rect_fast.3099:	let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	flw	f4, 0(x6)	# [2179] dconst.(0)
	fsub	f4, f4, f1	# [2180] dconst.(0) -. b0
	flw	f5, 1(x6)	# [2181] dconst.(1)
	# let d0 = (dconst.(0) -. b0) *. dconst.(1)
	fmul	f4, f4, f5	# [2182] (dconst.(0) -. b0) *. dconst.(1)
	flw	f5, 1(x5)	# [2183] v.(1)
	fmul	f5, f4, f5	# [2184] d0 *. v.(1)
	fadd	f5, f5, f2	# [2185] d0 *. v.(1) +. b1
	fabs	f5, f5	# [2186] fabs (d0 *. v.(1) +. b1)
	fsw	f1, 0(x2)	# [2187] o_param_b m
	fsw	f2, 1(x2)	# [2188] o_param_b m
	sw	x6, 2(x2)	# [2189] o_param_b m
	sw	x4, 3(x2)	# [2190] o_param_b m
	fsw	f3, 4(x2)	# [2191] o_param_b m
	fsw	f4, 5(x2)	# [2192] o_param_b m
	sw	x5, 6(x2)	# [2193] o_param_b m
	fsw	f5, 7(x2)	# [2194] o_param_b m
	sw	x1, 8(x2)	# [2195] o_param_b m
	addi	x2, x2, 9	# [2196] o_param_b m
	jal	x1, -2028	# [2197] o_param_b m
	addi	x2, x2, -9	# [2198] o_param_b m
	lw	x1, 8(x2)	# [2199] o_param_b m
	flw	f2, 7(x2)	# [2200] fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m)
	flt	x4, f2, f1	# [2201] fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m)
	bne	x4, x0, 3	# [2202] if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false
# beq:	false
	addi	x4, x0, 0	# [2203] false
	jal	x0, 25	# [2204] if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false
# bne:	if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false
	lw	x4, 6(x2)	# [2205] v.(2)
	flw	f1, 2(x4)	# [2206] v.(2)
	flw	f2, 5(x2)	# [2207] d0 *. v.(2)
	fmul	f1, f2, f1	# [2208] d0 *. v.(2)
	flw	f3, 4(x2)	# [2209] d0 *. v.(2) +. b2
	fadd	f1, f1, f3	# [2210] d0 *. v.(2) +. b2
	fabs	f1, f1	# [2211] fabs (d0 *. v.(2) +. b2)
	lw	x5, 3(x2)	# [2212] o_param_c m
	fsw	f1, 8(x2)	# [2213] o_param_c m
	addi	x4, x5, 0	# [2214] o_param_c m
	sw	x1, 9(x2)	# [2215] o_param_c m
	addi	x2, x2, 10	# [2216] o_param_c m
	jal	x1, -2045	# [2217] o_param_c m
	addi	x2, x2, -10	# [2218] o_param_c m
	lw	x1, 9(x2)	# [2219] o_param_c m
	flw	f2, 8(x2)	# [2220] fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m)
	flt	x4, f2, f1	# [2221] fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m)
	bne	x4, x0, 3	# [2222] if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false
# beq:	false
	addi	x4, x0, 0	# [2223] false
	jal	x0, 5	# [2224] if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false
# bne:	not (fiszero dconst.(1))
	lw	x4, 2(x2)	# [2225] dconst.(1)
	flw	f1, 1(x4)	# [2226] dconst.(1)
	feq	x5, f1, f0	# [2227] fiszero dconst.(1)
	xori	x4, x5, -1	# [2228] not (fiszero dconst.(1))
# cont:	if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false
# cont:	if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false
	bne	x4, x0, 116	# [2229] if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
# beq:	let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	lw	x4, 2(x2)	# [2230] dconst.(2)
	flw	f1, 2(x4)	# [2231] dconst.(2)
	flw	f2, 1(x2)	# [2232] dconst.(2) -. b1
	fsub	f1, f1, f2	# [2233] dconst.(2) -. b1
	flw	f3, 3(x4)	# [2234] dconst.(3)
	# let d1 = (dconst.(2) -. b1) *. dconst.(3)
	fmul	f1, f1, f3	# [2235] (dconst.(2) -. b1) *. dconst.(3)
	lw	x5, 6(x2)	# [2236] v.(0)
	flw	f3, 0(x5)	# [2237] v.(0)
	fmul	f3, f1, f3	# [2238] d1 *. v.(0)
	flw	f4, 0(x2)	# [2239] d1 *. v.(0) +. b0
	fadd	f3, f3, f4	# [2240] d1 *. v.(0) +. b0
	fabs	f3, f3	# [2241] fabs (d1 *. v.(0) +. b0)
	lw	x6, 3(x2)	# [2242] o_param_a m
	fsw	f1, 9(x2)	# [2243] o_param_a m
	fsw	f3, 10(x2)	# [2244] o_param_a m
	addi	x4, x6, 0	# [2245] o_param_a m
	sw	x1, 11(x2)	# [2246] o_param_a m
	addi	x2, x2, 12	# [2247] o_param_a m
	jal	x1, -2082	# [2248] o_param_a m
	addi	x2, x2, -12	# [2249] o_param_a m
	lw	x1, 11(x2)	# [2250] o_param_a m
	flw	f2, 10(x2)	# [2251] fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m)
	flt	x4, f2, f1	# [2252] fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m)
	bne	x4, x0, 3	# [2253] if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false
# beq:	false
	addi	x4, x0, 0	# [2254] false
	jal	x0, 25	# [2255] if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false
# bne:	if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false
	lw	x4, 6(x2)	# [2256] v.(2)
	flw	f1, 2(x4)	# [2257] v.(2)
	flw	f2, 9(x2)	# [2258] d1 *. v.(2)
	fmul	f1, f2, f1	# [2259] d1 *. v.(2)
	flw	f3, 4(x2)	# [2260] d1 *. v.(2) +. b2
	fadd	f1, f1, f3	# [2261] d1 *. v.(2) +. b2
	fabs	f1, f1	# [2262] fabs (d1 *. v.(2) +. b2)
	lw	x5, 3(x2)	# [2263] o_param_c m
	fsw	f1, 11(x2)	# [2264] o_param_c m
	addi	x4, x5, 0	# [2265] o_param_c m
	sw	x1, 12(x2)	# [2266] o_param_c m
	addi	x2, x2, 13	# [2267] o_param_c m
	jal	x1, -2096	# [2268] o_param_c m
	addi	x2, x2, -13	# [2269] o_param_c m
	lw	x1, 12(x2)	# [2270] o_param_c m
	flw	f2, 11(x2)	# [2271] fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m)
	flt	x4, f2, f1	# [2272] fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m)
	bne	x4, x0, 3	# [2273] if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false
# beq:	false
	addi	x4, x0, 0	# [2274] false
	jal	x0, 5	# [2275] if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false
# bne:	not (fiszero dconst.(3))
	lw	x4, 2(x2)	# [2276] dconst.(3)
	flw	f1, 3(x4)	# [2277] dconst.(3)
	feq	x5, f1, f0	# [2278] fiszero dconst.(3)
	xori	x4, x5, -1	# [2279] not (fiszero dconst.(3))
# cont:	if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false
# cont:	if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false
	bne	x4, x0, 59	# [2280] if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
# beq:	let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	lw	x4, 2(x2)	# [2281] dconst.(4)
	flw	f1, 4(x4)	# [2282] dconst.(4)
	flw	f2, 4(x2)	# [2283] dconst.(4) -. b2
	fsub	f1, f1, f2	# [2284] dconst.(4) -. b2
	flw	f2, 5(x4)	# [2285] dconst.(5)
	# let d2 = (dconst.(4) -. b2) *. dconst.(5)
	fmul	f1, f1, f2	# [2286] (dconst.(4) -. b2) *. dconst.(5)
	lw	x5, 6(x2)	# [2287] v.(0)
	flw	f2, 0(x5)	# [2288] v.(0)
	fmul	f2, f1, f2	# [2289] d2 *. v.(0)
	flw	f3, 0(x2)	# [2290] d2 *. v.(0) +. b0
	fadd	f2, f2, f3	# [2291] d2 *. v.(0) +. b0
	fabs	f2, f2	# [2292] fabs (d2 *. v.(0) +. b0)
	lw	x6, 3(x2)	# [2293] o_param_a m
	fsw	f1, 12(x2)	# [2294] o_param_a m
	fsw	f2, 13(x2)	# [2295] o_param_a m
	addi	x4, x6, 0	# [2296] o_param_a m
	sw	x1, 14(x2)	# [2297] o_param_a m
	addi	x2, x2, 15	# [2298] o_param_a m
	jal	x1, -2133	# [2299] o_param_a m
	addi	x2, x2, -15	# [2300] o_param_a m
	lw	x1, 14(x2)	# [2301] o_param_a m
	flw	f2, 13(x2)	# [2302] fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m)
	flt	x4, f2, f1	# [2303] fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m)
	bne	x4, x0, 3	# [2304] if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false
# beq:	false
	addi	x4, x0, 0	# [2305] false
	jal	x0, 24	# [2306] if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false
# bne:	if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false
	lw	x4, 6(x2)	# [2307] v.(1)
	flw	f1, 1(x4)	# [2308] v.(1)
	flw	f2, 12(x2)	# [2309] d2 *. v.(1)
	fmul	f1, f2, f1	# [2310] d2 *. v.(1)
	flw	f3, 1(x2)	# [2311] d2 *. v.(1) +. b1
	fadd	f1, f1, f3	# [2312] d2 *. v.(1) +. b1
	fabs	f1, f1	# [2313] fabs (d2 *. v.(1) +. b1)
	lw	x4, 3(x2)	# [2314] o_param_b m
	fsw	f1, 14(x2)	# [2315] o_param_b m
	sw	x1, 15(x2)	# [2316] o_param_b m
	addi	x2, x2, 16	# [2317] o_param_b m
	jal	x1, -2149	# [2318] o_param_b m
	addi	x2, x2, -16	# [2319] o_param_b m
	lw	x1, 15(x2)	# [2320] o_param_b m
	flw	f2, 14(x2)	# [2321] fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m)
	flt	x4, f2, f1	# [2322] fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m)
	bne	x4, x0, 3	# [2323] if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false
# beq:	false
	addi	x4, x0, 0	# [2324] false
	jal	x0, 5	# [2325] if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false
# bne:	not (fiszero dconst.(5))
	lw	x4, 2(x2)	# [2326] dconst.(5)
	flw	f1, 5(x4)	# [2327] dconst.(5)
	feq	x4, f1, f0	# [2328] fiszero dconst.(5)
	xori	x4, x4, -1	# [2329] not (fiszero dconst.(5))
# cont:	if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false
# cont:	if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false
	bne	x4, x0, 3	# [2330] if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
# beq:	0
	addi	x4, x0, 0	# [2331] 0
	jalr	x0, x1, 0	# [2332] 0
# bne:	solver_dist.(0) <- d2; 3
	lui	x4, 256	# [2333] solver_dist
	addi	x4, x4, 122	# [2334] solver_dist
	flw	f1, 12(x2)	# [2335] solver_dist.(0) <- d2
	fsw	f1, 0(x4)	# [2336] solver_dist.(0) <- d2
	addi	x4, x0, 3	# [2337] 3
	jalr	x0, x1, 0	# [2338] 3
# bne:	solver_dist.(0) <- d1; 2
	lui	x4, 256	# [2339] solver_dist
	addi	x4, x4, 122	# [2340] solver_dist
	flw	f1, 9(x2)	# [2341] solver_dist.(0) <- d1
	fsw	f1, 0(x4)	# [2342] solver_dist.(0) <- d1
	addi	x4, x0, 2	# [2343] 2
	jalr	x0, x1, 0	# [2344] 2
# bne:	solver_dist.(0) <- d0; 1
	lui	x4, 256	# [2345] solver_dist
	addi	x4, x4, 122	# [2346] solver_dist
	flw	f1, 5(x2)	# [2347] solver_dist.(0) <- d0
	fsw	f1, 0(x4)	# [2348] solver_dist.(0) <- d0
	addi	x4, x0, 1	# [2349] 1
	jalr	x0, x1, 0	# [2350] 1
# solver_surface_fast.3106:	let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	flw	f4, 0(x5)	# [2351] dconst.(0)
	flt	x4, f4, f0	# [2352] fisneg dconst.(0)
	bne	x4, x0, 3	# [2353] if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
# beq:	0
	addi	x4, x0, 0	# [2354] 0
	jalr	x0, x1, 0	# [2355] 0
# bne:	solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1
	lui	x4, 256	# [2356] solver_dist
	addi	x4, x4, 122	# [2357] solver_dist
	flw	f4, 1(x5)	# [2358] dconst.(1)
	fmul	f1, f4, f1	# [2359] dconst.(1) *. b0
	flw	f4, 2(x5)	# [2360] dconst.(2)
	fmul	f2, f4, f2	# [2361] dconst.(2) *. b1
	fadd	f1, f1, f2	# [2362] dconst.(1) *. b0 +. dconst.(2) *. b1
	flw	f2, 3(x5)	# [2363] dconst.(3)
	fmul	f2, f2, f3	# [2364] dconst.(3) *. b2
	fadd	f1, f1, f2	# [2365] dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	fsw	f1, 0(x4)	# [2366] solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	addi	x4, x0, 1	# [2367] 1
	jalr	x0, x1, 0	# [2368] 1
# solver_second_fast.3112:	let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	# let aa = dconst.(0)
	flw	f4, 0(x5)	# [2369] dconst.(0)
	feq	x6, f4, f0	# [2370] fiszero aa
	bne	x6, x0, 71	# [2371] if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	flw	f5, 1(x5)	# [2372] dconst.(1)
	fmul	f5, f5, f1	# [2373] dconst.(1) *. b0
	flw	f6, 2(x5)	# [2374] dconst.(2)
	fmul	f6, f6, f2	# [2375] dconst.(2) *. b1
	fadd	f5, f5, f6	# [2376] dconst.(1) *. b0 +. dconst.(2) *. b1
	flw	f6, 3(x5)	# [2377] dconst.(3)
	fmul	f6, f6, f3	# [2378] dconst.(3) *. b2
	# let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	fadd	f5, f5, f6	# [2379] dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	sw	x5, 0(x2)	# [2380] quadratic m b0 b1 b2
	fsw	f4, 1(x2)	# [2381] quadratic m b0 b1 b2
	fsw	f5, 2(x2)	# [2382] quadratic m b0 b1 b2
	sw	x4, 3(x2)	# [2383] quadratic m b0 b1 b2
	# let cc0 = quadratic m b0 b1 b2
	sw	x1, 4(x2)	# [2384] quadratic m b0 b1 b2
	addi	x2, x2, 5	# [2385] quadratic m b0 b1 b2
	jal	x1, -584	# [2386] quadratic m b0 b1 b2
	addi	x2, x2, -5	# [2387] quadratic m b0 b1 b2
	lw	x1, 4(x2)	# [2388] quadratic m b0 b1 b2
	lw	x4, 3(x2)	# [2389] o_form m
	fsw	f1, 4(x2)	# [2390] o_form m
	sw	x1, 5(x2)	# [2391] o_form m
	addi	x2, x2, 6	# [2392] o_form m
	jal	x1, -2235	# [2393] o_form m
	addi	x2, x2, -6	# [2394] o_form m
	lw	x1, 5(x2)	# [2395] o_form m
	addi	x5, x0, 3	# [2396] 3
	# let cc = if o_form m = 3 then cc0 -. 1.0 else cc0
	bne	x4, x5, 4	# [2397] if o_form m = 3 then cc0 -. 1.0 else cc0
# beq:	cc0 -. 1.0
	flw	f1, 4(x2)	# [2398] cc0 -. 1.0
	fsub	f1, f1, f11	# [2399] cc0 -. 1.0
	jal	x0, 2	# [2400] if o_form m = 3 then cc0 -. 1.0 else cc0
# bne:	cc0
	flw	f1, 4(x2)	# [2401] cc0
# cont:	if o_form m = 3 then cc0 -. 1.0 else cc0
	flw	f2, 2(x2)	# [2402] fsqr neg_bb
	fmul	f3, f2, f2	# [2403] fsqr neg_bb
	flw	f4, 1(x2)	# [2404] aa *. cc
	fmul	f1, f4, f1	# [2405] aa *. cc
	# let d = (fsqr neg_bb) -. aa *. cc
	fsub	f1, f3, f1	# [2406] (fsqr neg_bb) -. aa *. cc
	flt	x4, f0, f1	# [2407] fispos d
	bne	x4, x0, 3	# [2408] if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	0
	addi	x4, x0, 0	# [2409] 0
	jalr	x0, x1, 0	# [2410] 0
# bne:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1
	lw	x4, 3(x2)	# [2411] o_isinvert m
	fsw	f1, 5(x2)	# [2412] o_isinvert m
	sw	x1, 6(x2)	# [2413] o_isinvert m
	addi	x2, x2, 7	# [2414] o_isinvert m
	jal	x1, -2253	# [2415] o_isinvert m
	addi	x2, x2, -7	# [2416] o_isinvert m
	lw	x1, 6(x2)	# [2417] o_isinvert m
	bne	x4, x0, 12	# [2418] if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# beq:	solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	lui	x4, 256	# [2419] solver_dist
	addi	x4, x4, 122	# [2420] solver_dist
	flw	f1, 5(x2)	# [2421] sqrt d
	fsqrt	f1, f1	# [2422] sqrt d
	flw	f2, 2(x2)	# [2423] neg_bb -. sqrt d
	fsub	f1, f2, f1	# [2424] neg_bb -. sqrt d
	lw	x5, 0(x2)	# [2425] dconst.(4)
	flw	f2, 4(x5)	# [2426] dconst.(4)
	fmul	f1, f1, f2	# [2427] (neg_bb -. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# [2428] solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	jal	x0, 11	# [2429] if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# bne:	solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	lui	x4, 256	# [2430] solver_dist
	addi	x4, x4, 122	# [2431] solver_dist
	flw	f1, 5(x2)	# [2432] sqrt d
	fsqrt	f1, f1	# [2433] sqrt d
	flw	f2, 2(x2)	# [2434] neg_bb +. sqrt d
	fadd	f1, f2, f1	# [2435] neg_bb +. sqrt d
	lw	x5, 0(x2)	# [2436] dconst.(4)
	flw	f2, 4(x5)	# [2437] dconst.(4)
	fmul	f1, f1, f2	# [2438] (neg_bb +. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# [2439] solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
# cont:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	addi	x4, x0, 1	# [2440] 1
	jalr	x0, x1, 0	# [2441] 1
# bne:	0
	addi	x4, x0, 0	# [2442] 0
	jalr	x0, x1, 0	# [2443] 0
# solver_fast.3118:	let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	lui	x7, 256	# [2444] objects
	addi	x7, x7, 60	# [2445] objects
	# let m = objects.(index)
	add	x31, x7, x4	# [2446] objects.(index)
	lw	x7, 0(x31)	# [2447] objects.(index)
	flw	f1, 0(x6)	# [2448] org.(0)
	sw	x4, 0(x2)	# [2449] o_param_x m
	sw	x5, 1(x2)	# [2450] o_param_x m
	sw	x7, 2(x2)	# [2451] o_param_x m
	sw	x6, 3(x2)	# [2452] o_param_x m
	fsw	f1, 4(x2)	# [2453] o_param_x m
	addi	x4, x7, 0	# [2454] o_param_x m
	sw	x1, 5(x2)	# [2455] o_param_x m
	addi	x2, x2, 6	# [2456] o_param_x m
	jal	x1, -2280	# [2457] o_param_x m
	addi	x2, x2, -6	# [2458] o_param_x m
	lw	x1, 5(x2)	# [2459] o_param_x m
	flw	f2, 4(x2)	# [2460] org.(0) -. o_param_x m
	# let b0 = org.(0) -. o_param_x m
	fsub	f1, f2, f1	# [2461] org.(0) -. o_param_x m
	lw	x4, 3(x2)	# [2462] org.(1)
	flw	f2, 1(x4)	# [2463] org.(1)
	lw	x5, 2(x2)	# [2464] o_param_y m
	fsw	f1, 5(x2)	# [2465] o_param_y m
	fsw	f2, 6(x2)	# [2466] o_param_y m
	addi	x4, x5, 0	# [2467] o_param_y m
	sw	x1, 7(x2)	# [2468] o_param_y m
	addi	x2, x2, 8	# [2469] o_param_y m
	jal	x1, -2290	# [2470] o_param_y m
	addi	x2, x2, -8	# [2471] o_param_y m
	lw	x1, 7(x2)	# [2472] o_param_y m
	flw	f2, 6(x2)	# [2473] org.(1) -. o_param_y m
	# let b1 = org.(1) -. o_param_y m
	fsub	f1, f2, f1	# [2474] org.(1) -. o_param_y m
	lw	x4, 3(x2)	# [2475] org.(2)
	flw	f2, 2(x4)	# [2476] org.(2)
	lw	x4, 2(x2)	# [2477] o_param_z m
	fsw	f1, 7(x2)	# [2478] o_param_z m
	fsw	f2, 8(x2)	# [2479] o_param_z m
	sw	x1, 9(x2)	# [2480] o_param_z m
	addi	x2, x2, 10	# [2481] o_param_z m
	jal	x1, -2299	# [2482] o_param_z m
	addi	x2, x2, -10	# [2483] o_param_z m
	lw	x1, 9(x2)	# [2484] o_param_z m
	flw	f2, 8(x2)	# [2485] org.(2) -. o_param_z m
	# let b2 = org.(2) -. o_param_z m
	fsub	f1, f2, f1	# [2486] org.(2) -. o_param_z m
	lw	x4, 1(x2)	# [2487] d_const dirvec
	fsw	f1, 9(x2)	# [2488] d_const dirvec
	# let dconsts = d_const dirvec
	sw	x1, 10(x2)	# [2489] d_const dirvec
	addi	x2, x2, 11	# [2490] d_const dirvec
	jal	x1, -2257	# [2491] d_const dirvec
	addi	x2, x2, -11	# [2492] d_const dirvec
	lw	x1, 10(x2)	# [2493] d_const dirvec
	lw	x5, 0(x2)	# [2494] dconsts.(index)
	# let dconst = dconsts.(index)
	add	x31, x4, x5	# [2495] dconsts.(index)
	lw	x4, 0(x31)	# [2496] dconsts.(index)
	lw	x5, 2(x2)	# [2497] o_form m
	sw	x4, 10(x2)	# [2498] o_form m
	# let m_shape = o_form m
	addi	x4, x5, 0	# [2499] o_form m
	sw	x1, 11(x2)	# [2500] o_form m
	addi	x2, x2, 12	# [2501] o_form m
	jal	x1, -2344	# [2502] o_form m
	addi	x2, x2, -12	# [2503] o_form m
	lw	x1, 11(x2)	# [2504] o_form m
	addi	x5, x0, 1	# [2505] 1
	bne	x4, x5, 14	# [2506] if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
# beq:	solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 1(x2)	# [2507] d_vec dirvec
	sw	x1, 11(x2)	# [2508] d_vec dirvec
	addi	x2, x2, 12	# [2509] d_vec dirvec
	jal	x1, -2278	# [2510] d_vec dirvec
	addi	x2, x2, -12	# [2511] d_vec dirvec
	lw	x1, 11(x2)	# [2512] d_vec dirvec
	addi	x5, x4, 0	# [2513] d_vec dirvec
	flw	f1, 5(x2)	# [2514] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f2, 7(x2)	# [2515] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f3, 9(x2)	# [2516] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 2(x2)	# [2517] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x6, 10(x2)	# [2518] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	jal	x0, -340	# [2519] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
# bne:	if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	addi	x5, x0, 2	# [2520] 2
	bne	x4, x5, 7	# [2521] if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
# beq:	solver_surface_fast m dconst b0 b1 b2
	flw	f1, 5(x2)	# [2522] solver_surface_fast m dconst b0 b1 b2
	flw	f2, 7(x2)	# [2523] solver_surface_fast m dconst b0 b1 b2
	flw	f3, 9(x2)	# [2524] solver_surface_fast m dconst b0 b1 b2
	lw	x4, 2(x2)	# [2525] solver_surface_fast m dconst b0 b1 b2
	lw	x5, 10(x2)	# [2526] solver_surface_fast m dconst b0 b1 b2
	jal	x0, -176	# [2527] solver_surface_fast m dconst b0 b1 b2
# bne:	solver_second_fast m dconst b0 b1 b2
	flw	f1, 5(x2)	# [2528] solver_second_fast m dconst b0 b1 b2
	flw	f2, 7(x2)	# [2529] solver_second_fast m dconst b0 b1 b2
	flw	f3, 9(x2)	# [2530] solver_second_fast m dconst b0 b1 b2
	lw	x4, 2(x2)	# [2531] solver_second_fast m dconst b0 b1 b2
	lw	x5, 10(x2)	# [2532] solver_second_fast m dconst b0 b1 b2
	jal	x0, -164	# [2533] solver_second_fast m dconst b0 b1 b2
# solver_surface_fast2.3122:	let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	flw	f1, 0(x5)	# [2534] dconst.(0)
	flt	x4, f1, f0	# [2535] fisneg dconst.(0)
	bne	x4, x0, 3	# [2536] if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
# beq:	0
	addi	x4, x0, 0	# [2537] 0
	jalr	x0, x1, 0	# [2538] 0
# bne:	solver_dist.(0) <- dconst.(0) *. sconst.(3); 1
	lui	x4, 256	# [2539] solver_dist
	addi	x4, x4, 122	# [2540] solver_dist
	flw	f1, 0(x5)	# [2541] dconst.(0)
	flw	f2, 3(x6)	# [2542] sconst.(3)
	fmul	f1, f1, f2	# [2543] dconst.(0) *. sconst.(3)
	fsw	f1, 0(x4)	# [2544] solver_dist.(0) <- dconst.(0) *. sconst.(3)
	addi	x4, x0, 1	# [2545] 1
	jalr	x0, x1, 0	# [2546] 1
# solver_second_fast2.3129:	let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	# let aa = dconst.(0)
	flw	f4, 0(x5)	# [2547] dconst.(0)
	feq	x7, f4, f0	# [2548] fiszero aa
	bne	x7, x0, 49	# [2549] if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	flw	f5, 1(x5)	# [2550] dconst.(1)
	fmul	f1, f5, f1	# [2551] dconst.(1) *. b0
	flw	f5, 2(x5)	# [2552] dconst.(2)
	fmul	f2, f5, f2	# [2553] dconst.(2) *. b1
	fadd	f1, f1, f2	# [2554] dconst.(1) *. b0 +. dconst.(2) *. b1
	flw	f2, 3(x5)	# [2555] dconst.(3)
	fmul	f2, f2, f3	# [2556] dconst.(3) *. b2
	# let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	fadd	f1, f1, f2	# [2557] dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	# let cc = sconst.(3)
	flw	f2, 3(x6)	# [2558] sconst.(3)
	fmul	f3, f1, f1	# [2559] fsqr neg_bb
	fmul	f2, f4, f2	# [2560] aa *. cc
	# let d = (fsqr neg_bb) -. aa *. cc
	fsub	f2, f3, f2	# [2561] (fsqr neg_bb) -. aa *. cc
	flt	x6, f0, f2	# [2562] fispos d
	bne	x6, x0, 3	# [2563] if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	0
	addi	x4, x0, 0	# [2564] 0
	jalr	x0, x1, 0	# [2565] 0
# bne:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1
	sw	x5, 0(x2)	# [2566] o_isinvert m
	fsw	f1, 1(x2)	# [2567] o_isinvert m
	fsw	f2, 2(x2)	# [2568] o_isinvert m
	sw	x1, 3(x2)	# [2569] o_isinvert m
	addi	x2, x2, 4	# [2570] o_isinvert m
	jal	x1, -2409	# [2571] o_isinvert m
	addi	x2, x2, -4	# [2572] o_isinvert m
	lw	x1, 3(x2)	# [2573] o_isinvert m
	bne	x4, x0, 12	# [2574] if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# beq:	solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	lui	x4, 256	# [2575] solver_dist
	addi	x4, x4, 122	# [2576] solver_dist
	flw	f1, 2(x2)	# [2577] sqrt d
	fsqrt	f1, f1	# [2578] sqrt d
	flw	f2, 1(x2)	# [2579] neg_bb -. sqrt d
	fsub	f1, f2, f1	# [2580] neg_bb -. sqrt d
	lw	x5, 0(x2)	# [2581] dconst.(4)
	flw	f2, 4(x5)	# [2582] dconst.(4)
	fmul	f1, f1, f2	# [2583] (neg_bb -. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# [2584] solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	jal	x0, 11	# [2585] if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# bne:	solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	lui	x4, 256	# [2586] solver_dist
	addi	x4, x4, 122	# [2587] solver_dist
	flw	f1, 2(x2)	# [2588] sqrt d
	fsqrt	f1, f1	# [2589] sqrt d
	flw	f2, 1(x2)	# [2590] neg_bb +. sqrt d
	fadd	f1, f2, f1	# [2591] neg_bb +. sqrt d
	lw	x5, 0(x2)	# [2592] dconst.(4)
	flw	f2, 4(x5)	# [2593] dconst.(4)
	fmul	f1, f1, f2	# [2594] (neg_bb +. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# [2595] solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
# cont:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	addi	x4, x0, 1	# [2596] 1
	jalr	x0, x1, 0	# [2597] 1
# bne:	0
	addi	x4, x0, 0	# [2598] 0
	jalr	x0, x1, 0	# [2599] 0
# solver_fast2.3136:	let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	lui	x6, 256	# [2600] objects
	addi	x6, x6, 60	# [2601] objects
	# let m = objects.(index)
	add	x31, x6, x4	# [2602] objects.(index)
	lw	x6, 0(x31)	# [2603] objects.(index)
	sw	x6, 0(x2)	# [2604] o_param_ctbl m
	sw	x4, 1(x2)	# [2605] o_param_ctbl m
	sw	x5, 2(x2)	# [2606] o_param_ctbl m
	# let sconst = o_param_ctbl m
	addi	x4, x6, 0	# [2607] o_param_ctbl m
	sw	x1, 3(x2)	# [2608] o_param_ctbl m
	addi	x2, x2, 4	# [2609] o_param_ctbl m
	jal	x1, -2400	# [2610] o_param_ctbl m
	addi	x2, x2, -4	# [2611] o_param_ctbl m
	lw	x1, 3(x2)	# [2612] o_param_ctbl m
	# let b0 = sconst.(0)
	flw	f1, 0(x4)	# [2613] sconst.(0)
	# let b1 = sconst.(1)
	flw	f2, 1(x4)	# [2614] sconst.(1)
	# let b2 = sconst.(2)
	flw	f3, 2(x4)	# [2615] sconst.(2)
	lw	x5, 2(x2)	# [2616] d_const dirvec
	sw	x4, 3(x2)	# [2617] d_const dirvec
	fsw	f3, 4(x2)	# [2618] d_const dirvec
	fsw	f2, 5(x2)	# [2619] d_const dirvec
	fsw	f1, 6(x2)	# [2620] d_const dirvec
	# let dconsts = d_const dirvec
	addi	x4, x5, 0	# [2621] d_const dirvec
	sw	x1, 7(x2)	# [2622] d_const dirvec
	addi	x2, x2, 8	# [2623] d_const dirvec
	jal	x1, -2390	# [2624] d_const dirvec
	addi	x2, x2, -8	# [2625] d_const dirvec
	lw	x1, 7(x2)	# [2626] d_const dirvec
	lw	x5, 1(x2)	# [2627] dconsts.(index)
	# let dconst = dconsts.(index)
	add	x31, x4, x5	# [2628] dconsts.(index)
	lw	x4, 0(x31)	# [2629] dconsts.(index)
	lw	x5, 0(x2)	# [2630] o_form m
	sw	x4, 7(x2)	# [2631] o_form m
	# let m_shape = o_form m
	addi	x4, x5, 0	# [2632] o_form m
	sw	x1, 8(x2)	# [2633] o_form m
	addi	x2, x2, 9	# [2634] o_form m
	jal	x1, -2477	# [2635] o_form m
	addi	x2, x2, -9	# [2636] o_form m
	lw	x1, 8(x2)	# [2637] o_form m
	addi	x5, x0, 1	# [2638] 1
	bne	x4, x5, 14	# [2639] if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
# beq:	solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 2(x2)	# [2640] d_vec dirvec
	sw	x1, 8(x2)	# [2641] d_vec dirvec
	addi	x2, x2, 9	# [2642] d_vec dirvec
	jal	x1, -2411	# [2643] d_vec dirvec
	addi	x2, x2, -9	# [2644] d_vec dirvec
	lw	x1, 8(x2)	# [2645] d_vec dirvec
	addi	x5, x4, 0	# [2646] d_vec dirvec
	flw	f1, 6(x2)	# [2647] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f2, 5(x2)	# [2648] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f3, 4(x2)	# [2649] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 0(x2)	# [2650] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x6, 7(x2)	# [2651] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	jal	x0, -473	# [2652] solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
# bne:	if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	addi	x5, x0, 2	# [2653] 2
	bne	x4, x5, 8	# [2654] if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
# beq:	solver_surface_fast2 m dconst sconst b0 b1 b2
	flw	f1, 6(x2)	# [2655] solver_surface_fast2 m dconst sconst b0 b1 b2
	flw	f2, 5(x2)	# [2656] solver_surface_fast2 m dconst sconst b0 b1 b2
	flw	f3, 4(x2)	# [2657] solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x4, 0(x2)	# [2658] solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x5, 7(x2)	# [2659] solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x6, 3(x2)	# [2660] solver_surface_fast2 m dconst sconst b0 b1 b2
	jal	x0, -127	# [2661] solver_surface_fast2 m dconst sconst b0 b1 b2
# bne:	solver_second_fast2 m dconst sconst b0 b1 b2
	flw	f1, 6(x2)	# [2662] solver_second_fast2 m dconst sconst b0 b1 b2
	flw	f2, 5(x2)	# [2663] solver_second_fast2 m dconst sconst b0 b1 b2
	flw	f3, 4(x2)	# [2664] solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x4, 0(x2)	# [2665] solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x5, 7(x2)	# [2666] solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x6, 3(x2)	# [2667] solver_second_fast2 m dconst sconst b0 b1 b2
	jal	x0, -121	# [2668] solver_second_fast2 m dconst sconst b0 b1 b2
# setup_rect_table.3139:	let rec setup_rect_table vec m = let const = create_array 6 0.0 in if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) ); if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) ); if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) ); const
	addi	x6, x0, 6	# [2669] 6
	addi	x31, x0, 0	# [2670] 0.0
	xtof	f1, x31	# [2671] 0.0
	# let const = create_array 6 0.0
	add	x31, x3, x6	# [2672] create_array 6 0.0
	beq	x31, x3, 4	# [2673] create_array 6 0.0
	fsw	f1, 0(x3)	# [2674] create_array 6 0.0
	addi	x3, x3, 1	# [2675] create_array 6 0.0
	jal	x0, -3	# [2676] create_array 6 0.0
	flw	f1, 0(x4)	# [2677] vec.(0)
	feq	x7, f1, f0	# [2678] fiszero vec.(0)
	sw	x6, 0(x2)	# [2679] if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
	sw	x5, 1(x2)	# [2680] if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
	sw	x4, 2(x2)	# [2681] if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
	bne	x7, x0, 32	# [2682] if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
# beq:	const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0)
	addi	x4, x5, 0	# [2683] o_isinvert m
	sw	x1, 3(x2)	# [2684] o_isinvert m
	addi	x2, x2, 4	# [2685] o_isinvert m
	jal	x1, -2524	# [2686] o_isinvert m
	addi	x2, x2, -4	# [2687] o_isinvert m
	lw	x1, 3(x2)	# [2688] o_isinvert m
	lw	x5, 2(x2)	# [2689] vec.(0)
	flw	f1, 0(x5)	# [2690] vec.(0)
	flt	x6, f1, f0	# [2691] fisneg vec.(0)
	xor	x4, x4, x6	# [2692] xor (o_isinvert m) (fisneg vec.(0))
	lw	x6, 1(x2)	# [2693] o_param_a m
	sw	x4, 3(x2)	# [2694] o_param_a m
	addi	x4, x6, 0	# [2695] o_param_a m
	sw	x1, 4(x2)	# [2696] o_param_a m
	addi	x2, x2, 5	# [2697] o_param_a m
	jal	x1, -2532	# [2698] o_param_a m
	addi	x2, x2, -5	# [2699] o_param_a m
	lw	x1, 4(x2)	# [2700] o_param_a m
	lw	x4, 3(x2)	# [2701] fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	sw	x1, 4(x2)	# [2702] fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	addi	x2, x2, 5	# [2703] fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	jal	x1, -2687	# [2704] fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	addi	x2, x2, -5	# [2705] fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	lw	x1, 4(x2)	# [2706] fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	lw	x4, 0(x2)	# [2707] const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	fsw	f1, 0(x4)	# [2708] const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	lw	x5, 2(x2)	# [2709] vec.(0)
	flw	f1, 0(x5)	# [2710] vec.(0)
	fdiv	f1, f11, f1	# [2711] 1.0 /. vec.(0)
	fsw	f1, 1(x4)	# [2712] const.(1) <- 1.0 /. vec.(0)
	jal	x0, 4	# [2713] if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
# bne:	const.(1) <- 0.0
	addi	x31, x0, 0	# [2714] 0.0
	xtof	f1, x31	# [2715] 0.0
	fsw	f1, 1(x6)	# [2716] const.(1) <- 0.0
# cont:	if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
	lw	x4, 2(x2)	# [2717] vec.(1)
	flw	f1, 1(x4)	# [2718] vec.(1)
	feq	x5, f1, f0	# [2719] fiszero vec.(1)
	bne	x5, x0, 33	# [2720] if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) )
# beq:	const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1)
	lw	x5, 1(x2)	# [2721] o_isinvert m
	addi	x4, x5, 0	# [2722] o_isinvert m
	sw	x1, 4(x2)	# [2723] o_isinvert m
	addi	x2, x2, 5	# [2724] o_isinvert m
	jal	x1, -2563	# [2725] o_isinvert m
	addi	x2, x2, -5	# [2726] o_isinvert m
	lw	x1, 4(x2)	# [2727] o_isinvert m
	lw	x5, 2(x2)	# [2728] vec.(1)
	flw	f1, 1(x5)	# [2729] vec.(1)
	flt	x6, f1, f0	# [2730] fisneg vec.(1)
	xor	x4, x4, x6	# [2731] xor (o_isinvert m) (fisneg vec.(1))
	lw	x6, 1(x2)	# [2732] o_param_b m
	sw	x4, 4(x2)	# [2733] o_param_b m
	addi	x4, x6, 0	# [2734] o_param_b m
	sw	x1, 5(x2)	# [2735] o_param_b m
	addi	x2, x2, 6	# [2736] o_param_b m
	jal	x1, -2568	# [2737] o_param_b m
	addi	x2, x2, -6	# [2738] o_param_b m
	lw	x1, 5(x2)	# [2739] o_param_b m
	lw	x4, 4(x2)	# [2740] fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	sw	x1, 5(x2)	# [2741] fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	addi	x2, x2, 6	# [2742] fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	jal	x1, -2726	# [2743] fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	addi	x2, x2, -6	# [2744] fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	lw	x1, 5(x2)	# [2745] fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	lw	x4, 0(x2)	# [2746] const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	fsw	f1, 2(x4)	# [2747] const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	lw	x5, 2(x2)	# [2748] vec.(1)
	flw	f1, 1(x5)	# [2749] vec.(1)
	fdiv	f1, f11, f1	# [2750] 1.0 /. vec.(1)
	fsw	f1, 3(x4)	# [2751] const.(3) <- 1.0 /. vec.(1)
	jal	x0, 5	# [2752] if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) )
# bne:	const.(3) <- 0.0
	addi	x31, x0, 0	# [2753] 0.0
	xtof	f1, x31	# [2754] 0.0
	lw	x5, 0(x2)	# [2755] const.(3) <- 0.0
	fsw	f1, 3(x5)	# [2756] const.(3) <- 0.0
# cont:	if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) )
	lw	x4, 2(x2)	# [2757] vec.(2)
	flw	f1, 2(x4)	# [2758] vec.(2)
	feq	x5, f1, f0	# [2759] fiszero vec.(2)
	bne	x5, x0, 33	# [2760] if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) )
# beq:	const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2)
	lw	x5, 1(x2)	# [2761] o_isinvert m
	addi	x4, x5, 0	# [2762] o_isinvert m
	sw	x1, 5(x2)	# [2763] o_isinvert m
	addi	x2, x2, 6	# [2764] o_isinvert m
	jal	x1, -2603	# [2765] o_isinvert m
	addi	x2, x2, -6	# [2766] o_isinvert m
	lw	x1, 5(x2)	# [2767] o_isinvert m
	lw	x5, 2(x2)	# [2768] vec.(2)
	flw	f1, 2(x5)	# [2769] vec.(2)
	flt	x6, f1, f0	# [2770] fisneg vec.(2)
	xor	x4, x4, x6	# [2771] xor (o_isinvert m) (fisneg vec.(2))
	lw	x6, 1(x2)	# [2772] o_param_c m
	sw	x4, 5(x2)	# [2773] o_param_c m
	addi	x4, x6, 0	# [2774] o_param_c m
	sw	x1, 6(x2)	# [2775] o_param_c m
	addi	x2, x2, 7	# [2776] o_param_c m
	jal	x1, -2605	# [2777] o_param_c m
	addi	x2, x2, -7	# [2778] o_param_c m
	lw	x1, 6(x2)	# [2779] o_param_c m
	lw	x4, 5(x2)	# [2780] fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	sw	x1, 6(x2)	# [2781] fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	addi	x2, x2, 7	# [2782] fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	jal	x1, -2766	# [2783] fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	addi	x2, x2, -7	# [2784] fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	lw	x1, 6(x2)	# [2785] fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	lw	x4, 0(x2)	# [2786] const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	fsw	f1, 4(x4)	# [2787] const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	lw	x5, 2(x2)	# [2788] vec.(2)
	flw	f1, 2(x5)	# [2789] vec.(2)
	fdiv	f1, f11, f1	# [2790] 1.0 /. vec.(2)
	fsw	f1, 5(x4)	# [2791] const.(5) <- 1.0 /. vec.(2)
	jal	x0, 5	# [2792] if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) )
# bne:	const.(5) <- 0.0
	addi	x31, x0, 0	# [2793] 0.0
	xtof	f1, x31	# [2794] 0.0
	lw	x4, 0(x2)	# [2795] const.(5) <- 0.0
	fsw	f1, 5(x4)	# [2796] const.(5) <- 0.0
# cont:	if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) )
	jalr	x0, x1, 0	# [2797] const
# setup_surface_table.3142:	let rec setup_surface_table vec m = let const = create_array 4 0.0 in let d = vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m in if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0; const
	addi	x6, x0, 4	# [2798] 4
	addi	x31, x0, 0	# [2799] 0.0
	xtof	f1, x31	# [2800] 0.0
	# let const = create_array 4 0.0
	add	x31, x3, x6	# [2801] create_array 4 0.0
	beq	x31, x3, 4	# [2802] create_array 4 0.0
	fsw	f1, 0(x3)	# [2803] create_array 4 0.0
	addi	x3, x3, 1	# [2804] create_array 4 0.0
	jal	x0, -3	# [2805] create_array 4 0.0
	flw	f1, 0(x4)	# [2806] vec.(0)
	sw	x6, 0(x2)	# [2807] o_param_a m
	sw	x5, 1(x2)	# [2808] o_param_a m
	sw	x4, 2(x2)	# [2809] o_param_a m
	fsw	f1, 3(x2)	# [2810] o_param_a m
	addi	x4, x5, 0	# [2811] o_param_a m
	sw	x1, 4(x2)	# [2812] o_param_a m
	addi	x2, x2, 5	# [2813] o_param_a m
	jal	x1, -2648	# [2814] o_param_a m
	addi	x2, x2, -5	# [2815] o_param_a m
	lw	x1, 4(x2)	# [2816] o_param_a m
	flw	f2, 3(x2)	# [2817] vec.(0) *. o_param_a m
	fmul	f1, f2, f1	# [2818] vec.(0) *. o_param_a m
	lw	x4, 2(x2)	# [2819] vec.(1)
	flw	f2, 1(x4)	# [2820] vec.(1)
	lw	x5, 1(x2)	# [2821] o_param_b m
	fsw	f1, 4(x2)	# [2822] o_param_b m
	fsw	f2, 5(x2)	# [2823] o_param_b m
	addi	x4, x5, 0	# [2824] o_param_b m
	sw	x1, 6(x2)	# [2825] o_param_b m
	addi	x2, x2, 7	# [2826] o_param_b m
	jal	x1, -2658	# [2827] o_param_b m
	addi	x2, x2, -7	# [2828] o_param_b m
	lw	x1, 6(x2)	# [2829] o_param_b m
	flw	f2, 5(x2)	# [2830] vec.(1) *. o_param_b m
	fmul	f1, f2, f1	# [2831] vec.(1) *. o_param_b m
	flw	f2, 4(x2)	# [2832] vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m
	fadd	f1, f2, f1	# [2833] vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m
	lw	x4, 2(x2)	# [2834] vec.(2)
	flw	f2, 2(x4)	# [2835] vec.(2)
	lw	x4, 1(x2)	# [2836] o_param_c m
	fsw	f1, 6(x2)	# [2837] o_param_c m
	fsw	f2, 7(x2)	# [2838] o_param_c m
	sw	x1, 8(x2)	# [2839] o_param_c m
	addi	x2, x2, 9	# [2840] o_param_c m
	jal	x1, -2669	# [2841] o_param_c m
	addi	x2, x2, -9	# [2842] o_param_c m
	lw	x1, 8(x2)	# [2843] o_param_c m
	flw	f2, 7(x2)	# [2844] vec.(2) *. o_param_c m
	fmul	f1, f2, f1	# [2845] vec.(2) *. o_param_c m
	flw	f2, 6(x2)	# [2846] vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m
	# let d = vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m
	fadd	f1, f2, f1	# [2847] vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m
	flt	x4, f0, f1	# [2848] fispos d
	bne	x4, x0, 6	# [2849] if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0
# beq:	const.(0) <- 0.0
	addi	x31, x0, 0	# [2850] 0.0
	xtof	f1, x31	# [2851] 0.0
	lw	x4, 0(x2)	# [2852] const.(0) <- 0.0
	fsw	f1, 0(x4)	# [2853] const.(0) <- 0.0
	jal	x0, 44	# [2854] if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0
# bne:	const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d)
	lui	x31, -264192	# [2855] -1.0
	addi	x31, x31, 0	# [2856] -1.0
	xtof	f2, x31	# [2857] -1.0
	fdiv	f2, f2, f1	# [2858] -1.0 /. d
	lw	x4, 0(x2)	# [2859] const.(0) <- -1.0 /. d
	fsw	f2, 0(x4)	# [2860] const.(0) <- -1.0 /. d
	lw	x5, 1(x2)	# [2861] o_param_a m
	fsw	f1, 8(x2)	# [2862] o_param_a m
	addi	x4, x5, 0	# [2863] o_param_a m
	sw	x1, 9(x2)	# [2864] o_param_a m
	addi	x2, x2, 10	# [2865] o_param_a m
	jal	x1, -2700	# [2866] o_param_a m
	addi	x2, x2, -10	# [2867] o_param_a m
	lw	x1, 9(x2)	# [2868] o_param_a m
	flw	f2, 8(x2)	# [2869] o_param_a m /. d
	fdiv	f1, f1, f2	# [2870] o_param_a m /. d
	fneg	f1, f1	# [2871] fneg (o_param_a m /. d)
	lw	x4, 0(x2)	# [2872] const.(1) <- fneg (o_param_a m /. d)
	fsw	f1, 1(x4)	# [2873] const.(1) <- fneg (o_param_a m /. d)
	lw	x5, 1(x2)	# [2874] o_param_b m
	addi	x4, x5, 0	# [2875] o_param_b m
	sw	x1, 9(x2)	# [2876] o_param_b m
	addi	x2, x2, 10	# [2877] o_param_b m
	jal	x1, -2709	# [2878] o_param_b m
	addi	x2, x2, -10	# [2879] o_param_b m
	lw	x1, 9(x2)	# [2880] o_param_b m
	flw	f2, 8(x2)	# [2881] o_param_b m /. d
	fdiv	f1, f1, f2	# [2882] o_param_b m /. d
	fneg	f1, f1	# [2883] fneg (o_param_b m /. d)
	lw	x4, 0(x2)	# [2884] const.(2) <- fneg (o_param_b m /. d)
	fsw	f1, 2(x4)	# [2885] const.(2) <- fneg (o_param_b m /. d)
	lw	x5, 1(x2)	# [2886] o_param_c m
	addi	x4, x5, 0	# [2887] o_param_c m
	sw	x1, 9(x2)	# [2888] o_param_c m
	addi	x2, x2, 10	# [2889] o_param_c m
	jal	x1, -2718	# [2890] o_param_c m
	addi	x2, x2, -10	# [2891] o_param_c m
	lw	x1, 9(x2)	# [2892] o_param_c m
	flw	f2, 8(x2)	# [2893] o_param_c m /. d
	fdiv	f1, f1, f2	# [2894] o_param_c m /. d
	fneg	f1, f1	# [2895] fneg (o_param_c m /. d)
	lw	x4, 0(x2)	# [2896] const.(3) <- fneg (o_param_c m /. d)
	fsw	f1, 3(x4)	# [2897] const.(3) <- fneg (o_param_c m /. d)
# cont:	if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0
	jalr	x0, x1, 0	# [2898] const
# setup_second_table.3145:	let rec setup_second_table v m = let const = create_array 5 0.0 in let aa = quadratic m v.(0) v.(1) v.(2) in let c1 = fneg (v.(0) *. o_param_a m) in let c2 = fneg (v.(1) *. o_param_b m) in let c3 = fneg (v.(2) *. o_param_c m) in const.(0) <- aa; (* b' = dirvec^t A start だが、(dirvec^t A)の部分を計算しconst.(1:3)に格納。 b' を求めるにはこのベクトルとstartの内積を取れば良い。符号は逆にする *) if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 ); if not (fiszero aa) then const.(4) <- 1.0 /. aa else (); const
	addi	x6, x0, 5	# [2899] 5
	addi	x31, x0, 0	# [2900] 0.0
	xtof	f1, x31	# [2901] 0.0
	# let const = create_array 5 0.0
	add	x31, x3, x6	# [2902] create_array 5 0.0
	beq	x31, x3, 4	# [2903] create_array 5 0.0
	fsw	f1, 0(x3)	# [2904] create_array 5 0.0
	addi	x3, x3, 1	# [2905] create_array 5 0.0
	jal	x0, -3	# [2906] create_array 5 0.0
	flw	f1, 0(x4)	# [2907] v.(0)
	flw	f2, 1(x4)	# [2908] v.(1)
	flw	f3, 2(x4)	# [2909] v.(2)
	sw	x6, 0(x2)	# [2910] quadratic m v.(0) v.(1) v.(2)
	sw	x5, 1(x2)	# [2911] quadratic m v.(0) v.(1) v.(2)
	sw	x4, 2(x2)	# [2912] quadratic m v.(0) v.(1) v.(2)
	# let aa = quadratic m v.(0) v.(1) v.(2)
	addi	x4, x5, 0	# [2913] quadratic m v.(0) v.(1) v.(2)
	sw	x1, 3(x2)	# [2914] quadratic m v.(0) v.(1) v.(2)
	addi	x2, x2, 4	# [2915] quadratic m v.(0) v.(1) v.(2)
	jal	x1, -1114	# [2916] quadratic m v.(0) v.(1) v.(2)
	addi	x2, x2, -4	# [2917] quadratic m v.(0) v.(1) v.(2)
	lw	x1, 3(x2)	# [2918] quadratic m v.(0) v.(1) v.(2)
	lw	x4, 2(x2)	# [2919] v.(0)
	flw	f2, 0(x4)	# [2920] v.(0)
	lw	x5, 1(x2)	# [2921] o_param_a m
	fsw	f1, 3(x2)	# [2922] o_param_a m
	fsw	f2, 4(x2)	# [2923] o_param_a m
	addi	x4, x5, 0	# [2924] o_param_a m
	sw	x1, 5(x2)	# [2925] o_param_a m
	addi	x2, x2, 6	# [2926] o_param_a m
	jal	x1, -2761	# [2927] o_param_a m
	addi	x2, x2, -6	# [2928] o_param_a m
	lw	x1, 5(x2)	# [2929] o_param_a m
	flw	f2, 4(x2)	# [2930] v.(0) *. o_param_a m
	fmul	f1, f2, f1	# [2931] v.(0) *. o_param_a m
	# let c1 = fneg (v.(0) *. o_param_a m)
	fneg	f1, f1	# [2932] fneg (v.(0) *. o_param_a m)
	lw	x4, 2(x2)	# [2933] v.(1)
	flw	f2, 1(x4)	# [2934] v.(1)
	lw	x5, 1(x2)	# [2935] o_param_b m
	fsw	f1, 5(x2)	# [2936] o_param_b m
	fsw	f2, 6(x2)	# [2937] o_param_b m
	addi	x4, x5, 0	# [2938] o_param_b m
	sw	x1, 7(x2)	# [2939] o_param_b m
	addi	x2, x2, 8	# [2940] o_param_b m
	jal	x1, -2772	# [2941] o_param_b m
	addi	x2, x2, -8	# [2942] o_param_b m
	lw	x1, 7(x2)	# [2943] o_param_b m
	flw	f2, 6(x2)	# [2944] v.(1) *. o_param_b m
	fmul	f1, f2, f1	# [2945] v.(1) *. o_param_b m
	# let c2 = fneg (v.(1) *. o_param_b m)
	fneg	f1, f1	# [2946] fneg (v.(1) *. o_param_b m)
	lw	x4, 2(x2)	# [2947] v.(2)
	flw	f2, 2(x4)	# [2948] v.(2)
	lw	x5, 1(x2)	# [2949] o_param_c m
	fsw	f1, 7(x2)	# [2950] o_param_c m
	fsw	f2, 8(x2)	# [2951] o_param_c m
	addi	x4, x5, 0	# [2952] o_param_c m
	sw	x1, 9(x2)	# [2953] o_param_c m
	addi	x2, x2, 10	# [2954] o_param_c m
	jal	x1, -2783	# [2955] o_param_c m
	addi	x2, x2, -10	# [2956] o_param_c m
	lw	x1, 9(x2)	# [2957] o_param_c m
	flw	f2, 8(x2)	# [2958] v.(2) *. o_param_c m
	fmul	f1, f2, f1	# [2959] v.(2) *. o_param_c m
	# let c3 = fneg (v.(2) *. o_param_c m)
	fneg	f1, f1	# [2960] fneg (v.(2) *. o_param_c m)
	lw	x4, 0(x2)	# [2961] const.(0) <- aa
	flw	f2, 3(x2)	# [2962] const.(0) <- aa
	fsw	f2, 0(x4)	# [2963] const.(0) <- aa
	lw	x5, 1(x2)	# [2964] o_isrot m
	fsw	f1, 9(x2)	# [2965] o_isrot m
	addi	x4, x5, 0	# [2966] o_isrot m
	sw	x1, 10(x2)	# [2967] o_isrot m
	addi	x2, x2, 11	# [2968] o_isrot m
	jal	x1, -2805	# [2969] o_isrot m
	addi	x2, x2, -11	# [2970] o_isrot m
	lw	x1, 10(x2)	# [2971] o_isrot m
	bne	x4, x0, 9	# [2972] if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 )
# beq:	const.(1) <- c1; const.(2) <- c2; const.(3) <- c3
	lw	x4, 0(x2)	# [2973] const.(1) <- c1
	flw	f1, 5(x2)	# [2974] const.(1) <- c1
	fsw	f1, 1(x4)	# [2975] const.(1) <- c1
	flw	f1, 7(x2)	# [2976] const.(2) <- c2
	fsw	f1, 2(x4)	# [2977] const.(2) <- c2
	flw	f1, 9(x2)	# [2978] const.(3) <- c3
	fsw	f1, 3(x4)	# [2979] const.(3) <- c3
	jal	x0, 96	# [2980] if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 )
# bne:	const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	lw	x4, 2(x2)	# [2981] v.(2)
	flw	f1, 2(x4)	# [2982] v.(2)
	lw	x5, 1(x2)	# [2983] o_param_r2 m
	fsw	f1, 10(x2)	# [2984] o_param_r2 m
	addi	x4, x5, 0	# [2985] o_param_r2 m
	sw	x1, 11(x2)	# [2986] o_param_r2 m
	addi	x2, x2, 12	# [2987] o_param_r2 m
	jal	x1, -2784	# [2988] o_param_r2 m
	addi	x2, x2, -12	# [2989] o_param_r2 m
	lw	x1, 11(x2)	# [2990] o_param_r2 m
	flw	f2, 10(x2)	# [2991] v.(2) *. o_param_r2 m
	fmul	f1, f2, f1	# [2992] v.(2) *. o_param_r2 m
	lw	x4, 2(x2)	# [2993] v.(1)
	flw	f2, 1(x4)	# [2994] v.(1)
	lw	x5, 1(x2)	# [2995] o_param_r3 m
	fsw	f1, 11(x2)	# [2996] o_param_r3 m
	fsw	f2, 12(x2)	# [2997] o_param_r3 m
	addi	x4, x5, 0	# [2998] o_param_r3 m
	sw	x1, 13(x2)	# [2999] o_param_r3 m
	addi	x2, x2, 14	# [3000] o_param_r3 m
	jal	x1, -2794	# [3001] o_param_r3 m
	addi	x2, x2, -14	# [3002] o_param_r3 m
	lw	x1, 13(x2)	# [3003] o_param_r3 m
	flw	f2, 12(x2)	# [3004] v.(1) *. o_param_r3 m
	fmul	f1, f2, f1	# [3005] v.(1) *. o_param_r3 m
	flw	f2, 11(x2)	# [3006] v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m
	fadd	f1, f2, f1	# [3007] v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m
	fmul	f1, f1, f27	# [3008] fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	flw	f2, 5(x2)	# [3009] c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	fsub	f1, f2, f1	# [3010] c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	lw	x4, 0(x2)	# [3011] const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	fsw	f1, 1(x4)	# [3012] const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	lw	x5, 2(x2)	# [3013] v.(2)
	flw	f1, 2(x5)	# [3014] v.(2)
	lw	x6, 1(x2)	# [3015] o_param_r1 m
	fsw	f1, 13(x2)	# [3016] o_param_r1 m
	addi	x4, x6, 0	# [3017] o_param_r1 m
	sw	x1, 14(x2)	# [3018] o_param_r1 m
	addi	x2, x2, 15	# [3019] o_param_r1 m
	jal	x1, -2819	# [3020] o_param_r1 m
	addi	x2, x2, -15	# [3021] o_param_r1 m
	lw	x1, 14(x2)	# [3022] o_param_r1 m
	flw	f2, 13(x2)	# [3023] v.(2) *. o_param_r1 m
	fmul	f1, f2, f1	# [3024] v.(2) *. o_param_r1 m
	lw	x4, 2(x2)	# [3025] v.(0)
	flw	f2, 0(x4)	# [3026] v.(0)
	lw	x5, 1(x2)	# [3027] o_param_r3 m
	fsw	f1, 14(x2)	# [3028] o_param_r3 m
	fsw	f2, 15(x2)	# [3029] o_param_r3 m
	addi	x4, x5, 0	# [3030] o_param_r3 m
	sw	x1, 16(x2)	# [3031] o_param_r3 m
	addi	x2, x2, 17	# [3032] o_param_r3 m
	jal	x1, -2826	# [3033] o_param_r3 m
	addi	x2, x2, -17	# [3034] o_param_r3 m
	lw	x1, 16(x2)	# [3035] o_param_r3 m
	flw	f2, 15(x2)	# [3036] v.(0) *. o_param_r3 m
	fmul	f1, f2, f1	# [3037] v.(0) *. o_param_r3 m
	flw	f2, 14(x2)	# [3038] v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m
	fadd	f1, f2, f1	# [3039] v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m
	fmul	f1, f1, f27	# [3040] fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	flw	f2, 7(x2)	# [3041] c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	fsub	f1, f2, f1	# [3042] c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	lw	x4, 0(x2)	# [3043] const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	fsw	f1, 2(x4)	# [3044] const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	lw	x5, 2(x2)	# [3045] v.(1)
	flw	f1, 1(x5)	# [3046] v.(1)
	lw	x6, 1(x2)	# [3047] o_param_r1 m
	fsw	f1, 16(x2)	# [3048] o_param_r1 m
	addi	x4, x6, 0	# [3049] o_param_r1 m
	sw	x1, 17(x2)	# [3050] o_param_r1 m
	addi	x2, x2, 18	# [3051] o_param_r1 m
	jal	x1, -2851	# [3052] o_param_r1 m
	addi	x2, x2, -18	# [3053] o_param_r1 m
	lw	x1, 17(x2)	# [3054] o_param_r1 m
	flw	f2, 16(x2)	# [3055] v.(1) *. o_param_r1 m
	fmul	f1, f2, f1	# [3056] v.(1) *. o_param_r1 m
	lw	x4, 2(x2)	# [3057] v.(0)
	flw	f2, 0(x4)	# [3058] v.(0)
	lw	x4, 1(x2)	# [3059] o_param_r2 m
	fsw	f1, 17(x2)	# [3060] o_param_r2 m
	fsw	f2, 18(x2)	# [3061] o_param_r2 m
	sw	x1, 19(x2)	# [3062] o_param_r2 m
	addi	x2, x2, 20	# [3063] o_param_r2 m
	jal	x1, -2860	# [3064] o_param_r2 m
	addi	x2, x2, -20	# [3065] o_param_r2 m
	lw	x1, 19(x2)	# [3066] o_param_r2 m
	flw	f2, 18(x2)	# [3067] v.(0) *. o_param_r2 m
	fmul	f1, f2, f1	# [3068] v.(0) *. o_param_r2 m
	flw	f2, 17(x2)	# [3069] v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m
	fadd	f1, f2, f1	# [3070] v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m
	fmul	f1, f1, f27	# [3071] fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	flw	f2, 9(x2)	# [3072] c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	fsub	f1, f2, f1	# [3073] c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	lw	x4, 0(x2)	# [3074] const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	fsw	f1, 3(x4)	# [3075] const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
# cont:	if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 )
	flw	f1, 3(x2)	# [3076] fiszero aa
	feq	x5, f1, f0	# [3077] fiszero aa
	bne	x5, x0, 4	# [3078] if not (fiszero aa) then const.(4) <- 1.0 /. aa else ()
# beq:	const.(4) <- 1.0 /. aa
	fdiv	f1, f11, f1	# [3079] 1.0 /. aa
	fsw	f1, 4(x4)	# [3080] const.(4) <- 1.0 /. aa
	jal	x0, 1	# [3081] if not (fiszero aa) then const.(4) <- 1.0 /. aa else ()
# bne:	()
# cont:	if not (fiszero aa) then const.(4) <- 1.0 /. aa else ()
	jalr	x0, x1, 0	# [3082] const
# iter_setup_dirvec_constants.3148:	let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	bge	x5, x0, 2	# [3083] if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [3084] ()
# bge:	let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1)
	lui	x6, 256	# [3085] objects
	addi	x6, x6, 60	# [3086] objects
	# let m = objects.(index)
	add	x31, x6, x5	# [3087] objects.(index)
	lw	x6, 0(x31)	# [3088] objects.(index)
	sw	x5, 0(x2)	# [3089] d_const dirvec
	sw	x6, 1(x2)	# [3090] d_const dirvec
	sw	x4, 2(x2)	# [3091] d_const dirvec
	# let dconst = (d_const dirvec)
	sw	x1, 3(x2)	# [3092] d_const dirvec
	addi	x2, x2, 4	# [3093] d_const dirvec
	jal	x1, -2860	# [3094] d_const dirvec
	addi	x2, x2, -4	# [3095] d_const dirvec
	lw	x1, 3(x2)	# [3096] d_const dirvec
	lw	x5, 2(x2)	# [3097] d_vec dirvec
	sw	x4, 3(x2)	# [3098] d_vec dirvec
	# let v = d_vec dirvec
	addi	x4, x5, 0	# [3099] d_vec dirvec
	sw	x1, 4(x2)	# [3100] d_vec dirvec
	addi	x2, x2, 5	# [3101] d_vec dirvec
	jal	x1, -2870	# [3102] d_vec dirvec
	addi	x2, x2, -5	# [3103] d_vec dirvec
	lw	x1, 4(x2)	# [3104] d_vec dirvec
	lw	x5, 1(x2)	# [3105] o_form m
	sw	x4, 4(x2)	# [3106] o_form m
	# let m_shape = o_form m
	addi	x4, x5, 0	# [3107] o_form m
	sw	x1, 5(x2)	# [3108] o_form m
	addi	x2, x2, 6	# [3109] o_form m
	jal	x1, -2952	# [3110] o_form m
	addi	x2, x2, -6	# [3111] o_form m
	lw	x1, 5(x2)	# [3112] o_form m
	addi	x5, x0, 1	# [3113] 1
	bne	x4, x5, 13	# [3114] if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# beq:	dconst.(index) <- setup_rect_table v m
	lw	x4, 4(x2)	# [3115] setup_rect_table v m
	lw	x5, 1(x2)	# [3116] setup_rect_table v m
	sw	x1, 5(x2)	# [3117] setup_rect_table v m
	addi	x2, x2, 6	# [3118] setup_rect_table v m
	jal	x1, -450	# [3119] setup_rect_table v m
	addi	x2, x2, -6	# [3120] setup_rect_table v m
	lw	x1, 5(x2)	# [3121] setup_rect_table v m
	lw	x5, 0(x2)	# [3122] dconst.(index) <- setup_rect_table v m
	lw	x6, 3(x2)	# [3123] dconst.(index) <- setup_rect_table v m
	add	x31, x6, x5	# [3124] dconst.(index) <- setup_rect_table v m
	sw	x4, 0(x31)	# [3125] dconst.(index) <- setup_rect_table v m
	jal	x0, 26	# [3126] if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# bne:	if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
	addi	x5, x0, 2	# [3127] 2
	bne	x4, x5, 13	# [3128] if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# beq:	dconst.(index) <- setup_surface_table v m
	lw	x4, 4(x2)	# [3129] setup_surface_table v m
	lw	x5, 1(x2)	# [3130] setup_surface_table v m
	sw	x1, 5(x2)	# [3131] setup_surface_table v m
	addi	x2, x2, 6	# [3132] setup_surface_table v m
	jal	x1, -335	# [3133] setup_surface_table v m
	addi	x2, x2, -6	# [3134] setup_surface_table v m
	lw	x1, 5(x2)	# [3135] setup_surface_table v m
	lw	x5, 0(x2)	# [3136] dconst.(index) <- setup_surface_table v m
	lw	x6, 3(x2)	# [3137] dconst.(index) <- setup_surface_table v m
	add	x31, x6, x5	# [3138] dconst.(index) <- setup_surface_table v m
	sw	x4, 0(x31)	# [3139] dconst.(index) <- setup_surface_table v m
	jal	x0, 12	# [3140] if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# bne:	dconst.(index) <- setup_second_table v m
	lw	x4, 4(x2)	# [3141] setup_second_table v m
	lw	x5, 1(x2)	# [3142] setup_second_table v m
	sw	x1, 5(x2)	# [3143] setup_second_table v m
	addi	x2, x2, 6	# [3144] setup_second_table v m
	jal	x1, -246	# [3145] setup_second_table v m
	addi	x2, x2, -6	# [3146] setup_second_table v m
	lw	x1, 5(x2)	# [3147] setup_second_table v m
	lw	x5, 0(x2)	# [3148] dconst.(index) <- setup_second_table v m
	lw	x6, 3(x2)	# [3149] dconst.(index) <- setup_second_table v m
	add	x31, x6, x5	# [3150] dconst.(index) <- setup_second_table v m
	sw	x4, 0(x31)	# [3151] dconst.(index) <- setup_second_table v m
# cont:	if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# cont:	if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
	addi	x5, x5, -1	# [3152] index - 1
	lw	x4, 2(x2)	# [3153] iter_setup_dirvec_constants dirvec (index - 1)
	jal	x0, -71	# [3154] iter_setup_dirvec_constants dirvec (index - 1)
# setup_dirvec_constants.3151:	let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	lui	x5, 256	# [3155] n_objects
	addi	x5, x5, 0	# [3156] n_objects
	lw	x5, 0(x5)	# [3157] n_objects.(0)
	addi	x5, x5, -1	# [3158] n_objects.(0) - 1
	jal	x0, -76	# [3159] iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
# setup_startp_constants.3153:	let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	bge	x5, x0, 2	# [3160] if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [3161] ()
# bge:	let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1)
	lui	x6, 256	# [3162] objects
	addi	x6, x6, 60	# [3163] objects
	# let obj = objects.(index)
	add	x31, x6, x5	# [3164] objects.(index)
	lw	x6, 0(x31)	# [3165] objects.(index)
	sw	x5, 0(x2)	# [3166] o_param_ctbl obj
	sw	x4, 1(x2)	# [3167] o_param_ctbl obj
	sw	x6, 2(x2)	# [3168] o_param_ctbl obj
	# let sconst = o_param_ctbl obj
	addi	x4, x6, 0	# [3169] o_param_ctbl obj
	sw	x1, 3(x2)	# [3170] o_param_ctbl obj
	addi	x2, x2, 4	# [3171] o_param_ctbl obj
	jal	x1, -2962	# [3172] o_param_ctbl obj
	addi	x2, x2, -4	# [3173] o_param_ctbl obj
	lw	x1, 3(x2)	# [3174] o_param_ctbl obj
	lw	x5, 2(x2)	# [3175] o_form obj
	sw	x4, 3(x2)	# [3176] o_form obj
	# let m_shape = o_form obj
	addi	x4, x5, 0	# [3177] o_form obj
	sw	x1, 4(x2)	# [3178] o_form obj
	addi	x2, x2, 5	# [3179] o_form obj
	jal	x1, -3022	# [3180] o_form obj
	addi	x2, x2, -5	# [3181] o_form obj
	lw	x1, 4(x2)	# [3182] o_form obj
	lw	x5, 1(x2)	# [3183] p.(0)
	flw	f1, 0(x5)	# [3184] p.(0)
	lw	x6, 2(x2)	# [3185] o_param_x obj
	sw	x4, 4(x2)	# [3186] o_param_x obj
	fsw	f1, 5(x2)	# [3187] o_param_x obj
	addi	x4, x6, 0	# [3188] o_param_x obj
	sw	x1, 6(x2)	# [3189] o_param_x obj
	addi	x2, x2, 7	# [3190] o_param_x obj
	jal	x1, -3014	# [3191] o_param_x obj
	addi	x2, x2, -7	# [3192] o_param_x obj
	lw	x1, 6(x2)	# [3193] o_param_x obj
	flw	f2, 5(x2)	# [3194] p.(0) -. o_param_x obj
	fsub	f1, f2, f1	# [3195] p.(0) -. o_param_x obj
	lw	x4, 3(x2)	# [3196] sconst.(0) <- p.(0) -. o_param_x obj
	fsw	f1, 0(x4)	# [3197] sconst.(0) <- p.(0) -. o_param_x obj
	lw	x5, 1(x2)	# [3198] p.(1)
	flw	f1, 1(x5)	# [3199] p.(1)
	lw	x6, 2(x2)	# [3200] o_param_y obj
	fsw	f1, 6(x2)	# [3201] o_param_y obj
	addi	x4, x6, 0	# [3202] o_param_y obj
	sw	x1, 7(x2)	# [3203] o_param_y obj
	addi	x2, x2, 8	# [3204] o_param_y obj
	jal	x1, -3025	# [3205] o_param_y obj
	addi	x2, x2, -8	# [3206] o_param_y obj
	lw	x1, 7(x2)	# [3207] o_param_y obj
	flw	f2, 6(x2)	# [3208] p.(1) -. o_param_y obj
	fsub	f1, f2, f1	# [3209] p.(1) -. o_param_y obj
	lw	x4, 3(x2)	# [3210] sconst.(1) <- p.(1) -. o_param_y obj
	fsw	f1, 1(x4)	# [3211] sconst.(1) <- p.(1) -. o_param_y obj
	lw	x5, 1(x2)	# [3212] p.(2)
	flw	f1, 2(x5)	# [3213] p.(2)
	lw	x6, 2(x2)	# [3214] o_param_z obj
	fsw	f1, 7(x2)	# [3215] o_param_z obj
	addi	x4, x6, 0	# [3216] o_param_z obj
	sw	x1, 8(x2)	# [3217] o_param_z obj
	addi	x2, x2, 9	# [3218] o_param_z obj
	jal	x1, -3036	# [3219] o_param_z obj
	addi	x2, x2, -9	# [3220] o_param_z obj
	lw	x1, 8(x2)	# [3221] o_param_z obj
	flw	f2, 7(x2)	# [3222] p.(2) -. o_param_z obj
	fsub	f1, f2, f1	# [3223] p.(2) -. o_param_z obj
	lw	x4, 3(x2)	# [3224] sconst.(2) <- p.(2) -. o_param_z obj
	fsw	f1, 2(x4)	# [3225] sconst.(2) <- p.(2) -. o_param_z obj
	addi	x5, x0, 2	# [3226] 2
	lw	x6, 4(x2)	# [3227] if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
	bne	x6, x5, 20	# [3228] if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# beq:	sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	lw	x5, 2(x2)	# [3229] o_param_abc obj
	addi	x4, x5, 0	# [3230] o_param_abc obj
	sw	x1, 8(x2)	# [3231] o_param_abc obj
	addi	x2, x2, 9	# [3232] o_param_abc obj
	jal	x1, -3058	# [3233] o_param_abc obj
	addi	x2, x2, -9	# [3234] o_param_abc obj
	lw	x1, 8(x2)	# [3235] o_param_abc obj
	lw	x5, 3(x2)	# [3236] sconst.(0)
	flw	f1, 0(x5)	# [3237] sconst.(0)
	flw	f2, 1(x5)	# [3238] sconst.(1)
	flw	f3, 2(x5)	# [3239] sconst.(2)
	sw	x1, 8(x2)	# [3240] veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	addi	x2, x2, 9	# [3241] veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	jal	x1, -3153	# [3242] veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	addi	x2, x2, -9	# [3243] veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	lw	x1, 8(x2)	# [3244] veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	lw	x4, 3(x2)	# [3245] sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	fsw	f1, 3(x4)	# [3246] sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	jal	x0, 21	# [3247] if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# bne:	if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
	addi	x5, x0, 2	# [3248] 2
	bge	x5, x6, 19	# [3249] if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# blt:	let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0
	flw	f1, 0(x4)	# [3250] sconst.(0)
	flw	f2, 1(x4)	# [3251] sconst.(1)
	flw	f3, 2(x4)	# [3252] sconst.(2)
	lw	x5, 2(x2)	# [3253] quadratic obj sconst.(0) sconst.(1) sconst.(2)
	# let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2)
	addi	x4, x5, 0	# [3254] quadratic obj sconst.(0) sconst.(1) sconst.(2)
	sw	x1, 8(x2)	# [3255] quadratic obj sconst.(0) sconst.(1) sconst.(2)
	addi	x2, x2, 9	# [3256] quadratic obj sconst.(0) sconst.(1) sconst.(2)
	jal	x1, -1455	# [3257] quadratic obj sconst.(0) sconst.(1) sconst.(2)
	addi	x2, x2, -9	# [3258] quadratic obj sconst.(0) sconst.(1) sconst.(2)
	lw	x1, 8(x2)	# [3259] quadratic obj sconst.(0) sconst.(1) sconst.(2)
	addi	x4, x0, 3	# [3260] 3
	lw	x5, 4(x2)	# [3261] if m_shape = 3 then cc0 -. 1.0 else cc0
	bne	x5, x4, 3	# [3262] if m_shape = 3 then cc0 -. 1.0 else cc0
# beq:	cc0 -. 1.0
	fsub	f1, f1, f11	# [3263] cc0 -. 1.0
	jal	x0, 1	# [3264] if m_shape = 3 then cc0 -. 1.0 else cc0
# bne:	cc0
# cont:	if m_shape = 3 then cc0 -. 1.0 else cc0
	lw	x4, 3(x2)	# [3265] sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0
	fsw	f1, 3(x4)	# [3266] sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0
	jal	x0, 1	# [3267] if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# bge:	()
# cont:	if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# cont:	if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
	lw	x4, 0(x2)	# [3268] index - 1
	addi	x5, x4, -1	# [3269] index - 1
	lw	x4, 1(x2)	# [3270] setup_startp_constants p (index - 1)
	jal	x0, -111	# [3271] setup_startp_constants p (index - 1)
# setup_startp.3156:	let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	lui	x5, 256	# [3272] startp_fast
	addi	x5, x5, 151	# [3273] startp_fast
	sw	x4, 0(x2)	# [3274] veccpy startp_fast p
	addi	x30, x5, 0	# [3275] veccpy startp_fast p
	addi	x5, x4, 0	# [3276] veccpy startp_fast p
	addi	x4, x30, 0	# [3277] veccpy startp_fast p
	sw	x1, 1(x2)	# [3278] veccpy startp_fast p
	addi	x2, x2, 2	# [3279] veccpy startp_fast p
	jal	x1, -3242	# [3280] veccpy startp_fast p
	addi	x2, x2, -2	# [3281] veccpy startp_fast p
	lw	x1, 1(x2)	# [3282] veccpy startp_fast p
	addi	x0, x4, 0	# [3283] veccpy startp_fast p
	lui	x4, 256	# [3284] n_objects
	addi	x4, x4, 0	# [3285] n_objects
	lw	x4, 0(x4)	# [3286] n_objects.(0)
	addi	x5, x4, -1	# [3287] n_objects.(0) - 1
	lw	x4, 0(x2)	# [3288] setup_startp_constants p (n_objects.(0) - 1)
	jal	x0, -129	# [3289] setup_startp_constants p (n_objects.(0) - 1)
# is_rect_outside.3158:	let rec is_rect_outside m p0 p1 p2 = if if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false then o_isinvert m else not (o_isinvert m)
	fabs	f1, f1	# [3290] fabs p0
	fsw	f3, 0(x2)	# [3291] o_param_a m
	sw	x4, 1(x2)	# [3292] o_param_a m
	fsw	f2, 2(x2)	# [3293] o_param_a m
	fsw	f1, 3(x2)	# [3294] o_param_a m
	sw	x1, 4(x2)	# [3295] o_param_a m
	addi	x2, x2, 5	# [3296] o_param_a m
	jal	x1, -3131	# [3297] o_param_a m
	addi	x2, x2, -5	# [3298] o_param_a m
	lw	x1, 4(x2)	# [3299] o_param_a m
	flw	f2, 3(x2)	# [3300] fless (fabs p0) (o_param_a m)
	flt	x4, f2, f1	# [3301] fless (fabs p0) (o_param_a m)
	bne	x4, x0, 3	# [3302] if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false
# beq:	false
	addi	x4, x0, 0	# [3303] false
	jal	x0, 26	# [3304] if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false
# bne:	if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false
	flw	f1, 2(x2)	# [3305] fabs p1
	fabs	f1, f1	# [3306] fabs p1
	lw	x4, 1(x2)	# [3307] o_param_b m
	fsw	f1, 4(x2)	# [3308] o_param_b m
	sw	x1, 5(x2)	# [3309] o_param_b m
	addi	x2, x2, 6	# [3310] o_param_b m
	jal	x1, -3142	# [3311] o_param_b m
	addi	x2, x2, -6	# [3312] o_param_b m
	lw	x1, 5(x2)	# [3313] o_param_b m
	flw	f2, 4(x2)	# [3314] fless (fabs p1) (o_param_b m)
	flt	x4, f2, f1	# [3315] fless (fabs p1) (o_param_b m)
	bne	x4, x0, 3	# [3316] if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false
# beq:	false
	addi	x4, x0, 0	# [3317] false
	jal	x0, 12	# [3318] if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false
# bne:	fless (fabs p2) (o_param_c m)
	flw	f1, 0(x2)	# [3319] fabs p2
	fabs	f1, f1	# [3320] fabs p2
	lw	x4, 1(x2)	# [3321] o_param_c m
	fsw	f1, 5(x2)	# [3322] o_param_c m
	sw	x1, 6(x2)	# [3323] o_param_c m
	addi	x2, x2, 7	# [3324] o_param_c m
	jal	x1, -3153	# [3325] o_param_c m
	addi	x2, x2, -7	# [3326] o_param_c m
	lw	x1, 6(x2)	# [3327] o_param_c m
	flw	f2, 5(x2)	# [3328] fless (fabs p2) (o_param_c m)
	flt	x4, f2, f1	# [3329] fless (fabs p2) (o_param_c m)
# cont:	if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false
# cont:	if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false
	bne	x4, x0, 9	# [3330] if if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false then o_isinvert m else not (o_isinvert m)
# beq:	not (o_isinvert m)
	lw	x4, 1(x2)	# [3331] o_isinvert m
	sw	x1, 6(x2)	# [3332] o_isinvert m
	addi	x2, x2, 7	# [3333] o_isinvert m
	jal	x1, -3172	# [3334] o_isinvert m
	addi	x2, x2, -7	# [3335] o_isinvert m
	lw	x1, 6(x2)	# [3336] o_isinvert m
	xori	x4, x4, -1	# [3337] not (o_isinvert m)
	jalr	x0, x1, 0	# [3338] not (o_isinvert m)
# bne:	o_isinvert m
	lw	x4, 1(x2)	# [3339] o_isinvert m
	jal	x0, -3178	# [3340] o_isinvert m
# is_plane_outside.3163:	let rec is_plane_outside m p0 p1 p2 = let w = veciprod2 (o_param_abc m) p0 p1 p2 in not (xor (o_isinvert m) (fisneg w))
	sw	x4, 0(x2)	# [3341] o_param_abc m
	fsw	f3, 1(x2)	# [3342] o_param_abc m
	fsw	f2, 2(x2)	# [3343] o_param_abc m
	fsw	f1, 3(x2)	# [3344] o_param_abc m
	sw	x1, 4(x2)	# [3345] o_param_abc m
	addi	x2, x2, 5	# [3346] o_param_abc m
	jal	x1, -3172	# [3347] o_param_abc m
	addi	x2, x2, -5	# [3348] o_param_abc m
	lw	x1, 4(x2)	# [3349] o_param_abc m
	flw	f1, 3(x2)	# [3350] veciprod2 (o_param_abc m) p0 p1 p2
	flw	f2, 2(x2)	# [3351] veciprod2 (o_param_abc m) p0 p1 p2
	flw	f3, 1(x2)	# [3352] veciprod2 (o_param_abc m) p0 p1 p2
	# let w = veciprod2 (o_param_abc m) p0 p1 p2
	sw	x1, 4(x2)	# [3353] veciprod2 (o_param_abc m) p0 p1 p2
	addi	x2, x2, 5	# [3354] veciprod2 (o_param_abc m) p0 p1 p2
	jal	x1, -3266	# [3355] veciprod2 (o_param_abc m) p0 p1 p2
	addi	x2, x2, -5	# [3356] veciprod2 (o_param_abc m) p0 p1 p2
	lw	x1, 4(x2)	# [3357] veciprod2 (o_param_abc m) p0 p1 p2
	lw	x4, 0(x2)	# [3358] o_isinvert m
	fsw	f1, 4(x2)	# [3359] o_isinvert m
	sw	x1, 5(x2)	# [3360] o_isinvert m
	addi	x2, x2, 6	# [3361] o_isinvert m
	jal	x1, -3200	# [3362] o_isinvert m
	addi	x2, x2, -6	# [3363] o_isinvert m
	lw	x1, 5(x2)	# [3364] o_isinvert m
	flw	f1, 4(x2)	# [3365] fisneg w
	flt	x5, f1, f0	# [3366] fisneg w
	xor	x4, x4, x5	# [3367] xor (o_isinvert m) (fisneg w)
	xori	x4, x4, -1	# [3368] not (xor (o_isinvert m) (fisneg w))
	jalr	x0, x1, 0	# [3369] not (xor (o_isinvert m) (fisneg w))
# is_second_outside.3168:	let rec is_second_outside m p0 p1 p2 = let w = quadratic m p0 p1 p2 in let w2 = if o_form m = 3 then w -. 1.0 else w in not (xor (o_isinvert m) (fisneg w2))
	sw	x4, 0(x2)	# [3370] quadratic m p0 p1 p2
	# let w = quadratic m p0 p1 p2
	sw	x1, 1(x2)	# [3371] quadratic m p0 p1 p2
	addi	x2, x2, 2	# [3372] quadratic m p0 p1 p2
	jal	x1, -1571	# [3373] quadratic m p0 p1 p2
	addi	x2, x2, -2	# [3374] quadratic m p0 p1 p2
	lw	x1, 1(x2)	# [3375] quadratic m p0 p1 p2
	lw	x4, 0(x2)	# [3376] o_form m
	fsw	f1, 1(x2)	# [3377] o_form m
	sw	x1, 2(x2)	# [3378] o_form m
	addi	x2, x2, 3	# [3379] o_form m
	jal	x1, -3222	# [3380] o_form m
	addi	x2, x2, -3	# [3381] o_form m
	lw	x1, 2(x2)	# [3382] o_form m
	addi	x5, x0, 3	# [3383] 3
	# let w2 = if o_form m = 3 then w -. 1.0 else w
	bne	x4, x5, 4	# [3384] if o_form m = 3 then w -. 1.0 else w
# beq:	w -. 1.0
	flw	f1, 1(x2)	# [3385] w -. 1.0
	fsub	f1, f1, f11	# [3386] w -. 1.0
	jal	x0, 2	# [3387] if o_form m = 3 then w -. 1.0 else w
# bne:	w
	flw	f1, 1(x2)	# [3388] w
# cont:	if o_form m = 3 then w -. 1.0 else w
	lw	x4, 0(x2)	# [3389] o_isinvert m
	fsw	f1, 2(x2)	# [3390] o_isinvert m
	sw	x1, 3(x2)	# [3391] o_isinvert m
	addi	x2, x2, 4	# [3392] o_isinvert m
	jal	x1, -3231	# [3393] o_isinvert m
	addi	x2, x2, -4	# [3394] o_isinvert m
	lw	x1, 3(x2)	# [3395] o_isinvert m
	flw	f1, 2(x2)	# [3396] fisneg w2
	flt	x5, f1, f0	# [3397] fisneg w2
	xor	x4, x4, x5	# [3398] xor (o_isinvert m) (fisneg w2)
	xori	x4, x4, -1	# [3399] not (xor (o_isinvert m) (fisneg w2))
	jalr	x0, x1, 0	# [3400] not (xor (o_isinvert m) (fisneg w2))
# is_outside.3173:	let rec is_outside m q0 q1 q2 = let p0 = q0 -. o_param_x m in let p1 = q1 -. o_param_y m in let p2 = q2 -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then is_rect_outside m p0 p1 p2 else if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
	fsw	f3, 0(x2)	# [3401] o_param_x m
	fsw	f2, 1(x2)	# [3402] o_param_x m
	sw	x4, 2(x2)	# [3403] o_param_x m
	fsw	f1, 3(x2)	# [3404] o_param_x m
	sw	x1, 4(x2)	# [3405] o_param_x m
	addi	x2, x2, 5	# [3406] o_param_x m
	jal	x1, -3230	# [3407] o_param_x m
	addi	x2, x2, -5	# [3408] o_param_x m
	lw	x1, 4(x2)	# [3409] o_param_x m
	flw	f2, 3(x2)	# [3410] q0 -. o_param_x m
	# let p0 = q0 -. o_param_x m
	fsub	f1, f2, f1	# [3411] q0 -. o_param_x m
	lw	x4, 2(x2)	# [3412] o_param_y m
	fsw	f1, 4(x2)	# [3413] o_param_y m
	sw	x1, 5(x2)	# [3414] o_param_y m
	addi	x2, x2, 6	# [3415] o_param_y m
	jal	x1, -3236	# [3416] o_param_y m
	addi	x2, x2, -6	# [3417] o_param_y m
	lw	x1, 5(x2)	# [3418] o_param_y m
	flw	f2, 1(x2)	# [3419] q1 -. o_param_y m
	# let p1 = q1 -. o_param_y m
	fsub	f1, f2, f1	# [3420] q1 -. o_param_y m
	lw	x4, 2(x2)	# [3421] o_param_z m
	fsw	f1, 5(x2)	# [3422] o_param_z m
	sw	x1, 6(x2)	# [3423] o_param_z m
	addi	x2, x2, 7	# [3424] o_param_z m
	jal	x1, -3242	# [3425] o_param_z m
	addi	x2, x2, -7	# [3426] o_param_z m
	lw	x1, 6(x2)	# [3427] o_param_z m
	flw	f2, 0(x2)	# [3428] q2 -. o_param_z m
	# let p2 = q2 -. o_param_z m
	fsub	f1, f2, f1	# [3429] q2 -. o_param_z m
	lw	x4, 2(x2)	# [3430] o_form m
	fsw	f1, 6(x2)	# [3431] o_form m
	# let m_shape = o_form m
	sw	x1, 7(x2)	# [3432] o_form m
	addi	x2, x2, 8	# [3433] o_form m
	jal	x1, -3276	# [3434] o_form m
	addi	x2, x2, -8	# [3435] o_form m
	lw	x1, 7(x2)	# [3436] o_form m
	addi	x5, x0, 1	# [3437] 1
	bne	x4, x5, 6	# [3438] if m_shape = 1 then is_rect_outside m p0 p1 p2 else if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
# beq:	is_rect_outside m p0 p1 p2
	flw	f1, 4(x2)	# [3439] is_rect_outside m p0 p1 p2
	flw	f2, 5(x2)	# [3440] is_rect_outside m p0 p1 p2
	flw	f3, 6(x2)	# [3441] is_rect_outside m p0 p1 p2
	lw	x4, 2(x2)	# [3442] is_rect_outside m p0 p1 p2
	jal	x0, -153	# [3443] is_rect_outside m p0 p1 p2
# bne:	if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
	addi	x5, x0, 2	# [3444] 2
	bne	x4, x5, 6	# [3445] if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
# beq:	is_plane_outside m p0 p1 p2
	flw	f1, 4(x2)	# [3446] is_plane_outside m p0 p1 p2
	flw	f2, 5(x2)	# [3447] is_plane_outside m p0 p1 p2
	flw	f3, 6(x2)	# [3448] is_plane_outside m p0 p1 p2
	lw	x4, 2(x2)	# [3449] is_plane_outside m p0 p1 p2
	jal	x0, -109	# [3450] is_plane_outside m p0 p1 p2
# bne:	is_second_outside m p0 p1 p2
	flw	f1, 4(x2)	# [3451] is_second_outside m p0 p1 p2
	flw	f2, 5(x2)	# [3452] is_second_outside m p0 p1 p2
	flw	f3, 6(x2)	# [3453] is_second_outside m p0 p1 p2
	lw	x4, 2(x2)	# [3454] is_second_outside m p0 p1 p2
	jal	x0, -85	# [3455] is_second_outside m p0 p1 p2
# check_all_inside.3178:	let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	# let head = iand.(ofs)
	add	x31, x5, x4	# [3456] iand.(ofs)
	lw	x6, 0(x31)	# [3457] iand.(ofs)
	addi	x7, x0, -1	# [3458] -1
	bne	x6, x7, 3	# [3459] if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
# beq:	true
	addi	x4, x0, 1	# [3460] true
	jalr	x0, x1, 0	# [3461] true
# bne:	if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2
	lui	x7, 256	# [3462] objects
	addi	x7, x7, 60	# [3463] objects
	add	x31, x7, x6	# [3464] objects.(head)
	lw	x6, 0(x31)	# [3465] objects.(head)
	fsw	f3, 0(x2)	# [3466] is_outside objects.(head) q0 q1 q2
	fsw	f2, 1(x2)	# [3467] is_outside objects.(head) q0 q1 q2
	fsw	f1, 2(x2)	# [3468] is_outside objects.(head) q0 q1 q2
	sw	x5, 3(x2)	# [3469] is_outside objects.(head) q0 q1 q2
	sw	x4, 4(x2)	# [3470] is_outside objects.(head) q0 q1 q2
	addi	x4, x6, 0	# [3471] is_outside objects.(head) q0 q1 q2
	sw	x1, 5(x2)	# [3472] is_outside objects.(head) q0 q1 q2
	addi	x2, x2, 6	# [3473] is_outside objects.(head) q0 q1 q2
	jal	x1, -73	# [3474] is_outside objects.(head) q0 q1 q2
	addi	x2, x2, -6	# [3475] is_outside objects.(head) q0 q1 q2
	lw	x1, 5(x2)	# [3476] is_outside objects.(head) q0 q1 q2
	bne	x4, x0, 8	# [3477] if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2
# beq:	check_all_inside (ofs + 1) iand q0 q1 q2
	lw	x4, 4(x2)	# [3478] ofs + 1
	addi	x4, x4, 1	# [3479] ofs + 1
	flw	f1, 2(x2)	# [3480] check_all_inside (ofs + 1) iand q0 q1 q2
	flw	f2, 1(x2)	# [3481] check_all_inside (ofs + 1) iand q0 q1 q2
	flw	f3, 0(x2)	# [3482] check_all_inside (ofs + 1) iand q0 q1 q2
	lw	x5, 3(x2)	# [3483] check_all_inside (ofs + 1) iand q0 q1 q2
	jal	x0, -28	# [3484] check_all_inside (ofs + 1) iand q0 q1 q2
# bne:	false
	addi	x4, x0, 0	# [3485] false
	jalr	x0, x1, 0	# [3486] false
# shadow_check_and_group.3184:	let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	add	x31, x5, x4	# [3487] and_group.(iand_ofs)
	lw	x6, 0(x31)	# [3488] and_group.(iand_ofs)
	addi	x7, x0, -1	# [3489] -1
	bne	x6, x7, 3	# [3490] if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
# beq:	false
	addi	x4, x0, 0	# [3491] false
	jalr	x0, x1, 0	# [3492] false
# bne:	let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	# let obj = and_group.(iand_ofs)
	add	x31, x5, x4	# [3493] and_group.(iand_ofs)
	lw	x6, 0(x31)	# [3494] and_group.(iand_ofs)
	lui	x7, 256	# [3495] light_dirvec
	addi	x7, x7, 233	# [3496] light_dirvec
	lui	x8, 256	# [3497] intersection_point
	addi	x8, x8, 127	# [3498] intersection_point
	sw	x5, 0(x2)	# [3499] solver_fast obj light_dirvec intersection_point
	sw	x4, 1(x2)	# [3500] solver_fast obj light_dirvec intersection_point
	sw	x6, 2(x2)	# [3501] solver_fast obj light_dirvec intersection_point
	# let t0 = solver_fast obj light_dirvec intersection_point
	addi	x5, x7, 0	# [3502] solver_fast obj light_dirvec intersection_point
	addi	x4, x6, 0	# [3503] solver_fast obj light_dirvec intersection_point
	addi	x6, x8, 0	# [3504] solver_fast obj light_dirvec intersection_point
	sw	x1, 3(x2)	# [3505] solver_fast obj light_dirvec intersection_point
	addi	x2, x2, 4	# [3506] solver_fast obj light_dirvec intersection_point
	jal	x1, -1063	# [3507] solver_fast obj light_dirvec intersection_point
	addi	x2, x2, -4	# [3508] solver_fast obj light_dirvec intersection_point
	lw	x1, 3(x2)	# [3509] solver_fast obj light_dirvec intersection_point
	lui	x5, 256	# [3510] solver_dist
	addi	x5, x5, 122	# [3511] solver_dist
	# let t0p = solver_dist.(0)
	flw	f1, 0(x5)	# [3512] solver_dist.(0)
	bne	x4, x0, 3	# [3513] if t0 <> 0 then fless t0p (-0.2) else false
# beq:	false
	addi	x4, x0, 0	# [3514] false
	jal	x0, 5	# [3515] if t0 <> 0 then fless t0p (-0.2) else false
# bne:	fless t0p (-0.2)
	lui	x31, -269108	# [3516] -0.2
	addi	x31, x31, -819	# [3517] -0.2
	xtof	f2, x31	# [3518] -0.2
	flt	x4, f1, f2	# [3519] fless t0p (-0.2)
# cont:	if t0 <> 0 then fless t0p (-0.2) else false
	bne	x4, x0, 18	# [3520] if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
# beq:	if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lui	x4, 256	# [3521] objects
	addi	x4, x4, 60	# [3522] objects
	lw	x5, 2(x2)	# [3523] objects.(obj)
	add	x31, x4, x5	# [3524] objects.(obj)
	lw	x4, 0(x31)	# [3525] objects.(obj)
	sw	x1, 3(x2)	# [3526] o_isinvert (objects.(obj))
	addi	x2, x2, 4	# [3527] o_isinvert (objects.(obj))
	jal	x1, -3366	# [3528] o_isinvert (objects.(obj))
	addi	x2, x2, -4	# [3529] o_isinvert (objects.(obj))
	lw	x1, 3(x2)	# [3530] o_isinvert (objects.(obj))
	bne	x4, x0, 3	# [3531] if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
# beq:	false
	addi	x4, x0, 0	# [3532] false
	jalr	x0, x1, 0	# [3533] false
# bne:	shadow_check_and_group (iand_ofs + 1) and_group
	lw	x4, 1(x2)	# [3534] iand_ofs + 1
	addi	x4, x4, 1	# [3535] iand_ofs + 1
	lw	x5, 0(x2)	# [3536] shadow_check_and_group (iand_ofs + 1) and_group
	jal	x0, -50	# [3537] shadow_check_and_group (iand_ofs + 1) and_group
# bne:	let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group
	lui	x31, 246333	# [3538] 0.01
	addi	x31, x31, 1802	# [3539] 0.01
	xtof	f2, x31	# [3540] 0.01
	# let t = t0p +. 0.01
	fadd	f1, f1, f2	# [3541] t0p +. 0.01
	lui	x4, 256	# [3542] light
	addi	x4, x4, 69	# [3543] light
	flw	f2, 0(x4)	# [3544] light.(0)
	fmul	f2, f2, f1	# [3545] light.(0) *. t
	lui	x4, 256	# [3546] intersection_point
	addi	x4, x4, 127	# [3547] intersection_point
	flw	f3, 0(x4)	# [3548] intersection_point.(0)
	# let q0 = light.(0) *. t +. intersection_point.(0)
	fadd	f2, f2, f3	# [3549] light.(0) *. t +. intersection_point.(0)
	lui	x4, 256	# [3550] light
	addi	x4, x4, 69	# [3551] light
	flw	f3, 1(x4)	# [3552] light.(1)
	fmul	f3, f3, f1	# [3553] light.(1) *. t
	lui	x4, 256	# [3554] intersection_point
	addi	x4, x4, 127	# [3555] intersection_point
	flw	f4, 1(x4)	# [3556] intersection_point.(1)
	# let q1 = light.(1) *. t +. intersection_point.(1)
	fadd	f3, f3, f4	# [3557] light.(1) *. t +. intersection_point.(1)
	lui	x4, 256	# [3558] light
	addi	x4, x4, 69	# [3559] light
	flw	f4, 2(x4)	# [3560] light.(2)
	fmul	f1, f4, f1	# [3561] light.(2) *. t
	lui	x4, 256	# [3562] intersection_point
	addi	x4, x4, 127	# [3563] intersection_point
	flw	f4, 2(x4)	# [3564] intersection_point.(2)
	# let q2 = light.(2) *. t +. intersection_point.(2)
	fadd	f1, f1, f4	# [3565] light.(2) *. t +. intersection_point.(2)
	addi	x4, x0, 0	# [3566] 0
	lw	x5, 0(x2)	# [3567] check_all_inside 0 and_group q0 q1 q2
	fmv	f31, f3	# [3568] check_all_inside 0 and_group q0 q1 q2
	fmv	f3, f1	# [3569] check_all_inside 0 and_group q0 q1 q2
	fmv	f1, f2	# [3570] check_all_inside 0 and_group q0 q1 q2
	fmv	f2, f31	# [3571] check_all_inside 0 and_group q0 q1 q2
	sw	x1, 3(x2)	# [3572] check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, 4	# [3573] check_all_inside 0 and_group q0 q1 q2
	jal	x1, -118	# [3574] check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, -4	# [3575] check_all_inside 0 and_group q0 q1 q2
	lw	x1, 3(x2)	# [3576] check_all_inside 0 and_group q0 q1 q2
	bne	x4, x0, 5	# [3577] if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group
# beq:	shadow_check_and_group (iand_ofs + 1) and_group
	lw	x4, 1(x2)	# [3578] iand_ofs + 1
	addi	x4, x4, 1	# [3579] iand_ofs + 1
	lw	x5, 0(x2)	# [3580] shadow_check_and_group (iand_ofs + 1) and_group
	jal	x0, -94	# [3581] shadow_check_and_group (iand_ofs + 1) and_group
# bne:	true
	addi	x4, x0, 1	# [3582] true
	jalr	x0, x1, 0	# [3583] true
# shadow_check_one_or_group.3187:	let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	# let head = or_group.(ofs)
	add	x31, x5, x4	# [3584] or_group.(ofs)
	lw	x6, 0(x31)	# [3585] or_group.(ofs)
	addi	x7, x0, -1	# [3586] -1
	bne	x6, x7, 3	# [3587] if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
# beq:	false
	addi	x4, x0, 0	# [3588] false
	jalr	x0, x1, 0	# [3589] false
# bne:	let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group
	lui	x7, 256	# [3590] and_net
	addi	x7, x7, 120	# [3591] and_net
	# let and_group = and_net.(head)
	add	x31, x7, x6	# [3592] and_net.(head)
	lw	x6, 0(x31)	# [3593] and_net.(head)
	addi	x7, x0, 0	# [3594] 0
	sw	x5, 0(x2)	# [3595] shadow_check_and_group 0 and_group
	sw	x4, 1(x2)	# [3596] shadow_check_and_group 0 and_group
	# let shadow_p = shadow_check_and_group 0 and_group
	addi	x5, x6, 0	# [3597] shadow_check_and_group 0 and_group
	addi	x4, x7, 0	# [3598] shadow_check_and_group 0 and_group
	sw	x1, 2(x2)	# [3599] shadow_check_and_group 0 and_group
	addi	x2, x2, 3	# [3600] shadow_check_and_group 0 and_group
	jal	x1, -114	# [3601] shadow_check_and_group 0 and_group
	addi	x2, x2, -3	# [3602] shadow_check_and_group 0 and_group
	lw	x1, 2(x2)	# [3603] shadow_check_and_group 0 and_group
	bne	x4, x0, 5	# [3604] if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group
# beq:	shadow_check_one_or_group (ofs + 1) or_group
	lw	x4, 1(x2)	# [3605] ofs + 1
	addi	x4, x4, 1	# [3606] ofs + 1
	lw	x5, 0(x2)	# [3607] shadow_check_one_or_group (ofs + 1) or_group
	jal	x0, -24	# [3608] shadow_check_one_or_group (ofs + 1) or_group
# bne:	true
	addi	x4, x0, 1	# [3609] true
	jalr	x0, x1, 0	# [3610] true
# shadow_check_one_or_matrix.3190:	let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	# let head = or_matrix.(ofs)
	add	x31, x5, x4	# [3611] or_matrix.(ofs)
	lw	x6, 0(x31)	# [3612] or_matrix.(ofs)
	# let range_primitive = head.(0)
	lw	x7, 0(x6)	# [3613] head.(0)
	addi	x8, x0, -1	# [3614] -1
	bne	x7, x8, 3	# [3615] if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
# beq:	false
	addi	x4, x0, 0	# [3616] false
	jalr	x0, x1, 0	# [3617] false
# bne:	if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	addi	x8, x0, 99	# [3618] 99
	sw	x6, 0(x2)	# [3619] if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	sw	x5, 1(x2)	# [3620] if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	sw	x4, 2(x2)	# [3621] if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	bne	x7, x8, 3	# [3622] if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# beq:	true
	addi	x4, x0, 1	# [3623] true
	jal	x0, 37	# [3624] if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# bne:	let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	lui	x8, 256	# [3625] light_dirvec
	addi	x8, x8, 233	# [3626] light_dirvec
	lui	x9, 256	# [3627] intersection_point
	addi	x9, x9, 127	# [3628] intersection_point
	# let t = solver_fast range_primitive light_dirvec intersection_point
	addi	x6, x9, 0	# [3629] solver_fast range_primitive light_dirvec intersection_point
	addi	x5, x8, 0	# [3630] solver_fast range_primitive light_dirvec intersection_point
	addi	x4, x7, 0	# [3631] solver_fast range_primitive light_dirvec intersection_point
	sw	x1, 3(x2)	# [3632] solver_fast range_primitive light_dirvec intersection_point
	addi	x2, x2, 4	# [3633] solver_fast range_primitive light_dirvec intersection_point
	jal	x1, -1190	# [3634] solver_fast range_primitive light_dirvec intersection_point
	addi	x2, x2, -4	# [3635] solver_fast range_primitive light_dirvec intersection_point
	lw	x1, 3(x2)	# [3636] solver_fast range_primitive light_dirvec intersection_point
	bne	x4, x0, 3	# [3637] if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# beq:	false
	addi	x4, x0, 0	# [3638] false
	jal	x0, 22	# [3639] if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# bne:	if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false
	lui	x4, 256	# [3640] solver_dist
	addi	x4, x4, 122	# [3641] solver_dist
	flw	f1, 0(x4)	# [3642] solver_dist.(0)
	lui	x31, -271156	# [3643] -0.1
	addi	x31, x31, -819	# [3644] -0.1
	xtof	f2, x31	# [3645] -0.1
	flt	x4, f1, f2	# [3646] fless solver_dist.(0) (-0.1)
	bne	x4, x0, 3	# [3647] if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false
# beq:	false
	addi	x4, x0, 0	# [3648] false
	jal	x0, 12	# [3649] if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false
# bne:	if shadow_check_one_or_group 1 head then true else false
	addi	x4, x0, 1	# [3650] 1
	lw	x5, 0(x2)	# [3651] shadow_check_one_or_group 1 head
	sw	x1, 3(x2)	# [3652] shadow_check_one_or_group 1 head
	addi	x2, x2, 4	# [3653] shadow_check_one_or_group 1 head
	jal	x1, -70	# [3654] shadow_check_one_or_group 1 head
	addi	x2, x2, -4	# [3655] shadow_check_one_or_group 1 head
	lw	x1, 3(x2)	# [3656] shadow_check_one_or_group 1 head
	bne	x4, x0, 3	# [3657] if shadow_check_one_or_group 1 head then true else false
# beq:	false
	addi	x4, x0, 0	# [3658] false
	jal	x0, 2	# [3659] if shadow_check_one_or_group 1 head then true else false
# bne:	true
	addi	x4, x0, 1	# [3660] true
# cont:	if shadow_check_one_or_group 1 head then true else false
# cont:	if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false
# cont:	if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# cont:	if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	bne	x4, x0, 5	# [3661] if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
# beq:	shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x4, 2(x2)	# [3662] ofs + 1
	addi	x4, x4, 1	# [3663] ofs + 1
	lw	x5, 1(x2)	# [3664] shadow_check_one_or_matrix (ofs + 1) or_matrix
	jal	x0, -54	# [3665] shadow_check_one_or_matrix (ofs + 1) or_matrix
# bne:	if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix
	addi	x4, x0, 1	# [3666] 1
	lw	x5, 0(x2)	# [3667] shadow_check_one_or_group 1 head
	sw	x1, 3(x2)	# [3668] shadow_check_one_or_group 1 head
	addi	x2, x2, 4	# [3669] shadow_check_one_or_group 1 head
	jal	x1, -86	# [3670] shadow_check_one_or_group 1 head
	addi	x2, x2, -4	# [3671] shadow_check_one_or_group 1 head
	lw	x1, 3(x2)	# [3672] shadow_check_one_or_group 1 head
	bne	x4, x0, 5	# [3673] if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix
# beq:	shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x4, 2(x2)	# [3674] ofs + 1
	addi	x4, x4, 1	# [3675] ofs + 1
	lw	x5, 1(x2)	# [3676] shadow_check_one_or_matrix (ofs + 1) or_matrix
	jal	x0, -66	# [3677] shadow_check_one_or_matrix (ofs + 1) or_matrix
# bne:	true
	addi	x4, x0, 1	# [3678] true
	jalr	x0, x1, 0	# [3679] true
# solve_each_element.3193:	let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	# let iobj = and_group.(iand_ofs)
	add	x31, x5, x4	# [3680] and_group.(iand_ofs)
	lw	x7, 0(x31)	# [3681] and_group.(iand_ofs)
	addi	x8, x0, -1	# [3682] -1
	bne	x7, x8, 2	# [3683] if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
# beq:	()
	jalr x0, x1, 0	# [3684] ()
# bne:	let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
	lui	x8, 256	# [3685] startp
	addi	x8, x8, 148	# [3686] startp
	sw	x6, 0(x2)	# [3687] solver iobj dirvec startp
	sw	x5, 1(x2)	# [3688] solver iobj dirvec startp
	sw	x4, 2(x2)	# [3689] solver iobj dirvec startp
	sw	x7, 3(x2)	# [3690] solver iobj dirvec startp
	# let t0 = solver iobj dirvec startp
	addi	x5, x6, 0	# [3691] solver iobj dirvec startp
	addi	x4, x7, 0	# [3692] solver iobj dirvec startp
	addi	x6, x8, 0	# [3693] solver iobj dirvec startp
	sw	x1, 4(x2)	# [3694] solver iobj dirvec startp
	addi	x2, x2, 5	# [3695] solver iobj dirvec startp
	jal	x1, -1587	# [3696] solver iobj dirvec startp
	addi	x2, x2, -5	# [3697] solver iobj dirvec startp
	lw	x1, 4(x2)	# [3698] solver iobj dirvec startp
	bne	x4, x0, 18	# [3699] if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
# beq:	if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
	lui	x4, 256	# [3700] objects
	addi	x4, x4, 60	# [3701] objects
	lw	x5, 3(x2)	# [3702] objects.(iobj)
	add	x31, x4, x5	# [3703] objects.(iobj)
	lw	x4, 0(x31)	# [3704] objects.(iobj)
	sw	x1, 4(x2)	# [3705] o_isinvert (objects.(iobj))
	addi	x2, x2, 5	# [3706] o_isinvert (objects.(iobj))
	jal	x1, -3545	# [3707] o_isinvert (objects.(iobj))
	addi	x2, x2, -5	# [3708] o_isinvert (objects.(iobj))
	lw	x1, 4(x2)	# [3709] o_isinvert (objects.(iobj))
	bne	x4, x0, 2	# [3710] if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
# beq:	()
	jalr x0, x1, 0	# [3711] ()
# bne:	solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x4, 2(x2)	# [3712] iand_ofs + 1
	addi	x4, x4, 1	# [3713] iand_ofs + 1
	lw	x5, 1(x2)	# [3714] solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x6, 0(x2)	# [3715] solve_each_element (iand_ofs + 1) and_group dirvec
	jal	x0, -36	# [3716] solve_each_element (iand_ofs + 1) and_group dirvec
# bne:	let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec
	lui	x5, 256	# [3717] solver_dist
	addi	x5, x5, 122	# [3718] solver_dist
	# let t0p = solver_dist.(0)
	flw	f1, 0(x5)	# [3719] solver_dist.(0)
	flt	x5, f0, f1	# [3720] fless 0.0 t0p
	bne	x5, x0, 2	# [3721] if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else ()
# beq:	()
	jal	x0, 72	# [3722] if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else ()
# bne:	if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else ()
	lui	x5, 256	# [3723] tmin
	addi	x5, x5, 124	# [3724] tmin
	flw	f2, 0(x5)	# [3725] tmin.(0)
	flt	x5, f1, f2	# [3726] fless t0p tmin.(0)
	bne	x5, x0, 2	# [3727] if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else ()
# beq:	()
	jal	x0, 66	# [3728] if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else ()
# bne:	let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else ()
	lui	x31, 246333	# [3729] 0.01
	addi	x31, x31, 1802	# [3730] 0.01
	xtof	f2, x31	# [3731] 0.01
	# let t = t0p +. 0.01
	fadd	f1, f1, f2	# [3732] t0p +. 0.01
	lw	x5, 0(x2)	# [3733] dirvec.(0)
	flw	f2, 0(x5)	# [3734] dirvec.(0)
	fmul	f2, f2, f1	# [3735] dirvec.(0) *. t
	lui	x6, 256	# [3736] startp
	addi	x6, x6, 148	# [3737] startp
	flw	f3, 0(x6)	# [3738] startp.(0)
	# let q0 = dirvec.(0) *. t +. startp.(0)
	fadd	f2, f2, f3	# [3739] dirvec.(0) *. t +. startp.(0)
	flw	f3, 1(x5)	# [3740] dirvec.(1)
	fmul	f3, f3, f1	# [3741] dirvec.(1) *. t
	lui	x6, 256	# [3742] startp
	addi	x6, x6, 148	# [3743] startp
	flw	f4, 1(x6)	# [3744] startp.(1)
	# let q1 = dirvec.(1) *. t +. startp.(1)
	fadd	f3, f3, f4	# [3745] dirvec.(1) *. t +. startp.(1)
	flw	f4, 2(x5)	# [3746] dirvec.(2)
	fmul	f4, f4, f1	# [3747] dirvec.(2) *. t
	lui	x6, 256	# [3748] startp
	addi	x6, x6, 148	# [3749] startp
	flw	f5, 2(x6)	# [3750] startp.(2)
	# let q2 = dirvec.(2) *. t +. startp.(2)
	fadd	f4, f4, f5	# [3751] dirvec.(2) *. t +. startp.(2)
	addi	x6, x0, 0	# [3752] 0
	lw	x7, 1(x2)	# [3753] check_all_inside 0 and_group q0 q1 q2
	sw	x4, 4(x2)	# [3754] check_all_inside 0 and_group q0 q1 q2
	fsw	f4, 5(x2)	# [3755] check_all_inside 0 and_group q0 q1 q2
	fsw	f3, 6(x2)	# [3756] check_all_inside 0 and_group q0 q1 q2
	fsw	f2, 7(x2)	# [3757] check_all_inside 0 and_group q0 q1 q2
	fsw	f1, 8(x2)	# [3758] check_all_inside 0 and_group q0 q1 q2
	addi	x5, x7, 0	# [3759] check_all_inside 0 and_group q0 q1 q2
	addi	x4, x6, 0	# [3760] check_all_inside 0 and_group q0 q1 q2
	fmv	f1, f2	# [3761] check_all_inside 0 and_group q0 q1 q2
	fmv	f2, f3	# [3762] check_all_inside 0 and_group q0 q1 q2
	fmv	f3, f4	# [3763] check_all_inside 0 and_group q0 q1 q2
	sw	x1, 9(x2)	# [3764] check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, 10	# [3765] check_all_inside 0 and_group q0 q1 q2
	jal	x1, -310	# [3766] check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, -10	# [3767] check_all_inside 0 and_group q0 q1 q2
	lw	x1, 9(x2)	# [3768] check_all_inside 0 and_group q0 q1 q2
	bne	x4, x0, 2	# [3769] if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else ()
# beq:	()
	jal	x0, 24	# [3770] if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else ()
# bne:	tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0
	lui	x4, 256	# [3771] tmin
	addi	x4, x4, 124	# [3772] tmin
	flw	f1, 8(x2)	# [3773] tmin.(0) <- t
	fsw	f1, 0(x4)	# [3774] tmin.(0) <- t
	lui	x4, 256	# [3775] intersection_point
	addi	x4, x4, 127	# [3776] intersection_point
	flw	f1, 7(x2)	# [3777] vecset intersection_point q0 q1 q2
	flw	f2, 6(x2)	# [3778] vecset intersection_point q0 q1 q2
	flw	f3, 5(x2)	# [3779] vecset intersection_point q0 q1 q2
	sw	x1, 9(x2)	# [3780] vecset intersection_point q0 q1 q2
	addi	x2, x2, 10	# [3781] vecset intersection_point q0 q1 q2
	jal	x1, -3755	# [3782] vecset intersection_point q0 q1 q2
	addi	x2, x2, -10	# [3783] vecset intersection_point q0 q1 q2
	lw	x1, 9(x2)	# [3784] vecset intersection_point q0 q1 q2
	addi	x0, x4, 0	# [3785] vecset intersection_point q0 q1 q2
	lui	x4, 256	# [3786] intersected_object_id
	addi	x4, x4, 128	# [3787] intersected_object_id
	lw	x5, 3(x2)	# [3788] intersected_object_id.(0) <- iobj
	sw	x5, 0(x4)	# [3789] intersected_object_id.(0) <- iobj
	lui	x4, 256	# [3790] intsec_rectside
	addi	x4, x4, 123	# [3791] intsec_rectside
	lw	x5, 4(x2)	# [3792] intsec_rectside.(0) <- t0
	sw	x5, 0(x4)	# [3793] intsec_rectside.(0) <- t0
# cont:	if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else ()
# cont:	if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else ()
# cont:	if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else ()
	lw	x4, 2(x2)	# [3794] iand_ofs + 1
	addi	x4, x4, 1	# [3795] iand_ofs + 1
	lw	x5, 1(x2)	# [3796] solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x6, 0(x2)	# [3797] solve_each_element (iand_ofs + 1) and_group dirvec
	jal	x0, -118	# [3798] solve_each_element (iand_ofs + 1) and_group dirvec
# solve_one_or_network.3197:	let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	# let head = or_group.(ofs)
	add	x31, x5, x4	# [3799] or_group.(ofs)
	lw	x7, 0(x31)	# [3800] or_group.(ofs)
	addi	x8, x0, -1	# [3801] -1
	bne	x7, x8, 2	# [3802] if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
# beq:	()
	jalr x0, x1, 0	# [3803] ()
# bne:	let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec
	lui	x8, 256	# [3804] and_net
	addi	x8, x8, 120	# [3805] and_net
	# let and_group = and_net.(head)
	add	x31, x8, x7	# [3806] and_net.(head)
	lw	x7, 0(x31)	# [3807] and_net.(head)
	addi	x8, x0, 0	# [3808] 0
	sw	x6, 0(x2)	# [3809] solve_each_element 0 and_group dirvec
	sw	x5, 1(x2)	# [3810] solve_each_element 0 and_group dirvec
	sw	x4, 2(x2)	# [3811] solve_each_element 0 and_group dirvec
	addi	x5, x7, 0	# [3812] solve_each_element 0 and_group dirvec
	addi	x4, x8, 0	# [3813] solve_each_element 0 and_group dirvec
	sw	x1, 3(x2)	# [3814] solve_each_element 0 and_group dirvec
	addi	x2, x2, 4	# [3815] solve_each_element 0 and_group dirvec
	jal	x1, -136	# [3816] solve_each_element 0 and_group dirvec
	addi	x2, x2, -4	# [3817] solve_each_element 0 and_group dirvec
	lw	x1, 3(x2)	# [3818] solve_each_element 0 and_group dirvec
	addi	x0, x4, 0	# [3819] solve_each_element 0 and_group dirvec
	lw	x4, 2(x2)	# [3820] ofs + 1
	addi	x4, x4, 1	# [3821] ofs + 1
	lw	x5, 1(x2)	# [3822] solve_one_or_network (ofs + 1) or_group dirvec
	lw	x6, 0(x2)	# [3823] solve_one_or_network (ofs + 1) or_group dirvec
	jal	x0, -25	# [3824] solve_one_or_network (ofs + 1) or_group dirvec
# trace_or_matrix.3201:	let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	# let head = or_network.(ofs)
	add	x31, x5, x4	# [3825] or_network.(ofs)
	lw	x7, 0(x31)	# [3826] or_network.(ofs)
	# let range_primitive = head.(0)
	lw	x8, 0(x7)	# [3827] head.(0)
	addi	x9, x0, -1	# [3828] -1
	bne	x8, x9, 2	# [3829] if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
# beq:	()
	jalr x0, x1, 0	# [3830] ()
# bne:	if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec
	addi	x9, x0, 99	# [3831] 99
	sw	x6, 0(x2)	# [3832] if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	sw	x5, 1(x2)	# [3833] if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	sw	x4, 2(x2)	# [3834] if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	bne	x8, x9, 11	# [3835] if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
# beq:	solve_one_or_network 1 head dirvec
	addi	x8, x0, 1	# [3836] 1
	addi	x5, x7, 0	# [3837] solve_one_or_network 1 head dirvec
	addi	x4, x8, 0	# [3838] solve_one_or_network 1 head dirvec
	sw	x1, 3(x2)	# [3839] solve_one_or_network 1 head dirvec
	addi	x2, x2, 4	# [3840] solve_one_or_network 1 head dirvec
	jal	x1, -42	# [3841] solve_one_or_network 1 head dirvec
	addi	x2, x2, -4	# [3842] solve_one_or_network 1 head dirvec
	lw	x1, 3(x2)	# [3843] solve_one_or_network 1 head dirvec
	addi	x0, x4, 0	# [3844] solve_one_or_network 1 head dirvec
	jal	x0, 32	# [3845] if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
# bne:	let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else ()
	lui	x9, 256	# [3846] startp
	addi	x9, x9, 148	# [3847] startp
	sw	x7, 3(x2)	# [3848] solver range_primitive dirvec startp
	# let t = solver range_primitive dirvec startp
	addi	x5, x6, 0	# [3849] solver range_primitive dirvec startp
	addi	x4, x8, 0	# [3850] solver range_primitive dirvec startp
	addi	x6, x9, 0	# [3851] solver range_primitive dirvec startp
	sw	x1, 4(x2)	# [3852] solver range_primitive dirvec startp
	addi	x2, x2, 5	# [3853] solver range_primitive dirvec startp
	jal	x1, -1745	# [3854] solver range_primitive dirvec startp
	addi	x2, x2, -5	# [3855] solver range_primitive dirvec startp
	lw	x1, 4(x2)	# [3856] solver range_primitive dirvec startp
	bne	x4, x0, 2	# [3857] if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else ()
# beq:	()
	jal	x0, 19	# [3858] if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else ()
# bne:	let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else ()
	lui	x4, 256	# [3859] solver_dist
	addi	x4, x4, 122	# [3860] solver_dist
	# let tp = solver_dist.(0)
	flw	f1, 0(x4)	# [3861] solver_dist.(0)
	lui	x4, 256	# [3862] tmin
	addi	x4, x4, 124	# [3863] tmin
	flw	f2, 0(x4)	# [3864] tmin.(0)
	flt	x4, f1, f2	# [3865] fless tp tmin.(0)
	bne	x4, x0, 2	# [3866] if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else ()
# beq:	()
	jal	x0, 10	# [3867] if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else ()
# bne:	solve_one_or_network 1 head dirvec
	addi	x4, x0, 1	# [3868] 1
	lw	x5, 3(x2)	# [3869] solve_one_or_network 1 head dirvec
	lw	x6, 0(x2)	# [3870] solve_one_or_network 1 head dirvec
	sw	x1, 4(x2)	# [3871] solve_one_or_network 1 head dirvec
	addi	x2, x2, 5	# [3872] solve_one_or_network 1 head dirvec
	jal	x1, -74	# [3873] solve_one_or_network 1 head dirvec
	addi	x2, x2, -5	# [3874] solve_one_or_network 1 head dirvec
	lw	x1, 4(x2)	# [3875] solve_one_or_network 1 head dirvec
	addi	x0, x4, 0	# [3876] solve_one_or_network 1 head dirvec
# cont:	if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else ()
# cont:	if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else ()
# cont:	if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	lw	x4, 2(x2)	# [3877] ofs + 1
	addi	x4, x4, 1	# [3878] ofs + 1
	lw	x5, 1(x2)	# [3879] trace_or_matrix (ofs + 1) or_network dirvec
	lw	x6, 0(x2)	# [3880] trace_or_matrix (ofs + 1) or_network dirvec
	jal	x0, -56	# [3881] trace_or_matrix (ofs + 1) or_network dirvec
# judge_intersection.3205:	let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lui	x5, 256	# [3882] tmin
	addi	x5, x5, 124	# [3883] tmin
	lui	x31, 321254	# [3884] 1000000000.0
	addi	x31, x31, -1240	# [3885] 1000000000.0
	xtof	f1, x31	# [3886] 1000000000.0
	fsw	f1, 0(x5)	# [3887] tmin.(0) <- (1000000000.0)
	addi	x5, x0, 0	# [3888] 0
	lui	x6, 256	# [3889] or_net
	addi	x6, x6, 121	# [3890] or_net
	lw	x6, 0(x6)	# [3891] or_net.(0)
	addi	x30, x6, 0	# [3892] trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x6, x4, 0	# [3893] trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x4, x5, 0	# [3894] trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x5, x30, 0	# [3895] trace_or_matrix 0 (or_net.(0)) dirvec
	sw	x1, 0(x2)	# [3896] trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x2, x2, 1	# [3897] trace_or_matrix 0 (or_net.(0)) dirvec
	jal	x1, -73	# [3898] trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x2, x2, -1	# [3899] trace_or_matrix 0 (or_net.(0)) dirvec
	lw	x1, 0(x2)	# [3900] trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x0, x4, 0	# [3901] trace_or_matrix 0 (or_net.(0)) dirvec
	lui	x4, 256	# [3902] tmin
	addi	x4, x4, 124	# [3903] tmin
	# let t = tmin.(0)
	flw	f1, 0(x4)	# [3904] tmin.(0)
	lui	x31, -271156	# [3905] -0.1
	addi	x31, x31, -819	# [3906] -0.1
	xtof	f2, x31	# [3907] -0.1
	flt	x4, f2, f1	# [3908] fless (-0.1) t
	bne	x4, x0, 3	# [3909] if (fless (-0.1) t) then (fless t 100000000.0) else false
# beq:	false
	addi	x4, x0, 0	# [3910] false
	jalr	x0, x1, 0	# [3911] false
# bne:	fless t 100000000.0
	lui	x31, 314347	# [3912] 100000000.0
	addi	x31, x31, -992	# [3913] 100000000.0
	xtof	f2, x31	# [3914] 100000000.0
	flt	x4, f1, f2	# [3915] fless t 100000000.0
	jalr	x0, x1, 0	# [3916] fless t 100000000.0
# solve_each_element_fast.3207:	let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x6, 0(x2)	# [3917] d_vec dirvec
	sw	x4, 1(x2)	# [3918] d_vec dirvec
	sw	x5, 2(x2)	# [3919] d_vec dirvec
	# let vec = (d_vec dirvec)
	addi	x4, x6, 0	# [3920] d_vec dirvec
	sw	x1, 3(x2)	# [3921] d_vec dirvec
	addi	x2, x2, 4	# [3922] d_vec dirvec
	jal	x1, -3691	# [3923] d_vec dirvec
	addi	x2, x2, -4	# [3924] d_vec dirvec
	lw	x1, 3(x2)	# [3925] d_vec dirvec
	lw	x5, 1(x2)	# [3926] and_group.(iand_ofs)
	lw	x6, 2(x2)	# [3927] and_group.(iand_ofs)
	# let iobj = and_group.(iand_ofs)
	add	x31, x6, x5	# [3928] and_group.(iand_ofs)
	lw	x7, 0(x31)	# [3929] and_group.(iand_ofs)
	addi	x8, x0, -1	# [3930] -1
	bne	x7, x8, 2	# [3931] if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
# beq:	()
	jalr x0, x1, 0	# [3932] ()
# bne:	let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
	lw	x8, 0(x2)	# [3933] solver_fast2 iobj dirvec
	sw	x4, 3(x2)	# [3934] solver_fast2 iobj dirvec
	sw	x7, 4(x2)	# [3935] solver_fast2 iobj dirvec
	# let t0 = solver_fast2 iobj dirvec
	addi	x5, x8, 0	# [3936] solver_fast2 iobj dirvec
	addi	x4, x7, 0	# [3937] solver_fast2 iobj dirvec
	sw	x1, 5(x2)	# [3938] solver_fast2 iobj dirvec
	addi	x2, x2, 6	# [3939] solver_fast2 iobj dirvec
	jal	x1, -1340	# [3940] solver_fast2 iobj dirvec
	addi	x2, x2, -6	# [3941] solver_fast2 iobj dirvec
	lw	x1, 5(x2)	# [3942] solver_fast2 iobj dirvec
	bne	x4, x0, 18	# [3943] if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
# beq:	if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
	lui	x4, 256	# [3944] objects
	addi	x4, x4, 60	# [3945] objects
	lw	x5, 4(x2)	# [3946] objects.(iobj)
	add	x31, x4, x5	# [3947] objects.(iobj)
	lw	x4, 0(x31)	# [3948] objects.(iobj)
	sw	x1, 5(x2)	# [3949] o_isinvert (objects.(iobj))
	addi	x2, x2, 6	# [3950] o_isinvert (objects.(iobj))
	jal	x1, -3789	# [3951] o_isinvert (objects.(iobj))
	addi	x2, x2, -6	# [3952] o_isinvert (objects.(iobj))
	lw	x1, 5(x2)	# [3953] o_isinvert (objects.(iobj))
	bne	x4, x0, 2	# [3954] if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
# beq:	()
	jalr x0, x1, 0	# [3955] ()
# bne:	solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x4, 1(x2)	# [3956] iand_ofs + 1
	addi	x4, x4, 1	# [3957] iand_ofs + 1
	lw	x5, 2(x2)	# [3958] solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x6, 0(x2)	# [3959] solve_each_element_fast (iand_ofs + 1) and_group dirvec
	jal	x0, -43	# [3960] solve_each_element_fast (iand_ofs + 1) and_group dirvec
# bne:	let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lui	x5, 256	# [3961] solver_dist
	addi	x5, x5, 122	# [3962] solver_dist
	# let t0p = solver_dist.(0)
	flw	f1, 0(x5)	# [3963] solver_dist.(0)
	flt	x5, f0, f1	# [3964] fless 0.0 t0p
	bne	x5, x0, 2	# [3965] if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else ()
# beq:	()
	jal	x0, 72	# [3966] if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else ()
# bne:	if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else ()
	lui	x5, 256	# [3967] tmin
	addi	x5, x5, 124	# [3968] tmin
	flw	f2, 0(x5)	# [3969] tmin.(0)
	flt	x5, f1, f2	# [3970] fless t0p tmin.(0)
	bne	x5, x0, 2	# [3971] if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else ()
# beq:	()
	jal	x0, 66	# [3972] if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else ()
# bne:	let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else ()
	lui	x31, 246333	# [3973] 0.01
	addi	x31, x31, 1802	# [3974] 0.01
	xtof	f2, x31	# [3975] 0.01
	# let t = t0p +. 0.01
	fadd	f1, f1, f2	# [3976] t0p +. 0.01
	lw	x5, 3(x2)	# [3977] vec.(0)
	flw	f2, 0(x5)	# [3978] vec.(0)
	fmul	f2, f2, f1	# [3979] vec.(0) *. t
	lui	x6, 256	# [3980] startp_fast
	addi	x6, x6, 151	# [3981] startp_fast
	flw	f3, 0(x6)	# [3982] startp_fast.(0)
	# let q0 = vec.(0) *. t +. startp_fast.(0)
	fadd	f2, f2, f3	# [3983] vec.(0) *. t +. startp_fast.(0)
	flw	f3, 1(x5)	# [3984] vec.(1)
	fmul	f3, f3, f1	# [3985] vec.(1) *. t
	lui	x6, 256	# [3986] startp_fast
	addi	x6, x6, 151	# [3987] startp_fast
	flw	f4, 1(x6)	# [3988] startp_fast.(1)
	# let q1 = vec.(1) *. t +. startp_fast.(1)
	fadd	f3, f3, f4	# [3989] vec.(1) *. t +. startp_fast.(1)
	flw	f4, 2(x5)	# [3990] vec.(2)
	fmul	f4, f4, f1	# [3991] vec.(2) *. t
	lui	x5, 256	# [3992] startp_fast
	addi	x5, x5, 151	# [3993] startp_fast
	flw	f5, 2(x5)	# [3994] startp_fast.(2)
	# let q2 = vec.(2) *. t +. startp_fast.(2)
	fadd	f4, f4, f5	# [3995] vec.(2) *. t +. startp_fast.(2)
	addi	x5, x0, 0	# [3996] 0
	lw	x6, 2(x2)	# [3997] check_all_inside 0 and_group q0 q1 q2
	sw	x4, 5(x2)	# [3998] check_all_inside 0 and_group q0 q1 q2
	fsw	f4, 6(x2)	# [3999] check_all_inside 0 and_group q0 q1 q2
	fsw	f3, 7(x2)	# [4000] check_all_inside 0 and_group q0 q1 q2
	fsw	f2, 8(x2)	# [4001] check_all_inside 0 and_group q0 q1 q2
	fsw	f1, 9(x2)	# [4002] check_all_inside 0 and_group q0 q1 q2
	addi	x4, x5, 0	# [4003] check_all_inside 0 and_group q0 q1 q2
	addi	x5, x6, 0	# [4004] check_all_inside 0 and_group q0 q1 q2
	fmv	f1, f2	# [4005] check_all_inside 0 and_group q0 q1 q2
	fmv	f2, f3	# [4006] check_all_inside 0 and_group q0 q1 q2
	fmv	f3, f4	# [4007] check_all_inside 0 and_group q0 q1 q2
	sw	x1, 10(x2)	# [4008] check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, 11	# [4009] check_all_inside 0 and_group q0 q1 q2
	jal	x1, -554	# [4010] check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, -11	# [4011] check_all_inside 0 and_group q0 q1 q2
	lw	x1, 10(x2)	# [4012] check_all_inside 0 and_group q0 q1 q2
	bne	x4, x0, 2	# [4013] if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else ()
# beq:	()
	jal	x0, 24	# [4014] if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else ()
# bne:	tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0;
	lui	x4, 256	# [4015] tmin
	addi	x4, x4, 124	# [4016] tmin
	flw	f1, 9(x2)	# [4017] tmin.(0) <- t
	fsw	f1, 0(x4)	# [4018] tmin.(0) <- t
	lui	x4, 256	# [4019] intersection_point
	addi	x4, x4, 127	# [4020] intersection_point
	flw	f1, 8(x2)	# [4021] vecset intersection_point q0 q1 q2
	flw	f2, 7(x2)	# [4022] vecset intersection_point q0 q1 q2
	flw	f3, 6(x2)	# [4023] vecset intersection_point q0 q1 q2
	sw	x1, 10(x2)	# [4024] vecset intersection_point q0 q1 q2
	addi	x2, x2, 11	# [4025] vecset intersection_point q0 q1 q2
	jal	x1, -3999	# [4026] vecset intersection_point q0 q1 q2
	addi	x2, x2, -11	# [4027] vecset intersection_point q0 q1 q2
	lw	x1, 10(x2)	# [4028] vecset intersection_point q0 q1 q2
	addi	x0, x4, 0	# [4029] vecset intersection_point q0 q1 q2
	lui	x4, 256	# [4030] intersected_object_id
	addi	x4, x4, 128	# [4031] intersected_object_id
	lw	x5, 4(x2)	# [4032] intersected_object_id.(0) <- iobj
	sw	x5, 0(x4)	# [4033] intersected_object_id.(0) <- iobj
	lui	x4, 256	# [4034] intsec_rectside
	addi	x4, x4, 123	# [4035] intsec_rectside
	lw	x5, 5(x2)	# [4036] intsec_rectside.(0) <- t0
	sw	x5, 0(x4)	# [4037] intsec_rectside.(0) <- t0
# cont:	if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else ()
# cont:	if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else ()
# cont:	if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else ()
	lw	x4, 1(x2)	# [4038] iand_ofs + 1
	addi	x4, x4, 1	# [4039] iand_ofs + 1
	lw	x5, 2(x2)	# [4040] solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x6, 0(x2)	# [4041] solve_each_element_fast (iand_ofs + 1) and_group dirvec
	jal	x0, -125	# [4042] solve_each_element_fast (iand_ofs + 1) and_group dirvec
# solve_one_or_network_fast.3211:	let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	# let head = or_group.(ofs)
	add	x31, x5, x4	# [4043] or_group.(ofs)
	lw	x7, 0(x31)	# [4044] or_group.(ofs)
	addi	x8, x0, -1	# [4045] -1
	bne	x7, x8, 2	# [4046] if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
# beq:	()
	jalr x0, x1, 0	# [4047] ()
# bne:	let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec
	lui	x8, 256	# [4048] and_net
	addi	x8, x8, 120	# [4049] and_net
	# let and_group = and_net.(head)
	add	x31, x8, x7	# [4050] and_net.(head)
	lw	x7, 0(x31)	# [4051] and_net.(head)
	addi	x8, x0, 0	# [4052] 0
	sw	x6, 0(x2)	# [4053] solve_each_element_fast 0 and_group dirvec
	sw	x5, 1(x2)	# [4054] solve_each_element_fast 0 and_group dirvec
	sw	x4, 2(x2)	# [4055] solve_each_element_fast 0 and_group dirvec
	addi	x5, x7, 0	# [4056] solve_each_element_fast 0 and_group dirvec
	addi	x4, x8, 0	# [4057] solve_each_element_fast 0 and_group dirvec
	sw	x1, 3(x2)	# [4058] solve_each_element_fast 0 and_group dirvec
	addi	x2, x2, 4	# [4059] solve_each_element_fast 0 and_group dirvec
	jal	x1, -143	# [4060] solve_each_element_fast 0 and_group dirvec
	addi	x2, x2, -4	# [4061] solve_each_element_fast 0 and_group dirvec
	lw	x1, 3(x2)	# [4062] solve_each_element_fast 0 and_group dirvec
	addi	x0, x4, 0	# [4063] solve_each_element_fast 0 and_group dirvec
	lw	x4, 2(x2)	# [4064] ofs + 1
	addi	x4, x4, 1	# [4065] ofs + 1
	lw	x5, 1(x2)	# [4066] solve_one_or_network_fast (ofs + 1) or_group dirvec
	lw	x6, 0(x2)	# [4067] solve_one_or_network_fast (ofs + 1) or_group dirvec
	jal	x0, -25	# [4068] solve_one_or_network_fast (ofs + 1) or_group dirvec
# trace_or_matrix_fast.3215:	let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	# let head = or_network.(ofs)
	add	x31, x5, x4	# [4069] or_network.(ofs)
	lw	x7, 0(x31)	# [4070] or_network.(ofs)
	# let range_primitive = head.(0)
	lw	x8, 0(x7)	# [4071] head.(0)
	addi	x9, x0, -1	# [4072] -1
	bne	x8, x9, 2	# [4073] if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
# beq:	()
	jalr x0, x1, 0	# [4074] ()
# bne:	if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec
	addi	x9, x0, 99	# [4075] 99
	sw	x6, 0(x2)	# [4076] if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	sw	x5, 1(x2)	# [4077] if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	sw	x4, 2(x2)	# [4078] if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	bne	x8, x9, 11	# [4079] if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
# beq:	solve_one_or_network_fast 1 head dirvec
	addi	x8, x0, 1	# [4080] 1
	addi	x5, x7, 0	# [4081] solve_one_or_network_fast 1 head dirvec
	addi	x4, x8, 0	# [4082] solve_one_or_network_fast 1 head dirvec
	sw	x1, 3(x2)	# [4083] solve_one_or_network_fast 1 head dirvec
	addi	x2, x2, 4	# [4084] solve_one_or_network_fast 1 head dirvec
	jal	x1, -42	# [4085] solve_one_or_network_fast 1 head dirvec
	addi	x2, x2, -4	# [4086] solve_one_or_network_fast 1 head dirvec
	lw	x1, 3(x2)	# [4087] solve_one_or_network_fast 1 head dirvec
	addi	x0, x4, 0	# [4088] solve_one_or_network_fast 1 head dirvec
	jal	x0, 29	# [4089] if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
# bne:	let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else ()
	sw	x7, 3(x2)	# [4090] solver_fast2 range_primitive dirvec
	# let t = solver_fast2 range_primitive dirvec
	addi	x5, x6, 0	# [4091] solver_fast2 range_primitive dirvec
	addi	x4, x8, 0	# [4092] solver_fast2 range_primitive dirvec
	sw	x1, 4(x2)	# [4093] solver_fast2 range_primitive dirvec
	addi	x2, x2, 5	# [4094] solver_fast2 range_primitive dirvec
	jal	x1, -1495	# [4095] solver_fast2 range_primitive dirvec
	addi	x2, x2, -5	# [4096] solver_fast2 range_primitive dirvec
	lw	x1, 4(x2)	# [4097] solver_fast2 range_primitive dirvec
	bne	x4, x0, 2	# [4098] if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else ()
# beq:	()
	jal	x0, 19	# [4099] if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else ()
# bne:	let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else ()
	lui	x4, 256	# [4100] solver_dist
	addi	x4, x4, 122	# [4101] solver_dist
	# let tp = solver_dist.(0)
	flw	f1, 0(x4)	# [4102] solver_dist.(0)
	lui	x4, 256	# [4103] tmin
	addi	x4, x4, 124	# [4104] tmin
	flw	f2, 0(x4)	# [4105] tmin.(0)
	flt	x4, f1, f2	# [4106] fless tp tmin.(0)
	bne	x4, x0, 2	# [4107] if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else ()
# beq:	()
	jal	x0, 10	# [4108] if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else ()
# bne:	solve_one_or_network_fast 1 head dirvec
	addi	x4, x0, 1	# [4109] 1
	lw	x5, 3(x2)	# [4110] solve_one_or_network_fast 1 head dirvec
	lw	x6, 0(x2)	# [4111] solve_one_or_network_fast 1 head dirvec
	sw	x1, 4(x2)	# [4112] solve_one_or_network_fast 1 head dirvec
	addi	x2, x2, 5	# [4113] solve_one_or_network_fast 1 head dirvec
	jal	x1, -71	# [4114] solve_one_or_network_fast 1 head dirvec
	addi	x2, x2, -5	# [4115] solve_one_or_network_fast 1 head dirvec
	lw	x1, 4(x2)	# [4116] solve_one_or_network_fast 1 head dirvec
	addi	x0, x4, 0	# [4117] solve_one_or_network_fast 1 head dirvec
# cont:	if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else ()
# cont:	if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else ()
# cont:	if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	lw	x4, 2(x2)	# [4118] ofs + 1
	addi	x4, x4, 1	# [4119] ofs + 1
	lw	x5, 1(x2)	# [4120] trace_or_matrix_fast (ofs + 1) or_network dirvec
	lw	x6, 0(x2)	# [4121] trace_or_matrix_fast (ofs + 1) or_network dirvec
	jal	x0, -53	# [4122] trace_or_matrix_fast (ofs + 1) or_network dirvec
# judge_intersection_fast.3219:	let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lui	x5, 256	# [4123] tmin
	addi	x5, x5, 124	# [4124] tmin
	lui	x31, 321254	# [4125] 1000000000.0
	addi	x31, x31, -1240	# [4126] 1000000000.0
	xtof	f1, x31	# [4127] 1000000000.0
	fsw	f1, 0(x5)	# [4128] tmin.(0) <- (1000000000.0)
	addi	x5, x0, 0	# [4129] 0
	lui	x6, 256	# [4130] or_net
	addi	x6, x6, 121	# [4131] or_net
	lw	x6, 0(x6)	# [4132] or_net.(0)
	addi	x30, x6, 0	# [4133] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x6, x4, 0	# [4134] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x4, x5, 0	# [4135] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x5, x30, 0	# [4136] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	sw	x1, 0(x2)	# [4137] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x2, x2, 1	# [4138] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	jal	x1, -70	# [4139] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x2, x2, -1	# [4140] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	lw	x1, 0(x2)	# [4141] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x0, x4, 0	# [4142] trace_or_matrix_fast 0 (or_net.(0)) dirvec
	lui	x4, 256	# [4143] tmin
	addi	x4, x4, 124	# [4144] tmin
	# let t = tmin.(0)
	flw	f1, 0(x4)	# [4145] tmin.(0)
	lui	x31, -271156	# [4146] -0.1
	addi	x31, x31, -819	# [4147] -0.1
	xtof	f2, x31	# [4148] -0.1
	flt	x4, f2, f1	# [4149] fless (-0.1) t
	bne	x4, x0, 3	# [4150] if (fless (-0.1) t) then (fless t 100000000.0) else false
# beq:	false
	addi	x4, x0, 0	# [4151] false
	jalr	x0, x1, 0	# [4152] false
# bne:	fless t 100000000.0
	lui	x31, 314347	# [4153] 100000000.0
	addi	x31, x31, -992	# [4154] 100000000.0
	xtof	f2, x31	# [4155] 100000000.0
	flt	x4, f1, f2	# [4156] fless t 100000000.0
	jalr	x0, x1, 0	# [4157] fless t 100000000.0
# get_nvector_rect.3221:	let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	lui	x5, 256	# [4158] intsec_rectside
	addi	x5, x5, 123	# [4159] intsec_rectside
	# let rectside = intsec_rectside.(0)
	lw	x5, 0(x5)	# [4160] intsec_rectside.(0)
	lui	x6, 256	# [4161] nvector
	addi	x6, x6, 131	# [4162] nvector
	sw	x4, 0(x2)	# [4163] vecbzero nvector
	sw	x5, 1(x2)	# [4164] vecbzero nvector
	addi	x4, x6, 0	# [4165] vecbzero nvector
	sw	x1, 2(x2)	# [4166] vecbzero nvector
	addi	x2, x2, 3	# [4167] vecbzero nvector
	jal	x1, -4133	# [4168] vecbzero nvector
	addi	x2, x2, -3	# [4169] vecbzero nvector
	lw	x1, 2(x2)	# [4170] vecbzero nvector
	addi	x0, x4, 0	# [4171] vecbzero nvector
	lui	x4, 256	# [4172] nvector
	addi	x4, x4, 131	# [4173] nvector
	lw	x5, 1(x2)	# [4174] rectside-1
	addi	x6, x5, -1	# [4175] rectside-1
	addi	x5, x5, -1	# [4176] rectside-1
	lw	x7, 0(x2)	# [4177] dirvec.(rectside-1)
	add	x31, x7, x5	# [4178] dirvec.(rectside-1)
	flw	f1, 0(x31)	# [4179] dirvec.(rectside-1)
	sw	x6, 2(x2)	# [4180] sgn (dirvec.(rectside-1))
	sw	x4, 3(x2)	# [4181] sgn (dirvec.(rectside-1))
	sw	x1, 4(x2)	# [4182] sgn (dirvec.(rectside-1))
	addi	x2, x2, 5	# [4183] sgn (dirvec.(rectside-1))
	jal	x1, -4182	# [4184] sgn (dirvec.(rectside-1))
	addi	x2, x2, -5	# [4185] sgn (dirvec.(rectside-1))
	lw	x1, 4(x2)	# [4186] sgn (dirvec.(rectside-1))
	fneg	f1, f1	# [4187] fneg (sgn (dirvec.(rectside-1)))
	lw	x4, 2(x2)	# [4188] nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	lw	x5, 3(x2)	# [4189] nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	add	x31, x5, x4	# [4190] nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	fsw	f1, 0(x31)	# [4191] nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	jalr x0, x1, 0	# [4192] nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
# get_nvector_plane.3223:	let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	lui	x5, 256	# [4193] nvector
	addi	x5, x5, 131	# [4194] nvector
	sw	x4, 0(x2)	# [4195] o_param_a m
	sw	x5, 1(x2)	# [4196] o_param_a m
	sw	x1, 2(x2)	# [4197] o_param_a m
	addi	x2, x2, 3	# [4198] o_param_a m
	jal	x1, -4033	# [4199] o_param_a m
	addi	x2, x2, -3	# [4200] o_param_a m
	lw	x1, 2(x2)	# [4201] o_param_a m
	fneg	f1, f1	# [4202] fneg (o_param_a m)
	lw	x4, 1(x2)	# [4203] nvector.(0) <- fneg (o_param_a m)
	fsw	f1, 0(x4)	# [4204] nvector.(0) <- fneg (o_param_a m)
	lui	x4, 256	# [4205] nvector
	addi	x4, x4, 131	# [4206] nvector
	lw	x5, 0(x2)	# [4207] o_param_b m
	sw	x4, 2(x2)	# [4208] o_param_b m
	addi	x4, x5, 0	# [4209] o_param_b m
	sw	x1, 3(x2)	# [4210] o_param_b m
	addi	x2, x2, 4	# [4211] o_param_b m
	jal	x1, -4043	# [4212] o_param_b m
	addi	x2, x2, -4	# [4213] o_param_b m
	lw	x1, 3(x2)	# [4214] o_param_b m
	fneg	f1, f1	# [4215] fneg (o_param_b m)
	lw	x4, 2(x2)	# [4216] nvector.(1) <- fneg (o_param_b m)
	fsw	f1, 1(x4)	# [4217] nvector.(1) <- fneg (o_param_b m)
	lui	x4, 256	# [4218] nvector
	addi	x4, x4, 131	# [4219] nvector
	lw	x5, 0(x2)	# [4220] o_param_c m
	sw	x4, 3(x2)	# [4221] o_param_c m
	addi	x4, x5, 0	# [4222] o_param_c m
	sw	x1, 4(x2)	# [4223] o_param_c m
	addi	x2, x2, 5	# [4224] o_param_c m
	jal	x1, -4053	# [4225] o_param_c m
	addi	x2, x2, -5	# [4226] o_param_c m
	lw	x1, 4(x2)	# [4227] o_param_c m
	fneg	f1, f1	# [4228] fneg (o_param_c m)
	lw	x4, 3(x2)	# [4229] nvector.(2) <- fneg (o_param_c m)
	fsw	f1, 2(x4)	# [4230] nvector.(2) <- fneg (o_param_c m)
	jalr x0, x1, 0	# [4231] nvector.(2) <- fneg (o_param_c m)
# get_nvector_second.3225:	let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	lui	x5, 256	# [4232] intersection_point
	addi	x5, x5, 127	# [4233] intersection_point
	flw	f1, 0(x5)	# [4234] intersection_point.(0)
	sw	x4, 0(x2)	# [4235] o_param_x m
	fsw	f1, 1(x2)	# [4236] o_param_x m
	sw	x1, 2(x2)	# [4237] o_param_x m
	addi	x2, x2, 3	# [4238] o_param_x m
	jal	x1, -4062	# [4239] o_param_x m
	addi	x2, x2, -3	# [4240] o_param_x m
	lw	x1, 2(x2)	# [4241] o_param_x m
	flw	f2, 1(x2)	# [4242] intersection_point.(0) -. o_param_x m
	# let p0 = intersection_point.(0) -. o_param_x m
	fsub	f1, f2, f1	# [4243] intersection_point.(0) -. o_param_x m
	lui	x4, 256	# [4244] intersection_point
	addi	x4, x4, 127	# [4245] intersection_point
	flw	f2, 1(x4)	# [4246] intersection_point.(1)
	lw	x4, 0(x2)	# [4247] o_param_y m
	fsw	f1, 2(x2)	# [4248] o_param_y m
	fsw	f2, 3(x2)	# [4249] o_param_y m
	sw	x1, 4(x2)	# [4250] o_param_y m
	addi	x2, x2, 5	# [4251] o_param_y m
	jal	x1, -4072	# [4252] o_param_y m
	addi	x2, x2, -5	# [4253] o_param_y m
	lw	x1, 4(x2)	# [4254] o_param_y m
	flw	f2, 3(x2)	# [4255] intersection_point.(1) -. o_param_y m
	# let p1 = intersection_point.(1) -. o_param_y m
	fsub	f1, f2, f1	# [4256] intersection_point.(1) -. o_param_y m
	lui	x4, 256	# [4257] intersection_point
	addi	x4, x4, 127	# [4258] intersection_point
	flw	f2, 2(x4)	# [4259] intersection_point.(2)
	lw	x4, 0(x2)	# [4260] o_param_z m
	fsw	f1, 4(x2)	# [4261] o_param_z m
	fsw	f2, 5(x2)	# [4262] o_param_z m
	sw	x1, 6(x2)	# [4263] o_param_z m
	addi	x2, x2, 7	# [4264] o_param_z m
	jal	x1, -4082	# [4265] o_param_z m
	addi	x2, x2, -7	# [4266] o_param_z m
	lw	x1, 6(x2)	# [4267] o_param_z m
	flw	f2, 5(x2)	# [4268] intersection_point.(2) -. o_param_z m
	# let p2 = intersection_point.(2) -. o_param_z m
	fsub	f1, f2, f1	# [4269] intersection_point.(2) -. o_param_z m
	lw	x4, 0(x2)	# [4270] o_param_a m
	fsw	f1, 6(x2)	# [4271] o_param_a m
	sw	x1, 7(x2)	# [4272] o_param_a m
	addi	x2, x2, 8	# [4273] o_param_a m
	jal	x1, -4108	# [4274] o_param_a m
	addi	x2, x2, -8	# [4275] o_param_a m
	lw	x1, 7(x2)	# [4276] o_param_a m
	flw	f2, 2(x2)	# [4277] p0 *. o_param_a m
	# let d0 = p0 *. o_param_a m
	fmul	f1, f2, f1	# [4278] p0 *. o_param_a m
	lw	x4, 0(x2)	# [4279] o_param_b m
	fsw	f1, 7(x2)	# [4280] o_param_b m
	sw	x1, 8(x2)	# [4281] o_param_b m
	addi	x2, x2, 9	# [4282] o_param_b m
	jal	x1, -4114	# [4283] o_param_b m
	addi	x2, x2, -9	# [4284] o_param_b m
	lw	x1, 8(x2)	# [4285] o_param_b m
	flw	f2, 4(x2)	# [4286] p1 *. o_param_b m
	# let d1 = p1 *. o_param_b m
	fmul	f1, f2, f1	# [4287] p1 *. o_param_b m
	lw	x4, 0(x2)	# [4288] o_param_c m
	fsw	f1, 8(x2)	# [4289] o_param_c m
	sw	x1, 9(x2)	# [4290] o_param_c m
	addi	x2, x2, 10	# [4291] o_param_c m
	jal	x1, -4120	# [4292] o_param_c m
	addi	x2, x2, -10	# [4293] o_param_c m
	lw	x1, 9(x2)	# [4294] o_param_c m
	flw	f2, 6(x2)	# [4295] p2 *. o_param_c m
	# let d2 = p2 *. o_param_c m
	fmul	f1, f2, f1	# [4296] p2 *. o_param_c m
	lw	x4, 0(x2)	# [4297] o_isrot m
	fsw	f1, 9(x2)	# [4298] o_isrot m
	sw	x1, 10(x2)	# [4299] o_isrot m
	addi	x2, x2, 11	# [4300] o_isrot m
	jal	x1, -4137	# [4301] o_isrot m
	addi	x2, x2, -11	# [4302] o_isrot m
	lw	x1, 10(x2)	# [4303] o_isrot m
	bne	x4, x0, 14	# [4304] if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) )
# beq:	nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2
	lui	x4, 256	# [4305] nvector
	addi	x4, x4, 131	# [4306] nvector
	flw	f1, 7(x2)	# [4307] nvector.(0) <- d0
	fsw	f1, 0(x4)	# [4308] nvector.(0) <- d0
	lui	x4, 256	# [4309] nvector
	addi	x4, x4, 131	# [4310] nvector
	flw	f1, 8(x2)	# [4311] nvector.(1) <- d1
	fsw	f1, 1(x4)	# [4312] nvector.(1) <- d1
	lui	x4, 256	# [4313] nvector
	addi	x4, x4, 131	# [4314] nvector
	flw	f1, 9(x2)	# [4315] nvector.(2) <- d2
	fsw	f1, 2(x4)	# [4316] nvector.(2) <- d2
	jal	x0, 85	# [4317] if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) )
# bne:	nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	lui	x4, 256	# [4318] nvector
	addi	x4, x4, 131	# [4319] nvector
	lw	x5, 0(x2)	# [4320] o_param_r3 m
	sw	x4, 10(x2)	# [4321] o_param_r3 m
	addi	x4, x5, 0	# [4322] o_param_r3 m
	sw	x1, 11(x2)	# [4323] o_param_r3 m
	addi	x2, x2, 12	# [4324] o_param_r3 m
	jal	x1, -4118	# [4325] o_param_r3 m
	addi	x2, x2, -12	# [4326] o_param_r3 m
	lw	x1, 11(x2)	# [4327] o_param_r3 m
	flw	f2, 4(x2)	# [4328] p1 *. o_param_r3 m
	fmul	f1, f2, f1	# [4329] p1 *. o_param_r3 m
	lw	x4, 0(x2)	# [4330] o_param_r2 m
	fsw	f1, 11(x2)	# [4331] o_param_r2 m
	sw	x1, 12(x2)	# [4332] o_param_r2 m
	addi	x2, x2, 13	# [4333] o_param_r2 m
	jal	x1, -4130	# [4334] o_param_r2 m
	addi	x2, x2, -13	# [4335] o_param_r2 m
	lw	x1, 12(x2)	# [4336] o_param_r2 m
	flw	f2, 6(x2)	# [4337] p2 *. o_param_r2 m
	fmul	f1, f2, f1	# [4338] p2 *. o_param_r2 m
	flw	f3, 11(x2)	# [4339] p1 *. o_param_r3 m +. p2 *. o_param_r2 m
	fadd	f1, f3, f1	# [4340] p1 *. o_param_r3 m +. p2 *. o_param_r2 m
	fmul	f1, f1, f27	# [4341] fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	flw	f3, 7(x2)	# [4342] d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	fadd	f1, f3, f1	# [4343] d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	lw	x4, 10(x2)	# [4344] nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	fsw	f1, 0(x4)	# [4345] nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	lui	x4, 256	# [4346] nvector
	addi	x4, x4, 131	# [4347] nvector
	lw	x5, 0(x2)	# [4348] o_param_r3 m
	sw	x4, 12(x2)	# [4349] o_param_r3 m
	addi	x4, x5, 0	# [4350] o_param_r3 m
	sw	x1, 13(x2)	# [4351] o_param_r3 m
	addi	x2, x2, 14	# [4352] o_param_r3 m
	jal	x1, -4146	# [4353] o_param_r3 m
	addi	x2, x2, -14	# [4354] o_param_r3 m
	lw	x1, 13(x2)	# [4355] o_param_r3 m
	flw	f2, 2(x2)	# [4356] p0 *. o_param_r3 m
	fmul	f1, f2, f1	# [4357] p0 *. o_param_r3 m
	lw	x4, 0(x2)	# [4358] o_param_r1 m
	fsw	f1, 13(x2)	# [4359] o_param_r1 m
	sw	x1, 14(x2)	# [4360] o_param_r1 m
	addi	x2, x2, 15	# [4361] o_param_r1 m
	jal	x1, -4161	# [4362] o_param_r1 m
	addi	x2, x2, -15	# [4363] o_param_r1 m
	lw	x1, 14(x2)	# [4364] o_param_r1 m
	flw	f2, 6(x2)	# [4365] p2 *. o_param_r1 m
	fmul	f1, f2, f1	# [4366] p2 *. o_param_r1 m
	flw	f2, 13(x2)	# [4367] p0 *. o_param_r3 m +. p2 *. o_param_r1 m
	fadd	f1, f2, f1	# [4368] p0 *. o_param_r3 m +. p2 *. o_param_r1 m
	fmul	f1, f1, f27	# [4369] fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	flw	f2, 8(x2)	# [4370] d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	fadd	f1, f2, f1	# [4371] d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	lw	x4, 12(x2)	# [4372] nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	fsw	f1, 1(x4)	# [4373] nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	lui	x4, 256	# [4374] nvector
	addi	x4, x4, 131	# [4375] nvector
	lw	x5, 0(x2)	# [4376] o_param_r2 m
	sw	x4, 14(x2)	# [4377] o_param_r2 m
	addi	x4, x5, 0	# [4378] o_param_r2 m
	sw	x1, 15(x2)	# [4379] o_param_r2 m
	addi	x2, x2, 16	# [4380] o_param_r2 m
	jal	x1, -4177	# [4381] o_param_r2 m
	addi	x2, x2, -16	# [4382] o_param_r2 m
	lw	x1, 15(x2)	# [4383] o_param_r2 m
	flw	f2, 2(x2)	# [4384] p0 *. o_param_r2 m
	fmul	f1, f2, f1	# [4385] p0 *. o_param_r2 m
	lw	x4, 0(x2)	# [4386] o_param_r1 m
	fsw	f1, 15(x2)	# [4387] o_param_r1 m
	sw	x1, 16(x2)	# [4388] o_param_r1 m
	addi	x2, x2, 17	# [4389] o_param_r1 m
	jal	x1, -4189	# [4390] o_param_r1 m
	addi	x2, x2, -17	# [4391] o_param_r1 m
	lw	x1, 16(x2)	# [4392] o_param_r1 m
	flw	f2, 4(x2)	# [4393] p1 *. o_param_r1 m
	fmul	f1, f2, f1	# [4394] p1 *. o_param_r1 m
	flw	f2, 15(x2)	# [4395] p0 *. o_param_r2 m +. p1 *. o_param_r1 m
	fadd	f1, f2, f1	# [4396] p0 *. o_param_r2 m +. p1 *. o_param_r1 m
	fmul	f1, f1, f27	# [4397] fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	flw	f2, 9(x2)	# [4398] d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	fadd	f1, f2, f1	# [4399] d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	lw	x4, 14(x2)	# [4400] nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	fsw	f1, 2(x4)	# [4401] nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
# cont:	if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) )
	lui	x4, 256	# [4402] nvector
	addi	x4, x4, 131	# [4403] nvector
	lw	x5, 0(x2)	# [4404] o_isinvert m
	sw	x4, 16(x2)	# [4405] o_isinvert m
	addi	x4, x5, 0	# [4406] o_isinvert m
	sw	x1, 17(x2)	# [4407] o_isinvert m
	addi	x2, x2, 18	# [4408] o_isinvert m
	jal	x1, -4247	# [4409] o_isinvert m
	addi	x2, x2, -18	# [4410] o_isinvert m
	lw	x1, 17(x2)	# [4411] o_isinvert m
	addi	x5, x4, 0	# [4412] o_isinvert m
	lw	x4, 16(x2)	# [4413] vecunit_sgn nvector (o_isinvert m)
	jal	x0, -4369	# [4414] vecunit_sgn nvector (o_isinvert m)
# get_nvector.3227:	let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	sw	x4, 0(x2)	# [4415] o_form m
	sw	x5, 1(x2)	# [4416] o_form m
	# let m_shape = o_form m
	sw	x1, 2(x2)	# [4417] o_form m
	addi	x2, x2, 3	# [4418] o_form m
	jal	x1, -4261	# [4419] o_form m
	addi	x2, x2, -3	# [4420] o_form m
	lw	x1, 2(x2)	# [4421] o_form m
	addi	x5, x0, 1	# [4422] 1
	bne	x4, x5, 3	# [4423] if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
# beq:	get_nvector_rect dirvec
	lw	x4, 1(x2)	# [4424] get_nvector_rect dirvec
	jal	x0, -267	# [4425] get_nvector_rect dirvec
# bne:	if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	addi	x5, x0, 2	# [4426] 2
	bne	x4, x5, 3	# [4427] if m_shape = 2 then get_nvector_plane m else get_nvector_second m
# beq:	get_nvector_plane m
	lw	x4, 0(x2)	# [4428] get_nvector_plane m
	jal	x0, -236	# [4429] get_nvector_plane m
# bne:	get_nvector_second m
	lw	x4, 0(x2)	# [4430] get_nvector_second m
	jal	x0, -199	# [4431] get_nvector_second m
# utexture.3230:	let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	sw	x5, 0(x2)	# [4432] o_texturetype m
	sw	x4, 1(x2)	# [4433] o_texturetype m
	# let m_tex = o_texturetype m
	sw	x1, 2(x2)	# [4434] o_texturetype m
	addi	x2, x2, 3	# [4435] o_texturetype m
	jal	x1, -4280	# [4436] o_texturetype m
	addi	x2, x2, -3	# [4437] o_texturetype m
	lw	x1, 2(x2)	# [4438] o_texturetype m
	lui	x5, 256	# [4439] texture_color
	addi	x5, x5, 134	# [4440] texture_color
	lw	x6, 1(x2)	# [4441] o_color_red m
	sw	x4, 2(x2)	# [4442] o_color_red m
	sw	x5, 3(x2)	# [4443] o_color_red m
	addi	x4, x6, 0	# [4444] o_color_red m
	sw	x1, 4(x2)	# [4445] o_color_red m
	addi	x2, x2, 5	# [4446] o_color_red m
	jal	x1, -4255	# [4447] o_color_red m
	addi	x2, x2, -5	# [4448] o_color_red m
	lw	x1, 4(x2)	# [4449] o_color_red m
	lw	x4, 3(x2)	# [4450] texture_color.(0) <- o_color_red m
	fsw	f1, 0(x4)	# [4451] texture_color.(0) <- o_color_red m
	lui	x4, 256	# [4452] texture_color
	addi	x4, x4, 134	# [4453] texture_color
	lw	x5, 1(x2)	# [4454] o_color_green m
	sw	x4, 4(x2)	# [4455] o_color_green m
	addi	x4, x5, 0	# [4456] o_color_green m
	sw	x1, 5(x2)	# [4457] o_color_green m
	addi	x2, x2, 6	# [4458] o_color_green m
	jal	x1, -4264	# [4459] o_color_green m
	addi	x2, x2, -6	# [4460] o_color_green m
	lw	x1, 5(x2)	# [4461] o_color_green m
	lw	x4, 4(x2)	# [4462] texture_color.(1) <- o_color_green m
	fsw	f1, 1(x4)	# [4463] texture_color.(1) <- o_color_green m
	lui	x4, 256	# [4464] texture_color
	addi	x4, x4, 134	# [4465] texture_color
	lw	x5, 1(x2)	# [4466] o_color_blue m
	sw	x4, 5(x2)	# [4467] o_color_blue m
	addi	x4, x5, 0	# [4468] o_color_blue m
	sw	x1, 6(x2)	# [4469] o_color_blue m
	addi	x2, x2, 7	# [4470] o_color_blue m
	jal	x1, -4273	# [4471] o_color_blue m
	addi	x2, x2, -7	# [4472] o_color_blue m
	lw	x1, 6(x2)	# [4473] o_color_blue m
	lw	x4, 5(x2)	# [4474] texture_color.(2) <- o_color_blue m
	fsw	f1, 2(x4)	# [4475] texture_color.(2) <- o_color_blue m
	addi	x4, x0, 1	# [4476] 1
	lw	x5, 2(x2)	# [4477] if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	bne	x5, x4, 65	# [4478] if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	lw	x4, 0(x2)	# [4479] p.(0)
	flw	f1, 0(x4)	# [4480] p.(0)
	lw	x5, 1(x2)	# [4481] o_param_x m
	fsw	f1, 6(x2)	# [4482] o_param_x m
	addi	x4, x5, 0	# [4483] o_param_x m
	sw	x1, 7(x2)	# [4484] o_param_x m
	addi	x2, x2, 8	# [4485] o_param_x m
	jal	x1, -4309	# [4486] o_param_x m
	addi	x2, x2, -8	# [4487] o_param_x m
	lw	x1, 7(x2)	# [4488] o_param_x m
	flw	f2, 6(x2)	# [4489] p.(0) -. o_param_x m
	# let w1 = p.(0) -. o_param_x m
	fsub	f1, f2, f1	# [4490] p.(0) -. o_param_x m
	lui	x31, 251084	# [4491] 0.05
	addi	x31, x31, -819	# [4492] 0.05
	xtof	f2, x31	# [4493] 0.05
	fmul	f2, f1, f2	# [4494] w1 *. 0.05
	ftoi	x31, f2	# [4495] floor (w1 *. 0.05)
	itof	f2, x31	# [4496] floor (w1 *. 0.05)
	# let d1 = (floor (w1 *. 0.05)) *. 20.0
	fmul	f2, f2, f16	# [4497] (floor (w1 *. 0.05)) *. 20.0
	fsub	f1, f1, f2	# [4498] w1 -. d1
	# let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0
	flt	x4, f1, f14	# [4499] fless (w1 -. d1) 10.0
	lw	x5, 0(x2)	# [4500] p.(2)
	flw	f1, 2(x5)	# [4501] p.(2)
	lw	x5, 1(x2)	# [4502] o_param_z m
	sw	x4, 7(x2)	# [4503] o_param_z m
	fsw	f1, 8(x2)	# [4504] o_param_z m
	addi	x4, x5, 0	# [4505] o_param_z m
	sw	x1, 9(x2)	# [4506] o_param_z m
	addi	x2, x2, 10	# [4507] o_param_z m
	jal	x1, -4325	# [4508] o_param_z m
	addi	x2, x2, -10	# [4509] o_param_z m
	lw	x1, 9(x2)	# [4510] o_param_z m
	flw	f2, 8(x2)	# [4511] p.(2) -. o_param_z m
	# let w3 = p.(2) -. o_param_z m
	fsub	f1, f2, f1	# [4512] p.(2) -. o_param_z m
	lui	x31, 251084	# [4513] 0.05
	addi	x31, x31, -819	# [4514] 0.05
	xtof	f2, x31	# [4515] 0.05
	fmul	f2, f1, f2	# [4516] w3 *. 0.05
	ftoi	x31, f2	# [4517] floor (w3 *. 0.05)
	itof	f2, x31	# [4518] floor (w3 *. 0.05)
	# let d2 = (floor (w3 *. 0.05)) *. 20.0
	fmul	f2, f2, f16	# [4519] (floor (w3 *. 0.05)) *. 20.0
	fsub	f1, f1, f2	# [4520] w3 -. d2
	# let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0
	flt	x4, f1, f14	# [4521] fless (w3 -. d2) 10.0
	lui	x5, 256	# [4522] texture_color
	addi	x5, x5, 134	# [4523] texture_color
	lw	x6, 7(x2)	# [4524] if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	bne	x6, x0, 9	# [4525] if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
# beq:	if flag2 then 0.0 else 255.0
	bne	x4, x0, 5	# [4526] if flag2 then 0.0 else 255.0
# beq:	255.0
	lui	x31, 276464	# [4527] 255.0
	addi	x31, x31, 0	# [4528] 255.0
	xtof	f1, x31	# [4529] 255.0
	jal	x0, 3	# [4530] if flag2 then 0.0 else 255.0
# bne:	0.0
	addi	x31, x0, 0	# [4531] 0.0
	xtof	f1, x31	# [4532] 0.0
# cont:	if flag2 then 0.0 else 255.0
	jal	x0, 8	# [4533] if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
# bne:	if flag2 then 255.0 else 0.0
	bne	x4, x0, 4	# [4534] if flag2 then 255.0 else 0.0
# beq:	0.0
	addi	x31, x0, 0	# [4535] 0.0
	xtof	f1, x31	# [4536] 0.0
	jal	x0, 4	# [4537] if flag2 then 255.0 else 0.0
# bne:	255.0
	lui	x31, 276464	# [4538] 255.0
	addi	x31, x31, 0	# [4539] 255.0
	xtof	f1, x31	# [4540] 255.0
# cont:	if flag2 then 255.0 else 0.0
# cont:	if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	fsw	f1, 1(x5)	# [4541] texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	jalr x0, x1, 0	# [4542] texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
# bne:	if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x4, x0, 2	# [4543] 2
	bne	x5, x4, 59	# [4544] if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2)
	lw	x4, 0(x2)	# [4545] p.(1)
	flw	f1, 1(x4)	# [4546] p.(1)
	fmul	f1, f1, f26	# [4547] p.(1) *. 0.25
	lui	x31, 256559	# [4548]
	addi	x31, x31, -1661	# [4549]
	xtof	f2, x31	# [4550]
	fmul	f2, f1, f2	# [4551]
	ftoi	x4, f2	# [4552]
	andi	x5, x4, 1	# [4553]
	itof	f2, x5	# [4554]
	fmul	f2, f2, f12	# [4555]
	fsub	f2, f11, f2	# [4556]
	itof	f3, x4	# [4557]
	fmul	f3, f3, f28	# [4558]
	fsub	f1, f1, f3	# [4559]
	lui	x31, 261264	# [4560]
	addi	x31, x31, -37	# [4561]
	xtof	f3, x31	# [4562]
	fsub	f1, f1, f3	# [4563]
	fmul	f1, f1, f1	# [4564]
	fmul	f3, f1, f27	# [4565]
	fmul	f4, f3, f1	# [4566]
	lui	x31, 252586	# [4567]
	addi	x31, x31, -1365	# [4568]
	xtof	f5, x31	# [4569]
	fmul	f4, f4, f5	# [4570]
	fmul	f5, f4, f1	# [4571]
	lui	x31, 249992	# [4572]
	addi	x31, x31, -1911	# [4573]
	xtof	f6, x31	# [4574]
	fmul	f5, f5, f6	# [4575]
	fmul	f6, f5, f1	# [4576]
	lui	x31, 248100	# [4577]
	addi	x31, x31, -1755	# [4578]
	xtof	f7, x31	# [4579]
	fmul	f6, f6, f7	# [4580]
	fmul	f1, f6, f1	# [4581]
	lui	x31, 246624	# [4582]
	addi	x31, x31, -1183	# [4583]
	xtof	f7, x31	# [4584]
	fmul	f1, f1, f7	# [4585]
	fsub	f3, f11, f3	# [4586]
	fadd	f3, f3, f4	# [4587]
	fsub	f3, f3, f5	# [4588]
	fadd	f3, f3, f6	# [4589]
	fsub	f1, f3, f1	# [4590]
	fmul	f1, f2, f1	# [4591]
	# let w2 = fsqr (sin (p.(1) *. 0.25))
	fmul	f1, f1, f1	# [4592] fsqr (sin (p.(1) *. 0.25))
	lui	x4, 256	# [4593] texture_color
	addi	x4, x4, 134	# [4594] texture_color
	fmul	f2, f19, f1	# [4595] 255.0 *. w2
	fsw	f2, 0(x4)	# [4596] texture_color.(0) <- 255.0 *. w2
	lui	x4, 256	# [4597] texture_color
	addi	x4, x4, 134	# [4598] texture_color
	fsub	f1, f11, f1	# [4599] 1.0 -. w2
	fmul	f1, f19, f1	# [4600] 255.0 *. (1.0 -. w2)
	fsw	f1, 1(x4)	# [4601] texture_color.(1) <- 255.0 *. (1.0 -. w2)
	jalr x0, x1, 0	# [4602] texture_color.(1) <- 255.0 *. (1.0 -. w2)
# bne:	if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x4, x0, 3	# [4603] 3
	bne	x5, x4, 73	# [4604] if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0
	lw	x4, 0(x2)	# [4605] p.(0)
	flw	f1, 0(x4)	# [4606] p.(0)
	lw	x5, 1(x2)	# [4607] o_param_x m
	fsw	f1, 9(x2)	# [4608] o_param_x m
	addi	x4, x5, 0	# [4609] o_param_x m
	sw	x1, 10(x2)	# [4610] o_param_x m
	addi	x2, x2, 11	# [4611] o_param_x m
	jal	x1, -4435	# [4612] o_param_x m
	addi	x2, x2, -11	# [4613] o_param_x m
	lw	x1, 10(x2)	# [4614] o_param_x m
	flw	f2, 9(x2)	# [4615] p.(0) -. o_param_x m
	# let w1 = p.(0) -. o_param_x m
	fsub	f1, f2, f1	# [4616] p.(0) -. o_param_x m
	lw	x4, 0(x2)	# [4617] p.(2)
	flw	f2, 2(x4)	# [4618] p.(2)
	lw	x4, 1(x2)	# [4619] o_param_z m
	fsw	f1, 10(x2)	# [4620] o_param_z m
	fsw	f2, 11(x2)	# [4621] o_param_z m
	sw	x1, 12(x2)	# [4622] o_param_z m
	addi	x2, x2, 13	# [4623] o_param_z m
	jal	x1, -4441	# [4624] o_param_z m
	addi	x2, x2, -13	# [4625] o_param_z m
	lw	x1, 12(x2)	# [4626] o_param_z m
	flw	f2, 11(x2)	# [4627] p.(2) -. o_param_z m
	# let w3 = p.(2) -. o_param_z m
	fsub	f1, f2, f1	# [4628] p.(2) -. o_param_z m
	flw	f2, 10(x2)	# [4629] fsqr w1
	fmul	f2, f2, f2	# [4630] fsqr w1
	fmul	f1, f1, f1	# [4631] fsqr w3
	fadd	f1, f2, f1	# [4632] fsqr w1 +. fsqr w3
	fsqrt	f1, f1	# [4633] sqrt (fsqr w1 +. fsqr w3)
	# let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0
	fmul	f1, f1, f21	# [4634] sqrt (fsqr w1 +. fsqr w3) /. 10.0
	ftoi	x31, f1	# [4635] floor w2
	itof	f2, x31	# [4636] floor w2
	fsub	f1, f1, f2	# [4637] w2 -. floor w2
	# let w4 = (w2 -. floor w2) *. 3.1415927
	fmul	f1, f1, f28	# [4638] (w2 -. floor w2) *. 3.1415927
	fmul	f1, f1, f1	# [4639]
	fmul	f2, f1, f27	# [4640]
	fmul	f3, f2, f1	# [4641]
	lui	x31, 252586	# [4642]
	addi	x31, x31, -1365	# [4643]
	xtof	f4, x31	# [4644]
	fmul	f3, f3, f4	# [4645]
	fmul	f4, f3, f1	# [4646]
	lui	x31, 249992	# [4647]
	addi	x31, x31, -1911	# [4648]
	xtof	f5, x31	# [4649]
	fmul	f4, f4, f5	# [4650]
	fmul	f5, f4, f1	# [4651]
	lui	x31, 248100	# [4652]
	addi	x31, x31, -1755	# [4653]
	xtof	f6, x31	# [4654]
	fmul	f5, f5, f6	# [4655]
	fmul	f1, f5, f1	# [4656]
	lui	x31, 246624	# [4657]
	addi	x31, x31, -1183	# [4658]
	xtof	f6, x31	# [4659]
	fmul	f1, f1, f6	# [4660]
	fsub	f2, f11, f2	# [4661]
	fadd	f2, f2, f3	# [4662]
	fsub	f2, f2, f4	# [4663]
	fadd	f2, f2, f5	# [4664]
	fsub	f1, f2, f1	# [4665]
	# let cws = fsqr (cos w4)
	fmul	f1, f1, f1	# [4666] fsqr (cos w4)
	lui	x4, 256	# [4667] texture_color
	addi	x4, x4, 134	# [4668] texture_color
	fmul	f2, f1, f19	# [4669] cws *. 255.0
	fsw	f2, 1(x4)	# [4670] texture_color.(1) <- cws *. 255.0
	lui	x4, 256	# [4671] texture_color
	addi	x4, x4, 134	# [4672] texture_color
	fsub	f1, f11, f1	# [4673] 1.0 -. cws
	fmul	f1, f1, f19	# [4674] (1.0 -. cws) *. 255.0
	fsw	f1, 2(x4)	# [4675] texture_color.(2) <- (1.0 -. cws) *. 255.0
	jalr x0, x1, 0	# [4676] texture_color.(2) <- (1.0 -. cws) *. 255.0
# bne:	if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x4, x0, 4	# [4677] 4
	bne	x5, x4, 195	# [4678] if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3
	lw	x4, 0(x2)	# [4679] p.(0)
	flw	f1, 0(x4)	# [4680] p.(0)
	lw	x5, 1(x2)	# [4681] o_param_x m
	fsw	f1, 12(x2)	# [4682] o_param_x m
	addi	x4, x5, 0	# [4683] o_param_x m
	sw	x1, 13(x2)	# [4684] o_param_x m
	addi	x2, x2, 14	# [4685] o_param_x m
	jal	x1, -4509	# [4686] o_param_x m
	addi	x2, x2, -14	# [4687] o_param_x m
	lw	x1, 13(x2)	# [4688] o_param_x m
	flw	f2, 12(x2)	# [4689] p.(0) -. o_param_x m
	fsub	f1, f2, f1	# [4690] p.(0) -. o_param_x m
	lw	x4, 1(x2)	# [4691] o_param_a m
	fsw	f1, 13(x2)	# [4692] o_param_a m
	sw	x1, 14(x2)	# [4693] o_param_a m
	addi	x2, x2, 15	# [4694] o_param_a m
	jal	x1, -4529	# [4695] o_param_a m
	addi	x2, x2, -15	# [4696] o_param_a m
	lw	x1, 14(x2)	# [4697] o_param_a m
	fsqrt	f1, f1	# [4698] sqrt (o_param_a m)
	flw	f2, 13(x2)	# [4699] (p.(0) -. o_param_x m) *. (sqrt (o_param_a m))
	# let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m))
	fmul	f1, f2, f1	# [4700] (p.(0) -. o_param_x m) *. (sqrt (o_param_a m))
	lw	x4, 0(x2)	# [4701] p.(2)
	flw	f2, 2(x4)	# [4702] p.(2)
	lw	x5, 1(x2)	# [4703] o_param_z m
	fsw	f1, 14(x2)	# [4704] o_param_z m
	fsw	f2, 15(x2)	# [4705] o_param_z m
	addi	x4, x5, 0	# [4706] o_param_z m
	sw	x1, 16(x2)	# [4707] o_param_z m
	addi	x2, x2, 17	# [4708] o_param_z m
	jal	x1, -4526	# [4709] o_param_z m
	addi	x2, x2, -17	# [4710] o_param_z m
	lw	x1, 16(x2)	# [4711] o_param_z m
	flw	f2, 15(x2)	# [4712] p.(2) -. o_param_z m
	fsub	f1, f2, f1	# [4713] p.(2) -. o_param_z m
	lw	x4, 1(x2)	# [4714] o_param_c m
	fsw	f1, 16(x2)	# [4715] o_param_c m
	sw	x1, 17(x2)	# [4716] o_param_c m
	addi	x2, x2, 18	# [4717] o_param_c m
	jal	x1, -4546	# [4718] o_param_c m
	addi	x2, x2, -18	# [4719] o_param_c m
	lw	x1, 17(x2)	# [4720] o_param_c m
	fsqrt	f1, f1	# [4721] sqrt (o_param_c m)
	flw	f2, 16(x2)	# [4722] (p.(2) -. o_param_z m) *. (sqrt (o_param_c m))
	# let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m))
	fmul	f1, f2, f1	# [4723] (p.(2) -. o_param_z m) *. (sqrt (o_param_c m))
	flw	f2, 14(x2)	# [4724] fsqr w1
	fmul	f3, f2, f2	# [4725] fsqr w1
	fmul	f4, f1, f1	# [4726] fsqr w3
	# let w4 = (fsqr w1) +. (fsqr w3)
	fadd	f3, f3, f4	# [4727] (fsqr w1) +. (fsqr w3)
	fabs	f4, f2	# [4728] fabs w1
	lui	x31, 232731	# [4729] 1.0e-4
	addi	x31, x31, 1815	# [4730] 1.0e-4
	xtof	f5, x31	# [4731] 1.0e-4
	flt	x4, f4, f5	# [4732] fless (fabs w1) 1.0e-4
	# let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
	bne	x4, x0, 39	# [4733] if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
# beq:	let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
	fdiv	f1, f1, f2	# [4734] w3 /. w1
	# let w5 = fabs (w3 /. w1)
	fabs	f1, f1	# [4735] fabs (w3 /. w1)
	fsub	f1, f1, f12	# [4736]
	fmul	f1, f1, f22	# [4737]
	fmul	f2, f1, f1	# [4738]
	fmul	f2, f2, f12	# [4739]
	fmul	f4, f2, f1	# [4740]
	lui	x31, 261802	# [4741]
	addi	x31, x31, -1365	# [4742]
	xtof	f5, x31	# [4743]
	fmul	f4, f4, f5	# [4744]
	fmul	f5, f4, f1	# [4745]
	lui	x31, 261399	# [4746]
	addi	x31, x31, 1117	# [4747]
	xtof	f6, x31	# [4748]
	fmul	f5, f5, f6	# [4749]
	fmul	f6, f5, f1	# [4750]
	lui	x31, 260846	# [4751]
	addi	x31, x31, -273	# [4752]
	xtof	f7, x31	# [4753]
	fmul	f6, f6, f7	# [4754]
	lui	x31, 260315	# [4755]
	addi	x31, x31, 1805	# [4756]
	xtof	f7, x31	# [4757]
	fadd	f1, f7, f1	# [4758]
	fsub	f1, f1, f2	# [4759]
	fadd	f1, f1, f4	# [4760]
	fsub	f1, f1, f5	# [4761]
	fadd	f1, f1, f6	# [4762]
	lui	x31, 270080	# [4763] 30.0
	addi	x31, x31, 0	# [4764] 30.0
	xtof	f2, x31	# [4765] 30.0
	fmul	f1, f1, f2	# [4766] (atan w5) *. 30.0
	lui	x31, 256559	# [4767] ((atan w5) *. 30.0) /. 3.1415927
	addi	x31, x31, -1661	# [4768] ((atan w5) *. 30.0) /. 3.1415927
	xtof	f2, x31	# [4769] ((atan w5) *. 30.0) /. 3.1415927
	fmul	f1, f1, f2	# [4770] ((atan w5) *. 30.0) /. 3.1415927
	jal	x0, 4	# [4771] if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
# bne:	15.0
	lui	x31, 268032	# [4772] 15.0
	addi	x31, x31, 0	# [4773] 15.0
	xtof	f1, x31	# [4774] 15.0
# cont:	if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
	ftoi	x31, f1	# [4775] floor w7
	itof	f2, x31	# [4776] floor w7
	# let w9 = w7 -. (floor w7)
	fsub	f1, f1, f2	# [4777] w7 -. (floor w7)
	lw	x4, 0(x2)	# [4778] p.(1)
	flw	f2, 1(x4)	# [4779] p.(1)
	lw	x4, 1(x2)	# [4780] o_param_y m
	fsw	f1, 17(x2)	# [4781] o_param_y m
	fsw	f3, 18(x2)	# [4782] o_param_y m
	fsw	f2, 19(x2)	# [4783] o_param_y m
	sw	x1, 20(x2)	# [4784] o_param_y m
	addi	x2, x2, 21	# [4785] o_param_y m
	jal	x1, -4606	# [4786] o_param_y m
	addi	x2, x2, -21	# [4787] o_param_y m
	lw	x1, 20(x2)	# [4788] o_param_y m
	flw	f2, 19(x2)	# [4789] p.(1) -. o_param_y m
	fsub	f1, f2, f1	# [4790] p.(1) -. o_param_y m
	lw	x4, 1(x2)	# [4791] o_param_b m
	fsw	f1, 20(x2)	# [4792] o_param_b m
	sw	x1, 21(x2)	# [4793] o_param_b m
	addi	x2, x2, 22	# [4794] o_param_b m
	jal	x1, -4626	# [4795] o_param_b m
	addi	x2, x2, -22	# [4796] o_param_b m
	lw	x1, 21(x2)	# [4797] o_param_b m
	fsqrt	f1, f1	# [4798] sqrt (o_param_b m)
	flw	f2, 20(x2)	# [4799] (p.(1) -. o_param_y m) *. (sqrt (o_param_b m))
	# let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m))
	fmul	f1, f2, f1	# [4800] (p.(1) -. o_param_y m) *. (sqrt (o_param_b m))
	flw	f2, 18(x2)	# [4801] fabs w4
	fabs	f3, f2	# [4802] fabs w4
	lui	x31, 232731	# [4803] 1.0e-4
	addi	x31, x31, 1815	# [4804] 1.0e-4
	xtof	f4, x31	# [4805] 1.0e-4
	flt	x4, f3, f4	# [4806] fless (fabs w4) 1.0e-4
	# let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
	bne	x4, x0, 39	# [4807] if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
# beq:	let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
	fdiv	f1, f1, f2	# [4808] w2 /. w4
	# let w6 = fabs (w2 /. w4)
	fabs	f1, f1	# [4809] fabs (w2 /. w4)
	fsub	f1, f1, f12	# [4810]
	fmul	f1, f1, f22	# [4811]
	fmul	f2, f1, f1	# [4812]
	fmul	f2, f2, f12	# [4813]
	fmul	f3, f2, f1	# [4814]
	lui	x31, 261802	# [4815]
	addi	x31, x31, -1365	# [4816]
	xtof	f4, x31	# [4817]
	fmul	f3, f3, f4	# [4818]
	fmul	f4, f3, f1	# [4819]
	lui	x31, 261399	# [4820]
	addi	x31, x31, 1117	# [4821]
	xtof	f5, x31	# [4822]
	fmul	f4, f4, f5	# [4823]
	fmul	f5, f4, f1	# [4824]
	lui	x31, 260846	# [4825]
	addi	x31, x31, -273	# [4826]
	xtof	f6, x31	# [4827]
	fmul	f5, f5, f6	# [4828]
	lui	x31, 260315	# [4829]
	addi	x31, x31, 1805	# [4830]
	xtof	f6, x31	# [4831]
	fadd	f1, f6, f1	# [4832]
	fsub	f1, f1, f2	# [4833]
	fadd	f1, f1, f3	# [4834]
	fsub	f1, f1, f4	# [4835]
	fadd	f1, f1, f5	# [4836]
	lui	x31, 270080	# [4837] 30.0
	addi	x31, x31, 0	# [4838] 30.0
	xtof	f2, x31	# [4839] 30.0
	fmul	f1, f1, f2	# [4840] (atan w6) *. 30.0
	lui	x31, 256559	# [4841] ((atan w6) *. 30.0) /. 3.1415927
	addi	x31, x31, -1661	# [4842] ((atan w6) *. 30.0) /. 3.1415927
	xtof	f2, x31	# [4843] ((atan w6) *. 30.0) /. 3.1415927
	fmul	f1, f1, f2	# [4844] ((atan w6) *. 30.0) /. 3.1415927
	jal	x0, 4	# [4845] if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
# bne:	15.0
	lui	x31, 268032	# [4846] 15.0
	addi	x31, x31, 0	# [4847] 15.0
	xtof	f1, x31	# [4848] 15.0
# cont:	if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
	ftoi	x31, f1	# [4849] floor w8
	itof	f2, x31	# [4850] floor w8
	# let w10 = w8 -. (floor w8)
	fsub	f1, f1, f2	# [4851] w8 -. (floor w8)
	flw	f2, 17(x2)	# [4852] 0.5 -. w9
	fsub	f2, f27, f2	# [4853] 0.5 -. w9
	fmul	f2, f2, f2	# [4854] fsqr (0.5 -. w9)
	fsub	f2, f25, f2	# [4855] 0.15 -. (fsqr (0.5 -. w9))
	fsub	f1, f27, f1	# [4856] 0.5 -. w10
	fmul	f1, f1, f1	# [4857] fsqr (0.5 -. w10)
	# let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10))
	fsub	f1, f2, f1	# [4858] 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10))
	flt	x4, f1, f0	# [4859] fisneg w11
	# let w12 = if fisneg w11 then 0.0 else w11
	bne	x4, x0, 2	# [4860] if fisneg w11 then 0.0 else w11
# beq:	w11
	jal	x0, 3	# [4861] if fisneg w11 then 0.0 else w11
# bne:	0.0
	addi	x31, x0, 0	# [4862] 0.0
	xtof	f1, x31	# [4863] 0.0
# cont:	if fisneg w11 then 0.0 else w11
	lui	x4, 256	# [4864] texture_color
	addi	x4, x4, 134	# [4865] texture_color
	fmul	f1, f19, f1	# [4866] 255.0 *. w12
	lui	x31, 263509	# [4867] (255.0 *. w12) /. 0.3
	addi	x31, x31, 1365	# [4868] (255.0 *. w12) /. 0.3
	xtof	f2, x31	# [4869] (255.0 *. w12) /. 0.3
	fmul	f1, f1, f2	# [4870] (255.0 *. w12) /. 0.3
	fsw	f1, 2(x4)	# [4871] texture_color.(2) <- (255.0 *. w12) /. 0.3
	jalr x0, x1, 0	# [4872] texture_color.(2) <- (255.0 *. w12) /. 0.3
# bne:	()
	jalr x0, x1, 0	# [4873] ()
# add_light.3233:	let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	flt	x4, f0, f1	# [4874] fispos bright
	fsw	f3, 0(x2)	# [4875] if fispos bright then vecaccum rgb bright texture_color else ()
	fsw	f2, 1(x2)	# [4876] if fispos bright then vecaccum rgb bright texture_color else ()
	bne	x4, x0, 2	# [4877] if fispos bright then vecaccum rgb bright texture_color else ()
# beq:	()
	jal	x0, 11	# [4878] if fispos bright then vecaccum rgb bright texture_color else ()
# bne:	vecaccum rgb bright texture_color
	lui	x4, 256	# [4879] rgb
	addi	x4, x4, 140	# [4880] rgb
	lui	x5, 256	# [4881] texture_color
	addi	x5, x5, 134	# [4882] texture_color
	sw	x1, 2(x2)	# [4883] vecaccum rgb bright texture_color
	addi	x2, x2, 3	# [4884] vecaccum rgb bright texture_color
	jal	x1, -4787	# [4885] vecaccum rgb bright texture_color
	addi	x2, x2, -3	# [4886] vecaccum rgb bright texture_color
	lw	x1, 2(x2)	# [4887] vecaccum rgb bright texture_color
	addi	x0, x4, 0	# [4888] vecaccum rgb bright texture_color
# cont:	if fispos bright then vecaccum rgb bright texture_color else ()
	flw	f1, 1(x2)	# [4889] fispos hilight
	flt	x4, f0, f1	# [4890] fispos hilight
	bne	x4, x0, 2	# [4891] if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
# beq:	()
	jalr x0, x1, 0	# [4892] ()
# bne:	let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl
	fmul	f1, f1, f1	# [4893] fsqr hilight
	fmul	f1, f1, f1	# [4894] fsqr (fsqr hilight)
	flw	f2, 0(x2)	# [4895] fsqr (fsqr hilight) *. hilight_scale
	# let ihl = fsqr (fsqr hilight) *. hilight_scale
	fmul	f1, f1, f2	# [4896] fsqr (fsqr hilight) *. hilight_scale
	lui	x4, 256	# [4897] rgb
	addi	x4, x4, 140	# [4898] rgb
	lui	x5, 256	# [4899] rgb
	addi	x5, x5, 140	# [4900] rgb
	flw	f2, 0(x5)	# [4901] rgb.(0)
	fadd	f2, f2, f1	# [4902] rgb.(0) +. ihl
	fsw	f2, 0(x4)	# [4903] rgb.(0) <- rgb.(0) +. ihl
	lui	x4, 256	# [4904] rgb
	addi	x4, x4, 140	# [4905] rgb
	lui	x5, 256	# [4906] rgb
	addi	x5, x5, 140	# [4907] rgb
	flw	f2, 1(x5)	# [4908] rgb.(1)
	fadd	f2, f2, f1	# [4909] rgb.(1) +. ihl
	fsw	f2, 1(x4)	# [4910] rgb.(1) <- rgb.(1) +. ihl
	lui	x4, 256	# [4911] rgb
	addi	x4, x4, 140	# [4912] rgb
	lui	x5, 256	# [4913] rgb
	addi	x5, x5, 140	# [4914] rgb
	flw	f2, 2(x5)	# [4915] rgb.(2)
	fadd	f1, f2, f1	# [4916] rgb.(2) +. ihl
	fsw	f1, 2(x4)	# [4917] rgb.(2) <- rgb.(2) +. ihl
	jalr x0, x1, 0	# [4918] rgb.(2) <- rgb.(2) +. ihl
# trace_reflections.3237:	let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	bge	x4, x0, 2	# [4919] if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
# blt:	()
	jalr x0, x1, 0	# [4920] ()
# bge:	let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec
	lui	x6, 256	# [4921] reflections
	addi	x6, x6, 415	# [4922] reflections
	# let rinfo = reflections.(index)
	add	x31, x6, x4	# [4923] reflections.(index)
	lw	x6, 0(x31)	# [4924] reflections.(index)
	sw	x4, 0(x2)	# [4925] r_dvec rinfo
	fsw	f2, 1(x2)	# [4926] r_dvec rinfo
	sw	x5, 2(x2)	# [4927] r_dvec rinfo
	fsw	f1, 3(x2)	# [4928] r_dvec rinfo
	sw	x6, 4(x2)	# [4929] r_dvec rinfo
	# let dvec = r_dvec rinfo
	addi	x4, x6, 0	# [4930] r_dvec rinfo
	sw	x1, 5(x2)	# [4931] r_dvec rinfo
	addi	x2, x2, 6	# [4932] r_dvec rinfo
	jal	x1, -4695	# [4933] r_dvec rinfo
	addi	x2, x2, -6	# [4934] r_dvec rinfo
	lw	x1, 5(x2)	# [4935] r_dvec rinfo
	sw	x4, 5(x2)	# [4936] judge_intersection_fast dvec
	sw	x1, 6(x2)	# [4937] judge_intersection_fast dvec
	addi	x2, x2, 7	# [4938] judge_intersection_fast dvec
	jal	x1, -816	# [4939] judge_intersection_fast dvec
	addi	x2, x2, -7	# [4940] judge_intersection_fast dvec
	lw	x1, 6(x2)	# [4941] judge_intersection_fast dvec
	bne	x4, x0, 2	# [4942] if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else ()
# beq:	()
	jal	x0, 84	# [4943] if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else ()
# bne:	let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
	lui	x4, 256	# [4944] intersected_object_id
	addi	x4, x4, 128	# [4945] intersected_object_id
	lw	x4, 0(x4)	# [4946] intersected_object_id.(0)
	slli	x4, x4, 2	# [4947] intersected_object_id.(0) * 4
	lui	x5, 256	# [4948] intsec_rectside
	addi	x5, x5, 123	# [4949] intsec_rectside
	lw	x5, 0(x5)	# [4950] intsec_rectside.(0)
	# let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0)
	add	x4, x4, x5	# [4951] intersected_object_id.(0) * 4 + intsec_rectside.(0)
	lw	x5, 4(x2)	# [4952] r_surface_id rinfo
	sw	x4, 6(x2)	# [4953] r_surface_id rinfo
	addi	x4, x5, 0	# [4954] r_surface_id rinfo
	sw	x1, 7(x2)	# [4955] r_surface_id rinfo
	addi	x2, x2, 8	# [4956] r_surface_id rinfo
	jal	x1, -4721	# [4957] r_surface_id rinfo
	addi	x2, x2, -8	# [4958] r_surface_id rinfo
	lw	x1, 7(x2)	# [4959] r_surface_id rinfo
	lw	x5, 6(x2)	# [4960] if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
	bne	x5, x4, 66	# [4961] if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
# beq:	if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else ()
	addi	x4, x0, 0	# [4962] 0
	lui	x5, 256	# [4963] or_net
	addi	x5, x5, 121	# [4964] or_net
	lw	x5, 0(x5)	# [4965] or_net.(0)
	sw	x1, 7(x2)	# [4966] shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, 8	# [4967] shadow_check_one_or_matrix 0 or_net.(0)
	jal	x1, -1357	# [4968] shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, -8	# [4969] shadow_check_one_or_matrix 0 or_net.(0)
	lw	x1, 7(x2)	# [4970] shadow_check_one_or_matrix 0 or_net.(0)
	bne	x4, x0, 55	# [4971] if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else ()
# beq:	let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale
	lui	x4, 256	# [4972] nvector
	addi	x4, x4, 131	# [4973] nvector
	lw	x5, 5(x2)	# [4974] d_vec dvec
	sw	x4, 7(x2)	# [4975] d_vec dvec
	addi	x4, x5, 0	# [4976] d_vec dvec
	sw	x1, 8(x2)	# [4977] d_vec dvec
	addi	x2, x2, 9	# [4978] d_vec dvec
	jal	x1, -4747	# [4979] d_vec dvec
	addi	x2, x2, -9	# [4980] d_vec dvec
	lw	x1, 8(x2)	# [4981] d_vec dvec
	addi	x5, x4, 0	# [4982] d_vec dvec
	lw	x4, 7(x2)	# [4983] veciprod nvector (d_vec dvec)
	# let p = veciprod nvector (d_vec dvec)
	sw	x1, 8(x2)	# [4984] veciprod nvector (d_vec dvec)
	addi	x2, x2, 9	# [4985] veciprod nvector (d_vec dvec)
	jal	x1, -4909	# [4986] veciprod nvector (d_vec dvec)
	addi	x2, x2, -9	# [4987] veciprod nvector (d_vec dvec)
	lw	x1, 8(x2)	# [4988] veciprod nvector (d_vec dvec)
	lw	x4, 4(x2)	# [4989] r_bright rinfo
	fsw	f1, 8(x2)	# [4990] r_bright rinfo
	# let scale = r_bright rinfo
	sw	x1, 9(x2)	# [4991] r_bright rinfo
	addi	x2, x2, 10	# [4992] r_bright rinfo
	jal	x1, -4753	# [4993] r_bright rinfo
	addi	x2, x2, -10	# [4994] r_bright rinfo
	lw	x1, 9(x2)	# [4995] r_bright rinfo
	flw	f2, 3(x2)	# [4996] scale *. diffuse
	fmul	f3, f1, f2	# [4997] scale *. diffuse
	flw	f4, 8(x2)	# [4998] scale *. diffuse *. p
	# let bright = scale *. diffuse *. p
	fmul	f3, f3, f4	# [4999] scale *. diffuse *. p
	lw	x4, 5(x2)	# [5000] d_vec dvec
	fsw	f3, 9(x2)	# [5001] d_vec dvec
	fsw	f1, 10(x2)	# [5002] d_vec dvec
	sw	x1, 11(x2)	# [5003] d_vec dvec
	addi	x2, x2, 12	# [5004] d_vec dvec
	jal	x1, -4773	# [5005] d_vec dvec
	addi	x2, x2, -12	# [5006] d_vec dvec
	lw	x1, 11(x2)	# [5007] d_vec dvec
	addi	x5, x4, 0	# [5008] d_vec dvec
	lw	x4, 2(x2)	# [5009] veciprod dirvec (d_vec dvec)
	sw	x1, 11(x2)	# [5010] veciprod dirvec (d_vec dvec)
	addi	x2, x2, 12	# [5011] veciprod dirvec (d_vec dvec)
	jal	x1, -4935	# [5012] veciprod dirvec (d_vec dvec)
	addi	x2, x2, -12	# [5013] veciprod dirvec (d_vec dvec)
	lw	x1, 11(x2)	# [5014] veciprod dirvec (d_vec dvec)
	flw	f2, 10(x2)	# [5015] scale *. veciprod dirvec (d_vec dvec)
	# let hilight = scale *. veciprod dirvec (d_vec dvec)
	fmul	f2, f2, f1	# [5016] scale *. veciprod dirvec (d_vec dvec)
	flw	f1, 9(x2)	# [5017] add_light bright hilight hilight_scale
	flw	f3, 1(x2)	# [5018] add_light bright hilight hilight_scale
	sw	x1, 11(x2)	# [5019] add_light bright hilight hilight_scale
	addi	x2, x2, 12	# [5020] add_light bright hilight hilight_scale
	jal	x1, -147	# [5021] add_light bright hilight hilight_scale
	addi	x2, x2, -12	# [5022] add_light bright hilight hilight_scale
	lw	x1, 11(x2)	# [5023] add_light bright hilight hilight_scale
	addi	x0, x4, 0	# [5024] add_light bright hilight hilight_scale
	jal	x0, 1	# [5025] if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else ()
# bne:	()
# cont:	if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else ()
	jal	x0, 1	# [5026] if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
# bne:	()
# cont:	if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
# cont:	if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else ()
	lw	x4, 0(x2)	# [5027] index - 1
	addi	x4, x4, -1	# [5028] index - 1
	flw	f1, 3(x2)	# [5029] trace_reflections (index - 1) diffuse hilight_scale dirvec
	flw	f2, 1(x2)	# [5030] trace_reflections (index - 1) diffuse hilight_scale dirvec
	lw	x5, 2(x2)	# [5031] trace_reflections (index - 1) diffuse hilight_scale dirvec
	jal	x0, -113	# [5032] trace_reflections (index - 1) diffuse hilight_scale dirvec
# trace_ray.3242:	let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	addi	x7, x0, 4	# [5033] 4
	bge	x7, x4, 2	# [5034] if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
# blt:	()
	jalr x0, x1, 0	# [5035] ()
# bge:	let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () )
	fsw	f2, 0(x2)	# [5036] p_surface_ids pixel
	sw	x6, 1(x2)	# [5037] p_surface_ids pixel
	fsw	f1, 2(x2)	# [5038] p_surface_ids pixel
	sw	x4, 3(x2)	# [5039] p_surface_ids pixel
	sw	x5, 4(x2)	# [5040] p_surface_ids pixel
	# let surface_ids = p_surface_ids pixel
	addi	x4, x6, 0	# [5041] p_surface_ids pixel
	sw	x1, 5(x2)	# [5042] p_surface_ids pixel
	addi	x2, x2, 6	# [5043] p_surface_ids pixel
	jal	x1, -4828	# [5044] p_surface_ids pixel
	addi	x2, x2, -6	# [5045] p_surface_ids pixel
	lw	x1, 5(x2)	# [5046] p_surface_ids pixel
	lw	x5, 4(x2)	# [5047] judge_intersection dirvec
	sw	x4, 5(x2)	# [5048] judge_intersection dirvec
	addi	x4, x5, 0	# [5049] judge_intersection dirvec
	sw	x1, 6(x2)	# [5050] judge_intersection dirvec
	addi	x2, x2, 7	# [5051] judge_intersection dirvec
	jal	x1, -1170	# [5052] judge_intersection dirvec
	addi	x2, x2, -7	# [5053] judge_intersection dirvec
	lw	x1, 6(x2)	# [5054] judge_intersection dirvec
	bne	x4, x0, 50	# [5055] if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () )
# beq:	surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else ()
	addi	x4, x0, -1	# [5056] -1
	lw	x5, 3(x2)	# [5057] surface_ids.(nref) <- -1
	lw	x6, 5(x2)	# [5058] surface_ids.(nref) <- -1
	add	x31, x6, x5	# [5059] surface_ids.(nref) <- -1
	sw	x4, 0(x31)	# [5060] surface_ids.(nref) <- -1
	bne	x5, x0, 2	# [5061] if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else ()
# beq:	()
	jalr x0, x1, 0	# [5062] ()
# bne:	let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	lui	x5, 256	# [5063] light
	addi	x5, x5, 69	# [5064] light
	lw	x4, 4(x2)	# [5065] veciprod dirvec light
	sw	x1, 6(x2)	# [5066] veciprod dirvec light
	addi	x2, x2, 7	# [5067] veciprod dirvec light
	jal	x1, -4991	# [5068] veciprod dirvec light
	addi	x2, x2, -7	# [5069] veciprod dirvec light
	lw	x1, 6(x2)	# [5070] veciprod dirvec light
	# let hl = fneg (veciprod dirvec light)
	fneg	f1, f1	# [5071] fneg (veciprod dirvec light)
	flt	x4, f0, f1	# [5072] fispos hl
	bne	x4, x0, 2	# [5073] if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
# beq:	()
	jalr x0, x1, 0	# [5074] ()
# bne:	let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl
	fmul	f2, f1, f1	# [5075] fsqr hl
	fmul	f1, f2, f1	# [5076] fsqr hl *. hl
	flw	f2, 2(x2)	# [5077] fsqr hl *. hl *. energy
	fmul	f1, f1, f2	# [5078] fsqr hl *. hl *. energy
	lui	x4, 256	# [5079] beam
	addi	x4, x4, 70	# [5080] beam
	flw	f2, 0(x4)	# [5081] beam.(0)
	# let ihl = fsqr hl *. hl *. energy *. beam.(0)
	fmul	f1, f1, f2	# [5082] fsqr hl *. hl *. energy *. beam.(0)
	lui	x4, 256	# [5083] rgb
	addi	x4, x4, 140	# [5084] rgb
	lui	x5, 256	# [5085] rgb
	addi	x5, x5, 140	# [5086] rgb
	flw	f2, 0(x5)	# [5087] rgb.(0)
	fadd	f2, f2, f1	# [5088] rgb.(0) +. ihl
	fsw	f2, 0(x4)	# [5089] rgb.(0) <- rgb.(0) +. ihl
	lui	x4, 256	# [5090] rgb
	addi	x4, x4, 140	# [5091] rgb
	lui	x5, 256	# [5092] rgb
	addi	x5, x5, 140	# [5093] rgb
	flw	f2, 1(x5)	# [5094] rgb.(1)
	fadd	f2, f2, f1	# [5095] rgb.(1) +. ihl
	fsw	f2, 1(x4)	# [5096] rgb.(1) <- rgb.(1) +. ihl
	lui	x4, 256	# [5097] rgb
	addi	x4, x4, 140	# [5098] rgb
	lui	x5, 256	# [5099] rgb
	addi	x5, x5, 140	# [5100] rgb
	flw	f2, 2(x5)	# [5101] rgb.(2)
	fadd	f1, f2, f1	# [5102] rgb.(2) +. ihl
	fsw	f1, 2(x4)	# [5103] rgb.(2) <- rgb.(2) +. ihl
	jalr x0, x1, 0	# [5104] rgb.(2) <- rgb.(2) +. ihl
# bne:	let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else ()
	lui	x4, 256	# [5105] intersected_object_id
	addi	x4, x4, 128	# [5106] intersected_object_id
	# let obj_id = intersected_object_id.(0)
	lw	x4, 0(x4)	# [5107] intersected_object_id.(0)
	lui	x5, 256	# [5108] objects
	addi	x5, x5, 60	# [5109] objects
	# let obj = objects.(obj_id)
	add	x31, x5, x4	# [5110] objects.(obj_id)
	lw	x5, 0(x31)	# [5111] objects.(obj_id)
	sw	x4, 6(x2)	# [5112] o_reflectiontype obj
	sw	x5, 7(x2)	# [5113] o_reflectiontype obj
	# let m_surface = o_reflectiontype obj
	addi	x4, x5, 0	# [5114] o_reflectiontype obj
	sw	x1, 8(x2)	# [5115] o_reflectiontype obj
	addi	x2, x2, 9	# [5116] o_reflectiontype obj
	jal	x1, -4957	# [5117] o_reflectiontype obj
	addi	x2, x2, -9	# [5118] o_reflectiontype obj
	lw	x1, 8(x2)	# [5119] o_reflectiontype obj
	lw	x5, 7(x2)	# [5120] o_diffuse obj
	sw	x4, 8(x2)	# [5121] o_diffuse obj
	addi	x4, x5, 0	# [5122] o_diffuse obj
	sw	x1, 9(x2)	# [5123] o_diffuse obj
	addi	x2, x2, 10	# [5124] o_diffuse obj
	jal	x1, -4939	# [5125] o_diffuse obj
	addi	x2, x2, -10	# [5126] o_diffuse obj
	lw	x1, 9(x2)	# [5127] o_diffuse obj
	flw	f2, 2(x2)	# [5128] o_diffuse obj *. energy
	# let diffuse = o_diffuse obj *. energy
	fmul	f1, f1, f2	# [5129] o_diffuse obj *. energy
	lw	x4, 7(x2)	# [5130] get_nvector obj dirvec
	lw	x5, 4(x2)	# [5131] get_nvector obj dirvec
	fsw	f1, 9(x2)	# [5132] get_nvector obj dirvec
	sw	x1, 10(x2)	# [5133] get_nvector obj dirvec
	addi	x2, x2, 11	# [5134] get_nvector obj dirvec
	jal	x1, -720	# [5135] get_nvector obj dirvec
	addi	x2, x2, -11	# [5136] get_nvector obj dirvec
	lw	x1, 10(x2)	# [5137] get_nvector obj dirvec
	addi	x0, x4, 0	# [5138] get_nvector obj dirvec
	lui	x4, 256	# [5139] startp
	addi	x4, x4, 148	# [5140] startp
	lui	x5, 256	# [5141] intersection_point
	addi	x5, x5, 127	# [5142] intersection_point
	sw	x1, 10(x2)	# [5143] veccpy startp intersection_point
	addi	x2, x2, 11	# [5144] veccpy startp intersection_point
	jal	x1, -5107	# [5145] veccpy startp intersection_point
	addi	x2, x2, -11	# [5146] veccpy startp intersection_point
	lw	x1, 10(x2)	# [5147] veccpy startp intersection_point
	addi	x0, x4, 0	# [5148] veccpy startp intersection_point
	lui	x5, 256	# [5149] intersection_point
	addi	x5, x5, 127	# [5150] intersection_point
	lw	x4, 7(x2)	# [5151] utexture obj intersection_point
	sw	x1, 10(x2)	# [5152] utexture obj intersection_point
	addi	x2, x2, 11	# [5153] utexture obj intersection_point
	jal	x1, -722	# [5154] utexture obj intersection_point
	addi	x2, x2, -11	# [5155] utexture obj intersection_point
	lw	x1, 10(x2)	# [5156] utexture obj intersection_point
	addi	x0, x4, 0	# [5157] utexture obj intersection_point
	lw	x4, 6(x2)	# [5158] obj_id * 4
	slli	x4, x4, 2	# [5159] obj_id * 4
	lui	x5, 256	# [5160] intsec_rectside
	addi	x5, x5, 123	# [5161] intsec_rectside
	lw	x5, 0(x5)	# [5162] intsec_rectside.(0)
	add	x4, x4, x5	# [5163] obj_id * 4 + intsec_rectside.(0)
	lw	x5, 3(x2)	# [5164] surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0)
	lw	x6, 5(x2)	# [5165] surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0)
	add	x31, x6, x5	# [5166] surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0)
	sw	x4, 0(x31)	# [5167] surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0)
	lw	x4, 1(x2)	# [5168] p_intersection_points pixel
	# let intersection_points = p_intersection_points pixel
	sw	x1, 10(x2)	# [5169] p_intersection_points pixel
	addi	x2, x2, 11	# [5170] p_intersection_points pixel
	jal	x1, -4957	# [5171] p_intersection_points pixel
	addi	x2, x2, -11	# [5172] p_intersection_points pixel
	lw	x1, 10(x2)	# [5173] p_intersection_points pixel
	lw	x5, 3(x2)	# [5174] intersection_points.(nref)
	add	x31, x4, x5	# [5175] intersection_points.(nref)
	lw	x4, 0(x31)	# [5176] intersection_points.(nref)
	lui	x6, 256	# [5177] intersection_point
	addi	x6, x6, 127	# [5178] intersection_point
	addi	x5, x6, 0	# [5179] veccpy intersection_points.(nref) intersection_point
	sw	x1, 10(x2)	# [5180] veccpy intersection_points.(nref) intersection_point
	addi	x2, x2, 11	# [5181] veccpy intersection_points.(nref) intersection_point
	jal	x1, -5144	# [5182] veccpy intersection_points.(nref) intersection_point
	addi	x2, x2, -11	# [5183] veccpy intersection_points.(nref) intersection_point
	lw	x1, 10(x2)	# [5184] veccpy intersection_points.(nref) intersection_point
	addi	x0, x4, 0	# [5185] veccpy intersection_points.(nref) intersection_point
	lw	x4, 1(x2)	# [5186] p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 10(x2)	# [5187] p_calc_diffuse pixel
	addi	x2, x2, 11	# [5188] p_calc_diffuse pixel
	jal	x1, -4971	# [5189] p_calc_diffuse pixel
	addi	x2, x2, -11	# [5190] p_calc_diffuse pixel
	lw	x1, 10(x2)	# [5191] p_calc_diffuse pixel
	lw	x5, 7(x2)	# [5192] o_diffuse obj
	sw	x4, 10(x2)	# [5193] o_diffuse obj
	addi	x4, x5, 0	# [5194] o_diffuse obj
	sw	x1, 11(x2)	# [5195] o_diffuse obj
	addi	x2, x2, 12	# [5196] o_diffuse obj
	jal	x1, -5011	# [5197] o_diffuse obj
	addi	x2, x2, -12	# [5198] o_diffuse obj
	lw	x1, 11(x2)	# [5199] o_diffuse obj
	flt	x4, f1, f27	# [5200] fless (o_diffuse obj) 0.5
	bne	x4, x0, 61	# [5201] if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; )
# beq:	calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector;
	addi	x4, x0, 1	# [5202] true
	lw	x5, 3(x2)	# [5203] calc_diffuse.(nref) <- true
	lw	x6, 10(x2)	# [5204] calc_diffuse.(nref) <- true
	add	x31, x6, x5	# [5205] calc_diffuse.(nref) <- true
	sw	x4, 0(x31)	# [5206] calc_diffuse.(nref) <- true
	lw	x4, 1(x2)	# [5207] p_energy pixel
	# let energya = p_energy pixel
	sw	x1, 11(x2)	# [5208] p_energy pixel
	addi	x2, x2, 12	# [5209] p_energy pixel
	jal	x1, -4990	# [5210] p_energy pixel
	addi	x2, x2, -12	# [5211] p_energy pixel
	lw	x1, 11(x2)	# [5212] p_energy pixel
	lw	x5, 3(x2)	# [5213] energya.(nref)
	add	x31, x4, x5	# [5214] energya.(nref)
	lw	x6, 0(x31)	# [5215] energya.(nref)
	lui	x7, 256	# [5216] texture_color
	addi	x7, x7, 134	# [5217] texture_color
	sw	x4, 11(x2)	# [5218] veccpy energya.(nref) texture_color
	addi	x5, x7, 0	# [5219] veccpy energya.(nref) texture_color
	addi	x4, x6, 0	# [5220] veccpy energya.(nref) texture_color
	sw	x1, 12(x2)	# [5221] veccpy energya.(nref) texture_color
	addi	x2, x2, 13	# [5222] veccpy energya.(nref) texture_color
	jal	x1, -5185	# [5223] veccpy energya.(nref) texture_color
	addi	x2, x2, -13	# [5224] veccpy energya.(nref) texture_color
	lw	x1, 12(x2)	# [5225] veccpy energya.(nref) texture_color
	addi	x0, x4, 0	# [5226] veccpy energya.(nref) texture_color
	lw	x4, 3(x2)	# [5227] energya.(nref)
	lw	x5, 11(x2)	# [5228] energya.(nref)
	add	x31, x5, x4	# [5229] energya.(nref)
	lw	x5, 0(x31)	# [5230] energya.(nref)
	lui	x31, 243712	# [5231] 1.0 /. 256.0
	addi	x31, x31, 0	# [5232] 1.0 /. 256.0
	xtof	f1, x31	# [5233] 1.0 /. 256.0
	flw	f2, 9(x2)	# [5234] (1.0 /. 256.0) *. diffuse
	fmul	f1, f1, f2	# [5235] (1.0 /. 256.0) *. diffuse
	addi	x4, x5, 0	# [5236] vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	sw	x1, 12(x2)	# [5237] vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	addi	x2, x2, 13	# [5238] vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	jal	x1, -5112	# [5239] vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	addi	x2, x2, -13	# [5240] vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	lw	x1, 12(x2)	# [5241] vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	addi	x0, x4, 0	# [5242] vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	lw	x4, 1(x2)	# [5243] p_nvectors pixel
	# let nvectors = p_nvectors pixel
	sw	x1, 12(x2)	# [5244] p_nvectors pixel
	addi	x2, x2, 13	# [5245] p_nvectors pixel
	jal	x1, -5016	# [5246] p_nvectors pixel
	addi	x2, x2, -13	# [5247] p_nvectors pixel
	lw	x1, 12(x2)	# [5248] p_nvectors pixel
	lw	x5, 3(x2)	# [5249] nvectors.(nref)
	add	x31, x4, x5	# [5250] nvectors.(nref)
	lw	x4, 0(x31)	# [5251] nvectors.(nref)
	lui	x6, 256	# [5252] nvector
	addi	x6, x6, 131	# [5253] nvector
	addi	x5, x6, 0	# [5254] veccpy nvectors.(nref) nvector
	sw	x1, 12(x2)	# [5255] veccpy nvectors.(nref) nvector
	addi	x2, x2, 13	# [5256] veccpy nvectors.(nref) nvector
	jal	x1, -5219	# [5257] veccpy nvectors.(nref) nvector
	addi	x2, x2, -13	# [5258] veccpy nvectors.(nref) nvector
	lw	x1, 12(x2)	# [5259] veccpy nvectors.(nref) nvector
	addi	x0, x4, 0	# [5260] veccpy nvectors.(nref) nvector
	jal	x0, 6	# [5261] if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; )
# bne:	calc_diffuse.(nref) <- false
	addi	x4, x0, 0	# [5262] false
	lw	x5, 3(x2)	# [5263] calc_diffuse.(nref) <- false
	lw	x6, 10(x2)	# [5264] calc_diffuse.(nref) <- false
	add	x31, x6, x5	# [5265] calc_diffuse.(nref) <- false
	sw	x4, 0(x31)	# [5266] calc_diffuse.(nref) <- false
# cont:	if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; )
	lui	x31, -262144	# [5267] -2.0
	addi	x31, x31, 0	# [5268] -2.0
	xtof	f1, x31	# [5269] -2.0
	lui	x5, 256	# [5270] nvector
	addi	x5, x5, 131	# [5271] nvector
	lw	x4, 4(x2)	# [5272] veciprod dirvec nvector
	fsw	f1, 12(x2)	# [5273] veciprod dirvec nvector
	sw	x1, 13(x2)	# [5274] veciprod dirvec nvector
	addi	x2, x2, 14	# [5275] veciprod dirvec nvector
	jal	x1, -5199	# [5276] veciprod dirvec nvector
	addi	x2, x2, -14	# [5277] veciprod dirvec nvector
	lw	x1, 13(x2)	# [5278] veciprod dirvec nvector
	flw	f2, 12(x2)	# [5279] (-2.0) *. veciprod dirvec nvector
	# let w = (-2.0) *. veciprod dirvec nvector
	fmul	f1, f2, f1	# [5280] (-2.0) *. veciprod dirvec nvector
	lui	x5, 256	# [5281] nvector
	addi	x5, x5, 131	# [5282] nvector
	lw	x4, 4(x2)	# [5283] vecaccum dirvec w nvector
	sw	x1, 13(x2)	# [5284] vecaccum dirvec w nvector
	addi	x2, x2, 14	# [5285] vecaccum dirvec w nvector
	jal	x1, -5188	# [5286] vecaccum dirvec w nvector
	addi	x2, x2, -14	# [5287] vecaccum dirvec w nvector
	lw	x1, 13(x2)	# [5288] vecaccum dirvec w nvector
	addi	x0, x4, 0	# [5289] vecaccum dirvec w nvector
	lw	x4, 7(x2)	# [5290] o_hilight obj
	sw	x1, 13(x2)	# [5291] o_hilight obj
	addi	x2, x2, 14	# [5292] o_hilight obj
	jal	x1, -5104	# [5293] o_hilight obj
	addi	x2, x2, -14	# [5294] o_hilight obj
	lw	x1, 13(x2)	# [5295] o_hilight obj
	flw	f2, 2(x2)	# [5296] energy *. o_hilight obj
	# let hilight_scale = energy *. o_hilight obj
	fmul	f1, f2, f1	# [5297] energy *. o_hilight obj
	addi	x4, x0, 0	# [5298] 0
	lui	x5, 256	# [5299] or_net
	addi	x5, x5, 121	# [5300] or_net
	lw	x5, 0(x5)	# [5301] or_net.(0)
	fsw	f1, 13(x2)	# [5302] shadow_check_one_or_matrix 0 or_net.(0)
	sw	x1, 14(x2)	# [5303] shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, 15	# [5304] shadow_check_one_or_matrix 0 or_net.(0)
	jal	x1, -1694	# [5305] shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, -15	# [5306] shadow_check_one_or_matrix 0 or_net.(0)
	lw	x1, 14(x2)	# [5307] shadow_check_one_or_matrix 0 or_net.(0)
	bne	x4, x0, 32	# [5308] if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else ()
# beq:	let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale
	lui	x4, 256	# [5309] nvector
	addi	x4, x4, 131	# [5310] nvector
	lui	x5, 256	# [5311] light
	addi	x5, x5, 69	# [5312] light
	sw	x1, 14(x2)	# [5313] veciprod nvector light
	addi	x2, x2, 15	# [5314] veciprod nvector light
	jal	x1, -5238	# [5315] veciprod nvector light
	addi	x2, x2, -15	# [5316] veciprod nvector light
	lw	x1, 14(x2)	# [5317] veciprod nvector light
	fneg	f1, f1	# [5318] fneg (veciprod nvector light)
	flw	f2, 9(x2)	# [5319] fneg (veciprod nvector light) *. diffuse
	# let bright = fneg (veciprod nvector light) *. diffuse
	fmul	f1, f1, f2	# [5320] fneg (veciprod nvector light) *. diffuse
	lui	x5, 256	# [5321] light
	addi	x5, x5, 69	# [5322] light
	lw	x4, 4(x2)	# [5323] veciprod dirvec light
	fsw	f1, 14(x2)	# [5324] veciprod dirvec light
	sw	x1, 15(x2)	# [5325] veciprod dirvec light
	addi	x2, x2, 16	# [5326] veciprod dirvec light
	jal	x1, -5250	# [5327] veciprod dirvec light
	addi	x2, x2, -16	# [5328] veciprod dirvec light
	lw	x1, 15(x2)	# [5329] veciprod dirvec light
	# let hilight = fneg (veciprod dirvec light)
	fneg	f2, f1	# [5330] fneg (veciprod dirvec light)
	flw	f1, 14(x2)	# [5331] add_light bright hilight hilight_scale
	flw	f3, 13(x2)	# [5332] add_light bright hilight hilight_scale
	sw	x1, 15(x2)	# [5333] add_light bright hilight hilight_scale
	addi	x2, x2, 16	# [5334] add_light bright hilight hilight_scale
	jal	x1, -461	# [5335] add_light bright hilight hilight_scale
	addi	x2, x2, -16	# [5336] add_light bright hilight hilight_scale
	lw	x1, 15(x2)	# [5337] add_light bright hilight hilight_scale
	addi	x0, x4, 0	# [5338] add_light bright hilight hilight_scale
	jal	x0, 1	# [5339] if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else ()
# bne:	()
# cont:	if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else ()
	lui	x4, 256	# [5340] intersection_point
	addi	x4, x4, 127	# [5341] intersection_point
	sw	x1, 15(x2)	# [5342] setup_startp intersection_point
	addi	x2, x2, 16	# [5343] setup_startp intersection_point
	jal	x1, -2072	# [5344] setup_startp intersection_point
	addi	x2, x2, -16	# [5345] setup_startp intersection_point
	lw	x1, 15(x2)	# [5346] setup_startp intersection_point
	addi	x0, x4, 0	# [5347] setup_startp intersection_point
	lui	x4, 256	# [5348] n_reflections
	addi	x4, x4, 416	# [5349] n_reflections
	lw	x4, 0(x4)	# [5350] n_reflections.(0)
	addi	x4, x4, -1	# [5351] n_reflections.(0)-1
	flw	f1, 9(x2)	# [5352] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	flw	f2, 13(x2)	# [5353] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	lw	x5, 4(x2)	# [5354] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	sw	x1, 15(x2)	# [5355] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	addi	x2, x2, 16	# [5356] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	jal	x1, -438	# [5357] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	addi	x2, x2, -16	# [5358] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	lw	x1, 15(x2)	# [5359] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	addi	x0, x4, 0	# [5360] trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	flw	f1, 2(x2)	# [5361] fless 0.1 energy
	flt	x4, f21, f1	# [5362] fless 0.1 energy
	bne	x4, x0, 2	# [5363] if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else ()
# beq:	()
	jalr x0, x1, 0	# [5364] ()
# bne:	if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ();
	addi	x4, x0, 4	# [5365] 4
	lw	x5, 3(x2)	# [5366] if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
	bge	x5, x4, 7	# [5367] if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
# blt:	surface_ids.(nref+1) <- -1
	addi	x4, x5, 1	# [5368] nref+1
	addi	x6, x0, -1	# [5369] -1
	lw	x7, 5(x2)	# [5370] surface_ids.(nref+1) <- -1
	add	x31, x7, x4	# [5371] surface_ids.(nref+1) <- -1
	sw	x6, 0(x31)	# [5372] surface_ids.(nref+1) <- -1
	jal	x0, 1	# [5373] if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
# bge:	()
# cont:	if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
	addi	x4, x0, 2	# [5374] 2
	lw	x6, 8(x2)	# [5375] if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
	bne	x6, x4, 26	# [5376] if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
# beq:	let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	lw	x4, 7(x2)	# [5377] o_diffuse obj
	sw	x1, 15(x2)	# [5378] o_diffuse obj
	addi	x2, x2, 16	# [5379] o_diffuse obj
	jal	x1, -5194	# [5380] o_diffuse obj
	addi	x2, x2, -16	# [5381] o_diffuse obj
	lw	x1, 15(x2)	# [5382] o_diffuse obj
	fsub	f1, f11, f1	# [5383] 1.0 -. o_diffuse obj
	flw	f2, 2(x2)	# [5384] energy *. (1.0 -. o_diffuse obj)
	# let energy2 = energy *. (1.0 -. o_diffuse obj)
	fmul	f1, f2, f1	# [5385] energy *. (1.0 -. o_diffuse obj)
	lw	x4, 3(x2)	# [5386] nref+1
	addi	x4, x4, 1	# [5387] nref+1
	lui	x5, 256	# [5388] tmin
	addi	x5, x5, 124	# [5389] tmin
	flw	f2, 0(x5)	# [5390] tmin.(0)
	flw	f3, 0(x2)	# [5391] dist +. tmin.(0)
	fadd	f2, f3, f2	# [5392] dist +. tmin.(0)
	lw	x5, 4(x2)	# [5393] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	lw	x6, 1(x2)	# [5394] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	sw	x1, 15(x2)	# [5395] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	addi	x2, x2, 16	# [5396] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	jal	x1, -364	# [5397] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	addi	x2, x2, -16	# [5398] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	lw	x1, 15(x2)	# [5399] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	addi	x0, x4, 0	# [5400] trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	jal	x0, 1	# [5401] if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
# bne:	()
# cont:	if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
	jalr x0, x1, 0	# [5402]
# trace_diffuse_ray.3248:	let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	fsw	f1, 0(x2)	# [5403] judge_intersection_fast dirvec
	sw	x4, 1(x2)	# [5404] judge_intersection_fast dirvec
	sw	x1, 2(x2)	# [5405] judge_intersection_fast dirvec
	addi	x2, x2, 3	# [5406] judge_intersection_fast dirvec
	jal	x1, -1284	# [5407] judge_intersection_fast dirvec
	addi	x2, x2, -3	# [5408] judge_intersection_fast dirvec
	lw	x1, 2(x2)	# [5409] judge_intersection_fast dirvec
	bne	x4, x0, 2	# [5410] if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
# beq:	()
	jalr x0, x1, 0	# [5411] ()
# bne:	let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else ()
	lui	x4, 256	# [5412] objects
	addi	x4, x4, 60	# [5413] objects
	lui	x5, 256	# [5414] intersected_object_id
	addi	x5, x5, 128	# [5415] intersected_object_id
	lw	x5, 0(x5)	# [5416] intersected_object_id.(0)
	# let obj = objects.(intersected_object_id.(0))
	add	x31, x4, x5	# [5417] objects.(intersected_object_id.(0))
	lw	x4, 0(x31)	# [5418] objects.(intersected_object_id.(0))
	lw	x5, 1(x2)	# [5419] d_vec dirvec
	sw	x4, 2(x2)	# [5420] d_vec dirvec
	addi	x4, x5, 0	# [5421] d_vec dirvec
	sw	x1, 3(x2)	# [5422] d_vec dirvec
	addi	x2, x2, 4	# [5423] d_vec dirvec
	jal	x1, -5192	# [5424] d_vec dirvec
	addi	x2, x2, -4	# [5425] d_vec dirvec
	lw	x1, 3(x2)	# [5426] d_vec dirvec
	addi	x5, x4, 0	# [5427] d_vec dirvec
	lw	x4, 2(x2)	# [5428] get_nvector obj (d_vec dirvec)
	sw	x1, 3(x2)	# [5429] get_nvector obj (d_vec dirvec)
	addi	x2, x2, 4	# [5430] get_nvector obj (d_vec dirvec)
	jal	x1, -1016	# [5431] get_nvector obj (d_vec dirvec)
	addi	x2, x2, -4	# [5432] get_nvector obj (d_vec dirvec)
	lw	x1, 3(x2)	# [5433] get_nvector obj (d_vec dirvec)
	addi	x0, x4, 0	# [5434] get_nvector obj (d_vec dirvec)
	lui	x5, 256	# [5435] intersection_point
	addi	x5, x5, 127	# [5436] intersection_point
	lw	x4, 2(x2)	# [5437] utexture obj intersection_point
	sw	x1, 3(x2)	# [5438] utexture obj intersection_point
	addi	x2, x2, 4	# [5439] utexture obj intersection_point
	jal	x1, -1008	# [5440] utexture obj intersection_point
	addi	x2, x2, -4	# [5441] utexture obj intersection_point
	lw	x1, 3(x2)	# [5442] utexture obj intersection_point
	addi	x0, x4, 0	# [5443] utexture obj intersection_point
	addi	x4, x0, 0	# [5444] 0
	lui	x5, 256	# [5445] or_net
	addi	x5, x5, 121	# [5446] or_net
	lw	x5, 0(x5)	# [5447] or_net.(0)
	sw	x1, 3(x2)	# [5448] shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, 4	# [5449] shadow_check_one_or_matrix 0 or_net.(0)
	jal	x1, -1839	# [5450] shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, -4	# [5451] shadow_check_one_or_matrix 0 or_net.(0)
	lw	x1, 3(x2)	# [5452] shadow_check_one_or_matrix 0 or_net.(0)
	bne	x4, x0, 35	# [5453] if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else ()
# beq:	let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
	lui	x4, 256	# [5454] nvector
	addi	x4, x4, 131	# [5455] nvector
	lui	x5, 256	# [5456] light
	addi	x5, x5, 69	# [5457] light
	sw	x1, 3(x2)	# [5458] veciprod nvector light
	addi	x2, x2, 4	# [5459] veciprod nvector light
	jal	x1, -5383	# [5460] veciprod nvector light
	addi	x2, x2, -4	# [5461] veciprod nvector light
	lw	x1, 3(x2)	# [5462] veciprod nvector light
	# let br = fneg (veciprod nvector light)
	fneg	f1, f1	# [5463] fneg (veciprod nvector light)
	flt	x4, f0, f1	# [5464] fispos br
	# let bright = (if fispos br then br else 0.0)
	bne	x4, x0, 4	# [5465] if fispos br then br else 0.0
# beq:	0.0
	addi	x31, x0, 0	# [5466] 0.0
	xtof	f1, x31	# [5467] 0.0
	jal	x0, 1	# [5468] if fispos br then br else 0.0
# bne:	br
# cont:	if fispos br then br else 0.0
	lui	x4, 256	# [5469] diffuse_ray
	addi	x4, x4, 137	# [5470] diffuse_ray
	flw	f2, 0(x2)	# [5471] energy *. bright
	fmul	f1, f2, f1	# [5472] energy *. bright
	lw	x5, 2(x2)	# [5473] o_diffuse obj
	sw	x4, 3(x2)	# [5474] o_diffuse obj
	fsw	f1, 4(x2)	# [5475] o_diffuse obj
	addi	x4, x5, 0	# [5476] o_diffuse obj
	sw	x1, 5(x2)	# [5477] o_diffuse obj
	addi	x2, x2, 6	# [5478] o_diffuse obj
	jal	x1, -5293	# [5479] o_diffuse obj
	addi	x2, x2, -6	# [5480] o_diffuse obj
	lw	x1, 5(x2)	# [5481] o_diffuse obj
	flw	f2, 4(x2)	# [5482] energy *. bright *. o_diffuse obj
	fmul	f1, f2, f1	# [5483] energy *. bright *. o_diffuse obj
	lui	x5, 256	# [5484] texture_color
	addi	x5, x5, 134	# [5485] texture_color
	lw	x4, 3(x2)	# [5486] vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
	jal	x0, -5389	# [5487] vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
# bne:	()
	jalr x0, x1, 0	# [5488] ()
# iter_trace_diffuse_rays.3251:	let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	bge	x7, x0, 2	# [5489] if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
# blt:	()
	jalr x0, x1, 0	# [5490] ()
# bge:	let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	add	x31, x4, x7	# [5491] dirvec_group.(index)
	lw	x5, 0(x31)	# [5492] dirvec_group.(index)
	sw	x6, 0(x2)	# [5493] d_vec dirvec_group.(index)
	sw	x7, 1(x2)	# [5494] d_vec dirvec_group.(index)
	sw	x4, 2(x2)	# [5495] d_vec dirvec_group.(index)
	addi	x4, x5, 0	# [5496] d_vec dirvec_group.(index)
	sw	x1, 3(x2)	# [5497] d_vec dirvec_group.(index)
	addi	x2, x2, 4	# [5498] d_vec dirvec_group.(index)
	jal	x1, -5267	# [5499] d_vec dirvec_group.(index)
	addi	x2, x2, -4	# [5500] d_vec dirvec_group.(index)
	lw	x1, 3(x2)	# [5501] d_vec dirvec_group.(index)
	lui	x5, 256	# [5502] nvector
	addi	x5, x5, 131	# [5503] nvector
	# let p = veciprod (d_vec dirvec_group.(index)) nvector
	sw	x1, 3(x2)	# [5504] veciprod (d_vec dirvec_group.(index)) nvector
	addi	x2, x2, 4	# [5505] veciprod (d_vec dirvec_group.(index)) nvector
	jal	x1, -5429	# [5506] veciprod (d_vec dirvec_group.(index)) nvector
	addi	x2, x2, -4	# [5507] veciprod (d_vec dirvec_group.(index)) nvector
	lw	x1, 3(x2)	# [5508] veciprod (d_vec dirvec_group.(index)) nvector
	flt	x4, f1, f0	# [5509] fisneg p
	bne	x4, x0, 17	# [5510] if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
# beq:	trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	lw	x4, 1(x2)	# [5511] dirvec_group.(index)
	lw	x5, 2(x2)	# [5512] dirvec_group.(index)
	add	x31, x5, x4	# [5513] dirvec_group.(index)
	lw	x6, 0(x31)	# [5514] dirvec_group.(index)
	lui	x31, 245159	# [5515] p /. 150.0
	addi	x31, x31, 1038	# [5516] p /. 150.0
	xtof	f2, x31	# [5517] p /. 150.0
	fmul	f1, f1, f2	# [5518] p /. 150.0
	addi	x4, x6, 0	# [5519] trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	sw	x1, 3(x2)	# [5520] trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	addi	x2, x2, 4	# [5521] trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	jal	x1, -119	# [5522] trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	addi	x2, x2, -4	# [5523] trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	lw	x1, 3(x2)	# [5524] trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	addi	x0, x4, 0	# [5525] trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	jal	x0, 17	# [5526] if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
# bne:	trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	lw	x4, 1(x2)	# [5527] index + 1
	addi	x5, x4, 1	# [5528] index + 1
	lw	x6, 2(x2)	# [5529] dirvec_group.(index + 1)
	add	x31, x6, x5	# [5530] dirvec_group.(index + 1)
	lw	x5, 0(x31)	# [5531] dirvec_group.(index + 1)
	lui	x31, -279129	# [5532] p /. -150.0
	addi	x31, x31, 1038	# [5533] p /. -150.0
	xtof	f2, x31	# [5534] p /. -150.0
	fmul	f1, f1, f2	# [5535] p /. -150.0
	addi	x4, x5, 0	# [5536] trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	sw	x1, 3(x2)	# [5537] trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	addi	x2, x2, 4	# [5538] trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	jal	x1, -136	# [5539] trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	addi	x2, x2, -4	# [5540] trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	lw	x1, 3(x2)	# [5541] trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	addi	x0, x4, 0	# [5542] trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
# cont:	if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	lui	x5, 256	# [5543] nvector
	addi	x5, x5, 131	# [5544] nvector
	lw	x4, 1(x2)	# [5545] index - 2
	addi	x7, x4, -2	# [5546] index - 2
	lw	x4, 2(x2)	# [5547] iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	lw	x6, 0(x2)	# [5548] iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	jal	x0, -60	# [5549] iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
# trace_diffuse_rays.3256:	let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	sw	x6, 0(x2)	# [5550] setup_startp org
	sw	x4, 1(x2)	# [5551] setup_startp org
	addi	x4, x6, 0	# [5552] setup_startp org
	sw	x1, 2(x2)	# [5553] setup_startp org
	addi	x2, x2, 3	# [5554] setup_startp org
	jal	x1, -2283	# [5555] setup_startp org
	addi	x2, x2, -3	# [5556] setup_startp org
	lw	x1, 2(x2)	# [5557] setup_startp org
	addi	x0, x4, 0	# [5558] setup_startp org
	lui	x5, 256	# [5559] nvector
	addi	x5, x5, 131	# [5560] nvector
	addi	x7, x0, 118	# [5561] 118
	lw	x4, 1(x2)	# [5562] iter_trace_diffuse_rays dirvec_group nvector org 118
	lw	x6, 0(x2)	# [5563] iter_trace_diffuse_rays dirvec_group nvector org 118
	jal	x0, -75	# [5564] iter_trace_diffuse_rays dirvec_group nvector org 118
# trace_diffuse_ray_80percent.3260:	let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	sw	x6, 0(x2)	# [5565] if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	sw	x4, 1(x2)	# [5566] if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	bne	x4, x0, 2	# [5567] if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
# beq:	()
	jal	x0, 14	# [5568] if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(0) nvector org
	lui	x5, 256	# [5569] dirvecs
	addi	x5, x5, 168	# [5570] dirvecs
	lw	x5, 0(x5)	# [5571] dirvecs.(0)
	lui	x7, 256	# [5572] nvector
	addi	x7, x7, 131	# [5573] nvector
	addi	x4, x5, 0	# [5574] trace_diffuse_rays dirvecs.(0) nvector org
	addi	x5, x7, 0	# [5575] trace_diffuse_rays dirvecs.(0) nvector org
	sw	x1, 2(x2)	# [5576] trace_diffuse_rays dirvecs.(0) nvector org
	addi	x2, x2, 3	# [5577] trace_diffuse_rays dirvecs.(0) nvector org
	jal	x1, -28	# [5578] trace_diffuse_rays dirvecs.(0) nvector org
	addi	x2, x2, -3	# [5579] trace_diffuse_rays dirvecs.(0) nvector org
	lw	x1, 2(x2)	# [5580] trace_diffuse_rays dirvecs.(0) nvector org
	addi	x0, x4, 0	# [5581] trace_diffuse_rays dirvecs.(0) nvector org
# cont:	if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	addi	x4, x0, 1	# [5582] 1
	lw	x5, 1(x2)	# [5583] if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
	bne	x5, x4, 2	# [5584] if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
# beq:	()
	jal	x0, 15	# [5585] if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(1) nvector org
	lui	x4, 256	# [5586] dirvecs
	addi	x4, x4, 168	# [5587] dirvecs
	lw	x4, 1(x4)	# [5588] dirvecs.(1)
	lui	x6, 256	# [5589] nvector
	addi	x6, x6, 131	# [5590] nvector
	lw	x7, 0(x2)	# [5591] trace_diffuse_rays dirvecs.(1) nvector org
	addi	x5, x6, 0	# [5592] trace_diffuse_rays dirvecs.(1) nvector org
	addi	x6, x7, 0	# [5593] trace_diffuse_rays dirvecs.(1) nvector org
	sw	x1, 2(x2)	# [5594] trace_diffuse_rays dirvecs.(1) nvector org
	addi	x2, x2, 3	# [5595] trace_diffuse_rays dirvecs.(1) nvector org
	jal	x1, -46	# [5596] trace_diffuse_rays dirvecs.(1) nvector org
	addi	x2, x2, -3	# [5597] trace_diffuse_rays dirvecs.(1) nvector org
	lw	x1, 2(x2)	# [5598] trace_diffuse_rays dirvecs.(1) nvector org
	addi	x0, x4, 0	# [5599] trace_diffuse_rays dirvecs.(1) nvector org
# cont:	if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
	addi	x4, x0, 2	# [5600] 2
	lw	x5, 1(x2)	# [5601] if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
	bne	x5, x4, 2	# [5602] if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
# beq:	()
	jal	x0, 15	# [5603] if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(2) nvector org
	lui	x4, 256	# [5604] dirvecs
	addi	x4, x4, 168	# [5605] dirvecs
	lw	x4, 2(x4)	# [5606] dirvecs.(2)
	lui	x6, 256	# [5607] nvector
	addi	x6, x6, 131	# [5608] nvector
	lw	x7, 0(x2)	# [5609] trace_diffuse_rays dirvecs.(2) nvector org
	addi	x5, x6, 0	# [5610] trace_diffuse_rays dirvecs.(2) nvector org
	addi	x6, x7, 0	# [5611] trace_diffuse_rays dirvecs.(2) nvector org
	sw	x1, 2(x2)	# [5612] trace_diffuse_rays dirvecs.(2) nvector org
	addi	x2, x2, 3	# [5613] trace_diffuse_rays dirvecs.(2) nvector org
	jal	x1, -64	# [5614] trace_diffuse_rays dirvecs.(2) nvector org
	addi	x2, x2, -3	# [5615] trace_diffuse_rays dirvecs.(2) nvector org
	lw	x1, 2(x2)	# [5616] trace_diffuse_rays dirvecs.(2) nvector org
	addi	x0, x4, 0	# [5617] trace_diffuse_rays dirvecs.(2) nvector org
# cont:	if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
	addi	x4, x0, 3	# [5618] 3
	lw	x5, 1(x2)	# [5619] if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
	bne	x5, x4, 2	# [5620] if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
# beq:	()
	jal	x0, 15	# [5621] if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(3) nvector org
	lui	x4, 256	# [5622] dirvecs
	addi	x4, x4, 168	# [5623] dirvecs
	lw	x4, 3(x4)	# [5624] dirvecs.(3)
	lui	x6, 256	# [5625] nvector
	addi	x6, x6, 131	# [5626] nvector
	lw	x7, 0(x2)	# [5627] trace_diffuse_rays dirvecs.(3) nvector org
	addi	x5, x6, 0	# [5628] trace_diffuse_rays dirvecs.(3) nvector org
	addi	x6, x7, 0	# [5629] trace_diffuse_rays dirvecs.(3) nvector org
	sw	x1, 2(x2)	# [5630] trace_diffuse_rays dirvecs.(3) nvector org
	addi	x2, x2, 3	# [5631] trace_diffuse_rays dirvecs.(3) nvector org
	jal	x1, -82	# [5632] trace_diffuse_rays dirvecs.(3) nvector org
	addi	x2, x2, -3	# [5633] trace_diffuse_rays dirvecs.(3) nvector org
	lw	x1, 2(x2)	# [5634] trace_diffuse_rays dirvecs.(3) nvector org
	addi	x0, x4, 0	# [5635] trace_diffuse_rays dirvecs.(3) nvector org
# cont:	if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
	addi	x4, x0, 4	# [5636] 4
	lw	x5, 1(x2)	# [5637] if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	bne	x5, x4, 2	# [5638] if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
# beq:	()
	jalr x0, x1, 0	# [5639] ()
# bne:	trace_diffuse_rays dirvecs.(4) nvector org
	lui	x4, 256	# [5640] dirvecs
	addi	x4, x4, 168	# [5641] dirvecs
	lw	x4, 4(x4)	# [5642] dirvecs.(4)
	lui	x5, 256	# [5643] nvector
	addi	x5, x5, 131	# [5644] nvector
	lw	x6, 0(x2)	# [5645] trace_diffuse_rays dirvecs.(4) nvector org
	jal	x0, -96	# [5646] trace_diffuse_rays dirvecs.(4) nvector org
# calc_diffuse_using_1point.3264:	let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	sw	x5, 0(x2)	# [5647] p_received_ray_20percent pixel
	sw	x4, 1(x2)	# [5648] p_received_ray_20percent pixel
	# let ray20p = p_received_ray_20percent pixel
	sw	x1, 2(x2)	# [5649] p_received_ray_20percent pixel
	addi	x2, x2, 3	# [5650] p_received_ray_20percent pixel
	jal	x1, -5429	# [5651] p_received_ray_20percent pixel
	addi	x2, x2, -3	# [5652] p_received_ray_20percent pixel
	lw	x1, 2(x2)	# [5653] p_received_ray_20percent pixel
	lw	x5, 1(x2)	# [5654] p_nvectors pixel
	sw	x4, 2(x2)	# [5655] p_nvectors pixel
	# let nvectors = p_nvectors pixel
	addi	x4, x5, 0	# [5656] p_nvectors pixel
	sw	x1, 3(x2)	# [5657] p_nvectors pixel
	addi	x2, x2, 4	# [5658] p_nvectors pixel
	jal	x1, -5429	# [5659] p_nvectors pixel
	addi	x2, x2, -4	# [5660] p_nvectors pixel
	lw	x1, 3(x2)	# [5661] p_nvectors pixel
	lw	x5, 1(x2)	# [5662] p_intersection_points pixel
	sw	x4, 3(x2)	# [5663] p_intersection_points pixel
	# let intersection_points = p_intersection_points pixel
	addi	x4, x5, 0	# [5664] p_intersection_points pixel
	sw	x1, 4(x2)	# [5665] p_intersection_points pixel
	addi	x2, x2, 5	# [5666] p_intersection_points pixel
	jal	x1, -5453	# [5667] p_intersection_points pixel
	addi	x2, x2, -5	# [5668] p_intersection_points pixel
	lw	x1, 4(x2)	# [5669] p_intersection_points pixel
	lw	x5, 1(x2)	# [5670] p_energy pixel
	sw	x4, 4(x2)	# [5671] p_energy pixel
	# let energya = p_energy pixel
	addi	x4, x5, 0	# [5672] p_energy pixel
	sw	x1, 5(x2)	# [5673] p_energy pixel
	addi	x2, x2, 6	# [5674] p_energy pixel
	jal	x1, -5455	# [5675] p_energy pixel
	addi	x2, x2, -6	# [5676] p_energy pixel
	lw	x1, 5(x2)	# [5677] p_energy pixel
	lui	x5, 256	# [5678] diffuse_ray
	addi	x5, x5, 137	# [5679] diffuse_ray
	lw	x6, 0(x2)	# [5680] ray20p.(nref)
	lw	x7, 2(x2)	# [5681] ray20p.(nref)
	add	x31, x7, x6	# [5682] ray20p.(nref)
	lw	x7, 0(x31)	# [5683] ray20p.(nref)
	sw	x4, 5(x2)	# [5684] veccpy diffuse_ray ray20p.(nref)
	addi	x4, x5, 0	# [5685] veccpy diffuse_ray ray20p.(nref)
	addi	x5, x7, 0	# [5686] veccpy diffuse_ray ray20p.(nref)
	sw	x1, 6(x2)	# [5687] veccpy diffuse_ray ray20p.(nref)
	addi	x2, x2, 7	# [5688] veccpy diffuse_ray ray20p.(nref)
	jal	x1, -5651	# [5689] veccpy diffuse_ray ray20p.(nref)
	addi	x2, x2, -7	# [5690] veccpy diffuse_ray ray20p.(nref)
	lw	x1, 6(x2)	# [5691] veccpy diffuse_ray ray20p.(nref)
	addi	x0, x4, 0	# [5692] veccpy diffuse_ray ray20p.(nref)
	lw	x4, 1(x2)	# [5693] p_group_id pixel
	sw	x1, 6(x2)	# [5694] p_group_id pixel
	addi	x2, x2, 7	# [5695] p_group_id pixel
	jal	x1, -5472	# [5696] p_group_id pixel
	addi	x2, x2, -7	# [5697] p_group_id pixel
	lw	x1, 6(x2)	# [5698] p_group_id pixel
	lw	x5, 0(x2)	# [5699] nvectors.(nref)
	lw	x6, 3(x2)	# [5700] nvectors.(nref)
	add	x31, x6, x5	# [5701] nvectors.(nref)
	lw	x6, 0(x31)	# [5702] nvectors.(nref)
	lw	x7, 4(x2)	# [5703] intersection_points.(nref)
	add	x31, x7, x5	# [5704] intersection_points.(nref)
	lw	x7, 0(x31)	# [5705] intersection_points.(nref)
	addi	x5, x6, 0	# [5706] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x6, x7, 0	# [5707] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	sw	x1, 6(x2)	# [5708] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x2, x2, 7	# [5709] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	jal	x1, -145	# [5710] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x2, x2, -7	# [5711] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	lw	x1, 6(x2)	# [5712] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x0, x4, 0	# [5713] trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	lui	x4, 256	# [5714] rgb
	addi	x4, x4, 140	# [5715] rgb
	lw	x5, 0(x2)	# [5716] energya.(nref)
	lw	x6, 5(x2)	# [5717] energya.(nref)
	add	x31, x6, x5	# [5718] energya.(nref)
	lw	x5, 0(x31)	# [5719] energya.(nref)
	lui	x6, 256	# [5720] diffuse_ray
	addi	x6, x6, 137	# [5721] diffuse_ray
	jal	x0, -5585	# [5722] vecaccumv rgb energya.(nref) diffuse_ray
# calc_diffuse_using_5points.3267:	let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	add	x31, x5, x4	# [5723] prev.(x)
	lw	x5, 0(x31)	# [5724] prev.(x)
	sw	x8, 0(x2)	# [5725] p_received_ray_20percent prev.(x)
	sw	x7, 1(x2)	# [5726] p_received_ray_20percent prev.(x)
	sw	x6, 2(x2)	# [5727] p_received_ray_20percent prev.(x)
	sw	x4, 3(x2)	# [5728] p_received_ray_20percent prev.(x)
	# let r_up = p_received_ray_20percent prev.(x)
	addi	x4, x5, 0	# [5729] p_received_ray_20percent prev.(x)
	sw	x1, 4(x2)	# [5730] p_received_ray_20percent prev.(x)
	addi	x2, x2, 5	# [5731] p_received_ray_20percent prev.(x)
	jal	x1, -5510	# [5732] p_received_ray_20percent prev.(x)
	addi	x2, x2, -5	# [5733] p_received_ray_20percent prev.(x)
	lw	x1, 4(x2)	# [5734] p_received_ray_20percent prev.(x)
	lw	x5, 3(x2)	# [5735] x-1
	addi	x6, x5, -1	# [5736] x-1
	lw	x7, 2(x2)	# [5737] cur.(x-1)
	add	x31, x7, x6	# [5738] cur.(x-1)
	lw	x6, 0(x31)	# [5739] cur.(x-1)
	sw	x4, 4(x2)	# [5740] p_received_ray_20percent cur.(x-1)
	# let r_left = p_received_ray_20percent cur.(x-1)
	addi	x4, x6, 0	# [5741] p_received_ray_20percent cur.(x-1)
	sw	x1, 5(x2)	# [5742] p_received_ray_20percent cur.(x-1)
	addi	x2, x2, 6	# [5743] p_received_ray_20percent cur.(x-1)
	jal	x1, -5522	# [5744] p_received_ray_20percent cur.(x-1)
	addi	x2, x2, -6	# [5745] p_received_ray_20percent cur.(x-1)
	lw	x1, 5(x2)	# [5746] p_received_ray_20percent cur.(x-1)
	lw	x5, 3(x2)	# [5747] cur.(x)
	lw	x6, 2(x2)	# [5748] cur.(x)
	add	x31, x6, x5	# [5749] cur.(x)
	lw	x7, 0(x31)	# [5750] cur.(x)
	sw	x4, 5(x2)	# [5751] p_received_ray_20percent cur.(x)
	# let r_center = p_received_ray_20percent cur.(x)
	addi	x4, x7, 0	# [5752] p_received_ray_20percent cur.(x)
	sw	x1, 6(x2)	# [5753] p_received_ray_20percent cur.(x)
	addi	x2, x2, 7	# [5754] p_received_ray_20percent cur.(x)
	jal	x1, -5533	# [5755] p_received_ray_20percent cur.(x)
	addi	x2, x2, -7	# [5756] p_received_ray_20percent cur.(x)
	lw	x1, 6(x2)	# [5757] p_received_ray_20percent cur.(x)
	lw	x5, 3(x2)	# [5758] x+1
	addi	x6, x5, 1	# [5759] x+1
	lw	x7, 2(x2)	# [5760] cur.(x+1)
	add	x31, x7, x6	# [5761] cur.(x+1)
	lw	x6, 0(x31)	# [5762] cur.(x+1)
	sw	x4, 6(x2)	# [5763] p_received_ray_20percent cur.(x+1)
	# let r_right = p_received_ray_20percent cur.(x+1)
	addi	x4, x6, 0	# [5764] p_received_ray_20percent cur.(x+1)
	sw	x1, 7(x2)	# [5765] p_received_ray_20percent cur.(x+1)
	addi	x2, x2, 8	# [5766] p_received_ray_20percent cur.(x+1)
	jal	x1, -5545	# [5767] p_received_ray_20percent cur.(x+1)
	addi	x2, x2, -8	# [5768] p_received_ray_20percent cur.(x+1)
	lw	x1, 7(x2)	# [5769] p_received_ray_20percent cur.(x+1)
	lw	x5, 3(x2)	# [5770] next.(x)
	lw	x6, 1(x2)	# [5771] next.(x)
	add	x31, x6, x5	# [5772] next.(x)
	lw	x6, 0(x31)	# [5773] next.(x)
	sw	x4, 7(x2)	# [5774] p_received_ray_20percent next.(x)
	# let r_down = p_received_ray_20percent next.(x)
	addi	x4, x6, 0	# [5775] p_received_ray_20percent next.(x)
	sw	x1, 8(x2)	# [5776] p_received_ray_20percent next.(x)
	addi	x2, x2, 9	# [5777] p_received_ray_20percent next.(x)
	jal	x1, -5556	# [5778] p_received_ray_20percent next.(x)
	addi	x2, x2, -9	# [5779] p_received_ray_20percent next.(x)
	lw	x1, 8(x2)	# [5780] p_received_ray_20percent next.(x)
	lui	x5, 256	# [5781] diffuse_ray
	addi	x5, x5, 137	# [5782] diffuse_ray
	lw	x6, 0(x2)	# [5783] r_up.(nref)
	lw	x7, 4(x2)	# [5784] r_up.(nref)
	add	x31, x7, x6	# [5785] r_up.(nref)
	lw	x7, 0(x31)	# [5786] r_up.(nref)
	sw	x4, 8(x2)	# [5787] veccpy diffuse_ray r_up.(nref)
	addi	x4, x5, 0	# [5788] veccpy diffuse_ray r_up.(nref)
	addi	x5, x7, 0	# [5789] veccpy diffuse_ray r_up.(nref)
	sw	x1, 9(x2)	# [5790] veccpy diffuse_ray r_up.(nref)
	addi	x2, x2, 10	# [5791] veccpy diffuse_ray r_up.(nref)
	jal	x1, -5754	# [5792] veccpy diffuse_ray r_up.(nref)
	addi	x2, x2, -10	# [5793] veccpy diffuse_ray r_up.(nref)
	lw	x1, 9(x2)	# [5794] veccpy diffuse_ray r_up.(nref)
	addi	x0, x4, 0	# [5795] veccpy diffuse_ray r_up.(nref)
	lui	x4, 256	# [5796] diffuse_ray
	addi	x4, x4, 137	# [5797] diffuse_ray
	lw	x5, 0(x2)	# [5798] r_left.(nref)
	lw	x6, 5(x2)	# [5799] r_left.(nref)
	add	x31, x6, x5	# [5800] r_left.(nref)
	lw	x6, 0(x31)	# [5801] r_left.(nref)
	addi	x5, x6, 0	# [5802] vecadd diffuse_ray r_left.(nref)
	sw	x1, 9(x2)	# [5803] vecadd diffuse_ray r_left.(nref)
	addi	x2, x2, 10	# [5804] vecadd diffuse_ray r_left.(nref)
	jal	x1, -5691	# [5805] vecadd diffuse_ray r_left.(nref)
	addi	x2, x2, -10	# [5806] vecadd diffuse_ray r_left.(nref)
	lw	x1, 9(x2)	# [5807] vecadd diffuse_ray r_left.(nref)
	addi	x0, x4, 0	# [5808] vecadd diffuse_ray r_left.(nref)
	lui	x4, 256	# [5809] diffuse_ray
	addi	x4, x4, 137	# [5810] diffuse_ray
	lw	x5, 0(x2)	# [5811] r_center.(nref)
	lw	x6, 6(x2)	# [5812] r_center.(nref)
	add	x31, x6, x5	# [5813] r_center.(nref)
	lw	x6, 0(x31)	# [5814] r_center.(nref)
	addi	x5, x6, 0	# [5815] vecadd diffuse_ray r_center.(nref)
	sw	x1, 9(x2)	# [5816] vecadd diffuse_ray r_center.(nref)
	addi	x2, x2, 10	# [5817] vecadd diffuse_ray r_center.(nref)
	jal	x1, -5704	# [5818] vecadd diffuse_ray r_center.(nref)
	addi	x2, x2, -10	# [5819] vecadd diffuse_ray r_center.(nref)
	lw	x1, 9(x2)	# [5820] vecadd diffuse_ray r_center.(nref)
	addi	x0, x4, 0	# [5821] vecadd diffuse_ray r_center.(nref)
	lui	x4, 256	# [5822] diffuse_ray
	addi	x4, x4, 137	# [5823] diffuse_ray
	lw	x5, 0(x2)	# [5824] r_right.(nref)
	lw	x6, 7(x2)	# [5825] r_right.(nref)
	add	x31, x6, x5	# [5826] r_right.(nref)
	lw	x6, 0(x31)	# [5827] r_right.(nref)
	addi	x5, x6, 0	# [5828] vecadd diffuse_ray r_right.(nref)
	sw	x1, 9(x2)	# [5829] vecadd diffuse_ray r_right.(nref)
	addi	x2, x2, 10	# [5830] vecadd diffuse_ray r_right.(nref)
	jal	x1, -5717	# [5831] vecadd diffuse_ray r_right.(nref)
	addi	x2, x2, -10	# [5832] vecadd diffuse_ray r_right.(nref)
	lw	x1, 9(x2)	# [5833] vecadd diffuse_ray r_right.(nref)
	addi	x0, x4, 0	# [5834] vecadd diffuse_ray r_right.(nref)
	lui	x4, 256	# [5835] diffuse_ray
	addi	x4, x4, 137	# [5836] diffuse_ray
	lw	x5, 0(x2)	# [5837] r_down.(nref)
	lw	x6, 8(x2)	# [5838] r_down.(nref)
	add	x31, x6, x5	# [5839] r_down.(nref)
	lw	x6, 0(x31)	# [5840] r_down.(nref)
	addi	x5, x6, 0	# [5841] vecadd diffuse_ray r_down.(nref)
	sw	x1, 9(x2)	# [5842] vecadd diffuse_ray r_down.(nref)
	addi	x2, x2, 10	# [5843] vecadd diffuse_ray r_down.(nref)
	jal	x1, -5730	# [5844] vecadd diffuse_ray r_down.(nref)
	addi	x2, x2, -10	# [5845] vecadd diffuse_ray r_down.(nref)
	lw	x1, 9(x2)	# [5846] vecadd diffuse_ray r_down.(nref)
	addi	x0, x4, 0	# [5847] vecadd diffuse_ray r_down.(nref)
	lw	x4, 3(x2)	# [5848] cur.(x)
	lw	x5, 2(x2)	# [5849] cur.(x)
	add	x31, x5, x4	# [5850] cur.(x)
	lw	x4, 0(x31)	# [5851] cur.(x)
	# let energya = p_energy cur.(x)
	sw	x1, 9(x2)	# [5852] p_energy cur.(x)
	addi	x2, x2, 10	# [5853] p_energy cur.(x)
	jal	x1, -5634	# [5854] p_energy cur.(x)
	addi	x2, x2, -10	# [5855] p_energy cur.(x)
	lw	x1, 9(x2)	# [5856] p_energy cur.(x)
	lui	x5, 256	# [5857] rgb
	addi	x5, x5, 140	# [5858] rgb
	lw	x6, 0(x2)	# [5859] energya.(nref)
	add	x31, x4, x6	# [5860] energya.(nref)
	lw	x4, 0(x31)	# [5861] energya.(nref)
	lui	x6, 256	# [5862] diffuse_ray
	addi	x6, x6, 137	# [5863] diffuse_ray
	addi	x30, x5, 0	# [5864] vecaccumv rgb energya.(nref) diffuse_ray
	addi	x5, x4, 0	# [5865] vecaccumv rgb energya.(nref) diffuse_ray
	addi	x4, x30, 0	# [5866] vecaccumv rgb energya.(nref) diffuse_ray
	jal	x0, -5730	# [5867] vecaccumv rgb energya.(nref) diffuse_ray
# do_without_neighbors.3273:	let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	addi	x6, x0, 4	# [5868] 4
	bge	x6, x5, 2	# [5869] if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
# blt:	()
	jalr x0, x1, 0	# [5870] ()
# bge:	let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else ()
	sw	x4, 0(x2)	# [5871] p_surface_ids pixel
	sw	x5, 1(x2)	# [5872] p_surface_ids pixel
	# let surface_ids = p_surface_ids pixel
	sw	x1, 2(x2)	# [5873] p_surface_ids pixel
	addi	x2, x2, 3	# [5874] p_surface_ids pixel
	jal	x1, -5659	# [5875] p_surface_ids pixel
	addi	x2, x2, -3	# [5876] p_surface_ids pixel
	lw	x1, 2(x2)	# [5877] p_surface_ids pixel
	lw	x5, 1(x2)	# [5878] surface_ids.(nref)
	add	x31, x4, x5	# [5879] surface_ids.(nref)
	lw	x4, 0(x31)	# [5880] surface_ids.(nref)
	bge	x4, x0, 2	# [5881] if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [5882] ()
# bge:	let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1)
	lw	x4, 0(x2)	# [5883] p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 2(x2)	# [5884] p_calc_diffuse pixel
	addi	x2, x2, 3	# [5885] p_calc_diffuse pixel
	jal	x1, -5668	# [5886] p_calc_diffuse pixel
	addi	x2, x2, -3	# [5887] p_calc_diffuse pixel
	lw	x1, 2(x2)	# [5888] p_calc_diffuse pixel
	lw	x5, 1(x2)	# [5889] calc_diffuse.(nref)
	add	x31, x4, x5	# [5890] calc_diffuse.(nref)
	lw	x4, 0(x31)	# [5891] calc_diffuse.(nref)
	bne	x4, x0, 2	# [5892] if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else ()
# beq:	()
	jal	x0, 8	# [5893] if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else ()
# bne:	calc_diffuse_using_1point pixel nref
	lw	x4, 0(x2)	# [5894] calc_diffuse_using_1point pixel nref
	sw	x1, 2(x2)	# [5895] calc_diffuse_using_1point pixel nref
	addi	x2, x2, 3	# [5896] calc_diffuse_using_1point pixel nref
	jal	x1, -250	# [5897] calc_diffuse_using_1point pixel nref
	addi	x2, x2, -3	# [5898] calc_diffuse_using_1point pixel nref
	lw	x1, 2(x2)	# [5899] calc_diffuse_using_1point pixel nref
	addi	x0, x4, 0	# [5900] calc_diffuse_using_1point pixel nref
# cont:	if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else ()
	lw	x4, 1(x2)	# [5901] nref + 1
	addi	x5, x4, 1	# [5902] nref + 1
	lw	x4, 0(x2)	# [5903] do_without_neighbors pixel (nref + 1)
	jal	x0, -36	# [5904] do_without_neighbors pixel (nref + 1)
# neighbors_exist.3276:	let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	addi	x6, x5, 1	# [5905] y + 1
	lui	x7, 256	# [5906] image_size
	addi	x7, x7, 142	# [5907] image_size
	lw	x7, 1(x7)	# [5908] image_size.(1)
	bge	x6, x7, 16	# [5909] if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
# blt:	if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false
	bge	x0, x5, 13	# [5910] if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false
# blt:	if (x + 1) < image_size.(0) then if x > 0 then true else false else false
	addi	x5, x4, 1	# [5911] x + 1
	lui	x6, 256	# [5912] image_size
	addi	x6, x6, 142	# [5913] image_size
	lw	x6, 0(x6)	# [5914] image_size.(0)
	bge	x5, x6, 6	# [5915] if (x + 1) < image_size.(0) then if x > 0 then true else false else false
# blt:	if x > 0 then true else false
	bge	x0, x4, 3	# [5916] if x > 0 then true else false
# blt:	true
	addi	x4, x0, 1	# [5917] true
	jalr	x0, x1, 0	# [5918] true
# bge:	false
	addi	x4, x0, 0	# [5919] false
	jalr	x0, x1, 0	# [5920] false
# bge:	false
	addi	x4, x0, 0	# [5921] false
	jalr	x0, x1, 0	# [5922] false
# bge:	false
	addi	x4, x0, 0	# [5923] false
	jalr	x0, x1, 0	# [5924] false
# bge:	false
	addi	x4, x0, 0	# [5925] false
	jalr	x0, x1, 0	# [5926] false
# get_surface_id.3280:	let rec get_surface_id pixel index = let surface_ids = p_surface_ids pixel in surface_ids.(index)
	sw	x5, 0(x2)	# [5927] p_surface_ids pixel
	# let surface_ids = p_surface_ids pixel
	sw	x1, 1(x2)	# [5928] p_surface_ids pixel
	addi	x2, x2, 2	# [5929] p_surface_ids pixel
	jal	x1, -5714	# [5930] p_surface_ids pixel
	addi	x2, x2, -2	# [5931] p_surface_ids pixel
	lw	x1, 1(x2)	# [5932] p_surface_ids pixel
	lw	x5, 0(x2)	# [5933] surface_ids.(index)
	add	x31, x4, x5	# [5934] surface_ids.(index)
	lw	x4, 0(x31)	# [5935] surface_ids.(index)
	jalr	x0, x1, 0	# [5936] surface_ids.(index)
# neighbors_are_available.3283:	let rec neighbors_are_available x prev cur next nref = let sid_center = get_surface_id cur.(x) nref in if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false
	add	x31, x6, x4	# [5937] cur.(x)
	lw	x9, 0(x31)	# [5938] cur.(x)
	sw	x6, 0(x2)	# [5939] get_surface_id cur.(x) nref
	sw	x7, 1(x2)	# [5940] get_surface_id cur.(x) nref
	sw	x8, 2(x2)	# [5941] get_surface_id cur.(x) nref
	sw	x4, 3(x2)	# [5942] get_surface_id cur.(x) nref
	sw	x5, 4(x2)	# [5943] get_surface_id cur.(x) nref
	# let sid_center = get_surface_id cur.(x) nref
	addi	x5, x8, 0	# [5944] get_surface_id cur.(x) nref
	addi	x4, x9, 0	# [5945] get_surface_id cur.(x) nref
	sw	x1, 5(x2)	# [5946] get_surface_id cur.(x) nref
	addi	x2, x2, 6	# [5947] get_surface_id cur.(x) nref
	jal	x1, -21	# [5948] get_surface_id cur.(x) nref
	addi	x2, x2, -6	# [5949] get_surface_id cur.(x) nref
	lw	x1, 5(x2)	# [5950] get_surface_id cur.(x) nref
	lw	x5, 3(x2)	# [5951] prev.(x)
	lw	x6, 4(x2)	# [5952] prev.(x)
	add	x31, x6, x5	# [5953] prev.(x)
	lw	x6, 0(x31)	# [5954] prev.(x)
	lw	x7, 2(x2)	# [5955] get_surface_id prev.(x) nref
	sw	x4, 5(x2)	# [5956] get_surface_id prev.(x) nref
	addi	x5, x7, 0	# [5957] get_surface_id prev.(x) nref
	addi	x4, x6, 0	# [5958] get_surface_id prev.(x) nref
	sw	x1, 6(x2)	# [5959] get_surface_id prev.(x) nref
	addi	x2, x2, 7	# [5960] get_surface_id prev.(x) nref
	jal	x1, -34	# [5961] get_surface_id prev.(x) nref
	addi	x2, x2, -7	# [5962] get_surface_id prev.(x) nref
	lw	x1, 6(x2)	# [5963] get_surface_id prev.(x) nref
	lw	x5, 5(x2)	# [5964] if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false
	bne	x4, x5, 52	# [5965] if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false
# beq:	if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false
	lw	x4, 3(x2)	# [5966] next.(x)
	lw	x6, 1(x2)	# [5967] next.(x)
	add	x31, x6, x4	# [5968] next.(x)
	lw	x6, 0(x31)	# [5969] next.(x)
	lw	x7, 2(x2)	# [5970] get_surface_id next.(x) nref
	addi	x5, x7, 0	# [5971] get_surface_id next.(x) nref
	addi	x4, x6, 0	# [5972] get_surface_id next.(x) nref
	sw	x1, 6(x2)	# [5973] get_surface_id next.(x) nref
	addi	x2, x2, 7	# [5974] get_surface_id next.(x) nref
	jal	x1, -48	# [5975] get_surface_id next.(x) nref
	addi	x2, x2, -7	# [5976] get_surface_id next.(x) nref
	lw	x1, 6(x2)	# [5977] get_surface_id next.(x) nref
	lw	x5, 5(x2)	# [5978] if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false
	bne	x4, x5, 36	# [5979] if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false
# beq:	if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false
	lw	x4, 3(x2)	# [5980] x-1
	addi	x6, x4, -1	# [5981] x-1
	lw	x7, 0(x2)	# [5982] cur.(x-1)
	add	x31, x7, x6	# [5983] cur.(x-1)
	lw	x6, 0(x31)	# [5984] cur.(x-1)
	lw	x8, 2(x2)	# [5985] get_surface_id cur.(x-1) nref
	addi	x5, x8, 0	# [5986] get_surface_id cur.(x-1) nref
	addi	x4, x6, 0	# [5987] get_surface_id cur.(x-1) nref
	sw	x1, 6(x2)	# [5988] get_surface_id cur.(x-1) nref
	addi	x2, x2, 7	# [5989] get_surface_id cur.(x-1) nref
	jal	x1, -63	# [5990] get_surface_id cur.(x-1) nref
	addi	x2, x2, -7	# [5991] get_surface_id cur.(x-1) nref
	lw	x1, 6(x2)	# [5992] get_surface_id cur.(x-1) nref
	lw	x5, 5(x2)	# [5993] if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false
	bne	x4, x5, 19	# [5994] if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false
# beq:	if get_surface_id cur.(x+1) nref = sid_center then true else false
	lw	x4, 3(x2)	# [5995] x+1
	addi	x4, x4, 1	# [5996] x+1
	lw	x6, 0(x2)	# [5997] cur.(x+1)
	add	x31, x6, x4	# [5998] cur.(x+1)
	lw	x4, 0(x31)	# [5999] cur.(x+1)
	lw	x6, 2(x2)	# [6000] get_surface_id cur.(x+1) nref
	addi	x5, x6, 0	# [6001] get_surface_id cur.(x+1) nref
	sw	x1, 6(x2)	# [6002] get_surface_id cur.(x+1) nref
	addi	x2, x2, 7	# [6003] get_surface_id cur.(x+1) nref
	jal	x1, -77	# [6004] get_surface_id cur.(x+1) nref
	addi	x2, x2, -7	# [6005] get_surface_id cur.(x+1) nref
	lw	x1, 6(x2)	# [6006] get_surface_id cur.(x+1) nref
	lw	x5, 5(x2)	# [6007] if get_surface_id cur.(x+1) nref = sid_center then true else false
	bne	x4, x5, 3	# [6008] if get_surface_id cur.(x+1) nref = sid_center then true else false
# beq:	true
	addi	x4, x0, 1	# [6009] true
	jalr	x0, x1, 0	# [6010] true
# bne:	false
	addi	x4, x0, 0	# [6011] false
	jalr	x0, x1, 0	# [6012] false
# bne:	false
	addi	x4, x0, 0	# [6013] false
	jalr	x0, x1, 0	# [6014] false
# bne:	false
	addi	x4, x0, 0	# [6015] false
	jalr	x0, x1, 0	# [6016] false
# bne:	false
	addi	x4, x0, 0	# [6017] false
	jalr	x0, x1, 0	# [6018] false
# try_exploit_neighbors.3289:	let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	# let pixel = cur.(x)
	add	x31, x7, x4	# [6019] cur.(x)
	lw	x10, 0(x31)	# [6020] cur.(x)
	addi	x11, x0, 4	# [6021] 4
	bge	x11, x9, 2	# [6022] if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
# blt:	()
	jalr x0, x1, 0	# [6023] ()
# bge:	if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else ()
	sw	x5, 0(x2)	# [6024] get_surface_id pixel nref
	sw	x10, 1(x2)	# [6025] get_surface_id pixel nref
	sw	x9, 2(x2)	# [6026] get_surface_id pixel nref
	sw	x8, 3(x2)	# [6027] get_surface_id pixel nref
	sw	x7, 4(x2)	# [6028] get_surface_id pixel nref
	sw	x6, 5(x2)	# [6029] get_surface_id pixel nref
	sw	x4, 6(x2)	# [6030] get_surface_id pixel nref
	addi	x5, x9, 0	# [6031] get_surface_id pixel nref
	addi	x4, x10, 0	# [6032] get_surface_id pixel nref
	sw	x1, 7(x2)	# [6033] get_surface_id pixel nref
	addi	x2, x2, 8	# [6034] get_surface_id pixel nref
	jal	x1, -108	# [6035] get_surface_id pixel nref
	addi	x2, x2, -8	# [6036] get_surface_id pixel nref
	lw	x1, 7(x2)	# [6037] get_surface_id pixel nref
	bge	x4, x0, 2	# [6038] if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else ()
# blt:	()
	jalr x0, x1, 0	# [6039] ()
# bge:	if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref
	lw	x4, 6(x2)	# [6040] neighbors_are_available x prev cur next nref
	lw	x5, 5(x2)	# [6041] neighbors_are_available x prev cur next nref
	lw	x6, 4(x2)	# [6042] neighbors_are_available x prev cur next nref
	lw	x7, 3(x2)	# [6043] neighbors_are_available x prev cur next nref
	lw	x8, 2(x2)	# [6044] neighbors_are_available x prev cur next nref
	sw	x1, 7(x2)	# [6045] neighbors_are_available x prev cur next nref
	addi	x2, x2, 8	# [6046] neighbors_are_available x prev cur next nref
	jal	x1, -110	# [6047] neighbors_are_available x prev cur next nref
	addi	x2, x2, -8	# [6048] neighbors_are_available x prev cur next nref
	lw	x1, 7(x2)	# [6049] neighbors_are_available x prev cur next nref
	bne	x4, x0, 7	# [6050] if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref
# beq:	do_without_neighbors cur.(x) nref
	lw	x4, 6(x2)	# [6051] cur.(x)
	lw	x5, 4(x2)	# [6052] cur.(x)
	add	x31, x5, x4	# [6053] cur.(x)
	lw	x4, 0(x31)	# [6054] cur.(x)
	lw	x5, 2(x2)	# [6055] do_without_neighbors cur.(x) nref
	jal	x0, -188	# [6056] do_without_neighbors cur.(x) nref
# bne:	let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x4, 1(x2)	# [6057] p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 7(x2)	# [6058] p_calc_diffuse pixel
	addi	x2, x2, 8	# [6059] p_calc_diffuse pixel
	jal	x1, -5842	# [6060] p_calc_diffuse pixel
	addi	x2, x2, -8	# [6061] p_calc_diffuse pixel
	lw	x1, 7(x2)	# [6062] p_calc_diffuse pixel
	lw	x8, 2(x2)	# [6063] calc_diffuse.(nref)
	add	x31, x4, x8	# [6064] calc_diffuse.(nref)
	lw	x4, 0(x31)	# [6065] calc_diffuse.(nref)
	bne	x4, x0, 2	# [6066] if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else ()
# beq:	()
	jal	x0, 11	# [6067] if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else ()
# bne:	calc_diffuse_using_5points x prev cur next nref
	lw	x4, 6(x2)	# [6068] calc_diffuse_using_5points x prev cur next nref
	lw	x5, 5(x2)	# [6069] calc_diffuse_using_5points x prev cur next nref
	lw	x6, 4(x2)	# [6070] calc_diffuse_using_5points x prev cur next nref
	lw	x7, 3(x2)	# [6071] calc_diffuse_using_5points x prev cur next nref
	sw	x1, 7(x2)	# [6072] calc_diffuse_using_5points x prev cur next nref
	addi	x2, x2, 8	# [6073] calc_diffuse_using_5points x prev cur next nref
	jal	x1, -351	# [6074] calc_diffuse_using_5points x prev cur next nref
	addi	x2, x2, -8	# [6075] calc_diffuse_using_5points x prev cur next nref
	lw	x1, 7(x2)	# [6076] calc_diffuse_using_5points x prev cur next nref
	addi	x0, x4, 0	# [6077] calc_diffuse_using_5points x prev cur next nref
# cont:	if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else ()
	lw	x4, 2(x2)	# [6078] nref + 1
	addi	x9, x4, 1	# [6079] nref + 1
	lw	x4, 6(x2)	# [6080] try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x5, 0(x2)	# [6081] try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x6, 5(x2)	# [6082] try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x7, 4(x2)	# [6083] try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x8, 3(x2)	# [6084] try_exploit_neighbors x y prev cur next (nref + 1)
	jal	x0, -66	# [6085] try_exploit_neighbors x y prev cur next (nref + 1)
# write_ppm_header.3296:	let rec write_ppm_header _ = ( print_char 80; print_char 54; print_char 10; print_char 49; print_char 50; print_char 56; print_char 10; print_char 49; print_char 50; print_char 56; print_char 10; print_char 50; print_char 53; print_char 53; print_char 10; print_char 50; print_char 53; print_char 53; print_char 10; )
	addi	x4, x0, 80	# [6086] 80
	ob	x4	# [6087] print_char 80
	addi	x4, x0, 54	# [6088] 54
	ob	x4	# [6089] print_char 54
	addi	x4, x0, 10	# [6090] 10
	ob	x4	# [6091] print_char 10
	addi	x4, x0, 49	# [6092] 49
	ob	x4	# [6093] print_char 49
	addi	x4, x0, 50	# [6094] 50
	ob	x4	# [6095] print_char 50
	addi	x4, x0, 56	# [6096] 56
	ob	x4	# [6097] print_char 56
	addi	x4, x0, 10	# [6098] 10
	ob	x4	# [6099] print_char 10
	addi	x4, x0, 49	# [6100] 49
	ob	x4	# [6101] print_char 49
	addi	x4, x0, 50	# [6102] 50
	ob	x4	# [6103] print_char 50
	addi	x4, x0, 56	# [6104] 56
	ob	x4	# [6105] print_char 56
	addi	x4, x0, 10	# [6106] 10
	ob	x4	# [6107] print_char 10
	addi	x4, x0, 50	# [6108] 50
	ob	x4	# [6109] print_char 50
	addi	x4, x0, 53	# [6110] 53
	ob	x4	# [6111] print_char 53
	addi	x4, x0, 53	# [6112] 53
	ob	x4	# [6113] print_char 53
	addi	x4, x0, 10	# [6114] 10
	ob	x4	# [6115] print_char 10
	addi	x4, x0, 50	# [6116] 50
	ob	x4	# [6117] print_char 50
	addi	x4, x0, 53	# [6118] 53
	ob	x4	# [6119] print_char 53
	addi	x4, x0, 53	# [6120] 53
	ob	x4	# [6121] print_char 53
	addi	x4, x0, 10	# [6122] 10
	ob	x4	# [6123] print_char 10
	jalr x0, x1, 0	# [6124]
# write_rgb_element.3298:	let rec write_rgb_element x = let ix = int_of_float x in let elem = if ix > 255 then 255 else if ix < 0 then 0 else ix in print_char elem
	# let ix = int_of_float x
	ftoi	x4, f1	# [6125] int_of_float x
	addi	x5, x0, 255	# [6126] 255
	# let elem = if ix > 255 then 255 else if ix < 0 then 0 else ix
	bge	x5, x4, 3	# [6127] if ix > 255 then 255 else if ix < 0 then 0 else ix
# blt:	255
	addi	x4, x0, 255	# [6128] 255
	jal	x0, 4	# [6129] if ix > 255 then 255 else if ix < 0 then 0 else ix
# bge:	if ix < 0 then 0 else ix
	bge	x4, x0, 3	# [6130] if ix < 0 then 0 else ix
# blt:	0
	addi	x4, x0, 0	# [6131] 0
	jal	x0, 1	# [6132] if ix < 0 then 0 else ix
# bge:	ix
# cont:	if ix < 0 then 0 else ix
# cont:	if ix > 255 then 255 else if ix < 0 then 0 else ix
	ob	x4	# [6133] print_char elem
	jalr x0, x1, 0	# [6134] print_char elem
# write_rgb.3300:	let rec write_rgb _ = write_rgb_element rgb.(0); print_char 32; write_rgb_element rgb.(1); print_char 32; write_rgb_element rgb.(2); print_char 10
	lui	x4, 256	# [6135] rgb
	addi	x4, x4, 140	# [6136] rgb
	flw	f1, 0(x4)	# [6137] rgb.(0)
	sw	x1, 0(x2)	# [6138] write_rgb_element rgb.(0)
	addi	x2, x2, 1	# [6139] write_rgb_element rgb.(0)
	jal	x1, -15	# [6140] write_rgb_element rgb.(0)
	addi	x2, x2, -1	# [6141] write_rgb_element rgb.(0)
	lw	x1, 0(x2)	# [6142] write_rgb_element rgb.(0)
	addi	x0, x4, 0	# [6143] write_rgb_element rgb.(0)
	addi	x4, x0, 32	# [6144] 32
	ob	x4	# [6145] print_char 32
	lui	x4, 256	# [6146] rgb
	addi	x4, x4, 140	# [6147] rgb
	flw	f1, 1(x4)	# [6148] rgb.(1)
	sw	x1, 0(x2)	# [6149] write_rgb_element rgb.(1)
	addi	x2, x2, 1	# [6150] write_rgb_element rgb.(1)
	jal	x1, -26	# [6151] write_rgb_element rgb.(1)
	addi	x2, x2, -1	# [6152] write_rgb_element rgb.(1)
	lw	x1, 0(x2)	# [6153] write_rgb_element rgb.(1)
	addi	x0, x4, 0	# [6154] write_rgb_element rgb.(1)
	addi	x4, x0, 32	# [6155] 32
	ob	x4	# [6156] print_char 32
	lui	x4, 256	# [6157] rgb
	addi	x4, x4, 140	# [6158] rgb
	flw	f1, 2(x4)	# [6159] rgb.(2)
	sw	x1, 0(x2)	# [6160] write_rgb_element rgb.(2)
	addi	x2, x2, 1	# [6161] write_rgb_element rgb.(2)
	jal	x1, -37	# [6162] write_rgb_element rgb.(2)
	addi	x2, x2, -1	# [6163] write_rgb_element rgb.(2)
	lw	x1, 0(x2)	# [6164] write_rgb_element rgb.(2)
	addi	x0, x4, 0	# [6165] write_rgb_element rgb.(2)
	addi	x4, x0, 10	# [6166] 10
	ob	x4	# [6167] print_char 10
	jalr x0, x1, 0	# [6168] print_char 10
# pretrace_diffuse_rays.3302:	let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	addi	x6, x0, 4	# [6169] 4
	bge	x6, x5, 2	# [6170] if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
# blt:	()
	jalr x0, x1, 0	# [6171] ()
# bge:	let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else ()
	sw	x5, 0(x2)	# [6172] get_surface_id pixel nref
	sw	x4, 1(x2)	# [6173] get_surface_id pixel nref
	# let sid = get_surface_id pixel nref
	sw	x1, 2(x2)	# [6174] get_surface_id pixel nref
	addi	x2, x2, 3	# [6175] get_surface_id pixel nref
	jal	x1, -249	# [6176] get_surface_id pixel nref
	addi	x2, x2, -3	# [6177] get_surface_id pixel nref
	lw	x1, 2(x2)	# [6178] get_surface_id pixel nref
	bge	x4, x0, 2	# [6179] if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [6180] ()
# bge:	let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1)
	lw	x4, 1(x2)	# [6181] p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 2(x2)	# [6182] p_calc_diffuse pixel
	addi	x2, x2, 3	# [6183] p_calc_diffuse pixel
	jal	x1, -5966	# [6184] p_calc_diffuse pixel
	addi	x2, x2, -3	# [6185] p_calc_diffuse pixel
	lw	x1, 2(x2)	# [6186] p_calc_diffuse pixel
	lw	x5, 0(x2)	# [6187] calc_diffuse.(nref)
	add	x31, x4, x5	# [6188] calc_diffuse.(nref)
	lw	x4, 0(x31)	# [6189] calc_diffuse.(nref)
	bne	x4, x0, 2	# [6190] if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else ()
# beq:	()
	jal	x0, 69	# [6191] if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else ()
# bne:	let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray
	lw	x4, 1(x2)	# [6192] p_group_id pixel
	# let group_id = p_group_id pixel
	sw	x1, 2(x2)	# [6193] p_group_id pixel
	addi	x2, x2, 3	# [6194] p_group_id pixel
	jal	x1, -5971	# [6195] p_group_id pixel
	addi	x2, x2, -3	# [6196] p_group_id pixel
	lw	x1, 2(x2)	# [6197] p_group_id pixel
	lui	x5, 256	# [6198] diffuse_ray
	addi	x5, x5, 137	# [6199] diffuse_ray
	sw	x4, 2(x2)	# [6200] vecbzero diffuse_ray
	addi	x4, x5, 0	# [6201] vecbzero diffuse_ray
	sw	x1, 3(x2)	# [6202] vecbzero diffuse_ray
	addi	x2, x2, 4	# [6203] vecbzero diffuse_ray
	jal	x1, -6169	# [6204] vecbzero diffuse_ray
	addi	x2, x2, -4	# [6205] vecbzero diffuse_ray
	lw	x1, 3(x2)	# [6206] vecbzero diffuse_ray
	addi	x0, x4, 0	# [6207] vecbzero diffuse_ray
	lw	x4, 1(x2)	# [6208] p_nvectors pixel
	# let nvectors = p_nvectors pixel
	sw	x1, 3(x2)	# [6209] p_nvectors pixel
	addi	x2, x2, 4	# [6210] p_nvectors pixel
	jal	x1, -5981	# [6211] p_nvectors pixel
	addi	x2, x2, -4	# [6212] p_nvectors pixel
	lw	x1, 3(x2)	# [6213] p_nvectors pixel
	lw	x5, 1(x2)	# [6214] p_intersection_points pixel
	sw	x4, 3(x2)	# [6215] p_intersection_points pixel
	# let intersection_points = p_intersection_points pixel
	addi	x4, x5, 0	# [6216] p_intersection_points pixel
	sw	x1, 4(x2)	# [6217] p_intersection_points pixel
	addi	x2, x2, 5	# [6218] p_intersection_points pixel
	jal	x1, -6005	# [6219] p_intersection_points pixel
	addi	x2, x2, -5	# [6220] p_intersection_points pixel
	lw	x1, 4(x2)	# [6221] p_intersection_points pixel
	lui	x5, 256	# [6222] dirvecs
	addi	x5, x5, 168	# [6223] dirvecs
	lw	x6, 2(x2)	# [6224] dirvecs.(group_id)
	add	x31, x5, x6	# [6225] dirvecs.(group_id)
	lw	x5, 0(x31)	# [6226] dirvecs.(group_id)
	lw	x6, 0(x2)	# [6227] nvectors.(nref)
	lw	x7, 3(x2)	# [6228] nvectors.(nref)
	add	x31, x7, x6	# [6229] nvectors.(nref)
	lw	x7, 0(x31)	# [6230] nvectors.(nref)
	add	x31, x4, x6	# [6231] intersection_points.(nref)
	lw	x4, 0(x31)	# [6232] intersection_points.(nref)
	addi	x6, x4, 0	# [6233] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x4, x5, 0	# [6234] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x5, x7, 0	# [6235] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	sw	x1, 4(x2)	# [6236] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x2, x2, 5	# [6237] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	jal	x1, -688	# [6238] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x2, x2, -5	# [6239] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	lw	x1, 4(x2)	# [6240] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x0, x4, 0	# [6241] trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	lw	x4, 1(x2)	# [6242] p_received_ray_20percent pixel
	# let ray20p = p_received_ray_20percent pixel
	sw	x1, 4(x2)	# [6243] p_received_ray_20percent pixel
	addi	x2, x2, 5	# [6244] p_received_ray_20percent pixel
	jal	x1, -6023	# [6245] p_received_ray_20percent pixel
	addi	x2, x2, -5	# [6246] p_received_ray_20percent pixel
	lw	x1, 4(x2)	# [6247] p_received_ray_20percent pixel
	lw	x5, 0(x2)	# [6248] ray20p.(nref)
	add	x31, x4, x5	# [6249] ray20p.(nref)
	lw	x4, 0(x31)	# [6250] ray20p.(nref)
	lui	x6, 256	# [6251] diffuse_ray
	addi	x6, x6, 137	# [6252] diffuse_ray
	addi	x5, x6, 0	# [6253] veccpy ray20p.(nref) diffuse_ray
	sw	x1, 4(x2)	# [6254] veccpy ray20p.(nref) diffuse_ray
	addi	x2, x2, 5	# [6255] veccpy ray20p.(nref) diffuse_ray
	jal	x1, -6218	# [6256] veccpy ray20p.(nref) diffuse_ray
	addi	x2, x2, -5	# [6257] veccpy ray20p.(nref) diffuse_ray
	lw	x1, 4(x2)	# [6258] veccpy ray20p.(nref) diffuse_ray
	addi	x0, x4, 0	# [6259] veccpy ray20p.(nref) diffuse_ray
# cont:	if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else ()
	lw	x4, 0(x2)	# [6260] nref + 1
	addi	x5, x4, 1	# [6261] nref + 1
	lw	x4, 1(x2)	# [6262] pretrace_diffuse_rays pixel (nref + 1)
	jal	x0, -94	# [6263] pretrace_diffuse_rays pixel (nref + 1)
# pretrace_pixels.3305:	let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	bge	x5, x0, 2	# [6264] if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
# blt:	()
	jalr x0, x1, 0	# [6265] ()
# bge:	let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	lui	x7, 256	# [6266] scan_pitch
	addi	x7, x7, 145	# [6267] scan_pitch
	flw	f4, 0(x7)	# [6268] scan_pitch.(0)
	lui	x7, 256	# [6269] image_center
	addi	x7, x7, 144	# [6270] image_center
	lw	x7, 0(x7)	# [6271] image_center.(0)
	sub	x7, x5, x7	# [6272] x - image_center.(0)
	itof	f5, x7	# [6273] float_of_int (x - image_center.(0))
	# let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0))
	fmul	f4, f4, f5	# [6274] scan_pitch.(0) *. float_of_int (x - image_center.(0))
	lui	x7, 256	# [6275] ptrace_dirvec
	addi	x7, x7, 163	# [6276] ptrace_dirvec
	lui	x8, 256	# [6277] screenx_dir
	addi	x8, x8, 154	# [6278] screenx_dir
	flw	f5, 0(x8)	# [6279] screenx_dir.(0)
	fmul	f5, f4, f5	# [6280] xdisp *. screenx_dir.(0)
	fadd	f5, f5, f1	# [6281] xdisp *. screenx_dir.(0) +. lc0
	fsw	f5, 0(x7)	# [6282] ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0
	lui	x7, 256	# [6283] ptrace_dirvec
	addi	x7, x7, 163	# [6284] ptrace_dirvec
	lui	x8, 256	# [6285] screenx_dir
	addi	x8, x8, 154	# [6286] screenx_dir
	flw	f5, 1(x8)	# [6287] screenx_dir.(1)
	fmul	f5, f4, f5	# [6288] xdisp *. screenx_dir.(1)
	fadd	f5, f5, f2	# [6289] xdisp *. screenx_dir.(1) +. lc1
	fsw	f5, 1(x7)	# [6290] ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1
	lui	x7, 256	# [6291] ptrace_dirvec
	addi	x7, x7, 163	# [6292] ptrace_dirvec
	lui	x8, 256	# [6293] screenx_dir
	addi	x8, x8, 154	# [6294] screenx_dir
	flw	f5, 2(x8)	# [6295] screenx_dir.(2)
	fmul	f4, f4, f5	# [6296] xdisp *. screenx_dir.(2)
	fadd	f4, f4, f3	# [6297] xdisp *. screenx_dir.(2) +. lc2
	fsw	f4, 2(x7)	# [6298] ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2
	lui	x7, 256	# [6299] ptrace_dirvec
	addi	x7, x7, 163	# [6300] ptrace_dirvec
	addi	x8, x0, 0	# [6301] false
	fsw	f3, 0(x2)	# [6302] vecunit_sgn ptrace_dirvec false
	fsw	f2, 1(x2)	# [6303] vecunit_sgn ptrace_dirvec false
	fsw	f1, 2(x2)	# [6304] vecunit_sgn ptrace_dirvec false
	sw	x6, 3(x2)	# [6305] vecunit_sgn ptrace_dirvec false
	sw	x5, 4(x2)	# [6306] vecunit_sgn ptrace_dirvec false
	sw	x4, 5(x2)	# [6307] vecunit_sgn ptrace_dirvec false
	addi	x5, x8, 0	# [6308] vecunit_sgn ptrace_dirvec false
	addi	x4, x7, 0	# [6309] vecunit_sgn ptrace_dirvec false
	sw	x1, 6(x2)	# [6310] vecunit_sgn ptrace_dirvec false
	addi	x2, x2, 7	# [6311] vecunit_sgn ptrace_dirvec false
	jal	x1, -6267	# [6312] vecunit_sgn ptrace_dirvec false
	addi	x2, x2, -7	# [6313] vecunit_sgn ptrace_dirvec false
	lw	x1, 6(x2)	# [6314] vecunit_sgn ptrace_dirvec false
	addi	x0, x4, 0	# [6315] vecunit_sgn ptrace_dirvec false
	lui	x4, 256	# [6316] rgb
	addi	x4, x4, 140	# [6317] rgb
	sw	x1, 6(x2)	# [6318] vecbzero rgb
	addi	x2, x2, 7	# [6319] vecbzero rgb
	jal	x1, -6285	# [6320] vecbzero rgb
	addi	x2, x2, -7	# [6321] vecbzero rgb
	lw	x1, 6(x2)	# [6322] vecbzero rgb
	addi	x0, x4, 0	# [6323] vecbzero rgb
	lui	x4, 256	# [6324] startp
	addi	x4, x4, 148	# [6325] startp
	lui	x5, 256	# [6326] viewpoint
	addi	x5, x5, 66	# [6327] viewpoint
	sw	x1, 6(x2)	# [6328] veccpy startp viewpoint
	addi	x2, x2, 7	# [6329] veccpy startp viewpoint
	jal	x1, -6292	# [6330] veccpy startp viewpoint
	addi	x2, x2, -7	# [6331] veccpy startp viewpoint
	lw	x1, 6(x2)	# [6332] veccpy startp viewpoint
	addi	x0, x4, 0	# [6333] veccpy startp viewpoint
	addi	x4, x0, 0	# [6334] 0
	lui	x31, 260096	# [6335] 1.0
	addi	x31, x31, 0	# [6336] 1.0
	xtof	f1, x31	# [6337] 1.0
	lui	x5, 256	# [6338] ptrace_dirvec
	addi	x5, x5, 163	# [6339] ptrace_dirvec
	lw	x6, 4(x2)	# [6340] line.(x)
	lw	x7, 5(x2)	# [6341] line.(x)
	add	x31, x7, x6	# [6342] line.(x)
	lw	x8, 0(x31)	# [6343] line.(x)
	addi	x31, x0, 0	# [6344] 0.0
	xtof	f2, x31	# [6345] 0.0
	addi	x6, x8, 0	# [6346] trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	sw	x1, 6(x2)	# [6347] trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	addi	x2, x2, 7	# [6348] trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	jal	x1, -1316	# [6349] trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	addi	x2, x2, -7	# [6350] trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	lw	x1, 6(x2)	# [6351] trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	addi	x0, x4, 0	# [6352] trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	lw	x4, 4(x2)	# [6353] line.(x)
	lw	x5, 5(x2)	# [6354] line.(x)
	add	x31, x5, x4	# [6355] line.(x)
	lw	x6, 0(x31)	# [6356] line.(x)
	addi	x4, x6, 0	# [6357] p_rgb line.(x)
	sw	x1, 6(x2)	# [6358] p_rgb line.(x)
	addi	x2, x2, 7	# [6359] p_rgb line.(x)
	jal	x1, -6148	# [6360] p_rgb line.(x)
	addi	x2, x2, -7	# [6361] p_rgb line.(x)
	lw	x1, 6(x2)	# [6362] p_rgb line.(x)
	lui	x5, 256	# [6363] rgb
	addi	x5, x5, 140	# [6364] rgb
	sw	x1, 6(x2)	# [6365] veccpy (p_rgb line.(x)) rgb
	addi	x2, x2, 7	# [6366] veccpy (p_rgb line.(x)) rgb
	jal	x1, -6329	# [6367] veccpy (p_rgb line.(x)) rgb
	addi	x2, x2, -7	# [6368] veccpy (p_rgb line.(x)) rgb
	lw	x1, 6(x2)	# [6369] veccpy (p_rgb line.(x)) rgb
	addi	x0, x4, 0	# [6370] veccpy (p_rgb line.(x)) rgb
	lw	x4, 4(x2)	# [6371] line.(x)
	lw	x5, 5(x2)	# [6372] line.(x)
	add	x31, x5, x4	# [6373] line.(x)
	lw	x6, 0(x31)	# [6374] line.(x)
	lw	x7, 3(x2)	# [6375] p_set_group_id line.(x) group_id
	addi	x5, x7, 0	# [6376] p_set_group_id line.(x) group_id
	addi	x4, x6, 0	# [6377] p_set_group_id line.(x) group_id
	sw	x1, 6(x2)	# [6378] p_set_group_id line.(x) group_id
	addi	x2, x2, 7	# [6379] p_set_group_id line.(x) group_id
	jal	x1, -6153	# [6380] p_set_group_id line.(x) group_id
	addi	x2, x2, -7	# [6381] p_set_group_id line.(x) group_id
	lw	x1, 6(x2)	# [6382] p_set_group_id line.(x) group_id
	addi	x0, x4, 0	# [6383] p_set_group_id line.(x) group_id
	lw	x4, 4(x2)	# [6384] line.(x)
	lw	x5, 5(x2)	# [6385] line.(x)
	add	x31, x5, x4	# [6386] line.(x)
	lw	x6, 0(x31)	# [6387] line.(x)
	addi	x7, x0, 0	# [6388] 0
	addi	x5, x7, 0	# [6389] pretrace_diffuse_rays line.(x) 0
	addi	x4, x6, 0	# [6390] pretrace_diffuse_rays line.(x) 0
	sw	x1, 6(x2)	# [6391] pretrace_diffuse_rays line.(x) 0
	addi	x2, x2, 7	# [6392] pretrace_diffuse_rays line.(x) 0
	jal	x1, -224	# [6393] pretrace_diffuse_rays line.(x) 0
	addi	x2, x2, -7	# [6394] pretrace_diffuse_rays line.(x) 0
	lw	x1, 6(x2)	# [6395] pretrace_diffuse_rays line.(x) 0
	addi	x0, x4, 0	# [6396] pretrace_diffuse_rays line.(x) 0
	lw	x4, 4(x2)	# [6397] x-1
	addi	x4, x4, -1	# [6398] x-1
	addi	x5, x0, 1	# [6399] 1
	lw	x6, 3(x2)	# [6400] add_mod5 group_id 1
	sw	x4, 6(x2)	# [6401] add_mod5 group_id 1
	addi	x4, x6, 0	# [6402] add_mod5 group_id 1
	sw	x1, 7(x2)	# [6403] add_mod5 group_id 1
	addi	x2, x2, 8	# [6404] add_mod5 group_id 1
	jal	x1, -6384	# [6405] add_mod5 group_id 1
	addi	x2, x2, -8	# [6406] add_mod5 group_id 1
	lw	x1, 7(x2)	# [6407] add_mod5 group_id 1
	addi	x6, x4, 0	# [6408] add_mod5 group_id 1
	flw	f1, 2(x2)	# [6409] pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	flw	f2, 1(x2)	# [6410] pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	flw	f3, 0(x2)	# [6411] pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	lw	x4, 5(x2)	# [6412] pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	lw	x5, 6(x2)	# [6413] pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	jal	x0, -150	# [6414] pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
# pretrace_line.3312:	let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lui	x7, 256	# [6415] scan_pitch
	addi	x7, x7, 145	# [6416] scan_pitch
	flw	f1, 0(x7)	# [6417] scan_pitch.(0)
	lui	x7, 256	# [6418] image_center
	addi	x7, x7, 144	# [6419] image_center
	lw	x7, 1(x7)	# [6420] image_center.(1)
	sub	x5, x5, x7	# [6421] y - image_center.(1)
	itof	f2, x5	# [6422] float_of_int (y - image_center.(1))
	# let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1))
	fmul	f1, f1, f2	# [6423] scan_pitch.(0) *. float_of_int (y - image_center.(1))
	lui	x5, 256	# [6424] screeny_dir
	addi	x5, x5, 157	# [6425] screeny_dir
	flw	f2, 0(x5)	# [6426] screeny_dir.(0)
	fmul	f2, f1, f2	# [6427] ydisp *. screeny_dir.(0)
	lui	x5, 256	# [6428] screenz_dir
	addi	x5, x5, 160	# [6429] screenz_dir
	flw	f3, 0(x5)	# [6430] screenz_dir.(0)
	# let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0)
	fadd	f2, f2, f3	# [6431] ydisp *. screeny_dir.(0) +. screenz_dir.(0)
	lui	x5, 256	# [6432] screeny_dir
	addi	x5, x5, 157	# [6433] screeny_dir
	flw	f3, 1(x5)	# [6434] screeny_dir.(1)
	fmul	f3, f1, f3	# [6435] ydisp *. screeny_dir.(1)
	lui	x5, 256	# [6436] screenz_dir
	addi	x5, x5, 160	# [6437] screenz_dir
	flw	f4, 1(x5)	# [6438] screenz_dir.(1)
	# let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1)
	fadd	f3, f3, f4	# [6439] ydisp *. screeny_dir.(1) +. screenz_dir.(1)
	lui	x5, 256	# [6440] screeny_dir
	addi	x5, x5, 157	# [6441] screeny_dir
	flw	f4, 2(x5)	# [6442] screeny_dir.(2)
	fmul	f1, f1, f4	# [6443] ydisp *. screeny_dir.(2)
	lui	x5, 256	# [6444] screenz_dir
	addi	x5, x5, 160	# [6445] screenz_dir
	flw	f4, 2(x5)	# [6446] screenz_dir.(2)
	# let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2)
	fadd	f1, f1, f4	# [6447] ydisp *. screeny_dir.(2) +. screenz_dir.(2)
	lui	x5, 256	# [6448] image_size
	addi	x5, x5, 142	# [6449] image_size
	lw	x5, 0(x5)	# [6450] image_size.(0)
	addi	x5, x5, -1	# [6451] image_size.(0) - 1
	fmv	f31, f3	# [6452] pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	fmv	f3, f1	# [6453] pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	fmv	f1, f2	# [6454] pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	fmv	f2, f31	# [6455] pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	jal	x0, -192	# [6456] pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
# scan_pixel.3316:	let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lui	x9, 256	# [6457] image_size
	addi	x9, x9, 142	# [6458] image_size
	lw	x9, 0(x9)	# [6459] image_size.(0)
	bge	x4, x9, 73	# [6460] if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
# blt:	veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next
	lui	x9, 256	# [6461] rgb
	addi	x9, x9, 140	# [6462] rgb
	add	x31, x7, x4	# [6463] cur.(x)
	lw	x10, 0(x31)	# [6464] cur.(x)
	sw	x6, 0(x2)	# [6465] p_rgb cur.(x)
	sw	x7, 1(x2)	# [6466] p_rgb cur.(x)
	sw	x8, 2(x2)	# [6467] p_rgb cur.(x)
	sw	x5, 3(x2)	# [6468] p_rgb cur.(x)
	sw	x4, 4(x2)	# [6469] p_rgb cur.(x)
	sw	x9, 5(x2)	# [6470] p_rgb cur.(x)
	addi	x4, x10, 0	# [6471] p_rgb cur.(x)
	sw	x1, 6(x2)	# [6472] p_rgb cur.(x)
	addi	x2, x2, 7	# [6473] p_rgb cur.(x)
	jal	x1, -6262	# [6474] p_rgb cur.(x)
	addi	x2, x2, -7	# [6475] p_rgb cur.(x)
	lw	x1, 6(x2)	# [6476] p_rgb cur.(x)
	addi	x5, x4, 0	# [6477] p_rgb cur.(x)
	lw	x4, 5(x2)	# [6478] veccpy rgb (p_rgb cur.(x))
	sw	x1, 6(x2)	# [6479] veccpy rgb (p_rgb cur.(x))
	addi	x2, x2, 7	# [6480] veccpy rgb (p_rgb cur.(x))
	jal	x1, -6443	# [6481] veccpy rgb (p_rgb cur.(x))
	addi	x2, x2, -7	# [6482] veccpy rgb (p_rgb cur.(x))
	lw	x1, 6(x2)	# [6483] veccpy rgb (p_rgb cur.(x))
	addi	x0, x4, 0	# [6484] veccpy rgb (p_rgb cur.(x))
	lw	x4, 4(x2)	# [6485] neighbors_exist x y next
	lw	x5, 3(x2)	# [6486] neighbors_exist x y next
	lw	x6, 2(x2)	# [6487] neighbors_exist x y next
	sw	x1, 6(x2)	# [6488] neighbors_exist x y next
	addi	x2, x2, 7	# [6489] neighbors_exist x y next
	jal	x1, -585	# [6490] neighbors_exist x y next
	addi	x2, x2, -7	# [6491] neighbors_exist x y next
	lw	x1, 6(x2)	# [6492] neighbors_exist x y next
	bne	x4, x0, 15	# [6493] if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0
# beq:	do_without_neighbors cur.(x) 0
	lw	x4, 4(x2)	# [6494] cur.(x)
	lw	x5, 1(x2)	# [6495] cur.(x)
	add	x31, x5, x4	# [6496] cur.(x)
	lw	x6, 0(x31)	# [6497] cur.(x)
	addi	x7, x0, 0	# [6498] 0
	addi	x5, x7, 0	# [6499] do_without_neighbors cur.(x) 0
	addi	x4, x6, 0	# [6500] do_without_neighbors cur.(x) 0
	sw	x1, 6(x2)	# [6501] do_without_neighbors cur.(x) 0
	addi	x2, x2, 7	# [6502] do_without_neighbors cur.(x) 0
	jal	x1, -635	# [6503] do_without_neighbors cur.(x) 0
	addi	x2, x2, -7	# [6504] do_without_neighbors cur.(x) 0
	lw	x1, 6(x2)	# [6505] do_without_neighbors cur.(x) 0
	addi	x0, x4, 0	# [6506] do_without_neighbors cur.(x) 0
	jal	x0, 13	# [6507] if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0
# bne:	try_exploit_neighbors x y prev cur next 0
	addi	x9, x0, 0	# [6508] 0
	lw	x4, 4(x2)	# [6509] try_exploit_neighbors x y prev cur next 0
	lw	x5, 3(x2)	# [6510] try_exploit_neighbors x y prev cur next 0
	lw	x6, 0(x2)	# [6511] try_exploit_neighbors x y prev cur next 0
	lw	x7, 1(x2)	# [6512] try_exploit_neighbors x y prev cur next 0
	lw	x8, 2(x2)	# [6513] try_exploit_neighbors x y prev cur next 0
	sw	x1, 6(x2)	# [6514] try_exploit_neighbors x y prev cur next 0
	addi	x2, x2, 7	# [6515] try_exploit_neighbors x y prev cur next 0
	jal	x1, -497	# [6516] try_exploit_neighbors x y prev cur next 0
	addi	x2, x2, -7	# [6517] try_exploit_neighbors x y prev cur next 0
	lw	x1, 6(x2)	# [6518] try_exploit_neighbors x y prev cur next 0
	addi	x0, x4, 0	# [6519] try_exploit_neighbors x y prev cur next 0
# cont:	if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0
	sw	x1, 6(x2)	# [6520] write_rgb ()
	addi	x2, x2, 7	# [6521] write_rgb ()
	jal	x1, -387	# [6522] write_rgb ()
	addi	x2, x2, -7	# [6523] write_rgb ()
	lw	x1, 6(x2)	# [6524] write_rgb ()
	addi	x0, x4, 0	# [6525] write_rgb ()
	lw	x4, 4(x2)	# [6526] x + 1
	addi	x4, x4, 1	# [6527] x + 1
	lw	x5, 3(x2)	# [6528] scan_pixel (x + 1) y prev cur next
	lw	x6, 0(x2)	# [6529] scan_pixel (x + 1) y prev cur next
	lw	x7, 1(x2)	# [6530] scan_pixel (x + 1) y prev cur next
	lw	x8, 2(x2)	# [6531] scan_pixel (x + 1) y prev cur next
	jal	x0, -75	# [6532] scan_pixel (x + 1) y prev cur next
# bge:	()
	jalr x0, x1, 0	# [6533] ()
# scan_line.3322:	let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	lui	x9, 256	# [6534] image_size
	addi	x9, x9, 142	# [6535] image_size
	lw	x9, 1(x9)	# [6536] image_size.(1)
	bge	x4, x9, 56	# [6537] if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else ()
# blt:	if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2);
	lui	x9, 256	# [6538] image_size
	addi	x9, x9, 142	# [6539] image_size
	lw	x9, 1(x9)	# [6540] image_size.(1)
	addi	x9, x9, -1	# [6541] image_size.(1) - 1
	sw	x8, 0(x2)	# [6542] if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x7, 1(x2)	# [6543] if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x6, 2(x2)	# [6544] if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x5, 3(x2)	# [6545] if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x4, 4(x2)	# [6546] if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	bge	x4, x9, 12	# [6547] if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
# blt:	pretrace_line next (y + 1) group_id
	addi	x9, x4, 1	# [6548] y + 1
	addi	x6, x8, 0	# [6549] pretrace_line next (y + 1) group_id
	addi	x5, x9, 0	# [6550] pretrace_line next (y + 1) group_id
	addi	x4, x7, 0	# [6551] pretrace_line next (y + 1) group_id
	sw	x1, 5(x2)	# [6552] pretrace_line next (y + 1) group_id
	addi	x2, x2, 6	# [6553] pretrace_line next (y + 1) group_id
	jal	x1, -139	# [6554] pretrace_line next (y + 1) group_id
	addi	x2, x2, -6	# [6555] pretrace_line next (y + 1) group_id
	lw	x1, 5(x2)	# [6556] pretrace_line next (y + 1) group_id
	addi	x0, x4, 0	# [6557] pretrace_line next (y + 1) group_id
	jal	x0, 1	# [6558] if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
# bge:	()
# cont:	if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	addi	x4, x0, 0	# [6559] 0
	lw	x5, 4(x2)	# [6560] scan_pixel 0 y prev cur next
	lw	x6, 3(x2)	# [6561] scan_pixel 0 y prev cur next
	lw	x7, 2(x2)	# [6562] scan_pixel 0 y prev cur next
	lw	x8, 1(x2)	# [6563] scan_pixel 0 y prev cur next
	sw	x1, 5(x2)	# [6564] scan_pixel 0 y prev cur next
	addi	x2, x2, 6	# [6565] scan_pixel 0 y prev cur next
	jal	x1, -109	# [6566] scan_pixel 0 y prev cur next
	addi	x2, x2, -6	# [6567] scan_pixel 0 y prev cur next
	lw	x1, 5(x2)	# [6568] scan_pixel 0 y prev cur next
	addi	x0, x4, 0	# [6569] scan_pixel 0 y prev cur next
	lw	x4, 4(x2)	# [6570] y + 1
	addi	x4, x4, 1	# [6571] y + 1
	addi	x5, x0, 2	# [6572] 2
	lw	x6, 0(x2)	# [6573] add_mod5 group_id 2
	sw	x4, 5(x2)	# [6574] add_mod5 group_id 2
	addi	x4, x6, 0	# [6575] add_mod5 group_id 2
	sw	x1, 6(x2)	# [6576] add_mod5 group_id 2
	addi	x2, x2, 7	# [6577] add_mod5 group_id 2
	jal	x1, -6557	# [6578] add_mod5 group_id 2
	addi	x2, x2, -7	# [6579] add_mod5 group_id 2
	lw	x1, 6(x2)	# [6580] add_mod5 group_id 2
	addi	x8, x4, 0	# [6581] add_mod5 group_id 2
	lw	x4, 5(x2)	# [6582] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x5, 2(x2)	# [6583] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x6, 1(x2)	# [6584] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x7, 3(x2)	# [6585] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	sw	x1, 6(x2)	# [6586] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	addi	x2, x2, 7	# [6587] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	jal	x1, -54	# [6588] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	addi	x2, x2, -7	# [6589] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x1, 6(x2)	# [6590] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	addi	x0, x4, 0	# [6591] scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	jalr x0, x1, 0	# [6592]
# bge:	()
	jalr x0, x1, 0	# [6593] ()
# create_float5x3array.3328:	let rec create_float5x3array _ = ( let vec = create_array 3 0.0 in let array = create_array 5 vec in array.(1) <- create_array 3 0.0; array.(2) <- create_array 3 0.0; array.(3) <- create_array 3 0.0; array.(4) <- create_array 3 0.0; array )
	addi	x4, x0, 3	# [6594] 3
	addi	x31, x0, 0	# [6595] 0.0
	xtof	f1, x31	# [6596] 0.0
	# let vec = create_array 3 0.0
	add	x31, x3, x4	# [6597] create_array 3 0.0
	beq	x31, x3, 4	# [6598] create_array 3 0.0
	fsw	f1, 0(x3)	# [6599] create_array 3 0.0
	addi	x3, x3, 1	# [6600] create_array 3 0.0
	jal	x0, -3	# [6601] create_array 3 0.0
	addi	x5, x0, 5	# [6602] 5
	# let array = create_array 5 vec
	add	x31, x3, x5	# [6603] create_array 5 vec
	beq	x31, x3, 4	# [6604] create_array 5 vec
	sw	x4, 0(x3)	# [6605] create_array 5 vec
	addi	x3, x3, 1	# [6606] create_array 5 vec
	jal	x0, -3	# [6607] create_array 5 vec
	addi	x5, x0, 3	# [6608] 3
	addi	x31, x0, 0	# [6609] 0.0
	xtof	f1, x31	# [6610] 0.0
	add	x31, x3, x5	# [6611] create_array 3 0.0
	beq	x31, x3, 4	# [6612] create_array 3 0.0
	fsw	f1, 0(x3)	# [6613] create_array 3 0.0
	addi	x3, x3, 1	# [6614] create_array 3 0.0
	jal	x0, -3	# [6615] create_array 3 0.0
	sw	x5, 1(x4)	# [6616] array.(1) <- create_array 3 0.0
	addi	x5, x0, 3	# [6617] 3
	addi	x31, x0, 0	# [6618] 0.0
	xtof	f1, x31	# [6619] 0.0
	add	x31, x3, x5	# [6620] create_array 3 0.0
	beq	x31, x3, 4	# [6621] create_array 3 0.0
	fsw	f1, 0(x3)	# [6622] create_array 3 0.0
	addi	x3, x3, 1	# [6623] create_array 3 0.0
	jal	x0, -3	# [6624] create_array 3 0.0
	sw	x5, 2(x4)	# [6625] array.(2) <- create_array 3 0.0
	addi	x5, x0, 3	# [6626] 3
	addi	x31, x0, 0	# [6627] 0.0
	xtof	f1, x31	# [6628] 0.0
	add	x31, x3, x5	# [6629] create_array 3 0.0
	beq	x31, x3, 4	# [6630] create_array 3 0.0
	fsw	f1, 0(x3)	# [6631] create_array 3 0.0
	addi	x3, x3, 1	# [6632] create_array 3 0.0
	jal	x0, -3	# [6633] create_array 3 0.0
	sw	x5, 3(x4)	# [6634] array.(3) <- create_array 3 0.0
	addi	x5, x0, 3	# [6635] 3
	addi	x31, x0, 0	# [6636] 0.0
	xtof	f1, x31	# [6637] 0.0
	add	x31, x3, x5	# [6638] create_array 3 0.0
	beq	x31, x3, 4	# [6639] create_array 3 0.0
	fsw	f1, 0(x3)	# [6640] create_array 3 0.0
	addi	x3, x3, 1	# [6641] create_array 3 0.0
	jal	x0, -3	# [6642] create_array 3 0.0
	sw	x5, 4(x4)	# [6643] array.(4) <- create_array 3 0.0
	jalr	x0, x1, 0	# [6644] array
# create_pixel.3330:	let rec create_pixel _ = let m_rgb = create_array 3 0.0 in let m_isect_ps = create_float5x3array() in let m_sids = create_array 5 0 in let m_cdif = create_array 5 false in let m_engy = create_float5x3array() in let m_r20p = create_float5x3array() in let m_gid = create_array 1 0 in let m_nvectors = create_float5x3array() in (m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors)
	addi	x4, x0, 3	# [6645] 3
	addi	x31, x0, 0	# [6646] 0.0
	xtof	f1, x31	# [6647] 0.0
	# let m_rgb = create_array 3 0.0
	add	x31, x3, x4	# [6648] create_array 3 0.0
	beq	x31, x3, 4	# [6649] create_array 3 0.0
	fsw	f1, 0(x3)	# [6650] create_array 3 0.0
	addi	x3, x3, 1	# [6651] create_array 3 0.0
	jal	x0, -3	# [6652] create_array 3 0.0
	sw	x4, 0(x2)	# [6653] create_float5x3array()
	# let m_isect_ps = create_float5x3array()
	sw	x1, 1(x2)	# [6654] create_float5x3array()
	addi	x2, x2, 2	# [6655] create_float5x3array()
	jal	x1, -62	# [6656] create_float5x3array()
	addi	x2, x2, -2	# [6657] create_float5x3array()
	lw	x1, 1(x2)	# [6658] create_float5x3array()
	addi	x5, x0, 5	# [6659] 5
	addi	x6, x0, 0	# [6660] 0
	# let m_sids = create_array 5 0
	add	x31, x3, x5	# [6661] create_array 5 0
	beq	x31, x3, 4	# [6662] create_array 5 0
	sw	x6, 0(x3)	# [6663] create_array 5 0
	addi	x3, x3, 1	# [6664] create_array 5 0
	jal	x0, -3	# [6665] create_array 5 0
	addi	x6, x0, 5	# [6666] 5
	addi	x7, x0, 0	# [6667] false
	# let m_cdif = create_array 5 false
	add	x31, x3, x6	# [6668] create_array 5 false
	beq	x31, x3, 4	# [6669] create_array 5 false
	sw	x7, 0(x3)	# [6670] create_array 5 false
	addi	x3, x3, 1	# [6671] create_array 5 false
	jal	x0, -3	# [6672] create_array 5 false
	sw	x4, 1(x2)	# [6673] create_float5x3array()
	sw	x5, 2(x2)	# [6674] create_float5x3array()
	sw	x6, 3(x2)	# [6675] create_float5x3array()
	# let m_engy = create_float5x3array()
	sw	x1, 4(x2)	# [6676] create_float5x3array()
	addi	x2, x2, 5	# [6677] create_float5x3array()
	jal	x1, -84	# [6678] create_float5x3array()
	addi	x2, x2, -5	# [6679] create_float5x3array()
	lw	x1, 4(x2)	# [6680] create_float5x3array()
	sw	x4, 4(x2)	# [6681] create_float5x3array()
	# let m_r20p = create_float5x3array()
	sw	x1, 5(x2)	# [6682] create_float5x3array()
	addi	x2, x2, 6	# [6683] create_float5x3array()
	jal	x1, -90	# [6684] create_float5x3array()
	addi	x2, x2, -6	# [6685] create_float5x3array()
	lw	x1, 5(x2)	# [6686] create_float5x3array()
	addi	x5, x0, 1	# [6687] 1
	addi	x6, x0, 0	# [6688] 0
	# let m_gid = create_array 1 0
	add	x31, x3, x5	# [6689] create_array 1 0
	beq	x31, x3, 4	# [6690] create_array 1 0
	sw	x6, 0(x3)	# [6691] create_array 1 0
	addi	x3, x3, 1	# [6692] create_array 1 0
	jal	x0, -3	# [6693] create_array 1 0
	sw	x4, 5(x2)	# [6694] create_float5x3array()
	sw	x5, 6(x2)	# [6695] create_float5x3array()
	# let m_nvectors = create_float5x3array()
	sw	x1, 7(x2)	# [6696] create_float5x3array()
	addi	x2, x2, 8	# [6697] create_float5x3array()
	jal	x1, -104	# [6698] create_float5x3array()
	addi	x2, x2, -8	# [6699] create_float5x3array()
	lw	x1, 7(x2)	# [6700] create_float5x3array()
	addi	x31, x3, 0	# [6701] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	addi	x3, x3, 8	# [6702] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 7(x31)	# [6703] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 6(x2)	# [6704] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 6(x31)	# [6705] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 5(x2)	# [6706] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 5(x31)	# [6707] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 4(x2)	# [6708] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 4(x31)	# [6709] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 3(x2)	# [6710] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 3(x31)	# [6711] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 2(x2)	# [6712] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 2(x31)	# [6713] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 1(x2)	# [6714] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 1(x31)	# [6715] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 0(x2)	# [6716] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 0(x31)	# [6717] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	addi	x4, x31, 0	# [6718] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	jalr	x0, x1, 0	# [6719] m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
# init_line_elements.3332:	let rec init_line_elements line n = if n >= 0 then ( line.(n) <- create_pixel(); init_line_elements line (n-1) ) else line
	bge	x5, x0, 2	# [6720] if n >= 0 then ( line.(n) <- create_pixel(); init_line_elements line (n-1) ) else line
# blt:	line
	jalr	x0, x1, 0	# [6721] line
# bge:	line.(n) <- create_pixel(); init_line_elements line (n-1)
	sw	x5, 0(x2)	# [6722] create_pixel()
	sw	x4, 1(x2)	# [6723] create_pixel()
	sw	x1, 2(x2)	# [6724] create_pixel()
	addi	x2, x2, 3	# [6725] create_pixel()
	jal	x1, -81	# [6726] create_pixel()
	addi	x2, x2, -3	# [6727] create_pixel()
	lw	x1, 2(x2)	# [6728] create_pixel()
	lw	x5, 0(x2)	# [6729] line.(n) <- create_pixel()
	lw	x6, 1(x2)	# [6730] line.(n) <- create_pixel()
	add	x31, x6, x5	# [6731] line.(n) <- create_pixel()
	sw	x4, 0(x31)	# [6732] line.(n) <- create_pixel()
	addi	x5, x5, -1	# [6733] n-1
	addi	x4, x6, 0	# [6734] init_line_elements line (n-1)
	jal	x0, -15	# [6735] init_line_elements line (n-1)
# create_pixelline.3335:	let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	lui	x4, 256	# [6736] image_size
	addi	x4, x4, 142	# [6737] image_size
	lw	x4, 0(x4)	# [6738] image_size.(0)
	sw	x4, 0(x2)	# [6739] create_pixel()
	sw	x1, 1(x2)	# [6740] create_pixel()
	addi	x2, x2, 2	# [6741] create_pixel()
	jal	x1, -97	# [6742] create_pixel()
	addi	x2, x2, -2	# [6743] create_pixel()
	lw	x1, 1(x2)	# [6744] create_pixel()
	lw	x5, 0(x2)	# [6745] create_array image_size.(0) (create_pixel())
	# let line = create_array image_size.(0) (create_pixel())
	add	x31, x3, x5	# [6746] create_array image_size.(0) (create_pixel())
	beq	x31, x3, 4	# [6747] create_array image_size.(0) (create_pixel())
	sw	x4, 0(x3)	# [6748] create_array image_size.(0) (create_pixel())
	addi	x3, x3, 1	# [6749] create_array image_size.(0) (create_pixel())
	jal	x0, -3	# [6750] create_array image_size.(0) (create_pixel())
	lui	x5, 256	# [6751] image_size
	addi	x5, x5, 142	# [6752] image_size
	lw	x5, 0(x5)	# [6753] image_size.(0)
	addi	x5, x5, -2	# [6754] image_size.(0)-2
	jal	x0, -35	# [6755] init_line_elements line (image_size.(0)-2)
# adjust_position.3337:	let rec adjust_position h ratio = let l = sqrt(h*.h +. 0.1) in let tan_h = 1.0 /. l in let theta_h = atan tan_h in let tan_m = tan (theta_h *. ratio) in tan_m *. l
	fmul	f1, f1, f1	# [6756] h*.h
	fadd	f1, f1, f21	# [6757] h*.h +. 0.1
	# let l = sqrt(h*.h +. 0.1)
	fsqrt	f1, f1	# [6758] sqrt(h*.h +. 0.1)
	# let tan_h = 1.0 /. l
	fdiv	f3, f11, f1	# [6759] 1.0 /. l
	fsub	f3, f3, f12	# [6760]
	fmul	f3, f3, f22	# [6761]
	fmul	f4, f3, f3	# [6762]
	fmul	f4, f4, f12	# [6763]
	fmul	f5, f4, f3	# [6764]
	lui	x31, 261802	# [6765]
	addi	x31, x31, -1365	# [6766]
	xtof	f6, x31	# [6767]
	fmul	f5, f5, f6	# [6768]
	fmul	f6, f5, f3	# [6769]
	lui	x31, 261399	# [6770]
	addi	x31, x31, 1117	# [6771]
	xtof	f7, x31	# [6772]
	fmul	f6, f6, f7	# [6773]
	fmul	f7, f6, f3	# [6774]
	lui	x31, 260846	# [6775]
	addi	x31, x31, -273	# [6776]
	xtof	f8, x31	# [6777]
	fmul	f7, f7, f8	# [6778]
	lui	x31, 260315	# [6779]
	addi	x31, x31, 1805	# [6780]
	xtof	f8, x31	# [6781]
	fadd	f3, f8, f3	# [6782]
	fsub	f3, f3, f4	# [6783]
	fadd	f3, f3, f5	# [6784]
	fsub	f3, f3, f6	# [6785]
	# let theta_h = atan tan_h
	fadd	f3, f3, f7	# [6786]
	fmul	f2, f3, f2	# [6787] theta_h *. ratio
	fmul	f3, f2, f2	# [6788]
	fmul	f4, f2, f3	# [6789]
	lui	x31, 256682	# [6790]
	addi	x31, x31, -1365	# [6791]
	xtof	f5, x31	# [6792]
	fmul	f4, f4, f5	# [6793]
	fmul	f5, f4, f3	# [6794]
	lui	x31, 257228	# [6795]
	addi	x31, x31, -819	# [6796]
	xtof	f6, x31	# [6797]
	fmul	f5, f5, f6	# [6798]
	fmul	f6, f5, f3	# [6799]
	lui	x31, 257267	# [6800]
	addi	x31, x31, -780	# [6801]
	xtof	f7, x31	# [6802]
	fmul	f6, f6, f7	# [6803]
	fmul	f3, f6, f3	# [6804]
	lui	x31, 257271	# [6805]
	addi	x31, x31, -1499	# [6806]
	xtof	f7, x31	# [6807]
	fmul	f3, f3, f7	# [6808]
	fadd	f2, f2, f4	# [6809]
	fadd	f2, f2, f5	# [6810]
	fadd	f2, f2, f6	# [6811]
	# let tan_m = tan (theta_h *. ratio)
	fadd	f2, f2, f3	# [6812]
	fmul	f1, f2, f1	# [6813] tan_m *. l
	jalr	x0, x1, 0	# [6814] tan_m *. l
# calc_dirvec.3340:	let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	addi	x7, x0, 5	# [6815] 5
	bge	x4, x7, 31	# [6816] if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
# blt:	let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	fsw	f3, 0(x2)	# [6817] adjust_position y rx
	sw	x6, 1(x2)	# [6818] adjust_position y rx
	sw	x5, 2(x2)	# [6819] adjust_position y rx
	fsw	f4, 3(x2)	# [6820] adjust_position y rx
	sw	x4, 4(x2)	# [6821] adjust_position y rx
	# let x2 = adjust_position y rx
	fmv	f1, f2	# [6822] adjust_position y rx
	fmv	f2, f3	# [6823] adjust_position y rx
	sw	x1, 5(x2)	# [6824] adjust_position y rx
	addi	x2, x2, 6	# [6825] adjust_position y rx
	jal	x1, -70	# [6826] adjust_position y rx
	addi	x2, x2, -6	# [6827] adjust_position y rx
	lw	x1, 5(x2)	# [6828] adjust_position y rx
	lw	x4, 4(x2)	# [6829] icount + 1
	addi	x4, x4, 1	# [6830] icount + 1
	flw	f2, 3(x2)	# [6831] adjust_position x2 ry
	fsw	f1, 5(x2)	# [6832] adjust_position x2 ry
	sw	x4, 6(x2)	# [6833] adjust_position x2 ry
	sw	x1, 7(x2)	# [6834] adjust_position x2 ry
	addi	x2, x2, 8	# [6835] adjust_position x2 ry
	jal	x1, -80	# [6836] adjust_position x2 ry
	addi	x2, x2, -8	# [6837] adjust_position x2 ry
	lw	x1, 7(x2)	# [6838] adjust_position x2 ry
	fmr	f2, f1	# [6839] adjust_position x2 ry
	flw	f1, 5(x2)	# [6840] calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	flw	f3, 0(x2)	# [6841] calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	flw	f4, 3(x2)	# [6842] calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x4, 6(x2)	# [6843] calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x5, 2(x2)	# [6844] calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x6, 1(x2)	# [6845] calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	jal	x0, -31	# [6846] calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
# bge:	let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
	fmul	f3, f1, f1	# [6847] fsqr x
	fmul	f4, f2, f2	# [6848] fsqr y
	fadd	f3, f3, f4	# [6849] fsqr x +. fsqr y
	fadd	f3, f3, f11	# [6850] fsqr x +. fsqr y +. 1.0
	# let l = sqrt(fsqr x +. fsqr y +. 1.0)
	fsqrt	f3, f3	# [6851] sqrt(fsqr x +. fsqr y +. 1.0)
	# let vx = x /. l
	fdiv	f1, f1, f3	# [6852] x /. l
	# let vy = y /. l
	fdiv	f2, f2, f3	# [6853] y /. l
	# let vz = 1.0 /. l
	fdiv	f3, f11, f3	# [6854] 1.0 /. l
	lui	x4, 256	# [6855] dirvecs
	addi	x4, x4, 168	# [6856] dirvecs
	# let dgroup = dirvecs.(group_id)
	add	x31, x4, x5	# [6857] dirvecs.(group_id)
	lw	x4, 0(x31)	# [6858] dirvecs.(group_id)
	add	x31, x4, x6	# [6859] dgroup.(index)
	lw	x5, 0(x31)	# [6860] dgroup.(index)
	sw	x4, 7(x2)	# [6861] d_vec dgroup.(index)
	sw	x6, 1(x2)	# [6862] d_vec dgroup.(index)
	fsw	f3, 8(x2)	# [6863] d_vec dgroup.(index)
	fsw	f2, 9(x2)	# [6864] d_vec dgroup.(index)
	fsw	f1, 10(x2)	# [6865] d_vec dgroup.(index)
	addi	x4, x5, 0	# [6866] d_vec dgroup.(index)
	sw	x1, 11(x2)	# [6867] d_vec dgroup.(index)
	addi	x2, x2, 12	# [6868] d_vec dgroup.(index)
	jal	x1, -6637	# [6869] d_vec dgroup.(index)
	addi	x2, x2, -12	# [6870] d_vec dgroup.(index)
	lw	x1, 11(x2)	# [6871] d_vec dgroup.(index)
	flw	f1, 10(x2)	# [6872] vecset (d_vec dgroup.(index)) vx vy vz
	flw	f2, 9(x2)	# [6873] vecset (d_vec dgroup.(index)) vx vy vz
	flw	f3, 8(x2)	# [6874] vecset (d_vec dgroup.(index)) vx vy vz
	sw	x1, 11(x2)	# [6875] vecset (d_vec dgroup.(index)) vx vy vz
	addi	x2, x2, 12	# [6876] vecset (d_vec dgroup.(index)) vx vy vz
	jal	x1, -6850	# [6877] vecset (d_vec dgroup.(index)) vx vy vz
	addi	x2, x2, -12	# [6878] vecset (d_vec dgroup.(index)) vx vy vz
	lw	x1, 11(x2)	# [6879] vecset (d_vec dgroup.(index)) vx vy vz
	addi	x0, x4, 0	# [6880] vecset (d_vec dgroup.(index)) vx vy vz
	lw	x4, 1(x2)	# [6881] index+40
	addi	x5, x4, 40	# [6882] index+40
	lw	x6, 7(x2)	# [6883] dgroup.(index+40)
	add	x31, x6, x5	# [6884] dgroup.(index+40)
	lw	x5, 0(x31)	# [6885] dgroup.(index+40)
	addi	x4, x5, 0	# [6886] d_vec dgroup.(index+40)
	sw	x1, 11(x2)	# [6887] d_vec dgroup.(index+40)
	addi	x2, x2, 12	# [6888] d_vec dgroup.(index+40)
	jal	x1, -6657	# [6889] d_vec dgroup.(index+40)
	addi	x2, x2, -12	# [6890] d_vec dgroup.(index+40)
	lw	x1, 11(x2)	# [6891] d_vec dgroup.(index+40)
	flw	f1, 9(x2)	# [6892] fneg vy
	fneg	f3, f1	# [6893] fneg vy
	flw	f2, 10(x2)	# [6894] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	flw	f4, 8(x2)	# [6895] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	fmv	f1, f2	# [6896] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	fmv	f2, f4	# [6897] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	sw	x1, 11(x2)	# [6898] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	addi	x2, x2, 12	# [6899] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	jal	x1, -6873	# [6900] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	addi	x2, x2, -12	# [6901] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	lw	x1, 11(x2)	# [6902] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	addi	x0, x4, 0	# [6903] vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	lw	x4, 1(x2)	# [6904] index+80
	addi	x5, x4, 80	# [6905] index+80
	lw	x6, 7(x2)	# [6906] dgroup.(index+80)
	add	x31, x6, x5	# [6907] dgroup.(index+80)
	lw	x5, 0(x31)	# [6908] dgroup.(index+80)
	addi	x4, x5, 0	# [6909] d_vec dgroup.(index+80)
	sw	x1, 11(x2)	# [6910] d_vec dgroup.(index+80)
	addi	x2, x2, 12	# [6911] d_vec dgroup.(index+80)
	jal	x1, -6680	# [6912] d_vec dgroup.(index+80)
	addi	x2, x2, -12	# [6913] d_vec dgroup.(index+80)
	lw	x1, 11(x2)	# [6914] d_vec dgroup.(index+80)
	flw	f1, 10(x2)	# [6915] fneg vx
	fneg	f2, f1	# [6916] fneg vx
	flw	f3, 9(x2)	# [6917] fneg vy
	fneg	f4, f3	# [6918] fneg vy
	flw	f5, 8(x2)	# [6919] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	fmv	f3, f4	# [6920] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	fmv	f1, f5	# [6921] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	sw	x1, 11(x2)	# [6922] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	addi	x2, x2, 12	# [6923] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	jal	x1, -6897	# [6924] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	addi	x2, x2, -12	# [6925] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	lw	x1, 11(x2)	# [6926] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	addi	x0, x4, 0	# [6927] vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	lw	x4, 1(x2)	# [6928] index+1
	addi	x5, x4, 1	# [6929] index+1
	lw	x6, 7(x2)	# [6930] dgroup.(index+1)
	add	x31, x6, x5	# [6931] dgroup.(index+1)
	lw	x5, 0(x31)	# [6932] dgroup.(index+1)
	addi	x4, x5, 0	# [6933] d_vec dgroup.(index+1)
	sw	x1, 11(x2)	# [6934] d_vec dgroup.(index+1)
	addi	x2, x2, 12	# [6935] d_vec dgroup.(index+1)
	jal	x1, -6704	# [6936] d_vec dgroup.(index+1)
	addi	x2, x2, -12	# [6937] d_vec dgroup.(index+1)
	lw	x1, 11(x2)	# [6938] d_vec dgroup.(index+1)
	flw	f1, 10(x2)	# [6939] fneg vx
	fneg	f2, f1	# [6940] fneg vx
	flw	f3, 9(x2)	# [6941] fneg vy
	fneg	f4, f3	# [6942] fneg vy
	flw	f5, 8(x2)	# [6943] fneg vz
	fneg	f6, f5	# [6944] fneg vz
	fmv	f3, f6	# [6945] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	fmv	f1, f2	# [6946] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	fmv	f2, f4	# [6947] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	sw	x1, 11(x2)	# [6948] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	addi	x2, x2, 12	# [6949] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	jal	x1, -6923	# [6950] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	addi	x2, x2, -12	# [6951] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	lw	x1, 11(x2)	# [6952] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	addi	x0, x4, 0	# [6953] vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	lw	x4, 1(x2)	# [6954] index+41
	addi	x5, x4, 41	# [6955] index+41
	lw	x6, 7(x2)	# [6956] dgroup.(index+41)
	add	x31, x6, x5	# [6957] dgroup.(index+41)
	lw	x5, 0(x31)	# [6958] dgroup.(index+41)
	addi	x4, x5, 0	# [6959] d_vec dgroup.(index+41)
	sw	x1, 11(x2)	# [6960] d_vec dgroup.(index+41)
	addi	x2, x2, 12	# [6961] d_vec dgroup.(index+41)
	jal	x1, -6730	# [6962] d_vec dgroup.(index+41)
	addi	x2, x2, -12	# [6963] d_vec dgroup.(index+41)
	lw	x1, 11(x2)	# [6964] d_vec dgroup.(index+41)
	flw	f1, 10(x2)	# [6965] fneg vx
	fneg	f2, f1	# [6966] fneg vx
	flw	f3, 8(x2)	# [6967] fneg vz
	fneg	f4, f3	# [6968] fneg vz
	flw	f5, 9(x2)	# [6969] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	fmv	f3, f5	# [6970] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	fmv	f1, f2	# [6971] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	fmv	f2, f4	# [6972] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	sw	x1, 11(x2)	# [6973] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	addi	x2, x2, 12	# [6974] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	jal	x1, -6948	# [6975] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	addi	x2, x2, -12	# [6976] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	lw	x1, 11(x2)	# [6977] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	addi	x0, x4, 0	# [6978] vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	lw	x4, 1(x2)	# [6979] index+81
	addi	x4, x4, 81	# [6980] index+81
	lw	x5, 7(x2)	# [6981] dgroup.(index+81)
	add	x31, x5, x4	# [6982] dgroup.(index+81)
	lw	x4, 0(x31)	# [6983] dgroup.(index+81)
	sw	x1, 11(x2)	# [6984] d_vec dgroup.(index+81)
	addi	x2, x2, 12	# [6985] d_vec dgroup.(index+81)
	jal	x1, -6754	# [6986] d_vec dgroup.(index+81)
	addi	x2, x2, -12	# [6987] d_vec dgroup.(index+81)
	lw	x1, 11(x2)	# [6988] d_vec dgroup.(index+81)
	flw	f1, 8(x2)	# [6989] fneg vz
	fneg	f1, f1	# [6990] fneg vz
	flw	f2, 10(x2)	# [6991] vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
	flw	f3, 9(x2)	# [6992] vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
	jal	x0, -6966	# [6993] vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
# calc_dirvecs.3348:	let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	bge	x4, x0, 2	# [6994] if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
# blt:	()
	jalr x0, x1, 0	# [6995] ()
# bge:	let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	itof	f2, x4	# [6996] float_of_int col
	fmul	f2, f2, f22	# [6997] (float_of_int col) *. 0.2
	lui	x31, 259686	# [6998] 0.9
	addi	x31, x31, 1638	# [6999] 0.9
	xtof	f3, x31	# [7000] 0.9
	# let rx = (float_of_int col) *. 0.2 -. 0.9
	fsub	f3, f2, f3	# [7001] (float_of_int col) *. 0.2 -. 0.9
	addi	x7, x0, 0	# [7002] 0
	addi	x31, x0, 0	# [7003] 0.0
	xtof	f2, x31	# [7004] 0.0
	addi	x31, x0, 0	# [7005] 0.0
	xtof	f4, x31	# [7006] 0.0
	fsw	f1, 0(x2)	# [7007] calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x5, 1(x2)	# [7008] calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x6, 2(x2)	# [7009] calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x4, 3(x2)	# [7010] calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x4, x7, 0	# [7011] calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f31, f4	# [7012] calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f4, f1	# [7013] calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f1, f2	# [7014] calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f2, f31	# [7015] calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x1, 4(x2)	# [7016] calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x2, x2, 5	# [7017] calc_dirvec 0 0.0 0.0 rx ry group_id index
	jal	x1, -203	# [7018] calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x2, x2, -5	# [7019] calc_dirvec 0 0.0 0.0 rx ry group_id index
	lw	x1, 4(x2)	# [7020] calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x0, x4, 0	# [7021] calc_dirvec 0 0.0 0.0 rx ry group_id index
	lw	x4, 3(x2)	# [7022] float_of_int col
	itof	f1, x4	# [7023] float_of_int col
	fmul	f1, f1, f22	# [7024] (float_of_int col) *. 0.2
	# let rx2 = (float_of_int col) *. 0.2 +. 0.1
	fadd	f3, f1, f21	# [7025] (float_of_int col) *. 0.2 +. 0.1
	addi	x5, x0, 0	# [7026] 0
	addi	x31, x0, 0	# [7027] 0.0
	xtof	f1, x31	# [7028] 0.0
	addi	x31, x0, 0	# [7029] 0.0
	xtof	f2, x31	# [7030] 0.0
	lw	x6, 2(x2)	# [7031] index + 2
	addi	x7, x6, 2	# [7032] index + 2
	flw	f4, 0(x2)	# [7033] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x8, 1(x2)	# [7034] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x6, x7, 0	# [7035] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x4, x5, 0	# [7036] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x5, x8, 0	# [7037] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	sw	x1, 4(x2)	# [7038] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x2, x2, 5	# [7039] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	jal	x1, -225	# [7040] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x2, x2, -5	# [7041] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x1, 4(x2)	# [7042] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x0, x4, 0	# [7043] calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x4, 3(x2)	# [7044] col - 1
	addi	x4, x4, -1	# [7045] col - 1
	addi	x5, x0, 1	# [7046] 1
	lw	x6, 1(x2)	# [7047] add_mod5 group_id 1
	sw	x4, 4(x2)	# [7048] add_mod5 group_id 1
	addi	x4, x6, 0	# [7049] add_mod5 group_id 1
	sw	x1, 5(x2)	# [7050] add_mod5 group_id 1
	addi	x2, x2, 6	# [7051] add_mod5 group_id 1
	jal	x1, -7031	# [7052] add_mod5 group_id 1
	addi	x2, x2, -6	# [7053] add_mod5 group_id 1
	lw	x1, 5(x2)	# [7054] add_mod5 group_id 1
	addi	x5, x4, 0	# [7055] add_mod5 group_id 1
	flw	f1, 0(x2)	# [7056] calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	lw	x4, 4(x2)	# [7057] calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	lw	x6, 2(x2)	# [7058] calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	jal	x0, -65	# [7059] calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
# calc_dirvec_rows.3353:	let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	bge	x4, x0, 2	# [7060] if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
# blt:	()
	jalr x0, x1, 0	# [7061] ()
# bge:	let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
	itof	f1, x4	# [7062] float_of_int row
	fmul	f1, f1, f22	# [7063] (float_of_int row) *. 0.2
	lui	x31, 259686	# [7064] 0.9
	addi	x31, x31, 1638	# [7065] 0.9
	xtof	f2, x31	# [7066] 0.9
	# let ry = (float_of_int row) *. 0.2 -. 0.9
	fsub	f1, f1, f2	# [7067] (float_of_int row) *. 0.2 -. 0.9
	addi	x7, x0, 4	# [7068] 4
	sw	x6, 0(x2)	# [7069] calc_dirvecs 4 ry group_id index
	sw	x5, 1(x2)	# [7070] calc_dirvecs 4 ry group_id index
	sw	x4, 2(x2)	# [7071] calc_dirvecs 4 ry group_id index
	addi	x4, x7, 0	# [7072] calc_dirvecs 4 ry group_id index
	sw	x1, 3(x2)	# [7073] calc_dirvecs 4 ry group_id index
	addi	x2, x2, 4	# [7074] calc_dirvecs 4 ry group_id index
	jal	x1, -81	# [7075] calc_dirvecs 4 ry group_id index
	addi	x2, x2, -4	# [7076] calc_dirvecs 4 ry group_id index
	lw	x1, 3(x2)	# [7077] calc_dirvecs 4 ry group_id index
	addi	x0, x4, 0	# [7078] calc_dirvecs 4 ry group_id index
	lw	x4, 2(x2)	# [7079] row - 1
	addi	x4, x4, -1	# [7080] row - 1
	addi	x5, x0, 2	# [7081] 2
	lw	x6, 1(x2)	# [7082] add_mod5 group_id 2
	sw	x4, 3(x2)	# [7083] add_mod5 group_id 2
	addi	x4, x6, 0	# [7084] add_mod5 group_id 2
	sw	x1, 4(x2)	# [7085] add_mod5 group_id 2
	addi	x2, x2, 5	# [7086] add_mod5 group_id 2
	jal	x1, -7066	# [7087] add_mod5 group_id 2
	addi	x2, x2, -5	# [7088] add_mod5 group_id 2
	lw	x1, 4(x2)	# [7089] add_mod5 group_id 2
	addi	x5, x4, 0	# [7090] add_mod5 group_id 2
	lw	x4, 0(x2)	# [7091] index + 4
	addi	x6, x4, 4	# [7092] index + 4
	lw	x4, 3(x2)	# [7093] calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
	jal	x0, -34	# [7094] calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
# create_dirvec.3357:	let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	addi	x4, x0, 3	# [7095] 3
	addi	x31, x0, 0	# [7096] 0.0
	xtof	f1, x31	# [7097] 0.0
	# let v3 = create_array 3 0.0
	add	x31, x3, x4	# [7098] create_array 3 0.0
	beq	x31, x3, 4	# [7099] create_array 3 0.0
	fsw	f1, 0(x3)	# [7100] create_array 3 0.0
	addi	x3, x3, 1	# [7101] create_array 3 0.0
	jal	x0, -3	# [7102] create_array 3 0.0
	lui	x5, 256	# [7103] n_objects
	addi	x5, x5, 0	# [7104] n_objects
	lw	x5, 0(x5)	# [7105] n_objects.(0)
	# let consts = create_array n_objects.(0) v3
	add	x31, x3, x5	# [7106] create_array n_objects.(0) v3
	beq	x31, x3, 4	# [7107] create_array n_objects.(0) v3
	sw	x4, 0(x3)	# [7108] create_array n_objects.(0) v3
	addi	x3, x3, 1	# [7109] create_array n_objects.(0) v3
	jal	x0, -3	# [7110] create_array n_objects.(0) v3
	addi	x31, x3, 0	# [7111] v3, consts
	addi	x3, x3, 2	# [7112] v3, consts
	sw	x5, 1(x31)	# [7113] v3, consts
	sw	x4, 0(x31)	# [7114] v3, consts
	addi	x4, x31, 0	# [7115] v3, consts
	jalr	x0, x1, 0	# [7116] v3, consts
# create_dirvec_elements.3359:	let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	bge	x5, x0, 2	# [7117] if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [7118] ()
# bge:	d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1)
	sw	x5, 0(x2)	# [7119] create_dirvec()
	sw	x4, 1(x2)	# [7120] create_dirvec()
	sw	x1, 2(x2)	# [7121] create_dirvec()
	addi	x2, x2, 3	# [7122] create_dirvec()
	jal	x1, -28	# [7123] create_dirvec()
	addi	x2, x2, -3	# [7124] create_dirvec()
	lw	x1, 2(x2)	# [7125] create_dirvec()
	lw	x5, 0(x2)	# [7126] d.(index) <- create_dirvec()
	lw	x6, 1(x2)	# [7127] d.(index) <- create_dirvec()
	add	x31, x6, x5	# [7128] d.(index) <- create_dirvec()
	sw	x4, 0(x31)	# [7129] d.(index) <- create_dirvec()
	addi	x5, x5, -1	# [7130] index - 1
	addi	x4, x6, 0	# [7131] create_dirvec_elements d (index - 1)
	jal	x0, -15	# [7132] create_dirvec_elements d (index - 1)
# create_dirvecs.3362:	let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	bge	x4, x0, 2	# [7133] if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [7134] ()
# bge:	dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1)
	lui	x5, 256	# [7135] dirvecs
	addi	x5, x5, 168	# [7136] dirvecs
	addi	x6, x0, 120	# [7137] 120
	sw	x4, 0(x2)	# [7138] create_dirvec()
	sw	x5, 1(x2)	# [7139] create_dirvec()
	sw	x6, 2(x2)	# [7140] create_dirvec()
	sw	x1, 3(x2)	# [7141] create_dirvec()
	addi	x2, x2, 4	# [7142] create_dirvec()
	jal	x1, -48	# [7143] create_dirvec()
	addi	x2, x2, -4	# [7144] create_dirvec()
	lw	x1, 3(x2)	# [7145] create_dirvec()
	lw	x5, 2(x2)	# [7146] create_array 120 (create_dirvec())
	add	x31, x3, x5	# [7147] create_array 120 (create_dirvec())
	beq	x31, x3, 4	# [7148] create_array 120 (create_dirvec())
	sw	x4, 0(x3)	# [7149] create_array 120 (create_dirvec())
	addi	x3, x3, 1	# [7150] create_array 120 (create_dirvec())
	jal	x0, -3	# [7151] create_array 120 (create_dirvec())
	lw	x5, 0(x2)	# [7152] dirvecs.(index) <- create_array 120 (create_dirvec())
	lw	x6, 1(x2)	# [7153] dirvecs.(index) <- create_array 120 (create_dirvec())
	add	x31, x6, x5	# [7154] dirvecs.(index) <- create_array 120 (create_dirvec())
	sw	x4, 0(x31)	# [7155] dirvecs.(index) <- create_array 120 (create_dirvec())
	lui	x4, 256	# [7156] dirvecs
	addi	x4, x4, 168	# [7157] dirvecs
	add	x31, x4, x5	# [7158] dirvecs.(index)
	lw	x4, 0(x31)	# [7159] dirvecs.(index)
	addi	x6, x0, 118	# [7160] 118
	addi	x5, x6, 0	# [7161] create_dirvec_elements dirvecs.(index) 118
	sw	x1, 3(x2)	# [7162] create_dirvec_elements dirvecs.(index) 118
	addi	x2, x2, 4	# [7163] create_dirvec_elements dirvecs.(index) 118
	jal	x1, -47	# [7164] create_dirvec_elements dirvecs.(index) 118
	addi	x2, x2, -4	# [7165] create_dirvec_elements dirvecs.(index) 118
	lw	x1, 3(x2)	# [7166] create_dirvec_elements dirvecs.(index) 118
	addi	x0, x4, 0	# [7167] create_dirvec_elements dirvecs.(index) 118
	lw	x4, 0(x2)	# [7168] index-1
	addi	x4, x4, -1	# [7169] index-1
	jal	x0, -37	# [7170] create_dirvecs (index-1)
# init_dirvec_constants.3364:	let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	bge	x5, x0, 2	# [7171] if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [7172] ()
# bge:	setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1)
	add	x31, x4, x5	# [7173] vecset.(index)
	lw	x6, 0(x31)	# [7174] vecset.(index)
	sw	x4, 0(x2)	# [7175] setup_dirvec_constants vecset.(index)
	sw	x5, 1(x2)	# [7176] setup_dirvec_constants vecset.(index)
	addi	x4, x6, 0	# [7177] setup_dirvec_constants vecset.(index)
	sw	x1, 2(x2)	# [7178] setup_dirvec_constants vecset.(index)
	addi	x2, x2, 3	# [7179] setup_dirvec_constants vecset.(index)
	jal	x1, -4025	# [7180] setup_dirvec_constants vecset.(index)
	addi	x2, x2, -3	# [7181] setup_dirvec_constants vecset.(index)
	lw	x1, 2(x2)	# [7182] setup_dirvec_constants vecset.(index)
	addi	x0, x4, 0	# [7183] setup_dirvec_constants vecset.(index)
	lw	x4, 1(x2)	# [7184] index - 1
	addi	x5, x4, -1	# [7185] index - 1
	lw	x4, 0(x2)	# [7186] init_dirvec_constants vecset (index - 1)
	jal	x0, -16	# [7187] init_dirvec_constants vecset (index - 1)
# init_vecset_constants.3367:	let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	bge	x4, x0, 2	# [7188] if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# [7189] ()
# bge:	init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1)
	lui	x5, 256	# [7190] dirvecs
	addi	x5, x5, 168	# [7191] dirvecs
	add	x31, x5, x4	# [7192] dirvecs.(index)
	lw	x5, 0(x31)	# [7193] dirvecs.(index)
	addi	x6, x0, 119	# [7194] 119
	sw	x4, 0(x2)	# [7195] init_dirvec_constants dirvecs.(index) 119
	addi	x4, x5, 0	# [7196] init_dirvec_constants dirvecs.(index) 119
	addi	x5, x6, 0	# [7197] init_dirvec_constants dirvecs.(index) 119
	sw	x1, 1(x2)	# [7198] init_dirvec_constants dirvecs.(index) 119
	addi	x2, x2, 2	# [7199] init_dirvec_constants dirvecs.(index) 119
	jal	x1, -29	# [7200] init_dirvec_constants dirvecs.(index) 119
	addi	x2, x2, -2	# [7201] init_dirvec_constants dirvecs.(index) 119
	lw	x1, 1(x2)	# [7202] init_dirvec_constants dirvecs.(index) 119
	addi	x0, x4, 0	# [7203] init_dirvec_constants dirvecs.(index) 119
	lw	x4, 0(x2)	# [7204] index - 1
	addi	x4, x4, -1	# [7205] index - 1
	jal	x0, -18	# [7206] init_vecset_constants (index - 1)
# init_dirvecs.3369:	let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	addi	x4, x0, 4	# [7207] 4
	sw	x1, 0(x2)	# [7208] create_dirvecs 4
	addi	x2, x2, 1	# [7209] create_dirvecs 4
	jal	x1, -77	# [7210] create_dirvecs 4
	addi	x2, x2, -1	# [7211] create_dirvecs 4
	lw	x1, 0(x2)	# [7212] create_dirvecs 4
	addi	x0, x4, 0	# [7213] create_dirvecs 4
	addi	x4, x0, 9	# [7214] 9
	addi	x5, x0, 0	# [7215] 0
	addi	x6, x0, 0	# [7216] 0
	sw	x1, 0(x2)	# [7217] calc_dirvec_rows 9 0 0
	addi	x2, x2, 1	# [7218] calc_dirvec_rows 9 0 0
	jal	x1, -159	# [7219] calc_dirvec_rows 9 0 0
	addi	x2, x2, -1	# [7220] calc_dirvec_rows 9 0 0
	lw	x1, 0(x2)	# [7221] calc_dirvec_rows 9 0 0
	addi	x0, x4, 0	# [7222] calc_dirvec_rows 9 0 0
	addi	x4, x0, 4	# [7223] 4
	jal	x0, -36	# [7224] init_vecset_constants 4
# add_reflection.3371:	let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	sw	x4, 0(x2)	# [7225] create_dirvec()
	sw	x5, 1(x2)	# [7226] create_dirvec()
	fsw	f1, 2(x2)	# [7227] create_dirvec()
	fsw	f4, 3(x2)	# [7228] create_dirvec()
	fsw	f3, 4(x2)	# [7229] create_dirvec()
	fsw	f2, 5(x2)	# [7230] create_dirvec()
	# let dvec = create_dirvec()
	sw	x1, 6(x2)	# [7231] create_dirvec()
	addi	x2, x2, 7	# [7232] create_dirvec()
	jal	x1, -138	# [7233] create_dirvec()
	addi	x2, x2, -7	# [7234] create_dirvec()
	lw	x1, 6(x2)	# [7235] create_dirvec()
	sw	x4, 6(x2)	# [7236] d_vec dvec
	sw	x1, 7(x2)	# [7237] d_vec dvec
	addi	x2, x2, 8	# [7238] d_vec dvec
	jal	x1, -7007	# [7239] d_vec dvec
	addi	x2, x2, -8	# [7240] d_vec dvec
	lw	x1, 7(x2)	# [7241] d_vec dvec
	flw	f1, 5(x2)	# [7242] vecset (d_vec dvec) v0 v1 v2
	flw	f2, 4(x2)	# [7243] vecset (d_vec dvec) v0 v1 v2
	flw	f3, 3(x2)	# [7244] vecset (d_vec dvec) v0 v1 v2
	sw	x1, 7(x2)	# [7245] vecset (d_vec dvec) v0 v1 v2
	addi	x2, x2, 8	# [7246] vecset (d_vec dvec) v0 v1 v2
	jal	x1, -7220	# [7247] vecset (d_vec dvec) v0 v1 v2
	addi	x2, x2, -8	# [7248] vecset (d_vec dvec) v0 v1 v2
	lw	x1, 7(x2)	# [7249] vecset (d_vec dvec) v0 v1 v2
	addi	x0, x4, 0	# [7250] vecset (d_vec dvec) v0 v1 v2
	lw	x4, 6(x2)	# [7251] setup_dirvec_constants dvec
	sw	x1, 7(x2)	# [7252] setup_dirvec_constants dvec
	addi	x2, x2, 8	# [7253] setup_dirvec_constants dvec
	jal	x1, -4099	# [7254] setup_dirvec_constants dvec
	addi	x2, x2, -8	# [7255] setup_dirvec_constants dvec
	lw	x1, 7(x2)	# [7256] setup_dirvec_constants dvec
	addi	x0, x4, 0	# [7257] setup_dirvec_constants dvec
	lui	x4, 256	# [7258] reflections
	addi	x4, x4, 415	# [7259] reflections
	addi	x31, x3, 0	# [7260] surface_id, dvec, bright
	addi	x3, x3, 3	# [7261] surface_id, dvec, bright
	flw	f1, 2(x2)	# [7262] surface_id, dvec, bright
	fsw	f1, 2(x31)	# [7263] surface_id, dvec, bright
	lw	x5, 6(x2)	# [7264] surface_id, dvec, bright
	sw	x5, 1(x31)	# [7265] surface_id, dvec, bright
	lw	x5, 1(x2)	# [7266] surface_id, dvec, bright
	sw	x5, 0(x31)	# [7267] surface_id, dvec, bright
	addi	x5, x31, 0	# [7268] surface_id, dvec, bright
	lw	x6, 0(x2)	# [7269] reflections.(index) <- (surface_id, dvec, bright)
	add	x31, x4, x6	# [7270] reflections.(index) <- (surface_id, dvec, bright)
	sw	x5, 0(x31)	# [7271] reflections.(index) <- (surface_id, dvec, bright)
	jalr x0, x1, 0	# [7272] reflections.(index) <- (surface_id, dvec, bright)
# setup_rect_reflection.3378:	let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	# let sid = obj_id * 4
	slli	x4, x4, 2	# [7273] obj_id * 4
	lui	x6, 256	# [7274] n_reflections
	addi	x6, x6, 416	# [7275] n_reflections
	# let nr = n_reflections.(0)
	lw	x6, 0(x6)	# [7276] n_reflections.(0)
	sw	x6, 0(x2)	# [7277] o_diffuse obj
	sw	x4, 1(x2)	# [7278] o_diffuse obj
	addi	x4, x5, 0	# [7279] o_diffuse obj
	sw	x1, 2(x2)	# [7280] o_diffuse obj
	addi	x2, x2, 3	# [7281] o_diffuse obj
	jal	x1, -7096	# [7282] o_diffuse obj
	addi	x2, x2, -3	# [7283] o_diffuse obj
	lw	x1, 2(x2)	# [7284] o_diffuse obj
	# let br = 1.0 -. o_diffuse obj
	fsub	f1, f11, f1	# [7285] 1.0 -. o_diffuse obj
	lui	x4, 256	# [7286] light
	addi	x4, x4, 69	# [7287] light
	flw	f2, 0(x4)	# [7288] light.(0)
	# let n0 = fneg light.(0)
	fneg	f2, f2	# [7289] fneg light.(0)
	lui	x4, 256	# [7290] light
	addi	x4, x4, 69	# [7291] light
	flw	f3, 1(x4)	# [7292] light.(1)
	# let n1 = fneg light.(1)
	fneg	f3, f3	# [7293] fneg light.(1)
	lui	x4, 256	# [7294] light
	addi	x4, x4, 69	# [7295] light
	flw	f4, 2(x4)	# [7296] light.(2)
	# let n2 = fneg light.(2)
	fneg	f4, f4	# [7297] fneg light.(2)
	lw	x4, 1(x2)	# [7298] sid+1
	addi	x5, x4, 1	# [7299] sid+1
	lui	x6, 256	# [7300] light
	addi	x6, x6, 69	# [7301] light
	flw	f5, 0(x6)	# [7302] light.(0)
	lw	x6, 0(x2)	# [7303] add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f3, 2(x2)	# [7304] add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f4, 3(x2)	# [7305] add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f2, 4(x2)	# [7306] add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f1, 5(x2)	# [7307] add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x4, x6, 0	# [7308] add_reflection nr (sid+1) br light.(0) n1 n2
	fmv	f2, f5	# [7309] add_reflection nr (sid+1) br light.(0) n1 n2
	sw	x1, 6(x2)	# [7310] add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x2, x2, 7	# [7311] add_reflection nr (sid+1) br light.(0) n1 n2
	jal	x1, -87	# [7312] add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x2, x2, -7	# [7313] add_reflection nr (sid+1) br light.(0) n1 n2
	lw	x1, 6(x2)	# [7314] add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x0, x4, 0	# [7315] add_reflection nr (sid+1) br light.(0) n1 n2
	lw	x4, 0(x2)	# [7316] nr+1
	addi	x5, x4, 1	# [7317] nr+1
	lw	x6, 1(x2)	# [7318] sid+2
	addi	x7, x6, 2	# [7319] sid+2
	lui	x8, 256	# [7320] light
	addi	x8, x8, 69	# [7321] light
	flw	f3, 1(x8)	# [7322] light.(1)
	flw	f1, 5(x2)	# [7323] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	flw	f2, 4(x2)	# [7324] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	flw	f4, 3(x2)	# [7325] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x4, x5, 0	# [7326] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x5, x7, 0	# [7327] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	sw	x1, 6(x2)	# [7328] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x2, x2, 7	# [7329] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	jal	x1, -105	# [7330] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x2, x2, -7	# [7331] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	lw	x1, 6(x2)	# [7332] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x0, x4, 0	# [7333] add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	lw	x4, 0(x2)	# [7334] nr+2
	addi	x5, x4, 2	# [7335] nr+2
	lw	x6, 1(x2)	# [7336] sid+3
	addi	x6, x6, 3	# [7337] sid+3
	lui	x7, 256	# [7338] light
	addi	x7, x7, 69	# [7339] light
	flw	f4, 2(x7)	# [7340] light.(2)
	flw	f1, 5(x2)	# [7341] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	flw	f2, 4(x2)	# [7342] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	flw	f3, 2(x2)	# [7343] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x4, x5, 0	# [7344] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x5, x6, 0	# [7345] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	sw	x1, 6(x2)	# [7346] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x2, x2, 7	# [7347] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	jal	x1, -123	# [7348] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x2, x2, -7	# [7349] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	lw	x1, 6(x2)	# [7350] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x0, x4, 0	# [7351] add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	lui	x4, 256	# [7352] n_reflections
	addi	x4, x4, 416	# [7353] n_reflections
	lw	x5, 0(x2)	# [7354] nr + 3
	addi	x5, x5, 3	# [7355] nr + 3
	sw	x5, 0(x4)	# [7356] n_reflections.(0) <- nr + 3
	jalr x0, x1, 0	# [7357] n_reflections.(0) <- nr + 3
# setup_surface_reflection.3381:	let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	slli	x4, x4, 2	# [7358] obj_id * 4
	# let sid = obj_id * 4 + 1
	addi	x4, x4, 1	# [7359] obj_id * 4 + 1
	lui	x6, 256	# [7360] n_reflections
	addi	x6, x6, 416	# [7361] n_reflections
	# let nr = n_reflections.(0)
	lw	x6, 0(x6)	# [7362] n_reflections.(0)
	sw	x4, 0(x2)	# [7363] o_diffuse obj
	sw	x6, 1(x2)	# [7364] o_diffuse obj
	sw	x5, 2(x2)	# [7365] o_diffuse obj
	addi	x4, x5, 0	# [7366] o_diffuse obj
	sw	x1, 3(x2)	# [7367] o_diffuse obj
	addi	x2, x2, 4	# [7368] o_diffuse obj
	jal	x1, -7183	# [7369] o_diffuse obj
	addi	x2, x2, -4	# [7370] o_diffuse obj
	lw	x1, 3(x2)	# [7371] o_diffuse obj
	# let br = 1.0 -. o_diffuse obj
	fsub	f1, f11, f1	# [7372] 1.0 -. o_diffuse obj
	lui	x4, 256	# [7373] light
	addi	x4, x4, 69	# [7374] light
	lw	x5, 2(x2)	# [7375] o_param_abc obj
	fsw	f1, 3(x2)	# [7376] o_param_abc obj
	sw	x4, 4(x2)	# [7377] o_param_abc obj
	addi	x4, x5, 0	# [7378] o_param_abc obj
	sw	x1, 5(x2)	# [7379] o_param_abc obj
	addi	x2, x2, 6	# [7380] o_param_abc obj
	jal	x1, -7206	# [7381] o_param_abc obj
	addi	x2, x2, -6	# [7382] o_param_abc obj
	lw	x1, 5(x2)	# [7383] o_param_abc obj
	addi	x5, x4, 0	# [7384] o_param_abc obj
	lw	x4, 4(x2)	# [7385] veciprod light (o_param_abc obj)
	# let p = veciprod light (o_param_abc obj)
	sw	x1, 5(x2)	# [7386] veciprod light (o_param_abc obj)
	addi	x2, x2, 6	# [7387] veciprod light (o_param_abc obj)
	jal	x1, -7311	# [7388] veciprod light (o_param_abc obj)
	addi	x2, x2, -6	# [7389] veciprod light (o_param_abc obj)
	lw	x1, 5(x2)	# [7390] veciprod light (o_param_abc obj)
	lw	x4, 2(x2)	# [7391] o_param_a obj
	fsw	f1, 5(x2)	# [7392] o_param_a obj
	sw	x1, 6(x2)	# [7393] o_param_a obj
	addi	x2, x2, 7	# [7394] o_param_a obj
	jal	x1, -7229	# [7395] o_param_a obj
	addi	x2, x2, -7	# [7396] o_param_a obj
	lw	x1, 6(x2)	# [7397] o_param_a obj
	fmul	f1, f12, f1	# [7398] 2.0 *. o_param_a obj
	flw	f2, 5(x2)	# [7399] 2.0 *. o_param_a obj *. p
	fmul	f1, f1, f2	# [7400] 2.0 *. o_param_a obj *. p
	lui	x4, 256	# [7401] light
	addi	x4, x4, 69	# [7402] light
	flw	f3, 0(x4)	# [7403] light.(0)
	fsub	f1, f1, f3	# [7404] 2.0 *. o_param_a obj *. p -. light.(0)
	lw	x4, 2(x2)	# [7405] o_param_b obj
	fsw	f1, 6(x2)	# [7406] o_param_b obj
	sw	x1, 7(x2)	# [7407] o_param_b obj
	addi	x2, x2, 8	# [7408] o_param_b obj
	jal	x1, -7240	# [7409] o_param_b obj
	addi	x2, x2, -8	# [7410] o_param_b obj
	lw	x1, 7(x2)	# [7411] o_param_b obj
	fmul	f1, f12, f1	# [7412] 2.0 *. o_param_b obj
	flw	f2, 5(x2)	# [7413] 2.0 *. o_param_b obj *. p
	fmul	f1, f1, f2	# [7414] 2.0 *. o_param_b obj *. p
	lui	x4, 256	# [7415] light
	addi	x4, x4, 69	# [7416] light
	flw	f3, 1(x4)	# [7417] light.(1)
	fsub	f1, f1, f3	# [7418] 2.0 *. o_param_b obj *. p -. light.(1)
	lw	x4, 2(x2)	# [7419] o_param_c obj
	fsw	f1, 7(x2)	# [7420] o_param_c obj
	sw	x1, 8(x2)	# [7421] o_param_c obj
	addi	x2, x2, 9	# [7422] o_param_c obj
	jal	x1, -7251	# [7423] o_param_c obj
	addi	x2, x2, -9	# [7424] o_param_c obj
	lw	x1, 8(x2)	# [7425] o_param_c obj
	fmul	f1, f12, f1	# [7426] 2.0 *. o_param_c obj
	flw	f2, 5(x2)	# [7427] 2.0 *. o_param_c obj *. p
	fmul	f1, f1, f2	# [7428] 2.0 *. o_param_c obj *. p
	lui	x4, 256	# [7429] light
	addi	x4, x4, 69	# [7430] light
	flw	f2, 2(x4)	# [7431] light.(2)
	fsub	f4, f1, f2	# [7432] 2.0 *. o_param_c obj *. p -. light.(2)
	flw	f1, 3(x2)	# [7433] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	flw	f2, 6(x2)	# [7434] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	flw	f3, 7(x2)	# [7435] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x4, 1(x2)	# [7436] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x5, 0(x2)	# [7437] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	sw	x1, 8(x2)	# [7438] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	addi	x2, x2, 9	# [7439] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	jal	x1, -215	# [7440] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	addi	x2, x2, -9	# [7441] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x1, 8(x2)	# [7442] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	addi	x0, x4, 0	# [7443] add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lui	x4, 256	# [7444] n_reflections
	addi	x4, x4, 416	# [7445] n_reflections
	lw	x5, 1(x2)	# [7446] nr + 1
	addi	x5, x5, 1	# [7447] nr + 1
	sw	x5, 0(x4)	# [7448] n_reflections.(0) <- nr + 1
	jalr x0, x1, 0	# [7449] n_reflections.(0) <- nr + 1
# setup_reflections.3384:	let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	bge	x4, x0, 2	# [7450] if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
# blt:	()
	jalr x0, x1, 0	# [7451] ()
# bge:	let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else ()
	lui	x5, 256	# [7452] objects
	addi	x5, x5, 60	# [7453] objects
	# let obj = objects.(obj_id)
	add	x31, x5, x4	# [7454] objects.(obj_id)
	lw	x5, 0(x31)	# [7455] objects.(obj_id)
	sw	x4, 0(x2)	# [7456] o_reflectiontype obj
	sw	x5, 1(x2)	# [7457] o_reflectiontype obj
	addi	x4, x5, 0	# [7458] o_reflectiontype obj
	sw	x1, 2(x2)	# [7459] o_reflectiontype obj
	addi	x2, x2, 3	# [7460] o_reflectiontype obj
	jal	x1, -7301	# [7461] o_reflectiontype obj
	addi	x2, x2, -3	# [7462] o_reflectiontype obj
	lw	x1, 2(x2)	# [7463] o_reflectiontype obj
	addi	x5, x0, 2	# [7464] 2
	bne	x4, x5, 27	# [7465] if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else ()
# beq:	if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else ()
	lw	x4, 1(x2)	# [7466] o_diffuse obj
	sw	x1, 2(x2)	# [7467] o_diffuse obj
	addi	x2, x2, 3	# [7468] o_diffuse obj
	jal	x1, -7283	# [7469] o_diffuse obj
	addi	x2, x2, -3	# [7470] o_diffuse obj
	lw	x1, 2(x2)	# [7471] o_diffuse obj
	flt	x4, f1, f11	# [7472] fless (o_diffuse obj) 1.0
	bne	x4, x0, 2	# [7473] if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else ()
# beq:	()
	jalr x0, x1, 0	# [7474] ()
# bne:	let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else ()
	lw	x4, 1(x2)	# [7475] o_form obj
	# let m_shape = o_form obj
	sw	x1, 2(x2)	# [7476] o_form obj
	addi	x2, x2, 3	# [7477] o_form obj
	jal	x1, -7320	# [7478] o_form obj
	addi	x2, x2, -3	# [7479] o_form obj
	lw	x1, 2(x2)	# [7480] o_form obj
	addi	x5, x0, 1	# [7481] 1
	bne	x4, x5, 4	# [7482] if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else ()
# beq:	setup_rect_reflection obj_id obj
	lw	x4, 0(x2)	# [7483] setup_rect_reflection obj_id obj
	lw	x5, 1(x2)	# [7484] setup_rect_reflection obj_id obj
	jal	x0, -212	# [7485] setup_rect_reflection obj_id obj
# bne:	if m_shape = 2 then setup_surface_reflection obj_id obj else ()
	addi	x5, x0, 2	# [7486] 2
	bne	x4, x5, 4	# [7487] if m_shape = 2 then setup_surface_reflection obj_id obj else ()
# beq:	setup_surface_reflection obj_id obj
	lw	x4, 0(x2)	# [7488] setup_surface_reflection obj_id obj
	lw	x5, 1(x2)	# [7489] setup_surface_reflection obj_id obj
	jal	x0, -132	# [7490] setup_surface_reflection obj_id obj
# bne:	()
	jalr x0, x1, 0	# [7491] ()
# bne:	()
	jalr x0, x1, 0	# [7492] ()
# rt.3386:	let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lui	x6, 256	# [7493] image_size
	addi	x6, x6, 142	# [7494] image_size
	sw	x4, 0(x6)	# [7495] image_size.(0) <- size_x
	lui	x6, 256	# [7496] image_size
	addi	x6, x6, 142	# [7497] image_size
	sw	x5, 1(x6)	# [7498] image_size.(1) <- size_y
	lui	x6, 256	# [7499] image_center
	addi	x6, x6, 144	# [7500] image_center
	srai	x7, x4, 1	# [7501] size_x / 2
	sw	x7, 0(x6)	# [7502] image_center.(0) <- size_x / 2
	lui	x6, 256	# [7503] image_center
	addi	x6, x6, 144	# [7504] image_center
	srai	x5, x5, 1	# [7505] size_y / 2
	sw	x5, 1(x6)	# [7506] image_center.(1) <- size_y / 2
	lui	x5, 256	# [7507] scan_pitch
	addi	x5, x5, 145	# [7508] scan_pitch
	itof	f1, x4	# [7509] float_of_int size_x
	fdiv	f1, f17, f1	# [7510] 128.0 /. float_of_int size_x
	fsw	f1, 0(x5)	# [7511] scan_pitch.(0) <- 128.0 /. float_of_int size_x
	# let prev = create_pixelline ()
	sw	x1, 0(x2)	# [7512] create_pixelline ()
	addi	x2, x2, 1	# [7513] create_pixelline ()
	jal	x1, -778	# [7514] create_pixelline ()
	addi	x2, x2, -1	# [7515] create_pixelline ()
	lw	x1, 0(x2)	# [7516] create_pixelline ()
	sw	x4, 0(x2)	# [7517] create_pixelline ()
	# let cur = create_pixelline ()
	sw	x1, 1(x2)	# [7518] create_pixelline ()
	addi	x2, x2, 2	# [7519] create_pixelline ()
	jal	x1, -784	# [7520] create_pixelline ()
	addi	x2, x2, -2	# [7521] create_pixelline ()
	lw	x1, 1(x2)	# [7522] create_pixelline ()
	sw	x4, 1(x2)	# [7523] create_pixelline ()
	# let next = create_pixelline ()
	sw	x1, 2(x2)	# [7524] create_pixelline ()
	addi	x2, x2, 3	# [7525] create_pixelline ()
	jal	x1, -790	# [7526] create_pixelline ()
	addi	x2, x2, -3	# [7527] create_pixelline ()
	lw	x1, 2(x2)	# [7528] create_pixelline ()
	sw	x4, 2(x2)	# [7529] read_parameter()
	sw	x1, 3(x2)	# [7530] read_parameter()
	addi	x2, x2, 4	# [7531] read_parameter()
	jal	x1, -5943	# [7532] read_parameter()
	addi	x2, x2, -4	# [7533] read_parameter()
	lw	x1, 3(x2)	# [7534] read_parameter()
	addi	x0, x4, 0	# [7535] read_parameter()
	sw	x1, 3(x2)	# [7536] write_ppm_header ()
	addi	x2, x2, 4	# [7537] write_ppm_header ()
	jal	x1, -1452	# [7538] write_ppm_header ()
	addi	x2, x2, -4	# [7539] write_ppm_header ()
	lw	x1, 3(x2)	# [7540] write_ppm_header ()
	addi	x0, x4, 0	# [7541] write_ppm_header ()
	sw	x1, 3(x2)	# [7542] init_dirvecs()
	addi	x2, x2, 4	# [7543] init_dirvecs()
	jal	x1, -337	# [7544] init_dirvecs()
	addi	x2, x2, -4	# [7545] init_dirvecs()
	lw	x1, 3(x2)	# [7546] init_dirvecs()
	addi	x0, x4, 0	# [7547] init_dirvecs()
	lui	x4, 256	# [7548] light_dirvec
	addi	x4, x4, 233	# [7549] light_dirvec
	sw	x1, 3(x2)	# [7550] d_vec light_dirvec
	addi	x2, x2, 4	# [7551] d_vec light_dirvec
	jal	x1, -7320	# [7552] d_vec light_dirvec
	addi	x2, x2, -4	# [7553] d_vec light_dirvec
	lw	x1, 3(x2)	# [7554] d_vec light_dirvec
	lui	x5, 256	# [7555] light
	addi	x5, x5, 69	# [7556] light
	sw	x1, 3(x2)	# [7557] veccpy (d_vec light_dirvec) light
	addi	x2, x2, 4	# [7558] veccpy (d_vec light_dirvec) light
	jal	x1, -7521	# [7559] veccpy (d_vec light_dirvec) light
	addi	x2, x2, -4	# [7560] veccpy (d_vec light_dirvec) light
	lw	x1, 3(x2)	# [7561] veccpy (d_vec light_dirvec) light
	addi	x0, x4, 0	# [7562] veccpy (d_vec light_dirvec) light
	lui	x4, 256	# [7563] light_dirvec
	addi	x4, x4, 233	# [7564] light_dirvec
	sw	x1, 3(x2)	# [7565] setup_dirvec_constants light_dirvec
	addi	x2, x2, 4	# [7566] setup_dirvec_constants light_dirvec
	jal	x1, -4412	# [7567] setup_dirvec_constants light_dirvec
	addi	x2, x2, -4	# [7568] setup_dirvec_constants light_dirvec
	lw	x1, 3(x2)	# [7569] setup_dirvec_constants light_dirvec
	addi	x0, x4, 0	# [7570] setup_dirvec_constants light_dirvec
	lui	x4, 256	# [7571] n_objects
	addi	x4, x4, 0	# [7572] n_objects
	lw	x4, 0(x4)	# [7573] n_objects.(0)
	addi	x4, x4, -1	# [7574] n_objects.(0) - 1
	sw	x1, 3(x2)	# [7575] setup_reflections (n_objects.(0) - 1)
	addi	x2, x2, 4	# [7576] setup_reflections (n_objects.(0) - 1)
	jal	x1, -127	# [7577] setup_reflections (n_objects.(0) - 1)
	addi	x2, x2, -4	# [7578] setup_reflections (n_objects.(0) - 1)
	lw	x1, 3(x2)	# [7579] setup_reflections (n_objects.(0) - 1)
	addi	x0, x4, 0	# [7580] setup_reflections (n_objects.(0) - 1)
	addi	x5, x0, 0	# [7581] 0
	addi	x6, x0, 0	# [7582] 0
	lw	x4, 1(x2)	# [7583] pretrace_line cur 0 0
	sw	x1, 3(x2)	# [7584] pretrace_line cur 0 0
	addi	x2, x2, 4	# [7585] pretrace_line cur 0 0
	jal	x1, -1171	# [7586] pretrace_line cur 0 0
	addi	x2, x2, -4	# [7587] pretrace_line cur 0 0
	lw	x1, 3(x2)	# [7588] pretrace_line cur 0 0
	addi	x0, x4, 0	# [7589] pretrace_line cur 0 0
	addi	x4, x0, 0	# [7590] 0
	addi	x8, x0, 2	# [7591] 2
	lw	x5, 0(x2)	# [7592] scan_line 0 prev cur next 2
	lw	x6, 1(x2)	# [7593] scan_line 0 prev cur next 2
	lw	x7, 2(x2)	# [7594] scan_line 0 prev cur next 2
	jal	x0, -1061	# [7595] scan_line 0 prev cur next 2
# entry point
	addi	x2, x0, 0 # [7596]
	lui	x3, 256 # [7597]
	addi	x3, x3, -1 # [7598]
# program begins
	addi	x3, x0, 0	# [7599]
	addi	x4, x0, 1	# [7600] 1
	addi	x5, x0, 0	# [7601] 0
	# let n_objects = create_array 1 0
	add	x31, x3, x4	# [7602] create_array 1 0
	beq	x31, x3, 4	# [7603] create_array 1 0
	sw	x5, 0(x3)	# [7604] create_array 1 0
	addi	x3, x3, 1	# [7605] create_array 1 0
	jal	x0, -3	# [7606] create_array 1 0
	addi	x4, x0, 0	# [7607] 0
	addi	x31, x0, 0	# [7608] 0.0
	xtof	f1, x31	# [7609] 0.0
	# let dummy = create_array 0 0.0
	add	x31, x3, x4	# [7610] create_array 0 0.0
	beq	x31, x3, 4	# [7611] create_array 0 0.0
	fsw	f1, 0(x3)	# [7612] create_array 0 0.0
	addi	x3, x3, 1	# [7613] create_array 0 0.0
	jal	x0, -3	# [7614] create_array 0 0.0
	addi	x4, x0, 60	# [7615] 60
	addi	x5, x0, 0	# [7616] 0
	addi	x6, x0, 0	# [7617] 0
	addi	x7, x0, 0	# [7618] 0
	addi	x8, x0, 0	# [7619] 0
	lui	x9, 256	# [7620] dummy
	addi	x9, x9, 0	# [7621] dummy
	lui	x10, 256	# [7622] dummy
	addi	x10, x10, 0	# [7623] dummy
	addi	x11, x0, 0	# [7624] false
	lui	x12, 256	# [7625] dummy
	addi	x12, x12, 0	# [7626] dummy
	lui	x13, 256	# [7627] dummy
	addi	x13, x13, 0	# [7628] dummy
	lui	x14, 256	# [7629] dummy
	addi	x14, x14, 0	# [7630] dummy
	lui	x15, 256	# [7631] dummy
	addi	x15, x15, 0	# [7632] dummy
	addi	x31, x3, 0	# [7633] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	addi	x3, x0, 11	# [7634] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x15, 10(x31)	# [7635] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x14, 9(x31)	# [7636] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x13, 8(x31)	# [7637] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x12, 7(x31)	# [7638] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x11, 6(x31)	# [7639] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x10, 5(x31)	# [7640] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x9, 4(x31)	# [7641] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x8, 3(x31)	# [7642] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x7, 2(x31)	# [7643] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x6, 1(x31)	# [7644] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x5, 0(x31)	# [7645] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	addi	x5, x31, 0	# [7646] 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	# let objects = let dummy = create_array 0 0.0 in create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	add	x31, x3, x4	# [7647] create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	beq	x31, x3, 4	# [7648] create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	sw	x5, 0(x3)	# [7649] create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x3, x3, 1	# [7650] create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	jal	x0, -3	# [7651] create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x4, x0, 3	# [7652] 3
	addi	x31, x0, 0	# [7653] 0.0
	xtof	f1, x31	# [7654] 0.0
	# let screen = create_array 3 0.0
	add	x31, x3, x4	# [7655] create_array 3 0.0
	beq	x31, x3, 4	# [7656] create_array 3 0.0
	fsw	f1, 0(x3)	# [7657] create_array 3 0.0
	addi	x3, x3, 1	# [7658] create_array 3 0.0
	jal	x0, -3	# [7659] create_array 3 0.0
	addi	x4, x0, 3	# [7660] 3
	addi	x31, x0, 0	# [7661] 0.0
	xtof	f1, x31	# [7662] 0.0
	# let viewpoint = create_array 3 0.0
	add	x31, x3, x4	# [7663] create_array 3 0.0
	beq	x31, x3, 4	# [7664] create_array 3 0.0
	fsw	f1, 0(x3)	# [7665] create_array 3 0.0
	addi	x3, x3, 1	# [7666] create_array 3 0.0
	jal	x0, -3	# [7667] create_array 3 0.0
	addi	x4, x0, 3	# [7668] 3
	addi	x31, x0, 0	# [7669] 0.0
	xtof	f1, x31	# [7670] 0.0
	# let light = create_array 3 0.0
	add	x31, x3, x4	# [7671] create_array 3 0.0
	beq	x31, x3, 4	# [7672] create_array 3 0.0
	fsw	f1, 0(x3)	# [7673] create_array 3 0.0
	addi	x3, x3, 1	# [7674] create_array 3 0.0
	jal	x0, -3	# [7675] create_array 3 0.0
	addi	x4, x0, 1	# [7676] 1
	lui	x31, 276464	# [7677] 255.0
	addi	x31, x31, 0	# [7678] 255.0
	xtof	f1, x31	# [7679] 255.0
	# let beam = create_array 1 255.0
	add	x31, x3, x4	# [7680] create_array 1 255.0
	beq	x31, x3, 4	# [7681] create_array 1 255.0
	fsw	f1, 0(x3)	# [7682] create_array 1 255.0
	addi	x3, x3, 1	# [7683] create_array 1 255.0
	jal	x0, -3	# [7684] create_array 1 255.0
	addi	x4, x0, 50	# [7685] 50
	addi	x5, x0, 1	# [7686] 1
	addi	x6, x0, -1	# [7687] -1
	add	x31, x3, x5	# [7688] create_array 1 (-1)
	beq	x31, x3, 4	# [7689] create_array 1 (-1)
	sw	x6, 0(x3)	# [7690] create_array 1 (-1)
	addi	x3, x3, 1	# [7691] create_array 1 (-1)
	jal	x0, -3	# [7692] create_array 1 (-1)
	# let and_net = create_array 50 (create_array 1 (-1))
	add	x31, x3, x4	# [7693] create_array 50 (create_array 1 (-1))
	beq	x31, x3, 4	# [7694] create_array 50 (create_array 1 (-1))
	sw	x5, 0(x3)	# [7695] create_array 50 (create_array 1 (-1))
	addi	x3, x3, 1	# [7696] create_array 50 (create_array 1 (-1))
	jal	x0, -3	# [7697] create_array 50 (create_array 1 (-1))
	addi	x4, x0, 1	# [7698] 1
	addi	x5, x0, 1	# [7699] 1
	lui	x6, 256	# [7700] and_net
	addi	x6, x6, 120	# [7701] and_net
	lw	x6, 0(x6)	# [7702] and_net.(0)
	add	x31, x3, x5	# [7703] create_array 1 (and_net.(0))
	beq	x31, x3, 4	# [7704] create_array 1 (and_net.(0))
	sw	x6, 0(x3)	# [7705] create_array 1 (and_net.(0))
	addi	x3, x3, 1	# [7706] create_array 1 (and_net.(0))
	jal	x0, -3	# [7707] create_array 1 (and_net.(0))
	# let or_net = create_array 1 (create_array 1 (and_net.(0)))
	add	x31, x3, x4	# [7708] create_array 1 (create_array 1 (and_net.(0)))
	beq	x31, x3, 4	# [7709] create_array 1 (create_array 1 (and_net.(0)))
	sw	x5, 0(x3)	# [7710] create_array 1 (create_array 1 (and_net.(0)))
	addi	x3, x3, 1	# [7711] create_array 1 (create_array 1 (and_net.(0)))
	jal	x0, -3	# [7712] create_array 1 (create_array 1 (and_net.(0)))
	addi	x4, x0, 1	# [7713] 1
	addi	x31, x0, 0	# [7714] 0.0
	xtof	f1, x31	# [7715] 0.0
	# let solver_dist = create_array 1 0.0
	add	x31, x3, x4	# [7716] create_array 1 0.0
	beq	x31, x3, 4	# [7717] create_array 1 0.0
	fsw	f1, 0(x3)	# [7718] create_array 1 0.0
	addi	x3, x3, 1	# [7719] create_array 1 0.0
	jal	x0, -3	# [7720] create_array 1 0.0
	addi	x4, x0, 1	# [7721] 1
	addi	x5, x0, 0	# [7722] 0
	# let intsec_rectside = create_array 1 0
	add	x31, x3, x4	# [7723] create_array 1 0
	beq	x31, x3, 4	# [7724] create_array 1 0
	sw	x5, 0(x3)	# [7725] create_array 1 0
	addi	x3, x3, 1	# [7726] create_array 1 0
	jal	x0, -3	# [7727] create_array 1 0
	addi	x4, x0, 1	# [7728] 1
	lui	x31, 321254	# [7729] 1000000000.0
	addi	x31, x31, -1240	# [7730] 1000000000.0
	xtof	f1, x31	# [7731] 1000000000.0
	# let tmin = create_array 1 (1000000000.0)
	add	x31, x3, x4	# [7732] create_array 1 (1000000000.0)
	beq	x31, x3, 4	# [7733] create_array 1 (1000000000.0)
	fsw	f1, 0(x3)	# [7734] create_array 1 (1000000000.0)
	addi	x3, x3, 1	# [7735] create_array 1 (1000000000.0)
	jal	x0, -3	# [7736] create_array 1 (1000000000.0)
	addi	x4, x0, 3	# [7737] 3
	addi	x31, x0, 0	# [7738] 0.0
	xtof	f1, x31	# [7739] 0.0
	# let intersection_point = create_array 3 0.0
	add	x31, x3, x4	# [7740] create_array 3 0.0
	beq	x31, x3, 4	# [7741] create_array 3 0.0
	fsw	f1, 0(x3)	# [7742] create_array 3 0.0
	addi	x3, x3, 1	# [7743] create_array 3 0.0
	jal	x0, -3	# [7744] create_array 3 0.0
	addi	x4, x0, 1	# [7745] 1
	addi	x5, x0, 0	# [7746] 0
	# let intersected_object_id = create_array 1 0
	add	x31, x3, x4	# [7747] create_array 1 0
	beq	x31, x3, 4	# [7748] create_array 1 0
	sw	x5, 0(x3)	# [7749] create_array 1 0
	addi	x3, x3, 1	# [7750] create_array 1 0
	jal	x0, -3	# [7751] create_array 1 0
	addi	x4, x0, 3	# [7752] 3
	addi	x31, x0, 0	# [7753] 0.0
	xtof	f1, x31	# [7754] 0.0
	# let nvector = create_array 3 0.0
	add	x31, x3, x4	# [7755] create_array 3 0.0
	beq	x31, x3, 4	# [7756] create_array 3 0.0
	fsw	f1, 0(x3)	# [7757] create_array 3 0.0
	addi	x3, x3, 1	# [7758] create_array 3 0.0
	jal	x0, -3	# [7759] create_array 3 0.0
	addi	x4, x0, 3	# [7760] 3
	addi	x31, x0, 0	# [7761] 0.0
	xtof	f1, x31	# [7762] 0.0
	# let texture_color = create_array 3 0.0
	add	x31, x3, x4	# [7763] create_array 3 0.0
	beq	x31, x3, 4	# [7764] create_array 3 0.0
	fsw	f1, 0(x3)	# [7765] create_array 3 0.0
	addi	x3, x3, 1	# [7766] create_array 3 0.0
	jal	x0, -3	# [7767] create_array 3 0.0
	addi	x4, x0, 3	# [7768] 3
	addi	x31, x0, 0	# [7769] 0.0
	xtof	f1, x31	# [7770] 0.0
	# let diffuse_ray = create_array 3 0.0
	add	x31, x3, x4	# [7771] create_array 3 0.0
	beq	x31, x3, 4	# [7772] create_array 3 0.0
	fsw	f1, 0(x3)	# [7773] create_array 3 0.0
	addi	x3, x3, 1	# [7774] create_array 3 0.0
	jal	x0, -3	# [7775] create_array 3 0.0
	addi	x4, x0, 3	# [7776] 3
	addi	x31, x0, 0	# [7777] 0.0
	xtof	f1, x31	# [7778] 0.0
	# let rgb = create_array 3 0.0
	add	x31, x3, x4	# [7779] create_array 3 0.0
	beq	x31, x3, 4	# [7780] create_array 3 0.0
	fsw	f1, 0(x3)	# [7781] create_array 3 0.0
	addi	x3, x3, 1	# [7782] create_array 3 0.0
	jal	x0, -3	# [7783] create_array 3 0.0
	addi	x4, x0, 2	# [7784] 2
	addi	x5, x0, 0	# [7785] 0
	# let image_size = create_array 2 0
	add	x31, x3, x4	# [7786] create_array 2 0
	beq	x31, x3, 4	# [7787] create_array 2 0
	sw	x5, 0(x3)	# [7788] create_array 2 0
	addi	x3, x3, 1	# [7789] create_array 2 0
	jal	x0, -3	# [7790] create_array 2 0
	addi	x4, x0, 2	# [7791] 2
	addi	x5, x0, 0	# [7792] 0
	# let image_center = create_array 2 0
	add	x31, x3, x4	# [7793] create_array 2 0
	beq	x31, x3, 4	# [7794] create_array 2 0
	sw	x5, 0(x3)	# [7795] create_array 2 0
	addi	x3, x3, 1	# [7796] create_array 2 0
	jal	x0, -3	# [7797] create_array 2 0
	addi	x4, x0, 1	# [7798] 1
	addi	x31, x0, 0	# [7799] 0.0
	xtof	f1, x31	# [7800] 0.0
	# let scan_pitch = create_array 1 0.0
	add	x31, x3, x4	# [7801] create_array 1 0.0
	beq	x31, x3, 4	# [7802] create_array 1 0.0
	fsw	f1, 0(x3)	# [7803] create_array 1 0.0
	addi	x3, x3, 1	# [7804] create_array 1 0.0
	jal	x0, -3	# [7805] create_array 1 0.0
	addi	x4, x0, 3	# [7806] 3
	addi	x31, x0, 0	# [7807] 0.0
	xtof	f1, x31	# [7808] 0.0
	# let startp = create_array 3 0.0
	add	x31, x3, x4	# [7809] create_array 3 0.0
	beq	x31, x3, 4	# [7810] create_array 3 0.0
	fsw	f1, 0(x3)	# [7811] create_array 3 0.0
	addi	x3, x3, 1	# [7812] create_array 3 0.0
	jal	x0, -3	# [7813] create_array 3 0.0
	addi	x4, x0, 3	# [7814] 3
	addi	x31, x0, 0	# [7815] 0.0
	xtof	f1, x31	# [7816] 0.0
	# let startp_fast = create_array 3 0.0
	add	x31, x3, x4	# [7817] create_array 3 0.0
	beq	x31, x3, 4	# [7818] create_array 3 0.0
	fsw	f1, 0(x3)	# [7819] create_array 3 0.0
	addi	x3, x3, 1	# [7820] create_array 3 0.0
	jal	x0, -3	# [7821] create_array 3 0.0
	addi	x4, x0, 3	# [7822] 3
	addi	x31, x0, 0	# [7823] 0.0
	xtof	f1, x31	# [7824] 0.0
	# let screenx_dir = create_array 3 0.0
	add	x31, x3, x4	# [7825] create_array 3 0.0
	beq	x31, x3, 4	# [7826] create_array 3 0.0
	fsw	f1, 0(x3)	# [7827] create_array 3 0.0
	addi	x3, x3, 1	# [7828] create_array 3 0.0
	jal	x0, -3	# [7829] create_array 3 0.0
	addi	x4, x0, 3	# [7830] 3
	addi	x31, x0, 0	# [7831] 0.0
	xtof	f1, x31	# [7832] 0.0
	# let screeny_dir = create_array 3 0.0
	add	x31, x3, x4	# [7833] create_array 3 0.0
	beq	x31, x3, 4	# [7834] create_array 3 0.0
	fsw	f1, 0(x3)	# [7835] create_array 3 0.0
	addi	x3, x3, 1	# [7836] create_array 3 0.0
	jal	x0, -3	# [7837] create_array 3 0.0
	addi	x4, x0, 3	# [7838] 3
	addi	x31, x0, 0	# [7839] 0.0
	xtof	f1, x31	# [7840] 0.0
	# let screenz_dir = create_array 3 0.0
	add	x31, x3, x4	# [7841] create_array 3 0.0
	beq	x31, x3, 4	# [7842] create_array 3 0.0
	fsw	f1, 0(x3)	# [7843] create_array 3 0.0
	addi	x3, x3, 1	# [7844] create_array 3 0.0
	jal	x0, -3	# [7845] create_array 3 0.0
	addi	x4, x0, 3	# [7846] 3
	addi	x31, x0, 0	# [7847] 0.0
	xtof	f1, x31	# [7848] 0.0
	# let ptrace_dirvec = create_array 3 0.0
	add	x31, x3, x4	# [7849] create_array 3 0.0
	beq	x31, x3, 4	# [7850] create_array 3 0.0
	fsw	f1, 0(x3)	# [7851] create_array 3 0.0
	addi	x3, x3, 1	# [7852] create_array 3 0.0
	jal	x0, -3	# [7853] create_array 3 0.0
	addi	x4, x0, 0	# [7854] 0
	addi	x31, x0, 0	# [7855] 0.0
	xtof	f1, x31	# [7856] 0.0
	# let dummyf = create_array 0 0.0
	add	x31, x3, x4	# [7857] create_array 0 0.0
	beq	x31, x3, 4	# [7858] create_array 0 0.0
	fsw	f1, 0(x3)	# [7859] create_array 0 0.0
	addi	x3, x3, 1	# [7860] create_array 0 0.0
	jal	x0, -3	# [7861] create_array 0 0.0
	addi	x4, x0, 0	# [7862] 0
	lui	x5, 256	# [7863] dummyf
	addi	x5, x5, 163	# [7864] dummyf
	# let dummyff = create_array 0 dummyf
	add	x31, x3, x4	# [7865] create_array 0 dummyf
	beq	x31, x3, 4	# [7866] create_array 0 dummyf
	sw	x5, 0(x3)	# [7867] create_array 0 dummyf
	addi	x3, x3, 1	# [7868] create_array 0 dummyf
	jal	x0, -3	# [7869] create_array 0 dummyf
	addi	x4, x0, 0	# [7870] 0
	lui	x5, 256	# [7871] dummyf
	addi	x5, x5, 163	# [7872] dummyf
	lui	x6, 256	# [7873] dummyff
	addi	x6, x6, 163	# [7874] dummyff
	addi	x31, x3, 0	# [7875] dummyf, dummyff
	addi	x3, x0, 13	# [7876] dummyf, dummyff
	sw	x6, 1(x31)	# [7877] dummyf, dummyff
	sw	x5, 0(x31)	# [7878] dummyf, dummyff
	addi	x5, x31, 0	# [7879] dummyf, dummyff
	# let dummy_vs = create_array 0 (dummyf, dummyff)
	add	x31, x3, x4	# [7880] create_array 0 (dummyf, dummyff)
	beq	x31, x3, 4	# [7881] create_array 0 (dummyf, dummyff)
	sw	x5, 0(x3)	# [7882] create_array 0 (dummyf, dummyff)
	addi	x3, x3, 1	# [7883] create_array 0 (dummyf, dummyff)
	jal	x0, -3	# [7884] create_array 0 (dummyf, dummyff)
	addi	x4, x0, 5	# [7885] 5
	lui	x5, 256	# [7886] dummy_vs
	addi	x5, x5, 163	# [7887] dummy_vs
	# let dirvecs = let dummyf = create_array 0 0.0 in let dummyff = create_array 0 dummyf in let dummy_vs = create_array 0 (dummyf, dummyff) in create_array 5 dummy_vs
	add	x31, x3, x4	# [7888] create_array 5 dummy_vs
	beq	x31, x3, 4	# [7889] create_array 5 dummy_vs
	sw	x5, 0(x3)	# [7890] create_array 5 dummy_vs
	addi	x3, x3, 1	# [7891] create_array 5 dummy_vs
	jal	x0, -3	# [7892] create_array 5 dummy_vs
	addi	x4, x0, 0	# [7893] 0
	addi	x31, x0, 0	# [7894] 0.0
	xtof	f1, x31	# [7895] 0.0
	# let dummyf2 = create_array 0 0.0
	add	x31, x3, x4	# [7896] create_array 0 0.0
	beq	x31, x3, 4	# [7897] create_array 0 0.0
	fsw	f1, 0(x3)	# [7898] create_array 0 0.0
	addi	x3, x3, 1	# [7899] create_array 0 0.0
	jal	x0, -3	# [7900] create_array 0 0.0
	addi	x4, x0, 3	# [7901] 3
	addi	x31, x0, 0	# [7902] 0.0
	xtof	f1, x31	# [7903] 0.0
	# let v3 = create_array 3 0.0
	add	x31, x3, x4	# [7904] create_array 3 0.0
	beq	x31, x3, 4	# [7905] create_array 3 0.0
	fsw	f1, 0(x3)	# [7906] create_array 3 0.0
	addi	x3, x3, 1	# [7907] create_array 3 0.0
	jal	x0, -3	# [7908] create_array 3 0.0
	addi	x4, x0, 60	# [7909] 60
	lui	x5, 256	# [7910] dummyf2
	addi	x5, x5, 168	# [7911] dummyf2
	# let consts = create_array 60 dummyf2
	add	x31, x3, x4	# [7912] create_array 60 dummyf2
	beq	x31, x3, 4	# [7913] create_array 60 dummyf2
	sw	x5, 0(x3)	# [7914] create_array 60 dummyf2
	addi	x3, x3, 1	# [7915] create_array 60 dummyf2
	jal	x0, -3	# [7916] create_array 60 dummyf2
	lui	x4, 256	# [7917] v3
	addi	x4, x4, 171	# [7918] v3
	lui	x5, 256	# [7919] consts
	addi	x5, x5, 231	# [7920] consts
	addi	x31, x3, 0	# [7921] v3, consts
	addi	x3, x0, 15	# [7922] v3, consts
	sw	x5, 1(x31)	# [7923] v3, consts
	sw	x4, 0(x31)	# [7924] v3, consts
	# let light_dirvec = let dummyf2 = create_array 0 0.0 in let v3 = create_array 3 0.0 in let consts = create_array 60 dummyf2 in (v3, consts)
	addi	x4, x31, 0	# [7925] v3, consts
	addi	x4, x0, 0	# [7926] 0
	addi	x31, x0, 0	# [7927] 0.0
	xtof	f1, x31	# [7928] 0.0
	# let dummyf3 = create_array 0 0.0
	add	x31, x3, x4	# [7929] create_array 0 0.0
	beq	x31, x3, 4	# [7930] create_array 0 0.0
	fsw	f1, 0(x3)	# [7931] create_array 0 0.0
	addi	x3, x3, 1	# [7932] create_array 0 0.0
	jal	x0, -3	# [7933] create_array 0 0.0
	addi	x4, x0, 0	# [7934] 0
	lui	x5, 256	# [7935] dummyf3
	addi	x5, x5, 233	# [7936] dummyf3
	# let dummyff3 = create_array 0 dummyf3
	add	x31, x3, x4	# [7937] create_array 0 dummyf3
	beq	x31, x3, 4	# [7938] create_array 0 dummyf3
	sw	x5, 0(x3)	# [7939] create_array 0 dummyf3
	addi	x3, x3, 1	# [7940] create_array 0 dummyf3
	jal	x0, -3	# [7941] create_array 0 dummyf3
	lui	x4, 256	# [7942] dummyf3
	addi	x4, x4, 233	# [7943] dummyf3
	lui	x5, 256	# [7944] dummyff3
	addi	x5, x5, 233	# [7945] dummyff3
	addi	x31, x3, 0	# [7946] dummyf3, dummyff3
	addi	x3, x0, 17	# [7947] dummyf3, dummyff3
	sw	x5, 1(x31)	# [7948] dummyf3, dummyff3
	sw	x4, 0(x31)	# [7949] dummyf3, dummyff3
	# let dummydv = (dummyf3, dummyff3)
	addi	x4, x31, 0	# [7950] dummyf3, dummyff3
	addi	x4, x0, 180	# [7951] 180
	addi	x5, x0, 0	# [7952] 0
	lui	x6, 256	# [7953] dummydv
	addi	x6, x6, 235	# [7954] dummydv
	addi	x31, x0, 0	# [7955] 0.0
	xtof	f1, x31	# [7956] 0.0
	addi	x31, x3, 0	# [7957] 0, dummydv, 0.0
	fsw	f1, 2(x31)	# [7958] 0, dummydv, 0.0
	sw	x6, 1(x31)	# [7959] 0, dummydv, 0.0
	sw	x5, 0(x31)	# [7960] 0, dummydv, 0.0
	addi	x5, x31, 0	# [7961] 0, dummydv, 0.0
	# let reflections = let dummyf3 = create_array 0 0.0 in let dummyff3 = create_array 0 dummyf3 in let dummydv = (dummyf3, dummyff3) in create_array 180 (0, dummydv, 0.0)
	add	x31, x3, x4	# [7962] create_array 180 (0, dummydv, 0.0)
	beq	x31, x3, 4	# [7963] create_array 180 (0, dummydv, 0.0)
	sw	x5, 0(x3)	# [7964] create_array 180 (0, dummydv, 0.0)
	addi	x3, x3, 1	# [7965] create_array 180 (0, dummydv, 0.0)
	jal	x0, -3	# [7966] create_array 180 (0, dummydv, 0.0)
	addi	x4, x0, 1	# [7967] 1
	addi	x5, x0, 0	# [7968] 0
	# let n_reflections = create_array 1 0
	add	x31, x3, x4	# [7969] create_array 1 0
	beq	x31, x3, 4	# [7970] create_array 1 0
	sw	x5, 0(x3)	# [7971] create_array 1 0
	addi	x3, x3, 1	# [7972] create_array 1 0
	jal	x0, -3	# [7973] create_array 1 0
	addi	x4, x0, 128	# [7974] 128
	addi	x5, x0, 128	# [7975] 128
	sw	x1, 0(x2)	# [7976] rt 128 128
	addi	x2, x2, 1	# [7977] rt 128 128
	jal	x1, -485	# [7978] rt 128 128
	addi	x2, x2, -1	# [7979] rt 128 128
	lw	x1, 0(x2)	# [7980] rt 128 128
# program ends
	hlt	# [7981]
