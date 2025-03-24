# Laboratory Exercise 7, Home Assignment 2
.text
main:
	li a0, 212 # load test input
	li a1, 4
	li a2, 941
	jal max # call max procedure
	li a7, 10 # terminate
	ecall
end_main:
max:
	add s0, a0, zero # copy a0 in s0; largest so far
	sub t0, a1, s0 # compute a1 - s0
	blt t0, zero, okay # if a1 - s0 < 0 then no change
	add s0, a1, zero # else a1 is largest thus far
okay:
	sub t0, a2, s0 # compute a2 - v0
	blt t0, zero, done # if a2 - v0 <0 then no change
	add s0, a2, zero # else a2 is largest overall
done:
	jr ra # return to calling program
