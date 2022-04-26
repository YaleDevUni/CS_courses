
	.data 0x10010000 	# Normally the default, but forcing it anyway as
				# MARS might be misconfigured for some reason.
	
	.eqv	PIXEL_ON  0x00ffffff
	.eqv	PIXEL_OFF 0x00000000
	.eqv	ROWS      16
	
BITMAP_DISPLAY:
	.space 1024		# Ensuring all further .data values are outside of Bitmap Tool words

PATTERN:
	.word	0x0000
		0x07f8
		0x0ff8
		0x0f38
		0x1e38
		0x1c38
		0x1e38
		0x0ff8
		0x0ff8
		0x03f8
		0x0738
		0x0738
		0x0e38
		0x0e38
		0x1e38
		0x0000
	
	.text
	
	la $s0, BITMAP_DISPLAY
	la $s1, PATTERN
	
	addi $s2, $zero, ROWS
	

LOOP_ROW:
	lw $t1, 0($s1)
	addi $s3, $zero, ROWS
LOOP_COLUMN:
	##
	addi $s4,$zero, PIXEL_OFF
	andi $t4,$t1, 0x0001
	beq $t4, $zero, WRITE_PIXEL
	addi $s4,$zero, PIXEL_ON
WRITE_PIXEL:
	sw $s4,0($s0)
	addi $s0,$s0,4
	srl $t1,$t1,1
	##
	addi $s3,$s3,-1
	bne $s3,$zero, LOOP_COLUMN

	addi $s1,$s1, 4
	addi $s2, $s2, -1
	bne $s2, $zero, LOOP_ROW
	
EXIT:
	addi $v0, $zero, 10
	syscall
	
