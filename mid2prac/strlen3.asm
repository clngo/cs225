.globl strlen
strlen:
	li t0, 0

while:
	add t1, t0, a0
	lb t2, 0(t1)
	beq t2, zero, endwhile
	addi t0, t0, 1
	b while

endwhile:
	mv a0, t0
	ret