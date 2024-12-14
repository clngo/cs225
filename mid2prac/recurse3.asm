.text
main:
	li a7, 5
	ecall
	
	jal recurse
	
	li a7, 1
	ecall
	
	li a7, 10
	ecall

recurse:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp)
	mv s0, a0
	
if:
	bgtz s0, else
	li a0, 0
	b end

else:
	addi a0, s0, -1
	jal recurse
	addi a0, a0, 1

end:
	lw s0, 8(sp)
	lw ra, 12(sp)
	addi sp, sp, 16
	ret