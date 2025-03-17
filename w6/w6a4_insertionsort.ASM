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
   addi a5, a5, 1       #loop count 
   j insertion_sort

after_sort:
   li a7, 10
   ecall

insertion_sort:
   add a3, a1, zero    # &(A[0])
   addi a3, a3, 4      # &(A[1])

outer:
   bgt a3, a2, after_sort   # reached Aend
   lw t0, 0(a3)             # t0 = A[i]
   addi a4, a3, -4          # a4 = &(A[i-1]) = &(A[j])
 
inner_loop:
   blt a4, a1, insert_key   # checked A[i-1] through A[0]
   lw t1, 0(a4)             
   ble t1, t0, insert_key   
   sw t1, 4(a4)   
   addi a4, a4, -4          # j--
   j inner_loop

insert_key:
   sw t0, 4(a4) 
   j print_array

print_array:
   la s0, A
   la s1, Aend
   addi s1, s1, -4
   
   addi a0, a5, 0
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
   
   addi a3, a3, 4  # i++
   j outer