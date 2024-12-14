.globl strlen
strlen:
	mv t0, a0
	mv a0, x0 #counter = 0
for:
	lb t1, (t0)
	beqz t1, end
	addi a0, a0, 1
	addi t0, t0, 1
	b for
end:
	ret