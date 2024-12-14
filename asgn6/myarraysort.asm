.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here

#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */

# callee setup
    	addi sp, sp, -32	# allocate space on the stack
	sw ra, 28 (sp)	# store ra
	sw s0, 24(sp)	# allocate space for arr
	sw s1, 20(sp)	# allocate space for i
	sw s2, 16(sp)	# allocate space for n
	sw s3, 12(sp)	# allocate space for min
	sw s4, 8(sp)  	# allocate space for j
	
	mv s0, a0	# s0 = arr
	mv s1, a1	# s1 = i
	mv s2, a2	# s2 = n

#    int j;
#    int min = i;
	mv s3, a1   # s3 = min = i

#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	addi s4, s1, 1   # s4 = j = i + 1

forloop:
# j < n
	bge s4, s2, endfor   # if (j >= n) branch

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:
	slli t0, s4, 2  # t0 = j * 4
	add t0, t0, s0  # t0 = &arr[j]
	lw t1, (t0)    	# t1 = arr[j]
	slli t2, s3, 2  # t2 = min * 4
	add t2, t2, s0  # t2 = &arr[min]
	lw t3, (t2)    	# t3 = arr[min]
	bge t1, t3, endif1  # if (arr[j] >= arr[min]) branch

#            min = j;    /* update the index of minimum element */
	mv s3, s4	# min = j

#        }
endif1:
	# increment j
   	addi s4, s4, 1	# j++
   	j forloop	# branch to forloop

#    }
endfor:
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
#caller setup and subroutine call for swap goes here.
	mv a0, s0   # a0 = arr
    	mv a1, s3   # a1 = min
    	mv a2, s1   # a2 = i
    	jal ra, swap	# call the swap subroutine

#caller teardown for swap goes here (if needed).
 
#    if (i + 1 < n) {
if2:
	addi t0, s1, 1		# i + 1
	bge t0, s2, endif2 	# if (i + 1 < n)
	
#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.
	mv a0, s0	# a0 = s0 = arr
	mv a1, t0	# a1 = t0 = i
	mv a2, s2	# s2 = s2 = n
	jal selectionSort	# recursion
    
#caller teardown for selectionSort goes here (if needed).

#    }
endif2:
# callee teardown goes here
	lw ra, 28(sp)	# restore ra
	lw s0, 24(sp)	# restore s0
	lw s1, 20(sp)	# restore s1
	lw s2, 16(sp)	# restore s2
	lw s3, 12(sp)	# restore s3
	lw s4, 8(sp)	# restore s4
	addi sp,sp,32	# restore stack
	ret	# return

#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here
	addi sp, sp, -16	# allocate space on the stack
	sw ra, 12(sp)		# store ra on the stack

#    int temp = arr[i];
	slli t0, a1, 2
	add t0, t0, a0  	# load i offset
	lw t1, (t0)		# get arr[i]

#    arr[i] = arr[j];
	slli t2, a2, 2	# calculate memory offset for arr[i]
	add t2, t2, a0  # load j offset
	lw t3, (t2)	# arr[j] = t3
	sw t3, (t0)	# store t3 in arr[i]

#    arr[j] = temp;
	sw t1, (t2)    # arr[j] = temp

# swap callee teardown goes here
	lw ra, 12(sp)		# restore ra
	addi sp, sp, 16		# reset stack pointer
	ret			# return

#}
