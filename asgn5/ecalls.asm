# Colin Ngo
# Bernice Lau

.globl printstring, exit0, printchar, readchar, readstring
.data
svra: .word -1

.text
printstring:
	li a7, 4
	ecall
	ret 
	
exit0:
	li a7, 10
	ecall
	ret
	
printchar:
	li a7, 11
	ecall
	ret
	
readchar:
	li a7, 12
	ecall
	ret

readstring: #return an array of characters
	sw ra, svra, t6
	
	mv s5, a0 #readstringarray into s5
	li s1, 0 #int i = 0;addi sp, sp, -16
	
readstringwhile:
	li t0, 19
	beq s1, t0, endreadstringwhile #stop at 19 characters
	
	jal readchar #ra= char c = getchar();
	

	li t0, '\n' #enter
	beq a0, t0, endreadstringwhile

	
	sb a0, 0(s5) 
	addi s5, s5, 1 #i++
	addi s1, s1, 1
			#addi t1, t1, 1 #acts like i++ for str[i]
	b readstringwhile
	
endreadstringwhile:

if:
	li t0, 19
	bne s1, t0 endif
	li t0, '\n'
	mv a0, t0
	jal printchar
	
endif:
	sb x0, 0(s5) #array is complete; str[i] - 0
	
	lw ra, svra
	ret
