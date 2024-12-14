.text
main:
	
	la a0, welcome #loads the welcome string
	li a7, 4 #loads service number
	ecall #issues the instruction

	li t2, 'n'

	li a1, -2147483648 #bit
while1:

	li a2, 0 #counter
	li a3, 0 # result

	
	la a0, query	# Please enter a number; just prints
	li a7, 4 	# putting 4 into a7 is printstring
	ecall      	# issue the system call to print the string
	
	
	li a7, 5 #Asks for the user for an int input
	ecall 

while2:
	and t1, a0, a1 #a0 is the myNum; a1 is bit; myNum & bit = t1
	
if: 
	beqz t1, endif #a0 (which is myNum is the bit, if bit is 0, endif; #myNum & bit != 0	
	li t5, 1
	sll t4, t5, a2 #t4 = 1<<counter (a2)
	add a3, a3, t4 #result (a3) += t4

	
endif:
	slli a0, a0, 1	#bitshift myNum (a0) by 1
	addi a2, a2, 1 #counter += 1
	beqz a0, endwhile2
	b while2
	
endwhile2:
	
	la a0, result
	li a7, 4
	ecall

	add a0, a3, zero
	li a7, 34
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
	welcome: .string "Welcome to the Reverse program." 
	query: .string "\n\nPlease enter a number: "
	result: .string "The bit reversed value in hex is: "
	continue: .string "\nContinue (y/n)?: "
	exit: .string "\nExiting\n"

	
