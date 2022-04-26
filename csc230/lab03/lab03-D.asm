.text 
	# $8 : initial value for which we look for trailing zeros
	# $9 : the counter to keeps track of # of trailing zeros (result)
	# $10 :  the result of the AND with the mask
	
	ori $8, $0, 0#0xc800   	# same as "addi $8, $0, 0xc800"
	
	ori $9, $0, 0		# counter
loop:
	andi $10, $8, 1
	bne $10, $0, exit
	addi $9, $9, 1
	srl $8, $8, 1
	b loop
	
exit:
	nop			# answer is in $9
	
	
	#if $8 setup with zero the loop will coutinue endlessly, to avoid this fatal flaw, we can write a code that branch if $8 is zero,
	#at the begining 