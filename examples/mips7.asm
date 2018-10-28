#########################################################
#                                                       #
#       Usuniêcie z ³añcucha sekwencji znaków o         #
#       pozycji i d³ugoœci zadanej w postaci liczb,     #
#       z w³aœciw¹ reakcj¹ na nieprawid³owe             #
#       wartoœci argumentów	                         #
#       Autor: Jakub Sikora                             #
#                                                       #
#########################################################


	.data
str_prompt: .asciiz "Enter string: \n"
pos_prompt: .asciiz "Enter position: \n"
len_prompt: .asciiz "Enter length: \n"
pos_not_found: .asciiz "Entered string is too short! \n"
buf: .space 100
result: .space 100

 	.text
 	.globl main
main:
	li $v0, 4
	la $a0, str_prompt
	syscall
	 
	li $v0, 8
	la $a0, buf
 	li $a1, 100
	syscall
	
	li $v0, 4 
	la $a0, pos_prompt
	syscall
	
	li $v0, 5
	syscall
	move $t2, $v0 #pos
	
	li $v0, 4
	la $a0, len_prompt
	syscall
	
	li $v0, 5
	syscall
	move $t3, $v0 #len
	
	la $t0, buf
	la $t4, result
	
find_pos:
	lb $t1, ($t0)
	beqz $t1, error	
	beqz $t2, loop
	sb $t1, ($t4)
	addiu $t4, $t4, 1
	addiu $t0, $t0, 1
	subiu $t2, $t2, 1
	b find_pos
	
loop:	
	beqz $t3, loop_end
	lb $t1, ($t0)
	beqz $t1, alert_exit
	subiu $t3, $t3, 1
	addiu $t0, $t0, 1
	b loop
		
loop_end:
	lb $t1, ($t0)
	sb $t1, ($t4)
	addiu $t4, $t4, 1
	addiu $t0, $t0, 1
	bnez $t1, loop_end
		
exit:
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 10
	syscall
	
alert_exit: 
	addiu $t4, $t4, 1
	li $t6, 0x00
	sb $t6, ($t4)
	
	li $v0, 4
	la $a0, result
	syscall
	
	li $v0, 10
	syscall
error:
	li $v0, 4
	la $a0, pos_not_found
	syscall

	li $v0, 10
	syscall