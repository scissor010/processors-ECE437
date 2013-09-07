
	addiu	$29,	$0,	0xFFC
	jal	multwo
	addiu	$1,	$0,	0x11
	push	$1
	addiu	$1,	$0,	0x3
	push	$1

	jal 	multwo


	halt

# ini program
multwo:
	
	lw	$1,	$29,	4
	sw	$2,	$29,	4	#$2

	lw	$2,	$29,	8
	sw	$3,	$29,	8	#$3

	lw	$3,	$29,	12
	sw	$4,	$29,	12	#$4

	lw	$4,	$29,	16
	sw	$5,	$29,	16	#$5

	

	# start of actual program
	and	$5,	$0,	$5 # clear $5
lpsrt:
	andi	$4,	$3,	1
	beq	$0,	$4,	isZero
	addu	$5,	$5,	$2

isZero:
	sll	$2,	$2,	1
	srl	$3,	$3,	1
	bne	$3,	$0,	lpsrt

	addu 	$1,	$5,	$0

	pop	$5
	pop	$4
	pop	$31
	pop	$3
	pop	$2
	push	$1

	jr	$31	#return
