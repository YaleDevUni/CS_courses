# Skeleton file provided to students in UVic CSC 230, Spring 2022
# Original file copyright Mike Zastre, 2022

.include "a4support.asm"


.globl main

.text 

main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	la $a0, FILENAME_1
	la $a1, ARRAY_A
	jal read_file_of_ints
	add $s0, $zero, $v0	# Number of integers read into the array from the file
	
	la $a0, ARRAY_A
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part A test
	#
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	add $a2, $zero, $s0
	jal accumulate_sum
	
	
	la $a0, ARRAY_B
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part B test
	#
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	add $a2, $zero, $s0
	jal accumulate_max
	
	la $a0, ARRAY_B
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part C test
	#
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	add $a2, $zero, $s0
	jal reverse_array
	
	la $a0, ARRAY_B
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Part D test
	la $a0, FILENAME_1
	la $a1, ARRAY_A
	jal read_file_of_ints
	add $s0, $zero, $v0
	
	la $a0, FILENAME_2
	la $a1, ARRAY_B
	jal read_file_of_ints
	# $v0 should be the same as for the previous call to read_file_of_ints
	# but no error checking is done here...
	
	la $a0, ARRAY_A
	la $a1, ARRAY_B
	la $a2, ARRAY_C
	add $a3, $zero, $s0
	jal pairwise_max
	
	la $a0, ARRAY_C
	add $a1, $zero, $s0
	jal dump_ints_to_console
	
	
	# Get outta here...
	add $v0, $zero, 10
	syscall	
	
	
# Accumulate sum: Accepts two integer arrays where the value to be
# stored at each each index in the *second* array is the sum of all
# integers from the index back to towards zero in the first
# array. The arrays are of the same size; the size is the third
# parameter.
#
accumulate_sum:
	addi,$sp,$sp,-8 #preserve
	sw $s0,4($sp)
	sw $s1,0($sp)
loop:
	lw $s0,0($a0) #get integer
	add $s1,$s1,$s0 #sum cumulatively
	beqz $a2, end_loop#if array index is zero end loop 
	sw $s1,0($a1)	#save cumulative sum in other array
	addi $a2,$a2,-1	#count down for loop
	addi $a0,$a0,4	#point next array index
	addi $a1,$a1,4	#point next array index
	b loop
end_loop:
	lw $s1,0($sp)
	lw $s0,4($sp)
	addi $sp,$sp,8
	jr $ra


# Accumulate max: Accepts two integer arrays where the value to be
# stored at each each index in the *second* array is the maximum
# of all integers from the index back to towards zero in the first
# array. The arrays are of the same size;  the size is the third
# parameter.
#
accumulate_max:
	addi,$sp,$sp,-12#preserve
	sw $s3,8($sp)
	sw $s0,4($sp)
	sw $s1,0($sp)
	
	add $s3,$zero,$zero
	
loop_b:
	lw $s0,0($a0)	#get integer from array
	slt $t1,$s3,$s0	#check previous integer and current index
	beqz $t1,pass	#if largest integer so far is smaller than current
	add $s3,$zero,$s0#update largest integer
pass:
	beqz $a2,end_loop_b
	sw $s3,0($a1)	#copy largest so far to other array
	addi $a2,$a2,-1	#count down for looping
	addi $a0,$a0,4	#move array pointer
	addi $a1,$a1,4 #move array pointer
	b loop_b
end_loop_b:
	lw $s1,0($sp)
	lw $s0,4($sp)
	lw $s3,8($sp)
	addi $sp,$sp,12
	jr $ra
	
	
# Reverse: Accepts an integer array, and produces a new
# one in which the elements are copied in reverse order into
# a second array.  The arrays are of the same size; 
# the size is the third parameter.
#
reverse_array:
	addi,$sp,$sp,-12 #preserve
	sw $s2,8($sp)
	sw $s1,4($sp)
	sw $s0,0($sp)
	sll $t1,$a2,2 # $t1 = array_length*4 - 4
	addi $t1,$t1,-4
	add $a0,$a0,$t1# point to last index of array
loop_rb:
	lw $s0,0($a0) #get integer from array
	beq $a2,$zero,loop_rb_end #if count down is zero end loop
	sw $s0,0($a1)	#copy to new array
	addi $a2,$a2,-1	#count down 
	addi $a1,$a1,4 	#move array pointer
	addi $a0,$a0,-4 #move array pointer
	beq $zero,$zero,loop_rb
loop_rb_end:
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	addi $sp,$sp,12
	jr $ra
	
	
# Reverse: Accepts three integer arrays, with the maximum
# element at each index of the first two arrays is stored
# at that same index in the third array. The arrays are 
# of the same size; the size is the fourth parameter.
#	
pairwise_max:
	addi,$sp,$sp,-12
	sw $s2,8($sp)
	sw $s1,4($sp)
	sw $s0,0($sp)
	
loop_p:
	lw $s0,0($a0) #get integer from Array 1
	lw $s1,0($a1) #get integer from Array 2
	beq $a3,$zero,loop_p_end	#if count down is zero, then end loop
	slt $t1,$s1,$s0 # compare integers
	bnez $t1,first_big	#get bigger integer
	beqz $t1,second_big
first_big:
	add $s2,$s0,$zero
	b bottom
second_big:
	add $s2,$s1,$zero
	b bottom
bottom:
	sw $s2,0($a2)	#copy the bigger integer to new array
	addi $a3,$a3,-1	#count down
	addi $a2,$a2,4	#move index
	addi $a1,$a1,4	#move index
	addi $a0,$a0,4	#move index
	beq $zero,$zero,loop_p
loop_p_end:
	lw $s0,0($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	addi $sp,$sp,12
	jr $ra
	
	
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
	

.data

.eqv	MAX_ARRAY_SIZE 1024

.align 2

ARRAY_A:	.space MAX_ARRAY_SIZE
ARRAY_B:	.space MAX_ARRAY_SIZE
ARRAY_C:	.space MAX_ARRAY_SIZE

FILENAME_1:	.asciiz "integers-10-314.bin"
FILENAME_2:	.asciiz "integers-10-1592.bin"


# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


# In this region you can add more arrays and more
# file-name strings. Make sure you use ".align 2" before
# a line for a .space directive.


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
