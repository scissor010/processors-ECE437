
	addiu	$29,	$0,		0x3FFC


	addi	$1,		$0,		2 	# operands
	push	$1
	addi	$1,		$0,		3
	push	$1
	addi	$1,		$0,		2
	push	$1
	addi	$5,		$0,		3	# number of operands

	# actual program 2

lp2srt:
	addi	$5,		$5,		0xFFFF
	beq		$0,		$5,		lp2end

	
	jal		multwo
	j 		lp2srt

lp2end:

	pop $5
	addi 	$1,		$0,		0x3ffc
	sw		$5,		$1,		0
	#pop		$31
	#jr		$31
	lw		$1,		$0,		0x3ffc
	sw		$1,		$0,		0x0ffc
	halt
	
	# program 2 end





# ini program
multwo:
	addiu 	$1,		$29,	0
	
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
	pop		$0
	
	jr		$31	#return
