	.data
	.literal8
	.align 3
l.4921:	# 128.000000
	.long	0
	.long	1080033280
	.align 3
l.4910:	# 40000.000000
	.long	0
	.long	1088653312
	.align 3
l.4858:	# -2.000000
	.long	0
	.long	-1073741824
	.align 3
l.4857:	# 0.100000
	.long	-1717986918
	.long	1069128089
	.align 3
l.4856:	# 0.200000
	.long	-1717986918
	.long	1070176665
	.align 3
l.4828:	# 20.000000
	.long	0
	.long	1077149696
	.align 3
l.4827:	# 0.050000
	.long	-1717986918
	.long	1068079513
	.align 3
l.4823:	# 0.250000
	.long	0
	.long	1070596096
	.align 3
l.4819:	# 255.000000
	.long	0
	.long	1081073664
	.align 3
l.4818:	# 3.141593
	.long	1518260631
	.long	1074340347
	.align 3
l.4817:	# 10.000000
	.long	0
	.long	1076101120
	.align 3
l.4813:	# 850.000000
	.long	0
	.long	1082822656
	.align 3
l.4812:	# 0.500000
	.long	0
	.long	1071644672
	.align 3
l.4811:	# 0.150000
	.long	858993459
	.long	1069757235
	.align 3
l.4809:	# 9.549296
	.long	1647403911
	.long	1076042045
	.align 3
l.4808:	# 15.000000
	.long	0
	.long	1076756480
	.align 3
l.4807:	# 0.000100
	.long	-350469331
	.long	1058682594
	.align 3
l.4761:	# 100000000.000000
	.long	0
	.long	1100470148
	.align 3
l.4757:	# 1000000000.000000
	.long	0
	.long	1104006501
	.align 3
l.4724:	# -0.100000
	.long	-1717986918
	.long	-1078355559
	.align 3
l.4709:	# 0.010000
	.long	1202590843
	.long	1065646817
	.align 3
l.4708:	# -0.200000
	.long	-1717986918
	.long	-1077306983
	.align 3
l.4682:	# 4.000000
	.long	0
	.long	1074790400
	.align 3
l.4481:	# -200.000000
	.long	0
	.long	-1066860544
	.align 3
l.4467:	# 0.017453
	.long	-1433277178
	.long	1066524486
	.align 3
l.4466:	# -1.000000
	.long	0
	.long	-1074790400
	.align 3
l.4465:	# 1.000000
	.long	0
	.long	1072693248
	.align 3
l.4464:	# 0.000000
	.long	0
	.long	0
	.align 3
l.4440:	# 2.000000
	.long	0
	.long	1073741824
	.text
	.globl _min_caml_start
	.align 2
xor.1977:	# 14:12-52
	cmpwi	cr7, r2, 0	# 14:30-52
	bne	cr7, beq_else.5685	# 14:30-52
#	14:51-52
	mr	r2, r5	# 14:51-52
	blr	# 14:51-52
beq_else.5685:	# 14:40-45
	cmpwi	cr7, r5, 0	# 14:40-45
	bne	cr7, beq_else.5686	# 14:40-45
#	14:40-45
	li	r2, 1	# 14:40-45
	blr	# 14:40-45
beq_else.5686:	# 14:40-45
	li	r2, 0	# 14:40-45
	blr	# 14:40-45
fsqr.1980:	# 17:12-35
	fmul	f0, f0, f0	# 17:29-35
	blr	# 17:29-35
fhalf.1982:	# 20:12-37
	lis	r31, ha16(l.4440)	# 20:35-37
	addi	r31, r31, lo16(l.4440)	# 20:35-37
	lfd	f1, 0(r31)	# 20:35-37
	fdiv	f0, f0, f1	# 20:30-37
	blr	# 20:30-37
o_texturetype.1984:	# 26:12 - 33:8
	lwz	r2, 0(r2)	# 28:3 - 33:8
	blr	# 33:3-8
o_form.1986:	# 36:12 - 43:10
	lwz	r2, 4(r2)	# 38:3 - 43:10
	blr	# 43:3-10
o_reflectiontype.1988:	# 46:12 - 53:12
	lwz	r2, 8(r2)	# 48:3 - 53:12
	blr	# 53:3-12
o_isinvert.1990:	# 56:12 - 62:11
	lwz	r2, 24(r2)	# 58:3 - 62:11
	blr	# 62:3-11
o_isrot.1992:	# 65:12 - 71:10
	lwz	r2, 12(r2)	# 67:3 - 71:10
	blr	# 71:3-10
o_param_a.1994:	# 74:12 - 81:12
	lwz	r2, 16(r2)	# 76:3 - 81:12
	lfd	f0, 0(r2)	# 81:3-12
	blr	# 81:3-12
o_param_b.1996:	# 84:12 - 91:12
	lwz	r2, 16(r2)	# 86:3 - 91:12
	lfd	f0, 8(r2)	# 91:3-12
	blr	# 91:3-12
o_param_c.1998:	# 94:12 - 101:12
	lwz	r2, 16(r2)	# 96:3 - 101:12
	lfd	f0, 16(r2)	# 101:3-12
	blr	# 101:3-12
o_param_x.2000:	# 104:12 - 111:12
	lwz	r2, 20(r2)	# 106:3 - 111:12
	lfd	f0, 0(r2)	# 111:3-12
	blr	# 111:3-12
o_param_y.2002:	# 114:12 - 121:12
	lwz	r2, 20(r2)	# 116:3 - 121:12
	lfd	f0, 8(r2)	# 121:3-12
	blr	# 121:3-12
o_param_z.2004:	# 124:12 - 131:12
	lwz	r2, 20(r2)	# 126:3 - 131:12
	lfd	f0, 16(r2)	# 131:3-12
	blr	# 131:3-12
o_diffuse.2006:	# 134:12 - 141:19
	lwz	r2, 28(r2)	# 136:3 - 141:19
	lfd	f0, 0(r2)	# 141:3-19
	blr	# 141:3-19
o_hilight.2008:	# 144:12 - 151:19
	lwz	r2, 28(r2)	# 146:3 - 151:19
	lfd	f0, 8(r2)	# 151:3-19
	blr	# 151:3-19
o_color_red.2010:	# 154:12 - 161:14
	lwz	r2, 32(r2)	# 156:3 - 161:14
	lfd	f0, 0(r2)	# 161:3-14
	blr	# 161:3-14
o_color_green.2012:	# 164:12 - 171:14
	lwz	r2, 32(r2)	# 166:3 - 171:14
	lfd	f0, 8(r2)	# 171:3-14
	blr	# 171:3-14
o_color_blue.2014:	# 174:12 - 181:14
	lwz	r2, 32(r2)	# 176:3 - 181:14
	lfd	f0, 16(r2)	# 181:3-14
	blr	# 181:3-14
o_param_r1.2016:	# 184:12 - 191:15
	lwz	r2, 36(r2)	# 186:3 - 191:15
	lfd	f0, 0(r2)	# 191:3-15
	blr	# 191:3-15
o_param_r2.2018:	# 194:12 - 201:15
	lwz	r2, 36(r2)	# 196:3 - 201:15
	lfd	f0, 8(r2)	# 201:3-15
	blr	# 201:3-15
o_param_r3.2020:	# 204:12 - 211:15
	lwz	r2, 36(r2)	# 206:3 - 211:15
	lfd	f0, 16(r2)	# 211:3-15
	blr	# 211:3-15
normalize_vector.2022:	# 214:12 - 220:22
	lfd	f0, 0(r2)	# 216:24-29
	stw	r5, 0(r3)	# 216:19-29
	stw	r2, 4(r3)	# 216:19-29
	mflr	r31	# 216:19-29
	stw	r31, 12(r3)	# 216:19-29
	addi	r3, r3, 16	# 216:19-29
	bl	fsqr.1980	# 216:19-29
	subi	r3, r3, 16	# 216:19-29
	lwz	r31, 12(r3)	# 216:19-29
	mtlr	r31	# 216:19-29
	lwz	r2, 4(r3)	# 216:38-43
	lfd	f1, 8(r2)	# 216:38-43
	stfd	f0, 8(r3)	# 216:33-43
	mflr	r31	# 216:33-43
	fmr	f0, f1	# 216:33-43
	stw	r31, 20(r3)	# 216:33-43
	addi	r3, r3, 24	# 216:33-43
	bl	fsqr.1980	# 216:33-43
	subi	r3, r3, 24	# 216:33-43
	lwz	r31, 20(r3)	# 216:33-43
	mtlr	r31	# 216:33-43
	lfd	f1, 8(r3)	# 216:19-43
	fadd	f0, f1, f0	# 216:19-43
	lwz	r2, 4(r3)	# 216:52-57
	lfd	f1, 16(r2)	# 216:52-57
	stfd	f0, 16(r3)	# 216:47-57
	mflr	r31	# 216:47-57
	fmr	f0, f1	# 216:47-57
	stw	r31, 28(r3)	# 216:47-57
	addi	r3, r3, 32	# 216:47-57
	bl	fsqr.1980	# 216:47-57
	subi	r3, r3, 32	# 216:47-57
	lwz	r31, 28(r3)	# 216:47-57
	mtlr	r31	# 216:47-57
	lfd	f1, 16(r3)	# 216:18-58
	fadd	f0, f1, f0	# 216:18-58
	mflr	r31	# 216:3-59
	stw	r31, 28(r3)	# 216:3-59
	addi	r3, r3, 32	# 216:3-59
	bl	min_caml_sqrt	# 216:3-59
	subi	r3, r3, 32	# 216:3-59
	lwz	r31, 28(r3)	# 216:3-59
	mtlr	r31	# 216:3-59
	lwz	r2, 0(r3)	# 217:3-35
	cmpwi	cr7, r2, 0	# 217:11-35
	bne	cr7, beq_else.5687	# 217:3-35
#	217:33-35
	b	beq_cont.5688
beq_else.5687:	# 217:23-27
	fneg	f0, f0	# 217:23-27
beq_cont.5688:	# 217:3-35
	lwz	r2, 4(r3)	# 218:12-17
	lfd	f1, 0(r2)	# 218:12-17
	fdiv	f1, f1, f0	# 218:12-22
	stfd	f1, 0(r2)	# 218:3-22
	lfd	f1, 8(r2)	# 219:12-17
	fdiv	f1, f1, f0	# 219:12-22
	stfd	f1, 8(r2)	# 219:3-22
	lfd	f1, 16(r2)	# 220:12-17
	fdiv	f0, f1, f0	# 220:12-22
	stfd	f0, 16(r2)	# 220:3-22
	blr	# 220:3-22
sgn.2025:	# 223:12 - 226:12
	lis	r31, ha16(l.4464)	# 225:6-9
	addi	r31, r31, lo16(l.4464)	# 225:6-9
	lfd	f1, 0(r31)	# 225:6-9
	fcmpu	cr7, f0, f1	# 225:6-13
	bgt	cr7, ble_else.5690	# 225:3 - 226:12
#	226:8-12
	lis	r31, ha16(l.4466)	# 226:8-12
	addi	r31, r31, lo16(l.4466)	# 226:8-12
	lfd	f0, 0(r31)	# 226:8-12
	blr	# 226:8-12
ble_else.5690:	# 225:19-22
	lis	r31, ha16(l.4465)	# 225:19-22
	addi	r31, r31, lo16(l.4465)	# 225:19-22
	lfd	f0, 0(r31)	# 225:19-22
	blr	# 225:19-22
rad.2027:	# 232:12-46
	lis	r31, ha16(l.4467)	# 232:33-46
	addi	r31, r31, lo16(l.4467)	# 232:33-46
	lfd	f1, 0(r31)	# 232:33-46
	fmul	f0, f0, f1	# 232:28-46
	blr	# 232:28-46
read_environ.2029:	# 236:12 - 274:35
	lis	r2, ha16(min_caml_screen)	# 241:3-9
	addi	r2, r2, lo16(min_caml_screen)	# 241:3-9
	stw	r2, 0(r3)	# 241:17-30
	mflr	r31	# 241:17-30
	stw	r31, 4(r3)	# 241:17-30
	addi	r3, r3, 8	# 241:17-30
	bl	min_caml_read_float	# 241:17-30
	subi	r3, r3, 8	# 241:17-30
	lwz	r31, 4(r3)	# 241:17-30
	mtlr	r31	# 241:17-30
	lwz	r2, 0(r3)	# 241:3-30
	stfd	f0, 0(r2)	# 241:3-30
	lis	r2, ha16(min_caml_screen)	# 242:3-9
	addi	r2, r2, lo16(min_caml_screen)	# 242:3-9
	stw	r2, 4(r3)	# 242:17-30
	mflr	r31	# 242:17-30
	stw	r31, 12(r3)	# 242:17-30
	addi	r3, r3, 16	# 242:17-30
	bl	min_caml_read_float	# 242:17-30
	subi	r3, r3, 16	# 242:17-30
	lwz	r31, 12(r3)	# 242:17-30
	mtlr	r31	# 242:17-30
	lwz	r2, 4(r3)	# 242:3-30
	stfd	f0, 8(r2)	# 242:3-30
	lis	r2, ha16(min_caml_screen)	# 243:3-9
	addi	r2, r2, lo16(min_caml_screen)	# 243:3-9
	stw	r2, 8(r3)	# 243:17-30
	mflr	r31	# 243:17-30
	stw	r31, 12(r3)	# 243:17-30
	addi	r3, r3, 16	# 243:17-30
	bl	min_caml_read_float	# 243:17-30
	subi	r3, r3, 16	# 243:17-30
	lwz	r31, 12(r3)	# 243:17-30
	mtlr	r31	# 243:17-30
	lwz	r2, 8(r3)	# 243:3-30
	stfd	f0, 16(r2)	# 243:3-30
	mflr	r31	# 245:16-31
	stw	r31, 12(r3)	# 245:16-31
	addi	r3, r3, 16	# 245:16-31
	bl	min_caml_read_float	# 245:16-31
	subi	r3, r3, 16	# 245:16-31
	lwz	r31, 12(r3)	# 245:16-31
	mtlr	r31	# 245:16-31
	mflr	r31	# 245:3-31
	stw	r31, 12(r3)	# 245:3-31
	addi	r3, r3, 16	# 245:3-31
	bl	rad.2027	# 245:3-31
	subi	r3, r3, 16	# 245:3-31
	lwz	r31, 12(r3)	# 245:3-31
	mtlr	r31	# 245:3-31
	lis	r2, ha16(min_caml_cos_v)	# 246:3-8
	addi	r2, r2, lo16(min_caml_cos_v)	# 246:3-8
	stfd	f0, 16(r3)	# 246:16-22
	stw	r2, 24(r3)	# 246:16-22
	mflr	r31	# 246:16-22
	stw	r31, 28(r3)	# 246:16-22
	addi	r3, r3, 32	# 246:16-22
	bl	min_caml_cos	# 246:16-22
	subi	r3, r3, 32	# 246:16-22
	lwz	r31, 28(r3)	# 246:16-22
	mtlr	r31	# 246:16-22
	lwz	r2, 24(r3)	# 246:3-22
	stfd	f0, 0(r2)	# 246:3-22
	lis	r2, ha16(min_caml_sin_v)	# 247:3-8
	addi	r2, r2, lo16(min_caml_sin_v)	# 247:3-8
	lfd	f0, 16(r3)	# 247:16-22
	stw	r2, 28(r3)	# 247:16-22
	mflr	r31	# 247:16-22
	stw	r31, 36(r3)	# 247:16-22
	addi	r3, r3, 40	# 247:16-22
	bl	min_caml_sin	# 247:16-22
	subi	r3, r3, 40	# 247:16-22
	lwz	r31, 36(r3)	# 247:16-22
	mtlr	r31	# 247:16-22
	lwz	r2, 28(r3)	# 247:3-22
	stfd	f0, 0(r2)	# 247:3-22
	mflr	r31	# 248:16-31
	stw	r31, 36(r3)	# 248:16-31
	addi	r3, r3, 40	# 248:16-31
	bl	min_caml_read_float	# 248:16-31
	subi	r3, r3, 40	# 248:16-31
	lwz	r31, 36(r3)	# 248:16-31
	mtlr	r31	# 248:16-31
	mflr	r31	# 248:3-31
	stw	r31, 36(r3)	# 248:3-31
	addi	r3, r3, 40	# 248:3-31
	bl	rad.2027	# 248:3-31
	subi	r3, r3, 40	# 248:3-31
	lwz	r31, 36(r3)	# 248:3-31
	mtlr	r31	# 248:3-31
	lis	r2, ha16(min_caml_cos_v)	# 249:3-8
	addi	r2, r2, lo16(min_caml_cos_v)	# 249:3-8
	stfd	f0, 32(r3)	# 249:16-22
	stw	r2, 40(r3)	# 249:16-22
	mflr	r31	# 249:16-22
	stw	r31, 44(r3)	# 249:16-22
	addi	r3, r3, 48	# 249:16-22
	bl	min_caml_cos	# 249:16-22
	subi	r3, r3, 48	# 249:16-22
	lwz	r31, 44(r3)	# 249:16-22
	mtlr	r31	# 249:16-22
	lwz	r2, 40(r3)	# 249:3-22
	stfd	f0, 8(r2)	# 249:3-22
	lis	r2, ha16(min_caml_sin_v)	# 250:3-8
	addi	r2, r2, lo16(min_caml_sin_v)	# 250:3-8
	lfd	f0, 32(r3)	# 250:16-22
	stw	r2, 44(r3)	# 250:16-22
	mflr	r31	# 250:16-22
	stw	r31, 52(r3)	# 250:16-22
	addi	r3, r3, 56	# 250:16-22
	bl	min_caml_sin	# 250:16-22
	subi	r3, r3, 56	# 250:16-22
	lwz	r31, 52(r3)	# 250:16-22
	mtlr	r31	# 250:16-22
	lwz	r2, 44(r3)	# 250:3-22
	stfd	f0, 8(r2)	# 250:3-22
	mflr	r31	# 252:3-25
	stw	r31, 52(r3)	# 252:3-25
	addi	r3, r3, 56	# 252:3-25
	bl	min_caml_read_float	# 252:3-25
	subi	r3, r3, 56	# 252:3-25
	lwz	r31, 52(r3)	# 252:3-25
	mtlr	r31	# 252:3-25
	mflr	r31	# 255:16-31
	stw	r31, 52(r3)	# 255:16-31
	addi	r3, r3, 56	# 255:16-31
	bl	min_caml_read_float	# 255:16-31
	subi	r3, r3, 56	# 255:16-31
	lwz	r31, 52(r3)	# 255:16-31
	mtlr	r31	# 255:16-31
	mflr	r31	# 255:3-31
	stw	r31, 52(r3)	# 255:3-31
	addi	r3, r3, 56	# 255:3-31
	bl	rad.2027	# 255:3-31
	subi	r3, r3, 56	# 255:3-31
	lwz	r31, 52(r3)	# 255:3-31
	mtlr	r31	# 255:3-31
	stfd	f0, 48(r3)	# 256:13-19
	mflr	r31	# 256:3-19
	stw	r31, 60(r3)	# 256:3-19
	addi	r3, r3, 64	# 256:3-19
	bl	min_caml_sin	# 256:3-19
	subi	r3, r3, 64	# 256:3-19
	lwz	r31, 60(r3)	# 256:3-19
	mtlr	r31	# 256:3-19
	lis	r2, ha16(min_caml_light)	# 257:3-8
	addi	r2, r2, lo16(min_caml_light)	# 257:3-8
	fneg	f0, f0	# 257:16-21
	stfd	f0, 8(r2)	# 257:3-21
	mflr	r31	# 258:16-31
	stw	r31, 60(r3)	# 258:16-31
	addi	r3, r3, 64	# 258:16-31
	bl	min_caml_read_float	# 258:16-31
	subi	r3, r3, 64	# 258:16-31
	lwz	r31, 60(r3)	# 258:16-31
	mtlr	r31	# 258:16-31
	mflr	r31	# 258:3-31
	stw	r31, 60(r3)	# 258:3-31
	addi	r3, r3, 64	# 258:3-31
	bl	rad.2027	# 258:3-31
	subi	r3, r3, 64	# 258:3-31
	lwz	r31, 60(r3)	# 258:3-31
	mtlr	r31	# 258:3-31
	lfd	f1, 48(r3)	# 259:3-19
	stfd	f0, 56(r3)	# 259:13-19
	mflr	r31	# 259:3-19
	fmr	f0, f1	# 259:3-19
	stw	r31, 68(r3)	# 259:3-19
	addi	r3, r3, 72	# 259:3-19
	bl	min_caml_cos	# 259:3-19
	subi	r3, r3, 72	# 259:3-19
	lwz	r31, 68(r3)	# 259:3-19
	mtlr	r31	# 259:3-19
	lfd	f1, 56(r3)	# 260:3-19
	stfd	f0, 64(r3)	# 260:13-19
	mflr	r31	# 260:3-19
	fmr	f0, f1	# 260:3-19
	stw	r31, 76(r3)	# 260:3-19
	addi	r3, r3, 80	# 260:3-19
	bl	min_caml_sin	# 260:3-19
	subi	r3, r3, 80	# 260:3-19
	lwz	r31, 76(r3)	# 260:3-19
	mtlr	r31	# 260:3-19
	lis	r2, ha16(min_caml_light)	# 261:3-8
	addi	r2, r2, lo16(min_caml_light)	# 261:3-8
	lfd	f1, 64(r3)	# 261:16-26
	fmul	f0, f1, f0	# 261:16-26
	stfd	f0, 0(r2)	# 261:3-26
	lfd	f0, 56(r3)	# 262:3-19
	mflr	r31	# 262:3-19
	stw	r31, 76(r3)	# 262:3-19
	addi	r3, r3, 80	# 262:3-19
	bl	min_caml_cos	# 262:3-19
	subi	r3, r3, 80	# 262:3-19
	lwz	r31, 76(r3)	# 262:3-19
	mtlr	r31	# 262:3-19
	lis	r2, ha16(min_caml_light)	# 263:3-8
	addi	r2, r2, lo16(min_caml_light)	# 263:3-8
	lfd	f1, 64(r3)	# 263:16-26
	fmul	f0, f1, f0	# 263:16-26
	stfd	f0, 16(r2)	# 263:3-26
	lis	r2, ha16(min_caml_beam)	# 264:3-7
	addi	r2, r2, lo16(min_caml_beam)	# 264:3-7
	stw	r2, 72(r3)	# 264:15-28
	mflr	r31	# 264:15-28
	stw	r31, 76(r3)	# 264:15-28
	addi	r3, r3, 80	# 264:15-28
	bl	min_caml_read_float	# 264:15-28
	subi	r3, r3, 80	# 264:15-28
	lwz	r31, 76(r3)	# 264:15-28
	mtlr	r31	# 264:15-28
	lwz	r2, 72(r3)	# 264:3-28
	stfd	f0, 0(r2)	# 264:3-28
	lis	r2, ha16(min_caml_vp)	# 267:3-5
	addi	r2, r2, lo16(min_caml_vp)	# 267:3-5
	lis	r5, ha16(min_caml_cos_v)	# 267:13-18
	addi	r5, r5, lo16(min_caml_cos_v)	# 267:13-18
	lfd	f0, 0(r5)	# 267:13-22
	lis	r5, ha16(min_caml_sin_v)	# 267:26-31
	addi	r5, r5, lo16(min_caml_sin_v)	# 267:26-31
	lfd	f1, 8(r5)	# 267:26-35
	fmul	f0, f0, f1	# 267:13-35
	lis	r31, ha16(l.4481)	# 267:39-47
	addi	r31, r31, lo16(l.4481)	# 267:39-47
	lfd	f1, 0(r31)	# 267:39-47
	fmul	f0, f0, f1	# 267:13-47
	stfd	f0, 0(r2)	# 267:3-47
	lis	r2, ha16(min_caml_vp)	# 268:3-5
	addi	r2, r2, lo16(min_caml_vp)	# 268:3-5
	lis	r5, ha16(min_caml_sin_v)	# 268:16-21
	addi	r5, r5, lo16(min_caml_sin_v)	# 268:16-21
	lfd	f0, 0(r5)	# 268:16-25
	fneg	f0, f0	# 268:13-26
	lis	r31, ha16(l.4481)	# 268:30-38
	addi	r31, r31, lo16(l.4481)	# 268:30-38
	lfd	f1, 0(r31)	# 268:30-38
	fmul	f0, f0, f1	# 268:13-38
	stfd	f0, 8(r2)	# 268:3-38
	lis	r2, ha16(min_caml_vp)	# 269:3-5
	addi	r2, r2, lo16(min_caml_vp)	# 269:3-5
	lis	r5, ha16(min_caml_cos_v)	# 269:13-18
	addi	r5, r5, lo16(min_caml_cos_v)	# 269:13-18
	lfd	f0, 0(r5)	# 269:13-22
	lis	r5, ha16(min_caml_cos_v)	# 269:26-31
	addi	r5, r5, lo16(min_caml_cos_v)	# 269:26-31
	lfd	f1, 8(r5)	# 269:26-35
	fmul	f0, f0, f1	# 269:13-35
	lis	r31, ha16(l.4481)	# 269:39-47
	addi	r31, r31, lo16(l.4481)	# 269:39-47
	lfd	f1, 0(r31)	# 269:39-47
	fmul	f0, f0, f1	# 269:13-47
	stfd	f0, 16(r2)	# 269:3-47
	lis	r2, ha16(min_caml_view)	# 272:3-7
	addi	r2, r2, lo16(min_caml_view)	# 272:3-7
	lis	r5, ha16(min_caml_vp)	# 272:15-17
	addi	r5, r5, lo16(min_caml_vp)	# 272:15-17
	lfd	f0, 0(r5)	# 272:15-21
	lis	r5, ha16(min_caml_screen)	# 272:25-31
	addi	r5, r5, lo16(min_caml_screen)	# 272:25-31
	lfd	f1, 0(r5)	# 272:25-35
	fadd	f0, f0, f1	# 272:15-35
	stfd	f0, 0(r2)	# 272:3-35
	lis	r2, ha16(min_caml_view)	# 273:3-7
	addi	r2, r2, lo16(min_caml_view)	# 273:3-7
	lis	r5, ha16(min_caml_vp)	# 273:15-17
	addi	r5, r5, lo16(min_caml_vp)	# 273:15-17
	lfd	f0, 8(r5)	# 273:15-21
	lis	r5, ha16(min_caml_screen)	# 273:25-31
	addi	r5, r5, lo16(min_caml_screen)	# 273:25-31
	lfd	f1, 8(r5)	# 273:25-35
	fadd	f0, f0, f1	# 273:15-35
	stfd	f0, 8(r2)	# 273:3-35
	lis	r2, ha16(min_caml_view)	# 274:3-7
	addi	r2, r2, lo16(min_caml_view)	# 274:3-7
	lis	r5, ha16(min_caml_vp)	# 274:15-17
	addi	r5, r5, lo16(min_caml_vp)	# 274:15-17
	lfd	f0, 16(r5)	# 274:15-21
	lis	r5, ha16(min_caml_screen)	# 274:25-31
	addi	r5, r5, lo16(min_caml_screen)	# 274:25-31
	lfd	f1, 16(r5)	# 274:25-35
	fadd	f0, f0, f1	# 274:15-35
	stfd	f0, 16(r2)	# 274:3-35
	blr	# 274:3-35
read_nth_object.2031:	# 278:12 - 397:10
	stw	r2, 0(r3)	# 283:17-28
	mflr	r31	# 283:3-28
	stw	r31, 4(r3)	# 283:3-28
	addi	r3, r3, 8	# 283:3-28
	bl	min_caml_read_int	# 283:3-28
	subi	r3, r3, 8	# 283:3-28
	lwz	r31, 4(r3)	# 283:3-28
	mtlr	r31	# 283:3-28
	cmpwi	cr7, r2, -1	# 284:6-19
	bne	cr7, beq_else.5693	# 284:3 - 397:10
#	397:5-10
	li	r2, 0	# 397:5-10
	blr	# 397:5-10
beq_else.5693:	# 285:5 - 395:7
	stw	r2, 4(r3)	# 286:18-29
	mflr	r31	# 286:7-29
	stw	r31, 12(r3)	# 286:7-29
	addi	r3, r3, 16	# 286:7-29
	bl	min_caml_read_int	# 286:7-29
	subi	r3, r3, 16	# 286:7-29
	lwz	r31, 12(r3)	# 286:7-29
	mtlr	r31	# 286:7-29
	stw	r2, 8(r3)	# 287:22-33
	mflr	r31	# 287:7-33
	stw	r31, 12(r3)	# 287:7-33
	addi	r3, r3, 16	# 287:7-33
	bl	min_caml_read_int	# 287:7-33
	subi	r3, r3, 16	# 287:7-33
	lwz	r31, 12(r3)	# 287:7-33
	mtlr	r31	# 287:7-33
	stw	r2, 12(r3)	# 288:21-32
	mflr	r31	# 288:7-32
	stw	r31, 20(r3)	# 288:7-32
	addi	r3, r3, 24	# 288:7-32
	bl	min_caml_read_int	# 288:7-32
	subi	r3, r3, 24	# 288:7-32
	lwz	r31, 20(r3)	# 288:7-32
	mtlr	r31	# 288:7-32
	li	r5, 3	# 290:28-29
	lis	r31, ha16(l.4464)	# 290:30-33
	addi	r31, r31, lo16(l.4464)	# 290:30-33
	lfd	f0, 0(r31)	# 290:30-33
	stw	r2, 16(r3)	# 290:17-33
	mflr	r31	# 290:7-33
	mr	r2, r5	# 290:7-33
	stw	r31, 20(r3)	# 290:7-33
	addi	r3, r3, 24	# 290:7-33
	bl	min_caml_create_float_array	# 290:7-33
	subi	r3, r3, 24	# 290:7-33
	lwz	r31, 20(r3)	# 290:7-33
	mtlr	r31	# 290:7-33
	stw	r2, 20(r3)	# 292:18-31
	mflr	r31	# 292:18-31
	stw	r31, 28(r3)	# 292:18-31
	addi	r3, r3, 32	# 292:18-31
	bl	min_caml_read_float	# 292:18-31
	subi	r3, r3, 32	# 292:18-31
	lwz	r31, 28(r3)	# 292:18-31
	mtlr	r31	# 292:18-31
	lwz	r2, 20(r3)	# 292:7-31
	stfd	f0, 0(r2)	# 292:7-31
	mflr	r31	# 293:18-31
	stw	r31, 28(r3)	# 293:18-31
	addi	r3, r3, 32	# 293:18-31
	bl	min_caml_read_float	# 293:18-31
	subi	r3, r3, 32	# 293:18-31
	lwz	r31, 28(r3)	# 293:18-31
	mtlr	r31	# 293:18-31
	lwz	r2, 20(r3)	# 293:7-31
	stfd	f0, 8(r2)	# 293:7-31
	mflr	r31	# 294:18-31
	stw	r31, 28(r3)	# 294:18-31
	addi	r3, r3, 32	# 294:18-31
	bl	min_caml_read_float	# 294:18-31
	subi	r3, r3, 32	# 294:18-31
	lwz	r31, 28(r3)	# 294:18-31
	mtlr	r31	# 294:18-31
	lwz	r2, 20(r3)	# 294:7-31
	stfd	f0, 16(r2)	# 294:7-31
	li	r5, 3	# 296:28-29
	lis	r31, ha16(l.4464)	# 296:30-33
	addi	r31, r31, lo16(l.4464)	# 296:30-33
	lfd	f0, 0(r31)	# 296:30-33
	mflr	r31	# 296:7-33
	mr	r2, r5	# 296:7-33
	stw	r31, 28(r3)	# 296:7-33
	addi	r3, r3, 32	# 296:7-33
	bl	min_caml_create_float_array	# 296:7-33
	subi	r3, r3, 32	# 296:7-33
	lwz	r31, 28(r3)	# 296:7-33
	mtlr	r31	# 296:7-33
	stw	r2, 24(r3)	# 298:18-31
	mflr	r31	# 298:18-31
	stw	r31, 28(r3)	# 298:18-31
	addi	r3, r3, 32	# 298:18-31
	bl	min_caml_read_float	# 298:18-31
	subi	r3, r3, 32	# 298:18-31
	lwz	r31, 28(r3)	# 298:18-31
	mtlr	r31	# 298:18-31
	lwz	r2, 24(r3)	# 298:7-31
	stfd	f0, 0(r2)	# 298:7-31
	mflr	r31	# 299:18-31
	stw	r31, 28(r3)	# 299:18-31
	addi	r3, r3, 32	# 299:18-31
	bl	min_caml_read_float	# 299:18-31
	subi	r3, r3, 32	# 299:18-31
	lwz	r31, 28(r3)	# 299:18-31
	mtlr	r31	# 299:18-31
	lwz	r2, 24(r3)	# 299:7-31
	stfd	f0, 8(r2)	# 299:7-31
	mflr	r31	# 300:18-31
	stw	r31, 28(r3)	# 300:18-31
	addi	r3, r3, 32	# 300:18-31
	bl	min_caml_read_float	# 300:18-31
	subi	r3, r3, 32	# 300:18-31
	lwz	r31, 28(r3)	# 300:18-31
	mtlr	r31	# 300:18-31
	lwz	r2, 24(r3)	# 300:7-31
	stfd	f0, 16(r2)	# 300:7-31
	lis	r31, ha16(l.4464)	# 302:22-25
	addi	r31, r31, lo16(l.4464)	# 302:22-25
	lfd	f0, 0(r31)	# 302:22-25
	stfd	f0, 32(r3)	# 302:28-43
	mflr	r31	# 302:28-43
	stw	r31, 44(r3)	# 302:28-43
	addi	r3, r3, 48	# 302:28-43
	bl	min_caml_read_float	# 302:28-43
	subi	r3, r3, 48	# 302:28-43
	lwz	r31, 44(r3)	# 302:28-43
	mtlr	r31	# 302:28-43
	lfd	f1, 32(r3)	# 302:7-43
	fcmpu	cr7, f1, f0	# 302:22-43
	bgt	cr7, ble_else.5695	# 302:7-43
#	302:22-43
	li	r2, 0	# 302:22-43
	b	ble_cont.5696
ble_else.5695:	# 302:22-43
	li	r2, 1	# 302:22-43
ble_cont.5696:	# 302:7-43
	li	r5, 2	# 304:34-35
	lis	r31, ha16(l.4464)	# 304:36-39
	addi	r31, r31, lo16(l.4464)	# 304:36-39
	lfd	f0, 0(r31)	# 304:36-39
	stw	r2, 40(r3)	# 304:23-39
	mflr	r31	# 304:7-39
	mr	r2, r5	# 304:7-39
	stw	r31, 44(r3)	# 304:7-39
	addi	r3, r3, 48	# 304:7-39
	bl	min_caml_create_float_array	# 304:7-39
	subi	r3, r3, 48	# 304:7-39
	lwz	r31, 44(r3)	# 304:7-39
	mtlr	r31	# 304:7-39
	stw	r2, 44(r3)	# 306:24-37
	mflr	r31	# 306:24-37
	stw	r31, 52(r3)	# 306:24-37
	addi	r3, r3, 56	# 306:24-37
	bl	min_caml_read_float	# 306:24-37
	subi	r3, r3, 56	# 306:24-37
	lwz	r31, 52(r3)	# 306:24-37
	mtlr	r31	# 306:24-37
	lwz	r2, 44(r3)	# 306:7-37
	stfd	f0, 0(r2)	# 306:7-37
	mflr	r31	# 307:24-37
	stw	r31, 52(r3)	# 307:24-37
	addi	r3, r3, 56	# 307:24-37
	bl	min_caml_read_float	# 307:24-37
	subi	r3, r3, 56	# 307:24-37
	lwz	r31, 52(r3)	# 307:24-37
	mtlr	r31	# 307:24-37
	lwz	r2, 44(r3)	# 307:7-37
	stfd	f0, 8(r2)	# 307:7-37
	li	r5, 3	# 309:30-31
	lis	r31, ha16(l.4464)	# 309:32-35
	addi	r31, r31, lo16(l.4464)	# 309:32-35
	lfd	f0, 0(r31)	# 309:32-35
	mflr	r31	# 309:7-35
	mr	r2, r5	# 309:7-35
	stw	r31, 52(r3)	# 309:7-35
	addi	r3, r3, 56	# 309:7-35
	bl	min_caml_create_float_array	# 309:7-35
	subi	r3, r3, 56	# 309:7-35
	lwz	r31, 52(r3)	# 309:7-35
	mtlr	r31	# 309:7-35
	stw	r2, 48(r3)	# 311:20-33
	mflr	r31	# 311:20-33
	stw	r31, 52(r3)	# 311:20-33
	addi	r3, r3, 56	# 311:20-33
	bl	min_caml_read_float	# 311:20-33
	subi	r3, r3, 56	# 311:20-33
	lwz	r31, 52(r3)	# 311:20-33
	mtlr	r31	# 311:20-33
	lwz	r2, 48(r3)	# 311:7-33
	stfd	f0, 0(r2)	# 311:7-33
	mflr	r31	# 312:20-33
	stw	r31, 52(r3)	# 312:20-33
	addi	r3, r3, 56	# 312:20-33
	bl	min_caml_read_float	# 312:20-33
	subi	r3, r3, 56	# 312:20-33
	lwz	r31, 52(r3)	# 312:20-33
	mtlr	r31	# 312:20-33
	lwz	r2, 48(r3)	# 312:7-33
	stfd	f0, 8(r2)	# 312:7-33
	mflr	r31	# 313:20-33
	stw	r31, 52(r3)	# 313:20-33
	addi	r3, r3, 56	# 313:20-33
	bl	min_caml_read_float	# 313:20-33
	subi	r3, r3, 56	# 313:20-33
	lwz	r31, 52(r3)	# 313:20-33
	mtlr	r31	# 313:20-33
	lwz	r2, 48(r3)	# 313:7-33
	stfd	f0, 16(r2)	# 313:7-33
	li	r5, 3	# 315:33-34
	lis	r31, ha16(l.4464)	# 315:35-38
	addi	r31, r31, lo16(l.4464)	# 315:35-38
	lfd	f0, 0(r31)	# 315:35-38
	mflr	r31	# 315:7-38
	mr	r2, r5	# 315:7-38
	stw	r31, 52(r3)	# 315:7-38
	addi	r3, r3, 56	# 315:7-38
	bl	min_caml_create_float_array	# 315:7-38
	subi	r3, r3, 56	# 315:7-38
	lwz	r31, 52(r3)	# 315:7-38
	mtlr	r31	# 315:7-38
	lwz	r5, 16(r3)	# 316:7 - 322:14
	cmpwi	cr7, r5, 0	# 316:10-22
	bne	cr7, beq_else.5697	# 316:7 - 322:14
