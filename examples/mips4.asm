#########################################################
#                                                       #
#       Skanowanie (konwersja) i wyœwietlenie	         # 
#       najwiêkszej liczby dziesiêtnej z ³añcucha.      #
#       Autor: Jakub Sikora                             #
#                                                       #
#########################################################

	.data
prompt: .asciiz "Enter string: \n"
ack_prompt: .asciiz "The biggest number in string is: "
error_prompt: .asciiz "There are no numbers in given string. \n" 
buf: .space 100

	.text
	.globl main
main: 	
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 8
	la $a0, buf
	la $a1, 100
	syscall
	
	la $t0, buf
	lb $t1, ($t0)
	beqz $t1, exit
	
	li $t2, '0'
	li $t3, '9'
	li $t4, ' ' #largest
	
loop: 	
	blt $t1, $t2, next
	bgt $t1, $t3, next
	#is a number
	
	blt $t1, $t4, next
	move $t4, $t1

next:
	addiu $t0, $t0, 1
	lb $t1, ($t0)
	bnez $t1, loop

exit:
	li $t5, ' '
	beq $t4, $t5, error_exit

	li $v0, 4
	la $a0, ack_prompt
	syscall
	
	li $v0, 11
	move $a0, $t4
	syscall
	
	li $v0, 10
	syscall

error_exit:
	li $v0, 4
	la $a0, error_prompt
	syscall
	
	li $v0, 10
	syscall
