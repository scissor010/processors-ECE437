	#ini
	addi	$29,	$0,		0xFFFC


#third program

	#ini 
	addi	$1,		$0,		1 	# day
	push	$1
	addi	$1,		$0,		2 	# month
	push	$1
	addi	$1,		$0,		2013 	# year
	push	$1

	# start of actual program 3
	#start-ini
	addi	$1,		$29,	0

	push	$5
	push	$4
	push	$3
	push	$2

	#start-start
	lw		$2,		$1,		00
	lw		$3,		$1,		04
	lw		$4,		$1,		08

	addi	$2,		$2,		-2000
	addi	$3,		$3,		-1

	push	$2
	addi	$1,		$0,		365
	push 	$1
	addi	$5,		$0,		2
	j 		multmore


	push	$3
	addi	$1,		$0,		30
	push 	$1
	addi	$5,		$0,		2
	jal		multmore
rt2:
	pop		$3
	pop		$2
	add 	$2,		$3,		$2
	add 	$2,		$4,		$2

	halt
# second program
	#ini
multmore:
#	addi	$1,		$0,		5
#	push	$1
#	addi	$1,		$0,		6
#	push	$1
#	addi	$1,		$0,		7
#	push	$1 
#	addi	$1,		$0,		8
#	push	$1
#	addi	$1,		$0,		2
#	push	$1
#	addi	$1,		$0,		3
#	push	$1
#	addi	$1,		$0,		2 	# operands
#	push	$1
#	addi	$1,		$0,		3
#	push	$1
#	addi	$1,		$0,		2
#	push	$1
#	addi	$1,		$0,		3
#	push	$1
#	addi	$5,		$0,		4	# number of operands
	# actual program 2
	add		$1,		$0,		$29	# where pass in data stores
	push	$31
lp2srt:
	addi	$5,		$5,		0xFFFF
	beq		$0,		$5,		lp2end

	
	jal		multwo
	j		lp2srt
lp2end:
	addi	$1,		$0,		0x3ffc
	pop		$5
	sw		$5,		$1,		0
	#pop		$31
	#jr		$31
	halt
	# program 2 end


# ini program
multwo:

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