#	322:12-14
	b	beq_cont.5698
beq_else.5697:	# 317:9 - 321:10
	stw	r2, 52(r3)	# 318:30-45
	mflr	r31	# 318:30-45
	stw	r31, 60(r3)	# 318:30-45
	addi	r3, r3, 64	# 318:30-45
	bl	min_caml_read_float	# 318:30-45
	subi	r3, r3, 64	# 318:30-45
	lwz	r31, 60(r3)	# 318:30-45
	mtlr	r31	# 318:30-45
	mflr	r31	# 318:26-45
	stw	r31, 60(r3)	# 318:26-45
	addi	r3, r3, 64	# 318:26-45
	bl	rad.2027	# 318:26-45
	subi	r3, r3, 64	# 318:26-45
	lwz	r31, 60(r3)	# 318:26-45
	mtlr	r31	# 318:26-45
	lwz	r2, 52(r3)	# 318:10-45
	stfd	f0, 0(r2)	# 318:10-45
	mflr	r31	# 319:30-45
	stw	r31, 60(r3)	# 319:30-45
	addi	r3, r3, 64	# 319:30-45
	bl	min_caml_read_float	# 319:30-45
	subi	r3, r3, 64	# 319:30-45
	lwz	r31, 60(r3)	# 319:30-45
	mtlr	r31	# 319:30-45
	mflr	r31	# 319:26-45
	stw	r31, 60(r3)	# 319:26-45
	addi	r3, r3, 64	# 319:26-45
	bl	rad.2027	# 319:26-45
	subi	r3, r3, 64	# 319:26-45
	lwz	r31, 60(r3)	# 319:26-45
	mtlr	r31	# 319:26-45
	lwz	r2, 52(r3)	# 319:10-45
	stfd	f0, 8(r2)	# 319:10-45
	mflr	r31	# 320:30-45
	stw	r31, 60(r3)	# 320:30-45
	addi	r3, r3, 64	# 320:30-45
	bl	min_caml_read_float	# 320:30-45
	subi	r3, r3, 64	# 320:30-45
	lwz	r31, 60(r3)	# 320:30-45
	mtlr	r31	# 320:30-45
	mflr	r31	# 320:26-45
	stw	r31, 60(r3)	# 320:26-45
	addi	r3, r3, 64	# 320:26-45
	bl	rad.2027	# 320:26-45
	subi	r3, r3, 64	# 320:26-45
	lwz	r31, 60(r3)	# 320:26-45
	mtlr	r31	# 320:26-45
	lwz	r2, 52(r3)	# 320:10-45
	stfd	f0, 16(r2)	# 320:10-45
beq_cont.5698:	# 316:7 - 322:14
	lwz	r5, 8(r3)	# 327:7-58
	cmpwi	cr7, r5, 2	# 327:26-34
	bne	cr7, beq_else.5699	# 327:7-58
#	327:40-44
	li	r6, 1	# 327:40-44
	b	beq_cont.5700
beq_else.5699:	# 327:50-58
	lwz	r6, 40(r3)	# 327:50-58
beq_cont.5700:	# 327:7-58
	mr	r7, r4	# 331:9 - 337:10
	addi	r4, r4, 40	# 331:9 - 337:10
	stw	r2, 36(r7)	# 331:9 - 337:10
	lwz	r8, 48(r3)	# 331:9 - 337:10
	stw	r8, 32(r7)	# 331:9 - 337:10
	lwz	r8, 44(r3)	# 331:9 - 337:10
	stw	r8, 28(r7)	# 331:9 - 337:10
	stw	r6, 24(r7)	# 331:9 - 337:10
	lwz	r6, 24(r3)	# 331:9 - 337:10
	stw	r6, 20(r7)	# 331:9 - 337:10
	lwz	r6, 20(r3)	# 331:9 - 337:10
	stw	r6, 16(r7)	# 331:9 - 337:10
	lwz	r8, 16(r3)	# 331:9 - 337:10
	stw	r8, 12(r7)	# 331:9 - 337:10
	lwz	r9, 12(r3)	# 331:9 - 337:10
	stw	r9, 8(r7)	# 331:9 - 337:10
	stw	r5, 4(r7)	# 331:9 - 337:10
	lwz	r9, 4(r3)	# 331:9 - 337:10
	stw	r9, 0(r7)	# 331:9 - 337:10
	lis	r9, ha16(min_caml_objects)	# 338:7-14
	addi	r9, r9, lo16(min_caml_objects)	# 338:7-14
	lwz	r10, 0(r3)	# 338:7-25
	slwi	r10, r10, 2	# 338:7-25
	stwx	r7, r9, r10	# 338:7-25
	stw	r2, 52(r3)	# 340:10-18
	cmpwi	cr7, r5, 3	# 340:10-18
	bne	cr7, beq_else.5701	# 340:7 - 354:11
#	341:9 - 349:10
	lfd	f0, 0(r6)	# 343:10-25
	lis	r31, ha16(l.4464)	# 344:24-27
	addi	r31, r31, lo16(l.4464)	# 344:24-27
	lfd	f1, 0(r31)	# 344:24-27
	fcmpu	cr7, f1, f0	# 344:24-31
	bne	cr7, beq_else.5703	# 344:21-65
#	344:37-40
	lis	r31, ha16(l.4464)	# 344:37-40
	addi	r31, r31, lo16(l.4464)	# 344:37-40
	lfd	f0, 0(r31)	# 344:37-40
	b	beq_cont.5704
beq_else.5703:	# 344:46-65
	stfd	f0, 56(r3)	# 344:46-53
	mflr	r31	# 344:46-53
	stw	r31, 68(r3)	# 344:46-53
	addi	r3, r3, 72	# 344:46-53
	bl	sgn.2025	# 344:46-53
	subi	r3, r3, 72	# 344:46-53
	lwz	r31, 68(r3)	# 344:46-53
	mtlr	r31	# 344:46-53
	lfd	f1, 56(r3)	# 344:57-65
	stfd	f0, 64(r3)	# 344:57-65
	mflr	r31	# 344:57-65
	fmr	f0, f1	# 344:57-65
	stw	r31, 76(r3)	# 344:57-65
	addi	r3, r3, 80	# 344:57-65
	bl	fsqr.1980	# 344:57-65
	subi	r3, r3, 80	# 344:57-65
	lwz	r31, 76(r3)	# 344:57-65
	mtlr	r31	# 344:57-65
	lfd	f1, 64(r3)	# 344:46-65
	fdiv	f0, f1, f0	# 344:46-65
beq_cont.5704:	# 344:21-65
	lwz	r2, 20(r3)	# 344:10-65
	stfd	f0, 0(r2)	# 344:10-65
	lfd	f0, 8(r2)	# 345:10-25
	lis	r31, ha16(l.4464)	# 346:24-27
	addi	r31, r31, lo16(l.4464)	# 346:24-27
	lfd	f1, 0(r31)	# 346:24-27
	fcmpu	cr7, f1, f0	# 346:24-31
	bne	cr7, beq_else.5705	# 346:21-65
#	346:37-40
	lis	r31, ha16(l.4464)	# 346:37-40
	addi	r31, r31, lo16(l.4464)	# 346:37-40
	lfd	f0, 0(r31)	# 346:37-40
	b	beq_cont.5706
beq_else.5705:	# 346:46-65
	stfd	f0, 72(r3)	# 346:46-53
	mflr	r31	# 346:46-53
	stw	r31, 84(r3)	# 346:46-53
	addi	r3, r3, 88	# 346:46-53
	bl	sgn.2025	# 346:46-53
	subi	r3, r3, 88	# 346:46-53
	lwz	r31, 84(r3)	# 346:46-53
	mtlr	r31	# 346:46-53
	lfd	f1, 72(r3)	# 346:57-65
	stfd	f0, 80(r3)	# 346:57-65
	mflr	r31	# 346:57-65
	fmr	f0, f1	# 346:57-65
	stw	r31, 92(r3)	# 346:57-65
	addi	r3, r3, 96	# 346:57-65
	bl	fsqr.1980	# 346:57-65
	subi	r3, r3, 96	# 346:57-65
	lwz	r31, 92(r3)	# 346:57-65
	mtlr	r31	# 346:57-65
	lfd	f1, 80(r3)	# 346:46-65
	fdiv	f0, f1, f0	# 346:46-65
beq_cont.5706:	# 346:21-65
	lwz	r2, 20(r3)	# 346:10-65
	stfd	f0, 8(r2)	# 346:10-65
	lfd	f0, 16(r2)	# 347:10-25
	lis	r31, ha16(l.4464)	# 348:24-27
	addi	r31, r31, lo16(l.4464)	# 348:24-27
	lfd	f1, 0(r31)	# 348:24-27
	fcmpu	cr7, f1, f0	# 348:24-31
	bne	cr7, beq_else.5707	# 348:21-65
#	348:37-40
	lis	r31, ha16(l.4464)	# 348:37-40
	addi	r31, r31, lo16(l.4464)	# 348:37-40
	lfd	f0, 0(r31)	# 348:37-40
	b	beq_cont.5708
beq_else.5707:	# 348:46-65
	stfd	f0, 88(r3)	# 348:46-53
	mflr	r31	# 348:46-53
	stw	r31, 100(r3)	# 348:46-53
	addi	r3, r3, 104	# 348:46-53
	bl	sgn.2025	# 348:46-53
	subi	r3, r3, 104	# 348:46-53
	lwz	r31, 100(r3)	# 348:46-53
	mtlr	r31	# 348:46-53
	lfd	f1, 88(r3)	# 348:57-65
	stfd	f0, 96(r3)	# 348:57-65
	mflr	r31	# 348:57-65
	fmr	f0, f1	# 348:57-65
	stw	r31, 108(r3)	# 348:57-65
	addi	r3, r3, 112	# 348:57-65
	bl	fsqr.1980	# 348:57-65
	subi	r3, r3, 112	# 348:57-65
	lwz	r31, 108(r3)	# 348:57-65
	mtlr	r31	# 348:57-65
	lfd	f1, 96(r3)	# 348:46-65
	fdiv	f0, f1, f0	# 348:46-65
beq_cont.5708:	# 348:21-65
	lwz	r2, 20(r3)	# 348:10-65
	stfd	f0, 16(r2)	# 348:10-65
	b	beq_cont.5702
beq_else.5701:	# 350:12 - 354:11
	cmpwi	cr7, r5, 2	# 350:15-23
	bne	cr7, beq_else.5709	# 350:12 - 354:11
#	352:9-44
	lwz	r5, 40(r3)	# 352:30-44
	cmpwi	cr7, r5, 0	# 352:30-44
	bne	cr7, beq_else.5711	# 352:30-44
#	352:30-44
	li	r5, 1	# 352:30-44
	b	beq_cont.5712
beq_else.5711:	# 352:30-44
	li	r5, 0	# 352:30-44
beq_cont.5712:	# 352:30-44
	mflr	r31	# 352:9-44
	mr	r2, r6	# 352:9-44
	stw	r31, 108(r3)	# 352:9-44
	addi	r3, r3, 112	# 352:9-44
	bl	normalize_vector.2022	# 352:9-44
	subi	r3, r3, 112	# 352:9-44
	lwz	r31, 108(r3)	# 352:9-44
	mtlr	r31	# 352:9-44
	b	beq_cont.5710
beq_else.5709:	# 354:9-11
beq_cont.5710:	# 350:12 - 354:11
beq_cont.5702:	# 340:7 - 354:11
	lwz	r2, 16(r3)	# 356:7 - 393:14
	cmpwi	cr7, r2, 0	# 356:10-22
	bne	cr7, beq_else.5713	# 356:7 - 393:14
#	393:12-14
	b	beq_cont.5714
beq_else.5713:	# 357:9 - 392:10
	lis	r2, ha16(min_caml_cs_temp)	# 358:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 358:10-17
	lwz	r5, 52(r3)	# 358:30-42
	lfd	f0, 0(r5)	# 358:30-42
	stw	r2, 104(r3)	# 358:26-42
	mflr	r31	# 358:26-42
	stw	r31, 108(r3)	# 358:26-42
	addi	r3, r3, 112	# 358:26-42
	bl	min_caml_cos	# 358:26-42
	subi	r3, r3, 112	# 358:26-42
	lwz	r31, 108(r3)	# 358:26-42
	mtlr	r31	# 358:26-42
	lwz	r2, 104(r3)	# 358:10-42
	stfd	f0, 80(r2)	# 358:10-42
	lis	r2, ha16(min_caml_cs_temp)	# 359:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 359:10-17
	lwz	r5, 52(r3)	# 359:30-42
	lfd	f0, 0(r5)	# 359:30-42
	stw	r2, 108(r3)	# 359:26-42
	mflr	r31	# 359:26-42
	stw	r31, 116(r3)	# 359:26-42
	addi	r3, r3, 120	# 359:26-42
	bl	min_caml_sin	# 359:26-42
	subi	r3, r3, 120	# 359:26-42
	lwz	r31, 116(r3)	# 359:26-42
	mtlr	r31	# 359:26-42
	lwz	r2, 108(r3)	# 359:10-42
	stfd	f0, 88(r2)	# 359:10-42
	lis	r2, ha16(min_caml_cs_temp)	# 360:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 360:10-17
	lwz	r5, 52(r3)	# 360:30-42
	lfd	f0, 8(r5)	# 360:30-42
	stw	r2, 112(r3)	# 360:26-42
	mflr	r31	# 360:26-42
	stw	r31, 116(r3)	# 360:26-42
	addi	r3, r3, 120	# 360:26-42
	bl	min_caml_cos	# 360:26-42
	subi	r3, r3, 120	# 360:26-42
	lwz	r31, 116(r3)	# 360:26-42
	mtlr	r31	# 360:26-42
	lwz	r2, 112(r3)	# 360:10-42
	stfd	f0, 96(r2)	# 360:10-42
	lis	r2, ha16(min_caml_cs_temp)	# 361:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 361:10-17
	lwz	r5, 52(r3)	# 361:30-42
	lfd	f0, 8(r5)	# 361:30-42
	stw	r2, 116(r3)	# 361:26-42
	mflr	r31	# 361:26-42
	stw	r31, 124(r3)	# 361:26-42
	addi	r3, r3, 128	# 361:26-42
	bl	min_caml_sin	# 361:26-42
	subi	r3, r3, 128	# 361:26-42
	lwz	r31, 124(r3)	# 361:26-42
	mtlr	r31	# 361:26-42
	lwz	r2, 116(r3)	# 361:10-42
	stfd	f0, 104(r2)	# 361:10-42
	lis	r2, ha16(min_caml_cs_temp)	# 362:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 362:10-17
	lwz	r5, 52(r3)	# 362:30-42
	lfd	f0, 16(r5)	# 362:30-42
	stw	r2, 120(r3)	# 362:26-42
	mflr	r31	# 362:26-42
	stw	r31, 124(r3)	# 362:26-42
	addi	r3, r3, 128	# 362:26-42
	bl	min_caml_cos	# 362:26-42
	subi	r3, r3, 128	# 362:26-42
	lwz	r31, 124(r3)	# 362:26-42
	mtlr	r31	# 362:26-42
	lwz	r2, 120(r3)	# 362:10-42
	stfd	f0, 112(r2)	# 362:10-42
	lis	r2, ha16(min_caml_cs_temp)	# 363:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 363:10-17
	lwz	r5, 52(r3)	# 363:30-42
	lfd	f0, 16(r5)	# 363:30-42
	stw	r2, 124(r3)	# 363:26-42
	mflr	r31	# 363:26-42
	stw	r31, 132(r3)	# 363:26-42
	addi	r3, r3, 136	# 363:26-42
	bl	min_caml_sin	# 363:26-42
	subi	r3, r3, 136	# 363:26-42
	lwz	r31, 132(r3)	# 363:26-42
	mtlr	r31	# 363:26-42
	lwz	r2, 124(r3)	# 363:10-42
	stfd	f0, 120(r2)	# 363:10-42
	lis	r2, ha16(min_caml_cs_temp)	# 364:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 364:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 364:25-32
	addi	r5, r5, lo16(min_caml_cs_temp)	# 364:25-32
	lfd	f0, 96(r5)	# 364:25-37
	lis	r5, ha16(min_caml_cs_temp)	# 364:41-48
	addi	r5, r5, lo16(min_caml_cs_temp)	# 364:41-48
	lfd	f1, 112(r5)	# 364:41-53
	fmul	f0, f0, f1	# 364:25-53
	stfd	f0, 0(r2)	# 364:10-53
	lis	r2, ha16(min_caml_cs_temp)	# 365:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 365:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 366:13-20
	addi	r5, r5, lo16(min_caml_cs_temp)	# 366:13-20
	lfd	f0, 88(r5)	# 366:13-25
	lis	r5, ha16(min_caml_cs_temp)	# 366:29-36
	addi	r5, r5, lo16(min_caml_cs_temp)	# 366:29-36
	lfd	f1, 104(r5)	# 366:29-41
	fmul	f0, f0, f1	# 366:13-41
	lis	r5, ha16(min_caml_cs_temp)	# 366:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 366:45-52
	lfd	f1, 112(r5)	# 366:45-57
	fmul	f0, f0, f1	# 366:12-58
	lis	r5, ha16(min_caml_cs_temp)	# 366:63-70
	addi	r5, r5, lo16(min_caml_cs_temp)	# 366:63-70
	lfd	f1, 80(r5)	# 366:63-75
	lis	r5, ha16(min_caml_cs_temp)	# 366:79-86
	addi	r5, r5, lo16(min_caml_cs_temp)	# 366:79-86
	lfd	f2, 120(r5)	# 366:79-91
	fmul	f1, f1, f2	# 366:62-92
	fsub	f0, f0, f1	# 366:12-92
	stfd	f0, 8(r2)	# 365:10 - 366:92
	lis	r2, ha16(min_caml_cs_temp)	# 367:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 367:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 368:13-20
	addi	r5, r5, lo16(min_caml_cs_temp)	# 368:13-20
	lfd	f0, 80(r5)	# 368:13-25
	lis	r5, ha16(min_caml_cs_temp)	# 368:29-36
	addi	r5, r5, lo16(min_caml_cs_temp)	# 368:29-36
	lfd	f1, 104(r5)	# 368:29-41
	fmul	f0, f0, f1	# 368:13-41
	lis	r5, ha16(min_caml_cs_temp)	# 368:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 368:45-52
	lfd	f1, 112(r5)	# 368:45-57
	fmul	f0, f0, f1	# 368:12-58
	lis	r5, ha16(min_caml_cs_temp)	# 368:63-70
	addi	r5, r5, lo16(min_caml_cs_temp)	# 368:63-70
	lfd	f1, 88(r5)	# 368:63-75
	lis	r5, ha16(min_caml_cs_temp)	# 368:79-86
	addi	r5, r5, lo16(min_caml_cs_temp)	# 368:79-86
	lfd	f2, 120(r5)	# 368:79-91
	fmul	f1, f1, f2	# 368:62-92
	fadd	f0, f0, f1	# 368:12-92
	stfd	f0, 16(r2)	# 367:10 - 368:92
	lis	r2, ha16(min_caml_cs_temp)	# 369:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 369:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 369:32-39
	addi	r5, r5, lo16(min_caml_cs_temp)	# 369:32-39
	lfd	f0, 96(r5)	# 369:32-44
	lis	r5, ha16(min_caml_cs_temp)	# 369:48-55
	addi	r5, r5, lo16(min_caml_cs_temp)	# 369:48-55
	lfd	f1, 120(r5)	# 369:48-60
	fmul	f0, f0, f1	# 369:32-60
	stfd	f0, 24(r2)	# 369:10-60
	lis	r2, ha16(min_caml_cs_temp)	# 370:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 370:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 371:13-20
	addi	r5, r5, lo16(min_caml_cs_temp)	# 371:13-20
	lfd	f0, 88(r5)	# 371:13-25
	lis	r5, ha16(min_caml_cs_temp)	# 371:29-36
	addi	r5, r5, lo16(min_caml_cs_temp)	# 371:29-36
	lfd	f1, 104(r5)	# 371:29-41
	fmul	f0, f0, f1	# 371:13-41
	lis	r5, ha16(min_caml_cs_temp)	# 371:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 371:45-52
	lfd	f1, 120(r5)	# 371:45-57
	fmul	f0, f0, f1	# 371:12-58
	lis	r5, ha16(min_caml_cs_temp)	# 371:63-70
	addi	r5, r5, lo16(min_caml_cs_temp)	# 371:63-70
	lfd	f1, 80(r5)	# 371:63-75
	lis	r5, ha16(min_caml_cs_temp)	# 371:79-86
	addi	r5, r5, lo16(min_caml_cs_temp)	# 371:79-86
	lfd	f2, 112(r5)	# 371:79-91
	fmul	f1, f1, f2	# 371:62-92
	fadd	f0, f0, f1	# 371:12-92
	stfd	f0, 32(r2)	# 370:10 - 371:92
	lis	r2, ha16(min_caml_cs_temp)	# 372:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 372:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 373:13-20
	addi	r5, r5, lo16(min_caml_cs_temp)	# 373:13-20
	lfd	f0, 80(r5)	# 373:13-25
	lis	r5, ha16(min_caml_cs_temp)	# 373:29-36
	addi	r5, r5, lo16(min_caml_cs_temp)	# 373:29-36
	lfd	f1, 104(r5)	# 373:29-41
	fmul	f0, f0, f1	# 373:13-41
	lis	r5, ha16(min_caml_cs_temp)	# 373:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 373:45-52
	lfd	f1, 120(r5)	# 373:45-57
	fmul	f0, f0, f1	# 373:12-58
	lis	r5, ha16(min_caml_cs_temp)	# 373:63-70
	addi	r5, r5, lo16(min_caml_cs_temp)	# 373:63-70
	lfd	f1, 88(r5)	# 373:63-75
	lis	r5, ha16(min_caml_cs_temp)	# 373:79-86
	addi	r5, r5, lo16(min_caml_cs_temp)	# 373:79-86
	lfd	f2, 112(r5)	# 373:79-91
	fmul	f1, f1, f2	# 373:62-92
	fsub	f0, f0, f1	# 373:12-92
	stfd	f0, 40(r2)	# 372:10 - 373:92
	lis	r2, ha16(min_caml_cs_temp)	# 374:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 374:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 374:34-41
	addi	r5, r5, lo16(min_caml_cs_temp)	# 374:34-41
	lfd	f0, 104(r5)	# 374:34-46
	fneg	f0, f0	# 374:32-46
	stfd	f0, 48(r2)	# 374:10-46
	lis	r2, ha16(min_caml_cs_temp)	# 375:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 375:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 375:32-39
	addi	r5, r5, lo16(min_caml_cs_temp)	# 375:32-39
	lfd	f0, 88(r5)	# 375:32-44
	lis	r5, ha16(min_caml_cs_temp)	# 375:48-55
	addi	r5, r5, lo16(min_caml_cs_temp)	# 375:48-55
	lfd	f1, 96(r5)	# 375:48-60
	fmul	f0, f0, f1	# 375:32-60
	stfd	f0, 56(r2)	# 375:10-60
	lis	r2, ha16(min_caml_cs_temp)	# 376:10-17
	addi	r2, r2, lo16(min_caml_cs_temp)	# 376:10-17
	lis	r5, ha16(min_caml_cs_temp)	# 376:32-39
	addi	r5, r5, lo16(min_caml_cs_temp)	# 376:32-39
	lfd	f0, 80(r5)	# 376:32-44
	lis	r5, ha16(min_caml_cs_temp)	# 376:48-55
	addi	r5, r5, lo16(min_caml_cs_temp)	# 376:48-55
	lfd	f1, 96(r5)	# 376:48-60
	fmul	f0, f0, f1	# 376:32-60
	stfd	f0, 64(r2)	# 376:10-60
	lwz	r2, 20(r3)	# 377:10-26
	lfd	f0, 0(r2)	# 377:10-26
	lfd	f1, 8(r2)	# 378:10-26
	lfd	f2, 16(r2)	# 379:10-26
	lis	r5, ha16(min_caml_cs_temp)	# 380:32-39
	addi	r5, r5, lo16(min_caml_cs_temp)	# 380:32-39
	lfd	f3, 0(r5)	# 380:32-43
	stfd	f2, 128(r3)	# 380:27-43
	stfd	f1, 136(r3)	# 380:27-43
	stfd	f0, 144(r3)	# 380:27-43
	mflr	r31	# 380:27-43
	fmr	f0, f3	# 380:27-43
	stw	r31, 156(r3)	# 380:27-43
	addi	r3, r3, 160	# 380:27-43
	bl	fsqr.1980	# 380:27-43
	subi	r3, r3, 160	# 380:27-43
	lwz	r31, 156(r3)	# 380:27-43
	mtlr	r31	# 380:27-43
	lfd	f1, 144(r3)	# 380:21-43
	fmul	f0, f1, f0	# 380:21-43
	lis	r2, ha16(min_caml_cs_temp)	# 380:58-65
	addi	r2, r2, lo16(min_caml_cs_temp)	# 380:58-65
	lfd	f2, 24(r2)	# 380:58-69
	stfd	f0, 152(r3)	# 380:53-69
	mflr	r31	# 380:53-69
	fmr	f0, f2	# 380:53-69
	stw	r31, 164(r3)	# 380:53-69
	addi	r3, r3, 168	# 380:53-69
	bl	fsqr.1980	# 380:53-69
	subi	r3, r3, 168	# 380:53-69
	lwz	r31, 164(r3)	# 380:53-69
	mtlr	r31	# 380:53-69
	lfd	f1, 136(r3)	# 380:47-69
	fmul	f0, f1, f0	# 380:47-69
	lfd	f2, 152(r3)	# 380:21-69
	fadd	f0, f2, f0	# 380:21-69
	lis	r2, ha16(min_caml_cs_temp)	# 380:84-91
	addi	r2, r2, lo16(min_caml_cs_temp)	# 380:84-91
	lfd	f2, 48(r2)	# 380:84-95
	stfd	f0, 160(r3)	# 380:79-95
	mflr	r31	# 380:79-95
	fmr	f0, f2	# 380:79-95
	stw	r31, 172(r3)	# 380:79-95
	addi	r3, r3, 176	# 380:79-95
	bl	fsqr.1980	# 380:79-95
	subi	r3, r3, 176	# 380:79-95
	lwz	r31, 172(r3)	# 380:79-95
	mtlr	r31	# 380:79-95
	lfd	f1, 128(r3)	# 380:73-95
	fmul	f0, f1, f0	# 380:73-95
	lfd	f2, 160(r3)	# 380:21-95
	fadd	f0, f2, f0	# 380:21-95
	lwz	r2, 20(r3)	# 380:10-95
	stfd	f0, 0(r2)	# 380:10-95
	lis	r5, ha16(min_caml_cs_temp)	# 381:32-39
	addi	r5, r5, lo16(min_caml_cs_temp)	# 381:32-39
	lfd	f0, 8(r5)	# 381:32-43
	mflr	r31	# 381:27-43
	stw	r31, 172(r3)	# 381:27-43
	addi	r3, r3, 176	# 381:27-43
	bl	fsqr.1980	# 381:27-43
	subi	r3, r3, 176	# 381:27-43
	lwz	r31, 172(r3)	# 381:27-43
	mtlr	r31	# 381:27-43
	lfd	f1, 144(r3)	# 381:21-43
	fmul	f0, f1, f0	# 381:21-43
	lis	r2, ha16(min_caml_cs_temp)	# 381:58-65
	addi	r2, r2, lo16(min_caml_cs_temp)	# 381:58-65
	lfd	f2, 32(r2)	# 381:58-69
	stfd	f0, 168(r3)	# 381:53-69
	mflr	r31	# 381:53-69
	fmr	f0, f2	# 381:53-69
	stw	r31, 180(r3)	# 381:53-69
	addi	r3, r3, 184	# 381:53-69
	bl	fsqr.1980	# 381:53-69
	subi	r3, r3, 184	# 381:53-69
	lwz	r31, 180(r3)	# 381:53-69
	mtlr	r31	# 381:53-69
	lfd	f1, 136(r3)	# 381:47-69
	fmul	f0, f1, f0	# 381:47-69
	lfd	f2, 168(r3)	# 381:21-69
	fadd	f0, f2, f0	# 381:21-69
	lis	r2, ha16(min_caml_cs_temp)	# 381:84-91
	addi	r2, r2, lo16(min_caml_cs_temp)	# 381:84-91
	lfd	f2, 56(r2)	# 381:84-95
	stfd	f0, 176(r3)	# 381:79-95
	mflr	r31	# 381:79-95
	fmr	f0, f2	# 381:79-95
	stw	r31, 188(r3)	# 381:79-95
	addi	r3, r3, 192	# 381:79-95
	bl	fsqr.1980	# 381:79-95
	subi	r3, r3, 192	# 381:79-95
	lwz	r31, 188(r3)	# 381:79-95
	mtlr	r31	# 381:79-95
	lfd	f1, 128(r3)	# 381:73-95
	fmul	f0, f1, f0	# 381:73-95
	lfd	f2, 176(r3)	# 381:21-95
	fadd	f0, f2, f0	# 381:21-95
	lwz	r2, 20(r3)	# 381:10-95
	stfd	f0, 8(r2)	# 381:10-95
	lis	r5, ha16(min_caml_cs_temp)	# 382:32-39
	addi	r5, r5, lo16(min_caml_cs_temp)	# 382:32-39
	lfd	f0, 16(r5)	# 382:32-43
	mflr	r31	# 382:27-43
	stw	r31, 188(r3)	# 382:27-43
	addi	r3, r3, 192	# 382:27-43
	bl	fsqr.1980	# 382:27-43
	subi	r3, r3, 192	# 382:27-43
	lwz	r31, 188(r3)	# 382:27-43
	mtlr	r31	# 382:27-43
	lfd	f1, 144(r3)	# 382:21-43
	fmul	f0, f1, f0	# 382:21-43
	lis	r2, ha16(min_caml_cs_temp)	# 382:58-65
	addi	r2, r2, lo16(min_caml_cs_temp)	# 382:58-65
	lfd	f2, 40(r2)	# 382:58-69
	stfd	f0, 184(r3)	# 382:53-69
	mflr	r31	# 382:53-69
	fmr	f0, f2	# 382:53-69
	stw	r31, 196(r3)	# 382:53-69
	addi	r3, r3, 200	# 382:53-69
	bl	fsqr.1980	# 382:53-69
	subi	r3, r3, 200	# 382:53-69
	lwz	r31, 196(r3)	# 382:53-69
	mtlr	r31	# 382:53-69
	lfd	f1, 136(r3)	# 382:47-69
	fmul	f0, f1, f0	# 382:47-69
	lfd	f2, 184(r3)	# 382:21-69
	fadd	f0, f2, f0	# 382:21-69
	lis	r2, ha16(min_caml_cs_temp)	# 382:84-91
	addi	r2, r2, lo16(min_caml_cs_temp)	# 382:84-91
	lfd	f2, 64(r2)	# 382:84-95
	stfd	f0, 192(r3)	# 382:79-95
	mflr	r31	# 382:79-95
	fmr	f0, f2	# 382:79-95
	stw	r31, 204(r3)	# 382:79-95
	addi	r3, r3, 208	# 382:79-95
	bl	fsqr.1980	# 382:79-95
	subi	r3, r3, 208	# 382:79-95
	lwz	r31, 204(r3)	# 382:79-95
	mtlr	r31	# 382:79-95
	lfd	f1, 128(r3)	# 382:73-95
	fmul	f0, f1, f0	# 382:73-95
	lfd	f2, 192(r3)	# 382:21-95
	fadd	f0, f2, f0	# 382:21-95
	lwz	r2, 20(r3)	# 382:10-95
	stfd	f0, 16(r2)	# 382:10-95
	lis	r31, ha16(l.4440)	# 383:26-29
	addi	r31, r31, lo16(l.4440)	# 383:26-29
	lfd	f0, 0(r31)	# 383:26-29
	lis	r2, ha16(min_caml_cs_temp)	# 383:40-47
	addi	r2, r2, lo16(min_caml_cs_temp)	# 383:40-47
	lfd	f2, 8(r2)	# 383:40-51
	lfd	f3, 144(r3)	# 383:34-51
	fmul	f2, f3, f2	# 383:34-51
	lis	r2, ha16(min_caml_cs_temp)	# 383:55-62
	addi	r2, r2, lo16(min_caml_cs_temp)	# 383:55-62
	lfd	f4, 16(r2)	# 383:55-66
	fmul	f2, f2, f4	# 383:34-66
	lis	r2, ha16(min_caml_cs_temp)	# 384:45-52
	addi	r2, r2, lo16(min_caml_cs_temp)	# 384:45-52
	lfd	f4, 32(r2)	# 384:45-56
	lfd	f5, 136(r3)	# 384:39-56
	fmul	f4, f5, f4	# 384:39-56
	lis	r2, ha16(min_caml_cs_temp)	# 384:60-67
	addi	r2, r2, lo16(min_caml_cs_temp)	# 384:60-67
	lfd	f6, 40(r2)	# 384:60-71
	fmul	f4, f4, f6	# 384:39-71
	fadd	f2, f2, f4	# 383:34 - 384:71
	lis	r2, ha16(min_caml_cs_temp)	# 385:45-52
	addi	r2, r2, lo16(min_caml_cs_temp)	# 385:45-52
	lfd	f4, 56(r2)	# 385:45-56
	fmul	f4, f1, f4	# 385:39-56
	lis	r2, ha16(min_caml_cs_temp)	# 385:60-67
	addi	r2, r2, lo16(min_caml_cs_temp)	# 385:60-67
	lfd	f6, 64(r2)	# 385:60-71
	fmul	f4, f4, f6	# 385:39-71
	fadd	f2, f2, f4	# 383:33 - 385:72
	fmul	f0, f0, f2	# 383:26 - 385:72
	lwz	r2, 52(r3)	# 383:10 - 385:72
	stfd	f0, 0(r2)	# 383:10 - 385:72
	lis	r31, ha16(l.4440)	# 386:26-29
	addi	r31, r31, lo16(l.4440)	# 386:26-29
	lfd	f0, 0(r31)	# 386:26-29
	lis	r5, ha16(min_caml_cs_temp)	# 386:40-47
	addi	r5, r5, lo16(min_caml_cs_temp)	# 386:40-47
	lfd	f2, 0(r5)	# 386:40-51
	fmul	f2, f3, f2	# 386:34-51
	lis	r5, ha16(min_caml_cs_temp)	# 386:55-62
	addi	r5, r5, lo16(min_caml_cs_temp)	# 386:55-62
	lfd	f4, 16(r5)	# 386:55-66
	fmul	f2, f2, f4	# 386:34-66
	lis	r5, ha16(min_caml_cs_temp)	# 387:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 387:45-52
	lfd	f4, 24(r5)	# 387:45-56
	fmul	f4, f5, f4	# 387:39-56
	lis	r5, ha16(min_caml_cs_temp)	# 387:60-67
	addi	r5, r5, lo16(min_caml_cs_temp)	# 387:60-67
	lfd	f6, 40(r5)	# 387:60-71
	fmul	f4, f4, f6	# 387:39-71
	fadd	f2, f2, f4	# 386:34 - 387:71
	lis	r5, ha16(min_caml_cs_temp)	# 388:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 388:45-52
	lfd	f4, 48(r5)	# 388:45-56
	fmul	f4, f1, f4	# 388:39-56
	lis	r5, ha16(min_caml_cs_temp)	# 388:60-67
	addi	r5, r5, lo16(min_caml_cs_temp)	# 388:60-67
	lfd	f6, 64(r5)	# 388:60-71
	fmul	f4, f4, f6	# 388:39-71
	fadd	f2, f2, f4	# 386:33 - 388:72
	fmul	f0, f0, f2	# 386:26 - 388:72
	stfd	f0, 8(r2)	# 386:10 - 388:72
	lis	r31, ha16(l.4440)	# 389:26-29
	addi	r31, r31, lo16(l.4440)	# 389:26-29
	lfd	f0, 0(r31)	# 389:26-29
	lis	r5, ha16(min_caml_cs_temp)	# 389:40-47
	addi	r5, r5, lo16(min_caml_cs_temp)	# 389:40-47
	lfd	f2, 0(r5)	# 389:40-51
	fmul	f2, f3, f2	# 389:34-51
	lis	r5, ha16(min_caml_cs_temp)	# 389:55-62
	addi	r5, r5, lo16(min_caml_cs_temp)	# 389:55-62
	lfd	f3, 8(r5)	# 389:55-66
	fmul	f2, f2, f3	# 389:34-66
	lis	r5, ha16(min_caml_cs_temp)	# 390:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 390:45-52
	lfd	f3, 24(r5)	# 390:45-56
	fmul	f3, f5, f3	# 390:39-56
	lis	r5, ha16(min_caml_cs_temp)	# 390:60-67
	addi	r5, r5, lo16(min_caml_cs_temp)	# 390:60-67
	lfd	f4, 32(r5)	# 390:60-71
	fmul	f3, f3, f4	# 390:39-71
	fadd	f2, f2, f3	# 389:34 - 390:71
	lis	r5, ha16(min_caml_cs_temp)	# 391:45-52
	addi	r5, r5, lo16(min_caml_cs_temp)	# 391:45-52
	lfd	f3, 48(r5)	# 391:45-56
	fmul	f1, f1, f3	# 391:39-56
	lis	r5, ha16(min_caml_cs_temp)	# 391:60-67
	addi	r5, r5, lo16(min_caml_cs_temp)	# 391:60-67
	lfd	f3, 56(r5)	# 391:60-71
	fmul	f1, f1, f3	# 391:39-71
	fadd	f1, f2, f1	# 389:33 - 391:72
	fmul	f0, f0, f1	# 389:26 - 391:72
	stfd	f0, 16(r2)	# 389:10 - 391:72
beq_cont.5714:	# 356:7 - 393:14
	li	r2, 1	# 394:7-11
	blr	# 394:7-11
read_object.2033:	# 401:12 - 407:10
	cmpwi	cr7, r2, 61	# 403:6-12
	blt	cr7, bge_else.5715	# 403:3 - 407:10
#	407:8-10
	blr	# 407:8-10
bge_else.5715:	# 404:5 - 406:12
	stw	r2, 0(r3)	# 404:8-25
	mflr	r31	# 404:8-25
	stw	r31, 4(r3)	# 404:8-25
	addi	r3, r3, 8	# 404:8-25
	bl	read_nth_object.2031	# 404:8-25
	subi	r3, r3, 8	# 404:8-25
	lwz	r31, 4(r3)	# 404:8-25
	mtlr	r31	# 404:8-25
	cmpwi	cr7, r2, 0	# 404:5 - 406:12
	bne	cr7, beq_else.5717	# 404:5 - 406:12
