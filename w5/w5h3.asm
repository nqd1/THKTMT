.data
string: .space 50
message1: .asciz "Nhap xau: "
message2: .asciz "Do dai xau la: "
.text
main:
get_string:
	li a7, 54
	la a0, message1
	la a1, string
	li a2, 50
	ecall 
	li a3, 0xa #value of newline in ascii
get_length:
	la a0, string # a0 = address(string[0])
	li t0, 0 # t0 = i = 0
	check_char:
	add t1, a0, t0 # t1 = a0 + t0 = address(string[0]+i) 
	lb t2, 0(t1) # t2 = string[i]
	beq t2, zero, end_of_str # Is null char?
	beq t2, a3, end_of_str # Is newline char?
	addi t0, t0, 1 # t0 = t0 + 1 -> i = i + 1
	j check_char
end_of_str:
end_of_get_length:
print_length:
	la a0, message2
	li a7, 56   
	mv a1, t0
	ecall

	
