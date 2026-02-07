#L'esercizio chiede di scrivere  un programma in linguaggio assemblativo MIPS/MARS per calcolare il massimo comun divisore (MCD) di due numeri interi positivi. 

.globl main
.data

divisore1: .word 2
divisore2: .word 3
stringa1: .asciiz "Il massimo comune divisore tra i due numeri é:"
stringa2: .asciiz "\n"
stringa3: .asciiz "I due numneri non hanno nessun divisore in comuine"

.text
main:

li $v0,5          #pop up immissione primo intero da tasiera
syscall
move $t0,$v0

li $v0,5          #pop up immissione secondo intero da tasiera
syscall
move $t1,$v0

li $t2, 2147483647   #numero massimo rappresentabile in ca2 

bge $t0,$t1 primomaggioreugualesecondo      #branch a set istruzioni adatto se primo intero maggiore o uguale al secondo altrimenti 
j secondomaggioreprimo                      #salta a set isruzioni adatto al caso in cui secondo intero maggiore del primo


primomaggioreugualesecondo:
sub $t6, $t2, $t1
sub $t2, $t2, $t6
primomaggioreugualesecondo1:
beqz $t2, fine1
rem $t3, $t1, $t2
beqz $t3, divisoresecondo
subi $t2, $t2, 1
j primomaggioreugualesecondo1
divisoresecondo:
rem $t4, $t0, $t2
beqz $t4, fine2
subi $t2, $t2, 1
j primomaggioreugualesecondo1


secondomaggioreprimo:
sub $t6, $t2, $t0
sub $t2, $t2, $t6
secondomaggioreprimo1:
beqz $t2, fine1
rem $t3, $t0, $t2
beqz $t3, divisoreprimo
subi $t2, $t2, 1
j secondomaggioreprimo1
divisoreprimo:
rem $t4, $t1, $t2
beqz $t4, fine2
subi $t2, $t2, 1
j secondomaggioreprimo1

fine1:

la $t0, stringa3
j fine

fine2:

la $t0, stringa1
la $t1, stringa2

li $v0, 4
move $a0,$t0
syscall

li $v0, 4
move $a0,$t1
syscall

li $v0,1
move $a0,$t2
syscall

fine: 

li $v0, 10
syscall
