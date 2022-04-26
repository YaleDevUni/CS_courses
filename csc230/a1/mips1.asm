.text
	li $12, 0x14030401
	li $11, 2
	li $4, 0
	li $21, 1
	li $22, 2
	sll $21 ,$22, 2
	
loop:	div $12, $11		# devide $12 by $11
	mfhi $14 		# remainder to $14
	mflo $13 		# quotient to $13
	la $12,($13)		# load remainder to $12
	addi $20,$20,1 		# count cycle
	beq $4,$14, loop	# if remainder zero excute loop block
	
	addi $20,$20,-1		# subtract 1 for overcounting value
	
	div $21,$22
	
