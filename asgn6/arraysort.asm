.globl swap 
.globl selectionSort
 
 #Bernice Lau
 #Colin Ngo
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here

#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */

# callee setup
    	addi sp, sp, -24	# allocate space on the stack
	sw ra, 20 (sp)	# store ra
	sw s0, 16(sp)	# allocate space for arr
	sw s1, 12(sp)	# allocate space for i
	sw s2, 8(sp)	# allocate space for n
	sw s3, 4(sp)	# allocate space for min
	sw s4, 0(sp)  	# allocate space for j
	
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
	lw t1, 0(t0)    	# t1 = arr[j]
	slli t2, s3, 2  # t2 = min * 4
	add t2, t2, s0  # t2 = &arr[min]
	lw t3, 0(t2)    	# t3 = arr[min]
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
	lw ra, 20(sp)	# restore ra
	lw s0, 16(sp)	# restore arr
	lw s1, 12(sp)	# restore i
	lw s2, 8(sp)	# restore n
	lw s3, 4(sp)	# restore min
	lw s4, 0(sp)	# restore j
	addi sp, sp, 24	# restore stack
	ret	# return

#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here
	addi sp, sp, -4	# allocate space on the stack
	sw ra, 0(sp)		# store ra on the stack

#    int temp = arr[i];
	slli t0, a1, 2
	add t0, t0, a0  	# load i offset
	lw t1, 0(t0)		# get arr[i]

#    arr[i] = arr[j];
	slli t2, a2, 2	# calculate memory offset for arr[i]
	add t2, t2, a0  # load j offset
	lw t3, 0(t2)	# arr[j] = t3
	sw t3, 0(t0)	# store t3 in arr[i]

#    arr[j] = temp;
	sw t1, 0(t2)    # arr[j] = temp

# swap callee teardown goes here
	lw ra, 0(sp)		# restore ra
	addi sp, sp, 4		# reset stack pointer
	ret			# return

#}
