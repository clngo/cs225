.globl addnums subnums multnums divnums andnums ornums xornums lshiftnums rshiftnums

addnums:
	add a0, a0, a1
	ret
	
subnums:
	sub a0, a0, a1
	ret

multnums:
	mul a0, a0, a1
	ret
	
divnums:
	div a0, a0, a1
	ret
	
andnums:
	and a0, a0, a1
	ret

ornums:
	or a0, a0, a1
	ret
	
xornums:
	xor a0, a0, a1
	ret

lshiftnums:
	sll a0, a0, a1
	ret

rshiftnums:
	srl a0, a0, a1
	ret
	
		
