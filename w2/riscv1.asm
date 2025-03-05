.data # Vung du lieu, chua cac khai bao bien
	x: .word 0x01020304 # Bien x, khoi tao gia tri
	msg: .asciz "Truong Cong nghe thong tin va Truyen thong"
.text # Vung lenh, chua cac lenh hop ngu
	la a0, msg # Dua dia chi bien mesage vao thanh ghi a0
	li a7, 4 # Gan thanh ghi a7 = 4
	ecall # Goi ham he thong in chuoi ky tu
	addi t1, zero, 2 # Thanh ghi t1 = 2
	addi t2, zero, 3 # Thanh ghi t2 = 3
	add t0, t1, t2 # Thanh ghi t0 = t1 + t2