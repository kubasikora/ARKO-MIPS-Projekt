#########################################################
#                                                       #
#       Skanowanie (konwersja) i wyœwietlenie	         # 
#       najwiêkszej liczby dziesiêtnej z ³añcucha.      #
#       Autor: Jakub Sikora                             #
#                                                       #
#########################################################

	.data
prompt: .asciiz "Enter string: \n"
ack_prompt: .asciiz "Average: "
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
	li $t4, 0 #sum
	li $t5, 0 #quantity
	
	
loop: 	
	blt $t1, $t2, next
	bgt $t1, $t3, next
	#is a number
	
	subiu $t1, $t1, 0x30	
	addu $t4, $t4, $t1
	addiu $t5, $t5, 1
	
next:
	addiu $t0, $t0, 1
	lb $t1, ($t0)
	bnez $t1, loop

	div $t4, $t4, $t5
	addiu $t4, $t4, 0x30
	
exit:	
	li $v0, 4
	la $a0, ack_prompt
	syscall
	
	li $v0, 11
	move $a0, $t4
	syscall
		
	li $v0, 10
	syscall