# Name: Bernice Lau
# Name: Colin Ngo

.data
interrupt_msg: .string "\nInitializing Interrupts\n"
key_msg: .string "\nKey Pressed is: "
exception_msg_1: .string "Runtime exception at "
exception_msg_2: .string ": "
exception_msg_3: .string " detected at "
load_address_misaligned_msg: .string "LOAD_ADDRESS_MISALIGNED"
load_access_fault_msg: .string "LOAD_ACCESS_FAULT"
store_address_misaligned_msg: .string "STORE_ADDRESS_MISALIGNED"
store_access_fault_msg: .string "STORE_ACCESS_FAULT"
environment_call_msg: .string "ENVIRONMENT_CALL"
undetermined_exception_msg: .string "UNDETERMINED_EXCEPTION"
interrupt_count: .word 0
RDR: .word 0xffff0004

.text
.globl int_init
.globl int_handler
.globl exception_handler

# int_init subroutine
int_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw t0, 8(sp)
	sw t1, 4(sp)
	
    	# Set the handler's address    
    	la t0, int_handler
    	csrrw x0, 5, t0 # set utvec (5) to the handler’s address

    	# Enable receiving device interrupts
    	li t0, 0x00000100
    	csrrs zero, 4, t0
    
    	# Enable the external device to send interrupts
    	li t0, 0xFFFF0000
    	lw t1, 0(t0)
    	ori t1, t1, 2
    	sw t1, 0(t0)
    
    	# Enable sending of device interrupts
    	csrrsi x0, 0, 1 # Enable global interrupt checking

    	# Print initialization message
    	la a0, interrupt_msg
    	jal printString
    
    	lw t1, 4(sp)
    	lw t0, 8(sp)
    	lw ra, 12(sp)
    	addi sp, sp, 16
    	ret
    
# int_handler (interrupt service routine)
int_handler:
    	# Preserve callee-save registers
    	addi sp, sp, -24
    	sw ra, 20(sp)
    	sw s0, 16(sp)
    	sw s1, 12(sp)
    	sw s2, 8(sp)
    	sw t0, 4(sp)
    	sw t1, 0(sp)
    
    	# Check if it's an interrupt or exception
    	csrr t0, ucause
    	beqz t0, interrupt_handler
    
    	# Exception handling
    	jal exception_handler
    	
    	# Return from exception, preserving all registers modified except a0
    	uret

 interrupt_handler:   	
    	# Read the key pressed
    	jal readChar
    	mv a0, t0

    	# Print the key pressed
    	la a0, key_msg
    	jal printString
    
    	# Read the key pressed
    	lw t1, RDR   # Load RDR register value
    	lbu a0, 0(t1)
    	mv s2, a0
    
    	jal printChar
    
    	li a0, '\n'
    	jal printChar

    	# Increment interrupt count
    	la s0, interrupt_count
    	lw s1, 0(s0)
    	addi s1, s1, 1
    	sw s1, 0(s0)

    	# Check interrupt count
    	lw s1, 0(s0)
    	li t0, 5  # Number of key presses required to update settings
    	bne s1, t0, int_handler_end

    	# Reset interrupt count to zero
    	sw zero, 0(s0)

    	# Set the handler's address to the start of main
    	lw t1, 0(sp)
    	lw t0, 4(sp)
    	lw s2, 8(sp)
    	lw s1, 12(sp)
    	lw s0, 16(sp)
    	lw ra, 20(sp)
    	jal main

int_handler_end:
    	# Restore callee-save registers

    	mv a0, s2
    	lw t1, 0(sp)
    	lw t0, 4(sp)
    	lw s2, 8(sp)
    	lw s1, 12(sp)
    	lw s0, 16(sp)
    	lw ra, 20(sp)
    	addi sp, sp, 24

    	# Return from interrupt, preserving all registers modified except a0
    	uret

# Exception handler
exception_handler:
   	# Preserve callee-save registers
    	addi sp, sp, -32
    	sw ra, 28(sp)
    	sw s0, 24(sp)
    	sw s1, 20(sp)
    	sw s2, 16(sp)
    	sw s3, 12(sp)
    	sw t0, 8(sp)
    	sw t1, 4(sp)
    	sw a0, 0(sp)

    	# Save preserved pc to return safely to the program
    	csrr t0, uepc   # Read epc value into t0
    	sw t0, 0(sp)   # Save epc value onto the stack

    	# Get the value of ucause
    	csrr s1, ucause

    	# Print the runtime exception information
    	li t0, 4
    	bne s1, t0, check_load_access_fault
    	la s2, load_address_misaligned_msg
    	j print_exception_info

check_load_access_fault:
	li t0, 5
   	bne s1, t0, check_store_address_misaligned
    	la s2, load_access_fault_msg
    	j print_exception_info

check_store_address_misaligned:
	li t0, 6
    	bne s1, t0, check_store_access_fault
    	la s2, store_address_misaligned_msg
    	j print_exception_info

check_store_access_fault:
	li t0, 7
    	bne s1, t0, check_environment_call
    	la s2, store_access_fault_msg
    	j print_exception_info

check_environment_call:
	li t0, 8
    	bne s1, t0, undetermined_exception
    	la s2, environment_call_msg
    	j print_exception_info

undetermined_exception:
    	la s2, undetermined_exception_msg

print_exception_info:
    	# Print the exception message
    	la a0, exception_msg_1
    	jal printString
    	
    	# Print the epc value
    	lw a0, 0(sp)
    	jal printInt
    	
    	# Print the second part of the exception message
    	la a0, exception_msg_2
    	jal printString

    	# Print the exception type message
    	mv a0, s2
    	jal printString
    	
    	# Print the third part of the exception message
    	la a0, exception_msg_3
    	jal printString

    	# Print the exception address
    	csrr a0, utval
    	jal printInt

    	# Restore registers
    	lw a0, 0(sp)
    	lw t1, 4(sp)
    	lw t0, 8(sp)
    	lw s3, 12(sp)
    	lw s2, 16(sp)
    	lw s1, 20(sp)
    	lw s0, 24(sp)
    	lw ra, 28(sp)
    	addi sp, sp, 32

    	# Return to the global handler
    	uret
