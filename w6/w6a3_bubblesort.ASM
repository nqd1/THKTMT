.data
   A: .word  7, -2, 5, 1, 129, 192, 12378, 5, 6, 7, 3, 6, 8, 8, 59, 5, 17
   Aend: .word
   nl: .asciz "\n"
   space: .asciz " "
   msg: .asciz "th loop: "

.text
main:
   la a1, A
   la a2, Aend
   addi a2, a2, -4

   j bubble_sort

after_sort:
   li a7, 10
   ecall

bubble_sort:
   add a3, a1, zero      # a3 = &(A[0]) 
   
outer:
   addi a3, a3, 4      # a3 = &(A[i+1])
   add a4, a2, zero      # a4 = &(A[n-1]) 
   li t3, 0            # Đặt t3 = 0 (chưa có swap)
   
   beq a3, a2, after_sort   # a3 == Aend-4?

inner_loop:
   lw t0, 0(a4)         # t0 = A[j]
   lw t1, -4(a4)         # t1 = A[j-1]

   blt t0, t1, swap      # A[j] < A[j-1] then swap
   
no_swap:
   addi a4, a4, -4      # j--
   bge a4, a3, inner_loop  # j >= i+1 then continue innerloop
   
   beqz t3, after_sort   # Nếu không có swap, thoát
   j print_array        

swap: 
   xor t0, t1, t0
   xor t1, t1, t0
   xor t0, t1, t0
   sw t0, 0(a4)
   sw t1, -4(a4)
   li t3, 1            # Đánh dấu đã swap
   j no_swap
   
print_array:
   la s0, A
   la s1, Aend
   addi s1, s1, -4
   
   mv a0, a5      
   li a7, 1
   ecall
   addi a5, a5, 1 
   
   la a0, msg   # "nth loop: "
   li a7, 4
   ecall
   
print_loop:   
   lw a0, 0(s0)   
   li a7, 1
   ecall

   la a0, space
   li a7, 4
   ecall
   
   addi s0, s0, 4
   ble s0, s1, print_loop

print_last:
   la a0, nl
   li a7, 4
   ecall
 
   j outer  # Continue sorting