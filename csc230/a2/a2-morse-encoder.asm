# a2-morse-encode.asm
#
# For UVic CSC 230, Spring 2022
# Name: Yeil Park
# ID: V00962281
# Original file copyright: Mike Zastre
#

.text


main:	



# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	## Test code that calls procedure for part A
	#jal save_our_souls

	## flash_one_symbol test for part B
	#addi $a0, $zero, 0x42   # dot dot dash dot
	#jal flash_one_symbol
	
	## flash_one_symbol test for part B
	# addi $a0, $zero, 0x37   # dash dash dash
	# jal flash_one_symbol
		
	## flash_one_symbol test for part B
	# addi $a0, $zero, 0x32  	# dot dash dot
	# jal flash_one_symbol
			
	## flash_one_symbol test for part B
	# addi $a0, $zero, 0x11   # dash
	# jal flash_one_symbol	
	
	# display_message test for part C
	# la $a0, test_buffer
	# jal display_message
	
	# char_to_code test for part D
	# the letter 'P' is properly encoded as 0x46.
	# addi $a0, $zero, 'P'
	# jal char_to_code
	
	# char_to_code test for part D
	# the letter 'A' is properly encoded as 0x21
	# addi $a0, $zero, 'A'
	# jal char_to_code
	
	# char_to_code test for part D
	# the space' is properly encoded as 0xff
	# addi $a0, $zero, ' '
	# jal char_to_code
	
	# encode_text test for part E
	# The outcome of the procedure is here
	# immediately used by display_message
	 la $a0, message01
	 la $a1, buffer01
	 jal encode_text
	 la $a0, buffer01	
	 #addi $a0, $a0,1
	 #lbu $t9, 0($a0) 
	 jal display_message
	
	# Proper exit from the program.
	addi $v0, $zero, 10
	syscall

	
	
###########
# PROCEDURE
#decription: flash morse code of "SOS" in the digital lab sim
#input: none
#output: void function
save_our_souls:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	jal seven_segment_on
	jal delay_short 
	jal seven_segment_off
	jal delay_long 
	jal seven_segment_on
	jal delay_short 
	jal seven_segment_off
	jal delay_long
	jal seven_segment_on
	jal delay_short 
	jal seven_segment_off
	jal delay_long
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	jal delay_long
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	jal delay_long
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	jal delay_long
	jal seven_segment_on
	jal delay_short 
	jal seven_segment_off
	jal delay_long
	jal seven_segment_on
	jal delay_short 
	jal seven_segment_off
	jal delay_long
	jal seven_segment_on
	jal delay_short 
	jal seven_segment_off
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $31


# PROCEDURE
#decription: flash morse code of a single character of 
#  	     alphabet or space in the digital lab sim
#input: parameter #a0 must be single asicii code
#output: void function
flash_one_symbol: 
	addi $sp,$sp,-4
	sw $ra,0($sp)
	beq $a0, 0xff, between_word # case for space  
	beqz $a0, end_function
	srl $s0, $a0, 4             # $s0 is value for left-most four bits
	andi $s1, $a0, 15           # $s1 is value for right-most four bits
	addi $s3, $s3, 4            # set $s3 as 4
	sub $s3, $s3, $s0           # subtract 4  by (4-length of the squence)
	sllv $s1, $s1, $s3          # shift left logically to read only in the range of given length

loop:	                            # loop while decimal value of left-most four bits ### loop start ##
	andi $s2,$s1, 8             # get value of left-most bit of left-most four bits
	sll $s1, $s1, 1             # shift left $s1 for next bit
	bnez $s2, flash_dash        # if left-most bit of $s1 is 0 flash dot else flash dash
 
flash_dot: 			    # flash dot
	jal seven_segment_on
	jal delay_short 
	jal seven_segment_off
	jal delay_long
	b skip_dash
	
flash_dash: 			    # flash dash
	jal seven_segment_on
	jal delay_long
	jal seven_segment_off
	jal delay_long

skip_dash:
	addi $s0, $s0, -1
	bnez $s0, loop              
	b end_function		    # end of loop
	
