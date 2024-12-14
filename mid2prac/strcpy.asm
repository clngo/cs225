.globl strcpy
strcpy:
	
forloop:
	lb t0, (a0)#t0 = arr[0]
	sb t0, (a1) #ar1[0] = t0
	beqz t0, endloop
	addi a0, a0, 1
	addi a1, a1, 1
	b forloop
	
endloop:
	ret
