.globl reverse
reverse:
	mv t0, a0
	mv t2, x0 #t2 = i; counter
forloop1: 
	lb t1, (t0)
	beqz t1, endloop1
	addi t2, t2, 1
	addi t0, t0, 1
	b forloop1
	
endloop1:
	addi, t2, t2, -1
forloop2:
	bltz t2, end #for t2 >= 0; !(t2 < 0)
	add t0, a0, t2#get arr[counter] where counter = t2
	lb t1, (t0)
	sb t1, (a1) #put arr[counter] to pointer
	addi t2, t2, -1 #decrement counter
	addi a1, a1, 1 #increment pointer
	b forloop2
	
end:
	sb x0, (a1)
	ret
	
	
	