# Name: Bernice Lau
# Name: Colin Ngo

.data
interrupt_msg: .string "\nInitializing Interrupts\n"
key_msg: .string "\nKey Pressed is: "
interrupt_count: .word 0
RDR: .word 0xffff0004


.text
.globl int_init
.globl int_handler

# int_init subroutine
int_init:
	addi sp, sp, -16
	sw ra, 12(sp)
	sw t0, 8(sp)
	sw t1, 4(sp)
    # Set the handler's address

    
    la t0, int_handler
    csrrw x0, 5, t0 #set utvec (5) to the handler’s address

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
    addi sp, sp, -16
    sw ra, 12(sp)
    sw s0, 8(sp)
    sw t1, 4(sp)

    # Print the key pressed
    la a0, key_msg
    jal printString

    # Read the key pressed
    lw t1, RDR   # Load RDR register value
    lbu a0, (t1)
    mv s0, a0
    
    jal printChar
    
    li a0, '\n'
    jal printChar

    # Restore callee-save registers
    mv a0, s0
    lw t1, 4(sp)
    lw s0, 8(sp)
    lw ra, 12(sp)
    addi sp, sp, 16

    # Return from interrupt, preserving all registers modified except a0
    uret
