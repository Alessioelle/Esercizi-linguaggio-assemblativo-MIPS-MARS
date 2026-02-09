#L'esercizio chiede di scrivere un programma in assembly che definsice un vettore di 10 elementi con numeri casuali compresi tra 0 e 999 e calcoli alcuni dati statistici: somma,media,max,min
#Il programma é stato scritto per lavorare solo su interi (no utilizzo coprocessore) quindi il risultato della media potrebbe risultare arrotondato ad un intero.
#Il programma é stato scritto in modo da non utilizzare lo stack

.globl main

.data

stringa: .asciiz "Il vettore generato casualmente é:"
stringa0: .asciiz "["
stringa1: .asciiz ","
stringa2: .asciiz "\t"
stringa3: .asciiz "]"
stringa4: .asciiz "\n"
stringa5: .asciiz "La somma degli elementi del vettore risulta pari a:"
stringa6: .asciiz "La media degli elementi del vettore risulta pari a:"
stringa7: .asciiz "Il massimo tra gli elementi del vettore é:"
stringa8: .asciiz "Il minimo tra gli elementi del vettore é:"
array1: .word 1:10 #inizializzo vettore di lunghezza 10 in memoria dati

.text

main:
li $a1,1000                           #istruzioni generazione 10 valori casuali vettore
li $v0,42                                       
syscall
move $t0,$a0
li $v0,42                            
syscall
move $t1,$a0
li $v0,42                          
syscall
move $t2,$a0
li $v0,42                           
syscall
move $t3,$a0
li $v0,42                          
syscall
move $t4,$a0
li $v0,42                          
syscall
move $t5,$a0
li $v0,42                          
syscall
move $t6,$a0
li $v0,42                           
syscall
move $t7,$a0
li $v0,42                          
syscall
move $t8,$a0
li $v0,42                           
syscall
move $t9,$a0
                                      #carico valori immessi da tastiera all'interno del vettore in memoria
sw $t0,array1   
li $t0,4
sw $t1,array1($t0)
li $t0,8  
sw $t2,array1($t0) 
li $t0,12  
sw $t3,array1($t0)
li $t0,16 
sw $t4,array1($t0) 
li $t0,20 
sw $t5,array1($t0)          
li $t0,24 
sw $t6,array1($t0) 
li $t0,28 
sw $t7,array1($t0)
li $t0,32
sw $t8,array1($t0)
li $t0,36
sw $t9,array1($t0) 

li $v0,4                               #stampa a schermo il vettore generato
la $a0,stringa
syscall
li $v0,4
la $a0,stringa2
syscall
li $v0,4
la $a0,stringa0
syscall
li $v0,1
lw $a0,array1
syscall
li $v0,4
la $a0,stringa1
syscall
li $t0,4 
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa1
syscall
add $t0,$t0,4
li $v0,1
lw $a0,array1($t0)
syscall
li $v0,4
la $a0,stringa3
syscall

li $t0,4                               #inizio funzioni di calcolo
li $t3,36
lw $t1,array1

calcolosomma:                          #calcolo somma elementi vettorre
lw $t2,array1($t0)
add $t1,$t1,$t2
add $t0,$t0,4
ble $t0,$t3,calcolosomma               #metto in $t1 risultato somma elementi vettore

calcolomedia:                          #calcolo media aritmetica elementi vettore
div $t2,$t1,10                         #metto in $t2 risultato media aritmetica elemeni vettore

calcolomassimo:                        #calcolo il massimo tra gli elementi del vettore
li $t0,4                   
li $t3,36
lw $t4,array1
lw $t5,array1($t0)
bge $t4,$t5,primomaggioreugualesecondo
secondomaggioreprimo:
add $t0,$t0,4
bgt $t0,$t3,salvataggiomax
lw $t4,array1($t0)
bge $t4,$t5,primomaggioreugualesecondo
j secondomaggioreprimo
primomaggioreugualesecondo:
add $t0,$t0,4
bgt $t0,$t3,salvataggiomax
lw $t5,array1($t0)
bge $t4,$t5,primomaggioreugualesecondo                                                 
j secondomaggioreprimo                                                      
salvataggiomax:
bge $t4,$t5,calcolominimo
move $t4,$t5                           #a fine ciclo metto in $t4 numero massimo     
                                                                        
calcolominimo:                         #calcolo il minimo tra gli elementi del vettore      
li $t0,4                   
li $t3,36
lw $t5,array1
lw $t6,array1($t0)
ble $t5,$t6,primominoreugualesecondo
secondominoreprimo:
add $t0,$t0,4
bgt $t0,$t3,salvataggiomin
lw $t5,array1($t0)
ble $t5,$t6,primominoreugualesecondo
j secondominoreprimo
primominoreugualesecondo:
add $t0,$t0,4
bgt $t0,$t3,salvataggiomin
lw $t6,array1($t0)
ble $t5,$t6,primominoreugualesecondo                                                 
j secondominoreprimo                                                      
salvataggiomin:
ble $t5,$t6,fine
move $t5,$t6                          #a fine ciclo metto in $t5 numero minimo  
                                                     
fine:                                 #stampa a schermo i risultati statistici richiesti 
li $v0,4
la $a0,stringa4
syscall
li $v0,4
la $a0,stringa5
syscall
li $v0,4
la $a0,stringa2
syscall
li $v0,1
move $a0,$t1
syscall
li $v0,4
la $a0,stringa4
syscall
li $v0,4
la $a0,stringa6
syscall
li $v0,4
la $a0,stringa2
syscall
li $v0,1
move $a0,$t2
syscall                                   
li $v0,4
la $a0,stringa4
syscall
li $v0,4
la $a0,stringa7
syscall
li $v0,4
la $a0,stringa2
syscall
li $v0,1
move $a0,$t4
syscall
li $v0,4
la $a0,stringa4
syscall
li $v0,4
la $a0,stringa8
syscall
li $v0,4
la $a0,stringa2
syscall
li $v0,1
move $a0,$t5
syscall
li $v0,10
syscall                                                                          
                                                                                                                  
                                                                                                                                                        
                                                                                                                                                                                              
 
