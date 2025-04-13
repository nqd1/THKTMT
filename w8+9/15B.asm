.data
	ask_n:	.asciz "enter array size: "
	ask_el:	.asciz "enter element: "
	ans:		.asciz "least freq element: "
	nl:		.asciz "\n"
	err_msg:	.asciz "an array cant have less than 0 elements!\n"
	err_n0:	.asciz "array is empty!\n"
.text
main:
input:
	# input n
	la			a0, ask_n
	li			a7, 4
	ecall

	li			a7, 5
	ecall
	
	bgtz		a0, valid_n
	beqz 		a0, err_0
	
	la			a0, err_msg
	li 		a7, 4
	ecall
	j 			input

err_0: 
	la			a0, err_n0		
	li			a7, 4
	ecall
	j			input

valid_n:
	mv			s0, a0 	# s0 = n

	# alloc stack: array + count = n * 8 bytes
	slli		t0, s0, 3	# t0 = n*8
	sub 		sp, sp, t0
	mv			s1, sp 	# s1 = array addr
	slli		t1, s0, 2	# t1 = n*4
	add 		s2, s1, t1 	# s2 = count addr

	# input array
	li			t2, 0	# i = 0
read_loop:
	bge 		t2, s0, read_done

	la			a0, ask_el
	li			a7, 4
	ecall

	li			a7, 5
	ecall
	slli		t3, t2, 2
	add	 	t4, s1, t3
	sw			a0, 0(t4)

	addi		t2, t2, 1
	j 			read_loop
read_done:

	# count freq
	li			t2, 0	# i
outer_loop:
	bge 		t2, s0, outer_done

	slli		t3, t2, 2
	add 		t4, s1, t3
	lw			t5, 0(t4)	# t5 = array[i]

	li			t6, 0			# j
	li			t1, 0			# freq = 0
inner_loop:
	bge 		t6, s0, store_freq

	slli		t3, t6, 2
	add 		t4, s1, t3
	lw			t0, 0(t4)	# t0 = array[j]

	bne 		t0, t5, skip_add
	addi		t1, t1, 1
skip_add:
	addi		t6, t6, 1
	j 			inner_loop

store_freq:
	slli		t3, t2, 2
	add 		t4, s2, t3
	sw			t1, 0(t4)

	addi		t2, t2, 1
	j 			outer_loop
	outer_done:

	# find min freq
	li			t2, 0
	li			t3, 2147483647 	# min_freq = intMAX
	li			t4, 0	# min_idx

find_loop:
	bge		t2, s0, print_res

	slli		t5, t2, 2
	add		t6, s2, t5
	lw			t0, 0(t6)			# t0 = count[i]

	blt 		t0, t3, update_min
	j 			skip_min
update_min:
	mv			t3, t0
	mv			t4, t2
skip_min:
	addi		t2, t2, 1
	j 			find_loop

print_res:
	slli		t5, t4, 2
	add 		t6, s1, t5
	lw			a1, 0(t6)

	la			a0, ans
	li			a7, 4
	ecall

	mv			a0, a1
	li			a7, 1
	ecall

	la			a0, nl
	li			a7, 4
	ecall

	# free stack
	slli		t0, s0, 3
	add 		sp, sp, t0

	li			a7, 10
	ecall
