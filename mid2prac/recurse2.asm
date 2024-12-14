.text
main:
	li a0, 13
	jal recurse
	
	li a7, 1
	ecall
	
	li a7, 10
	ecall

recurse:
	addi sp, sp, -4
	sw ra, 0(sp)
	
if:
	bgtz a0, endif
	mv a0, x0
	b end
	
endif:
	addi a0, a0, -1 #a0 = x-1
	jal recurse
	addi a0, a0, 1 #1+recurse(x-1)
	
end:
	lw ra, 0(sp)
	addi sp, sp, 4
	ret 
	
	
