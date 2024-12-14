.globl strcpy
strcpy:
	
for:
	lb t1, (a0)	#t1 = arr
	sb a0, (a1)
	beqz t1, end
	addi a1, a1, 1
	addi a0, a0, 1
	b for
	
end:
	ret
