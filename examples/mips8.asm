#########################################################
#                                                       #
#   	Zastepowanie co trzeciej malej litery           #
#       odpowiadajaca jej wielka litera                 #
# 	Autor: Jakub Sikora                             #
#                                                       #
#########################################################

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
	la $a1, 100
	syscall
	
	li $t0, 'a'
	li $t1, 'z'
	li $t2, 2
	li $t5, 0x20
	
	la $t3, buf
	lb $t4, ($t3)
	beqz $t4, end
	
loop:
	blt $t4, $t0, next
	bgt $t4, $t1, next
	bnez $t2, not_third
	
	subu $t4, $t4, $t5
	sb $t4, ($t3)
	li $t2, 2
	b next
not_third:
	subiu $t2, $t2, 1
next:
	addiu $t3, $t3, 1
	lb $t4, ($t3)
	bnez $t4, loop

end:	
	li $v0, 4
	la $a0, buf
	syscall

	li $v0, 10
	syscall