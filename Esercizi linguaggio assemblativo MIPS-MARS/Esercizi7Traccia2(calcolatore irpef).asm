# L'esercizio chiede di scrivere un programma in linguaggio assemblativo MIPS/MARS che, dato in input da tastiera lo stipendio (intero) di un dipendente, ne calcola sia la tassazione 
# sulla base degli scaglioni irpef (<10000 0% / 10001-28000 23% / 28001-50000 28% / >50000 43%) che lo stato applica sulla ral del lavoratore che lo stipendio netto effettivamente percepito.

.globl main

.data

stringa1: .asciiz "Inserisca la sua ral per il calcolo del totale irpef dovuto:"
stringa2: .asciiz "La tassazione del suo stipendio ammonta a:"
stringa3: .asciiz "Quindi il suo guadagno netto sará di:"
stringa4: .asciiz "\n"

.text

main:

la $t0, stringa1     #si chiede di inserire la ral da tastiera
li $v0,4
move $a0,$t0
syscall
li $v0,5             #pop up inserimento ral da tastiera
syscall
move $t0,$v0
li $t1, 10000        #se ral minore o uguale a 10000 euro vai a fine1 altrimenti prosegui 
ble $t0,$t1, fine1   

calcolotassetra10e28:

li $t2, 28000        #calcolo tasse quota ral <=28000 e metto in $t4 irpef dovuta e in $t0 stipendio netto
bgt $t0,$t2, calcolotassetra28e50
sub $t3,$t0,$t1  
div $t4,$t3,100
mul $t4,$t4,23
sub $t0,$t0,$t4
j fine2


calcolotassetra28e50:
li $t5, 50000        #calcolo tasse quota ral <=50000 e metto in $t4 irpef dovuta e in $t0 stipendio netto
bgt $t0,$t5, calcolotasseoltre50
sub $t3,$t0,$t2      #calcolo tasse quota 28000<x<50000 e metto in $t4 irpef calcolata
div $t4,$t3,100
mul $t4,$t4,28
add $t7,$t1,$t3      #calcolo tasse quota 10000<x<28000 e metto in $t4 irpef calcolata e in $t0 stipendio netto
sub $t7,$t0,$t7
div $t6,$t7,100
mul $t6,$t6,23
add $t4,$t4,$t6
sub $t0,$t0,$t4
j fine2


calcolotasseoltre50: 
sub $t3,$t0,$t5      #calcolo tasse quota ral >50000 e metto in $t4 irpef dovuta e in $t0 stipendio netto
div $t4,$t3,100
mul $t4,$t4,43
add $t7,$t2,$t3      #calcolo tasse quota 28000<x<50000 e metto in $t5 irpef calcolata
sub $t7,$t0,$t7
div $t5,$t7,100
mul $t5,$t5,28       
add $t7,$t7,$t3      #calcolo tasse quota 10000<x<28000 e metto in $t6 irpef calcolata e in $t0 stipendio netto
add $t7,$t1,$t7
sub $t7,$t0,$t7
div $t6,$t7,100
mul $t6,$t6,23
add $t4,$t4,$t5
add $t4,$t4,$t6      #calcolo irpef totale e metto in $t4
sub $t0,$t0,$t4      #calcolo stipendio netto e metto in $t0


fine2:

la $t2, stringa2     #il programma comunicherá l'entitá delle tasse dovute e lo stipendio netto con una ral >10000 euro
li $v0,4
move $a0,$t2
syscall
la $t2, stringa4
li $v0,4
move $a0,$t2
syscall
li $v0,1
move $a0,$t4
syscall
li $v0,4
move $a0,$t2
syscall
la $t2, stringa3
li $v0,4
move $a0,$t2
syscall
la $t2, stringa4
li $v0,4
move $a0,$t2
syscall
li $v0,1
move $a0,$t0
syscall
li $v0,10
syscall


fine1:
li $t1,0             #irpef dovuta con ral < 10000 euro
la $t2, stringa2     #il programma comunicherá l'entitá delle tasse dovute e lo stipendio netto con una ral <= 10000 euro
li $v0,4
move $a0,$t2
syscall
la $t2, stringa4
li $v0,4
move $a0,$t2
syscall
li $v0,1
move $a0,$t1
syscall
li $v0,4
move $a0,$t2
syscall
la $t2, stringa3
li $v0,4
move $a0,$t2
syscall
la $t2, stringa4
li $v0,4
move $a0,$t2
syscall
li $v0,1
move $a0,$t0
syscall
li $v0,10
syscall
