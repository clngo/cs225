.globl swap 
.globl selectionSort
 
#void selectionSort(int arr[], int i, int n){
selectionSort:
# callee setup goes here
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s0, 16(sp) #arr[]
	sw s1, 12(sp) #i
	sw s2, 8(sp) #n
	sw s3, 4(sp) #j
	sw s4, 0(sp) #min

    #/* find the minimum element in the unsorted subarray `[i…n-1]`
    #// and swap it with `arr[i]`  */
    mv s0, a0 #arr[]
    mv s1, a1 #i
    mv s2, a2 #n
    
#    int j;

#    int min = i;
	mv s4, s1
	


#    for (j = i + 1; j < n; j++)    {

for:
#j = i + 1;
	addi t0, s1, 1 #t0 = i+1
	mv s3, t0 # j = i+1


forloop:
# j < n
	bge s3, s2, endfor


#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j] < arr[min]) {
if1:
	slli t0, s3, 2 #index offset of j
	add t0, t0, s0 #t0 = &arr[j]
	lw t1, 0(t0) #t1 = arr[j]
	
	slli t2, s4, 2 #index offset of min
	add t2, t2, s0 #t2 = arr[min]
	lw t3, 0(t2)
	
	#if arr[j] < arr[min]
	bge t1, t3, endif1
	
#            min = j;    /* update the index of minimum element */
	mv s4, s3


#        }
endif1:

	#j++
	addi s3, s3, 1
	b forloop
#    }
endfor:
 	mv a0, s0 #arr 
 	mv a1, s4 #min
 	mv a2, s1 # i
 	
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#    swap(arr, min, i);
	jal swap
#caller setup and subroutine call for swap goes here.

#caller teardown for swap goes here (if needed).
 
#    if (i + 1 < n) {
if2:
	addi t0, s1, 1 #t0 = i+1
	bge t0, s2, endif2

#        selectionSort(arr, i + 1, n);
#caller setup and subroutine call for selectionSort goes here.
	mv a0, s0 #arr
	mv a1, t0 #i+1
	mv a2, s2 #n
	
	jal selectionSort

#caller teardown for selectionSort goes here (if needed).


#    }
endif2:
	
# callee teardown goes here
	lw ra, 20(sp)
	lw s0, 16(sp)
	lw s1, 12(sp)
	lw s2, 8(sp)
	lw s3, 4(sp)
	lw s4, 0(sp)
	addi sp, sp 24
	ret
#}

 

#/* Utility function to swap values at two indices in an array*/
#void swap(int arr[], int i, int j) {
swap: 
# swap callee setup goes here
	addi sp, sp, -4
	sw ra, 0(sp)
	

#    int temp = arr[i];
	slli t0, a1, 2 #offset index for i
	add t0, t0, a0 #t1 = &arr[i]
	lw t1, (t0) #temp = arr[i]
	

#    arr[i] = arr[j];
	slli t2, a2, 2 #offset index of j
	add t2, t2, a0 #t3 = &arr[j]
	lw t3, (t2) #arr[i] = arr[j]

#    arr[j] = temp;
	sw t3, (t0) #arr[j](t3) = arr[i](t2)
	sw t1, (t2) #arr[i](t4) = arr[j](t1)
	

# swap callee teardown goes here
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
#}
