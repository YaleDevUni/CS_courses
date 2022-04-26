# a3-part-B.asm
#
# For UVic CSC 230, Spring 2022
# Name: Yeil Park
# ID: V00962281
# Original file copyright: Mike Zastre
	.data
KEYBOARD_EVENT_PENDING:
	.word	0x0
KEYBOARD_EVENT:
	.word   0x0
KEYBOARD_COUNTS:
	.space  128
NEWLINE:
	.asciiz "\n"
SPACE:
	.asciiz " "
	
	
	.eqv 	LETTER_a 97
	.eqv	LETTER_b 98
	.eqv	LETTER_c 99
	.eqv 	LETTER_D 100
	.eqv 	LETTER_space 32
	
	
	.text  
main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	la $s0, 0xffff0000	# control register for MMIO Simulator "Receiver"
	lb $s1, 0($s0)
	ori $s1, $s1, 0x02	# Set bit 1 to enable "Receiver" interrupts (i.e., keyboard)
	sb $s1, 0($s0)
	
check_for_event:
	la $s0, KEYBOARD_EVENT_PENDING
	lw $s1, 0($s0)			#$s1 is value of pressed key
	beq $s1, $zero, check_for_event
	
	beq $s1, LETTER_a,is_a		#if key is pressed, key pressed process starts from here
	beq $s1, LETTER_b,is_b		
	beq $s1, LETTER_c,is_c
	beq $s1, LETTER_D,is_d
	beq $s1, LETTER_space, is_space
	j end_process
is_a:					#count a
	addi $s2,$s2,1
	j end_process
is_b:					#count b
	addi $s3,$s3,1
	j end_process
is_c:					#count c
	addi $s4,$s4,1
	j end_process
is_d:					#count d
	addi $s5,$s5,1
	j end_process
is_space:				
	sll $s3,$s3,8		#shift and sum the bits to format 0x01010101 
	sll $s4,$s4,16		#-> set bit represent counted num of abcd
	sll $s5,$s5,24
	or $s2,$s2,$s3
	or $s2,$s2,$s4
	or $s2,$s2,$s5
	sw $s2,KEYBOARD_EVENT	#save word in to KEYBOARD_EVENT
	la $a0, KEYBOARD_EVENT	#pass address of KEYBOARD_EVENT to dump_array
	addi $a1, $zero, 4
	jal dump_array
	add $s2,$zero,$zero	#reset abcd counts
	add $s3,$zero,$zero
	add $s4,$zero,$zero
	add $s5,$zero,$zero
	j end_process
end_process:
	sw $zero, 0($s0) #reset status of pending
	beq $zero, $zero, check_for_event # branch to pending key press
	
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
	lb $a0, ($s0)		#print value of current array index
	addi $v0, $zero, 1
	syscall
	
	la $a0, SPACE		#print space between integer
	addi $v0, $zero, 4
	syscall
	
	addiu $s0, $s0, 1	#point next array index
	addi $s1,$s1,-1
	bnez $s1, loop		#***loop end***
	
	
	lw $s0,0($sp)		
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra
	
	.kdata

	.ktext 0x80000180
__kernel_entry:
	mfc0 $k0, $13		# $13 is the "cause" register in Coproc0
	andi $k1, $k0, 0x7c	# bits 2 to 6 are the ExcCode field (0 for interrupts)
	srl  $k1, $k1, 2	# shift ExcCode bits for easier comparison
	beq $zero, $k1, __is_interrupt
	
__is_exception:
	beq $zero, $zero, __exit_exception
	
__is_interrupt:
	andi $k1, $k0, 0x0100	# examine bit 8
	bnez $k1, __is_keyboard_interrupt	 # if bit 8 set, then we have a keyboard interrupt.
	
	beq $zero, $zero, __exit_exception	# otherwise, we return exit kernel
	
__is_keyboard_interrupt:
	la $k0, 0xffff0004
	lw $t2, 0($k0)
	sw $t2, KEYBOARD_EVENT_PENDING 
	beq $zero, $zero, __exit_exception
	
__exit_exception:
	eret
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

	
