# Name: Bernice Lau
# Name: Colin Ngo

.data
msg_welcome:
	.string "Welcome to the Calculator program."
msg_operations:
	.string "\nOperations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift"
msg_num_ops:
	.string "\n\nNumber of operations performed: "
msg_enter_num1:
	.string "\nEnter number: "
msg_enter_num2:
	.string "Enter second number: "
msg_select_op:
	.string "Select Operation: "
msg_result:
	.string "Result: "
msg_invalid_op:
	.string "Result: Invalid Operation"
msg_continue:
	.string "\nContinue (y/n)?: "
msg_exit:
	.string "\nExiting"
	
.text
.globl main
    
main:
	# Print welcome message and operation options
	la a0, msg_welcome
    	jal printString
    	la a0, msg_operations
    	jal printString
    	
    	# Initialize variables
    	li t0, 0        # operations

loop:
	# Initialize variables
    	li t2, 121        # choice
	
    	# Print number of operations performed
    	la a0, msg_num_ops
    	jal printString
    	mv a0, t0
    	jal printInt
	
   	 # Prompt for user input
    	la a0, msg_enter_num1
    	jal printString
    	jal readInt
    	mv t1, a0       # Save num1
   	la a0, msg_enter_num2
   	jal printString
    	jal readInt
   	mv t3, a0       # Save num2
   	la a0, msg_select_op
   	jal printString
   	jal readInt
   	mv t4, a0       # Save op

   	# Perform operation
   	li t6, 1
   	blt t4, t6, invalid_op
   	li t6, 9
   	bgt t4, t6, invalid_op
   	mv a0, t1  # Pass num1 as argument
   	mv a1, t3  # Pass num2 as argument

	# Determine operation and call corresponding subroutine
	li t6, 1
	beq t4, t6, add
	li t6, 2
	beq t4, t6, sub
	li t6, 3
	beq t4, t6, mult
	li t6, 4
	beq t4, t6, div
	li t6, 5
	beq t4, t6, and
	li t6, 6
	beq t4, t6, or
	li t6, 7
	beq t4, t6, xor
	li t6, 8
	beq t4, t6, lshift
	li t6, 9
	beq t4, t6, rshift

result:
	add t5, a0, x0  # Save result
	
    	# Print result
    	la a0, msg_result
    	jal printString
    	mv a0, t5
    	jal printInt
    	addi t0, t0, 1  # Increment operations counter
    	
continue:

    	# Prompt to continue
    	la a0, msg_continue
    	jal printString
    	li t2, 0
    	jal readChar
    	mv t2, a0       # Save choice
    	li t6, 110	# Load ASCII value of 'n' into temporary register t6
    	beq t2, t6, end	# Branch to end if t2 contains ASCII value of 'n'
	j loop

end:
    	# Print number of operations performed and exit
    	la a0, msg_num_ops
    	jal printString
    	mv a0, t0
    	jal printInt
    	la a0, msg_exit
    	jal printString
    	jal exitProgram
    
invalid_op:
   	# Print "Invalid Operation" message and prompt to continue
   	addi t0, t0, 1  # Increment operations counter
  	la a0, msg_invalid_op
  	jal printString
	j continue

# branch to the corresponding subroutines in operations.asm	
add:
	jal addnums
	j result

sub:
	jal subnums
	j result
	
mult:
	jal multnums
	j result
	
div:
	jal divnums
	j result
	
and:
	jal andnums
	j result
	
or:
	jal ornums
	j result
	
xor:
	jal xornums
	j result
	
lshift:
	jal lshiftnums
	j result
	
rshift:
	jal rshiftnums
	j result
