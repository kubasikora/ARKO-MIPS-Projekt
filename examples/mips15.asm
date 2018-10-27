#########################################################
#                                                       #
#       Wczytaæ ci¹g znaków. Wygenerowaæ ci¹g znaków    #
#       na zasadzie a5b1t2z4 ? aaabaazzzttz     	  #
#       Autor: Jakub Sikora                             #
#                                                       #
#########################################################

	.data
prompt: .asciiz "Enter command: \n"
error: .asciiz "Wrong command! \n"
cmd: .space 20
result: .space 100

	.text
	.globl main
main: 
	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, cmd
	li $a1, 100
	syscall
	
	la $t0, cmd
	lb $t1, ($t0)
	beqz $t1, exit
	
	li $t5, '0'
	li $t6, '9'
	
	la $t3, result
	lb $t1, ($t0) #letter
loop:
	addiu $t0, $t0, 1
	lb $t2, ($t0) #number
	beqz $t2, exit
	
	blt $t2, $t5, error_exit
	bgt $t2, $t6, error_exit
	
inner_loop:
	sb $t1, ($t3)
	addiu $t3, $t3, 1
	subiu $t2, $t2, 1
	bgt $t2, $t5, inner_loop
	
next: 
	addiu $t0, $t0 1
	lb $t1, ($t0)
	bnez $t1, loop
	
exit:
	li $t1, 0
	sb $t1, ($t3)
	addiu $t3, $t3, 1

	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 10
	syscall
	
error_exit:
	li $v0, 4
	la $a0, error
	syscall
	
	li $v0, 10
	syscall