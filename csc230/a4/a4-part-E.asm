# Skeleton file provided to students in UVic CSC 230, Spring 2022 
# Original file copyright Mike Zastre, 2022

.include "a4support.asm"

.data

.eqv	MAX_ARRAY_SIZE 1024

.align 2
ARRAY_1:	.space MAX_ARRAY_SIZE
ARRAY_2:	.space MAX_ARRAY_SIZE
ARRAY_3:	.space MAX_ARRAY_SIZE
ARRAY_4:	.space MAX_ARRAY_SIZE
ARRAY_5:	.space MAX_ARRAY_SIZE
ARRAY_6:	.space MAX_ARRAY_SIZE
ARRAY_7:	.space MAX_ARRAY_SIZE
ARRAY_8:	.space MAX_ARRAY_SIZE

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

FILENAME_1:	.asciiz "integers-200-42624.bin"
FILENAME_2:	.asciiz "integers-200-93238.bin"

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE



.globl main
.text 
main:

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	la $a0, FILENAME_1
	la $a1, ARRAY_1
	jal read_file_of_ints
	add $s1, $zero, $v0
	
	la $a0, FILENAME_2
	la $a1, ARRAY_2
	jal read_file_of_ints
	add $s2, $zero, $v0
	
	
	# WRITE YOUR SOLUTION TO THE PART E PROBLEM
	# HERE...
	la $a0, ARRAY_1
	la $a1, ARRAY_3
	add $a2,$zero,$s1
	jal accumulate_max	# ARRAY_3 = accumulate_max(ARRAY_1)
	
	la $a0, ARRAY_2
	la $a1, ARRAY_4
	add $a2,$zero,$s2
	jal accumulate_max	# ARRAY_4 = accumulate_max(ARRAY_2)
	
	la $a0, ARRAY_3
	la $a1, ARRAY_5
	add $a2,$zero,$s1
	jal reverse_array	# ARRAY_5 = reverse_array(ARRAY_3)
	
	la $a0, ARRAY_4
	la $a1, ARRAY_5
	la $a2, ARRAY_6
	add $a3,$zero,$s2
	jal pairwise_max	# ARRAY_6 = reverse_array(ARRAY_4, ARRAY_5)
	
	la $a0, ARRAY_6
	la $a1, ARRAY_7
	add $a2,$zero,$s2
	jal accumulate_sum	# ARRAY_7 = reverse_array(ARRAY_6)
	
	sll $t1, $s2,2		# $t1(last index of array) = array_length * 4 - 4
	addi $t1,$t1,-4
	la $a0, ARRAY_7		# load address of ARRAY_7
	add $a0,$a0,$t1		# point to last index of ARRAY
	addi $a1,$zero,1	# set array size 1 as parameter
	jal dump_ints_to_console
	# Get outta here.		
	add $v0, $zero, 10
	syscall	
	

	
# COPY YOUR PROCEDURES FROM PARTS A, B, C, and D BELOW
# THIS POINT.
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
