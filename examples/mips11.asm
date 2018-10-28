#########################################################
#                                                       #
#       Wczytaæ ci¹g znaków ([a-z]). Wypisaæ licznoœæ   #
#       ka¿dego z symboli w ci¹gu                       #
#       np. aaabaazzzttz ? a5b1t2z4	                 #
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
	la $a1, 100
	syscall
	
	la $t0, buf
	lb $t1, ($t0)
	beqz $t1, exit
	
	li $t2, 'a'
	li $t3, 'z'
	la $t8, result
	
loop:
	blt $t1, $t2, next
	bgt $t1, $t3, next
	li $t4, 0 #quantity
	move $t5, $t0
	lb $t6, ($t5)
	
inner_loop:
	bne $t6, $t1, inner_next
	addiu $t4, $t4, 1
	li $t6, 0x20
	sb $t6, ($t5)
	
inner_next:
	addiu $t5, $t5, 1
	lb $t6, ($t5)
	bnez $t6, inner_loop
	
copy: 
	sb $t1, ($t8)
	addiu $t8, $t8, 1
	
	addiu $t4, $t4, 0x30
	sb $t4, ($t8)
	addiu $t8, $t8, 1
	
next:	
	addiu $t0, $t0, 1
	lb $t1, ($t0)
	bnez $t1, loop

exit:
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 10
	syscall
	