#	406:10-12
	blr	# 406:10-12
beq_else.5717:	# 405:10-29
	lwz	r2, 0(r3)	# 405:22-29
	addi	r2, r2, 1	# 405:22-29
	b	read_object.2033	# 405:10-29
read_all_object.2035:	# 410:12 - 412:16
	li	r2, 0	# 412:15-16
	b	read_object.2033	# 412:3-16
read_net_item.2037:	# 418:12 - 424:28
	stw	r2, 0(r3)	# 420:14-25
	mflr	r31	# 420:3-25
	stw	r31, 4(r3)	# 420:3-25
	addi	r3, r3, 8	# 420:3-25
	bl	min_caml_read_int	# 420:3-25
	subi	r3, r3, 8	# 420:3-25
	lwz	r31, 4(r3)	# 420:3-25
	mtlr	r31	# 420:3-25
	cmpwi	cr7, r2, -1	# 421:6-15
	bne	cr7, beq_else.5719	# 421:3 - 424:28
#	421:21-49
	lwz	r2, 0(r3)	# 421:32-44
	addi	r2, r2, 1	# 421:32-44
	li	r5, -1	# 421:45-49
	b	min_caml_create_array	# 421:21-49
beq_else.5719:	# 423:5 - 424:28
	lwz	r5, 0(r3)	# 423:27-39
	addi	r6, r5, 1	# 423:27-39
	stw	r2, 4(r3)	# 423:13-39
	mflr	r31	# 423:5-39
	mr	r2, r6	# 423:5-39
	stw	r31, 12(r3)	# 423:5-39
	addi	r3, r3, 16	# 423:5-39
	bl	read_net_item.2037	# 423:5-39
	subi	r3, r3, 16	# 423:5-39
	lwz	r31, 12(r3)	# 423:5-39
	mtlr	r31	# 423:5-39
	lwz	r5, 0(r3)	# 424:6-24
	slwi	r5, r5, 2	# 424:6-24
	lwz	r6, 4(r3)	# 424:6-24
	stwx	r6, r2, r5	# 424:6-24
	blr	# 424:26-27
read_or_network.2039:	# 427:12 - 434:27
	li	r5, 0	# 429:27-28
	stw	r2, 0(r3)	# 429:13-28
	mflr	r31	# 429:3-28
	mr	r2, r5	# 429:3-28
	stw	r31, 4(r3)	# 429:3-28
	addi	r3, r3, 8	# 429:3-28
	bl	read_net_item.2037	# 429:3-28
	subi	r3, r3, 8	# 429:3-28
	lwz	r31, 4(r3)	# 429:3-28
	mr	r5, r2	# 429:3-28
	mtlr	r31	# 429:3-28
	lwz	r2, 0(r5)	# 430:6-13
	cmpwi	cr7, r2, -1	# 430:6-18
	bne	cr7, beq_else.5720	# 430:3 - 434:27
#	431:5-32
	lwz	r2, 0(r3)	# 431:16-28
	addi	r2, r2, 1	# 431:16-28
	b	min_caml_create_array	# 431:5-32
beq_else.5720:	# 433:5 - 434:27
	lwz	r2, 0(r3)	# 433:29-41
	addi	r6, r2, 1	# 433:29-41
	stw	r5, 4(r3)	# 433:13-41
	mflr	r31	# 433:5-41
	mr	r2, r6	# 433:5-41
	stw	r31, 12(r3)	# 433:5-41
	addi	r3, r3, 16	# 433:5-41
	bl	read_or_network.2039	# 433:5-41
	subi	r3, r3, 16	# 433:5-41
	lwz	r31, 12(r3)	# 433:5-41
	mtlr	r31	# 433:5-41
	lwz	r5, 0(r3)	# 434:6-23
	slwi	r5, r5, 2	# 434:6-23
	lwz	r6, 4(r3)	# 434:6-23
	stwx	r6, r2, r5	# 434:6-23
	blr	# 434:25-26
read_and_network.2041:	# 437:12 - 444:4
	li	r5, 0	# 439:27-28
	stw	r2, 0(r3)	# 439:13-28
	mflr	r31	# 439:3-28
	mr	r2, r5	# 439:3-28
	stw	r31, 4(r3)	# 439:3-28
	addi	r3, r3, 8	# 439:3-28
	bl	read_net_item.2037	# 439:3-28
	subi	r3, r3, 8	# 439:3-28
	lwz	r31, 4(r3)	# 439:3-28
	mtlr	r31	# 439:3-28
	lwz	r5, 0(r2)	# 440:6-13
	cmpwi	cr7, r5, -1	# 440:6-18
	bne	cr7, beq_else.5721	# 440:3 - 444:4
#	440:24-26
	blr	# 440:24-26
beq_else.5721:	# 441:8 - 444:4
	lis	r5, ha16(min_caml_and_net)	# 442:5-12
	addi	r5, r5, lo16(min_caml_and_net)	# 442:5-12
	lwz	r6, 0(r3)	# 442:5-23
	slwi	r7, r6, 2	# 442:5-23
	stwx	r2, r5, r7	# 442:5-23
	addi	r2, r6, 1	# 443:22-29
	b	read_and_network.2041	# 443:5-29
read_parameter.2043:	# 447:12 - 454:4
	mflr	r31	# 450:4-19
	stw	r31, 4(r3)	# 450:4-19
	addi	r3, r3, 8	# 450:4-19
	bl	read_environ.2029	# 450:4-19
	subi	r3, r3, 8	# 450:4-19
	lwz	r31, 4(r3)	# 450:4-19
	mtlr	r31	# 450:4-19
	mflr	r31	# 451:4-22
	stw	r31, 4(r3)	# 451:4-22
	addi	r3, r3, 8	# 451:4-22
	bl	read_all_object.2035	# 451:4-22
	subi	r3, r3, 8	# 451:4-22
	lwz	r31, 4(r3)	# 451:4-22
	mtlr	r31	# 451:4-22
	li	r2, 0	# 452:21-22
	mflr	r31	# 452:4-22
	stw	r31, 4(r3)	# 452:4-22
	addi	r3, r3, 8	# 452:4-22
	bl	read_and_network.2041	# 452:4-22
	subi	r3, r3, 8	# 452:4-22
	lwz	r31, 4(r3)	# 452:4-22
	mtlr	r31	# 452:4-22
	lis	r2, ha16(min_caml_or_net)	# 453:4-10
	addi	r2, r2, lo16(min_caml_or_net)	# 453:4-10
	li	r5, 0	# 453:34-35
	stw	r2, 0(r3)	# 453:18-35
	mflr	r31	# 453:18-35
	mr	r2, r5	# 453:18-35
	stw	r31, 4(r3)	# 453:18-35
	addi	r3, r3, 8	# 453:18-35
	bl	read_or_network.2039	# 453:18-35
	subi	r3, r3, 8	# 453:18-35
	lwz	r31, 4(r3)	# 453:18-35
	mtlr	r31	# 453:18-35
	lwz	r5, 0(r3)	# 453:4-35
	stw	r2, 0(r5)	# 453:4-35
	blr	# 453:4-35
solver_rect.2045:	# 470:12 - 521:27
	lis	r31, ha16(l.4464)	# 474:8-11
	addi	r31, r31, lo16(l.4464)	# 474:8-11
	lfd	f0, 0(r31)	# 474:8-11
	lfd	f1, 0(r5)	# 474:14-19
	stw	r2, 0(r3)	# 474:8-19
	stw	r5, 4(r3)	# 474:8-19
	fcmpu	cr7, f0, f1	# 474:8-19
	bne	cr7, beq_else.5724	# 473:3 - 485:5
#	474:25-30
	li	r2, 0	# 474:25-30
	b	beq_cont.5725
beq_else.5724:	# 474:36 - 485:5
	mflr	r31	# 476:16-30
	stw	r31, 12(r3)	# 476:16-30
	addi	r3, r3, 16	# 476:16-30
	bl	o_isinvert.1990	# 476:16-30
	subi	r3, r3, 16	# 476:16-30
	lwz	r31, 12(r3)	# 476:16-30
	mtlr	r31	# 476:16-30
	lis	r31, ha16(l.4464)	# 476:32-35
	addi	r31, r31, lo16(l.4464)	# 476:32-35
	lfd	f0, 0(r31)	# 476:32-35
	lwz	r5, 4(r3)	# 476:38-43
	lfd	f1, 0(r5)	# 476:38-43
	fcmpu	cr7, f0, f1	# 476:32-43
	bgt	cr7, ble_else.5726	# 476:31-44
#	476:31-44
	li	r6, 0	# 476:31-44
	b	ble_cont.5727
ble_else.5726:	# 476:31-44
	li	r6, 1	# 476:31-44
ble_cont.5727:	# 476:31-44
	mflr	r31	# 476:12-44
	mr	r5, r6	# 476:12-44
	stw	r31, 12(r3)	# 476:12-44
	addi	r3, r3, 16	# 476:12-44
	bl	xor.1977	# 476:12-44
	subi	r3, r3, 16	# 476:12-44
	lwz	r31, 12(r3)	# 476:12-44
	mtlr	r31	# 476:12-44
	cmpwi	cr7, r2, 0	# 476:9-84
	bne	cr7, beq_else.5728	# 475:7 - 476:84
#	476:69-84
	lwz	r2, 0(r3)	# 476:71-84
	mflr	r31	# 476:71-84
	stw	r31, 12(r3)	# 476:71-84
	addi	r3, r3, 16	# 476:71-84
	bl	o_param_a.1994	# 476:71-84
	subi	r3, r3, 16	# 476:71-84
	lwz	r31, 12(r3)	# 476:71-84
	mtlr	r31	# 476:71-84
	fneg	f0, f0	# 476:69-84
	b	beq_cont.5729
beq_else.5728:	# 476:50-63
	lwz	r2, 0(r3)	# 476:50-63
	mflr	r31	# 476:50-63
	stw	r31, 12(r3)	# 476:50-63
	addi	r3, r3, 16	# 476:50-63
	bl	o_param_a.1994	# 476:50-63
	subi	r3, r3, 16	# 476:50-63
	lwz	r31, 12(r3)	# 476:50-63
	mtlr	r31	# 476:50-63
beq_cont.5729:	# 475:7 - 476:84
	lis	r2, ha16(min_caml_solver_w_vec)	# 478:22-34
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 478:22-34
	lfd	f1, 0(r2)	# 478:22-38
	fsub	f0, f0, f1	# 478:16-39
	lwz	r2, 4(r3)	# 478:43-48
	lfd	f1, 0(r2)	# 478:43-48
	fdiv	f0, f0, f1	# 478:7-48
	lwz	r5, 0(r3)	# 480:56-67
	stfd	f0, 8(r3)	# 480:56-67
	mflr	r31	# 480:56-67
	mr	r2, r5	# 480:56-67
	stw	r31, 20(r3)	# 480:56-67
	addi	r3, r3, 24	# 480:56-67
	bl	o_param_b.1996	# 480:56-67
	subi	r3, r3, 24	# 480:56-67
	lwz	r31, 20(r3)	# 480:56-67
	mtlr	r31	# 480:56-67
	lwz	r2, 4(r3)	# 480:27-32
	lfd	f1, 8(r2)	# 480:27-32
	lfd	f2, 8(r3)	# 480:21-32
	fmul	f1, f2, f1	# 480:21-32
	lis	r5, ha16(min_caml_solver_w_vec)	# 480:36-48
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 480:36-48
	lfd	f3, 8(r5)	# 480:36-52
	fadd	f1, f1, f3	# 480:20-53
	stfd	f0, 16(r3)	# 480:10-53
	mflr	r31	# 480:10-53
	fmr	f0, f1	# 480:10-53
	stw	r31, 28(r3)	# 480:10-53
	addi	r3, r3, 32	# 480:10-53
	bl	min_caml_abs_float	# 480:10-53
	subi	r3, r3, 32	# 480:10-53
	lwz	r31, 28(r3)	# 480:10-53
	mtlr	r31	# 480:10-53
	lfd	f1, 16(r3)	# 480:7 - 484:17
	fcmpu	cr7, f1, f0	# 480:10-67
	bgt	cr7, ble_else.5730	# 480:7 - 484:17
#	484:12-17
	li	r2, 0	# 484:12-17
	b	ble_cont.5731
ble_else.5730:	# 481:9 - 483:19
	lwz	r2, 0(r3)	# 481:58-69
	mflr	r31	# 481:58-69
	stw	r31, 28(r3)	# 481:58-69
	addi	r3, r3, 32	# 481:58-69
	bl	o_param_c.1998	# 481:58-69
	subi	r3, r3, 32	# 481:58-69
	lwz	r31, 28(r3)	# 481:58-69
	mtlr	r31	# 481:58-69
	lwz	r2, 4(r3)	# 481:29-34
	lfd	f1, 16(r2)	# 481:29-34
	lfd	f2, 8(r3)	# 481:23-34
	fmul	f1, f2, f1	# 481:23-34
	lis	r5, ha16(min_caml_solver_w_vec)	# 481:38-50
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 481:38-50
	lfd	f3, 16(r5)	# 481:38-54
	fadd	f1, f1, f3	# 481:22-55
	stfd	f0, 24(r3)	# 481:12-55
	mflr	r31	# 481:12-55
	fmr	f0, f1	# 481:12-55
	stw	r31, 36(r3)	# 481:12-55
	addi	r3, r3, 40	# 481:12-55
	bl	min_caml_abs_float	# 481:12-55
	subi	r3, r3, 40	# 481:12-55
	lwz	r31, 36(r3)	# 481:12-55
	mtlr	r31	# 481:12-55
	lfd	f1, 24(r3)	# 481:9 - 483:19
	fcmpu	cr7, f1, f0	# 481:12-69
	bgt	cr7, ble_else.5732	# 481:9 - 483:19
#	483:14-19
	li	r2, 0	# 483:14-19
	b	ble_cont.5733
ble_else.5732:	# 482:14-43
	lis	r2, ha16(min_caml_solver_dist)	# 482:15-26
	addi	r2, r2, lo16(min_caml_solver_dist)	# 482:15-26
	lfd	f0, 8(r3)	# 482:15-36
	stfd	f0, 0(r2)	# 482:15-36
	li	r2, 1	# 482:38-42
ble_cont.5733:	# 481:9 - 483:19
ble_cont.5731:	# 480:7 - 484:17
beq_cont.5725:	# 473:3 - 485:5
	cmpwi	cr7, r2, 0	# 487:3 - 521:27
	bne	cr7, beq_else.5734	# 487:3 - 521:27
#	490:3 - 521:27
	lis	r31, ha16(l.4464)	# 491:8-11
	addi	r31, r31, lo16(l.4464)	# 491:8-11
	lfd	f0, 0(r31)	# 491:8-11
	lwz	r2, 4(r3)	# 491:14-19
	lfd	f1, 8(r2)	# 491:14-19
	fcmpu	cr7, f0, f1	# 491:8-19
	bne	cr7, beq_else.5735	# 490:3 - 502:6
#	491:25-30
	li	r2, 0	# 491:25-30
	b	beq_cont.5736
beq_else.5735:	# 491:36 - 502:6
	lwz	r5, 0(r3)	# 493:16-30
	mflr	r31	# 493:16-30
	mr	r2, r5	# 493:16-30
	stw	r31, 36(r3)	# 493:16-30
	addi	r3, r3, 40	# 493:16-30
	bl	o_isinvert.1990	# 493:16-30
	subi	r3, r3, 40	# 493:16-30
	lwz	r31, 36(r3)	# 493:16-30
	mtlr	r31	# 493:16-30
	lis	r31, ha16(l.4464)	# 493:32-35
	addi	r31, r31, lo16(l.4464)	# 493:32-35
	lfd	f0, 0(r31)	# 493:32-35
	lwz	r5, 4(r3)	# 493:38-43
	lfd	f1, 8(r5)	# 493:38-43
	fcmpu	cr7, f0, f1	# 493:32-43
	bgt	cr7, ble_else.5737	# 493:31-44
#	493:31-44
	li	r6, 0	# 493:31-44
	b	ble_cont.5738
ble_else.5737:	# 493:31-44
	li	r6, 1	# 493:31-44
ble_cont.5738:	# 493:31-44
	mflr	r31	# 493:12-44
	mr	r5, r6	# 493:12-44
	stw	r31, 36(r3)	# 493:12-44
	addi	r3, r3, 40	# 493:12-44
	bl	xor.1977	# 493:12-44
	subi	r3, r3, 40	# 493:12-44
	lwz	r31, 36(r3)	# 493:12-44
	mtlr	r31	# 493:12-44
	cmpwi	cr7, r2, 0	# 493:9-84
	bne	cr7, beq_else.5739	# 492:7 - 493:84
#	493:69-84
	lwz	r2, 0(r3)	# 493:71-84
	mflr	r31	# 493:71-84
	stw	r31, 36(r3)	# 493:71-84
	addi	r3, r3, 40	# 493:71-84
	bl	o_param_b.1996	# 493:71-84
	subi	r3, r3, 40	# 493:71-84
	lwz	r31, 36(r3)	# 493:71-84
	mtlr	r31	# 493:71-84
	fneg	f0, f0	# 493:69-84
	b	beq_cont.5740
beq_else.5739:	# 493:50-63
	lwz	r2, 0(r3)	# 493:50-63
	mflr	r31	# 493:50-63
	stw	r31, 36(r3)	# 493:50-63
	addi	r3, r3, 40	# 493:50-63
	bl	o_param_b.1996	# 493:50-63
	subi	r3, r3, 40	# 493:50-63
	lwz	r31, 36(r3)	# 493:50-63
	mtlr	r31	# 493:50-63
beq_cont.5740:	# 492:7 - 493:84
	lis	r2, ha16(min_caml_solver_w_vec)	# 495:22-34
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 495:22-34
	lfd	f1, 8(r2)	# 495:22-38
	fsub	f0, f0, f1	# 495:16-39
	lwz	r2, 4(r3)	# 495:43-48
	lfd	f1, 8(r2)	# 495:43-48
	fdiv	f0, f0, f1	# 495:7-48
	lwz	r5, 0(r3)	# 497:56-67
	stfd	f0, 32(r3)	# 497:56-67
	mflr	r31	# 497:56-67
	mr	r2, r5	# 497:56-67
	stw	r31, 44(r3)	# 497:56-67
	addi	r3, r3, 48	# 497:56-67
	bl	o_param_c.1998	# 497:56-67
	subi	r3, r3, 48	# 497:56-67
	lwz	r31, 44(r3)	# 497:56-67
	mtlr	r31	# 497:56-67
	lwz	r2, 4(r3)	# 497:27-32
	lfd	f1, 16(r2)	# 497:27-32
	lfd	f2, 32(r3)	# 497:21-32
	fmul	f1, f2, f1	# 497:21-32
	lis	r5, ha16(min_caml_solver_w_vec)	# 497:36-48
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 497:36-48
	lfd	f3, 16(r5)	# 497:36-52
	fadd	f1, f1, f3	# 497:20-53
	stfd	f0, 40(r3)	# 497:10-53
	mflr	r31	# 497:10-53
	fmr	f0, f1	# 497:10-53
	stw	r31, 52(r3)	# 497:10-53
	addi	r3, r3, 56	# 497:10-53
	bl	min_caml_abs_float	# 497:10-53
	subi	r3, r3, 56	# 497:10-53
	lwz	r31, 52(r3)	# 497:10-53
	mtlr	r31	# 497:10-53
	lfd	f1, 40(r3)	# 497:7 - 501:17
	fcmpu	cr7, f1, f0	# 497:10-67
	bgt	cr7, ble_else.5741	# 497:7 - 501:17
#	501:12-17
	li	r2, 0	# 501:12-17
	b	ble_cont.5742
ble_else.5741:	# 498:9 - 500:19
	lwz	r2, 0(r3)	# 498:58-69
	mflr	r31	# 498:58-69
	stw	r31, 52(r3)	# 498:58-69
	addi	r3, r3, 56	# 498:58-69
	bl	o_param_a.1994	# 498:58-69
	subi	r3, r3, 56	# 498:58-69
	lwz	r31, 52(r3)	# 498:58-69
	mtlr	r31	# 498:58-69
	lwz	r2, 4(r3)	# 498:29-34
	lfd	f1, 0(r2)	# 498:29-34
	lfd	f2, 32(r3)	# 498:23-34
	fmul	f1, f2, f1	# 498:23-34
	lis	r5, ha16(min_caml_solver_w_vec)	# 498:38-50
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 498:38-50
	lfd	f3, 0(r5)	# 498:38-54
	fadd	f1, f1, f3	# 498:22-55
	stfd	f0, 48(r3)	# 498:12-55
	mflr	r31	# 498:12-55
	fmr	f0, f1	# 498:12-55
	stw	r31, 60(r3)	# 498:12-55
	addi	r3, r3, 64	# 498:12-55
	bl	min_caml_abs_float	# 498:12-55
	subi	r3, r3, 64	# 498:12-55
	lwz	r31, 60(r3)	# 498:12-55
	mtlr	r31	# 498:12-55
	lfd	f1, 48(r3)	# 498:9 - 500:19
	fcmpu	cr7, f1, f0	# 498:12-69
	bgt	cr7, ble_else.5743	# 498:9 - 500:19
#	500:14-19
	li	r2, 0	# 500:14-19
	b	ble_cont.5744
ble_else.5743:	# 499:14-43
	lis	r2, ha16(min_caml_solver_dist)	# 499:15-26
	addi	r2, r2, lo16(min_caml_solver_dist)	# 499:15-26
	lfd	f0, 32(r3)	# 499:15-36
	stfd	f0, 0(r2)	# 499:15-36
	li	r2, 1	# 499:38-42
ble_cont.5744:	# 498:9 - 500:19
ble_cont.5742:	# 497:7 - 501:17
beq_cont.5736:	# 490:3 - 502:6
	cmpwi	cr7, r2, 0	# 504:3 - 521:27
	bne	cr7, beq_else.5745	# 504:3 - 521:27
#	507:3 - 521:27
	lis	r31, ha16(l.4464)	# 508:8-11
	addi	r31, r31, lo16(l.4464)	# 508:8-11
	lfd	f0, 0(r31)	# 508:8-11
	lwz	r2, 4(r3)	# 508:14-19
	lfd	f1, 16(r2)	# 508:14-19
	fcmpu	cr7, f0, f1	# 508:8-19
	bne	cr7, beq_else.5746	# 507:3 - 519:5
#	508:25-30
	li	r2, 0	# 508:25-30
	b	beq_cont.5747
beq_else.5746:	# 508:36 - 519:5
	lwz	r5, 0(r3)	# 510:16-30
	mflr	r31	# 510:16-30
	mr	r2, r5	# 510:16-30
	stw	r31, 60(r3)	# 510:16-30
	addi	r3, r3, 64	# 510:16-30
	bl	o_isinvert.1990	# 510:16-30
	subi	r3, r3, 64	# 510:16-30
	lwz	r31, 60(r3)	# 510:16-30
	mtlr	r31	# 510:16-30
	lis	r31, ha16(l.4464)	# 510:32-35
	addi	r31, r31, lo16(l.4464)	# 510:32-35
	lfd	f0, 0(r31)	# 510:32-35
	lwz	r5, 4(r3)	# 510:38-43
	lfd	f1, 16(r5)	# 510:38-43
	fcmpu	cr7, f0, f1	# 510:32-43
	bgt	cr7, ble_else.5748	# 510:31-44
#	510:31-44
	li	r6, 0	# 510:31-44
	b	ble_cont.5749
ble_else.5748:	# 510:31-44
	li	r6, 1	# 510:31-44
ble_cont.5749:	# 510:31-44
	mflr	r31	# 510:12-44
	mr	r5, r6	# 510:12-44
	stw	r31, 60(r3)	# 510:12-44
	addi	r3, r3, 64	# 510:12-44
	bl	xor.1977	# 510:12-44
	subi	r3, r3, 64	# 510:12-44
	lwz	r31, 60(r3)	# 510:12-44
	mtlr	r31	# 510:12-44
	cmpwi	cr7, r2, 0	# 510:9-84
	bne	cr7, beq_else.5750	# 509:7 - 510:84
#	510:69-84
	lwz	r2, 0(r3)	# 510:71-84
	mflr	r31	# 510:71-84
	stw	r31, 60(r3)	# 510:71-84
	addi	r3, r3, 64	# 510:71-84
	bl	o_param_c.1998	# 510:71-84
	subi	r3, r3, 64	# 510:71-84
	lwz	r31, 60(r3)	# 510:71-84
	mtlr	r31	# 510:71-84
	fneg	f0, f0	# 510:69-84
	b	beq_cont.5751
beq_else.5750:	# 510:50-63
	lwz	r2, 0(r3)	# 510:50-63
	mflr	r31	# 510:50-63
	stw	r31, 60(r3)	# 510:50-63
	addi	r3, r3, 64	# 510:50-63
	bl	o_param_c.1998	# 510:50-63
	subi	r3, r3, 64	# 510:50-63
	lwz	r31, 60(r3)	# 510:50-63
	mtlr	r31	# 510:50-63
beq_cont.5751:	# 509:7 - 510:84
	lis	r2, ha16(min_caml_solver_w_vec)	# 512:22-34
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 512:22-34
	lfd	f1, 16(r2)	# 512:22-38
	fsub	f0, f0, f1	# 512:16-39
	lwz	r2, 4(r3)	# 512:43-48
	lfd	f1, 16(r2)	# 512:43-48
	fdiv	f0, f0, f1	# 512:7-48
	lwz	r5, 0(r3)	# 514:56-67
	stfd	f0, 56(r3)	# 514:56-67
	mflr	r31	# 514:56-67
	mr	r2, r5	# 514:56-67
	stw	r31, 68(r3)	# 514:56-67
	addi	r3, r3, 72	# 514:56-67
	bl	o_param_a.1994	# 514:56-67
	subi	r3, r3, 72	# 514:56-67
	lwz	r31, 68(r3)	# 514:56-67
	mtlr	r31	# 514:56-67
	lwz	r2, 4(r3)	# 514:27-32
	lfd	f1, 0(r2)	# 514:27-32
	lfd	f2, 56(r3)	# 514:21-32
	fmul	f1, f2, f1	# 514:21-32
	lis	r5, ha16(min_caml_solver_w_vec)	# 514:36-48
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 514:36-48
	lfd	f3, 0(r5)	# 514:36-52
	fadd	f1, f1, f3	# 514:20-53
	stfd	f0, 64(r3)	# 514:10-53
	mflr	r31	# 514:10-53
	fmr	f0, f1	# 514:10-53
	stw	r31, 76(r3)	# 514:10-53
	addi	r3, r3, 80	# 514:10-53
	bl	min_caml_abs_float	# 514:10-53
	subi	r3, r3, 80	# 514:10-53
	lwz	r31, 76(r3)	# 514:10-53
	mtlr	r31	# 514:10-53
	lfd	f1, 64(r3)	# 514:7 - 518:17
	fcmpu	cr7, f1, f0	# 514:10-67
	bgt	cr7, ble_else.5752	# 514:7 - 518:17
#	518:12-17
	li	r2, 0	# 518:12-17
	b	ble_cont.5753
ble_else.5752:	# 515:9 - 517:19
	lwz	r2, 0(r3)	# 515:58-69
	mflr	r31	# 515:58-69
	stw	r31, 76(r3)	# 515:58-69
	addi	r3, r3, 80	# 515:58-69
	bl	o_param_b.1996	# 515:58-69
	subi	r3, r3, 80	# 515:58-69
	lwz	r31, 76(r3)	# 515:58-69
	mtlr	r31	# 515:58-69
	lwz	r2, 4(r3)	# 515:29-34
	lfd	f1, 8(r2)	# 515:29-34
	lfd	f2, 56(r3)	# 515:23-34
	fmul	f1, f2, f1	# 515:23-34
	lis	r2, ha16(min_caml_solver_w_vec)	# 515:38-50
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 515:38-50
	lfd	f3, 8(r2)	# 515:38-54
	fadd	f1, f1, f3	# 515:22-55
	stfd	f0, 72(r3)	# 515:12-55
	mflr	r31	# 515:12-55
	fmr	f0, f1	# 515:12-55
	stw	r31, 84(r3)	# 515:12-55
	addi	r3, r3, 88	# 515:12-55
	bl	min_caml_abs_float	# 515:12-55
	subi	r3, r3, 88	# 515:12-55
	lwz	r31, 84(r3)	# 515:12-55
	mtlr	r31	# 515:12-55
	lfd	f1, 72(r3)	# 515:9 - 517:19
	fcmpu	cr7, f1, f0	# 515:12-69
	bgt	cr7, ble_else.5754	# 515:9 - 517:19
#	517:14-19
	li	r2, 0	# 517:14-19
	b	ble_cont.5755
ble_else.5754:	# 516:14-43
	lis	r2, ha16(min_caml_solver_dist)	# 516:15-26
	addi	r2, r2, lo16(min_caml_solver_dist)	# 516:15-26
	lfd	f0, 56(r3)	# 516:15-36
	stfd	f0, 0(r2)	# 516:15-36
	li	r2, 1	# 516:38-42
ble_cont.5755:	# 515:9 - 517:19
ble_cont.5753:	# 514:7 - 518:17
beq_cont.5747:	# 507:3 - 519:5
	cmpwi	cr7, r2, 0	# 521:3-27
	bne	cr7, beq_else.5756	# 521:3-27
#	521:26-27
	li	r2, 0	# 521:26-27
	blr	# 521:26-27
beq_else.5756:	# 521:19-20
	li	r2, 3	# 521:19-20
	blr	# 521:19-20
beq_else.5745:	# 504:19-20
	li	r2, 2	# 504:19-20
	blr	# 504:19-20
beq_else.5734:	# 487:19-20
	li	r2, 1	# 487:19-20
	blr	# 487:19-20
solver_surface.2048:	# 525:12 - 533:9
	lfd	f0, 0(r5)	# 529:12-17
	stw	r2, 0(r3)	# 529:21-32
	stw	r5, 4(r3)	# 529:21-32
	stfd	f0, 8(r3)	# 529:21-32
	mflr	r31	# 529:21-32
	stw	r31, 20(r3)	# 529:21-32
	addi	r3, r3, 24	# 529:21-32
	bl	o_param_a.1994	# 529:21-32
	subi	r3, r3, 24	# 529:21-32
	lwz	r31, 20(r3)	# 529:21-32
	mtlr	r31	# 529:21-32
	lfd	f1, 8(r3)	# 529:12-32
	fmul	f0, f1, f0	# 529:12-32
	lwz	r2, 4(r3)	# 529:36-41
	lfd	f1, 8(r2)	# 529:36-41
	lwz	r5, 0(r3)	# 529:45-56
	stfd	f0, 16(r3)	# 529:45-56
	stfd	f1, 24(r3)	# 529:45-56
	mflr	r31	# 529:45-56
	mr	r2, r5	# 529:45-56
	stw	r31, 36(r3)	# 529:45-56
	addi	r3, r3, 40	# 529:45-56
	bl	o_param_b.1996	# 529:45-56
	subi	r3, r3, 40	# 529:45-56
	lwz	r31, 36(r3)	# 529:45-56
	mtlr	r31	# 529:45-56
	lfd	f1, 24(r3)	# 529:36-56
	fmul	f0, f1, f0	# 529:36-56
	lfd	f1, 16(r3)	# 529:12-56
	fadd	f0, f1, f0	# 529:12-56
	lwz	r2, 4(r3)	# 529:60-65
	lfd	f1, 16(r2)	# 529:60-65
	lwz	r2, 0(r3)	# 529:69-80
	stfd	f0, 32(r3)	# 529:69-80
	stfd	f1, 40(r3)	# 529:69-80
	mflr	r31	# 529:69-80
	stw	r31, 52(r3)	# 529:69-80
	addi	r3, r3, 56	# 529:69-80
	bl	o_param_c.1998	# 529:69-80
	subi	r3, r3, 56	# 529:69-80
	lwz	r31, 52(r3)	# 529:69-80
	mtlr	r31	# 529:69-80
	lfd	f1, 40(r3)	# 529:60-80
	fmul	f0, f1, f0	# 529:60-80
	lfd	f1, 32(r3)	# 529:3-81
	fadd	f0, f1, f0	# 529:3-81
	lis	r31, ha16(l.4464)	# 530:6-9
	addi	r31, r31, lo16(l.4464)	# 530:6-9
	lfd	f1, 0(r31)	# 530:6-9
	fcmpu	cr7, f0, f1	# 530:6-13
	bgt	cr7, ble_else.5757	# 530:3 - 533:9
#	533:8-9
	li	r2, 0	# 533:8-9
	blr	# 533:8-9
ble_else.5757:	# 531:5 - 532:32
	lis	r2, ha16(min_caml_solver_w_vec)	# 531:14-26
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 531:14-26
	lfd	f1, 0(r2)	# 531:14-30
	lwz	r2, 0(r3)	# 531:34-45
	stfd	f0, 48(r3)	# 531:34-45
	stfd	f1, 56(r3)	# 531:34-45
	mflr	r31	# 531:34-45
	stw	r31, 68(r3)	# 531:34-45
	addi	r3, r3, 72	# 531:34-45
	bl	o_param_a.1994	# 531:34-45
	subi	r3, r3, 72	# 531:34-45
	lwz	r31, 68(r3)	# 531:34-45
	mtlr	r31	# 531:34-45
	lfd	f1, 56(r3)	# 531:14-45
	fmul	f0, f1, f0	# 531:14-45
	lis	r2, ha16(min_caml_solver_w_vec)	# 531:49-61
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 531:49-61
	lfd	f1, 8(r2)	# 531:49-65
	lwz	r2, 0(r3)	# 531:69-80
	stfd	f0, 64(r3)	# 531:69-80
	stfd	f1, 72(r3)	# 531:69-80
	mflr	r31	# 531:69-80
	stw	r31, 84(r3)	# 531:69-80
	addi	r3, r3, 88	# 531:69-80
	bl	o_param_b.1996	# 531:69-80
	subi	r3, r3, 88	# 531:69-80
	lwz	r31, 84(r3)	# 531:69-80
	mtlr	r31	# 531:69-80
	lfd	f1, 72(r3)	# 531:49-80
	fmul	f0, f1, f0	# 531:49-80
	lfd	f1, 64(r3)	# 531:14-80
	fadd	f0, f1, f0	# 531:14-80
	lis	r2, ha16(min_caml_solver_w_vec)	# 531:84-96
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 531:84-96
	lfd	f1, 16(r2)	# 531:84-100
	lwz	r2, 0(r3)	# 531:104-115
	stfd	f0, 80(r3)	# 531:104-115
	stfd	f1, 88(r3)	# 531:104-115
	mflr	r31	# 531:104-115
	stw	r31, 100(r3)	# 531:104-115
	addi	r3, r3, 104	# 531:104-115
	bl	o_param_c.1998	# 531:104-115
	subi	r3, r3, 104	# 531:104-115
	lwz	r31, 100(r3)	# 531:104-115
	mtlr	r31	# 531:104-115
	lfd	f1, 88(r3)	# 531:84-115
	fmul	f0, f1, f0	# 531:84-115
	lfd	f1, 80(r3)	# 531:13-116
	fadd	f0, f1, f0	# 531:13-116
	lfd	f1, 48(r3)	# 531:5-121
	fdiv	f0, f0, f1	# 531:5-121
	lis	r2, ha16(min_caml_solver_dist)	# 532:6-17
	addi	r2, r2, lo16(min_caml_solver_dist)	# 532:6-17
	fneg	f0, f0	# 532:25-28
	stfd	f0, 0(r2)	# 532:6-28
	li	r2, 1	# 532:30-31
	blr	# 532:30-31
in_prod_sqr_obj.2051:	# 538:12 - 542:37
	lfd	f0, 0(r5)	# 540:10-15
	stw	r5, 0(r3)	# 540:4-16
	stw	r2, 4(r3)	# 540:4-16
	mflr	r31	# 540:4-16
	stw	r31, 12(r3)	# 540:4-16
	addi	r3, r3, 16	# 540:4-16
	bl	fsqr.1980	# 540:4-16
	subi	r3, r3, 16	# 540:4-16
	lwz	r31, 12(r3)	# 540:4-16
	mtlr	r31	# 540:4-16
	lwz	r2, 4(r3)	# 540:20-31
	stfd	f0, 8(r3)	# 540:20-31
	mflr	r31	# 540:20-31
	stw	r31, 20(r3)	# 540:20-31
	addi	r3, r3, 24	# 540:20-31
	bl	o_param_a.1994	# 540:20-31
	subi	r3, r3, 24	# 540:20-31
	lwz	r31, 20(r3)	# 540:20-31
	mtlr	r31	# 540:20-31
	lfd	f1, 8(r3)	# 540:4-31
	fmul	f0, f1, f0	# 540:4-31
	lwz	r2, 0(r3)	# 541:15-20
	lfd	f1, 8(r2)	# 541:15-20
	stfd	f0, 16(r3)	# 541:9-21
	mflr	r31	# 541:9-21
	fmr	f0, f1	# 541:9-21
	stw	r31, 28(r3)	# 541:9-21
	addi	r3, r3, 32	# 541:9-21
	bl	fsqr.1980	# 541:9-21
	subi	r3, r3, 32	# 541:9-21
	lwz	r31, 28(r3)	# 541:9-21
	mtlr	r31	# 541:9-21
	lwz	r2, 4(r3)	# 541:25-36
	stfd	f0, 24(r3)	# 541:25-36
	mflr	r31	# 541:25-36
	stw	r31, 36(r3)	# 541:25-36
	addi	r3, r3, 40	# 541:25-36
	bl	o_param_b.1996	# 541:25-36
	subi	r3, r3, 40	# 541:25-36
	lwz	r31, 36(r3)	# 541:25-36
	mtlr	r31	# 541:25-36
	lfd	f1, 24(r3)	# 541:9-36
	fmul	f0, f1, f0	# 541:9-36
	lfd	f1, 16(r3)	# 540:4 - 541:36
	fadd	f0, f1, f0	# 540:4 - 541:36
	lwz	r2, 0(r3)	# 542:15-20
	lfd	f1, 16(r2)	# 542:15-20
	stfd	f0, 32(r3)	# 542:9-21
	mflr	r31	# 542:9-21
	fmr	f0, f1	# 542:9-21
	stw	r31, 44(r3)	# 542:9-21
	addi	r3, r3, 48	# 542:9-21
	bl	fsqr.1980	# 542:9-21
	subi	r3, r3, 48	# 542:9-21
	lwz	r31, 44(r3)	# 542:9-21
	mtlr	r31	# 542:9-21
	lwz	r2, 4(r3)	# 542:25-36
	stfd	f0, 40(r3)	# 542:25-36
	mflr	r31	# 542:25-36
	stw	r31, 52(r3)	# 542:25-36
	addi	r3, r3, 56	# 542:25-36
	bl	o_param_c.1998	# 542:25-36
	subi	r3, r3, 56	# 542:25-36
	lwz	r31, 52(r3)	# 542:25-36
	mtlr	r31	# 542:25-36
	lfd	f1, 40(r3)	# 542:9-36
	fmul	f0, f1, f0	# 542:9-36
	lfd	f1, 32(r3)	# 540:3 - 542:37
	fadd	f0, f1, f0	# 540:3 - 542:37
	blr	# 540:3 - 542:37
