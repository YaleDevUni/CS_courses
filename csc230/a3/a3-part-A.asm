# a3-part-A.asm
#
# For UVic CSC 230, Spring 2022
# Name: Yeil Park
# ID: V00962281
# Original file copyright: Mike Zastre

	.data
ARRAY_A:
	.word	21, 210, 49, 4
ARRAY_B:
	.word	21, -314159, 0x1000, 0x7fffffff, 3, 1, 4, 1, 5, 9, 2
ARRAY_Z:
	.space	28
NEWLINE:
	.asciiz "\n"
SPACE:
	.asciiz " "
		
	
	.text  
main:	
	la $a0, ARRAY_A
	addi $a1, $zero, 4
	jal dump_array
	
	la $a0, ARRAY_B
	addi $a1, $zero, 11
	jal dump_array
	
	la $a0, ARRAY_Z
	lw $t0, 0($a0)
	addi $t0, $t0, 1
	sw $t0, 0($a0)
	addi $a1, $zero, 9
	jal dump_array
		
	addi $v0, $zero, 10
	syscall

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	
# system print out an array of integer in mars console 
# $a0: address of array
# $a1: number of elements in array
dump_array:
	addi $sp,$sp,-8
	sw $s0,4($sp)		#preseve $s0, $s1
	sw $s1,0($sp)
	
	la $s0, ($a0)
	add $s1, $a1, $zero
	
loop:				# ***loop start** loop given $a1 value times
	lw $a0, ($s0)		#print value of current array index
	addi $v0, $zero, 1
	syscall
	
	la $a0, SPACE		#print space between integer
	addi $v0, $zero, 4
	syscall
	
	addiu $s0, $s0, 4	#point next array index
	addi $s1,$s1,-1
	bnez $s1, loop		#***loop end***
	
	la $a0, NEWLINE		#print newline between line
	addi $v0, $zero, 4
	syscall
	
	lw $s0,0($sp)		
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra
	
	
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
