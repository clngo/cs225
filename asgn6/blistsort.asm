.globl	recurSelectionSort
recurSelectionSort:
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s0, 16(sp)
	sw s1, 12(sp)
	sw s2, 8(sp)
	sw s3, 4(sp)
	sw s4, 0(sp)
#struct Node* recurSelectionSort(struct Node* head) {
	mv s0, a0

#	if (head->next == NULL)
	addi t0, s0, 16
	lw t0, 0(t0)
	beqz t0, end

#		return head;


#	struct Node* min = head;
	mv s1, a0

#	struct Node* beforeMin = NULL;
	mv s2, zero

#	struct Node* ptr;

#	for (ptr = head; ptr->next != NULL; ptr = ptr->next) {
forinit:
	mv s3, s0

forloop:
	addi t1, s3, 16
	lw t1, 0(t1)
	beqz t1, endfor

#		if (ptr->next->studentid < min->studentid ) {
ifmin:
	addi t2, s3, 16
	lw t2, 0(t2)
	addi t2, t2, 8
	lw t3, 0(t2)
	addi t4, s1, 8
	lw t5, 0(t4)
	bge t3, t5, endifmin

#			min = ptr->next;
#			beforeMin = ptr;
	mv s1, t2
    	mv s2, s3
    	
    	lw t6, 0(t2)
    	sw t6, 0(s1)

	
endifmin:
	j forloop
	
#		}


endfor:
#	}


if2:
#	if (min != head)
	beq s1, s0, endif2

#		swapNodes(&head, head, min, beforeMin);
	sw s1, 4(sp)  
	
	mv a1, s1
    	mv a2, s0
    	mv a3, s1
    	mv a4, s2
	jal swapNodes

endif2:

#	head->next = recurSelectionSort(head->next);
	addi t2, s0, 16
	lw t3, 0(t2)

	mv a0, t3
	jal recurSelectionSort
	
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
