# Name: Bernice Lau
# Name: Colin Ngo

.text
.globl main

main:
	# load asterisk into a0
	li a0, '*'
	
loop:
	# print '*' to runI/O window infinitely
	li a7, 11
	ecall
	
	# print '*' to MMIO
	jal printChar
	
	j loop
