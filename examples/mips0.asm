#########################################################
#                                                       #
#   	Zamiana ma?ych liter na wielkie                 #
# 	Autor: mgr. in?. S?awomir Niespodziany          #
#                                                       #
#########################################################
	
	.data #sekcja zmiennych globalnych
prompt: .asciiz "Enter string: \n" #tresc promptu
buf: .space 100 #bufor na napis

	.text #sekcja procedur
	.globl main #opublikowanie etykiety main
main:
	li $v0, 4 #ustaw numer wywolania systemowego print string
	la $a0, prompt #wczytaj adres promptu
	syscall #przekaz sterowanie do OS, wykonaj print string
	
	li $v0, 8 #ustaw numer wywolania systemowego read string
	la $a0, buf #ustaw adres bufora na wczytany tekst
	li $a1, 100 #ustaw limit dlugosci bufora
	syscall #przekaz sterowanie do OS, wykonaj read string
	
	#definujemy stale programowe
	li $t0, 'a'
	li $t1, 'z'
	li $t2, 0x20
	
	la $t3, buf #wskazanie adresu bufora 
	lb $t4, ($t3) #wczytaj bajt z bufora, (nawiasy) - dereferencja
	beqz $t4, end #skocz do end jesli zero

loop:
 	blt $t4, $t0, next #sprawdz czy znak jest mniejszy od malego a
 	bgt $t4, $t1, next #sprawdz czy znak jest wiekszy od malego z 
 	#brawo, litera jest mala
 	sub $t4, $t4, $t2 # t4 = t4 - t2
	sb $t4, ($t3) #wstaw wynik w adres z którego pobrales

next:
	addi $t3, $t3, 1 #przejdz o bajt do przodu
	lb $t4, ($t3) #wczytaj bajt
	bnez $t4, loop #jesli nie zero, wróc do loop
 
end:
	li $v0, 4 #ustaw numer wywolania systemowego print string
	la $a0, buf #wczytaj adres wyniku do wypisania
	syscall #przekaz sterowanie do OS, wykonaj print string
	
	li $v0, 10 #ustaw numer wywolania systemowego exit
	syscall #przekaz sterowanie do OS, wykonaj exit
	
	 	
 	
 	
 	
	
