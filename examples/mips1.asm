#########################################################
#                                                       #
#   	Zastepowanie cyfr ich dopelnieniem              #
# 	Autor: Jakub Sikora                             #
#                                                       #
#########################################################

	.data
prompt: .asciiz "Enter string: \n" 
buf: .space 100
	
	.text
	.globl main
main:
	#print prompt
	li $v0, 4
	la $a0, prompt
	syscall 
	
	#get string
	li $v0, 8
	la $a0, buf
	li $a1, 100	
	syscall
	
	#interesting range of charachters
	li $t0, '0'
	li $t1, '9'
		
	la $t2, buf #get buf adress
	lb $t3, ($t2) #load byte from buffer
	beqz $t3, end #if 0, go to end
	
loop: #check condition
	blt $t3, $t0, next
	bgt $t3, $t1, next
	
	#loop body
	li $t5, 'i'
	sub $t3, $t5, $t3
	sb $t3, ($t2)	
	
next: #finishing the loop and branching
	addiu $t2, $t2, 1
	lb $t3, ($t2)
	bnez $t3, loop
	
end:	
	#print result
	li $v0, 4
	la $a0, buf
	syscall
	
	#exit
	li $v0, 10
	syscall
	
