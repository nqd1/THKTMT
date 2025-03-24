.data
min_msg:   .string "min = "
at_msg:    .string ", at "
max_msg:   .string "max = "
newline:   .string "\n"

.text
main:
	li a0, 1
	addi sp, sp, -4
	sw a0, 0(sp)

   li a1, 2
   addi sp, sp, -4
	sw a1, 0(sp)
	
   li a2, 3
   addi sp, sp, -4
	sw a2, 0(sp)
	
   li a3, 4
   addi sp, sp, -4
	sw a3, 0(sp)
	
   li a4, 5
   addi sp, sp, -4
	sw a4, 0(sp)
	
   li a5, 6
   addi sp, sp, -4
	sw a5, 0(sp)
	
   li a6, 10
   addi sp, sp, -4
	sw a6, 0(sp)
	
   li a7, 2
   addi sp, sp, -4
	sw a7, 0(sp)
	
   addi sp, sp, -24
   mv s0, a0	# min.value
   mv s1, a0	# max.value
   li s2, 0		# min.index
   li s3, 0		# max.index
   li s4, 1 	# index (starts from 1) 
   bge a1, s0, not_min_1
   mv s0, a1
   mv s2, s4
not_min_1:
   ble a1, s1, not_max_1
   mv s1, a1
   mv s3, s4
not_max_1:
   addi s4, s4, 1 
   bge a2, s0, not_min_2
   mv s0, a2
   mv s2, s4
not_min_2:
   ble a2, s1, not_max_2
   mv s1, a2
   mv s3, s4
not_max_2:
   addi s4, s4, 1
   bge a3, s0, not_min_3
   mv s0, a3
   mv s2, s4
not_min_3:
   ble a3, s1, not_max_3
   mv s1, a3
   mv s3, s4
not_max_3:
   addi s4, s4, 1
   bge a4, s0, not_min_4
   mv s0, a4
   mv s2, s4
not_min_4:
   ble a4, s1, not_max_4
   mv s1, a4
   mv s3, s4
not_max_4:
   addi s4, s4, 1
   bge a5, s0, not_min_5
   mv s0, a5
   mv s2, s4
not_min_5:
   ble a5, s1, not_max_5
   mv s1, a5
   mv s3, s4
not_max_5:
   addi s4, s4, 1
   bge a6, s0, not_min_6
   mv s0, a6
   mv s2, s4
not_min_6:
   ble a6, s1, not_max_6
   mv s1, a6
   mv s3, s4
not_max_6:
   addi s4, s4, 1
   bge a7, s0, not_min_7
   mv s0, a7
   mv s2, s4
not_min_7:
   ble a7, s1, not_max_7
   mv s1, a7
   mv s3, s4
not_max_7:
   addi s2, s2, 1
   addi s3, s3, 1
   la a0, min_msg
   li a7, 4
   ecall
   mv a0, s0
   li a7, 1
   ecall
   la a0, at_msg
   li a7, 4
   ecall
   mv a0, s2
   li a7, 1
   ecall
   la a0, newline
   li a7, 4
   ecall
   la a0, max_msg
   li a7, 4
   ecall
   mv a0, s1
   li a7, 1
   ecall
   la a0, at_msg
   li a7, 4
   ecall
   mv a0, s3
   li a7, 1
   ecall
   lw ra, 0(sp)
   li a7, 10
   ecall
