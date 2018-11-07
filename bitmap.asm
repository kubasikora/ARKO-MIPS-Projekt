# Important: do not put any other data before the frameBuffer
# Also: the Bitmap Display tool must be connected to MARS and set to
#   display width in pixels: 256
#   display height in pixels: 256
#   base address for display: 0x10010000 (static data)
	.data
frameBuffer: .space 0x136 
fout: .asciiz "/home/sikora/Documents/Dev/Arko/ARKO-MIPS-Projekt/test.bmp"      # filename for output
	.text

la $a0, frameBuffer

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

li $t0, 0x01
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

## offset to raster data, gdzie zaczyna sie tablica pikseli
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
li $t0, 0x10
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

#height - rozmiar w px
li $t0, 0x10
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

#planes - 1 plaszczyzna
li $t0, 0x01
sb $t0, ($a0)
addiu $a0, $a0, 1

li $t0, 0x00
sb $t0, ($a0)
addiu $a0, $a0, 1

#bitcount - 1bit na piksel
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
li $t0, 0x01
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

#colors importance
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

li $t5, 0x100
li $t6, 0x46
loop:
	addiu $a0, $a0, 1
	sb $t6, ($a0)
	subiu $t5, $t5, 1
	bnez $t5, loop
	

  ###############################################################
  # Open (for writing) a file that does not exist
  li   $v0, 13       # system call for open file
  la   $a0, fout     # output file name
  li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  li   $a2, 0        # mode is ignored
  syscall            # open a file (file descriptor returned in $v0)
  move $s6, $v0      # save the file descriptor 
  
  ###############################################################
  
  # Write header to file
  li   $v0, 15       # system call for write to file
  move $a0, $s6      # file descriptor 
  la   $a1, frameBuffer  # address of buffer from which to write
  li   $a2, 0x136      # hardcoded buffer length
  syscall            # write to file
   
    
  ###############################################################
  # Close the file 
  li   $v0, 16       # system call for close file
  move $a0, $s6      # file descriptor to close
  syscall            # close file
  ###############################################################



  li $v0,10
  syscall

