.text
.globl main
main:
# Print a list of strings.
# using t1 as the table index/vector

    li a7, 4 # printstring routine code

    la t0, list
    li    t1, 0    # init table index.
    li    t2, 0		# temp address.
    li    t3, -1

    lw a0, 0(t0) # first address in string table.
loop:
    beq     a0, t3, endloop
    ecall    #print the string.
    addi    t1, t1, 1    #increment table index
    slli    t2, t1, 2     # convert index to offset
    add	  t2, t2, t0  # add offset to table base address
    lw     a0, 0(t2) # get the starting address of str1
    b loop
endloop:

    
    li	t1 9
    la	a0, errormsg
    #now print using index = 3 as a vector.
    li    t3, 6  # MAXINDEX or number ofentries in table
    blt	t1, zero printit  # index too small
    bge	t1, t3, printit   # index too large

    # index good, get address
    slli    t2, t1, 2     # convert index to offset
    add	  t2, t2, t0  # add offset to table base address
    lw     a0, 0(t2) # get the starting address of str1
   
    printit:
    ecall    #print the string.
   

    li a7, 10
    ecall

# do stuff
.data #located at 0x10010000
list:
    .word str1
		default
		str3
		default
		default
		str3
		-1  # flag value for end of table

    .string "Lets fill this space with garbage"
str1: .string "apple\n"
str2: .string "dog\n"
str3: .string "planet\n"
default: .string "default\n"

errormsg: .string "\nnice try\n"

