#########################################################
#                                                       #
#       Zliczanie liczb dziesiêtnych                    #
#       Autor: Jakub Sikora                             #
#                                                       #
#########################################################
	
	.data
prompt: .asciiz "Enter text: \n"
buf: .space 100	
result_prompt: .asciiz "Quantity of numbers: "

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
		
	li $t0, '0'
	li $t1, '9'
	li $t4, 0 #isANumber
	li $t5, 0 #howManyNumbers
	
	la $t2, buf
	lb $t3, ($t2)
	beqz $t3, exit
	
loop: 
	#is a number?
	blt $t3, $t0, nan
	bgt $t3, $t1, nan
	 
	bnez $t4, next
	addiu $t4, $t4, 1
	b next

nan:
	beqz $t4, next
	subiu $t4, $t4, 1
	addiu $t5, $t5, 1
	
next:	
	addiu $t2, $t2,1 
	lb $t3, ($t2)
	bnez $t3, loop
				
exit:
	li $v0, 4
	la $a0, result_prompt
	syscall
	
	li $v0, 1
	move $a0, $t5
	syscall
		
	li $v0, 10
	syscall	
