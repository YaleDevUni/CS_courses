.data
	aaa:	.word 123
.text 
	la $4, aaa
	addi $sp, $sp, -4
	addi $t0, $zero, 10
	sw $t0, 0($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 4
	lw $t2, 0($sp)
	addi $sp, $sp, -4
	lw $t2, 0($sp)
	
	
