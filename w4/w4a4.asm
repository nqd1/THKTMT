.text
    	li s1, 0x7FFFFFFF  # = INT_MAX
    	li s2, 0x00000001   
    	li t0, 0 
    
	add s3, s1, s2  
    	xor t1, s1, s2  
	blt t1, zero, EXIT  
    
	xor t1, s1, s3  
	blt t1, zero, OVERFLOW  
	j EXIT
	
OVERFLOW:
    li t0, 1  
    
EXIT:


 