in_prod_co_objrot.2054:	# 545:12 - 549:38
	lfd	f0, 8(r5)	# 547:3-8
	lfd	f1, 16(r5)	# 547:12-17
	fmul	f0, f0, f1	# 547:3-17
	stw	r2, 0(r3)	# 547:21-33
	stw	r5, 4(r3)	# 547:21-33
	stfd	f0, 8(r3)	# 547:21-33
	mflr	r31	# 547:21-33
	stw	r31, 20(r3)	# 547:21-33
	addi	r3, r3, 24	# 547:21-33
	bl	o_param_r1.2016	# 547:21-33
	subi	r3, r3, 24	# 547:21-33
	lwz	r31, 20(r3)	# 547:21-33
	mtlr	r31	# 547:21-33
	lfd	f1, 8(r3)	# 547:3-33
	fmul	f0, f1, f0	# 547:3-33
	lwz	r2, 4(r3)	# 548:8-13
	lfd	f1, 0(r2)	# 548:8-13
	lfd	f2, 16(r2)	# 548:17-22
	fmul	f1, f1, f2	# 548:8-22
	lwz	r5, 0(r3)	# 548:26-38
	stfd	f0, 16(r3)	# 548:26-38
	stfd	f1, 24(r3)	# 548:26-38
	mflr	r31	# 548:26-38
	mr	r2, r5	# 548:26-38
	stw	r31, 36(r3)	# 548:26-38
	addi	r3, r3, 40	# 548:26-38
	bl	o_param_r2.2018	# 548:26-38
	subi	r3, r3, 40	# 548:26-38
	lwz	r31, 36(r3)	# 548:26-38
	mtlr	r31	# 548:26-38
	lfd	f1, 24(r3)	# 548:8-38
	fmul	f0, f1, f0	# 548:8-38
	lfd	f1, 16(r3)	# 547:3 - 548:38
	fadd	f0, f1, f0	# 547:3 - 548:38
	lwz	r2, 4(r3)	# 549:8-13
	lfd	f1, 0(r2)	# 549:8-13
	lfd	f2, 8(r2)	# 549:17-22
	fmul	f1, f1, f2	# 549:8-22
	lwz	r2, 0(r3)	# 549:26-38
	stfd	f0, 32(r3)	# 549:26-38
	stfd	f1, 40(r3)	# 549:26-38
	mflr	r31	# 549:26-38
	stw	r31, 52(r3)	# 549:26-38
	addi	r3, r3, 56	# 549:26-38
	bl	o_param_r3.2020	# 549:26-38
	subi	r3, r3, 56	# 549:26-38
	lwz	r31, 52(r3)	# 549:26-38
	mtlr	r31	# 549:26-38
	lfd	f1, 40(r3)	# 549:8-38
	fmul	f0, f1, f0	# 549:8-38
	lfd	f1, 32(r3)	# 547:3 - 549:38
	fadd	f0, f1, f0	# 547:3 - 549:38
	blr	# 547:3 - 549:38
solver2nd_mul_b.2057:	# 552:12 - 556:48
	lis	r6, ha16(min_caml_solver_w_vec)	# 554:3-15
	addi	r6, r6, lo16(min_caml_solver_w_vec)	# 554:3-15
	lfd	f0, 0(r6)	# 554:3-19
	lfd	f1, 0(r5)	# 554:23-28
	fmul	f0, f0, f1	# 554:3-28
	stw	r2, 0(r3)	# 554:32-43
	stw	r5, 4(r3)	# 554:32-43
	stfd	f0, 8(r3)	# 554:32-43
	mflr	r31	# 554:32-43
	stw	r31, 20(r3)	# 554:32-43
	addi	r3, r3, 24	# 554:32-43
	bl	o_param_a.1994	# 554:32-43
	subi	r3, r3, 24	# 554:32-43
	lwz	r31, 20(r3)	# 554:32-43
	mtlr	r31	# 554:32-43
	lfd	f1, 8(r3)	# 554:3-43
	fmul	f0, f1, f0	# 554:3-43
	lis	r2, ha16(min_caml_solver_w_vec)	# 555:8-20
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 555:8-20
	lfd	f1, 8(r2)	# 555:8-24
	lwz	r2, 4(r3)	# 555:28-33
	lfd	f2, 8(r2)	# 555:28-33
	fmul	f1, f1, f2	# 555:8-33
	lwz	r5, 0(r3)	# 555:37-48
	stfd	f0, 16(r3)	# 555:37-48
	stfd	f1, 24(r3)	# 555:37-48
	mflr	r31	# 555:37-48
	mr	r2, r5	# 555:37-48
	stw	r31, 36(r3)	# 555:37-48
	addi	r3, r3, 40	# 555:37-48
	bl	o_param_b.1996	# 555:37-48
	subi	r3, r3, 40	# 555:37-48
	lwz	r31, 36(r3)	# 555:37-48
	mtlr	r31	# 555:37-48
	lfd	f1, 24(r3)	# 555:8-48
	fmul	f0, f1, f0	# 555:8-48
	lfd	f1, 16(r3)	# 554:3 - 555:48
	fadd	f0, f1, f0	# 554:3 - 555:48
	lis	r2, ha16(min_caml_solver_w_vec)	# 556:8-20
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 556:8-20
	lfd	f1, 16(r2)	# 556:8-24
	lwz	r2, 4(r3)	# 556:28-33
	lfd	f2, 16(r2)	# 556:28-33
	fmul	f1, f1, f2	# 556:8-33
	lwz	r2, 0(r3)	# 556:37-48
	stfd	f0, 32(r3)	# 556:37-48
	stfd	f1, 40(r3)	# 556:37-48
	mflr	r31	# 556:37-48
	stw	r31, 52(r3)	# 556:37-48
	addi	r3, r3, 56	# 556:37-48
	bl	o_param_c.1998	# 556:37-48
	subi	r3, r3, 56	# 556:37-48
	lwz	r31, 52(r3)	# 556:37-48
	mtlr	r31	# 556:37-48
	lfd	f1, 40(r3)	# 556:8-48
	fmul	f0, f1, f0	# 556:8-48
	lfd	f1, 32(r3)	# 554:3 - 556:48
	fadd	f0, f1, f0	# 554:3 - 556:48
	blr	# 554:3 - 556:48
solver2nd_rot_b.2060:	# 559:12 - 563:81
	lis	r6, ha16(min_caml_solver_w_vec)	# 561:5-17
	addi	r6, r6, lo16(min_caml_solver_w_vec)	# 561:5-17
	lfd	f0, 16(r6)	# 561:5-21
	lfd	f1, 8(r5)	# 561:25-30
	fmul	f0, f0, f1	# 561:5-30
	lis	r6, ha16(min_caml_solver_w_vec)	# 561:34-46
	addi	r6, r6, lo16(min_caml_solver_w_vec)	# 561:34-46
	lfd	f1, 8(r6)	# 561:34-50
	lfd	f2, 16(r5)	# 561:54-59
	fmul	f1, f1, f2	# 561:34-59
	fadd	f0, f0, f1	# 561:4-60
	stw	r2, 0(r3)	# 561:64-76
	stw	r5, 4(r3)	# 561:64-76
	stfd	f0, 8(r3)	# 561:64-76
	mflr	r31	# 561:64-76
	stw	r31, 20(r3)	# 561:64-76
	addi	r3, r3, 24	# 561:64-76
	bl	o_param_r1.2016	# 561:64-76
	subi	r3, r3, 24	# 561:64-76
	lwz	r31, 20(r3)	# 561:64-76
	mtlr	r31	# 561:64-76
	lfd	f1, 8(r3)	# 561:4-76
	fmul	f0, f1, f0	# 561:4-76
	lis	r2, ha16(min_caml_solver_w_vec)	# 562:10-22
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 562:10-22
	lfd	f1, 0(r2)	# 562:10-26
	lwz	r2, 4(r3)	# 562:30-35
	lfd	f2, 16(r2)	# 562:30-35
	fmul	f1, f1, f2	# 562:10-35
	lis	r5, ha16(min_caml_solver_w_vec)	# 562:39-51
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 562:39-51
	lfd	f2, 16(r5)	# 562:39-55
	lfd	f3, 0(r2)	# 562:59-64
	fmul	f2, f2, f3	# 562:39-64
	fadd	f1, f1, f2	# 562:9-65
	lwz	r5, 0(r3)	# 562:69-81
	stfd	f0, 16(r3)	# 562:69-81
	stfd	f1, 24(r3)	# 562:69-81
	mflr	r31	# 562:69-81
	mr	r2, r5	# 562:69-81
	stw	r31, 36(r3)	# 562:69-81
	addi	r3, r3, 40	# 562:69-81
	bl	o_param_r2.2018	# 562:69-81
	subi	r3, r3, 40	# 562:69-81
	lwz	r31, 36(r3)	# 562:69-81
	mtlr	r31	# 562:69-81
	lfd	f1, 24(r3)	# 562:9-81
	fmul	f0, f1, f0	# 562:9-81
	lfd	f1, 16(r3)	# 561:4 - 562:81
	fadd	f0, f1, f0	# 561:4 - 562:81
	lis	r2, ha16(min_caml_solver_w_vec)	# 563:10-22
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 563:10-22
	lfd	f1, 0(r2)	# 563:10-26
	lwz	r2, 4(r3)	# 563:30-35
	lfd	f2, 8(r2)	# 563:30-35
	fmul	f1, f1, f2	# 563:10-35
	lis	r5, ha16(min_caml_solver_w_vec)	# 563:39-51
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 563:39-51
	lfd	f2, 8(r5)	# 563:39-55
	lfd	f3, 0(r2)	# 563:59-64
	fmul	f2, f2, f3	# 563:39-64
	fadd	f1, f1, f2	# 563:9-65
	lwz	r2, 0(r3)	# 563:69-81
	stfd	f0, 32(r3)	# 563:69-81
	stfd	f1, 40(r3)	# 563:69-81
	mflr	r31	# 563:69-81
	stw	r31, 52(r3)	# 563:69-81
	addi	r3, r3, 56	# 563:69-81
	bl	o_param_r3.2020	# 563:69-81
	subi	r3, r3, 56	# 563:69-81
	lwz	r31, 52(r3)	# 563:69-81
	mtlr	r31	# 563:69-81
	lfd	f1, 40(r3)	# 563:9-81
	fmul	f0, f1, f0	# 563:9-81
	lfd	f1, 32(r3)	# 561:4 - 563:81
	fadd	f0, f1, f0	# 561:4 - 563:81
	blr	# 561:4 - 563:81
solver_second.2063:	# 566:12 - 604:6
	stw	r5, 0(r3)	# 568:13-32
	stw	r2, 4(r3)	# 568:13-32
	mflr	r31	# 568:3-32
	stw	r31, 12(r3)	# 568:3-32
	addi	r3, r3, 16	# 568:3-32
	bl	in_prod_sqr_obj.2051	# 568:3-32
	subi	r3, r3, 16	# 568:3-32
	lwz	r31, 12(r3)	# 568:3-32
	mtlr	r31	# 568:3-32
	lwz	r2, 4(r3)	# 570:8-17
	stfd	f0, 8(r3)	# 570:8-17
	mflr	r31	# 570:8-17
	stw	r31, 20(r3)	# 570:8-17
	addi	r3, r3, 24	# 570:8-17
	bl	o_isrot.1992	# 570:8-17
	subi	r3, r3, 24	# 570:8-17
	lwz	r31, 20(r3)	# 570:8-17
	mtlr	r31	# 570:8-17
	cmpwi	cr7, r2, 0	# 570:8-22
	bne	cr7, beq_else.5758	# 569:3 - 571:13
#	571:10-13
	lfd	f0, 8(r3)	# 571:10-13
	b	beq_cont.5759
beq_else.5758:	# 570:28-56
	lwz	r2, 4(r3)	# 570:35-56
	lwz	r5, 0(r3)	# 570:35-56
	mflr	r31	# 570:35-56
	stw	r31, 20(r3)	# 570:35-56
	addi	r3, r3, 24	# 570:35-56
	bl	in_prod_co_objrot.2054	# 570:35-56
	subi	r3, r3, 24	# 570:35-56
	lwz	r31, 20(r3)	# 570:35-56
	mtlr	r31	# 570:35-56
	lfd	f1, 8(r3)	# 570:28-56
	fadd	f0, f1, f0	# 570:28-56
beq_cont.5759:	# 569:3 - 571:13
	lis	r31, ha16(l.4464)	# 573:6-9
	addi	r31, r31, lo16(l.4464)	# 573:6-9
	lfd	f1, 0(r31)	# 573:6-9
	fcmpu	cr7, f1, f0	# 573:6-14
	bne	cr7, beq_else.5760	# 573:3 - 604:6
#	574:8-9
	li	r2, 0	# 574:8-9
	blr	# 574:8-9
beq_else.5760:	# 576:5 - 604:6
	lis	r31, ha16(l.4440)	# 577:16-19
	addi	r31, r31, lo16(l.4440)	# 577:16-19
	lfd	f1, 0(r31)	# 577:16-19
	lwz	r2, 4(r3)	# 577:23-42
	lwz	r5, 0(r3)	# 577:23-42
	stfd	f0, 16(r3)	# 577:23-42
	stfd	f1, 24(r3)	# 577:23-42
	mflr	r31	# 577:23-42
	stw	r31, 36(r3)	# 577:23-42
	addi	r3, r3, 40	# 577:23-42
	bl	solver2nd_mul_b.2057	# 577:23-42
	subi	r3, r3, 40	# 577:23-42
	lwz	r31, 36(r3)	# 577:23-42
	mtlr	r31	# 577:23-42
	lfd	f1, 24(r3)	# 577:6-42
	fmul	f0, f1, f0	# 577:6-42
	lwz	r2, 4(r3)	# 580:11-20
	stfd	f0, 32(r3)	# 580:11-20
	mflr	r31	# 580:11-20
	stw	r31, 44(r3)	# 580:11-20
	addi	r3, r3, 48	# 580:11-20
	bl	o_isrot.1992	# 580:11-20
	subi	r3, r3, 48	# 580:11-20
	lwz	r31, 44(r3)	# 580:11-20
	mtlr	r31	# 580:11-20
	cmpwi	cr7, r2, 0	# 580:11-25
	bne	cr7, beq_else.5761	# 579:6 - 581:16
#	581:13-16
	lfd	f0, 32(r3)	# 581:13-16
	b	beq_cont.5762
beq_else.5761:	# 580:31-57
	lwz	r2, 4(r3)	# 580:38-57
	lwz	r5, 0(r3)	# 580:38-57
	mflr	r31	# 580:38-57
	stw	r31, 44(r3)	# 580:38-57
	addi	r3, r3, 48	# 580:38-57
	bl	solver2nd_rot_b.2060	# 580:38-57
	subi	r3, r3, 48	# 580:38-57
	lwz	r31, 44(r3)	# 580:38-57
	mtlr	r31	# 580:38-57
	lfd	f1, 32(r3)	# 580:31-57
	fadd	f0, f1, f0	# 580:31-57
beq_cont.5762:	# 579:6 - 581:16
	lis	r5, ha16(min_caml_solver_w_vec)	# 583:34-46
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 583:34-46
	lwz	r2, 4(r3)	# 583:6-46
	stfd	f0, 40(r3)	# 583:16-46
	mflr	r31	# 583:6-46
	stw	r31, 52(r3)	# 583:6-46
	addi	r3, r3, 56	# 583:6-46
	bl	in_prod_sqr_obj.2051	# 583:6-46
	subi	r3, r3, 56	# 583:6-46
	lwz	r31, 52(r3)	# 583:6-46
	mtlr	r31	# 583:6-46
	lwz	r2, 4(r3)	# 585:11-20
	stfd	f0, 48(r3)	# 585:11-20
	mflr	r31	# 585:11-20
	stw	r31, 60(r3)	# 585:11-20
	addi	r3, r3, 64	# 585:11-20
	bl	o_isrot.1992	# 585:11-20
	subi	r3, r3, 64	# 585:11-20
	lwz	r31, 60(r3)	# 585:11-20
	mtlr	r31	# 585:11-20
	cmpwi	cr7, r2, 0	# 585:11-25
	bne	cr7, beq_else.5763	# 584:6 - 587:16
#	587:13-16
	lfd	f0, 48(r3)	# 587:13-16
	b	beq_cont.5764
beq_else.5763:	# 586:10-51
	lis	r5, ha16(min_caml_solver_w_vec)	# 586:38-50
	addi	r5, r5, lo16(min_caml_solver_w_vec)	# 586:38-50
	lwz	r2, 4(r3)	# 586:18-50
	mflr	r31	# 586:18-50
	stw	r31, 60(r3)	# 586:18-50
	addi	r3, r3, 64	# 586:18-50
	bl	in_prod_co_objrot.2054	# 586:18-50
	subi	r3, r3, 64	# 586:18-50
	lwz	r31, 60(r3)	# 586:18-50
	mtlr	r31	# 586:18-50
	lfd	f1, 48(r3)	# 586:10-51
	fadd	f0, f1, f0	# 586:10-51
beq_cont.5764:	# 584:6 - 587:16
	lwz	r2, 4(r3)	# 589:11-19
	stfd	f0, 56(r3)	# 589:11-19
	mflr	r31	# 589:11-19
	stw	r31, 68(r3)	# 589:11-19
	addi	r3, r3, 72	# 589:11-19
	bl	o_form.1986	# 589:11-19
	subi	r3, r3, 72	# 589:11-19
	lwz	r31, 68(r3)	# 589:11-19
	mtlr	r31	# 589:11-19
	cmpwi	cr7, r2, 3	# 589:11-23
	bne	cr7, beq_else.5765	# 588:6 - 590:32
#	590:13-23
	lis	r31, ha16(l.4465)	# 590:20-23
	addi	r31, r31, lo16(l.4465)	# 590:20-23
	lfd	f0, 0(r31)	# 590:20-23
	lfd	f1, 56(r3)	# 590:13-23
	fsub	f0, f1, f0	# 590:13-23
	b	beq_cont.5766
beq_else.5765:	# 590:29-32
	lfd	f0, 56(r3)	# 590:29-32
beq_cont.5766:	# 588:6 - 590:32
	lis	r31, ha16(l.4682)	# 593:17-20
	addi	r31, r31, lo16(l.4682)	# 593:17-20
	lfd	f1, 0(r31)	# 593:17-20
	lfd	f2, 16(r3)	# 593:17-26
	fmul	f1, f1, f2	# 593:17-26
	fmul	f0, f1, f0	# 593:8-32
	lfd	f1, 40(r3)	# 594:8-17
	stfd	f0, 64(r3)	# 594:8-17
	mflr	r31	# 594:8-17
	fmr	f0, f1	# 594:8-17
	stw	r31, 76(r3)	# 594:8-17
	addi	r3, r3, 80	# 594:8-17
	bl	fsqr.1980	# 594:8-17
	subi	r3, r3, 80	# 594:8-17
	lwz	r31, 76(r3)	# 594:8-17
	mtlr	r31	# 594:8-17
	lfd	f1, 64(r3)	# 592:6 - 594:23
	fsub	f0, f0, f1	# 592:6 - 594:23
	lis	r31, ha16(l.4464)	# 596:9-12
	addi	r31, r31, lo16(l.4464)	# 596:9-12
	lfd	f1, 0(r31)	# 596:9-12
	fcmpu	cr7, f0, f1	# 596:9-16
	bgt	cr7, ble_else.5767	# 596:6 - 603:12
#	603:11-12
	li	r2, 0	# 603:11-12
	blr	# 603:11-12
ble_else.5767:	# 598:8 - 602:9
	mflr	r31	# 599:9-24
	stw	r31, 76(r3)	# 599:9-24
	addi	r3, r3, 80	# 599:9-24
	bl	min_caml_sqrt	# 599:9-24
	subi	r3, r3, 80	# 599:9-24
	lwz	r31, 76(r3)	# 599:9-24
	mtlr	r31	# 599:9-24
	lwz	r2, 4(r3)	# 600:21-33
	stfd	f0, 72(r3)	# 600:21-33
	mflr	r31	# 600:21-33
	stw	r31, 84(r3)	# 600:21-33
	addi	r3, r3, 88	# 600:21-33
	bl	o_isinvert.1990	# 600:21-33
	subi	r3, r3, 88	# 600:21-33
	lwz	r31, 84(r3)	# 600:21-33
	mtlr	r31	# 600:21-33
	cmpwi	cr7, r2, 0	# 600:18-51
	bne	cr7, beq_else.5768	# 600:9-51
#	600:47-51
	lfd	f0, 72(r3)	# 600:47-51
	fneg	f0, f0	# 600:47-51
	b	beq_cont.5769
beq_else.5768:	# 600:39-41
	lfd	f0, 72(r3)	# 600:39-41
beq_cont.5769:	# 600:9-51
	lis	r2, ha16(min_caml_solver_dist)	# 601:10-21
	addi	r2, r2, lo16(min_caml_solver_dist)	# 601:10-21
	lfd	f1, 40(r3)	# 601:30-40
	fsub	f0, f0, f1	# 601:30-40
	lis	r31, ha16(l.4440)	# 601:44-47
	addi	r31, r31, lo16(l.4440)	# 601:44-47
	lfd	f1, 0(r31)	# 601:44-47
	fdiv	f0, f0, f1	# 601:30-47
	lfd	f1, 16(r3)	# 601:29-54
	fdiv	f0, f0, f1	# 601:29-54
	stfd	f0, 0(r2)	# 601:10-54
	li	r2, 1	# 601:56-57
	blr	# 601:56-57
solver.2066:	# 608:12 - 617:25
	lis	r7, ha16(min_caml_objects)	# 610:11-18
	addi	r7, r7, lo16(min_caml_objects)	# 610:11-18
	slwi	r2, r2, 2	# 610:11-26
	lwzx	r2, r7, r2	# 610:3-26
	lis	r7, ha16(min_caml_solver_w_vec)	# 611:3-15
	addi	r7, r7, lo16(min_caml_solver_w_vec)	# 611:3-15
	lfd	f0, 0(r6)	# 611:23-28
	stw	r5, 0(r3)	# 611:32-43
	stw	r2, 4(r3)	# 611:32-43
	stw	r6, 8(r3)	# 611:32-43
	stw	r7, 12(r3)	# 611:32-43
	stfd	f0, 16(r3)	# 611:32-43
	mflr	r31	# 611:32-43
	stw	r31, 28(r3)	# 611:32-43
	addi	r3, r3, 32	# 611:32-43
	bl	o_param_x.2000	# 611:32-43
	subi	r3, r3, 32	# 611:32-43
	lwz	r31, 28(r3)	# 611:32-43
	mtlr	r31	# 611:32-43
	lfd	f1, 16(r3)	# 611:23-43
	fsub	f0, f1, f0	# 611:23-43
	lwz	r2, 12(r3)	# 611:3-43
	stfd	f0, 0(r2)	# 611:3-43
	lis	r2, ha16(min_caml_solver_w_vec)	# 612:3-15
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 612:3-15
	lwz	r5, 8(r3)	# 612:23-28
	lfd	f0, 8(r5)	# 612:23-28
	lwz	r6, 4(r3)	# 612:32-43
	stw	r2, 24(r3)	# 612:32-43
	stfd	f0, 32(r3)	# 612:32-43
	mflr	r31	# 612:32-43
	mr	r2, r6	# 612:32-43
	stw	r31, 44(r3)	# 612:32-43
	addi	r3, r3, 48	# 612:32-43
	bl	o_param_y.2002	# 612:32-43
	subi	r3, r3, 48	# 612:32-43
	lwz	r31, 44(r3)	# 612:32-43
	mtlr	r31	# 612:32-43
	lfd	f1, 32(r3)	# 612:23-43
	fsub	f0, f1, f0	# 612:23-43
	lwz	r2, 24(r3)	# 612:3-43
	stfd	f0, 8(r2)	# 612:3-43
	lis	r2, ha16(min_caml_solver_w_vec)	# 613:3-15
	addi	r2, r2, lo16(min_caml_solver_w_vec)	# 613:3-15
	lwz	r5, 8(r3)	# 613:23-28
	lfd	f0, 16(r5)	# 613:23-28
	lwz	r5, 4(r3)	# 613:32-43
	stw	r2, 40(r3)	# 613:32-43
	stfd	f0, 48(r3)	# 613:32-43
	mflr	r31	# 613:32-43
	mr	r2, r5	# 613:32-43
	stw	r31, 60(r3)	# 613:32-43
	addi	r3, r3, 64	# 613:32-43
	bl	o_param_z.2004	# 613:32-43
	subi	r3, r3, 64	# 613:32-43
	lwz	r31, 60(r3)	# 613:32-43
	mtlr	r31	# 613:32-43
	lfd	f1, 48(r3)	# 613:23-43
	fsub	f0, f1, f0	# 613:23-43
	lwz	r2, 40(r3)	# 613:3-43
	stfd	f0, 16(r2)	# 613:3-43
	lwz	r2, 4(r3)	# 614:3-25
	mflr	r31	# 614:3-25
	stw	r31, 60(r3)	# 614:3-25
	addi	r3, r3, 64	# 614:3-25
	bl	o_form.1986	# 614:3-25
	subi	r3, r3, 64	# 614:3-25
	lwz	r31, 60(r3)	# 614:3-25
	mtlr	r31	# 614:3-25
	cmpwi	cr7, r2, 1	# 615:6-17
	bne	cr7, beq_else.5772	# 615:3 - 617:25
#	615:23-38
	lwz	r2, 4(r3)	# 615:23-38
	lwz	r5, 0(r3)	# 615:23-38
	b	solver_rect.2045	# 615:23-38
beq_else.5772:	# 616:8 - 617:25
	cmpwi	cr7, r2, 2	# 616:11-22
	bne	cr7, beq_else.5773	# 616:8 - 617:25
#	616:28-46
	lwz	r2, 4(r3)	# 616:28-46
	lwz	r5, 0(r3)	# 616:28-46
	b	solver_surface.2048	# 616:28-46
beq_else.5773:	# 617:8-25
	lwz	r2, 4(r3)	# 617:8-25
	lwz	r5, 0(r3)	# 617:8-25
	b	solver_second.2063	# 617:8-25
is_rect_outside.2070:	# 624:12 - 633:44
	stw	r2, 0(r3)	# 627:37-48
	mflr	r31	# 627:37-48
	stw	r31, 4(r3)	# 627:37-48
	addi	r3, r3, 8	# 627:37-48
	bl	o_param_a.1994	# 627:37-48
	subi	r3, r3, 8	# 627:37-48
	lwz	r31, 4(r3)	# 627:37-48
	mtlr	r31	# 627:37-48
	lis	r2, ha16(min_caml_isoutside_q)	# 627:19-30
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 627:19-30
	lfd	f1, 0(r2)	# 627:19-34
	stfd	f0, 8(r3)	# 627:9-34
	mflr	r31	# 627:9-34
	fmr	f0, f1	# 627:9-34
	stw	r31, 20(r3)	# 627:9-34
	addi	r3, r3, 24	# 627:9-34
	bl	min_caml_abs_float	# 627:9-34
	subi	r3, r3, 24	# 627:9-34
	lwz	r31, 20(r3)	# 627:9-34
	mtlr	r31	# 627:9-34
	lfd	f1, 8(r3)	# 627:5 - 632:6
	fcmpu	cr7, f1, f0	# 627:9-48
	bgt	cr7, ble_else.5775	# 627:5 - 632:6
#	631:10-15
	li	r2, 0	# 631:10-15
	b	ble_cont.5776
ble_else.5775:	# 628:7 - 630:17
	lwz	r2, 0(r3)	# 628:38-49
	mflr	r31	# 628:38-49
	stw	r31, 20(r3)	# 628:38-49
	addi	r3, r3, 24	# 628:38-49
	bl	o_param_b.1996	# 628:38-49
	subi	r3, r3, 24	# 628:38-49
	lwz	r31, 20(r3)	# 628:38-49
	mtlr	r31	# 628:38-49
	lis	r2, ha16(min_caml_isoutside_q)	# 628:20-31
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 628:20-31
	lfd	f1, 8(r2)	# 628:20-35
	stfd	f0, 16(r3)	# 628:10-35
	mflr	r31	# 628:10-35
	fmr	f0, f1	# 628:10-35
	stw	r31, 28(r3)	# 628:10-35
	addi	r3, r3, 32	# 628:10-35
	bl	min_caml_abs_float	# 628:10-35
	subi	r3, r3, 32	# 628:10-35
	lwz	r31, 28(r3)	# 628:10-35
	mtlr	r31	# 628:10-35
	lfd	f1, 16(r3)	# 628:7 - 630:17
	fcmpu	cr7, f1, f0	# 628:10-49
	bgt	cr7, ble_else.5777	# 628:7 - 630:17
#	630:12-17
	li	r2, 0	# 630:12-17
	b	ble_cont.5778
ble_else.5777:	# 629:9-72
	lwz	r2, 0(r3)	# 629:40-51
	mflr	r31	# 629:40-51
	stw	r31, 28(r3)	# 629:40-51
	addi	r3, r3, 32	# 629:40-51
	bl	o_param_c.1998	# 629:40-51
	subi	r3, r3, 32	# 629:40-51
	lwz	r31, 28(r3)	# 629:40-51
	mtlr	r31	# 629:40-51
	lis	r2, ha16(min_caml_isoutside_q)	# 629:22-33
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 629:22-33
	lfd	f1, 16(r2)	# 629:22-37
	stfd	f0, 24(r3)	# 629:12-37
	mflr	r31	# 629:12-37
	fmr	f0, f1	# 629:12-37
	stw	r31, 36(r3)	# 629:12-37
	addi	r3, r3, 40	# 629:12-37
	bl	min_caml_abs_float	# 629:12-37
	subi	r3, r3, 40	# 629:12-37
	lwz	r31, 36(r3)	# 629:12-37
	mtlr	r31	# 629:12-37
	lfd	f1, 24(r3)	# 629:9-72
	fcmpu	cr7, f1, f0	# 629:12-51
	bgt	cr7, ble_else.5779	# 629:9-72
#	629:67-72
	li	r2, 0	# 629:67-72
	b	ble_cont.5780
ble_else.5779:	# 629:57-61
	li	r2, 1	# 629:57-61
ble_cont.5780:	# 629:9-72
ble_cont.5778:	# 628:7 - 630:17
ble_cont.5776:	# 627:5 - 632:6
	cmpwi	cr7, r2, 0	# 626:3 - 633:44
	bne	cr7, beq_else.5781	# 626:3 - 633:44
#	633:26-44
	lwz	r2, 0(r3)	# 633:30-44
	mflr	r31	# 633:30-44
	stw	r31, 36(r3)	# 633:30-44
	addi	r3, r3, 40	# 633:30-44
	bl	o_isinvert.1990	# 633:30-44
	subi	r3, r3, 40	# 633:30-44
	lwz	r31, 36(r3)	# 633:30-44
	mtlr	r31	# 633:30-44
	cmpwi	cr7, r2, 0	# 633:26-44
	bne	cr7, beq_else.5782	# 633:26-44
#	633:26-44
	li	r2, 1	# 633:26-44
	blr	# 633:26-44
beq_else.5782:	# 633:26-44
	li	r2, 0	# 633:26-44
	blr	# 633:26-44
beq_else.5781:	# 633:8-20
	lwz	r2, 0(r3)	# 633:8-20
	b	o_isinvert.1990	# 633:8-20
is_plane_outside.2072:	# 636:12 - 642:29
	stw	r2, 0(r3)	# 638:12-23
	mflr	r31	# 638:12-23
	stw	r31, 4(r3)	# 638:12-23
	addi	r3, r3, 8	# 638:12-23
	bl	o_param_a.1994	# 638:12-23
	subi	r3, r3, 8	# 638:12-23
	lwz	r31, 4(r3)	# 638:12-23
	mtlr	r31	# 638:12-23
	lis	r2, ha16(min_caml_isoutside_q)	# 638:27-38
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 638:27-38
	lfd	f1, 0(r2)	# 638:27-42
	fmul	f0, f0, f1	# 638:12-42
	lwz	r2, 0(r3)	# 639:17-28
	stfd	f0, 8(r3)	# 639:17-28
	mflr	r31	# 639:17-28
	stw	r31, 20(r3)	# 639:17-28
	addi	r3, r3, 24	# 639:17-28
	bl	o_param_b.1996	# 639:17-28
	subi	r3, r3, 24	# 639:17-28
	lwz	r31, 20(r3)	# 639:17-28
	mtlr	r31	# 639:17-28
	lis	r2, ha16(min_caml_isoutside_q)	# 639:32-43
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 639:32-43
	lfd	f1, 8(r2)	# 639:32-47
	fmul	f0, f0, f1	# 639:17-47
	lfd	f1, 8(r3)	# 638:12 - 639:47
	fadd	f0, f1, f0	# 638:12 - 639:47
	lwz	r2, 0(r3)	# 640:17-28
	stfd	f0, 16(r3)	# 640:17-28
	mflr	r31	# 640:17-28
	stw	r31, 28(r3)	# 640:17-28
	addi	r3, r3, 32	# 640:17-28
	bl	o_param_c.1998	# 640:17-28
	subi	r3, r3, 32	# 640:17-28
	lwz	r31, 28(r3)	# 640:17-28
	mtlr	r31	# 640:17-28
	lis	r2, ha16(min_caml_isoutside_q)	# 640:32-43
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 640:32-43
	lfd	f1, 16(r2)	# 640:32-47
	fmul	f0, f0, f1	# 640:17-47
	lfd	f1, 16(r3)	# 638:3 - 640:48
	fadd	f0, f1, f0	# 638:3 - 640:48
	lis	r31, ha16(l.4464)	# 641:11-14
	addi	r31, r31, lo16(l.4464)	# 641:11-14
	lfd	f1, 0(r31)	# 641:11-14
	fcmpu	cr7, f1, f0	# 641:11-18
	bgt	cr7, ble_else.5784	# 641:3-18
#	641:11-18
	li	r2, 0	# 641:11-18
	b	ble_cont.5785
ble_else.5784:	# 641:11-18
	li	r2, 1	# 641:11-18
ble_cont.5785:	# 641:3-18
	lwz	r5, 0(r3)	# 642:12-26
	stw	r2, 24(r3)	# 642:12-26
	mflr	r31	# 642:12-26
	mr	r2, r5	# 642:12-26
	stw	r31, 28(r3)	# 642:12-26
	addi	r3, r3, 32	# 642:12-26
	bl	o_isinvert.1990	# 642:12-26
	subi	r3, r3, 32	# 642:12-26
	lwz	r31, 28(r3)	# 642:12-26
	mtlr	r31	# 642:12-26
	lwz	r5, 24(r3)	# 642:7-29
	mflr	r31	# 642:7-29
	stw	r31, 28(r3)	# 642:7-29
	addi	r3, r3, 32	# 642:7-29
	bl	xor.1977	# 642:7-29
	subi	r3, r3, 32	# 642:7-29
	lwz	r31, 28(r3)	# 642:7-29
	mtlr	r31	# 642:7-29
	cmpwi	cr7, r2, 0	# 642:3-29
	bne	cr7, beq_else.5786	# 642:3-29
#	642:3-29
	li	r2, 1	# 642:3-29
	blr	# 642:3-29
beq_else.5786:	# 642:3-29
	li	r2, 0	# 642:3-29
	blr	# 642:3-29
is_second_outside.2074:	# 645:12 - 656:29
	lis	r5, ha16(min_caml_isoutside_q)	# 647:29-40
	addi	r5, r5, lo16(min_caml_isoutside_q)	# 647:29-40
	stw	r2, 0(r3)	# 647:11-40
	mflr	r31	# 647:3-40
	stw	r31, 4(r3)	# 647:3-40
	addi	r3, r3, 8	# 647:3-40
	bl	in_prod_sqr_obj.2051	# 647:3-40
	subi	r3, r3, 8	# 647:3-40
	lwz	r31, 4(r3)	# 647:3-40
	mtlr	r31	# 647:3-40
	lwz	r2, 0(r3)	# 648:15-23
	stfd	f0, 8(r3)	# 648:15-23
	mflr	r31	# 648:15-23
	stw	r31, 20(r3)	# 648:15-23
	addi	r3, r3, 24	# 648:15-23
	bl	o_form.1986	# 648:15-23
	subi	r3, r3, 24	# 648:15-23
	lwz	r31, 20(r3)	# 648:15-23
	mtlr	r31	# 648:15-23
	cmpwi	cr7, r2, 3	# 648:15-27
	bne	cr7, beq_else.5788	# 648:3-48
#	648:33-41
	lis	r31, ha16(l.4465)	# 648:38-41
	addi	r31, r31, lo16(l.4465)	# 648:38-41
	lfd	f0, 0(r31)	# 648:38-41
	lfd	f1, 8(r3)	# 648:33-41
	fsub	f0, f1, f0	# 648:33-41
	b	beq_cont.5789
beq_else.5788:	# 648:47-48
	lfd	f0, 8(r3)	# 648:47-48
beq_cont.5789:	# 648:3-48
	lwz	r2, 0(r3)	# 650:8-17
	stfd	f0, 16(r3)	# 650:8-17
	mflr	r31	# 650:8-17
	stw	r31, 28(r3)	# 650:8-17
	addi	r3, r3, 32	# 650:8-17
	bl	o_isrot.1992	# 650:8-17
	subi	r3, r3, 32	# 650:8-17
	lwz	r31, 28(r3)	# 650:8-17
	mtlr	r31	# 650:8-17
	cmpwi	cr7, r2, 0	# 650:8-22
	bne	cr7, beq_else.5790	# 649:3 - 653:9
#	653:7-9
	lfd	f0, 16(r3)	# 653:7-9
	b	beq_cont.5791
beq_else.5790:	# 651:7-44
	lis	r5, ha16(min_caml_isoutside_q)	# 651:33-44
	addi	r5, r5, lo16(min_caml_isoutside_q)	# 651:33-44
	lwz	r2, 0(r3)	# 651:13-44
	mflr	r31	# 651:13-44
	stw	r31, 28(r3)	# 651:13-44
	addi	r3, r3, 32	# 651:13-44
	bl	in_prod_co_objrot.2054	# 651:13-44
	subi	r3, r3, 32	# 651:13-44
	lwz	r31, 28(r3)	# 651:13-44
	mtlr	r31	# 651:13-44
	lfd	f1, 16(r3)	# 651:7-44
	fadd	f0, f1, f0	# 651:7-44
