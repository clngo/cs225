.data
string: .space 20

.text
main:
readString:
	la t1, string
while0:
	li a7, 12
	ecall
	
	li t0, '\n'
	beq a0, t0, end0
	
	sb a0, (t1)
	addi t1, t1, 1
	b while0
	
end0:
	la a0, string
	jal countLowerChars
	
	li a7, 1
	ecall
	
	li a7, 10
	ecall
	
countLowerChars:
	li t0, 0 #t0 = counter = 0
while:
	lb t1, (a0)
	beqz t1, end
if:
	li t2, 97 # !(t1 >= 97) = t1 < 97
    	blt t1, t2, else

    	li t2, 122 # !(t1 <= 122) = t1 > 122
    	bgt t1, t2, else
	
	addi t0, t0, 1
else:
	addi a0, a0, 1
	b while
	
end:
	mv a0, t0
	ret
