# a3-part-C.asm
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
	
	.globl main
	.text	
main:
	addi $a0, $zero, 0
	addi $a1, $zero, 0
	addi $a2, $zero, 0x00ff0000
	jal draw_bitmap_box
	
	addi $a0, $zero, 11
	addi $a1, $zero, 6
	addi $a2, $zero, 0x00ffff00
	jal draw_bitmap_box
	
	addi $a0, $zero, 8
	addi $a1, $zero, 8
	addi $a2, $zero, 0x0099ff33
	jal draw_bitmap_box
	
	addi $a0, $zero, 2
	addi $a1, $zero, 3
	addi $a2, $zero, 0x00000000
	jal draw_bitmap_box

	addi $v0, $zero, 10
	syscall
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


# Draws a 4x4 pixel box in the "Bitmap Display" tool
# $a0: row of box's upper-left corner
# $a1: column of box's upper-left corner
# $a2: colour of box

draw_bitmap_box:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	li $s0, 4#size of row
	li $s1, 4#size of column
loop:				# outer loop, loop 4 times
inner_loop:			# inner loop, loop 4 times
	jal set_pixel		#draw pixel 
	addi $a0,$a0,1
	addi $s0 $s0,-1
	bnez $s0,inner_loop	# endof inner loop -
	addi $s0,$s0,4
	addi $a0,$a0,-4
	addi $a1,$a1,1
	addi $s1,$s1,-1
	bnez $s1, loop		# end of outer loop--------
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
