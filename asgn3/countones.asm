.text
main:
	
	la a0, welcome #loads the welcome string
	li a7, 4 #loads service number
	ecall #issues the instruction

	li t2, 'n'

	 
while1:
	li a1, 1 #bit
	li a2, 0 #counter
	
	la a0, query	# Please enter a number; just prints
	li a7, 4 	# putting 4 into a7 is printstring
	ecall      	# issue the system call to print the string
	
	
	li a7, 5 #Asks for the user for an int input
	ecall 

while2:
	and t1, a0, a1 #a0 is the myNum; a1 is bit
	
if: 
	beqz t1, endif #a1 is the bit, if bit is 0, endif
	addi a2, a2, 1

	
endif:
	slli a1, a1, 1	#bitshift bit (a1) by 1
	beqz a1, endwhile2
	b while2
	
endwhile2:
	
	la a0, result
	li a7, 4
	ecall

	add a0, a2, zero
	li a7, 1
	ecall

	la a0, continue
	li a7, 4
	ecall
	
	li a7, 12
	ecall
	
	beq a0, t2, endwhile1
	b while1
endwhile1:
	la a0, exit
	li a7, 4
	ecall
	

	li a7, 10  # Again we need to indicate what system call we are making and this time we are calling exit(93)
	ecall 

.data
	welcome: .string "Welcome to the CountOnes program.\n" 
	query: .string "\n\nPlease enter a number: "
	result: .string "The number of bits set is: "
	continue: .string "\nContinue (y/n)?: "
	exit: .string "\nExiting\n"

	
