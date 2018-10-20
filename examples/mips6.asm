#########################################################
#                                                       #
#   	Usuni?cie z ?a?cucha znaków okre?lonego         # 
#       podzbioru(cyfr, ma?ych liter itp.).             #
#       Wybrany podzbiór: male litery                   #
# 	Autor: Jakub Sikora                             #
#                                                       #
#########################################################

	.data
prompt: .asciiz "Enter string \n"
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
	
	li $t0, 'a'
	li $t1, 'z'
	
	la $t4, result
	
	la $t2, buf
	lb $t3, ($t2)
	beqz $t3, end
		
loop: 
	blt $t3, $t0, approved
	bgt $t3, $t1, approved
	b next

approved:
	sb $t3, ($t4)
	addiu $t4, $t4, 1
	
next:
	addiu $t2, $t2, 1
	lb $t3, ($t2)
	bnez $t3, loop	
	
end:	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 10
	syscall
	
	