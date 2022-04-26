
	.data
	.eqv  BITMAP_DISPLAY 0x10010000
	.eqv  PIXEL_WHITE    0x00ffffff
	
	.text
	
	la $s0, BITMAP_DISPLAY
	li $s1, PIXEL_WHITE
	
	# Draw a row of white pixels on the bitmap display tool
	# Use row 4. You will need to write a loop!
	
	sw $s1, 0($s0)		# This is not the correct value!

	
	# Draw a column of white pixels on the bitmap display tool
	# Use column 3. You will need to write a loop!
	
	sw $s1, 0($s0)		# This is not the correct value!


	addi $v0, $zero, 10
	syscall