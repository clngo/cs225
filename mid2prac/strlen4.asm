.text
.globl strlen
strlen:
	mv t0, a0 #t1 = arr
	mv a0, x0
while:
	lb t1, (t0) #t1 = arr[i]
	beqz t1, end
	addi t0, t0, 1
	addi a0, a0, 1
	b while
end: 
	ret