between_word:			    # delay long 3 times for space 
	jal seven_segment_off
	jal delay_long
	jal delay_long
	jal delay_long
	
end_function:  			    
	jal delay_long		    # for between letter
	li $s0, 0
	li $s1, 0
	li $s2, 0
	li $s3, 0
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

###########
# PROCEDURE
#decription: display sequence of letters by morse code in Digital Lab Sim
#input: data-memory address in $a0
#output: void function
display_message:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $s4,($a0)   		    
	addi $s6,$zero,0

display_loop:			    # ## loop start ##
	lbu $s5, 0($s4)		    # load byte from data-memory into $s5
	addi $s4, $s4 ,1	    # move address to get next byte
	add $a0, $zero, $s5	    # pass loaded byte to flash_one_symbol parameter	    
	jal flash_one_symbol	    # flash the digital lab sim
	bnez $s5, display_loop      # ## loop end ## loop end if loaded byte $s5 is zero
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
	
	
###########
# PROCEDURE
#decription: change character to given one-byte equivalent morse code pattern
#input: character (byte-value in ASCII) stored in$a0
#output: one-byte equivalent stored in$v0
char_to_code:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	add $t4,$zero,$zero
	addi $t7, $zero, ' ' 		# set $t7 as ' '
	beq $a0, $t7, is_space		# branch to is_space if parameter $a0 is ' '
	add $t5, $zero, $zero	 	
	addi $s6, $a0, 0		# copy $a0 value to $s6
	la $s7, codes			# load address of code data to $s7
	
char_loop:				# ###### outer loop start######
	lb $t1, 0($s7)			# load byte from $s7( codes data )
	beqz $t1, quit_loop		# loop if byte from $s7 is not empty
	
is_same_ascii:
	bne $s6, $t1, skip_is_same_ascii# check loaded byte have same ascii. if false then skip the steps
	addi $s7, $s7, 1		# add $s7 by 1 to get next byte
	
char_inner_loop:			# ### inner loop start ###
	lb $t2, 0($s7)			# load byte to $t2 from $s7( codes ) address
	beqz $t2, quit_char_inner_loop  # if $t2 empty end inner loop
	addi $t5, $t5, 1		# $t5 is for length of a specific morse code pattern
	addi $t3, $zero, '.'		# set $t3 as '.' (dot)
	beq $t2, $t3, is_dot		# if $t2(byte from codes address) is '.' branch to is_dot
	
is_dash:				# else $t2 is '_'
	addi $t4, $t4, 1		# $t4 is for position of dot and dash
	b skip_is_dot		
	
is_dot:
	#do nothing
skip_is_dot:
	sll $t4, $t4, 1			# adjust postion of dot and dash
	addi $s7, $s7, 1		# add address by 1 to get next byte
	b char_inner_loop		# ### end of inner loop ###
	
quit_char_inner_loop:
	#do nothing
skip_is_same_ascii:
	addi $s7 ,$s7, 8 		# add address by 8 to get next character of alphabet
	b char_loop			# ####### outer loop end ######
	
quit_loop:				
	srl $t4, $t4 ,1 		# adjust right-most four bits by shifting right logically
	sll $t5, $t5, 4 		# adjust left-most four bits by shifting left four times logically
	or $v0, $t4, $t5		# or operation to add right and left-most four bits
	b end_char_function		# branch to end 
	
is_space:
	addi $v0, $zero, 0xff		# case for space
end_char_function:
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra
###########
# PROCEDURE
#decription: change letters to collection of given one-byte 
#	     equivalent morse code patterns. And save it to
#	     given buffer.
#input: data-memory address of message in $a0
#	data-memory address of byte array to hold encoded message in $a1
#output: void function
encode_text:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	la $s0, ($a0)		# set $s0 as address of $a0
	la $s1, ($a1)		# set $s1 as address of $a1
	lb $s2, 0($s0)

