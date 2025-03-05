.text 
	li s0, 0x87654321
	li t0, 0xff000000
	li t1, 0xffffff00
	and s1, s0, t0		#Trích xuất MSB của thanh ghi s0
	and s0, s0, t1 	#Xóa LSB của thanh ghi s0
	ori s0, s0, 0x000000ff#Thiết lập LSB của thanh ghi s0 (bit 7 đến bit 0 được thiết lập bằng 1)
	#neg s0, s0
	and s0, s0, zero	#Xóa thanh ghi s0 bằng cách dùng các lệnh logic (s0 = 0)
	