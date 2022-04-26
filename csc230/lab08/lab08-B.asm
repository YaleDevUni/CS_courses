	.data

S1:	.asciiz "In what year were you born? "
S2:	.asciiz "What year is it now? "
S3:	.asciiz "You will turn "
S4: 	.asciiz " years old this year.\n"
SPACE:	.asciiz " "
NL:	.asciiz "\n"
	
	.text
main:
	la $a0, S4
	addi $v0, $zero, 4
	syscall	
				
	addi $v0, $zero, 10
	syscall
