#########################################################
#                                                       #
#       Usuwanie z ka¿dej ciaglej sekwencji             #
#       wielkich liter wszystkich oprócz pierwszej      #
#       Autor: Jakub Sikora                             #
#                                                       #
#########################################################

	.data
prompt: .asciiz "Enter string: \n"
buf: .space 100
result: .space 100

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
	
	li $t0, 'A'
	li $t1, 'Z'
	li $t4, 1 #last_Char_space
	
	la $t2, buf
	lb $t3, ($t2)
	beqz $t3, exit
	
	la $t5, result

loop:
	bgt $t3, $t1, nalc	
	blt $t3, $t0, nalc	
	
	beqz $t4, last_was_space
	sb $t3, ($t5)
	addiu $t5, $t5, 1
	li $t4, 0
	b next
	
last_was_space:
	li $t4, 0
	b next

nalc:
	sb $t3, ($t5)
	addiu $t5, $t5, 1
	li $t4, 0
	bne $t3, 0x20, next
	li $t4, 1

next:
	addiu $t2, $t2, 1
	lb $t3, ($t2)
	bnez $t3, loop

exit:
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 10
	syscall