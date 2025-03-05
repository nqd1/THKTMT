# Laboratory Exercise 4, Home Assignment 2
.text
	li s0, 0x12345678 # Test value
	andi t0, s0, 0xff # Extract LSB of s0
	andi t1, s0, 0x0400 # Extract bit 10 of s0
	#0x0400 = 0b100 0000 0000