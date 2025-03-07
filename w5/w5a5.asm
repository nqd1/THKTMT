.data
buffer: .space 22 # 20 characters + \0 + 1 byte tránh overflow
ask: .asciz "Enter a string (max 20 characters): "
inverted_string: .space 22 # Space for the inverted string
err: .asciz "Entered string is empty"
.text
.globl main

main:    
    li a7, 4
    la a0, ask
    ecall

    li a7, 8 
    la a0, buffer
    li a1, 21 # Maximum len 20 char + \0
    ecall

    lb t0, 0(a0) # Load first character of buffer
    li t1, 10    # '\n' (ASCII 10)
    beq t0, t1, end_error # If first character is '\n', jump to end.error

    la a1, inverted_string
    jal ra, reverse_string

    la a0, inverted_string
    li a7, 4 
    ecall

end:
    li a7, 10 
    ecall

end_error:
    li a7, 4
    la a0, err
    ecall
    
    li a7, 10
    ecall
    
reverse_string:
    mv t0, a0
    li t1, 0

find_length:
    lbu t2, 0(t0)
    beq t2, zero, length_found
    addi t0, t0, 1
    addi t1, t1, 1
    j find_length

length_found:
    addi t0, t0, -1 

reverse:
    lbu t2, 0(t0)
    sb t2, 0(a1)
    addi t0, t0, -1
    addi a1, a1, 1
    addi t1, t1, -1
    bnez t1, reverse
    sb zero, 0(a1)
    jr ra
