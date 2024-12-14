.text
main:
	li a7, 5
	ecall
	
	jal countzeros
	
	li a7, 1
	ecall
	
	li a7, 10
	ecall
countzeros: 
	li t0, 0 #t0 = counter
	li t1, 1 #t1 = bit1
	not a0, a0 #inverse the bits

while:
	beqz a0, end
if:
	and t2, a0, t1
	beqz t2, else
	addi t0, t0, 1
else:
	srli a0, a0, 1
	b while

end:
	mv a0, t0
	ret