beq_cont.5791:	# 649:3 - 653:9
	lis	r31, ha16(l.4464)	# 655:11-14
	addi	r31, r31, lo16(l.4464)	# 655:11-14
	lfd	f1, 0(r31)	# 655:11-14
	fcmpu	cr7, f1, f0	# 655:11-19
	bgt	cr7, ble_else.5792	# 655:3-19
#	655:11-19
	li	r2, 0	# 655:11-19
	b	ble_cont.5793
ble_else.5792:	# 655:11-19
	li	r2, 1	# 655:11-19
ble_cont.5793:	# 655:3-19
	lwz	r5, 0(r3)	# 656:12-26
	stw	r2, 24(r3)	# 656:12-26
	mflr	r31	# 656:12-26
	mr	r2, r5	# 656:12-26
	stw	r31, 28(r3)	# 656:12-26
	addi	r3, r3, 32	# 656:12-26
	bl	o_isinvert.1990	# 656:12-26
	subi	r3, r3, 32	# 656:12-26
	lwz	r31, 28(r3)	# 656:12-26
	mtlr	r31	# 656:12-26
	lwz	r5, 24(r3)	# 656:7-29
	mflr	r31	# 656:7-29
	stw	r31, 28(r3)	# 656:7-29
	addi	r3, r3, 32	# 656:7-29
	bl	xor.1977	# 656:7-29
	subi	r3, r3, 32	# 656:7-29
	lwz	r31, 28(r3)	# 656:7-29
	mtlr	r31	# 656:7-29
	cmpwi	cr7, r2, 0	# 656:3-29
	bne	cr7, beq_else.5794	# 656:3-29
#	656:3-29
	li	r2, 1	# 656:3-29
	blr	# 656:3-29
beq_else.5794:	# 656:3-29
	li	r2, 0	# 656:3-29
	blr	# 656:3-29
is_outside.2076:	# 659:12 - 670:24
	lis	r5, ha16(min_caml_isoutside_q)	# 661:3-14
	addi	r5, r5, lo16(min_caml_isoutside_q)	# 661:3-14
	lis	r6, ha16(min_caml_chkinside_p)	# 661:22-33
	addi	r6, r6, lo16(min_caml_chkinside_p)	# 661:22-33
	lfd	f0, 0(r6)	# 661:22-37
	stw	r2, 0(r3)	# 661:41-52
	stw	r5, 4(r3)	# 661:41-52
	stfd	f0, 8(r3)	# 661:41-52
	mflr	r31	# 661:41-52
	stw	r31, 20(r3)	# 661:41-52
	addi	r3, r3, 24	# 661:41-52
	bl	o_param_x.2000	# 661:41-52
	subi	r3, r3, 24	# 661:41-52
	lwz	r31, 20(r3)	# 661:41-52
	mtlr	r31	# 661:41-52
	lfd	f1, 8(r3)	# 661:22-52
	fsub	f0, f1, f0	# 661:22-52
	lwz	r2, 4(r3)	# 661:3-52
	stfd	f0, 0(r2)	# 661:3-52
	lis	r2, ha16(min_caml_isoutside_q)	# 662:3-14
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 662:3-14
	lis	r5, ha16(min_caml_chkinside_p)	# 662:22-33
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 662:22-33
	lfd	f0, 8(r5)	# 662:22-37
	lwz	r5, 0(r3)	# 662:41-52
	stw	r2, 16(r3)	# 662:41-52
	stfd	f0, 24(r3)	# 662:41-52
	mflr	r31	# 662:41-52
	mr	r2, r5	# 662:41-52
	stw	r31, 36(r3)	# 662:41-52
	addi	r3, r3, 40	# 662:41-52
	bl	o_param_y.2002	# 662:41-52
	subi	r3, r3, 40	# 662:41-52
	lwz	r31, 36(r3)	# 662:41-52
	mtlr	r31	# 662:41-52
	lfd	f1, 24(r3)	# 662:22-52
	fsub	f0, f1, f0	# 662:22-52
	lwz	r2, 16(r3)	# 662:3-52
	stfd	f0, 8(r2)	# 662:3-52
	lis	r2, ha16(min_caml_isoutside_q)	# 663:3-14
	addi	r2, r2, lo16(min_caml_isoutside_q)	# 663:3-14
	lis	r5, ha16(min_caml_chkinside_p)	# 663:22-33
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 663:22-33
	lfd	f0, 16(r5)	# 663:22-37
	lwz	r5, 0(r3)	# 663:41-52
	stw	r2, 32(r3)	# 663:41-52
	stfd	f0, 40(r3)	# 663:41-52
	mflr	r31	# 663:41-52
	mr	r2, r5	# 663:41-52
	stw	r31, 52(r3)	# 663:41-52
	addi	r3, r3, 56	# 663:41-52
	bl	o_param_z.2004	# 663:41-52
	subi	r3, r3, 56	# 663:41-52
	lwz	r31, 52(r3)	# 663:41-52
	mtlr	r31	# 663:41-52
	lfd	f1, 40(r3)	# 663:22-52
	fsub	f0, f1, f0	# 663:22-52
	lwz	r2, 32(r3)	# 663:3-52
	stfd	f0, 16(r2)	# 663:3-52
	lwz	r2, 0(r3)	# 664:3-25
	mflr	r31	# 664:3-25
	stw	r31, 52(r3)	# 664:3-25
	addi	r3, r3, 56	# 664:3-25
	bl	o_form.1986	# 664:3-25
	subi	r3, r3, 56	# 664:3-25
	lwz	r31, 52(r3)	# 664:3-25
	mtlr	r31	# 664:3-25
	cmpwi	cr7, r2, 1	# 665:6-17
	bne	cr7, beq_else.5797	# 665:3 - 670:24
#	666:5-22
	lwz	r2, 0(r3)	# 666:5-22
	b	is_rect_outside.2070	# 666:5-22
beq_else.5797:	# 667:8 - 670:24
	cmpwi	cr7, r2, 2	# 667:11-22
	bne	cr7, beq_else.5798	# 667:8 - 670:24
#	668:5-23
	lwz	r2, 0(r3)	# 668:5-23
	b	is_plane_outside.2072	# 668:5-23
beq_else.5798:	# 670:5-24
	lwz	r2, 0(r3)	# 670:5-24
	b	is_second_outside.2074	# 670:5-24
check_all_inside.2078:	# 674:12 - 680:4
	slwi	r6, r2, 2	# 676:14-24
	lwzx	r6, r5, r6	# 676:3-24
	cmpwi	cr7, r6, -1	# 677:6-15
	bne	cr7, beq_else.5799	# 677:3 - 680:4
#	677:21-25
	li	r2, 1	# 677:21-25
	blr	# 677:21-25
beq_else.5799:	# 677:31 - 680:4
	lis	r7, ha16(min_caml_objects)	# 678:21-28
	addi	r7, r7, lo16(min_caml_objects)	# 678:21-28
	slwi	r6, r6, 2	# 678:20-36
	lwzx	r6, r7, r6	# 678:20-36
	stw	r5, 0(r3)	# 678:8-37
	stw	r2, 4(r3)	# 678:8-37
	mflr	r31	# 678:8-37
	mr	r2, r6	# 678:8-37
	stw	r31, 12(r3)	# 678:8-37
	addi	r3, r3, 16	# 678:8-37
	bl	is_outside.2076	# 678:8-37
	subi	r3, r3, 16	# 678:8-37
	lwz	r31, 12(r3)	# 678:8-37
	mtlr	r31	# 678:8-37
	cmpwi	cr7, r2, 0	# 677:31 - 680:4
	bne	cr7, beq_else.5800	# 677:31 - 680:4
#	679:10-41
	lwz	r2, 4(r3)	# 679:27-36
	addi	r2, r2, 1	# 679:27-36
	lwz	r5, 0(r3)	# 679:10-41
	b	check_all_inside.2078	# 679:10-41
beq_else.5800:	# 678:43-48
	li	r2, 0	# 678:43-48
	blr	# 678:43-48
shadow_check_and_group.2081:	# 689:12 - 720:17
	slwi	r7, r2, 2	# 691:6-26
	lwzx	r7, r5, r7	# 691:6-26
	cmpwi	cr7, r7, -1	# 691:6-31
	bne	cr7, beq_else.5801	# 691:3 - 720:17
#	692:5-10
	li	r2, 0	# 692:5-10
	blr	# 692:5-10
beq_else.5801:	# 694:5 - 720:17
	slwi	r7, r2, 2	# 694:15-35
	lwzx	r7, r5, r7	# 694:5-35
	lis	r8, ha16(min_caml_light)	# 700:25-30
	addi	r8, r8, lo16(min_caml_light)	# 700:25-30
	stw	r6, 0(r3)	# 700:14-32
	stw	r5, 4(r3)	# 700:14-32
	stw	r2, 8(r3)	# 700:14-32
	stw	r7, 12(r3)	# 700:14-32
	mflr	r31	# 700:5-32
	mr	r5, r8	# 700:5-32
	mr	r2, r7	# 700:5-32
	stw	r31, 20(r3)	# 700:5-32
	addi	r3, r3, 24	# 700:5-32
	bl	solver.2066	# 700:5-32
	subi	r3, r3, 24	# 700:5-32
	lwz	r31, 20(r3)	# 700:5-32
	mtlr	r31	# 700:5-32
	lis	r5, ha16(min_caml_solver_dist)	# 701:15-26
	addi	r5, r5, lo16(min_caml_solver_dist)	# 701:15-26
	lfd	f0, 0(r5)	# 701:5-30
	cmpwi	cr7, r2, 0	# 702:12-19
	bne	cr7, beq_else.5802	# 702:8-47
#	702:41-46
	li	r2, 0	# 702:41-46
	b	beq_cont.5803
beq_else.5802:	# 702:25-35
	lis	r31, ha16(l.4708)	# 702:31-35
	addi	r31, r31, lo16(l.4708)	# 702:31-35
	lfd	f1, 0(r31)	# 702:31-35
	fcmpu	cr7, f1, f0	# 702:25-35
	bgt	cr7, ble_else.5804	# 702:25-35
#	702:25-35
	li	r2, 0	# 702:25-35
	b	ble_cont.5805
ble_else.5804:	# 702:25-35
	li	r2, 1	# 702:25-35
ble_cont.5805:	# 702:25-35
beq_cont.5803:	# 702:8-47
	cmpwi	cr7, r2, 0	# 702:5 - 720:17
	bne	cr7, beq_else.5806	# 702:5 - 720:17
#	718:7 - 720:17
	lis	r2, ha16(min_caml_objects)	# 718:22-29
	addi	r2, r2, lo16(min_caml_objects)	# 718:22-29
	lwz	r5, 12(r3)	# 718:21-36
	slwi	r5, r5, 2	# 718:21-36
	lwzx	r2, r2, r5	# 718:21-36
	mflr	r31	# 718:10-36
	stw	r31, 20(r3)	# 718:10-36
	addi	r3, r3, 24	# 718:10-36
	bl	o_isinvert.1990	# 718:10-36
	subi	r3, r3, 24	# 718:10-36
	lwz	r31, 20(r3)	# 718:10-36
	mtlr	r31	# 718:10-36
	cmpwi	cr7, r2, 0	# 718:7 - 720:17
	bne	cr7, beq_else.5807	# 718:7 - 720:17
#	720:12-17
	li	r2, 0	# 720:12-17
	blr	# 720:12-17
beq_else.5807:	# 719:12-61
	lwz	r2, 8(r3)	# 719:35-49
	addi	r2, r2, 1	# 719:35-49
	lwz	r5, 4(r3)	# 719:12-61
	lwz	r6, 0(r3)	# 719:12-61
	b	shadow_check_and_group.2081	# 719:12-61
beq_else.5806:	# 706:7 - 712:61
	lis	r31, ha16(l.4709)	# 706:22-26
	addi	r31, r31, lo16(l.4709)	# 706:22-26
	lfd	f1, 0(r31)	# 706:22-26
	fadd	f0, f0, f1	# 706:7-26
	lis	r2, ha16(min_caml_chkinside_p)	# 707:7-18
	addi	r2, r2, lo16(min_caml_chkinside_p)	# 707:7-18
	lis	r5, ha16(min_caml_light)	# 707:26-31
	addi	r5, r5, lo16(min_caml_light)	# 707:26-31
	lfd	f1, 0(r5)	# 707:26-35
	fmul	f1, f1, f0	# 707:26-40
	lwz	r5, 0(r3)	# 707:44-49
	lfd	f2, 0(r5)	# 707:44-49
	fadd	f1, f1, f2	# 707:26-49
	stfd	f1, 0(r2)	# 707:7-49
	lis	r2, ha16(min_caml_chkinside_p)	# 708:7-18
	addi	r2, r2, lo16(min_caml_chkinside_p)	# 708:7-18
	lis	r6, ha16(min_caml_light)	# 708:26-31
	addi	r6, r6, lo16(min_caml_light)	# 708:26-31
	lfd	f1, 8(r6)	# 708:26-35
	fmul	f1, f1, f0	# 708:26-40
	lfd	f2, 8(r5)	# 708:44-49
	fadd	f1, f1, f2	# 708:26-49
	stfd	f1, 8(r2)	# 708:7-49
	lis	r2, ha16(min_caml_chkinside_p)	# 709:7-18
	addi	r2, r2, lo16(min_caml_chkinside_p)	# 709:7-18
	lis	r6, ha16(min_caml_light)	# 709:26-31
	addi	r6, r6, lo16(min_caml_light)	# 709:26-31
	lfd	f1, 16(r6)	# 709:26-35
	fmul	f0, f1, f0	# 709:26-40
	lfd	f1, 16(r5)	# 709:44-49
	fadd	f0, f0, f1	# 709:26-49
	stfd	f0, 16(r2)	# 709:7-49
	li	r2, 0	# 710:28-29
	lwz	r6, 4(r3)	# 710:10-40
	mflr	r31	# 710:10-40
	mr	r5, r6	# 710:10-40
	stw	r31, 20(r3)	# 710:10-40
	addi	r3, r3, 24	# 710:10-40
	bl	check_all_inside.2078	# 710:10-40
	subi	r3, r3, 24	# 710:10-40
	lwz	r31, 20(r3)	# 710:10-40
	mtlr	r31	# 710:10-40
	cmpwi	cr7, r2, 0	# 710:7 - 712:61
	bne	cr7, beq_else.5808	# 710:7 - 712:61
#	712:12-61
	lwz	r2, 8(r3)	# 712:35-49
	addi	r2, r2, 1	# 712:35-49
	lwz	r5, 4(r3)	# 712:12-61
	lwz	r6, 0(r3)	# 712:12-61
	b	shadow_check_and_group.2081	# 712:12-61
beq_else.5808:	# 711:12-16
	li	r2, 1	# 711:12-16
	blr	# 711:12-16
shadow_check_one_or_group.2085:	# 724:12 - 734:4
	slwi	r7, r2, 2	# 726:14-28
	lwzx	r7, r5, r7	# 726:3-28
	cmpwi	cr7, r7, -1	# 727:6-15
	bne	cr7, beq_else.5809	# 727:3 - 734:4
#	728:5-10
	li	r2, 0	# 728:5-10
	blr	# 728:5-10
beq_else.5809:	# 729:8 - 734:4
	lis	r8, ha16(min_caml_and_net)	# 730:21-28
	addi	r8, r8, lo16(min_caml_and_net)	# 730:21-28
	slwi	r7, r7, 2	# 730:21-35
	lwzx	r7, r8, r7	# 730:5-35
	li	r8, 0	# 731:43-44
	stw	r6, 0(r3)	# 731:20-56
	stw	r5, 4(r3)	# 731:20-56
	stw	r2, 8(r3)	# 731:20-56
	mflr	r31	# 731:5-56
	mr	r5, r7	# 731:5-56
	mr	r2, r8	# 731:5-56
	stw	r31, 12(r3)	# 731:5-56
	addi	r3, r3, 16	# 731:5-56
	bl	shadow_check_and_group.2081	# 731:5-56
	subi	r3, r3, 16	# 731:5-56
	lwz	r31, 12(r3)	# 731:5-56
	mtlr	r31	# 731:5-56
	cmpwi	cr7, r2, 0	# 732:5 - 733:56
	bne	cr7, beq_else.5810	# 732:5 - 733:56
#	733:10-56
	lwz	r2, 8(r3)	# 733:36-45
	addi	r2, r2, 1	# 733:36-45
	lwz	r5, 4(r3)	# 733:10-56
	lwz	r6, 0(r3)	# 733:10-56
	b	shadow_check_one_or_group.2085	# 733:10-56
beq_else.5810:	# 732:22-26
	li	r2, 1	# 732:22-26
	blr	# 732:22-26
shadow_check_one_or_matrix.2089:	# 738:12 - 763:4
	slwi	r7, r2, 2	# 740:14-29
	lwzx	r7, r5, r7	# 740:3-29
	lwz	r8, 0(r7)	# 741:3-33
	cmpwi	cr7, r8, -1	# 742:6-26
	bne	cr7, beq_else.5811	# 742:3 - 763:4
#	742:32-37
	li	r2, 0	# 742:32-37
	blr	# 742:32-37
beq_else.5811:	# 743:8 - 763:4
	cmpwi	cr7, r8, 99	# 744:8-28
	bne	cr7, beq_else.5812	# 743:8 - 763:4
#	747:37-38
	li	r8, 1	# 747:37-38
	stw	r6, 0(r3)	# 747:10-46
	stw	r5, 4(r3)	# 747:10-46
	stw	r2, 8(r3)	# 747:10-46
	mflr	r31	# 747:10-46
	mr	r5, r7	# 747:10-46
	mr	r2, r8	# 747:10-46
	stw	r31, 12(r3)	# 747:10-46
	addi	r3, r3, 16	# 747:10-46
	bl	shadow_check_one_or_group.2085	# 747:10-46
	subi	r3, r3, 16	# 747:10-46
	lwz	r31, 12(r3)	# 747:10-46
	mtlr	r31	# 747:10-46
	cmpwi	cr7, r2, 0	# 747:7 - 749:60
	bne	cr7, beq_else.5813	# 747:7 - 749:60
#	749:12-60
	lwz	r2, 8(r3)	# 749:39-48
	addi	r2, r2, 1	# 749:39-48
	lwz	r5, 4(r3)	# 749:12-60
	lwz	r6, 0(r3)	# 749:12-60
	b	shadow_check_one_or_matrix.2089	# 749:12-60
beq_else.5813:	# 748:12-16
	li	r2, 1	# 748:12-16
	blr	# 748:12-16
beq_else.5812:	# 752:7 - 762:60
	lis	r9, ha16(min_caml_light)	# 752:38-43
	addi	r9, r9, lo16(min_caml_light)	# 752:38-43
	stw	r7, 12(r3)	# 752:15-45
	stw	r6, 0(r3)	# 752:15-45
	stw	r5, 4(r3)	# 752:15-45
	stw	r2, 8(r3)	# 752:15-45
	mflr	r31	# 752:7-45
	mr	r5, r9	# 752:7-45
	mr	r2, r8	# 752:7-45
	stw	r31, 20(r3)	# 752:7-45
	addi	r3, r3, 24	# 752:7-45
	bl	solver.2066	# 752:7-45
	subi	r3, r3, 24	# 752:7-45
	lwz	r31, 20(r3)	# 752:7-45
	mtlr	r31	# 752:7-45
	cmpwi	cr7, r2, 0	# 755:10-16
	bne	cr7, beq_else.5814	# 755:7 - 762:60
#	762:12-60
	lwz	r2, 8(r3)	# 762:39-48
	addi	r2, r2, 1	# 762:39-48
	lwz	r5, 4(r3)	# 762:12-60
	lwz	r6, 0(r3)	# 762:12-60
	b	shadow_check_one_or_matrix.2089	# 762:12-60
beq_else.5814:	# 756:9 - 761:62
	lis	r31, ha16(l.4724)	# 756:30-34
	addi	r31, r31, lo16(l.4724)	# 756:30-34
	lfd	f0, 0(r31)	# 756:30-34
	lis	r2, ha16(min_caml_solver_dist)	# 756:12-23
	addi	r2, r2, lo16(min_caml_solver_dist)	# 756:12-23
	lfd	f1, 0(r2)	# 756:12-27
	fcmpu	cr7, f0, f1	# 756:12-34
	bgt	cr7, ble_else.5815	# 756:9 - 761:62
#	761:14-62
	lwz	r2, 8(r3)	# 761:41-50
	addi	r2, r2, 1	# 761:41-50
	lwz	r5, 4(r3)	# 761:14-62
	lwz	r6, 0(r3)	# 761:14-62
	b	shadow_check_one_or_matrix.2089	# 761:14-62
ble_else.5815:	# 758:40-41
	li	r2, 1	# 758:40-41
	lwz	r5, 12(r3)	# 758:14-48
	lwz	r6, 0(r3)	# 758:14-48
	mflr	r31	# 758:14-48
	stw	r31, 20(r3)	# 758:14-48
	addi	r3, r3, 24	# 758:14-48
	bl	shadow_check_one_or_group.2085	# 758:14-48
	subi	r3, r3, 24	# 758:14-48
	lwz	r31, 20(r3)	# 758:14-48
	mtlr	r31	# 758:14-48
	cmpwi	cr7, r2, 0	# 758:11 - 760:64
	bne	cr7, beq_else.5816	# 758:11 - 760:64
#	760:16-64
	lwz	r2, 8(r3)	# 760:43-52
	addi	r2, r2, 1	# 760:43-52
	lwz	r5, 4(r3)	# 760:16-64
	lwz	r6, 0(r3)	# 760:16-64
	b	shadow_check_one_or_matrix.2089	# 760:16-64
beq_else.5816:	# 759:16-20
	li	r2, 1	# 759:16-20
	blr	# 759:16-20
solve_each_element.2093:	# 770:12 - 810:4
	slwi	r6, r2, 2	# 772:14-34
	lwzx	r6, r5, r6	# 772:3-34
	cmpwi	cr7, r6, -1	# 773:6-15
	bne	cr7, beq_else.5817	# 773:3 - 810:4
#	773:21-23
	blr	# 773:21-23
beq_else.5817:	# 774:8 - 810:4
	lis	r7, ha16(min_caml_vscan)	# 775:26-31
	addi	r7, r7, lo16(min_caml_vscan)	# 775:26-31
	lis	r8, ha16(min_caml_viewpoint)	# 775:32-41
	addi	r8, r8, lo16(min_caml_viewpoint)	# 775:32-41
	stw	r2, 0(r3)	# 775:14-41
	stw	r5, 4(r3)	# 775:14-41
	stw	r6, 8(r3)	# 775:14-41
	mflr	r31	# 775:5-41
	mr	r5, r7	# 775:5-41
	mr	r2, r6	# 775:5-41
	mr	r6, r8	# 775:5-41
	stw	r31, 12(r3)	# 775:5-41
	addi	r3, r3, 16	# 775:5-41
	bl	solver.2066	# 775:5-41
	subi	r3, r3, 16	# 775:5-41
	lwz	r31, 12(r3)	# 775:5-41
	mtlr	r31	# 775:5-41
	cmpwi	cr7, r2, 0	# 776:8-15
	bne	cr7, beq_else.5819	# 776:5 - 806:8
#	803:7 - 806:8
	lis	r2, ha16(min_caml_objects)	# 805:23-30
	addi	r2, r2, lo16(min_caml_objects)	# 805:23-30
	lwz	r5, 8(r3)	# 805:22-38
	slwi	r5, r5, 2	# 805:22-38
	lwzx	r2, r2, r5	# 805:22-38
	mflr	r31	# 805:11-38
	stw	r31, 12(r3)	# 805:11-38
	addi	r3, r3, 16	# 805:11-38
	bl	o_isinvert.1990	# 805:11-38
	subi	r3, r3, 16	# 805:11-38
	lwz	r31, 12(r3)	# 805:11-38
	mtlr	r31	# 805:11-38
	cmpwi	cr7, r2, 0	# 803:7 - 806:8
	bne	cr7, beq_else.5821	# 803:7 - 806:8
#	805:52-74
	lis	r2, ha16(min_caml_end_flag)	# 805:52-60
	addi	r2, r2, lo16(min_caml_end_flag)	# 805:52-60
	li	r5, 1	# 805:68-74
	stw	r5, 0(r2)	# 805:52-74
	b	beq_cont.5822
beq_else.5821:	# 805:44-46
beq_cont.5822:	# 803:7 - 806:8
	b	beq_cont.5820
beq_else.5819:	# 777:7 - 801:8
	lis	r5, ha16(min_caml_solver_dist)	# 780:18-29
	addi	r5, r5, lo16(min_caml_solver_dist)	# 780:18-29
	lfd	f0, 0(r5)	# 780:8-33
	lis	r31, ha16(l.4724)	# 781:11-15
	addi	r31, r31, lo16(l.4724)	# 781:11-15
	lfd	f1, 0(r31)	# 781:11-15
	fcmpu	cr7, f0, f1	# 781:11-21
	bgt	cr7, ble_else.5823	# 781:8 - 800:15
#	800:13-15
	b	ble_cont.5824
ble_else.5823:	# 782:10 - 799:17
	lis	r5, ha16(min_caml_tmin)	# 782:19-23
	addi	r5, r5, lo16(min_caml_tmin)	# 782:19-23
	lfd	f1, 0(r5)	# 782:19-27
	fcmpu	cr7, f1, f0	# 782:13-27
	bgt	cr7, ble_else.5825	# 782:10 - 799:17
#	799:15-17
	b	ble_cont.5826
ble_else.5825:	# 783:12 - 798:13
	lis	r31, ha16(l.4709)	# 784:28-32
	addi	r31, r31, lo16(l.4709)	# 784:28-32
	lfd	f1, 0(r31)	# 784:28-32
	fadd	f0, f0, f1	# 784:13-32
	lis	r5, ha16(min_caml_chkinside_p)	# 785:13-24
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 785:13-24
	lis	r6, ha16(min_caml_vscan)	# 785:32-37
	addi	r6, r6, lo16(min_caml_vscan)	# 785:32-37
	lfd	f1, 0(r6)	# 785:32-41
	fmul	f1, f1, f0	# 785:32-46
	lis	r6, ha16(min_caml_viewpoint)	# 785:50-59
	addi	r6, r6, lo16(min_caml_viewpoint)	# 785:50-59
	lfd	f2, 0(r6)	# 785:50-63
	fadd	f1, f1, f2	# 785:32-63
	stfd	f1, 0(r5)	# 785:13-63
	lis	r5, ha16(min_caml_chkinside_p)	# 786:13-24
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 786:13-24
	lis	r6, ha16(min_caml_vscan)	# 786:32-37
	addi	r6, r6, lo16(min_caml_vscan)	# 786:32-37
	lfd	f1, 8(r6)	# 786:32-41
	fmul	f1, f1, f0	# 786:32-46
	lis	r6, ha16(min_caml_viewpoint)	# 786:50-59
	addi	r6, r6, lo16(min_caml_viewpoint)	# 786:50-59
	lfd	f2, 8(r6)	# 786:50-63
	fadd	f1, f1, f2	# 786:32-63
	stfd	f1, 8(r5)	# 786:13-63
	lis	r5, ha16(min_caml_chkinside_p)	# 787:13-24
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 787:13-24
	lis	r6, ha16(min_caml_vscan)	# 787:32-37
	addi	r6, r6, lo16(min_caml_vscan)	# 787:32-37
	lfd	f1, 16(r6)	# 787:32-41
	fmul	f1, f1, f0	# 787:32-46
	lis	r6, ha16(min_caml_viewpoint)	# 787:50-59
	addi	r6, r6, lo16(min_caml_viewpoint)	# 787:50-59
	lfd	f2, 16(r6)	# 787:50-63
	fadd	f1, f1, f2	# 787:32-63
	stfd	f1, 16(r5)	# 787:13-63
	li	r5, 0	# 788:33-34
	lwz	r6, 4(r3)	# 788:16-44
	stw	r2, 12(r3)	# 788:16-44
	stfd	f0, 16(r3)	# 788:16-44
	mflr	r31	# 788:16-44
	mr	r2, r5	# 788:16-44
	mr	r5, r6	# 788:16-44
	stw	r31, 28(r3)	# 788:16-44
	addi	r3, r3, 32	# 788:16-44
	bl	check_all_inside.2078	# 788:16-44
	subi	r3, r3, 32	# 788:16-44
	lwz	r31, 28(r3)	# 788:16-44
	mtlr	r31	# 788:16-44
	cmpwi	cr7, r2, 0	# 788:13 - 797:20
	bne	cr7, beq_else.5827	# 788:13 - 797:20
#	797:18-20
	b	beq_cont.5828
beq_else.5827:	# 789:15 - 796:17
	lis	r2, ha16(min_caml_tmin)	# 790:17-21
	addi	r2, r2, lo16(min_caml_tmin)	# 790:17-21
	lfd	f0, 16(r3)	# 790:17-30
	stfd	f0, 0(r2)	# 790:17-30
	lis	r2, ha16(min_caml_crashed_point)	# 791:17-30
	addi	r2, r2, lo16(min_caml_crashed_point)	# 791:17-30
	lis	r5, ha16(min_caml_chkinside_p)	# 791:38-49
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 791:38-49
	lfd	f0, 0(r5)	# 791:38-53
	stfd	f0, 0(r2)	# 791:17-53
	lis	r2, ha16(min_caml_crashed_point)	# 792:17-30
	addi	r2, r2, lo16(min_caml_crashed_point)	# 792:17-30
	lis	r5, ha16(min_caml_chkinside_p)	# 792:38-49
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 792:38-49
	lfd	f0, 8(r5)	# 792:38-53
	stfd	f0, 8(r2)	# 792:17-53
	lis	r2, ha16(min_caml_crashed_point)	# 793:17-30
	addi	r2, r2, lo16(min_caml_crashed_point)	# 793:17-30
	lis	r5, ha16(min_caml_chkinside_p)	# 793:38-49
	addi	r5, r5, lo16(min_caml_chkinside_p)	# 793:38-49
	lfd	f0, 16(r5)	# 793:38-53
	stfd	f0, 16(r2)	# 793:17-53
	lis	r2, ha16(min_caml_intsec_rectside)	# 794:17-32
	addi	r2, r2, lo16(min_caml_intsec_rectside)	# 794:17-32
	lwz	r5, 12(r3)	# 794:17-42
	stw	r5, 0(r2)	# 794:17-42
	lis	r2, ha16(min_caml_crashed_object)	# 795:17-31
	addi	r2, r2, lo16(min_caml_crashed_object)	# 795:17-31
	lwz	r5, 8(r3)	# 795:17-43
	stw	r5, 0(r2)	# 795:17-43
beq_cont.5828:	# 788:13 - 797:20
ble_cont.5826:	# 782:10 - 799:17
ble_cont.5824:	# 781:8 - 800:15
beq_cont.5820:	# 776:5 - 806:8
	lis	r2, ha16(min_caml_end_flag)	# 807:14-22
	addi	r2, r2, lo16(min_caml_end_flag)	# 807:14-22
	lwz	r2, 0(r2)	# 807:13-27
	cmpwi	cr7, r2, 0	# 807:5 - 809:12
	bne	cr7, beq_else.5829	# 807:5 - 809:12
#	808:7-50
	lwz	r2, 0(r3)	# 808:26-40
	addi	r2, r2, 1	# 808:26-40
	lwz	r5, 4(r3)	# 808:7-50
	b	solve_each_element.2093	# 808:7-50
beq_else.5829:	# 809:10-12
	blr	# 809:10-12
solve_one_or_network.2096:	# 814:12 - 822:4
	slwi	r6, r2, 2	# 816:14-28
	lwzx	r6, r5, r6	# 816:3-28
	cmpwi	cr7, r6, -1	# 817:6-15
	bne	cr7, beq_else.5831	# 817:3 - 822:4
#	817:21-23
	blr	# 817:21-23
beq_else.5831:	# 817:29 - 822:4
	lis	r7, ha16(min_caml_and_net)	# 818:21-28
	addi	r7, r7, lo16(min_caml_and_net)	# 818:21-28
	slwi	r6, r6, 2	# 818:21-35
	lwzx	r6, r7, r6	# 818:5-35
	lis	r7, ha16(min_caml_end_flag)	# 819:5-13
	addi	r7, r7, lo16(min_caml_end_flag)	# 819:5-13
	li	r8, 0	# 819:21-26
	stw	r8, 0(r7)	# 819:5-26
	li	r7, 0	# 820:24-25
	stw	r5, 0(r3)	# 820:5-35
	stw	r2, 4(r3)	# 820:5-35
	mflr	r31	# 820:5-35
	mr	r5, r6	# 820:5-35
	mr	r2, r7	# 820:5-35
	stw	r31, 12(r3)	# 820:5-35
	addi	r3, r3, 16	# 820:5-35
	bl	solve_each_element.2093	# 820:5-35
	subi	r3, r3, 16	# 820:5-35
	lwz	r31, 12(r3)	# 820:5-35
	mtlr	r31	# 820:5-35
	lwz	r2, 4(r3)	# 821:26-35
	addi	r2, r2, 1	# 821:26-35
	lwz	r5, 0(r3)	# 821:5-44
	b	solve_one_or_network.2096	# 821:5-44
trace_or_matrix.2099:	# 826:12 - 847:4
	slwi	r6, r2, 2	# 828:14-30
	lwzx	r6, r5, r6	# 828:3-30
	lwz	r7, 0(r6)	# 829:3-33
	cmpwi	cr7, r7, -1	# 830:6-26
	bne	cr7, beq_else.5833	# 830:3 - 847:4
#	831:5-7
	blr	# 831:5-7
beq_else.5833:	# 832:8 - 847:4
	stw	r5, 0(r3)	# 833:8-28
	stw	r2, 4(r3)	# 833:8-28
	cmpwi	cr7, r7, 99	# 833:8-28
	bne	cr7, beq_else.5835	# 833:5 - 845:8
#	834:32-33
	li	r7, 1	# 834:32-33
	mflr	r31	# 834:10-39
	mr	r5, r6	# 834:10-39
	mr	r2, r7	# 834:10-39
	stw	r31, 12(r3)	# 834:10-39
	addi	r3, r3, 16	# 834:10-39
	bl	solve_one_or_network.2096	# 834:10-39
	subi	r3, r3, 16	# 834:10-39
	lwz	r31, 12(r3)	# 834:10-39
	mtlr	r31	# 834:10-39
	b	beq_cont.5836
beq_else.5835:	# 836:7 - 845:8
	lis	r8, ha16(min_caml_vscan)	# 838:40-45
	addi	r8, r8, lo16(min_caml_vscan)	# 838:40-45
	lis	r9, ha16(min_caml_viewpoint)	# 838:46-55
	addi	r9, r9, lo16(min_caml_viewpoint)	# 838:46-55
	stw	r6, 8(r3)	# 838:17-55
	mflr	r31	# 838:9-55
	mr	r6, r9	# 838:9-55
	mr	r5, r8	# 838:9-55
	mr	r2, r7	# 838:9-55
	stw	r31, 12(r3)	# 838:9-55
	addi	r3, r3, 16	# 838:9-55
	bl	solver.2066	# 838:9-55
	subi	r3, r3, 16	# 838:9-55
	lwz	r31, 12(r3)	# 838:9-55
	mtlr	r31	# 838:9-55
	cmpwi	cr7, r2, 0	# 839:12-18
	bne	cr7, beq_else.5837	# 839:9 - 844:16
#	844:14-16
	b	beq_cont.5838
beq_else.5837:	# 840:11 - 843:18
	lis	r2, ha16(min_caml_solver_dist)	# 840:20-31
	addi	r2, r2, lo16(min_caml_solver_dist)	# 840:20-31
	lfd	f0, 0(r2)	# 840:11-35
	lis	r2, ha16(min_caml_tmin)	# 841:19-23
	addi	r2, r2, lo16(min_caml_tmin)	# 841:19-23
	lfd	f1, 0(r2)	# 841:19-27
	fcmpu	cr7, f1, f0	# 841:14-27
	bgt	cr7, ble_else.5839	# 841:11 - 843:18
#	843:16-18
	b	ble_cont.5840
ble_else.5839:	# 842:38-39
	li	r2, 1	# 842:38-39
	lwz	r5, 8(r3)	# 842:16-45
	mflr	r31	# 842:16-45
	stw	r31, 12(r3)	# 842:16-45
	addi	r3, r3, 16	# 842:16-45
	bl	solve_one_or_network.2096	# 842:16-45
	subi	r3, r3, 16	# 842:16-45
	lwz	r31, 12(r3)	# 842:16-45
	mtlr	r31	# 842:16-45
ble_cont.5840:	# 841:11 - 843:18
beq_cont.5838:	# 839:9 - 844:16
beq_cont.5836:	# 833:5 - 845:8
	lwz	r2, 4(r3)	# 846:21-30
	addi	r2, r2, 1	# 846:21-30
	lwz	r5, 0(r3)	# 846:5-41
	b	trace_or_matrix.2099	# 846:5-41
tracer.2102:	# 854:12 - 865:2
	lis	r2, ha16(min_caml_tmin)	# 857:3-7
	addi	r2, r2, lo16(min_caml_tmin)	# 857:3-7
	lis	r31, ha16(l.4757)	# 857:15-29
	addi	r31, r31, lo16(l.4757)	# 857:15-29
	lfd	f0, 0(r31)	# 857:15-29
	stfd	f0, 0(r2)	# 857:3-29
	li	r2, 0	# 858:19-20
	lis	r5, ha16(min_caml_or_net)	# 858:22-28
	addi	r5, r5, lo16(min_caml_or_net)	# 858:22-28
	lwz	r5, 0(r5)	# 858:21-33
	mflr	r31	# 858:3-33
	stw	r31, 4(r3)	# 858:3-33
	addi	r3, r3, 8	# 858:3-33
	bl	trace_or_matrix.2099	# 858:3-33
	subi	r3, r3, 8	# 858:3-33
	lwz	r31, 4(r3)	# 858:3-33
	mtlr	r31	# 858:3-33
	lis	r2, ha16(min_caml_tmin)	# 859:11-15
	addi	r2, r2, lo16(min_caml_tmin)	# 859:11-15
	lfd	f0, 0(r2)	# 859:3-19
	lis	r31, ha16(l.4724)	# 860:6-10
	addi	r31, r31, lo16(l.4724)	# 860:6-10
	lfd	f1, 0(r31)	# 860:6-10
	fcmpu	cr7, f0, f1	# 860:6-14
	bgt	cr7, ble_else.5841	# 860:3 - 864:13
