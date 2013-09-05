
	addiu	$29,	$0,		0xFFC
	jal		multwo
	addiu	$1,		$0,		0x11
	push	$1
	addiu	$1,		$0,		0x3
	push	$1

	jal 	multwo

#	lw		$1,		$0		0x3ffc
#	sw		$1,		$0,		0x0ffc
	halt

# ini program
multwo:
	addiu 	$1,		$29,	0
	push	$31
	
	push	$2
	push 	$3
	push	$4
	push	$5

	lw		$2,		0($1)
	lw		$3,		4($1)



	# start of actual program
	and		$5,		$0,		$5 # clear $5
lpsrt:
	andi	$4,		$3,		1
	beq		$0,		$4,		isZero
	addu		$5,		$5,		$2

isZero:
	sll		$2,		$2,		1
	srl		$3,		$3,		1
	bne		$3,		$0,		lpsrt

	sw		$5,		$1,		4	#result @ stack top of subroutine start

	pop		$5
	pop		$4
	pop		$3
	pop		$2
#	pop		$0

	pop		$31
	jr		$31	#return