encode_loop:			# ## loop start ##
	lb $s2, 0($s0)		# load byte to $s2 from $s0
	beqz $s2, end_encode_loop# if $s2 is empty end loop
	add $a0, $zero, $s2	# pass byte from $s2 to the function char_to_code
	jal char_to_code	# function to get character to code
	sb $v0, 0($s1)		# get returned byte( code ) and save to $s1 (buffer)
	addi $s0, $s0, 1	# for next position
	addi $s1, $s1, 1	# for next position
	b encode_loop		# ## end of loop ##
end_encode_loop:
	add $s0, $zero, $zero	
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

#############################################
# DO NOT MODIFY ANY OF THE CODE / LINES BELOW

###########
# PROCEDURE
seven_segment_on:
	la $t1, 0xffff0010     # location of bits for right digit
	addi $t2, $zero, 0xff  # All bits in byte are set, turning on all segments
	sb $t2, 0($t1)         # "Make it so!"
	jr $31


###########
# PROCEDURE
seven_segment_off:
	la $t1, 0xffff0010	# location of bits for right digit
	sb $zero, 0($t1)	# All bits in byte are unset, turning off all segments
	jr $31			# "Make it so!"
	

###########
# PROCEDURE
delay_long:
	add $sp, $sp, -4	# Reserve 
	sw $a0, 0($sp)
	addi $a0, $zero, 600
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31

	
###########
# PROCEDURE			
delay_short:
	add $sp, $sp, -4
	sw $a0, 0($sp)
	addi $a0, $zero, 200
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31




#############
# DATA MEMORY
.data
codes:
	.byte 'A', '.', '-', 0, 0, 0, 0, 0
	.byte 'B', '-', '.', '.', '.', 0, 0, 0
	.byte 'C', '-', '.', '-', '.', 0, 0, 0
	.byte 'D', '-', '.', '.', 0, 0, 0, 0
	.byte 'E', '.', 0, 0, 0, 0, 0, 0
	.byte 'F', '.', '.', '-', '.', 0, 0, 0
	.byte 'G', '-', '-', '.', 0, 0, 0, 0
	.byte 'H', '.', '.', '.', '.', 0, 0, 0
	.byte 'I', '.', '.', 0, 0, 0, 0, 0
	.byte 'J', '.', '-', '-', '-', 0, 0, 0
	.byte 'K', '-', '.', '-', 0, 0, 0, 0
	.byte 'L', '.', '-', '.', '.', 0, 0, 0
	.byte 'M', '-', '-', 0, 0, 0, 0, 0
	.byte 'N', '-', '.', 0, 0, 0, 0, 0
	.byte 'O', '-', '-', '-', 0, 0, 0, 0
	.byte 'P', '.', '-', '-', '.', 0, 0, 0
	.byte 'Q', '-', '-', '.', '-', 0, 0, 0
	.byte 'R', '.', '-', '.', 0, 0, 0, 0
	.byte 'S', '.', '.', '.', 0, 0, 0, 0
	.byte 'T', '-', 0, 0, 0, 0, 0, 0
	.byte 'U', '.', '.', '-', 0, 0, 0, 0
	.byte 'V', '.', '.', '.', '-', 0, 0, 0
	.byte 'W', '.', '-', '-', 0, 0, 0, 0
	.byte 'X', '-', '.', '.', '-', 0, 0, 0
	.byte 'Y', '-', '.', '-', '-', 0, 0, 0
	.byte 'Z', '-', '-', '.', '.', 0, 0, 0
	
message01:	.asciiz "A A A"
message02:	.asciiz "SOS"
message03:	.asciiz "WATERLOO"
message04:	.asciiz "DANCING QUEEN"
message05:	.asciiz "CHIQUITITA"
message06:	.asciiz "THE WINNER TAKES IT ALL"
message07:	.asciiz "MAMMA MIA"
message08:	.asciiz "TAKE A CHANCE ON ME"
message09:	.asciiz "KNOWING ME KNOWING YOU"
message10:	.asciiz "FERNANDO"

buffer01:	.space 128
buffer02:	.space 128
test_buffer:	.byte 0x30 0x37 0x30 0x00    # This is SOS
