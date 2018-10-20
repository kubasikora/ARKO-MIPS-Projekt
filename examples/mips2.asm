#########################################################
#                                                       #
#   	Wypisywanie najd?u?szego ci?gu cyfr             #
# 	Autor: Jakub Sikora                             #
#                                                       #
#########################################################

	.data
prompt: .asciiz "Enter string: \n" 
error: .asciiz "No sequence found" 
buf: .space 100
result: .space 100
	
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
	
	li $t4, 0 #lenght of actual sequence lm
	li $t5, 0 #address of actual sequence pm
	li $t6, 0 #longest sequence
	li $t7, 1000 #address of longest sequence, 1000 means no sequence was found
	
loop: #check condition
	blt $t3, $t0, nan
	bgt $t3, $t1, nan
	#is a number
	
	bnez $t4, addnum
	la $t5, ($t2)  #store address of first number in sequence
addnum:
	addiu $t4, $t4, 1 #increace actual sequence length
	b next
	
nan: #not a number
	ble $t4, $t6, reset
	move $t6, $t4
	move $t7, $t5

reset:
	li $t4, 0
			
next: #finishing the loop and branching
	addiu $t2, $t2, 1
	lb $t3, ($t2)
	bnez $t3, loop
	
end:	
	#check if any sequence was found
	beq $t7, 1000, endwitherror

	#write 0 after longest sequence 
	addu $t4, $t7, $t6 
	li $a0, 0x00
	sb $a0, ($t4)	
	
	#print result
	li $v0, 4
	la $a0, ($t7)
	syscall
	
	#exit
	li $v0, 10
	syscall
	
endwitherror:
	#print error
	li $v0, 4
	la $a0, error
	syscall 
	
	#exit
	li $v0, 10
	syscall
