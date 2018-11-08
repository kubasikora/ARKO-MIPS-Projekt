###########################################################
#                                                         #
#       Projekt 1 z ARKO - Architektura Komputerow        #
#       Temat: 12. Rysowanie trojpunktowej krzywej        #
#       Beziera na obrazku BMP.                           #
#       Autor: Jakub Sikora                               #
#       Prowadzacy: mgr. inz. Slawomir Niespodziany       #
#                                                         #
###########################################################

	.data
.align 4
x_vect: .space 4096
y_vect: .space 4096
	
output_file: .asciiz "out.bmp"
greeting: .asciiz "3rd degree Bezier curve generator \n"

# interaction with acquiring points
first_point_x_ask: .asciiz "Please enter x coordinate of the first point: \n"
first_point_y_ask: .asciiz "Please enter y coordinate of the first point: \n"
second_point_x_ask: .asciiz "Please enter x coordinate of the second point: \n"
second_point_y_ask: .asciiz "Please enter y coordinate of the second point: \n"
third_point_x_ask: .asciiz "Please enter x coordinate of the third point: \n"
third_point_y_ask: .asciiz "Please enter y coordinate of the third point: \n"
ack_conf: .asciiz "Entered points: \n"
first_point_ack: .asciiz "P1 = ("
second_point_ack: .asciiz "P2 = ("
third_point_ack: .asciiz "P3 = ("
ack_terminate: .asciiz ")\n"

invalid_arg_error: .asciiz "ERROR: Invalid pair of coordinates. \n"
	
	.text
	.globl main
main: 
	li $v0, 4
	la $a0, greeting
	syscall
	
acquire_points:
	li $v0, 4
	la $a0, first_point_x_ask
	syscall
	
	li $v0, 5
	syscall	
	move $s0, $v0
		
	li $v0, 4
	la $a0, first_point_y_ask
	syscall

	li $v0, 5
	syscall	
	move $s1, $v0
			
	li $v0, 4
	la $a0, second_point_x_ask
	syscall

	li $v0, 5
	syscall	
	move $s2, $v0
	
	li $v0, 4
	la $a0, second_point_y_ask
	syscall

	li $v0, 5
	syscall	
	move $s3, $v0
		
	li $v0, 4
	la $a0, third_point_x_ask
	syscall

	li $v0, 5
	syscall	
	move $s4, $v0
		
	li $v0, 4
	la $a0, third_point_y_ask
	syscall

	li $v0, 5
	syscall	
	move $s5, $v0

	
print_confirmation:
	li $v0, 4
	la $a0, ack_conf
	syscall
	
print_first_point:	
	li $v0, 4
	la $a0, first_point_ack
	syscall 
		
	li $v0, 1
	move $a0, $s0
	syscall
	
	li $v0, 11
	li $a0, ','
	syscall	 
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	li $v0, 4
	la $a0, ack_terminate
	syscall 

print_second_point:	
	li $v0, 4
	la $a0, second_point_ack
	syscall 
	
	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 11
	li $a0, ','
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, ack_terminate
	syscall
	
print_third_point:	
	li $v0, 4
	la $a0, third_point_ack
	syscall 
	
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 11
	li $a0, ','
	syscall
	 
	li $v0, 1
	move $a0, $s5
	syscall
	
	li $v0, 4
	la $a0, ack_terminate
	syscall
	
evaluate_bezier_vectors: #executes (1-t)^3 * x0 + 3*((1-t)^2)*t*x1 + 3*(1-t)*x2*(t^2) + (t^3)*x3	
	li $t0, 1024 #max
	li $t1, 1024 #t
	
	la $t5, x_vect
	la $t7, y_vect
	
bezier_loop:
x_vect_evaluate:
	subiu $t1, $t1, 1
	move $t2, $s0 #x1 
 	move $t3, $s2 #x2
	move $t4, $s4 #x3	
	li $s1, 3
	sll $s1, $s1, 10	
	
	subu $t6, $t0, $t1 # t-1 
	sll $t2, $t2, 10 # x1 staloprzecinkowe
	
	mulu $t6, $t6, $t6 #kwadrat staloprzecinkowy
	srl $t6, $t6, 10 #10bitow mniej bo stalo X stalo
	
	mulu $t6, $t6, $t1#mnozenie staloprzecinkowych
	srl $t6, $t6, 10#10bitow mniej bo stalo X stalo
	
	mulu $t6, $t6, $t2#mnozenie staloprzecinkowe
	srl $t6, $t6, 10#20 bit mniej bo doprowadzamy do 
	
	mulu $t6, $t6, $s1
	srl $t6, $t6, 10
	
	move $t8, $t6 #dodaj do akumulatora
	
	subu $t6, $t0, $t1 # t-1 
	sll $t3, $t3, 10 # x2 staloprzecinkowe
	
	mulu $t6, $t6, $t1
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $t1
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $t3
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $s1
	srl $t6, $t6, 10
	
	addu $t8, $t8, $t6
	
	sll $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	addu $t8, $t4, $t8
	
	srl $t8, $t8, 10
	
	
	li $v0, 11
	li $a0, 'x'
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 11
	li $a0, ':'
	syscall

	li $v0, 1
	move $a0, $t8
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	sw $t8, ($t5)
	addiu $t5, $t5, 4
	
y_vect_evaluate:
	move $t2, $s0 #x1 
 	move $t3, $s2 #x2
	move $t4, $s4 #x3	
	li $s1, 3
	sll $s1, $s1, 10	
	
	subu $t6, $t0, $t1 # t-1 
	sll $t2, $t2, 10 # x1 staloprzecinkowe
	
	mulu $t6, $t6, $t6 #kwadrat staloprzecinkowy
	srl $t6, $t6, 10 #10bitow mniej bo stalo X stalo
	
	mulu $t6, $t6, $t1#mnozenie staloprzecinkowych
	srl $t6, $t6, 10#10bitow mniej bo stalo X stalo
	
	mulu $t6, $t6, $t2#mnozenie staloprzecinkowe
	srl $t6, $t6, 10#20 bit mniej bo doprowadzamy do 
	
	mulu $t6, $t6, $s1
	srl $t6, $t6, 10
	
	move $t8, $t6 #dodaj do akumulatora
	
	subu $t6, $t0, $t1 # t-1 
	sll $t3, $t3, 10 # x2 staloprzecinkowe
	
	mulu $t6, $t6, $t1
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $t1
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $t3
	srl $t6, $t6, 10
	
	mulu $t6, $t6, $s1
	srl $t6, $t6, 10
	
	addu $t8, $t8, $t6
	
	sll $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	mulu $t4, $t4, $t1
	srl $t4, $t4, 10
	
	addu $t8, $t4, $t8
	
	srl $t8, $t8, 10
	
	li $v0, 11
	li $a0, 'y'
	syscall
	
	li $v0, 1
	move $a0, $t1
	syscall

	li $v0, 11
	li $a0, ':'
	syscall

	li $v0, 1
	move $a0, $t8
	syscall
	
	li $v0, 11
	li $a0, '\n'
	syscall
	
	
	sw $t8, ($t5)
	addiu $t5, $t5, 4
	
	bnez $t1, bezier_loop
			
exit:
	la $t5, x_vect
	lw $a0, ($t5)
	li $v0, 1
	syscall
	addiu $t5, $t5, 512
	lw $a0, ($t5)
	syscall
	
	li $v0, 10
	syscall
	
	
invalid_arg_exit:
	li $v0, 4
	la $a0, invalid_arg_error
	syscall
	
	li $v0, 17
	li $a0, -1
	syscall
	
