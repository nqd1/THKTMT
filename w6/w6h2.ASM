.data
	A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
	Aend: .word			
	# Aend duoc cap phat dia chi ngay sau A
	nl: .asciz "\n"
	space: .asciz " "
	msg: .asciz "th loop: "
.text
main:
	la a2, A
	la a1, Aend
	addi a1, a1, -4
	li a5, 1 	#loop counter
	j sort

after_sort:
	li a7, 10
	ecall

end_main:

sort:
	beq a2, a1, done
	j max

after_max:
	lw t0, 0(a1)
	sw t0, 0(s0)
	sw s1, 0(a1)
	addi a1, a1, -4

	j print_array    

done:
	j after_sort

max:
	addi s0, a2, 0
	lw s1, 0(s0)
	addi t0, a2, 0

loop:
	beq t0, a1, ret
	addi t0, t0, 4
	lw t1, 0(t0)
	blt t1, s1, loop
	addi s0, t0, 0
	addi s1, t1, 0
	j loop

ret:
	j after_max

print_array:
	mv a0, a5        
	li a7, 1
	ecall

	la a0, msg    # "nth loop: "
	li a7, 4
	ecall

	la a3, A
	la a4, Aend
	addi a4, a4, -4

print_loop:
	lw a0, 0(a3)    
	li a7, 1
	ecall

	la a0, space
	li a7, 4
	ecall

	addi a3, a3, 4
	ble a3, a4, print_loop

print_last:
	la a0, nl
	li a7, 4
	ecall

	addi a5, a5, 1   # counter++
	j sort
