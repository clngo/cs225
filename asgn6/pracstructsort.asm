.globl swap
.globl selectionSort
.globl printArray

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
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s0, 16(sp) #arr[]
	sw s1, 12(sp) #int i
	sw s2, 8(sp) #int n
	sw s3, 4(sp) #int j
	sw s4, 0(sp) #min
	
	mv s0, a0
	mv s1, a1
	mv s2, a2
	
#    /* find the minimum element in the unsorted subarray `[i…n-1]`
#    // and swap it with `arr[i]`  */
#    int j;
	
#    int min = i;
	mv s4, a1



#    for (j = i + 1; j < n; j++)    {
for1:
	addi s3, s1, 1 #j = i + 1
	
forloop1:
	bge s3, s2, endfor1 #j < n; !(j >= n)
	
	slli t0, s3, 4 #index offset of 16 (j)
	add t0, t0, s0 #t0 = &arr[j]
	addi t0, t0, 8 #t0 = &arr[j].studentid
	lw t1,(t0) #t1 = value arr[j].studentid
	
	
	slli t0, s4, 4 #index offset of 16 (min)
	add t0, t0, s0 #t0 = &arr[min]
	addi t0, t0, 8 #t0 = &arr[min].studentid
	lw t2,(t0) #t2 = value arr[min].studentid
	
#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {
if1:
	bge t1, t2, endif1 

#            min = j;    /* update the index of minimum element */
	mv s4, s3


#        }
endif1:
	addi s3, s3, 1
	b forloop1
	
endfor1:
	
#    }
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#caller setup goes here
	mv a0, s0
	mv a1, s4
	mv a2, s1
#    swap(arr, min, i);
	jal swap


#caller teardown goes here (if needed)
 
#    if (i + 1 < n) {

if2:
	addi t0, s1, 1 #t0 = i+1
	bge t0, s2, endif2
#caller setup goes here
	mv a0, s0
	mv a1, t0
	mv a2, s2
#        selectionSort(arr, i + 1, n);
	jal selectionSort

#caller teardown goes here (if needed)

#    }
endif2:
    
#callee teardown goes here (if needed)
	lw ra, 20(sp)
	lw s0, 16(sp)
	lw s1, 12(sp)
	lw s2, 8(sp)
	lw s3, 4(sp)
	lw s4, 0(sp)
	addi sp, sp, 24
	ret


#}
 
#/* Function to print `n` elements of array `arr` */ 
#void printArray(studentNode arr[], int n) {
printArray:
#callee setup goes here
	addi sp, sp, -16
	sw ra, 12(sp)
	sw s0, 8(sp) #arr[]
	sw s1, 4(sp) #int n
#    int i;
	sw s2, 0(sp) #int i
	
	mv s0, a0
	mv s1, a1

#    for (i = 0; i < n; i++) {
for2:
	mv s2, x0 #i = 0

forloop2:
	bge s2, s1, endfor2 #i < n; !(i >= n)
	
#use ecalls to implement printf
#        printf("%d ", arr[i].studentid);
	slli t0, s2, 4 #index offset of 16 (i)
	add t0, t0, s0 #t0 = &add[i]
	addi t0, t0, 8 #t0 = &add[i].studentid
	lw a0, (t0) #a0 = value add[i].studentid
	
	li a7, 1
	ecall
	
	li a0, ' '
	li a7, 11
	ecall
#        printf("%s ", arr[i].name);
	slli t0, s2, 4 #index offset of 16 [i]
	add a0, t0, s0 #&arr[i]
	#addi t0, t0, 0 #&arr[i].name
	#lw a0, 0(t0) #a0 = value arr[i].name

	li a7, 4
	ecall
	
	li a0, ' '
	li a7, 11
	ecall
#        printf("%d\n", arr[i].coursenum);
	slli t0, s2, 4 #index offset of 16 (i)
	add t0, t0, s0 #t0 = &arr[i]
	addi t0, t0, 12 #t0 = &arr[i].coursenum
	lw a0, (t0) #a0 = value arr[i].coursenum
	
	li a7, 1
	ecall
	
	li a0, '\n'
	li a7, 11
	ecall
	
	addi s2, s2, 1
	b forloop2
#    }
endfor2:

#caller teardown goes here
	lw ra, 12(sp)
	lw s0, 8(sp)
	lw s1, 4(sp)
	lw s2, 0(sp)
	addi sp, sp, 16
	ret

#}
 
 

#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#caller setup goes here
	addi sp, sp, -20
	sw ra, 16(sp)
	sw s0, 12(sp)
	sw s1, 8(sp)
	sw s2, 4(sp)
	sw s3, 0(sp)
#    studentNode temp = arr[i];
	slli t0, a1, 4 #index offset of 16 (i)
	add t0, t0, a0 #t0 = &arr[i]
	lw t1, 0(t0)
	lw t2, 4(t0)
	lw t3, 8(t0)
	lw t4, 12(t0)
	
#    arr[i] = arr[j];
	slli t5, a2, 4 #index offset of 16(j)
	add t5, t5, a0 #t5 = &arr[j]
	lw s0, 0(t5)
	lw s1, 4(t5)
	lw s2, 8(t5)
	lw s3, 12(t5)
	
	#arr[i] = arr[j] ; #t0 = t5
	sw s0, 0(t0)
	sw s1, 4(t0)
	sw s2, 8(t0)
	sw s3, 12(t0)
	
#    arr[j] = temp; #t5 = t0
	sw t1, 0(t5)
	sw t2, 4(t5)
	sw t3, 8(t5)
	sw t4, 12(t5)

#caller teardown goes here
	lw ra, 16(sp)
	lw s0, 12(sp)
	lw s1, 8(sp)
	lw s2, 4(sp)
	lw s3, 0(sp)
	addi sp, sp, 20
	ret

#}
