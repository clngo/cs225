.text
lw t1, blah
la t2, OMG
lw t3, (t2)
lb t4, 4(t2)
lbu t5, 4(t2)
la t6, oops
lb t6, 6(t6)

.data
blah: .word 0x11223344
OMG: .byte 'a'
STRG: .string "test string!"
TEST1: .word 20
oops: .space 6
LOL: .byte -1
