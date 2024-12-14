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
    
	#    /* find the minimum element in the unsorted subarray `[i…n-1]`
	#    // and swap it with `arr[i]`  */
	#    int j; s0
	mv s1, a1#    int min = i; min = s1



#    for (j = i + 1; j < n; j++)    {
for1:
	addi s0, a1, 1 #j = i + 1; 


forloop1:
	bge s0, a2, endfor1 # j < n;  j>= n, end

#        /* if `arr[j]` is less, then it is the new minimum */
#        if (arr[j].studentid < arr[min].studentid) {
if1:
	add t1, a0, s0 #t1 = arr[j]
	addi t2, t1, 1 #t2 = arr[j].studentid
	
	add t3, a0, s1 #t3 = arr[min]
	addi t4, t3, 1 #t4 = arr[min].studentid
	
	bge t2, t4, endif1 #arr[j].studentid < arr[min].studentid;  arr[j].studentid >= arr[min].studentid, endif1
	mv s1, s0 #min = j
	
	

#            min = j;    /* update the index of minimum element */


#        }
endif1:
	b forloop1
	

endfor1:
	
#    }
 
#    /* swap the minimum element in subarray `arr[i…n-1]` with `arr[i] */
#caller setup goes here


#    swap(arr, min, i);
	#swap returns void, no need to preserve argument registers; also same parameters
	#preserve ret
	addi sp, sp -16
	sw ra, 12(sp) #ra in stack
	
	sw s3, 8(sp)
	mv s3, a0(sp) #save array into s3
	
	sw s4, 4(sp)
	mv s4, a1 #saves i into s4
	
	sw s5, 0(sp)
	mv s5, a2 #saves n into s5
	
	jal swap
	
	lw ra, 12(sp) #restores ra

#caller teardown goes here (if needed)
#    if (i + 1 < n) {
if2:
	addi t0, s4, 1 #to = i + 1
	bge t0, a5 endif2 # i+1 < n -> i+1>= n
	
#caller setup goes here
	addi sp, sp, -16
	sw ra, 12(sp)
	
	

#        selectionSort(arr, i + 1, n);

#caller teardown goes here (if needed)


#    }
endif2:
    
#callee teardown goes here (if needed)


#}
 
#/* Function to print `n` elements of array `arr` */ 
#void printArray(studentNode arr[], int n) {
printArray:
#callee setup goes here

#    int i;

#    for (i = 0; i < n; i++) {
for2:


forloop2:

#use ecalls to implement printf
#        printf("%d ", arr[i].studentid);


#        printf("%s ", arr[i].name);


#        printf("%d\n", arr[i].coursenum);


#    }
endfor2:

#caller teardown goes here

#}
 
 

#/* Utility function to swap values at two indices in an array*/
#void swap(studentNode arr[], int i, int j) {
swap:
#caller setup goes here

#    studentNode temp = arr[i];


#    arr[i] = arr[j];


#    arr[j] = temp;


#caller teardown goes here


#}
