	.text
	.globl _min_caml_start
	.align 2
ack.15:	# 1:1 - 4:30
	cmpwi	cr7, r2, 0	# 2:6-12
	bgt	cr7, ble_else.34	# 2:3 - 4:30
#	2:18-23
	addi	r2, r5, 1	# 2:18-23
	blr	# 2:18-23
ble_else.34:	# 3:3 - 4:30
	cmpwi	cr7, r5, 0	# 3:6-12
	bgt	cr7, ble_else.35	# 3:3 - 4:30
#	3:18-31
	subi	r2, r2, 1	# 3:22-29
	li	r5, 1	# 3:30-31
	b	ack.15	# 3:18-31
ble_else.35:	# 4:3-30
	subi	r6, r2, 1	# 4:7-14
	subi	r5, r5, 1	# 4:22-29
	stw	r6, 0(r3)	# 4:15-30
	mflr	r31	# 4:15-30
	stw	r31, 4(r3)	# 4:15-30
	addi	r3, r3, 8	# 4:15-30
	bl	ack.15	# 4:15-30
	subi	r3, r3, 8	# 4:15-30
	lwz	r31, 4(r3)	# 4:15-30
	mr	r5, r2	# 4:15-30
	mtlr	r31	# 4:15-30
	lwz	r2, 0(r3)	# 4:3-30
	b	ack.15	# 4:3-30
_min_caml_start:	# main entry point
	mflr	r0
	stmw	r30, -8(r1)
	stw	r0, 8(r1)
	stwu	r1, -96(r1)
#	main program starts
	li	r2, 3	# 5:16-17
	li	r5, 10	# 5:18-20
	mflr	r31	# 5:11-21
	stw	r31, 4(r3)	# 5:11-21
	addi	r3, r3, 8	# 5:11-21
	bl	ack.15	# 5:11-21
	subi	r3, r3, 8	# 5:11-21
	lwz	r31, 4(r3)	# 5:11-21
	mtlr	r31	# 5:11-21
	mflr	r31	# 5:1-21
	stw	r31, 4(r3)	# 5:1-21
	addi	r3, r3, 8	# 5:1-21
	bl	min_caml_print_int	# 5:1-21
	subi	r3, r3, 8	# 5:1-21
	lwz	r31, 4(r3)	# 5:1-21
	mtlr	r31	# 5:1-21
#	main program ends
	lwz	r1, 0(r1)
	lwz	r0, 8(r1)
	mtlr	r0
	lmw	r30, -8(r1)
	blr
