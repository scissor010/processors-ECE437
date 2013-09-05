
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
	pop	$1

	

	addu 	$1,	$2,	$0
	pop	$2
	push	$1	#$2

	addu 	$1,	$3,	$0
	pop	$3
	push	$1	#$3

	push	$31	#$31
	
	push	$4	#$4
	push	$5	#$5


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
