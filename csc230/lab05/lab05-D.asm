.data

stringA: .asciiz "We're off to see the wizard,"
stringB: .asciiz "the wonderful wizard of OZ!"
stringC: .asciiz "I'll be back..."
stringD: .asciiz "Doh!"

string_space:
	.asciiz "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"


# Given the string address loaded in $8,
# find the length of the string and store
# that length is $10

.text
	la $8, stringD
	la $11 string_space
	jal stirng_len
	beq $0 ,$0 finish
stirng_len:
	add $10, $0, $0
	
	
loop_start:
	lb $9, 0($8)
	sb $9, 0($11)
	beq $9, $0, return_from_string_len
	
	addi $11,$11,1
	addi $8, $8, 1
	addi $10, $10, 1
	beq $0, $0, loop_start
	
return_from_string_len:
	jr $ra
finish:
	# Nothing more is needed
	
	# At this point length of the string
	# is stored in $9
