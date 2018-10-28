#########################################################
#                                                       #
#       Wczytaæ ci¹g znaków[a-j0-9] i zamieniæ          #
#       wszystkie cyfry na litery oraz litery           #
#       na cyfry np. ab01j ? 01ab9 	                 #
#       Autor: Jakub Sikora                             #
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
	 li $a1, 100
	 syscall
	 
	 la $t0, buf
	 lb $t1, ($t0)
	 beqz $t1, exit
	 
	 li $t2, 'a'
	 li $t3, 'j'
	 li $t4, '0'
	 li $t5, '9'
	  
loop:
	 blt $t1, $t4, next
	 bgt $t1, $t3, next
	 
	 bge $t1, $t2, small_letter
	 ble $t1, $t5, numbers
	 
	 addiu $t0, $t0, 1
	 lb $t1, ($t0)
	 beqz $t1, exit
	 b loop
	 
numbers:
	 addiu $t1, $t1, '1'
	 sb $t1, ($t0)
next:
	 addiu $t0, $t0, 1
	 lb $t1, ($t0)  
	 beqz $t1, exit
	 b loop
	
small_letter: 
	subiu $t1, $t1, '1'
	sb $t1, ($t0)
	addiu $t0, $t0, 1
	lb $t1, ($t0)  
	beqz $t1, exit
	b loop 
	
	 
	  
exit:
	li $v0, 4
	la $a0, buf
	syscall
	 
	li $v0, 10
	syscall
