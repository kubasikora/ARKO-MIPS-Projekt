#########################################################
#                                                       #
#       Wczytac ciag znakow i zamienic wszystkie        #
#       wielkie litery na male litery                   #
#       oraz male na wielkie. 	                         #
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
	 li $t3, 'z'
	 li $t4, 'A'
	 li $t5, 'Z'
	  
loop:
	 blt $t1, $t4, next
	 bgt $t1, $t3, next
	 
	 bge $t1, $t2, small_letter
	 ble $t1, $t5, big_letter
	 
	 addiu $t0, $t0, 1
	 lb $t1, ($t0)
	 beqz $t1, exit
	 b loop
	 
big_letter:
	 addiu $t1, $t1, 0x20
	 sb $t1, ($t0)
next:
	 addiu $t0, $t0, 1
	 lb $t1, ($t0)  
	 beqz $t1, exit
	 b loop
	
small_letter: 
	subiu $t1, $t1, 0x20
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