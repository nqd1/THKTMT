.eqv SEVENSEG_LEFT	0xFFFF0011
.eqv SEVENSEG_RIGHT 0xFFFF0010

.data
SEG_TABLE:
	.byte 0x3F	# 0
	.byte 0x06	# 1
	.byte 0x5B	# 2
	.byte 0x4F	# 3	
	.byte 0x66	# 4
	.byte 0x6D	# 5
	.byte 0x7D	# 6
	.byte 0x07	# 7
	.byte 0x7F	# 8
	.byte 0x6F	# 9

.text
main:
	li a7, 12	# read char
	ecall

	li t3, 100
	remu t0, a0, t3	# get 2 last digits

	li t4, 10
	divu t1, t0, t4	# tens
	remu t2, t0, t4	# ones

	la t5, SEG_TABLE
	add t6, t5, t1
	lbu a1, 0(t6)

	add t6, t5, t2
	lbu a2, 0(t6)

	li t0, SEVENSEG_LEFT
	sb a1, 0(t0)

	li t0, SEVENSEG_RIGHT
	sb a2, 0(t0)

	j main
