# Colin Ngo
# Bernice Lau

.globl main
.data
readstringarray: .space 20 #creates an array of 20 elements; each char is 1 byte

printenterword: .string "Enter word: " 
printogword: .string "Original word: "
printalpha: .string "\nAlphabetized word: "


printexit: .string "\nExiting"

.text

main:

while:
	la a0, printenterword
	jal printstring #print "Enter word: "
	
	la a0, readstringarray
	jal readstring #takes in user input;
	
	la t1, readstringarray
	lb t2, 0(t1) # t2 = str[0]
	beq t2, x0, endwhile #if str[0] == '\0'; 
	
	la a0, printogword
	jal printstring
	
	#print chars from an array of chars
	
	li s7, 0 # int i = 0
whileprint1:
	la t2, readstringarray
	add t2, t2, s7
	
	lb t3, 0(t2)  #t3 is str[i]
	beq t3, x0, endwhileprint1 #str[i] == x0; end
	mv a0, t3
	jal printchar
	addi s7, s7, 1
	b whileprint1
	
endwhileprint1:
	
	la a0, printalpha
	jal printstring
	
	
	
	

#sort
	li s0, 'z' #char lowest = 'z'
	li s2, 0 #int j = 0;
	li s3, 0 #int i = 0;
	
while1:
	la t2, readstringarray
	add t2, t2, s2
	
	lb t3, 0(t2)  #t3 is str[j]
	beq t3, x0, endwhile1 #str[j] == x0; end'

if1:
	bge t3, s0, endif1 #s0 is lowest; str[j] < lowest
	mv s0, t3

endif1:
	addi s2, s2, 1
	b while1

endwhile1:
	li s2, 0 #int j = 0
	
while2:
	la t2, readstringarray
	add t2, t2, s2
	
	lb t3, 0(t2)  #t3 is str[i]
	beq t3, x0, while3 #str[i] == x0; end'
	
if2: 
	bne t3, s0, endif2 #str[j
	mv a0, t3
	jal printchar
	
endif2:
	addi s2, s2, 1
	b while2
	
while3:
	la t2, readstringarray
	add t2, t2, s3
	
	lb t3, 0(t2)  #t3 is str[i]
	beq t3, x0, endwhile3 #str[i] == x0; end'
	
	li s4, 'z' #nextlow = 'z';
	li s2, 0 #int j = 0;
	
while3_1:
	la t2, readstringarray
	add t2, t2, s2
	
	lb t3, 0(t2)  #t3 is str[i]
	beq t3, x0, endwhile3_1 #str[i] == x0; end'
if3_1:
	bge s0, t3, endif3_1
	bge t3, s4, endif3_1
	mv s4, t3

endif3_1:
	addi s2, s2, 1
	b while3_1
	
endwhile3_1:
	
	li s2, 0

while3_2:
	la t2, readstringarray
	add t2, t2, s2
	
	lb t3, 0(t2)  #t3 is str[i]
	beq t3, x0, endwhile3_2 #str[i] == x0; end'
	
if3_2:
	bne t3, s4, endif3_2 #str[j] != nextlow
	mv a0, t3
	jal printchar

endif3_2:
	addi s2, s2, 1
	b while3_2
	
endwhile3_2:
	mv s0, s4 #lowest = nextlow;
	addi s3, s3, 1
	b while3
	
endwhile3: 
	li a0, '\n'
	jal printchar
	b while
	
endwhile:
	la a0, printexit
	jal printstring
	
	jal exit0
