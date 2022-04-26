# a3-part-D.asm
#
# For UVic CSC 230, Spring 2022
# Name: Yeil Park
# ID: V00962281
# Original file copyright: Mike Zastre

# This code assumes the use of the "Bitmap Display" tool.
#
# Tool settings must be:
#   Unit Width in Pixels: 32
#   Unit Height in Pixels: 32
#   Display Width in Pixels: 512
#   Display Height in Pixels: 512
#   Based Address for display: 0x10010000 (static data)
#
# In effect, this produces a bitmap display of 16x16 pixels.


	.include "bitmap-routines.asm"

	.data
TELL_TALE:
	.word 0x12345678 0x9abcdef0	# Helps us visually detect where our part starts in .data section
KEYBOARD_EVENT_PENDING:
	.word	0x0
KEYBOARD_EVENT:
	.word   0x0
BOX_ROW:
	.word	0x0
BOX_COLUMN:
	.word	0x0

	.eqv LETTER_a 97
	.eqv LETTER_d 100
	.eqv LETTER_w 119
	.eqv LETTER_s 115
    .eqv SPACE    32
	.eqv BOX_COLOUR 0x0099ff33
	
	.globl main
	
	.text	
main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	.eqv MY_COLOUR 0x00962281
	# initialize variables
	la $s0, 0xffff0000	# control register for MMIO Simulator "Receiver"
	lb $s1, 0($s0)
	ori $s1, $s1, 0x02	# Set bit 1 to enable "Receiver" interrupts (i.e., keyboard)
	sb $s1, 0($s0)
	lw $a0, BOX_ROW		#set defalult location and colour
	lw $a1, BOX_COLUMN
	add $a2,$zero,BOX_COLOUR
	add $s3,$zero,BOX_COLOUR#preserve box colour in $s3
	jal draw_bitmap_box
check_for_event:
	la $s0, KEYBOARD_EVENT_PENDING	#loop until key is pressed
	lw $s1,0($s0)			
	beq $s1, $zero, check_for_event
	

	lw $a0, BOX_ROW		#remove previous box by drawing black box current location
	lw $a1, BOX_COLUMN
	add $a2,$zero,0x00000000
	jal draw_bitmap_box
	
	add $a0, $s1, $zero
	add $a2,$s3,$zero
	jal toggle_colour 	#check if box should be swapped colour
	add $s3,$v0,$zero
	add $a2,$s3,$zero
	jal update_location	#update location
	lw $a0, BOX_ROW		#get updated box's location
	lw $a1, BOX_COLUMN	
	
	jal draw_bitmap_box	#draw box by given location
	
	sw $zero, 0($s0) #reset status of pending
	
	beq $zero, $zero, check_for_event
	
	# Should never, *ever* arrive at this point
	# in the code.	

	addi $v0, $zero, 10
	


.data
    .eqv BOX_COLOUR_BLACK 0x00000000
.text

	addi $v0, $zero, BOX_COLOUR_BLACK
	syscall
# if space is pressed, flip the colour between default color and customized color
# $a0: any key pressed value
# $a2: current box color in 24bit RGB
# return value:
# $v0: box colour in 24bits RGB
toggle_colour:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	add $v0,$a2,$zero 
	bne $a0,SPACE, not_toggle # do nothing if $a0 is not space value
	beq $a2,BOX_COLOUR, swap_defalut # if current colour defalut, swap
	beq $a2,MY_COLOUR, swap_mine	# if current colour customized colour, swap
swap_defalut:
	addi $v0,$zero,MY_COLOUR
	j not_toggle
swap_mine:
	addi $v0,$zero,BOX_COLOUR
not_toggle:
	lw $ra 0($sp)
	addi $sp,$sp,4
	jr $ra
# Update location of left-upper box point
# $a0: char value, any keypressed value
update_location:
	addi $sp,$sp,-24
	sw $a0,0($sp)
	sw $s0,4($sp)
	sw $s1,8($sp)
	sw $s2,12($sp)
	sw $s3,16($sp)
	sw $ra,20($sp)
	
	la $s0,BOX_ROW
	la $s1,BOX_COLUMN
	lw $s2,0($s0) #value of row
	lw $s3,0($s1) #value of column
	beq $a0,LETTER_a,is_left
	beq $a0,LETTER_d,is_down
	beq $a0,LETTER_s,is_right
	beq $a0,LETTER_w,is_up
	j close_f
is_up:
	addi $s2,$s2,-1
	j process_f
is_right:
	addi $s2,$s2, 1
	j process_f
is_left:
	addi $s3,$s3,-1
	j process_f
is_down:
	addi $s3,$s3, 1
	j process_f
process_f:
	sw $s2,0($s0) #update row
	sw $s3,0($s1) #update column
	j close_f
close_f:
	lw $a0,0($sp)
	lw $s0,4($sp)
	lw $s1,8($sp)
	lw $s2,12($sp)
	lw $s3,16($sp)
	lw $ra,20($sp)
	addi $sp,$sp,24
	jr $ra

# Draws a 4x4 pixel box in the "Bitmap Display" tool
# $a0: row of box's upper-left corner
# $a1: column of box's upper-left corner
# $a2: colour of box
draw_bitmap_box:
	addi $sp,$sp,-12
	sw $s0,8($sp)
	sw $s1,4($sp)
	sw $ra,0($sp)
	li $s0, 4 #size of row
	li $s1, 4 #size of column
loop:				# outer loop---------------
inner_loop:			# inner loop ------
	jal set_pixel		#draw pixel 
	addi $a0,$a0,1
	addi $s0 $s0,-1
	bnez $s0,inner_loop	# endof inner loop -
	addi $s0,$s0,4
	addi $a0,$a0,-4
	addi $a1,$a1,1
	addi $s1,$s1,-1
	bnez $s1, loop		# end of outer loop--------
	lw $s0,8($sp)
	lw $s1,4($sp)
	lw $ra,0($sp)
	addi $sp,$sp,12
	jr $ra


	.kdata
	.ktext 0x80000180
#
# You can copy-and-paste some of your code from part (a)
# to provide elements of the interrupt handler.
#
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


.data

# Any additional .text area "variables" that you need can
# be added in this spot. The assembler will ensure that whatever
# directives appear here will be placed in memory following the
# data items at the top of this file.

	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


.eqv BOX_COLOUR_WHITE 0x00FFFFFF
	
