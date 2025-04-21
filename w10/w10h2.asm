.eqv MONITOR_SCREEN 0x10010000
.eqv RED	0x00FF0000
.eqv BLUE	0x000000FF

.text
main:
	li t0, 0			# i = 0 (row)
row_loop:
	li t1, 0			# j = 0 (col)

col_loop:
	# addr = base + (i * 8 + j) * 4
	slli t3, t0, 3		# t3 = 8*i
	add t3, t3, t1		# t3 = i*8 + j
	slli t3, t3, 2		# t3 *= 4 
	li t4, MONITOR_SCREEN
	add t3, t3, t4		# t3 = final addr

	add t5, t0, t1		# t5 = i + j
	andi t5, t5, 1		# (i+j)%2
	beqz t5, use_red
	li t6, BLUE
	j store

use_red:	
	li t6, RED

store:
	sw t6, 0(t3)		# store color

	addi t1, t1, 1		# j++
	li t6, 8
	blt t1, t6, col_loop

	addi t0, t0, 1		# i++
	blt t0, t6, row_loop

exit:
	li a7, 10
	ecall
