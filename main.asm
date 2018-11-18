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
x_vect: .space 8192
y_vect: .space 8192

# file
frameBuffer: .space 0x30036  	
fout: .asciiz "arko_mips_project.bmp"      # filename for output
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
			
file_creation:
	li $v0, 4
	la $a0, file_save_start
	syscall
	
	la $a0, frameBuffer

create_main_header:
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

create_bitmapinfoheader:
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

	li $t0, 0x01
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

	li $t0, 0x01
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
	li $t0, 24
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

	li $t0, 0x01
	sb $t0, ($a0)
	addiu $a0, $a0, 1

	li $t0, 0x00
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
	
background_color:
	li $t5, 0x30000 #counter
	li $t6, 0xf4 #R
	li $t7, 0xa1 #G
	li $t8, 0xe2 #B
	
background_loop: #write 3 bytes for one pixel -- bgr
	
	addiu $a0, $a0, 1 #b
	sb $t8, ($a0) 
	subiu $t5, $t5, 1
	
	addiu $a0, $a0, 1 #g
	sb $t7, ($a0)
	subiu $t5, $t5, 1
	
	addiu $a0, $a0, 1 #r
	sb $t6, ($a0)
	subiu $t5, $t5, 1
	
	bnez $t5, background_loop
	
			
draw_bezier_vectors: #executes (1-t)^3 * x0 + 3*((1-t)^2)*t*x1 + 3*(1-t)*x2*(t^2) + (t^3)*x3	
	li $t0, 1 #max
	li $t1, 1 #t
	sll $t0, $t0, 10
	sll $t1, $t1, 10

bezier_loop:
	la $a2,  frameBuffer
	addiu $a2, $a2, 54
	
x_vect_evaluate:
	subiu $t1, $t1, 1
	move $t2, $s0 #x1 
	sll $t2, $t2, 10
 	move $t3, $s2 #x2
	sll $t3, $t3, 10
	move $t4, $s4 #x3
	sll $t4, $t4, 10	
	li $s7, 3
	sll $s7, $s7, 10	
	
	subu $t6, $t0, $t1 # t-1 
	
	# razy t-1
	multu $t6, $t6 #kwadrat staloprzecinkowy
	mflo $t6
	srl $t6, $t6, 10 #10 bitow mniej bo stalo X stalo
	
	# razy t
	multu $t6, $t1 #mnozenie staloprzecinkowe
	mflo $t6
	srl $t6, $t6, 10 #13 bitow mniej bo stalo X stalo
	
	# razy x1
	multu $t6, $t2 #mnozenie staloprzecinkowe
	mflo $t6
	srl $t6, $t6, 10 #13  bit mniej bo doprowadzamy do 
	
	# razy 3
	multu $t6, $s7
	mflo $t6
	srl $t6, $t6, 10
	
	# dodaj do x(t)
	move $t8, $t6

	# t-1 
	subu $t6, $t0, $t1 # t-1 
	
	# razy t
	multu $t6, $t1
	mflo $t6
	srl $t6, $t6, 10
	
	# razy t
	multu $t6, $t1
	mflo $t6
	srl $t6, $t6, 10
	
	# razy x2
	multu $t6, $t3
	mflo $t6
	srl $t6, $t6, 10
	#
	# razy 3
	multu $t6, $s7
	mflo $t6
	srl $t6, $t6, 10
	
	# dodaj do x(t)
	addu $t8, $t8, $t6

	# t
	# razy x3
	multu $t4, $t1
	mflo $t4
	mfhi $t9
	bnez $t9, alarm
	srl $t4, $t4, 10
	
	# razy t
	multu $t4, $t1
	mflo $t4
	mfhi $t9
	bnez $t9, alarm
	srl $t4, $t4, 10
	
	# razy t
	multu $t4, $t1
	mflo $t4
	mfhi $t9
	bnez $t9, alarm
	srl $t4, $t4, 10
	
	# dodaj do x(t)
	addu $t8, $t4, $t8
	
	# normalizacja x(t)
	srl $t8, $t8, 10
	
	li $a3, 3
	multu $t8, $a3
	mflo $t8
	move $a3, $t8
	
