#############################################################################
#  Row-major order traversal of 16 x 16 array of words.
#  Pete Sanderson
#  31 March 2007
#
#  To easily observe the row-oriented order, run the Memory Reference
#  Visualization tool with its default settings over this program.
#  You may, at the same time or separately, run the Data Cache Simulator 
#  over this program to observe caching performance.  Compare the results
#  with those of the column-major order traversal algorithm.
#
#  The C/C++/Java-like equivalent of this MIPS program is:
#     int size = 16;
#     int[size][size] data;
#     int value = 0;
#     for (int row = 0; col < size; row++) {
#        for (int col = 0; col < size; col++) }
#           data[row][col] = value;
#           value++;
#        }
#     }
#
#  Note: Program is hard-wired for 16 x 16 matrix.  If you want to change this,
#        three statements need to be changed.
#        1. The array storage size declaration at "data:" needs to be changed from
#           256 (which is 16 * 16) to #columns * #rows.
#        2. The "li" to initialize t0 needs to be changed to new #rows.
#        3. The "li" to initialize t1 needs to be changed to new #columns.
#
         .data
data:    .word     0 : 256       # storage for 16x16 matrix of words
         .text
         li       t0, 16        # t0 = number of rows
         li       t1, 16        # t1 = number of columns
         addi     s0, zero, 0   # s0 = row counter
         addi     s1, zero, 0   # s1 = column counter
         addi     t2, zero, 0   # t2 = the value to be stored
         la       t3, data      # t3 = the first-byte address of 2d-array data
#  Each loop iteration will store incremented t1 value into next element of matrix.
#  Offset is calculated at each iteration. offset = 4 * (row*#cols+col)
#  Note: no attempt is made to optimize runtime performance!
loop:    mul      s2, s0, t1    # s2 = row * #cols  (two-instruction sequence)
         add      s2, s2, s1    # s2 += column counter
         slli     s2, s2, 2     # s2 *= 4 (shift left 2 bits) for byte offset
         add      s2, s2, t3
         sw       t2, 0(s2)     # store the value in matrix element
         addi     t2, t2, 1     # increment value to be stored
#  Loop control: If we increment past last column, reset column counter and increment row counter
#                If we increment past last row, we're finished.
         addi     s1, s1, 1    # increment column counter
         bne      s1, t1, loop # not at end of row so loop back
         addi     s1, zero,0   # reset column counter
         addi     s0, s0, 1    # increment row counter
         bne      s0, t0, loop # not at end of matrix so loop back
#  We're finished traversing the matrix.
         li       a7, 10        # system service 10 is exit
Thang:         
         ecall                  # we are outta here.
         
         
         
         
