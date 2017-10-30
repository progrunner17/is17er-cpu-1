	.globl _min_caml_start
# read_float.2526:	# let rec read_float _ = 1.2345
	lui	x31, 260576	# 1.2345
	addi	x31, x31, 1067320345	# 1.2345
	mvitof	f1, x31	# 1.2345
	jalr	x0, x1, 0	# 1.2345
# read_int.2528:	# let rec read_int _ = 12345
	lui	x4, 3	# 12345
	addi	x4, x4, 12345	# 12345
	jalr	x0, x1, 0	# 12345
# sgn.2530:	# let rec sgn x = if fiszero x then 0.0 else if fispos x then 1.0 else -1.0
	feq	x4, f1, f0	# fiszero x
	bne	x4, x0, 11	# if fiszero x then 0.0 else if fispos x then 1.0 else -1.0
# beq:	if fispos x then 1.0 else -1.0
	flt	x4, f1, f1	# fispos x
	bne	x4, x0, 5	# if fispos x then 1.0 else -1.0
# beq:	-1.0
	lui	x31, -264192	# -1.0
	addi	x31, x31, -1082130432	# -1.0
	mvitof	f1, x31	# -1.0
	jalr	x0, x1, 0	# -1.0
# bne:	1.0
	lui	x31, 260096	# 1.0
	addi	x31, x31, 1065353216	# 1.0
	mvitof	f1, x31	# 1.0
	jalr	x0, x1, 0	# 1.0
# bne:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
# fneg_cond.2532:	# let rec fneg_cond cond x = if cond then x else fneg x
	bne	x4, x0, 3	# if cond then x else fneg x
# beq:	fneg x
	fneg	f1, f1	# fneg x
	jalr	x0, x1, 0	# fneg x
# bne:	x
	jalr	x0, x1, 0	# x
# add_mod5.2535:	# let rec add_mod5 x y = let sum = x + y in if sum >= 5 then sum - 5 else sum
	# let sum = x + y
	add	x4, x4, x5	# x + y
	addi	x5, x0, 5	# 5
	bge	x4, x5, 2	# if sum >= 5 then sum - 5 else sum
# blt:	sum
	jalr	x0, x1, 0	# sum
# bge:	sum - 5
	addi	x4, x4, -5	# sum - 5
	jalr	x0, x1, 0	# sum - 5
# vecset.2538:	# let rec vecset v x y z = v.(0) <- x; v.(1) <- y; v.(2) <- z
	fsw	f1, 0(x4)	# v.(0) <- x
	fsw	f2, 1(x4)	# v.(1) <- y
	fsw	f3, 2(x4)	# v.(2) <- z
	jalr x0, x1, 0	# v.(2) <- z
# vecfill.2543:	# let rec vecfill v elem = v.(0) <- elem; v.(1) <- elem; v.(2) <- elem
	fsw	f1, 0(x4)	# v.(0) <- elem
	fsw	f1, 1(x4)	# v.(1) <- elem
	fsw	f1, 2(x4)	# v.(2) <- elem
	jalr x0, x1, 0	# v.(2) <- elem
# vecbzero.2546:	# let rec vecbzero v = vecfill v 0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jal	x0, -6	# vecfill v 0.0
# veccpy.2548:	# let rec veccpy dest src = dest.(0) <- src.(0); dest.(1) <- src.(1); dest.(2) <- src.(2)
	flw	f1, 0(x5)	# src.(0)
	fsw	f1, 0(x4)	# dest.(0) <- src.(0)
	flw	f1, 1(x5)	# src.(1)
	fsw	f1, 1(x4)	# dest.(1) <- src.(1)
	flw	f1, 2(x5)	# src.(2)
	fsw	f1, 2(x4)	# dest.(2) <- src.(2)
	jalr x0, x1, 0	# dest.(2) <- src.(2)
# vecunit_sgn.2556:	# let rec vecunit_sgn v inv = let l = sqrt (fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2)) in let il = if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l in v.(0) <- v.(0) *. il; v.(1) <- v.(1) *. il; v.(2) <- v.(2) *. il
	flw	f1, 0(x4)	# v.(0)
	fmul	f1, f1, f1	# fsqr v.(0)
	flw	f2, 1(x4)	# v.(1)
	fmul	f2, f2, f2	# fsqr v.(1)
	fadd	f1, f1, f2	# fsqr v.(0) +. fsqr v.(1)
	flw	f2, 2(x4)	# v.(2)
	fmul	f2, f2, f2	# fsqr v.(2)
	fadd	f1, f1, f2	# fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2)
	# let l = sqrt (fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2))
	fsqrt	f1, f1	# sqrt (fsqr v.(0) +. fsqr v.(1) +. fsqr v.(2))
	feq	x6, f1, f0	# fiszero l
	# let il = if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
	bne	x6, x0, 10	# if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
# beq:	if inv then -1.0 /. l else 1.0 /. l
	bne	x5, x0, 3	# if inv then -1.0 /. l else 1.0 /. l
# beq:	1.0 /. l
	fdiv	f1, f11, f1	# 1.0 /. l
	jalr	x0, x1, 0	# 1.0 /. l
# bne:	-1.0 /. l
	lui	x31, -264192	# -1.0
	addi	x31, x31, -1082130432	# -1.0
	mvitof	f2, x31	# -1.0
	fdiv	f1, f2, f1	# -1.0 /. l
	jalr	x0, x1, 0	# -1.0 /. l
	jal	x0, 5	# if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
# bne:	1.0
	lui	x31, 260096	# 1.0
	addi	x31, x31, 1065353216	# 1.0
	mvitof	f1, x31	# 1.0
	jalr	x0, x1, 0	# 1.0
# cont:	if fiszero l then 1.0 else if inv then -1.0 /. l else 1.0 /. l
	flw	f2, 0(x4)	# v.(0)
	fmul	f2, f2, f1	# v.(0) *. il
	fsw	f2, 0(x4)	# v.(0) <- v.(0) *. il
	flw	f2, 1(x4)	# v.(1)
	fmul	f2, f2, f1	# v.(1) *. il
	fsw	f2, 1(x4)	# v.(1) <- v.(1) *. il
	flw	f2, 2(x4)	# v.(2)
	fmul	f1, f2, f1	# v.(2) *. il
	fsw	f1, 2(x4)	# v.(2) <- v.(2) *. il
	jalr x0, x1, 0	# v.(2) <- v.(2) *. il
# veciprod.2559:	# let rec veciprod v w = v.(0) *. w.(0) +. v.(1) *. w.(1) +. v.(2) *. w.(2)
	flw	f1, 0(x4)	# v.(0)
	flw	f2, 0(x5)	# w.(0)
	fmul	f1, f1, f2	# v.(0) *. w.(0)
	flw	f2, 1(x4)	# v.(1)
	flw	f3, 1(x5)	# w.(1)
	fmul	f2, f2, f3	# v.(1) *. w.(1)
	fadd	f1, f1, f2	# v.(0) *. w.(0) +. v.(1) *. w.(1)
	flw	f2, 2(x4)	# v.(2)
	flw	f3, 2(x5)	# w.(2)
	fmul	f2, f2, f3	# v.(2) *. w.(2)
	fadd	f1, f1, f2	# v.(0) *. w.(0) +. v.(1) *. w.(1) +. v.(2) *. w.(2)
	jalr	x0, x1, 0	# v.(0) *. w.(0) +. v.(1) *. w.(1) +. v.(2) *. w.(2)
# veciprod2.2562:	# let rec veciprod2 v w0 w1 w2 = v.(0) *. w0 +. v.(1) *. w1 +. v.(2) *. w2
	flw	f4, 0(x4)	# v.(0)
	fmul	f1, f4, f1	# v.(0) *. w0
	flw	f4, 1(x4)	# v.(1)
	fmul	f2, f4, f2	# v.(1) *. w1
	fadd	f1, f1, f2	# v.(0) *. w0 +. v.(1) *. w1
	flw	f2, 2(x4)	# v.(2)
	fmul	f2, f2, f3	# v.(2) *. w2
	fadd	f1, f1, f2	# v.(0) *. w0 +. v.(1) *. w1 +. v.(2) *. w2
	jalr	x0, x1, 0	# v.(0) *. w0 +. v.(1) *. w1 +. v.(2) *. w2
# vecaccum.2567:	# let rec vecaccum dest scale v = dest.(0) <- dest.(0) +. scale *. v.(0); dest.(1) <- dest.(1) +. scale *. v.(1); dest.(2) <- dest.(2) +. scale *. v.(2)
	flw	f2, 0(x4)	# dest.(0)
	flw	f3, 0(x5)	# v.(0)
	fmul	f3, f1, f3	# scale *. v.(0)
	fadd	f2, f2, f3	# dest.(0) +. scale *. v.(0)
	fsw	f2, 0(x4)	# dest.(0) <- dest.(0) +. scale *. v.(0)
	flw	f2, 1(x4)	# dest.(1)
	flw	f3, 1(x5)	# v.(1)
	fmul	f3, f1, f3	# scale *. v.(1)
	fadd	f2, f2, f3	# dest.(1) +. scale *. v.(1)
	fsw	f2, 1(x4)	# dest.(1) <- dest.(1) +. scale *. v.(1)
	flw	f2, 2(x4)	# dest.(2)
	flw	f3, 2(x5)	# v.(2)
	fmul	f1, f1, f3	# scale *. v.(2)
	fadd	f1, f2, f1	# dest.(2) +. scale *. v.(2)
	fsw	f1, 2(x4)	# dest.(2) <- dest.(2) +. scale *. v.(2)
	jalr x0, x1, 0	# dest.(2) <- dest.(2) +. scale *. v.(2)
# vecadd.2571:	# let rec vecadd dest v = dest.(0) <- dest.(0) +. v.(0); dest.(1) <- dest.(1) +. v.(1); dest.(2) <- dest.(2) +. v.(2)
	flw	f1, 0(x4)	# dest.(0)
	flw	f2, 0(x5)	# v.(0)
	fadd	f1, f1, f2	# dest.(0) +. v.(0)
	fsw	f1, 0(x4)	# dest.(0) <- dest.(0) +. v.(0)
	flw	f1, 1(x4)	# dest.(1)
	flw	f2, 1(x5)	# v.(1)
	fadd	f1, f1, f2	# dest.(1) +. v.(1)
	fsw	f1, 1(x4)	# dest.(1) <- dest.(1) +. v.(1)
	flw	f1, 2(x4)	# dest.(2)
	flw	f2, 2(x5)	# v.(2)
	fadd	f1, f1, f2	# dest.(2) +. v.(2)
	fsw	f1, 2(x4)	# dest.(2) <- dest.(2) +. v.(2)
	jalr x0, x1, 0	# dest.(2) <- dest.(2) +. v.(2)
# vecscale.2577:	# let rec vecscale dest scale = dest.(0) <- dest.(0) *. scale; dest.(1) <- dest.(1) *. scale; dest.(2) <- dest.(2) *. scale
	flw	f2, 0(x4)	# dest.(0)
	fmul	f2, f2, f1	# dest.(0) *. scale
	fsw	f2, 0(x4)	# dest.(0) <- dest.(0) *. scale
	flw	f2, 1(x4)	# dest.(1)
	fmul	f2, f2, f1	# dest.(1) *. scale
	fsw	f2, 1(x4)	# dest.(1) <- dest.(1) *. scale
	flw	f2, 2(x4)	# dest.(2)
	fmul	f1, f2, f1	# dest.(2) *. scale
	fsw	f1, 2(x4)	# dest.(2) <- dest.(2) *. scale
	jalr x0, x1, 0	# dest.(2) <- dest.(2) *. scale
# vecaccumv.2580:	# let rec vecaccumv dest v w = dest.(0) <- dest.(0) +. v.(0) *. w.(0); dest.(1) <- dest.(1) +. v.(1) *. w.(1); dest.(2) <- dest.(2) +. v.(2) *. w.(2)
	flw	f1, 0(x4)	# dest.(0)
	flw	f2, 0(x5)	# v.(0)
	flw	f3, 0(x6)	# w.(0)
	fmul	f2, f2, f3	# v.(0) *. w.(0)
	fadd	f1, f1, f2	# dest.(0) +. v.(0) *. w.(0)
	fsw	f1, 0(x4)	# dest.(0) <- dest.(0) +. v.(0) *. w.(0)
	flw	f1, 1(x4)	# dest.(1)
	flw	f2, 1(x5)	# v.(1)
	flw	f3, 1(x6)	# w.(1)
	fmul	f2, f2, f3	# v.(1) *. w.(1)
	fadd	f1, f1, f2	# dest.(1) +. v.(1) *. w.(1)
	fsw	f1, 1(x4)	# dest.(1) <- dest.(1) +. v.(1) *. w.(1)
	flw	f1, 2(x4)	# dest.(2)
	flw	f2, 2(x5)	# v.(2)
	flw	f3, 2(x6)	# w.(2)
	fmul	f2, f2, f3	# v.(2) *. w.(2)
	fadd	f1, f1, f2	# dest.(2) +. v.(2) *. w.(2)
	fsw	f1, 2(x4)	# dest.(2) <- dest.(2) +. v.(2) *. w.(2)
	jalr x0, x1, 0	# dest.(2) <- dest.(2) +. v.(2) *. w.(2)
# o_texturetype.2584:	# let rec o_texturetype m = let (m_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_tex
	# let (m_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 0(x4)	# let (m_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# m_tex
# o_form.2586:	# let rec o_form m = let (xm_tex, m_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_shape
	# let (xm_tex, m_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 1(x4)	# let (xm_tex, m_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# m_shape
# o_reflectiontype.2588:	# let rec o_reflectiontype m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_surface
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 2(x4)	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# m_surface
# o_isinvert.2590:	# let rec o_isinvert m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, m_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_invert
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, m_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 6(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, m_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# m_invert
# o_isrot.2592:	# let rec o_isrot m = let (xm_tex, xm_shape, xm_surface, m_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_isrot
	# let (xm_tex, xm_shape, xm_surface, m_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 3(x4)	# let (xm_tex, xm_shape, xm_surface, m_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# m_isrot
# o_param_a.2594:	# let rec o_param_a m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# m_abc.(0)
	jalr	x0, x1, 0	# m_abc.(0)
# o_param_b.2596:	# let rec o_param_b m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# m_abc.(1)
	jalr	x0, x1, 0	# m_abc.(1)
# o_param_c.2598:	# let rec o_param_c m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc.(2)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# m_abc.(2)
	jalr	x0, x1, 0	# m_abc.(2)
# o_param_abc.2600:	# let rec o_param_abc m = let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_abc
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 4(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, m_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	jalr	x0, x1, 0	# m_abc
# o_param_x.2602:	# let rec o_param_x m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_xyz.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 5(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# m_xyz.(0)
	jalr	x0, x1, 0	# m_xyz.(0)
# o_param_y.2604:	# let rec o_param_y m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_xyz.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 5(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# m_xyz.(1)
	jalr	x0, x1, 0	# m_xyz.(1)
# o_param_z.2606:	# let rec o_param_z m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_xyz.(2)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 5(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, m_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# m_xyz.(2)
	jalr	x0, x1, 0	# m_xyz.(2)
# o_diffuse.2608:	# let rec o_diffuse m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_surfparams.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 7(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# m_surfparams.(0)
	jalr	x0, x1, 0	# m_surfparams.(0)
# o_hilight.2610:	# let rec o_hilight m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m in m_surfparams.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	lw	x4, 7(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, m_surfparams, xm_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# m_surfparams.(1)
	jalr	x0, x1, 0	# m_surfparams.(1)
# o_color_red.2612:	# let rec o_color_red m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m in m_color.(0)
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	lw	x4, 8(x4)	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# m_color.(0)
	jalr	x0, x1, 0	# m_color.(0)
# o_color_green.2614:	# let rec o_color_green m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m in m_color.(1)
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	lw	x4, 8(x4)	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# m_color.(1)
	jalr	x0, x1, 0	# m_color.(1)
# o_color_blue.2616:	# let rec o_color_blue m = let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m in m_color.(2)
	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	lw	x4, 8(x4)	# let (xm_tex, xm_shape, m_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, m_color, xm_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# m_color.(2)
	jalr	x0, x1, 0	# m_color.(2)
# o_param_r1.2618:	# let rec o_param_r1 m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m in m_rot123.(0)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	lw	x4, 9(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	flw	f1, 0(x4)	# m_rot123.(0)
	jalr	x0, x1, 0	# m_rot123.(0)
# o_param_r2.2620:	# let rec o_param_r2 m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m in m_rot123.(1)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	lw	x4, 9(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	flw	f1, 1(x4)	# m_rot123.(1)
	jalr	x0, x1, 0	# m_rot123.(1)
# o_param_r3.2622:	# let rec o_param_r3 m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m in m_rot123.(2)
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	lw	x4, 9(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, m_rot123, xm_ctbl) = m
	flw	f1, 2(x4)	# m_rot123.(2)
	jalr	x0, x1, 0	# m_rot123.(2)
# o_param_ctbl.2624:	# let rec o_param_ctbl m = let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, m_ctbl) = m in m_ctbl
	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, m_ctbl) = m
	lw	x4, 10(x4)	# let (xm_tex, xm_shape, xm_surface, xm_isrot, xm_abc, xm_xyz, xm_invert, xm_surfparams, xm_color, xm_rot123, m_ctbl) = m
	jalr	x0, x1, 0	# m_ctbl
# p_rgb.2626:	# let rec p_rgb pixel = let (m_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_rgb
	# let (m_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 0(x4)	# let (m_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# m_rgb
# p_intersection_points.2628:	# let rec p_intersection_points pixel = let (xm_rgb, m_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_isect_ps
	# let (xm_rgb, m_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 1(x4)	# let (xm_rgb, m_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# m_isect_ps
# p_surface_ids.2630:	# let rec p_surface_ids pixel = let (xm_rgb, xm_isect_ps, m_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_sids
	# let (xm_rgb, xm_isect_ps, m_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 2(x4)	# let (xm_rgb, xm_isect_ps, m_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# m_sids
# p_calc_diffuse.2632:	# let rec p_calc_diffuse pixel = let (xm_rgb, xm_isect_ps, xm_sids, m_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_cdif
	# let (xm_rgb, xm_isect_ps, xm_sids, m_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 3(x4)	# let (xm_rgb, xm_isect_ps, xm_sids, m_cdif, xm_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# m_cdif
# p_energy.2634:	# let rec p_energy pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, m_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel in m_engy
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, m_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 4(x4)	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, m_engy, xm_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# m_engy
# p_received_ray_20percent.2636:	# let rec p_received_ray_20percent pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, m_r20p, xm_gid, xm_nvectors ) = pixel in m_r20p
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, m_r20p, xm_gid, xm_nvectors ) = pixel
	lw	x4, 5(x4)	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, m_r20p, xm_gid, xm_nvectors ) = pixel
	jalr	x0, x1, 0	# m_r20p
# p_group_id.2638:	# let rec p_group_id pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel in m_gid.(0)
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	lw	x4, 6(x4)	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	lw	x4, 0(x4)	# m_gid.(0)
	jalr	x0, x1, 0	# m_gid.(0)
# p_set_group_id.2640:	# let rec p_set_group_id pixel id = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel in m_gid.(0) <- id
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	lw	x4, 6(x4)	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, m_gid, xm_nvectors ) = pixel
	sw	x5, 0(x4)	# m_gid.(0) <- id
	jalr x0, x1, 0	# m_gid.(0) <- id
# p_nvectors.2643:	# let rec p_nvectors pixel = let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, m_nvectors ) = pixel in m_nvectors
	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, m_nvectors ) = pixel
	lw	x4, 7(x4)	# let (xm_rgb, xm_isect_ps, xm_sids, xm_cdif, xm_engy, xm_r20p, xm_gid, m_nvectors ) = pixel
	jalr	x0, x1, 0	# m_nvectors
# d_vec.2645:	# let rec d_vec d = let (m_vec, xm_const) = d in m_vec
	# let (m_vec, xm_const) = d
	lw	x4, 0(x4)	# let (m_vec, xm_const) = d
	jalr	x0, x1, 0	# m_vec
# d_const.2647:	# let rec d_const d = let (dm_vec, m_const) = d in m_const
	# let (dm_vec, m_const) = d
	lw	x4, 1(x4)	# let (dm_vec, m_const) = d
	jalr	x0, x1, 0	# m_const
# r_surface_id.2649:	# let rec r_surface_id r = let (m_sid, xm_dvec, xm_br) = r in m_sid
	# let (m_sid, xm_dvec, xm_br) = r
	lw	x4, 0(x4)	# let (m_sid, xm_dvec, xm_br) = r
	jalr	x0, x1, 0	# m_sid
# r_dvec.2651:	# let rec r_dvec r = let (xm_sid, m_dvec, xm_br) = r in m_dvec
	# let (xm_sid, m_dvec, xm_br) = r
	lw	x4, 1(x4)	# let (xm_sid, m_dvec, xm_br) = r
	jalr	x0, x1, 0	# m_dvec
# r_bright.2653:	# let rec r_bright r = let (xm_sid, xm_dvec, m_br) = r in m_br
	# let (xm_sid, xm_dvec, m_br) = r
	flw	f1, 2(x4)	# let (xm_sid, xm_dvec, m_br) = r
	jalr	x0, x1, 0	# m_br
# rad.2655:	# let rec rad x = x *. 0.017453293
	lui	x31, 248048	# 0.017453293
	addi	x31, x31, 1016003125	# 0.017453293
	mvitof	f2, x31	# 0.017453293
	fmul	f1, f1, f2	# x *. 0.017453293
	jalr	x0, x1, 0	# x *. 0.017453293
# read_screen_settings.2657:	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x4, 8(x29)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x5, 7(x29)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x6, 6(x29)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x7, 5(x29)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x8, 4(x29)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	sw	x4, 0(x2)	# read_float ()
	sw	x6, 1(x2)	# read_float ()
	sw	x7, 2(x2)	# read_float ()
	sw	x5, 3(x2)	# read_float ()
	sw	x8, 4(x2)	# read_float ()
	sw	x1, 5(x2)	# read_float ()
	addi	x2, x2, 6	# read_float ()
	jal	x0, -269	# read_float ()
	subi	x2, x2, 6	# read_float ()
	lw	x1, 5(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 4(x2)	# screen.(0) <- read_float ()
	fsw	f1, 0(x4)	# screen.(0) <- read_float ()
	sw	x1, 5(x2)	# read_float ()
	addi	x2, x2, 6	# read_float ()
	jal	x0, -277	# read_float ()
	subi	x2, x2, 6	# read_float ()
	lw	x1, 5(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 4(x2)	# screen.(1) <- read_float ()
	fsw	f1, 1(x4)	# screen.(1) <- read_float ()
	sw	x1, 5(x2)	# read_float ()
	addi	x2, x2, 6	# read_float ()
	jal	x0, -285	# read_float ()
	subi	x2, x2, 6	# read_float ()
	lw	x1, 5(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 4(x2)	# screen.(2) <- read_float ()
	fsw	f1, 2(x4)	# screen.(2) <- read_float ()
	sw	x1, 5(x2)	# read_float ()
	addi	x2, x2, 6	# read_float ()
	jal	x0, -293	# read_float ()
	subi	x2, x2, 6	# read_float ()
	lw	x1, 5(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	# let v1 = rad (read_float ())
	sw	x1, 5(x2)	# rad (read_float ())
	addi	x2, x2, 6	# rad (read_float ())
	jal	x0, -50	# rad (read_float ())
	subi	x2, x2, 6	# rad (read_float ())
	lw	x1, 5(x2)	# rad (read_float ())
	fmr	f1, f1	# rad (read_float ())
	# let cos_v1 = cos v1
	cos	f2, f1	# cos v1
	# let sin_v1 = sin v1
	sin	f1, f1	# sin v1
	fsw	f1, 5(x2)	# read_float ()
	fsw	f2, 6(x2)	# read_float ()
	sw	x1, 7(x2)	# read_float ()
	addi	x2, x2, 8	# read_float ()
	jal	x0, -309	# read_float ()
	subi	x2, x2, 8	# read_float ()
	lw	x1, 7(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	# let v2 = rad (read_float ())
	sw	x1, 7(x2)	# rad (read_float ())
	addi	x2, x2, 8	# rad (read_float ())
	jal	x0, -66	# rad (read_float ())
	subi	x2, x2, 8	# rad (read_float ())
	lw	x1, 7(x2)	# rad (read_float ())
	fmr	f1, f1	# rad (read_float ())
	# let cos_v2 = cos v2
	cos	f2, f1	# cos v2
	# let sin_v2 = sin v2
	sin	f1, f1	# sin v2
	flw	f3, 6(x2)	# cos_v1 *. sin_v2
	fmul	f4, f3, f1	# cos_v1 *. sin_v2
	fmul	f4, f4, f18	# cos_v1 *. sin_v2 *. 200.0
	lw	x4, 3(x2)	# screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0
	fsw	f4, 0(x4)	# screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0
	lui	x31, -248704	# -200.0
	addi	x31, x31, -1018691584	# -200.0
	mvitof	f4, x31	# -200.0
	flw	f5, 5(x2)	# sin_v1 *. -200.0
	fmul	f4, f5, f4	# sin_v1 *. -200.0
	fsw	f4, 1(x4)	# screenz_dir.(1) <- sin_v1 *. -200.0
	fmul	f4, f3, f2	# cos_v1 *. cos_v2
	fmul	f4, f4, f18	# cos_v1 *. cos_v2 *. 200.0
	fsw	f4, 2(x4)	# screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0
	lw	x5, 2(x2)	# screenx_dir.(0) <- cos_v2
	fsw	f2, 0(x5)	# screenx_dir.(0) <- cos_v2
	addi	x31, x0, 0	# 0.0
	mvitof	f4, x31	# 0.0
	fsw	f4, 1(x5)	# screenx_dir.(1) <- 0.0
	fneg	f4, f1	# fneg sin_v2
	fsw	f4, 2(x5)	# screenx_dir.(2) <- fneg sin_v2
	fneg	f4, f5	# fneg sin_v1
	fmul	f1, f4, f1	# fneg sin_v1 *. sin_v2
	lw	x5, 1(x2)	# screeny_dir.(0) <- fneg sin_v1 *. sin_v2
	fsw	f1, 0(x5)	# screeny_dir.(0) <- fneg sin_v1 *. sin_v2
	fneg	f1, f3	# fneg cos_v1
	fsw	f1, 1(x5)	# screeny_dir.(1) <- fneg cos_v1
	fneg	f1, f5	# fneg sin_v1
	fmul	f1, f1, f2	# fneg sin_v1 *. cos_v2
	fsw	f1, 2(x5)	# screeny_dir.(2) <- fneg sin_v1 *. cos_v2
	lw	x5, 4(x2)	# screen.(0)
	flw	f1, 0(x5)	# screen.(0)
	flw	f2, 0(x4)	# screenz_dir.(0)
	fsub	f1, f1, f2	# screen.(0) -. screenz_dir.(0)
	lw	x6, 0(x2)	# viewpoint.(0) <- screen.(0) -. screenz_dir.(0)
	fsw	f1, 0(x6)	# viewpoint.(0) <- screen.(0) -. screenz_dir.(0)
	flw	f1, 1(x5)	# screen.(1)
	flw	f2, 1(x4)	# screenz_dir.(1)
	fsub	f1, f1, f2	# screen.(1) -. screenz_dir.(1)
	fsw	f1, 1(x6)	# viewpoint.(1) <- screen.(1) -. screenz_dir.(1)
	flw	f1, 2(x5)	# screen.(2)
	flw	f2, 2(x4)	# screenz_dir.(2)
	fsub	f1, f1, f2	# screen.(2) -. screenz_dir.(2)
	fsw	f1, 2(x6)	# viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	jalr x0, x1, 0	# viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
# read_light.2659:	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	lw	x4, 5(x29)	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	lw	x5, 4(x29)	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	sw	x5, 0(x2)	# read_float ()
	sw	x4, 1(x2)	# read_float ()
	sw	x1, 2(x2)	# read_float ()
	addi	x2, x2, 3	# read_float ()
	jal	x0, -372	# read_float ()
	subi	x2, x2, 3	# read_float ()
	lw	x1, 2(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	# let l1 = rad (read_float ())
	sw	x1, 2(x2)	# rad (read_float ())
	addi	x2, x2, 3	# rad (read_float ())
	jal	x0, -129	# rad (read_float ())
	subi	x2, x2, 3	# rad (read_float ())
	lw	x1, 2(x2)	# rad (read_float ())
	fmr	f1, f1	# rad (read_float ())
	# let sl1 = sin l1
	sin	f2, f1	# sin l1
	fneg	f2, f2	# fneg sl1
	lw	x4, 1(x2)	# light.(1) <- fneg sl1
	fsw	f2, 1(x4)	# light.(1) <- fneg sl1
	fsw	f1, 2(x2)	# read_float ()
	sw	x1, 3(x2)	# read_float ()
	addi	x2, x2, 4	# read_float ()
	jal	x0, -389	# read_float ()
	subi	x2, x2, 4	# read_float ()
	lw	x1, 3(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	# let l2 = rad (read_float ())
	sw	x1, 3(x2)	# rad (read_float ())
	addi	x2, x2, 4	# rad (read_float ())
	jal	x0, -146	# rad (read_float ())
	subi	x2, x2, 4	# rad (read_float ())
	lw	x1, 3(x2)	# rad (read_float ())
	fmr	f1, f1	# rad (read_float ())
	flw	f2, 2(x2)	# cos l1
	# let cl1 = cos l1
	cos	f2, f2	# cos l1
	# let sl2 = sin l2
	sin	f3, f1	# sin l2
	fmul	f3, f2, f3	# cl1 *. sl2
	lw	x4, 1(x2)	# light.(0) <- cl1 *. sl2
	fsw	f3, 0(x4)	# light.(0) <- cl1 *. sl2
	# let cl2 = cos l2
	cos	f1, f1	# cos l2
	fmul	f1, f2, f1	# cl1 *. cl2
	fsw	f1, 2(x4)	# light.(2) <- cl1 *. cl2
	sw	x1, 3(x2)	# read_float ()
	addi	x2, x2, 4	# read_float ()
	jal	x0, -410	# read_float ()
	subi	x2, x2, 4	# read_float ()
	lw	x1, 3(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 0(x2)	# beam.(0) <- read_float ()
	fsw	f1, 0(x4)	# beam.(0) <- read_float ()
	jalr x0, x1, 0	# beam.(0) <- read_float ()
# rotate_quadratic_matrix.2661:	# let rec rotate_quadratic_matrix abc rot = let cos_x = cos rot.(0) in let sin_x = sin rot.(0) in let cos_y = cos rot.(1) in let sin_y = sin rot.(1) in let cos_z = cos rot.(2) in let sin_z = sin rot.(2) in let m00 = cos_y *. cos_z in let m01 = sin_x *. sin_y *. cos_z -. cos_x *. sin_z in let m02 = cos_x *. sin_y *. cos_z +. sin_x *. sin_z in let m10 = cos_y *. sin_z in let m11 = sin_x *. sin_y *. sin_z +. cos_x *. cos_z in let m12 = cos_x *. sin_y *. sin_z -. sin_x *. cos_z in let m20 = fneg sin_y in let m21 = sin_x *. cos_y in let m22 = cos_x *. cos_y in let ao = abc.(0) in let bo = abc.(1) in let co = abc.(2) in abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	flw	f1, 0(x5)	# rot.(0)
	# let cos_x = cos rot.(0)
	cos	f1, f1	# cos rot.(0)
	flw	f2, 0(x5)	# rot.(0)
	# let sin_x = sin rot.(0)
	sin	f2, f2	# sin rot.(0)
	flw	f3, 1(x5)	# rot.(1)
	# let cos_y = cos rot.(1)
	cos	f3, f3	# cos rot.(1)
	flw	f4, 1(x5)	# rot.(1)
	# let sin_y = sin rot.(1)
	sin	f4, f4	# sin rot.(1)
	flw	f5, 2(x5)	# rot.(2)
	# let cos_z = cos rot.(2)
	cos	f5, f5	# cos rot.(2)
	flw	f6, 2(x5)	# rot.(2)
	# let sin_z = sin rot.(2)
	sin	f6, f6	# sin rot.(2)
	# let m00 = cos_y *. cos_z
	fmul	f7, f3, f5	# cos_y *. cos_z
	fmul	f8, f2, f4	# sin_x *. sin_y
	fmul	f8, f8, f5	# sin_x *. sin_y *. cos_z
	fmul	f9, f1, f6	# cos_x *. sin_z
	# let m01 = sin_x *. sin_y *. cos_z -. cos_x *. sin_z
	fsub	f8, f8, f9	# sin_x *. sin_y *. cos_z -. cos_x *. sin_z
	fmul	f9, f1, f4	# cos_x *. sin_y
	fmul	f9, f9, f5	# cos_x *. sin_y *. cos_z
	fmul	f10, f2, f6	# sin_x *. sin_z
	# let m02 = cos_x *. sin_y *. cos_z +. sin_x *. sin_z
	fadd	f9, f9, f10	# cos_x *. sin_y *. cos_z +. sin_x *. sin_z
	# let m10 = cos_y *. sin_z
	fmul	f10, f3, f6	# cos_y *. sin_z
	fmul	f30, f2, f4	# sin_x *. sin_y
	fmul	f30, f30, f6	# sin_x *. sin_y *. sin_z
	fsw	f9, 0(x2)	# let m11 = sin_x *. sin_y *. sin_z +. cos_x *. cos_z in let m12 = cos_x *. sin_y *. sin_z -. sin_x *. cos_z in let m20 = fneg sin_y in let m21 = sin_x *. cos_y in let m22 = cos_x *. cos_y in let ao = abc.(0) in let bo = abc.(1) in let co = abc.(2) in abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f9, f1, f5	# cos_x *. cos_z
	# let m11 = sin_x *. sin_y *. sin_z +. cos_x *. cos_z
	fadd	f9, f30, f9	# sin_x *. sin_y *. sin_z +. cos_x *. cos_z
	fmul	f30, f1, f4	# cos_x *. sin_y
	fmul	f6, f30, f6	# cos_x *. sin_y *. sin_z
	fmul	f5, f2, f5	# sin_x *. cos_z
	# let m12 = cos_x *. sin_y *. sin_z -. sin_x *. cos_z
	fsub	f5, f6, f5	# cos_x *. sin_y *. sin_z -. sin_x *. cos_z
	# let m20 = fneg sin_y
	fneg	f4, f4	# fneg sin_y
	# let m21 = sin_x *. cos_y
	fmul	f2, f2, f3	# sin_x *. cos_y
	# let m22 = cos_x *. cos_y
	fmul	f1, f1, f3	# cos_x *. cos_y
	# let ao = abc.(0)
	flw	f3, 0(x4)	# abc.(0)
	# let bo = abc.(1)
	flw	f6, 1(x4)	# abc.(1)
	# let co = abc.(2)
	flw	f30, 2(x4)	# abc.(2)
	fsw	f7, 1(x2)	# abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f7, f7, f7	# fsqr m00
	fmul	f7, f3, f7	# ao *. fsqr m00
	fsw	f10, 2(x2)	# abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20; abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21; abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f10, f10, f10	# fsqr m10
	fmul	f10, f6, f10	# bo *. fsqr m10
	fadd	f7, f7, f10	# ao *. fsqr m00 +. bo *. fsqr m10
	fmul	f10, f4, f4	# fsqr m20
	fmul	f10, f30, f10	# co *. fsqr m20
	fadd	f7, f7, f10	# ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20
	fsw	f7, 0(x4)	# abc.(0) <- ao *. fsqr m00 +. bo *. fsqr m10 +. co *. fsqr m20
	fmul	f7, f8, f8	# fsqr m01
	fmul	f7, f3, f7	# ao *. fsqr m01
	fmul	f10, f9, f9	# fsqr m11
	fmul	f10, f6, f10	# bo *. fsqr m11
	fadd	f7, f7, f10	# ao *. fsqr m01 +. bo *. fsqr m11
	fmul	f10, f2, f2	# fsqr m21
	fmul	f10, f30, f10	# co *. fsqr m21
	fadd	f7, f7, f10	# ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21
	fsw	f7, 1(x4)	# abc.(1) <- ao *. fsqr m01 +. bo *. fsqr m11 +. co *. fsqr m21
	flw	f7, 0(x2)	# fsqr m02
	fmul	f10, f7, f7	# fsqr m02
	fmul	f10, f3, f10	# ao *. fsqr m02
	fsw	f4, 3(x2)	# abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22; rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22); rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fmul	f4, f5, f5	# fsqr m12
	fmul	f4, f6, f4	# bo *. fsqr m12
	fadd	f4, f10, f4	# ao *. fsqr m02 +. bo *. fsqr m12
	fmul	f10, f1, f1	# fsqr m22
	fmul	f10, f30, f10	# co *. fsqr m22
	fadd	f4, f4, f10	# ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22
	fsw	f4, 2(x4)	# abc.(2) <- ao *. fsqr m02 +. bo *. fsqr m12 +. co *. fsqr m22
	fmul	f4, f3, f8	# ao *. m01
	fmul	f4, f4, f7	# ao *. m01 *. m02
	fmul	f10, f6, f9	# bo *. m11
	fmul	f10, f10, f5	# bo *. m11 *. m12
	fadd	f4, f4, f10	# ao *. m01 *. m02 +. bo *. m11 *. m12
	fmul	f10, f30, f2	# co *. m21
	fmul	f10, f10, f1	# co *. m21 *. m22
	fadd	f4, f4, f10	# ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22
	fmul	f4, f12, f4	# 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22)
	fsw	f4, 0(x5)	# rot.(0) <- 2.0 *. (ao *. m01 *. m02 +. bo *. m11 *. m12 +. co *. m21 *. m22)
	flw	f4, 1(x2)	# ao *. m00
	fmul	f10, f3, f4	# ao *. m00
	fmul	f7, f10, f7	# ao *. m00 *. m02
	fsw	f2, 4(x2)	# rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22); rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	flw	f10, 2(x2)	# bo *. m10
	fmul	f2, f6, f10	# bo *. m10
	fmul	f2, f2, f5	# bo *. m10 *. m12
	fadd	f2, f7, f2	# ao *. m00 *. m02 +. bo *. m10 *. m12
	flw	f5, 3(x2)	# co *. m20
	fmul	f7, f30, f5	# co *. m20
	fmul	f1, f7, f1	# co *. m20 *. m22
	fadd	f1, f2, f1	# ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22
	fmul	f1, f12, f1	# 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22)
	fsw	f1, 1(x5)	# rot.(1) <- 2.0 *. (ao *. m00 *. m02 +. bo *. m10 *. m12 +. co *. m20 *. m22)
	fmul	f1, f3, f4	# ao *. m00
	fmul	f1, f1, f8	# ao *. m00 *. m01
	fmul	f2, f6, f10	# bo *. m10
	fmul	f2, f2, f9	# bo *. m10 *. m11
	fadd	f1, f1, f2	# ao *. m00 *. m01 +. bo *. m10 *. m11
	fmul	f2, f30, f5	# co *. m20
	flw	f3, 4(x2)	# co *. m20 *. m21
	fmul	f2, f2, f3	# co *. m20 *. m21
	fadd	f1, f1, f2	# ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21
	fmul	f1, f12, f1	# 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	fsw	f1, 2(x5)	# rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
	jalr x0, x1, 0	# rot.(2) <- 2.0 *. (ao *. m00 *. m01 +. bo *. m10 *. m11 +. co *. m20 *. m21)
# read_nth_object.2664:	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	lw	x5, 4(x29)	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	sw	x4, 0(x2)	# read_int ()
	sw	x5, 1(x2)	# read_int ()
	# let texture = read_int ()
	sw	x1, 2(x2)	# read_int ()
	addi	x2, x2, 3	# read_int ()
	jal	x0, -522	# read_int ()
	subi	x2, x2, 3	# read_int ()
	lw	x1, 2(x2)	# read_int ()
	addi	x4, x4, 0	# read_int ()
	addi	x5, x0, -1	# -1
	bne	x4, x5, 3	# if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true
	sw	x4, 2(x2)	# read_int ()
	# let form = read_int ()
	sw	x1, 3(x2)	# read_int ()
	addi	x2, x2, 4	# read_int ()
	jal	x0, -533	# read_int ()
	subi	x2, x2, 4	# read_int ()
	lw	x1, 3(x2)	# read_int ()
	addi	x4, x4, 0	# read_int ()
	sw	x4, 3(x2)	# read_int ()
	# let refltype = read_int ()
	sw	x1, 4(x2)	# read_int ()
	addi	x2, x2, 5	# read_int ()
	jal	x0, -540	# read_int ()
	subi	x2, x2, 5	# read_int ()
	lw	x1, 4(x2)	# read_int ()
	addi	x4, x4, 0	# read_int ()
	sw	x4, 4(x2)	# read_int ()
	# let isrot_p = read_int ()
	sw	x1, 5(x2)	# read_int ()
	addi	x2, x2, 6	# read_int ()
	jal	x0, -547	# read_int ()
	subi	x2, x2, 6	# read_int ()
	lw	x1, 5(x2)	# read_int ()
	addi	x4, x4, 0	# read_int ()
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 5(x2)	# create_array 3 0.0
	# let abc = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 6(x2)	# create_array 3 0.0
	addi	x2, x2, 7	# create_array 3 0.0
	jal	x0, -1061	# create_array 3 0.0
	subi	x2, x2, 7	# create_array 3 0.0
	lw	x1, 6(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	sw	x4, 6(x2)	# read_float ()
	sw	x1, 7(x2)	# read_float ()
	addi	x2, x2, 8	# read_float ()
	jal	x0, -569	# read_float ()
	subi	x2, x2, 8	# read_float ()
	lw	x1, 7(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 6(x2)	# abc.(0) <- read_float ()
	fsw	f1, 0(x4)	# abc.(0) <- read_float ()
	sw	x1, 7(x2)	# read_float ()
	addi	x2, x2, 8	# read_float ()
	jal	x0, -577	# read_float ()
	subi	x2, x2, 8	# read_float ()
	lw	x1, 7(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 6(x2)	# abc.(1) <- read_float ()
	fsw	f1, 1(x4)	# abc.(1) <- read_float ()
	sw	x1, 7(x2)	# read_float ()
	addi	x2, x2, 8	# read_float ()
	jal	x0, -585	# read_float ()
	subi	x2, x2, 8	# read_float ()
	lw	x1, 7(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 6(x2)	# abc.(2) <- read_float ()
	fsw	f1, 2(x4)	# abc.(2) <- read_float ()
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	# let xyz = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 7(x2)	# create_array 3 0.0
	addi	x2, x2, 8	# create_array 3 0.0
	jal	x0, -1096	# create_array 3 0.0
	subi	x2, x2, 8	# create_array 3 0.0
	lw	x1, 7(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	sw	x4, 7(x2)	# read_float ()
	sw	x1, 8(x2)	# read_float ()
	addi	x2, x2, 9	# read_float ()
	jal	x0, -604	# read_float ()
	subi	x2, x2, 9	# read_float ()
	lw	x1, 8(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 7(x2)	# xyz.(0) <- read_float ()
	fsw	f1, 0(x4)	# xyz.(0) <- read_float ()
	sw	x1, 8(x2)	# read_float ()
	addi	x2, x2, 9	# read_float ()
	jal	x0, -612	# read_float ()
	subi	x2, x2, 9	# read_float ()
	lw	x1, 8(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 7(x2)	# xyz.(1) <- read_float ()
	fsw	f1, 1(x4)	# xyz.(1) <- read_float ()
	sw	x1, 8(x2)	# read_float ()
	addi	x2, x2, 9	# read_float ()
	jal	x0, -620	# read_float ()
	subi	x2, x2, 9	# read_float ()
	lw	x1, 8(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 7(x2)	# xyz.(2) <- read_float ()
	fsw	f1, 2(x4)	# xyz.(2) <- read_float ()
	sw	x1, 8(x2)	# read_float ()
	addi	x2, x2, 9	# read_float ()
	jal	x0, -628	# read_float ()
	subi	x2, x2, 9	# read_float ()
	lw	x1, 8(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	# let m_invert = fisneg (read_float ())
	flt	x4, f0, f0	# fisneg (read_float ())
	addi	x5, x0, 2	# 2
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 8(x2)	# create_array 2 0.0
	# let reflparam = create_array 2 0.0
	addi	x4, x5, 0	# create_array 2 0.0
	sw	x1, 9(x2)	# create_array 2 0.0
	addi	x2, x2, 10	# create_array 2 0.0
	jal	x0, -1139	# create_array 2 0.0
	subi	x2, x2, 10	# create_array 2 0.0
	lw	x1, 9(x2)	# create_array 2 0.0
	addi	x4, x4, 0	# create_array 2 0.0
	sw	x4, 9(x2)	# read_float ()
	sw	x1, 10(x2)	# read_float ()
	addi	x2, x2, 11	# read_float ()
	jal	x0, -647	# read_float ()
	subi	x2, x2, 11	# read_float ()
	lw	x1, 10(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 9(x2)	# reflparam.(0) <- read_float ()
	fsw	f1, 0(x4)	# reflparam.(0) <- read_float ()
	sw	x1, 10(x2)	# read_float ()
	addi	x2, x2, 11	# read_float ()
	jal	x0, -655	# read_float ()
	subi	x2, x2, 11	# read_float ()
	lw	x1, 10(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 9(x2)	# reflparam.(1) <- read_float ()
	fsw	f1, 1(x4)	# reflparam.(1) <- read_float ()
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	# let color = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 10(x2)	# create_array 3 0.0
	addi	x2, x2, 11	# create_array 3 0.0
	jal	x0, -1166	# create_array 3 0.0
	subi	x2, x2, 11	# create_array 3 0.0
	lw	x1, 10(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	sw	x4, 10(x2)	# read_float ()
	sw	x1, 11(x2)	# read_float ()
	addi	x2, x2, 12	# read_float ()
	jal	x0, -674	# read_float ()
	subi	x2, x2, 12	# read_float ()
	lw	x1, 11(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 10(x2)	# color.(0) <- read_float ()
	fsw	f1, 0(x4)	# color.(0) <- read_float ()
	sw	x1, 11(x2)	# read_float ()
	addi	x2, x2, 12	# read_float ()
	jal	x0, -682	# read_float ()
	subi	x2, x2, 12	# read_float ()
	lw	x1, 11(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 10(x2)	# color.(1) <- read_float ()
	fsw	f1, 1(x4)	# color.(1) <- read_float ()
	sw	x1, 11(x2)	# read_float ()
	addi	x2, x2, 12	# read_float ()
	jal	x0, -690	# read_float ()
	subi	x2, x2, 12	# read_float ()
	lw	x1, 11(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	lw	x4, 10(x2)	# color.(2) <- read_float ()
	fsw	f1, 2(x4)	# color.(2) <- read_float ()
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	# let rotation = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 11(x2)	# create_array 3 0.0
	addi	x2, x2, 12	# create_array 3 0.0
	jal	x0, -1201	# create_array 3 0.0
	subi	x2, x2, 12	# create_array 3 0.0
	lw	x1, 11(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	lw	x5, 5(x2)	# if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	bne	x5, x0, 3	# if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 45	# if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
# bne:	rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ())
	sw	x4, 11(x2)	# read_float ()
	sw	x1, 12(x2)	# read_float ()
	addi	x2, x2, 13	# read_float ()
	jal	x0, -713	# read_float ()
	subi	x2, x2, 13	# read_float ()
	lw	x1, 12(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	sw	x1, 12(x2)	# rad (read_float ())
	addi	x2, x2, 13	# rad (read_float ())
	jal	x0, -470	# rad (read_float ())
	subi	x2, x2, 13	# rad (read_float ())
	lw	x1, 12(x2)	# rad (read_float ())
	fmr	f1, f1	# rad (read_float ())
	lw	x4, 11(x2)	# rotation.(0) <- rad (read_float ())
	fsw	f1, 0(x4)	# rotation.(0) <- rad (read_float ())
	sw	x1, 12(x2)	# read_float ()
	addi	x2, x2, 13	# read_float ()
	jal	x0, -727	# read_float ()
	subi	x2, x2, 13	# read_float ()
	lw	x1, 12(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	sw	x1, 12(x2)	# rad (read_float ())
	addi	x2, x2, 13	# rad (read_float ())
	jal	x0, -484	# rad (read_float ())
	subi	x2, x2, 13	# rad (read_float ())
	lw	x1, 12(x2)	# rad (read_float ())
	fmr	f1, f1	# rad (read_float ())
	lw	x4, 11(x2)	# rotation.(1) <- rad (read_float ())
	fsw	f1, 1(x4)	# rotation.(1) <- rad (read_float ())
	sw	x1, 12(x2)	# read_float ()
	addi	x2, x2, 13	# read_float ()
	jal	x0, -741	# read_float ()
	subi	x2, x2, 13	# read_float ()
	lw	x1, 12(x2)	# read_float ()
	fmr	f1, f1	# read_float ()
	sw	x1, 12(x2)	# rad (read_float ())
	addi	x2, x2, 13	# rad (read_float ())
	jal	x0, -498	# rad (read_float ())
	subi	x2, x2, 13	# rad (read_float ())
	lw	x1, 12(x2)	# rad (read_float ())
	fmr	f1, f1	# rad (read_float ())
	lw	x4, 11(x2)	# rotation.(2) <- rad (read_float ())
	fsw	f1, 2(x4)	# rotation.(2) <- rad (read_float ())
	jalr x0, x1, 0	# rotation.(2) <- rad (read_float ())
# cont:	if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else ()
	addi	x5, x0, 2	# 2
	lw	x6, 3(x2)	# if form = 2 then true else m_invert
	# let m_invert2 = if form = 2 then true else m_invert
	bne	x6, x5, 4	# if form = 2 then true else m_invert
# beq:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
	jal	x0, 4	# if form = 2 then true else m_invert
# bne:	m_invert
	lw	x5, 8(x2)	# m_invert
	addi	x4, x5, 0	# m_invert
	jalr	x0, x1, 0	# m_invert
# cont:	if form = 2 then true else m_invert
	addi	x7, x0, 4	# 4
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x5, 12(x2)	# create_array 4 0.0
	sw	x4, 11(x2)	# create_array 4 0.0
	# let ctbl = create_array 4 0.0
	addi	x4, x7, 0	# create_array 4 0.0
	sw	x1, 13(x2)	# create_array 4 0.0
	addi	x2, x2, 14	# create_array 4 0.0
	jal	x0, -1270	# create_array 4 0.0
	subi	x2, x2, 14	# create_array 4 0.0
	lw	x1, 13(x2)	# create_array 4 0.0
	addi	x4, x4, 0	# create_array 4 0.0
	addi	x31, x3, 0	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	addi	x3, x3, 11	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 10(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x5, 11(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x5, 9(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x4, 10(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 8(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x4, 9(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 7(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x4, 12(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 6(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x4, 7(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 5(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x4, 6(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x4, 4(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x6, 5(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x6, 3(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x7, 4(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x7, 2(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x7, 3(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x7, 1(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x8, 2(x2)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	sw	x8, 0(x31)	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	# let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl )
	addi	x8, x31, 0	# texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl
	lw	x9, 0(x2)	# objects.(n) <- obj
	lw	x10, 1(x2)	# objects.(n) <- obj
	swa	x8, (x10, x9)	# objects.(n) <- obj
	addi	x8, x0, 3	# 3
	bne	x7, x8, 63	# if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else ()
# beq:	let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c
	# let a = abc.(0)
	flw	f1, 0(x4)	# abc.(0)
	feq	x7, f1, f0	# fiszero a
	bne	x7, x0, 13	# if fiszero a then 0.0 else sgn a /. fsqr a
# beq:	sgn a /. fsqr a
	fsw	f1, 13(x2)	# sgn a
	sw	x1, 14(x2)	# sgn a
	addi	x2, x2, 15	# sgn a
	jal	x0, -803	# sgn a
	subi	x2, x2, 15	# sgn a
	lw	x1, 14(x2)	# sgn a
	fmr	f1, f1	# sgn a
	flw	f2, 13(x2)	# fsqr a
	fmul	f2, f2, f2	# fsqr a
	fdiv	f1, f1, f2	# sgn a /. fsqr a
	jalr	x0, x1, 0	# sgn a /. fsqr a
	jal	x0, 4	# if fiszero a then 0.0 else sgn a /. fsqr a
# bne:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
# cont:	if fiszero a then 0.0 else sgn a /. fsqr a
	lw	x4, 6(x2)	# abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a
	fsw	f1, 0(x4)	# abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a
	# let b = abc.(1)
	flw	f1, 1(x4)	# abc.(1)
	feq	x5, f1, f0	# fiszero b
	bne	x5, x0, 13	# if fiszero b then 0.0 else sgn b /. fsqr b
# beq:	sgn b /. fsqr b
	fsw	f1, 14(x2)	# sgn b
	sw	x1, 15(x2)	# sgn b
	addi	x2, x2, 16	# sgn b
	jal	x0, -823	# sgn b
	subi	x2, x2, 16	# sgn b
	lw	x1, 15(x2)	# sgn b
	fmr	f1, f1	# sgn b
	flw	f2, 14(x2)	# fsqr b
	fmul	f2, f2, f2	# fsqr b
	fdiv	f1, f1, f2	# sgn b /. fsqr b
	jalr	x0, x1, 0	# sgn b /. fsqr b
	jal	x0, 4	# if fiszero b then 0.0 else sgn b /. fsqr b
# bne:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
# cont:	if fiszero b then 0.0 else sgn b /. fsqr b
	lw	x4, 6(x2)	# abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b
	fsw	f1, 1(x4)	# abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b
	# let c = abc.(2)
	flw	f1, 2(x4)	# abc.(2)
	feq	x5, f1, f0	# fiszero c
	bne	x5, x0, 13	# if fiszero c then 0.0 else sgn c /. fsqr c
# beq:	sgn c /. fsqr c
	fsw	f1, 15(x2)	# sgn c
	sw	x1, 16(x2)	# sgn c
	addi	x2, x2, 17	# sgn c
	jal	x0, -843	# sgn c
	subi	x2, x2, 17	# sgn c
	lw	x1, 16(x2)	# sgn c
	fmr	f1, f1	# sgn c
	flw	f2, 15(x2)	# fsqr c
	fmul	f2, f2, f2	# fsqr c
	fdiv	f1, f1, f2	# sgn c /. fsqr c
	jalr	x0, x1, 0	# sgn c /. fsqr c
	jal	x0, 4	# if fiszero c then 0.0 else sgn c /. fsqr c
# bne:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
# cont:	if fiszero c then 0.0 else sgn c /. fsqr c
	lw	x4, 6(x2)	# abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c
	fsw	f1, 2(x4)	# abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c
	jalr x0, x1, 0	# abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c
	jal	x0, 8	# if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else ()
# bne:	if form = 2 then vecunit_sgn abc (not m_invert) else ()
	addi	x8, x0, 2	# 2
	bne	x7, x8, 5	# if form = 2 then vecunit_sgn abc (not m_invert) else ()
# beq:	vecunit_sgn abc (not m_invert)
	lw	x7, 8(x2)	# not m_invert
	xori	x7, x7, -1	# not m_invert
	addi	x5, x7, 0	# vecunit_sgn abc (not m_invert)
	jal	x0, -818	# vecunit_sgn abc (not m_invert)
# bne:	()
	jalr x0, x1, 0	# ()
# cont:	if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else ()
	lw	x4, 5(x2)	# if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
	bne	x4, x0, 3	# if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 4	# if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
# bne:	rotate_quadratic_matrix abc rotation
	lw	x4, 6(x2)	# rotate_quadratic_matrix abc rotation
	lw	x5, 11(x2)	# rotate_quadratic_matrix abc rotation
	jal	x0, -462	# rotate_quadratic_matrix abc rotation
# cont:	if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else ()
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# read_object.2666:	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	lw	x5, 5(x29)	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	lw	x6, 4(x29)	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	addi	x7, x0, 60	# 60
	bge	x4, x7, 22	# if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
# blt:	if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n
	sw	x29, 0(x2)	# read_nth_object n
	sw	x6, 1(x2)	# read_nth_object n
	sw	x4, 2(x2)	# read_nth_object n
	addi	x29, x5, 0	# read_nth_object n
	sw	x1, 3(x2)	# read_nth_object n
	addi	x2, x2, 4	# read_nth_object n
	lw	x31, 0(x29)	# read_nth_object n
	jalr	x1, x31, 0	# read_nth_object n
	subi	x2, x2, 4	# read_nth_object n
	lw	x1, 3(x2)	# read_nth_object n
	addi	x4, x4, 0	# read_nth_object n
	bne	x4, x0, 5	# if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n
# beq:	n_objects.(0) <- n
	lw	x4, 1(x2)	# n_objects.(0) <- n
	lw	x5, 2(x2)	# n_objects.(0) <- n
	sw	x5, 0(x4)	# n_objects.(0) <- n
	jalr x0, x1, 0	# n_objects.(0) <- n
# bne:	read_object (n + 1)
	lw	x4, 2(x2)	# n + 1
	addi	x4, x4, 1	# n + 1
	lw	x29, 0(x2)	# read_object (n + 1)
	lw	x31, 0(x29)	# read_object (n + 1)
	jalr	x0, x31, 0	# read_object (n + 1)
# bge:	()
	jalr x0, x1, 0	# ()
# read_all_object.2668:	# let rec read_all_object _ = read_object 0
	lw	x29, 4(x29)	# let rec read_all_object _ = read_object 0
	addi	x4, x0, 0	# 0
	lw	x31, 0(x29)	# read_object 0
	jalr	x0, x31, 0	# read_object 0
# read_net_item.2670:	# let rec read_net_item length = let item = read_int () in if item = -1 then create_array (length + 1) (-1) else let v = read_net_item (length + 1) in (v.(length) <- item; v)
	sw	x4, 0(x2)	# read_int ()
	# let item = read_int ()
	sw	x1, 1(x2)	# read_int ()
	addi	x2, x2, 2	# read_int ()
	jal	x0, -911	# read_int ()
	subi	x2, x2, 2	# read_int ()
	lw	x1, 1(x2)	# read_int ()
	addi	x4, x4, 0	# read_int ()
	addi	x5, x0, -1	# -1
	bne	x4, x5, 5	# if item = -1 then create_array (length + 1) (-1) else let v = read_net_item (length + 1) in (v.(length) <- item; v)
# beq:	create_array (length + 1) (-1)
	lw	x4, 0(x2)	# length + 1
	addi	x4, x4, 1	# length + 1
	addi	x5, x0, -1	# -1
	jal	x0, -1921	# create_array (length + 1) (-1)
# bne:	let v = read_net_item (length + 1) in (v.(length) <- item; v)
	lw	x5, 0(x2)	# length + 1
	addi	x6, x5, 1	# length + 1
	sw	x4, 1(x2)	# read_net_item (length + 1)
	# let v = read_net_item (length + 1)
	addi	x4, x6, 0	# read_net_item (length + 1)
	sw	x1, 2(x2)	# read_net_item (length + 1)
	addi	x2, x2, 3	# read_net_item (length + 1)
	jal	x0, -21	# read_net_item (length + 1)
	subi	x2, x2, 3	# read_net_item (length + 1)
	lw	x1, 2(x2)	# read_net_item (length + 1)
	addi	x4, x4, 0	# read_net_item (length + 1)
	lw	x5, 0(x2)	# v.(length) <- item
	lw	x6, 1(x2)	# v.(length) <- item
	swa	x6, (x4, x5)	# v.(length) <- item
	jalr	x0, x1, 0	# v
# read_or_network.2672:	# let rec read_or_network length = let net = read_net_item 0 in if net.(0) = -1 then create_array (length + 1) net else let v = read_or_network (length + 1) in (v.(length) <- net; v)
	addi	x5, x0, 0	# 0
	sw	x4, 0(x2)	# read_net_item 0
	# let net = read_net_item 0
	addi	x4, x5, 0	# read_net_item 0
	sw	x1, 1(x2)	# read_net_item 0
	addi	x2, x2, 2	# read_net_item 0
	jal	x0, -34	# read_net_item 0
	subi	x2, x2, 2	# read_net_item 0
	lw	x1, 1(x2)	# read_net_item 0
	addi	x5, x4, 0	# read_net_item 0
	lw	x4, 0(x5)	# net.(0)
	addi	x6, x0, -1	# -1
	bne	x4, x6, 4	# if net.(0) = -1 then create_array (length + 1) net else let v = read_or_network (length + 1) in (v.(length) <- net; v)
# beq:	create_array (length + 1) net
	lw	x4, 0(x2)	# length + 1
	addi	x4, x4, 1	# length + 1
	jal	x0, -1950	# create_array (length + 1) net
# bne:	let v = read_or_network (length + 1) in (v.(length) <- net; v)
	lw	x4, 0(x2)	# length + 1
	addi	x6, x4, 1	# length + 1
	sw	x5, 1(x2)	# read_or_network (length + 1)
	# let v = read_or_network (length + 1)
	addi	x4, x6, 0	# read_or_network (length + 1)
	sw	x1, 2(x2)	# read_or_network (length + 1)
	addi	x2, x2, 3	# read_or_network (length + 1)
	jal	x0, -23	# read_or_network (length + 1)
	subi	x2, x2, 3	# read_or_network (length + 1)
	lw	x1, 2(x2)	# read_or_network (length + 1)
	addi	x4, x4, 0	# read_or_network (length + 1)
	lw	x5, 0(x2)	# v.(length) <- net
	lw	x6, 1(x2)	# v.(length) <- net
	swa	x6, (x4, x5)	# v.(length) <- net
	jalr	x0, x1, 0	# v
# read_and_network.2674:	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	lw	x5, 4(x29)	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	addi	x6, x0, 0	# 0
	sw	x29, 0(x2)	# read_net_item 0
	sw	x4, 1(x2)	# read_net_item 0
	sw	x5, 2(x2)	# read_net_item 0
	# let net = read_net_item 0
	addi	x4, x6, 0	# read_net_item 0
	sw	x1, 3(x2)	# read_net_item 0
	addi	x2, x2, 4	# read_net_item 0
	jal	x0, -66	# read_net_item 0
	subi	x2, x2, 4	# read_net_item 0
	lw	x1, 3(x2)	# read_net_item 0
	addi	x4, x4, 0	# read_net_item 0
	lw	x5, 0(x4)	# net.(0)
	addi	x6, x0, -1	# -1
	bne	x5, x6, 2	# if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	and_net.(n) <- net; read_and_network (n + 1)
	lw	x5, 1(x2)	# and_net.(n) <- net
	lw	x6, 2(x2)	# and_net.(n) <- net
	swa	x4, (x6, x5)	# and_net.(n) <- net
	addi	x4, x5, 1	# n + 1
	lw	x29, 0(x2)	# read_and_network (n + 1)
	lw	x31, 0(x29)	# read_and_network (n + 1)
	jalr	x0, x31, 0	# read_and_network (n + 1)
# read_parameter.2676:	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	lw	x4, 8(x29)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	lw	x5, 7(x29)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	lw	x6, 6(x29)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	lw	x7, 5(x29)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	lw	x8, 4(x29)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x8, 0(x2)	# read_screen_settings()
	sw	x6, 1(x2)	# read_screen_settings()
	sw	x7, 2(x2)	# read_screen_settings()
	sw	x5, 3(x2)	# read_screen_settings()
	addi	x29, x4, 0	# read_screen_settings()
	sw	x1, 4(x2)	# read_screen_settings()
	addi	x2, x2, 5	# read_screen_settings()
	lw	x31, 0(x29)	# read_screen_settings()
	jalr	x1, x31, 0	# read_screen_settings()
	subi	x2, x2, 5	# read_screen_settings()
	lw	x1, 4(x2)	# read_screen_settings()
	addi	x0, x4, 0	# read_screen_settings()
	lw	x29, 3(x2)	# read_light()
	sw	x1, 4(x2)	# read_light()
	addi	x2, x2, 5	# read_light()
	lw	x31, 0(x29)	# read_light()
	jalr	x1, x31, 0	# read_light()
	subi	x2, x2, 5	# read_light()
	lw	x1, 4(x2)	# read_light()
	addi	x0, x4, 0	# read_light()
	lw	x29, 2(x2)	# read_all_object ()
	sw	x1, 4(x2)	# read_all_object ()
	addi	x2, x2, 5	# read_all_object ()
	lw	x31, 0(x29)	# read_all_object ()
	jalr	x1, x31, 0	# read_all_object ()
	subi	x2, x2, 5	# read_all_object ()
	lw	x1, 4(x2)	# read_all_object ()
	addi	x0, x4, 0	# read_all_object ()
	addi	x4, x0, 0	# 0
	lw	x29, 1(x2)	# read_and_network 0
	sw	x1, 4(x2)	# read_and_network 0
	addi	x2, x2, 5	# read_and_network 0
	lw	x31, 0(x29)	# read_and_network 0
	jalr	x1, x31, 0	# read_and_network 0
	subi	x2, x2, 5	# read_and_network 0
	lw	x1, 4(x2)	# read_and_network 0
	addi	x0, x4, 0	# read_and_network 0
	addi	x4, x0, 0	# 0
	sw	x1, 4(x2)	# read_or_network 0
	addi	x2, x2, 5	# read_or_network 0
	jal	x0, -100	# read_or_network 0
	subi	x2, x2, 5	# read_or_network 0
	lw	x1, 4(x2)	# read_or_network 0
	addi	x4, x4, 0	# read_or_network 0
	lw	x5, 0(x2)	# or_net.(0) <- read_or_network 0
	sw	x4, 0(x5)	# or_net.(0) <- read_or_network 0
	jalr x0, x1, 0	# or_net.(0) <- read_or_network 0
# solver_rect_surface.2678:	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	lw	x9, 4(x29)	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	flwa	f4, (x5, x6)	# dirvec.(i0)
	feq	x10, f4, f0	# fiszero dirvec.(i0)
	bne	x10, x0, 71	# if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
# beq:	let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	sw	x9, 0(x2)	# o_param_abc m
	fsw	f3, 1(x2)	# o_param_abc m
	sw	x8, 2(x2)	# o_param_abc m
	fsw	f2, 3(x2)	# o_param_abc m
	sw	x7, 4(x2)	# o_param_abc m
	fsw	f1, 5(x2)	# o_param_abc m
	sw	x6, 6(x2)	# o_param_abc m
	sw	x5, 7(x2)	# o_param_abc m
	sw	x4, 8(x2)	# o_param_abc m
	# let abc = o_param_abc m
	sw	x1, 9(x2)	# o_param_abc m
	addi	x2, x2, 10	# o_param_abc m
	jal	x0, -876	# o_param_abc m
	subi	x2, x2, 10	# o_param_abc m
	lw	x1, 9(x2)	# o_param_abc m
	addi	x4, x4, 0	# o_param_abc m
	lw	x5, 8(x2)	# o_isinvert m
	sw	x4, 9(x2)	# o_isinvert m
	addi	x4, x5, 0	# o_isinvert m
	sw	x1, 10(x2)	# o_isinvert m
	addi	x2, x2, 11	# o_isinvert m
	jal	x0, -897	# o_isinvert m
	subi	x2, x2, 11	# o_isinvert m
	lw	x1, 10(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	lw	x5, 6(x2)	# dirvec.(i0)
	lw	x6, 7(x2)	# dirvec.(i0)
	flwa	f1, (x6, x5)	# dirvec.(i0)
	flt	x7, f0, f0	# fisneg dirvec.(i0)
	xor	x4, x4, x7	# xor (o_isinvert m) (fisneg dirvec.(i0))
	lw	x7, 9(x2)	# abc.(i0)
	flwa	f1, (x7, x5)	# abc.(i0)
	# let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	sw	x1, 10(x2)	# fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	addi	x2, x2, 11	# fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	jal	x0, -1058	# fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	subi	x2, x2, 11	# fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	lw	x1, 10(x2)	# fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	fmr	f1, f1	# fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0)
	flw	f2, 5(x2)	# d -. b0
	fsub	f1, f1, f2	# d -. b0
	lw	x4, 6(x2)	# dirvec.(i0)
	lw	x5, 7(x2)	# dirvec.(i0)
	flwa	f2, (x5, x4)	# dirvec.(i0)
	# let d2 = (d -. b0) /. dirvec.(i0)
	fdiv	f1, f1, f2	# (d -. b0) /. dirvec.(i0)
	lw	x4, 4(x2)	# dirvec.(i1)
	flwa	f2, (x5, x4)	# dirvec.(i1)
	fmul	f2, f1, f2	# d2 *. dirvec.(i1)
	flw	f3, 3(x2)	# d2 *. dirvec.(i1) +. b1
	fadd	f2, f2, f3	# d2 *. dirvec.(i1) +. b1
	fabs	f2, f2	# fabs (d2 *. dirvec.(i1) +. b1)
	lw	x6, 9(x2)	# abc.(i1)
	flwa	f2, (x6, x4)	# abc.(i1)
	flt	x4, f2, f2	# fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1)
	bne	x4, x0, 3	# if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false
	lw	x4, 2(x2)	# dirvec.(i2)
	flwa	f2, (x5, x4)	# dirvec.(i2)
	fmul	f2, f1, f2	# d2 *. dirvec.(i2)
	flw	f3, 1(x2)	# d2 *. dirvec.(i2) +. b2
	fadd	f2, f2, f3	# d2 *. dirvec.(i2) +. b2
	fabs	f2, f2	# fabs (d2 *. dirvec.(i2) +. b2)
	flwa	f2, (x6, x4)	# abc.(i2)
	flt	x4, f2, f2	# fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2)
	bne	x4, x0, 3	# if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	solver_dist.(0) <- d2; true
	lw	x4, 0(x2)	# solver_dist.(0) <- d2
	fsw	f1, 0(x4)	# solver_dist.(0) <- d2
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# bne:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# solver_rect.2687:	# let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	lw	x29, 4(x29)	# let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x6, x0, 0	# 0
	addi	x7, x0, 1	# 1
	addi	x8, x0, 2	# 2
	fsw	f1, 0(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	fsw	f3, 1(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	fsw	f2, 2(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	sw	x5, 3(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	sw	x4, 4(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	sw	x29, 5(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	sw	x1, 6(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	addi	x2, x2, 7	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	lw	x31, 0(x29)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	jalr	x1, x31, 0	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	subi	x2, x2, 7	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	lw	x1, 6(x2)	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	addi	x4, x4, 0	# solver_rect_surface m dirvec b0 b1 b2 0 1 2
	bne	x4, x0, 41	# if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
# beq:	if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x6, x0, 1	# 1
	addi	x7, x0, 2	# 2
	addi	x8, x0, 0	# 0
	flw	f1, 2(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	flw	f2, 1(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	flw	f3, 0(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x4, 4(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x5, 3(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x29, 5(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	sw	x1, 6(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	addi	x2, x2, 7	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x31, 0(x29)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	jalr	x1, x31, 0	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	subi	x2, x2, 7	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	lw	x1, 6(x2)	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	addi	x4, x4, 0	# solver_rect_surface m dirvec b1 b2 b0 1 2 0
	bne	x4, x0, 22	# if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
# beq:	if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x6, x0, 2	# 2
	addi	x7, x0, 0	# 0
	addi	x8, x0, 1	# 1
	flw	f1, 1(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	flw	f2, 0(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	flw	f3, 2(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x4, 4(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x5, 3(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x29, 5(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	sw	x1, 6(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	addi	x2, x2, 7	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x31, 0(x29)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	jalr	x1, x31, 0	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	subi	x2, x2, 7	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	lw	x1, 6(x2)	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	addi	x4, x4, 0	# solver_rect_surface m dirvec b2 b0 b1 2 0 1
	bne	x4, x0, 3	# if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	3
	addi	x4, x0, 3	# 3
	jalr	x0, x1, 0	# 3
# bne:	2
	addi	x4, x0, 2	# 2
	jalr	x0, x1, 0	# 2
# bne:	1
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# solver_surface.2693:	# let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	lw	x6, 4(x29)	# let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	sw	x6, 0(x2)	# o_param_abc m
	fsw	f3, 1(x2)	# o_param_abc m
	fsw	f2, 2(x2)	# o_param_abc m
	fsw	f1, 3(x2)	# o_param_abc m
	sw	x5, 4(x2)	# o_param_abc m
	# let abc = o_param_abc m
	sw	x1, 5(x2)	# o_param_abc m
	addi	x2, x2, 6	# o_param_abc m
	jal	x0, -1005	# o_param_abc m
	subi	x2, x2, 6	# o_param_abc m
	lw	x1, 5(x2)	# o_param_abc m
	addi	x5, x4, 0	# o_param_abc m
	lw	x4, 4(x2)	# veciprod dirvec abc
	sw	x5, 5(x2)	# veciprod dirvec abc
	# let d = veciprod dirvec abc
	sw	x1, 6(x2)	# veciprod dirvec abc
	addi	x2, x2, 7	# veciprod dirvec abc
	jal	x0, -1111	# veciprod dirvec abc
	subi	x2, x2, 7	# veciprod dirvec abc
	lw	x1, 6(x2)	# veciprod dirvec abc
	fmr	f1, f1	# veciprod dirvec abc
	flt	x4, f1, f1	# fispos d
	bne	x4, x0, 3	# if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1
	flw	f2, 3(x2)	# veciprod2 abc b0 b1 b2
	flw	f3, 2(x2)	# veciprod2 abc b0 b1 b2
	flw	f4, 1(x2)	# veciprod2 abc b0 b1 b2
	lw	x4, 5(x2)	# veciprod2 abc b0 b1 b2
	fsw	f1, 6(x2)	# veciprod2 abc b0 b1 b2
	fmv	f1, f2	# veciprod2 abc b0 b1 b2
	fmv	f2, f3	# veciprod2 abc b0 b1 b2
	fmv	f3, f4	# veciprod2 abc b0 b1 b2
	sw	x1, 7(x2)	# veciprod2 abc b0 b1 b2
	addi	x2, x2, 8	# veciprod2 abc b0 b1 b2
	jal	x0, -1114	# veciprod2 abc b0 b1 b2
	subi	x2, x2, 8	# veciprod2 abc b0 b1 b2
	lw	x1, 7(x2)	# veciprod2 abc b0 b1 b2
	fmr	f1, f1	# veciprod2 abc b0 b1 b2
	fneg	f1, f1	# fneg (veciprod2 abc b0 b1 b2)
	flw	f2, 6(x2)	# fneg (veciprod2 abc b0 b1 b2) /. d
	fdiv	f1, f1, f2	# fneg (veciprod2 abc b0 b1 b2) /. d
	lw	x4, 0(x2)	# solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d
	fsw	f1, 0(x4)	# solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# quadratic.2699:	# let rec quadratic m v0 v1 v2 = let diag_part = fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m in if o_isrot m = 0 then diag_part else diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	fmul	f4, f1, f1	# fsqr v0
	fsw	f1, 0(x2)	# o_param_a m
	fsw	f3, 1(x2)	# o_param_a m
	sw	x4, 2(x2)	# o_param_a m
	fsw	f2, 3(x2)	# o_param_a m
	fsw	f4, 4(x2)	# o_param_a m
	sw	x1, 5(x2)	# o_param_a m
	addi	x2, x2, 6	# o_param_a m
	jal	x0, -1059	# o_param_a m
	subi	x2, x2, 6	# o_param_a m
	lw	x1, 5(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flw	f2, 4(x2)	# fsqr v0 *. o_param_a m
	fmul	f1, f2, f1	# fsqr v0 *. o_param_a m
	flw	f2, 3(x2)	# fsqr v1
	fmul	f3, f2, f2	# fsqr v1
	lw	x4, 2(x2)	# o_param_b m
	fsw	f1, 5(x2)	# o_param_b m
	fsw	f3, 6(x2)	# o_param_b m
	sw	x1, 7(x2)	# o_param_b m
	addi	x2, x2, 8	# o_param_b m
	jal	x0, -1069	# o_param_b m
	subi	x2, x2, 8	# o_param_b m
	lw	x1, 7(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flw	f2, 6(x2)	# fsqr v1 *. o_param_b m
	fmul	f1, f2, f1	# fsqr v1 *. o_param_b m
	flw	f2, 5(x2)	# fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m
	fadd	f1, f2, f1	# fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m
	flw	f2, 1(x2)	# fsqr v2
	fmul	f3, f2, f2	# fsqr v2
	lw	x4, 2(x2)	# o_param_c m
	fsw	f1, 7(x2)	# o_param_c m
	fsw	f3, 8(x2)	# o_param_c m
	sw	x1, 9(x2)	# o_param_c m
	addi	x2, x2, 10	# o_param_c m
	jal	x0, -1081	# o_param_c m
	subi	x2, x2, 10	# o_param_c m
	lw	x1, 9(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flw	f2, 8(x2)	# fsqr v2 *. o_param_c m
	fmul	f1, f2, f1	# fsqr v2 *. o_param_c m
	flw	f2, 7(x2)	# fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m
	# let diag_part = fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m
	fadd	f1, f2, f1	# fsqr v0 *. o_param_a m +. fsqr v1 *. o_param_b m +. fsqr v2 *. o_param_c m
	lw	x4, 2(x2)	# o_isrot m
	fsw	f1, 9(x2)	# o_isrot m
	sw	x1, 10(x2)	# o_isrot m
	addi	x2, x2, 11	# o_isrot m
	jal	x0, -1101	# o_isrot m
	subi	x2, x2, 11	# o_isrot m
	lw	x1, 10(x2)	# o_isrot m
	addi	x4, x4, 0	# o_isrot m
	bne	x4, x0, 3	# if o_isrot m = 0 then diag_part else diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
# beq:	diag_part
	flw	f1, 9(x2)	# diag_part
	jalr	x0, x1, 0	# diag_part
# bne:	diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	flw	f1, 1(x2)	# v1 *. v2
	flw	f2, 3(x2)	# v1 *. v2
	fmul	f3, f2, f1	# v1 *. v2
	lw	x4, 2(x2)	# o_param_r1 m
	fsw	f3, 10(x2)	# o_param_r1 m
	sw	x1, 11(x2)	# o_param_r1 m
	addi	x2, x2, 12	# o_param_r1 m
	jal	x0, -1078	# o_param_r1 m
	subi	x2, x2, 12	# o_param_r1 m
	lw	x1, 11(x2)	# o_param_r1 m
	fmr	f1, f1	# o_param_r1 m
	flw	f2, 10(x2)	# v1 *. v2 *. o_param_r1 m
	fmul	f1, f2, f1	# v1 *. v2 *. o_param_r1 m
	flw	f2, 9(x2)	# diag_part +. v1 *. v2 *. o_param_r1 m
	fadd	f1, f2, f1	# diag_part +. v1 *. v2 *. o_param_r1 m
	flw	f2, 0(x2)	# v2 *. v0
	flw	f3, 1(x2)	# v2 *. v0
	fmul	f3, f3, f2	# v2 *. v0
	lw	x4, 2(x2)	# o_param_r2 m
	fsw	f1, 11(x2)	# o_param_r2 m
	fsw	f3, 12(x2)	# o_param_r2 m
	sw	x1, 13(x2)	# o_param_r2 m
	addi	x2, x2, 14	# o_param_r2 m
	jal	x0, -1091	# o_param_r2 m
	subi	x2, x2, 14	# o_param_r2 m
	lw	x1, 13(x2)	# o_param_r2 m
	fmr	f1, f1	# o_param_r2 m
	flw	f2, 12(x2)	# v2 *. v0 *. o_param_r2 m
	fmul	f1, f2, f1	# v2 *. v0 *. o_param_r2 m
	flw	f2, 11(x2)	# diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m
	fadd	f1, f2, f1	# diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m
	flw	f2, 3(x2)	# v0 *. v1
	flw	f3, 0(x2)	# v0 *. v1
	fmul	f2, f3, f2	# v0 *. v1
	lw	x4, 2(x2)	# o_param_r3 m
	fsw	f1, 13(x2)	# o_param_r3 m
	fsw	f2, 14(x2)	# o_param_r3 m
	sw	x1, 15(x2)	# o_param_r3 m
	addi	x2, x2, 16	# o_param_r3 m
	jal	x0, -1104	# o_param_r3 m
	subi	x2, x2, 16	# o_param_r3 m
	lw	x1, 15(x2)	# o_param_r3 m
	fmr	f1, f1	# o_param_r3 m
	flw	f2, 14(x2)	# v0 *. v1 *. o_param_r3 m
	fmul	f1, f2, f1	# v0 *. v1 *. o_param_r3 m
	flw	f2, 13(x2)	# diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	fadd	f1, f2, f1	# diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
	jalr	x0, x1, 0	# diag_part +. v1 *. v2 *. o_param_r1 m +. v2 *. v0 *. o_param_r2 m +. v0 *. v1 *. o_param_r3 m
# bilinear.2704:	# let rec bilinear m v0 v1 v2 w0 w1 w2 = let diag_part = v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m in if o_isrot m = 0 then diag_part else diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	fmul	f7, f1, f4	# v0 *. w0
	fsw	f4, 0(x2)	# o_param_a m
	fsw	f1, 1(x2)	# o_param_a m
	fsw	f6, 2(x2)	# o_param_a m
	fsw	f3, 3(x2)	# o_param_a m
	sw	x4, 4(x2)	# o_param_a m
	fsw	f5, 5(x2)	# o_param_a m
	fsw	f2, 6(x2)	# o_param_a m
	fsw	f7, 7(x2)	# o_param_a m
	sw	x1, 8(x2)	# o_param_a m
	addi	x2, x2, 9	# o_param_a m
	jal	x0, -1165	# o_param_a m
	subi	x2, x2, 9	# o_param_a m
	lw	x1, 8(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flw	f2, 7(x2)	# v0 *. w0 *. o_param_a m
	fmul	f1, f2, f1	# v0 *. w0 *. o_param_a m
	flw	f2, 5(x2)	# v1 *. w1
	flw	f3, 6(x2)	# v1 *. w1
	fmul	f4, f3, f2	# v1 *. w1
	lw	x4, 4(x2)	# o_param_b m
	fsw	f1, 8(x2)	# o_param_b m
	fsw	f4, 9(x2)	# o_param_b m
	sw	x1, 10(x2)	# o_param_b m
	addi	x2, x2, 11	# o_param_b m
	jal	x0, -1176	# o_param_b m
	subi	x2, x2, 11	# o_param_b m
	lw	x1, 10(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flw	f2, 9(x2)	# v1 *. w1 *. o_param_b m
	fmul	f1, f2, f1	# v1 *. w1 *. o_param_b m
	flw	f2, 8(x2)	# v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m
	fadd	f1, f2, f1	# v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m
	flw	f2, 2(x2)	# v2 *. w2
	flw	f3, 3(x2)	# v2 *. w2
	fmul	f4, f3, f2	# v2 *. w2
	lw	x4, 4(x2)	# o_param_c m
	fsw	f1, 10(x2)	# o_param_c m
	fsw	f4, 11(x2)	# o_param_c m
	sw	x1, 12(x2)	# o_param_c m
	addi	x2, x2, 13	# o_param_c m
	jal	x0, -1189	# o_param_c m
	subi	x2, x2, 13	# o_param_c m
	lw	x1, 12(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flw	f2, 11(x2)	# v2 *. w2 *. o_param_c m
	fmul	f1, f2, f1	# v2 *. w2 *. o_param_c m
	flw	f2, 10(x2)	# v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m
	# let diag_part = v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m
	fadd	f1, f2, f1	# v0 *. w0 *. o_param_a m +. v1 *. w1 *. o_param_b m +. v2 *. w2 *. o_param_c m
	lw	x4, 4(x2)	# o_isrot m
	fsw	f1, 12(x2)	# o_isrot m
	sw	x1, 13(x2)	# o_isrot m
	addi	x2, x2, 14	# o_isrot m
	jal	x0, -1209	# o_isrot m
	subi	x2, x2, 14	# o_isrot m
	lw	x1, 13(x2)	# o_isrot m
	addi	x4, x4, 0	# o_isrot m
	bne	x4, x0, 3	# if o_isrot m = 0 then diag_part else diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
# beq:	diag_part
	flw	f1, 12(x2)	# diag_part
	jalr	x0, x1, 0	# diag_part
# bne:	diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	flw	f1, 5(x2)	# v2 *. w1
	flw	f2, 3(x2)	# v2 *. w1
	fmul	f3, f2, f1	# v2 *. w1
	flw	f4, 2(x2)	# v1 *. w2
	flw	f5, 6(x2)	# v1 *. w2
	fmul	f6, f5, f4	# v1 *. w2
	fadd	f3, f3, f6	# v2 *. w1 +. v1 *. w2
	lw	x4, 4(x2)	# o_param_r1 m
	fsw	f3, 13(x2)	# o_param_r1 m
	sw	x1, 14(x2)	# o_param_r1 m
	addi	x2, x2, 15	# o_param_r1 m
	jal	x0, -1190	# o_param_r1 m
	subi	x2, x2, 15	# o_param_r1 m
	lw	x1, 14(x2)	# o_param_r1 m
	fmr	f1, f1	# o_param_r1 m
	flw	f2, 13(x2)	# (v2 *. w1 +. v1 *. w2) *. o_param_r1 m
	fmul	f1, f2, f1	# (v2 *. w1 +. v1 *. w2) *. o_param_r1 m
	flw	f2, 2(x2)	# v0 *. w2
	flw	f3, 1(x2)	# v0 *. w2
	fmul	f2, f3, f2	# v0 *. w2
	flw	f4, 0(x2)	# v2 *. w0
	flw	f5, 3(x2)	# v2 *. w0
	fmul	f5, f5, f4	# v2 *. w0
	fadd	f2, f2, f5	# v0 *. w2 +. v2 *. w0
	lw	x4, 4(x2)	# o_param_r2 m
	fsw	f1, 14(x2)	# o_param_r2 m
	fsw	f2, 15(x2)	# o_param_r2 m
	sw	x1, 16(x2)	# o_param_r2 m
	addi	x2, x2, 17	# o_param_r2 m
	jal	x0, -1205	# o_param_r2 m
	subi	x2, x2, 17	# o_param_r2 m
	lw	x1, 16(x2)	# o_param_r2 m
	fmr	f1, f1	# o_param_r2 m
	flw	f2, 15(x2)	# (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	fmul	f1, f2, f1	# (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	flw	f2, 14(x2)	# (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	fadd	f1, f2, f1	# (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m
	flw	f2, 5(x2)	# v0 *. w1
	flw	f3, 1(x2)	# v0 *. w1
	fmul	f2, f3, f2	# v0 *. w1
	flw	f3, 0(x2)	# v1 *. w0
	flw	f4, 6(x2)	# v1 *. w0
	fmul	f3, f4, f3	# v1 *. w0
	fadd	f2, f2, f3	# v0 *. w1 +. v1 *. w0
	lw	x4, 4(x2)	# o_param_r3 m
	fsw	f1, 16(x2)	# o_param_r3 m
	fsw	f2, 17(x2)	# o_param_r3 m
	sw	x1, 18(x2)	# o_param_r3 m
	addi	x2, x2, 19	# o_param_r3 m
	jal	x0, -1222	# o_param_r3 m
	subi	x2, x2, 19	# o_param_r3 m
	lw	x1, 18(x2)	# o_param_r3 m
	fmr	f1, f1	# o_param_r3 m
	flw	f2, 17(x2)	# (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	fmul	f1, f2, f1	# (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	flw	f2, 16(x2)	# (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	fadd	f1, f2, f1	# (v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m
	fmul	f1, f1, f27	# fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	flw	f2, 12(x2)	# diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	fadd	f1, f2, f1	# diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
	jalr	x0, x1, 0	# diag_part +. fhalf ((v2 *. w1 +. v1 *. w2) *. o_param_r1 m +. (v0 *. w2 +. v2 *. w0) *. o_param_r2 m +. (v0 *. w1 +. v1 *. w0) *. o_param_r3 m)
# solver_second.2712:	# let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	lw	x6, 4(x29)	# let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	flw	f4, 0(x5)	# dirvec.(0)
	flw	f5, 1(x5)	# dirvec.(1)
	flw	f6, 2(x5)	# dirvec.(2)
	sw	x6, 0(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fsw	f3, 1(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fsw	f2, 2(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fsw	f1, 3(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	sw	x4, 4(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	sw	x5, 5(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	# let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fmv	f3, f6	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fmv	f2, f5	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fmv	f1, f4	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	sw	x1, 6(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	addi	x2, x2, 7	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	jal	x0, -239	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	subi	x2, x2, 7	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	lw	x1, 6(x2)	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	fmr	f1, f1	# quadratic m dirvec.(0) dirvec.(1) dirvec.(2)
	feq	x4, f1, f0	# fiszero aa
	bne	x4, x0, 85	# if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
# beq:	let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0
	lw	x4, 5(x2)	# dirvec.(0)
	flw	f2, 0(x4)	# dirvec.(0)
	flw	f3, 1(x4)	# dirvec.(1)
	flw	f4, 2(x4)	# dirvec.(2)
	flw	f5, 3(x2)	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	flw	f6, 2(x2)	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	flw	f7, 1(x2)	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	lw	x4, 4(x2)	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fsw	f1, 6(x2)	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	# let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f1, f2	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f2, f3	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f3, f4	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f4, f5	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f5, f6	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmv	f6, f7	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	sw	x1, 7(x2)	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	addi	x2, x2, 8	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	jal	x0, -156	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	subi	x2, x2, 8	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	lw	x1, 7(x2)	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	fmr	f1, f1	# bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2
	flw	f2, 3(x2)	# quadratic m b0 b1 b2
	flw	f3, 2(x2)	# quadratic m b0 b1 b2
	flw	f4, 1(x2)	# quadratic m b0 b1 b2
	lw	x4, 4(x2)	# quadratic m b0 b1 b2
	fsw	f1, 7(x2)	# quadratic m b0 b1 b2
	# let cc0 = quadratic m b0 b1 b2
	fmv	f1, f2	# quadratic m b0 b1 b2
	fmv	f2, f3	# quadratic m b0 b1 b2
	fmv	f3, f4	# quadratic m b0 b1 b2
	sw	x1, 8(x2)	# quadratic m b0 b1 b2
	addi	x2, x2, 9	# quadratic m b0 b1 b2
	jal	x0, -276	# quadratic m b0 b1 b2
	subi	x2, x2, 9	# quadratic m b0 b1 b2
	lw	x1, 8(x2)	# quadratic m b0 b1 b2
	fmr	f1, f1	# quadratic m b0 b1 b2
	lw	x4, 4(x2)	# o_form m
	fsw	f1, 8(x2)	# o_form m
	sw	x1, 9(x2)	# o_form m
	addi	x2, x2, 10	# o_form m
	jal	x0, -1343	# o_form m
	subi	x2, x2, 10	# o_form m
	lw	x1, 9(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 3	# 3
	# let cc = if o_form m = 3 then cc0 -. 1.0 else cc0
	bne	x4, x5, 5	# if o_form m = 3 then cc0 -. 1.0 else cc0
# beq:	cc0 -. 1.0
	flw	f1, 8(x2)	# cc0 -. 1.0
	fsub	f1, f1, f11	# cc0 -. 1.0
	jalr	x0, x1, 0	# cc0 -. 1.0
	jal	x0, 3	# if o_form m = 3 then cc0 -. 1.0 else cc0
# bne:	cc0
	flw	f1, 8(x2)	# cc0
	jalr	x0, x1, 0	# cc0
# cont:	if o_form m = 3 then cc0 -. 1.0 else cc0
	flw	f2, 7(x2)	# fsqr bb
	fmul	f3, f2, f2	# fsqr bb
	flw	f4, 6(x2)	# aa *. cc
	fmul	f1, f4, f1	# aa *. cc
	# let d = fsqr bb -. aa *. cc
	fsub	f1, f3, f1	# fsqr bb -. aa *. cc
	flt	x4, f1, f1	# fispos d
	bne	x4, x0, 3	# if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1)
	# let sd = sqrt d
	fsqrt	f1, f1	# sqrt d
	lw	x4, 4(x2)	# o_isinvert m
	fsw	f1, 9(x2)	# o_isinvert m
	sw	x1, 10(x2)	# o_isinvert m
	addi	x2, x2, 11	# o_isinvert m
	jal	x0, -1365	# o_isinvert m
	subi	x2, x2, 11	# o_isinvert m
	lw	x1, 10(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	# let t1 = if o_isinvert m then sd else fneg sd
	bne	x4, x0, 5	# if o_isinvert m then sd else fneg sd
# beq:	fneg sd
	flw	f1, 9(x2)	# fneg sd
	fneg	f1, f1	# fneg sd
	jalr	x0, x1, 0	# fneg sd
	jal	x0, 3	# if o_isinvert m then sd else fneg sd
# bne:	sd
	flw	f1, 9(x2)	# sd
	jalr	x0, x1, 0	# sd
# cont:	if o_isinvert m then sd else fneg sd
	flw	f2, 7(x2)	# t1 -. bb
	fsub	f1, f1, f2	# t1 -. bb
	flw	f2, 6(x2)	# (t1 -. bb) /. aa
	fdiv	f1, f1, f2	# (t1 -. bb) /. aa
	lw	x4, 0(x2)	# solver_dist.(0) <- (t1 -. bb) /. aa
	fsw	f1, 0(x4)	# solver_dist.(0) <- (t1 -. bb) /. aa
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# bne:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# solver.2718:	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	lw	x7, 7(x29)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	lw	x8, 6(x29)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	lw	x9, 5(x29)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	lw	x10, 4(x29)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	# let m = objects.(index)
	lwa	x4, (x10, x4)	# objects.(index)
	flw	f1, 0(x6)	# org.(0)
	sw	x8, 0(x2)	# o_param_x m
	sw	x7, 1(x2)	# o_param_x m
	sw	x5, 2(x2)	# o_param_x m
	sw	x9, 3(x2)	# o_param_x m
	sw	x4, 4(x2)	# o_param_x m
	sw	x6, 5(x2)	# o_param_x m
	fsw	f1, 6(x2)	# o_param_x m
	sw	x1, 7(x2)	# o_param_x m
	addi	x2, x2, 8	# o_param_x m
	jal	x0, -1386	# o_param_x m
	subi	x2, x2, 8	# o_param_x m
	lw	x1, 7(x2)	# o_param_x m
	fmr	f1, f1	# o_param_x m
	flw	f2, 6(x2)	# org.(0) -. o_param_x m
	# let b0 = org.(0) -. o_param_x m
	fsub	f1, f2, f1	# org.(0) -. o_param_x m
	lw	x4, 5(x2)	# org.(1)
	flw	f2, 1(x4)	# org.(1)
	lw	x5, 4(x2)	# o_param_y m
	fsw	f1, 7(x2)	# o_param_y m
	fsw	f2, 8(x2)	# o_param_y m
	addi	x4, x5, 0	# o_param_y m
	sw	x1, 9(x2)	# o_param_y m
	addi	x2, x2, 10	# o_param_y m
	jal	x0, -1396	# o_param_y m
	subi	x2, x2, 10	# o_param_y m
	lw	x1, 9(x2)	# o_param_y m
	fmr	f1, f1	# o_param_y m
	flw	f2, 8(x2)	# org.(1) -. o_param_y m
	# let b1 = org.(1) -. o_param_y m
	fsub	f1, f2, f1	# org.(1) -. o_param_y m
	lw	x4, 5(x2)	# org.(2)
	flw	f2, 2(x4)	# org.(2)
	lw	x4, 4(x2)	# o_param_z m
	fsw	f1, 9(x2)	# o_param_z m
	fsw	f2, 10(x2)	# o_param_z m
	sw	x1, 11(x2)	# o_param_z m
	addi	x2, x2, 12	# o_param_z m
	jal	x0, -1407	# o_param_z m
	subi	x2, x2, 12	# o_param_z m
	lw	x1, 11(x2)	# o_param_z m
	fmr	f1, f1	# o_param_z m
	flw	f2, 10(x2)	# org.(2) -. o_param_z m
	# let b2 = org.(2) -. o_param_z m
	fsub	f1, f2, f1	# org.(2) -. o_param_z m
	lw	x4, 4(x2)	# o_form m
	fsw	f1, 11(x2)	# o_form m
	# let m_shape = o_form m
	sw	x1, 12(x2)	# o_form m
	addi	x2, x2, 13	# o_form m
	jal	x0, -1442	# o_form m
	subi	x2, x2, 13	# o_form m
	lw	x1, 12(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 1	# 1
	bne	x4, x5, 9	# if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
# beq:	solver_rect m dirvec b0 b1 b2
	flw	f1, 7(x2)	# solver_rect m dirvec b0 b1 b2
	flw	f2, 9(x2)	# solver_rect m dirvec b0 b1 b2
	flw	f3, 11(x2)	# solver_rect m dirvec b0 b1 b2
	lw	x4, 4(x2)	# solver_rect m dirvec b0 b1 b2
	lw	x5, 2(x2)	# solver_rect m dirvec b0 b1 b2
	lw	x29, 3(x2)	# solver_rect m dirvec b0 b1 b2
	lw	x31, 0(x29)	# solver_rect m dirvec b0 b1 b2
	jalr	x0, x31, 0	# solver_rect m dirvec b0 b1 b2
# bne:	if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	addi	x5, x0, 2	# 2
	bne	x4, x5, 9	# if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
# beq:	solver_surface m dirvec b0 b1 b2
	flw	f1, 7(x2)	# solver_surface m dirvec b0 b1 b2
	flw	f2, 9(x2)	# solver_surface m dirvec b0 b1 b2
	flw	f3, 11(x2)	# solver_surface m dirvec b0 b1 b2
	lw	x4, 4(x2)	# solver_surface m dirvec b0 b1 b2
	lw	x5, 2(x2)	# solver_surface m dirvec b0 b1 b2
	lw	x29, 1(x2)	# solver_surface m dirvec b0 b1 b2
	lw	x31, 0(x29)	# solver_surface m dirvec b0 b1 b2
	jalr	x0, x31, 0	# solver_surface m dirvec b0 b1 b2
# bne:	solver_second m dirvec b0 b1 b2
	flw	f1, 7(x2)	# solver_second m dirvec b0 b1 b2
	flw	f2, 9(x2)	# solver_second m dirvec b0 b1 b2
	flw	f3, 11(x2)	# solver_second m dirvec b0 b1 b2
	lw	x4, 4(x2)	# solver_second m dirvec b0 b1 b2
	lw	x5, 2(x2)	# solver_second m dirvec b0 b1 b2
	lw	x29, 0(x2)	# solver_second m dirvec b0 b1 b2
	lw	x31, 0(x29)	# solver_second m dirvec b0 b1 b2
	jalr	x0, x31, 0	# solver_second m dirvec b0 b1 b2
# solver_rect_fast.2722:	# let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	lw	x7, 4(x29)	# let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	flw	f4, 0(x6)	# dconst.(0)
	fsub	f4, f4, f1	# dconst.(0) -. b0
	flw	f5, 1(x6)	# dconst.(1)
	# let d0 = (dconst.(0) -. b0) *. dconst.(1)
	fmul	f4, f4, f5	# (dconst.(0) -. b0) *. dconst.(1)
	flw	f5, 1(x5)	# v.(1)
	fmul	f5, f4, f5	# d0 *. v.(1)
	fadd	f5, f5, f2	# d0 *. v.(1) +. b1
	fabs	f5, f5	# fabs (d0 *. v.(1) +. b1)
	sw	x7, 0(x2)	# o_param_b m
	fsw	f1, 1(x2)	# o_param_b m
	fsw	f2, 2(x2)	# o_param_b m
	sw	x6, 3(x2)	# o_param_b m
	sw	x4, 4(x2)	# o_param_b m
	fsw	f3, 5(x2)	# o_param_b m
	fsw	f4, 6(x2)	# o_param_b m
	sw	x5, 7(x2)	# o_param_b m
	sw	x1, 8(x2)	# o_param_b m
	addi	x2, x2, 9	# o_param_b m
	jal	x0, -1482	# o_param_b m
	subi	x2, x2, 9	# o_param_b m
	lw	x1, 8(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flt	x4, f1, f1	# fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m)
	bne	x4, x0, 4	# if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
	jal	x0, 25	# if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false
# bne:	if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false
	lw	x4, 7(x2)	# v.(2)
	flw	f1, 2(x4)	# v.(2)
	flw	f2, 6(x2)	# d0 *. v.(2)
	fmul	f1, f2, f1	# d0 *. v.(2)
	flw	f3, 5(x2)	# d0 *. v.(2) +. b2
	fadd	f1, f1, f3	# d0 *. v.(2) +. b2
	fabs	f1, f1	# fabs (d0 *. v.(2) +. b2)
	lw	x5, 4(x2)	# o_param_c m
	addi	x4, x5, 0	# o_param_c m
	sw	x1, 8(x2)	# o_param_c m
	addi	x2, x2, 9	# o_param_c m
	jal	x0, -1498	# o_param_c m
	subi	x2, x2, 9	# o_param_c m
	lw	x1, 8(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flt	x4, f1, f1	# fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m)
	bne	x4, x0, 3	# if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	not (fiszero dconst.(1))
	lw	x4, 3(x2)	# dconst.(1)
	flw	f1, 1(x4)	# dconst.(1)
	feq	x5, f1, f0	# fiszero dconst.(1)
	xori	x4, x5, -1	# not (fiszero dconst.(1))
	jalr	x0, x1, 0	# not (fiszero dconst.(1))
# cont:	if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false
	bne	x4, x0, 114	# if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
# beq:	let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	lw	x4, 3(x2)	# dconst.(2)
	flw	f1, 2(x4)	# dconst.(2)
	flw	f2, 2(x2)	# dconst.(2) -. b1
	fsub	f1, f1, f2	# dconst.(2) -. b1
	flw	f3, 3(x4)	# dconst.(3)
	# let d1 = (dconst.(2) -. b1) *. dconst.(3)
	fmul	f1, f1, f3	# (dconst.(2) -. b1) *. dconst.(3)
	lw	x5, 7(x2)	# v.(0)
	flw	f3, 0(x5)	# v.(0)
	fmul	f3, f1, f3	# d1 *. v.(0)
	flw	f4, 1(x2)	# d1 *. v.(0) +. b0
	fadd	f3, f3, f4	# d1 *. v.(0) +. b0
	fabs	f3, f3	# fabs (d1 *. v.(0) +. b0)
	lw	x6, 4(x2)	# o_param_a m
	fsw	f1, 8(x2)	# o_param_a m
	addi	x4, x6, 0	# o_param_a m
	sw	x1, 9(x2)	# o_param_a m
	addi	x2, x2, 10	# o_param_a m
	jal	x0, -1535	# o_param_a m
	subi	x2, x2, 10	# o_param_a m
	lw	x1, 9(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flt	x4, f1, f1	# fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m)
	bne	x4, x0, 4	# if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
	jal	x0, 25	# if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false
# bne:	if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false
	lw	x4, 7(x2)	# v.(2)
	flw	f1, 2(x4)	# v.(2)
	flw	f2, 8(x2)	# d1 *. v.(2)
	fmul	f1, f2, f1	# d1 *. v.(2)
	flw	f3, 5(x2)	# d1 *. v.(2) +. b2
	fadd	f1, f1, f3	# d1 *. v.(2) +. b2
	fabs	f1, f1	# fabs (d1 *. v.(2) +. b2)
	lw	x5, 4(x2)	# o_param_c m
	addi	x4, x5, 0	# o_param_c m
	sw	x1, 9(x2)	# o_param_c m
	addi	x2, x2, 10	# o_param_c m
	jal	x0, -1549	# o_param_c m
	subi	x2, x2, 10	# o_param_c m
	lw	x1, 9(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flt	x4, f1, f1	# fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m)
	bne	x4, x0, 3	# if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	not (fiszero dconst.(3))
	lw	x4, 3(x2)	# dconst.(3)
	flw	f1, 3(x4)	# dconst.(3)
	feq	x5, f1, f0	# fiszero dconst.(3)
	xori	x4, x5, -1	# not (fiszero dconst.(3))
	jalr	x0, x1, 0	# not (fiszero dconst.(3))
# cont:	if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false
	bne	x4, x0, 58	# if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
# beq:	let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	lw	x4, 3(x2)	# dconst.(4)
	flw	f1, 4(x4)	# dconst.(4)
	flw	f2, 5(x2)	# dconst.(4) -. b2
	fsub	f1, f1, f2	# dconst.(4) -. b2
	flw	f2, 5(x4)	# dconst.(5)
	# let d2 = (dconst.(4) -. b2) *. dconst.(5)
	fmul	f1, f1, f2	# (dconst.(4) -. b2) *. dconst.(5)
	lw	x5, 7(x2)	# v.(0)
	flw	f2, 0(x5)	# v.(0)
	fmul	f2, f1, f2	# d2 *. v.(0)
	flw	f3, 1(x2)	# d2 *. v.(0) +. b0
	fadd	f2, f2, f3	# d2 *. v.(0) +. b0
	fabs	f2, f2	# fabs (d2 *. v.(0) +. b0)
	lw	x6, 4(x2)	# o_param_a m
	fsw	f1, 9(x2)	# o_param_a m
	addi	x4, x6, 0	# o_param_a m
	sw	x1, 10(x2)	# o_param_a m
	addi	x2, x2, 11	# o_param_a m
	jal	x0, -1586	# o_param_a m
	subi	x2, x2, 11	# o_param_a m
	lw	x1, 10(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flt	x4, f1, f1	# fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m)
	bne	x4, x0, 4	# if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
	jal	x0, 24	# if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false
# bne:	if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false
	lw	x4, 7(x2)	# v.(1)
	flw	f1, 1(x4)	# v.(1)
	flw	f2, 9(x2)	# d2 *. v.(1)
	fmul	f1, f2, f1	# d2 *. v.(1)
	flw	f3, 2(x2)	# d2 *. v.(1) +. b1
	fadd	f1, f1, f3	# d2 *. v.(1) +. b1
	fabs	f1, f1	# fabs (d2 *. v.(1) +. b1)
	lw	x4, 4(x2)	# o_param_b m
	sw	x1, 10(x2)	# o_param_b m
	addi	x2, x2, 11	# o_param_b m
	jal	x0, -1603	# o_param_b m
	subi	x2, x2, 11	# o_param_b m
	lw	x1, 10(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flt	x4, f1, f1	# fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m)
	bne	x4, x0, 3	# if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	not (fiszero dconst.(5))
	lw	x4, 3(x2)	# dconst.(5)
	flw	f1, 5(x4)	# dconst.(5)
	feq	x4, f1, f0	# fiszero dconst.(5)
	xori	x4, x4, -1	# not (fiszero dconst.(5))
	jalr	x0, x1, 0	# not (fiszero dconst.(5))
# cont:	if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false
	bne	x4, x0, 3	# if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	solver_dist.(0) <- d2; 3
	lw	x4, 0(x2)	# solver_dist.(0) <- d2
	flw	f1, 9(x2)	# solver_dist.(0) <- d2
	fsw	f1, 0(x4)	# solver_dist.(0) <- d2
	addi	x4, x0, 3	# 3
	jalr	x0, x1, 0	# 3
# bne:	solver_dist.(0) <- d1; 2
	lw	x4, 0(x2)	# solver_dist.(0) <- d1
	flw	f1, 8(x2)	# solver_dist.(0) <- d1
	fsw	f1, 0(x4)	# solver_dist.(0) <- d1
	addi	x4, x0, 2	# 2
	jalr	x0, x1, 0	# 2
# bne:	solver_dist.(0) <- d0; 1
	lw	x4, 0(x2)	# solver_dist.(0) <- d0
	flw	f1, 6(x2)	# solver_dist.(0) <- d0
	fsw	f1, 0(x4)	# solver_dist.(0) <- d0
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# solver_surface_fast.2729:	# let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	lw	x4, 4(x29)	# let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	flw	f4, 0(x5)	# dconst.(0)
	flt	x6, f0, f0	# fisneg dconst.(0)
	bne	x6, x0, 3	# if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1
	flw	f4, 1(x5)	# dconst.(1)
	fmul	f1, f4, f1	# dconst.(1) *. b0
	flw	f4, 2(x5)	# dconst.(2)
	fmul	f2, f4, f2	# dconst.(2) *. b1
	fadd	f1, f1, f2	# dconst.(1) *. b0 +. dconst.(2) *. b1
	flw	f2, 3(x5)	# dconst.(3)
	fmul	f2, f2, f3	# dconst.(3) *. b2
	fadd	f1, f1, f2	# dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	fsw	f1, 0(x4)	# solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# solver_second_fast.2735:	# let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	lw	x6, 4(x29)	# let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	# let aa = dconst.(0)
	flw	f4, 0(x5)	# dconst.(0)
	feq	x7, f4, f0	# fiszero aa
	bne	x7, x0, 77	# if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	flw	f5, 1(x5)	# dconst.(1)
	fmul	f5, f5, f1	# dconst.(1) *. b0
	flw	f6, 2(x5)	# dconst.(2)
	fmul	f6, f6, f2	# dconst.(2) *. b1
	fadd	f5, f5, f6	# dconst.(1) *. b0 +. dconst.(2) *. b1
	flw	f6, 3(x5)	# dconst.(3)
	fmul	f6, f6, f3	# dconst.(3) *. b2
	# let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	fadd	f5, f5, f6	# dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	sw	x6, 0(x2)	# quadratic m b0 b1 b2
	sw	x5, 1(x2)	# quadratic m b0 b1 b2
	fsw	f4, 2(x2)	# quadratic m b0 b1 b2
	fsw	f5, 3(x2)	# quadratic m b0 b1 b2
	sw	x4, 4(x2)	# quadratic m b0 b1 b2
	# let cc0 = quadratic m b0 b1 b2
	sw	x1, 5(x2)	# quadratic m b0 b1 b2
	addi	x2, x2, 6	# quadratic m b0 b1 b2
	jal	x0, -625	# quadratic m b0 b1 b2
	subi	x2, x2, 6	# quadratic m b0 b1 b2
	lw	x1, 5(x2)	# quadratic m b0 b1 b2
	fmr	f1, f1	# quadratic m b0 b1 b2
	lw	x4, 4(x2)	# o_form m
	fsw	f1, 5(x2)	# o_form m
	sw	x1, 6(x2)	# o_form m
	addi	x2, x2, 7	# o_form m
	jal	x0, -1689	# o_form m
	subi	x2, x2, 7	# o_form m
	lw	x1, 6(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 3	# 3
	# let cc = if o_form m = 3 then cc0 -. 1.0 else cc0
	bne	x4, x5, 5	# if o_form m = 3 then cc0 -. 1.0 else cc0
# beq:	cc0 -. 1.0
	flw	f1, 5(x2)	# cc0 -. 1.0
	fsub	f1, f1, f11	# cc0 -. 1.0
	jalr	x0, x1, 0	# cc0 -. 1.0
	jal	x0, 3	# if o_form m = 3 then cc0 -. 1.0 else cc0
# bne:	cc0
	flw	f1, 5(x2)	# cc0
	jalr	x0, x1, 0	# cc0
# cont:	if o_form m = 3 then cc0 -. 1.0 else cc0
	flw	f2, 3(x2)	# fsqr neg_bb
	fmul	f3, f2, f2	# fsqr neg_bb
	flw	f4, 2(x2)	# aa *. cc
	fmul	f1, f4, f1	# aa *. cc
	# let d = (fsqr neg_bb) -. aa *. cc
	fsub	f1, f3, f1	# (fsqr neg_bb) -. aa *. cc
	flt	x4, f1, f1	# fispos d
	bne	x4, x0, 3	# if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1
	lw	x4, 4(x2)	# o_isinvert m
	fsw	f1, 6(x2)	# o_isinvert m
	sw	x1, 7(x2)	# o_isinvert m
	addi	x2, x2, 8	# o_isinvert m
	jal	x0, -1710	# o_isinvert m
	subi	x2, x2, 8	# o_isinvert m
	lw	x1, 7(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	bne	x4, x0, 12	# if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# beq:	solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	flw	f1, 6(x2)	# sqrt d
	fsqrt	f1, f1	# sqrt d
	flw	f2, 3(x2)	# neg_bb -. sqrt d
	fsub	f1, f2, f1	# neg_bb -. sqrt d
	lw	x4, 1(x2)	# dconst.(4)
	flw	f2, 4(x4)	# dconst.(4)
	fmul	f1, f1, f2	# (neg_bb -. sqrt d) *. dconst.(4)
	lw	x4, 0(x2)	# solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	jalr x0, x1, 0	# solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	jal	x0, 11	# if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# bne:	solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	flw	f1, 6(x2)	# sqrt d
	fsqrt	f1, f1	# sqrt d
	flw	f2, 3(x2)	# neg_bb +. sqrt d
	fadd	f1, f2, f1	# neg_bb +. sqrt d
	lw	x4, 1(x2)	# dconst.(4)
	flw	f2, 4(x4)	# dconst.(4)
	fmul	f1, f1, f2	# (neg_bb +. sqrt d) *. dconst.(4)
	lw	x4, 0(x2)	# solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	jalr x0, x1, 0	# solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
# cont:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# bne:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# solver_fast.2741:	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	lw	x7, 7(x29)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	lw	x8, 6(x29)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	lw	x9, 5(x29)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	lw	x10, 4(x29)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	# let m = objects.(index)
	lwa	x10, (x10, x4)	# objects.(index)
	flw	f1, 0(x6)	# org.(0)
	sw	x8, 0(x2)	# o_param_x m
	sw	x7, 1(x2)	# o_param_x m
	sw	x9, 2(x2)	# o_param_x m
	sw	x4, 3(x2)	# o_param_x m
	sw	x5, 4(x2)	# o_param_x m
	sw	x10, 5(x2)	# o_param_x m
	sw	x6, 6(x2)	# o_param_x m
	fsw	f1, 7(x2)	# o_param_x m
	addi	x4, x10, 0	# o_param_x m
	sw	x1, 8(x2)	# o_param_x m
	addi	x2, x2, 9	# o_param_x m
	jal	x0, -1741	# o_param_x m
	subi	x2, x2, 9	# o_param_x m
	lw	x1, 8(x2)	# o_param_x m
	fmr	f1, f1	# o_param_x m
	flw	f2, 7(x2)	# org.(0) -. o_param_x m
	# let b0 = org.(0) -. o_param_x m
	fsub	f1, f2, f1	# org.(0) -. o_param_x m
	lw	x4, 6(x2)	# org.(1)
	flw	f2, 1(x4)	# org.(1)
	lw	x5, 5(x2)	# o_param_y m
	fsw	f1, 8(x2)	# o_param_y m
	fsw	f2, 9(x2)	# o_param_y m
	addi	x4, x5, 0	# o_param_y m
	sw	x1, 10(x2)	# o_param_y m
	addi	x2, x2, 11	# o_param_y m
	jal	x0, -1752	# o_param_y m
	subi	x2, x2, 11	# o_param_y m
	lw	x1, 10(x2)	# o_param_y m
	fmr	f1, f1	# o_param_y m
	flw	f2, 9(x2)	# org.(1) -. o_param_y m
	# let b1 = org.(1) -. o_param_y m
	fsub	f1, f2, f1	# org.(1) -. o_param_y m
	lw	x4, 6(x2)	# org.(2)
	flw	f2, 2(x4)	# org.(2)
	lw	x4, 5(x2)	# o_param_z m
	fsw	f1, 10(x2)	# o_param_z m
	fsw	f2, 11(x2)	# o_param_z m
	sw	x1, 12(x2)	# o_param_z m
	addi	x2, x2, 13	# o_param_z m
	jal	x0, -1763	# o_param_z m
	subi	x2, x2, 13	# o_param_z m
	lw	x1, 12(x2)	# o_param_z m
	fmr	f1, f1	# o_param_z m
	flw	f2, 11(x2)	# org.(2) -. o_param_z m
	# let b2 = org.(2) -. o_param_z m
	fsub	f1, f2, f1	# org.(2) -. o_param_z m
	lw	x4, 4(x2)	# d_const dirvec
	fsw	f1, 12(x2)	# d_const dirvec
	# let dconsts = d_const dirvec
	sw	x1, 13(x2)	# d_const dirvec
	addi	x2, x2, 14	# d_const dirvec
	jal	x0, -1722	# d_const dirvec
	subi	x2, x2, 14	# d_const dirvec
	lw	x1, 13(x2)	# d_const dirvec
	addi	x4, x4, 0	# d_const dirvec
	lw	x5, 3(x2)	# dconsts.(index)
	# let dconst = dconsts.(index)
	lwa	x4, (x4, x5)	# dconsts.(index)
	lw	x5, 5(x2)	# o_form m
	sw	x4, 13(x2)	# o_form m
	# let m_shape = o_form m
	addi	x4, x5, 0	# o_form m
	sw	x1, 14(x2)	# o_form m
	addi	x2, x2, 15	# o_form m
	jal	x0, -1808	# o_form m
	subi	x2, x2, 15	# o_form m
	lw	x1, 14(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 1	# 1
	bne	x4, x5, 16	# if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
# beq:	solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 4(x2)	# d_vec dirvec
	sw	x1, 14(x2)	# d_vec dirvec
	addi	x2, x2, 15	# d_vec dirvec
	jal	x0, -1744	# d_vec dirvec
	subi	x2, x2, 15	# d_vec dirvec
	lw	x1, 14(x2)	# d_vec dirvec
	addi	x5, x4, 0	# d_vec dirvec
	flw	f1, 8(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f2, 10(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f3, 12(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 5(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x6, 13(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x29, 2(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x31, 0(x29)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	jalr	x0, x31, 0	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
# bne:	if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	addi	x5, x0, 2	# 2
	bne	x4, x5, 9	# if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
# beq:	solver_surface_fast m dconst b0 b1 b2
	flw	f1, 8(x2)	# solver_surface_fast m dconst b0 b1 b2
	flw	f2, 10(x2)	# solver_surface_fast m dconst b0 b1 b2
	flw	f3, 12(x2)	# solver_surface_fast m dconst b0 b1 b2
	lw	x4, 5(x2)	# solver_surface_fast m dconst b0 b1 b2
	lw	x5, 13(x2)	# solver_surface_fast m dconst b0 b1 b2
	lw	x29, 1(x2)	# solver_surface_fast m dconst b0 b1 b2
	lw	x31, 0(x29)	# solver_surface_fast m dconst b0 b1 b2
	jalr	x0, x31, 0	# solver_surface_fast m dconst b0 b1 b2
# bne:	solver_second_fast m dconst b0 b1 b2
	flw	f1, 8(x2)	# solver_second_fast m dconst b0 b1 b2
	flw	f2, 10(x2)	# solver_second_fast m dconst b0 b1 b2
	flw	f3, 12(x2)	# solver_second_fast m dconst b0 b1 b2
	lw	x4, 5(x2)	# solver_second_fast m dconst b0 b1 b2
	lw	x5, 13(x2)	# solver_second_fast m dconst b0 b1 b2
	lw	x29, 0(x2)	# solver_second_fast m dconst b0 b1 b2
	lw	x31, 0(x29)	# solver_second_fast m dconst b0 b1 b2
	jalr	x0, x31, 0	# solver_second_fast m dconst b0 b1 b2
# solver_surface_fast2.2745:	# let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	lw	x4, 4(x29)	# let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	flw	f1, 0(x5)	# dconst.(0)
	flt	x7, f0, f0	# fisneg dconst.(0)
	bne	x7, x0, 3	# if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	solver_dist.(0) <- dconst.(0) *. sconst.(3); 1
	flw	f1, 0(x5)	# dconst.(0)
	flw	f2, 3(x6)	# sconst.(3)
	fmul	f1, f1, f2	# dconst.(0) *. sconst.(3)
	fsw	f1, 0(x4)	# solver_dist.(0) <- dconst.(0) *. sconst.(3)
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# solver_second_fast2.2752:	# let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	lw	x7, 4(x29)	# let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	# let aa = dconst.(0)
	flw	f4, 0(x5)	# dconst.(0)
	feq	x8, f4, f0	# fiszero aa
	bne	x8, x0, 51	# if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	flw	f5, 1(x5)	# dconst.(1)
	fmul	f1, f5, f1	# dconst.(1) *. b0
	flw	f5, 2(x5)	# dconst.(2)
	fmul	f2, f5, f2	# dconst.(2) *. b1
	fadd	f1, f1, f2	# dconst.(1) *. b0 +. dconst.(2) *. b1
	flw	f2, 3(x5)	# dconst.(3)
	fmul	f2, f2, f3	# dconst.(3) *. b2
	# let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	fadd	f1, f1, f2	# dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2
	# let cc = sconst.(3)
	flw	f2, 3(x6)	# sconst.(3)
	fmul	f3, f1, f1	# fsqr neg_bb
	fmul	f2, f4, f2	# aa *. cc
	# let d = (fsqr neg_bb) -. aa *. cc
	fsub	f2, f3, f2	# (fsqr neg_bb) -. aa *. cc
	flt	x6, f2, f2	# fispos d
	bne	x6, x0, 3	# if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
# beq:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# bne:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1
	sw	x7, 0(x2)	# o_isinvert m
	sw	x5, 1(x2)	# o_isinvert m
	fsw	f1, 2(x2)	# o_isinvert m
	fsw	f2, 3(x2)	# o_isinvert m
	sw	x1, 4(x2)	# o_isinvert m
	addi	x2, x2, 5	# o_isinvert m
	jal	x0, -1882	# o_isinvert m
	subi	x2, x2, 5	# o_isinvert m
	lw	x1, 4(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	bne	x4, x0, 12	# if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# beq:	solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	flw	f1, 3(x2)	# sqrt d
	fsqrt	f1, f1	# sqrt d
	flw	f2, 2(x2)	# neg_bb -. sqrt d
	fsub	f1, f2, f1	# neg_bb -. sqrt d
	lw	x4, 1(x2)	# dconst.(4)
	flw	f2, 4(x4)	# dconst.(4)
	fmul	f1, f1, f2	# (neg_bb -. sqrt d) *. dconst.(4)
	lw	x4, 0(x2)	# solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	jalr x0, x1, 0	# solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	jal	x0, 11	# if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
# bne:	solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	flw	f1, 3(x2)	# sqrt d
	fsqrt	f1, f1	# sqrt d
	flw	f2, 2(x2)	# neg_bb +. sqrt d
	fadd	f1, f2, f1	# neg_bb +. sqrt d
	lw	x4, 1(x2)	# dconst.(4)
	flw	f2, 4(x4)	# dconst.(4)
	fmul	f1, f1, f2	# (neg_bb +. sqrt d) *. dconst.(4)
	lw	x4, 0(x2)	# solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	fsw	f1, 0(x4)	# solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
	jalr x0, x1, 0	# solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4)
# cont:	if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4)
	addi	x4, x0, 1	# 1
	jalr	x0, x1, 0	# 1
# bne:	0
	addi	x4, x0, 0	# 0
	jalr	x0, x1, 0	# 0
# solver_fast2.2759:	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x6, 7(x29)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x7, 6(x29)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x8, 5(x29)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x9, 4(x29)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	# let m = objects.(index)
	lwa	x9, (x9, x4)	# objects.(index)
	sw	x7, 0(x2)	# o_param_ctbl m
	sw	x6, 1(x2)	# o_param_ctbl m
	sw	x8, 2(x2)	# o_param_ctbl m
	sw	x9, 3(x2)	# o_param_ctbl m
	sw	x4, 4(x2)	# o_param_ctbl m
	sw	x5, 5(x2)	# o_param_ctbl m
	# let sconst = o_param_ctbl m
	addi	x4, x9, 0	# o_param_ctbl m
	sw	x1, 6(x2)	# o_param_ctbl m
	addi	x2, x2, 7	# o_param_ctbl m
	jal	x0, -1877	# o_param_ctbl m
	subi	x2, x2, 7	# o_param_ctbl m
	lw	x1, 6(x2)	# o_param_ctbl m
	addi	x4, x4, 0	# o_param_ctbl m
	# let b0 = sconst.(0)
	flw	f1, 0(x4)	# sconst.(0)
	# let b1 = sconst.(1)
	flw	f2, 1(x4)	# sconst.(1)
	# let b2 = sconst.(2)
	flw	f3, 2(x4)	# sconst.(2)
	lw	x5, 5(x2)	# d_const dirvec
	sw	x4, 6(x2)	# d_const dirvec
	fsw	f3, 7(x2)	# d_const dirvec
	fsw	f2, 8(x2)	# d_const dirvec
	fsw	f1, 9(x2)	# d_const dirvec
	# let dconsts = d_const dirvec
	addi	x4, x5, 0	# d_const dirvec
	sw	x1, 10(x2)	# d_const dirvec
	addi	x2, x2, 11	# d_const dirvec
	jal	x0, -1868	# d_const dirvec
	subi	x2, x2, 11	# d_const dirvec
	lw	x1, 10(x2)	# d_const dirvec
	addi	x4, x4, 0	# d_const dirvec
	lw	x5, 4(x2)	# dconsts.(index)
	# let dconst = dconsts.(index)
	lwa	x4, (x4, x5)	# dconsts.(index)
	lw	x5, 3(x2)	# o_form m
	sw	x4, 10(x2)	# o_form m
	# let m_shape = o_form m
	addi	x4, x5, 0	# o_form m
	sw	x1, 11(x2)	# o_form m
	addi	x2, x2, 12	# o_form m
	jal	x0, -1955	# o_form m
	subi	x2, x2, 12	# o_form m
	lw	x1, 11(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 1	# 1
	bne	x4, x5, 16	# if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
# beq:	solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 5(x2)	# d_vec dirvec
	sw	x1, 11(x2)	# d_vec dirvec
	addi	x2, x2, 12	# d_vec dirvec
	jal	x0, -1891	# d_vec dirvec
	subi	x2, x2, 12	# d_vec dirvec
	lw	x1, 11(x2)	# d_vec dirvec
	addi	x5, x4, 0	# d_vec dirvec
	flw	f1, 9(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f2, 8(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	flw	f3, 7(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x4, 3(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x6, 10(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x29, 2(x2)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	lw	x31, 0(x29)	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
	jalr	x0, x31, 0	# solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2
# bne:	if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	addi	x5, x0, 2	# 2
	bne	x4, x5, 10	# if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
# beq:	solver_surface_fast2 m dconst sconst b0 b1 b2
	flw	f1, 9(x2)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	flw	f2, 8(x2)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	flw	f3, 7(x2)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x4, 3(x2)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x5, 10(x2)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x6, 6(x2)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x29, 1(x2)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	lw	x31, 0(x29)	# solver_surface_fast2 m dconst sconst b0 b1 b2
	jalr	x0, x31, 0	# solver_surface_fast2 m dconst sconst b0 b1 b2
# bne:	solver_second_fast2 m dconst sconst b0 b1 b2
	flw	f1, 9(x2)	# solver_second_fast2 m dconst sconst b0 b1 b2
	flw	f2, 8(x2)	# solver_second_fast2 m dconst sconst b0 b1 b2
	flw	f3, 7(x2)	# solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x4, 3(x2)	# solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x5, 10(x2)	# solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x6, 6(x2)	# solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x29, 0(x2)	# solver_second_fast2 m dconst sconst b0 b1 b2
	lw	x31, 0(x29)	# solver_second_fast2 m dconst sconst b0 b1 b2
	jalr	x0, x31, 0	# solver_second_fast2 m dconst sconst b0 b1 b2
# setup_rect_table.2762:	# let rec setup_rect_table vec m = let const = create_array 6 0.0 in if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) ); if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) ); if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) ); const
	addi	x6, x0, 6	# 6
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x5, 0(x2)	# create_array 6 0.0
	sw	x4, 1(x2)	# create_array 6 0.0
	# let const = create_array 6 0.0
	addi	x4, x6, 0	# create_array 6 0.0
	sw	x1, 2(x2)	# create_array 6 0.0
	addi	x2, x2, 3	# create_array 6 0.0
	auipc	x31, -1	# create_array 6 0.0
	jalr	x0, x31, -2669	# create_array 6 0.0
	subi	x2, x2, 3	# create_array 6 0.0
	lw	x1, 2(x2)	# create_array 6 0.0
	addi	x4, x4, 0	# create_array 6 0.0
	lw	x5, 1(x2)	# vec.(0)
	flw	f1, 0(x5)	# vec.(0)
	feq	x6, f1, f0	# fiszero vec.(0)
	bne	x6, x0, 39	# if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
# beq:	const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0)
	lw	x6, 0(x2)	# o_isinvert m
	sw	x4, 2(x2)	# o_isinvert m
	addi	x4, x6, 0	# o_isinvert m
	sw	x1, 3(x2)	# o_isinvert m
	addi	x2, x2, 4	# o_isinvert m
	jal	x0, -2014	# o_isinvert m
	subi	x2, x2, 4	# o_isinvert m
	lw	x1, 3(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	lw	x5, 1(x2)	# vec.(0)
	flw	f1, 0(x5)	# vec.(0)
	flt	x6, f0, f0	# fisneg vec.(0)
	xor	x4, x4, x6	# xor (o_isinvert m) (fisneg vec.(0))
	lw	x6, 0(x2)	# o_param_a m
	sw	x4, 3(x2)	# o_param_a m
	addi	x4, x6, 0	# o_param_a m
	sw	x1, 4(x2)	# o_param_a m
	addi	x2, x2, 5	# o_param_a m
	jal	x0, -2023	# o_param_a m
	subi	x2, x2, 5	# o_param_a m
	lw	x1, 4(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	lw	x4, 3(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	sw	x1, 4(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	addi	x2, x2, 5	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	auipc	x31, -1	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	jalr	x0, x31, -2182	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	subi	x2, x2, 5	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	lw	x1, 4(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	fmr	f1, f1	# fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	lw	x4, 2(x2)	# const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	fsw	f1, 0(x4)	# const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m)
	lw	x5, 1(x2)	# vec.(0)
	flw	f1, 0(x5)	# vec.(0)
	fdiv	f1, f11, f1	# 1.0 /. vec.(0)
	fsw	f1, 1(x4)	# const.(1) <- 1.0 /. vec.(0)
	jalr x0, x1, 0	# const.(1) <- 1.0 /. vec.(0)
	jal	x0, 5	# if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
# bne:	const.(1) <- 0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	fsw	f1, 1(x4)	# const.(1) <- 0.0
	jalr x0, x1, 0	# const.(1) <- 0.0
# cont:	if fiszero vec.(0) then const.(1) <- 0.0 else ( const.(0) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(0))) (o_param_a m); const.(1) <- 1.0 /. vec.(0) )
	flw	f1, 1(x5)	# vec.(1)
	feq	x6, f1, f0	# fiszero vec.(1)
	bne	x6, x0, 41	# if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) )
# beq:	const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1)
	lw	x6, 0(x2)	# o_isinvert m
	sw	x4, 2(x2)	# o_isinvert m
	addi	x4, x6, 0	# o_isinvert m
	sw	x1, 4(x2)	# o_isinvert m
	addi	x2, x2, 5	# o_isinvert m
	auipc	x31, -1	# o_isinvert m
	jalr	x0, x31, -2059	# o_isinvert m
	subi	x2, x2, 5	# o_isinvert m
	lw	x1, 4(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	lw	x5, 1(x2)	# vec.(1)
	flw	f1, 1(x5)	# vec.(1)
	flt	x6, f0, f0	# fisneg vec.(1)
	xor	x4, x4, x6	# xor (o_isinvert m) (fisneg vec.(1))
	lw	x6, 0(x2)	# o_param_b m
	sw	x4, 4(x2)	# o_param_b m
	addi	x4, x6, 0	# o_param_b m
	sw	x1, 5(x2)	# o_param_b m
	addi	x2, x2, 6	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -2066	# o_param_b m
	subi	x2, x2, 6	# o_param_b m
	lw	x1, 5(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	lw	x4, 4(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	sw	x1, 5(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	addi	x2, x2, 6	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	auipc	x31, -1	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	jalr	x0, x31, -2229	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	subi	x2, x2, 6	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	lw	x1, 5(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	fmr	f1, f1	# fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	lw	x4, 2(x2)	# const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	fsw	f1, 2(x4)	# const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m)
	lw	x5, 1(x2)	# vec.(1)
	flw	f1, 1(x5)	# vec.(1)
	fdiv	f1, f11, f1	# 1.0 /. vec.(1)
	fsw	f1, 3(x4)	# const.(3) <- 1.0 /. vec.(1)
	jalr x0, x1, 0	# const.(3) <- 1.0 /. vec.(1)
	jal	x0, 5	# if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) )
# bne:	const.(3) <- 0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	fsw	f1, 3(x4)	# const.(3) <- 0.0
	jalr x0, x1, 0	# const.(3) <- 0.0
# cont:	if fiszero vec.(1) then const.(3) <- 0.0 else ( const.(2) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(1))) (o_param_b m); const.(3) <- 1.0 /. vec.(1) )
	flw	f1, 2(x5)	# vec.(2)
	feq	x6, f1, f0	# fiszero vec.(2)
	bne	x6, x0, 41	# if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) )
# beq:	const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2)
	lw	x6, 0(x2)	# o_isinvert m
	sw	x4, 2(x2)	# o_isinvert m
	addi	x4, x6, 0	# o_isinvert m
	sw	x1, 5(x2)	# o_isinvert m
	addi	x2, x2, 6	# o_isinvert m
	auipc	x31, -1	# o_isinvert m
	jalr	x0, x31, -2106	# o_isinvert m
	subi	x2, x2, 6	# o_isinvert m
	lw	x1, 5(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	lw	x5, 1(x2)	# vec.(2)
	flw	f1, 2(x5)	# vec.(2)
	flt	x6, f0, f0	# fisneg vec.(2)
	xor	x4, x4, x6	# xor (o_isinvert m) (fisneg vec.(2))
	lw	x6, 0(x2)	# o_param_c m
	sw	x4, 5(x2)	# o_param_c m
	addi	x4, x6, 0	# o_param_c m
	sw	x1, 6(x2)	# o_param_c m
	addi	x2, x2, 7	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -2110	# o_param_c m
	subi	x2, x2, 7	# o_param_c m
	lw	x1, 6(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	lw	x4, 5(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	sw	x1, 6(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	addi	x2, x2, 7	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	auipc	x31, -1	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	jalr	x0, x31, -2276	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	subi	x2, x2, 7	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	lw	x1, 6(x2)	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	fmr	f1, f1	# fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	lw	x4, 2(x2)	# const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	fsw	f1, 4(x4)	# const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m)
	lw	x5, 1(x2)	# vec.(2)
	flw	f1, 2(x5)	# vec.(2)
	fdiv	f1, f11, f1	# 1.0 /. vec.(2)
	fsw	f1, 5(x4)	# const.(5) <- 1.0 /. vec.(2)
	jalr x0, x1, 0	# const.(5) <- 1.0 /. vec.(2)
	jal	x0, 5	# if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) )
# bne:	const.(5) <- 0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	fsw	f1, 5(x4)	# const.(5) <- 0.0
	jalr x0, x1, 0	# const.(5) <- 0.0
# cont:	if fiszero vec.(2) then const.(5) <- 0.0 else ( const.(4) <- fneg_cond (xor (o_isinvert m) (fisneg vec.(2))) (o_param_c m); const.(5) <- 1.0 /. vec.(2) )
	jalr	x0, x1, 0	# const
# setup_surface_table.2765:	# let rec setup_surface_table vec m = let const = create_array 4 0.0 in let d = vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m in if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0; const
	addi	x6, x0, 4	# 4
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x5, 0(x2)	# create_array 4 0.0
	sw	x4, 1(x2)	# create_array 4 0.0
	# let const = create_array 4 0.0
	addi	x4, x6, 0	# create_array 4 0.0
	sw	x1, 2(x2)	# create_array 4 0.0
	addi	x2, x2, 3	# create_array 4 0.0
	auipc	x31, -1	# create_array 4 0.0
	jalr	x0, x31, -2823	# create_array 4 0.0
	subi	x2, x2, 3	# create_array 4 0.0
	lw	x1, 2(x2)	# create_array 4 0.0
	addi	x4, x4, 0	# create_array 4 0.0
	lw	x5, 1(x2)	# vec.(0)
	flw	f1, 0(x5)	# vec.(0)
	lw	x6, 0(x2)	# o_param_a m
	sw	x4, 2(x2)	# o_param_a m
	fsw	f1, 3(x2)	# o_param_a m
	addi	x4, x6, 0	# o_param_a m
	sw	x1, 4(x2)	# o_param_a m
	addi	x2, x2, 5	# o_param_a m
	auipc	x31, -1	# o_param_a m
	jalr	x0, x31, -2163	# o_param_a m
	subi	x2, x2, 5	# o_param_a m
	lw	x1, 4(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flw	f2, 3(x2)	# vec.(0) *. o_param_a m
	fmul	f1, f2, f1	# vec.(0) *. o_param_a m
	lw	x4, 1(x2)	# vec.(1)
	flw	f2, 1(x4)	# vec.(1)
	lw	x5, 0(x2)	# o_param_b m
	fsw	f1, 4(x2)	# o_param_b m
	fsw	f2, 5(x2)	# o_param_b m
	addi	x4, x5, 0	# o_param_b m
	sw	x1, 6(x2)	# o_param_b m
	addi	x2, x2, 7	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -2175	# o_param_b m
	subi	x2, x2, 7	# o_param_b m
	lw	x1, 6(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flw	f2, 5(x2)	# vec.(1) *. o_param_b m
	fmul	f1, f2, f1	# vec.(1) *. o_param_b m
	flw	f2, 4(x2)	# vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m
	fadd	f1, f2, f1	# vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m
	lw	x4, 1(x2)	# vec.(2)
	flw	f2, 2(x4)	# vec.(2)
	lw	x4, 0(x2)	# o_param_c m
	fsw	f1, 6(x2)	# o_param_c m
	fsw	f2, 7(x2)	# o_param_c m
	sw	x1, 8(x2)	# o_param_c m
	addi	x2, x2, 9	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -2189	# o_param_c m
	subi	x2, x2, 9	# o_param_c m
	lw	x1, 8(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flw	f2, 7(x2)	# vec.(2) *. o_param_c m
	fmul	f1, f2, f1	# vec.(2) *. o_param_c m
	flw	f2, 6(x2)	# vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m
	# let d = vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m
	fadd	f1, f2, f1	# vec.(0) *. o_param_a m +. vec.(1) *. o_param_b m +. vec.(2) *. o_param_c m
	flt	x4, f1, f1	# fispos d
	bne	x4, x0, 7	# if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0
# beq:	const.(0) <- 0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	lw	x4, 2(x2)	# const.(0) <- 0.0
	fsw	f1, 0(x4)	# const.(0) <- 0.0
	jalr x0, x1, 0	# const.(0) <- 0.0
	jal	x0, 51	# if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0
# bne:	const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d)
	lui	x31, -264192	# -1.0
	addi	x31, x31, -1082130432	# -1.0
	mvitof	f2, x31	# -1.0
	fdiv	f2, f2, f1	# -1.0 /. d
	lw	x4, 2(x2)	# const.(0) <- -1.0 /. d
	fsw	f2, 0(x4)	# const.(0) <- -1.0 /. d
	lw	x5, 0(x2)	# o_param_a m
	fsw	f1, 8(x2)	# o_param_a m
	addi	x4, x5, 0	# o_param_a m
	sw	x1, 9(x2)	# o_param_a m
	addi	x2, x2, 10	# o_param_a m
	auipc	x31, -1	# o_param_a m
	jalr	x0, x31, -2222	# o_param_a m
	subi	x2, x2, 10	# o_param_a m
	lw	x1, 9(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flw	f2, 8(x2)	# o_param_a m /. d
	fdiv	f1, f1, f2	# o_param_a m /. d
	fneg	f1, f1	# fneg (o_param_a m /. d)
	lw	x4, 2(x2)	# const.(1) <- fneg (o_param_a m /. d)
	fsw	f1, 1(x4)	# const.(1) <- fneg (o_param_a m /. d)
	lw	x5, 0(x2)	# o_param_b m
	addi	x4, x5, 0	# o_param_b m
	sw	x1, 9(x2)	# o_param_b m
	addi	x2, x2, 10	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -2233	# o_param_b m
	subi	x2, x2, 10	# o_param_b m
	lw	x1, 9(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flw	f2, 8(x2)	# o_param_b m /. d
	fdiv	f1, f1, f2	# o_param_b m /. d
	fneg	f1, f1	# fneg (o_param_b m /. d)
	lw	x4, 2(x2)	# const.(2) <- fneg (o_param_b m /. d)
	fsw	f1, 2(x4)	# const.(2) <- fneg (o_param_b m /. d)
	lw	x5, 0(x2)	# o_param_c m
	addi	x4, x5, 0	# o_param_c m
	sw	x1, 9(x2)	# o_param_c m
	addi	x2, x2, 10	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -2244	# o_param_c m
	subi	x2, x2, 10	# o_param_c m
	lw	x1, 9(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flw	f2, 8(x2)	# o_param_c m /. d
	fdiv	f1, f1, f2	# o_param_c m /. d
	fneg	f1, f1	# fneg (o_param_c m /. d)
	lw	x4, 2(x2)	# const.(3) <- fneg (o_param_c m /. d)
	fsw	f1, 3(x4)	# const.(3) <- fneg (o_param_c m /. d)
	jalr x0, x1, 0	# const.(3) <- fneg (o_param_c m /. d)
# cont:	if fispos d then ( const.(0) <- -1.0 /. d; const.(1) <- fneg (o_param_a m /. d); const.(2) <- fneg (o_param_b m /. d); const.(3) <- fneg (o_param_c m /. d) ) else const.(0) <- 0.0
	jalr	x0, x1, 0	# const
# setup_second_table.2768:	# let rec setup_second_table v m = let const = create_array 5 0.0 in let aa = quadratic m v.(0) v.(1) v.(2) in let c1 = fneg (v.(0) *. o_param_a m) in let c2 = fneg (v.(1) *. o_param_b m) in let c3 = fneg (v.(2) *. o_param_c m) in const.(0) <- aa; (* b' = dirvec^t A start だが、(dirvec^t A)の部分を計算しconst.(1:3)に格納。 b' を求めるにはこのベクトルとstartの内積を取れば良い。符号は逆にする *) if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 ); if not (fiszero aa) then const.(4) <- 1.0 /. aa else (); const
	addi	x6, x0, 5	# 5
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x5, 0(x2)	# create_array 5 0.0
	sw	x4, 1(x2)	# create_array 5 0.0
	# let const = create_array 5 0.0
	addi	x4, x6, 0	# create_array 5 0.0
	sw	x1, 2(x2)	# create_array 5 0.0
	addi	x2, x2, 3	# create_array 5 0.0
	auipc	x31, -1	# create_array 5 0.0
	jalr	x0, x31, -2943	# create_array 5 0.0
	subi	x2, x2, 3	# create_array 5 0.0
	lw	x1, 2(x2)	# create_array 5 0.0
	addi	x4, x4, 0	# create_array 5 0.0
	lw	x5, 1(x2)	# v.(0)
	flw	f1, 0(x5)	# v.(0)
	flw	f2, 1(x5)	# v.(1)
	flw	f3, 2(x5)	# v.(2)
	lw	x6, 0(x2)	# quadratic m v.(0) v.(1) v.(2)
	sw	x4, 2(x2)	# quadratic m v.(0) v.(1) v.(2)
	# let aa = quadratic m v.(0) v.(1) v.(2)
	addi	x4, x6, 0	# quadratic m v.(0) v.(1) v.(2)
	sw	x1, 3(x2)	# quadratic m v.(0) v.(1) v.(2)
	addi	x2, x2, 4	# quadratic m v.(0) v.(1) v.(2)
	jal	x0, -1236	# quadratic m v.(0) v.(1) v.(2)
	subi	x2, x2, 4	# quadratic m v.(0) v.(1) v.(2)
	lw	x1, 3(x2)	# quadratic m v.(0) v.(1) v.(2)
	fmr	f1, f1	# quadratic m v.(0) v.(1) v.(2)
	lw	x4, 1(x2)	# v.(0)
	flw	f2, 0(x4)	# v.(0)
	lw	x5, 0(x2)	# o_param_a m
	fsw	f1, 3(x2)	# o_param_a m
	fsw	f2, 4(x2)	# o_param_a m
	addi	x4, x5, 0	# o_param_a m
	sw	x1, 5(x2)	# o_param_a m
	addi	x2, x2, 6	# o_param_a m
	auipc	x31, -1	# o_param_a m
	jalr	x0, x31, -2296	# o_param_a m
	subi	x2, x2, 6	# o_param_a m
	lw	x1, 5(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flw	f2, 4(x2)	# v.(0) *. o_param_a m
	fmul	f1, f2, f1	# v.(0) *. o_param_a m
	# let c1 = fneg (v.(0) *. o_param_a m)
	fneg	f1, f1	# fneg (v.(0) *. o_param_a m)
	lw	x4, 1(x2)	# v.(1)
	flw	f2, 1(x4)	# v.(1)
	lw	x5, 0(x2)	# o_param_b m
	fsw	f1, 5(x2)	# o_param_b m
	fsw	f2, 6(x2)	# o_param_b m
	addi	x4, x5, 0	# o_param_b m
	sw	x1, 7(x2)	# o_param_b m
	addi	x2, x2, 8	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -2309	# o_param_b m
	subi	x2, x2, 8	# o_param_b m
	lw	x1, 7(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flw	f2, 6(x2)	# v.(1) *. o_param_b m
	fmul	f1, f2, f1	# v.(1) *. o_param_b m
	# let c2 = fneg (v.(1) *. o_param_b m)
	fneg	f1, f1	# fneg (v.(1) *. o_param_b m)
	lw	x4, 1(x2)	# v.(2)
	flw	f2, 2(x4)	# v.(2)
	lw	x5, 0(x2)	# o_param_c m
	fsw	f1, 7(x2)	# o_param_c m
	fsw	f2, 8(x2)	# o_param_c m
	addi	x4, x5, 0	# o_param_c m
	sw	x1, 9(x2)	# o_param_c m
	addi	x2, x2, 10	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -2322	# o_param_c m
	subi	x2, x2, 10	# o_param_c m
	lw	x1, 9(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flw	f2, 8(x2)	# v.(2) *. o_param_c m
	fmul	f1, f2, f1	# v.(2) *. o_param_c m
	# let c3 = fneg (v.(2) *. o_param_c m)
	fneg	f1, f1	# fneg (v.(2) *. o_param_c m)
	lw	x4, 2(x2)	# const.(0) <- aa
	flw	f2, 3(x2)	# const.(0) <- aa
	fsw	f2, 0(x4)	# const.(0) <- aa
	lw	x5, 0(x2)	# o_isrot m
	fsw	f1, 9(x2)	# o_isrot m
	addi	x4, x5, 0	# o_isrot m
	sw	x1, 10(x2)	# o_isrot m
	addi	x2, x2, 11	# o_isrot m
	auipc	x31, -1	# o_isrot m
	jalr	x0, x31, -2346	# o_isrot m
	subi	x2, x2, 11	# o_isrot m
	lw	x1, 10(x2)	# o_isrot m
	addi	x4, x4, 0	# o_isrot m
	bne	x4, x0, 10	# if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 )
# beq:	const.(1) <- c1; const.(2) <- c2; const.(3) <- c3
	lw	x4, 2(x2)	# const.(1) <- c1
	flw	f1, 5(x2)	# const.(1) <- c1
	fsw	f1, 1(x4)	# const.(1) <- c1
	flw	f1, 7(x2)	# const.(2) <- c2
	fsw	f1, 2(x4)	# const.(2) <- c2
	flw	f1, 9(x2)	# const.(3) <- c3
	fsw	f1, 3(x4)	# const.(3) <- c3
	jalr x0, x1, 0	# const.(3) <- c3
	jal	x0, 109	# if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 )
# bne:	const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	lw	x4, 1(x2)	# v.(2)
	flw	f1, 2(x4)	# v.(2)
	lw	x5, 0(x2)	# o_param_r2 m
	fsw	f1, 10(x2)	# o_param_r2 m
	addi	x4, x5, 0	# o_param_r2 m
	sw	x1, 11(x2)	# o_param_r2 m
	addi	x2, x2, 12	# o_param_r2 m
	auipc	x31, -1	# o_param_r2 m
	jalr	x0, x31, -2328	# o_param_r2 m
	subi	x2, x2, 12	# o_param_r2 m
	lw	x1, 11(x2)	# o_param_r2 m
	fmr	f1, f1	# o_param_r2 m
	flw	f2, 10(x2)	# v.(2) *. o_param_r2 m
	fmul	f1, f2, f1	# v.(2) *. o_param_r2 m
	lw	x4, 1(x2)	# v.(1)
	flw	f2, 1(x4)	# v.(1)
	lw	x5, 0(x2)	# o_param_r3 m
	fsw	f1, 11(x2)	# o_param_r3 m
	fsw	f2, 12(x2)	# o_param_r3 m
	addi	x4, x5, 0	# o_param_r3 m
	sw	x1, 13(x2)	# o_param_r3 m
	addi	x2, x2, 14	# o_param_r3 m
	auipc	x31, -1	# o_param_r3 m
	jalr	x0, x31, -2340	# o_param_r3 m
	subi	x2, x2, 14	# o_param_r3 m
	lw	x1, 13(x2)	# o_param_r3 m
	fmr	f1, f1	# o_param_r3 m
	flw	f2, 12(x2)	# v.(1) *. o_param_r3 m
	fmul	f1, f2, f1	# v.(1) *. o_param_r3 m
	flw	f2, 11(x2)	# v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m
	fadd	f1, f2, f1	# v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m
	fmul	f1, f1, f27	# fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	flw	f2, 5(x2)	# c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	fsub	f1, f2, f1	# c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	lw	x4, 2(x2)	# const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	fsw	f1, 1(x4)	# const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m)
	lw	x5, 1(x2)	# v.(2)
	flw	f1, 2(x5)	# v.(2)
	lw	x6, 0(x2)	# o_param_r1 m
	fsw	f1, 13(x2)	# o_param_r1 m
	addi	x4, x6, 0	# o_param_r1 m
	sw	x1, 14(x2)	# o_param_r1 m
	addi	x2, x2, 15	# o_param_r1 m
	auipc	x31, -1	# o_param_r1 m
	jalr	x0, x31, -2367	# o_param_r1 m
	subi	x2, x2, 15	# o_param_r1 m
	lw	x1, 14(x2)	# o_param_r1 m
	fmr	f1, f1	# o_param_r1 m
	flw	f2, 13(x2)	# v.(2) *. o_param_r1 m
	fmul	f1, f2, f1	# v.(2) *. o_param_r1 m
	lw	x4, 1(x2)	# v.(0)
	flw	f2, 0(x4)	# v.(0)
	lw	x5, 0(x2)	# o_param_r3 m
	fsw	f1, 14(x2)	# o_param_r3 m
	fsw	f2, 15(x2)	# o_param_r3 m
	addi	x4, x5, 0	# o_param_r3 m
	sw	x1, 16(x2)	# o_param_r3 m
	addi	x2, x2, 17	# o_param_r3 m
	auipc	x31, -1	# o_param_r3 m
	jalr	x0, x31, -2376	# o_param_r3 m
	subi	x2, x2, 17	# o_param_r3 m
	lw	x1, 16(x2)	# o_param_r3 m
	fmr	f1, f1	# o_param_r3 m
	flw	f2, 15(x2)	# v.(0) *. o_param_r3 m
	fmul	f1, f2, f1	# v.(0) *. o_param_r3 m
	flw	f2, 14(x2)	# v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m
	fadd	f1, f2, f1	# v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m
	fmul	f1, f1, f27	# fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	flw	f2, 7(x2)	# c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	fsub	f1, f2, f1	# c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	lw	x4, 2(x2)	# const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	fsw	f1, 2(x4)	# const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m)
	lw	x5, 1(x2)	# v.(1)
	flw	f1, 1(x5)	# v.(1)
	lw	x6, 0(x2)	# o_param_r1 m
	fsw	f1, 16(x2)	# o_param_r1 m
	addi	x4, x6, 0	# o_param_r1 m
	sw	x1, 17(x2)	# o_param_r1 m
	addi	x2, x2, 18	# o_param_r1 m
	auipc	x31, -1	# o_param_r1 m
	jalr	x0, x31, -2403	# o_param_r1 m
	subi	x2, x2, 18	# o_param_r1 m
	lw	x1, 17(x2)	# o_param_r1 m
	fmr	f1, f1	# o_param_r1 m
	flw	f2, 16(x2)	# v.(1) *. o_param_r1 m
	fmul	f1, f2, f1	# v.(1) *. o_param_r1 m
	lw	x4, 1(x2)	# v.(0)
	flw	f2, 0(x4)	# v.(0)
	lw	x4, 0(x2)	# o_param_r2 m
	fsw	f1, 17(x2)	# o_param_r2 m
	fsw	f2, 18(x2)	# o_param_r2 m
	sw	x1, 19(x2)	# o_param_r2 m
	addi	x2, x2, 20	# o_param_r2 m
	auipc	x31, -1	# o_param_r2 m
	jalr	x0, x31, -2415	# o_param_r2 m
	subi	x2, x2, 20	# o_param_r2 m
	lw	x1, 19(x2)	# o_param_r2 m
	fmr	f1, f1	# o_param_r2 m
	flw	f2, 18(x2)	# v.(0) *. o_param_r2 m
	fmul	f1, f2, f1	# v.(0) *. o_param_r2 m
	flw	f2, 17(x2)	# v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m
	fadd	f1, f2, f1	# v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m
	fmul	f1, f1, f27	# fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	flw	f2, 9(x2)	# c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	fsub	f1, f2, f1	# c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	lw	x4, 2(x2)	# const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	fsw	f1, 3(x4)	# const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
	jalr x0, x1, 0	# const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m)
# cont:	if o_isrot m <> 0 then ( const.(1) <- c1 -. fhalf (v.(2) *. o_param_r2 m +. v.(1) *. o_param_r3 m); const.(2) <- c2 -. fhalf (v.(2) *. o_param_r1 m +. v.(0) *. o_param_r3 m); const.(3) <- c3 -. fhalf (v.(1) *. o_param_r1 m +. v.(0) *. o_param_r2 m) ) else ( const.(1) <- c1; const.(2) <- c2; const.(3) <- c3 )
	flw	f1, 3(x2)	# fiszero aa
	feq	x5, f1, f0	# fiszero aa
	bne	x5, x0, 5	# if not (fiszero aa) then const.(4) <- 1.0 /. aa else ()
# beq:	const.(4) <- 1.0 /. aa
	fdiv	f1, f11, f1	# 1.0 /. aa
	fsw	f1, 4(x4)	# const.(4) <- 1.0 /. aa
	jalr x0, x1, 0	# const.(4) <- 1.0 /. aa
	jal	x0, 2	# if not (fiszero aa) then const.(4) <- 1.0 /. aa else ()
# bne:	()
	jalr x0, x1, 0	# ()
# cont:	if not (fiszero aa) then const.(4) <- 1.0 /. aa else ()
	jalr	x0, x1, 0	# const
# iter_setup_dirvec_constants.2771:	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	lw	x6, 4(x29)	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	bge	x5, x0, 2	# if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1)
	# let m = objects.(index)
	lwa	x6, (x6, x5)	# objects.(index)
	sw	x29, 0(x2)	# d_const dirvec
	sw	x5, 1(x2)	# d_const dirvec
	sw	x6, 2(x2)	# d_const dirvec
	sw	x4, 3(x2)	# d_const dirvec
	# let dconst = (d_const dirvec)
	sw	x1, 4(x2)	# d_const dirvec
	addi	x2, x2, 5	# d_const dirvec
	auipc	x31, -1	# d_const dirvec
	jalr	x0, x31, -2419	# d_const dirvec
	subi	x2, x2, 5	# d_const dirvec
	lw	x1, 4(x2)	# d_const dirvec
	addi	x4, x4, 0	# d_const dirvec
	lw	x5, 3(x2)	# d_vec dirvec
	sw	x4, 4(x2)	# d_vec dirvec
	# let v = d_vec dirvec
	addi	x4, x5, 0	# d_vec dirvec
	sw	x1, 5(x2)	# d_vec dirvec
	addi	x2, x2, 6	# d_vec dirvec
	auipc	x31, -1	# d_vec dirvec
	jalr	x0, x31, -2430	# d_vec dirvec
	subi	x2, x2, 6	# d_vec dirvec
	lw	x1, 5(x2)	# d_vec dirvec
	addi	x4, x4, 0	# d_vec dirvec
	lw	x5, 2(x2)	# o_form m
	sw	x4, 5(x2)	# o_form m
	# let m_shape = o_form m
	addi	x4, x5, 0	# o_form m
	sw	x1, 6(x2)	# o_form m
	addi	x2, x2, 7	# o_form m
	auipc	x31, -1	# o_form m
	jalr	x0, x31, -2514	# o_form m
	subi	x2, x2, 7	# o_form m
	lw	x1, 6(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 1	# 1
	bne	x4, x5, 14	# if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# beq:	dconst.(index) <- setup_rect_table v m
	lw	x4, 5(x2)	# setup_rect_table v m
	lw	x5, 2(x2)	# setup_rect_table v m
	sw	x1, 6(x2)	# setup_rect_table v m
	addi	x2, x2, 7	# setup_rect_table v m
	jal	x0, -532	# setup_rect_table v m
	subi	x2, x2, 7	# setup_rect_table v m
	lw	x1, 6(x2)	# setup_rect_table v m
	addi	x4, x4, 0	# setup_rect_table v m
	lw	x5, 1(x2)	# dconst.(index) <- setup_rect_table v m
	lw	x6, 4(x2)	# dconst.(index) <- setup_rect_table v m
	swa	x4, (x6, x5)	# dconst.(index) <- setup_rect_table v m
	jalr x0, x1, 0	# dconst.(index) <- setup_rect_table v m
	jal	x0, 27	# if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# bne:	if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
	addi	x5, x0, 2	# 2
	bne	x4, x5, 13	# if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
# beq:	dconst.(index) <- setup_surface_table v m
	lw	x4, 5(x2)	# setup_surface_table v m
	lw	x5, 2(x2)	# setup_surface_table v m
	sw	x1, 6(x2)	# setup_surface_table v m
	addi	x2, x2, 7	# setup_surface_table v m
	jal	x0, -393	# setup_surface_table v m
	subi	x2, x2, 7	# setup_surface_table v m
	lw	x1, 6(x2)	# setup_surface_table v m
	addi	x4, x4, 0	# setup_surface_table v m
	lw	x5, 1(x2)	# dconst.(index) <- setup_surface_table v m
	lw	x6, 4(x2)	# dconst.(index) <- setup_surface_table v m
	swa	x4, (x6, x5)	# dconst.(index) <- setup_surface_table v m
	jalr x0, x1, 0	# dconst.(index) <- setup_surface_table v m
# bne:	dconst.(index) <- setup_second_table v m
	lw	x4, 5(x2)	# setup_second_table v m
	lw	x5, 2(x2)	# setup_second_table v m
	sw	x1, 6(x2)	# setup_second_table v m
	addi	x2, x2, 7	# setup_second_table v m
	jal	x0, -285	# setup_second_table v m
	subi	x2, x2, 7	# setup_second_table v m
	lw	x1, 6(x2)	# setup_second_table v m
	addi	x4, x4, 0	# setup_second_table v m
	lw	x5, 1(x2)	# dconst.(index) <- setup_second_table v m
	lw	x6, 4(x2)	# dconst.(index) <- setup_second_table v m
	swa	x4, (x6, x5)	# dconst.(index) <- setup_second_table v m
	jalr x0, x1, 0	# dconst.(index) <- setup_second_table v m
# cont:	if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m
	addi	x5, x5, -1	# index - 1
	lw	x4, 3(x2)	# iter_setup_dirvec_constants dirvec (index - 1)
	lw	x29, 0(x2)	# iter_setup_dirvec_constants dirvec (index - 1)
	lw	x31, 0(x29)	# iter_setup_dirvec_constants dirvec (index - 1)
	jalr	x0, x31, 0	# iter_setup_dirvec_constants dirvec (index - 1)
# setup_dirvec_constants.2774:	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	lw	x5, 5(x29)	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	lw	x29, 4(x29)	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	lw	x5, 0(x5)	# n_objects.(0)
	addi	x5, x5, -1	# n_objects.(0) - 1
	lw	x31, 0(x29)	# iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	jalr	x0, x31, 0	# iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
# setup_startp_constants.2776:	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	lw	x6, 4(x29)	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	bge	x5, x0, 2	# if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1)
	# let obj = objects.(index)
	lwa	x6, (x6, x5)	# objects.(index)
	sw	x29, 0(x2)	# o_param_ctbl obj
	sw	x5, 1(x2)	# o_param_ctbl obj
	sw	x4, 2(x2)	# o_param_ctbl obj
	sw	x6, 3(x2)	# o_param_ctbl obj
	# let sconst = o_param_ctbl obj
	addi	x4, x6, 0	# o_param_ctbl obj
	sw	x1, 4(x2)	# o_param_ctbl obj
	addi	x2, x2, 5	# o_param_ctbl obj
	auipc	x31, -1	# o_param_ctbl obj
	jalr	x0, x31, -2530	# o_param_ctbl obj
	subi	x2, x2, 5	# o_param_ctbl obj
	lw	x1, 4(x2)	# o_param_ctbl obj
	addi	x4, x4, 0	# o_param_ctbl obj
	lw	x5, 3(x2)	# o_form obj
	sw	x4, 4(x2)	# o_form obj
	# let m_shape = o_form obj
	addi	x4, x5, 0	# o_form obj
	sw	x1, 5(x2)	# o_form obj
	addi	x2, x2, 6	# o_form obj
	auipc	x31, -1	# o_form obj
	jalr	x0, x31, -2592	# o_form obj
	subi	x2, x2, 6	# o_form obj
	lw	x1, 5(x2)	# o_form obj
	addi	x4, x4, 0	# o_form obj
	lw	x5, 2(x2)	# p.(0)
	flw	f1, 0(x5)	# p.(0)
	lw	x6, 3(x2)	# o_param_x obj
	sw	x4, 5(x2)	# o_param_x obj
	fsw	f1, 6(x2)	# o_param_x obj
	addi	x4, x6, 0	# o_param_x obj
	sw	x1, 7(x2)	# o_param_x obj
	addi	x2, x2, 8	# o_param_x obj
	auipc	x31, -1	# o_param_x obj
	jalr	x0, x31, -2586	# o_param_x obj
	subi	x2, x2, 8	# o_param_x obj
	lw	x1, 7(x2)	# o_param_x obj
	fmr	f1, f1	# o_param_x obj
	flw	f2, 6(x2)	# p.(0) -. o_param_x obj
	fsub	f1, f2, f1	# p.(0) -. o_param_x obj
	lw	x4, 4(x2)	# sconst.(0) <- p.(0) -. o_param_x obj
	fsw	f1, 0(x4)	# sconst.(0) <- p.(0) -. o_param_x obj
	lw	x5, 2(x2)	# p.(1)
	flw	f1, 1(x5)	# p.(1)
	lw	x6, 3(x2)	# o_param_y obj
	fsw	f1, 7(x2)	# o_param_y obj
	addi	x4, x6, 0	# o_param_y obj
	sw	x1, 8(x2)	# o_param_y obj
	addi	x2, x2, 9	# o_param_y obj
	auipc	x31, -1	# o_param_y obj
	jalr	x0, x31, -2599	# o_param_y obj
	subi	x2, x2, 9	# o_param_y obj
	lw	x1, 8(x2)	# o_param_y obj
	fmr	f1, f1	# o_param_y obj
	flw	f2, 7(x2)	# p.(1) -. o_param_y obj
	fsub	f1, f2, f1	# p.(1) -. o_param_y obj
	lw	x4, 4(x2)	# sconst.(1) <- p.(1) -. o_param_y obj
	fsw	f1, 1(x4)	# sconst.(1) <- p.(1) -. o_param_y obj
	lw	x5, 2(x2)	# p.(2)
	flw	f1, 2(x5)	# p.(2)
	lw	x6, 3(x2)	# o_param_z obj
	fsw	f1, 8(x2)	# o_param_z obj
	addi	x4, x6, 0	# o_param_z obj
	sw	x1, 9(x2)	# o_param_z obj
	addi	x2, x2, 10	# o_param_z obj
	auipc	x31, -1	# o_param_z obj
	jalr	x0, x31, -2612	# o_param_z obj
	subi	x2, x2, 10	# o_param_z obj
	lw	x1, 9(x2)	# o_param_z obj
	fmr	f1, f1	# o_param_z obj
	flw	f2, 8(x2)	# p.(2) -. o_param_z obj
	fsub	f1, f2, f1	# p.(2) -. o_param_z obj
	lw	x4, 4(x2)	# sconst.(2) <- p.(2) -. o_param_z obj
	fsw	f1, 2(x4)	# sconst.(2) <- p.(2) -. o_param_z obj
	addi	x5, x0, 2	# 2
	lw	x6, 5(x2)	# if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
	bne	x6, x5, 25	# if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# beq:	sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	lw	x5, 3(x2)	# o_param_abc obj
	addi	x4, x5, 0	# o_param_abc obj
	sw	x1, 9(x2)	# o_param_abc obj
	addi	x2, x2, 10	# o_param_abc obj
	auipc	x31, -1	# o_param_abc obj
	jalr	x0, x31, -2636	# o_param_abc obj
	subi	x2, x2, 10	# o_param_abc obj
	lw	x1, 9(x2)	# o_param_abc obj
	addi	x4, x4, 0	# o_param_abc obj
	lw	x5, 4(x2)	# sconst.(0)
	flw	f1, 0(x5)	# sconst.(0)
	flw	f2, 1(x5)	# sconst.(1)
	flw	f3, 2(x5)	# sconst.(2)
	sw	x1, 9(x2)	# veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	addi	x2, x2, 10	# veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	auipc	x31, -1	# veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	jalr	x0, x31, -2734	# veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	subi	x2, x2, 10	# veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	lw	x1, 9(x2)	# veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	fmr	f1, f1	# veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	lw	x4, 4(x2)	# sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	fsw	f1, 3(x4)	# sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	jalr x0, x1, 0	# sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2)
	jal	x0, 25	# if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# bne:	if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
	addi	x5, x0, 2	# 2
	bge	x5, x6, 22	# if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
# blt:	let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0
	flw	f1, 0(x4)	# sconst.(0)
	flw	f2, 1(x4)	# sconst.(1)
	flw	f3, 2(x4)	# sconst.(2)
	lw	x5, 3(x2)	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	# let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2)
	addi	x4, x5, 0	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	sw	x1, 9(x2)	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	addi	x2, x2, 10	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	jal	x0, -1626	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	subi	x2, x2, 10	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	lw	x1, 9(x2)	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	fmr	f1, f1	# quadratic obj sconst.(0) sconst.(1) sconst.(2)
	addi	x4, x0, 3	# 3
	lw	x5, 5(x2)	# if m_shape = 3 then cc0 -. 1.0 else cc0
	bne	x5, x4, 4	# if m_shape = 3 then cc0 -. 1.0 else cc0
# beq:	cc0 -. 1.0
	fsub	f1, f1, f11	# cc0 -. 1.0
	jalr	x0, x1, 0	# cc0 -. 1.0
	jal	x0, 2	# if m_shape = 3 then cc0 -. 1.0 else cc0
# bne:	cc0
	jalr	x0, x1, 0	# cc0
# cont:	if m_shape = 3 then cc0 -. 1.0 else cc0
	lw	x4, 4(x2)	# sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0
	fsw	f1, 3(x4)	# sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0
	jalr x0, x1, 0	# sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0
# bge:	()
	jalr x0, x1, 0	# ()
# cont:	if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else ()
	lw	x4, 1(x2)	# index - 1
	addi	x5, x4, -1	# index - 1
	lw	x4, 2(x2)	# setup_startp_constants p (index - 1)
	lw	x29, 0(x2)	# setup_startp_constants p (index - 1)
	lw	x31, 0(x29)	# setup_startp_constants p (index - 1)
	jalr	x0, x31, 0	# setup_startp_constants p (index - 1)
# setup_startp.2779:	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	lw	x5, 6(x29)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	lw	x6, 5(x29)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	lw	x7, 4(x29)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	sw	x4, 0(x2)	# veccpy startp_fast p
	sw	x6, 1(x2)	# veccpy startp_fast p
	sw	x7, 2(x2)	# veccpy startp_fast p
	addi	x30, x5, 0	# veccpy startp_fast p
	addi	x5, x4, 0	# veccpy startp_fast p
	addi	x4, x30, 0	# veccpy startp_fast p
	sw	x1, 3(x2)	# veccpy startp_fast p
	addi	x2, x2, 4	# veccpy startp_fast p
	auipc	x31, -1	# veccpy startp_fast p
	jalr	x0, x31, -2834	# veccpy startp_fast p
	subi	x2, x2, 4	# veccpy startp_fast p
	lw	x1, 3(x2)	# veccpy startp_fast p
	addi	x0, x4, 0	# veccpy startp_fast p
	lw	x4, 2(x2)	# n_objects.(0)
	lw	x4, 0(x4)	# n_objects.(0)
	addi	x5, x4, -1	# n_objects.(0) - 1
	lw	x4, 0(x2)	# setup_startp_constants p (n_objects.(0) - 1)
	lw	x29, 1(x2)	# setup_startp_constants p (n_objects.(0) - 1)
	lw	x31, 0(x29)	# setup_startp_constants p (n_objects.(0) - 1)
	jalr	x0, x31, 0	# setup_startp_constants p (n_objects.(0) - 1)
# is_rect_outside.2781:	# let rec is_rect_outside m p0 p1 p2 = if if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false then o_isinvert m else not (o_isinvert m)
	fabs	f1, f1	# fabs p0
	fsw	f3, 0(x2)	# o_param_a m
	sw	x4, 1(x2)	# o_param_a m
	fsw	f2, 2(x2)	# o_param_a m
	sw	x1, 3(x2)	# o_param_a m
	addi	x2, x2, 4	# o_param_a m
	auipc	x31, -1	# o_param_a m
	jalr	x0, x31, -2725	# o_param_a m
	subi	x2, x2, 4	# o_param_a m
	lw	x1, 3(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flt	x4, f1, f1	# fless (fabs p0) (o_param_a m)
	bne	x4, x0, 4	# if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
	jal	x0, 27	# if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false
# bne:	if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false
	flw	f1, 2(x2)	# fabs p1
	fabs	f1, f1	# fabs p1
	lw	x4, 1(x2)	# o_param_b m
	sw	x1, 3(x2)	# o_param_b m
	addi	x2, x2, 4	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -2737	# o_param_b m
	subi	x2, x2, 4	# o_param_b m
	lw	x1, 3(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flt	x4, f1, f1	# fless (fabs p1) (o_param_b m)
	bne	x4, x0, 3	# if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	fless (fabs p2) (o_param_c m)
	flw	f1, 0(x2)	# fabs p2
	fabs	f1, f1	# fabs p2
	lw	x4, 1(x2)	# o_param_c m
	sw	x1, 3(x2)	# o_param_c m
	addi	x2, x2, 4	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -2748	# o_param_c m
	subi	x2, x2, 4	# o_param_c m
	lw	x1, 3(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flt	x4, f1, f1	# fless (fabs p2) (o_param_c m)
	jalr	x0, x1, 0	# fless (fabs p2) (o_param_c m)
# cont:	if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false
	bne	x4, x0, 11	# if if (fless (fabs p0) (o_param_a m)) then if (fless (fabs p1) (o_param_b m)) then fless (fabs p2) (o_param_c m) else false else false then o_isinvert m else not (o_isinvert m)
# beq:	not (o_isinvert m)
	lw	x4, 1(x2)	# o_isinvert m
	sw	x1, 3(x2)	# o_isinvert m
	addi	x2, x2, 4	# o_isinvert m
	auipc	x31, -1	# o_isinvert m
	jalr	x0, x31, -2769	# o_isinvert m
	subi	x2, x2, 4	# o_isinvert m
	lw	x1, 3(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	xori	x4, x4, -1	# not (o_isinvert m)
	jalr	x0, x1, 0	# not (o_isinvert m)
# bne:	o_isinvert m
	lw	x4, 1(x2)	# o_isinvert m
	auipc	x31, -1	# o_isinvert m
	jalr	x0, x31, -2774	# o_isinvert m
# is_plane_outside.2786:	# let rec is_plane_outside m p0 p1 p2 = let w = veciprod2 (o_param_abc m) p0 p1 p2 in not (xor (o_isinvert m) (fisneg w))
	sw	x4, 0(x2)	# o_param_abc m
	fsw	f3, 1(x2)	# o_param_abc m
	fsw	f2, 2(x2)	# o_param_abc m
	fsw	f1, 3(x2)	# o_param_abc m
	sw	x1, 4(x2)	# o_param_abc m
	addi	x2, x2, 5	# o_param_abc m
	auipc	x31, -1	# o_param_abc m
	jalr	x0, x31, -2772	# o_param_abc m
	subi	x2, x2, 5	# o_param_abc m
	lw	x1, 4(x2)	# o_param_abc m
	addi	x4, x4, 0	# o_param_abc m
	flw	f1, 3(x2)	# veciprod2 (o_param_abc m) p0 p1 p2
	flw	f2, 2(x2)	# veciprod2 (o_param_abc m) p0 p1 p2
	flw	f3, 1(x2)	# veciprod2 (o_param_abc m) p0 p1 p2
	# let w = veciprod2 (o_param_abc m) p0 p1 p2
	sw	x1, 4(x2)	# veciprod2 (o_param_abc m) p0 p1 p2
	addi	x2, x2, 5	# veciprod2 (o_param_abc m) p0 p1 p2
	auipc	x31, -1	# veciprod2 (o_param_abc m) p0 p1 p2
	jalr	x0, x31, -2868	# veciprod2 (o_param_abc m) p0 p1 p2
	subi	x2, x2, 5	# veciprod2 (o_param_abc m) p0 p1 p2
	lw	x1, 4(x2)	# veciprod2 (o_param_abc m) p0 p1 p2
	fmr	f1, f1	# veciprod2 (o_param_abc m) p0 p1 p2
	lw	x4, 0(x2)	# o_isinvert m
	sw	x1, 4(x2)	# o_isinvert m
	addi	x2, x2, 5	# o_isinvert m
	auipc	x31, -1	# o_isinvert m
	jalr	x0, x31, -2803	# o_isinvert m
	subi	x2, x2, 5	# o_isinvert m
	lw	x1, 4(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	flt	x5, f0, f0	# fisneg w
	xor	x4, x4, x5	# xor (o_isinvert m) (fisneg w)
	xori	x4, x4, -1	# not (xor (o_isinvert m) (fisneg w))
	jalr	x0, x1, 0	# not (xor (o_isinvert m) (fisneg w))
# is_second_outside.2791:	# let rec is_second_outside m p0 p1 p2 = let w = quadratic m p0 p1 p2 in let w2 = if o_form m = 3 then w -. 1.0 else w in not (xor (o_isinvert m) (fisneg w2))
	sw	x4, 0(x2)	# quadratic m p0 p1 p2
	# let w = quadratic m p0 p1 p2
	sw	x1, 1(x2)	# quadratic m p0 p1 p2
	addi	x2, x2, 2	# quadratic m p0 p1 p2
	jal	x0, -1763	# quadratic m p0 p1 p2
	subi	x2, x2, 2	# quadratic m p0 p1 p2
	lw	x1, 1(x2)	# quadratic m p0 p1 p2
	fmr	f1, f1	# quadratic m p0 p1 p2
	lw	x4, 0(x2)	# o_form m
	fsw	f1, 1(x2)	# o_form m
	sw	x1, 2(x2)	# o_form m
	addi	x2, x2, 3	# o_form m
	auipc	x31, -1	# o_form m
	jalr	x0, x31, -2827	# o_form m
	subi	x2, x2, 3	# o_form m
	lw	x1, 2(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 3	# 3
	# let w2 = if o_form m = 3 then w -. 1.0 else w
	bne	x4, x5, 5	# if o_form m = 3 then w -. 1.0 else w
# beq:	w -. 1.0
	flw	f1, 1(x2)	# w -. 1.0
	fsub	f1, f1, f11	# w -. 1.0
	jalr	x0, x1, 0	# w -. 1.0
	jal	x0, 3	# if o_form m = 3 then w -. 1.0 else w
# bne:	w
	flw	f1, 1(x2)	# w
	jalr	x0, x1, 0	# w
# cont:	if o_form m = 3 then w -. 1.0 else w
	lw	x4, 0(x2)	# o_isinvert m
	sw	x1, 2(x2)	# o_isinvert m
	addi	x2, x2, 3	# o_isinvert m
	auipc	x31, -1	# o_isinvert m
	jalr	x0, x31, -2839	# o_isinvert m
	subi	x2, x2, 3	# o_isinvert m
	lw	x1, 2(x2)	# o_isinvert m
	addi	x4, x4, 0	# o_isinvert m
	flt	x5, f0, f0	# fisneg w2
	xor	x4, x4, x5	# xor (o_isinvert m) (fisneg w2)
	xori	x4, x4, -1	# not (xor (o_isinvert m) (fisneg w2))
	jalr	x0, x1, 0	# not (xor (o_isinvert m) (fisneg w2))
# is_outside.2796:	# let rec is_outside m q0 q1 q2 = let p0 = q0 -. o_param_x m in let p1 = q1 -. o_param_y m in let p2 = q2 -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then is_rect_outside m p0 p1 p2 else if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
	fsw	f3, 0(x2)	# o_param_x m
	fsw	f2, 1(x2)	# o_param_x m
	sw	x4, 2(x2)	# o_param_x m
	fsw	f1, 3(x2)	# o_param_x m
	sw	x1, 4(x2)	# o_param_x m
	addi	x2, x2, 5	# o_param_x m
	auipc	x31, -1	# o_param_x m
	jalr	x0, x31, -2839	# o_param_x m
	subi	x2, x2, 5	# o_param_x m
	lw	x1, 4(x2)	# o_param_x m
	fmr	f1, f1	# o_param_x m
	flw	f2, 3(x2)	# q0 -. o_param_x m
	# let p0 = q0 -. o_param_x m
	fsub	f1, f2, f1	# q0 -. o_param_x m
	lw	x4, 2(x2)	# o_param_y m
	fsw	f1, 4(x2)	# o_param_y m
	sw	x1, 5(x2)	# o_param_y m
	addi	x2, x2, 6	# o_param_y m
	auipc	x31, -1	# o_param_y m
	jalr	x0, x31, -2847	# o_param_y m
	subi	x2, x2, 6	# o_param_y m
	lw	x1, 5(x2)	# o_param_y m
	fmr	f1, f1	# o_param_y m
	flw	f2, 1(x2)	# q1 -. o_param_y m
	# let p1 = q1 -. o_param_y m
	fsub	f1, f2, f1	# q1 -. o_param_y m
	lw	x4, 2(x2)	# o_param_z m
	fsw	f1, 5(x2)	# o_param_z m
	sw	x1, 6(x2)	# o_param_z m
	addi	x2, x2, 7	# o_param_z m
	auipc	x31, -1	# o_param_z m
	jalr	x0, x31, -2855	# o_param_z m
	subi	x2, x2, 7	# o_param_z m
	lw	x1, 6(x2)	# o_param_z m
	fmr	f1, f1	# o_param_z m
	flw	f2, 0(x2)	# q2 -. o_param_z m
	# let p2 = q2 -. o_param_z m
	fsub	f1, f2, f1	# q2 -. o_param_z m
	lw	x4, 2(x2)	# o_form m
	fsw	f1, 6(x2)	# o_form m
	# let m_shape = o_form m
	sw	x1, 7(x2)	# o_form m
	addi	x2, x2, 8	# o_form m
	auipc	x31, -1	# o_form m
	jalr	x0, x31, -2891	# o_form m
	subi	x2, x2, 8	# o_form m
	lw	x1, 7(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 1	# 1
	bne	x4, x5, 6	# if m_shape = 1 then is_rect_outside m p0 p1 p2 else if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
# beq:	is_rect_outside m p0 p1 p2
	flw	f1, 4(x2)	# is_rect_outside m p0 p1 p2
	flw	f2, 5(x2)	# is_rect_outside m p0 p1 p2
	flw	f3, 6(x2)	# is_rect_outside m p0 p1 p2
	lw	x4, 2(x2)	# is_rect_outside m p0 p1 p2
	jal	x0, -175	# is_rect_outside m p0 p1 p2
# bne:	if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
	addi	x5, x0, 2	# 2
	bne	x4, x5, 6	# if m_shape = 2 then is_plane_outside m p0 p1 p2 else is_second_outside m p0 p1 p2
# beq:	is_plane_outside m p0 p1 p2
	flw	f1, 4(x2)	# is_plane_outside m p0 p1 p2
	flw	f2, 5(x2)	# is_plane_outside m p0 p1 p2
	flw	f3, 6(x2)	# is_plane_outside m p0 p1 p2
	lw	x4, 2(x2)	# is_plane_outside m p0 p1 p2
	jal	x0, -126	# is_plane_outside m p0 p1 p2
# bne:	is_second_outside m p0 p1 p2
	flw	f1, 4(x2)	# is_second_outside m p0 p1 p2
	flw	f2, 5(x2)	# is_second_outside m p0 p1 p2
	flw	f3, 6(x2)	# is_second_outside m p0 p1 p2
	lw	x4, 2(x2)	# is_second_outside m p0 p1 p2
	jal	x0, -98	# is_second_outside m p0 p1 p2
# check_all_inside.2801:	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	lw	x6, 4(x29)	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	# let head = iand.(ofs)
	lwa	x7, (x5, x4)	# iand.(ofs)
	addi	x8, x0, -1	# -1
	bne	x7, x8, 3	# if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
# beq:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# bne:	if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2
	lwa	x6, (x6, x7)	# objects.(head)
	fsw	f3, 0(x2)	# is_outside objects.(head) q0 q1 q2
	fsw	f2, 1(x2)	# is_outside objects.(head) q0 q1 q2
	fsw	f1, 2(x2)	# is_outside objects.(head) q0 q1 q2
	sw	x5, 3(x2)	# is_outside objects.(head) q0 q1 q2
	sw	x29, 4(x2)	# is_outside objects.(head) q0 q1 q2
	sw	x4, 5(x2)	# is_outside objects.(head) q0 q1 q2
	addi	x4, x6, 0	# is_outside objects.(head) q0 q1 q2
	sw	x1, 6(x2)	# is_outside objects.(head) q0 q1 q2
	addi	x2, x2, 7	# is_outside objects.(head) q0 q1 q2
	jal	x0, -81	# is_outside objects.(head) q0 q1 q2
	subi	x2, x2, 7	# is_outside objects.(head) q0 q1 q2
	lw	x1, 6(x2)	# is_outside objects.(head) q0 q1 q2
	addi	x4, x4, 0	# is_outside objects.(head) q0 q1 q2
	bne	x4, x0, 10	# if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2
# beq:	check_all_inside (ofs + 1) iand q0 q1 q2
	lw	x4, 5(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	flw	f1, 2(x2)	# check_all_inside (ofs + 1) iand q0 q1 q2
	flw	f2, 1(x2)	# check_all_inside (ofs + 1) iand q0 q1 q2
	flw	f3, 0(x2)	# check_all_inside (ofs + 1) iand q0 q1 q2
	lw	x5, 3(x2)	# check_all_inside (ofs + 1) iand q0 q1 q2
	lw	x29, 4(x2)	# check_all_inside (ofs + 1) iand q0 q1 q2
	lw	x31, 0(x29)	# check_all_inside (ofs + 1) iand q0 q1 q2
	jalr	x0, x31, 0	# check_all_inside (ofs + 1) iand q0 q1 q2
# bne:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# shadow_check_and_group.2807:	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x6, 10(x29)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x7, 9(x29)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x8, 8(x29)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x9, 7(x29)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x10, 6(x29)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x11, 5(x29)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x12, 4(x29)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lwa	x13, (x5, x4)	# and_group.(iand_ofs)
	addi	x14, x0, -1	# -1
	bne	x13, x14, 3	# if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	# let obj = and_group.(iand_ofs)
	lwa	x13, (x5, x4)	# and_group.(iand_ofs)
	sw	x12, 0(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x11, 1(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x10, 2(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x5, 3(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x29, 4(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x4, 5(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x13, 6(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x8, 7(x2)	# solver_fast obj light_dirvec intersection_point
	sw	x7, 8(x2)	# solver_fast obj light_dirvec intersection_point
	# let t0 = solver_fast obj light_dirvec intersection_point
	addi	x5, x9, 0	# solver_fast obj light_dirvec intersection_point
	addi	x4, x13, 0	# solver_fast obj light_dirvec intersection_point
	addi	x29, x6, 0	# solver_fast obj light_dirvec intersection_point
	addi	x6, x11, 0	# solver_fast obj light_dirvec intersection_point
	sw	x1, 9(x2)	# solver_fast obj light_dirvec intersection_point
	addi	x2, x2, 10	# solver_fast obj light_dirvec intersection_point
	lw	x31, 0(x29)	# solver_fast obj light_dirvec intersection_point
	jalr	x1, x31, 0	# solver_fast obj light_dirvec intersection_point
	subi	x2, x2, 10	# solver_fast obj light_dirvec intersection_point
	lw	x1, 9(x2)	# solver_fast obj light_dirvec intersection_point
	addi	x4, x4, 0	# solver_fast obj light_dirvec intersection_point
	lw	x5, 8(x2)	# solver_dist.(0)
	# let t0p = solver_dist.(0)
	flw	f1, 0(x5)	# solver_dist.(0)
	bne	x4, x0, 4	# if t0 <> 0 then fless t0p (-0.2) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
	jal	x0, 6	# if t0 <> 0 then fless t0p (-0.2) else false
# bne:	fless t0p (-0.2)
	lui	x31, -269107	# -0.2
	addi	x31, x31, -1102263091	# -0.2
	mvitof	f2, x31	# -0.2
	flt	x4, f2, f2	# fless t0p (-0.2)
	jalr	x0, x1, 0	# fless t0p (-0.2)
# cont:	if t0 <> 0 then fless t0p (-0.2) else false
	bne	x4, x0, 20	# if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
# beq:	if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x4, 6(x2)	# objects.(obj)
	lw	x5, 7(x2)	# objects.(obj)
	lwa	x4, (x5, x4)	# objects.(obj)
	sw	x1, 9(x2)	# o_isinvert (objects.(obj))
	addi	x2, x2, 10	# o_isinvert (objects.(obj))
	auipc	x31, -1	# o_isinvert (objects.(obj))
	jalr	x0, x31, -2993	# o_isinvert (objects.(obj))
	subi	x2, x2, 10	# o_isinvert (objects.(obj))
	lw	x1, 9(x2)	# o_isinvert (objects.(obj))
	addi	x4, x4, 0	# o_isinvert (objects.(obj))
	bne	x4, x0, 3	# if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	shadow_check_and_group (iand_ofs + 1) and_group
	lw	x4, 5(x2)	# iand_ofs + 1
	addi	x4, x4, 1	# iand_ofs + 1
	lw	x5, 3(x2)	# shadow_check_and_group (iand_ofs + 1) and_group
	lw	x29, 4(x2)	# shadow_check_and_group (iand_ofs + 1) and_group
	lw	x31, 0(x29)	# shadow_check_and_group (iand_ofs + 1) and_group
	jalr	x0, x31, 0	# shadow_check_and_group (iand_ofs + 1) and_group
# bne:	let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group
	lui	x31, 246333	# 0.01
	addi	x31, x31, 1008981770	# 0.01
	mvitof	f2, x31	# 0.01
	# let t = t0p +. 0.01
	fadd	f1, f1, f2	# t0p +. 0.01
	lw	x4, 2(x2)	# light.(0)
	flw	f2, 0(x4)	# light.(0)
	fmul	f2, f2, f1	# light.(0) *. t
	lw	x5, 1(x2)	# intersection_point.(0)
	flw	f3, 0(x5)	# intersection_point.(0)
	# let q0 = light.(0) *. t +. intersection_point.(0)
	fadd	f2, f2, f3	# light.(0) *. t +. intersection_point.(0)
	flw	f3, 1(x4)	# light.(1)
	fmul	f3, f3, f1	# light.(1) *. t
	flw	f4, 1(x5)	# intersection_point.(1)
	# let q1 = light.(1) *. t +. intersection_point.(1)
	fadd	f3, f3, f4	# light.(1) *. t +. intersection_point.(1)
	flw	f4, 2(x4)	# light.(2)
	fmul	f1, f4, f1	# light.(2) *. t
	flw	f4, 2(x5)	# intersection_point.(2)
	# let q2 = light.(2) *. t +. intersection_point.(2)
	fadd	f1, f1, f4	# light.(2) *. t +. intersection_point.(2)
	addi	x4, x0, 0	# 0
	lw	x5, 3(x2)	# check_all_inside 0 and_group q0 q1 q2
	lw	x29, 0(x2)	# check_all_inside 0 and_group q0 q1 q2
	fmv	f31, f3	# check_all_inside 0 and_group q0 q1 q2
	fmv	f3, f1	# check_all_inside 0 and_group q0 q1 q2
	fmv	f1, f2	# check_all_inside 0 and_group q0 q1 q2
	fmv	f2, f31	# check_all_inside 0 and_group q0 q1 q2
	sw	x1, 9(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, 10	# check_all_inside 0 and_group q0 q1 q2
	lw	x31, 0(x29)	# check_all_inside 0 and_group q0 q1 q2
	jalr	x1, x31, 0	# check_all_inside 0 and_group q0 q1 q2
	subi	x2, x2, 10	# check_all_inside 0 and_group q0 q1 q2
	lw	x1, 9(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x4, x4, 0	# check_all_inside 0 and_group q0 q1 q2
	bne	x4, x0, 7	# if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group
# beq:	shadow_check_and_group (iand_ofs + 1) and_group
	lw	x4, 5(x2)	# iand_ofs + 1
	addi	x4, x4, 1	# iand_ofs + 1
	lw	x5, 3(x2)	# shadow_check_and_group (iand_ofs + 1) and_group
	lw	x29, 4(x2)	# shadow_check_and_group (iand_ofs + 1) and_group
	lw	x31, 0(x29)	# shadow_check_and_group (iand_ofs + 1) and_group
	jalr	x0, x31, 0	# shadow_check_and_group (iand_ofs + 1) and_group
# bne:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# shadow_check_one_or_group.2810:	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	lw	x6, 5(x29)	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	lw	x7, 4(x29)	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	# let head = or_group.(ofs)
	lwa	x8, (x5, x4)	# or_group.(ofs)
	addi	x9, x0, -1	# -1
	bne	x8, x9, 3	# if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group
	# let and_group = and_net.(head)
	lwa	x7, (x7, x8)	# and_net.(head)
	addi	x8, x0, 0	# 0
	sw	x5, 0(x2)	# shadow_check_and_group 0 and_group
	sw	x29, 1(x2)	# shadow_check_and_group 0 and_group
	sw	x4, 2(x2)	# shadow_check_and_group 0 and_group
	# let shadow_p = shadow_check_and_group 0 and_group
	addi	x5, x7, 0	# shadow_check_and_group 0 and_group
	addi	x4, x8, 0	# shadow_check_and_group 0 and_group
	addi	x29, x6, 0	# shadow_check_and_group 0 and_group
	sw	x1, 3(x2)	# shadow_check_and_group 0 and_group
	addi	x2, x2, 4	# shadow_check_and_group 0 and_group
	lw	x31, 0(x29)	# shadow_check_and_group 0 and_group
	jalr	x1, x31, 0	# shadow_check_and_group 0 and_group
	subi	x2, x2, 4	# shadow_check_and_group 0 and_group
	lw	x1, 3(x2)	# shadow_check_and_group 0 and_group
	addi	x4, x4, 0	# shadow_check_and_group 0 and_group
	bne	x4, x0, 7	# if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group
# beq:	shadow_check_one_or_group (ofs + 1) or_group
	lw	x4, 2(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	lw	x5, 0(x2)	# shadow_check_one_or_group (ofs + 1) or_group
	lw	x29, 1(x2)	# shadow_check_one_or_group (ofs + 1) or_group
	lw	x31, 0(x29)	# shadow_check_one_or_group (ofs + 1) or_group
	jalr	x0, x31, 0	# shadow_check_one_or_group (ofs + 1) or_group
# bne:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# shadow_check_one_or_matrix.2813:	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x6, 8(x29)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x7, 7(x29)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x8, 6(x29)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x9, 5(x29)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x10, 4(x29)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	# let head = or_matrix.(ofs)
	lwa	x11, (x5, x4)	# or_matrix.(ofs)
	# let range_primitive = head.(0)
	lw	x12, 0(x11)	# head.(0)
	addi	x13, x0, -1	# -1
	bne	x12, x13, 3	# if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	addi	x13, x0, 99	# 99
	sw	x11, 0(x2)	# if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	sw	x8, 1(x2)	# if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	sw	x5, 2(x2)	# if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	sw	x29, 3(x2)	# if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	sw	x4, 4(x2)	# if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	bne	x12, x13, 4	# if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# beq:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
	jal	x0, 40	# if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# bne:	let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	sw	x7, 5(x2)	# solver_fast range_primitive light_dirvec intersection_point
	# let t = solver_fast range_primitive light_dirvec intersection_point
	addi	x5, x9, 0	# solver_fast range_primitive light_dirvec intersection_point
	addi	x4, x12, 0	# solver_fast range_primitive light_dirvec intersection_point
	addi	x29, x6, 0	# solver_fast range_primitive light_dirvec intersection_point
	addi	x6, x10, 0	# solver_fast range_primitive light_dirvec intersection_point
	sw	x1, 6(x2)	# solver_fast range_primitive light_dirvec intersection_point
	addi	x2, x2, 7	# solver_fast range_primitive light_dirvec intersection_point
	lw	x31, 0(x29)	# solver_fast range_primitive light_dirvec intersection_point
	jalr	x1, x31, 0	# solver_fast range_primitive light_dirvec intersection_point
	subi	x2, x2, 7	# solver_fast range_primitive light_dirvec intersection_point
	lw	x1, 6(x2)	# solver_fast range_primitive light_dirvec intersection_point
	addi	x4, x4, 0	# solver_fast range_primitive light_dirvec intersection_point
	bne	x4, x0, 3	# if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false
	lw	x4, 5(x2)	# solver_dist.(0)
	flw	f1, 0(x4)	# solver_dist.(0)
	lui	x31, -271155	# -0.1
	addi	x31, x31, -1110651699	# -0.1
	mvitof	f1, x31	# -0.1
	flt	x4, f1, f1	# fless solver_dist.(0) (-0.1)
	bne	x4, x0, 3	# if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	if shadow_check_one_or_group 1 head then true else false
	addi	x4, x0, 1	# 1
	lw	x5, 0(x2)	# shadow_check_one_or_group 1 head
	lw	x29, 1(x2)	# shadow_check_one_or_group 1 head
	sw	x1, 6(x2)	# shadow_check_one_or_group 1 head
	addi	x2, x2, 7	# shadow_check_one_or_group 1 head
	lw	x31, 0(x29)	# shadow_check_one_or_group 1 head
	jalr	x1, x31, 0	# shadow_check_one_or_group 1 head
	subi	x2, x2, 7	# shadow_check_one_or_group 1 head
	lw	x1, 6(x2)	# shadow_check_one_or_group 1 head
	addi	x4, x4, 0	# shadow_check_one_or_group 1 head
	bne	x4, x0, 3	# if shadow_check_one_or_group 1 head then true else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# cont:	if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false
	bne	x4, x0, 7	# if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
# beq:	shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x4, 4(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	lw	x5, 2(x2)	# shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x29, 3(x2)	# shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x31, 0(x29)	# shadow_check_one_or_matrix (ofs + 1) or_matrix
	jalr	x0, x31, 0	# shadow_check_one_or_matrix (ofs + 1) or_matrix
# bne:	if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix
	addi	x4, x0, 1	# 1
	lw	x5, 0(x2)	# shadow_check_one_or_group 1 head
	lw	x29, 1(x2)	# shadow_check_one_or_group 1 head
	sw	x1, 6(x2)	# shadow_check_one_or_group 1 head
	addi	x2, x2, 7	# shadow_check_one_or_group 1 head
	lw	x31, 0(x29)	# shadow_check_one_or_group 1 head
	jalr	x1, x31, 0	# shadow_check_one_or_group 1 head
	subi	x2, x2, 7	# shadow_check_one_or_group 1 head
	lw	x1, 6(x2)	# shadow_check_one_or_group 1 head
	addi	x4, x4, 0	# shadow_check_one_or_group 1 head
	bne	x4, x0, 7	# if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix
# beq:	shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x4, 4(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	lw	x5, 2(x2)	# shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x29, 3(x2)	# shadow_check_one_or_matrix (ofs + 1) or_matrix
	lw	x31, 0(x29)	# shadow_check_one_or_matrix (ofs + 1) or_matrix
	jalr	x0, x31, 0	# shadow_check_one_or_matrix (ofs + 1) or_matrix
# bne:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# solve_each_element.2816:	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x7, 12(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x8, 11(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x9, 10(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x10, 9(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x11, 8(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x12, 7(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x13, 6(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x14, 5(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x15, 4(x29)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	# let iobj = and_group.(iand_ofs)
	lwa	x16, (x5, x4)	# and_group.(iand_ofs)
	addi	x17, x0, -1	# -1
	bne	x16, x17, 2	# if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
	sw	x12, 0(x2)	# solver iobj dirvec startp
	sw	x14, 1(x2)	# solver iobj dirvec startp
	sw	x13, 2(x2)	# solver iobj dirvec startp
	sw	x15, 3(x2)	# solver iobj dirvec startp
	sw	x8, 4(x2)	# solver iobj dirvec startp
	sw	x7, 5(x2)	# solver iobj dirvec startp
	sw	x9, 6(x2)	# solver iobj dirvec startp
	sw	x6, 7(x2)	# solver iobj dirvec startp
	sw	x5, 8(x2)	# solver iobj dirvec startp
	sw	x29, 9(x2)	# solver iobj dirvec startp
	sw	x4, 10(x2)	# solver iobj dirvec startp
	sw	x16, 11(x2)	# solver iobj dirvec startp
	sw	x11, 12(x2)	# solver iobj dirvec startp
	# let t0 = solver iobj dirvec startp
	addi	x5, x6, 0	# solver iobj dirvec startp
	addi	x4, x16, 0	# solver iobj dirvec startp
	addi	x29, x10, 0	# solver iobj dirvec startp
	addi	x6, x8, 0	# solver iobj dirvec startp
	sw	x1, 13(x2)	# solver iobj dirvec startp
	addi	x2, x2, 14	# solver iobj dirvec startp
	lw	x31, 0(x29)	# solver iobj dirvec startp
	jalr	x1, x31, 0	# solver iobj dirvec startp
	subi	x2, x2, 14	# solver iobj dirvec startp
	lw	x1, 13(x2)	# solver iobj dirvec startp
	addi	x4, x4, 0	# solver iobj dirvec startp
	bne	x4, x0, 20	# if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
# beq:	if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
	lw	x4, 11(x2)	# objects.(iobj)
	lw	x5, 12(x2)	# objects.(iobj)
	lwa	x4, (x5, x4)	# objects.(iobj)
	sw	x1, 13(x2)	# o_isinvert (objects.(iobj))
	addi	x2, x2, 14	# o_isinvert (objects.(iobj))
	auipc	x31, -1	# o_isinvert (objects.(iobj))
	jalr	x0, x31, -3208	# o_isinvert (objects.(iobj))
	subi	x2, x2, 14	# o_isinvert (objects.(iobj))
	lw	x1, 13(x2)	# o_isinvert (objects.(iobj))
	addi	x4, x4, 0	# o_isinvert (objects.(iobj))
	bne	x4, x0, 2	# if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x4, 10(x2)	# iand_ofs + 1
	addi	x4, x4, 1	# iand_ofs + 1
	lw	x5, 8(x2)	# solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x6, 7(x2)	# solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x29, 9(x2)	# solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x31, 0(x29)	# solve_each_element (iand_ofs + 1) and_group dirvec
	jalr	x0, x31, 0	# solve_each_element (iand_ofs + 1) and_group dirvec
# bne:	let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x5, 6(x2)	# solver_dist.(0)
	# let t0p = solver_dist.(0)
	flw	f1, 0(x5)	# solver_dist.(0)
	flt	x5, f1, f1	# fless 0.0 t0p
	bne	x5, x0, 3	# if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 67	# if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else ()
# bne:	if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else ()
	lw	x5, 5(x2)	# tmin.(0)
	flw	f2, 0(x5)	# tmin.(0)
	flt	x6, f2, f2	# fless t0p tmin.(0)
	bne	x6, x0, 2	# if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else ()
	lui	x31, 246333	# 0.01
	addi	x31, x31, 1008981770	# 0.01
	mvitof	f2, x31	# 0.01
	# let t = t0p +. 0.01
	fadd	f1, f1, f2	# t0p +. 0.01
	lw	x6, 7(x2)	# dirvec.(0)
	flw	f2, 0(x6)	# dirvec.(0)
	fmul	f2, f2, f1	# dirvec.(0) *. t
	lw	x7, 4(x2)	# startp.(0)
	flw	f3, 0(x7)	# startp.(0)
	# let q0 = dirvec.(0) *. t +. startp.(0)
	fadd	f2, f2, f3	# dirvec.(0) *. t +. startp.(0)
	flw	f3, 1(x6)	# dirvec.(1)
	fmul	f3, f3, f1	# dirvec.(1) *. t
	flw	f4, 1(x7)	# startp.(1)
	# let q1 = dirvec.(1) *. t +. startp.(1)
	fadd	f3, f3, f4	# dirvec.(1) *. t +. startp.(1)
	flw	f4, 2(x6)	# dirvec.(2)
	fmul	f4, f4, f1	# dirvec.(2) *. t
	flw	f5, 2(x7)	# startp.(2)
	# let q2 = dirvec.(2) *. t +. startp.(2)
	fadd	f4, f4, f5	# dirvec.(2) *. t +. startp.(2)
	addi	x7, x0, 0	# 0
	lw	x8, 8(x2)	# check_all_inside 0 and_group q0 q1 q2
	lw	x29, 3(x2)	# check_all_inside 0 and_group q0 q1 q2
	sw	x4, 13(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f4, 14(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f3, 15(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f2, 16(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f1, 17(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x5, x8, 0	# check_all_inside 0 and_group q0 q1 q2
	addi	x4, x7, 0	# check_all_inside 0 and_group q0 q1 q2
	fmv	f1, f2	# check_all_inside 0 and_group q0 q1 q2
	fmv	f2, f3	# check_all_inside 0 and_group q0 q1 q2
	fmv	f3, f4	# check_all_inside 0 and_group q0 q1 q2
	sw	x1, 18(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, 19	# check_all_inside 0 and_group q0 q1 q2
	lw	x31, 0(x29)	# check_all_inside 0 and_group q0 q1 q2
	jalr	x1, x31, 0	# check_all_inside 0 and_group q0 q1 q2
	subi	x2, x2, 19	# check_all_inside 0 and_group q0 q1 q2
	lw	x1, 18(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x4, x4, 0	# check_all_inside 0 and_group q0 q1 q2
	bne	x4, x0, 2	# if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0
	lw	x4, 5(x2)	# tmin.(0) <- t
	flw	f1, 17(x2)	# tmin.(0) <- t
	fsw	f1, 0(x4)	# tmin.(0) <- t
	flw	f1, 16(x2)	# vecset intersection_point q0 q1 q2
	flw	f2, 15(x2)	# vecset intersection_point q0 q1 q2
	flw	f3, 14(x2)	# vecset intersection_point q0 q1 q2
	lw	x4, 2(x2)	# vecset intersection_point q0 q1 q2
	sw	x1, 18(x2)	# vecset intersection_point q0 q1 q2
	addi	x2, x2, 19	# vecset intersection_point q0 q1 q2
	auipc	x31, -1	# vecset intersection_point q0 q1 q2
	jalr	x0, x31, -3419	# vecset intersection_point q0 q1 q2
	subi	x2, x2, 19	# vecset intersection_point q0 q1 q2
	lw	x1, 18(x2)	# vecset intersection_point q0 q1 q2
	addi	x0, x4, 0	# vecset intersection_point q0 q1 q2
	lw	x4, 1(x2)	# intersected_object_id.(0) <- iobj
	lw	x5, 11(x2)	# intersected_object_id.(0) <- iobj
	sw	x5, 0(x4)	# intersected_object_id.(0) <- iobj
	lw	x4, 0(x2)	# intsec_rectside.(0) <- t0
	lw	x5, 13(x2)	# intsec_rectside.(0) <- t0
	sw	x5, 0(x4)	# intsec_rectside.(0) <- t0
	jalr x0, x1, 0	# intsec_rectside.(0) <- t0
# cont:	if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else ()
	lw	x4, 10(x2)	# iand_ofs + 1
	addi	x4, x4, 1	# iand_ofs + 1
	lw	x5, 8(x2)	# solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x6, 7(x2)	# solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x29, 9(x2)	# solve_each_element (iand_ofs + 1) and_group dirvec
	lw	x31, 0(x29)	# solve_each_element (iand_ofs + 1) and_group dirvec
	jalr	x0, x31, 0	# solve_each_element (iand_ofs + 1) and_group dirvec
# solve_one_or_network.2820:	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	lw	x7, 5(x29)	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	lw	x8, 4(x29)	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	# let head = or_group.(ofs)
	lwa	x9, (x5, x4)	# or_group.(ofs)
	addi	x10, x0, -1	# -1
	bne	x9, x10, 2	# if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec
	# let and_group = and_net.(head)
	lwa	x8, (x8, x9)	# and_net.(head)
	addi	x9, x0, 0	# 0
	sw	x6, 0(x2)	# solve_each_element 0 and_group dirvec
	sw	x5, 1(x2)	# solve_each_element 0 and_group dirvec
	sw	x29, 2(x2)	# solve_each_element 0 and_group dirvec
	sw	x4, 3(x2)	# solve_each_element 0 and_group dirvec
	addi	x5, x8, 0	# solve_each_element 0 and_group dirvec
	addi	x4, x9, 0	# solve_each_element 0 and_group dirvec
	addi	x29, x7, 0	# solve_each_element 0 and_group dirvec
	sw	x1, 4(x2)	# solve_each_element 0 and_group dirvec
	addi	x2, x2, 5	# solve_each_element 0 and_group dirvec
	lw	x31, 0(x29)	# solve_each_element 0 and_group dirvec
	jalr	x1, x31, 0	# solve_each_element 0 and_group dirvec
	subi	x2, x2, 5	# solve_each_element 0 and_group dirvec
	lw	x1, 4(x2)	# solve_each_element 0 and_group dirvec
	addi	x0, x4, 0	# solve_each_element 0 and_group dirvec
	lw	x4, 3(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	lw	x5, 1(x2)	# solve_one_or_network (ofs + 1) or_group dirvec
	lw	x6, 0(x2)	# solve_one_or_network (ofs + 1) or_group dirvec
	lw	x29, 2(x2)	# solve_one_or_network (ofs + 1) or_group dirvec
	lw	x31, 0(x29)	# solve_one_or_network (ofs + 1) or_group dirvec
	jalr	x0, x31, 0	# solve_one_or_network (ofs + 1) or_group dirvec
# trace_or_matrix.2824:	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	lw	x7, 8(x29)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	lw	x8, 7(x29)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	lw	x9, 6(x29)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	lw	x10, 5(x29)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	lw	x11, 4(x29)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	# let head = or_network.(ofs)
	lwa	x12, (x5, x4)	# or_network.(ofs)
	# let range_primitive = head.(0)
	lw	x13, 0(x12)	# head.(0)
	addi	x14, x0, -1	# -1
	bne	x13, x14, 2	# if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec
	addi	x14, x0, 99	# 99
	sw	x6, 0(x2)	# if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	sw	x5, 1(x2)	# if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	sw	x29, 2(x2)	# if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	sw	x4, 3(x2)	# if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	bne	x13, x14, 8	# if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
# beq:	solve_one_or_network 1 head dirvec
	addi	x7, x0, 1	# 1
	addi	x5, x12, 0	# solve_one_or_network 1 head dirvec
	addi	x4, x7, 0	# solve_one_or_network 1 head dirvec
	addi	x29, x11, 0	# solve_one_or_network 1 head dirvec
	lw	x31, 0(x29)	# solve_one_or_network 1 head dirvec
	jalr	x0, x31, 0	# solve_one_or_network 1 head dirvec
	jal	x0, 31	# if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
# bne:	let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else ()
	sw	x12, 4(x2)	# solver range_primitive dirvec startp
	sw	x11, 5(x2)	# solver range_primitive dirvec startp
	sw	x7, 6(x2)	# solver range_primitive dirvec startp
	sw	x9, 7(x2)	# solver range_primitive dirvec startp
	# let t = solver range_primitive dirvec startp
	addi	x5, x6, 0	# solver range_primitive dirvec startp
	addi	x4, x13, 0	# solver range_primitive dirvec startp
	addi	x29, x10, 0	# solver range_primitive dirvec startp
	addi	x6, x8, 0	# solver range_primitive dirvec startp
	sw	x1, 8(x2)	# solver range_primitive dirvec startp
	addi	x2, x2, 9	# solver range_primitive dirvec startp
	lw	x31, 0(x29)	# solver range_primitive dirvec startp
	jalr	x1, x31, 0	# solver range_primitive dirvec startp
	subi	x2, x2, 9	# solver range_primitive dirvec startp
	lw	x1, 8(x2)	# solver range_primitive dirvec startp
	addi	x4, x4, 0	# solver range_primitive dirvec startp
	bne	x4, x0, 2	# if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else ()
	lw	x4, 7(x2)	# solver_dist.(0)
	# let tp = solver_dist.(0)
	flw	f1, 0(x4)	# solver_dist.(0)
	lw	x4, 6(x2)	# tmin.(0)
	flw	f1, 0(x4)	# tmin.(0)
	flt	x4, f1, f1	# fless tp tmin.(0)
	bne	x4, x0, 2	# if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	solve_one_or_network 1 head dirvec
	addi	x4, x0, 1	# 1
	lw	x5, 4(x2)	# solve_one_or_network 1 head dirvec
	lw	x6, 0(x2)	# solve_one_or_network 1 head dirvec
	lw	x29, 5(x2)	# solve_one_or_network 1 head dirvec
	lw	x31, 0(x29)	# solve_one_or_network 1 head dirvec
	jalr	x0, x31, 0	# solve_one_or_network 1 head dirvec
# cont:	if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () )
	lw	x4, 3(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	lw	x5, 1(x2)	# trace_or_matrix (ofs + 1) or_network dirvec
	lw	x6, 0(x2)	# trace_or_matrix (ofs + 1) or_network dirvec
	lw	x29, 2(x2)	# trace_or_matrix (ofs + 1) or_network dirvec
	lw	x31, 0(x29)	# trace_or_matrix (ofs + 1) or_network dirvec
	jalr	x0, x31, 0	# trace_or_matrix (ofs + 1) or_network dirvec
# judge_intersection.2828:	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lw	x5, 6(x29)	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lw	x6, 5(x29)	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lw	x7, 4(x29)	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lui	x31, 321255	# 1000000000.0
	addi	x31, x31, 1315859240	# 1000000000.0
	mvitof	f1, x31	# 1000000000.0
	fsw	f1, 0(x6)	# tmin.(0) <- (1000000000.0)
	addi	x8, x0, 0	# 0
	lw	x7, 0(x7)	# or_net.(0)
	sw	x6, 0(x2)	# trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x6, x4, 0	# trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x29, x5, 0	# trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x5, x7, 0	# trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x4, x8, 0	# trace_or_matrix 0 (or_net.(0)) dirvec
	sw	x1, 1(x2)	# trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x2, x2, 2	# trace_or_matrix 0 (or_net.(0)) dirvec
	lw	x31, 0(x29)	# trace_or_matrix 0 (or_net.(0)) dirvec
	jalr	x1, x31, 0	# trace_or_matrix 0 (or_net.(0)) dirvec
	subi	x2, x2, 2	# trace_or_matrix 0 (or_net.(0)) dirvec
	lw	x1, 1(x2)	# trace_or_matrix 0 (or_net.(0)) dirvec
	addi	x0, x4, 0	# trace_or_matrix 0 (or_net.(0)) dirvec
	lw	x4, 0(x2)	# tmin.(0)
	# let t = tmin.(0)
	flw	f1, 0(x4)	# tmin.(0)
	flt	x4, f1, f1	# fless (-0.1) t
	bne	x4, x0, 3	# if (fless (-0.1) t) then (fless t 100000000.0) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	fless t 100000000.0
	lui	x31, 314348	# 100000000.0
	addi	x31, x31, 1287568416	# 100000000.0
	mvitof	f1, x31	# 100000000.0
	flt	x4, f1, f1	# fless t 100000000.0
	jalr	x0, x1, 0	# fless t 100000000.0
# solve_each_element_fast.2830:	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x7, 12(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x8, 11(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x9, 10(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x10, 9(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x11, 8(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x12, 7(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x13, 6(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x14, 5(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lw	x15, 4(x29)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x12, 0(x2)	# d_vec dirvec
	sw	x14, 1(x2)	# d_vec dirvec
	sw	x13, 2(x2)	# d_vec dirvec
	sw	x15, 3(x2)	# d_vec dirvec
	sw	x8, 4(x2)	# d_vec dirvec
	sw	x7, 5(x2)	# d_vec dirvec
	sw	x10, 6(x2)	# d_vec dirvec
	sw	x29, 7(x2)	# d_vec dirvec
	sw	x11, 8(x2)	# d_vec dirvec
	sw	x6, 9(x2)	# d_vec dirvec
	sw	x9, 10(x2)	# d_vec dirvec
	sw	x4, 11(x2)	# d_vec dirvec
	sw	x5, 12(x2)	# d_vec dirvec
	# let vec = (d_vec dirvec)
	addi	x4, x6, 0	# d_vec dirvec
	sw	x1, 13(x2)	# d_vec dirvec
	addi	x2, x2, 14	# d_vec dirvec
	auipc	x31, -1	# d_vec dirvec
	jalr	x0, x31, -3376	# d_vec dirvec
	subi	x2, x2, 14	# d_vec dirvec
	lw	x1, 13(x2)	# d_vec dirvec
	addi	x4, x4, 0	# d_vec dirvec
	lw	x5, 11(x2)	# and_group.(iand_ofs)
	lw	x6, 12(x2)	# and_group.(iand_ofs)
	# let iobj = and_group.(iand_ofs)
	lwa	x7, (x6, x5)	# and_group.(iand_ofs)
	addi	x8, x0, -1	# -1
	bne	x7, x8, 2	# if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
	lw	x8, 9(x2)	# solver_fast2 iobj dirvec
	lw	x29, 10(x2)	# solver_fast2 iobj dirvec
	sw	x4, 13(x2)	# solver_fast2 iobj dirvec
	sw	x7, 14(x2)	# solver_fast2 iobj dirvec
	# let t0 = solver_fast2 iobj dirvec
	addi	x5, x8, 0	# solver_fast2 iobj dirvec
	addi	x4, x7, 0	# solver_fast2 iobj dirvec
	sw	x1, 15(x2)	# solver_fast2 iobj dirvec
	addi	x2, x2, 16	# solver_fast2 iobj dirvec
	lw	x31, 0(x29)	# solver_fast2 iobj dirvec
	jalr	x1, x31, 0	# solver_fast2 iobj dirvec
	subi	x2, x2, 16	# solver_fast2 iobj dirvec
	lw	x1, 15(x2)	# solver_fast2 iobj dirvec
	addi	x4, x4, 0	# solver_fast2 iobj dirvec
	bne	x4, x0, 20	# if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
# beq:	if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
	lw	x4, 14(x2)	# objects.(iobj)
	lw	x5, 8(x2)	# objects.(iobj)
	lwa	x4, (x5, x4)	# objects.(iobj)
	sw	x1, 15(x2)	# o_isinvert (objects.(iobj))
	addi	x2, x2, 16	# o_isinvert (objects.(iobj))
	auipc	x31, -1	# o_isinvert (objects.(iobj))
	jalr	x0, x31, -3477	# o_isinvert (objects.(iobj))
	subi	x2, x2, 16	# o_isinvert (objects.(iobj))
	lw	x1, 15(x2)	# o_isinvert (objects.(iobj))
	addi	x4, x4, 0	# o_isinvert (objects.(iobj))
	bne	x4, x0, 2	# if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x4, 11(x2)	# iand_ofs + 1
	addi	x4, x4, 1	# iand_ofs + 1
	lw	x5, 12(x2)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x6, 9(x2)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x29, 7(x2)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x31, 0(x29)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	jalr	x0, x31, 0	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
# bne:	let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x5, 6(x2)	# solver_dist.(0)
	# let t0p = solver_dist.(0)
	flw	f1, 0(x5)	# solver_dist.(0)
	flt	x5, f1, f1	# fless 0.0 t0p
	bne	x5, x0, 3	# if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 67	# if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else ()
# bne:	if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else ()
	lw	x5, 5(x2)	# tmin.(0)
	flw	f2, 0(x5)	# tmin.(0)
	flt	x6, f2, f2	# fless t0p tmin.(0)
	bne	x6, x0, 2	# if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else ()
	lui	x31, 246333	# 0.01
	addi	x31, x31, 1008981770	# 0.01
	mvitof	f2, x31	# 0.01
	# let t = t0p +. 0.01
	fadd	f1, f1, f2	# t0p +. 0.01
	lw	x6, 13(x2)	# vec.(0)
	flw	f2, 0(x6)	# vec.(0)
	fmul	f2, f2, f1	# vec.(0) *. t
	lw	x7, 4(x2)	# startp_fast.(0)
	flw	f3, 0(x7)	# startp_fast.(0)
	# let q0 = vec.(0) *. t +. startp_fast.(0)
	fadd	f2, f2, f3	# vec.(0) *. t +. startp_fast.(0)
	flw	f3, 1(x6)	# vec.(1)
	fmul	f3, f3, f1	# vec.(1) *. t
	flw	f4, 1(x7)	# startp_fast.(1)
	# let q1 = vec.(1) *. t +. startp_fast.(1)
	fadd	f3, f3, f4	# vec.(1) *. t +. startp_fast.(1)
	flw	f4, 2(x6)	# vec.(2)
	fmul	f4, f4, f1	# vec.(2) *. t
	flw	f5, 2(x7)	# startp_fast.(2)
	# let q2 = vec.(2) *. t +. startp_fast.(2)
	fadd	f4, f4, f5	# vec.(2) *. t +. startp_fast.(2)
	addi	x6, x0, 0	# 0
	lw	x7, 12(x2)	# check_all_inside 0 and_group q0 q1 q2
	lw	x29, 3(x2)	# check_all_inside 0 and_group q0 q1 q2
	sw	x4, 15(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f4, 16(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f3, 17(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f2, 18(x2)	# check_all_inside 0 and_group q0 q1 q2
	fsw	f1, 19(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x5, x7, 0	# check_all_inside 0 and_group q0 q1 q2
	addi	x4, x6, 0	# check_all_inside 0 and_group q0 q1 q2
	fmv	f1, f2	# check_all_inside 0 and_group q0 q1 q2
	fmv	f2, f3	# check_all_inside 0 and_group q0 q1 q2
	fmv	f3, f4	# check_all_inside 0 and_group q0 q1 q2
	sw	x1, 20(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x2, x2, 21	# check_all_inside 0 and_group q0 q1 q2
	lw	x31, 0(x29)	# check_all_inside 0 and_group q0 q1 q2
	jalr	x1, x31, 0	# check_all_inside 0 and_group q0 q1 q2
	subi	x2, x2, 21	# check_all_inside 0 and_group q0 q1 q2
	lw	x1, 20(x2)	# check_all_inside 0 and_group q0 q1 q2
	addi	x4, x4, 0	# check_all_inside 0 and_group q0 q1 q2
	bne	x4, x0, 2	# if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0;
	lw	x4, 5(x2)	# tmin.(0) <- t
	flw	f1, 19(x2)	# tmin.(0) <- t
	fsw	f1, 0(x4)	# tmin.(0) <- t
	flw	f1, 18(x2)	# vecset intersection_point q0 q1 q2
	flw	f2, 17(x2)	# vecset intersection_point q0 q1 q2
	flw	f3, 16(x2)	# vecset intersection_point q0 q1 q2
	lw	x4, 2(x2)	# vecset intersection_point q0 q1 q2
	sw	x1, 20(x2)	# vecset intersection_point q0 q1 q2
	addi	x2, x2, 21	# vecset intersection_point q0 q1 q2
	auipc	x31, -1	# vecset intersection_point q0 q1 q2
	jalr	x0, x31, -3688	# vecset intersection_point q0 q1 q2
	subi	x2, x2, 21	# vecset intersection_point q0 q1 q2
	lw	x1, 20(x2)	# vecset intersection_point q0 q1 q2
	addi	x0, x4, 0	# vecset intersection_point q0 q1 q2
	lw	x4, 1(x2)	# intersected_object_id.(0) <- iobj
	lw	x5, 14(x2)	# intersected_object_id.(0) <- iobj
	sw	x5, 0(x4)	# intersected_object_id.(0) <- iobj
	lw	x4, 0(x2)	# intsec_rectside.(0) <- t0
	lw	x5, 15(x2)	# intsec_rectside.(0) <- t0
	sw	x5, 0(x4)	# intsec_rectside.(0) <- t0
	jalr x0, x1, 0
# cont:	if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else ()
	lw	x4, 11(x2)	# iand_ofs + 1
	addi	x4, x4, 1	# iand_ofs + 1
	lw	x5, 12(x2)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x6, 9(x2)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x29, 7(x2)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	lw	x31, 0(x29)	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
	jalr	x0, x31, 0	# solve_each_element_fast (iand_ofs + 1) and_group dirvec
# solve_one_or_network_fast.2834:	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	lw	x7, 5(x29)	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	lw	x8, 4(x29)	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	# let head = or_group.(ofs)
	lwa	x9, (x5, x4)	# or_group.(ofs)
	addi	x10, x0, -1	# -1
	bne	x9, x10, 2	# if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec
	# let and_group = and_net.(head)
	lwa	x8, (x8, x9)	# and_net.(head)
	addi	x9, x0, 0	# 0
	sw	x6, 0(x2)	# solve_each_element_fast 0 and_group dirvec
	sw	x5, 1(x2)	# solve_each_element_fast 0 and_group dirvec
	sw	x29, 2(x2)	# solve_each_element_fast 0 and_group dirvec
	sw	x4, 3(x2)	# solve_each_element_fast 0 and_group dirvec
	addi	x5, x8, 0	# solve_each_element_fast 0 and_group dirvec
	addi	x4, x9, 0	# solve_each_element_fast 0 and_group dirvec
	addi	x29, x7, 0	# solve_each_element_fast 0 and_group dirvec
	sw	x1, 4(x2)	# solve_each_element_fast 0 and_group dirvec
	addi	x2, x2, 5	# solve_each_element_fast 0 and_group dirvec
	lw	x31, 0(x29)	# solve_each_element_fast 0 and_group dirvec
	jalr	x1, x31, 0	# solve_each_element_fast 0 and_group dirvec
	subi	x2, x2, 5	# solve_each_element_fast 0 and_group dirvec
	lw	x1, 4(x2)	# solve_each_element_fast 0 and_group dirvec
	addi	x0, x4, 0	# solve_each_element_fast 0 and_group dirvec
	lw	x4, 3(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	lw	x5, 1(x2)	# solve_one_or_network_fast (ofs + 1) or_group dirvec
	lw	x6, 0(x2)	# solve_one_or_network_fast (ofs + 1) or_group dirvec
	lw	x29, 2(x2)	# solve_one_or_network_fast (ofs + 1) or_group dirvec
	lw	x31, 0(x29)	# solve_one_or_network_fast (ofs + 1) or_group dirvec
	jalr	x0, x31, 0	# solve_one_or_network_fast (ofs + 1) or_group dirvec
# trace_or_matrix_fast.2838:	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	lw	x7, 7(x29)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	lw	x8, 6(x29)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	lw	x9, 5(x29)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	lw	x10, 4(x29)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	# let head = or_network.(ofs)
	lwa	x11, (x5, x4)	# or_network.(ofs)
	# let range_primitive = head.(0)
	lw	x12, 0(x11)	# head.(0)
	addi	x13, x0, -1	# -1
	bne	x12, x13, 2	# if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec
	addi	x13, x0, 99	# 99
	sw	x6, 0(x2)	# if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	sw	x5, 1(x2)	# if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	sw	x29, 2(x2)	# if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	sw	x4, 3(x2)	# if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	bne	x12, x13, 8	# if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
# beq:	solve_one_or_network_fast 1 head dirvec
	addi	x7, x0, 1	# 1
	addi	x5, x11, 0	# solve_one_or_network_fast 1 head dirvec
	addi	x4, x7, 0	# solve_one_or_network_fast 1 head dirvec
	addi	x29, x10, 0	# solve_one_or_network_fast 1 head dirvec
	lw	x31, 0(x29)	# solve_one_or_network_fast 1 head dirvec
	jalr	x0, x31, 0	# solve_one_or_network_fast 1 head dirvec
	jal	x0, 30	# if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
# bne:	let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else ()
	sw	x11, 4(x2)	# solver_fast2 range_primitive dirvec
	sw	x10, 5(x2)	# solver_fast2 range_primitive dirvec
	sw	x7, 6(x2)	# solver_fast2 range_primitive dirvec
	sw	x9, 7(x2)	# solver_fast2 range_primitive dirvec
	# let t = solver_fast2 range_primitive dirvec
	addi	x5, x6, 0	# solver_fast2 range_primitive dirvec
	addi	x4, x12, 0	# solver_fast2 range_primitive dirvec
	addi	x29, x8, 0	# solver_fast2 range_primitive dirvec
	sw	x1, 8(x2)	# solver_fast2 range_primitive dirvec
	addi	x2, x2, 9	# solver_fast2 range_primitive dirvec
	lw	x31, 0(x29)	# solver_fast2 range_primitive dirvec
	jalr	x1, x31, 0	# solver_fast2 range_primitive dirvec
	subi	x2, x2, 9	# solver_fast2 range_primitive dirvec
	lw	x1, 8(x2)	# solver_fast2 range_primitive dirvec
	addi	x4, x4, 0	# solver_fast2 range_primitive dirvec
	bne	x4, x0, 2	# if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else ()
	lw	x4, 7(x2)	# solver_dist.(0)
	# let tp = solver_dist.(0)
	flw	f1, 0(x4)	# solver_dist.(0)
	lw	x4, 6(x2)	# tmin.(0)
	flw	f1, 0(x4)	# tmin.(0)
	flt	x4, f1, f1	# fless tp tmin.(0)
	bne	x4, x0, 2	# if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	solve_one_or_network_fast 1 head dirvec
	addi	x4, x0, 1	# 1
	lw	x5, 4(x2)	# solve_one_or_network_fast 1 head dirvec
	lw	x6, 0(x2)	# solve_one_or_network_fast 1 head dirvec
	lw	x29, 5(x2)	# solve_one_or_network_fast 1 head dirvec
	lw	x31, 0(x29)	# solve_one_or_network_fast 1 head dirvec
	jalr	x0, x31, 0	# solve_one_or_network_fast 1 head dirvec
# cont:	if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () )
	lw	x4, 3(x2)	# ofs + 1
	addi	x4, x4, 1	# ofs + 1
	lw	x5, 1(x2)	# trace_or_matrix_fast (ofs + 1) or_network dirvec
	lw	x6, 0(x2)	# trace_or_matrix_fast (ofs + 1) or_network dirvec
	lw	x29, 2(x2)	# trace_or_matrix_fast (ofs + 1) or_network dirvec
	lw	x31, 0(x29)	# trace_or_matrix_fast (ofs + 1) or_network dirvec
	jalr	x0, x31, 0	# trace_or_matrix_fast (ofs + 1) or_network dirvec
# judge_intersection_fast.2842:	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lw	x5, 6(x29)	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lw	x6, 5(x29)	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lw	x7, 4(x29)	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lui	x31, 321255	# 1000000000.0
	addi	x31, x31, 1315859240	# 1000000000.0
	mvitof	f1, x31	# 1000000000.0
	fsw	f1, 0(x6)	# tmin.(0) <- (1000000000.0)
	addi	x8, x0, 0	# 0
	lw	x7, 0(x7)	# or_net.(0)
	sw	x6, 0(x2)	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x6, x4, 0	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x29, x5, 0	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x5, x7, 0	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x4, x8, 0	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	sw	x1, 1(x2)	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x2, x2, 2	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	lw	x31, 0(x29)	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	jalr	x1, x31, 0	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	subi	x2, x2, 2	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	lw	x1, 1(x2)	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	addi	x0, x4, 0	# trace_or_matrix_fast 0 (or_net.(0)) dirvec
	lw	x4, 0(x2)	# tmin.(0)
	# let t = tmin.(0)
	flw	f1, 0(x4)	# tmin.(0)
	flt	x4, f1, f1	# fless (-0.1) t
	bne	x4, x0, 3	# if (fless (-0.1) t) then (fless t 100000000.0) else false
# beq:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	fless t 100000000.0
	lui	x31, 314348	# 100000000.0
	addi	x31, x31, 1287568416	# 100000000.0
	mvitof	f1, x31	# 100000000.0
	flt	x4, f1, f1	# fless t 100000000.0
	jalr	x0, x1, 0	# fless t 100000000.0
# get_nvector_rect.2844:	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	lw	x5, 5(x29)	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	lw	x6, 4(x29)	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	# let rectside = intsec_rectside.(0)
	lw	x6, 0(x6)	# intsec_rectside.(0)
	sw	x5, 0(x2)	# vecbzero nvector
	sw	x4, 1(x2)	# vecbzero nvector
	sw	x6, 2(x2)	# vecbzero nvector
	addi	x4, x5, 0	# vecbzero nvector
	sw	x1, 3(x2)	# vecbzero nvector
	addi	x2, x2, 4	# vecbzero nvector
	auipc	x31, -1	# vecbzero nvector
	jalr	x0, x31, -3826	# vecbzero nvector
	subi	x2, x2, 4	# vecbzero nvector
	lw	x1, 3(x2)	# vecbzero nvector
	addi	x0, x4, 0	# vecbzero nvector
	lw	x4, 2(x2)	# rectside-1
	addi	x5, x4, -1	# rectside-1
	addi	x4, x4, -1	# rectside-1
	lw	x6, 1(x2)	# dirvec.(rectside-1)
	flwa	f1, (x6, x4)	# dirvec.(rectside-1)
	sw	x5, 3(x2)	# sgn (dirvec.(rectside-1))
	sw	x1, 4(x2)	# sgn (dirvec.(rectside-1))
	addi	x2, x2, 5	# sgn (dirvec.(rectside-1))
	auipc	x31, -1	# sgn (dirvec.(rectside-1))
	jalr	x0, x31, -3873	# sgn (dirvec.(rectside-1))
	subi	x2, x2, 5	# sgn (dirvec.(rectside-1))
	lw	x1, 4(x2)	# sgn (dirvec.(rectside-1))
	fmr	f1, f1	# sgn (dirvec.(rectside-1))
	fneg	f1, f1	# fneg (sgn (dirvec.(rectside-1)))
	lw	x4, 3(x2)	# nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	lw	x5, 0(x2)	# nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	fswa	f1, (x5, x4)	# nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	jalr x0, x1, 0	# nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
# get_nvector_plane.2846:	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	lw	x5, 4(x29)	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	sw	x4, 0(x2)	# o_param_a m
	sw	x5, 1(x2)	# o_param_a m
	sw	x1, 2(x2)	# o_param_a m
	addi	x2, x2, 3	# o_param_a m
	auipc	x31, -1	# o_param_a m
	jalr	x0, x31, -3722	# o_param_a m
	subi	x2, x2, 3	# o_param_a m
	lw	x1, 2(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	fneg	f1, f1	# fneg (o_param_a m)
	lw	x4, 1(x2)	# nvector.(0) <- fneg (o_param_a m)
	fsw	f1, 0(x4)	# nvector.(0) <- fneg (o_param_a m)
	lw	x5, 0(x2)	# o_param_b m
	addi	x4, x5, 0	# o_param_b m
	sw	x1, 2(x2)	# o_param_b m
	addi	x2, x2, 3	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -3730	# o_param_b m
	subi	x2, x2, 3	# o_param_b m
	lw	x1, 2(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	fneg	f1, f1	# fneg (o_param_b m)
	lw	x4, 1(x2)	# nvector.(1) <- fneg (o_param_b m)
	fsw	f1, 1(x4)	# nvector.(1) <- fneg (o_param_b m)
	lw	x5, 0(x2)	# o_param_c m
	addi	x4, x5, 0	# o_param_c m
	sw	x1, 2(x2)	# o_param_c m
	addi	x2, x2, 3	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -3739	# o_param_c m
	subi	x2, x2, 3	# o_param_c m
	lw	x1, 2(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	fneg	f1, f1	# fneg (o_param_c m)
	lw	x4, 1(x2)	# nvector.(2) <- fneg (o_param_c m)
	fsw	f1, 2(x4)	# nvector.(2) <- fneg (o_param_c m)
	jalr x0, x1, 0	# nvector.(2) <- fneg (o_param_c m)
# get_nvector_second.2848:	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	lw	x5, 5(x29)	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	lw	x6, 4(x29)	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	flw	f1, 0(x6)	# intersection_point.(0)
	sw	x5, 0(x2)	# o_param_x m
	sw	x4, 1(x2)	# o_param_x m
	sw	x6, 2(x2)	# o_param_x m
	fsw	f1, 3(x2)	# o_param_x m
	sw	x1, 4(x2)	# o_param_x m
	addi	x2, x2, 5	# o_param_x m
	auipc	x31, -1	# o_param_x m
	jalr	x0, x31, -3753	# o_param_x m
	subi	x2, x2, 5	# o_param_x m
	lw	x1, 4(x2)	# o_param_x m
	fmr	f1, f1	# o_param_x m
	flw	f2, 3(x2)	# intersection_point.(0) -. o_param_x m
	# let p0 = intersection_point.(0) -. o_param_x m
	fsub	f1, f2, f1	# intersection_point.(0) -. o_param_x m
	lw	x4, 2(x2)	# intersection_point.(1)
	flw	f2, 1(x4)	# intersection_point.(1)
	lw	x5, 1(x2)	# o_param_y m
	fsw	f1, 4(x2)	# o_param_y m
	fsw	f2, 5(x2)	# o_param_y m
	addi	x4, x5, 0	# o_param_y m
	sw	x1, 6(x2)	# o_param_y m
	addi	x2, x2, 7	# o_param_y m
	auipc	x31, -1	# o_param_y m
	jalr	x0, x31, -3764	# o_param_y m
	subi	x2, x2, 7	# o_param_y m
	lw	x1, 6(x2)	# o_param_y m
	fmr	f1, f1	# o_param_y m
	flw	f2, 5(x2)	# intersection_point.(1) -. o_param_y m
	# let p1 = intersection_point.(1) -. o_param_y m
	fsub	f1, f2, f1	# intersection_point.(1) -. o_param_y m
	lw	x4, 2(x2)	# intersection_point.(2)
	flw	f2, 2(x4)	# intersection_point.(2)
	lw	x4, 1(x2)	# o_param_z m
	fsw	f1, 6(x2)	# o_param_z m
	fsw	f2, 7(x2)	# o_param_z m
	sw	x1, 8(x2)	# o_param_z m
	addi	x2, x2, 9	# o_param_z m
	auipc	x31, -1	# o_param_z m
	jalr	x0, x31, -3776	# o_param_z m
	subi	x2, x2, 9	# o_param_z m
	lw	x1, 8(x2)	# o_param_z m
	fmr	f1, f1	# o_param_z m
	flw	f2, 7(x2)	# intersection_point.(2) -. o_param_z m
	# let p2 = intersection_point.(2) -. o_param_z m
	fsub	f1, f2, f1	# intersection_point.(2) -. o_param_z m
	lw	x4, 1(x2)	# o_param_a m
	fsw	f1, 8(x2)	# o_param_a m
	sw	x1, 9(x2)	# o_param_a m
	addi	x2, x2, 10	# o_param_a m
	auipc	x31, -1	# o_param_a m
	jalr	x0, x31, -3804	# o_param_a m
	subi	x2, x2, 10	# o_param_a m
	lw	x1, 9(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	flw	f2, 4(x2)	# p0 *. o_param_a m
	# let d0 = p0 *. o_param_a m
	fmul	f1, f2, f1	# p0 *. o_param_a m
	lw	x4, 1(x2)	# o_param_b m
	fsw	f1, 9(x2)	# o_param_b m
	sw	x1, 10(x2)	# o_param_b m
	addi	x2, x2, 11	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -3812	# o_param_b m
	subi	x2, x2, 11	# o_param_b m
	lw	x1, 10(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	flw	f2, 6(x2)	# p1 *. o_param_b m
	# let d1 = p1 *. o_param_b m
	fmul	f1, f2, f1	# p1 *. o_param_b m
	lw	x4, 1(x2)	# o_param_c m
	fsw	f1, 10(x2)	# o_param_c m
	sw	x1, 11(x2)	# o_param_c m
	addi	x2, x2, 12	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -3820	# o_param_c m
	subi	x2, x2, 12	# o_param_c m
	lw	x1, 11(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	flw	f2, 8(x2)	# p2 *. o_param_c m
	# let d2 = p2 *. o_param_c m
	fmul	f1, f2, f1	# p2 *. o_param_c m
	lw	x4, 1(x2)	# o_isrot m
	fsw	f1, 11(x2)	# o_isrot m
	sw	x1, 12(x2)	# o_isrot m
	addi	x2, x2, 13	# o_isrot m
	auipc	x31, -1	# o_isrot m
	jalr	x0, x31, -3839	# o_isrot m
	subi	x2, x2, 13	# o_isrot m
	lw	x1, 12(x2)	# o_isrot m
	addi	x4, x4, 0	# o_isrot m
	bne	x4, x0, 10	# if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) )
# beq:	nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2
	lw	x4, 0(x2)	# nvector.(0) <- d0
	flw	f1, 9(x2)	# nvector.(0) <- d0
	fsw	f1, 0(x4)	# nvector.(0) <- d0
	flw	f1, 10(x2)	# nvector.(1) <- d1
	fsw	f1, 1(x4)	# nvector.(1) <- d1
	flw	f1, 11(x2)	# nvector.(2) <- d2
	fsw	f1, 2(x4)	# nvector.(2) <- d2
	jalr x0, x1, 0	# nvector.(2) <- d2
	jal	x0, 88	# if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) )
# bne:	nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	lw	x4, 1(x2)	# o_param_r3 m
	sw	x1, 12(x2)	# o_param_r3 m
	addi	x2, x2, 13	# o_param_r3 m
	auipc	x31, -1	# o_param_r3 m
	jalr	x0, x31, -3814	# o_param_r3 m
	subi	x2, x2, 13	# o_param_r3 m
	lw	x1, 12(x2)	# o_param_r3 m
	fmr	f1, f1	# o_param_r3 m
	flw	f2, 6(x2)	# p1 *. o_param_r3 m
	fmul	f1, f2, f1	# p1 *. o_param_r3 m
	lw	x4, 1(x2)	# o_param_r2 m
	fsw	f1, 12(x2)	# o_param_r2 m
	sw	x1, 13(x2)	# o_param_r2 m
	addi	x2, x2, 14	# o_param_r2 m
	auipc	x31, -1	# o_param_r2 m
	jalr	x0, x31, -3828	# o_param_r2 m
	subi	x2, x2, 14	# o_param_r2 m
	lw	x1, 13(x2)	# o_param_r2 m
	fmr	f1, f1	# o_param_r2 m
	flw	f2, 8(x2)	# p2 *. o_param_r2 m
	fmul	f1, f2, f1	# p2 *. o_param_r2 m
	flw	f3, 12(x2)	# p1 *. o_param_r3 m +. p2 *. o_param_r2 m
	fadd	f1, f3, f1	# p1 *. o_param_r3 m +. p2 *. o_param_r2 m
	fmul	f1, f1, f27	# fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	flw	f3, 9(x2)	# d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	fadd	f1, f3, f1	# d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	lw	x4, 0(x2)	# nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	fsw	f1, 0(x4)	# nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m)
	lw	x5, 1(x2)	# o_param_r3 m
	addi	x4, x5, 0	# o_param_r3 m
	sw	x1, 13(x2)	# o_param_r3 m
	addi	x2, x2, 14	# o_param_r3 m
	auipc	x31, -1	# o_param_r3 m
	jalr	x0, x31, -3842	# o_param_r3 m
	subi	x2, x2, 14	# o_param_r3 m
	lw	x1, 13(x2)	# o_param_r3 m
	fmr	f1, f1	# o_param_r3 m
	flw	f2, 4(x2)	# p0 *. o_param_r3 m
	fmul	f1, f2, f1	# p0 *. o_param_r3 m
	lw	x4, 1(x2)	# o_param_r1 m
	fsw	f1, 13(x2)	# o_param_r1 m
	sw	x1, 14(x2)	# o_param_r1 m
	addi	x2, x2, 15	# o_param_r1 m
	auipc	x31, -1	# o_param_r1 m
	jalr	x0, x31, -3860	# o_param_r1 m
	subi	x2, x2, 15	# o_param_r1 m
	lw	x1, 14(x2)	# o_param_r1 m
	fmr	f1, f1	# o_param_r1 m
	flw	f2, 8(x2)	# p2 *. o_param_r1 m
	fmul	f1, f2, f1	# p2 *. o_param_r1 m
	flw	f2, 13(x2)	# p0 *. o_param_r3 m +. p2 *. o_param_r1 m
	fadd	f1, f2, f1	# p0 *. o_param_r3 m +. p2 *. o_param_r1 m
	fmul	f1, f1, f27	# fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	flw	f2, 10(x2)	# d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	fadd	f1, f2, f1	# d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	lw	x4, 0(x2)	# nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	fsw	f1, 1(x4)	# nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m)
	lw	x5, 1(x2)	# o_param_r2 m
	addi	x4, x5, 0	# o_param_r2 m
	sw	x1, 14(x2)	# o_param_r2 m
	addi	x2, x2, 15	# o_param_r2 m
	auipc	x31, -1	# o_param_r2 m
	jalr	x0, x31, -3874	# o_param_r2 m
	subi	x2, x2, 15	# o_param_r2 m
	lw	x1, 14(x2)	# o_param_r2 m
	fmr	f1, f1	# o_param_r2 m
	flw	f2, 4(x2)	# p0 *. o_param_r2 m
	fmul	f1, f2, f1	# p0 *. o_param_r2 m
	lw	x4, 1(x2)	# o_param_r1 m
	fsw	f1, 14(x2)	# o_param_r1 m
	sw	x1, 15(x2)	# o_param_r1 m
	addi	x2, x2, 16	# o_param_r1 m
	auipc	x31, -1	# o_param_r1 m
	jalr	x0, x31, -3889	# o_param_r1 m
	subi	x2, x2, 16	# o_param_r1 m
	lw	x1, 15(x2)	# o_param_r1 m
	fmr	f1, f1	# o_param_r1 m
	flw	f2, 6(x2)	# p1 *. o_param_r1 m
	fmul	f1, f2, f1	# p1 *. o_param_r1 m
	flw	f2, 14(x2)	# p0 *. o_param_r2 m +. p1 *. o_param_r1 m
	fadd	f1, f2, f1	# p0 *. o_param_r2 m +. p1 *. o_param_r1 m
	fmul	f1, f1, f27	# fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	flw	f2, 11(x2)	# d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	fadd	f1, f2, f1	# d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	lw	x4, 0(x2)	# nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	fsw	f1, 2(x4)	# nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
	jalr x0, x1, 0	# nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m)
# cont:	if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) )
	lw	x5, 1(x2)	# o_isinvert m
	addi	x4, x5, 0	# o_isinvert m
	sw	x1, 15(x2)	# o_isinvert m
	addi	x2, x2, 16	# o_isinvert m
	auipc	x31, -1	# o_isinvert m
	jalr	x0, x31, -3946	# o_isinvert m
	subi	x2, x2, 16	# o_isinvert m
	lw	x1, 15(x2)	# o_isinvert m
	addi	x5, x4, 0	# o_isinvert m
	lw	x4, 0(x2)	# vecunit_sgn nvector (o_isinvert m)
	auipc	x31, -1	# vecunit_sgn nvector (o_isinvert m)
	jalr	x0, x31, -4069	# vecunit_sgn nvector (o_isinvert m)
# get_nvector.2850:	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	lw	x6, 6(x29)	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	lw	x7, 5(x29)	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	lw	x8, 4(x29)	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	sw	x6, 0(x2)	# o_form m
	sw	x4, 1(x2)	# o_form m
	sw	x8, 2(x2)	# o_form m
	sw	x5, 3(x2)	# o_form m
	sw	x7, 4(x2)	# o_form m
	# let m_shape = o_form m
	sw	x1, 5(x2)	# o_form m
	addi	x2, x2, 6	# o_form m
	auipc	x31, -1	# o_form m
	jalr	x0, x31, -3969	# o_form m
	subi	x2, x2, 6	# o_form m
	lw	x1, 5(x2)	# o_form m
	addi	x4, x4, 0	# o_form m
	addi	x5, x0, 1	# 1
	bne	x4, x5, 5	# if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
# beq:	get_nvector_rect dirvec
	lw	x4, 3(x2)	# get_nvector_rect dirvec
	lw	x29, 4(x2)	# get_nvector_rect dirvec
	lw	x31, 0(x29)	# get_nvector_rect dirvec
	jalr	x0, x31, 0	# get_nvector_rect dirvec
# bne:	if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	addi	x5, x0, 2	# 2
	bne	x4, x5, 5	# if m_shape = 2 then get_nvector_plane m else get_nvector_second m
# beq:	get_nvector_plane m
	lw	x4, 1(x2)	# get_nvector_plane m
	lw	x29, 2(x2)	# get_nvector_plane m
	lw	x31, 0(x29)	# get_nvector_plane m
	jalr	x0, x31, 0	# get_nvector_plane m
# bne:	get_nvector_second m
	lw	x4, 1(x2)	# get_nvector_second m
	lw	x29, 0(x2)	# get_nvector_second m
	lw	x31, 0(x29)	# get_nvector_second m
	jalr	x0, x31, 0	# get_nvector_second m
# utexture.2853:	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	lw	x6, 4(x29)	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	sw	x5, 0(x2)	# o_texturetype m
	sw	x6, 1(x2)	# o_texturetype m
	sw	x4, 2(x2)	# o_texturetype m
	# let m_tex = o_texturetype m
	sw	x1, 3(x2)	# o_texturetype m
	addi	x2, x2, 4	# o_texturetype m
	auipc	x31, -1	# o_texturetype m
	jalr	x0, x31, -3998	# o_texturetype m
	subi	x2, x2, 4	# o_texturetype m
	lw	x1, 3(x2)	# o_texturetype m
	addi	x4, x4, 0	# o_texturetype m
	lw	x5, 2(x2)	# o_color_red m
	sw	x4, 3(x2)	# o_color_red m
	addi	x4, x5, 0	# o_color_red m
	sw	x1, 4(x2)	# o_color_red m
	addi	x2, x2, 5	# o_color_red m
	auipc	x31, -1	# o_color_red m
	jalr	x0, x31, -3971	# o_color_red m
	subi	x2, x2, 5	# o_color_red m
	lw	x1, 4(x2)	# o_color_red m
	fmr	f1, f1	# o_color_red m
	lw	x4, 1(x2)	# texture_color.(0) <- o_color_red m
	fsw	f1, 0(x4)	# texture_color.(0) <- o_color_red m
	lw	x5, 2(x2)	# o_color_green m
	addi	x4, x5, 0	# o_color_green m
	sw	x1, 4(x2)	# o_color_green m
	addi	x2, x2, 5	# o_color_green m
	auipc	x31, -1	# o_color_green m
	jalr	x0, x31, -3979	# o_color_green m
	subi	x2, x2, 5	# o_color_green m
	lw	x1, 4(x2)	# o_color_green m
	fmr	f1, f1	# o_color_green m
	lw	x4, 1(x2)	# texture_color.(1) <- o_color_green m
	fsw	f1, 1(x4)	# texture_color.(1) <- o_color_green m
	lw	x5, 2(x2)	# o_color_blue m
	addi	x4, x5, 0	# o_color_blue m
	sw	x1, 4(x2)	# o_color_blue m
	addi	x2, x2, 5	# o_color_blue m
	auipc	x31, -1	# o_color_blue m
	jalr	x0, x31, -3987	# o_color_blue m
	subi	x2, x2, 5	# o_color_blue m
	lw	x1, 4(x2)	# o_color_blue m
	fmr	f1, f1	# o_color_blue m
	lw	x4, 1(x2)	# texture_color.(2) <- o_color_blue m
	fsw	f1, 2(x4)	# texture_color.(2) <- o_color_blue m
	addi	x5, x0, 1	# 1
	lw	x6, 3(x2)	# if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	bne	x6, x5, 68	# if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	lw	x5, 0(x2)	# p.(0)
	flw	f1, 0(x5)	# p.(0)
	lw	x6, 2(x2)	# o_param_x m
	fsw	f1, 4(x2)	# o_param_x m
	addi	x4, x6, 0	# o_param_x m
	sw	x1, 5(x2)	# o_param_x m
	addi	x2, x2, 6	# o_param_x m
	auipc	x31, -1	# o_param_x m
	jalr	x0, x31, -4025	# o_param_x m
	subi	x2, x2, 6	# o_param_x m
	lw	x1, 5(x2)	# o_param_x m
	fmr	f1, f1	# o_param_x m
	flw	f2, 4(x2)	# p.(0) -. o_param_x m
	# let w1 = p.(0) -. o_param_x m
	fsub	f1, f2, f1	# p.(0) -. o_param_x m
	lui	x31, 251085	# 0.05
	addi	x31, x31, 1028443341	# 0.05
	mvitof	f2, x31	# 0.05
	fmul	f2, f1, f2	# w1 *. 0.05
	floor	f2, f2	# floor (w1 *. 0.05)
	# let d1 = (floor (w1 *. 0.05)) *. 20.0
	fmul	f2, f2, f16	# (floor (w1 *. 0.05)) *. 20.0
	fsub	f1, f1, f2	# w1 -. d1
	# let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0
	flt	x4, f14, f14	# fless (w1 -. d1) 10.0
	lw	x5, 0(x2)	# p.(2)
	flw	f1, 2(x5)	# p.(2)
	lw	x5, 2(x2)	# o_param_z m
	sw	x4, 5(x2)	# o_param_z m
	fsw	f1, 6(x2)	# o_param_z m
	addi	x4, x5, 0	# o_param_z m
	sw	x1, 7(x2)	# o_param_z m
	addi	x2, x2, 8	# o_param_z m
	auipc	x31, -1	# o_param_z m
	jalr	x0, x31, -4042	# o_param_z m
	subi	x2, x2, 8	# o_param_z m
	lw	x1, 7(x2)	# o_param_z m
	fmr	f1, f1	# o_param_z m
	flw	f2, 6(x2)	# p.(2) -. o_param_z m
	# let w3 = p.(2) -. o_param_z m
	fsub	f1, f2, f1	# p.(2) -. o_param_z m
	lui	x31, 251085	# 0.05
	addi	x31, x31, 1028443341	# 0.05
	mvitof	f2, x31	# 0.05
	fmul	f2, f1, f2	# w3 *. 0.05
	floor	f2, f2	# floor (w3 *. 0.05)
	# let d2 = (floor (w3 *. 0.05)) *. 20.0
	fmul	f2, f2, f16	# (floor (w3 *. 0.05)) *. 20.0
	fsub	f1, f1, f2	# w3 -. d2
	# let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0
	flt	x4, f14, f14	# fless (w3 -. d2) 10.0
	lw	x5, 5(x2)	# if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	bne	x5, x0, 10	# if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
# beq:	if flag2 then 0.0 else 255.0
	bne	x4, x0, 5	# if flag2 then 0.0 else 255.0
# beq:	255.0
	lui	x31, 276464	# 255.0
	addi	x31, x31, 1132396544	# 255.0
	mvitof	f1, x31	# 255.0
	jalr	x0, x1, 0	# 255.0
# bne:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
	jal	x0, 9	# if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
# bne:	if flag2 then 255.0 else 0.0
	bne	x4, x0, 4	# if flag2 then 255.0 else 0.0
# beq:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
# bne:	255.0
	lui	x31, 276464	# 255.0
	addi	x31, x31, 1132396544	# 255.0
	mvitof	f1, x31	# 255.0
	jalr	x0, x1, 0	# 255.0
# cont:	if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	lw	x4, 1(x2)	# texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	fsw	f1, 1(x4)	# texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
	jalr x0, x1, 0	# texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0)
# bne:	if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x5, x0, 2	# 2
	bne	x6, x5, 12	# if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2)
	lw	x5, 0(x2)	# p.(1)
	flw	f1, 1(x5)	# p.(1)
	fmul	f1, f1, f26	# p.(1) *. 0.25
	sin	f1, f1	# sin (p.(1) *. 0.25)
	# let w2 = fsqr (sin (p.(1) *. 0.25))
	fmul	f1, f1, f1	# fsqr (sin (p.(1) *. 0.25))
	fmul	f2, f19, f1	# 255.0 *. w2
	fsw	f2, 0(x4)	# texture_color.(0) <- 255.0 *. w2
	fsub	f1, f11, f1	# 1.0 -. w2
	fmul	f1, f19, f1	# 255.0 *. (1.0 -. w2)
	fsw	f1, 1(x4)	# texture_color.(1) <- 255.0 *. (1.0 -. w2)
	jalr x0, x1, 0	# texture_color.(1) <- 255.0 *. (1.0 -. w2)
# bne:	if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x5, x0, 3	# 3
	bne	x6, x5, 47	# if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0
	lw	x5, 0(x2)	# p.(0)
	flw	f1, 0(x5)	# p.(0)
	lw	x6, 2(x2)	# o_param_x m
	fsw	f1, 7(x2)	# o_param_x m
	addi	x4, x6, 0	# o_param_x m
	sw	x1, 8(x2)	# o_param_x m
	addi	x2, x2, 9	# o_param_x m
	auipc	x31, -1	# o_param_x m
	jalr	x0, x31, -4107	# o_param_x m
	subi	x2, x2, 9	# o_param_x m
	lw	x1, 8(x2)	# o_param_x m
	fmr	f1, f1	# o_param_x m
	flw	f2, 7(x2)	# p.(0) -. o_param_x m
	# let w1 = p.(0) -. o_param_x m
	fsub	f1, f2, f1	# p.(0) -. o_param_x m
	lw	x4, 0(x2)	# p.(2)
	flw	f2, 2(x4)	# p.(2)
	lw	x4, 2(x2)	# o_param_z m
	fsw	f1, 8(x2)	# o_param_z m
	fsw	f2, 9(x2)	# o_param_z m
	sw	x1, 10(x2)	# o_param_z m
	addi	x2, x2, 11	# o_param_z m
	auipc	x31, -1	# o_param_z m
	jalr	x0, x31, -4116	# o_param_z m
	subi	x2, x2, 11	# o_param_z m
	lw	x1, 10(x2)	# o_param_z m
	fmr	f1, f1	# o_param_z m
	flw	f2, 9(x2)	# p.(2) -. o_param_z m
	# let w3 = p.(2) -. o_param_z m
	fsub	f1, f2, f1	# p.(2) -. o_param_z m
	flw	f2, 8(x2)	# fsqr w1
	fmul	f2, f2, f2	# fsqr w1
	fmul	f1, f1, f1	# fsqr w3
	fadd	f1, f2, f1	# fsqr w1 +. fsqr w3
	fsqrt	f1, f1	# sqrt (fsqr w1 +. fsqr w3)
	# let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0
	fmul	f1, f1, f21	# sqrt (fsqr w1 +. fsqr w3) /. 10.0
	floor	f2, f1	# floor w2
	fsub	f1, f1, f2	# w2 -. floor w2
	# let w4 = (w2 -. floor w2) *. 3.1415927
	fmul	f1, f1, f28	# (w2 -. floor w2) *. 3.1415927
	cos	f1, f1	# cos w4
	# let cws = fsqr (cos w4)
	fmul	f1, f1, f1	# fsqr (cos w4)
	fmul	f2, f1, f19	# cws *. 255.0
	lw	x4, 1(x2)	# texture_color.(1) <- cws *. 255.0
	fsw	f2, 1(x4)	# texture_color.(1) <- cws *. 255.0
	fsub	f1, f11, f1	# 1.0 -. cws
	fmul	f1, f1, f19	# (1.0 -. cws) *. 255.0
	fsw	f1, 2(x4)	# texture_color.(2) <- (1.0 -. cws) *. 255.0
	jalr x0, x1, 0	# texture_color.(2) <- (1.0 -. cws) *. 255.0
# bne:	if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x5, x0, 4	# 4
	bne	x6, x5, 158	# if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
# beq:	let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3
	lw	x5, 0(x2)	# p.(0)
	flw	f1, 0(x5)	# p.(0)
	lw	x6, 2(x2)	# o_param_x m
	fsw	f1, 10(x2)	# o_param_x m
	addi	x4, x6, 0	# o_param_x m
	sw	x1, 11(x2)	# o_param_x m
	addi	x2, x2, 12	# o_param_x m
	auipc	x31, -1	# o_param_x m
	jalr	x0, x31, -4155	# o_param_x m
	subi	x2, x2, 12	# o_param_x m
	lw	x1, 11(x2)	# o_param_x m
	fmr	f1, f1	# o_param_x m
	flw	f2, 10(x2)	# p.(0) -. o_param_x m
	fsub	f1, f2, f1	# p.(0) -. o_param_x m
	lw	x4, 2(x2)	# o_param_a m
	fsw	f1, 11(x2)	# o_param_a m
	sw	x1, 12(x2)	# o_param_a m
	addi	x2, x2, 13	# o_param_a m
	auipc	x31, -1	# o_param_a m
	jalr	x0, x31, -4178	# o_param_a m
	subi	x2, x2, 13	# o_param_a m
	lw	x1, 12(x2)	# o_param_a m
	fmr	f1, f1	# o_param_a m
	fsqrt	f1, f1	# sqrt (o_param_a m)
	flw	f2, 11(x2)	# (p.(0) -. o_param_x m) *. (sqrt (o_param_a m))
	# let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m))
	fmul	f1, f2, f1	# (p.(0) -. o_param_x m) *. (sqrt (o_param_a m))
	lw	x4, 0(x2)	# p.(2)
	flw	f2, 2(x4)	# p.(2)
	lw	x5, 2(x2)	# o_param_z m
	fsw	f1, 12(x2)	# o_param_z m
	fsw	f2, 13(x2)	# o_param_z m
	addi	x4, x5, 0	# o_param_z m
	sw	x1, 14(x2)	# o_param_z m
	addi	x2, x2, 15	# o_param_z m
	auipc	x31, -1	# o_param_z m
	jalr	x0, x31, -4176	# o_param_z m
	subi	x2, x2, 15	# o_param_z m
	lw	x1, 14(x2)	# o_param_z m
	fmr	f1, f1	# o_param_z m
	flw	f2, 13(x2)	# p.(2) -. o_param_z m
	fsub	f1, f2, f1	# p.(2) -. o_param_z m
	lw	x4, 2(x2)	# o_param_c m
	fsw	f1, 14(x2)	# o_param_c m
	sw	x1, 15(x2)	# o_param_c m
	addi	x2, x2, 16	# o_param_c m
	auipc	x31, -1	# o_param_c m
	jalr	x0, x31, -4199	# o_param_c m
	subi	x2, x2, 16	# o_param_c m
	lw	x1, 15(x2)	# o_param_c m
	fmr	f1, f1	# o_param_c m
	fsqrt	f1, f1	# sqrt (o_param_c m)
	flw	f2, 14(x2)	# (p.(2) -. o_param_z m) *. (sqrt (o_param_c m))
	# let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m))
	fmul	f1, f2, f1	# (p.(2) -. o_param_z m) *. (sqrt (o_param_c m))
	flw	f2, 12(x2)	# fsqr w1
	fmul	f3, f2, f2	# fsqr w1
	fmul	f4, f1, f1	# fsqr w3
	# let w4 = (fsqr w1) +. (fsqr w3)
	fadd	f3, f3, f4	# (fsqr w1) +. (fsqr w3)
	fabs	f4, f2	# fabs w1
	lui	x31, 232731	# 1.0e-4
	addi	x31, x31, 953267991	# 1.0e-4
	mvitof	f4, x31	# 1.0e-4
	flt	x4, f4, f4	# fless (fabs w1) 1.0e-4
	# let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
	bne	x4, x0, 14	# if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
# beq:	let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
	fdiv	f1, f1, f2	# w3 /. w1
	# let w5 = fabs (w3 /. w1)
	fabs	f1, f1	# fabs (w3 /. w1)
	atan	f1, f1	# atan w5
	lui	x31, 270080	# 30.0
	addi	x31, x31, 1106247680	# 30.0
	mvitof	f2, x31	# 30.0
	fmul	f1, f1, f2	# (atan w5) *. 30.0
	lui	x31, 256560	# ((atan w5) *. 30.0) /. 3.1415927
	addi	x31, x31, 1050868099	# ((atan w5) *. 30.0) /. 3.1415927
	mvitof	f2, x31	# ((atan w5) *. 30.0) /. 3.1415927
	fmul	f1, f1, f2	# ((atan w5) *. 30.0) /. 3.1415927
	jalr	x0, x1, 0	# ((atan w5) *. 30.0) /. 3.1415927
	jal	x0, 5	# if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
# bne:	15.0
	lui	x31, 268032	# 15.0
	addi	x31, x31, 1097859072	# 15.0
	mvitof	f1, x31	# 15.0
	jalr	x0, x1, 0	# 15.0
# cont:	if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927
	floor	f2, f1	# floor w7
	# let w9 = w7 -. (floor w7)
	fsub	f1, f1, f2	# w7 -. (floor w7)
	lw	x4, 0(x2)	# p.(1)
	flw	f2, 1(x4)	# p.(1)
	lw	x4, 2(x2)	# o_param_y m
	fsw	f1, 15(x2)	# o_param_y m
	fsw	f3, 16(x2)	# o_param_y m
	fsw	f2, 17(x2)	# o_param_y m
	sw	x1, 18(x2)	# o_param_y m
	addi	x2, x2, 19	# o_param_y m
	auipc	x31, -1	# o_param_y m
	jalr	x0, x31, -4236	# o_param_y m
	subi	x2, x2, 19	# o_param_y m
	lw	x1, 18(x2)	# o_param_y m
	fmr	f1, f1	# o_param_y m
	flw	f2, 17(x2)	# p.(1) -. o_param_y m
	fsub	f1, f2, f1	# p.(1) -. o_param_y m
	lw	x4, 2(x2)	# o_param_b m
	fsw	f1, 18(x2)	# o_param_b m
	sw	x1, 19(x2)	# o_param_b m
	addi	x2, x2, 20	# o_param_b m
	auipc	x31, -1	# o_param_b m
	jalr	x0, x31, -4258	# o_param_b m
	subi	x2, x2, 20	# o_param_b m
	lw	x1, 19(x2)	# o_param_b m
	fmr	f1, f1	# o_param_b m
	fsqrt	f1, f1	# sqrt (o_param_b m)
	flw	f2, 18(x2)	# (p.(1) -. o_param_y m) *. (sqrt (o_param_b m))
	# let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m))
	fmul	f1, f2, f1	# (p.(1) -. o_param_y m) *. (sqrt (o_param_b m))
	flw	f2, 16(x2)	# fabs w4
	fabs	f3, f2	# fabs w4
	lui	x31, 232731	# 1.0e-4
	addi	x31, x31, 953267991	# 1.0e-4
	mvitof	f3, x31	# 1.0e-4
	flt	x4, f3, f3	# fless (fabs w4) 1.0e-4
	# let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
	bne	x4, x0, 14	# if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
# beq:	let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
	fdiv	f1, f1, f2	# w2 /. w4
	# let w6 = fabs (w2 /. w4)
	fabs	f1, f1	# fabs (w2 /. w4)
	atan	f1, f1	# atan w6
	lui	x31, 270080	# 30.0
	addi	x31, x31, 1106247680	# 30.0
	mvitof	f2, x31	# 30.0
	fmul	f1, f1, f2	# (atan w6) *. 30.0
	lui	x31, 256560	# ((atan w6) *. 30.0) /. 3.1415927
	addi	x31, x31, 1050868099	# ((atan w6) *. 30.0) /. 3.1415927
	mvitof	f2, x31	# ((atan w6) *. 30.0) /. 3.1415927
	fmul	f1, f1, f2	# ((atan w6) *. 30.0) /. 3.1415927
	jalr	x0, x1, 0	# ((atan w6) *. 30.0) /. 3.1415927
	jal	x0, 5	# if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
# bne:	15.0
	lui	x31, 268032	# 15.0
	addi	x31, x31, 1097859072	# 15.0
	mvitof	f1, x31	# 15.0
	jalr	x0, x1, 0	# 15.0
# cont:	if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927
	floor	f2, f1	# floor w8
	# let w10 = w8 -. (floor w8)
	fsub	f1, f1, f2	# w8 -. (floor w8)
	flw	f2, 15(x2)	# 0.5 -. w9
	fsub	f2, f27, f2	# 0.5 -. w9
	fmul	f2, f2, f2	# fsqr (0.5 -. w9)
	fsub	f2, f25, f2	# 0.15 -. (fsqr (0.5 -. w9))
	fsub	f1, f27, f1	# 0.5 -. w10
	fmul	f1, f1, f1	# fsqr (0.5 -. w10)
	# let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10))
	fsub	f1, f2, f1	# 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10))
	flt	x4, f0, f0	# fisneg w11
	# let w12 = if fisneg w11 then 0.0 else w11
	bne	x4, x0, 3	# if fisneg w11 then 0.0 else w11
# beq:	w11
	jalr	x0, x1, 0	# w11
	jal	x0, 4	# if fisneg w11 then 0.0 else w11
# bne:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
# cont:	if fisneg w11 then 0.0 else w11
	fmul	f1, f19, f1	# 255.0 *. w12
	lui	x31, 263509	# (255.0 *. w12) /. 0.3
	addi	x31, x31, 1079334229	# (255.0 *. w12) /. 0.3
	mvitof	f2, x31	# (255.0 *. w12) /. 0.3
	fmul	f1, f1, f2	# (255.0 *. w12) /. 0.3
	lw	x4, 1(x2)	# texture_color.(2) <- (255.0 *. w12) /. 0.3
	fsw	f1, 2(x4)	# texture_color.(2) <- (255.0 *. w12) /. 0.3
	jalr x0, x1, 0	# texture_color.(2) <- (255.0 *. w12) /. 0.3
# bne:	()
	jalr x0, x1, 0	# ()
# add_light.2856:	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	lw	x5, 5(x29)	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	lw	x4, 4(x29)	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	flt	x6, f1, f1	# fispos bright
	sw	x4, 0(x2)	# if fispos bright then vecaccum rgb bright texture_color else ()
	fsw	f3, 1(x2)	# if fispos bright then vecaccum rgb bright texture_color else ()
	fsw	f2, 2(x2)	# if fispos bright then vecaccum rgb bright texture_color else ()
	bne	x6, x0, 3	# if fispos bright then vecaccum rgb bright texture_color else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 3	# if fispos bright then vecaccum rgb bright texture_color else ()
# bne:	vecaccum rgb bright texture_color
	auipc	x31, -1	# vecaccum rgb bright texture_color
	jalr	x0, x31, -4392	# vecaccum rgb bright texture_color
# cont:	if fispos bright then vecaccum rgb bright texture_color else ()
	flw	f1, 2(x2)	# fispos hilight
	flt	x4, f1, f1	# fispos hilight
	bne	x4, x0, 2	# if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl
	fmul	f1, f1, f1	# fsqr hilight
	fmul	f1, f1, f1	# fsqr (fsqr hilight)
	flw	f2, 1(x2)	# fsqr (fsqr hilight) *. hilight_scale
	# let ihl = fsqr (fsqr hilight) *. hilight_scale
	fmul	f1, f1, f2	# fsqr (fsqr hilight) *. hilight_scale
	lw	x4, 0(x2)	# rgb.(0)
	flw	f2, 0(x4)	# rgb.(0)
	fadd	f2, f2, f1	# rgb.(0) +. ihl
	fsw	f2, 0(x4)	# rgb.(0) <- rgb.(0) +. ihl
	flw	f2, 1(x4)	# rgb.(1)
	fadd	f2, f2, f1	# rgb.(1) +. ihl
	fsw	f2, 1(x4)	# rgb.(1) <- rgb.(1) +. ihl
	flw	f2, 2(x4)	# rgb.(2)
	fadd	f1, f2, f1	# rgb.(2) +. ihl
	fsw	f1, 2(x4)	# rgb.(2) <- rgb.(2) +. ihl
	jalr x0, x1, 0	# rgb.(2) <- rgb.(2) +. ihl
# trace_reflections.2860:	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x6, 11(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x7, 10(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x8, 9(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x9, 8(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x10, 7(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x11, 6(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x12, 5(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x13, 4(x29)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	bge	x4, x0, 2	# if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec
	# let rinfo = reflections.(index)
	lwa	x7, (x7, x4)	# reflections.(index)
	sw	x29, 0(x2)	# r_dvec rinfo
	sw	x4, 1(x2)	# r_dvec rinfo
	fsw	f2, 2(x2)	# r_dvec rinfo
	sw	x13, 3(x2)	# r_dvec rinfo
	sw	x5, 4(x2)	# r_dvec rinfo
	fsw	f1, 5(x2)	# r_dvec rinfo
	sw	x9, 6(x2)	# r_dvec rinfo
	sw	x6, 7(x2)	# r_dvec rinfo
	sw	x8, 8(x2)	# r_dvec rinfo
	sw	x7, 9(x2)	# r_dvec rinfo
	sw	x11, 10(x2)	# r_dvec rinfo
	sw	x12, 11(x2)	# r_dvec rinfo
	sw	x10, 12(x2)	# r_dvec rinfo
	# let dvec = r_dvec rinfo
	addi	x4, x7, 0	# r_dvec rinfo
	sw	x1, 13(x2)	# r_dvec rinfo
	addi	x2, x2, 14	# r_dvec rinfo
	auipc	x31, -1	# r_dvec rinfo
	jalr	x0, x31, -4302	# r_dvec rinfo
	subi	x2, x2, 14	# r_dvec rinfo
	lw	x1, 13(x2)	# r_dvec rinfo
	addi	x4, x4, 0	# r_dvec rinfo
	lw	x29, 12(x2)	# judge_intersection_fast dvec
	sw	x4, 13(x2)	# judge_intersection_fast dvec
	sw	x1, 14(x2)	# judge_intersection_fast dvec
	addi	x2, x2, 15	# judge_intersection_fast dvec
	lw	x31, 0(x29)	# judge_intersection_fast dvec
	jalr	x1, x31, 0	# judge_intersection_fast dvec
	subi	x2, x2, 15	# judge_intersection_fast dvec
	lw	x1, 14(x2)	# judge_intersection_fast dvec
	addi	x4, x4, 0	# judge_intersection_fast dvec
	bne	x4, x0, 3	# if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 87	# if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else ()
# bne:	let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
	lw	x4, 11(x2)	# intersected_object_id.(0)
	lw	x4, 0(x4)	# intersected_object_id.(0)
	slli	x4, x4, 2	# intersected_object_id.(0) * 4
	lw	x5, 10(x2)	# intsec_rectside.(0)
	lw	x5, 0(x5)	# intsec_rectside.(0)
	# let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0)
	add	x4, x4, x5	# intersected_object_id.(0) * 4 + intsec_rectside.(0)
	lw	x5, 9(x2)	# r_surface_id rinfo
	sw	x4, 14(x2)	# r_surface_id rinfo
	addi	x4, x5, 0	# r_surface_id rinfo
	sw	x1, 15(x2)	# r_surface_id rinfo
	addi	x2, x2, 16	# r_surface_id rinfo
	auipc	x31, -1	# r_surface_id rinfo
	jalr	x0, x31, -4332	# r_surface_id rinfo
	subi	x2, x2, 16	# r_surface_id rinfo
	lw	x1, 15(x2)	# r_surface_id rinfo
	addi	x4, x4, 0	# r_surface_id rinfo
	lw	x5, 14(x2)	# if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
	bne	x5, x4, 68	# if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else ()
# beq:	if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else ()
	addi	x4, x0, 0	# 0
	lw	x5, 8(x2)	# or_net.(0)
	lw	x5, 0(x5)	# or_net.(0)
	lw	x29, 7(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	sw	x1, 15(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, 16	# shadow_check_one_or_matrix 0 or_net.(0)
	lw	x31, 0(x29)	# shadow_check_one_or_matrix 0 or_net.(0)
	jalr	x1, x31, 0	# shadow_check_one_or_matrix 0 or_net.(0)
	subi	x2, x2, 16	# shadow_check_one_or_matrix 0 or_net.(0)
	lw	x1, 15(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	addi	x4, x4, 0	# shadow_check_one_or_matrix 0 or_net.(0)
	bne	x4, x0, 55	# if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else ()
# beq:	let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale
	lw	x4, 13(x2)	# d_vec dvec
	sw	x1, 15(x2)	# d_vec dvec
	addi	x2, x2, 16	# d_vec dvec
	auipc	x31, -1	# d_vec dvec
	jalr	x0, x31, -4359	# d_vec dvec
	subi	x2, x2, 16	# d_vec dvec
	lw	x1, 15(x2)	# d_vec dvec
	addi	x5, x4, 0	# d_vec dvec
	lw	x4, 6(x2)	# veciprod nvector (d_vec dvec)
	# let p = veciprod nvector (d_vec dvec)
	sw	x1, 15(x2)	# veciprod nvector (d_vec dvec)
	addi	x2, x2, 16	# veciprod nvector (d_vec dvec)
	auipc	x31, -1	# veciprod nvector (d_vec dvec)
	jalr	x0, x31, -4522	# veciprod nvector (d_vec dvec)
	subi	x2, x2, 16	# veciprod nvector (d_vec dvec)
	lw	x1, 15(x2)	# veciprod nvector (d_vec dvec)
	fmr	f1, f1	# veciprod nvector (d_vec dvec)
	lw	x4, 9(x2)	# r_bright rinfo
	fsw	f1, 15(x2)	# r_bright rinfo
	# let scale = r_bright rinfo
	sw	x1, 16(x2)	# r_bright rinfo
	addi	x2, x2, 17	# r_bright rinfo
	auipc	x31, -1	# r_bright rinfo
	jalr	x0, x31, -4368	# r_bright rinfo
	subi	x2, x2, 17	# r_bright rinfo
	lw	x1, 16(x2)	# r_bright rinfo
	fmr	f1, f1	# r_bright rinfo
	flw	f2, 5(x2)	# scale *. diffuse
	fmul	f3, f1, f2	# scale *. diffuse
	flw	f4, 15(x2)	# scale *. diffuse *. p
	# let bright = scale *. diffuse *. p
	fmul	f3, f3, f4	# scale *. diffuse *. p
	lw	x4, 13(x2)	# d_vec dvec
	fsw	f3, 16(x2)	# d_vec dvec
	fsw	f1, 17(x2)	# d_vec dvec
	sw	x1, 18(x2)	# d_vec dvec
	addi	x2, x2, 19	# d_vec dvec
	auipc	x31, -1	# d_vec dvec
	jalr	x0, x31, -4390	# d_vec dvec
	subi	x2, x2, 19	# d_vec dvec
	lw	x1, 18(x2)	# d_vec dvec
	addi	x5, x4, 0	# d_vec dvec
	lw	x4, 4(x2)	# veciprod dirvec (d_vec dvec)
	sw	x1, 18(x2)	# veciprod dirvec (d_vec dvec)
	addi	x2, x2, 19	# veciprod dirvec (d_vec dvec)
	auipc	x31, -1	# veciprod dirvec (d_vec dvec)
	jalr	x0, x31, -4553	# veciprod dirvec (d_vec dvec)
	subi	x2, x2, 19	# veciprod dirvec (d_vec dvec)
	lw	x1, 18(x2)	# veciprod dirvec (d_vec dvec)
	fmr	f1, f1	# veciprod dirvec (d_vec dvec)
	flw	f2, 17(x2)	# scale *. veciprod dirvec (d_vec dvec)
	# let hilight = scale *. veciprod dirvec (d_vec dvec)
	fmul	f2, f2, f1	# scale *. veciprod dirvec (d_vec dvec)
	flw	f1, 16(x2)	# add_light bright hilight hilight_scale
	flw	f3, 2(x2)	# add_light bright hilight hilight_scale
	lw	x29, 3(x2)	# add_light bright hilight hilight_scale
	lw	x31, 0(x29)	# add_light bright hilight hilight_scale
	jalr	x0, x31, 0	# add_light bright hilight hilight_scale
# bne:	()
	jalr x0, x1, 0	# ()
# bne:	()
	jalr x0, x1, 0	# ()
# cont:	if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else ()
	lw	x4, 1(x2)	# index - 1
	addi	x4, x4, -1	# index - 1
	flw	f1, 5(x2)	# trace_reflections (index - 1) diffuse hilight_scale dirvec
	flw	f2, 2(x2)	# trace_reflections (index - 1) diffuse hilight_scale dirvec
	lw	x5, 4(x2)	# trace_reflections (index - 1) diffuse hilight_scale dirvec
	lw	x29, 0(x2)	# trace_reflections (index - 1) diffuse hilight_scale dirvec
	lw	x31, 0(x29)	# trace_reflections (index - 1) diffuse hilight_scale dirvec
	jalr	x0, x31, 0	# trace_reflections (index - 1) diffuse hilight_scale dirvec
# trace_ray.2865:	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x7, 23(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x8, 22(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x9, 21(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x10, 20(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x11, 19(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x12, 18(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x13, 17(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x14, 16(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x15, 15(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x16, 14(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x17, 13(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x18, 12(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x19, 11(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x20, 10(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x21, 9(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x22, 8(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x23, 7(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x24, 6(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x25, 5(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lw	x26, 4(x29)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	addi	x27, x0, 4	# 4
	bge	x27, x4, 2	# if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () )
	sw	x29, 0(x2)	# p_surface_ids pixel
	fsw	f2, 1(x2)	# p_surface_ids pixel
	sw	x9, 2(x2)	# p_surface_ids pixel
	sw	x8, 3(x2)	# p_surface_ids pixel
	sw	x18, 4(x2)	# p_surface_ids pixel
	sw	x13, 5(x2)	# p_surface_ids pixel
	sw	x26, 6(x2)	# p_surface_ids pixel
	sw	x12, 7(x2)	# p_surface_ids pixel
	sw	x15, 8(x2)	# p_surface_ids pixel
	sw	x17, 9(x2)	# p_surface_ids pixel
	sw	x10, 10(x2)	# p_surface_ids pixel
	sw	x6, 11(x2)	# p_surface_ids pixel
	sw	x21, 12(x2)	# p_surface_ids pixel
	sw	x7, 13(x2)	# p_surface_ids pixel
	sw	x22, 14(x2)	# p_surface_ids pixel
	sw	x11, 15(x2)	# p_surface_ids pixel
	sw	x24, 16(x2)	# p_surface_ids pixel
	sw	x16, 17(x2)	# p_surface_ids pixel
	sw	x23, 18(x2)	# p_surface_ids pixel
	sw	x14, 19(x2)	# p_surface_ids pixel
	sw	x25, 20(x2)	# p_surface_ids pixel
	fsw	f1, 21(x2)	# p_surface_ids pixel
	sw	x19, 22(x2)	# p_surface_ids pixel
	sw	x4, 23(x2)	# p_surface_ids pixel
	sw	x5, 24(x2)	# p_surface_ids pixel
	sw	x20, 25(x2)	# p_surface_ids pixel
	# let surface_ids = p_surface_ids pixel
	addi	x4, x6, 0	# p_surface_ids pixel
	sw	x1, 26(x2)	# p_surface_ids pixel
	addi	x2, x2, 27	# p_surface_ids pixel
	auipc	x31, -1	# p_surface_ids pixel
	jalr	x0, x31, -4487	# p_surface_ids pixel
	subi	x2, x2, 27	# p_surface_ids pixel
	lw	x1, 26(x2)	# p_surface_ids pixel
	addi	x4, x4, 0	# p_surface_ids pixel
	lw	x5, 24(x2)	# judge_intersection dirvec
	lw	x29, 25(x2)	# judge_intersection dirvec
	sw	x4, 26(x2)	# judge_intersection dirvec
	addi	x4, x5, 0	# judge_intersection dirvec
	sw	x1, 27(x2)	# judge_intersection dirvec
	addi	x2, x2, 28	# judge_intersection dirvec
	lw	x31, 0(x29)	# judge_intersection dirvec
	jalr	x1, x31, 0	# judge_intersection dirvec
	subi	x2, x2, 28	# judge_intersection dirvec
	lw	x1, 27(x2)	# judge_intersection dirvec
	addi	x4, x4, 0	# judge_intersection dirvec
	bne	x4, x0, 38	# if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () )
# beq:	surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else ()
	addi	x4, x0, -1	# -1
	lw	x5, 23(x2)	# surface_ids.(nref) <- -1
	lw	x6, 26(x2)	# surface_ids.(nref) <- -1
	swa	x4, (x6, x5)	# surface_ids.(nref) <- -1
	bne	x5, x0, 2	# if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	lw	x4, 24(x2)	# veciprod dirvec light
	lw	x5, 22(x2)	# veciprod dirvec light
	sw	x1, 27(x2)	# veciprod dirvec light
	addi	x2, x2, 28	# veciprod dirvec light
	auipc	x31, -1	# veciprod dirvec light
	jalr	x0, x31, -4654	# veciprod dirvec light
	subi	x2, x2, 28	# veciprod dirvec light
	lw	x1, 27(x2)	# veciprod dirvec light
	fmr	f1, f1	# veciprod dirvec light
	# let hl = fneg (veciprod dirvec light)
	fneg	f1, f1	# fneg (veciprod dirvec light)
	flt	x4, f1, f1	# fispos hl
	bne	x4, x0, 2	# if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl
	fmul	f2, f1, f1	# fsqr hl
	fmul	f1, f2, f1	# fsqr hl *. hl
	flw	f2, 21(x2)	# fsqr hl *. hl *. energy
	fmul	f1, f1, f2	# fsqr hl *. hl *. energy
	lw	x4, 20(x2)	# beam.(0)
	flw	f2, 0(x4)	# beam.(0)
	# let ihl = fsqr hl *. hl *. energy *. beam.(0)
	fmul	f1, f1, f2	# fsqr hl *. hl *. energy *. beam.(0)
	lw	x4, 19(x2)	# rgb.(0)
	flw	f2, 0(x4)	# rgb.(0)
	fadd	f2, f2, f1	# rgb.(0) +. ihl
	fsw	f2, 0(x4)	# rgb.(0) <- rgb.(0) +. ihl
	flw	f2, 1(x4)	# rgb.(1)
	fadd	f2, f2, f1	# rgb.(1) +. ihl
	fsw	f2, 1(x4)	# rgb.(1) <- rgb.(1) +. ihl
	flw	f2, 2(x4)	# rgb.(2)
	fadd	f1, f2, f1	# rgb.(2) +. ihl
	fsw	f1, 2(x4)	# rgb.(2) <- rgb.(2) +. ihl
	jalr x0, x1, 0	# rgb.(2) <- rgb.(2) +. ihl
# bne:	let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else ()
	lw	x4, 18(x2)	# intersected_object_id.(0)
	# let obj_id = intersected_object_id.(0)
	lw	x4, 0(x4)	# intersected_object_id.(0)
	lw	x5, 17(x2)	# objects.(obj_id)
	# let obj = objects.(obj_id)
	lwa	x5, (x5, x4)	# objects.(obj_id)
	sw	x4, 27(x2)	# o_reflectiontype obj
	sw	x5, 28(x2)	# o_reflectiontype obj
	# let m_surface = o_reflectiontype obj
	addi	x4, x5, 0	# o_reflectiontype obj
	sw	x1, 29(x2)	# o_reflectiontype obj
	addi	x2, x2, 30	# o_reflectiontype obj
	auipc	x31, -1	# o_reflectiontype obj
	jalr	x0, x31, -4606	# o_reflectiontype obj
	subi	x2, x2, 30	# o_reflectiontype obj
	lw	x1, 29(x2)	# o_reflectiontype obj
	addi	x4, x4, 0	# o_reflectiontype obj
	lw	x5, 28(x2)	# o_diffuse obj
	sw	x4, 29(x2)	# o_diffuse obj
	addi	x4, x5, 0	# o_diffuse obj
	sw	x1, 30(x2)	# o_diffuse obj
	addi	x2, x2, 31	# o_diffuse obj
	auipc	x31, -1	# o_diffuse obj
	jalr	x0, x31, -4590	# o_diffuse obj
	subi	x2, x2, 31	# o_diffuse obj
	lw	x1, 30(x2)	# o_diffuse obj
	fmr	f1, f1	# o_diffuse obj
	flw	f2, 21(x2)	# o_diffuse obj *. energy
	# let diffuse = o_diffuse obj *. energy
	fmul	f1, f1, f2	# o_diffuse obj *. energy
	lw	x4, 28(x2)	# get_nvector obj dirvec
	lw	x5, 24(x2)	# get_nvector obj dirvec
	lw	x29, 16(x2)	# get_nvector obj dirvec
	fsw	f1, 30(x2)	# get_nvector obj dirvec
	sw	x1, 31(x2)	# get_nvector obj dirvec
	addi	x2, x2, 32	# get_nvector obj dirvec
	lw	x31, 0(x29)	# get_nvector obj dirvec
	jalr	x1, x31, 0	# get_nvector obj dirvec
	subi	x2, x2, 32	# get_nvector obj dirvec
	lw	x1, 31(x2)	# get_nvector obj dirvec
	addi	x0, x4, 0	# get_nvector obj dirvec
	lw	x4, 15(x2)	# veccpy startp intersection_point
	lw	x5, 14(x2)	# veccpy startp intersection_point
	sw	x1, 31(x2)	# veccpy startp intersection_point
	addi	x2, x2, 32	# veccpy startp intersection_point
	auipc	x31, -1	# veccpy startp intersection_point
	jalr	x0, x31, -4763	# veccpy startp intersection_point
	subi	x2, x2, 32	# veccpy startp intersection_point
	lw	x1, 31(x2)	# veccpy startp intersection_point
	addi	x0, x4, 0	# veccpy startp intersection_point
	lw	x4, 28(x2)	# utexture obj intersection_point
	lw	x5, 14(x2)	# utexture obj intersection_point
	lw	x29, 13(x2)	# utexture obj intersection_point
	sw	x1, 31(x2)	# utexture obj intersection_point
	addi	x2, x2, 32	# utexture obj intersection_point
	lw	x31, 0(x29)	# utexture obj intersection_point
	jalr	x1, x31, 0	# utexture obj intersection_point
	subi	x2, x2, 32	# utexture obj intersection_point
	lw	x1, 31(x2)	# utexture obj intersection_point
	addi	x0, x4, 0	# utexture obj intersection_point
	lw	x4, 27(x2)	# obj_id * 4
	slli	x4, x4, 2	# obj_id * 4
	lw	x5, 12(x2)	# intsec_rectside.(0)
	lw	x5, 0(x5)	# intsec_rectside.(0)
	add	x4, x4, x5	# obj_id * 4 + intsec_rectside.(0)
	lw	x5, 23(x2)	# surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0)
	lw	x6, 26(x2)	# surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0)
	swa	x4, (x6, x5)	# surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0)
	lw	x4, 11(x2)	# p_intersection_points pixel
	# let intersection_points = p_intersection_points pixel
	sw	x1, 31(x2)	# p_intersection_points pixel
	addi	x2, x2, 32	# p_intersection_points pixel
	auipc	x31, -1	# p_intersection_points pixel
	jalr	x0, x31, -4611	# p_intersection_points pixel
	subi	x2, x2, 32	# p_intersection_points pixel
	lw	x1, 31(x2)	# p_intersection_points pixel
	addi	x4, x4, 0	# p_intersection_points pixel
	lw	x5, 23(x2)	# intersection_points.(nref)
	lwa	x4, (x4, x5)	# intersection_points.(nref)
	lw	x6, 14(x2)	# veccpy intersection_points.(nref) intersection_point
	addi	x5, x6, 0	# veccpy intersection_points.(nref) intersection_point
	sw	x1, 31(x2)	# veccpy intersection_points.(nref) intersection_point
	addi	x2, x2, 32	# veccpy intersection_points.(nref) intersection_point
	auipc	x31, -1	# veccpy intersection_points.(nref) intersection_point
	jalr	x0, x31, -4799	# veccpy intersection_points.(nref) intersection_point
	subi	x2, x2, 32	# veccpy intersection_points.(nref) intersection_point
	lw	x1, 31(x2)	# veccpy intersection_points.(nref) intersection_point
	addi	x0, x4, 0	# veccpy intersection_points.(nref) intersection_point
	lw	x4, 11(x2)	# p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 31(x2)	# p_calc_diffuse pixel
	addi	x2, x2, 32	# p_calc_diffuse pixel
	auipc	x31, -1	# p_calc_diffuse pixel
	jalr	x0, x31, -4626	# p_calc_diffuse pixel
	subi	x2, x2, 32	# p_calc_diffuse pixel
	lw	x1, 31(x2)	# p_calc_diffuse pixel
	addi	x4, x4, 0	# p_calc_diffuse pixel
	lw	x5, 28(x2)	# o_diffuse obj
	sw	x4, 31(x2)	# o_diffuse obj
	addi	x4, x5, 0	# o_diffuse obj
	sw	x1, 32(x2)	# o_diffuse obj
	addi	x2, x2, 33	# o_diffuse obj
	auipc	x31, -1	# o_diffuse obj
	jalr	x0, x31, -4667	# o_diffuse obj
	subi	x2, x2, 33	# o_diffuse obj
	lw	x1, 32(x2)	# o_diffuse obj
	fmr	f1, f1	# o_diffuse obj
	flt	x4, f27, f27	# fless (o_diffuse obj) 0.5
	bne	x4, x0, 63	# if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; )
# beq:	calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector;
	addi	x4, x0, 1	# true
	lw	x5, 23(x2)	# calc_diffuse.(nref) <- true
	lw	x6, 31(x2)	# calc_diffuse.(nref) <- true
	swa	x4, (x6, x5)	# calc_diffuse.(nref) <- true
	lw	x4, 11(x2)	# p_energy pixel
	# let energya = p_energy pixel
	sw	x1, 32(x2)	# p_energy pixel
	addi	x2, x2, 33	# p_energy pixel
	auipc	x31, -1	# p_energy pixel
	jalr	x0, x31, -4648	# p_energy pixel
	subi	x2, x2, 33	# p_energy pixel
	lw	x1, 32(x2)	# p_energy pixel
	addi	x4, x4, 0	# p_energy pixel
	lw	x5, 23(x2)	# energya.(nref)
	lwa	x6, (x4, x5)	# energya.(nref)
	lw	x7, 10(x2)	# veccpy energya.(nref) texture_color
	sw	x4, 32(x2)	# veccpy energya.(nref) texture_color
	addi	x5, x7, 0	# veccpy energya.(nref) texture_color
	addi	x4, x6, 0	# veccpy energya.(nref) texture_color
	sw	x1, 33(x2)	# veccpy energya.(nref) texture_color
	addi	x2, x2, 34	# veccpy energya.(nref) texture_color
	auipc	x31, -1	# veccpy energya.(nref) texture_color
	jalr	x0, x31, -4843	# veccpy energya.(nref) texture_color
	subi	x2, x2, 34	# veccpy energya.(nref) texture_color
	lw	x1, 33(x2)	# veccpy energya.(nref) texture_color
	addi	x0, x4, 0	# veccpy energya.(nref) texture_color
	lw	x4, 23(x2)	# energya.(nref)
	lw	x5, 32(x2)	# energya.(nref)
	lwa	x5, (x5, x4)	# energya.(nref)
	lui	x31, 243712	# 1.0 /. 256.0
	addi	x31, x31, 998244352	# 1.0 /. 256.0
	mvitof	f1, x31	# 1.0 /. 256.0
	flw	f2, 30(x2)	# (1.0 /. 256.0) *. diffuse
	fmul	f1, f1, f2	# (1.0 /. 256.0) *. diffuse
	addi	x4, x5, 0	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	sw	x1, 33(x2)	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	addi	x2, x2, 34	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	auipc	x31, -1	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	jalr	x0, x31, -4769	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	subi	x2, x2, 34	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	lw	x1, 33(x2)	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	addi	x0, x4, 0	# vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse)
	lw	x4, 11(x2)	# p_nvectors pixel
	# let nvectors = p_nvectors pixel
	sw	x1, 33(x2)	# p_nvectors pixel
	addi	x2, x2, 34	# p_nvectors pixel
	auipc	x31, -1	# p_nvectors pixel
	jalr	x0, x31, -4675	# p_nvectors pixel
	subi	x2, x2, 34	# p_nvectors pixel
	lw	x1, 33(x2)	# p_nvectors pixel
	addi	x4, x4, 0	# p_nvectors pixel
	lw	x5, 23(x2)	# nvectors.(nref)
	lwa	x4, (x4, x5)	# nvectors.(nref)
	lw	x6, 9(x2)	# veccpy nvectors.(nref) nvector
	addi	x5, x6, 0	# veccpy nvectors.(nref) nvector
	sw	x1, 33(x2)	# veccpy nvectors.(nref) nvector
	addi	x2, x2, 34	# veccpy nvectors.(nref) nvector
	auipc	x31, -1	# veccpy nvectors.(nref) nvector
	jalr	x0, x31, -4879	# veccpy nvectors.(nref) nvector
	subi	x2, x2, 34	# veccpy nvectors.(nref) nvector
	lw	x1, 33(x2)	# veccpy nvectors.(nref) nvector
	addi	x0, x4, 0	# veccpy nvectors.(nref) nvector
	jalr x0, x1, 0
	jal	x0, 6	# if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; )
# bne:	calc_diffuse.(nref) <- false
	addi	x4, x0, 0	# false
	lw	x5, 23(x2)	# calc_diffuse.(nref) <- false
	lw	x6, 31(x2)	# calc_diffuse.(nref) <- false
	swa	x4, (x6, x5)	# calc_diffuse.(nref) <- false
	jalr x0, x1, 0	# calc_diffuse.(nref) <- false
# cont:	if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; )
	lui	x31, -262144	# -2.0
	addi	x31, x31, -1073741824	# -2.0
	mvitof	f1, x31	# -2.0
	lw	x4, 24(x2)	# veciprod dirvec nvector
	lw	x5, 9(x2)	# veciprod dirvec nvector
	fsw	f1, 33(x2)	# veciprod dirvec nvector
	sw	x1, 34(x2)	# veciprod dirvec nvector
	addi	x2, x2, 35	# veciprod dirvec nvector
	auipc	x31, -1	# veciprod dirvec nvector
	jalr	x0, x31, -4859	# veciprod dirvec nvector
	subi	x2, x2, 35	# veciprod dirvec nvector
	lw	x1, 34(x2)	# veciprod dirvec nvector
	fmr	f1, f1	# veciprod dirvec nvector
	flw	f2, 33(x2)	# (-2.0) *. veciprod dirvec nvector
	# let w = (-2.0) *. veciprod dirvec nvector
	fmul	f1, f2, f1	# (-2.0) *. veciprod dirvec nvector
	lw	x4, 24(x2)	# vecaccum dirvec w nvector
	lw	x5, 9(x2)	# vecaccum dirvec w nvector
	sw	x1, 34(x2)	# vecaccum dirvec w nvector
	addi	x2, x2, 35	# vecaccum dirvec w nvector
	auipc	x31, -1	# vecaccum dirvec w nvector
	jalr	x0, x31, -4849	# vecaccum dirvec w nvector
	subi	x2, x2, 35	# vecaccum dirvec w nvector
	lw	x1, 34(x2)	# vecaccum dirvec w nvector
	addi	x0, x4, 0	# vecaccum dirvec w nvector
	lw	x4, 28(x2)	# o_hilight obj
	sw	x1, 34(x2)	# o_hilight obj
	addi	x2, x2, 35	# o_hilight obj
	auipc	x31, -1	# o_hilight obj
	jalr	x0, x31, -4766	# o_hilight obj
	subi	x2, x2, 35	# o_hilight obj
	lw	x1, 34(x2)	# o_hilight obj
	fmr	f1, f1	# o_hilight obj
	flw	f2, 21(x2)	# energy *. o_hilight obj
	# let hilight_scale = energy *. o_hilight obj
	fmul	f1, f2, f1	# energy *. o_hilight obj
	addi	x4, x0, 0	# 0
	lw	x5, 8(x2)	# or_net.(0)
	lw	x5, 0(x5)	# or_net.(0)
	lw	x29, 7(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	fsw	f1, 34(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	sw	x1, 35(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, 36	# shadow_check_one_or_matrix 0 or_net.(0)
	lw	x31, 0(x29)	# shadow_check_one_or_matrix 0 or_net.(0)
	jalr	x1, x31, 0	# shadow_check_one_or_matrix 0 or_net.(0)
	subi	x2, x2, 36	# shadow_check_one_or_matrix 0 or_net.(0)
	lw	x1, 35(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	addi	x4, x4, 0	# shadow_check_one_or_matrix 0 or_net.(0)
	bne	x4, x0, 30	# if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else ()
# beq:	let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale
	lw	x4, 9(x2)	# veciprod nvector light
	lw	x5, 22(x2)	# veciprod nvector light
	sw	x1, 35(x2)	# veciprod nvector light
	addi	x2, x2, 36	# veciprod nvector light
	auipc	x31, -1	# veciprod nvector light
	jalr	x0, x31, -4902	# veciprod nvector light
	subi	x2, x2, 36	# veciprod nvector light
	lw	x1, 35(x2)	# veciprod nvector light
	fmr	f1, f1	# veciprod nvector light
	fneg	f1, f1	# fneg (veciprod nvector light)
	flw	f2, 30(x2)	# fneg (veciprod nvector light) *. diffuse
	# let bright = fneg (veciprod nvector light) *. diffuse
	fmul	f1, f1, f2	# fneg (veciprod nvector light) *. diffuse
	lw	x4, 24(x2)	# veciprod dirvec light
	lw	x5, 22(x2)	# veciprod dirvec light
	fsw	f1, 35(x2)	# veciprod dirvec light
	sw	x1, 36(x2)	# veciprod dirvec light
	addi	x2, x2, 37	# veciprod dirvec light
	auipc	x31, -1	# veciprod dirvec light
	jalr	x0, x31, -4915	# veciprod dirvec light
	subi	x2, x2, 37	# veciprod dirvec light
	lw	x1, 36(x2)	# veciprod dirvec light
	fmr	f1, f1	# veciprod dirvec light
	# let hilight = fneg (veciprod dirvec light)
	fneg	f2, f1	# fneg (veciprod dirvec light)
	flw	f1, 35(x2)	# add_light bright hilight hilight_scale
	flw	f3, 34(x2)	# add_light bright hilight hilight_scale
	lw	x29, 6(x2)	# add_light bright hilight hilight_scale
	lw	x31, 0(x29)	# add_light bright hilight hilight_scale
	jalr	x0, x31, 0	# add_light bright hilight hilight_scale
	jal	x0, 2	# if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else ()
# bne:	()
	jalr x0, x1, 0	# ()
# cont:	if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else ()
	lw	x4, 14(x2)	# setup_startp intersection_point
	lw	x29, 5(x2)	# setup_startp intersection_point
	sw	x1, 36(x2)	# setup_startp intersection_point
	addi	x2, x2, 37	# setup_startp intersection_point
	lw	x31, 0(x29)	# setup_startp intersection_point
	jalr	x1, x31, 0	# setup_startp intersection_point
	subi	x2, x2, 37	# setup_startp intersection_point
	lw	x1, 36(x2)	# setup_startp intersection_point
	addi	x0, x4, 0	# setup_startp intersection_point
	lw	x4, 4(x2)	# n_reflections.(0)
	lw	x4, 0(x4)	# n_reflections.(0)
	addi	x4, x4, -1	# n_reflections.(0)-1
	flw	f1, 30(x2)	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	flw	f2, 34(x2)	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	lw	x5, 24(x2)	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	lw	x29, 3(x2)	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	sw	x1, 36(x2)	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	addi	x2, x2, 37	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	lw	x31, 0(x29)	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	jalr	x1, x31, 0	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	subi	x2, x2, 37	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	lw	x1, 36(x2)	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	addi	x0, x4, 0	# trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec
	flw	f1, 21(x2)	# fless 0.1 energy
	flt	x4, f1, f1	# fless 0.1 energy
	bne	x4, x0, 2	# if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ();
	addi	x4, x0, 4	# 4
	lw	x5, 23(x2)	# if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
	bge	x5, x4, 7	# if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
# blt:	surface_ids.(nref+1) <- -1
	addi	x4, x5, 1	# nref+1
	addi	x6, x0, -1	# -1
	lw	x7, 26(x2)	# surface_ids.(nref+1) <- -1
	swa	x6, (x7, x4)	# surface_ids.(nref+1) <- -1
	jalr x0, x1, 0	# surface_ids.(nref+1) <- -1
	jal	x0, 2	# if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
# bge:	()
	jalr x0, x1, 0	# ()
# cont:	if(nref < 4) then surface_ids.(nref+1) <- -1 else ()
	addi	x4, x0, 2	# 2
	lw	x6, 29(x2)	# if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
	bne	x6, x4, 24	# if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
# beq:	let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	lw	x4, 28(x2)	# o_diffuse obj
	sw	x1, 36(x2)	# o_diffuse obj
	addi	x2, x2, 37	# o_diffuse obj
	auipc	x31, -1	# o_diffuse obj
	jalr	x0, x31, -4862	# o_diffuse obj
	subi	x2, x2, 37	# o_diffuse obj
	lw	x1, 36(x2)	# o_diffuse obj
	fmr	f1, f1	# o_diffuse obj
	fsub	f1, f11, f1	# 1.0 -. o_diffuse obj
	flw	f2, 21(x2)	# energy *. (1.0 -. o_diffuse obj)
	# let energy2 = energy *. (1.0 -. o_diffuse obj)
	fmul	f1, f2, f1	# energy *. (1.0 -. o_diffuse obj)
	lw	x4, 23(x2)	# nref+1
	addi	x4, x4, 1	# nref+1
	lw	x5, 2(x2)	# tmin.(0)
	flw	f2, 0(x5)	# tmin.(0)
	flw	f3, 1(x2)	# dist +. tmin.(0)
	fadd	f2, f3, f2	# dist +. tmin.(0)
	lw	x5, 24(x2)	# trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	lw	x6, 11(x2)	# trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	lw	x29, 0(x2)	# trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	lw	x31, 0(x29)	# trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	jalr	x0, x31, 0	# trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0))
	jal	x0, 2	# if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
# bne:	()
	jalr x0, x1, 0	# ()
# cont:	if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else ()
	jalr x0, x1, 0
# trace_diffuse_ray.2871:	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x5, 15(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x6, 14(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x7, 13(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x8, 12(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x9, 11(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x10, 10(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x11, 9(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x12, 8(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x13, 7(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x14, 6(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x15, 5(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x16, 4(x29)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x6, 0(x2)	# judge_intersection_fast dirvec
	sw	x16, 1(x2)	# judge_intersection_fast dirvec
	fsw	f1, 2(x2)	# judge_intersection_fast dirvec
	sw	x11, 3(x2)	# judge_intersection_fast dirvec
	sw	x10, 4(x2)	# judge_intersection_fast dirvec
	sw	x7, 5(x2)	# judge_intersection_fast dirvec
	sw	x8, 6(x2)	# judge_intersection_fast dirvec
	sw	x13, 7(x2)	# judge_intersection_fast dirvec
	sw	x5, 8(x2)	# judge_intersection_fast dirvec
	sw	x15, 9(x2)	# judge_intersection_fast dirvec
	sw	x4, 10(x2)	# judge_intersection_fast dirvec
	sw	x9, 11(x2)	# judge_intersection_fast dirvec
	sw	x14, 12(x2)	# judge_intersection_fast dirvec
	addi	x29, x12, 0	# judge_intersection_fast dirvec
	sw	x1, 13(x2)	# judge_intersection_fast dirvec
	addi	x2, x2, 14	# judge_intersection_fast dirvec
	lw	x31, 0(x29)	# judge_intersection_fast dirvec
	jalr	x1, x31, 0	# judge_intersection_fast dirvec
	subi	x2, x2, 14	# judge_intersection_fast dirvec
	lw	x1, 13(x2)	# judge_intersection_fast dirvec
	addi	x4, x4, 0	# judge_intersection_fast dirvec
	bne	x4, x0, 2	# if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else ()
	lw	x4, 12(x2)	# intersected_object_id.(0)
	lw	x4, 0(x4)	# intersected_object_id.(0)
	lw	x5, 11(x2)	# objects.(intersected_object_id.(0))
	# let obj = objects.(intersected_object_id.(0))
	lwa	x4, (x5, x4)	# objects.(intersected_object_id.(0))
	lw	x5, 10(x2)	# d_vec dirvec
	sw	x4, 13(x2)	# d_vec dirvec
	addi	x4, x5, 0	# d_vec dirvec
	sw	x1, 14(x2)	# d_vec dirvec
	addi	x2, x2, 15	# d_vec dirvec
	auipc	x31, -1	# d_vec dirvec
	jalr	x0, x31, -4881	# d_vec dirvec
	subi	x2, x2, 15	# d_vec dirvec
	lw	x1, 14(x2)	# d_vec dirvec
	addi	x5, x4, 0	# d_vec dirvec
	lw	x4, 13(x2)	# get_nvector obj (d_vec dirvec)
	lw	x29, 9(x2)	# get_nvector obj (d_vec dirvec)
	sw	x1, 14(x2)	# get_nvector obj (d_vec dirvec)
	addi	x2, x2, 15	# get_nvector obj (d_vec dirvec)
	lw	x31, 0(x29)	# get_nvector obj (d_vec dirvec)
	jalr	x1, x31, 0	# get_nvector obj (d_vec dirvec)
	subi	x2, x2, 15	# get_nvector obj (d_vec dirvec)
	lw	x1, 14(x2)	# get_nvector obj (d_vec dirvec)
	addi	x0, x4, 0	# get_nvector obj (d_vec dirvec)
	lw	x4, 13(x2)	# utexture obj intersection_point
	lw	x5, 7(x2)	# utexture obj intersection_point
	lw	x29, 8(x2)	# utexture obj intersection_point
	sw	x1, 14(x2)	# utexture obj intersection_point
	addi	x2, x2, 15	# utexture obj intersection_point
	lw	x31, 0(x29)	# utexture obj intersection_point
	jalr	x1, x31, 0	# utexture obj intersection_point
	subi	x2, x2, 15	# utexture obj intersection_point
	lw	x1, 14(x2)	# utexture obj intersection_point
	addi	x0, x4, 0	# utexture obj intersection_point
	addi	x4, x0, 0	# 0
	lw	x5, 6(x2)	# or_net.(0)
	lw	x5, 0(x5)	# or_net.(0)
	lw	x29, 5(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	sw	x1, 14(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	addi	x2, x2, 15	# shadow_check_one_or_matrix 0 or_net.(0)
	lw	x31, 0(x29)	# shadow_check_one_or_matrix 0 or_net.(0)
	jalr	x1, x31, 0	# shadow_check_one_or_matrix 0 or_net.(0)
	subi	x2, x2, 15	# shadow_check_one_or_matrix 0 or_net.(0)
	lw	x1, 14(x2)	# shadow_check_one_or_matrix 0 or_net.(0)
	addi	x4, x4, 0	# shadow_check_one_or_matrix 0 or_net.(0)
	bne	x4, x0, 35	# if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else ()
# beq:	let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
	lw	x4, 4(x2)	# veciprod nvector light
	lw	x5, 3(x2)	# veciprod nvector light
	sw	x1, 14(x2)	# veciprod nvector light
	addi	x2, x2, 15	# veciprod nvector light
	auipc	x31, -1	# veciprod nvector light
	jalr	x0, x31, -5077	# veciprod nvector light
	subi	x2, x2, 15	# veciprod nvector light
	lw	x1, 14(x2)	# veciprod nvector light
	fmr	f1, f1	# veciprod nvector light
	# let br = fneg (veciprod nvector light)
	fneg	f1, f1	# fneg (veciprod nvector light)
	flt	x4, f1, f1	# fispos br
	# let bright = (if fispos br then br else 0.0)
	bne	x4, x0, 5	# if fispos br then br else 0.0
# beq:	0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	jalr	x0, x1, 0	# 0.0
	jal	x0, 2	# if fispos br then br else 0.0
# bne:	br
	jalr	x0, x1, 0	# br
# cont:	if fispos br then br else 0.0
	flw	f2, 2(x2)	# energy *. bright
	fmul	f1, f2, f1	# energy *. bright
	lw	x4, 13(x2)	# o_diffuse obj
	fsw	f1, 14(x2)	# o_diffuse obj
	sw	x1, 15(x2)	# o_diffuse obj
	addi	x2, x2, 16	# o_diffuse obj
	auipc	x31, -1	# o_diffuse obj
	jalr	x0, x31, -4987	# o_diffuse obj
	subi	x2, x2, 16	# o_diffuse obj
	lw	x1, 15(x2)	# o_diffuse obj
	fmr	f1, f1	# o_diffuse obj
	flw	f2, 14(x2)	# energy *. bright *. o_diffuse obj
	fmul	f1, f2, f1	# energy *. bright *. o_diffuse obj
	lw	x4, 1(x2)	# vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
	lw	x5, 0(x2)	# vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
	auipc	x31, -1	# vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
	jalr	x0, x31, -5081	# vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color
# bne:	()
	jalr x0, x1, 0	# ()
# iter_trace_diffuse_rays.2874:	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	lw	x8, 4(x29)	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	bge	x7, x0, 2	# if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	lwa	x9, (x4, x7)	# dirvec_group.(index)
	sw	x6, 0(x2)	# d_vec dirvec_group.(index)
	sw	x29, 1(x2)	# d_vec dirvec_group.(index)
	sw	x8, 2(x2)	# d_vec dirvec_group.(index)
	sw	x7, 3(x2)	# d_vec dirvec_group.(index)
	sw	x4, 4(x2)	# d_vec dirvec_group.(index)
	sw	x5, 5(x2)	# d_vec dirvec_group.(index)
	addi	x4, x9, 0	# d_vec dirvec_group.(index)
	sw	x1, 6(x2)	# d_vec dirvec_group.(index)
	addi	x2, x2, 7	# d_vec dirvec_group.(index)
	auipc	x31, -1	# d_vec dirvec_group.(index)
	jalr	x0, x31, -4965	# d_vec dirvec_group.(index)
	subi	x2, x2, 7	# d_vec dirvec_group.(index)
	lw	x1, 6(x2)	# d_vec dirvec_group.(index)
	addi	x4, x4, 0	# d_vec dirvec_group.(index)
	lw	x5, 5(x2)	# veciprod (d_vec dirvec_group.(index)) nvector
	# let p = veciprod (d_vec dirvec_group.(index)) nvector
	sw	x1, 6(x2)	# veciprod (d_vec dirvec_group.(index)) nvector
	addi	x2, x2, 7	# veciprod (d_vec dirvec_group.(index)) nvector
	auipc	x31, -1	# veciprod (d_vec dirvec_group.(index)) nvector
	jalr	x0, x31, -5129	# veciprod (d_vec dirvec_group.(index)) nvector
	subi	x2, x2, 7	# veciprod (d_vec dirvec_group.(index)) nvector
	lw	x1, 6(x2)	# veciprod (d_vec dirvec_group.(index)) nvector
	fmr	f1, f1	# veciprod (d_vec dirvec_group.(index)) nvector
	flt	x4, f0, f0	# fisneg p
	bne	x4, x0, 13	# if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
# beq:	trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	lw	x4, 3(x2)	# dirvec_group.(index)
	lw	x5, 4(x2)	# dirvec_group.(index)
	lwa	x6, (x5, x4)	# dirvec_group.(index)
	lui	x31, 245159	# p /. 150.0
	addi	x31, x31, 1004172302	# p /. 150.0
	mvitof	f2, x31	# p /. 150.0
	fmul	f1, f1, f2	# p /. 150.0
	lw	x29, 2(x2)	# trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	addi	x4, x6, 0	# trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	lw	x31, 0(x29)	# trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	jalr	x0, x31, 0	# trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	jal	x0, 13	# if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
# bne:	trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	lw	x4, 3(x2)	# index + 1
	addi	x5, x4, 1	# index + 1
	lw	x6, 4(x2)	# dirvec_group.(index + 1)
	lwa	x5, (x6, x5)	# dirvec_group.(index + 1)
	lui	x31, -279129	# p /. -150.0
	addi	x31, x31, -1143311346	# p /. -150.0
	mvitof	f2, x31	# p /. -150.0
	fmul	f1, f1, f2	# p /. -150.0
	lw	x29, 2(x2)	# trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	addi	x4, x5, 0	# trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	lw	x31, 0(x29)	# trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
	jalr	x0, x31, 0	# trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0)
# cont:	if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0)
	lw	x4, 3(x2)	# index - 2
	addi	x7, x4, -2	# index - 2
	lw	x4, 4(x2)	# iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	lw	x5, 5(x2)	# iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	lw	x6, 0(x2)	# iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	lw	x29, 1(x2)	# iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	lw	x31, 0(x29)	# iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
	jalr	x0, x31, 0	# iter_trace_diffuse_rays dirvec_group nvector org (index - 2)
# trace_diffuse_rays.2879:	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	lw	x7, 5(x29)	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	lw	x8, 4(x29)	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	sw	x6, 0(x2)	# setup_startp org
	sw	x5, 1(x2)	# setup_startp org
	sw	x4, 2(x2)	# setup_startp org
	sw	x8, 3(x2)	# setup_startp org
	addi	x4, x6, 0	# setup_startp org
	addi	x29, x7, 0	# setup_startp org
	sw	x1, 4(x2)	# setup_startp org
	addi	x2, x2, 5	# setup_startp org
	lw	x31, 0(x29)	# setup_startp org
	jalr	x1, x31, 0	# setup_startp org
	subi	x2, x2, 5	# setup_startp org
	lw	x1, 4(x2)	# setup_startp org
	addi	x0, x4, 0	# setup_startp org
	addi	x7, x0, 118	# 118
	lw	x4, 2(x2)	# iter_trace_diffuse_rays dirvec_group nvector org 118
	lw	x5, 1(x2)	# iter_trace_diffuse_rays dirvec_group nvector org 118
	lw	x6, 0(x2)	# iter_trace_diffuse_rays dirvec_group nvector org 118
	lw	x29, 3(x2)	# iter_trace_diffuse_rays dirvec_group nvector org 118
	lw	x31, 0(x29)	# iter_trace_diffuse_rays dirvec_group nvector org 118
	jalr	x0, x31, 0	# iter_trace_diffuse_rays dirvec_group nvector org 118
# trace_diffuse_ray_80percent.2883:	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	lw	x7, 5(x29)	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	lw	x8, 4(x29)	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	sw	x6, 0(x2)	# if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	sw	x5, 1(x2)	# if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	sw	x7, 2(x2)	# if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	sw	x8, 3(x2)	# if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	sw	x4, 4(x2)	# if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	bne	x4, x0, 3	# if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 6	# if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(0) nvector org
	lw	x9, 0(x8)	# dirvecs.(0)
	addi	x4, x9, 0	# trace_diffuse_rays dirvecs.(0) nvector org
	addi	x29, x7, 0	# trace_diffuse_rays dirvecs.(0) nvector org
	lw	x31, 0(x29)	# trace_diffuse_rays dirvecs.(0) nvector org
	jalr	x0, x31, 0	# trace_diffuse_rays dirvecs.(0) nvector org
# cont:	if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else ()
	addi	x4, x0, 1	# 1
	lw	x5, 4(x2)	# if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
	bne	x5, x4, 3	# if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 11	# if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(1) nvector org
	lw	x4, 3(x2)	# dirvecs.(1)
	lw	x6, 1(x4)	# dirvecs.(1)
	lw	x7, 1(x2)	# trace_diffuse_rays dirvecs.(1) nvector org
	lw	x8, 0(x2)	# trace_diffuse_rays dirvecs.(1) nvector org
	lw	x29, 2(x2)	# trace_diffuse_rays dirvecs.(1) nvector org
	addi	x5, x7, 0	# trace_diffuse_rays dirvecs.(1) nvector org
	addi	x4, x6, 0	# trace_diffuse_rays dirvecs.(1) nvector org
	addi	x6, x8, 0	# trace_diffuse_rays dirvecs.(1) nvector org
	lw	x31, 0(x29)	# trace_diffuse_rays dirvecs.(1) nvector org
	jalr	x0, x31, 0	# trace_diffuse_rays dirvecs.(1) nvector org
# cont:	if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else ()
	addi	x4, x0, 2	# 2
	lw	x5, 4(x2)	# if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
	bne	x5, x4, 3	# if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 11	# if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(2) nvector org
	lw	x4, 3(x2)	# dirvecs.(2)
	lw	x6, 2(x4)	# dirvecs.(2)
	lw	x7, 1(x2)	# trace_diffuse_rays dirvecs.(2) nvector org
	lw	x8, 0(x2)	# trace_diffuse_rays dirvecs.(2) nvector org
	lw	x29, 2(x2)	# trace_diffuse_rays dirvecs.(2) nvector org
	addi	x5, x7, 0	# trace_diffuse_rays dirvecs.(2) nvector org
	addi	x4, x6, 0	# trace_diffuse_rays dirvecs.(2) nvector org
	addi	x6, x8, 0	# trace_diffuse_rays dirvecs.(2) nvector org
	lw	x31, 0(x29)	# trace_diffuse_rays dirvecs.(2) nvector org
	jalr	x0, x31, 0	# trace_diffuse_rays dirvecs.(2) nvector org
# cont:	if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else ()
	addi	x4, x0, 3	# 3
	lw	x5, 4(x2)	# if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
	bne	x5, x4, 3	# if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 11	# if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
# bne:	trace_diffuse_rays dirvecs.(3) nvector org
	lw	x4, 3(x2)	# dirvecs.(3)
	lw	x6, 3(x4)	# dirvecs.(3)
	lw	x7, 1(x2)	# trace_diffuse_rays dirvecs.(3) nvector org
	lw	x8, 0(x2)	# trace_diffuse_rays dirvecs.(3) nvector org
	lw	x29, 2(x2)	# trace_diffuse_rays dirvecs.(3) nvector org
	addi	x5, x7, 0	# trace_diffuse_rays dirvecs.(3) nvector org
	addi	x4, x6, 0	# trace_diffuse_rays dirvecs.(3) nvector org
	addi	x6, x8, 0	# trace_diffuse_rays dirvecs.(3) nvector org
	lw	x31, 0(x29)	# trace_diffuse_rays dirvecs.(3) nvector org
	jalr	x0, x31, 0	# trace_diffuse_rays dirvecs.(3) nvector org
# cont:	if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else ()
	addi	x4, x0, 4	# 4
	lw	x5, 4(x2)	# if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	bne	x5, x4, 2	# if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	trace_diffuse_rays dirvecs.(4) nvector org
	lw	x4, 3(x2)	# dirvecs.(4)
	lw	x4, 4(x4)	# dirvecs.(4)
	lw	x5, 1(x2)	# trace_diffuse_rays dirvecs.(4) nvector org
	lw	x6, 0(x2)	# trace_diffuse_rays dirvecs.(4) nvector org
	lw	x29, 2(x2)	# trace_diffuse_rays dirvecs.(4) nvector org
	lw	x31, 0(x29)	# trace_diffuse_rays dirvecs.(4) nvector org
	jalr	x0, x31, 0	# trace_diffuse_rays dirvecs.(4) nvector org
# calc_diffuse_using_1point.2887:	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	lw	x6, 6(x29)	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	lw	x7, 5(x29)	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	lw	x8, 4(x29)	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	sw	x7, 0(x2)	# p_received_ray_20percent pixel
	sw	x6, 1(x2)	# p_received_ray_20percent pixel
	sw	x8, 2(x2)	# p_received_ray_20percent pixel
	sw	x5, 3(x2)	# p_received_ray_20percent pixel
	sw	x4, 4(x2)	# p_received_ray_20percent pixel
	# let ray20p = p_received_ray_20percent pixel
	sw	x1, 5(x2)	# p_received_ray_20percent pixel
	addi	x2, x2, 6	# p_received_ray_20percent pixel
	auipc	x31, -1	# p_received_ray_20percent pixel
	jalr	x0, x31, -5126	# p_received_ray_20percent pixel
	subi	x2, x2, 6	# p_received_ray_20percent pixel
	lw	x1, 5(x2)	# p_received_ray_20percent pixel
	addi	x4, x4, 0	# p_received_ray_20percent pixel
	lw	x5, 4(x2)	# p_nvectors pixel
	sw	x4, 5(x2)	# p_nvectors pixel
	# let nvectors = p_nvectors pixel
	addi	x4, x5, 0	# p_nvectors pixel
	sw	x1, 6(x2)	# p_nvectors pixel
	addi	x2, x2, 7	# p_nvectors pixel
	auipc	x31, -1	# p_nvectors pixel
	jalr	x0, x31, -5127	# p_nvectors pixel
	subi	x2, x2, 7	# p_nvectors pixel
	lw	x1, 6(x2)	# p_nvectors pixel
	addi	x4, x4, 0	# p_nvectors pixel
	lw	x5, 4(x2)	# p_intersection_points pixel
	sw	x4, 6(x2)	# p_intersection_points pixel
	# let intersection_points = p_intersection_points pixel
	addi	x4, x5, 0	# p_intersection_points pixel
	sw	x1, 7(x2)	# p_intersection_points pixel
	addi	x2, x2, 8	# p_intersection_points pixel
	auipc	x31, -1	# p_intersection_points pixel
	jalr	x0, x31, -5153	# p_intersection_points pixel
	subi	x2, x2, 8	# p_intersection_points pixel
	lw	x1, 7(x2)	# p_intersection_points pixel
	addi	x4, x4, 0	# p_intersection_points pixel
	lw	x5, 4(x2)	# p_energy pixel
	sw	x4, 7(x2)	# p_energy pixel
	# let energya = p_energy pixel
	addi	x4, x5, 0	# p_energy pixel
	sw	x1, 8(x2)	# p_energy pixel
	addi	x2, x2, 9	# p_energy pixel
	auipc	x31, -1	# p_energy pixel
	jalr	x0, x31, -5157	# p_energy pixel
	subi	x2, x2, 9	# p_energy pixel
	lw	x1, 8(x2)	# p_energy pixel
	addi	x4, x4, 0	# p_energy pixel
	lw	x5, 3(x2)	# ray20p.(nref)
	lw	x6, 5(x2)	# ray20p.(nref)
	lwa	x6, (x6, x5)	# ray20p.(nref)
	lw	x7, 2(x2)	# veccpy diffuse_ray ray20p.(nref)
	sw	x4, 8(x2)	# veccpy diffuse_ray ray20p.(nref)
	addi	x5, x6, 0	# veccpy diffuse_ray ray20p.(nref)
	addi	x4, x7, 0	# veccpy diffuse_ray ray20p.(nref)
	sw	x1, 9(x2)	# veccpy diffuse_ray ray20p.(nref)
	addi	x2, x2, 10	# veccpy diffuse_ray ray20p.(nref)
	auipc	x31, -1	# veccpy diffuse_ray ray20p.(nref)
	jalr	x0, x31, -5354	# veccpy diffuse_ray ray20p.(nref)
	subi	x2, x2, 10	# veccpy diffuse_ray ray20p.(nref)
	lw	x1, 9(x2)	# veccpy diffuse_ray ray20p.(nref)
	addi	x0, x4, 0	# veccpy diffuse_ray ray20p.(nref)
	lw	x4, 4(x2)	# p_group_id pixel
	sw	x1, 9(x2)	# p_group_id pixel
	addi	x2, x2, 10	# p_group_id pixel
	auipc	x31, -1	# p_group_id pixel
	jalr	x0, x31, -5176	# p_group_id pixel
	subi	x2, x2, 10	# p_group_id pixel
	lw	x1, 9(x2)	# p_group_id pixel
	addi	x4, x4, 0	# p_group_id pixel
	lw	x5, 3(x2)	# nvectors.(nref)
	lw	x6, 6(x2)	# nvectors.(nref)
	lwa	x6, (x6, x5)	# nvectors.(nref)
	lw	x7, 7(x2)	# intersection_points.(nref)
	lwa	x7, (x7, x5)	# intersection_points.(nref)
	lw	x29, 1(x2)	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x5, x6, 0	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x6, x7, 0	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	sw	x1, 9(x2)	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x2, x2, 10	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	lw	x31, 0(x29)	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	jalr	x1, x31, 0	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	subi	x2, x2, 10	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	lw	x1, 9(x2)	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	addi	x0, x4, 0	# trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref)
	lw	x4, 3(x2)	# energya.(nref)
	lw	x5, 8(x2)	# energya.(nref)
	lwa	x5, (x5, x4)	# energya.(nref)
	lw	x4, 0(x2)	# vecaccumv rgb energya.(nref) diffuse_ray
	lw	x6, 2(x2)	# vecaccumv rgb energya.(nref) diffuse_ray
	auipc	x31, -1	# vecaccumv rgb energya.(nref) diffuse_ray
	jalr	x0, x31, -5285	# vecaccumv rgb energya.(nref) diffuse_ray
# calc_diffuse_using_5points.2890:	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	lw	x9, 5(x29)	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	lw	x10, 4(x29)	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	lwa	x5, (x5, x4)	# prev.(x)
	sw	x9, 0(x2)	# p_received_ray_20percent prev.(x)
	sw	x10, 1(x2)	# p_received_ray_20percent prev.(x)
	sw	x8, 2(x2)	# p_received_ray_20percent prev.(x)
	sw	x7, 3(x2)	# p_received_ray_20percent prev.(x)
	sw	x6, 4(x2)	# p_received_ray_20percent prev.(x)
	sw	x4, 5(x2)	# p_received_ray_20percent prev.(x)
	# let r_up = p_received_ray_20percent prev.(x)
	addi	x4, x5, 0	# p_received_ray_20percent prev.(x)
	sw	x1, 6(x2)	# p_received_ray_20percent prev.(x)
	addi	x2, x2, 7	# p_received_ray_20percent prev.(x)
	auipc	x31, -1	# p_received_ray_20percent prev.(x)
	jalr	x0, x31, -5216	# p_received_ray_20percent prev.(x)
	subi	x2, x2, 7	# p_received_ray_20percent prev.(x)
	lw	x1, 6(x2)	# p_received_ray_20percent prev.(x)
	addi	x4, x4, 0	# p_received_ray_20percent prev.(x)
	lw	x5, 5(x2)	# x-1
	addi	x6, x5, -1	# x-1
	lw	x7, 4(x2)	# cur.(x-1)
	lwa	x6, (x7, x6)	# cur.(x-1)
	sw	x4, 6(x2)	# p_received_ray_20percent cur.(x-1)
	# let r_left = p_received_ray_20percent cur.(x-1)
	addi	x4, x6, 0	# p_received_ray_20percent cur.(x-1)
	sw	x1, 7(x2)	# p_received_ray_20percent cur.(x-1)
	addi	x2, x2, 8	# p_received_ray_20percent cur.(x-1)
	auipc	x31, -1	# p_received_ray_20percent cur.(x-1)
	jalr	x0, x31, -5229	# p_received_ray_20percent cur.(x-1)
	subi	x2, x2, 8	# p_received_ray_20percent cur.(x-1)
	lw	x1, 7(x2)	# p_received_ray_20percent cur.(x-1)
	addi	x4, x4, 0	# p_received_ray_20percent cur.(x-1)
	lw	x5, 5(x2)	# cur.(x)
	lw	x6, 4(x2)	# cur.(x)
	lwa	x7, (x6, x5)	# cur.(x)
	sw	x4, 7(x2)	# p_received_ray_20percent cur.(x)
	# let r_center = p_received_ray_20percent cur.(x)
	addi	x4, x7, 0	# p_received_ray_20percent cur.(x)
	sw	x1, 8(x2)	# p_received_ray_20percent cur.(x)
	addi	x2, x2, 9	# p_received_ray_20percent cur.(x)
	auipc	x31, -1	# p_received_ray_20percent cur.(x)
	jalr	x0, x31, -5241	# p_received_ray_20percent cur.(x)
	subi	x2, x2, 9	# p_received_ray_20percent cur.(x)
	lw	x1, 8(x2)	# p_received_ray_20percent cur.(x)
	addi	x4, x4, 0	# p_received_ray_20percent cur.(x)
	lw	x5, 5(x2)	# x+1
	addi	x6, x5, 1	# x+1
	lw	x7, 4(x2)	# cur.(x+1)
	lwa	x6, (x7, x6)	# cur.(x+1)
	sw	x4, 8(x2)	# p_received_ray_20percent cur.(x+1)
	# let r_right = p_received_ray_20percent cur.(x+1)
	addi	x4, x6, 0	# p_received_ray_20percent cur.(x+1)
	sw	x1, 9(x2)	# p_received_ray_20percent cur.(x+1)
	addi	x2, x2, 10	# p_received_ray_20percent cur.(x+1)
	auipc	x31, -1	# p_received_ray_20percent cur.(x+1)
	jalr	x0, x31, -5254	# p_received_ray_20percent cur.(x+1)
	subi	x2, x2, 10	# p_received_ray_20percent cur.(x+1)
	lw	x1, 9(x2)	# p_received_ray_20percent cur.(x+1)
	addi	x4, x4, 0	# p_received_ray_20percent cur.(x+1)
	lw	x5, 5(x2)	# next.(x)
	lw	x6, 3(x2)	# next.(x)
	lwa	x6, (x6, x5)	# next.(x)
	sw	x4, 9(x2)	# p_received_ray_20percent next.(x)
	# let r_down = p_received_ray_20percent next.(x)
	addi	x4, x6, 0	# p_received_ray_20percent next.(x)
	sw	x1, 10(x2)	# p_received_ray_20percent next.(x)
	addi	x2, x2, 11	# p_received_ray_20percent next.(x)
	auipc	x31, -1	# p_received_ray_20percent next.(x)
	jalr	x0, x31, -5266	# p_received_ray_20percent next.(x)
	subi	x2, x2, 11	# p_received_ray_20percent next.(x)
	lw	x1, 10(x2)	# p_received_ray_20percent next.(x)
	addi	x4, x4, 0	# p_received_ray_20percent next.(x)
	lw	x5, 2(x2)	# r_up.(nref)
	lw	x6, 6(x2)	# r_up.(nref)
	lwa	x6, (x6, x5)	# r_up.(nref)
	lw	x7, 1(x2)	# veccpy diffuse_ray r_up.(nref)
	sw	x4, 10(x2)	# veccpy diffuse_ray r_up.(nref)
	addi	x5, x6, 0	# veccpy diffuse_ray r_up.(nref)
	addi	x4, x7, 0	# veccpy diffuse_ray r_up.(nref)
	sw	x1, 11(x2)	# veccpy diffuse_ray r_up.(nref)
	addi	x2, x2, 12	# veccpy diffuse_ray r_up.(nref)
	auipc	x31, -1	# veccpy diffuse_ray r_up.(nref)
	jalr	x0, x31, -5465	# veccpy diffuse_ray r_up.(nref)
	subi	x2, x2, 12	# veccpy diffuse_ray r_up.(nref)
	lw	x1, 11(x2)	# veccpy diffuse_ray r_up.(nref)
	addi	x0, x4, 0	# veccpy diffuse_ray r_up.(nref)
	lw	x4, 2(x2)	# r_left.(nref)
	lw	x5, 7(x2)	# r_left.(nref)
	lwa	x5, (x5, x4)	# r_left.(nref)
	lw	x6, 1(x2)	# vecadd diffuse_ray r_left.(nref)
	addi	x4, x6, 0	# vecadd diffuse_ray r_left.(nref)
	sw	x1, 11(x2)	# vecadd diffuse_ray r_left.(nref)
	addi	x2, x2, 12	# vecadd diffuse_ray r_left.(nref)
	auipc	x31, -1	# vecadd diffuse_ray r_left.(nref)
	jalr	x0, x31, -5400	# vecadd diffuse_ray r_left.(nref)
	subi	x2, x2, 12	# vecadd diffuse_ray r_left.(nref)
	lw	x1, 11(x2)	# vecadd diffuse_ray r_left.(nref)
	addi	x0, x4, 0	# vecadd diffuse_ray r_left.(nref)
	lw	x4, 2(x2)	# r_center.(nref)
	lw	x5, 8(x2)	# r_center.(nref)
	lwa	x5, (x5, x4)	# r_center.(nref)
	lw	x6, 1(x2)	# vecadd diffuse_ray r_center.(nref)
	addi	x4, x6, 0	# vecadd diffuse_ray r_center.(nref)
	sw	x1, 11(x2)	# vecadd diffuse_ray r_center.(nref)
	addi	x2, x2, 12	# vecadd diffuse_ray r_center.(nref)
	auipc	x31, -1	# vecadd diffuse_ray r_center.(nref)
	jalr	x0, x31, -5412	# vecadd diffuse_ray r_center.(nref)
	subi	x2, x2, 12	# vecadd diffuse_ray r_center.(nref)
	lw	x1, 11(x2)	# vecadd diffuse_ray r_center.(nref)
	addi	x0, x4, 0	# vecadd diffuse_ray r_center.(nref)
	lw	x4, 2(x2)	# r_right.(nref)
	lw	x5, 9(x2)	# r_right.(nref)
	lwa	x5, (x5, x4)	# r_right.(nref)
	lw	x6, 1(x2)	# vecadd diffuse_ray r_right.(nref)
	addi	x4, x6, 0	# vecadd diffuse_ray r_right.(nref)
	sw	x1, 11(x2)	# vecadd diffuse_ray r_right.(nref)
	addi	x2, x2, 12	# vecadd diffuse_ray r_right.(nref)
	auipc	x31, -1	# vecadd diffuse_ray r_right.(nref)
	jalr	x0, x31, -5424	# vecadd diffuse_ray r_right.(nref)
	subi	x2, x2, 12	# vecadd diffuse_ray r_right.(nref)
	lw	x1, 11(x2)	# vecadd diffuse_ray r_right.(nref)
	addi	x0, x4, 0	# vecadd diffuse_ray r_right.(nref)
	lw	x4, 2(x2)	# r_down.(nref)
	lw	x5, 10(x2)	# r_down.(nref)
	lwa	x5, (x5, x4)	# r_down.(nref)
	lw	x6, 1(x2)	# vecadd diffuse_ray r_down.(nref)
	addi	x4, x6, 0	# vecadd diffuse_ray r_down.(nref)
	sw	x1, 11(x2)	# vecadd diffuse_ray r_down.(nref)
	addi	x2, x2, 12	# vecadd diffuse_ray r_down.(nref)
	auipc	x31, -1	# vecadd diffuse_ray r_down.(nref)
	jalr	x0, x31, -5436	# vecadd diffuse_ray r_down.(nref)
	subi	x2, x2, 12	# vecadd diffuse_ray r_down.(nref)
	lw	x1, 11(x2)	# vecadd diffuse_ray r_down.(nref)
	addi	x0, x4, 0	# vecadd diffuse_ray r_down.(nref)
	lw	x4, 5(x2)	# cur.(x)
	lw	x5, 4(x2)	# cur.(x)
	lwa	x4, (x5, x4)	# cur.(x)
	# let energya = p_energy cur.(x)
	sw	x1, 11(x2)	# p_energy cur.(x)
	addi	x2, x2, 12	# p_energy cur.(x)
	auipc	x31, -1	# p_energy cur.(x)
	jalr	x0, x31, -5341	# p_energy cur.(x)
	subi	x2, x2, 12	# p_energy cur.(x)
	lw	x1, 11(x2)	# p_energy cur.(x)
	addi	x4, x4, 0	# p_energy cur.(x)
	lw	x5, 2(x2)	# energya.(nref)
	lwa	x5, (x4, x5)	# energya.(nref)
	lw	x4, 0(x2)	# vecaccumv rgb energya.(nref) diffuse_ray
	lw	x6, 1(x2)	# vecaccumv rgb energya.(nref) diffuse_ray
	auipc	x31, -1	# vecaccumv rgb energya.(nref) diffuse_ray
	jalr	x0, x31, -5430	# vecaccumv rgb energya.(nref) diffuse_ray
# do_without_neighbors.2896:	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	lw	x6, 4(x29)	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	addi	x7, x0, 4	# 4
	bge	x7, x5, 2	# if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else ()
	sw	x29, 0(x2)	# p_surface_ids pixel
	sw	x6, 1(x2)	# p_surface_ids pixel
	sw	x4, 2(x2)	# p_surface_ids pixel
	sw	x5, 3(x2)	# p_surface_ids pixel
	# let surface_ids = p_surface_ids pixel
	sw	x1, 4(x2)	# p_surface_ids pixel
	addi	x2, x2, 5	# p_surface_ids pixel
	auipc	x31, -1	# p_surface_ids pixel
	jalr	x0, x31, -5366	# p_surface_ids pixel
	subi	x2, x2, 5	# p_surface_ids pixel
	lw	x1, 4(x2)	# p_surface_ids pixel
	addi	x4, x4, 0	# p_surface_ids pixel
	lw	x5, 3(x2)	# surface_ids.(nref)
	lwa	x4, (x4, x5)	# surface_ids.(nref)
	bge	x4, x0, 2	# if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1)
	lw	x4, 2(x2)	# p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 4(x2)	# p_calc_diffuse pixel
	addi	x2, x2, 5	# p_calc_diffuse pixel
	auipc	x31, -1	# p_calc_diffuse pixel
	jalr	x0, x31, -5376	# p_calc_diffuse pixel
	subi	x2, x2, 5	# p_calc_diffuse pixel
	lw	x1, 4(x2)	# p_calc_diffuse pixel
	addi	x4, x4, 0	# p_calc_diffuse pixel
	lw	x5, 3(x2)	# calc_diffuse.(nref)
	lwa	x4, (x4, x5)	# calc_diffuse.(nref)
	bne	x4, x0, 3	# if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 5	# if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else ()
# bne:	calc_diffuse_using_1point pixel nref
	lw	x4, 2(x2)	# calc_diffuse_using_1point pixel nref
	lw	x29, 1(x2)	# calc_diffuse_using_1point pixel nref
	lw	x31, 0(x29)	# calc_diffuse_using_1point pixel nref
	jalr	x0, x31, 0	# calc_diffuse_using_1point pixel nref
# cont:	if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else ()
	lw	x4, 3(x2)	# nref + 1
	addi	x5, x4, 1	# nref + 1
	lw	x4, 2(x2)	# do_without_neighbors pixel (nref + 1)
	lw	x29, 0(x2)	# do_without_neighbors pixel (nref + 1)
	lw	x31, 0(x29)	# do_without_neighbors pixel (nref + 1)
	jalr	x0, x31, 0	# do_without_neighbors pixel (nref + 1)
# neighbors_exist.2899:	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	lw	x6, 4(x29)	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	addi	x7, x5, 1	# y + 1
	lw	x8, 1(x6)	# image_size.(1)
	bge	x7, x8, 14	# if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
# blt:	if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false
	bge	x0, x5, 11	# if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false
# blt:	if (x + 1) < image_size.(0) then if x > 0 then true else false else false
	addi	x5, x4, 1	# x + 1
	lw	x6, 0(x6)	# image_size.(0)
	bge	x5, x6, 6	# if (x + 1) < image_size.(0) then if x > 0 then true else false else false
# blt:	if x > 0 then true else false
	bge	x0, x4, 3	# if x > 0 then true else false
# blt:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# bge:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bge:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bge:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bge:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# get_surface_id.2903:	# let rec get_surface_id pixel index = let surface_ids = p_surface_ids pixel in surface_ids.(index)
	sw	x5, 0(x2)	# p_surface_ids pixel
	# let surface_ids = p_surface_ids pixel
	sw	x1, 1(x2)	# p_surface_ids pixel
	addi	x2, x2, 2	# p_surface_ids pixel
	auipc	x31, -1	# p_surface_ids pixel
	jalr	x0, x31, -5420	# p_surface_ids pixel
	subi	x2, x2, 2	# p_surface_ids pixel
	lw	x1, 1(x2)	# p_surface_ids pixel
	addi	x4, x4, 0	# p_surface_ids pixel
	lw	x5, 0(x2)	# surface_ids.(index)
	lwa	x4, (x4, x5)	# surface_ids.(index)
	jalr	x0, x1, 0	# surface_ids.(index)
# neighbors_are_available.2906:	# let rec neighbors_are_available x prev cur next nref = let sid_center = get_surface_id cur.(x) nref in if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false
	lwa	x9, (x6, x4)	# cur.(x)
	sw	x6, 0(x2)	# get_surface_id cur.(x) nref
	sw	x7, 1(x2)	# get_surface_id cur.(x) nref
	sw	x8, 2(x2)	# get_surface_id cur.(x) nref
	sw	x4, 3(x2)	# get_surface_id cur.(x) nref
	sw	x5, 4(x2)	# get_surface_id cur.(x) nref
	# let sid_center = get_surface_id cur.(x) nref
	addi	x5, x8, 0	# get_surface_id cur.(x) nref
	addi	x4, x9, 0	# get_surface_id cur.(x) nref
	sw	x1, 5(x2)	# get_surface_id cur.(x) nref
	addi	x2, x2, 6	# get_surface_id cur.(x) nref
	jal	x0, -22	# get_surface_id cur.(x) nref
	subi	x2, x2, 6	# get_surface_id cur.(x) nref
	lw	x1, 5(x2)	# get_surface_id cur.(x) nref
	addi	x4, x4, 0	# get_surface_id cur.(x) nref
	lw	x5, 3(x2)	# prev.(x)
	lw	x6, 4(x2)	# prev.(x)
	lwa	x6, (x6, x5)	# prev.(x)
	lw	x7, 2(x2)	# get_surface_id prev.(x) nref
	sw	x4, 5(x2)	# get_surface_id prev.(x) nref
	addi	x5, x7, 0	# get_surface_id prev.(x) nref
	addi	x4, x6, 0	# get_surface_id prev.(x) nref
	sw	x1, 6(x2)	# get_surface_id prev.(x) nref
	addi	x2, x2, 7	# get_surface_id prev.(x) nref
	jal	x0, -35	# get_surface_id prev.(x) nref
	subi	x2, x2, 7	# get_surface_id prev.(x) nref
	lw	x1, 6(x2)	# get_surface_id prev.(x) nref
	addi	x4, x4, 0	# get_surface_id prev.(x) nref
	lw	x5, 5(x2)	# if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false
	bne	x4, x5, 52	# if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false
# beq:	if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false
	lw	x4, 3(x2)	# next.(x)
	lw	x6, 1(x2)	# next.(x)
	lwa	x6, (x6, x4)	# next.(x)
	lw	x7, 2(x2)	# get_surface_id next.(x) nref
	addi	x5, x7, 0	# get_surface_id next.(x) nref
	addi	x4, x6, 0	# get_surface_id next.(x) nref
	sw	x1, 6(x2)	# get_surface_id next.(x) nref
	addi	x2, x2, 7	# get_surface_id next.(x) nref
	jal	x0, -49	# get_surface_id next.(x) nref
	subi	x2, x2, 7	# get_surface_id next.(x) nref
	lw	x1, 6(x2)	# get_surface_id next.(x) nref
	addi	x4, x4, 0	# get_surface_id next.(x) nref
	lw	x5, 5(x2)	# if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false
	bne	x4, x5, 36	# if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false
# beq:	if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false
	lw	x4, 3(x2)	# x-1
	addi	x6, x4, -1	# x-1
	lw	x7, 0(x2)	# cur.(x-1)
	lwa	x6, (x7, x6)	# cur.(x-1)
	lw	x8, 2(x2)	# get_surface_id cur.(x-1) nref
	addi	x5, x8, 0	# get_surface_id cur.(x-1) nref
	addi	x4, x6, 0	# get_surface_id cur.(x-1) nref
	sw	x1, 6(x2)	# get_surface_id cur.(x-1) nref
	addi	x2, x2, 7	# get_surface_id cur.(x-1) nref
	jal	x0, -64	# get_surface_id cur.(x-1) nref
	subi	x2, x2, 7	# get_surface_id cur.(x-1) nref
	lw	x1, 6(x2)	# get_surface_id cur.(x-1) nref
	addi	x4, x4, 0	# get_surface_id cur.(x-1) nref
	lw	x5, 5(x2)	# if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false
	bne	x4, x5, 19	# if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false
# beq:	if get_surface_id cur.(x+1) nref = sid_center then true else false
	lw	x4, 3(x2)	# x+1
	addi	x4, x4, 1	# x+1
	lw	x6, 0(x2)	# cur.(x+1)
	lwa	x4, (x6, x4)	# cur.(x+1)
	lw	x6, 2(x2)	# get_surface_id cur.(x+1) nref
	addi	x5, x6, 0	# get_surface_id cur.(x+1) nref
	sw	x1, 6(x2)	# get_surface_id cur.(x+1) nref
	addi	x2, x2, 7	# get_surface_id cur.(x+1) nref
	jal	x0, -79	# get_surface_id cur.(x+1) nref
	subi	x2, x2, 7	# get_surface_id cur.(x+1) nref
	lw	x1, 6(x2)	# get_surface_id cur.(x+1) nref
	addi	x4, x4, 0	# get_surface_id cur.(x+1) nref
	lw	x5, 5(x2)	# if get_surface_id cur.(x+1) nref = sid_center then true else false
	bne	x4, x5, 3	# if get_surface_id cur.(x+1) nref = sid_center then true else false
# beq:	true
	addi	x4, x0, 1	# true
	jalr	x0, x1, 0	# true
# bne:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# bne:	false
	addi	x4, x0, 0	# false
	jalr	x0, x1, 0	# false
# try_exploit_neighbors.2912:	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	lw	x10, 5(x29)	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	lw	x11, 4(x29)	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	# let pixel = cur.(x)
	lwa	x12, (x7, x4)	# cur.(x)
	addi	x13, x0, 4	# 4
	bge	x13, x9, 2	# if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else ()
	sw	x5, 0(x2)	# get_surface_id pixel nref
	sw	x29, 1(x2)	# get_surface_id pixel nref
	sw	x11, 2(x2)	# get_surface_id pixel nref
	sw	x12, 3(x2)	# get_surface_id pixel nref
	sw	x10, 4(x2)	# get_surface_id pixel nref
	sw	x9, 5(x2)	# get_surface_id pixel nref
	sw	x8, 6(x2)	# get_surface_id pixel nref
	sw	x7, 7(x2)	# get_surface_id pixel nref
	sw	x6, 8(x2)	# get_surface_id pixel nref
	sw	x4, 9(x2)	# get_surface_id pixel nref
	addi	x5, x9, 0	# get_surface_id pixel nref
	addi	x4, x12, 0	# get_surface_id pixel nref
	sw	x1, 10(x2)	# get_surface_id pixel nref
	addi	x2, x2, 11	# get_surface_id pixel nref
	jal	x0, -114	# get_surface_id pixel nref
	subi	x2, x2, 11	# get_surface_id pixel nref
	lw	x1, 10(x2)	# get_surface_id pixel nref
	addi	x4, x4, 0	# get_surface_id pixel nref
	bge	x4, x0, 2	# if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref
	lw	x4, 9(x2)	# neighbors_are_available x prev cur next nref
	lw	x5, 8(x2)	# neighbors_are_available x prev cur next nref
	lw	x6, 7(x2)	# neighbors_are_available x prev cur next nref
	lw	x7, 6(x2)	# neighbors_are_available x prev cur next nref
	lw	x8, 5(x2)	# neighbors_are_available x prev cur next nref
	sw	x1, 10(x2)	# neighbors_are_available x prev cur next nref
	addi	x2, x2, 11	# neighbors_are_available x prev cur next nref
	jal	x0, -118	# neighbors_are_available x prev cur next nref
	subi	x2, x2, 11	# neighbors_are_available x prev cur next nref
	lw	x1, 10(x2)	# neighbors_are_available x prev cur next nref
	addi	x4, x4, 0	# neighbors_are_available x prev cur next nref
	bne	x4, x0, 8	# if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref
# beq:	do_without_neighbors cur.(x) nref
	lw	x4, 9(x2)	# cur.(x)
	lw	x5, 7(x2)	# cur.(x)
	lwa	x4, (x5, x4)	# cur.(x)
	lw	x5, 5(x2)	# do_without_neighbors cur.(x) nref
	lw	x29, 4(x2)	# do_without_neighbors cur.(x) nref
	lw	x31, 0(x29)	# do_without_neighbors cur.(x) nref
	jalr	x0, x31, 0	# do_without_neighbors cur.(x) nref
# bne:	let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x4, 3(x2)	# p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 10(x2)	# p_calc_diffuse pixel
	addi	x2, x2, 11	# p_calc_diffuse pixel
	auipc	x31, -1	# p_calc_diffuse pixel
	jalr	x0, x31, -5556	# p_calc_diffuse pixel
	subi	x2, x2, 11	# p_calc_diffuse pixel
	lw	x1, 10(x2)	# p_calc_diffuse pixel
	addi	x4, x4, 0	# p_calc_diffuse pixel
	lw	x8, 5(x2)	# calc_diffuse.(nref)
	lwa	x4, (x4, x8)	# calc_diffuse.(nref)
	bne	x4, x0, 3	# if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 8	# if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else ()
# bne:	calc_diffuse_using_5points x prev cur next nref
	lw	x4, 9(x2)	# calc_diffuse_using_5points x prev cur next nref
	lw	x5, 8(x2)	# calc_diffuse_using_5points x prev cur next nref
	lw	x6, 7(x2)	# calc_diffuse_using_5points x prev cur next nref
	lw	x7, 6(x2)	# calc_diffuse_using_5points x prev cur next nref
	lw	x29, 2(x2)	# calc_diffuse_using_5points x prev cur next nref
	lw	x31, 0(x29)	# calc_diffuse_using_5points x prev cur next nref
	jalr	x0, x31, 0	# calc_diffuse_using_5points x prev cur next nref
# cont:	if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else ()
	lw	x4, 5(x2)	# nref + 1
	addi	x9, x4, 1	# nref + 1
	lw	x4, 9(x2)	# try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x5, 0(x2)	# try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x6, 8(x2)	# try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x7, 7(x2)	# try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x8, 6(x2)	# try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x29, 1(x2)	# try_exploit_neighbors x y prev cur next (nref + 1)
	lw	x31, 0(x29)	# try_exploit_neighbors x y prev cur next (nref + 1)
	jalr	x0, x31, 0	# try_exploit_neighbors x y prev cur next (nref + 1)
# pretrace_diffuse_rays.2925:	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	lw	x6, 6(x29)	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	lw	x7, 5(x29)	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	lw	x8, 4(x29)	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	addi	x9, x0, 4	# 4
	bge	x9, x5, 2	# if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else ()
	sw	x29, 0(x2)	# get_surface_id pixel nref
	sw	x6, 1(x2)	# get_surface_id pixel nref
	sw	x7, 2(x2)	# get_surface_id pixel nref
	sw	x8, 3(x2)	# get_surface_id pixel nref
	sw	x5, 4(x2)	# get_surface_id pixel nref
	sw	x4, 5(x2)	# get_surface_id pixel nref
	# let sid = get_surface_id pixel nref
	sw	x1, 6(x2)	# get_surface_id pixel nref
	addi	x2, x2, 7	# get_surface_id pixel nref
	jal	x0, -185	# get_surface_id pixel nref
	subi	x2, x2, 7	# get_surface_id pixel nref
	lw	x1, 6(x2)	# get_surface_id pixel nref
	addi	x4, x4, 0	# get_surface_id pixel nref
	bge	x4, x0, 2	# if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1)
	lw	x4, 5(x2)	# p_calc_diffuse pixel
	# let calc_diffuse = p_calc_diffuse pixel
	sw	x1, 6(x2)	# p_calc_diffuse pixel
	addi	x2, x2, 7	# p_calc_diffuse pixel
	auipc	x31, -1	# p_calc_diffuse pixel
	jalr	x0, x31, -5606	# p_calc_diffuse pixel
	subi	x2, x2, 7	# p_calc_diffuse pixel
	lw	x1, 6(x2)	# p_calc_diffuse pixel
	addi	x4, x4, 0	# p_calc_diffuse pixel
	lw	x5, 4(x2)	# calc_diffuse.(nref)
	lwa	x4, (x4, x5)	# calc_diffuse.(nref)
	bne	x4, x0, 3	# if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else ()
# beq:	()
	jalr x0, x1, 0	# ()
	jal	x0, 69	# if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else ()
# bne:	let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray
	lw	x4, 5(x2)	# p_group_id pixel
	# let group_id = p_group_id pixel
	sw	x1, 6(x2)	# p_group_id pixel
	addi	x2, x2, 7	# p_group_id pixel
	auipc	x31, -1	# p_group_id pixel
	jalr	x0, x31, -5613	# p_group_id pixel
	subi	x2, x2, 7	# p_group_id pixel
	lw	x1, 6(x2)	# p_group_id pixel
	addi	x4, x4, 0	# p_group_id pixel
	lw	x5, 3(x2)	# vecbzero diffuse_ray
	sw	x4, 6(x2)	# vecbzero diffuse_ray
	addi	x4, x5, 0	# vecbzero diffuse_ray
	sw	x1, 7(x2)	# vecbzero diffuse_ray
	addi	x2, x2, 8	# vecbzero diffuse_ray
	auipc	x31, -1	# vecbzero diffuse_ray
	jalr	x0, x31, -5813	# vecbzero diffuse_ray
	subi	x2, x2, 8	# vecbzero diffuse_ray
	lw	x1, 7(x2)	# vecbzero diffuse_ray
	addi	x0, x4, 0	# vecbzero diffuse_ray
	lw	x4, 5(x2)	# p_nvectors pixel
	# let nvectors = p_nvectors pixel
	sw	x1, 7(x2)	# p_nvectors pixel
	addi	x2, x2, 8	# p_nvectors pixel
	auipc	x31, -1	# p_nvectors pixel
	jalr	x0, x31, -5625	# p_nvectors pixel
	subi	x2, x2, 8	# p_nvectors pixel
	lw	x1, 7(x2)	# p_nvectors pixel
	addi	x4, x4, 0	# p_nvectors pixel
	lw	x5, 5(x2)	# p_intersection_points pixel
	sw	x4, 7(x2)	# p_intersection_points pixel
	# let intersection_points = p_intersection_points pixel
	addi	x4, x5, 0	# p_intersection_points pixel
	sw	x1, 8(x2)	# p_intersection_points pixel
	addi	x2, x2, 9	# p_intersection_points pixel
	auipc	x31, -1	# p_intersection_points pixel
	jalr	x0, x31, -5650	# p_intersection_points pixel
	subi	x2, x2, 9	# p_intersection_points pixel
	lw	x1, 8(x2)	# p_intersection_points pixel
	addi	x4, x4, 0	# p_intersection_points pixel
	lw	x5, 6(x2)	# dirvecs.(group_id)
	lw	x6, 2(x2)	# dirvecs.(group_id)
	lwa	x5, (x6, x5)	# dirvecs.(group_id)
	lw	x6, 4(x2)	# nvectors.(nref)
	lw	x7, 7(x2)	# nvectors.(nref)
	lwa	x7, (x7, x6)	# nvectors.(nref)
	lwa	x4, (x4, x6)	# intersection_points.(nref)
	lw	x29, 1(x2)	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x6, x4, 0	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x4, x5, 0	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x5, x7, 0	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	sw	x1, 8(x2)	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x2, x2, 9	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	lw	x31, 0(x29)	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	jalr	x1, x31, 0	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	subi	x2, x2, 9	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	lw	x1, 8(x2)	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	addi	x0, x4, 0	# trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref)
	lw	x4, 5(x2)	# p_received_ray_20percent pixel
	# let ray20p = p_received_ray_20percent pixel
	sw	x1, 8(x2)	# p_received_ray_20percent pixel
	addi	x2, x2, 9	# p_received_ray_20percent pixel
	auipc	x31, -1	# p_received_ray_20percent pixel
	jalr	x0, x31, -5669	# p_received_ray_20percent pixel
	subi	x2, x2, 9	# p_received_ray_20percent pixel
	lw	x1, 8(x2)	# p_received_ray_20percent pixel
	addi	x4, x4, 0	# p_received_ray_20percent pixel
	lw	x5, 4(x2)	# ray20p.(nref)
	lwa	x4, (x4, x5)	# ray20p.(nref)
	lw	x6, 3(x2)	# veccpy ray20p.(nref) diffuse_ray
	addi	x5, x6, 0	# veccpy ray20p.(nref) diffuse_ray
	auipc	x31, -1	# veccpy ray20p.(nref) diffuse_ray
	jalr	x0, x31, -5861	# veccpy ray20p.(nref) diffuse_ray
# cont:	if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else ()
	lw	x4, 4(x2)	# nref + 1
	addi	x5, x4, 1	# nref + 1
	lw	x4, 5(x2)	# pretrace_diffuse_rays pixel (nref + 1)
	lw	x29, 0(x2)	# pretrace_diffuse_rays pixel (nref + 1)
	lw	x31, 0(x29)	# pretrace_diffuse_rays pixel (nref + 1)
	jalr	x0, x31, 0	# pretrace_diffuse_rays pixel (nref + 1)
# pretrace_pixels.2928:	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x7, 12(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x8, 11(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x9, 10(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x10, 9(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x11, 8(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x12, 7(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x13, 6(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x14, 5(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x15, 4(x29)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	bge	x5, x0, 2	# if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	flw	f4, 0(x11)	# scan_pitch.(0)
	lw	x11, 0(x15)	# image_center.(0)
	sub	x11, x5, x11	# x - image_center.(0)
	itof	f5, x11	# float_of_int (x - image_center.(0))
	# let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0))
	fmul	f4, f4, f5	# scan_pitch.(0) *. float_of_int (x - image_center.(0))
	flw	f5, 0(x10)	# screenx_dir.(0)
	fmul	f5, f4, f5	# xdisp *. screenx_dir.(0)
	fadd	f5, f5, f1	# xdisp *. screenx_dir.(0) +. lc0
	fsw	f5, 0(x13)	# ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0
	flw	f5, 1(x10)	# screenx_dir.(1)
	fmul	f5, f4, f5	# xdisp *. screenx_dir.(1)
	fadd	f5, f5, f2	# xdisp *. screenx_dir.(1) +. lc1
	fsw	f5, 1(x13)	# ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1
	flw	f5, 2(x10)	# screenx_dir.(2)
	fmul	f4, f4, f5	# xdisp *. screenx_dir.(2)
	fadd	f4, f4, f3	# xdisp *. screenx_dir.(2) +. lc2
	fsw	f4, 2(x13)	# ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2
	addi	x10, x0, 0	# false
	fsw	f3, 0(x2)	# vecunit_sgn ptrace_dirvec false
	fsw	f2, 1(x2)	# vecunit_sgn ptrace_dirvec false
	fsw	f1, 2(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x29, 3(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x14, 4(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x6, 5(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x13, 6(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x8, 7(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x5, 8(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x4, 9(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x7, 10(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x9, 11(x2)	# vecunit_sgn ptrace_dirvec false
	sw	x12, 12(x2)	# vecunit_sgn ptrace_dirvec false
	addi	x5, x10, 0	# vecunit_sgn ptrace_dirvec false
	addi	x4, x13, 0	# vecunit_sgn ptrace_dirvec false
	sw	x1, 13(x2)	# vecunit_sgn ptrace_dirvec false
	addi	x2, x2, 14	# vecunit_sgn ptrace_dirvec false
	auipc	x31, -1	# vecunit_sgn ptrace_dirvec false
	jalr	x0, x31, -5909	# vecunit_sgn ptrace_dirvec false
	subi	x2, x2, 14	# vecunit_sgn ptrace_dirvec false
	lw	x1, 13(x2)	# vecunit_sgn ptrace_dirvec false
	addi	x0, x4, 0	# vecunit_sgn ptrace_dirvec false
	lw	x4, 12(x2)	# vecbzero rgb
	sw	x1, 13(x2)	# vecbzero rgb
	addi	x2, x2, 14	# vecbzero rgb
	auipc	x31, -1	# vecbzero rgb
	jalr	x0, x31, -5929	# vecbzero rgb
	subi	x2, x2, 14	# vecbzero rgb
	lw	x1, 13(x2)	# vecbzero rgb
	addi	x0, x4, 0	# vecbzero rgb
	lw	x4, 11(x2)	# veccpy startp viewpoint
	lw	x5, 10(x2)	# veccpy startp viewpoint
	sw	x1, 13(x2)	# veccpy startp viewpoint
	addi	x2, x2, 14	# veccpy startp viewpoint
	auipc	x31, -1	# veccpy startp viewpoint
	jalr	x0, x31, -5935	# veccpy startp viewpoint
	subi	x2, x2, 14	# veccpy startp viewpoint
	lw	x1, 13(x2)	# veccpy startp viewpoint
	addi	x0, x4, 0	# veccpy startp viewpoint
	addi	x4, x0, 0	# 0
	lui	x31, 260096	# 1.0
	addi	x31, x31, 1065353216	# 1.0
	mvitof	f1, x31	# 1.0
	lw	x5, 8(x2)	# line.(x)
	lw	x6, 9(x2)	# line.(x)
	lwa	x7, (x6, x5)	# line.(x)
	addi	x31, x0, 0	# 0.0
	mvitof	f2, x31	# 0.0
	lw	x8, 6(x2)	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	lw	x29, 7(x2)	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	addi	x6, x7, 0	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	addi	x5, x8, 0	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	sw	x1, 13(x2)	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	addi	x2, x2, 14	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	lw	x31, 0(x29)	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	jalr	x1, x31, 0	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	subi	x2, x2, 14	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	lw	x1, 13(x2)	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	addi	x0, x4, 0	# trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0
	lw	x4, 8(x2)	# line.(x)
	lw	x5, 9(x2)	# line.(x)
	lwa	x6, (x5, x4)	# line.(x)
	addi	x4, x6, 0	# p_rgb line.(x)
	sw	x1, 13(x2)	# p_rgb line.(x)
	addi	x2, x2, 14	# p_rgb line.(x)
	auipc	x31, -1	# p_rgb line.(x)
	jalr	x0, x31, -5789	# p_rgb line.(x)
	subi	x2, x2, 14	# p_rgb line.(x)
	lw	x1, 13(x2)	# p_rgb line.(x)
	addi	x4, x4, 0	# p_rgb line.(x)
	lw	x5, 12(x2)	# veccpy (p_rgb line.(x)) rgb
	sw	x1, 13(x2)	# veccpy (p_rgb line.(x)) rgb
	addi	x2, x2, 14	# veccpy (p_rgb line.(x)) rgb
	auipc	x31, -1	# veccpy (p_rgb line.(x)) rgb
	jalr	x0, x31, -5974	# veccpy (p_rgb line.(x)) rgb
	subi	x2, x2, 14	# veccpy (p_rgb line.(x)) rgb
	lw	x1, 13(x2)	# veccpy (p_rgb line.(x)) rgb
	addi	x0, x4, 0	# veccpy (p_rgb line.(x)) rgb
	lw	x4, 8(x2)	# line.(x)
	lw	x5, 9(x2)	# line.(x)
	lwa	x6, (x5, x4)	# line.(x)
	lw	x7, 5(x2)	# p_set_group_id line.(x) group_id
	addi	x5, x7, 0	# p_set_group_id line.(x) group_id
	addi	x4, x6, 0	# p_set_group_id line.(x) group_id
	sw	x1, 13(x2)	# p_set_group_id line.(x) group_id
	addi	x2, x2, 14	# p_set_group_id line.(x) group_id
	auipc	x31, -1	# p_set_group_id line.(x) group_id
	jalr	x0, x31, -5794	# p_set_group_id line.(x) group_id
	subi	x2, x2, 14	# p_set_group_id line.(x) group_id
	lw	x1, 13(x2)	# p_set_group_id line.(x) group_id
	addi	x0, x4, 0	# p_set_group_id line.(x) group_id
	lw	x4, 8(x2)	# line.(x)
	lw	x5, 9(x2)	# line.(x)
	lwa	x6, (x5, x4)	# line.(x)
	addi	x7, x0, 0	# 0
	lw	x29, 4(x2)	# pretrace_diffuse_rays line.(x) 0
	addi	x5, x7, 0	# pretrace_diffuse_rays line.(x) 0
	addi	x4, x6, 0	# pretrace_diffuse_rays line.(x) 0
	sw	x1, 13(x2)	# pretrace_diffuse_rays line.(x) 0
	addi	x2, x2, 14	# pretrace_diffuse_rays line.(x) 0
	lw	x31, 0(x29)	# pretrace_diffuse_rays line.(x) 0
	jalr	x1, x31, 0	# pretrace_diffuse_rays line.(x) 0
	subi	x2, x2, 14	# pretrace_diffuse_rays line.(x) 0
	lw	x1, 13(x2)	# pretrace_diffuse_rays line.(x) 0
	addi	x0, x4, 0	# pretrace_diffuse_rays line.(x) 0
	lw	x4, 8(x2)	# x-1
	addi	x4, x4, -1	# x-1
	addi	x5, x0, 1	# 1
	lw	x6, 5(x2)	# add_mod5 group_id 1
	sw	x4, 13(x2)	# add_mod5 group_id 1
	addi	x4, x6, 0	# add_mod5 group_id 1
	sw	x1, 14(x2)	# add_mod5 group_id 1
	addi	x2, x2, 15	# add_mod5 group_id 1
	auipc	x31, -1	# add_mod5 group_id 1
	jalr	x0, x31, -6030	# add_mod5 group_id 1
	subi	x2, x2, 15	# add_mod5 group_id 1
	lw	x1, 14(x2)	# add_mod5 group_id 1
	addi	x6, x4, 0	# add_mod5 group_id 1
	flw	f1, 2(x2)	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	flw	f2, 1(x2)	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	flw	f3, 0(x2)	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	lw	x4, 9(x2)	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	lw	x5, 13(x2)	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	lw	x29, 3(x2)	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	lw	x31, 0(x29)	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
	jalr	x0, x31, 0	# pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2
# pretrace_line.2935:	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lw	x7, 9(x29)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lw	x8, 8(x29)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lw	x9, 7(x29)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lw	x10, 6(x29)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lw	x11, 5(x29)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lw	x12, 4(x29)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	flw	f1, 0(x9)	# scan_pitch.(0)
	lw	x9, 1(x12)	# image_center.(1)
	sub	x5, x5, x9	# y - image_center.(1)
	itof	f2, x5	# float_of_int (y - image_center.(1))
	# let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1))
	fmul	f1, f1, f2	# scan_pitch.(0) *. float_of_int (y - image_center.(1))
	flw	f2, 0(x8)	# screeny_dir.(0)
	fmul	f2, f1, f2	# ydisp *. screeny_dir.(0)
	flw	f3, 0(x7)	# screenz_dir.(0)
	# let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0)
	fadd	f2, f2, f3	# ydisp *. screeny_dir.(0) +. screenz_dir.(0)
	flw	f3, 1(x8)	# screeny_dir.(1)
	fmul	f3, f1, f3	# ydisp *. screeny_dir.(1)
	flw	f4, 1(x7)	# screenz_dir.(1)
	# let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1)
	fadd	f3, f3, f4	# ydisp *. screeny_dir.(1) +. screenz_dir.(1)
	flw	f4, 2(x8)	# screeny_dir.(2)
	fmul	f1, f1, f4	# ydisp *. screeny_dir.(2)
	flw	f4, 2(x7)	# screenz_dir.(2)
	# let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2)
	fadd	f1, f1, f4	# ydisp *. screeny_dir.(2) +. screenz_dir.(2)
	lw	x5, 0(x11)	# image_size.(0)
	addi	x5, x5, -1	# image_size.(0) - 1
	addi	x29, x10, 0	# pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	fmv	f31, f3	# pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	fmv	f3, f1	# pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	fmv	f1, f2	# pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	fmv	f2, f31	# pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lw	x31, 0(x29)	# pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	jalr	x0, x31, 0	# pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
# scan_pixel.2939:	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lw	x9, 8(x29)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lw	x10, 7(x29)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lw	x11, 6(x29)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lw	x12, 5(x29)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lw	x13, 4(x29)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lw	x12, 0(x12)	# image_size.(0)
	bge	x4, x12, 68	# if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
# blt:	veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next
	lwa	x12, (x7, x4)	# cur.(x)
	sw	x29, 0(x2)	# p_rgb cur.(x)
	sw	x6, 1(x2)	# p_rgb cur.(x)
	sw	x9, 2(x2)	# p_rgb cur.(x)
	sw	x13, 3(x2)	# p_rgb cur.(x)
	sw	x7, 4(x2)	# p_rgb cur.(x)
	sw	x8, 5(x2)	# p_rgb cur.(x)
	sw	x5, 6(x2)	# p_rgb cur.(x)
	sw	x4, 7(x2)	# p_rgb cur.(x)
	sw	x11, 8(x2)	# p_rgb cur.(x)
	sw	x10, 9(x2)	# p_rgb cur.(x)
	addi	x4, x12, 0	# p_rgb cur.(x)
	sw	x1, 10(x2)	# p_rgb cur.(x)
	addi	x2, x2, 11	# p_rgb cur.(x)
	auipc	x31, -1	# p_rgb cur.(x)
	jalr	x0, x31, -5903	# p_rgb cur.(x)
	subi	x2, x2, 11	# p_rgb cur.(x)
	lw	x1, 10(x2)	# p_rgb cur.(x)
	addi	x5, x4, 0	# p_rgb cur.(x)
	lw	x4, 9(x2)	# veccpy rgb (p_rgb cur.(x))
	sw	x1, 10(x2)	# veccpy rgb (p_rgb cur.(x))
	addi	x2, x2, 11	# veccpy rgb (p_rgb cur.(x))
	auipc	x31, -1	# veccpy rgb (p_rgb cur.(x))
	jalr	x0, x31, -6088	# veccpy rgb (p_rgb cur.(x))
	subi	x2, x2, 11	# veccpy rgb (p_rgb cur.(x))
	lw	x1, 10(x2)	# veccpy rgb (p_rgb cur.(x))
	addi	x0, x4, 0	# veccpy rgb (p_rgb cur.(x))
	lw	x4, 7(x2)	# neighbors_exist x y next
	lw	x5, 6(x2)	# neighbors_exist x y next
	lw	x6, 5(x2)	# neighbors_exist x y next
	lw	x29, 8(x2)	# neighbors_exist x y next
	sw	x1, 10(x2)	# neighbors_exist x y next
	addi	x2, x2, 11	# neighbors_exist x y next
	lw	x31, 0(x29)	# neighbors_exist x y next
	jalr	x1, x31, 0	# neighbors_exist x y next
	subi	x2, x2, 11	# neighbors_exist x y next
	lw	x1, 10(x2)	# neighbors_exist x y next
	addi	x4, x4, 0	# neighbors_exist x y next
	bne	x4, x0, 11	# if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0
# beq:	do_without_neighbors cur.(x) 0
	lw	x4, 7(x2)	# cur.(x)
	lw	x5, 4(x2)	# cur.(x)
	lwa	x6, (x5, x4)	# cur.(x)
	addi	x7, x0, 0	# 0
	lw	x29, 3(x2)	# do_without_neighbors cur.(x) 0
	addi	x5, x7, 0	# do_without_neighbors cur.(x) 0
	addi	x4, x6, 0	# do_without_neighbors cur.(x) 0
	lw	x31, 0(x29)	# do_without_neighbors cur.(x) 0
	jalr	x0, x31, 0	# do_without_neighbors cur.(x) 0
	jal	x0, 10	# if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0
# bne:	try_exploit_neighbors x y prev cur next 0
	addi	x9, x0, 0	# 0
	lw	x4, 7(x2)	# try_exploit_neighbors x y prev cur next 0
	lw	x5, 6(x2)	# try_exploit_neighbors x y prev cur next 0
	lw	x6, 1(x2)	# try_exploit_neighbors x y prev cur next 0
	lw	x7, 4(x2)	# try_exploit_neighbors x y prev cur next 0
	lw	x8, 5(x2)	# try_exploit_neighbors x y prev cur next 0
	lw	x29, 2(x2)	# try_exploit_neighbors x y prev cur next 0
	lw	x31, 0(x29)	# try_exploit_neighbors x y prev cur next 0
	jalr	x0, x31, 0	# try_exploit_neighbors x y prev cur next 0
# cont:	if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0
	lw	x4, 7(x2)	# x + 1
	addi	x4, x4, 1	# x + 1
	lw	x5, 6(x2)	# scan_pixel (x + 1) y prev cur next
	lw	x6, 1(x2)	# scan_pixel (x + 1) y prev cur next
	lw	x7, 4(x2)	# scan_pixel (x + 1) y prev cur next
	lw	x8, 5(x2)	# scan_pixel (x + 1) y prev cur next
	lw	x29, 0(x2)	# scan_pixel (x + 1) y prev cur next
	lw	x31, 0(x29)	# scan_pixel (x + 1) y prev cur next
	jalr	x0, x31, 0	# scan_pixel (x + 1) y prev cur next
# bge:	()
	jalr x0, x1, 0	# ()
# scan_line.2945:	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	lw	x9, 6(x29)	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	lw	x10, 5(x29)	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	lw	x11, 4(x29)	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	lw	x12, 1(x11)	# image_size.(1)
	bge	x4, x12, 59	# if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else ()
# blt:	if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2);
	lw	x11, 1(x11)	# image_size.(1)
	addi	x11, x11, -1	# image_size.(1) - 1
	sw	x29, 0(x2)	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x8, 1(x2)	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x7, 2(x2)	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x6, 3(x2)	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x5, 4(x2)	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x4, 5(x2)	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	sw	x9, 6(x2)	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	bge	x4, x11, 9	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
# blt:	pretrace_line next (y + 1) group_id
	addi	x11, x4, 1	# y + 1
	addi	x6, x8, 0	# pretrace_line next (y + 1) group_id
	addi	x5, x11, 0	# pretrace_line next (y + 1) group_id
	addi	x4, x7, 0	# pretrace_line next (y + 1) group_id
	addi	x29, x10, 0	# pretrace_line next (y + 1) group_id
	lw	x31, 0(x29)	# pretrace_line next (y + 1) group_id
	jalr	x0, x31, 0	# pretrace_line next (y + 1) group_id
	jal	x0, 2	# if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
# bge:	()
	jalr x0, x1, 0	# ()
# cont:	if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else ()
	addi	x4, x0, 0	# 0
	lw	x5, 5(x2)	# scan_pixel 0 y prev cur next
	lw	x6, 4(x2)	# scan_pixel 0 y prev cur next
	lw	x7, 3(x2)	# scan_pixel 0 y prev cur next
	lw	x8, 2(x2)	# scan_pixel 0 y prev cur next
	lw	x29, 6(x2)	# scan_pixel 0 y prev cur next
	sw	x1, 7(x2)	# scan_pixel 0 y prev cur next
	addi	x2, x2, 8	# scan_pixel 0 y prev cur next
	lw	x31, 0(x29)	# scan_pixel 0 y prev cur next
	jalr	x1, x31, 0	# scan_pixel 0 y prev cur next
	subi	x2, x2, 8	# scan_pixel 0 y prev cur next
	lw	x1, 7(x2)	# scan_pixel 0 y prev cur next
	addi	x0, x4, 0	# scan_pixel 0 y prev cur next
	lw	x4, 5(x2)	# y + 1
	addi	x4, x4, 1	# y + 1
	addi	x5, x0, 2	# 2
	lw	x6, 1(x2)	# add_mod5 group_id 2
	sw	x4, 7(x2)	# add_mod5 group_id 2
	addi	x4, x6, 0	# add_mod5 group_id 2
	sw	x1, 8(x2)	# add_mod5 group_id 2
	addi	x2, x2, 9	# add_mod5 group_id 2
	auipc	x31, -2	# add_mod5 group_id 2
	jalr	x0, x31, -6195	# add_mod5 group_id 2
	subi	x2, x2, 9	# add_mod5 group_id 2
	lw	x1, 8(x2)	# add_mod5 group_id 2
	addi	x8, x4, 0	# add_mod5 group_id 2
	lw	x4, 7(x2)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x5, 3(x2)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x6, 2(x2)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x7, 4(x2)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x29, 0(x2)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	sw	x1, 8(x2)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	addi	x2, x2, 9	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x31, 0(x29)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	jalr	x1, x31, 0	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	subi	x2, x2, 9	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	lw	x1, 8(x2)	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	addi	x0, x4, 0	# scan_line (y + 1) cur next prev (add_mod5 group_id 2)
	jalr x0, x1, 0
# bge:	()
	jalr x0, x1, 0	# ()
# create_float5x3array.2951:	# let rec create_float5x3array _ = ( let vec = create_array 3 0.0 in let array = create_array 5 vec in array.(1) <- create_array 3 0.0; array.(2) <- create_array 3 0.0; array.(3) <- create_array 3 0.0; array.(4) <- create_array 3 0.0; array )
	addi	x4, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	# let vec = create_array 3 0.0
	sw	x1, 0(x2)	# create_array 3 0.0
	addi	x2, x2, 1	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -6746	# create_array 3 0.0
	subi	x2, x2, 1	# create_array 3 0.0
	lw	x1, 0(x2)	# create_array 3 0.0
	addi	x5, x4, 0	# create_array 3 0.0
	addi	x4, x0, 5	# 5
	# let array = create_array 5 vec
	sw	x1, 0(x2)	# create_array 5 vec
	addi	x2, x2, 1	# create_array 5 vec
	auipc	x31, -2	# create_array 5 vec
	jalr	x0, x31, -7254	# create_array 5 vec
	subi	x2, x2, 1	# create_array 5 vec
	lw	x1, 0(x2)	# create_array 5 vec
	addi	x4, x4, 0	# create_array 5 vec
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 0(x2)	# create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 1(x2)	# create_array 3 0.0
	addi	x2, x2, 2	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -6765	# create_array 3 0.0
	subi	x2, x2, 2	# create_array 3 0.0
	lw	x1, 1(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	lw	x5, 0(x2)	# array.(1) <- create_array 3 0.0
	sw	x4, 1(x5)	# array.(1) <- create_array 3 0.0
	addi	x4, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x1, 1(x2)	# create_array 3 0.0
	addi	x2, x2, 2	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -6778	# create_array 3 0.0
	subi	x2, x2, 2	# create_array 3 0.0
	lw	x1, 1(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	lw	x5, 0(x2)	# array.(2) <- create_array 3 0.0
	sw	x4, 2(x5)	# array.(2) <- create_array 3 0.0
	addi	x4, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x1, 1(x2)	# create_array 3 0.0
	addi	x2, x2, 2	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -6790	# create_array 3 0.0
	subi	x2, x2, 2	# create_array 3 0.0
	lw	x1, 1(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	lw	x5, 0(x2)	# array.(3) <- create_array 3 0.0
	sw	x4, 3(x5)	# array.(3) <- create_array 3 0.0
	addi	x4, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x1, 1(x2)	# create_array 3 0.0
	addi	x2, x2, 2	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -6802	# create_array 3 0.0
	subi	x2, x2, 2	# create_array 3 0.0
	lw	x1, 1(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	lw	x5, 0(x2)	# array.(4) <- create_array 3 0.0
	sw	x4, 4(x5)	# array.(4) <- create_array 3 0.0
	addi	x4, x5, 0	# array
	jalr	x0, x1, 0	# array
# create_pixel.2953:	# let rec create_pixel _ = let m_rgb = create_array 3 0.0 in let m_isect_ps = create_float5x3array() in let m_sids = create_array 5 0 in let m_cdif = create_array 5 false in let m_engy = create_float5x3array() in let m_r20p = create_float5x3array() in let m_gid = create_array 1 0 in let m_nvectors = create_float5x3array() in (m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors)
	addi	x4, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	# let m_rgb = create_array 3 0.0
	sw	x1, 0(x2)	# create_array 3 0.0
	addi	x2, x2, 1	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -6816	# create_array 3 0.0
	subi	x2, x2, 1	# create_array 3 0.0
	lw	x1, 0(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	sw	x4, 0(x2)	# create_float5x3array()
	# let m_isect_ps = create_float5x3array()
	sw	x1, 1(x2)	# create_float5x3array()
	addi	x2, x2, 2	# create_float5x3array()
	jal	x0, -86	# create_float5x3array()
	subi	x2, x2, 2	# create_float5x3array()
	lw	x1, 1(x2)	# create_float5x3array()
	addi	x4, x4, 0	# create_float5x3array()
	addi	x5, x0, 5	# 5
	addi	x6, x0, 0	# 0
	sw	x4, 1(x2)	# create_array 5 0
	# let m_sids = create_array 5 0
	addi	x4, x5, 0	# create_array 5 0
	addi	x5, x6, 0	# create_array 5 0
	sw	x1, 2(x2)	# create_array 5 0
	addi	x2, x2, 3	# create_array 5 0
	auipc	x31, -2	# create_array 5 0
	jalr	x0, x31, -7333	# create_array 5 0
	subi	x2, x2, 3	# create_array 5 0
	lw	x1, 2(x2)	# create_array 5 0
	addi	x4, x4, 0	# create_array 5 0
	addi	x5, x0, 5	# 5
	addi	x6, x0, 0	# false
	sw	x4, 2(x2)	# create_array 5 false
	# let m_cdif = create_array 5 false
	addi	x4, x5, 0	# create_array 5 false
	addi	x5, x6, 0	# create_array 5 false
	sw	x1, 3(x2)	# create_array 5 false
	addi	x2, x2, 4	# create_array 5 false
	auipc	x31, -2	# create_array 5 false
	jalr	x0, x31, -7345	# create_array 5 false
	subi	x2, x2, 4	# create_array 5 false
	lw	x1, 3(x2)	# create_array 5 false
	addi	x4, x4, 0	# create_array 5 false
	sw	x4, 3(x2)	# create_float5x3array()
	# let m_engy = create_float5x3array()
	sw	x1, 4(x2)	# create_float5x3array()
	addi	x2, x2, 5	# create_float5x3array()
	jal	x0, -117	# create_float5x3array()
	subi	x2, x2, 5	# create_float5x3array()
	lw	x1, 4(x2)	# create_float5x3array()
	addi	x4, x4, 0	# create_float5x3array()
	sw	x4, 4(x2)	# create_float5x3array()
	# let m_r20p = create_float5x3array()
	sw	x1, 5(x2)	# create_float5x3array()
	addi	x2, x2, 6	# create_float5x3array()
	jal	x0, -124	# create_float5x3array()
	subi	x2, x2, 6	# create_float5x3array()
	lw	x1, 5(x2)	# create_float5x3array()
	addi	x4, x4, 0	# create_float5x3array()
	addi	x5, x0, 1	# 1
	addi	x6, x0, 0	# 0
	sw	x4, 5(x2)	# create_array 1 0
	# let m_gid = create_array 1 0
	addi	x4, x5, 0	# create_array 1 0
	addi	x5, x6, 0	# create_array 1 0
	sw	x1, 6(x2)	# create_array 1 0
	addi	x2, x2, 7	# create_array 1 0
	auipc	x31, -2	# create_array 1 0
	jalr	x0, x31, -7371	# create_array 1 0
	subi	x2, x2, 7	# create_array 1 0
	lw	x1, 6(x2)	# create_array 1 0
	addi	x4, x4, 0	# create_array 1 0
	sw	x4, 6(x2)	# create_float5x3array()
	# let m_nvectors = create_float5x3array()
	sw	x1, 7(x2)	# create_float5x3array()
	addi	x2, x2, 8	# create_float5x3array()
	jal	x0, -143	# create_float5x3array()
	subi	x2, x2, 8	# create_float5x3array()
	lw	x1, 7(x2)	# create_float5x3array()
	addi	x4, x4, 0	# create_float5x3array()
	addi	x31, x3, 0	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	addi	x3, x3, 8	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 7(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 6(x2)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 6(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 5(x2)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 5(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 4(x2)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 4(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 3(x2)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 3(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 2(x2)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 2(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 1(x2)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 1(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	lw	x4, 0(x2)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	sw	x4, 0(x31)	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	addi	x4, x31, 0	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
	jalr	x0, x1, 0	# m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors
# init_line_elements.2955:	# let rec init_line_elements line n = if n >= 0 then ( line.(n) <- create_pixel(); init_line_elements line (n-1) ) else line
	bge	x5, x0, 2	# if n >= 0 then ( line.(n) <- create_pixel(); init_line_elements line (n-1) ) else line
# blt:	line
	jalr	x0, x1, 0	# line
# bge:	line.(n) <- create_pixel(); init_line_elements line (n-1)
	sw	x5, 0(x2)	# create_pixel()
	sw	x4, 1(x2)	# create_pixel()
	sw	x1, 2(x2)	# create_pixel()
	addi	x2, x2, 3	# create_pixel()
	jal	x0, -102	# create_pixel()
	subi	x2, x2, 3	# create_pixel()
	lw	x1, 2(x2)	# create_pixel()
	addi	x4, x4, 0	# create_pixel()
	lw	x5, 0(x2)	# line.(n) <- create_pixel()
	lw	x6, 1(x2)	# line.(n) <- create_pixel()
	swa	x4, (x6, x5)	# line.(n) <- create_pixel()
	addi	x5, x5, -1	# n-1
	addi	x4, x6, 0	# init_line_elements line (n-1)
	jal	x0, -15	# init_line_elements line (n-1)
# create_pixelline.2958:	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	lw	x4, 4(x29)	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	lw	x5, 0(x4)	# image_size.(0)
	sw	x4, 0(x2)	# create_pixel()
	sw	x5, 1(x2)	# create_pixel()
	sw	x1, 2(x2)	# create_pixel()
	addi	x2, x2, 3	# create_pixel()
	jal	x0, -118	# create_pixel()
	subi	x2, x2, 3	# create_pixel()
	lw	x1, 2(x2)	# create_pixel()
	addi	x5, x4, 0	# create_pixel()
	lw	x4, 1(x2)	# create_array image_size.(0) (create_pixel())
	# let line = create_array image_size.(0) (create_pixel())
	sw	x1, 2(x2)	# create_array image_size.(0) (create_pixel())
	addi	x2, x2, 3	# create_array image_size.(0) (create_pixel())
	auipc	x31, -2	# create_array image_size.(0) (create_pixel())
	jalr	x0, x31, -7433	# create_array image_size.(0) (create_pixel())
	subi	x2, x2, 3	# create_array image_size.(0) (create_pixel())
	lw	x1, 2(x2)	# create_array image_size.(0) (create_pixel())
	addi	x4, x4, 0	# create_array image_size.(0) (create_pixel())
	lw	x5, 0(x2)	# image_size.(0)
	lw	x5, 0(x5)	# image_size.(0)
	addi	x5, x5, -2	# image_size.(0)-2
	jal	x0, -37	# init_line_elements line (image_size.(0)-2)
# adjust_position.2960:	# let rec adjust_position h ratio = let l = sqrt(h*.h +. 0.1) in let tan_h = 1.0 /. l in let theta_h = atan tan_h in let tan_m = tan (theta_h *. ratio) in tan_m *. l
	fmul	f1, f1, f1	# h*.h
	fadd	f1, f1, f21	# h*.h +. 0.1
	# let l = sqrt(h*.h +. 0.1)
	fsqrt	f1, f1	# sqrt(h*.h +. 0.1)
	# let tan_h = 1.0 /. l
	fdiv	f3, f11, f1	# 1.0 /. l
	# let theta_h = atan tan_h
	atan	f3, f3	# atan tan_h
	fmul	f2, f3, f2	# theta_h *. ratio
	# let tan_m = tan (theta_h *. ratio)
	sin	f2, f2	# tan (theta_h *. ratio)
	fmul	f1, f2, f1	# tan_m *. l
	jalr	x0, x1, 0	# tan_m *. l
# calc_dirvec.2963:	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x7, 4(x29)	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	addi	x8, x0, 5	# 5
	bge	x4, x8, 35	# if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
# blt:	let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	fsw	f3, 0(x2)	# adjust_position y rx
	sw	x6, 1(x2)	# adjust_position y rx
	sw	x5, 2(x2)	# adjust_position y rx
	sw	x29, 3(x2)	# adjust_position y rx
	fsw	f4, 4(x2)	# adjust_position y rx
	sw	x4, 5(x2)	# adjust_position y rx
	# let x2 = adjust_position y rx
	fmv	f1, f2	# adjust_position y rx
	fmv	f2, f3	# adjust_position y rx
	sw	x1, 6(x2)	# adjust_position y rx
	addi	x2, x2, 7	# adjust_position y rx
	jal	x0, -23	# adjust_position y rx
	subi	x2, x2, 7	# adjust_position y rx
	lw	x1, 6(x2)	# adjust_position y rx
	fmr	f1, f1	# adjust_position y rx
	lw	x4, 5(x2)	# icount + 1
	addi	x4, x4, 1	# icount + 1
	flw	f2, 4(x2)	# adjust_position x2 ry
	fsw	f1, 6(x2)	# adjust_position x2 ry
	sw	x4, 7(x2)	# adjust_position x2 ry
	sw	x1, 8(x2)	# adjust_position x2 ry
	addi	x2, x2, 9	# adjust_position x2 ry
	jal	x0, -36	# adjust_position x2 ry
	subi	x2, x2, 9	# adjust_position x2 ry
	lw	x1, 8(x2)	# adjust_position x2 ry
	fmr	f2, f1	# adjust_position x2 ry
	flw	f1, 6(x2)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	flw	f3, 0(x2)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	flw	f4, 4(x2)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x4, 7(x2)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x5, 2(x2)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x6, 1(x2)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x29, 3(x2)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lw	x31, 0(x29)	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	jalr	x0, x31, 0	# calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
# bge:	let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
	fmul	f3, f1, f1	# fsqr x
	fmul	f4, f2, f2	# fsqr y
	fadd	f3, f3, f4	# fsqr x +. fsqr y
	fadd	f3, f3, f11	# fsqr x +. fsqr y +. 1.0
	# let l = sqrt(fsqr x +. fsqr y +. 1.0)
	fsqrt	f3, f3	# sqrt(fsqr x +. fsqr y +. 1.0)
	# let vx = x /. l
	fdiv	f1, f1, f3	# x /. l
	# let vy = y /. l
	fdiv	f2, f2, f3	# y /. l
	# let vz = 1.0 /. l
	fdiv	f3, f11, f3	# 1.0 /. l
	# let dgroup = dirvecs.(group_id)
	lwa	x4, (x7, x5)	# dirvecs.(group_id)
	lwa	x5, (x4, x6)	# dgroup.(index)
	sw	x4, 8(x2)	# d_vec dgroup.(index)
	sw	x6, 1(x2)	# d_vec dgroup.(index)
	fsw	f3, 9(x2)	# d_vec dgroup.(index)
	fsw	f2, 10(x2)	# d_vec dgroup.(index)
	fsw	f1, 11(x2)	# d_vec dgroup.(index)
	addi	x4, x5, 0	# d_vec dgroup.(index)
	sw	x1, 12(x2)	# d_vec dgroup.(index)
	addi	x2, x2, 13	# d_vec dgroup.(index)
	auipc	x31, -2	# d_vec dgroup.(index)
	jalr	x0, x31, -6266	# d_vec dgroup.(index)
	subi	x2, x2, 13	# d_vec dgroup.(index)
	lw	x1, 12(x2)	# d_vec dgroup.(index)
	addi	x4, x4, 0	# d_vec dgroup.(index)
	flw	f1, 11(x2)	# vecset (d_vec dgroup.(index)) vx vy vz
	flw	f2, 10(x2)	# vecset (d_vec dgroup.(index)) vx vy vz
	flw	f3, 9(x2)	# vecset (d_vec dgroup.(index)) vx vy vz
	sw	x1, 12(x2)	# vecset (d_vec dgroup.(index)) vx vy vz
	addi	x2, x2, 13	# vecset (d_vec dgroup.(index)) vx vy vz
	auipc	x31, -2	# vecset (d_vec dgroup.(index)) vx vy vz
	jalr	x0, x31, -6484	# vecset (d_vec dgroup.(index)) vx vy vz
	subi	x2, x2, 13	# vecset (d_vec dgroup.(index)) vx vy vz
	lw	x1, 12(x2)	# vecset (d_vec dgroup.(index)) vx vy vz
	addi	x0, x4, 0	# vecset (d_vec dgroup.(index)) vx vy vz
	lw	x4, 1(x2)	# index+40
	addi	x5, x4, 40	# index+40
	lw	x6, 8(x2)	# dgroup.(index+40)
	lwa	x5, (x6, x5)	# dgroup.(index+40)
	addi	x4, x5, 0	# d_vec dgroup.(index+40)
	sw	x1, 12(x2)	# d_vec dgroup.(index+40)
	addi	x2, x2, 13	# d_vec dgroup.(index+40)
	auipc	x31, -2	# d_vec dgroup.(index+40)
	jalr	x0, x31, -6288	# d_vec dgroup.(index+40)
	subi	x2, x2, 13	# d_vec dgroup.(index+40)
	lw	x1, 12(x2)	# d_vec dgroup.(index+40)
	addi	x4, x4, 0	# d_vec dgroup.(index+40)
	flw	f1, 10(x2)	# fneg vy
	fneg	f3, f1	# fneg vy
	flw	f2, 11(x2)	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	flw	f4, 9(x2)	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	fmv	f1, f2	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	fmv	f2, f4	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	sw	x1, 12(x2)	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	addi	x2, x2, 13	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	auipc	x31, -2	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	jalr	x0, x31, -6507	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	subi	x2, x2, 13	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	lw	x1, 12(x2)	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	addi	x0, x4, 0	# vecset (d_vec dgroup.(index+40)) vx vz (fneg vy)
	lw	x4, 1(x2)	# index+80
	addi	x5, x4, 80	# index+80
	lw	x6, 8(x2)	# dgroup.(index+80)
	lwa	x5, (x6, x5)	# dgroup.(index+80)
	addi	x4, x5, 0	# d_vec dgroup.(index+80)
	sw	x1, 12(x2)	# d_vec dgroup.(index+80)
	addi	x2, x2, 13	# d_vec dgroup.(index+80)
	auipc	x31, -2	# d_vec dgroup.(index+80)
	jalr	x0, x31, -6313	# d_vec dgroup.(index+80)
	subi	x2, x2, 13	# d_vec dgroup.(index+80)
	lw	x1, 12(x2)	# d_vec dgroup.(index+80)
	addi	x4, x4, 0	# d_vec dgroup.(index+80)
	flw	f1, 11(x2)	# fneg vx
	fneg	f2, f1	# fneg vx
	flw	f3, 10(x2)	# fneg vy
	fneg	f4, f3	# fneg vy
	flw	f5, 9(x2)	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	fmv	f3, f4	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	fmv	f1, f5	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	sw	x1, 12(x2)	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	addi	x2, x2, 13	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	auipc	x31, -2	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	jalr	x0, x31, -6533	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	subi	x2, x2, 13	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	lw	x1, 12(x2)	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	addi	x0, x4, 0	# vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy)
	lw	x4, 1(x2)	# index+1
	addi	x5, x4, 1	# index+1
	lw	x6, 8(x2)	# dgroup.(index+1)
	lwa	x5, (x6, x5)	# dgroup.(index+1)
	addi	x4, x5, 0	# d_vec dgroup.(index+1)
	sw	x1, 12(x2)	# d_vec dgroup.(index+1)
	addi	x2, x2, 13	# d_vec dgroup.(index+1)
	auipc	x31, -2	# d_vec dgroup.(index+1)
	jalr	x0, x31, -6339	# d_vec dgroup.(index+1)
	subi	x2, x2, 13	# d_vec dgroup.(index+1)
	lw	x1, 12(x2)	# d_vec dgroup.(index+1)
	addi	x4, x4, 0	# d_vec dgroup.(index+1)
	flw	f1, 11(x2)	# fneg vx
	fneg	f2, f1	# fneg vx
	flw	f3, 10(x2)	# fneg vy
	fneg	f4, f3	# fneg vy
	flw	f5, 9(x2)	# fneg vz
	fneg	f6, f5	# fneg vz
	fmv	f3, f6	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	fmv	f1, f2	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	fmv	f2, f4	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	sw	x1, 12(x2)	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	addi	x2, x2, 13	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	auipc	x31, -2	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	jalr	x0, x31, -6560	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	subi	x2, x2, 13	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	lw	x1, 12(x2)	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	addi	x0, x4, 0	# vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz)
	lw	x4, 1(x2)	# index+41
	addi	x5, x4, 41	# index+41
	lw	x6, 8(x2)	# dgroup.(index+41)
	lwa	x5, (x6, x5)	# dgroup.(index+41)
	addi	x4, x5, 0	# d_vec dgroup.(index+41)
	sw	x1, 12(x2)	# d_vec dgroup.(index+41)
	addi	x2, x2, 13	# d_vec dgroup.(index+41)
	auipc	x31, -2	# d_vec dgroup.(index+41)
	jalr	x0, x31, -6367	# d_vec dgroup.(index+41)
	subi	x2, x2, 13	# d_vec dgroup.(index+41)
	lw	x1, 12(x2)	# d_vec dgroup.(index+41)
	addi	x4, x4, 0	# d_vec dgroup.(index+41)
	flw	f1, 11(x2)	# fneg vx
	fneg	f2, f1	# fneg vx
	flw	f3, 9(x2)	# fneg vz
	fneg	f4, f3	# fneg vz
	flw	f5, 10(x2)	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	fmv	f3, f5	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	fmv	f1, f2	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	fmv	f2, f4	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	sw	x1, 12(x2)	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	addi	x2, x2, 13	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	auipc	x31, -2	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	jalr	x0, x31, -6587	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	subi	x2, x2, 13	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	lw	x1, 12(x2)	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	addi	x0, x4, 0	# vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy
	lw	x4, 1(x2)	# index+81
	addi	x4, x4, 81	# index+81
	lw	x5, 8(x2)	# dgroup.(index+81)
	lwa	x4, (x5, x4)	# dgroup.(index+81)
	sw	x1, 12(x2)	# d_vec dgroup.(index+81)
	addi	x2, x2, 13	# d_vec dgroup.(index+81)
	auipc	x31, -2	# d_vec dgroup.(index+81)
	jalr	x0, x31, -6394	# d_vec dgroup.(index+81)
	subi	x2, x2, 13	# d_vec dgroup.(index+81)
	lw	x1, 12(x2)	# d_vec dgroup.(index+81)
	addi	x4, x4, 0	# d_vec dgroup.(index+81)
	flw	f1, 9(x2)	# fneg vz
	fneg	f1, f1	# fneg vz
	flw	f2, 11(x2)	# vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
	flw	f3, 10(x2)	# vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
	auipc	x31, -2	# vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
	jalr	x0, x31, -6607	# vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy
# calc_dirvecs.2971:	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	lw	x7, 4(x29)	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	bge	x4, x0, 2	# if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	itof	f2, x4	# float_of_int col
	fmul	f2, f2, f22	# (float_of_int col) *. 0.2
	lui	x31, 259686	# 0.9
	addi	x31, x31, 1063675494	# 0.9
	mvitof	f3, x31	# 0.9
	# let rx = (float_of_int col) *. 0.2 -. 0.9
	fsub	f3, f2, f3	# (float_of_int col) *. 0.2 -. 0.9
	addi	x8, x0, 0	# 0
	addi	x31, x0, 0	# 0.0
	mvitof	f2, x31	# 0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f4, x31	# 0.0
	sw	x29, 0(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	fsw	f1, 1(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x5, 2(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x7, 3(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x6, 4(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x4, 5(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x4, x8, 0	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x29, x7, 0	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f31, f4	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f4, f1	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f1, f2	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	fmv	f2, f31	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	sw	x1, 6(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x2, x2, 7	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	lw	x31, 0(x29)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	jalr	x1, x31, 0	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	subi	x2, x2, 7	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	lw	x1, 6(x2)	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	addi	x0, x4, 0	# calc_dirvec 0 0.0 0.0 rx ry group_id index
	lw	x4, 5(x2)	# float_of_int col
	itof	f1, x4	# float_of_int col
	fmul	f1, f1, f22	# (float_of_int col) *. 0.2
	# let rx2 = (float_of_int col) *. 0.2 +. 0.1
	fadd	f3, f1, f21	# (float_of_int col) *. 0.2 +. 0.1
	addi	x5, x0, 0	# 0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	addi	x31, x0, 0	# 0.0
	mvitof	f2, x31	# 0.0
	lw	x6, 4(x2)	# index + 2
	addi	x7, x6, 2	# index + 2
	flw	f4, 1(x2)	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x8, 2(x2)	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x29, 3(x2)	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x6, x7, 0	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x4, x5, 0	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x5, x8, 0	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	sw	x1, 6(x2)	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x2, x2, 7	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x31, 0(x29)	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	jalr	x1, x31, 0	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	subi	x2, x2, 7	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x1, 6(x2)	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	addi	x0, x4, 0	# calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2)
	lw	x4, 5(x2)	# col - 1
	addi	x4, x4, -1	# col - 1
	addi	x5, x0, 1	# 1
	lw	x6, 2(x2)	# add_mod5 group_id 1
	sw	x4, 6(x2)	# add_mod5 group_id 1
	addi	x4, x6, 0	# add_mod5 group_id 1
	sw	x1, 7(x2)	# add_mod5 group_id 1
	addi	x2, x2, 8	# add_mod5 group_id 1
	auipc	x31, -2	# add_mod5 group_id 1
	jalr	x0, x31, -6682	# add_mod5 group_id 1
	subi	x2, x2, 8	# add_mod5 group_id 1
	lw	x1, 7(x2)	# add_mod5 group_id 1
	addi	x5, x4, 0	# add_mod5 group_id 1
	flw	f1, 1(x2)	# calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	lw	x4, 6(x2)	# calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	lw	x6, 4(x2)	# calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	lw	x29, 0(x2)	# calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	lw	x31, 0(x29)	# calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
	jalr	x0, x31, 0	# calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index
# calc_dirvec_rows.2976:	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	lw	x7, 4(x29)	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	bge	x4, x0, 2	# if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
	itof	f1, x4	# float_of_int row
	fmul	f1, f1, f22	# (float_of_int row) *. 0.2
	lui	x31, 259686	# 0.9
	addi	x31, x31, 1063675494	# 0.9
	mvitof	f2, x31	# 0.9
	# let ry = (float_of_int row) *. 0.2 -. 0.9
	fsub	f1, f1, f2	# (float_of_int row) *. 0.2 -. 0.9
	addi	x8, x0, 4	# 4
	sw	x29, 0(x2)	# calc_dirvecs 4 ry group_id index
	sw	x6, 1(x2)	# calc_dirvecs 4 ry group_id index
	sw	x5, 2(x2)	# calc_dirvecs 4 ry group_id index
	sw	x4, 3(x2)	# calc_dirvecs 4 ry group_id index
	addi	x4, x8, 0	# calc_dirvecs 4 ry group_id index
	addi	x29, x7, 0	# calc_dirvecs 4 ry group_id index
	sw	x1, 4(x2)	# calc_dirvecs 4 ry group_id index
	addi	x2, x2, 5	# calc_dirvecs 4 ry group_id index
	lw	x31, 0(x29)	# calc_dirvecs 4 ry group_id index
	jalr	x1, x31, 0	# calc_dirvecs 4 ry group_id index
	subi	x2, x2, 5	# calc_dirvecs 4 ry group_id index
	lw	x1, 4(x2)	# calc_dirvecs 4 ry group_id index
	addi	x0, x4, 0	# calc_dirvecs 4 ry group_id index
	lw	x4, 3(x2)	# row - 1
	addi	x4, x4, -1	# row - 1
	addi	x5, x0, 2	# 2
	lw	x6, 2(x2)	# add_mod5 group_id 2
	sw	x4, 4(x2)	# add_mod5 group_id 2
	addi	x4, x6, 0	# add_mod5 group_id 2
	sw	x1, 5(x2)	# add_mod5 group_id 2
	addi	x2, x2, 6	# add_mod5 group_id 2
	auipc	x31, -2	# add_mod5 group_id 2
	jalr	x0, x31, -6724	# add_mod5 group_id 2
	subi	x2, x2, 6	# add_mod5 group_id 2
	lw	x1, 5(x2)	# add_mod5 group_id 2
	addi	x5, x4, 0	# add_mod5 group_id 2
	lw	x4, 1(x2)	# index + 4
	addi	x6, x4, 4	# index + 4
	lw	x4, 4(x2)	# calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
	lw	x29, 0(x2)	# calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
	lw	x31, 0(x29)	# calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
	jalr	x0, x31, 0	# calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4)
# create_dirvec.2980:	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	lw	x4, 4(x29)	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 0(x2)	# create_array 3 0.0
	# let v3 = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 1(x2)	# create_array 3 0.0
	addi	x2, x2, 2	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -7269	# create_array 3 0.0
	subi	x2, x2, 2	# create_array 3 0.0
	lw	x1, 1(x2)	# create_array 3 0.0
	addi	x5, x4, 0	# create_array 3 0.0
	lw	x4, 0(x2)	# n_objects.(0)
	lw	x4, 0(x4)	# n_objects.(0)
	sw	x5, 1(x2)	# create_array n_objects.(0) v3
	# let consts = create_array n_objects.(0) v3
	sw	x1, 2(x2)	# create_array n_objects.(0) v3
	addi	x2, x2, 3	# create_array n_objects.(0) v3
	auipc	x31, -2	# create_array n_objects.(0) v3
	jalr	x0, x31, -7780	# create_array n_objects.(0) v3
	subi	x2, x2, 3	# create_array n_objects.(0) v3
	lw	x1, 2(x2)	# create_array n_objects.(0) v3
	addi	x4, x4, 0	# create_array n_objects.(0) v3
	addi	x31, x3, 0	# v3, consts
	addi	x3, x3, 2	# v3, consts
	sw	x4, 1(x31)	# v3, consts
	lw	x4, 1(x2)	# v3, consts
	sw	x4, 0(x31)	# v3, consts
	addi	x4, x31, 0	# v3, consts
	jalr	x0, x1, 0	# v3, consts
# create_dirvec_elements.2982:	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	lw	x6, 4(x29)	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	bge	x5, x0, 2	# if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1)
	sw	x29, 0(x2)	# create_dirvec()
	sw	x5, 1(x2)	# create_dirvec()
	sw	x4, 2(x2)	# create_dirvec()
	addi	x29, x6, 0	# create_dirvec()
	sw	x1, 3(x2)	# create_dirvec()
	addi	x2, x2, 4	# create_dirvec()
	lw	x31, 0(x29)	# create_dirvec()
	jalr	x1, x31, 0	# create_dirvec()
	subi	x2, x2, 4	# create_dirvec()
	lw	x1, 3(x2)	# create_dirvec()
	addi	x4, x4, 0	# create_dirvec()
	lw	x5, 1(x2)	# d.(index) <- create_dirvec()
	lw	x6, 2(x2)	# d.(index) <- create_dirvec()
	swa	x4, (x6, x5)	# d.(index) <- create_dirvec()
	addi	x5, x5, -1	# index - 1
	lw	x29, 0(x2)	# create_dirvec_elements d (index - 1)
	addi	x4, x6, 0	# create_dirvec_elements d (index - 1)
	lw	x31, 0(x29)	# create_dirvec_elements d (index - 1)
	jalr	x0, x31, 0	# create_dirvec_elements d (index - 1)
# create_dirvecs.2985:	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	lw	x5, 6(x29)	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	lw	x6, 5(x29)	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	lw	x7, 4(x29)	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	bge	x4, x0, 2	# if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1)
	addi	x8, x0, 120	# 120
	sw	x29, 0(x2)	# create_dirvec()
	sw	x6, 1(x2)	# create_dirvec()
	sw	x4, 2(x2)	# create_dirvec()
	sw	x5, 3(x2)	# create_dirvec()
	sw	x8, 4(x2)	# create_dirvec()
	addi	x29, x7, 0	# create_dirvec()
	sw	x1, 5(x2)	# create_dirvec()
	addi	x2, x2, 6	# create_dirvec()
	lw	x31, 0(x29)	# create_dirvec()
	jalr	x1, x31, 0	# create_dirvec()
	subi	x2, x2, 6	# create_dirvec()
	lw	x1, 5(x2)	# create_dirvec()
	addi	x5, x4, 0	# create_dirvec()
	lw	x4, 4(x2)	# create_array 120 (create_dirvec())
	sw	x1, 5(x2)	# create_array 120 (create_dirvec())
	addi	x2, x2, 6	# create_array 120 (create_dirvec())
	auipc	x31, -2	# create_array 120 (create_dirvec())
	jalr	x0, x31, -7836	# create_array 120 (create_dirvec())
	subi	x2, x2, 6	# create_array 120 (create_dirvec())
	lw	x1, 5(x2)	# create_array 120 (create_dirvec())
	addi	x4, x4, 0	# create_array 120 (create_dirvec())
	lw	x5, 2(x2)	# dirvecs.(index) <- create_array 120 (create_dirvec())
	lw	x6, 3(x2)	# dirvecs.(index) <- create_array 120 (create_dirvec())
	swa	x4, (x6, x5)	# dirvecs.(index) <- create_array 120 (create_dirvec())
	lwa	x4, (x6, x5)	# dirvecs.(index)
	addi	x6, x0, 118	# 118
	lw	x29, 1(x2)	# create_dirvec_elements dirvecs.(index) 118
	addi	x5, x6, 0	# create_dirvec_elements dirvecs.(index) 118
	sw	x1, 5(x2)	# create_dirvec_elements dirvecs.(index) 118
	addi	x2, x2, 6	# create_dirvec_elements dirvecs.(index) 118
	lw	x31, 0(x29)	# create_dirvec_elements dirvecs.(index) 118
	jalr	x1, x31, 0	# create_dirvec_elements dirvecs.(index) 118
	subi	x2, x2, 6	# create_dirvec_elements dirvecs.(index) 118
	lw	x1, 5(x2)	# create_dirvec_elements dirvecs.(index) 118
	addi	x0, x4, 0	# create_dirvec_elements dirvecs.(index) 118
	lw	x4, 2(x2)	# index-1
	addi	x4, x4, -1	# index-1
	lw	x29, 0(x2)	# create_dirvecs (index-1)
	lw	x31, 0(x29)	# create_dirvecs (index-1)
	jalr	x0, x31, 0	# create_dirvecs (index-1)
# init_dirvec_constants.2987:	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	lw	x6, 4(x29)	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	bge	x5, x0, 2	# if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1)
	lwa	x7, (x4, x5)	# vecset.(index)
	sw	x4, 0(x2)	# setup_dirvec_constants vecset.(index)
	sw	x29, 1(x2)	# setup_dirvec_constants vecset.(index)
	sw	x5, 2(x2)	# setup_dirvec_constants vecset.(index)
	addi	x4, x7, 0	# setup_dirvec_constants vecset.(index)
	addi	x29, x6, 0	# setup_dirvec_constants vecset.(index)
	sw	x1, 3(x2)	# setup_dirvec_constants vecset.(index)
	addi	x2, x2, 4	# setup_dirvec_constants vecset.(index)
	lw	x31, 0(x29)	# setup_dirvec_constants vecset.(index)
	jalr	x1, x31, 0	# setup_dirvec_constants vecset.(index)
	subi	x2, x2, 4	# setup_dirvec_constants vecset.(index)
	lw	x1, 3(x2)	# setup_dirvec_constants vecset.(index)
	addi	x0, x4, 0	# setup_dirvec_constants vecset.(index)
	lw	x4, 2(x2)	# index - 1
	addi	x5, x4, -1	# index - 1
	lw	x4, 0(x2)	# init_dirvec_constants vecset (index - 1)
	lw	x29, 1(x2)	# init_dirvec_constants vecset (index - 1)
	lw	x31, 0(x29)	# init_dirvec_constants vecset (index - 1)
	jalr	x0, x31, 0	# init_dirvec_constants vecset (index - 1)
# init_vecset_constants.2990:	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	lw	x5, 5(x29)	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	lw	x6, 4(x29)	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	bge	x4, x0, 2	# if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1)
	lwa	x6, (x6, x4)	# dirvecs.(index)
	addi	x7, x0, 119	# 119
	sw	x29, 0(x2)	# init_dirvec_constants dirvecs.(index) 119
	sw	x4, 1(x2)	# init_dirvec_constants dirvecs.(index) 119
	addi	x4, x6, 0	# init_dirvec_constants dirvecs.(index) 119
	addi	x29, x5, 0	# init_dirvec_constants dirvecs.(index) 119
	addi	x5, x7, 0	# init_dirvec_constants dirvecs.(index) 119
	sw	x1, 2(x2)	# init_dirvec_constants dirvecs.(index) 119
	addi	x2, x2, 3	# init_dirvec_constants dirvecs.(index) 119
	lw	x31, 0(x29)	# init_dirvec_constants dirvecs.(index) 119
	jalr	x1, x31, 0	# init_dirvec_constants dirvecs.(index) 119
	subi	x2, x2, 3	# init_dirvec_constants dirvecs.(index) 119
	lw	x1, 2(x2)	# init_dirvec_constants dirvecs.(index) 119
	addi	x0, x4, 0	# init_dirvec_constants dirvecs.(index) 119
	lw	x4, 1(x2)	# index - 1
	addi	x4, x4, -1	# index - 1
	lw	x29, 0(x2)	# init_vecset_constants (index - 1)
	lw	x31, 0(x29)	# init_vecset_constants (index - 1)
	jalr	x0, x31, 0	# init_vecset_constants (index - 1)
# init_dirvecs.2992:	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	lw	x4, 6(x29)	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	lw	x5, 5(x29)	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	lw	x6, 4(x29)	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	addi	x7, x0, 4	# 4
	sw	x4, 0(x2)	# create_dirvecs 4
	sw	x6, 1(x2)	# create_dirvecs 4
	addi	x4, x7, 0	# create_dirvecs 4
	addi	x29, x5, 0	# create_dirvecs 4
	sw	x1, 2(x2)	# create_dirvecs 4
	addi	x2, x2, 3	# create_dirvecs 4
	lw	x31, 0(x29)	# create_dirvecs 4
	jalr	x1, x31, 0	# create_dirvecs 4
	subi	x2, x2, 3	# create_dirvecs 4
	lw	x1, 2(x2)	# create_dirvecs 4
	addi	x0, x4, 0	# create_dirvecs 4
	addi	x4, x0, 9	# 9
	addi	x5, x0, 0	# 0
	addi	x6, x0, 0	# 0
	lw	x29, 1(x2)	# calc_dirvec_rows 9 0 0
	sw	x1, 2(x2)	# calc_dirvec_rows 9 0 0
	addi	x2, x2, 3	# calc_dirvec_rows 9 0 0
	lw	x31, 0(x29)	# calc_dirvec_rows 9 0 0
	jalr	x1, x31, 0	# calc_dirvec_rows 9 0 0
	subi	x2, x2, 3	# calc_dirvec_rows 9 0 0
	lw	x1, 2(x2)	# calc_dirvec_rows 9 0 0
	addi	x0, x4, 0	# calc_dirvec_rows 9 0 0
	addi	x4, x0, 4	# 4
	lw	x29, 0(x2)	# init_vecset_constants 4
	lw	x31, 0(x29)	# init_vecset_constants 4
	jalr	x0, x31, 0	# init_vecset_constants 4
# add_reflection.2994:	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	lw	x6, 6(x29)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	lw	x7, 5(x29)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	lw	x29, 4(x29)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	sw	x4, 0(x2)	# create_dirvec()
	sw	x7, 1(x2)	# create_dirvec()
	sw	x5, 2(x2)	# create_dirvec()
	fsw	f1, 3(x2)	# create_dirvec()
	sw	x6, 4(x2)	# create_dirvec()
	fsw	f4, 5(x2)	# create_dirvec()
	fsw	f3, 6(x2)	# create_dirvec()
	fsw	f2, 7(x2)	# create_dirvec()
	# let dvec = create_dirvec()
	sw	x1, 8(x2)	# create_dirvec()
	addi	x2, x2, 9	# create_dirvec()
	lw	x31, 0(x29)	# create_dirvec()
	jalr	x1, x31, 0	# create_dirvec()
	subi	x2, x2, 9	# create_dirvec()
	lw	x1, 8(x2)	# create_dirvec()
	addi	x4, x4, 0	# create_dirvec()
	sw	x4, 8(x2)	# d_vec dvec
	sw	x1, 9(x2)	# d_vec dvec
	addi	x2, x2, 10	# d_vec dvec
	auipc	x31, -2	# d_vec dvec
	jalr	x0, x31, -6717	# d_vec dvec
	subi	x2, x2, 10	# d_vec dvec
	lw	x1, 9(x2)	# d_vec dvec
	addi	x4, x4, 0	# d_vec dvec
	flw	f1, 7(x2)	# vecset (d_vec dvec) v0 v1 v2
	flw	f2, 6(x2)	# vecset (d_vec dvec) v0 v1 v2
	flw	f3, 5(x2)	# vecset (d_vec dvec) v0 v1 v2
	sw	x1, 9(x2)	# vecset (d_vec dvec) v0 v1 v2
	addi	x2, x2, 10	# vecset (d_vec dvec) v0 v1 v2
	auipc	x31, -2	# vecset (d_vec dvec) v0 v1 v2
	jalr	x0, x31, -6934	# vecset (d_vec dvec) v0 v1 v2
	subi	x2, x2, 10	# vecset (d_vec dvec) v0 v1 v2
	lw	x1, 9(x2)	# vecset (d_vec dvec) v0 v1 v2
	addi	x0, x4, 0	# vecset (d_vec dvec) v0 v1 v2
	lw	x4, 8(x2)	# setup_dirvec_constants dvec
	lw	x29, 4(x2)	# setup_dirvec_constants dvec
	sw	x1, 9(x2)	# setup_dirvec_constants dvec
	addi	x2, x2, 10	# setup_dirvec_constants dvec
	lw	x31, 0(x29)	# setup_dirvec_constants dvec
	jalr	x1, x31, 0	# setup_dirvec_constants dvec
	subi	x2, x2, 10	# setup_dirvec_constants dvec
	lw	x1, 9(x2)	# setup_dirvec_constants dvec
	addi	x0, x4, 0	# setup_dirvec_constants dvec
	addi	x31, x3, 0	# surface_id, dvec, bright
	addi	x3, x3, 3	# surface_id, dvec, bright
	flw	f1, 3(x2)	# surface_id, dvec, bright
	fsw	f1, 2(x31)	# surface_id, dvec, bright
	lw	x4, 8(x2)	# surface_id, dvec, bright
	sw	x4, 1(x31)	# surface_id, dvec, bright
	lw	x4, 2(x2)	# surface_id, dvec, bright
	sw	x4, 0(x31)	# surface_id, dvec, bright
	addi	x4, x31, 0	# surface_id, dvec, bright
	lw	x5, 0(x2)	# reflections.(index) <- (surface_id, dvec, bright)
	lw	x6, 1(x2)	# reflections.(index) <- (surface_id, dvec, bright)
	swa	x4, (x6, x5)	# reflections.(index) <- (surface_id, dvec, bright)
	jalr x0, x1, 0	# reflections.(index) <- (surface_id, dvec, bright)
# setup_rect_reflection.3001:	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	lw	x6, 6(x29)	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	lw	x7, 5(x29)	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	lw	x8, 4(x29)	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	# let sid = obj_id * 4
	slli	x4, x4, 2	# obj_id * 4
	# let nr = n_reflections.(0)
	lw	x9, 0(x6)	# n_reflections.(0)
	sw	x6, 0(x2)	# o_diffuse obj
	sw	x9, 1(x2)	# o_diffuse obj
	sw	x8, 2(x2)	# o_diffuse obj
	sw	x4, 3(x2)	# o_diffuse obj
	sw	x7, 4(x2)	# o_diffuse obj
	addi	x4, x5, 0	# o_diffuse obj
	sw	x1, 5(x2)	# o_diffuse obj
	addi	x2, x2, 6	# o_diffuse obj
	auipc	x31, -2	# o_diffuse obj
	jalr	x0, x31, -6812	# o_diffuse obj
	subi	x2, x2, 6	# o_diffuse obj
	lw	x1, 5(x2)	# o_diffuse obj
	fmr	f1, f1	# o_diffuse obj
	# let br = 1.0 -. o_diffuse obj
	fsub	f1, f11, f1	# 1.0 -. o_diffuse obj
	lw	x4, 4(x2)	# light.(0)
	flw	f2, 0(x4)	# light.(0)
	# let n0 = fneg light.(0)
	fneg	f2, f2	# fneg light.(0)
	flw	f3, 1(x4)	# light.(1)
	# let n1 = fneg light.(1)
	fneg	f3, f3	# fneg light.(1)
	flw	f4, 2(x4)	# light.(2)
	# let n2 = fneg light.(2)
	fneg	f4, f4	# fneg light.(2)
	lw	x5, 3(x2)	# sid+1
	addi	x6, x5, 1	# sid+1
	flw	f5, 0(x4)	# light.(0)
	lw	x7, 1(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	lw	x29, 2(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f3, 5(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f4, 6(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f2, 7(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	fsw	f1, 8(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x5, x6, 0	# add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x4, x7, 0	# add_reflection nr (sid+1) br light.(0) n1 n2
	fmv	f2, f5	# add_reflection nr (sid+1) br light.(0) n1 n2
	sw	x1, 9(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x2, x2, 10	# add_reflection nr (sid+1) br light.(0) n1 n2
	lw	x31, 0(x29)	# add_reflection nr (sid+1) br light.(0) n1 n2
	jalr	x1, x31, 0	# add_reflection nr (sid+1) br light.(0) n1 n2
	subi	x2, x2, 10	# add_reflection nr (sid+1) br light.(0) n1 n2
	lw	x1, 9(x2)	# add_reflection nr (sid+1) br light.(0) n1 n2
	addi	x0, x4, 0	# add_reflection nr (sid+1) br light.(0) n1 n2
	lw	x4, 1(x2)	# nr+1
	addi	x5, x4, 1	# nr+1
	lw	x6, 3(x2)	# sid+2
	addi	x7, x6, 2	# sid+2
	lw	x8, 4(x2)	# light.(1)
	flw	f3, 1(x8)	# light.(1)
	flw	f1, 8(x2)	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	flw	f2, 7(x2)	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	flw	f4, 6(x2)	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	lw	x29, 2(x2)	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x4, x5, 0	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x5, x7, 0	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	sw	x1, 9(x2)	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x2, x2, 10	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	lw	x31, 0(x29)	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	jalr	x1, x31, 0	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	subi	x2, x2, 10	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	lw	x1, 9(x2)	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	addi	x0, x4, 0	# add_reflection (nr+1) (sid+2) br n0 light.(1) n2
	lw	x4, 1(x2)	# nr+2
	addi	x5, x4, 2	# nr+2
	lw	x6, 3(x2)	# sid+3
	addi	x6, x6, 3	# sid+3
	lw	x7, 4(x2)	# light.(2)
	flw	f4, 2(x7)	# light.(2)
	flw	f1, 8(x2)	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	flw	f2, 7(x2)	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	flw	f3, 5(x2)	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	lw	x29, 2(x2)	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x4, x5, 0	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x5, x6, 0	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	sw	x1, 9(x2)	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x2, x2, 10	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	lw	x31, 0(x29)	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	jalr	x1, x31, 0	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	subi	x2, x2, 10	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	lw	x1, 9(x2)	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	addi	x0, x4, 0	# add_reflection (nr+2) (sid+3) br n0 n1 light.(2)
	lw	x4, 1(x2)	# nr + 3
	addi	x4, x4, 3	# nr + 3
	lw	x5, 0(x2)	# n_reflections.(0) <- nr + 3
	sw	x4, 0(x5)	# n_reflections.(0) <- nr + 3
	jalr x0, x1, 0	# n_reflections.(0) <- nr + 3
# setup_surface_reflection.3004:	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	lw	x6, 6(x29)	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	lw	x7, 5(x29)	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	lw	x8, 4(x29)	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	slli	x4, x4, 2	# obj_id * 4
	# let sid = obj_id * 4 + 1
	addi	x4, x4, 1	# obj_id * 4 + 1
	# let nr = n_reflections.(0)
	lw	x9, 0(x6)	# n_reflections.(0)
	sw	x6, 0(x2)	# o_diffuse obj
	sw	x4, 1(x2)	# o_diffuse obj
	sw	x9, 2(x2)	# o_diffuse obj
	sw	x8, 3(x2)	# o_diffuse obj
	sw	x7, 4(x2)	# o_diffuse obj
	sw	x5, 5(x2)	# o_diffuse obj
	addi	x4, x5, 0	# o_diffuse obj
	sw	x1, 6(x2)	# o_diffuse obj
	addi	x2, x2, 7	# o_diffuse obj
	auipc	x31, -2	# o_diffuse obj
	jalr	x0, x31, -6902	# o_diffuse obj
	subi	x2, x2, 7	# o_diffuse obj
	lw	x1, 6(x2)	# o_diffuse obj
	fmr	f1, f1	# o_diffuse obj
	# let br = 1.0 -. o_diffuse obj
	fsub	f1, f11, f1	# 1.0 -. o_diffuse obj
	lw	x4, 5(x2)	# o_param_abc obj
	fsw	f1, 6(x2)	# o_param_abc obj
	sw	x1, 7(x2)	# o_param_abc obj
	addi	x2, x2, 8	# o_param_abc obj
	auipc	x31, -2	# o_param_abc obj
	jalr	x0, x31, -6924	# o_param_abc obj
	subi	x2, x2, 8	# o_param_abc obj
	lw	x1, 7(x2)	# o_param_abc obj
	addi	x5, x4, 0	# o_param_abc obj
	lw	x4, 4(x2)	# veciprod light (o_param_abc obj)
	# let p = veciprod light (o_param_abc obj)
	sw	x1, 7(x2)	# veciprod light (o_param_abc obj)
	addi	x2, x2, 8	# veciprod light (o_param_abc obj)
	auipc	x31, -2	# veciprod light (o_param_abc obj)
	jalr	x0, x31, -7030	# veciprod light (o_param_abc obj)
	subi	x2, x2, 8	# veciprod light (o_param_abc obj)
	lw	x1, 7(x2)	# veciprod light (o_param_abc obj)
	fmr	f1, f1	# veciprod light (o_param_abc obj)
	lw	x4, 5(x2)	# o_param_a obj
	fsw	f1, 7(x2)	# o_param_a obj
	sw	x1, 8(x2)	# o_param_a obj
	addi	x2, x2, 9	# o_param_a obj
	auipc	x31, -2	# o_param_a obj
	jalr	x0, x31, -6950	# o_param_a obj
	subi	x2, x2, 9	# o_param_a obj
	lw	x1, 8(x2)	# o_param_a obj
	fmr	f1, f1	# o_param_a obj
	fmul	f1, f12, f1	# 2.0 *. o_param_a obj
	flw	f2, 7(x2)	# 2.0 *. o_param_a obj *. p
	fmul	f1, f1, f2	# 2.0 *. o_param_a obj *. p
	lw	x4, 4(x2)	# light.(0)
	flw	f3, 0(x4)	# light.(0)
	fsub	f1, f1, f3	# 2.0 *. o_param_a obj *. p -. light.(0)
	lw	x5, 5(x2)	# o_param_b obj
	fsw	f1, 8(x2)	# o_param_b obj
	addi	x4, x5, 0	# o_param_b obj
	sw	x1, 9(x2)	# o_param_b obj
	addi	x2, x2, 10	# o_param_b obj
	auipc	x31, -2	# o_param_b obj
	jalr	x0, x31, -6962	# o_param_b obj
	subi	x2, x2, 10	# o_param_b obj
	lw	x1, 9(x2)	# o_param_b obj
	fmr	f1, f1	# o_param_b obj
	fmul	f1, f12, f1	# 2.0 *. o_param_b obj
	flw	f2, 7(x2)	# 2.0 *. o_param_b obj *. p
	fmul	f1, f1, f2	# 2.0 *. o_param_b obj *. p
	lw	x4, 4(x2)	# light.(1)
	flw	f3, 1(x4)	# light.(1)
	fsub	f1, f1, f3	# 2.0 *. o_param_b obj *. p -. light.(1)
	lw	x5, 5(x2)	# o_param_c obj
	fsw	f1, 9(x2)	# o_param_c obj
	addi	x4, x5, 0	# o_param_c obj
	sw	x1, 10(x2)	# o_param_c obj
	addi	x2, x2, 11	# o_param_c obj
	auipc	x31, -2	# o_param_c obj
	jalr	x0, x31, -6975	# o_param_c obj
	subi	x2, x2, 11	# o_param_c obj
	lw	x1, 10(x2)	# o_param_c obj
	fmr	f1, f1	# o_param_c obj
	fmul	f1, f12, f1	# 2.0 *. o_param_c obj
	flw	f2, 7(x2)	# 2.0 *. o_param_c obj *. p
	fmul	f1, f1, f2	# 2.0 *. o_param_c obj *. p
	lw	x4, 4(x2)	# light.(2)
	flw	f2, 2(x4)	# light.(2)
	fsub	f4, f1, f2	# 2.0 *. o_param_c obj *. p -. light.(2)
	flw	f1, 6(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	flw	f2, 8(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	flw	f3, 9(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x4, 2(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x5, 1(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x29, 3(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	sw	x1, 10(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	addi	x2, x2, 11	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x31, 0(x29)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	jalr	x1, x31, 0	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	subi	x2, x2, 11	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x1, 10(x2)	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	addi	x0, x4, 0	# add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2))
	lw	x4, 2(x2)	# nr + 1
	addi	x4, x4, 1	# nr + 1
	lw	x5, 0(x2)	# n_reflections.(0) <- nr + 1
	sw	x4, 0(x5)	# n_reflections.(0) <- nr + 1
	jalr x0, x1, 0	# n_reflections.(0) <- nr + 1
# setup_reflections.3007:	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	lw	x5, 6(x29)	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	lw	x6, 5(x29)	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	lw	x7, 4(x29)	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	bge	x4, x0, 2	# if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
# blt:	()
	jalr x0, x1, 0	# ()
# bge:	let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else ()
	# let obj = objects.(obj_id)
	lwa	x7, (x7, x4)	# objects.(obj_id)
	sw	x5, 0(x2)	# o_reflectiontype obj
	sw	x4, 1(x2)	# o_reflectiontype obj
	sw	x6, 2(x2)	# o_reflectiontype obj
	sw	x7, 3(x2)	# o_reflectiontype obj
	addi	x4, x7, 0	# o_reflectiontype obj
	sw	x1, 4(x2)	# o_reflectiontype obj
	addi	x2, x2, 5	# o_reflectiontype obj
	auipc	x31, -2	# o_reflectiontype obj
	jalr	x0, x31, -7029	# o_reflectiontype obj
	subi	x2, x2, 5	# o_reflectiontype obj
	lw	x1, 4(x2)	# o_reflectiontype obj
	addi	x4, x4, 0	# o_reflectiontype obj
	addi	x5, x0, 2	# 2
	bne	x4, x5, 35	# if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else ()
# beq:	if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else ()
	lw	x4, 3(x2)	# o_diffuse obj
	sw	x1, 4(x2)	# o_diffuse obj
	addi	x2, x2, 5	# o_diffuse obj
	auipc	x31, -2	# o_diffuse obj
	jalr	x0, x31, -7014	# o_diffuse obj
	subi	x2, x2, 5	# o_diffuse obj
	lw	x1, 4(x2)	# o_diffuse obj
	fmr	f1, f1	# o_diffuse obj
	flt	x4, f11, f11	# fless (o_diffuse obj) 1.0
	bne	x4, x0, 2	# if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else ()
# beq:	()
	jalr x0, x1, 0	# ()
# bne:	let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else ()
	lw	x4, 3(x2)	# o_form obj
	# let m_shape = o_form obj
	sw	x1, 4(x2)	# o_form obj
	addi	x2, x2, 5	# o_form obj
	auipc	x31, -2	# o_form obj
	jalr	x0, x31, -7053	# o_form obj
	subi	x2, x2, 5	# o_form obj
	lw	x1, 4(x2)	# o_form obj
	addi	x4, x4, 0	# o_form obj
	addi	x5, x0, 1	# 1
	bne	x4, x5, 6	# if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else ()
# beq:	setup_rect_reflection obj_id obj
	lw	x4, 1(x2)	# setup_rect_reflection obj_id obj
	lw	x5, 3(x2)	# setup_rect_reflection obj_id obj
	lw	x29, 2(x2)	# setup_rect_reflection obj_id obj
	lw	x31, 0(x29)	# setup_rect_reflection obj_id obj
	jalr	x0, x31, 0	# setup_rect_reflection obj_id obj
# bne:	if m_shape = 2 then setup_surface_reflection obj_id obj else ()
	addi	x5, x0, 2	# 2
	bne	x4, x5, 6	# if m_shape = 2 then setup_surface_reflection obj_id obj else ()
# beq:	setup_surface_reflection obj_id obj
	lw	x4, 1(x2)	# setup_surface_reflection obj_id obj
	lw	x5, 3(x2)	# setup_surface_reflection obj_id obj
	lw	x29, 0(x2)	# setup_surface_reflection obj_id obj
	lw	x31, 0(x29)	# setup_surface_reflection obj_id obj
	jalr	x0, x31, 0	# setup_surface_reflection obj_id obj
# bne:	()
	jalr x0, x1, 0	# ()
# bne:	()
	jalr x0, x1, 0	# ()
# rt.3009:	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x6, 16(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x7, 15(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x8, 14(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x9, 13(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x10, 12(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x11, 11(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x12, 10(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x13, 9(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x14, 8(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x15, 7(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x16, 6(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x17, 5(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x29, 4(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x4, 0(x16)	# image_size.(0) <- size_x
	sw	x5, 1(x16)	# image_size.(1) <- size_y
	srai	x16, x4, 1	# size_x / 2
	sw	x16, 0(x17)	# image_center.(0) <- size_x / 2
	srai	x5, x5, 1	# size_y / 2
	sw	x5, 1(x17)	# image_center.(1) <- size_y / 2
	itof	f1, x4	# float_of_int size_x
	fdiv	f1, f17, f1	# 128.0 /. float_of_int size_x
	fsw	f1, 0(x8)	# scan_pitch.(0) <- 128.0 /. float_of_int size_x
	sw	x9, 0(x2)	# create_pixelline ()
	sw	x11, 1(x2)	# create_pixelline ()
	sw	x6, 2(x2)	# create_pixelline ()
	sw	x12, 3(x2)	# create_pixelline ()
	sw	x7, 4(x2)	# create_pixelline ()
	sw	x14, 5(x2)	# create_pixelline ()
	sw	x13, 6(x2)	# create_pixelline ()
	sw	x15, 7(x2)	# create_pixelline ()
	sw	x10, 8(x2)	# create_pixelline ()
	sw	x29, 9(x2)	# create_pixelline ()
	# let prev = create_pixelline ()
	sw	x1, 10(x2)	# create_pixelline ()
	addi	x2, x2, 11	# create_pixelline ()
	lw	x31, 0(x29)	# create_pixelline ()
	jalr	x1, x31, 0	# create_pixelline ()
	subi	x2, x2, 11	# create_pixelline ()
	lw	x1, 10(x2)	# create_pixelline ()
	addi	x4, x4, 0	# create_pixelline ()
	lw	x29, 9(x2)	# create_pixelline ()
	sw	x4, 10(x2)	# create_pixelline ()
	# let cur = create_pixelline ()
	sw	x1, 11(x2)	# create_pixelline ()
	addi	x2, x2, 12	# create_pixelline ()
	lw	x31, 0(x29)	# create_pixelline ()
	jalr	x1, x31, 0	# create_pixelline ()
	subi	x2, x2, 12	# create_pixelline ()
	lw	x1, 11(x2)	# create_pixelline ()
	addi	x4, x4, 0	# create_pixelline ()
	lw	x29, 9(x2)	# create_pixelline ()
	sw	x4, 11(x2)	# create_pixelline ()
	# let next = create_pixelline ()
	sw	x1, 12(x2)	# create_pixelline ()
	addi	x2, x2, 13	# create_pixelline ()
	lw	x31, 0(x29)	# create_pixelline ()
	jalr	x1, x31, 0	# create_pixelline ()
	subi	x2, x2, 13	# create_pixelline ()
	lw	x1, 12(x2)	# create_pixelline ()
	addi	x4, x4, 0	# create_pixelline ()
	lw	x29, 8(x2)	# read_parameter()
	sw	x4, 12(x2)	# read_parameter()
	sw	x1, 13(x2)	# read_parameter()
	addi	x2, x2, 14	# read_parameter()
	lw	x31, 0(x29)	# read_parameter()
	jalr	x1, x31, 0	# read_parameter()
	subi	x2, x2, 14	# read_parameter()
	lw	x1, 13(x2)	# read_parameter()
	addi	x0, x4, 0	# read_parameter()
	lw	x29, 7(x2)	# init_dirvecs()
	sw	x1, 13(x2)	# init_dirvecs()
	addi	x2, x2, 14	# init_dirvecs()
	lw	x31, 0(x29)	# init_dirvecs()
	jalr	x1, x31, 0	# init_dirvecs()
	subi	x2, x2, 14	# init_dirvecs()
	lw	x1, 13(x2)	# init_dirvecs()
	addi	x0, x4, 0	# init_dirvecs()
	lw	x4, 6(x2)	# d_vec light_dirvec
	sw	x1, 13(x2)	# d_vec light_dirvec
	addi	x2, x2, 14	# d_vec light_dirvec
	auipc	x31, -2	# d_vec light_dirvec
	jalr	x0, x31, -7077	# d_vec light_dirvec
	subi	x2, x2, 14	# d_vec light_dirvec
	lw	x1, 13(x2)	# d_vec light_dirvec
	addi	x4, x4, 0	# d_vec light_dirvec
	lw	x5, 5(x2)	# veccpy (d_vec light_dirvec) light
	sw	x1, 13(x2)	# veccpy (d_vec light_dirvec) light
	addi	x2, x2, 14	# veccpy (d_vec light_dirvec) light
	auipc	x31, -2	# veccpy (d_vec light_dirvec) light
	jalr	x0, x31, -7281	# veccpy (d_vec light_dirvec) light
	subi	x2, x2, 14	# veccpy (d_vec light_dirvec) light
	lw	x1, 13(x2)	# veccpy (d_vec light_dirvec) light
	addi	x0, x4, 0	# veccpy (d_vec light_dirvec) light
	lw	x4, 6(x2)	# setup_dirvec_constants light_dirvec
	lw	x29, 4(x2)	# setup_dirvec_constants light_dirvec
	sw	x1, 13(x2)	# setup_dirvec_constants light_dirvec
	addi	x2, x2, 14	# setup_dirvec_constants light_dirvec
	lw	x31, 0(x29)	# setup_dirvec_constants light_dirvec
	jalr	x1, x31, 0	# setup_dirvec_constants light_dirvec
	subi	x2, x2, 14	# setup_dirvec_constants light_dirvec
	lw	x1, 13(x2)	# setup_dirvec_constants light_dirvec
	addi	x0, x4, 0	# setup_dirvec_constants light_dirvec
	lw	x4, 3(x2)	# n_objects.(0)
	lw	x4, 0(x4)	# n_objects.(0)
	addi	x4, x4, -1	# n_objects.(0) - 1
	lw	x29, 2(x2)	# setup_reflections (n_objects.(0) - 1)
	sw	x1, 13(x2)	# setup_reflections (n_objects.(0) - 1)
	addi	x2, x2, 14	# setup_reflections (n_objects.(0) - 1)
	lw	x31, 0(x29)	# setup_reflections (n_objects.(0) - 1)
	jalr	x1, x31, 0	# setup_reflections (n_objects.(0) - 1)
	subi	x2, x2, 14	# setup_reflections (n_objects.(0) - 1)
	lw	x1, 13(x2)	# setup_reflections (n_objects.(0) - 1)
	addi	x0, x4, 0	# setup_reflections (n_objects.(0) - 1)
	addi	x5, x0, 0	# 0
	addi	x6, x0, 0	# 0
	lw	x4, 11(x2)	# pretrace_line cur 0 0
	lw	x29, 1(x2)	# pretrace_line cur 0 0
	sw	x1, 13(x2)	# pretrace_line cur 0 0
	addi	x2, x2, 14	# pretrace_line cur 0 0
	lw	x31, 0(x29)	# pretrace_line cur 0 0
	jalr	x1, x31, 0	# pretrace_line cur 0 0
	subi	x2, x2, 14	# pretrace_line cur 0 0
	lw	x1, 13(x2)	# pretrace_line cur 0 0
	addi	x0, x4, 0	# pretrace_line cur 0 0
	addi	x4, x0, 0	# 0
	addi	x8, x0, 2	# 2
	lw	x5, 10(x2)	# scan_line 0 prev cur next 2
	lw	x6, 11(x2)	# scan_line 0 prev cur next 2
	lw	x7, 12(x2)	# scan_line 0 prev cur next 2
	lw	x29, 0(x2)	# scan_line 0 prev cur next 2
	lw	x31, 0(x29)	# scan_line 0 prev cur next 2
	jalr	x0, x31, 0	# scan_line 0 prev cur next 2
_min_caml_start:	# entry point
# program starts
	addi	x3, x0, 0
	addi	x4, x0, 1	# 1
	addi	x5, x0, 0	# 0
	# let n_objects = create_array 1 0
	sw	x1, 0(x2)	# create_array 1 0
	addi	x2, x2, 1	# create_array 1 0
	auipc	x31, -2	# create_array 1 0
	jalr	x0, x31, -8373	# create_array 1 0
	subi	x2, x2, 1	# create_array 1 0
	lw	x1, 0(x2)	# create_array 1 0
	addi	x4, x4, 0	# create_array 1 0
	addi	x5, x0, 0	# 0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 0(x2)	# create_array 0 0.0
	# let dummy = create_array 0 0.0
	addi	x4, x5, 0	# create_array 0 0.0
	sw	x1, 1(x2)	# create_array 0 0.0
	addi	x2, x2, 2	# create_array 0 0.0
	auipc	x31, -2	# create_array 0 0.0
	jalr	x0, x31, -7884	# create_array 0 0.0
	subi	x2, x2, 2	# create_array 0 0.0
	lw	x1, 1(x2)	# create_array 0 0.0
	addi	x4, x4, 0	# create_array 0 0.0
	addi	x5, x0, 60	# 60
	addi	x6, x0, 0	# 0
	addi	x7, x0, 0	# 0
	addi	x8, x0, 0	# 0
	addi	x9, x0, 0	# 0
	addi	x10, x0, 0	# false
	addi	x31, x3, 0	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	addi	x3, x0, 11	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x4, 10(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x4, 9(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x4, 8(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x4, 7(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x10, 6(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x4, 5(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x4, 4(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x9, 3(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x8, 2(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x7, 1(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	sw	x6, 0(x31)	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	addi	x4, x31, 0	# 0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy
	# let objects = let dummy = create_array 0 0.0 in create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x30, x5, 0	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x5, x4, 0	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x4, x30, 0	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	sw	x1, 1(x2)	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x2, x2, 2	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	auipc	x31, -2	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	jalr	x0, x31, -8412	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	subi	x2, x2, 2	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	lw	x1, 1(x2)	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x4, x4, 0	# create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 1(x2)	# create_array 3 0.0
	# let screen = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 2(x2)	# create_array 3 0.0
	addi	x2, x2, 3	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -7926	# create_array 3 0.0
	subi	x2, x2, 3	# create_array 3 0.0
	lw	x1, 2(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 2(x2)	# create_array 3 0.0
	# let viewpoint = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 3(x2)	# create_array 3 0.0
	addi	x2, x2, 4	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -7938	# create_array 3 0.0
	subi	x2, x2, 4	# create_array 3 0.0
	lw	x1, 3(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 3(x2)	# create_array 3 0.0
	# let light = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 4(x2)	# create_array 3 0.0
	addi	x2, x2, 5	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -7950	# create_array 3 0.0
	subi	x2, x2, 5	# create_array 3 0.0
	lw	x1, 4(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 1	# 1
	lui	x31, 276464	# 255.0
	addi	x31, x31, 1132396544	# 255.0
	mvitof	f1, x31	# 255.0
	sw	x4, 4(x2)	# create_array 1 255.0
	# let beam = create_array 1 255.0
	addi	x4, x5, 0	# create_array 1 255.0
	sw	x1, 5(x2)	# create_array 1 255.0
	addi	x2, x2, 6	# create_array 1 255.0
	auipc	x31, -2	# create_array 1 255.0
	jalr	x0, x31, -7963	# create_array 1 255.0
	subi	x2, x2, 6	# create_array 1 255.0
	lw	x1, 5(x2)	# create_array 1 255.0
	addi	x4, x4, 0	# create_array 1 255.0
	addi	x5, x0, 50	# 50
	addi	x6, x0, 1	# 1
	addi	x7, x0, -1	# -1
	sw	x4, 5(x2)	# create_array 1 (-1)
	sw	x5, 6(x2)	# create_array 1 (-1)
	addi	x5, x7, 0	# create_array 1 (-1)
	addi	x4, x6, 0	# create_array 1 (-1)
	sw	x1, 7(x2)	# create_array 1 (-1)
	addi	x2, x2, 8	# create_array 1 (-1)
	auipc	x31, -2	# create_array 1 (-1)
	jalr	x0, x31, -8476	# create_array 1 (-1)
	subi	x2, x2, 8	# create_array 1 (-1)
	lw	x1, 7(x2)	# create_array 1 (-1)
	addi	x5, x4, 0	# create_array 1 (-1)
	lw	x4, 6(x2)	# create_array 50 (create_array 1 (-1))
	# let and_net = create_array 50 (create_array 1 (-1))
	sw	x1, 7(x2)	# create_array 50 (create_array 1 (-1))
	addi	x2, x2, 8	# create_array 50 (create_array 1 (-1))
	auipc	x31, -2	# create_array 50 (create_array 1 (-1))
	jalr	x0, x31, -8486	# create_array 50 (create_array 1 (-1))
	subi	x2, x2, 8	# create_array 50 (create_array 1 (-1))
	lw	x1, 7(x2)	# create_array 50 (create_array 1 (-1))
	addi	x4, x4, 0	# create_array 50 (create_array 1 (-1))
	addi	x5, x0, 1	# 1
	addi	x6, x0, 1	# 1
	lw	x7, 0(x4)	# and_net.(0)
	sw	x4, 7(x2)	# create_array 1 (and_net.(0))
	sw	x5, 8(x2)	# create_array 1 (and_net.(0))
	addi	x5, x7, 0	# create_array 1 (and_net.(0))
	addi	x4, x6, 0	# create_array 1 (and_net.(0))
	sw	x1, 9(x2)	# create_array 1 (and_net.(0))
	addi	x2, x2, 10	# create_array 1 (and_net.(0))
	auipc	x31, -2	# create_array 1 (and_net.(0))
	jalr	x0, x31, -8498	# create_array 1 (and_net.(0))
	subi	x2, x2, 10	# create_array 1 (and_net.(0))
	lw	x1, 9(x2)	# create_array 1 (and_net.(0))
	addi	x5, x4, 0	# create_array 1 (and_net.(0))
	lw	x4, 8(x2)	# create_array 1 (create_array 1 (and_net.(0)))
	# let or_net = create_array 1 (create_array 1 (and_net.(0)))
	sw	x1, 9(x2)	# create_array 1 (create_array 1 (and_net.(0)))
	addi	x2, x2, 10	# create_array 1 (create_array 1 (and_net.(0)))
	auipc	x31, -2	# create_array 1 (create_array 1 (and_net.(0)))
	jalr	x0, x31, -8508	# create_array 1 (create_array 1 (and_net.(0)))
	subi	x2, x2, 10	# create_array 1 (create_array 1 (and_net.(0)))
	lw	x1, 9(x2)	# create_array 1 (create_array 1 (and_net.(0)))
	addi	x4, x4, 0	# create_array 1 (create_array 1 (and_net.(0)))
	addi	x5, x0, 1	# 1
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 9(x2)	# create_array 1 0.0
	# let solver_dist = create_array 1 0.0
	addi	x4, x5, 0	# create_array 1 0.0
	sw	x1, 10(x2)	# create_array 1 0.0
	addi	x2, x2, 11	# create_array 1 0.0
	auipc	x31, -2	# create_array 1 0.0
	jalr	x0, x31, -8019	# create_array 1 0.0
	subi	x2, x2, 11	# create_array 1 0.0
	lw	x1, 10(x2)	# create_array 1 0.0
	addi	x4, x4, 0	# create_array 1 0.0
	addi	x5, x0, 1	# 1
	addi	x6, x0, 0	# 0
	sw	x4, 10(x2)	# create_array 1 0
	# let intsec_rectside = create_array 1 0
	addi	x4, x5, 0	# create_array 1 0
	addi	x5, x6, 0	# create_array 1 0
	sw	x1, 11(x2)	# create_array 1 0
	addi	x2, x2, 12	# create_array 1 0
	auipc	x31, -2	# create_array 1 0
	jalr	x0, x31, -8530	# create_array 1 0
	subi	x2, x2, 12	# create_array 1 0
	lw	x1, 11(x2)	# create_array 1 0
	addi	x4, x4, 0	# create_array 1 0
	addi	x5, x0, 1	# 1
	lui	x31, 321255	# 1000000000.0
	addi	x31, x31, 1315859240	# 1000000000.0
	mvitof	f1, x31	# 1000000000.0
	sw	x4, 11(x2)	# create_array 1 (1000000000.0)
	# let tmin = create_array 1 (1000000000.0)
	addi	x4, x5, 0	# create_array 1 (1000000000.0)
	sw	x1, 12(x2)	# create_array 1 (1000000000.0)
	addi	x2, x2, 13	# create_array 1 (1000000000.0)
	auipc	x31, -2	# create_array 1 (1000000000.0)
	jalr	x0, x31, -8044	# create_array 1 (1000000000.0)
	subi	x2, x2, 13	# create_array 1 (1000000000.0)
	lw	x1, 12(x2)	# create_array 1 (1000000000.0)
	addi	x4, x4, 0	# create_array 1 (1000000000.0)
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 12(x2)	# create_array 3 0.0
	# let intersection_point = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 13(x2)	# create_array 3 0.0
	addi	x2, x2, 14	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8056	# create_array 3 0.0
	subi	x2, x2, 14	# create_array 3 0.0
	lw	x1, 13(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 1	# 1
	addi	x6, x0, 0	# 0
	sw	x4, 13(x2)	# create_array 1 0
	# let intersected_object_id = create_array 1 0
	addi	x4, x5, 0	# create_array 1 0
	addi	x5, x6, 0	# create_array 1 0
	sw	x1, 14(x2)	# create_array 1 0
	addi	x2, x2, 15	# create_array 1 0
	auipc	x31, -2	# create_array 1 0
	jalr	x0, x31, -8567	# create_array 1 0
	subi	x2, x2, 15	# create_array 1 0
	lw	x1, 14(x2)	# create_array 1 0
	addi	x4, x4, 0	# create_array 1 0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 14(x2)	# create_array 3 0.0
	# let nvector = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 15(x2)	# create_array 3 0.0
	addi	x2, x2, 16	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8080	# create_array 3 0.0
	subi	x2, x2, 16	# create_array 3 0.0
	lw	x1, 15(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 15(x2)	# create_array 3 0.0
	# let texture_color = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 16(x2)	# create_array 3 0.0
	addi	x2, x2, 17	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8092	# create_array 3 0.0
	subi	x2, x2, 17	# create_array 3 0.0
	lw	x1, 16(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 16(x2)	# create_array 3 0.0
	# let diffuse_ray = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 17(x2)	# create_array 3 0.0
	addi	x2, x2, 18	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8104	# create_array 3 0.0
	subi	x2, x2, 18	# create_array 3 0.0
	lw	x1, 17(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 17(x2)	# create_array 3 0.0
	# let rgb = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 18(x2)	# create_array 3 0.0
	addi	x2, x2, 19	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8116	# create_array 3 0.0
	subi	x2, x2, 19	# create_array 3 0.0
	lw	x1, 18(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 2	# 2
	addi	x6, x0, 0	# 0
	sw	x4, 18(x2)	# create_array 2 0
	# let image_size = create_array 2 0
	addi	x4, x5, 0	# create_array 2 0
	addi	x5, x6, 0	# create_array 2 0
	sw	x1, 19(x2)	# create_array 2 0
	addi	x2, x2, 20	# create_array 2 0
	auipc	x31, -2	# create_array 2 0
	jalr	x0, x31, -8627	# create_array 2 0
	subi	x2, x2, 20	# create_array 2 0
	lw	x1, 19(x2)	# create_array 2 0
	addi	x4, x4, 0	# create_array 2 0
	addi	x5, x0, 2	# 2
	addi	x6, x0, 0	# 0
	sw	x4, 19(x2)	# create_array 2 0
	# let image_center = create_array 2 0
	addi	x4, x5, 0	# create_array 2 0
	addi	x5, x6, 0	# create_array 2 0
	sw	x1, 20(x2)	# create_array 2 0
	addi	x2, x2, 21	# create_array 2 0
	auipc	x31, -2	# create_array 2 0
	jalr	x0, x31, -8639	# create_array 2 0
	subi	x2, x2, 21	# create_array 2 0
	lw	x1, 20(x2)	# create_array 2 0
	addi	x4, x4, 0	# create_array 2 0
	addi	x5, x0, 1	# 1
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 20(x2)	# create_array 1 0.0
	# let scan_pitch = create_array 1 0.0
	addi	x4, x5, 0	# create_array 1 0.0
	sw	x1, 21(x2)	# create_array 1 0.0
	addi	x2, x2, 22	# create_array 1 0.0
	auipc	x31, -2	# create_array 1 0.0
	jalr	x0, x31, -8152	# create_array 1 0.0
	subi	x2, x2, 22	# create_array 1 0.0
	lw	x1, 21(x2)	# create_array 1 0.0
	addi	x4, x4, 0	# create_array 1 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 21(x2)	# create_array 3 0.0
	# let startp = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 22(x2)	# create_array 3 0.0
	addi	x2, x2, 23	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8164	# create_array 3 0.0
	subi	x2, x2, 23	# create_array 3 0.0
	lw	x1, 22(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 22(x2)	# create_array 3 0.0
	# let startp_fast = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 23(x2)	# create_array 3 0.0
	addi	x2, x2, 24	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8176	# create_array 3 0.0
	subi	x2, x2, 24	# create_array 3 0.0
	lw	x1, 23(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 23(x2)	# create_array 3 0.0
	# let screenx_dir = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 24(x2)	# create_array 3 0.0
	addi	x2, x2, 25	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8188	# create_array 3 0.0
	subi	x2, x2, 25	# create_array 3 0.0
	lw	x1, 24(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 24(x2)	# create_array 3 0.0
	# let screeny_dir = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 25(x2)	# create_array 3 0.0
	addi	x2, x2, 26	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8200	# create_array 3 0.0
	subi	x2, x2, 26	# create_array 3 0.0
	lw	x1, 25(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 25(x2)	# create_array 3 0.0
	# let screenz_dir = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 26(x2)	# create_array 3 0.0
	addi	x2, x2, 27	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8212	# create_array 3 0.0
	subi	x2, x2, 27	# create_array 3 0.0
	lw	x1, 26(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 26(x2)	# create_array 3 0.0
	# let ptrace_dirvec = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 27(x2)	# create_array 3 0.0
	addi	x2, x2, 28	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8224	# create_array 3 0.0
	subi	x2, x2, 28	# create_array 3 0.0
	lw	x1, 27(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 0	# 0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 27(x2)	# create_array 0 0.0
	# let dummyf = create_array 0 0.0
	addi	x4, x5, 0	# create_array 0 0.0
	sw	x1, 28(x2)	# create_array 0 0.0
	addi	x2, x2, 29	# create_array 0 0.0
	auipc	x31, -2	# create_array 0 0.0
	jalr	x0, x31, -8236	# create_array 0 0.0
	subi	x2, x2, 29	# create_array 0 0.0
	lw	x1, 28(x2)	# create_array 0 0.0
	addi	x5, x4, 0	# create_array 0 0.0
	addi	x4, x0, 0	# 0
	sw	x5, 28(x2)	# create_array 0 dummyf
	# let dummyff = create_array 0 dummyf
	sw	x1, 29(x2)	# create_array 0 dummyf
	addi	x2, x2, 30	# create_array 0 dummyf
	auipc	x31, -2	# create_array 0 dummyf
	jalr	x0, x31, -8746	# create_array 0 dummyf
	subi	x2, x2, 30	# create_array 0 dummyf
	lw	x1, 29(x2)	# create_array 0 dummyf
	addi	x4, x4, 0	# create_array 0 dummyf
	addi	x5, x0, 0	# 0
	addi	x31, x3, 0	# dummyf, dummyff
	addi	x3, x0, 13	# dummyf, dummyff
	sw	x4, 1(x31)	# dummyf, dummyff
	lw	x4, 28(x2)	# dummyf, dummyff
	sw	x4, 0(x31)	# dummyf, dummyff
	addi	x4, x31, 0	# dummyf, dummyff
	# let dummy_vs = create_array 0 (dummyf, dummyff)
	addi	x30, x5, 0	# create_array 0 (dummyf, dummyff)
	addi	x5, x4, 0	# create_array 0 (dummyf, dummyff)
	addi	x4, x30, 0	# create_array 0 (dummyf, dummyff)
	sw	x1, 29(x2)	# create_array 0 (dummyf, dummyff)
	addi	x2, x2, 30	# create_array 0 (dummyf, dummyff)
	auipc	x31, -2	# create_array 0 (dummyf, dummyff)
	jalr	x0, x31, -8760	# create_array 0 (dummyf, dummyff)
	subi	x2, x2, 30	# create_array 0 (dummyf, dummyff)
	lw	x1, 29(x2)	# create_array 0 (dummyf, dummyff)
	addi	x5, x4, 0	# create_array 0 (dummyf, dummyff)
	addi	x4, x0, 5	# 5
	# let dirvecs = let dummyf = create_array 0 0.0 in let dummyff = create_array 0 dummyf in let dummy_vs = create_array 0 (dummyf, dummyff) in create_array 5 dummy_vs
	sw	x1, 29(x2)	# create_array 5 dummy_vs
	addi	x2, x2, 30	# create_array 5 dummy_vs
	auipc	x31, -2	# create_array 5 dummy_vs
	jalr	x0, x31, -8771	# create_array 5 dummy_vs
	subi	x2, x2, 30	# create_array 5 dummy_vs
	lw	x1, 29(x2)	# create_array 5 dummy_vs
	addi	x4, x4, 0	# create_array 5 dummy_vs
	addi	x5, x0, 0	# 0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 29(x2)	# create_array 0 0.0
	# let dummyf2 = create_array 0 0.0
	addi	x4, x5, 0	# create_array 0 0.0
	sw	x1, 30(x2)	# create_array 0 0.0
	addi	x2, x2, 31	# create_array 0 0.0
	auipc	x31, -2	# create_array 0 0.0
	jalr	x0, x31, -8282	# create_array 0 0.0
	subi	x2, x2, 31	# create_array 0 0.0
	lw	x1, 30(x2)	# create_array 0 0.0
	addi	x4, x4, 0	# create_array 0 0.0
	addi	x5, x0, 3	# 3
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 30(x2)	# create_array 3 0.0
	# let v3 = create_array 3 0.0
	addi	x4, x5, 0	# create_array 3 0.0
	sw	x1, 31(x2)	# create_array 3 0.0
	addi	x2, x2, 32	# create_array 3 0.0
	auipc	x31, -2	# create_array 3 0.0
	jalr	x0, x31, -8294	# create_array 3 0.0
	subi	x2, x2, 32	# create_array 3 0.0
	lw	x1, 31(x2)	# create_array 3 0.0
	addi	x4, x4, 0	# create_array 3 0.0
	addi	x5, x0, 60	# 60
	lw	x6, 30(x2)	# create_array 60 dummyf2
	sw	x4, 31(x2)	# create_array 60 dummyf2
	# let consts = create_array 60 dummyf2
	addi	x4, x5, 0	# create_array 60 dummyf2
	addi	x5, x6, 0	# create_array 60 dummyf2
	sw	x1, 32(x2)	# create_array 60 dummyf2
	addi	x2, x2, 33	# create_array 60 dummyf2
	auipc	x31, -2	# create_array 60 dummyf2
	jalr	x0, x31, -8805	# create_array 60 dummyf2
	subi	x2, x2, 33	# create_array 60 dummyf2
	lw	x1, 32(x2)	# create_array 60 dummyf2
	addi	x4, x4, 0	# create_array 60 dummyf2
	addi	x31, x3, 0	# v3, consts
	addi	x3, x0, 15	# v3, consts
	sw	x4, 1(x31)	# v3, consts
	lw	x4, 31(x2)	# v3, consts
	sw	x4, 0(x31)	# v3, consts
	# let light_dirvec = let dummyf2 = create_array 0 0.0 in let v3 = create_array 3 0.0 in let consts = create_array 60 dummyf2 in (v3, consts)
	addi	x4, x31, 0	# v3, consts
	addi	x5, x0, 0	# 0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	sw	x4, 32(x2)	# create_array 0 0.0
	# let dummyf3 = create_array 0 0.0
	addi	x4, x5, 0	# create_array 0 0.0
	sw	x1, 33(x2)	# create_array 0 0.0
	addi	x2, x2, 34	# create_array 0 0.0
	auipc	x31, -2	# create_array 0 0.0
	jalr	x0, x31, -8324	# create_array 0 0.0
	subi	x2, x2, 34	# create_array 0 0.0
	lw	x1, 33(x2)	# create_array 0 0.0
	addi	x5, x4, 0	# create_array 0 0.0
	addi	x4, x0, 0	# 0
	sw	x5, 33(x2)	# create_array 0 dummyf3
	# let dummyff3 = create_array 0 dummyf3
	sw	x1, 34(x2)	# create_array 0 dummyf3
	addi	x2, x2, 35	# create_array 0 dummyf3
	auipc	x31, -2	# create_array 0 dummyf3
	jalr	x0, x31, -8834	# create_array 0 dummyf3
	subi	x2, x2, 35	# create_array 0 dummyf3
	lw	x1, 34(x2)	# create_array 0 dummyf3
	addi	x4, x4, 0	# create_array 0 dummyf3
	addi	x31, x3, 0	# dummyf3, dummyff3
	addi	x3, x0, 17	# dummyf3, dummyff3
	sw	x4, 1(x31)	# dummyf3, dummyff3
	lw	x4, 33(x2)	# dummyf3, dummyff3
	sw	x4, 0(x31)	# dummyf3, dummyff3
	# let dummydv = (dummyf3, dummyff3)
	addi	x4, x31, 0	# dummyf3, dummyff3
	addi	x5, x0, 180	# 180
	addi	x6, x0, 0	# 0
	addi	x31, x0, 0	# 0.0
	mvitof	f1, x31	# 0.0
	addi	x31, x3, 0	# 0, dummydv, 0.0
	addi	x3, x0, 20	# 0, dummydv, 0.0
	fsw	f1, 2(x31)	# 0, dummydv, 0.0
	sw	x4, 1(x31)	# 0, dummydv, 0.0
	sw	x6, 0(x31)	# 0, dummydv, 0.0
	addi	x4, x31, 0	# 0, dummydv, 0.0
	# let reflections = let dummyf3 = create_array 0 0.0 in let dummyff3 = create_array 0 dummyf3 in let dummydv = (dummyf3, dummyff3) in create_array 180 (0, dummydv, 0.0)
	addi	x30, x5, 0	# create_array 180 (0, dummydv, 0.0)
	addi	x5, x4, 0	# create_array 180 (0, dummydv, 0.0)
	addi	x4, x30, 0	# create_array 180 (0, dummydv, 0.0)
	sw	x1, 34(x2)	# create_array 180 (0, dummydv, 0.0)
	addi	x2, x2, 35	# create_array 180 (0, dummydv, 0.0)
	auipc	x31, -2	# create_array 180 (0, dummydv, 0.0)
	jalr	x0, x31, -8857	# create_array 180 (0, dummydv, 0.0)
	subi	x2, x2, 35	# create_array 180 (0, dummydv, 0.0)
	lw	x1, 34(x2)	# create_array 180 (0, dummydv, 0.0)
	addi	x4, x4, 0	# create_array 180 (0, dummydv, 0.0)
	addi	x5, x0, 1	# 1
	addi	x6, x0, 0	# 0
	sw	x4, 34(x2)	# create_array 1 0
	# let n_reflections = create_array 1 0
	addi	x4, x5, 0	# create_array 1 0
	addi	x5, x6, 0	# create_array 1 0
	sw	x1, 35(x2)	# create_array 1 0
	addi	x2, x2, 36	# create_array 1 0
	auipc	x31, -2	# create_array 1 0
	jalr	x0, x31, -8870	# create_array 1 0
	subi	x2, x2, 36	# create_array 1 0
	lw	x1, 35(x2)	# create_array 1 0
	addi	x4, x4, 0	# create_array 1 0
	addi	x5, x3, 0	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	addi	x3, x0, 29	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	addi	x31, x0, 254	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	sw	x31, 0(x5)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x6, 3(x2)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	sw	x6, 8(x5)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x7, 26(x2)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	sw	x7, 7(x5)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x8, 25(x2)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	sw	x8, 6(x5)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x9, 24(x2)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	sw	x9, 5(x5)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	lw	x10, 2(x2)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	sw	x10, 4(x5)	# let rec read_screen_settings _ = screen.(0) <- read_float (); screen.(1) <- read_float (); screen.(2) <- read_float (); let v1 = rad (read_float ()) in let cos_v1 = cos v1 in let sin_v1 = sin v1 in let v2 = rad (read_float ()) in let cos_v2 = cos v2 in let sin_v2 = sin v2 in screenz_dir.(0) <- cos_v1 *. sin_v2 *. 200.0; screenz_dir.(1) <- sin_v1 *. -200.0; screenz_dir.(2) <- cos_v1 *. cos_v2 *. 200.0; screenx_dir.(0) <- cos_v2; screenx_dir.(1) <- 0.0; screenx_dir.(2) <- fneg sin_v2; screeny_dir.(0) <- fneg sin_v1 *. sin_v2; screeny_dir.(1) <- fneg cos_v1; screeny_dir.(2) <- fneg sin_v1 *. cos_v2; viewpoint.(0) <- screen.(0) -. screenz_dir.(0); viewpoint.(1) <- screen.(1) -. screenz_dir.(1); viewpoint.(2) <- screen.(2) -. screenz_dir.(2)
	addi	x10, x3, 0	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	addi	x3, x0, 35	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	addi	x31, x0, 363	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	sw	x31, 0(x10)	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	lw	x11, 4(x2)	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	sw	x11, 5(x10)	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	lw	x12, 5(x2)	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	sw	x12, 4(x10)	# let rec read_light _ = let nl = read_int () in let l1 = rad (read_float ()) in let sl1 = sin l1 in light.(1) <- fneg sl1; let l2 = rad (read_float ()) in let cl1 = cos l1 in let sl2 = sin l2 in light.(0) <- cl1 *. sl2; let cl2 = cos l2 in light.(2) <- cl1 *. cl2; beam.(0) <- read_float ()
	addi	x13, x3, 0	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	addi	x3, x0, 40	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	addi	x31, x0, 518	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	sw	x31, 0(x13)	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	lw	x14, 1(x2)	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	sw	x14, 4(x13)	# let rec read_nth_object n = let texture = read_int () in if texture <> -1 then ( let form = read_int () in let refltype = read_int () in let isrot_p = read_int () in let abc = create_array 3 0.0 in abc.(0) <- read_float (); abc.(1) <- read_float (); abc.(2) <- read_float (); let xyz = create_array 3 0.0 in xyz.(0) <- read_float (); xyz.(1) <- read_float (); xyz.(2) <- read_float (); let m_invert = fisneg (read_float ()) in let reflparam = create_array 2 0.0 in reflparam.(0) <- read_float (); reflparam.(1) <- read_float (); let color = create_array 3 0.0 in color.(0) <- read_float (); color.(1) <- read_float (); color.(2) <- read_float (); let rotation = create_array 3 0.0 in if isrot_p <> 0 then ( rotation.(0) <- rad (read_float ()); rotation.(1) <- rad (read_float ()); rotation.(2) <- rad (read_float ()) ) else (); let m_invert2 = if form = 2 then true else m_invert in let ctbl = create_array 4 0.0 in let obj = (texture, form, refltype, isrot_p, abc, xyz, m_invert2, reflparam, color, rotation, ctbl ) in objects.(n) <- obj; if form = 3 then ( let a = abc.(0) in abc.(0) <- if fiszero a then 0.0 else sgn a /. fsqr a; let b = abc.(1) in abc.(1) <- if fiszero b then 0.0 else sgn b /. fsqr b; let c = abc.(2) in abc.(2) <- if fiszero c then 0.0 else sgn c /. fsqr c ) else if form = 2 then vecunit_sgn abc (not m_invert) else (); if isrot_p <> 0 then rotate_quadratic_matrix abc rotation else (); true ) else false
	addi	x15, x3, 0	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	addi	x3, x0, 46	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	addi	x31, x0, 879	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	sw	x31, 0(x15)	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	sw	x13, 5(x15)	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	lw	x13, 0(x2)	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	sw	x13, 4(x15)	# let rec read_object n = if n < 60 then if read_nth_object n then read_object (n + 1) else n_objects.(0) <- n else ()
	addi	x16, x3, 0	# let rec read_all_object _ = read_object 0
	addi	x3, x0, 51	# let rec read_all_object _ = read_object 0
	addi	x31, x0, 905	# let rec read_all_object _ = read_object 0
	sw	x31, 0(x16)	# let rec read_all_object _ = read_object 0
	sw	x15, 4(x16)	# let rec read_all_object _ = read_object 0
	addi	x15, x3, 0	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	addi	x3, x0, 56	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	addi	x31, x0, 965	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	sw	x31, 0(x15)	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	lw	x17, 7(x2)	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	sw	x17, 4(x15)	# let rec read_and_network n = let net = read_net_item 0 in if net.(0) = -1 then () else ( and_net.(n) <- net; read_and_network (n + 1) )
	addi	x18, x3, 0	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	addi	x3, x0, 65	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	addi	x31, x0, 988	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x31, 0(x18)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x5, 8(x18)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x10, 7(x18)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x15, 6(x18)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x16, 5(x18)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	lw	x5, 9(x2)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	sw	x5, 4(x18)	# let rec read_parameter _ = ( read_screen_settings(); read_light(); read_all_object (); read_and_network 0; or_net.(0) <- read_or_network 0 )
	addi	x10, x3, 0	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	addi	x3, x0, 70	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	addi	x31, x0, 1040	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	sw	x31, 0(x10)	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	lw	x15, 10(x2)	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	sw	x15, 4(x10)	# let rec solver_rect_surface m dirvec b0 b1 b2 i0 i1 i2 = if fiszero dirvec.(i0) then false else let abc = o_param_abc m in let d = fneg_cond (xor (o_isinvert m) (fisneg dirvec.(i0))) abc.(i0) in let d2 = (d -. b0) /. dirvec.(i0) in if fless (fabs (d2 *. dirvec.(i1) +. b1)) abc.(i1) then if fless (fabs (d2 *. dirvec.(i2) +. b2)) abc.(i2) then (solver_dist.(0) <- d2; true) else false else false
	addi	x16, x3, 0	# let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x3, x0, 75	# let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x31, x0, 1116	# let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	sw	x31, 0(x16)	# let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	sw	x10, 4(x16)	# let rec solver_rect m dirvec b0 b1 b2 = if solver_rect_surface m dirvec b0 b1 b2 0 1 2 then 1 else if solver_rect_surface m dirvec b1 b2 b0 1 2 0 then 2 else if solver_rect_surface m dirvec b2 b0 b1 2 0 1 then 3 else 0
	addi	x10, x3, 0	# let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	addi	x3, x0, 80	# let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	addi	x31, x0, 1176	# let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	sw	x31, 0(x10)	# let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	sw	x15, 4(x10)	# let rec solver_surface m dirvec b0 b1 b2 = let abc = o_param_abc m in let d = veciprod dirvec abc in if fispos d then ( solver_dist.(0) <- fneg (veciprod2 abc b0 b1 b2) /. d; 1 ) else 0
	addi	x19, x3, 0	# let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	addi	x3, x0, 85	# let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	addi	x31, x0, 1445	# let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	sw	x31, 0(x19)	# let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	sw	x15, 4(x19)	# let rec solver_second m dirvec b0 b1 b2 = let aa = quadratic m dirvec.(0) dirvec.(1) dirvec.(2) in if fiszero aa then 0 else ( let bb = bilinear m dirvec.(0) dirvec.(1) dirvec.(2) b0 b1 b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = fsqr bb -. aa *. cc in if fispos d then ( let sd = sqrt d in let t1 = if o_isinvert m then sd else fneg sd in (solver_dist.(0) <- (t1 -. bb) /. aa; 1) ) else 0 )
	addi	x20, x3, 0	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	addi	x3, x0, 93	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	addi	x31, x0, 1552	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	sw	x31, 0(x20)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	sw	x10, 7(x20)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	sw	x19, 6(x20)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	sw	x16, 5(x20)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	sw	x14, 4(x20)	# let rec solver index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let m_shape = o_form m in if m_shape = 1 then solver_rect m dirvec b0 b1 b2 else if m_shape = 2 then solver_surface m dirvec b0 b1 b2 else solver_second m dirvec b0 b1 b2
	addi	x10, x3, 0	# let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	addi	x3, x0, 98	# let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	addi	x31, x0, 1636	# let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	sw	x31, 0(x10)	# let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	sw	x15, 4(x10)	# let rec solver_rect_fast m v dconst b0 b1 b2 = let d0 = (dconst.(0) -. b0) *. dconst.(1) in if if fless (fabs (d0 *. v.(1) +. b1)) (o_param_b m) then if fless (fabs (d0 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(1)) else false else false then (solver_dist.(0) <- d0; 1) else let d1 = (dconst.(2) -. b1) *. dconst.(3) in if if fless (fabs (d1 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d1 *. v.(2) +. b2)) (o_param_c m) then not (fiszero dconst.(3)) else false else false then (solver_dist.(0) <- d1; 2) else let d2 = (dconst.(4) -. b2) *. dconst.(5) in if if fless (fabs (d2 *. v.(0) +. b0)) (o_param_a m) then if fless (fabs (d2 *. v.(1) +. b1)) (o_param_b m) then not (fiszero dconst.(5)) else false else false then (solver_dist.(0) <- d2; 3) else 0
	addi	x16, x3, 0	# let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	addi	x3, x0, 103	# let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	addi	x31, x0, 1807	# let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	sw	x31, 0(x16)	# let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	sw	x15, 4(x16)	# let rec solver_surface_fast m dconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2; 1 ) else 0
	addi	x19, x3, 0	# let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	addi	x3, x0, 108	# let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	addi	x31, x0, 1824	# let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	sw	x31, 0(x19)	# let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	sw	x15, 4(x19)	# let rec solver_second_fast m dconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc0 = quadratic m b0 b1 b2 in let cc = if o_form m = 3 then cc0 -. 1.0 else cc0 in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	addi	x21, x3, 0	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	addi	x3, x0, 116	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	addi	x31, x0, 1906	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	sw	x31, 0(x21)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	sw	x16, 7(x21)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	sw	x19, 6(x21)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	sw	x10, 5(x21)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	sw	x14, 4(x21)	# let rec solver_fast index dirvec org = let m = objects.(index) in let b0 = org.(0) -. o_param_x m in let b1 = org.(1) -. o_param_y m in let b2 = org.(2) -. o_param_z m in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast m dconst b0 b1 b2 else solver_second_fast m dconst b0 b1 b2
	addi	x16, x3, 0	# let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	addi	x3, x0, 121	# let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	addi	x31, x0, 2010	# let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	sw	x31, 0(x16)	# let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	sw	x15, 4(x16)	# let rec solver_surface_fast2 m dconst sconst b0 b1 b2 = if fisneg dconst.(0) then ( solver_dist.(0) <- dconst.(0) *. sconst.(3); 1 ) else 0
	addi	x19, x3, 0	# let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	addi	x3, x0, 126	# let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	addi	x31, x0, 2022	# let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	sw	x31, 0(x19)	# let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	sw	x15, 4(x19)	# let rec solver_second_fast2 m dconst sconst b0 b1 b2 = let aa = dconst.(0) in if fiszero aa then 0 else let neg_bb = dconst.(1) *. b0 +. dconst.(2) *. b1 +. dconst.(3) *. b2 in let cc = sconst.(3) in let d = (fsqr neg_bb) -. aa *. cc in if fispos d then ( if o_isinvert m then solver_dist.(0) <- (neg_bb +. sqrt d) *. dconst.(4) else solver_dist.(0) <- (neg_bb -. sqrt d) *. dconst.(4); 1) else 0
	addi	x22, x3, 0	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	addi	x3, x0, 134	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	lui	x31, 1	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	addi	x31, x31, 2078	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	sw	x31, 0(x22)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	sw	x16, 7(x22)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	sw	x19, 6(x22)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	sw	x10, 5(x22)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	sw	x14, 4(x22)	# let rec solver_fast2 index dirvec = let m = objects.(index) in let sconst = o_param_ctbl m in let b0 = sconst.(0) in let b1 = sconst.(1) in let b2 = sconst.(2) in let dconsts = d_const dirvec in let dconst = dconsts.(index) in let m_shape = o_form m in if m_shape = 1 then solver_rect_fast m (d_vec dirvec) dconst b0 b1 b2 else if m_shape = 2 then solver_surface_fast2 m dconst sconst b0 b1 b2 else solver_second_fast2 m dconst sconst b0 b1 b2
	addi	x10, x3, 0	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	addi	x3, x0, 139	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	lui	x31, 1	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	addi	x31, x31, 2647	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	sw	x31, 0(x10)	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	sw	x14, 4(x10)	# let rec iter_setup_dirvec_constants dirvec index = if index >= 0 then ( let m = objects.(index) in let dconst = (d_const dirvec) in let v = d_vec dirvec in let m_shape = o_form m in if m_shape = 1 then dconst.(index) <- setup_rect_table v m else if m_shape = 2 then dconst.(index) <- setup_surface_table v m else dconst.(index) <- setup_second_table v m; iter_setup_dirvec_constants dirvec (index - 1) ) else ()
	addi	x16, x3, 0	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	addi	x3, x0, 145	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	lui	x31, 1	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	addi	x31, x31, 2728	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	sw	x31, 0(x16)	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	sw	x13, 5(x16)	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	sw	x10, 4(x16)	# let rec setup_dirvec_constants dirvec = iter_setup_dirvec_constants dirvec (n_objects.(0) - 1)
	addi	x10, x3, 0	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	addi	x3, x0, 150	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	lui	x31, 1	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	addi	x31, x31, 2734	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	sw	x31, 0(x10)	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	sw	x14, 4(x10)	# let rec setup_startp_constants p index = if index >= 0 then ( let obj = objects.(index) in let sconst = o_param_ctbl obj in let m_shape = o_form obj in sconst.(0) <- p.(0) -. o_param_x obj; sconst.(1) <- p.(1) -. o_param_y obj; sconst.(2) <- p.(2) -. o_param_z obj; if m_shape = 2 then sconst.(3) <- veciprod2 (o_param_abc obj) sconst.(0) sconst.(1) sconst.(2) else if m_shape > 2 then let cc0 = quadratic obj sconst.(0) sconst.(1) sconst.(2) in sconst.(3) <- if m_shape = 3 then cc0 -. 1.0 else cc0 else (); setup_startp_constants p (index - 1) ) else ()
	addi	x19, x3, 0	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	addi	x3, x0, 157	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	lui	x31, 1	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	addi	x31, x31, 2866	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	sw	x31, 0(x19)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	lw	x23, 23(x2)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	sw	x23, 6(x19)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	sw	x10, 5(x19)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	sw	x13, 4(x19)	# let rec setup_startp p = veccpy startp_fast p; setup_startp_constants p (n_objects.(0) - 1)
	addi	x10, x3, 0	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	addi	x3, x0, 162	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	lui	x31, 1	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	addi	x31, x31, 3077	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	sw	x31, 0(x10)	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	sw	x14, 4(x10)	# let rec check_all_inside ofs iand q0 q1 q2 = let head = iand.(ofs) in if head = -1 then true else ( if is_outside objects.(head) q0 q1 q2 then false else check_all_inside (ofs + 1) iand q0 q1 q2 )
	addi	x24, x3, 0	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	addi	x3, x0, 173	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lui	x31, 1	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	addi	x31, x31, 3109	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x31, 0(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x21, 10(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x15, 9(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x14, 8(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x25, 32(x2)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x25, 7(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x11, 6(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	lw	x26, 13(x2)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x26, 5(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	sw	x10, 4(x24)	# let rec shadow_check_and_group iand_ofs and_group = if and_group.(iand_ofs) = -1 then false else let obj = and_group.(iand_ofs) in let t0 = solver_fast obj light_dirvec intersection_point in let t0p = solver_dist.(0) in if (if t0 <> 0 then fless t0p (-0.2) else false) then let t = t0p +. 0.01 in let q0 = light.(0) *. t +. intersection_point.(0) in let q1 = light.(1) *. t +. intersection_point.(1) in let q2 = light.(2) *. t +. intersection_point.(2) in if check_all_inside 0 and_group q0 q1 q2 then true else shadow_check_and_group (iand_ofs + 1) and_group else if o_isinvert (objects.(obj)) then shadow_check_and_group (iand_ofs + 1) and_group else false
	addi	x27, x3, 0	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	addi	x3, x0, 179	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	lui	x31, 1	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	addi	x31, x31, 3214	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	sw	x31, 0(x27)	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	sw	x24, 5(x27)	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	sw	x17, 4(x27)	# let rec shadow_check_one_or_group ofs or_group = let head = or_group.(ofs) in if head = -1 then false else ( let and_group = and_net.(head) in let shadow_p = shadow_check_and_group 0 and_group in if shadow_p then true else shadow_check_one_or_group (ofs + 1) or_group )
	addi	x24, x3, 0	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	addi	x3, x0, 188	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	lui	x31, 1	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	addi	x31, x31, 3245	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	sw	x31, 0(x24)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	sw	x21, 8(x24)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	sw	x15, 7(x24)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	sw	x27, 6(x24)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	sw	x25, 5(x24)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	sw	x26, 4(x24)	# let rec shadow_check_one_or_matrix ofs or_matrix = let head = or_matrix.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then false else if if range_primitive = 99 then true else let t = solver_fast range_primitive light_dirvec intersection_point in if t <> 0 then if fless solver_dist.(0) (-0.1) then if shadow_check_one_or_group 1 head then true else false else false else false then if (shadow_check_one_or_group 1 head) then true else shadow_check_one_or_matrix (ofs + 1) or_matrix else shadow_check_one_or_matrix (ofs + 1) or_matrix
	addi	x21, x3, 0	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	addi	x3, x0, 201	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lui	x31, 1	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	addi	x31, x31, 3331	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x31, 0(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x27, 12(x2)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x27, 12(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x28, 22(x2)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x28, 11(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x15, 10(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x20, 9(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x14, 8(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x29, 11(x2)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x29, 7(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x26, 6(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	lw	x25, 14(x2)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x25, 5(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x10, 4(x21)	# let rec solve_each_element iand_ofs and_group dirvec = let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver iobj dirvec startp in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = dirvec.(0) *. t +. startp.(0) in let q1 = dirvec.(1) *. t +. startp.(1) in let q2 = dirvec.(2) *. t +. startp.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0 ) else () ) else () else (); solve_each_element (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element (iand_ofs + 1) and_group dirvec else () )
	sw	x18, 35(x2)	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else () in let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec ) in let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false ) in (****************************************************************************** 光線と物体の交差判定 高速版 *****************************************************************************) let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () ) in let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else () in let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec ) in let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false ) in (****************************************************************************** 物体と光の交差点の法線ベクトルを求める関数 *****************************************************************************) let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1))) in let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m) in let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m) in let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m in (****************************************************************************** 物体表面の色(色付き拡散反射率)を求める *****************************************************************************) let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else () in (****************************************************************************** 衝突点に当たる光源の直接光と反射光を計算する関数群 *****************************************************************************) let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () in let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else () in (****************************************************************************** 直接光を追跡する *****************************************************************************) let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else () in (****************************************************************************** 間接光を追跡する *****************************************************************************) (* 間接光の方向ベクトル dirvecに関しては定数テーブルが作られており、衝突判定 が高速に行われる。物体に当たったら、その後の反射は追跡しない *) let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else () in (* あらかじめ決められた方向ベクトルの配列に対し、各ベクトルの方角から来る 間接光の強さをサンプリングして加算する *) let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else () in let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118 in (* 半球方向の全部で300本のベクトルのうち、まだ追跡していない残りの240本の ベクトルについて間接光追跡する。60本のベクトル追跡を4セット行う *) let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else () in (* 上下左右4点の間接光追跡結果を使わず、300本全部のベクトルを追跡して間接光を 計算する。20%(60本)は追跡済なので、残り80%(240本)を追跡する *) let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray in (* 自分と上下左右4点の追跡結果を加算して間接光を求める。本来は 300 本の光を 追跡する必要があるが、5点加算するので1点あたり60本(20%)追跡するだけで済む *) let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray in let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else () in let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false in let rec get_surface_id pixel index = let surface_ids = p_surface_ids pixel in surface_ids.(index) in (* 上下左右4点の直接光追跡の結果、自分と同じ面に衝突しているかをチェック もし同じ面に衝突していれば、これら4点の結果を使うことで計算を省略出来る *) let rec neighbors_are_available x prev cur next nref = let sid_center = get_surface_id cur.(x) nref in if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false in (* 直接光の各衝突点における間接受光の強さを、上下左右4点の結果を使用して計算 する。もし上下左右4点の計算結果を使えない場合は、その時点で do_without_neighborsに切り替える *) let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else () in (****************************************************************************** PPMファイルの書き込み関数 *****************************************************************************) let rec write_ppm_header _ = ( print_char 80; print_char (48 + 3); print_char 10; print_int image_size.(0); print_char 32; print_int image_size.(1); print_char 32; print_int 255; print_char 10 ) in let rec write_rgb_element x = let ix = int_of_float x in let elem = if ix > 255 then 255 else if ix < 0 then 0 else ix in print_int elem in let rec write_rgb _ = write_rgb_element rgb.(0); print_char 32; write_rgb_element rgb.(1); print_char 32; write_rgb_element rgb.(2); print_char 10 in (****************************************************************************** あるラインの計算に必要な情報を集めるため次のラインの追跡を行っておく関数群 *****************************************************************************) (* 間接光のサンプリングでは上下左右4点の結果を使うので、次のラインの計算を 行わないと最終的なピクセルの値を計算できない *) let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else () in let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else () in let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2 in (****************************************************************************** 直接光追跡と間接光20%追跡の結果から最終的なピクセル値を計算する関数 *****************************************************************************) let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else () in let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () ) in (****************************************************************************** ピクセルの情報を格納するデータ構造の割り当て関数群 *****************************************************************************) let rec create_float5x3array _ = ( let vec = create_array 3 0.0 in let array = create_array 5 vec in array.(1) <- create_array 3 0.0; array.(2) <- create_array 3 0.0; array.(3) <- create_array 3 0.0; array.(4) <- create_array 3 0.0; array ) in let rec create_pixel _ = let m_rgb = create_array 3 0.0 in let m_isect_ps = create_float5x3array() in let m_sids = create_array 5 0 in let m_cdif = create_array 5 false in let m_engy = create_float5x3array() in let m_r20p = create_float5x3array() in let m_gid = create_array 1 0 in let m_nvectors = create_float5x3array() in (m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors) in let rec init_line_elements line n = if n >= 0 then ( line.(n) <- create_pixel(); init_line_elements line (n-1) ) else line in let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2) in (****************************************************************************** 間接光のサンプリングにつかう方向ベクトル群を計算する関数群 *****************************************************************************) (* ベクトル達が出来るだけ一様に分布するよう、600本の方向ベクトルの向きを定める 立方体上の各面に100本ずつ分布させ、さらに、100本が立方体上の面上で10 x 10 の 格子状に並ぶような配列を使う。この配列では方角によるベクトルの密度の差が 大きいので、これに補正を加えたものを最終的に用いる *) let rec tan x = sin(x) /. cos(x) in let rec adjust_position h ratio = let l = sqrt(h*.h +. 0.1) in let tan_h = 1.0 /. l in let theta_h = atan tan_h in let tan_m = tan (theta_h *. ratio) in tan_m *. l in let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index in let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else () in let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else () in (****************************************************************************** dirvec のメモリ割り当てを行う *****************************************************************************) let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts) in let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else () in let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else () in (****************************************************************************** 補助関数達を呼び出してdirvecの初期化を行う *****************************************************************************) let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else () in let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else () in let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4 in (****************************************************************************** 完全鏡面反射成分を持つ物体の反射情報を初期化する *****************************************************************************) let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright) in let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3 in let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1 in let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else () in (***************************************************************************** 全体の制御 *****************************************************************************) let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 ) in let _ = rt 128 128 in 0
	addi	x18, x3, 0	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	addi	x3, x0, 207	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	lui	x31, 1	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	addi	x31, x31, 3467	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	sw	x31, 0(x18)	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	sw	x21, 5(x18)	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	sw	x17, 4(x18)	# let rec solve_one_or_network ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element 0 and_group dirvec; solve_one_or_network (ofs + 1) or_group dirvec ) else ()
	addi	x21, x3, 0	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	addi	x3, x0, 216	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	lui	x31, 1	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	addi	x31, x31, 3496	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	sw	x31, 0(x21)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	sw	x27, 8(x21)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	sw	x28, 7(x21)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	sw	x15, 6(x21)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	sw	x20, 5(x21)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	sw	x18, 4(x21)	# let rec trace_or_matrix ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then (solve_one_or_network 1 head dirvec) else ( let t = solver range_primitive dirvec startp in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network 1 head dirvec) else () else () ); trace_or_matrix (ofs + 1) or_network dirvec )
	addi	x18, x3, 0	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	addi	x3, x0, 223	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lui	x31, 1	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	addi	x31, x31, 3556	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x31, 0(x18)	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x21, 6(x18)	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x27, 5(x18)	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x5, 4(x18)	# let rec judge_intersection dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	addi	x20, x3, 0	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	addi	x3, x0, 236	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	lui	x31, 1	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	addi	x31, x31, 3588	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x31, 0(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x27, 12(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x23, 11(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x22, 10(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x15, 9(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x14, 8(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x29, 7(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x26, 6(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x25, 5(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	sw	x10, 4(x20)	# let rec solve_each_element_fast iand_ofs and_group dirvec = let vec = (d_vec dirvec) in let iobj = and_group.(iand_ofs) in if iobj = -1 then () else ( let t0 = solver_fast2 iobj dirvec in if t0 <> 0 then ( let t0p = solver_dist.(0) in if (fless 0.0 t0p) then if (fless t0p tmin.(0)) then ( let t = t0p +. 0.01 in let q0 = vec.(0) *. t +. startp_fast.(0) in let q1 = vec.(1) *. t +. startp_fast.(1) in let q2 = vec.(2) *. t +. startp_fast.(2) in if check_all_inside 0 and_group q0 q1 q2 then ( tmin.(0) <- t; vecset intersection_point q0 q1 q2; intersected_object_id.(0) <- iobj; intsec_rectside.(0) <- t0; ) else () ) else () else (); solve_each_element_fast (iand_ofs + 1) and_group dirvec ) else if o_isinvert (objects.(iobj)) then solve_each_element_fast (iand_ofs + 1) and_group dirvec else () )
	addi	x10, x3, 0	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	addi	x3, x0, 242	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	lui	x31, 1	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	addi	x31, x31, 3736	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	sw	x31, 0(x10)	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	sw	x20, 5(x10)	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	sw	x17, 4(x10)	# let rec solve_one_or_network_fast ofs or_group dirvec = let head = or_group.(ofs) in if head <> -1 then ( let and_group = and_net.(head) in solve_each_element_fast 0 and_group dirvec; solve_one_or_network_fast (ofs + 1) or_group dirvec ) else ()
	addi	x17, x3, 0	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	addi	x3, x0, 250	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	lui	x31, 1	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	addi	x31, x31, 3765	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	sw	x31, 0(x17)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	sw	x27, 7(x17)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	sw	x22, 6(x17)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	sw	x15, 5(x17)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	sw	x10, 4(x17)	# let rec trace_or_matrix_fast ofs or_network dirvec = let head = or_network.(ofs) in let range_primitive = head.(0) in if range_primitive = -1 then () else ( if range_primitive = 99 then solve_one_or_network_fast 1 head dirvec else ( let t = solver_fast2 range_primitive dirvec in if t <> 0 then let tp = solver_dist.(0) in if fless tp tmin.(0) then (solve_one_or_network_fast 1 head dirvec) else () else () ); trace_or_matrix_fast (ofs + 1) or_network dirvec )
	addi	x10, x3, 0	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	addi	x3, x0, 257	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	lui	x31, 1	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	addi	x31, x31, 3823	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x31, 0(x10)	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x17, 6(x10)	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x27, 5(x10)	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	sw	x5, 4(x10)	# let rec judge_intersection_fast dirvec = ( tmin.(0) <- (1000000000.0); trace_or_matrix_fast 0 (or_net.(0)) dirvec; let t = tmin.(0) in if (fless (-0.1) t) then (fless t 100000000.0) else false )
	addi	x15, x3, 0	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	addi	x3, x0, 263	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	lui	x31, 1	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	addi	x31, x31, 3855	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	sw	x31, 0(x15)	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	lw	x17, 15(x2)	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	sw	x17, 5(x15)	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	sw	x29, 4(x15)	# let rec get_nvector_rect dirvec = let rectside = intsec_rectside.(0) in vecbzero nvector; nvector.(rectside-1) <- fneg (sgn (dirvec.(rectside-1)))
	addi	x20, x3, 0	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	addi	x3, x0, 268	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	lui	x31, 1	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	addi	x31, x31, 3887	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	sw	x31, 0(x20)	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	sw	x17, 4(x20)	# let rec get_nvector_plane m = nvector.(0) <- fneg (o_param_a m); nvector.(1) <- fneg (o_param_b m); nvector.(2) <- fneg (o_param_c m)
	addi	x21, x3, 0	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	addi	x3, x0, 274	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	lui	x31, 1	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	addi	x31, x31, 3925	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	sw	x31, 0(x21)	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	sw	x17, 5(x21)	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	sw	x26, 4(x21)	# let rec get_nvector_second m = let p0 = intersection_point.(0) -. o_param_x m in let p1 = intersection_point.(1) -. o_param_y m in let p2 = intersection_point.(2) -. o_param_z m in let d0 = p0 *. o_param_a m in let d1 = p1 *. o_param_b m in let d2 = p2 *. o_param_c m in if o_isrot m = 0 then ( nvector.(0) <- d0; nvector.(1) <- d1; nvector.(2) <- d2 ) else ( nvector.(0) <- d0 +. fhalf (p1 *. o_param_r3 m +. p2 *. o_param_r2 m); nvector.(1) <- d1 +. fhalf (p0 *. o_param_r3 m +. p2 *. o_param_r1 m); nvector.(2) <- d2 +. fhalf (p0 *. o_param_r2 m +. p1 *. o_param_r1 m) ); vecunit_sgn nvector (o_isinvert m)
	addi	x22, x3, 0	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	addi	x3, x0, 281	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	lui	x31, 1	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	addi	x31, x31, 4121	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	sw	x31, 0(x22)	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	sw	x21, 6(x22)	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	sw	x15, 5(x22)	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	sw	x20, 4(x22)	# let rec get_nvector m dirvec = let m_shape = o_form m in if m_shape = 1 then get_nvector_rect dirvec else if m_shape = 2 then get_nvector_plane m else get_nvector_second m
	addi	x15, x3, 0	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x3, x0, 286	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	lui	x31, 1	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x31, x31, 4152	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	sw	x31, 0(x15)	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	lw	x20, 16(x2)	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	sw	x20, 4(x15)	# let rec utexture m p = let m_tex = o_texturetype m in texture_color.(0) <- o_color_red m; texture_color.(1) <- o_color_green m; texture_color.(2) <- o_color_blue m; if m_tex = 1 then ( let w1 = p.(0) -. o_param_x m in let flag1 = let d1 = (floor (w1 *. 0.05)) *. 20.0 in fless (w1 -. d1) 10.0 in let w3 = p.(2) -. o_param_z m in let flag2 = let d2 = (floor (w3 *. 0.05)) *. 20.0 in fless (w3 -. d2) 10.0 in texture_color.(1) <- if flag1 then (if flag2 then 255.0 else 0.0) else (if flag2 then 0.0 else 255.0) ) else if m_tex = 2 then ( let w2 = fsqr (sin (p.(1) *. 0.25)) in texture_color.(0) <- 255.0 *. w2; texture_color.(1) <- 255.0 *. (1.0 -. w2) ) else if m_tex = 3 then ( let w1 = p.(0) -. o_param_x m in let w3 = p.(2) -. o_param_z m in let w2 = sqrt (fsqr w1 +. fsqr w3) /. 10.0 in let w4 = (w2 -. floor w2) *. 3.1415927 in let cws = fsqr (cos w4) in texture_color.(1) <- cws *. 255.0; texture_color.(2) <- (1.0 -. cws) *. 255.0 ) else if m_tex = 4 then ( let w1 = (p.(0) -. o_param_x m) *. (sqrt (o_param_a m)) in let w3 = (p.(2) -. o_param_z m) *. (sqrt (o_param_c m)) in let w4 = (fsqr w1) +. (fsqr w3) in let w7 = if fless (fabs w1) 1.0e-4 then 15.0 else let w5 = fabs (w3 /. w1) in ((atan w5) *. 30.0) /. 3.1415927 in let w9 = w7 -. (floor w7) in let w2 = (p.(1) -. o_param_y m) *. (sqrt (o_param_b m)) in let w8 = if fless (fabs w4) 1.0e-4 then 15.0 else let w6 = fabs (w2 /. w4) in ((atan w6) *. 30.0) /. 3.1415927 in let w10 = w8 -. (floor w8) in let w11 = 0.15 -. (fsqr (0.5 -. w9)) -. (fsqr (0.5 -. w10)) in let w12 = if fisneg w11 then 0.0 else w11 in texture_color.(2) <- (255.0 *. w12) /. 0.3 ) else ()
	addi	x21, x3, 0	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	addi	x3, x0, 292	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	lui	x31, 1	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	addi	x31, x31, 4488	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	sw	x31, 0(x21)	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	sw	x20, 5(x21)	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	lw	x23, 18(x2)	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	sw	x23, 4(x21)	# let rec add_light bright hilight hilight_scale = if fispos bright then vecaccum rgb bright texture_color else (); if fispos hilight then ( let ihl = fsqr (fsqr hilight) *. hilight_scale in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else ()
	sw	x16, 36(x2)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else () in (****************************************************************************** 直接光を追跡する *****************************************************************************) let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else () in (****************************************************************************** 間接光を追跡する *****************************************************************************) (* 間接光の方向ベクトル dirvecに関しては定数テーブルが作られており、衝突判定 が高速に行われる。物体に当たったら、その後の反射は追跡しない *) let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else () in (* あらかじめ決められた方向ベクトルの配列に対し、各ベクトルの方角から来る 間接光の強さをサンプリングして加算する *) let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else () in let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118 in (* 半球方向の全部で300本のベクトルのうち、まだ追跡していない残りの240本の ベクトルについて間接光追跡する。60本のベクトル追跡を4セット行う *) let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else () in (* 上下左右4点の間接光追跡結果を使わず、300本全部のベクトルを追跡して間接光を 計算する。20%(60本)は追跡済なので、残り80%(240本)を追跡する *) let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray in (* 自分と上下左右4点の追跡結果を加算して間接光を求める。本来は 300 本の光を 追跡する必要があるが、5点加算するので1点あたり60本(20%)追跡するだけで済む *) let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray in let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else () in let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false in let rec get_surface_id pixel index = let surface_ids = p_surface_ids pixel in surface_ids.(index) in (* 上下左右4点の直接光追跡の結果、自分と同じ面に衝突しているかをチェック もし同じ面に衝突していれば、これら4点の結果を使うことで計算を省略出来る *) let rec neighbors_are_available x prev cur next nref = let sid_center = get_surface_id cur.(x) nref in if get_surface_id prev.(x) nref = sid_center then if get_surface_id next.(x) nref = sid_center then if get_surface_id cur.(x-1) nref = sid_center then if get_surface_id cur.(x+1) nref = sid_center then true else false else false else false else false in (* 直接光の各衝突点における間接受光の強さを、上下左右4点の結果を使用して計算 する。もし上下左右4点の計算結果を使えない場合は、その時点で do_without_neighborsに切り替える *) let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else () in (****************************************************************************** PPMファイルの書き込み関数 *****************************************************************************) let rec write_ppm_header _ = ( print_char 80; print_char (48 + 3); print_char 10; print_int image_size.(0); print_char 32; print_int image_size.(1); print_char 32; print_int 255; print_char 10 ) in let rec write_rgb_element x = let ix = int_of_float x in let elem = if ix > 255 then 255 else if ix < 0 then 0 else ix in print_int elem in let rec write_rgb _ = write_rgb_element rgb.(0); print_char 32; write_rgb_element rgb.(1); print_char 32; write_rgb_element rgb.(2); print_char 10 in (****************************************************************************** あるラインの計算に必要な情報を集めるため次のラインの追跡を行っておく関数群 *****************************************************************************) (* 間接光のサンプリングでは上下左右4点の結果を使うので、次のラインの計算を 行わないと最終的なピクセルの値を計算できない *) let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else () in let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else () in let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2 in (****************************************************************************** 直接光追跡と間接光20%追跡の結果から最終的なピクセル値を計算する関数 *****************************************************************************) let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else () in let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () ) in (****************************************************************************** ピクセルの情報を格納するデータ構造の割り当て関数群 *****************************************************************************) let rec create_float5x3array _ = ( let vec = create_array 3 0.0 in let array = create_array 5 vec in array.(1) <- create_array 3 0.0; array.(2) <- create_array 3 0.0; array.(3) <- create_array 3 0.0; array.(4) <- create_array 3 0.0; array ) in let rec create_pixel _ = let m_rgb = create_array 3 0.0 in let m_isect_ps = create_float5x3array() in let m_sids = create_array 5 0 in let m_cdif = create_array 5 false in let m_engy = create_float5x3array() in let m_r20p = create_float5x3array() in let m_gid = create_array 1 0 in let m_nvectors = create_float5x3array() in (m_rgb, m_isect_ps, m_sids, m_cdif, m_engy, m_r20p, m_gid, m_nvectors) in let rec init_line_elements line n = if n >= 0 then ( line.(n) <- create_pixel(); init_line_elements line (n-1) ) else line in let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2) in (****************************************************************************** 間接光のサンプリングにつかう方向ベクトル群を計算する関数群 *****************************************************************************) (* ベクトル達が出来るだけ一様に分布するよう、600本の方向ベクトルの向きを定める 立方体上の各面に100本ずつ分布させ、さらに、100本が立方体上の面上で10 x 10 の 格子状に並ぶような配列を使う。この配列では方角によるベクトルの密度の差が 大きいので、これに補正を加えたものを最終的に用いる *) let rec tan x = sin(x) /. cos(x) in let rec adjust_position h ratio = let l = sqrt(h*.h +. 0.1) in let tan_h = 1.0 /. l in let theta_h = atan tan_h in let tan_m = tan (theta_h *. ratio) in tan_m *. l in let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index in let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else () in let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else () in (****************************************************************************** dirvec のメモリ割り当てを行う *****************************************************************************) let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts) in let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else () in let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else () in (****************************************************************************** 補助関数達を呼び出してdirvecの初期化を行う *****************************************************************************) let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else () in let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else () in let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4 in (****************************************************************************** 完全鏡面反射成分を持つ物体の反射情報を初期化する *****************************************************************************) let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright) in let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3 in let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1 in let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else () in (***************************************************************************** 全体の制御 *****************************************************************************) let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 ) in let _ = rt 128 128 in 0
	addi	x16, x3, 0	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	addi	x3, x0, 304	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lui	x31, 1	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	addi	x31, x31, 4518	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x31, 0(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x24, 11(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	lw	x13, 34(x2)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x13, 10(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x5, 9(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x17, 8(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x10, 7(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x29, 6(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x25, 5(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	sw	x21, 4(x16)	# let rec trace_reflections index diffuse hilight_scale dirvec = if index >= 0 then ( let rinfo = reflections.(index) in let dvec = r_dvec rinfo in if judge_intersection_fast dvec then let surface_id = intersected_object_id.(0) * 4 + intsec_rectside.(0) in if surface_id = r_surface_id rinfo then if not (shadow_check_one_or_matrix 0 or_net.(0)) then let p = veciprod nvector (d_vec dvec) in let scale = r_bright rinfo in let bright = scale *. diffuse *. p in let hilight = scale *. veciprod dirvec (d_vec dvec) in add_light bright hilight hilight_scale else () else () else (); trace_reflections (index - 1) diffuse hilight_scale dirvec ) else ()
	addi	x13, x3, 0	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	addi	x3, x0, 328	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	lui	x31, 1	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	addi	x31, x31, 4656	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x31, 0(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x15, 23(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x16, 22(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x27, 21(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x20, 20(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x28, 19(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x24, 18(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x19, 17(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x23, 16(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x5, 15(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x14, 14(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x17, 13(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x4, 12(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x11, 11(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x18, 10(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x29, 9(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x26, 8(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x25, 7(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x22, 6(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x12, 5(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	sw	x21, 4(x13)	# let rec trace_ray nref energy dirvec pixel dist = if nref <= 4 then ( let surface_ids = p_surface_ids pixel in if judge_intersection dirvec then ( let obj_id = intersected_object_id.(0) in let obj = objects.(obj_id) in let m_surface = o_reflectiontype obj in let diffuse = o_diffuse obj *. energy in get_nvector obj dirvec; veccpy startp intersection_point; utexture obj intersection_point; surface_ids.(nref) <- obj_id * 4 + intsec_rectside.(0); let intersection_points = p_intersection_points pixel in veccpy intersection_points.(nref) intersection_point; let calc_diffuse = p_calc_diffuse pixel in if fless (o_diffuse obj) 0.5 then calc_diffuse.(nref) <- false else ( calc_diffuse.(nref) <- true; let energya = p_energy pixel in veccpy energya.(nref) texture_color; vecscale energya.(nref) ((1.0 /. 256.0) *. diffuse); let nvectors = p_nvectors pixel in veccpy nvectors.(nref) nvector; ); let w = (-2.0) *. veciprod dirvec nvector in vecaccum dirvec w nvector; let hilight_scale = energy *. o_hilight obj in if not (shadow_check_one_or_matrix 0 or_net.(0)) then let bright = fneg (veciprod nvector light) *. diffuse in let hilight = fneg (veciprod dirvec light) in add_light bright hilight hilight_scale else (); setup_startp intersection_point; trace_reflections (n_reflections.(0)-1) diffuse hilight_scale dirvec; if fless 0.1 energy then ( if(nref < 4) then surface_ids.(nref+1) <- -1 else (); if m_surface = 2 then ( let energy2 = energy *. (1.0 -. o_diffuse obj) in trace_ray (nref+1) energy2 dirvec pixel (dist +. tmin.(0)) ) else (); ) else () ) else ( surface_ids.(nref) <- -1; if nref <> 0 then ( let hl = fneg (veciprod dirvec light) in if fispos hl then ( let ihl = fsqr hl *. hl *. energy *. beam.(0) in rgb.(0) <- rgb.(0) +. ihl; rgb.(1) <- rgb.(1) +. ihl; rgb.(2) <- rgb.(2) +. ihl ) else () ) else () ) ) else ()
	addi	x12, x3, 0	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	addi	x3, x0, 344	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lui	x31, 1	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	addi	x31, x31, 5074	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x31, 0(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x15, 15(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x20, 14(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x24, 13(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x5, 12(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x14, 11(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x17, 10(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x11, 9(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x10, 8(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x26, 7(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x25, 6(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x22, 5(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	lw	x5, 17(x2)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	sw	x5, 4(x12)	# let rec trace_diffuse_ray dirvec energy = if judge_intersection_fast dirvec then let obj = objects.(intersected_object_id.(0)) in get_nvector obj (d_vec dirvec); utexture obj intersection_point; if not (shadow_check_one_or_matrix 0 or_net.(0)) then let br = fneg (veciprod nvector light) in let bright = (if fispos br then br else 0.0) in vecaccum diffuse_ray (energy *. bright *. o_diffuse obj) texture_color else () else ()
	addi	x10, x3, 0	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	addi	x3, x0, 349	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	lui	x31, 1	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	addi	x31, x31, 5189	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	sw	x31, 0(x10)	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	sw	x12, 4(x10)	# let rec iter_trace_diffuse_rays dirvec_group nvector org index = if index >= 0 then ( let p = veciprod (d_vec dirvec_group.(index)) nvector in (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っている 法線ベクトルと同じ向きの物を選んで使う *) if fisneg p then trace_diffuse_ray dirvec_group.(index + 1) (p /. -150.0) else trace_diffuse_ray dirvec_group.(index) (p /. 150.0); iter_trace_diffuse_rays dirvec_group nvector org (index - 2) ) else ()
	addi	x12, x3, 0	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	addi	x3, x0, 355	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	lui	x31, 1	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	addi	x31, x31, 5249	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	sw	x31, 0(x12)	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	sw	x19, 5(x12)	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	sw	x10, 4(x12)	# let rec trace_diffuse_rays dirvec_group nvector org = setup_startp org; (* 配列の 2n 番目と 2n+1 番目には互いに逆向の方向ベクトルが入っていて、 法線ベクトルと同じ向きの物のみサンプリングに使われる *) iter_trace_diffuse_rays dirvec_group nvector org 118
	addi	x10, x3, 0	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	addi	x3, x0, 361	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	lui	x31, 1	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	addi	x31, x31, 5271	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	sw	x31, 0(x10)	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	sw	x12, 5(x10)	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	lw	x15, 29(x2)	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	sw	x15, 4(x10)	# let rec trace_diffuse_ray_80percent group_id nvector org = if group_id <> 0 then trace_diffuse_rays dirvecs.(0) nvector org else (); if group_id <> 1 then trace_diffuse_rays dirvecs.(1) nvector org else (); if group_id <> 2 then trace_diffuse_rays dirvecs.(2) nvector org else (); if group_id <> 3 then trace_diffuse_rays dirvecs.(3) nvector org else (); if group_id <> 4 then trace_diffuse_rays dirvecs.(4) nvector org else ()
	addi	x16, x3, 0	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	addi	x3, x0, 368	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	lui	x31, 1	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	addi	x31, x31, 5342	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	sw	x31, 0(x16)	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	sw	x10, 6(x16)	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	sw	x23, 5(x16)	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	sw	x5, 4(x16)	# let rec calc_diffuse_using_1point pixel nref = let ray20p = p_received_ray_20percent pixel in let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in let energya = p_energy pixel in veccpy diffuse_ray ray20p.(nref); trace_diffuse_ray_80percent (p_group_id pixel) nvectors.(nref) intersection_points.(nref); vecaccumv rgb energya.(nref) diffuse_ray
	addi	x10, x3, 0	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	addi	x3, x0, 374	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	lui	x31, 1	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	addi	x31, x31, 5431	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	sw	x31, 0(x10)	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	sw	x23, 5(x10)	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	sw	x5, 4(x10)	# let rec calc_diffuse_using_5points x prev cur next nref = let r_up = p_received_ray_20percent prev.(x) in let r_left = p_received_ray_20percent cur.(x-1) in let r_center = p_received_ray_20percent cur.(x) in let r_right = p_received_ray_20percent cur.(x+1) in let r_down = p_received_ray_20percent next.(x) in veccpy diffuse_ray r_up.(nref); vecadd diffuse_ray r_left.(nref); vecadd diffuse_ray r_center.(nref); vecadd diffuse_ray r_right.(nref); vecadd diffuse_ray r_down.(nref); let energya = p_energy cur.(x) in vecaccumv rgb energya.(nref) diffuse_ray
	addi	x17, x3, 0	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	addi	x3, x0, 379	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	lui	x31, 1	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	addi	x31, x31, 5576	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	sw	x31, 0(x17)	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	sw	x16, 4(x17)	# let rec do_without_neighbors pixel nref = if nref <= 4 then let surface_ids = p_surface_ids pixel in if surface_ids.(nref) >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_1point pixel nref else (); do_without_neighbors pixel (nref + 1) ) else () else ()
	addi	x16, x3, 0	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	addi	x3, x0, 384	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	lui	x31, 1	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	addi	x31, x31, 5618	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	sw	x31, 0(x16)	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	lw	x18, 19(x2)	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	sw	x18, 4(x16)	# let rec neighbors_exist x y next = if (y + 1) < image_size.(1) then if y > 0 then if (x + 1) < image_size.(0) then if x > 0 then true else false else false else false else false
	addi	x19, x3, 0	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	addi	x3, x0, 390	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	lui	x31, 1	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	addi	x31, x31, 5730	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	sw	x31, 0(x19)	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	sw	x17, 5(x19)	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	sw	x10, 4(x19)	# let rec try_exploit_neighbors x y prev cur next nref = let pixel = cur.(x) in if nref <= 4 then if get_surface_id pixel nref >= 0 then if neighbors_are_available x prev cur next nref then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then calc_diffuse_using_5points x prev cur next nref else (); try_exploit_neighbors x y prev cur next (nref + 1) ) else do_without_neighbors cur.(x) nref else () else ()
	addi	x10, x3, 0	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	addi	x3, x0, 397	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	lui	x31, 1	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	addi	x31, x31, 5805	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	sw	x31, 0(x10)	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	sw	x12, 6(x10)	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	sw	x15, 5(x10)	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	sw	x5, 4(x10)	# let rec pretrace_diffuse_rays pixel nref = if nref <= 4 then let sid = get_surface_id pixel nref in if sid >= 0 then ( let calc_diffuse = p_calc_diffuse pixel in if calc_diffuse.(nref) then ( let group_id = p_group_id pixel in vecbzero diffuse_ray; (* 5つの方向ベクトル集合(各60本)から自分のグループIDに対応する物を 一つ選んで追跡 *) let nvectors = p_nvectors pixel in let intersection_points = p_intersection_points pixel in trace_diffuse_rays dirvecs.(group_id) nvectors.(nref) intersection_points.(nref); let ray20p = p_received_ray_20percent pixel in veccpy ray20p.(nref) diffuse_ray ) else (); pretrace_diffuse_rays pixel (nref + 1) ) else () else ()
	addi	x5, x3, 0	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	addi	x3, x0, 410	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lui	x31, 1	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	addi	x31, x31, 5912	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x31, 0(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x6, 12(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x13, 11(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x28, 10(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x9, 9(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x6, 21(x2)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x6, 8(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x23, 7(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x9, 27(x2)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x9, 6(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x10, 5(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	lw	x9, 20(x2)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	sw	x9, 4(x5)	# let rec pretrace_pixels line x group_id lc0 lc1 lc2 = if x >= 0 then ( let xdisp = scan_pitch.(0) *. float_of_int (x - image_center.(0)) in ptrace_dirvec.(0) <- xdisp *. screenx_dir.(0) +. lc0; ptrace_dirvec.(1) <- xdisp *. screenx_dir.(1) +. lc1; ptrace_dirvec.(2) <- xdisp *. screenx_dir.(2) +. lc2; vecunit_sgn ptrace_dirvec false; vecbzero rgb; veccpy startp viewpoint; trace_ray 0 1.0 ptrace_dirvec line.(x) 0.0; veccpy (p_rgb line.(x)) rgb; p_set_group_id line.(x) group_id; pretrace_diffuse_rays line.(x) 0; pretrace_pixels line (x-1) (add_mod5 group_id 1) lc0 lc1 lc2 ) else ()
	addi	x10, x3, 0	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	addi	x3, x0, 420	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	lui	x31, 1	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	addi	x31, x31, 6067	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	sw	x31, 0(x10)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	sw	x7, 9(x10)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	sw	x8, 8(x10)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	sw	x6, 7(x10)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	sw	x5, 6(x10)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	sw	x18, 5(x10)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	sw	x9, 4(x10)	# let rec pretrace_line line y group_id = let ydisp = scan_pitch.(0) *. float_of_int (y - image_center.(1)) in let lc0 = ydisp *. screeny_dir.(0) +. screenz_dir.(0) in let lc1 = ydisp *. screeny_dir.(1) +. screenz_dir.(1) in let lc2 = ydisp *. screeny_dir.(2) +. screenz_dir.(2) in pretrace_pixels line (image_size.(0) - 1) group_id lc0 lc1 lc2
	addi	x5, x3, 0	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	addi	x3, x0, 429	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	lui	x31, 1	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	addi	x31, x31, 6099	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	sw	x31, 0(x5)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	sw	x19, 8(x5)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	sw	x23, 7(x5)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	sw	x16, 6(x5)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	sw	x18, 5(x5)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	sw	x17, 4(x5)	# let rec scan_pixel x y prev cur next = if x < image_size.(0) then ( veccpy rgb (p_rgb cur.(x)); if neighbors_exist x y next then try_exploit_neighbors x y prev cur next 0 else do_without_neighbors cur.(x) 0; write_rgb (); scan_pixel (x + 1) y prev cur next ) else ()
	addi	x7, x3, 0	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	addi	x3, x0, 436	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	lui	x31, 2	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	addi	x31, x31, 6174	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	sw	x31, 0(x7)	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	sw	x5, 6(x7)	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	sw	x10, 5(x7)	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	sw	x18, 4(x7)	# let rec scan_line y prev cur next group_id = ( if y < image_size.(1) then ( if y < image_size.(1) - 1 then pretrace_line next (y + 1) group_id else (); scan_pixel 0 y prev cur next; scan_line (y + 1) cur next prev (add_mod5 group_id 2); ) else () )
	addi	x5, x3, 0	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	addi	x3, x0, 441	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	lui	x31, 2	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	addi	x31, x31, 6417	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	sw	x31, 0(x5)	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	sw	x18, 4(x5)	# let rec create_pixelline _ = let line = create_array image_size.(0) (create_pixel()) in init_line_elements line (image_size.(0)-2)
	addi	x8, x3, 0	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	addi	x3, x0, 446	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	lui	x31, 2	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	addi	x31, x31, 6448	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	sw	x31, 0(x8)	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	sw	x15, 4(x8)	# let rec calc_dirvec icount x y rx ry group_id index = if icount >= 5 then ( let l = sqrt(fsqr x +. fsqr y +. 1.0) in let vx = x /. l in let vy = y /. l in let vz = 1.0 /. l in let dgroup = dirvecs.(group_id) in vecset (d_vec dgroup.(index)) vx vy vz; vecset (d_vec dgroup.(index+40)) vx vz (fneg vy); vecset (d_vec dgroup.(index+80)) vz (fneg vx) (fneg vy); vecset (d_vec dgroup.(index+1)) (fneg vx) (fneg vy) (fneg vz); vecset (d_vec dgroup.(index+41)) (fneg vx) (fneg vz) vy; vecset (d_vec dgroup.(index+81)) (fneg vz) vx vy ) else let x2 = adjust_position y rx in calc_dirvec (icount + 1) x2 (adjust_position x2 ry) rx ry group_id index
	addi	x12, x3, 0	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	addi	x3, x0, 451	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	lui	x31, 2	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	addi	x31, x31, 6641	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	sw	x31, 0(x12)	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	sw	x8, 4(x12)	# let rec calc_dirvecs col ry group_id index = if col >= 0 then ( let rx = (float_of_int col) *. 0.2 -. 0.9 in calc_dirvec 0 0.0 0.0 rx ry group_id index; let rx2 = (float_of_int col) *. 0.2 +. 0.1 in calc_dirvec 0 0.0 0.0 rx2 ry group_id (index + 2); calc_dirvecs (col - 1) ry (add_mod5 group_id 1) index ) else ()
	addi	x8, x3, 0	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	addi	x3, x0, 456	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	lui	x31, 2	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	addi	x31, x31, 6717	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	sw	x31, 0(x8)	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	sw	x12, 4(x8)	# let rec calc_dirvec_rows row group_id index = if row >= 0 then ( let ry = (float_of_int row) *. 0.2 -. 0.9 in calc_dirvecs 4 ry group_id index; calc_dirvec_rows (row - 1) (add_mod5 group_id 2) (index + 4) ) else ()
	addi	x12, x3, 0	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	addi	x3, x0, 461	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	lui	x31, 2	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	addi	x31, x31, 6759	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	sw	x31, 0(x12)	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	lw	x13, 0(x2)	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	sw	x13, 4(x12)	# let rec create_dirvec _ = let v3 = create_array 3 0.0 in let consts = create_array n_objects.(0) v3 in (v3, consts)
	addi	x16, x3, 0	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	addi	x3, x0, 466	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	lui	x31, 2	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	addi	x31, x31, 6789	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	sw	x31, 0(x16)	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	sw	x12, 4(x16)	# let rec create_dirvec_elements d index = if index >= 0 then ( d.(index) <- create_dirvec(); create_dirvec_elements d (index - 1) ) else ()
	addi	x17, x3, 0	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	addi	x3, x0, 473	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	lui	x31, 2	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	addi	x31, x31, 6811	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	sw	x31, 0(x17)	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	sw	x15, 6(x17)	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	sw	x16, 5(x17)	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	sw	x12, 4(x17)	# let rec create_dirvecs index = if index >= 0 then ( dirvecs.(index) <- create_array 120 (create_dirvec()); create_dirvec_elements dirvecs.(index) 118; create_dirvecs (index-1) ) else ()
	addi	x16, x3, 0	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	addi	x3, x0, 478	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	lui	x31, 2	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	addi	x31, x31, 6857	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	sw	x31, 0(x16)	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	lw	x19, 36(x2)	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	sw	x19, 4(x16)	# let rec init_dirvec_constants vecset index = if index >= 0 then ( setup_dirvec_constants vecset.(index); init_dirvec_constants vecset (index - 1) ) else ()
	addi	x20, x3, 0	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	addi	x3, x0, 484	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	lui	x31, 2	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	addi	x31, x31, 6879	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	sw	x31, 0(x20)	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	sw	x16, 5(x20)	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	sw	x15, 4(x20)	# let rec init_vecset_constants index = if index >= 0 then ( init_dirvec_constants dirvecs.(index) 119; init_vecset_constants (index - 1) ) else ()
	addi	x15, x3, 0	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	addi	x3, x0, 491	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	lui	x31, 2	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	addi	x31, x31, 6902	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	sw	x31, 0(x15)	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	sw	x20, 6(x15)	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	sw	x17, 5(x15)	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	sw	x8, 4(x15)	# let rec init_dirvecs _ = create_dirvecs 4; calc_dirvec_rows 9 0 0; init_vecset_constants 4
	addi	x8, x3, 0	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	addi	x3, x0, 498	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	lui	x31, 2	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	addi	x31, x31, 6932	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	sw	x31, 0(x8)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	sw	x19, 6(x8)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	lw	x16, 34(x2)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	sw	x16, 5(x8)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	sw	x12, 4(x8)	# let rec add_reflection index surface_id bright v0 v1 v2 = let dvec = create_dirvec() in vecset (d_vec dvec) v0 v1 v2; setup_dirvec_constants dvec; reflections.(index) <- (surface_id, dvec, bright)
	addi	x12, x3, 0	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	addi	x3, x0, 505	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	lui	x31, 2	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	addi	x31, x31, 6990	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	sw	x31, 0(x12)	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	sw	x4, 6(x12)	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	sw	x11, 5(x12)	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	sw	x8, 4(x12)	# let rec setup_rect_reflection obj_id obj = let sid = obj_id * 4 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let n0 = fneg light.(0) in let n1 = fneg light.(1) in let n2 = fneg light.(2) in add_reflection nr (sid+1) br light.(0) n1 n2; add_reflection (nr+1) (sid+2) br n0 light.(1) n2; add_reflection (nr+2) (sid+3) br n0 n1 light.(2); n_reflections.(0) <- nr + 3
	addi	x16, x3, 0	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	addi	x3, x0, 512	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	lui	x31, 2	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	addi	x31, x31, 7078	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	sw	x31, 0(x16)	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	sw	x4, 6(x16)	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	sw	x11, 5(x16)	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	sw	x8, 4(x16)	# let rec setup_surface_reflection obj_id obj = let sid = obj_id * 4 + 1 in let nr = n_reflections.(0) in let br = 1.0 -. o_diffuse obj in let p = veciprod light (o_param_abc obj) in add_reflection nr sid br (2.0 *. o_param_a obj *. p -. light.(0)) (2.0 *. o_param_b obj *. p -. light.(1)) (2.0 *. o_param_c obj *. p -. light.(2)); n_reflections.(0) <- nr + 1
	addi	x4, x3, 0	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	addi	x3, x0, 519	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	lui	x31, 2	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	addi	x31, x31, 7181	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	sw	x31, 0(x4)	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	sw	x16, 6(x4)	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	sw	x12, 5(x4)	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	sw	x14, 4(x4)	# let rec setup_reflections obj_id = if obj_id >= 0 then let obj = objects.(obj_id) in if o_reflectiontype obj = 2 then if fless (o_diffuse obj) 1.0 then let m_shape = o_form obj in if m_shape = 1 then setup_rect_reflection obj_id obj else if m_shape = 2 then setup_surface_reflection obj_id obj else () else () else () else ()
	addi	x29, x3, 0	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lui	x31, 2	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	addi	x31, x31, 7236	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x31, 0(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x4, 16(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x19, 15(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x6, 14(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x7, 13(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x4, 35(x2)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x4, 12(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x10, 11(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x13, 10(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	lw	x4, 32(x2)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x4, 9(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x11, 8(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x15, 7(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x18, 6(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x9, 5(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	sw	x5, 4(x29)	# let rec rt size_x size_y = ( image_size.(0) <- size_x; image_size.(1) <- size_y; image_center.(0) <- size_x / 2; image_center.(1) <- size_y / 2; scan_pitch.(0) <- 128.0 /. float_of_int size_x; let prev = create_pixelline () in let cur = create_pixelline () in let next = create_pixelline () in read_parameter(); write_ppm_header (); init_dirvecs(); veccpy (d_vec light_dirvec) light; setup_dirvec_constants light_dirvec; setup_reflections (n_objects.(0) - 1); pretrace_line cur 0 0; scan_line 0 prev cur next 2 )
	addi	x4, x0, 128	# 128
	addi	x5, x0, 128	# 128
	sw	x1, 37(x2)	# rt 128 128
	addi	x2, x2, 38	# rt 128 128
	lw	x31, 0(x29)	# rt 128 128
	jalr	x1, x31, 0	# rt 128 128
	subi	x2, x2, 38	# rt 128 128
	lw	x1, 37(x2)	# rt 128 128
	addi	x4, x4, 0	# rt 128 128
# program ends
	addi x0, x0, 0
