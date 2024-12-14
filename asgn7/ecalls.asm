# Name: Bernice Lau
# Name: Colin Ngo

.text
.globl readInt
.globl readString
.globl readChar
.globl exitProgram
	
# readInt
readInt:
	addi sp, sp, -16     # allocate 16 bytes on stack
	sw ra, 12(sp)	     # save return address
	sw s0, 8(sp)	     # save s0 register
	mv s0, a0	     # move input buffer address to s0
	
	# readChar
	jal readChar
	
	# Convert character to integer
	li t0, '0'
  	sub a0, a0, t0       # subtract ASCII value of '0' to get the digit

  	lw s0, 8(sp)         # restore s0 register
  	lw ra, 12(sp)        # restore return address
  	addi sp, sp, 16      # deallocate 16 bytes from stack
  	ret


# readString
readString:
	addi sp, sp, -16     # allocate 16 bytes on stack
    	sw ra, 12(sp)        # save return address
    	sw s0, 8(sp)         # save s0 register
    	sw s1, 4(sp)         # save s1 register
    	mv s0, a0            # move input buffer address to s0
    	li s1, 0             # initialize i to 0

readstring_loop:
    	jal readChar    # call readChar subroutine to get next character
    	beq a0, x0, end_readstring_loop  # break loop on null character
    	li t0, '\n'          # load Enter key value into t0
    	beq a0, t0, end_readstring_loop # break loop on Enter key
    	li t0, 20            # load 20 into t0
    	bge s1, t0, end_readstring_loop # break loop if i >= 20
    	sb a0, 0(s0)         # store character in input buffer
    	addi s0, s0, 1       # increment buffer address
    	addi s1, s1, 1       # increment i
    	j readstring_loop    # jump to beginning of loop

end_readstring_loop:
    	sb x0, 0(s0)         # add null character to end of input buffer
    	lw s1, 4(sp)         # restore s1 register
    	lw s0, 8(sp)         # restore s0 register
    	lw ra, 12(sp)        # restore return address
    	addi sp, sp, 16      # deallocate 16 bytes from stack
    	ret

# readChar
readChar:
	addi sp, sp, -16     # allocate 16 bytes on stack
    	sw ra, 12(sp)        # save return address
	
	addi a1, sp, 8	     # address of the buffer
    	li a0, 0             # file descriptor (stdin)
    	li a2, 1             # buffer length
    	
    	li a7, 63            # system call number for read
    	ecall                # execute system call
	
	lb a0, 8(sp)
    	lw ra, 12(sp)        # restore return address
    	addi sp, sp, 16      # deallocate 16 bytes from stack
	ret
	

# exitProgram
exitProgram:
    	li a7, 10   # load system call code for exit into a7 register
    	ecall       # execute system call
    	ret         # return from subroutine


.globl printInt
.globl printString
.globl printChar
.align 2

# printInt
printInt:
	addi sp, sp, -16     # allocate 16 bytes on stack
	sw ra, 12(sp)	     # save return address
	
	# Convert digit to ASCII
  	addi a0, a0, '0'
  	
  	# Print the character
    	jal printChar

    	lw ra, 12(sp)
    	addi sp, sp, 16
    	ret
  	
# printString
printString:
	addi sp, sp, -16     # allocate 16 bytes on stack
	sw ra, 12(sp)	     # save return address
	sw s0, 8(sp)	     # save s0
	sw s1, 4(sp)	     # save s1
	
	mv s0, a0
	
loop:
    	lb s1, 0(s0)         # Load a character from the string
    	beqz s1, exit_printString      # If the character is null, exit the loop
    	mv a0, s1
    	jal printChar  	     # Print the character
    	addi s0, s0, 1       # Move to the next character
    	j loop

exit_printString:
	lw s1, 4(sp)
	lw s0, 8(sp)
    	lw ra, 12(sp)
    	addi sp, sp, 16
    	ret

# printChar
printChar:
	addi sp, sp, -16     # allocate 16 bytes on stack
	sw ra, 12(sp)	     # save return address
	sw a0, 8(sp)	     # save s0
	
	# Print the character
	addi a1, sp, 8       
    	li a0, 1             # File descriptor (stdout)
    	li a2, 1             # Buffer length
    	
    	li a7, 64            # System call number for write
    	ecall
    	
    	lw a0, 8(sp)	
    	lw ra, 12(sp)
    	addi sp, sp, 16
    	ret
