# Name: Bernice Lau
# Name: Colin Ngo

.data
RCR: .word 0xffff0000
RDR: .word 0xffff0004
TCR: .word 0xffff0008
TDR: .word 0xffff000c

.text
.globl readInt
.globl readString
.globl readChar
.globl exitProgram
	
# readInt
readInt:
    	lw t1, RCR #t1 = RCR
    	lw t0, (t1) #t0 = &RCR
       	andi t0, t0, 1 # &RCR = &RCR & 1; andi checks if there is new data
    	beqz t0, readInt

    	lw t1, RDR
    	lw a0, (t1)
    	lbu t2, (t1)    # Load RDR register value
    	addi a0, a0, -48
    	ret

# readString
readString: #return an array of characters
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp) #arr[]
	sw s1, 4(sp)
	
	mv s0, a0 #readstringarray into s0
readstringwhile:
	jal readChar 
	mv s1, a0
	
	li t0, '\n'
	beq t0, s1, endreadstringwhile
	
	sb a0, (s0)
	addi s0, s0, 1 #increment next char in arr

	b readstringwhile
	
endreadstringwhile:
	sb x0, (s0)
	
	lw s1, 4(sp)
	lw s0, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret

# readChar
readChar:
    	lw t1, RCR   # Load RCR register value
    	lw t0, (t1)
   	andi t0, t0, 1       # Check if RCR[0] is 1 (new character received)
   	beqz t0, readChar  # If RCR[0] is 0, wait until character is received

    	lw t1, RDR   # Load RDR register value
    	lbu a0, (t1)
    	ret
    	
# exitProgram
exitProgram:
    	li a7, 10   # load system call code for exit into a7 register
    	ecall       # execute system call
    	ret         # return from subroutine
		
.globl printInt
.globl printString
.globl printChar

# printInt
printInt:

    	# Poll TCR register to wait for the display to complete
    	lw t0, TCR    # Load TCR register value
    	lw t1, (t0)
    	andi t1, t1, 1       # Extract the ready bit (TCR[0])
    	beqz t1, printInt       # Poll TCR register until ready bit becomes 1
    	lw t0, TDR
	addi a0, a0, 48
	sw a0, (t0)
    	ret
  	
# printString
printString:
	addi sp, sp, -16     # allocate 16 bytes on stack
	sw ra, 12(sp)	     # save return address
	sw s0, 8(sp)	     # save s0
	sw s1, 4(sp)
	mv s0, a0
	
	
printString_loop:
    	beqz a0, exit_printString      # If the character is null, exit the loop
    	lb a0, 0(s0)
    	addi s0, s0, 1		# Move to the next character
    	jal printChar  	     # Print the character
    	mv s1, a0
    	j printString_loop

exit_printString:
	lw s1, 4(sp)
	lw s0, 8(sp)
    	lw ra, 12(sp)
    	addi sp, sp, 16
    	ret

# printChar
printChar:
    	lw t1, TCR   # Load TCR register value
    	lw t0, (t1)
    	andi t0, t0, 1       # Check if TCR[0] is 1 (device ready)
    	beqz t0, printChar # If TCR[0] is 0, wait until ready
	
    	lw t1, TDR
    	sw a0, (t1)
    	ret
