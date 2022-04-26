# UVic CSC 230, Spring 2022
# Assignment #1, part C
# (Base code copyright 2022 Mike Zastre)

# Compute S % T, where S must be in $12, T must be in $13,
# and S % T must be in $19.

.text
start:
	lw $12, testcase3_S
	lw $13, testcase3_T

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
main: 
	li $19,-1
	ble $13,$4,skip #branch to skip if divisor is less than or equal to zero
	ble $12,$4,skip#branch to skip if dividend is less than or equal to zero
	bge $13,128,skip#brach to skip if divisor is greater than or equal to 128
	
loop:	
	nop
	la $19,($12)#load $12 to temp register $19
	sub $12,$12,$13#load result to $14 which subtract $12 by $13
	slt $5,$12,$4#if $12 less than zero then set 1 else 0
	beq $5,$4,loop#loop if $5 is zero
skip:
	nop

# Your code here.

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

# The three lines of code below will eventually be
# explained in a bit more detail in CSC 230. In
# essence, MARS provides something similar to the
# system-call interface provided by many operating
# systems -- and one very important task an OS
# must do is to stop/terminate a running job. In
# essence, the code below causes MARS to stop your
# program in a safe way. (And believe you me --
# throughout the term there will be times when you
# write programs that do *not* end safely because
# of a bug (or three!).

exit:
	add $2, $0, 10
	syscall
		

.data

# testcase1: 219 % 61 = 36
#
testcase1_S:
	.word	219
testcase1_T:
	.word 	61
	
# testcase2: 24156 % 77 = 55
#
testcase2_S:
	.word	24156
testcase2_T:
	.word 	77

# testcase3: 21 % 0 = -1
#
testcase3_S:
	.word	21
testcase3_T:
	.word 	0
	
# testcase4: 33 % 120 = 33
#
testcase4_S:
	.word	33
testcase4_T:
	.word 	120
	
testcaseEVALS:
	.word	391
testcaseEVALT:
	.word	0
