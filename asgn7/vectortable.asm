.text
.data #located at 0x10010000
# vectortable is a table of subroutine labels.
# each entry in the vectortable is a MMIO subroutine.
# a default subroutine is used for unsupported or invalid entries.
# Use the ecall service number as an index into the table.
# Must do own bounds checking on index to verify number is within range.

vectortable:
     .word default    #0 there is no ecall 0 but use default handler.
     .word printint   #1 for printint ecall
     .word default    #2
     .word default    #3
     .word readstring #4 for readstring ecall
     .word readint    #5 for readint ecall
     .word default    # all other unsupported or invalid ecalls
     # table is incomplete.
     # complete table using your MMIO routines.

.globl main
main:
    li a7, 4
    # how to convert ecall # into offset into vectortable:
    # use service # as index into vectortable.
    # convert index to offset into vectortable.
    # t1 <- index a7 converted to offset. 
    # t0 <- start of vectortable

    la t0 vectortable
    add t2, t0, t1  # add offset to start of table.
    lw t3, (t2)     # read the table entry to get start of MMIO routine.
    jalr ra, 0(t2)  # jump to MMIO routine

    b main

default: # for undefined or unsupported ecalls
    ret
printint: #1
    ret
readstring: #4
    ret
readint: #5
    ret

