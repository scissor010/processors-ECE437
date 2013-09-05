
	addi	$2,		$0,		48
	addi	$3,		$0,		7

	# start of actual program
lpsrt:
	andi	$4,		$3,		1
	beq		$0,		$4,		isZero
	add		$5,		$5,		$2

isZero:
	sll		$2,		$2,		1
	srl		$3,		$3,		1
	bne		$3,		$0,		lpsrt

	sw		$5,		$1,		0	#result @ stack top of subroutine start
	halt
	# end of multwo, restore regs
