.globl printint printstring printchar readchar readint exit0
.text
printint: 
	li a7, 1
	ecall
	ret
	
printstring:
	li a7, 4
	ecall
	ret
	
printchar:
	li a7, 11
	ecall
	ret
	
	
readchar: 
	li a7, 12
	ecall
	ret
	
readint: 
	li a7, 5
	ecall
	ret
	
exit0:
	li a7, 10
	ecall
	
