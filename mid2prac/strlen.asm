.globl strlen
strlen:
	mv t0, x0 #counter = 0

forloop:
	mv t1, a0
	add t1, t1, t0
	lb t2, 0(t1)

	beqz t2, endloop
	addi t0, t0, 1
	
	b forloop

endloop:
	mv a0, t0
	ret
