# UVic CSC 230, Spring 2022
#
# Howdy, world!

	.data
howdy_string:
	.asciiz	"\nHello! My name is Yeil Park!\n\n"
howdy_number:
	.asciiz "V00962281\n"
	
	
	.text
main:
	li	$22, 0x1000fff9
	li	$v0, 4
	la	$a0, howdy_string
	syscall
	
	li	$v0, 4
	la	$a0, howdy_number
	syscall
	
	li	$v0, 10
	syscall
