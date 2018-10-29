# bubblesort - zadanie 1, sprawdzian MIPS

	.data
prompt: .asciiz "Enter string: \n"
buf: .space 100
	.text
	.globl main
main:
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, buf
	li $a1, 100
	syscall
	
	la $t0, buf
	lb $t1, ($t0)
	beqz $t1, exit
	li $t8, 0 #liczba elem
	
count_loop:
	lb $t1, ($t0)	
	addiu $t8, $t8, 1
	addiu $t0, $t0, 1
	bnez $t1, count_loop
	subiu $t8, $t8, 3 # nie ruszac, liczba elementow
	
	
main_loop:
	la $t0, buf
	lb $t1, ($t0)
	move $t3, $t1
	
	move $t5, $t8 # t5 licznik petli for
	
loop:
	addiu $t2, $t0, 1
	lb $t3, ($t2) #pobierz kolejny obok
	
	beq $t3, '\n', main_next
	
	li $v0, 11
	move $a0, $t1
	syscall
	 
	li $v0, 11
	move $a0, $t3
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	
	bgt $t3, $t1, next # nie rob swapa
	
swap:	
	sb $t3, ($t0)
	sb $t1, ($t2)

next:
	addiu $t0, $t0, 1
	subiu $t5, $t5, 1
	lb $t1, ($t0)
	bnez $t5, loop
		
main_next:
	subiu $t8, $t8, 1
	bge $t8, 1, main_loop
	
exit:
	li $v0, 4
	la $a0, buf
	syscall

	li $v0, 10
	syscall	
	
