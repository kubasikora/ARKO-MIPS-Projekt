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
first_point_x: .word 0
first_point_y: .word 0
second_point_x: .word 0
second_point_y: .word 0
third_point_x: .word 0
third_point_y: .word 0
	
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
	la $t0, first_point_x
	sb $v0, ($t0)
		
	li $v0, 4
	la $a0, first_point_y_ask
	syscall

	li $v0, 5
	syscall	
	la $t0, first_point_y
	sb $v0, ($t0)
			
	li $v0, 4
	la $a0, second_point_x_ask
	syscall

	li $v0, 5
	syscall	
	la $t0, second_point_x
	sb $v0, ($t0)
		
	li $v0, 4
	la $a0, second_point_y_ask
	syscall

	li $v0, 5
	syscall	
	la $t0, second_point_y
	sb $v0, ($t0)
			
	li $v0, 4
	la $a0, third_point_x_ask
	syscall

	li $v0, 5
	syscall	
	la $t0, third_point_x
	sb $v0, ($t0)
			
	li $v0, 4
	la $a0, third_point_y_ask
	syscall

	li $v0, 5
	syscall	
	la $t0, third_point_y
	sb $v0, ($t0)
	
print_confirmation:
	li $v0, 4
	la $a0, ack_conf
	syscall
	
print_first_point:	
	li $v0, 4
	la $a0, first_point_ack
	syscall 
	
	la $t0, first_point_x
	lb $t1, ($t0)
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 11
	li $a0, ','
	syscall
	 
	la $t0, first_point_y
	lb $t1, ($t0)
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, ack_terminate
	syscall 

print_second_point:	
	li $v0, 4
	la $a0, second_point_ack
	syscall 
	
	la $t0, second_point_x
	lb $t1, ($t0)
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 11
	li $a0, ','
	syscall
	 
	la $t0, second_point_y
	lb $t1, ($t0)
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, ack_terminate
	syscall
	
print_third_point:	
	li $v0, 4
	la $a0, third_point_ack
	syscall 
	
	la $t0, third_point_x
	lb $t1, ($t0)
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 11
	li $a0, ','
	syscall
	 
	la $t0, third_point_y
	lb $t1, ($t0)
	
	li $v0, 1
	move $a0, $t1
	syscall
	
	li $v0, 4
	la $a0, ack_terminate
	syscall
	
	
exit:
	li $v0, 10
	syscall
	
	
invalid_arg_exit:
	li $v0, 4
	la $a0, invalid_arg_error
	syscall
	
	li $v0, 17
	li $a0, -1
	syscall
	
