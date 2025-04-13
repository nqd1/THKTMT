.data
	ask:			.asciz	"Enter n: "	# input n
	nl:			.asciz	"\n"
	end_msg:		.asciz 	"\nTotal number of perfect nums: "
	err_msg: 	.asciz	" is not a possitive num, please enter again: "
	space: 		.asciz	" "
	
.text
main:
	# ask for n
	la		a0, ask
	li		a7, 4
	ecall
enter:
	li		a7, 5
	ecall
	bgtz 	a0, begin

error_handler:	
	li		a7, 1
	ecall
	la 	a0, err_msg
	li		a7, 4
	ecall
	
	j		enter

begin:	
	mv		s0, a0	# s0 = n

	li		s1, 1		# i = 1
	li		s2, 0		# s2 = count

main_loop:
	bge s1, s0, exit	# if i >= n, exit

	mv		a0, s1
	jal 	ra, isperfect
	beqz	a0, next # if not perfect, skip print

	mv		a0, s1
	li		a7, 1
	ecall

	la		a0, space
	li		a7, 4
	ecall

	addi	s2, s2, 1# count++

next:
	addi	s1, s1, 1
	j 		main_loop

exit:
	# print end message
	la		a0, end_msg
	li		a7, 4
	ecall

	mv		a0, s2
	li		a7, 1
	ecall

	la		a0, nl
	li		a7, 4
	ecall

	li	a7, 10
	ecall

# isperfect: check perfect?, return in a0, T/F = 1/0
isperfect:
	add 	t0, a0, zero # t0 = n
	li		t1, 0# sum = 0
	li		t2, 2
	div 	t3, a0, t2 # t3 = n / 2
	li		t4, 1# j = 1
	
loop_check:
	bgt 	t4, t3, done_check
	rem 	t5, t0, t4
	bnez	t5, skip
	add 	t1, t1, t4
skip:
	addi	t4, t4, 1
	j 		loop_check
	
done_check:
	beq t1, t0, ret_yes
	li		a0, 0
	jr		ra

ret_yes:
	li		a0, 1
	jr		ra
