.data
	A: .word -2, -3, -1, 0, 29
.text
main:
	la a0, A
	li a1, 5
	j mspfx
continue:
exit:
	li a7, 10
ecall
end_of_main:

mspfx:
	li s0, 0 # initialize length of prefix-sum in s0 to 0
	li s1, 0x80000000 # initialize max prefix-sum in s1 to smallest int
	li t0, 0 # initialize index for loop i in t0 to 0
	li t1, 0 # initialize running sum in t1 to 0
loop:
	add t2, t0, t0 # put 2i in t2	
	add t2, t2, t2 # put 4i in t2
	add t3, t2, a0 # put 4i+A (address of A[i]) in t3
	lw t4, 0(t3) # load A[i] from mem(t3) into t4
	add t1, t1, t4 # add A[i] to running sum in t1
	blt s1, t1, mdfy # if (s1 < t1) modify results
	j next
mdfy:
	addi s0, t0, 1 # new max-sum prefix has length i+1
	addi s1, t1, 0 # new max sum is the running sum
next:
	addi t0, t0, 1 # advance the index i
	blt t0, a1, loop # if (i<n) repeat
done:
	j continue
mspfx_end:
