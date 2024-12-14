.text
.globl exceptiontest

exceptiontest:
#INSTRUCTION_ADDR_MISALIGNED 	#0
#jump to an invalid address (like zero)
#try to load instruction at PC=0
#li	t1, 3
#jalr	ra, t1

#INSTRUCTION_ACCESS_FAULT	#1
#jalr ra, 0(zero)

#LOAD_ADDRESS_MISALIGNED	#4
li	t1, 3
lw	t0, (t1)

#LOAD_ACCESS_FAULT		#5
la	t1, main
lw	t0, 0(t1)

#STORE_ADDRESS_MISALIGNED	#6
li	t1, 3
sw	t0, 2(t1)

#STORE_ACCESS_FAULT		#7
la	t1, main
sw	t0, 0(t1)

ret
