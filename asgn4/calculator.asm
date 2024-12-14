#Name: Bernice Lau
#Name: Colin Ngo

.text
main:
	la a0, msgwelcome #"Welcome to the Calculator Program.\n"
	jal printstring
	
	la a0, msgoperations #"Operations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift\n""
	jal printstring
	 
	li s0, 0 #operations_counter = 0
	li s1, 'n' 
	li s2, 'y' 
while: 
	beq s1, s2, endwhile #choice != 'n'
	la a0, msgnumoperations #"\nNumber of operations performed:"
	jal printstring
	
	mv a0, s0
	jal printint #Prints number of operations
	
	la a0, msgEnterNumber #"Enter Number: "
	jal printstring
	
	jal readint #Reads the integer of the first number
	mv s3, a0 #num1
	
	la a0, msgEnterNumber2 #"Enter Second Number: "
	jal printstring
	
	jal readint #Reads the integer of the second number
	mv s4, a0 #num2
	
	la a0, msgSelectOperation #"Select Operation: "
	jal printstring
	
	jal readint #Reads the operation related to the integer; op = r0
	mv s5, a0 #choice is s5
if1:
	li, t4, 1
	bne t4, s5, if2 #op == 1
	
	mv a0, s4
	mv a1, s3
	jal addnums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif

if2:
	li, t4, 2
	bne t4, s5, if3 #op == 2
	
	mv a0, s3
	mv a1, s4
	jal subnums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif
	
if3:
	li, t4, 3
	bne t4, s5, if4 #op == 3
	
	mv a0, s3
	mv a1, s4
	jal multnums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal ra, printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif
	
if4:
	li, t4, 4
	bne t4, s5, if5 #op == 4
	
	mv a0, s3
	mv a1, s4
	jal divnums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif

if5:
	li, t4, 5
	bne t4, s5, if6 #op == 5
	
	mv a0, s3
	mv a1, s4
	jal andnums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif
	
if6:
	li, t4, 6
	bne t4, s5, if7 #op == 1
	
	mv a0, s3
	mv a1, s4
	jal ornums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif
	
if7:
	li, t4, 7
	bne t4, s5, if8 #op == 7
	
	mv a0, s3
	mv a1, s4
	jal xornums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif
	
if8:
	li, t4, 8
	bne t4, s5, if9 #op == 8
	
	mv a0, s3
	mv a1, s4
	jal lshiftnums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer

	b endif
	
if9:
	li, t4, 9
	bne t4, s5, else #op == 9
	
	mv a0, s3
	mv a1, s4
	jal rshiftnums
	mv s6, a0 #saves value from addnums into s3
	
	la a0, msgResult # "Result: "
	jal printstring
	
	mv a0, s6
	jal printint #prints the result integer
	
	b endif	
else:
	la a0, msgInvalid #"Result: Invalid Operation\n" 
	jal printstring
	
	b endif
	
endif:
	la a0, msgContinue #"Continue (y/n)?: "
	jal printstring
	
	jal readchar
	mv s2, a0

	addi s0, s0, 1 #operations ++ 
	b while #goes back to the whileloop
	

endwhile:
	la a0, msgnumoperations #"\nNumber of operations performed:"
	jal printstring
	
	mv a0, s0
	jal printint
	
	la a0, msgExit #"Exiting\n"
	jal printstring
	
	jal exit0 #Closes program
	
.data
	msgwelcome: .string "Welcome to the Calculator program.\n"
	msgoperations: .string "Operations - 1:add 2:subtract 3:multiply 4:divide 5:and 6:or 7:xor 8:lshift 9:rshift"
	msgnumoperations: .string "\n\nNumber of Operations performed: "
	msgEnterNumber: .string "\nEnter number: "
	msgEnterNumber2: .string "Enter second number: "
	msgSelectOperation: .string "Select Operation: "
	msgResult: .string "Result: "
	msgInvalid: .string "Result: Invalid Operation"
	msgContinue: .string "\nContinue (y/n)?: "
	msgExit: .string "\nExiting"
	
	
	
	

	
	
	
