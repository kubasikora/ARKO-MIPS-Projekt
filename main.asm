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
#bezier curve data vectors
.align 4
x_vect: .space 4096
y_vect: .space 4096

# file
frameBuffer: .space 0xc0036 	
fout: .asciiz "/home/sikora/Documents/Dev/Arko/ARKO-MIPS-Projekt/arko_mips_project.bmp"      # filename for output
file_save_start: .asciiz "Creating a bitmap...\n"
file_save_end: .asciiz "Created arko_mips_project.bmp file!\n"

# interaction with acquiring points
greeting: .asciiz "3rd degree Bezier curve generator \n"
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

#errors
invalid_arg_error: .asciiz "ERROR: Invalid pair of coordinates. \n"


	.text
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
			
file_creation:
	li $v0, 4
	la $a0, file_save_start
	syscall
	
	la $a0, frameBuffer

	########################## HEADER

	#BM
	li $t0, 'B'
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 'M'
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#Filesize
	li $t0, 0x3a
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x09
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	## reserved - empty 
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	## offset to raster data, gdzie zaczyna sie tablica pikseli - nie zmieniac
	li $t0, 0x36
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1


	###############  BITMAPINFOHEADER

	#size - DONE - rozmiar nagłówka BITMAPINFOHEADER
	li $t0, 0x28
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1
	 
	#width - rozmiar w px
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x02
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#height - rozmiar w px
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x02
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00	
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#planes - 1 plaszczyzna
	li $t0, 0x01
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#bitcount - 24 bity na piksel
	li $t0, 0x18
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1
	 
	#compression - brak kompresji
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#imagesizeaftercompression  - rozmiar samego obrazka
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x04
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#xpixelsperm
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#ypixelsperm
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	#colors used
	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	######## TABLE

	li $t5, 0xc0000
	li $t6, 0x18
	li $t7, 0x5e
	li $t8, 0xce
	
loop: #write 3 bytes for one pixel
	addiu $a0, $a0, 1
	sb $t8, ($a0)
	subiu $t5, $t5, 1
	
	addiu $a0, $a0, 1
	sb $t7, ($a0)
	subiu $t5, $t5, 1
	
	addiu $a0, $a0, 1
	sb $t6, ($a0)
	subiu $t5, $t5, 1
	bnez $t5, loop
	
  	# Open (for writing) a file that does not exist
  	li   $v0, 13       # system call for open file
  	la   $a0, fout     # output file name
 	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
 	li   $a2, 0        # mode is ignored
 	syscall            # open a file (file descriptor returned in $v0)
 	move $s6, $v0      # save the file descriptor 
  
  	# Write header to file
 	li   $v0, 15       # system call for write to file
  	move $a0, $s6      # file descriptor 
  	la   $a1, frameBuffer  # address of buffer from which to write
 	li   $a2, 0xc0036      # hardcoded buffer length
  	syscall            # write to file
   
 	 # Close the file 
 	 li   $v0, 16       # system call for close file
 	 move $a0, $s6      # file descriptor to close
 	 syscall            # close file

		
exit:
	li $v0, 4
	la $a0, file_save_end
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
	
