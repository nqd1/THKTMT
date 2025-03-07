.data
	msg1: .asciz "The sum of "
	msg2: .asciz " and "
	msg3: .asciz " is "
	msg4: .asciz "\n"
.text
main:
    li s0, 10  
    li s1, 20
    li a7, 4
    la a0, msg1
    ecall # print "The sum of "
    li a7, 1
    mv a0, s0
    ecall # print value of s0
    
    li a7, 4
    la a0, msg2
    ecall # print " and "
    
    li a7, 1
    mv a0, s1
    ecall # print value of s1
    
    li a7, 4
    la a0, msg3
    ecall # print " is "
    
    add t0, s0, s1
    li a7, 1
    mv a0, t0
    ecall # print sum
    
    li a7, 10
    ecall
