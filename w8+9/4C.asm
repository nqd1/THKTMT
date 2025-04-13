.data
ask:				.asciz	"enter string: "
input:			.space	4096		
nl:				.asciz	"\n"
output_msg:		.asciz	"longest	word: "
error_msg:		.asciz	"error: no word entered"

.text

main:
	# prt ask
	la		a0, ask
	li		a7, 4
	ecall

	# read str
	la		a0, input
	li		a1, 4096
	li		a7, 8
	ecall

	# chk empty input (\0 or \n)
	la		s0, input
	lb		t0, 0(s0)
	li		t1, 10	# '\n'
	beq	t0, zero, print_error
	beq	t0, t1, print_error

	# init ptrs & lens
	mv		s1, s0	# cur word start
	mv		s2, s0	# max	word	start
	li		s3, 0		# cur	len
	li		s4, 0		# max	len

loop:
	lb		t0, 0(s0)
	beq	t0, zero, done
	
	j 		check_alph
	

	
is_alph:
	
	addi	s3, s3, 1		# cur	len++
	addi	s0, s0, 1		# move	ptr
	j	loop

not_alph:

check_max:
	bgt	s3, s4, update_max
	j	reset_word
update_max:
	mv		s4, s3	# max	len = cur len
	mv		s2, s1	# max	ptr = cur ptr
reset_word:
	addi	s0, s0, 1
	mv		s1, s0
	li		s3, 0
	j	loop

done:
	# cmp last word
	bge	s3, s4, update_final
	j	print_result
update_final:
	mv		s4, s3
	mv		s2, s1

print_result:
	# if no word, print err
	beqz	s4, print_error

	la		a0, output_msg
	li		a7, 4
	ecall

	mv		t0, s4
	mv		t1, s2
print_loop:
	beqz	t0, exit
	lb		a0, 0(t1)
	li		a7, 11
	ecall
	addi	t1, t1, 1
	addi	t0, t0, -1
	j	print_loop

print_error:
	la		a0, error_msg
	li		a7, 4
	ecall

exit:
	la		a0, nl
	li		a7, 4
	ecall

	li		a7, 10
	ecall
	
check_alph:
	li t1, 0x41			# A
	li t2, 0x5A			# Z
	li t3, 0x61			# a
	li t4, 0x7A			# z
	#AZ___az
	blt t0, t1, not_alph		# branch if t0 < A (0x41)

	# check if t0 > z
	bgt t0, t4, not_alph		# branch if t0 > z (0x7A)
	
	# now: A <= t0 <= z.
	# check if A-Z or a-z 
	
	# check if t0 <= Z
	ble t0, t2, is_alph    # if t0 <= Z, t0 is uppercase -> branch to is_alph
	
	# if t0 > Z, check if < a
	blt t0, t3, not_alph   # if t0 < a, t0 is in the gap -> not_alph
	
	# remaining: t0 is in a-z
	j	is_alph
	
	
