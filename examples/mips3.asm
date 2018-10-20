#########################################################
#                                                       #
#   	Odwrócenie kolejno?ci cyfr                      #
# 	Autor: Jakub Sikora                             #
#                                                       #
#########################################################
	
	.data
prompt: .asciiz "Enter string: \n" " 
buf: .space 100
result: .space 101

	.text
	.globl main
main:
	#print prompt
	li $v0, 4
	la $a0, prompt
	syscall
	
	#load string
	li $v0, 8
	la $a0, buf
	li $a1, 100
	syscall
	
	#load buffer adddress
	la $t0, buf 
	
find_end: #find string end
	lb $t1, ($t0)
	beqz $t1, copy
	addiu $t0, $t0, 1
	b find_end
	
copy:	#load initial adresses
	la $t2, result
	la $t4, buf
	
loop:   #copy buffer in reverse 
	lb $t3, ($t0)
	sb $t3, ($t2)
	addiu $t2, $t2, 1
	subiu $t0, $t0, 1	
	bge $t0, $t4, loop
	
end: 	#add 1 to address and print
	la $t0, result
	addiu $t0, $t0, 1
	la $a0, ($t0)
	li $v0, 4
	syscall
		
	#exit 
	li $v0, 10
	syscall
	