y_vect_evaluate:	
	move $t2, $s1 #y1
	sll $t2, $t2, 10
	move $t3, $s3 #y2
	sll $t3, $t3, 10
	move $t4, $s5 #y3
	sll $t4, $t4, 10	
	li $s7, 3
	sll $s7, $s7, 10	
		
	subu $t6, $t0, $t1 # t-1 
	
	# razy t-1
	multu $t6, $t6 #kwadrat staloprzecinkowy
	mflo $t6
	srl $t6, $t6, 10 #10 bitow mniej bo stalo X stalo
	
	# razy t
	multu $t6, $t1 #mnozenie staloprzecinkowe
	mflo $t6
	srl $t6, $t6, 10 #13 bitow mniej bo stalo X stalo
	
	# razy y1
	multu $t6, $t2 #mnozenie staloprzecinkowe
	mflo $t6
	srl $t6, $t6, 10 #13  bit mniej bo doprowadzamy do 
	
	# razy 3
	multu $t6, $s7
	mflo $t6
	srl $t6, $t6, 10
	
	# dodaj do y(t)
	move $t8, $t6


	# t-1 
	subu $t6, $t0, $t1 # t-1 
	
	# razy t
	multu $t6, $t1
	mflo $t6
	srl $t6, $t6, 10
	
	# razy t
	multu $t6, $t1
	mflo $t6
	srl $t6, $t6, 10
	
	# razy y2
	multu $t6, $t3
	mflo $t6
	srl $t6, $t6, 10
	#
	# razy 3
	multu $t6, $s7
	mflo $t6
	srl $t6, $t6, 10
	
	# dodaj do y(t)
	addu $t8, $t8, $t6
	
	
	# t
	# razy x3
	multu $t4, $t1
	mflo $t4
	mfhi $t9
	bnez $t9, alarm
	srl $t4, $t4, 10
	
	# razy t
	multu $t4, $t1
	mflo $t4
	mfhi $t9
	bnez $t9, alarm
	srl $t4, $t4, 10
	
	# razy t
	multu $t4, $t1
	mflo $t4
	mfhi $t9
	bnez $t9, alarm
	srl $t4, $t4, 10
	
	# dodaj do y(t)
	addu $t8, $t4, $t8
	
	# normalizacja y(t)
	srl $t8, $t8, 10	
	
draw_bezier_pixel:	
	#w a3 x
	#w t8 y
	li $t9, 0x300
	multu $t8, $t9
	mflo $t8
	addu $t8, $a3, $t8
	
	#w a2 pierwszy pixel
	addu $a0, $a2, $t8
	
	li $t2, 0xff 


	sb $t2, ($a0) 
	subiu $t5, $t5, 1
	
	addiu $a0, $a0, 1 #g
	sb $t2, ($a0)
	subiu $t5, $t5, 1
	
	addiu $a0, $a0, 1 #r
	sb $t2, ($a0)
	subiu $t5, $t5, 1

	
draw_pixel:	
	addiu $t5, $t5, 4
	bnez $t1, bezier_loop
	
	
			
	# Open (for writing) a file that does not exist
  	li   $v0, 13       # system call for open file
  	la   $a0, fout     # output file name
 	li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
 	li   $a2, 0        # mode is ignored
 	syscall            # open a file (file descriptor returned in $v0)
 	move $s6, $v0      # save the file descriptor 
  
  	# Write buffer to file
 	li   $v0, 15       # system call for write to file
  	move $a0, $s6      # file descriptor 
  	la   $a1, frameBuffer  # address of buffer from which to write
 	li   $a2, 0x30036      # hardcoded buffer length
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
alarm:
	li $v0, 4
	la $a0, invalid_arg_error
	syscall
	
	li $v0, 17
	li $a0, -1
	syscall
	
