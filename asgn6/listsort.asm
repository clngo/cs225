.globl	recurSelectionSort
#Colin Ngo
#Bernice Lau
recurSelectionSort:
	addi sp, sp, -24
	sw ra, 20(sp)
	sw s0, 16(sp) #head
	sw s1, 12(sp) #min
	sw s2, 8(sp) #beforeMin
	sw s3, 4(sp) #ptr
	sw a0, 0(sp) #Struct Node* head
#struct Node* recurSelectionSort(struct Node* head) {
	mv s0, a0 #copy of the head
#	if (head->next == NULL)

	lw t0, 16(s0)
	beqz t0, end

#		return head;


#	struct Node* min = head;
	mv s1, a0 #s1 = min

#	struct Node* beforeMin = NULL;
	mv s2, x0

#	struct Node* ptr;

#	for (ptr = head; ptr->next != NULL; ptr = ptr->next) {
forinit:
	mv s3, s0

forloop:
	#addi t1, s3, 16 #t1 = ptr->next
	#lw t1, 0(t1) #t1 = next (some node)
	
	lw t1, 16(s3) #t1 = ptr->next
	beqz t1, endfor

#		if (ptr->next->studentid < min->studentid ) {
ifmin:

	lw t2, 8(t1) #t2 = ptr->next->studentid
	#lw t3, 0(t2) #t3 = studentid
	lw t4, 8(s1) #min->studentid
	#lw t5, 0(t4) #t5 = studentid
	bge t2, t4, endifmin

#			min = ptr->next;
#			beforeMin = ptr;
	mv s1, t1
    	mv s2, s3
    	
    	#lw t6, 0(t2)
    	#sw t6, 0(s1)

	
endifmin:
	
	mv s3, t1
	b forloop
	
#		}


endfor:
#	}


if2:
#	if (min != head)
	beq s1, s0, endif2

#		swapNodes(&head, head, min, beforeMin);
	#sw s1, 4(sp)  
	#sw s4, (a0)
	#mv a0, s4
	addi a0, sp, 0
	#mv a0, t0
	mv a1, s0
    	mv a2, s1
    	mv a3, s2
	jal swapNodes

endif2:

#	head->next = recurSelectionSort(head->next);
	lw t2, 0(sp)
	lw a0, 16(t2)
	
	jal recurSelectionSort
	
	lw t2, 0(sp)
	sw a0, 16(t2)
	
end:
	lw ra, 20(sp)
	lw s0, 16(sp)	
	lw s1, 12(sp)	
	lw s2, 8(sp)	
	lw s3, 4(sp)	
	lw a0, 0(sp)	
	addi sp, sp, 24	
	ret

#	return head;



#}
