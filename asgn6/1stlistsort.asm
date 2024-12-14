#.globl	recurSelectionSort
recurSelectionSort:
	addi sp, sp, -24
	sw ra, 20(sp) 
	sw s0, 16(sp) #head
	sw s1, 12(sp) #min
	sw s2, 8(sp) #beforeMin
	sw s3, 4(sp) #ptr
	sw s4, 0(sp) #&head
#struct Node* recurSelectionSort(struct Node* head) {
	mv s0, a0 #s0 is head ptr
	
	lw s4, (a0)

#	if (head->next == NULL)
	addi t0, s0, 16
	#lw t0, 16(s0) #offset of 16 of the node address to get next
	lw t0, 0(t0)
	beqz t0, end #t0 is next; if the next points to 0, stop
	
#		return head;

#	struct Node* min = head;
	mv s1, a0
	
#	struct Node* beforeMin = NULL;
	mv s2, x0
	
#	struct Node* ptr; saving that for s3

#	for (ptr = head; ptr->next != NULL; ptr = ptr->next) {
forinit:
	#ptr = head; s3 pointing to address of head
	mv s3, a0
	
forloop:
	#mv t0, s3
	addi t1, s3, 16
	#lw t2, 16(t0)
	beqz t2, endfor #next != NULL; !(next == NULL)

#		if (ptr->next->studentid < min->studentid ) {
ifmin:
	lw t2, 16(s3) #t2 = ptr->next
	lw t3, 0(t2)  #t2 is the node ptrnext is pointing at 
	lw t3, 8(t3) #t2 = ptr->next->studentid
	#lw t3, 0(t2) #t3 = studentid
	#addi t4, s1, 8
	lw t4, 8(s1)
	#lw t5, 0(t4)
	bge t2, t4, endifmin

#			min = ptr->next;
#			beforeMin = ptr;

	mv s1, t2
	#lw s1, 16(s3)
    	mv s2, s3
    	
    	
    	#lw t6, 0(t2)
    	#sw t6, 0(s1)

	
endifmin:
	#ptr = ptr -> next;
	addi s3, s3, 16
	
	b forloop
	
#		}


endfor:
#	}


if2:
#	if (min != head)
	beq s1, s0, endif2

#		swapNodes(&head, head, min, beforeMin);
	mv a0, s4
	#addi a0, sp, 0
	mv a1, s0
	#addi a1, sp, 16
    	mv a2, s1
    	#addi a2, sp, 12
    	mv a3, s2
    	#addi a3, sp, 8
	jal swapNodes

endif2:

#	head->next = recurSelectionSort(head->next);
	addi t2, s0, 16
	lw t3, 0(t2)

	mv a0, t3
	jal recurSelectionSort
	
	mv a0, s0
	
	
end:
	lw ra, 20(sp)
	lw s0, 16(sp)	
	lw s1, 12(sp)	
	lw s2, 8(sp)	
	lw s3, 4(sp)	
	lw s4, 0(sp)		
	addi sp, sp, 24	
	ret

#	return head;



#}
