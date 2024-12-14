.globl printhex
printhex:
	addi sp, sp, -16
	sw	ra, 12(sp)
	sw	s0, 8(sp)
	sw	s1, 4(sp)

	mv	s0, a0   #preserve arg
	li s1, 28    # shift counter
	
looph:
	li t1, 0xf   # hexval mask.
	sll	 a1, t1, s1 #shift hexval mask into position
	and  a0, a1, s0 #isolate hexval of interest
	srl	 a0, a0, s1 # move hexval into a0 
	li t4, 0x39  
	addi a0, a0, 0x30 # convert hexval into char 
	ble a0, t4, AtoFval # if val is A-F 
	addi a0, a0, 7
AtoFval:
#	jal printchar
	li	a7, 11
	ecall

	addi s1, s1, -4    #decrement shift counter.
	bge  s1, zero, looph  #done when counter <0

	lw	ra, 12(sp)
	lw	s1, 4(sp)
	lw	s0, 8(sp)
	addi sp, sp, 16
	ret


