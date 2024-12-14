.globl reverse
reverse:
	li t0, 0 #counter = t0 = 0

forloop1:
	lb t1, (a0) #t1 = arr[i]
	beqz t1, endloop1
	addi a0, a0, 1
	addi t0, t0, 1
	b forloop1
endloop1:
	