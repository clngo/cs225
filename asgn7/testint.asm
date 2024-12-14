# Name: Bernice Lau
# Name: Colin Ngo

.text
.globl main

main:
	# call interrupt initialization routine
	jal int_init
	# load asterisk into a0
	li a0, '*'
	
loop:
	# print '*' to runI/O window infinitely 	
	# li a7, 11
	# ecall
	
	# print '*' to MMIO

	jal printChar
	#jal int_handler
	j loop
