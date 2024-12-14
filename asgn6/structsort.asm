.globl swap	
.globl selectionSort
.globl printArray

#Bernice Lau
#Colin Ngo

#struct def'n for reference
#struct studentNode {
#   char name[6];
#   int studentid;
#   int coursenum;
#};

 
#/* Recursive function to perform selection sort on subarray `arr[i…n-1]` */
#void selectionSort(studentNode arr[], int i, int n) {
selectionSort:
#callee setup goes here
	addi sp, sp, -24	# allocate space for stack
	sw ra, 20(sp)	# store ra
	sw s0, 16(sp)	# allocate space for struct arr[]
	sw s1, 12(sp)	# allocate space for i
	sw s2, 8(sp)	# allocate space for n
	sw s3, 4(sp)	# allocate space for min
	sw s4, 0(sp)  	# allocate space for j
	
	mv s0, a0	# s0 = arr[]
	mv s1, a1	# s1 = i
	mv s2, a2	# s2 = n

#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */
#    int j;

#    int min = i;
	mv s3, a1	# min = i


#    for (j = i + 1; j < n; j++)    {
for1:
	addi s4, s1, 1 		# j = i + 1

forloop1:
	bge s4, s2, endfor1	# if j > n, branch

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {
if1:
	slli t0, s4, 4		# calculate j offset
	add t0, t0, s0  	# load j offset from arr starting address 
	addi t0, t0, 8		# add 8 offset to get ID num
	lw t1, (t0) 		# ID num value

	slli t0, s3, 4 		# calculate min offset
	add t0, t0, s0		# load min offset from arr starting address
	addi t0, t0, 8		# add 8 offset from arr[min]
	lw t2, (t0)		# ID num value

	bge t1, t2, endif1     # if arr[j] is >= arr[min], branch

#            min = j;    /* update the index of minimum element */
	mv s3, s4 		# min = j
	
#        }
endif1:
	addi s4, s4, 1 		# j++
	j forloop1		# branch

endfor1:

#    }
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#caller setup goes here
	mv a0, s0		# a0 = arr
	mv a1, s3		# a1 = min
	mv a2, s1		# a2 = i
	jal swap		# swap subroutine call

#    swap(arr, min, i);


#caller teardown goes here (if needed)
 
#    if (i + 1 < n) {
if2:
	addi t0, s1, 1		# i + 1
	bge t0, s2, endif2 	# if (i + 1 < n)

#caller setup goes here

#        selectionSort(arr, i + 1, n);
	mv a0, s0		# a0 = arr
	mv a1, t0 		# a1 = i + 1
	mv a2, s2		# a2 = n
	jal selectionSort	# recursion

#caller teardown goes here (if needed)


#    }
endif2:
    
#callee teardown goes here (if needed)
	lw ra, 20(sp)		# restore ra
	lw s0, 16(sp)		# restore struct arr[]
	lw s1, 12(sp)		# restore i
	lw s2, 8(sp)		# restore n
	lw s3, 4(sp)		# restore min
	lw s4, 0(sp)		# restore j
	addi sp, sp, 24		# reset the stack pointer
	ret			# return

#}
 
#/* Function to print `n` elements of array `arr` */ 
#void printArray(studentNode arr[], int n) {
printArray:
#callee setup goes here
	addi sp, sp, -16		# allocate stack space
	sw ra, 12(sp)			# save ra
	sw s0, 8(sp)			# save arr[]
	sw s1, 4(sp)			# save n

	mv s0, a0			# s0 = arr[]
	mv s1, a1			# s1 = n

#    int i;
	sw s2, 0(sp)			# intialize i
	
#    for (i = 0; i < n; i++) {
for2:
	li s2, 0			# i = 0

forloop2:
	bge s2, s1, endfor2	# if i >= n, branch
	
#use ecalls to implement printf
#        printf("%d ", arr[i].studentid);
	slli t0, s2, 4  	# index * 16	
	add t1, s0, t0 		# full index + base address
	addi t1, t1, 8 		# address of student id
	lw a0, 0(t1)		# load student id value

	#mv a0, t2   		# move t2 to a0
	li a7, 1		# load system call to print int
	ecall			# print int

	li a0, ' '		# load space into a0
	li a7, 11		# load system call to print char
	ecall              	# print char

#        printf("%s ", arr[i].name);
	addi t1, t1, -8		# get name starting address

	mv a0, t1   		# move t1 into a0
	li a7, 4		# load system call to print string
	ecall              	# print string
 
	li a0, ' '		# load space
	li a7, 11		# load system call to print char
	ecall              	# print char

#        printf("%d\n", arr[i].coursenum);
	addi t1, t1, 12 	# get starting address of course number 
	lw t4, 0(t1)		# load course num
	
	mv a0, t4  		# move t4 into a0
	li a7, 1		# load system call to print int
	ecall              	# print int

	li a0, '\n'		# load newline
	li a7, 11		# load system call to print char
	ecall              	# print char

	addi s2, s2, 1     	# i++
	j forloop2		# branch


#    }
endfor2:

#caller teardown goes here
	lw ra, 12(sp)		# restore ra
	lw s0, 8(sp)		# restore arr[]
	lw s1, 4(sp)		# restore n
	lw s2, 0(sp)		# restore i
	addi sp, sp, 16		# reset the stack pointer
	ret			# return

#}
 
 

#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#caller setup goes here
	addi sp, sp, -20	# allocate stack space
	sw ra, 16(sp)    		# save ra
	sw s0, 12(sp)		# save values
	sw s1, 8(sp)	
	sw s2, 4(sp)		
	sw s3, 0(sp)

#    studentNode temp = arr[i];
	slli t0, a1, 4		# calculate i offset
	add t0, t0, a0  	# load i offset from arr starting address
	lw t1, 0(t0) 		# load arr[i] into temp
	lw t2, 4(t0) 		# load values
	lw t3, 8(t0) 
	lw t4, 12(t0)  

#    arr[i] = arr[j];
	slli t5, a2, 4 		# calculate j offset
	add t5, t5, a0  	# t5 = arr[j]
	lw s0, 0(t5)		# load arr[j]
	lw s1, 4(t5)		# load values
	lw s2, 8(t5)
	lw s3, 12(t5)

	sw s0, 0(t0)		# store arr[j] into arr[i]
	sw s1, 4(t0)		# save values
	sw s2, 8(t0)
	sw s3, 12(t0)

#    arr[j] = temp;
	sw t1, 0(t5)		# store temp into arr[j]
	sw t2, 4(t5)		# save values
	sw t3, 8(t5)
	sw t4, 12(t5)

#caller teardown goes here
	lw ra, 16(sp)		# restore ra
	lw s0, 12(sp)		# restore values
	lw s1, 8(sp)	
	lw s2, 4(sp)	
	lw s3, 0(sp)
	addi sp, sp, 20		# reset the stack pointer
	ret			# return

#}
