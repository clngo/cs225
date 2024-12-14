.globl strcpy
strcpy:

forloop:
	lb t0, (a0) #t0 = src[i]
	sb t0, (a1) #*dest = src[i]
	beqz t0, endloop
	addi a0, a0, 1
	addi a1, a1, 1
	b forloop
	
endloop:
	ret
