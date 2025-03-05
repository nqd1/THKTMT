.text
    li a0, 6        
    li a1, 7        
    li a2, 0        
    li t0, 1        

LOOP:
    and t1, a1, t0  
    beq  t1, zero, SKIP   
    add a2, a2, a0  

SKIP:
    sll a0, a0, t0   
    srl a1, a1, t0  
    bne a1, zero, LOOP   

EXIT:
    
