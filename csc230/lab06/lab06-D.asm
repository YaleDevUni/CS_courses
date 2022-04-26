.data

seven_segment:
	.byte 0x3f, 0x06, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x07, 0x7f, 0x6f, 0x5f, 0x7c, 0x39, 0x5e, 0x79, 0x71
	
.text
	
	addi $a0, $zero, 0xe
	addi $a1, $zero, 1

	
	jal display_hex_digit	
	
	
	addi $a0, $zero, 0xa
	addi $a1, $zero, 0
	jal display_hex_digit
	
finish:
	addi $v0, $zero, 10
	syscall


# $a0: hex digit to be displayed
# $a1: 0 == right display; 1 == left display

display_hex_digit:
	la $s2, seven_segment
	la $s3, 0xffff0010
	la $s4, 0xffff0011
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	add $s1, $s2, $a0
	lb $s5, 0($s1)
	
	beqz $a1, right_display
left_display:
	sb $s5, 0($s4)
	b last
right_display:
	sb $s5, 0($s3)
last:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
