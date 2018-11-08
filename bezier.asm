	.data

	.text
	.globl main
main:
	#executes (1-t)^3 * x0 + 3*((1-t)^2)*t*x1 + 3*(1-t)*x2*(t^2) + (t^3)*x3	

	li $t0, 1024 #max
	li $t1, 1024 #t
	
loop:
	subiu $t1, $t1, 1
	li $t2, 45 #x1 
 	li $t3, 402 #x2
	li $t4, 499 #x3	
	li $s1, 3
	sll $s1, $s1, 10

	subu $t6, $t0, $t1 # t-1 
	sll $t2, $t2, 10 # x1 staloprzecinkowe
	
	mulu $t6, $t6, $t6 #kwadrat staloprzecinkowy
	srl $t6, $t6, 10 #10bitow mniej bo stalo X stalo
	
	mulu $t6, $t6, $t1#mnozenie staloprzecinkowych
	srl $t6, $t6, 10#10bitow mniej bo stalo X stalo
	
	mulu $t6, $t6, $t2#mnozenie staloprzecinkowe
	srl $t6, $t6, 10#20 bit mniej bo doprowadzamy do 
	
	mulu $t6, $t6, $s1
	srl $t6, $t6, 10
	
	move $t8, $t6
	
	subu $t6, $t0, $t1 # t-1 
	sll $t3, $t3, 10 # x2 staloprzecinkowe
	
	mulu $t6, $t6, $t1
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $t1
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $t3
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $s1
	srl $t6, $t6, 10
	
	addu $t8, $t8, $t6
	
	sll $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	addu $t8, $t4, $t8
	
	srl $t8, $t8, 10
	
	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 11
	li $a0, ':'
	syscall

	li $v0, 1
	move $a0, $t8
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	
	bnez $t1, loop
			
	li $v0, 10
	syscall
	
