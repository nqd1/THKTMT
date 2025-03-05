# Laboratory Exercise 2, Assignment 6
.data # Khởi tạo biến (declare memory)
X: .word 5 # Biến X, kiểu word (4 bytes), giá trị khởi tạo = 5
Y: .word -1 # Biến Y, kiểu word (4 bytes), giá trị khởi tạo = -1
Z: .word 0 # Biến Z, kiểu word (4 bytes), giá trị khởi tạo = 0
.text # Khởi tạo lệnh (declare instruction)
# Nạp giá trị X và Y vào các thanh ghi
la t5, X # Lấy địa chỉ của X trong vùng nhớ chứa dữ liệu
la t6, Y # Lấy địa chỉ của Y
lw t1, 0(t5) # t1 = X
lw t2, 0(t6) # t2 = Y
# Tính biểu thức Z = 2X + Y với các thanh ghi
add s0, t1, t1
add s0, s0, t2
# Lưu kết quả từ thanh ghi vào bộ nhớ
la t4, Z # Lấy địa chỉ của Z
sw s0, 0(t4) # Lưu giá trị của Z từ thanh ghi vào bộ nhớ