#	864:8-13
	li	r2, 0	# 864:8-13
	blr	# 864:8-13
ble_else.5841:	# 861:5 - 863:15
	lis	r31, ha16(l.4761)	# 861:12-23
	addi	r31, r31, lo16(l.4761)	# 861:12-23
	lfd	f1, 0(r31)	# 861:12-23
	fcmpu	cr7, f1, f0	# 861:8-23
	bgt	cr7, ble_else.5842	# 861:5 - 863:15
#	863:10-15
	li	r2, 0	# 863:10-15
	blr	# 863:10-15
ble_else.5842:	# 862:7-11
	li	r2, 1	# 862:7-11
	blr	# 862:7-11
get_nvector_rect.2105:	# 876:12 - 898:10
	lis	r2, ha16(min_caml_intsec_rectside)	# 878:18-33
	addi	r2, r2, lo16(min_caml_intsec_rectside)	# 878:18-33
	lwz	r2, 0(r2)	# 878:3-37
	cmpwi	cr7, r2, 1	# 880:6-18
	bne	cr7, beq_else.5843	# 880:3 - 898:10
#	881:5 - 885:7
	lis	r2, ha16(min_caml_nvector)	# 882:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 882:7-14
	lis	r5, ha16(min_caml_vscan)	# 882:30-35
	addi	r5, r5, lo16(min_caml_vscan)	# 882:30-35
	lfd	f0, 0(r5)	# 882:29-40
	stw	r2, 0(r3)	# 882:24-41
	mflr	r31	# 882:24-41
	stw	r31, 4(r3)	# 882:24-41
	addi	r3, r3, 8	# 882:24-41
	bl	sgn.2025	# 882:24-41
	subi	r3, r3, 8	# 882:24-41
	lwz	r31, 4(r3)	# 882:24-41
	mtlr	r31	# 882:24-41
	fneg	f0, f0	# 882:22-41
	lwz	r2, 0(r3)	# 882:7-41
	stfd	f0, 0(r2)	# 882:7-41
	lis	r2, ha16(min_caml_nvector)	# 883:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 883:7-14
	lis	r31, ha16(l.4464)	# 883:22-25
	addi	r31, r31, lo16(l.4464)	# 883:22-25
	lfd	f0, 0(r31)	# 883:22-25
	stfd	f0, 8(r2)	# 883:7-25
	lis	r2, ha16(min_caml_nvector)	# 884:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 884:7-14
	lis	r31, ha16(l.4464)	# 884:22-25
	addi	r31, r31, lo16(l.4464)	# 884:22-25
	lfd	f0, 0(r31)	# 884:22-25
	stfd	f0, 16(r2)	# 884:7-25
	blr	# 884:7-25
beq_else.5843:	# 886:8 - 898:10
	cmpwi	cr7, r2, 2	# 886:11-23
	bne	cr7, beq_else.5845	# 886:8 - 898:10
#	887:5 - 891:7
	lis	r2, ha16(min_caml_nvector)	# 888:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 888:7-14
	lis	r31, ha16(l.4464)	# 888:22-25
	addi	r31, r31, lo16(l.4464)	# 888:22-25
	lfd	f0, 0(r31)	# 888:22-25
	stfd	f0, 0(r2)	# 888:7-25
	lis	r2, ha16(min_caml_nvector)	# 889:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 889:7-14
	lis	r5, ha16(min_caml_vscan)	# 889:30-35
	addi	r5, r5, lo16(min_caml_vscan)	# 889:30-35
	lfd	f0, 8(r5)	# 889:29-40
	stw	r2, 4(r3)	# 889:24-41
	mflr	r31	# 889:24-41
	stw	r31, 12(r3)	# 889:24-41
	addi	r3, r3, 16	# 889:24-41
	bl	sgn.2025	# 889:24-41
	subi	r3, r3, 16	# 889:24-41
	lwz	r31, 12(r3)	# 889:24-41
	mtlr	r31	# 889:24-41
	fneg	f0, f0	# 889:22-41
	lwz	r2, 4(r3)	# 889:7-41
	stfd	f0, 8(r2)	# 889:7-41
	lis	r2, ha16(min_caml_nvector)	# 890:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 890:7-14
	lis	r31, ha16(l.4464)	# 890:22-25
	addi	r31, r31, lo16(l.4464)	# 890:22-25
	lfd	f0, 0(r31)	# 890:22-25
	stfd	f0, 16(r2)	# 890:7-25
	blr	# 890:7-25
beq_else.5845:	# 892:8 - 898:10
	cmpwi	cr7, r2, 3	# 892:11-23
	bne	cr7, beq_else.5847	# 892:8 - 898:10
#	893:5 - 897:7
	lis	r2, ha16(min_caml_nvector)	# 894:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 894:7-14
	lis	r31, ha16(l.4464)	# 894:22-25
	addi	r31, r31, lo16(l.4464)	# 894:22-25
	lfd	f0, 0(r31)	# 894:22-25
	stfd	f0, 0(r2)	# 894:7-25
	lis	r2, ha16(min_caml_nvector)	# 895:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 895:7-14
	lis	r31, ha16(l.4464)	# 895:22-25
	addi	r31, r31, lo16(l.4464)	# 895:22-25
	lfd	f0, 0(r31)	# 895:22-25
	stfd	f0, 8(r2)	# 895:7-25
	lis	r2, ha16(min_caml_nvector)	# 896:7-14
	addi	r2, r2, lo16(min_caml_nvector)	# 896:7-14
	lis	r5, ha16(min_caml_vscan)	# 896:30-35
	addi	r5, r5, lo16(min_caml_vscan)	# 896:30-35
	lfd	f0, 16(r5)	# 896:29-40
	stw	r2, 8(r3)	# 896:24-41
	mflr	r31	# 896:24-41
	stw	r31, 12(r3)	# 896:24-41
	addi	r3, r3, 16	# 896:24-41
	bl	sgn.2025	# 896:24-41
	subi	r3, r3, 16	# 896:24-41
	lwz	r31, 12(r3)	# 896:24-41
	mtlr	r31	# 896:24-41
	fneg	f0, f0	# 896:22-41
	lwz	r2, 8(r3)	# 896:7-41
	stfd	f0, 16(r2)	# 896:7-41
	blr	# 896:7-41
beq_else.5847:	# 898:8-10
	blr	# 898:8-10
get_nvector_plane.2107:	# 901:12 - 906:33
	lis	r5, ha16(min_caml_nvector)	# 904:3-10
	addi	r5, r5, lo16(min_caml_nvector)	# 904:3-10
	stw	r2, 0(r3)	# 904:20-33
	stw	r5, 4(r3)	# 904:20-33
	mflr	r31	# 904:20-33
	stw	r31, 12(r3)	# 904:20-33
	addi	r3, r3, 16	# 904:20-33
	bl	o_param_a.1994	# 904:20-33
	subi	r3, r3, 16	# 904:20-33
	lwz	r31, 12(r3)	# 904:20-33
	mtlr	r31	# 904:20-33
	fneg	f0, f0	# 904:18-33
	lwz	r2, 4(r3)	# 904:3-33
	stfd	f0, 0(r2)	# 904:3-33
	lis	r2, ha16(min_caml_nvector)	# 905:3-10
	addi	r2, r2, lo16(min_caml_nvector)	# 905:3-10
	lwz	r5, 0(r3)	# 905:20-33
	stw	r2, 8(r3)	# 905:20-33
	mflr	r31	# 905:20-33
	mr	r2, r5	# 905:20-33
	stw	r31, 12(r3)	# 905:20-33
	addi	r3, r3, 16	# 905:20-33
	bl	o_param_b.1996	# 905:20-33
	subi	r3, r3, 16	# 905:20-33
	lwz	r31, 12(r3)	# 905:20-33
	mtlr	r31	# 905:20-33
	fneg	f0, f0	# 905:18-33
	lwz	r2, 8(r3)	# 905:3-33
	stfd	f0, 8(r2)	# 905:3-33
	lis	r2, ha16(min_caml_nvector)	# 906:3-10
	addi	r2, r2, lo16(min_caml_nvector)	# 906:3-10
	lwz	r5, 0(r3)	# 906:20-33
	stw	r2, 12(r3)	# 906:20-33
	mflr	r31	# 906:20-33
	mr	r2, r5	# 906:20-33
	stw	r31, 20(r3)	# 906:20-33
	addi	r3, r3, 24	# 906:20-33
	bl	o_param_c.1998	# 906:20-33
	subi	r3, r3, 24	# 906:20-33
	lwz	r31, 20(r3)	# 906:20-33
	mtlr	r31	# 906:20-33
	fneg	f0, f0	# 906:18-33
	lwz	r2, 12(r3)	# 906:3-33
	stfd	f0, 16(r2)	# 906:3-33
	blr	# 906:3-33
get_nvector_second_norot.2109:	# 909:12 - 915:42
	lis	r6, ha16(min_caml_nvector)	# 912:3-10
	addi	r6, r6, lo16(min_caml_nvector)	# 912:3-10
	lfd	f0, 0(r5)	# 912:19-24
	stw	r5, 0(r3)	# 912:28-39
	stw	r6, 4(r3)	# 912:28-39
	stw	r2, 8(r3)	# 912:28-39
	stfd	f0, 16(r3)	# 912:28-39
	mflr	r31	# 912:28-39
	stw	r31, 28(r3)	# 912:28-39
	addi	r3, r3, 32	# 912:28-39
	bl	o_param_x.2000	# 912:28-39
	subi	r3, r3, 32	# 912:28-39
	lwz	r31, 28(r3)	# 912:28-39
	mtlr	r31	# 912:28-39
	lfd	f1, 16(r3)	# 912:18-40
	fsub	f0, f1, f0	# 912:18-40
	lwz	r2, 8(r3)	# 912:44-55
	stfd	f0, 24(r3)	# 912:44-55
	mflr	r31	# 912:44-55
	stw	r31, 36(r3)	# 912:44-55
	addi	r3, r3, 40	# 912:44-55
	bl	o_param_a.1994	# 912:44-55
	subi	r3, r3, 40	# 912:44-55
	lwz	r31, 36(r3)	# 912:44-55
	mtlr	r31	# 912:44-55
	lfd	f1, 24(r3)	# 912:18-55
	fmul	f0, f1, f0	# 912:18-55
	lwz	r2, 4(r3)	# 912:3-55
	stfd	f0, 0(r2)	# 912:3-55
	lis	r2, ha16(min_caml_nvector)	# 913:3-10
	addi	r2, r2, lo16(min_caml_nvector)	# 913:3-10
	lwz	r5, 0(r3)	# 913:19-24
	lfd	f0, 8(r5)	# 913:19-24
	lwz	r6, 8(r3)	# 913:28-39
	stw	r2, 32(r3)	# 913:28-39
	stfd	f0, 40(r3)	# 913:28-39
	mflr	r31	# 913:28-39
	mr	r2, r6	# 913:28-39
	stw	r31, 52(r3)	# 913:28-39
	addi	r3, r3, 56	# 913:28-39
	bl	o_param_y.2002	# 913:28-39
	subi	r3, r3, 56	# 913:28-39
	lwz	r31, 52(r3)	# 913:28-39
	mtlr	r31	# 913:28-39
	lfd	f1, 40(r3)	# 913:18-40
	fsub	f0, f1, f0	# 913:18-40
	lwz	r2, 8(r3)	# 913:44-55
	stfd	f0, 48(r3)	# 913:44-55
	mflr	r31	# 913:44-55
	stw	r31, 60(r3)	# 913:44-55
	addi	r3, r3, 64	# 913:44-55
	bl	o_param_b.1996	# 913:44-55
	subi	r3, r3, 64	# 913:44-55
	lwz	r31, 60(r3)	# 913:44-55
	mtlr	r31	# 913:44-55
	lfd	f1, 48(r3)	# 913:18-55
	fmul	f0, f1, f0	# 913:18-55
	lwz	r2, 32(r3)	# 913:3-55
	stfd	f0, 8(r2)	# 913:3-55
	lis	r2, ha16(min_caml_nvector)	# 914:3-10
	addi	r2, r2, lo16(min_caml_nvector)	# 914:3-10
	lwz	r5, 0(r3)	# 914:19-24
	lfd	f0, 16(r5)	# 914:19-24
	lwz	r5, 8(r3)	# 914:28-39
	stw	r2, 56(r3)	# 914:28-39
	stfd	f0, 64(r3)	# 914:28-39
	mflr	r31	# 914:28-39
	mr	r2, r5	# 914:28-39
	stw	r31, 76(r3)	# 914:28-39
	addi	r3, r3, 80	# 914:28-39
	bl	o_param_z.2004	# 914:28-39
	subi	r3, r3, 80	# 914:28-39
	lwz	r31, 76(r3)	# 914:28-39
	mtlr	r31	# 914:28-39
	lfd	f1, 64(r3)	# 914:18-40
	fsub	f0, f1, f0	# 914:18-40
	lwz	r2, 8(r3)	# 914:44-55
	stfd	f0, 72(r3)	# 914:44-55
	mflr	r31	# 914:44-55
	stw	r31, 84(r3)	# 914:44-55
	addi	r3, r3, 88	# 914:44-55
	bl	o_param_c.1998	# 914:44-55
	subi	r3, r3, 88	# 914:44-55
	lwz	r31, 84(r3)	# 914:44-55
	mtlr	r31	# 914:44-55
	lfd	f1, 72(r3)	# 914:18-55
	fmul	f0, f1, f0	# 914:18-55
	lwz	r2, 56(r3)	# 914:3-55
	stfd	f0, 16(r2)	# 914:3-55
	lis	r2, ha16(min_caml_nvector)	# 915:20-27
	addi	r2, r2, lo16(min_caml_nvector)	# 915:20-27
	lwz	r5, 8(r3)	# 915:28-42
	stw	r2, 80(r3)	# 915:28-42
	mflr	r31	# 915:28-42
	mr	r2, r5	# 915:28-42
	stw	r31, 84(r3)	# 915:28-42
	addi	r3, r3, 88	# 915:28-42
	bl	o_isinvert.1990	# 915:28-42
	subi	r3, r3, 88	# 915:28-42
	lwz	r31, 84(r3)	# 915:28-42
	mr	r5, r2	# 915:28-42
	mtlr	r31	# 915:28-42
	lwz	r2, 80(r3)	# 915:3-42
	b	normalize_vector.2022	# 915:3-42
get_nvector_second_rot.2112:	# 918:12 - 932:42
	lis	r6, ha16(min_caml_nvector_w)	# 920:3-12
	addi	r6, r6, lo16(min_caml_nvector_w)	# 920:3-12
	lfd	f0, 0(r5)	# 920:20-25
	stw	r2, 0(r3)	# 920:29-40
	stw	r5, 4(r3)	# 920:29-40
	stw	r6, 8(r3)	# 920:29-40
	stfd	f0, 16(r3)	# 920:29-40
	mflr	r31	# 920:29-40
	stw	r31, 28(r3)	# 920:29-40
	addi	r3, r3, 32	# 920:29-40
	bl	o_param_x.2000	# 920:29-40
	subi	r3, r3, 32	# 920:29-40
	lwz	r31, 28(r3)	# 920:29-40
	mtlr	r31	# 920:29-40
	lfd	f1, 16(r3)	# 920:20-40
	fsub	f0, f1, f0	# 920:20-40
	lwz	r2, 8(r3)	# 920:3-40
	stfd	f0, 0(r2)	# 920:3-40
	lis	r2, ha16(min_caml_nvector_w)	# 921:3-12
	addi	r2, r2, lo16(min_caml_nvector_w)	# 921:3-12
	lwz	r5, 4(r3)	# 921:20-25
	lfd	f0, 8(r5)	# 921:20-25
	lwz	r6, 0(r3)	# 921:29-40
	stw	r2, 24(r3)	# 921:29-40
	stfd	f0, 32(r3)	# 921:29-40
	mflr	r31	# 921:29-40
	mr	r2, r6	# 921:29-40
	stw	r31, 44(r3)	# 921:29-40
	addi	r3, r3, 48	# 921:29-40
	bl	o_param_y.2002	# 921:29-40
	subi	r3, r3, 48	# 921:29-40
	lwz	r31, 44(r3)	# 921:29-40
	mtlr	r31	# 921:29-40
	lfd	f1, 32(r3)	# 921:20-40
	fsub	f0, f1, f0	# 921:20-40
	lwz	r2, 24(r3)	# 921:3-40
	stfd	f0, 8(r2)	# 921:3-40
	lis	r2, ha16(min_caml_nvector_w)	# 922:3-12
	addi	r2, r2, lo16(min_caml_nvector_w)	# 922:3-12
	lwz	r5, 4(r3)	# 922:20-25
	lfd	f0, 16(r5)	# 922:20-25
	lwz	r5, 0(r3)	# 922:29-40
	stw	r2, 40(r3)	# 922:29-40
	stfd	f0, 48(r3)	# 922:29-40
	mflr	r31	# 922:29-40
	mr	r2, r5	# 922:29-40
	stw	r31, 60(r3)	# 922:29-40
	addi	r3, r3, 64	# 922:29-40
	bl	o_param_z.2004	# 922:29-40
	subi	r3, r3, 64	# 922:29-40
	lwz	r31, 60(r3)	# 922:29-40
	mtlr	r31	# 922:29-40
	lfd	f1, 48(r3)	# 922:20-40
	fsub	f0, f1, f0	# 922:20-40
	lwz	r2, 40(r3)	# 922:3-40
	stfd	f0, 16(r2)	# 922:3-40
	lis	r2, ha16(min_caml_nvector)	# 923:3-10
	addi	r2, r2, lo16(min_caml_nvector)	# 923:3-10
	lis	r5, ha16(min_caml_nvector_w)	# 923:19-28
	addi	r5, r5, lo16(min_caml_nvector_w)	# 923:19-28
	lfd	f0, 0(r5)	# 923:19-32
	lwz	r5, 0(r3)	# 923:43-54
	stw	r2, 56(r3)	# 923:43-54
	stfd	f0, 64(r3)	# 923:43-54
	mflr	r31	# 923:43-54
	mr	r2, r5	# 923:43-54
	stw	r31, 76(r3)	# 923:43-54
	addi	r3, r3, 80	# 923:43-54
	bl	o_param_a.1994	# 923:43-54
	subi	r3, r3, 80	# 923:43-54
	lwz	r31, 76(r3)	# 923:43-54
	mtlr	r31	# 923:43-54
	lfd	f1, 64(r3)	# 923:19-54
	fmul	f0, f1, f0	# 923:19-54
	lis	r2, ha16(min_caml_nvector_w)	# 924:31-40
	addi	r2, r2, lo16(min_caml_nvector_w)	# 924:31-40
	lfd	f1, 8(r2)	# 924:31-44
	lwz	r2, 0(r3)	# 924:48-60
	stfd	f0, 72(r3)	# 924:48-60
	stfd	f1, 80(r3)	# 924:48-60
	mflr	r31	# 924:48-60
	stw	r31, 92(r3)	# 924:48-60
	addi	r3, r3, 96	# 924:48-60
	bl	o_param_r3.2020	# 924:48-60
	subi	r3, r3, 96	# 924:48-60
	lwz	r31, 92(r3)	# 924:48-60
	mtlr	r31	# 924:48-60
	lfd	f1, 80(r3)	# 924:31-60
	fmul	f0, f1, f0	# 924:31-60
	lis	r2, ha16(min_caml_nvector_w)	# 925:36-45
	addi	r2, r2, lo16(min_caml_nvector_w)	# 925:36-45
	lfd	f1, 16(r2)	# 925:36-49
	lwz	r2, 0(r3)	# 925:53-65
	stfd	f0, 88(r3)	# 925:53-65
	stfd	f1, 96(r3)	# 925:53-65
	mflr	r31	# 925:53-65
	stw	r31, 108(r3)	# 925:53-65
	addi	r3, r3, 112	# 925:53-65
	bl	o_param_r2.2018	# 925:53-65
	subi	r3, r3, 112	# 925:53-65
	lwz	r31, 108(r3)	# 925:53-65
	mtlr	r31	# 925:53-65
	lfd	f1, 96(r3)	# 925:36-65
	fmul	f0, f1, f0	# 925:36-65
	lfd	f1, 88(r3)	# 924:30 - 925:66
	fadd	f0, f1, f0	# 924:30 - 925:66
	mflr	r31	# 924:24 - 925:66
	stw	r31, 108(r3)	# 924:24 - 925:66
	addi	r3, r3, 112	# 924:24 - 925:66
	bl	fhalf.1982	# 924:24 - 925:66
	subi	r3, r3, 112	# 924:24 - 925:66
	lwz	r31, 108(r3)	# 924:24 - 925:66
	mtlr	r31	# 924:24 - 925:66
	lfd	f1, 72(r3)	# 923:18 - 925:67
	fadd	f0, f1, f0	# 923:18 - 925:67
	lwz	r2, 56(r3)	# 923:3 - 925:67
	stfd	f0, 0(r2)	# 923:3 - 925:67
	lis	r2, ha16(min_caml_nvector)	# 926:3-10
	addi	r2, r2, lo16(min_caml_nvector)	# 926:3-10
	lis	r5, ha16(min_caml_nvector_w)	# 926:19-28
	addi	r5, r5, lo16(min_caml_nvector_w)	# 926:19-28
	lfd	f0, 8(r5)	# 926:19-32
	lwz	r5, 0(r3)	# 926:43-54
	stw	r2, 104(r3)	# 926:43-54
	stfd	f0, 112(r3)	# 926:43-54
	mflr	r31	# 926:43-54
	mr	r2, r5	# 926:43-54
	stw	r31, 124(r3)	# 926:43-54
	addi	r3, r3, 128	# 926:43-54
	bl	o_param_b.1996	# 926:43-54
	subi	r3, r3, 128	# 926:43-54
	lwz	r31, 124(r3)	# 926:43-54
	mtlr	r31	# 926:43-54
	lfd	f1, 112(r3)	# 926:19-54
	fmul	f0, f1, f0	# 926:19-54
	lis	r2, ha16(min_caml_nvector_w)	# 927:31-40
	addi	r2, r2, lo16(min_caml_nvector_w)	# 927:31-40
	lfd	f1, 0(r2)	# 927:31-44
	lwz	r2, 0(r3)	# 927:48-60
	stfd	f0, 120(r3)	# 927:48-60
	stfd	f1, 128(r3)	# 927:48-60
	mflr	r31	# 927:48-60
	stw	r31, 140(r3)	# 927:48-60
	addi	r3, r3, 144	# 927:48-60
	bl	o_param_r3.2020	# 927:48-60
	subi	r3, r3, 144	# 927:48-60
	lwz	r31, 140(r3)	# 927:48-60
	mtlr	r31	# 927:48-60
	lfd	f1, 128(r3)	# 927:31-60
	fmul	f0, f1, f0	# 927:31-60
	lis	r2, ha16(min_caml_nvector_w)	# 928:36-45
	addi	r2, r2, lo16(min_caml_nvector_w)	# 928:36-45
	lfd	f1, 16(r2)	# 928:36-49
	lwz	r2, 0(r3)	# 928:53-65
	stfd	f0, 136(r3)	# 928:53-65
	stfd	f1, 144(r3)	# 928:53-65
	mflr	r31	# 928:53-65
	stw	r31, 156(r3)	# 928:53-65
	addi	r3, r3, 160	# 928:53-65
	bl	o_param_r1.2016	# 928:53-65
	subi	r3, r3, 160	# 928:53-65
	lwz	r31, 156(r3)	# 928:53-65
	mtlr	r31	# 928:53-65
	lfd	f1, 144(r3)	# 928:36-65
	fmul	f0, f1, f0	# 928:36-65
	lfd	f1, 136(r3)	# 927:30 - 928:66
	fadd	f0, f1, f0	# 927:30 - 928:66
	mflr	r31	# 927:24 - 928:66
	stw	r31, 156(r3)	# 927:24 - 928:66
	addi	r3, r3, 160	# 927:24 - 928:66
	bl	fhalf.1982	# 927:24 - 928:66
	subi	r3, r3, 160	# 927:24 - 928:66
	lwz	r31, 156(r3)	# 927:24 - 928:66
	mtlr	r31	# 927:24 - 928:66
	lfd	f1, 120(r3)	# 926:18 - 928:67
	fadd	f0, f1, f0	# 926:18 - 928:67
	lwz	r2, 104(r3)	# 926:3 - 928:67
	stfd	f0, 8(r2)	# 926:3 - 928:67
	lis	r2, ha16(min_caml_nvector)	# 929:3-10
	addi	r2, r2, lo16(min_caml_nvector)	# 929:3-10
	lis	r5, ha16(min_caml_nvector_w)	# 929:19-28
	addi	r5, r5, lo16(min_caml_nvector_w)	# 929:19-28
	lfd	f0, 16(r5)	# 929:19-32
	lwz	r5, 0(r3)	# 929:43-54
	stw	r2, 152(r3)	# 929:43-54
	stfd	f0, 160(r3)	# 929:43-54
	mflr	r31	# 929:43-54
	mr	r2, r5	# 929:43-54
	stw	r31, 172(r3)	# 929:43-54
	addi	r3, r3, 176	# 929:43-54
	bl	o_param_c.1998	# 929:43-54
	subi	r3, r3, 176	# 929:43-54
	lwz	r31, 172(r3)	# 929:43-54
	mtlr	r31	# 929:43-54
	lfd	f1, 160(r3)	# 929:19-54
	fmul	f0, f1, f0	# 929:19-54
	lis	r2, ha16(min_caml_nvector_w)	# 930:31-40
	addi	r2, r2, lo16(min_caml_nvector_w)	# 930:31-40
	lfd	f1, 0(r2)	# 930:31-44
	lwz	r2, 0(r3)	# 930:48-60
	stfd	f0, 168(r3)	# 930:48-60
	stfd	f1, 176(r3)	# 930:48-60
	mflr	r31	# 930:48-60
	stw	r31, 188(r3)	# 930:48-60
	addi	r3, r3, 192	# 930:48-60
	bl	o_param_r2.2018	# 930:48-60
	subi	r3, r3, 192	# 930:48-60
	lwz	r31, 188(r3)	# 930:48-60
	mtlr	r31	# 930:48-60
	lfd	f1, 176(r3)	# 930:31-60
	fmul	f0, f1, f0	# 930:31-60
	lis	r2, ha16(min_caml_nvector_w)	# 931:36-45
	addi	r2, r2, lo16(min_caml_nvector_w)	# 931:36-45
	lfd	f1, 8(r2)	# 931:36-49
	lwz	r2, 0(r3)	# 931:53-65
	stfd	f0, 184(r3)	# 931:53-65
	stfd	f1, 192(r3)	# 931:53-65
	mflr	r31	# 931:53-65
	stw	r31, 204(r3)	# 931:53-65
	addi	r3, r3, 208	# 931:53-65
	bl	o_param_r1.2016	# 931:53-65
	subi	r3, r3, 208	# 931:53-65
	lwz	r31, 204(r3)	# 931:53-65
	mtlr	r31	# 931:53-65
	lfd	f1, 192(r3)	# 931:36-65
	fmul	f0, f1, f0	# 931:36-65
	lfd	f1, 184(r3)	# 930:30 - 931:66
	fadd	f0, f1, f0	# 930:30 - 931:66
	mflr	r31	# 930:24 - 931:66
	stw	r31, 204(r3)	# 930:24 - 931:66
	addi	r3, r3, 208	# 930:24 - 931:66
	bl	fhalf.1982	# 930:24 - 931:66
	subi	r3, r3, 208	# 930:24 - 931:66
	lwz	r31, 204(r3)	# 930:24 - 931:66
	mtlr	r31	# 930:24 - 931:66
	lfd	f1, 168(r3)	# 929:18 - 931:67
	fadd	f0, f1, f0	# 929:18 - 931:67
	lwz	r2, 152(r3)	# 929:3 - 931:67
	stfd	f0, 16(r2)	# 929:3 - 931:67
	lis	r2, ha16(min_caml_nvector)	# 932:20-27
	addi	r2, r2, lo16(min_caml_nvector)	# 932:20-27
	lwz	r5, 0(r3)	# 932:28-42
	stw	r2, 200(r3)	# 932:28-42
	mflr	r31	# 932:28-42
	mr	r2, r5	# 932:28-42
	stw	r31, 204(r3)	# 932:28-42
	addi	r3, r3, 208	# 932:28-42
	bl	o_isinvert.1990	# 932:28-42
	subi	r3, r3, 208	# 932:28-42
	lwz	r31, 204(r3)	# 932:28-42
	mr	r5, r2	# 932:28-42
	mtlr	r31	# 932:28-42
	lwz	r2, 200(r3)	# 932:3-42
	b	normalize_vector.2022	# 932:3-42
get_nvector.2115:	# 935:12 - 946:35
	stw	r5, 0(r3)	# 937:17-25
	stw	r2, 4(r3)	# 937:17-25
	mflr	r31	# 937:3-25
	stw	r31, 12(r3)	# 937:3-25
	addi	r3, r3, 16	# 937:3-25
	bl	o_form.1986	# 937:3-25
	subi	r3, r3, 16	# 937:3-25
	lwz	r31, 12(r3)	# 937:3-25
	mtlr	r31	# 937:3-25
	cmpwi	cr7, r2, 1	# 938:6-17
	bne	cr7, beq_else.5860	# 938:3 - 946:35
#	939:5-24
	b	get_nvector_rect.2105	# 939:5-24
beq_else.5860:	# 940:8 - 946:35
	cmpwi	cr7, r2, 2	# 940:11-22
	bne	cr7, beq_else.5861	# 940:8 - 946:35
#	941:5-24
	lwz	r2, 4(r3)	# 941:5-24
	b	get_nvector_plane.2107	# 941:5-24
beq_else.5861:	# 943:5 - 946:35
	lwz	r2, 4(r3)	# 943:8-17
	mflr	r31	# 943:8-17
	stw	r31, 12(r3)	# 943:8-17
	addi	r3, r3, 16	# 943:8-17
	bl	o_isrot.1992	# 943:8-17
	subi	r3, r3, 16	# 943:8-17
	lwz	r31, 12(r3)	# 943:8-17
	mtlr	r31	# 943:8-17
	cmpwi	cr7, r2, 0	# 943:8-22
	bne	cr7, beq_else.5862	# 943:5 - 946:35
#	946:7-35
	lwz	r2, 4(r3)	# 946:7-35
	lwz	r5, 0(r3)	# 946:7-35
	b	get_nvector_second_norot.2109	# 946:7-35
beq_else.5862:	# 944:7-33
	lwz	r2, 4(r3)	# 944:7-33
	lwz	r5, 0(r3)	# 944:7-33
	b	get_nvector_second_rot.2112	# 944:7-33
utexture.2118:	# 951:12 - 1021:10
	stw	r5, 0(r3)	# 953:15-30
	stw	r2, 4(r3)	# 953:15-30
	mflr	r31	# 953:3-30
	stw	r31, 12(r3)	# 953:3-30
	addi	r3, r3, 16	# 953:3-30
	bl	o_texturetype.1984	# 953:3-30
	subi	r3, r3, 16	# 953:3-30
	lwz	r31, 12(r3)	# 953:3-30
	mtlr	r31	# 953:3-30
	lis	r5, ha16(min_caml_texture_color)	# 955:3-16
	addi	r5, r5, lo16(min_caml_texture_color)	# 955:3-16
	lwz	r6, 4(r3)	# 955:24-37
	stw	r2, 8(r3)	# 955:24-37
	stw	r5, 12(r3)	# 955:24-37
	mflr	r31	# 955:24-37
	mr	r2, r6	# 955:24-37
	stw	r31, 20(r3)	# 955:24-37
	addi	r3, r3, 24	# 955:24-37
	bl	o_color_red.2010	# 955:24-37
	subi	r3, r3, 24	# 955:24-37
	lwz	r31, 20(r3)	# 955:24-37
	mtlr	r31	# 955:24-37
	lwz	r2, 12(r3)	# 955:3-37
	stfd	f0, 0(r2)	# 955:3-37
	lis	r2, ha16(min_caml_texture_color)	# 956:3-16
	addi	r2, r2, lo16(min_caml_texture_color)	# 956:3-16
	lwz	r5, 4(r3)	# 956:24-39
	stw	r2, 16(r3)	# 956:24-39
	mflr	r31	# 956:24-39
	mr	r2, r5	# 956:24-39
	stw	r31, 20(r3)	# 956:24-39
	addi	r3, r3, 24	# 956:24-39
	bl	o_color_green.2012	# 956:24-39
	subi	r3, r3, 24	# 956:24-39
	lwz	r31, 20(r3)	# 956:24-39
	mtlr	r31	# 956:24-39
	lwz	r2, 16(r3)	# 956:3-39
	stfd	f0, 8(r2)	# 956:3-39
	lis	r2, ha16(min_caml_texture_color)	# 957:3-16
	addi	r2, r2, lo16(min_caml_texture_color)	# 957:3-16
	lwz	r5, 4(r3)	# 957:24-38
	stw	r2, 20(r3)	# 957:24-38
	mflr	r31	# 957:24-38
	mr	r2, r5	# 957:24-38
	stw	r31, 28(r3)	# 957:24-38
	addi	r3, r3, 32	# 957:24-38
	bl	o_color_blue.2014	# 957:24-38
	subi	r3, r3, 32	# 957:24-38
	lwz	r31, 28(r3)	# 957:24-38
	mtlr	r31	# 957:24-38
	lwz	r2, 20(r3)	# 957:3-38
	stfd	f0, 16(r2)	# 957:3-38
	lwz	r2, 8(r3)	# 958:3 - 1021:10
	cmpwi	cr7, r2, 1	# 958:6-15
	bne	cr7, beq_else.5863	# 958:3 - 1021:10
#	959:5 - 975:6
	lwz	r2, 0(r3)	# 961:15-20
	lfd	f0, 0(r2)	# 961:15-20
	lwz	r5, 4(r3)	# 961:24-35
	stfd	f0, 24(r3)	# 961:24-35
	mflr	r31	# 961:24-35
	mr	r2, r5	# 961:24-35
	stw	r31, 36(r3)	# 961:24-35
	addi	r3, r3, 40	# 961:24-35
	bl	o_param_x.2000	# 961:24-35
	subi	r3, r3, 40	# 961:24-35
	lwz	r31, 36(r3)	# 961:24-35
	mtlr	r31	# 961:24-35
	lfd	f1, 24(r3)	# 961:6-35
	fsub	f0, f1, f0	# 961:6-35
	lis	r31, ha16(l.4827)	# 963:31-35
	addi	r31, r31, lo16(l.4827)	# 963:31-35
	lfd	f1, 0(r31)	# 963:31-35
	fmul	f1, f0, f1	# 963:24-36
	stfd	f0, 32(r3)	# 963:17-37
	mflr	r31	# 963:17-37
	fmr	f0, f1	# 963:17-37
	stw	r31, 44(r3)	# 963:17-37
	addi	r3, r3, 48	# 963:17-37
	bl	min_caml_floor	# 963:17-37
	subi	r3, r3, 48	# 963:17-37
	lwz	r31, 44(r3)	# 963:17-37
	mtlr	r31	# 963:17-37
	lis	r31, ha16(l.4828)	# 963:41-45
	addi	r31, r31, lo16(l.4828)	# 963:41-45
	lfd	f1, 0(r31)	# 963:41-45
	fmul	f0, f0, f1	# 963:8-45
	lis	r31, ha16(l.4817)	# 964:22-26
	addi	r31, r31, lo16(l.4817)	# 964:22-26
	lfd	f1, 0(r31)	# 964:22-26
	lfd	f2, 32(r3)	# 964:11-19
	fsub	f0, f2, f0	# 964:11-19
	fcmpu	cr7, f1, f0	# 964:11-26
	bgt	cr7, ble_else.5864	# 962:6 - 964:47
#	964:42-47
	li	r2, 0	# 964:42-47
	b	ble_cont.5865
ble_else.5864:	# 964:32-36
	li	r2, 1	# 964:32-36
ble_cont.5865:	# 962:6 - 964:47
	lwz	r5, 0(r3)	# 966:15-20
	lfd	f0, 16(r5)	# 966:15-20
	lwz	r5, 4(r3)	# 966:24-35
	stw	r2, 40(r3)	# 966:24-35
	stfd	f0, 48(r3)	# 966:24-35
	mflr	r31	# 966:24-35
	mr	r2, r5	# 966:24-35
	stw	r31, 60(r3)	# 966:24-35
	addi	r3, r3, 64	# 966:24-35
	bl	o_param_z.2004	# 966:24-35
	subi	r3, r3, 64	# 966:24-35
	lwz	r31, 60(r3)	# 966:24-35
	mtlr	r31	# 966:24-35
	lfd	f1, 48(r3)	# 966:6-35
	fsub	f0, f1, f0	# 966:6-35
	lis	r31, ha16(l.4827)	# 968:31-35
	addi	r31, r31, lo16(l.4827)	# 968:31-35
	lfd	f1, 0(r31)	# 968:31-35
	fmul	f1, f0, f1	# 968:24-36
	stfd	f0, 56(r3)	# 968:17-37
	mflr	r31	# 968:17-37
	fmr	f0, f1	# 968:17-37
	stw	r31, 68(r3)	# 968:17-37
	addi	r3, r3, 72	# 968:17-37
	bl	min_caml_floor	# 968:17-37
	subi	r3, r3, 72	# 968:17-37
	lwz	r31, 68(r3)	# 968:17-37
	mtlr	r31	# 968:17-37
	lis	r31, ha16(l.4828)	# 968:41-45
	addi	r31, r31, lo16(l.4828)	# 968:41-45
	lfd	f1, 0(r31)	# 968:41-45
	fmul	f0, f0, f1	# 968:8-45
	lis	r31, ha16(l.4817)	# 969:22-26
	addi	r31, r31, lo16(l.4817)	# 969:22-26
	lfd	f1, 0(r31)	# 969:22-26
	lfd	f2, 56(r3)	# 969:11-19
	fsub	f0, f2, f0	# 969:11-19
	fcmpu	cr7, f1, f0	# 969:11-26
	bgt	cr7, ble_else.5867	# 967:6 - 969:47
#	969:42-47
	li	r2, 0	# 969:42-47
	b	ble_cont.5868
ble_else.5867:	# 969:32-36
	li	r2, 1	# 969:32-36
ble_cont.5868:	# 967:6 - 969:47
	lis	r5, ha16(min_caml_texture_color)	# 971:6-19
	addi	r5, r5, lo16(min_caml_texture_color)	# 971:6-19
	lwz	r6, 40(r3)	# 972:8 - 974:43
	cmpwi	cr7, r6, 0	# 972:8 - 974:43
	bne	cr7, beq_else.5869	# 972:8 - 974:43
