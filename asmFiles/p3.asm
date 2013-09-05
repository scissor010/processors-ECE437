
	addiu	$29,	$0,		0x3FFC
	jal		multwo



	#ini
	addi	$1,		$0,		1 	# day
	push	$1
	addi	$1,		$0,		2 	# month
	push	$1
	addi	$1,		$0,		2013 	# year
	push	$1


	pop		$2
	addi 	$1,		$0,		2000
	subu 	$1,		$2,		$1
	addi 	$2,		$0,		365
	push	$1
	push	$2

	jal 	multwo
	lw		$2,		$0,		0x3ff0

	pop		$3
	addi 	$3,		0xFFFF

	halt

# ini program
multwo:
	addiu 	$1,		$29,	0
	push	$31
	
	push	$2
	push 	$3
	push	$4
	push	$5

	lw		$2,		$1,		0
	lw		$3,		$1,		4



	# start of actual program
	and		$5,		$0,		$5 # clear $5
lpsrt:
	andi	$4,		$3,		1
	beq		$0,		$4,		isZero
	add		$5,		$5,		$2

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
