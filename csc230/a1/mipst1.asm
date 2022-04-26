# Count number of 1s in a 32 Bit Number
#$t0 = user input
#$t1 = counter
.data
prompt: .asciiz "Enter Number: "
result: .asciiz "Number of 1s counted: "
n:  .word   0
counter:.word   0
    .text

#Prompt User for Number 
    li $v0, 4       #load text stored in v0
        la $a0, prompt  #print prompt
        syscall     #call prompt string

#Get user Input   
        li $v0, 5   #load number stored in v0
        la $t0, n   #load int into $t0
        syscall     #display integer

#Store user input in $t0 to do function
        move $t0, $v0   #Move value from $v0 to $t0 to modify
        la $t1, counter #load address of counter
        lw $t1, 0($t1)  #load counter to t1

AND:
    andi $t2, $t0, 1 #and user input($t0) with 1 and store in $t2
    beq  $t2, 1, loop #if t2 equals 0 branch
    srl  $t0, $t0, 1 #shift user input($t0) to right 1 position logically
    b AND       #branch this function

loop:
    add $t1, $t1, 1 #add 1 to the counter
    srl $t0, $t0, 1 #shift $to to the right 1 position logically with counter
    beqz $t0, display #If $t0 equals 0 send to display function
    b AND       #send back to AND function if not

display:
       li $v0, 4    #load text stored in v0
       la $a0, result   #print text from address a0
       syscall
       la $a0, ($t1)    #load the address of the counter to a0
       li $v0, 1      #load integer stored in v0
       syscall        #print final integer
