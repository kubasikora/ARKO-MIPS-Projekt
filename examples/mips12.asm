#########################################################
#                                                       #
#       Wczytaæ ci¹g znaków. Na standardowe wyjœcie     #
#       wypisaæ ci¹g w postaci: [znak]                  #
#       [liczba wyst¹pieñ znaku do aktualnego miejsca]  #
#       np.: alamakota ? a1l1a2m1a3k1o1t1a4.           #
#       Nale¿y zliczaæ tylko ma³e litery,               #
#       pomijaæ inne znaki.	                         #
#       Autor: Jakub Sikora                             #
#                                                       #
#########################################################


	.data
prompt: .asciiz "Enter string: \n"
buf: .space 100
result: .space 200

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
	la $t7, result
	
main_loop: 
	blt $t1, $t2, next
	bgt $t1, $t3, next
	li $t6, 0
	la $t4, buf
	
inner_loop:
	lb $t5, ($t4)			
	bne $t1, $t5, next_inner
	addiu $t6, $t6, 1
	
next_inner:
	beq $t4, $t0, copy
	addiu $t4, $t4, 1
	b inner_loop
	
copy:	
	sb $t5, ($t7)
	addiu $t6, $t6, 0x30
	addiu $t7, $t7, 1
	sb $t6, ($t7)
	addiu $t7, $t7, 1
	
next:
	addiu $t0, $t0, 1
	lb $t1, ($t0)
	bnez $t1, main_loop
	
exit:
	addiu $t4, $t4, 1
	li $t2, 0
	sb $t2, ($t4)
	
	li $v0, 4
	la $a0, result
	syscall
			
	li $v0, 10
	syscall