#	974:13-43
	cmpwi	cr7, r2, 0	# 974:13-43
	bne	cr7, beq_else.5871	# 974:13-43
#	974:37-42
	lis	r31, ha16(l.4819)	# 974:37-42
	addi	r31, r31, lo16(l.4819)	# 974:37-42
	lfd	f0, 0(r31)	# 974:37-42
	b	beq_cont.5872
beq_else.5871:	# 974:28-31
	lis	r31, ha16(l.4464)	# 974:28-31
	addi	r31, r31, lo16(l.4464)	# 974:28-31
	lfd	f0, 0(r31)	# 974:28-31
beq_cont.5872:	# 974:13-43
	b	beq_cont.5870
beq_else.5869:	# 973:13-43
	cmpwi	cr7, r2, 0	# 973:13-43
	bne	cr7, beq_else.5873	# 973:13-43
#	973:39-42
	lis	r31, ha16(l.4464)	# 973:39-42
	addi	r31, r31, lo16(l.4464)	# 973:39-42
	lfd	f0, 0(r31)	# 973:39-42
	b	beq_cont.5874
beq_else.5873:	# 973:28-33
	lis	r31, ha16(l.4819)	# 973:28-33
	addi	r31, r31, lo16(l.4819)	# 973:28-33
	lfd	f0, 0(r31)	# 973:28-33
beq_cont.5874:	# 973:13-43
beq_cont.5870:	# 972:8 - 974:43
	stfd	f0, 8(r5)	# 971:6 - 974:43
	blr	# 971:6 - 974:43
beq_else.5863:	# 976:8 - 1021:10
	cmpwi	cr7, r2, 2	# 976:11-20
	bne	cr7, beq_else.5876	# 976:8 - 1021:10
#	978:5 - 982:6
	lwz	r2, 0(r3)	# 979:27-32
	lfd	f0, 8(r2)	# 979:27-32
	lis	r31, ha16(l.4823)	# 979:36-40
	addi	r31, r31, lo16(l.4823)	# 979:36-40
	lfd	f1, 0(r31)	# 979:36-40
	fmul	f0, f0, f1	# 979:26-41
	mflr	r31	# 979:21-42
	stw	r31, 68(r3)	# 979:21-42
	addi	r3, r3, 72	# 979:21-42
	bl	min_caml_sin	# 979:21-42
	subi	r3, r3, 72	# 979:21-42
	lwz	r31, 68(r3)	# 979:21-42
	mtlr	r31	# 979:21-42
	mflr	r31	# 979:7-42
	stw	r31, 68(r3)	# 979:7-42
	addi	r3, r3, 72	# 979:7-42
	bl	fsqr.1980	# 979:7-42
	subi	r3, r3, 72	# 979:7-42
	lwz	r31, 68(r3)	# 979:7-42
	mtlr	r31	# 979:7-42
	lis	r2, ha16(min_caml_texture_color)	# 980:7-20
	addi	r2, r2, lo16(min_caml_texture_color)	# 980:7-20
	lis	r31, ha16(l.4819)	# 980:28-33
	addi	r31, r31, lo16(l.4819)	# 980:28-33
	lfd	f1, 0(r31)	# 980:28-33
	fmul	f1, f1, f0	# 980:28-39
	stfd	f1, 0(r2)	# 980:7-39
	lis	r2, ha16(min_caml_texture_color)	# 981:7-20
	addi	r2, r2, lo16(min_caml_texture_color)	# 981:7-20
	lis	r31, ha16(l.4819)	# 981:28-33
	addi	r31, r31, lo16(l.4819)	# 981:28-33
	lfd	f1, 0(r31)	# 981:28-33
	lis	r31, ha16(l.4465)	# 981:38-41
	addi	r31, r31, lo16(l.4465)	# 981:38-41
	lfd	f2, 0(r31)	# 981:38-41
	fsub	f0, f2, f0	# 981:37-48
	fmul	f0, f1, f0	# 981:28-48
	stfd	f0, 8(r2)	# 981:7-48
	blr	# 981:7-48
beq_else.5876:	# 983:8 - 1021:10
	cmpwi	cr7, r2, 3	# 983:11-20
	bne	cr7, beq_else.5878	# 983:8 - 1021:10
#	985:5 - 993:6
	lwz	r2, 0(r3)	# 986:16-21
	lfd	f0, 0(r2)	# 986:16-21
	lwz	r5, 4(r3)	# 986:25-36
	stfd	f0, 64(r3)	# 986:25-36
	mflr	r31	# 986:25-36
	mr	r2, r5	# 986:25-36
	stw	r31, 76(r3)	# 986:25-36
	addi	r3, r3, 80	# 986:25-36
	bl	o_param_x.2000	# 986:25-36
	subi	r3, r3, 80	# 986:25-36
	lwz	r31, 76(r3)	# 986:25-36
	mtlr	r31	# 986:25-36
	lfd	f1, 64(r3)	# 986:7-36
	fsub	f0, f1, f0	# 986:7-36
	lwz	r2, 0(r3)	# 987:16-21
	lfd	f1, 16(r2)	# 987:16-21
	lwz	r2, 4(r3)	# 987:25-36
	stfd	f0, 72(r3)	# 987:25-36
	stfd	f1, 80(r3)	# 987:25-36
	mflr	r31	# 987:25-36
	stw	r31, 92(r3)	# 987:25-36
	addi	r3, r3, 96	# 987:25-36
	bl	o_param_z.2004	# 987:25-36
	subi	r3, r3, 96	# 987:25-36
	lwz	r31, 92(r3)	# 987:25-36
	mtlr	r31	# 987:25-36
	lfd	f1, 80(r3)	# 987:7-36
	fsub	f0, f1, f0	# 987:7-36
	lfd	f1, 72(r3)	# 988:22-29
	stfd	f0, 88(r3)	# 988:22-29
	mflr	r31	# 988:22-29
	fmr	f0, f1	# 988:22-29
	stw	r31, 100(r3)	# 988:22-29
	addi	r3, r3, 104	# 988:22-29
	bl	fsqr.1980	# 988:22-29
	subi	r3, r3, 104	# 988:22-29
	lwz	r31, 100(r3)	# 988:22-29
	mtlr	r31	# 988:22-29
	lfd	f1, 88(r3)	# 988:33-40
	stfd	f0, 96(r3)	# 988:33-40
	mflr	r31	# 988:33-40
	fmr	f0, f1	# 988:33-40
	stw	r31, 108(r3)	# 988:33-40
	addi	r3, r3, 112	# 988:33-40
	bl	fsqr.1980	# 988:33-40
	subi	r3, r3, 112	# 988:33-40
	lwz	r31, 108(r3)	# 988:33-40
	mtlr	r31	# 988:33-40
	lfd	f1, 96(r3)	# 988:21-41
	fadd	f0, f1, f0	# 988:21-41
	mflr	r31	# 988:16-41
	stw	r31, 108(r3)	# 988:16-41
	addi	r3, r3, 112	# 988:16-41
	bl	min_caml_sqrt	# 988:16-41
	subi	r3, r3, 112	# 988:16-41
	lwz	r31, 108(r3)	# 988:16-41
	mtlr	r31	# 988:16-41
	lis	r31, ha16(l.4817)	# 988:45-49
	addi	r31, r31, lo16(l.4817)	# 988:45-49
	lfd	f1, 0(r31)	# 988:45-49
	fdiv	f0, f0, f1	# 988:7-49
	stfd	f0, 104(r3)	# 989:24-32
	mflr	r31	# 989:24-32
	stw	r31, 116(r3)	# 989:24-32
	addi	r3, r3, 120	# 989:24-32
	bl	min_caml_floor	# 989:24-32
	subi	r3, r3, 120	# 989:24-32
	lwz	r31, 116(r3)	# 989:24-32
	mtlr	r31	# 989:24-32
	lfd	f1, 104(r3)	# 989:17-33
	fsub	f0, f1, f0	# 989:17-33
	lis	r31, ha16(l.4818)	# 989:37-46
	addi	r31, r31, lo16(l.4818)	# 989:37-46
	lfd	f1, 0(r31)	# 989:37-46
	fmul	f0, f0, f1	# 989:7-46
	mflr	r31	# 990:22-30
	stw	r31, 116(r3)	# 990:22-30
	addi	r3, r3, 120	# 990:22-30
	bl	min_caml_cos	# 990:22-30
	subi	r3, r3, 120	# 990:22-30
	lwz	r31, 116(r3)	# 990:22-30
	mtlr	r31	# 990:22-30
	mflr	r31	# 990:7-30
	stw	r31, 116(r3)	# 990:7-30
	addi	r3, r3, 120	# 990:7-30
	bl	fsqr.1980	# 990:7-30
	subi	r3, r3, 120	# 990:7-30
	lwz	r31, 116(r3)	# 990:7-30
	mtlr	r31	# 990:7-30
	lis	r2, ha16(min_caml_texture_color)	# 991:7-20
	addi	r2, r2, lo16(min_caml_texture_color)	# 991:7-20
	lis	r31, ha16(l.4819)	# 991:35-40
	addi	r31, r31, lo16(l.4819)	# 991:35-40
	lfd	f1, 0(r31)	# 991:35-40
	fmul	f1, f0, f1	# 991:28-40
	stfd	f1, 8(r2)	# 991:7-40
	lis	r2, ha16(min_caml_texture_color)	# 992:7-20
	addi	r2, r2, lo16(min_caml_texture_color)	# 992:7-20
	lis	r31, ha16(l.4465)	# 992:29-32
	addi	r31, r31, lo16(l.4465)	# 992:29-32
	lfd	f1, 0(r31)	# 992:29-32
	fsub	f0, f1, f0	# 992:28-40
	lis	r31, ha16(l.4819)	# 992:44-49
	addi	r31, r31, lo16(l.4819)	# 992:44-49
	lfd	f1, 0(r31)	# 992:44-49
	fmul	f0, f0, f1	# 992:28-49
	stfd	f0, 16(r2)	# 992:7-49
	blr	# 992:7-49
beq_else.5878:	# 994:8 - 1021:10
	cmpwi	cr7, r2, 4	# 994:11-20
	bne	cr7, beq_else.5880	# 994:8 - 1021:10
#	994:26 - 1020:5
	lwz	r2, 0(r3)	# 996:15-20
	lfd	f0, 0(r2)	# 996:15-20
	lwz	r5, 4(r3)	# 996:24-35
	stfd	f0, 112(r3)	# 996:24-35
	mflr	r31	# 996:24-35
	mr	r2, r5	# 996:24-35
	stw	r31, 124(r3)	# 996:24-35
	addi	r3, r3, 128	# 996:24-35
	bl	o_param_x.2000	# 996:24-35
	subi	r3, r3, 128	# 996:24-35
	lwz	r31, 124(r3)	# 996:24-35
	mtlr	r31	# 996:24-35
	lfd	f1, 112(r3)	# 996:14-36
	fsub	f0, f1, f0	# 996:14-36
	lwz	r2, 4(r3)	# 996:46-59
	stfd	f0, 120(r3)	# 996:46-59
	mflr	r31	# 996:46-59
	stw	r31, 132(r3)	# 996:46-59
	addi	r3, r3, 136	# 996:46-59
	bl	o_param_a.1994	# 996:46-59
	subi	r3, r3, 136	# 996:46-59
	lwz	r31, 132(r3)	# 996:46-59
	mtlr	r31	# 996:46-59
	mflr	r31	# 996:40-60
	stw	r31, 132(r3)	# 996:40-60
	addi	r3, r3, 136	# 996:40-60
	bl	min_caml_sqrt	# 996:40-60
	subi	r3, r3, 136	# 996:40-60
	lwz	r31, 132(r3)	# 996:40-60
	mtlr	r31	# 996:40-60
	lfd	f1, 120(r3)	# 996:5-60
	fmul	f0, f1, f0	# 996:5-60
	lwz	r2, 0(r3)	# 997:15-20
	lfd	f1, 16(r2)	# 997:15-20
	lwz	r5, 4(r3)	# 997:24-35
	stfd	f0, 128(r3)	# 997:24-35
	stfd	f1, 136(r3)	# 997:24-35
	mflr	r31	# 997:24-35
	mr	r2, r5	# 997:24-35
	stw	r31, 148(r3)	# 997:24-35
	addi	r3, r3, 152	# 997:24-35
	bl	o_param_z.2004	# 997:24-35
	subi	r3, r3, 152	# 997:24-35
	lwz	r31, 148(r3)	# 997:24-35
	mtlr	r31	# 997:24-35
	lfd	f1, 136(r3)	# 997:14-36
	fsub	f0, f1, f0	# 997:14-36
	lwz	r2, 4(r3)	# 997:46-59
	stfd	f0, 144(r3)	# 997:46-59
	mflr	r31	# 997:46-59
	stw	r31, 156(r3)	# 997:46-59
	addi	r3, r3, 160	# 997:46-59
	bl	o_param_c.1998	# 997:46-59
	subi	r3, r3, 160	# 997:46-59
	lwz	r31, 156(r3)	# 997:46-59
	mtlr	r31	# 997:46-59
	mflr	r31	# 997:40-60
	stw	r31, 156(r3)	# 997:40-60
	addi	r3, r3, 160	# 997:40-60
	bl	min_caml_sqrt	# 997:40-60
	subi	r3, r3, 160	# 997:40-60
	lwz	r31, 156(r3)	# 997:40-60
	mtlr	r31	# 997:40-60
	lfd	f1, 144(r3)	# 997:5-60
	fmul	f0, f1, f0	# 997:5-60
	lfd	f1, 128(r3)	# 998:20-29
	stfd	f0, 152(r3)	# 998:20-29
	mflr	r31	# 998:20-29
	fmr	f0, f1	# 998:20-29
	stw	r31, 164(r3)	# 998:20-29
	addi	r3, r3, 168	# 998:20-29
	bl	fsqr.1980	# 998:20-29
	subi	r3, r3, 168	# 998:20-29
	lwz	r31, 164(r3)	# 998:20-29
	mtlr	r31	# 998:20-29
	lfd	f1, 152(r3)	# 998:33-42
	stfd	f0, 160(r3)	# 998:33-42
	mflr	r31	# 998:33-42
	fmr	f0, f1	# 998:33-42
	stw	r31, 172(r3)	# 998:33-42
	addi	r3, r3, 176	# 998:33-42
	bl	fsqr.1980	# 998:33-42
	subi	r3, r3, 176	# 998:33-42
	lwz	r31, 172(r3)	# 998:33-42
	mtlr	r31	# 998:33-42
	lfd	f1, 160(r3)	# 998:19-43
	fadd	f0, f1, f0	# 998:19-43
	mflr	r31	# 998:5-43
	stw	r31, 172(r3)	# 998:5-43
	addi	r3, r3, 176	# 998:5-43
	bl	min_caml_sqrt	# 998:5-43
	subi	r3, r3, 176	# 998:5-43
	lwz	r31, 172(r3)	# 998:5-43
	mtlr	r31	# 998:5-43
	lis	r31, ha16(l.4807)	# 1000:25-31
	addi	r31, r31, lo16(l.4807)	# 1000:25-31
	lfd	f1, 0(r31)	# 1000:25-31
	lfd	f2, 128(r3)	# 1000:10-22
	stfd	f0, 168(r3)	# 1000:10-22
	stfd	f1, 176(r3)	# 1000:10-22
	mflr	r31	# 1000:10-22
	fmr	f0, f2	# 1000:10-22
	stw	r31, 188(r3)	# 1000:10-22
	addi	r3, r3, 192	# 1000:10-22
	bl	min_caml_abs_float	# 1000:10-22
	subi	r3, r3, 192	# 1000:10-22
	lwz	r31, 188(r3)	# 1000:10-22
	mtlr	r31	# 1000:10-22
	lfd	f1, 176(r3)	# 999:5 - 1005:41
	fcmpu	cr7, f1, f0	# 1000:10-31
	bgt	cr7, ble_else.5881	# 999:5 - 1005:41
#	1003:9 - 1005:41
	lfd	f0, 128(r3)	# 1003:28-38
	lfd	f1, 152(r3)	# 1003:28-38
	fdiv	f0, f1, f0	# 1003:28-38
	mflr	r31	# 1003:9-38
	stw	r31, 188(r3)	# 1003:9-38
	addi	r3, r3, 192	# 1003:9-38
	bl	min_caml_abs_float	# 1003:9-38
	subi	r3, r3, 192	# 1003:9-38
	lwz	r31, 188(r3)	# 1003:9-38
	mtlr	r31	# 1003:9-38
	mflr	r31	# 1005:9-18
	stw	r31, 188(r3)	# 1005:9-18
	addi	r3, r3, 192	# 1005:9-18
	bl	min_caml_atan	# 1005:9-18
	subi	r3, r3, 192	# 1005:9-18
	lwz	r31, 188(r3)	# 1005:9-18
	mtlr	r31	# 1005:9-18
	lis	r31, ha16(l.4809)	# 1005:22-41
	addi	r31, r31, lo16(l.4809)	# 1005:22-41
	lfd	f1, 0(r31)	# 1005:22-41
	fmul	f0, f0, f1	# 1005:9-41
	b	ble_cont.5882
ble_else.5881:	# 1001:9-13
	lis	r31, ha16(l.4808)	# 1001:9-13
	addi	r31, r31, lo16(l.4808)	# 1001:9-13
	lfd	f0, 0(r31)	# 1001:9-13
ble_cont.5882:	# 999:5 - 1005:41
	stfd	f0, 184(r3)	# 1007:20-30
	mflr	r31	# 1007:20-30
	stw	r31, 196(r3)	# 1007:20-30
	addi	r3, r3, 200	# 1007:20-30
	bl	min_caml_floor	# 1007:20-30
	subi	r3, r3, 200	# 1007:20-30
	lwz	r31, 196(r3)	# 1007:20-30
	mtlr	r31	# 1007:20-30
	lfd	f1, 184(r3)	# 1007:5-30
	fsub	f0, f1, f0	# 1007:5-30
	lwz	r2, 0(r3)	# 1009:15-20
	lfd	f2, 8(r2)	# 1009:15-20
	lwz	r2, 4(r3)	# 1009:24-35
	stfd	f0, 192(r3)	# 1009:24-35
	stfd	f2, 200(r3)	# 1009:24-35
	mflr	r31	# 1009:24-35
	stw	r31, 212(r3)	# 1009:24-35
	addi	r3, r3, 216	# 1009:24-35
	bl	o_param_y.2002	# 1009:24-35
	subi	r3, r3, 216	# 1009:24-35
	lwz	r31, 212(r3)	# 1009:24-35
	mtlr	r31	# 1009:24-35
	lfd	f1, 200(r3)	# 1009:14-36
	fsub	f0, f1, f0	# 1009:14-36
	lwz	r2, 4(r3)	# 1009:46-59
	stfd	f0, 208(r3)	# 1009:46-59
	mflr	r31	# 1009:46-59
	stw	r31, 220(r3)	# 1009:46-59
	addi	r3, r3, 224	# 1009:46-59
	bl	o_param_b.1996	# 1009:46-59
	subi	r3, r3, 224	# 1009:46-59
	lwz	r31, 220(r3)	# 1009:46-59
	mtlr	r31	# 1009:46-59
	mflr	r31	# 1009:40-60
	stw	r31, 220(r3)	# 1009:40-60
	addi	r3, r3, 224	# 1009:40-60
	bl	min_caml_sqrt	# 1009:40-60
	subi	r3, r3, 224	# 1009:40-60
	lwz	r31, 220(r3)	# 1009:40-60
	mtlr	r31	# 1009:40-60
	lfd	f1, 208(r3)	# 1009:5-60
	fmul	f0, f1, f0	# 1009:5-60
	lis	r31, ha16(l.4807)	# 1011:25-31
	addi	r31, r31, lo16(l.4807)	# 1011:25-31
	lfd	f1, 0(r31)	# 1011:25-31
	lfd	f2, 184(r3)	# 1011:10-22
	stfd	f0, 216(r3)	# 1011:10-22
	stfd	f1, 224(r3)	# 1011:10-22
	mflr	r31	# 1011:10-22
	fmr	f0, f2	# 1011:10-22
	stw	r31, 236(r3)	# 1011:10-22
	addi	r3, r3, 240	# 1011:10-22
	bl	min_caml_abs_float	# 1011:10-22
	subi	r3, r3, 240	# 1011:10-22
	lwz	r31, 236(r3)	# 1011:10-22
	mtlr	r31	# 1011:10-22
	lfd	f1, 224(r3)	# 1010:5 - 1015:44
	fcmpu	cr7, f1, f0	# 1011:10-31
	bgt	cr7, ble_else.5883	# 1010:5 - 1015:44
#	1014:9 - 1015:44
	lfd	f0, 168(r3)	# 1014:28-38
	lfd	f1, 216(r3)	# 1014:28-38
	fdiv	f0, f1, f0	# 1014:28-38
	mflr	r31	# 1014:9-38
	stw	r31, 236(r3)	# 1014:9-38
	addi	r3, r3, 240	# 1014:9-38
	bl	min_caml_abs_float	# 1014:9-38
	subi	r3, r3, 240	# 1014:9-38
	lwz	r31, 236(r3)	# 1014:9-38
	mtlr	r31	# 1014:9-38
	mflr	r31	# 1015:12-21
	stw	r31, 236(r3)	# 1015:12-21
	addi	r3, r3, 240	# 1015:12-21
	bl	min_caml_atan	# 1015:12-21
	subi	r3, r3, 240	# 1015:12-21
	lwz	r31, 236(r3)	# 1015:12-21
	mtlr	r31	# 1015:12-21
	lis	r31, ha16(l.4809)	# 1015:25-44
	addi	r31, r31, lo16(l.4809)	# 1015:25-44
	lfd	f1, 0(r31)	# 1015:25-44
	fmul	f0, f0, f1	# 1015:12-44
	b	ble_cont.5884
ble_else.5883:	# 1012:9-13
	lis	r31, ha16(l.4808)	# 1012:9-13
	addi	r31, r31, lo16(l.4808)	# 1012:9-13
	lfd	f0, 0(r31)	# 1012:9-13
ble_cont.5884:	# 1010:5 - 1015:44
	stfd	f0, 232(r3)	# 1017:21-31
	mflr	r31	# 1017:21-31
	stw	r31, 244(r3)	# 1017:21-31
	addi	r3, r3, 248	# 1017:21-31
	bl	min_caml_floor	# 1017:21-31
	subi	r3, r3, 248	# 1017:21-31
	lwz	r31, 244(r3)	# 1017:21-31
	mtlr	r31	# 1017:21-31
	lfd	f1, 232(r3)	# 1017:5-31
	fsub	f0, f1, f0	# 1017:5-31
	lis	r31, ha16(l.4811)	# 1018:15-19
	addi	r31, r31, lo16(l.4811)	# 1018:15-19
	lfd	f1, 0(r31)	# 1018:15-19
	lis	r31, ha16(l.4812)	# 1018:30-33
	addi	r31, r31, lo16(l.4812)	# 1018:30-33
	lfd	f2, 0(r31)	# 1018:30-33
	lfd	f3, 192(r3)	# 1018:29-40
	fsub	f2, f2, f3	# 1018:29-40
	stfd	f0, 240(r3)	# 1018:23-41
	stfd	f1, 248(r3)	# 1018:23-41
	mflr	r31	# 1018:23-41
	fmr	f0, f2	# 1018:23-41
	stw	r31, 260(r3)	# 1018:23-41
	addi	r3, r3, 264	# 1018:23-41
	bl	fsqr.1980	# 1018:23-41
	subi	r3, r3, 264	# 1018:23-41
	lwz	r31, 260(r3)	# 1018:23-41
	mtlr	r31	# 1018:23-41
	lfd	f1, 248(r3)	# 1018:15-41
	fsub	f0, f1, f0	# 1018:15-41
	lis	r31, ha16(l.4812)	# 1018:52-55
	addi	r31, r31, lo16(l.4812)	# 1018:52-55
	lfd	f1, 0(r31)	# 1018:52-55
	lfd	f2, 240(r3)	# 1018:51-63
	fsub	f1, f1, f2	# 1018:51-63
	stfd	f0, 256(r3)	# 1018:45-64
	mflr	r31	# 1018:45-64
	fmr	f0, f1	# 1018:45-64
	stw	r31, 268(r3)	# 1018:45-64
	addi	r3, r3, 272	# 1018:45-64
	bl	fsqr.1980	# 1018:45-64
	subi	r3, r3, 272	# 1018:45-64
	lwz	r31, 268(r3)	# 1018:45-64
	mtlr	r31	# 1018:45-64
	lfd	f1, 256(r3)	# 1018:5-64
	fsub	f0, f1, f0	# 1018:5-64
	lis	r2, ha16(min_caml_texture_color)	# 1019:5-18
	addi	r2, r2, lo16(min_caml_texture_color)	# 1019:5-18
	lis	r31, ha16(l.4464)	# 1019:29-32
	addi	r31, r31, lo16(l.4464)	# 1019:29-32
	lfd	f1, 0(r31)	# 1019:29-32
	fcmpu	cr7, f0, f1	# 1019:29-39
	bgt	cr7, ble_else.5885	# 1019:26-75
#	1019:45-48
	lis	r31, ha16(l.4464)	# 1019:45-48
	addi	r31, r31, lo16(l.4464)	# 1019:45-48
	lfd	f0, 0(r31)	# 1019:45-48
	b	ble_cont.5886
ble_else.5885:	# 1019:54-75
	lis	r31, ha16(l.4813)	# 1019:61-75
	addi	r31, r31, lo16(l.4813)	# 1019:61-75
	lfd	f1, 0(r31)	# 1019:61-75
	fmul	f0, f0, f1	# 1019:54-75
ble_cont.5886:	# 1019:26-75
	stfd	f0, 16(r2)	# 1019:5-75
	blr	# 1019:5-75
beq_else.5880:	# 1021:8-10
	blr	# 1021:8-10
in_prod.2121:	# 1031:12 - 1033:59
	lfd	f0, 0(r2)	# 1033:3-9
	lfd	f1, 0(r5)	# 1033:13-19
	fmul	f0, f0, f1	# 1033:3-19
	lfd	f1, 8(r2)	# 1033:23-29
	lfd	f2, 8(r5)	# 1033:33-39
	fmul	f1, f1, f2	# 1033:23-39
	fadd	f0, f0, f1	# 1033:3-39
	lfd	f1, 16(r2)	# 1033:43-49
	lfd	f2, 16(r5)	# 1033:53-59
	fmul	f1, f1, f2	# 1033:43-59
	fadd	f0, f0, f1	# 1033:3-59
	blr	# 1033:3-59
accumulate_vec_mul.2124:	# 1037:12 - 1041:34
	lfd	f1, 0(r2)	# 1039:13-19
	lfd	f2, 0(r5)	# 1039:28-34
	fmul	f2, f0, f2	# 1039:23-34
	fadd	f1, f1, f2	# 1039:13-34
	stfd	f1, 0(r2)	# 1039:3-34
	lfd	f1, 8(r2)	# 1040:13-19
	lfd	f2, 8(r5)	# 1040:28-34
	fmul	f2, f0, f2	# 1040:23-34
	fadd	f1, f1, f2	# 1040:13-34
	stfd	f1, 8(r2)	# 1040:3-34
	lfd	f1, 16(r2)	# 1041:13-19
	lfd	f2, 16(r5)	# 1041:28-34
	fmul	f0, f0, f2	# 1041:23-34
	fadd	f0, f1, f0	# 1041:13-34
	stfd	f0, 16(r2)	# 1041:3-34
	blr	# 1041:3-34
raytracing.2128:	# 1044:12 - 1128:10
	lis	r5, ha16(min_caml_viewpoint)	# 1046:26-35
	addi	r5, r5, lo16(min_caml_viewpoint)	# 1046:26-35
	lis	r6, ha16(min_caml_vscan)	# 1046:36-41
	addi	r6, r6, lo16(min_caml_vscan)	# 1046:36-41
	stfd	f0, 0(r3)	# 1046:19-41
	stw	r2, 8(r3)	# 1046:19-41
	mflr	r31	# 1046:3-41
	mr	r2, r5	# 1046:3-41
	mr	r5, r6	# 1046:3-41
	stw	r31, 12(r3)	# 1046:3-41
	addi	r3, r3, 16	# 1046:3-41
	bl	tracer.2102	# 1046:3-41
	subi	r3, r3, 16	# 1046:3-41
	lwz	r31, 12(r3)	# 1046:3-41
	mtlr	r31	# 1046:3-41
	stw	r2, 12(r3)	# 1050:3 - 1066:10
	cmpwi	cr7, r2, 0	# 1050:3 - 1066:10
	bne	cr7, beq_else.5890	# 1050:3 - 1066:10
#	1051:5 - 1065:12
	lwz	r5, 8(r3)	# 1051:5 - 1065:12
	cmpwi	cr7, r5, 0	# 1051:8-17
	bne	cr7, beq_else.5892	# 1051:5 - 1065:12
#	1065:10-12
	b	beq_cont.5893
beq_else.5892:	# 1052:7 - 1064:9
	lis	r6, ha16(min_caml_vscan)	# 1053:29-34
	addi	r6, r6, lo16(min_caml_vscan)	# 1053:29-34
	lis	r7, ha16(min_caml_light)	# 1053:35-40
	addi	r7, r7, lo16(min_caml_light)	# 1053:35-40
	mflr	r31	# 1053:20-41
	mr	r5, r7	# 1053:20-41
	mr	r2, r6	# 1053:20-41
	stw	r31, 20(r3)	# 1053:20-41
	addi	r3, r3, 24	# 1053:20-41
	bl	in_prod.2121	# 1053:20-41
	subi	r3, r3, 24	# 1053:20-41
	lwz	r31, 20(r3)	# 1053:20-41
	mtlr	r31	# 1053:20-41
	fneg	f0, f0	# 1053:9-41
	lis	r31, ha16(l.4464)	# 1055:12-15
	addi	r31, r31, lo16(l.4464)	# 1055:12-15
	lfd	f1, 0(r31)	# 1055:12-15
	fcmpu	cr7, f0, f1	# 1055:12-20
	bgt	cr7, ble_else.5894	# 1055:9 - 1063:16
#	1063:14-16
	b	ble_cont.5895
ble_else.5894:	# 1056:11 - 1062:12
	stfd	f0, 16(r3)	# 1058:22-29
	mflr	r31	# 1058:22-29
	stw	r31, 28(r3)	# 1058:22-29
	addi	r3, r3, 32	# 1058:22-29
	bl	fsqr.1980	# 1058:22-29
	subi	r3, r3, 32	# 1058:22-29
	lwz	r31, 28(r3)	# 1058:22-29
	mtlr	r31	# 1058:22-29
	lfd	f1, 16(r3)	# 1058:22-35
	fmul	f0, f0, f1	# 1058:22-35
	lfd	f1, 0(r3)	# 1058:22-45
	fmul	f0, f0, f1	# 1058:22-45
	lis	r2, ha16(min_caml_beam)	# 1058:49-53
	addi	r2, r2, lo16(min_caml_beam)	# 1058:49-53
	lfd	f2, 0(r2)	# 1058:49-57
	fmul	f0, f0, f2	# 1058:12-57
	lis	r2, ha16(min_caml_rgb)	# 1059:12-15
	addi	r2, r2, lo16(min_caml_rgb)	# 1059:12-15
	lis	r5, ha16(min_caml_rgb)	# 1059:23-26
	addi	r5, r5, lo16(min_caml_rgb)	# 1059:23-26
	lfd	f2, 0(r5)	# 1059:23-30
	fadd	f2, f2, f0	# 1059:23-37
	stfd	f2, 0(r2)	# 1059:12-37
	lis	r2, ha16(min_caml_rgb)	# 1060:12-15
	addi	r2, r2, lo16(min_caml_rgb)	# 1060:12-15
	lis	r5, ha16(min_caml_rgb)	# 1060:23-26
	addi	r5, r5, lo16(min_caml_rgb)	# 1060:23-26
	lfd	f2, 8(r5)	# 1060:23-30
	fadd	f2, f2, f0	# 1060:23-37
	stfd	f2, 8(r2)	# 1060:12-37
	lis	r2, ha16(min_caml_rgb)	# 1061:12-15
	addi	r2, r2, lo16(min_caml_rgb)	# 1061:12-15
	lis	r5, ha16(min_caml_rgb)	# 1061:23-26
	addi	r5, r5, lo16(min_caml_rgb)	# 1061:23-26
	lfd	f2, 16(r5)	# 1061:23-30
	fadd	f0, f2, f0	# 1061:23-37
	stfd	f0, 16(r2)	# 1061:12-37
ble_cont.5895:	# 1055:9 - 1063:16
beq_cont.5893:	# 1051:5 - 1065:12
	b	beq_cont.5891
beq_else.5890:	# 1066:8-10
beq_cont.5891:	# 1050:3 - 1066:10
	lwz	r2, 12(r3)	# 1068:3 - 1128:10
	cmpwi	cr7, r2, 0	# 1068:3 - 1128:10
	bne	cr7, beq_else.5896	# 1068:3 - 1128:10
#	1128:8-10
	blr	# 1128:8-10
beq_else.5896:	# 1070:5 - 1127:7
	lis	r2, ha16(min_caml_objects)	# 1072:18-25
	addi	r2, r2, lo16(min_caml_objects)	# 1072:18-25
	lis	r5, ha16(min_caml_crashed_object)	# 1072:27-41
	addi	r5, r5, lo16(min_caml_crashed_object)	# 1072:27-41
	lwz	r5, 0(r5)	# 1072:27-45
	slwi	r5, r5, 2	# 1072:18-46
	lwzx	r2, r2, r5	# 1072:7-46
	lis	r5, ha16(min_caml_crashed_point)	# 1073:24-37
	addi	r5, r5, lo16(min_caml_crashed_point)	# 1073:24-37
	stw	r2, 24(r3)	# 1073:7-37
	mflr	r31	# 1073:7-37
	stw	r31, 28(r3)	# 1073:7-37
	addi	r3, r3, 32	# 1073:7-37
	bl	get_nvector.2115	# 1073:7-37
	subi	r3, r3, 32	# 1073:7-37
	lwz	r31, 28(r3)	# 1073:7-37
	mtlr	r31	# 1073:7-37
	li	r2, 0	# 1075:40-41
	lis	r5, ha16(min_caml_or_net)	# 1075:42-48
	addi	r5, r5, lo16(min_caml_or_net)	# 1075:42-48
	lwz	r5, 0(r5)	# 1075:42-52
	lis	r6, ha16(min_caml_crashed_point)	# 1075:53-66
	addi	r6, r6, lo16(min_caml_crashed_point)	# 1075:53-66
	mflr	r31	# 1075:12-67
	stw	r31, 28(r3)	# 1075:12-67
	addi	r3, r3, 32	# 1075:12-67
	bl	shadow_check_one_or_matrix.2089	# 1075:12-67
	subi	r3, r3, 32	# 1075:12-67
	lwz	r31, 28(r3)	# 1075:12-67
	mtlr	r31	# 1075:12-67
	cmpwi	cr7, r2, 0	# 1075:9 - 1082:11
	bne	cr7, beq_else.5898	# 1074:7 - 1082:11
#	1078:14 - 1082:11
	lis	r2, ha16(min_caml_nvector)	# 1079:31-38
	addi	r2, r2, lo16(min_caml_nvector)	# 1079:31-38
	lis	r5, ha16(min_caml_light)	# 1079:39-44
	addi	r5, r5, lo16(min_caml_light)	# 1079:39-44
	mflr	r31	# 1079:22-45
	stw	r31, 28(r3)	# 1079:22-45
	addi	r3, r3, 32	# 1079:22-45
	bl	in_prod.2121	# 1079:22-45
	subi	r3, r3, 32	# 1079:22-45
	lwz	r31, 28(r3)	# 1079:22-45
	mtlr	r31	# 1079:22-45
	fneg	f0, f0	# 1079:11-45
	lis	r31, ha16(l.4464)	# 1080:24-27
	addi	r31, r31, lo16(l.4464)	# 1080:24-27
	lfd	f1, 0(r31)	# 1080:24-27
	fcmpu	cr7, f1, f0	# 1080:24-32
	bgt	cr7, ble_else.5900	# 1080:11-56
#	1080:47-56
	lis	r31, ha16(l.4856)	# 1080:53-56
	addi	r31, r31, lo16(l.4856)	# 1080:53-56
	lfd	f1, 0(r31)	# 1080:53-56
	fadd	f0, f0, f1	# 1080:47-56
	b	ble_cont.5901
ble_else.5900:	# 1080:38-41
	lis	r31, ha16(l.4856)	# 1080:38-41
	addi	r31, r31, lo16(l.4856)	# 1080:38-41
	lfd	f0, 0(r31)	# 1080:38-41
ble_cont.5901:	# 1080:11-56
	lfd	f1, 0(r3)	# 1081:11-24
	fmul	f0, f0, f1	# 1081:11-24
	lwz	r2, 24(r3)	# 1081:28-42
	stfd	f0, 32(r3)	# 1081:28-42
	mflr	r31	# 1081:28-42
	stw	r31, 44(r3)	# 1081:28-42
	addi	r3, r3, 48	# 1081:28-42
	bl	o_diffuse.2006	# 1081:28-42
	subi	r3, r3, 48	# 1081:28-42
	lwz	r31, 44(r3)	# 1081:28-42
	mtlr	r31	# 1081:28-42
	lfd	f1, 32(r3)	# 1081:11-42
	fmul	f0, f1, f0	# 1081:11-42
	b	beq_cont.5899
beq_else.5898:	# 1077:11-14
	lis	r31, ha16(l.4464)	# 1077:11-14
	addi	r31, r31, lo16(l.4464)	# 1077:11-14
	lfd	f0, 0(r31)	# 1077:11-14
beq_cont.5899:	# 1074:7 - 1082:11
	lis	r5, ha16(min_caml_crashed_point)	# 1084:21-34
	addi	r5, r5, lo16(min_caml_crashed_point)	# 1084:21-34
	lwz	r2, 24(r3)	# 1084:7-34
	stfd	f0, 40(r3)	# 1084:7-34
	mflr	r31	# 1084:7-34
	stw	r31, 52(r3)	# 1084:7-34
	addi	r3, r3, 56	# 1084:7-34
	bl	utexture.2118	# 1084:7-34
	subi	r3, r3, 56	# 1084:7-34
	lwz	r31, 52(r3)	# 1084:7-34
	mtlr	r31	# 1084:7-34
	lis	r2, ha16(min_caml_rgb)	# 1085:26-29
	addi	r2, r2, lo16(min_caml_rgb)	# 1085:26-29
	lis	r5, ha16(min_caml_texture_color)	# 1085:30-43
	addi	r5, r5, lo16(min_caml_texture_color)	# 1085:30-43
	lfd	f0, 40(r3)	# 1085:7-50
	mflr	r31	# 1085:7-50
	stw	r31, 52(r3)	# 1085:7-50
	addi	r3, r3, 56	# 1085:7-50
	bl	accumulate_vec_mul.2124	# 1085:7-50
	subi	r3, r3, 56	# 1085:7-50
	lwz	r31, 52(r3)	# 1085:7-50
	mtlr	r31	# 1085:7-50
	lwz	r2, 8(r3)	# 1087:7 - 1126:14
	cmpwi	cr7, r2, 4	# 1087:10-18
	bgt	cr7, ble_else.5903	# 1087:7 - 1126:14
