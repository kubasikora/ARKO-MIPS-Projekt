# zamiana pierwszego i ostatniego bajtu w slowie 
# zakaz uzywania operacji load/store dla bajtow lb sb
# zadanie 2 - sprawdzian mips

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
	li $a1, 100
	syscall
		
	li $t0, 0	
		
loop:
	lw $t1, buf($t0)
		
	andi $t2, $t1, 0x000000ff
	andi $t3, $t1, 0xff000000
	andi $t4, $t1, 0x0000ff00
	andi $t5, $t1, 0x00ff0000
	sll $t2, $t2, 24
	srl $t3, $t3, 24
	
	blt $t4, 0x20, exit
	blt $t2, 0x20, exit
	blt $t3, 0x20, exit
	blt $t5, 0x20, exit
	
	or $t4, $t4, $t5
	or $t4, $t4, $t2
	or $t4, $t4, $t3
		
	sw $t4, buf($t0)
	
	addiu $t0, $t0, 4
	b loop
	
exit:
	li $v0, 4
	la $a0, buf
	syscall
	
	li $v0, 10
	syscall	