#	1088:7 - 1126:14
	lis	r31, ha16(l.4857)	# 1088:10-13
	addi	r31, r31, lo16(l.4857)	# 1088:10-13
	lfd	f0, 0(r31)	# 1088:10-13
	lfd	f1, 0(r3)	# 1088:7 - 1126:14
	fcmpu	cr7, f1, f0	# 1088:10-22
	bgt	cr7, ble_else.5904	# 1088:7 - 1126:14
#	1126:12-14
	blr	# 1126:12-14
ble_else.5904:	# 1089:9 - 1125:11
	lis	r31, ha16(l.4858)	# 1091:19-25
	addi	r31, r31, lo16(l.4858)	# 1091:19-25
	lfd	f0, 0(r31)	# 1091:19-25
	lis	r5, ha16(min_caml_vscan)	# 1091:37-42
	addi	r5, r5, lo16(min_caml_vscan)	# 1091:37-42
	lis	r6, ha16(min_caml_nvector)	# 1091:43-50
	addi	r6, r6, lo16(min_caml_nvector)	# 1091:43-50
	stfd	f0, 48(r3)	# 1091:29-50
	mflr	r31	# 1091:29-50
	mr	r2, r5	# 1091:29-50
	mr	r5, r6	# 1091:29-50
	stw	r31, 60(r3)	# 1091:29-50
	addi	r3, r3, 64	# 1091:29-50
	bl	in_prod.2121	# 1091:29-50
	subi	r3, r3, 64	# 1091:29-50
	lwz	r31, 60(r3)	# 1091:29-50
	mtlr	r31	# 1091:29-50
	lfd	f1, 48(r3)	# 1091:11-50
	fmul	f0, f1, f0	# 1091:11-50
	lis	r2, ha16(min_caml_vscan)	# 1093:30-35
	addi	r2, r2, lo16(min_caml_vscan)	# 1093:30-35
	lis	r5, ha16(min_caml_nvector)	# 1093:36-43
	addi	r5, r5, lo16(min_caml_nvector)	# 1093:36-43
	mflr	r31	# 1093:11-45
	stw	r31, 60(r3)	# 1093:11-45
	addi	r3, r3, 64	# 1093:11-45
	bl	accumulate_vec_mul.2124	# 1093:11-45
	subi	r3, r3, 64	# 1093:11-45
	lwz	r31, 60(r3)	# 1093:11-45
	mtlr	r31	# 1093:11-45
	lwz	r2, 24(r3)	# 1095:11-48
	mflr	r31	# 1095:11-48
	stw	r31, 60(r3)	# 1095:11-48
	addi	r3, r3, 64	# 1095:11-48
	bl	o_reflectiontype.1988	# 1095:11-48
	subi	r3, r3, 64	# 1095:11-48
	lwz	r31, 60(r3)	# 1095:11-48
	mtlr	r31	# 1095:11-48
	cmpwi	cr7, r2, 1	# 1096:14-27
	bne	cr7, beq_else.5906	# 1096:11 - 1124:18
#	1098:13 - 1114:14
	lis	r31, ha16(l.4464)	# 1099:17-20
	addi	r31, r31, lo16(l.4464)	# 1099:17-20
	lfd	f0, 0(r31)	# 1099:17-20
	lwz	r2, 24(r3)	# 1099:23-39
	stfd	f0, 56(r3)	# 1099:23-39
	mflr	r31	# 1099:23-39
	stw	r31, 68(r3)	# 1099:23-39
	addi	r3, r3, 72	# 1099:23-39
	bl	o_hilight.2008	# 1099:23-39
	subi	r3, r3, 72	# 1099:23-39
	lwz	r31, 68(r3)	# 1099:23-39
	mtlr	r31	# 1099:23-39
	lfd	f1, 56(r3)	# 1098:13 - 1114:14
	fcmpu	cr7, f1, f0	# 1099:17-39
	bne	cr7, beq_else.5907	# 1098:13 - 1114:14
#	1100:16-18
	blr	# 1100:16-18
beq_else.5907:	# 1102:16 - 1113:23
	lis	r2, ha16(min_caml_vscan)	# 1102:36-41
	addi	r2, r2, lo16(min_caml_vscan)	# 1102:36-41
	lis	r5, ha16(min_caml_light)	# 1102:42-47
	addi	r5, r5, lo16(min_caml_light)	# 1102:42-47
	mflr	r31	# 1102:27-48
	stw	r31, 68(r3)	# 1102:27-48
	addi	r3, r3, 72	# 1102:27-48
	bl	in_prod.2121	# 1102:27-48
	subi	r3, r3, 72	# 1102:27-48
	lwz	r31, 68(r3)	# 1102:27-48
	mtlr	r31	# 1102:27-48
	fneg	f0, f0	# 1102:16-48
	lis	r31, ha16(l.4464)	# 1103:19-22
	addi	r31, r31, lo16(l.4464)	# 1103:19-22
	lfd	f1, 0(r31)	# 1103:19-22
	fcmpu	cr7, f0, f1	# 1103:19-27
	bgt	cr7, ble_else.5909	# 1103:16 - 1113:23
#	1113:21-23
	blr	# 1113:21-23
ble_else.5909:	# 1104:18 - 1112:20
	mflr	r31	# 1106:27-36
	stw	r31, 68(r3)	# 1106:27-36
	addi	r3, r3, 72	# 1106:27-36
	bl	fsqr.1980	# 1106:27-36
	subi	r3, r3, 72	# 1106:27-36
	lwz	r31, 68(r3)	# 1106:27-36
	mtlr	r31	# 1106:27-36
	mflr	r31	# 1106:22-36
	stw	r31, 68(r3)	# 1106:22-36
	addi	r3, r3, 72	# 1106:22-36
	bl	fsqr.1980	# 1106:22-36
	subi	r3, r3, 72	# 1106:22-36
	lwz	r31, 68(r3)	# 1106:22-36
	mtlr	r31	# 1106:22-36
	lfd	f1, 0(r3)	# 1106:22-46
	fmul	f0, f0, f1	# 1106:22-46
	lfd	f1, 40(r3)	# 1106:22-56
	fmul	f0, f0, f1	# 1106:22-56
	lwz	r2, 24(r3)	# 1107:27-41
	stfd	f0, 64(r3)	# 1107:27-41
	mflr	r31	# 1107:27-41
	stw	r31, 76(r3)	# 1107:27-41
	addi	r3, r3, 80	# 1107:27-41
	bl	o_hilight.2008	# 1107:27-41
	subi	r3, r3, 80	# 1107:27-41
	lwz	r31, 76(r3)	# 1107:27-41
	mtlr	r31	# 1107:27-41
	lfd	f1, 64(r3)	# 1105:20 - 1107:41
	fmul	f0, f1, f0	# 1105:20 - 1107:41
	lis	r2, ha16(min_caml_rgb)	# 1109:20-23
	addi	r2, r2, lo16(min_caml_rgb)	# 1109:20-23
	lis	r5, ha16(min_caml_rgb)	# 1109:31-34
	addi	r5, r5, lo16(min_caml_rgb)	# 1109:31-34
	lfd	f1, 0(r5)	# 1109:31-38
	fadd	f1, f1, f0	# 1109:31-45
	stfd	f1, 0(r2)	# 1109:20-45
	lis	r2, ha16(min_caml_rgb)	# 1110:20-23
	addi	r2, r2, lo16(min_caml_rgb)	# 1110:20-23
	lis	r5, ha16(min_caml_rgb)	# 1110:31-34
	addi	r5, r5, lo16(min_caml_rgb)	# 1110:31-34
	lfd	f1, 8(r5)	# 1110:31-38
	fadd	f1, f1, f0	# 1110:31-45
	stfd	f1, 8(r2)	# 1110:20-45
	lis	r2, ha16(min_caml_rgb)	# 1111:20-23
	addi	r2, r2, lo16(min_caml_rgb)	# 1111:20-23
	lis	r5, ha16(min_caml_rgb)	# 1111:31-34
	addi	r5, r5, lo16(min_caml_rgb)	# 1111:31-34
	lfd	f1, 16(r5)	# 1111:31-38
	fadd	f0, f1, f0	# 1111:31-45
	stfd	f0, 16(r2)	# 1111:20-45
	blr	# 1111:20-45
beq_else.5906:	# 1115:16 - 1124:18
	cmpwi	cr7, r2, 2	# 1115:19-32
	bne	cr7, beq_else.5912	# 1115:16 - 1124:18
#	1117:13 - 1123:15
	lis	r2, ha16(min_caml_viewpoint)	# 1118:15-24
	addi	r2, r2, lo16(min_caml_viewpoint)	# 1118:15-24
	lis	r5, ha16(min_caml_crashed_point)	# 1118:32-45
	addi	r5, r5, lo16(min_caml_crashed_point)	# 1118:32-45
	lfd	f0, 0(r5)	# 1118:32-49
	stfd	f0, 0(r2)	# 1118:15-49
	lis	r2, ha16(min_caml_viewpoint)	# 1119:15-24
	addi	r2, r2, lo16(min_caml_viewpoint)	# 1119:15-24
	lis	r5, ha16(min_caml_crashed_point)	# 1119:32-45
	addi	r5, r5, lo16(min_caml_crashed_point)	# 1119:32-45
	lfd	f0, 8(r5)	# 1119:32-49
	stfd	f0, 8(r2)	# 1119:15-49
	lis	r2, ha16(min_caml_viewpoint)	# 1120:15-24
	addi	r2, r2, lo16(min_caml_viewpoint)	# 1120:15-24
	lis	r5, ha16(min_caml_crashed_point)	# 1120:32-45
	addi	r5, r5, lo16(min_caml_crashed_point)	# 1120:32-45
	lfd	f0, 16(r5)	# 1120:32-49
	stfd	f0, 16(r2)	# 1120:15-49
	lis	r31, ha16(l.4465)	# 1121:40-43
	addi	r31, r31, lo16(l.4465)	# 1121:40-43
	lfd	f0, 0(r31)	# 1121:40-43
	lwz	r2, 24(r3)	# 1121:47-61
	stfd	f0, 72(r3)	# 1121:47-61
	mflr	r31	# 1121:47-61
	stw	r31, 84(r3)	# 1121:47-61
	addi	r3, r3, 88	# 1121:47-61
	bl	o_diffuse.2006	# 1121:47-61
	subi	r3, r3, 88	# 1121:47-61
	lwz	r31, 84(r3)	# 1121:47-61
	mtlr	r31	# 1121:47-61
	lfd	f1, 72(r3)	# 1121:39-62
	fsub	f0, f1, f0	# 1121:39-62
	lfd	f1, 0(r3)	# 1121:15-62
	fmul	f0, f1, f0	# 1121:15-62
	lwz	r2, 8(r3)	# 1122:26-36
	addi	r2, r2, 1	# 1122:26-36
	b	raytracing.2128	# 1122:15-44
beq_else.5912:	# 1124:16-18
	blr	# 1124:16-18
ble_else.5903:	# 1087:24-26
	blr	# 1087:24-26
write_rgb.2131:	# 1132:12 - 1146:4
	lis	r2, ha16(min_caml_rgb)	# 1135:27-30
	addi	r2, r2, lo16(min_caml_rgb)	# 1135:27-30
	lfd	f0, 0(r2)	# 1135:27-34
	mflr	r31	# 1135:4-34
	stw	r31, 4(r3)	# 1135:4-34
	addi	r3, r3, 8	# 1135:4-34
	bl	min_caml_int_of_float	# 1135:4-34
	subi	r3, r3, 8	# 1135:4-34
	lwz	r31, 4(r3)	# 1135:4-34
	mtlr	r31	# 1135:4-34
	cmpwi	cr7, r2, 255	# 1136:17-26
	bgt	cr7, ble_else.5915	# 1136:4-44
#	1136:41-44
	b	ble_cont.5916
ble_else.5915:	# 1136:32-35
	li	r2, 255	# 1136:32-35
ble_cont.5916:	# 1136:4-44
	mflr	r31	# 1137:4-18
	stw	r31, 4(r3)	# 1137:4-18
	addi	r3, r3, 8	# 1137:4-18
	bl	min_caml_print_byte	# 1137:4-18
	subi	r3, r3, 8	# 1137:4-18
	lwz	r31, 4(r3)	# 1137:4-18
	mtlr	r31	# 1137:4-18
	lis	r2, ha16(min_caml_rgb)	# 1139:29-32
	addi	r2, r2, lo16(min_caml_rgb)	# 1139:29-32
	lfd	f0, 8(r2)	# 1139:29-36
	mflr	r31	# 1139:4-36
	stw	r31, 4(r3)	# 1139:4-36
	addi	r3, r3, 8	# 1139:4-36
	bl	min_caml_int_of_float	# 1139:4-36
	subi	r3, r3, 8	# 1139:4-36
	lwz	r31, 4(r3)	# 1139:4-36
	mtlr	r31	# 1139:4-36
	cmpwi	cr7, r2, 255	# 1140:19-30
	bgt	cr7, ble_else.5917	# 1140:4-50
#	1140:45-50
	b	ble_cont.5918
ble_else.5917:	# 1140:36-39
	li	r2, 255	# 1140:36-39
ble_cont.5918:	# 1140:4-50
	mflr	r31	# 1141:4-20
	stw	r31, 4(r3)	# 1141:4-20
	addi	r3, r3, 8	# 1141:4-20
	bl	min_caml_print_byte	# 1141:4-20
	subi	r3, r3, 8	# 1141:4-20
	lwz	r31, 4(r3)	# 1141:4-20
	mtlr	r31	# 1141:4-20
	lis	r2, ha16(min_caml_rgb)	# 1143:28-31
	addi	r2, r2, lo16(min_caml_rgb)	# 1143:28-31
	lfd	f0, 16(r2)	# 1143:28-35
	mflr	r31	# 1143:4-35
	stw	r31, 4(r3)	# 1143:4-35
	addi	r3, r3, 8	# 1143:4-35
	bl	min_caml_int_of_float	# 1143:4-35
	subi	r3, r3, 8	# 1143:4-35
	lwz	r31, 4(r3)	# 1143:4-35
	mtlr	r31	# 1143:4-35
	cmpwi	cr7, r2, 255	# 1144:18-28
	bgt	cr7, ble_else.5919	# 1144:4-47
#	1144:43-47
	b	ble_cont.5920
ble_else.5919:	# 1144:34-37
	li	r2, 255	# 1144:34-37
ble_cont.5920:	# 1144:4-47
	b	min_caml_print_byte	# 1145:4-19
write_ppm_header.2133:	# 1149:12 - 1161:4
	li	r2, 80	# 1152:16-18
	mflr	r31	# 1152:5-18
	stw	r31, 4(r3)	# 1152:5-18
	addi	r3, r3, 8	# 1152:5-18
	bl	min_caml_print_byte	# 1152:5-18
	subi	r3, r3, 8	# 1152:5-18
	lwz	r31, 4(r3)	# 1152:5-18
	mtlr	r31	# 1152:5-18
	li	r2, 54	# 1153:16-24
	mflr	r31	# 1153:5-24
	stw	r31, 4(r3)	# 1153:5-24
	addi	r3, r3, 8	# 1153:5-24
	bl	min_caml_print_byte	# 1153:5-24
	subi	r3, r3, 8	# 1153:5-24
	lwz	r31, 4(r3)	# 1153:5-24
	mtlr	r31	# 1153:5-24
	li	r2, 10	# 1154:16-18
	mflr	r31	# 1154:5-18
	stw	r31, 4(r3)	# 1154:5-18
	addi	r3, r3, 8	# 1154:5-18
	bl	min_caml_print_byte	# 1154:5-18
	subi	r3, r3, 8	# 1154:5-18
	lwz	r31, 4(r3)	# 1154:5-18
	mtlr	r31	# 1154:5-18
	lis	r2, ha16(min_caml_size)	# 1155:15-19
	addi	r2, r2, lo16(min_caml_size)	# 1155:15-19
	lwz	r2, 0(r2)	# 1155:15-23
	mflr	r31	# 1155:5-23
	stw	r31, 4(r3)	# 1155:5-23
	addi	r3, r3, 8	# 1155:5-23
	bl	min_caml_print_int	# 1155:5-23
	subi	r3, r3, 8	# 1155:5-23
	lwz	r31, 4(r3)	# 1155:5-23
	mtlr	r31	# 1155:5-23
	li	r2, 32	# 1156:16-18
	mflr	r31	# 1156:5-18
	stw	r31, 4(r3)	# 1156:5-18
	addi	r3, r3, 8	# 1156:5-18
	bl	min_caml_print_byte	# 1156:5-18
	subi	r3, r3, 8	# 1156:5-18
	lwz	r31, 4(r3)	# 1156:5-18
	mtlr	r31	# 1156:5-18
	lis	r2, ha16(min_caml_size)	# 1157:15-19
	addi	r2, r2, lo16(min_caml_size)	# 1157:15-19
	lwz	r2, 4(r2)	# 1157:15-23
	mflr	r31	# 1157:5-23
	stw	r31, 4(r3)	# 1157:5-23
	addi	r3, r3, 8	# 1157:5-23
	bl	min_caml_print_int	# 1157:5-23
	subi	r3, r3, 8	# 1157:5-23
	lwz	r31, 4(r3)	# 1157:5-23
	mtlr	r31	# 1157:5-23
	li	r2, 10	# 1158:16-18
	mflr	r31	# 1158:5-18
	stw	r31, 4(r3)	# 1158:5-18
	addi	r3, r3, 8	# 1158:5-18
	bl	min_caml_print_byte	# 1158:5-18
	subi	r3, r3, 8	# 1158:5-18
	lwz	r31, 4(r3)	# 1158:5-18
	mtlr	r31	# 1158:5-18
	li	r2, 255	# 1159:15-18
	mflr	r31	# 1159:5-18
	stw	r31, 4(r3)	# 1159:5-18
	addi	r3, r3, 8	# 1159:5-18
	bl	min_caml_print_int	# 1159:5-18
	subi	r3, r3, 8	# 1159:5-18
	lwz	r31, 4(r3)	# 1159:5-18
	mtlr	r31	# 1159:5-18
	li	r2, 10	# 1160:16-18
	b	min_caml_print_byte	# 1160:5-18
scan_point.2135:	# 1165:12 - 1199:4
	lis	r5, ha16(min_caml_size)	# 1167:15-19
	addi	r5, r5, lo16(min_caml_size)	# 1167:15-19
	lwz	r5, 0(r5)	# 1167:15-23
	cmpw	cr7, r5, r2	# 1167:6-23
	bgt	cr7, ble_else.5921	# 1167:3 - 1199:4
#	1167:29-31
	blr	# 1167:29-31
ble_else.5921:	# 1168:3 - 1199:4
	stw	r2, 0(r3)	# 1170:19-37
	mflr	r31	# 1170:19-37
	stw	r31, 4(r3)	# 1170:19-37
	addi	r3, r3, 8	# 1170:19-37
	bl	min_caml_float_of_int	# 1170:19-37
	subi	r3, r3, 8	# 1170:19-37
	lwz	r31, 4(r3)	# 1170:19-37
	mtlr	r31	# 1170:19-37
	lis	r2, ha16(min_caml_scan_offset)	# 1170:41-52
	addi	r2, r2, lo16(min_caml_scan_offset)	# 1170:41-52
	lfd	f1, 0(r2)	# 1170:41-56
	fsub	f0, f0, f1	# 1170:18-57
	lis	r2, ha16(min_caml_scan_d)	# 1170:61-67
	addi	r2, r2, lo16(min_caml_scan_d)	# 1170:61-67
	lfd	f1, 0(r2)	# 1170:61-71
	fmul	f0, f0, f1	# 1170:5-71
	lis	r2, ha16(min_caml_vscan)	# 1172:5-10
	addi	r2, r2, lo16(min_caml_vscan)	# 1172:5-10
	lis	r5, ha16(min_caml_cos_v)	# 1172:29-34
	addi	r5, r5, lo16(min_caml_cos_v)	# 1172:29-34
	lfd	f1, 8(r5)	# 1172:29-38
	fmul	f1, f0, f1	# 1172:19-38
	lis	r5, ha16(min_caml_wscan)	# 1172:42-47
	addi	r5, r5, lo16(min_caml_wscan)	# 1172:42-47
	lfd	f2, 0(r5)	# 1172:42-51
	fadd	f1, f1, f2	# 1172:18-52
	stfd	f1, 0(r2)	# 1172:5-52
	lis	r2, ha16(min_caml_vscan)	# 1173:5-10
	addi	r2, r2, lo16(min_caml_vscan)	# 1173:5-10
	lis	r5, ha16(min_caml_scan_sscany)	# 1173:19-30
	addi	r5, r5, lo16(min_caml_scan_sscany)	# 1173:19-30
	lfd	f1, 0(r5)	# 1173:19-34
	lis	r5, ha16(min_caml_cos_v)	# 1173:38-43
	addi	r5, r5, lo16(min_caml_cos_v)	# 1173:38-43
	lfd	f2, 0(r5)	# 1173:38-47
	fmul	f1, f1, f2	# 1173:19-47
	lis	r5, ha16(min_caml_vp)	# 1173:51-53
	addi	r5, r5, lo16(min_caml_vp)	# 1173:51-53
	lfd	f2, 8(r5)	# 1173:51-57
	fsub	f1, f1, f2	# 1173:18-58
	stfd	f1, 8(r2)	# 1173:5-58
	lis	r2, ha16(min_caml_vscan)	# 1174:5-10
	addi	r2, r2, lo16(min_caml_vscan)	# 1174:5-10
	fneg	f1, f0	# 1174:19-27
	lis	r5, ha16(min_caml_sin_v)	# 1174:31-36
	addi	r5, r5, lo16(min_caml_sin_v)	# 1174:31-36
	lfd	f2, 8(r5)	# 1174:31-40
	fmul	f1, f1, f2	# 1174:19-40
	lis	r5, ha16(min_caml_wscan)	# 1174:44-49
	addi	r5, r5, lo16(min_caml_wscan)	# 1174:44-49
	lfd	f2, 16(r5)	# 1174:44-53
	fadd	f1, f1, f2	# 1174:18-54
	stfd	f1, 16(r2)	# 1174:5-54
	mflr	r31	# 1177:24-37
	stw	r31, 4(r3)	# 1177:24-37
	addi	r3, r3, 8	# 1177:24-37
	bl	fsqr.1980	# 1177:24-37
	subi	r3, r3, 8	# 1177:24-37
	lwz	r31, 4(r3)	# 1177:24-37
	mtlr	r31	# 1177:24-37
	lis	r2, ha16(min_caml_scan_met1)	# 1177:41-50
	addi	r2, r2, lo16(min_caml_scan_met1)	# 1177:41-50
	lfd	f1, 0(r2)	# 1177:41-54
	fadd	f0, f0, f1	# 1177:23-55
	mflr	r31	# 1177:5-55
	stw	r31, 4(r3)	# 1177:5-55
	addi	r3, r3, 8	# 1177:5-55
	bl	min_caml_sqrt	# 1177:5-55
	subi	r3, r3, 8	# 1177:5-55
	lwz	r31, 4(r3)	# 1177:5-55
	mtlr	r31	# 1177:5-55
	lis	r2, ha16(min_caml_vscan)	# 1178:5-10
	addi	r2, r2, lo16(min_caml_vscan)	# 1178:5-10
	lis	r5, ha16(min_caml_vscan)	# 1178:18-23
	addi	r5, r5, lo16(min_caml_vscan)	# 1178:18-23
	lfd	f1, 0(r5)	# 1178:18-27
	fdiv	f1, f1, f0	# 1178:18-37
	stfd	f1, 0(r2)	# 1178:5-37
	lis	r2, ha16(min_caml_vscan)	# 1179:5-10
	addi	r2, r2, lo16(min_caml_vscan)	# 1179:5-10
	lis	r5, ha16(min_caml_vscan)	# 1179:18-23
	addi	r5, r5, lo16(min_caml_vscan)	# 1179:18-23
	lfd	f1, 8(r5)	# 1179:18-27
	fdiv	f1, f1, f0	# 1179:18-37
	stfd	f1, 8(r2)	# 1179:5-37
	lis	r2, ha16(min_caml_vscan)	# 1180:5-10
	addi	r2, r2, lo16(min_caml_vscan)	# 1180:5-10
	lis	r5, ha16(min_caml_vscan)	# 1180:18-23
	addi	r5, r5, lo16(min_caml_vscan)	# 1180:18-23
	lfd	f1, 16(r5)	# 1180:18-27
	fdiv	f0, f1, f0	# 1180:18-37
	stfd	f0, 16(r2)	# 1180:5-37
	lis	r2, ha16(min_caml_viewpoint)	# 1182:5-14
	addi	r2, r2, lo16(min_caml_viewpoint)	# 1182:5-14
	lis	r5, ha16(min_caml_view)	# 1182:22-26
	addi	r5, r5, lo16(min_caml_view)	# 1182:22-26
	lfd	f0, 0(r5)	# 1182:22-30
	stfd	f0, 0(r2)	# 1182:5-30
	lis	r2, ha16(min_caml_viewpoint)	# 1183:5-14
	addi	r2, r2, lo16(min_caml_viewpoint)	# 1183:5-14
	lis	r5, ha16(min_caml_view)	# 1183:22-26
	addi	r5, r5, lo16(min_caml_view)	# 1183:22-26
	lfd	f0, 8(r5)	# 1183:22-30
	stfd	f0, 8(r2)	# 1183:5-30
	lis	r2, ha16(min_caml_viewpoint)	# 1184:5-14
	addi	r2, r2, lo16(min_caml_viewpoint)	# 1184:5-14
	lis	r5, ha16(min_caml_view)	# 1184:22-26
	addi	r5, r5, lo16(min_caml_view)	# 1184:22-26
	lfd	f0, 16(r5)	# 1184:22-30
	stfd	f0, 16(r2)	# 1184:5-30
	lis	r2, ha16(min_caml_rgb)	# 1187:5-8
	addi	r2, r2, lo16(min_caml_rgb)	# 1187:5-8
	lis	r31, ha16(l.4464)	# 1187:16-19
	addi	r31, r31, lo16(l.4464)	# 1187:16-19
	lfd	f0, 0(r31)	# 1187:16-19
	stfd	f0, 0(r2)	# 1187:5-19
	lis	r2, ha16(min_caml_rgb)	# 1188:5-8
	addi	r2, r2, lo16(min_caml_rgb)	# 1188:5-8
	lis	r31, ha16(l.4464)	# 1188:16-19
	addi	r31, r31, lo16(l.4464)	# 1188:16-19
	lfd	f0, 0(r31)	# 1188:16-19
	stfd	f0, 8(r2)	# 1188:5-19
	lis	r2, ha16(min_caml_rgb)	# 1189:5-8
	addi	r2, r2, lo16(min_caml_rgb)	# 1189:5-8
	lis	r31, ha16(l.4464)	# 1189:16-19
	addi	r31, r31, lo16(l.4464)	# 1189:16-19
	lfd	f0, 0(r31)	# 1189:16-19
	stfd	f0, 16(r2)	# 1189:5-19
	li	r2, 0	# 1192:16-17
	lis	r31, ha16(l.4465)	# 1192:18-21
	addi	r31, r31, lo16(l.4465)	# 1192:18-21
	lfd	f0, 0(r31)	# 1192:18-21
	mflr	r31	# 1192:5-21
	stw	r31, 4(r3)	# 1192:5-21
	addi	r3, r3, 8	# 1192:5-21
	bl	raytracing.2128	# 1192:5-21
	subi	r3, r3, 8	# 1192:5-21
	lwz	r31, 4(r3)	# 1192:5-21
	mtlr	r31	# 1192:5-21
	mflr	r31	# 1195:5-17
	stw	r31, 4(r3)	# 1195:5-17
	addi	r3, r3, 8	# 1195:5-17
	bl	write_rgb.2131	# 1195:5-17
	subi	r3, r3, 8	# 1195:5-17
	lwz	r31, 4(r3)	# 1195:5-17
	mtlr	r31	# 1195:5-17
	lwz	r2, 0(r3)	# 1198:16-27
	addi	r2, r2, 1	# 1198:16-27
	b	scan_point.2135	# 1198:5-27
scan_line.2137:	# 1203:12 - 1227:7
	lis	r5, ha16(min_caml_size)	# 1205:14-18
	addi	r5, r5, lo16(min_caml_size)	# 1205:14-18
	lwz	r5, 0(r5)	# 1205:14-22
	cmpw	cr7, r5, r2	# 1205:6-22
	bgt	cr7, ble_else.5923	# 1205:3 - 1227:7
#	1227:5-7
	blr	# 1227:5-7
ble_else.5923:	# 1206:5 - 1225:6
	lis	r5, ha16(min_caml_scan_sscany)	# 1214:7-18
	addi	r5, r5, lo16(min_caml_scan_sscany)	# 1214:7-18
	lis	r6, ha16(min_caml_scan_offset)	# 1215:18-29
	addi	r6, r6, lo16(min_caml_scan_offset)	# 1215:18-29
	lfd	f0, 0(r6)	# 1215:18-33
	lis	r31, ha16(l.4465)	# 1215:37-40
	addi	r31, r31, lo16(l.4465)	# 1215:37-40
	lfd	f1, 0(r31)	# 1215:37-40
	fsub	f0, f0, f1	# 1215:18-40
	stw	r2, 0(r3)	# 1215:44-62
	stw	r5, 4(r3)	# 1215:44-62
	stfd	f0, 8(r3)	# 1215:44-62
	mflr	r31	# 1215:44-62
	stw	r31, 20(r3)	# 1215:44-62
	addi	r3, r3, 24	# 1215:44-62
	bl	min_caml_float_of_int	# 1215:44-62
	subi	r3, r3, 24	# 1215:44-62
	lwz	r31, 20(r3)	# 1215:44-62
	mtlr	r31	# 1215:44-62
	lfd	f1, 8(r3)	# 1215:9-63
	fsub	f0, f1, f0	# 1215:9-63
	lis	r2, ha16(min_caml_scan_d)	# 1216:9-15
	addi	r2, r2, lo16(min_caml_scan_d)	# 1216:9-15
	lfd	f1, 0(r2)	# 1216:9-19
	fmul	f0, f1, f0	# 1214:26 - 1216:25
	lwz	r2, 4(r3)	# 1214:7 - 1216:25
	stfd	f0, 0(r2)	# 1214:7 - 1216:25
	lis	r2, ha16(min_caml_scan_met1)	# 1218:7-16
	addi	r2, r2, lo16(min_caml_scan_met1)	# 1218:7-16
	lis	r5, ha16(min_caml_scan_sscany)	# 1218:29-40
	addi	r5, r5, lo16(min_caml_scan_sscany)	# 1218:29-40
	lfd	f0, 0(r5)	# 1218:29-44
	stw	r2, 16(r3)	# 1218:24-44
	mflr	r31	# 1218:24-44
	stw	r31, 20(r3)	# 1218:24-44
	addi	r3, r3, 24	# 1218:24-44
	bl	fsqr.1980	# 1218:24-44
	subi	r3, r3, 24	# 1218:24-44
	lwz	r31, 20(r3)	# 1218:24-44
	mtlr	r31	# 1218:24-44
	lis	r31, ha16(l.4910)	# 1218:48-55
	addi	r31, r31, lo16(l.4910)	# 1218:48-55
	lfd	f1, 0(r31)	# 1218:48-55
	fadd	f0, f0, f1	# 1218:24-55
	lwz	r2, 16(r3)	# 1218:7-55
	stfd	f0, 0(r2)	# 1218:7-55
	lis	r2, ha16(min_caml_scan_sscany)	# 1220:16-27
	addi	r2, r2, lo16(min_caml_scan_sscany)	# 1220:16-27
	lfd	f0, 0(r2)	# 1220:16-31
	lis	r2, ha16(min_caml_sin_v)	# 1220:35-40
	addi	r2, r2, lo16(min_caml_sin_v)	# 1220:35-40
	lfd	f1, 0(r2)	# 1220:35-44
	fmul	f0, f0, f1	# 1220:7-44
	lis	r2, ha16(min_caml_wscan)	# 1221:7-12
	addi	r2, r2, lo16(min_caml_wscan)	# 1221:7-12
	lis	r5, ha16(min_caml_sin_v)	# 1221:26-31
	addi	r5, r5, lo16(min_caml_sin_v)	# 1221:26-31
	lfd	f1, 8(r5)	# 1221:26-35
	fmul	f1, f0, f1	# 1221:20-35
	lis	r5, ha16(min_caml_vp)	# 1221:39-41
	addi	r5, r5, lo16(min_caml_vp)	# 1221:39-41
	lfd	f2, 0(r5)	# 1221:39-45
	fsub	f1, f1, f2	# 1221:20-45
	stfd	f1, 0(r2)	# 1221:7-45
	lis	r2, ha16(min_caml_wscan)	# 1222:7-12
	addi	r2, r2, lo16(min_caml_wscan)	# 1222:7-12
	lis	r5, ha16(min_caml_cos_v)	# 1222:26-31
	addi	r5, r5, lo16(min_caml_cos_v)	# 1222:26-31
	lfd	f1, 8(r5)	# 1222:26-35
	fmul	f0, f0, f1	# 1222:20-35
	lis	r5, ha16(min_caml_vp)	# 1222:39-41
	addi	r5, r5, lo16(min_caml_vp)	# 1222:39-41
	lfd	f1, 16(r5)	# 1222:39-45
	fsub	f0, f0, f1	# 1222:20-45
	stfd	f0, 16(r2)	# 1222:7-45
	li	r2, 0	# 1223:18-19
	mflr	r31	# 1223:7-19
	stw	r31, 20(r3)	# 1223:7-19
	addi	r3, r3, 24	# 1223:7-19
	bl	scan_point.2135	# 1223:7-19
	subi	r3, r3, 24	# 1223:7-19
	lwz	r31, 20(r3)	# 1223:7-19
	mtlr	r31	# 1223:7-19
	lwz	r2, 0(r3)	# 1224:17-28
	addi	r2, r2, 1	# 1224:17-28
	b	scan_line.2137	# 1224:7-28
scan_start.2139:	# 1231:12 - 1239:4
	mflr	r31	# 1234:5-24
	stw	r31, 4(r3)	# 1234:5-24
	addi	r3, r3, 8	# 1234:5-24
	bl	write_ppm_header.2133	# 1234:5-24
	subi	r3, r3, 8	# 1234:5-24
	lwz	r31, 4(r3)	# 1234:5-24
	mtlr	r31	# 1234:5-24
	lis	r2, ha16(min_caml_size)	# 1235:30-34
	addi	r2, r2, lo16(min_caml_size)	# 1235:30-34
	lwz	r2, 0(r2)	# 1235:30-38
	mflr	r31	# 1235:5-38
	stw	r31, 4(r3)	# 1235:5-38
	addi	r3, r3, 8	# 1235:5-38
	bl	min_caml_float_of_int	# 1235:5-38
	subi	r3, r3, 8	# 1235:5-38
	lwz	r31, 4(r3)	# 1235:5-38
	mtlr	r31	# 1235:5-38
	lis	r2, ha16(min_caml_scan_d)	# 1236:5-11
	addi	r2, r2, lo16(min_caml_scan_d)	# 1236:5-11
	lis	r31, ha16(l.4921)	# 1236:19-24
	addi	r31, r31, lo16(l.4921)	# 1236:19-24
	lfd	f1, 0(r31)	# 1236:19-24
	fdiv	f1, f1, f0	# 1236:19-33
	stfd	f1, 0(r2)	# 1236:5-33
	lis	r2, ha16(min_caml_scan_offset)	# 1237:5-16
	addi	r2, r2, lo16(min_caml_scan_offset)	# 1237:5-16
	lis	r31, ha16(l.4440)	# 1237:33-36
	addi	r31, r31, lo16(l.4440)	# 1237:33-36
	lfd	f1, 0(r31)	# 1237:33-36
	fdiv	f0, f0, f1	# 1237:24-36
	stfd	f0, 0(r2)	# 1237:5-36
	li	r2, 0	# 1238:15-16
	b	scan_line.2137	# 1238:5-16
rt.2141:	# 1244:12 - 1252:4
	lis	r7, ha16(min_caml_size)	# 1247:5-9
	addi	r7, r7, lo16(min_caml_size)	# 1247:5-9
	stw	r2, 0(r7)	# 1247:5-23
	lis	r2, ha16(min_caml_size)	# 1248:5-9
	addi	r2, r2, lo16(min_caml_size)	# 1248:5-9
	stw	r5, 4(r2)	# 1248:5-23
	lis	r2, ha16(min_caml_dbg)	# 1249:5-8
	addi	r2, r2, lo16(min_caml_dbg)	# 1249:5-8
	stw	r6, 0(r2)	# 1249:5-23
	mflr	r31	# 1250:5-22
	stw	r31, 4(r3)	# 1250:5-22
	addi	r3, r3, 8	# 1250:5-22
	bl	read_parameter.2043	# 1250:5-22
	subi	r3, r3, 8	# 1250:5-22
	lwz	r31, 4(r3)	# 1250:5-22
	mtlr	r31	# 1250:5-22
	b	scan_start.2139	# 1251:5-18
_min_caml_start:	# main entry point
	mflr	r0
	stmw	r30, -8(r1)
	stw	r0, 8(r1)
	stwu	r1, -96(r1)
#	main program starts
	li	r2, 768	# 1255:4-7
	li	r5, 768	# 1255:8-11
	li	r6, 0	# 1255:12-17
	mflr	r31	# 1255:1-17
	stw	r31, 4(r3)	# 1255:1-17
	addi	r3, r3, 8	# 1255:1-17
	bl	rt.2141	# 1255:1-17
	subi	r3, r3, 8	# 1255:1-17
	lwz	r31, 4(r3)	# 1255:1-17
	mtlr	r31	# 1255:1-17
#	main program ends
	lwz	r1, 0(r1)
	lwz	r0, 8(r1)
	mtlr	r0
	lmw	r30, -8(r1)
	blr
